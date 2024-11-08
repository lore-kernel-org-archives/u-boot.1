Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2CFD5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE188922D;
	Fri,  8 Nov 2024 16:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TVsNNkv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4F5E88E81; Fri,  8 Nov 2024 14:39:59 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA068900E
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso20722675ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073196; x=1731677996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcll6O17sa9AneFFHqS5EXLYPgcs38J6JPJAC9JsSB8=;
 b=TVsNNkv8duM0Dyk1yHbpXBIRwqYb3UE1tKaiBbh8NJ9SD76xJtf09v2TqdSrC6Y+qE
 LgbyKLX+u8r1z7dWOOZNgYZiPd4ha6WXM/ouVGN1nmikHTDuVKnDxAuLLYpB0+c8KgBV
 lgw83gD1cZZIb5PKif8sT8uxmDgzCdb/7SBtjWm9ixDhs1g+NiL1L6Yv/HTMlQj2XyMK
 Abcl9f8jdooe1gVFRlEEi5NafBij2pOhayMuKajsyEJwbb8xUKckTz2SAmzYC7lj2QX/
 kAm8LSUvzz2sP3nEXZwo5ohOhMLpHPikePSIu3dqz6G7PDXyrY5Gtc4ebkjc4iVoqlkj
 xeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073196; x=1731677996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcll6O17sa9AneFFHqS5EXLYPgcs38J6JPJAC9JsSB8=;
 b=cqqTrHpk+Gs9ArTgfI3rAjoLNIJC1Rgp+aYfvWQ/qkcgGLTU/b4wNbrtWhO1mD0H0a
 j5c17kd3NfjNMNpcxgfr9JNFTeKI+bH4+cOEtYFOZn8F0zhIIQ8whLhCoVGdfgOu2E6L
 tSQUt6CZJcZlJJge/ex1CVrFaFc2AYVfWzbE2F4L+tGw/UzcXQ/2LqY7gH01ySZLVzOB
 OuwwV42VOw4j1zyTjOQPtWB0WOG6UT7pxL8DktAQcWNoeNXnS1usdXCCxS0tqJaCJsAv
 BpvFCr1b1Qo+ESseF1n1+QKN5RuFjFgx0LZwJ4UGYcDkaILz5EWfkg2k3cOaiqPjAzal
 3D+A==
X-Gm-Message-State: AOJu0YxdNDqeit4QjjoQL2Xg06CsuOi7wNjOD7Zdfr6P+TXN0c9hmGz7
 VbLHu0plOtZCADmCVLhtQ4qMJTUfOpthOgyUG651Dbs+ZieyCV9Ypp7MAM1QZYg=
X-Google-Smtp-Source: AGHT+IE2jffPtd6YHPh5mjeE7006KlehYORyQlcv1h5Gnh7POBhjaJ+ADKsykA52Rw0emm5QP5nZ4Q==
X-Received: by 2002:a17:902:fc50:b0:20c:a97d:cc7f with SMTP id
 d9443c01a7336-21183e0a518mr29246625ad.41.1731073195968; 
 Fri, 08 Nov 2024 05:39:55 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:39:55 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 03/15] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Fri,  8 Nov 2024 10:38:38 -0300
Message-ID: <20241108133850.431075-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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

Add definition for DEVICE_PATH_SUB_TYPE_MSG_IPV4 device path
subtype.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_api.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93..c76519a20a 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -616,6 +616,7 @@ struct efi_device_path_acpi_path {
 #  define DEVICE_PATH_SUB_TYPE_MSG_SCSI		0x02
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB		0x05
 #  define DEVICE_PATH_SUB_TYPE_MSG_MAC_ADDR	0x0b
+#  define DEVICE_PATH_SUB_TYPE_MSG_IPV4		0x0c
 #  define DEVICE_PATH_SUB_TYPE_MSG_UART		0x0e
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS	0x0f
 #  define DEVICE_PATH_SUB_TYPE_MSG_USB_WWI	0x10
@@ -691,6 +692,22 @@ struct efi_device_path_uri {
 	u8 uri[];
 } __packed;
 
+struct efi_ipv4_address {
+	u8 ip_addr[4];
+} __attribute__((aligned(4)));
+
+struct efi_device_path_ipv4 {
+	struct efi_device_path dp;
+	struct efi_ipv4_address local_ip_address;
+	struct efi_ipv4_address remote_ip_address;
+	u16 local_port;
+	u16 remote_port;
+	u16 protocol;
+	u8 static_ip_address;
+	struct efi_ipv4_address gateway_ip_address;
+	struct efi_ipv4_address subnet_mask;
+} __packed;
+
 #define DEVICE_PATH_TYPE_MEDIA_DEVICE		0x04
 #  define DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH	0x01
 #  define DEVICE_PATH_SUB_TYPE_CDROM_PATH	0x02
-- 
2.43.0

