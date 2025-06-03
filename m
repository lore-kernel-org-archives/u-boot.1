Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AEDC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 09:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1375481F0D;
	Tue,  3 Jun 2025 11:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748941739;
	bh=bpubx7LNbMPiJcqnFki0YASOGE0a8IqBSPGQ85XQAE8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j77LamylUs1KU45rk4XR217vaNb9liY9gUIFGRLNmXT6G0scsidO+DNF5nxeq9x49
	 p2rJlxvFCOS7lhL2RFoct60NwioCr6wi9dWtub85ds3hbI/73sp1YYLpO9tTWWVFkO
	 Ck89IntNbDL4QIjaGxn70KMkUoyaqEjH91jPsMLuvrhm+Dlm44Uqd2Kh5Y55DSnz8n
	 p8MPKUDcfPJeIEj9e74oFzFovwAG4W7DIr2j9AbWFHiq1QPeUwg4BNRzven0DkpdXc
	 4hKG3gnBM7IGEcGcwla7UrjSdWqTevQ+3B5S7qj+ixCFMpDir83VI7CAd6VcG5Qs3a
	 TcReYahs9mZxA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B2E81FFC; Tue,  3 Jun 2025 11:08:57 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8945F81E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 11:08:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BtQRODQH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5606110397298; 
 Tue,  3 Jun 2025 11:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748941734; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=bpubx7LNbMPiJcqnFki0YASOGE0a8IqBSPGQ85XQAE8=;
 b=BtQRODQHI3FRKq4ClekufdVU5wC9QAwRkjcpg/6UvJnB3Ii6XMZJuMSnh/552J7vNQ6BPy
 VIBcbfG6q8/ZCXNDsYa1yFXburjdMxIyMySgs5cW9sfPl7HOUeDpf/2TeuBA+maWfleO0q
 Y96clJJJaUDf2ZjlBN32YtKcnvEzExcjfqcs19FQD9RTWQ4LhpKnptJ4sQqqQo9FtIkiCL
 XQGFj37+2pfXdLjO/9nIN5P4kNuCTtgboj+xmbbc73sYb1U+gePUrw7I4KOQApFHv+5QKx
 wJ5SrjinIV8CreJ9SJvDMBbK8Kt8PGCkP5UpWdQ2o1Xry6U5tjzMO5u5AexgYg==
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
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 0/2] Add Onion Omega2/2+ board support
Date: Tue,  3 Jun 2025 11:07:57 +0200
Message-Id: <20250603090759.162308-1-pro@denx.de>
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

Changes in v2:
	I forgot to run checkpatch in v1. Fix some style issues in v2.

Changes in v3:
	Simplify image size check

Philip Oberfichtner (2):
  Makefile: Add size check for u-boot-with-spl.bin
  mips: mt7628: Add Onion Omega2/2+ board support

 Makefile                             |   1 +
 arch/mips/dts/Makefile               |   1 +
 arch/mips/dts/onion-omega2p.dts      |  58 ++++++++++++
 arch/mips/mach-mtmips/mt7628/Kconfig |   7 ++
 board/onion/omega2p/Kconfig          |  12 +++
 board/onion/omega2p/MAINTAINERS      |  10 ++
 board/onion/omega2p/Makefile         |   3 +
 board/onion/omega2p/board.c          | 134 +++++++++++++++++++++++++++
 board/onion/omega2p/omega2p.env      |  18 ++++
 common/spl/Kconfig                   |   2 +-
 configs/onion-omega2p_defconfig      |  81 ++++++++++++++++
 include/configs/onion-omega2p.h      |  15 +++
 12 files changed, 341 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/dts/onion-omega2p.dts
 create mode 100644 board/onion/omega2p/Kconfig
 create mode 100644 board/onion/omega2p/MAINTAINERS
 create mode 100644 board/onion/omega2p/Makefile
 create mode 100644 board/onion/omega2p/board.c
 create mode 100644 board/onion/omega2p/omega2p.env
 create mode 100644 configs/onion-omega2p_defconfig
 create mode 100644 include/configs/onion-omega2p.h

-- 
2.39.5

