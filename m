Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9374FC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47288876C6;
	Thu, 30 Nov 2023 21:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PoejjSav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6106487646; Thu, 30 Nov 2023 21:13:58 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7F387646
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-58cf894544cso768634eaf.3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375235; x=1701980035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24twM8Gopj8Bt8YRkSH7X4CY1ye6W4+acyuqiKl0gnE=;
 b=PoejjSavwRrX7lRy3k26625fGSYxftVsxf+PGTzQuwTMx1QrHhSiTQkF4qFBZAE+zw
 Th8PunUoTSX37sFOOMe+KzRvn4ISR3/ll2bItchh9ZOgNbhe8oGWEqn8pirmjTMO3NKD
 wDPAews7l7Tp8f6v4abJMxdQ+SZMSkMTVvesJkilLVUzz2R7z/3dQ17pqae79QeItok6
 RZPxtyUfB10LjTHc//Iu2+22tVZWYylTIhvmDLu1nqrhstmBLoY3WY655wwNTyTOSezF
 ilgQg8whxTtl7S2BtVl1f5Hhd0Hm0WeUZrs8ndgnQnvQb+TGdlHgV37QamnQab1qzcuJ
 6VRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375235; x=1701980035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24twM8Gopj8Bt8YRkSH7X4CY1ye6W4+acyuqiKl0gnE=;
 b=QMQBSJPh+UZ6HMI5r7pxBJtUgzUhYUqoVxzxrTJoTpTqov1ThaP22UMevLbRFVYXhN
 QCxJZnuzKou3tHQ0JpR/z/NshfInSYLgM36LZSRruXMi9kF0H2ZBo79NbILaOvt7IPTv
 aSea7FDhCInNAiC+mknV2oJ7lopBPz+/9DHXWcm4ZsJCKtTcHC9reAqKjIK6yoK7Un7h
 k1tbJHgTsjbbpeKunFWMt1D8LfgLkJMvkIQuEC+Jr2Eq/4w/zndGckhxNZilIp3UXg7m
 Y3MIPJvMd8TW4t5hMHw9KFF0n1yrDUwwc05+c2Oq2EAfOeIdX+fWYOt8CGohzulbQQnB
 rtZg==
X-Gm-Message-State: AOJu0Yw2zqjFRwTY2EehjGb6aAuevNhegbbOoEeCB2vEgr3jO2JtZmoP
 xB3qnQhTUhcACaiwRXVTnTGOqQ==
X-Google-Smtp-Source: AGHT+IFcLILxjd3lEVP8JDbl4esWHcKJDaLA6R8xQvjUaNYdr9bOPE+CK15Cp7P25xJVg6EMhv0lPQ==
X-Received: by 2002:a05:6870:524c:b0:1fa:3014:ada9 with SMTP id
 o12-20020a056870524c00b001fa3014ada9mr22293906oai.54.1701375234450; 
 Thu, 30 Nov 2023 12:13:54 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 la2-20020a056871410200b001f5d2d47439sm428404oab.32.2023.11.30.12.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:54 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 2/7] pinctrl: exynos: Extract pin parsing code into a separate
 function
Date: Thu, 30 Nov 2023 14:13:47 -0600
Message-Id: <20231130201352.6379-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
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

Next commits are going to re-design the pin_to_bank_base() function and
its usage in a way that the pin parsing code will be called separately.
Extract it into a separate function first, as a refactoring commit.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 27 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index 995a3a0ee5fd..2d194ba0a4b5 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -34,6 +34,22 @@ void exynos_pinctrl_setup_peri(struct exynos_pinctrl_config_data *conf,
 	}
 }
 
+static void parse_pin(const char *pin_name, u32 *pin, char *bank_name)
+{
+	u32 idx = 0;
+
+	/*
+	 * The format of the pin name is <bank_name name>-<pin_number>.
+	 * Example: gpa0-4 (gpa0 is the bank_name name and 4 is the pin number.
+	 */
+	while (pin_name[idx] != '-') {
+		bank_name[idx] = pin_name[idx];
+		idx++;
+	}
+	bank_name[idx] = '\0';
+	*pin = pin_name[++idx] - '0';
+}
+
 /* given a pin-name, return the address of pin config registers */
 static unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
 						u32 *pin)
@@ -44,16 +60,7 @@ static unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
 	u32 nr_banks, pin_ctrl_idx = 0, idx = 0, bank_base;
 	char bank[10];
 
-	/*
-	 * The format of the pin name is <bank name>-<pin_number>.
-	 * Example: gpa0-4 (gpa0 is the bank name and 4 is the pin number.
-	 */
-	while (pin_name[idx] != '-') {
-		bank[idx] = pin_name[idx];
-		idx++;
-	}
-	bank[idx] = '\0';
-	*pin = pin_name[++idx] - '0';
+	parse_pin(pin_name, pin, bank);
 
 	/* lookup the pin bank data using the pin bank name */
 	while (true) {
-- 
2.39.2

