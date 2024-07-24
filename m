Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F7EC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A176288A02;
	Wed, 24 Jul 2024 17:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BuvuCzgU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9139889E8; Wed, 24 Jul 2024 17:10:02 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759D2889EF
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39626aee4easo31857325ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833798; x=1722438598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZEPgo+XYLFFyAW1YlK0NCnBY6hKBWJxZ6+C8S626Io=;
 b=BuvuCzgUyc7xyctY556XpW5CLeIAb735Mb7YqYSQEWnHh3Av4F+GIxMj276ZHyMdzg
 2oUrz9mMQIyS9W7sKZfaq65RjzHkFl9vnvv69TA0lOBHPy/8t5/GUHSEFH3wFmnAwDmc
 RVMIsdSFuKILaQ+m449T5lUVt0i026c76AJ5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833798; x=1722438598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZEPgo+XYLFFyAW1YlK0NCnBY6hKBWJxZ6+C8S626Io=;
 b=Qu6KeopV8iU/x3Rf7XraRLslAE437TMwilbvT282TDAS/R2ZNQy7vpZiCv135FIm9S
 k9IylPUj/Nzt4J2DzNT9X4NuRwZcRCFH/ZvioQ5CyCy89qm2EXB9viE/RU0acYLehHu7
 LN5X30rAQo/l9aJ8/Oksys5jpfUQDYS5XgUHpJ6YGW5e1AzXjHNDX2d/dQHyLBTEMLQN
 QTPHXEN9eqtA8DS+YG5CuLtn17Yob8fCdgWgi2M5WlzRIoa9fkT/FoBT0IjjAEOwGXR8
 +dZU37N0AxjeqXqI54yJ2oRKHmeg9Fd5HXkAb7Ycde2iMfeV++8ypRUNhH09qmo3VUa8
 Iyog==
X-Gm-Message-State: AOJu0YxBOhyVnC2e71iTtNtCNRiamTgTRTnFp9R1nItBHXu+3TXdELef
 KSnT5pu6+vAmUObwqj0LFMHi9/KsVHg4wDwiwHq7iCUT3H33+/zmvZ3mec1Ta0ZweEkYxvA848w
 =
X-Google-Smtp-Source: AGHT+IEdYMIXOmfe2DRB6pmMCzeRnWNr6LmzMA6bR1W0F7Dbvkrym7EcBI+HF0rpWCp4RkAsvIfCHA==
X-Received: by 2002:a92:c241:0:b0:383:5ada:7a65 with SMTP id
 e9e14a558f8ab-39a16d5dc55mr39037355ab.26.1721833798137; 
 Wed, 24 Jul 2024 08:09:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Aaron Williams <awilliams@marvell.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 23/35] global_data: Reduce the size of bus_clk and mem_clk
Date: Wed, 24 Jul 2024 09:09:10 -0600
Message-Id: <20240724150922.2343249-24-sjg@chromium.org>
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

The bus clock and memory clock are unlikely to go above 4GHz for now, so
reduce the field size to 32 bits.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
index 48241d10034..7910e73e2e3 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -65,11 +65,11 @@ struct global_data {
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

