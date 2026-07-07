Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCA2C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B67846B4;
	Tue,  7 Jul 2026 13:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FRai5RfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0619284852; Tue,  7 Jul 2026 13:36:01 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E0480087
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:35:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a324d200c2so2348953eaf.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424157; x=1784028957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vSIlevgg+s8jAP62Ctqfc//BrYeJxMyWnDSnRiwVqI4=;
 b=FRai5RfJB+b0mol26UrEnUuDNqGrA+kn2QijkIwTXOTyd/rjTtZtyyrIIR60Gd4VeW
 uWgo/hDGu0zdI5GP4mmSm48mgrR0vif8lxKa63y6cHY49N08fFNx3xpM8061YAMr0UMk
 0Wm+BoXwu+ENowDc0Xdnnk1/M1DP2Sx8q//Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424157; x=1784028957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSIlevgg+s8jAP62Ctqfc//BrYeJxMyWnDSnRiwVqI4=;
 b=bQ7cg75rXm5zckYVf/GoTbXwWRX3jHOOk1317EcU2hc/3Pq4gMQtGq3FhEGGTSBw62
 H0syvpuLa/+yILoeN4VuKzpzz0BM4/mgaZeYE86f/9h1lN5Z4fpKH58CBMl3Gvi75HbE
 LtcJGulMCUnGAv5YCqzaXhISXEAIxGxWyU3h1Bs+GHjDVC5aQLj8Tuy1RhMXRug6VYyd
 AJY//1cGZX4z8J+7gz3ViRCF7zmCWGKKHvEBd0n9ETEa1WUT1XzJ3U58BLGDGYtuu1bb
 2idjdG5NHyd7gkUbai59SvXf30SaPJPnQEo3Ktg2qkMOA8a2CdwNzLgn7kPGLNi3Yey7
 ndCQ==
X-Gm-Message-State: AOJu0YyJ0a+j+v7yzeYk1/QYc1N9i62t91px46AKBsBks0+gQkVo6XxW
 BRvFWphBePHPVLWIwwL7CLGU2b6yeI4sg7jXZcSpbIm//pj5EJsTqgEud2gbPCyIDr76iCj/oaL
 6KNmS1Q==
X-Gm-Gg: AfdE7cnTXagSYgK0+HtEuk4lkOA+DrRIv0waqxWVkjealwPqhRDws3iNselhsOS4SRE
 pzjOfklhC9pRSc8CzrYYGeJ0XADv3Pn3AER8F5xR5Cx2WYZUsAkr6qCbGAJVqgIRKf2plZOv+H/
 27IG0ev5UU9slyU7V4Lv2J6Nctb9SMhI8yFcpraBukLiVTYrkKSeTaNEi1DXMpBGtZnxVq99aG3
 kBQLiMrXuYEuKWxcqU9vC86ERCNsRPKqWkSE3J04Jnx2TMpbNHElYUByp7tc/4r8SPQnShjgiSY
 pZi46by2wroyuQ/jwrUowvKC2uXvh8kKyPCt2hVqcuuF/Do15HzAQ6f3BR5vVtmY7l6ekvyjLhT
 86dThydj/iywgeNphF1VKESwuYMu5UYkOChBp7MfubJbaZKcwwq3p4tr8Y1JB9pWp0JXiKpna6Z
 RqjKmEY9Q=
X-Received: by 2002:a05:6820:4c14:b0:6a1:50e9:d589 with SMTP id
 006d021491bc7-6a35556935cmr3261752eaf.70.1783424157220; 
 Tue, 07 Jul 2026 04:35:57 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:35:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/13] qconfig: Use kconfiglib for database build and
 defconfig sync
Date: Tue,  7 Jul 2026 05:35:01 -0600
Message-ID: <20260707113538.3382145-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The -b (build database) and -s (sync defconfigs) options currently
spawn make subprocesses for every board, requiring cross-compiler
toolchains. It is dog slow, taking several minutes.

This series replaces both paths with direct kconfiglib evaluation,
reducing the time to under two seconds for ~1500 boards with no
toolchain requirement.

The series starts by fixing a long-standing kconfiglib bug where
backslash sequences in string values (like \n in
CONFIG_AUTOBOOT_PROMPT) were silently corrupted during round-trips.

To prepare for the conversion, the database code is refactored so that
buildman can read and build the CONFIG database directly, and
defconfigs can be selected on the command line without using stdin.

A resync is neutral: the effective config is unchanged and only the
defconfig text is brought to canonical minimal form. Defconfigs which
use #include directives are handled too, updating the overlay entries
while preserving the include structure; entries which merely restate
the include files are left alone, to avoid churn. Every updated
defconfig produces a byte-identical .config when processed by the C
Kconfig implementation. The -r (git-ref) option is converted as well.

With all operations now using kconfiglib, the old make-based
infrastructure (move_config(), Slot, Slots, KconfigParser and related
helpers) is removed, dropping ~500 lines. The tool still grows overall,
mostly due to the #include-defconfig handling and its unit tests.
Finally, qconfig's tests are added to the test runner.

The first two qconfig patches were sent in October 2024 (the -D patch
with a Reviewed-by from Tom) but were never applied; they are included
here with only minor commit-message and docstring tweaks.


Simon Glass (13):
  buildman: Fix kconfiglib string-value escaping
  qconfig: Add a way to select defconfigs without stdin
  qconfig: Ignore defconfigs containing #include
  qconfig: Refactor to allow buildman to read the database
  qconfig: Rename do_build_db()
  qconfig: Drop args from KconfigParser
  qconfig: Allow buildman to obtain the qconfig database
  qconfig: Use kconfiglib to build the CONFIG database
  qconfig: Auto-rebuild stale database for -f queries
  qconfig: Use kconfiglib for defconfig sync
  qconfig: Handle #include defconfigs in kconfiglib sync
  qconfig: Use kconfiglib for -r (git-ref) sync path
  test: Add qconfig tests to the test runner

 .azure-pipelines.yml         |    3 +-
 .gitlab-ci.yml               |    3 +-
 doc/develop/qconfig.rst      |   75 +-
 test/run                     |    1 +
 tools/buildman/kconfiglib.py |   30 +-
 tools/qconfig.py             | 1294 ++++++++++++++++++++++------------
 6 files changed, 912 insertions(+), 494 deletions(-)

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
branch: qconf-us

-- 
2.43.0

