Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3DCE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF5D80619;
	Mon,  6 Jan 2025 15:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e5/DGVtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220C7801DE; Mon,  6 Jan 2025 15:48:25 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E86F3805FE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so564612239f.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174901; x=1736779701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWVLoS9pHVJ3J3nuLPL2d83Vjv5e6WGNXO4sUG6LSW4=;
 b=e5/DGVtI6j7sPK1YoJ302mtavZSYK84F7vHOFnklW9k5pkRhJVfxtqTvEY2IrD2bMv
 O7Wv3ELH06cmFODAinaml6+w5jUknPxz/OmuApkVHLJinikSPBOhqTwD5Hz7lWxBnCuP
 UEm6jNbSBKXGtaV2wKAR81nfKJPFXYKLoOt1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174901; x=1736779701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWVLoS9pHVJ3J3nuLPL2d83Vjv5e6WGNXO4sUG6LSW4=;
 b=LK/kt8tdK0yzXDdP98W1V7jXJ7P6cdp2fWDnkHnkUCem8wbFylOIwaq7Ujb/nvl9RP
 T9nt1GLTzmNK+RddbY9Aif2Br9oiR19/Mm/q+BEUvIQxbXceHtU5Vn8u4A/AaR43Jm4V
 wd6T48YqkukFMBs9l+VKm2XBduy/V5P8mgn7EAIEWMp+7Jemyf764DOPbigcbLcKDuGe
 qfld9qsIeKiZbb0XE91y1EdUoHhHv/oJD1Est52T/6DGDkfU3FU7gDMLLu0Zj+OWUPgS
 1S7wmkA/Lmtd83R4hBB/1EtL4Q/yzjOWHxzDFa32TbVPsps3tOzlRb+sUhPwWxQUSdBR
 WN9w==
X-Gm-Message-State: AOJu0YzHcey4HEIFpNJUfhNM7tRk45jYl7mD3/Cw0eaHMZuseJwjY8Xb
 Jlnvu7QYqfO0bLJNTfEK5uD0KEF40kMh2BvTFdSAYUwL3Y/jo0/JSPaMKBoNOivI8PeuO5fuMws
 =
X-Gm-Gg: ASbGncul9O0Hvf8pdoLmcypGCDSCPWeYxAIT9NOA52b7R+J0Xoc7VdjiKlc1wMdwymw
 9aYAlGUSnlhvQOAVDCqrysThxNk/2E/Lc6Gmd69TygKShHQcNplGr3u1shQSMmFQZvQNvTRvkWD
 BDL2i8S7kfKb7efT7ljzRy6PkFQAPkmDEZdVe5cdMcQhwC3M8T93XU5JJTGwR+OsGmBmr6anpf1
 xErokF2qFvZUA/MhYWqFqOPQ5LJpOi23Jo4d9us1iuPHuS0mhI6qL8MoXKV6XVABmpPrzjHO1It
 njKlHZ1p0l43WbSikA==
X-Google-Smtp-Source: AGHT+IEwNj5EAxrlKlcjbPSwOLAajxsJRbMSOA8NwPjhUTRYeDjEBJuvMlXRPVjhduzHvlI5izI3Hw==
X-Received: by 2002:a05:6e02:349c:b0:3a7:d02b:f653 with SMTP id
 e9e14a558f8ab-3c2f9815c0emr532506805ab.0.1736174901104; 
 Mon, 06 Jan 2025 06:48:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 7/8] efi_loader: Check that the bootflow is not removed by app
Date: Mon,  6 Jan 2025 07:47:54 -0700
Message-Id: <20250106144755.3054780-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

The bootflow should not be affected by the app running and returning.
Add a check that it is still valid after the app completes execution.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootflow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8b1bc9f10ab..81e81f3cfbf 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1330,6 +1330,9 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
+	/* make sure the bootflow is still present */
+	ut_assertnonnull(std->cur_bootflow);
+
 	/* check memory allocations are as expected */
 	if (!hdr)
 		return 0;
-- 
2.34.1

