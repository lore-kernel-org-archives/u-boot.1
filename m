Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE4606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DErC58Gt;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=fB+nPH5m;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=FN2a9jMO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1119680C2D;
	Mon, 26 Oct 2026 22:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRhwOvCs0wPI; Mon, 26 Oct 2026 22:55:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EBEB580C41
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055328;
	b=pPabO8acipbwtaRNs79eZdBIUiu3DI0sP589lO0TQmV0w3m9mitwCNNJuHdOuVraYZ3u
	 lwZimo1cRSH+dRSyTjCmjnIRhjFuipH2nV5Q6iMN4T0r0NX4OVjsj5KwvqV6s04G0vWiv
	 5b1JB0cVn/UUPM0zQ/xTf/OnptjO49xslqtI0E7ny/m7xk5FhTocgoPzp4w0Cb+19MCFn
	 XLJLtpcjyEd49sNJktJlyIf6kBnmE09Ar4NbD0QqQuNJlEkijkVV7LZ+8ZuMA4Z59Ue9H
	 s9wdW1brkOXPphMDMVDU7GgLx0LIxsAcF57K/FDB86turJ6qUiKq+CFKORf0HzTuF/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055328;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B0oTcR5NAyL7Jm7QUDq4fnNZu9GdKBGHMjZypB5UTEs=;
	b=CIq7vazdPhDvp/rtFfAC5du4jLAs37Tf1ZVPzYF4B666IfPQQ1kt9mSHU/QZsLpwVCjs
	 qJ6tAEZ2C/TwsFi8aclrCswzSjfjm1IxW1ijyQZybnZ1Dza59nt8JXtioYDDCdoGp8Gg4
	 CeuSb2WZEdZJmecEyy6T6lXZ1YIPAlL/J3hr/1l6AkkgR49P3GZiCDBNOwr9yrF5kxuCf
	 H9CU3fLEsIbwy6aBv9275CIL3y1nUYjxeNYI2QZVG6U+qfLSv1xRlTvcQiL/UAPOG8mkc
	 gjkgJidzpOojVf2YCt7fJSIIFZxaNiVhrq/1nZqg9N68TGC+HPQxSyMHcTdX3dppSVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055328;
	bh=B0oTcR5NAyL7Jm7QUDq4fnNZu9GdKBGHMjZypB5UTEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DErC58Gt+uiX76PBSaCjCBQgYG5A5BFPNHHqBj68oKp7XBkYUXxZLKdPimcHtdSwl
	 jwnxNWXwBPX1+dT8xdRlm6NojK4ws13nw4VpZ+TTFTBRpgVimQzc7SyM1Q0x2xZXid
	 kSUI+BcjIgSlZLzlOqjtG5QkjhmB+usCiRev/e2YB/e02yi/bwDt0DOfYG75rjARMh
	 lGsE88cNaRTEAEP3QvE7D3jvmXcA/g2JOj5IrYfFiwKP+HuDRya4GFB8G18JbMBWBk
	 89UZbW9hh/pAF81jFtlfLI7Fh7TTXBlgwR6oCTJStXnhhvUJCjJc6A5mbBYTFOoKx6
	 Xzz+4qDLkZWpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBEB580C41;
	Mon, 26 Oct 2026 22:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B01380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5675F40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDW2FfIlYaRq for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 84B8740062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=69.169.224.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055313;
 b=jKnlOn60CnUm+w2p7LEYcsgbluKV3XR2PckEq+Uaf+yu/63PQluIfjbl/uSdjehlFfV7
 1+ogXx0uoQ6ml0rDhV0+2Nz5i4rhbmvG+/lkRb1oBgFpXpY8bLfe6JEzGHyy43jfi5FFW
 s2OkXtYBlxNPRlatoGQSdnQlD/wdbR4Xugaac/x3/08ALR8NBRS8g588zxbEO8xRWEUG/
 ktMumc/Oo3kUEIq1IuWceQ9heOhGycd5E4pFON5pugyWtbR2QtGY2BVoWuDe1snlN2lMn
 sYx+rLQY9wby36f6FQoThgof2TXk5qLOpufsZIahhW3G/S0BZjhjCJUNByZUKkmTQFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055313;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=B0oTcR5NAyL7Jm7QUDq4fnNZu9GdKBGHMjZypB5UTEs=;
 b=EijpDX+zRpCT+DQj2JoJdhVzj7isItyGywUy1NLahNhMMZsGfUevgvZFj+NFpPSweXwu
 16pANf+zAX0kzKekJtlDvFvokraJzlYX/DPally4p5G2I8wUlcvjWbHolQcqhx+26blji
 qnqoeU8oU6aMjGGU4rHib72E+sjou5GLviFX+UBNgJ/EYvL3sa7CVNc9u44ZixIB7dqEp
 eldo236xjGkOueml+1dciRpzY6EEUbIZizdF3j0lC+QNfNJMAUpetPnkxY3BdU3wcgAX2
 2HQ5Qsx2f0kR0YrZS5h3Mg3uQqEyr2q6M7BbgbBDWXrlCU9uriylhEuZsXgvm0OvDnQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=fB+nPH5m; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=FN2a9jMO; 
 arc=none smtp.remote-ip=69.169.224.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.8;
 helo=b224-8.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cbfe7-1740b045-13d8-4a20-bccc-6a1bc0409314-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=fB+nPH5m; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=FN2a9jMO
