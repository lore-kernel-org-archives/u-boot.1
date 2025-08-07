Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FE4C87FCB
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 00:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9333A83B1A;
	Thu,  7 Aug 2025 02:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="W9X7iPnh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E417A83B1A; Thu,  7 Aug 2025 02:49:57 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9581283AE9
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 02:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30bbb2d332eso173077fac.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 17:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1754527793; x=1755132593; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQxwcqiH5NJ1iWTqqk8Crn0eQOoROOlNu1pWwWUPKLE=;
 b=W9X7iPnhoc4TePnqwwzHUWyxRadryiDTxxMC3b+SHuNXBIqnofLSdVUanOvs6E3T/r
 7LfR2GlW/3+8TSwMa9AAClreUD4/e0DPScqR3sSPczkgemLzLk6bCcIvESOeqvPOetnI
 cRg1OqpPGAOJ+ZO6z58QtOL8xvU5cxjlqNz56WxE/mhp3Yyw0mM4pNSIsXXMuOCLusxz
 p+aPoSBnnJd9XsX0abCqv9qTPRZjUzuDCDNDj3cddd5gjoUzPTD7VocvQeejt5MuTncG
 eEW9w9SPqDz9abYF9mo7h1ykWtnfDhwBKwpwnGIcqkrrurpf8SOvJ4Zzqs5AsSThZGqC
 LnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754527793; x=1755132593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gQxwcqiH5NJ1iWTqqk8Crn0eQOoROOlNu1pWwWUPKLE=;
 b=KSvClLqPBs9uFTIvWizR3X7x0dTbeFzS/HLyrPI+hJ024XfFY/vUNMjQlUX/O+vNKI
 UkeX5RJ8KT7CaHUKMSXJoZbXprJkYXth18kDsd6HQsXYURc1A7u0t+AcU+vLclJUHhC2
 H504mi/MrhlPIVViQXA9yW+a0ARoTDoJC14Ctp5sEe13PQ+zm8D/5xwD5g2VTIzfMTPy
 jYzdXvABZmFvjhIaWHIaeqCnnJVFgIk3Z2fMfBneF00OyjPGyRLQDJXZ4OiUqvo85I7x
 9zm/QrZVdDRDb41y1TlyXA1WdboYkLgcydFB31Cs0qKsqpaxXBBfhA9ZgGI4bjfVlXLr
 5YZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuGpyu+vaCnTNXZ6zsQXgJGytQamK5wGAPYszl0OWk1xgu8uypgfTi3eJZqD+ig/iYFhYk/mE=@lists.denx.de
X-Gm-Message-State: AOJu0YzOIie/p3jCPi1n/dsgM2JaKCSXwUFsaYVHgWxSJ7/UcWjzEu/c
 VO7jJ0gdxE/4cjVOi4fGlHc1hHMp35qadeg61dvSYCAzgpz4AhzF7IF71D+YiVZ6F7IBA13Fml/
 2polA1ZYyOWL6MdY7PE1X8YFkick7IvZIS5IK4BeiRA==
X-Gm-Gg: ASbGncsGTuR/yPhLFIo9P6V2yqyYzzcELuyeZsUs5AwfHIelWZIIH9GmSDZ3qTMkmqS
 nQP/nnRlnSfliRdNdgs4d6vXgu9o/FNtzbkI3XXzuZHJ4wksc3AfRylqMB2NTvBR3qQZc6digVY
 uDXxXWesLEf49zO2Q2dmNyO/eMM1pbo5Qi+Ry6P9KNrMm3wedgofITEgJQXXSgMi18U44TfgksF
 iWv1ZE=
X-Google-Smtp-Source: AGHT+IF8mKeCAkfZRafi4+LctlRKb/e/1wZ9OXSkjPWbo658wx0PwrA4gvgq1zyMrCK1a8ANmi8+8IDsZyq7RbkT/4Q=
X-Received: by 2002:a05:6870:ac06:b0:301:a823:9cd1 with SMTP id
 586e51a60fabf-30be2bd6048mr2937929fac.22.1754527793098; Wed, 06 Aug 2025
 17:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
 <20250728-imx95b0-v1-2-5cdae3764d21@oss.nxp.com>
In-Reply-To: <20250728-imx95b0-v1-2-5cdae3764d21@oss.nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 6 Aug 2025 17:49:42 -0700
X-Gm-Features: Ac12FXzY_tRdkwTPD5-RC8PYtWnDGzfeuX98NIpUn5tpUfhOlPVUJ2IEkUNDh1Q
Message-ID: <CAJ+vNU2GGaXhqmoJQwh=NPA9QwjdXBqGuRA96CmaZt4iybhucw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imx95_evk: Restore support for i.MX95 A0 silicon
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 6, 2025 at 5:40=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:
>
> From: Alice Guo <alice.guo@nxp.com>
>
> This patch is used to restore support for i.MX95 A0 silicon. To avoid
> duplicating defconfig, imx95.config is added and can be shared between
> imx95_a0_19x19_evk_defconfig and imx95_19x19_evk_defconfig.
>
> container.cfg and imximage.cfg are used to created .cfgout files that
> are be passed to mkimage with -n to build flash.bin. Now they have been
> deleted and replaced by adding their content to the property cfg-content
> of node which type is nxp-config under binman node.
>
> Fixes: 9936724aa9b ("imx95_evk: Add i.MX95 B0 support")
>

Hi Alice,

Thanks for addressing this!

> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/dts/imx95-u-boot.dtsi            |  48 ++++++++++
>  arch/arm/mach-imx/Makefile                |   5 +
>  arch/arm/mach-imx/imx9/Kconfig            |   5 +-
>  arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
>  arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
>  configs/imx95.config                      | 150 ++++++++++++++++++++++++=
+++++
>  configs/imx95_19x19_evk_defconfig         | 153 +-----------------------=
------
>  configs/imx95_a0_19x19_evk_defconfig      |   2 +
>  doc/board/nxp/imx95_evk.rst               |  41 +++++++-
>  9 files changed, 247 insertions(+), 184 deletions(-)
>
> diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.d=
tsi
> index 9bf8f9834c9..227e220cd65 100644
> --- a/arch/arm/dts/imx95-u-boot.dtsi
> +++ b/arch/arm/dts/imx95-u-boot.dtsi
> @@ -51,6 +51,54 @@
>                         filename =3D "flash.bin";
>                         pad-byte =3D <0x00>;
>
> +                       imximage-cfg {
> +                               type =3D "nxp-config";
> +                               cfg-path =3D "spl/u-boot-spl.cfgout";
> +#ifdef CONFIG_IMX95_A0
> +                               cfg-content =3D "BOOT_FROM SD",
> +                                             "SOC_TYPE IMX9",
> +                                             "APPEND mx95a0-ahab-contain=
er.img",
> +                                             "CONTAINER",
> +                                             "IMAGE OEI m33-oei-ddrfw.bi=
n 0x1ffc0000",
> +                                             "HOLD 0x10000",
> +                                             "IMAGE OEI oei-m33-tcm.bin =
0x1ffc0000",
> +                                             "IMAGE M33 m33_image.bin 0x=
1ffc0000",
> +                                             "IMAGE A55 spl/u-boot-spl.b=
in 0x20480000",
> +                                             "DUMMY_V2X 0x8b000000";
> +#else
> +                               cfg-content =3D "CNTR_VERSION 2",
> +                                             "BOOT_FROM SD",
> +                                             "SOC_TYPE IMX9",
> +                                             "APPEND mx95b0-ahab-contain=
er.img",
> +                                             "CONTAINER",
> +                                             "DUMMY_DDR",
> +                                             "IMAGE OEI m33-oei-ddrfw.bi=
n 0x1ffc0000",
> +                                             "HOLD 0x10000",
> +                                             "IMAGE M33 m33_image.bin 0x=
1ffc0000",
> +                                             "IMAGE A55 spl/u-boot-spl.b=
in 0x20480000",
> +                                             "DUMMY_V2X 0x8b000000";
> +#endif
> +                       };
> +
> +                       container-cfg {
> +                               type =3D "nxp-config";
> +                               cfg-path =3D "u-boot-container.cfgout";
> +#ifdef CONFIG_IMX95_A0
> +                               cfg-content =3D "BOOT_FROM SD",
> +                                             "SOC_TYPE IMX9",
> +                                             "CONTAINER",
> +                                             "IMAGE A55 bl31.bin 0x8a200=
000",
> +                                             "IMAGE A55 u-boot.bin 0x902=
00000";
> +#else
> +                               cfg-content =3D "CNTR_VERSION 2",
> +                                             "BOOT_FROM SD",
> +                                             "SOC_TYPE IMX9",
> +                                             "CONTAINER",
> +                                             "IMAGE A55 bl31.bin 0x8a200=
000",
> +                                             "IMAGE A55 u-boot.bin 0x902=
00000";
> +#endif
> +                       };
> +
>                         spl {
>                                 align =3D <0x400>;
>                                 align-size =3D <0x400>;
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 8bd85e889ab..fa2cdaba144 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -223,6 +223,10 @@ endif
>
>  ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
>
> +ifneq ($(and $(CONFIG_IMX95),$(CONFIG_BINMAN)),)
> +SPL: spl/u-boot-spl.bin FORCE
> +       $(call if_changed,mkimage)
> +else
>  quiet_cmd_cpp_cfg_imx9_check =3D CHECK    $@
>  cmd_cpp_cfg_imx9_check =3D $(CPP) $(cpp_flags) -D__ASSEMBLY__ -x c -o $@=
 $< && $(srctree)/tools/imx9_image.sh $@
>
> @@ -244,6 +248,7 @@ u-boot-container.cfgout: $(IMX_CONTAINER_CFG) FORCE
>  flash.bin: spl/u-boot-spl-ddr.bin container.cfgout FORCE
>         $(call if_changed,mkimage)
>  endif
> +endif
>
>  else
>  MKIMAGEFLAGS_SPL =3D -n $(filter-out $(PLUGIN).bin $< $(PHONY),$^) \

excellent cleanup - nice to see those cfg files go away

<snip>
> diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
> index 27cd15eb7c9..83ec628f989 100644
> --- a/doc/board/nxp/imx95_evk.rst
> +++ b/doc/board/nxp/imx95_evk.rst
> @@ -21,6 +21,16 @@ Get ahab-container.img
>
>  Note: srctree is U-Boot source directory
>
> +i.MX95 A0 silicon version
> +
> +.. code-block:: bash
> +
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3=
.0-17945fc.bin
> +   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
> +   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctr=
ee)
> +

Is there a reason you are using a different version of the container
here? I find the mx95a0-ahab-container.img from
firmware-ele-imx-2.0.2-89161a8.bin appears to work fine. Either way:

Tested-By: Tim Harvey <tharvey@gateworks.com> # imx95-19x19-evk (rA0)

Best Regards,

Tim
