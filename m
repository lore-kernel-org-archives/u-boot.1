Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1142CCA470
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 23:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08CDF839D9;
	Wed,  8 Oct 2025 01:50:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UgzIH5Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF3083977; Tue,  7 Oct 2025 21:06:49 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC9F83959
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 21:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pevusU07JH2XIK4MCAwBKPNtykKBFZoorYm6y/T18APfFFOOWZchbW/KcKYu/WaCdsFu4I+C2svrHAgo+L8yDjLMBfPTLtRv3TYwR23Q6oGOzl4SMCvKWsv8b5dbjLl09a+RfCaGxRUJlQvlieyJIPWskFuEi1NN9RiSQnC3IG530qe4MvkpCaUHDav05yFU8kEAJEWNWyib5jpNfh9yBBRbtTRFfkMLeYxyi57q8UC84G5K1yozOWSzsEsLEhB5DcsgOAjukJ8ZwAFuBo5d26Xi0PlOoOsSeOj2pidIEZPVyU6/Yxk3Iw3iacj8+9vLv9nsyz5FrTIPoAssWiPS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fiHZUIkjgjTs1Ujo2rQpE1HgVVOjTUDAYyLmpBbjaQ=;
 b=i7I0HvQE2dCY8DYsbokpd7DbcGdKD2uL8nKXte08zZ0AzH8tFxflyfbWmor2kIhQx+b89DmwrZLEQN4ci6Pq/zBksJMBUcqxzmv+8wsRSk58kAHJT+Fiocs0/FMH4EvJfvgrCGfwmHikshnwF6R15l/y80U5dUWjFwa8HfI6oJTZL+yukM8hx4dHIivYnVEZhcNiTj/oD5FOZgn/AWyBxogD8GD9kr/3lKT6SAW5zSbLMCHHaI7OAbA0fnd8YDVvn3Y6pbeFy0vGOHv4wPVwqsZnNP6CVg/+i9kYmAdPH+wyMlhShP2mLVVvcdSI3+ReEntNYschX35+tNmpwOIg/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fiHZUIkjgjTs1Ujo2rQpE1HgVVOjTUDAYyLmpBbjaQ=;
 b=UgzIH5WbZh8BN3EJNMGv0dXVFtro9u6KDohdr2h/bsLTulSK+Zbw3bs1IDkLxy+WMv0yiT80rAWIo9vOzD7KxDDLsAUX2CCJAifXcxm6MxCnWlAGXPnNKINvTxSFQ65LFfikuSvnDwFo53IS+lV1iaO4O3Tklwa5+Ux5H+5hdKQOTDMbqNaGu+PRHKgGRu6sconV7doE8EAXlCrSk9osADrdeZGkFeBRdq073d+mjAKxE2cdJe0S7RZGz9Pn2WrDp+wZq5tfRwQSaGOWRwxk/wNlpur9u2w+d6/NQlAg5z8gQid/xYxS4SUDld/MlQpnyhC08wLh2jx3JBneiqPkdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH2PR03MB5350.namprd03.prod.outlook.com (2603:10b6:610:99::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 19:06:43 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 19:06:43 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 kuanlim.lee@starfivetech.com, weiliang.lim@starfivetech.com,
 yuklin.soo@starfivetech.com, e@freeshell.de, marex@denx.de,
 tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v2] mmc: sdhci-cadence6: Use dev_read_u32() for device tree
 property parsing
