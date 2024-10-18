Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93EFD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0580488C4D;
	Fri, 18 Oct 2024 18:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bpi1cO2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D334088DFF; Fri, 18 Oct 2024 18:34:41 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D7188D9F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9e6c=RP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1729269270;
 bh=+z1N6P7RdA1gKSddjQyetKrQNXp5moWluKHHND6gvJc=;
 b=Bpi1cO2ExofNFPZ3s2n2hsLn59DdCMqhLB8z4koSktUlgba3hTeJYASQtwdC+agR4FMYjbCQm
 +h1Th+ZmAzBRS/QCoVnfQXWUjn8qQmssVvRBGHQbvqRsHbRbUeSiAHd6pSrFhWbW+yE7ivM3f2H
 wGmB4E3Zr/wgQCr83b+hOIRdZmkR1+V29KIJsEMlFf57LGX/6jB9M3isp6rbOyY6hQn9JIF1h5e
 qfPo/bOct8En5YrTm1o709zSmNkZ+6axmf8WAyvjG0X4gP6t6AL+lYR/ihdmLdJ7D3SgBj/0zA4
 /s4mBF8QajgjwW/c7gh8mwd0+UTkr1jymI29Wpfa0uUw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: rk35xx: Implement checkboard() to print SoC
 variant
Date: Fri, 18 Oct 2024 16:34:16 +0000
Message-ID: <20241018163423.1562287-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67128e153b4db30540b6b5bb
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

Information about what SoC model, variant and version can be found in
OTP. This series use this information in checkboard() to print out the
running SoC model, variant and version.

There are some asumptions taken on how some of the OTP values are
encoded, however for my boards this seem to match and something like
the following is shown with this applied:

  SoC:   RK3566 v1
  SoC:   RK3566 v2
  SoC:   RK3566T v2
  SoC:   RK3568 v2
  SoC:   RK3568B2 v2
  SoC:   RK3568J v2

  SoC:   RK3582 v1
  SoC:   RK3588 v0
  SoC:   RK3588 v1
  SoC:   RK3588S v0
  SoC:   RK3588S v1
  SoC:   RK3588S2 v1

Jonas Karlman (2):
  rockchip: rk356x: Implement checkboard() to print SoC variant
  rockchip: rk3588: Implement checkboard() to print SoC variant

 arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
 arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
 arch/arm/mach-rockchip/rk3568/rk3568.c | 65 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c | 56 ++++++++++++++++++++++
 configs/generic-rk3568_defconfig       |  2 +-
 configs/generic-rk3588_defconfig       |  2 +-
 6 files changed, 131 insertions(+), 2 deletions(-)

-- 
2.46.2

