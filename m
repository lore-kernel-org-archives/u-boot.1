Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kQV655FJ;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=V2/xMYCk;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=kFrIOgUI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0026605D1;
	Mon, 26 Oct 2026 22:55:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wY-M6obK6ZWT; Mon, 26 Oct 2026 22:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5D92C606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055326;
	b=T6fi/4KnbrGMWfLQVhOcDrfEAYVhybyX0frN3p5FRhQTTEA7dYvgnu/qCXXzW1NJ0Nb7
	 ZCHd+E0ZTwt+vELCvSeqKWeyoAMOYvEnoQMl5L/cit9NC8jWw/Nc14n+8fSxtrFxng4Rc
	 iY6VO2w6WBBd0o3hBHzorLEhrP9iOgKS4aVyUHQv8TFmEkkXKHwiXjCCqZ3plZvADHh77
	 35PNfKAjClCaeqvIFD4MTGnPQHMX9RhkrEru4soQjKew0eLMKZX4t5LEfm+vsz3oP8/EM
	 2ZgnlKbtezX/IqGBE+HHLspjMyYQX1vlO66RkFzcFouGmhWbbOCA8DVRn84uqfU7Yiw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OolA2cWTzOC76CZuiTDwGTR+JHOgywrYGl793LlQ3A0=;
	b=oZL4Ibc+V4Eq9Il1CHnTwhfMDkOVPXCPECx4CXfcCiyfJqjptJoHAs1LWNaN7r3+fln8
	 maCMp0DVGS1jtjGokh9Gd6ndG3kGTOfl/SSb6bVogwkmeRzpfZdypYmrDmR1OkY72ti/K
	 K4EWW0+VCT6v6xEko1wMsE5QF62PwgGed6S22Of1dowkbB1jUt3KOLVd3ZxqJ/xZ4TKm5
	 pRi0HcyJQsQxdYezy5gt9BGBPAdg5KM7f/HGf/l+0aitvty+ZF96W/jEXHT/i5ZO8xgqj
	 perHeqbBC5CMJotr9mNfK1ZekVsNHdSYckX6/PpQsrjfyzU1lsiN7Y+zZ8+T3tuo4pQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055326;
	bh=OolA2cWTzOC76CZuiTDwGTR+JHOgywrYGl793LlQ3A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQV655FJ2gB9t7yzkOmiUR0p9c9wSTqEn909azxOneMCuf2KN7Z6rUooNqQITLey8
	 F0/vxtiETKEhUuGQBDRbRXkuRQt6bWnYSjKk6xjUZl83d6C+E7qO2ZUEIq78t7mSEO
	 P1SRc9p2gmfPhy2Hh3TLb67DDf29SDay+7Kk3JFlhC6fxGR358zKIUDG4W1XCSrdIR
	 +H8Tkb9qqZsjo1u5qvCiWA0ATN83K63Z7PESZSIyakAytQsE/OeP7fWJ7lXLF64B5F
	 JkgQ0qib/mxVPvM+hs+D1Ed4Y0xRxky8ftJtFyluCCtb/sxW4r88QhIfO+KxEHXfs9
	 YwAAKCRRgA/rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D92C606FD;
	Mon, 26 Oct 2026 22:55:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 713A22F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62CBF809C0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mfSdeEYT1CsC for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B4A83808C9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055311;
 b=EWRZteSOucBMTLYsdYxZTW224S/M5A/fohp38Sa/YNH8RroIlwNqiXNGow1p2anMM2Z4
 7lvtkxSH+Bh6g4/WSsVW/RgIQXdABpX/cCOp/wc6xDpeK4dKwMiyRCrYuJUVO9jNgUGyS
 UKE2py4h6wgVtYZJ8tEaqXMxYiIVqODp8h3UEzCphYYCRICYXWp3solb4119i/Sm56IAx
 BAD4O0i8JI+YF0Vx22oXN5hFCfjuzlW9T5KxfmAsTshh0P3m0V7Bx9RmIacXOOzVGI1EL
 lN0MKHP4neyniGo54YZtiXoTGyrhizpUzy2J+KNmk4nMHhv7LNJgbhk3xRg7romppRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055311;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=OolA2cWTzOC76CZuiTDwGTR+JHOgywrYGl793LlQ3A0=;
 b=KPQzuNG8HntOlqjkoYs8R3aVempKZ8bHiikqvjXWDy/H112/OOPtFNoEWQRrXGkmZsBc
 12lKoyyp+esFKgHwap3ExDxokrrPB8STFbZJxcikGnE73F6QfJBwUNsKA6d6tY7q3jhYj
 INN1YKfKxBWXCEOM2wVb1vena5Pmv7eDfZGaeoRt84UUAicnrZ1bo6km6tDkvAgvkeLwb
 0geFE3hI3eq78oJkhL/ftaGGrxJWYZXoZvNQKEPMnRDFabMQB6vcuKGQkz2KrWrnOi9ia
 vkXsBOtJ3gUO0Ch87g2s18Xim6dSYyrlEtOZWvTZ0NQCSXlCALgKVumSxax9AOW9qUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b="V2/xMYCk"; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=kFrIOgUI; 
 arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cb987-ca9954ea-05f7-4b42-bc13-1ac4334d850b-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=V2/xMYCk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=kFrIOgUI
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4A83808C9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055308;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=jpFEpqkXif6ZsJJFpppPVbyRoxwEeAEzzzz0FI+KCCU=;
 b=V2/xMYCkXtdWPkHo6aTQ28eP6CemwZcL/hlcswUy3QuIdCMhxGqV/7c4gG+YzImI
 yMii9AvnGmQJO50ar7yqKOuJVB6zgFWHXoB2Jfn2kCbbyH0iwrlOvQxdRW5yiHIKgED
 T9h07lZ9hguM7TaV9MLbP2JMcb5qDvuwZOK0rI4Ish8Z/XPFi34JfY8ocHAopTeia9s
 2OOHDOtz9EhoYfszsOBwVrFbCZ+BzBL0YUBDInRFG/K2HV4urip08V+COmsTWjrhuR1
 RVEtuSnfEkduPJWwTJ9TN7YQ3Dq/t1e9iUwYfxpCvi9IaRrI6mlU7eL7zFGjCiJXfi7
 F8N+UJJOXg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055308;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=jpFEpqkXif6ZsJJFpppPVbyRoxwEeAEzzzz0FI+KCCU=;
 b=kFrIOgUIcYGbzTLvxWEd7tUx0uTKaxTigI4dsSTJ/5/f6uLH7XstYjatUZpXE1dh
 eYVnpVmOZgHnMrf5Zv6047xpn5SH5QV711BXY4ZJ00SBZFrs16CcCUlE+10nfiNm1jF
 AuwDLo3U/ZEJOJrOmc2wvo3h4bbKxgVzBEpCjgSI=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:08 +0000
