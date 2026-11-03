Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19D606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zMAlOh32;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJTeHbeX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44A2E4081C;
	Tue,  3 Nov 2026 13:05:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TFjvEnLYn3wo; Tue,  3 Nov 2026 13:05:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 25EEA40770
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711144;
	b=WaJl3PzP7K+Q7zgzXQdUKsi4jUJB5kwXv7UL6u5JfA3lqn8lQhJLj4qjt7xihN8zw3em
	 GIHSJspN5k9ZLGa4Lw36EjSS5gtsXh7VqhMpbtRu0mVXV0mGXdMUsd2LC2R5yYfrQC511
	 pTQLeIl9FbymjQ76GymQp3GpeaLmeubjdKlETv5fahUwLYwoCfHY2Ccbqn+ovoto4RDEE
	 4TUHTYOCCWG/k15aimzfY5TzCoRxLqxAkv6vysCh6TQ65ZFSn/5V4+2XWD5Sw53GQcIlv
	 Y6baxu6zIr8f2bjhRJioNmEFdOR4NWwxSGY+d4O4cBWXqb2b6KhGH3zbR/E6KWF/Qkw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711144;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=vOuaw9yboZAUSHcDZClby0NqyLN/kN8DUOrdF0ofJ0o=;
	b=e6+zEVoIGpwEoIGyOAWxyxOqNfwDpCpY4SZyabDM1FiK5Gf04IveX2as8u1+iJ0Ue/GX
	 qxunfaxOHi2HMEknw0i+xixUFNV36EwvOPQmzW2/7u5e1ItzYH6jMEgQvXBcWeZpLMaPt
	 srxdMaWGA+1x/TMBYEEe2zyQmuwSiip/NWYjcH6zIkyc3G5q7Tq1D8pw2cUTN84+lpwyE
	 e1zOPdUrbEDucU/2OSlvyQNo0Or7kyXgvliRzVT8s6wSqLzP1emOubyvUCokayG28Qx1f
	 tuJY1ALp+LGPNkeoixNpQPV8k8w4kZbGAURNKJIsQfWjNdx6vqRpLuIXZDLYEwwtnew==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711144;
	bh=vOuaw9yboZAUSHcDZClby0NqyLN/kN8DUOrdF0ofJ0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=zMAlOh32GYFVV2fQSiy0PYQMU/JphwOZxM/uaKsRj0mrHPZh7GGi0OgTcKu3e7wf0
	 m7D6X3qUYoxtiRcAyLBgUIMRh4NEwrhRwzS15YT8RrxptGnzee8/3mk/+zRmeIKJwx
	 oq+pcCakfDUE6K00PmbXTHsl082rdfEaw8M1hnGT9YFcwVd8QYpv4pk25mIpiRLiSl
	 BH0NNHrWB+xvfjtin/S+fQkuPI3NN3YC8GWXGbIPeFT39PevB/utXsXjrrVgsacEM7
	 Is9wxHBCzPK2Bv6Al7Krc1GUfgmgouiMYv3aKGDYpJ2TaFEoeZ652xacEUItdAxA0Y
	 Yg/BvWthGKt1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25EEA40770;
	Tue,  3 Nov 2026 13:05:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64B1A435
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 561D280C6A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id veQ0lnGh9j8A for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5018480C66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702232;
 b=O9bx8LHwXYTwL7LMyJu9s0+Bfe53iCBIAAD0qGrUArMqLnOV2ZsuY9DoPv84rXw9TT55
 719MHrlYemaEccFPpsftEqUTH/TJrj61QQTIS3J8qy1rNuSVCTxUtxWb3q/sfWt96YdLI
 ypslS078u1iYafyY47R64T3TnwPQzNSje59XzkuzYITFuVPYVrXd2uD/BadQJZyGRx/RK
 QNhr9HZ1pY9YhelRLuEyQYXSLtoxL1A5dqsNKIZty/Ve9gvjWUY1kQja2/eL6G3hzk7zx
 2waNIOJ7Rh2sLDQWj7+VUgKyUBrxFLtIQ/W5+rCXAkq1wO5XvZbk6+DI9/ZEFmMVoWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702232;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=vOuaw9yboZAUSHcDZClby0NqyLN/kN8DUOrdF0ofJ0o=;
 b=S2Gsy5t6HyYiI73xklFZdZsbId02xIUqVz7N1YzulqMcjL17huq2K5ziRl4NshaPPU8w
 IEOSI/NCrCsVc/boiKwMqCaO5R7iKxxLAnNi1/uWqarCrhH67G1AxyI/TuMHtzZ6X2Z9m
 hseiFOtCzIbShedFds07xx8HHtQLQQMhiXHmZkgvK4fG4jfH6Rpi7aITdapjwVAbf0BTT
 lsUo29joJrUDrpUiOz5OJXsPGfTxssH1wfCZCrYK0w8RKlXQ+91KkR/LGwc6n6DQbF1uF
 xK/JmWCUtaPqziIBqnEz25xOY7KDJ8xeAAJUnuy0MS2bOQIgksZ75aOHwrwvzJUzWaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IJTeHbeX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IJTeHbeX
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5018480C66
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97B85406F9;
 Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702231;
 b=GuQAlcdO/Lfl6b3bCJYOWZsFb8MfxT361uyDt5qQOlE8DkPtTt4Pz6Y1YoYMnCUttnAv
 uWJXN7E07whcn0NqbXZ/UEYjHxmYrq6sCXEWRUpreRukizMtDR+3/xDDFydpr/BeW+P7X
 u166Qg4HPt84fDuXwqNENwaU/jwMGhxUt9KNArLcYQQrH5fJmmc5IcQ3pmV/9WdmCZmCX
 dVIalI1ON+e6zWoA6hYiaXeBsAa7+z0YQV2OcpL5Td/kPy/zfdXjOOgg6SUMSyD5cj9Cb
 e2MCCqx6mF4eGeGN6XWQuhrKu57+WBvevcXI37qBUCSx8Gb0ooKOYy7PosckGqtKa6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702231;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=vOuaw9yboZAUSHcDZClby0NqyLN/kN8DUOrdF0ofJ0o=;
 b=t7lNURORDMuPl5lypOZ/b5VEmowe/Sxz18ustR2+tEu0HZI/3g8UEGRDUg8s9JY2VPiV
 3hiMCgy4+iG0g0+F4Y+D5rlPWXZAcpAh0cMN3eu+Hb9EtUsqZp61GeoDz2ISatSphq9Cv
 VTPh+gKwtv8ALJ+zWNJW7nfnM4qxCtHhnxCgHCN4sxsWe8Ib+dgl0gNNVfWHW23/ndLse
 h7UfMEXafmdH1hl128L6YZVDPvbRSnsbKnAVBv2NEHkESwt1iqJqQXRShu01EFATG1t2D
 xwrHfG5NY7Hj9x9YVHs++MLI2H1xw2m4h+uPv8ICDX2+y6iz4cC1/6ldSmL/9bdZjDA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 663611F00A15;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702231;
 bh=vOuaw9yboZAUSHcDZClby0NqyLN/kN8DUOrdF0ofJ0o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=IJTeHbeXaLOqXZCiRpGomKfOP55k1zCW4TkjMdAEaBhR8xgHSIVxExCuRsZnOSjaj
 CNKAuup8NjU5Tir5O19oV1sd0HUSPss47llj7QfOTuylywCaltAfrnVuOvTP6g76Ai
 9LKzS+UcirH2xUr/UwcQcQ9gRfhJmmGqrt5yn6VxjG0VGQJVJSNdV1zxXGAxEYJkEI
 lTxYduXMGcLQUm9CsMa/Qj8Lh/Uh9bDumkxWfF2OR6itL4oUyyoJz9Ochk1VQTDvmD
 /saFf99XG2Kj1L8JJOM/jlODoSYZ6wucQEMaJxKB6xp7Y27i1n6fmkG4S5ZUk/HNkn
 fGpH4HQJjwsNA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E21EE468D4;
 Tue,  3 Nov 2026 10:37:08 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Tue, 03 Nov 2026 18:37:08 +0800
