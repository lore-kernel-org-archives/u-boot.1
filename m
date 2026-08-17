Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F656C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD5B840804;
	Mon, 17 Aug 2026 15:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PkveLk7ldmxY; Mon, 17 Aug 2026 15:35:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 01B4340807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786980902;
	bh=JoSIx0iU6fb+bH64tA7v+wRbQFvkf4YjHDMC9RpXQH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LQMgqQ0B1zvaxoEElwO/13PIf1zF67LNIfpzCzzHPo4jghzr0Gs68A+94F32UBYdu
	 16zZsn4KYJc3vPTWePs06zWr2wpgIW9vio4IdwQe5dmmvn3tw5deIBBkccbBJic3RN
	 ZLmsGWCEcW4I58tIgWUG2atrAAomb1HiMGu77GYgK9ZwFH8dwklfDDSa4kJZ7jTT2d
	 8+90KrVUoqaLRdns+uAX7KdT6douQHtkFJgbwZhDvHZjJof/orp72N169EW/r+Gf27
	 zVTia3w94df3HmHT0RGY9H8cAPH1oSL/OE3iauYiTMDtCJmydy2FKIfaUL/b3PKlaR
	 kbTdAsBqfKxGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01B4340807;
	Mon, 17 Aug 2026 15:35:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 986EB23F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CDFC407D0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ot3o9s_dCYKY for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:34:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::10;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7F9B8407EE
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F9B8407EE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=C8e1U54v
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7F9B8407EE
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id DE384B00563;
 Mon, 17 Aug 2026 17:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786980897;
 bh=pv1zmFFiRHTt3QCgOXtezyvlx06sFYrC6Xh7ZXLnAjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C8e1U54vxdDsTJ+/p0TOyccqe84VQ5NDErWaiyd2sAgcY429u3Vad1DC5u/IlZKi/
 udnC+NQCWqsLuRobmPct07S8QKqSh6fUIXz5+0nid7hNu/4js5064ZJtJZKLJv0Ktd
 dkqvpz86nxjJLdQUADLnDO/IVKVO5eOMyub9MNAUcMzzqkFT2Ae9LtT7uxWbP4wKl6
 txcfLCxLQyYe5jd3pS9P4WSke6PLGTsR7AUsG6A0YCmxqhpmEe2YXRVfWgw+tvleMz
 UuS93UAKK1SvrlLzdqru3Q2PXhHfedb/jLWVnTFIELvfpw8z6M0o2FvZCaCudZLIc0
 J6HWUrivqpqjg==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 10/23] arm: dts: layerscape: nbxv3: enable UART0..UART3
Date: Mon, 17 Aug 2026 17:31:28 +0200
Message-ID: <20260817153144.1951036-11-vjardin@free.fr>
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

&uart0 (LX2160ARM UART1, MMIO 0x021c0000) is the console. The
remaining three (&uart1..&uart3) are available for applications
at the U-Boot prompt.

Numbering note: the LX2160A has four PL011 UARTs on chip. The
reference manual labels them 1 indexed (UART1..UART4); the device
tree is 0 indexed (&uart0..&uart3).
The mapping is constant across the family:

 - &uart0   LX2160ARM UART1   MMIO 0x021c0000   (console)
 - &uart1   LX2160ARM UART2   MMIO 0x021d0000
 - &uart2   LX2160ARM UART3   MMIO 0x021e0000
 - &uart3   LX2160ARM UART4   MMIO 0x021f0000

TF-A also uses &uart0 for its own boot log.

U-Boot console is at 115200 8N1.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 20 ++++++++++++++++++++
 configs/nbxv3_tfa_defconfig        |  1 +
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 9dcc1bf1d5e..9b79d2c3253 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -13,6 +13,26 @@
 / {
 	model = "Free Mobile Nodebox v3 CPU Module (LX2160A)";
 	compatible = "freemobile,nbxv3", "fsl,lx2160a";
+
+	aliases {
+		serial0 = &uart0;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
 };
 
 /*
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index cb6043f3278..6d55a808a76 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -20,6 +20,7 @@ CONFIG_MP=y
 CONFIG_DYNAMIC_SYS_CLK_FREQ=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_SYS_PBSIZE=532
 # CONFIG_ID_EEPROM is not set
 CONFIG_RESET_PHY_R=y
-- 
2.43.0

