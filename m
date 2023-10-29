Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA4C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE75087C65;
	Sun, 29 Oct 2023 04:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9TaQsSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FC787C62; Sun, 29 Oct 2023 04:48:59 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D3C87740
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:48:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-67089696545so6659386d6.0
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551334; x=1699156134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bizwAxqdPQ34tNYM7CTYkZjUplLROLeJBPC3Odkc+no=;
 b=C9TaQsSJs5mcpQUnZGgW6lVN/gA4LrfOLTnqgumpfm53kk86y4+9k0pBLukYRe6ycU
 lI6leLcO86rLlYTGhZQA5tzrde6CKyYtG0iFsEN7CwhVAExHXxPvbOUitTdr4x50Syy+
 U7PaNtfkjXiI8Fg8KqJBxBgFP5eBNPJwhgWDvHFVOz8NXvwDYVhuJ1hwhridk18918b2
 sA3g3J5H9a8sgufu6JH0ZCB3AaiEUYEqxJikEGJi5pqRmqz/i2fUc7wWZYFOn2IlKOrO
 5FTGQkYnvKOZA/Mfmo3U0hsIpfOdUbGJA0PqF9PpjH/wVjy/io7Zo/t43UtWofKBAi4/
 zz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551334; x=1699156134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bizwAxqdPQ34tNYM7CTYkZjUplLROLeJBPC3Odkc+no=;
 b=PnlNkMjmy+YQm/tx7f8M31TmSf+EljotZRW+EGq/bezEycQGCZZP0686GEY3NpVBtc
 A0fo1ZcgSdLbTMBsfLF3F/k/1MEH1BmULO9UvNVe7SELHU+wYLzOvv0tknE5wGOHXav2
 8DtZH0tKAaWV2FvbDj/NH/dMcRauaM87Ey2UA+vmGDhFFUxUSSvmHXdIEL1/OfagAPqL
 Xl4F6jZs3P7CHl0JQeL//qWO6mOb+bSfpzd8m1fiLkillO3OqdX2kWcqO0kUEcb9Gnej
 cQYJdRb+JcW8HiR8w03AVJUKDWn7D+F81roDJk2xMxpKiQAiEPJV2dOKpy+21AUmmDCa
 uUXA==
X-Gm-Message-State: AOJu0YxXbW/TsXlOTOnYC4f2VcY/gDACUn6qZ9ExaDD95ioTvqrzIl11
 FYLUkcYYshrHhLRTUqtMxr4R2mk8daSPkA==
X-Google-Smtp-Source: AGHT+IGJd9g+7WRYg7Y4zIB4lkl0vInsP6ONL24aUsk3I4S9sSmClL9p8513yrIrFxG/Eb1SslKl7w==
X-Received: by 2002:a05:6214:1bc8:b0:66d:3300:a51b with SMTP id
 m8-20020a0562141bc800b0066d3300a51bmr10158011qvc.41.1698551333904; 
 Sat, 28 Oct 2023 20:48:53 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 t10-20020a0cea2a000000b00646e0411e8csm2160832qvp.30.2023.10.28.20.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:48:53 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 04/15] nand: spl_loaders: Only read enough pages to load the
 image
Date: Sat, 28 Oct 2023 23:48:34 -0400
Message-Id: <20231029034845.1169614-5-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

All other implementations of nand_spl_load_image only read as many pages as
are necessary to load the image. However, nand_spl_loaders.c loads the full
block. Align it with other load functions so that it is easier to
determine how large of a load buffer we need.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/mtd/nand/raw/nand_spl_loaders.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_spl_loaders.c b/drivers/mtd/nand/raw/nand_spl_loaders.c
index 8848cb27db9..f071b5b57f5 100644
--- a/drivers/mtd/nand/raw/nand_spl_loaders.c
+++ b/drivers/mtd/nand/raw/nand_spl_loaders.c
@@ -12,8 +12,11 @@ int nand_spl_load_image(uint32_t offs, unsigned int size, void *dst)
 	while (block <= lastblock) {
 		if (!nand_is_bad_block(block)) {
 			/* Skip bad blocks */
-			while (page < SYS_NAND_PAGE_COUNT) {
+			while (size && page < SYS_NAND_PAGE_COUNT) {
 				nand_read_page(block, page, dst);
+
+				size -= min(size, CONFIG_SYS_NAND_PAGE_SIZE -
+						  page_offset);
 				/*
 				 * When offs is not aligned to page address the
 				 * extra offset is copied to dst as well. Copy
-- 
2.37.1

