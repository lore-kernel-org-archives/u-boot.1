Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154AFC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C6481E6C;
	Fri, 28 Mar 2025 16:36:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lpbEEGjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A848981E6C; Fri, 28 Mar 2025 16:36:54 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5DC0820A1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b4170f1f5so65213539f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176209; x=1743781009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jH7ClcvybM9ysBIy+DhSao7D4TVSC47VuqJs6Hzy9KM=;
 b=lpbEEGjTY8pFHb4etlvS9KuHlk/VDg23G8MLKo5iK00vKRYVAFHFY0FMXbi+aacKBx
 s8pLU39qus57XIZC9y1aGysNH3Z1uGBouqtrfWLplQTxtZ/Cl75EkiAgvO3QAk7LdJgd
 5Gp0Zpflg4lzLq47GIYiw+uee/JSnn3Aamuyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176209; x=1743781009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH7ClcvybM9ysBIy+DhSao7D4TVSC47VuqJs6Hzy9KM=;
 b=XSfGJLK5Ub0QcxZSaRwYwc02awc0mQK7dv1gC2PKxVIcaeX8IHmrrUYaGSz62RQvyO
 XLXEx9fC2hJHiA7hoC0RkxnYWeeaHdTtMxicsNRyE6i9y67wREcYXRRCvPyETxI9AGN2
 yYsqFwn/PnfeXGL6RCOGdTVUQac9CSrj/0gEzX8+aekumzM+H6+vkd+PiMhKjtx5IoH7
 A2Ucw6tj25Sxr8kmXU3Q3hrBvDBmlAAgGCLcPPtpIMJEjz2OgTdVLERFJ1IUNECgxgZV
 PnQLn0nBPoE/I0yU/2vRswcxLi//ACc/DY7Kq990jsLdrasaD9AsBSWhaX5f6afabKWZ
 OVcg==
X-Gm-Message-State: AOJu0YxKV2ngTKjY+m4JFprhPP4GrlbsS8M3lg7QkrigJrfD5fQ8ZrJX
 JQsdfaY5U8AyeHkD1IzpHo0yts+T+ZIADN/mSMHFDFi8i1lf4dKADNICdF5srei6R+Ekezzl0qY
 =
X-Gm-Gg: ASbGncsAeb6PI0gN298NUljGhe+WM/1cNhNabPodhn44eBYTazVNIbK8/V8PUCKLw7D
 HOGlxkAv8/WFBmP6uEWBE4t/51JrmNxytkqWg5HW8sfl/3JftWSlu05KvjLGfZUiNUZ9Qpsg6on
 004xuQIwWaakuiNh8ugMDRIhZ1TKM5MAMbtjdKzba3PE0c8U3kI5YoJJJtxDjifkzfsZzN3PC+Z
 6GjQn78D5OdKhc6X3ZL/6wD0GciKA8M+961se3Y7FJRWAyMJrJky5Nm6mKk1a6kiPmZizu6liw+
 aU3JNu8EUl1AuIpRI7LdjUNZqOqY9KEJLAaRdOCiXdjMn10VwELuT+ZTBYZwN+VMWv+ZFlyfsOY
 tpR+Ppw==
X-Google-Smtp-Source: AGHT+IFHs3lJkSzCd6xOAOmYEFOLPwf7EWR6Wi3+OEejC3MVrZE3TW0BJVuie+IXNOItkXyYzISWew==
X-Received: by 2002:a05:6602:380a:b0:85b:37eb:f466 with SMTP id
 ca18e2360f4ac-85e820550camr894196539f.1.1743176208868; 
 Fri, 28 Mar 2025 08:36:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alex Shumsky <alexthreed@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 31/31] bloblist: Allow using a different bloblist address
Date: Fri, 28 Mar 2025 09:35:11 -0600
Message-ID: <20250328153522.3555472-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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
index 7685914fa6f..778ac6275c4 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1127,6 +1127,26 @@ config SPL_BLOBLIST_ALLOC
 
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
index 3f8c7f669a7..effb38dff9c 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -516,9 +516,22 @@ int bloblist_init(void)
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

