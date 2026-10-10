Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A60CA9ECA
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 22:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76E6540902;
	Sat, 10 Oct 2026 22:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KtzxqAgOfL0a; Sat, 10 Oct 2026 22:32:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88508408AF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791671546;
	b=WsFBQa/WucMCZ5Gk5r7Yo136ODrNS/dV/Vvsz6CFrC4czk4vbmPxAuXDephnTr2lK/Yt
	 JBdVN78USn8R6sEFsGN0usksa4rsYNbO2lxLD2dH16BYojuZuBxxv0QNAQoAOp7pvvE+v
	 KuvANL5lrNi/TP/CKv8MTkqeq26j+aIFSTvPZcFwZW33NHhA/eYb1PjSWLhCKyUFeNHEi
	 9HpbCgUU+mwvoEf7tKlgJX5E/MGiIXQkP7gWiqfItxqq1SSp/W4pfGqydE0SAiboMWdJu
	 X9dRpiyYAlhzawxyLnUPetMran3raci6LMbCtZ865AJ+U1R89rGmZCAtShuCR7s42cw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791671546;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=69GvPCi4Z35E/OZ01iNGzJsr6nyatNU00clKOOqXBa4=;
	b=clumRbUmtivOMwKcH4By4q/oQrj4Lwr/NYwXxnzxEON7zqoRJXrM2ijNsL2mJ1wI4Q17
	 39P16NrTqAksvwVrHOm2m3e0Kf/BRG8DR5UL99Rs6mSvLW+gpJXEM9PeV3xqRnhNSK2/Q
	 /YqixxDQ0nyt2hJrO0OT2680V64Luex/Z40Re6O7/my6yKuvFLP4e0zevtXBXtwGbkmY+
	 k5RbbjRG0WOxNBOK3oa6YVoyAMkV/eeJIs6E8bqqhLGe9rAJ87xCuyXFHATZXESIfXp60
	 jTovw9OWdBe3Q8Rnpmj84p0Of+ZZYOsK84bErdhgWWM/vpeJ3NZtf/VQ9J+7LIEH5FQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791671546;
	bh=69GvPCi4Z35E/OZ01iNGzJsr6nyatNU00clKOOqXBa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZeZThlgYY1VtynLvF1wOxpL4gPvqeHsPH2imsEq/PAxcCCaQIqWexNonClHeEN5+W
	 WHdVSiPnDKv78EI1hlQVLh55MObYm5RrfjQVmhpDfmSQK9pL6y0XFxFARjT0JWNIgA
	 Xcf6C/K2mxAKdgxGyEVsUA3hUUxckq6hS34rjVcbotSYv9STTVitrfNjM+3vLIwQkF
	 xst4HMjmcNRyWq0++vEmuicE0YzeGZoHMKu7MtAVu5Q6yMcs7la2CoDx4Gbflp/PKT
	 odRReHoI/4v3RwvmSGcukRZk2sDcXO7YG6zywOBj4Tb53cr/a1gP1lR0S8cjTgkapK
	 C4RXmPklsI1QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88508408AF;
	Sat, 10 Oct 2026 22:32:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FA97356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11006606DA
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDDpIf3wIl62 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B471B60638
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791666488;
 b=QNedpazKEiF4t+YPbO9ntW2YkFCfFBA8UwEYCoTCleSvEsi5HJ/zp5/8N5lxRIGb1G9c
 A+xgM8+X1UGGSmcWQdjvkvos6vBSPZ9AtvasVReIBg1uNsvEjttZBoOHpRv9ede6wuD+3
 xuo51NGjVvvALTlj2+89gqc/LzgoQlIwA7EMSs6lou7liyVKZXwAo43vEm2zC0SyrMkaA
 tF8i+6dwwkHPyZXBYUMgsSSGL9nT5IWqyNxB5JqvSRZUZzw1GbCyk2ELA463j055gmxfi
 XMOIjzj0ijraP6vlMGBBhYs7q8K6OsVv4Bn9oUFCtPmB/SF2MReHm9rYUIHuhaty9xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791666488;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=69GvPCi4Z35E/OZ01iNGzJsr6nyatNU00clKOOqXBa4=;
 b=Xa9q7oX7psmJ1w3baloWptg6XPTKotnutU179tnEX5iywK5NU7giMxlQdgITzs3gxrI+
 JTsxkbFI1el2ZEH8iWiYGlayQJaYo6FOmrNRtjzlS7WFl06gmgWyoNvsukWRq6HLPGYM4
 ZpI0ZkUbm5ZUNSprTTiV1S1qEt0CDvK+o85WbwmdKToist8upLSBclDcLp+abhDs+eZpy
 KFc+eBOcBaC+jkitK60OKDKU5VWguLuMnSmoDVkMFG/KLVmnJadpKr64ISy6mcFeBbo75
 pLAjC5PgwYRjIQDXajOnwsVnC77M1qEXQNZrfJNcGwLAcV8O5i+v4DmwNTrm+ZJ4ZFg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Rio5Evyu; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Rio5Evyu
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B471B60638
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 21:08:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 43FE7432F4;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 237A7C2BCB9;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791666487;
 bh=5iYy6SjAPCBAAgq+MuIQae/aKXyHTB77ddAFG3+GNBk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Rio5Evyubg3kfBvzYhLHC1/XW4+YTEdG2b6uIy0j17ZeGgnODha4gR8wR3F7wocad
 0cgkoy40HRSUdg6M0rzd8Pvp/BHyO27yhLxAvCOyvPdGcOwRpI9mQex3wX0T3z3900
 5iTgUCu5tSYlh+sL5k7d6vEc+DZpE6NqHXwTNpO2KBjZo3l9m64s8RJRznRhd3lpuo
 nK6QJvLBlTDgaHypLfkxysUS+EwiFoE+aFyJpmKpcZF//c1fJ/GE990Cj3zARaDazo
 lC2WjYYTSC98k/Qo4RbmSUbstpD+l/07LJAh3HXp0T4UAMlGWdm4fKD0e2nU3SK1cq
 VwIfZnbopUPNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 07F5ACA9ECA;
 Sat, 10 Oct 2026 21:08:07 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 23:07:50 +0200
