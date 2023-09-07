Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D29EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E889E86B03;
	Thu,  7 Sep 2023 17:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JbxyYSfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6194586AD8; Thu,  7 Sep 2023 17:59:53 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8A186AD8
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so4524645ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102386; x=1694707186; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIHnpZ73D2kUJFvzoyE13502MNR2KzZXsJbaDPDEJVM=;
 b=JbxyYSfWynREziE1J/XH+VERvaMNn1tcxJAYLU57Dya1E8Z5sISfzuRwUhHQnGTmEi
 sIqXgvWVbbb3jQ5iyjQD12T4gTZNL/ZqDmUzaixwz06MEnj5smJTTre6681dt2VAtOp7
 2cOtLaxVNHbIeMH2X2hftwHga5vHOdIGQtyT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102386; x=1694707186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIHnpZ73D2kUJFvzoyE13502MNR2KzZXsJbaDPDEJVM=;
 b=k5NYvqagH0msYQHcRLXrzMkjATC+QGP9rm2bhhP/Q8cLsZAVWnbpYce5nKEwZ7xza0
 44aZPhpu68GiRnOPHQrKOV90E3Uv+ZGZSB9Jx+B8RP7t/qK/Kl/y4ky7zlTIdSN79+PI
 ObZtrn6Tc6LkUR0pknSq9uLeCoWuAS4e9+JaWM5NSVLETOGPw+JhlwXf/e99TCjBnxtc
 XkOiKYckWRvu8RlDGgsRY9VYTzgRJzOEjDNFWUOzQcujo9jHh0EA+k24PTvLlOKpvZtX
 KX7A/yKJgj/z9rDkdcx5AKh80nCE8sx580Vk64s8asDNiv1w6i4DlIx1gU0ZY/bS80gQ
 UnZg==
X-Gm-Message-State: AOJu0YxiY6gBo3jHAlFOyoMUDutGmGfTXt8wVlNCjAHROVQY7eHIOuDZ
 1Ilbl+SHSN/cmO/q3qmHtsnbRn3xQsXHv6ekuNc=
X-Google-Smtp-Source: AGHT+IFEgFC+6j4SVA3g6DzEbSU2FzFJI0PjLuuMJq4NQcVGV3y87T8Lz9EzEH72azLbQzmoZutgqQ==
X-Received: by 2002:a05:6e02:144d:b0:34c:a30a:15f7 with SMTP id
 p13-20020a056e02144d00b0034ca30a15f7mr86320ilo.32.1694102386748; 
 Thu, 07 Sep 2023 08:59:46 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 09/22] Move fdt_simplefb to boot/
Date: Thu,  7 Sep 2023 09:59:14 -0600
Message-ID: <20230907155933.48511-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

This relates to booting, so move it there. Create a new Kconfig menu for
things related to devicetree fixup.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig                    | 16 ++++++++++++++++
 boot/Makefile                   |  1 +
 {common => boot}/fdt_simplefb.c |  0
 common/Kconfig                  |  9 ---------
 common/Makefile                 |  1 -
 5 files changed, 17 insertions(+), 10 deletions(-)
 rename {common => boot}/fdt_simplefb.c (100%)

diff --git a/boot/Kconfig b/boot/Kconfig
index 0a98f1e22207..39c51e9e2fe8 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1538,6 +1538,22 @@ config SPL_IMAGE_PRE_LOAD_SIG
 
 endmenu
 
+if OF_LIBFDT
+
+menu "Devicetree fixup"
+
+config FDT_SIMPLEFB
+	bool "FDT tools for simplefb support"
+	help
+	  Enable the fdt tools to manage the simple fb nodes in device tree.
+	  These functions can be used by board to indicate to the OS
+	  the presence of the simple frame buffer with associated reserved
+	  memory
+
+endmenu
+
+endif # OF_LIBFDT
+
 config USE_BOOTARGS
 	bool "Enable boot arguments"
 	help
diff --git a/boot/Makefile b/boot/Makefile
index f15a161614ff..6ce983b83fa4 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
+obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) += fdt_simplefb.o
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
diff --git a/common/fdt_simplefb.c b/boot/fdt_simplefb.c
similarity index 100%
rename from common/fdt_simplefb.c
rename to boot/fdt_simplefb.c
diff --git a/common/Kconfig b/common/Kconfig
index d11292f52c2b..21eaa5e815f9 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1157,14 +1157,5 @@ config VPL_IMAGE_SIGN_INFO
 
 endif
 
-config FDT_SIMPLEFB
-	bool "FDT tools for simplefb support"
-	depends on OF_LIBFDT
-	help
-	  Enable the fdt tools to manage the simple fb nodes in device tree.
-	  These functions can be used by board to indicate to the OS
-	  the presence of the simple frame buffer with associated reserved
-	  memory
-
 config IO_TRACE
 	bool
diff --git a/common/Makefile b/common/Makefile
index 0948721d0b47..5c1617206f07 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -17,7 +17,6 @@ obj-y += board_r.o
 obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
-obj-$(CONFIG_FDT_SIMPLEFB) += fdt_simplefb.o
 obj-$(CONFIG_MII) += miiphyutil.o
 obj-$(CONFIG_CMD_MII) += miiphyutil.o
 obj-$(CONFIG_PHYLIB) += miiphyutil.o
-- 
2.42.0.283.g2d96d420d3-goog

