Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BF2D3A696
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A97B891AA;
	Tue, 29 Oct 2024 20:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lc1N22Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8948891A8; Tue, 29 Oct 2024 20:22:40 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E39891B6
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2fb5638dd57so54021381fa.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730229757; x=1730834557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofGwYljnh2oh1BIgJMhD1YAKquGpAWcsW2USCwLdKmw=;
 b=Lc1N22EiUFuBae/niGFjNlZQxhx2YR9LU9bswGBUAqthD4Unsfmbu4EZMU1weEhax0
 /g79TUYYs/R58Vxpq95MO9Y4dakJ3XVs4vWp1ifHE1jEMx4T+pFVUtzdwVUkEtGUNnQd
 +9PyQrBZDXo9XT4Vd7lk2tFzxl+jN0FWmaj9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730229757; x=1730834557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofGwYljnh2oh1BIgJMhD1YAKquGpAWcsW2USCwLdKmw=;
 b=QsaDCMatjei74Vv6VJCtQP5GoqIkv3O22kTMpwYlu8XtQOejEasY7vt66z8QKm5C4n
 UpkScBDM2UDB601ULY7XJnooJmMm3OcZs8U2UM1CkEVvmtDLlizK9z5BMSpj2CVqNdRQ
 K75u1ZCS816YooDd3ifvzMP1PMLsstyIX03H2s3pbxYhw8HB8njqHCtFngu7fEiCYprU
 BdXPuW4VXrNTei4fXrXtmMGi16mD7u1qT9D0XN0v8d8ltcBkxAzD1+Cf31g4x6FMHfS8
 kTsfGAhOy60S1WmzpT6OQSNWYw7CQTTeCKSKbkucZRs/STzvEV+ipDkniLvK6T+KqWio
 5r4w==
X-Gm-Message-State: AOJu0YwwxBuegPVH6xmKbKZEarNNvPG+D/iuN3CPi0f8o2YHhTxCpqk/
 ApJJekEh9BqqfdwRL3pxiePiKJ42l97qjRCyj/U5SnYM3VVPCOptKpzoUdEIQdhtnz4PKKkmMGr
 tp25h
X-Google-Smtp-Source: AGHT+IHZP39/O86qQ7M3X4FkoFZUqo13U8/8+XNKJkHf9bQILkpmyZVrNnuGbyR/vuBs4lbno+WbHA==
X-Received: by 2002:a2e:812:0:b0:2fc:ba7a:c982 with SMTP id
 38308e7fff4ca-2fcbe07bbd9mr52661751fa.36.1730229756516; 
 Tue, 29 Oct 2024 12:22:36 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629f65esm4272770a12.36.2024.10.29.12.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 12:22:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v9 05/11] efi_loader: Move get_efi_pxe_arch() to efi_helper
Date: Tue, 29 Oct 2024 20:22:13 +0100
Message-ID: <20241029192222.362445-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029192222.362445-1-sjg@chromium.org>
References: <20241029192222.362445-1-sjg@chromium.org>
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
index fef88e9c5d6..633f5b4acb5 100644
--- a/include/efi.h
+++ b/include/efi.h
@@ -679,4 +679,14 @@ void efi_show_tables(struct efi_system_table *systab);
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
2.43.0

