Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A9DC369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 10:24:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D14B82A4D;
	Sat, 19 Apr 2025 12:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jxoOEvW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ABAD82A55; Sat, 19 Apr 2025 12:24:31 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EA382A31
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 12:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-045.46.114.pool.telefonica.de
 [46.114.106.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D313C3F20C; 
 Sat, 19 Apr 2025 10:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745058250;
 bh=MDCjex/BBFaCtf0VIlqhepvuxsPiMwb1NxaroKKi+6Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jxoOEvW4gJz+1G8iCrXGnhw++Hf6WDKiomb+Yu08Epi0OCYP5iyg5uzf1orn6RMp8
 Olp0m9IlekZkRrBppRv+jUUZqu+mpKFV+70nqYCek7VST1D2k7ah5PFQVCHh0mxCLg
 j4498eztbvDfJQCd8HnjTK/8AqwCXV5qInUnIWarXOOgQWQf52uBchUo3Jy0Y4RzzZ
 SQpaZ+mcVcM9AMSE7p+9W89esNCSdZA+DvIS21ai34BIRTDY5DFpt3cqRc2X3Ch1XB
 Sh2WTgFrpXrU74lTS8vT0YTqzilJRa+b0Vj30z8a78V+K8SujSkZsX0TTqTQDnDjWM
 MIEUeLRP5fp1g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v5 0/3] doc/buildman: describe using fragments
Date: Sat, 19 Apr 2025 12:23:55 +0200
Message-ID: <20250419102358.13127-1-heinrich.schuchardt@canonical.com>
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
comma-separated list of configuration fragments to add to the board
defconfigs.

In response to v2 Quentin discussed alternatives forms of passing the
fragments as parameters. But as the Simon already reviewed the current
form and did not instruct me to do otherwise I am leaving things as
they are.

v5:
	Fix typo comma-separated
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

