Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99AEECE58F
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 23:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8A888E93;
	Tue, 10 Sep 2024 01:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rEYTAusC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C772988E9C; Tue, 10 Sep 2024 01:45:50 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3F788E4E
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-160-200.46.114.pool.telefonica.de
 [46.114.160.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B81463F38D; 
 Mon,  9 Sep 2024 23:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1725925548;
 bh=bq5W9/9IgVGgiynHWhA0+fo29GCxtAKzMHH9DUZBwRI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=rEYTAusCR/+n9qMd54AdTgTLbu+/407DDvKDMJ/AIu9VUZOcKpvyy0lmUUdl8HVsa
 rknZiZb7tzqIdRbKHW1ariohGuPmXlU8WR4IN+z/d85/2iI0Es1wShoHbOeZPtHEJJ
 8EhyBNwBzy713kXDnNe1DxlkuztgE39eRR1juka9gbErvfqwK2Q54z5O5ECbJjVw/O
 0Xvrb5OVaKYosjFR1EnpSEDUNaWol2d2n9TO+a8hwXKEPwt8hwDL7mr047Ka5v9+KL
 fizeVNpdsEOqxSTJqXT4hm0KrHB7oS3xdk/dOgLScwahIqNc1EhRnz3ENJjo6FkSHi
 S4p8Acne0PRcQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Igor Prusov <ivprusov@sberdevices.ru>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] cmd: clk: simplify clk command
Date: Tue, 10 Sep 2024 01:45:27 +0200
Message-ID: <20240909234530.27570-1-heinrich.schuchardt@canonical.com>
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

The clk command cannot provide useful output without a clock driver.
So let it depend on CONFIG_CLK.

Fix the Kconfig description of the command.

As with the series the clk command is only built if CONFIG_CLK=y we can
remove some #ifdefs.

Enabling the clk command on the sandbox will allow us to write tests
for it.

Heinrich Schuchardt (3):
  cmd/Kconfig: CONFIG_CMD_CLK should depend on CONFIG_CLK
  cmd: clk: simplify clk command
  sandbox: enable clk command on the sandbox

 cmd/Kconfig                        |  9 +++------
 cmd/clk.c                          | 14 --------------
 configs/sandbox64_defconfig        |  1 +
 configs/sandbox_defconfig          |  1 +
 configs/sandbox_flattree_defconfig |  1 +
 configs/sandbox_noinst_defconfig   |  1 +
 configs/sandbox_spl_defconfig      |  1 +
 configs/sandbox_vpl_defconfig      |  1 +
 8 files changed, 9 insertions(+), 20 deletions(-)

-- 
2.45.2