Subject: [PATCH 02/11] cmd: phonemenu: pixel drawn boot menu rendering and
 navigation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-phonemenu-series-v1-2-bfa23de6eb0b@protonmail.com>
References: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
In-Reply-To: <20261010-b4-phonemenu-series-v1-0-bfa23de6eb0b@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Petr Pavlata <petr@acrux.cz>, 
 David Heidelberg <david@ixit.cz>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791666485; l=11954;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=iuyoL/O88lzQSL/rNAjnm4b4OlkPYw4eSwCICZOE1qI=;
 b=EblZzkrcPb2I2o8swx7knfwVBWjqIXomcTA0JbmuvLdvMfyNFymkhsGb54yEiX1SkNWqoKe3I
 xzsTN4bkNJeCN4bgV8Gr6E0NewXsdG0NMWrJeOvJwpOypss4jfIVpE6
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 22:32:12 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add the core sectioned boot menu engine:

- the menu data tables
- the pixel layout/drawing primitives (video uclass fills + vidconsole
  bitmap text)
- the navigation loop built on bootmenu_loop() so volume up/down/power
  work via BUTTON_REMAP_PHONE_KEYS

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 MAINTAINERS     |   1 +
 cmd/Makefile    |   2 +-
 cmd/phonemenu.c | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b0b0b2f3a5..696abefa1e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -688,6 +688,7 @@ L:	u-boot-qcom@groups.io
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
 F:	cmd/phone_util.c
+F:	cmd/phonemenu.c
 F:	configs/qcm6490_defconfig
 F:	configs/qcs9100_defconfig
 F:	drivers/*/*/pm8???-*
diff --git a/cmd/Makefile b/cmd/Makefile
index 762572156cd..913d94abdb2 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_CMD_BMP) += bmp.o
 obj-$(CONFIG_CMD_BOOTCOUNT) += bootcount.o
 obj-$(CONFIG_CMD_BOOTEFI) += bootefi.o
 obj-$(CONFIG_CMD_BOOTMENU) += bootmenu.o
-obj-$(CONFIG_CMD_PHONEMENU) += phone_util.o
+obj-$(CONFIG_CMD_PHONEMENU) += phone_util.o phonemenu.o
 obj-$(CONFIG_CMD_BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_CMD_BOOTZ) += bootz.o
 obj-$(CONFIG_CMD_BOOTI) += booti.o
