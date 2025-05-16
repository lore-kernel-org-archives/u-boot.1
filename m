Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAD3C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D5908277D;
	Fri, 16 May 2025 10:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HASuP7Jx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6755082A33; Fri, 16 May 2025 10:17:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A328288D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0adcc3e54so1064005f8f.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383467; x=1747988267; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8lUxJ7EpDgqGM3SAClqAkl0yVCFQualNE7VI3l/e4M=;
 b=HASuP7JxLZ5xHHnJpPpfGeZfoIXJS1JMxNJM4p49/hx+4ZD8fzVolTX64MMAFylxNA
 PhdVIUf/YlN/COtss0DVwztb11C80GJ/xnQlyWZUS4RR9N7GWVhPB+ZuzN7YUMIT7UJV
 87wfaqnGgn+YwIfiAsQCv9gBMnPGye9qfGw6mayWbaf0R4JwzWjz81jRf1x+mKixWcIS
 FGb7GDlTX4iiKU0iAyWUhcOgWdVaZDXaEfpIHG8ulcZPz4NGYPTEQ1LN/stTaTFJoUu8
 xLP4+GW6HGnayWhCrzHGhnQ8w09LV9uuiLS6cueD5o2/z8zu84t4c2xnHCwUsMlnzErj
 wSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383467; x=1747988267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B8lUxJ7EpDgqGM3SAClqAkl0yVCFQualNE7VI3l/e4M=;
 b=eOh+fwW27Ea7cCOdud1bJ4p5KCudoakEdL+xK+vowZoSs9frHRn8UQybaGUlQFaX3I
 fCWE+cqdDz0amyTrm+qsisxpB/auBHUcQhI0suDI5Z43lA2Sx00CclOTazHiYXz91D9N
 0F5+JysAKY4LZvD6QXcQjWbSI9aaOixQGIxIJ2l6SocfGjuvNYI3n5BnDBOu+3kwiAyW
 ly/iFgng6oZpbVrHQz1iFhxlg8o8o9K4NENEJtxI5eYaK6McfJ2ydR7mXnkNc+prEsRQ
 6kwROsEl+2mFMUhmBPQQhLWVicBgHyM0cIhaEEqFCbrBVZPC+9xn7mjKBCSuM6ZoQIVq
 OCXA==
X-Gm-Message-State: AOJu0YwWgDdJlclW1wsuAhZ8voJDHxR4brK7JNzNhYGB41SZBczqoWjn
 jsck9/FAD6m4+vm8iIgxZpVNRMsXgT5agKWHbj8ngMZks1NwUsp/9wcxXQCDNOa+Xuc=
X-Gm-Gg: ASbGncuWJf8fVztd+GKx7oUH5aq4lW3c48uMNsW+2nfGd5297i9f1Uh3mMS/IGBi1vP
 eNATUuGY8u5AjF/y1WBeD8ZCnE2CqypcyEiN573TW0AbpkiTew9+8PdnOhVUPWwCkgiWpKEEg7F
 LRCfrHS5tzMvt8ztUWXOFiuChJsCA0cXTx8e+2uqS4I58h/XjttUluSmXOikhTrQB6OZDAmrEzo
 BKqWg1LxlLmz2naRGsm6f/CJVqPPmlpHrzipzkRXWXH/ddEDjrhi7M2tvP2/Ku4K8UcH8xz2AeG
 FokDmb81Piz0Tfpnu/DVnn+E11YC1L6C9YYqFwCDgqnIHM5hx7es5XvxUomKNuxRWFnm5k/w
X-Google-Smtp-Source: AGHT+IGlRlRIyLKIKved28LH3YDMGkobCwPbeteQiE763tJuPBBaBWlmqh4/+L6BDrZAs5TOM6FITQ==
X-Received: by 2002:a05:6000:4284:b0:3a3:5c00:5819 with SMTP id
 ffacd0b85a97d-3a35feab76bmr1295848f8f.27.1747383466848; 
 Fri, 16 May 2025 01:17:46 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:46 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/9] lib/efi_loader: Move EFI network files into
 /lib/efi_loader/net/
Date: Fri, 16 May 2025 04:18:31 -0400
Message-ID: <20250516081839.28587-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516081839.28587-1-adriano.cordova@canonical.com>
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
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

Created /lib/efi_loader/net/ and moved efi_net.c, efi_http.c, and
efi_ipconfig.c into it. Previously, efi_net.c contained implementations
for all supported EFI network protocols, which made the file bloated
and hard to maintain.

Now, each protocol has its own file under net/. efi_net.c is responsible
only for installing and uninstalling these protocols on EFI network
devices.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 doc/api/efi.rst                         | 2 +-
 lib/efi_loader/Makefile                 | 4 +---
 lib/efi_loader/net/Makefile             | 3 +++
 lib/efi_loader/{ => net}/efi_http.c     | 0
 lib/efi_loader/{ => net}/efi_ipconfig.c | 0
 lib/efi_loader/{ => net}/efi_net.c      | 0
 6 files changed, 5 insertions(+), 4 deletions(-)
 create mode 100644 lib/efi_loader/net/Makefile
 rename lib/efi_loader/{ => net}/efi_http.c (100%)
 rename lib/efi_loader/{ => net}/efi_ipconfig.c (100%)
 rename lib/efi_loader/{ => net}/efi_net.c (100%)

diff --git a/doc/api/efi.rst b/doc/api/efi.rst
index 43d6f936fb0..9df9fd223a1 100644
--- a/doc/api/efi.rst
+++ b/doc/api/efi.rst
@@ -145,7 +145,7 @@ RAM disk. U-Boot can be configured to provide an implementation.
 Network protocols
 ~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: lib/efi_loader/efi_net.c
+.. kernel-doc:: lib/efi_loader/net/efi_net.c
    :internal:
 
 Random number generator protocol
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index cf050e5385d..92c6822bc13 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -59,9 +59,7 @@ obj-y += efi_watchdog.o
 obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
 obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
-obj-$(CONFIG_NETDEVICES) += efi_net.o
-obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
-obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
+obj-$(CONFIG_NETDEVICES) += net/
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
diff --git a/lib/efi_loader/net/Makefile b/lib/efi_loader/net/Makefile
new file mode 100644
index 00000000000..ab41f358de9
--- /dev/null
+++ b/lib/efi_loader/net/Makefile
@@ -0,0 +1,3 @@
+obj-y += efi_net.o
+obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
+obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
\ No newline at end of file
diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/net/efi_http.c
similarity index 100%
rename from lib/efi_loader/efi_http.c
rename to lib/efi_loader/net/efi_http.c
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/net/efi_ipconfig.c
similarity index 100%
rename from lib/efi_loader/efi_ipconfig.c
rename to lib/efi_loader/net/efi_ipconfig.c
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/net/efi_net.c
similarity index 100%
rename from lib/efi_loader/efi_net.c
rename to lib/efi_loader/net/efi_net.c
-- 
2.48.1

