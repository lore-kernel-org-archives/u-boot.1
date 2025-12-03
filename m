Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6D8D12D56
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD9F83F95;
	Wed,  3 Dec 2025 13:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Mffn3rI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8296383F95; Wed,  3 Dec 2025 13:22:36 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7520083F95
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Km2nuMMZqhMfzVlYfz1eoeM8UuUXH+q5dcwLDjsMxolg1HTqVK7dZ1EhvNIky5rXYNRz+68jOuQp1onSH1Dbp0sX2cM7Xl4YVk6TMnbToTYvAkgUrlcRHioX0XmGDtwP2WGfeCYVKtYCePiof9OwzxsGURaDuL7cO+BYHjp5NneBP2aic2aBRVXEjV3MvAETrUbyY2c4hgSFMN7km+PYt8+OsRqfV24zFBT4PmO4eGnXx4FaNWUlGeLdTkP5INNZyVOQH4zvEU6SwAP9lUECCI3nKHqQxg5lmjWo972Nlo+MsT7NZpD8hw70ync/N6vsFRVmMfM/nTuNVNX4VHB22A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhHwrV8V87gNgegKdypRqSMa+Ungvf8iWVDcYbRUFmM=;
 b=TG8bPXxvh7G7N4uT0cSzWyYq5VFUBiufbIlmwAbYScxusKgomyzf+PNwPqolohW7LajqwqF8Xrnkog1ITSQZZKqM72dUSWbb5hUowrWh5U325/FApqArN0k/gvL1mOmNa3wAxwoKFBJtPgouFLVgjEY7oLfd3qjliPbanOei7gZvz5a2nCV6BGBwdMEcSePAdvNHIqfwYDjyklm6XYlD+KXQMWRgoqEaGF355ruGBYxCjakSik/DiSFSQBmYZdEYrBt04aSv0MlAAJZDqjufme990Nu8l2z7ERt1oRgtbmoYouy+j/0KAFeyg2/ZVEu7sbdE/PF4ZBOSLAEDOd7Xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhHwrV8V87gNgegKdypRqSMa+Ungvf8iWVDcYbRUFmM=;
 b=Mffn3rI5caVL7xZnAB9WHkVNaufRiEIZLVHHXAWKbkSDq6I3tC8WMuBeSP1AVmI5JmIrDvyuCD7hZUh+XbXu11ybXk9g6SvNCrZSEbFiLF8CEICjYW8xhapoMN/Pptu6Ab6c8Qi9wiW5hjSYBh2q6NGXkfr6y2NjYSvdxWm2ElHP1XN5us5dJItctkBbyWQklVGvOQXRd4/jgGcvq18Yg7kQOGA5wOCIQsuTRIqHl4kaKgq4/FeAA2Jn+VhOVLfnPMz2loqLVjzZLPuKiJvIWVGcc4k0hguVr9wSoMnpDxIM6GpXJcEng5cj9PXeWE3TZicqGNNgFb4f61bhofglUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:31 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:31 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 6/9] mmc: sdhci-cadence: Use hardware version field for
 Cadence SDHCI controller
