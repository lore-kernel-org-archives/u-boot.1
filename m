Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72502C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCEA881AA;
	Wed, 15 May 2024 14:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PUh8s8jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3D588251; Wed, 15 May 2024 14:20:20 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEE588013
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 56060CE1394;
 Wed, 15 May 2024 12:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659C4C116B1;
 Wed, 15 May 2024 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715775614;
 bh=4ANO5RJZAlrrj3iC2MeWTBNIw4Nn9lMqb6J9geXM3f8=;
 h=From:Date:Subject:To:Cc:From;
 b=PUh8s8jlZoVHTlNJah71EckDkf2m4/aokcdyENwQMUxQVaWNUiv26sFE7fCA3MlQ1
 EoQ26iEuMPRH4MMacnyOYW6B6RAYNgc/ti63rnEB6JVNwv2LFy0yI0P/vPw30xGVSO
 2c2nMH2lOAILpV7FT5JN77Jhga7vD9KyZv0tbXQwvlamCAZS+bKocbHedPcYBuuI1y
 yoGz7iIsPIuy/I9F6MWzRAaRKZcCXTeXCnL3CVIQDNQpzenuvloheZJw58aKkqooCz
 ZkAv2hu58LEq3eucK1sCMKeW3jQr6Zzl0yQHYRhYVDLrlc2SYk0hQBbhjwhvaRaFtj
 Jn76u5sjKeCCg==
From: Roger Quadros <rogerq@kernel.org>
Date: Wed, 15 May 2024 15:20:08 +0300
Subject: [PATCH] memory: ti-gpmc: use printf to dump settings/timings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240515-for-2024-10-gpmc-printf-v1-1-025c78529d8c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHioRGYC/x3MQQqAIBBA0avErBvQ0KCuEi1Cx5pFJmNEEN49a
 /kW/z+QSZgyjM0DQhdnPmKFbhtw2xJXQvbV0KnOKKsthkPwA2qFa9odJuF4BvTO22BM7werodZ
 JKPD9n6e5lBcFcbdYaQAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, Nishanth Menon <nm@ti.com>, 
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4028; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=4ANO5RJZAlrrj3iC2MeWTBNIw4Nn9lMqb6J9geXM3f8=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmRKh8MaaZiFbckVHVMSN/OiaTLiblBU6svXj3y
 ++zNXmikoqJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZkSofAAKCRDSWmvTvnYw
 k3CdEACVFGUIu11fWzPIOoU1I0rzCGR1I2D4Hr3Lt541J49JlnuBtgGnqXXoSfG3IJoYBjk81bB
 LRUii42PvG1GSJNtKwGhKXtJ1calNq3j59CD3rFqRfWaQqODrz2ZkEg5oPstRzu663KEEZAHtxP
 GvQlev+JXeylpPBHfHFzp4kljf2dCOWEh0zxrXn2AcMLJaXIRfbZSHkdAj6ONMgpf66CnBDISx5
 P2J0nMcix/+zRhpfO6NrROaGb6bgbvIWW3IEJ8jCXmm5Nr2rD3CXiKQByhf+9lOq+GGoPFq6OWd
 LxGeNb6IrrqYfgtMuu5QymOc7b+S+h6J1ll9e9WHEJlSIj175EIZ8IRPRBE74HvhUbb7nj5IRDx
 oNd0f2dO0YKfQtYgAUKhEhpjsbJK4y3NOeZX1geB6KgN6/XfDWhpwkXTBNGmKKCOf0HMakmn2FL
 7dTrNsvKJx70In88f+llRj/dWIF9JkHIGMjq7pAJtS1vsRxD3upbdWlq36wPMbtucGr7Qoqq00Y
 bPFRQA0bZRmr10mltxwnmvJm3S45zcJCWD/daxs7jtR+Zkfz1+cp0nOxLHwYeKa5wmuVXTWaLjJ
 9KCDFR5yJfzKBwHh5DD4YpzXks/nF/etORGOlIdU/kvAjAJ/Yd3fEcvYL49XyaUwSj0Z7hYPzVH
 7wMuDKe0997d7Eg==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

pr_info() depends on CONFIG_LOGLEVEL > 6. If user has
enabled CONFIG_TI_GPMC_DEBUG then we should print the
GPMC settings/timings regardless of CONFIG_LOGLEVEL.

