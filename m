Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A79DC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7349E874B0;
	Tue, 31 Oct 2023 08:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698738048;
	bh=9CNx+E4TQMGXk5CFz21yYoMEYsQ69RisxY0qIu2Zdzg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=b13kaaD2OkifZrugXy+PMXGBDgQLE2tH/gb5uibx/49bV5tRVk6VRUl9ZaTCVtYHk
	 8YmVqguZd1iNNbxaXkEg5d655s/F2WDxeJbC96bgMxKF9vVL6ZTt74U2vii1LhhJ3W
	 gFOtZJMnBiYD8/vUPPoEK5MjKrdcanVg+nL9Z+yQBz1SeMthHQYP333NMTNQ7/jiwP
	 ay5O+RW6USo8S/2MZIt8BN8foU2uWRSjpE6taQxb58ngRNAXvUd8Pe8SiPs94hEV7w
	 GgzWr+YE6hc8u8EokmEftmAfk0xihGem6xvHQhIECvsYU8ktoGuuU4feQKa4Okbw0h
	 awLjzf2wBr6gA==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:4b67:3ae7:15fa:40a0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B18AA87256;
 Tue, 31 Oct 2023 08:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698738046;
 bh=9CNx+E4TQMGXk5CFz21yYoMEYsQ69RisxY0qIu2Zdzg=;
 h=From:To:Cc:Subject:Date:From;
 b=VXiy8Dsla5+s7ZuMmSaBsB5+Pl3hCaDnUijnBSyu1rWUPysIXuctLVeOGDdsy00gq
 D7g/qPsqHpMqEJguGYSS8s4D26ObtNodSKxFrm5vACa9SGvVZv3ZsvSgSBVuO0KE0d
 UDXQZBMcJK/WxQZ7JTlrui/P+3eYiKRex06uof2/uyaHAv3s/nLGreSidiQ6z8v0Dx
 sxsb/z51VUJel8zelTMmnvvYQOz4sODao5mTHulYascZKZG1czmlVfREEKfPle3EZa
 Qg6KwSf2Zyw8tDnyo0Q3LCWZoDtRSVcNmqCAY9WnwEwmw3De9mDI00XmiVkB5ZsEpp
 U1kWelOp4sO5g==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH v3 0/3] bootcount: Replace I2C legacy implementation by driver
 model
Date: Tue, 31 Oct 2023 08:38:42 +0100
Message-ID: <20231031073844.15683-2-pro@denx.de>
X-Mailer: git-send-email 2.42.0
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

The generic I2C bootcounter driver does not yet adhere to driver model.
This patchset intends to replace the legacy implementation.

There are currently no upstream boards using the driver, so it should be
safe to just remove it. For downstream users it should be straighforward to
switch to the new implementation.

Changes in v3:
- Remove common.h #include

Changes in v2:
- Improved device tree handling by replacing address property with phandle
- Addition of a generic i2c helper function

Philip Richard Oberfichtner (3):
  bootcount: Remove legacy I2C driver
  i2c: Implement i2c_get_chip_by_phandle()
  bootcount: Add driver model I2C driver

 drivers/bootcount/Kconfig            |  34 ++++-----
 drivers/bootcount/Makefile           |   2 +-
 drivers/bootcount/bootcount_dm_i2c.c | 102 +++++++++++++++++++++++++++
 drivers/bootcount/bootcount_i2c.c    |  43 -----------
 drivers/i2c/i2c-uclass.c             |  75 ++++++++++++++++++++
 include/i2c.h                        |  12 ++++
 6 files changed, 203 insertions(+), 65 deletions(-)
 create mode 100644 drivers/bootcount/bootcount_dm_i2c.c
 delete mode 100644 drivers/bootcount/bootcount_i2c.c

-- 
2.42.0

