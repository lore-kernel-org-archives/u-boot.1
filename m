Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B07DC87FCB
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:05:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD1B846AA;
	Sat,  9 Aug 2025 03:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Lko9Xs0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9F4846A8; Sat,  9 Aug 2025 03:05:13 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E8D846A8
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9zyv0xRDPsJsfBgIlz5OfQraVSY88cjEJDKow675qCfnADZtM8x8xw4FRkq+g0W32utMbiDOEwkTXtt0ivFl9qJTk9Pyo5uP4WxbXBKyIb00DqLjP7Hre7YWdhlf9PiSb5YEdxNu9Ia5NFi/FRkZBOqRuo8VHKSQV385bwAA/IrE/swg8QLdJQDC6EJm4S0h+BtUbv4S3sqLuR7Gy90yxTXFjREhw7cn4V3ZWubDe1x4CDVE8X/oYbQNd5aD1r0JSrKrj5X7Tu5eGK67QpvsyUkbf5op76/2Swk7puW2cT0WvZy3YZK6vispRbzNGp0//qaOzxnuhGdBfpNA3P3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8eOx350URXDadOWUbXy55boBDIGmgPQBuzom0KjbU0=;
 b=c4f3ivCeA43jW2x+JMvrN7qXRnmFLyV/QQriCLq8OMi4VFOG1yAmtiYoF4Whv7ILuN3JEu3uJcKeHj16fmpUmeCAyTcHhXaIWhfDKbewo03liTkTNNPAr2VGIjdIdoQqJK8s++JRlLKbGeDJzeLN3grS8V/ZqIyKyqQkjimj+lpSgzA67b5etbcJv4+K6PGZX5ES5dTM8J8r7pnqaCXYA50MJmfmL//cq07o6nbN3GuWlCHV2zwUxnSjWF7m36FDyXLxEbyjZoTvDYxf+Zl9j9jpbrrvQESg5Q9IhhniQzeXfQAageMLAzZsqKVe9YxZkVk1kD8ecU6lDKoIIKWOjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8eOx350URXDadOWUbXy55boBDIGmgPQBuzom0KjbU0=;
 b=Lko9Xs0TYidvoFZ9ZYqxa8gnJkoLGpGdAknC79nwnyFvBgEcQWjCY2hhUEnl4rteKsVaYPHVzXVL5fWh72GWGcvTjproFq8eIFgcFcYJclYGlx2MIrPjzVicJUPAwzD2w+9RGxFEa8XHmUX8zuVrJUp4ycMr52/+5dS1tuDrFfYPWmIigyVesJPDODWpdfVwvIr36X6Z+hTE3H83peC0YVcNtniSYeJkZ/aVQG1cCg+Xr6xuIsBGcakL9hLQts6c7beVXuORmEN/WV0m0ySFMo04Ow9QjYKfeKAEYJsjEjTDH1gxGRD577eDtJ5v7QABwkC6Bk+FJqEofPUHFichWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 00/24] mtd: spinand: driver improvements
