Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27643C54E5D
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 13:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41E7C87FEC;
	Sat, 16 Mar 2024 14:54:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHBqe9xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3449A87BF1; Sat, 16 Mar 2024 14:54:43 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC8187D09
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 14:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-414087091b3so3579655e9.0
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710597278; x=1711202078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPcxqyTeUTFtLFpSljl4ZTM1noOjuExPBLyjmd+rHbA=;
 b=ZHBqe9xdk7EuO6YM3iHRx4tx/CZHBB5ZItQEpeDvF+awFxWGUg/Fqm/khs0IPczpoo
 EOqXNYzq25jSEA/7YYZxGsH4c4jHWc+O057akxfRsn2f+nEX1/0rQOsBVd2LX+YbWELF
 YEmxouL6BtLSQdK4QFdmQrvSNOa5nQYuViVv9bqS5lEmNoEZfLsITBuHTpnoe4qQJcHs
 vWTapTreUn0VMEZXF1qwlouiipfndRM3glATuUGJnXJro73Tm+ijkyjejA0NHAgFLfDc
 Hg57pAblyZx/+9ZYzvbOp37OgL7ZULAZuiGr8/94T36XEIcBUD4oiTUCCH82/8HhmcjL
 zJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710597278; x=1711202078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPcxqyTeUTFtLFpSljl4ZTM1noOjuExPBLyjmd+rHbA=;
 b=s4tHAWVYL2szwOOqnNbn1tFeclSEaZl/IL4aHDpqL0zs9GbRWD30npG+rddWABbp1C
 IdYqgm34tzGfZn/xXfTMsrXXC8CIuh5N0YCk89mfgs7Gj7qkt0KEhhBLVCt+pc2E3JKa
 b/Z5JWPBrKKeLPbvpagmypdAbyNNGuXm5xT9TLKnBX/crUOxRZ7bjYb3lT+datX8RXE8
 MZE8YMwBv60U3EZYkGMV4KtspuSNs6QyOUIKB2RDjaL/imZ/9g7M6uS02JsG/UBxjau7
 BSr/EyfwYTy9qrCV83M/HVRKbNV8alMTz6gqHGk0sNYrPJXs8xWM+10LY0g9+l+laCjH
 MByQ==
X-Gm-Message-State: AOJu0Yx7WjRNpmOqMUIIe8VEDVbZ9/JWvfsy68zL89vI7s+CvYLX2hoV
 K02LwrFS/k+fE51r2BYloMQzPLt87BUyL2rXTaIqQpE427U9ppUaYKtQlJpNcLM=
X-Google-Smtp-Source: AGHT+IEYG0eH4ayJUBr8ecRr7PG/f3qDBKXctrgFmfXcnYwNZccND8AUuoO0Z4plKiEDHJJUHtl5jQ==
X-Received: by 2002:a05:600c:a0b:b0:414:21b:9a92 with SMTP id
 z11-20020a05600c0a0b00b00414021b9a92mr1581883wmp.8.1710597278092; 
 Sat, 16 Mar 2024 06:54:38 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0041409fa57c4sm523963wmq.34.2024.03.16.06.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Mar 2024 06:54:37 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 linux-amlogic@lists.infradead.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] ARM: board: meson: update efuse MAC reading code
Date: Sat, 16 Mar 2024 13:54:29 +0000
Message-Id: <20240316135430.826898-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316135430.826898-1-christianshewitt@gmail.com>
References: <20240316135430.826898-1-christianshewitt@gmail.com>
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

Current code used for reading the factory programmed MAC from efuse on
p200 boards does not appear to work resulting in a random MAC being
generated. Update the p200 board data reusing the function from the VIM3
source.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 board/amlogic/p200/p200.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 7c432f9d281..fb07eefa532 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -14,29 +14,36 @@
 #include <asm/arch/eth.h>
 #include <asm/arch/mem.h>
 
-#define EFUSE_SN_OFFSET		20
-#define EFUSE_SN_SIZE		16
-#define EFUSE_MAC_OFFSET	52
-#define EFUSE_MAC_SIZE		6
+#define EFUSE_MAC_OFFSET	0
+#define EFUSE_MAC_SIZE		12
+#define MAC_ADDR_LEN		6
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	u8 mac_addr[MAC_ADDR_LEN];
+	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
-					  mac_addr, EFUSE_MAC_SIZE);
-		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
+					  efuse_mac_addr, EFUSE_MAC_SIZE);
+		if (len != EFUSE_MAC_SIZE)
+			return 0;
+
+		/* MAC is stored in ASCII format, 1bytes = 2characters */
+		for (int i = 0; i < 6; i++) {
+			tmp[0] = efuse_mac_addr[i * 2];
+			tmp[1] = efuse_mac_addr[i * 2 + 1];
+			tmp[2] = '\0';
+			mac_addr[i] = simple_strtoul(tmp, NULL, 16);
+		}
+
+		if (is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
-	}
+		else
+			meson_generate_serial_ethaddr();
 
-	if (!env_get("serial#")) {
-		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
-			EFUSE_SN_SIZE);
-		if (len == EFUSE_SN_SIZE)
-			env_set("serial#", serial);
+		eth_env_get_enetaddr("ethaddr", mac_addr);
 	}
 
 	return 0;
-- 
2.34.1

