Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DB5D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B0028959D;
	Tue, 19 Nov 2024 14:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FiIk7Bbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A696889609; Tue, 19 Nov 2024 14:20:16 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707248959C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a77980fe3aso2027205ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022412; x=1732627212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+997dx6en5CuIgHms/Qddgge3/JsQnuz0Di+sptb2rs=;
 b=FiIk7Bbv4UmOEl4yk8xHTon8uSJ/GL9TXceQqKEc+uZrNiFw3L8F1KqIOXzRqx7tkb
 EeWybWaNcFzh4XqGf1NcoJTcTgBx8PT/EFzBKm0jb0chNhNNHLExAhRMMys1l1SToum0
 ndI8usuKDo0zgQ+1l09ryTcnWya1gre2CTzj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022412; x=1732627212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+997dx6en5CuIgHms/Qddgge3/JsQnuz0Di+sptb2rs=;
 b=rT0Q6UbKxruwrx8a0JwoVCJhcakPNpZwbXcGubgRkI7gQcvZ0lqQoy9tZySutXvkND
 q0ZnfFujelRuEXMhCjE6hq3dcz8JIOFFjJ4+6NDVcCMNjeXF2nF3NjmonNi1GVO1B+Sh
 sXzGe9ECUzmWjLkYB3iaMnvGGVOJV4pq8YH1l3Nm81nlADiyT1pL1NPqwa05IFFMuVYy
 6krPB1BE2MRCbs0N14/b9mH4q+QkBgoPjjew4FWD+qkjT7piakczn6Cy3q6Se2zMTQoc
 zzKSArDtZ0dcSLBQAU5TrkS36bZYjOUv4rcx/PuWZzSVy/3cQS0mnKLhI/n93ur8cXiz
 WWxQ==
X-Gm-Message-State: AOJu0YwyAlGER0vjyIZnTXuARjLU3G9EiGAnW4su0B0p7j7yZasvGna2
 txefpJXNwDbHBBamV00+9VBpO1Fk4mWeg39j2TtVh6CnZopoZ8y6/XJ4e/9dY8hIysg7XKRmCuw
 =
X-Google-Smtp-Source: AGHT+IH9FH218IAZZvk+u+XKgr3/FSMHbVtqfX+UPPR0cF6KVHDEF7BIeeMKnRWH+QNdW0kTUPO5gA==
X-Received: by 2002:a05:6e02:1a4a:b0:3a4:f275:c7bf with SMTP id
 e9e14a558f8ab-3a7773d0886mr36310915ab.6.1732022412682; 
 Tue, 19 Nov 2024 05:20:12 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 30/39] bootmeth_extlinux: Move pxe_context into plat
Date: Tue, 19 Nov 2024 06:18:35 -0700
Message-Id: <20241119131844.4078144-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Move this struct into the plat data so that we can use it multiple times
during the boot process.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index b48f96b16ef..2f8e579540b 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -26,9 +26,11 @@
  *
  * @use_fallback: true to boot with the fallback option
  * @info: Info passed to the extlinux_getfile() function
+ * @ctx: holds the PXE context, if it should be saved
  */
 struct extlinux_plat {
 	bool use_fallback;
+	struct pxe_context ctx;
 	struct extlinux_info info;
 };
 
@@ -181,7 +183,6 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context ctx;
 	ulong addr;
 	int ret;
 
@@ -190,12 +191,12 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	plat->info.dev = dev;
 	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &plat->info, true,
+	ret = pxe_setup_ctx(&plat->ctx, extlinux_getfile, &plat->info, true,
 			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
-	ret = pxe_process(&ctx, addr, false);
+	ret = pxe_process(&plat->ctx, addr, false);
 	if (ret)
 		return log_msg_ret("bread", -EINVAL);
 
-- 
2.34.1

