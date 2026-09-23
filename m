Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD59C98310
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 02:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0A4F60B21;
	Thu, 24 Sep 2026 02:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4TUX30XfSZXJ; Thu, 24 Sep 2026 02:56:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD49660B24
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790218568;
	b=pWnZruYNYB60yAYEjDX9RWGpCscwhacJMHnudngbzvbmJ9qY2otFTjxAgLczveiZDd5e
	 bGuHElQedGfGZTx1oICI/aXVkm6I7tOXjDWWULjGpYXI147UsJErZnocuCIvDY9AHqqU8
	 citT/LkBmNa9rnB2OOmjhItndO6My00RWVpA1QbV4lEmogC7Ps+Bq7yjWTR+4D3iYGpvS
	 i87xAPcRl9XVhvFCnZb5OyrDEeHoOPjfyd3Oaavh8tuWV10RDzk43xs3uFZbP431lqoya
	 lpCBRhrEmfku7gII0gtKa2IkC4KniuOsxl3VdbH7AP0iS+xdhDxErCMlzUsZphnK0xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790218568;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AzUhKPrwck1vUtAHoGlYKLyKjypRFgLWfA8VyP/aqDA=;
	b=AVCquq25/rDaIOPp2zrtNS0Z3tvxlwE4peAJHxAhL/Z/fohS2ROyuRmNvHvmWL7tepR9
	 lvMXThYR7+nsLdg2nGOfTJuk2petPoyXb1DKeTOGLyVosaMSGSpwMHdNAZ0OHO9OPJzR0
	 7cfOS5tnp78VRw91zEzwSJdzsXzWgLmngPqu1kfVk1A7iBN89KwpiDV5pjIUYeDX0kLAq
	 EFTEz/Sj/VOJhCQm31L9aGEJwgYhgfElqLTAcbbIek9DaA8adpj76xUmL1hLY7lfKxCTL
	 Te3Qx6RUBK6yM30ZirtfU5jRRD/9oH/lYoO3v0XdSlooyCoukUV/zA/Mtfu6jbR1HPQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hr9GtTJh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790218568;
	bh=AzUhKPrwck1vUtAHoGlYKLyKjypRFgLWfA8VyP/aqDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bEA+py+czoWvEqGVx7pEbQZzWLeWgMOPp+b5fRlR0qCs+P0r7EsLPlIbN9pOig6M/
	 OZ5QP28ONo+mP2Erb0+u6h2vaAAhJNc6YcBWN1Zon7SRggAlnzRkVOjt0b32OKARs8
	 GI2Vnm33Ccz2gGsQQoOx0o5CssKuuLUbP/CvTeigKSwmuUGF5McF5yHHDSYLzkmwrG
	 VHnc2JFz74fp/SX5+52ErcII39hks2rPXm5yTncmiFje1qNgp9q/YHbueVV/4yQp6A
	 j5MWZVZCf595YHxSK73zsS7v9mIoycriOKa+OVhaOcjdp7T8NHAshH2G7ZuPMs0ZFe
	 ryTxo++9GAZKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD49660B24;
	Thu, 24 Sep 2026 02:56:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B54477F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07922608B5
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AdkY_d1CJcPI for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:40:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2340C60890
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199647;
 b=R9UpvnCXy/bQhEruCthX0kGnYOXQPRvLbveG8Iaax2Nl3CfEwHOPEt9RERlmUf7M3uhc
 jwoIkZc7bjRamJUPAK5tEpaJxkAk7yAm1y4Npjbix5bbB5pbzualfbr/nabviHF+cdI3/
 F9qGrY4iilqVWGwUI6evMleMCc2EUiLdZPDCSB1+D2cHFOvd/9DHN81KZHHt6lekUXFPF
 1xF8XOLZhLNKnVQrbtw/kap6MO+TbxV8fK8qETuJGQtIWhldMXrwBEHXlMmXeAB/V87PF
 e7hx2kYWq5IuD8O6zWkm4CqgZ8zXzj4jDodhkB4nGeItLrgnIBeiC8FE19cQlJH3POw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199647;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=AzUhKPrwck1vUtAHoGlYKLyKjypRFgLWfA8VyP/aqDA=;
 b=e26iGyKeWcz0uRMdff/1xu5PN8+2vk4UxQBEbSLHhar0JVZfcURqNaqyLu0VJv6VFcaj
 oJxGnKnFw6IyjmvMQVJrhzItyBNE3uzhP7Do8L33IvsjJUZWpCrMuChWLjqjYuMmBAxfz
 5IXVAO/QoT/7mmhilX/ITys0PVH+2CNWGVw+FhBXuvNxBDd3Rb+hzopiNT5yu8Knubw+Y
 nFwtbOP4N050W08W154hzM42ZA/IjwL3VYSQFC1m5Q+sCU3wNpG1XZnE8pfRqgMAcuIWy
 C3inXdiBlheD9QUnCzy5lY6njqfskuVPzU7wVXSiAhz2Fxlwh44x7TGyp01Bl09PaEA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Hr9GtTJh; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hr9GtTJh
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2340C60890
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:40:46 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so943379f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199645; x=1790804445;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AzUhKPrwck1vUtAHoGlYKLyKjypRFgLWfA8VyP/aqDA=;
 b=Hr9GtTJhk17Ejv3Rrjfg6NsDMPz1/A9qAcZfMrMvt5Ohi/nnn6/MwEP/k2HugD3fhN
 Svk49R7ICcRva77ISFtRC1eZPJCEyxdI5VLaJHY+ufMxqteeqpeGPpFlgRNHhxpzou0r
 EkIVuKLMyZGGMqNoq49tFs9QEr2dsbSAax8S0gPJRup1FtYOwHbP9dRkKrDuSK4hJR0B
 uC+ufrl5s5ibCCZoxiEN5BeC9mrqFE6aPPjY46dvImBYHk25SV7u6swH7Lt/deY3+u6W
 WGU2nGoQWga+U4GVXgWgXiq+++M3fX4QxAXVF68FJWH1yr0JbCNML62zYDsJU9hAu+/l
 Z2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199645; x=1790804445;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AzUhKPrwck1vUtAHoGlYKLyKjypRFgLWfA8VyP/aqDA=;
 b=a8WnBqOjaZg7OzYSr9xBTqRcK2hWZlMO1maxNWGkG8Ka0NnAAgfCakggoeltmeIGSJ
 T7kDRHt1fPRmG/D+MQ8q4x8JeZykOElCrThgfgmr4ZNh8cpRfSit7v7fUbJrIHInF8e4
 LQ7p/PF9cVsKIL3bJf5wr7hQwOlHarRBD1Djv49cZpDQii7//zy/iCfqgCcbtlvHjnO+
 dMhcp1/dNwbMlCS+eBOdkzto48QjacKcmkYLW5q3OSHMNi8XCAplDsw4WU28A0TL4lJ4
 /oo/gUmLeby83/4/hJabz1QkQk4+ie9rChOmTGxb6THDSMHX1SvHGZfeo5iD+G3XbWzL
 jQUA==
