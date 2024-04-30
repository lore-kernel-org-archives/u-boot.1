Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CE5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2617188A1E;
	Tue, 30 Apr 2024 17:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hHzoRo8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B75A887BA; Tue, 30 Apr 2024 17:32:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B17888A1E
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491122; bh=+xNNFKE6xGT6JJIFUQ4/EklYXPM1vzlZ6un3pJYyhDU=;
 b=hHzoRo8NIgiCXVWDv3WrctJuVjayAr7pZ9VCoFj6ayK+KVkFGic2Re24MgVIr60/EI/t5UWRl
 xyr/2AMwYsUYcdQiv+XdKFxqgpj8UMj50iLfo3IBx9d2OVHE0NcOO0GDvRtsy2VORdJS0gMl1q+
 OzlelJvnMJqoObkQr1vuvJxYgwOFPmuMTwRkALLzavre+5/EUl8lw+VgM7aHGidrqxiUEtLI4uz
 5C5d8fsxvoIIv085G3Nxfz+tW7pBdOGa5GqJTwbAZ5j/NBEB0IR7PvIynFnYCZB1NJst8xJDXuN
 A5JZfBRwMlZwKtNPMQ0lX6QFbi8lGl19nwlWgXKHX/8g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: [PATCH v2 12/18] rockchip: rk3399: Remove inherited bootph-all props
Date: Tue, 30 Apr 2024 15:30:19 +0000
Message-ID: <20240430153053.308788-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310eecd99e42224315b8db
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

Remove superfluous bootph-all props already inherited from main soc
u-boot.dtsi file.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch split from "Fix loading FIT from SD-card" patch
---
 arch/arm/dts/rk3399-evb-u-boot.dtsi           | 1 -
 arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi  | 2 --
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
index 796ac9642399..9df4a02c3e74 100644
--- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
@@ -38,7 +38,6 @@
 };
 
 &sdmmc {
-	bootph-all;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
index 83b0c44e9ec5..56fdaf440aea 100644
--- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
@@ -12,12 +12,10 @@
 
 &sdhci {
 	max-frequency = <25000000>;
-	bootph-all;
 };
 
 &sdmmc {
 	max-frequency = <20000000>;
-	bootph-all;
 };
 
 &spiflash {
diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index 5dc7d0db5f73..dcfcec4f3072 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -8,10 +8,8 @@
 
 &sdhci {
 	max-frequency = <25000000>;
-	bootph-all;
 };
 
 &sdmmc {
 	max-frequency = <20000000>;
-	bootph-all;
 };
-- 
2.43.2

