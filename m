Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAA4C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A377588B0E;
	Tue,  6 Aug 2024 23:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BaDPnH//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F2C988AE4; Tue,  6 Aug 2024 23:51:09 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B10188AFA
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2cf11b91813so934858a91.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981056; x=1723585856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7Hf+4sLdxqUq0ruOjfrRQQxXZOoZdr/jePemre3J9s=;
 b=BaDPnH//MWDrdeBN+LH4+WnfCjyLKEdF+ydo03Idg9QtlW/7AO5oWAqOxEsQurp1IH
 DjAytjawso9Fis91oT0OiaZrsDfrTuiBzmdpPN0MXHiZhXc+oKExNLjbWIB7ynx5Ic2D
 JuOwMm3Vx6fEJiJV66lqwwnNRS90Gvdc9qU2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981056; x=1723585856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7Hf+4sLdxqUq0ruOjfrRQQxXZOoZdr/jePemre3J9s=;
 b=L9x54jSXT8+DCyhXYUyDYQbc+cM4S4GdwboDdKL4lxndEB2+07ZV/Jxc3Y9oAkjFkQ
 oNtHD9+KrZP8jmbc08nKUQCPsr8CToPP7tBPJ9/xbLfUlYVqn2IDyUrJl82UXthSc/DQ
 HcIwNH2dBMz4AM24tapoFP+MWtKVUTiRgfUqjwUf7Ay7gwVqKeDQju27tuSC8AJmQjH7
 tjrIA7umSE2xrW1+a4CarC5pCD2xAQ8iN5JYI1qzfJj0uOLTfGW0EPXGnHeC0m/5NwHy
 X4sARTklIyrTq5HWKCj3tDOuDWMp6qc91t2wf0ALxKmzEr7tgfhuRUvDwOpdS9wagtUG
 Dsqw==
X-Gm-Message-State: AOJu0YyfWEZ3MU5zhBL+bXdnl0jzl6eiDMZ+8TicWzhXkVq8+rytiKZ0
 isTt//misReJ8O16/grSjlhpxuKdy/djw/Xw3SagUrECpnXUFrNrAjsUPBpBBd7mJvJ6FNlkESN
 oCET3sHfQpL6eD1ardJO0iw2O+iu34QiZW1uW1vDYcoBhy/4=
X-Google-Smtp-Source: AGHT+IG6AdU3tiFj3DsQl7y1Wg7wiRqAFz5jeBhnt0KSFv2EfjuHRZZebE2II0UIY7YgkN64u2BlKbyOARMHhuchJIk=
X-Received: by 2002:a17:90a:898b:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cff93c8ebbmr15798903a91.6.1722981056107; Tue, 06 Aug 2024
 14:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
In-Reply-To: <75114aa0-2de7-4f5c-b764-0953ebf08263@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:44 -0600
Message-ID: <CAFLszTh2Am1AuROKKwBr6zCNF4QCZQG2Vd88R2WWYFpGkMwjzQ@mail.gmail.com>
Subject: Re: Selecting serial device for console
To: Fiona Klute <fiona.klute@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Fiona,

On Thu, 1 Aug 2024 at 08:07, Fiona Klute <fiona.klute@gmx.de> wrote:
>
> Hi everyone,
>
> how can I configure which of the available serial devices U-Boot will
> use for its serial console?
>
> Background: I have a device based on a Raspberry Pi CM4, which has 6
> UARTs (UART1 is a mini UART, the others PL011) [1]. In the default
> configuration (including the mainline Linux broadcom/bcm2711-rpi-cm4-io
> device tree) the Bluetooth module is attached to UART0. Unless I either
> completely disable UART0 (status = "disabled" in the device tree) or
> reconfigure it to be a serial console (e.g. using the RPi disable-bt
> DTBO) U-Boot fails to boot, I assume (it doesn't get far enough to show
> messages over netconsole) because it tries and fails to set up a serial
> console where there's a BT chip listening.
>
> That happens even if another serial console is available: With the RPi
> bcm2711-rpi-cm4 DTB plus "disable-bt" (disable the Bluetooth module,
> reconfigure UART0 as a serial console) and "uart1" (set up a serial
> console on UART1) DTBOs I can see that U-Boot discovers the serial
> device on UART1 (serial@7e215040):
>
> U-Boot> dm uclass serial
> uclass 108: serial
> 0   * serial@7e201000 @ 3af3b200, seq 0
> 1     serial@7e215040 @ 3af3b2d0, seq 1
>
> However, I can't find a way to make it *use* it instead of UART0
> (serial@7e201000). I tried to set CONFIG_CONS_INDEX=1 but didn't see any
> change (unfortunately the help does not describe exactly how the number
> is mapped to DT UART definitions). If I completely disable UART0 in the
> DT as mentioned above U-Boot uses UART1 just fine, so it's not an issue
> with UART1 as such.
>
> To make matters slightly more complicated, the specific device I have is
> a RevPi Connect 4, where a vendor overlay [2] describes how to set up an
> RS485 serial console using UART5. The pins defined there are wired to
> the outside of the box [3], so eventually I'll actually want to use
> UART5 for the serial console. Which means I really need a (build-time or
> preferably DT-based) way to configure which serial device to use.
>
> My goal is to create a single DTS which both U-Boot and Linux can use,
> and get it upstreamed if possible. If there are configuration options
> and they're just missing from the documentation, I'd be happy to send a
> patch to add them once I have a solution.

You should be able to update /chosen/stdout-path (in the devicetree)
to specify the UART you want, using its alias. So if you have a
'serial1' alias, you can set stdout-path to 'serial1'. This should
work in Linux too.

The code in question is serial_find_console_or_panic().

Regards,
Simon


>
> Best regards,
> Fiona
>
> [1]
> https://www.raspberrypi.com/documentation/computers/configuration.html#configure-uarts
> [2]
> https://gitlab.com/revolutionpi/linux/-/blob/4ae9a35871799004300f83694a24359a7b4ef8fa/arch/arm/boot/dts/overlays/revpi-connect4-overlay.dts#L281-292
> [3]
> https://revolutionpi.com/en/tutorials/uebersicht-revpi-connect/serielle-geraete-anschliessen-connect
