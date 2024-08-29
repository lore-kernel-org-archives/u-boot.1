Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97BEC83F0F
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 12:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A91488BDA;
	Thu, 29 Aug 2024 14:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vPAbdfop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961CA88B86; Thu, 29 Aug 2024 14:21:38 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E07788B8F
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 14:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TCLWvH042569;
 Thu, 29 Aug 2024 07:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724934092;
 bh=8mKqhL9Y/bpsMroyUPlYm/QXYV8K6ID4d1Xg0M+mAPU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vPAbdfopbGQxKFRqR6wwiHoBa9eg6L66BJAcDWXptY66eHYUOlvjhdBAx4ZvIWm23
 BWl2ovvRrcSGm1IOYg/vMK7ScIzed9kQDVrKjmFsD4F4u9e8mUpNA9weEjZCLgybRu
 pTa6DV7xEU5QSFC1Lt7iQ421d2yNkVFDAqrFdEOs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TCLWOu127905
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Aug 2024 07:21:32 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 07:21:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 07:21:32 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TCLW1Y042786;
 Thu, 29 Aug 2024 07:21:32 -0500
Date: Thu, 29 Aug 2024 07:21:32 -0500
From: Bryan Brattlof <bb@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <nm@ti.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>, Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH] ram: k3-ddrss: Handle error properly in lpddr4_start
Message-ID: <20240829122132.zhjva3dbcz346dbo@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240829083453.647044-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240829083453.647044-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On August 29, 2024 thus sayeth Udit Kumar:
> In lpddr4_start function error returned by lpddr4_enablepiinitiator
> may go undetected due to overwrite of return code.
> Add support to handle error in above case.
> 
> Reported-by: Andreas Dannenberg <dannenberg@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

One day I'll get around to cleaning this up. starting the controllers 
isn't all this complicated.  

~Bryan
