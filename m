Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089DBC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF89E40813;
	Mon, 17 Aug 2026 15:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3Mn9lKkg20t; Mon, 17 Aug 2026 15:35:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B7C540715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980937;
	bh=sFSKhl6O6ZusOyQEXg2d0yRvGBUN6VA1OW1BkJjD7pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jsCKjiXWOY0SKytJaJVIX+aCTu+7Cgwj1T7uFCIl9X+0tVF15qCzikK4c2hTKlqGr
	 OuAQknV6j3p1ahqenvjs1J0ublO7UGLe90DClpT7PkQfK0xoCcSPF3wph6vHH97TQ1
	 Id9mNCPIEUW9ENlmTz+Eg09YiZJO9maZH5q6bXEQ/04Scc/E+2p3QCTiNkeKSEP5f/
	 DzwTTVGRZxsmhhkHyVGDy3z839lxiXvOM5Wi6mGfchjIzrJWUq4zBKqvT3HUKldzu2
	 oYpcQJZ9JqnbjsV9Qh5B2N9hU8kPp27bhx4iW3SGYYpRnEZrmYpeF2PcIhcUKoJNJI
	 2aEoqJdfXPPfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B7C540715;
	Mon, 17 Aug 2026 15:35:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBF20337
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9CE1607A8
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KeNLw2Q9Rl6b for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:35:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AED6C607A2
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AED6C607A2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=uhb1uysC
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AED6C607A2
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1FCA8B00576;
 Mon, 17 Aug 2026 17:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980933;
 bh=SvVZAOj5daUw5EcdmCpD2SpH9zllmlI73SX4xx8m3Ow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uhb1uysC/QUjfkGY6ydlDSXSILoOYzRcykoobHwl+Eht4ZW1b1J8SCdhNyNFYciFb
 Gv3zDxZ/dgsVuuuTBBL+9dHMVc7UqH1s7zcCc9VIzN5zDm05NPNDPeXxNrWtUytfYA
 OFaKsMVPqzOkwOcs+Psd/l71BmXw2dm5Y83syAshTB+WA9k1BkStq8a6uG6SSTbA8Q
 dor+tISO6DUhBzQa6li8B/Mcmy/3vRkFtnL1QhyJRzxP4RssvnIyYbpfuoDkW8MUxK
 9J6peRtnvL0aHD/0hz/5tl5c2SWDzdOlCR/ix56FhNCZwNrj84x5IC4xfTwk1WxHBN
 n+TMUSr71l5Fg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 12/23] board: nbxv3: store the environment in the boot NOR
Date: Mon, 17 Aug 2026 17:31:30 +0200
Message-ID: <20260817153144.1951036-13-vjardin@free.fr>
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

Set the environment to the FlexSPI boot NOR:
 ENV_IS_IN_SPI_FLASH on bus 3
 CONFIG_ENV_OFFSET 0x500000
with a 64 KiB CONFIG_ENV_SECT_SIZE, and CONFIG_ENV_ADDR set to
NXP_FLEXSPI_FLASH_ADDR (0x20000000) + offset so AHB mapped readers
reach it.

The 0x500000 slot is reserved for the env in the boot NOR layout.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 configs/nbxv3_tfa_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 9cdf11b9975..6684fecf3a4 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -8,12 +8,15 @@ CONFIG_SYS_MALLOC_LEN=0x202000
 CONFIG_SYS_MALLOC_F_LEN=0x6000
 CONFIG_NR_DRAM_BANKS=3
 CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x500000
+CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="fsl-lx2160a-nbxv3"
 CONFIG_FSPI_AHB_EN_4BYTE=y
 CONFIG_SYS_MONITOR_LEN=958464
 CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=y
 CONFIG_SEC_FIRMWARE_ARMV8_PSCI=y
+CONFIG_ENV_ADDR=0x20500000
 CONFIG_OF_BOARD_FIXUP=y
 CONFIG_SYS_FSL_NUM_CC_PLLS=4
 CONFIG_REMAKE_ELF=y
@@ -31,6 +34,8 @@ CONFIG_CMD_HISTORY=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_SPI_BUS=3
 CONFIG_DYNAMIC_DDR_CLK_FREQ=y
 CONFIG_DDR_ECC=y
 CONFIG_ECC_INIT_VIA_DDRCONTROLLER=y
-- 
2.43.0

