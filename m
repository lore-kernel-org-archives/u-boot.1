Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26E5C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 279528175D;
	Wed, 12 Mar 2025 19:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OowIIDVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C20381BEE; Wed, 12 Mar 2025 19:08:13 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B49280756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 19:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e677f59438so72592a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802891; x=1742407691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYQA7tdeviOl9kt2u/sGwOy290b5YbGQbkCk+DS1EjU=;
 b=OowIIDVzcjjfth/9JlSbDIr+WNW+Ubcm7odHlAOD0Acm5TwJBpKWc3FASXE1Z7nJ95
 hl8aDGAgYaCTqi5Uzfc037mirX4lcNHHRWlRoxi4dtRwmsyWJ6QU4PTnF/4XxLtkQ824
 SxnGhPuL8kNAppp/0kBaDNC33cIZCl8P77CiPjoTzR+FoyWv3fO/qAxs04+FVVJP26ed
 s2IvDFcYpihI2hJhw+Ewv0GmcUE19gosvvLglSJN3Bia+vLRHWu3gRVwXPqurovR0blK
 TRqFn2wLUSF3rpl7REJFBxM2Z26iJxm5MD0tZ3TrUAt2hmU27vYBjBUEIYo+RE7vBv3q
 ddew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802891; x=1742407691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYQA7tdeviOl9kt2u/sGwOy290b5YbGQbkCk+DS1EjU=;
 b=VsZR0wxIr57v1Mkk92Ail+PTB+2KAakzamQC8jaCUK647vFEPB6vkhc2VmUKz46Olc
 mbyIbiB1+DS+ElLh5yObZI03GGbMTLdTpdq1AqM9Qo5dVCEAjSlVzLpwtwQqHLJEWkdf
 x56kjCj+yn3Pyhf64a9swpj5YmnxPMk8g/FIyzs6jPA4ZuSu6nVXJbB9WngsCbW2a/Jg
 ReV67LdAoEuOYhCjjgcKSxouEvzi50v3yTAIamDXOhkvCksSbOwWwC1JQfdBIJfuHJkb
 VF8pP/mncf7klqRe4X7TaAdgXnJOq7VFKhEIdHWSSZPPbVdPLVjsIryGUIc1b6ZqKOvp
 M+uQ==
X-Gm-Message-State: AOJu0YylDpxmebb4cmxwTff2yvu0wDUl4IaJlGF789OXQZb2ymkSBL7T
 5n5PKZcqPz4Jbx75K+7fguWafEi1c8dqVPGHr0EWNs5SsrmzcRIV
X-Gm-Gg: ASbGncs8LFv3kFSRiL9VZhu1/PMfGqb9yE53dcxoBpNkvBXd0PwirYZcKGA+hT7wJSO
 ukqDglzsV0bBzd7D43dCe6mIXWTIuRVOk48B73eInbrSBShD/GzKE2/xssAtLlUkTckr7MkBUqs
 67wU8+glBlZORJPgBNqra+yp66oSXhnAVXlMGCPckrS5ljm0y9JJ95PdPMrenhdWm8JQsXh0Urr
 x3e/ikqZMlHhjShT7HfhzX7qdMEE31kwKFLJwlKxRAUuwy7xkM/kJvb6SnmCJoKiycr+WWlNNFy
 zRpZZEkt1u1hlfuqH8RT8i9a4aory3W4WHU+
X-Google-Smtp-Source: AGHT+IHWY7XDduTP5altvRVEI3CMbmW079r2kJ8zBinddlfxA4V6MytgYanXx9JqnWlaQoEpaJ4tPg==
X-Received: by 2002:a05:6402:4409:b0:5e7:110a:c55 with SMTP id
 4fb4d7f45d1cf-5e7110a0c6dmr17758947a12.18.1741802890657; 
 Wed, 12 Mar 2025 11:08:10 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c733fcd2sm9971635a12.2.2025.03.12.11.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 11:08:10 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 04/13] video: bridge: tc358768: simplify power supplies
 request
