Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3109AC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 11:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB78F87EFA;
	Thu, 21 Mar 2024 12:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="HqlXnoVX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 186698808A; Thu, 21 Mar 2024 07:57:59 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5689880A6
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rnCN3-0006F1-MH; Thu, 21 Mar 2024 02:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=fDiPI3oSVF1uQFc0izL8r6MirDljeWNhHLSW3CfGL0M=; b=HqlXnoVX039VVR
 8GnhcYBIMzyePL1wtbKzPLDSbhgOtT7UpfYRsxaKGsoOl5V3VIEFTobpBdBOlrp+LdxaKzFHnGw89
 D9Se09cJhBaXnviNTpfZxlbDjyzV/FI7/zhdCh32wKqmPxvykpd7rG2pCWsWYFw9qy3rmNz48DnLb
 KBCrxYUgKzvg0BDPFdBHVhUhiO3SMiRypWWAobjhOxLSV0SasrQThcMiWk1T90RVpxr6Oo9kgYaYy
 qO0Pz0e/H1jlURwBaN0GjNJeAkm+liSUtvCADmnXzr0APTasIEYEwOD5LVg/M4JKoff/H1lF8wYj5
 EThZtzCjchBBpXgjYADQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 0/3] imx93-phyboard-segin: Add USB support.
Date: Thu, 21 Mar 2024 07:57:39 +0100
Message-ID: <20240321065742.32441-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Mar 2024 12:32:10 +0100
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

This series adds USB support to imx93-phyboard-segin, in the same way as it
has been done for imx93_var_som here:

https://lists.denx.de/pipermail/u-boot/2024-February/546301.html

Thanks,

Mathieu

Changelog:

v1: https://lists.denx.de/pipermail/u-boot/2024-March/548613.html

Mathieu Othacehe (3):
  arm: dts: imx93-phyboard-segin: Add USB support
  configs: imx93-phyboard-segin: Add USB support
  configs: imx93-phyboard-segin: Add fastboot support

 arch/arm/dts/imx93-phyboard-segin.dts  | 13 +++++++++++++
 configs/imx93-phyboard-segin_defconfig | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.41.0

