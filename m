Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21781CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 19:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8A083FB0;
	Fri, 10 Oct 2025 21:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rV0mOgDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F088405C; Fri, 10 Oct 2025 21:56:05 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B8D83FB0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 21:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-mcarthur@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59AJtwQp757507;
 Fri, 10 Oct 2025 14:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760126158;
 bh=ffB9hL8+tUNZf0qhw0nMfoqJGG2eR5uodF89P8AuU9Q=;
 h=From:To:CC:Subject:Date;
 b=rV0mOgDCNw9pixey/K/nRL08hy4zy0b0N2Kc+yQMnDc5uFkv7lH/qp57DRvN6tvA7
 2p9NlTmOuBSuLByjylIhidVFnWCO9uYy7v3u34V7mRznkYqKOha74EU0aUrrSdaEGm
 /nlTwFvYVfdTmUBBDar7cSuZAIxW7pa6hLesvB70=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59AJtwqf1025304
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 10 Oct 2025 14:55:58 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 14:55:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 14:55:57 -0500
Received: from localhost (uda0499903.dhcp.ti.com [128.247.81.24])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59AJtv022389427;
 Fri, 10 Oct 2025 14:55:57 -0500
From: Jared McArthur <j-mcarthur@ti.com>
To: <u-boot@lists.denx.de>
CC: <marek.vasut+renesas@mailbox.org>, <j-mcarthur@ti.com>,
 <trini@konsulko.com>, <n-francis@ti.com>, <bhupesh.linux@gmail.com>,
 <neil.armstrong@linaro.org>, <u-kumar1@ti.com>, <bb@ti.com>
Subject: [PATCH v2 0/2] ufs: Add support for setting bRefClkFreq attribute
Date: Fri, 10 Oct 2025 14:55:54 -0500
Message-ID: <20251010195556.1772611-1-j-mcarthur@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Currently, U-Boot doesn't set the bRefClkFreq attribute before
changing power mode of the UFS device. If there is a difference
between the UFS device and the host controller, all commands will fail
after switching to high speed.

This behavior is rarely observed, because Linux sets the bRefClkFreq
attribute on probe, and the bRefClkFreq is a persistent attribute. In
other words, once Linux has booted once, the issue will never be seen.

If trying to provision and boot from an unprovisioned UFS device,
U-Boot will fail. Fix this by adding support for setting the
bRefClkFreq attribute.

Changes in v2:
- drop the dev_ref_clk_freq field from the ufs_hba struct
- ufshcd_parse_dev_ref_clk_freq returns a enum ufs_ref_clk_freq instead
  of setting the field in the ufs_hba struct (and returning void)

Jared McArthur (2):
  ufs: Add support for sending UFS attribute requests
  ufs: Add bRefClkFreq attribute setting

 drivers/ufs/ufs.c | 180 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs.h |   9 +++
 2 files changed, 189 insertions(+)

-- 
2.34.1

