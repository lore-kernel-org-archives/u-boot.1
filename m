Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1424CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 16:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B7B7847B0;
	Wed, 20 May 2026 18:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="LHlJqvZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022B0843B6; Wed, 20 May 2026 18:07:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA1884706
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O89+Hc3OP/8AhvhrGtFl0Piq+NX8fFyVVC5dd4UASV4dUsZXGyUmUMekxS7JBpl5xyH81s7b/ffpa/ITXwHgGw9bQZK3UcXrUtk6EVZ1V1rOEgyB7c80aMp13tchPeRTwfztHaJ69vbGTyHABUjlo/9msvo+R+S1oM9Lo1/2xDgpMAnIg2vvZzky4DbCYYKfil/hpbDk+w+TUN+QJfSUpeC4tCfyGHy801K+AozZAgYOQvi/QmN6YV0piOuiSL7WwjsdpXdj7lfw/jl7t15jtkRBPglxfZwrNYarONKjIZQ3tIOGD5UJXpOtSdQf1B9onLoNFUDDSPr4PXOAxHcdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+4Ii9qgbMFh648pz7cgsvOzdK/U7QPbc6HfZXDLz9w=;
 b=UBQbVuxrjulWT02m1D5Bf5bl2dCrpDh4cebAKhYGPOmYRvkStoJnv7NUj/+E9LTATdsZjUE0YSs3mEQhdyzIJyMmnUaUzsvbCmeemiC2kQTpCY14mlGfgynC2f8+VGQIF8f1d3ZQvd49gps4ydUmKZtGhORbxt7lqVUw3kn59mdtRarIU5KqpbaESd7TlEf7lINdH3NK5wwRduguHzHOrdus+ecL60ledestxMmGNpw9fGF6i6+fuK4VvxXwQSTHljGapGo/k97Tl/pMlKdzX28/HHb8ROOlcDKC75/T0lN1JFiIXfEfqGIxMni1g8zsN+NaviZFT95Ivc8jd3wRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+4Ii9qgbMFh648pz7cgsvOzdK/U7QPbc6HfZXDLz9w=;
 b=LHlJqvZ6G3RCsr+tyWO4ZfYWge9x4jN72DfNs/lEjY84NsUjX3RW8D/gRPDS29aFJ0URynKu9LERcDBP2vDoXRVnzZQYmfWVrSD3b/o56Ilq32dSfVENrLn5bz2hAQxQ/6jMca6zSHRFbyQSuDXlD2iXaRR0OZz3z03ReCoCSO5DXiYQu0eVl4YYDg8dhilZgDFEldmv/W5C4ha5d2MSOagEfMX5tT7tU2Tc6GIkgiKW84jOW+b2/P5bedxY+q7WkW5fCj2IqD4j2/uuHNMqt1H3w5wjwO8KmOmo34y96qaM3s0EfhfnqSEXNN6NInOCp9XrP6+dvJvlrcYZdfCIUA==
