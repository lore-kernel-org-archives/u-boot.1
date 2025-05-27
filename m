Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D27C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 11:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923DA82E31;
	Tue, 27 May 2025 13:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748345902;
	bh=zXWgQd/TV1CG5ZwXb+ta36kJOWzEaYqn+QRvPXotGSs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ldBY+hI4tUcYUXcK5WNbfud5Sh7ZdVp40ATnZF6ZrBut0aAFEwnAgPUz8A7/3vXwE
	 n8MjB2pyLhdR8L0VKiZ/FMPsRPjHUrykawzL7nMN01tkMKgFrQJoA5mFEnlJIKP6Tv
	 4ms1ZAwaG0KOcMfgAAXD/loImNzV9/S6+HziZE2k0FPFjpjgBfzzg1FEnY4wKnzgQx
	 C417Zn3USnX+d+hU+gcFAnP775pOVlXOgdDTxTSeqRDa74rjrX47lvLVVpZR2RYUBd
	 8Er5RKHTyBSyB9686UT2d8HQ5sx768HMfmfOCPpgvLFLN8qBRJTtbSigQEzEX+XtUM
	 Dm1kmEiKLJJgw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E09A78300F; Tue, 27 May 2025 13:38:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E58A282B7C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="N/SChglt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7E2921039728C; 
 Tue, 27 May 2025 13:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748345897; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=zXWgQd/TV1CG5ZwXb+ta36kJOWzEaYqn+QRvPXotGSs=;
 b=N/SChgltaMtPbbgqqLuv2BBoaaJLCi+mm4hKxIckQrDSW8TorKVU0r8dKaoPvW1xjGVIAl
 51IDR6XoJxcHBsg6xdEQ1pkqLauGvXytg3V5r26+OHUGd5kIc/f8Xm94aLZph4v14+K9Cv
 h63FCNjc5flC5MUFIUmXEwjsu2FvxgF5BYDBnyZrdRMrl9a/UIUkR1cbK1N7OTXCCxm84a
 PmfFNm0mztaC0OBE7q9CtbklqVeA2lKocuXfa95IcYvomxC1DcxkbvyLwNHI+jgJrCqPO3
 pnPMT/1IKxe0IN7J10snKA3L0mTyodib92KUPR85TmBnj9vqVLfy8QQb85XO2Q==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>, Anshul Dalal <anshuld@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 0/2] Add Onion Omega2/2+ board support
Date: Tue, 27 May 2025 13:37:49 +0200
Message-Id: <20250527113751.95741-1-pro@denx.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
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

Add support for the MediaTek based boards by Onion. Whereas the second commit
adds the actual board support, the first commit handles a tight flash size
constraint for the u-boot-with-spl.bin image.

Philip Oberfichtner (2):
  spl: Add size check for u-boot-with-spl.bin
  mips: mt7628: Add Onion Omega2/2+ board support

 Makefile                             |   7 ++
 arch/mips/dts/Makefile               |   1 +
 arch/mips/dts/onion-omega2p.dts      |  58 ++++++++++++
 arch/mips/mach-mtmips/mt7628/Kconfig |   7 ++
 board/onion/omega2p/Kconfig          |  12 +++
 board/onion/omega2p/Makefile         |   3 +
 board/onion/omega2p/board.c          | 134 +++++++++++++++++++++++++++
 board/onion/omega2p/omega2p.env      |  18 ++++
 common/spl/Kconfig                   |   7 ++
 configs/onion-omega2p_defconfig      |  81 ++++++++++++++++
 include/configs/onion-omega2p.h      |  15 +++
 11 files changed, 343 insertions(+)
 create mode 100644 arch/mips/dts/onion-omega2p.dts
 create mode 100644 board/onion/omega2p/Kconfig
 create mode 100644 board/onion/omega2p/Makefile
 create mode 100644 board/onion/omega2p/board.c
 create mode 100644 board/onion/omega2p/omega2p.env
 create mode 100644 configs/onion-omega2p_defconfig
 create mode 100644 include/configs/onion-omega2p.h

-- 
2.39.5

