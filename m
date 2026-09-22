Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087DC98308
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B092D40765;
	Tue, 22 Sep 2026 16:50:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7TTlm_MwFLF0; Tue, 22 Sep 2026 16:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7C7A64074E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790095809;
	b=Aex6e/ksDhgHVoBoh3cJt456+kwnVNytZcLhH4FMNFRapwWwkyrM5d829osqlNXS9ti7
	 A8Qeu6DbBfjSXKWeUyEl57FO5dGHh+il80N91XBhc/sGxIV6hIR4M/hmQMLY87YfiV5OO
	 D1QqwaLlSfmnS0iqRLOerQqRjhLndKmWl/zvG2WvJCeeVXQBxCU2PsWrRwjGMY9/L4PEB
	 YN0UzCXhMCZD9K75iX30AeHHG5RXbACvCoo2kn4LxNA87MUXcXs65Cu96lEmsaZURU3f+
	 4DoBwYbnHIrrNNpcAFliQlsN0ipq6VWmgzZTbwKpkzTGnHPOrSTOHwptjvUN5c+wQMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790095809;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gF8taGjqBGk5chvQnUO/6VENBWOhadIP38849I/Kwws=;
	b=fkp0xUouy/2obfoaD9v5R/QUvq8ICYPMZe3blE2rR+47e898k0VMYplEyIS3ajcrfJ4P
	 2ncFNpXQvJHVysgmjh1qwKbWP0AlItyk/XN5rbP7bBcMeiOokfj/HHuvN/dgcdo523iPp
	 VZw1OLP8gPh5TP66uvfXm8h1gZf89116XrwXY5BDQ7Zo9ww9nik9Gu8b3lJBpa9gEFbj1
	 07Awn5heht4aikmbnsNpmVLibS5EP1gJ6NhwO1ctvtd27ttndn6m5Sop9YQfwwG4dPx+c
	 JkBmU99dF0kS+nr9sEp337bpdyHnfWXnfQ1EZKMWqr8RHF3L8DOgqBf9jShMSYhdsvQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790095809;
	bh=gF8taGjqBGk5chvQnUO/6VENBWOhadIP38849I/Kwws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kvBaDHrc/KA/low0cIFBxr6qjzwpzHHiazcqBN4bAE1WPV1SlqcSEmtiyh86MM6CL
	 +Ay5w0TcbGA+A04E1uRyowV+sbKhWVGLZUSIW2Lezp74IUZNmI6bWkS5TlAk2g6lu3
	 7vZhYkKEcn1iIOnQ1Rb7ZsMGndJkkgWTyi9l/mEyHZGsdHwbVUcKjeKvxzAi4rQvqL
	 12E+pn2wXC4Kz53WM4b94p4VbgZki6hZBH4c+IbyiEkLnwrfse/CMF6cbirq1/IbtN
	 AaQ1TUSJuLeAImtNZRVwmJqS5PNYW7c1PoCecwKEt0l5kX2LC5GPgUjgtHmitNJnTz
	 //nR4FGVet2PA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C7A64074E;
	Tue, 22 Sep 2026 16:50:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 917579CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:20:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7826B606E9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LRt4dKnrfGpB for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:20:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 54CF8606D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094009;
 b=B5ll2L2LR2fUmuoYCoBlSyeg7oW64Jdn3gr1eHuL6aK0st/7+5Qiex9voR5Hmg48WW2L
 8GJWKB8vWB4LG3W/R0iOdPkNrAfDjt0caP8IKQI5AGVeH3qpVJxZ5ZwQMwc5oB19Tjry+
 3r7ossdo/eyVYAMSJBRG3xdzbwJq+SWZSnB98p0lUiNB+63JEV8K5x+z13rDGiAuIFKRn
 b/T7t6nxCuHv8dDP0XkZSwvCz6Z3SXqiY1qJ+J/5Ndr6CRMxsyHg5upQo1nqO31PVrSas
 VxR3k3ulZ6Eir3Sp0jvRfHsv6ailkqfelhJA1uGufkeZFKAv1eO2YL71eswUbIagbWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790094009;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=gF8taGjqBGk5chvQnUO/6VENBWOhadIP38849I/Kwws=;
 b=CdImNYXXhm7KPpE57CIC2xOYv2ShSWTX6j5XEPlMg22oAplEStbdHXto13wsgzPlr5rj
 u+U8XOjB9CYTjvsGSsBT6LDiRh2OEeNXtJkeO9joxTjXv/2AX+2J5QYVCNaB1oulqMl8r
 E0wXW4WlBKjeQjoNKsUxUU40PBVIZ371tlKZaeFCwpgCAM2r761ncpeBVMsf2oN9avW+X
 /gY2kIdLD+G/L/EvEM0dmTZiOAEwH5JwPjT0szz5llBIYSoy3AMQdIiOmGq4nTY0s5/fZ
 r0RBEYJNOZnYWemAFvgUnLOoG0ngroUw34wgPvIQffWDNo3jlcVvuGsVn12aof9RX5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=EXzF66Mb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=EXzF66Mb
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54CF8606D0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790093963; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Q5y+9LvmYLV0pDeb5nrW7Q/pzEEdqKEgnx38hRue7RRB8U4UEmmAuZOQuZyxpTbergHDicYabsMSaE6CwNtn5aSYB2Fa8OE6twgBl/xVP7L2dHiGrVjSFTsGfn5wF+OYOdDuerZxZ4S5ZmLntGgm6hMjPM4MhuOueuI3cbqNttM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790093963;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gF8taGjqBGk5chvQnUO/6VENBWOhadIP38849I/Kwws=; 
 b=P5V60FoNJY+9uaJTfAX0QAehGOGYJChQoVyNQOn6UYubolLc+qAIVSc9sYq0q5N9gOI5Av2HwAkxyJQwr/DoTsRpOlI0nVSbChb4LayzR89oqrny/4SsltFWRgaX5NdP9Sm5NnfDn4Cu5sH8G8BAZgK2r/wsZdJB/cULL+GqzYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790093963; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=gF8taGjqBGk5chvQnUO/6VENBWOhadIP38849I/Kwws=;
 b=EXzF66MbR+5ONFbVs+etT0sDsH8jQpn/wYpzFwK3r0S1D/SKIGz8PQhEdahLVLvH
 sg+rtsLyDgemsys7gGF11KRdC2hGUM1Jq8N/bbQGHcaTWKLAveWcJ2J2Qf6ag+MZsxf
 U6SsBwx7vYfAV2CneNx7LBbIhCkeVe/OZrm7WSdk=
