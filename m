Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB345C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 22:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4375386AB5;
	Sat, 26 Aug 2023 00:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="H29oLWuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22F386ACF; Sat, 26 Aug 2023 00:01:39 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC5E86AA6
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 00:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693000896; x=1693605696; i=xypron.glpk@gmx.de;
 bh=zm3jJD8wQSbGKd+4fxzSiNrParg3TA6/sYHtnV/he2s=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=H29oLWuUtccmVzXc2u/DekPL6tX3dJh0RNmsbUfjcLHIELlrn54JNBCAlay7Y1szQ7+v+06
 inZJAb4hqG4ha0h23HmFTXNr1qOEGDbKRt6pg9UAB8rAih5DgigUsWg1krYhHcAk9HvZhNmkQ
 f13uA1qaQJ59ApUTYjBle+JA9BIIrZNe+GP4RNRKKdhLnAJ1AvlzyGL1HaJ/9MKAJRHQJoouf
 specnn7iu/SCtFPfLXDWSWZo08GBqEPQzOJsz5+eqjD+r8lUTTjod1o2kFLv0OPD22eiDHQDy
 d1RULs3HidGY4q1icMzLnD+I3Ozv7YJuGKckEYZ+Cny+P38pSKLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1qUhLC0Gvm-00H7FF; Sat, 26
 Aug 2023 00:01:36 +0200
Message-ID: <8e64d594-8f05-4b0f-b83f-c7a99c6e781f@gmx.de>
Date: Sat, 26 Aug 2023 00:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Correct handling of frame buffer
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230825192842.1957055-1-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230825192842.1957055-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uHIeBGNkrQnMVmHmm93c9DJzqrDAF0NXieYJ2LAOzxxpVBqhCRT
 fV76/tcXJ/Hk3bli4Jt2zcsxHsAkiSHpirR3OWAyje3+0eLN+y590kVeoA1U/m7aoKf8wW2
 pPvEfxcNZibKAIZkCihWv2hN6chsRrYsHxlZb1HiEsil05JgcW+YUFSBlKicRz7c9G1r7B4
 ngA9POrmfwfPv05Fpiuyg==
UI-OutboundReport: notjunk:1;M01:P0:r/dHuClxvfk=;A5SLiswIoNb7aomKeqMiRstAtKr
 CyXKgNdnYcqDTdouFGwfAl1z9bhfnz3+pBbcIBb4/WuET0NmOD8o4Yfk7gDktHQLQIF1H7fJL
 gkFm8EARnhZivayjrnYeQnptAq/dbFL6B41+a9dedckaFX1XJwUED13vhTlDoOjqxPhsj4+Bd
 +FKAJeuaB9fcgLWJDBZ8Og5dfHU7YyKwz+mO5d8vKXIQmkCu4aoGCT+35NLV0bQEC3SeTXVsn
 yqPYIHbOsUgPbQX4crPFYLnhmZj5IzTfogLgP2eSQRa45MoNWNli232cOXvhqPrg/Ms3D9DcN
 7FQB1xbCc7WgJ7fgzvdP75B+VlPneiL73lZQ6TWnG96Jo8eKOjnfUJqsZRWKyxwr4yPunIxln
 Yi+w20rfKzouaVr9lJzs3PZlXAtjCs2+6YLygMdS6V7qbWDQwKpt4VyPNjuMyJhZH4EA4lJ6m
 j/4xEi7+KfLMCyoGAMbtfQLaQ/5XNeIZIMj3BiwlxGef8oQdNX8Zk3EdjKqnoFbhJHK8K+x9X
 Th36Wv91InJqKdbJLcD//5lnfdA9pO+CBJwOsdLG/Agmd3h0e+0g5Rk3UKwOuWRzn7xW8xIb3
 gUB758Wy+1cHHFbyMRMoDE60usZuO5oMu2qT3P2haLiIx5uKY6UsluBJ73M8UkWS7ZJrK3H21
 K8bakVHX8xq6PLgl2l93rk1N3NbGoUM+pAP7RyFhqP5fHDKbDpbnU8wmUyAGUUewJX6Dd/4OC
 eA3OWKwTW5+kjVAUG5gnrXDsvwBowIy3Lyq7wFNbYYufH3B0TqBhmhvVVtitWTSQ70MNFFpFM
 3rovEBdWzjdqjQS2zekTxJkFYTjbP1h+3wnyIMYYqjfV2dutie9PKmFKyn5rLT8O/VZS98RiJ
 nn44nKodcmPop5Bf8jHD/+hQhyMdsPrqRzjLGJXOCF9yXnon9QBjIN51nXtegvEQJNtpSjjxL
 2ChSSF/mq+/GTI5zycS+fkipNyw=
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

On 8/25/23 21:28, Simon Glass wrote:
> The efi_gop driver uses private fields from the video uclass to obtain a
> pointer to the frame buffer. Use the platform data instead.
>
> Check the VIDEO_COPY setting to determine which frame buffer to use. Onc=
e
> the next stage is running (and making use of U-Boot's EFI boot services)
> U-Boot does not handle copying from priv->fb to the hardware framebuffer=
,
> so we must allow EFI to write directly to the hardware framebuffer.

Let's think of a EFI application running:

With your patch GOP API calls will use the hardware buffer. But text
output by calling OutputString() and messages generated in the U-Boot
code would write to the copy buffer. This will lead to unexpected output.

What triggers copying from the copy buffer to the hardware buffer?

Where is the copy function implemented?

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_gop.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
> index 778b693f983..a09db31eb46 100644
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

This logic and the map_sysmem() conversion would better be placed in
video-uclass.c or video.h as a function video_get_hw_fb(void *fb_base,
size_t *fb_size).
>
>   	switch (bpix) {
>   	case VIDEO_BPP16:
> @@ -547,7 +549,7 @@ efi_status_t efi_gop_register(void)
>   	}
>   	gopobj->info.pixels_per_scanline =3D col;
>   	gopobj->bpix =3D bpix;
> -	gopobj->fb =3D fb;
> +	gopobj->fb =3D map_sysmem(fb_base, fb_size);

Could you, please, add a description of the side effects of the 'len'
parameter of map_sysmem() in doc/arch/sandbox/sandbox.rst. It seems to
be ignored, see

include/mapmem.h:16
arch/sandbox/include/asm/io.h:40

So maybe just remove it?

Best regards

Heinrich

>
>   	return EFI_SUCCESS;
>   }

