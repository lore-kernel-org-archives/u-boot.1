Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB77DCD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 11:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5951863E5;
	Sun, 17 Sep 2023 13:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="EY1EvQCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27243864BA; Sun, 17 Sep 2023 13:47:56 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BD686308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 13:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 11C9D3F6BC; 
 Sun, 17 Sep 2023 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694951273;
 bh=ZZPZNUHEGqoWXZlcCqRHuBvVf5dcHeyipo8hUGsib90=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=EY1EvQCwYehLsvYz5vC35JfVlJfb9baez12duCPexCqj/jz+hYJhKnDXwUTCzafT8
 iZUlzsrcgQY1LyMn9bywM4FstqsJpl9zE/j0HRgGGiVdBIkJI5nwt5l9XyoLSC0tcT
 vcy8vvQNwmqJSgYuxMagXp7LZ6/j7yOrFELVb5ZDzPcZOxVrWbGe2cHuasgnxgpelS
 0Yx/rRYe9JtrzfihLyQoSr4IUxonbkSqIGYp2Z+2pIQm7jNga88DWALT+Skkr+6slb
 NJi3QFBuhBuN1gGc+fklxk5LVWp6FlCLFBltNJsIWdkQvCGIBA//5WkCsiz+CcF0qE
 m9+YpVXox97hg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 =?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/2] riscv: starfive: generate u-boot-spl.bin.normal.out
Date: Sun, 17 Sep 2023 13:47:29 +0200
Message-Id: <20230917114731.23695-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The StarFive JH7110 base boards require a header to be prefixed to the SPL
binary image. This has previously done with a vendor tool 'spl_tool'
published under a GPL-2-or-later license. Integrate this capability into
mkimage.

Add a binman task into the VisionFive 2 build to build the prefixed
U-Boot SPL file u-boot-spl.bin.normal.out.

v3:
	Rename binman node for SPL image.
	Use u-boot-spl instead of blob as mkimage subnode.
v2:
	Fix a typo in a comment in tools/sfspl.c
	Add Tested-by credits

Heinrich Schuchardt (2):
  tools: mkimage: Add StarFive SPL image support
  riscv: dts: starfive: generate u-boot-spl.bin.normal.out

 .../jh7110-starfive-visionfive-2-u-boot.dtsi  |  11 ++
 boot/image.c                                  |   1 +
 doc/board/starfive/visionfive2.rst            |  14 +-
 include/image.h                               |   1 +
 tools/Makefile                                |   1 +
 tools/sfspl.c                                 | 174 ++++++++++++++++++
 6 files changed, 190 insertions(+), 12 deletions(-)
 create mode 100644 tools/sfspl.c

-- 
2.40.1

