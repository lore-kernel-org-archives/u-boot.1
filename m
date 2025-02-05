Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE04C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 02:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01A28070F;
	Wed,  5 Feb 2025 02:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gHj3lmp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543FC80A23; Wed,  5 Feb 2025 02:58:04 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 457B1807FB
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e22b2387cso4322929a34.3
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720677; x=1739325477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqJSSidUfwcjYVe7rT5zWk8RDuNspcw3iJvurVeVv1I=;
 b=gHj3lmp1icNSJGQGLx/WPhP4HWwPI4V7Xx+DdQSk9HgtDJ46facBwkIFI0HN0/WBrH
 UAzKMNShQdSFYaWm3JDUWj5u3HdY2zC9i60I997V4wdFLVuIJi8G2yzh6F3h9doCEeNF
 usAc40/3R4RtH1Zxkq9vUufo+vtPZfJy6xCis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720677; x=1739325477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqJSSidUfwcjYVe7rT5zWk8RDuNspcw3iJvurVeVv1I=;
 b=u17MVlwt5vXHnqk3kktyRHHcOU4trYBQoGvW14qtChOUCXN8zRI2ggu+GWX7m2tXpg
 I/L17psDQDxwnc9Fhc28eQw9QSMy6koE4znkuUtMoob2JpyvFtSpYFt8EeaJqV8l2J3D
 izt5VgDP0ZXCDEJxHCZXO04s2kQmbDyyNcifLU6y66Ap7vth8G9p9aiXNafALfF7L3Ik
 nepU5SJy8EH0IEmCjtNWHcXSr5tCdBUpjKusO2Tbp3aCHmCj1Dd4/53zQefWsEoXJspd
 CQUC8Rc2nAgujUMszli29DN6remlODSZy9bIwZNPS+BB4W6qCqmQ1B97M/tkzkFnitLP
 vMSA==
X-Gm-Message-State: AOJu0YwgQONFLjJDhxebhR4y4L8kAAD/s3Vr7UeOzc0C7ERqx3nRVwO/
 NgfmOeyK+P6JQ5I9RFYNKTaT7iTq/v/HG4NmcG3U+rORBt/p65i1Jtm/NUBIQGfgxGdDoK4+Tr8
 =
X-Gm-Gg: ASbGncutiCFS33brkrriO7IXHLVhwUUy4hV74dBmvsm99yOUdQsHcenvQS3eTqwA/NP
 VBTEUZT+YvERYJ0vbtbQ+33/wKHF8T0nHnFNQfDcM+Tz9N8lJCpnyfy2P510MrQws40BXXIQZFh
 +TOdiVQ4jL6uNDyZiNoXmqe4+FzVp8yV+fg6q9KZ1Eqiv93hiBcZ47adkoAatIyFcKuGTw+GVEG
 f3ZGmzqj4k9qVGhK2bqBMgJBLKXYC8lb9SgJ3yoeEhMx+Y9DvAewjRNsVAzYOXUa/jfiF3hwFFH
 tPpeGzwHmSv805CoB6i2z2pk0Ejx513j8QFXXW99py2w9PXUkdRp
X-Google-Smtp-Source: AGHT+IGwoT4ilQJRfjI0uxJe0pTdeUzvsOnAP0GbTTPkCJCN4yDicoksBBsUPeGxSvG2aXiLtXAJ3g==
X-Received: by 2002:a05:6830:6603:b0:71d:ffa1:6b11 with SMTP id
 46e09a7af769-726a4289b1amr908257a34.28.1738720677506; 
 Tue, 04 Feb 2025 17:57:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:57:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL phase
Date: Tue,  4 Feb 2025 18:55:19 -0700
Message-ID: <20250205015606.2686149-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

Add an option to select this behaviour and provide a relocation address.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Kconfig    | 20 ++++++++++++++++++++
 common/bloblist.c | 15 ++++++++++++++-
 common/spl/spl.c  |  9 +++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

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
diff --git a/common/spl/spl.c b/common/spl/spl.c
index e7157df1ff9..84543691cde 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -841,6 +841,15 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			       ret);
 	}
 
+	if (xpl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST_RELOC)) {
+		ulong addr = CONFIG_IF_ENABLED_INT(BLOBLIST_RELOC,
+						   BLOBLIST_RELOC_ADDR);
+
+		log_debug("Relocating bloblist %p to %lx\n", gd_bloblist(),
+			  addr);
+		bloblist_reloc(map_sysmem(addr, 0), bloblist_get_total_size());
+	}
+
 	spl_board_prepare_for_boot();
 
 	if (CONFIG_IS_ENABLED(RELOC_LOADER)) {
-- 
2.43.0

