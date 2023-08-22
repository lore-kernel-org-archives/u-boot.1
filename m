Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941DEEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 17:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C684E860F1;
	Tue, 22 Aug 2023 19:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+qoP9HL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCD2B860CA; Tue, 22 Aug 2023 19:03:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E6F8864B6
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 981B96533A;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 011E6C433C8;
 Tue, 22 Aug 2023 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692723826;
 bh=6NJqaJvdjGHbug0V5ivKzYtBV8Sd2+bQXnF+m+rLY38=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=m+qoP9HLcS8/wdY09Yfc8lAk+huJEO0s4LwLnfPdnyXEQWpSKU90cn+Tz0SZcW07f
 lYoWwwgv3Mf3fKx8YFE3IO3b5lHIfwTQQbI4sxVNPB5lwxM5hKLM0PkXihC/NjNUNB
 JTyn/vlsJ66f515nExyN0xr4IghkWipiyuPuZxfJf9PgDPO67Xhefdp8GeYkJbxP+u
 6cmwdYZETw8YOU9V2++xb7n//3OKa84/oXk64TeIBU7nZUhvD6V5BFWOUq4Q1cg/Gt
 aJbJB0cN4kTvYCEVVpW52hYnIjbhG63nWB8SCcjDgwmR+Db/vdNQZzpyGKw/WahOs4
 9T5hSX39m3tRQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D2F97EE4993;
 Tue, 22 Aug 2023 17:03:45 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH RESEND v2 0/2] net: add support for HiSilicon Fast Ethernet
 Controller driver
Date: Wed, 23 Aug 2023 01:03:41 +0800
Message-Id: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, David Yang <mmyangfl@gmail.com>, 
 u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692723823; l=1239;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=6NJqaJvdjGHbug0V5ivKzYtBV8Sd2+bQXnF+m+rLY38=;
 b=7W9L65ErtM9ldFdCcTZJ8BFx5tmfQoBRpwg4oLhcWgFhxq1Do2gk2NXUtsCFuI0q9gdKQ0+F5
 ZB/iFiBv9GMD1VpQXzwiOOcEn9+8PU7S06Mhrb7V0gJQnBnrg/O64g0
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

This core is found on many HiSilicon chips. This patchset adds support
for it and the integrated MDIO bus.

The driver code comes from linux kernel driver, downstream u-boot driver
and the datasheet. It's already tested on a Hi3798MV200 based STB.

Note that currently this driver can't be used for Hi3798MV200 since the
clock driver is missing. I will implement and submit the clock driver
and the framework in a later patchset.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- hisi_femac: clear previous irq before sending
- Link to v1: https://lore.kernel.org/r/20230725-wip-hisi_femac-trunk-v1-0-88469a170310@outlook.com

---
Yang Xiwen (2):
      net: add hifemac Ethernet driver for HiSilicon platform
      net: add hifemac_mdio MDIO bus driver for HiSilicon platform

 drivers/net/Kconfig        |  17 ++
 drivers/net/Makefile       |   2 +
 drivers/net/hifemac.c      | 481 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/hifemac_mdio.c | 116 +++++++++++
 4 files changed, 616 insertions(+)
---
base-commit: 580eb31199be8a822e62f20965854a242f895d03
change-id: 20230724-wip-hisi_femac-trunk-1f57f0986f0c

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

