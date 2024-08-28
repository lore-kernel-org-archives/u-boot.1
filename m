Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD6C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD7E88A7B;
	Wed, 28 Aug 2024 03:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KA1+7TvR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1227488A8E; Wed, 28 Aug 2024 03:44:39 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A194E88A82
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-829e856a14eso98058539f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809475; x=1725414275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31RBrw/sCOf7pOdWYyBSNe+iQ4RRmPyJitIu9Aocug4=;
 b=KA1+7TvRTOzmURENTj4XTL4cNsv8kcCZFMVX0tYWpLOMZW7dgT1KV8jlCKNBr3P7RD
 pd3CEqHf2J41KVQswoPwn5xI6nTzBLcQpAQ0yzVr2lNjkvO7qwSfwp9vuoCTHpEkCdAE
 G5FCOMwUhRtqbiRFVK4++z1+a36IZ25gZbCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809475; x=1725414275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31RBrw/sCOf7pOdWYyBSNe+iQ4RRmPyJitIu9Aocug4=;
 b=rVLdUMCmdC+RKcmmdv8VU6gOfoZ7zKME82PaEyh5ImiCgBunzSrvI0BqpfjUS8TkQ7
 5ESCATH8893rfy8skl6yGO4jH/80rttdsBJt6wtGOexTAWZaJxFnlG/wtCqZd8iNHLlo
 lW4ydNnA2pP3pNeKE1f+STXJmfZZzo13Bt0ZIDOwT2uavSO88CsoVyglf6TVAQY0z5GE
 6Iorml+qxT9MEiVsMBF2DDsnEADXyirnJtkTIzef33qtuvXiRi11VUety6bZNiGhe/d1
 wI7HgO3ZeVmN0q+aotOcmIpAcsrycokN/r4IKWqonJ+odGAXy0Uv6dbhQS7r+Uf/oAM2
 Nkwg==
X-Gm-Message-State: AOJu0YxVvBEvS254/vs/8RJ97/dc8SjMTLeeB3Qq5GTcqyNIWcPf23iq
 6QdJTGKB+XHjrCwQPOrXh8qqDVzDmeSeTdrQGplm984be7huuzp1UDtCHqhzz0KEcZ8ghBadpH0
 =
X-Google-Smtp-Source: AGHT+IHsq6Y5yAWMsoZ0ubgP7k3cvaHgsUSOAeAGFbRpZOdu7OQr1Vtk9NHnSWEH3voChd19MgkdmA==
X-Received: by 2002:a05:6602:6b87:b0:804:2b28:75db with SMTP id
 ca18e2360f4ac-82787329bbemr1426889739f.10.1724809475283; 
 Tue, 27 Aug 2024 18:44:35 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH 2/6] x86: Ensure the CPU identity exists for timer init
Date: Tue, 27 Aug 2024 19:44:25 -0600
Message-Id: <20240828014429.3320011-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014429.3320011-1-sjg@chromium.org>
References: <20240828014429.3320011-1-sjg@chromium.org>
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

When bootstage is used the timer can be inited before the CPU identity
is set up, resulting in the checks for the vendor not working.

Add a special call to work around this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/i386/cpu.c           | 5 +++++
 arch/x86/cpu/x86_64/cpu.c         | 6 ++++++
 arch/x86/include/asm/u-boot-x86.h | 9 +++++++++
 drivers/timer/tsc_timer.c         | 4 ++++
 4 files changed, 24 insertions(+)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 101837b3190..3726f7ff78f 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -501,6 +501,11 @@ int x86_cpu_reinit_f(void)
 	return 0;
 }
 
+void x86_get_identity_for_timer(void)
+{
+	setup_identity();
+}
+
 void x86_enable_caches(void)
 {
 	unsigned long cr0;
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 80eab710315..71bc07f872a 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -75,3 +75,9 @@ void board_debug_uart_init(void)
 	/* this was already done in SPL */
 }
 #endif
+
+void x86_get_identity_for_timer(void)
+{
+	/* set the vendor to Intel so that native_calibrate_tsc() works */
+	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+}
diff --git a/arch/x86/include/asm/u-boot-x86.h b/arch/x86/include/asm/u-boot-x86.h
index 5cc8f63334e..64139ead190 100644
--- a/arch/x86/include/asm/u-boot-x86.h
+++ b/arch/x86/include/asm/u-boot-x86.h
@@ -43,6 +43,15 @@ int x86_cpu_reinit_f(void);
  */
 int x86_cpu_init_tpl(void);
 
+/**
+ * x86_get_identity_for_timer() - Set up CPU identity for use by the early timer
+ *
+ * The timer can be needed early in board_f if bootstage is enabled. This
+ * function can be called from the TSC timer to make sure that the CPU-identity
+ * info has been set up
+ */
+void x86_get_identity_for_timer(void);
+
 /**
  * cpu_reinit_fpu() - Reinit the FPU if something is wrong with it
  *
diff --git a/drivers/timer/tsc_timer.c b/drivers/timer/tsc_timer.c
index 80c084f380d..d11227cf440 100644
--- a/drivers/timer/tsc_timer.c
+++ b/drivers/timer/tsc_timer.c
@@ -403,6 +403,10 @@ static void tsc_timer_ensure_setup(bool early)
 	if (!gd->arch.clock_rate) {
 		unsigned long fast_calibrate;
 
+		/* deal with this being called before x86_cpu_init_f() */
+		if (!gd->arch.x86_vendor)
+			x86_get_identity_for_timer();
+
 		/**
 		 * There is no obvious way to obtain this information from EFI
 		 * boot services. This value was measured on a Framework Laptop
-- 
2.34.1

