Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B257CD8C90
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC03884895;
	Mon,  8 Jun 2026 01:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gbc81EVL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC4D0846E6; Mon,  8 Jun 2026 01:37:23 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF68847C6
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8939B445B8;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CA33C4AF10;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780875435;
 bh=kPiUON3+R6fPbWHUKFTuhzqlL2P3Tnm5Bfn6/hFjyrw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Gbc81EVL+I+AGc7s7m1pKZVaV5xHAy6SMuqZhkojQr3UcO8tgzqBn4VgkV9ixNXka
 NvUuB0feNSMff07CBYXBnbxkkXDaJ0GiscsUnvlfRCDmObQZnHlbJ1uQCkUFYCdvCd
 kiDi9wwtiBBtbnt2eM58LnggYyOqlZdhkkJvUjuG1lls3CGTnOpA5OnH/xgAfP/4q8
 0aYVeEgynHwCB2xVObgHmKqATj6GgqsfBwc5WCVUWZasecJUdfdRbDxIk49xOMXpVt
 tSywNWLQDOHHd78FmICmogpbUgbS/DI6GsJe1aj0xCY5HrEbrA9ZSZBm6ueiYQwVVw
 9AnadZw8N/A9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 65A5ACD8C90;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 08 Jun 2026 09:37:16 +1000
Subject: [PATCH v2 7/8] arch: arm: exynos: add j7xelte binman config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-android-binman-v2-7-b8203682507f@samcday.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780875433; l=1131;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=HbJpz7IXyYdlJzHpnPAUHH/XrcxS7rCpGBd+VJ5Nt9Q=;
 b=iXoMS0lND+s6JzNAEuRK50YgTr/QpG3rYXOZj2S24ryg8izoqV1vQgSmluTIKTJwpGnvgOC0X
 481grGcS7/KBhnzX9IXrisDW1sx9xpGzC4WAecqiZVSRkqdzCiueqrX
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
 arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

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

-- 
2.54.0


