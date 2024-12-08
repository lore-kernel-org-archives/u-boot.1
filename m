Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A16E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879B58975D;
	Sun,  8 Dec 2024 14:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7204B89529; Sun,  8 Dec 2024 10:21:25 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EAA89575
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC8oCQEbkPeYJDcA5gVkUYA3mVUqNsIdg8Ja1MTvX2IAkwPEUJBwmOQyItPUAnzIa6PIlaEKUqYAzQUC9rzWXhJ70SWQxuj3zWeonXxXv/sWl3esRdcgIvnmzuyI2AkCaWf1tCArGnfVkvOPx01YjSxQ42HWW1ZFCqxWGzr7YoDKFB4EB5dJ3Tv3vg0JRrNppzAOyd8LTLs9teFJGNHZEnR3V7P22mZClyxvrgKMuofI0ctxYwNJDaFU6Dd0GD9kvyqmGNkUyhGn93GnSfDl0QKuZzSOVy12zqPRKL62Q1s+/QF7hSmSAlA3SuFKoJbCKoiH4YZnGoX6vrST2ThR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpPejiiLjHxv9Rcx0mbLmTc7fjIK3AHzaReEZeJzXiY=;
 b=MqbZgLt4F2pwRJzC5echomNT0Z/fMJarVQFw5QHx1JUfrXHKzxs/YCnV9czpW1mjIPSrrKdl4txaEJKrZzb7HkBgKdahDQ9BcHx9vEf0ki/kGhAzXsYpQEjPGCElPPx8kTKmHmVd0uHOfGMFOa6uO/VYvfE+il6iZFPd7rnd87sW5VJa4AsxfppYGQTI0W3z99ikCOffHtL4DlkR9mXcvaV2DX0CxRgpT7DydrC0PtJXF/QNRDnr8OenHMFwt55c9SybmQGMBXRBzx0uLDbZwB6MrliFYw68dgkiIek0ByP3hg4QZtIz5s+GaHZvPognUB6Dt4Uw6IBBnkVTKJH5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:46 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:46 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 11/12] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Sun,  8 Dec 2024 17:19:41 +0800
