Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7518C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5C881F00;
	Wed, 19 Mar 2025 15:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GSn5AQ0x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B473981ED8; Wed, 19 Mar 2025 15:38:54 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B672881DE3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so5635604f8f.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395132; x=1742999932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vkec3W6FrUJRfGS8Gh/vhIPHANMGJsb/s7zoT76nGWc=;
 b=GSn5AQ0xcE+LAFncbvo75XBTw+7iF9ku+WmG18YWapJ3fqQ8cqb3m7YSJ55K6e0L6n
 486bPcSVlLGz/mOE5pbEyRpU5NgfjPCBPy8qz0r0qn4RVi4buYHg0xUVxb4tWrjOHtdk
 2FMEwFgTsfeiMcaMuVj9A5i9AYu2EQl14fDmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395132; x=1742999932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vkec3W6FrUJRfGS8Gh/vhIPHANMGJsb/s7zoT76nGWc=;
 b=X13EetQzmq8vTyfHa3B8QHlzwtQVg+pKSx7XX4JjiqikrTQo7lzuFAcIMM1qWoTrJb
 Erfy6wGmt4ZPA8VpZ3jq4kX9S3yNLmZ1W3v62YESpvOIoesrP7zZleDKqqKt9tnuKJOo
 7oLcOrMMKpX6k4BDLELax1tVsPrhyYQWu4FtlrgfIGbUj72USvdiLZ63E4y0/QgD7RFW
 5UjJpWxPwHasdoz1Vpyr58exT6yW8jQU/AGCMa916EpVQCI9vRrxCOiLrODlwBG8CrbJ
 foTq3n6kFRFgbP0VUhI7sCtvFpHr1JWw5SFcp/nuXBFY+ShQf4bONnZBUAK2alHDCsMM
 wG1w==
X-Gm-Message-State: AOJu0YznQQJrvs+8DFObqajGXa3WyeVWyeQHF0jMlAy5SjtFRz/YzgB/
 mzHqxgg0wtkRrfKqXKW2jHQmLQ7vUAQQKgY3kuIXRriR2zKpuuFcOopxtD3oSALe4Lu50CH7l7w
 =
X-Gm-Gg: ASbGnct7ZJhYJ2tw7sJyI9BC5kD/DWe8toCsZ6wBm0iva/h9EZGBA3apNGJObEvz066
 8JBABz0hgfdpe016AJSddk0saNqM9DH0NKGUhAIOu7Kbdrd06ieP01pS9XqH8H54TtgF2bKgfTU
 myApHAtB9fxEyQcqpWf8yZSuJnofTJXRMxvKx3PaN0S41gjcXn2SKq9Tc2PAE0Ys1+FNII86/OF
 os21Fst5WHuwuLfC74/UEWn02XFWLLzg9j7mjT4JKLHZkFWqt3YseqCgDmrNgfIzVavfXKC/UFa
 KuIlHr6QbeFkTeVPrXzo4/5f6fwcI1BLrd9brLxFLUGb3MtWT3SN
X-Google-Smtp-Source: AGHT+IFHO2y/F+Dc/gfVCGFrKlJ+GlFC4gKTkxoKPD/nNRGkYyqWm1/P66BZ+uSShxq+iz/I2b8yRA==
X-Received: by 2002:a5d:6d8e:0:b0:391:12a5:3cb3 with SMTP id
 ffacd0b85a97d-399739b63f3mr2548414f8f.3.1742395131601; 
 Wed, 19 Mar 2025 07:38:51 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/17] bootstd: Add more debugging to bootmeth_extlinux
Date: Wed, 19 Mar 2025 15:37:59 +0100
Message-ID: <20250319143820.2385092-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

Add a little more debugging to help figure out why bootflows are not
found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_extlinux.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index bb68391d551..71a9009479b 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -108,13 +108,18 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	loff_t size;
 	int ret, i;
 
+	log_debug("starting part %d\n", bflow->part);
 	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
-	if (ret)
+	if (ret) {
+		log_debug("no bootstd\n");
 		return log_msg_ret("std", ret);
+	}
 
 	/* If a block device, we require a partition table */
-	if (bflow->blk && !bflow->part)
+	if (bflow->blk && !bflow->part) {
+		log_debug("no partition table\n");
 		return -ENOENT;
+	}
 
 	prefixes = bootstd_get_prefixes(bootstd);
 	i = 0;
@@ -122,10 +127,13 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	do {
 		prefix = prefixes ? prefixes[i] : NULL;
 
+		log_debug("try prefix %s\n", prefix);
 		ret = bootmeth_try_file(bflow, desc, prefix, EXTLINUX_FNAME);
 	} while (ret && prefixes && prefixes[++i]);
-	if (ret)
+	if (ret) {
+		log_debug("no file found\n");
 		return log_msg_ret("try", ret);
+	}
 	size = bflow->size;
 
 	ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
-- 
2.43.0

