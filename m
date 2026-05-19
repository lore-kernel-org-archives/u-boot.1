Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4F3CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726CA84877;
	Wed, 20 May 2026 01:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dycnJbWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B54C84874; Wed, 20 May 2026 01:32:28 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F2C384707
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-68470763896so2191030eaf.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233544; x=1779838344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IflCm9XxtHTo8IitTfckkHG72DvPgTaf+AtagEuL4i4=;
 b=dycnJbWqFV45UyWjORFLSaP+PJD+GR+2RrB19M0GEVmvTsLbnfG7O3RP35iWRP8rTx
 /3lkvujd2mLK4vHzwlxVJu2sjOXo3eV3huYRonXpEyNxilfo+tVYRkmKYjjbstYL6GHl
 B87iptXoZp566H16MVVlbhXbp5WUWQ5r4hqZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233544; x=1779838344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IflCm9XxtHTo8IitTfckkHG72DvPgTaf+AtagEuL4i4=;
 b=h3X/qkZ9RbqlZC4AJsICMITPl8w//5Yl0TmeAUgorY4nJdQYt0eN0lsxBzn25sM3uo
 fto+AHciD3aOcNanX/28baDnXa1dFKOIiK7NeZjVKxvOBYhjVS7Zgihh813eUoB5Wa41
 hbidb6QKdopSgNlSGEbFFxMpu/ctWvcizvBiE5v4aQH58tpXGqANEGhp+00Cb7cilXHt
 7iXdjVyoJFeVnU1edm8YiwZoLnHJg5iiLdJoWuqtVoG/NgL5OmlkORbCLewPy1EcEG1O
 jHtegFcHBx5qS27oQTuNnravtLNxpjrGLfRZuRQX4K5yw1eMPjk9lZGYX1hMOVBZL7h9
 bqRA==
X-Gm-Message-State: AOJu0YwId0fGPUcLfoBaqTuDs0240TyzPDio/o5ZovvuT2/5hYHWx7PA
 jk8xNEorO+yI/RjcnL52GEWOhhQgp/ZYIrzUqCxfJJO2MpxQKWDx17oKV8ZgLA2m/lCdyKJlkKU
 IkrKRO3cy
X-Gm-Gg: Acq92OESSO/Ri8ddG55ci01LhcZBl6kV2x0hITJthWskfw1Pd1iG02Saqed0qlRmkF4
 OtsHTt1C32zEWiEvF6eGFHSh2kD/18wllzlvhmhGWwqSHk9JiJ2cywmiDc1FLP0OiHPMd7kZE0v
 ruqnIcWJZeoIblfEFS4RmT6Ll9BRcCKLCpBYb7YeruQKy6nN24QuBYIFu+wpyAV4eO8ezAcdieB
 IjiHe2lDYFhoUtAMVR+U79DphAHPqb8T5v4w5VIbm4zv2x7mzftHJH1Lh0H71xu+hfVzPFHrj3G
 NpqIOywXrQMxOHE+qOLBsPmUJI25I7QN8JaIlzBlKjpVZzcAKga9yosXy9xy3pEvWQrEvbPnG9Z
 XcVzjq6j3Ad8VnofF6U/MoyKLKnSR9GoXB28u2/bDrrZ95E/CnLpgxoLXn0J5pOS0aeFTQelBUk
 lQveCCv+KRWUfhKlkPOA==
X-Received: by 2002:a05:6820:1513:b0:67b:baae:3339 with SMTP id
 006d021491bc7-69c94583a5fmr14335048eaf.45.1779233544236; 
 Tue, 19 May 2026 16:32:24 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Daniel Palmer <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH v2 00/17] Tidy command option parsing and use it a bit
Date: Tue, 19 May 2026 17:31:26 -0600
Message-ID: <20260519233207.2765755-1-sjg@chromium.org>
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

We have had getopt() for over five years but it is not much used. It is
much easier to understand arg-parsing using getopt() and it avoids
common errors. As the named maintainer I decided to look at how to make
more use of it.

So this series explores the impact of converting a few commands to use
getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
anywhere in the cmdline and provides a few helpers to reduce
boilerplate.

The chosen commands are:

- echo: very simple with one flag and fixed ordering (worst case?)
- hash: fairly simple with just one flag
- env grep/export/import - fuller examples

The series also adds a recommendation to use getopt() for new commands.

To try to reduce the code-size increase, a lower-case function is added
and called from a few places. The difference is fairly marginal.

v2 includes further attempts to reduce code size, by making reordering
a Kconfig option, dropping some printing and some intensive optimisation
of the env commands.

