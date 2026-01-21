Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6D7C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 16:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCE083A1E;
	Wed, 21 Jan 2026 17:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="LGEFtnbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61FF80077; Wed, 21 Jan 2026 17:33:38 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D626183946
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 17:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnhxMRCKyxXYc0ouwJvfs6BJV8vLOelffdySoda6EYKyAw3XeqrvDOBF83hY8MOHjV6q9zyCRGKtCTefykou81Jn/hc+X/TAjSkGBrG77y2o6iPQES3PEZKIuzE0irIZo/Xqeui2eQ9Un14zdDXOLapsFMjkNadZRScLcV693/0V/uNYtyMUIlWB0Zxa753Hj0MzJGnsvXka5TxB4lnfkfZ6KCzMHeFfp7WvjeZpqF1p96tOvI8thm5bZ8iCNA+gQPIV7QNsvVd4LD17tzgg5MpW1g1I8bT4vNHlAbFJgY3khggKd1+dm45fibR/v60wfMFk+FuiOcwzXy8xZE08dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx3GvPrtEc84oKQFqZgw+1SQMoPJkUHR0Y/wpzWk6o0=;
 b=UFQvOQaTuqoIMB8mZ1aD73FP5MT7D+2yZqaHO2rWLU63M89yVDujgyuErWC9eY5BEm5h3Oq7JxP6hj5MCd8ir/NUtzexkTnFtB7Be2mhzVE3aELq629XnVkDccVzV2serAjcIwR6y6coCuUbbl2FT58jrH6fdWTfkOfTtM76/FY4akJMdc2v+Xd34u2AZi/O9gWmce6vRo5gOsN0euCBA3EPLKS9YsuUhsRMmWhNcF29zOHkPk60HM906uKTOeWJMeydsAacXk7qP+Sw13IJvbkfAvQpxGg7gSj92HXJddqFmuywzou8JyZvVgVpDeDYISnXCO4PsuXVMZV1X4hi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx3GvPrtEc84oKQFqZgw+1SQMoPJkUHR0Y/wpzWk6o0=;
 b=LGEFtnbo0/Twx5oSHW+T2cEv2gK5vEfDngtuWKq5iinQ29vAq7YRThCNUiPAIn12O4hfZw1filu623vHTkAK/OLG7O1fu7V36x9FtxTmXP52ZfNGjkxIkjM6B09ffxRPjslILZwkCOeq8nehp4ByHcBGTQhn/KGSniMJ08jOlAtQS0oU6mFONh8vymrX3tNYOvqor3sIvO/1OJoABlyeKzJm2eAZQ1t6f6foYeTvmM63/QKpqnW2KdHqI1p7z5ETjZspT9mfGcaGkphbmkGRaWydfZeD3h6mse907f6C+xpwSNGb67p4tDudSAP5MQguERogfEDEMw5PPMDq81v3Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AS8PR06MB7750.eurprd06.prod.outlook.com (2603:10a6:20b:335::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:33:32 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:33:32 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, vesa.jaaskelainen@vaisala.com,
 Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 1/3] mach-imx: ele_ahab: Mitigate imx93_qsb build error
