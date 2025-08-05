Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37589C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 08:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524DD8416C;
	Tue,  5 Aug 2025 10:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="163WP7qU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F23841E7; Tue,  5 Aug 2025 10:17:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561EC8414E
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 10:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlLpnSb7yn+tcZM7HowtjX3vW7vljwSoyX/kMA8gzgjMAHeYKsOW8MeaWLAaOvWb682Pmgl2723dwsW7rwVT7OzA3rgxHqD3VFDvi4AnV2TAMQHUbh4F0YOE3t07WYVVlovzZ7dwPyr5Qrhkhy337V1Ll3iqzsudTkffM4j9iN//kopXxG9u/gGfEKAgHuo2KkE28v40NDPf5nrDgXAtJYlr62MMLaCsiSCX56Wzm0m2MZ8SprNuBGoXSdiRPmN/6761eleaBmOWQT6wvACjv+ZJQMS4pK3sB3eRz2fkTA1KTToTfdRqNerIGwcZJxBz7lasDynB0jRestgGgEmQjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxXjbMxCCC60GPpNteIvyh+II93p3ZKK8kmkPkQDFhs=;
 b=D2YQSY35yzltLfpT4y7nE1ei/KJrGUtaNL7dY3D/i6YwRPmunzX9bS3OypqjNsjpdMBaANqOi0Kmndj+LleAiX3+Yjtc3Jorj37eKrHds1CXQ9EkmS0ffDFPfc260jDsHlBhE5fDfVXLILBXlI64VM4mOAZaDD4hwzkCjcRaXZke2CFFVsoenOuzLIVjsAVolIeOXdy1q1GJjYsuttrQEf5ywiAHQVAg+/w3tRmwrCd64JWjuYGak53PnGKPKjjiAyqpwUO0s7apD+JdcIMCZ1wJuwHb+OZvIomDfLD0V6PhW8wO51BQtPmB9THp/OlwwZaO7iKRfSChEMI12XEZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxXjbMxCCC60GPpNteIvyh+II93p3ZKK8kmkPkQDFhs=;
 b=163WP7qU1TmzOB64JkbhEm9FLu1Lipqc8c0nzG6OuLb4i0l0AJtSUCcTT+LSDL3KuzUQff1nsR+bNUHJ3oo+0c0NVAvlvZrsm0SPe0NYPZewZRNsd2P+gSyNUWjo4Sac3o6SRlc53tEnUYpQDlK4Idn6A4WOgGO/LYfV9E5Ahufur6dI/PDsNPq8x50vvA7Um+sywTiv6TE9XCvpAD+LJijZfRfUsg0BnuYOkmH/J6MBg2M2cSKHgx3RWPO1+UVP4nJcCPDf/agaE47y/3AqavfnXwSouXGSkYtO4X4n1gib8RMSgx9Fi8QhahC+Q6ez9zGqy79B7fR/OPMESgPGug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6698.eurprd08.prod.outlook.com (2603:10a6:10:2a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Tue, 5 Aug
 2025 08:15:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 08:15:33 +0000
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
Subject: [PATCH v3 11/22] mtd: spinand: set bitflip_threshold to 75% of ECC
 strength
Date: Tue,  5 Aug 2025 11:15:00 +0300
Message-ID: <20250805081511.1482964-12-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: deab20e1-db47-45ec-26b4-08ddd3f84010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AKzuaiZpf0mD3mFR89oArqHtMVGYQGdf2vlvmoC75zcMFH29IAUDObvkfZbv?=
 =?us-ascii?Q?AZNrRSVviLYPyC3wVMJja34qkz+p8bMOoCbSHfJ06ODkrFvbP2EPosNf7KO8?=
 =?us-ascii?Q?crSKX3IvNmDr4xzKY0Nv6b/V8SyzgBqAO3JhF6Wqh0Y42hyKYw0i+KKoH4GT?=
 =?us-ascii?Q?tjOwkhzXeBxSLep/OsYqyRnCP1/Y/O5vG/Bb/nzy/DUTE03Su9NaA7c8i780?=
 =?us-ascii?Q?rN3ZBRcFJ5ubtSEbHThzkL3/YZIO/K/+O1Vqzjn4p08asc2HQzLlxFvG6JH6?=
 =?us-ascii?Q?vQy9Ui9xQox+2MXeQvr3oFVUBvDwtAAZwE8SxIS+qXO/nPlRYHTlT+w10wmE?=
 =?us-ascii?Q?YTYLJi+/Vy4rVES2pEtj9Bs4QGsOayn3RFSdfRAK+ZSCoXiNG+LPltjuGejw?=
 =?us-ascii?Q?5YiVBFH4DCjOkBJBCnGqnSe80jPZMBOX2uOvqYY7Kyzpfra070L5eNqteczL?=
 =?us-ascii?Q?rb+frNXNLEIHi8O5DVhZ5fq35hNU0nxVdXQlY91mgZhJ/8YXRjso41YvUyjV?=
 =?us-ascii?Q?nsA2i2e8eRa6kbKq1qYZP3vsAyE781DIVWR01vogs12y8/DwTVqUmkWDlLg7?=
 =?us-ascii?Q?lAVXZtvOsMl30y4qIL/cJ1iaNYvuGQnI1nNpmInK1Din2Nc4sWwSGB5XYlte?=
 =?us-ascii?Q?UrWZ1tPRlM7O1GjzJ0tBssCdPgPLWtvltKVFeNM3muHSm+y3KSWeKJrakNkX?=
 =?us-ascii?Q?mq4lHNU2gXaD/WjF0CL/m0WzDH/CZB6f55NkN/5JnB6pVUhgbhrVOi9kH5I0?=
 =?us-ascii?Q?e6g6x1N/Emcp9S0cpujS0OKLO6eoNrOztUySgwkP1KV+V51KT0ZZ4fE6Fjqd?=
 =?us-ascii?Q?dttcE5uApxiwa95uK/mCQDmNUQUpLK1Q6xS28Ie++JbOYamR779EMpf2dx0n?=
 =?us-ascii?Q?Ygo8N0tuvxkXZcAH5gptQUmnhVoRbKvud+ytkNXWuSpwg8KsxObNieRynXfV?=
 =?us-ascii?Q?NVumkUZlAnAnbta98U6uNhtPcibhbYVUTUvQHtOsXEQs3Hbd13LtpQu+K8Gw?=
 =?us-ascii?Q?mfY4Nq2n5B/y/NScvO6rXXIIL632NcQHqf1WN6MxhoV5Orn04uW/s0hXbQEr?=
 =?us-ascii?Q?4aeqCUnYpnazaPSiDcWRKlJnwQDObetV70TGYjix7czByBHkoyIsDrG2Tnt5?=
 =?us-ascii?Q?6YbCVU6SEBqUnylDlSjPaLPLicPnuAE3EaWyTisljR7UwJRxyAnAqS6tO6BT?=
 =?us-ascii?Q?Kql4bdgE05QoKK1dzaFRbju1ZMsCnaC4AxeycZlV+P0f9r1HdBOHKMwpSWlz?=
 =?us-ascii?Q?RWoA3o5ijmwNP3fZjMObSB7we3dQvdqUhgrkNc90KqPtHlQ82QVvJwW6H2zr?=
 =?us-ascii?Q?YqKJYIdVGdUTsDL0O3d2A2ae68fTN8j6PnY44K2UbWBCr9KOocXnsX7ebY5N?=
 =?us-ascii?Q?UYrfH8KiYYSlcz2LhqprJemB9TaofRAtbScGgbGKXRTjWVyKHa0buagyJDDY?=
 =?us-ascii?Q?4OW4+uOvXBRqogwjuXtOaP3kiU4DCXT2pZlNT0D6SEooYinfJYDx8uuSpRuZ?=
 =?us-ascii?Q?vYR28dRHl7Zlk+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?it5a4kiSRn4V+td89IlUlHq1BeO21n5sBlpkPJ1asE0oQBIbNqG2mIbr3QoR?=
 =?us-ascii?Q?nAxejqoKuxhxKqJxR8p+20tQX6b0CvHEGWgNnc78+1/7gwpCeu7crYLterhe?=
 =?us-ascii?Q?SBaVhd4hK44H1e2gjGINyQyA8cQ3fM7wjHlcNstgO0U1PNmfCoWe+PxI06vw?=
 =?us-ascii?Q?gLcvJbB4NSXkb0YnesgCSWNIi5kBYXoEl+H9bd8csF8idSxCScR8wXMPZFyo?=
 =?us-ascii?Q?hgDd3tVsVhPorueatWzdrjG4wcbuL2W1LUrj1J8K8DVEdJwhL7fFRuXPj6SY?=
 =?us-ascii?Q?zRcY3lXzfsWjxZFMGcBnQbaAOCVuf68dpiwVcabMLLbSG7itPrHZj2VV7e8h?=
 =?us-ascii?Q?qd6j/O1r7UQVF8T4VSjSk+xN/obRw9PRAEnr1ezOH82s/ZyVwVsEEQM7T5u0?=
 =?us-ascii?Q?tzsj4pw4ougZIZddIn0F2qflusLoEvXEfXN199Jd9zYEbnAIzamEdiaNvd5d?=
 =?us-ascii?Q?r2pZ+HLsEEH8HRdd4ipQ+5lUAVX/VquGE/+DAhrxt3gTOHbF4KorKVSEh5VO?=
 =?us-ascii?Q?B1e+c4/w0AS5wenziGr00TKfyObCJHxnPnKNXDt5gHtFkzHrtFd27pMrRVlc?=
 =?us-ascii?Q?GDQ4HwhNTVt0KkyAgOzUqm9kaCqDFXOFpWj1jhshkmhE1wLqWt4zmVt14ArN?=
 =?us-ascii?Q?o2ocG7td05L4WBITX3cfEIhtAnk7gO1L9FouY60CVYPJH7+I8pO1X0kZSWbN?=
 =?us-ascii?Q?y2xk/bNxNO/Mf1Sv8cyJlESmUfLdLjRcD90YXmMehKCkbjvbPWmi+EHn14Q5?=
 =?us-ascii?Q?SGj7lN9Zr0PNZ9+g2OrgNNsnELeoxkmjcNtf7wNFHC5UZ5fLGnfMcbKhDE78?=
 =?us-ascii?Q?e2XwMK8C4ZZZLMfmB8TXdX2RjxUezjtHrk0dqR++7woiGJsLa5x6TCPrshdH?=
 =?us-ascii?Q?/2P8xpAIBDxaR+uRfLCC38EjwRsphkW4KMwMl6VYWesLv6m/6sivvnWwu5yE?=
 =?us-ascii?Q?cgT8/5eU48BsWi9BpFDG13yQ5cqONtl40YOV3NHsfWlpCofLCGMW6umsXCow?=
 =?us-ascii?Q?5oQ0QLrNyZAeVbsTnx38/6HgB/MW0BcLidqtpB4OE0liW+gR2Ax9jsHGtXua?=
 =?us-ascii?Q?jmdMORxNvMPFV2LtFwFjLHwwBwSHcMWxcaKC+VVDPq+Aiw54e5c6XNUpaKM0?=
 =?us-ascii?Q?z7XzcxU+fC6moxXYBPsanWoR566KJQqL9B6CuF3GmLWZ5CV8PzuPyK6ZPfsp?=
 =?us-ascii?Q?zsjIFX9sYA2XNCo3xZKPXQhVE9nT13BZmiPhOdwcfIo5MMwezsdOiFYBHqHY?=
 =?us-ascii?Q?uRPEdE6jmR0c7i2MXqS8CPXIJtIk+ZsI3Rg0NrB1r5/jqEEfFR0YoBvwrmIf?=
 =?us-ascii?Q?HHjYe5Q31NKd8YqnEfjD3CRybVzXo3Reos/SVlZQicCTDLwrRUgIQVYVctL/?=
 =?us-ascii?Q?TMiKovD5nlNL2vsArSD5PH3O/bVYjPRUWLc5BmMT4/wqEzzupr5jMgABE5W7?=
 =?us-ascii?Q?62QkdyJ92jjYpTLuMbqInTVRHHEq4l/iQq6ZhacPB4Mxrz7Oicp+I8Z/fmfv?=
 =?us-ascii?Q?xzdjczW4fIOH6Z6/3ctFuRQWXbkBMAo0dRSRUy4CHgiUCP7fcaMZMUrigB9+?=
 =?us-ascii?Q?MIEiXbj5OuTjUH7iSqsTZPQpAJSOOA0i+1ADK2smXMCPTCiZpDKslZXBlrcJ?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: deab20e1-db47-45ec-26b4-08ddd3f84010
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 08:15:33.8732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O++q54PhMJiiQl4L8dSgMzW3hTHRlvpgb1OCl1fThMGRUCWKLLB5+B6Xbb8mh4hIUSqxwQMjiZOC3YoFoAxpEFvQoZHsm8Em2NT1oP+6CYo=
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

Reporting an unclean read from SPI-NAND only when the maximum number
of correctable bitflip errors has been hit seems a bit late.
UBI LEB scrubbing, which depends on the lower MTD device reporting
correctable bitflips, then only kicks in when it's almost too late.

Set bitflip_threshold to 75% of the ECC strength, which is also the
default for raw NAND.

This is a port of linux commit 1824520e7477bedf76bd08c32261c755e6405cd9
(mtd: spinand: set bitflip_threshold to 75% of ECC strength)
created by Daniel Golle <daniel@makrotopia.org>

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b4795927277..7ace61fd19f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1279,6 +1279,7 @@ static int spinand_init(struct spinand_device *spinand)
 	/* Propagate ECC information to mtd_info */
 	mtd->ecc_strength = nanddev_get_ecc_conf(nand)->strength;
 	mtd->ecc_step_size = nanddev_get_ecc_conf(nand)->step_size;
+	mtd->bitflip_threshold = DIV_ROUND_UP(mtd->ecc_strength * 3, 4);
 
 	ret = spinand_create_dirmaps(spinand);
 	if (ret) {
-- 
2.47.2

