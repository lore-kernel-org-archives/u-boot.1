Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2A5C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 00:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A114D88249;
	Sat, 20 Apr 2024 02:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="PAqoG06C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF93488249; Sat, 20 Apr 2024 02:03:38 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E479188249
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 02:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1713571415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ifCV94iRVQ0QjObS5H6CdCBsKDC5BETqJsXgh1EZeTE=;
 b=PAqoG06C0H2RKTu9Tqn8lStsAiqUzVp7tQNN2NXyarjFxmEso7piaNS+IscgnY5AEO4MCA
 lZJEvQ2vGpNE1usO9MiG5SsaxFODXmXCuBw8dP4JDFVN9yY2ez+ydTMXegHlLJncvczHm8
 2SV3E5hbnx1WSKc1wy0ieEv3eS+sBve/YG5W3HxrLUah8Q+yjutPUOgndqrfsw8BaisUhF
 N9BvS/fzzv5w+4W2JWDbbXanOXOsuCa0wXEkaGeRF50gdXfCwdOuDhEDLCjX0vzd7liUwY
 0+8X6P0bT/peadnIWKpacf39wLWz2ZimopVpKlzJHAd6OdfCEhqvv6QG9KYq6w==
From: John Watts <contact@jookia.org>
Subject: [PATCH RFC 0/9] sunxi: video: Support LCD and HDMI output on H6/D1
Date: Sat, 20 Apr 2024 10:02:33 +1000
Message-Id: <20240420-d1_de2-v1-0-297efca674ba@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoGI2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyMD3RTD+JRUI13LpFQLwxRTs6QUC1MloOKCotS0zAqwQdFKQW7OSrG
 1tQA9Rrk/XQAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1713571359; l=1751;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=hGtiB0fr+Lghf9puJiVsbIcm4PbNKzzptfs9wiXnxuc=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAXuI3QTnJVvwpZCzKEENRhmL
 TjRQIoKQmugUdJdcb+qU0oOy+CnuaAigMRIU4/1zAm58WgkMJI8f1StlD5FvEAgUAAOoR
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

This patch series is my first attempt at supporting an LCD panel on the
T113. I can confirm this specific use case works, but I've added code
for the H6/H616 too in the process as a lot of the logic is the same.

I've also included an untested patch for HDMI support at the end in case
anyone wants to work on it. It compiles and looks like it should work,
but I haven't ungated/reset the slow HDMI clock, or HDMI sub.

Signed-off-by: John Watts <contact@jookia.org>
---
John Watts (9):
      sunxi: clock: support H6/D1 video clocks
      sunxi: ncat2: Specify DE2 and LCD0 base addresses
      sunxi: sun50i-h6: Specify DE2 and LCD0 base addresses
      sunxi: video: support LCD on H6/D1
      sunxi: video: enable DE2 on H6/D1
      sunxi: video: silence unused use_mipi_pll warning
      sunxi: video: dummy out HDMI on H6/D1
      sunxi: Enable display engine on H6/D1
      sunxi: video: support HDMI on H6/H616

 arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h | 65 ++++++++++++++++++
 arch/arm/include/asm/arch-sunxi/cpu_sun50i_h6.h   |  3 +
 arch/arm/include/asm/arch-sunxi/cpu_sunxi_ncat2.h |  3 +
 arch/arm/mach-sunxi/Kconfig                       |  2 +
 arch/arm/mach-sunxi/clock_sun50i_h6.c             | 81 +++++++++++++++++++++++
 drivers/video/sunxi/lcdc.c                        | 23 +++++++
 drivers/video/sunxi/sunxi_de2.c                   | 18 +++++
 drivers/video/sunxi/sunxi_dw_hdmi.c               | 77 +++++++++++++++++++--
 drivers/video/sunxi/sunxi_lcd.c                   |  6 +-
 9 files changed, 270 insertions(+), 8 deletions(-)
---
base-commit: 1f1bbbdf85b67316770a6964a4a02b73a720a167
change-id: 20240420-d1_de2-9be81d56bd85

Best regards,
-- 
John Watts <contact@jookia.org>

