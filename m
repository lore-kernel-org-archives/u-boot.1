Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6C9CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 14:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD261830B4;
	Wed, 10 Sep 2025 16:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oRCWiVpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 217BF8318E; Wed, 10 Sep 2025 16:47:18 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 883E7830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 16:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58AElDkU079820;
 Wed, 10 Sep 2025 09:47:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757515633;
 bh=OZkw/jM0WYXjcz7zh2DEn5pDlaFwmu6F6sSX3qOqofA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oRCWiVpu28CgPrafLsnHSxvEPcFOYFEdDEam/GII7IThkQO/uy8nIyPXBDfPvRFnV
 0S+lLkoKRqrg5EpawND8F7h1pzbAHpt5ZD9b1R1mUhuGilW4FG4vcPFYFj3Pu5zDd0
 ppAlNKBz5bwJOoSRZEVzY1fMSDsHvPItkjKIu22Y=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58AElDpc1224651
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 09:47:13 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 09:47:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 09:47:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58AElCvI637912;
 Wed, 10 Sep 2025 09:47:12 -0500
Date: Wed, 10 Sep 2025 09:47:12 -0500
From: Bryan Brattlof <bb@ti.com>
To: Steffen Kothe <steffen.kothe@skothe.net>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>
Subject: Re: [PATCH 0/2] arm: mach-k3: am64x: Add reset cause for cpuinfo
Message-ID: <20250910144712.wx3dfwwq54xcnk44@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250831151706.404373-1-steffen.kothe@skothe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250831151706.404373-1-steffen.kothe@skothe.net>
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

On August 31, 2025 thus sayeth Steffen Kothe:
> Hi together,
> 
> AM64X hereby receives support for reset reason printing during boot.
> 
> Unfortunately does the AM64X register mapping slighlty differ from
> the AM62X. WDT and PORZ are not part of the reset source register, but
> the mapping remains the same for all other causes.
> 
> To prevent ifdef/else constructs, I decided to follow a simple
> copy/paste approach and adjusted the logic accordingly.
> 
> Cheers,
>   Steffen Kothe
> 
> Steffen Kothe (2):
>   arm: mach-k3: am64_hardware.h: Add CTRLMMR_MCU_RST_SRC reset cause bit
>     mappings
>   arm: mach-k3: am64x: Implement get_reset_reason()
> 
>  arch/arm/mach-k3/am64x/boot.c                 | 36 +++++++++++++++++++
>  arch/arm/mach-k3/include/mach/am64_hardware.h | 20 +++++++++++
>  2 files changed, 56 insertions(+)

Works for me! Thanks for patching this up

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
