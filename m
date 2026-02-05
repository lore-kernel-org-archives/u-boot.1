Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04DAEA7950
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 01:42:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199F6839A8;
	Thu,  5 Feb 2026 02:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BQknR+5k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xO3ZKuAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A4E0839A8; Thu,  5 Feb 2026 02:42:06 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54AB8063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 02:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f60MH45NVz9twS;
 Thu,  5 Feb 2026 02:42:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770255723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dap5btjaoBr1aG4DxfHKWzHD9SUF+cVEcFkq1+SEQtg=;
 b=BQknR+5kiWARHTwZvpBw0iRMEM+WqglqTv9f2HFHws/MTQCDDHKx5P7dtBYUA6UwS4LaLj
 E81/wlj9LJMzmmzzF1gwCbCM2/zOYESZglJAZ1xCHC+2FXGGbquOOJAVEC8qN0RITtzrRc
 40chMEvKoqrV9k92P+yUyU3+1vxDSZND3qmdwaspRMIWrbhYszu40wb7/n43fj86nBE5yg
 F3EudEKIuLvX+U7YqNl5m5uqfoUTD8X43tTf6gGgGF1GiiqQRv+rrzS0Z3bxSsUfFPZUrx
 XC8eB0ZzYjO8hqVzwkBXB9OFVx7dHTHk6JExe5umKS0GNomysW04aaWM/akwRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770255721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Dap5btjaoBr1aG4DxfHKWzHD9SUF+cVEcFkq1+SEQtg=;
 b=xO3ZKuAm8LE4m2ZC8FFGPOhuuNs1ahuXoaW0Rd6C2yw4UxCJLX/5cwgTjY/Mcahyg6FY2q
 X2H8hyDoozQjTN943eP2cBj6t6/1C5iy6+UnSwBRSXpTuscLHsx5Q64F1TU5FSHrI2Fxf6
 pBdumfwx8b91ibNFR+VsVQq/4bHrcjXGI49aoVsXvsjUCgaKvP2qH9nitkYUGAEIWU60Wt
 Pw6y2Qo6ghNmi+nu20OspirdwW0JtjxiQNyU4XTw+dCfU04UPIrDojYRFQJp2YXWvOhWKR
 V5S7r2Tg0wg2P8rCrSjrNz7GzDAaMX/AXXx1QV538DQSFIKNyMEnJVyMOu/fNg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v3 0/2] test: cmd: Add test for zip/unzip/gzwrite commands
Date: Thu,  5 Feb 2026 02:40:43 +0100
Message-ID: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 840aa6bea39d29f4798
X-MBO-RS-META: xfu3ggyu9hhjegab8z9dzzwgds7e9ugc
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

Enable zip command in sandbox so it is always build tested.
Add simple test for zip/unzip/gzwrite commands so they are
unit tested.

DEPENDS:
https://patchwork.ozlabs.org/project/uboot/patch/20260128194049.278542-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20260128194117.278566-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20260128194152.278586-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20260128194226.278605-1-marek.vasut+renesas@mailbox.org/

Marek Vasut (2):
  configs: sandbox: Enable zip command
  test: cmd: Add test for zip/unzip/gzwrite commands

 arch/sandbox/dts/test.dts   |   7 ++
 common/Kconfig              |   2 +-
 configs/sandbox64_defconfig |   1 +
 configs/sandbox_defconfig   |   1 +
 test/cmd/Makefile           |   3 +
 test/cmd/unzip.c            | 124 ++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py    |   6 ++
 7 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 test/cmd/unzip.c

---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de

-- 
2.51.0

