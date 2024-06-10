Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2F2C27C5F
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A312888528;
	Mon, 10 Jun 2024 11:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GQj2VDFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B2C88444; Mon, 10 Jun 2024 11:11:30 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7249A8812B
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7216B3F963
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010684;
 bh=RJ0O/JUGudMKMtGbFrWshGsDcDIN4LUupEZj2xeDkB0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=GQj2VDFqQ+lo8UtY01hsbB2mrhSI8BJC1oAIDWR+/zg7Q8K9+3re3m3dMx/EC0pEY
 4xWrXS1NVfuV91DOgk9Hw85KZ61Mwzf5quxNKK5zAwXHhiTULPFmxLgXAsAUshJkDf
 3pcpvj3M1Tdxr+FHeQm9HqlgP9aZBpDdNgOwawiDHwaAiqL39Yj7LiHe6Cx6BPqwtZ
 iFzi5AhSU1ZWqrxw8IcWKfHsq8ip7C9IbWgaZUkSQ8ixGn6h0Ze2digx1T/Q7teeUG
 e5jF8AuQ6q+2n9OdWPuvopSdrDVx/8Cx6X0DUFmxHfHT7U2dYS96OZKg4AB/Kz7tvv
 8RiGLuKJrsfpg==
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ebd7ad3476so10843051fa.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010675; x=1718615475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJ0O/JUGudMKMtGbFrWshGsDcDIN4LUupEZj2xeDkB0=;
 b=X2nLywNNt5vbMsoeG/ufmXWMyOsX2bXHnYysXdGc8hVnzUV+cl5pIISzvWYZr+ZhiZ
 DhLX7g/WLoeEbGdvWTSnqrB6iR3e0PKj44qxbSkXt5C0c66jmQeBgeFAvBCnsE9/7CPp
 e4PoMYiG+yP4qhtkcjnidhwRq1PwaLyS/D6i7ft/94tJuj9txWn31rdyB4QiyqFvOjGy
 RE/WDkMP+TUs4tuQBBNPgc1AlsorWnl5A26N9r/P5RcHX+mLcCVSyuFlYjHLU6Eq6knF
 r/5sGAcfwBHyfRX+SujrKWBcmkqItY/kwkB3U48ykLB5wqUkQBcb2TGGJ/eap0jca67t
 +Pjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQmlljOcNNU9ptMT+5Qc+1QCkUq0aCAHjddsL4sTmFlG/hyQHNZ+TzmoHboPGEH/CDGVgSaJcb9DhctQX2WbpusAQi9A==
X-Gm-Message-State: AOJu0YzhdBdVL0yO8gJSKcjt2BL/rQYPecRP1SOBL+vA+DFI695AXJmp
 uSN2QE8BUkWMMaiEF3btdlyXnj4CQGnBI+dtA9C9sJ1iFXC1+4pJV2O0XKNQ9LSv8qQLfBnQ9Kz
 AFX8PFsf27weBEffC4yLXxGIvrZLp0rW4+xBSRSjfyun2Jeg6u+Cdx6EA/Rt1eKJjciQ=
X-Received: by 2002:a05:651c:507:b0:2eb:df6d:6c36 with SMTP id
 38308e7fff4ca-2ebdf6d6df8mr24637911fa.4.1718010675470; 
 Mon, 10 Jun 2024 02:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoiiEQPek0es3I9PzhAJED3VyVgtrK9n9QV+Q60FkT8Af4P/97UM24ESfd0rizyGi0r1LR+w==
X-Received: by 2002:a05:651c:507:b0:2eb:df6d:6c36 with SMTP id
 38308e7fff4ca-2ebdf6d6df8mr24637721fa.4.1718010675196; 
 Mon, 10 Jun 2024 02:11:15 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:14 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 9/9] efi_loader: rename struct efi_initrd_dp to
 efi_lo_dp_prefix
Date: Mon, 10 Jun 2024 11:10:57 +0200
Message-ID: <20240610091057.64463-10-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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

