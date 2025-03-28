Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2DDC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0595C81F4E;
	Fri, 28 Mar 2025 16:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aj7klgju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE9B81E60; Fri, 28 Mar 2025 16:44:26 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9597B81E60
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:44:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85b5e49615aso197926039f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176663; x=1743781463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O5/vxFYJGIeF2Hp73g/qced0sjQzKCQ/OoGxTtOFHjs=;
 b=Aj7klgjuT2sBs+Qn67eZtnEqvVyA8LpblaGTD0G4MUoYm6abUSbetMVQkzcEA1tPkz
 oE9LFFTlQoa2qtRKJnuyqsuC43S2UF+gS+scNENp7fEirZtKqrdunyITasUikbRXC1pE
 5gBTWZFM1tILPYfgoD7ioAKXaVeHbsGJ6mBHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176663; x=1743781463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O5/vxFYJGIeF2Hp73g/qced0sjQzKCQ/OoGxTtOFHjs=;
 b=j2NVA01DsVEm6JO6OcOp6tqGvDQ3m/PcP1aXap4+APiJoaLSmq+Yq6R6wIJNmPxJ+Y
 a/rgmR9SgA1ckBshq1bAzj7Qz7JN/2Ja/r9Td9pelOp5c8+4gsetiRvOAibT4aTjwT8V
 txi6Nbzdupx1EMMhYA2pRciifRFYEn952s7H1MbFPWJyRFk4jM02qfVHR9Y1Xh+/uMbW
 oyhXYkes5UKbieDF+HqJdgJenmQn+8JXkbXujRr+3bryReedETj+C3+paTmPXbhVgUaf
 KZZek65FIz6/U0u4I88+SsqMcqCPfFHOUK2q3LEf44P9IHuzi+LSIejajS0ug1Avvngj
 I3KQ==
X-Gm-Message-State: AOJu0YwXexES9itbxpkC94UX6M1AU2pFuZra5B20UhS1ZHOcxcyfDbrX
 AxpdePNiHbwM53yzKzb/KFfJNpHDYeGkTWbFWZNzbtilGU48H41GfW2o+5zoU0MsPXX88uRXvVM
 =
X-Gm-Gg: ASbGncuMcOb2LhjNtnJiJSrdNttwn+K/82U3EvJ0KFfN3CDCdb4yfu4ZvQiUs5m601H
 mqOOfPcSfidxn6y7p+EUlM8p53bWM/WPmGX2dVZjGi9NS2Vs3HIp+ySDxdfLPz3df4tBCuSlVzJ
 mRbL64gTXV355myIFow3c7VNnLU6kOlNn1Rxvw6nL73YyEForBsNerqIs1x6Q7b4WxilRJmT8ue
 lZh8PDdQXD2MLKGJZT6Z2JqNdjrosD3f0dAAllHBUsKefy0k3Hmh3wn2aDCUkg4uLDG49PBJYP4
 xrq5DguEWUTfYxArZluwLB73lT03KbLqHE4Gjnq8fiKdPbIeyg9CUxHwy99n3GFos6vurJhluin
 7DuxgRw==
X-Google-Smtp-Source: AGHT+IHZxrea9afgY6mmGAy36TyrZRTouzG+d8kauO3dN4fsBJOXzUOyknloYAfg5rXHgnLLNkkiaQ==
X-Received: by 2002:a05:6602:4c83:b0:85b:5d92:35b9 with SMTP id
 ca18e2360f4ac-85e820552bemr1004504339f.2.1743176662611; 
 Fri, 28 Mar 2025 08:44:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85e8ffd6b56sm42174439f.17.2025.03.28.08.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:44:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
Subject: [PATCH 2/4] fdt: Introduce OF_BLOBLIST
Date: Fri, 28 Mar 2025 09:43:56 -0600
Message-ID: <20250328154401.3563921-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328154401.3563921-1-sjg@chromium.org>
References: <20250328154401.3563921-1-sjg@chromium.org>
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