Subject: [PATCH v3 3/6] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R28S
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nanopi-r28s-v3-3-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4996;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=rvqwtn67AjiPqkBuMNlbFDfk3sVDXvEvh3arACU1s+s=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwabVrGaTDYIFlffl/6Suaf+/f8zLjd9n7V03Eqed
 Xudqfe7jp0sDMJcDLJiiiyd0p8nfnl8YfrXm5OyYOawMoEMYeDiFICJGHoxcTJ+/XA4+/3F8Hy7
 Ai2ly6cKpnEmiJ+88TV2ValCy6WFi97H3KtSbGeNOz8j8BO/8Q1mD0Vn23POq3JS7U/lvPMzW2j
 g+x5oRuTJ1a2nb1l7O88LnnB98YuDMg7ZsS+Koha+dGecHeZqd2pPa8+ymjaZBeqpzXlLvuxLqN
 2UIrfiSsD2vZPt2R3vyDJPAQA=
X-Developer-Key: i=HystericalDragons@proton.me; a=openpgp;
 fpr=5A3AC293DCEEAA41A8A3266A910205A0AEB09D84
X-Endpoint-Received: by B4 Relay for HystericalDragons@proton.me/20261103
 with auth_id=1393
X-Original-From: =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: HystericalDragons@proton.me
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: 安容 <HystericalDragons@proton.me>