diff --git a/cmd/phonemenu.c b/cmd/phonemenu.c
new file mode 100644
index 00000000000..30f994bcb64
--- /dev/null
+++ b/cmd/phonemenu.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <cli.h>
+#include <command.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <log.h>
+#include <malloc.h>
+#include <menu.h>
+#include <video.h>
+#include <video_console.h>
+#include <version.h>
+#include <linux/string.h>
+
+/* Layout (pixels) */
+#define CARD_MARGIN_X		40
+#define HEADER_TITLE_Y		150
+#define HEADER_SLOT_Y		200
+#define HEADER_VERSION_Y	240
+#define HR_Y			290
+#define HR_THICK		2
+#define BODY_TOP		(HR_Y + HR_THICK + 36)
+#define SECTION_LABEL_H		44
+#define ITEM_H			72
+#define FOOTER_PAD		120
+#define INDENT_SECTION		88
+#define INDENT_ITEM		120
+
+/* Colours packed for X8R8G8B8 */
+#define RGB(r, g, b)		(((u32)(r) << 16) | ((u32)(g) << 8) | (u32)(b))
+#define COL_BG			RGB(0x0d, 0x11, 0x17)
+#define COL_HR			RGB(0x30, 0x36, 0x3d)
+#define COL_TITLE		RGB(0xf0, 0xf3, 0xf6)
+#define COL_SUB			RGB(0x7d, 0x85, 0x90)
+#define COL_SECTION		RGB(0x58, 0xa6, 0xff)
+#define COL_ITEM		RGB(0xc9, 0xd1, 0xd9)
+#define COL_HL_BG		RGB(0x1f, 0x6f, 0xeb)
+#define COL_HL_FG		RGB(0xff, 0xff, 0xff)
+#define COL_FOOTER		RGB(0x7d, 0x85, 0x90)
+
+/* The 16x32 bitmap font */
+#define FONT_W			16
+#define FONT_H			32
+
+enum pm_section {
+	PM_SEC_BOOT,
+	PM_SEC_USB,
+	PM_SEC_DIAG,
+	PM_SEC_SYS,
+	PM_SEC_COUNT,
+};
+
+struct pm_item {
+	const char *label;
+	const char *command;
+	enum pm_section section;
+};
+
+static const char * const pm_section_label[PM_SEC_COUNT] = {
+	[PM_SEC_BOOT] = "BOOT",
+	[PM_SEC_USB]  = "USB MODES",
+	[PM_SEC_DIAG] = "DIAGNOSTICS",
+	[PM_SEC_SYS]  = "SYSTEM",
+};
+
+static const struct pm_item pm_main[] = {
+	{ "Boot",             "run bootcmd",                              PM_SEC_BOOT },
+	{ "Advanced menu >",  "phonemenu advanced",                       PM_SEC_BOOT },
+	{ "Reset",            "reset",                                    PM_SEC_SYS  },
+	{ "Power off",        "phone_poweroff",                           PM_SEC_SYS  },
+};
+
+static const struct pm_item pm_advanced[] = {
+#if IS_ENABLED(CONFIG_USB_ETHER) && IS_ENABLED(CONFIG_CMD_TFTPBOOT)
+	{ "TFTP boot",        "run tftp_boot; phonemenu advanced",        PM_SEC_BOOT },
+#endif
+#if IS_ENABLED(CONFIG_USB_ETHER) && IS_ENABLED(CONFIG_CMD_PXE)
+	{ "PXE boot",         "run pxe_boot; phonemenu advanced",         PM_SEC_BOOT },
+#endif
+#if IS_ENABLED(CONFIG_USB_FUNCTION_ACM)
+	{ "Serial gadget",    "run serial_gadget",                        PM_SEC_USB  },
+#endif
+#if IS_ENABLED(CONFIG_CMD_USB_MASS_STORAGE)
+	{ "USB mass storage", "ums 0 ${storage} 0; phonemenu advanced",   PM_SEC_USB  },
+#endif
+#if IS_ENABLED(CONFIG_CMD_FASTBOOT)
+	{ "Fastboot",         "run fastboot; phonemenu advanced",         PM_SEC_USB  },
+#endif
+#if IS_ENABLED(CONFIG_CMD_DFU)
+	{ "DFU",              "dfu_pwr; phonemenu advanced",              PM_SEC_USB  },
+#endif
+	{ "Diagnostics >",    "phonemenu diag",                           PM_SEC_DIAG },
+	{ "< Back",           "phonemenu",                                PM_SEC_SYS  },
+};
+
+static const struct pm_item pm_diag[] = {
+	{ "Dump clocks",      "clk dump; pause; phonemenu diag",          PM_SEC_DIAG },
+	{ "Dump environment", "printenv; pause; phonemenu diag",          PM_SEC_DIAG },
+	{ "Bootargs",         "fdt addr $fdt_addr_r; fdt print /chosen bootargs; pause; "
+			      "phonemenu diag",                           PM_SEC_DIAG },
+	{ "Board info",       "bdinfo; pause; phonemenu diag",            PM_SEC_DIAG },
+	{ "Buttons",          "button list; pause; phonemenu diag",       PM_SEC_DIAG },
+	{ "< Back",           "phonemenu advanced",                       PM_SEC_SYS  },
+};
+
+struct pm_state {
+	struct udevice *vid;
+	struct udevice *vc;
+	struct video_priv *vp;
+	int w, h;
+	const struct pm_item *items;
+	int count;
+	int active;
+	int last_active;
+	int *row_y;
+	int *section_y;
+	int footer_y;
+	const char *title;
+	const char *subtitle;
+	const char *version;
+};
+
+static int pm_init_dev(struct pm_state *s)
+{
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_VIDEO, &s->vid);
+	if (ret)
+		return ret;
+	ret = uclass_first_device_err(UCLASS_VIDEO_CONSOLE, &s->vc);
+	if (ret)
+		return ret;
+
+	s->vp = dev_get_uclass_priv(s->vid);
+	s->w = video_get_xsize(s->vid);
+	s->h = video_get_ysize(s->vid);
+	return 0;
+}
+
+static void pm_text(struct pm_state *s, int x, int y, u32 fg, u32 bg,
+		    const char *str)
+{
+	s->vp->colour_fg = fg;
+	s->vp->colour_bg = bg;
+	vidconsole_set_cursor_pos(s->vc, x, y);
+	vidconsole_put_string(s->vc, (char *)str);
+}
+
+static int pm_center_x(struct pm_state *s, const char *str)
+{
+	int px = (int)strlen(str) * FONT_W;
+
+	return (s->w - px) / 2;
+}
+
+static void pm_layout(struct pm_state *s)
+{
+	enum pm_section prev = PM_SEC_COUNT;
+	int y = BODY_TOP;
+	int i;
+
+	for (i = 0; i < s->count; i++) {
+		if (s->items[i].section != prev) {
+			s->section_y[i] = y;
+			y += SECTION_LABEL_H;
+			prev = s->items[i].section;
+		} else {
+			s->section_y[i] = -1;
+		}
+		s->row_y[i] = y;
+		y += ITEM_H;
+	}
+	s->footer_y = s->h - FOOTER_PAD;
+}
+
+static void pm_draw_item(struct pm_state *s, int i, bool active)
+{
+	int y = s->row_y[i];
+	int text_y = y + (ITEM_H - FONT_H) / 2;
+	u32 fg, bg;
+
+	if (active) {
+		video_fill_part(s->vid, CARD_MARGIN_X, y,
+				s->w - CARD_MARGIN_X, y + ITEM_H,
+				COL_HL_BG);
+		fg = COL_HL_FG;
+		bg = COL_HL_BG;
+	} else {
+		video_fill_part(s->vid, CARD_MARGIN_X, y,
+				s->w - CARD_MARGIN_X, y + ITEM_H,
+				COL_BG);
+		fg = COL_ITEM;
+		bg = COL_BG;
+	}
+
+	pm_text(s, INDENT_ITEM, text_y, fg, bg, s->items[i].label);
+}
+
+static void pm_draw_frame(struct pm_state *s)
+{
+	int hr_x0 = CARD_MARGIN_X + 20;
+	int hr_x1 = s->w - CARD_MARGIN_X - 20;
+	const char *foot = "Vol up/down to move    Power to select";
+	int i;
+
+	video_fill_part(s->vid, 0, 0, s->w, s->h, COL_BG);
+
+	pm_text(s, pm_center_x(s, s->title), HEADER_TITLE_Y,
+		COL_TITLE, COL_BG, s->title);
+
+	if (s->subtitle && *s->subtitle)
+		pm_text(s, pm_center_x(s, s->subtitle), HEADER_SLOT_Y,
+			COL_SUB, COL_BG, s->subtitle);
+
+	if (s->version && *s->version)
+		pm_text(s, pm_center_x(s, s->version), HEADER_VERSION_Y,
+			COL_SUB, COL_BG, s->version);
+
+	video_fill_part(s->vid, hr_x0, HR_Y, hr_x1, HR_Y + HR_THICK, COL_HR);
+
+	for (i = 0; i < s->count; i++) {
+		if (s->section_y[i] < 0)
+			continue;
+		pm_text(s, INDENT_SECTION, s->section_y[i],
+			COL_SECTION, COL_BG,
+			pm_section_label[s->items[i].section]);
+	}
+
+	video_fill_part(s->vid, hr_x0, s->footer_y - 36,
+			hr_x1, s->footer_y - 36 + HR_THICK, COL_HR);
+	pm_text(s, pm_center_x(s, foot), s->footer_y,
+		COL_FOOTER, COL_BG, foot);
+}
+
+static void pm_render_all(struct pm_state *s)
+{
+	int i;
+
+	pm_draw_frame(s);
+	for (i = 0; i < s->count; i++)
+		pm_draw_item(s, i, i == s->active);
+	video_sync(s->vid, true);
+}
+
+static int pm_run(const struct pm_item *items, int count,
+		  const char *title, const char *subtitle, const char *version)
+{
+	struct pm_state s = { 0 };
+	struct cli_ch_state cch;
+	struct bootmenu_data nav = {
+		.delay = -1,
+		.active = 0,
+		.last_active = 0,
+		.count = count,
+		.first = NULL,
+	};
+	const char *cmd;
+	bool running = true;
+	int ret = CMD_RET_SUCCESS;
+
+	if (pm_init_dev(&s))
+		return CMD_RET_FAILURE;
+
+	s.items = items;
+	s.count = count;
+	s.title = title;
+	s.subtitle = subtitle;
+	s.version = version;
+	s.row_y = calloc(count, sizeof(int));
+	s.section_y = calloc(count, sizeof(int));
+	if (!s.row_y || !s.section_y) {
+		ret = CMD_RET_FAILURE;
+		goto cleanup;
+	}
+
+	pm_layout(&s);
+	pm_render_all(&s);
+
+	cli_ch_init(&cch);
+	while (running) {
+		enum bootmenu_key k = bootmenu_loop(&nav, &cch);
+
+		switch (k) {
+		case BKEY_UP:
+			/* Wrap from item 0 around to the last item. */
+			s.last_active = s.active;
+			s.active = s.active ? s.active - 1 : count - 1;
+			pm_draw_item(&s, s.last_active, false);
+			pm_draw_item(&s, s.active, true);
+			video_sync(s.vid, true);
+			break;
+		case BKEY_DOWN:
+			/* Wrap from the last item back to item 0. */
+			s.last_active = s.active;
+			s.active = (s.active < count - 1) ? s.active + 1 : 0;
+			pm_draw_item(&s, s.last_active, false);
+			pm_draw_item(&s, s.active, true);
+			video_sync(s.vid, true);
+			break;
+		case BKEY_SELECT:
+			running = false;
+			break;
+		case BKEY_QUIT:
+			s.active = count - 1;
+			running = false;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Repaint to BG before running the chosen command */
+	video_fill_part(s.vid, 0, 0, s.w, s.h, COL_BG);
+	vidconsole_set_cursor_pos(s.vc, 16, 0);
+	s.vp->colour_fg = COL_ITEM;
+	s.vp->colour_bg = COL_BG;
+	video_sync(s.vid, true);
+
+	cmd = items[s.active].command;
+	if (cmd && cmd[0])
+		run_command((char *)cmd, 0);
+	/* an empty command leaves us at the console */
+
+cleanup:
+	free(s.row_y);
+	free(s.section_y);
+	return ret;
+}
+
+static const char *pm_codename(void)
+{
+	static char buf[32];
+	const char *compat;
+	const char *p;
+
+	compat = ofnode_read_string(ofnode_root(), "compatible");
+	if (!compat || !*compat)
+		return "unknown";
+
+	p = strchr(compat, ',');
+	if (p)
+		compat = p + 1;
+
+	strlcpy(buf, compat, sizeof(buf));
+	return buf;
+}
+
+static int do_phonemenu(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	const char *sub = (argc > 1) ? argv[1] : "main";
+
+	if (!strcmp(sub, "advanced"))
+		return pm_run(pm_advanced, ARRAY_SIZE(pm_advanced),
+			      "Advanced menu", NULL, U_BOOT_VERSION);
+
+	if (!strcmp(sub, "diag"))
+		return pm_run(pm_diag, ARRAY_SIZE(pm_diag),
+			      "Diagnostics", NULL, U_BOOT_VERSION);
+
+	return pm_run(pm_main, ARRAY_SIZE(pm_main),
+		      pm_codename(), NULL, U_BOOT_VERSION);
+}
+
+U_BOOT_CMD(phonemenu, 2, 0, do_phonemenu,
+	   "pixel-drawn sectioned boot menu",
+	   "[advanced|diag]\n"
+	   "    - Render the main menu (default), the advanced menu or the\n"
+	   "      diagnostics submenu.\n"
+	   "      Navigation: Vol up/down to move, Power to select.\n");

-- 
2.55.0


