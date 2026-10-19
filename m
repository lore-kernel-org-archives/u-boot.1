Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364E606A31B
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LNpoAFpp;
	dkim=pass (1024-bit key, unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=lYidmgqH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F321660643;
	Mon, 19 Oct 2026 16:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XORbSnXAH2eV; Mon, 19 Oct 2026 16:57:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 943EC6068B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429078;
	b=Z1nAbKFGEPGkc7Dw4B95Gnxwdk2Ozc2cadtyXIe/lmF3YXekxSOpQxXzNqe3fQz8c7p8
	 xp6Nun+YTe6tNMsY/kxaZ3ou9mwtoLd9zi6wyTP1Lb75NGpbpjAqRELTQwFcarZAtI6N9
	 Yzj/8UVtJbomD3o1uD2rH2ccYo8sM43yypRht0u4CR2oQBbFNgKvzuxp8frt962mfQVq1
	 mKgW4Y+WAkXFv1udFW/DoA212KRACZwiP/8ewPp7ED15LDm9T3I6J5E2SkL9vzgEFxdlY
	 eg3Zd0nCU9p5hc055CkJAZyTTWZR9jY1FXWRYYT/6RVAf+OnlTv0Q1udzVBP5I+LfCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792429078;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Gd8SfTQZTdCSj95YQY5TKjv/9yQft6rcMY8HlIgW+bA=;
	b=n1pBTSCSCJWR+BmPcVXZNq7i9qKLDGwJ6aVCxicerwqM6CxQoOA0xNeeMM4WMy+EEuBJ
	 0CuxwzIf+8LQYHOkHGdQQkDOhJXdl97JawWaDS/+/p1S4CQvcipxVUtsWHN7fx5uglUU2
	 9S7FPIZDUlUrDu1GthplbIONLsRiXBFP1chEatyAEx7DBXfNIvKdcFxursWJBU+kYDjy7
	 jOCBx4jBt5+ASqXvIIXFMjjpVq2sHV9ySlI+XHl1xAfkuLj3yW57ViJaw+T2FJu1ZsQpZ
	 +TIbJXu9n00kR3U3tc2hF3L9HjhjoN3OmGi+/+QpWU/IEuoRuGK+QleV74hi2hwtU2g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792429078;
	bh=Gd8SfTQZTdCSj95YQY5TKjv/9yQft6rcMY8HlIgW+bA=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LNpoAFppFaPsP+yk/JEVq2aM0Jhf+cRcHEafmWwnoE2Malb7V2ldkpOPtf9UDX2ae
	 9pmhyASOBotIwfYyKQWLU52GoS9qeGKJcrZm403YqeUws92gLJQcx3gUUSBz7nE6GD
	 xkJiJF3OmIj7l+f1SEDVusMZnTBETVilI54EWiFpvtkbrTOTikcUG1YFnCxMiqIbvZ
	 c35VJAOdxUX92JPo1TvIdNIByNVtbJVryG5pRgPmnPbpzQZ0RNc83b1qk2k6o+b1gt
	 hWSyaptx4dm3QU3UGr7CoLmVg0R2sDS04TSMcYTDNM/4T6V/DoE/xn4OkmD035bUjM
	 3vWJnrRzXeByQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 943EC6068B;
	Mon, 19 Oct 2026 16:57:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C10631E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAEFE40669
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0J36W-SZVssb for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 16:57:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2BC94062E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792429075;
 b=gKgEQrkuLSQaH6EzIXx8LAWOh4Xb0OhG7m3vc7D4uxXdUkAOYPPEfS+fJ/39D89osmDf
 4L3T1gziUgNJO8Ms2LvNySuz9yVl7dulay1BLVtfHgu3xzvBr/PPnRMlK8nHs/L1r9pCA
 001N8052cCrQ6nYCyr+yq54tkPweh7KRaqyCv2OocKXHqLaMkasc9XfBizh6cx9JTzI8Q
 mtYmjJ09CJy1rF1n56mgSzOk7MbuyyogoMgREkmVnr0rXgb4FY6WE64CfWas6F9gbhJRO
 MN8EVsGHkVk2aHZX03+qo6YH1OgCgAweNgPGhWhgkoo6doPTH3DpTQsGMowSN3MkH2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792429075;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
 From:X-Mailer:References:In-Reply-To:X-ZohoMailClient;
 bh=Gd8SfTQZTdCSj95YQY5TKjv/9yQft6rcMY8HlIgW+bA=;
 b=jm7nSfYwhWHqbgKhVAKKvhlOP0xrsl/OdDBStADmTor+j7atLG7UzzIx3OEPchXGGdL2
 TQOKh6fvjFqfc0jdHRKkkzdd9qPARpkn1BB94IT7cH8SP2i/B+niX0m+3CJFoNWSF2ElT
 juIwkg+cDSl7sWFc3D5uRRy998VanPp4MWYw27A2/KZ8dR2+OTnfEYFtwYH00Z0VxA+UM
 5U+1/p23C7RKx70/BE3xZmaZUkOlXRJLDTaSEXLQAVm8VYcty7i3NGzTQNr6b3x2kXqoG
 j5wwYQheFexKpIoaPAzulfrdGjAtcBZDIiQluDuLATFGn1xMX989JPtD2ocYNCRgpNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=pigmoral.tech;
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=lYidmgqH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=lYidmgqH
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F2BC94062E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 16:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792429040; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=L+sk7zrwVjHydsPdn7QmPnCALm7QeIAVU0yut6PzxiCY7OqwZVvCdjCIfpHT+aOTFvCEkOAAgQShOiHziQQxfHgol5kE7KMdlwmGs+vPYZ7NZY9wrGLC73av1HDYoLXsuJhq/uFSMxz6TZYRZhVY4A+7nqVzCypV92JiNcAafYU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792429040;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Gd8SfTQZTdCSj95YQY5TKjv/9yQft6rcMY8HlIgW+bA=; 
 b=Ws0rf6nrEwIDacLQZbeb/NYdrErZIoaW+ldxw53o2XF5XDVC63paWM+Ms9V/5UPEKxs1ors3QPxF/osYxirCxgvPNpzylXxXFkok2zlHEbgUaM6YCupRdtmFmmun/DCwJ5o29ZDaM9lIEMbIy3qcj04LVxFl6MLiyEOxURXfHcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792429039; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:To:To:Cc:Cc:Subject:Subject:From:From:In-Reply-To:Reply-To;
 bh=Gd8SfTQZTdCSj95YQY5TKjv/9yQft6rcMY8HlIgW+bA=;
 b=lYidmgqHGFHKEvVNkHjLKqxHRPoKYX124kgK1G0WNSc+BdU7nEHugWlg0Idz/CWm
 qHdXYUqBeG8QSzVTR+qXV+cmj/RjVNnDWBtraBTaHvfNn/0fnheoZxsaS01UuW2W6Ne
 L9bL2Om795LBWVghrbkINN6rSfDVai4RJIhIJzoA=
Received: by smtp.zohomail.com with SMTPS id 179242903677683.99516991489963;
 Mon, 19 Oct 2026 09:57:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 00:57:11 +0800
Message-Id: <DM8Z29MAWU5D.4BOB6OBV6D8T@pigmoral.tech>
To: "Igor Opaniuk" <igor.opaniuk@oss.qualcomm.com>,
 <u-boot@lists.u-boot-project.org>
Cc: "Tom Rini" <trini@konsulko.com>, "Aristo Chen"
 <aristo.chen@canonical.com>, "Simon Glass" <sjg@chromium.org>, "Nora
 Schiffer" <nora.schiffer@ew.tq-group.com>, "Daniel Golle"
 <daniel@makrotopia.org>
Subject: Re: [PATCH v2] bootm: set os.arch for Android boot images
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20261012-upstream-bootm_android_b4-v2-1-4c18a34550a1@oss.qualcomm.com>
In-Reply-To: <20261012-upstream-bootm_android_b4-v2-1-4c18a34550a1@oss.qualcomm.com>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,

On Tue Oct 13, 2026 at 4:43 AM CST, Igor Opaniuk wrote:
> bootm_find_os() leaves images.os.arch at IH_ARCH_INVALID for Android boot
> images: unlike the legacy and FIT headers, the Android boot image header
> carries no architecture field. The arm64 Image relocation in
> bootm_load_os() (booti_setup()) is therefore skipped, and a kernel that
> is executed in place, which android_image_get_kernel_addr() arranges for
> any uncompressed kernel whose header holds the default kernel address
> (or with ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR), whatever the header
> version, runs from boot.img + page size, which is not 2 MiB aligned. The
> kernel reports "Kernel image misaligned at boot, please fix your
> bootloader!" and dies early (observed as a stack overflow in
> start_kernel() with a GKI 6.12 kernel on QEMU virt).
>
> Set IH_ARCH_DEFAULT, the one architecture this U-Boot can boot and the
> only value available for this image format, so that booti_setup() moves
> the kernel to a properly aligned address. The other readers of os.arch
> are not affected:
>
> - arch/arm/lib/bootm.c switches to AArch32 only for IH_ARCH_ARM, so an
>   Android image keeps taking the AArch64 path exactly as it does with
>   IH_ARCH_INVALID. Its update_os_arch_secondary_cores() hook, implemented
>   by Layerscape, marks the spin table entries OS_ARCH_SAME only when
>   os_arch equals IH_ARCH_DEFAULT, so with IH_ARCH_INVALID an Android
>   boot currently releases the secondary cores as if the kernel were a
>   different architecture; this is fixed as well.
> - the x86 setup.bin lookup in bootm.c is only reached on an x86 U-Boot,
>   where the Android format is not bootable through bootm anyway.
> - ARM32 and RISC-V do not read os.arch after bootm_find_os().
>
> For a v0-v2 image whose ramdisk is used in place, booti_setup() can now
> move the kernel forward by up to 2 MiB, and the memmove() of image_size
> bytes (which includes BSS) overwrites the start of the ramdisk that
> follows the kernel in boot.img. Executing in place already had the same
> problem, since the kernel clears its BSS early, so this is not a
> regression; the ramdisk is relocated by the ramdisk_high logic when it is
> in use, and loading the kernel to kernel_addr_r instead of executing it
> in place, like the compressed case, is a separate change. The LMB
> reservation also still covers the original load range, as it does for
> FIT.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v2:
> - reword the commit message (Simon Glass): the Android header has no
>   architecture field, the in-place execution is not specific to header
>   v3/v4, why IH_ARCH_DEFAULT is safe for the other readers of os.arch
>   (and fixes the Layerscape secondary core release), note on the
>   ramdisk overlap for v0-v2 images booted in place and on the LMB
>   reservation; code unchanged, kept unconditional
> - add Simon's Reviewed-by
> - Link to v1: https://patch.msgid.link/20261011-upstream-bootm_android_b4=
-v1-1-3e82462ac206@oss.qualcomm.com
> ---
>  boot/bootm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index b6ae0163b27..75b34f39cca 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -432,6 +432,7 @@ static int bootm_find_os(const char *cmd_name, const =
char *addr_fit)
>  		images.os.type =3D IH_TYPE_KERNEL;
>  		images.os.comp =3D android_image_get_kcomp(boot_img, vendor_boot_img);
>  		images.os.os =3D IH_OS_LINUX;
> +		images.os.arch =3D IH_ARCH_DEFAULT;
>  		images.os.end =3D android_image_get_end(boot_img, vendor_boot_img);
>  		images.os.load =3D android_image_get_kload(boot_img, vendor_boot_img);
>  		images.ep =3D images.os.load;

Thanks. With this change, I no longer need to specify --kernel-offset
or --page-size when booting a kernel Image via fastboot boot.

However, I did encounter the ramdisk overlap issue in my testing on
an Allwinner ARM64 platform. The ramdisk is relocated afterwards by
boot_ramdisk_high(), but by then its source data has already been
overwritten. As noted in your commit message, let's address it in a
separate patch.

Also, RISC-V boots successfully when combined with this patch:
https://lore.kernel.org/u-boot/20261020-bootm-riscv-image-relocation-v1-1-e=
583a2dd1d14@pigmoral.tech

Reviewed-by: Junhui Liu <junhui.liu@pigmoral.tech>
Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>

>
> ---
> base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
> change-id: 20261011-upstream-bootm_android_b4-4e94dca526b5
>
> Best regards,
> -- =20
> Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

--=20
Best regards,
Junhui Liu
