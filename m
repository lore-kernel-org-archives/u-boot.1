Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC1606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=glUiM2SC;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=lL5XnXwz;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=AZJP0YFD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8ADE40611;
	Mon, 26 Oct 2026 22:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9t7EFGOpfU6; Mon, 26 Oct 2026 22:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9FCE840520
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055329;
	b=Napn5M7fT4VIs6s+8j+S5gStjjor70hgVSsFe/JaOQxXnWvgqfh/F41MOiUoKnpsfkUu
	 IxvFJZVVaR7iZKh+iKnD7NDn6PBDDIU4XmaLOMn37vfXKLkizXzO9b388R+/6b8nO/jB4
	 ezb3EZZix6ckwaih5ZnxbsK05gf9MikgBWzXMhqSjpL+FfYH4ZOslGs+ePeZC4qTtqR36
	 TL4E4uk9+LZx8Ixv1C5ntOX/B74D9QKFIaRwH0q2pnIulTcmhZ7TyoPiWi0ddugqFeJHZ
	 D0wk3KdZ8n4pQZWT8UCiyYvypKkC+IryO9RLueSbCJLKDF6d2Mm3VyyEuXreUWbk60Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6b2Y5Xn0qiVY0YMwVp3FghUSnfmTHkqko8YUmPWi/Oo=;
	b=JCn9cWcHK6J/j1Mlb26jCo8550/++ZCSHQPbIec0tcv0Ru6mrErbeam7jV6QrQgf5IKN
	 Xhb+gmOH3TNGmxlBdYcUHanOp0qp+J3NsnGGpYKtzUlc79jrS8OsA27SeoX2mPccbp0NM
	 U1rLVksjd3o+I6KnUiCdby/P5TAq7zmbgjRvBNK4BjnC6FUdh+ZHg2lGqR6LyqAsRqhsf
	 ID5qEsiKwdYgDz/OEowjytQVPdbyh2ds2fMT0C6iQg3N0MAPPwcQoIU7bFRvm57iFR+xh
	 vhPgH3a4ZQMuaHHrOSkbNlgtwgyaFc9RHG8aB1XRzgA7YScGYLLQ/Ef7TSGIAeilbaQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055329;
	bh=6b2Y5Xn0qiVY0YMwVp3FghUSnfmTHkqko8YUmPWi/Oo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glUiM2SCUyvUH/LUfuGlDUGvDN6Gdiz88uikmH8eQ/wqZIBMhTHkVErPJWCf0Ggj2
	 V1j6amPkeVTQK3tiIV1zGJViDLlZmt8J2qFHePKS/YMIEC3+A8lWoUcqN+HBzGMRO0
	 oTBsvVKn7yJsEMib4hD4ajvkKZoTVQR/q9kHftCNs82LJ5PjzoL/i5pT/awLPFvPhB
	 NtunuDf6ZjO6sCaBWxEQ6CO8KjNrO5V14+abt88xt1FP0KljuDOCi5PHUz2vMFG9vc
	 4Q57s3GZktt+Bezl4AInTlzKZ/1kEwy1BKzIdEJKfcLWlsET9KVtYd2YSYpl0tXfH1
	 I5y/GNxxaheKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FCE840520;
	Mon, 26 Oct 2026 22:55:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F3B3422
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C700B60603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6NPqBkAyQ4Z for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60156605CF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055313;
 b=cj42rlcE0LD7vYZIQPrK0kC79KhJUEOIxiOmQM2r0tiLEBVJAgPH5ElzZCnOThEqpSwG
 77Rv8ZjRBeLcFBbRYqVMvpyGyRPu/Nn3jauvE2nfq42Gr/Zfn19FB0MfBZExDqFUMef/R
 zZLwPCC8cG+IuXSXdnuaMma7dn65ZRIj5TcHQT8Iuvwgqzd0WnsPkFja/gVjGfQ38LNxD
 PATRY3jVoa77ffGUXftK1ymFGnHVuMZ2djeVKa6RQ36JhUnMoJoxtkpz8GgisPpoyDr99
 tG4WH00onljvvqdX8c8es+mmhyzlRAyFoKnLEEK0wpnPW+2kKY8PuhLv6U4TosXbusA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055313;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=6b2Y5Xn0qiVY0YMwVp3FghUSnfmTHkqko8YUmPWi/Oo=;
 b=CnG5RkkACZJVCm2y/rned7pC/Lk63WA/56dfZF/pDbO5Wi/mQaPaHJWaZ/JmJK6tGSk1
 e5uEp3+HQiKJsu9qzrj9GLyje0gzNcle3rWU+pOVfPAQ/ePCkgVLmjXTjpNech+8UlVpg
 a/TtGn8x7ItPvUoAB2CHNHiSyen/X/ICVJSt4Af+zDMtpSlVQUWItTF2GNMJ6HOtxYsTK
 uP4IJWUSlfp7xdi4pH8XVBn1vNHguawt5rWREyw3URSt2MfZS+8n8glmCwnQNE8JXcVYi
 GwaqyGlUHoUDwtrfus1dSJuoaQekuQSMt+QqIMgk9OHI2KZci/JdBV7fQXGu9x2KRJA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=lL5XnXwz; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=AZJP0YFD; 
 arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cc2c5-f0cadde7-f15e-4167-bdbe-39d7f009e85f-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=lL5XnXwz; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=AZJP0YFD
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60156605CF
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055310;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=k2+r3uKo3MaxkcoKVQ0K1f235XBZoqHBSk4nqa78fMk=;
 b=lL5XnXwzCRG0sfttJzrMzBrx93HPzERp8WryKwhwd8rAKwNc/cDHh6hPUcmJtD0Q
 9Jw95NFuNS4f8B5PORb6+v3+YVb2jPZ37WhGu1lGGLNZK/MgGaxMHn8ymVrsa7aOgkC
 7iBTGqO5veVbhCY6YexBYEMjRHKPl4zJYSYJagd4qKTQfQ3sEjIEhSNJVlNxvYITsL6
 M7qtldZpLmUkgcWhIp+h0fVgRsql1tK328EGEbEtvxA5g8SKGMZDM2aagixJTQMXKd9
 H0hSRkV2Q4uaoTXhOEbt6P1MHqTnVNL6ds22oqes1noc9A94B8PwdhZ6KX9rv24Sqr4
 Z5RiprSZSg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055310;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=k2+r3uKo3MaxkcoKVQ0K1f235XBZoqHBSk4nqa78fMk=;
 b=AZJP0YFDPhmnqxX0iR9jZiwOBbplHYxILNAdNQQFlTRTAMfUVBITUSeYQzIc4hwc
 3p1Zke4uBFSHgbjrM4p6zzuMPJVwnjxrs3NIrOvvv7r4ZmrEZ7UrtltLdU/SRwv5hu9
 Rl5grnjYnWaNgoKZ6gbAWpmj5HsvizbzkNsBnUnI=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:10 +0000
