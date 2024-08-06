Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616D1C3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0800C88B12;
	Tue,  6 Aug 2024 14:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WD9rdQ/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F2F88A76; Tue,  6 Aug 2024 14:59:53 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E68C788A65
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81f85130660so195308239f.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949188; x=1723553988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZPs5LxcNNfqWmMn1am7y0YE8qmewycHIxMGVk0UTcc=;
 b=WD9rdQ/j2AwV53jaxIieOR1C+JVkv/VIJTr+UJXFHPqUSJtzZkZsmKTYbivAx5AP8u
 ERFNPAnSHoE2mVWlDSYvM4utYLt5Kay+kcFi/gT4JLCLryhztQtt9RXkiQkdYP4h5CbY
 DYgToQbbMdr6n/m5CiZheZxmVCHw5+lq3xQk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949188; x=1723553988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZPs5LxcNNfqWmMn1am7y0YE8qmewycHIxMGVk0UTcc=;
 b=hBnBn2tc8mV4o9g/BMwZKHUTFSJhMc2yp5GTppt9Yd+olgzV6Ff0gSohVlF5ULlFJf
 uZ/wmpAiIHxjTKxaPrQnYBAorLUpBxbTthlSumlyPgUhh6gRjsX3BhrAM7iAd6vhD9mX
 EZvnQnywUyE9LzjhTfqQl3OpyZjYqYPwyAR/Ql/KuyjIVozSjFyDLXStsRKU2jT6FZu8
 74u+opiPCtaypD4mLVXKzxB38Hfc8WlYGRKZegPG6bdUplTmwFesc6zWfNUIT0dZmknA
 Nxm7yDCW7i8C/0vXrsiIYoFpKxHC4YJ+zZ+jNR57uNcpH71W5aJLtd6cY/KS+19Nt3Eo
 O6yw==
X-Gm-Message-State: AOJu0Yw3sgl98GhVJMBV6hhF9cUWBTAsCw52BVjQPIK3aSRONzW2naLp
 ZV0/WkFIR5bXgxllZBfkpJDCPTQX9pR3G5tBzPNu5/KexDZaPQvNZArNkMW4iLhK5eGcfNILw7c
 =
X-Google-Smtp-Source: AGHT+IEAI/UbgWcONqsSI77GUs/LdvTOs4bYj6vY9Hcq6oCAcIaSli+baATUT1Q9Ncxh+rxohVBhfg==
X-Received: by 2002:a92:50c:0:b0:39b:3244:a355 with SMTP id
 e9e14a558f8ab-39b3244a818mr94132495ab.11.1722949188386; 
 Tue, 06 Aug 2024 05:59:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>
Subject: [PATCH v2 34/39] bootstd: Add debugging for efi bootmeth
Date: Tue,  6 Aug 2024 06:58:45 -0600
Message-Id: <20240806125850.2316956-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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
---

(no changes since v1)

 boot/bootmeth_efi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 39232eb2e25..99887a89f02 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -163,8 +163,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	int ret, seq;
 
 	/* We require a partition table */
-	if (!bflow->part)
+	if (!bflow->part) {
+		log_debug("no partitions\n");
 		return -ENOENT;
+	}
 
 	strcpy(fname, EFI_DIRNAME);
 	strcat(fname, BOOTEFI_NAME);
@@ -172,8 +174,10 @@ static int distro_efi_try_bootflow_files(struct udevice *dev,
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
 	ret = bootmeth_try_file(bflow, desc, NULL, fname);
-	if (ret)
+	if (ret) {
+		log_debug("no file\n");
 		return log_msg_ret("try", ret);
+	}
 
 	/* Since we can access the file, let's call it ready */
 	bflow->state = BOOTFLOWST_READY;
@@ -308,6 +312,8 @@ static int distro_efi_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
 
+	log_debug("dev='%s', part=%d\n", bflow->dev->name, bflow->part);
+
 	/*
 	 * bootmeth_efi doesn't allocate any buffer neither for blk nor net device
 	 * set flag to avoid freeing static buffer.
@@ -333,6 +339,7 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 	ulong kernel, fdt;
 	int ret;
 
+	log_debug("boot\n");
 	kernel = env_get_hex("kernel_addr_r", 0);
 	if (!bootmeth_uses_network(bflow)) {
 		ret = efiload_read_file(bflow, kernel);
-- 
2.34.1

