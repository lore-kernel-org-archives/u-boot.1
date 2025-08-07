Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9D6C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 07:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC08D83A97;
	Thu,  7 Aug 2025 09:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754553437;
	bh=rsg4HLTtltqpYKiiHUTmykingwNqyNi5c6Ul9y7/dnA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vdV3QJMkipWr4Twmo5ZDEpUV0uQSbr37JQAwLUUM59nhQ1a+TmG38QHc49RzWo9MY
	 hUG8ijIGNmbNDTQiDoab+irjRh/qJbLUTtfKAkLvfRDd2rFMsfZZDkmMTAeRy14Fwe
	 hrjmVv/pLnhd05TKb5r96ECMWknJGNLShFcXU5RFcpsj1/R1MOAvxDt3+vvxJEdfw0
	 TnNYCkJWdhw3PBICBHPnqpXdULjMocifYs7Kjy7sjEO4f3b4eGwMnTNi15YonlnZP+
	 b4s/WFAQgO6ZaSGcoC4ieujrnmzCQhRsG28ohJWxQzsIeQfWJA8kSY++0RhsHPipV8
	 fo6tzP0+mbifg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F2883BEF; Thu,  7 Aug 2025 09:57:16 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF09B83A92
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CBtXm6I7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 168951038C126; 
 Thu,  7 Aug 2025 09:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754553433; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=rsg4HLTtltqpYKiiHUTmykingwNqyNi5c6Ul9y7/dnA=;
 b=CBtXm6I7wR5VwBiTF/xR7OfF41i6bP2qCVXamoeGK30JM6aYQ8Yvl8AlOTKK5ExXAP3rvr
 k9sfLlE2ddzQ5p04LCx03mcynlbPCuX/xy1UAnhcJ++XvEoJVzcvg0mC7+4TcHdNuUCYiy
 DOCX4s4W1gtE+HDkpXJQxk3q1UXOwm255M2ObKogh7ZjnWSCpIGkgdI3EWeu8DnQTMZeq8
 31TCEvEfsAiY7aYPecRLQtNPpEMIVX0sa7Gi/2V4tMSY9eydfMWflPaTi/gl2RSmlbFmx9
 wW//z3eo/EAse5LhKMFRMamSal3vAdITNDNTQDkvkAwWdFRpuplDAR1IFg61Xw==
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
Subject: [PATCH v6 0/4] Add Onion Omega2/2+ board support
Date: Thu,  7 Aug 2025 09:56:49 +0200
Message-Id: <20250807075653.356088-1-pro@denx.de>
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

Add support for the MediaTek based boards by Onion. Commit one to three are
rather generic, whereas the last commit adds the actual board support.

Changes in v6:
	- Remove all vendor specific code from the board files.

Changes in v5:
	- Reimplement the Makefile size check.

Changes in v4:
	- Rebase board support to v2025.07
	- Add new commit to silence warning in arch/mips/

Changes in v3:
	- Simplify image size check.

Changes in v2:
	- I forgot to run checkpatch in v1. Fix some style issues in v2.

Philip Oberfichtner (4):
  Makefile: Simplify size check
  Makefile: Add size check for u-boot-with-spl.bin
  mips: serial: Silence "unused variable" warning
  mips: mt7628: Add Onion Omega2/2+ board support

 Makefile                                  | 45 ++++----------
 arch/mips/dts/Makefile                    |  1 +
 arch/mips/dts/onion-omega2p.dts           | 58 ++++++++++++++++++
 arch/mips/mach-mtmips/mt7620/serial.c     |  2 +-
 arch/mips/mach-mtmips/mt7621/spl/serial.c |  2 +-
 arch/mips/mach-mtmips/mt7628/Kconfig      |  7 +++
 arch/mips/mach-mtmips/mt7628/serial.c     |  2 +-
 board/onion/omega2p/Kconfig               | 12 ++++
 board/onion/omega2p/MAINTAINERS           |  6 ++
 common/spl/Kconfig                        |  7 +++
 configs/onion-omega2p_defconfig           | 73 +++++++++++++++++++++++
 include/configs/onion-omega2p.h           | 15 +++++
 tools/spl_size_limit.c                    |  2 +-
 13 files changed, 194 insertions(+), 38 deletions(-)
 create mode 100644 arch/mips/dts/onion-omega2p.dts
 create mode 100644 board/onion/omega2p/Kconfig
 create mode 100644 board/onion/omega2p/MAINTAINERS
 create mode 100644 configs/onion-omega2p_defconfig
 create mode 100644 include/configs/onion-omega2p.h

-- 
2.39.5

