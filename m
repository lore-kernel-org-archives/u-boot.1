Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E356C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 835ED82A55;
	Mon,  5 May 2025 18:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="tCjGYwB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D61782A36; Mon,  5 May 2025 18:59:17 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379A182A9E
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Zrnmw15XHzDqJZ;
 Mon,  5 May 2025 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1746464352; bh=u5n00fR9+r+BZk+zuBdYvN8fN2fNgUOedxWqIXrp5qM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=tCjGYwB9dz5+jNX2UkReEiTaq9YXgaQMyt4YYT21ZXfJr1MF3IOVW5dOSG5yw/nTU
 Q4ZMoUMKC8AhbcBbA8oDO49cb59hRWnmrhtPge8IjikDELY9xcJfbxzEgcNDMGiu5C
 owlm/80h0jIEBs4itKSM4iqYCzWurloU2nT1yugQ=
X-Riseup-User-ID: D0F353022B14668F67C95011A4EEA95D525A01639853B603F00B50CA48771519
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Zrnmr57CzzJsNx;
 Mon,  5 May 2025 16:59:08 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 05 May 2025 23:58:24 +0700
Subject: [PATCH v4 08/12] dts: rockchip: rk356x: Prerelocate VOP in U-Boot
 proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vop2-pt2-v4-8-3b7c3ab1a617@riseup.net>
References: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
In-Reply-To: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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
index 8718697395365f1daa8566c5f47729b3ac63c793..9e9bb595a2fab37f6cb71884695060fca602a0b4 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -169,6 +169,10 @@
 	bootph-all;
 };
 
+&vop {
+	bootph-some-ram;
+};
+
 &xin24m {
 	bootph-all;
 };

-- 
2.49.0