X-Gm-Message-State: AFuF++mKez8UWY/5GLGzD4LJKtluVrOHNOX8jCcW3cyYV1KRaGNR5iS7
 lhuKqazUqMYVxMsx2/VJXhNCk7vdx465iKqWoNh5k28g/Zt2jx7urf5/6XBqDMCqWDA=
X-Gm-Gg: AYBFou1ZcHAYYqFWQkLNFZIfYgqDhlvH5/wHdMo3uMRcKxTo71arVkGgZRe99szG9IG
 6MT4r3AQOinjqz1LbW59+0TuHyr3r8AB8jdt33i3pfo6gK+qzS1ha1bWjOdO3klqOcD/7RJAFY2
 6bNkAITSqBLpaLrXMdIiyI8CAqTcMV55QkLAoTUPfIVybreo0wZhPY2dfWqFWDLo19qpedryI8W
 4J7FP3MELNYZRBwsJIjDK9jzat7UG3JSP1vWbJUv9RSHxGg/FnGsrqr0QGtbIzKw9WBbVKgRaAi
 1rma96RMnixpnXpoWfmcbueMjkA8TOKsW5bY45wQxgxuvD5Ks2G1a9o0yLTAVb0PvtKcyBhn5ua
 aYJT1bAAPXdnRpTUX/7/tM8bYwfvBZsSTFMb8l3rjzAya2/39LAW78XE56vyjEf1pqXL6TGXRQW
 RQDihHbFobSHhFgNDm9GADHEFNtuDhFVsNVLAwW2V4m3msvhLis+vrUGsmhhvA4J5Mw27IZGHOb
 m/4fZD+/8FLJfTHbqa8T4qjlt3ByfFidlNII/ei+9dcas3GAk+XDQ+YP+4=
