Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29AEFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D1E84673;
	Mon,  4 May 2026 15:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="AJjYOYD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED3B8466E; Mon,  4 May 2026 15:20:46 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC4DB84255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhq3hxzzhnh;
 Mon,  4 May 2026 15:20:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900843;
 bh=A3qFKnQ7GrEkn8RWaRJsfvmFIR/ZftoFi61VemZ1EPQ=;
 h=From:Subject:Date:To:Cc:From;
 b=AJjYOYD5FBu53833cY5/Cvvnsjc2E2yw/vEVL9NBUOtrl/VQ9Jzdq+q8lEkQhlDCs
 dCzAVGqhqpQ3xgS62903swpgGkj+nulOEu7WmwWvSFxobBpavrZ+B9ZYo2NRadO51k
 e1mSIHMq0wypqea2PuQVCj80YtmHuarz+daM4QdKNnzJPcYHQklqoAkEgXbOjt6dUe
 ZvkoTcsas85yXDpQBLYB0KCroFYb8/abreVk1RJ4ZE3c7eN2C9yW6Vvwfw2n9LqLU5
 HliJP1nGmJsNGEHDX+PqZ8/C8uzYimatROFBxwkbClZHHf9ZE8h6PtoMl5WDj2AOC3
 5NE/J4VnBXSDg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhm4k6sz9jf; Mon,  4 May 2026 15:20:40 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH RFC next 00/18] sync scripts/Makefile.extrawarn with 6.1,
 enable WERROR for host tools
Date: Mon, 04 May 2026 15:20:27 +0200
Message-Id: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNL3dSKkqLE8sSiPN3iyrxkXVMDkzQz0xSjtDQjQyWgpoKi1LTMCrC
 B0UpBbs4KeUANSrEQmeLSpKzU5BKQeUq1tQDNvkahfAAAAA==
X-Change-ID: 20260429-extrawarn-sync-504f65d2ff21
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

I ended up being surprised host tools aren't compiled with -Werror even
when CONFIG_WERROR is set.

While this is an issue for local builds, buildman (used in CI) adds
-Werror to KCFLAGS and HOSTCFLAGS when passed -E (or
--warnings-as-errors), which we do, see
'build all platforms in a single job' job and &buildman_and_testpy_dfn
template.

It turns out that even though we claim to have synchronized our kbuild
with Linux kernel v6.1, some of it was stuck to v5.1 +- some partial
backports. This doesn't attempt to update everything that isn't in sync
with 6.1 though!

The first two patches are for fixing pytest calling make directly on a
"dirty" build directory as generated by buildman using the clang-20
toolchain, but pytest does not set HOSTCC and CC to clang-20, resulting
in clang flags being used with gcc).

One can simply reproduce it (after backporting up to patch
"scripts/Makefile.extrawarn: sync with 6.1") by doing so in the
container:

make HOSTCC=clang-20 CC=clang-20 O=build/sandbox sandbox_defconfig
make HOSTCC=clang-20 CC=clang-20 O=build/sandbox -j`nproc
make O=build/sandbox u-boot-initial-env

It'll print:
gcc: error: unrecognized command-line option '-mno-global-merge'
gcc: error: unrecognized command-line option '-Wformat-invalid-specifier'
gcc: error: unrecognized command-line option '-Qunused-arguments'

This is essentially what's run within test_env_initial_env_file in
test/py/tests/test_env.py.

While I'm not unhappy with the patches to pytest, it feels to me we may
be missing something else for the u-boot-initial-env make target to
update the kconfig symbol based on the toolchain being used when called.

While looking at the kernel git history for Makefile and
scripts/Makefile.extrawarn I also saw a few flags being removed or
reworked so I took the liberty of backporting some.

Then, scripts/Makefile.extrawarn is directly imported verbatim from v6.1
which is the version we've claimed to be synced with so far.

Also, patches to apply CONFIG_WERROR to the host tools as well as linker
and assembler are backported.

kernel-doc is made to ignore KBUILD_EXTRA_WARN since we have too many
warnings for now and it prevents us from being able to use W=e Make
variable which is extremely convenient to essentially do the same as
setting CONFIG_WERROR in Kconfig, just without needing to actually set
it in the defconfig or in a .config. I don't like it but it is what it
is. Our kernel-doc has a couple of patches on top of Linux kernel
v5.11's. The kernel has moved to a Python script this year, so it's
probably wise to migrate to that before trying to tackle kernel-doc
warnings.

Finally, buildman is made to use W=e such that the same logic as
CONFIG_WERROR is applied (instead of manually configuring KCFLAGS and
HOSTCFLAGS which only modifies host and target cflags and not linker or
assembler flags like CONFIG_WERROR now does).

RFC because I don't like the commenting of kernel-doc but I think it's
worth it. RFC also because I think something must be broken in the
handling of u-boot-initial-env make target which doesn't check the
compiler vs what's in .config (or maybe some other issue, don't know but
we shouldn't end up using clang flags with gcc or vice-versa).

CI pipeline here: https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/29975

Only change is:

 # diff --git a/test/py/conftest.py b/test/py/conftest.py
 # index 8852df2235e..a26aaee7b2f 100644
 # --- a/test/py/conftest.py
 # +++ b/test/py/conftest.py
 # @@ -121,10 +121,9 @@ def run_build(config, source_dir, build_dir, board_type, log):
 #              o_opt = 'O=%s' % build_dir
 #          else:
 #              o_opt = ''
 # -        base_cmd = ['make', *config.getoption('make_args'), o_opt, '-s']
 #          cmds = (
 # -            base_cmd + [board_type + '_defconfig'],
 # -            base_cmd + ['-j{}'.format(os.cpu_count())],
 # +            ['make', *config.getoption('make_args'), o_opt, '-s', board_type + '_defconfig'],
 # +            ['make', *config.getoption('make_args'), o_opt, '-s', '-j{}'.format(os.cpu_count())],
 #          )
 #          name = 'make'

because I changed my mind factoring out the start of the make cmds in
run_build.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (18):
      test/py: add pytest --make-args argument for additional Make arguments
      CI: pass clang HOSTCC and CC to pytest
      scripts/Makefile.extrawarn: migrate -Wvla to a U-Boot-specific file
      kbuild: re-enable int-in-bool-context warning
      kbuild: Don't try to add '-fcatch-undefined-behavior' flag
      Makefile: move deprecated-non-prototype to scripts/Makefile.extrawarn.u-boot
      scripts/Makefile.extrawarn: handle CONFIG_WERROR in U-Boot-specific file
      scripts/Makefile.extrawarn: sync with 6.1
      kbuild: support W=c and W=e shorthands for Kconfig
      kbuild: align W=e with CONFIG_WERROR
      kbuild: unify W=e and CONFIG_WERROR
      scripts/Makefile.extrawarn.u-boot: remove redundant Werror handling
      kbuild: rust: move `-Dwarnings` handling to `Makefile.extrawarn`
      kbuild: respect CONFIG_WERROR for linker and assembler
      kbuild: enable -Werror for hostprogs
      scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=e for hostprogs
      scripts/Makefile.build: do not run kernel-docs with warnings
      buildman: set W flag to e to be consistent with CONFIG_WERROR

 .gitlab-ci.yml                      |   2 +
 Makefile                            |  17 +++-
 scripts/Makefile.build              |   5 +-
 scripts/Makefile.extrawarn          | 175 +++++++++++++++++++++---------------
 scripts/Makefile.extrawarn.u-boot   |  27 ++++++
 scripts/kconfig/Makefile            |   8 ++
 test/py/conftest.py                 |   6 +-
 test/py/tests/test_cleanup_build.py |   4 +-
 test/py/tests/test_env.py           |   4 +-
 tools/buildman/builderthread.py     |   1 +
 10 files changed, 165 insertions(+), 84 deletions(-)
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
change-id: 20260429-extrawarn-sync-504f65d2ff21

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