Date: Tue,  7 Oct 2025 12:06:38 -0700
Message-Id: <20251007190638.4325-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH2PR03MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a05ccc-b41a-447b-77c1-08de05d4a765
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qh7+plAsYq+JOOdtRKdoBmF2czWUhaMQ7qgkAhIsIGUe507u+bLmOjmLbwPc?=
 =?us-ascii?Q?0ldO5omwQ6uS2+mGQibc0sTCAwQrGT0b4Mlz9CMEwawIFNHx0ZJEpgD8+7B7?=
 =?us-ascii?Q?fdR2zmwy9zctgtYkJ33E6Y9T+jwS7qXlE78KRIX1OvzwukU+Z3NCrBf5Z9k8?=
 =?us-ascii?Q?QAOLc4/FJyC+fhKeN/8MYaqCC37OBKQqAFd6hva463LBdAQSEr7GltSLuxbS?=
 =?us-ascii?Q?4t4F/3HNr55JNdJNla509wQJJOukJ33yAAkxcjmHfrCIuswY5PRMXVOfzE5P?=
 =?us-ascii?Q?Jd1LpvildOCbfDl9hnl5xF1Tkv0pLEEzAZOAH20iv9cB+PgQCYhAaHwPe2yr?=
 =?us-ascii?Q?w6MLWxXtD7Bep7OTtYzHdZysIaTzS5JjTx8oiiGA8t+/oSqwYr/kr/UjT+p/?=
 =?us-ascii?Q?Pv3Z34KIqwd+aXKm0fOeDwILXXGMc+VwTSC0g4NrgrNLqEFq/K1joU2B8+a0?=
 =?us-ascii?Q?bQTCQafOwfRA3KT5aFXWbRTTyb8omqo3gLiu93MwZdF7PQkLAer7snrSHDTm?=
 =?us-ascii?Q?YmHv/31JeMubLxokQDBwGeZZ7CkYXw8zjhwCdOK4TqZUpbjjcN0KNb15vs8p?=
 =?us-ascii?Q?MWvGP+9s8sEA9VxXYc/ImPWhj2SWD3PlANZ83Bf9tvJWM5jIub+GbbulnLRi?=
 =?us-ascii?Q?L2iJddTeJDUhir7vmD0ldSRS9JrDwl6AWbeNLfqUuQn2BOdVhcXan2WWuSEi?=
 =?us-ascii?Q?fQCu2/3qKHU30PbrjVJ6c65pgl3+PnRvS16+Rye8nxdFx1/dVCn0knWr+jDO?=
 =?us-ascii?Q?I+89imO/YzzDMTn7RqxLLNwEVtNQIAbkzxic7Xb7plXEfo7TAPsmN//DGmpg?=
 =?us-ascii?Q?AyXb2oRhMAEUs6JBd0vpK2pkfO+rnUro9hMDWM2ZEDDLBdwhEWrSO0f0F/ST?=
 =?us-ascii?Q?a5IJuc9Mc20ehFBFSAODuCUnWuF40gwBAMh6P6OoujS/wbXBiRmv+VPYPJve?=
 =?us-ascii?Q?2HMGJfEAiZM1sWMF1Md4zCtvlgYFyjfecBw8NrAGWaTg0UuOENfEi4s4pqM+?=
 =?us-ascii?Q?FI+ahWwAgDeYvi9ZE6tH2hlYrUIKFJ6C72ILpfcpAy6LITu9yr42WDKt/TBn?=
 =?us-ascii?Q?8J7HoInRjLgkTRCyY31Vv0mDOjB801vredhTCO2UUhDZ8DBVLl8pt1/PJMJX?=
 =?us-ascii?Q?8F3he/RVTnbmcB+3l+g0wdyCjG5Mo8r/j55qOR38ts6phAiOBJXY/DWGdTny?=
 =?us-ascii?Q?YsDBEZkFTbOKQzzGVNbTmM3h0NH7WlSWjeFKr85lFXhu0ssccACpB83bqu9U?=
 =?us-ascii?Q?2KvU5Wds6MmH7fSHOAbIjKx81gkHJ9pLnOnbTL7gDRXknN8QBNCg2Pew++e+?=
 =?us-ascii?Q?IMpysM4aYFVcjVnP82WxiweD3QEV0TETOGSOvzRMV3MVJW3barZoxPKq3kMb?=
 =?us-ascii?Q?zdqTekrohxL/cx2qKK42l0IrAVyStDqTSI32fk7myn5KPxdJrwfuK693oeK4?=
 =?us-ascii?Q?3jvihApxShiqejKp8j09lwgGtr9RC+gq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Us3iBrUVKc3x8LR7GHsBFG0fZ5nXnve10Yi9oAWSCvlkZZEwYKf9k6h//RMn?=
 =?us-ascii?Q?2WzcYRuC1ZjbEfHzROImN6GzA5NIRnnK037nd7la0GDwkKE/5Xp1zIVCbG4g?=
 =?us-ascii?Q?Us7p6XoAihWN4/3X5Xx8HxOykOPuf7chkFu/q9YYvVj46CBG7nX/EXAlQMFZ?=
 =?us-ascii?Q?jYmup17AlcWbZCVHNybubnsgddJhcmD6VDNNZA42d2UsYtgzVUKUplyoZRDf?=
 =?us-ascii?Q?66IcuRGp22Kc6595NLJFsVHwIZgHmmgyJNjnNCCNFTKlhG1ETAePQweGE3B2?=
 =?us-ascii?Q?aFxlf7G0q58/PfTIbMgQb1Rgtv1Jgdk+PE3fe4sJ5pQ14Zqj0BIyo0H8kaj/?=
 =?us-ascii?Q?BbSiUqHRvA9+ZOEGS+xbwrobSKvW261IsFcrKApbbrpmD8ReQgcU4ypNxtwt?=
 =?us-ascii?Q?hs5cTYdtJIzPUKAnp3MObXLBAGMudRdHwokeWAdLo8WP88U3K2phrumRmL0p?=
 =?us-ascii?Q?89VMvCeDrRR1ZqG1ztIwzF1XRlnsNzwcY/Pem+7Eoq20Jbv+bGKgi/0wzMiO?=
 =?us-ascii?Q?z+Lx/jyKoZZVC0vUN+lps28vI9FsZEpAIAakOYyB+pa/yi3dPcEzXQMxvWwC?=
 =?us-ascii?Q?SW/i5YSqETkl0N8gkkaYjWlyW+45LxrL231uYE+NqceeTjyao5mSUAZDoFss?=
 =?us-ascii?Q?Z+qozDDMfXFy7yLnr23lvRl9v7h2uHmSgduYTbvZ2yH8z+PnZUAhVkpxPm07?=
 =?us-ascii?Q?Lv7Ewc4/I3ykVcmv8v6BpRGvzwXMLqWsB0veZ0jNUQtb+KiSGklg1xhhDn+V?=
 =?us-ascii?Q?T0Wugg8iyIvc+Dh8XUk7tGAGmoDoPQwMUMEQnn4WUkvNiBGkXg7XA/BiKJk4?=
 =?us-ascii?Q?iDuOm3H3w8MvSFwbEE1/AeViCCj+6cra1w+A1QMpzNZSfatjyueSusOLjBDo?=
 =?us-ascii?Q?9NQVUQ2Od3byTD0an8C1ptNvRhdRDetYsFd7Tlli2Q6Rprj48mg6Kcqcahy6?=
 =?us-ascii?Q?G5J3hn1cinOz3Cs1IrrUV1EKmgs3w90qPlhupgdC+ddoHYb8Mo7Rk/tYR4YM?=
 =?us-ascii?Q?JyNXTpj9ygUIUkDzfgWEaWc1G9D4U+bWEfW5Rt0sKvcOHdxOvlsKdoht5Gzw?=
 =?us-ascii?Q?MRvINHDToamA5xdt1B15C/F4lBQ0k9RwgRczhW39VPd78hGgTrrrWy2ATNf3?=
 =?us-ascii?Q?bqjDwrw/Edsnox36gYbv5xDmsknHDvwtzLLDp8FEjQWeYHKWhS4gpLiKrrtp?=
 =?us-ascii?Q?I2SpgWf2CxwymEBhnkqEWt5fMq4mV17uFlj2aXIZCaewikXIZG6I5u0DidBg?=
 =?us-ascii?Q?U8Grx5xF3BcJJqilUgUlNW/T51G36dxJJUz0gyYG1N3qOa+ounIVh3iLGS5g?=
 =?us-ascii?Q?l23SLWWuJs5AL9KFFtklOc/8NbMOXhf2nFZwwbIsg5Ru285QiyIgfPvWZhun?=
 =?us-ascii?Q?FaCslb8WoDGCfSg0tRxveVwTw/FiU01dfFhDTHrcCKKLuxwVkX2yeZb65KfN?=
 =?us-ascii?Q?8exVcGx9bCtxkJw3q1S3i8IhB5QGqC54wMqQOdPsdKS8n/dXjTvUfUpuvJHf?=
 =?us-ascii?Q?Az3nVTqw3O3FS+Vu7ylW+bX+d5W3W0vZAoOol8IVlLKmbfuMiK4tdroA4Cws?=
 =?us-ascii?Q?p7Mp5zr+CckUo2qdx6UYbK5eMdErUj7U5jpbDRGrP/y7cv5DdU2FXyMBeCEH?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a05ccc-b41a-447b-77c1-08de05d4a765
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 19:06:43.3929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix4RUPi1RWl64VRJ6VOXJa7+F3LPv07MfrWWkH7pXe0C/7a+OPUb/IjV0C9z/6XnxsuT+jAezz/88NYQ11yF4r/TKdZoTnklWNeUMAdcS44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5350
X-Mailman-Approved-At: Wed, 08 Oct 2025 01:50:35 +0200
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

