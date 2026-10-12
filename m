Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE61CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 15:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 24E3C6066D;
	Mon, 12 Oct 2026 15:01:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DwEjsynEsf45; Mon, 12 Oct 2026 15:01:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6658360628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791817279;
	b=pOLmspy1fEG4+aSftYWCy3DCgdYQxngiZP/D+fub/gsQyaYuTM/ji9/ldLvs6UvQkdCT
	 RcVn7xHFYbErTmg+W8k0n+wXuickmmbY0uFbZ2Xuk0T1KGEBXWPZwR1s2PergUNNQP6v8
	 tYpzsrI6yGsaSqEd3WlarBVYKn8FRpNFSrSN+PiAU8YYaunpZtFRdEtTeomzCPuTbPyao
	 MJJWLo3Ozelp58+7DIX5f10BABLuS4PDFboZxNj2n/GL8StP/SfT4Ms+eXP+jMoTKunn/
	 9RT6/3Op5oGpYOlYA8CMhXxbqZ5S9RzWPTyX9cf79uW9s2wqck8StuW753HRy+ZHvvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791817279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=CBduEd+dwnX7/VCREZkyfoS33GsDnZn1WdClBfbemCs=;
	b=PAUyDUgGFh2boq8XiXfW6lavAhhUzkj/PGxwHqPvRR3b6gGlO6MFciqVVyct+4AZZT3a
	 BgCgraR3ZDJbHwwHlIeYfyYO5WCXsdaZRTvP/mzGz8kRTt26c7aw0qehG55FeLPJeu9/Y
	 abSvCWZG6ZMeZojd/zfcO4MFwTraXUlLS5tS9gnzXU9RKKuQUVxKCAUI1ySg88W1tf0qp
	 XqkJ+rsMNUVVLPt6YTzKg2ZDEFi04guLZizAAkC7FmT9u0vmsaDFxTGAs1PGgq8foX934
	 Vif2NIGy5X5gHCQZ8DdY0iC0G4XGVKwgfTRHfBi2/KBKd1MT3CMI5E9FlJn1t6I+0wQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791817279;
	bh=CBduEd+dwnX7/VCREZkyfoS33GsDnZn1WdClBfbemCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sKuc6EpKPY3BLytfVpdY1JKT7cVYL6qyTDfpSPWTXnbBjYbHXLaMBpWDT+hFsY2X8
	 cw6LB/IREQkXYe+iMgjrXF6YIuHBiyFm9wuEF+wSmOdpfFAHB2N5xt0dpDJzEAIjYw
	 liJUdlwNkQyESo5FibLFvBiHZ3pKef9+XuwdpyLOt5PvOcijoCMLgVLSaU5kvJ4Xrl
	 MGI4wnM8w1dK6gEcCrajJ9d0Nc4htinn7q57WVVHTGUdQ1frnWWxoYo9NExOgcdFeL
	 8cIiXRppXkryT8e1uiffFKa/yJzRUMIq88qhCNVu16Df+8bOqs82Pcpgszel4v6QP9
	 lteX0E6gr+oqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6658360628;
	Mon, 12 Oct 2026 15:01:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5799B105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D73B40558
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbI2n_NeIBou for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:22:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EF5640522
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791811340;
 b=nOdX8bYJw+qXA83ybYJnF+184S/S0kn1oWOJ2WWhNaV+8EYa1o5/rElN5vzUmPhDVlsQ
 TAZnMXLvHqjfv0+NVg2nIlnTNkWJTRLf0hqm6zlDKcJ3N9WGcCjfieKNJvsQ1n8vFjhjD
 Rim4jx1mnYsmOk4eqvCW/z9wUeUS+hmfZOjLXTMgBEJd2YXOuutbVEsDAPYhg5NIFjnLN
 4K4v/71x3NsqIqZejwWcRrDUbA+QymBG4nl54uX4GCoMsTnLMva7CS6qGl02IRXpdh8fV
 xWeDs7E0njlFvaKMghtlyzMulNGALt8tWTraD00fUYS54Ht0KCZSwmCeQEx6FMx85sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791811340;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=CBduEd+dwnX7/VCREZkyfoS33GsDnZn1WdClBfbemCs=;
 b=nB9/TuRJ7hFjK8yODfdIzM2DybZb4RhHt0UBUJGtVuhaGmwtpKEEIMgLTLIZDStpKzCs
 7VYCQQnExStGlimvx8XBu2/5FeHveVgc18glIkUK2m7vmq1ZlrWi+LSQlfa94C5s4OQmZ
 Dek5P1HEABB2kh21j/v5/BLAS2sReNBavNhWINVxWFAQVKbnMX66phgcS2azUdVifaLYs
 64GQ43Sh9bleQV3opmAZywfRWKvNPbkP/4a312zEXkrPp+imnT5ROSZWWm+PMg/Q3ovoQ
 5tz2vsakn4CuUMiHF1OJHTaN3AY59whAP+RG7KxuKXbljwdF9UgDP8fgfauj+E/QY6A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O9yu80j6; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O9yu80j6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EF5640522
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A62E43607;
 Mon, 12 Oct 2026 13:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0D7EC2BCFA;
 Mon, 12 Oct 2026 13:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791811339;
 bh=r5kZWMxPwBXGiHhqmPEMflSK9IDirel6UlqoE3wAHm8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=O9yu80j6k8jKBNO76D6Ys0SkwciES5I6pht5ITjb+IfmTEFldQ8+G+sWEvfYjLXvk
 KGQWCkuO+kEP3nl5VC98AUi1dW7V4R3+fY+TbXpbE/mD0eayxNT/0c3P6mfzQYKV6A
 cvnq5viUTgnN3SkZ8xsxdBuD1Q9NvAZLfpsESujkOf3zuAMXJ4TXdV3bwDgJJMyyCF
 sg57Ag9RUyTXJIKxd94snkZLAam0ZO/3gNW3lFsLtnygm/zW5XJXmXxsIGpSNAydbT
 zIPavuK5NhfZSx4f2qxDqIvEGGLRTC7OJAhI2oULwqYAP16ciEq6C3Cr2YQW2xde9G
 ap92mqgiMCJCA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D01D2CA9ED1;
 Mon, 12 Oct 2026 13:22:18 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Mon, 12 Oct 2026 21:22:16 +0800
