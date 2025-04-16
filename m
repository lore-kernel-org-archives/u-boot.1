Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC6FC369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 22:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF73482DE7;
	Thu, 17 Apr 2025 00:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CvHUhv1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B7C82F6A; Thu, 17 Apr 2025 00:40:45 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58924803DF
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 00:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-153.46.114.pool.telefonica.de
 [46.114.106.153])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 53B273FFBD; 
 Wed, 16 Apr 2025 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744843241;
 bh=JE7aI7h0kBjl8e3C1TiiqfkZgv1Kvd8XHlEvrW84m7I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CvHUhv1P7XQWTc9Su3sMfo8Q0DEJBtqF0OC8jK7SbP6i1iBGbUnqt9SDs9aYYdmBp
 HxxnE9khhBdb4M89ajLjUQK+gE/R/PW8qAZCLKtlrB/U9yRN34olw8tLPR9RVI7vnP
 Bf2ZJrp6QXCfkOp8HleWhbjydbGreCs7sTP3I2dmpYw82wMHvT8c4Hiu8Neirfhp6a
 dXc8SBTslQtjg9g0bXjGiBkekT+obY1/Y39e2nAyEpO+RxKkuYQUxw1hzYDk1AKMd/
 n2vQrniiW5EXgu17abQ9gbWMQ0seMlfxVZfNEBzzH4iWVa/ctfjes+h+98K1P/WF75
 s5rIoSgmCf/IA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/3] buildman: allow specifying configuration fragments
Date: Thu, 17 Apr 2025 00:40:29 +0200
Message-ID: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Currently we are no able to build with configuration fragments in our CI.
With this patch buildman gets a new argument --fragments for passing a
comma separated list of configuration fragments to add to the board
defconfigs.

v2:
	add documentation and a unit test

Heinrich Schuchardt (3):
  buildman: allow specifying configuration fragments
  doc/buildman: describe using fragments
  buildman: unit test for configuration fragments

 tools/buildman/builder.py       |  3 ++-
 tools/buildman/builderthread.py | 18 +++++++++++-------
 tools/buildman/buildman.rst     | 22 ++++++++++------------
 tools/buildman/cmdline.py       |  2 ++
 tools/buildman/control.py       |  2 +-
 tools/buildman/func_test.py     | 15 +++++++++++++++
 6 files changed, 41 insertions(+), 21 deletions(-)

-- 
2.48.1

