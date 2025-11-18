Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A757CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:30:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E2883D0F;
	Tue, 18 Nov 2025 09:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="X272M/gm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCC883C32; Tue, 18 Nov 2025 05:31:01 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D198398D
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 05:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AB2CE109C86; Tue, 18 Nov 2025 05:30:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763440257;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=h8iuy/vGez8GJ3ik/WS8o1gGXTHQ+WnjR3eYhDYMoiA=;
 b=X272M/gmnq3axVS9+Qr40IfJXf70DDawX4DPHmSp3DgRt7kxPKyXDsQKE5lI8PcRoGKoCW
 ySjQXh3eUpsmXZF/iRMXBWdYMf0vpG/YclJYeTOf2y3q+Kq9JBVt1cBRdRVYtD5IPdrAsJ
 iyoagPkZrxUhSg/JU7qa+tc79fVa/8ko1iVFImPXHjn8VkGyk3l2OtVgUr6dBVj1cQDVQX
 /QD5wnlmnCY+JojxGy+H5fY51oI1eYJm73mFeOsthXul5abYnkOtpSvRiXqOemMC+pY0N4
 Vcil4A3MxvYs1BkwktEWxY4dQX1YqOaArmaFbzVdu1bKaZ/POjwzudYGOqj3Iw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
Subject: [PATCH v3 0/6] Add support for SM3 secure hash
Date: Tue, 18 Nov 2025 05:30:36 +0100
Message-Id: <20251118043042.27726-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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


Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and described
at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02

TPMv2 defines hash algo sm3_256, which is currently
not supported and prevented TPMv2 chip with newer
firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C

    u-boot=> tpm2 init
    u-boot=> tpm2 autostart
    tpm2_get_pcr_info: too many pcrs: 5
    Error: -90
    u-boot=>

Implement sm3 hash, so we can fix this problem.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=194&view=results

Changes in v3:
Added Reviewed-by from Ilias
rebased series to
commit: 69cc92d6869 ("Merge tag 'efi-2026-01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-efi")
add comments from Ilias
- use sizeof(*sctx) instead of sizeof(struct sm3_context)
- use output[] instead of output[SM3_DIGEST_SIZE] comment from Ilias
  This leaded to CI error:
  +lib/sm3.c:241:50: error: argument 2 of type ‘uint8_t[]’ {aka ‘unsigned char[]’} with mismatched bound [-Werror=array-parameter=]
  +  241 | void sm3_final(struct sm3_context *sctx, uint8_t output[])
  +      |                                          ~~~~~~~~^~~~~~~~
  see:
  https://dev.azure.com/hs0298/hs/_build/results?buildId=192&view=logs&j=182673a4-17b9-5c0c-69ad-98f742450579&t=34b689f8-3e29-5ffe-50ea-32bfe99f47c7&l=334
  so made this change back to v2 state of the series, to have the same
  arguments as the other hashes in lib/
- seperate linux and U-Boot parts into 2 commits
New in version 3 as Ilias recommended to split linux
and U-boot changes.
use CMD_TEST instead of DM_TEST, as Heinrich confirmed
add comment from Ilias
- add SM3 support in tcg2_hash_pe_image()
Added Reviewed-by from Ilias

Changes in v2:
rebase to
6b27b688694: ("Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh")
add Ilias to Series-cc
add sm3_hash to header file, so we can use it.
add comments from Ilias
- use ARRAY_SIZE(hash_algo_list) instead of a fix number
  in tpm2_get_pcr_info() for the count of supported hashes
  in U-Boot.
- add SM3 hash in tpm_tcg2
Added Reviewed-by tag from Heinrich

Heiko Schocher (6):
  lib: Import rol32 function from Linux
  lib: import sm3 256 hash parts from linux
  lib: sm3: implement U-Boot parts
  test: cmd: hash: add unit test for sm3_256
  tpm2: add sm3 256 hash support
  test: cmd: fix a typo in md5 test

 MAINTAINERS               |   7 +
 boot/Kconfig              |   1 +
 cmd/Kconfig               |  15 ++
 cmd/Makefile              |   1 +
 cmd/sm3sum.c              |  48 ++++++
 cmd/tpm-v2.c              |   1 +
 common/hash.c             |  42 ++++-
 include/linux/bitops.h    |  11 ++
 include/tpm-v2.h          |  12 ++
 include/u-boot/sm3.h      |  35 +++++
 lib/Kconfig               |   7 +
 lib/Makefile              |   1 +
 lib/efi_loader/efi_tcg2.c |   3 +
 lib/sm3.c                 | 312 ++++++++++++++++++++++++++++++++++++++
 lib/tpm-v2.c              |   4 +-
 lib/tpm_tcg2.c            |   9 ++
 test/cmd/hash.c           |  49 +++++-
 17 files changed, 554 insertions(+), 4 deletions(-)
 create mode 100644 cmd/sm3sum.c
 create mode 100644 include/u-boot/sm3.h
 create mode 100644 lib/sm3.c

-- 
2.20.1

base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9
