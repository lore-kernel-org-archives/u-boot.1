Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4602AD69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E43B89D2C;
	Thu, 28 Nov 2024 15:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOs3kfOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220A389D36; Thu, 28 Nov 2024 15:44:35 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02D689D33
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ea39638194so757188a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805071; x=1733409871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCL0sc6dScbywI7CnFt+u28w+AOTlXjqKi0BjsYM188=;
 b=IOs3kfOVSVBN2b6rKd4Z1rnh+5640BMtMAf69//ncH9oTiC3n6M+SSsyjeX1cLKtFi
 Nzd4t3EmcuKgf++RQ1EBQU31VhaXTq0PmeC+0DzCqBXUVYckioBYv5jMz3tJUlEu6vzw
 58fC/63F4fN4F3MENsO8h60A6BdKuKOI7aSSW5i+s6MvixI0ROp4Ggia46I9+X22/SvL
 ig5lzyKIoqLpsy3UQJFXT+oV96DoggoupC93IgNrRYtOPVYEebDpudWiRptDU2Vtb1hK
 lwIb4Di8K6AEIRkZiWAqv7ebygSjxoN03FbhwbnBiLQ4yH5zVYkqGzrlPaBAh4acghnb
 yeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805071; x=1733409871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCL0sc6dScbywI7CnFt+u28w+AOTlXjqKi0BjsYM188=;
 b=PN2vGs2SeYzOFgb7OkmqYIOjIlYWtt1eKpmgbYwgsB6e2TzPMhOqTi4wdOc7vubrTq
 UwtsbM94ccygwPcS+ZXgqdJiorPxq9a0aqTIbzswFxfNqF/c/xKLPnIbJ9tD1eXc2w5H
 g2AKP7wZIeDuJqmVKb9YYJZI13IUTN/nNOY+9EWaEmVg1JcKnJX4huX1O5t2jgCwn2HX
 flC3xpn/a+BWeRHg6zEakE7eRWqtpuaGsWszDrBF/1uSf1YcTi06R0/InOp/hzhrJHh5
 M+135R5p+ezc9B5KrZ65bU2zvI1/txdcA/f3oA+6WwQfophWPf456G5o9UHIH9pL1ICk
 9ATw==
X-Gm-Message-State: AOJu0YzQoCX8hRIuwdEP6U1wloIFT9AEQpJ5FuIH1WIxpKkqHQJjSzvS
 v0IVSMWLDZ6c1gkfKsXrRxlL+mZTzJU8iFj2XjGL6V0iLR4PevtwZ4B5tOGBykg=
X-Gm-Gg: ASbGncu4h3b8G65RK5qWYRS19lARO+b8ivECqCvifhofXuHWh+z1WfsaL+1MyPbOMKM
 rzhKcAGEHcKX1pjmx5xhHAa2cTCIJZjlQ4JL3ijm1F5zMNbkOoIfGnYmZuK4i309RT4qb0y4KoA
 v87UgF1SVuFLs7ApG8MIRp7zOGUvco3kKRqt+co2mvGunOeO+4RkuWjVrtdm6kNxznvLgQ85MSj
 b810yeoiGMUoGVfrxQyc8oRWJPnJZkdyNGagkSA7h4=
X-Google-Smtp-Source: AGHT+IFkeVzH/tN0hulPV8iM94slrXXpQt/16TowdG/lSmz4pjV03DmrmH8HI+OMujDxKnCKpQTgOQ==
X-Received: by 2002:a17:90b:4f85:b0:2ea:712d:9a82 with SMTP id
 98e67ed59e1d1-2ee097c1e4emr9036724a91.29.1732805071217; 
 Thu, 28 Nov 2024 06:44:31 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:30 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 04/14] efi_loader: add IPv4() to device path to text
 protocol
Date: Thu, 28 Nov 2024 11:44:06 -0300
Message-ID: <20241128144416.604126-5-adrianox@gmail.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Implement Ipv4() node support in the device path to text protocol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

