Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF74C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 06:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FDE88039;
	Fri,  8 Mar 2024 07:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3087788039; Fri,  8 Mar 2024 07:53:54 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20726.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BA388027
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 07:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjJiJnvIgjgGx/LWKgdXduPyblN4JTMJJ9Hjq+Zs1b6T4HO4j3+WMFk+eOoWLtO7iiOezqjZVZzNPW4GYXSwboMdIf9D2jNmbOXyeaXcekw7jz1VtX6Ia9ZrPXqWpPwS9pzCHo0D03oN184CJ5infSLfWjyg0XzobvKw2n8FCU3wZY/gU4w/f9aaQyPFZ6lBC9i3A6m48RmXqklQvHfecW3vCFG3HdRcoMqcxAxMTH/K5YH7aRqe6Ee8JYZ971CK1RpjzPegVE9nhL6E4lfPVQgZkeHp7zpDYAt+smCLYIT1cgn0urWaFMEkFBszOBI32xr1df0EC+RVlJATudBqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENOxvQYyEo/tp3IYg9GVvFytmllCGDA35XLdl7nKjCc=;
 b=faGW5NLKlJGuPyK0E2+7MODje7Ils9JNCsU9nLDnGHOYuTsS9tJlbfjmnScDLNaHiAWkOKLGSzMmPrjlZgfAa1m60sLYy7lXC8DbwrFQUGAP3AF3MhZOrmfVNIQqzk5wmJTN9EXzzcdsOaU5/x5bZY9y2813q0O+/nBbrHzLQYdtiZEWClyVJiHApWv3ysXmzwu/M769QQcGcBLr1lZQDPyVTzMwgmq6H8AuXHPrfqovJk8j51FgAxIRXTm1DnHrh3MCa1ypR+494vGFgjOjUrhk6wY03Vi9+HwAsrRrHie7y2ACL3/GqPTAolpOpH285idBD9yJeXMCM52nkIGJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0784.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.53; Fri, 8 Mar
 2024 06:53:44 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7316.051; Fri, 8 Mar 2024 06:53:44 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Leo Yu-chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 2/2] board: starfive: maintainer: Add visionfive2 PCIe
 driver
