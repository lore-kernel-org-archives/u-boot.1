Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD8C77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 19:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB2081FEE;
	Mon, 23 Jun 2025 21:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JpvKM8U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0128210D; Mon, 23 Jun 2025 21:28:36 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89C38006D
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 21:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55NJSVr31653672;
 Mon, 23 Jun 2025 14:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750706911;
 bh=mvKrbIOh503suzTv1diIZ8YMjLDlrnp4aCryZZAYJjQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JpvKM8U70ZZa57WE+smGE984wui63XpNA+Hu5YJgLWhNYpO8u0hutbW/J5VgYpJOv
 Sl3iffQor5zcSq3VzFFVktF2ffYKvWZd1wuZ0k9b2iAu/XRkvcSTuT8IiSL9I2DyN0
 n5AhsGleQspx2HK8AN3/VLQE8SjueNe+oRSRKkyA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55NJSVae3519631
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 23 Jun 2025 14:28:31 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 23
 Jun 2025 14:28:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 23 Jun 2025 14:28:30 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55NJSUCh477223;
 Mon, 23 Jun 2025 14:28:30 -0500
Date: Mon, 23 Jun 2025 14:28:30 -0500
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>
Subject: Re: [PATCH] mach-k3: am62ax: am62a7_init: Drop write to non existent
 register
Message-ID: <20250623192830.w3r42iwlewgg74bg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250620132154.1982902-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250620132154.1982902-1-vigneshr@ti.com>
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

On June 20, 2025 thus sayeth Vignesh Raghavendra:
> Per section 14.2.1.3 Kick Protection Registers of AM62A TRM[1],
> there is no partition 5. Delete it.
> 
> [1] https://www.ti.com/lit/pdf/spruj16
> 
> Fixes: b511b371ad76 ("arm: mach-k3: introduce basic files to support the am62a")
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  arch/arm/mach-k3/am62ax/am62a7_init.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Oops good catch

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
