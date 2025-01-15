Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141ABC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50CEC800C2;
	Wed, 15 Jan 2025 14:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D+pQ+bCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC27480214; Wed, 15 Jan 2025 14:19:22 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A737F80040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:19:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaf8f0ea963so1302954466b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947160; x=1737551960; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1CfR6AXHCy3d5vS0BkAdeJu2DIgMTKlQZF0FYsK7QL0=;
 b=D+pQ+bCS5krNkdMz5kbZhcV+QtHljwUntzyo6npke6uGhgCRqW4uOMZTOKURSMmPT+
 HQ+w3vIj0tyNshr22b6MIwsBA2qztmCjGA5OCbs9P/nzMYuq2O78L6CNwikVyQBRrrkj
 UsjUJUYH9QCvDKEvCKPh5gZiZrtg5xiQiDMwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947160; x=1737551960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1CfR6AXHCy3d5vS0BkAdeJu2DIgMTKlQZF0FYsK7QL0=;
 b=k2QPK4iQ+7RfivQSgdSRjO0h/pfhRMqZ6YUOR6GiCuqPqmh9n3BDDIfAk+TWyt8Fzs
 Cv05ZRG8fray7JMF1O0Szqu6VQhfMh4didniG+Knxa4uIYjSZiLKgdnvVoPBFBdz3Awx
 YCzx5FlEmvdBC1yw77xQ8SQBnfUwiyyuyRN3dBbjmP+EZuxZk2zaRf0su4Ai2XKtW+lj
 DS2tF/okzKUzOC77oDXO+8Oq606BaBaAhoHeX3ic7mEdHTQ6loEzIBQRFFNK+5gSGWrf
 689DFjN9uzQ5JTJxi+xzLyQadLDMQxs7yW2404r2o/6jWpjmnAotLCJAReFT8Tpv97p1
 tw4Q==
X-Gm-Message-State: AOJu0YxrYm2jg09D7ZbPzvFKC92MXcWUtWAlC6fSPEEsxEd6uYBmro7H
 c1A1WXhbvDT04vJsdq3bYXBCxJKCmgFNPSXLje7V34J/0fJGwvPUXBVLxp3hJgODddDSer2N52C
 8dzXwF35ZSy1vlhlnujfeeFhwUPJltYvQihBS
X-Gm-Gg: ASbGncutgMWoMmwEUuYGWBL+TbnXvRImY41ICiBErlXd8jw3H2/vOdYNwZH8vjE6RT8
 A2NyBBN5evFa09woJ8fo1bbd5aSArtP8T9KzBkdg=
X-Google-Smtp-Source: AGHT+IFztnruuaQcAPf/zkAjzwAe8kb6c5fa/MVvWFY1l9jMF/Jyc3Hhm85aV+8iu2BiqOuE1vAIOcpN21g3I7KGKWI=
X-Received: by 2002:a17:907:86ac:b0:ab3:8b1:12aa with SMTP id
 a640c23a62f3a-ab308b117f8mr1300234466b.8.1736947160061; Wed, 15 Jan 2025
 05:19:20 -0800 (PST)
MIME-Version: 1.0
References: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
In-Reply-To: <8b798c6e-60a3-4ef3-8ce6-a747e072807a@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:19:08 -0700
X-Gm-Features: AbW1kva7kamH_DEpNc8bSubwR2wwVTuxm_qW750N36HllCEQiyOTeolh9-Unjhk
Message-ID: <CAFLszTj3O64xvA9buAfMf2RRRjwF5SjoOje+_1pWCT3QgV4Akg@mail.gmail.com>
Subject: Re: dtc: "syntax error" linked to &{label/subnode} syntax
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Patrice,

On Wed, 15 Jan 2025 at 03:19, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
> Hi
>
> I am currently converting STM32MP platforms to OF_UPSTREAM.
> As we use same binary for several boards, flags CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
> and CONFIG_OF_UPSTREAM_VENDOR="st" are set.
>
> So all dts/upstream/src/arm/st/* dts files are compiled.
>
> I am facing an issue with dts/upstream/src/arm/st/stm32mp151a-prtt1* and
> dts/upstream/src/arm/st/stm32mp15*-mec*.* files.
>
> To be more precise, these files are using a syntax which follows this
> format &{label/subnode} to override some nodes.
>
> This leads to DTC error:
>
>  AR      drivers/usb/gadget/built-in.o
>   LD      u-boot
>   OBJCOPY u-boot.srec
>   OBJCOPY u-boot-nodtb.bin
>   SYM     u-boot.sym
>   DTC     dts/upstream/src/arm/st/stm32mp157c-dhcom-picoitx.dtb
>   DTC     dts/upstream/src/arm/st/stm32h750i-art-pi.dtb
>   DTC     dts/upstream/src/arm/st/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dtb
>   DTC     dts/upstream/src/arm/st/stm32mp157a-iot-box.dtb
>   DTC     dts/upstream/src/arm/st/stm32746g-eval.dtb
>   DTC     dts/upstream/src/arm/st/stm32mp151c-mecio1r0.dtb
>   DTC     dts/upstream/src/arm/st/stm32mp157a-dhcor-avenger96.dtb
>   DTC     dts/upstream/src/arm/st/ste-nomadik-s8815.dtb
> Error: ../dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi:338.1-2 syntax error
> FATAL ERROR: Unable to parse input tree
>
>
> At line 338 in dts/upstream/src/arm/st/stm32mp15x-mecio1-io.dtsi we got :
>
> &{qspi_bk1_pins_a/pins} {
>         pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>                  <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>                  <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>                  <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>         /delete-property/ bias-disable;
>         bias-pull-up;
> };
>
> If i update it as following , the DTC compilation is OK :
>
> &qspi_bk1_pins_a {
>         pins {
>                 pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
>                          <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
>                          <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
>                          <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
>                 /delete-property/ bias-disable;
>                 bias-pull-up;
>         };
> };
>
> On kernel side, the DTC compilation is ok, but not on U-Boot side. I am not able to understand the difference.
>

Could it be that the kernel dtc is newer?

You could try DTC=`which dtc` if you already have that in your system.

Regards,
Simon
