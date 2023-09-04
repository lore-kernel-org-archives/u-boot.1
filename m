Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C48C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 19:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BD2E8679F;
	Mon,  4 Sep 2023 21:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GZrJ01e+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E417C8692D; Mon,  4 Sep 2023 21:06:43 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535DF864DD
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 21:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a7f4f7a8easo764212b6e.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693854398; x=1694459198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fle/f1i7uCwS9zpfzU/0UwbUUIQj7580nGdj597C9RE=;
 b=GZrJ01e+UjH6OAa5beZWSvUvrW/1JLPD8lPmX6CPYJRYJuIhtqF/rygg0lolCdHG06
 xth0dT2a1G7KAT4lA/wLgfCW47rW3f7k71RSRmlCf9dL9SJM4iPT98iEHsvaYpaAJYhy
 g+/gtkPFQ4nVWHzktdaVqEc5oke4F78uTshV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693854398; x=1694459198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fle/f1i7uCwS9zpfzU/0UwbUUIQj7580nGdj597C9RE=;
 b=HiN9yIbmLlaXL3m8QC3QrwxGQGLWkEKsqgPk1RVfa0XRo35nOMtLpL17AWILXfD0S0
 rxq0eu2rp8XFi9ykkq+XbGg2mQjXg0Gd8MyVKuQ1x53ulx1536v3MzHKm4n6+8OKKM9P
 ri4BWzZB6CqEZReFlLYCRDIfBxl4T97EeMPhPUiLY5s1w5SiTaGaIEGOBrhBCndcs9iG
 ywGuGk7zWhe4BB5yFNkg9nAUeMkuI1xyBZDtWuZbxOKiZdTeJGRoQCeHBlNxPbkG9hUh
 dOWGFpWzEbg8dcARck7x8m3UF6cMZ1aZxrK8yX4EZeRZpCgNq9tUo0fl5auE1mhc/Fpn
 GeeQ==
X-Gm-Message-State: AOJu0Yzfttkhe5PqeKFuQA5TujBpUAxGApjZ9t9z9M3b+qy3HRU2Di5B
 0CVY2AOKKoIKa6dTvI6cP2W1wfsvKMid5o742UJWlA==
X-Google-Smtp-Source: AGHT+IEpWE74+QzncwcMWQrQIhAtmNQUOdCMXELmb4F6gXj32fomOj0nxu2B6w9m9EQYZTeUurak9Q==
X-Received: by 2002:a05:6808:13d2:b0:3a8:29a9:e4d0 with SMTP id
 d18-20020a05680813d200b003a829a9e4d0mr14840775oiw.34.1693854397866; 
 Mon, 04 Sep 2023 12:06:37 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 ci7-20020a05690c0a8700b005869d49212fsm2755109ywb.32.2023.09.04.12.06.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 12:06:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Nikita Shubin <n.shubin@yadro.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 2/2] riscv: Correct event usage for riscv_cpu_probe/setup
Date: Mon,  4 Sep 2023 15:06:35 -0400
Message-Id: <20230904190635.3896494-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904190635.3896494-1-trini@konsulko.com>
References: <20230904190635.3896494-1-trini@konsulko.com>
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

With having both an EVENT_SPY_SIMPLE setup for both riscv_cpu_probe and
riscv_cpu_setup we do not need the latter function to call the former
function as it will already have been done in time.

Fixes: 1c55d62fb9cc ("riscv: cpu: make riscv_cpu_probe to EVT_DM_POST_INIT_R callback")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Rick Chen <rick@andestech.com>
Cc: Leo Yu-Chi Liang  <ycliang@andestech.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Nikita Shubin <n.shubin@yadro.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>
---
 arch/riscv/cpu/cpu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index cfe9fdc9df55..c1a9638c1ab7 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -94,11 +94,7 @@ static void dummy_pending_ipi_clear(ulong hart, ulong arg0, ulong arg1)
 
 int riscv_cpu_setup(void)
 {
-	int ret;
-
-	ret = riscv_cpu_probe(ctx, event);
-	if (ret)
-		return ret;
+	int __maybe_unused ret;
 
 	/* Enable FPU */
 	if (supports_extension('d') || supports_extension('f')) {
-- 
2.34.1

