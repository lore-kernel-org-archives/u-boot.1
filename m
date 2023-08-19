Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E0CEE49A6
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF1F86FAA;
	Sat, 19 Aug 2023 23:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nxtZsNZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01BA86C58; Sat, 19 Aug 2023 23:23:24 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E5A86C1C
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34ca22e3b3dso1575225ab.3
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480200; x=1693085000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37hJ9HlpUNr6X/Uftwt2W1KqkPmCc+NrJrpJ0QYhZRs=;
 b=nxtZsNZimScE2kRkaJIEA00mRzjxUsZ4/CQ4+2KwccghG4y6wbmTtrbBu8+jpR94pK
 nrGhzMWgVRDsC81pSRmYSjOyoRfLNLvCHCQ1XtYPGij+1Ymj7aUZ8GKRHBLgqDVXhIdz
 HcbB8+yK5ulveoMpGm2QAqf7oWlDhmIwiKRxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480200; x=1693085000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37hJ9HlpUNr6X/Uftwt2W1KqkPmCc+NrJrpJ0QYhZRs=;
 b=FqAnkPT9OS+1Zq6TwvqDLm+DW3bsHvr3QMyaZe+JpWB9aVBleC85ic1IzzY61EGfQC
 4Q2QRleCMSaJ2tw3QzyxQbpPQaFuZi9IWp58hT3NSFoqxcohoEfD5AEO86eFJZqBs68/
 z/gFCuscob3SIOb1Y/pbluL06zA6m2ny93jXTnCCIvCUhDoH1MtahB1ck1SNR3cemvNB
 kil/8gmuvb+Z2a2ytenWaJy9zSY87VVwHOJu8sd1Z11ba48JLBCKdNHVUuWT1603Kdhu
 VzKOWLVu9QTB7ZKpSwPuCYLT2r1lmcY7Ge+ofJRn0l4qPHK/gXzI5JdJffsNYEGAW2ld
 zh/Q==
X-Gm-Message-State: AOJu0YzUSTR782m8JrE1nSTsZluazFGXEs9UyK6yhA2+UgulnYKN2mX3
 z7HPXpmZMaSm3cevgFPA+GvkR8LdoXQXc+t0LvY=
X-Google-Smtp-Source: AGHT+IHPgDkqIKRKchAeO118b1/FJo8FJ0oGb8bTL3fj/eubbl+E8RbY1+JPpfbpZRXrFS+fP3kHaw==
X-Received: by 2002:a5d:884c:0:b0:783:550e:33c0 with SMTP id
 t12-20020a5d884c000000b00783550e33c0mr4210616ios.7.1692480200615; 
 Sat, 19 Aug 2023 14:23:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 03/19] x86: coreboot: Rearrange arch_cpu_init()
Date: Sat, 19 Aug 2023 15:22:41 -0600
Message-ID: <20230819212309.1094440-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

(no changes since v1)

 arch/x86/cpu/coreboot/coreboot.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index d7eedbd7436e..a0c62cce2293 100644
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
2.42.0.rc1.204.g551eb34607-goog

