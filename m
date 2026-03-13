Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF75105F796
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69E484253;
	Fri, 13 Mar 2026 11:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qUO7Sna+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F07A84253; Fri, 13 Mar 2026 11:42:44 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A4938420C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D3039C42701;
 Fri, 13 Mar 2026 10:43:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B428A60027;
 Fri, 13 Mar 2026 10:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6432910369E9B; Fri, 13 Mar 2026 11:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398561; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=5QE3K5mzvACWYrQd3EOiYl2LkQur8+mQBhughfvGSc4=;
 b=qUO7Sna+tE90gWlBWK1pwyMaUzRCH3kbDNSCDDAsp9IZFWpBEH3pcF/PW8muev+3PwbNES
 JHV3rjLAc4pvgaCWlHTCKkrzxjUULt/dZfFhVah2vDrmMAF88pWcemekxJpdV0j8aTdi2m
 vdd7V4oKu+e3lBkSAEx5OB0W1vNaUPEue1f9no4k9tWukLEAM/+mTVCJSW/udGH+LjcYdN
 X34ucEhFgGyS3taywwsL58BNuz7A+npTAeLacdTVZ1bHhN8779MaRcE/kFjjIxyLAln6eO
 EOo7A0DAR/QUqhAOsMepjbyW3nHYN6Gy5x9oABwUXxi9UkwetSPzrf2nBZ4smw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 0/7] Introduce SQUASHFS support in SPL
Date: Fri, 13 Mar 2026 11:42:22 +0100
Message-ID: <20260313104229.1555236-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

SquashFS has support in U-Boot, but not in SPL.

This series adds the possibility for the SPL to load files from SquashFS
partitions.
This is useful, for instance, when there's a SquashFS rootfs containing
U-Boot binary.

NB: falcon mode is not supported yet.

Richard Genoud (7):
  fs/squashfs: fix sqfs_decompressor.c build in SPL
  fs/squashfs: sqfs_decompressor: simplify code
  fs/squashfs: squashfs.h: include file should be self dependent
  spl: add squashfs support
  spl: mmc: support squashfs
  MAINTAINERS: SQUASHFS: update João Marcos Costa email
  MAINTAINERS: SQUASHFS: Add myself as co-maintainer

 MAINTAINERS                     |  6 ++-
 common/spl/Makefile             |  1 +
 common/spl/spl_mmc.c            | 19 +++++---
 common/spl/spl_squashfs.c       | 78 +++++++++++++++++++++++++++++++++
 fs/squashfs/sqfs.c              | 12 +++--
 fs/squashfs/sqfs_decompressor.c | 71 ++++++++++--------------------
 include/part.h                  |  1 +
 include/spl.h                   |  6 +++
 include/squashfs.h              |  5 ++-
 9 files changed, 135 insertions(+), 64 deletions(-)
 create mode 100644 common/spl/spl_squashfs.c


base-commit: ba7bf918dafcd093ad733b07ba490baeb20cf5da
