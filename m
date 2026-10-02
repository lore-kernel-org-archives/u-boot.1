Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7D7CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 03:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19EC540BE8;
	Fri,  2 Oct 2026 03:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CYhOb4YLIbho; Fri,  2 Oct 2026 03:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 59AAC40BE1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790910843;
	b=pUzGdEKzL1H78H1ZkS6hGo5BtZZ2fIA7B/KDKqbkzU96dSilaNDgqDKWDTy7EJSLmoLn
	 u3GaL6O3zhsAqxBtXP9kJzTuwUfnXLwFfFPFugWFOISh+P7wNgXrVjTr7FWY7OUfg3Hd7
	 5Ex5hU0oVnNYMwUEASKrWv0I4pMJn+XBU3NVMuYJ9IWt1gDs2THsKbt2Qo/JVBeJLT0Ek
	 k7JIbnT6dZ3peRUAMEHVSA6dpDpkmUwhXN9NGi6ig4w/x2eGiyzh38UzF0CLlQE4Ey+Ca
	 wbfM2Jl6mg9ihcPJlBjPkmzSRhR7vVxlaKSEny8ZYsljzN4mYVNxDm35LM2mHDAEsKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790910843;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:X-Relaying-Domain:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GiUfWtwyiA6PX5pbqxqrq8GscNEcJF2NM8XRf5kzDjQ=;
	b=bRPaVfX6ewnpCX4HK9WXckBSzi2G8kqW19CWUkKMxRLXEJK92t8ELcXKNN4a/hXhPr3p
	 /TUGSggySMdZizGPU5tsUY0Ei26uxnSusk2C/Z4SRpS1XIROkfKn7OnKAwoC+kF8aNmDu
	 +saFLMX5YIwOJadXKVKqpweEAxOgv+1aqhO1TSw/bw6YwuXQNODxpOd/ZfAT2KZRDTndd
	 05Vl3B/hC+l/4k8cl0CwXPPweTqnO+wjupgE20JFN6rwbBaukOWyFO9ohr1Q2FL8gDZZV
	 60FZD4fSb2PUnnU2wmrC0WbjhN6WJJzNQH6+qk/9YmQg5PE6hnJil6xrLleULL9Kkiw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790910843;
	bh=GiUfWtwyiA6PX5pbqxqrq8GscNEcJF2NM8XRf5kzDjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MQiYvnkoosQ4YBTv1rICLt8+D/QN8mjf3WoAuubI5mo9YhKCx3SBffpAH/rWvy7gE
	 SWsUPps66nm4MxZSW4fXQnaBlKp+5ZsrW2NFNC93B6omXtGwj29yRZATdqQq5oRfz/
	 uxxSYN7QuPuYW++LZP0n67xz1ZhFSv6S43sT81IL9UJWpwKHui9BVNc3RVVnUH/2F1
	 1UnlVP1SxbB+wdNN11otK6qL4ehEIg+V7ErBP9SsQJXEfBVLkL10lULQfBg0IET7e9
	 aabUGw0rI2dQwM8BmDPMrP7XABV7VXjyNNXuEigCXHeDgis/QQ53DDzwFPM5u4XnF5
	 h4oGjj0e6Qwlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59AAC40BE1;
	Fri,  2 Oct 2026 03:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1201B282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F68C80FAE
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlnFP6PiSx5G for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 03:13:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 510B880FA4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::661"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790910832;
 b=eJ1TjHYRvSyq1dx4QLojgQe8b3TkRouQ70gOJbwR/VciutK48mMTcFHGU4fBRaF43lnJ
 QJyayYnle+L93MSXV6fu2gEy45R1VvK4jQA/aI6FDsuxaYWUbNHz/Y10QtkGbWFxUVY1g
 iDjN5SQsnyAoQzKkkAAYZal2+HgdcKFhfDv3JU+c/elOjsacpw2g+x3ScPWYTFG8lEQjy
 MTiqrofjyozDx4yoNWQJDp9GKTmlRjjkYHuppBis2zMrLwVVFiPfAqg/NhPH9tRO7L9nF
 ZmpdC9M2w/3ZvinSttTxd+q1sHlHkovx1Ov9CVusX0ffg+RKkwgwi6vZU9hUMbD2A1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790910832;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:From:
 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=GiUfWtwyiA6PX5pbqxqrq8GscNEcJF2NM8XRf5kzDjQ=;
 b=eQrZo9Evqoj8qP/90gtn83YyFKfhKS3HmUGEQDkn5BcgNxKpO0IVbFmEH+06PkF5SEbx
 6rPxM38AxHJ+/2g8WKf5Ict141elGRhQL9/t7C6mBu+tqQ3Ftm4O1x7IY0R9X1lck/P+c
 p3nT59/z/hPHupY1o0yYHqdGocJC98Is8HBZI0W6pvIXlxhaOeRVuuGM8AZg2xzRoUoO0
 oD3dfL2wzuVP3eqZg7y6d2rrZXdWYWmMD3zQoUGOOnBTgj6kZE9lAUsabj21aKigyQEXg
 q6z2CqMrwAyEF+KiGjfIndHMOnpiNBZW3wuHhNJOEiFHm+Bvh+O+XxmRbkV9YY26+xA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=ausil.us; 
 dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256
 header.s=google header.b=PJ1KN6ej; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::661"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::661; helo=mail-pl1-x661.google.com;
 envelope-from=dennis@ausil.us; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ausil.us
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us
 header.a=rsa-sha256 header.s=google header.b=PJ1KN6ej