Convert device tree property parsing to use dev_read_u32(), which
handles endianness and simplifies the code.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 9a92b8437a6..ead96dc0c91 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -180,10 +180,8 @@ static int sdhci_cdns6_reset_phy_dll(struct sdhci_cdns_plat *plat, bool reset)
 
 int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 mode)
 {
-	DECLARE_GLOBAL_DATA_PTR;
 	struct sdhci_cdns6_phy_cfg *sdhci_cdns6_phy_cfgs;
 	struct sdhci_cdns6_ctrl_cfg *sdhci_cdns6_ctrl_cfgs;
-	const fdt32_t *prop;
 	u32 tmp;
 	int i, ret;
 
@@ -216,19 +214,11 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 		return -EINVAL;
 	}
 
-	for (i = 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++) {
-		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
-				   sdhci_cdns6_phy_cfgs[i].property, NULL);
-		if (prop)
-			sdhci_cdns6_phy_cfgs[i].val = *prop;
-	}
+	for (i = 0; i < SDHCI_CDNS6_PHY_CFG_NUM; i++)
+		dev_read_u32(dev, sdhci_cdns6_phy_cfgs[i].property, &sdhci_cdns6_phy_cfgs[i].val);
 
-	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++) {
-		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
-				   sdhci_cdns6_ctrl_cfgs[i].property, NULL);
-		if (prop)
-			sdhci_cdns6_ctrl_cfgs[i].val = *prop;
-	}
+	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++)
+		dev_read_u32(dev, sdhci_cdns6_ctrl_cfgs[i].property, &sdhci_cdns6_ctrl_cfgs[i].val);
 
 	/* Switch On the DLL Reset */
 	sdhci_cdns6_reset_phy_dll(plat, true);
-- 
2.35.3

