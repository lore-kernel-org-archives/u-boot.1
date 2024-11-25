Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F017BD3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B7B8995B;
	Mon, 25 Nov 2024 01:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZNCD5Js";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC648961C; Mon, 25 Nov 2024 01:58:38 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C94CD8929F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso3681399b3a.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496314; x=1733101114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCL0sc6dScbywI7CnFt+u28w+AOTlXjqKi0BjsYM188=;
 b=CZNCD5JsOwOCdnSPljeuwBKLqKpMcm4aJw24CuFpWaJWE+Mc1lFMuXyyxfYNGLgxXn
 nZ15w2uH+LCX28j7MKgo19+GOsVuniQwD9qXsvpHZh+yB9jg6CE24JrT+ttsRFrf4Xxa
 /E8+iF5IywJmyFHz4TGWvlsP9epjoBJvlIv17FgQIfvENQibsssKekHUVGHRaTo9Xdfh
 sD0eb2AYCRZwO2m+hrAAySJOaRSqg14ujge2izJ7K7XEsPdYGheouElVd3YSkJY0pMYz
 jnTP6cjdDa9n8EZ9vaLrgK/UkGXPaS+cUBJqhaAQGErrpQSaK8f/sF0YKNo1+6J78Vxq
 9ZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496314; x=1733101114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCL0sc6dScbywI7CnFt+u28w+AOTlXjqKi0BjsYM188=;
 b=BXgRKEqQ8OyAZ682jDwCGOeObU4izaAUvgRvq4kGJmiVQwyl094wCD3cjgtBSGMqog
 pLiXRKtJu9V2ekM3VPaSBlTH4V8Mtpzv43GUyavolOWT/reh4NgRZkjAgCELn3RfztUz
 DLfOLsVXWn/b8vRCO3plsPvExbYvFH6XA0m6qjBuEGgaPFibNAFvGP9RZlzWmx+hy6td
 J5pKALjyyk/vJ5DNxm7IpLyuy6BxV9PGRDzQ3vPF1nhYqABw8Q4wBLxTs6jw5HdItB+n
 9vVqkfmxCH3bwHzz49cTeV+7Qs3/lvwPsHg4KBYIkwizVsyPq/DLfgLEtZGYUjLahR81
 8aLQ==
X-Gm-Message-State: AOJu0YyuE5f9slUawr0o+TCsFOmG+psbVh5s2hzCNg7HfFmlLPbn1SsM
 fOkBVnHfvl0OCkhAQZ9rmpM2jJo7NgDIRJcQDLKsHw83r7vqxhHr5G+dnsLmCjk=
X-Gm-Gg: ASbGncspqxTQbWesSO1JT7h0V00g8zKgtDQ7cMNlVNhzPktSuJrjSP2CgYRTTAAMOh8
 yIQ3AUfByMKr+6lo60NT1k5CxM0M7OgXZRkTJsjxw8PaJw9MiVPwWw8edcCTE6QH+YrQ4+a/xb7
 ZWB4t98HmXaFtBnIQwTMiSb/L1KGII7SNA5HOIZqnVeBJJolosWzTBojgS7UlCYOhWTfaZX53aw
 3jE6S3uex6uQiR6V9U67PPiS8XPz1397sTyL0Ftsm/a
X-Google-Smtp-Source: AGHT+IGGRK7gmOhbDy74Jl7kJmEMM3YYnD593nU33J6H9lV9zJBfbwdNbwV1+XHLPIuARCKuD4DUMA==
X-Received: by 2002:a05:6a20:8426:b0:1db:d8a5:7c82 with SMTP id
 adf61e73a8af0-1e09e3a370cmr15372366637.5.1732496314138; 
 Sun, 24 Nov 2024 16:58:34 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:33 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 04/14] efi_loader: add IPv4() to device path to text
 protocol
Date: Sun, 24 Nov 2024 21:58:04 -0300
Message-ID: <20241125005814.236669-5-adrianox@gmail.com>
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

