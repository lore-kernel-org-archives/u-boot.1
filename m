Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B465D12D55
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CAB83F85;
	Wed,  3 Dec 2025 13:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wY5osxxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747E883FA2; Wed,  3 Dec 2025 13:22:32 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F20583F89
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xV1bt2YmvxDzDNqQhB6fTgWrKzgMtSJMrpWtIQfyH6MWOEW4EgGyK2ShGh4xOezkbodKyy9vhX4HMxTuTu9YFhELs9g/A0WvwkyOZNrULPEFdlZZgiPC9tEq3e3GRnN5Lz5A/Um9h6XJQiE/iZihUH6lyj+epoqsfQ6bx+1iEilH0a+RQjhNFGoB+dGJTw8Hc4Cmo0I9SqY6XcOPJyfiV8574lu06xazbyoBF4O25ED3eCL+vt71voVHm7B+FWPPQFXQET5aIg1LrTun7kP2uJ3RYcPxO5NyhDiQjqbYkeDXBAAFm4KYpgdnmMrzMs2e4nKL99uwhj1tIqRvqdying==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xROAtUyMm7dSfFuRRGXAXRZyhDj58/0K4IK3d0ggjV4=;
 b=lOqXG2vqg9DxfL1sakpWy4LXfwbQQiL4rxjzLOmJh+q1THFMi09WaOzNpNAmY1iaB3pxHLPQHeqT190uoCc8yKSbUi9iawI/LvTa7Wi/uJKqf3ljKNAoDFxAYeskvY7CxBcRg490XEaRNPNX/0WqncxjUqOh++S+Tw9XDnX9syXRCK7XEe0EkxKOO+uhTM5STDuk4APnHub+j7JHllBHLJXi/p9gYBoiuKChumXCsvoETplvSViQVnH0jcLqelgIIH6rWC9BkdZW+T/Wqr9s2CNArA09A2Nic1OmGUHIpUnPz6sb9MqUwrnkmH5nnvUQ54WcUKDHbAfoUma+z8JyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xROAtUyMm7dSfFuRRGXAXRZyhDj58/0K4IK3d0ggjV4=;
 b=wY5osxxCjzndvuiq9dujHZmgEJv33NWwpT2AiV23fm1WDsHFk/UzYdnf8Xwz1AMDz3ZK17h9fsl10o2wR2eHVRxEJM7bOLGReDVZ42FyRayQ1AQ8A4sc6NC+56UYRYppcgoAwWoAAU9x/607zjpTqroJ9O2U1uSST66kzG6w0jw8CzHew6TM17+gNGBDfM7GbhWIbeTmfjYppDBjqL3uQCIpu7SQ+XQBN5GsBpkWS8p28mgM7k38y/PSjkizMRlYgKfWBizyQnvPxMUtNIx6DtiMrSWbkXKWCAORQSA8iRsS5ZCGWa9CNSJQfBu0YELatdTVUfIsfkh02RG4cFsjqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:27 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:27 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 1/9] mmc: sdhci-cadence: Add reset control support
