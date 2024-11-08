Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC31D5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8AF38927E;
	Fri,  8 Nov 2024 14:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fEfhvfP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D2B188C86; Fri,  8 Nov 2024 04:48:03 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7685B88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720be27db74so1366452b3a.1
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037679; x=1731642479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6q445Jqdj7B+VwHf7FrK/rfBNO7yL6hfJvO3kSZ7kkE=;
 b=fEfhvfP1PrjVI9dbIP7RiopnpF1n7FfvuiMVLRJnFcHzzeanUN5+vmHc3TR/hQU/cE
 4OEIFKYeHzpRTQpsWil47nLCZ0VqCLGRaKU6os6ZA5fHe2aVXqewnmVtSQeTOsYfppNt
 zNfkz3GZCndxbOlUZjTvmKeKee2NdU+I2KZZXpU4s9hIUFvJERNtnea5ajxaxECjSR41
 rLFPCA+ANLsDC5G55znhAwqnd4AeC5LfyimEWMo/tBudwzmL4asfbcNR60PHhK/aelOx
 5uKqhN35ly8QM7laLT0mXhSrb1g5zDwMVkY7V17uVCW/2opixWd4LkEDU18+iITfBePK
 MUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037679; x=1731642479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6q445Jqdj7B+VwHf7FrK/rfBNO7yL6hfJvO3kSZ7kkE=;
 b=RrcnSl3jB40pU7Fl+9FIyZI2CPT/Kto+5ZhmO83Q2bZmqlEmb4fLjJZCL7mLdDLjoq
 1qLd0PjkqQfEIxkEk2GzslXd8MsMobw3631dUqnBnnSVLAkDaCZXOGuFUpFWowRe7t6y
 BF99Y3StGFHgZCYTPFArNEKBaasPC4yFk9CZirBiBDK10zlM7XyzqUvivYHzY2OTpdtS
 CAggrg9bbY00VYZ0J8Tg5/fWFKYTWDMkVN3sttP56c6zO5PJq77pqlhUp1YfMAzFXB2M
 n/aOguBwKfEdqt1ZgQq6Zp93rRmmQYZAQhslvLw9HKx0f8C0GEdzYACxyl+mRye37Oqe
 w6Jg==
X-Gm-Message-State: AOJu0Yx9YXfx3GPUV+URRzWqpleoB1ouzia5Ct2lamzPdlceYgJySJsw
 toTn+ITEmVHOyYipLuFArU27O1LdD6Y52dDAlGkbuECHT/qku7EBOIriFuxA7mo=
X-Google-Smtp-Source: AGHT+IGeaYphzcch0BJCIl1ZLdvhygYG0epawDbUofXZidS0AYGYO9YPKTc3/pOmjtbk7FUu7UMtdg==
X-Received: by 2002:aa7:9f4f:0:b0:71e:40cd:b607 with SMTP id
 d2e1a72fcca58-7241230ed29mr2886491b3a.11.1731037678918; 
 Thu, 07 Nov 2024 19:47:58 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724079aa9a1sm2539260b3a.130.2024.11.07.19.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:47:58 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 13/15] lib: uuid: display HTTP and IPV4 Config II protocols
Date: Fri,  8 Nov 2024 00:47:53 -0300
Message-ID: <20241108034753.346520-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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
---
 lib/uuid.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index c6a27b7d04..dfc8218fb5 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -174,6 +174,20 @@ static const struct {
 		"Firmware Management",
 		EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID
 	},
+#ifdef CONFIG_EFI_HTTP_PROTOCOL
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