Date: Wed, 12 Mar 2025 20:07:45 +0200
Message-ID: <20250312180754.120946-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312180754.120946-1-clamor95@gmail.com>
References: <20250312180754.120946-1-clamor95@gmail.com>
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

Simplify power supply request logic.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/tc358768.c | 44 ++++++++++++++-------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/video/bridge/tc358768.c b/drivers/video/bridge/tc358768.c
index 15bee19a152..6f1b057c208 100644
--- a/drivers/video/bridge/tc358768.c
+++ b/drivers/video/bridge/tc358768.c
@@ -124,6 +124,10 @@
 #define NANO	1000000000UL
 #define PICO	1000000000000ULL
 
+static const char * const tc358768_supplies[] = {
+	"vddc-supply", "vddmipi-supply", "vddio-supply"
+};
+
 struct tc358768_priv {
 	struct mipi_dsi_host host;
 	struct mipi_dsi_device device;
@@ -131,9 +135,7 @@ struct tc358768_priv {
 	struct udevice *panel;
 	struct display_timing timing;
 
-	struct udevice *vddc;
-	struct udevice *vddmipi;
-	struct udevice *vddio;
+	struct udevice *supplies[ARRAY_SIZE(tc358768_supplies)];
 
 	struct clk *refclk;
 
@@ -277,17 +279,17 @@ static void tc358768_hw_enable(struct udevice *dev)
 	if (ret)
 		log_debug("%s: error enabling refclk (%d)\n", __func__, ret);
 
-	ret = regulator_set_enable_if_allowed(priv->vddc, true);
+	ret = regulator_set_enable_if_allowed(priv->supplies[0], true);
 	if (ret)
 		log_debug("%s: error enabling vddc (%d)\n", __func__, ret);
 
-	ret = regulator_set_enable_if_allowed(priv->vddmipi, true);
+	ret = regulator_set_enable_if_allowed(priv->supplies[1], true);
 	if (ret)
 		log_debug("%s: error enabling vddmipi (%d)\n", __func__, ret);
 
 	mdelay(10);
 
-	ret = regulator_set_enable_if_allowed(priv->vddio, true);
+	ret = regulator_set_enable_if_allowed(priv->supplies[2], true);
 	if (ret)
 		log_debug("%s: error enabling vddio (%d)\n", __func__, ret);
 
@@ -904,7 +906,7 @@ static int tc358768_setup(struct udevice *dev)
 	struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct mipi_dsi_device *device = &priv->device;
 	struct mipi_dsi_panel_plat *mipi_plat;
-	int ret;
+	int i, ret;
 
 	/* The bridge uses 16 bit registers */
 	ret = i2c_set_chip_offset_len(dev, 2);
@@ -937,25 +939,15 @@ static int tc358768_setup(struct udevice *dev)
 	priv->dsi_lanes = device->lanes;
 
 	/* get regulators */
-	ret = device_get_supply_regulator(dev, "vddc-supply", &priv->vddc);
-	if (ret) {
-		log_debug("%s: vddc regulator error: %d\n", __func__, ret);
-		if (ret != -ENOENT)
-			return log_ret(ret);
-	}
-
-	ret = device_get_supply_regulator(dev, "vddmipi-supply", &priv->vddmipi);
-	if (ret) {
-		log_debug("%s: vddmipi regulator error: %d\n", __func__, ret);
-		if (ret != -ENOENT)
-			return log_ret(ret);
-	}
-
-	ret = device_get_supply_regulator(dev, "vddio-supply", &priv->vddio);
-	if (ret) {
-		log_debug("%s: vddio regulator error: %d\n", __func__, ret);
-		if (ret != -ENOENT)
-			return log_ret(ret);
+	for (i = 0; i < ARRAY_SIZE(tc358768_supplies); i++) {
+		ret = device_get_supply_regulator(dev, tc358768_supplies[i],
+						  &priv->supplies[i]);
+		if (ret) {
+			log_debug("%s: cannot get %s %d\n", __func__,
+				  tc358768_supplies[i], ret);
+			if (ret != -ENOENT)
+				return log_ret(ret);
+		}
 	}
 
 	/* get clk */
-- 
2.43.0

