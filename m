Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589CEC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 23:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548A8805C2;
	Mon, 10 Feb 2025 00:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yOPJehL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABED2809D4; Mon, 10 Feb 2025 00:28:18 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2063B80548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 00:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e522=VB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1739143694;
 bh=M801Y+dUBabOaN7r37FoueNBafXOUo7UUR07E1wP4NM=;
 b=yOPJehL7PZ5EjTMDSsHNrtn0D9pnGhV2t6z9QNbmfRu9GVc+e/YnDjvQAhJ9f0j8wCIjjZVxm
 D4JQgtmT/qPtP8pZwraV2uU9hN/FgY4JEWubmqdV3RSr+mZgpNL+JsFp1y7Sl6V7EY4/Sra8xvv
 Fp+BX0hQPYaD3TCjSqIj7KiegZ6sVtMK2WFqMk2VVs+Hy20fviycI9301PM8QpJGhBBzY7ErXG+
 RG3un+vT2cU3K6NmtXSyTPmw8nKAw2+p4WVthqh6FdiNxaQb77BtvUNb0tEoJoL6ah1smWQhBuo
 jov4OcBbFIDi7j17cdt6ubHGfn/aDGCXwYVmPi7+vJYg==
X-Forward-Email-ID: 67a93a066e258c2c4c42a4f4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] net: dwc_eth_qos_rockchip: Fix disable of delay for
 RK356x and RK3588
Date: Sun,  9 Feb 2025 23:27:54 +0000
Message-ID: <20250209232801.3185681-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

When rgmii-rxid/txid/id phy-mode is used the MAC should not add RX
and/or TX delay. Currently RX/TX delay is configured as enabled using
zero as delay value for the rgmii-rxid/txid/id modes.

This series change to disable RX and/or TX delay and using zero as delay
value for RK356x and RK3588.

Jonas Karlman (2):
  net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay for RK356x
  net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay for RK3588

 drivers/net/dwc_eth_qos_rockchip.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.48.1

