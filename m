Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA99AC5472C
	for <u-boot@archiver.kernel.org>; Sat, 24 Aug 2024 09:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AA5388CE9;
	Sat, 24 Aug 2024 11:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="aJ2XxTq2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1729688CC0; Sat, 24 Aug 2024 11:27:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A078988C10
 for <u-boot@lists.denx.de>; Sat, 24 Aug 2024 11:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2oeXgzyHmoqFmeLQwjklhqrqgJQgdy1aXVesNtsSr5oBzRnK+zd3QufPLySYLi1AcMfIPOOLzisiZYViguMUzY8urGtrhkpdE4a1pGeeA+QciL75HPYoVOOQkMriY8UZEkU9ActrUXWHLeyixwVdZZHDW/3I95V3XNE32TNy0tI4vCDxUCgUHR1p8wf6gD7DpCOsqKpXkjyExPcUPah/tNtrD26GSmPJPMYv7H3ii1qRhqvySIAx4fF/DXODa8CjBSUq4uVxdHbvgFMyAyKT9lSwBe7qf+Ox9zPDC8n4HgpLFueM7ecQF8lOHu7Ww2qGJOFs02VFjwOcKmIMWFqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhDrKtJGhb+57TxmjG38iyVs/9AHNELy1ePL2KzWXxA=;
 b=zH1NPEkSsRx3B9e0tyYYFHQSE6SGcdTPVk44sATwNwubMRBhllGE6xsjnnBKcUXiAycpwwx0VRPcNc5WF/bUNm6ZpgxLgfzO4yQ+3ljO2jl9DTxC00kIEwWzuGbe9s0GuDbVjpRSPzWGtWrHy2EDIrhV5BkYY3ZPvbEeqsZGwfT0vhKmsks+WdU8YdpkHYBJ3S/0TJPgPHuAq/Zl6ENBVNQCEDZ4/2ps5UE4dPDuYh+DVG6X0AcvAIWKRA++UMRx/z1ij2roI7MFQ1nxo05vygfulvtJoybuSnGkJwD1QFZ7TyHQhzuU3cocik+9VSu5SQizcHawiBpc2BzofKLs1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhDrKtJGhb+57TxmjG38iyVs/9AHNELy1ePL2KzWXxA=;
 b=aJ2XxTq29908BibcxGx3Nrt49zM/aIeSItjO8MH20K2HiE0A8G0XCTU/O+EUh4ElFbr/S5fYLU74IzL2HZCnuJvAdQMgvgNLgYM0HMklEeGT2OViXzHhXfgSgQdejikKTEFCla+i3J4TD33PXKR59ty5zK2vpWzErp9sRul1nmx9EKSCfY51Zw5jQ383hDtuS3JGGjXcoVH0aFAftzfeNBqQ64i07glYSvGpOnBXyvOO2YEf84KHIQCl+ffh4VIPMqhVoVFxYO3GNhGtI0S14a11RJ0NK1lh1/1+BS6VQATQq2mwPApxN9YSV9EAYa7fXKiOsgrz7qHGz/wmGLX7jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS4PR08MB7601.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 09:27:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7918.011; Sat, 24 Aug 2024
 09:27:37 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v5 09/11] net/netcat: add netcat over tcp support
