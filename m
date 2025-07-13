Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58944C83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E75083020;
	Mon, 14 Jul 2025 01:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Fnw8/NSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 319CB830B5; Mon, 14 Jul 2025 01:35:49 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8999E82FCA
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449741; bh=nsDN33xVXwmXffTWbsP66+lzAPXXE3hLjyQ5sFGD130=;
 b=Fnw8/NScqwIJ2AbCmSIIg4T99xZ/xMETgO8FZnP54KP/rP2GuGYnWipL3Kd2M0Nb3T6+iJAq2
 lDGdNIxAu47jBNlU1dGvJH+wuaoFJJMy5MWlYYG4ROFy8NjkuQmgc0HJJ9z5QJQWbpzEkXSOXAH
 bi7o/YUSVR00aCrOTjvnB0XIDPZbcToXnVcApAMOaqckuetakuxAEplilWml4ywOLJBdv6j/NhH
 1E/vGrwUrKePWGumpQ9nf6WDuJYHRqc6m2ootRIWRswaV8r2RC8ODC2aiXLGW+RhtxigL2GJGGu
 aDbFJRs9dyCCDipvdMbdBf0+t4uzkZgGq/UMIjEzbHHA==
X-Forward-Email-ID: 687442ca5c59ddd2f405001f
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 17/17] arm: dts: rockchip: Include OTP in U-Boot pre-reloc
 phase for RK3326
Date: Sun, 13 Jul 2025 23:34:05 +0000
Message-ID: <20250713233429.1376172-18-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

Update rk3326-u-boot.dtsi to include OTP in U-Boot pre-reloc phase for
checkboard() to be able to read information about the running SoC model
and variant from OTP and print it during boot:

  U-Boot 2025.07 (Jul 13 2025 - 10:07:16 +0000)

  Model: ODROID-GO Super
  SoC:   RK3326
  DRAM:  1 GiB (total 1022 MiB)

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This patch only makes sense together with "rockchip: px30/rk3326:
Implement checkboard() to print SoC variant" [1]

[1] https://patchwork.ozlabs.org/patch/2095941/
---
 arch/arm/dts/rk3326-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
index be1dd4f91c1b..6503a9382b9c 100644
--- a/arch/arm/dts/rk3326-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-u-boot.dtsi
@@ -61,6 +61,10 @@
 	bootph-all;
 };
 
+&otp {
+	bootph-some-ram;
+};
+
 &pcfg_pull_none {
 	bootph-all;
 };
-- 
2.49.0