The NanoPi R28S is a dual gigabit Ethernet router board based on the
Rockchip RK3528 SoC, designed and developed by FriendlyElec. It shares
most of its design with the NanoPi Zero2, so it builds on the common
rk3528-nanopi.dtsi.

Specification:
- Rockchip RK3528
- 1GB RAM
- eMMC socket (optional)
- MicroSD slot
- 1x 1000Base-T (GMAC1, Realtek RTL8211F)
- 1x 1000Base-T (PCIe, Realtek RTL8111H)
- AICSemi AIC8800D80 SDIO WiFi + Bluetooth
- 3x LEDs (SYS, LAN, WAN)
- 1x USB 2.0 Type-C OTG, shared with the 5V power input
- User and MaskROM buttons
- Haoyu HYM8563 RTC
- 1x USB Type-C debug UART (onboard WCH CH340E)

The AIC8800D80 has no upstream driver yet, so only the SDIO and UART
controllers it hangs off are enabled, along with the WiFi and Bluetooth
wake and power pins taken from the schematics.

Assisted-by: LLM
Signed-off-by: 安容 <HystericalDragons@proton.me>
Link: https://patch.msgid.link/20260919-r28s-upstream-v7-3-e80a6f8ef521@proton.me
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: c1e23f3425c49fe22e9598f8eea2fcf693950d50 ]

(cherry picked from commit d0f6e37c635be183ff10d8a0291f54afd1365f30)
---
 .../src/arm64/rockchip/rk3528-nanopi-r28s.dts      | 160 +++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-nanopi-r28s.dts b/dts/upstream/src/arm64/rockchip/rk3528-nanopi-r28s.dts
new file mode 100644
index 00000000000..294b66f60e4
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3528-nanopi-r28s.dts
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2026 FriendlyElec Computer Tech. Co., Ltd.
+ * Copyright (c) 2026 安容 <HystericalDragons@proton.me>
+ */
+
+/dts-v1/;
+
+#include "rk3528-nanopi.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPi R28S";
+	compatible = "friendlyarm,nanopi-r28s", "rockchip,rk3528";
+
+	aliases {
+		mmc2 = &sdio0;
+		serial2 = &uart2;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio4_b2_usr_btn>;
+
+		button-user {
+			debounce-interval = <50>;
+			gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_LOW>;
+			label = "USER";
+			linux,code = <BTN_1>;
+			wakeup-source;
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_wf>;
+		post-power-on-delay-ms = <100>;
+		reset-gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&combphy {
+	status = "okay";
+};
+
+&led1 {
+	default-state = "off";
+	function = LED_FUNCTION_WAN;
+	linux,default-trigger = "netdev";
+};
+
+&leds {
+	pinctrl-names = "default";
+	pinctrl-0 = <&led_sys_pin>, <&led1_pin>, <&led2_pin>;
+
+	led-2 {
+		color = <LED_COLOR_ID_GREEN>;
+		default-state = "off";
+		function = LED_FUNCTION_LAN;
+		gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>;
+		linux,default-trigger = "netdev";
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_eth_perstb>;
+	reset-gpios = <&gpio4 RK_PC0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3>;
+	status = "okay";
+};
+
+&pinctrl {
+	bluetooth {
+		bt_wake_host: bt-wake-host {
+			rockchip,pins = <1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		host_wake_bt: host-wake-bt {
+			rockchip,pins = <1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	gpio-keys {
+		gpio4_b2_usr_btn: gpio4-b2-usr-btn {
+			rockchip,pins = <4 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	leds {
+		led2_pin: led2-pin {
+			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie {
+		pcie_eth_perstb: pcie-eth-perstb {
+			rockchip,pins = <4 RK_PC0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	wifi {
+		host_wake_wl: host-wake-wl {
+			rockchip,pins = <1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pwr_wf: pwr-wf {
+			rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wl_wake_host: wl-wake-host {
+			rockchip,pins = <1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&uart2 {
+	dma-names = "tx", "rx";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2m1_xfer>, <&uart2m1_ctsn>, <&uart2m1_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	/*
+	 * The Type-C port is also the 5V power input, so it comes up as a
+	 * device, but host mode works with an externally powered hub.
+	 */
+	extcon = <&usb2phy>;
+	maximum-speed = "high-speed";
+	phys = <&usb2phy_otg>;
+	phy-names = "usb2-phy";
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb2phy_otg {
+	status = "okay";
+};

-- 
2.56.0