Date: Sat, 24 Aug 2024 12:27:14 +0300
Message-ID: <20240824092716.1042696-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240824092716.1042696-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0011.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS4PR08MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: abc1a702-a72f-429f-27bb-08dcc41efe22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3S9bLxUlUhkGPAK5wYCW7WcM+h2OLIclep6qv3Nxiv3ugqUiqkDYsI4UJJ2?=
 =?us-ascii?Q?MQlAhPirHe1OwJHLGqPKTNwihXsfUif9mDyFX7jLmga1/w+55GdoYR0pfo0d?=
 =?us-ascii?Q?DHxVt0AXFH8TOA/AJ17Lhg8Vv1er/J4m2w/xfFf3XKbmSfZW/B5lnogeA9cl?=
 =?us-ascii?Q?wOqCUaF54RtPnQ57L/+rVbZg3a51kd7crtd8+wDjdAKZ+3qPl6VNxB4TYquO?=
 =?us-ascii?Q?LVJ7JgP2a0JAKF/fKDzNYuZXYTFOROIkFztTZ5NGxYSIwrzRaWLCl3Rh+hDD?=
 =?us-ascii?Q?Ko+MXN6XjY75A44MJXdeeFKnr7UEYrIKAT9YZFdJNwwD/MgZP6zFarbfyaMh?=
 =?us-ascii?Q?fqhMv+1mluduFP1u4rYYeLL+zu0rtsAzSUNqmLzdJ1xR86IM84egR0mT2MtR?=
 =?us-ascii?Q?Xcf0nzH+hE91YWOH085Y/5idBHqE9dXDSKUlsduyn3Ih13VSg3azXqGtmRSE?=
 =?us-ascii?Q?A4VT4RMgl/HehsrvT8I/lfO3bOH8PxkXwRiQ8G1XYNcAdOxtBntBrF1ElgZi?=
 =?us-ascii?Q?0yx0c9IMo5sbDKZRmUJHIaRj1vW3RtMKjkfD+8OzHdPzDJQUuUXD+RKG16wj?=
 =?us-ascii?Q?yDGpCFUOV9g3yXbZbJ2pKtUF6QlSnocpKZFxkFH4ikGs11saUUr5eq+dPKJa?=
 =?us-ascii?Q?Yjf9DZ2U1F8KJ7kxu/TLEVg4cOdBi7FcOC41LdiCepPTgS/Sp0CwBN7qlQI+?=
 =?us-ascii?Q?+qYuj6kJbfSglPr5BIiavOBkdEns621Pl7EFQkqF+l4nAOAsRbiVOHOooqUE?=
 =?us-ascii?Q?cPMqSL2FPMJ/x2ZUm6qC8bBLQI3cJy1gCgLvbcnO/7Nj/K+veJuqPmOr2kSu?=
 =?us-ascii?Q?cYpwiehSZe5vRUQt4a9xy+QRQpzpGtjl05cJikrzzXCKqtMd3gZ1Jg2BWPZP?=
 =?us-ascii?Q?H3H+Yx3PkAjhgwURXgWYM5Q4kMWgEz+X0tPqlioYp//KwSiKChfIWcjvsXVH?=
 =?us-ascii?Q?b/eJhemmLhhWeY76wVen7XXFEabryhfBJ+HKJEcMgUEre+HF6DcJFskTEr3O?=
 =?us-ascii?Q?+mZZKsVyN9X6Jq64oK4ZfY3INrN7lcfusdHWaAV2KFTq/Bjodui8KsaccFro?=
 =?us-ascii?Q?z48rZiAFrJpJ/vzljun2JODWsmzIiS4rG+C1CN30nQj14/4npbgKRT8+7F62?=
 =?us-ascii?Q?F0TvPXg5tlKIlsnj0EqO+nPBdb5Tlr6npPft/nC/jC6Ky5rlF24Mn3dwCahg?=
 =?us-ascii?Q?jFPMA/E2CigQcguYAQ1BX9HblsAozf3mvJPoRXP8jtF1Et3jKd7mMcYZdOkk?=
 =?us-ascii?Q?3V5LhhjcXcs2bUq2zNA2hyvM6VIUqzdhdaoyO4K56o7mKoFI+jyQDDOrjAiF?=
 =?us-ascii?Q?69Fk06ctiFO4AJRrH7gW9kGEcDL5SYtEjdSwWsdEUwhNZhDmF9+lYJIB9mLq?=
 =?us-ascii?Q?cDqqxqZp2PVwb4CIEZpsL4B1spN3YKwa8VrHZPICUQtu4jXqlQl3qYxtwtZT?=
 =?us-ascii?Q?q4rgxPurCIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tOy+CTqmcEYkIOKioebbm+/N1VvYrRFqGkW8CYwHPXkhc8Zxe3YJBaSR7LLN?=
 =?us-ascii?Q?dw9t6I6JzNv4i+auZ/3b55U1jYsYUGXaIiJr706K5LUfZeH0/ZEykYMqDEM1?=
 =?us-ascii?Q?3AdM2NhzaU/wMCR6GmLhsfJLdSdjGsOZKZcys0UmPWgNdsNr0l264MEjqpY7?=
 =?us-ascii?Q?ppPfLK8dIKRT/oOj/4yMMvHb0xGvbYnEQTS7EJgpMfOhpDQrN65BSj4neShH?=
 =?us-ascii?Q?7UZQ5Gh6se3xPoMrObawY7823UUxf2Y7NB6SekJwNXPvD73w+Zqkyh9E+ib/?=
 =?us-ascii?Q?fngRAzNXnDquttvTc4ylj5v3f6x27KkhHVReV+xBV2h0EW9p0T9QJadOGuia?=
 =?us-ascii?Q?eYD+FczXw43DDHND2y/tZBNWQWp8sGzAZ29kVtsOVHe4gh/y2ypkG5Pk4+ec?=
 =?us-ascii?Q?MPTfuu0cCivxN0qTLpWiQWWYfMO1of3JZH5meKfrJJVJr5iHZeBDNMSsCztg?=
 =?us-ascii?Q?y2nrtKu52zEFSed+Um5eMIlUzUTBy/kkWB1khXAMy0Dql3XDm2GXXwuNWOpx?=
 =?us-ascii?Q?0oPh3WvYVZPMDdjCW9dkgA9bsUT91J499blPZnPwsz1nsmy97fQ6L1rimUVT?=
 =?us-ascii?Q?F8yfpcVU7oa79H5dYo0fo8oavEHDBvx29Kxt0QErb5l+3PhEimOEqlBbgRwZ?=
 =?us-ascii?Q?9LNURdxW3aZmCmXxJ4wbK4uly3A4NM8fyf66UPBSiJhdM2HnPls+MJCheluA?=
 =?us-ascii?Q?WDT0x9jpU7pcUNjrMroZ7DXrqAe4Qj8p9vQCMfpN/m0v2rZmuInyQmfGkVdv?=
 =?us-ascii?Q?Jd2RpCtD6gOkeOi3CT4cJ7MMHN/hs9QHn9MfL/hIKH55aqdznThB6zuqCiQY?=
 =?us-ascii?Q?Yento5Tqxmi8/heyXn2SMyJ1mw6BxblKy3QCGLqokAzLMYJ0WNhJJ2cw7QmU?=
 =?us-ascii?Q?axJd1/97z2pPHZIuPoZeJfLweuobrue95RQyyeCebg5kIDxzY6AESbdmEsCB?=
 =?us-ascii?Q?EUiF7wRyC0uHXxtOssUJFzq2hbne65rsb/sJfkqFfBSqVHmILoD1JFYR4N83?=
 =?us-ascii?Q?L5WT3Kcy+XUvei0GQHU5Yw+aZpYdZRQolv0upJdhND8yUID7Ts5GahWRrJ7U?=
 =?us-ascii?Q?Jq3tn/vc7CIUS8F62pHZs9NDN1y7Ss5RES1SfwCcmgVIxNLVCwrqQt4td/F7?=
 =?us-ascii?Q?DRfPOUeAdEE873xcgKqru8hkZnkwSLuhAoWRhKwoMZLcS6fmLLyRypaKUoPU?=
 =?us-ascii?Q?DCvToCtnIm7NXYlv4ncmOo2eFkGvh+0Pn5DZ6MAPPhJBPOdkgF7CCSdcBaof?=
 =?us-ascii?Q?H+F0nn/DxaThDcZedRmtYJlp8R5X++uv0ikEB9Bmw1B+gCcj3v10qqaQfLmJ?=
 =?us-ascii?Q?/mlrvNe0YwzkUDWZBYNv6dOrtX0vwVMeF6NOhUrZbFmMeYdgNB8UCSDXezHA?=
 =?us-ascii?Q?RooVfrpxDDlBwYsar5tbNHUhVRhnTvYaPu2tDiIQWIV6v6a/vHjCn4FUDcS3?=
 =?us-ascii?Q?Ewco28AaW/B2x7Q22EWBYD4M7i1Xo71VOC4D33tK+LLLbEgMdvZbLQOuZYqK?=
 =?us-ascii?Q?4gnrHNnne7Cx2HrEl5qudzB5sCw+UoOaYDnLnhIfOq3cnv63I0qdZfpbqfmI?=
 =?us-ascii?Q?F9LVILSLQ8cSU7hcbrSIqO3oBv2OFDQ5VDzZ85M/Ee9H2iXRv5quQX46uBUb?=
 =?us-ascii?Q?VywK5kRqCX4ts39EbDsu+Ew=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: abc1a702-a72f-429f-27bb-08dcc41efe22
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 09:27:37.2791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAPDvYTGR8/r6p0pPy98CoyLftFgLRuJsaPevpujXxFKPTnclieX/TCqC1pQ0UQfn9iYZ+LI5TKC0a+0JzJpUO/xtlw2TkqSlh7DAQpjrRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7601
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

