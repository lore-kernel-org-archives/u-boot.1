Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39B5C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 12:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D3268305C;
	Tue, 27 May 2025 14:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1748347923;
	bh=SW0jqyLxhWhipnd3gim1D0y8J2RPXNlrYvt6ZEHADaE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Gnc6Lk0ZmVz6fWgI7sXelDzZ2RsVyNAcG3GMMHKJ7XOL41zgq0CKCgJ/IFc8DbcCG
	 70NOhX0av6Ihk28w9aJA5EGy0vDbbXORYr2HEqo8zArrhXovrSSvRtcqgEj08DD0t6
	 PKgMiWxfgEJofDyhablbbQqFz/zRH+3kV/pNxt1dgV3Sq1uL1gWH4mxfZvILDsHQ/G
	 ugvDVeQ1cYB6lI4BZdsg2yY58R9LXdDpS6yw1DDgVWqBVvVg1OzobcogH/+a9QT9Pm
	 QsD4BK/8xUbtpH0KSb8R4MJF1UmbNJIvuSxXcnxEfxu+MjTk5aZtB58eYVh+RbaYq+
	 81Cn+4O6WAmAw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B8883087; Tue, 27 May 2025 14:12:00 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF20F83010
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cveJfdlt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1BB11039728C; 
 Tue, 27 May 2025 14:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1748347917; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=SW0jqyLxhWhipnd3gim1D0y8J2RPXNlrYvt6ZEHADaE=;
 b=cveJfdlt5gX1NvwllMR/ivSeeZ4r5Nz27zeOoQaMxR/MwQjgpF/knpHGa3Dtq3BkkI1Sh6
 vgJCJjLP3U4UZLf3qmo3ZvW4ysAthk+WayLkPXehZUtctlEotAabOGPkJJAHWJUGqTxRXL
 xjiZaD+I5OXHjVG5j7QGmGMxg+ytz6owp8+dzL4ooXsvpsLkTvHZFOqldabu5K6+dEjIeY
 ofv55t0UFuZ05tFxfttHDeTlLwFgNWj2IOyrJRVN1DgQ0vSD8TM+sU0KXjrlVXduYFc2SM
 7qvKsH/wDDnd+w4aieIT4BV4FBwkOQTekDRNiOiaj4Rt/dVXmE1VaamKrwoJ+A==
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
Subject: [PATCH v2 0/2] Add Onion Omega2/2+ board support
Date: Tue, 27 May 2025 14:10:47 +0200
Message-Id: <20250527121049.106825-1-pro@denx.de>
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
--------------

I forgot to run checkpatch in v1. Fix some style issues in v2.

Philip Oberfichtner (2):
  spl: Add size check for u-boot-with-spl.bin
  mips: mt7628: Add Onion Omega2/2+ board support

 Makefile                             |   7 ++
 arch/mips/dts/Makefile               |   1 +
 arch/mips/dts/onion-omega2p.dts      |  58 ++++++++++++
 arch/mips/mach-mtmips/mt7628/Kconfig |   7 ++
 board/onion/omega2p/Kconfig          |  12 +++
 board/onion/omega2p/MAINTAINERS      |  10 ++
 board/onion/omega2p/Makefile         |   3 +
 board/onion/omega2p/board.c          | 134 +++++++++++++++++++++++++++
 board/onion/omega2p/omega2p.env      |  18 ++++
 common/spl/Kconfig                   |   7 ++
 configs/onion-omega2p_defconfig      |  81 ++++++++++++++++
 include/configs/onion-omega2p.h      |  15 +++
 12 files changed, 353 insertions(+)
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

