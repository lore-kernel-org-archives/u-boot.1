Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B72C5321E
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7B588E97;
	Wed, 21 Aug 2024 18:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i6UE0/qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA29488E40; Wed, 21 Aug 2024 18:20:14 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2076488E57
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7092dd03223so1954929a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257198; x=1724861998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9tKt6bJiAh4xCBSHTMWxcBVYKB/8btQcihDTR2+FWQ=;
 b=i6UE0/qi0C9SISNSjWfWqxyXsuRXdoJcNjQdtjqpKBw9utLUTO7iCIMLeWjM5KRiVP
 xyjom0vv9hn44/GvsCO4jNw4txrnfyz1mDzZx+QUtF56i9Bp9o43vcT2sIJDT3nAEVfe
 1f/uFbdrI0Y73geSSN0W7KRfPePSL+G5A7qh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257198; x=1724861998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9tKt6bJiAh4xCBSHTMWxcBVYKB/8btQcihDTR2+FWQ=;
 b=GM/q/xpe4JddXptSKlXeLtiRH3R5pwiGY8tIITTBExSsrk0NF+BzMbliOnB73VTsfA
 +V2Xk/icN2qBbWaGUKXVqnQi3Hdhi5CGA9Jy0UE+lfRo23iF82KQ3o1iHLrImFQ6pRk2
 JzMYY1JTJ6FxBi3OQnhvnNNhnRPH5miLF1IKsKvuVmBS4h0Up2B+mvgcOW1EmK4XrXJl
 eBDvXywxcZSXcCP+JKVI0Hjd1f03+CDpF66XxWIaCjLo9mP/B7VQDmN0fC7fxYaVGflr
 DU1DDWUuqUxXKU3BnXM5nP1LXNrQ1vdIvlGAvdpY+Io/wA4q/Lhi9cYXwwh6W1AhmLIc
 9nvQ==
X-Gm-Message-State: AOJu0Yz0v+vxvmX/DvXpLFSfDt92/utLcR2hlGaY8/2wCg6El1plmGzU
 guFxCveYiVZ1VteSCu/wqaff7PROSyTYRib47diw7I6QK4hdwSCsLqCyOrXwjXM1j5mPeEHs8dY
 =
X-Google-Smtp-Source: AGHT+IGeoEn3wLOTvoDeKxUAOznldP0rx9cBX44dGoPG30RB62UyAtNcwbNpVVoeSYONmqu7z5wC5Q==
X-Received: by 2002:a05:6830:6a8f:b0:709:4d7a:3438 with SMTP id
 46e09a7af769-70df86fbb28mr2997692a34.11.1724257197731; 
 Wed, 21 Aug 2024 09:19:57 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 24/35] global_data: Reduce the size of mon_len
Date: Wed, 21 Aug 2024 10:19:16 -0600
Message-Id: <20240821161927.695717-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

This is the length of the U-Boot binary, which is typically 200-800KB
and certainly not larger than 4GB. Use a 32-bit value to save space in
global_data and move it up to be with fields of the same alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/board_f.c                  | 4 ++--
 include/asm-generic/global_data.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index eb1a5f0e1e9..d9fe6f997ab 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -340,7 +340,7 @@ __weak int arch_setup_dest_addr(void)
 
 static int setup_dest_addr(void)
 {
-	debug("Monitor len: %08lX\n", gd->mon_len);
+	debug("Monitor len: %08x\n", gd->mon_len);
 	/*
 	 * Ram is setup, size stored in gd !!
 	 */
@@ -477,7 +477,7 @@ static int reserve_uboot(void)
 		gd->relocaddr &= ~(65536 - 1);
 	#endif
 
-		debug("Reserving %ldk for U-Boot at: %08lx\n",
+		debug("Reserving %dk for U-Boot at: %08lx\n",
 		      gd->mon_len >> 10, gd->relocaddr);
 	}
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 0c8801500f0..06523cab522 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -71,6 +71,10 @@ struct global_data {
 	 * @mem_clk: memory clock rate in Hz
 	 */
 	unsigned int mem_clk;
+	/**
+	 * @mon_len: monitor length in bytes
+	 */
+	unsigned int mon_len;
 	/**
 	 * @env_addr: address of environment structure
 	 *
@@ -115,10 +119,6 @@ struct global_data {
 	 * @ram_size: RAM size in bytes
 	 */
 	phys_size_t ram_size;
-	/**
-	 * @mon_len: monitor length in bytes
-	 */
-	unsigned long mon_len;
 	/**
 	 * @irq_sp: IRQ stack pointer
 	 */
-- 
2.34.1

