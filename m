Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D96C25B75
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47378873A;
	Tue, 21 May 2024 09:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BUQksAvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B038874C; Tue, 21 May 2024 09:14:01 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD59A87FA1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B939F6201E;
 Tue, 21 May 2024 07:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C5FC32782;
 Tue, 21 May 2024 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275637;
 bh=sgeNpu9nIELa68JF0KxLROY2xwH/8x3+ZchzuK1nXAg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BUQksAvXUiInW/qbFrvX0Ozjrep42yxXjRP3sROcSCAej3WwVAK8uBBBHETf7d1jB
 2UbEi5GbOPqqpnOUwnOZJXhuOsOOaFTV+H3PqKkOiEF+NOygjNGJbVPBQhb0/mb12h
 xNDwEdWsx1UByNDxXyyHgh0nnkISh5cyFEUrG/9tn0bNg3rNVyC79PmBpy3Uzs6a77
 mlZS0nZryJevojtHe1Bog/DGkQ+v3JDzB4ArLb7cVp2A/bqcDUW22SF5B/IZJIY65o
 aOHZ2sWU1NSOQwIHusnUySVv54+uuAewz0AOBN6QuTL7ipKvn95n+7ZO+1y0T1pMyZ
 LYtQLUnKpoGvA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 09/11] cmd: eeprom: Refactor command execution into function
 by action
Date: Tue, 21 May 2024 09:13:33 +0200
Message-ID: <20240521071335.4193-10-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Refactor the eeprom_execute_command() function into separate functions
do_eeprom_rw(), do_eeprom_print() and do_eeprom_update().

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/eeprom.c | 111 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 40 deletions(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index e29639780d..c76cf43157 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -288,61 +288,75 @@ static enum eeprom_action parse_action(char *cmd)
 	return EEPROM_ACTION_INVALID;
 }
 
-static int eeprom_execute_command(enum eeprom_action action,
-				  struct eeprom_dev_spec *dev,
-				  int layout_ver, char *key, char *value,
-				  ulong addr, ulong off, ulong cnt)
+static int do_eeprom_rw(struct eeprom_dev_spec *dev, bool read,
+			ulong addr, ulong off, ulong cnt)
 {
-	int rcode = 0;
 	const char *const fmt =
 		"\nEEPROM @0x%lX %s: addr 0x%08lx  off 0x%04lx  count %ld ... ";
+	uchar *memloc = (uchar *)addr;
+	int ret;
+
+	printf(fmt, dev->i2c_addr, read ? "read" : "write", addr, off, cnt);
+	if (read)
+		ret = eeprom_read(dev->i2c_addr, off, memloc, cnt);
+	else
+		ret = eeprom_write(dev->i2c_addr, off, memloc, cnt);
+	puts("done\n");
+
+	return ret;
+}
+
 #ifdef CONFIG_CMD_EEPROM_LAYOUT
-	struct eeprom_layout layout;
-#endif
 
-	if (action == EEPROM_ACTION_INVALID)
-		return CMD_RET_USAGE;
+static int do_eeprom_layout(struct eeprom_dev_spec *dev, int layout_ver,
+			    struct eeprom_layout *layout)
+{
+	int ret;
 
-	eeprom_init(dev->i2c_bus);
-	if (action == EEPROM_READ) {
-		printf(fmt, dev->i2c_addr, "read", addr, off, cnt);
+	ret = eeprom_read(dev->i2c_addr, 0, eeprom_buf, CONFIG_SYS_EEPROM_SIZE);
+	if (ret)
+		return ret;
 
-		rcode = eeprom_read(dev->i2c_addr, off, (uchar *)addr, cnt);
+	eeprom_layout_setup(layout, eeprom_buf, CONFIG_SYS_EEPROM_SIZE,
+			    layout_ver);
 
-		puts("done\n");
-		return rcode;
-	} else if (action == EEPROM_WRITE) {
-		printf(fmt, dev->i2c_addr, "write", addr, off, cnt);
+	return 0;
+}
 
-		rcode = eeprom_write(dev->i2c_addr, off, (uchar *)addr, cnt);
+static int do_eeprom_print(struct eeprom_dev_spec *dev, int layout_ver)
+{
+	struct eeprom_layout layout;
+	int ret;
 
-		puts("done\n");
-		return rcode;
-	}
+	ret = do_eeprom_layout(dev, layout_ver, &layout);
+	if (ret)
+		return ret;
 
-#ifdef CONFIG_CMD_EEPROM_LAYOUT
-	rcode = eeprom_read(dev->i2c_addr, 0, eeprom_buf,
-			    CONFIG_SYS_EEPROM_SIZE);
-	if (rcode < 0)
-		return rcode;
+	layout.print(&layout);
 
-	eeprom_layout_setup(&layout, eeprom_buf, CONFIG_SYS_EEPROM_SIZE,
-			    layout_ver);
+	return 0;
+}
 
-	if (action == EEPROM_PRINT) {
-		layout.print(&layout);
-		return 0;
-	}
+static int do_eeprom_update(struct eeprom_dev_spec *dev, int layout_ver,
+			    char *key, char *value)
+{
+	struct eeprom_layout layout;
+	int ret;
 
-	layout.update(&layout, key, value);
+	ret = do_eeprom_layout(dev, layout_ver, &layout);
+	if (ret)
+		return ret;
 
-	rcode = eeprom_write(dev->i2c_addr, 0, layout.data,
-			     CONFIG_SYS_EEPROM_SIZE);
-#endif
+	ret = layout.update(&layout, key, value);
+	if (ret)
+		return CMD_RET_FAILURE;
 
-	return rcode;
+	return eeprom_write(dev->i2c_addr, 0, layout.data,
+			    CONFIG_SYS_EEPROM_SIZE);
 }
 
+#endif
+
 static int eeprom_action_expected_argc(enum eeprom_action action)
 {
 	switch (action) {
@@ -361,13 +375,15 @@ static int eeprom_action_expected_argc(enum eeprom_action action)
 #define NEXT_PARAM(argc, index)	{ (argc)--; (index)++; }
 int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	int layout_ver = LAYOUT_VERSION_AUTODETECT;
 	enum eeprom_action action = EEPROM_ACTION_INVALID;
 	struct eeprom_dev_spec dev;
 	ulong addr = 0, cnt = 0, off = 0;
 	int ret, index = 0;
+#ifdef CONFIG_CMD_EEPROM_LAYOUT
 	char *field_name = "";
 	char *field_value = "";
+	int layout_ver = LAYOUT_VERSION_AUTODETECT;
+#endif
 
 	if (argc <= 1)
 		return CMD_RET_USAGE;
@@ -416,8 +432,23 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	return eeprom_execute_command(action, &dev, layout_ver, field_name,
-				      field_value, addr, off, cnt);
+	eeprom_init(dev.i2c_bus);
+
+	switch (action) {
+	case EEPROM_READ:
+	case EEPROM_WRITE:
+		return do_eeprom_rw(&dev, action == EEPROM_READ,
+				    addr, off, cnt);
+#ifdef CONFIG_CMD_EEPROM_LAYOUT
+	case EEPROM_PRINT:
+		return do_eeprom_print(&dev, layout_ver);
+	case EEPROM_UPDATE:
+		return do_eeprom_update(&dev, layout_ver,
+					field_name, field_value);
+#endif
+	default:
+		return CMD_RET_USAGE;
+	}
 }
 
 #ifdef CONFIG_EEPROM_LAYOUT_VERSIONS
-- 
2.44.1