Date: Wed,  3 Dec 2025 04:21:36 -0800
Message-Id: <9234bbbac9c03069e8f61178d93dee9f04a8c395.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ce11cd-765e-437f-be55-08de3266a193
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PvZ5/7YUbSIFurkjQIZDTBMfAPTdjwhucFKdC4HmffmTUISxSnq0n7tSVK+U?=
 =?us-ascii?Q?SmlabjwvyE842zYEcnNAchXpQ99YthXCo2wnuv+zvdsil2SepwYwFdxvyUYd?=
 =?us-ascii?Q?ZTqfvuREew9MjfIc9kyNpxzILshhHPWBskvPVYnxxm+cv1LiOsNJN1Has28T?=
 =?us-ascii?Q?oGPoYvMm4Eegy7hUKFoYSmQofv8c1sE4ESOj29psJzmReMRyt/Bs6B09GeQu?=
 =?us-ascii?Q?QGyWcHh0pnklangp9W5hOjapPPg7THCu3Ryd7rthFg+aBG8dmYwp5VLV3ZMv?=
 =?us-ascii?Q?ayKYMOgBv9uLbceFEBcsIb35cbZGM2WV0oVqiLSB9EQW7V+yppryCTV5ZcyI?=
 =?us-ascii?Q?Z26mg0NmPoTGGOGL4dbnUsvRBXuIHQ5rmHDrd8lNKQP23ldBuUVvpgyKtaKS?=
 =?us-ascii?Q?wxjAocyyIMRQ34xU9CDpfHInLwm76uoTBmu/yVGTnVGLI2pUIzTos+vJb3zj?=
 =?us-ascii?Q?xkbJPLEIml+oxOeBubuIVRbaNNv3PipQsObnH/zdMMEiKA4Bhax0124YW7YQ?=
 =?us-ascii?Q?dJvwiESq8VCKh3SLGe2OvZZ5alf94ii+7kIfoCtVHaElRByi9pOS2hGyNZXs?=
 =?us-ascii?Q?f7vMC8I4iCgik41OHzaKQUUF9+ae4HjrK3mbYoTbsuTvYiGzzzZqloq9vBzB?=
 =?us-ascii?Q?fy6jhRODzC2Muu+lkHHtjYf0+8Ap8LgLPD5gn3c4qkDNIWSsGztl85OnxojE?=
 =?us-ascii?Q?pqIHhIo6Rh9EjTKjgve7L5FOKqYI2gzN4MinwIz3lGYJqbsFEMuatS8D78uP?=
 =?us-ascii?Q?om0Ml+PLjcTHUwyL/ERknH2bw9A3e+jDGv3WwOHzFndKaSEQfokefNHbeDqy?=
 =?us-ascii?Q?Ib32iJ4IQTeKj+19ClPzVHgb39fwFjTKplfN1Nhcr3vTv+hDXS5QO/RDbkDh?=
 =?us-ascii?Q?JI+JHVQ3hVixAzS8D70kdxgXycTtOI/Z2Q6GooZC2tJb9ZhDPnQae26pLoaY?=
 =?us-ascii?Q?29sixcmMwzQG+mqucF6PL+Xvk+KTK0EtocXIvjamy9QA9TIbB3M11jyqG0Q4?=
 =?us-ascii?Q?dm35oRBE6ZncaONL3mO9dJpFCGZfTVN7krDcEi3cyzHoeNUQND47PyQAZ6m5?=
 =?us-ascii?Q?ZC0YwuOxpyksKVbHzHYeEdTbb8DBCgKr5or2rkRuS/ZYbYV1FAmG7EYXl1VY?=
 =?us-ascii?Q?ewWdYhy1F3MEgLLG+QOHDLw6SHnnE8NgJA3qGkNpn8BkK2poBtmlS3w43V7X?=
 =?us-ascii?Q?wKiN/jxDj9ve1d1bUeQoQZl6uWzPvZjRA7pefTr5kjoOngaVF7f5o6JSQiyH?=
 =?us-ascii?Q?mXOGaVBnT27WB86qzdHpRTRFGOeV9ht1ywP1otKUfe8Ycu0HOFZpDvNpInSS?=
 =?us-ascii?Q?WJ6t0aidDX9LQwZtu/+1XFUKvsggQ2Z6mwPvZiBkvVceOzGQOISfHE08wuzj?=
 =?us-ascii?Q?jjbkUITJvRXVmH34aDKhK/mbs55NXS0QUXHha8Dq1yZ5yKCiC9hqZTqzDXsT?=
 =?us-ascii?Q?ssfhWU3zzwxQOVthDgvi9pRxnWO8j/3V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GtSq4eyig/D5zQNaVMU9mZSjJ8RDi9uN1u9hPVtJnxcL0Q+etDUWlMTA153p?=
 =?us-ascii?Q?3BkUn1kpcaExioL9f7A+e4U0vJ+qRtiL9buKQ8ipjaVvv63sXU2e6/LVRYp0?=
 =?us-ascii?Q?nJUGi99kGrqyob1YEIn2k0BqNX4PyYYxsXDl+S1nAs9K79FTZCufMmFUMtUR?=
 =?us-ascii?Q?z4MVE+C21cCNqLE7OaRG+XgEpqMZ4ogoogZ9Vfn2rZqyA8WTLJ4avKng3JFn?=
 =?us-ascii?Q?zowF+U2nYSVlz7x4ArtQRHqq/jIk97JWGsjLLlJSIox+854pKJ/uPLg6PGmk?=
 =?us-ascii?Q?uvFB2P5p3ixVZ5i1bkvjPgpbdo7HBUINdB0acHbQPZARhhs3oXd7sEHzPswR?=
 =?us-ascii?Q?24D0WNxIICIN2KmemBINQe0uZtIPthIcQRPkHg8DdUpPrnIOz2MB0LEMCyCw?=
 =?us-ascii?Q?7PDHffRhYakoFDzv/qb/+Obuja/CH3k+sUOKx95p93iAyM/UI9/WmuxihuWx?=
 =?us-ascii?Q?pdwwhll8fVHviSPg9RPJ8lSlobryI0v7lDZwxbGD6OTzLQDI/pSkZyHtkcBE?=
 =?us-ascii?Q?VLECscsX//j8DjEBXd6lplk6xJ3NcfB6WP1b2J4E5XibBiLJwqgrTyqMWRUY?=
 =?us-ascii?Q?yBtHVmE1EEaRa+b3m7anoaKN3qAR/Uo3Jqgcdcd7UahPtcDh+lEVIiGTv2Rv?=
 =?us-ascii?Q?x0IjMQIHQS+G9ByEKIxXDAWY69pe2gLe53MOpGXkLA0a2XInZGtpvSJsPymH?=
 =?us-ascii?Q?Fcm3JAZDHcE9+4SkXj8Xs3F9y3B/Z/6uOmAvgXUowY5FYe4v3P9P+ERI96lq?=
 =?us-ascii?Q?q8FSxXS0M/4VG3j8X3+Mh7CuzSdB3ukQCWPYkxznvoBYmUVbHEHXpGFgt+GT?=
 =?us-ascii?Q?/GTXQu4YPotUE9AlPDftyRjaSN9RT0vqEKZ+jxTnhG2Aj2alX5fqvFSFJ2Vb?=
 =?us-ascii?Q?ziDZ8LmzIneq57x+dyJx40MZ80FflPV43KMwqIYxCrIsILC+3cpsqMIF07ep?=
 =?us-ascii?Q?iJXU8Ysr49fxHqSf0BrOI8s06dRWTZwFS5SzVK1S+TgK/A5gMPc+KYFYv9vh?=
 =?us-ascii?Q?c9TizhUvLQDKVUrpNib3orbnujdfNKevYTx//GIdi8QrG8MuqJa3N7d6T+te?=
 =?us-ascii?Q?1LPo0qUFhHC9WhAQ2J3fhU4rXw5n02sEhZl/RrctKUQnzVq9vSv2faqbLIf6?=
 =?us-ascii?Q?P8RPmrhqA8flxqnONcM//N8i18ntmCLMqaZCes4L0/WUWtiIK+tP38yxRBZq?=
 =?us-ascii?Q?ZXQL+DFbPqFgYNQWdDF3B1Mywrhsabd142p1QEBdamuUKUOl5GN/Ui5y9utl?=
 =?us-ascii?Q?QqIS6S/+E96gYzg7ADWNAuqtFbdLP+XinUpAhvaec8yphylt4Ux7+MOsz31m?=
 =?us-ascii?Q?kMIPkApllOsCOIclmaPJsgQgh9fk0RH1gDRpGn0QSJU8XThpVqmaA8yR5pu4?=
 =?us-ascii?Q?+bCGMH/hp1f1e9q8MEVa3vtL6vnoeQpOPd1gZu18I0oZEE8fPEqH6u0BbhIF?=
 =?us-ascii?Q?iSfdBVpIvBaGrinAV3+pjzTt06SwN5QDPvmNC3lBsirY5TgXg3BkAJ0alCtC?=
 =?us-ascii?Q?3HJeVMaomSh6X1qwe4Z1M1Rbf5C65qmX8fczO1fhIXTHBrU4XdYnC9yrJy/7?=
 =?us-ascii?Q?yAFyGmT7W2KfEgFEeWlwJTpaDSaQfHYEA5ctKYCcnncgjpE3LTcPzIRq8Hf8?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ce11cd-765e-437f-be55-08de3266a193
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:31.3167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ii01NL6qqNXjPM9SINgYbckQaORIKT2hs5zL06Al+QYR84SWJhWBqPXGHa32WMKdrLIRPyHDzasYwJ42ab0+sUKubxTVfsTY3TZX9csEBDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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
index 5e2a4037605..a0b9434e4f0 100644
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

