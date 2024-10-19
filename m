Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9960CD3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CE289334;
	Sat, 19 Oct 2024 17:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SoaAeZLf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC88C89324; Sat, 19 Oct 2024 17:23:09 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F3D88933A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-83aad99d6bfso118464539f.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351384; x=1729956184; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOQPy2aBfY49k+YQYWWb+kbIBtNIvSbbnLQfjgMDFBU=;
 b=SoaAeZLfU+WNaXlB1WKhMYdldxXyyDddkgwXYjLzgO8uNcHDvjTBvkC4PC0K8X+JjS
 Rlr40M6l8xBQe+97ALPT7UJyDrch3h8h7BBzOndDK8h41L+U4EyW1Sh+NBnV+wlVLJkI
 clNXYclZMDYokEIriI2M4nFhO9qq+bGiK8oDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351384; x=1729956184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AOQPy2aBfY49k+YQYWWb+kbIBtNIvSbbnLQfjgMDFBU=;
 b=aZLY0L69dYHp1k5Q5+PRIOaglgMtXePfW7Z4JCUqE5kdhMoOB0ThKiRMoH3m9YIgNC
 o1XHWMSjj6msZy/RqhXcAwx3+ompOTnIpsRuEoK/JUW/1zdrMb1xW3PcGssJirESewEO
 JLi/srVByk05UBeuYguMuwxyYcC+kXNXVwEEhGcypeWzihmRYsyIOQpM6txx77SC6uzF
 virMQfMbrkdT9Ol+2RGW1XhlclfQauOSTOThH7hH4w7DI1Y+I27LymFROxTeO0bzsejw
 OXi7s6lrhjYPZmA4AIBVXQtaiS8TVBL/KIl6v0WtHcMJN64xLIeFcmjygP0xk+xgvr8q
 FlFA==
X-Gm-Message-State: AOJu0YzDsHMVn3zGQYDsA0sxL87Iqa9xWH01WR/RHjti3UTmAnU86s+O
 4AZZGd4wVN3POLy5fYzboYDfUVRHst6XH32q8V5SunuTwkkCioebNuOYMSx0C2IJ+ZMJ55qN1Q0
 =
X-Google-Smtp-Source: AGHT+IEW6w3ugA1U/98MS4mL4Ff6WZBNKtOQEVQJNpgR2bOF7dVnCi90nCtWLmMQqPKg4NNeWv9UNw==
X-Received: by 2002:a05:6e02:1a0f:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a3f40508c9mr62631335ab.3.1729351384083; 
 Sat, 19 Oct 2024 08:23:04 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:23:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 30/31] bootstd: Update cros bootmeth to record images
Date: Sat, 19 Oct 2024 09:22:10 -0600
Message-Id: <20241019152211.1014896-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth_cros.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 1825293d93d..907e05b1d60 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -206,6 +206,7 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	ulong base, setup, cmdline, kern_base;
+	struct bootflow_img img;
 	ulong num_blks;
 	int ret;
 
@@ -243,8 +244,27 @@ static int cros_read_buf(struct bootflow *bflow, void *buf, ulong size,
 	ret = copy_cmdline(map_sysmem(cmdline, 0), uuid, &bflow->cmdline);
 	if (ret)
 		return log_msg_ret("cmd", ret);
+
+	img.fname = strdup("setup");
+	if (!img.fname)
+		return log_msg_ret("cri", -ENOMEM);
+	img.type = (enum bootflow_img_t)IH_TYPE_X86_SETUP;
+	img.addr = setup;
+	img.size = 0x3000;
+	if (!alist_add(&bflow->images, img))
+		return log_msg_ret("cri", -ENOMEM);
+
 	bflow->x86_setup = map_sysmem(setup, 0);
 
+	img.fname = strdup("cmdline");
+	if (!img.fname)
+		return log_msg_ret("cri", -ENOMEM);
+	img.type = BFI_CMDLINE;
+	img.addr = cmdline;
+	img.size = 0x1000;
+	if (!alist_add(&bflow->images, img))
+		return log_msg_ret("cri", -ENOMEM);
+
 	return 0;
 }
 
@@ -263,6 +283,7 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	struct udevice *blk = bflow->blk;
 	struct blk_desc *desc = dev_get_uclass_plat(blk);
 	ulong offset, size, before_base;
+	struct bootflow_img img;
 	void *buf;
 	int ret;
 
@@ -306,6 +327,15 @@ static int cros_read_info(struct bootflow *bflow, const char *uuid,
 	}
 	priv->info_buf = buf;
 
+	img.fname = strdup("kernel");
+	if (!img.fname)
+		return log_msg_ret("cri", -ENOMEM);
+	img.type = (enum bootflow_img_t)IH_TYPE_KERNEL;
+	img.addr = 0;
+	img.size = priv->body_size;
+	if (!alist_add(&bflow->images, img))
+		return log_msg_ret("cri", -ENOMEM);
+
 	return 0;
 }
 
-- 
2.34.1

