Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E662C3DA61
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 04:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0198895A;
	Tue, 30 Jul 2024 06:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CxcblTC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0818895E; Tue, 30 Jul 2024 06:27:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732768894F
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 06:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U4RVxv042212;
 Mon, 29 Jul 2024 23:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1722313651;
 bh=UspVCyGleowix+VisUBZLdm36GzGy1RcKGqKL3/sfhw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CxcblTC97GudOsVEyNRM1MkXKHjhTRK9ucqJc0uY73LwIf+UtN+MflANkfWKpoEjQ
 W9mvFm28lTDWXkiUdxT2f0cHSAFBn0PJWA8Q7c+ekjj1Z95QuLOWxTTe/pBcCKCAi6
 5bWIbX0LaF8E7OSbJdmV7/oR16VUsZgEcKzE+q1E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U4RVoe007478
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jul 2024 23:27:31 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 23:27:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 23:27:30 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36]
 (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U4RR8b029750;
 Mon, 29 Jul 2024 23:27:28 -0500
Message-ID: <9f819144-4d64-40e2-afbc-1dc1983f6444@ti.com>
Date: Tue, 30 Jul 2024 09:57:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] binman: Tidy up bintool docs
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>, Stefan Herbrechtsmeier
 <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini <trini@konsulko.com>
References: <20240720104950.2730773-1-sjg@chromium.org>
 <20240720104950.2730773-4-sjg@chromium.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240720104950.2730773-4-sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 20/07/24 16:19, Simon Glass wrote:
> The docs have somehow got out of sync. Regenerate the file to fix the
> problem.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   tools/binman/bintools.rst | 61 ++++++++++++++++++++++++---------------
>   1 file changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/binman/bintools.rst b/tools/binman/bintools.rst
> index 1336f4d0115..fa44d9c6872 100644
> --- a/tools/binman/bintools.rst
> +++ b/tools/binman/bintools.rst
> @@ -10,6 +10,15 @@ binaries. It is fairly easy to create new bintools. Just add a new file to the
>   
>   
>   
> +Bintool: bootgen: Generate bootable fsbl image for zynq/zynqmp
> +--------------------------------------------------------------
> +
> +This bintools supports running Xilinx "bootgen" in order
> +to generate a bootable, authenticated image form an SPL.
> +
> +
> +
> +
>   Bintool: bzip2: Compression/decompression using the bzip2 algorithm
>   -------------------------------------------------------------------
>   
> @@ -37,6 +46,25 @@ Documentation about CBFS is at https://www.coreboot.org/CBFS
>   
>   
>   
> +Bintool: cst: Image generation for U-Boot
> +-----------------------------------------
> +
> +This bintool supports running `cst` with some basic parameters as
> +needed by binman.
> +
> +
> +
> +Bintool: fdt_add_pubkey: Add public key to control dtb (spl or u-boot proper)
> +-----------------------------------------------------------------------------
> +
> +This bintool supports running `fdt_add_pubkey`.
> +
> +Normally mkimage adds signature information to the control dtb. However
> +binman images are built independent from each other. Thus it is required
> +to add the public key separately from mkimage.
> +
> +
> +
>   Bintool: fiptool: Image generation for ARM Trusted Firmware
>   -----------------------------------------------------------
>   
> @@ -143,11 +171,20 @@ Documentation is available via::
>   
>   
>   
> +Bintool: mkeficapsule: Handles the 'mkeficapsule' tool
> +------------------------------------------------------
> +
> +This bintool is used for generating the EFI capsules. The
> +capsule generation parameters can either be specified through
> +commandline, or through a config file.
> +
> +
> +
>   Bintool: mkimage: Image generation for U-Boot
>   ---------------------------------------------
>   
>   This bintool supports running `mkimage` with some basic parameters as
> -neeed by binman.
> +needed by binman.
>   
>   Normally binman uses the mkimage built by U-Boot. But when run outside the
>   U-Boot build system, binman can use the version installed in your system.
> @@ -194,25 +231,3 @@ Documentation is available via::
>   
>   
>   
> -Bintool: fdt_add_pubkey: Add public key to device tree
> -------------------------------------------------------
> -
> -This bintool supports running `fdt_add_pubkey` in order to add a public
> -key coming from a certificate to a device-tree.
> -
> -Normally signing is done using `mkimage` in context of `binman sign`. However,
> -in this process the public key is not added to the stage before u-boot proper.
> -Using `fdt_add_pubkey` the key can be injected to the SPL independent of
> -`mkimage`
> -
> -
> -
> -Bintool: bootgen: Sign ZynqMP FSBL image
> -----------------------------------------
> -
> -This bintool supports running `bootgen` in order to sign a SPL for ZynqMP
> -devices.
> -
> -The bintool automatically creates an appropriate input image file (.bif) for
> -bootgen based on the passed arguments. The output is a bootable,
> -authenticated `boot.bin` file.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
