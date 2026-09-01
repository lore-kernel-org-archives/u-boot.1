Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3161DC624CF
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D652C60770;
	Tue,  1 Sep 2026 09:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzBGWhcIdSOk; Tue,  1 Sep 2026 09:13:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788254016;
	bh=s1YSvzxwFLDHhEKOMwN7O/NURQVQfNyDwdtuvS6m7HY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qxNuHq6eANQ5Cl614iJLrJAh8yV5ef2PkEn+4ptBkWJ94sQoYoYcR5zbkWes8wmps
	 /eZlG6Gk+XcWLyZYgd0HkT4iMJqo1oQWNnGC9eNl30OSInzP3TSuDSv1r0Dgr6womW
	 bAQ4nt6Fz7bSKIHNZTLO3LUTofMaV9jL+DHwAL5TYH/BSgTF0PFsD14Ra2GprX9+64
	 UoeKD37Ouq5qED0jL+o5vlo48jNMc3Zj239ST9ddEE3nna/CkOkBePN58qdJtblWCs
	 Uoh16KLJEj7sHPI3ZtZPukM26Fa1NOw5R+BEVTOYwgaGlbb91LkZDNGUh/07kJbwc2
	 4DaTX29Avskiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7E4D60769;
	Tue,  1 Sep 2026 09:13:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32081105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1488040189
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vuECNwcXO2KJ for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jvs/1Fld
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 25379400A8
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B341041A46;
 Tue,  1 Sep 2026 09:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A511F000E9;
 Tue,  1 Sep 2026 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788254012;
 bh=s1YSvzxwFLDHhEKOMwN7O/NURQVQfNyDwdtuvS6m7HY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jvs/1Fldt1BtAnhYdz11nJkLhwehx1K2S+RwPxXWB4Y8pffP0qWz9LM0X/kd0bXqt
 AveMXsh8b01sFfcg7M5220egFrq56/qM6bZ1fmtfQ5sqArWfTInMG0P7/Fg/ABT+CM
 tF683ZaVGrdEHxil8No3CUb/gxGWAhv35fAJ7kjzCRYEonidY/pu90KoESgcRjHPNd
 3G1cgDEZSDrcJ/zhS/ailWi94QZqaA5RofBIAjYmPytHg9tJPSzc/DKwqpyP3Kw/xi
 HhtAqCQgl2umSqXl01rU8VGwkomQd9nwB6KcANEjLk/BABX94m9j+VklFC45nlvuM2
 JXP3/WPtoVKhg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:11 +0200
Subject: [PATCH v7 13/13] arm: u8500: Package Stemmy device trees in FIT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-13-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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
appended to Stemmy U-Boot. Select the appropriate configuration at
runtime from the machine ID passed by the Samsung firmware. Codina
and Codina TMO share a machine ID, so distinguish Codina TMO by its
board ID.

Keep the multi-DTB FIT selection, default device tree and device tree
list in stemmy_defconfig. This leaves the base U8500 platform available
to non-Samsung devices (non-Stemmy) using their own board, defconfig
and device tree selection.

Print the firmware machine and board IDs to aid diagnostics and future
machine ID mappings.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 board/ste/stemmy/stemmy.c | 77 ++++++++++++++++++++++++++++++++++++++++++++---
 configs/stemmy_defconfig  |  2 ++
 2 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 66330184af86..8526deeb29bc 100644
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
@@ -40,6 +45,70 @@ static const struct tag *fw_atags_get(void)
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
+	case 3296:
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
@@ -96,11 +165,6 @@ static void parse_serial(const struct tag_serialnr *serialnr)
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
@@ -181,6 +245,9 @@ static void copy_atags(const struct tag *tags)
 int misc_init_r(void)
 {
 	copy_atags(fw_atags_get());
+	printf("Firmware machine ID: %lu, board ID: %lu\n",
+	       fw_mach, board_id);
+
 	return 0;
 }
 
diff --git a/configs/stemmy_defconfig b/configs/stemmy_defconfig
index c253780df2ef..7c9df043457e 100644
--- a/configs/stemmy_defconfig
+++ b/configs/stemmy_defconfig
@@ -12,6 +12,8 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="st/ste-ux500-samsung-janice"
+CONFIG_OF_LIST="st/ste-ux500-samsung-codina st/ste-ux500-samsung-codina-tmo st/ste-ux500-samsung-gavini st/ste-ux500-samsung-golden st/ste-ux500-samsung-janice st/ste-ux500-samsung-kyle st/ste-ux500-samsung-skomer"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000

-- 
2.55.0

