Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88CCC61DDE
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7B483E40;
	Sat, 21 Feb 2026 10:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Po1epY9Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F10B83DBF; Sat, 21 Feb 2026 10:43:04 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A67083936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4837907f535so25552385e9.3
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666981; x=1772271781;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dh5Z81BHMLz+L3luo+o19BjOyiH42+e1YEzMpViHm8c=;
 b=Po1epY9YCk4pLKaoKHYU6z9tr51MycXLuEQTcc9QNAqTBapwQHuHmRrnzj1y8riPKd
 5kGMdyd84wc3t8LuEGYz4TQ0CwuIZ3p02KOEp7qpnVydtYHdGUF7j6z6aT/JogNmUSlf
 /Advbhp4DkHmqqd7mmFDke00LNQSINgV0iMlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666981; x=1772271781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dh5Z81BHMLz+L3luo+o19BjOyiH42+e1YEzMpViHm8c=;
 b=T9CfJ2aC/gmNVNKl9mWSY4z517uysdUFxTdduq5IlA1+69d2WwKA/kCy5OaeDtKw4J
 darEVyWZg3nrLju32j2WRXpGhlISQGq4b5UG2AoRkwM1PeU3t8xwOOTLdOFKU1d/B5yJ
 slpzvk6YFhnTe+qOj5kqSog01aPBVFY/0XU/W9eFlYsnx7T+r/FHv73Yna9Em2WAgInR
 DWFeA6nRd4Emm5RLEv/AhcH7X7uA5aF7MFSMEuV8uaWSKR5++sodH8MPvTA3xgJQaUqB
 yuWQK0vF6EeynpwKPxBkaOKIK5m0OHUv0rZbZRiKVloVevPRA9lkTlMCLeiCUhkKlQYj
 VPVQ==
X-Gm-Message-State: AOJu0YxGqXFbF1Lr30+o+GIAkIjGx7+j4o4anMHLvLC06eBDmKX5E6pH
 zpBXaARgZQaq8r4UtwXNGLrtEhqfDGCPzM0qlayV++JM5+scfl5BnW1hEWGDH/Zw5RTpfswLyR5
 O0iVt
X-Gm-Gg: AZuq6aKkhTYuA0vR+t+Txx8fK7YV07ojaJCEFWqOLdYEY31LEIusb8TjdbdGovnXdnq
 0VYFj/LzWKsaSfZDPQ3GFNR7FFj5BoApEtcVL+qwpe4VftkGo/0DXOjdqOKO4cuE+Al9lxFjahs
 3JHm0+RzX84bsmjp/3bxsw/tMFZxBGKEaG4/yQLtERi5IefoP446mw8AmDRjq3Z/GaW3oEjSW09
 UZXClyRzRB4Y8rkNtJdGbiaXivasLpxwgK36q0LUNaSFsGL3HLhKYJoTnoPUM6IsA57gEi9EEV8
 5SnR/S4yT6Mxn6Xzmb8RxcusC9NLlqeEjcePb785TDEt8jTeGAK2cXlSSltNbxRbrL3nE7E6a2P
 MVYQ3I3THWt/c5Ybxwf4Qo04FC+kd4DRM8K1Zg2J6b4j8AovUkCrAvHDiOHteqFWrbgMVvXOBDx
 +NaDN84H2BkF3YoVOfxLmt+uwt1yuUWc8JmVgBBdx2Wsj4cy5ogJWDxgRKlFezucihcsb7nkCCT
 GxTI9PrqqLiNait+vZVdWhPsK8nkBOuw3WJivWXu+ahHdLKVi4HYNJDZxT2SvLKKi+rRfQARLjs
 MDcMzoIfA83bWuQH3gOtqlKgABdlzgz9C9w=
X-Received: by 2002:a05:600c:3484:b0:483:7f4e:fef6 with SMTP id
 5b1f17b1804b1-483a95fa4e7mr29237575e9.26.1771666981323; 
 Sat, 21 Feb 2026 01:43:01 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:43:00 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/8] test: spi: add sandbox_spi_get_wordlen interface
Date: Sat, 21 Feb 2026 10:42:17 +0100
Message-ID: <20260221094252.3103034-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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

Add the sandbox_spi_get_wordlen() public interface to retrieve the
internal word length state of the sandbox SPI device.

This is intended for use in sandbox SPI test cases to verify that
the word length is correctly propagated from the SPI uclass to
the driver.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/sandbox/include/asm/test.h | 8 ++++++++
 drivers/spi/sandbox_spi.c       | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/sandbox/include/asm/test.h b/arch/sandbox/include/asm/test.h
index 0e8d19ce2325..0438790028b9 100644
--- a/arch/sandbox/include/asm/test.h
+++ b/arch/sandbox/include/asm/test.h
@@ -243,6 +243,14 @@ uint sandbox_spi_get_speed(struct udevice *dev);
  */
 uint sandbox_spi_get_mode(struct udevice *dev);
 
+/**
+ * sandbox_spi_get_wordlen() - Get current wordlen setting of a sandbox spi slave
+ *
+ * @dev: Device to check
+ * Return: current wordlen
+ */
+uint sandbox_spi_get_wordlen(struct udevice *dev);
+
 /**
  * sandbox_get_pch_spi_protect() - Get the PCI SPI protection status
  *
diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 8eed56140f6a..b035a60ef43a 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -63,6 +63,14 @@ uint sandbox_spi_get_mode(struct udevice *dev)
 	return priv->mode;
 }
 
+uint sandbox_spi_get_wordlen(struct udevice *slave)
+{
+	struct udevice *bus = slave->parent;
+	struct sandbox_spi_priv *priv = dev_get_priv(bus);
+
+	return priv->wordlen;
+}
+
 static int sandbox_spi_set_wordlen(struct udevice *slave, unsigned int wordlen)
 {
 	struct udevice *bus = slave->parent;
-- 
2.43.0