Message-ID: <20241208091942.47298-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: 329d669b-20ec-440f-65a8-08dd1769bce9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: Vwh/pkidnwwmT2GF5pyx68eHMSZJEXXiiGsAlmTd4JPK3Bqh0XlQR5qc3TLDP3nFLl3ICTv/OGRtvW+hTzNZ1L0nO1kNyX5keKs6wGKZg1EQFBZmFvzeZQWI7W+BTg2w67gq5FIDCFQn0wNaSBhmcdsXaa3TKbOm2pJG3xOHxcBc98HDe440XB2RWXoQRav62TxhDZHSiS/VpzdEQpQ2XfrICZP6jrNMNkw2qLEM6+N680Uamk1xZexKTpZe2Lyoo7g+R1plmwTjt4ypXH8Tq9t2XkSCP633CQtJE1zO6vE7XYltTdH6CiOWcSoyaJwZXaxUzmEt6RDj6QX/WGYasmOvkDZ8PfiPpNmpzQgYSSYZ4u7rUIdYmn/fz2yo016ooKtY0mHZTamhiviosOSmozGMHtNxNRcjKhenpN9JV4rXIMumyqvULRkqpSRONwncFhkIf0V8vcMXBPkpoJ+L37DKNqW1EUJaDI6uZ9wqqhjm9wxvpCb4xobCGz7EGcClOMiw5qF72p2WLF08KzdGivt8h4KdoMhRm6cFFd4IuzZrGdfUHBz8g5Ka7Fsi/iNmi1nnXJmhriA/qYP9KLNQePHquMPfXXODItrWFur662DTkr7QVks9sZs3BWqbTPINBmGenAIo/lKSy6pLuUTnrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9ddsaJDiyRhC5BgQvWF0/vkk9IgbiQYnxeYW1JgQWkUBAkRCIQzloZpeyJc?=
 =?us-ascii?Q?Xlss7nSuZfjuxHlWcwGI0qzIpfz9TBo7ocW+61CSf7tNHjHktuFdx790UA1E?=
 =?us-ascii?Q?kCVPHvX0/n6jRIRpOY/BGa48gVnkcjUqlE0V3sLR4xAgmMD1wqnZVv59Uou4?=
 =?us-ascii?Q?koRqSVFUQo8L8EOmZgnc7J34QNDzyBrG+XCbNVXAtMeSUyxoZwY0WW9L77cg?=
 =?us-ascii?Q?1dhzqpCtkNoF7Jn5/kfT2JrpxSMmpeBM8Gknd6ccKJdmBRDU2hkP6A0EDYUh?=
 =?us-ascii?Q?UDSJId0wBRD/hWGdAS1xnHLK88XfyhU8rniAwbmR43R+yohocKXj0zWlLtV5?=
 =?us-ascii?Q?WjU4FgGhIpgG6ogm1vMRg15FCwucSH9yOXQnjgjLcmbluaanyWTuPzR45A6m?=
 =?us-ascii?Q?/fDvlsMHxZzNP7Rz/EaqXbHMRgTCjMcJJrLAcDfbmaIcey1No7llc6NT7phm?=
 =?us-ascii?Q?Fd9BdMcIvchvxw6Az3RQ+0vGPbMMg3w61TgQlhRtg9fsj4ZFZsD5Oh+png1b?=
 =?us-ascii?Q?xd4NnrscCeFmnmqESJKTU9M4mnKNSytTGAV0AUpDX8vX0LD0LCtwvvM9ZPXT?=
 =?us-ascii?Q?zFrIwRIBt75lj7ap/FvHqyasj29226FxuC+YzQVGSMl6AR6lM9gy6KwiY3lm?=
 =?us-ascii?Q?ZTPV66xCorz75w6jSaRP1ypCP691JB2MPt0BiIw8j6SfbwmI+yWTFlssWdcy?=
 =?us-ascii?Q?EjW2mlV5BB9hPCD7YUWaDCkyIJ5Z9RbWrd2ICaui8ZgCBvhEx3BndFY9cc7W?=
 =?us-ascii?Q?qost8cbvl8odTwcoVjnWCCMHMwdOnPTI+NuMPBqW7l9ZIHZNT50sAA8F25rW?=
 =?us-ascii?Q?GCFlF/9ReP74RLyRJs8MGprgn4VRcB6NDXLJAh1+wa3zoix8rx/A0W9YsbyX?=
 =?us-ascii?Q?LVJnpMcwYAQkoHu1p6VIXI1caXhsfy1Y58yYqt5tId4irsIcp2O7xSpY8Kse?=
 =?us-ascii?Q?dbxsSWD0DOtxrAdi7Ytxa/8p2IOb2gh+GGOrIU9DIV6H8zqkPsA5aHR8zLkR?=
 =?us-ascii?Q?cK+00OGq1S1czekZE/K9vybXu0OgEoS+Uik1qU8IkijYFMAnPBPyUnPV59vC?=
 =?us-ascii?Q?oVYRANsXwqw4skeAUOGPlRseTn2QOmIUKjW8uFoL8m1rnYoYoBL96o1wrA0G?=
 =?us-ascii?Q?Bc03Vsr24/pYdXHFm6yU9+FP2wQTE9VKD9/FECWFiyKKenhsTd4X9FUpkdYJ?=
 =?us-ascii?Q?Fp+iBGqW7wIzeL1ZwOb8VYffeSfbid5M77vos7KwGvRRxrEPgxjxOEcmaRfT?=
 =?us-ascii?Q?CLFHwUeQTRV6KNMItM3f+OncjybthVhVrPItLtgoCvYYeRMDUXQmjX09G5hq?=
 =?us-ascii?Q?cMEpqPwUjg0X/m578y2H+SJbTBWbZnAWI7ybhO+GfviRv8GWHJKRRxq20SIH?=
 =?us-ascii?Q?eAlI7PnJRU9toShCdYDlshay0rOdD0PoXZrYWkoBrCYoLARpVOiXGQbHsDVW?=
 =?us-ascii?Q?/Qz9It3ByXIhmSi4ziQZRIQ8ipgN6CrTRcrEJRegezB1nuCGCDapfHeGGfR+?=
 =?us-ascii?Q?nDOEvg7NAZPs3o56OkM54uNzBHbUlqga8NRWLrLhQysPcAs2dLtnvSQx7dkS?=
 =?us-ascii?Q?/iGhJt2uGKoVHIhoZJspTIXEiEJ252L/Ms4y0VCHzKSkgRm9JpOsn6XIuiFp?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329d669b-20ec-440f-65a8-08dd1769bce9
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:46.5930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zxKE1qsqhOiRFdn0MwvYqZF3iyp/k4dVJLXaoyBYjGwObXIsQ89cSyMuHGdjq+kLeoL/0MWRaOX45LMfts4ijIczCEw+B8A6WvcmZf/Cg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

Get product ID and the other information from EEPROM, use them to select
the correct DTB.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..22afd76c6b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,36 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	} else if (!strncmp(product_id, "MARC", 4)) {
+		if (!get_mmc_size_from_eeprom()) {
+			if (!strcmp(name, "jh7110-milkv-mars-cm-lite"))
+				return 0;
+		} else {
+			if (!strcmp(name, "jh7110-milkv-mars-cm"))
+				return 0;
+		}
+	} else if (!strncmp(product_id, "STAR64", 6) &&
+		   !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2

