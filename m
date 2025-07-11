Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7D8C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 22:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97BE082FD4;
	Sat, 12 Jul 2025 00:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UsscmeBc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4CD381FEE; Sat, 12 Jul 2025 00:22:07 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A9C883043
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 00:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2656=ZZ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752272524; bh=FTZehhMC6SWjmBVJM85jhzbhny5eedmZZW3rrRZ9NZM=;
 b=UsscmeBcfCAluNHKtv1AY4R2LRraXbBKqfdmkSv45UdgJSdgJZS14AwNrtKKgSNwVU6dkDsvm
 EZNPlNv8Dy/DC+GCNEEk6aztxnWRh55mK4gm4LDO0vYb6clXNbU5oMm/V0JaaTPDvArHs9b0pBw
 8Hmw14RuuNliznOm0f7BVAOar4QbbzalO8lksclRQTKPwPD291kQVoq5GMeVi1F9T9EszTZMHTe
 jbLp1Tt+TbF/g4u8eD8c5nU4h7rrWdKLu6IJuPSdCsbDahzAhpjs+3vYQz1KxtJvD7OSN+03TeL
 OqIFEmls4wmtivAS4ZTAvvDOQbFen1EFqSq5g/9rNNtQ==
X-Forward-Email-ID: 68718e8826dc7c4d2555fd7d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 6/6] arm: dts: rockchip: Include OTP in U-Boot pre-reloc
 phase for RK3576
Date: Fri, 11 Jul 2025 22:21:21 +0000
Message-ID: <20250711222132.204344-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250711222132.204344-1-jonas@kwiboo.se>
References: <20250711222132.204344-1-jonas@kwiboo.se>
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

Update rk3576-u-boot.dtsi to include OTP in U-Boot pre-reloc phase for
checkboard() to be able to read information about the running SoC model
and variant from OTP and print it during boot:

  U-Boot 2025.04 (Apr 22 2025 - 20:43:17 +0000)

  Model: Generic RK3576
  SoC:   RK3576
  DRAM:  8 GiB

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
index be99a48a630f..fb5a107f47d9 100644
--- a/arch/arm/dts/rk3576-u-boot.dtsi
+++ b/arch/arm/dts/rk3576-u-boot.dtsi
@@ -49,6 +49,10 @@
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

