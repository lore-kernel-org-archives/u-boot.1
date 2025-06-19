Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187FAC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436DF82D60;
	Fri, 20 Jun 2025 01:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="a6DHodEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD27182C55; Fri, 20 Jun 2025 01:55:04 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D7F82CF8
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2n4HbB20oIcV6nZqBeljq/b65OYx1zc3RmI+d+EK12jYrKdNf89T+BPOOKrohjeNq525ReItnKj4BJWiDP5bcHZrfhxiSkSBbvwAU7rvWWE+u96/VfDK/lDxQAfTTo0mktJ4bo5ighJTavqF6PjUvyT5bNWlHnDugV3uIDJYMW9liq1tMhyMHT50shxv06zTlUH40PZ4e4oyOvnUCQf3Rw1K9VXt17du1y7WpUHk60a1EQbMzHyQq1hPQq1O5uBZSF22jqi68uXmWFd3aQsGVxst/bONL4udG2+8SHsqDXQA+OJTPOPkxg4WQ/K8MR2EsPY9Q7Nj+6KWanoh6YAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Y1ivzPx/n8uWvPI1YR8XubO09/sN9YRVwKK1xrEgE=;
 b=KulQXEINdVLWXy2uWuivhO6EqzpP4R+D8HJz2JOK13yAdSmGLLu/LgcfAAP6hr3zJjaJSSIbm3ER2VwkBjw3WPHiKQX4nFi9NkWn6s2JT83GjDcjWri+HrOR0yvdjaK2tYir7GeWiMwyythNAeG0Hl31632HtcOlABaZkcS3LkFJLZy1hoj5Z7yDwd6Dl8UqSizL5MrXuLaJ6gQBmpGlkgF1y2dgyxbgM3jZ37ibY0oPKogztVwoeGR4gwxmFit4+8CJpNCrImYB4cmc5Bp5MEXo8tRxqUDbLjVTvI9Sc3VSHf5x5RaankUCCri1OnAaEQk7UOPfPkJu3rF1OsT8Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Y1ivzPx/n8uWvPI1YR8XubO09/sN9YRVwKK1xrEgE=;
 b=a6DHodEqiWlzBVw6FwVmDhaYVdu0To31TDhuvhpJC/WKXxYRO7uiQhujVBSyes9UNR8lczWb8KZLxNtxZVGPCOGMeBr8PVtFVJdW60Q4mOTD4qz8GvAbJ41jN7OXRXvpGmitV0yNBGOAccQk2Fff6F4g8PX05cxFmtRFUtj4tvj2LvvUxoS7ymEEelYgineFzcVKLSb/uxokG71UKLuOLcZpW2WDJEXivyvLTNcNLi0iZqD7smJpSa/VhQnZh0qSWAfhZQBTycm0Nk6zbI17b2x35HdxlWuF402ZEeex0XXpdw30U3P5M2jPxImJwNdAtlPmdDZIlUng6w7FCrLhEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10560.eurprd08.prod.outlook.com (2603:10a6:800:20a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Thu, 19 Jun
 2025 23:54:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8835.023; Thu, 19 Jun 2025
 23:54:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 1/3] drivers/spi/airoha_snfi_spi: remove unnecessary
 operation adjust_op_size
