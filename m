Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3586606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wlK6ZXrt;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=ki40pAdJ;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=T80mW9fb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCA3E60725;
	Mon, 26 Oct 2026 22:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iKpRvYBy-IU4; Mon, 26 Oct 2026 22:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 98A0E606FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055331;
	b=VnbUFfKGOvf9Q3Lm6nTCj/6KClHQlxyKH2cKaXg/RHa7ut48mG+1t5hZao60Um0sb361
	 NDhYVg/Q+4WFbuG5oOs0QJ3XqtycEgxWrQO+NLvNUQX3YZ1NP28F9kVelwxwS2H1gssDn
	 49W8guUvFldPDUvEjn9Rg/kP3IfHum5LgpKLQsJ07NLrDnnEZJ8VmDSn9TBb9LStB/rj8
	 8U47GHVbMdtyNVGSDtwpwCQT7Y9BOts8OqWc9RluCyO+Tn5f6vs+puvryumQ2oJa4E/ns
	 5AepvDyFDWFvTnsn4AO7a8boH5d5RPRvZoUUZUfyDmcRFpCmAERFnN/4wzjxYqXXbCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L/GXM9t9xfhFxvalMA3tVw1ORhsGO843UiKzbG5PgHQ=;
	b=lofI4QVFuYg5sBSOCpmv31u0tiKOQSYeJEgOgRlYab4R4oFuh/3YI8GkQSny/O56IksH
	 MFLYn5t/1vZziQ8KbMrIfkNK5fbpgY+UyH9hUVsDGspSKqfunOXqOk7giVN3V6okEnh7i
	 WVdSbAfeuyEmqon7AipUh4M9K/pDAPgGoGuAbsUhO7+Bk+rC2+X+vMzeNYcnK/lRUYeEb
	 TfK/DMUeKnP2qTmzU/gk96jMK7KHVJ4DuaV7ZVlADHouNJMqrC80bkoHZEVG1HdTAX3of
	 3eb8bNBxlHKiX+xk5XF69zplD+iUVwyrgV/Bund5riDjPDcbCBSIlKCvhdDG9qodefA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055331;
	bh=L/GXM9t9xfhFxvalMA3tVw1ORhsGO843UiKzbG5PgHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wlK6ZXrti0VUj/pq6HZWNjffp31VbCSnGk0Y0zux21sNXTYFsNC4hpra9pjszlGNh
	 F92FeSM2Is3aU/xllmZRgeNMJJWGNVKx/Bharc/r56/v/U8rPMv6m+DpsyHbtreFRf
	 sOQrel3tSnPlsWtlyFG8T7VroBr1ugwebY7Ze+mqpb9xWefDIKqQh68sn3w+ntuKxk
	 c/Y3tZRpprf67yHtbAhUTUebuIaWQRXsrw0JkPTh+mRtrwnR69hDBs6/4eYZM4E/W7
	 oRNEAERm86OJ7a22ynVwMVT8kdj0IOmsCg0OF4UbG3AFTFQ+qUaaumdZ+mcboqTZbB
	 PtbThtuqUKbMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98A0E606FA;
	Mon, 26 Oct 2026 22:55:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 42266380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2945180C0D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30ozXEa9r6qy for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 001F680A8C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055314;
 b=SjX/E4CaXtwXvuuX1Z8x5LVxHh9yBqstUlFK8jvpmg0tgnNoxpatkDIrDDtuhi8J7+kv
 gIfIEMpz3ODY/gYqz41YKdUdQspIZ9x2Oy41Df0pp2Zsy4Gfe35+zkuQZ49on83lDCEse
 0ha4ecFzZg3+i+N6eqOzvVR+5ghFPaM7uZtAFDFXYmvpTjFJ3ViooDpACnb7aZ1eQALjj
 WUip6ZyjcPAGQAWlv7JbSKPoojKHmsFl/kQQ4BJdEJAJ2dEr0DDaKYr4kDjMfn8t+7Trh
 ke0popkOfQrGWAPTbaOMmBWvyD+MSZCk7ICixLJ6Zj5QSoRbdeWswHhjhyGGYSk69yQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055314;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=L/GXM9t9xfhFxvalMA3tVw1ORhsGO843UiKzbG5PgHQ=;
 b=YqCD4H/4tUfWvsGHMI7zanvKPCGIqAspuDZeJEY4gY1E/LzDUdErNIj7eeavzVaQA6gT
 1j2eZCs1tJsUEc/9RlvFtCruisjNnfzHiW954byOin1dmFEH44TJ6uVzeTBKOjWvYOeho
 BHbv1hCyB7lG3WCMDwrQfY3Wxkql+TPmBpYDOMPr15PohCEVZ7WGMIXUvOLzzLMx1Va2n
 5T6oRpcl4AcGCX2RuMEtsUm3jgZg/oPl9mM+G4T4ehozeil37g8UQX6m2Qo2rZALH5yMw
 J44sCtStp/8j0DbmzsVD/6K0AiIhIkrnnlihbeq6oGeag13xRe22u0bdpRHCgdj+EuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=ki40pAdJ; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=T80mW9fb; 
 arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cc578-042ab76d-fa70-4451-8369-7885f619f0d0-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=ki40pAdJ; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=T80mW9fb
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 001F680A8C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055311;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=a/6y516RXEydBUU11w4FXNN2fxcPdTMGFI1jd3B6DLw=;
 b=ki40pAdJh7DgSZiICJ3CJ64dhVwxH2WwE3GyJBARmpAjs4qpFC9LNC6IPEZo8Twj
 WNfurjLFnA59wmx5RWFmLj1uN55KzOq4eXvamiunX/drYy3at7mx+uHi5r1IFK91Hr4
 16kO+8gQ540CdVXLPq7eWrTiHZpARRLJfEBLts9OQwtfGPU8gaXQbAobkgmhV5MtsCg
 wz5S9HYb9vG3N+ORSggxVl9ZR71TI4+m61SiPRV5A9IL1YyPMoLqIAYIC78Bxov3FV4
 m21iuTuhv8Sy0rmC8iXx8HaHbwOgw/i8Iu2Fn1DVZODgjovcmiiYKXqlXt4AkyBw9N1
 lKw9+EnCAA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055311;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=a/6y516RXEydBUU11w4FXNN2fxcPdTMGFI1jd3B6DLw=;
 b=T80mW9fbJFOfrB23y+BqZb1X2gHpwTDTKZiIBeIsoULaET4pWVnSZlLSVesk7/B1
 yLDQHprPGYusIc2ZFz9tqhKdz9SzaElGm4GiCOAajb3TCGqyLg9WlTWVFPLTg/DvRil
 GRR46JLICOB6xyz6t5lfr+8LZ9qVdh1G180W9eCE=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:11 +0000
