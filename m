Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6713C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 18:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7B8988125;
	Sun, 14 Apr 2024 20:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gz/e0oWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B2088124; Sun, 14 Apr 2024 20:16:28 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF63788059
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 20:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-61816fc256dso19821077b3.0
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 11:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713118584; x=1713723384;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UWw3gNFU5ZjFP/fBn82lMfUQMOSFdPYHmW7npBuQ52g=;
 b=gz/e0oWYwsT3zf9v/GdX8uyhwhTKq+HEsrlTb6qEQi2ACu0mj/flXN1gQt9wIEnZ3r
 Xs8ov5dSIwT3tMyI1yL/VXabX9kP3Gn5jUHScImq9gZZMGbSOUkR0Y/yQXakA4FyczAh
 JMnF6MMIBGY2K2k/7OL+UN58QqGcY9GUtAZO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713118584; x=1713723384;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWw3gNFU5ZjFP/fBn82lMfUQMOSFdPYHmW7npBuQ52g=;
 b=wHdvC6S7jJYNrkF7wBW++EWn/X8Yg8VZjNynN5wTyVg/J6HMlessZUmMXLHyM3Bv2E
 A2KFxoi6EUpJx6urYJObc0lxtrkC0b3Y79SLrimfxHl3sp3FLV4dZE1oSFEblmiPu95U
 pLbZshdFZsBPPeoZW/VLeLHMros64jSUMRjibJJ9LDRQ5ekF/ZCYKswgY4yY/C9tJuFd
 gKemqy7WXA4C6utd1x6RU/lqtavTOf38qePUd9LMoT7IXm6F6xNXOFJ1VwC34fQQj/qC
 XxTu7LfuTDBCPPRH385/+LW3ZrWZY7Ja31jz5s4Zouk/aL4yxE84+CpX2+doBTTcoLPl
 mS1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/J+pMRUdoCegCaPhJy0kVWMR6HHFilGCvf2OYLhxajBqBQYIaK+IkUK+eCXkukrsXADUvyFI07g/G1UCkqMYyIJhffQ==
X-Gm-Message-State: AOJu0YwHxJ2WpdKSEagf2KKwjtMj44VIlCxXx67R6km7QRZOMaid8cfJ
 mfjX8Unw18MSA7F91or9loEn6CPZctGEIS+a71DS8N9AC9df6NTyjF0SCS2UbzkfyQsNLQtkiyk
 yeZ2yEQjTaCkz2Uv17yjilh7VUukfLAA9pEsttqBALEyqdouwqlToAA==
X-Google-Smtp-Source: AGHT+IGpcQlU5Ioye+OdZee1ZyU3meI/5A4h1wxOn7eT4lGg7jyZuyxryL3H7p8W78m7jX2BbxaPcX28j3PZml2dNDU=
X-Received: by 2002:a05:690c:1c:b0:618:822a:e69a with SMTP id
 bc28-20020a05690c001c00b00618822ae69amr6235411ywb.9.1713118584472; Sun, 14
 Apr 2024 11:16:24 -0700 (PDT)
MIME-Version: 1.0
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 14 Apr 2024 20:16:13 +0200
Message-ID: <CABGWkvodMc8TEMXSMJ2H1ij24YeLH=PmTgKV82Z=tEHRqxyCNA@mail.gmail.com>
Subject: [PULL] Pull request for u-boot-nand-20240414
To: Tom Rini <trini@konsulko.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Alexander Dahl <ada@thorsis.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Bruce Suen <bruce_suen@163.com>, Weizhao Ouyang <o451686892@gmail.com>
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

Hello Tom,

The following changes since commit 266603d8c39cf4d194e2cfe8d86d870590e150e0:

  Merge tag 'efi-2024-07-rc1-2' of
https://source.denx.de/u-boot/custodians/u-boot-efi (2024-04-13
10:18:38 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
tags/u-boot-nand-20240414

for you to fetch changes up to 248fc16055858c2028a381bb59e12354c4ae19ea:

  cmd: mtd: OTP access support (2024-04-14 08:49:40 +0200)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/20333

----------------------------------------------------------------
Pull request for u-boot-nand-20240414

The first patch is by Weizhao Ouyang and avoids sf probe crashes.

The second patch is by Arseniy Krasnov and adds basic support for Amlogic
Meson NAND controller on AXG.

The following four patches are by Alexander Dahl and apply some fixes to
drivers/mtd/nand/raw/ and port some changes applied in Linux.

The following patch is by Bruce Suen and adds support for XTX SPINAND.

Finally, the last patch is again by Arseniy Krasnov and adds access to
OTP region, supporting info, dump, write and lock operations.

----------------------------------------------------------------
Alexander Dahl (4):
      mtd: nand: raw: Use macro nand_to_mtd() where appropriate
      mtd: nand: raw: Port another option flag from Linux
      mtd: nand: raw: Fix (most) Kconfig indentation
      mtd: nand: raw: atmel: Fix comment in timings preparation

Arseniy Krasnov (2):
      mtd: rawnand: Meson NAND controller support
      cmd: mtd: OTP access support

Bruce Suen (1):
      mtd: spinand: Add support for XTX SPINAND

Weizhao Ouyang (1):
      cmd: sf: Fix sf probe crash

 cmd/Kconfig                                  |    7 +
 cmd/mtd.c                                    |  234 +++++++++++++++++++
 cmd/sf.c                                     |    5 +-
 drivers/mtd/nand/raw/Kconfig                 |  115 +++++-----
 drivers/mtd/nand/raw/Makefile                |    1 +
 drivers/mtd/nand/raw/atmel/nand-controller.c |    4 +-
 drivers/mtd/nand/raw/meson_nand.c            | 1248
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/nand_base.c             |    6 +-
 drivers/mtd/nand/spi/Makefile                |    2 +-
 drivers/mtd/nand/spi/core.c                  |    1 +
 drivers/mtd/nand/spi/xtx.c                   |  266 +++++++++++++++++++++
 include/linux/mtd/rawnand.h                  |    7 +
 include/linux/mtd/spinand.h                  |    1 +
 13 files changed, 1835 insertions(+), 62 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/meson_nand.c
 create mode 100644 drivers/mtd/nand/spi/xtx.c


-- 
Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
