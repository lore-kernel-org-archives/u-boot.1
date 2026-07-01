Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C67C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40DC84BAA;
	Wed,  1 Jul 2026 13:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EmR2x6RO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE27984BB3; Wed,  1 Jul 2026 13:46:56 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1BA84B62
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so527559a34.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906413; x=1783511213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TYBS6FVsSfUBWOT70EUCotqSTaWCbH09F9we+yBxuK0=;
 b=EmR2x6ROhOwdYh8C95Sj2nCdkgWVgDwbpHBs4I1ndH85Ck4tbAr6DiBupIiZh+ErOj
 ZgEHRxxbqLlG7kXWP85cp+99TpZ/rkw5AZNrtl8MMt7oAZ8Sx6JNaxkAj2WNNmCt13Bf
 H5GqVMlza7m6ucFrb+pmWET4hSbeh69UWbQWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906413; x=1783511213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYBS6FVsSfUBWOT70EUCotqSTaWCbH09F9we+yBxuK0=;
 b=nifLOxLBnvtfMVdpnyHpfrUJPjAM3uHBfMCQxei3/NH8pJtUCdIDPWxZe5wFPCIw8V
 DqfyTmRoYZIk6dEx1OBODI2fK1nlWANRegnDZzbzSS2y7y5+LXmo70eNQ9OP5YjVoTtf
 5xQjmMOwtvPYvlHA680Qa8Mmmjh5xkMeX75ykdSasuyyRkqEOmV56f5cY+6KdCsteeun
 1h/vSTPKPhkq0yjmzc3nFqnyLz/uQ2isi/xO0aDPmcpD2y6qK1iAU1TpQyYZfuF8CDvC
 Cp+jNeRz97k55AfTRjWd/sN+kxUrONfabJDM1txqbDjrzF4XBJb0RkXBq6bRB04zpYip
 /6QA==
X-Gm-Message-State: AOJu0YymfnS42vIiXJvLm4Lw+GO1WgYSPWdRmYvSM52lO0Fd0GoReZ/H
 GAn16ZZAs3lVxmzbPgvVbjlHj4eTcGDlJwJeDqv0dOVla9TPZ3vxsgB1y5OI/HyVYzNhtSKuMHE
 iXys=
X-Gm-Gg: AfdE7clwH3uxz7lYRzlRxbwxA4DMC+AZG+JHvsgu0fM7CJ301awZRRKLTpdZFIDFObF
 BzCU/iKcojwXQ1Ca8ykaHp6lAVceUdZCOy5LSRD5nESDzgcUxNAdg2UhoHy/8Pq7/q631x5Mmp1
 WxPywnik2kbDWrj+V+LEngf6XNdPSaTceSoVh3L8Reto/K0kpBTt9HGFGhs3gY3LPsUBE92K/0O
 22Vqjhp+O8CkGBoOQz75Eefx47MfMpMgQ/ugnnX61K3mX17OxM9tXRkfg39fyzei5+PLw0WJG8D
 XCYlCEgfwM9sBKtRizyAKanWj9/FSA/K5lzzPvi3WRdR5Le/aHOeF3rFzm3bBlqCjH4xrfmniPo
 xYfd7e1cjFJfvUCPvEdAbi+wxjCSiNz670+e53kHh6yRvl1++zjiWHWm9IR8h7nOtx2gmXHKMFX
 oX8ADqPQI=
X-Received: by 2002:a05:6808:1387:b0:495:effa:f06e with SMTP id
 5614622812f47-49636a563bcmr155604b6e.42.1782906412835; 
 Wed, 01 Jul 2026 04:46:52 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:46:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heiko Stuebner <heiko@sntech.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Sam Day <me@samcday.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 00/14] cmd: Convert command option parsing to getopt()
Date: Wed,  1 Jul 2026 05:42:20 -0600
Message-ID: <20260701114248.1396125-1-sjg@chromium.org>
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

Most U-Boot commands open-code their option parsing, scanning argv[] for
"-x" strings by hand. That only recognises options in fixed positions
(so e.g. 'echo foo -n' misbehaves) and duplicates the same code in
every command.

This series introduces a getopt-based command signature: a command
marked CMDF_GETOPT receives a single 'struct getopt_state *' and parses
options with getopt(), while commands without the flag keep the classic
(cmdtp, flag, argc, argv) signature, so commands move over one at a
time.

It starts with the getopt groundwork - optional argv permutation, a
getopt_pop() helper, dropping the printed error messages and the silent
variant - then adds the U_BOOT_CMD_GETOPT() signature support and a
strlower() helper, and converts the first commands: hash, env
export/import/grep, fastboot and echo.

