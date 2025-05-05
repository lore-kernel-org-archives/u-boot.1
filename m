Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C557CC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 17:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70E682A8B;
	Mon,  5 May 2025 18:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="KRZhu7H2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C641F82161; Mon,  5 May 2025 18:59:19 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE05A820F6
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Zrnmz5547zDs71;
 Mon,  5 May 2025 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1746464356; bh=nOZ0TDdGzVKba0pk9+xGpYVheWNq3taP8oml9pcpCfI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KRZhu7H2hxr6oYLaofsCt3IkwgPy/illz3YslR3C1lJw9uJE13q5152Xxp9FDt6C/
 yljJoxYRulwzEsv2O3MPlEi9u+Bywry0+QO4KjLGnkauWdS8D16ilvnC549U7Xk049
 20RNyPtQaoi6gcHD9HPT5vc4RQMtqBMBKmYEsULU=
X-Riseup-User-ID: D5CF349C80CF87606D28A9ABC0403E33428A4873C5499E0970D12C7D1B1DC379
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Zrnmw20gfzJp9k;
 Mon,  5 May 2025 16:59:12 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Mon, 05 May 2025 23:58:25 +0700
Subject: [PATCH v4 09/12] configs: quartz64: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-vop2-pt2-v4-9-3b7c3ab1a617@riseup.net>
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

Now that we have VOP2 support, we should enable vidconsole.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 include/configs/quartz64_rk3566.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/configs/quartz64_rk3566.h b/include/configs/quartz64_rk3566.h
index dfe0fee94cdb043cbca558e90fb203245534509a..bf391458219b4f2371626d0ccf98af2a3bc279ce 100644
--- a/include/configs/quartz64_rk3566.h
+++ b/include/configs/quartz64_rk3566.h
@@ -3,7 +3,10 @@
 #ifndef __QUARTZ64_RK3566_H
 #define __QUARTZ64_RK3566_H
 
-#define ROCKCHIP_DEVICE_SETTINGS
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdin=serial,usbkbd\0" \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
 
 #include <configs/rk3568_common.h>
 

-- 
2.49.0