Subject: [PATCH v2 12/14] New SoC/board: S5L8723/N20
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cc578-042ab76d-fa70-4451-8369-7885f619f0d0-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=8660;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=a/6y516RXEydBUU11w4FXNN2fxcPdTMGFI1jd3B6DLw=;
 b=EVhGttpN2a9KbLOa4D4j+iQI9ptYxH0bksMwyTajbXRU4FqZ8WOoKUviBhdmcZU548JWxBqx3
 CcOqv6nMoq3Ajrhu/nNM02jS5okuXzx0RZPDtS0F01Q+TpFFnkmiiwg
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.12
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

Marketing name: Apple iPod nano (6th generation)

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/dts/s5l8723-n20.dts          | 26 ++++++++++++++++
 arch/arm/dts/s5l8723.dtsi             | 40 ++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig         |  1 +
 arch/arm/mach-s5l87xx/Makefile        |  5 +++
 arch/arm/mach-s5l87xx/s5l8723.c       | 18 +++++++++++
 arch/arm/mach-s5l87xx/s5l8723/Kconfig | 12 ++++++++
 board/apple/n20/Kconfig               | 15 +++++++++
 board/apple/n20/Makefile              |  7 +++++
 board/apple/n20/n20.c                 | 57 +++++++++++++++++++++++++++++++++++
 configs/apple_n20_defconfig           | 33 ++++++++++++++++++++
 include/configs/apple_n20.h           | 15 +++++++++
 11 files changed, 229 insertions(+)

