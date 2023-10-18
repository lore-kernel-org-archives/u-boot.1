Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C277CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEB786FB8;
	Wed, 18 Oct 2023 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="Jo5zyhcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE1D86FBA; Wed, 18 Oct 2023 16:01:41 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E786886F94
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c509d5ab43so76768411fa.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1697637698; x=1698242498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pMjnT9FAv0SobZQArQB7Tio/DeuRbWjYE7GkzZ/1NLE=;
 b=Jo5zyhcR2wUXEFfRrVKN9NmLNA8I6uVcr8st6cFmfVLAlIR3KGmFMZJ4ea1LSxRJlg
 YK2OimgA3FDEHkR+d8r6KFtz4kJ8EKDg4EX8xElbW3g7vrmOPwDI222SZf6sSia74E7Q
 +sGMzUaAjNImfd6OQqktmt5mzMO8RML2QjS+QAHyST75Tda0HoOpfNVure52Wv9pzeXC
 0+Q4GSr1jWQ6I6MPXHmrcjaE8gM33YL8l8kv62H2/IzDi5HP9lGpYr8oFgz0qesrReah
 dWa806fU6oGs0yB5UhNKi1We3hWJSdDFLg6e2X+A1/+9NeviV2o1Eq0EHl6kwhqdSGYq
 W8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637698; x=1698242498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pMjnT9FAv0SobZQArQB7Tio/DeuRbWjYE7GkzZ/1NLE=;
 b=kBa12jK9g9owggSOxmIoC/HXTD3Vvre0PC83nzpWUEaT80ieOwbFvoY8RiPTY1WRFV
 svharThoYSEJ7cY3n1lEgdTXB7KGNx0O6d0TXmq7csVFMThBeZ8jlqXiYbl4RNlMxvyN
 lluuE5UDYGmeX55zHw2r6UuveV6v7UT60ZMqmeDYKNeXdpnHA0+w9ltQKuB1FdXMPLfa
 QOMlDWRIAKeecaR9bLiJz1MLfxVOLwV1LPSv3bjyGIYZ8mM6MAZYQ/sVfNVPnFZWBU5C
 M4iYpAxTLkDAEqH2giLw747rynDu16sVqm9y11U502WAxJsdohxT8fTXC+29gFNylCpc
 jpNg==
X-Gm-Message-State: AOJu0YzqsNsgti/91oyqKeFw9myVeQkw7zvZ17w838yBsXNI+M0herqm
 I2NgS8xKmqVKAWL4q2ptQ4SXHA==
X-Google-Smtp-Source: AGHT+IF8x/GFeMGGq6gigqKacPF3evoLoCIZ1rD3C7+esQ2yYXJq3oEAYrk7ZP4pIjeX/wzMtvGq5Q==
X-Received: by 2002:a2e:7a05:0:b0:2c0:e7c:bf74 with SMTP id
 v5-20020a2e7a05000000b002c00e7cbf74mr4526746ljc.12.1697637697925; 
 Wed, 18 Oct 2023 07:01:37 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 f2-20020a05651c03c200b002b9bf5b071bsm718692ljp.20.2023.10.18.07.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:01:37 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v5 0/4] Conclusive KSTR-SAMA5D27 support
Date: Wed, 18 Oct 2023 16:00:55 +0200
Message-ID: <20231018140059.161169-1-artur@conclusive.pl>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this is v5 of the Conclusive KSTR-SAMA5D27 support series.

Patches [1/4], [2/4] and [3/4] remain unchanged.

In patch [4/4], a new dtsi file has been added in order to keep U-Boot
specific properties separate from the main dts. As such, MAINTAINERS has
been modified to feature the new file.

An alias to the i2c node holding the EEPROM has also been explicitly
added, so that it always enumerates at bus 2.

Artur Rojek (4):
  common: add prototype & rename populate_serial_number()
  event: add new EVT_SETTINGS_R event
  arm: dts: at91: sama5: Add flexcom4 node
  board: Add support for Conclusive KSTR-SAMA5D27

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/at91-kstr-sama5d27-u-boot.dtsi   |  42 +++
 arch/arm/dts/at91-kstr-sama5d27.dts           | 127 ++++++++++
 arch/arm/dts/sama5d2.dtsi                     |  20 ++
 arch/arm/mach-at91/Kconfig                    |  12 +
 board/conclusive/kstr-sama5d27/Kconfig        |  15 ++
 board/conclusive/kstr-sama5d27/MAINTAINERS    |   9 +
 board/conclusive/kstr-sama5d27/Makefile       |   5 +
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 239 ++++++++++++++++++
 cmd/tlv_eeprom.c                              |  14 +-
 common/board_r.c                              |   1 +
 common/event.c                                |   1 +
 configs/kstr_sama5d27_defconfig               |  73 ++++++
 include/configs/kstr-sama5d27.h               |  15 ++
 include/event.h                               |   9 +
 include/init.h                                |  14 +
 16 files changed, 586 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27-u-boot.dtsi
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
 create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
 create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
 create mode 100644 board/conclusive/kstr-sama5d27/Makefile
 create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
 create mode 100644 configs/kstr_sama5d27_defconfig
 create mode 100644 include/configs/kstr-sama5d27.h

-- 
2.42.0

