Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC7EE64012
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 04:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBE9C807C0;
	Sun,  5 Apr 2026 06:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YQvtp9f2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g3uG6dji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9449B83D17; Sun,  5 Apr 2026 06:38:08 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E46D84144
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 06:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fpKT54GKgz9tYP;
 Sun,  5 Apr 2026 06:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775363881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9D1Gr32F9GQxGBy/yotX5hITDCubI9uzgu9D5Yu6Ns8=;
 b=YQvtp9f2MTI8s2wEUfSmYMZoV0OssOOH6EHA6eaIElBJWD4x30yS3cHYElNu5gm0bTb6m5
 8HY8JcSBxcHD/cxaD9gpcMuQGmOKAcel5Qv8Q2nD+idS43JJHMv1xm3CqbIKgWGchdW0v3
 0P7NvdZUltTc+I4tShkA8NZCPj4zgntGb4yduqvpZW8LRDAWMQYZab1F/q1Z0H3zw4sQr4
 gmp/IF1P2VqDbHDvKNgW6/GFk/zX4SF7qyXBdqpBA/gqZQu0Sq8PI0LhhmIYMwg1VKtAWF
 5UNJxaNBgZ9wySTfMyAsGjoRpx7FT0yqj6/J3YS4ZV2BziVdi1UxPT3BmvvdkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775363879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9D1Gr32F9GQxGBy/yotX5hITDCubI9uzgu9D5Yu6Ns8=;
 b=g3uG6djidr06LaxZijTHvXzXyrH81VThtyLXzxpq7z0ImVUG6cygR2vQ/8cC09DpNph2Qh
 ko2ziO5Z5c1nUMzfQ0qnmcH95ZD3FTR7Wn1/JSJpLFo6oVmxBWgX6JImsAiJUS4AEp4mqJ
 5nlnUiXoFKd2J8dMs3E7EBP6u2GQuVogUh3ByvGogawVyCDU8vPV4tedkFnN1MED3APTzk
 bcLkQlkk16YLgpo3rPyChIe8yS3pY+8jPkmTomPW4e1OI/AU0wE9Uwje2Y8FleEfAbZAaq
 ZL3v9M4mXmK8+lSMc5FUwNcazlgJWdlH6lMycrr0yGGNtOkRmO1iZfpNK0l8mQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun,  5 Apr 2026 06:33:57 +0200
Message-ID: <20260405043751.350594-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ef03ffc1faf22660930
X-MBO-RS-META: ze9my1fj45ebf35o5untwkw3e1zet4c8
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

Two trivial fixes for 2026.04 , one fix for possible NULL pointer dereference
which was not triggered thus far but got detected on Gen5 RSIP, and one basic
disablement of SCIF1 in DT to which a driver was never bound. But it would be
nice to have them corrected.

The following changes since commit 214aababe07de0598bd26ecb0c8fb2e2843ff7d5:

  Revert "usb: cdns3: use VBUS Valid to determine role for dr_mode OTG" (2026-04-03 17:50:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to d8bd70741f0d0258088a306c39bf8af3c1be3c4b:

  arm64: dts: renesas: Disable SCIF1 in Renesas R-Car X5H R8A78000 SoC DT (2026-04-04 23:46:31 +0200)

----------------------------------------------------------------
Marek Vasut (2):
      net: rswitch: Avoid NULL pointer dereference during PHY access
      arm64: dts: renesas: Disable SCIF1 in Renesas R-Car X5H R8A78000 SoC DT

 arch/arm/dts/r8a78000.dtsi | 2 +-
 drivers/net/rswitch.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
