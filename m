Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE378D591B3
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08FC2894C6;
	Mon, 18 Nov 2024 22:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I6+BlJSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA97E894A9; Mon, 18 Nov 2024 22:09:23 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC14C88C10
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5ebc9bda8c8so940606eaf.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964160; x=1732568960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yiVtXGen04U2jhRL7NJnx1rM4z0X1yIJqHm3jNX7/A=;
 b=I6+BlJSO2byR7kn2VhyQlS//IdjWy4H/2hpjF9cy2wRIKfrGjPLiI74YQ6cdwRQTem
 yDPAA6/kP2swwSxuDOoW8nvX1/RCq1aU0h9O2xJwCJHW7URQfD/SQJ0NT+5rYF7Qaj+o
 jXfvmeu6AAVMfXuGyoYBYSRfW65kzkOFpzOlqFLkiyGUNvQIwyfdkHgZ1Vn7/kC6Vk5X
 m/eWA94NdIr9ccHPPZp6OwJKpV80zODmo39aRoOPqYQxWC5Ur7h93kW5kC6Q4JQEJISO
 ZPYsw6lcWN8imneLOffeONHRZbF7FSobL6uN1Vi6UZ5ttYl0vcnQJ98bFkTCZHMrXxFl
 sVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964160; x=1732568960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yiVtXGen04U2jhRL7NJnx1rM4z0X1yIJqHm3jNX7/A=;
 b=lVyAttsEj47CfvJmWBpj67zNHzAcIf+cguodozJFtPX3+GIhPalVJO4DxQSdVLTU9p
 m2cibhf927YzN7338c2Rl66QmtXFpKzER5BuOBj1wIuHUeYHbzOTZ4FwmAdcatpGd6NT
 DRCrWHUqLUpjgs3M3mYlJpDdkj5/cFE3XocvVVDGbo54AKv5znOaM8NYr17dJQdN7Q1D
 IOxgrQXrPgsNfBqbcYxtQqg/MfxaMBPElJNAneQeEIaYu0dcg7Nb3M2Hguq07vbqVt9E
 dYiFeaZ/r3zKJZyZ0EAWL4yuam/J1DcYOIv23/sdJWKdeLez3cvZ8qCGF/sbegW4L+J0
 JzBA==
X-Gm-Message-State: AOJu0YzkAbSYq8fjGjnvc9wMH3OoIcJK2PYK5nVNUwQGpaobT3WRFk3S
 Gh1DyZgIJ/ZrOJC4wT2kWZFBC01dm1hArR+cxagnTYdUdYNfX4j0o59EV7l1
X-Google-Smtp-Source: AGHT+IGzl4HlxFV57ZpLgbQbDHUbx2RfnCfZf+AQc64/MF9y8FAV259Tk65iujBhrJZYVKvOOO2/4w==
X-Received: by 2002:a05:6870:5d8f:b0:277:c28c:147e with SMTP id
 586e51a60fabf-2962de0ba2amr11925623fac.21.1731964160597; 
 Mon, 18 Nov 2024 13:09:20 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:20 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 02/14] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Mon, 18 Nov 2024 18:08:56 -0300
Message-ID: <20241118210908.51196-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118210908.51196-1-adrianox@gmail.com>
References: <20241118210908.51196-1-adrianox@gmail.com>
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

Add definition for DEVICE_PATH_SUB_TYPE_MSG_IPV4 device path
subtype.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v3)

Changes in v3:
- Removed alignment in struct efi_ipv4_address

 include/efi_api.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93..99ee749522 100644
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
+};
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

