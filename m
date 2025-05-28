Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27943C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332B383A2B;
	Wed, 28 May 2025 10:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QaRkVHZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDF583A32; Wed, 28 May 2025 10:37:19 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F9DE83A2A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so32695035e9.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421436; x=1749026236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeKGR59ND8Ih5ewTSLxsrfERfONm9o/Pyl5+6kX5hiI=;
 b=QaRkVHZq86QQH1jShPV/h/wXyCd6RrOAn5nh11mvkxw+M1UMXD4Nqkur4pUochwtkW
 AiFw3QnqG7Qv9rqqLcW3wLscVazEi3w89Qbzt0IiceuvQgP+CYUnt4n/NHZkrUkxaM++
 SB4AA+i4TGcvL41kOvrOrzbe1znSxaAhqJ7hpkVkFXQLvBYQ7u21Y6ocz6/StJyI1Qlp
 xhHgFGT0Bs/VMvIND5BSNaAS9FKJieGYdqhEqkpFLPAjLZLjiptg/XlWRNY5XqPDlsna
 SIaFIiqVvcHyaHrnwf/9lSxyWhnXPBLegXRd5C/7/t0jEQIB3CgX9AkXUx8nzPLifhI4
 Q9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421436; x=1749026236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeKGR59ND8Ih5ewTSLxsrfERfONm9o/Pyl5+6kX5hiI=;
 b=eQ0jDMs6ocFrOct7zyG0vUyyIsmOrrhteHJdbZK89iiJUmFRIsXLAvXr/DOVsJ7vZI
 BE/7z6u9J1yT6vvFKDqSuW4bD8Uh0/oVOVTxODA6vQ9X0LGOaQzZK1YLkEy/000WePpk
 Qzn78Z771kioYfeZ4k75jyxfjsxe+3qIrwDkZwcuMJknSznnmhiE1kIyWKojF9rLBMn9
 HBZMyMnEWKBluoFQmiQXuoBaMaVROGcbKIQwTt0wbt4Y3LfSBvLB4eCh/G4HkAlnHEwt
 PBfdk1UcMWOyNqZ6qUpqWoqrbpe97SXdE5h4Kn64dWIxA2UzCaFvJy+fpXxgpEjrIcRL
 Jldw==
X-Gm-Message-State: AOJu0YyKkfQgWqhEsS5BGR5rLLspMajNurJAntLAvXkpDYYqKVVFUFtc
 YNv4HntxokAG0+Yd9h7sHjVu/bikBsVSGWQm8xq0NlNKI/fVrRoZGwNaAeshyMX8kho=
X-Gm-Gg: ASbGnctNyubFxX80K4rsuvl/RGaWjKB0DEddojK6LpUM4ENvYG6jH06/AWU56Z7I0dO
 mPJTUsJV9xNlYFnXQwfomsIXFBttuyt+iKkF70VyIMmAqPqaZlpBkCZBkF7oI5/3apGAi0kYPTr
 0SnXhnkpDykWRnskNSLfsCeNXHRwu42FHHwfLhMsC3x9tuMJEtxZ4tI6PBiS8c1gM/f9p3QoO7f
 igrKttmg6hAauQKBmGJo7R5Ayissqo7oUT1SZ5l4Oi2oMaXuXBx21m5DocVnkSvSvuaZlTyN6a0
 wVmQZU0A1obPrcWjEbf/L69DCTragUgz0+7LkdkUBqD9DGudZ2vU+f+Azpx/yBU5UlCY7z+EYdf
 +q+Xg0mLU/ofsPXWXEhRNNHg+k/4=
X-Google-Smtp-Source: AGHT+IF1vkyC6q1CNIwCzlG5hegHFxtXR7+aH4xvAYSFk/EP9OFOZc1pBbcJ7gGeW7b/6pdJqwXNRw==
X-Received: by 2002:a05:6000:248a:b0:3a4:dd16:a26d with SMTP id
 ffacd0b85a97d-3a4dd16a2e9mr8732305f8f.38.1748421436344; 
 Wed, 28 May 2025 01:37:16 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:15 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 1/9] lib/efi_loader: Move EFI network files into
 /lib/efi_loader/net/
Date: Wed, 28 May 2025 04:38:13 -0400
Message-ID: <20250528083821.567514-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528083821.567514-1-adriano.cordova@canonical.com>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
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
index a98298f93dc..c123056b58a 100644
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

