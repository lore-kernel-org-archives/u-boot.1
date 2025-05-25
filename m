Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552DBC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF8A82BAA;
	Sun, 25 May 2025 12:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ICmGPakA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194D382AA7; Sun, 25 May 2025 12:48:51 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2087E83741
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so809519f8f.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170128; x=1748774928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPmCUCTwd2KbtblLqL0N5A0iCk8ThqwF4Zf70VZdFAA=;
 b=ICmGPakA8JbWLsB9yRDib8ZhNviF0qIeGwEp0i8klz0PjiyMwZdfuYCJ+RePTlXBxa
 7APRA9wWLrEW/xnSC7WeBIEPOuCl/VC09oMVs81v+vN9Hl2gRQx95vRY3m80KVmz0YNq
 ++k/BpdIpkgE+XCrstMzBGH5FwoXIyPOWTvV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170128; x=1748774928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPmCUCTwd2KbtblLqL0N5A0iCk8ThqwF4Zf70VZdFAA=;
 b=Jah4bQ8sDRmq62m/ANbkyyvF+mEVdFfNMx/g6BCpZ7PNkH3j4T3n0yfhbnKo0Qbmpb
 Qjai6XX+JiQfM5N6KMIvdNHozcVE9fSAls7ydctL8vTgrYKR0UclxNXhYYiPRujtC2AF
 +m0zRvbk4EiML5CpEcb3nEzGLs7rNRTxByVPsbybPv8pzJ8l9KrmSXsYQ8Fmc4Bts0zY
 TOf8Prhce9w5notu5r6Iby8g9P2DOpFUHF+l1WW/mDW1bmpBPsZsoKOfPP3VjRR9SdEf
 uuitPe3eEqHxeofGA5wlOtj+YcnaIujwDgkv+wUaMYHe0zp7F8Sgs1lF2gjpz6xUJvk6
 JQ0Q==
X-Gm-Message-State: AOJu0YxmvbwMzwG1M9looxfLF9XM2R+p/vb5y8dDhnh0e4zRkun+mQqE
 8KPvagtrN1Q3i87rPS92ei1+SWbQe3lEGUZWYzVDJbCkbpKBDWAk4mNyraTvoNVHqP4One0RUhk
 g2gjIFF0g
X-Gm-Gg: ASbGncsbp4Sz25uKrCtTaVfLzArPWRMX115uOkoXBiFQ1Ul3fIPzWciGDZqnyf3DGGS
 LY3BULAFHfmheSU9R8kvAVm959Qd6BrjiZhJckvWIEUyzjrtp8+btvdTgxpOSecK5sPKBcVHsVY
 9WonXVOah2VHn9lK1L+tgrfJlBeab0CenT1M9tAzuubxGRlumC75f6rZ4edbfIY49Kz3fhdt+sy
 OuswVCnQitVt3DPo3t35i6MBybYZk8dd4CdSVfly5g0hlg4qeJOYDx9py74fu0oc09UKjbtBAiT
 NB22WTMKJwvTm8ZJSfbqQEyzlc6ZQYIpv4yVmHZUFsB1V63EImux1rQhtbmIUhiEax5rhho=
X-Google-Smtp-Source: AGHT+IHYMqBwW8oImkVg7g0eJQsQ3xODx35MXHzqR6Om2ZGgir6zOuxZkrbdYP2QqvFpVAd69hU90Q==
X-Received: by 2002:a05:6000:400e:b0:3a4:cfbf:519a with SMTP id
 ffacd0b85a97d-3a4cfbf5273mr3581173f8f.31.1748170127755; 
 Sun, 25 May 2025 03:48:47 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 25/25] bloblist: Allow using a different bloblist address
Date: Sun, 25 May 2025 11:48:01 +0100
Message-Id: <20250525104801.1440260-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Move the actual relocation code to a previous board-specific patch

 common/Kconfig    | 20 ++++++++++++++++++++
 common/bloblist.c | 15 ++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/Kconfig b/common/Kconfig
index 17539079f90..d2aa02edab6 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1157,6 +1157,26 @@ config SPL_BLOBLIST_ALLOC
 
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
index 197b609fc23..0ca9fbf8ba8 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -515,9 +515,22 @@ int bloblist_init(void)
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
2.34.1

