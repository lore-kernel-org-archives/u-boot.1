Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AF5C369CA
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1FB83276;
	Fri, 18 Apr 2025 16:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tA5123P6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2866B83236; Fri, 18 Apr 2025 16:11:35 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A0781E72
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c266c1389so1321404f8f.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985492; x=1745590292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZRw61HGdoHtac21Cnl/nm9zDPXgrwDkVNo+MshubKU=;
 b=tA5123P6360TneBl3xt8m98n+B+n4ZEvdJg67yakbV2EkvTpKflNXOQF75/aauJzZ7
 U6UeGwekkgKL5YEcpSUidlVXFb5zlIenSkcOh6ES3nOxIX7d5n9sDukic7ZUeLU+nNqq
 bvhHVcP8soiZbXT2OsWOZCi7VveLsUrPR19PWajzFYzI/0QHyeqOZTQMzdkZrFgOBmiU
 Ir7XSoEMt8UaBzvDGICJaqUmhi50mxstT++Z5LE7pKGSndDa1KC3RJAauj+JIRIfG36W
 Las5cxlgXD6ctUy/g6c4ewG3nlGXOl306+sviFpR4xCZWwDqCyP5Pwl6QDhTpaoL5lLd
 nr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985492; x=1745590292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZRw61HGdoHtac21Cnl/nm9zDPXgrwDkVNo+MshubKU=;
 b=WptDUcoXbLPHXfW1Bb5WUrqOKUYEnOZ0XRhHoOhd3hjf0CyYGvXBl/t+AtRj7COi9f
 a3fwPnVFGCFjpGAQSt/1xwIzht5zEUVEZlgjFg/8F3024a+xbbDKG40U9MXogSf0DW+C
 b/u7ro0LtSu7ZhNSrtofDHlW9DyCnAO58ixkJGif/N130e1PFsyZbNQfq7//6hkv4zju
 8h6VCNw/AWFYO95Ahq7Lx2GCigFHsQXM31ewJjJbg1MVcBAVf55bTDgwUGYHnmoeRubO
 KU5oHEsC5UjyWLDkk3foZU5RfyLiD1PVtcS8rT8ZJ64e21fWGYPRFvBnGzaqjotx6jao
 Fw5g==
X-Gm-Message-State: AOJu0YzAUGH8u2pe8RCf4nBMzYiCfLRN9C2y10lJ6V/ILLheNtZ9Xw4U
 ByhHMUIccOud/qdvw0QF/roLpdfh41cdYuYZjCOSoM6/KUNywXg0r9oMYiSlRmEGEczKp/FuVsT
 JQi0ojuPv
X-Gm-Gg: ASbGncvPof/Y1MM/el6dcd1bcSZuhkNcpDa3O/h9msgdxKLLMkd/XIZsO0BIN9RkwId
 7h9CKp1S2oC2ugJJyjJSBPBdObyAR5xKkbJV42Y2q5XXltHSXm6Z50MhsQiKZ/OuMBPz7MRjU7K
 x56H1cntKu8uQmLgiiZSNHTPURKMozzgSKHoATHST4I8zjJpCnrlMsA+LCdLoptXWFnaandV4qJ
 v3FsBLybzJhuKd6M4XbMeZKqHRtOsDLwLG1sgKXM6uZIHfpWr6+fkckRkiB6zXn/kFHheQLlwji
 Zr3MebgsTy//jbhXTdfWE05o/M3+OWJ1xMnDli7Nfaki0bSqgg==
X-Google-Smtp-Source: AGHT+IH03ko/PoCBbT4irsv09Oo1O4bh66syPpdGQIUz2Ybt4aGMjnndE4XBZ7t77XeOdLeEh8MRQQ==
X-Received: by 2002:a5d:5f49:0:b0:39c:1424:3246 with SMTP id
 ffacd0b85a97d-39efba2ad2bmr2302715f8f.2.1744985491354; 
 Fri, 18 Apr 2025 07:11:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:30 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <malysagreg@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Julius Lehmann <lehmanju@devpi.de>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Scott McNutt <smcnutt@psyent.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thomas Chou <thomas@wytron.com.tw>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, Wolfgang Denk <wd@denx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v6 00/17] Uthreads
Date: Fri, 18 Apr 2025 16:09:28 +0200
Message-ID: <20250418141114.2056981-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Apr 2025 16:20:26 +0200
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

