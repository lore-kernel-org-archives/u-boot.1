Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6486BD3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 01:00:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DC34895F8;
	Mon, 25 Nov 2024 01:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwpJOiNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988B7895F8; Mon, 25 Nov 2024 01:59:05 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F15899D0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7e9e38dd5f1so3359748a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496337; x=1733101137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5IA7t9KJtD2LKa4JVRVUKtPQ4t2ltR2ewFqIss65w/E=;
 b=VwpJOiNnCzaVanGTwCNdx9e4XFnxjMdhXIFwssr+6aEIuPdONbH1g8qAsOJrjNhJdG
 NVI3cX2C+dNNynBeAbW57jfHXlpjS1HpFySComIdGiBJFkjWAyGXZQAbv3flNNq3Z636
 9Hs4YPj0rT2z5fFjK+tTgXP1qP4DvuFO2Y8vZuAfuKAa0OndOTF0br7zlW3+NH/2wSjW
 pZ+zd90mouqasnGyYOOnv9ZZ+4JC25FuE3dr61rKmXAVQDmkSs7Z+heqMTfxwcGTJ2hv
 letbzz4YcY6Pf2Pn+M61D8I7ld988NuTGaNaJ4kCt1uIuFEN4bhtoFJ7Gb/2/XmdVJuc
 4R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496337; x=1733101137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5IA7t9KJtD2LKa4JVRVUKtPQ4t2ltR2ewFqIss65w/E=;
 b=AdMujpjYhJnNQQglsN0tEsdHMmTQoTuDzZTQY8q0B8Dzy84RxGG+fpSPlDmy2hQZJ0
 E4eRPauWV+gnX4e8EQ+fuRmrgU3jpEfTKkrKNS8thTIancCdBijwV3pAmvhlb/bfjkVb
 GPPuvLcx7t6g9ozPcOpEzGFwhLB7cPuBzOLovNNPS2+GOV+hgh/WOT9mU1etujX1lDa3
 IEA72HwdO2Y5jNXYSb3V2F3V5UseTkrJaQFJLZAX6xti9uHZzr8hwj0PRshwiNejhzfm
 PyZIUfLhI9VWOb5i74UyHfnZq4c+AwdzvCjjSM+C9dXdLOGZ599jFYzGVqkndF1Zggi4
 Mf+A==
X-Gm-Message-State: AOJu0Yzy3NIbQHnyr7iiv0Ka/HCri6rI0GVpeBoIKeGYSWjBxIZgP0un
 XtF8l1YTVyM8wB1JtMybJeIYlKNhKYmAk8DMD+HNjgt6wR+hj8/h5/eiOElKGtU=
X-Gm-Gg: ASbGncsX6BXcnovFL5VzKOQbTekpWQuLFGStObhS6JDvcWlWzXCiYl7Bet0qHhCvjyQ
 KLf5HEDxcwdL1L7ySipEgRX9d3XynmgELR32MfzbZXUREiK3feJQE0EXD9zaihsAniwhl6FABcE
 K/stLpRyTd8KWBa6aAO6mBl20zWLDfLlwHiXm8Tk05F444DbGaR53PVsFvhEcSfWK2EkAxwjMtt
 WFoOTWlQNKIDYSwXckpzsn7Wl+fI8sQimfXRYFeHg8f
X-Google-Smtp-Source: AGHT+IHDhkzg15fQsy/3Q+qIb5tAZF6SvRdBVGSwg8XN/9LRPVeV29NqttBTHIWMLtevlBOBct4zfA==
X-Received: by 2002:a05:6a20:244b:b0:1db:eeb3:d06d with SMTP id
 adf61e73a8af0-1e09e4576admr17765259637.21.1732496336844; 
 Sun, 24 Nov 2024 16:58:56 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:56 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 12/14] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Sun, 24 Nov 2024 21:58:12 -0300
Message-ID: <20241125005814.236669-13-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Add long texts for

* EFI HTTP Protocol
* EFI HTTP Service Binding Protocol
* EFI IPv4 Configuration II Protocol

to the uuid library.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)
 lib/uuid.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index c6a27b7d04..3b2cf60fe1 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -174,6 +174,20 @@ static const struct {
 		"Firmware Management",
 		EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
 	},
+#if IS_ENABLED(CONFIG_EFI_HTTP_PROTOCOL)
+	{
+		"HTTP",
+		EFI_HTTP_PROTOCOL_GUID,
+	},
+	{
+		"HTTP Service Binding",
+		EFI_HTTP_SERVICE_BINDING_PROTOCOL_GUID,
+	},
+	{
+		"IPv4 Config2",
+		EFI_IP4_CONFIG2_PROTOCOL_GUID,
+	},
+#endif
 	/* Configuration table GUIDs */
 	{
 		"ACPI table",
-- 
2.43.0

