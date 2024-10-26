Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5476D10BE8
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 07:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B3B888DEE;
	Sat, 26 Oct 2024 09:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mrzc2pFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AE9688DF1; Sat, 26 Oct 2024 09:43:32 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F62889ED
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 09:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so3833269a12.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729928605; x=1730533405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M2mX5yHrySGNk/MyJQVqe6B8uryeYJ5+i6kQkedDtNg=;
 b=Mrzc2pFGTC0FpjwOtJyp2e2lVHwyoipMUlXALOkhbP5L69qjJhgQWzC+PqOtuNaNuc
 0xz9uMZxY/gx+yGxG3pH4YyYEyyYw+KVpmLT59nrdSNenYQdDwI/6BtNdKqi5jFtY22l
 dyNxL3DflKJpWv6THxvcr6fCI9PFWabS15RlwgkHMWNRPAeE0h7Dd1YPPC6VROXdLjwb
 ol7unouKxrHBQiuZgD0mRt5P1r0x4NQlyI6vf3FSXjiLS/ZQxc+JFVp/jTgdREdDCumd
 HP8s6kLaWhY8M9oD8buXzZeErZiCaZzE4Bhg0Oidsw8ISG5FCiWlY+EtANDO4dXmw/Y0
 iCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729928605; x=1730533405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M2mX5yHrySGNk/MyJQVqe6B8uryeYJ5+i6kQkedDtNg=;
 b=rPR98LlYnVgaMlN2MRwLem6cOqpimHzac/aPo8Wb0DNHyVBJMVMI4AZMeHY1rEBCLU
 4ojkoP5ieD5gthDQm23+voZu1MTGC18kj3FSoRgQFj2ht8n9eeTk22KWhbx7HoA4TzU0
 RSWmFTiQi405wQNZQO+JPU7ogh0GhpC6Jy4qlfrQ/CYOciS7r1dryeGHWPLxU9/uYmpj
 HhLBwrDZ+tzmp33SCgXlwxitK0F8NRGDmcvPKosIR8FWEfMkT/l6/AKYsROXwj+Z2Z3Z
 DTx67+ZsEPA+goDfMR5LBiz3h2jwqw0p4DJy/zntqclhmULojGzXSMK1z2wRrJsR9hWN
 EdsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPtAXT7ymRpQ5cVVwCSr24JnD78vLSBnDX6qlLe2zKsTs/x10KIYmIKCQM073FXipSajjmTD8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9LKerWE5gaMZu2w8UrNNadlVPIYEfr5qvwPO9UJWDyRS/0v7Y
 SKcVoNVCOXEI1zvel0ZfGKZJh/9KrXNMMjl7T5dP3MeEb7UajpX4nDqplNz/zKg=
X-Google-Smtp-Source: AGHT+IEKTaklyrN8LiMd9H2AFVbbVEjfKClFGIasKqt9AKoPQIFhTJ4EpKcdNIhoyFL3CpvjXb4qNg==
X-Received: by 2002:a17:907:9726:b0:a9a:4a1f:c97d with SMTP id
 a640c23a62f3a-a9de5c9db6cmr145697966b.7.1729928604542; 
 Sat, 26 Oct 2024 00:43:24 -0700 (PDT)
Received: from hades.. (ppp176092143132.access.hol.gr. [176.92.143.132])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb631a258sm1328128a12.78.2024.10.26.00.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 00:43:22 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Mark static function in dumpdtb
Date: Sat, 26 Oct 2024 10:43:17 +0300
Message-ID: <20241026074319.110292-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

A few functions are only used locally but miss the 'static' keyword.
Add it and quiesce W=1 build wanrings

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/dtbdump.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/dtbdump.c b/lib/efi_loader/dtbdump.c
index 9f1d8fb82cb0..a3d59a2fd3be 100644
--- a/lib/efi_loader/dtbdump.c
+++ b/lib/efi_loader/dtbdump.c
@@ -225,7 +225,7 @@ static u32 f2h(fdt32_t val)
  * @systable:	system table
  * Return:	device tree or NULL
  */
-void *get_dtb(struct efi_system_table *systable)
+static void *get_dtb(struct efi_system_table *systable)
 {
 	void *dtb = NULL;
 	efi_uintn_t i;
@@ -246,7 +246,7 @@ void *get_dtb(struct efi_system_table *systable)
  * @pos:	UTF-16 string
  * Return:	pointer to first non-whitespace
  */
-u16 *skip_whitespace(u16 *pos)
+static u16 *skip_whitespace(u16 *pos)
 {
 	for (; *pos && *pos <= 0x20; ++pos)
 		;
@@ -260,7 +260,7 @@ u16 *skip_whitespace(u16 *pos)
  * @keyword:	keyword to be searched
  * Return:	true fi @string starts with the keyword
  */
-bool starts_with(u16 *string, u16 *keyword)
+static bool starts_with(u16 *string, u16 *keyword)
 {
 	for (; *keyword; ++string, ++keyword) {
 		if (*string != *keyword)
@@ -272,7 +272,7 @@ bool starts_with(u16 *string, u16 *keyword)
 /**
  * do_help() - print help
  */
-void do_help(void)
+static void do_help(void)
 {
 	error(u"dump       - print device-tree\r\n");
 	error(u"load <dtb> - load device-tree from file\r\n");
@@ -332,7 +332,7 @@ open_file_system(struct efi_simple_file_system_protocol **file_system)
  * @filename:	file name
  * Return:	status code
  */
-efi_status_t do_load(u16 *filename)
+static efi_status_t do_load(u16 *filename)
 {
 	struct efi_dt_fixup_protocol *dt_fixup_prot;
 	struct efi_simple_file_system_protocol *file_system;
@@ -469,7 +469,7 @@ out:
  * @filename:	file name
  * Return:	status code
  */
-efi_status_t do_save(u16 *filename)
+static efi_status_t do_save(u16 *filename)
 {
 	struct efi_simple_file_system_protocol *file_system;
 	efi_uintn_t dtb_size;
-- 
2.43.0

