Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F37D73E89
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 21:02:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF6F84106;
	Thu, 29 Jan 2026 22:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="I0FpROma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87442840F1; Thu, 29 Jan 2026 22:02:15 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0A0840F1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 22:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1769720531;
 bh=/ub3R3B3Gdwsddg+r8LaStYDIgQNIwrfPTBkHkzf5GQ=;
 b=I0FpROmatiVj43/Y02R2r37mLFZqyaeViszmvye36sC2XdCDvZpmD048h1ZpSXnnD6/NBKXj3
 edFve9QjFc3aP9BPPbOHqsKBAblLPofZYMaMyZr/66vOn6u8CrVft/vKAcNdEuXpvi6WjOCC7zc
 4tjxaxyNS45vi4ieHHqhhxue5G2aIytZNpC8K7vp6cFC7Q78nobR567X3VHwf/88fIQu7Zv3Ghy
 1kJ2LRHSJY2ys135vLWhHOMgB3bt/oblNhpsyrXb0zsr/FUTt5zYBOe5SzMc2QJwmma1Posd1gN
 4yo7RfnxgzeZVoqzfL/xhS9bO7VARgFetLS8OqGxvwGQ==
X-Forward-Email-ID: 697bcacd8bac728cb531c66c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome@forissier.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/4] net: dwc_eth_qos: Update tail pointer handling
Date: Thu, 29 Jan 2026 21:01:48 +0000
Message-ID: <20260129210159.2279888-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
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

This series update transmit descriptor tail pointer to be more in line
with the initialization description in the DesignWare Cores Ethernet
Quality-of-Service databook.

The series does not really change or fix any known issue and is more of
a biproduct from when I was debugging and testing Ethernet on a Rockchip
RK3506 board. The issue I faced on that board was instead related to
the SoCs security firewall blocking DMA use out of cold reset.

The last patch is not related to descriptor tail pointers and instead
renames a few "unused" regs, two that is configured by the driver.

Jonas Karlman (4):
  net: dwc_eth_qos: Use lower_32_bits() for tail pointers
  net: dwc_eth_qos: Initialize the transmit tail pointer in eqos_start()
  net: dwc_eth_qos: Start DMA and MAC after tail pointers are
    initialized
  net: dwc_eth_qos: Define more of the unused MAC regs

 drivers/net/dwc_eth_qos.c | 43 ++++++++++++++++++++++-----------------
 drivers/net/dwc_eth_qos.h | 28 +++++++++++++++++--------
 2 files changed, 44 insertions(+), 27 deletions(-)

-- 
2.52.0

