Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02038C4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 14:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63858879FE;
	Thu,  1 Feb 2024 15:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tBwlR5Bj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B52187C66; Thu,  1 Feb 2024 15:05:47 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C4D879FE
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 15:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9413061C00;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41B9BC433C7;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706796343;
 bh=qoO1GWUwglkouL30KLVHZpQKTUw3WzxauJY+ZHGAzaU=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=tBwlR5Bj5XKKlOHnaJ9oAA8nvqn+FAunaX3nVkGusbj0hUkElIFcprW/Y19cQO32E
 UfIS+OKw5qSznU2DU+cpgfUplZQc4qpQGwxR6Jqf0FfzGOltJYaxyWxChpquiW8kSv
 dcit048KGfJl4JQah2Dx7+isckIJsebe4oCJS9fQoUOUzfRyXsYwxGcH/4WL4NUHYf
 7R3LBJVzp7IxlyXDwaBZWBuRpa4lYLTBSFHEvn+VrD51SToCFqdNx4wAzhR97bRYOY
 3UP6OADtZAKqgj+tjVBVWJ3GGKaPitP5ZNKr2dO6TzNhjPSYmOrypILgmFn9BX6m1D
 mA8W2/R8gPddw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 26AD6C4828F;
 Thu,  1 Feb 2024 14:05:43 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/3] mmc: hi6220-dwmmc: handle resets and clocks
Date: Thu, 01 Feb 2024 22:05:41 +0800
Message-Id: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWlu2UC/1WMQQ7CIBBFr9LMWgwgrcGV9zBdtONgJ0oxUImm4
 e5idy7fz39vhUSRKcGpWSFS5sRhrqB3DeA0zDcSfK0MWmojlbLCexQW3dEdTNviaKA+n5Ecv7f
 Kpa88cVpC/GzRrH7rv5+VUGIg6kaNrrNSn8NreYRw32Pw0JdSvrej8EeYAAAA
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706796342; l=893;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=qoO1GWUwglkouL30KLVHZpQKTUw3WzxauJY+ZHGAzaU=;
 b=dOufC9sn2B03Ug7hXCoPaP0mz906uzVmCPGsmToWPXgXbHB0pj30R/78iZdwBgRcEw8bnmwq0
 f79IaQDY2cZBd0t7TMDUZPfmB1RwCRXTkZtMUYDFaLMjto+4ug32/FR
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

Also allow setup fifoth_val in driver

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- dw-mmc: proceed if data busy found
- hi6220-dw-mmc: add fifoth_val setup, separate hi3798mv200 data
- Link to v1: https://lore.kernel.org/r/20240119-mmc-v1-1-aee6b2cf6902@outlook.com

---
Yang Xiwen (3):
      mmc: hi6220-dwmmc: handle clocks and resets if CONFIG_CLK and CONFIG_DM_RESET enabled
      mmc: dw_mmc: Don't return error if data busy timeout
      mmc: hi6220_dw_mmc: add fifoth_val to private data and set it in .probe

 drivers/mmc/dw_mmc.c        |  4 +--
 drivers/mmc/hi6220_dw_mmc.c | 72 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 4 deletions(-)
---
base-commit: f7cca7ccc5117eaafcc2bde91ad1bed6fee7cfc3
change-id: 20240119-mmc-9cf7f3455cb4

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

