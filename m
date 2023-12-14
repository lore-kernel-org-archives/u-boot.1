Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC48C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 12:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F32E687A4D;
	Thu, 14 Dec 2023 13:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="ihugx5Gi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90D1B87A2E; Thu, 14 Dec 2023 13:11:47 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C1287A64
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1702555903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
 bh=5tJwttUxbvkn1LSytziFpw9NC6mhuFO0tebTmYan9jQ=;
 b=ihugx5GiOXeOiC19Md2SZAXPN0CzxeIHDZxtnyF9GlOLgk4CmfVEZh77dEcd8K+uR8346Y
 8wveaQYOZ2c1vS2PGym1rxk66trVksumR3Zc7JVay1xjVEdGwdeHymWzyrE3GUoh8VYX4E
 9m5Bgj/ZVJCYXpuyBYupeRDD3xr8/sxqLO8iF8xAenDpww2vpGrTJm4vvMBhcg2orJMlEy
 LCGHGFQEW1CIieqYC0WGajZKy7ajF7cX3r+HSFLqsZX8BDyWKKA2e4CKQHGOlSkIKCHaOu
 YtBQ79HPjImtYv2wy5bguqnQuV0wLTXwT+nSnUXjnUvhiO+vZuGwpRDMP89DkA==
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Terry Lv <terry.lv@nxp.com>
Subject: [PATCH v2 0/2] tools: Fix build without host OpenSSL
Date: Thu, 14 Dec 2023 13:11:34 +0100
Message-Id: <20231214121136.3286703-1-ada@thorsis.com>
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

Hei hei,

every now and then some user wants to build without having to install
OpenSSL development libraries on the build host for different reasons.
This is not possible for all boards supported by U-Boot and not for all
configurations, but at least for some.  And U-Boot has an option for
that, which currently does not work.

The topic was discussed multiple times and multiple patches were
proposed to fix things, but to my knowledge none got applied.  I'm aware
of at least the discussions listed below.

This series is based on the work done by Paul-Erwan Rio earlier this
year, but replacing the first of two patches by a new patch based on two
older approaches from 2021 and 2022 and the feedback they got.  Because
of that, I gave it the v2 right away.

I added some notes to both patches for further explanations on my
decisions.

I tested this with and without libssl-dev installed on a Debian
GNU/Linux 12 (bookworm) host (amd64 arch), with buildman and the
following options:

    buildman -b master..mybranch -a '~CONFIG_TOOLS_KWBIMAGE' -a '~CONFIG_TOOLS_LIBCRYPTO' atmel

And with libssl-dev installed this:

    buildman -b master..mybranch atmel
    buildman -b master..mybranch turris

Building 'turris' without libssl-dev installed fails as expected.

The series solves _my_ immediate problem (building a recent U-Boot for
an at91 based board _without_ FIT images and/or signing, in a BSP from
2018 which we can not update, and which does not handle host openssl
correctly), but I did not investigate other combinations, except those
listed above.  Test on real hardware was only on our at91 based boards.

Please test and let me know what you think.  I can imagine having CI
testing builds with and without CONFIG_TOOLS_LIBCRYPTO set might be
difficult, because building without won't work for every board.  It can
not, because some boards require it while others don't.

Greets
Alex

Cc: Marek Vasut <marex@denx.de>
Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Link: https://lore.kernel.org/u-boot/20211021093304.25399-1-pali@kernel.org/
Link: https://lore.kernel.org/u-boot/20220111153120.1276641-1-marex@denx.de/
Link: https://lore.kernel.org/u-boot/1884029.XjOfZupGQm@ada/
Link: https://lore.kernel.org/u-boot/20230121154743.667253-1-paulerwan.rio@gmail.com/
Link: https://lore.kernel.org/u-boot/AM6PR04MB61521B84F78571B282FE1D828FD5A@AM6PR04MB6152.eurprd04.prod.outlook.com/

Alexander Dahl (1):
  tools: kwbimage: Allow disabling build on non-mvebu platforms

Paul-Erwan Rio (1):
  tools: fix build without LIBCRYPTO support

 arch/arm/mach-mvebu/Kconfig | 1 +
 include/image.h             | 2 +-
 tools/Kconfig               | 6 ++++++
 tools/Makefile              | 5 ++++-
 tools/fit_image.c           | 2 +-
 tools/image-host.c          | 4 ++++
 tools/mkimage.c             | 5 +++--
 7 files changed, 20 insertions(+), 5 deletions(-)


base-commit: 27089f1e4d11fd7e0619097b59258d0428cde2ac
-- 
2.39.2

