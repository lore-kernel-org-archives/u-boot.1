Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36495CA5FF0
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 21:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D837E80BEA;
	Sun,  4 Oct 2026 21:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FT1PHnKgW0kC; Sun,  4 Oct 2026 21:53:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 28A4A80BCE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791150807;
	b=ZFGiIuHwwnZJYOq/Zo9sihqsdhxeLbaS6kryrYvkuDy6THjXfM5CyBntkAVhgf3M3Z9I
	 zM2K+wkkhDLB2+xpxtnl48Ygia5qZFNpAWMJ9CTvX45Eo7ZyW/2zGSkoBc73MboAeHF1l
	 o+z5XRLwg4Vk1jIGVzxzXobiNd/RA7AtdpK6WnDxLQBuQHW5DYxORACRwOH/W1UA43PxO
	 jpruld5k6UYX0vIs8068cC9HT+DtCNPUkIwA9PYhwm4wMans5E8/BtGIoO5k8RPfszBk3
	 iBWdFLdtvlYDkD8qCRBiT3yjWPzWlgeKzCOoX2Ma4fgznQHXAQXLzurZ73UNnGbJVNg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791150807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BsNLsFmdze99KmEoA3KO0Jkkql0IIr6SoR2tGuGvcRI=;
	b=DbbT5TBw3ckBqrLo++wA+eu/6wmyOGJ0zeIFiiWP46+rsM3ZJm2U1nT99UYBrnthPMfk
	 yaHFsygNXt536Tvh77J/BuMPV4usZjsjP3b7RER1H5HtEVGoHyljUI4YqJrAlwfnn7eRc
	 A4iGIjIeDJuLrT1cjzl0+NHqJzmO9wje1y5sVYs0XY+UuGz8oawOAhyNXFx2faAnMZquY
	 y9xiA8uq+PnIF6uZdbOQZWaGmY1+6TCv17VupJ5sJAns4oF4Qr6CwJ2q/rdJN6msEbIPa
	 Y0zk+mZ+3REo3luUX9knz30vZ2JiaW0dhX9mNUs8d0SkF8PNA91T40DIx+9jkoSIlMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791150807;
	bh=BsNLsFmdze99KmEoA3KO0Jkkql0IIr6SoR2tGuGvcRI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=z26y2HB6dZh4kMpeKLBzLpXmP/KskFTEc4W3fqThnZoEc864cnGzeqo31LjlpkxJi
	 wf9qsnd1dOKWmw9foxeGlvZqD/f6a1v2FeusZT9Cx3NHsfD7B1SwmTpT9xJJLH7Zxy
	 wGcFNt/MJ0WOggPJRc+LERvYw7cIORntUllbo0CwegXKb6bpHtZcWawo//O1mXzYyr
	 k+nHM1NJeULgvTNyMo9Gy4LCKViPXoTL1GPgd/KUhpoD0qOQCyYphg5YWXR4jUoULQ
	 icY5PyG41yCrz0BndGI9oE+/x1TchFZGW1Rs3Eh1r6hbKeHEvirnYdYMFJm0Itat4q
	 Z80NXArd4OaDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28A4A80BCE;
	Sun,  4 Oct 2026 21:53:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A02662E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 85F4C40049
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KiLnwgG9vfg9 for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 21:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EC23340004
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791150805;
 b=MEuvn6N6oaZrXMSofLq1yh+xfjaQJpfv4cCcOyrzkDBgsfaTGqPuMn0IFwWCsE7tV3ps
 +3g9FsmVP0FapYxQwzbbnifDEn1LKrV+SoiimvYDuFRo8mDBdaA3z/EsnLYiDf5SJb1/m
 BqYM30gZtN2zxbhpb6cFzOkb40Vt1zKvytAulQmQzx06tABBKKpe4MJc5DcQVJMrC06KE
 0IF+D+SJsXpDp8PEZUHhex2B6ZZWkW/Z5ZphdJUEZswUXpd+ixTIvs6oeOvVebSew1aEJ
 hFdVgEykOnr/UBNFhK6c/nYZEAFWVp+yQ4yQUmd/oVZM6PI/kh9f9eEgfVQ4Q0IxTtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791150805;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=BsNLsFmdze99KmEoA3KO0Jkkql0IIr6SoR2tGuGvcRI=;
 b=ko26aggsg7yCb7CIuQOJo9Xx/ABLvmfKQSs6BAzRXZpNkFIXXVBMlZEgX/hz/VAWNv3U
 34XHsIVNaMDM2TW4p4auZN38JpirRNHUFdX1KaPIRb3c+aAcNSLFUu79S6UJvY6zvpuF6
 9XzOjeF5XarvJRpmGWWSTfEwsYihG4MUSzy9LR/ooKOeS+vNdpPyPK2E2KNNdQ7A57flE
 aF9qz2LYL9YbrsCf9R9IFCjIQl9j8luphPs/JxYqC4qdOG7zJNFmakOgbRim/J5hm7g6I
 w0+n6qbX+c3Hua/LAdgbu7Or66nxbF6xcsyem9TFiIzXuZxAafz8/kvLKx7Lcm8ZfSw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kwiboo.se; 
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=XcwFEb6D; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=8573=h3=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=XcwFEb6D
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC23340004
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1791150803;
 bh=BsNLsFmdze99KmEoA3KO0Jkkql0IIr6SoR2tGuGvcRI=;
 b=XcwFEb6DHEbXIL1ePd9dBZ/3jNc/vMRuR4JiTWBrQDaJcU4KKSDaXL2I5RqS0pcjbnTbWJm/D
 g3v6Gg2R5HdKxa04hWqBTD5gU9p7DMkCWsswxAm2be58f7EScLSoJyER1xMDVz/xZB7/tEXrG4w
 8qlcZxo8leYaugJtZhjVM2QWVty4pLUO0U12tuqM3P9AJg3Zhx60M8Ccxq/XOkihzonvhAFraVW
 8BinabdyQDK81yRI6RLXyDrQD2VRaEXmLkDu494aRSiznRkJbk+y+2mPsZGtvn2bp5fZgl57sHe
 /dH4JY6jNFkY9tc2jV1d5YYM8hvfLQ32YhfFWvnfGOpg==
X-Forward-Email-ID: 6ac2cad15dbe246f1b817a32
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] net: eth-phy: Add reset control support
Date: Sun,  4 Oct 2026 21:53:15 +0000
Message-ID: <20261004215318.65492-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series extends support for reset of Ethernet PHYs using reset
controls in addition to GPIO to the generic eth phy driver.

Some boards have Ethernet PHYs that use reset controls instead of GPIO
reset, e.g. some Rockchip boards using an integrated Fast Ethernet PHY.

Jonas Karlman (2):
  net: eth-phy: Refactor DM_GPIO guard
  net: eth-phy: Add reset control support

 drivers/net/eth-phy-uclass.c | 38 +++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.55.0