Date: Sat,  9 Aug 2025 04:04:32 +0300
Message-ID: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f18ba7-095d-4c4c-0bb2-08ddd6e0c65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cAyCUxS7Fd9IZVj9IbNSfUmqxU8MVaKAJH0t4M7yWmt6cBJqB6FU60mvm7lO?=
 =?us-ascii?Q?GuWir2A0AiwFWCjUzCEssv8T22UrNReTJXmKxKxP6HVTeelPCjgKA5+MTDfT?=
 =?us-ascii?Q?wIy8TsFaAwrjpazALkAnP8INhBec0nKg8A9Gq2CDKbDOJJUAqaKEOeRydBPq?=
 =?us-ascii?Q?KnnEp9n2ZxrmJWSX9HpWV9P3CiXTJ5w3J8SJg61h5WiSUEUgUarzaZKvF1WQ?=
 =?us-ascii?Q?RvqirJKSDSflckwtvCsI1zCNQME/6/J8qsgfzElZj0ctPuZNOqzMqaTLL9Vn?=
 =?us-ascii?Q?u1LvJnqVt/WDley+O5SP5SCZmN1b4u7m7FRIGMD6FdG89HRyElBcxBG6SOLh?=
 =?us-ascii?Q?TnNkEVPpA1r8+7vInCIl8pU0RRqP7uZx8inxDBg2laxj+XtpkU00qLA1zdKU?=
 =?us-ascii?Q?9CXQZmfIzGaWNZuBSOZcS95/MJ9iLMKa/HzEczgcjAdmG4lBNUyeYwe6R6eG?=
 =?us-ascii?Q?uAsXYYJqLdMeosB5QNeBGbhJMmCjoKWNIzVc77rPTqGPm5pl8w3LgVUTMtzh?=
 =?us-ascii?Q?7GbwOj5CjXmAekySus2AraW+yL2m3dl2sZoEbSYoR6bzbkU/oIvKYC7Q3sbv?=
 =?us-ascii?Q?cDJQQ27jeBtpD06JZlvZnR4yjz8UKhovgWEDBx1eanL+nVfOEysbAz5SudGz?=
 =?us-ascii?Q?UZZVWmR6mSvN32F3jkdaiBPL2MCBEPg8ASm/2EoUY7bu0fE8WrJvAzvm7Sms?=
 =?us-ascii?Q?M/MAIj36hbKybVC8wv8dCnFnNkmkK/mSQDi1ngGFSP+2ATuIwwg4aP0sBN4G?=
 =?us-ascii?Q?BjqBo6oVoJ4WTLKCIYeyn5oFVyeLf54ItrB1+Mvnp99JxIgHjyGu9HvPtIjs?=
 =?us-ascii?Q?Lu02qWOYUDuxVumEWmgljyGu4RwkjI/nL6Ows7RTr6gonu93zeJqqiVyLRYf?=
 =?us-ascii?Q?Nwn4uodtr4KWbzKOMC+TxgZX82MIWbkrmRxRqtQ5EQmDiVQI0OwFhP6y3egC?=
 =?us-ascii?Q?JdQVEiNWyp7JI52u/ll8yO5F2MfveqeDRMIzKOrbz8aBNgx9Kmz6qZ9lf6un?=
 =?us-ascii?Q?rZ+nN1BTZH4MFw2gFVn/oJg02iUQDBiUcNdKeiDp6ZQMfSekBbgAwR5xEHkF?=
 =?us-ascii?Q?c1gvSZ8aZH6hg/q7kgzOV5zAPgbzYyy6smZmJt/XFpvbYxESrgQjQOmSxWa4?=
 =?us-ascii?Q?93znI0ISzBDx80/na+BQ2r8bUYW7jLsApn5RqY/9MppNwHKnSg9axQuLDIL2?=
 =?us-ascii?Q?oIqxDeZZYzGx4Vz22AgNmY9vkfumOP6bVZt2VCn/eeOInKLm7T1LnRJPxODv?=
 =?us-ascii?Q?WQfooo0draRG13QTLUOscjGTlfk/sKf3MD8VtKeD3tr8WH/S9qp5DukOEzNJ?=
 =?us-ascii?Q?5jQ7uMPSCUycc3BRUKobiLtPQ2yyqoEeOLUifbyrRV7KcssQLJSUzQj6zB6O?=
 =?us-ascii?Q?ugNGhPaDq38rEfblTEfswYXIQ+CL0YOaHB9H7teuImHTeaLI4j0pUAUcP2PA?=
 =?us-ascii?Q?Cehgg/9UEKKnhYphlLA0DKr5odS3lx4a9j0fNyXT6ZlzpcIfAdOwhfdvJrzu?=
 =?us-ascii?Q?QWR4fMvRP/LqvkU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEKKA8tiLtnYq64453U852F7exMl526H3fn+DKrdDM74ct1CuJTBWailnIkD?=
 =?us-ascii?Q?eNomzS+OJzQ8JT+Ej0Piz2q5YAKifxiB1H5LlFegzcvbj9actoVzpnbHRwag?=
 =?us-ascii?Q?xn+NdnCgaU4r+RoPTXOiobvGmi9GIe5iuP3Nmt/DUcyiBy5uq/+KKfCDKTFG?=
 =?us-ascii?Q?b3KJl9ONkExlYdgsFrBSntUORylXT8HXCpxnKI9xSuYPcl0/L0/Om4buAO98?=
 =?us-ascii?Q?4eScOC4Lks5CB39F5Pcep86Xwo5WCHalW4UM1/S6Zpp+qzWbfHdNszCKpKk9?=
 =?us-ascii?Q?ziDhFUugom93o6WLO8WvKiicY+t2RppxrmWhRXhGhfwrOX/UzFSEdw1g+MnF?=
 =?us-ascii?Q?dhslCvmL8o+/+V/G/v5BsOxB0gbUPy9cZWDiQjtkjJ2mtf58JkudDD67gkQy?=
 =?us-ascii?Q?juDcS9aJJDH8x9EKEpHdJho2GaTnIOdI5Ok8Fw0Wzu+kxajVT6fSZZQIr5JJ?=
 =?us-ascii?Q?buAn1GJYSXK72YXgO5JysaF5IfiR4ULMhXAal2t0f0IAYZUILzu45H7JN3N3?=
 =?us-ascii?Q?CDuRWqVf9moQiM4IZJY0gkqtcGuZhLxfLQ4tTqqkBCz//JusYkIeBGmTpT2y?=
 =?us-ascii?Q?EL/SAxN4Fb5S4afgIaGO2kh1vo6KFWJtJaVD+AdcJHWwyoGyEw1hDF/j4+Km?=
 =?us-ascii?Q?9EZJDMvu4xPJHD5euKPrHyE8zbYccLbMfYZEhNsqUJ+HKvM01v3nlKZvNzJ+?=
 =?us-ascii?Q?k0EGb0LxHbWH2SHd6u4Id3StpxzxqymmOWwxcLV+krrhxixLn1PeB1YRqGn2?=
 =?us-ascii?Q?3XkMebsx/D1RQmvF9DQ0tIUVPywx/EbzfMRceesY5FEgSy/9s6PmSL/mT7uG?=
 =?us-ascii?Q?Fyoz/ObMdb9guSHQmGFWB2BR/tx/6dyiJAZi7hdSdx2MzuyZIGTbN2k+JDT/?=
 =?us-ascii?Q?i1C+fs9OfYmgIvqSgQei4+F5CtvKGBaD3r6FaeZLpqsHstldDoH5nsxbvFne?=
 =?us-ascii?Q?OxjSeC9di5nWvM+1U5ywiixM1hEyLy5+XyvAzjdI19LybjjzWoTKQLDtBFgk?=
 =?us-ascii?Q?3SvoevSFQJRbezyOZCrWMWgksfje8SLVtaS2j44Lt84JEXogm/34ExdNcmbI?=
 =?us-ascii?Q?EsMOIOcrL4U/Ff90fW8JtPtAGb1H1KTqg4Px9eVfKkyDfIztwECvKKc1y+32?=
 =?us-ascii?Q?8h6kJOTE3uEZZWn6U7qIkVRIo2ukrA9daVbKKCLlAe8NYLxPH7X+oQK9uOfB?=
 =?us-ascii?Q?FtpqEcncM89jzWnIrWaa8i7ScIE5l5jedhXIruY64SQZhCcw2+/iS+wFYHrV?=
 =?us-ascii?Q?S4XMPglx88ef6y/AcnV26E7JX9K9F/RCHwRBtFZeD4HTXFMD6b/wJzz/Pwdv?=
 =?us-ascii?Q?kyC3XyR1kqkW7RgsdzNJtSj34vmigY6ECpck6b+zz9ZFOSVGxmjwTEhbX0sA?=
 =?us-ascii?Q?XBivI4EUbqopxEcva32H5a+Y34SFlqj2+Tau5SsKiyH5EFf/i6DGICxCjLs1?=
 =?us-ascii?Q?3Be7blkv4uzLdA2j32DyXdrCO3CZa1Rb1Z+Uog1zR0XkOLTwYYiioRpaBogL?=
 =?us-ascii?Q?01dPEhfO2vLTsAX0w5TyiDfPVonGc2WYcTXVTYE6r2GEulmE7BV5DjEMxGWk?=
 =?us-ascii?Q?Q+5wwTTg1ghOjuUVhyuJM4AqJvfdT27EGUS2VgKBM2KsJ51DzE53Q0VAfVZW?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f18ba7-095d-4c4c-0bb2-08ddd6e0c65a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:04.8020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lubiaxiEfMCgo5JxIsJoo7GTq3YaBTIjBJPaWlHYy7+MXJ5eIm+Q3j/niD4vGJmdKBaNJM2ONFKaWEm3ycGZXHD2+L5CH70bboPTKeD5hlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

