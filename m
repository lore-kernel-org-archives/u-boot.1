Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD14CC4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 09:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9977D88C18;
	Fri,  3 May 2024 11:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EpHoAnUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3953A88C0C; Fri,  3 May 2024 11:00:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CD4882CE
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 11:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E3F9C3FE64
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714726846;
 bh=4oZ7OaPfMkqwGCHPNp6PtCbQM0i52gkSLYDgMcIo/2w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=EpHoAnUMBynhTdisLB6O9MaF/kulUx3y/CjDebBs2Bbvq4JfuNJh5BZ3fLJRTY0co
 e57xsSLumdyMtCupShOs0rWhLqHAvdZjLgzf0efxo6AG4rSFHeoYgY52BSqETse6Ef
 lASK9YRPjeh1zMBxXH2kYEH3GI+MC8vzW9BsAisuoRPvxzBg3hdW5bmkwXkMTn7sqX
 ffGD6xxr1qeH5PVT9dDov+tWxsv0c0E2WzcVljdin6Lhlg+TuONCakMpuxCQ7nQfmv
 aWEbKN4nrqWyiRtrgPB8agspoV/D7Hxn/HBji7aTbyot2rl3ARmjUiiucUDnPzB1V4
 RT4JP9XCO/U1g==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-34e01a857a6so1035839f8f.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 02:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714726846; x=1715331646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oZ7OaPfMkqwGCHPNp6PtCbQM0i52gkSLYDgMcIo/2w=;
 b=ljz3BZrWuRxyyoI3gKQYo5SdVy1MJKXrcMWWzIxC9B0ecGBkBvELhbLYAdymR6N4ql
 Og4KzzO2hxjV7D4rXnPnq8iG3/CJZYWHcG22Hm+Ortr4Dvx9gq4c9R2knnDuxZLjHev7
 GG5Pv/t1/qr1wa3O4ygvzH2zBwkrX0IlCGqgmb+tVzJQKprybnTHrE76SNRZyjGQUAFv
 HREAGYqLHyzTPQSmSmCutBRIOf1r+ubTq/hyw7eY1Vd2j1DQSPyobQNcsEsEomlnTq8Z
 uVSNJCYPElYTxGqQn8e3Ylq4HghchmwwDNN3BhAdS8OAr969R/BoiKVxmvducif51w81
 +FJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOlX5OlCtaLQXm6VCcQsPcKuz6b20/Uqej+KL2xeGg6b/uuVGKnJL8p7Pg/iJ0X4bIrpm19HjP0ks0JbSfKt/9fMGXLg==
X-Gm-Message-State: AOJu0YyQ3sP0pojtUWVbkDF+2ibNHJqnB6n2axvCUQjLzK58AlfwXDu5
 qOxGUr0R64Qv2TWic038ZAB/AS5g8eHEIOMHFKKOEbvvzmKMwalA7b/vAjVYGZgJ4eSy9tVFst2
 bioWgny3gF+qgptT+0Ym6maKjf/Z6WnZAYZBV7OkvkPPZF9XkxGKNlpWCqaA7xxd0j7M=
X-Received: by 2002:adf:fdca:0:b0:34d:742e:3dbf with SMTP id
 i10-20020adffdca000000b0034d742e3dbfmr1534690wrs.0.1714726846262; 
 Fri, 03 May 2024 02:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5NFXFXZ19J6OEaOE2HqBi4I2RtBOtfQPNXqubcy7ckcLPMamINPVGcbZrtBxhorh31k3VTg==
X-Received: by 2002:adf:fdca:0:b0:34d:742e:3dbf with SMTP id
 i10-20020adffdca000000b0034d742e3dbfmr1534667wrs.0.1714726845927; 
 Fri, 03 May 2024 02:00:45 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 bf9-20020a0560001cc900b00341b451a31asm3247313wrb.36.2024.05.03.02.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 02:00:45 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] board: starfive: function to read eMMC size
Date: Fri,  3 May 2024 11:00:00 +0200
Message-ID: <20240503090011.37849-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
References: <20240503090011.37849-1-heinrich.schuchardt@canonical.com>
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

The EEPROM provides information about the size of the eMMC.
Provide a new function get_mmc_size_from_eeprom() to read it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	fix typos in get_mmc_size_from_eeprom() description
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h    |  7 +++++++
 board/starfive/visionfive2/Kconfig             |  9 +++++++++
 .../visionfive2/visionfive2-i2c-eeprom.c       | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index 62d184aeb57..45ad2a5f7bc 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -12,6 +12,13 @@
 u8 get_pcb_revision_from_eeprom(void);
 u32 get_ddr_size_from_eeprom(void);
 
+/**
+ * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
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
index 5095a0e9fdb..9648a270494 100644
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