Received: from mail-pl1-x661.google.com (mail-pl1-x661.google.com
 [IPv6:2607:f8b0:4864:20::661])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 510B880FA4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 03:13:51 +0000 (UTC)
Received: by mail-pl1-x661.google.com with SMTP id
 d9443c01a7336-2df8c28a0b1so9883545ad.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 20:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1790910831; x=1791515631; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GiUfWtwyiA6PX5pbqxqrq8GscNEcJF2NM8XRf5kzDjQ=;
 b=PJ1KN6ej19XmIQn/iHEwAF1Y2zmDx7ZvMAgM20AwGazdyATrX8JPegn4FXdt6eYoCc
 FpJiT5WEFx2VSSsJDLr1ZEhZfMfE0KvjVmF2/k0OsMe8zDIrTtZE5sd5D7Qhq3apyylm
 Ak/Rk4JoKf6vMaEGpxAmG5TOLI0Ytz5PAcv/CisMYyd2xwMUI9GwusNYfSkcjbjjXJMK
 t2UyEcrGIyf9VZDcPQsRmpO+Nuy+OjOxsffq5RSGbuYg7XhN8QtnsjGurgt9S6gYu1QB
 5fmy0jTYskn78TmR5Kh5XqQGRSsPm0W3LYES+WDjbv2ISd4wEoyCfvdjkRYlwNCf0NL1
 LcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790910831; x=1791515631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GiUfWtwyiA6PX5pbqxqrq8GscNEcJF2NM8XRf5kzDjQ=;
 b=TYJSWG4oWFdng6j5EJSOlTx/oGhck+R3Tp+B48T54guigzekGiviZghnSylzznAows
 dlDfImDTncplDtruhMc3eGsCdQ06kZUHKRe5Lf119VcYDNCFUWFa82NxgbYWDnWv5p/Q
 CMmfFU+ov2EL9jp8XLER8hVYFWfB5Bw33ei+GP++nvIt+n5LeLzGoOgjqA+Fi5XVzgw0
 JhtVqQs8KNAUQ42vH+khWN3yend4OGCTQmWau2CGdFnxyCt3KvG0y0mIXBx5j7m4Zekr
 uQTBtAyBvprroida7YktZxwZcf5FHqxlvaKAqZFfMufObDxNTJV7goiUskxS7lAGRIAy
 Ni0A==
X-Gm-Message-State: AFq9FYKfAk2lUSyQ8UbHT1y8mJ83Jh3yHuuL3U7AC9WwRHtv1iCKOMR/
 /P6s5XgXXYmfjNhinJdRTvP66Jr3uxcB7/itZy3rzC2H4OkvRrJltmLNm/oKEC1rMC37VeauL7y
 nImMNhi5d9hESA5ib6H4TUpAitGgq73WzK1iqW32y7aJs
X-Gm-Gg: AYBFou1Xhc7B6LVSNT+OPng7N1qcHMIYfPnXlla1Dc5HaJ5lx8QdSXvHXCkI99Z2noh
 hfOV0WJIgsdBiS4LciWC+RBic3/OQ9g/7cLMuH4sld4ix+yuBwCHg9bIC4PrRgRsJLnzX1b72Fd
 0DJspQlygpJR4TrM1pVyOQQlNZvnJtybXwxxg9Hua7HgyksJfxa7E1d9fZ1dS+U1OxICG2Pn6RO
 OMnFw7kbjYGtHi9oKLXh18k212iRO0m1O11Ywx5uoE6nZlYRd68S0+dsi9csOYGWT+sSyqMOIvQ
 FzOkwU/1IWyZMkX5g/0hTzCFKIQsyqzwEbcpZPWwcY2A8m7Z5zlc11tJlNR0xrq/LaW3BA8RT0z
 HBLSDyZTT6UroDBzke2Yrinc=
