Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C62CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1859783A79;
	Mon, 10 Nov 2025 18:38:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="G5k0Kw8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2475F83957; Mon, 10 Nov 2025 18:37:57 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26DC83A79
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvY6ESKXgM1pS9pL7h045/P4NBVquHCTQXenoM57YAMEteZqrrlj7em+XJ7rYBYUHrCfarn/7RftSdEgQcK93kPi6rXtIRBbTCqL1AbTc8PFugXdsYVOIhI5PpDDMufjbpH/IE4letX4Yc6RCXIM9I3vJAPq0BPCjTJxDxPTyA8OkPW2m8u6I15qLp69yUCpvl5gZIzmaVo1Fxs27Y5gBzKkr4w8XfkMPLlq0LX2DVQkCjMTg5fesg1efPQ11Tur6kEE/iq6bSCZRy7wWMNXzUEsDBkBHAFd5RE313qtE6usbWUh2zamNNn8v6O9G6TXkZRN7JE9JGTVo1tOk+HQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCnZbqHB0Ox77bNvtW/6v+KzFqj56nSI+6vuUg+yp4c=;
 b=n5siDHUDXCbKbdFzFgNe6PNmx9LqEAIH3MQ3eoRUUWMYkIndsLnL53oAumh+gs+/wMBm5JnHsBMuiLePTgls0jy8DzsKSlaeOWxj5LtkI6jtj8TmJhzBtJdZsrFvZebZqzvEtaRF59EQxOAvkTa+ThM6Kdz5AdSFOnWv2dKLyBNipa/ueaUdiXxVIt0XWUYjS5Tjxb2n0WiV+MknVaSW5Ge3Cz3QW7VHAiuRbVEQAkipmde5PmFthrZzq/KaGkeL7LtPFuJ61iLd4S0VNltLcFkFGZOgGeU8uf9CPUYZ25FKiFVsPHcpVmYZvTLFGm6arV70p2HmL+wuCLIY7cjqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCnZbqHB0Ox77bNvtW/6v+KzFqj56nSI+6vuUg+yp4c=;
 b=G5k0Kw8vmQqiVr5c8qvtnc3dShxKdYOdj/nKtCy+XPNHbGRGBknnQgbcXX9J7co2HUIcWDLt6TvaEPcHnAeUTrXF+hELY8tK3tugYK4bqLTIs+agQP4pfjyLn5OljK+QLCo+HxMNYxVuH/MJqwNJeQaF2nRQcYhjNQt2tsD5oW2wMN/AkAXG2gmhYQh0pUMvH1vY19/Xv8QjVHcyAvEmP5+Ef9ocjg8Fj37eKw/ZXjn3j4JW2z1wTxVaig83osJDyBTcyXW8uQn457JF7tYn7a9c1na84O6l83xu0JqgAM67YIxIEMk5R24kLaactl4aji1C/wJOO3LWZ8EIrLHFcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB5984.namprd03.prod.outlook.com (2603:10b6:5:38b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:51 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:51 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 5/8] mmc: sdhci-cadence: Use hardware version field for
 Cadence SDHCI controller
