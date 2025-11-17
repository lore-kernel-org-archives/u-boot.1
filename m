Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1395CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 19:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FE683BDD;
	Mon, 17 Nov 2025 20:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BEB83C19; Mon, 17 Nov 2025 20:43:46 +0100 (CET)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BB783B99
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 20:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d9J8H375pzn3s;
 Mon, 17 Nov 2025 20:43:43 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d9J8D0N4gztn2; Mon, 17 Nov 2025 20:43:39 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 0/4] fit: allow signing with an OpenSSL engine
Date: Mon, 17 Nov 2025 20:43:28 +0100
Message-Id: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MywrCMBCF4VcpszaSSdpCXfke0kUuYzMLU0kkW
 Ere3Vhw4/I/cL4dMiWmDJduh0SFM6+xhTp14IKJCwn2rUFJNaDUUliODxMFxYUjCdL9ZKUap9F
 LaJ9noju/D+82tw6cX2vaDr7gd/1J+CcVFFI41A7t4I3r9dUFSmk7e4K51voBEAEEqKoAAAA=
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

I am not entirely sure if the setup for the PKCS11 tests package
requirements is implemented the proper way (the double try:catch).

+Cc Eddie who's working on OpenSSL provider support, maybe we can work
together on supporting both engines and providers via the same API we
expose to the user?
+Cc Wolfgang who seems interested in signing with PKCS11 engine which
should now be supported.
+Cc Peter who seems interested according to v1

@Wolfgang, key-name-hint will only be a hint to use when verifying (as
well as being used for the node name), but if you have a
fit,engine-keydir which contains object= or id= in it, key-name-hint
won't be passed to your engine.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
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
 tools/binman/btool/softhsm2_util.py                |  21 +++
 tools/binman/entries.rst                           |  45 ++++-
 tools/binman/etype/fit.py                          |  61 ++++++-
 tools/binman/ftest.py                              | 193 +++++++++++++++++++++
 tools/binman/test/340_dummy-rsa4096.crt            |  31 ++++
 tools/binman/test/340_fit_signature_engine.dts     |  99 +++++++++++
 .../test/340_fit_signature_engine_pkcs11.dts       |  99 +++++++++++
 .../340_fit_signature_engine_pkcs11_object.dts     | 100 +++++++++++
 tools/binman/test/340_openssl.conf                 |  10 ++
 tools/binman/test/340_softhsm2.conf                |  16 ++
 tools/binman/test/Makefile                         |   6 +-
 tools/binman/test/dummy-rsa-engine.c               | 149 ++++++++++++++++
 tools/fit_image.c                                  |   3 +-
 tools/image-host.c                                 |   4 +-
 15 files changed, 830 insertions(+), 12 deletions(-)
---
base-commit: 089d92860e1ba63c52fba9b2ac8aa42bf03ebc03
change-id: 20251030-binman-engine-e349b02696d0

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

