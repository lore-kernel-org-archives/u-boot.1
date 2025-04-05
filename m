Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D88FC36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 18:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091E882AC1;
	Sat,  5 Apr 2025 20:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743878807;
	bh=m5ir9mARr8vfBgYuS7FnF4y0L0Yejy279qc+ovmE3xw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u62MNu7Llf13k2y8boaNySmeewaBp1VF5A6/Zz1OQTjZJdVMA20ACa3srHJwJa2GU
	 46JkeyJD5edcvtMWkxblv+ILqGREZLx4dfZ9j9xVQEhIgu8GvsP7LoiRfrrkBYyo39
	 +5ic6IY7tXLoNfscjCJq9/TXT9+XqJFRJWyGYVlmn4THGMVYwlqRufW+ZkZrVMgky6
	 3mjHGerATVuBri76D01CrKVgS1bIiRjN/GysUAIz+sVpLoxyZMzcMZdmLEdC9dpYCW
	 oz/3vLIARrJqFRB/OQDDvfw+Zt0e1LtPvrFbr0O4DIw8H5Ww707U8MCiZmbB87umae
	 YKDiGpTEF7+Ew==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68EF82A76; Sat,  5 Apr 2025 20:46:45 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36FDA81F45
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 20:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AcVFz35D"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 07DCF10276F6E; 
 Sat,  5 Apr 2025 20:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743878801; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=m5ir9mARr8vfBgYuS7FnF4y0L0Yejy279qc+ovmE3xw=;
 b=AcVFz35DdLOe8C1xsCq7R+wX5p4W5RzGZOYezhE1GfZGpTk6rnYDUSLBF3TGzc6x1t5f/f
 H05dpWs4g9QOzp4VwI8ueEzkX1AzEZqAltlUdNIiDjolUG+GB3M396KsHwZb7ygeaeCkLF
 k/2cmUma2RHTvbYIXi+qQrg4BOJq51vKc7SyUwid2uqrdm+ptw8ej97jwVq/b3Ei9nV6Y4
 iPvv+WALMe1L5+0PQl3MM4JcVrkW3T+kcBLFv4BsiwvAwF+OmFUdedMkZXjXHIPnEMbXxg
 tjI2fhB8w+JC3I/2I5JSyG1D1ywHOJlHEy7/gFn9tn9a6eHvpiEU/bWhwdcWSw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/8] This series introduces U-Boot tests with tbot on real
 hardware.
Date: Sat,  5 Apr 2025 20:46:18 +0200
Message-Id: <20250405184626.22377-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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


add U-Boot tests on real hardware with tbot, which is
started from gitlab CI (or other CI implementations like
jenkins, github,...)

Currently only one board in my lab@hungary is implemented, if series
gets accepted more will follow. May others are interested too,
and prepare also such setups ... or simply send me hardware, I can
add to my setup.

Current board is the imx8qxp based cxg3 board. To build and get a
working image you need some binary blobs, which are copied from the
lab host to the "CI host". After successfull build the resulting
images are copied to the lab host, and new flash.bin is booted
with uuu tool in USB SDP bootmode, and than installed with fastboot
to the emmc. Than power is switched off, bootmode set to emmc
and it gets checked, that U-Boot boots from emmc now.

Than test/py gets configured and started on the CI host which
runs the tests on the board in tha lab.

Hopefully the approach is generic enough to get other hardware
easy integrated, but if there are problems, just contact me,
if stuff is missing.

You can find a working example @gitlab in my i2c custodian branch
here:

https://source.denx.de/u-boot/custodians/u-boot-i2c/-/jobs/1081203
(If you have no access rights, look below for a test started @github)

I dropped from above repo/branch the following commits in this series:

- tbottest: add github example
  as it is not interesting for U-Boot mainline (or?)

  Just for interest, with that the same test is started from repo @github, example:
  https://github.com/hsdenx/u-boot-test/actions/runs/14212012371/job/39821029362
  to see the full logs open there (Run U-Boot test)

- .gitlab-ci.yml: only start tbot tests
- remove .azure-pipelines.yml
  as this changes are only for speeding up my local testing.

The patches in this series:

- test/py/requirements.txt: update coverage
- tools/buildman/requirements.txt: update coverage
- test/py/requirements.txt: increase filelock version
- test/py/requirements.txt: remove unittest2 and testtools
- test: increase timeouts

are fixing small common issues I found with test/py setup ...
which could be go seperate into mainline, but in the first
shot, I want to have all patches in one series.

- CI: add U-Boot testing on real HW with tbot

  adds all the config needed for testing the imx8qxp based cxg3
  board with tbot in tbottest subdirectory. We should discuss where
  to put this code!

  May into u-boot:/test/tbottest ?

  This setup not only runs on gitlab, it also runs from github,
  jenkins ... or from a local shell without any changes in code. So you
  can use it for your normal development process (what was the goal from
  tbot at the beginning, to be more precise, it was may laziness to type
  a lot of commands on different machines again and again). So if you use
  this setup for your daily work you get the CI integration for free!

