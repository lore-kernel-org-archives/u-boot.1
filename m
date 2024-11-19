Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49840D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CAB1895D7;
	Tue, 19 Nov 2024 14:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rwf58EJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6FFE8959C; Tue, 19 Nov 2024 14:20:13 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B378959D
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3a763f45bb6so3472185ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022410; x=1732627210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOEf9yJCE+N8SzGWgPk2s4G3C7wFjlSvZPck+j7HWtk=;
 b=Rwf58EJkNUGmCZoR990RGJm9ZhHAqclSHeYLBkEedYCiPiKUqqA3MWT0jJtBd6LqF8
 dYnWKm7ragsADggwkAbx0bjauUUtsyZCqcFkEj48EJn0fEQWoYFmQO3JJfu/G+2faAKV
 FaOaqGUvpxRH+CDSpZW4DvV7fvUZpOhN4gtPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022410; x=1732627210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOEf9yJCE+N8SzGWgPk2s4G3C7wFjlSvZPck+j7HWtk=;
 b=p9us90hKWsrJe59r+HZ7L5GqAcU6HJ7yhUrc6fTdDn1dYQfFWdABdgXWtNKk9Bfzt5
 CYKHR3AqLWKMgP0yeQYu5qQwx0ljRfmxWiPYrZDBZzSSo/ixhMlSK8FIJWGSEpa3pAe2
 uZFclo5+F8/itYY5eNmzo7O6ahUtn8EqQU4VDaInMKrriiSnGuIxQc09I0HyaBF64bXI
 dAl397rOZak3cG8mEKuH9RoK01jm0ZWiuHCV8JEJwDab2soxCj9oCSLJbz29ZR4nu/P6
 BahFT4aSk1OlmwmBYzCVS9QnTfNgjA1Sab0LRQFNZ9h3mZ/bvOrwbO8DEetXZeDS2w1R
 JVRQ==
X-Gm-Message-State: AOJu0YzJpK5vDiaEL1UJPkgq98D5zo2m6qDBBz65mxA+swdjz0zLBnUa
 x7qSQ8Xslg4cxwV2rqmbP1EiLnu0bbb1C/zFg3ANnRPY5Qbg+K8X26L9ZPawqrS7gNLbTaa5H8s
 =
X-Google-Smtp-Source: AGHT+IFL+3NwzJIo04YxHPkEtjTT8PQVzshEhZ7JfZLfqcbHzu9iDWMNCVskA4bxP4JBvEe5zn7U6w==
X-Received: by 2002:a05:6e02:2208:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a7480227b5mr167612905ab.10.1732022409810; 
 Tue, 19 Nov 2024 05:20:09 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ion Agorria <ion@agorria.com>, Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 29/39] bootmeth_extlinux: Move extlinux_info into plat
Date: Tue, 19 Nov 2024 06:18:34 -0700
Message-Id: <20241119131844.4078144-30-sjg@chromium.org>
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

This struct is missing a comment, so add one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 9cc2032a201..b48f96b16ef 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -21,8 +21,15 @@
 #include <mmc.h>
 #include <pxe_utils.h>
 
+/**
+ * struct extlinux_plat - locate state for this bootmeth
+ *
+ * @use_fallback: true to boot with the fallback option
+ * @info: Info passed to the extlinux_getfile() function
+ */
 struct extlinux_plat {
 	bool use_fallback;
+	struct extlinux_info info;
 };
 
 enum extlinux_option_type {
@@ -173,20 +180,18 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
+	struct extlinux_plat *plat = dev_get_plat(dev);
 	struct pxe_context ctx;
-	struct extlinux_info info;
-	struct extlinux_plat *plat;
 	ulong addr;
 	int ret;
 
 	addr = map_to_sysmem(bflow->buf);
-	info.dev = dev;
-	info.bflow = bflow;
 
-	plat = dev_get_plat(dev);
+	plat->info.dev = dev;
+	plat->info.bflow = bflow;
 
-	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &info, true, bflow->fname,
-			    false, plat->use_fallback, bflow);
+	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &plat->info, true,
+			    bflow->fname, false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
-- 
2.34.1