Overall, the result is not ideal (see below) with about a 850-byte
size-increase on arm64:
  01: smbios: Do not fall back on devicetree without valid mapping
     aarch64:  w+   firefly-rk3399
  02: lib: string: Add strlower()
  03: cmd: ini: Use strlower() to normalise case
  04: fs: fat: Use strlower() to normalise case
     aarch64: (for 1/1 boards) all -24.0 text -24.0
  05: boot: pxe_utils: Use strlower() in get_string()
     aarch64: (for 1/1 boards) all -36.0 text -36.0
  06: lib: getopt: Permute by default with inline reorder
  07: lib: getopt: Add getopt_pop() helper
  08: cmd: echo: Use getopt() with '+' prefix for option parsing
     aarch64: (for 1/1 boards) all +1243.0 rodata +175.0 text +1068.0
  09: cmd: hash: Use getopt() for option parsing
  10: cmd: nvedit: Use getopt() in env grep
  11: cmd: nvedit: Use getopt() in env export
     aarch64: (for 1/1 boards) all -5.0 rodata +27.0 text -32.0
  12: cmd: nvedit: Use getopt() in env import
     aarch64: (for 1/1 boards) all +45.0 rodata -55.0 text +100.0
  13: lib: getopt: Tidy up two minor redundancies
     aarch64: (for 1/1 boards) all -4.0 text -4.0
  14: lib: getopt: Drop printed error messages and the silent variant
     aarch64: (for 1/1 boards) all -129.0 rodata -61.0 text -68.0
  15: lib: getopt: Merge the optional and required-argument branches
     aarch64: (for 1/1 boards) all -84.0 text -84.0
  16: lib: getopt: Hoist the arg_index==1 guard
     aarch64: (for 1/1 boards) all -4.0 text -4.0
  17: lib: getopt: Add a Kconfig to drop the permutation code
     aarch64: (for 1/1 boards) all -80.0 text -80.0
  18: doc: commands: Recommend getopt() for option parsing

for a total of:

  18: doc: commands: Recommend getopt() for option parsing
     aarch64: (for 1/1 boards) all +922.0 rodata +86.0 text +836.0

Ideally we would use getopt() everywhere. The small increase in each
case is partially resolved in v2, but it isn't clear that this would be
achieveable in every case in future.

One option would be to make the getopt_init_state() in command.c and
pass struct getopt_state to the commands. This would reduce code size at
each size, but obviously requires a different command signature, unless
a global is used.

Another small improvement could be to include a getopt function to
return the next arg as hex.

Ideas are welcome!

Changes in v2:
- Use "permute" terminology in docs and comments
- Move the working argv array to the top of struct getopt_state and
  rename it from @args to @argv (drops inter-field padding too)
- Refine kerneldoc for @index
- Restore the original worked example in getopt()'s kerneldoc
- Add tests for permuted argv, a required argument missing after a
  leading non-option, and the '+' prefix
- Redo the sep_err logic to reduce code size

Simon Glass (17):
  lib: string: Add strlower()
  cmd: ini: Use strlower() to normalise case
  fs: fat: Use strlower() to normalise case
  boot: pxe_utils: Use strlower() in get_string()
  lib: getopt: Permute by default with inline reorder
  lib: getopt: Add getopt_pop() helper
  cmd: echo: Use getopt() with '+' prefix for option parsing
  cmd: hash: Use getopt() for option parsing
  cmd: nvedit: Use getopt() in env grep
  cmd: nvedit: Use getopt() in env export
  cmd: nvedit: Use getopt() in env import
  lib: getopt: Tidy up two minor redundancies
  lib: getopt: Drop printed error messages and the silent variant
  lib: getopt: Merge the optional and required-argument branches
  lib: getopt: Hoist the arg_index==1 guard
  lib: getopt: Add a Kconfig to drop the permutation code
  doc: commands: Recommend getopt() for option parsing

 boot/pxe_utils.c         |  12 +-
 cmd/Kconfig              |   4 +
 cmd/bdinfo.c             |   4 +-
 cmd/echo.c               |  23 ++--
 cmd/hash.c               |  37 +++---
 cmd/ini.c                |  21 ++--
 cmd/log.c                |  12 +-
 cmd/nvedit.c             | 240 ++++++++++++++++++---------------------
 doc/develop/commands.rst |  62 ++++++++++
 env/common.c             |   2 +-
 fs/fat/fat.c             |  20 +---
 fs/fat/fat_write.c       |   2 +-
 include/getopt.h         | 100 ++++++++++------
 include/linux/string.h   |  12 ++
 lib/Kconfig              |  14 +++
 lib/getopt.c             | 140 +++++++++++++----------
 lib/string.c             |  10 ++
 test/cmd/test_echo.c     |  10 ++
 test/lib/getopt.c        |  47 +++++++-
 test/lib/string.c        |  27 +++++
 20 files changed, 497 insertions(+), 302 deletions(-)

---
base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
branch: clid2

-- 
2.43.0

