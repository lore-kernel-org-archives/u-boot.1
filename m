Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05101C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B8EB884D4;
	Sun, 23 Jun 2024 19:53:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ckV+khoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E442F8843A; Sun, 23 Jun 2024 19:53:23 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF44F882E6
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-371c97913cdso16659535ab.3
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165200; x=1719770000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=ckV+khoe5l7GC9iq2MyQoj+eWBf0kU5MBJWkZKhBvq8s3QEGK667fDYAjyqBmTvlVp
 8u86JfSuPuokCquEDTMZ/ESWvGfuXLSHltKFrKTRqhCj8rpMuRpeJRNYiSvFPTZ43gRy
 nfkAoMhkpwKuViP7YReVHOfpQO8C6ez3z2kxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165200; x=1719770000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=l85aaScElrkNGjupTdmzjUinxgnJ7eFAH9f4MiuQk3bjZ374rTWLfxWNmYx2jP2RqX
 QLJcTnpSH2Ae/wQAYf6rKXvLfSinkRFUBzJuF6UITRJkRAgChyIayKjykJOOsABtznVi
 p1hJrFPTsP4+Zxm1PR5czadYjYXVNsQlMOciMLk+Eep30JSKxLlADitGB+WhJ4KGuk3U
 aYXhp7E8H4Y1iltvvfvewalTOi9wC8ogEC3hfM4bDNFw65fZcK+WNq69UfQl39BzbfJP
 3LvFtzbnfyGbNfyiI4zbLezhLSL51U4dE9QIf9u5e8VJTl6X/S0g5pU/kFKeUnN1P+xu
 Xexw==
X-Gm-Message-State: AOJu0YyPAssndUe8AM3NUFBMLiLXVK7anzn/wUIK+GxqvSWgOfa09aoG
 9Fu+UUkXvX1j8khn9wULDMa7oIId9zYnFxm/vwS8YVkSEdHJAFwYoH4WZ+yN4k/lcYA6nC6Oulv
 c2Q==
X-Google-Smtp-Source: AGHT+IFTqfFuchwfrRKBrt3lASC1nNlukUCbXJ4qMn9q89sUa24WMnhpEMglhsBdiC9sJMCbSuprsA==
X-Received: by 2002:a05:6e02:12cf:b0:374:ad0f:1b00 with SMTP id
 e9e14a558f8ab-3763b1bf182mr47719545ab.15.1719165200290; 
 Sun, 23 Jun 2024 10:53:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d113ff85sm1636834173.81.2024.06.23.10.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:53:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/16] mkeficapsule: Add a --version argument
Date: Sun, 23 Jun 2024 11:52:47 -0600
Message-Id: <20240623175302.1463973-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175302.1463973-1-sjg@chromium.org>
References: <20240623175302.1463973-1-sjg@chromium.org>
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

