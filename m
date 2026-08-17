Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F9EC5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B4A440850;
	Mon, 17 Aug 2026 18:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ePX115OkEaD9; Mon, 17 Aug 2026 18:17:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 441F140854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990668;
	bh=4yJL5ss0VBzVj2bWTp6HWDKn9SEg50i2kaiZJGaTw1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/iBMT5LBoLXmi1gWAI9IW7l/8t2wrcvLIb6tfXaGvP9yO3fhAkO8k3uMzWZQ+ZI4
	 UJbMXESH+aPzTUe3yGs+K5VDnoH6sk8JEjRIMdG6hTBMemsPa5aJLyGfzVJQZuhBhl
	 gVJUCTBY9wEDzxgsrJksgj0eBdmwVwFoQP2hxhFxJPazjtdXiXbbazAw+h9m2sNes0
	 xIChEkMbRQHomCbTcJdVwri58F6fnCeeWBVTJ3OEaI7mjj7ebVNnj8L0/yz8UzSw9u
	 j6vTozbkMlfiz0/BSFLPFVyMlnsL0+mDTgCJZtKjH6y6woxecKR9tEro5S+BOfkGy4
	 d4YWtnt2N2uZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 441F140854;
	Mon, 17 Aug 2026 18:17:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BBCB337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D7C580FF2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6GmUXxWEcBDI for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1254780F0A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1254780F0A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=CL/5PBII
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1254780F0A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:33 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c149c5722so1155861cf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986993; x=1787591793;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4yJL5ss0VBzVj2bWTp6HWDKn9SEg50i2kaiZJGaTw1w=;
 b=CL/5PBIIf/ww5qRyt1rvqW3PMN/h9rP80WSkH7jogscmAOgqkUKYiF85nhIsp22mz+
 3wridKSRDn1K7GppIOuLD1rImfwEEeX/kxmrVZYsiAoju6gXIoDl1l23u2HtJSauCO7S
 gLG5l4Ksf3XluOVOltaVF7WeES5m5ZGiU2EkmH5Dh7W2HbY5nIxsAbNka+o87CzPBxRr
 0xgoWRDeRpYMb0h7hYNL+j3idsGHlJrA/+eRZDKznLtNeSbtPOgBGIR48bpR/K86rPiE
 lK46ndxZItdz/d/HdNpUuVTQ6LwmGa2jnU8RKqUV5c2j5RHQ3FMm/vjEqEwE9hWW7Ub4
 yOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986993; x=1787591793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4yJL5ss0VBzVj2bWTp6HWDKn9SEg50i2kaiZJGaTw1w=;
 b=mdtWhah5OWh1TSx+CC8kRkzPC70McLVZEJ0MO0w8Ha9r5kloQVxpqvPRKr4VGuF0AQ
 P2HmcMnkYlxJIbjEGkefsMvAHmjICc63eNzyJ0bgpvlfqkHm9s3daXM4O4W9hToIhSM5
 I7oo/B8WffPdLnMG+3lzJbP2FeHVNB7KoUyJqbo3c9Xo31vVHOmWkY+4PJkknk4mZ/ge
 qbNkT2O4LITSnBXweETeFfLoe5+WTrsIfRoV94bjalpjihuwqdVStPWS4ss+6jMLEZSt
 HUweBxaRAm8MYe2ldnM9LvwDv7EIqe1ifdSK6oAp3HFxpOij6rO3cQAa2C/g5HyvwCDs
 LIVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwXi40ajA6EH+60y9ZwBpr8KYc6rOKdFMV/NJVjFLgKeft7vnnSCqlhzh1ggSNcULcv4MZPTk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yw/YycnQUlm5WSXNp2zaxe1WkAuPAQztH4Po3GoqgXov47PaJOH
 DMNFg7aVWPN8kuqBnI0jFG5Hhjgt2/YcTJxstNACV5SqFdtUPyCkTaV6Vf/+bw0OXCVHTvZgmmd
 c+t8rH2OP2ksFyLfMuAhhMePK3/NSPnu+BkoDlyiU5BQJhnNeO4iMYz3edAV/Yso=
