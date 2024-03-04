Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2322C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A92687EE4;
	Mon,  4 Mar 2024 18:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nc6AZRHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F03387FF2; Mon,  4 Mar 2024 18:45:14 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128C187FCC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412b30be60dso2607715e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574311; x=1710179111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5hYb9tvhIu26Zgptq0KxUqht+iLWEjbRWL/fVDmIIA=;
 b=Nc6AZRHSclRzHvwwzSLRW1bPOpYcDBBhrs19VAbq6W0b4K5jtOo2uU7qeU2MeRPgtp
 k3hwOjXap/ERtBW1KfhzZ2yqC9sL7RIvZIFGlFuyUX7+QoQqm+uzBO1ew4AN/V/0o083
 PxW6JTc52o3nIvv2clexfu1Z1/w3jPIXllH+22ERW0KoOvjVUIDtgD4B7Im0xZxuHOKo
 l72LNgn1044x8DEYxzjlI/ANP3iQEQyy7fZK7x8P5e71Kg5NnkGP96tZ7xShP0XM8WKp
 msH4dGl5XsO48sX7D1Ra0gYUMFtq8qlUlcT1lZtC6ZVVlGdEYwxcT66cYKmVj2RR+TQZ
 LKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574311; x=1710179111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5hYb9tvhIu26Zgptq0KxUqht+iLWEjbRWL/fVDmIIA=;
 b=UuoOhapF+fCb5/tdd9NFQ8MntpH7ZQRInR3KAOXkBfFrvxVVO3agsA3NbeeyUhiKPi
 +uIAkoNVOGyIz254YvS2vvpIsevJT09s21yDQ8LMnQSRhRYWil5lypKd/7pEDMjT1V3L
 vsBSmVD0BCbPk+u0nVWiRCrTw04jar/d18aHt2qvjQNWIm4lCIR197+YOR1g9LsZQ3CN
 lpUzCDSxRB3LkFmy65v3cutWDjOnHqYTX2visxnx6aAuCnIFwQPlYUN0cciutyCzdE6Q
 ZBlCgK655LAZDy3IWPolvFmAhzok6W1yXqf3n4hs1XXAONkg+9KF4kzhww5q/6k+sTN/
 hncA==
X-Gm-Message-State: AOJu0YxSD2JWOpgDTar3YUDeCCS1BYqwK4gHx/rz7z1VjCg6SJRLujbY
 WRJJScMf3lSX/mNZdWQzhd73oxmelzYajIl5gFkTo07d/Mk+AZqt0a5tOWFqE14=
X-Google-Smtp-Source: AGHT+IHi/M5LILBmt7M75cFG7cE32bNpCXHYtXaEYhV6Z+QZz2zE6E125nsouAK0LraIWhIvCniBkg==
X-Received: by 2002:a05:600c:1c12:b0:412:5670:ef62 with SMTP id
 j18-20020a05600c1c1200b004125670ef62mr7547829wms.1.1709574311118; 
 Mon, 04 Mar 2024 09:45:11 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 n37-20020a05600c3ba500b00412e5633ee9sm2788436wms.43.2024.03.04.09.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:09 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Roger Knecht <rknecht@pm.me>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/6] cmd: optee_rpmb: build cmd for sandbox
Date: Mon,  4 Mar 2024 18:44:52 +0100
Message-Id: <20240304174454.1484507-5-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

Support CMD_OPTEE_RPMB for SANDBOX configurations.
Test:

$ ./u-boot -d arch/sandbox/dts/test.dtb
...
=> optee_rpmb write_pvalue test_variable test_value
Wrote 11 bytes
=> optee_rpmb read_pvalue test_variable 11
Read 11 bytes, value = test_value

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

(no changes since v2)

Changes in v2:
- Applied R-b and T-b tags

 cmd/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index a86b5705174..8ad8c0c542c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1370,7 +1370,9 @@ config CMD_CLONE
 
 config CMD_OPTEE_RPMB
 	bool "Enable read/write support on RPMB via OPTEE"
-	depends on SUPPORT_EMMC_RPMB && OPTEE
+	depends on (SUPPORT_EMMC_RPMB && OPTEE) || SANDBOX_TEE
+	default y if SANDBOX_TEE
+	select OPTEE_TA_AVB if SANDBOX_TEE
 	help
 	  Enable the commands for reading, writing persistent named values
 	  in the Replay Protection Memory Block partition in eMMC by
-- 
2.34.1

