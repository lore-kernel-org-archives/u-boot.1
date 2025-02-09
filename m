Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF13C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7FE809A5;
	Sun,  9 Feb 2025 22:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kRvvQWeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9A880836; Sun,  9 Feb 2025 22:16:59 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 743D980A55
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d14dec3236so4811955ab.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135816; x=1739740616; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hep2VvEsoy5z3iAWDNil0s8t8fa9+URSEogdct4qB2c=;
 b=kRvvQWeSwZXcI3zCl1Gd/c8iSSaGZUsvEpKHtjIwgOa+LuuFMEmdM8QOc0GlaJq38H
 IoZqp1KMzanaFxRpqSBJAioEbj+AZjpZhL6HTLlbYy8t9y0Us6Lwh+ALhit2xPrY9l7R
 Ml2ZJil96iOmaDnjb1GuAnEN3Q4QCkrt9Hi2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135816; x=1739740616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hep2VvEsoy5z3iAWDNil0s8t8fa9+URSEogdct4qB2c=;
 b=pmf8Nj2i4XMDl9eisrutnAS10g7neaaQo7bTLffPb+YybOLGV7Qh6CagDpq2r8qtT1
 MPeSdEYetp7oY+fUhlGGTcCWNmeTjVDhkZpe+E5Lo9pkymDSuvKxduLQb7Ks+uvVVYDC
 hZJ5YLlCzGAi7NpbKOOFSmqOdBV36RAOBC8eWhVdl2ChtmsxEwR+ovh5RpWdgKWKqaWP
 jY59C0GZXqLjhhbVJ2uNYaqVYrJkyrdThog2M+JyJdZupo9Z0iX8k/k5fM38/iqL33cg
 y1f2R16zZnGO1YRdCEp2tyVY9oiWnhFEvqWPnEFRBQB4kysXkNu8Zt5cVMNuTalvwPKe
 Z0wg==
X-Gm-Message-State: AOJu0YwpuwzXaMCwNQsSZIXRQJ17tdSTsu7sMRD5p0Mt92TlfpN9LLE7
 idzEfvbYGxErzFFzNUkfQ+zvYEEnFsYhIKWs/BMfFPaKZtt+3bRvpYl62UJXD+Hg46vAXNAEf0s
 =
X-Gm-Gg: ASbGncvY7MhPJ+oSaJ1hsxBwBVD25ffGnvSqVIQmj0RSjkIhHzEBuongI+81JTDCoIt
 j60Y/qaiT/FHX2d8IXoz2CIkRAXecy6DdO6razUXEBTH6ZSWMM3O62LZ+pdA3jiMGu3/LK0Dr+0
 wc6tq0uqtpT1thMd/d7zD17ME4FEgBdGnY8zlZbAaZVvKVhwdM5sqfNVEFU/88M5lnnuDTHAryO
 qGjI879ECpvHik4w9Kya/o4WecIqsA8EUBwDL9ULCBeeY2unwgMXadgxLvaj+l9Wv38AU8Edc3m
 nWf4ISJ0IZrFnifLqnUTEnY92K+U0F+c+zz/vUgIsjPLLa0o6OBr
X-Google-Smtp-Source: AGHT+IER8Zx33TsNdYdxag2mTOgPI4SW1PrqpRgZgWF+FmTZVPn4xLg9Pw5DYcqEs2cI0CYJ+lHdmQ==
X-Received: by 2002:a92:c241:0:b0:3cf:fa94:c7d with SMTP id
 e9e14a558f8ab-3d13dd4ddb2mr86899245ab.9.1739135814589; 
 Sun, 09 Feb 2025 13:16:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 35/35] bloblist: Allow using a different bloblist address
Date: Sun,  9 Feb 2025 14:14:56 -0700
Message-ID: <20250209211502.2299245-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Where the bloblist is located in internal memory and TF-A's BL31 blob
removes access to this memory, the best option seems to be to relocate
the bloblist just before running TF-A.

We can do the relocation in board-specific code, but need an option to
pick up the correct address within U-Boot proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Move the actual relocation code to a previous board-specific patch

 common/Kconfig    | 20 ++++++++++++++++++++
 common/bloblist.c | 15 ++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 0e8c44f3f74..962e7fd76eb 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
 
 endchoice
 
+config SPL_BLOBLIST_RELOC
+	bool "Relocate the bloblist before existing SPL"
+	depends on BLOBLIST_FIXED
+	help
+	  Some platforms locate the bloblist in SRAM in SPL. In some cases,
+	  the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
+
+	  Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
+	  before leaving SPL.
+
+config SPL_BLOBLIST_RELOC_ADDR
+	hex "Relocate the bloblist before existing SPL"
+	depends on SPL_BLOBLIST_RELOC
+	default BLOBLIST_ADDR
+	help
+	  Sets the address to which the bloblist is relocated at the end of SPL.
+	  U-Boot proper uses this address when it starts up. Note that U-Boot
+	  always relocates the bloblist again as part of its own relocation
+	  process.
+
 endif # SPL_BLOBLIST
 
 if TPL_BLOBLIST
diff --git a/common/bloblist.c b/common/bloblist.c
index 7eda94ecdf9..60c23d604b6 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -503,9 +503,22 @@ int bloblist_init(void)
 	expected = fixed && !xpl_is_first_phase();
 	if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
 		expected = false;
-	if (fixed)
+	if (fixed) {
 		addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
 				      CONFIG_BLOBLIST_ADDR);
+
+		if (xpl_phase() == PHASE_BOARD_F &&
+		    IS_ENABLED(CONFIG_SPL_BLOBLIST_RELOC)) {
+			ulong addr = IF_ENABLED_INT(CONFIG_SPL_BLOBLIST_RELOC,
+					    CONFIG_SPL_BLOBLIST_RELOC_ADDR);
+
+			log_debug("Using bloblist at %lx\n", addr);
+			bloblist_reloc(map_sysmem(addr, 0),
+				       bloblist_get_total_size());
+		}
+		log_debug("bloblist addr=%lx\n", addr);
+	}
+
 	size = CONFIG_BLOBLIST_SIZE;
 	if (expected) {
 		ret = bloblist_check(addr, size);
-- 
2.43.0

