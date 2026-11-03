Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20663606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s0TisgaJ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NG3R683Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F14994079A;
	Tue,  3 Nov 2026 13:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klZK4WsW-ok6; Tue,  3 Nov 2026 13:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB43E40762
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711155;
	b=CEGvDrYJ6sGxgbB+9gVzvOtCpUNGMDr2MQWl4d46shIRZkS5+pX1E6okICTJnYNc/vnW
	 iAePjVHzy6uI001/ASkFmcbbLYKp4BZvow9QHz94NZ9ieNW2725eo8wOjJTkUm6JfgV5Y
	 ynmhVsMKCKbl/OPGshIMv9Ln3lZFH1ga++CSpNJEAzPXYipVKcaxujv84/mgXTFbsOB+8
	 fluYgoQrDGDy93ekGYpnWPF46VOTGQlWt5XWQS3P5gL01BcLAnpfg6YAnEdwmoEOG1K/L
	 b4L3lUFvifdGwBB4Ys6TZJiZZUtrfiRcmlokDOWssTMTb9stHFusbKrgWTAXkcEwfWA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711155;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=ACQQ9H+ChV9WMPExpfRjFI+qFjXlPAYUxm1Q8Ehhiq0=;
	b=qy346huXgqjP1OI1QPyoHF/H0oyXaCm1V2xEzpPDM1I4qT1i79SY+P1EhngP0K5irRfC
	 WTnmaudDACihxzk/cJbhHjh1pK5KnGToPhQyh+kgx1uNHnIEE5rPHjJtMB6smSifMqX0j
	 qU3FHukxbtLQA412feYnAnBR4/YAHXG6FIj8HhCHFjBlidZ9O/GUhkMOe6QCeVaqqdsm9
	 kA/cem9TOs29FydfpHO1R0CkoRxqG7NCgpV4viJNhydiFxjuqXNH0yLmX4uQb3afavtqW
	 GBVYlwSayqKGF32tfnSiKi9IcTzj/0YqXYoOZKBIpMJMQRH74ommAfmNbxxhjoGktoQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711155;
	bh=ACQQ9H+ChV9WMPExpfRjFI+qFjXlPAYUxm1Q8Ehhiq0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=s0TisgaJv8+pdLp5u9mwEd7/xJgJnAo5SH6iMozIGbkzZkvNche3+/nd0k/n7e0YY
	 aO8LvgghtfbvLwQTDUDrs9eyBI65sAjTL6fTac3W8w97BwQRttmiYr0PvrwsTtBm94
	 41DKsS8yMCe+NRKZwJGfBG5SBNtW1Rk72S1fw9DLhgnRZqWAa9T09IP7wBwQV32U7s
	 lx/1rVlfwmPLcm+m0s0ArMCvfidVb810bd3lTZ+jROXcgqINvA6EUfaS6U0GlOuYpP
	 c7ahezu9tVGWExQLv+ruDQ2Ema4TVQH008BEY3iZIUVTnlGviWMj/rNj/L9X1iwdC5
	 TDDNfeQMP1PYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB43E40762;
	Tue,  3 Nov 2026 13:05:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8879A15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA28180C66
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7vAVWs1zJh32 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D5D280C6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702234;
 b=UCos1DFCAnhoGG4hIIzQ8nPxK+YNAi7oHamXUoJ44HjUzVLTcHoF29xNSIAT1yo6jAaX
 YuFPx61KZ0JtYO4eYbeTrlFJLI5Hfy/DAAsl4QYFx9PiQriDu9rVbo5sZ29uwUrc7ljUM
 wlRLgWvaTiuHE+g+wk+JKSIzcKJlaq0YKviMXKCpXSMzlj6WY/Yx4P3ubWcNhI4xXgiDV
 cqaGIU78Bg2N1zMVhrXCMYipxcdUrlNprTIs7Z2kRul/9TMFrkcEpBakJvWYgXrx9DhtN
 PIttJFbY3UHEpW0zL/M6Vr3VcOUnVnC6UE+4r8yqVtUJ7EXc0MJg2e9UcB7k1oqKpdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702234;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=ACQQ9H+ChV9WMPExpfRjFI+qFjXlPAYUxm1Q8Ehhiq0=;
 b=sp/j+PFdGo6u+ZCweE6+SSjFJ7T9Do3tgzdriBwHSGUU7iDfm4AWeLODq+HU3QHN3AJa
 QQvMEcN+5IYX/iU7/Kr9OFg63UvnY4ZXGe2dqhA1ilFMx7VQkx7FvcETeZ596QZU2uNiV
 yeXEOUIgRaGQTt9LD47tiU1Bff8cYmTDCsGJ6C/yTObNci6CT97GEFGn9BpQ1lLCiZCOA
 70RmdyT9IDloi41OVkvyqdZ4fWV+Y/6IiYAV/kBazTG5C119rrw8QUSZGmp83X8gqrtiS
 Jb837YX18sw0Zczb/LVE5QgsGh3QbpWccVWMSEfeMDId4ixFJdCoCyBZlee6sX1SLrg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=NG3R683Q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=NG3R683Q
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D5D280C6A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58D42602C2;
 Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702231;
 b=kXmoX+yRqcg2vos+p+nNOwf0Oc0H3zOoPdYGIdZizEnlEoBwOE3rtgS1MsOt5dTm55q0
 tMQtelf6QeXWCfhrghOSY9PJyqh+OI7MikR2MzJmGgQ0N4Q37yMGJ+I4UxnARWLlDQb+c
 QhYC2RMb9hJ0DfIS5wTnbIVXFkdctVSlhSsRT2nNbKTzUYxACFyoC0wTgbRaNDrnvlOI0
 sC7YuUMHJCgCPZ7ZzGwKlpK0xSS69RGX1bUIo0+8x45TP4lyLQqieXxM5k1JMMgXCnPrv
 t2kBYCHabNrMx840ebiR6/u8Do45wr3JetFaywGYxRBgKxeMcA4m8/nErOxybpftyfA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702231;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=ACQQ9H+ChV9WMPExpfRjFI+qFjXlPAYUxm1Q8Ehhiq0=;
 b=E0ofXV2YwTfTGnjuXLThxVC6tZOsGebYo7mJK3ZASnYjdfAJ5qocY1Ntd3s80109qKa9
 tDEwHeuMrQ/eLqcveiivB2aJGfe8Al4UflhJitAJ32GtilpGyyh/ysWhqvcGGyMFtdUxu
 T6+WwVbdw1VYV4Qj5Kd4RIEyu3VLjShdEhebsnnUQ6zTXhn/dKvAalHFmkfDPSt7qfDwt
 w2VLNZc7s9iyCwXjm80bacfmFbsTiMGrx6faPY4dTyOc46VveZb/JSKO2cV7rMG1keZbm
 CfhVDg6c+LEzkZMlKVYvDxEdeBdPiKQymLMYCT7GvWBp5YStFhEBAjeQ4iYSum5UiPA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 65FD91F0093A;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702231;
 bh=ACQQ9H+ChV9WMPExpfRjFI+qFjXlPAYUxm1Q8Ehhiq0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=NG3R683Qom6PmzTnhp71cHf9yg1WO6xwdASkY7GYQLpbYEts0I3ExHBLNfz7tv3VE
 HhTwXp8IXXQIG0HPtZKR0FwTHDcNJ6c4RNNENwThRIa7Bme+WlY6fNJk42ytWACpcG
 6aPzSCR65yeVKcSXAw4dsbOwJImtEgEz8v0FosT3vFxfeAgQJ2Q0ZkJR5ZOFZXLE1H
 dpGdNkrR3bq6cXX330lqLfSM58aP+pOAT4T8EstwUEsQMFucP9qoRsLCWcyyxanrSY
 YoEgsJ37jvRtfkTbeVXP8yv861TxbPZ1TnQ7AVBJTdAVRpRoBPQDbpnVW0eaSCEG8Q
 fyzDr0qIypeAQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D6900468D0;
 Tue,  3 Nov 2026 10:37:08 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Tue, 03 Nov 2026 18:37:07 +0800
