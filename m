Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E9EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BF6870B7;
	Thu, 14 Sep 2023 18:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G5Ty2/Ee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0B0870A5; Thu, 14 Sep 2023 18:56:42 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2967E86F58
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-792975085b2so39415139f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710599; x=1695315399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a/KGVHj0Y2R1ZEWWCyfWHFeU7fyrsi/Xkjt8npmgSJk=;
 b=G5Ty2/Ee1nq3dMLH9VQQFqLnK66/hVKPZ7F7Gaquw/MWHkPTts8rFvNxQ1Op9v4tqX
 e7hR0GiYOrnlVF5vpCkaBpUfFlB65J9fctNRnAloYzQezgGC1gn52l4NqTfbi36meMtG
 rbjchlQ3PeVYRCLKHOMShuSy/YHTP2S4UoHQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710599; x=1695315399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a/KGVHj0Y2R1ZEWWCyfWHFeU7fyrsi/Xkjt8npmgSJk=;
 b=xN7dKqWIFeg6TbnbU9YBhzTQvd8U4kYdiVlRna1etmCgMWT09Z4FBKWPlHMgVd8WrC
 XTUxys6OnM6Y6Hqx+Ybztkn62smUJ3InAsPjIK6RmL+VjXBvpQ4b62ZA7Oobir20jACQ
 Mps4x6a/NfSSvHCLN0psHYylie0TeNVEMHQ9Qk3fvE5GLssva2HnlJrejmMYEGY/PHpd
 7VjVkKPUU/L41klwL/c02pOBo2PixeCwhkE18HizaraOgOqO2fmh/Ym5YUWsqeH83O43
 8LZo+djiNK9h/AwZpZpKX4AZAoJqLYpM5FOGElI+XN9BDg9lpLGrUqOx20MqRj9THFYI
 RG7g==
X-Gm-Message-State: AOJu0YxvJ1FiUrkajk4+VO5oeiwYwYFM4E9tafhi/nRUYRQ1IDAqZqMp
 sK2lltuRyJVjeEfih1yZMtVezAzh0DJMO9mgfqk=
X-Google-Smtp-Source: AGHT+IGA3Q24vgFX2lQYVOo4XuyDDfgZ6rh5luPcLxmxpx4GhWmEvi1sdyf0typyZBDReABmwRV/mQ==
X-Received: by 2002:a5e:9812:0:b0:790:aedd:3e81 with SMTP id
 s18-20020a5e9812000000b00790aedd3e81mr7666037ioj.8.1694710598766; 
 Thu, 14 Sep 2023 09:56:38 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v5 08/21] Move fdt_simplefb to boot/
Date: Thu, 14 Sep 2023 10:55:46 -0600
Message-ID: <20230914165615.1058529-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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
index 0a98f1e2220..39c51e9e2fe 100644
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
index f15a161614f..6ce983b83fa 100644
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
index d11292f52c2..21eaa5e815f 100644
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
index 0948721d0b4..5c1617206f0 100644
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
2.42.0.459.ge4e396fd5e-goog

