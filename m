Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F863CA101E
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30CD88AD2;
	Mon,  2 Sep 2024 03:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KmPOnRE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D99A88A34; Mon,  2 Sep 2024 03:18:48 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF4288A27
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39f52e60a19so4975625ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239924; x=1725844724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9tCNJowy8ljKgL67GchgMWoyhXwiIj6N2+kl8jylCg=;
 b=KmPOnRE1oEPWQspdlERQUIlyM1aFEp06+YBTTkpD7jeeYfN4qXdclxtKsEFz5MTOlu
 IbY/IH0f3phb9WjsqgujHIEeX+8RV5QznSUpWxzzUAfutL9ZbMI20u4+evJwx8J2+cNO
 59a395cHCZDAsf00w9vwg1bcwYfgmwr4InB/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239924; x=1725844724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9tCNJowy8ljKgL67GchgMWoyhXwiIj6N2+kl8jylCg=;
 b=EzfRNOIUTeZMGk78vPFDy45Eih8CVa3i5vYBkxl/6zCZqmdCY5IotBoAg7JtO5Y+Z1
 whfifgrgAI8EMHm6t0yHEwigMMy0tbSJusNpxOGPUC1D2vL0AhxdVSCunG6h3JoR4/eC
 GhYk4TL2yVXeM6exbqJu0NYrDZIopMNEK3+PtsVkp64dXspLxADWYS3/LgR9gBQeXnTb
 w9ajMx3v7tD+n9w2ZC9WuTOrqGepmPmWdlzm3Ld6jzUueUqFNCToFsNrb8mdlBznzeXN
 osVBhKeqIByspZtdq04qA5j5XT0NVWcrOR/cpwGutEWX0JYdkqcMpkUb+ZsKfLlckwbs
 95QQ==
X-Gm-Message-State: AOJu0Yx2vq3JyCDNCprv50NXXtPv63c7hz8nU2yxxKvtxuTI5K3ojWOz
 KI01vkPqT4e/W3VHEsQKVLID8BSJzFwEnu7cG+ijnYFxTFjRTOgIAHiAJP+/yPWDXe0RfQCXcuQ
 =
X-Google-Smtp-Source: AGHT+IEcsERRIw5MvtsaiulQoVRSGSEVAQjhGfeQtnMtrj8OAUzMTaJD4OnhYdIJ0AZK6EyzXF3FMg==
X-Received: by 2002:a05:6e02:1524:b0:39d:24de:daa0 with SMTP id
 e9e14a558f8ab-39f37837f02mr149938165ab.20.1725239924524; 
 Sun, 01 Sep 2024 18:18:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 09/14] bootstd: Add debugging for efi bootmeth
Date: Sun,  1 Sep 2024 19:18:20 -0600
Message-Id: <20240902011825.746421-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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

(no changes since v1)

 boot/bootmeth_efi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 6b41c0999f1..4d641d042ec 100644
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
+		log_debug("no file\n");
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
 
+	log_debug("boot\n");
 	kernel = env_get_hex("kernel_addr_r", 0);
 	if (!bootmeth_uses_network(bflow)) {
 		ret = efiload_read_file(bflow, kernel);
-- 
2.34.1

