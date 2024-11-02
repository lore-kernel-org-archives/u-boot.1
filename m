Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BDBE6780C
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 20:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BC6890B9;
	Sat,  2 Nov 2024 21:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fbdOcris";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05B8E890B9; Sat,  2 Nov 2024 21:38:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AF688F50
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 21:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730579874;
 bh=W36EbmZ76ZJGrqV6qVHEJFCZfy4+bV0JzfUUyc7j07k=;
 b=fbdOcrishcuIjEMQfWdRZ2N3juLSyDsjcdxIZWtABcJbq5WOGRkemoDE3rB7wyCF7ThVKy+dT
 c7hmQ45PsSIgF0451FFzWdHvKTozc2yboIBVkWWzeqGMNKOiNWE2hb4DhF5xCaz+7HCRixs3C9Y
 E8pCHpk/uz6dwbW0IzGOnCJmTU6XJ1QM0p87EM1MDX0fcoZg0ThsdGMGcWxEURHHXYq6g1UAQFr
 pJOeE6A4qh5UcE9WyxeNtsKpArTrJZkS56j/x4HWKmsF2kmATa21GQ4lC5k+IRjd5nyUc/lYWs5
 ZkUzFFyecc0jBwkPEBNPHMQ4yFlE5v296T+eQLpXqYFw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 0/3] rockchip: rk35xx: Implement checkboard() to print SoC
 variant
Date: Sat,  2 Nov 2024 20:37:38 +0000
Message-ID: <20241102203746.3631481-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67268da1922720f2eae901f9
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
one of the following is shown with this applied:

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

  SoC:   RK3308B
  SoC:   RK3308B-S

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
 arch/arm/mach-rockchip/rk3308/rk3308.c | 16 ++++++
 arch/arm/mach-rockchip/rk3568/rk3568.c | 67 ++++++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++
 5 files changed, 149 insertions(+)

-- 
2.46.2

