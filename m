Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A7DC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1656874D5;
	Fri, 22 Dec 2023 22:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dq3BNKuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF0A874D5; Fri, 22 Dec 2023 22:32:22 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD82986FB5
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7811dba1d5dso154539985a.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703280739; x=1703885539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1V5UI6RajBlcMTf5MAPNP+BoyHTGfN0ZmIyzHUyke0=;
 b=Dq3BNKuoInoXoboa/2EqS6u6UQHA/Bm92F8qQSw5GlqpPkTJYbECqCBl5uBB3o0bTs
 KjjrjvNR5PNJXgYyinGVAPekh/CNfIMG3FhdNJblSHxMnVdACo6N2MkqOHQpIltxgmoh
 spk79yD2jpHbGyQFh6SaOpo/6wRZwJoQWmrOupAUYKcSPVtxxOTLMJfhdti0yLQWSmq4
 /Q+70IAhNrpqjUSN/WsWa9hgPQLWQqhndoV+sgqcMDvsfHPnH7TQH3S/o1519kcVEL6B
 F3dRX790UAMxy6tY5k7pedjfcW7w/tgFJPAp5NwO/SGNklT3savQOqY8vW6VBPAapxK7
 S1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703280739; x=1703885539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1V5UI6RajBlcMTf5MAPNP+BoyHTGfN0ZmIyzHUyke0=;
 b=H/8Dhrd9dZg7yv76f8XeVDQIyChmBEBUGm5l3IuozPXfmeU5k2dZthONo1foBSXGWL
 NqKgxgzTjBRbsrcd8ebIc8eO1r3LQWaKLxSkZM/cVq/FPhFtSnF2VQdWmcgzpnTYBcOH
 yrODwzYBSRLxi0P3x6r1dvvCvgmPP3x+bgFjYCbZuw0YrV44pe+9Ac87kNSHMKAmGb8i
 ZqSXxSB/zhXItpqz7qi8SHY/ubkCV3AUHjMYOBvT5g/tqVVhLHtOCDYBVhrmxburW3j+
 BdJxeAR2z4KIF/efNBVGacYijTuKhXY74123KiVYDMDXQWCJymcdKf0ybgBni1vQrdo5
 7ScA==
X-Gm-Message-State: AOJu0Yy9kbHTgbz/ZUfYTo4k7hJBBc5WC0c/HxFsV4qArDKNeZBQ0YFX
 01S+yNnWcpm7Zg0IBctmZ53mSr9+E7LfreCMBJx27xkIqko=
X-Google-Smtp-Source: AGHT+IH6R2g1eIHPWeX6GU6Zw5CykJl01mHJPgK+0VOEkk7iItYvG8lKRorNcRFNwI8b4i6svpImNg==
X-Received: by 2002:ad4:4b25:0:b0:67f:9aa6:e9c1 with SMTP id
 s5-20020ad44b25000000b0067f9aa6e9c1mr1493801qvw.127.1703280739353; 
 Fri, 22 Dec 2023 13:32:19 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 dm6-20020ad44e26000000b0067f6ec98ae9sm1623096qvb.32.2023.12.22.13.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:32:19 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 9/9] qemu-arm: get FDT from bloblist
Date: Fri, 22 Dec 2023 13:31:09 -0800
Message-Id: <20231222213110.660402-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231222213110.660402-1-raymond.mao@linaro.org>
References: <20231222213110.660402-1-raymond.mao@linaro.org>
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

Get devicetree from a bloblist if it exists.
If not, fallback to get FDT from the specified memory address.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Refactor of board_fdt_blob_setup().

 board/emulation/qemu-arm/qemu-arm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index e225011bf0..d326668caf 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -149,9 +149,17 @@ int dram_init_banksize(void)
 
 void *board_fdt_blob_setup(int *err)
 {
+	void *fdt = NULL;
 	*err = 0;
-	/* QEMU loads a generated DTB for us at the start of RAM. */
-	return (void *)CFG_SYS_SDRAM_BASE;
+
+	/* Check if a DTB exists in bloblist */
+	if (IS_ENABLED(CONFIG_BLOBLIST) && !bloblist_maybe_init())
+		fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
+	if (!fdt)
+		/* QEMU loads a generated DTB for us at the start of RAM. */
+		return (void *)CFG_SYS_SDRAM_BASE;
+
+	return fdt;
 }
 
 int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
-- 
2.25.1

