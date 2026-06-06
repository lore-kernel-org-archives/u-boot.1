Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A6BCD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD17848F5;
	Sat,  6 Jun 2026 06:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="t20Jjygc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C29484962; Sat,  6 Jun 2026 02:52:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB564848A9
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A07B3409E6;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7512DC2BCB4;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=mluKHT8GjPi3cfWqxSEAR6d505fuHR5HwuQ0H7XJIp0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=t20Jjygc5i8uOwozMknZSVCNKW3khuqt/+h9pQwTsnD44HOupBCywC2RVSxdqzsv6
 Xcxwg6ziZcbNLqIbNSKHonW9IoHkiMIVkq7PNBC19TP38dZmMS2RaXJ388tbVpRCH1
 IP2dclN8PDhewiFk/x6O87fsSWVWALN7NsD0W0LE7waxjwdzP3hQtBQ5D8JqDNVTFV
 SuLtfEl8Tiax8ZugqdIPpJLARKFtScORgq550PNLU082oME3VJ0j4+nA44/hV8gVba
 IO8nGJayivjej1JSavs4mEKMcTcyPo/wkFO4HAzqnfGcnPCwwq0mTAvmk1W9ygG/F1
 9/moEY44pBO/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6B17ECD8C8C;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:38 +1000
Subject: [PATCH 04/13] qcom: arch: arm: qcom: sdm845-fajita binman configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-4-c7a3c14b8a3d@samcday.com>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
In-Reply-To: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=1083;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=mZxf+Q/EuryyhsgbBMWO83UoITzAa8GMxzUa+eg9aHg=;
 b=xuPEhbs5wlRRl3fnxwvPIH14+S1PB2ShzfVDRdwV4PRuRxWrFJlY6jIrdylddDmdNv7eAS9iT
 zhP4GK22upSDGUcSMNhwUrszNATw0WQDc9RLUscjTW8wN7bJbIg0pT8
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:39 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

This binman configuration emits an Android v2 boot image that ABL will
accept. This platform accepts uncompressed kernel artifacts, and the
boot partition(s) are plenty big enough, so we opt for speed over size.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi b/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi
new file mode 100644
index 00000000000..b88be5a502e
--- /dev/null
+++ b/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <config.h>
+
+#ifdef CONFIG_BINMAN
+/ {
+	binman {
+		filename = "u-boot-oneplus-fajita.img";
+
+		android-boot {
+			header-version = <2>;
+			page-size = <4096>;
+			base = <0x00000000>;
+			kernel-offset = <0x00008000>;
+			dtb-offset = <0x01f00000>;
+
+			kernel {
+				u-boot-nodtb {};
+			};
+
+			dtb {
+				u-boot-dtb {};
+			};
+		};
+	};
+};
+#endif

-- 
2.54.0