Subject: [PATCH v2 11/14] New SoC/board: S5L8720/N58s
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cc2c5-f0cadde7-f15e-4167-bdbe-39d7f009e85f-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=10369;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=k2+r3uKo3MaxkcoKVQ0K1f235XBZoqHBSk4nqa78fMk=;
 b=xfmRwGNvCfsp+lz+HrknD5DnyczU3DVQC2nuHOhqatClB1uMsELyc08QvGw53lHB6NZTBx+hd
 dF26hSGueNpAwPkQ3X7rB/uEUxkGyJ1NtrfNX1yidoCfGMuDm4tXXZo
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.7
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

Marketing name: Apple iPod nano (4th generation)

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/dts/s5l8720-n58s.dts           | 26 +++++++++++++++
 arch/arm/dts/s5l8720.dtsi               | 42 ++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig           |  1 +
 arch/arm/mach-s5l87xx/Makefile          |  5 +++
 arch/arm/mach-s5l87xx/s5l8720.c         | 18 +++++++++++
 arch/arm/mach-s5l87xx/s5l8720/Kconfig   | 12 +++++++
 arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c | 55 +++++++++++++++++++++++++++++++
 board/apple/n58s/Kconfig                | 15 +++++++++
 board/apple/n58s/Makefile               |  7 ++++
 board/apple/n58s/n58s.c                 | 57 +++++++++++++++++++++++++++++++++
 configs/apple_n58s_defconfig            | 33 +++++++++++++++++++
 include/configs/apple_n58s.h            | 15 +++++++++
 12 files changed, 286 insertions(+)

