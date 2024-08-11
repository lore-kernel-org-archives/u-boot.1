Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BA3C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DF688C4D;
	Sun, 11 Aug 2024 16:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RahY2NM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF548889C; Sun, 11 Aug 2024 16:53:04 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6388888A25
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39c2f653efcso5890865ab.2
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387977; x=1723992777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZPs5LxcNNfqWmMn1am7y0YE8qmewycHIxMGVk0UTcc=;
 b=RahY2NM/OYCDifSK1+FVIdWsDlEDipghQGMxqNopb0Vh/BFtkwzqkO6jiNTqm94Cc8
 h8Sf4k9qAKwrh1Eg/z+5E59E2vII1XWpHum6Ff9gqXnrtpWcUTQO4exfA18SW0kVfVpg
 5N5vFmKPg0SaIZFCUQXeov05DirDPuy6RXvbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387977; x=1723992777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AZPs5LxcNNfqWmMn1am7y0YE8qmewycHIxMGVk0UTcc=;
 b=n4UJBeVeAormj5u8ZCAOVmFfSmMpw2GppwDYxDCHS+fU3ISIgwq+5qA7h0EC4cUQYx
 YR5vcbsYXJYgsWAJ820obKQ0yoiljESM7hZIv3w/WD1oaPrbptOxBTrL4FllqRo/VHv9
 r/XBEC43WyLFaKBtvCGQ+IaFVsfFBKHsErUpSrm4gCuz7ZyagAn9fPjYUWXRc838HRwJ
 jBdW1trh+t0ne/MsMf5aA+xDhm7OO9CGumBepiBwkHGA13FxwyYVSj2W6dC13pRQ/RwG
 ZBf900oBOPIjftW6aPs6SLptQi/T4L38qUP178/S5wtNcMj8rTzVp802mAb2izxXY9aR
 ycfA==
X-Gm-Message-State: AOJu0Yya7/aS/KzuHWYb2KdQL3kFf5B+TZa0g/gfJRfFXCy1DcNxE46W
 lgtsKQLV3wV2+Xp2z7XmIy5EkAG5UH/rjz57cPXyzIkv5odRdn97sp4/OrWeesOgpq9KFVz0cTk
 =
X-Google-Smtp-Source: AGHT+IHw6qwgyWh7odjaszTbr1OC8RrfIAtvKNAvPNYurxihEtx8HiDNzMDmlvXc9LnmUCYk+XOrtw==
X-Received: by 2002:a05:6e02:b49:b0:382:64d9:1cba with SMTP id
 e9e14a558f8ab-39b815a4dcfmr91263875ab.19.1723387977123; 
 Sun, 11 Aug 2024 07:52:57 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 35/40] bootstd: Add debugging for efi bootmeth
Date: Sun, 11 Aug 2024 08:52:04 -0600
Message-Id: <20240811145209.4191404-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

