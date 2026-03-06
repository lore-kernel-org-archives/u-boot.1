Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E82F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC1F83FE1;
	Fri,  6 Mar 2026 03:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VSaPJubn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5AA83FDE; Fri,  6 Mar 2026 03:37:20 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC6DC83F9D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-89a00e8dc04so48317816d6.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764637; x=1773369437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJK5MXidn+vtvfwGW+EFaiu6/Sf5UL6ICJD0QJZSn5E=;
 b=VSaPJubnXh8Cp1SxkcE5ElKE9NNc/bUC+l+piU1NccxV7Z4eYKmOwkSnCGZ5SaHah8
 BSJpsNRe7RN4uJM8Tx7U+z5mZtJYh9ts2foF+VS3u3cmoMEt4Gt0sglCzagG72pe06wF
 2pf69aSJ3J9WSQyc6dzfuWbjl5uBTia1xNgFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764637; x=1773369437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qJK5MXidn+vtvfwGW+EFaiu6/Sf5UL6ICJD0QJZSn5E=;
 b=oshUpB6kQx9CefXN3k6KUXgTBHehLbeJQ00NK2fwd9aqax061YAk5TkbiTmLL/4YL0
 WwLh7cI2VX+nVEGKhJwy6jm4ZTE8Vli7nMlCHhiGylNkvztD7VHkVP4StTTWzwBE2zd0
 hD7upba/kaYbEaDZObYgGwefcugKDz9qWMWa3OsT+SIpWnOAlaIzBr3RMkVdo0uKqhaV
 TiibjGGLfNSaKKflQpNaG4V2momC68V2LfB89dHX9sGogCHCI1wchA/Jok2XcsYOlxJL
 1O4imZ3zu/0zr6ESawo5A8GGblgOrn2XibuHIne3ROP+KQDEWBqnJb8y2Ut35V0pPAUA
 Sh9A==
X-Gm-Message-State: AOJu0YwnwQolYrihqqG9IdJ8FK/C+QTmRjM+RDZn63awaMalPcawpNNm
 2iN/XhqHs+erhtGTB0mjICCyNOv5/sINkC+Jj/KKGNr42WD/N5eqlKBqU5luQqd/8R/s8rTrYdq
 Vvyc=
X-Gm-Gg: ATEYQzxkR9HNWs1zEY/GLY574p8PlPH4UyikGiMLA28vs37Jl4iJqyZ+Sw74fsXmDvR
 RBkEUC2/Zl+KteT/1wgxh41BdcOr8Vlu9w3GxYSRGnXEax8PB5aZiqbn1+2lSiV0+SxKpHf9YMG
 Lkta/CJkka/BhM9XGnDh9xAmWFiFNWpR3D7snPkc4CoQ5qwLmRNjBU20ZdCLS2FxM2yhGTFT/u4
 EIaTxVyL+//7ZjAg3YBv7ZTE57xBspT67sOC/e7sm9/PGuiX1H/5d6x11mqW6KT9YEDSwJ+/kkq
 i+K+Z5O+HRw2J6mZMegR0n+gSQu6o6xOv5vskcCiJqjY64oQ/qwyvwjzEWtaFU8RFT5RjV1mU9D
 oHUS4H0JQ+iI0Vh4GCAyHrK94Y5AgKl1+3Hv85rx3sG3K1sRveJWnSCv3VAzqEBqwtNFdu2km2w
 XaoyzJNAGjeh281PEotQ==
X-Received: by 2002:a05:6214:20ec:b0:89a:894:9cf with SMTP id
 6a1803df08f44-89a30a1e8fdmr6471146d6.1.1772764637081; 
 Thu, 05 Mar 2026 18:37:17 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, uboot-snps-arc@synopsys.com
Subject: [PATCH v4 09/17] arc: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:18 -0700
Message-ID: <20260306023638.2678886-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Replace the open-coded printf and bootstage_mark_name with a call to
bootm_final(). This also adds board_quiesce_devices() and
dm_remove_devices_active() which were not previously called on ARC.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

Changes in v4:
- Pass flag directly instead of using BOOTM_FINAL_FAKE

Changes in v3:
- Add new patch for ARC conversion

 arch/arc/lib/bootm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 91bce5235a5..91165a06a46 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -50,17 +50,13 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 {
 	ulong kernel_entry;
 	unsigned int r0, r2;
-	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
-
 	kernel_entry = images->ep;
 
 	debug("## Transferring control to Linux (at address %08lx)...\n",
 	      kernel_entry);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
-	printf("\nStarting kernel ...%s\n\n", fake ?
-	       "(fake run for tracing)" : "");
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+	bootm_final(flag);
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
 		r0 = 2;
@@ -72,7 +68,7 @@ static void boot_jump_linux(struct bootm_headers *images, int flag)
 
 	cleanup_before_linux();
 
-	if (!fake)
+	if (!(flag & BOOTM_STATE_OS_FAKE_GO))
 		board_jump_and_run(kernel_entry, r0, 0, r2);
 }
 
-- 
2.43.0