This series introduces threads and uses them to improve the performance
of the USB bus scanning code and to implement background jobs in the
shell via two new commands: 'spawn' and 'wait'.

The threading framework is called 'uthread' and is inspired from the
barebox threads [2]. setjmp() and longjmp() are used to save and
restore contexts, as well as a non-standard extension called initjmp().
This new function is added in several patches, one for each
architecture that supports HAVE_SETJMP. A new symbol is defined:
HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
scheduling, are added to the lib suite.

After introducing threads and making schedule() and udelay() a thread
re-scheduling point, the USB stack initialization is modified to benefit
from concurrency when UTHREAD is enabled, where uthreads are used in
usb_init() to initialize and scan multiple busses at the same time.
The code was tested on arm64 and arm QEMU with 4 simulated XHCI buses
and some devices. On this platform the USB scan takes 2.2 s instead of
5.6 s. Tested on i.MX93 EVK with two USB hubs, one ethernet adapter and
one webcam on each, "usb start" takes 2.4 s instead of 4.6 s.

Finally, the spawn and wait commands are introduced, allowing the use of
threads from the shell. Tested on the i.MX93 EVK with a spinning HDD
connected to USB1 and the network connected to ENET1. The USB plus DHCP
init sequence "spawn usb start; spawn dhcp; wait" takes 4.5 seconds
instead of 8 seconds for "usb start; dhcp".

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=446674
[2] https://github.com/barebox/barebox/blob/master/common/bthread.c

Changes in v6:
- Rebase on master (v2025.04-1157-g278be62c052)
- Add patch "configs: qemu: enable UTHREAD and CMD_SPAWN in various
defconfigs"
- See change logs in individual patches

Changes in v5:
- Apply review tags
- Explain why initjmp() is introduced for every platform (arm, riscv,
sandbox).
- USB: keep 'controllers_initialized' local to usb_init() and use the DM
function device_active() to count the controllers initialized successfully.

Changes in v4:
- Rebase on top of next (at 0e1fc465fea "Merge tag 'dm-pull-15mar25' of
git://git.denx.de/u-boot-dm into next")
- Add a stack_sz parameter to initjmp(). This is made necessary by the
sandbox implementation which relies on sigaltstack(), which need both
the stack base address and its size in its stack_t argument. In any
case it is cleaner to provide the exact stack boundaries. With that,
a crash was fixed on sandbox in the lib_initjmp unit test.
@Ilias: I kept your R-b on the two patches with a trivial change
(passing one more parameter), but I removed it from "arm: add initjmp()"
since there's one more line of assembly code and who knows what I might
have done wrong ;)
- Remove symbol UTHREAD_GRANULARITY and use a tight scheduling loop in
delay() instead. Tests on an i.MX93 board have shown that setting
UTHREAD_GRANULARITY as low as 10 microseconds (or higher) can have a
negative impact on the console input (some key presses do not register)
while 0 makes the console fully responsive.  The test consist in running
"spawn sleep 10" and typing a command. I suspect other platforms may
behave similarly, therefore do not bother with the added complexity of
a configurable delay.
- Apply review tags

Changes in v3:
- Rebase on top of Heinrich's series "common: cleanup usage of structure
jmp_buf_data":
https://patchwork.ozlabs.org/project/uboot/list/?series=446674
https://lists.denx.de/pipermail/u-boot/2025-March/582221.html
- HAVE_INITJMP now depends on HAVE_SETJMP. Provide proper Sphinx-like
documentaion for initjmp().
- test/lib/initjmp.c: change SPDX license tag from GPL2.0+ to
GPL-2.0-or-later
- Add doc/api/setjmp.rst. The initjmp() test is used as an example in the
documentation.
- uthread_create() now accepts an optional user-allocated struct uthread
- Remove the list_empty() test from uthread_schedule() (not needed)
- Add Sphinx doc to all functions in uthread.h (moved from uthread.c).
- Add doc/api/uthread.rst. The uthread test is used as an example in the
documentation.
- Document struct uthread and its components
- Provide numbers to justify the scheduling loop in udelay() in commit
"lib: time: hook uthread_schedule() into udelay()".
- Do not insert uthread_schedule() in common/console.c:fgetc() since it
is already in schedule()
- The wait command can be interrupted with Ctrl-C
- Switch spawn and wait tests from DM_TEST() to CMD_TEST()
- Add MAINTAINERS entry
- Apply review tags

