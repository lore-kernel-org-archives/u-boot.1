Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B7AC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 22:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBB3803B5;
	Thu, 23 Jan 2025 23:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Swi8PE3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68A1807A7; Thu, 23 Jan 2025 23:02:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED78380087
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 23:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=331d=UQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1737669752;
 bh=XIS8muewKXU+u0uNNYpU4woEBvSTRlwrWsXXtnUY7fM=;
 b=Swi8PE3rtFbnDr0MhKXFmitI8r6gB8h+AW2fgf5wcs5hG5X/yRzPSt6/6bm9whCtqXDZDFHUH
 5RBXbQ/tHJigIfMo89BtSaLYTcCLCWqoqfZyWOJcU78jhkr1ia52OCXFdcbYhZ3vv9xUS7IjjY0
 CXJQD596PD3Z+JPGP3Jn/72LiIBnAhRNfAcv2BNXUkasFMxlpHj5TF5kbqfgnvYq3AuL8MZHD2G
 kh/smsnndGflzYj1pTo2SFRSLtOshXV3FPOzWhmcj4vAQMsA2slkxqXP6RU+WbrrovxdoIn2Y1H
 Tr7donGmjJMbFqhT/C4+c1iIdjSfIm8U71sqp9oJLqVw==
X-Forward-Email-ID: 6792bc73f07771e5c89df4bc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: sdram: Fix issues observed on RK3576
Date: Thu, 23 Jan 2025 22:02:16 +0000
Message-ID: <20250123220222.3089386-1-jonas@kwiboo.se>
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

Most Rockchip AArch64 SoCs have start of DRAM at 0x0. However, the
RK3576 instead has start of DRAM at 0x40000000 and can extend continuous
beyond the 4 GiB mark.

This series fixes two issues observed on a Rockchip RK3576 board testing
Heiko's RK3576 series [1].

[1] https://patchwork.ozlabs.org/cover/2013854/

Jonas Karlman (2):
  rockchip: sdram: Allow the first bank to extend beyond 4 GiB
  rockchip: sdram: Fix reserve of 2 MiB at start of DRAM

 arch/arm/mach-rockchip/sdram.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.48.1

