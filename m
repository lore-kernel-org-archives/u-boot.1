Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C55CF649D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 09:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF0E88D2E;
	Mon, 30 Sep 2024 11:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Lzwbfozf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4317888B55; Mon, 30 Sep 2024 11:14:33 +0200 (CEST)
Received: from mail-m21473.qiye.163.com (mail-m21473.qiye.163.com
 [117.135.214.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1945588AD7
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=LzwbfozfiABuQ3OyT6Gy0kx//i7hy6Wlfqn2cftimZAbV24+U8ONhqeDXSJ1RBnspVfkvhC8z2x5qU3uCwNr/3pqf9K1RUvlwBA7nviCkn/duxAOD7axf/oV0G2pCtaorEhV+qhS4oCUgKaZxz4JcxVgybnddwcC0igryGU5WWw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=+kccSnM8vkYtVinz5GmmTrQK/BI6w+Fw6xVhZ/swPVY=;
 h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D5F0B280965;
 Mon, 30 Sep 2024 17:14:24 +0800 (CST)
From: Kever Yang <kever.yang@rock-chips.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: Pull request: u-boot-rockchip-20240930
Date: Mon, 30 Sep 2024 17:14:24 +0800
Message-Id: <20240930091424.2696174-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxkYQlZJQhhOTxkfGBgfQh1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a924235a54d09d3kunmd5f0b280965
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6EQw6PzIqIiMaFRg8HRpW
 KyMKCwpVSlVKTElMTUNMTU1OT0lOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT01JNwY+
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

Hi Tom,

Please pull the fixex for rockchip platform:
- rk8xx pmic fix

CI:
https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/22470

Thanks,
- Kever

The following changes since commit 596465138175cd7e4171cad1e68a2ef7c5c002bc:

  regulator: rk8xx: Fix buck get and set enabled state on RK806 (2024-09-27 18:20:49 +0800)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20240930

for you to fetch changes up to 7210de40a25a222043aed1348ec667a5ccc204b6:

  regulator: rk8xx: Use buck variable consistently (2024-09-27 18:20:49 +0800)

----------------------------------------------------------------
Jonas Karlman (1):
      regulator: rk8xx: Use buck variable consistently

 drivers/power/regulator/rk8xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
