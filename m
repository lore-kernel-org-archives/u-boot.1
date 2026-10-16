Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40743CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C2B161325;
	Fri, 16 Oct 2026 13:24:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5W82FAenBhpd; Fri, 16 Oct 2026 13:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0AC5661168
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157075;
	b=QUXIQEaVPTIk97BxAKX/8uaVEb58r1kSpwalRRVpNgcw0nNr5Ypwwi/3duzvQeZ/dkQG
	 OVYhwQV6WNYGZ+fQvtUtyloSwOUw8/dYk0WtLBHxLFOH+5RXxbuznSGAPJAH8gQaYm6+4
	 To1QeSl1aBboIZtKzc1m558t3Lo4k/OsXWdJpPXfi7ThK1Nu4N6R6mTH1p4+1SEA1jhYt
	 1WfuDdBWqrvgf1rTm/b2XOM/nbWj+Q2b+JxdoG7SWtdJwnfz/Hx2NMfpMNOoGiZWBGKcg
	 q+nuyC4ehvB8+FGbOVDg3XTS7++G6OWiitfqV/zVVbut2EolpbStnjlACwxM7GUSFVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RydeF6/NH7e7M9YEVYjTP0SM8elIAlYPib7nCv5Jj9w=;
	b=R0RFgDwGonAD6yp5mf1wivV8st/I4WkQkDfgdojdvyVlOJv3Z8a4svbQK6OHQsKf1zhh
	 dJXi/OGzn0nPT0mAGUv4QCy9uhoA4NkCbjjSy2eCp1tn57Wtv/xoxuV8OFLwjn69m/lLp
	 8Hi+7CV6ZiWvjga7jdAnjf/fLGyYhvuDInXauyRKXcLZY2K4y1lkd3UH0QsoQzmlH7tR0
	 WHb6hefn7I4ATTD7kXHRkSzri72UuorgZSVz1PVDEr79DPiwC7SmpIJLg+TeIH1w0WqQs
	 4oH9lFyiu2aGMVusVx7CeDsxyLAqo6vPqQfh1Jo0tJKXOl9kq0YACIqt+CeHGo1VOQw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157075;
	bh=RydeF6/NH7e7M9YEVYjTP0SM8elIAlYPib7nCv5Jj9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E3egWjBBXSihHRmHOnQif56nePBx6WpHgh/K0my4w4ouYCXt1swCFJQTWzz0mbpCT
	 3uk4NueiNthQ+PHtx5NZ6usJKoVhU9khMmO/j+q0aWjXijcRdbrx6GD9WN4ejJrsSw
	 rj69QSqV0Z8nxwQhHtCiN9oeJSdIiOyQOnPyQRazpLPTiDqYiopvGIecykCIC7N2NB
	 6aFOgPFuU6S5c4qcy56tF68Mp80frn5fcjFBmd2L3DmgkNkuke9BdWkZzEMvMXTcC4
	 v9yTbnuwDBTMnd3D4tkMQ7mFBjW8kqCXc3LHiwXcWniYCqAT6BE8cHNBufH/hnL6zc
	 Xp6YLaTST0Zyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AC5661168;
	Fri, 16 Oct 2026 13:24:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC93F920
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B33CF4046E
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VblY5n2uyobb for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 61DFF40100
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142236;
 b=L+1QDHy88S65bI6lD4yfZkp4NO+GAIIScXF5jj4kHACc2wbxXZS1bWNXvDokP2m4Hi4i
 vh4JDCu60haBfkC7mxvK3afnY96Rt/WrwCNZD3vKaS9SNE2JtXlV8su4wJL39UgbkyMLI
 iP8d0I1OYp1Pilb/AVhPiIOMxNx+GXmpMgob9vBY+RADv/ggjBesdRTe3tgM8nu0O5mMT
 3KEhUaGLs/H1ydAyUZWawdHFaHduzBUSe2v3h+QLXdtRjOZwQz8fBD0vT8eM97A5485E5
 J4gecpf+wgLqMSVVUAdgzZfDdu5SNfeSpPcHBZRORWBfp5Iq41Ux1I+eY1FdLRYCnhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=RydeF6/NH7e7M9YEVYjTP0SM8elIAlYPib7nCv5Jj9w=;
 b=T5l1jk6KH2pbml8NGbUAZz5Nkbs93/EmONtdO4cBhKeJBIj0KG0jAYstK6QgdQBzHz79
 ASKd9gfQIfb+E/uHSVkOKmJo6AX0+iUwxA9XCVXtYhP8nHlpshcoKvAZuEh06OpUlylDQ
 L06/v6VI0XA+TfywsLXW+67PjBb9tuQ4OU98JuFvchdIJ+0zb1xr/mXI3ikMye/E4msyN
 eeMWZg07v3roq+HST+oq2cYh+mvYnqdKitJwkl28M/ojeg0/nMIRVWrM/Svq6pdNheGNS
 yvXe+T01r+UZyuyhpH3T7UrLe5WpanTlDn6GsFcm+5R+eVcTHiPt9gLX/JgfmPmL2UA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fArsoR4w; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=fArsoR4w
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61DFF40100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:15 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so586442f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142233; x=1792747033;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RydeF6/NH7e7M9YEVYjTP0SM8elIAlYPib7nCv5Jj9w=;
 b=fArsoR4wNaooL09uebzRBv0SsRrUOJ2ttx7lO2d+96KHcZmuyCvm0ky/aFjc9TqI9w
 SY7+Dn43pYMi4i1mw8qjntjynEnihFR7yvB6fmj0F4sMt1c37zdHLXH6KQ5rAu0PhmlU
 pOr+CWrIEGU2cLDE0vw7vRfJIl/7LMxBAD+fotJmnr0nVk7a03dKhEtIji0T6PQwTGCw
 jhfiTrAcg3WR1WrfNqSuHOM/6+zfr8Fu0odzUB/tit6r+z2eN0Pg1N8R1beW5X7N5whT
 s0cKYsRvvnodKWrtiqAr8HKt2th1klbY6ibuaI/tYcgdfMMsq0qKdc7PyXBZnkLW/bDF
 xoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142233; x=1792747033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RydeF6/NH7e7M9YEVYjTP0SM8elIAlYPib7nCv5Jj9w=;
 b=Vj065tMIKfIXmOfbIO1ATFhQ67qn/fvzpLLUX+e22U4Bc40yXs1kwSNhKtag7RxuE1
 B86edT6kVH3V4i1oEVtUN8xtt4Vj5iJTpc/g5QEWEnInBdq2DaWofeXlt59WLfpIh+53
 j/gWE626g62M2VnaMAJb99V6tMXFyioG7dyRv/C51QioiUDTJhI4ooMHRF/LnsFFyZKz
 XV4OJP5lbPkVxtAWxUk0Iq/lSRDlQVlIS/PNXoGsK3hkZbnEhOXuK7OVKmPqBBDGlVuH
 1XWAZTMZ9BaBvPuNKDUgGxF9pnlye1JVNk+A28hbcVbgwRuMtoF1ZlTIicI7M+JrtHrK
 /+JA==
