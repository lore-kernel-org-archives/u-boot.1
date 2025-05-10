Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF459C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5198091A;
	Sat, 10 May 2025 13:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MkY1/iw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52AF80ADF; Sat, 10 May 2025 13:05:46 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F158070C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad21a5466f6so316761266b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875143; x=1747479943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EUmKCj83adLPYHEZrBy79SYdCPVnWIpHyeWPacek48o=;
 b=MkY1/iw8Wv3fpuXXZtTn138Oz9/FsaYzl565SDCwymhIEteuRrU50v6VtW/DWdJT/M
 06/TVebEGsOj3mEYMIpkDUBgAWl45MtpqbkYgsVh8FzHBDVcCKWVS0v9cwYWzlPQaaEB
 kaDo/JGoPY6mUp6t5xJJ2PgLGXJUNjEPt2Zm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875143; x=1747479943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EUmKCj83adLPYHEZrBy79SYdCPVnWIpHyeWPacek48o=;
 b=ODgjVGzubFr+ahUDYgp2YcAqUYkFaBEE6kHtjCChJYfLn/JxHiRT6tN70ziT1xKs+k
 KiAw4/ZQVMZ3pzy9VcvDAKUrfasr/jydOlsuoHlClk2XXba3bK1HXwwYm2imo398xVZr
 8er+RoJapf8VHb9ju7FQI9gOpJf1wdJaEsb69JRCL6tOGb0pWw17fLkRpNEJV0G+4/w3
 OSyVw/uVBPP8+z3HPuzAB9A3QqWiC9lyCgiHLbfCXC8/HRe8ZfxFGThnNqZXracXmCvK
 wGq8QT3F/JRFTR+zl83Nyz2sp2ukYvVr/FsXsL4PWRkPU2Zk+XnaaalX16v7LBDDQwOc
 e7oA==
X-Gm-Message-State: AOJu0YyPdgOta2ZGFC/4cxa0towDJlyExsSwq2vYjhlQKbjfryzNgzFU
 X8Hi8D42ksT4X2OCuZLyZfzJUpQhCYk1j8rrCQkndGvTEqvryk65ToUCu2xiioiCbeNN4JtoGXC
 msIIUtcNJ+g==
X-Gm-Gg: ASbGnctdvX5wPVKX+myP447+csHf1ib+bBuM8UJM6ueqRVyuC/8YGkp21tp6W1bV3Ii
 IQQAC2GnuuTseKC3U/aY3vtEH4xYSaSZfSPTUslfCNLYdNnAfCIcSMNVkO5Dfq1VYA1CX5LPfJC
 y3lI/Yuo8oWdLzvWPvKe2wnwFR3yapRCIOXhOYVrMGE8FkBlBVglNaDkbhIUkKBTn7CThPg4eQ7
 v4++Sh5ue5gYA0SxJJjMosgfMfDKRPV9LByVqDTrQa558usFb7gB4RTfwkb3T4FD/o2BSslxEbl
 2mbkmEgXu8MieQycrV55liCRMBMfl6qJAyMov0LMOmBLimI=
X-Google-Smtp-Source: AGHT+IGWmcKbaPpnmR1pLfGVI0bEFTdCUUnf8m3tr5HWEY6HWSYOu8wwamqZsHBTa8aUX9UG1O+NfA==
X-Received: by 2002:a17:906:6205:b0:acb:37ae:619c with SMTP id
 a640c23a62f3a-ad21b21d279mr536654366b.15.1746875143404; 
 Sat, 10 May 2025 04:05:43 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/25] patman: Support beter management of series
Date: Sat, 10 May 2025 13:04:53 +0200
Message-ID: <20250510110535.1453745-1-sjg@chromium.org>
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

Patman provides good facilities for preparing and sending out series. It
also has a way to collect review/test tags from Patchwork in preparation
for sending the next series. But so far it lacks series management.

This series provides a few new subcommands, mainly 'series', which:

- maintains a local database of series
- sendings series and gathers tags and feedback from Patchwork
- provides an overall view of upstreaming progress
- allows tracking of multiple versions of a series


Simon Glass (25):
  u_boot_pylib: Correct pylint warnings in gitutil
  patman: Deal with git safe-directory warning
  u_boot_pylib: Add more functions to gitutil
  patman: Use python3 with /usr/bin/env
  patman: Add a test for collecting a PATCH prefix
  patman: Move common test code into a new module
  patman: Add a fourth series for testing
  patman: Avoid touching the system or local config
  patman: Add a simple database implementation
  patman: Add a helper for managing cseries
  patman: Add a Cseries class
  patman: Update status command support cover-letter info
  patman: Enhance patchwork interface to support Cseries
  patman: Enhance implementation of file-based defaults
  patman: Use -c to show patch comments
  patman: Support returning the parsers to use
  patman: Introduce basic database support in Series
  patman: Improve Series support for patchwork links
  patman: Implement the patchwork subcommand
  patman: Support aliases for commands and subcommands
  patman: Update send function to return whether it sent
  patman: Implement the series subcommand
  patman: Implement the upstream subcommand
  patman: Add tests for Cseries
  patman: Add basic documentation for new features

 doc/develop/pics/patman.jpg    |  Bin 0 -> 97131 bytes
 tools/patman/__init__.py       |    8 +-
 tools/patman/__main__.py       |    6 +-
 tools/patman/checkpatch.py     |    7 +-
 tools/patman/cmdline.py        |  311 ++-
 tools/patman/control.py        |  203 +-
 tools/patman/cser_helper.py    | 1524 +++++++++++++
 tools/patman/cseries.py        | 1165 ++++++++++
 tools/patman/database.py       |  823 +++++++
 tools/patman/func_test.py      |  239 +--
 tools/patman/get_maintainer.py |   13 +-
 tools/patman/patchwork.py      |  439 +++-
 tools/patman/patman.rst        |  283 ++-
 tools/patman/project.py        |    3 +-
 tools/patman/send.py           |   11 +-
 tools/patman/series.py         |   70 +
 tools/patman/settings.py       |   53 +-
 tools/patman/status.py         |   71 +-
 tools/patman/test_common.py    |  254 +++
 tools/patman/test_cseries.py   | 3684 ++++++++++++++++++++++++++++++++
 tools/u_boot_pylib/gitutil.py  |  123 +-
 21 files changed, 9006 insertions(+), 284 deletions(-)
 create mode 100644 doc/develop/pics/patman.jpg
 create mode 100644 tools/patman/cser_helper.py
 create mode 100644 tools/patman/cseries.py
 create mode 100644 tools/patman/database.py
 create mode 100644 tools/patman/test_common.py
 create mode 100644 tools/patman/test_cseries.py

-- 
2.43.0

base-commit: dd1b960e8de7c06add7983ce123f808fcf4dd1fc
branch: patd