This patch series makes u-boot spinand driver almost the same as spinand
driver from linux-6.17-rc1. This provides the following improvements:
 * it becomes easy to port changes from linux kernel
 * more flash is supported
 * spi drivers can accelerate flash reading/writing using spi-mem dirmap API
 * continuous reading mode was supported
 * OTP support was added (for some flashes)
 * add support of special data recovery reading (for some flashes)
 * bug fixes
 * other minor improvements

The following linux kernel driver features was not implemented
 * support of different ECC engines
 * per operation maximum spi bus frequency

The patchset also includes fixes for continuous reading mode.
The similar patches were sent to upstream linux kernel.

Changes v2:
 * update patch description
 * add fixes for continuous reading mode

Changes v3:
 * fix duplication in patch description
 * add more information about commits ported from linux kernel

Changes v4:
 * the original authorship was preserved for several patches
 * the code was synced with the latest shapshot of future linux-6.17-rc1
 * spi-nand was replaced by spinand in patch description
 * continuous reading mode fixes were updated

Alexander Lobakin (1):
  mtd: spinand: core: add missing MODULE_DEVICE_TABLE()

Cheng Ming Lin (2):
  mtd: spinand: Add support for setting plane select bits
  mtd: spinand: Add read retry support

Daniel Golle (1):
  mtd: spinand: set bitflip_threshold to 75% of ECC strength