Date: Fri,  8 Mar 2024 14:53:36 +0800
Message-Id: <20240308065336.40795-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240308065336.40795-1-minda.chen@starfivetech.com>
References: <20240308065336.40795-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0035.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0784:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2d60e6-37a0-45a3-fdf8-08dc3f3c7f27
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdbbd669Yk0lcZraRbEcXsAlGu2LHnKgbJft+YJ1sf2jq/bKMnTQ1OqVPEvQ3Z++9jUJmSLuPLYbb6kZHPgUQSm90oqZcy9jMCCl8dnBZ81o8OZJCWFnVe7i1CUNy1n5DZIJAnKpChbZ1/VFZOJ+Lbl9u0UNFF5+UfW5tOdVJKslLZswAp1QDznVNO3Wm6FWNYLsbLCEXtDaZvrtomc6w8FfEJ6PB0VrOh4rIaxeDBWqiSwNpT0pUqhMEwoiStxtTGtsWuPKQ7DIrO9yDp1u5UEUHqgsFl2rWbqbV9yQu8EoHQaT+6PZOX2K0BXLjfd6dVxBw7FHy9Mjq6i3IVaoBP6mAk4078ffXeDRURYK3XMxepv4BhqhuVd/Xc3HQqxG8hD6k0ats5qQQC8/uBRiUJ3w23n7i1bEa8gEFJLjKBV1VfPW5XhkSkdXxCbpmmOVAFCvsvVnvfvWMPyi+NBhvjfzk3d5q3V0cZAtga1WW9JlTEPMvexxlHiX00vZNurJYKGGNf1C83eU3WYm4uL8S18ITJLObPhmi1OE83zggENz2DQ64dKGqTdBbP4a4UlP7euR5FcNkrqPqc2mcsQ4D4L4JVUHCXEtgiaYI5V6DGEou0PSF+sNAKlyfhrRT/zZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(52116005)(41320700004)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4TT0PV+pCw/p4TXk6Ehsplu4cPGmqeHyHzLuTaVxxyzC8hPWLtkaQchZUBN?=
 =?us-ascii?Q?gccgtguI3h0vPgKPAjQyd6ox2Rk8a7LvtN5FUq/U4tPW0kiXBwITyxwYEwgK?=
 =?us-ascii?Q?0yI0Ow+ZMCN0NSizB3o8q1NlolK0i6CP6+FQtJw9CCsQQy56VU1c3hnUe7bp?=
 =?us-ascii?Q?ipNQHYdNXpcJVEpQa0owh5JXLc927c1vowxkh2ir+3uTOvAkAEfH1bSzaQLc?=
 =?us-ascii?Q?Mnh4SRG8wBEc76N60RlfPkp29UVSxdmoxhC1JxmEm+ypKu4du9rdnBtDJRpC?=
 =?us-ascii?Q?YaFlnFz0/W7X1gKJxhLrsmbg4Ww/RUd4jxSCNoN8rrQimrWweZ5oc1y3dRJT?=
 =?us-ascii?Q?62tQg+MkkyLiIEeLr+tndEDSuIPajuEVXrt5igmdCQWxPWnABMgfChtVtN1/?=
 =?us-ascii?Q?024cghhewIqWOHT9p5TpQQ/lJKHPfaKB1AxhnAusd2BGaLCuyNcNsF7MWLr7?=
 =?us-ascii?Q?SkxrrusePOp74qTppaLGdDK4hXcMvvc86g2cLJAbbK615Gy1ytYxAPmylwu5?=
 =?us-ascii?Q?qFqFWXQyrVjcAXDrn22ZWXbCDIXZeUR1EuwK+qcN/HNA02C4nu9lF5oiXN/a?=
 =?us-ascii?Q?NNsxl9SWmj1fX6yIcweqPh2BwavVgdXWmMXWSCZWnxxuelq9dHK2Ce3nNC/8?=
 =?us-ascii?Q?832Q+1pmQCkdbDXKn/PQ3K6ksX5dzUQWvm9VPnaYgVH2rOcnmbhPSgwsTzub?=
 =?us-ascii?Q?1tuvGww1W4umf7XODx4qv87ivXyHACtk/S3rrzYBHgkSwGAvXTnUimTSjd5W?=
 =?us-ascii?Q?YYWN60+eXtMN+X77x8p2P86FtCVF7qlj2OX7GZxb/pcvo8pAM3qh0qo9a2Jr?=
 =?us-ascii?Q?0S40xZiHthmxKKWQLf23h+H7B8r1C1XKaSvuvw+Vrq6GwuWXdYDKk//242en?=
 =?us-ascii?Q?UoZd1m44/Yd0RpTNK5sRP0Ukv/cT1mYl0yCQXXTs1aOxCBTXANKahMDW827x?=
 =?us-ascii?Q?NzoTNfpqbzexST6gPvJk6vdFSV+hali/aliJbg62VfWylFEXSZfjXGeOemR5?=
 =?us-ascii?Q?EuRCZfaC5221k7D1lXAvQM+rfYOSkOrU2L4dP5VR5th49uZqnHEur2qH4vfx?=
 =?us-ascii?Q?WBDuQiDu+x+1LfWaP2deXG/WMOv5AKK5MtFJ9VW/+3YYKxwyyE8OgjN29JQ2?=
 =?us-ascii?Q?KE7F9LaHz5kUXldw4T8CoxqXKHMsTKbrQxRaZADZQYLofTBO3T3B2TNLygtP?=
 =?us-ascii?Q?brBNu02jotfexDuwtS671SJ3RZ9se8aZXL4sZRtjelaSXm3LXZod4Mv//xXt?=
 =?us-ascii?Q?vhuhluakrFpOkvCJ7/QNSo/oePUM9vR8q0h4TdU0Iku4vNecTKxAGaPVJz6J?=
 =?us-ascii?Q?U4YUX1Jz0KjU+/L16raUNZ7mI6cbjRXCgAvuWAvDiWJmqobcTbGpEr2hiYen?=
 =?us-ascii?Q?/2t0HNLV61H6LQVfze7MQKJuPWc2KZHEXoPGvAquExokXYpWQjf/RaqboUmj?=
 =?us-ascii?Q?vExhgdgAB9VcFMYOUmuYC8yit7rIhspmBmMdcBP9+G4L3Vab9YjzFXb0JfJ8?=
 =?us-ascii?Q?77wPtJpPCtjI8V6rDLAEvk88spVawycLJbGSlURetOR1ztKZ0Xc49ZBxKgOx?=
 =?us-ascii?Q?F51RaNL2EooQWLxrrpuvrBby7TYg26uYBTba4xLas526U+Db/PYuNETRowxG?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2d60e6-37a0-45a3-fdf8-08dc3f3c7f27
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 06:53:44.5343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Yp6UpBdS76kDbEscGn9AaRPo6rOr0mWc55Ph+pARxBMuU6KZ4aUnCTsRyheTH1Y9m4CQmmUKUmKa7XsXnT6piM5o4TlSONSm1s3FTJvDjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0784
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

Add PCIe driver file to visionfive2 board MAINTAINERS list.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 board/starfive/visionfive2/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index 5056e9c713..d7f638f9b4 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -5,3 +5,4 @@ F:	arch/riscv/include/asm/arch-jh7110/
 F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
+F:	drivers/pci/pcie_starfive_jh7110.c
-- 
2.17.1

