Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C2DC25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 03:55:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1AAB884BE;
	Sat, 18 May 2024 05:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="zgBt//yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0F2884AC; Sat, 18 May 2024 05:55:14 +0200 (CEST)
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com
 [95.215.58.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A6D884BE
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 05:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Envelope-To: contact@jookia.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1716004509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NKCDMjYeGS9diSVEsecNUZnlb4Z0QpuNFm5YbcSwXic=;
 b=zgBt//ylrlYgttzyexu5/JAvjNN0m1UGJuxqsRS9+2giXbP766MACBEd4p00KSmbsMpL14
 kML38+OTO5FiExIMHuDDuBGC34Ears+uXz3oTzmtmANn7QD6/eyTBrzEVsj82IdLgQsoD3
 NJ3EOr8AWJBLqciBMTfLHtTHTAln6ECo6GlKoQoGGc3lbq98RkykubZRG5kKZR9rbzMe10
 FYy/csp7gHautyEfpHWeE69IZwXyU2GI4qPMyZ6YPr6LsmCUj8xMGk/WN+RfwkReD/BFGL
 u0rNNKa51cB1zIWNsFfkHnp8fZ/LVh0q+ZgozW7UeAei1ZD0SP4yhAGwhVy6uw==
X-Envelope-To: lukma@denx.de
X-Envelope-To: rick@andestech.com
X-Envelope-To: seanga2@gmail.com
X-Envelope-To: ycliang@andestech.com
X-Envelope-To: sumit.garg@linaro.org
X-Envelope-To: u-boot@lists.denx.de
X-Envelope-To: trini@konsulko.com
X-Envelope-To: andre.przywara@arm.com
X-Envelope-To: jagan@amarulasolutions.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
Subject: [PATCH RFC 0/4] pwm: sunxi: Add support Allwinner D1 PWM
Date: Sat, 18 May 2024 13:54:42 +1000
Message-Id: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIImSGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0ML3YLy3PgUQ90kE+MUIzPj1ERDE2MloOKCotS0zAqwQdFKQW7OSrG
 1tQDl83OQXQAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1716004483; l=1198;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=vJ+DS6h4tqBT8vnFYQWxEIjg7D7ds9bw5fnoJD2HxsA=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAf4pg2RUU6JZ8y66oL7LNur8
 sc3ChgAgY0B4kR3+Njr8y4Z6PM2rRj/CNsPBlTo2KBlWuS7EZkXQR/AZ5BtOUCQUAAPQ8
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This patch series adds support for the Allwinner D1, T113 and R329 PWM.

This code isn't based on any kernel code but instead written from scratch with
the goal of handling the PWM pairs deterministically.

I've tested this on T113 hardware and it works very well.

Signed-off-by: John Watts <contact@jookia.org>
---
John Watts (4):
      clk: sunxi: Add PWM bus clock and reset
      pinctrl: sunxi: Add PWM7 pinctrl for the D1
      pwm: sunxi: Add support Allwinner D1 PWM
      [FOR TESTING ONLY] sunxi-d1s-t113: Add D1 and T113 PWM node

 arch/riscv/dts/sunxi-d1s-t113.dtsi                 |  12 +
 drivers/clk/sunxi/clk_d1.c                         |   4 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   1 +
 drivers/pwm/Kconfig                                |   6 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/sunxi_pwm_d1.c                         | 542 +++++++++++++++++++++
 .../src/riscv/allwinner/sunxi-d1s-t113.dtsi        |  12 +
 7 files changed, 578 insertions(+)
---
base-commit: 312efdf9c9297382b4e1d04c50376573764b5c00
change-id: 20240518-pwm_d1-b43d263ea143

Best regards,
-- 
John Watts <contact@jookia.org>

