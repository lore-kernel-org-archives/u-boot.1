Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B42CE7E34C
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 09:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B83783DC9;
	Fri,  3 Apr 2026 11:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dr+FUCQV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D04084120; Fri,  3 Apr 2026 11:01:29 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B2983CF5
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 11:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4888375f735so14142675e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775206887; x=1775811687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdwpaU6iUhDzdUkX2+r8JBDyihxWgAxxLFJEAUYC6Fo=;
 b=Dr+FUCQVw0l1qgyALDH22kGymfXszbJXawYOTs0R2G3HrwvjobYSCw+PtDQhrLSzD0
 ejv1MVeJpMzQaWQf/UvInOAFm7MgEtrHrYoYgsBgYvDxx06aCkrhgQ2vQy6g8LHnZe9J
 PwiZx2bS3xK7zDSZTmT1JO9uOdNVu73GxTW2Y6ijVmHYmK5j3TFO/Psx11f/wiPKPdtu
 DsKY3tH2VjIpr0pZVnSQbhoICLzQJVwUFUP3rVhJTuoywgvg5EtnmJkP92csfdzTA7Sw
 lbDSQT79ggcTWPFIY82kZ6qVudffwHeqZii84j+BviRkqlZj5AvDi3cilGUDqkAUmu8l
 3O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775206887; x=1775811687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RdwpaU6iUhDzdUkX2+r8JBDyihxWgAxxLFJEAUYC6Fo=;
 b=U6NiYJxRfO5d+Nz98DVDn/VX4lmsejtQb0Mi/etixrRTQNFSN7fCgoAL5RQEzWMoot
 m7v3WFtOcN+bB0xru8O2d+MQd8RuZbyL+wYgNyWIfM87GIrxmYfHZQzBJNg256cH7jJ4
 F2pYbeFtRdthezIYx+G66Dpeasflb6uGwoWKht4IRhdOe/uvZTDL1jz6wfHuhFfhlqo+
 B1W5PhS0C7MyksDEEBYqNI5glAQDrYwz7KqHydmWJCLfKmeA80bRpE2EqjCSRDqcEpXa
 nATBKTHNaxF+mgWFl5lB6BwOM+WfLmxjHJSLHW3dlnAJ5Md2iuiKgLcqp2spJCQtxwQv
 CCRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjC6i18hyDwqlKZi6a6ys/jw539jNmeOFBrhPrBJfYoWM3TryzBc3c+32F5c2/Ez/jgljtJX0=@lists.denx.de
X-Gm-Message-State: AOJu0YxKYwBv7b74Gsp/wlpCmzDTCasHA6nPM43/ea7JGyljZVk2psvI
 WndEESmfdiR0/PevC62AELgSlFSo5/jVQlkBFfc1awtiSqt1C59tff7uJG4V6hLak0Y=
X-Gm-Gg: ATEYQzwoDYx/b7QNlNhbTW+/2f52cPs3MP+4RSJ327+1mR5AEoeFRXMlzkRrPWPsoN8
 MMtXoVexZBScbNxIc/PBho4F5tFmiFOglg1PggYzzeW7fqoTDSrXvykNKHOPCk4QQ2oeWjUiJE5
 gDClqA1UKEH8TQN2MBwXMAuvtjtNP+29Kj7Quf1mrCfwlxiahBgfHVnHjrMyx7AbIDDF9bVBdY9
 NjgqHY2/OpqOm3V3IO4lbrt3SZjxq5q9Rlet/7a9QVV3EJUTsL2ztYBEUygi5HSK3iMO9x9n74F
 x2wEGzKI8ux4IlSUDB7DYJuB9+cSkg7yulBCy7jZDWb8qwAe5ViLE9hmJMCIFouxqI7dylVSuio
 NldotuuvrDN57SNNnvVhIXc20RdZGGe4EZHEAV9ViNln0MAxdDv4Srx8yhkvWSYjqUGp3lqJarW
 U5AJkc+7Ttt1pAKt5NXIW6tVKEhIX35jl309hjOibjAb20L5DEX4MblsuY6wAQeIJOYmEcVwhiK
 yesKVLp2rqEAv0HQUm8IoVaDhFkkUP/0BIfR/FpVHBDx+GI1SZ4i0PnqzjM7D8BLkdtXZup9ogQ
 6/GwhA3O1y+iLnERl559shrnOocf1sFMIKfNK57ZpGwfPraSZcKH5e/g3nvX+c8I3ITYDKfe0FG
 6Wt1KHTFlpT0xQ3dx8GEtMjBXh87uYtxKO5E2XV4YRwvzN89lHNFntPpoJwmFEuGlPMnS3iNR2m
 Q/ns1wNUmeHukAwrowyI4DkIYVzX1PcAPM3aP+y2Q4GBhaDF5TQ9uYcWgOYyu2
X-Received: by 2002:a05:600d:1:b0:485:3c8f:e4d9 with SMTP id
 5b1f17b1804b1-488997ddc40mr29168215e9.26.1775206886764; 
 Fri, 03 Apr 2026 02:01:26 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e967badsm332528545e9.14.2026.04.03.02.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 02:01:26 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1 3/4] common: Clean up setup_dest_addr()
Date: Fri,  3 Apr 2026 12:01:05 +0300
Message-ID: <20260403090109.3564638-4-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
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

Right now the function does
- Re-adjust the ram_size based on Kconfig options
- Set ram_top
- Set the relocation address

It also does not set the ram_size in case ram_top grew
from it's initial value. But ram_top and ram_size should
always be changed together.

So let's make things a bit cleaner and move the ram calculations
in their own INITCALL

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 common/board_f.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 7df92281c35a..dd5518b60db4 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -337,13 +337,9 @@ static int setup_ram_base(void)
 	return 0;
 }
 
-static int setup_dest_addr(void)
+static int setup_ram_config(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
-	/*
-	 * Ram is setup, size stored in gd !!
-	 */
-	debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
 #if CONFIG_VAL(SYS_MEM_TOP_HIDE)
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
@@ -359,8 +355,17 @@ static int setup_dest_addr(void)
 #endif
 	gd->ram_top = gd->ram_base + get_effective_memsize();
 	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
-	gd->relocaddr = gd->ram_top;
+
 	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
+	debug("Ram size: %08llX\n", (unsigned long long)gd->ram_size);
+
+	return 0;
+}
+
+static int setup_dest_addr(void)
+{
+	gd->relocaddr = gd->ram_top;
+	debug("Reloc addr: %08llX\n", (unsigned long long)gd->relocaddr);
 
 	return arch_setup_dest_addr();
 }
@@ -966,6 +971,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
     !CONFIG_IS_ENABLED(OF_INITIAL_DTB_READONLY)
-- 
2.53.0

