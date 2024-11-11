Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AF7D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5746893E0;
	Tue, 12 Nov 2024 03:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hAN3ilM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE58889390; Mon, 11 Nov 2024 22:10:16 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90EE889393
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-211a4682fcaso7759585ad.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359413; x=1731964213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhPForE5wtLaH2G9Cz7r2xFbpJUcXpix8WZuV3LRZ80=;
 b=hAN3ilM36m3w7ILUTM8g1Iznrbf5DDE3kwYedslaU5Wm6wbLiGGA3qgDoOxPm/ypxn
 PEYsR3OJF5xxEp50CX3F5QQKDl5B2H8/+aLdqnoItXUyflzx39ro1bU1BaY/ZUWXObOo
 OMsSungK2veaA/AZGkAFaVyodu93PqqrVgHksaJMvMdUZFl5ds4Cf1De08o3Aoyg4Ve0
 jZQjBdJsptMYE9O4iuezdn6noycoLRjd3Mu9gJCfMSqTYH9Rbi1SyNlPZA5B8m5mRLf3
 MCq+GGvQr3yA71UUJC8TlqcinfShvFUzX813Ld/cE7tflunZLBqmbdegzF/77nksbq6l
 CO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359413; x=1731964213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhPForE5wtLaH2G9Cz7r2xFbpJUcXpix8WZuV3LRZ80=;
 b=fgrNt7y4EatxMV9pUgRTZ1Vd/33zhY+rOhxQOrTlio9YGD2XIYGe58iBP7c6/mBtvS
 86MwHHlaHRnAgfXUn6FWzyb1csiMubgUexdZYDyS8V0cQXWSxtWgRLd1b6eGw+eNYkM+
 /yNTRWmbkNOhrBgKIJbLUKzDijKdPiRO7bI46d1WRhe+1MztcUNrVVlFPkOwKpW9Goql
 HSv9ymJ/6pQqgIp7eD5/kSKLThi+ky8xH1+0k7E3oRSzYtoaGFtwXIDta/dME3Ic/NQX
 CuyLctpUB04aeklFe4GGmA+tDfarM2CyDTXt8x7eRWvnoNzFYDDdigzE6qGYuHXfzeCg
 VPlQ==
X-Gm-Message-State: AOJu0Yy7EGzTMqEpNmBwL/frNumIccBkWBeWHOmDVor5riqDmZm2Uxq1
 KxCx5BsJSwE2sJ2xqItkCsp3le7A9RBjkedh1Nw9w/5EhX7xPpG4oTs0H8O5
X-Google-Smtp-Source: AGHT+IHUlu1vgXdk69RUYrc4/yAFxxCROpA/jtnIW3zR7k1NdiI4nt/wppBtSgvIhpi4akQxJ1lJag==
X-Received: by 2002:a17:902:f681:b0:20c:7c09:b2ac with SMTP id
 d9443c01a7336-211835cca0emr196477725ad.52.1731359411469; 
 Mon, 11 Nov 2024 13:10:11 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:11 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 03/15] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Mon, 11 Nov 2024 18:09:47 -0300
Message-ID: <20241111210959.560738-4-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

