Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C7D2A559
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F70188DE1;
	Wed, 16 Oct 2024 22:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fUMUeoCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8D2988DE1; Wed, 16 Oct 2024 22:15:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6153288DD1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=97a5=RN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1729109733;
 bh=7bf4xea9jwuCxv52csi83ehcKbkXHl6s2k/LY6llqeU=;
 b=fUMUeoCMQbGfJn1lSvVulOpD9D2nEUlsKT9dIm/gaMuJY8y1RZhT91Ee1RG9tKg4lilYBjxrz
 M0X+s8rQpdaZk7HrcZyZvSE/9LVRwoexfmvcewHSZ90ho3O6h8NzJH8ho9lrvoosL/FRizVwN4K
 aocQmzpQfV+t894s0ytOw49Ha8+5UihPny+8S/6Id4fZhx6Ef+H2081f5dr54nzc3+0Asmv71QD
 CrwWNfmY/efPog2nyBkhZfK11ufyTGoOnIoT6MEqUziO93U/rq0EAQceCbGhpgyDtwsQf7Mhi/t
 sLQEEheO2MKcArzuLsM3S1J0MRKLnDRXz6m7heCMyhOw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3399-pinephone-pro: Drop upstream props from
 u-boot.dtsi
Date: Wed, 16 Oct 2024 20:15:21 +0000
Message-ID: <20241016201523.903560-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67101ee273445051e72dc8d8
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

The SPI flash node has been added in upstream DT, drop all props beside
bootph-* props from the SPI flash related nodes in u-boot.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
index 037cec10ce36..7438bec4ee63 100644
--- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
@@ -15,13 +15,8 @@
 };
 
 &spi1 {
-	status = "okay";
-
 	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
 		bootph-pre-ram;
 		bootph-some-ram;
-		spi-max-frequency = <10000000>;
 	};
 };
-- 
2.46.2

