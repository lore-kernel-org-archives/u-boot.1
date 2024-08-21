Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46335C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 011E988E73;
	Wed, 21 Aug 2024 18:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jw4Ol3iw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCB688E74; Wed, 21 Aug 2024 18:20:04 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4511388E43
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-70942ebcc29so4691133a34.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257197; x=1724861997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sjMKWLtTtaAoQoWbNvnKe0CfSRejpUbKVo3Y0L0RI+I=;
 b=jw4Ol3iwWdl/t9CimFvXy5HVu7LpFELteyr1V2UOhXjJE2ApM292/FN753ePfAFsGB
 UMuij97oAGae8uvWKgBC8UsDCXNU4HuEMu0Vg+4btJJ1DBAnX3NSk6vd/Xgsm1e2k+Kt
 Uf5YHMn/5BjPjyQbRb5ILltvmSHkJYPexhgvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257197; x=1724861997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjMKWLtTtaAoQoWbNvnKe0CfSRejpUbKVo3Y0L0RI+I=;
 b=MoLLplG9c8CMPnW2bA25L2GXEJVTHzB8IdMRceZbq2Y9txV5PhAsUnAoUMNrnzRDmS
 dB9Kir16Tg2HwweyWbbkgUrtNOWErzAxr+L+MLKP1+Vr0r1Idhf1jx1OLtSdz9mm9Vxw
 Jb4jDfSq4l37GC0Z/xQdNu+YRBO5IW2w3hZqtztuBNG+NeV0n+I/pn5hTbePcJ+lCnxC
 hIRdQY00wkR1sKbmBGbzRVMOGEufdD4JSNBFUihZLfGb+ybfX53U6uUtVXkGJ5v3Xwso
 4vmSdc3KsuoFs+ur3WsY9CuCF6WKJcygVyORk3yn0/7qi8wyyR8W+LXGSSefx/8NRaKf
 Hckg==
X-Gm-Message-State: AOJu0YxG1YTGmVtYxw0lY+/xSZG+c031zopgPfmpjW8EdElu8ZMGQR6S
 Avc5OPpRM2YxegZCU+ae3sf3S7krCvjEQ3mvx7mElq4wnxlqQEkoOolM433LLXPQyFRSjyYzavw
 =
X-Google-Smtp-Source: AGHT+IGYledQOs1X1npQZSU4RjLN/3MDVJ0exTNGVwOx3gWNVMnCDYfIo+ymJy4S+ucga/hEyHiIxw==
X-Received: by 2002:a05:6830:671b:b0:709:5601:abea with SMTP id
 46e09a7af769-70df8709b10mr3358262a34.10.1724257196937; 
 Wed, 21 Aug 2024 09:19:56 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:19:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/35] global_data: Reduce the size of bus_clk and mem_clk
Date: Wed, 21 Aug 2024 10:19:15 -0600
Message-Id: <20240821161927.695717-24-sjg@chromium.org>
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

The bus clock and memory clock are unlikely to go above 4GHz for now, so
reduce the field size to 32 bits.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/mips/mach-ath79/ar934x/clk.c | 4 ++--
 arch/mips/mach-octeon/cpu.c       | 2 +-
 include/asm-generic/global_data.h | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mach-ath79/ar934x/clk.c b/arch/mips/mach-ath79/ar934x/clk.c
index bdaa6839a2b..231a21ca90f 100644
--- a/arch/mips/mach-ath79/ar934x/clk.c
+++ b/arch/mips/mach-ath79/ar934x/clk.c
@@ -327,8 +327,8 @@ int do_ar934x_showclk(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	ar934x_update_clock();
 	printf("CPU:       %8ld MHz\n", gd->cpu_clk / 1000000);
-	printf("Memory:    %8ld MHz\n", gd->mem_clk / 1000000);
-	printf("AHB:       %8ld MHz\n", gd->bus_clk / 1000000);
+	printf("Memory:    %8d MHz\n", gd->mem_clk / 1000000);
+	printf("AHB:       %8d MHz\n", gd->bus_clk / 1000000);
 	return 0;
 }
 
diff --git a/arch/mips/mach-octeon/cpu.c b/arch/mips/mach-octeon/cpu.c
index c7744e84706..c771da61a68 100644
--- a/arch/mips/mach-octeon/cpu.c
+++ b/arch/mips/mach-octeon/cpu.c
@@ -67,7 +67,7 @@ static int get_clocks(void)
 	gd->cpu_clk = ref_clock * FIELD_GET(RST_BOOT_C_MUL, val);
 	gd->bus_clk = ref_clock * FIELD_GET(RST_BOOT_PNR_MUL, val);
 
-	debug("%s: cpu: %lu, bus: %lu\n", __func__, gd->cpu_clk, gd->bus_clk);
+	debug("%s: cpu: %lu, bus: %u\n", __func__, gd->cpu_clk, gd->bus_clk);
 
 	return 0;
 }
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 094e97449f6..0c8801500f0 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -66,11 +66,11 @@ struct global_data {
 	/**
 	 * @bus_clk: platform clock rate in Hz
 	 */
-	unsigned long bus_clk;
+	unsigned int bus_clk;
 	/**
 	 * @mem_clk: memory clock rate in Hz
 	 */
-	unsigned long mem_clk;
+	unsigned int mem_clk;
 	/**
 	 * @env_addr: address of environment structure
 	 *
-- 
2.34.1

