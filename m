Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82FECD11C2
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B3487FAA;
	Tue, 19 Mar 2024 15:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gdrHdT0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693EA8802B; Tue, 19 Mar 2024 15:53:29 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9292A87DA7
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-513e14b2bd9so3902658e87.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710860006; x=1711464806; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AXYoZPj/fCIQKSz/tRDoaWp2HWdMJyRCjQHubUzjf5E=;
 b=gdrHdT0yN+syA/bGh+p/WTxaQPzr5RJ9EzLopdSxRWwFPpWs6A6Fc7f/DQ05IPuP4q
 XuRKb9MjRpaRezwNAnIB3KKeGtTbl9J9su8qjIAeEzg9woQr9ocvDEhr0VPC24ZHCXIl
 st21k+qtnn58iv/4pnV1OSRJCEy50Lol9U7lVCDkQuz5jhM0+sVhsQ1NaCpCsg16cMJu
 yJ0vCHnTRTgDOf8WwLcBx3J/hFwcA2eVS3HI8QOWHySH7I2mJ/8IvHNu91a2wk5FmPhU
 TP65W3G9zykmij80wW6vHDUpTrh4Gfir213r7eFrCyhSbZsnHAHHKwfU7/vKz2ESLSkN
 XReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710860006; x=1711464806;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AXYoZPj/fCIQKSz/tRDoaWp2HWdMJyRCjQHubUzjf5E=;
 b=YRVloQrpNwwXpZTnjmORdUDbv0GcGTs28y6Kth23D8SgDoT6rjejJvY3Ys7F/dlrsa
 blOdo9fh0f8Rg/cvZ6EgdhAPNzdehpyze5BUDjAyuvGCNiq8EJq8GDy4Tczr2S+V/PC/
 NmqNBZveTt6FxM5ELpwSSqYlK7m9YvM35H4D9oFUsf1aEQOSvlW/6nUNoDh4Oy5hBNSK
 PA7QvVqaDMAseoSPM203QkvM7yKHg7sq9yjqU6n8iJ+79YcwgP6WpLJrvUpp4eYMp+wu
 x/Vo08ZAtdFrPwQC4x9TUvHzFc9Bya3smJRkyrsl+Yf2IeZQI9tX7dg9SDs6QvdK4l6N
 ni+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiOj7V/xJ0qoG6KQfO9KDelLgS4xG5OVPDsq+ffbsh6WymVqKD0jO7kGO39LJyZbYlmRVXg5FvNLlWji0T3465aJ6bIA==
X-Gm-Message-State: AOJu0YyQHwdwysrYA1Jc9BU2C2FpjbKtWGrE84rFgn7Gis/XzkdMGpOj
 FxI/UJjM3D2wBdqnF9O/LDNjQzgmYiJmUo+j+fRPhfvZnA+HUtUTF4/Pdjuleg4=
X-Google-Smtp-Source: AGHT+IGwgq6yOwJfR1lRrqvUKTxG7LL4TFskgHMfqLrTKcxly/OreDz9Mvx+CQ6MT4/2t1onqJ7xtg==
X-Received: by 2002:ac2:5b9b:0:b0:513:d6d9:b0e7 with SMTP id
 o27-20020ac25b9b000000b00513d6d9b0e7mr9231218lfn.28.1710860005783; 
 Tue, 19 Mar 2024 07:53:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a05600c4e8b00b0041461cce1cbsm3444958wmq.46.2024.03.19.07.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:53:25 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Mar 2024 15:53:24 +0100
Subject: [PATCH] board: amlogic: fix buffler overflow in serial & usid read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOOm+WUC/x2MWw5AMBAAryL7bZNtEY+riI9iyyai0iIScXflc
 5KZuSGwFw7QJDd4PiWIWyOoNIFhNuvEKGNk0KRzylSNB/bO7Wjlwk0T4debBQ2p0hblYGxVQYw
 3z1H5x233PC8RDVVHaAAAAA==
