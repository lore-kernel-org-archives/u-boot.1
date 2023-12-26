Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C25FC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD27B8791A;
	Tue, 26 Dec 2023 10:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JQ+w/lS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A957587919; Tue, 26 Dec 2023 10:48:15 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B9CE8781A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6dbb20471b0so3355286a34.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584092; x=1704188892; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShabeFujdhUO8CwZO026qy2Z5Wb6Qr8LqG79NAZRrrc=;
 b=JQ+w/lS72Mfcxa93q75M95DF8PNY8AFk2S1w74pNjfe4dIYssQ2uUsUSITm1L7xBmQ
 qEvtVd1bezmoMueSoeQ9JbyBgKWTTY0eWsVFu+vhe+XJw6V3OyMlj8xu7PsTRoCnnjGs
 kfpE88I5pfKC1RGzefjcerxMXjHfVnIh/1E3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584092; x=1704188892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShabeFujdhUO8CwZO026qy2Z5Wb6Qr8LqG79NAZRrrc=;
 b=rkD74PErQgtMwm/NxEh9UgsQGLe/WI8N3bYFxmslU7DI4JeP6q3SKynQXRc/UyQlpj
 TQ2F9bWZ8SQrIqmicqE08UBfzUv3BvcdrNYAVBCJP7dsqQ/ZkD1yPP5KFjudLZZZkAFe
 1b7HtrJ3uYjaPhxLDt6U1J8s1oyEnDhkXisYphVCqVdjClJY2oHiP84auwLmSPytAKx6
 feP2UNgLrU77JUTqgSjLJ+Cyq5kLABTPPRiAv1FcoeS38fo5Uyz/DHNeefpIAVMafQRA
 Kz6qZ/prXm3wdrTUeLNXYjF6lIsBZlLwdjQSdh+VasKYqQ6ARwP0YSuMiwdWSps1yE0f
 dsJQ==
X-Gm-Message-State: AOJu0YwV2E5kaZb5oi9Y2A7zxkH6li6gTuBCy2mnJoPRf2U0WJd/J1wU
 8yN5Xrcmc27cO6S0r/fhBB5ZrA6MdQ2UvgDoxKzcQrdilZ1h
X-Google-Smtp-Source: AGHT+IG54n7JVF0ZEGArLfR4Uj0NTXkZ8wji/LI4p5G0i8FZ41f/cYTCwxqrQBHHTObtmxZrbluD8ZYe95C8d3PI+3I=
X-Received: by 2002:a05:6808:219f:b0:3bb:8023:37c9 with SMTP id
 be31-20020a056808219f00b003bb802337c9mr9791048oib.2.1703584092200; Tue, 26
 Dec 2023 01:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-9-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-9-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:46 +0000
Message-ID: <CAFLszTg=TZaO-EKoqRf8dH1Kf9WHO-OGWzsg0k8-+riuyN8EDQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] fdt: update the document and Kconfig description
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>
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

Hi Raymond,

On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Update the document and Kconfig to describe the behavior of board
> specific custom functions when CONFIG_OF_BOARD is defined.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  doc/develop/devicetree/control.rst | 6 +++---
>  dts/Kconfig                        | 7 +++++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/=
control.rst
> index cbb65c9b17..e061f4e812 100644
> --- a/doc/develop/devicetree/control.rst
> +++ b/doc/develop/devicetree/control.rst
> @@ -104,9 +104,9 @@ in u-boot.bin so you can still just flash u-boot.bin =
onto your board. If you are
>  using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the=
 device
>  tree binary.
>
> -If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
> -devicetree at runtime, for example if an earlier bootloader stage create=
s
> -it and passes it to U-Boot.
> +If CONFIG_OF_BOARD is defined, board-specific routines will provide the
> +bloblist and devicetree at runtime, for example if an earlier bootloader=
 stage
> +creates it and passes it to U-Boot.
>
>  If CONFIG_SANDBOX is defined, then it will be read from a file on
>  startup. Use the -d flag to U-Boot to specify the file to read, -D for t=
he
> diff --git a/dts/Kconfig b/dts/Kconfig
> index 00c0aeff89..12d61dc748 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -110,8 +110,11 @@ config OF_BOARD
>         default y if SANDBOX || OF_HAS_PRIOR_STAGE
>         help
>           If this option is enabled, the device tree is provided at runti=
me by
> -         a custom function called board_fdt_blob_setup(). The board must
> -         implement this function if it wishes to provide special behavio=
ur.
> +         a custom function called board_fdt_blob_setup().
> +         If this option is enabled, bloblist is provided at runtime by a
> +         custom function called board_bloblist_from_boot_arg().
> +         The board must implement these functions if it wishes to provid=
e
> +         special behaviour.

Again, this spec is not board-specific, so it should work on any ARM
board, without board-specific code, just by enabling the feature.

>
>           With this option, the device tree build by U-Boot may be overri=
dden or
>           ignored. See OF_HAS_PRIOR_STAGE.
> --
> 2.25.1
>

Regards,
SImon