The signature change itself is code-size-neutral; commands parse in
POSIX mode (a '+' optstring prefix), so CONFIG_GETOPT_PERMUTE - which
would make every getopt command carry a writable argv copy - stays off
by default and is kept only as an opt-in.

The earlier RFCs grew arm64 by about 1.1K, not ideal for a series that
mainly benefits readability. To fix that, this series also restructures
struct cmd_tbl so that adding getopt() support does not cost size: the
rarely-useful ->cmd_rep function pointer is replaced by a
CMDF_REPEATABLE flag, dropping a pointer from every command entry.

Because that pointer is removed from every command on every board, the
net result is now a size reduction. On qcom (arm64, ~120 commands) the
whole series is about 6.9K smaller than mainline.

Previous attempts:
v3 just had a simple convert for env input/export
   https://lore.kernel.org/u-boot/20260520201218.3752042-1-sjg@chromium.org/

v2 included the full series
   https://lore.kernel.org/u-boot/20260520000630.GJ1858239@bill-the-cat/

v1 started the effort
   https://lore.kernel.org/u-boot/CAFLszTiSxcKyD1MWP+2p2zBbDzLoC5Z=wnxVNHO31DGQHCrLcA@mail.gmail.com/

Changes in v4:
- Add a Kconfig to control permuting
- Reword the commit message a little
- Fix the getopt_silent() kernel-doc and the bdinfo help test
- Add new patch to narrow maxargs to a short, freeing space in
  struct cmd_tbl for the flags byte
- Guard cmd_invoke() with CONFIG_IS_ENABLED(GETOPT) so boards without
  GETOPT still link
- Add new patch to replace the ->cmd_rep pointer with a
  CMDF_REPEATABLE flag, dropping a pointer from every command entry
- Make hash parse in POSIX mode so nothing selects GETOPT_PERMUTE
- Update commit message to mention himport_r()
- Add new patch to convert fastboot
- Rebased on us/next

Changes in v2:
- Use "permute" terminology in docs and comments
- Move the working argv array to the top of struct getopt_state and
  rename it from @args to @argv (drops inter-field padding too)
- Refine kerneldoc for @index
- Restore the original worked example in getopt()'s kerneldoc
- Add tests for permuted argv, a required argument missing after a
  leading non-option, and the '+' prefix
- Redo the sep_err logic to reduce code size

Simon Glass (14):
  lib: getopt: Add optional argv permutation with inline reorder
  lib: getopt: Add getopt_pop() helper
  lib: getopt: Drop printed error messages and the silent variant
  command: Narrow cmd_tbl.maxargs to a short
  command: Support a getopt-based command signature
  command: Replace the cmd_rep pointer with a CMDF_REPEATABLE flag
  hash: Drop unused cmdtp and flag args from hash_command()
  lib: string: Add strlower()
  cmd: hash: Use getopt() for option parsing
  cmd: nvedit: Use getopt() in env export
  cmd: nvedit: Use getopt() in env import
  cmd: nvedit: Use getopt() in env grep
  cmd: fastboot: Use getopt() for option parsing
  cmd: echo: Use getopt() for option parsing

 cmd/Kconfig            |   6 ++
 cmd/bdinfo.c           |   4 +-
 cmd/echo.c             |  26 ++---
 cmd/fastboot.c         |  48 +++++-----
 cmd/hash.c             |  42 +++++----
 cmd/help.c             |   2 +-
 cmd/log.c              |  12 +--
 cmd/md5sum.c           |   2 +-
 cmd/mem.c              |   2 +-
 cmd/nvedit.c           | 210 ++++++++++++++++++++---------------------
 cmd/sha1sum.c          |   2 +-
 cmd/sm3sum.c           |   2 +-
 cmd/sound.c            |   4 +-
 cmd/test.c             |   2 +-
 cmd/x86/zboot.c        |   2 +-
 common/command.c       |  46 ++++-----
 common/hash.c          |   4 +-
 include/command.h      | 167 +++++++++++++++++++++++---------
 include/getopt.h       | 116 ++++++++++++++++-------
 include/hash.h         |   6 +-
 include/linux/string.h |  12 +++
 lib/Kconfig            |  17 ++++
 lib/getopt.c           |  93 ++++++++++++++----
 lib/string.c           |  10 ++
 test/cmd/bdinfo.c      |   1 -
 test/cmd/test_echo.c   |   7 ++
 test/lib/getopt.c      |  54 ++++++++++-
 test/lib/string.c      |  27 ++++++
 28 files changed, 614 insertions(+), 312 deletions(-)

---
base-commit: 5602e89a834ccbedc686053b14206c062a144107
branch: clid-us4

-- 
2.43.0

