Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555D3C98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DB7180EEC;
	Thu, 24 Sep 2026 12:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pY1jPS4MZSp2; Thu, 24 Sep 2026 12:37:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 436DF80EEF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253438;
	b=QksA/BpO9V5SS/dnFRmA8uvsIojAKuqILcKeJ9/tAv1r7T33yLRsHn5CyxuekL00Nwu1
	 y3bESmPtjBHVi+svkmA8Q4QU0AgPaMS3FTezArTqTBuehKaEU7yOzERHVGBoN6QlfV4Bt
	 HToLHz2j9s5+iQmbFaXjN2qhr26DCzPefrrzKSqpzUYzNaDzbDU2QS60U/KUe/ZniUivm
	 PUbRvAOFmhHRab/PbKk4Q/xFm03EKqiTsOC2xC3gWFynW2ZhiXLhxW4GlkBextcoSgW+u
	 mXJXjx7/KSQkvizrDcUs/aohkJfovzWbmrBfio48gxfyymRgD6q4n4A/zJU+3g9hvJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253438;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8iZQkYV/T7wb2p68UI7XGCTpp/V2HE/4gzLzwu9RLJQ=;
	b=KKge76KBXkGquHBl5Na/9aMwaLNAki2nVvabP9zXxkbJDPwIsvQ7wzL72eXOdFLcldJi
	 NpKs/c4/hYrBXXuTaaHuE5+UEJqgxB5jPcND4P6xNtazLMgcLsaz/pZBcCAUOOCkXRA1v
	 T619hCwhFKY2uBEmjNK9Su3/b3q6yTqjvz7N5qhRDXIEaZ4EjrYjsLXYnRQKFd6LdU8Pp
	 Ka9d0TWvHtRkMWVe8X6ybvVZcoV0F3Os1h835VY2vrzjxx/nVmQ+VtI26DuIMBKTL9db3
	 2t5dRefZXUeYYJOrvDIgWzqVem27UPPm8tuuZxDHPshsmU6y0AlqvTvVJBT1BfeYO3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253438;
	bh=8iZQkYV/T7wb2p68UI7XGCTpp/V2HE/4gzLzwu9RLJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oCyejhYvEXdFq0NTC7fz1Q0WWOyvDlAJYSbhLTWf5B8eTnQLDYfvR/jD2iks2wadW
	 O0w/ULjTjVQFM0+GCT1iA0uG2Hm/klL6BXOe3Ge3orK4dAfeuh7pHe++qfXD5TNEcZ
	 iH9nOX73I2H6YDJleM0Tt2EHfIyme2KHP7Gy8Gx7sO3HKa+igN3IXvpUi/+WA0ddK9
	 DM4XgLlZ64SLQOCFUWqbhx3g7NvMdHeueZkn7Vx0eQqqP4Ej4lINWC1LH6H1dJhMMN
	 PVC1bhRv6FbnwQhYCw39RfEVTlj0xrcTptExbpONiwN7Jy/jG3Sn/QzdlHR79RktCL
	 AVnfDFQDk31Cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 436DF80EEF;
	Thu, 24 Sep 2026 12:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3498A35A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25A4440D1E
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WZ-3wkW3hwFU for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EA9C840D72
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253436;
 b=FwbnsumUMw1PXFFNY4EBtAybhPcJ+ofCHJG0YDAW3PwiTLFtNvyGDBtJ1/HKxAlM+nnd
 SYKZ5jDH553kJQ+1VpXod7RUdTvCBvpORBJl0nmWX4ycaWuCtx7RiomqMbknqPXd94uvi
 svurcHTOuJN4YqrZCcS15UbI40DxmIvNPD1DBswYVwzLBNYSLYUEPiB/Xy7v9zFkQbQNd
 0AJLOly9zPieQqs00ZEIhJDySCd7fUlH3m4pA8PfzUY5cxJv8GpD0w2NXA8JjUm/cfdgZ
 zuttxuYUnowo/7yNRzoeK9Tvu3Iqq3dQRG4XukkeMZJmNvY1lF45g8yWXOjMStZEFmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253436;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=8iZQkYV/T7wb2p68UI7XGCTpp/V2HE/4gzLzwu9RLJQ=;
 b=e+TIOurDhSDwB5rRgmFPHveuwKA9x4Rf7fxH0TUUsAXC1kNLZZ37xe4O8sQqwGim15iV
 qg1gswztVSobUCDPG0toDefwcVoVjPnVS3uWxRO0eb8PHl8mE/Qu9zQ7980EKbgzf5aFE
 4TPvCxzXQbTLEHQ+eyA9StTeEEY2hcWMEGJr3b89I519bMDzTeTzrDB37s93nMgwELdrD
 +d0PPiONYgVrJzm+6nsbM09F2Yqf3iDE2ri7fKewgM8EehI3EXV8kRF6qkC7dzjJo0RzH
 6PcQ11g2shhU+PAYZWhUOVPvQdUHAU+tovw38Ac0D9AV5IQvL4qum71+01gEB4T6hDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b="ioo/X6D9"; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=ioo/X6D9
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA9C840D72
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CD9A1C211C1;
 Thu, 24 Sep 2026 12:38:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6207160341;
 Thu, 24 Sep 2026 12:37:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 93B7310329456; 
 Thu, 24 Sep 2026 14:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253430; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=8iZQkYV/T7wb2p68UI7XGCTpp/V2HE/4gzLzwu9RLJQ=;
 b=ioo/X6D9cnbNWRekkXnpcmuXQ1XupLUA2lgHkXmiAKowuUnIoLv0B1cMbP8rhd39aTtmqo
 XNqtSekc0UuTcTASN2bNmE8yWO+jAfWyV0p/HZd1Me5WDu6cdyDK6LREvb28YG4RO0HsmN
 2FdtWPuhzCKylXNyZzEoQPG6JAmeWUTaJE/fy6aMSlOqb2Fta397+v4eDSvy0CB4EZSNfv
 0+IzM3uOfqy1B7jEU24zG9LabcRiryArZDZiq0o5jmbF6dPhbutJ9JLQm7RQqZpYIBu78D
 fKgWHAbegpLXvYtLmEiicI/p3+VUiZs1Zcbih7YhVTEq8iZi5o7kz3FB54XNJw==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 18/22] arm: mach-k3: j721s2: Enable LPM resume flow
