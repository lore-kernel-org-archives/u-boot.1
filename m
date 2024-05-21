Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE53C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CB788744;
	Tue, 21 May 2024 09:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P46bUfWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE3A88737; Tue, 21 May 2024 09:13:59 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8118871D
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4A8D4CE0E90;
 Tue, 21 May 2024 07:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDDFC32782;
 Tue, 21 May 2024 07:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275633;
 bh=2WVShhLd/mAQ4BLHQm+cBILxCcDGdEePcpU7WxN5c/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P46bUfWue47BsBForB4LGFvETo4NJnNgxgD7wA79Zm2ixESE9SELZ3wqfYxQHmXgg
 T6JB7S9xLagTYskHrvlgUWqG9MSeGJye7Fqhrp94FkjyGbBruC6RCWERQjJXVTRoFf
 wLjvOIoVSxNX9tedICtlQI0h9WC5asCpM3SDhqSFDCHAQL7u0HIGXSDKcS+qGgx6jI
 vXbLIHAicXwjEv+6cJXuL6Iti9C3GrrvlbvGiVcd9/sFMTw/SK0WwRwdd2AlBjyDFI
 7pP8YHBE4xDlJ8csB0tuowwRwW1A+Ty8TpJgmyF9wYX0XJsgPks0Fk30N/ozKDi7xF
 5LbYEwOyG6ZEg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 07/11] cmd: eeprom: Deduplicate parse_i2c_bus_addr() calls
Date: Tue, 21 May 2024 09:13:31 +0200
Message-ID: <20240521071335.4193-8-kabel@kernel.org>
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

Deduplicate the calls to parse_i2c_bus_addr().

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/eeprom.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index d610dc9931..12902e812e 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -339,6 +339,21 @@ static int eeprom_execute_command(enum eeprom_action action, int i2c_bus,
 	return rcode;
 }
 
+static int eeprom_action_expected_argc(enum eeprom_action action)
+{
+	switch (action) {
+	case EEPROM_READ:
+	case EEPROM_WRITE:
+		return 3;
+	case EEPROM_PRINT:
+		return 0;
+	case EEPROM_UPDATE:
+		return 2;
+	default:
+		return CMD_RET_USAGE;
+	}
+}
+
 #define NEXT_PARAM(argc, index)	{ (argc)--; (index)++; }
 int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
@@ -371,25 +386,8 @@ int do_eeprom(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 #endif
 
-	switch (action) {
-	case EEPROM_READ:
-	case EEPROM_WRITE:
-		ret = parse_i2c_bus_addr(&i2c_bus, &i2c_addr, argc,
-					 argv + index, 3);
-		break;
-	case EEPROM_PRINT:
-		ret = parse_i2c_bus_addr(&i2c_bus, &i2c_addr, argc,
-					 argv + index, 0);
-		break;
-	case EEPROM_UPDATE:
-		ret = parse_i2c_bus_addr(&i2c_bus, &i2c_addr, argc,
-					 argv + index, 2);
-		break;
-	default:
-		/* Get compiler to stop whining */
-		return CMD_RET_USAGE;
-	}
-
+	ret = parse_i2c_bus_addr(&i2c_bus, &i2c_addr, argc, argv + index,
+				 eeprom_action_expected_argc(action));
 	if (ret == CMD_RET_USAGE)
 		return ret;
 
-- 
2.44.1