- .gitlab-ci.yml: add tbot-lab

  finally integrates the tbot test setup into .gitlab-ci.yml

  This works currently for my I2C custodian repo, with some CI secrets
  stored... we have to add this secrets to u-boot repo to get it up
  and running.

  If this is not possible may I should setup a gitlab runner?
  (Which I would like to prevent... but possible of course, and this
   would prevent the timing issues I fixed when tbot is started somewhere
   in the world)

Bonus patch with an idea for custodians I want to implement, if code
gets accepted:

- scripts: add helper for getting infos from your patchwork ToDo list

  is a preparation for activating my 8 year old setup, which
  downloaded patches from my Patchwork ToDo list, checked them
  with checkpatch.pl script  and applied them with git am, fully
  automated from within the CI !

  With that script it is very easy to reactivate this now again,
  if this is interesting for others. Currently I have not a clean
  patchwork ToDo list, which is the reson for adding this not yet.

  My plan is also to reactivate an automated git bisect session,
  in case there are problems with that patches, so test shows the
  problematic patch at the end... which I think would be a great
  feature and benefit to have in mainline CI.

  For reference an old video on youtube how this worked 8 years ago:

  https://www.youtube.com/watch?v=PhaYfqOrQOg

  It would be nice, we can make such a step configurable through
  a switch we can enable/disable before starting a gitlab CI run.

May time is now ready for it, that people have interests in such
a setup?



Heiko Schocher (8):
  test/py/requirements.txt: update coverage
  tools/buildman/requirements.txt: update coverage
  test/py/requirements.txt: increase filelock version
  test/py/requirements.txt: remove unittest2 and testtools
  test: increase timeouts
  [RFC] CI: add U-Boot testing on real HW with tbot
  .gitlab-ci.yml: add tbot-lab
  scripts: add helper for getting infos from your patchwork ToDo list

 .gitlab-ci.yml                                |  74 ++++
 MAINTAINERS                                   |   6 +
 scripts/getpatchlist.py                       | 126 +++++++
 tbottesting/README.md                         | 323 ++++++++++++++++++
 tbottesting/boardtestconfig.py                |  18 +
 tbottesting/boardtests.py                     |  50 +++
 tbottesting/preparetbot.sh                    |   5 +
 tbottesting/tbotboardtests.py                 | 127 +++++++
 tbottesting/tbotconfig-hs/boardspecific.py    | 111 ++++++
 tbottesting/tbotconfig-hs/hs/README.cxg3      |  28 ++
 tbottesting/tbotconfig-hs/hs/args/argsbase    |  11 +
 tbottesting/tbotconfig-hs/hs/args/argshs      |   1 +
 .../tbotconfig-hs/hs/args/argshs-github-ci    |   7 +
 .../tbotconfig-hs/hs/args/argshs-noeth        |   3 +
 .../tbotconfig-hs/hs/args/argshs-noeth-ssh    |   5 +
 tbottesting/tbotconfig-hs/hs/cxg3.ini         | 106 ++++++
 tbottesting/tbotconfig-hs/hs/tbot.ini         | 117 +++++++
 tbottesting/tbotconfig-hs/interactive.py      |  59 ++++
 tbottesting/tbotconfig-hs/labcallbacks.py     |  76 +++++
 tbottesting/tbotconfig-hs/tc_cxg3.py          |  82 +++++
 test/py/requirements.txt                      |   6 +-
 test/py/u_boot_console_base.py                |   4 +-
 tools/buildman/requirements.txt               |   2 +-
 23 files changed, 1340 insertions(+), 7 deletions(-)
 create mode 100755 scripts/getpatchlist.py
 create mode 100644 tbottesting/README.md
 create mode 100644 tbottesting/boardtestconfig.py
 create mode 100644 tbottesting/boardtests.py
 create mode 100755 tbottesting/preparetbot.sh
 create mode 100644 tbottesting/tbotboardtests.py
 create mode 100644 tbottesting/tbotconfig-hs/boardspecific.py
 create mode 100644 tbottesting/tbotconfig-hs/hs/README.cxg3
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argsbase
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs-github-ci
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs-noeth
 create mode 100644 tbottesting/tbotconfig-hs/hs/args/argshs-noeth-ssh
 create mode 100644 tbottesting/tbotconfig-hs/hs/cxg3.ini
 create mode 100644 tbottesting/tbotconfig-hs/hs/tbot.ini
 create mode 100644 tbottesting/tbotconfig-hs/interactive.py
 create mode 100644 tbottesting/tbotconfig-hs/labcallbacks.py
 create mode 100644 tbottesting/tbotconfig-hs/tc_cxg3.py

-- 
2.20.1