Received: by smtp.zohomail.com with SMTPS id 17900939608461012.6798927416309; 
 Tue, 22 Sep 2026 09:19:20 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 22 Sep 2026 23:46:24 +0800
Subject: [PATCH v4 09/11] rtc: cv1800: Add RTC and system reset support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-milkv-duo-upstream-dts-v4-9-d45b74dfad36@zohomail.com>
References: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
In-Reply-To: <20260922-milkv-duo-upstream-dts-v4-0-d45b74dfad36@zohomail.com>
To: u-boot@lists.u-boot-project.org, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Yao Zi <me@ziyao.cc>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>, Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Chen-Yu Yeh <chenyou910331@gmail.com>, Chen Wang <chen.wang@linux.dev>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Leo Liang <leo.liang@sifive.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Alexander Koch <akoch@initse.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112273e3bb615cdf165c30e1201fc0000421eb86b8384656765f8bc09bbbb1b9aa8250ee24f7da448e6:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 22 Sep 2026 16:50:01 +0000
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

The upstream devicetrees describe the CV1800 RTC subsystem with the
"sophgo,cv1800b-rtc" compatible string. The RTC seconds counter and the
system-reset controls share the same register range.

Add an RTC driver which directly matches this node, enables its clock,
and implements reading and setting the 32-bit seconds counter. Bind the
CV1800B sysreset driver as a child from the RTC driver's bind callback so
both functions can be instantiated from the same devicetree node.

