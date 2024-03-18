Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C94C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 17:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1C058800C;
	Mon, 18 Mar 2024 18:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="UGxKEKN0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E0F87F1F; Mon, 18 Mar 2024 18:17:13 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5F287E86
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 18:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rmGbb-0007H7-Oa; Mon, 18 Mar 2024 13:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=3In1eHLbKleXMrBKBpYcOunuaNK9QrtK2lR31bEn3eA=; b=UGxKEKN02hBEiL
 8J0+QOiaun5uOlc8MxKyOq0zGa5cyAr2lME+ftXH1+ftrKycETSWyLX4Hj/7OwWrah42nSnGlJrpE
 pZlVcPkg1fPzjPlE14nFz1tU73ZT5nMgL2ZFi5HR4mZGG5VjxRUmpB8IxiN7zdihU+239qWqyH5qT
 QcUxFaNCjVfuiG5ihklpCGzAKbOvTEsXFQD+1+Z/ln/nd2t4vBPtzXRegz4iTrp9x4+EA0nt/N1A4
 WJYSPHhn7pvbrHzLr9WVknEyJmIf+U1GYcSUu73FYiP0LpsGptSyk0jaK02+VKSV0dqHOroHTmheC
 5Fmpyr1sk31UID7lHO+w==;
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
Subject: [PATCH 0/3] imx93-phyboard-segin: Add USB support.
Date: Mon, 18 Mar 2024 18:16:33 +0100
Message-ID: <20240318171637.12664-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Mar 2024 18:43:33 +0100
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

Mathieu Othacehe (3):
  arm: dts: imx93-phyboard-segin: Add USB support.
  configs: imx93-phyboard-segin: Add USB support.
  configs: imx93-phyboard-segin: Add fastboot support.

 arch/arm/dts/imx93-phyboard-segin.dts  | 13 +++++++++++++
 configs/imx93-phyboard-segin_defconfig | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.41.0

