Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BC4C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126D383B05;
	Thu, 10 Apr 2025 11:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="J8aeVZGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E18783AE9; Thu, 10 Apr 2025 11:02:09 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D5E83AFD
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1u2nnR-0007dF-2h; Thu, 10 Apr 2025 05:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=7pnggSBU5jCd8f1Lxa/jPpaR7IN8ujnAeXyYqfyuicI=; b=J8aeVZGLEKCZwv
 iQzP+QsoS+JZe8rakIg8O4L7ygD1kJHmRbzfQGZxHhRIi+gSZV6E1D/ATXOpLwQo0F4RqjPfHf5Md
 zR3ejbEg1Em5W5rpckysX1FXqbrt9DkIE49GHBUINu4xeYfR8wa2Ul7PtFP2Yc2pSDiKjFi9PIK03
 cAy5YKnM1Z/5Imza8B2IfxVul8WI9aqElfZ2Jp0axPEldJca4ylWbXUeHE8oHhcyXwvGqew7JDyE2
 YWHI1ah7ZcMouh0oFofL2dEvkrnX0BVBzyIBFlAg+qsQTLDl12qWOx0EXvQbxYglxZsWHmvGSiCFO
 Np3NNlWyLL5xdnfXgZ8g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 u-boot@lists.denx.de, regis.ray@landisgyr.com, pascal.dupuis@landisgyr.com,
 Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 0/2] mmc: omap_hsmmc: Restore the init_stream sequence
Date: Thu, 10 Apr 2025 11:00:19 +0200
Message-ID: <20250410090021.14446-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.47.1
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

Hello,

Back in 2019, the init_stream sequence was disabled with db52e19ced because:

  This is not required. The MMC core sends CMD0 right after the
  initialization and it serves the same purpose.

That is wrong. It does not serve the same purpose at all. The init_stream
function role is to keep the CMD line high for 74 clock cycles which is
required by the SD specification[1]:

  A device shall be ready to accept the first command within 1ms from detecting VDD min.
  Device may use up to 74 clocks for preparation before receiving the first command.

It turns out that one of the devices I am speaking to is requiring those 74
clocks sequence before the send of the CMD0 as described in the specification.

It was then broken since 2019.

I guess that most of the other devices out there are able to cope with those
74 clocks sequence missing and can respond directly to CMD0, which is why that
went unnoticed with the omap_hsmmc driver users.

I am proposing to restore that sequence, which is also used on the Linux side.

Thanks,

Mathieu

[1]: https://academy.cba.mit.edu/classes/networking_communications/SD/SD.pdf

Jean-Jacques Hiblot (1):
  mmc: Add a new callback function to perform the 74 clocks cycle
    sequence

Mathieu Othacehe (1):
  mmc: omap_hsmmc: implement send_init_stream callback

 drivers/mmc/mmc-uclass.c | 13 +++++++++++++
 drivers/mmc/mmc.c        |  6 ++++++
 drivers/mmc/omap_hsmmc.c | 13 +++++++++++--
 include/mmc.h            |  9 +++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

-- 
2.47.1

