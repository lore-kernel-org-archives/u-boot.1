Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C681C5DF88
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 08:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1684080E7E;
	Wed, 19 Aug 2026 08:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhaKi3HgTUZB; Wed, 19 Aug 2026 08:54:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787129676;
	bh=2lmYs+OZFQhicBPlnZASDkZcjIpoGOOuN2pCgJDjwk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VhwHMogEfw9fgDxLvMc6uWbyhbErZtJYLSeuJxgy8gif7TnpMdGp9woXuws+veuUL
	 1d1cfkh6EdHr5BvVwiKw0CwZvHX7tWRTXH9mKCAGyJ3reR9XWHNg+W0ai38jyrUcYt
	 L5A4D5fu1hvfIFveKmO1YmEZSSmLw5o+qfBjUfxCy8xgZhT8vQkKVxdQiQ16wCFnyz
	 I/1biSUaPGezT8fwbs3FGqvWwQg1unEGDtwvQnWhoslrDO83HvCxx3LrUycZCuGH1P
	 cWju9g0LpSLRACnHjhILO0i3ea8ZnPstMugn92tIHdHv66lLXQkyvb6F7cTjwVlkYH
	 y2CAr5h/g5t/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 534A380E73;
	Wed, 19 Aug 2026 08:54:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BF7A823F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A616380E0E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTFwArV1ifp9 for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 08:54:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lD1mL7I9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8A9480E5D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 08:54:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 67E264008F;
 Wed, 19 Aug 2026 08:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDB61F000E9;
 Wed, 19 Aug 2026 08:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787129670;
 bh=2lmYs+OZFQhicBPlnZASDkZcjIpoGOOuN2pCgJDjwk0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lD1mL7I9r5RvrGsoldtEhXQAyp0u5R6SqKzJRc5mK5zaw1o/gHuX/PrNi/xF/tTpy
 lUfMOa6VfgnjdfjgsINUF6emVidcqiqY75ExLYwm/gCsq+9sZPoxIhyyNHEJNXmitE
 WZjQZLYU4X4Gzj6p/68kyB75q/hoZGh3T6Xsfzr5q4QKuTgJSd2ZQrZFCCP95hwSh9
 MESLEaNNdid/HcYkKet82tiH3mtGZNEgVcoDp5Rn1rYLtq5+X7EzPQIHRfSF1PURMQ
 W9k9LTkhjIRQZVNd8TLdHpv2OwEdm7gHHwIVaIRYDYi1BcMgGp9g9l4dIANNve9GOb
 LZ2SalRcy2erw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 19 Aug 2026 10:54:17 +0200
Subject: [PATCH v4 12/12] arm: u8500: Package Stemmy device trees in FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-ux500-external-sdcard-v4-12-f1c8c9ffac30@kernel.org>
References: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
In-Reply-To: <20260819-ux500-external-sdcard-v4-0-f1c8c9ffac30@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Build all seven supported Samsung Ux500 device trees into the FIT
appended to U-Boot. Select the appropriate configuration at runtime
from the machine ID passed by the Samsung firmware. Codina and Codina
TMO share a machine ID, so distinguish Codina TMO by its board ID.

Keep a Kconfig default for the generic multi-DTB build dependency, but
remove it from the defconfig since the board selection is now dynamic.
Print the firmware machine and board IDs to aid diagnostics and future
machine ID mappings.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/Kconfig          |  1 +
 board/ste/stemmy/Kconfig  |  6 ++++
 board/ste/stemmy/stemmy.c | 76 +++++++++++++++++++++++++++++++++++++++++++----
 configs/stemmy_defconfig  |  1 -
 4 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2a01ac9b7675..8e697b87d50f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1278,6 +1278,7 @@ config ARCH_U8500
 	imply DM_REGULATOR
 	imply DM_REGULATOR_FIXED
 	imply DM_RTC
+	imply MULTI_DTB_FIT
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER
 	imply PINCTRL
