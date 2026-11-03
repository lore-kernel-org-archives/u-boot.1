Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B3606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oWOzupZr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aar9qcn7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE08C81161;
	Tue,  3 Nov 2026 13:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BexJRzt4D5zL; Tue,  3 Nov 2026 13:05:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A43881202
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793711152;
	b=gF7VncFfzZzbO/as7ejwQMXSfRyv5HOMyzg5mbZyaOvrFqkDFSszgmrKUniV1mv+t9pt
	 I92Fnlar6jHnvTSwZj9BliGiElJLGIo75pl59fzkPySMhDYtfKSN3RNRqDoEofj9WSIlJ
	 djECE1zV0i4NyP34fPJiGFQwNmNY37i48L0Ro8Vkg3WDVaIg8vYADGN7eVI+4E+IQU43q
	 oF0vQ4Q22wWcbTjoIxBzxYfYBEkXOd/vvS/K+aUyGL7lRa+ttijv6sPT4NSNRH5cC7fmJ
	 NXmjj+3UzuXjH2CucVH5J5G4Zoad0O1sL8yG+T27UXICeBWUuwAJpatlkJsMgELCeTg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711152;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Lvhj4xj74zFpTFj5w+2SPNnjDQ6jvuUQVH7I99OPYCE=;
	b=EYXjfyDFafZ2w+zRrKL2KvzIXEc2g1+b4d3S/EtwLr7oZQrHnG/Kjtpkhl2W75k3v/g0
	 61WUyfL7QVEX3ZPhrN07mfb1DQj1n5Md0VG8ucB859M0ZpE5Y9tzUjfqYDqDtlFiOFnbA
	 gCOIqIQdS9dvhBz7xMA0SRD2MLe+KkPqs6zpv6ze+IC3NvY+9I5BPpAod0VMLO4BpnCzD
	 eRqWkpnpELCyWr0vA3JIYMwdod64xOZUvSpPqNaz+rr5mQQlqVmfL2Mfl0JWpBpeY6Kaf
	 JqtagnUhaB0TjlaFtUsoBV3+Sck+aJktbm/SsiuHImoJde16T7HkXJaa/zTRzq7PgRg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711152;
	bh=Lvhj4xj74zFpTFj5w+2SPNnjDQ6jvuUQVH7I99OPYCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=oWOzupZrPOaOQ1lpaZbfzDc1l19QvcrKX9Ra3MxHROAEdC6tOc5WBnaX5486ctpba
	 uhHrIQxV4XdHrvUwe2My4VmdlFSBt2cj34Pc76IAEU5pQKxEdKNVcxm0suCrq1idzY
	 fgjNKgW3UwyB7SzjJzLyJKmxP4VFdgiRGJpIwYDJAv0jZhRYsyovvx5+OZdDWvXjCQ
	 /vcTe6QLNSugYtXPYf0p9sxJvWBCCZNIpEACSe21iP21xlo0293kZKzbu8b46R10/p
	 wTV04KXxxcw7NLrEytAwA+ZuvdTSUXJPV9JrA4Hflqjw+68ybZGB71Bqn89eG4gYEQ
	 p/20QA4dYoSVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A43881202;
	Tue,  3 Nov 2026 13:05:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48A042AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DDD8401DF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id agzs0ZE8-Lwf for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 10:37:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3DEDD4005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793702234;
 b=NUX5aMqAA22sGGVwlrUjAyod1LGsdjhFEw/MbyfE9yL8T/f2tE4diBv0uqGAdrVGH9Gt
 ciZjnd5/+B+3CJBswEo2fU1rlX8P4+6eT1A+/yli/31ynAYaNxsH3KqlReAJc00mkoK3t
 C2FcJVF235v4y6IKkZtslk0jKClbC/Uox9q1AheeLxq7SgzY4Gin5EuVamkHm9AcvXibO
 ENzGNvBCK+WtHshvtPqmSquvfgkd8pnyDc9+PUyWaYZqXhC0Vi/q8y8Nkm2zraaH0NmHP
 vkBwVfUplDiOAIHrvbUf2ezZXhUBz00cT9M7Rnh0Q0Wnq30VB6vjRlLhbixtdc5ppdA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702234;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Message-Id:References:In-Reply-To:
 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Endpoint-Received:X-Original-From:Reply-To:
 Content-Transfer-Encoding;
 bh=Lvhj4xj74zFpTFj5w+2SPNnjDQ6jvuUQVH7I99OPYCE=;
 b=ICE0mrWs9e3iN5Cnme5zAIc5bEQV151PAI/HEy9awficOqaeHI61GshJCpcL7vgP1dT6
 pkKzM94trhpOVyNtf+FCcnwrFwyrM+FqY/l8DNfsM8kyrUmfzZ7IGXAAVvPPK1OGu7SyG
 d8uOmvqzpd/J3RaMRR4xkvcUIJbiwwSVz4Eo6i3ERcs922ewMYMpEdfydCsMRK0jzSLrc
 a8nneSQbnzlpX16fBDNoBnnppiPwGkURZGzSZrrvPlFH0oWy2t1LEiW4XgN34J+P+hhDJ
 HMMTxcoD+pYVEdL21E7O2uG+GwwyQYtjHFFFYsBAJk0ncaDyoE6kXF9zOMzun860PGQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Aar9qcn7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+hystericaldragons.proton.me@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Aar9qcn7
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DEDD4005E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 10:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2B4A4150E;
 Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793702231;
 b=Rf4C4PHGrIaI7EfkqHEXGhaEwHkEbVakcnyp7fFTVxALndfdxauU3W+CR48NPfcclU2Z
 lrqFB6dzUoO/cI2EUcVJvxVQUdsJv7PuMJdXN+zPua8ot0nAZ6B7FPESiG/hRmbyT7Q6D
 xT9ZAMKFXQYEPOfjU7SweG/TGoge/CXo0UePTdw0Splu7b6wZkqwQi/nWffnEUh9dFaSk
 g9s18RVwjsz14CneT1cr/ZLb4Ziywgtfwaz1luOpOcKtGJVtB6WBBCKXGKxj2X8liwELB
 zimQorfMfuZ3p6cDJO5EjxtXkbvhpA7eMkB5QC6Q8gHMuZiCwlX2M0XoVjSu83ZY9cQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793702231;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Lvhj4xj74zFpTFj5w+2SPNnjDQ6jvuUQVH7I99OPYCE=;
 b=Ct7iPnkShBV7erHXZd1VLOLrFHB1q5CMZS/hBAN2QHKHlhh1SX5IAOVnW6RX72QEItO3
 D4EXw1XofXGJRzZ/eNedE3NsmX/ku8vHyaQaCon64TnRkTMSJitrab7EJIeGOoaAGy5MO
 3rfM6YbX+N8X2FuiZS4D/8WSAp84Nd/BdxRMiwoXLZNkB78Tcs0nvUSCmRmFmMLTtpRYP
 xqGMXjx+mWlQcPZwBz8pHid4MzAX6/RE1ImMmKJ6d0BT0XM+ZrwCAHTATq7SvxW75OGTv
 NBEFQEXnKENjUJGLvC5oaHq+2GHwA2iwp5lCgfEroLvpVa+CTqBvJUQ0lkUeyuOjk0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 1A48F1F00919;
 Tue,  3 Nov 2026 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793702231;
 bh=Lvhj4xj74zFpTFj5w+2SPNnjDQ6jvuUQVH7I99OPYCE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Aar9qcn7hKlBYPrQiIYatRjG7dKEpfocKFFcg8zD16PfpJpc3tGWtksTvsqdqpn9s
 Bh5/7+Sc9q/ImBl2GVOoM9VSFhMIbHZ0Teqk+DLZE2XjHqWw3xPKPiyMET5g5uCwpX
 CQOh6/Lv0ScVtbc9qHBpZSDUhARZRIUxdBTJkHQpX009Jv7iTdRo5YTbvGI3C02498
 am2q5KIiA1DM6/MpUM4RAHK16BnGr5whpEXmTOKyRJbLFH/ypNWOguUPJGT3hr/4pJ
 UNbgshK2kP6BoHCVYn2fDZcfkKOmnTmAfeRiYpDXySCboyOl53FtUEhGfWnIl6aetI
 YjWkQFpaYxdLg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 12D20468E0;
 Tue,  3 Nov 2026 10:37:09 +0000 (UTC)
