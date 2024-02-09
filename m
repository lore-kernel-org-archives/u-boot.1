Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39374C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 12:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A88887E66;
	Fri,  9 Feb 2024 13:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="rWJoORuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D71487E50; Fri,  9 Feb 2024 11:30:31 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E7187E5D
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 11:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rYO9G-0002ci-3w; Fri, 09 Feb 2024 05:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=6fERyOhsrV/uJf6Cd+LQIY5g8+fzqAfaQoEUke2NoeY=; b=rWJoORuL5roDFE
 I3k2qFZfYXLLiP+23RGoR+rm4EPC4tWcK7BWEN0FqHRbiZU/btA1nbXRIO/6SHwMFu48iC68kvFby
 V5JokajM4GfH7cpcMcYnFwGTkkzl14QNiXokyNhzzvTOzhMPbAL1H3AEAH4V8ik/4gFz6sZIu1jSs
 gW1n33Ag2rzEzckoZDi6biaf3waTzzWwoq4t7LJkgBLUM7rARRDyzopcUrgTJFf0THMTn9r9TjQZN
 +DVo6lVc8O/kxSBmp38IBHth/GGJmndeTmBPXls6KFPO4AhG5KfhXaAkJJX2YPFyc179z0kHoya7i
 f+VnyjZYruBLJ0XAlm3Q==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 0/3] imx93_var_som: Enable AHAB support
Date: Fri,  9 Feb 2024 11:30:06 +0100
Message-ID: <20240209103009.5463-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Feb 2024 13:04:59 +0100
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

Hello,

In this v2, I moved imx93_probe_mu to a dedicated header.

Thanks,

Mathieu

Changelog:
v2: Move imx93_probe_mu declaration to a header file

Link to the previous revision:
v1: https://lists.denx.de/pipermail/u-boot/2024-February/545528.html

Mathieu Othacehe (3):
  imx93: Use a header for imx9_probe_mu declaration
  board: imx93_var_som: Probe ELE MU
  configs: imx93_var_som: Enable AHAB support

 arch/arm/include/asm/arch-imx9/mu.h | 13 +++++++++++++
 board/freescale/imx93_evk/spl.c     |  2 +-
 board/phytec/phycore_imx93/spl.c    |  2 +-
 board/variscite/imx93_var_som/spl.c |  5 +++--
 configs/imx93_var_som_defconfig     |  1 +
 5 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-imx9/mu.h

-- 
2.41.0