Received: from b224-8.smtp-out.eu-central-1.amazonses.com
 (b224-8.smtp-out.eu-central-1.amazonses.com [69.169.224.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84B8740062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055310;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=+Sac2+0DZvPziNnXHyY0kTcYemjc1GD9E1q2jL3qXAo=;
 b=fB+nPH5mc3GvNyj/jeIynh8eOOX8uusttNzW9qYajljkeHuFkD7eOi+9PQdRbZPb
 Z8vfpt01ViBJtDixHU3CKN5V74ElBOnCmV+ijqQM8HDcGWP5748JVL58UxBCyYp7Gbj
 khmGKbElpNKChIaXBhdyklTLS4+bIEWyD5beQHKFJ9lhZNOOrOXq47x4DBtk7Cj6xJH
 Rg9fokD7XS3bVLsoLKS5MKdqgctEkeJVBMc+9EABdkUls/NqgBor4TKmltc7fBsEOz/
 BBYnM8ikkHBlTefsfu9q1t0ZS88naCMp1gDxUe250IHaNAB3aLNgDTkVbkb8Lz170Zx
 G93yCnfKYQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055310;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=+Sac2+0DZvPziNnXHyY0kTcYemjc1GD9E1q2jL3qXAo=;
 b=FN2a9jMOTGHqqjyFz3B8RS3SaZL5QhqxbYLpuU2mYlbuS6XMljfem2ihNKHrMxII
 u8fG//9cPEoIsTvdCzdVCRNmCYq7zWK8aLVJ2qrPezxHHKhrvD18jq6baN6YSLCZOFB
 GzvzYFG2kUC6shGG5kll1S0xsfk6GHC7xt+fR4mo=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:09 +0000
Subject: [PATCH v2 10/14] New SoC/boards: S5L8702/N46 and N25
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cbfe7-1740b045-13d8-4a20-bccc-6a1bc0409314-000000@eu-central-1.amazonses.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=22949;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=+Sac2+0DZvPziNnXHyY0kTcYemjc1GD9E1q2jL3qXAo=;
 b=jgVL6pBGGpV4vxQ9mpcUJMlJzyNrwanBzOJ/uKsqiyhxtAxeluyyBjx58W9mhupTro88sAms4
 Tx9tFJwPHOGDIt9tpYJLPE2uSYTs4lO2DYZBSBa5vdk/tnkfBBvP5qE
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marketing name: Apple iPod nano (3rd generation)
Marketing name: Apple iPod classic

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 arch/arm/dts/s5l8702-common.dtsi        |  34 ++++++++
 arch/arm/dts/s5l8702-n25.dts            |  26 ++++++
 arch/arm/dts/s5l8702-n46.dts            |  26 ++++++
 arch/arm/dts/s5l8702.dtsi               |  44 ++++++++++
 arch/arm/mach-s5l87xx/Kconfig           |   1 +
 arch/arm/mach-s5l87xx/Makefile          |   5 ++
 arch/arm/mach-s5l87xx/relocate.S        |  27 +++++++
 arch/arm/mach-s5l87xx/s5l8702-otg-phy.c |  72 +++++++++++++++++
 arch/arm/mach-s5l87xx/s5l8702.c         |  18 +++++
 arch/arm/mach-s5l87xx/s5l8702/Kconfig   |  26 ++++++
 arch/arm/mach-s5l87xx/s5l87xx-timer.c   | 139 ++++++++++++++++++++++++++++++++
 board/apple/n25/Kconfig                 |  15 ++++
 board/apple/n25/Makefile                |   7 ++
 board/apple/n25/n25.c                   |  50 ++++++++++++
 board/apple/n46/Kconfig                 |  15 ++++
 board/apple/n46/Makefile                |   7 ++
 board/apple/n46/n46.c                   |  51 ++++++++++++
 configs/apple_n25_defconfig             |  37 +++++++++
 configs/apple_n46_defconfig             |  36 +++++++++
 include/configs/apple_n25.h             |  15 ++++
 include/configs/apple_n46.h             |  15 ++++
 21 files changed, 666 insertions(+)

diff --git a/arch/arm/dts/s5l8702-common.dtsi b/arch/arm/dts/s5l8702-common.dtsi
new file mode 100644
index 00000000000..4c2aabc35a0
--- /dev/null
+++ b/arch/arm/dts/s5l8702-common.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Peripherals common to Samsung S5L8702 and later SoCs
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+
+/ {
+	soc {
+		vic0: interrupt-controller@38e00000 {
+			compatible = "arm,pl192-vic";
+			interrupt-controller;
+			reg = <0x38e00000 0x1000>;
+			#interrupt-cells = <1>;
+		};
+
+		usbotg_hs: usb@38400000 {
+			compatible = "apple,s5l87xx-usb";
+			reg = <0x38400000 0x40000>;
+			interrupt-parent = <&vic0>;
+			interrupts = <19>;
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
+			clocks = <&clkref>;
+			clock-names = "otg";
+			g-rx-fifo-size = <256>;
+			g-np-tx-fifo-size = <256>;
+			g-tx-fifo-size = <256 256 256 256 256 256>;
+			dr_mode = "peripheral";
+		};
+	};
+};
diff --git a/arch/arm/dts/s5l8702-n25.dts b/arch/arm/dts/s5l8702-n25.dts
new file mode 100644
index 00000000000..a069e4e3609
--- /dev/null
+++ b/arch/arm/dts/s5l8702-n25.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod classic (6th generation)
+ *
+ * target-type: N25
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8702.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n25", "samsung,s5l8702", "apple,arm-platform";
+	model = "Apple iPod classic (6th generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x04000000>; /* 64 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <12000000>;
+};
diff --git a/arch/arm/dts/s5l8702-n46.dts b/arch/arm/dts/s5l8702-n46.dts
new file mode 100644
index 00000000000..e7fe5cb26ec
--- /dev/null
+++ b/arch/arm/dts/s5l8702-n46.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Apple iPod nano (3rd generation)
+ *
+ * target-type: N46
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+/dts-v1/;
+
+#include "s5l8702.dtsi"
+#include "s5l87xx-nxx.dtsi"
+
+/ {
+	compatible = "apple,n46", "samsung,s5l8702", "apple,arm-platform";
+	model = "Apple iPod nano (3rd generation)";
+};
+
+&memory {
+	reg = <0x08000000 0x02000000>; /* 32 MiB SDRAM */
+};
+
+&clkref {
+	clock-frequency = <12000000>;
+};
diff --git a/arch/arm/dts/s5l8702.dtsi b/arch/arm/dts/s5l8702.dtsi
new file mode 100644
index 00000000000..b94dbd87b9c
--- /dev/null
+++ b/arch/arm/dts/s5l8702.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Samsung S5L8702 SoC
+ *
+ * Other names: M1A
+ *
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include "s5l87xx.dtsi"
+#include "s5l8702-common.dtsi"
+
+/ {
+	compatible = "samsung,s5l8702", "apple,arm-platform";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+};
+
+&cpu0 {
+	compatible = "arm,arm926ejs";
+};
+
+&clkgates {
+	/*
+	 * Clock-gate name -> {gate, bit} table consumed by s5l87xx_enable_clkgate().
+	 * Each entry is two cells: gate * 32 + bit, with 0xffffffff for an unused
+	 * second gate. Timers carry a secondary gate 4 enable; S5L8702 itself gates
+	 * all timers behind one gate (rockbox CLOCKGATE_TIMER 37 = {1,5}).
+	 */
+	clock-gate-names = "timer0", "timer1", "timer2", "timer3", "timer4",
+					   "timer7", "timer8", "uart0",
+					   "usb-otg", "usb2-phy", "bootrom",
+					   "timer", "lcd", "i2c0";
+	samsung,clock-gates = <37 128>, <55 129>, <56 130>, <57 131>, <58 132>,
+						  <69 150>, <70 151>, <41 135>,
+						  <2 0xffffffff>, <35 0xffffffff>, <30 0xffffffff>,
+						  <37 0xffffffff>, <1 0xffffffff>, <36 0xffffffff>;
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
index ec35a293998..11eeb4d7467 100644
--- a/arch/arm/mach-s5l87xx/Kconfig
+++ b/arch/arm/mach-s5l87xx/Kconfig
@@ -58,5 +58,6 @@ config S5L8740
 endchoice
 
 source "arch/arm/mach-s5l87xx/s5l8701/Kconfig"
+source "arch/arm/mach-s5l87xx/s5l8702/Kconfig"
 
 endif
diff --git a/arch/arm/mach-s5l87xx/Makefile b/arch/arm/mach-s5l87xx/Makefile
index 68da781df74..4cccb797da2 100644
--- a/arch/arm/mach-s5l87xx/Makefile
+++ b/arch/arm/mach-s5l87xx/Makefile
@@ -9,3 +9,8 @@ obj-y += s5l87xx-clk.o
 obj-$(CONFIG_S5L8701) += s5l8701.o
 obj-$(CONFIG_S5L8701) += s5l8701-otg-phy.o
 obj-$(CONFIG_S5L8701) += s5l8701-timer.o
+
+obj-$(CONFIG_S5L8702) += relocate.o
+obj-$(CONFIG_S5L8702) += s5l8702.o
+obj-$(CONFIG_S5L8702) += s5l8702-otg-phy.o
+obj-$(CONFIG_S5L8702) += s5l87xx-timer.o
diff --git a/arch/arm/mach-s5l87xx/relocate.S b/arch/arm/mach-s5l87xx/relocate.S
new file mode 100644
index 00000000000..65987d0f1e8
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/relocate.S
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 The freemyipod team (freemyipod.org)
+ */
+
+#include <asm-offsets.h>
+#include <config.h>
+#include <linux/linkage.h>
+
+    .section    .text.relocate_vectors,"ax",%progbits
+
+ENTRY(relocate_vectors)
+    /* Remap SRAM to 00000000. */
+    ldr r0, =0x3e00000c
+    mov r1, #3 /* REMAP_SRAM | REMAP_ENABLE */
+    str r1, [r0]
+
+    /* Copy vectors to 00000000. */
+    ldr r0, [r9, #GD_RELOCADDR] /* r0 = gd->relocaddr */
+    ldr     r1, =0x00000000
+    ldmia   r0!, {r2-r8,r10}
+    stmia   r1!, {r2-r8,r10}
+    ldmia   r0!, {r2-r8,r10}
+    stmia   r1!, {r2-r8,r10}
+
+    bx lr
+ENDPROC(relocate_vectors)
diff --git a/arch/arm/mach-s5l87xx/s5l8702-otg-phy.c b/arch/arm/mach-s5l87xx/s5l8702-otg-phy.c
new file mode 100644
index 00000000000..b5bd04399d8
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8702-otg-phy.c
@@ -0,0 +1,72 @@
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
+// S5L8702 OTG PHY register layout, reverse-engineered from a disk mode QEMU
+// trace. Differs from the S5L8730/N36 layout, so it is kept separate.
+struct s5l8702_otgphy {
+	u32 pwr;		// 0x00 - power down control
+	u32 clk;		// 0x04 - clock select
+	u32 rstcon;		// 0x08 - reset control (3 bits)
+	u32 pad0[3];	// 0x0c-0x14
+	u32 bias;		// 0x18 - analog bias/trim
+	u32 pad1[5];	// 0x1c-0x2c  (0x28 read-only by bootrom)
+	u32 intfcon;	// 0x30 - interface control
+	u32 pad2[3];	// 0x34-0x3c
+	u32 phy_ctrl1;	// 0x40 - analog power stage 1
+	u32 phy_ctrl2;	// 0x44 - analog power stage 2
+};
+
+void otg_phy_init(void *unused)
+{
+	struct s5l8702_otgphy *otgphy = (struct s5l8702_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8702_otgphy: turning on\n");
+	s5l87xx_enable_clkgate("usb-otg");
+	s5l87xx_enable_clkgate("usb2-phy");
+
+	// Disable USB suspend.
+	writel(0, S5L87XX_OTG_BASE + 0xe00);
+
+	writel(0x000, &otgphy->pwr);
+	writel(0x000, &otgphy->clk);
+	writel(0x400, &otgphy->bias);
+	writel(0x007, &otgphy->rstcon); // assert all three reset signals
+
+	// Ramp up PHY analog stage 1 incrementally (from disk mode trace).
+	writel(0x300, &otgphy->phy_ctrl1);
+	writel(0x340, &otgphy->phy_ctrl1);
+	writel(0x346, &otgphy->phy_ctrl1);
+	writel(0x347, &otgphy->phy_ctrl1);
+
+	// Ramp up PHY analog stage 2 incrementally (from disk mode trace).
+	writel(0x0c00, &otgphy->phy_ctrl2);
+	writel(0x0fc0, &otgphy->phy_ctrl2);
+	writel(0x0fe0, &otgphy->phy_ctrl2);
+	writel(0x0ff0, &otgphy->phy_ctrl2);
+	writel(0x0fff, &otgphy->phy_ctrl2);
+
+	writel(1, S5L87XX_PHY_BASE + 0x100); // enable PHY output
+
+	writel(0x000, &otgphy->rstcon); // deassert reset
+	writel(0x400, &otgphy->bias);
+	writel(0x000, &otgphy->intfcon);
+	writel(0x000, &otgphy->bias);
+}
+
+void otg_phy_off(void *unused)
+{
+	struct s5l8702_otgphy *phy = (struct s5l8702_otgphy *)S5L87XX_PHY_BASE;
+
+	log_debug("s5l8702_otgphy: turning off\n");
+	writel(0, &phy->phy_ctrl2);
+	writel(0, &phy->phy_ctrl1);
+	writel(0x7, &phy->rstcon);
+	writel(0xff, &phy->pwr);
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8702.c b/arch/arm/mach-s5l87xx/s5l8702.c
new file mode 100644
index 00000000000..58d8f9918d3
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8702.c
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
+	printf("CPU:   Samsung S5L8702 (ARM926EJ-S)\n");
+	return 0;
+}
+
+ulong get_tbclk(void)
+{
+	// Corresponds to TIMER_F setup from s5l87xx.c.
+	return 1000000;
+}
diff --git a/arch/arm/mach-s5l87xx/s5l8702/Kconfig b/arch/arm/mach-s5l87xx/s5l8702/Kconfig
new file mode 100644
index 00000000000..566c5b47bfd
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l8702/Kconfig
@@ -0,0 +1,26 @@
+if S5L8702
+
+choice
+	prompt "S5L8702 board select"
+	help
+	  Choose which S5L8702 board are you building for. Currently only N46 (iPod
+	  nano 3rd generation) and N25 (iPod classic 6th generation) are supported.
+
+config TARGET_N46
+	bool "Apple N46 - iPod nano (3rd generation)"
+	help
+	  Apple iPod nano (3rd generation) is a digital audio player, introduced in
+	  September 2007. It has a NAND flash of either 4 or 8 GiB.
+
+config TARGET_N25
+	bool "Apple N25 - iPod classic (6th generation)"
+	help
+	  Apple iPod classic (6th generation) is a digital audio player, introduced
+	  in September 2007. It has a HDD of either 80, 120 or 160 GiB.
+
+endchoice
+
+source "board/apple/n46/Kconfig"
+source "board/apple/n25/Kconfig"
+
+endif
diff --git a/arch/arm/mach-s5l87xx/s5l87xx-timer.c b/arch/arm/mach-s5l87xx/s5l87xx-timer.c
new file mode 100644
index 00000000000..26124354163
--- /dev/null
+++ b/arch/arm/mach-s5l87xx/s5l87xx-timer.c
@@ -0,0 +1,139 @@
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
+	// Timer E: 64-bit (unimplemented, different registers from others)
+	S5L87XX_TIMER_E = 4,
+	// Timers F, G, H, I: 32-bit
+	S5L87XX_TIMER_F = 5,
+	S5L87XX_TIMER_G = 6,
+	S5L87XX_TIMER_H = 7,
+	S5L87XX_TIMER_I = 8,
+};
+
+#define SYSTEM_TIMER S5L87XX_TIMER_F
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
+	case S5L87XX_TIMER_E:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x80);
+	case S5L87XX_TIMER_F:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0xa0);
+	case S5L87XX_TIMER_G:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0xc0);
+	case S5L87XX_TIMER_H:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0xe0);
+	case S5L87XX_TIMER_I:
+		return (struct s5l87xx_timer *)(S5L87XX_TIMER_BASE + 0x100);
+	default:
+		panic("requested invalid timer id %d", id);
+	}
+}
+
+static const char *s5l87xx_timer_clockgate(enum s5l87xx_timer_id id)
+{
+	if (IS_ENABLED(CONFIG_S5L8702))
+		/* S5L8701 and S5L8702 gate all timers behind a single clock gate. */
+		return "timer";
+
+	switch (id) {
+	case S5L87XX_TIMER_A:
+		return "timer0";
+	case S5L87XX_TIMER_B:
+		return "timer1";
+	case S5L87XX_TIMER_C:
+		return "timer2";
+	case S5L87XX_TIMER_D:
+		return "timer3";
+	case S5L87XX_TIMER_E:
+		return "timer4";
+	case S5L87XX_TIMER_F:
+		return "timer5";
+	case S5L87XX_TIMER_G:
+		return "timer6";
+	case S5L87XX_TIMER_H:
+		return "timer7";
+	case S5L87XX_TIMER_I:
+		return "timer8";
+	default:
+		panic("requested invalid timer id %d", id);
+	}
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
+	writel(0x40, &timer->con);
+	writel(0xb, &timer->pre);
+	writel(0xffffffff, &timer->data0);
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
+	return s5l87xx_timer_read(SYSTEM_TIMER);
+}
diff --git a/board/apple/n25/Kconfig b/board/apple/n25/Kconfig
new file mode 100644
index 00000000000..cdeac8303aa
--- /dev/null
+++ b/board/apple/n25/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N25
+
+config SYS_BOARD
+	default "n25"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8702"
+
+config SYS_CONFIG_NAME
+	default "apple_n25"
+
+endif
diff --git a/board/apple/n25/Makefile b/board/apple/n25/Makefile
new file mode 100644
index 00000000000..44143c4dc44
--- /dev/null
+++ b/board/apple/n25/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n25.o
diff --git a/board/apple/n25/n25.c b/board/apple/n25/n25.c
new file mode 100644
index 00000000000..5fa1777a835
--- /dev/null
+++ b/board/apple/n25/n25.c
@@ -0,0 +1,50 @@
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
+	// Disable all VIC interrupts before U-Boot configures them.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	board_gpio_init();
+	board_clock_init();
+	board_vic_init();
+
+	return 0;
+}
+
+void board_debug_uart_init(void)
+{
+	board_gpio_init();
+
+	// Runs before the FDT is set up, so ungate uart0 by raw {gate, bit}
+	// ({1,9} + {4,7}) rather than the device-tree-driven name lookup.
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/board/apple/n46/Kconfig b/board/apple/n46/Kconfig
new file mode 100644
index 00000000000..efbb15d14cc
--- /dev/null
+++ b/board/apple/n46/Kconfig
@@ -0,0 +1,15 @@
+if TARGET_N46
+
+config SYS_BOARD
+	default "n46"
+
+config SYS_VENDOR
+	default "apple"
+
+config SYS_SOC
+	default "s5l8702"
+
+config SYS_CONFIG_NAME
+	default "apple_n46"
+
+endif
diff --git a/board/apple/n46/Makefile b/board/apple/n46/Makefile
new file mode 100644
index 00000000000..ccc6abd8067
--- /dev/null
+++ b/board/apple/n46/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 The freemyipod team (freemyipod.org)
+#
+
+obj-y += ../nxx-common/nxx.o
+obj-y += n46.o
diff --git a/board/apple/n46/n46.c b/board/apple/n46/n46.c
new file mode 100644
index 00000000000..4fb104e437c
--- /dev/null
+++ b/board/apple/n46/n46.c
@@ -0,0 +1,51 @@
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
+	// Disable all VIC interrupts before U-Boot configures them.
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(0));
+	writel(0xffffffff, S5L87XX_VICINTENCLEAR(1));
+}
+
+int board_early_init_f(void)
+{
+	board_gpio_init();
+	board_clock_init();
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
+	// Runs before the FDT is set up, so ungate uart0 by raw {gate, bit}
+	// ({1,9} + {4,7}) rather than the device-tree-driven name lookup.
+	s5l87xx_enable_clkgate_bit(1, 9);
+	s5l87xx_enable_clkgate_bit(4, 7);
+}
diff --git a/configs/apple_n25_defconfig b/configs/apple_n25_defconfig
new file mode 100644
index 00000000000..ccae6bdc7fd
--- /dev/null
+++ b/configs/apple_n25_defconfig
@@ -0,0 +1,37 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_TEXT_BASE=0x08000800
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8702-n25"
+CONFIG_S5L8702=y
+CONFIG_TARGET_N25=y
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=12000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART=y
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_FIT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_USE_PREBOOT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_CMD_DFU=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_BAUDRATE=57600
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/configs/apple_n46_defconfig b/configs/apple_n46_defconfig
new file mode 100644
index 00000000000..0942baa89ac
--- /dev/null
+++ b/configs/apple_n46_defconfig
@@ -0,0 +1,36 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_ARCH_S5L87XX=y
+CONFIG_SUPPORT_PASSING_ATAGS=y
+CONFIG_CMDLINE_TAG=y
+CONFIG_TEXT_BASE=0x08000800
+CONFIG_SYS_MALLOC_LEN=0x00200000
+CONFIG_DEFAULT_DEVICE_TREE="s5l8702-n46"
+CONFIG_S5L8702=y
+CONFIG_SYS_LOAD_ADDR=0x08000000
+CONFIG_DEBUG_UART_BASE=0x3CC00000
+CONFIG_DEBUG_UART_CLOCK=12000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART=y
+CONFIG_STACK_SIZE=0x00100000
+CONFIG_FIT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="dfu 0 ram 0; bootm"
+CONFIG_USE_PREBOOT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_CMD_DFU=y
+CONFIG_OF_CONTROL=y
+CONFIG_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SET_DFU_ALT_INFO=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x00100000
+CONFIG_BAUDRATE=57600
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x05ac
+CONFIG_USB_GADGET_PRODUCT_NUM=0xff00
+CONFIG_USB_GADGET_DWC2_OTG=y
+CONFIG_USB_GADGET_DOWNLOAD=y
diff --git a/include/configs/apple_n25.h b/include/configs/apple_n25.h
new file mode 100644
index 00000000000..007cda4c9fd
--- /dev/null
+++ b/include/configs/apple_n25.h
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
+// 256K SRAM total, first 128K are the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00040000
+
+#endif	/* __CONFIG_H */
diff --git a/include/configs/apple_n46.h b/include/configs/apple_n46.h
new file mode 100644
index 00000000000..007cda4c9fd
--- /dev/null
+++ b/include/configs/apple_n46.h
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
+// 256K SRAM total, first 128K are the fastest, then 128K slower than DRAM
+#define CFG_SYS_INIT_RAM_ADDR	0x22000000
+#define CFG_SYS_INIT_RAM_SIZE	0x00040000
+
+#endif	/* __CONFIG_H */

-- 
Git-157)