Gabor Juhos (1):
  mtd: spinand: propagate spinand_wait() errors from
    spinand_write_page()

Mikhail Kshevetskiy (15):
  spi-mem: sync a bit with linux-6.16
  mtd: spinand: Use the spi-mem dirmap API
  mtd: spinand: simulate behavior of linux's function spinand_wait()
  mtd: spinand: more use of spinand_to_{something} helpers
  mtd: spinand: replace enable_ecc variable with disable_ecc and update
    corresponding logic
  mtd: spinand: minor refactoring
  mtd: spinand: more refactoring
  mtd: spinand: sync code with linux-6.10
  mtd: spinand: add support of continuous reading mode
  mtd: spinand: add OTP support
  mtd: spinand: Enhance the logic when picking a variant
  mtd: spinand: sync with linux-6.17-rc1
  mtd: spinand: fix direct mapping creation sizes.
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails

Miquel Raynal (2):
  mtd: nand: Add a NAND page I/O request type
  mtd: spinand: Add a ->configure_chip() hook

Takahiro Kuwano (2):
  mtd: spinand: Remove write_enable_op() in markbad()
  mtd: spinand: Introduce a way to avoid raw access

 drivers/mtd/nand/spi/Makefile         |   5 +-
 drivers/mtd/nand/spi/alliancememory.c | 155 ++++
 drivers/mtd/nand/spi/ato.c            |  88 +++
 drivers/mtd/nand/spi/core.c           | 983 +++++++++++++++++++-------
 drivers/mtd/nand/spi/esmt.c           | 123 +++-
 drivers/mtd/nand/spi/foresee.c        | 107 +++
 drivers/mtd/nand/spi/gigadevice.c     |  86 ++-
 drivers/mtd/nand/spi/macronix.c       | 289 ++++++--
 drivers/mtd/nand/spi/micron.c         | 180 ++++-
 drivers/mtd/nand/spi/otp.c            | 369 ++++++++++
 drivers/mtd/nand/spi/paragon.c        |  24 +-
 drivers/mtd/nand/spi/skyhigh.c        | 149 ++++
 drivers/mtd/nand/spi/toshiba.c        |  63 +-
 drivers/mtd/nand/spi/winbond.c        | 361 +++++++++-
 drivers/mtd/nand/spi/xtx.c            |  20 +-
 drivers/spi/spi-mem.c                 |  45 +-
 include/linux/mtd/nand.h              | 157 +++-
 include/linux/mtd/spinand.h           | 374 ++++++++--
 include/spi-mem.h                     |  93 ++-
 19 files changed, 3160 insertions(+), 511 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/alliancememory.c
 create mode 100644 drivers/mtd/nand/spi/ato.c
 create mode 100644 drivers/mtd/nand/spi/foresee.c
 create mode 100644 drivers/mtd/nand/spi/otp.c
 create mode 100644 drivers/mtd/nand/spi/skyhigh.c

-- 
2.47.2

