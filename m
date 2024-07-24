Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30773C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BFB889E1;
	Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jpargq34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9C93887F5; Wed, 24 Jul 2024 17:10:02 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B182889F7
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso3415675ab.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833799; x=1722438599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw37jPhdY63tRC9oKGOocj3yuGi+VeyqWDcEsAStBro=;
 b=jpargq340M1wpH4DBGy0J1IYyIG8Fbq0yJ2OBQfBMxn/XNAfmjyPSsWieHLDqp6Pjn
 l5tbUZUbxQPDy8rTOaJBqVjvmVTHPzRfU9F18+AS+tY+8qEL0GrC/Vcj5I3zT1GTWMsJ
 57CE/xO39DB02b7ZOntfB0sCgjLsQhe5QxXmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833799; x=1722438599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aw37jPhdY63tRC9oKGOocj3yuGi+VeyqWDcEsAStBro=;
 b=vFoYlrBiufc/Cah8vxVYxUnAKtIpHyvN/PoLll8mYpWD5jn2fuoZhg2TlAT34iEOAF
 +X2AJChezo/N6pPgJiTqoxWKvxbVnOuZ0rVYuc4usxf8efA1eGn8WrR4XECgP6+IXoEH
 r30O7GdceNDJe9ETU8TNp6DeIANSB9LvLhVITNg1P7VxHgOZUUAEdObAvPGM5pxoFGR+
 WuT1QxAA1wjjHG6fV6sZquzrnqAkkuscbhu2war/eGvew2+oYD16pDeZ51KByE5muHcz
 66vDVwDoacycWZy+aqlK1jXG5Zd9diB1TfKcDpuOv+wMydItv3am14i5AFPc/pblBQ0Y
 Ivaw==
X-Gm-Message-State: AOJu0Yzbsy9DxXTfljcvGWU0/WjJmtjkQ/noCW1lrSL/69Vl1Cmrxlv8
 BLSBPp09xdveSwxSwj14UK9seqeIjiFOpL4QxlIblq5tfxG2XwA44vRY3F+LC51EACB5Unb51aM
 =
X-Google-Smtp-Source: AGHT+IEMGpyCjLTu/pU9GZdM1dq9Xeo6BM0o7x16wdON2jElzvGe+OUPpQMy7GqZycpmH5pCFTKsYQ==
X-Received: by 2002:a05:6e02:12e4:b0:375:acd3:31b3 with SMTP id
 e9e14a558f8ab-39a1a7838bbmr13936815ab.5.1721833798861; 
 Wed, 24 Jul 2024 08:09:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Raymond Mao <raymond.mao@linaro.org>, Shiji Yang <yangshiji66@outlook.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH 24/35] global_data: Reduce the size of mon_len
Date: Wed, 24 Jul 2024 09:09:11 -0600
Message-Id: <20240724150922.2343249-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

 common/board_f.c                  | 4 ++--
 include/asm-generic/global_data.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index c99b573bc17..1bd4b790e80 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -339,7 +339,7 @@ __weak int arch_setup_dest_addr(void)
 
 static int setup_dest_addr(void)
 {
-	debug("Monitor len: %08lX\n", gd->mon_len);
+	debug("Monitor len: %08x\n", gd->mon_len);
 	/*
 	 * Ram is setup, size stored in gd !!
 	 */
@@ -476,7 +476,7 @@ static int reserve_uboot(void)
 		gd->relocaddr &= ~(65536 - 1);
 	#endif
 
-		debug("Reserving %ldk for U-Boot at: %08lx\n",
+		debug("Reserving %dk for U-Boot at: %08lx\n",
 		      gd->mon_len >> 10, gd->relocaddr);
 	}
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 7910e73e2e3..c8699c9e963 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -70,6 +70,10 @@ struct global_data {
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
@@ -114,10 +118,6 @@ struct global_data {
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

