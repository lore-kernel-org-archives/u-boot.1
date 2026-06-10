Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D62CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:28:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E14849BD;
	Wed, 10 Jun 2026 03:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EUNVT2rN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDDD848B0; Wed, 10 Jun 2026 03:27:47 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07B5849AC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 01C4440717;
 Wed, 10 Jun 2026 01:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2E27C2BCC7;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=gIJad4rFnGim+JhKtOGPpIt47KZkzVfhmXGnHSV7lRs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=EUNVT2rNN9UIQ/8hcx15t47h+umAF2gC2vqg0qLbn+ILeRWvpVubeZotBCpU1Iy7S
 te5CWiuOvdM8DrDJWm6k/0CnQ/2pj5jfC4zps7un9ox9mw8VPpjoNrcayGuYZoY+5h
 3Qqv0Ax/YidaiaSN64BlRscFLlD50cWhCMWWnZbxdEtXHDxEOr18tW7zxwfJ6J0sA0
 2Y0VWXmG2gC6ZKSN516w/R7KEwyaJcXB6AFIuCaqj9+iJNms6OhKcNBYGRjZ5egrpE
 rnG8Bazl63CVlK+tiyR1FUOp7Gczw1lZqeA64BCk1Y6/WD6apdm+6DmPgyFI70gCKf
 /Df79vAh4wkpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CC760CD8CA8;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:47 +1000
Subject: [PATCH v3 09/10] arch: arm: exynos: add j7xelte binman config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-9-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
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
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=1129;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=6N86e0nsPC791hYMDJuBq6vEcAt8DN6e0mfDXT4z8F0=;
 b=2qfRC2Sz84ILQ3AjBRog3eCXyVRF/2+ANcmE3Z03ekQTG3i4GjEc8Pj4P8bLi9H7MclrvH0Az
 BaBhcP9ooDkBHBRv2cGN8Cc83ZnaU2w0TDt0JLLMmRIlqJpIiNCexTm
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

Link: https://lore.kernel.org/all/177209522223.26390.6219893536178441080.b4-ty@kernel.org/
Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
new file mode 100644
index 00000000000..0cd4c12a2e4
--- /dev/null
+++ b/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	binman {
+		filename = "u-boot-samsung-j7xelte.img";
+
+		android-boot {
+			/* S-BOOT ignores offsets, so they are not provided here */
+			kernel {
+				u-boot-nodtb { };
+			};
+
+			vendor-dt {
+				dtbh {
+					dtb-0 {
+						model_info-chip = <7870>;
+						model_info-hw_rev = <0>;
+						model_info-hw_rev_end = <255>;
+
+						u-boot-dtb { };
+					};
+				};
+			};
+		};
+	};
+};

-- 
2.54.0


