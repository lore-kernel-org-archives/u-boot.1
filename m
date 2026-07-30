Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C9C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 848A180F3D;
	Thu, 30 Jul 2026 09:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8B0poquaJTWV; Thu, 30 Jul 2026 09:36:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79EF080EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785404176;
	bh=+xF4CtxPZ4gN3ulF3DqPZ/j5tftjBFf7ngWTkWmiGIA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wm2rRM+Y/Ed2R3iPfAvdH+CnYD9KTULesAYlvgzSE7IL03QVe9lsJJpCgBBKzVYyf
	 zgVXhrRpi4fbAmEhZCJccWm5Af4ioAbeSYuXWnqc9Y6MlDSRk0h7oL6annpbFLkgxJ
	 he27tHV2KGpBqBLcsb6TGuQ4nGAst+MaRSCo+QRNcTXyWVquUTw75WmN1q6trIxJEq
	 w9rb/Vq8RlsYK8Em++KtbKw2z2fnJL9z54FWsXmXVt0yCdSoPiSp24EkAkgGEa5mJu
	 YlYfVZW72o/OlPWQfnLEh/RHkw1ZKw7t3J1wmIwSYR1HF3pWeMr3X66R1sIRkTip2b
	 10d13ieX/RG/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79EF080EEE;
	Thu, 30 Jul 2026 09:36:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5A792CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AADA480EEE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gYD4Y4ZOh6i for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:36:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B2CFA80EB1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2CFA80EB1
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2CFA80EB1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:36:13 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso1298317f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 02:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785404172; x=1786008972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+xF4CtxPZ4gN3ulF3DqPZ/j5tftjBFf7ngWTkWmiGIA=;
 b=p9oK76JpGbv1Jn0Aipcz4bga/IYCqAEWa2f0kO62SaSeTHF03ObvluoDmVS6vP9Vtg
 3ZXNvpDWvrKS5TgPCUz0FjK4ueAE271uFLwWPMpEIYu4XzbJ7Zgz8QmuyBgDZM5odlZo
 UgVcwHoIyqismDNiKyx4DI/+MHqaOmX2J4OVooXxWFTLgneFw5TLDkD0vItTBqdCHvp5
 KtyRwthWoKaevyz20ikPjgYTujjckT6k2j8bAZcLJCnPwUrt7ETSOaG5Kera5+vXvqgL
 9INrURBpMNPBQ4AJv7h+Sie/KbAEetAxEh+2g/Vz7TAIrkmUb6Ai0/iLFDH5ANDI/xzW
 ORHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGD+3qebU47OEZCmm99zu7R9pbxbJIA6NRbyYzhgqDElcDoKyk0KJP64wu0CQq1+Xuviia7Dw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy7usP5yq8Sn+UQoqMNS9eHia98CAkn+X/dqSMd+Whl1vwKazRU
 Zd6YHzYVUu1oJIZ+RqLkemqA0MgIk918jXg4XiaKu8D/DFcdPpj3ws6i
X-Gm-Gg: AR+sD125c/dEd1duGhcQJH5SbLFAeJcQQ+g+R/qECkCMox36u0LfzHH0EoH0/c2jygV
 ig9TikcBWcoORX/NWr6PPaVQDKODpeAYDy9m9HWAD+vGIOgIgak88+ioIvdFust14G9uV0qOq8k
 rnhUIci7zuLX2OVcPt6PgcJW8GJmrnejf8mYWIGAotyr17jY/CMduRc/8yCCouISYOZbWTuBN8R
 3Y7pivvN+ziKJ9/DtS3KuzyWi9707TMwIMWRDlLHSm487pR5ubvJI6jW7quzFZP8sBmO/MTY8DK
 tZH1ehRx06IXoXUjtyZ3H+jt0zjyfvmhG+sJlC/Cv7BEAGvZQ0+hyQVMzri76ED8OsNANJHI2iU
 eYJNP6F/GHHAPNI4zyxeuKyf8PT5RwQ4oKzM4KuKsOiiTMPM0TQHcEGnNjSzksmeE96MQKCi7+a
 6jh8ZL/mIK2lWozseNwItgJubVWHaWeXhufvi8Rqlb2goVsEyDuarCUQkmcwx6Mk6g/A4bhong2
 Q500sDN7g3tokaiwYUoyis9Q3YVjCeMqVWyu3Jd8HamHllgxCHc3/ZbtkyuIfqLWIZf/nH00rrY
 fuB+t30=
