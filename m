Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9887EEB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 12:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A82686553;
	Wed,  6 Sep 2023 14:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e4vi0K+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 981DA8691E; Wed,  6 Sep 2023 14:00:18 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064B2864AA
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 14:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2FF5F3F6E5; 
 Wed,  6 Sep 2023 12:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694001615;
 bh=xJj+ogIftpXZDsZW7Ir5j4AKK24M4uDxPT1YC2raaW8=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=e4vi0K+9oJxWw4dyW8+6fj1b0SJ7bCkvgyhXMkR/60wsYUAXZxO7j/WxnSv+cnyJr
 tAu/RDYKmCboTWR5RCRPRrYP9m1tne7mMHM2sX8kjGt4lskp4LkwGrR/wrUSwXpqyL
 yVSuQO4GfjSbZsMPXsbeFjybklltA0e+GZ9zTc9GLVV/oPR8zF1D67yxfWlnait6PP
 RHHFaIuHg5HsLVMQlVjIorbQseISOrgFEy5m9XuOqTWY81/j8UhSRwzWPDXzV4tUvK
 iThYRxjJXN7FS0qgT1IG+2u3O8iKSUEfgYLNWhAXCbDJLHHtmBGFl40kwXBZj6Zc7C
 76CRpokKz/+KQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: Simon Glass <sjg@chromium.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] riscv: starfive: generate u-boot-spl.bin.normal.out
Date: Wed,  6 Sep 2023 14:00:06 +0200
Message-Id: <20230906120008.86717-1-heinrich.schuchardt@canonical.com>
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

The StarFive JH7110 base boards require a header to be prefixed to the SPL
binary image. This has previously done with a vendor tool 'spl_tool'
published under a GPL-2-or-later license. Integrate this capability into
mkimage.

Add a binman task into the VisionFive 2 build to build the prefixed
U-Boot SPL file u-boot-spl.bin.normal.out.

v2:
	Fix a typo in a comment in tools/sfspl.c
	Add Tested-by credits

Heinrich Schuchardt (2):
  tools: mkimage: Add StarFive SPL image support
  riscv: dts: starfive: generate u-boot-spl.bin.normal.out

 .../jh7110-starfive-visionfive-2-u-boot.dtsi  |  10 +
 boot/image.c                                  |   1 +
 doc/board/starfive/visionfive2.rst            |  14 +-
 include/image.h                               |   1 +
 tools/Makefile                                |   1 +
 tools/sfspl.c                                 | 174 ++++++++++++++++++
 6 files changed, 189 insertions(+), 12 deletions(-)
 create mode 100644 tools/sfspl.c

-- 
2.40.1

