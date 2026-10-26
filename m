Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NjVqRuAm;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sPUsAxSI;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=dwn/WZZA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5728780D2C;
	Mon, 26 Oct 2026 22:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSDC248T67tA; Mon, 26 Oct 2026 22:55:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4115680C4E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055333;
	b=syYwu3ZbGf+JEh+i8e2kgVz10xaP6+J9273OHFLwc1BneJS++0UzOjKBX+GGH0e7hru+
	 ygqrjga7rVHrecN4LxFhHm52W4b/616qvjp0qAsJ0AbxSIEozFuhnZod4InJdNAXFQ5+D
	 CI8ZRxIXn/+XVDtK1Xs1SjO2L//v/leBllE9QDJscCn8tFF9rJsR2exHEZBQSDwcI6aEt
	 68hLEleRS5j5xUDjkTHdCDvDuGrrabz2frohwCFY/NhoziPlTZ3ge6Ox0cEhlhGhbA/Qh
	 TKCiqjUZoJ/o5yQHOX6yCPpI4ZKCBMGJgUQgDOtMWpKNHS9XHKsFk/InFz/VlHvCbjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d2kosJnBK1q/Af76lI3zY78vmtG+d7zRCHa+rlVyAKo=;
	b=g0bMB1tgUFyumlkNFuySCUg6aB7CcJfwUjxHm2uA7MVqwE7K0NROk1T9+USLrcaEzUII
	 8m1csu/dU2GHS4RKBiV6LYihMzkag8xRzZg7Z0H9bP+fXMV8wdCylG6PYx2NyKAXgDDbB
	 w9i34frm6X7bYHAKTAF4oOqQM6rZwI43T0DVX3ZvFj4OSEDFogb+6GPPGGc4UfLFPUwmA
	 lJtFhulhrPLB2B6CJwLbVPFb6zqDKcXtFeTxyFwPi7pdLsV0J35Ohyk/KqGKkstM6Mcfg
	 fKaRb7neckWMiI504SIXHt/jDf5KMtHWRjHCb4HGeO3dKGik6RvDtUAW/L8KQ0Jgezg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=freemyipod.org;
	dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sPUsAxSI;
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b="dwn/WZZA";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055333;
	bh=d2kosJnBK1q/Af76lI3zY78vmtG+d7zRCHa+rlVyAKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NjVqRuAmsY0k5c5KT5PJlYiLJ4qI7IjcMV6SfC9CspG+AbuB3HIqtQYzVaV7bGJwo
	 uI7OMBIMG8sCrncNREFcSz7rxdNIvYmWqaGADyoim2P9DJIN9WgtDVI3P0lg5M+5ZB
	 0jDGwvjzzpEco24733fPntf4ySLEHBQrpmxEPC4D7sU2wbSeUJnQjZrIjkanNwsXVR
	 HPW5mIokLRzNDSYD1DQ8f50HkqfiSALc39HZIjPmi/15F9KnJtx+6UHZmbTqgRYGvh
	 wJufNaOtUPZydWRIhR2YRCufZxnCPNs4OGX0KSK4gp9b8DEHPMJLrTpUYDhIBYcjYk
	 3HMsiR/UWSKiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4115680C4E;
	Mon, 26 Oct 2026 22:55:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BCFB2AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0D41D80C0D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cqkhz7Yca4y0 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B621D80963
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055315;
 b=ZLK/dvH/X31M9CQsracRyN/Pei1k72pO9BF9PaK9HAfsmtFYrGwuy9Z86RCQNMhu5HLh
 t/ByTBckLC+bwQslYyHoGMaZvQ+32esim/HVsn/M+Ms76kSWqs6Mlw57+BYIBTeOPUaWS
 v/kZovyQuWYzfuVF4sVN+u1lqYuuOip1mDOUrzaBHAj43vklkpodavhxrOgKc2POwhrxd
 i1tNd7iiQpwMIJHBaTP9AIW2GNJuZFJUiq/DfSNAk6/HLY6H8Hjevvldf3XudQNY4a304
 aLFC5w0xStKGFarpLswHL7Xw2nb9NkD7D9DNhPKxrmJLG0sk+xh7PFIePWc9W09ySoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055315;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=d2kosJnBK1q/Af76lI3zY78vmtG+d7zRCHa+rlVyAKo=;
 b=RkCl7jJG49veZTaN6C8bCv+5pS7SWWEDWKfeKBszfNduzKDHOWAHTy8cAUVirFsN8L6/
 YF5KZflvvPlebdVZORBzzx4qzKVcsj3JX0OcDANG80a36EBDnS/gVZNuogdRDfl7V/DFm
 4+1s2ZqkTLp2aS7bbOI4/u0JDyOfdKrE2YPnnVdWnE62sW0+3/3ejKOzk4k6Kwn0z1qT/
 hoXIk85FN9Pu7nasH2aukxwj46WAxx61OJxT01p5n7PROuCFXOpfQCYiEtIhiCiOjKuD7
 XViMF7Ljl7dCKI0mHiYSZetOK3WNNqn7p5yUtm/zQEFy0IjfYiNUbXD8gh1bO4wemsQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sPUsAxSI; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b="dwn/WZZA"; 
 arc=none smtp.remote-ip=69.169.224.10
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.10;
 helo=b224-10.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cc81c-191d98e1-9fc3-4d38-9c27-da76c570b154-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sPUsAxSI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=dwn/WZZA
