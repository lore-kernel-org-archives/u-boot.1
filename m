Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5953CD591B3
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7756894B6;
	Mon, 18 Nov 2024 22:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dwz6a0dQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5ADC894BF; Mon, 18 Nov 2024 22:09:29 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92E4C88C10
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2968322f5feso649619fac.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964166; x=1732568966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEdb8OO4eeUClKFdwlauTulCcQve93gQAUVSQC3efgU=;
 b=dwz6a0dQr+z9pGPRn70z0AVnHFWbbY4h3qm6m6ze3I3OcbtIum7qjqhj7ssrSWwa3y
 m5jbTNyYKbHPYA6HXikEYinNU/rc2UwW1h6ZsayYkMleFD/fOdNMG77vIXM3BI1cycCG
 0QB4DYUv44rNSqeZJWEq+YFhJ7WHWmdM276wsfh1XUvpNpglPakNLslFMmL/1QpF/igp
 zBSZofwyzUkN2fESMVl+JHUd9RzH1djUmfBSsXCLDiq3CFEhEsnpkC1APB0xwMyVa2ej
 urfqS8VdGsp14dRDHxrxcmVau1ZzUvF4FqucRhG1Yn6ZLmIhD/q/F3VrdYA0mLMN9KpS
 zd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964166; x=1732568966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rEdb8OO4eeUClKFdwlauTulCcQve93gQAUVSQC3efgU=;
 b=NUMlNQD7rGYex8Eln6F3MVU7mTDvvapQg+1D7+Dr6jtz8u40ou+xDqRkgI2IMov3Le
 4wuvu2qIpahOXI6KPhscukeu/nj89YBTmqXbDEdt8nABXvUETQ/xD4R5Sss2d9OLY2gz
 6tThkPiXd/zoUCXtsoVD0u7O3Bt5dYQDYH2U9WoT7YXuiC12on9+BkyHLz5sg9rFP38/
 nYLbZjT/m7sVZph2erMaTd5KhH5sFH7XLqhWSthXp6lK8MskaJ/0rkNsuD/WhclE36Hu
 u42Cr7K9l31GggUzVjeppUJm+pvDkLo7oGlkPKJ/wMtNYCcTEHUTjPrG0mLpR31tJK9V
 mQqw==
X-Gm-Message-State: AOJu0YyJsgEUt3nivkLxZ0teunHPetu+BBH3U24IgrKKoyicM3K1GNKs
 R918Jx52czDO5kxhkNh9Yy8cLNF6VM7EvkamOdeCB7IgyjUFjWFeNG8riUWW
X-Google-Smtp-Source: AGHT+IGvNZHW2XZZRQH6IWDiIFpVvJWZJWPliSVfiZHrtDOFzdJFXxXG2eS6IPyMESz/2Tznp5ODUA==
X-Received: by 2002:a05:6870:568f:b0:287:d8df:7c22 with SMTP id
 586e51a60fabf-2962ddebdf1mr11787621fac.23.1731964166191; 
 Mon, 18 Nov 2024 13:09:26 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:25 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 04/14] efi_loader: add IPv4() to device path to text
 protocol
Date: Mon, 18 Nov 2024 18:08:58 -0300
Message-ID: <20241118210908.51196-5-adrianox@gmail.com>
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