diff --git a/arch/arm/dts/s5l8723-n20.dts b/arch/arm/dts/s5l8723-n20.dts
new file mode 100644
index 00000000000..f2996f495b2
--- /dev/null
+++ b/arch/arm/dts/s5l8723-n20.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (6th generation)
+ *
+ * target-type: N20
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8723.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n20", "samsung,s5l8723", "apple,arm-platform";
+	model = "Apple iPod nano (6th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8723.dtsi b/arch/arm/dts/s5l8723.dtsi
new file mode 100644
index 00000000000..be83c0f4ebc
--- /dev/null
+++ b/arch/arm/dts/s5l8723.dtsi
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8723 SoC
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8723", "apple,arm-platform";
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
+						  <56 130>, <57 131>, <69 150>, <70 151>,
+						  <41 135>, <2 0xffffffff>, <35 0xffffffff>,
+						  <13 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
index 6a873f10675..f40a340312a 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -60,5 +60,6 @@ endchoice
 source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
 source "arch/arm/mach-s5l87xx/s5l8720/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8723/Kconfig"
 
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index 62564a34645..ff84eff8448 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -19,3 +19,8 @@ obj-$(CONFIG_S5L8720) += relocate.o
 obj-$(CONFIG_S5L8720) += s5l8720.o
 obj-$(CONFIG_S5L8720) += s5l87xx-otg-phy.o
 obj-$(CONFIG_S5L8720) += s5l87xx-timer.o
+
+obj-$(CONFIG_S5L8723) += relocate.o
+obj-$(CONFIG_S5L8723) += s5l8723.o
+obj-$(CONFIG_S5L8723) += s5l87xx-otg-phy.o
+obj-$(CONFIG_S5L8723) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/s5l8723.c b/arch/arm/mach-s5l87xx/s5l8723.c
new file mode 100644
index 00000000000..5c82dfd2851
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8723.c
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
+	printf("CPU:   Samsung S5L8723 (ARM1176JZF-S)\n");
+	return 0;
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8723/Kconfig b/arch/arm/mach-s5l87xx/s5l8723/Kconfig
new file mode 100644
index 00000000000..9564f620518
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8723/Kconfig
@@ -0,0 +1,12 @@
+if S5L8723
+
+config TARGET_N20
+	bool "Apple N20 - iPod nano (6th generation)"
+	default y
+	help
+	  Apple iPod nano (6th generation) is a digital audio player, introduced in
+	  September 2010. It has a NAND flash of either 8 or 16 GiB.
+
+source "board/apple/n20/Kconfig"
+
+endif
diff --git a/board/apple/n20/Kconfig b/board/apple/n20/Kconfig
new file mode 100644
index 00000000000..252baff3c33
--- /dev/null
+++ b/board/apple/n20/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N20
+
+config SYS_BOARD
+	default "n20"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8723"
+
+config SYS_CONFIG_NAME
+	default "apple_n20"
+
+endif
diff --git a/board/apple/n20/Makefile b/board/apple/n20/Makefile
new file mode 100644
index 00000000000..e3353451653
--- /dev/null
+++ b/board/apple/n20/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n20.o
diff --git a/board/apple/n20/n20.c b/board/apple/n20/n20.c
new file mode 100644
index 00000000000..ec6dbf01714
--- /dev/null
+++ b/board/apple/n20/n20.c
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
diff --git a/configs/apple_n20_defconfig b/configs/apple_n20_defconfig
new file mode 100644
index 00000000000..62a401f2087
--- /dev/null
+++ b/configs/apple_n20_defconfig
@@ -0,0 +1,33 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8723-n20"
+CONFIG_S5L8723=y
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
diff --git a/include/configs/apple_n20.h b/include/configs/apple_n20.h
new file mode 100644
index 00000000000..7cb68073fcd
--- /dev/null
+++ b/include/configs/apple_n20.h
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
+// 192K SRAM total, first 64K is the fastest
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00030000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

