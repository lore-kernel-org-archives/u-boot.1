Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DF606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NOWcZp8I;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=CpQr4nUX;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=ApghChq3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74CB940621;
	Mon, 26 Oct 2026 22:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22fbFmurAAdq; Mon, 26 Oct 2026 22:55:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 313E8405E3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055335;
	b=NZZLg1C+Ur0PekiWVNjju2ahohvfqbY8rYk27F7hcWNlwWZI1b+dtoe3NvRe4/qMzImf
	 eSr7wZ56yXP2VPmNp/6LS/Wx8a/MWcFADZLk5WPANT/4eCfJkIAMWQb+QnTa0rdEIftx0
	 BlTBQKFZ982/s7D5jnOaMiW+HsI6SVT4wOW6v/mCTPjZnUpXSMBXJtvJYu0PJnEKMRRtV
	 QqKW5Zun22ZD/yTT/NgokQGxrsF8oyHBffWm+DmuA1yn5VjmPeoQDpjp13l2iLzdbR4V1
	 +bJ2nVEyvfKn80q13pVQSGYslKL+8upDgh/SkusIfa/2D3p0uBhxRBp0dElC3+DUCxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z9ZB7bK2dXveds5m35i5ppHq9KBoiepK1VVI43jRiTM=;
	b=nxkR37OuOhZ6v3E9KBSOVM7GnE1tS8WYUlBI0SCuWGrjsL90AdEVRUaumFVqXkZLkMqH
	 0651fkZ0qlbBDDLYQRSU0E79MCRxXaMT6AJgX2/tE1RCF4h4TEM2PgvrkGseYuwIoBxgo
	 EkJsSbTtfIn/wQRH4XdNUapA4PQOOfB6GNCryp6DPAJ9tbBNi4t2z2YRBp2ZeTduK4Oh9
	 tkerdyXisL2j43hrNFangxNYZEvIdkwJFQYRGDez4dytauPRW/u4VqLRTDHl176owAonw
	 2ertePxKDgZi1qvCDNq6eeo2sg0M3WrPsXbf1C7lEVvX/Ubdsn00UeZjRayxxokemGg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055335;
	bh=z9ZB7bK2dXveds5m35i5ppHq9KBoiepK1VVI43jRiTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NOWcZp8I6k50f4Vs2+bmxIwnXOkaxmBx0YRflJCh0UX2M4a5zMPlhLrZHf0r0xWWV
	 kHUYNp9XMMqEtSHTlKk5RmTXnjzTBGFFcGPzBgBBaa9jLjUJuD3EYTOwy+4IwBdJ4D
	 Lx0ZsOQAzlLb1emwQQI5CjzejVX8OYij8W84EV2EBX1wu/HxRSWEM8yl4GqPh3huQe
	 oxpPPKK2d8XraKe5MvmOxVYPaxyVg9xoGv2PBdJv0KZSL+s4+6q2MAOvQ/M/sPHhWs
	 fC2bunHUSpfHuwyya5gc13s7gxbqvoEQPNdDRuWZIvS3EuyL+H9wWMuQywtPCR7cfs
	 EZ/6TbYCKQdPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 313E8405E3;
	Mon, 26 Oct 2026 22:55:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 250C22AC
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16B3680C0F
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0xGhrmngGM67 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A32680A8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055316;
 b=labu8BCjGe91/BiW9CSMs+U6B+ru5LcVVKueBo/28wbY9zMTx1rc8cJpHRRos3N2eVIT
 Svhiw+vlrOgZ/qSCN6IB/FI0VVVr7YZbGk6dxZcYSqig3KtTCZxblin3j4nxUE+7Z74Q8
 f3qHXvOTt7W58Ljt+USqC5chI1D9HpO8RdF1MDq+xKZsd7p+b3b/ezP+FSQ5g7/62uo/6
 H+IaRroEX4gl86ARD/G1mFj7PL+cFaW5hGSip1Yo6Gkp6zAms5XO2fcf3u7PU22PhIh41
 dnb1+n9iCHbCbTx06d6O3HNpDd8/0tZtGIbFhtDWmgeGNtjPqbSxKL5dYUJ2o5uhl8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055316;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=z9ZB7bK2dXveds5m35i5ppHq9KBoiepK1VVI43jRiTM=;
 b=DCDTZL7DscFWnQ+vbo1pNQS2PSrCEyyKfgTlLjGgSDW4qq7V+KyTSOPAqIMeSqOM8nXU
 6Rkfo2JgO3MAJIJr/DRXJPjtvxaO4CgDW915C4TbuBDSqaHyjZGeGsuWhvdSLOVdrFbl6
 A5vGziT+xm38TjKwolefRCvcmUSUcL5kFS/Mg01JTAkMrXcYMS890dRQsV6FT87aGkm4W
 iRugtYiN11CQTkvX5f+KYZMnw9HznQeqqg1iTojEZ4MM+d7kpaBYU5A3MVnxgh3PD3abd
 w6zlbbfM+GhtVLWDHyztur7mtI907t/ssEXd1HYaA7dEYx9AyJrtpLFAer8iWjlXPNw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=CpQr4nUX; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=ApghChq3; 
 arc=none smtp.remote-ip=69.169.224.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.8;
 helo=b224-8.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6ccae8-743d53fd-3f9f-421f-b574-b1fc32b21f09-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=CpQr4nUX; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=ApghChq3
