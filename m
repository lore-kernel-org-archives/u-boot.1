Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A309606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G2QesI72;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=JbfIeSWn;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=KGuKK6wC
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64B85405A5;
	Mon, 26 Oct 2026 22:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gsemWvXHgde3; Mon, 26 Oct 2026 22:55:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D92754050D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055325;
	b=R1t6kC3n2Cp5Q6/YkSEVnszKV4uaywTNpmuky/0rruJ3Y5yx28C8FfnpdYDiaOBwbO1x
	 0kWkYl3jXUfQ4J5oK3kz9Fstyl8j24a6FiAK7jpVMab6pExjjpo44zNzXBiFRGoPJ9nLJ
	 YKYH71M5ZJMSMZPrBuN1hrAu4I9ycHYPYMMrBlrUr40pbasMEBPaxmptyIBsyURHqbbsf
	 cxusM2GDSxVCjPk0E3e8QToS4zYb1fVDp/TqxOoNj5qF3teG3SHuCey4LhePqf7S6jpNs
	 +FScoZ/Kl9mV/PM9n/Yg1sykZaMo7KOmDAAekEjH8/W4pgoILtv+yNccvLyA95691/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Zf6S8v7bIbxZT2svhBX1xvItGONN/CqNsYwFZ45KVBw=;
	b=DMdeV4UEbD+1aMWpZHLoMZHui1rZbdq/J6vNUTvfWwAhEL05MBhvbCzfcF8FuGd+yPpO
	 rEizdDX0k4IeKc+QKncFILeuTLfFUp8vulVMCbuLWOgitbqtdzvv0MqywWoSLl7BCcS6f
	 VninO7aPtMbwcDa3iFdMd+QSmR+uBbwZB5VYzNQ6l6t8tdPrmB/WEPm18jruRctvtew77
	 uJaxj+FpnsZwhaee5vrTWkzrF90QZN7ivJbcqbluMFGjfX3DVKI59W9nu2NLXFOvgg1AC
	 rBYc9qCTLC2OzI9S2p5cpMYtc8jv5IkmO56AflbEhoCyTkkiFJ7uWHfFSnQFg0WUHxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055325;
	bh=Zf6S8v7bIbxZT2svhBX1xvItGONN/CqNsYwFZ45KVBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G2QesI72q9WoDhX83FKWSPqx5SaKRNxTRg61E3VLwRH4mOQixziQU1F7malEQnTi/
	 lEQmXfKkAuCcJ7J6jdek+WYmtmqjpMizFBV3bnbDUxUMpD9ui+lXZkpvXWc2zLN69E
	 iAwGDXfYS33BkmWzU+EaCjjNgRKBcOyffE9t0w9Rajo7b7aifFzaiJV6IDG3e+/7t4
	 7a2E6kDWBPhj0rSAOwRCyPv+oRZEQD/gjBQaar51vx6LfueZgAOzZ8YJVlPjeq4EUq
	 6AeENXfTcioHV7qaz5Aoy/uc+retbTyAtWaBoz2WTiwh2T2TQJsI2RW/LN8/qLg3Qr
	 yTqH9M3Ju7UXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D92754050D;
	Mon, 26 Oct 2026 22:55:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A6512F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8BEEE80963
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wP2OqtFCPedb for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DCB3C80898
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=69.169.224.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055310;
 b=ixCyrelqiXEsowVgO6ABhdPCgQmSakMX4ol9QYWgfS3//ZSTh1pr2CJkIOyuMwHvaXwj
 GyjYePKemMXsZRzVMow51roPQxaoDWHjUAivZSiM71fL2EPX0ji9sYbgviPmCe6dA+vtC
 1DWNwv65q7awwalOaM6O+O06HHK8hoCxyNKp8OMMhsTEHocJbYr7oX0VZGgIYK2aTGLFQ
 vRRVwInMvU7/zFt3e3IjrGkh9BFi0vLnPK3qEO+woT2PAkLBWrmSnfP8W9ndRp8lzSVZ4
 omQvy1DBaJmItqA1JpTwLE7t/adhuFMRe9eC5SwTtjmd6MEtwpyTg4Evf6HH1C2YXzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055310;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=Zf6S8v7bIbxZT2svhBX1xvItGONN/CqNsYwFZ45KVBw=;
 b=bUc+lRlnaiSBkenYKEKCftk14RgrVZa9nAoeWkzW6j9rtM0qXzYlFuWjwkA3qHRgttFs
 HtXIcmoM8/h+ZqZTAv8VGiadSlPCXBjfdaFopbtgjg1/5YBTVTOrQmRk+68a5our/EQ9V
 BO0Tmv2lpnRzGCHT6NOFdIGPB0Hq7rYnZbS5Jf2JDDf+d8Np3XZEfNr4t6MTuSx9g9We1
 Bg3T4wa1rjNsUkT9hIx88CMA26Lm5st2HcdiD0zK3v088z+RT3hR4W3R2cPqsU8L54gxC
 c143baMFl6ZXpi0/sximSn1BAH42uv+Pf0Z+WaPxHrM5wQU4XasajyipDvhnha44m7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=JbfIeSWn; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=KGuKK6wC; 
 arc=none smtp.remote-ip=69.169.224.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.7;
 helo=b224-7.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cbcff-cd185ddf-1b22-4a0a-820a-8d6c7db22601-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=JbfIeSWn; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=KGuKK6wC
