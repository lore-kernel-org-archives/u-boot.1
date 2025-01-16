Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEC7C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C33980780;
	Thu, 16 Jan 2025 14:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="Ea7AhCNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC19D806D4; Thu, 16 Jan 2025 10:16:43 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52AA80658
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4YYcgX0BlCzDqk5;
 Thu, 16 Jan 2025 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737019000; bh=SkPwamh2hseXlNFl3/cP7ROwxrZRpJHBc7vfoXtfgHg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Ea7AhCNAE1MQuzUsirVPRiaR/DJY1/zvoaCcajmdYsPf3jRFDBm/o49lx6HS2hENq
 0bQ3RYYMLJKFgWvrOGOzbU/BZoM7KNfDSGHrQe+AjIGu/lUOe5/ASrPvNGzQp9zRd1
 HmE7QSRJlKJuMRi+a3ADhftGYoF/wdFQoffm+OcE=
X-Riseup-User-ID: EC239EB12DA5FCE459FF9D3ECBD652454215D3FCEB1809BF4A74ACA84326BC4A
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YYcgT1VWJzJrSR;
 Thu, 16 Jan 2025 09:16:36 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Thu, 16 Jan 2025 16:15:56 +0700
Subject: [PATCH 07/10] dts: rockchip: rk356x: Prerelocate VOP in U-Boot proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-vop2-pt2-v1-7-c9d646b53930@riseup.net>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
In-Reply-To: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:20 +0100
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

We need to prerelocate VOP2 memory so the driver can work. This
will only support U-Boot proper.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 arch/arm/dts/rk356x-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 0a0943b462a90826a05b3539bd19f77abf169944..413e3497404ee0ecc109c2386233ba5946113979 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -162,6 +162,10 @@
 	clock-frequency = <24000000>;
 };
 
+&vop {
+	bootph-some-ram;
+};
+
 &uart2m0_xfer {
 	bootph-all;
 };

-- 
2.48.1

