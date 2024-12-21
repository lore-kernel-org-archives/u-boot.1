Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A6BE7718B
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 13:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033F1803B5;
	Sat, 21 Dec 2024 14:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TywDLOVh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j38s7XOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DD6B8051F; Sat, 21 Dec 2024 14:29:06 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229F2803A9
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 14:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YFlVl5bFRz9sp9;
 Sat, 21 Dec 2024 14:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734787743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cM1oluL9Z5E6lB8N6udqEAMzGVfeMgtVS2znIiQ3s1Y=;
 b=TywDLOVhKZZyX6qeCIacNeCfS9T8hugPGn3PGp3x85gcZ9RcyMiO4aUGPpBEHbAIxkyCc8
 jYf6tWyS8jZju7o5LUzmpAsdvfHVExv5kOrHvL+Jrid8kbKW5L89ELHnQqA1mITn9zLQCK
 wNkVqTegk0jIzzyEWCaJ/IQoEo2yxpfYdJddYnrouclRTdjVchY90l4DiDT8Zi9e5i1FIt
 UpleA6CLOTSS8lRjDIiSk4w1Ugo91WZKY/t7AVFBVCTEQpJ/lT9H9nr5WhMjpUaw6Im25y
 kMEfTZBzOQkaWQHIfcF5y5ygTkOJiT8+E9/0rn+TR019Ms/HF7h12e20auFBxA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734787741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cM1oluL9Z5E6lB8N6udqEAMzGVfeMgtVS2znIiQ3s1Y=;
 b=j38s7XOJfLdpf+m75JS4FVuDvqkEBlD3VOmbDfpq5pyuhLpqPm0BxWtfmFo/N5pnhOZv3L
 chp+UcPHPSXNK+x+KSFrw3+tEeeRp1GcrPfSlm/G6jRAZTJQZI7l13z/tEENNTfo8hsf7H
 5xL5OwOW0voU+vtrudkjxzdpgfPFvsh0SwGG3FzGJjTHgniTRtlvi6TW8IxfcGQCtKbYfX
 rmoRg9734pwNC92aTatCjqxbRf9sk8RudE6a07BTtEc+YIwYzjKKAYfqgq6/M7F9zgrMHX
 nB1LOnthx2+YWWNKEmjTJLvpoQzf9y3kaZ20zV9A/X6rSyIJHhFgD2nHRLo/nA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PULL] u-boot-sh/master
Date: Sat, 21 Dec 2024 14:28:32 +0100
Message-ID: <20241221132849.9569-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: c1irpjuuahitzz6pqenxtong3ex7a83z
X-MBO-RS-ID: cd41e4ae5ce4afac5d5
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

The following changes since commit 5c8ef70f0872399b3764b2addf1ed27e22dc61b0:

  Merge tag 'xilinx-for-v2025.01-rc5-v2' of https://source.denx.de/u-boot/custodians/u-boot-microblaze (2024-12-20 08:26:16 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to fa0f9e83a0654360506321e38c6d92888cb6f7ff:

  net: rswitch: Add missing cache invalidate of TX descriptor (2024-12-20 22:20:37 +0100)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      clk: renesas: r8a779h0: Drop CLK_PLL2_DIV2 to clarify ZCn clocks

Marek Vasut (2):
      net: renesas: Enable TFTP_TSIZE on all Renesas hardware
      net: rswitch: Add missing cache invalidate of TX descriptor

 drivers/clk/renesas/r8a779h0-cpg-mssr.c | 10 ++++------
 drivers/net/rswitch.c                   |  1 +
 net/Kconfig                             |  2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)