X-Received: by 2002:a05:6000:2088:b0:487:27f6:a4e9 with SMTP id
 ffacd0b85a97d-488716c3819mr656942f8f.57.1790199644785; 
 Wed, 23 Sep 2026 14:40:44 -0700 (PDT)
Received: from rrouwprlc0373.. ([81.172.79.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c119sm10309950f8f.15.2026.09.23.14.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:40:44 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org,
 =?UTF-8?q?Jo=C3=A3o=20Loureiro?= <joaofl@gmail.com>
Subject: [PATCH v6 2/3] spi: Introduce initial driver-model support for SPI
 EEPROMs
Date: Wed, 23 Sep 2026 23:40:29 +0200
Message-ID: <91bb73a43793518638d85208944d9f2e37459e31.1790198142.git.joaofl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790198142.git.joaofl@gmail.com>
References: <cover.1790198142.git.joaofl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 02:56:02 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

U-Boot has driver-model support for EEPROMs on several buses - I2C
through UCLASS_I2C_EEPROM and 1-Wire through UCLASS_W1_EEPROM - but
nothing for SPI, even though SPI EEPROMs are common and are usually the
faster part of the two.

These devices typically hold a board's identity: its serial number, a
unique device ID and the hardware variant. U-Boot needs that early,
both to decide which device tree and overlays to load for the variant
it happens to be running on, and to hand the unique IDs to the system
it is about to boot. Today a board that wants any of this has to
open-code raw SPI transfers in board code, which is neither reusable
nor testable.

Introduce a UCLASS_SPI_EEPROM uclass with read/write/size operations,
analogous to the I2C EEPROM uclass, along with a driver for AT25-style
parts. The chip geometry - total size, page size and address width - is
taken from the device tree as described by the atmel,at25 binding in
dts/upstream/Bindings/eeprom/at25.yaml, which requires those properties,
falling back to per-compatible defaults held in driver data. Devices
using 8-, 16- and 24-bit addressing are therefore all covered, and
adding a part later is a driver-data entry rather than a change to the
uclass API. The 9-bit addressing mode the binding also allows, where the
ninth address bit travels in the opcode, is not implemented.

Only reading is implemented for now; spi_eeprom_write() returns -ENOSYS.
Enable the uclass in sandbox_defconfig so that the emulator and DM test
added by the next patch are built.

Signed-off-by: João Loureiro <joaofl@gmail.com>
---
 MAINTAINERS                    |   7 +
 configs/sandbox_defconfig      |   1 +
 drivers/misc/Kconfig           |  15 ++
 drivers/misc/Makefile          |   1 +
 drivers/misc/spi_eeprom.c      | 267 +++++++++++++++++++++++++++++++++
 drivers/misc/spi_eeprom_priv.h |  18 +++
 include/dm/uclass-id.h         |   1 +
 include/spi_eeprom.h           |  95 ++++++++++++
 8 files changed, 405 insertions(+)
 create mode 100644 drivers/misc/spi_eeprom.c
 create mode 100644 drivers/misc/spi_eeprom_priv.h
 create mode 100644 include/spi_eeprom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index eb4209bdea6..c45c47000c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1708,6 +1708,13 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-spi.git
 F:	drivers/spi/
 F:	include/spi*
 
+SPI EEPROM
+M:	João Loureiro <joaofl@gmail.com>
+S:	Maintained
+F:	drivers/misc/spi_eeprom.c
+F:	drivers/misc/spi_eeprom_priv.h
+F:	include/spi_eeprom.h
+
 SPI NAND
 M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
 M:	Michael Trimarchi <michael@amarulasolutions.com>
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ca73080b06d..78ba1532ced 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -267,6 +267,7 @@ CONFIG_SYS_NAND_USE_FLASH_BBT=y
 CONFIG_NAND_SANDBOX=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_SYS_NAND_PAGE_SIZE=0x200
+CONFIG_SPI_EEPROM=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_BOOTDEV_SPI_FLASH=y
 CONFIG_SPI_FLASH_ATMEL=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 44415f24ae1..8409635ef17 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -567,6 +567,21 @@ config I2C_EEPROM
 	help
 	  Enable a generic driver for EEPROMs attached via I2C.
 
+config SPI_EEPROM
+	bool "Enable driver for generic SPI-attached EEPROMs"
+	help
+	  Enable a generic driver for EEPROMs attached via SPI.
+
+	  This provides the UCLASS_SPI_EEPROM uclass together with a driver
+	  for AT25-style parts, i.e. devices described by the "atmel,at25"
+	  device tree binding. The chip geometry (size, pagesize and
+	  address-width) is read from the device tree, with per-compatible
+	  defaults for the parts listed in the driver. Parts using 8-, 16-
+	  and 24-bit addressing are supported; 9-bit addressing, where the
+	  ninth address bit travels in the opcode, is not.
+
+	  Only read access is implemented at present; spi_eeprom_write()
+	  returns -ENOSYS.
 
 config SPL_I2C_EEPROM
 	bool "Enable driver for generic I2C-attached EEPROMs for SPL"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..8c9f8eb9cfa 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_GDSYS_SOC) += gdsys_soc.o
 obj-$(CONFIG_IRQ) += irq-uclass.o
 obj-$(CONFIG_SANDBOX) += irq_sandbox.o irq_sandbox_test.o
 obj-$(CONFIG_$(PHASE_)I2C_EEPROM) += i2c_eeprom.o
+obj-$(CONFIG_$(PHASE_)SPI_EEPROM) += spi_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c
new file mode 100644
index 00000000000..3c64c0ef9f5
--- /dev/null
+++ b/drivers/misc/spi_eeprom.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_SPI_EEPROM
+
+#include <dm.h>
+#include <spi.h>
+#include <spi_eeprom.h>
+#include <linux/err.h>
+
+#include "spi_eeprom_priv.h"
+
+/* Longest address accepted by spi_eeprom_std_read(), in bytes */
+#define SPI_EEPROM_MAX_ADDR_LEN		3
+
+/**
+ * struct at25_chip - geometry defaults for an AT25-style EEPROM
+ *
+ * The atmel,at25 binding (dts/upstream/Bindings/eeprom/at25.yaml) requires
+ * "size", "pagesize" and "address-width" to be present in the device tree.
+ * These values are used when a device tree omits them, and are all zero for
+ * the generic "atmel,at25" compatible, where nothing can be assumed.
+ *
+ * @size:	Total capacity in bytes
+ * @pagesize:	Write page size in bytes
+ * @addr_len:	Number of address bytes sent after the command opcode
+ */
+struct at25_chip {
+	u32 size;
+	u32 pagesize;
+	u8 addr_len;
+};
+
+int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf, int size)
+{
+	const struct spi_eeprom_ops *ops = device_get_ops(dev);
+
+	if (!ops->read)
+		return -ENOSYS;
+
+	return ops->read(dev, offset, buf, size);
+}
+
+int spi_eeprom_write(struct udevice *dev, int offset, const u8 *buf, int size)
+{
+	const struct spi_eeprom_ops *ops = device_get_ops(dev);
+
+	if (!ops->write)
+		return -ENOSYS;
+
+	return ops->write(dev, offset, buf, size);
+}
+
+int spi_eeprom_size(struct udevice *dev)
+{
+	const struct spi_eeprom_ops *ops = device_get_ops(dev);
+
+	if (!ops->size)
+		return -ENOSYS;
+
+	return ops->size(dev);
+}
+
+static int spi_eeprom_read_cmd(struct udevice *dev, u8 *buf, int size,
+			       const u8 *cmd, int cmd_size)
+{
+	struct spi_slave *slave = dev_get_parent_priv(dev);
+	int ret;
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret) {
+		log_err("Failed to claim SPI bus: %d\n", ret);
+		return ret;
+	}
+
+	/* Send the command, keeping the transaction open */
+	ret = spi_xfer(slave, cmd_size * 8, cmd, NULL, SPI_XFER_BEGIN);
+	if (ret) {
+		log_err("Failed to send command: %d\n", ret);
+		goto release;
+	}
+
+	/* Read the data back and close the transaction */
+	ret = spi_xfer(slave, size * 8, NULL, buf, SPI_XFER_END);
+	if (ret)
+		log_err("Failed to read data: %d\n", ret);
+
+release:
+	dm_spi_release_bus(dev);
+	return ret;
+}
+
+/*
+ * Read the status register. Returns the register value on success or a
+ * negative error code on failure.
+ *
+ * Status register layout (AT25-style devices):
+ *   Bit 0    Ready/Busy: 1 while an internal write cycle is in progress
+ *   Bit 1    Write Enable Latch
+ *   Bits 2-3 Block write protection
+ *   Bits 4-6 Reserved
+ *   Bit 7    Write-protect enable
+ */
+static int spi_eeprom_read_status(struct udevice *dev, u8 *status)
+{
+	u8 cmd = AT25_CMD_READ_STATUS;
+
+	return spi_eeprom_read_cmd(dev, status, 1, &cmd, 1);
+}
+
+static int spi_eeprom_std_read(struct udevice *dev, int offset, u8 *buf,
+			       int size)
+{
+	struct spi_eeprom *priv = dev_get_priv(dev);
+	u8 cmd[1 + SPI_EEPROM_MAX_ADDR_LEN];
+	int i;
+
+	if (offset < 0 || size < 0 || offset >= priv->size ||
+	    size > priv->size - offset) {
+		log_err("Read out of bounds (offset %d, size %d, max %lu)\n",
+			offset, size, priv->size);
+		return -EINVAL;
+	}
+
+	cmd[0] = AT25_CMD_READ_DATA;
+	for (i = 0; i < priv->addr_len; i++)
+		cmd[1 + i] = offset >> (8 * (priv->addr_len - 1 - i));
+
+	return spi_eeprom_read_cmd(dev, buf, size, cmd, 1 + priv->addr_len);
+}
+
+static int spi_eeprom_std_size(struct udevice *dev)
+{
+	struct spi_eeprom *priv = dev_get_priv(dev);
+
+	return priv->size;
+}
+
+static const struct spi_eeprom_ops spi_eeprom_std_ops = {
+	.read	= spi_eeprom_std_read,
+	.size	= spi_eeprom_std_size,
+};
+
+/* Geometry is described by the device tree for the generic compatible */
+static const struct at25_chip at25_generic = { };
+
+static const struct at25_chip mchp_25aa010a = {
+	.size		= 128,
+	.pagesize	= 16,
+	.addr_len	= 1,
+};
+
+static const struct at25_chip mchp_at25160bn = {
+	.size		= 2048,
+	.pagesize	= 32,
+	.addr_len	= 2,
+};
+
+static const struct at25_chip atmel_at25256b = {
+	.size		= 32768,
+	.pagesize	= 64,
+	.addr_len	= 2,
+};
+
+static const struct at25_chip st_m95640 = {
+	.size		= 8192,
+	.pagesize	= 32,
+	.addr_len	= 2,
+};
+
+static const struct at25_chip st_m95256 = {
+	.size		= 32768,
+	.pagesize	= 64,
+	.addr_len	= 2,
+};
+
+static const struct at25_chip st_m95m02 = {
+	.size		= 262144,
+	.pagesize	= 256,
+	.addr_len	= 3,
+};
+
+static int spi_eeprom_std_probe(struct udevice *dev)
+{
+	const struct at25_chip *chip =
+		(const struct at25_chip *)dev_get_driver_data(dev);
+	struct spi_eeprom *priv = dev_get_priv(dev);
+	u32 addr_bits;
+	u8 status;
+	int ret;
+
+	if (!chip)
+		chip = &at25_generic;
+
+	priv->size = dev_read_u32_default(dev, "size", chip->size);
+	priv->pagesize = dev_read_u32_default(dev, "pagesize", chip->pagesize);
+	addr_bits = dev_read_u32_default(dev, "address-width",
+					 chip->addr_len * 8);
+
+	if (!priv->size || !priv->pagesize || !addr_bits) {
+		log_err("Missing 'size'/'pagesize'/'address-width', required by the atmel,at25 binding\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The binding also allows 9-bit addressing, where the ninth address
+	 * bit travels in the opcode. That is not implemented here.
+	 */
+	switch (addr_bits) {
+	case 8:
+	case 16:
+	case 24:
+		priv->addr_len = addr_bits / 8;
+		break;
+	default:
+		log_err("Unsupported address width %u\n", addr_bits);
+		return -EOPNOTSUPP;
+	}
+
+	if (priv->size > 1UL << addr_bits) {
+		log_err("Size %lu exceeds the %u-bit address range\n",
+			priv->size, addr_bits);
+		return -EINVAL;
+	}
+
+	ret = spi_eeprom_read_status(dev, &status);
+	if (ret) {
+		log_err("Failed to read status register: %d\n", ret);
+		return ret;
+	}
+
+	log_debug("status register: 0x%02x\n", status);
+
+	return 0;
+}
+
+static const struct udevice_id spi_eeprom_std_ids[] = {
+	{ .compatible = "microchip,25aa010a",
+	  .data = (ulong)&mchp_25aa010a },
+	{ .compatible = "microchip,at25160bn",
+	  .data = (ulong)&mchp_at25160bn },
+	{ .compatible = "atmel,at25256B",
+	  .data = (ulong)&atmel_at25256b },
+	{ .compatible = "st,m95640", .data = (ulong)&st_m95640 },
+	{ .compatible = "st,m95256", .data = (ulong)&st_m95256 },
+	{ .compatible = "st,m95m02", .data = (ulong)&st_m95m02 },
+	/* Fallback compatible required by the binding; must be last */
+	{ .compatible = "atmel,at25", .data = (ulong)&at25_generic },
+	{ }
+};
+
+U_BOOT_DRIVER(spi_eeprom_std) = {
+	.name		= "spi_eeprom",
+	.id		= UCLASS_SPI_EEPROM,
+	.of_match	= spi_eeprom_std_ids,
+	.probe		= spi_eeprom_std_probe,
+	.priv_auto	= sizeof(struct spi_eeprom),
+	.ops		= &spi_eeprom_std_ops,
+};
+
+UCLASS_DRIVER(spi_eeprom) = {
+	.id	= UCLASS_SPI_EEPROM,
+	.name	= "spi_eeprom",
+};
diff --git a/drivers/misc/spi_eeprom_priv.h b/drivers/misc/spi_eeprom_priv.h
new file mode 100644
index 00000000000..142ffc736c7
--- /dev/null
+++ b/drivers/misc/spi_eeprom_priv.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Command set shared by the AT25-style SPI EEPROM driver and its sandbox
+ * emulator. These opcodes are an implementation detail of the driver, not
+ * part of the UCLASS_SPI_EEPROM API.
+ *
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#ifndef __SPI_EEPROM_PRIV_H
+#define __SPI_EEPROM_PRIV_H
+
+/* AT25-style command set */
+#define AT25_CMD_READ_DATA	0x03	/* Read data from memory array */
+#define AT25_CMD_READ_STATUS	0x05	/* Read status register */
+
+#endif /* __SPI_EEPROM_PRIV_H */
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 36b5d87c304..d24b4a1a121 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -138,6 +138,7 @@ enum uclass_id {
 	UCLASS_SOC,		/* SOC Device */
 	UCLASS_SOUND,		/* Playing simple sounds */
 	UCLASS_SPI,		/* SPI bus */
+	UCLASS_SPI_EEPROM,	/* SPI EEPROM device */
 	UCLASS_SPI_FLASH,	/* SPI flash */
 	UCLASS_SPI_GENERIC,	/* Generic SPI flash target */
 	UCLASS_SPMI,		/* System Power Management Interface bus */
diff --git a/include/spi_eeprom.h b/include/spi_eeprom.h
new file mode 100644
index 00000000000..64b5d3130be
--- /dev/null
+++ b/include/spi_eeprom.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 Koninklijke Philips N.V.
+ * Copyright (c) 2026 João Loureiro <joaofl@gmail.com>
+ */
+
+#ifndef __SPI_EEPROM
+#define __SPI_EEPROM
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+struct udevice;
+
+/**
+ * struct spi_eeprom_ops - operations provided by an SPI EEPROM driver
+ *
+ * @read:	Read @size bytes from @offset into @buf
+ * @write:	Write @size bytes from @buf at @offset
+ * @size:	Return the capacity of the device in bytes
+ */
+struct spi_eeprom_ops {
+	int (*read)(struct udevice *dev, int offset, u8 *buf, int size);
+	int (*write)(struct udevice *dev, int offset, const u8 *buf,
+		     int size);
+	int (*size)(struct udevice *dev);
+};
+
+/**
+ * struct spi_eeprom - geometry of an SPI EEPROM device
+ *
+ * @pagesize:	The EEPROM's page size in bytes
+ * @size:	The EEPROM's capacity in bytes
+ * @addr_len:	Number of address bytes sent after the command opcode
+ */
+struct spi_eeprom {
+	unsigned long pagesize;
+	unsigned long size;
+	u8 addr_len;
+};
+
+#if CONFIG_IS_ENABLED(SPI_EEPROM)
+/**
+ * spi_eeprom_read() - read bytes from an SPI EEPROM chip
+ *
+ * @dev:	Chip to read from
+ * @offset:	Offset within chip to start reading
+ * @buf:	Place to put data
+ * @size:	Number of bytes to read
+ * Return: 0 on success, -ve on failure
+ */
+int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf, int size);
+
+/**
+ * spi_eeprom_write() - write bytes to an SPI EEPROM chip
+ *
+ * @dev:	Chip to write to
+ * @offset:	Offset within chip to start writing
+ * @buf:	Buffer containing data to write
+ * @size:	Number of bytes to write
+ * Return: 0 on success, -ve on failure
+ */
+int spi_eeprom_write(struct udevice *dev, int offset, const u8 *buf,
+		     int size);
+
+/**
+ * spi_eeprom_size() - get size of SPI EEPROM chip
+ *
+ * @dev:	Chip to query
+ * Return: +ve size in bytes on success, -ve on failure
+ */
+int spi_eeprom_size(struct udevice *dev);
+
+#else /* !SPI_EEPROM */
+
+static inline int spi_eeprom_read(struct udevice *dev, int offset, u8 *buf,
+				  int size)
+{
+	return -ENOSYS;
+}
+
+static inline int spi_eeprom_write(struct udevice *dev, int offset,
+				   const u8 *buf, int size)
+{
+	return -ENOSYS;
+}
+
+static inline int spi_eeprom_size(struct udevice *dev)
+{
+	return -ENOSYS;
+}
+
+#endif /* SPI_EEPROM */
+
+#endif /* __SPI_EEPROM */
-- 
2.43.0

