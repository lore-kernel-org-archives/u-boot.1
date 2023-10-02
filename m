Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED54E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 12:43:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEA5186DE7;
	Mon,  2 Oct 2023 14:42:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=conclusive.pl header.i=@conclusive.pl header.b="QWrZlpn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E51386DDA; Mon,  2 Oct 2023 14:42:59 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D0B870D1
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 14:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=conclusive.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=artur@conclusive.pl
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5048156976cso9174502e87.2
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=conclusive.pl; s=google; t=1696250575; x=1696855375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=naZKIxazljAM0dlzjnImoue9SR3PqPkmRLn+Qyap2gM=;
 b=QWrZlpn4Os/4EjQaHYybghkBNdjXnRC8QRhD1uj8KjzjPDZ1vQqPs+1p462jVzMa2z
 kvEWRTvhu9gjVA7GLQRdguM3VcTtR6EGgOwDTE60Bgtq5I3Qbutprn3pfFU09f0bIhPl
 bFtNsv+3/02MhdDUO0fj6gWZvduFTTou7s+R9fujG7PpFAoOnOuqHHlj8B3qS0/hn972
 WALgNIid7dnnmEO6cNuuNdI3c1Bqjq+vhO690+HTeOuULyYU0Ps5dl23w+oGX1b/YDws
 VYr5UsNqjoUoG6HjwtVh135n9p7KzYcciimculr+yok4bm9BJxicxTtkSsu7L4QahWFT
 DQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250575; x=1696855375;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=naZKIxazljAM0dlzjnImoue9SR3PqPkmRLn+Qyap2gM=;
 b=DyFRQkSInzZr5LlUoWI6xeee53kv3ftDdzGMa3SRsdCIRZ7HIKdFx6B1o628iK4vrf
 9cb5ZCwMjD4UfQQasUGfr/CAA9ynzPr4ZYOXA0LEns3clcT/XaZEH7jLpkIN0mfg1NPv
 /zAV+UPau9NNCmePQe1Xg5g/Qp2HgmPz4BV6Uri6u1RUsQY1otntkoazsBBNVhE3LG7f
 esAXeeAqXBjBzBniy6vFgD+wbkeIRnhVx0ZHqXbAyz+OWB9clrf3c00PTu0cg+oXIW4K
 G5gYY/DhGcKM9vYEok960Y/gwtWQ/ZcBrF5bxMRjUHpvNXaZJKPVUVxfWSmKjMWZcYi8
 0AbA==
X-Gm-Message-State: AOJu0YwQre7OoqEnK4FUb1tD2qxPf1RDCyaudSv9eB1eGprB8WznLsG3
 wja63N7X2lZKIeBvJ+Dc+SWuZA==
X-Google-Smtp-Source: AGHT+IGtZUqrM5oXql+wJfdL5ncpzYsxY4bmlUPmIaRjJyGttnCtjPXSsrspyfw3NP5gYMqKuvt43A==
X-Received: by 2002:ac2:5e3a:0:b0:502:ffdf:b098 with SMTP id
 o26-20020ac25e3a000000b00502ffdfb098mr7886527lfg.6.1696250574597; 
 Mon, 02 Oct 2023 05:42:54 -0700 (PDT)
Received: from localhost.localdomain (host-89.25.128.123.static.3s.pl.
 [89.25.128.123]) by smtp.gmail.com with ESMTPSA id
 e8-20020ac25468000000b004faa2de9877sm4719316lfn.286.2023.10.02.05.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 05:42:54 -0700 (PDT)
From: Artur Rojek <artur@conclusive.pl>
To: Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Marcin Jabrzyk <marcin@conclusive.pl>
Cc: Wojciech Kloska <wojciech@conclusive.pl>,
 =?UTF-8?q?Rados=C5=82aw=20Adamczyk?= <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de, Artur Rojek <artur@conclusive.pl>
Subject: [PATCH v3 0/4] Conclusive KSTR-SAMA5D27 support
Date: Mon,  2 Oct 2023 14:42:13 +0200
Message-ID: <20231002124217.68220-1-artur@conclusive.pl>
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

this is v3 of the Conclusive KSTR-SAMA5D27 support series.

Patch [1/4] now takes a different approach at reading the EEPROM serial.
An existing CONFIG_ID_EEPROM option provides a mechanism for reading
EEPROM embedded MAC addresses at init. As this option is meant for
reading various identifying features, not just MACs, I've decided to
expand it by the ability of reading serial number, adding a generic
serial_read_from_eeprom(). For tlv eeprom, this wraps around existing
populate_serial_number(), which now becomes local to tlv_eeprom.c.
Other boards which enable CONFIG_ID_EEPROM, but don't store EEPROM data
as tlv, will need to provide their own implementations of
serial_read_from_eeprom(). A dummy weak function has been provided to
prevent compilation issues on such boards.

Simon, you've already accepted the solution from v2, however changes
required for [4/4] have forced me to go with this new approach.

Patch [2/4] is new. CONFIG_ID_EEPROM requires that the do_mac() command
exists, however implementation of this function has been missing from
tlv_eeprom. This patch adds a bare minimum support for it - only
handling the "mac read" flag. KSTR-SAMA5D27 is supposed to use EEPROM
embedded MAC addresses, however this feature has been overlooked in
previous versions of this series.

Patch [3/4] remains unchanged.

Patch [4/4] now uses CONFIG_DISPLAY_BOARDINFO_LATE in order to display
the board model and S/N. As a side effect of that, serial access has
been moved to CONFIG_ID_EEPROM (see patch [1/4]) and BOARD_LATE_INIT
mechanism dropped as unnecessary.

The kstr_sama5d27_defconfig has also been re-generated with
savedefconfig, which got rid of some redundant flags.

Artur Rojek (4):
  common: Add generic function for reading serial number
  cmd: tlv_eeprom: Add support for do_mac() command
  arm: dts: at91: sama5: Add flexcom4 node
  board: Add support for Conclusive KSTR-SAMA5D27

 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/at91-kstr-sama5d27.dts           | 131 ++++++++++
 arch/arm/dts/sama5d2.dtsi                     |  20 ++
 arch/arm/mach-at91/Kconfig                    |  12 +
 board/conclusive/kstr-sama5d27/Kconfig        |  15 ++
 board/conclusive/kstr-sama5d27/MAINTAINERS    |   8 +
 board/conclusive/kstr-sama5d27/Makefile       |   5 +
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  | 230 ++++++++++++++++++
 cmd/tlv_eeprom.c                              |  76 ++++--
 common/board_r.c                              |   8 +
 configs/kstr_sama5d27_defconfig               |  74 ++++++
 include/configs/kstr-sama5d27.h               |  15 ++
 include/init.h                                |  14 ++
 13 files changed, 595 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/dts/at91-kstr-sama5d27.dts
 create mode 100644 board/conclusive/kstr-sama5d27/Kconfig
 create mode 100644 board/conclusive/kstr-sama5d27/MAINTAINERS
 create mode 100644 board/conclusive/kstr-sama5d27/Makefile
 create mode 100644 board/conclusive/kstr-sama5d27/kstr-sama5d27.c
 create mode 100644 configs/kstr_sama5d27_defconfig
 create mode 100644 include/configs/kstr-sama5d27.h

-- 
2.42.0

