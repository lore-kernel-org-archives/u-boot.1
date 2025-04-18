Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112C3C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 04:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE24831C2;
	Fri, 18 Apr 2025 06:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Y2ha3mS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0AE183125; Fri, 18 Apr 2025 06:31:50 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF92B82A27
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 06:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-148.46.114.pool.telefonica.de
 [46.114.106.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 52E443FFD5; 
 Fri, 18 Apr 2025 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744950707;
 bh=WoBcjEKlyxsOFEe9r1dfNCCQT7/Vh08JCmyPOd6hqpQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Y2ha3mS7uhjE3ZzpQMDFC4j0pcWuykzJx8VhBFovuFlvDTZFWcxOoiZeFtOrNr9bs
 lMq3aMUSz3Lx6MiVjRqV8Qnkhg0NLKodEpq2ErAgy87Xrw+IDTOj8auC9+Iit95ALm
 zOkzvtXRMuQ/2naae7785WPBV8g8gzO1kyyGmxbosvyZq5btSjWB/go1uR9dMZS3uC
 1K8XdpkKr7+pvsTHRk8PzEq6ftiQccwYkklhgvXRR5bB/bSSgD4uu7FkOXiEzvlVGK
 q7UrvLMy3cLtmZCDF0IgxtinX1Yt6aEQ+858WBERfoncqfM3mb/EU7C4LSo1jL4Qpo
 AnF320FLGtJXw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 0/3] doc/buildman: describe using fragments
Date: Fri, 18 Apr 2025 06:31:34 +0200
Message-ID: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
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

v4:
	Describe the invocation of merge_config.sh
v3:
	Add missing argument descriptions
	Always pass fragments argument where used
	Avoid long lines
v2:
	Add documentation and a unit test

Heinrich Schuchardt (3):
  buildman: allow specifying configuration fragments
  buildman: unit test for configuration fragments
  doc/buildman: describe using fragments

 tools/buildman/builder.py       |  5 ++++-
 tools/buildman/builderthread.py | 18 +++++++++++-------
 tools/buildman/buildman.rst     | 28 ++++++++++++----------------
 tools/buildman/cmdline.py       |  2 ++
 tools/buildman/control.py       |  3 ++-
 tools/buildman/func_test.py     | 15 +++++++++++++++
 tools/buildman/test.py          |  2 +-
 7 files changed, 47 insertions(+), 26 deletions(-)

-- 
2.48.1

