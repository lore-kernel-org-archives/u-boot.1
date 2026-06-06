Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50BFCD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260398486D;
	Sat,  6 Jun 2026 06:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o4MVNLn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98AAC84962; Sat,  6 Jun 2026 02:52:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D76F84878
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B4A9407CC;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 609F3C2BCC6;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=mx1v+LbN1kB+b5Pyxga/9Mi5gUxRysjdSl53yXxPrvk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=o4MVNLn59M2nlFJb30KljXXrhEfRIWLbkC2a23v+RmM4WMOCl0loWuOJu+zrePdZU
 MvmKQ4tsJrKkTKWWZ3ZAhDF1dWyOQGqT9tc9xOge4ca+xgxGUWKelTFVmDCi0mGvft
 /tbxVP6nR+HTW33s9f2jRPlNNUUJVOBwu0TBx+ihiGgpzrbTqe2kaaWI2yB0MY4iOB
 YSPOfNV1ZvxFepvZN+zLV7ErJ/AkdjvVOi61XIxGxOW+3eyejrqDg1VH+Dulo90vje
 +XMIYdZaq7Hm4Y0TQ5vq6awvr+hns8TYwIDlelNSBUg6D39xl7+5/ootWmpH1fkzCe
 IrkgURsVlp+Tg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 57D95CD6E7B;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:37 +1000
Subject: [PATCH 03/13] arch: arm: qcom: google-sargo binman config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-3-c7a3c14b8a3d@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=1036;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=x7PcMVoEJJF1L5LgC89yb2s092Ohj6g7/XUCPTRu96g=;
 b=XbbssfG97Eh7Atb99m55YWnn46VnWw+A4bdwnxHfIA8OuUA2Uor3sGdbtpgXwfU3Eo8a6zKVG
 EeHJv/TTFFUDB2KTNn5QfLUy1C1/2A2KbH06NAxO7Jj+dNhJUhcen8z
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
accept. Notably, this platform does not seem to accept uncompressed
kernel payloads, so it's gzipped.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/dts/sdm670-google-sargo-u-boot.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/dts/sdm670-google-sargo-u-boot.dtsi b/arch/arm/dts/sdm670-google-sargo-u-boot.dtsi
new file mode 100644
index 00000000000..3257ef165cd
--- /dev/null
+++ b/arch/arm/dts/sdm670-google-sargo-u-boot.dtsi
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <config.h>
+
+/ {
+	binman {
+		filename = "u-boot-google-sargo.img";
+
+		android-boot {
+			header-version = <2>;
+			page-size = <4096>;
+			base = <0x80000000>;
+			kernel-offset = <0x00008000>;
+			dtb-offset = <0x01f00000>;
+
+			kernel {
+				u-boot-nodtb {
+					compress = "gzip";
+				};
+			};
+
+			dtb {
+				u-boot-dtb {};
+			};
+		};
+	};
+};

-- 
2.54.0


