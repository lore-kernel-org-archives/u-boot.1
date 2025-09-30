Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E17CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 08:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE93183045;
	Tue, 30 Sep 2025 10:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PqANAvVg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF6E83071; Tue, 30 Sep 2025 10:08:10 +0200 (CEST)
Received: from mx-relay128-hz1.antispameurope.com
 (mx-relay128-hz1.antispameurope.com [94.100.132.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9AA0828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0361cc115b=matthias.schiffer@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate128-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=ZyB8MxtDq7TI1eG43k3V+Ykho4uPaulMgjvZhhCIgII=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1759219623;
 b=LHwz1rJf4uPmhCc1L6sPPtwCU43ssZVVOePCRTo3K/ztGoZYJupWaU8uASgkg/Q68Ti0Dmbx
 51U4iWzdLMZQ08TibifkzNiBUXP5Hms17gJwsuiFbc9yzQ1stsFFLUujf4fzNSFDO/mw2TE1Suq
 HwV12iK7BX4DK5XrLI2LKsk5LFXNW9AIexQvATrtiV79lw+byrs+fCpoyHtWItbuufusC1/el+d
 2Wc8GKOkr0oh0kjT1LkuYJYDh0ToseXC7rvl5/HznpfBjsVU2Wr/NtRwyArkYTpGgWU/IoFOiEH
 92D4cXd5t6UgmFcXJ2SYRAFkQstIz5nFpvoi+4luksKnA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1759219623;
 b=sCVdF7nyz1oXA2RLkjWwtcqEHO0jUuGk3pADS8pQn8tsvbtvFPQ+ZQOK9n3v7pIAbWSVG3o0
 2geiohETJzdQob1aJt76J7fYCmbAgyENO6nAEnV958DZGBOeC75vmQFlZ1ackIAtwnGtPu0a5Uu
 I5w/RNJWcbPot/5wv40yP2d+UcLB+EXzGIiByqZpl5MoAmvZxR3+ZoJkVEx58j9oieoCrDl3YTG
 mLEPTkrEygFcYRx/uAIzjq+K2BolAn4HmTzqU16PMx3l1mqgOThPRV9sA8qEfwv5EkDqhGz3yG9
 Th+MoH5vffbXjnCCrZAgv0r/sManEJJNeQQ7eB1M8t0uA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay128-hz1.antispameurope.com; Tue, 30 Sep 2025 10:07:02 +0200
Received: from schifferm-ubuntu.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: matthias.schiffer@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 4E015220CE5; Tue, 30 Sep 2025 10:05:33 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 0/2] am65-cpsw-nuss phy_interface_t fixup for fixed TX delay
Date: Tue, 30 Sep 2025 10:05:09 +0200
Message-ID: <cover.1759218200.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay128-hz1.antispameurope.com with 4cbVws66w3zvQDm
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 21e93e854f646af50c0f42d705e85d6b
X-cloud-security: scantime:13.72
DKIM-Signature: a=rsa-sha256;
 bh=ZyB8MxtDq7TI1eG43k3V+Ykho4uPaulMgjvZhhCIgII=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1759219619; v=1;
 b=PqANAvVgBpz/ZrVtu6lyfls6eEA0WmfrIgAZ0bCxS5ZqT+bNVf8JuSpSx3gzCk1SFC7z30Yn
 +Q51ZVuWzvr4+hlBEcoJmvkv19wIG0t989MmGnVQRA2nzRUC7uFOA1lYIPyfoXDvEH5os9wyXsy
 tUXHImROXA9kyeZTXF9S4MfrmW0pFqWzocDE4rWf8BBbqzvnG2uDMjTMK/HrisfeQYh52bdJcRR
 db6sMy5EKICPK3kFhWQF4uajM9t1rzlw1drWybSWWfbe/P6hDVzE40oMHgAZ85afUmwh4aGIv81
 ZbhEvon9Y1bftqyFCLoLL2h00ApBHTt+gJ61jtmJQ/2tw==
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

Following a discussion on the LKML [1], there has been a clarification
of the correct use of the rgmii(/-rxid/-txid/-it) phy-modes [2] - namely,
that they don't describe the interface at the MAC or PHY boundary, but
whether the PCB traces add delays or not (where it is
implementation-defined whether the delays are added on the MAC or PHY
side in the latter case).

Accordingly, a fixup has been implemented in the am65-cpsw-nuss driver
to make it follow the clarified rules [3]; apply the same change to
U-Boot. Backwards compatibility is preserved: using an old DTB with
the wrong phy-mode only results in a warning message, but keeps the
Ethernet working. With a new DTB from Linux 6.17+ that sets the mode to
rgmii-id, these changes are necessary to avoid using an unsupported/
reserved configuration. See the commit message of patch 2/2 for some
additional detail.

[1] https://lore.kernel.org/lkml/d25b1447-c28b-4998-b238-92672434dc28@lunn.ch/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c360eb0c3ccb95306704fd221442283ee82f1f58
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca13b249f291f4920466638d1adbfb3f9c8db6e9

I'm not sure whether this should go into master or next - if no DTS from
Linux 6.17+ are imported in the v2025.10 cycle, next is probably
sufficient.

Matthias Schiffer (2):
  net: mdio-uclass: introduce dm_eth_phy_connect_interface()
  net: ethernet: ti: am65-cpsw: fix up PHY mode for fixed RGMII TX delay

 drivers/net/ti/am65-cpsw-nuss.c | 35 ++++++++++++++++++++-------------
 include/miiphy.h                | 15 ++++++++++++++
 net/mdio-uclass.c               | 18 ++++++-----------
 3 files changed, 42 insertions(+), 26 deletions(-)

-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