Date: Fri, 20 Jun 2025 02:54:46 +0300
Message-ID: <20250619235448.2414587-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
 <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da03bda-d999-4b22-564b-08ddaf8cb214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zkH0ASaWVKMMuZo71VLGR5wFU59kICDFkH9ds5alVRWaqbTSK2iD0UWnbevS?=
 =?us-ascii?Q?/a1fW8bpUYOnraqj4FSFlexkVjgqqxo1gDHHpwMZ7cwpkqEKvE4mlJZtj/x1?=
 =?us-ascii?Q?O9K2y0SoH0KZW6qsmQ8ExwylNT3JjnQMkvQI/QSomR13eB+2Okbop1FMVyn4?=
 =?us-ascii?Q?8UEE85DhhO74iFzzOCw2kzRxh0jNUvH/vlOD4iCSUErq3j8gA0q5tAww+fmC?=
 =?us-ascii?Q?zmuALjCDsE4g25eYTqWgbY1tIuh3UaVRS9aurkbgIQdXMZFQON379WxTbYNF?=
 =?us-ascii?Q?q1mQFGgIw7YobXtExRV9jQR+tjp3IrlWR4J2IpwB1cjjWbXx8Qw1GtJrABe9?=
 =?us-ascii?Q?tE836x9qaw5SD5t4za/D91J50/FtjFRb1GH3vaSYkilxBM8zCT8EgnmqpEec?=
 =?us-ascii?Q?ZtGSmEZhb+/qH6UnXACLbDCQsWFyk5daw1NpP+Ba0iaI2A1wZhmYTayI5iSH?=
 =?us-ascii?Q?YyMJJEBZ1+AY1vRr/fzKFO2h3DF4vd7Sd9A7wMR4w/qB/6GY5xyYuuLJIa9Q?=
 =?us-ascii?Q?LJRNgKKqgPWdNqXUgyhIChy8Xr5r1auMzceHjjSS0EtagoZSdMjkIYKriEHs?=
 =?us-ascii?Q?RgD0FiLuBLdhAlIqy1EpMMVNc09zYGaQCqbcynzyu4VAlMQorOyOtcsxlB1Q?=
 =?us-ascii?Q?TRBoWiZEWMFHLxNLyEZZWVx1048Au4hY1pmgio8ZbaYqY5Fj7LsA+EVy9YYq?=
 =?us-ascii?Q?qeGYDr1jJ0wWVlG7ZHI6EApBOaMrK0PegK2uRzZ4SHz3lztMyj4cgF1UExdC?=
 =?us-ascii?Q?nS2vDd/DgBkMugV323mZyB+hl9pYyCNl0/XuJkw0UkvqIzrTxO5qJzywwZ1x?=
 =?us-ascii?Q?hHkpZhfjR/qKoIrMnPdwNwYWlxggs5eJhq/3muDTC8FGDnZ4QPIHtuWotib1?=
 =?us-ascii?Q?XxNHX7UcKU4sLsb0ILnRbsSGK7HlkpoOAUsIU7rPPo8cgCOjwrKMjW673QnC?=
 =?us-ascii?Q?7oXoixLLwUXcsS7Dew5RfJtYGAfAZ/PFGa9vlZ7e1EIZDadm9V2R5hjpqu/d?=
 =?us-ascii?Q?BkTFebgTm6T11fuIeivry39gGHVYSV9cSSIaoRgMUPSonjt31r28ghfYPiAW?=
 =?us-ascii?Q?J0Rs4AUFOP/SzopiKIBEElGovQo7Xgj/wk0CkfgUpLjcNEFxvJbBFpfYWa5w?=
 =?us-ascii?Q?9hlyUv4ncaHq6b6241hko4bE7pT1xVfSHj3/bHVhss3p40EbhvrlvX5lFOWV?=
 =?us-ascii?Q?dIhfHu4+4d5ipoPmT/AjsVKFCzgVluS822nGvLlHihyjNJrhq7BeWXcek8mS?=
 =?us-ascii?Q?YsIPrjxavfX895C+6jau9Ts+0dp6QhNCvBCOi5ZiYnZGKCVh/Q1kVR1m5NfH?=
 =?us-ascii?Q?2jAjypJyBp2f4ReeQtF6G15KICnFoHw4NmFAgpjdLYv8EDFUgNOBJ41IIigV?=
 =?us-ascii?Q?t0sJELKnWbtHzcgNKJ51gMXevlw5KV3yNO6pkKPn9ZqEvu055aRGvtitU/iS?=
 =?us-ascii?Q?RZU/pQHiXIriWCRey0leTgYvnLc0tTeHj8O9Mh/zRdzf8X2UWCtW1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tvbKfeAOyXMgZ3wMDj3zm0TREoXslD+O0EE8bDSD4moaCb2tNspSE0H7BKI1?=
 =?us-ascii?Q?fi4tmkpzJIR7oLE3ApCpGsZeGTE6uj/e0+ZtOOwR0x4kF9kVu27L0/fxQh0N?=
 =?us-ascii?Q?Z5cDa1yaCUlAes7e4Nnc9f3plqpXEgh8OcfRB5tET8xIHXcLJjMsnBvHYXi+?=
 =?us-ascii?Q?DhGPqPLi9P037XZUYIEcF0xWXNYybwowtnjWbHxmoBc+BIlH4oPsAAesrOnK?=
 =?us-ascii?Q?0wKiq6leEUE73HyCaileurZyOX3t8KPM0fJUAKCdbjaPFABCNEjp7zX42opW?=
 =?us-ascii?Q?8P41ZwzAIFKkZaYHDGwxy0JbMwnfRreEjN63ZJGlTY4HYE7vTLnzs4cKBeWA?=
 =?us-ascii?Q?UjqQ2WdJrKIJDruRyLBSIkAfA+VgATzghLgDD7Bq8bgnxpSMzFgzAgdCuVzy?=
 =?us-ascii?Q?zSTaRbA8sFAC3QAj+dW17xCPk37Dt1KCNOdRlvfuSrYlVgFk392TkbY5Bgw8?=
 =?us-ascii?Q?eiBgRhjkBLWNKDT6RhVPh/uk4xCZQ+J8VVXy4ECmLva9xbkpGWcn/0UEYkNu?=
 =?us-ascii?Q?t8NEunn+/Trdi/E/zwyxye5iYHHcJtn7HgCWHBA+HLRILNHea+W+TThOdP4U?=
 =?us-ascii?Q?18M3iRsovh55i/jh8gknrPUahp1mW/3Z5BmK3K2roW3U8qP3KiGN7/Xjesii?=
 =?us-ascii?Q?dMzpqOShwEfD4+1ermykSx/vD5MXJEgV6QZm5x3gcugsIvrb5ggsM4C2JWgT?=
 =?us-ascii?Q?k0LJ0sX/ve3+C106WNJ7ps3KPUJKcF3gsAtR7B5Jwj9BPe9i+cpAk6Hzy8gD?=
 =?us-ascii?Q?xW6aBCS5Q/XXGzXnXGu34LPxjgsDkWPlFAJc6Cq8j0s9YCSB3TbA5i148Nb4?=
 =?us-ascii?Q?0anJiD5AnIK4M6kpkjtFp453wknqSqBoWXdl8GyFHDmBHCc7drgZI6hH4KW+?=
 =?us-ascii?Q?lnKzDXsQeR7wH/Y9NWZhWfjFWCGw8bKXij/Y7lQORRc8WVdRGYu0IgtBbPxF?=
 =?us-ascii?Q?1uBoMO7Uj1dBkP2H8BMigVfaI6MuToMy/XrnRrX+uk4wmMP4pqarXjGqGlOX?=
 =?us-ascii?Q?8OST93BWOjfTQwqbpd4P+9tmiNUyCQYUUjqx9nMW2Lem1yNWCszeDFRGLwFr?=
 =?us-ascii?Q?RfCvwtE9nuh1Nk4DR2H8/noD0TInCZFGzijPYqwF48M7U7AAx+1Jvh4uM4C0?=
 =?us-ascii?Q?bkRpn42APuW54yIAtYBG1MpA4d9UgNGPbpE77hubtoOY3lqycbMyfgeAcMxJ?=
 =?us-ascii?Q?AuRPvpwfV9E1hACSWc3JHDJDYm7HMVVvhkeaLcvzVnRBa7WfZBZhnz8iA/P5?=
 =?us-ascii?Q?7+XMGA1RsQmEoX1qrbpIgRpJ5ITU/cD7Fcd4eAp7KL1FW0G6oTwa4+zbCbOS?=
 =?us-ascii?Q?Jdm86KpS9jjSbBKgY+rL1skiZYeFafovVrUfamBzIdQnGUeX/SoEGuasm62e?=
 =?us-ascii?Q?3lswKOrS4BJDqkAeejSj8Q0mpQyMnaFkUxMUP7mu1P+DrH84p1hhgKKTzShx?=
 =?us-ascii?Q?w/uTxzYYxugyNepmhhpN+pqPeLIZS7rqCvCU/m9/CfEvYDm4y6ON3OGv83R1?=
 =?us-ascii?Q?z1cplFcE3HUML9/ZMsQzTU8uggpvzYMUS9KYZ2BFULHf0gVJQEttCmzbHPsY?=
 =?us-ascii?Q?4HeyYj/UrNjAqZ+CuSePXvRb9cm2xe3pj3YwOeoewup5ZXWVyv5NKgJukn7d?=
 =?us-ascii?Q?0rY54vCkKivOkEXRh9lHi1U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da03bda-d999-4b22-564b-08ddaf8cb214
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 23:54:57.6522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShigoWNYHt16WE56STzmGsCxlMBWUI5KrVfs6wcpJlBgzFumOlzdWQfZIpsg03mUYgliY/z44shF2TWyZ5jyn2+5qM9YJfxbwNKAkRZ4+kc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10560
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

This operation is not needed because airoha_snand_write_data() and
airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 3ea25b293d1..4eb01038404 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -525,21 +525,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
-static int airoha_snand_adjust_op_size(struct spi_slave *slave,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-	if (max_len >= 160)
-		return -EOPNOTSUPP;
-
-	if (op->data.nbytes > 160 - max_len)
-		op->data.nbytes = 160 - max_len;
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -691,7 +676,6 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 };
-- 
2.47.2

