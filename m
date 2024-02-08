Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5592C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE9387E59;
	Thu,  8 Feb 2024 13:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="p100D07Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454A187E0F; Thu,  8 Feb 2024 10:45:46 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAB687DFB
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 10:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rY0yQ-0003oF-2Q; Thu, 08 Feb 2024 04:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=YYGCk0gnnQKCDema1gSOuqYlFm0Mll4659WJOnjeul8=; b=p100D07Z474NXF
 a4zBkCab2xhXpUhHBts8gfykonOUQomEKAwoMRlrVXoTGX7WMPth6EBH3MuR0CS0dNtdEWXFdhtB4
 khxx4Bx3Bmt8qNYWqysGkiFwN0/1hDsyKY6iUlgYYMoMdr06QSlcilYGXMD20/vkLj7SX9L1SWhFJ
 z6h3CEL9lhj1obLVSetJzPnlzAFrtDCw6gkghNLEbtB+jZDCZ4YBH/WP70VRi98E+kFg2W1JoyZQW
 gYVPxk+bCciX2cNHzkatAxQFmRlKr8rB5sWef+1Ws8nqlxs3+4A722050SLCxkQ5WYRGz1aGE27+x
 XGAoY8MlEYAPMI8GQ9SQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 0/2] imx93_var_som: Enable AHAB support
Date: Thu,  8 Feb 2024 10:45:16 +0100
Message-ID: <20240208094518.391-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:10:31 +0100
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

This enables AHAB support on the imx93_var_som.
I was able to test that I can boot from signed images on a closed board.

There is one issue that has been discovered and that is discussed here:
https://lists.denx.de/pipermail/u-boot/2024-February/545404.html

This series can still be applied in the meantime I guess.

Thanks,

Mathieu

Mathieu Othacehe (2):
  board: imx93_var_som: Probe ELE MU
  configs: imx93_var_som: Enable AHAB support

 board/variscite/imx93_var_som/spl.c | 5 +++--
 configs/imx93_var_som_defconfig     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.41.0

