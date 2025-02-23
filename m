Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5720C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA2DE810F4;
	Sun, 23 Feb 2025 13:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="c2IT/CWC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FDE810F4; Sun, 23 Feb 2025 13:14:31 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC01D80F56
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Z12q80dQyzDqk3;
 Sun, 23 Feb 2025 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1740312868; bh=gbAJun7Eg000MGzSTAYnpdudHqOq37fZX/7We7YhuTg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=c2IT/CWCMjKz/TOS94q4aBPQV4ee9yq5hfQsR0ruPoQxKxfACAQJQQYO5DPi+DfCI
 hd7FmMUxudQyoH+PJtCOwQynH3JaqOoRRm6SuC8/MMunCKeg0lcP2+HWzFBV5N5iYQ
 pcbBpXYvWr/GF3lsTle8DZT4UrT6lsTex3x11pKA=
X-Riseup-User-ID: 7ADE55674453AE6D0F9CE2D1DA0BECDE9908558ED4120745B04458BC32BC8911
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Z12q42bcZzJtZh;
 Sun, 23 Feb 2025 12:14:24 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sun, 23 Feb 2025 19:13:43 +0700
Subject: [PATCH v2 08/11] dts: rockchip: rk356x: Prerelocate VOP in U-Boot
 proper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-vop2-pt2-v2-8-71350e482970@riseup.net>
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
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
index 24a976cf7e21da351cbbb969ba2b4687c344ca6c..1191e2fd567dd18655c88ea1b7a28d160d43c220 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -166,6 +166,10 @@
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