To: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4180;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bKCqdcek1W8zVCb25198galA5k90ADO/cUC2NKtl2Vk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+abk3L4tONZ0Era8ESRxHC1VvwSSpcJFFuMOXe5H
 r6JKux6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfmm5AAKCRB33NvayMhJ0cY2D/
 4qtGbv0w2L+IOPbY5kxh6hdmA7T1xjG2urwHmQTsjLhQ1fJdI1M797suAoFpj7wbcf1+UW/L9SNGYf
 jNYYFQ5SYx+xyEWzb32ZFG27p0rJJQbtTOOb6gh2MII2aBiSe101eE+wlvnDoyjdLgwkuMIAGDGxdC
 YeD+l2RhCRFVUyz4yU2gajGMZHAImveADZbBWLtLrQ7KHhpIW5gTCQZcH1F1va9C+gVqDTQzt40d9F
 AMChtdcgiMJ+pysEqeRb886B6JjDB59CK8McrnnHSATlqXxPz8b+P0hg+MbtpIeVQi4Kn0HQf1GROh
 BkPFrkVo3rcvfUB0pWJ++olk35Or+SQ9/d+KbKl4Q24lUlHEqxNvd3VF9hC9he9gpcTIvDtbPUrPqK
 /FeQB4Azl9wvE0/FV7ZAUGUi2i7YGs2/dEU7KzgFp/aiyjyrxm67+KpXkgTlcmbLgNI+TXc9qaaHko
 w8TUqD4nE9Z13xpbySF9AzyWa/OGVMnPAJrtY5KbmE9DRIH4cZfTRgW4a2Uz+tnlx/s1EpQP7fIVgo
 fDSGVdMe+4aCnC3fws67Fg70RhR8bFar/d0tCkG3Hz19TYn5tNOGandrGmRmBB4fh56iZpdgKjN6wc
 Ax+tVf47y9zczt9xLiRfyQLPjbSjfC/C2/XW8wtLFF0DA36Li2gKVCZMj2Xw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

While meson_sm_read_efuse() doesn't overflow, the string is not
zero terminated and env_set() will buffer overflow and add random
characters to environment.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/amlogic/jethub-j80/jethub-j80.c | 6 ++++--
 board/amlogic/p200/p200.c             | 3 ++-
 board/amlogic/p201/p201.c             | 3 ++-
 board/amlogic/p212/p212.c             | 3 ++-
 board/amlogic/q200/q200.c             | 3 ++-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
index 185880de13..d10492cc46 100644
--- a/board/amlogic/jethub-j80/jethub-j80.c
+++ b/board/amlogic/jethub-j80/jethub-j80.c
@@ -28,8 +28,8 @@
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
-	char usid[EFUSE_USID_SIZE];
+	char serial[EFUSE_SN_SIZE + 1];
+	char usid[EFUSE_USID_SIZE + 1];
 	ssize_t len;
 	unsigned int adcval;
 	int ret;
@@ -46,6 +46,7 @@ int misc_init_r(void)
 	if (!env_get("serial")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 					  EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial", serial);
 	}
@@ -53,6 +54,7 @@ int misc_init_r(void)
 	if (!env_get("usid")) {
 		len = meson_sm_read_efuse(EFUSE_USID_OFFSET, usid,
 					  EFUSE_USID_SIZE);
+		usid[len] = '\0';
 		if (len == EFUSE_USID_SIZE)
 			env_set("usid", usid);
 	}
diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 7c432f9d28..37a54e715c 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -22,7 +22,7 @@
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
@@ -35,6 +35,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 			EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/p201/p201.c b/board/amlogic/p201/p201.c
index 7c432f9d28..37a54e715c 100644
--- a/board/amlogic/p201/p201.c
+++ b/board/amlogic/p201/p201.c
@@ -22,7 +22,7 @@
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
@@ -35,6 +35,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 			EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/p212/p212.c b/board/amlogic/p212/p212.c
index fcef90bce5..90ac9f885d 100644
--- a/board/amlogic/p212/p212.c
+++ b/board/amlogic/p212/p212.c
@@ -23,7 +23,7 @@
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
@@ -38,6 +38,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 			EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
index 3aa6d8f200..1c47f4645f 100644
--- a/board/amlogic/q200/q200.c
+++ b/board/amlogic/q200/q200.c
@@ -23,7 +23,7 @@
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
@@ -38,6 +38,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 					  EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}

---
base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
change-id: 20240319-u-boot-fix-p200-serial-a017f57caf88

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