Received: from b224-8.smtp-out.eu-central-1.amazonses.com
 (b224-8.smtp-out.eu-central-1.amazonses.com [69.169.224.8])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A32680A8C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055312;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=u9hIu72V+wbnbN4uz09I9/Gi1XnHC17Gbnrod78dl4o=;
 b=CpQr4nUXwPdIWpS19A6xXYJLL1ep6RGfXFsGeCditZ8ODB98e1jFhud5KxzQp9sg
 OAEf4qOvCzLYqdoMSA7U7UCg+uezQYGCg866uzc+ZkYmxlrLaBHbhvcWb6kSVBuBF96
 D8gyF2TRcZZU1kUWb2aesyOlKFj/8svfnznVPHXgdSqJ4ChSk/69gAoluNpcyrRNNjX
 D8XHNVpV/xpMgnZ2XYaNLPQ4jjxSQWi6lp9j/DkM5AovR4sOlA5nRHIm0hNfdwzT7ib
 gVd0J6Sh0psI7OHsGjeAuulL5SXYL3ob4rbqcQu95TpaVJ8VsqYX25oVQy/FwKF0l87
 3wdeBqAPnA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055312;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=u9hIu72V+wbnbN4uz09I9/Gi1XnHC17Gbnrod78dl4o=;
 b=ApghChq3PDw+MgAsKw1iJFo/z5OyCv9uaVTZJpq6zPekn8qlaxM3aCXyScHoLQ/L
 KkU0h+YfC3HblkAMfNHcJ1Serj741o/bNnQDKhZTRx5R619NXvATT4l2LmuAFkUpfAP
 KtdG55qz8Qv58bK0ivsaN5okd5PPOFg+150eRcUM=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:12 +0000
Subject: [PATCH v2 14/14] New SoC/board: S5L8740/N31
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6ccae8-743d53fd-3f9f-421f-b574-b1fc32b21f09-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=12659;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=u9hIu72V+wbnbN4uz09I9/Gi1XnHC17Gbnrod78dl4o=;
 b=IgG7PiRJbCslTpqmKsH26fAi6DnwLWHjOIvrgjmca8WvhqWiB94XeKk4pDpNM/1LIEhUDWSAr
 CwkJGmp18UhDpaf7nTN2S2/6wqs3cqQJ/wV2eq6j3thRBp6BF9txHNO
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.8
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marketing name: Apple iPod nano (7th generation)

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/dts/s5l8740-n31.dts            | 26 +++++++++
 arch/arm/dts/s5l8740.dtsi               | 43 +++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig           |  1 +
 arch/arm/mach-s5l87xx/Makefile          |  4 ++
 arch/arm/mach-s5l87xx/s5l8740-otg-phy.c | 75 ++++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l8740.c         | 25 +++++++++
 arch/arm/mach-s5l87xx/s5l8740/Kconfig   | 12 +++++
 board/apple/n31/Kconfig                 | 15 ++++++
 board/apple/n31/Makefile                |  7 +++
 board/apple/n31/n31.c                   | 96 +++++++++++++++++++++++++++++++++
 configs/apple_n31_defconfig             | 31 +++++++++++
 include/configs/apple_n31.h             | 15 ++++++
 12 files changed, 350 insertions(+)

