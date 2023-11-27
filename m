Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5AAC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E59BB87782;
	Mon, 27 Nov 2023 19:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="gYL+EvxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 763ED875A1; Mon, 27 Nov 2023 19:27:55 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85DE987782
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 2C418240104
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1701109673; bh=hM1z2w8PdZsWvC89qugbPBlV0zg2c4LNKRSU7vqnvxQ=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=gYL+EvxSeIzEpgZhCmSuX1lC7RN/mPKVcji5gdDMCHn3Kkgm5AWEGlkAQFLeJdcKe
 lP77VQ1Jiguaxc4IGgEiNLdRjiPyEtVcPWUi1e4Ga+hxTNR+YTHXZyODuKFSgbtVnQ
 DeQ4emKbBCN2StMxTRVsg7dOlwdSK60AXw67Sn9iIDP9vU/FKo6I93W+OrGxrfHx2d
 OGLULBDrPMCzRHsu+BULzqka6xitdHssYamulXj36LPOOwMN3ULPj7X/Z8fg8FItpW
 XU5IOs3ZuahasLCl//KknbTIs5jQhhK+0iLhs8QcArvI48WiCYD0mV5yaKSAstonqh
 vc32sPW9YU/gA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4SfDbX43yhz6tvq;
 Mon, 27 Nov 2023 19:27:52 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v2 0/2] arm: s5p4418: fix relocation
Date: Mon, 27 Nov 2023 18:26:07 +0000
Message-Id: <20231127182609.4663-1-stefan_b@posteo.net>
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

Changes in v2:
- Cosmetic: Fix spelling mistake in commit message

Stefan Bosch (2):
  common: board_f: change calculation of gd->mon_len to fix s5p4418
    reloc
  arm: s5p4418: fix relocation of vectors

 arch/arm/cpu/armv7/s5p4418/Makefile   |  3 +++
 arch/arm/cpu/armv7/s5p4418/relocate.S | 24 ++++++++++++++++++++++++
 common/board_f.c                      |  2 +-
 3 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/cpu/armv7/s5p4418/relocate.S

-- 
2.17.1