Date: Wed, 21 Jan 2026 18:33:56 +0200
Message-ID: <20260121163358.21322-1-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DBEC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::305) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AS8PR06MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d11bf6-e727-4ecf-8db3-08de590ad094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7dm44ij7UQzfCcpfYAN8Wdr0VsrqZrd6WCavpPChERfvm3JTqI3D30cNNb6i?=
 =?us-ascii?Q?x1Ba2EVqE2FukvCBJM1PVU7bd+fZljXim4cojd/bYrZQlzq7qBF20GVURTbK?=
 =?us-ascii?Q?K5U9xctY5QDbmYYjRnd/yzlnR/KkDo5LpbeTUcqJ/YlcV0hFEQnBgoKx6rKt?=
 =?us-ascii?Q?WLhf/7rMlMO2Pyqt3A9Laja/8BXzEitJJKdcicnPEXnNASVYOWP0Dgt9ZrSH?=
 =?us-ascii?Q?70VowS7h0D9XTI9HqpEW1ZLmE6Ta+Tdpx1RGqvyEzBBB5QF8K+aKGP6xPPN3?=
 =?us-ascii?Q?rjbIzFteOls316NsZtdsw/IbYM2VET9562TzLpfY7y/CKRlyP0zX6YAtINMz?=
 =?us-ascii?Q?FnxYbrwgAhb0srL64BvFtwWWh0ZROXzL6BahlSzK3K0+3BVPhxMDzM55GzUJ?=
 =?us-ascii?Q?2uDIUin6xrfvK8hQ5SGM3Rjooozb/kMhLCs9w3qOk5nutBxwpL3sGEWmBzNl?=
 =?us-ascii?Q?dXM+hrrhyECB+lhNs1RAjx3Cv4fW0timY0fSy+FDKTqAblXDj8l4Phjgl9TS?=
 =?us-ascii?Q?1gbDXB4ijqAsoSX79qbvsAtW8C+u3g5qu43b3dzKe3VMUbiJOO9h0LE/jiNH?=
 =?us-ascii?Q?fa8s1TH1Eg6s/b0l8oesRxVn87GTrSaeabQMyb/z3IXkDJlqciNN3YZ8DpK+?=
 =?us-ascii?Q?4nMGccsnA4B4MATYBdD0xGC/FwtIEYj8ZpW3EiqS5EBlXY84nxmWK/6rJp1Z?=
 =?us-ascii?Q?jLlXAzoqVKwp/BRrxHxLW32+w/LMp3lzGplx/Y55j5+J9p5U7L/Xaos32d01?=
 =?us-ascii?Q?qXtFKgUk2dvsWneTAAk9ocx26i8ofUl1FkVmCGlE5br+Jc5SH+wS+shzCl48?=
 =?us-ascii?Q?pzdu7GWKew+Q9atEUCug1qeoruZ2m/puCIK/H9JGb7+cqvYmsv8Hssl9Eq1P?=
 =?us-ascii?Q?cnHRy5YepvDQv0QuyJXYXkz0FjAckAkpwxSw3cHCO6WPPwrtig8g2E31wm5f?=
 =?us-ascii?Q?cKYCa5zsieyfhA1ODqmGPBRg9wWyrCp2okcUVpgD5AYoXO8AT17+WfEHa0nV?=
 =?us-ascii?Q?K2tcbmLnCOJddECww1iOC9gRP7KaPrYdkle24LEWGv295ZZF92VLSIPD09jc?=
 =?us-ascii?Q?V54Hw6YYjDXgdlh35xrRwZqqw++2LS95kj9qBzv4biZWtr66TDQq2mnsUPuf?=
 =?us-ascii?Q?6icdjoiKkqYQgysxyzY0LR2axZ4jkGohM7T00AYQxdhV7BGjDVgJa6WqSGp5?=
 =?us-ascii?Q?LtBAl6Up9EPghKYQ6uVa7YQWrZGiSQbzBvy3k/S+q7+ghhkiuyswRi5OfCW+?=
 =?us-ascii?Q?A+QogLogbnl+ngZRFL++Hjbfiq+Bkd955lJCuI04IdSzG8BvAte1UZfOqJq9?=
 =?us-ascii?Q?TwRae40GNiNqhJwEczXl3ZDMI981nZnKbxtXSp10ciBfJd4rqAHrmX7jM9qa?=
 =?us-ascii?Q?huI3rYHlByc4nI2VrcmcCrzV+v0t+hNuB0S4Q6mRfK4RNGik/iIHf1+81gm4?=
 =?us-ascii?Q?yTYOt51MS9KHHsIXqSKV/ifXQnppPEdxWpN3Hq7qbBkvWkHUNz7cDwUrY773?=
 =?us-ascii?Q?Ae/6HkuldSUc2cKf7ykM7kLw233YEsqnvuga+Gb3PRtF0VIOCzkErTTnv28v?=
 =?us-ascii?Q?AWwbrZEusew9QykHb9V3b/erJuEdjyUhfd7vPcD3HItVqRro9Wz8TseyaCfA?=
 =?us-ascii?Q?GofM4TWWA3rwzsirMgRSKJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c3pd3oEnDxVaQxplu+/qcvxCye8W/9vtsYITuj5xD/K2N18w8wVCAfWz/Nq2?=
 =?us-ascii?Q?b5PyrXA+1+tLItHPVTnom61wgWnWGGgYbt5IoxP+j31vhYWQpsj7gQCwOk0f?=
 =?us-ascii?Q?KllWC4QRHqmJ6KZEzLnfltylZBLLrm3eWRDSQbFVEscYBfFRj9SYGQjiMYIm?=
 =?us-ascii?Q?oGDTPNmk9Wdw0xoEZv2PemaGx9m/E1hOJZKgoMpEjRGRPIM+sf01XiX5wqz5?=
 =?us-ascii?Q?Z8+iUV250bex7hdAZulryGhQGDt7wemh56xhFJPjqvLiPsZpTJMeGItBKqDo?=
 =?us-ascii?Q?AzmF6QjefZ/tFMRyClAaP/lK1QMIO3F/GcQwHARK1YbDGGYmIxlmRBwCNUDM?=
 =?us-ascii?Q?QtgWzZJjG1sdRvT94pjYbVQXiuppOMFIQS9h4ST4G7K5qTZ69VDwvOgUdxQ9?=
 =?us-ascii?Q?tE0hj3HQE7UgWTcY0bhE1QsO8tFBwXEtyqI1jtjLgp7voPVC/2Q0D4MW7fxu?=
 =?us-ascii?Q?qsPmQZeDzFhRTZNxzNNDe8Grod9+le4zq88YASYD0z4xNSNkFxJAyI2ovShW?=
 =?us-ascii?Q?kCyItNAbecCxx9cs8WL5ecD6Je/ryy19feLX2mxa9jeJiX/2olr08dxYMA+o?=
 =?us-ascii?Q?wEWXp7yAEFFZ4GorzL3sE0VFAvItZivpyRMPWDRZPrLPXE+KIpT0r//vCMBF?=
 =?us-ascii?Q?n1oSiuCFC0Dlhi8f7ShjXOLDsws2WHnylHrYXKxK67sK/ti92D7qtygz8SzP?=
 =?us-ascii?Q?SFcl6xRHUvQQ8e8dyW18GZ5BeBWeIsEM2hCloaOUkZjC7AKjepOygYMQkTZe?=
 =?us-ascii?Q?fZuN2SylkO5SmeNBTNkyXTNRyMuBG1lvb2GBFNMp1FUDw0bvlaLAM1WTXNtb?=
 =?us-ascii?Q?kIG69E9+U/G7nCG4ay7YqMFluFWryhbyTz5jpeMG6Tk03bQMYEyehk/R2dfk?=
 =?us-ascii?Q?NBYiETiIPEG0n74/yQc5jzAabI0G45BJXd+TOQL9C6BY0qU32DPr8gcporxJ?=
 =?us-ascii?Q?zMhBga/CrMbeT+bFaobquyXKR0QC+JUXsmWCSFW+VJPll11+TLdOPFCcjKpU?=
 =?us-ascii?Q?IdpU4nRaPjY58A5BeKn+IkY647yuJ9vKfGjB1Wkc+/1vrYzEOzasn6yq5z4E?=
 =?us-ascii?Q?tkxmT4pzoZiEIf7AirdTH4W/xhYiUi0tBzohPNOrP/7Aex9Cfd5RFo5DhxlI?=
 =?us-ascii?Q?GvHBqakAVYognAqCcyKrjcMXDv6WHpmW+ZhAYxaPyrAf4v9RDhJYg3VmjyvB?=
 =?us-ascii?Q?3o3sslEfOlruNAJo9lUsJOFpds6YWb+PiFXfaB8fevNoSuk6aGqwT7Led++l?=
 =?us-ascii?Q?vSpOZgSCVIqBcDjaiUsMiNf9yhKO5JYVLigQko6kD5may8vU0Qy2cZlKOk1d?=
 =?us-ascii?Q?ac3a3yRgdmUdYjSgs6VPXh9qnvPh72N9Q/6aZs7VMXR9Uh7F+wDfe6sYkw1W?=
 =?us-ascii?Q?Q6cQ1BQiE/Ty1klNZHWo97hkdxioowDmdAmzODAyH4ckoCdvgDl77gyA5ZoF?=
 =?us-ascii?Q?DgPVnYWjwGiUGRsZOyN3A4mcuFXZhEPq8khAatiP90ga1Q7nRRfn3Ry1cqYB?=
 =?us-ascii?Q?/nGyVhDH9KPGHTsNmPzl3GaFNmnzC8KIq10XrOn2rtDHhB1XPu9VWCbOVeDi?=
 =?us-ascii?Q?oYYkOoQ0M3KbIXpQjhW+5wZ6asOm3zvWcIyEyV/yCmVpkIMnvsPrdwNNwBU9?=
 =?us-ascii?Q?G//R0ss/MZZ3bmSjZPMq/C4DafL6ZE/YVH+2FjKq/965Er+7QlEyqZCYywpC?=
 =?us-ascii?Q?ymX8xtrdpw+ItExY64NJ0nu6Lp5qgI8B8DMYSK+MRB1KDFQlUOGEaeSy6cCc?=
 =?us-ascii?Q?GeqrE5WIj/mBFt9mUxtVjawkTefF3Yg=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d11bf6-e727-4ecf-8db3-08de590ad094
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:33:31.9294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIIMitmz+GrKGaZIl7iri7HNNkIua1jc2GyHhlvfoaWxYpxybAYZvuFHIvciWmBLnALIcQeegidUK+/QVSSocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7750
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

From: Niko Mauno <niko.mauno@vaisala.com>

Add include to avoid following build error with imx93_qsb, when
AHAB_BOOT is enabled:

  .../arch/arm/mach-imx/ele_ahab.c:262:24: error: 'IMG_CONTAINER_BASE' undeclared (first use in this function); did you mean 'IMG_CONTAINER_END_BASE'?
  .../arch/arm/mach-imx/ele_ahab.c:477:20: error: 'FSB_BASE_ADDR' undeclared (first use in this function); did you mean 'WDOG_BASE_ADDR'?
  .../arch/arm/mach-imx/ele_ahab.c:543:20: error: 'FSB_BASE_ADDR' undeclared (first use in this function); did you mean 'WDOG_BASE_ADDR'?

Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 arch/arm/mach-imx/ele_ahab.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 38e671e3935..4d4620dcafd 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -10,6 +10,7 @@
 #include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/sys_proto.h>
 #include <asm/arch-imx/cpu.h>
+#include <asm/arch/imx-regs.h>
 #include <asm/arch/sys_proto.h>
 #include <console.h>
 #include <cpu_func.h>
-- 
2.47.3