Subject: [PATCH v2 1/3] rockchip: rk3528: Split out common NanoPi u-boot.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-nanopi-r28s-v2-1-3d162759dd3d@proton.me>
References: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
In-Reply-To: <20261012-nanopi-r28s-v2-0-3d162759dd3d@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152;
 i=HystericalDragons@proton.me; h=from:subject:message-id;
 bh=OPgz28j3KtTUGlUgWj5O/HjkThPqN+JWbYP1nYWKvr4=;
 b=owGbwMvMwCUmepz3XUtTHjvjabUkhqwz9zmXPdvoH8S7J/vM1YlbOzg7Iv+qdBqFlhf+9EgQr
 eR6fuljRykLgxgXg6yYIovspupIoVXRM4tYpI7DzGFlAhnCwMUpABOpnMDI0C86WXLK7iu6yfHf
 XN6skJj5I/HwpIWRNr8i+O4paux1r2P4p3To/NuHCzd+9rGWjLus9MS1Zd3j9FmHW5aELP11NP3
 ycn4A
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=1DB27B5912AA5B9972041AC715C70DEE84826E07
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/default
 with auth_id=1004
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
X-Mailman-Approved-At: Mon, 12 Oct 2026 15:01:18 +0000
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
Reply-To: HystericalDragons@proton.me
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: 安容 <HystericalDragons@proton.me>

The Linux devicetree of the NanoPi Zero2 has been split into a common
rk3528-nanopi.dtsi, which the NanoPi R28S builds on. Both boards use
the same PWM regulators for vdd_arm and vdd_logic.

Move the U-Boot specific parts of the NanoPi Zero2 into a common
rk3528-nanopi-u-boot.dtsi in the same way, so that the NanoPi R28S can
include it instead of duplicating it. No functional change.

Signed-off-by: 安容 <HystericalDragons@proton.me>
---
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi       | 11 +++++++++++
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 10 +---------
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  1 +
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
new file mode 100644
index 00000000000..3e2fbd81da1
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
index 3e2fbd81da1..151f1872fed 100644
--- a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
@@ -1,11 +1,3 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 
-#include "rk3528-u-boot.dtsi"
-
-&vdd_arm {
-	regulator-init-microvolt = <953000>;
-};
-
-&vdd_logic {
-	regulator-init-microvolt = <900000>;
-};
+#include "rk3528-nanopi-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index 95543b40dd3..d1810fb0528 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -13,6 +13,7 @@ F:	configs/hinlink-h28k-rk3528_defconfig
 NANOPI-ZERO2-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
+F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
 F:	arch/arm/dts/rk3528-nanopi-zero2*
 F:	configs/nanopi-zero2-rk3528_defconfig
 

-- 
2.56.0


