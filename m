Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0580CD4F3D
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 19:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE0CE846FC;
	Sun, 17 May 2026 21:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ya.ru header.i=@ya.ru header.b="wEPOdYKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B6584688; Sun, 17 May 2026 21:25:10 +0200 (CEST)
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net
 [178.154.239.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F65983EF9
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 21:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=paullo612@ya.ru
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
 by forward102b.mail.yandex.net (Yandex) with ESMTPS id A8279C00C9;
 Sun, 17 May 2026 22:25:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id mOVI2m4SD0U0-TcdyzYNd; 
 Sun, 17 May 2026 22:25:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1779045907; bh=oL74VwaypeCVbHtXTJdVBZiTgRN0fmcFw71HK9eiG2I=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=wEPOdYKeiu3JwpIvrNXiAQqjifxUYrBR5PEC9OLYu4vBLov7d+tFP7Br7HSASwuOE
 ekhWyJXgv6NkRl4gwLjBrOqdvYmqqRIKGaHiz/VfNk8md3HRzupqR4wgvTs3QKcEFo
 cHyYw4KPPm6MFRo1nVQ3v22+SMTL7W+Pd2896WmM=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net;
 dkim=pass header.i=@ya.ru
From: Pavel Golikov <paullo612@ya.ru>
Date: Sun, 17 May 2026 22:24:40 +0300
Subject: [PATCH RFC 14/18] rockchip: rk356x: Add DMC related syscons to
 u-boot.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-rk3568-raminit-v1-14-a24e16302a13@ya.ru>
References: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
In-Reply-To: <20260517-rk3568-raminit-v1-0-a24e16302a13@ya.ru>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Finley Xiao <finley.xiao@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Casey Connolly <casey.connolly@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut%2Brenesas@mailbox.org>, 
 Pavel Golikov <paullo612@ya.ru>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Sun, 17 May 2026 21:26:22 +0200
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

Add ddrgrf, sgrf and msch syscons in u-boot.dtsi. Those are needed for
RK3568's DRAM controller initialization. Reference them in DMC node.
DRAM controller also needs CRU, so, add reference to it too.

Signed-off-by: Pavel Golikov <paullo612@ya.ru>
---
 arch/arm/dts/rk356x-u-boot.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index b9f300a3274..3202c1bf534 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -16,8 +16,33 @@
 		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;
 	};
 
+	ddrgrf: syscon@fdc40000 {
+		compatible = "rockchip,rk3568-ddrgrf", "syscon";
+		reg = <0x0 0xfdc40000 0x0 0x10000>;
+
+		bootph-all;
+	};
+
+	sgrf: syscon@fdd18000 {
+		compatible = "rockchip,rk3568-sgrf", "syscon";
+		reg = <0x0 0xfdd18000 0x0 0x4000>;
+
+		bootph-all;
+	};
+
+	msch: syscon@fe100000 {
+		compatible = "rockchip,rk3568-msch", "syscon";
+		reg = <0x0 0xfe100000 0x0 0x2000>;
+
+		bootph-all;
+	};
+
 	dmc: dmc@fe250000 {
 		compatible = "rockchip,rk3568-dmc";
+		rockchip,ddrgrf = <&ddrgrf>;
+		rockchip,cru = <&cru>;
+		rockchip,msch = <&msch>;
+		rockchip,pmugrf = <&pmugrf>;
 		reg = <0 0xfe250000 0 0x10000
 		       0 0xfe800000 0 0x10000>;
 

-- 
2.25.1

