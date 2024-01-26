Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38BEC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B7B187B98;
	Fri, 26 Jan 2024 13:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="EbhvOeK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF60A87BAD; Fri, 26 Jan 2024 13:53:04 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0AD187775
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 4A2C3240029
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 13:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1706273582; bh=RSsmI+S1J3GaTyh4yV52ytc1dpog3Ehk6Yd2D81IWfg=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=EbhvOeK4hVeUGE1CjYEr/hIX1bxUvNNCdxQoZSekDM5rvld8HOpVFbi/K54OKKER/
 gRJoTO17aR8/xXSoaYE1iNMM1ZDDVX9Xu3eG/aYEvvQMJtg1lQGz4QIept+sGB+i7s
 XRcG8ODvQkTHV10JNaMweatzXCWJVahuN5wHxOJFbTl7FIJUf+HOsLTB/UzW1cUfLC
 OnIPzhlhjpsfMEbILPDFjU9chfD1GEkf+aKugJYzeGEv3ky46iJCeWPuBDASt4wcSZ
 pPefyWGWNySaw6uQj1+jEFMAtwYI1PsmdKq3MjTOY+/SQ0bzw7RSuqYtvActNKWr55
 tWhYH+JphEH9Q==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4TLyKT4JXCz6trs;
 Fri, 26 Jan 2024 13:53:01 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v3 0/2] arm: s5p4418: fix relocation
Date: Fri, 26 Jan 2024 12:50:54 +0000
Message-Id: <20240126125056.16439-1-stefan_b@posteo.net>
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


Fix relocation of u-boot for s5p4418-SoC. I.e. use __image_copy_start
instead of _start to calculate the monitor length. Furthermore use an
adapted version of relocate_vectors for the s5p4418-SoC. Background:
The header (NSIH) used by the 2nd-bootloader (included at the begin of
u-boot.bin) is not loaded into RAM. Therefore _start has to be after
the header and therefore is not equal to __image_copy_start which is
at the begin of the header.

Changes in v3:
- MICROBLAZE has not built anymore. Therefore do change calculation of
  gd->mon_len for ARCH_NEXELL only. This makes sure that MICROBLAZE and
  other ARM-boards are not affected.

Changes in v2:
- Cosmetic: Fix spelling mistake in commit message

Stefan Bosch (2):
  common: board_f: change calculation of gd->mon_len to fix s5p4418
    reloc
  arm: s5p4418: fix relocation of vectors

 arch/arm/cpu/armv7/s5p4418/Makefile   |  3 +++
 arch/arm/cpu/armv7/s5p4418/relocate.S | 24 ++++++++++++++++++++++++
 common/board_f.c                      |  4 +++-
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S

-- 
2.17.1