Date: Wed,  3 Dec 2025 04:21:31 -0800
Message-Id: <8bcab0e7b389d65f54746202c28a22a279a4691d.1764760325.git.tanmay.kathpalia@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98c0cc11-93d6-423f-2252-08de32669f41
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1cwrk60mjhwhB3aUBGKBOVewLM/kGxsRcAibmnoQpbBDfPpDllUvQx1BoM9K?=
 =?us-ascii?Q?D7N1kxvsuwZ/kQqv3ZW5vnmAuGb8xyA8W1KWtVzalHQOWcO/tgCdv+b01vN1?=
 =?us-ascii?Q?ZW2oc3bq4N4bBREY7N/xnCp9kKYSvZBaOxsfOeC+x7G+PhQKeousMo7s48Ee?=
 =?us-ascii?Q?n8unZm5UFrNngkJnFP/Dy0e6CcCPG+qUQQvRYtwCsS1n2qgvCLe/qDjVxJzK?=
 =?us-ascii?Q?pQagEidHNB4irrUX/ocI4nreLsmihGRX9kJDP7VRw4TE7zFhs4K2OwGcFGup?=
 =?us-ascii?Q?naTnsvzdxdk2VvFfYycGzImJO7WkCvSzZ1/t7+Cq2+rNgp5DvAvOERKQStZw?=
 =?us-ascii?Q?//YXowOopH+5c1HKvoVAwZUO/18kHF9ZU5l2uvqGuZLH8BuL41hSjRzYo0SD?=
 =?us-ascii?Q?63i37U+wmOQkOyLDk8hS9QyTTuPZvAfv3TlIpdleV2PH495DBwhqFTbIasYf?=
 =?us-ascii?Q?UB/jwvLjiNTq4rurr/ZGWHlJK3QeV8fqkJlMhHxTMffUP5b8lJO5SmNPJzuQ?=
 =?us-ascii?Q?53U8KAshMrZMx9H14N3/aRYI6UAjmcLnOGKi5eBQuEG5EnZ1bazAG+crSCLR?=
 =?us-ascii?Q?FpPq1aXbVaEMYvE5wYOnD1PNMXYO7zp1jqvjqMLNq6ZOHKnkMF/Z65iGqf+U?=
 =?us-ascii?Q?Q6IPKy3Yrg2XCsP+ieEnVS+4rbT7wh1JMRqPN8N7+ZFOSiLSI5rT9grLFAlE?=
 =?us-ascii?Q?3jzd2nR/8WbelIqHbyHeVCrDgNSoJQ4PLhUm/QJbBVi1xXHzfuKCSuubrR6T?=
 =?us-ascii?Q?dHR3RWH/KPD1GoNHmnE8wErhHaDSInV8ujgrJrqyROYr6U5T9X30jJjHMUdE?=
 =?us-ascii?Q?Sj+v+R0zCJUbVHFkNA+L8c812O/HcC0kxB1oAgiZyPdaD+szORjpuQ3GHKU1?=
 =?us-ascii?Q?WG9m+Qh6Fx6MVVbfLpkYEU/zGofJ+dgdW5fpPbHvYWeLRg+AH5NtRbtPvmyZ?=
 =?us-ascii?Q?ma+CIGwkk8BXTObIlBWlPTjVXNZFHQTxvX3rjHjOJ3e4fCG2v0GOCcrDb7NQ?=
 =?us-ascii?Q?k4DJVCoYDvqSgvAKYufAZOEGimdkczc4dPdGZXYK/SUo+3MJj8fTGMvUloLy?=
 =?us-ascii?Q?HUd7FbUy59zmn1C9l7oFHoWGZm9HAXW38PcwKVhCIhlKbyWZsJc5M8eaK2zW?=
 =?us-ascii?Q?BwbXDDXffW+VwCr7VzDlO0iKkhEqvzQ6XTW+nt4ODRjQ0/PwkUHQj4+E0nww?=
 =?us-ascii?Q?tpmJk8VaacOpZr8DLAoPc08nsV1Jmltmp7LNF5tbgnrMS1d169Yb7+RZAEUS?=
 =?us-ascii?Q?O4lH0rYxHy60g7WRfAVl09B9G7AkzmthaugVYo7WWQQZ4VinltMpLrHx434G?=
 =?us-ascii?Q?oz/q7FqvlKO62lTbig8YrfbqqB8K1SwSR0vJMlGbCaI4RL8BQ2ozyjqsRpQz?=
 =?us-ascii?Q?lpsNOwH4GKV5FdIZYArkxxJg3DVmM8aMyWeEwtvlfGqnb615EWiElxsVBBdK?=
 =?us-ascii?Q?S3kLt95swmy2EUWxjdIB35FCiVjIzbhh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r47nYBhpmOPTEGENrjgkVwR4KMQVlms87UucW1A3NaKD0Xb6aq6vPlY8znWR?=
 =?us-ascii?Q?5f3Lb3RsKB2vf8rH2X3nralhAjWEoA5r76iWcXwDnJxlCYRYSVB2XtQ+zjLQ?=
 =?us-ascii?Q?D2m2UHLjFeRHKhTQP2U9F/0XAHVO1FI5agFJR34cauwi383Ifhn89fmFOJZp?=
 =?us-ascii?Q?Qd4daVFzgKwWROCxvX7i4buM+6C6h5fJPJCOnMHsmEmeRqmVwQVryKAShDna?=
 =?us-ascii?Q?iGaNTowSrYDZTcPunKSFolJnsr7ap9nT4qV/9GhI1UaCHI3n6KsDmyiQJYaX?=
 =?us-ascii?Q?XXba3hek28Dky+T41kApmYoqLY5LrXtpAVUcDp1glcuNKP60+XDciM9YJc25?=
 =?us-ascii?Q?FGGw4kFy02+j437bj/R+Q694xj6VJ81q7tPD6mqHlT0W0Smra2MDsaMzyrHL?=
 =?us-ascii?Q?ytO/K5/Gq6U3zoNYIadj8ZkFFG9rHM6HyjWtilEQe381x45S2n5h1L7dSgxX?=
 =?us-ascii?Q?v9qqAk2GnMa52UYN1IAjrcmetZ82K9dJ/dNQ2IoZc4zY+jUuDLcxOLedzbIn?=
 =?us-ascii?Q?u+TEWOZyVWOSEENwLqfCfhHYDjb8CZAlAAmm8eQOiOI0rGtDmK3UCYpslaO6?=
 =?us-ascii?Q?Eis6ioaqvD/UBbWN2DwgQp4/X/YntfAXIPvYKovT1viu/avo3gw6Hcbljxo1?=
 =?us-ascii?Q?v0tzEc0oTxyGz3VV+M0AbLBtqYBO6VxvlPf3m6Ags+Z0Xhtc2V5rJNLnWJZL?=
 =?us-ascii?Q?vx9kx9wa5uYkiAYAZ+g16clmmuvjyjSgpzT5Z2de43ROjpOENFCmZhEO3dL3?=
 =?us-ascii?Q?6/Zb9yiO/YrQGSWLIouDojEwxF7vgMNCcEQP158LElulodaxFcq6vqDZ+9KH?=
 =?us-ascii?Q?PFjOgqKegClM9tlDXr6EzCk9T0yEZLER4lt0zIRVSnIvVR7fvyACUs/fLwDu?=
 =?us-ascii?Q?LkVEm9dmM7G4QFfNXoknn7+IsMmMvF44GEDOyddq+0E5sC7z/bDa6fajVeCu?=
 =?us-ascii?Q?NBOXYk0OneDlb2Bl9gK4haePLIuDEyETJz472VBgQ5Ai7XXaAIfWaajO9x9T?=
 =?us-ascii?Q?cvVu65PeEEHlAnBqvDzdooMVNrWWj0IFSmUG7BvNqb2Y4/mIDp+ohhjuHfvh?=
 =?us-ascii?Q?fWE3lFXt8keqn7JeAY+jkg85cpVvy99XSqlE/BkNbfGL4mi9reW3HBwpq/Z0?=
 =?us-ascii?Q?zIamF/uncWbusJgghO6hTEmTHRQNNe17KPB94BDpxqN4DhHkYt4UOUaKimRb?=
 =?us-ascii?Q?JIFBg692hrsBSLnp8Lgqq6EZ5CVSojVmSZF4AVz03xAFaFW7tJeb90Mr1CAP?=
 =?us-ascii?Q?8pR6nLj9w7DVqKa3sLSASATr0w5BetPV8Q5I7UGRl4LwGlXoQU3VgA9PGp6t?=
 =?us-ascii?Q?lgIofkNsL67qoLDM7a9tiI+ezFTaoJIW9GBpiuAU6pVrAQniQfSKcfwwEwio?=
 =?us-ascii?Q?nkMGBzy9/G7KpxlIfNFEOzt9dcsAFIY6l7qN18hTVrN9J13zc2u9VvA5QVkS?=
 =?us-ascii?Q?aUmsFuofJ/r+CPs3iRIjgEMw21vDKwEmfpTlCQmkjC8pVFM6ei3rt46nM7Sk?=
 =?us-ascii?Q?VyBsVJx3DQoyp3lm0sxcrT4ThahMkfg9O2ENIif214EDlCfv+6iCoqOWjjY4?=
 =?us-ascii?Q?y3VIXWw+ar2UWKfoWoS5xkmO0r7lCx5AT8MSOG4WC6DIig7UXhRSUwu3XrLO?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c0cc11-93d6-423f-2252-08de32669f41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:27.4843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+Y1sKNbUPlN/IqOkHRYqsiApHVUxP8BhjYvTCGK63A72UJKk9zESK299lNHW2HGerFWVKUZbwXPsVA6tLari++QCdhgdFTjlHxbnHm+IQ8=
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

