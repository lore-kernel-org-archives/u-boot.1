Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0596C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 10:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8004888F5;
	Thu, 13 Jun 2024 12:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dC18ICQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A5B888E9; Thu, 13 Jun 2024 12:13:37 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A514888D9
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52962423ed8so1051608e87.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718273614; x=1718878414;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7zICqjiRabucE9uUo5x9KVLea6SvjoIO7CoPygjJi8o=;
 b=dC18ICQxGEI+QV3u3G1abW5qKtQNjsohzRH0kIllXG7Hw+2j+dZ7EvQN0+L8v7LIa5
 SAdlimfDFp7j8dy/jdpfd1NEfb61S1fxVT8O4VvoJ5dBcS+cD1srVD4nEl2Nt7oobzT7
 oAhYkc36buNPBg4b3aDvBFpTQ0NxZISvhkc4kJ8X4nlRH3hYxaEXqddr7O1x+iZisMW6
 WqecgjXGz3rCrgS/jurLQ1rO9q/tRMGrBJVna7P2TBbeiImA8L3skqO1swb1YyVziN77
 eUVtcy8aOV6aVySr7qZEO23LuHHXc+FPvO3bbTMwqtw0CB3uSTLUoN19mH8Xzczb/Cox
 5mAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718273614; x=1718878414;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zICqjiRabucE9uUo5x9KVLea6SvjoIO7CoPygjJi8o=;
 b=MbDG3tuDQeeBLA4zOrU0jCo/LWWcpmMfKyBtTDxC1bLEcXiuqovIeNVPINEkt74DXv
 IAZiAUPeFu2CsxqyPBKFe9yWuY/JPLfjYmCsvlYMkUmLpKSleLxQS0cyPm2KJ2RYFr5f
 ZFQZ1ya4GFm+NwsKUuKsT6bHRRzoXDiInjZUvE3EF3iOMYc+6nBaYuM4HayUgDibphhq
 FYc1pzAz/pBEiFx5i8IAjaMiJqf0TFjmtEEfbgBkk2nsdq2OuhU/sHohgtFejsuwE6DH
 85KdDJ/+zrGjyJUS85LNwl1C5eqQd4NG7EpLpw6qUZpg8+D+D5XlNvt0KFTFiBsJYqK4
 wUAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7gbjnEPELdsOTpgh/Uv3T0xek4kTfhml6YqtHmG7cbkTDPteRBCO3g0ctKBtzwpkQT/chrjzzVHBtr+EReKsRZ8ot8g==
X-Gm-Message-State: AOJu0Yykchfvi3wS1kw8KMWuKdG4Swekz/zqASOkzSsb+/p94+n9YjpM
 JJhmFR4o1Srxbp/qybl2973/9xcJH08SG1xRfvxU7fqA+6MKBsIndPFZtd0mes8=
X-Google-Smtp-Source: AGHT+IGXZhL+fqYoqk7gl7oBeCLVmr8wPgInO4dPKHFqng8Z1yjHCXq7wIY9kYk9rXr4lJnz5HvtLQ==
X-Received: by 2002:ac2:44b3:0:b0:52c:896f:bc3c with SMTP id
 2adb3069b0e04-52c9a405922mr2578440e87.67.1718273614138; 
 Thu, 13 Jun 2024 03:13:34 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2295sm1251573f8f.82.2024.06.13.03.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 03:13:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 13 Jun 2024 12:13:10 +0200
Subject: [PATCH v2 3/5] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-bootmeth-android-v2-3-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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

The only way to configure the load addresses for both bootimg and
vendor_bootimg is by using the "abootimg" command.
If we want to use the C API, there is no equivalent.

Add set_abootimg_addr() and set_avendor_bootimg_addr() so that we can
specify the load address from C.

This can be useful for implementing an Android bootmethod.

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 cmd/abootimg.c  | 10 ++++++++++
 include/image.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index 327712a536c0..ae7a1a7c83b0 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -22,6 +22,11 @@ ulong get_abootimg_addr(void)
 	return (_abootimg_addr == -1 ? image_load_addr : _abootimg_addr);
 }
 
+void set_abootimg_addr(ulong addr)
+{
+	_abootimg_addr = addr;
+}
+
 ulong get_ainit_bootimg_addr(void)
 {
 	return _ainit_bootimg_addr;
@@ -32,6 +37,11 @@ ulong get_avendor_bootimg_addr(void)
 	return _avendor_bootimg_addr;
 }
 
+void set_avendor_bootimg_addr(ulong addr)
+{
+	_avendor_bootimg_addr = addr;
+}
+
 static int abootimg_get_ver(int argc, char *const argv[])
 {
 	const struct andr_boot_img_hdr_v0 *hdr;
diff --git a/include/image.h b/include/image.h
index c5b288f62b44..df2decbf5c2a 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1970,6 +1970,13 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
  */
 ulong get_abootimg_addr(void);
 
+/**
+ * set_abootimg_addr() - Set Android boot image address
+ *
+ * Return: no returned results
+ */
+void set_abootimg_addr(ulong addr);
+
 /**
  * get_ainit_bootimg_addr() - Get Android init boot image address
  *
@@ -1984,6 +1991,13 @@ ulong get_ainit_bootimg_addr(void);
  */
 ulong get_avendor_bootimg_addr(void);
 
+/**
+ * set_abootimg_addr() - Set Android vendor boot image address
+ *
+ * Return: no returned results
+ */
+void set_avendor_bootimg_addr(ulong addr);
+
 /**
  * board_fit_config_name_match() - Check for a matching board name
  *

-- 
2.45.2

