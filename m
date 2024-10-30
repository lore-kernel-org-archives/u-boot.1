Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22835D6B6DA
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8205089216;
	Wed, 30 Oct 2024 22:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PLBbyjmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E3AF8924D; Wed, 30 Oct 2024 22:54:06 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C39688F47
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:54:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ULs0eA015796;
 Wed, 30 Oct 2024 16:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730325240;
 bh=d3lJMf9BvWbRK8Z3gYryGT5fYJGEO7wlGUyai6OIrwY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PLBbyjmPetJgixvHeAcUIupaD5Qv6o+829x2Oi3gTdQ+56x5TkQgZCzxo0zLowIuZ
 hIxSPMGijv+YIKI5TyssjCpaF7hzUBpnuXpR2cfQu4NU9R37HFGXFx1+IkTAsn9KLs
 Lh1dkXpU+5fQGg+EQoHMxsovQQJnV2PmNx3gyKmQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49ULs0UM098434
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Oct 2024 16:54:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Oct 2024 16:54:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Oct 2024 16:54:00 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ULs021052500;
 Wed, 30 Oct 2024 16:54:00 -0500
Date: Wed, 30 Oct 2024 16:54:00 -0500
From: Bryan Brattlof <bb@ti.com>
To: Garrett Giordano <ggiordano@phytec.com>
CC: <trini@konsulko.com>, <afd@ti.com>, <w.egorov@phytec.de>,
 <vaishnav.a@ti.com>, <hnagalla@ti.com>, <j-choudhary@ti.com>,
 <a-nandan@ti.com>, <nm@ti.com>, <sjg@chromium.org>, <a-bhatia1@ti.com>,
 <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm: mach-k3: am62a7: Provide a way to obtain boot
 device for non SPLs
Message-ID: <20241030215400.3pf3d4tv36p6krdm@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20241030204023.2421381-1-ggiordano@phytec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20241030204023.2421381-1-ggiordano@phytec.com>
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

Hi Garrett!

On October 30, 2024 thus sayeth Garrett Giordano:
> Introduce get_boot_device() to obtain the booting device. Make it also
> available for non SPL builds so u-boot can also know the device it
> is booting from.
> 

All looks good but I'm trying to understand the scenario. Are we using a 
bare-metal boot loader in tiboot3 then packaging U-Boot proper with TF-A 
and OP-TEE in next phase after DRAM is up?

> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> ---
>  arch/arm/mach-k3/Makefile             |   1 +
>  arch/arm/mach-k3/am62ax/Makefile      |   1 +
>  arch/arm/mach-k3/am62ax/am62a7_init.c |  97 +----------------------
>  arch/arm/mach-k3/am62ax/boot.c        | 106 ++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+), 96 deletions(-)
>  create mode 100644 arch/arm/mach-k3/am62ax/boot.c
> 
> diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
> index 8c4f6786a5b..ce09a30e58f 100644
> --- a/arch/arm/mach-k3/Makefile
> +++ b/arch/arm/mach-k3/Makefile
> @@ -10,6 +10,7 @@ obj-y += common.o security.o
>  obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>  obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>  obj-$(CONFIG_SOC_K3_AM625) += am62x/
> +obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/

Yeah I don't know how we treat 'x' here when alphabetizing things. Do we 
treat it like a literal 'x' or is that just a regex alias for .+ IDK.

Anywho, it looks like we created a second entry accidentally. But the 
substance of the patch is sound.

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
