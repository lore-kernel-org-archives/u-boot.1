Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8CEC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1E084AC2;
	Fri, 10 Jul 2026 15:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="VHVqrXrx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F74A84AA3; Fri, 10 Jul 2026 15:17:40 +0200 (CEST)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch
 [185.125.25.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC6284A92
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxXSK3nH7zXh1;
 Fri, 10 Jul 2026 15:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783689457;
 bh=dL/+dJ/N9Xa5WPH+BYh+7VgrnKznYcylulwkIXH7Whg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VHVqrXrxJAh1M2Ru6oI5rqKfoDUwrlTVpxNGwtl9KYcivPGWNsceN9P7+u/ivwEhM
 ofPbFEMLtNIhRM6sop8+RhaTbLP/aJDXBGcJcGXQde8Q2RIeulrd90tnUCF0Dvgtc7
 tGmrUl2czLByqjbfUNNRNKxDycpH83HYCYGHSUNG/z4XU/MIsV6JDla7JcFmpm+5GI
 jYn+DHAzkBMxwmhtBKYQksWJB4HvyZ3DL9stjx4UdcAivu4oaYRlXFncqyBg7xqEWF
 Jus62u/mzVwnZgpQG4g/KmQcgvsRg4C+JDsNoRhMyyXWodQJQUCY5k9ZKSD9d3/eoQ
 RQfcbtVlNBq1Q==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxXSJ1V2hzdmB; Fri, 10 Jul 2026 15:17:36 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Joseph Chen <chenjh@rock-chips.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Johan Jonker <jbx6244@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
 Liangbin Lian <jjm2473@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260625125818.18914-1-jjm2473@gmail.com>
References: <20260625125818.18914-1-jjm2473@gmail.com>
Subject: Re: [PATCH v2 0/1] rockchip: rk3568: Add support for LinkEase
 EasePi R1
Message-Id: <178368945618.879692.6882293803347985405.b4-ty@b4>
Date: Fri, 10 Jul 2026 15:17:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
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

On Thu, 25 Jun 2026 20:58:17 +0800, Liangbin Lian wrote:
> LinkEase EasePi R1 [1] is a high-performance mini router.
> 
> Specification:
> - Rockchip RK3568
> - 2GB/4GB LPDDR4 RAM
> - 16GB on-board eMMC
> - 1x M.2 key for 2280 NVMe (PCIe 3.0)
> - 1x USB 3.0 Type-A
> - 1x USB 2.0 Type-C (for USB flashing)
> - 2x 1000 Base-T (native, RTL8211F)
> - 2x 2500 Base-T (PCIe, RTL8125B)
> - 1x HDMI 2.0 Output
> - 12v DC Jack
> - 1x Power key connected to PMIC
> - 2x LEDs (one static power supplied, one GPIO controlled)
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2026.10), thanks!

[1/1] rockchip: rk3568: Add support for LinkEase EasePi R1
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3a8b3cdd83a3247d23f59f8c75eaf4e917b7f0b6

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

