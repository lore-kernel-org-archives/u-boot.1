Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC330CD11DD
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 11:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D8F8824B;
	Fri, 29 Mar 2024 12:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711711104;
	bh=Oura5P+wXKzhtyuOPc+oulblrfwIm2fis6xzAXeptlo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jPMQjLAbIELnkX+6xloL6B+8Z88Xu7fwgWAsYFDZ42MufI/UhYfuideZ6kNbuGwnw
	 ZXXB012UKoNnQ82Fm3jJ65TeJlW4JSYFLDMCWjTfifHKTI0yH84KCjMTy/O0oOPoM6
	 VL0Pyp48Dm2kUK7RniYBkeG1iWduIvLbyuzTx0XfUy8/IqssNuKCAfBNPtN0HVKN2Q
	 7DQ4Xakmjw4ETmQ+Gr3OSvXk6vo2sReNEdUFYnSrrJojf2Lkbv+Xkhpk9uZkHYvSlb
	 Q9WcX1F9obLmwiruSEg5Q8ov3TES5Qmh/qmcpyT+k5P2QBiaK0Ui1q7UPuUmTjq+C/
	 JzDsURNF2TGJA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B106488089;
 Fri, 29 Mar 2024 12:18:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711711103;
 bh=Oura5P+wXKzhtyuOPc+oulblrfwIm2fis6xzAXeptlo=;
 h=From:To:Cc:Subject:Date:From;
 b=GnIggyF5wSOnvwAfnRodFJkldXC51vngNXIEM/1lFO+NPDaV9AS0LOr0SuCt8JXmd
 CV8ZnkfPPvJVE5fYskI2GaUPQFsByw/QXm+ZQ2qD1x8WPYZlRxGQ4k7uIYaKnZngy1
 fm0cayKmjaaWbPm1iAhvQ0hyhsHkhuMQy2axw8LgrFPJG172IPS2WJbot0dxAIgrQB
 hkmmvSdROXxF/dTkPN1On/6xY1Kj7s7qWmldsy3TXdO3/jpk3iQj0j/lWnD05ouJUM
 eU+RmkaKZlfGttoUnf80hi7wN6ubRV3cbmQYYzoEVnLPbXyjv07uI9mPgSa9JgWYMW
 nUZghblL0l+fQ==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] arm: xea: Provide enhancements for XEA board
Date: Fri, 29 Mar 2024 12:18:05 +0100
Message-Id: <20240329111809.3959962-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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


This patch series is a preparatory patch for supporting
different versions of XEA board HW (until problem with
Linux kernel support for multiple revisions is resorted).

Moreover, limits for u-boot.sb and u-boot.img has been set
to avoid binary sizes exceeding in the future.

Changes in v2:
Remove "inline" from get_som_rev() function definition
Squash with 'config: xea: Enable late board initialization to set revision variable'
Update commit message
Squash with 'arm: xea: Print information about XEA's SoM HW revision'

Lukasz Majewski (4):
  arm: spl: xea: Remove I2S pins configuration from early initialization
  arm: spl: Add definition for PHY reset GPIO for XEA HW rev. 2
  arm: xea: Add support for reading SoM (CPU) board HW revision
  config: xea: Add limits for SPL and u-boot proper sizes

 board/liebherr/xea/spl_xea.c   | 21 +++++++++------
 board/liebherr/xea/xea.c       | 49 ++++++++++++++++++++++++++++++++++
 configs/imx28_xea_defconfig    |  4 +++
 configs/imx28_xea_sb_defconfig |  1 +
 4 files changed, 67 insertions(+), 8 deletions(-)

-- 
2.39.2

