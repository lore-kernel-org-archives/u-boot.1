Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FDEC05052
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9DBD86A28;
	Thu, 17 Aug 2023 03:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WjZuUxGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1536886A2D; Thu, 17 Aug 2023 03:52:04 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DDBE86A45
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6bd3317144fso4606582a34.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237119; x=1692841919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Puo6mlCLME9VLJ75a/kuYUcc3k6NCP7WWQ0T87uVTJw=;
 b=WjZuUxGHOflJQI6TPNGtaAbmbRBRa2GC+LJx8AujuQ4HJwQUCpRQBPGO1ysEIKj8Zt
 q7HWRtQ21HyP3H5Y9tTbDl/Wki8AidimJilyu+frDk0rCq64fp4ls6by7egd7R2bMS3h
 48c8kVqQco7rcvyL3iwt0F06lSW8M6ZsBkOZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237119; x=1692841919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Puo6mlCLME9VLJ75a/kuYUcc3k6NCP7WWQ0T87uVTJw=;
 b=ddHAmykOORm+KaAhaEpIz9Wi4Brt9Ag6do3ciFRb1bfYIuTLlh3EGoF0ytGW/1yQcw
 Mj0zEa/Otc8ZPCrICYclYLALKwzwOtfylczk/7uOBEKHQ1zvxb3+sSzvArwCZv28u+q+
 aMrWF9efmQJT4Pnupf4jBFKcMqFdxP6LIHZ2m1vqgvax7NGz/MtzQIVxTK4cNuLxBPok
 PTUuOVihi+P46NEOEIQOOxgAa9bEvMxbrJQmOOjqODENwQg9JFLtVYA+4mnX7CN11jmD
 y4BNIqIglSSf8EaPza/r8Fb2ABtt8I9VI4ZP6SAUpzxqneAWUabxB5WURbR2YgUdVyom
 dirA==
X-Gm-Message-State: AOJu0YziZrBxuoO18e5ySbSTqc8OAjCumPgyYdv8vUvoNIH7QCq/d1cQ
 0leuoVQuUTUdMVZfxWzChLrdPP37h9jJpQw7tXY=
X-Google-Smtp-Source: AGHT+IFUl8GCcI8Xh0C2SdAwXWKuCgpnXVjh14o3lbSnkx5R3/2nM+Ta4NzUwKPN+F0Q4jYClXbljw==
X-Received: by 2002:a9d:638c:0:b0:6b1:d368:557c with SMTP id
 w12-20020a9d638c000000b006b1d368557cmr3970988otk.30.1692237119646; 
 Wed, 16 Aug 2023 18:51:59 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:51:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/9] x86: coreboot: Rearrange arch_cpu_init()
Date: Wed, 16 Aug 2023 19:51:36 -0600
Message-ID: <20230817015149.774847-2-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

Init errors in SPL are currently ignored by this function.

Change the code to init the CPU, reporting an error if something is wrong.
After that, look for the coreboot table.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/coreboot/coreboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d7eedbd7436e..6a551e4c6713 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -20,7 +20,14 @@
 
 int arch_cpu_init(void)
 {
-	int ret = get_coreboot_info(&lib_sysinfo);
+	int ret;
+
+	ret = IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
+		 x86_cpu_init_f();
+	if (ret) 
+		return ret;
+
+	ret = get_coreboot_info(&lib_sysinfo);
 	if (ret != 0) {
 		printf("Failed to parse coreboot tables.\n");
 		return ret;
@@ -28,8 +35,7 @@ int arch_cpu_init(void)
 
 	timestamp_init();
 
-	return IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
-		 x86_cpu_init_f();
+	return 0;
 }
 
 int checkcpu(void)
-- 
2.41.0.694.ge786442a9b-goog

