Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D8CC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5464883845;
	Mon, 26 May 2025 12:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dBh2q2Px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0622D836B8; Mon, 26 May 2025 12:16:50 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8018383A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3dc7830a386so7912645ab.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254606; x=1748859406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WKdCzvEHg64lhohGJ0MsCbsdsPePLXAhN/2KtUm5sUA=;
 b=dBh2q2Px85RMd/+036gTNZ09adRul+ReH8CL8haD7ySMK30dNHy8ddwDfHCrsVGQBU
 FyXrZ+6c9nBrbhqaggXg+FFy5yGdY+DuzTSErtOwzefIJHfU22Q55ET5OEbH8B4oFWOA
 9BlsYstR52qiE49HUW0NRAlryuv6cxH71enCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254606; x=1748859406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKdCzvEHg64lhohGJ0MsCbsdsPePLXAhN/2KtUm5sUA=;
 b=Ya3TVK0anTtzZxJO8zw7VO18eQn7jltm9g0SVsNSt/yS3k4Pzx2EmFYKB2bH3O+S/y
 58BdRUQXVq92KCQqu006vUxsSloBCLH577LMRxJeiFD7MGabJU62HMoqfbF2sOGjFaWD
 FHL6RDNrC3KBYvltDa3w3TN/KJvGb/mtrIEzhJstfmTm2TGdGAkj/qKwxF5pc9F8M6mb
 K5dw5Fit9f+rROv4Ocy+H6JZ3+ejQ26IbnDuiq8WpEtd1peOd0GtjK1NWuwkls+Oi0kJ
 in4KPiSNqoTBuAD6ejd8SIsrfc3rA768cuTu7t/A2dkVgdyBOSaOQfYpJmz11tMx80wI
 Fkkg==
X-Gm-Message-State: AOJu0Ywx/nBnIsFrCLtux60Y2zBGJIN38jkiasVTK00fTYhAjk5/Celh
 4d152MRr2mQKg3ZwrxOBUE1020ghXuS0j0wwPYOF4D5bcguEx81e7mJ7U4VwUqT2jUthPUbYoAW
 bCcgysoNN
X-Gm-Gg: ASbGncud9q0nTZ7hgFAibwksHfgdqvecrdopiaw2FnZN8pSoGwPNh09WAR2RzX15HW1
 rMSxm6F0UN+aGg8+YTHOlhaAccqMjIKFo+BEvk5rgpSwGrfo7OvzJCKGes75uFSPm46h50ojIeQ
 kdMlp6Zgul/UUs2cpm5N+FiAMRh/czf7d0hhQS5P1435xZhIW6QNGaOg1C+FlZn2zFXpJBl+hN2
 k4dm2zMVMYGIE6W6D7vUQDk7PZygakUb6nOl3yCWol+gneOSdHdGTffa5ILEOLeOjkegtZ76phB
 2nIkemO0Y3dTCQ+QnrkQ3jbMXCQBQF6fGu+zY4Nl+WkX2YoA9NKI1nlqZ1A1f9nEX7APM7++Fki
 wG8x61CZwbokW
X-Google-Smtp-Source: AGHT+IGYJNvsSqp2HVoi4Yz5kLno+1drNdIfjq2ck+UAgO1eUww5Ugsh19e1qZh2//9gysBWuhOotg==
X-Received: by 2002:a05:6e02:3c04:b0:3dc:76c6:4391 with SMTP id
 e9e14a558f8ab-3dc9b71b666mr67351005ab.20.1748254606047; 
 Mon, 26 May 2025 03:16:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 25/25] bloblist: Allow using a different bloblist address
Date: Mon, 26 May 2025 04:15:11 -0600
Message-ID: <20250526101541.3254628-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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
2.43.0