Subject: [PATCH v3 2/6] arm64: dts: rockchip: Split out the common NanoPi
 RK3528 parts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nanopi-r28s-v3-2-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Chukun Pan <amadeus@jmu.edu.cn>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16001;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=bWGo+pll+6s3eusplW11fnYgfXnVGyG3Jfk6ZSU0Jmg=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwZ/i9+3ymX52klZieL2Buol37K3Ngqyfw+Njtr6m
 M/N/uGdjp0sDMJcDLJiiiyd0p8nfnl8YfrXm5OyYOawMoEMYeDiFICJ/J/AxMm4U/BXzk27FUUS
 nveqJv1IunvBXedCXWujzeJVVib/pE8eVGBQuDJRrcmrgStyx/mTFT6lE8N1XEOXZl9svdkzocP
 l0i6gGSe0316/OOnqprDz8yp73N4bGtVZHdgu3Hv/0uEyn11Bd7zk9Y6/OCkT41hpeZJbbeo12z
 f3Y9Y9mdBx6p7KfblP4UtV4gA=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: 安容 <HystericalDragons@proton.me>

The FriendlyElec NanoPi Zero2 and the NanoPi R28S share their power
tree, storage, RGMII Ethernet, RTC, LEDs and debug console. Move those
parts into rk3528-nanopi.dtsi so the NanoPi R28S can reuse them, and
leave only the board specific nodes in the NanoPi Zero2 devicetree.

