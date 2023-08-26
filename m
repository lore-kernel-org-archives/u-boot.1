Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35233C83F10
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 01:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A3C869CC;
	Sat, 26 Aug 2023 03:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fGQTvTZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4E786AF4; Sat, 26 Aug 2023 03:53:01 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8EAA869CA
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 03:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2A99F3F227; 
 Sat, 26 Aug 2023 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693014778;
 bh=Bdw92QJ0dDGgFHUoj7Tn0fboMr8XXBwCHLI+kO3bZg8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=fGQTvTZm5k+TcEFfQG0NusYnVuXBWUoEE/DRYEENSGtsA0q8ohchjpPMA6KswpAMf
 wGV/hZCGkByhAYzLjvnqA+xyI5xmRjVmV/0SNp6NXJmEfmfqOHo+uJMqOkhMdD6xil
 EoGM4GHYAzWjMpZ6Acitz/usS4SwbM4ukN7M4W0RAyYMwoEVZ/I51gGG0dJqwl8hZh
 oIIA5cYdk5qbmZuhFaVswJiv/AI54bRrUFU8/1vY8zC0Ph0YKh/muZZGc/HfsiJMfG
 b+nRj7DDfLp3w7VjHybFv+yGTnklChSWXBIRiL22EvzMtClojE1DFypC+pRYMjghma
 IeuEyhOe88l3A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Joshua Watt <jpewhacker@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] cmd: fix errors in gpt command
Date: Sat, 26 Aug 2023 03:53:40 +0200
Message-Id: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Consider that partitions may not be numbered continously starting at 1.
Don't enumerate a block device with multiple partition drivers.
Let gpt_partition_entry be a hexadecimal value.

Heinrich Schuchardt (3):
  cmd: fix gpt setenv
  cmd: fix gpt enumerate
  cmd: let gpt_partition_entry be hexadecimal

 cmd/gpt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.40.1

