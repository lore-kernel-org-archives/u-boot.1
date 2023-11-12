Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67C6C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 14:40:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D1F86DA2;
	Sun, 12 Nov 2023 15:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="o9R771+J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFBEA86F68; Sun, 12 Nov 2023 15:40:11 +0100 (CET)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8831186D23
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 9ED80240103
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 15:40:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1699800006; bh=FSsMFnPJGNdG3U8CdSrwgSq9ZBYK8US05caiNOIK3jM=;
 h=From:To:Cc:Subject:Date:Message-Id:From;
 b=o9R771+J/y0Itp6HqiOoCQQRfbFCCFOm1wPwMkK+/lwTbU+gVDmkY1wD5Rc7Om2C9
 JI8/NgKz3doSPgnX0ihVVDDAgTdAYa+X9Xcl86HYoC9n7VRmcSYtoaI943HJDpDwxg
 FtPOEqFj8k29KKYhi4kxGAD0PZsneE5CeDIx/17EaZNlmFoC9CV5PtHRMUccLNpE5p
 ghkzncHCvdUgr07jZnDIxksPeq98yyT63N7AWfwxAwk/kreG/C8eoTv3iOoo/09hpj
 Y40ZP1KxLy5SP0U4vLrqb9gohhEnNxpQbFxDBrmFGZF+aVWXzZzyxchuug21j3ktwO
 8ownrMFkD13YA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4SSwFf0R9pz9rxH;
 Sun, 12 Nov 2023 15:40:06 +0100 (CET)
From: Stefan Bosch <stefan_b@posteo.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Stefan Bosch <stefan_b@posteo.net>
Subject: [PATCH v1 0/2] arm: s5p4418: fix relocation
Date: Sun, 12 Nov 2023 14:38:09 +0000
Message-Id: <20231112143811.3606-1-stefan_b@posteo.net>
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