Both boards drive a green LED from GPIO4_PB1, but give it a different
purpose, so the common file describes the LED itself and each board
adds the function, trigger and default state. While moving the LED pins
give them the usual _pin suffix, which frees the led1 label for the LED
node.

Suggested-by: Chukun Pan <amadeus@jmu.edu.cn>
Signed-off-by: 安容 <HystericalDragons@proton.me>
Link: https://patch.msgid.link/20260919-r28s-upstream-v7-2-e80a6f8ef521@proton.me
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: fdb087806e808ccc4963e2e5225fe16581ecb421 ]

(cherry picked from commit f7f1ea96945deee8bbadfd0737706ce770315342)
---
 .../src/arm64/rockchip/rk3528-nanopi-zero2.dts     | 290 +-------------------
 dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi | 291 +++++++++++++++++++++
 2 files changed, 296 insertions(+), 285 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts b/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts
index 97d85124d21..05ae03622e8 100644
--- a/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3528-nanopi-zero2.dts
@@ -2,41 +2,12 @@
 
 /dts-v1/;
 
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/pwm/pwm.h>
-#include "rk3528.dtsi"
+#include "rk3528-nanopi.dtsi"
 
 / {
 	model = "FriendlyElec NanoPi Zero2";
 	compatible = "friendlyarm,nanopi-zero2", "rockchip,rk3528";
 
-	aliases {
-		ethernet0 = &gmac1;
-		i2c1 = &i2c1;
-		mmc0 = &sdhci;
-		mmc1 = &sdmmc;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:1500000n8";
-	};
-
-	adc-keys-0 {
-		compatible = "adc-keys";
-		io-channels = <&saradc 0>;
-		io-channel-names = "buttons";
-		keyup-threshold-microvolt = <1800000>;
-		poll-interval = <100>;
-
-		button-maskrom {
-			label = "MASK";
-			linux,code = <KEY_SETUP>;
-			press-threshold-microvolt = <0>;
-		};
-	};
-
 	adc-keys-1 {
 		compatible = "adc-keys";
 		io-channels = <&saradc 1>;
@@ -51,28 +22,6 @@
 		};
 	};
 