Date: Mon, 10 Nov 2025 09:37:34 -0800
Message-Id: <20251110173737.24545-6-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3479f0-548c-403f-7c2b-08de207fdf6c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3k+3UJZJtG7oKGVttZrSPe/9Qs4R51+NK9ajVWZFnjeEH8AaCAwbyUnznf0?=
 =?us-ascii?Q?feqgrXigLWexM668NBtB72HIYt0u+9s3O7kKHLZzaFayi2vI7se/8GDomLCw?=
 =?us-ascii?Q?hykwz4gWTfja6C43JAd6u+oIF/GXKkvQFwdwUJuDYxNKt96uqo9FG8xQz0pr?=
 =?us-ascii?Q?/Tk51RjPRY5hxMMQ1yCk0GKNUwgHEUN9Um3PG8GsrAuPCFEOT5/SqiVNUO0J?=
 =?us-ascii?Q?f4w1Htt4rnVpLTOwx08QZZwmXsSvGiAqo+RZ1gr6yoszS/2DnAZptYtabhfh?=
 =?us-ascii?Q?pxM3zf0C3lXzj2N1kWDmENUUw62D5hlCl8MfF+knxwLAiFepQHyAURJBZXPX?=
 =?us-ascii?Q?polZBGfIwo4E5VrM0eu+IBt3BwKeBuF5pQTyYevCwKPANCFz9LfkVvYWyHEd?=
 =?us-ascii?Q?GXpUJp3V6h5QWHSfA4rr+hBgaY/ylL1ZxfDPYIzPZn14gX+z/dPiNiMdah2F?=
 =?us-ascii?Q?ch2fclQsGDCCoJcd59DD6wN35UxJ/NyQnbkg7iF/P+5dvKtD50cStXiF76e9?=
 =?us-ascii?Q?+PnnvmR8Cy7A5cqd9ORsC5N4itdPoon/QZb4NkzgYX1KM+xLU1BwlNdRLDm2?=
 =?us-ascii?Q?TWA5g4z3XCyohgrV3Jo6rpViyrLU3FHBd5P6/rAVYFgM9KCLZjwX9sL93wJo?=
 =?us-ascii?Q?eTZOhu/lxSm4cmPu8pbWSKqBN0gl8UOpGqgGAgRvwdgeUOge48lE/T0GNacK?=
 =?us-ascii?Q?pyrmaUoC8aAzXdLCr4HDI6jrXSp/4FUiEHYg6MLn2VWPA1euIo5pIvFO8fTV?=
 =?us-ascii?Q?+M2BxIUX0NUrQh7wKvO3mgULZHHowNw5p1sFjiHljIdsAPTdA7eCv+iytu5g?=
 =?us-ascii?Q?V/JUdh+4L6vWzGNscUclaxaIYNeqqwXtS4+h8RJA6LYQFr3VlP1efvIAhIGH?=
 =?us-ascii?Q?+0uRFpkCxC7ElVAK3opJUUAPQYkBmP0U+Xq89mPiHTvZTUC9FUEiYubDYZjI?=
 =?us-ascii?Q?Zat2/IiyfinB43yDxU08iRqUF+6oVjxr5l3LF7RcXmFOVVcE0eJHL4rB4s5g?=
 =?us-ascii?Q?S2YHVfyxkg2aseAYvb29pNjBwLlmQhvXOb3gkAbBNokOf4WCdGVMH71+1Ir8?=
 =?us-ascii?Q?49CRtST2toZUeMpCQ1lomQCrs/GQW9AQy4xOvhK6CdhpxVwTu02yF/O+Ty3q?=
 =?us-ascii?Q?QiNr5qnAGT64iXiEtk0i4ucYDYpy+7ZCPA2IKSu5R7g5Iqxyg/M0+6G7YMif?=
 =?us-ascii?Q?Pa6rDBUDKfPiBJFP/0nAc2Hrd1wJnesf8gjLrWmjFGRe8QGWm0F8gsqhgd5W?=
 =?us-ascii?Q?DCLxpSGJ1zPP+hawHQRLmRtcPgkMQ2OCb05kiFgIbQwkO/3spBx8Qo1mWD8A?=
 =?us-ascii?Q?CovY+VFhNg/ZMQcBQHRvOs9XmjMWUHL6S0cftHM6BCRAiLZhqTPJlI0VNguX?=
 =?us-ascii?Q?IsmPQOoTtMO3LgVGX+oe5s89gaSBK6L5XhLQyFzvExOTzh7FNRIaOTNugZbi?=
 =?us-ascii?Q?ewL6DIw3yBM5dLRGERGVR7P6JqO+l/z9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4V5NU1T3NiEYeCo3Qpfzr8Msqo1ZYivUryFney5D19/2LtkOeFSTS2FbMtUa?=
 =?us-ascii?Q?a+dvC89jbzq/2ULUn9xFSgGLKwEo26fcTlYfsWlvb/3m+ZnU2/TeWURHUO7Q?=
 =?us-ascii?Q?xLi9qhZvoOncFHrkLXyx6sfi7Xp01Ot9Jb60bLbGVK2nQWlQBj4t/T+k2HuH?=
 =?us-ascii?Q?e1uj5YcFimM7kd+AJGZDaEgjmRRqkogsDI1/oEUcFlC3NFkXngHGoZduMyV0?=
 =?us-ascii?Q?hbYe5SUTAqZULJqQEb9dYnIm+mm4xD+/Geb5WirlTh/d/wnoBhZawD0p8xQZ?=
 =?us-ascii?Q?T0K90t41JTOuZSAJUpK4SxTHqXlNJVzO1J+KyXOLZz2ibQZWMk86sHp8us+s?=
 =?us-ascii?Q?ZInm1ZgMbfoqkh/t9ll1hKlU1fXaqUV2bAPTeFXzf7CshyiEMMUnQTLeVJq2?=
 =?us-ascii?Q?ztMgvMox3OYqOFZpjbPBSReFFzAoq+qWL/xnj2qBxgZr0pqzSPDoxX4mAv8a?=
 =?us-ascii?Q?dfMi0iam5j4ERM7qx5qhHQ1izyOou/vihTIRk6Pk8SFGcYhuMfULCgZfgHni?=
 =?us-ascii?Q?bZCfjOQ96CyGWQQtJ/2+C2KaTCZXms6Nn5nAMC+s1zKRnzvDNuZ2HchfwF0r?=
 =?us-ascii?Q?YL6xa5Y/OaoEUGl8GaIKaCnu89HBNn+OT6hpjgkiSxT3kIb8vAgM6pJYjeV1?=
 =?us-ascii?Q?SGK+1R/ndH5mrBBVDZ21hLKMBQ7sgSmnN/1h60HCRltMQRtdTGrpbbrbSiNP?=
 =?us-ascii?Q?30057eL9N3F5G4hQpLLayiV5EGVtaiPV0WE4Mu1cCp2GT6VdtpJ2NnFdVJKV?=
 =?us-ascii?Q?p1xjbn3C7ZVwEfwFz0uiutGRYfprbbq7OyPY/Cno2hCm4LQOJx/e+PuPBtxw?=
 =?us-ascii?Q?N8mMkO+hMc4LPUuZDsGcfv89RXCQhtQAB0Z7ofnRUxVvRYZeejyUmaP1L09F?=
 =?us-ascii?Q?lGLbHV4ImlPLoCWf4SF1qy/G0qdqG4c3NKG/1x2DVGW8yWo7BxwCbKTcUeaF?=
 =?us-ascii?Q?+0VcypOmH1UyzzfEpv7XW4zdjkuOu9NvXPA5C7711yfSWxkbAcB0rfFqTq8N?=
 =?us-ascii?Q?VzFzwkJ9iIzGJbd130VUZP4gFBIra1McaJtPj0/+dQy9z+UW3lA89gOQXhDy?=
 =?us-ascii?Q?FAqgFKJXfap5Vap+3+rkRiRJ2MlbtplB0fZGapDWoAXjWIq6LSYOeCJh8cB1?=
 =?us-ascii?Q?rOT4xMSE0QBQTcH4AkmFMAgozq01FurV3IJG5nA+SW4koeKPjOXpmPUDxqwf?=
 =?us-ascii?Q?Cscil26j5yMbeB9620b057puiwNwM+uKVNxYdX1P1yLirRgu8BC7DfMt6N0r?=
 =?us-ascii?Q?uN3zms8AalPxSwQW4GTT2UUDBqv+1RlbNxceaMHgMkaMITYV1t5jo5BfAoOa?=
 =?us-ascii?Q?V3nBNJG96Nmb6o+rH3zPH2topG7fwEy4zYO63hL+92dx7NsZE79K8gsZob2c?=
 =?us-ascii?Q?7oOW2lnmP/LPNyQibeZQrD8J5L9JRi5BXfV8osQ8Ehv0wHfz3iSnP0Ij+cTP?=
 =?us-ascii?Q?yRUveteMoKZQtVT2KuweGpQ+ixHCKMxzmooEoCI6P1MJprlLF0J1Xu9Cumvf?=
 =?us-ascii?Q?sUbu8s/g0QygdQuF2dWPRnuDLCE+1Dgb2Pf4r5fBjm5wSk1WNqwf5LoIUOEq?=
 =?us-ascii?Q?qwArDxwgGloQffxgtB1jqhksm7iRSuN+yDRDyw3CPZxN+QLFJzVr9MBj9Q07?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3479f0-548c-403f-7c2b-08de207fdf6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:51.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQLtyf2L9fGBmN5MhoCP0LW/Ma91AYRZOMECGhlWKbZClNeZj1zhrAxJiBZVFoF9mcdEpbBLNzYYiTBJ+l+0s1houPvZHf13tKyGC75gWhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5984
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

