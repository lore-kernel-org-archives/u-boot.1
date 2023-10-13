Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E24CCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 09:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CD986E15;
	Fri, 13 Oct 2023 11:44:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697190295;
	bh=LW6jIVxR7X9M8370UUVgp2X6NI/jnP0+FL/0EmXefdY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fv+mKBK340xFY1XIjuMkltpv6QE0kAlzg63VE3DUJat5WULNc9zjUx7ewnbtdVRd8
	 b+vO3aH3xTZ/HYI/pzK9LBCsHFxiVeaob1K3mUV1WA9gDiQ0XUszkEXhacUHA42MzB
	 MgydT3wymtkTmYrStzSp+kN1F4RbYbd45g4kDwYXZPAvhbORZJ8WpP+sR/1eBVgXNJ
	 QJ0bh02DxkvUTR5Uq3QJg0GaF+LNtY2ZKBUsK3plUr11I0psMz5ac7npo2hNc81uDg
	 U7vsNBQhEoXFMysVrEhmbo73wd+SHLQV37w6RHqX6kiv+t1i546BpwNw50jntJVeg3
	 Gi9YaqZ7Xjbfw==
Received: from localhost (unknown
 [IPv6:2a01:cb18:989:a700:7e7a:91ff:feeb:a1bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: pro@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A0283868BF;
 Fri, 13 Oct 2023 11:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697190293;
 bh=LW6jIVxR7X9M8370UUVgp2X6NI/jnP0+FL/0EmXefdY=;
 h=From:To:Cc:Subject:Date:From;
 b=ossDifPi7lrwlw5jR6I02aDxt1Mh8hdISnFv+1ZIK4NRjMx2WZd2s597dX0/2uz18
 ckGpTxOLSAjo9diJhIIEfJh9dAphJ6Wy4QWKwbLjlY+6hGKhnp/EHVYw2gKhJWPHWy
 1ZmUcHKR6U4UyXUWlMGAG1ka5LWt6zWGcjb5Zl20Y0YF4k1FnpAAvyO1f7yeHtW9or
 qpXlOwG/7/pAWIPmK0suTSPz3/Y+0sgvMn9sV0UhUkwawLEiwyB52SE6ccSxEDZ5VI
 dRUDtnDHs+uhK1c8d2VKCpH9hMSmcEVsS79zF4LX4iHaPv6SaMSqxBEG4MiSM0/cqb
 YaseMXvudbGGQ==
From: Philip Richard Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: hs@denx.de, sjg@chromium.org, trini@konsulko.com,
 Philip Richard Oberfichtner <pro@denx.de>
Subject: [PATCH 0/2] bootcount: Replace I2C legacy implementation by driver
 model
Date: Fri, 13 Oct 2023 11:43:00 +0200
Message-ID: <20231013094302.28944-1-pro@denx.de>
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

Philip Richard Oberfichtner (2):
  bootcount: Remove legacy I2C driver
  bootcount: Add driver model I2C driver

 drivers/bootcount/Kconfig            |  34 +++-----
 drivers/bootcount/Makefile           |   2 +-
 drivers/bootcount/bootcount_dm_i2c.c | 126 +++++++++++++++++++++++++++
 drivers/bootcount/bootcount_i2c.c    |  43 ---------
 4 files changed, 140 insertions(+), 65 deletions(-)
 create mode 100644 drivers/bootcount/bootcount_dm_i2c.c
 delete mode 100644 drivers/bootcount/bootcount_i2c.c

-- 
2.42.0

