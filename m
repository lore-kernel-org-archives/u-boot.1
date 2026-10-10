Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AC5CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA20F40953;
	Sat, 10 Oct 2026 19:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKWl6jbAbq3X; Sat, 10 Oct 2026 19:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7E874089A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791659400;
	b=nufJvGGZ0v/AQXU01WbQs95O6XGZtrV9AHTweRfgIZ/ylr0tFECJHZ3tOfnxrWhLr+8g
	 eqhx19fSzIe/a9heDoy1bRZZD3OH8C/cxVR6CbzsPdT65FgcKP0RTf9FPzMVbw4FRBRRQ
	 Ql8OihkxhIDqRtNDWzCUIIt45asJAVuWv4fw2hNjY6sx9+cvYjKILRlNX5Umvshf2OPd+
	 f4MM+M25wDcFf8mVpwY7LsC6p/j/Va/QxK2TNB/SjiYEdWzUgU4co5I/QhQzjY2+UnN1k
	 OSUPJKBxzldV1JSdxaGpkBYHmDvCShCo7cBZuTt3PLU5ew+GlxhC+WsJqGtCUXHnl4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791659400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qmVjGw8kXIOZEDJuss7douCRDU9U59dcxZjVd0XrIoY=;
	b=GWllfTlbrK2rex1MQahptIHJ16Y317XPb49zjGady3cXwrjUFSEO2kiVDPLFolgyUFkL
	 5PmQRPU6uDf0tBiSEPZ/cTuPIGyWZxE0XrvJPV9IUPP77sxQYBV5hnTuRmWYhGDFCyyK7
	 3zdA7r5BUr0hq7MP1ljVN88/J7ZDzMFGTvIof3Jb3MeGKP5eUgZMnkuQ7C15VQcXII6pf
	 KFiGtvZV4kEQw+V6fnAeSfjKSJqVN16ifSP7zoqoS7NseqqP+KBpq659gblvTR+KhmGsH
	 BUA0eP0Sm2g5OWKI15RL6mnLBMha7wKSY1saIQtlUGwxrvTuvFRGe0JFrVY9x6+vfhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791659400;
	bh=qmVjGw8kXIOZEDJuss7douCRDU9U59dcxZjVd0XrIoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xD5Xrd9QW1BjF1x5Y6LIoebImkBB1yyhmTfx1H9U1TwFrQNw6r+5PC9VpILN9OyX8
	 WjId66/BWUHradH4gQLFAkXiqBPhvBb4Sp6LUfZenHjBeUT1WS01APNoFUkbMDc8Nm
	 wSyLfZCdq3SCKC0PhywcrjOhaY1046VHblZiPtpfCSSDylHPzUOeLs3GqXDO0deYbG
	 WjmZn/zPjXqLPsOVWhdEJcRDrEQxIfmPjmOArNjStzWrDGS+kwCSfKAU4GN+B/JCWZ
	 RGSOyUjYTAbjO5d4RTRGvqGb8/FnTERwAoIKUOUZbG8PlfowY9r00MBjapcqFePSm6
	 eN8SVI+ZC++EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7E874089A;
	Sat, 10 Oct 2026 19:09:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FC2D1A6
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55C9140071
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85VxFHrj94jW for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 14:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AF40D40004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791642293;
 b=ZgbmO1+SXaX95NILOZBerZkQGZVd+vrvuxbf0RhYsYl1VGI2QkzU3+BPLRIvL3j5+6nQ
 aWII1zkl3G31xmxUHeMYWkOfYDF0x7M5TcYCd5YCw9fYGZxAE3iLhI7qGKMOZO6FnqhQ0
 sF/yBsycPNH621+55hbKDOanUJ2ejkwvjGzG3IT6WRawKbyZ/pqgycyL1DqW4LbLEI4Hr
 JaEfqT7uCVLyDegEG0QfFcMVllYCiyWmh0qGem/6Zt+24mgK4bDSWuOA2JZFYJmJZ+PhN
 S89Oj7j/Se5V2atuFowrtt+RAiFCIaCxOYOVfB0ctM/7D86XMEr1bIoOZiytO4VwADw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791642293;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=qmVjGw8kXIOZEDJuss7douCRDU9U59dcxZjVd0XrIoY=;
 b=amDAgBGgvJZ4S+q0KEj3fWVndrL0qE1P4fgssqlHtm9qIV9QOnM74kTnhscqcWVQxx/t
 xXWiYbfD5lMkbqqhLgRtpAe6i3CeYbAps9xtUSYE+XyQF6iU9MshLQb2A+untWxO/G6su
 jyuLd8j00ah8XfhfP8HfMsHv7nl6TI0BcEsXvIc84mLnIUAP+nEaDBV3qvUDilw99Zw/w
 EqsC0jr3KJFdn1+xDBm/Cja6HQV2/6nlVBJZ93KrCCOu38pTldAv8abKc5uuWQujZowVl
 HVw1Ht50Lv77g8X5x/dzJoIyFAqpENQ2Ibn9KwtL4/xiwpw6KtRL4y5pCy5Kbhs0dSw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZD1XTruc; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ZD1XTruc
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AF40D40004
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 14:24:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C214642E1F;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A348FC2BCFC;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791642292;
 bh=rWempJW2vnD5YGnix3gyHUk4h74F/oUXtjVVdJ4JyN8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ZD1XTrucYZeE548h0RzL1Gc+6AIWWamanogyBgatIN0CoMMGbT4US/J9xdMSYHWl2
 9SmC2lUbYvyK7PrcCSghWfAiAyHhCoNOSwgTMdEjgQRpmtq+lJeGNLfjrfUj4/z3lF
 N3RXqdeORmp9D0jy5ppzJ4DqBP1Gd1iMBCcHvRZ6efAlhM5v2Dar/+HPV3P4jeDf8f
 hnfQHFETmE7rg7DgQH7440j6VWgP49xZEMB9YBqjAuCbEos/4xvJu+OLL6dSQ3YiTw
 Ta/3M8JGbTkLg5mlvyc2zEq7/JJjOB4cbcwrnKo2V9RDuCkyzvFbKLXJrnBebtYUe5
 yxzWrkE1LwaCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8771BCA9EC3;
 Sat, 10 Oct 2026 14:24:52 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 10 Oct 2026 16:24:46 +0200
