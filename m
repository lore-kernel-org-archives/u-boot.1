Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502A3CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B1183B55;
	Tue, 11 Nov 2025 14:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="R/Fuaok3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8667E83A98; Tue, 11 Nov 2025 06:48:41 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42C2383AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:48:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8878108FD6; Tue, 11 Nov 2025 06:48:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762840117; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Rt54J3cE4O8S5JyVDRSdQekzd61B5ayFld/HX0TVafc=;
 b=R/Fuaok3ZZjS2u48hO/WWsVA0MXWKUrDP7wprFSbpTvnByuwFPC9q6GaiZwEoMh3M8BJ9t
 y3SvGyaj8Wht6s0cKH7vIySWiHv/UgFVkmZDwDrIP+sUTxhaTmpUHAi5aWRzI7zPVT5qT/
 xj0rYfViHgmso7G/WLXbXwCEHYcO74imIqwB1Y0pRBTYZzl9eCgr8j691rkts1ZBS2hIvu
 H3s1gP+8TbYo2Rn2Ngs7+ftnI55v/5OffCQg2ETQsaWaC1yLmRm5S2fv9FZMxXT0hYsVxJ
 AFbnFadF7ehStZVwL7rL+WhMDTTUTmjFGsB2MxeHBAQDnKqxM5nByLiX41OeJg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yao Zi <ziyao@disroot.org>, briansune <briansune@gmail.com>
Subject: [PATCH v2 0/5] Add support for SM3 secure hash
Date: Tue, 11 Nov 2025 06:48:07 +0100
Message-Id: <20251111054813.1966-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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
https://dev.azure.com/hs0298/hs/_build/results?buildId=190&view=results

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

Heiko Schocher (5):
  lib: Import rol32 function from Linux
  lib: implement sm3 256 hash
  test: cmd: hash: add unit test for sm3_256
  tpm2: add sm3 256 hash support
  test: cmd: fix a typo in md5 test

 MAINTAINERS            |   7 +
 boot/Kconfig           |   1 +
 cmd/Kconfig            |  15 ++
 cmd/Makefile           |   1 +
 cmd/sm3sum.c           |  48 +++++++
 cmd/tpm-v2.c           |   1 +
 common/hash.c          |  43 +++++-
 include/linux/bitops.h |  11 ++
 include/tpm-v2.h       |  12 ++
 include/u-boot/sm3.h   |  35 +++++
 lib/Kconfig            |   7 +
 lib/Makefile           |   1 +
 lib/sm3.c              | 313 +++++++++++++++++++++++++++++++++++++++++
 lib/tpm-v2.c           |   4 +-
 lib/tpm_tcg2.c         |   9 ++
 test/cmd/hash.c        |  48 ++++++-
 16 files changed, 552 insertions(+), 4 deletions(-)
 create mode 100644 cmd/sm3sum.c
 create mode 100644 include/u-boot/sm3.h
 create mode 100644 lib/sm3.c

-- 
2.20.1

base-commit: 9094482ca7576877b2bfaa57c8e73cfeb536f8b9
