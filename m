Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A91C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8582160A35;
	Thu, 23 Jul 2026 15:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btkuwZfrde3d; Thu, 23 Jul 2026 15:04:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3FA560A3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819087;
	bh=qrB8e4dGpQLPMRG5juYKr42aRFZtkGNyOCGL9svrNvc=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uQXY7f4uT3DoeAMj1oBCIX5O+5Pjm+ekfnhsX/ZLsI6neZpddJrPB0NdEHc9S8wmA
	 I6AG1iO9sn84LSnLVPTNhej9ibQKKL6OYtg+wU/6ybwcirlbBvIs/8Eeq+9PS/2xBZ
	 bcUjW4U6F5B0Ed3VykIk8QzEwenAnJ+5dlCZFAnRpYhyuMH0z8wooQaPz6Yy0FhuNd
	 O1lSxOYj0FgN9Uzf8dJDGHcpQgLGdEWuNtCQteQUiqIK11uKU9yMNWNd1cpgFbEz54
	 KfOiwjJqzpFCVrFBs0OS/rYTzJp8Q21KkDt9QWx+q2SmvFGiI/Ms9SQguRNtKFa7mc
	 e35RIPyJIASzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3FA560A3D;
	Thu, 23 Jul 2026 15:04:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59FA536E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F9E860A3D
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdl1kDih9uXj for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:04:45 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 081F960A35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 081F960A35
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 081F960A35
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:04:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E3E80287; Thu, 23 Jul 2026 17:04:41 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E7080087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:04:38 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so1528583a12.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784819078; x=1785423878;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qrB8e4dGpQLPMRG5juYKr42aRFZtkGNyOCGL9svrNvc=;
 b=atAvKJq3AzdQWjyLzDZhMc+mgFrvKXF3iijVQy0m5C5hw59OLqb/mKevCVpf5EXlcD
 f/2xsgAFDsY2ePaZiIv8QXFFBorsrI8nxP3Z9mGuWIz4Uz0eT1Ixh5V2GkRCGDHrUCF6
 ao7JdOVxlxHJ/2UD4gqLBs+wOJ/BSWkSy3vzmREp5mO6VArp7oRe4j0Z1NidhwHFOqda
 QNCXKEfLNwEya6oOGdRgU5DvzNcVz8R01F3iXPWOSDAFsD0ovlIMgPvg+KHpe49Bw5eJ
 HgwsehHW/l5YLMK52t/O7HB3i6O6JkLPLMUSQ2VzD2M6WnzAC+fQK9ZRJ4WznSG1gvbh
 jT8g==
X-Gm-Message-State: AOJu0Ywoo0XiZtpyb1bfYliwe+rdCCDhm2+EA3OgqBIImdPj2qhdESl0
 ZFhFUEy1ZXFcJDAZHIvJ+RvUgp7wyp/2vpwhYDBY3pUUrt+BU/+xWE83iQv/JCvnD6o=
X-Gm-Gg: AR+sD13nE1UJKWKfxGmX9w9EYRDv9sSoECTPupMVidYSfGsrsY63NfancHiepE2cJT9
 D7T2JkWS85+ocEUKmegSfiVDWGvx/1IjLmUATN/puAvmR3fx2vIEmdc9IAfVkheopoqROXHnkUC
 OE6KhvmwA4O4DVHLRm+hztYatebwTnoVpzrsihEUuzZqms2ySB6uZbBYdwAu5BJUMm8pk6xquVD
 10AV6mQrwTcV9I/iJEc4lSHuHXHBzgXPX0KhcmIPs6sFcodivlpSjnGAvfCYeXYUQ/x0bwUCp0q
 CdHWEjAQBH1jFJmcuiURHcPBEaIRvkorRc2MJmggaHJzEXuhV2HkhEwNQfxlq1FfSmp744/Er2Y
 t+onz548XUSVr+xtzsouTq5ea2EaOwBQAx3YPHtwsTvJb24G7WkEGyrydY3Cxw+d9PWzF6I2ZM3
 JG5HDUR9hiXlxZ0dVs8dUoLg==
X-Received: by 2002:a17:907:3cc9:b0:c19:5d7c:ae72 with SMTP id
 a640c23a62f3a-c1c50d1cf84mr162147766b.32.1784819077850; 
 Thu, 23 Jul 2026 08:04:37 -0700 (PDT)
