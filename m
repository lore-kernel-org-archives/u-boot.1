Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B9FCCD184
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C7D837B6;
	Sun, 19 Oct 2025 17:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="YL7A5kKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB21D83438; Sun, 19 Oct 2025 17:09:58 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95ABC837B6
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ad34=45=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1760886595;
 bh=fN1zlIgQRFq1ziSKBw2byvNg4y6guhJd007WsOO7yKE=;
 b=YL7A5kKKpmel1ztEzBAd7o9Rn6hRRIR245DayPsH4yqNmFOtyq2OvpzvX2EQdE1bDIUJzz6fP
 3X3Jjl4beMpcncxub3ISL6yIlQNrkol4a3E8H57scsIGJpADkGyKYYmqyhu4girBcdZgBA8vRHs
 U6zla2bvwhvAvs29Cp0CFNtAaty+5o1ko8+gL0G/i6RWs9FcY3EqWS/5w8NuJ9KJUs6XHEfpZ4r
 yNsklfjrNN/ZTYkP2IEr/Ktmg2XYN6z7dG2c/ZRIVKsilvQK9wyblWrTuTqYz8GlQQV78CzOJb0
 vHWBVkyZGN/5LSmyPRPd8H7VtJeRotowGN8jp/2XbZrg==
X-Forward-Email-ID: 68f4ff3f5ea0c67427242914
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: rk3568: Disable USB3OTG U3 ports early
Date: Sun, 19 Oct 2025 15:09:39 +0000
Message-ID: <20251019150945.823167-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.51.0
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

This series adopt similar change to the U-Boot rockchip naneng-combphy
driver as was included in the Linux commit 7bb14b61b7d0 ("phy: rockchip:
naneng-combphy: Enable U3 OTG port for RK3568").

The Linux commit was merged into v6.18-rc1 and has been backported to
v6.17.3, v6.12.53 and v6.6.112.

The first patch in this series should be safe to apply.

However, the second patch may break use of USB 3.0 on RK3568 on Linux
kernel prior to version 6.6.112, 6.12.53, 6.17.3 and 6.18-rc1. Because
of this I think it may be too soon to have the second patch applied for
v2026.01.

Jonas Karlman (2):
  phy: rockchip: naneng-combphy: Enable U3 port for USB3OTG on RK3568
  rockchip: rk3568: Disable USB3OTG U3 ports early

 arch/arm/mach-rockchip/rk3568/rk3568.c             | 7 +++++++
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c | 8 ++++++++
 2 files changed, 15 insertions(+)

-- 
2.51.0

