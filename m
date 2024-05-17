Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A7EC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 12:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34011883C7;
	Fri, 17 May 2024 14:46:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="su1HlGZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0EA8823C; Fri, 17 May 2024 14:46:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9721A8823C
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 14:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715949975; x=1716554775; i=xypron.glpk@gmx.de;
 bh=1CD7bJv57crJ+jE9uUGFIHfsAY1Ro298UWLqfXrAPSc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=su1HlGZrXiV/o8fO1fVU03kh9gX9893RVDY9gFWY+z0UPiLICkCHblQ7rBBBLGx4
 4+Fq6UmByuxoikKJLcg/T0+GCfanXtSm4w1YmBUXolvAp4dtweGGmqxdE8NKxOKWQ
 9o26kmINWoncdZfEQGCoH7MoCSWxiRQG8PAA86luhWERPBrgpEB3JP8Dyc9FtkhLF
 I97uTrmCciOsZinW5MqcSUJ2NVr05TKNkkgqU8wKIEEbO/uTc8VuHXLD5OM/6N78/
 ogkznKvPNoDsrGz+QiE3EjZUmxzstoByLKwZj08AlnXj5/LBsNZ2951KT9QmJspiA
 5mvjOURWqdhjSG6Nqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm2D-1sMYEm369D-00GFxM; Fri, 17
 May 2024 14:46:15 +0200
Message-ID: <96451f9b-8411-4764-ace3-45b25f097f69@gmx.de>
Date: Fri, 17 May 2024 14:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] efi: Correct handling of frame buffer
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231119191202.667180-1-sjg@chromium.org>
 <20231119121144.v5.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231119121144.v5.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w5LgdLA/Z4i8Bcp4/j33fl3d9cgpwi3IGf5uQ5rB9OZXZkSzGxS
 1dHKsKgHACVKx8Av5oz6BsDzsH8WRnu53UR3r1E4dc3j0vMA07CHvytgNfyrx+NI8rj7bYw
 JH+DBOZTTDUkmMHwTbkjPAqGdLXvYZBrjoogEMruocjcxw0Bv+CjPkH32wyCw3Nsy77PVbd
 QND6ddKSFBNMt/D3M9B8Q==
UI-OutboundReport: notjunk:1;M01:P0:vbOEUFIjvb8=;q7MPwXGlOxuz77G9CaeWWaGBhTZ
 d1jU8LhIb8NGmrxmeAaXpweo/lJr+J1ILzX3+ABh2Dzw/ehS05mcj0V8MQKMqSBm22+WSumSg
 6Kjjps9OD6t58KeFvWm7MjsyaBkvKeWI1xZI2rb/qYp7T0s3n7LJLyqJx4byiDnNeMGJNebXN
 UDReTZgatkSWHvk6dpNZ/UZ0V3lrVVL2y9Ai3Z6bXaBE7TeAGCkZnebHwx0lbh7t+fMmtfEy5
 gzib76e3cgNOhUYRu1MT3YrxyxbujNf2pWlf5iOQ5MY4cCGukzioKkWA6JgbLBhcc3IuAnmHk
 TIUs9HMwyrygcLKnn8pv4wqagBNG6bd0+IJ6fXjIpBZPKAOyqN7FoPXQ8FmuGLndhwA3fUr7S
 QcXXOtaUYPqA1/Grd8fnCECZLKG/s9VemRDbqUke110reZpMTxxUtdvAu7lc8X6FNnEc5LbHv
 w373dRZqMJIfSEnAHz0FiU7uvn6eswY4gTO7+GmSPk5aleqJaoQer4+GUsXgdBCAjTHW6QMp2
 WB7pqww0lIXQfeOt13l6orPeITVhMzX0R004NLrMpdoxSl18V6e9W0ilJfYNxMgVtBTWDpVG9
 GWkdsmUL/bwEq2idfsEg/NjrzA/YCkQaKfJ5PY2aBne+QOjaLvT9W/x8yY03rz1UFK09NNfA5
 COC/PskDO5wqYibFifg/SXaVFlkF7VNtfLR2HLgOhvPi4zhvY+wX0RXmWPQb08uxOECBfL1Ur
 C8ZY1kOnWV5lGajTIq8/f7Lb9Ga0QJEKIkatAoXubOS8//lzwEzvrdtrzrRNbLk00jaRT0bCS
 TY0yaBMhUfbXLkSLHOPNZslJJH6R1uija9sLS6C2wL26w=
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

