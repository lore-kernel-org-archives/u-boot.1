Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312C4E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D16D801A0;
	Fri, 13 Dec 2024 00:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="O9Qzq0Hp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECFE480214; Fri, 13 Dec 2024 00:57:58 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1C3801DA
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047871; bh=PwkHdmksqTd42U/5NYPLKdvYopbxR2smlIsaRQYHSOU=;
 b=O9Qzq0HpIo4pXevW0XS1ePiqiotgorhn5XzV/CfwieVcdic824cHJ4GzthdFTJfPYhVJ0cNuO
 HL0gGmEwuf2Fkv582lIjuZo/WR2COtfI7zaIiHlEVt6Jilq+1GrAxOA1K3DH1Fk+qx+N75u4GhN
 4BvWtotSmlYajihEVNZc2vhI7I50e1soon4gmBmNEnrJLZT8ALZbrTvh4DRoQ86Af/v6PdyOvlQ
 s7EvPpuuO2C12QSrT37Dpder4cYuap1BW1pdQK4xI1vEzWccT7CsSJ0YjWwxgIpNpnlW5WekmxO
 TpUBDpTHicml5xLRGG4Ua5ySTkrHQ+ypDL67Kefr1YDA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 02/12] rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in
 offset prop
Date: Thu, 12 Dec 2024 23:57:09 +0000
Message-ID: <20241212235735.164272-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 675b787ea511ed8f0b3fe270
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

Use the offset configured with SYS_SPI_U_BOOT_OFFS Kconfig option
instead of a hardcoded 0x40000 for the FIT payload offset.

This has no intended impact as SYS_SPI_U_BOOT_OFFS=0x40000.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-gru-u-boot.dtsi | 2 +-
 arch/arm/dts/rk3399-u-boot.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index 6bdc892bd913..2505d9b01b8a 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -11,7 +11,7 @@
 	};
 
 	config {
-		u-boot,spl-payload-offset = <0x40000>;
+		u-boot,spl-payload-offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 	};
 };
 
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 2bec139d8338..81a3c6fc972b 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -43,7 +43,7 @@
 			};
 		};
 		u-boot-img {
-			offset = <0x40000>;
+			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
 		u-boot {
 			offset = <0x300000>;
-- 
2.47.1

