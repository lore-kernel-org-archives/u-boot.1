Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F0EC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 11:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92E486824;
	Mon,  4 Sep 2023 13:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YztxoFT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E257B868D1; Mon,  4 Sep 2023 13:23:24 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52819864C5
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 13:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [46.114.152.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6A496400E8; 
 Mon,  4 Sep 2023 11:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693826601;
 bh=+8KqOH50Lg9HsygGCAuMz7atr97Sttfep1dYDWITUZc=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=YztxoFT1peFvTe6ZL//hvlCgWBBQGeJ6zF+61qAqLjmmDr+R4Fv+IiazSfkd86k/P
 G+wRKaqEYeyt51E449yK6y7YhXjG6XUWH9utK1MgOFqvHZuknA0JxfospSXWbpqVi8
 2ndlODvrOv0coJi8Zu21ikQv/6RrYx/9qwTkFr38zPvosOrMY1jx99tSUbRS8dqwfF
 PVLqOfPDy2d8OKMIucBtD0S+Kj+kpzUSfP/gy+K9dWo9uX701mN4e+/t1eOSYrMk3B
 koGuoEgAVfJODHW+76kRbRi2U4mp8McPbbQj5Oo1UOOIujqR3r06DGmrz1tIk0C81G
 TVMivJ7WzkTFQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] risc-v: implement DBCN based debug console
Date: Mon,  4 Sep 2023 13:24:02 +0200
Message-Id: <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
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

Currently we only offer an SBI based debug UART for SBI v0.1.
With OpenSBI 1.3 the Debug Console Extension (DBCN) has become available.
This allows us to implement a debug UART in a device independent manor.

v2:
	In the driver check that we are in S-mode.

Heinrich Schuchardt (2):
  risc-v: implement DBCN write byte
  risc-v: implement DBCN based debug console

 arch/riscv/include/asm/sbi.h |  1 +
 arch/riscv/lib/sbi.c         | 16 ++++++++++++++++
 drivers/serial/Kconfig       |  5 ++++-
 drivers/serial/serial_sbi.c  | 20 ++++++++++++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

-- 
2.40.1

