Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F23CE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4154786C31;
	Wed, 20 Sep 2023 05:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oNiiuhCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C88286C0B; Wed, 20 Sep 2023 05:00:38 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A5C86B27
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34fdfa6af55so9537155ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178834; x=1695783634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpL9pfdiRLmz5tGhdl9c9iezT/p3jSHRnijxzYHxzJM=;
 b=oNiiuhCOMoeC+S2M2uV8rHzowi25H/sxKj6b0L8ilghoUIoskJpHT+UysRYRY1Kp2J
 8k/cDaQNYln/YkJziZqrKBCxlSWTjRZ20qed0XMSErPJYWnnbnmAxxaLwrVl8oEwRQwR
 QzeTGiR7+3uFZrBEPlH2/cEXRuyovp9GcX/DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178834; x=1695783634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpL9pfdiRLmz5tGhdl9c9iezT/p3jSHRnijxzYHxzJM=;
 b=Agsq5DRduII90vFUKQs+kXNqucnZL9y9GD93pudpOzGgUiuR3Cn+C4RnXnG9Gzo38y
 ej3oyVsib3xfIzCxYe9VUFKUPuQMTgnbDNecweOzpGQLxMHA7CiFIlqqxvLRvNs0Q8Sa
 xQrK3YnHFmnU+K0U9/bZ8bjpxU1Y8u8Sf3II0z8aV9GQjkCsed/lR74hINM3nh3yL3ch
 mqXMx1DdfDovcai0Stwtgd/nSt57FEVFFC6x0wJmzVRN9zxaNEjw1bR31ne/Oq51QZM2
 Gm//0aVXI8RHJmtWJ5yqOpX8wipM4OPwgMmBz7CgoEw6jTfpapHt/krB5yUV+BcRhft9
 53Kw==
X-Gm-Message-State: AOJu0YwM1ZJvyKdFCWSSXseVZyqLjcDTlZcpMQoe6/yJIqloiZrLhaOF
 57zOt/SKEg6me/7m1NC+e/iGVOTxbPBOunmgHFM=
X-Google-Smtp-Source: AGHT+IH1miW38uV0VOq/i6nvRYO0dognVf3xiwK6V5QdPCq8cQGRHZv2ZSG/GUxFTkUl9c+HJS9aHQ==
X-Received: by 2002:a05:6e02:1aa3:b0:34f:41ba:7c87 with SMTP id
 l3-20020a056e021aa300b0034f41ba7c87mr1823952ilv.4.1695178834593; 
 Tue, 19 Sep 2023 20:00:34 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 03/20] x86: coreboot: Rearrange arch_cpu_init()
Date: Tue, 19 Sep 2023 21:00:04 -0600
Message-ID: <20230920030027.1385833-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v5:
- Drop unwanted space

 arch/x86/cpu/coreboot/coreboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index 835b2c777462..da43d66e95d7 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -21,7 +21,14 @@
 
 int arch_cpu_init(void)
 {
-	int ret = get_coreboot_info(&lib_sysinfo);
+	int ret;
+
+	ret = IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
+		x86_cpu_init_f();
+	if (ret)
+		return ret;
+
+	ret = get_coreboot_info(&lib_sysinfo);
 	if (ret != 0) {
 		printf("Failed to parse coreboot tables.\n");
 		return ret;
@@ -29,8 +36,7 @@ int arch_cpu_init(void)
 
 	timestamp_init();
 
-	return IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
-		 x86_cpu_init_f();
+	return 0;
 }
 
 int checkcpu(void)
-- 
2.42.0.459.ge4e396fd5e-goog

