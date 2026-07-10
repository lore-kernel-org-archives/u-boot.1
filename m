Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490EBC44501
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E058497A;
	Fri, 10 Jul 2026 12:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ATBJhrTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D9948497A; Fri, 10 Jul 2026 12:05:35 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E82684119
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4682=FE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1783677932;
 bh=G/+rLaj9b2BxY1LtVsZPX+W1j1/Kybz7DGwDkJXimno=;
 b=ATBJhrTdXQEUpU+tMzIdtnRqmfKgjMkv8LordRRSQ284uXp19RKi1fmWr+pqGDb3VHk7kpQXe
 5hTuMNZjZa3pFZOZ4SqJHSgWz1RRPMh60SlY1R6sH9+v7EEIchr+GQPJTcIbYIwCFWjCSGM/Ois
 025lM8lKWehw5LlEaCkPlEqJysEe+RH8fyB7ZQx49AWFAVrjFuZ6/M31WBalz6pSKAgcpsinbBY
 vEXOhZ6IJF3a8xS0Dirjb4D6FaUHCoDUKsR+aZsDRQQaHXdi2HZw0kdOAwkClQDzTGs0Uzj+BGW
 3US02D5SPtpF85DTjlH05ddoM97xRRhQ/YXwcQTkzvQg==
X-Forward-Email-ID: 6a50c3e628378fa077a39504
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.10.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/7] rockchip: Enable USB support for RK3528
Date: Fri, 10 Jul 2026 10:05:12 +0000
Message-ID: <20260710100521.3677247-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
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

This series picks USB related DT commits from v7.2-rc1-dts to enabled
USB support on existing RK3528 boards. It also adds required DT nodes
and enables required Kconfig options on the Generic RK3528 target.

The 'Add watchdog node for RK3528' commit was included to fully sync
RK3528 DTs up to v7.2-rc1 state, it is not required for USB support.

USB has been verified working on following boards using both generic and
the board specific defconfig target.

- ArmSoM Sige1
- FriendlyElec NanoPi Zero2
- Radxa E20C
- Radxa ROCK 2F

Please note that the dts/upstream related patches should be applied
after v7.1-dts has been fully pulled into dts/upstream.

Jonas Karlman (7):
  arm64: dts: rockchip: Add watchdog node for RK3528
  arm64: dts: rockchip: Add USB nodes for RK3528
  arm64: dts: rockchip: Enable USB 2.0 ports on Radxa E20C
  arm64: dts: rockchip: Enable USB ports on Radxa ROCK 2A/2F
  arm64: dts: rockchip: Enable USB 2.0 ports on ArmSoM Sige1
  arm64: dts: rockchip: Enable USB 2.0 ports on NanoPi Zero2
  rockchip: rk3528-generic: Add support for USB OTG

 arch/arm/dts/rk3528-generic.dts               | 18 +++-
 configs/generic-rk3528_defconfig              | 10 +++
 .../arm64/rockchip/rk3528-armsom-sige1.dts    | 25 ++++++
 .../arm64/rockchip/rk3528-nanopi-zero2.dts    | 29 ++++++
 .../src/arm64/rockchip/rk3528-radxa-e20c.dts  | 60 +++++++++++++
 .../src/arm64/rockchip/rk3528-rock-2.dtsi     | 17 ++++
 .../src/arm64/rockchip/rk3528-rock-2a.dts     | 11 +++
 .../src/arm64/rockchip/rk3528-rock-2f.dts     | 12 +++
 dts/upstream/src/arm64/rockchip/rk3528.dtsi   | 88 +++++++++++++++++++
 9 files changed, 269 insertions(+), 1 deletion(-)

-- 
2.54.0