Add an option which indicates that the devicetree comes from the
bloblist.

After discussions with Tom, it seems we are comfortable with introducing
this option, ensuring of course that the transfer list is properly
supported.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/devicetree/control.rst |  3 ++
 dts/Kconfig                        |  8 ++++
 lib/fdtdec.c                       | 66 ++++++++++++------------------
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 0233945f8b6..d80f4d420a9 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -137,6 +137,9 @@ If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
+If `OF_BLOBLIST` is defined, the devicetree comes from a bloblist passed
+from a previous stage.
+
 If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
 passed from a previous stage, if present.
 
diff --git a/dts/Kconfig b/dts/Kconfig
index 6a5141b56e9..04359a4d7b2 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -167,6 +167,14 @@ config OF_INITIAL_DTB_READONLY
 	  If initial DTB for DT control is read-only (e.g. points to
 	  memory-mapped flash memory), then set this option.
 
+config OF_BLOBLIST
+	bool "DTB is provided by a bloblist"
+	help
+	  Select this to read the devicetree from the bloblist. This allows
+	  using a bloblist to transfer the devicetree between U-Boot phases.
+	  The devicetree is stored in the bloblist by an earlier phase so that
+	  U-Boot can read it.
+
 config OF_BOARD
 	bool "Provided by the board (e.g a previous loader) at runtime"
 	default y if SANDBOX || OF_HAS_PRIOR_STAGE
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index f09c9926a7a..833f8aca3ce 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1689,55 +1689,43 @@ void fdtdec_setup_embed(void)
 
 int fdtdec_setup(void)
 {
-	int ret = -ENOENT;
+	int ret;
 
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
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
 		ret = bloblist_maybe_init();
-		if (!ret) {
-			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-			if (gd->fdt_blob) {
-				gd->fdt_src = FDTSRC_BLOBLIST;
-				log_debug("Devicetree is in bloblist at %p\n",
-					  gd->fdt_blob);
-				ret = 0;
-			} else {
-				log_debug("No FDT found in bloblist\n");
-				ret = -ENOENT;
-			}
+		if (ret)
+			return ret;
+		gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+		if (!gd->fdt_blob) {
+			printf("Not FDT found in bloblist\n");
+			bloblist_show_list();
+			return -ENOENT;
 		}
-	}
-
-	/* Otherwise, the devicetree is typically appended to U-Boot */
-	if (ret) {
+		gd->fdt_src = FDTSRC_BLOBLIST;
+		bloblist_show_list();
+		log_debug("Devicetree is in bloblist at %p\n", gd->fdt_blob);
+	} else {
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
 		} else { /* embed dtb in ELF file for testing / development */
-			fdtdec_setup_embed();
+			gd->fdt_blob = dtb_dt_embedded();
+			gd->fdt_src = FDTSRC_EMBED;
 		}
-	}
 
-	/* Allow the board to override the fdt address. */
-	if (IS_ENABLED(CONFIG_OF_BOARD)) {
-		void *blob;
+		/* Allow the board to override the fdt address. */
+		if (IS_ENABLED(CONFIG_OF_BOARD)) {
+			void *blob;
 
-		blob = (void *)gd->fdt_blob;
-		ret = board_fdt_blob_setup(&blob);
-		if (ret) {
-			if (ret != -EEXIST)
-				return ret;
-		} else {
-			gd->fdt_src = FDTSRC_BOARD;
-			gd->fdt_blob = blob;
+			blob = (void *)gd->fdt_blob;
+			ret = board_fdt_blob_setup(&blob);
+			if (ret) {
+				if (ret != -EEXIST)
+					return ret;
+			} else {
+				gd->fdt_src = FDTSRC_BOARD;
+				gd->fdt_blob = blob;
+			}
 		}
 	}
 
-- 
2.43.0

