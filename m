Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574D5C5DF77
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E7B1607CA;
	Mon, 17 Aug 2026 15:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdA8eJNrhHbU; Mon, 17 Aug 2026 15:37:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31796607B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981060;
	bh=kOZJ5QBxGYJ1x0ibHZFuKGdbdTeBV6CgtxpskX5jFwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M1hwVf45SPHSnD7YXD2SlFnybqG/WExXiQfZzTHX+ioy+1XzU3IbQfFrZ8VpXLfg3
	 WdRvepyZq6iQT1B+LWP69cv+Uoc2uMDgquXP4/uEvDi3BBwQ5LPXtK/M7NRUJNQMZl
	 7yvWPkklcW4+FjmNHUgt2VrFhtwtqNy+1mujtyGMbKvoaFNy9sYi+YYAMQUVo1KgDs
	 fqYwJCrvPmvzf4BoMlMHdgWrOe2ycI5M2Pn3bN2CTuZWvADxCk1YPBjh9OBQom3uM8
	 ZIotumxX5IAOA3qgP2mOsOgOyn80HAJhfN+dLBXzEnqozz896A8xaaQRgmrX6BIF7m
	 d/hZCs+JbYVRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31796607B3;
	Mon, 17 Aug 2026 15:37:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 77ED72B2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E05940200
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zloWpGuQZHaa for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:37:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5A2E1401E5
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A2E1401E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=dQOS6Vy5
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A2E1401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id ACF20B00573;
 Mon, 17 Aug 2026 17:37:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981055;
 bh=UBqYQUKpcCIxwt2BLpCKPgTDDC8BT//Mohl51xQAsc8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dQOS6Vy5eA6pHISiVQT/ITjUr8DZTMcFINwHxAYrM7E6O65+Cc6Ph4sD2hwwLPiB0
 iDpTXFYPRapx0RO1hOU12DuHbzxSeioKnGZ0sjLnLNb6+4B0NAfUvb5nSkwJMCuprR
 3IGfAh08h4SHdnV4XCl3b3J3p7JCSoKBe5lDtJvUyibXAlRHp/ORvvqzQDPoDABAse
 UCr4UjEKUvit+aLPbbUxTcvP1eRZPFqQB6SxJeqyZFupXaW77pjOCkaD6fjjp6i/5k
 FWKzTjBjY6DNgybMTNulk1vPGC8v1XVkyR7QxFG4/U1ef1TgyF4ASz1pyOmYIz06Aq
 BxKJ8Om7l5lTw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 19/23] board: nbxv3: enable HW crypto (CAAM) and rng command
Date: Mon, 17 Aug 2026 17:31:37 +0200
Message-ID: <20260817153144.1951036-20-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817153144.1951036-1-vjardin@free.fr>
References: <20260817153144.1951036-1-vjardin@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the LX2160A on chip CAAM (hash, rng).

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 configs/nbxv3_tfa_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 8113e51c672..554e0bf20ac 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -43,10 +43,12 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RNG=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=3
+CONFIG_FSL_CAAM=y
 CONFIG_DYNAMIC_DDR_CLK_FREQ=y
 CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
@@ -56,7 +58,6 @@ CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
-CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x52
 CONFIG_SUPPORT_EMMC_RPMB=y
@@ -71,6 +72,7 @@ CONFIG_SYS_MEMAC_LITTLE_ENDIAN=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_PCI_IOMMU_EXTRA_MAPPINGS=y
 CONFIG_PCIE_LAYERSCAPE_GEN4=y
+CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_NXP_FSPI=y
-- 
2.43.0

