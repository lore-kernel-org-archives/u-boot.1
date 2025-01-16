Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B3CC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7D780792;
	Thu, 16 Jan 2025 14:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="rJWVJtmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2478069D; Thu, 16 Jan 2025 10:16:46 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01A8801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4YYcgb0Gx2z9t9V;
 Thu, 16 Jan 2025 09:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737019003; bh=W4d11A0g2HmcPjYRX1VvCftnsBrhTLEMbvUYUcROoqA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rJWVJtmhn+vSM11h0i1onPeXnfqoEfQ94wpevZ1NB6paelsA5t4mn6myhcg1hAddi
 74V6MdnJseQ9HoRM5gpd2xBKa0PPUBDTzf6wS1ulE9/pspbvpdQnWXK4YF15QKS3vD
 kAhiBmKVDZLbX3ra2YXh5gB6Gv0dBm20Mi138KQM=
X-Riseup-User-ID: 536FD6CE7D84F67A7C4BEBC15DC4E399ABE27A9835F65C31B5153715B61664DF
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YYcgX1tVGzJrSq;
 Thu, 16 Jan 2025 09:16:40 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Thu, 16 Jan 2025 16:15:57 +0700
Subject: [PATCH 08/10] configs: quartz64: Enable vidconsole
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-vop2-pt2-v1-8-c9d646b53930@riseup.net>
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
2.48.1

