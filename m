Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58781C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EF383A84;
	Wed, 28 May 2025 14:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZspL6Dxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D733C83A61; Wed, 28 May 2025 14:33:35 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB6DB83A5B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d91db4f0c3so14138355ab.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435611; x=1749040411; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kXKBuIqlRGwJZa7XmHOWbOokzhIaI5twSrLuDTlL2w=;
 b=ZspL6DxqNoG/bjZFLMT1GmPST/B4ChMBWXMqPvy4tM+UcHQoT1CCA5Xwegz8JGDVM2
 ocSpm/s5UGyFTg70A8dCz4cQfRwquRes1qXp136bBGfALGLRj3zjiBaxuTZ+7hPEd7Jq
 1yte9C9Fd2JO+Xdqht4bDOtLny8rv9oyaMHuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435611; x=1749040411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9kXKBuIqlRGwJZa7XmHOWbOokzhIaI5twSrLuDTlL2w=;
 b=ulDXpjwtCAQGc7uP6fNraoEF1YDOaV5zZdAB4zPQF39MdEpLwA8/+Vd72LLiikF3Aa
 yoOIhRCXi3OIs0IxLwA3nOzkuPlWolP7uB1POXZju8OR/BcN5YjyDrEIiSCcv5Vx0W4K
 9hR2XUnJTWjb86kfagn+PfHCFfWg1qutOA5/x9mEIl2XyAH9JaDFGNQ3E6+uBvEIv2v1
 LRZB5hx/ViCUniEQaTyZDxF4OcXUfw35HnPkKLX2G609a9aJUD1ZTFZNrN5ofAulr9nS
 iQWJXMK6cBRW+vo0/rKiBjt5YxnYfQklsEG9q/e+pbiLTyjuiAfyCfBmNqAVntJZEpy0
 LAxw==
X-Gm-Message-State: AOJu0Yx17qpivCI+hrAZeViKkg+OptMuykDgzNoKYy0f6XuAONatizyq
 VIfdSmeU0APgJ2uAwJwbXO8n2fiI1HnbEnJhOA0nbkRLQ1p6IQd0EOYADf83LP0/H1kl9/CEeCD
 eUOe8jYjk
X-Gm-Gg: ASbGncu8htrmkoZwCSR6UCNZ12DYCXYKDYTgsTxEiHeZmLvhad4zDNhtCGGANKQIqW7
 7p2VN75szhV92hjL+9lZ4wsLJNZ/RbUT/0FxgCUJhkQksRX/hOCVLHfS+nWH3ZZPW8TtpX6Kl5G
 4ssMB2xrBTtxqlRlAEHCSdT6wrTuyV+julBGsoVhXmPp3DTP34bc/QE+w3CzP8rFGHZq+ZGR1EI
 SlM3/tFJiUK6zl9WMEc+NfUJtzIyLlfy+LypnHdJdIAi9mHV4aief3ad/nfomVETvzGXxk1Pqr4
 NRZP3vA2SsQZrUywkbEkspq5/Xx1LtAcm8s3o10I25Vhg0BoS7LiSmBdFvBTHU1xeNHvlUH1Wg9
 SuHIr/YEd1uMA
X-Google-Smtp-Source: AGHT+IHn+A6/t8oCuxzTn4z2yoPngi8mXTri4n4KDxhtcOWzMy0hPju7KTWNPGRY2aQW3613Ksii3Q==
X-Received: by 2002:a05:6e02:4408:10b0:3dd:892d:b25e with SMTP id
 e9e14a558f8ab-3dd892db3a6mr21524885ab.22.1748435611286; 
 Wed, 28 May 2025 05:33:31 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v5 08/25] fdt: Redo devicetree setup
Date: Wed, 28 May 2025 06:32:10 -0600
Message-ID: <20250528123236.1138632-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

The existing logic for handling receiving a devicetree from a previous
phase is quite complicated. Simplify it in preparation for introducing
standard passage.

Add a Kconfig called OF_PASSAGE which indicates that the devicetree
must come from standard passage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Use OF_PASSAGE here instead of OF_BLOBLIST

Changes in v4:
- Drop now-unused label

Changes in v3:
- Add new patch to redo how a devicetree is set up

 dts/Kconfig  |  8 ++++++++
 lib/fdtdec.c | 35 ++++++-----------------------------
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index c544f948a15..57101bddabb 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -159,6 +159,14 @@ config OF_EMBED
 	  and development only and is not recommended for production devices.
 	  Boards in the mainline U-Boot tree should not use it.
 
+config OF_PASSAGE
+	bool "DTB is provided by a standard passage, in a bloblist"
+	help
+	  Select this to read the devicetree using the standard passage
+	  mechanism, i.e. from a previous phase in bloblist using arch-specific
+	  register conventions. If enabled, the previous phase must provide
+	  the devicetree, or U-Boot will not function correctly.
+
 endchoice
 
 config OF_INITIAL_DTB_READONLY
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..2fd6edde160 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1689,35 +1689,13 @@ void fdtdec_setup_embed(void)
 
 int fdtdec_setup(void)
 {
-	int ret = -ENOENT;
-
-	/*
-	 * If allowing a bloblist, check that first. There was discussion about
-	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
-	 *
-	 * The necessary test is whether the previous phase passed a bloblist,
-	 * not whether this phase creates one.
-	 */
-	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
-		ret = bloblist_maybe_init();
-		if (!ret) {
-			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-			if (gd->fdt_blob) {
-				gd->fdt_src = FDTSRC_BLOBLIST;
-				log_debug("Devicetree is in bloblist at %p\n",
-					  gd->fdt_blob);
-				goto setup_fdt;
-			} else {
-				log_debug("No FDT found in bloblist\n");
-				ret = -ENOENT;
-			}
-		}
-	}
+	int ret;
 
-	/* Otherwise, the devicetree is typically appended to U-Boot */
-	if (ret) {
+	if (CONFIG_IS_ENABLED(OF_PASSAGE)) {
+		printf("Previous phase failed to provide standard passage\n");
+		return -ENOENT;
+	} else {
+		/* The devicetree is typically appended to U-Boot */
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
@@ -1752,7 +1730,6 @@ int fdtdec_setup(void)
 		}
 	}
 
-setup_fdt:
 	if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
 		setup_multi_dtb_fit();
 
-- 
2.43.0