X-Forwarded-Encrypted: i=1;
 AKwUvByrPSrSGmLKxeIJcqLBHMJDg7tbPD6EXcfiPekNJ1osf6NLImiMIXwW9QcdEkx6ShcU0SBr/Fw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJfaEYYjwvbzfpCQyJb/Nk3LjrZWRmGCQ9wYUP1PklIiZuKdQO8
 vFMrrSBemjNQxrgOk2qfa/2+ShI8ZbeSJFfb4g3YItuosjNmobvIsrG3
X-Gm-Gg: AYBFou2RdoEDJj1dEo8np0KtPFpgmhjoFTOMWmhwAijc32HA5THBmtcCR1XNVJUaVVl
 PddUXQ/RRb7HYyl8qYHqZ7YKhmjbgH8zktZN50AxnWskwU1v8cL6VtDUD+QEufgwl5VZ8iimYny
 3iRA3nV23okgyuBDwEkTnNO6lzGHtzgTkKmqHgeQFh9BI6NHjx4N2mpDPoa33NBRx8hhh6EmT2F
 WKveGxUhzQ5kX0vEjLjq5oH5NLb2kAjZANuL4veUNwmnwU6spWm5suKjqg1wstAZUHcHGbil6hC
 a4qDPP5Eo9qy2BzuBnmZSTM/PeU9+yOnOUVjfajr9TTtNft183fO9tDmC5nt9hQ3E2L0COgx6zU
 qDo/mkT1vR8Xpb4TjnqL+CiqduOaIHVze++WaqXLeZkFLjiA2PzZPd97whPQZcsS9YjpTy+vljc
 vI1iwkz196P0XHCf00PHkM6RFqOLToYiEqqJrVglCI+mIJHfDZuhpGhlL5PmA=
