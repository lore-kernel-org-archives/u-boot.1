Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182C3C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 18:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 567C084A73;
	Sun, 19 Jul 2026 20:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="F/nyHKo9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i5h4UtkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 705EB84A5D; Sun, 19 Jul 2026 20:13:16 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B5C84A5B
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 20:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h3BbG175fz8tyk;
 Sun, 19 Jul 2026 20:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LcqYlrpth7jd9qdXFnWMirp1tw9bNXQf89UY9tst6Y=;
 b=F/nyHKo9Q87uc4eWRX+ZFk+z/V5o2xo7/BOwQbTD+PXuhooilk5Vv9QY4eN6nX1/Qti26Y
 2NHYwGQ36nQ/Ai+1ZelFiNdw+xTw8gz3acgq2KqqtHdlA6pGYepxVV5MNu7jcEjUOJ0kpL
 IO9z8io4Yx9e8vNTXg7aWNOIVdh1Ah2Uwds5OiP6htEUOYW2+mK2OglU4/xKO0UJW/M1ZA
 AmGZ4p3SE+IE28HZEcOsGU3qWk8vQTGW2mFCrbeg2GhjfhmWW0862TtNjXkdaP1h0AEDBi
 yHq0AY36uiumrbpW9cBIW3Kcsq+ao0UoARAi1uzplxjfy19/J3tsoRfHb29c2A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784484792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LcqYlrpth7jd9qdXFnWMirp1tw9bNXQf89UY9tst6Y=;
 b=i5h4UtkGIHr/AmGI6HexzLLRBGJaAByW7HqICmHSS+Gywr9wOD9CntajGWa1Q0SciXiMSO
 vqrlFlAbbmcB9GdCauAgM831doO8YNGdZBxNmV046PXx+q/RhbB9AHn7aJLnwV2cTBs6et
 GtjM4GHJfD+iOnDtCinQxRJpN3px/RQDxFk9gQhiQ14mk3jEPn+ip19Bmpu846fzsP5Cjr
 0ekj0k/im8CJ7S/1lmRtKGNkT/qE/gBzRsVsFIkd425Y97FoojHDHdp2Iu3HqX0eYlM77O
 XqnX7oHQBgJwbWHLLqSrpqUOn0M56R/tRTrNrw9DHcf6XVcKqGi9APgLXaYyEw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] arm64: renesas: r8a779g3: Enable PCIe clock generator and
 I2C mux drivers on Retronix R-Car V4H Sparrow Hawk board
Date: Sun, 19 Jul 2026 20:11:51 +0200
Message-ID: <20260719181303.245004-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
References: <20260719181303.245004-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c8756162176816ed5b0
X-MBO-RS-META: 4hs96mmg3ohwfuhhkce5gqjbny7rzhef
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

Enable Renesas 9-series PCIe clock generator driver to operate the
Renesas 9FGV0441 PCIe clock generator which supplies PCIe busses on
this device with 100 MHz clock. Enable PCA954x I2C mux driver to
access the PCIe clock generator which is attached to one of the
muxed I2C busses.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g3_sparrowhawk_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index 8bbe9721d7b..e39d14df806 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -25,8 +25,11 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_GPIO_HOG=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
 CONFIG_BITBANGMII=y
+CONFIG_CLK_RS9_PCIE=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI=y
-- 
2.53.0

