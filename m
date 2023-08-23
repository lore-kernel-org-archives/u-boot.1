Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518DDC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22F9864E5;
	Wed, 23 Aug 2023 23:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N2GiF1ht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE525864E5; Wed, 23 Aug 2023 23:11:13 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE26D86445
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79246bb4008so75451439f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825070; x=1693429870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fe/mUq9CZ5wWXabgCHcnUhruGO5Bjt72ZLYxIwhR76I=;
 b=N2GiF1httmQJM5uGIKLsZqVJMS9Q8n9PqHmHcddSqhhsAJVQZ9Tq/ujxwAx5Tbuw/N
 IagiA+K9/G39iGxuT+C9kk+hjCysVo+91P4ZmUfiQFRparxEa3y860hqIoDW2GCjsmFe
 y29Gka1f9lEbCN5s/JyyPycP7CLYQCiouuEDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825070; x=1693429870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fe/mUq9CZ5wWXabgCHcnUhruGO5Bjt72ZLYxIwhR76I=;
 b=A/UDRKjVaKop1b8II7AKdkDjrpyO0VQP0g0aZc6v2paDwgwWr3DL/eCIpxakfGgysu
 DSQegHRND977rnF/I/KzCMen2WSeIF4qXDoY04qkI8t7gq+E/WyVcPOafGc07U4Shhkv
 BcfKVNUq10ikxVoCV3gB0tOdJACyQp/O4SC9C4/+LvK+wb9mfpsE8BQRvrKUGTH23TLf
 RdrmogBB7VHmDpcrGbzvNqT59cNLswE25kt+2//w+T33C74w9V7BhIxl++nsBy3AhGbv
 kVlBzWlIjo1ofi1AgMTWcauA2sn/85gFXuBNsRvQxGeoStKIGZiLvD2T6/pkdIXEFumU
 knEQ==
X-Gm-Message-State: AOJu0YxlW/EwXx1qRA/F55oce+FJ4nXpHN4c7ig+Hr9n61SrBkwsEZmB
 HPTcxvC1lS5OF7EUQmcMzRgol4YVelqIG2jm5bQ=
X-Google-Smtp-Source: AGHT+IHSN7kriIHmXpntYJXBWp70q1cA6nBQrLdVQzk0RmY1kby0KdjdMOe3IFqp4WCsSOtLHk/N1w==
X-Received: by 2002:a05:6e02:160b:b0:345:d583:5c64 with SMTP id
 t11-20020a056e02160b00b00345d5835c64mr4603329ilu.24.1692825070294; 
 Wed, 23 Aug 2023 14:11:10 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 03/20] x86: coreboot: Rearrange arch_cpu_init()
Date: Wed, 23 Aug 2023 15:10:20 -0600
Message-ID: <20230823211059.1235147-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index 835b2c77746..c2ceaa9a56c 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -21,7 +21,14 @@
 
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
@@ -29,8 +36,7 @@ int arch_cpu_init(void)
 
 	timestamp_init();
 
-	return IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
-		 x86_cpu_init_f();
+	return 0;
 }
 
 int checkcpu(void)
-- 
2.42.0.rc1.204.g551eb34607-goog

