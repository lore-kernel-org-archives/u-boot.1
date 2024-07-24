Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F18FC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 189A788A29;
	Wed, 24 Jul 2024 17:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FcL6Npsf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E1D8896B; Wed, 24 Jul 2024 17:10:06 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AB528896B
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3993f5d75bbso21763915ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833803; x=1722438603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yl7b2neWcp3ZKSpPxnfjX/88lmyO4eG3V0NDr5W0e58=;
 b=FcL6NpsfMW/6PVHYnRhkDSVbZevKIcEDVSDx4bOM3hTP64jz+8nQwMYF/lT8NAKAPy
 by20f4RFWy3CvSMXBoeFQv8rLYEJ2haFQar/RGXrDSrsvIqXoWPFv82yHJEi7atiW905
 ytBYHcPMHo2oTsw2h5GS/pJfK8dDGJXWXX+jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833803; x=1722438603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yl7b2neWcp3ZKSpPxnfjX/88lmyO4eG3V0NDr5W0e58=;
 b=n2wzCvaQtJq+/ODvjv+fcgtHuLGwhhqjgdR8VWdUCOlKy5WdpcRvlsqL2vFatCD4Du
 DkgfP6i/DO9Eer9u8SPfXwT1cowBI+QTstAFD+mAXL52wxqqOC1xW5wl1meTNBPXGgih
 y+m3HoOShGXsHC+M1bdA90VBK+LFYTPLuPorDJR4I0frGwBHEAzQUMa3uiIPYNkt16A+
 Gj3wkVlIH39Nrn/V51/lQds2N2Fo1/dE4ia5rZiG4znGPIbGOc9tmPoqFDgGlTn/Xe85
 hyu4ou1RXOUNCe0d0XRlpe1P05T9fnhSYRBubAOJWL6Ch4EE7Qjgt5G/RTON3UthuYmx
 GhAA==
X-Gm-Message-State: AOJu0YwjMJDiuNAAgrmH8w2VHHGNA2xR9/5fkDD6zldeI/Xg+2vFIYFa
 j5K0uyZ6a0dBtXUDfklPwPqxNEb1oqoVyMxp7OP7WXWKP0Ol5G6SeW9N5oxZ6o1PVtMTgK+XHPE
 =
X-Google-Smtp-Source: AGHT+IEBabBv7wWQ3K7rKtPV5SIHaweY2fgYl6++HjVduWhndnF9/i8bra+3bBITaj2r7ReHEeIaSQ==
X-Received: by 2002:a05:6e02:1aad:b0:380:fd76:3d9e with SMTP id
 e9e14a558f8ab-398e6b9eea3mr178797535ab.22.1721833802843; 
 Wed, 24 Jul 2024 08:10:02 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 29/35] global_data: Put phys_addr fields near the top
Date: Wed, 24 Jul 2024 09:09:16 -0600
Message-Id: <20240724150922.2343249-30-sjg@chromium.org>
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

Put these fields near the top and together, since they have the same
alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/asm-generic/global_data.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 368b19ffb60..82c74dee161 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -48,6 +48,14 @@ struct global_data {
 	 */
 	struct board_f *boardf;
 #endif
+	/**
+	 * @ram_size: RAM size in bytes
+	 */
+	phys_size_t ram_size;
+	/**
+	 * @ram_top: top address of RAM used by U-Boot
+	 */
+	phys_addr_t ram_top;
 	/**
 	 * @flags: global data flags
 	 *
@@ -101,10 +109,6 @@ struct global_data {
 	 * @ram_base: base address of RAM used by U-Boot
 	 */
 	unsigned long ram_base;
-	/**
-	 * @ram_top: top address of RAM used by U-Boot
-	 */
-	phys_addr_t ram_top;
 	/**
 	 * @relocaddr: start address of U-Boot in RAM
 	 *
@@ -114,10 +118,6 @@ struct global_data {
 	 * GDB using the 'add-symbol-file u-boot <relocaddr>' command.
 	 */
 	unsigned long relocaddr;
-	/**
-	 * @ram_size: RAM size in bytes
-	 */
-	phys_size_t ram_size;
 	/**
 	 * @irq_sp: IRQ stack pointer
 	 */
-- 
2.34.1

