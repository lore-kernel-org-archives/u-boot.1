Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9636AC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C672F884F4;
	Wed, 26 Jun 2024 18:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zr8TL46M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A804884DB; Wed, 26 Jun 2024 18:00:08 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2D687F33
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42562e4b5d1so889155e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417605; x=1720022405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=Zr8TL46M+6cT32nHd/zKCfpSSfJ0xcAGXl8AIrJCJ+UvlQgE9kxKCQpOgR1cfU+Ult
 oQW8D8V4rGKXoIbu0Czo0tZeuzyWhO+WMXqYLwO9T4pdjjAMqs0HpNee7E50bQp3vNRX
 AuCb6GmtSGke7qDypBwjHV+lgZMp3Z9+awvhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417605; x=1720022405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DwbEmlb7j97i9Q+0Gkqlcn3kq0fvAKIR9SwwmRHzEg=;
 b=l4FZmEFSdUlmwaCNxpuYeXT39Wnji3FoEk+yVFgWCG+d8Y4ak8yQjhvPU91kiCjGbf
 ueN3zC2eY0nj7Pfp2omWvGoFs70H043r/I3ZIvcOxC8lFU1QhVJ5t/ub/Ao3KU0ZWBU0
 9Ta4O/CAh5jMEkFTaa2Fs9rT8pU0czJZhF+wv0bIwsCk8pNZshyq3HEjQbkGY0yOdNN8
 AzEmLjwaHYRpVULT+M+Hna0xUDSyOuyJ3+jKhnT22vXJ6sfMxsYHHdM6XZEoYrSwA5aS
 4IH7gDtlnnIt5/zYn3sNB+csM2E1SokfVMoj/kHl3f6ET+uJ5NKiqyTBOd31WBGP591I
 4UAQ==
X-Gm-Message-State: AOJu0YyvPDXqmqf8vg3Jj/cYFvf2xBJgCcG2mZApBFYm8n/42X/lgZde
 +OzZG2GhyEfeGpfF0wP7DFSL+ozrsAvPUZt9oacseLXkz484Ira76yUfVixdp9xv4XoYcYQAwOK
 yjA==
X-Google-Smtp-Source: AGHT+IEWCw/vogDWQsQ7Rs+emt+SjWWb3ca9mOEDQFA0BnS+6zOX46MQ9LbFf8MJ/b0ezUK92wVz0w==
X-Received: by 2002:a05:600c:2e49:b0:424:a48d:976c with SMTP id
 5b1f17b1804b1-424a48d98a7mr33520525e9.30.1719417604640; 
 Wed, 26 Jun 2024 09:00:04 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 01/16] mkeficapsule: Add a --version argument
Date: Wed, 26 Jun 2024 16:59:30 +0100
Message-Id: <20240626155945.278640-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

