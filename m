Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E982E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E988580274;
	Fri, 13 Dec 2024 00:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="honHwNXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB3A80274; Fri, 13 Dec 2024 00:58:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62473800B6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047897; bh=4q7oFsKCl4wn7EWdImSI8GM5ld8Me8t5y2z+V/rEHUc=;
 b=honHwNXSCPV+xIQ4S12i84wtiveY5rWrQOkAu4NxfS9zCZ+fCwC+U4iKBdiMwmir8SjnieaNG
 e0ZqjXvsCqz9mtbK8DigTHJgrbm7e9W8Sj9MNLJtcg8PtYYJ9I3ga33QBOi/FRdBchbW7kOHasd
 GkeVeUqaPw6otx0/wf0QdwtG64DVjistSsMgJa06On+cZBDEw3xLsFMGm41l/4IlOeWpBWR7EtO
 9twyr9goYZ71rqyVDHCadLb7DV97ht+40gWifqF/ew6WuL/QxAwyBDwC6b7Y+VbGeaXd2vaUIBb
 gFdyaD8zZnK9S6zflAxEmRcUA94fS70q95GYeZGrdZwg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/12] rockchip: rk3399-gru: Remove unused nodes from xPL
 control FDT
Date: Thu, 12 Dec 2024 23:57:15 +0000
Message-ID: <20241212235735.164272-9-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 675b7897a511ed8f0b3fe313
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

The eMMC PHY and SPI flash is not used in all xPL phases.

Change to no longer include emmc_phy and spi_flash in all xPL phases.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-gru-u-boot.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index 2505d9b01b8a..5f44327736df 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -29,6 +29,11 @@
 	rockchip,panel = <&edp_panel>;
 };
 
+&emmc_phy {
+	/delete-property/ bootph-pre-ram;
+};
+
+
 &pp1800_audio {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
@@ -80,7 +85,8 @@
 
 &spi1 {
 	spi_flash: flash@0 {
-		bootph-all;
+		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
-- 
2.47.1