From: =?utf-8?q?=E5=AE=89=E5=AE=B9_via_B4_Relay?=
 <devnull+HystericalDragons.proton.me@kernel.org>
Date: Tue, 03 Nov 2026 18:37:11 +0800
Subject: [PATCH v3 6/6] board: rockchip: Add FriendlyElec NanoPi R28S
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nanopi-r28s-v3-6-ae8664fd168f@proton.me>
References: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
In-Reply-To: <20261103-nanopi-r28s-v3-0-ae8664fd168f@proton.me>
To: u-boot@lists.u-boot-project.org
Cc: Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Jonas Karlman <jonas@kwiboo.se>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?=E5=AE=89=E5=AE=B9?= <HystericalDragons@proton.me>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4705;
 i=HystericalDragons@proton.me; s=20261103; h=from:subject:message-id;
 bh=Lvd/g+bpF8LTLWdIkvzptn7vN0IScMw4IvfOk3iqv1U=;
 b=owGbwMvMwCU8Ldb53x4TtgLG02pJDFkvdwZHMhfqr0txq/o2l7X+AYNwvfDB5lPWt5y57U0+3
 q+9rLiwYwcLgzAXg6yYIkun9OeJXx5fmP715qQsmDmsTCBDGLg4BWAiikxM7K6KL/N2N/cf7/h1
 i0N38jGFx91y01POP3YPDHDRUJzy7toaLYdo+5pfCYkmolu9lpYlJ0ea/F1deOHmo07HjRM3Mx/
 OYuJkbIrhEL594kPOnsndk8Kelfuppb0t3vfqUd7ySRdD0zcbnNCadvHehff1MltVfAo3SqwKzV
 wz0XvnAf2sG2XzPprKXttaDQA=
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

