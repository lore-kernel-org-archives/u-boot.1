Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E9FCCF9F8
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 01:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB4082A9E;
	Tue,  4 Nov 2025 02:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="FZaiDsbg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SwdyaD/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94CA48144A; Tue,  4 Nov 2025 02:52:20 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264C1836D1
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 02:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d0s013L4qz9tNM;
 Tue,  4 Nov 2025 02:52:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762221137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T7P+co7ZDgcYtWAYbUFc7RnsI7OZb9xdsIk8oSv57Xk=;
 b=FZaiDsbgo6pYmQKs9SRmkmlyEYa7+RYh1KPbNeOrjPpM7ZkUPeuzZarVAxKYFaFigIxVlu
 yk+SaGswkhwRnWZhNC2wLmleqXrdSPYgQGIMLSB65Qegk1rYX+3rELekGJ/NXNT5BMjCyN
 Eq85uYdu6dCbrTyu4BzfwHIUrEmcC8A5pQ/NkIPq/YUt+9khYhbd4ZNBSrUIx0b0ODK7lt
 AdEe7ThvfcFc6JnA5tLp0AENBcA7HOyVeG4J8+AcopYV4D4PfIyy4TaIKIVf2YT+NV1Kgk
 XF+m+TN9ckeGvf/LI59XPqba4sL2ziyiN++9MBfniue5qNXyw4/42dF+IV6xVw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="SwdyaD/v";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762221135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T7P+co7ZDgcYtWAYbUFc7RnsI7OZb9xdsIk8oSv57Xk=;
 b=SwdyaD/vbeLv9a/cIhLMbh4cpOiVDEb/MSRHSPKdnmSS47hw7kvW2yGaslr1Sqrc8WxrCZ
 P7gebbfk92eV7oyV3C/WpJzuhS43ElztOCEwcas/uOqL2Rw1emABU2OwNiLl2oz16QBPZZ
 jV1Vda7o3YmV0IVOPsiu4a3cu8SuqsfTjxRHZAVBNq70IwZHrvURtKSJNsLhyTvMBsFgFS
 5dL1LLrKBGNIAGd/W3FgnP0Dp0CXNL66HG2nXqbT/R68q0iTZPa8h7UZNlpo4ARvvNLeAD
 /eBEC2J4EJQlDaRLskg5DXc1bZwftfAtbbCYFxsJHb+pfmvaIEQn87MP+imDcw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] arm64: dts: imx8mp: Add missing LED enumerators for DH
 electronics i.MX8M Plus DHCOM on PDK2
Date: Tue,  4 Nov 2025 02:52:03 +0100
Message-ID: <20251104015212.220542-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: maq6t7ah8t7szai5d3auq7bbnhb8wdtg
X-MBO-RS-ID: eef29655a7c22af0dac
X-Rspamd-Queue-Id: 4d0s013L4qz9tNM
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The LED enumerators are missing, which prevents the LEDs from being
accurately told apart by label. Fill in the enumerators the same way
they are already present on PDK3. Put this into local DT extras until
matching kernel patch lands in Linux.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
Linux counterpart: https://lore.kernel.org/linux-arm-kernel/20251104015031.219863-1-marek.vasut@mailbox.org/
---
 arch/arm/dts/imx8mp-dhcom-pdk2-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/dts/imx8mp-dhcom-pdk2-u-boot.dtsi b/arch/arm/dts/imx8mp-dhcom-pdk2-u-boot.dtsi
index be2d4fb184a..b8b3abd0f03 100644
--- a/arch/arm/dts/imx8mp-dhcom-pdk2-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-dhcom-pdk2-u-boot.dtsi
@@ -4,3 +4,23 @@
  */
 
 #include "imx8mp-dhcom-u-boot.dtsi"
+
+/ {
+	led {
+		led-0 {
+			function-enumerator = <0>;
+		};
+
+		led-1 {
+			function-enumerator = <1>;
+		};
+
+		led-2 {
+			function-enumerator = <2>;
+		};
+
+		led-3 {
+			function-enumerator = <3>;
+		};
+	};
+};
-- 
2.51.0