X-Received: by 2002:a05:6000:400e:b0:47f:76e5:707c with SMTP id
 ffacd0b85a97d-47fc8214de1mr2195761f8f.55.1785404171325; 
 Thu, 30 Jul 2026 02:36:11 -0700 (PDT)
Received: from emanueleg-nb.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e439asm4243107f8f.11.2026.07.30.02.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:36:11 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 u-boot@lists.u-boot-project.org, Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] arm: imx: initialize the system counter earlier on i.MX7
Date: Thu, 30 Jul 2026 11:35:35 +0200
Message-ID: <20260730093546.2432933-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785404172; x=1786008972;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+xF4CtxPZ4gN3ulF3DqPZ/j5tftjBFf7ngWTkWmiGIA=;
 b=jUvh6K8N0+EnwfE0GZUE1Z8w/QAFDUu0wF5vIHOG9mW72sdut9AVzOFjmEydMG4bRZ
 5wHVEZE8UteakxE5Q2dyxf8e+/2z/9CHDMQphPspw5eSUGqiPP4Yz/mNKK3G4bs3X9ky
 bfV5kffKjV9NwzZe8QzwVfCs5cITvCKkgt/bF44duf+gAqqbiMrjLY1fhsKI9wE1N6PZ
 8uaNzlzrAn7wpC7ZnU+2hlwAuGAubxZZniIGSMasSS6srWzRBd0tMn7bgCr4fqn5SzN5
 ngfnqv3yOa7LAyjzLHohsqIN4hnWj1qE1uq01OWUMWw/6QBgEcyUAuxiJsr6SlfBq9s8
 LTfg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jUvh6K8N
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

imx_gpcv2_init() calls udelay(), which through schedule() reaches
cyclic_run(). Since commit 9c1b13b3fd27 ("cyclic: reduce get_timer_us()
calls inside hlist_for_each_entry_safe()") get_timer_us() is called even
when no cyclic function is registered, so tick_to_time_us() divides by a
still zero CNTFRQ and __div0() hangs the board before the console is up.
The requested delay was a no-op as well, since us_to_tick() reads a CNTFRQ
of zero.

Initialize the system counter before imx_gpcv2_init(), and move the
"already initialized" guard from timer_get_boot_us() into timer_init() so
that the later timer_init() from the generic init sequence is a no-op.
Where the system counter timer_init() is not compiled in, the weak
definition is empty and the calling it is harmless.

Fixes: b059837850e4 ("imx: mx7: add gpc initialization for low power mode")
Fixes: 9c1b13b3fd27 ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 arch/arm/mach-imx/mx7/soc.c    | 6 ++++++
 arch/arm/mach-imx/syscounter.c | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mx7/soc.c b/arch/arm/mach-imx/mx7/soc.c
index e504c1fd52a0..8a858dea5187 100644
--- a/arch/arm/mach-imx/mx7/soc.c
+++ b/arch/arm/mach-imx/mx7/soc.c
@@ -331,6 +331,12 @@ int arch_cpu_init(void)
 
 	init_snvs();
 
+	/*
+	 * imx_gpcv2_init() needs to do a delay.
+	 * Timer must be initialized before calling a delay function.
+	 */
+	timer_init();
+
 	imx_gpcv2_init();
 
 	enable_ca7_smp();
diff --git a/arch/arm/mach-imx/syscounter.c b/arch/arm/mach-imx/syscounter.c
index 96fe2c7c17bb..86311d0cc07d 100644
--- a/arch/arm/mach-imx/syscounter.c
+++ b/arch/arm/mach-imx/syscounter.c
@@ -65,6 +65,9 @@ int timer_init(void)
 	struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
 	unsigned long val, freq;
 
+	if (gd->arch.timer_rate_hz)
+		return 0;
+
 	freq = CFG_SC_TIMER_CLK;
 	asm volatile("mcr p15, 0, %0, c14, c0, 0" : : "r" (freq));
 
@@ -103,8 +106,7 @@ ulong get_timer(ulong base)
 
 ulong timer_get_boot_us(void)
 {
-	if (!gd->arch.timer_rate_hz)
-		timer_init();
+	timer_init();
 
 	return tick_to_time(get_ticks());
 }
-- 
2.43.0