X-Received: by 2002:a05:6000:26d3:b0:48d:f4ef:62e7 with SMTP id
 ffacd0b85a97d-48dfaca5f59mr6247745f8f.0.1792142233361; 
 Fri, 16 Oct 2026 02:17:13 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:17:12 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 7/7] sunxi: add the PocketBook Verse
Date: Fri, 16 Oct 2026 10:16:08 +0100
Message-ID: <20261016091608.121842-8-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

An Allwinner B288 e-reader. The DT is a copy of the one under review for
Linux, until it can come from dts/upstream.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 arch/arm/dts/Makefile                        |   2 +
 arch/arm/dts/sun8i-b288-pocketbook-verse.dts | 114 ++++++++
 arch/arm/dts/sun8i-b288.dtsi                 | 292 +++++++++++++++++++
 board/sunxi/MAINTAINERS                      |   6 +
 configs/pocketbook_verse_defconfig           |  10 +
 5 files changed, 424 insertions(+)
 create mode 100644 arch/arm/dts/sun8i-b288-pocketbook-verse.dts
 create mode 100644 arch/arm/dts/sun8i-b288.dtsi
 create mode 100644 configs/pocketbook_verse_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f082b6..039fbab2a90 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -586,6 +586,8 @@ dtb-$(CONFIG_MACH_SUN8I_A83T) += \
 	sun8i-a83t-bananapi-m3.dtb \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-a83t-tbs-a711.dtb
+dtb-$(CONFIG_MACH_SUN8I_B288) += \
+	sun8i-b288-pocketbook-verse.dtb
 dtb-$(CONFIG_MACH_SUN8I_H3) += \
 	sun8i-h2-plus-bananapi-m2-zero.dtb \
 	sun8i-h2-plus-libretech-all-h3-cc.dtb \
