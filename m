Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDCAC52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B553688901;
	Sun, 11 Aug 2024 16:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYzLb3Ve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F19C9888B2; Sun, 11 Aug 2024 16:51:18 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BDE888B2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-81f860c6015so143092439f.0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387874; x=1723992674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzrz1YdjuMUk4rpSAs0MrZ58R2NaX2A5Da7YWDVdqRo=;
 b=YYzLb3Ve5Iad63EHlAWTXS+6RhGL6IkAOjTzYYRgYOQjhE+5atz1B6eIIL5/oGgj/S
 GEf41fxA2mU4cEtqUWJrBSg1n6zEsEAvtpnp6pkdgEtmgjIQYcxzDJkcOYdboIbDKXRu
 4wPGs4peBu2EKsgPcweysCieaVBiMtbtreGTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387874; x=1723992674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yzrz1YdjuMUk4rpSAs0MrZ58R2NaX2A5Da7YWDVdqRo=;
 b=DfLZ4en83AfX+kiJYFtYNDI4CY0lmVp9pdMJhXvh9DJm/WXGWjb8x0YYpM4jKTCZaJ
 8+t1EUZ1yB0hn2iUg4h9xWlox73nvEj5QW24R5ELtR/pcSobYG8lF4yz5Y69BweKa62F
 zJ0iEaYCCvh/sd3sHxsB+07UmHjcST+x8JnXY3eM2if5MKM3NhkME1HtnwAUvxSUNjhu
 Amp9XzTZWwsrXFA12BcL92aRBpPhBLsMbI3zzVqXi4kyeI3ojq7MY1epKC/Bc4u/Q1Zl
 G4ZgjDy1/jU43i3fgPZpq6mFimZQAQwWG0fUp2oJgS4ZPSfN8NwO6pK3ga0dq7B7pVYD
 89Xw==
X-Gm-Message-State: AOJu0YxxWmrC1LFcdsBtaXFTCiIk4JRXsIjiWS75n6yg1mrAajhrcUzw
 FaTxqcDUxdj6a7vASszkZCV7RpY5WUDYXxe1Ok7i4kGpYLUdHHpKkIVYc3jTk10FORxrzar3py4
 =
X-Google-Smtp-Source: AGHT+IFYMg21VMIj/Ra1PyE9muMPQsX/ojREgCcrZpYs7ZXmhjWFktnCYO2LXpo1T5jAheQcdvFYYA==
X-Received: by 2002:a05:6602:2c90:b0:81f:cb5d:a5a5 with SMTP id
 ca18e2360f4ac-8225ee65857mr1205756339f.3.1723387874412; 
 Sun, 11 Aug 2024 07:51:14 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/18] i2c: Remove board_i2c_init()
Date: Sun, 11 Aug 2024 08:50:30 -0600
Message-Id: <20240811145047.4189460-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

This function is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/i2c.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/i2c.h b/include/i2c.h
index 4e59009cd93..8d91b24b43b 100644
--- a/include/i2c.h
+++ b/include/i2c.h
@@ -972,14 +972,6 @@ enum {
 	I2C_8, I2C_9, I2C_10,
 };
 
-/**
- * Get FDT values for i2c bus.
- *
- * @param blob  Device tree blbo
- * Return: the number of I2C bus
- */
-void board_i2c_init(const void *blob);
-
 /**
  * Find the I2C bus number by given a FDT I2C node.
  *
-- 
2.34.1

