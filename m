Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4B9C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:04:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB4EF409FC;
	Thu, 13 Aug 2026 17:04:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wybx7Gj3AMWs; Thu, 13 Aug 2026 17:04:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED3B4409F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786640649;
	bh=TOLOuS9hMrTzv+mBMS9SqAQzKSjU3xub5WvcWsB10+g=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=K52nw6ICNkfMS3Gu+47X1nlevGCELCmZqqaRkrjINeK1KHfXKBuewnX8holgT06sF
	 tu2yhBVkFOwzNNbTJmligVw288TPJMkYIG1ascS2hSZv3atdpaTn/kCt38iXR4nGkJ
	 4VzFcsYQuxlOBcAUIezKj38Sbm1RXapyiZBAKkltLpJZriSOkZlF6d3Ic2OXtF2rai
	 shDMsBmMccbq4BIAnnjs5kyj6fIiqwFJ8xqV/7oR87lKvr4/RxnKpXpcFcZTlVEFIG
	 mjbnMGlmRpLr2bwwFDiAvLdbZ3ULjCzOotTT6m/iTTTTWikVf1p1TEyM1wxpr1eJ5o
	 wLLVq12X+HT9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED3B4409F3;
	Thu, 13 Aug 2026 17:04:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E4BEEC
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:04:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3046840158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:04:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bkqDIGMqor4M for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 17:04:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.166.143.170;
 helo=smtp-8faa.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D506140061
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D506140061
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [83.166.143.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D506140061
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 17:04:05 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hLWsv3ZQZz4ZH
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 19:04:03 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hLWst6VYYzj1s; Thu, 13 Aug 2026 19:04:02 +0200 (CEST)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2027.01-20260813 into next
Date: Thu, 13 Aug 2026 19:03:42 +0200
Message-ID: <20260813170348.344977-1-u-boot@0leil.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786640643;
 bh=TOLOuS9hMrTzv+mBMS9SqAQzKSjU3xub5WvcWsB10+g=;
 h=From:To:Cc:Subject:Date:From;
 b=bP9dSQ6QDHK4B8Kib+SZ43DrBAeVLXZuIh/hu23YgVkRoal/59p7F82mxCWfWODGw
 NkRLwY+X9TMviJcNmwSttlxZ32won1jOvF0CZOWbUQuKTD56eoJKOMg3F5vFu2S0Hb
 crdL3ber1t116PQxU4IyzkRTaSkAqCv5KZuuaWQStvE+8wDoFEn1tBQjirXEY5gPKP
 9Xs8HeLFwvBU6dho0gb602JMiDVR927iHacHX1lKbrF1aYv7sHqBuBhAn/VCSYGXJ5
 DeMyr+rB0dKqIN426Y77ElpIg6Qr3KpELqKJ7H1bvsQ7Awg0Os5hBj/tpxP8TSJRpq
 lrMh4iCSep13g==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=bP9dSQ6Q
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/975

The following changes since commit 5a92645e1f9020d24d19e03fff2ae63f30080770:

  Merge patch series "Add eMMC support for Axiado SCM3005 board" (2026-08-11 14:55:40 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2027.01-20260813

for you to fetch changes up to f75a3d96e1f33c1b8737018843b7bd5fc207b9d4:

  clk: rockchip: pll: fix overflow and drop manual two's complement on RK3588/RK3576 (2026-08-12 16:55:03 +0200)

----------------------------------------------------------------
- Drop redundant OTP nodes from RK3528/RK356x since 7.1 DTS sync,
- Enable USB on RK3528,
- Add support for another SPI chip on Radxa Rock 4D,
- Fix fractional PLLs on RK3588/RK3576,

----------------------------------------------------------------
Alexey Charkov (5):
      clk: rockchip: pll: drop misleading fout in rockchip_rk3588_pll_k_get()
      clk: rockchip: pll: fix rounding of negative k in RK3588 frac PLL
      clk: rockchip: pll: fix RK3588 frac PLL result for k=-32768
      clk: rockchip: pll: let rockchip_rk3588_pll_k_get update m directly
      clk: rockchip: pll: fix overflow and drop manual two's complement on RK3588/RK3576

Jonas Karlman (8):
      arm: dts: rockchip: Drop OTP nodes from u-boot.dtsi on RK3528/RK356x
      arm64: dts: rockchip: Add watchdog node for RK3528
      arm64: dts: rockchip: Add USB nodes for RK3528
      arm64: dts: rockchip: Enable USB 2.0 ports on Radxa E20C
      arm64: dts: rockchip: Enable USB ports on Radxa ROCK 2A/2F
      arm64: dts: rockchip: Enable USB 2.0 ports on ArmSoM Sige1
      arm64: dts: rockchip: Enable USB 2.0 ports on NanoPi Zero2
      rockchip: rk3528-generic: Add support for USB OTG

Martin Herren (1):
      rockchip: rk3576-rock-4d: Enable XMC SPI chip

 arch/arm/dts/rk3528-generic.dts                    | 18 ++++-
 arch/arm/dts/rk3528-u-boot.dtsi                    |  5 --
 arch/arm/dts/rk356x-u-boot.dtsi                    |  5 --
 arch/arm/include/asm/arch-rockchip/clock.h         |  8 +-
 configs/generic-rk3528_defconfig                   | 10 +++
 configs/rock-4d-rk3576_defconfig                   |  1 +
 drivers/clk/rockchip/clk_pll.c                     | 86 +++++++++------------
 .../src/arm64/rockchip/rk3528-armsom-sige1.dts     | 25 ++++++
 .../src/arm64/rockchip/rk3528-nanopi-zero2.dts     | 29 +++++++
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts       | 60 +++++++++++++++
 dts/upstream/src/arm64/rockchip/rk3528-rock-2.dtsi | 17 +++++
 dts/upstream/src/arm64/rockchip/rk3528-rock-2a.dts | 11 +++
 dts/upstream/src/arm64/rockchip/rk3528-rock-2f.dts | 12 +++
 dts/upstream/src/arm64/rockchip/rk3528.dtsi        | 88 ++++++++++++++++++++++
 14 files changed, 311 insertions(+), 64 deletions(-)
