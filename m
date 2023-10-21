Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4560C001DF
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 00:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68AB086F83;
	Sat, 21 Oct 2023 02:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NaD+FS47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B00586FB0; Sat, 21 Oct 2023 02:45:33 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3984D86F34
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 02:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1ea4a3d0a44so981931fac.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697849127; x=1698453927; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AksLpLrnP5JgbkcjzCN5U9rjsX/duyv0xWfAE1ZDM6I=;
 b=NaD+FS47CU8NZqHnJo2ZwYBcv4KnXXij3H/XoLilrIubBdMVIeQtkfl/PEu7u+OzWh
 KysCniwnlYLx96hYlHXLKKfLUG1hozapXqyB4UaRO/AUK7wcK2XbIkp0jYooRFzncMa4
 fAXQNQfZfryJ+rL3RpACmxvtBLwkS5HPY5DXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697849127; x=1698453927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AksLpLrnP5JgbkcjzCN5U9rjsX/duyv0xWfAE1ZDM6I=;
 b=Dq0JYR1xBNMSvtge9qefvAY5TWYhBFgqyp/s8j7uokoMEHfJgN5EJAPwv8gnmRcmZm
 bqA4NoaoAyNPgP6SIYW7Cc50vT1LX4YQjhx7T628ha58Z6z/4+ByeC/il4tor5iB7a1a
 M28BEGI50epZ4MMm3u9Qkg6BfxIty65yXafd2tlFwxCJS2y1hhT4I+rGeS74hakHM8UT
 wOh/Z9F8jNBIEA2LmUvVKklPEJtdMTyyHyJQ99JjOsAB9C5OxVp8kA9D4s6KfCHpUj2w
 LCTc77bELg+H1UVaxLZ6y7HqC+w/qzbB33ZJ+tNq6AeWz427njG3xUi1BttpQigJWmCD
 n9Dw==
X-Gm-Message-State: AOJu0YySwPA+Mray8jAb6a4jKAmlYeRBNy+tqP/10jmn7jxjYt/P5WVz
 nz5pQ6AznYWy+lP25VMZNfBKUdoeUCAMiKmt6vZ7Qg==
X-Google-Smtp-Source: AGHT+IElddaJJpBZQf0Ty1xwEFW6dwJ2DchOrGBEfmf8n82M/8nOHx2933thvsvs+z4toVT6/JdKNw==
X-Received: by 2002:a05:6870:1050:b0:1ba:ddf2:417f with SMTP id
 16-20020a056870105000b001baddf2417fmr3069728oaj.2.1697849127675; 
 Fri, 20 Oct 2023 17:45:27 -0700 (PDT)
Received: from sjg1.roam.corp.google.com
 ([2607:fb90:92e0:4f65:b3be:8f40:3e80:95e4])
 by smtp.gmail.com with ESMTPSA id
 nd25-20020a056871441900b001dcfaba6d22sm607527oab.46.2023.10.20.17.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 17:45:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Date: Fri, 20 Oct 2023 17:45:21 -0700
Message-ID: <20231021004522.53311-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

U-Boot typically sets up its malloc() pool near the top of memory. On
ARM64 systems this can result in an SMBIOS table above 4GB which is
not supported by SMBIOSv2.

Work around this problem by providing a new option to choose an address
just below 4GB, if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/Kconfig                 | 17 +++++++++++++++++
 lib/efi_loader/efi_smbios.c | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index f6ca559897e7..a77f2f3e9089 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -994,6 +994,23 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+config SMBIOS_TABLE_FIXED
+	bool "Place the SMBIOS table at a special address"
+	depends on GENERATE_SMBIOS_TABLE && ARM64 && SMBIOS && EFI_LOADER
+	default y
+	help
+	  Use this option to place the SMBIOS table at a fixed address.
+
+	  U-Boot typically sets up its malloc() pool near the top of memory. On
+	  ARM64 systems this can result in an SMBIOS table above 4GB which is
+	  not supported by SMBIOSv2. This option works around this problem by
+	  chosing an address just below 4GB, if needed.
+
+config SMBIOS_TABLE_FIXED_ADDR
+	hex "Fixed address for use for SMBIOS table"
+	depends on SMBIOS_TABLE_FIXED
+	default 0xffff0000
+
 endmenu
 
 config LIB_RATIONAL
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 48446f654d9b..84ea027ea48c 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -61,6 +61,18 @@ static int install_smbios_table(void)
 		return log_msg_ret("mem", -ENOMEM);
 
 	addr = map_to_sysmem(buf);
+
+	/*
+	 * Deal with a fixed address if needed. For simplicity we assume that
+	 * the SMBIOS-table size is <64KB and that the malloc region does not
+	 * straddle the 4GB boundary.
+	 */
+	if (IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED) && addr >= SZ_4G - SZ_64K) {
+		addr = IF_ENABLED_INT(CONFIG_SMBIOS_TABLE_FIXED,
+				      CONFIG_SMBIOS_TABLE_FIXED_ADDR);
+		log_warning("Forcing SMBIOS table to address %lx\n", addr);
+	}
+
 	if (!write_smbios_table(addr)) {
 		log_err("Failed to write SMBIOS table\n");
 		return log_msg_ret("smbios", -EINVAL);
-- 
2.42.0.655.g421f12c284-goog