On 11/19/23 20:11, Simon Glass wrote:
> The efi_gop driver uses private fields from the video uclass to obtain a
> pointer to the frame buffer. Use the platform data instead.
>
> Check the VIDEO_COPY setting to determine which frame buffer to use. Onc=
e
> the next stage is running (and making use of U-Boot's EFI boot services)
> U-Boot does not handle copying from priv->fb to the hardware framebuffer=
,
> so we must allow EFI to write directly to the hardware framebuffer.
>
> We could provide a function to read this, but it seems better to just
> document how it works. The original change ignored an explicit comment
> in the video.h file ("Things that are private to the uclass: don't use
> these in the driver") which is why this was missed when the VIDEO_COPY
> feature was added.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 8f661a5b662 ("efi_loader: gop: Expose fb when 32bpp")
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>#

Since this patch
a75cf70d23ac ("efi: Correct handling of frame buffer") the EFI block
image transfer is broken on the sandbox.

Build sandbox_defconfig with CONFIG_EFI_SELFTEST=3Dy.

setenv efi_selftest block image transfer
bootefi selftest

A moving submarine should be shown.

Best regards

Heinrich

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Rebase to -next
> - Add some more comments to the header file
> - Add fixes tag
>
>   include/video.h          |  9 ++++++---
>   lib/efi_loader/efi_gop.c | 12 +++++++-----
>   2 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/include/video.h b/include/video.h
> index 5048116a3d57..4d8df9baaada 100644
> --- a/include/video.h
> +++ b/include/video.h
> @@ -21,9 +21,12 @@ struct udevice;
>    * @align: Frame-buffer alignment, indicating the memory boundary the =
frame
>    *	buffer should start on. If 0, 1MB is assumed
>    * @size: Frame-buffer size, in bytes
> - * @base: Base address of frame buffer, 0 if not yet known
> - * @copy_base: Base address of a hardware copy of the frame buffer. See
> - *	CONFIG_VIDEO_COPY.
> + * @base: Base address of frame buffer, 0 if not yet known. If CONFIG_V=
IDEO_COPY
> + *	is enabled, this is the software copy, so writes to this will not be
> + *	visible until vidconsole_sync_copy() is called. If CONFIG_VIDEO_COPY=
 is
> + *	disabled, this is the hardware framebuffer.
> + * @copy_base: Base address of a hardware copy of the frame buffer. If
> + *	CONFIG_VIDEO_COPY is disabled, this is not used.
>    * @copy_size: Size of copy framebuffer, used if @size is 0
>    * @hide_logo: Hide the logo (used for testing)
>    */
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index 778b693f983a..a09db31eb465 100644
> --- a/lib/efi_loader/efi_gop.c
> +++ b/lib/efi_loader/efi_gop.c
> @@ -10,6 +10,7 @@
>   #include <efi_loader.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <mapmem.h>
>   #include <video.h>
>   #include <asm/global_data.h>
>
> @@ -467,10 +468,10 @@ efi_status_t efi_gop_register(void)
>   	struct efi_gop_obj *gopobj;
>   	u32 bpix, format, col, row;
>   	u64 fb_base, fb_size;
> -	void *fb;
>   	efi_status_t ret;
>   	struct udevice *vdev;
>   	struct video_priv *priv;
> +	struct video_uc_plat *plat;
>
>   	/* We only support a single video output device for now */
>   	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
> @@ -483,9 +484,10 @@ efi_status_t efi_gop_register(void)
>   	format =3D priv->format;
>   	col =3D video_get_xsize(vdev);
>   	row =3D video_get_ysize(vdev);
> -	fb_base =3D (uintptr_t)priv->fb;
> -	fb_size =3D priv->fb_size;
> -	fb =3D priv->fb;
> +
> +	plat =3D dev_get_uclass_plat(vdev);
> +	fb_base =3D IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->ba=
se;
> +	fb_size =3D plat->size;
>
>   	switch (bpix) {
>   	case VIDEO_BPP16:
> @@ -547,7 +549,7 @@ efi_status_t efi_gop_register(void)
>   	}
>   	gopobj->info.pixels_per_scanline =3D col;
>   	gopobj->bpix =3D bpix;
> -	gopobj->fb =3D fb;
> +	gopobj->fb =3D map_sysmem(fb_base, fb_size);
>
>   	return EFI_SUCCESS;
>   }

