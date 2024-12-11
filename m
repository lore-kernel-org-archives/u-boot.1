Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C2AE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 22:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD461801DD;
	Wed, 11 Dec 2024 23:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A212QCHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB373801B6; Wed, 11 Dec 2024 23:38:50 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8BA680212
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 23:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a9c9f2a569so292915ab.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733956727; x=1734561527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZFbXQXXrX4NNznvx9fJjmNHnly31Uve7xFmDoOl18w=;
 b=A212QCHkD+BvFXzMUoTjlEXXaNp29pNZtbgd3wCGRi71eEwlKiwGkRwuAyXFmNd+if
 wuY2Qk73joxmVrk2ZCw8nQAJUVkJ5Q5BxSc2WJs64fv92qNqYegSVq2ZA+oAvTnrkr/n
 WW1T2bTlQxuhPIGWNG14Ck1watLuDRABzKSlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733956727; x=1734561527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZFbXQXXrX4NNznvx9fJjmNHnly31Uve7xFmDoOl18w=;
 b=sWjd7athelILSARsjlF2ln7JF3aRekdJeN+5swEzTq/hF6/DE48k7jTj00KTQd+a+7
 td7yYu7LPnl0fxNky2WcWi+ov2sFnMhwgwhHlZboL5E59QMQyGi0Tryo9kQF3bmJ9Jf/
 FrXWM7QeWo3LobKGMjseKcv2/FcjOfwAgeFnZhNs7B0WydKNCVvO1wkq+2xfOUK7uTU9
 UzvSw2Z2MpvMppkScJ3+hIdAiV4Bou8NSxRo1dEn73Z/zEeSHEgjp00iYqs2o74axu9l
 qvYyu0NxgZAleTqHIXMf11c6Jt3S58gzRHeaZ1JL7R6boekapmuzVKZnwO5Quu++fdmQ
 83Rw==
X-Gm-Message-State: AOJu0Yy2euIVKDr34k1+KckTtr42yjdIwuSJU6fMiwVZOL0CiWtvlF08
 RjC4SnqW9Nk69V42W2xMyhxhFEauHzkK9ZE3tIdrrgPzgR2HL+J1xja8a5kViqbYizl4luS/XAU
 =
X-Gm-Gg: ASbGncvYx9cv1tt5aIG1fQTlIXC/aS4Au1OQ9dVe6mNIsu7W9srYvNNYmL9yypDhI9Y
 y5ZMTp8eDzxXriHp5SkmLW5ocK6szd7p49mdXbIHAevCsWfQk8YO5xUGnqUtCMi4enti7YJ1GQw
 oHTs1QzxeLB0ur3DwBtv0cXGSU2jkQgqcQ7EuDlghdDAKHWo3fLBr6a2A311BFdZhoVVFRfOgOc
 mr3uZjvREn0unnnlntPbI9kzQ52lc6YP1Rw4m2sibXlj8XJdSy/36VXBwE6NhRtBskFqoB/t5kr
 qvUYLu9JMRhEekWfDA==
X-Google-Smtp-Source: AGHT+IFZPAHYzEMWgPfI5F2BXQ5BbEzHuj8u+b3JmT9AfmtYNoM1m05+tOFRN3dKRgrID4uJ8EC27Q==
X-Received: by 2002:a05:6e02:168d:b0:3a7:9670:7abb with SMTP id
 e9e14a558f8ab-3ac4d5e2adcmr14715975ab.15.1733956725439; 
 Wed, 11 Dec 2024 14:38:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2bce7981bsm1902816173.67.2024.12.11.14.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:38:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>, Patrick Wildt <pwildt@google.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 7/7] bootmeth_efi: Support PXE booting
Date: Wed, 11 Dec 2024 15:38:22 -0700
Message-Id: <20241211223822.2446254-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211223822.2446254-1-sjg@chromium.org>
References: <20241211223822.2446254-1-sjg@chromium.org>
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

Finish off the implementation so it is possible to boot an EFI app over
a network.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to support PXE booting

 boot/bootmeth_efi.c          | 15 +--------------
 lib/efi_loader/efi_bootbin.c |  5 ++++-
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index b745ba8bd4b..0c9b4c3d59d 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -210,6 +210,7 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (size <= 0)
 		return log_msg_ret("sz", -EINVAL);
 	bflow->size = size;
+	bflow->buf = map_sysmem(addr, size);
 
 	/* bootfile should be setup by dhcp */
 	bootfile_name = env_get("bootfile");
@@ -219,10 +220,6 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 	if (!bflow->fname)
 		return log_msg_ret("fi0", -ENOMEM);
 
-	/* do the hideous EFI hack */
-	efi_set_bootdev("Net", "", bflow->fname, map_sysmem(addr, 0),
-			bflow->size);
-
 	/* read the DT file also */
 	fdt_addr_str = env_get("fdt_addr_r");
 	if (!fdt_addr_str)
@@ -296,16 +293,6 @@ static int distro_efi_boot(struct udevice *dev, struct bootflow *bflow)
 		if (bflow->flags & ~BOOTFLOWF_USE_BUILTIN_FDT)
 			fdt = bflow->fdt_addr;
 
-	} else {
-		/*
-		 * This doesn't actually work for network devices:
-		 *
-		 * do_bootefi_image() No UEFI binary known at 0x02080000
-		 *
-		 * But this is the same behaviour for distro boot, so it can be
-		 * fixed here.
-		 */
-		fdt = env_get_hex("fdt_addr_r", 0);
 	}
 
 	if (efi_bootflow_run(bflow))
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 8efd779d9f1..d02c254c2bd 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -270,6 +270,9 @@ static const char *calc_dev_name(struct bootflow *bflow)
 	media_dev = dev_get_parent(bflow->dev);
 
 	if (!bflow->blk) {
+		if (device_get_uclass_id(media_dev) == UCLASS_ETH)
+			return "Net";
+
 		log_err("Cannot boot EFI app on media '%s'\n",
 			dev_get_uclass_name(media_dev));
 
@@ -310,7 +313,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
 	ret = calculate_paths(dev_name, devnum_str, bflow->fname, &device,
 			      &image);
 	if (ret)
-		return ret;
+		return EFI_UNSUPPORTED;
 
 	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
 		log_debug("Booting with built-in fdt\n");
-- 
2.34.1

