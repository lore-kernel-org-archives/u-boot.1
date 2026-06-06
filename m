Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDF0CD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF7984994;
	Sat,  6 Jun 2026 06:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tNFH+7Sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B413A84671; Sat,  6 Jun 2026 02:52:50 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506C984956
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 38492445E2;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C1B0C2BCC6;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707161;
 bh=gyMCAk4EQg/n39XKPbgcLqeJEoi/8r8XZ5dLgb8LMfI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tNFH+7SjzI7q2lA28Ks+X5fEptQrqwLxGSDMw/Hukx3mLclo9TgQbkTcCcn5/73Ii
 C1ea9Km4KOjOBqvZPWdgR42hva62gSbu1TmHlzSWUdMjnzBiG4BXxPMVdCwZQjscDP
 7YV3Wz7LySnRWzWQCneveXZ3XzsFdQya8c0n7QaELOhjyD0t6wkfKs2X/CyR/lVXmr
 H+3uTDxJ4JrtHkrax1sl06yaYh2xFZmbLmNZJVFWcC9Q13Zax72MeHOOfe1E4ldPbf
 BkLNinWz2/OgURoURBzG4B1hA7z1uu26kO/Z/NJCtqaMX1P52q4KOVdClJSlgCZA36
 Q8FAYHlMIDxqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 13AC3CD8C8C;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:46 +1000
Subject: [PATCH 12/13] arch: arm: exynos: add j7xelte binman config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-12-c7a3c14b8a3d@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=1641;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=hzM31luBfhFowNCNLsI3ruIRjk1FJsZ3zNEzn6DLuPs=;
 b=BTtUFmppJKh7IRNx/9XUZUpbbk1zxge3TYJMlz/TrxM72n1SS4YL8LLgD8DrbUyBFHP4HIUoF
 u+T/bLwNh5BB5JOUIr7KFJWCPcezeyjvuhoHReT7y0tufw8emNhWk3I
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

Note that, as of this commit, j7xelte does not yet exist in U-Boot's
upstream DTS tree. It was accepted into next so it should appear here
eventually.

S-BOOT expects a DTBH with hw-rev == 6.

Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080.b4-ty@kernel.org/
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi    | 24 ++++++++++++++++++++++++
 arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi |  2 --
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
new file mode 100644
index 00000000000..90bf3b735d5
--- /dev/null
+++ b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	/* These properties are required by S-BOOT. */
+	model_info-chip = <7870>;
+	model_info-hw_rev = <6>;
+	model_info-hw_rev_end = <6>;
+
+	binman {
+		filename = "u-boot-samsung-j7xelte.img";
+		android-boot {
+			kernel {
+				u-boot-nodtb {};
+			};
+			vendor-dt {
+				dtbh {
+					dtb-0 {
+						u-boot-dtb { };
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi b/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi
index b88be5a502e..d0e0f64ae16 100644
--- a/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi
+++ b/arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi
@@ -2,7 +2,6 @@
 
 #include <config.h>
 
-#ifdef CONFIG_BINMAN
 / {
 	binman {
 		filename = "u-boot-oneplus-fajita.img";
@@ -24,4 +23,3 @@
 		};
 	};
 };
-#endif

-- 
2.54.0


