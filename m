Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B514C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 09:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DF98883E;
	Wed, 24 Jul 2024 11:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFBB/i1R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206AC88800; Wed, 24 Jul 2024 11:59:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 288C8888EB
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 11:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fedorross@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso109660666b.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721815190; x=1722419990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QAW0aZt2uOveWNSDN7OoWr6YrblOi+pWOwPTj9MZNog=;
 b=hFBB/i1RAonZbGw9LTxyoSufDya9JuV+TFzqEp5qzJWOvFGvdFJiSCWCS7ht3BP8+V
 QWHiafDS8JO1jKBfuUSyxkKgRZ+C5nHNwQ23NvCZDXRUgJvgBqtv69lUymqdVguTNQPK
 +lf4apJCEsmcPGEvf9XrsPdy4impZhjcwqzyVGpTPwAK6j9V6yqOyMzI9ujK+CpZNXnU
 APsNE/6Dei32iXNaqexsmkD7AV709IiLbxcM9o5C10pAhXj+EUGKLd2FpJVan5VQRxwv
 Oz4x32iqgscw+1nFpgSpc/4no/NCXyejGmzRpamUBpUPwndVBrAas21EcKUY7yrG4nsi
 O38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721815190; x=1722419990;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QAW0aZt2uOveWNSDN7OoWr6YrblOi+pWOwPTj9MZNog=;
 b=gbB+BHVXCwW+XxUC7J5OQsfaKVSxHjt+V98YNXIIOnu0QeDTSLeAiBAa/+PndigXj1
 zVxfVnzDSlBX+YOVvm6BErsBGN6R6YZt/kXaRBE8xE4iJsJb6bJpq96s+YYy+/qJNJiV
 11lOCSAsHSx268ukb8ZS4cZuj28q1YwDTl5JExDsdSd40kw+wTNHUxkh8LkMFAZnVN77
 RKLSTLuRM/DpimmI3AfsAYURg06geQ/0A9NIdccA9LKfzqhIc2RCuP9DmuOHSkyWdBu+
 O9fFiFJstrwr/urfmMMkOUInMCY/J4ytH2NBkhv4gBl6TyMiDhxdbLuvaP70IRAFwKGV
 HVdw==
X-Gm-Message-State: AOJu0Yye5wChjGJRqPUmULepz4uQMLU4z9vvR7BLsx6qbZ3fuQP7j3hr
 mrY68QNl5pwcgzV5DeSlZ0FtH9Vz0LOS5i3ddtfvtbd4HdqV7mLoRt5ztg==
X-Google-Smtp-Source: AGHT+IFWDlabGdGO+e6GuBd+S8N0pNBRQ97yumYgTiHxVX/8z+9GlRus36DUq+H56mf4J5IgWusgMg==
X-Received: by 2002:a17:907:9443:b0:a7a:b43e:86d5 with SMTP id
 a640c23a62f3a-a7ab43e8c83mr100240766b.56.1721815189679; 
 Wed, 24 Jul 2024 02:59:49 -0700 (PDT)
Received: from localhost.localdomain ([147.161.231.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785d64sm625226666b.28.2024.07.24.02.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 02:59:49 -0700 (PDT)
From: fedorross@gmail.com
X-Google-Original-From: fedor.ross@ifm.com
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 1/3] i2c: imx_lpi2c: Fix a typo in bus_i2c_receive
Date: Wed, 24 Jul 2024 11:59:41 +0200
Message-Id: <20240724095943.214967-1-fedor.ross@ifm.com>
X-Mailer: git-send-email 2.34.1
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

From: Fedor Ross <fedor.ross@ifm.com>

Fix a typo in a debug message. It should be 'for' not 'fot' .

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>
---
 drivers/i2c/imx_lpi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/imx_lpi2c.c b/drivers/i2c/imx_lpi2c.c
index a1be841b119..3c43f61d819 100644
--- a/drivers/i2c/imx_lpi2c.c
+++ b/drivers/i2c/imx_lpi2c.c
@@ -130,7 +130,7 @@ static int bus_i2c_receive(struct udevice *bus, u8 *rxbuf, int len)
 
 	result = bus_i2c_wait_for_tx_ready(regs);
 	if (result) {
-		debug("i2c: receive wait fot tx ready: %d\n", result);
+		debug("i2c: receive wait for tx ready: %d\n", result);
 		return result;
 	}
 
-- 
2.34.1

