Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA12ACDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFCB788EEC;
	Fri, 27 Sep 2024 00:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TjWF8vY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B1D88EA3; Fri, 27 Sep 2024 00:01:34 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2C288E5F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb2f271043so11797316d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388090; x=1727992890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1zqTnyJ3uOzf0CZdE4lR7ii1MRbTGs8FlqFb9QGCFM=;
 b=TjWF8vY+Vp56jjNcz2IG63iAkMFKmpm+xhDgEv+xyiDFEKooBhzLMSBIhSKJdpaHye
 EmdqcitrvB92hY4fQnPlvRN3/+wO9pKqQX8VuhhsCMlS8D59z9ScLCTHsyNls0uJV3zt
 GPlesUlSzaz1R60yY7rg1U/fJ6RYJFelWQlog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388090; x=1727992890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1zqTnyJ3uOzf0CZdE4lR7ii1MRbTGs8FlqFb9QGCFM=;
 b=tkFlaDJ5TPb/Anialgl0JgoL+YQ3fiO/U+eIcrfEs2OLlN8e++xjovK9Znn4BAfpQZ
 1HzRCZFQ90AbjL1PxB21a88LXGY44JfOGpwh97AtpREX9ZR1OzwU9L6wByx9UvFyKwQI
 k0tWSz71z8zRUrZxIY/wr56+blMqnoR9DgEnntgl5PEF66+tcOKhYe3xXFrWdrEurvFe
 KAOjzMh/YcEsbBL/SDykETzviHUEPZQZ36YF3SR+U5N2NkUsasv2PPQQoPHdVd3/hAIF
 sjEuzEteV4C14xjJbFI0hh4syvaKK+9XIdMjrOfDF65OA9jdAg+WHhrpprzyJn3rt9sA
 sopg==
X-Gm-Message-State: AOJu0YylI4dzwO4Uf4S1bkVcVG5eWsedVvzKvZ5WM44Ff9eZdr8jVbj6
 g5+9AUIDdzrJmzfsjF2SRf6bgCIgp2RIWy6NSbb96rGVmwyJ6zvxjtM+l2Ox33/0Z0qwvKtt85A
 5duD7UVI=
X-Google-Smtp-Source: AGHT+IEwKh3xCc4zb8NXtUPzv/uPVgrUQ48F5g2YKKcFOd7at7OfHXjc0F8iIm/hv8G6nm86ZARhjw==
X-Received: by 2002:a0c:f40c:0:b0:6cb:25f5:ec44 with SMTP id
 6a1803df08f44-6cb3b5e4eadmr15801896d6.7.1727388090520; 
 Thu, 26 Sep 2024 15:01:30 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:01:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 07/12] bootstd: Add debugging for efi bootmeth
Date: Thu, 26 Sep 2024 23:59:37 +0200
Message-ID: <20240926215950.1265143-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926215950.1265143-1-sjg@chromium.org>
References: <20240926215950.1265143-1-sjg@chromium.org>
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

Add a little debugging so we can see what is happening.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v6:
- Expand the debug messages to be more descriptive

 boot/bootmeth_efi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 6b41c0999f1..2ad6d3b4ace 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -162,8 +162,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	int ret, seq;
 
 	/* We require a partition table */
-	if (!bflow->part)
+	if (!bflow->part) {
+		log_debug("no partitions\n");
 		return -ENOENT;
+	}
 
 	strcpy(fname, EFI_DIRNAME);
 	strcat(fname, BOOTEFI_NAME);
@@ -171,8 +173,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
 	ret = bootmeth_try_file(bflow, desc, NULL, fname);
-	if (ret)
+	if (ret) {
+		log_debug("File '%s' not found\n", fname);
 		return log_msg_ret("try", ret);
+	}
 
 	/* Since we can access the file, let's call it ready */
 	bflow->state = BOOTFLOWST_READY;
@@ -307,6 +311,8 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
 
+	log_debug("dev='%s', part=%d\n", bflow->dev->name, bflow->part);
+
 	/*
 	 * bootmeth_efi doesn't allocate any buffer neither for blk nor net device
 	 * set flag to avoid freeing static buffer.
@@ -332,6 +338,7 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 	ulong kernel, fdt;
 	int ret;
 
+	log_debug("distro EFI boot\n");
 	kernel = env_get_hex("kernel_addr_r", 0);
 	if (!bootmeth_uses_network(bflow)) {
 		ret = efiload_read_file(bflow, kernel);
-- 
2.43.0

