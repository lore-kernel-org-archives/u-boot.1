Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5485D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9640F893E6;
	Tue, 12 Nov 2024 03:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nJx82tBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 551AE89396; Mon, 11 Nov 2024 22:10:19 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3186689390
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c9978a221so55464445ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359416; x=1731964216; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEdb8OO4eeUClKFdwlauTulCcQve93gQAUVSQC3efgU=;
 b=nJx82tBgr0aBS0wj46bYA+/vnC4xoJ28sts68mUFzWNoaZEd4NYYqXi4i3gzKUIy/k
 JOH5CZd5fC4u8bY2rbYm0jXpGbTYcV7nQ83uwXUqzPR+BhPQKD6cwZT8q93SBKv8e/FS
 KVBUWEEW7eNHv76U5yUv0vFElNNPixDzqHSzY/Df0oyaXSh4i7OhwneITttMfkdiPqmU
 zJ/P2msvBkTosGDOMHZhPHEqb2s3HK2DCc67xNysnWwCcfuTSFeC5+cHKX8FI7UiB+WE
 3XPhX+iGqhuEzE4QMJqtqVEbXhpPZ+ouQSr6wYGtEiRgFVkOfOwYMbmOrxNkhIskNW6M
 Q2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359416; x=1731964216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rEdb8OO4eeUClKFdwlauTulCcQve93gQAUVSQC3efgU=;
 b=fsTWJA2zkTRzjugpC1jOpNW/hGhq/UtA9F6KZHRysAt4gR3podnyyV5BUA7xA4v/1f
 FOkhwHW6fI2ID6JsJtlQdg0LQcIIYadd/k2JYQO2FKkRP0RIWWQAf6Hg1t2U/LySTq3t
 SlrQQGzf1wpICaO9khOezj3rrZekQBazMxcfLsThTAxtaTEwd29tC/g6PDsysRuoHCN6
 ljNXlZIzy06YKWKZOt6zeFoigJ2QVaV6l4pAHuLtnnG2xTWXaQOHIAnrUQFlO/UNiF99
 qxhGTTvBjfTLTkwWG6WRINOHADr0j45lTozoIJV8iWr7Dn/RF9g+V5j3//lI00c88a/q
 WMYg==
X-Gm-Message-State: AOJu0Yy2Nnxy9VNMEjr6iBTInnoIxGsPE1ASVnOBBObJVp2y8IKsfimw
 J8W7dlX/FiwPUEwarNN+SAvJmiPVlaN9MEBfIJjfTloQEyJCCBRyQKDW3XV9
X-Google-Smtp-Source: AGHT+IHOgQD30jmrurC5o06FIGhQMWzU5Qh7IH6nsFPHVkda/reeWxKnBDVpmWAd4bzupG4LyRy/rA==
X-Received: by 2002:a17:902:cf02:b0:20c:af07:a816 with SMTP id
 d9443c01a7336-21183d087c7mr189515255ad.31.1731359415668; 
 Mon, 11 Nov 2024 13:10:15 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:15 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 05/15] efi_loader: add IPv4() to device path to text
 protocol
Date: Mon, 11 Nov 2024 18:09:49 -0300
Message-ID: <20241111210959.560738-6-adrianox@gmail.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Implement Ipv4() node support in the device path to text protocol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

(no changes since v2)

 lib/efi_loader/efi_device_path_to_text.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/efi_loader/efi_device_path_to_text.c b/lib/efi_loader/efi_device_path_to_text.c
index 0c7b30a26e..481a9712d9 100644
--- a/lib/efi_loader/efi_device_path_to_text.c
+++ b/lib/efi_loader/efi_device_path_to_text.c
@@ -8,6 +8,7 @@
 #include <blk.h>
 #include <efi_loader.h>
 #include <malloc.h>
+#include <net.h>
 
 #define MAC_OUTPUT_LEN 22
 #define UNKNOWN_OUTPUT_LEN 23
@@ -170,6 +171,28 @@ static char *dp_msging(char *s, struct efi_device_path *dp)
 
 		break;
 	}
+	case DEVICE_PATH_SUB_TYPE_MSG_IPV4: {
+		struct efi_device_path_ipv4 *idp =
+			(struct efi_device_path_ipv4 *)dp;
+
+		s += sprintf(s, "IPv4(%pI4,", &idp->remote_ip_address);
+		switch (idp->protocol) {
+		case IPPROTO_TCP:
+			s += sprintf(s, "TCP,");
+		case IPPROTO_UDP:
+			s += sprintf(s, "UDP,");
+		default:
+			s += sprintf(s, "0x%x,", idp->protocol);
+		}
+		s += sprintf(s, idp->static_ip_address ? "Static" : "DHCP");
+		s += sprintf(s, ",%pI4", &idp->local_ip_address);
+		if (idp->dp.length == sizeof(struct efi_device_path_ipv4))
+			s += sprintf(s, ",%pI4,%pI4", &idp->gateway_ip_address,
+				     &idp->subnet_mask);
+		s += sprintf(s, ")");
+
+		break;
+	}
 	case DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS: {
 		struct efi_device_path_usb_class *ucdp =
 			(struct efi_device_path_usb_class *)dp;
-- 
2.43.0

