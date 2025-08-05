Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42760C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7998418A;
	Tue,  5 Aug 2025 10:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="vmldK11T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBC998304F; Tue,  5 Aug 2025 10:15:37 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2DBA84141
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkseW6A7orxuGkGvwYiikp3L6to6ZD/swlZgS/jggt0ByRrcjkZPOrLDS//DiCnL66T833uYakTcNkjCMK/jCmfEni8UB1d3pTF0yRXImdBXF5foK/Vwwq3Z2EZDd4KtlK2aOEe6V1h0bW6bfAhjPnUIV0YZ17MEZNciZlNFUTkMBTKdAf6kUdnOUg81kuN68wUnvjLbHy/2KDRt+crd/AQXPAbk5i+EaXYyBVgSvu2I8huenHuW1liS8NVPKn2YoerUel6EqFPP8WA0DJiq37SyS+BpUegJrfLdbuyAVbVcVKygBWUTYLyQTSSTAxe4a5vkiXbQdaK4Ko/9BbqCMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzcMIxZH+ebNqKSrXYejLB7qyOukoG/F0hG7xjqh7CQ=;
 b=TMZLIu43ABgHmx4D9OCSuf6ad7IyR1Sr3MtQBZy68sINYh8PbN+4ITdXkDHBzXw8n+YI3SOUsH1/XX3+lF93Z3PglFxb1cuep+qxsgAdSZ2Ui0ONUrcuLBWgppBoqtU6nQZiqBimmWBtFwWF9wQbDf2q46r2M1bcBh2QFepR0zg0w6wFTSIMoDOIKqiRCuZJlWezn+pZB1qvPB1lvrBd2sqTxXmX4HsSQn87Bya4ORmefg3o0XOXlkDCSlEgdjIxhBH79r34sWkRBWYZflW5/FwxKjIwt6oF3tEKsmWCgC8SKZFVOy4qA+x3tMgV3V4No0HVWobcsgC+DZgNC4lUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzcMIxZH+ebNqKSrXYejLB7qyOukoG/F0hG7xjqh7CQ=;
 b=vmldK11TWMEq/LZi+LSzGU5EVJNRKdmFlmHnN/EJhAdhQ2nnpH2BJGx+CCXsuNnjUbSixR0dLe/2PII9fkYwILLU3qYlIm8uqYgW0EHhbsczEWIBi148QH2SnO/Vkc0GoN4rI3jUYzpDLQLTLFij7er06ksn4+FmsNW2/uFN5AqpWh0ziaBl24v7bC0kFPE/WzUXqXigfWQFqxgkpmTlOXUqFywZibYZpzuuL1jsqR3tVbbaOuZ/4XPFfXtyFge6bzFY/4PcLd37M5hgbdiD1vhyO3yGy3I0/KWOzRWLV7DBVjkTMGM6G6TwKCJh7KChNSLSJeQs4GjPgaAOK2ii0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 04/22] mtd: spinand: add missing MODULE_DEVICE_TABLE()
