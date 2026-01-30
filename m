Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A526D73E87
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 00:29:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19FB8413A;
	Fri, 30 Jan 2026 01:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rbnwfCiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 329DA8414B; Fri, 30 Jan 2026 01:29:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9874184114
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d4a6=AD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1769732988;
 bh=WNGjpiQDOGVT9sFG7p9Vvp2KrZTyr41Q2glhBqBrpYA=;
 b=rbnwfCiKU3ZFyZenmm5SWPs2HWEKAqkbqaKfxE2ZsTOtnZNNKYpcmnljtz7kmzJF9YN3Bti0f
 SPbSC4+JgW2fkxM/DHUrS5SrVxaKSNAPydmheVbQLApeomEGlB6Eu0ff35Vc3oXkbA2AU04hy1l
 AEUfKfAvIZewL1YQJgA0U99F+N4GWfOl4SKQDSPJgUqaxqRHpL/pMXSpx826oJnSQKrfvrYqeB9
 K21bB4eEbvEDpPvKYuCy52r19g1v0RlUAQDxlmdpg25H24u/3SRVjf7uziOfqB8GyhLEyRkGD2U
 ziy48xAOZYBg1PsczUabOvTIrr9hYitmjUlNGGrZLwAA==
X-Forward-Email-ID: 697bfb785af568bba11df3aa
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Marek Vasut <marex@denx.de>,
	Tom Rini <trini@konsulko.com>
Cc: Khoa Hoang <admin@khoahoang.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/6] usb: eth: asix88179: Use a fixed URB buffer size and misc
 cleanup
Date: Fri, 30 Jan 2026 00:29:25 +0000
Message-ID: <20260130002941.2336252-1-jonas@kwiboo.se>
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

This series fixes an issue resulting in unusabe Ethernet thanks to use
of large URB buffer size. It also include miscellaneous cleanup and
refactor to make the driver closer match the Linux ASIX AX88xxx driver.

The URB buffer size change patch is the only patch that was needed to
fix the non working Ethernet issue observed on a Rockchip RK3528 board
using a UGREEN USB 3.0 (AX88179B) or UGREEN USB 2.0 (AX88772E) Ethernet
adapter. Remaining patches is a biproduct of debugging that issue.

Jonas Karlman (6):
  usb: eth: asix88179: Use negative ECOMM return value
  usb: eth: asix88179: Use a fixed URB buffer size of 16 KiB
  usb: eth: asix88179: Make functions static and align params
  usb: eth: asix88179: Refactor asix_send_common() to closer match Linux
  usb: eth: asix88179: Refactor ax88179_eth_recv() to closer match Linux
  usb: eth: asix88179: Add read_rom_hwaddr() ops

 drivers/usb/eth/asix88179.c | 134 ++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 66 deletions(-)

-- 
2.52.0

