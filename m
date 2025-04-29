Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDC4C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 631028215E;
	Tue, 29 Apr 2025 15:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LUPEKM/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D076826AD; Tue, 29 Apr 2025 15:23:03 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 271F482145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2c6ed7efb1dso3709171fac.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745932975; x=1746537775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AQP6Yv8u8T1C2VdqA91fa9767D4hgMz4EYVN+bB3euE=;
 b=LUPEKM/M+C/69OczjEFDA+M5f3iFquQy6jDLsoFfidYBwXAlp/ArQE1ngfwuI/pNW4
 wKSjv/aBwCUEloUUn7K1VYlYpHFV9vumJfoDwbjnccoHO8aoOT/MeUAru2S68EnrleGl
 N8B4D6b7TTLPJc4yPHkNkRku1RR/6ML2BkBlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745932975; x=1746537775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AQP6Yv8u8T1C2VdqA91fa9767D4hgMz4EYVN+bB3euE=;
 b=GEpkxShZ8sjaxyb96AKsBtbhSJ3ZIqtfvm+egA31apjGKlcj0XIUK3aQuWivd7qc2D
 hEZC53d2ECF+RL50L/Pf3hT781M6QuDwOPFQz3kl0fxiuL0bQGkXY9gAtsN+Wf7XQsjE
 K6D7zVI5FlGjs3Salsm1uuMSlxPFvud3z8veXr/AUNTkWaidPT3AibikFRVUhbWWKyJ0
 8m/Z0UQemGYKoUlzwwmGxcFsZgLgpYoSpBaSt5WXyGou6biC5dsLuptQevGmZZ13pJi0
 xqWZGv3ASuSnvOcrDTQZkkGZ19VIyaT+jQeb3nMUgpRS+mYK/VDb75uxy2I0bZMsbxNq
 tQUQ==
X-Gm-Message-State: AOJu0YzCMEGTGfPRyo7g1dlFwrtlIrdwqBVb2P25lOGjZ8HcB9LSDS+m
 0b6GaWI8ReCtzc73cUjifm8wnlSfe9BUWmgzWM/y/75glqRoeM8zDjUU4iD2EvbMSyjidtnquhI
 =
X-Gm-Gg: ASbGncupca+HW/+dwGA/KF1GdtyhpR6k0wZaZBAaLzc0GsgHwb5SbY2i6ab3QP3DuVj
 hophhnExPbSGB1XdKjazeByzdhNk1NuJ4chI5qPmntga1Mq7RjyjbeR5etJcSe6/e7NopIvz3Tq
 ejzuobP+LvYeWNv5NBQDcc0uLokPEAEnDjTBSeIVOjziXsA42W+SVhkE4W246c2t3MuZSUSDLKX
 9XncTyhwF+x1quybY8UwLYu25uGdn2x9TpCrmQbViaQbslAsBLe0KXcE4XWpq9YQnETIfAfXIwi
 Qstjuh+w2NJ0+U83SGkkbm2B7HCm8MYOn/m0ICPAh4yyBjafNwVxma7Gr5mQ4TseVC7ToN/GfTH
 Srw==
X-Google-Smtp-Source: AGHT+IEjw/rpm3/SmcDn5jtrDI5FvVb8X3Bx4QHDiXH9MhwJDcmx9OCziNAgybCm0CxPwOgOhXMX+g==
X-Received: by 2002:a05:6870:214:b0:2d5:336f:1b5c with SMTP id
 586e51a60fabf-2da40285c9bmr1826596fac.34.1745932975125; 
 Tue, 29 Apr 2025 06:22:55 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:22:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/30] patman: Move to asyncio and other updates
Date: Tue, 29 Apr 2025 07:21:57 -0600
Message-ID: <20250429132239.251756-1-sjg@chromium.org>
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

This series moves patman to use asyncio instead of ThreadPoolExecutor
since it makes it easier to handle requests sent from different parts
of the code.

It also includes some updates to bring patman in line with the other
major Python tools (buildman and binman).

With this series, we have a better basis to add support for syncing more
data from a patchwork server.

After this, the next step it to add a new 'patman series' subcommand, to
track and manage series workflow.


Simon Glass (30):
  patman: Move all non-test logic into control module
  patman: Move capture_sys_output() into terminal and rename
  binman: Correct a typo in the toolpath comment
  u_boot_pylib: Allow control of capturing
  u_boot_pylib: Improve ANSI-colour output with backgrounds
  u_boot_pylib: Add a pager
  u_boot_pylib: Avoid concurrent execution of only one test
  u_boot_pylib: Allow disabling colour output
  tools: Plumb in capture control
  patman: Correct a stray quote
  patman: Rename test_basic() in test_checkpatch
  patman: Tidy up the start-up code
  patman: Support extra test features
  patman: Move code for sending into its own module
  CI: Add a dependency file for patman
  patman: Create a module for handling patchwork
  patman: Move Patch and Review to patchwork module
  patman: Add reading of series and patch status
  patman: Rename check_patchwork_status()
  patman: Split up check_and_show_status()
  patman: Split out the processing of find_new_responses()
  patman: Adjust how the fake request() function is provided
  patman: Simplify test_find_new_responses()
  patman: Show patches in yellow
  patman: Add more information to Patch
  patman: Use defaultdict directly
  patman: Switch over to asyncio
  patman: Provide an option to run in single-threaded mode
  patman: Use a pager when outputting status
  patman: Drop the old status code

 .azure-pipelines.yml            |   2 +
 .gitlab-ci.yml                  |   2 +
 doc/develop/binman_tests.rst    |   6 +-
 tools/binman/bintool_test.py    |  20 +-
 tools/binman/cbfs_util_test.py  |  15 +-
 tools/binman/elf_test.py        |   3 +-
 tools/binman/fip_util_test.py   |  11 +-
 tools/binman/ftest.py           | 106 ++++----
 tools/binman/image_test.py      |   4 +-
 tools/binman/main.py            |   4 +-
 tools/buildman/func_test.py     |  10 +-
 tools/buildman/main.py          |   2 +-
 tools/buildman/test.py          |   6 +-
 tools/dtoc/main.py              |   5 +-
 tools/dtoc/test_dtoc.py         |  11 +-
 tools/dtoc/test_fdt.py          |   2 +-
 tools/dtoc/test_src_scan.py     |  25 +-
 tools/patman/__main__.py        |  61 +----
 tools/patman/cmdline.py         |   8 +
 tools/patman/control.py         | 223 +++++----------
 tools/patman/func_test.py       | 143 +++++-----
 tools/patman/patchwork.py       | 425 +++++++++++++++++++++++++++++
 tools/patman/pyproject.toml     |   2 +-
 tools/patman/requirements.txt   |   1 +
 tools/patman/send.py            | 179 ++++++++++++
 tools/patman/status.py          | 463 ++++++++++++--------------------
 tools/patman/test_checkpatch.py |   2 +-
 tools/u_boot_pylib/__main__.py  |   2 +-
 tools/u_boot_pylib/terminal.py  | 105 ++++++--
 tools/u_boot_pylib/test_util.py |  29 +-
 tools/u_boot_pylib/tout.py      |   5 +-
 31 files changed, 1170 insertions(+), 712 deletions(-)
 create mode 100644 tools/patman/patchwork.py
 create mode 100644 tools/patman/requirements.txt
 create mode 100644 tools/patman/send.py

-- 
2.43.0

base-commit: b5d6220dd2f4612912989f3c2b5a710f2248cb36
branch: pata
