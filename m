Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098A606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FNJuQFW3;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JEvYLhGl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E5458127F;
	Wed, 18 Nov 2026 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuSvkDZyzDE0; Wed, 18 Nov 2026 13:19:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 55B3C81265
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007943;
	b=EabSV0/3lRU4c4J741UQVvxrRvbukAYvDQtZuQAKhbKiHE3NjUA826qw9S1uLgQ8DqPA
	 D+ko/GES63wfEnJfuWxBIGyTA+3VQtGIw7KMyvQP0RYC/fg73Brk8ZSM5iWA1KQPJyxVE
	 IItbBjXE09kau2n8xkC2JG2FRDJFcIGuKkVP//ilbGxovswZEg0n508vK900+cu2M/sfj
	 j6tTU3emkm0/WaMoBcwLT2tPHb7cV41W7aqsvU9fRvt7s7xRlN8yro+K1yywXCj+lZDxo
	 etaLuArk+9DGFhozKtlLJ6ie0siL8Ii8KTpfTXCEDCwS/GtfbzfR32QIA9vGfRZImCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007943;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1uCbPSEmf4z6NE2/NbwzqTjTOwAlCMFUh2mjZ1qzOPQ=;
	b=mILPi2E+VqinuJebEahL1rzx7a8JDJoPInDeUzrDL4PwXKd/ZJUzpH9/kfdEZrY16b4X
	 KLj60m5qC1p2iL1VjGqrsDhMSjUxtmwZmCCMqJHUItWRq4PKBzbwE6mB9jvm7O+Rf8vPL
	 9NxdoK6c0wLRQZ/+OWg/7lZqa5NF48HnE03BiARP7E0aRWJGOXA6BI9H30lvOMbHsp/LI
	 G0F0mZDJn5QQPVA7zbA510fTuCVPJXjmhHMKaiG6+Nh+Z6t3MPhFWe1ozEk48ZsLbSIS+
	 jRersp8K3kV+p+B2AG9oQz/l0P9FacBtg4pf5bErI15phncDNzvXlWAEEXhK0IbNO8g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007943;
	bh=1uCbPSEmf4z6NE2/NbwzqTjTOwAlCMFUh2mjZ1qzOPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FNJuQFW3HmBk1cFsZM87JEB29aAeTNwSAPjWFB0opt2LPuOw+3ZsmpXP8tqKl1PIs
	 iCtKCIpQJGb/HBdLAQ+QEqfNtcARZw8BPEvSCK1iUX02qAIPdGcpqWsF3H24OkORMe
	 v+gtKav7P/rEX5cN7TnM1XwmQeZnZdetX29Yz6yIme4vTxyvbVSEbVVY006y4YlApX
	 Gr+G1rfks47dQ5Peyhwbk6hyL7Y03kDTweaBpF1ESOiRPf+/s+Aj0pYCsMS9C670qC
	 6U3z+GqBFq3kxolEXLFscKZwfRI9fR+PpyfE+3KRu9a/ADP8tp8mIyErRA0kOIY5v3
	 ynrMwz4SpAhKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55B3C81265;
	Wed, 18 Nov 2026 13:19:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF16961
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E189E4047C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4eB2PvErDJJY for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EAC1340060
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=JEvYLhGl
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EAC1340060
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:19:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5E666C4CBDA;
 Wed, 18 Nov 2026 13:19:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 862AB5FE9B;
 Wed, 18 Nov 2026 13:18:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C69211BC1FAB; Wed, 18 Nov 2026 14:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795007936; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=1uCbPSEmf4z6NE2/NbwzqTjTOwAlCMFUh2mjZ1qzOPQ=;
 b=JEvYLhGlTkGMUpkLfuCOfkPsSpj6awzYlVwGxqeDvljw/iSEJru5un8apxW/0Gukcmdr/t
 7IdU+00ZrZPdoa6/JcuIndfWzzoU1+cTcczJgxczfMmPZNlQOelWUv5trRFxKi6R58BCrZ
 UiGu7IthJxiRMg5FAAHw5WcZjjis2p3h435ptjb/x1Cl1DLKVrjYqr8Qw2Uxa7lkboZjao
 kkVyHmz+xtrzLPFNXH9tp0At7c6PaaZ1puoJmOestjs5V4oiNDj+Enw4e6iB0qwGQPdKoB
 K/2AE7yoQ/yz1Or0/anE0v66evntxKpEx9RRxxHUQ1neXYAsonl0P7uiNyV/9Q==
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
Subject: [PATCH v7 11/20] ram: k3-ddrss: Add j722s DDR resume sequence
Date: Wed, 18 Nov 2026 14:17:58 +0100
Message-ID: <20261118131807.135859-12-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261118131807.135859-1-richard.genoud@bootlin.com>
References: <20261118131807.135859-1-richard.genoud@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As the j722s and am62p resume sequence differs on the way they are
detecting that the board is resuming, we should have a specific
compatible for each one of them.

For that purpose, introduce ti,j722s-ddrss compatible.

But still, j722s is affected by the errata i2487, so the same workaround
as the one done for am62p is applied.

Acked-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-j722s-r5-evm.dts    | 4 ++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c | 2 +-
 drivers/ram/k3-ddrss/k3-ddrss.c     | 9 +++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
index e1ef5d181ed7..cc4a5910673b 100644
--- a/arch/arm/dts/k3-j722s-r5-evm.dts
+++ b/arch/arm/dts/k3-j722s-r5-evm.dts
@@ -11,6 +11,10 @@
 #include "k3-am62a-ddr.dtsi"
 #include "k3-j722s-r5.dtsi"
 
+&memorycontroller {
+	compatible = "ti,j722s-ddrss", "ti,am62a-ddrss";
+};
+
 /* WKUP UART0 is used for DM firmware logs */
 &wkup_uart0 {
 	status = "okay";
diff --git a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
index 85fceb080d2d..cabdb3ca568d 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss-lpm.c
@@ -256,6 +256,6 @@ void am62xx_ddrss_run_retention_latch_clear_sequence(void)
 	 * DDR into retention mode, which will lead to corruption of the DDR
 	 * data.
 	 */
-	if (IS_ENABLED(CONFIG_K3_IODDR))
+	if (IS_ENABLED(CONFIG_K3_IODDR) || IS_ENABLED(CONFIG_K3_LPM))
 		am62xx_ddrss_clear_retention_latch_and_magic_words();
 }
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index bf917194160e..e4616036f15b 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -19,6 +19,7 @@
 #include <power-domain.h>
 #include <wait_bit.h>
 #include <power/regulator.h>
+#include <mach/hardware.h>
 #include <mach/k3-ddr.h>
 
 #include "k3-ddrss-lpm.h"
@@ -1305,11 +1306,19 @@ static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
 };
 
+static const struct k3_ddrss_data j722s_data = {
+	.flags = SINGLE_DDR_SUBSYSTEM,
+	.is_lpm_resume = j7xx_board_is_resuming,
+	.ddrss_deassert_retention = am62xx_ddrss_deassert_retention,
+	.ddrss_clear_retention_latch = am62xx_ddrss_run_retention_latch_clear_sequence,
+};
+
 static const struct udevice_id k3_ddrss_ids[] = {
 	{.compatible = "ti,am62a-ddrss", .data = (ulong)&am62xx_data, },
 	{.compatible = "ti,am64-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721e-ddrss", .data = (ulong)&k3_data, },
 	{.compatible = "ti,j721s2-ddrss", .data = (ulong)&j721s2_data, },
+	{.compatible = "ti,j722s-ddrss", .data = (ulong)&j722s_data, },
 	{}
 };
 
