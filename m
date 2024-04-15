Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991F6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E2A881EF;
	Mon, 15 Apr 2024 13:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AcJd5iQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9702C88089; Mon, 15 Apr 2024 13:50:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9035B87D5F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1730C411DE
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713181852;
 bh=2zQphO6LktZ2PZImkiw5jaUfGGJl1HlzNOoxQfzKoZE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=AcJd5iQNxBZ6XLLR5FLG340ll5fuQH1/xqiRRYpn9X80rL+0KCahtBTFsQoRsxUQg
 Y80dBoyfqsyZHSdVWqaAEz0XWKbT2DF8Yfl6XdN1Jvu0PH/A3mWUltK2r2MVbDKurT
 tNv7D+UhP0l4TBVwcaRNIv04g8NMdVRWjY+79SmnoMA0AH9KKVXWXcY8/RECv+dyWk
 GfztWIRPA/gP+1WJSYpvKcUVuAPE/H4UtBP50ewlwPKwt/vlICJ9EVKRwPW/qdHqcu
 LXEm6gqpDtQedJlbiLsMlseiWuOpODGGjTosGDaaASAnOkvGdjk4l2cb5OHt48Co85
 aKcBGK/tQqhQw==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-417c92b77e1so13490265e9.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181851; x=1713786651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zQphO6LktZ2PZImkiw5jaUfGGJl1HlzNOoxQfzKoZE=;
 b=NnnDzZu5JIfi0bhYpvp6QKUR5rRvoSFDSaP4g1lWKbV9k2pznGrFiGO8if3eL6r6VH
 GBnpOWo/c3HglTmnTXpNFQXuHYFEdWXVTNSaDhhNw2UyzP011IqnvvLdRR0VkYPNX9wN
 4eXVAgKvQo7dEU+G8Aw/gHACl41Qh3HOfNvzfc3zKlaHWgCvJ4U+Uorgy4dYoYRwpH7h
 zk28WSfGMSaEGFqA+HgTlFKH0K92qmZ0Yb2lMOzFQ5CJHz+RUw+jbjfVA4tm6JWgbXEE
 z4qmguczHcVXs8OaXMht1zPEHW7tvDbHeDXafLiAqNohc5eiW4MvZTrvAx4Pm4ueuM3Q
 rVMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeQz6wCUWZ4iyCedTr3e5I33PMZwlK4iIqaQj8GAeBNutHBdhv17/QW3VoaQm2OTGBpC+g6UDbFoIxrI3DBO33KpnvA==
X-Gm-Message-State: AOJu0YzqfeFLhCaRf52hOCD0hyVNF5zrWTDZ8SLXGMK5WT4FUGMXRl0A
 Hw6D6ItphtuezUm0f4r1ZWFrlPexcklJ9qYmmIKkYexHmVLokvpqGYgMcwidaCKxXnKX4AsexgC
 3pHYmX8EqNztlvQgVfbAwB0S+vmigKzO6hB/6dYQkVWq30GfQWfjoADOIL0p/losKqRI=
X-Received: by 2002:a05:600c:3491:b0:418:2323:e87 with SMTP id
 a17-20020a05600c349100b0041823230e87mr4054189wmq.25.1713181851571; 
 Mon, 15 Apr 2024 04:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv9aO74IafC7mtph9tQruVoEBQ59Kna8ZjYPWm/+Ma2M1wXHFndevKYtxmsTcgopBGQELvqQ==
X-Received: by 2002:a05:600c:3491:b0:418:2323:e87 with SMTP id
 a17-20020a05600c349100b0041823230e87mr4054174wmq.25.1713181851280; 
 Mon, 15 Apr 2024 04:50:51 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b003469e7f5c52sm11924130wro.80.2024.04.15.04.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:50:50 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/4] board: starfive: function to read eMMC size
Date: Mon, 15 Apr 2024 13:50:32 +0200
Message-ID: <20240415115035.46199-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
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

The EEPROM provides information about the size of the EEPROM.
Provide a new function get_mmc_size_from_eeprom() to read it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h    |  7 +++++++
 board/starfive/visionfive2/Kconfig             |  9 +++++++++
 .../visionfive2/visionfive2-i2c-eeprom.c       | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index 62d184aeb57..17395d4269e 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -12,6 +12,13 @@
 u8 get_pcb_revision_from_eeprom(void);
 u32 get_ddr_size_from_eeprom(void);
 
+/**
+ * get_mmc_size_from_eeprom() - read MMC size form EEPROM
+ *
+ * @return: size in GiB or 0 on error.
+ */
+u32 get_mmc_size_from_eeprom(void);
+
 /**
  * get_product_id_from_eeprom - get product ID string
  *
diff --git a/board/starfive/visionfive2/Kconfig b/board/starfive/visionfive2/Kconfig
index 2186a939646..d7e8a7a7d78 100644
--- a/board/starfive/visionfive2/Kconfig
+++ b/board/starfive/visionfive2/Kconfig
@@ -50,4 +50,13 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply PHY_LIB
 	imply PHY_MSCC
 
+config STARFIVE_NO_EMMC
+	bool "Report eMMC size as zero"
+	help
+	  The serial number string in the EEPROM is meant to report the
+	  size of onboard eMMC. Unfortunately some Milk-V Mars CM Lite
+	  modules without eMMC show a non-zero size here.
+
+	  Set to 'Y' if you have a Mars CM Lite module.
+
 endif
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index ddef7d61235..cd3d8bd51a6 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -548,6 +548,24 @@ u32 get_ddr_size_from_eeprom(void)
 	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
 }
 
+u32 get_mmc_size_from_eeprom(void)
+{
+	u32 size;
+
+	if (IS_ENABLED(CONFIG_STARFIVE_NO_EMMC))
+		return 0;
+
+	if (read_eeprom())
+		return 0;
+
+	size = dectoul(&pbuf.eeprom.atom1.data.pstr[19], NULL);
+
+	if (pbuf.eeprom.atom1.data.pstr[21] == 'T')
+		size <<= 10;
+
+	return size;
+}
+
 U_BOOT_LONGHELP(mac,
 	"\n"
 	"    - display EEPROM content\n"
-- 
2.43.0

