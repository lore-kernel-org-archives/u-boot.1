Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E746AC88CB2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41AB866E1;
	Fri,  1 Sep 2023 00:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="Y/OFDegv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDA781FA8; Fri,  1 Sep 2023 00:16:36 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FFC28659F
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=Cu0wVA91EFMQQYsGLBVrhBx+f1MIcxJHETFqha+hS6s=;
 b=Y/OFDegv/gAlmGqcpTVdgOGyu+Aet4jgZ9yJPtjTQXtOnjkDT8XVs66QYlBIDo+LZ/iF
 3dw3vtbSOPMABMSKbTWqcQNdA08HaSbiJbcPkZXt71w2luCDKN/BIOQr6S6Z6IveLlqmPJ
 oBIbJB3UlNqNn9r8fk8zqpmYh7fPixbRurE521M9CFDeDmK8cm3NLnpJVGPw7ugO4J7pAx
 LZnyxLUCQ8h9m1wB7LzJ06XYMNYPbN8A1bjf0fW0xaA2eKTrUrrPf1dWiiVLS1zp+nfbBg
 hUcnGA3mTbO4XA8I3lRAjcHomVOaglElXagPxMswHrgqrRnRbfXPJS91ODZMuLzw==
Received: by filterdrecv-66949dbc98-mtdwq with SMTP id
 filterdrecv-66949dbc98-mtdwq-1-64F1113F-2C
 2023-08-31 22:16:31.875571231 +0000 UTC m=+5859691.125361198
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id 4tY3zOnnTuKrUNAzwUfD_g Thu, 31 Aug 2023 22:16:31.563 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/6] phy: Fix use of generic_phy_valid() helper
Date: Thu, 31 Aug 2023 22:16:32 +0000 (UTC)
Message-ID: <20230831221629.1027552-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h0Qe811Rjh9uNH9HO?=
 =?us-ascii?Q?FcDHnjwJRxzadXnGIKMFzCr3bMPxzLqLiW+SLZe?=
 =?us-ascii?Q?CL1BjLQKh+2h37OC+WImOm62kBOtKkUPR7CCGPo?=
 =?us-ascii?Q?PZljcSNfN5mJIO0CJFcOqqQF=2F5mU48E63HYGV66?=
 =?us-ascii?Q?jm0V57vG6Yg1Q+22yhb3eqRkM=2FKHSFLYwZpvKw?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

The documentation for struct phy state that "The content of the
structure is managed solely by the PHY API and PHY drivers".

Change to use the generic_phy_valid() helper to check if phy is valid.

Patch 1-2 fixes issues where generic_phy_valid() erroneously report a
phy that has failed to be initialized as valid.
Patch 3-6 replace direct access to phy->dev with generic_phy_valid().

Jonas Karlman (6):
  phy: Set phy->dev to NULL when generic_phy_get_by_name() fails
  phy: Set phy->dev to NULL when generic_phy_get_by_index_nodev() fails
  usb: dwc3: Use generic_phy_valid() helper
  scsi: ceva: Use generic_phy_valid() helper
  net: zynq: Use generic_phy_valid() helper
  video: rockchip: dw_mipi_dsi: Use generic_phy_valid() helper

 arch/sandbox/dts/test.dts                     | 11 +++++++++++
 drivers/ata/sata_ceva.c                       |  2 +-
 drivers/net/zynq_gem.c                        |  3 ++-
 drivers/phy/phy-uclass.c                      |  4 ++++
 drivers/usb/dwc3/dwc3-generic.c               |  4 +---
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c |  6 +++---
 test/dm/phy.c                                 | 18 +++++++++++++++++-
 7 files changed, 39 insertions(+), 9 deletions(-)

-- 
2.42.0

