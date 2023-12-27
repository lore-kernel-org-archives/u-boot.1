Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E123C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 13:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53D887732;
	Wed, 27 Dec 2023 14:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vh7ofXRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8ED48798A; Wed, 27 Dec 2023 14:34:30 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 997E0876FF
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 14:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BRDYPWJ057778;
 Wed, 27 Dec 2023 07:34:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703684065;
 bh=+5NR04Bb5JAr0iP0pZDP5jk0yI+MvHxXEezeE5rsTuE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vh7ofXRbdVl89EvmryKgJhkiZ+ClIZoPJZTnECtQ1nwnL6xT8/eyH3CMddFZllQFK
 9mW7HXrIkz96an79l485GWF0vbaBn1fNm/TQLtEkAu57LPICbmpxpDrn6BoLpfDhsP
 Qs9vDEOiKWhkqvtqDSqG4BT3p/u47OtmC83O1z/Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BRDYPli048197
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Dec 2023 07:34:25 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Dec 2023 07:34:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Dec 2023 07:34:25 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BRDYPDM091334;
 Wed, 27 Dec 2023 07:34:25 -0600
Date: Wed, 27 Dec 2023 07:34:25 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, <n-francis@ti.com>
CC: <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] include: env: ti: default_findfdt: Follow the
 bootstd/distro conventions
Message-ID: <20231227133425.27x7uqogtptrgkjh@diagnoses>
References: <20231227130837.2624211-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231227130837.2624211-1-nm@ti.com>
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

On 07:08-20231227, Nishanth Menon wrote:
> Distroboot and bootstd both mandate a findfdt variable pointing to the
> correct device tree blob. Current mechanism calls a find_fdt function
> to set this variable. We do not need a find_fdt command to set the
> environment variable to a single dtb. Simplify the default_findfdt to
> remove variable expansion while at it.
> 
> For legacy scripts depending on a TI convention of name_fdt, provide a
> find_fdt wrapper that behaves like before.
> 
> NOTE: As part of this change, we also drop the cooked up
> default_device_tree_arch default_device_tree_subarch variables.
> 
> Reported-by: Jonathan Humphreys <j-humphreys@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  include/env/ti/default_findfdt.env | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
> index a2b51dd923bb..1a1ab8406c9e 100644
> --- a/include/env/ti/default_findfdt.env
> +++ b/include/env/ti/default_findfdt.env
> @@ -1,12 +1,7 @@
> -default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
> -default_device_tree_arch=ti
>  #ifdef CONFIG_ARM64
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> +fdtfile=ti/CONFIG_DEFAULT_DEVICE_TREE.dtb;
>  #else
> -default_device_tree_subarch=omap
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> +fdtfile=ti/omap/CONFIG_DEFAULT_DEVICE_TREE.dtb;
>  #endif
> +
> +findfdt=setenv name_fdt ${fdt_file}
> -- 
> 2.43.0
> 


This should have been RFC
Generates quotes


fdtfile=ti/"k3-am62a7-sk".dtb;

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