So use printf() instead of pr_info().

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/memory/ti-gpmc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
index 8af48e199a7..e979c431e33 100644
--- a/drivers/memory/ti-gpmc.c
+++ b/drivers/memory/ti-gpmc.c
@@ -242,20 +242,20 @@ static int get_gpmc_timing_reg(/* timing specifiers */
 		if (l)
 			time_ns_min = gpmc_clk_ticks_to_ns(l - 1, cs, cd) + 1;
 		time_ns = gpmc_clk_ticks_to_ns(l, cs, cd);
-		pr_info("gpmc,%s = <%u>; /* %u ns - %u ns; %i ticks%s*/\n",
-			name, time_ns, time_ns_min, time_ns, l,
-			invalid ? "; invalid " : " ");
+		printf("gpmc,%s = <%u>; /* %u ns - %u ns; %i ticks%s*/\n",
+		       name, time_ns, time_ns_min, time_ns, l,
+		       invalid ? "; invalid " : " ");
 	} else {
 		/* raw format */
-		pr_info("gpmc,%s = <%u>;%s\n", name, l,
-			invalid ? " /* invalid */" : "");
+		printf("gpmc,%s = <%u>;%s\n", name, l,
+		       invalid ? " /* invalid */" : "");
 	}
 
 	return l;
 }
 
 #define GPMC_PRINT_CONFIG(cs, config) \
-	pr_info("CS%i %s: 0x%08x\n", cs, #config, \
+	printf("CS%i %s: 0x%08x\n", cs, #config, \
 		gpmc_cs_read_reg(cs, config))
 #define GPMC_GET_RAW(reg, st, end, field) \
 	get_gpmc_timing_reg(cs, (reg), (st), (end), 0, field, GPMC_CD_FCLK, 0, 1, 0)
@@ -274,7 +274,7 @@ static int get_gpmc_timing_reg(/* timing specifiers */
 
 static void gpmc_show_regs(int cs, const char *desc)
 {
-	pr_info("gpmc cs%i %s:\n", cs, desc);
+	printf("gpmc cs%i %s:\n", cs, desc);
 	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG1);
 	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG2);
 	GPMC_PRINT_CONFIG(cs, GPMC_CS_CONFIG3);
@@ -291,7 +291,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 {
 	gpmc_show_regs(cs, desc);
 
-	pr_info("gpmc cs%i access configuration:\n", cs);
+	printf("gpmc cs%i access configuration:\n", cs);
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG1,  4,  4, "time-para-granularity");
 	GPMC_GET_RAW(GPMC_CS_CONFIG1,  8,  9, "mux-add-data");
 	GPMC_GET_RAW_SHIFT_MAX(GPMC_CS_CONFIG1, 12, 13, 1,
@@ -318,7 +318,7 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG6,  7,  7, "cycle2cycle-samecsen");
 	GPMC_GET_RAW_BOOL(GPMC_CS_CONFIG6,  6,  6, "cycle2cycle-diffcsen");
 
-	pr_info("gpmc cs%i timings configuration:\n", cs);
+	printf("gpmc cs%i timings configuration:\n", cs);
 	GPMC_GET_TICKS(GPMC_CS_CONFIG2,  0,  3, "cs-on-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG2,  8, 12, "cs-rd-off-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG2, 16, 20, "cs-wr-off-ns");
@@ -409,9 +409,9 @@ static int set_gpmc_timing_reg(int cs, int reg, int st_bit, int end_bit, int max
 
 	l = gpmc_cs_read_reg(cs, reg);
 	if (IS_ENABLED(CONFIG_TI_GPMC_DEBUG)) {
-		pr_info("GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
-			cs, name, ticks, gpmc_get_clk_period(cs, cd) * ticks / 1000,
-				(l >> st_bit) & mask, time);
+		printf("GPMC CS%d: %-17s: %3d ticks, %3lu ns (was %3i ticks) %3d ns\n",
+		       cs, name, ticks, gpmc_get_clk_period(cs, cd) * ticks / 1000,
+		       (l >> st_bit) & mask, time);
 	}
 
 	l &= ~(mask << st_bit);
@@ -618,8 +618,8 @@ static int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 		return -ENXIO;
 
 	if (IS_ENABLED(CONFIG_TI_GPMC_DEBUG)) {
-		pr_info("GPMC CS%d CLK period is %lu ns (div %d)\n",
-			cs, (div * gpmc_get_fclk_period()) / 1000, div);
+		printf("GPMC CS%d CLK period is %lu ns (div %d)\n",
+		       cs, (div * gpmc_get_fclk_period()) / 1000, div);
 	}
 
 	gpmc_cs_bool_timings(cs, &t->bool_timings);

---
base-commit: e7992828adcd5fad75bce9e6c41dfa9277ab93b0
change-id: 20240515-for-2024-10-gpmc-printf-dcd5f446d951

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

