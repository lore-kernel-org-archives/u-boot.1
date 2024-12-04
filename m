Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C737AE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A35689677;
	Wed,  4 Dec 2024 04:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V668Q6qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D7C7894A2; Wed,  4 Dec 2024 04:05:49 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CB0F89669
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-215b0582aaeso17733475ad.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281545; x=1733886345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxtB6ikyq5cdkTDgFcFC1nGyuk86+jm2NKK5wTaloF8=;
 b=V668Q6qeIx7nafynExMcHOX/j3ZwB8TYWL1oH6u3WGyQgEJzfKoCeLHL1u0MTbiU3o
 EOoNMeFINUojsyBNBe+vC+ZjaWEgyOpLgaHGOVsbRUl+rnX5tu2jdyFddTwMkltf3WZh
 ifOlvVt8Fww1nB4HPdElOYoWsAEGG9nZQ/wIdxABx43qtqjKdpNNvkHOwZBbZxd4KYTT
 haIkYhtOY3midhBu8uegF2cC7U5C10ZclOkg4rm+4L/rTq7XNVP1aO6GNoax70NkMn2P
 qLQjk94RkaMqnySjBxxkryFc5dwE7n9qVT7WXtRS2w3MDtaM8ycad2udghi+2I8csoMD
 m7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281545; x=1733886345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FxtB6ikyq5cdkTDgFcFC1nGyuk86+jm2NKK5wTaloF8=;
 b=Kq4+zkT4XNLOF9eW0PUO8juXD2JACOOI32jncqQTAKIFt5lvrh5/W3TnZrNrufWZ6P
 Adxv2CyqKokhoFK6uzZZXehZ+mdvMWngbmGgMBAs+gsx0eTrz2YpELEXwUGw3uHSUgSy
 TsEqkY5mJH5GS6uSxGqGsl6UX73ReB2Nwy+WlkM4wlWwXE64xG6v80VcVKb6Vfke6Ita
 QW1TZYGwSbBHr7SCJsUWDtBjzqZU+EiBL109no1zlYhjmJoFzVOINDCtTB7yXVZaY1yw
 Vz0ZRsfk/FF5yWszU72U3ZS/yH76iaFXLQWtfq0TETlqBOqGEtE9sTvIsBqDBuHKFxU+
 x+Vw==
X-Gm-Message-State: AOJu0YxZF/iPFlS3VO7xxcjZbzUEaDTqB819B3uzq3ejUpqV0tQGcMUR
 XZqH1O5SziAsZx3tc2/q/1ieuP3A62WgB43ETw+6uc2fPSwE1spgAOVqWdgAxgk=
X-Gm-Gg: ASbGncs9DJkugbvkAxIaHlKd07pnkvCyX1sXO9sx3N8y0/THaqWWWv7KVwSMBh97Xvw
 c2x5rTzqz3XtQH/7MhKzogMFSxlqu6wZkwlD6ELBweyvR2XZufkcDVKbRFen3ZvEKC364uC9Uav
 hcHc5nOoudZ6cVCl41+9WPgK9KAbxhER+raIl4aKEwlXYFuS7x3li1WJVIQzF8APMdVe8jMM5V9
 P8pWBpJlbvCFB4ZsHZXvV5pRVDbH7vs0x2M4i51VnY=
X-Google-Smtp-Source: AGHT+IH/l54PMpfh2Y/jlBOoEwISR6SriAKxvBXdSo/U4NLJOddVY7jTYdkYLjdiXCgUWZBQqIqG/Q==
X-Received: by 2002:a17:902:dad1:b0:215:5d8c:7e4d with SMTP id
 d9443c01a7336-215bd181de7mr68074165ad.54.1733281545567; 
 Tue, 03 Dec 2024 19:05:45 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:45 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 04/14] efi_loader: add IPv4() to device path to text
 protocol
Date: Wed,  4 Dec 2024 00:05:19 -0300
Message-ID: <20241204030530.2099776-4-adrianox@gmail.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Implement Ipv4() node support in the device path to text protocol.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
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

