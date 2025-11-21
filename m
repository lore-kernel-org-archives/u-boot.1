Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A8ECFC29B
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3810C83A1B;
	Fri, 21 Nov 2025 18:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AwmOYzJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414D283A1E; Fri, 21 Nov 2025 18:30:46 +0100 (CET)
Received: from mx-relay99-hz2.antispameurope.com
 (mx-relay99-hz2.antispameurope.com [94.100.136.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCD8839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413a1ceba=alexander.feilke@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate99-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=CwXa9GhURE4BFVVkYiKI78dZ5xhKQ/LJToDKl6YeCnw=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763746242;
 b=ZlOdHyCrkHjYeriHly4pIBtw+KQLQrXNRLnimnb9Mz/s8tPZsYXSuIqKYsvtwHtsqeKr5XZr
 /tvJQCJ3syId7imqMADv8FbesExY3tY8Xhtn/ed0Bf70RhWGjzAzTVOlk5ITXf+n5/c0SqZg0zR
 N4KGsriiYxmby4SEByzctxKNfapkZs+L1SLDEwAvrzV4AoXuxTp6E6i1qOwbP21kgun/44kNO7U
 mkh8xmlLFz3AZ77nKdhbo+zLFRMzDgqLl1UTVObg95J6XRznltpil8EoSvDIlEGgQ9HwzPNmIN0
 xZDJNOP1LRZJg7rJowQh0O8vMK7LN7K9mV86DFoFzmUyQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763746242;
 b=of8h9BY/eTPaxxl/K1Y0zoDopngm4D8qsQCizkkCU1JON3MPZY4a9kKmmVxi1UJwjb5b3oUw
 O6YHJ+rdyTvP+XC0In6BcW1pCdZcWjZyrFrh7jWvfGlquaUCE9bfnr5/GhBH9eaG6lAlCxoXVsn
 31FJxgfGAyjF/jEsrrC2AYFhqyoJCRHU5DwSvpcq9O2f4+VRQBkUM+1ZtG8PlNS9g5pG/TS5AsO
 8rIg/dgpmFiwIB5Rct8T+zE6L4j66lDj9Xg5ANZQIuQt3o3/gY1GKDf87uX1h5+2ImuM4WpvP6Q
 CucPAcxQHclkpdODQjYVrtpl5/n1KGV/w27A5q2gf4y2w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay99-hz2.antispameurope.com; Fri, 21 Nov 2025 18:30:42 +0100
Received: from FEILKEA-M.tq-net.de (host-82-135-125-110.customer.m-online.net
 [82.135.125.110])
 (Authenticated sender: alexander.feilke@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 C6191220CAB; Fri, 21 Nov 2025 18:30:23 +0100 (CET)
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Fabio Estevam <festevam@denx.de>,
 Markus Niebel <Markus.Niebel@tq-group.com>
Cc: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 0/8] net: fec_mxc: fix bugs when using DM_MDIO and DM_ETH_PHY.
Date: Fri, 21 Nov 2025 18:29:29 +0100
Message-Id: <20251121172938.26890-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: alexander.feilke@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for:
 alexander.feilke@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay99-hz2.antispameurope.com with 4dCj0c2Yjcz28lXQ
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 8f058dc2ed245bb48f0a071870dc4831
X-cloud-security: scantime:2.164
DKIM-Signature: a=rsa-sha256;
 bh=CwXa9GhURE4BFVVkYiKI78dZ5xhKQ/LJToDKl6YeCnw=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763746242; v=1;
 b=AwmOYzJX37nYinzQtB2uX6HSni7u3yGFebaIrQcP6//nSd+l8ixWA8fOeOCWdjvEJ/bINLby
 7TlWRBeN3w/NNLavPGNAiumNIYtPG5Mclk7AKha9TYLbge6GKKOAG+EWYS9X4jxbZuCPWfrHJe8
 hgA0AsT/yKUdzq6VEf2dcrQQUOcZiIy6WPx5DEeXUh/kXNCKEEHu+xROIyl3KZvdkk7eXFtb602
 ag+a+K6FqopwdbQOuzaw7FQZWn2qlqP0meMCnXYAgqVdisA5X9dEnuA0L7K42Vu6xFZO0xPTSVy
 0GV1xdLkrjVxapjxqtJyw+u/ARF0qYq6MSEL9azTRmG4Q==
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:51 +0100
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

This fixes various oversights in the fec_mxc driver and ultimately adds support
for devices with multiple FECs each using its own bus. The patches were tested
internally on an i.MX7D-based module with separate MDIO buses and on an iMX6UL
with shared MDIO buses.

Checkpatch also yielded some warnings regarding CONFIG #ifdef's, which weren't
included in this series yet.

Markus Niebel (8):
  net: fec_mxc: respect return value of phy_config
  net: fec-mxc: prevent crash if no MAC address is set
  net: fec_mxc: fix probe of MDIO bus for DM_MDIO
  net: fec_mxc: fix remove with DM_MDIO
  net: fec_mxc: rewrite fallback MDIO Bus allocation
  net: fec_mxc: fix usage of DM_MDIO and DM_ETH_PHY
  net: fec_mxc: add unique bus and device names for DM_MDIO
  net: fec_mxc.c: improve readability of dm_fec_bind_mdio

 drivers/net/fec_mxc.c | 56 +++++++++++++++++++++++++++++++++----------
 drivers/net/fec_mxc.h |  4 ++++
 2 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.34.1