diff --git a/arch/arm/dts/s5l8740-n31.dts b/arch/arm/dts/s5l8740-n31.dts
new file mode 100644
index 00000000000..a5248ba06e1
--- /dev/null
+++ b/arch/arm/dts/s5l8740-n31.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (7th generation)
+ *
+ * target-type: N31
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8740.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n31", "samsung,s5l8740", "apple,arm-platform";
+	model = "Apple iPod nano (7th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8740.dtsi b/arch/arm/dts/s5l8740.dtsi
new file mode 100644
index 00000000000..e14a1d0c10e
--- /dev/null
+++ b/arch/arm/dts/s5l8740.dtsi
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8740 SoC
+ *
+ * Other names: M2R
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8740", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart3;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,cortex-a5";
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
+					   "uart0", "uart1", "uart2", "uart3",
+					   "usb-otg", "usb2-phy", "bootrom";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <56 130>, <57 131>, <69 150>, <70 151>,
+						  <41 135>, <61 136>, <62 137>, <63 138>,
+						  <2 0xffffffff>, <35 0xffffffff>, <13 0xffffffff>;
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
index 3ec2326de42..239ba2733a1 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -62,5 +62,6 @@ source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8720/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8723/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8730/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8740/Kconfig"
 
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index 78ea7bc58d0..ab05b2220a7 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -29,3 +29,7 @@ obj-$(CONFIG_S5L8730) += relocate.o
 obj-$(CONFIG_S5L8730) += s5l8730.o
 obj-$(CONFIG_S5L8730) += s5l87xx-otg-phy.o
 obj-$(CONFIG_S5L8730) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8740) += s5l8740.o