X-Received: by 2002:a17:90b:33cc:b0:3a2:bb45:d37b with SMTP id
 98e67ed59e1d1-3a6ceb00093mr818703a91.25.1790910831319; 
 Thu, 01 Oct 2026 20:13:51 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a6cd60531fsm834715a91.6.2026.10.01.20.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 20:13:51 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: u-boot@lists.u-boot-project.org
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] board: rockchip: Add Xunlong Orange Pi 5 Pro
Date: Thu,  1 Oct 2026 22:13:34 -0500
Message-ID: <20261002031334.3285687-6-dennis@ausil.us>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002031334.3285687-1-dennis@ausil.us>
References: <20261002031334.3285687-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Xunlong Orange Pi 5 Pro is a single-board computer based on the
Rockchip RK3588S SoC. The board provides many interfaces, including
two HDMI output ports, a PCIe-attached Motorcomm YT6801 2.5GbE port,
an M.2 M-Key slot, one USB 3.0 and four USB 2.0 ports.

Features tested on an Orange Pi 5 Pro 16GB:
- SD-card boot
- eMMC boot
- PCIe/NVMe

The devicetree is taken from Linux v7.3 via the preceding dts/upstream
picks.

The upstream devicetree muxes the PERST# pin of pcie2x1l1 and
pcie2x1l2 to the controller's dedicated function while also using it
as reset-gpios. Linux switches the pin to GPIO when it is requested,
U-Boot does not, and probing pcie2x1l2 then hangs. Override the
pinctrl in the -u-boot.dtsi to use GPIO function for the reset pins,
like rk3568-rock-3a-u-boot.dtsi does, until the Linux devicetree is
fixed.

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 .../dts/rk3588s-orangepi-5-pro-u-boot.dtsi    | 25 ++++++
 board/rockchip/evb_rk3588/MAINTAINERS         |  6 ++
 configs/orangepi-5-pro-rk3588s_defconfig      | 82 +++++++++++++++++++
 doc/board/rockchip/rockchip.rst               |  1 +
 4 files changed, 114 insertions(+)
 create mode 100644 arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
 create mode 100644 configs/orangepi-5-pro-rk3588s_defconfig

diff --git a/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
new file mode 100644
index 00000000000..142db4a0fcf
--- /dev/null
+++ b/arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
+
+&pcie2x1l1 {
+	pinctrl-0 = <&pcie2x1l1_reset_h>, <&pcie30x1m1_1_clkreqn>,
+		    <&pcie30x1m1_1_waken>;
+};
+
+&pcie2x1l2 {
+	pinctrl-0 = <&pcie2x1l2_reset_h>, <&pcie20x1m0_clkreqn>,
+		    <&pcie20x1m0_waken>;
+};
+
+&pinctrl {
+	pcie {
+		pcie2x1l1_reset_h: pcie2x1l1-reset-h {
+			rockchip,pins = <4 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		pcie2x1l2_reset_h: pcie2x1l2-reset-h {
+			rockchip,pins = <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index b64dd4947ee..0cc32a6e28e 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -35,6 +35,12 @@ S:	Maintained
 F:	configs/orangepi-5-rk3588s_defconfig
 F:	arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi
 
+ORANGEPI-5-PRO-RK3588S
+M:	Dennis Gilmore <dennis@ausil.us>
+S:	Maintained
+F:	configs/orangepi-5-pro-rk3588s_defconfig
+F:	arch/arm/dts/rk3588s-orangepi-5-pro-u-boot.dtsi
+
 ORANGEPI-5-MAX-RK3588
 M:	Ilya Katsnelson <me@0upti.me>
 S:	Maintained
diff --git a/configs/orangepi-5-pro-rk3588s_defconfig b/configs/orangepi-5-pro-rk3588s_defconfig
new file mode 100644
index 00000000000..f4c6eecf2d5
--- /dev/null
+++ b/configs/orangepi-5-pro-rk3588s_defconfig
@@ -0,0 +1,82 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-orangepi-5-pro"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_SERIAL=y
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_EFI_SECURE_BOOT=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="pci enum; usb start; nvme scan;"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5-pro.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ATF=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_PHY_ROCKCHIP_USBDP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e2..dfaceb40f46 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -179,6 +179,7 @@ List of mainline supported Rockchip boards:
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Max (orangepi-5-max-rk3588)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
+     - Xunlong Orange Pi 5 Pro (orangepi-5-pro-rk3588s)
      - Xunlong Orange Pi 5 Ultra (orangepi-5-ultra-rk3588)
      - Yanyi Tech CoolPi 4 Model B (coolpi-4b-rk3588s)
      - Yanyi Tech CoolPi CM5 EVB (coolpi-cm5-evb-rk3588)
-- 
2.55.0

