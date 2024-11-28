Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F91D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE04889CF9;
	Thu, 28 Nov 2024 15:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lvOIC175";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC61889D28; Thu, 28 Nov 2024 15:44:30 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC9989D19
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ea8d322297so688629a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805067; x=1733409867; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhmG0zcR3gQZNpm2QEhClDo3cUQLcA6m0jO614l3SoI=;
 b=lvOIC175yZnUdFSt57t46LxWOCdsVn56G11qzBJQzhsJTA1JaJ1lbTzrVz2MrALDRa
 F4JnF44NOry42Mi2Ci+KvI4RG5ZKiIZCKzaPOxCUbmX3lcfs+ssRH78mgnoEf+KCqsyO
 4SdYvnNlOU4Tr09qacupo596gSrg+QnRg0de0u8YFxQpkMtglyfj9KN9i9lgSGA9xgvT
 /ievmALzVrk+JUh5FgLWiEmy60tyHVHyT7VOx7Hlp1hf8lZwkFx9ejD1CTozdBvLZZMx
 lGtmXpRyzKMJWRgCcyZaYZ8XZ3CftUbV+YoOgX3h7mmHuYPgcj0LXaA/v2pbRgNLmJIp
 4hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805067; x=1733409867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhmG0zcR3gQZNpm2QEhClDo3cUQLcA6m0jO614l3SoI=;
 b=leMtInuTfSHB9vx6SkhYnUIbA0vdUdEJr4HTxTgS6eO5usEBKC52KRNo/++P6A8YwN
 cKiuQH6LwuZwuMlPhD994g8a64io0XbXPm/Ar2FcyZMgRyaC/2ErB9tplO15DlxdFOqq
 6tXTVgvGSGO2OzaMfd4NNk8O6jznQvBGRKJZWF0M2vmkH/J5O4hgul2NQUKQ8oC8jZV7
 O0AfvdFafsPR2zmNfgn3s1AQ3S1HpAfuBi0ub9kCd81Io9pjv4PUB6fuZmJlIDrJLbyq
 nPa/S2ij151CU6UmigB/Zy4z8NdVTm5uOYTIDDPVREl2fGyKZxMOSRnqIFzMdH9bL6Ht
 Cgaw==
X-Gm-Message-State: AOJu0YwgKv/nPCFmUrPglL7ie0PMFFA+f/YbI5IIsK0qLK0vFjnm8WF0
 Jq/FWjfjhzdW8L6g55B3mrAnCL7TQNY+FTht2JewBW74f1tQJmIskdVnxlZnWIE=
X-Gm-Gg: ASbGnctEjC5DX1Cb1MUA9+6rqtzwhuXca9KOB+zuTr2oLBfEVzCdSH/tYKmfJKATiO5
 o4qJEt+cVCx7HL6BZtuMwt3RC5pVPdi2+RcjEsSpYC5pnire2L+nwmlQoyeG3uTrGV5l0qZTtMB
 adh8q5eHNFRzv0AeSbkrbNPbNmrmTRidJi/YtGUs8fijtz1gBgmOuK/U/YHQ9XkcxYnKr0nG93z
 C7RoSEmz5EaVbZ8Oc9AIHr2B76kOSOtyoMayFEaFDQ=
X-Google-Smtp-Source: AGHT+IF2VZaaxxsEuaUh6IQjJcK6hIUEJz9lE5lkcyiSMLjUPcP7ZiKP7QqDAnTFO9TI3/nF14sD7g==
X-Received: by 2002:a17:90b:164a:b0:2ea:9309:7594 with SMTP id
 98e67ed59e1d1-2ee08e997e9mr8957616a91.4.1732805066933; 
 Thu, 28 Nov 2024 06:44:26 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:26 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 02/14] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
Date: Thu, 28 Nov 2024 11:44:04 -0300
Message-ID: <20241128144416.604126-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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

