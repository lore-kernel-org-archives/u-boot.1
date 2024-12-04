Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E340E7716C
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E748950F;
	Wed,  4 Dec 2024 04:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USQxc1bT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B79893EE; Wed,  4 Dec 2024 04:05:43 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639D888EA3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-215909152c5so29593935ad.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281540; x=1733886340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0Q7p8P7l/tTOQH+uwOrMlMNIYLVR+JTHb9JNOzU89M=;
 b=USQxc1bTvP9KtclIAqZIndGU7LnnRR5IcQ0PDWgOq4l3E6fUAc9imbyYy4eoxa2fbk
 mlyXJZ1zC2OS8cejZIAqXcdORiQArC3mWuJZgIkWjJBu01Axf2bg2ppHQBo9owmmSxad
 /mTtqV+vduxhyEblELhCXGpHNbtXO+kwUejlpPJXtpCSSsRsRD9w/Xwcb7bQL0SNkfgn
 qHZYoioBTRVyyHZp3oXJ/n5exJka5rxZ5AlnKyjA2CFDQ2grWSkwS7i9TTw1/MVWjc0X
 xZfwVERR79M1sKTekR3XqsJvXvrN8wqn9HmGdcXAxGhMtl/069aZxTMK4cy4x2NL839G
 Eypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281540; x=1733886340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0Q7p8P7l/tTOQH+uwOrMlMNIYLVR+JTHb9JNOzU89M=;
 b=eQHhxpdLruRNaweOmZzKzttu+NtYN/ul4xYgJ1r0bf2gj4RzBpGd2XwQkL1wHBGLbj
 JJoyMGDkkOTx3HUgNlaIVg7s7zW5CGxgO/ptr8O1oI1YmE4c1hfI+SPCBs0eVJYTju85
 Ai1sESL7QanUkk8/G5LyW8p/sugk3narqZWAqpHB0F2aVwsDh/yVCQVWeuUI/z3HoNkV
 gEJ8M50qHQb5QNi7rEavoFlbgzog10nTZMjIwEeiqKPEbqZupStDi++lAEdHvc6EsAHH
 vGhV8PIK64DTUGsST9GsLcl/L/g9y+H5YUKErEhrURxt3YOuWldF6qA3gRFu8zgpVQy5
 v+bA==
X-Gm-Message-State: AOJu0YzcmXCVr4c9Yac+4ZGJjU1/8zsV8fjmL6HkEKh4/yYsNr02oBg2
 DP061DXS65WFWdrhlfpUUPQhVm1Rx40RAcGctmUAslWIV8Ucg/GX3pLKWVyQv/k=
X-Gm-Gg: ASbGnctqbWtMAb1nkgxLvxfcsybSZcZ79BxnFDndRqxLZHokbSJIotFf7sAkxyfrqKB
 JdoWiinahsX/EmR0860bOSNdAsop72Tyv4S+Rh/MwOmZkBL2tx1BcW1rknixYFMVKv7kzaEefZ2
 Ia+K7T+MTr5r83as7dd1BkPkJDQomUXFyDExCzRSM1BdMg99v4gG5rMZYalGzuMFQaxYI10T6Ax
 A3HY82hdqTFBGIu8OgVPso/0tEJUjVdON70pBYWjVU=
X-Google-Smtp-Source: AGHT+IGOYcRcXv7epZKf65OxkwwXQZg6XJxYXMeNq+bJwNf8d8Vo1qE/ReTToXk9DfuEe5VVexd7rQ==
X-Received: by 2002:a17:902:d504:b0:215:7cde:7fa5 with SMTP id
 d9443c01a7336-215bd26734amr65925075ad.56.1733281539891; 
 Tue, 03 Dec 2024 19:05:39 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:39 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 02/14] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Wed,  4 Dec 2024 00:05:17 -0300
Message-ID: <20241204030530.2099776-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204030530.2099776-1-adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
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