Add reset control functionality to the SDHCI Cadence driver to properly
handle hardware reset sequences during probe. This ensures the controller
is in a known state before initialization.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index 7d169efa476..6c9d24fe5f7 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -15,6 +15,7 @@
 #include <linux/sizes.h>
 #include <linux/libfdt.h>
 #include <mmc.h>
+#include <reset.h>
 #include <sdhci.h>
 #include "sdhci-cadence.h"
 
@@ -214,6 +215,7 @@ static int sdhci_cdns_probe(struct udevice *dev)
 	struct mmc_uclass_priv *upriv = dev_get_uclass_priv(dev);
 	struct sdhci_cdns_plat *plat = dev_get_plat(dev);
 	struct sdhci_host *host = dev_get_priv(dev);
+	struct reset_ctl_bulk reset_bulk;
 	fdt_addr_t base;
 	int ret;
 
@@ -225,6 +227,10 @@ static int sdhci_cdns_probe(struct udevice *dev)
 	if (!plat->hrs_addr)
 		return -ENOMEM;
 
+	ret = reset_get_bulk(dev, &reset_bulk);
+	if (!ret)
+		reset_deassert_bulk(&reset_bulk);
+
 	host->name = dev->name;
 	host->ioaddr = plat->hrs_addr + SDHCI_CDNS_SRS_BASE;
 	host->ops = &sdhci_cdns_ops;
-- 
2.43.7

