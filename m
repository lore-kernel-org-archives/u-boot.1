Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2144CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A9184713;
	Fri, 15 May 2026 22:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pscyj69R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1039847FD; Fri, 15 May 2026 22:33:28 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4C784694
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7de44ed7a11so321817a34.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877205; x=1779482005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hgc6mwUg9KUOZtRHpo/Iekle1IiIF5b1Zv2ygKEIQiM=;
 b=Pscyj69R7ZVvNUgHlmCcPBa7PBABmk0Lfck0H7FOZSu1e90okN/ET8oUhmg0sgS84l
 1Fft4ywEH3haZV47dt31hRiiAgTUn63Qe3T1eeVUozqY57feBUWmFcDSutqjyf2Bv+m0
 PnN4znbe8sMvbNR1Mljhr/qozH90effN0nAxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877205; x=1779482005;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgc6mwUg9KUOZtRHpo/Iekle1IiIF5b1Zv2ygKEIQiM=;
 b=pqK7RCGYStbjvzkeg0kkfF7YpdgkRTYEv8xWrUC5uLkTP4t2rkDE3XV4N2Ef2z1hPC
 JRBRa1XZ3bHMnXudClIR4tLlFI45BAYVx1vT8a4k6BffQD0zJhAQKtnt6OpiK8iQH0UQ
 IBSJa/363uFM03QxTsyrvC7AC/AGvaRx+8cwMO0SxxGEBGFSzPxRrEAkIX7/blMYm6uB
 i/z4D2anP5GgNWtk1jCsmmwWvTXJ09RIYieTjQvDeGITi/7lk7rUYvXkHIou2TZ6p1WX
 S95NUyX6sSxqYuLPHVWkc/MpugtLoRb3E6t6n3nzl3OfFEziOcdTGlm2RRhjpwnJuxr9
 JRsQ==
X-Gm-Message-State: AOJu0YxQNuZchD3xZoulU+V7QDGZZsqAvmQUPd7u7ikfkeXeyY/GgZGA
 +E3RZo+rfCpcpCJIXhDqXqXDWh9s/PG6nfiNht1WPPuZ0r+M+rnsEKLjrUKW0J/aIeuuUWkKdms
 GywbuRg==
X-Gm-Gg: Acq92OE+lVPP2dfSkLB0yNYDuWoxSVa2wt9tLlIseE/l1COE7ts3bGgXhUZQ7pVv5kp
 IlM6L181IR5KG4Ua1x9XwRJuYxXOlqImEsdV9DQzrbRpwOaw0J4/i3shKZoUENC6lb57ZEO77+s
 pO2H1nnIwbSWO2X7B9t/jcKBeJ3X/O+wcRnf6z5vmfkAeeI65/czOILOTOU+AumfI+VL9utpGSt
 Z/R5OAMhfWMSwHSdFamxVxN+xkIQ/Wdvk+csB2g2Y/Wt5wCgY6oBhIJzKe4886n9tQA02gK2h6k
 Bsqld/QnFSAkYcPcuW5KHwBIh6InZmjWSe4qu2Bcxp0yGKys+Mdd4GeXbbqM4slHfReK0M5a8Sx
 m/K+/1t1GPAjnqBGjbsiaoqdMx3J4Xguqnon3kbegqqtRyUzfxScCpffifernIksg/JaX3NXHlp
 vI+CDw2ZeTx7KemR/0UQ==
X-Received: by 2002:a05:6830:3697:b0:7dc:c4ae:a66f with SMTP id
 46e09a7af769-7e4ea19ab40mr3935083a34.7.1778877204683; 
 Fri, 15 May 2026 13:33:24 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?UTF-8?q?Beno=C3=AEt=20Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
Date: Fri, 15 May 2026 14:32:51 -0600
Message-ID: <20260515203311.2555651-1-sjg@chromium.org>
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

- echo: very simple with no flags
- hash: fairly simple with just one flag
- env grep/export/import - fuller examples

The series also adds a recommendation to use getopt() for new commands.

To try to reduce the code-size increase, a lower-case function is added
and called from a few places. The difference is fairly marginal.

Overall, the result is not pretty (see below) with about a 1.1K size
increase on arm64:

   01: Prepare v2026.07-rc2
      aarch64:  w+   firefly-rk3399
   02: lib: string: Add strlower()
      aarch64: (for 1/1 boards) all +40.0 rodata +40.0 spl/u-boot-spl:all
         +20.0 spl/u-boot-spl:rodata +20.0 tpl/u-boot-tpl:all +20.0
         tpl/u-boot-tpl:rodata +20.0
   03: cmd: ini: Use strlower() to normalise case
   04: fs: fat: Use strlower() to normalise case
      aarch64: (for 1/1 boards) all -24.0 text -24.0
   05: boot: pxe_utils: Use strlower() in get_string()
      aarch64: (for 1/1 boards) all -56.0 text -56.0
   06: doc: commands: Recommend getopt() for option parsing
   07: lib: getopt: Permute by default with inline reorder
   08: lib: getopt: Add getopt_pop() helper
   09: cmd: echo: Use getopt() with '+' prefix for option parsing
      aarch64: (for 1/1 boards) all +1235.0 rodata +175.0 text +1060.0
   10: cmd: hash: Use getopt() for option parsing
   11: cmd: nvedit: Use getopt() in env grep
   12: cmd: nvedit: Use getopt() in env export and env import
      aarch64: (for 1/1 boards) all +176.0 rodata +12.0 text +164.0

Ideally we would use getopt() everywhere, but at least with these
examples it does seem to produce at least a small increase in each case,
even ignoring the 'hit' of about 1K for the function itself.

One option would be to make the getopt_init_state() in command.c and
pass struct getopt_state to the commands. This would reduce code size at
each size, but obviously requires a different command signature, unless
a global is used.

Another small improvement could be to include a getopt function to
return the next arg as hex.

Ideas are welcome!


Simon Glass (11):
  lib: string: Add strlower()
  cmd: ini: Use strlower() to normalise case
  fs: fat: Use strlower() to normalise case
  boot: pxe_utils: Use strlower() in get_string()
  lib: getopt: Permute by default with inline reorder
  lib: getopt: Add getopt_pop() helper
  cmd: echo: Use getopt() with '+' prefix for option parsing
  cmd: hash: Use getopt() for option parsing
  cmd: nvedit: Use getopt() in env grep
  cmd: nvedit: Use getopt() in env export and env import
  doc: commands: Recommend getopt() for option parsing

 boot/pxe_utils.c         |  12 +--
 cmd/Kconfig              |   5 +
 cmd/bdinfo.c             |   4 +-
 cmd/echo.c               |  23 ++--
 cmd/hash.c               |  37 ++++---
 cmd/ini.c                |  21 ++--
 cmd/log.c                |  12 +--
 cmd/nvedit.c             | 219 +++++++++++++++++++--------------------
 doc/develop/commands.rst |  62 +++++++++++
 fs/fat/fat.c             |  20 +---
 fs/fat/fat_write.c       |   2 +-
 include/getopt.h         | 169 +++++++++++++++++-------------
 include/linux/string.h   |  12 +++
 lib/getopt.c             |  67 +++++++++---
 lib/string.c             |  10 ++
 test/cmd/test_echo.c     |  10 ++
 test/lib/getopt.c        |   6 +-
 test/lib/string.c        |  27 +++++
 18 files changed, 441 insertions(+), 277 deletions(-)

---
base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
branch: clid

-- 
2.43.0