X-Gm-Gg: AR+sD12hRlm4Z+P3Ai6OawwD6U8J+7F68KOiIh0aUIAGTJ8DuFjpLDh7vDrIoRDtJan
 NR1THn9kRk9DkJb0Bpr8F89Q2CY7PsIDg7BokukqOCEAYIQtkt9gBT6MK0DFv/yrAbX6FO61E0t
 BBpnMAAqN4/p/I8g3+M5JGX/ZsXCyZ0lR/3vkZBxph5WES/pmQgcD850PoF+ldIVDjmJUxxlHQ1
 CRR7BcbP4YQQBxlJADEf8rejRE3LCWDUGBClKhoFPE1AAhnp1CAz2KOP1QnRU+aUN6oMX9JZJv6
 HrcOmoGRL/z6G41PjEeo2zvO+a152ByvMbtBPXxR1PQw+veyQ4xPaKjx4y2I723lnmTpUnQGYSP
 H+5sgj82z9VxETMSZM7wYM52ki4MSqf+Bh7gv+Gowr8Do1rE+Pbk38WvjLdBzeC9lyz5sitmXrV
 JmTHOOP7/di3qhPfkZ5bAREvihCumAxFluPUesnQHmJLcwQwvB/aq2UNcMSm1N9CVDPz22eHHXl
 VxY0wDKhbYb05oP+TCoTMIfu/E=
X-Received: by 2002:a05:622a:181c:b0:528:317d:eaf3 with SMTP id
 d75a77b69052e-52dbed1f1c5mr7956411cf.6.1786986992612; 
 Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>
Subject: [PATCH 9/9] [RFT] meson: Add Khadas VIM1S support
Date: Mon, 17 Aug 2026 13:15:20 -0400
Message-ID: <20260817171623.1943847-10-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

This adds basic support for the Khadas VIM1S [1]. I built this config on
a custom board, and I don't even own a vim1s. Please test!

[1] https://www.khadas.com/vim1s

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 board/amlogic/q200/MAINTAINERS |  1 +
 configs/khadas-vim1s_defconfig | 80 ++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 configs/khadas-vim1s_defconfig

diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
index aece8d5e05c..5281e06f3cc 100644
--- a/board/amlogic/q200/MAINTAINERS
+++ b/board/amlogic/q200/MAINTAINERS
@@ -5,6 +5,7 @@ L:	u-boot-amlogic@groups.io
 F:	board/amlogic/q200/
 F:	include/configs/q200.h
 F:	configs/beelink-gt1-ultimate_defconfig
+F:	configs/khadas-vim1s_defconfig
 F:	configs/khadas-vim2_defconfig
 F:	configs/libretech-s905d-pc_defconfig
 F:	configs/libretech-s912-pc_defconfig
diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
new file mode 100644
index 00000000000..143425cd2ca
--- /dev/null
+++ b/configs/khadas-vim1s_defconfig
@@ -0,0 +1,80 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="q200"
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x0
+CONFIG_SYS_MALLOC_LEN=0x8000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_MESON_S4=y
+CONFIG_SYS_LOAD_ADDR=0x1000000
+CONFIG_IDENT_STRING=" vim1s"
+# CONFIG_PSCI_RESET is not set
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+# CONFIG_DISTRO_DEFAULTS is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="root=/dev/mmcblk1p2 ro rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="load mmc 1:1 $loadaddr linux.itb && bootm"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=32
+# CONFIG_CMD_BDI is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_WDT=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_PXE=y
+# CONFIG_CMD_DATE is not set
+CONFIG_CMD_RTC=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_ISO_PARTITION=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_MESON=y
+# CONFIG_INPUT is not set
+CONFIG_MMC_MESON_GX=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_MDIO_MUX=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE_MESON8B=y
+CONFIG_MDIO_MUX_MESON_G12A=y
+CONFIG_PHY_MESON_GXL=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_MESON_S4=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1337=y
+CONFIG_RTC_DS1337_NOOSC=y
+CONFIG_BAUDRATE=888888
+CONFIG_MESON_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MESON_GXBB=y
+# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.53.0