Received: from DB7PR05CA0032.eurprd05.prod.outlook.com (2603:10a6:10:36::45)
 by VE1PR10MB3885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:167::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 16:07:23 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::56) by DB7PR05CA0032.outlook.office365.com
 (2603:10a6:10:36::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Wed, 20
 May 2026 16:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 16:07:23 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:11:16 +0200
Received: from localhost (10.252.1.215) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 20 May
 2026 18:07:21 +0200
From: Yann Gautier <yann.gautier@foss.st.com>
To: <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/3] configs: stm32mp15: enable WDT_ARM_SMC driver
Date: Wed, 20 May 2026 18:07:13 +0200
Message-ID: <20260520160715.175032-2-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520160715.175032-1-yann.gautier@foss.st.com>
References: <20260520160715.175032-1-yann.gautier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.1.215]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|VE1PR10MB3885:EE_
X-MS-Office365-Filtering-Correlation-Id: a22cec0d-60f3-4c72-4242-08deb689e0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kxnVKb3oZysEYK/W/eK0O01c/VeIFLXZ7FGvnNq4+thz5gRtjQhOdQQwkb5MS9ZQnwCOSRaHkLWtsAZPrqBuYueLgQ2yTUNnbV0+tpEnPqUh+QWKq8tzD4YkqtjwJbmfnX9SDCGmfmfaOJfaUiEaX5raq1e/g5fMMT2nQ2fwQIzLo+AdtW4lpL5WXOALUlR3OL8Gxi2seYkz5jV9l+duCYdjIknX5CcMCCWMkuoCqvpy7gtkINxT6Fc5cfZuHefwHinpvOJ2QPB9sXGYxSSQi3KYMUcr+gjxxD5st5DepFG3xc0X8tCcOcHQ/gLJ7DUIczWifAS+8hWgfzFCfL5LggHw0A0J/BIJ+9gwGP+JlwgMBlvxiBxTo4trmXArnjuuLD1eC6wCjuf78FUVmBpQJHylrqsMI3D4JH266p0Wi01KcazyNQ4zFCg+n3QMlJDsh1zMMzIJfq2SqkOd7QBLcDpqLCJDFZ/Gjb9HdFJmidrr13Jul0oTv8xEnRRlu7jJ64J0WRsJjdX6FZkQhj+aexzoT4zMvDgwT4HtyaO05DCrT/ROhv8mTSyiCA9iigDxgKecbL6GhmUr9kpoG6T2kFtOiqZH6KAS/aSxIP0jRqfzocU1zumNte4NgwVNamtSLQn7TlGEXJqqV/96LZf29EaVnJ0i/EBwVRCDmtzquIiCzcj4aZzrfZOWEICt3C00tkvlbQFSMTtLIG52tJOw78+xdRdza7JEd0RW1Xv+ZMg=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yGO17uobFcxz7o0+pRYeaWxsnV3PE8bY/QZfwEGsJnweoXwE8+Rn9fSSMs6RelU4coLFU0TbGCdCIn5UeZpCgTlwGiMgiKBBIlH80jLyWU51vpPde9MwyBcDtKb+DamJZ8U7t+5fIR4O8XyrbfynTRlY7Lrtape6/E+h951D1e30TIHMyPBnzetRy1emXsex9VmS07jnP6LSNHMdvHDEqZt6Jj9xmF6vVvJD2A6JWacE3PA5uSKnJ8gx885a8zXEX6Vkk+4xAAcet+UCnGUmxLgsyinMfAoN628RqFffA7LIr+zfPiHsLv40vF7OydXRtw9fRaD6o8BwS+wrYnSbr4W5W5RsmzhzXrUN3LhiEkk982h43oXivJ/n79iUQ0FuQc5r33BmG1y98MtaSxriNIRpzTRAcoIvBTWcyJXKgF18XlcXm+3eLO783KZQXPws
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:07:23.0012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a22cec0d-60f3-4c72-4242-08deb689e0c8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3885
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

From: Lionel Debieve <lionel.debieve@foss.st.com>

Enable the arm watchdog over SMC driver. This allows using a secure
watchdog, based on IWDG1 peripheral and managed by OP-TEE.
The driver will be probed if a watchdog node with "arm,smc-wdt"
compatible is enabled.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

---

Changes in v3:
- Update patch 1 commit message
- Remove CONFIG_WDT_STM32MP for MP13 and update patch 2 commit message
    - update commit message

Changes in v2:
- Improve patch 2 commit message
- Add Reviewed-by tags from Patrice for patches 1 & 3

 configs/stm32mp15_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
index b9e44254087a..2ee08dc15551 100644
--- a/configs/stm32mp15_defconfig
+++ b/configs/stm32mp15_defconfig
@@ -169,5 +169,6 @@ CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
+CONFIG_WDT_ARM_SMC=y
 # CONFIG_BINMAN_FDT is not set
 CONFIG_ERRNO_STR=y
-- 
2.34.1