Subject: [PATCH v2 08/14] Common files for the whole S5L87xx SoC family and
 the Nxx board series
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cb987-ca9954ea-05f7-4b42-bc13-1ac4334d850b-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=15174;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=jpFEpqkXif6ZsJJFpppPVbyRoxwEeAEzzzz0FI+KCCU=;
 b=8/fmz/Vt23ckioceXBNe4DKXtEr8x41cCmYrWEvQu1RXZsj7Ds0eUFEApKUlftb2/fcBepUGV
 JHuMOvmLu7dD4eDJEsgmmy9STA2N05FrZsTIMJp1+3VEFEGXs37DZ9d
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marketing name: Apple iPod nano/classic series

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 MAINTAINERS                                 |  3 ++
 arch/arm/Kconfig                            |  2 +
 arch/arm/Makefile                           |  1 +
 arch/arm/dts/s5l87xx-nxx.dtsi               | 22 ++++++++
 arch/arm/dts/s5l87xx.dtsi                   | 78 ++++++++++++++++++++++++++++
 arch/arm/include/asm/arch-s5l87xx/clk.h     | 19 +++++++
 arch/arm/include/asm/arch-s5l87xx/s5l87xx.h | 79 +++++++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig               | 60 ++++++++++++++++++++++
 arch/arm/mach-s5l87xx/Makefile              |  7 +++
 arch/arm/mach-s5l87xx/s5l87xx-clk.c         | 66 ++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l87xx.c             | 22 ++++++++
 board/apple/nxx-common/nxx.c                | 47 +++++++++++++++++
 12 files changed, 406 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da8e413dd35..fccc5b2e886 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -603,7 +603,10 @@ F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
 ARM SAMSUNG S5L87XX SOC
 M:	Vencislav Atanasov <user890104@freemyipod.org>
 S:	Maintained
+F:	arch/arm/dts/s5l87*
 F:	arch/arm/include/asm/arch-s5l87*
+F:	arch/arm/mach-s5l87*
+F:	board/apple/n*
 
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0029365eb89..a528f90cb3a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2430,6 +2430,8 @@ source "arch/arm/mach-qemu/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
 