xxx
---
 cmd/Kconfig          |   7 ++
 cmd/net.c            |  34 ++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 +++
 net/netcat.c         | 181 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 248 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..abcd003f7f1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2007,6 +2007,13 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using netcat like manner over TCP.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..364139ec5b9 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,28 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	if (argc < 2)
+		return 1;
+
+	if (!strcmp(argv[1], "load"))
+		return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
+	else if (!strcmp(argv[1], "save"))
+		return netboot_common(NETCAT_SAVE, cmdtp, argc - 1, argv + 1);
+	else
+		return 1;
+}
+
+U_BOOT_CMD(
+	netcat,   5,      1,      do_netcat,
+	"load/store data via tcp netcat utility",
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]\n"
+);
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +345,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +389,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index 86182cc504e..d81604a57ce 100644
--- a/net/net.c
+++ b/net/net.c
@@ -108,6 +108,7 @@
 #include <test/test.h>
 #include <net/tcp.h>
 #include <net/wget.h>
+#include <net/netcat.h>
 #include "arp.h"
 #include "bootp.h"
 #include "cdp.h"
@@ -564,6 +565,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..633afe5c60b
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static unsigned int		packets;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	if ((packets % 10) == 0)
+		putc('#');
+	else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
+		puts("\n");
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted", packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker();
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker();
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void *ptr;
+
+	packets++;
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (maxlen == 0)
+		return 0;
+
+	packets++;
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if ((tcp->rhost.s_addr != server_ip.s_addr) ||
+		    (tcp->rport != server_port))
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	packets = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (strchr(net_boot_file_name, ':') == NULL) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (tcp == NULL) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+	return netcat_start();
+}
-- 
2.43.0