Received: from b224-10.smtp-out.eu-central-1.amazonses.com
 (b224-10.smtp-out.eu-central-1.amazonses.com [69.169.224.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B621D80963
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055312;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=5RJ7VGLp3nyFdBbScGZNLoTXng1pDfTsukx3fnmEQ2I=;
 b=sPUsAxSIBE/52nAdMU/iZdBbXPPeQnQrk/6JGmWtKH82ROsKKdTJrNCv9POpbm7/
 F+aVhnp8qV9OzfAm83dVT6mKVLT+ngnAP8X7pwdnyaC53uXgTy4F/yErEFDLYQjYouK
 UBvd8YcR5ikxBYftRVVaygUIcW/3TafY54NwHFbKLTagb2LxWHO1nreCsWY698kzKf1
 HZwcgW4JCvVRP5X3CAq2vskYKIZzU7DxLQ88IvdAoCIM1Hvn0+FPl0FIoW0N4McR4Le
 LAV3QobV66/aw1TVjgrjWBFlNvi0WlH27+8vmK5/mzq9Oqbp8qQTFGVzIXTN+eW9Onb
 RwG+WqHB7A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055312;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=5RJ7VGLp3nyFdBbScGZNLoTXng1pDfTsukx3fnmEQ2I=;
 b=dwn/WZZAWoGURWYNil7NLwQRUBLzDaExrU/vGAQy8OCBwzf/Ds0tMVysMwz/28gK
 liFrC2oa6kUBfW//KImwCV5CPiFfrNwsfEaQAgzF2MK1hWgEftLP6b2k+r2b4zWgVFv
 Ys6Hbk24BRS9MRDezXeQuD2GKd+XRAvcZOXVMZA8=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:11 +0000
Subject: [PATCH v2 13/14] New SoC/board: S5L8730/N33
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cc81c-191d98e1-9fc3-4d38-9c27-da76c570b154-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=8793;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=5RJ7VGLp3nyFdBbScGZNLoTXng1pDfTsukx3fnmEQ2I=;
 b=syYL7KDYonrFyAf8q6CVovcTEDf/HzL3qH5cIVLZ1E3sokVXxQzlX3MK9HSa6PA+EKX/PWvd0
 sybokGtgAo4AiaqaXgW20mQ9mG/xTQRrQFGcT2clmSwkn4sThu9tDU4
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.10
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

Marketing name: Apple iPod nano (5th generation)

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/dts/s5l8730-n33.dts          | 26 ++++++++++++++++
 arch/arm/dts/s5l8730.dtsi             | 42 ++++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig         |  1 +
 arch/arm/mach-s5l87xx/Makefile        |  5 +++
 arch/arm/mach-s5l87xx/s5l8730.c       | 18 +++++++++++
 arch/arm/mach-s5l87xx/s5l8730/Kconfig | 12 ++++++++
 board/apple/n33/Kconfig               | 15 +++++++++
 board/apple/n33/Makefile              |  7 +++++
 board/apple/n33/n33.c                 | 57 +++++++++++++++++++++++++++++++++++
 configs/apple_n33_defconfig           | 33 ++++++++++++++++++++
 include/configs/apple_n33.h           | 16 ++++++++++
 11 files changed, 232 insertions(+)

diff --git a/arch/arm/dts/s5l8730-n33.dts b/arch/arm/dts/s5l8730-n33.dts
new file mode 100644
index 00000000000..fb2fecedf09
--- /dev/null
+++ b/arch/arm/dts/s5l8730-n33.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (5th generation)
+ *
+ * target-type: N33
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8730.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n33", "samsung,s5l8730", "apple,arm-platform";
+	model = "Apple iPod nano (5th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8730.dtsi b/arch/arm/dts/s5l8730.dtsi
new file mode 100644
index 00000000000..902a8ac5dc1
--- /dev/null
+++ b/arch/arm/dts/s5l8730.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8730 SoC
+ *
+ * Other names: M2
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8730", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm1176jzf-s";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate.
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer5", "timer6", "timer7", "timer8",
+					   "uart0", "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <59 133>, <60 134>, <69 150>, <70 151>,
+						  <41 135>, <2 0xffffffff>, <35 0xffffffff>,
+						  <13 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
index f40a340312a..3ec2326de42 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -61,5 +61,6 @@ source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8720/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8723/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8730/Kconfig"
 
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index ff84eff8448..78ea7bc58d0 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -24,3 +24,8 @@ obj-$(CONFIG_S5L8723) += relocate.o
 obj-$(CONFIG_S5L8723) += s5l8723.o
 obj-$(CONFIG_S5L8723) += s5l87xx-otg-phy.o
 obj-$(CONFIG_S5L8723) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8730) += relocate.o
+obj-$(CONFIG_S5L8730) += s5l8730.o
+obj-$(CONFIG_S5L8730) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8730) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/s5l8730.c b/arch/arm/mach-s5l87xx/s5l8730.c
new file mode 100644
index 00000000000..f0970e21cec
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8730.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8730 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8730/Kconfig b/arch/arm/mach-s5l87xx/s5l8730/Kconfig
new file mode 100644
index 00000000000..4ca87a2f52b
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8730/Kconfig
@@ -0,0 +1,12 @@
+if S5L8730
+
+config TARGET_N33
+	bool "Apple N33 - iPod nano (5th generation)"
+	default y
+	help
+	  Apple iPod nano (5th generation) is a digital audio player, introduced in
+	  September 2009. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n33/Kconfig"
+
+endif
diff --git a/board/apple/n33/Kconfig b/board/apple/n33/Kconfig
new file mode 100644
index 00000000000..5c9dea9fbb9
--- /dev/null
+++ b/board/apple/n33/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N33
+
+config SYS_BOARD
+	default "n33"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8730"
+
+config SYS_CONFIG_NAME
+	default "apple_n33"
+
+endif
diff --git a/board/apple/n33/Makefile b/board/apple/n33/Makefile
new file mode 100644
index 00000000000..721718361e1
--- /dev/null
+++ b/board/apple/n33/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n33.o
diff --git a/board/apple/n33/n33.c b/board/apple/n33/n33.c
new file mode 100644
index 00000000000..ec6dbf01714
--- /dev/null
+++ b/board/apple/n33/n33.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/clk.h>
+
+static void board_gpio_init(void)
+{
+	// UART0
+	u32 gpio = readl(S5L87XX_PCON(0));
+
+	gpio &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	gpio |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(gpio, S5L87XX_PCON(0));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+static void board_vic_init(void)
+{
+	// Disable all VIC interrupts.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable clocking */
+	board_clock_init();
+
+	/* Configure VIC */
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Enable GPIO pins */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up, so ungate uart0 by
+	 * raw {gate, bit} ({1,9} + {4,7}) rather than the device-tree name lookup.
+	 */
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/configs/apple_n33_defconfig b/configs/apple_n33_defconfig
new file mode 100644
index 00000000000..3a9cb4fe817
--- /dev/null
+++ b/configs/apple_n33_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8730-n33"
+CONFIG_S5L8730=y
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART=y
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_FIT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_CMD_DFU=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/include/configs/apple_n33.h b/include/configs/apple_n33.h
new file mode 100644
index 00000000000..a00e773746f
--- /dev/null
+++ b/include/configs/apple_n33.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+// 448K SRAM total, first 64K and the 256K at 0x30000 are the fastest
+// 128K at 0x10000 are slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00070000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

