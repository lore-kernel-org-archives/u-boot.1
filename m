Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85290C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F3780EFB;
	Thu,  1 May 2025 15:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bIIOcs61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD8D8213D; Thu,  1 May 2025 15:37:45 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A859809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d8dcc7cd17so6920295ab.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106661; x=1746711461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ALGfv88HEU1j1Vkrml5dvNrAdznaXCHoL5RIHTDztU=;
 b=bIIOcs61MKER2veOV1esXI7M4jFaPWHaONS5JbRppiuUju51dG2l0pJbaujJ3Snu0A
 dP4H8sOsU5xxDbGmH9p15TKlQx9B/2hAPdkRNhbPeBvLaJdaGe9fIwWgijt8ZHDsrPCF
 jlIFI5xZdICExQby1d5t/bb8I+B5pA1N9lyMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106661; x=1746711461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ALGfv88HEU1j1Vkrml5dvNrAdznaXCHoL5RIHTDztU=;
 b=A71Y7Wh8HNhtArLnNgCH+ZgZdxMOrNYiETJzeYE4kuXQEctFVAZ8L7b2ngt/h8rsZW
 uSoUeqNupiJJb0KSsotF74i2uV7goJkev6LCp/J+xWRWD1Ii4IMj2GiLyPUz0p9ZKJiO
 +6JYpSWeUfAGGrnLaQUe/s92nzJ4PHPFntLzeVbYN4DTvEDTPwL/Dwq+tIzJt6kfvvtl
 VSll74i+SjBX1pBrgOl0iRVzFiKRCpkgawTDwUt7k47iRU4AZcSKRe2ZaLhJKmV7MSVp
 FHOTfK8hzlWty1bZf6pEDAuQGdOwqUJI6XE7H7Zb8I6kagK6HlXVOf2q5+s3w7lmGjmx
 QC3w==
X-Gm-Message-State: AOJu0Yz3ryfvdg9jKJfZiuY2tOKUmAz0UzRjsUiI6EvBufSb8JtLcCY5
 8j9BEH6lDTRsciv8uWnPIgx6N6ArMdPr1Bey8XTxG0bl6YWFbEDqIKuQFRkSmKDtcxaqKkaFaKI
 =
X-Gm-Gg: ASbGncsEkhFYg4nAUnfJutgoqcKXchkU/J+sJ4rOwQkZ3iP/RuIhqdfBc/Q/Phakps1
 9nmwzioSU0Lxo3UmOu8SCNGEXBcsXawwxFLWM+0nfSbPJSNTUfsr2OtCvNEDYdHv7SxITtAXGH6
 r2+X0FaWOzmKleQGek4DABTl1reroxiRznBLOkZO34S6dtzkoLgM9D2ibAJaZfaSMwyyhcuyGos
 zk+5Yl5wInj5pzrQuPy9QbLiBm9LEsCQWPeWD5KpQp/BihZqXcx7ztnVvXBX1HlHBVGipPp5Uft
 MN2Z2jZeX+c4u3rutcK1s2vZvUGcL2TYcmBdBJfKPeR7yzkRI76LU/CNt3zHx4c0uh1TpRlFoQe
 08ZJ7PC+b898y
X-Google-Smtp-Source: AGHT+IE6ORewTnYpw8Fzp+/UzgrU3UIYtGEL/9JGONpojgwBw0VnljaYKV1ICMtWTSySb7z5r3G7Hg==
X-Received: by 2002:a92:d08b:0:b0:3d9:2992:671b with SMTP id
 e9e14a558f8ab-3d970aa4638mr21711175ab.4.1746106661494; 
 Thu, 01 May 2025 06:37:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/18] bootstd: Add more debugging to bootmeth_extlinux
Date: Thu,  1 May 2025 07:37:06 -0600
Message-ID: <20250501133726.2627373-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

(no changes since v1)

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