Initialize the RTC and sysreset register maps from their shared devicetree
node instead of using hard-coded MMIO addresses. Remove the board-level
sysreset binding from Milk-V Duo. Boards using the upstream RTC node can
now instantiate both functions without board-specific binding code.

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 board/sophgo/milkv_duo/board.c         |   5 --
 configs/milkv_duo_256m_defconfig       |   2 +
 configs/milkv_duo_defconfig            |   2 +
 configs/sipeed_licheerv_nano_defconfig |   2 +
 drivers/rtc/Kconfig                    |   9 +++
 drivers/rtc/Makefile                   |   1 +
 drivers/rtc/rtc-cv1800.c               | 122 +++++++++++++++++++++++++++++++++
 drivers/sysreset/Kconfig               |   6 +-
 drivers/sysreset/sysreset_cv1800b.c    |  86 ++++++++++++++---------
 9 files changed, 194 insertions(+), 41 deletions(-)

diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/board.c
index 34339c42925..3423f54012e 100644
--- a/board/sophgo/milkv_duo/board.c
+++ b/board/sophgo/milkv_duo/board.c
@@ -3,15 +3,10 @@
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
  */
 
-#include <dm/lists.h>
-
 #include "../common/ethernet.h"
 
 int board_init(void)
 {
-	if (IS_ENABLED(CONFIG_SYSRESET_CV1800B))
-		device_bind_driver(gd->dm_root, "cv1800b_sysreset", "sysreset", NULL);
-
 	if (IS_ENABLED(CONFIG_NET_LEGACY))
 		cv1800b_ephy_init();
 
diff --git a/configs/milkv_duo_256m_defconfig b/configs/milkv_duo_256m_defconfig
index 436bdb1549a..ea31b053672 100644
--- a/configs/milkv_duo_256m_defconfig
+++ b/configs/milkv_duo_256m_defconfig
@@ -36,6 +36,8 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 9d6b80362d5..77c8d89701d 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -35,6 +35,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 21b8fece201..75229787d2f 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -40,6 +40,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SPI=y
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5b44cc99c97..f200d978937 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -54,6 +54,15 @@ config RTC_ARMADA38X
 	  This adds support for the in-chip RTC that can be found in the
 	  Armada 38x Marvell's SoC devices.
 
+config RTC_CV1800B
+	bool "Enable Sophgo CV1800B RTC driver"
+	depends on DM_RTC
+	select REGMAP
+	help
+	  Enable access to the RTC seconds counter found on Sophgo CV1800
+	  series SoCs. The driver also binds the system-reset function provided
+	  by the RTC subsystem when CONFIG_SYSRESET_CV1800B is enabled.
+
 config RTC_PCF2127
 	bool "Enable PCF2127 driver"
 	depends on DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 742481ce185..961fe5409f0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
+obj-$(CONFIG_RTC_CV1800B) += rtc-cv1800.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
 obj-$(CONFIG_RTC_DS1307) += ds1307.o
 obj-$(CONFIG_RTC_DS1337) += ds1337.o
diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
new file mode 100644
index 00000000000..4a958e44de1
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
+ *
+ * Based on the Linux driver by Jingbao Qiu <qiujingbao.dlmu@gmail.com>.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <regmap.h>
+#include <rtc.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+
+#define SEC_PULSE_GEN		0x1004
+#define SET_SEC_CNTR_VAL	0x1010
+#define SET_SEC_CNTR_TRIG	0x1014
+#define SEC_CNTR_VAL		0x1018
+#define MACRO_RG_SET_T		0x1498
+
+#define SEL_SEC_PULSE		BIT(31)
+
+struct cv1800_rtc_priv {
+	struct regmap *regmap;
+	struct clk clk;
+};
+
+static int cv1800_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
+	u32 value;
+	int ret;
+
+	ret = regmap_read(priv->regmap, SEC_PULSE_GEN, &value);
+	if (ret)
+		return ret;
+	if (value & SEL_SEC_PULSE)
+		return -EINVAL;
+
+	ret = regmap_read(priv->regmap, SEC_CNTR_VAL, &value);
+	if (ret)
+		return ret;
+
+	rtc_to_tm(value, time);
+
+	return 0;
+}
+
+static int cv1800_rtc_set(struct udevice *dev, const struct rtc_time *time)
+{
+	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
+	time64_t seconds;
+	int ret;
+
+	if (time->tm_year < 1970)
+		return -EINVAL;
+
+	seconds = rtc_mktime(time);
+	if (seconds > U32_MAX)
+		return -ERANGE;
+
+	ret = regmap_write(priv->regmap, SET_SEC_CNTR_VAL, seconds);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, SET_SEC_CNTR_TRIG, 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MACRO_RG_SET_T, seconds);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->regmap, SEC_PULSE_GEN,
+				  SEL_SEC_PULSE, 0);
+}
+
+static int cv1800_rtc_bind(struct udevice *dev)
+{
+	if (!CONFIG_IS_ENABLED(SYSRESET_CV1800B))
+		return 0;
+
+	return device_bind_driver_to_node(dev, "cv1800b_sysreset",
+					  "sysreset", dev_ofnode(dev), NULL);
+}
+
+static int cv1800_rtc_probe(struct udevice *dev)
+{
+	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = clk_get_by_name(dev, "rtc", &priv->clk);
+	if (ret)
+		return ret;
+
+	return clk_enable(&priv->clk);
+}
+
+static const struct rtc_ops cv1800_rtc_ops = {
+	.get = cv1800_rtc_get,
+	.set = cv1800_rtc_set,
+};
+
+static const struct udevice_id cv1800_rtc_ids[] = {
+	{ .compatible = "sophgo,cv1800b-rtc" },
+	{ }
+};
+
+U_BOOT_DRIVER(cv1800b_rtc) = {
+	.name = "cv1800b_rtc",
+	.id = UCLASS_RTC,
+	.of_match = cv1800_rtc_ids,
+	.bind = cv1800_rtc_bind,
+	.probe = cv1800_rtc_probe,
+	.ops = &cv1800_rtc_ops,
+	.priv_auto = sizeof(struct cv1800_rtc_priv),
+};
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 16ef434a8d9..c3125d1921a 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -60,9 +60,11 @@ config SYSRESET_CMD_POWEROFF
 endif
 
 config SYSRESET_CV1800B