diff --git a/board/ste/stemmy/Kconfig b/board/ste/stemmy/Kconfig
index b890ba51cb03..e891ddf9f8b2 100644
--- a/board/ste/stemmy/Kconfig
+++ b/board/ste/stemmy/Kconfig
@@ -9,4 +9,10 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "stemmy"
 
+config DEFAULT_DEVICE_TREE
+	default "st/ste-ux500-samsung-janice"
+
+config OF_LIST
+	default "st/ste-ux500-samsung-codina st/ste-ux500-samsung-codina-tmo st/ste-ux500-samsung-gavini st/ste-ux500-samsung-golden st/ste-ux500-samsung-janice st/ste-ux500-samsung-kyle st/ste-ux500-samsung-skomer"
+
 endif
diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 66330184af86..e0bcc3a7675e 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -21,6 +21,11 @@ static ulong fw_atags __section(".data");
 static const struct tag *fw_atags_copy;
 static uint fw_atags_size;
 
+#define SBL_BOARD "board_id="
+#define SBL_LCDTYPE "lcdtype="
+static ulong board_id;
+static ulong lcdtype;
+
 void save_boot_params(ulong r0, ulong r1, ulong r2, ulong r3)
 {
 	fw_mach = r1;
@@ -40,6 +45,69 @@ static const struct tag *fw_atags_get(void)
 	return tags;
 }
 
+static ulong fw_board_id_get(void)
+{
+	const struct tag *t, *tags = fw_atags_get();
+	const char *str;
+
+	if (!tags)
+		return 0;
+
+	for_each_tag(t, tags) {
+		if (t->hdr.tag != ATAG_CMDLINE)
+			continue;
+
+		str = strstr(t->u.cmdline.cmdline, SBL_BOARD);
+		if (str)
+			return simple_strtoul(str + strlen(SBL_BOARD), NULL, 10);
+	}
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const char *dt_name;
+
+	switch (fw_mach) {
+	case 5000:
+		dt_name = "ste-ux500-samsung-janice";
+		break;
+	case 5002:
+		dt_name = "ste-ux500-samsung-gavini";
+		break;
+	case 5003:
+		switch (fw_board_id_get()) {
+		case 0x101:
+		case 0x102:
+		case 0x103:
+		case 0x104:
+		case 0x105:
+		case 0x106:
+		case 0x107:
+			dt_name = "ste-ux500-samsung-codina-tmo";
+			break;
+		default:
+			dt_name = "ste-ux500-samsung-codina";
+			break;
+		}
+		break;
+	case 5006:
+		dt_name = "ste-ux500-samsung-kyle";
+		break;
+	case 5008:
+		dt_name = "ste-ux500-samsung-golden";
+		break;
+	case 5009:
+		dt_name = "ste-ux500-samsung-skomer";
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	return strcmp(name, dt_name);
+}
+
 int dram_init(void)
 {
 	const struct tag *t, *tags = fw_atags_get();
@@ -96,11 +164,6 @@ static void parse_serial(const struct tag_serialnr *serialnr)
 	env_set("serial#", serial);
 }
 
-#define SBL_BOARD "board_id="
-#define SBL_LCDTYPE "lcdtype="
-static ulong board_id = 0;
-static ulong lcdtype = 0;
-
 static void parse_cmdline(const struct tag_cmdline *cmdline)
 {
 	char *buf;
@@ -181,6 +244,9 @@ static void copy_atags(const struct tag *tags)
 int misc_init_r(void)
 {
 	copy_atags(fw_atags_get());
+	printf("Firmware machine ID: %lu, board ID: %lu\n",
+	       fw_mach, board_id);
+
 	return 0;
 }
 
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index 2bc395a2682e..e63ac4c6392d 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -11,7 +11,6 @@ CONFIG_SYS_MALLOC_F_LEN=0x400
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
-CONFIG_DEFAULT_DEVICE_TREE="st/ste-ux500-samsung-janice"
 CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000

-- 
2.55.0