As we now also store device-tree device-paths in load options rename
struct efi_initrd_dp to efi_lo_dp_prefix.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	new patch
---
 cmd/eficonfig.c                  |  4 ++--
 cmd/efidebug.c                   |  4 ++--
 include/efi_load_initrd.h        | 12 +++++++++++-
 lib/efi_loader/efi_load_initrd.c |  2 +-
 lib/efi_loader/initrddump.c      |  2 +-
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index a12df1e7d59..530eb931564 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -1402,7 +1402,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	struct efi_device_path *initrd_device_dp = NULL;
 	struct efi_device_path *fdt_device_dp = NULL;
 
-	const struct efi_initrd_dp initrd_prefix = {
+	const struct efi_lo_dp_prefix initrd_prefix = {
 		.vendor = {
 			{
 			DEVICE_PATH_TYPE_MEDIA_DEVICE,
@@ -1418,7 +1418,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		}
 	};
 
-	const struct efi_initrd_dp fdt_prefix = {
+	const struct efi_lo_dp_prefix fdt_prefix = {
 		.vendor = {
 			{
 			DEVICE_PATH_TYPE_MEDIA_DEVICE,
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a25ebd2061d..846d6b67a48 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -685,7 +685,7 @@ struct efi_device_path *create_lo_dp_part(const char *dev, const char *part,
 	struct efi_device_path *dp = NULL;
 	const struct efi_device_path *dp_prefix;
 	efi_status_t ret;
-	const struct efi_initrd_dp fdt_dp = {
+	const struct efi_lo_dp_prefix fdt_dp = {
 		.vendor = {
 			{
 			DEVICE_PATH_TYPE_MEDIA_DEVICE,
@@ -700,7 +700,7 @@ struct efi_device_path *create_lo_dp_part(const char *dev, const char *part,
 			sizeof(fdt_dp.end),
 		}
 	};
-	const struct efi_initrd_dp initrd_dp = {
+	const struct efi_lo_dp_prefix initrd_dp = {
 		.vendor = {
 			{
 			DEVICE_PATH_TYPE_MEDIA_DEVICE,
diff --git a/include/efi_load_initrd.h b/include/efi_load_initrd.h
index be5d5a7acbe..9feafb18c86 100644
--- a/include/efi_load_initrd.h
+++ b/include/efi_load_initrd.h
@@ -18,7 +18,17 @@
 		 0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 extern const efi_guid_t efi_lf2_initrd_guid;
 
-struct efi_initrd_dp {
+/**
+ * struct efi_lo_dp_prefix - separator device path used in load options
+ *
+ * We use vendor media device nodes in UEFI load options to separate
+ * the binary, initrd, and fdt device-paths. This structure contains
+ * the vendor media device node and an end node.
+ *
+ * @vendor:	vendor media device node
+ * @end:	end node
+ */
+struct efi_lo_dp_prefix {
 	struct efi_device_path_vendor vendor;
 	struct efi_device_path end;
 } __packed;
diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
index d91135436c4..2f0ee1ab4a1 100644
--- a/lib/efi_loader/efi_load_initrd.c
+++ b/lib/efi_loader/efi_load_initrd.c
@@ -24,7 +24,7 @@ static const struct efi_load_file_protocol efi_lf2_protocol = {
  * Device path defined by Linux to identify the handle providing the
  * EFI_LOAD_FILE2_PROTOCOL used for loading the initial ramdisk.
  */
-static const struct efi_initrd_dp dp_lf2_handle = {
+static const struct efi_lo_dp_prefix dp_lf2_handle = {
 	.vendor = {
 		{
 		   DEVICE_PATH_TYPE_MEDIA_DEVICE,
diff --git a/lib/efi_loader/initrddump.c b/lib/efi_loader/initrddump.c
index 0004b6b042b..7f4ea6675a8 100644
--- a/lib/efi_loader/initrddump.c
+++ b/lib/efi_loader/initrddump.c
@@ -33,7 +33,7 @@ static bool nocolor;
  * Device path defined by Linux to identify the handle providing the
  * EFI_LOAD_FILE2_PROTOCOL used for loading the initial ramdisk.
  */
-static const struct efi_initrd_dp initrd_dp = {
+static const struct efi_lo_dp_prefix initrd_dp = {
 	.vendor = {
 		{
 		   DEVICE_PATH_TYPE_MEDIA_DEVICE,
-- 
2.43.0

