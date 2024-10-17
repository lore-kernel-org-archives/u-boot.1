Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB528D3C52C
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF20789074;
	Thu, 17 Oct 2024 22:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AdE0LAob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF461890BC; Thu, 17 Oct 2024 22:01:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8911C890BE
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195263; bh=7cz4uRcDnHBy9DQE0+dT9CNBWUNX3I/wVY5gdbJ7PQc=;
 b=AdE0LAobJ1hTnq4M8wiyvzeooHg3WiHHBJK+L4CrdStHL8kn1sITB23eE0HS5hOVhZ94bxvIo
 R9s5VJu1tgZJcpCaEJeGWl+mEzq6GcrXdUCg9182eoDlLHJ2lcUPynspR2aD05mNRj0pPiqMT+h
 Nxo7xt6Bo2sPDQWo+86DIzbDlgNSxtltaIpqXKp9lQVOm/xGw2jrTNjmifOCSTMoaRlnFhrhzCT
 PIe/Mkc2+nGkPlPnDxkFERoTAQl2Li457rwAPj0zLFHQP5b6asU5AvvQpAh4GrM3VleNMRyc3kW
 Jj+rgtj9nYMfA1me70pznjO6i+pZNYqM22nmGTO+1Bbw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH 5/8] rockchip: rk3588-nanopc-t6: Drop upstream props from
 u-boot.dtsi
Date: Thu, 17 Oct 2024 20:00:24 +0000
Message-ID: <20241017200039.1235524-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67116cff6385e073f5ab13f2
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
bootph-* props from the SPI flash related nodes from u-boot.dtsi.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
index 968385622fa5..3261b2c42b4b 100644
--- a/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi
@@ -12,19 +12,8 @@
 };
 
 &sfc {
-	pinctrl-names = "default";
-	pinctrl-0 = <&fspim1_pins>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	status = "okay";
-
 	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
 		bootph-pre-ram;
 		bootph-some-ram;
-		spi-max-frequency = <24000000>;
-		spi-rx-bus-width = <4>;
-		spi-tx-bus-width = <1>;
 	};
 };
-- 
2.46.2

