Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DAAC5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 834404086C;
	Mon, 17 Aug 2026 15:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZvgF1w89IDqD; Mon, 17 Aug 2026 15:37:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 113914065F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981043;
	bh=NoS6159WD2zlS1RWkl96FPfofEvs2KDPC0gILe3t1Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mmlTCGBRZoNmewzAB8PkZ8E7+y9cwfpb+Zqw7JGn8gEdOAiOKbfESLO16u6qss5+E
	 e3F2UtD+jPMHHM6HETqQ79uZGripVecBxz4QUd8bZQ+R5/CwCQd1OfZTupoSQ9fDxe
	 TkLKTeiknhm5CLjcO/PTg5+gnXucIwmeqDncO+ZjxwLcQKEdaN5XlQtsF2Z9YYPjRx
	 f8aKBRjUhhYIOkF0FIAsLdbgjjUd+e9Ei865cLnnCFIgz/bt6u67uDblv3VfKPImOt
	 HCEF/7CnDhEFg53Vgn8liyzWNrzndvjyR169GpT3SkpQppjJMHvGJi/rN6+yX1Kom8
	 /YIgFzYmkKixw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 113914065F;
	Mon, 17 Aug 2026 15:37:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 07674194
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDDCD40232
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phN77fzlDdJd for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:37:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C660B40229
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C660B40229
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=hlnV9iV8
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C660B40229
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2E4C1B0055A;
 Mon, 17 Aug 2026 17:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1786981038;
 bh=xBvjL/8lRYbnR7xODYfvqGtqh5G2a++KSokFUey3DTE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hlnV9iV836buJkEgw6CGqNOmfV82g65zrWexdl3vstNGE3JVlJGAOAArFgq3Gq4Oo
 qU+oOI82Ln0VRebJ7OFV2XDkxSVokF5pRBItt/6NDZOWQks+XjXyH57+ceD7N/6Ds3
 yDtwnZrlcYkCFeD7ma5zLrksX0g/0Un9IGOKwpMbr3z7zHS1lOgl+GC7T8GtKdgiRl
 Jz9iAi0pJ5A9JvXnVHnbrhmb4K18pY3tBoPY19VosS89ahSYAKvuMcNftKL4xmmY4D
 CDu3nq8GRQfU7GBIpsMfK8kBu7cfIWOjGeWFs7THNV3rpw2O87cifoc2qpmMGNHU7X
 3o4SLJVgehFhQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Wasim Khan <wasim.khan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1 18/23] board: nbxv3: enable JC42 + QorIQ TMU + PMBus thermal
Date: Mon, 17 Aug 2026 17:31:36 +0200
Message-ID: <20260817153144.1951036-19-vjardin@free.fr>
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

Add the U-Boot temperature command on Nodebox v3 across the various
thermal sources the board supports:
  - the JC42 SPD temperature sensors of the two DDR4 SODIMMs
  - the QorIQ TMU of the lx2160a
  - the MPQ8785 die temperature, spawned by the PMBus regulator driver

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 arch/arm/dts/fsl-lx2160a-nbxv3.dts | 12 ++++++++++++
 configs/nbxv3_tfa_defconfig        |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/dts/fsl-lx2160a-nbxv3.dts b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
index 2047709f5b7..ad10326ad48 100644
--- a/arch/arm/dts/fsl-lx2160a-nbxv3.dts
+++ b/arch/arm/dts/fsl-lx2160a-nbxv3.dts
@@ -111,6 +111,18 @@
 			"", "", "", "";
 	};
 
+	temp@18 {
+		compatible = "jedec,jc-42.4-temp";
+		reg = <0x18>;
+		label = "ddr-top";
+	};
+
+	temp@19 {
+		compatible = "jedec,jc-42.4-temp";
+		reg = <0x19>;
+		label = "ddr-bottom";
+	};
+
 	regulator@10 {
 		compatible = "mps,mpq8785";
 		reg = <0x10>;
diff --git a/configs/nbxv3_tfa_defconfig b/configs/nbxv3_tfa_defconfig
index 7af9124bc6e..8113e51c672 100644
--- a/configs/nbxv3_tfa_defconfig
+++ b/configs/nbxv3_tfa_defconfig
@@ -41,6 +41,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_CONTROL=y
@@ -73,6 +74,10 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
 CONFIG_DM_SERIAL=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_NXP_FSPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_TMU=y
+CONFIG_DM_THERMAL_JC42=y
+CONFIG_PMBUS_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-- 
2.43.0

