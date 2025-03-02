Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B07C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 14:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173EE811AC;
	Sun,  2 Mar 2025 15:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lmFs30fq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE0C811AC; Sun,  2 Mar 2025 15:22:22 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C429806FC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 15:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3D12C42829; 
 Sun,  2 Mar 2025 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740925307;
 bh=hPXN49o7XAn6aI1Y1GrpUpz8TAmRalDCwbJk1Nx+JzY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=lmFs30fq1LQ+kNAgbpaHyIAz/gnBqLee9vz4mF4hsuDTezwHX399Cha0euTIoK1Rj
 h+hmWYx5rVH1uwo1rzI5ILnwhc+HL/YY+jJMpPycFk1VN0ZcaJGZUTccEDUMhzksCD
 V4sXg23lFqpWUpnl18yJcxNRFz3ZhjAi2zNRP0QPFVyYc9FeoAljzGqeuSCrcMfzeu
 uik+WtvyytKFxKs3k8VcJXvvxFpe3ih6FYU3JlCe9sSJVY89yrszscFRKCPL5u6G8m
 8y1AOlJIq0/Dr7LYc2EoU9wnnqU/7Dx2acmNR94bmHa1hxx1CCu2Opnsctze4gdMtF
 XN04/4QN3zfXA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Janne Grunau <j@jannau.net>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/5] arm: use type jmp_buf instead of struct jmp_buf_data
Date: Sun,  2 Mar 2025 15:21:21 +0100
Message-ID: <20250302142121.150480-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
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

Instead of using the implementation specific struct jmp_buf_data use the
standard compliant type jmp_buf when switching exception levels.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/cpu/armv7/exception_level.c | 6 +++---
 arch/arm/cpu/armv8/exception_level.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/cpu/armv7/exception_level.c b/arch/arm/cpu/armv7/exception_level.c
index c63b0e13666..a55c158ce51 100644
--- a/arch/arm/cpu/armv7/exception_level.c
+++ b/arch/arm/cpu/armv7/exception_level.c
@@ -24,7 +24,7 @@
  *
  * @non_secure_jmp:	jump buffer for restoring stack and registers
  */
-static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
+static void entry_non_secure(jmp_buf non_secure_jmp)
 {
 	dcache_enable();
 	debug("Reached non-secure mode\n");
@@ -42,10 +42,10 @@ static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
 void switch_to_non_secure_mode(void)
 {
 	static bool is_nonsec;
-	struct jmp_buf_data non_secure_jmp;
+	jmp_buf non_secure_jmp;
 
 	if (armv7_boot_nonsec() && !is_nonsec) {
-		if (setjmp(&non_secure_jmp))
+		if (setjmp(non_secure_jmp))
 			return;
 		dcache_disable();	/* flush cache before switch to HYP */
 		armv7_init_nonsec();
diff --git a/arch/arm/cpu/armv8/exception_level.c b/arch/arm/cpu/armv8/exception_level.c
index 58e816007f0..746737861e7 100644
--- a/arch/arm/cpu/armv8/exception_level.c
+++ b/arch/arm/cpu/armv8/exception_level.c
@@ -23,7 +23,7 @@
  *
  * @non_secure_jmp:	jump buffer for restoring stack and registers
  */
-static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
+static void entry_non_secure(jmp_buf non_secure_jmp)
 {
 	dcache_enable();
 	debug("Reached non-secure mode\n");
@@ -42,11 +42,11 @@ static void entry_non_secure(struct jmp_buf_data *non_secure_jmp)
  */
 void switch_to_non_secure_mode(void)
 {
-	struct jmp_buf_data non_secure_jmp;
+	jmp_buf non_secure_jmp;
 
 	/* On AArch64 we need to make sure we call our payload in < EL3 */
 	if (current_el() == 3) {
-		if (setjmp(&non_secure_jmp))
+		if (setjmp(non_secure_jmp))
 			return;
 		dcache_disable();	/* flush cache before switch to EL2 */
 
-- 
2.48.1