-	bool "Enable support for Sophgo cv1800b System Reset"
+	bool "Enable support for Sophgo CV1800B system reset"
+	depends on RTC_CV1800B
 	help
-	  Enable system reset support for Sophgo cv1800b SoC.
+	  Enable system reset and power control through the RTC subsystem found
+	  on Sophgo CV1800 series SoCs.
 
 config POWEROFF_GPIO
 	bool "Enable support for GPIO poweroff driver"
diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
index 9cd62772ef4..0836b018956 100644
--- a/drivers/sysreset/sysreset_cv1800b.c
+++ b/drivers/sysreset/sysreset_cv1800b.c
@@ -4,61 +4,79 @@
  */
 
 #include <dm.h>
-#include <stdbool.h>
+#include <regmap.h>
 #include <sysreset.h>
-#include <wait_bit.h>
-#include <linux/io.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
+#include <linux/err.h>
 
-#define REG_RTC_BASE             (void *)0x05026000
-#define REG_RTC_CTRL_BASE        (void *)0x05025000
-#define REG_RTC_EN_SHDN_REQ      (REG_RTC_BASE + 0xc0)
-#define REG_RTC_EN_PWR_CYC_REQ   (REG_RTC_BASE + 0xc8)
-#define REG_RTC_EN_WARM_RST_REQ  (REG_RTC_BASE + 0xcc)
-#define REG_RTC_CTRL_UNLOCKKEY   (REG_RTC_CTRL_BASE + 0x4)
-#define REG_RTC_CTRL             (REG_RTC_CTRL_BASE + 0x8)
+#define RTC_CTRL_UNLOCKKEY	0x0004
+#define RTC_CTRL		0x0008
+#define RTC_EN_SHDN_REQ		0x10c0
+#define RTC_EN_PWR_CYC_REQ	0x10c8
+#define RTC_EN_WARM_RST_REQ	0x10cc
 
