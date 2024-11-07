Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190EFD5D68A
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 21:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7F0888B1F;
	Thu,  7 Nov 2024 22:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P9yj/SGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8709288FE5; Thu,  7 Nov 2024 22:32:15 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143EF88B0A
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 22:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a6bba54722so5631635ab.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 13:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731015131; x=1731619931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oe6qhq9Cwo7Oo36VUqafHOpB86g+vUkQmZeNcaI1/24=;
 b=P9yj/SGegSHoC6Z1W7UD1QR8e1UnVnMQhXs+VSkojk7KaT27pRo7akb8MRRvXc1ENI
 Z2faMDYwQzQsUDJuB4GlwnB+SyMCIxGePGGxbH1kRESuZZSbepTV7lzUrxw+SfLJRzf2
 LABWV+y7eHX//UNOHD/cqE+KRjnDZPHvz068U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731015131; x=1731619931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oe6qhq9Cwo7Oo36VUqafHOpB86g+vUkQmZeNcaI1/24=;
 b=nYC9M5ep5kacAvynKrQU9JHl5BGhoLrLE4YpaeTtHorzp2he/79acngawOOPQew32h
 5q3jYEYmLKedpPpg49Psa75G9a0lySElF+4WmvYVKYUN0OTQMiL1eGYZZw9GI6404PE0
 2aXaCnk9tmSkdSyRU2HIdmzICTu9Oamc6m/6nR59tOpoilabMpGnKIY1KuksHf4fxtYD
 zIoBZEJbKBZDxeGwJThJEpejMsRH2boJpcgVY0rZej7U1FB/aONkKBEx/RbabhWkOpRD
 CpwWRPRSg97oxXkjniExlIEBqU+G5tdei3KhnGq1vaJxtmteGafEvSSPNhECenz6I5y5
 BhQA==
X-Gm-Message-State: AOJu0YwLPIJF1zukXH4SMmySckkjR6dLmH589RGyGCuUOA/1FxQ9M9u/
 E60iGLvZdkRmSSNRzEHAut6+/QTmkIIeAHX9jctGCjdP0Eaf4bCuV3rjxXQMWUzaPeb6Gm9G5XE
 =
X-Google-Smtp-Source: AGHT+IEXnl+64Wt2UB/K+5eyn/bvrk5zuWUW+SAwvBp1+YmdPu4b6jl6jr3E4kpWmOgO4+po1vbzYA==
X-Received: by 2002:a05:6e02:214f:b0:3a6:aade:e328 with SMTP id
 e9e14a558f8ab-3a6f19a03d1mr9418355ab.4.1731015131258; 
 Thu, 07 Nov 2024 13:32:11 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6ead30a79sm4831745ab.71.2024.11.07.13.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 13:32:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v10 04/10] efi_loader: Move get_efi_pxe_arch() to efi_helper
Date: Thu,  7 Nov 2024 14:31:44 -0700
Message-Id: <20241107213150.1711962-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107213150.1711962-1-sjg@chromium.org>
References: <20241107213150.1711962-1-sjg@chromium.org>
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

Move this function from the EFI bootmeth to the common efi_helper file.
No functional change is intended.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v9)

Changes in v9:
- Split out into a separate change

 boot/bootmeth_efi.c         | 25 ++-----------------------
 include/efi.h               | 10 ++++++++++
 lib/efi_loader/efi_helper.c | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 371b36d550b..f836aa655f5 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -25,32 +25,11 @@
 
 #define EFI_DIRNAME	"/EFI/BOOT/"
 
-static int get_efi_pxe_arch(void)
-{
-	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
-	if (IS_ENABLED(CONFIG_ARM64))
-		return 0xb;
-	else if (IS_ENABLED(CONFIG_ARM))
-		return 0xa;
-	else if (IS_ENABLED(CONFIG_X86_64))
-		return 0x6;
-	else if (IS_ENABLED(CONFIG_X86))
-		return 0x7;
-	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
-		return 0x19;
-	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
-		return 0x1b;
-	else if (IS_ENABLED(CONFIG_SANDBOX))
-		return 0;	/* not used */
-
-	return -EINVAL;
-}
-
 static int get_efi_pxe_vci(char *str, int max_len)
 {
 	int ret;
 
-	ret = get_efi_pxe_arch();
+	ret = efi_get_pxe_arch();
 	if (ret < 0)
 		return ret;
 
@@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	ret = get_efi_pxe_vci(str, sizeof(str));
 	if (ret)
 		return log_msg_ret("vci", ret);
-	ret = get_efi_pxe_arch();
+	ret = efi_get_pxe_arch();
 	if (ret < 0)
 		return log_msg_ret("arc", ret);
 	arch = ret;
diff --git a/include/efi.h b/include/efi.h
index ecdf7210750..789a64eda9d 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -678,4 +678,14 @@ void efi_show_tables(struct efi_system_table *systab);
  */
 const char *efi_get_basename(void);
 
+/**
+ * efi_get_pxe_arch() - Get the architecture value for PXE
+ *
+ * See:
+ * http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml
+ *
+ * Return: Architecture value
+ */
+int efi_get_pxe_arch(void);
+
 #endif /* _LINUX_EFI_H */
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 51e0c4852c5..b8ece1c2e0c 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -21,6 +21,8 @@
 #include <linux/libfdt.h>
 #include <linux/list.h>
 
+#undef BOOTEFI_NAME
+
 #ifdef CONFIG_SANDBOX
 
 #if HOST_ARCH == HOST_ARCH_X86_64
@@ -69,6 +71,27 @@ const char *efi_get_basename(void)
 	return BOOTEFI_NAME;
 }
 
+int efi_get_pxe_arch(void)
+{
+	/* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
+	if (IS_ENABLED(CONFIG_ARM64))
+		return 0xb;
+	else if (IS_ENABLED(CONFIG_ARM))
+		return 0xa;
+	else if (IS_ENABLED(CONFIG_X86_64))
+		return 0x6;
+	else if (IS_ENABLED(CONFIG_X86))
+		return 0x7;
+	else if (IS_ENABLED(CONFIG_ARCH_RV32I))
+		return 0x19;
+	else if (IS_ENABLED(CONFIG_ARCH_RV64I))
+		return 0x1b;
+	else if (IS_ENABLED(CONFIG_SANDBOX))
+		return 0;	/* not used */
+
+	return -EINVAL;
+}
+
 /**
  * efi_create_current_boot_var() - Return Boot#### name were #### is replaced by
  *			           the value of BootCurrent
-- 
2.34.1