Subject: [PATCH 2/4] binman: test: Add fit fdt compression device trees
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-b4-binman-fit-fdt-compression-v1-2-4465558758cc@protonmail.com>
References: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
In-Reply-To: <20261010-b4-binman-fit-fdt-compression-v1-0-4465558758cc@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791642291; l=3589;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=25dRcKDeN8eZSGb06AEbdr13LFy88eBHoMFpYEseEBA=;
 b=eSf8AKTUVR6DeEHtlFtoffeLkp2FEW4BbFvWP57ybAUDZ7EEHbwaT87noRvmCR1wkAJslVn/t
 S/dgSpQk+tKAGF+qk08yHnl+A7JwtZPGryr8caAKWW1Zn9WZkdu54xU
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:09:53 +0000
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
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add two copies of fit/fdt.dts whose @fdt-SEQ template asks for "lzma"
and for an unsupported algorithm ("bzip2").

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 tools/binman/test/fit/fdt_bad_comp.dts | 72 ++++++++++++++++++++++++++++++++++
 tools/binman/test/fit/fdt_lzma.dts     | 72 ++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

diff --git a/tools/binman/test/fit/fdt_bad_comp.dts b/tools/binman/test/fit/fdt_bad_comp.dts
new file mode 100644
index 00000000000..26a74895ac7
--- /dev/null
+++ b/tools/binman/test/fit/fdt_bad_comp.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				kernel {
+					description = "Vanilla Linux kernel";
+					type = "kernel";
+					arch = "ppc";
+					os = "linux";
+					compression = "gzip";
+					load = <00000000>;
+					entry = <00000000>;
+					hash-1 {
+						algo = "crc32";
+					};
+					hash-2 {
+						algo = "sha1";
+					};
+					u-boot {
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "bzip2";
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "uboot";
+					loadables = "atf";
+					fdt = "fdt-SEQ";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};
diff --git a/tools/binman/test/fit/fdt_lzma.dts b/tools/binman/test/fit/fdt_lzma.dts
new file mode 100644
index 00000000000..1a25ded4b8b
--- /dev/null
+++ b/tools/binman/test/fit/fdt_lzma.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+		};
+		fit {
+			description = "test-desc";
+			#address-cells = <1>;
+			fit,fdt-list = "of-list";
+
+			images {
+				atf {
+					description = "atf firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				uboot {
+					description = "U-Boot firmware";
+					type = "firmware";
+					compression = "none";
+					load = <00000000>;
+					entry = <00000000>;
+				};
+				kernel {
+					description = "Vanilla Linux kernel";
+					type = "kernel";
+					arch = "ppc";
+					os = "linux";
+					compression = "gzip";
+					load = <00000000>;
+					entry = <00000000>;
+					hash-1 {
+						algo = "crc32";
+					};
+					hash-2 {
+						algo = "sha1";
+					};
+					u-boot {
+					};
+				};
+				@fdt-SEQ {
+					description = "fdt-NAME.dtb";
+					type = "flat_dt";
+					compression = "lzma";
+					hash {
+						algo = "sha256";
+					};
+				};
+			};
+
+			configurations {
+				default = "@config-DEFAULT-SEQ";
+				@config-SEQ {
+					description = "conf-NAME.dtb";
+					firmware = "uboot";
+					loadables = "atf";
+					fdt = "fdt-SEQ";
+				};
+			};
+		};
+		u-boot-nodtb {
+		};
+	};
+};

-- 
2.55.0


