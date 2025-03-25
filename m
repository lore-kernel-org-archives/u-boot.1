Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD41C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5BC0812BC;
	Tue, 25 Mar 2025 15:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DwG+XVMM";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="ZMS5TP8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B528186D; Tue, 25 Mar 2025 15:48:41 +0100 (CET)
Received: from a7-45.smtp-out.eu-west-1.amazonses.com
 (a7-45.smtp-out.eu-west-1.amazonses.com [54.240.7.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D92BE80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020195cdc6e188-48dacf9c-cfa6-421c-aab3-61d989bc7c78-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1742914118;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
 bh=lEKOGoQXEiIUoyxAFJFAZ2Yj/VZib+N4Lq9ePEU1BHQ=;
 b=DwG+XVMMI722aLeDu4rgxQIymDprkbijavSBB95+cHY970AKE2AMuZMNz72KHc28
 PWzWTHvhPp0y3wB941gxXVbTAGWCGABCsptJlRm4YEkFXbZRtD2UP9AdtKL5qUYzi9/
 oEro0iQeMhPQGwV9/8oyMy6U1107hbLI8Pv4obYjlTABP8rbVwGbI6yrXfOXbWvH758
 y1OYn6108LCuuHYVt3cit8nyQiGD+8Z12R9jkaBwi1ZJIagVUkIKnGOFZpF//o+OFcd
 PNzzInZhd/EQpKgAmWnrjYBV0eAH5T2gwCFj8oHdYdZoz5Rk1Q4mSebvxvddSEGJnAc
 5p9TYDzgSg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1742914118;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=lEKOGoQXEiIUoyxAFJFAZ2Yj/VZib+N4Lq9ePEU1BHQ=;
 b=ZMS5TP8abkvKMCZAftTmetYawhWiMsOHhic4v4r6Z7e1KwYr9aQwDkuV7Y3xA6dZ
 bAStDrUjR6OfQ+BxSchqpu4n7rB9adgoqYMRh64FU2ztxuGvnAnraDM4WYOTpAY40VA
 daCF1z0DrgoQP28reJo/dDA1dc8QKyAkpxpvAwaI=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, 
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] rockchip: Enable usb gadget on Radxa ROCK 5C
Date: Tue, 25 Mar 2025 14:48:38 +0000
Message-ID: <01020195cdc6e188-48dacf9c-cfa6-421c-aab3-61d989bc7c78-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.03.25-54.240.7.45
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

I was testing DFU and SPL DFU [1] on my rock 5c. To get it working,
I had to set the usb_host0_xhci node to peripheral and maximum speed
to high speed, as done for other rk3588 devices.

For DFU (and not SPL DFU), I had to set the "maximum-speed" property on the
usbdp_phy0 node, otherwise it's failing:
=> dfu 0 ram 0
rockchip_udphy phy@fed80000: cmn ana lcpll lock timeout
rockchip_udphy phy@fed80000: failed to init usbdp combophy
rockchip_udphy phy@fed80000: PHY: Failed to init phy@fed80000: -110.
rockchip_udphy phy@fed80000: cmn ana lcpll lock timeout
rockchip_udphy phy@fed80000: failed to init usbdp combophy
rockchip_udphy phy@fed80000: PHY: Failed to init phy@fed80000: -110.
No USB device found
udc_device_get_by_index failed

The issue is that it's trying to configure the usb3 phy, which is not
the one used for peripheral mode. I've not checked on other rk3588 devices
if they would need a similar change.

[1] for SPL DFU, I've used the serie https://patchwork.ozlabs.org/project/uboot/list/?series=443761

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
index 1dc574c2f21..54b0f914010 100644
--- a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
@@ -9,3 +9,15 @@
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 };
+
+&usb_host0_xhci {
+	bootph-pre-ram;
+	bootph-some-ram;
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+};
+
+&usbdp_phy0 {
+	bootph-all;
+	maximum-speed = "high-speed";
+};
-- 
2.39.5

