Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6ECCCFA03
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 15:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 805D08389A;
	Sat,  1 Nov 2025 16:15:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="j9ZTaq+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC62883AAE; Sat,  1 Nov 2025 07:49:27 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 926ED83A92
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3C4071096DF; Sat,  1 Nov 2025 07:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761979763; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Sndv4hCvYZTOa19sM3TWZoI8YENct9kGfdUMoJWT3Ls=;
 b=j9ZTaq+AUKff6xe9K3Lw+VsYHUhtd+tlYMt4X6xq5eLs/qHMrrb0yzx+IhNfOa1KY0v4Jt
 w/uXfNRN8oZJijvll3x5bsUGOlZ00I/Qt5Weo2G5dU9JxQOmEUdNTMVwP868kWAZPhFmu/
 jdBNpNWWI9Vns0dJEUJw8Rmga0s2BECt9EGybGlCqQX3upmp12xlY8yFZf94vcm0KrjdbQ
 I0K0nzotfLQoW9s9GXcj4BxqxwQWEZj6d/z0+uFN1skqxkk34io0a7ByOdK2mSed0UxwGq
 w9ggPXJL4DRu54POTypYDQrwWrEQyL/96zzw6JmYCy0/yXTORD9kS0/SYuZ+tg==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH v1 0/5] Add support for SM3 secure hash
Date: Sat,  1 Nov 2025 07:49:02 +0100
Message-Id: <20251101064907.5037-1-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Sat, 01 Nov 2025 16:15:06 +0100
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

TPMv2 defines hash algo sm3, which is currently
not supported and prevented TPMv2 chip with newer
firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C

    u-boot=> tpm2 init
    u-boot=> tpm2 autostart
    tpm2_get_pcr_info: too many pcrs: 5
    Error: -90
    u-boot=>

Implement sm3 hash, so we can fix this problem.

Azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=188&view=results


Heiko Schocher (5):
  lib: Import rol32 function from Linux
  lib: implement SM3 secure hash
  test: cmd: add unit test for sm3 hash
  tpm2: add sm3 256 hash support
  test: cmd: fix a typo in md5 test

 MAINTAINERS            |   7 +
 boot/Kconfig           |   1 +
 cmd/Kconfig            |  16 +++
 cmd/Makefile           |   1 +
 cmd/sm3sum.c           |  48 +++++++
 cmd/tpm-v2.c           |   1 +
 common/hash.c          |  43 +++++-
 include/linux/bitops.h |  11 ++
 include/tpm-v2.h       |  12 ++
 include/u-boot/sm3.h   |  34 +++++
 lib/Kconfig            |   7 +
 lib/Makefile           |   1 +
 lib/sm3.c              | 313 +++++++++++++++++++++++++++++++++++++++++
 lib/tpm-v2.c           |   4 +-
 test/cmd/hash.c        |  48 ++++++-
 15 files changed, 543 insertions(+), 4 deletions(-)
 create mode 100644 cmd/sm3sum.c
 create mode 100644 include/u-boot/sm3.h
 create mode 100644 lib/sm3.c

-- 
2.20.1

base-commit: e6d1bcd668341af940254482b206a484e6a98db9