diff --git a/arch/arm/dts/sun8i-b288-pocketbook-verse.dts b/arch/arm/dts/sun8i-b288-pocketbook-verse.dts
new file mode 100644
index 00000000000..a60cbb63801
--- /dev/null
+++ b/arch/arm/dts/sun8i-b288-pocketbook-verse.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * PocketBook Verse (PB629), an Allwinner B288 based e-reader.
+ */
+
+/dts-v1/;
+#include "sun8i-b288.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "PocketBook Verse";
+	compatible = "pocketbook,verse", "allwinner,sun8i-b288";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_dldo2>;
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
+	disable-wp;
+	status = "okay";
+};
+
+&mmc3 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_dldo1>;
+	vcc-pd-supply = <&reg_dldo1>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	axp22x: pmic@34 {
+		/* labelled AXP227 */
+		compatible = "x-powers,axp221";
+		reg = <0x34>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1260000>;
+	regulator-max-microvolt = <1260000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc4 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1350000>;
+	regulator-max-microvolt = <1350000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pc";
+};
+
+&reg_dldo2 {
+	/* microSD slot */
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-sdcv";
+};
diff --git a/arch/arm/dts/sun8i-b288.dtsi b/arch/arm/dts/sun8i-b288.dtsi
new file mode 100644
index 00000000000..53832ea9dc0
--- /dev/null
+++ b/arch/arm/dts/sun8i-b288.dtsi
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Allwinner B288 (sun8iw10p1) SoC
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun8i-b288-ccu.h>
+#include <dt-bindings/reset/sun8i-b288-ccu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&gic>;
+
+	osc24M: osc24M-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24M";
+	};
+
+	osc32k: osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext-osc32k";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a7";
+			device_type = "cpu";
+			reg = <1>;
+			clocks = <&ccu CLK_CPUX>;
+			clock-names = "cpu";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		nmi_intc: interrupt-controller@1c000d0 {
+			compatible = "allwinner,sun8i-b288-nmi",
+				     "allwinner,sun9i-a80-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01c000d0 0x0c>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		/*
+		 * mmc0 is a v4p1x controller, so it runs in the old timing
+		 * mode and needs the sample and output phase clocks.
+		 */
+		mmc0: mmc@1c0f000 {
+			compatible = "allwinner,sun8i-b288-mmc",
+				     "allwinner,sun7i-a20-mmc";
+			reg = <0x01c0f000 0x1000>;
+			clocks = <&ccu CLK_BUS_SDMMC0_BUS>,
+				 <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
+			clock-names = "ahb", "mmc", "output", "sample";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc3: mmc@1c12000 {
+			compatible = "allwinner,sun8i-b288-emmc",
+				     "allwinner,sun50i-a64-emmc";
+			reg = <0x01c12000 0x1000>;
+			clocks = <&ccu CLK_BUS_SDMMC3_BUS>, <&ccu CLK_MMC3>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC3>;
+			reset-names = "ahb";
+			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc3_pins>;
+			max-frequency = <150000000>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* mmc2 @0x01c11000 is an unsupported SDHCI-style controller. */
+
+		ccu: clock-controller@1c20000 {
+			compatible = "allwinner,sun8i-b288-ccu";
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		rtc: rtc@1c20400 {
+			compatible = "allwinner,sun8i-b288-rtc";
+			reg = <0x01c20400 0x400>;
+			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
+		};
+
+		pio: pinctrl@1c20800 {
+			compatible = "allwinner,sun8i-b288-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2",
+				       "PF3", "PF4", "PF5";
+				function = "mmc0";
+				allwinner,pinmux = <2>;
+				drive-strength = <30>;
+				bias-pull-up;
+			};
+
+			i2c0_pins: i2c0-pins {
+				pins = "PB6", "PB7";
+				function = "i2c0";
+				allwinner,pinmux = <2>;
+			};
+
+			mmc3_pins: mmc3-pins {
+				pins = "PC1", "PC4", "PC5", "PC6",
+				       "PC7", "PC8", "PC9", "PC10",
+				       "PC11", "PC12", "PC13", "PC14";
+				function = "mmc3";
+				allwinner,pinmux = <5>;
+				drive-strength = <40>;
+				bias-pull-up;
+			};
+
+			uart0_pb_pins: uart0-pb-pins {
+				pins = "PB4", "PB5";
+				function = "uart0";
+				allwinner,pinmux = <2>;
+			};
+		};
+
+		wdt: watchdog@1c20ca0 {
+			compatible = "allwinner,sun8i-b288-wdt",
+				     "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&osc24M>;
+		};
+
+		uart0: serial@1c28000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28000 0x400>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		uart1: serial@1c28400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28400 0x400>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
+		uart2: serial@1c28800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28800 0x400>;
+			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+
+		uart3: serial@1c28c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c28c00 0x400>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			status = "disabled";
+		};
+
+		uart4: serial@1c29000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c29000 0x400>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@1c2ac00 {
+			compatible = "allwinner,sun8i-b288-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TWI0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@1c2b000 {
+			compatible = "allwinner,sun8i-b288-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TWI1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@1c2b400 {
+			compatible = "allwinner,sun8i-b288-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TWI2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		gic: interrupt-controller@1c81000 {
+			compatible = "arm,gic-400";
+			reg = <0x01c81000 0x1000>,
+			      <0x01c82000 0x2000>,
+			      <0x01c84000 0x2000>,
+			      <0x01c86000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index df745f14649..53fd2666f21 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -539,6 +539,12 @@ M:	Arnaud Ferraris <arnaud.ferraris@collabora.com>
 S:	Maintained
 F:	configs/pinetab_defconfig
 
+POCKETBOOK VERSE BOARD
+M:	Pablo Mazzini <pmazzini@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/sun8i-b288*
+F:	configs/pocketbook_verse_defconfig
+
 R16 EVB PARROT BOARD
 M:	Quentin Schulz <quentin.schulz@free-electrons.com>
 S:	Maintained
diff --git a/configs/pocketbook_verse_defconfig b/configs/pocketbook_verse_defconfig
new file mode 100644
index 00000000000..df86ab4b786
--- /dev/null
+++ b/configs/pocketbook_verse_defconfig
@@ -0,0 +1,10 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun8i-b288-pocketbook-verse"
+CONFIG_DRAM_CLK=672
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_B288=y
+CONFIG_DRAM_ZQ=3881977
+# CONFIG_HAS_ARMV7_SECURE_BASE is not set
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_NO_NET=y
-- 
2.52.0

