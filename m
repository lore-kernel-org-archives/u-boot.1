Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D0C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5787B87652;
	Thu,  2 Nov 2023 09:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TVFTM8zT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E177E8768D; Thu,  2 Nov 2023 09:45:07 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5CE87620
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d216597f64so96456766b.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698914702; x=1699519502; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmH+V6GBMi67TNX4NKfU7osHAb1WkR6xENvq8X0Z+ik=;
 b=TVFTM8zT3Nd8GYxmay3ZWPeTvgN+kOHlSVBcTF213f1FTIqS/JNgTrb4zTxaR3lSQj
 DSbYOxqJMrzrSbGqqNQAo7YSvIOcM5ovQmKScllNbW0D/f4E2sxV/j3SD+2jNJbOMN2U
 vAxqPZnQjpTYq4gxeJ4j13vHgVGhHoZU6FcwQHzRcK/WaoIkNSSaFYoKQkuJXPEu5jZw
 vJP9/eyF8pfMrt4W8CJhKkm1E6aa/NczGGnzWStKnLALwpg5fk/pFUYfgULpV6ePkUHB
 DygZl5bbZFxTJOalEOtcF+MQC2S7vXQxeg2e9PmWPmga5dWOMA6ow8u+ECeLCDu/Ajsm
 Df9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698914702; x=1699519502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pmH+V6GBMi67TNX4NKfU7osHAb1WkR6xENvq8X0Z+ik=;
 b=WoeCx/5nYne4F9jpWlA7GlPfrESaNJZtUHxrABWzSpojmAIBMjSzDoRahI2yvZ23IS
 0Q1Nz25KCjO9LJJbuHqNrXuQNOqp1f2cwEqZlI5Li6xGunNfZgp7+rNeTShvmHL0b6lo
 AlgvYoX5/dSqVIpv0ITdt+O8k9koEV0zRTORJX4kI/q/GEfnG1ciAT1+FAwgEQJoMT1k
 /5q0/YDSw8AVjZpxbTTCyrs5xQ3TvFGWFdlcFHOpS6E5Yik2ZVR1pm6gqcoplPJWncXN
 77XHFYkhtnnD9ZOySmx34BQDah0sSsteqdTsyrA21Dz29nz/VbGvJhAbP5PTsKFOyQkn
 i5IA==
X-Gm-Message-State: AOJu0Yy7aJ/hiylj+eThlfXMjPMY0RBfg5Y3FsP7GyOZEnlg+86Ha2M4
 7NhN6org/7oPFKMp/sb5t6RFcbRyEee+crt27/M=
X-Google-Smtp-Source: AGHT+IF67gl0y6StTa5wjPPcGMKox1ROJ58j5FaWyxfzuxr08fZ+r+ZsYz0PlNqpbx+peTArH3vvTaT685J0OMeIFd4=
X-Received: by 2002:a17:907:9496:b0:9ae:55f5:180a with SMTP id
 dm22-20020a170907949600b009ae55f5180amr4013551ejc.9.1698914702234; Thu, 02
 Nov 2023 01:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231027074326.3357618-1-masahisa.kojima@linaro.org>
In-Reply-To: <20231027074326.3357618-1-masahisa.kojima@linaro.org>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 2 Nov 2023 16:44:51 +0800
Message-ID: <CAHk0Hot9EYPvPCty4JgsH3GHTiCEBt26oJu_DS5EVQJ_SMMGuw@mail.gmail.com>
Subject: Re: [PATCH] scripts/Makefile.lib: print error when no public key is
 specified
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Fri, Oct 27, 2023 at 3:45=E2=80=AFPM Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> The current build system embeds the EFI Signature List(ESL)
> into the dtb to be used in the EFI capsule authentication.
> This ESL file is specified through the CONFIG_EFI_CAPSULE_ESL_FILE
> Kconfig option. If CONFIG_EFI_CAPSULE_ESL_FILE is not specified,
> U-boot build ends up with failure but the cause of failure is not
> easily understandable. Current error message is as follows.
>
> FATAL ERROR: Error reading file into data: Is a directoryCheck /home/ubun=
tu/src/ledge/u-boot/arch/arm/dts/.synquacer-sc2a11-developerbox.dtb.pre.tmp=
 for errors
> make[2]: *** [scripts/Makefile.lib:355: arch/arm/dts/synquacer-sc2a11-dev=
eloperbox.dtb] Error 1
> make[1]: *** [dts/Makefile:44: arch-dtbs] Error 2
> make: *** [Makefile:1165: dts/dt.dtb] Error 2
> make: *** Waiting for unfinished jobs....
>
> This commit shows the error message that CONFIG_EFI_CAPSULE_ESL_FILE
> must be specified when the EFI capsule authentication is enabled, then
> terminate the build with error.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>  scripts/Makefile.lib | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 8dc6ec82cd..16bbc277a9 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -339,7 +339,12 @@ cmd_capsule_esl_gen =3D \
>         $(shell sed "s:ESL_BIN_FILE:$(capsule_esl_path):" $(capsule_esl_i=
nput_file) > $@)
>
>  $(obj)/.capsule_esl.dtsi: FORCE
> +ifeq ($(CONFIG_EFI_CAPSULE_ESL_FILE),"")
> +       $(error "CONFIG_EFI_CAPSULE_ESL_FILE is empty, EFI capsule authen=
tication \
> +       public key must be specified when CONFIG_EFI_CAPSULE_AUTHENTICATE=
 is enabled")
> +else
>         $(call cmd_capsule_esl_gen)
> +endif
>
>  capsule_esl_input_file=3D$(srctree)/lib/efi_loader/capsule_esl.dtsi.in
>  capsule_esl_dtsi =3D .capsule_esl.dtsi
> --
> 2.34.1
>

Reviewed-by: Weizhao Ouyang <o451686892@gmail.com>