Date: Tue,  5 Aug 2025 11:14:53 +0300
Message-ID: <20250805081511.1482964-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250805081511.1482964-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0902CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:15::48) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bb3195-66c1-4c7f-a166-08ddd3f83adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ufZHKkwiXFxCP5HI5j8Srx2uDNk9wVDRtC3Hnrg/hISdxtp2U2p2149MXL39?=
 =?us-ascii?Q?A9lbt11eUd09gJGXrRmOLX6KebyLkEYlEshzFwBXEoRBKY6+StLTXCr4f79Q?=
 =?us-ascii?Q?etUW0TSudVVZMsj+TPxB0NtTMZtv48hkGwiM9Xz4WV8peC3KKFjUg7pquMEK?=
 =?us-ascii?Q?I95xMc3iBkJNgJeQfPsV0dMPl2CYTgr0zIUEmFzTfjI8Ql8s7s5+QAHf6bFo?=
 =?us-ascii?Q?ba1oLxjNlglH2AMIktEr8X9RNU/iavPoW/8FqV0RJz0zslRLD9v2C8e9prj6?=
 =?us-ascii?Q?6EFTsORn4KwA6o3RpNpoVx+rMJJJyjZ0BdbGF3vI8rfAGrYEDypKPrUr4lLE?=
 =?us-ascii?Q?fVmxEIS+31gfS26jGJgQ/LJ2cQVPmm0puXX50YAIVcBDr+HH/G9NPfY3gsDq?=
 =?us-ascii?Q?GOS5RxKqjCdckzoUfc0N8i29u1pzOGZ3GE+155Uj+q2xoj6wSfUf+UoTgbrA?=
 =?us-ascii?Q?A1hecmbkiBvmwVQpv1GKvY+QvkjlkXPhmuErLkGt3hkyXq4ccXKWVoFLLNlE?=
 =?us-ascii?Q?tfqW/lhhKbNad7Ypwi0z6JWymvIDHtJ/SDs4h5uLfDCCN3QmeWyoB5pyM3l8?=
 =?us-ascii?Q?asSjEcHYf45wRzv6kKE/O1MQKmZIN874lJ1mvjEUsf7liOjUKF5QgpjVlnbf?=
 =?us-ascii?Q?akj648wjIxpbrTmKLt+u+v8EOGWAYhNUVGFdBAx9lt5S4XnJ/jZQ6dJq0/2x?=
 =?us-ascii?Q?MMHrYmxZiAGQ8OJlse5JoByK1M6iyBPqR57WuvFwJeg2lAn0OLhjwSAjWt6u?=
 =?us-ascii?Q?kzLmQuSsvyQKULr7XTIQYUAQ0k6FXscYdzYdkkndsFJLHObqaoo1dyAC+mVa?=
 =?us-ascii?Q?//pt9d1xOvW9Q1OblZOzD+dNfSyl7khwDuPBAzzrC6pBgPDGpsLQn7LVdKzV?=
 =?us-ascii?Q?27k1lhoUFn4b8e8D93NVp/5k5l/LZJb7HuP0teqRx0dePkgGTFXqOZ93YPMf?=
 =?us-ascii?Q?JgSd0VDefxjjVQlVwCkPxmrOVIafMYZQpKAlRONxTRdI318XPV4bDz5uA3G9?=
 =?us-ascii?Q?TRXMEUT86tg+t5l1F2+u6VCMxW5OTsyBVZ5zI+aTWBHwMRaKYRMtCT2VI/dx?=
 =?us-ascii?Q?uNwQkQNymb7FiprtbUp94bk9lWuGsW0n/1yeP3PAMno84r2fiC0/eGluSfEp?=
 =?us-ascii?Q?KLgFVWXzGyZOnDC/socnNjUgZvbxrt+JFWHQlAHEYFWqSYDLtqIWQHAEPdS/?=
 =?us-ascii?Q?IH/wHvq6IgAoDYjgEs/vl6+3KPAEXI0ppmAy/Etm112O6oAr4h045pol8xO4?=
 =?us-ascii?Q?nSm3nzyWQ5j1u0+Q+5kUAWM9fRsoye76Nu4IZVgujiXHvl/XGMot2YAQW++I?=
 =?us-ascii?Q?nOZUcUnEak5n19rw01SUuhqdwj/GoY0JvvzOKafSDKlEXo5HAxQt2IyhXK40?=
 =?us-ascii?Q?fY9FdQFoJRenMbJgGZZ9dUkDRdop/AEH2g23cqFbDKVeml6+fbT7FDTzbmxz?=
 =?us-ascii?Q?nX228AJ4k4QQt8WNsJwYlCqvEr3nUU/x/EYT6VFO1Rqj9iQ6NLfXksNMoJ6p?=
 =?us-ascii?Q?nAl5DjorWXjiSjA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xG8wlpaX3cm3wHpK93GCmc7c+uTvC/xIuMqJRwzsAvaEwtK7v5XJhLx/Fi0x?=
 =?us-ascii?Q?xa0ao7n1RFdiqZLC+twb2UXuAwIpSBA4WRkyBbERyyCXu05BJb435qF+enQE?=
 =?us-ascii?Q?DBvD2f7VqDxzyT2nWwy6ZWVOw+MNWTa806fRH+R0yujlUjKlR5NKXAY4xrJj?=
 =?us-ascii?Q?3+tIi+6gb20bBmO+BN6YdfBCUiZ03pzYSD7/InPjhiORd+yYtmmSfDFCJNXD?=
 =?us-ascii?Q?3o2ASmzLGoq3CWibexJctzkNBlcWWbwXAYO1TwG0UBNoySSZqur8XobVursh?=
 =?us-ascii?Q?AzhvXdeM/GhkrA8UmlrMIaK1VmHZrpQ2Uo7WhDGRy7/aVL1V3mRjzu4hUnVn?=
 =?us-ascii?Q?VOzTfJpHGAGupsXF14eUZ4Tz4G6fdt/eLz8Saz+sIVRjqoCdLyMWahCUa6JK?=
 =?us-ascii?Q?z5sz/6j6xnu6/3uc6UXud+YgHNVzzbrfD+CR1cUrr24MAY00J8E1AS3RzVsD?=
 =?us-ascii?Q?N/mwEQhZ94q/3ROrCdInJuxbWCgivWEmfq2T1v9ZM/+tlXyUXdPA7DTR81fY?=
 =?us-ascii?Q?7nhKBAv+7bU589g+dXriqdEmtcUgXQf5oS2jPIA3boVvytNC4BJloId0rJ3K?=
 =?us-ascii?Q?vYGrBBjXFB06HMQNtSNOUl7JTQ+88hDWtgo+TdT0nq+ldzrpxWzeXL4kPnFv?=
 =?us-ascii?Q?ZEfIm1gObS8lR1Vjxendkjki20cO8zymgCLs+7rMeg7h0uztaK03i7LyHJI1?=
 =?us-ascii?Q?v/XEUcC3MagbJdVCdHoDvVcBayFhdYIgTEoZlWRPHrEIKdF4Yni+Z6y7hl6M?=
 =?us-ascii?Q?5vPCHqX1eYXvILaVZBPl7P5KjuHmnoa/dVD1cx+wqvNz/5tnSkDYhX7gE3fw?=
 =?us-ascii?Q?x6xucvmWDhGcHzezPTpog9yPonXn2l1DKd41GbpH2/C1F9nRsqwmrXrPt1ZT?=
 =?us-ascii?Q?nzucgb5jzFTQuiK40zQk6rdv8qF4T5YGzw8jEOKxV15iV8CJbNYXciNYgJ79?=
 =?us-ascii?Q?WX+l7v5d6H2Djox0mEPmffq3Lwu3rKHTgQNf68z0Li9WgSraPFQXukomM6jv?=
 =?us-ascii?Q?J1SdclFwzIH83N7tnGUAdRxSoMc04ok27GiMtALTKbtiro0TIfmOe4Z3Ommf?=
 =?us-ascii?Q?QL10Uw8YuH8uJxeLNhLqD0gidBSaf6ICCb/ZT+U4SfDRvJsyHjqf8dHVtkdR?=
 =?us-ascii?Q?qmbkt0oRWBuoIvAUkfbxqOs7pCx+UBA9cF5UtsTAQ1P+L1MnmaphNtjCKlLo?=
 =?us-ascii?Q?VTM5m8JDctNK0lwUo7nRUjzxw1AnKUfpJOm7IG/fsj3mPTxjsolTmw+Z2yNH?=
 =?us-ascii?Q?mvyWwDQ+BfpN5iZqdX3r/h95VbuFSwIWywCuMvgT9bHp2EIbPndNFhpyg4dq?=
 =?us-ascii?Q?BlxsPNLD7hk/ltQRcbDywCYWYr03126sjaAx1vrXbTsA4ewhlt4rcpyCSLPg?=
 =?us-ascii?Q?LxuZPZVKkrC3yBZr7+VQCdp0aicZoS+1GyVCux6/sQ2iJgvqCnv1LoXPwgc1?=
 =?us-ascii?Q?30COsuTHqknMoSlRj2mrry0CoJET8+KRsHMPvQjqgZFEvo0ZM117Cokfxdrv?=
 =?us-ascii?Q?+7Q2w/O6waT0xKPxoJKKcNOw4jEpMtLJVH626APSlR+Y6NQke7jIyPhdPkFI?=
 =?us-ascii?Q?a6YaM1rpzBcYjhk2360QrLIsRJW9cCymJo/FVVy7d1Jw1c2GsjKmrh50hrCa?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bb3195-66c1-4c7f-a166-08ddd3f83adc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:25.1304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNUBsqMuspOQ4j1h7kC9EqP/5m7AJHPyRVgnGvoGiuHtncDjssPwwG7WS9yTOUq1yoY1NGVbHqY1H/0jz15gBEdIVEgYQQTwdMbj25eR3Ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6698
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

This is a port of linux patch 25fefc88c71f47db0466570335e3f75f10952e7a
(mtd: spinand: core: add missing MODULE_DEVICE_TABLE())
created by Alexander Lobakin <alobakin@pm.me>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.47.2

