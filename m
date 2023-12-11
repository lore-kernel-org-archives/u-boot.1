Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB24C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2387877B7;
	Mon, 11 Dec 2023 18:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JH3BDBzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22261877B6; Mon, 11 Dec 2023 18:53:10 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5042886308
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5c08c47c055so46164197b3.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317185; x=1702921985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2DtlsHzRWNIFJaOEmuaALD9IrjLk+3bcYsEvH/be5jc=;
 b=JH3BDBzNF51gAxBMFdwjsF4fyacmG2SMliiTYg8bbc5LxugskXfuSHp78JbV4WI+Bn
 SgIBoF3ZBmtU5dT86Y8NS0GqvgQMtTorbuf6SwwJwASulzwUbi39n///9bWgqDa1xyrF
 AGJtSXsCLJBQuYFu7u8GNOYtga4QmUgbZtaBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317185; x=1702921985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2DtlsHzRWNIFJaOEmuaALD9IrjLk+3bcYsEvH/be5jc=;
 b=YAvSAEFP7KrctG3e9WI2tbJ0jndRGnZV8REXpQqPvcwFXV2yys7ZEfPh3VqOX8Jmq5
 uwcBCHJjAs50hxSlVFZUCr1yDWrTHKBANvPiPFOSebhM2qOuSV34z5hrd5FCMRaIA3yz
 YAQJKHvfSwMjsngED+yyA6RTHCwTaeq9jUBMt84BD39EWHTtNNs+U/E/ZwSLOCCi0h/b
 HTWryl7pknaLVLa5NNw79SiWS7hNuaiYlJGTTsC0YNK4NphCi15jWmhkHWh3HaIdcqMb
 bFSauWiib3V2qf2HReoopzEImTOnnb4E53a41vnjYR3loJzUrj+RGeANSZ2SkvkyDBah
 ao/A==
X-Gm-Message-State: AOJu0YzX9YLVhiYqV4xvH77/Z2/NlwhJ5RJXuTQ5gwD4ujyaoOXqBNl4
 MQZIdoCYV+piB7hJtZl7L0R4/dJNzbRKPpSzuc7Rvw==
X-Google-Smtp-Source: AGHT+IEo5m2WKLyNjiIvD/muzpERGL0z4VC4gLidF/nCWKzSft+/cB4mRZDc1tL5JZI9ZIWTUif0V9Cm3HuHmDP5GN8=
X-Received: by 2002:a25:5f03:0:b0:dbc:1b67:e358 with SMTP id
 t3-20020a255f03000000b00dbc1b67e358mr3317429ybb.95.1702317184836; Mon, 11 Dec
 2023 09:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231207142819.1511709-1-michael@amarulasolutions.com>
In-Reply-To: <20231207142819.1511709-1-michael@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:23 -0700
Message-ID: <CAPnjgZ0qGCRvN_XPTzd4gC8Muz+EKLLM_=iGjCk-OupCFHZ60Q@mail.gmail.com>
Subject: Re: [PATCH] pxe_utils: Increase feedback to user when fdt file is not
 found
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 linux-amarula@amarulasolutions.com, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
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

On Thu, 7 Dec 2023 at 07:28, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> extlinux.conf can set fdtdir. fdtdir look for fdt file using
> information found in the enviroment variable. The function does
> not report any error in the case the file is not found
>
> Scanning for bootflows in all bootdevs
> Seq  Method       State   Uclass    Part  Name                      Filename
> ---  -----------  ------  --------  ----  ------------------------  ----------------
> Scanning global bootmeth 'efi_mgr':
> No EFI system partition
> No EFI system partition
> Failed to persist EFI variables
> Scanning bootdev 'mmc@fa10000.bootdev':
>   0  extlinux     ready   mmc          1  mmc@fa10000.bootdev.part_ /boot/extlinux/extlinux.conf
> ** Booting bootflow 'mmc@fa10000.bootdev.part_1' with extlinux
> 1:      am62x-sk-buildroot
> Retrieving file: /boot/Image
> append: console=ttyS2,115200n8 root=PARTUUID=c586a30c-0bf1-4323-aba8-779c814ee135 rw
>                 rootfstype=ext4 rootwait earlycon=ns16550a,mmio32,0x02800000
> Retrieving file: /boot/k3-am623_ccm_m3.dtb
> Skipping fdtdir /boot/ for failure retrieving dts
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  boot/pxe_utils.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
