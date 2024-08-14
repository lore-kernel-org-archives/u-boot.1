Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABC5C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 13:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F97889BD;
	Wed, 14 Aug 2024 15:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="jO3zfetC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD50889D1; Wed, 14 Aug 2024 15:05:25 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 234D0889A1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 15:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: dc826064-5a3d-11ef-82de-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id dc826064-5a3d-11ef-82de-005056999439;
 Wed, 14 Aug 2024 15:05:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=mU9iHeRO+8lnJ3paMQQanJttG1REt6IpkrippVLa9U4=;
 b=jO3zfetCUfQ/9nOTn+Z4n9Z82nPF7foXJAcfzY5nXMaEqS4KNpM9V0uWVYECljMrXBhtlRKEL1Ewy
 XRE+F8osCpclpLStUM7p7EbhemfJ2EtQql/7GIXxcHp56MZN3WZAmyzeXpcgz6QZl85wEbsWaKkTqx
 j+PrdCsNh0WaY4SIPT2x6J7asN7U62aCXARugRWSnMUJNBFBvg2Ianuk9lJEmtCYFEJbs3T22T7tR6
 CPxBKP6nUbMBY+PEWOUxwYIvLYv3Dfc4/c7M+7mhDoBy/ffFeggJQdUOp2UMMh+O61sl4CBjSI62dO
 XxpNxlwrThYA+6D00tgaqk76GqpahKw==
X-KPN-MID: 33|uHHZHJkRlYut3GvjJ39u5dZKG5yjRaO1w7Hm2hUGDXx5E0ktREqIcluBnMPFhJE
 13P8FJDgYj5n8XgqIK3gswOy4EXCADO2DEAN3iTYRavs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pGYB4EiM/rBgYSagJuiSBJe9JaH61zsY8JK7NeMMtQLP1DZ5V0ZbkLP98re5/hh
 NwK3Q97Rgzagzb4kD9R4TMg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id dd1cbd9a-5a3d-11ef-8721-00505699d6e5;
 Wed, 14 Aug 2024 15:05:22 +0200 (CEST)
Date: Wed, 14 Aug 2024 15:05:22 +0200
Message-Id: <87le0z9rvx.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 sjg@chromium.org, u-boot@lists.denx.de, heinrich.schuchardt@canonical.com
In-Reply-To: <20240814123344.196991-1-heinrich.schuchardt@canonical.com>
 (message from Heinrich Schuchardt on Wed, 14 Aug 2024 14:33:44 +0200)
Subject: Re: [PATCH] tools/mkeficapsule: correct printf codes
References: <20240814123344.196991-1-heinrich.schuchardt@canonical.com>
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Date: Wed, 14 Aug 2024 14:33:44 +0200
> 
> uint64_t is defined as unsigned long long on 32-bit ARM.
> Use PRIX64 for printing uint64_t.
> 
> This avoid a build failure on 32-bit systems:
> 
>     tools/mkeficapsule.c: In function 'dump_capsule_auth_header':
>     tools/mkeficapsule.c:694:66: warning: format '%lX' expects argument of
>     type 'long unsigned int', but argument 2 has type 'uint64_t'
>     {aka 'long long unsigned int'} [-Wformat=]
>     694 | printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
>         |                                                      ~~~~^
>         |                                                          |
>         |                                                          long unsigned int
>         |                                                      %08llX
> 

FWIW, on OpenBSD uint64_t is always "unsigned long long" even on
64-bit architectures.  So this should get rid of some warnings for us
as well.

Personally I prefer the casting approach of v1 over PRIX64, but the
latter is probably slightly more portable.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	use PRIX64 to print uint64_t
> ---
>  tools/mkeficapsule.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index f28008a0829..1b53151d41a 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <getopt.h>
> +#include <inttypes.h>
>  #include <pe.h>
>  #include <stdbool.h>
>  #include <stdint.h>
> @@ -691,7 +692,7 @@ static uint32_t dump_fmp_payload_header(
>  static void dump_capsule_auth_header(
>  	struct efi_firmware_image_authentication *capsule_auth_hdr)
>  {
> -	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08lX\n",
> +	printf("EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT\t\t: %08" PRIX64 "\n",
>  	       capsule_auth_hdr->monotonic_count);
>  	printf("EFI_FIRMWARE_IMAGE_AUTH.AUTH_INFO.HDR.dwLENGTH\t: %08X\n",
>  	       capsule_auth_hdr->auth_info.hdr.dwLength);
> @@ -724,9 +725,9 @@ static void dump_fmp_capsule_image_header(
>  	       image_hdr->update_image_size);
>  	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_VENDOR_CODE_SIZE\t: %08X\n",
>  	       image_hdr->update_vendor_code_size);
> -	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08lX\n",
> +	printf("FMP_CAPSULE_IMAGE_HDR.UPDATE_HARDWARE_INSTANCE\t: %08" PRIX64 "\n",
>  	       image_hdr->update_hardware_instance);
> -	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08lX\n",
> +	printf("FMP_CAPSULE_IMAGE_HDR.IMAGE_CAPSULE_SUPPORT\t: %08" PRIX64 "\n",
>  	       image_hdr->image_capsule_support);
>  
>  	printf("--------\n");
> -- 
> 2.45.2
> 
> 