The FriendlyElec NanoPi R28S is a dual gigabit Ethernet router board
based on the Rockchip RK3528 SoC. It shares most of its design with the
NanoPi Zero2.

Specifications:
- SoC: Rockchip RK3528, quad-core Cortex-A53 @ 2.0 GHz
- RAM: 1 GB LPDDR4
- Storage: microSD slot, optional onboard eMMC
- Ethernet: 1x GbE (GMAC1 + Realtek RTL8211F),
            1x GbE (Realtek RTL8111H over PCIe)
- WiFi: AICSemi AIC8800D80 over SDIO
- USB: 1x USB 2.0 Type-C (power input and OTG)
- UART: USB Type-C debug console (onboard WCH CH340E), 1500000 8N1
- Buttons: user (GPIO), MaskROM (SARADC)

Add the board to the NanoPi RK3528 board target, which selects the
R28S FDT based on its HW_ID, and enable CONFIG_BUTTON_GPIO for the user
button.

Features tested on NanoPi R28S:
- SD-card boot
- Ethernet

Signed-off-by: 安容 <HystericalDragons@proton.me>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi      | 3 +++
 arch/arm/mach-rockchip/rk3528/Kconfig            | 5 +++--
 board/friendlyelec/nanopi-rk3528/MAINTAINERS     | 2 ++
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c | 1 +
 configs/nanopi-zero2-rk3528_defconfig            | 2 ++
 doc/board/rockchip/rockchip.rst                  | 2 +-
 6 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
new file mode 100644
index 00000000000..151f1872fed
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-nanopi-u-boot.dtsi"
diff --git a/arch/arm/mach-rockchip/rk3528/Kconfig b/arch/arm/mach-rockchip/rk3528/Kconfig
index 87b65d666e9..6e934408e56 100644
--- a/arch/arm/mach-rockchip/rk3528/Kconfig
+++ b/arch/arm/mach-rockchip/rk3528/Kconfig
@@ -1,9 +1,10 @@
 if ROCKCHIP_RK3528
 
 config TARGET_NANOPI_RK3528
-	bool "FriendlyElec NanoPi Zero2"
+	bool "FriendlyElec NanoPi R28S/Zero2"
 	help
-	  FriendlyElec NanoPi Zero2 single board computer with a RK3528A SoC.
+	  FriendlyElec NanoPi R28S/Zero2 single board computers with a RK3528A
+	  SoC.
 
 config TARGET_RADXA_ROCK_2_RK3528
 	bool "Radxa ROCK 2A/2F"
diff --git a/board/friendlyelec/nanopi-rk3528/MAINTAINERS b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
index 67f14661087..c2e3bbba6d7 100644
--- a/board/friendlyelec/nanopi-rk3528/MAINTAINERS
+++ b/board/friendlyelec/nanopi-rk3528/MAINTAINERS
@@ -1,7 +1,9 @@
 NANOPI-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
+M:	安容 <HystericalDragons@proton.me>
 S:	Maintained
 F:	board/friendlyelec/nanopi-rk3528
 F:	arch/arm/dts/rk3528-nanopi-u-boot.dtsi
+F:	arch/arm/dts/rk3528-nanopi-r28s*
 F:	arch/arm/dts/rk3528-nanopi-zero2*
 F:	configs/nanopi-zero2-rk3528_defconfig
diff --git a/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
index 86932eab7c7..c7f2ebe32fa 100644
--- a/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
+++ b/board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
@@ -16,6 +16,7 @@ struct board_model {
 /* HW_ID buckets from the FriendlyElec vendor U-Boot hwrev.c */
 static const struct board_model board_models[] = {
 	{  82, 150, "rockchip/rk3528-nanopi-zero2.dtb" },
+	{ 212, 274, "rockchip/rk3528-nanopi-r28s.dtb" },
 };
 
 static const struct board_model *get_board_model(void)
diff --git a/configs/nanopi-zero2-rk3528_defconfig b/configs/nanopi-zero2-rk3528_defconfig
index dde9134112f..0af811d0ea2 100644
--- a/configs/nanopi-zero2-rk3528_defconfig
+++ b/configs/nanopi-zero2-rk3528_defconfig
@@ -28,9 +28,11 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_RNG=y
 CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_LIST="rockchip/rk3528-nanopi-zero2 rockchip/rk3528-nanopi-r28s"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_BUTTON=y
 CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_LED=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index e22c2d6c575..bf02b700b0d 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -103,7 +103,7 @@ List of mainline supported Rockchip boards:
 
 * rk3528
      - ArmSoM Sige1 (sige1-rk3528)
-     - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
+     - FriendlyElec NanoPi R28S/Zero2 (nanopi-zero2-rk3528)
      - Generic RK3528 (generic-rk3528)
      - HINLINK H28K (hinlink-h28k-rk3528)
      - Radxa E20C (radxa-e20c-rk3528)

-- 
2.56.0


