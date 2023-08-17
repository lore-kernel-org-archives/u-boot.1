Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7726BC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECE186A30;
	Thu, 17 Aug 2023 03:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WuElm7pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08FA286A4B; Thu, 17 Aug 2023 03:58:07 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA5286A30
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a81437be28so1889407b6e.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237482; x=1692842282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vvb7rrFMsmNt48ACrbnRUlGAuLNNMaj92sTS5roX7B8=;
 b=WuElm7ptP/wDjFDGvgeA4Lku1JR+zAE/Ez44JCS4zcYVuxxTrl0aa6gwy1tYH0Go4b
 /vyolDtSE1FmFP4vNZbZP/RCtJoQwSoKvh3rZjufa1Czmf5gPpLPasSXhZorAL88DhdS
 CP2ERSXgnCmr9dFmbUzphk3QajumyfwV/imT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237482; x=1692842282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvb7rrFMsmNt48ACrbnRUlGAuLNNMaj92sTS5roX7B8=;
 b=R9oio6R6nRNCBKFulHu4NfRxnqOgbux+7hDEEdrbaDumnLLYzDtb3r+2cnXL+uimtj
 CDDwMP17gS4G7dZ1amzvzZrY/r5Xb90Gfv8SR/VV1N7trLFdzlkEyx+etPMlZJ0H4iov
 LJKKZELMpDlop8mJLYNmwSeIu9TeiG8XNm+q/DA3oZwqpCc89TIxwm3ulsMyjES8IY01
 eqDuBJyPfMAgzbCEv66bCp4ZRBvKHS4FLhifvHGOtMw2DIC9kM1vv5YdLwYGOtA/bPSx
 yE5jx6+ZtxUDA/rvInLYfD9BvP5/oFXizyFCLzfrTfunUug4j6aYDwV9dcogq5qwHCQW
 TLMw==
X-Gm-Message-State: AOJu0YzIF3+erldCOTjjXW0/mRFmA2sSudjZnKcaNCRDjzSyM94i7KEm
 p3H97DR32g2jQreyOfVnadxAidEqA/gUtUChheo=
X-Google-Smtp-Source: AGHT+IFFHLbWEVWYBR5cGk0sGaDQDZu0z5FtACwARYlcCWAFNmNLSsflUHBlm5x2NM/8sG8g29F+Pg==
X-Received: by 2002:a05:6808:2385:b0:3a1:e17a:b3fb with SMTP id
 bp5-20020a056808238500b003a1e17ab3fbmr5186628oib.1.1692237482753; 
 Wed, 16 Aug 2023 18:58:02 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b12-20020aca674c000000b003a7b5193909sm7026471oiy.19.2023.08.16.18.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:58:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Nable <nable.maininbox@googlemail.com>,
 Coreboot ML <coreboot@coreboot.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 1/2] x86: coreboot: Update cbmem table
Date: Wed, 16 Aug 2023 19:57:51 -0600
Message-ID: <20230817015754.776507-1-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
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

This changed a few years ago to include an overflow flag. Bring in the
new structure.

This comes from coreboot commit:

   6f5ead14b4 ("mb/google/nissa/var/joxer: Update eMMC DLL settings")

Note: There are several implementations of this in coreboot. I have chosen
to follow the one in src/lib/cbmem_console.c

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop __packed as it does nothing useful

 arch/x86/include/asm/coreboot_tables.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/coreboot_tables.h b/arch/x86/include/asm/coreboot_tables.h
index 4de137fbab9d..0dfb64babb96 100644
--- a/arch/x86/include/asm/coreboot_tables.h
+++ b/arch/x86/include/asm/coreboot_tables.h
@@ -299,11 +299,24 @@ struct cb_vdat {
 #define CB_TAG_TIMESTAMPS		0x0016
 #define CB_TAG_CBMEM_CONSOLE		0x0017
 
+#define CBMC_CURSOR_MASK	((1 << 28) - 1)
+#define CBMC_OVERFLOW		BIT(31)
+
+/*
+ * struct cbmem_console - In-memory console buffer for coreboot
+ *
+ * Structure describing console buffer. It is overlaid on a flat memory area,
+ * with body covering the extent of the memory. Once the buffer is full,
+ * output will wrap back around to the start of the buffer. The high bit of the
+ * cursor field gets set to indicate that this happened. If the underlying
+ * storage allows this, the buffer will persist across multiple boots and append
+ * to the previous log.
+ */
 struct cbmem_console {
 	u32 size;
 	u32 cursor;
-	char body[0];
-} __packed;
+	u8  body[0];
+};
 
 #define CB_TAG_MRC_CACHE		0x0018
 
-- 
2.41.0.694.ge786442a9b-goog

