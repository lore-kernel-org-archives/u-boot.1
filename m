Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BDDC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1FC84942;
	Tue,  7 Jul 2026 12:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fkXHU+Pk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8855C8498C; Tue,  7 Jul 2026 12:09:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE17846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=990e=FB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1783418971;
 bh=CHX1529WHNwXReodu3F6vKk9v5Iy0aXHqeBjOiyXGDo=;
 b=fkXHU+PkxRDY0XXH2LpyJD3W4QNCvwI9TAT4R3TOHXJu8hib6lRWf0ja4l4fxImfoAWPQBBc/
 wqVccsoNLhGpSCyeVQYHSAaP0lRUb42Kzv1FDD/0OHmudYweCXdiwT+0YaTJj+oWnbaKVzUIZBw
 R6ghTne3DC14ZZjfb/sP+G8dHRLIyaEj3PMANXO0ecFrZAirtEP1M5JvwIye9evWW1tA/E3L27r
 J/rKwaA1ivPaQgv4GvSNmXF7ZXnlInVRIueZZAlYRL5xz9j7SErNYK9aKuODuZ5C/wY6gREVSeu
 iR89Y406cv/8lkRoERtVcK6atmS1X/LrjpdZ5iXPXK6A==
X-Forward-Email-ID: 6a4cd0525f0e2c6e97e6dd59
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.9.9
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH] arm: dts: rockchip: Align OTP nodes for RK3528/RK356x with
 Linux v7.1
Date: Tue,  7 Jul 2026 10:09:17 +0000
Message-ID: <20260707100918.3057718-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

The <soc>-u-boot.dtsi OTP nodes for RK3528/RK356x use different names
compared to the OTP nodes that was merged in Linux v7.1. This causes
build issues when dts/upstream pulls in updated DTs, i.e.:

  ERROR (duplicate_label): /soc/nvmem@ffce0000: Duplicate label 'otp'
                           on /soc/nvmem@ffce0000 and /soc/efuse@ffce0000

  ERROR (duplicate_label): /nvmem@fe38c000: Duplicate label 'otp'
                           on /nvmem@fe38c000 and /efuse@fe38c000

Align the OTP node names in <soc>-u-boot.dtsi with the node names used
in upstream Linux v7.1 to avoid build issues when latest DTs are synced.

Also drop the unused RK356x id@a subnode as it has moved under a
nvmem-layout node in the merged upstream DT.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This has no intended changes and was quickly boot tested on a ArmSoM
Sige1 (rk3528) and a Radxa ROCK 3B (rk3568) board.
---
 arch/arm/dts/rk3528-u-boot.dtsi | 2 +-
 arch/arm/dts/rk356x-u-boot.dtsi | 8 +-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/dts/rk3528-u-boot.dtsi b/arch/arm/dts/rk3528-u-boot.dtsi
index a18d33b3d369..31345df62959 100644
--- a/arch/arm/dts/rk3528-u-boot.dtsi
+++ b/arch/arm/dts/rk3528-u-boot.dtsi
@@ -23,7 +23,7 @@
 			reg = <0x0 0xffc50000 0x0 0x200>;
 		};
 
-		otp: nvmem@ffce0000 {
+		otp: efuse@ffce0000 {
 			compatible = "rockchip,rk3528-otp";
 			reg = <0x0 0xffce0000 0x0 0x4000>;
 		};
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 738b9673d352..d09dab35b31a 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -21,15 +21,9 @@
 		bootph-all;
 	};
 
-	otp: nvmem@fe38c000 {
+	otp: efuse@fe38c000 {
 		compatible = "rockchip,rk3568-otp";
 		reg = <0x0 0xfe38c000 0x0 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		cpu_id: id@a {
-			reg = <0x0a 0x10>;
-		};
 	};
 };
 
-- 
2.54.0

