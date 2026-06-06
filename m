Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D33CCD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DDB84964;
	Sat,  6 Jun 2026 06:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YvfzoDmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C1B84878; Sat,  6 Jun 2026 02:52:49 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C80F84944
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 206364416C;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC760C2BCB4;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707161;
 bh=HbPyycQOAZ5PXuZHEEMFcfWeAdMrTGep/YsYYTj3NKI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=YvfzoDmOU+dZyHivWCIAIBx5Gl+OT9k+ynC9w0+N1skZy/9PevgpVTWTuoNL1q3RG
 RrWsHZsyJZhNQ2rxjo09URefpA3uS2sDRPiTM86Stx/+eXKbQr0RPXwEbVLjhuaXPz
 wQZQ/9B3+fDgQ4lvFBHh0S6WEC/lvmOv3+g0eloM5e4xYuU+mlEtqfF6xCw0kEqTGW
 BH0wtaw8x/sHlDh+KToMS20mtq+q33v0cgs4vQvuI9XQ04s0i/kg9/nh0DnBQ42vtO
 0bQgZFL2ugnruNjC83S4+e8e5S3mxpYB0Zi0bex7z36tlq7IjknP5zKLRlHeLQdfTy
 qw3jlxyyvElrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E4744CD8C88;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:44 +1000
Subject: [PATCH 10/13] arch: arm: qcom: samsung-gt510 binman config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-10-c7a3c14b8a3d@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=1137;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=q0SxIURCjc44eZjkjf69qGVfGy9ts/AdxjjhWGBBf3w=;
 b=ODaVhvaEro6AvAG3oquLYq9JiOVw1Ml2xrvmSokyAsoQtZPj5rtm34weXnWFGdFNStm8QIuV6
 AjCVIZv0BNAC2/x2weYr7H0hWNxyncbt8bB7ZJWLoG0K4Pum0NUcf6Y
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

Emits an Android boot.img that runs U-Boot from the boot partition
(chained from aboot).

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi b/arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi
new file mode 100644
index 00000000000..53f301a2b79
--- /dev/null
+++ b/arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/arm/qcom,ids.h>
+
+/ {
+	binman {
+		filename = "u-boot-samsung-gt510.img";
+
+		android-boot {
+			header-version = <0>;
+			page-size = <2048>;
+			base = <0x80000000>;
+			append-seandroid-enforce;
+
+			kernel {
+				u-boot {
+					no-expanded;
+				};
+			};
+
+			ramdisk {
+				fill {
+					size = <1>;
+				};
+			};
+
+			vendor-dt {
+				qcdt {
+					dtb-0 {
+						qcom,msm-id = <QCOM_ID_MSM8916 0>;
+						qcom,board-id = <0xce08ff01 7>;
+
+						u-boot-dtb {};
+					};
+				};
+			};
+		};
+	};
+};

-- 
2.54.0


