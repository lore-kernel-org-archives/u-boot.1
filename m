Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82FCE67806
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 05:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD62F890B9;
	Sun,  3 Nov 2024 06:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="b70ECi7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6202C8910B; Sun,  3 Nov 2024 06:36:16 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476A188FB9
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 06:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 272823F9A3; 
 Sun,  3 Nov 2024 05:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730612173;
 bh=N2gpoJNUuXy7u8daNgZ1e0osPgR9V3CQG2ZgrAJbenQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=b70ECi7m2DB2Suu5Rmz5QQhwTFOl+tWT78V6V2HxwwUtO+QmJyK/H5xFrXWPhgUae
 6aFeSJxqs88pbjyjj10af3fWEFSFd738rh2BAssa3Vwn6oba39DCdC+X1wv0IeuKnL
 L20DTEiwxTEQq/0x0WXjZCjG19fYp9vuKR+O6V1e5Wb3f0Rb6YjoDe3rJpfai8lGdU
 cIMJff3JHZZ+A39JhEJONUlTube8vHH3lN0N0lUkYenDURb+gVOrG4dgjxAUzyFJfO
 GLnX4uBtrFg5lpZ9lAYxs2BeOyerohBJr0VAmKYgxe+qB6Z/YvqrVmzwV4lhzK2WkU
 JlI0b4dko/cxw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kalen Brunham <kalen.brunham@intel.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] examples: fix building on arm64
Date: Sun,  3 Nov 2024 06:35:48 +0100
Message-ID: <20241103053551.52715-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Commit f9886bc60f42 ("Added arm64 assembly for examples/api crt0") added
the arm64 architecture but the code does not even build.

With the changes the 'demo' program runs on qemu_arm64_defconfig using

    setenv autostart no
    dhcp demo
    setenv autostart yes
    bootelf $loadaddr

Heinrich Schuchardt (3):
  examples: fix building on arm64
  examples: adjust LOAD_ADDR on arm64
  examples: make glue and demo code compatible with 64-bit

 examples/api/Makefile |  4 ++++
 examples/api/crt0.S   | 35 +++++++++++++++++++----------------
 examples/api/demo.c   |  9 ++++-----
 examples/api/glue.c   |  4 ++--
 4 files changed, 29 insertions(+), 23 deletions(-)

-- 
2.45.2