Changes in v2:
- Rewrite the cover letter, do not mention the older coroutines series
- Rebased onto next
- UTHREAD_STACK_SIZE is set to 32768 (32 KiB) instead of 32178
- Remove uthread_free_all() and let threads be freed as they terminate
by uthread_schedule()
- Add function descriptions
- Add documentation (doc/develop/uthread.rst)
- Explain initjmp() in the description of "arch: introduce symbol
HAVE_INITJMP".
- Add thread groups (uthread_grp_new_id() and uthread_grp_done())
- Add the spawn and wait commands

Jerome Forissier (17):
  arch: introduce initjmp() and Kconfig symbol HAVE_INITJMP
  arm: add initjmp()
  riscv: add initjmp()
  sandbox: add initjmp()
  test: lib: add initjmp() test
  uthread: add cooperative multi-tasking interface
  uthread: add uthread_mutex
  cyclic: invoke uthread_schedule() from schedule()
  lib: time: hook uthread_schedule() into udelay()
  test: lib: add uthread test
  test: lib: add uthread_mutex test
  dm: usb: move bus initialization into new static function
    usb_init_bus()
  dm: usb: initialize and scan multiple buses simultaneously with
    uthread
  cmd: add spawn and wait commands
  test: cmd: add test for spawn and wait commands
  MAINTAINERS: add UTHREAD
  configs: qemu: enable UTHREAD and CMD_SPAWN in various defconfigs

 MAINTAINERS                          |   9 ++
 arch/Kconfig                         |  10 ++
 arch/arm/lib/setjmp.S                |  12 ++
 arch/arm/lib/setjmp_aarch64.S        |  10 ++
 arch/riscv/lib/setjmp.S              |  11 ++
 arch/sandbox/cpu/Makefile            |  11 +-
 arch/sandbox/cpu/initjmp.c           | 175 ++++++++++++++++++++++++
 cmd/Kconfig                          |  17 +++
 cmd/Makefile                         |   2 +
 cmd/spawn.c                          | 187 ++++++++++++++++++++++++++
 common/cyclic.c                      |   3 +
 configs/imx93_11x11_evk_defconfig    |   2 +
 configs/qemu-riscv32_defconfig       |   3 +
 configs/qemu-riscv32_smode_defconfig |   3 +
 configs/qemu-riscv64_defconfig       |   3 +
 configs/qemu-riscv64_smode_defconfig |   3 +
 configs/qemu_arm64_defconfig         |   3 +
 configs/qemu_arm_defconfig           |   2 +
 configs/sandbox64_defconfig          |   2 +
 configs/sandbox_defconfig            |   2 +
 doc/api/index.rst                    |   2 +
 doc/api/setjmp.rst                   |  20 +++
 doc/api/uthread.rst                  |  19 +++
 drivers/usb/host/usb-uclass.c        | 192 +++++++++++++++++++--------
 include/setjmp.h                     |  32 +++++
 include/u-boot/schedule.h            |   3 +
 include/uthread.h                    | 183 +++++++++++++++++++++++++
 lib/Kconfig                          |  21 +++
 lib/Makefile                         |   2 +
 lib/time.c                           |   9 +-
 lib/uthread.c                        | 165 +++++++++++++++++++++++
 test/boot/bootdev.c                  |  11 +-
 test/boot/bootflow.c                 |   2 +-
 test/cmd/Makefile                    |   1 +
 test/cmd/spawn.c                     |  32 +++++
 test/lib/Makefile                    |   2 +
 test/lib/initjmp.c                   |  73 ++++++++++
 test/lib/uthread.c                   | 146 ++++++++++++++++++++
 38 files changed, 1322 insertions(+), 63 deletions(-)
 create mode 100644 arch/sandbox/cpu/initjmp.c
 create mode 100644 cmd/spawn.c
 create mode 100644 doc/api/setjmp.rst
 create mode 100644 doc/api/uthread.rst
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c
 create mode 100644 test/cmd/spawn.c
 create mode 100644 test/lib/initjmp.c
 create mode 100644 test/lib/uthread.c

-- 
2.43.0

base-commit: 278be62c052f3a5749c3c7a57bcd307b82dcdc2d
branch: uthreads-v6
