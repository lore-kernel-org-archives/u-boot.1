Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185E8CEDDA3
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 15:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94EB488E84;
	Wed,  9 Oct 2024 17:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qmNFjG+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C80188EDD; Wed,  9 Oct 2024 17:01:27 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF2D88DC1
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 17:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499F1L2B070945;
 Wed, 9 Oct 2024 10:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728486081;
 bh=VIHj0THKvqbmeXECEGzuBuQBJUn9+FI+ReUPyH5kPlA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qmNFjG+pKJWmsFvsu0+Ksx96UUkQRYmN6CMjpYNs80WB0AubsnZg3++QFk1ix81Ii
 Kn/Q4ARQybw98yYW2yoYjnPfjp/waua1uGQhjWq+nVfh1VLhsuhkCo2cQ781M2odnn
 zGL+9pb6iP0YCYLCAXYyHvQnx0XByqV0lVJ4yZ5A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 499F1LCG070726
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 9 Oct 2024 10:01:21 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 10:01:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 10:01:21 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499F1LuK014888;
 Wed, 9 Oct 2024 10:01:21 -0500
Date: Wed, 9 Oct 2024 10:01:21 -0500
From: Bryan Brattlof <bb@ti.com>
To: Jayesh Choudhary <j-choudhary@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <kamlesh@ti.com>, <j-humphreys@ti.com>, <d-gole@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts: k3-j722s-binman: Add support for HS-SE
Message-ID: <20241009150121.doeima6fs5rvyrlc@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241009110447.296776-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241009110447.296776-1-j-choudhary@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On October  9, 2024 thus sayeth Jayesh Choudhary:
> From: Udit Kumar <u-kumar1@ti.com>
> 
> J722S SOC have two variants as HS-FS and HS-SE.
> Add binman support for HS-SE variant.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> [j-choudhary@ti.com: Fix load-dm-data entry and indentation]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Looks good!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
