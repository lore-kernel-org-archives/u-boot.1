Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E25DD4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B562F89619;
	Tue, 19 Nov 2024 14:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LIf7S3KB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4237895FA; Tue, 19 Nov 2024 14:20:24 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8039E89619
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a77bd62fdeso1893275ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022421; x=1732627221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phX8yioRPrdUv++X4MH/CPQbC5ORZhwp4PueAUjpIgM=;
 b=LIf7S3KBlFhWxaXUEVfAC2rPn2WRfPdzOCZDhux1H3A9+j9QmKV2aOk6achlLj+MGP
 7wFKXW+OTwJ5D3stgJ7r1C0k7NIE6z5/lqOxhc2HxoqTfShKyrVTFt73alZRU0XsUnpV
 xpasSJeJT5+rf6tS0iJReGbY82jau3ytqoNHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022421; x=1732627221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phX8yioRPrdUv++X4MH/CPQbC5ORZhwp4PueAUjpIgM=;
 b=EarDUd8EnuquiCdzX1OQU9Kco1vfb1g0VhvNWxFHxf71m9LMeYkw78P89YHHwAt9Wx
 bqojfwtnD8s6vrlBCCLt+zX1xTSez4yrmROEbu2tozk7MLUVHAwIaMjw3kSx5RxfJQ9m
 tUccpho8Nw0bH97wnnjsDrXBdHcrPvJ+E4Wcdhy1x9yLCcs8LxLW4VTPQJbQlYV/LdQd
 AJN1Te427y1jc9cecENudKoKxHiJfCXvEUKrzcvBG1UXcu7tlckD4I/ZjIm1Ecbmebto
 4miscPuJ3vJvNi7YgH5uKIZj8ZMglLj7HINukI+AOFwwDUqn62FafoERYi33/MRBuY2j
 movg==
X-Gm-Message-State: AOJu0YyWwbkvg/L61671eIB4IAikSuyyYqaq3Pi62/cK1/7pjKq7+fgK
 yG0FT5KTxIRJPha8XM8NceNCoo2lUsylvjEfcqPbt9qJjnVE5jDvBNSb1Q3l8CDskSyqKb0APyc
 =
X-Google-Smtp-Source: AGHT+IGHzDY4tON/oDKI4iGpVLDVHIVg86gbLTWge2EYFu5qx7KVjXlTmJ0Hoy+AmR++RbJ2ImiD7A==
X-Received: by 2002:a05:6e02:164e:b0:3a7:8270:4043 with SMTP id
 e9e14a558f8ab-3a782704449mr1164215ab.15.1732022420712; 
 Tue, 19 Nov 2024 05:20:20 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 33/39] bootmeth_pxe: Drop the driver-private data
Date: Tue, 19 Nov 2024 06:18:38 -0700
Message-Id: <20241119131844.4078144-34-sjg@chromium.org>
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

Since this driver's plat-data already contains a PXE context, use that.
Drop the priv-data. Use the extlinux_info which is in there, as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_pxe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 6b3cb3c4b91..a9608edcef9 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -140,7 +140,7 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct extlinux_plat *plat = dev_get_plat(dev);
-	struct pxe_context *ctx = dev_get_priv(dev);
+	struct pxe_context *ctx = &plat->ctx;
 	ulong addr;
 	int ret;
 
@@ -188,6 +188,5 @@ U_BOOT_DRIVER(bootmeth_zpxe) = {
 	.of_match	= extlinux_bootmeth_pxe_ids,
 	.ops		= &extlinux_bootmeth_pxe_ops,
 	.bind		= extlinux_bootmeth_pxe_bind,
-	.priv_auto	= sizeof(struct pxe_context),
 	.plat_auto	= sizeof(struct extlinux_plat)
 };
-- 
2.34.1

