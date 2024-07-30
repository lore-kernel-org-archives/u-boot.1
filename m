Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6AFC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D041288831;
	Tue, 30 Jul 2024 16:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qnjD2iJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8438F87E62; Tue, 30 Jul 2024 16:28:16 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9147C8882F
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=18d8=O7=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722349686; bh=PPCDP25csG3avfU3NhyieMwv8pTvmFDY8AdhZfupjuI=;
 b=qnjD2iJUJBlXTDxcg5rmIZuzSTyn45DtXPg8Sd0aF/+rfVzHag6P4W8ThtG4ZGTdvH/CKdRch
 7hdfknuIA21ovIZ/nZ9rfx0DyjnCWSBvSPzVkoSxogJ+QybYVWVS7QkbyUma3iee8EfV2fxtgk/
 uWdMy4ckNcDnXBF0EvL130rC66xiXCo+/UcQTV5uH5NHMiremAavhuqgxg6n+SqPVNvUsIFeMLG
 R/Ugc9oeurwXdtYuG2JI3+pL1NAsk1BoZ3hpRRYabN8Pqp3kjc6rwU8eLoSyiD+q8hvT928H5do
 FgMvomXhhtVIx/Ls+er9vKr09fkeIgYuDPTx9or3M7Sg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 1/2] rockchip: rk3308: Remove OTP device node from soc
 u-boot dtsi
Date: Tue, 30 Jul 2024 14:27:50 +0000
Message-ID: <20240730142751.842772-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730142751.842772-1-jonas@kwiboo.se>
References: <20240730142751.842772-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66a8f87388a51d097cb150f0
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

The merged upstream DT node for OTP differs in nodename and will cause
following build errors once rk3308.dtsi in dts/upstream is updated:

  ERROR (duplicate_label): /nvmem@ff210000: Duplicate label 'otp' on /nvmem@ff210000 and /efuse@ff210000
  ERROR (duplicate_label): /nvmem@ff210000/id@7: Duplicate label 'cpu_id' on /nvmem@ff210000/id@7 and /efuse@ff210000/id@7

Remove the OTP device node from soc u-boot dtsi in preparation for
replacing it with the merged upstream DT node in dts/upstream.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 arch/arm/dts/rk3308-u-boot.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index 684fa7abddb1..b7964e2756f3 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -21,22 +21,6 @@
 		bootph-all;
 	};
 
-	otp: nvmem@ff210000 {
-		compatible = "rockchip,rk3308-otp";
-		reg = <0x0 0xff210000 0x0 0x4000>;
-		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
-			 <&cru PCLK_OTP_PHY>;
-		clock-names = "otp", "apb_pclk", "phy";
-		resets = <&cru SRST_OTP_PHY>;
-		reset-names = "phy";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		cpu_id: id@7 {
-			reg = <0x07 0x10>;
-		};
-	};
-
 	rng: rng@ff2f0000 {
 		compatible = "rockchip,cryptov2-rng";
 		reg = <0x0 0xff2f0000 0x0 0x4000>;
-- 
2.45.2

