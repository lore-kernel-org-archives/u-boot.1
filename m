Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90069C28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 02:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BE6A809A5;
	Sat, 29 Mar 2025 03:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="yHdWOIzU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dA2kwV23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A4380ECC; Sat, 29 Mar 2025 03:40:53 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F24880050
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 03:40:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZPhTZ6Y0Lz9shs;
 Sat, 29 Mar 2025 03:40:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1743216050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=caL8T0hU6X4APbUKccE1LXe4UwWI6gTn+rOXEOkRdF8=;
 b=yHdWOIzU/uxTNsxPnMZJRuoFzi+g6Kze0Y75WMgMz2BrQZqIjcJQoQL7/GbV5vhrYJdyXj
 V54qT63wOLVeemRB4m9MEzbhR1jtX2eVZe6ZWzwJZWScvQPEPLqc5PFexH9VaXUK2K6OE2
 jHebkcrJEk0MHGF2+LZWVVYI/rquBu8dKE8MLjhCb9xD8joeKLBGTG+DcMi0oW/UzsBcGy
 6tfXuzfReO7PcrcMkrazlL1eno+G8CMzmrxS7J64YQxEOi5nsvdPizLxMAPQgUinUI392B
 A6jvfC7LZ8Yar8d4z+hcF3/HiqOLSeIQe8VOzUxUb2qX7Wm23ZPkmcG4XCr7Lg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1743216048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=caL8T0hU6X4APbUKccE1LXe4UwWI6gTn+rOXEOkRdF8=;
 b=dA2kwV23qsvMX1IdyZARikI+8hSb1+LE9iqLtLqjwgX3lZ9mMyhkGGv18kZ0jhNt8Ysqru
 l0jyUaEDnxYaPaI6c6Vw7924V9a1dgG8/Jnotzf6V6iOtekNKNPvkexcWXZrpmpbDqyjIp
 9fa7DTfcEHzSqRRFofB1VceoamN9nd81vuD9w/83TiXu0zhoHuf/qz5h2Jerrao6palHex
 Anw8niX23eWZa/zArRwcXMlhWfH8P+sDp1+hgVeJXND8jx+L74rLv1VMvKB1qzBgZoMBDo
 bImtr0z6zbnWFUnzAhVOHhXhagIUY0iabFZn2x4avou4K5aXYdsRuXrIAXmmBA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/next
Date: Sat, 29 Mar 2025 03:39:53 +0100
Message-ID: <20250329024035.291171-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uik4oagbffrdb44y4eyowqwm6pc6pf9x
X-MBO-RS-ID: 257c7d89fff73754aed
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

More basic DBSC5 DRAM controller clean ups and improvements.

The following changes since commit 4adbf64ff8d8c730223fd8ae299d770bebb6fe86:

  Merge branch 'staging' of https://source.denx.de/u-boot/custodians/u-boot-tegra into next (2025-03-26 14:07:37 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git next

for you to fetch changes up to 47dad5cc61dd955cca342bbda8c146548ef3409c:

  ram: renesas: dbsc5: Pass udevice and MODEMR0 to dbsc5_get_board_data() (2025-03-29 02:33:24 +0100)

----------------------------------------------------------------
Marek Vasut (5):
      ram: renesas: dbsc5: Clarify MR27/MR28/MR57 register operations
      ram: renesas: dbsc5: Drop space before dbsc5_ddr_setval_all_ch()
      ram: renesas: dbsc5: Improve dbsc5_send_dbcmd2() signature
      ram: renesas: dbsc5: Factor out dbsc5_wait_dbwait()
      ram: renesas: dbsc5: Pass udevice and MODEMR0 to dbsc5_get_board_data()

 drivers/ram/renesas/dbsc5/dram.c | 92 ++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 26 deletions(-)
