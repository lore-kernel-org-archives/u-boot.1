Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A4AE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E48F892F0;
	Fri,  1 Nov 2024 16:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WRBvJ8eM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5231688606; Fri,  1 Nov 2024 16:26:33 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B5E288E35
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f58c68c5so4044975e87.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730474790; x=1731079590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/wuUET+lDOr1W47NyYJfWs7DKXW+VnrX8vcrxG7pQs=;
 b=WRBvJ8eMJcUyUq16W59ghJYd977DmD5VsdB7VnMzNqSOFjfWLZ6AowVHlgMNBnsMlC
 nOhpCkGfsbQnq99eFIXrgw49NubM/oHiEGK+AjhyF/ynMBcH233aIYG0BJhBuAWb8IQy
 f2JVwHAShYpoQD4Ssu0SdTT4+VWRSYDmBzvPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730474790; x=1731079590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/wuUET+lDOr1W47NyYJfWs7DKXW+VnrX8vcrxG7pQs=;
 b=aqKnDHYlE3/Y8PAsJxUA2lWg/colW71YXVK65DDyRWlPS1wxIv31+TZ5ydTna2k1qf
 SQ3BPn5sp9qcjV9Eugk4+q4eOGcztQ+m85Mk0bilIR+7BiRDFh9HJYqhVpk9mDMhkME6
 r5ipX4NajFLvb+ov5E34hw6nphmyXTvSDGGuNleX0OVMnr0RTE+1JsKsGDW4jP2vgzLI
 VDsDXUrbPNtF9xosw2O4JN0w7Tp+AfaqLwrt8IRCVEXW56Awlm1hMcjhs9l+fZ0xOZq7
 1iMKeulKLTUbn6hM6nsFfQqSkU6Cm0RGEuBxNrLmNWlUdb165htFr8ITQXYfXz5Ja4TG
 IB9A==
X-Gm-Message-State: AOJu0YxEXztnDoZVWmADB3Limiyddsy3gZlleHcz+hIC6LG4l9PCO7lo
 zFELmjN2nLtZ3ACDgvKFBVjWnFDmWWOISzfF07GSeK7u9XjLsJjLb3uvEDsFzjtQ/8EvzNugKnI
 vLRSO
X-Google-Smtp-Source: AGHT+IEXr+Vi5/R97m/H2BzF526okO5Zxhi/UCuzjrUnE/AgolKBYv0m62szNyWYS3T3kcL0Htjylw==
X-Received: by 2002:a05:6512:10cc:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-53d65de3310mr3683976e87.13.1730474789700; 
 Fri, 01 Nov 2024 08:26:29 -0700 (PDT)
Received: from chromium.org ([87.215.50.114]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5649454csm190269466b.8.2024.11.01.08.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 08:26:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v9 05/11] efi_loader: Move get_efi_pxe_arch() to efi_helper
Date: Fri,  1 Nov 2024 16:26:03 +0100
Message-ID: <20241101152614.238747-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101152614.238747-1-sjg@chromium.org>
References: <20241101152614.238747-1-sjg@chromium.org>
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

