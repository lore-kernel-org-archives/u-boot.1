Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373A6C3DA64
	for <u-boot@archiver.kernel.org>; Sun,  4 Aug 2024 15:06:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5342C88719;
	Sun,  4 Aug 2024 17:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Hs9YMEri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227178872E; Sun,  4 Aug 2024 17:06:09 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9777B8870D
 for <u-boot@lists.denx.de>; Sun,  4 Aug 2024 17:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1722783962;
 bh=o9MywSeLLGF7nSoRbc+dLwyWoTNmQms7RGUBj983e5s=;
 b=Hs9YMEriMzmJN2IKnrGt9qvrEi3p9DP4o55yyvK0eGhIzsxSJ6U+Kcr0uWHpWVn1PAyCk7jfx
 XqHS1++0/YcOQpyeiW4Y25ZMGtGRe9WAmtg6+xs5t+9es3OGlO2FyrxSBO68cKf3fA/xZV3MIzC
 HUXihR2KnotN+d6vBGuEwKcpQrV6tl7pcQGGjzk9zzhB14gvfNeTyVTTFZHWKNQ/QGRAO0gduhd
 loApSexDa7DlI7IQGqHYiMBGZQzFUzICbswE1F4NLqtplaE60+4QCHKLalOL9anwg228TdMw88X
 j5BUEKQiJYOS2gGCiXykK4JMJwKJKCMFNvnxmbdTOYBQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/3] dm: core: Avoid multiple calls to fdt_parent_offset()
Date: Sun,  4 Aug 2024 15:05:48 +0000
Message-ID: <20240804150556.3519995-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66af98d9b04314fb234e2f7e
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

Use of fdt_parent_offset() is very expensive as detailed by the function
documentation:

  NOTE: This function is expensive, as it must scan the device tree
  structure from the start to nodeoffset, *twice*.

This series remove multiple calls to fdt_parent_offset() or
ofnode_get_parent() when instead a single call can be made and the
returned value can be reused.

This series help reduce boot time by around:
- ~137ms on a Radxa ROCK Pi 4 (RK3399)
- ~33ms on a Radxa ZERO 3W (RK3566)

Jonas Karlman (3):
  dm: core: fdtaddr: Avoid multiple calls to fdt_parent_offset()
  dm: core: ofnode: Avoid multiple calls to ofnode_get_parent()
  dm: core: regmap: Avoid multiple calls to ofnode_get_parent()

 drivers/core/fdtaddr.c | 24 +++++++++++++++++-------
 drivers/core/ofnode.c  |  5 +++--
 drivers/core/regmap.c  | 14 ++++++++++----
 3 files changed, 30 insertions(+), 13 deletions(-)

-- 
2.45.2

