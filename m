Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0CC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86C5688A5A;
	Wed, 31 Jul 2024 16:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KyJtSIiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3722488A4B; Wed, 31 Jul 2024 16:49:16 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B8988A2A
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-381f24d6bc4so23748285ab.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437353; x=1723042153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=KyJtSIiKYd7X4BAPztTNJDBPlQ/ntFaTpEjSSTmc1ZjB8k8Sm/kyC28gC3cmGI6+Zt
 Qw4CvHi1w7AXDVNQuw2IVTq8MBb7SZTXhxebgdkiWn/Gl9fDinwM47vQYf3dXyrzTsX6
 1AT/w90E3Iz1PKgJlXEvtXYLnMp4GzHhTfKn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437353; x=1723042153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=pXj8XE2TPVRVVPdzrJ2wIuCawlm5/GkqYKoj2j7EnNdYxoTVVYLtNY7xd/fcKTSZ40
 u2363RQYG4XfFdZg/p7Y5xJxAThU7rxsh+xs4jgwO6ZIm+GNPUhrTc2JfN2pB1wgV389
 quyZP3zPrCWjcw45zuL/vR3QwJMYmQMREBgxKjZio8kYgYy4c2c/SeJN1VORRAx9Q3Fz
 mVrZ4IOxFPe/B+A0eqsLD4DA44lSZ0zwC+iM2CzmIoQVzmt0xAgh6OXgvYZn/LdoUQBQ
 6RVGtlo49NXZvu+caXa9VHfYVr6x9n9XK8odUsUN+9SZ3F8qjVvBjYSRclsdloRWNqK4
 qj6Q==
X-Gm-Message-State: AOJu0YwOEj/uUJ0zp7xh43tiglqxA63IP1h6npqRVwzaUeJStP2IXiA4
 QNZOm5c8TgnSRvqDvNB1kMVlGicEKhrCiUe6/Iwrbt/8cG/ptgmw/P3Jpp3+Loo7oxoD4lA45QY
 =
X-Google-Smtp-Source: AGHT+IHVjikEApXmy5gamoANeinN76oqWKtPj7cbdqMQOSAIPfsE3BtTb01lSbL4BUfBUjoDdSCb8A==
X-Received: by 2002:a05:6e02:1c25:b0:397:a8a2:7c58 with SMTP id
 e9e14a558f8ab-39aec2d0a90mr156378955ab.3.1722437352694; 
 Wed, 31 Jul 2024 07:49:12 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 1/8] mkeficapsule: Add a --version argument
Date: Wed, 31 Jul 2024 08:49:00 -0600
Message-Id: <20240731144908.795290-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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

Tools should have an option to obtain the version, so add this to the
mkeficapsule tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/mkeficapsule.1   | 4 ++++
 tools/mkeficapsule.c | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index c4c2057d5c7..c3d0f21488a 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -87,6 +87,10 @@ Generate a firmware revert empty capsule
 .BI "-o\fR,\fB --capoemflag "
 Capsule OEM flag, value between 0x0000 to 0xffff
 
+.TP
+.BR -V ", " --version
+Print version information and exit.
+
 .TP
 .BR -h ", " --help
 Print a help message
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 6a261ff549d..c112ae2de8d 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -21,6 +21,8 @@
 #include <gnutls/pkcs7.h>
 #include <gnutls/abstract.h>
 
+#include <version.h>
+
 #include "eficapsule.h"
 
 static const char *tool_name = "mkeficapsule";
@@ -28,7 +30,7 @@ static const char *tool_name = "mkeficapsule";
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
-static const char *opts_short = "g:i:I:v:p:c:m:o:dhARD";
+static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
 
 enum {
 	CAPSULE_NORMAL_BLOB = 0,
@@ -70,6 +72,7 @@ static void print_usage(void)
 		"\t-R, --fw-revert  firmware revert capsule, takes no GUID, no image blob\n"
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
+		"\t-V, --version               show version number\n"
 		"\t-h, --help                  print a help message\n",
 		tool_name);
 }
@@ -969,6 +972,9 @@ int main(int argc, char **argv)
 		case 'D':
 			capsule_dump = true;
 			break;
+		case 'V':
+			printf("mkeficapsule version %s\n", PLAIN_VERSION);
+			exit(EXIT_SUCCESS);
 		default:
 			print_usage();
 			exit(EXIT_SUCCESS);
-- 
2.34.1