+source "arch/arm/mach-s5l87xx/Kconfig"
+
 source "arch/arm/mach-s5pc1xx/Kconfig"
 
 source "arch/arm/mach-sc5xx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index de975fc9368..d27808dfd05 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -80,6 +80,7 @@ machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_OWL)		+= owl
 machine-$(CONFIG_ARCH_RENESAS)		+= renesas
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
+machine-$(CONFIG_ARCH_S5L87XX)		+= s5l87xx
 machine-$(CONFIG_ARCH_S5PC1XX)		+= s5pc1xx
 machine-$(CONFIG_ARCH_SC5XX)		+= sc5xx
 machine-$(CONFIG_ARCH_SNAPDRAGON)	+= snapdragon
diff --git a/arch/arm/dts/s5l87xx-nxx.dtsi b/arch/arm/dts/s5l87xx-nxx.dtsi
new file mode 100644
index 00000000000..152d8fc23a7
--- /dev/null
+++ b/arch/arm/dts/s5l87xx-nxx.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (2nd, 3rd, 4th, 5th, 6th and 7th generation) and iPod classic (6th generation)
+ *
+ * This file contains parts common to all Apple iPod devices using the s5l87xx.
+ *
+ * target-type: N36, N46, N58s, N33, N20, N31, N25
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/ {
+	memory: memory {
+		device_type = "memory";
+	};
+
+	clkref: clock-ref {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-output-names = "clkref";
+	};
+};
diff --git a/arch/arm/dts/s5l87xx.dtsi b/arch/arm/dts/s5l87xx.dtsi
new file mode 100644
index 00000000000..ac985ee6c37
--- /dev/null
+++ b/arch/arm/dts/s5l87xx.dtsi
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L87xx SoC family
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clkgates: clkgates {
+			compatible = "samsung,s5l87xx-clkgates";
+		};
+
+		uart0: uart@3cc00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3cc00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <0>;
+			status = "disabled";
+		};
+
+		uart1: uart@3db00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3db00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <1>;
+			status = "disabled";
+		};
+
+		uart2: uart@3dc00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3dc00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <2>;
+			status = "disabled";
+		};
+
+		uart3: uart@3dd00000 {
+			compatible = "apple,s5l-uart";
+			reg = <0x3dd00000 0x3c>;
+			clocks = <&clkref>, <&clkref>;
+			clock-names = "uart", "clk_uart_baud0";
+			reg-io-width = <4>;
+			id = <3>;
+			status = "disabled";
+		};
+
+		usbphy: usbphy@3c400000 {
+			compatible = "apple,s5l87xx-otgphy";
+			reg = <0x3c400000 0x100>;
+			#phy-cells = <0>;
+		};
+	};
+};
diff --git a/arch/arm/include/asm/arch-s5l87xx/clk.h b/arch/arm/include/asm/arch-s5l87xx/clk.h
new file mode 100644
index 00000000000..ad6a9ceca87
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/clk.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __S5L87XX_CLK_H_
+#define __S5L87XX_CLK_H_
+
+#include <inttypes.h>
+
+/*
+ * Ungate a single clock gate by raw {gate, bit}. Unlike s5l87xx_enable_clkgate()
+ * this needs no device tree, so it is safe in pre-relocation paths (e.g. the
+ * debug UART init, which runs before the FDT is set up).
+ */
+void s5l87xx_enable_clkgate_bit(u8 gate, u8 bit);
+void s5l87xx_enable_clkgate(const char *id);
+
+#endif //__S5L87XX_CLK_H_
diff --git a/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h b/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h
new file mode 100644
index 00000000000..ebcfe51e8b3
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/s5l87xx.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#ifndef __S5L87XX_H_
+#define __S5L87XX_H_
+
+#include <linux/types.h>
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_LCD_BASE 0x38600000
+#else
+#define S5L87XX_LCD_BASE 0x38300000
+#endif
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_OTG_BASE 0x38800000
+#else
+#define S5L87XX_OTG_BASE 0x38400000
+#endif
+
+#define S5L87XX_VIC_BASE         0x38E00000
+#define S5L87XX_VIC_OFFSET       0x1000
+#define S5L87XX_VICBASE(v)       (S5L87XX_VIC_BASE + S5L87XX_VIC_OFFSET * (v))
+#define S5L87XX_VICINTENCLEAR(v) (S5L87XX_VICBASE(v) + 0x14)
+
+#define S5L87XX_INT_BASE 0x39C00000
+/*
+ * Determines which interrupt source is masked.
+ * The masked interrupt source will not be serviced.
+ */
+#define S5L87XX_INTMSK   (S5L87XX_INT_BASE + 0x08)
+
+#define IRQ_USB_FUNC 16
+
+#define S5L87XX_PHY_BASE 0x3C400000
+
+#define S5L87XX_CLK_BASE  0x3C500000
+
+#if IS_ENABLED(CONFIG_S5L8701)
+#define S5L87XX_SWRCON    (S5L87XX_CLK_BASE + 0x30) /* Software reset control register */
+#define S5L87XX_PWRCON(i) (S5L87XX_CLK_BASE + ((i) == 1 ? 0x40 : 0x28))
+#else
+#define S5L87XX_SWRCON    (S5L87XX_CLK_BASE + 0x50)
+/* S5L8702 only uses PWRCON(0) and PWRCON(1) */
+#define S5L87XX_PWRCON(i) (S5L87XX_CLK_BASE + \
+							((i) == 4 ? 0x6C : \
+							((i) == 3 ? 0x68 : \
+							((i) == 2 ? 0x58 : \
+							((i) == 1 ? 0x4C : \
+								0x48)))))
+#endif
+
+#define S5L87XX_TIMER_BASE 0x3C700000
+
+#define S5L87XX_WDT_BASE 0x3C800000
+#define S5L87XX_WDTCON   S5L87XX_WDT_BASE			/* Control Register */
+#define S5L87XX_WDTCNT   (S5L87XX_WDT_BASE + 0x04)	/* 11-bits internal counter */
+
+#define S5L87XX_GPIO_BASE    0x3CF00000
+#define S5L87XX_PCON(n) (S5L87XX_GPIO_BASE + 0x00 + (n) * 0x20)
+#define S5L87XX_PUNB(n) (S5L87XX_GPIO_BASE + 0x0c + (n) * 0x20)
+#define S5L87XX_PUNC(n) (S5L87XX_GPIO_BASE + 0x10 + (n) * 0x20)
+#define S5L87XX_PPIE(n) (S5L87XX_GPIO_BASE + 0x14 + (n) * 0x20)
+
+#define S5L87XX_PCON_PINS_CLEAR_FN(rx_pin, tx_pin) (~(GENMASK((((rx_pin) + 1) * 4) - 1, \
+	(rx_pin) * 4) | GENMASK((((tx_pin) + 1) * 4) - 1, (tx_pin) * 4)))
+#define S5L87XX_PCON_PINS_SET_FN(rx_pin, tx_pin, fn) (((fn) << ((rx_pin) * 4)) |\
+	((fn) << ((tx_pin) * 4)))
+
+#define S5L87XX_BUS_BASE 0x3E000000
+
+/* Move 0xd3 value to CPSR register to enable SVC mode */
+#define svc32_mode_en() __asm__ __volatile__				\
+			("@ I&F disable, Mode: 0x13 - SVC\n\t"		\
+			 "msr     cpsr_c, %0\n\t" : : "r"(0x13 | 0xC0))
+
+#endif //__S5L87XX_H_
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
new file mode 100644
index 00000000000..39de1039495
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -0,0 +1,60 @@
+if ARCH_S5L87XX
+
+choice
+	prompt "S5L87xx SoC select"
+	help
+	  Choose which Samsung S5L87xx SoC are you building for.
+	  S5L8701 - N36 (iPod nano 2nd generation)
+	  S5L8702 - N46 (iPod nano 3rd generation) and N25 (iPod classic
+	            6th generation)
+	  S5L8720 - N58s (iPod nano 4th generation)
+	  S5L8723 - N20 (iPod nano 6th generation)
+	  S5L8730 - N33 (iPod nano 5th generation)
+	  S5L8740 - N31 (iPod nano 7th generation)
+
+config S5L8701
+	bool "S5L8701"
+	# Actually an ARM940T
+	select CPU_ARM920T
+	help
+	  The Samsung S5L8701 is an ARM-based SoC with a single core ARM940T.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8702
+	bool "S5L8702"
+	select CPU_ARM926EJS
+	help
+	  The Samsung S5L8702 is an ARM-based SoC with a single core ARM926EJ-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8720
+	bool "S5L8720"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8720 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8723
+	bool "S5L8723"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8723 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8730
+	bool "S5L8730"
+	select CPU_ARM1176
+	help
+	  The Samsung S5L8730 is an ARM-based SoC with a single core ARM1176JZF-S.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+config S5L8740
+	bool "S5L8740"
+	select CPU_V7A
+	help
+	  The Samsung S5L8740 is an ARM-based SoC with a single core ARM Cortex A5.
+	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
+
+endchoice
+
+endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
new file mode 100644
index 00000000000..c8d200479c3
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += s5l87xx.o
+obj-y += s5l87xx-clk.o
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-clk.c b/arch/arm/mach-s5l87xx/s5l87xx-clk.c
new file mode 100644
index 00000000000..13a7453a30a
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-clk.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <dm/ofnode.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+/*
+ * Sentinel for an unused second clock gate in the device-tree
+ * "samsung,clock-gates" property. A real gate is encoded as gate * 32 + bit.
+ */
+#define S5L87XX_CLKGATE_NONE 0xffffffff
+
+void s5l87xx_enable_clkgate_bit(u8 gate, u8 bit)
+{
+	u32 reg = S5L87XX_PWRCON(gate);
+	u32 mask = ~BIT(bit);
+	u32 value = readl(reg);
+
+	value &= mask;
+	writel(value, reg);
+}
+
+static void s5l87xx_ungate_encoded(u32 encoded)
+{
+	if (encoded == S5L87XX_CLKGATE_NONE)
+		return;
+
+	s5l87xx_enable_clkgate_bit(encoded / 32, encoded % 32);
+}
+
+/*
+ * Ungate a clock by name. The name -> {gate, bit} mapping lives in the device
+ * tree under the "samsung,s5l87xx-clkgates" node ("clock-gate-names" paired
+ * with "samsung,clock-gates", two cells per gate). Works pre-relocation: it
+ * reads the flat tree directly, so callers earlier than the FDT setup (e.g.
+ * the debug UART) must use s5l87xx_enable_clkgate_bit() instead.
+ */
+void s5l87xx_enable_clkgate(const char *id)
+{
+	ofnode node = ofnode_by_compatible(ofnode_null(),
+									   "samsung,s5l87xx-clkgates");
+
+	if (!ofnode_valid(node))
+		panic("%s: no clkgates node in device tree", __func__);
+
+	int idx = ofnode_stringlist_search(node, "clock-gate-names", id);
+
+	if (idx < 0)
+		panic("%s: unknown id %s", __func__, id);
+
+	u32 gate1, gate2;
+
+	if (ofnode_read_u32_index(node, "samsung,clock-gates", idx * 2, &gate1))
+		panic("%s: malformed gate1 for %s", __func__, id);
+
+	if (ofnode_read_u32_index(node, "samsung,clock-gates", idx * 2 + 1, &gate2))
+		panic("%s: malformed gate2 for %s", __func__, id);
+
+	log_debug("s5l87xx: ungating %s\n", id);
+	s5l87xx_ungate_encoded(gate1);
+	s5l87xx_ungate_encoded(gate2);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l87xx.c b/arch/arm/mach-s5l87xx/s5l87xx.c
new file mode 100644
index 00000000000..b9a1c54c13e
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+
+void reset_cpu(void)
+{
+	svc32_mode_en();
+	// According to S5L8700X datasheet
+	// rSWRCON = 0xA5 triggers a Software Reset
+	// rWDTCON = 0x100000 is not documented but might trigger a Watchdog Reset
+	// writel(0xA5, S5L87XX_SWRCON);
+
+	writel(0x100000, S5L87XX_WDTCON);
+
+	while (1)
+		;	/* loop forever till reset */
+}
diff --git a/board/apple/nxx-common/nxx.c b/board/apple/nxx-common/nxx.c
new file mode 100644
index 00000000000..72b21c1867b
--- /dev/null
+++ b/board/apple/nxx-common/nxx.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <fdtdec.h>
+#include <env.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+__weak int board_init(void)
+{
+	return 0;
+}
+
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	char buf[96];
+	ulong start;
+	ulong size;
+
+	if (!env_get("dfu_alt_info")) {
+		/* don't touch the upper 4M, U-boot is relocated there
+		 * use upper half of the remaining space for loading
+		 * and the lower for booting the payload, e.g. Linux
+		 */
+		size = (gd->ram_size - SZ_4M) / 2;
+		start = gd->ram_base + size;
+		snprintf(buf, sizeof(buf), "firmware ram 0x%08lx 0x%08lx;"
+				 "bootrom ram 0x20000000 0xc800", start, size);
+		env_set("dfu_alt_info", buf);
+
+		env_set_hex("loadaddr", start);
+	}
+}

-- 
Git-157)

