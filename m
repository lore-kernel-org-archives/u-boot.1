Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151E0D5C0C0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:48:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9729980107;
	Tue, 16 Dec 2025 03:48:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIgdXqUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 069FE8003E; Tue, 16 Dec 2025 03:48:04 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0180080107
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so752368b3a.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853279; x=1766458079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHI1vZC+NtUBdFGbaPEBvJmpsPCy4aN+iW1pIheBM68=;
 b=PIgdXqUitfHN9L9Bw7UaHNHKvgD0dj4IYLBGoyY4Fng0qlH7xd4qo0TSs6Omyw42NY
 9npCzcyDolG/TbOlMzJTswjPofHzrI8DbYTAU/6Ohln4l2Mj6aAccawI9ziJ9Y1dgu/t
 LdcJWMDMzso2xPA2ESD3GFcORjDsmy30QvqKhq+uaalUT4dQEW8+xBjVaHHFXHY5amms
 BaVlQePb5a2IvIqt7CmYq5NmJulsRjhb00KqNQOgb8sRbupX26m2eadh9rknQQaJ6Vkq
 jUtTIoh+Z675jxamVbtCx7NkjwlNWAXeIoRMDqRMkaSjXkbCxcfYmpL4/lM45tPFeLO3
 +fiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853279; x=1766458079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dHI1vZC+NtUBdFGbaPEBvJmpsPCy4aN+iW1pIheBM68=;
 b=EABOMd9r/1KRoN1335n6awhNPNw/dneSGAvLydvaT5KS2Kh8snepTdWistCFCY52VA
 +tmtMDPnAlT5rfWVcLaZcYj60Q9dqvlY3EN9ZGEnRXnCc+ZNaEq/dYIzitZtRQ6BbOp5
 U95N9LUwmBFkbQlmjV+Zzk1ONitm718/egLpm5DVM7VhOZ/i9MTtdONzPyV+JPTYJeox
 6lSjXeCUGYjyn3Hc/chlStORrYjsLliteCFr8GF8t1xsJvsAcUghBpsYNrlkVqHdQwGm
 sYEdEcbIiRLzfjJYH67/N7n+g4uT4rG7Q7rlYDzFlsueVRqqGww2KfJVutwS7ptZubwZ
 8lVg==
X-Gm-Message-State: AOJu0Yy/A1Zy9r3c/l8Ak6y3MxwIRWtfFQMJ1rZdV+SNJ5s8R9Yy2Rep
 ct2ilY4SdgHSzQQJrs7gATR+WgI1NLwM8NYWqbzavsqgpgZiRuL+1pmr
X-Gm-Gg: AY/fxX642crTI9f30kxVbv1hsHptX52YA/3ONqcCQToPACZa92GqKRxrLoZjsUMhpcL
 yC7dXb89ZaBb/ZDjyJUR7oc7O+nNa8pU6wIJGlEcI632Q9NtyK9uuefZckYUq7SUdZcPbKSR/A1
 1NT6JHup8mkvHkKF9jK8eV6tAhxaVbfdtiZKoJamVg1TIeGd6lU0J6GRjUFv8WE/HO4snP9+GCZ
 ffKVOBktPyDeXhLgfEbeAtYlhrASD6HRGsdfurVR/EeQM/oZ2p6woBHG5HEDutCNxIC8UuDomQe
 5QPgKagR7+p/jZu9QUT2xuyGSssWdag+Se/KOoG9fSQRv/8ZS93z4PnGgFrOKWI9amt9hVWcM7W
 njgQ99bOM/aBwMEDGNJmyWhvTic3iiVYu+Fjwxkd/l8/1faTYiisv3q985UHKLIAskz+NLs6BKc
 X/oQGnpXV33f4fL3/CwX3E+Q==
X-Google-Smtp-Source: AGHT+IF4cYpCe9MJIWQkAnRZw78HkXOZqK8zKJcRPMIWZdSWdUCVM0fW378yT4mf0/uG22tieiYOjQ==
X-Received: by 2002:a05:6a20:9184:b0:342:fa5:8b20 with SMTP id
 adf61e73a8af0-369aa64962cmr13008551637.30.1765853279322; 
 Mon, 15 Dec 2025 18:47:59 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:47:58 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Stanley Chu <yschu@nuvoton.com>
Subject: [PATCH v1 1/6] watchdog: npcm: Support more timeout value
Date: Tue, 16 Dec 2025 10:47:24 +0800
Message-Id: <20251216024729.1031306-2-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
References: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
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

From: Stanley Chu <yschu@nuvoton.com>

Calculate a timeout value that is close to the requested value.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/watchdog/npcm_wdt.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 57b61215a2a..7becc646fda 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -27,26 +27,11 @@ struct npcm_wdt_priv {
 static int npcm_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 {
 	struct npcm_wdt_priv *priv = dev_get_priv(dev);
-	u32 time_out, val;
-
-	time_out = (u32)(timeout_ms) / 1000;
-	if (time_out < 2)
-		val = 0x800;
-	else if (time_out < 3)
-		val = 0x420;
-	else if (time_out < 6)
-		val = 0x810;
-	else if (time_out < 11)
-		val = 0x430;
-	else if (time_out < 22)
-		val = 0x820;
-	else if (time_out < 44)
-		val = 0xc00;
-	else if (time_out < 87)
-		val = 0x830;
-	else if (time_out < 173)
-		val = 0xc10;
-	else if (time_out < 688)
+	u32 val;
+
+	if (timeout_ms < 343552)
+		val = ((timeout_ms / 1342) << 16) + 0x800;
+	else if (timeout_ms < 688000)
 		val = 0xc20;
 	else
 		val = 0xc30;
-- 
2.34.1

