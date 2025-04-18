Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735EFC369C2
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 01:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A5282EBE;
	Fri, 18 Apr 2025 03:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mcfOnRvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAEB182EBE; Fri, 18 Apr 2025 03:23:59 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 869EE800B3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-148.46.114.pool.telefonica.de
 [46.114.106.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AD79B3FB9F; 
 Fri, 18 Apr 2025 01:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744939437;
 bh=JkgiLX3LZsUahLUXGBZQC4mNz5j+V31mfmLlxN+gHlw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=mcfOnRvjCddnPZ76aOrHjhx93AxicgRfsNnOQRrk8O9g7+SnIQN8zbzlCj/rEJ+1X
 iVRonLq+ONqmpGE+Wb8+yz+xmuk2EUCNaDKxvt3gwRVdj6tYbyAaRnQvDc58vEq3rz
 G2B/3GT4/3uUboBjW3340+OHl3+HVCOSPtvE7Tf5BqU32KngrlvpJoGFGSAcgCAdiW
 ZUcWfqVdR0/rrusi2vx1S6KvMc9i24FrMVCMjYcUwgzXb6K1knrSFPlt8xFAd4/+gz
 lsdWyQdBTyHsmH7ayMM9vXUxGrZ1i2FJqj/s+G0hVRuNqJpA5K/2QkXD0ihToe7iHo
 SqjNxVUv4toPg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/3] buildman: allow specifying configuration fragments
Date: Fri, 18 Apr 2025 03:23:36 +0200
Message-ID: <20250418012339.177968-1-heinrich.schuchardt@canonical.com>
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

v3:
	Add missing argument descriptions
	Always pass fragments argument where used
	Avoid long lines
v2:
	Add documentation and a unit test

Heinrich Schuchardt (3):
  buildman: allow specifying configuration fragments
  doc/buildman: describe using fragments
  buildman: unit test for configuration fragments

 tools/buildman/builder.py       |  5 ++++-
 tools/buildman/builderthread.py | 18 +++++++++++-------
 tools/buildman/buildman.rst     | 22 ++++++++++------------
 tools/buildman/cmdline.py       |  2 ++
 tools/buildman/control.py       |  3 ++-
 tools/buildman/func_test.py     | 15 +++++++++++++++
 tools/buildman/test.py          |  2 +-
 7 files changed, 45 insertions(+), 22 deletions(-)

-- 
2.48.1

