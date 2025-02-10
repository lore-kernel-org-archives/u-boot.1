Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6300C0219B
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E87980C91;
	Mon, 10 Feb 2025 17:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Mg+adcJe";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="c8kgDEhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D64480AE6; Mon, 10 Feb 2025 16:30:10 +0100 (CET)
Received: from a7-43.smtp-out.eu-west-1.amazonses.com
 (a7-43.smtp-out.eu-west-1.amazonses.com [54.240.7.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BBD803CC
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b6837-f36ee1ff-c1e8-4b2b-8b11-76cf02467b15-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201407;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=GtIzwEaqMcwQa2Fdkf6X6cqY7ubneFKtrDRcBHxgXrU=;
 b=Mg+adcJegW4JY/kUlhygR4NmJztu+gUpz2O+N9BKhvSukJx/+f0z4e8DrmTBu3wq
 d3UwktmhCzPsuneHACWcMga+2DosvyBn+7f0MMRH03vSnKN2zlhlR/Vr0FkZEbUtjr/
 e6vYL7gOf/sd/+P/HHXOrcEBiEDJi+qopH6QBtu3ZbiX0LYVvAyurn1IPvHw5ULEHNi
 Do8RfmPnx3HnMkzolWnLnRgUon256Oq463yjl9MtiZLTA5VybnxKqTMVObpHJ5qFDZK
 lY64ANF5dCmOacTZbT/d3yPcylI/h7Prh02X4XyqDWvjZdedACoAw589cvdaf4+51Or
 EqFYh9hGIg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201407;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=GtIzwEaqMcwQa2Fdkf6X6cqY7ubneFKtrDRcBHxgXrU=;
 b=c8kgDEhcPgCLdqDZkPaqe25CJwDI3YTy/ET6nghpH2dcdbW7byhpstfQhTAZjSWF
 fgdqoeNN6K/xcuQL+A0mYPFPPdsNaO0i5r+LmiECGSreFnIdaPgLvAVav/U+DAzF9cI
 PFhkrdPL2DOGo6XmR5K/LIjZkXbAhN5c7ZRenKGo=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, 
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] arch/arm/dts/rk3399-roc-pc-u-boot.dtsi: Prepare for SPL
 DFU
Date: Mon, 10 Feb 2025 15:30:07 +0000
Message-ID: <01020194f07b6837-f36ee1ff-c1e8-4b2b-8b11-76cf02467b15-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210152947.3909357-1-arnaud.patard@collabora.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.43
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:47:57 +0100
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

For SPL DFU booting, define u-boot,spl-boot-order and
configure usb nodes for enabling the gadget in SPL.

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index 883d399a06a..e1502f30039 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -11,6 +11,10 @@
 		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
 	};
 
+        chosen {
+                u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
+        };
+
 	vcc_hub_en: vcc_hub_en-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -75,3 +79,22 @@
 	regulator-min-microvolt = <430000>;
 	regulator-init-microvolt = <950000>;
 };
+
+&u2phy0 {
+	bootph-all;
+        status = "okay";
+
+        u2phy0_otg: otg-port {
+		bootph-all;
+                status = "okay";
+        };
+};
+&usbdrd3_0 {
+	bootph-all;
+        status = "okay";
+};
+
+&usbdrd_dwc3_0 {
+	bootph-all;
+        status = "okay";
+};
-- 
2.39.5