Date: Thu, 24 Sep 2026 14:35:29 +0200
Message-ID: <20260924123533.2599438-19-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>

First, set LPM core bus path and compatible needed by extract_lpm_region
to find lpm-metadata memory region (at boot and at resume time)

Then, add the board specific part of the exit retention sequence for
k3-ddrss:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power
After that, the generic resume path is run.

Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 57 +++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index 780d853423f8..d301525d2455 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -16,12 +16,20 @@
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
 #include <dm/root.h>
+#include <mach/k3-ddr.h>
 #include <mmc.h>
+#include <power/pmic.h>
 #include <remoteproc.h>
 
 #include "../sysfw-loader.h"
+#include "../lpm-common.h"
 #include "../common.h"
 
+#define MAX_DDR_CONTROLLERS	2
+
+/* DDR retention bits */
+#define DDR_RET_VAL BIT(3)
+
 /* NAVSS North Bridge (NB) */
 #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
 #define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
@@ -262,9 +270,12 @@ bool check_rom_loaded_sysfw(void)
 void k3_mem_init(void)
 {
 	struct udevice *dev;
-	int ret;
+	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device_by_name(UCLASS_MISC, "msmc", &dev);
 		if (ret)
 			panic("Probe of msmc failed: %d\n", ret);
@@ -272,10 +283,48 @@ void k3_mem_init(void)
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+		devs[0] = dev;
+		ctrl++;
 
-		ret = uclass_next_device_err(&dev);
-		if (ret && ret != -ENODEV)
-			panic("DRAM 1 init failed: %d\n", ret);
+		while (ctrl < MAX_DDR_CONTROLLERS) {
+			ret = uclass_next_device_err(&dev);
+			if (ret == -ENODEV)
+				break;
+
+			if (ret)
+				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
+			ctrl++;
+		}
+
+		k3_set_lpm_core_bus_node_path("/bus@100000/bus@28380000");
+		k3_set_lpm_core_compatible("ti,j721s2-r5f");
+
+		if (j7xx_board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_ddr_ret("pmic@4c", DDR_RET_VAL, 0, false);
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+
+			/*
+			 * The DM (PDK) doesn't support being started with
+			 * caches enabled, and there no gain enabling them here
+			 * and disabling them just before jumping to DM
+			 */
+			do_resume();
+		}
 	}
 	spl_enable_cache();
 }
-- 
2.55.0