-	leds {
-		compatible = "gpio-leds";
-		pinctrl-names = "default";
-		pinctrl-0 = <&led1>, <&led_sys>;
-
-		led-0 {
-			color = <LED_COLOR_ID_RED>;
-			default-state = "on";
-			function = LED_FUNCTION_HEARTBEAT;
-			gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "heartbeat";
-		};
-
-		led-1 {
-			color = <LED_COLOR_ID_GREEN>;
-			default-state = "on";
-			function = LED_FUNCTION_STATUS;
-			gpios = <&gpio4 RK_PB1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-on";
-		};
-	};
-
 	vcc0v6_ddr: regulator-0v6-vcc-ddr {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc0v6_ddr";
@@ -83,66 +32,6 @@
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vdd_0v9: regulator-0v9-vdd {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd_0v9";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <900000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc_ddr: regulator-1v1-vcc-ddr {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_ddr";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1100000>;
-		regulator-max-microvolt = <1100000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc_1v8: regulator-1v8-vcc {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_1v8";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		vin-supply = <&vcc_3v3>;
-	};
-
-	vcc_3v3: regulator-3v3-vcc {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc_3v3";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc3v3_sd: regulator-3v3-vcc-sd {
-		compatible = "regulator-fixed";
-		gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwren_l>;
-		regulator-name = "vcc3v3_sd";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_3v3>;
-	};
-
-	vcc5v0_sys: regulator-5v0-vcc-sys {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
 	usb2_host_5v: regulator-5v0-usb2-host {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -154,138 +43,15 @@
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
-
-	vccio_sd: regulator-vccio-sd {
-		compatible = "regulator-gpio";
-		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
-		regulator-name = "vccio_sd";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-		states = <1800000 0x0>, <3300000 0x1>;
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vdd_arm: regulator-vdd-arm {
-		compatible = "pwm-regulator";
-		pwms = <&pwm1 0 5000 PWM_POLARITY_INVERTED>;
-		pwm-supply = <&vcc5v0_sys>;
-		regulator-name = "vdd_arm";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <746000>;
-		regulator-max-microvolt = <1201000>;
-		regulator-settling-time-up-us = <250>;
-	};
-
-	vdd_logic: regulator-vdd-logic {
-		compatible = "pwm-regulator";
-		pwms = <&pwm2 0 5000 PWM_POLARITY_INVERTED>;
-		pwm-supply = <&vcc5v0_sys>;
-		regulator-name = "vdd_logic";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <705000>;
-		regulator-max-microvolt = <1006000>;
-		regulator-settling-time-up-us = <250>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu1 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu2 {
-	cpu-supply = <&vdd_arm>;
-};
-
-&cpu3 {
-	cpu-supply = <&vdd_arm>;
 };
 
-&gmac1 {
-	clock_in_out = "output";
-	phy-handle = <&rgmii_phy>;
-	phy-mode = "rgmii-id";
-	phy-supply = <&vcc_3v3>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
-		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>;
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&vdd_logic>;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1m0_xfer>;
-	status = "okay";
-
-	hym8563: rtc@51 {
-		compatible = "haoyu,hym8563";
-		reg = <0x51>;
-		#clock-cells = <0>;
-		interrupt-parent = <&gpio4>;
-		interrupts = <RK_PC1 IRQ_TYPE_LEVEL_LOW>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&rtc_int_l>;
-		wakeup-source;
-	};
-};
-
-&mdio1 {
-	rgmii_phy: ethernet-phy@1 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0x1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac1_rstn_l>;
-		reset-assert-us = <20000>;
-		reset-deassert-us = <100000>;
-		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
-	};
+&led1 {
+	default-state = "on";
+	function = LED_FUNCTION_STATUS;
+	linux,default-trigger = "default-on";
 };
 
 &pinctrl {
-	ethernet {
-		gmac1_rstn_l: gmac1-rstn-l {
-			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	leds {
-		led1: led1 {
-			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		led_sys: led-sys {
-			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
-	rtc {
-		rtc_int_l: rtc-int-l {
-			rockchip,pins = <4 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-	};
-
-	sdmmc {
-		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
-		sdmmc_pwren_l: sdmmc-pwren-l {
-			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	usb {
 		usb20_host1_pwren: usb20-host1-pwren {
 			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -293,52 +59,6 @@
 	};
 };
 
-&pwm1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm1m0_pins>;
-	status = "okay";
-};
-
-&pwm2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pwm2m0_pins>;
-	status = "okay";
-};
-
-&saradc {
-	vref-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sdhci {
-	bus-width = <8>;
-	cap-mmc-highspeed;
-	mmc-hs200-1_8v;
-	no-sd;
-	no-sdio;
-	non-removable;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vcc_1v8>;
-	status = "okay";
-};
-
-&sdmmc {
-	bus-width = <4>;
-	cap-mmc-highspeed;
-	cap-sd-highspeed;
-	disable-wp;
-	sd-uhs-sdr104;
-	vmmc-supply = <&vcc3v3_sd>;
-	vqmmc-supply = <&vccio_sd>;
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0m0_xfer>;
-	status = "okay";
-};
-
 &usb_host0_ehci {
 	status = "okay";
 };
diff --git a/dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi b/dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi
new file mode 100644
index 00000000000..4b3f26dab6c
--- /dev/null
+++ b/dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "rk3528.dtsi"
+
+/ {
+	aliases {
+		ethernet0 = &gmac1;
+		i2c1 = &i2c1;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	adc-keys-0 {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		button-maskrom {
+			label = "MASK";
+			linux,code = <KEY_SETUP>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_sys_pin>, <&led1_pin>;
+
+		led-0 {
+			color = <LED_COLOR_ID_RED>;
+			default-state = "on";
+			function = LED_FUNCTION_HEARTBEAT;
+			gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		/* The purpose of the second LED differs per board. */
+		led1: led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio4 RK_PB1 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	vdd_0v9: regulator-0v9-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_ddr: regulator-1v1-vcc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_ddr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v8: regulator-1v8-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc_3v3: regulator-3v3-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc3v3_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpios = <&gpio4 RK_PA1 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_pwren_l>;
+		regulator-name = "vcc3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_3v3>;
+	};
+
+	vcc5v0_sys: regulator-5v0-vcc-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vccio_sd: regulator-vccio-sd {
+		compatible = "regulator-gpio";
+		gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_vol_ctrl_h>;
+		regulator-name = "vccio_sd";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x0>, <3300000 0x1>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_arm: regulator-vdd-arm {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 5000 PWM_POLARITY_INVERTED>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_arm";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <746000>;
+		regulator-max-microvolt = <1201000>;
+		regulator-settling-time-up-us = <250>;
+	};
+
+	vdd_logic: regulator-vdd-logic {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 5000 PWM_POLARITY_INVERTED>;
+		pwm-supply = <&vcc5v0_sys>;
+		regulator-name = "vdd_logic";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <705000>;
+		regulator-max-microvolt = <1006000>;
+		regulator-settling-time-up-us = <250>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_arm>;
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii-id";
+	phy-supply = <&vcc_3v3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
+		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&vdd_logic>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m0_xfer>;
+	status = "okay";
+
+	hym8563: rtc@51 {
+		compatible = "haoyu,hym8563";
+		reg = <0x51>;
+		#clock-cells = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PC1 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_int_l>;
+		wakeup-source;
+	};
+};
+
+&mdio1 {
+	rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac1_rstn_l>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pinctrl {
+	ethernet {
+		gmac1_rstn_l: gmac1-rstn-l {
+			rockchip,pins = <4 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led_sys_pin: led-sys-pin {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		led1_pin: led1-pin {
+			rockchip,pins = <4 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rtc {
+		rtc_int_l: rtc-int-l {
+			rockchip,pins = <4 RK_PC1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	sdmmc {
+		sdmmc_pwren_l: sdmmc-pwren-l {
+			rockchip,pins = <4 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		sdmmc_vol_ctrl_h: sdmmc-vol-ctrl-h {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm1m0_pins>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m0_pins>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc3v3_sd>;
+	vqmmc-supply = <&vccio_sd>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};

-- 
2.56.0


