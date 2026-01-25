Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B75EE63CAB
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 16:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768A083CE3;
	Sun, 25 Jan 2026 17:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Z4EY7TjZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PAHJIS//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 811A283CEE; Sun, 25 Jan 2026 17:26:44 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9769E83C39
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 17:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dzcW42c5dz9vDL;
 Sun, 25 Jan 2026 17:26:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769358400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MVNJv3QazCBUhibiKhhxPspKaK2YeEBPZ9ovuBBh1nI=;
 b=Z4EY7TjZSq/DVLTgRVzBfccdZnmyZdOfH59ecUa4e87uP7XY6H9c8QmleJ7GFfb5U9G0Ow
 Uv33VOGQLBHWgl88eRrfekZ68wQPTc+fMeUaYUe9HTO8hNxFLzpYAElzcdDWTvHZY5PWj4
 3beMUrcRE0thx04etguZBwITFa8Fw1dJRHBtJb0SYjiQFnfSYGXYMSeysrWDKTDPZFIh2o
 f/KEtIKvazVda5IF2T5NSZhloF66ZF4wWRI3M5mEgz5Bgexf7ihKAY/fb3U13TpMDoPUqq
 q8LogHJHemDVqL5z54Jrh8QMmVesQcaIU+MK217masQckWizwl9wMvWkV+FH3A==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="PAHJIS//";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769358398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MVNJv3QazCBUhibiKhhxPspKaK2YeEBPZ9ovuBBh1nI=;
 b=PAHJIS//NkngvvMMhvPgeKCRASPu18WycuOYphlFc1/vEOoBFUR+MTt6PGWABg+iX4QhRa
 lb35RkMmbgdxLWRcAbpGy2ZDme5PA8+KOAm8W61dmDahzrMT4mydC9/JMq2zCjZ3cxTZDX
 /4OYvC2lBxT0jojMgXpGfI/Nx5+Y6F+RUy9LQBQ6zOEh1eepzVwsmvx9rpze7WDSNgkaov
 oF9dhLQ69XE5a0YtEh4jBJY5tCJ4JTwo7hYOa9jZJWEH4ongg4CRGYflAZno6TWItQBm2h
 NDDrrH7svOhAmRY9Jqlz7/MCP0jXETxJlW/Dd3G8BiMcmkoXWfgllbJiUAkM7w==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Sun, 25 Jan 2026 17:26:13 +0100
Message-ID: <20260125162626.529902-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1u7b4bq79exph5xazjnc8h83do1b7snn
X-MBO-RS-ID: 6b560de4095c3c369d2
X-Rspamd-Queue-Id: 4dzcW42c5dz9vDL
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

The following changes since commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec:

  Merge patch series "sc5xx: Add complete board support for all ADI SC5xx boards" (2026-01-23 14:55:32 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to a6f018b7b503c026cc66d25bd59868bac70150dc:

  arm64: dts: renesas: r8a779g3: Reinstate basic PCIe clock description for Sparrow Hawk (2026-01-25 15:52:50 +0100)

----------------------------------------------------------------
Marek Vasut (1):
      arm64: dts: renesas: r8a779g3: Reinstate basic PCIe clock description for Sparrow Hawk

 arch/arm/dts/r8a779g3-sparrow-hawk-u-boot.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
