Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1964CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48C99839DF;
	Fri, 21 Nov 2025 18:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F56583A3B; Fri, 21 Nov 2025 18:15:12 +0100 (CET)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE29B80433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dChg1410szr41;
 Fri, 21 Nov 2025 18:15:09 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dChfy522xz8qX; Fri, 21 Nov 2025 18:15:06 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v3 0/4] fit: allow signing with an OpenSSL engine
Date: Fri, 21 Nov 2025 18:14:56 +0100
Message-Id: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ6CMBCF4auYrq2ZaQHBlfcwLmg7wCwspjWNh
 HB3C4nRsHwv+b9ZRApMUVwOswiUOPLo89DHg7BD63uS7PIWClSJoEEa9o/WS/I9e5Kki8aAqpr
 KgcjNM1DH78273fMeOL7GMG18wvX9SriTEkqQFrVFU7rWFvpqBwphOjkSq5TUr0Y872uVa4JSd
 1WtLZj6v16W5QMVUyZR6AAAAA==
X-Change-ID: 20251030-binman-engine-e349b02696d0
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

I have a couple of products whose U-Boot FIT is signed via a proprietary
OpenSSL engine which only expects the name of a "slot" to select the key
to sign data with.

Currently mkimage fit support expects either a key-dir (-k) or a
key-file (-G) as a toggle for signing, however this doesn't apply to our
usecase because we use an OpenSSL engine (so no key-file to provide)
which doesn't mimic a directory layout like key-dir implies. Moreover,
binman really expects private keys (.key extension) to be available in
this key-dir directory, which we of course cannot provide.

This series allows to sign a FIT image with mkimage (and binman) with
an OpenSSL engine, including PKCS11 and custom engines. If a key-dir
needs to be passed (which is typical for PKCS11), one can do so by using
fit,engine-keydir.

Note that the public key (.crt extension) still needs to be available if
one wants to embed it for signature verification (which is probably what
one wants to do :) ). It is probably possible to use the engine for
getting the public key instead of storing it on disk, but this needs to
be added to fdt_add_pubkey and then binman, through a mechanism
different from fit,engine*.

One issue though is that since binman resolves key paths absolutely and
that I don't believe an OpenSSL engine would happen to have the exact
same key_id value than a local absolute path, fit,encrypt and
fit,engine cannot cohabit. An issue for the next person who wants
an OpenSSL engine AND encrypt the same FIT image, I don't.

Note that LibreSSL supports neither engines nor providers as far as I
could tell (engine support has been explicitly removed).

Note that OpenSSL engines have been deprecated since 3.0 (Q3-2021),
however note that OpenSSL 3.5 still seems to support engines (git grep)
and is EOL end of Q1 2030.

+Cc Eddie who's working on OpenSSL provider support, maybe we can work
together on supporting both engines and providers via the same API we
expose to the user?
+Cc Wolfgang who seems interested in signing with PKCS11 engine which
should now be supported.
+Cc Peter who seems interested according to v1

If anyone has an idea on how to test PKCS11 with SOftHSMv2 with id=
passed in fit,engine-keydir, I'm all ears.

I'm also wondering if the explanation around fit,engine-keydir aren't
too much. After all, they are passed verbatim to mkimage as -k argument
and the special cases are all specific to mkimage and not binman.

This depends on https://lore.kernel.org/all/20251121-pkcs11-ci-v1-1-8ba6da56c2f5@cherry.de/T/#u

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v3:
- did NOT add T-b and R-B on patch 3 and 4 since there's been some
  rework,
- added R-b on patch 2,
- reworded commit log of patch 3,
- reworded documentation of fit,engine and the special case of pkcs11 to
  hopefully be easier to digest,
- put fit,engine and fit,engine-keydir extraction into a separate
  function,
- fixed issues due to modification of the environment in tests failing
  other tests, by using unittest.mock.patch.dict() on os.environ as
  suggested by the unittest.mock doc,
- added test for fit,encrypt + fit,engine raising an issue to keep 100%
  coverage for fit etype,
- fixed issue when running binman with only one process (-T or -P 1) by
  renaming uniquely files and directories created in the input dir in
  individual tests as it is shared among all tests run by a process,
- removed apt-get install of the lib packages in the test as
  Bintool.apt_install() is racey (apt itself is...) and would fail when
  running binman with multiple processes. The package is now part of the
  CI container (well, in a different series). If it's not detected, the
  test is skipped.
- Link to v2: https://patch.msgid.link/20251117-binman-engine-v2-0-e053f683c0b8@cherry.de

Changes in v2:
- added R-b on patch 1,
- did NOT add T-b and R-B on patch 3 since there's been some rework,
- added binman test for signing with dummy RSA engine,
- added binman test for signing with SoftHSMv2 PKCS11 engine,
- added binman test for signing with SoftHSMv2 PKCS11 engine and
  specific keydir (which contains an object= to tackle that special
  case)
- added dummy RSA engine for binman test,
- renamed property to fit,engine as my hunch is that it could be used
  for encrypting as well (from the same engine with the same keydir but
  likely a different key-name-hint so that a different keypair is used)
- added fit,engine-keydir to easily support PKCS11 with arguments other
  than object= taken from key-name-hint,
- Link to v1: https://patch.msgid.link/20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de

---
Quentin Schulz (4):
      fit: support signing with only an engine_id
      tools: binman: mkimage: add support for passing the engine
      tools: binman: fit: add support for OpenSSL engines
      tools: binman: fit: add tests for signing with an OpenSSL engine

 tools/binman/btool/mkimage.py                      |   5 +-
 tools/binman/btool/softhsm2_util.py                |  21 ++
 tools/binman/entries.rst                           |  54 ++++-
 tools/binman/etype/fit.py                          |  93 ++++++++-
 tools/binman/ftest.py                              | 223 +++++++++++++++++++++
 tools/binman/test/340_dummy-rsa4096.crt            |  31 +++
 tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++
 .../test/340_fit_signature_engine_encrypt.dts      | 100 +++++++++
 .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++
 .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++
 tools/binman/test/340_openssl.conf                 |  10 +
 tools/binman/test/340_softhsm2.conf                |  16 ++
 tools/binman/test/Makefile                         |   6 +-
 tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++
 tools/fit_image.c                                  |   3 +-
 tools/image-host.c                                 |   4 +-
 16 files changed, 1001 insertions(+), 12 deletions(-)
---
base-commit: a642f401d700034c82128defc2d6f9c18065de1f
change-id: 20251030-binman-engine-e349b02696d0

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