-#define CTRL_UNLOCKKEY_MAGIC     0xAB18
+#define CTRL_UNLOCKKEY_MAGIC	0xab18
 
-/* REG_RTC_CTRL */
-#define BIT_REQ_SHDN       BIT(0)
-#define BIT_REQ_PWR_CYC    BIT(3)
-#define BIT_REQ_WARM_RST   BIT(4)
+#define BIT_REQ_SHDN		BIT(0)
+#define BIT_REQ_PWR_CYC		BIT(3)
+#define BIT_REQ_WARM_RST	BIT(4)
 
-static struct {
-	void *pre_req_reg;
+struct cv1800b_sysreset_priv {
+	struct regmap *regmap;
+};
+
+static const struct {
+	u32 pre_req_reg;
 	u32 req_bit;
 } reset_info[SYSRESET_COUNT] = {
-	[SYSRESET_WARM]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
-	[SYSRESET_COLD]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
-	[SYSRESET_POWER]     = { REG_RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
-	[SYSRESET_POWER_OFF] = { REG_RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
+	[SYSRESET_WARM]      = { RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
+	[SYSRESET_COLD]      = { RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
+	[SYSRESET_POWER]     = { RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
+	[SYSRESET_POWER_OFF] = { RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
 };
 
 static int cv1800b_sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
-	u32 reg;
+	struct cv1800b_sysreset_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = regmap_write(priv->regmap, reset_info[type].pre_req_reg, 1);
+	if (ret)
+		return ret;
 
-	writel(1, reset_info[type].pre_req_reg);
-	writel(CTRL_UNLOCKKEY_MAGIC, REG_RTC_CTRL_UNLOCKKEY);
-	reg = readl(REG_RTC_CTRL);
-	writel(0xFFFF0800 | reset_info[type].req_bit, REG_RTC_CTRL);
+	ret = regmap_write(priv->regmap, RTC_CTRL_UNLOCKKEY,
+			   CTRL_UNLOCKKEY_MAGIC);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, RTC_CTRL,
+			   0xffff0800 | reset_info[type].req_bit);
+	if (ret)
+		return ret;
 
 	return -EINPROGRESS;
 }
 
+static int cv1800b_sysreset_probe(struct udevice *dev)
+{
+	struct cv1800b_sysreset_priv *priv = dev_get_priv(dev);
+
+	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	return 0;
+}
+
 static struct sysreset_ops cv1800b_sysreset = {
 	.request = cv1800b_sysreset_request,
 };
 
-static const struct udevice_id cv1800b_sysreset_ids[] = {
-	{ .compatible = "sophgo,cv1800b-sysreset", },
-	{},
-};
-
 U_BOOT_DRIVER(sysreset_cv1800b) = {
 	.name = "cv1800b_sysreset",
-	.id	  = UCLASS_SYSRESET,
-	.ops  = &cv1800b_sysreset,
-	.of_match = cv1800b_sysreset_ids
+	.id = UCLASS_SYSRESET,
+	.probe = cv1800b_sysreset_probe,
+	.ops = &cv1800b_sysreset,
+	.priv_auto = sizeof(struct cv1800b_sysreset_priv),
 };

-- 
2.55.0