Received: from alchark-surface.localdomain ([193.32.126.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32f1127fsm248769566b.55.2026.07.23.08.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:04:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v2 0/5] clk: rockchip: pll: fixes and simplification of
 maths in RK3588 frac PLL
Date: Thu, 23 Jul 2026 19:04:22 +0400
Message-Id: <20260723-rk3588-fracpll-v2-0-382d113f3a80@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2po+1Dau+A/DAspURgk0U2w0h
 H8XcO3yJOeeO0NCJkxwLWZgzJRoHFbQhwJ8Vw93FNSuDFrqi7TKCH6as3MicO1j3wvbGFTBKet
 tC+soMgZ678Fb9eP0ah7op62yGR2laeTP/pjV5v2NZyWk8G042aB9LRtXhp5iRD4OOEG1LMsX8
 Wm63sAAAAA=
X-Change-ID: 20260713-rk3588-fracpll-7b3e1f817c7d
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Ma2z7lLebqR+ImpWIluo77qZNYvB70lEflwiMpQiOKw=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQl6Vb7365Jtd0dvGam4SLGiXeyouTEp2+JT+9XuT1f3
 Xl5ftzPjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKY6jYPhf1GW9sN/bTMXGrXca3qd8kzkcuKiK88KI3f91jXdyrLeoo6R4YdDrfi
 FxG8T2pT3nJV6r/p50YNgfk8X1bPf81ii40I+8gAA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1784819078; x=1785423878; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qrB8e4dGpQLPMRG5juYKr42aRFZtkGNyOCGL9svrNvc=;
 b=eJQK7ioXU+MgpOX6+RzJPH+8jqU8YKbZJNOqR9QhytIxqGyiy7P9y5u54VrBsdArq1
 uuvCql1bW51ZOy3R+6ijLyfL5Gz683u7J9UKHtPDN4Bgjx2ZwWNZDecZPcN4fKqLgBp0
 BACSQxxu0Qw6cYHDbcJt+n6Vgf6FP7IaZLULbOXLhS/6gM0if+fa5jdYG4yHgVWfBPM7
 hqY7WtSCEPMWT3zKYKCXTtlDCJOeu39jcfRvnkp9RaT/LL+OWKyX8sB0K91ymC0m1vWD
 iTOk9s0LkBqnoLupIpHNlK/uqpVCaz9NNo/TtWoG/7cBfQ137Z+jm/RU58m84Y2yy9dR
 I8Ag==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=eJQK7ioX
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alchark@flipper.net
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=flipper.net header.i=@flipper.net header.b="eJQK7ioX"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Current fractional PLL code for RK3588 (also applies to RK3576) has two
issues causing it to overshoot the requested frequency for some negative
values of the fractional coefficient: one due to rounding, the other due
to treating -32768 as an invalid value where it is actually valid. It
also overflows the calculation of the fractional PLL rate when reading
it back, causing the function to return wrong PLL frequencies for non-
trivial values of the fractional coefficient.

Fix all three, and also use native signed integer arithmetics to avoid
manual bitwise operations on the unsigned representation of the fractional
coefficient, which simplifies the code and makes it easier to read.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v2:
- Pass a pointer to the full table entry to rockchip_rk3588_pll_k_get()
  to make it the single source of truth for both m and k in the fractional
  PLL auto-calculation path (thanks Quentin)
- Do the unsigned->signed conversion in a single patch instead of
  scattering it across several smaller changes (thanks Quentin)
- Use s16 to hold the value of k in the rate table, in line with what
  the hardware uses and also with my similar change submitted to Linux
- Add a comment in code with the actual clock rate formulas for easier
  future reference
- Link to v1: https://patch.msgid.link/20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net

To: u-boot@lists.denx.de
To: Elaine Zhang <zhangqing@rock-chips.com>
To: Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Finley Xiao <finley.xiao@rock-chips.com>

---
Alexey Charkov (5):
      clk: rockchip: pll: drop misleading fout in rockchip_rk3588_pll_k_get()
      clk: rockchip: pll: fix rounding of negative k in RK3588 frac PLL
      clk: rockchip: pll: fix RK3588 frac PLL result for k=-32768
      clk: rockchip: pll: let rockchip_rk3588_pll_k_get update m directly
      clk: rockchip: pll: fix overflow and drop manual two's complement on RK3588/RK3576

 arch/arm/include/asm/arch-rockchip/clock.h |  8 +--
 drivers/clk/rockchip/clk_pll.c             | 86 +++++++++++++-----------------
 2 files changed, 41 insertions(+), 53 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260713-rk3588-fracpll-7b3e1f817c7d

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