Received: from b224-7.smtp-out.eu-central-1.amazonses.com
 (b224-7.smtp-out.eu-central-1.amazonses.com [69.169.224.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCB3C80898
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055309;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=2HNyuoBMZiCcmo6l+cxe00V6mFX92HioHqmNJQqW40A=;
 b=JbfIeSWn0/acCr7HqcsaqGF5qt0bZUQ7JH7IntYlqx8oxM2xWpLMVB7mNrgYVSdd
 CFHj7EFJXd7mzMIP+twy9P40aff4yS9l9p2mqvk/oGjSGpUqTyjcD9SFBp+vSNepMoX
 KAbKLvDjVaJKg1ttwKhm/RR6L/AzmtsveKwJNTgXBp4TowRgUjKGdOew7l0DxTeRRuF
 L7np21gjU+gjvzrV3eqQOffAmaNJMdzgEwIdNKh0w9dMdVq/ekbrz/1eYPrGH5eXSff
 YIEh7iVBT8ENAsnwUOC9kbtKb2dBJXRh/KLfmzqn0vB9+5x3YX07Dw89kIO3Gv8XlPp
 VnBbHjamjA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055309;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=2HNyuoBMZiCcmo6l+cxe00V6mFX92HioHqmNJQqW40A=;
 b=KGuKK6wC/rYT9tNxjSc28qGvglI+6gMTf4lXoLCeCze7BFupoUz6iWELFqvzxdiB
 vSww6RHxtmBIlkoHyjTIsevuJizo/EbnMgBLhhxQpfV72IPouZE4z1SY4JQn51m24mK
 DzbG4r/BlovHmpXvhClPnVJNn1RWBeosKZqTG34g=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:09 +0000
Subject: [PATCH v2 09/14] New SoC/board: S5L8701/N36
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cbcff-cd185ddf-1b22-4a0a-820a-8d6c7db22601-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=14226;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=2HNyuoBMZiCcmo6l+cxe00V6mFX92HioHqmNJQqW40A=;
 b=nwc4+556WGIkE5Be5wjhbDmzCxBBxOwHAWBT8xzT7MO5NbkWGpi7S2v6TrNh6KZAOdPgK6VPG
 HIcFwMj1/aUAx9aTbo0JJCv7I0pHW3dBeZoEPz218skcPyQDUpdZ7Zl
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marketing name: Apple iPod nano (2nd generation)

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 MAINTAINERS                             |   2 +
 arch/arm/dts/s5l8701-n36.dts            |  26 ++++++++
 arch/arm/dts/s5l8701.dtsi               |  62 ++++++++++++++++++
 arch/arm/mach-s5l87xx/Kconfig           |   2 +
 arch/arm/mach-s5l87xx/Makefile          |   4 ++
 arch/arm/mach-s5l87xx/s5l8701-otg-phy.c |  56 ++++++++++++++++
 arch/arm/mach-s5l87xx/s5l8701-timer.c   | 109 ++++++++++++++++++++++++++++++++
 arch/arm/mach-s5l87xx/s5l8701.c         |  26 ++++++++
 arch/arm/mach-s5l87xx/s5l8701/Kconfig   |  12 ++++
 board/apple/n36/Kconfig                 |  15 +++++
 board/apple/n36/Makefile                |   7 ++
 board/apple/n36/n36.c                   |  19 ++++++
 configs/apple_n36_defconfig             |  31 +++++++++
 drivers/usb/gadget/dwc2_udc_otg.c       |  16 +++++
 include/configs/apple_n36.h             |  15 +++++
 15 files changed, 402 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fccc5b2e886..a54987e8546 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -607,6 +607,8 @@ F:	arch/arm/dts/s5l87*
 F:	arch/arm/include/asm/arch-s5l87*
 F:	arch/arm/mach-s5l87*
 F:	board/apple/n*
+F:	configs/apple_n*
+F:	include/configs/apple_n*
 
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
diff --git a/arch/arm/dts/s5l8701-n36.dts b/arch/arm/dts/s5l8701-n36.dts
new file mode 100644
index 00000000000..f8d6cdc8dba
--- /dev/null
+++ b/arch/arm/dts/s5l8701-n36.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (2nd generation)
+ *
+ * target-type: N36
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8701.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n36", "samsung,s5l8701", "apple,arm-platform";
+	model = "Apple iPod nano (2nd generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/s5l8701.dtsi b/arch/arm/dts/s5l8701.dtsi
new file mode 100644
index 00000000000..df14e80f083
--- /dev/null
+++ b/arch/arm/dts/s5l8701.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8701 SoC
+ *
+ * Other names: M1
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+
+/ {
+	compatible = "samsung,s5l8701", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	soc {
+		icu: interrupt-controller@39c00000 {
+			compatible = "samsung,s5l8701-icu";
+			interrupt-controller;
+			reg = <0x39c00000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		usbotg_hs: usb@38800000 {
+			compatible = "apple,s5l87xx-usb";
+			reg = <0x38800000 0x40000>;
+			interrupt-parent = <&icu>;
+			interrupts = <16>;
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
+			clocks = <&clkref>;
+			clock-names = "otg";
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <128>;
+			g-tx-fifo-size = <0>;
+			dr_mode = "peripheral";
+		};
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm940t";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate. The Nano2G (S5L8701) uses single gates (PWRCON registers).
+	 * See https://freemyipod.org/wiki/Nano2G_clock_gates
+	 */
+	clock-gate-names = "timer", "uart", "usb2-phy", "usb-otg";
+	samsung,clock-gates = <4 0xffffffff>, <8 0xffffffff>,
+						  <14 0xffffffff>, <43 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
index 39de1039495..ec35a293998 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -57,4 +57,6 @@ config S5L8740
 
 endchoice
 
+source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
+
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index c8d200479c3..68da781df74 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -5,3 +5,7 @@
 
 obj-y += s5l87xx.o
 obj-y += s5l87xx-clk.o
+
+obj-$(CONFIG_S5L8701) += s5l8701.o
+obj-$(CONFIG_S5L8701) += s5l8701-otg-phy.o
+obj-$(CONFIG_S5L8701) += s5l8701-timer.o
diff --git a/arch/arm/mach-s5l87xx/s5l8701-otg-phy.c b/arch/arm/mach-s5l87xx/s5l8701-otg-phy.c
new file mode 100644
index 00000000000..9584d662de5
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701-otg-phy.c
@@ -0,0 +1,56 @@
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
+	u32 pwr;	 // 0x00
+	u32 con;	 // 0x04
+	u32 rstcon;  // 0x08
+	u32 unk[4];  // 0x0c, 0x10, 0x14, 0x18
+	u32 unkcon;  // 0x1c
+	u32 pad[36]; // 0x20 - 0x44
+	u32 unk44;   // 0x44
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8701_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+	mdelay(10);
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0, &otgphy->pwr); /* PHY: Power up */
+	udelay(10);
+	writel(1, &otgphy->unkcon);
+	writel(0xe3f, &otgphy->unk44);
+	writel(1, &otgphy->rstcon); /* PHY: Assert Software Reset */
+	udelay(10);
+	writel(0, &otgphy->rstcon); /* PHY: Deassert Software Reset */
+	udelay(10);
+	writel(0x600, &otgphy->unk[3]);
+	writel(0, &otgphy->con);
+	udelay(400);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l87xx_otgphy *otgphy = (struct s5l87xx_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8701_otgphy: turning off\n");
+	writel(0x0F, &otgphy->pwr); /* PHY: Power down */
+	udelay(10);
+	writel(0x07, &otgphy->rstcon); /* PHY: Assert Software Reset */
+	udelay(10);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8701-timer.c b/arch/arm/mach-s5l87xx/s5l8701-timer.c
new file mode 100644
index 00000000000..ca0854c6acf
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701-timer.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+#include <asm/io.h>
+#include <asm/arch-s5l87xx/s5l87xx.h>
+#include <asm/arch-s5l87xx/clk.h>
+
+struct s5l87xx_timer {
+	u32 con;	// 0x00
+	u32 cmd;	// 0x04
+	u32 data0;	// 0x08
+	u32 data1;	// 0x0c
+	u32 pre;	// 0x10
+	u32 cnt;	// 0x14
+};
+
+enum s5l87xx_timer_id {
+	//  Timers A, B, C, D: 16-bit
+	S5L87XX_TIMER_A = 0,
+	S5L87XX_TIMER_B = 1,
+	S5L87XX_TIMER_C = 2,
+	S5L87XX_TIMER_D = 3,
+};
+
+#define SYSTEM_TIMER S5L87XX_TIMER_C
+
+enum s5l87xx_timer_cmd {
+	S5L87XX_TIMER_CMD_STOP = 0,
+	S5L87XX_TIMER_CMD_START = 1,
+	S5L87XX_TIMER_CMD_CLR = 2,
+};
+
+static struct s5l87xx_timer *s5l87xx_timer_registers(enum s5l87xx_timer_id id)
+{
+	switch (id) {
+	case S5L87XX_TIMER_A:
+		return (struct s5l87xx_timer *)S5L87XX_TIMER_BASE;
+	case S5L87XX_TIMER_B:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x20);
+	case S5L87XX_TIMER_C:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x40);
+	case S5L87XX_TIMER_D:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x60);
+	default:
+		panic("requested invalid timer id %d", id);
+	}
+}
+
+static const char *s5l87xx_timer_clockgate(enum s5l87xx_timer_id id)
+{
+	/* S5L8701 and S5L8702 gate all timers behind a single clock gate. */
+	return "timer";
+}
+
+static void s5l87xx_timer_configure_interval(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	log_debug("s5l87xx_timer: configuring %d in interval mode\n", id);
+	s5l87xx_enable_clkgate(s5l87xx_timer_clockgate(id));
+
+	writel(S5L87XX_TIMER_CMD_STOP, &timer->cmd);
+	/* configure timer for 1000 Hz??? */
+	writel((3 << 8) | (1 << 4), &timer->con);
+	writel(511, &timer->pre);
+	writel(0xffff, &timer->data0);
+	writel(0xffff, &timer->data1);
+	writel(S5L87XX_TIMER_CMD_CLR, &timer->cmd);
+}
+
+static void s5l87xx_timer_start(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	log_debug("s5l87xx_timer: starting %d\n", id);
+	writel(S5L87XX_TIMER_CMD_START, &timer->cmd);
+}
+
+static u32 s5l87xx_timer_read(enum s5l87xx_timer_id id)
+{
+	struct s5l87xx_timer *timer = s5l87xx_timer_registers(id);
+
+	return readl(&timer->cnt);
+}
+
+int timer_init(void)
+{
+	s5l87xx_timer_configure_interval(SYSTEM_TIMER);
+	s5l87xx_timer_start(SYSTEM_TIMER);
+
+	return 0;
+}
+
+unsigned long timer_read_counter(void)
+{
+	static u16 last, high;
+
+	u16 now = s5l87xx_timer_read(SYSTEM_TIMER);
+
+	if (now < last)
+		high++;
+
+	last = now;
+
+	return ((u32)high << 16) | (u32)now;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8701.c b/arch/arm/mach-s5l87xx/s5l8701.c
new file mode 100644
index 00000000000..9cacbf3eafb
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <init.h>
+
+int print_cpuinfo(void)
+{
+	printf("CPU:   Samsung S5L8701 (ARM940T)\n");
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
+	// Corresponds to timer setup from s5l8701-timer.c.
+	// Is this correct?
+	return 1416;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8701/Kconfig b/arch/arm/mach-s5l87xx/s5l8701/Kconfig
new file mode 100644
index 00000000000..7a12d3c4d20
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8701/Kconfig
@@ -0,0 +1,12 @@
+if S5L8701
+
+config TARGET_N36
+	bool "Apple N36 - iPod nano (2nd generation)"
+	default y
+	help
+	  Apple iPod nano (2nd generation) is a digital audio player, introduced in
+	  September 2006. It has a NAND flash of either 2, 4 or 8 GiB.
+
+source "board/apple/n36/Kconfig"
+
+endif
diff --git a/board/apple/n36/Kconfig b/board/apple/n36/Kconfig
new file mode 100644
index 00000000000..19190eddbc1
--- /dev/null
+++ b/board/apple/n36/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N36
+
+config SYS_BOARD
+	default "n36"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8701"
+
+config SYS_CONFIG_NAME
+	default "apple_n36"
+
+endif
diff --git a/board/apple/n36/Makefile b/board/apple/n36/Makefile
new file mode 100644
index 00000000000..a8fde44f930
--- /dev/null
+++ b/board/apple/n36/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n36.o
diff --git a/board/apple/n36/n36.c b/board/apple/n36/n36.c
new file mode 100644
index 00000000000..663b213247c
--- /dev/null
+++ b/board/apple/n36/n36.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm/arch-s5l87xx/clk.h>
+
+static void board_clock_init(void)
+{
+	s5l87xx_enable_clkgate("uart");
+}
+
+int board_early_init_f(void)
+{
+	/* enabling UART clocking */
+	board_clock_init();
+
+	return 0;
+}
diff --git a/configs/apple_n36_defconfig b/configs/apple_n36_defconfig
new file mode 100644
index 00000000000..e2c9ff308f7
--- /dev/null
+++ b/configs/apple_n36_defconfig
@@ -0,0 +1,31 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_TEXT_BASE=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8701-n36"
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=24000000
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
diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index ac36e5e2d87..09f18c64408 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -287,6 +287,14 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 
 	enable_irq(IRQ_OTG);
 
+	if (IS_ENABLED(CONFIG_S5L8701)) {
+		u32 value;
+
+		value = readl(S5L87XX_INTMSK);
+		value |= 1 << IRQ_USB_FUNC;
+		writel(value, S5L87XX_INTMSK);
+	}
+
 	debug_cond(DEBUG_SETUP != 0,
 		   "Registered gadget driver %s\n", dev->gadget.name);
 	udc_enable(dev);
@@ -316,6 +324,14 @@ int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
 
 	disable_irq(IRQ_OTG);
 
+	if (IS_ENABLED(CONFIG_S5L8701)) {
+		u32 value;
+
+		value = readl(S5L87XX_INTMSK);
+		value &= ~(1 << IRQ_USB_FUNC);
+		writel(value, S5L87XX_INTMSK);
+	}
+
 	udc_disable(dev);
 	return 0;
 }
diff --git a/include/configs/apple_n36.h b/include/configs/apple_n36.h
new file mode 100644
index 00000000000..cad28a3cc8e
--- /dev/null
+++ b/include/configs/apple_n36.h
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
+// 176K SRAM total
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x0002C000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