Replace device tree compatible string checks with hardware version field
detection to determine SDHCI controller capabilities. This approach is
more robust and aligns with standard SDHCI specification practices.
Controllers with SDHCI version 4.2 and above will automatically use the
enhanced PHY adjustment, and tuning v6-specific procedures.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index a151ce10ddc..4a54196e06d 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -151,7 +151,7 @@ static void sdhci_cdns_set_control_reg(struct sdhci_host *host)
 	if (IS_SD(mmc))
 		sdhci_set_control_reg(host);
 
-	if (device_is_compatible(mmc->dev, "cdns,sd6hc"))
+	if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420)
 		sdhci_cdns6_phy_adj(mmc->dev, plat, mmc->selected_mode);
 }
 
@@ -162,11 +162,13 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 static int sdhci_cdns_set_tune_val(struct sdhci_cdns_plat *plat,
 				   unsigned int val)
 {
+	struct mmc *mmc = &plat->mmc;
+	struct sdhci_host *host = dev_get_priv(mmc->dev);
 	void __iomem *reg = plat->hrs_addr + SDHCI_CDNS_HRS06;
 	u32 tmp;
 	int i, ret;
 
-	if (device_is_compatible(plat->mmc.dev, "cdns,sd6hc"))
+	if (SDHCI_GET_VERSION(host) >= SDHCI_SPEC_420)
 		return sdhci_cdns6_set_tune_val(plat, val);
 
 	if (WARN_ON(!FIELD_FIT(SDHCI_CDNS_HRS06_TUNE, val)))
-- 
2.43.7

