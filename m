Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF449D5E38A
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 00:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3CA389327;
	Sun, 10 Nov 2024 01:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yM07aQ8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330068932C; Sun, 10 Nov 2024 01:56:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDFB888D7E
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 01:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f1ff=SF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1731200189;
 bh=As7jrzF0D+apzXoLlkBRx+1aK4eXAV/ydDwbg6tcXkM=;
 b=yM07aQ8i5lFKU6rxgKSy/Wm0aaHAm3QjHytm+LrQOUT1mjQzp3Gf4rFdGbtVoWdeD8tzK88wz
 gF02B2UxIAo2fLz01xPrVWzdwsnz5YJqJjLIcOaGdQ5PrBNE/m0hrWgC7QFQA80ljMj6Np9za6R
 HmQcWFC6vj3wQvJJxDIsy5HcfWrBSqW912MhRu9I6joLqflTWonIF/ac8L//m/NJmkLZ7fxkpCy
 0e2OlvVpVLPGtpX9GEopxqI0Z/6ORbxTNiQKE/UD2vrnYt6YktOOva5SkcH/yZbmTlZeWqeAazl
 nkNM5IkHOc1PO/0nbGSSOz19FWhmYF/28bRK33kY9EJg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 0/3] rockchip: rk35xx: Implement checkboard() to print SoC
 variant
Date: Sun, 10 Nov 2024 00:56:14 +0000
Message-ID: <20241110005622.1515100-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 673004bc1e684d476418c010
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

Information about what SoC model and variant can be found in OTP. This
series use this information in checkboard() to print out the running
SoC model and variant, should match what is printed on the SoC.

There are some asumptions taken on how some of the OTP values are
encoded, however for my boards this seem to match and something like
one of the following is shown with this applied:

  SoC:   RK3566
  SoC:   RK3566T
  SoC:   RK3568
  SoC:   RK3568B2
  SoC:   RK3568J

  SoC:   RK3582
  SoC:   RK3588
  SoC:   RK3588S
  SoC:   RK3588S2

  SoC:   RK3308B
  SoC:   RK3308B-S

Changes in v3:
- Fix build issue with MISC=n or ROCKCHIP_OTP=n
- Remove use of cpu-version
- Use log_debug() instead of debug()

Changes in v2:
- Drop changes in generic-rk35xx_defconfig
- Update code comments
- Add patch for rk3308

This can probably be converted into an sysinfo driver in a future series,
once other pending changes to sysinfo core have settled.

Jonas Karlman (3):
  rockchip: rk356x: Implement checkboard() to print SoC variant
  rockchip: rk3588: Implement checkboard() to print SoC variant
  rockchip: rk3308: Implement checkboard() to print SoC variant

 arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
 arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
 arch/arm/mach-rockchip/rk3308/rk3308.c | 16 +++++++
 arch/arm/mach-rockchip/rk3568/rk3568.c | 61 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c | 52 ++++++++++++++++++++++
 5 files changed, 137 insertions(+)

-- 
2.46.2

