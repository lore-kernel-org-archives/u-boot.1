Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C64F33834
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 10:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC05E841DD;
	Tue, 17 Mar 2026 11:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BWtdKcu9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA657841B8; Tue, 17 Mar 2026 11:07:15 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF8B841CD
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 11:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmeBdM/jIu/NHKx5ZBqy78rxI1YfpIv5Ls67xgIl97Dz+DzkVhKNgfkGU6I4jTSNFrnyKcv/4gMcWn53YHeSQqShEo557CDlrbD+St3foFSFkOKpGBB0ZKpu9TKdoM4Tbg89nYVXnLKn/o5Du2ifY8MvVvJ5CQqPKy7dXGixXUW4H2kMortew2Ke+tXVZ1dzeaDFjQ8vrWbnxT18uvoI6bTSnNEJ3AtcI6yRmLMTnr7QaldpI4wG5JcR37jMpS0etKeJY8/cCfad1WENnHGDg2Zm/n8oYQ4IYlc/VRdv2Dn59C9MGooQyWY8ehjdaq/ODL+37UiF2sda1H/TVPbcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcYAV2dB2Wd/k8hIxMwWmeozvsT6VNA/veR9jUFZvig=;
 b=R4o7fcyrK7u2wiNcYeqLdd3RV97Qbt8bOsnQU2Y4IoEQEzJuUjLywuSzEdfNko7hUhv9FDCJ9sJgOKiN3XLTzj7EJeJ7G/6+Y14M7CMmW0WOPgOZFmXnm1Q/L20oz4/ZWCliuAEPqEkNDEBg7lwt27I0PoSMmkryCnOIM/xGIl5GjGh5n7zij+iq0IZFn5WPnua5yNwZzC7UAI05LdlxF1ed84U6nclDmeHliL9iBuXa6mdWfe5dlSayk6i5enqXAJzPWFPEFlO47ih7dAjXVj6Ao/LC/MhKPks41l8ke6+fQP1SFFsHSAp+NnwN4Cpy+a2YkbASQGp4wYZzifupsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcYAV2dB2Wd/k8hIxMwWmeozvsT6VNA/veR9jUFZvig=;
 b=BWtdKcu9S1Zte2UUYjEH2Y7odgZ9fG2YDQMF2NEVWD3we5DW0yvcO73CTpfioc0GSpHp7M9PbG3ZJVmc4D6ehyHNb2ic7uL5fKFOq6jXAXsa/AW1wQXVJm338rAkK6tpGQMLB94fZxWmblMClt9sxclAs5hoQt3pp8At/ynwsuF2jtWFGp8JginVm2D8IGuJxi6CcfWwU6FaeaAc1CTVVKjLIptgN6REswx7+/5NZIK/sbqS8+JJemvq9ZKEnzVm02KpyX8Z/+UFMIhWSTyVkb5Z+VkXwPzLdrTOdb6CCBkuXGHkiXZfPNlfcOqT9Eh4hcx6ZkUeeH9rLwbG5A6DOA==
Received: from DU6P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::28)
 by PAXP195MB1296.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 10:07:11 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::16) by DU6P191CA0017.outlook.office365.com
 (2603:10a6:10:540::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 10:07:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 10:07:11 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 17 Mar
 2026 11:07:10 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <m.othacehe@gmail.com>, <c.stoidner@phytec.de>, <trini@konsulko.com>,
 <primoz.fiser@norik.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/2] configs: imx93-phycore_defconfig: Enable
 CMD_USB_MASS_STORAGE
Date: Tue, 17 Mar 2026 11:07:03 +0100
Message-ID: <20260317100703.1933040-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317100703.1933040-1-w.egorov@phytec.de>
References: <20260317100703.1933040-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|PAXP195MB1296:EE_
X-MS-Office365-Filtering-Correlation-Id: d779a75f-29ba-4eb1-d9dd-08de840cf4a6
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: /v5MBMglyvgxstHFVeTzpvo6ZOnyq9SZMkrl8uCOyYy5QPcLuyOxeB7xAWCMusuMMAJgdglteuJYtKzdohITzBIdinfIhaibvhFrTHXQqz6BPd86wCXmVKG8aIr/p+B3fhkPz6QEB5MGhSo+fzJIygHycVF4hoXODqgQoKANH6CRBadpRV4MTheWJUHc4NJhpKlOOwMAOOqmrjdzgqZBuZJdSb8LSSp+SruspRa565biVf+vdb6Zy4Mig4yK4bMTzrelQ/M/kdg+mOtILyXCLhZgBQBCTAdK/Fu1/sDB1lR461rlnk0+FHmpZDh/LPvv5SYo5/XfxlzGQLWzdbQI9FBlJch7PtpFGxiPHAkJlsr7WACmP96r27mYrUqnAfo+Fc3ta5QZeM/twJvsiwARU8G9dC0lub1Vv+HMN2QQEPiDiH10XiP4U+PrtedY5sH092PuqqcnGYO0IgRG+5VLvk6uVeLbkd7CI9H8Z/jH4Il/CfH8ZgNtQhY8sNDfEVTShn9KmicQz35Bs3MdE1v1LNDap2ORa2BDolhiCA2vcbYGkbz7k99CDad6qxQ26jFndnbIytK/zViNHtFBy7TWtIUAjubblJ9TQLCvBBEfOvHJUmdphtsEYSl5Rlvxm6aVa/WRkC0XCAdSXHBqA5LHb38M+dihrrMr0jvaOH9g6yirvUlc2m3+niTOPDWcTr0VYROFS884/wnmE/Sh2B1iWSKYepNaSJD11oDFLqTX4H6A2QStdDcA+DD4jedUXBxBafX9jxicDJ+4ZjxBoMRzLg==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7IPwIG5PPQOHoVSpOYeHLgcjXa10Fa5wa5fuDB7FULk3DbJwhGFPxYvTwrgdEazMfbLDnHIIwTP9ZOfGrNpZDnoWVk6yzriw6G3yqmK517WsjjCyu+FhoTDVSQhH4ZUr0+EVQzcGrsHCPYRh5CulT3HpME1SIfG7IgJubzlBvvw6JXNBnlHtmKI7MfXC1SZTni23lI9eiwZ+ViRi4QCWV3zLLA5riFihDVie95mJYmKYEG3Qs59MEyrkBDa+CjFQ2sFfM2VpZV73MsalJ/wVDJH5yG/C66rG8D/jBHJkM83nCW3UShf18MTsmfbUepF+2wQtY8FACVrcskvtnFkJWjfQQqVuH2psDCeCysnfi0m0ia6v8+ZEb5ovKw5/dnEf6DIEgIV33cedMU/mgONi4nASkSm7o907kwLocU+eLTfNSCbTtcNntM+ufxMzc712
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 10:07:11.1545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d779a75f-29ba-4eb1-d9dd-08de840cf4a6
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1296
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

This allows us to expose MMC devices to the host for easy
flashing via USB.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 configs/imx93-phycore_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index ac719372b41..3fb6e7b5f1d 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.48.1

