Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FB0C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84E686E95;
	Sun, 19 Nov 2023 15:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qi+L9Pfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6746B87083; Sun, 19 Nov 2023 15:43:59 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0697D8706F
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3594c100735so8773215ab.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405032; x=1701009832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyqG0C9qZI/rTzSJ3arfx1rmLcxI+i9tNv4oUTli2l4=;
 b=Qi+L9PfgvtxroV4/+3LSFNlW7ULHZ2Jt4Vy9nkYy+LxIhhjMb5bT1T0viC1nGapRZZ
 yC8A5qcXkswINiUOjPIVTx9VkJYlVvIhsKrHFM1znARiI6XaToYEuxkU7qAdFmxOL//f
 /201wFv57/VYqmlFpzUf2i2IEF94m1LneSlTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405032; x=1701009832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyqG0C9qZI/rTzSJ3arfx1rmLcxI+i9tNv4oUTli2l4=;
 b=ie9cPXgsUufAqM6jlXRhf2BIZpxYuVBsNtMfeJpz+OamxPHicB2mluKNDqWO+X3yMY
 +j5vC+F9xTcAMkqrHIvkTXGWLFGYqRp2LC0aLVAI7QIuhM3nPSBRkSFT/61Yc9vpT65h
 H2OFkd477tIdLf/RH4NAVyA3cW9ZOUii75Rb+LzCwO6B1KydyDmbMBIJy+qHjP0VTQhV
 ddJm8RXZh/JB4eNiHxpKLZ5iZm6R2sExN6pP+TnT3qmc21ElQPR5yONaglt2axFEx30G
 ceKt2Ek55+0rvX+SG3ITPphsbE7pbZabOtlKHGO4PrqyNMJIyJq+4NHztJQvYzXB4i1X
 o9dQ==
X-Gm-Message-State: AOJu0Yyo85PvxCMD1WGrVoy5O1jNsot+hdmMSiKS74kp0J/FUl6vNGgl
 BQMaoXWYTojtc90/ZsrTYs1kCT9sy2+C+uKu+ysAzg==
X-Google-Smtp-Source: AGHT+IHALiq8V4MZJoG73GxYKvwXcMIiMPMsXT0KMDGYh/+wL18Wt1JyBsLMVnojxT9iG+JgW1GO6A==
X-Received: by 2002:a05:6e02:eea:b0:359:3ff:17c6 with SMTP id
 j10-20020a056e020eea00b0035903ff17c6mr9676859ilk.4.1700405032476; 
 Sun, 19 Nov 2023 06:43:52 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a023505000000b00463f8b3e34asm1511196jaa.23.2023.11.19.06.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:43:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 4/4] bootm: Support kernel_noload with compression
Date: Sun, 19 Nov 2023 07:43:34 -0700
Message-ID: <20231119144338.630138-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144338.630138-1-sjg@chromium.org>
References: <20231119144338.630138-1-sjg@chromium.org>
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

It is not currently possible to execute the kernel in-place without
loading it. Use lmb to allocate memory for it.

Co-developed-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

Changes in v3:
- Rebase on to bootm-refactoring series
- Support compression with an lmb-allocated region
- Drop patch to disallow kernel_noload with compression
- Drop patch 'bootm: Allow omitting the load address'

Changes in v2:
- Add a 'success' case to the cover letter
- Redo how the arm64 support is implemented

 boot/bootm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index cf07c042fbca..301cfded05cb 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -629,6 +629,24 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	void *load_buf, *image_buf;
 	int err;
 
+	/*
+	 * For a "noload" compressed kernel we need to allocate a buffer large
+	 * enough to decompress in to and use that as the load address now.
+	 * Assume that the kernel compression is at most a factor of 4 since
+	 * zstd almost achieves that.
+	 * Use an alignment of 2MB since this might help arm64
+	 */
+	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
+		ulong req_size = ALIGN(image_len * 4, SZ_1M);
+
+		load = lmb_alloc(&images->lmb, req_size, SZ_2M);
+		if (!load)
+			return 1;
+		os.load = load;
+		debug("Allocated %lx bytes at %lx for kernel (size %lx) decompression\n",
+		      req_size, load, image_len);
+	}
+
 	load_buf = map_sysmem(load, 0);
 	image_buf = map_sysmem(os.image_start, image_len);
 	err = image_decomp(os.comp, load, os.image_start, os.type,
-- 
2.43.0.rc0.421.g78406f8d94-goog