diff --git a/arch/arm/dts/s5l8720-n58s.dts b/arch/arm/dts/s5l8720-n58s.dts
new file mode 100644
index 00000000000..033127ebe28
--- /dev/null
+++ b/arch/arm/dts/s5l8720-n58s.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (4th generation)
+ *
+ * target-type: N58s
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8720.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n58s", "samsung,s5l8720", "apple,arm-platform";
+	model = "Apple iPod nano (4th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8720.dtsi b/arch/arm/dts/s5l8720.dtsi
new file mode 100644
index 00000000000..1c6853deaa6
--- /dev/null
+++ b/arch/arm/dts/s5l8720.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8720 SoC
+ *
+ * Other names: M2S
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8720", "apple,arm-platform";
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
index 11eeb4d7467..6a873f10675 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -59,5 +59,6 @@ endchoice
 
 source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8720/Kconfig"
 
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index 4cccb797da2..62564a34645 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -14,3 +14,8 @@ obj-$(CONFIG_S5L8702) += relocate.o
 obj-$(CONFIG_S5L8702) += s5l8702.o
 obj-$(CONFIG_S5L8702) += s5l8702-otg-phy.o
 obj-$(CONFIG_S5L8702) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8720) += relocate.o
+obj-$(CONFIG_S5L8720) += s5l8720.o
+obj-$(CONFIG_S5L8720) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8720) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/s5l8720.c b/arch/arm/mach-s5l87xx/s5l8720.c
new file mode 100644
index 00000000000..84d049ec4f0
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8720.c
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
+	printf("CPU:   Samsung S5L8720 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8720/Kconfig b/arch/arm/mach-s5l87xx/s5l8720/Kconfig
new file mode 100644
index 00000000000..ce3db2e7c78
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8720/Kconfig
@@ -0,0 +1,12 @@
+if S5L8720
+
+config TARGET_N58S
+	bool "Apple N58s - iPod nano (4th generation)"
+	default y
+	help
+	  Apple iPod nano (4th generation) is a digital audio player, introduced in
+	  September 2008. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n58s/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c b/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c
new file mode 100644
index 00000000000..058ae8406ab
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-otg-phy.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/clk.h>
+#include <linux/delay.h>
+
+struct s5l87xx_otgphy {
+	u32 pwr;		// 0x00
+	u32 con;		// 0x04
+	u32 rstcon;		// 0x08
+	u32 unk[4];		// 0x0c, 0x10, 0x14, 0x18
+	u32 unkcon;		// 0x1c
+	u32 pad[36];	// 0x20 - 0x44
+	u32 unk44;		// 0x44
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l87xx_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+	mdelay(10);
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0, &otgphy->pwr); /* PHY: Power up */
+	mdelay(10);
+	writel(1, &otgphy->rstcon);
+	mdelay(10);
+	writel(0, &otgphy->rstcon);
+	mdelay(10);
+	writel(6, &otgphy->unkcon);
+	writel(1, &otgphy->con);
+	mdelay(400);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l87xx_otgphy: turning off\n");
+	writel(0xFF, &otgphy->pwr);
+	mdelay(10);
+	writel(0xFF, &otgphy->rstcon);
+	mdelay(10);
+	writel(4, &otgphy->unkcon);
+}
diff --git a/board/apple/n58s/Kconfig b/board/apple/n58s/Kconfig
new file mode 100644
index 00000000000..6a61a9973d9
--- /dev/null
+++ b/board/apple/n58s/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N58S
+
+config SYS_BOARD
+	default "n58s"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8720"
+
+config SYS_CONFIG_NAME
+	default "apple_n58s"
+
+endif
diff --git a/board/apple/n58s/Makefile b/board/apple/n58s/Makefile
new file mode 100644
index 00000000000..293c92895e3
--- /dev/null
+++ b/board/apple/n58s/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n58s.o
diff --git a/board/apple/n58s/n58s.c b/board/apple/n58s/n58s.c
new file mode 100644
index 00000000000..ec6dbf01714
--- /dev/null
+++ b/board/apple/n58s/n58s.c
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
diff --git a/configs/apple_n58s_defconfig b/configs/apple_n58s_defconfig
new file mode 100644
index 00000000000..137941209e1
--- /dev/null
+++ b/configs/apple_n58s_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8720-n58s"
+CONFIG_S5L8720=y
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
diff --git a/include/configs/apple_n58s.h b/include/configs/apple_n58s.h
new file mode 100644
index 00000000000..79192cc4497
--- /dev/null
+++ b/include/configs/apple_n58s.h
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
+// 192K SRAM total, first 64K is the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00030000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

