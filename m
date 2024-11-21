Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4A0D75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FD0896B1;
	Thu, 21 Nov 2024 06:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166784;
	bh=Y++89W2deesAdM4JJagzmQ4x9G4Z7WPYXhTYsQG0VfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gt6P7uO2ZQZd4cnIPDMYJy3TSdwjDRKvizr6bm48U5tsmzFtLmK84n7R9TnRsji48
	 0Zk9tFElStcYBPAbV2wkFQBQkNljWNts/XUM/KamwC4/GOQpcKLCm7Yot/CqlVpBeZ
	 vZ43nMr2pVHhdyKkofZvuOo8VJ8zxGKcdwbZwws13fyDnXomX5HCdOzJDhjrA+ehFY
	 eqOpobkJMb5qC6NbUfKhraTTBJ5rpbIPLiOIYfUoF6rMYaZbaYe3QJzvYxWXx7tabz
	 0g63IQBqyvQ5Q8DGJJKzL4CEjzeYkDSp5Y54niuqI3t25pV3zavAlWihM598SSVCC1
	 9N1aFV28TvnrQ==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0115389654;
 Thu, 21 Nov 2024 06:26:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166780;
 bh=Y++89W2deesAdM4JJagzmQ4x9G4Z7WPYXhTYsQG0VfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GFHQ063Ny9ldrjTdcs7fbTXvOYmnlqej4lbcZzley2XDWXHZsEWmPV7OntEuuWnrO
 KPEt5cceSoKDDb5+RQc8SvDR+Xww6soQEMq51LrszUKYyDysCmeAx792P9R6EiNVJu
 O+SBx28LmRMKTO6AUNWOdx8CFGk2cjKyxQ2naM9ex8BosY//TzyFx2YHVlrVPZohzC
 hS6pWdw2N8wINYP+0M1X46reHsMzN9+z0wRGiv+HbNUK1wB6PKjvp/oWdpljLfZQVB
 c40b3dWUsIZEiejDttw5lhG0uoC29C8tuCcprV2Yl1ZsmrvQuBGmR71zc7e2KbT5TB
 oF7tS7WQUKczA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/20] siemens: imx8-capricorn.dtsi: add wdt device
Date: Thu, 21 Nov 2024 06:25:54 +0100
Message-Id: <20241121052601.72880-14-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

add wdt device

Signed-off-by: Heiko Schocher <hs@denx.de>

---

(no changes since v2)

Changes in v2:
- add comments rom Fabio and Enrico
  do not remove DMA for console
  remove u-boot specific property addition, instead
  add it in arch/arm/dts/imx8qxp-u-boot.dtsi

 arch/arm/dts/imx8-capricorn.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8-capricorn.dtsi b/arch/arm/dts/imx8-capricorn.dtsi
index 4918bf8f567..3734a9d21f1 100644
--- a/arch/arm/dts/imx8-capricorn.dtsi
+++ b/arch/arm/dts/imx8-capricorn.dtsi
@@ -17,6 +17,11 @@
 		stdout-path = &lpuart2;
 	};
 
+	/* create device for u-boot wdt command */
+	scu-wdt {
+		compatible = "siemens,scu-wdt";
+	};
+
 };
 
 &iomuxc {
-- 
2.20.1

