Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E9BC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B93D87F46;
	Mon, 26 Feb 2024 18:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="cPo3/c40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7756D87BD6; Mon, 26 Feb 2024 18:37:39 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D3E87F21
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1reeuy-00070T-NM; Mon, 26 Feb 2024 12:37:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=boRvRPl5yf4gbLAH6IL3HV4p7hiy1AU98EFwAPNdKWg=; b=cPo3/c408xpUqK
 aTUcQ/Mo1AJdqT7vB65ql4BU56tPkGWqK0rfzOdKCXbrQv4K0iTaFduj9QNFPsdkyifn3A4rL5NMt
 aHijW1f1RObed4c5wQvXwZb6H4mVJRu/+uZxcR6jKkwTBNWApI8bdTo+JVdDu2AHc4zv7ggLHotfg
 CIOm0AaQdOR+Fd8uM2mFnnouoGnxwf0qIL4u6cThqfiAvNLYtuV+CBO2AIYM/gQLEs83OHj6XW3Nq
 Rfgfq8V5TjyGSyGWBtO97jZ4Wzmb+0ni5VhWm4z57XL96YdU4B9djsksXaFvpDATOC6lo8fYr8AJY
 gzbZy+Cvs+WUo0FQSX+A==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 0/2] Fix OP-TEE support
Date: Mon, 26 Feb 2024 18:37:17 +0100
Message-ID: <20240226173719.25629-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Feb 2024 18:45:46 +0100
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

This series fixes OP-TEE support on all imx9 boards by starting the ELE RNG
and adding the optional tee.bin binary to the ATF container.

Thanks,

Mathieu

Mathieu Othacehe (2):
  imx9: Fix OP-TEE support
  tools: imx9_image: Reword warning message.

 arch/arm/mach-imx/imx9/container.cfg | 3 ++-
 board/freescale/imx93_evk/spl.c      | 7 +++++++
 board/phytec/phycore_imx93/spl.c     | 7 +++++++
 board/variscite/imx93_var_som/spl.c  | 6 ++++++
 tools/imx9_image.sh                  | 2 +-
 5 files changed, 23 insertions(+), 2 deletions(-)

-- 
2.41.0

