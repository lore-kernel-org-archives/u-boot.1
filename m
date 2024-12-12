Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A6EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E57880214;
	Fri, 13 Dec 2024 00:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Zm2NymqJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097DF80219; Fri, 13 Dec 2024 00:58:16 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADE9800B6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047890; bh=xxM9r+jIpOWVIAAh3b/NStNa2XD627jsenVCF6zlGQQ=;
 b=Zm2NymqJmvyWfP9BS82fCEirj0cFW07HWH7AuRaztZ5pKmdoyIvHLA5dGkr16RYqDVCSpG2qH
 /inKOT971esLpxiZaaKTQG++Q8Hnmi3B0QSXLwtv33PKjyf+K9F1Z/qjIhaOoOOLTUyCG054qtl
 7tlx3Q1hIkRqNpWjw2RX3t/wNxsgquTg9+EVER0lWeBpvCBn3czaS67TTFo1cii4/dUxuCG4OVV
 tttjYdpB/3d4C2anPP0kW8egI9eyBgQHGQgbzVYX1G9JnU4xLy5lrffi+cH1cIrFYvUYS4+cbp7
 hqGU9GmAiJAcx96GjJMCSRE4unKyhixIcVqpsDnmhibg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/12] rockchip: rk3399-gru: Include binman generated FIT in
 u-boot.rom image
Date: Thu, 12 Dec 2024 23:57:13 +0000
Message-ID: <20241212235735.164272-7-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 675b788fa511ed8f0b3fe2c6
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

The u-boot.rom image contain u-boot.img FIT instead of the FIT generated
by binman for the u-boot-rockchip.bin image.

Change to include the binman generated FIT for the u-boot.rom image.

This change result in TF-A being included and the use sha256 instead of
crc32 checksum in the u-boot.rom FIT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-u-boot.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index bd7527dde223..70f35b6c197a 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -50,7 +50,9 @@
 			u-boot-spl {
 			};
 		};
-		u-boot-img {
+		fit {
+			type = "blob";
+			filename = "u-boot.itb";
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
 		u-boot {
-- 
2.47.1

