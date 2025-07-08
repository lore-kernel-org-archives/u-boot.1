Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14E3C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1952683018;
	Tue,  8 Jul 2025 12:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751971226;
	bh=I0HbcrfF25SPFFEnqI74YnGoi7GqCDT98umh4EX1IYc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ftFkwMPpJSctgsuwz5ydRyjSfiG/u0oGO6a5kOQBQpwJqvCltrs5GXotzC67O/hBM
	 +NQxmT0TNJlsCJTerd6B9m5fQcrZomXURHx556wHHdqjrZwSMJ3Vuyn+XLjCvjtwcb
	 CrgAfmJqMPHrmvIjSI0PcJANsOAFlxkRMKbnFl03i8RpEq2UGK5XLL/+On5NDPz/gF
	 t4gnjh5iYXCnxLDNfb+dShcKJe2LrRjy/4VKGMiyIj7A42SRE5OufCzlhuPpQF8aAn
	 q1gjhRj9Ot+TD3jMh/Nvd1/nXAKADrGSFJ8Ss0ERT0iKtI9GcA7zg4x6oWKw8UzIo2
	 ZD3gC81wRrDyw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B9583043; Tue,  8 Jul 2025 12:40:25 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37E4F83015
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FUpLsbiG"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3CE8910380104; 
 Tue,  8 Jul 2025 12:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751971221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=I0HbcrfF25SPFFEnqI74YnGoi7GqCDT98umh4EX1IYc=;
 b=FUpLsbiG77J06LHrnpdQY1LDhFFHx0eqUpkbZN28kYjO8ucr8SgKXp7HPk44dO+v7VNuu2
 HS1E1vvqTild/dD/oAX+N0RjsFpDRN97AtJ70avhjLUicmrxFJmMcyoeYOB7suk/CSDUbl
 AqlA2U19EY6CQm4JG3DwziiRHI9GPsDny2FzY6J1xU1I1STroXy7xrwuHnpdB9Al0QYecv
 9T0nI5DHaR7zBo518rnO9J1/6aNmKfzU4PsemaebhPJxttyZTmFiQgD/K7BqIiDxtIXXZ1
 M3h5RXj/UsWUxrRASnpvCzJdZJE5cYHMWmsmF8N+VdhuIgeZ91797Jd0Kui8ag==
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
Subject: [PATCH v4 0/3] Add Onion Omega2/2+ board support
Date: Tue,  8 Jul 2025 12:39:56 +0200
Message-Id: <20250708103959.26129-1-pro@denx.de>
X-Mailer: git-send-email 2.39.5
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

Add support for the MediaTek based boards by Onion. Commit one and two are
rather generic, whereas the third commit adds the actual board support.

Changes in v4:
	- Rebase board support to v2025.07
	- Add new commit to silence warning in arch/mips/

Changes in v3:
	- Simplify image size check

Changes in v2:
	- I forgot to run checkpatch in v1. Fix some style issues in v2.

Philip Oberfichtner (3):
  Makefile: Add size check for u-boot-with-spl.bin
  mips: serial: Silence "unused variable" warning
  mips: mt7628: Add Onion Omega2/2+ board support

 Makefile                                  |   1 +
 arch/mips/dts/Makefile                    |   1 +
 arch/mips/dts/onion-omega2p.dts           |  58 ++++++++++
 arch/mips/mach-mtmips/mt7620/serial.c     |   2 +-
 arch/mips/mach-mtmips/mt7621/spl/serial.c |   2 +-
 arch/mips/mach-mtmips/mt7628/Kconfig      |   7 ++
 arch/mips/mach-mtmips/mt7628/serial.c     |   2 +-
 board/onion/omega2p/Kconfig               |  12 ++
 board/onion/omega2p/MAINTAINERS           |  10 ++
 board/onion/omega2p/Makefile              |   3 +
 board/onion/omega2p/board.c               | 134 ++++++++++++++++++++++
 board/onion/omega2p/omega2p.env           |  32 ++++++
 common/spl/Kconfig                        |   2 +-
 configs/onion-omega2p_defconfig           |  82 +++++++++++++
 include/configs/onion-omega2p.h           |  15 +++
 15 files changed, 359 insertions(+), 4 deletions(-)
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