+obj-$(CONFIG_S5L8740) += s5l8740-otg-phy.o
+obj-$(CONFIG_S5L8740) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/s5l8740-otg-phy.c b/arch/arm/mach-s5l87xx/s5l8740-otg-phy.c
new file mode 100644
index 00000000000..d02f936ec5d
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8740-otg-phy.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <log.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/clk.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+
+struct s5l8740_otgphy {
+	u32 pwr;		// 0x00 - PHYPWR
+	u32 con;		// 0x04 - PHYCON
+	u32 rstcon;		// 0x08 - URSTCON
+	u32 pad0[4];	// 0x0c - 0x18
+	u32 vldcon;		// 0x1c - UVLDCON
+	u32 pad1[5];	// 0x20 - 0x30
+	u32 rescon;		// 0x34 - URESCON
+	u32 pad2[2];	// 0x38 - 0x3c
+	u32 tune1;		// 0x40 - UOTGTUNE1
+	u32 tune2;		// 0x44 - UOTGTUNE2
+	u32 pad3[46];	// 0x48 - 0xfc
+	u32 rsv;		// 0x100 - URSV
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l8740_otgphy *otgphy = (struct s5l8740_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8740_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+
+	// Stay detached until the gadget driver has configured the controller.
+	setbits_le32(S5L87XX_OTG_BASE + 0x804, BIT(1)); /* DCTL: SftDiscon */
+	mdelay(4);
+
+	// Disable USB suspend: clear PCGCCTL GateHclk and StopPclk.
+	clrbits_le32(S5L87XX_OTG_BASE + 0xe00, BIT(1) | BIT(0));
+	udelay(100);
+
+	writel(0, &otgphy->pwr); /* PHY: Power up */
+	udelay(10);
+	writel(1, &otgphy->con); /* 24 MHz reference clock */
+	setbits_le32(&otgphy->rescon, BIT(2));
+	writel(BIT(2), &otgphy->vldcon);
+
+	// Tuning, written with the PLL and the PHY held in reset.
+	writel(BIT(3) | BIT(0), &otgphy->rstcon);
+	udelay(20);
+	clrsetbits_le32(&otgphy->tune1, 0x7ff, 0x347);
+	clrsetbits_le32(&otgphy->tune2, 0xfff, 0xe7f);
+	setbits_le32(&otgphy->rsv, BIT(0));
+	udelay(10);
+	writel(0, &otgphy->rstcon);
+	udelay(1000);
+
+	writel(BIT(2) | BIT(1), &otgphy->vldcon);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l8740_otgphy *otgphy = (struct s5l8740_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8740_otgphy: turning off\n");
+	// Enable USB suspend: set PCGCCTL GateHclk and StopPclk.
+	setbits_le32(S5L87XX_OTG_BASE + 0xe00, BIT(1) | BIT(0));
+	writel(0x1f, &otgphy->pwr); /* PHY: Power down */
+	setbits_le32(&otgphy->rstcon, 7); /* PHY: Assert all resets */
+	udelay(1000);
+	// Should we gate the usb-otg and usb2-phy clocks?
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8740.c b/arch/arm/mach-s5l87xx/s5l8740.c
new file mode 100644
index 00000000000..f817bd4e2a3
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8740.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8740 (ARM Cortex A5)\n");
+	return 0;
+}
+
+void enable_caches(void)
+{
+	// Caches already enabled by the bootloader
+	// This is here so that we don't see
+	// WARNING: Caches not enabled
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8740/Kconfig b/arch/arm/mach-s5l87xx/s5l8740/Kconfig
new file mode 100644
index 00000000000..dff8fad31bc
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8740/Kconfig
@@ -0,0 +1,12 @@
+if S5L8740
+
+config TARGET_N31
+	bool "Apple N31 - iPod nano (7th generation)"
+	default y
+	help
+	  Apple iPod nano (7th generation) is a digital audio player, introduced in
+	  October 2012. It has a NAND flash of 16 GiB.
+
+source "board/apple/n31/Kconfig"
+
+endif
diff --git a/board/apple/n31/Kconfig b/board/apple/n31/Kconfig
new file mode 100644
index 00000000000..4b26a9f22f3
--- /dev/null
+++ b/board/apple/n31/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N31
+
+config SYS_BOARD
+	default "n31"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8740"
+
+config SYS_CONFIG_NAME
+	default "apple_n31"
+
+endif
diff --git a/board/apple/n31/Makefile b/board/apple/n31/Makefile
new file mode 100644
index 00000000000..78c1f982c88
--- /dev/null
+++ b/board/apple/n31/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n31.o
diff --git a/board/apple/n31/n31.c b/board/apple/n31/n31.c
new file mode 100644
index 00000000000..fd34c4f9181
--- /dev/null
+++ b/board/apple/n31/n31.c
@@ -0,0 +1,96 @@
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
+	u32 value;
+
+	// UART0: pad 0, rx pin 4, tx pin 5, fn 2
+	value = readl(S5L87XX_PCON(0));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(4, 5);
+	value |= S5L87XX_PCON_PINS_SET_FN(4, 5, 0x2);
+	writel(value, S5L87XX_PCON(0));
+
+	value = readl(S5L87XX_PPIE(0));
+	value |= BIT(4) | BIT(5);
+	writel(value, S5L87XX_PPIE(0));
+
+	// UART1: pad 9, rx pin 6, tx pin 7, fn 2
+	value = readl(S5L87XX_PCON(9));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(6, 7);
+	value |= S5L87XX_PCON_PINS_SET_FN(6, 7, 0x2);
+	writel(value, S5L87XX_PCON(9));
+
+	value = readl(S5L87XX_PPIE(9));
+	value |= BIT(6) | BIT(7);
+	writel(value, S5L87XX_PPIE(9));
+
+	// UART2: pad 8, rx pin 2, tx pin 3, fn 2
+	value = readl(S5L87XX_PCON(10));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(2, 3);
+	value |= S5L87XX_PCON_PINS_SET_FN(2, 3, 0x2);
+	writel(value, S5L87XX_PCON(10));
+
+	value = readl(S5L87XX_PPIE(10));
+	value |= BIT(2) | BIT(3);
+	writel(value, S5L87XX_PPIE(10));
+
+	// UART3: pad 10, rx pin 3, tx pin 4, fn 2
+	value = readl(S5L87XX_PCON(10));
+	value &= S5L87XX_PCON_PINS_CLEAR_FN(3, 4);
+	value |= S5L87XX_PCON_PINS_SET_FN(3, 4, 0x2);
+	writel(value, S5L87XX_PCON(10));
+
+	value = readl(S5L87XX_PPIE(10));
+	value |= BIT(3) | BIT(4);
+	writel(value, S5L87XX_PPIE(10));
+}
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart0");
+	s5l87xx_enable_clkgate("uart1");
+	s5l87xx_enable_clkgate("uart2");
+	s5l87xx_enable_clkgate("uart3");
+	s5l87xx_enable_clkgate("bootrom");
+}
+
+int board_early_init_f(void)
+{
+	/* Configure UART TX & RX line GPIO */
+	board_gpio_init();
+
+	/* Enable UART clocking */
+	board_clock_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	/* Configure UART TX & RX line GPIO */
+	board_gpio_init();
+
+	/* Enable UART clocking. Runs before the FDT is set up */
+	// UART0
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+
+	// UART1
+	s5l87xx_enable_clkgate_bit(1, 29);
+	s5l87xx_enable_clkgate_bit(4, 8);
+
+	// UART2
+	s5l87xx_enable_clkgate_bit(1, 30);
+	s5l87xx_enable_clkgate_bit(4, 9);
+
+	// UART3
+	s5l87xx_enable_clkgate_bit(1, 31);
+	s5l87xx_enable_clkgate_bit(4, 10);
+}
diff --git a/configs/apple_n31_defconfig b/configs/apple_n31_defconfig
new file mode 100644
index 00000000000..2f6ea3403d8
--- /dev/null
+++ b/configs/apple_n31_defconfig
@@ -0,0 +1,31 @@
+CONFIG_ARM=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8740-n31"
+CONFIG_S5L8740=y
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_DEBUG_UART_BASE=0x3DD00000
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
diff --git a/include/configs/apple_n31.h b/include/configs/apple_n31.h
new file mode 100644
index 00000000000..85f35e81697
--- /dev/null
+++ b/include/configs/apple_n31.h
@@ -0,0 +1,15 @@
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
+// 256K SRAM total, first 64K is the fastest
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00040000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

