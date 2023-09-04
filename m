Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9A5C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 12:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C78C863A8;
	Mon,  4 Sep 2023 14:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MheV1b5i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C208684C; Mon,  4 Sep 2023 14:10:24 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FE81847C3
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 14:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcc4347d2dso19480951fa.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693829420; x=1694434220; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SmCuo32UUMY3ew9+NERIkbjXnHhbCUkN3wHymWOjurs=;
 b=MheV1b5iPkKdXhOX7mJCkEXEfJxfPMmOO/dV/+Ec3gR6ymKHXYXV8pyci05A2gqki8
 c4Ae/FPti6W8r350iU6el5Opxib3eGW69nPPHxv2hN9/hN/se8Q3g8HBE9amQrjWIEIS
 tUIXJL+/vCzUYHmmzmlwj07DbSYSRJiwi5gunpJO+F061HDzrgXVOpxWFp7izYxGZdBM
 gNMQYk0On9FHrKCxDaKjH+Un7DLhq0mAYOdrTp7PHqvnOOjsSoJyu04ej4+aFfVDFhxV
 f26B5Ji6uuJyurv8pgjMp9ismZDGC8XMefIzEtcayA2rhI8Led8INAzaXhACXXVeMiuj
 66TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693829420; x=1694434220;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SmCuo32UUMY3ew9+NERIkbjXnHhbCUkN3wHymWOjurs=;
 b=fJXpIxTSkwHyrqXtLhYEQ1hZpFlvbwla8E9brBhR9fBemKhJfzD5w/4Hgr3yrY+kPH
 bIrUXqkrnBH+bQ2CH0nVM7E+UHDccYq96ISgyQEvRx1H+2ScmdqX3y1+kgr1F/faZdxw
 ltbKmh4lWc6HFYq1YOVixqjZ2BLhs74P9/ExBbofL/Vv6iuIdtj7vJSWIo9SMnswoQf7
 u03S7vTI4sVW2HVbvCj4yzDziUis/GsrkqJ8YNrXRCteRAp5s97awSJsJrHqMjb+gNSh
 RQbodnSzzI16SIIsKteebZyw+uznMBytfKOb331ZuBxLLg98O1mL0QaK4pfoMVoe/TRK
 YzCA==
X-Gm-Message-State: AOJu0YxTp2U8pJaEJ512KRtoyEc1j2UThFQP3f1zKainitF7w9pxw4CS
 ivgIfZfiuUy3jT+/jpuv+u8CeOMe7DKLaVNJSZc=
X-Google-Smtp-Source: AGHT+IF2yY7kNzCaJAiJyWvojQ/+1HoaBUY27kR1egOt6UhqQeTuZGjqR/8n3cygCdzABhLnqUuXrtUAwEkA1QJiR+A=
X-Received: by 2002:a2e:9f43:0:b0:2b9:b9c8:99 with SMTP id
 v3-20020a2e9f43000000b002b9b9c80099mr6900075ljk.22.1693829420352; 
 Mon, 04 Sep 2023 05:10:20 -0700 (PDT)
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 4 Sep 2023 13:10:09 +0100
Message-ID: <CALeDE9MLAxKXRZethKcxBKjocRmaFq2dNw0e-5TjHfSiPvryXA@mail.gmail.com>
Subject: Updates for RPi for 2023.10:
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

The following changes since commit 8999257f219d1e371c2fd66f255b8782897944d9:

  Merge tag 'doc-2023-10-rc4-2' of
https://source.denx.de/u-boot/custodians/u-boot-efi (2023-09-02
09:08:54 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/ tags/rpi-2023.10

for you to fetch changes up to fc2af2d978b525e188b15d909e321caf9445bdb0:

  arm: rpi: Switch to a text environment (2023-09-03 23:33:04 +0100)

----------------------------------------------------------------
Updates for RPi for 2023.10:

- rpi: Disable DISTRO_DEFAULTS
- arm: rpi: Switch to standard boot
- arm: rpi: Switch to a text environment

----------------------------------------------------------------
Simon Glass (3):
      arm: rpi: Switch to standard boot
      rpi: Disable DISTRO_DEFAULTS
      arm: rpi: Switch to a text environment

 board/raspberrypi/rpi/rpi.env  |  77
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 configs/rpi_0_w_defconfig      |   2 +-
 configs/rpi_2_defconfig        |   2 +-
 configs/rpi_3_32b_defconfig    |   2 +-
 configs/rpi_3_b_plus_defconfig |   2 +-
 configs/rpi_3_defconfig        |   2 +-
 configs/rpi_4_32b_defconfig    |   2 +-
 configs/rpi_4_defconfig        |   2 +-
 configs/rpi_arm64_defconfig    |   2 +-
 configs/rpi_defconfig          |   2 +-
 include/configs/rpi.h          | 134
--------------------------------------------------------------------------------------------------------------------------------------
 11 files changed, 86 insertions(+), 143 deletions(-)
 create mode 100644 board/raspberrypi/rpi/rpi.env
