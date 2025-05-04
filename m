Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97203C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E25E8828B3;
	Sun,  4 May 2025 15:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MR89aTfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03DC82937; Sun,  4 May 2025 15:24:04 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57B882163
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so381474766b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365041; x=1746969841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ABUNqviAn9KdxTipv+ulSV9bMj3WLnNck2lCK4UsYTI=;
 b=MR89aTfyvCGtngQHZo4wk7l7jzdDigW4D3+INAOlSPRTrwUgI0RCCanMw7+abc24bh
 0Kz8esZBlZ4IQGuT5uW8/w5mytrT1XtVveGTEMGeEBLbHoACIsvp9dyYn6gq9hlseDaA
 zVXCZMa3JfK62Q3af7KqCmpSUwmS0BIsdq7RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365041; x=1746969841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ABUNqviAn9KdxTipv+ulSV9bMj3WLnNck2lCK4UsYTI=;
 b=V3yD7hQ9TZvcvzS2Qn3QjbRVGhN54Wq8OY1ogSHQDmaKTewfe+558uI8mYDawDssSv
 J2TFn78VM4mA0ZZuH8IeRXOpve5yN/bagX/3p77oP7kDH8lZwGP8gSFMSVVLmJ5nbYGi
 b+dd3SYf7hgJf1Dh/eOwLMzcVx40QZ9Amv9B7GB1gHfLectwyPenBSj8PlsERXm6ol6c
 vmyo8SdgHGpdL0fywCqHgau1l5Rdh96U42nqfu1LJhzEiW2IBmKRmvIUl/FSOjcHeBJI
 wUFJtBLNwakbioIufjz9hZGR0Rt7cMfGJZX4Q8TcHR4qAVRjd/3FXvKVuQ5+KHA6f4xQ
 oUZQ==
X-Gm-Message-State: AOJu0YxHAKupwbiQiAEEXXK7+WqyD6iB4RtRvwocEaTsAXmZSBiz575K
 k7Wbbp7DlZhivel5IWMbiTaahbT1UdJ2QrX0M7f8tkf3CfrW2XTt/PXC10LDxA8OCG9wq70r1gt
 5i8uKuIo=
X-Gm-Gg: ASbGncsXL7kfmLB2dGoBZEcxOzWD9QreELU0paZwXF2ACtNVpZ+zBKQbSFrEKZKYq3E
 vAy+/L9JyF24nuMbo+aNQxXKvs9W5dSG2i3fpiahMffUSL/q+C4wYSCXuYkGB6Ng9zTplQN8nDX
 fqwFh7jPd3fi+XRG4PwBj6vmMruz14XBrwE4FhC/JUDeth4kFhbIIFCqyOpgyMRUbx5oDDo9M87
 tqPUaTsN/f4O5IDF1IWv+2iDbuEbphRd6dz3eF8SNoW24WixRl2VToUmP/yb4jmlKGAuhYNfVGP
 vnOSClbIpxA8ymsWT/yIApa1WbGJ5saDGowJyTlLLjeAzhs=
X-Google-Smtp-Source: AGHT+IG4u0w0MfLODzOzO3vrRSZCp2BMxyaCfbo2WUIbF7CK9oJM79BtatqRvd5U3lY8VR9CmTKrFw==
X-Received: by 2002:a17:906:7314:b0:ad1:7858:a769 with SMTP id
 a640c23a62f3a-ad1a49af3ccmr342477066b.26.1746365041306; 
 Sun, 04 May 2025 06:24:01 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 00/30] patman: Move to asyncio and other updates
Date: Sun,  4 May 2025 15:23:16 +0200
Message-ID: <20250504132356.2317305-1-sjg@chromium.org>
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

Changes in v2:
- Rework commit message since this only updates requirements.txt now

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
  patman: Add aiohttp to requirements
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
 29 files changed, 1166 insertions(+), 712 deletions(-)
 create mode 100644 tools/patman/patchwork.py
 create mode 100644 tools/patman/send.py

-- 
2.43.0

base-commit: 0c8a89d252c3db3401ffa572ee2e4dfcb94e2c3b
branch: pata2-us
