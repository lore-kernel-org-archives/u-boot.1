Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F887C83F17
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D943836A4;
	Sat, 19 Jul 2025 02:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="25qEI2zV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285E7834B6; Sat, 19 Jul 2025 02:57:49 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 429EC836F0
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu5Tf6IcmLUX+9SZaOqqLO3A11p5xzL7eVtXHdbfBTtwcXPaZ1pcsYPpLoQNXk2L1wUARHUjTRVEDy2u7Bq1N2uX+p8dHL1vdLdKEK8eEqvgeyknAcQwg0mehtPwoOzODJv+dkh06iqXGuOKYHhnkZjbi2JI+cqn0HfdU6SHRwq7WJl5O/ceOM3dhJoLk0rSDreQN37gmKeT20FpFVrsBub6enTvd0Dv77Vw3bRyoYDsierPHSur2W+1KgbRqSSBMi/rCOwy/Y5NjP5IZIRrjMBQIKU5bFIOEd7hsGHQDRzbU74zS1N5kroSgLNXe9YqQggrmTs3EFzz7ljkuPZwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLHLugZGxtGAswowiAdraZkVKYWAEVJa1GtiAri29Go=;
 b=lbAl+fnbo8cyHprv4XKusIydCzCq4ZR2co4oSr4sJokroVzfExsSFvwTOmNaO6FX6QAdiuFOz2f+G1W/V8uMG25E+trFqhsKUS9rZw2bkFD4Yvk36wb6o8eFNkzueXyXcEPGL8o5CHOdCmt5uyn7q0TGR9Pm058vG5FDa2Peg9z837hbE3KCFy8v1AGxG3ReJ8IXV23FVrKgVCwX87AqXdEaG5A4kHiNrZnBRE315Q9orGeP4gZ+C0xT1oS4dVMKxDk67JLTFlhmOBZ/CBa3VW0rTsuNEJWscP6nKczmdT+6ewDdAth8hgUELgyaBjVCPScJQMZBuqcRKSER5pWqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLHLugZGxtGAswowiAdraZkVKYWAEVJa1GtiAri29Go=;
 b=25qEI2zVxOIyiKVGrNBj+hlmN+JRJ/5nJ5SRRd/kZaV2XPeYN7/s91/kGLsMD708tdpUCP+//KLHn4ioCdsxmrAqn9Omn/CReexS04jgNft97uBfGpJlMepS/2u3Xo3PAzD4gYVkIB9IsN/9uyhewacT924phfhAuoZ0LyMP56Lqjmr28XtkD27oOP7niRcbK7GhGsoZjsUljR7J7fKK3bPrYEXrUKGfmkq7bemJamT+kUtJb1EMAbHi8qWNq2LRABF5QxBq0YU7Q3SN3qqR9X/UMzMVVcToPX2Dhf4AtuDExTlVMiVBkN9rK4FXrxDMJFX13ypWs1dv4yW0DXY1JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:45 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 5/7] drivers/spi/airoha_snfi_spi: add support for airoha
 en7523 SoC family
Date: Sat, 19 Jul 2025 03:57:15 +0300
Message-ID: <20250719005717.113842-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: 7159a359-d9d1-45ab-bcbb-08ddc65f45eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LhYWz7A1m754N491DHPxzXafNDY0qA7BOcjjjLKAi+sUKZuSLrOj1Pt0Xfs+?=
 =?us-ascii?Q?5jFlhq9fZw61+5GdOTgaMD+Y+pbNhaujfKODzY2yHpW3DNeynpWxA00tL+Ri?=
 =?us-ascii?Q?JgvQWS+kq7RbcIc+nhWsYsTHHIn28/IUWsbHNz478k9aKBcdSrMjYLhbC5sy?=
 =?us-ascii?Q?7ROBRx8YNXADzqTOBAC+NUjZSNd/Kd0U2vj0VpI/ogYsmC5xYJhOJkE+9lVg?=
 =?us-ascii?Q?W2pVa3Hdb+2gFBnpfMspgdjUSQSHOkPZ7Eol8it67tR3MOX4w2sT4k9Y0meo?=
 =?us-ascii?Q?xIkRYpfmYpbTeI9lNucYjkj/ea+YozkvJI+uRYvYqdZSm4sdJSIKsx9SFxL/?=
 =?us-ascii?Q?S+IbveadmjnZHhOgRuX85UT4S9rsjnHcZeiFjXjefJokwk3jF/Y9nnJ5cNXi?=
 =?us-ascii?Q?kmrpGj9FIaO+qmPgiemCaNnbl4OdCsNk31bMouyH9RAhxRcXYxESeVvOPYNG?=
 =?us-ascii?Q?422gq3V3m+PMi96ctnErxLu00hWuoAgHrcf9DRjCvbEzJr4wiainqnFWsz0M?=
 =?us-ascii?Q?GEJH0sxtuw1NzhIV4wlCxe6lSXTuMOPcYNp7RLzeMeaZlvZL0ADZmBopkAxw?=
 =?us-ascii?Q?OJHSE9jlSTZ3tvphTgxNhD7wyslUKXLoU3pEDXM1Vs8z86Lq4m8J2Y9YHlbm?=
 =?us-ascii?Q?/U/CyhefGVfjSThCph9mtDTQrknYxUCPGW18DIQmNZVDfTojCccwVgRWgcU9?=
 =?us-ascii?Q?GxwggcnGQQJFzdyvmm0tExETsZb8dpGJGgH9FsyFakUFXjD8UgOmwBviLqbF?=
 =?us-ascii?Q?ipFeDLApIWRBDHw4limiYVjGBBcas8y6nS4PniQUQBJmNhX3YpffQoor+dZx?=
 =?us-ascii?Q?lp7UbZsI4LDs/4FRJjNXl2Ba91Kx7I2hUyjmM2MRMY/4Z8v21CtS7fRva6fp?=
 =?us-ascii?Q?qpaLC2Ffo5OzP7CLzDcLCtrJCqA+8dH8bnJOYzMihMAkFygyDrD6DfiXsNRq?=
 =?us-ascii?Q?R9paIsZM+TKzuc8+qBHf7Kk56fqJKJEYg3FqRAwUWVGoz4oSjns2YhOh3p9r?=
 =?us-ascii?Q?16lNPeSFY0E68bGn0rRxTxfU5qs5+yXRjR6jk9DKxJeT7zstjArkcx7nsdbO?=
 =?us-ascii?Q?8DOzHmQnSONug47TZLebsdbTjmJ/Hjwsf2x/N3ALnuEtPept3aqnR6xmE5SB?=
 =?us-ascii?Q?DinOXd8Rov5cK0C0Tp+R2OK1cG38MwVB3/Ve3muL0OZLb+/zThP2A5ag3Uc5?=
 =?us-ascii?Q?p6AsQoKYgJQaXjMXjjjtIdMD0leLR3L6ekAFfTNjHjQdSe+WT1JziEQPs5Fx?=
 =?us-ascii?Q?La58c2po7SaqhgJ9CpfI6mt9usanJ6gBXpwJ3N/rzUniURjkfT6tolXbRfxv?=
 =?us-ascii?Q?hevHse/oIoGgL+s4GjovOcC2jFAaZeDzyit/O30D7CAkkNTt5apR4ehcb0wB?=
 =?us-ascii?Q?+AW8lwVN1Xog95RZ5LSM3qoTA7JZAMsSu+QLaTWl6dbBlCnUpTQN1jk6Laz2?=
 =?us-ascii?Q?r1/3TfkEn4AOjc4tvUGVXYiUK+jDOi05MFhP6GWSbrNA8ArlSoYolSgLKKJk?=
 =?us-ascii?Q?8XRNIohetUcCPo4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pY8dLqFX6szECW5ZNH+FjJYYIVh2vULYjEY7qto6s2CdMScTIPuB3JOz9Jgf?=
 =?us-ascii?Q?YcV1VaQxFJ1pl3Lr/9XDBDqFPPGudFuuwTyT9SWmn5hwUkxdMTHHQg+Zxq2h?=
 =?us-ascii?Q?/rQVFKmj0F0idWemT9+au7M71xd6BtU1gG07LqMPjESJHRBLITSO846Eqs0D?=
 =?us-ascii?Q?Jh1FWJ5i+aDVmSxYPG4zbGqy2ljvDpi+yh/8yLuYHwwSWnZIw6NunL/fCWJI?=
 =?us-ascii?Q?EeS537TnIGlAo36z2HBdcoZACySUhLt2+YTogtIgHAHweeslV7OjhRwhzM3i?=
 =?us-ascii?Q?bG4GvWgwUgOipYkzUgDsLPs7BE2M/iJNxwHJkO7IF6nT63i9zNr2kT2LyHnT?=
 =?us-ascii?Q?jIJvaQ3svEamSFJO8RanLwUsbTn5T2DdD7X4DfRcKzR5AN09HfzNASYWE49S?=
 =?us-ascii?Q?aj6WGBnG4QcZUvvwmW3/eiy6zd8H7WEsD/ejywEkf8RwA4IxHHivtRge4x4Y?=
 =?us-ascii?Q?4bKnmyShVo5ZgVw1iKXaMXqVjxDafuV1dSlIv04gapgelbUvoWLWd6O9vV3z?=
 =?us-ascii?Q?+qR695+9iOuL6jKmlnZka6bMtsk4PByrdItsvWewQtBe97+RYNGveXDQT5dA?=
 =?us-ascii?Q?diqIbb+U6aKqY8qTzHUWWnRAyvUOxRDXVLBt4DoOzQu+95vkys/hFiJO34Kg?=
 =?us-ascii?Q?A1fD/H9vjAZUlJ6gZSsZxiYf0rHCNsXeepHkgbHqwaWExDCxqRXP1iZKqIEX?=
 =?us-ascii?Q?BPq3F9kQWLV1E9d3LGaijvjPOS3/adl9H1EnY26Xdfl2jQ2oLEGsoWdRx0LS?=
 =?us-ascii?Q?BiJFfgCF0XsBia8r0+BsUIhOE/ctSpzfWsfH1zVXRqyLRuAib69/Y6AQNgqj?=
 =?us-ascii?Q?yU73cOpWee9bQFSGGktE8KPsOTJXfCzJGFrgS2fYHCk4D3cGEDz/5i6JeniE?=
 =?us-ascii?Q?DcpIT6rmitdeYKZ/F5NMsVijMCTUFYe7xZTSUOBjSJ07ZSaASKBmG+NprBrc?=
 =?us-ascii?Q?jpP3BgD9RMZWipoC1e0EDwj3Hsl4dW7NxSwZvuZyNifLI3xFQY0kZOi+mLcP?=
 =?us-ascii?Q?FXRI9PvzRdx39clEDa26sxMIhRS26UN8RFBZBaHWCz56C+LQVloHQ+sYHGyF?=
 =?us-ascii?Q?lD1DK+iN5icXYfLrmT5nt9JuUaNt7+YVcFzaWbOKlck8jNzZtWEyIEI9H0aW?=
 =?us-ascii?Q?rG2AtZigLGj+udMSoxFprZjnUzoawilbPA1YJmgn4Ol7rR0IbmaqKPGGlvMn?=
 =?us-ascii?Q?kWXnR+sXhnFD+NriQImOy7KxA2Nft3hW7pUfqaqnLroBPkUjHdywPFPvbkOr?=
 =?us-ascii?Q?aceORA23r90/TsRPUVA/PIU2GX6+SrytjuGe0Nz+WWgy8MV5yIXT7vOv5OnO?=
 =?us-ascii?Q?+6EV+MQQFNEW73ICPQf/ohmUx4yff9WK+SVnS2eJJdDdeNlsOa4UwL4i+kH1?=
 =?us-ascii?Q?Jj52j2nJlWTly56kg7LHnrA3FCybu49hhi9rd6FaoAbGz/3+/tsEARUj2/Wf?=
 =?us-ascii?Q?lWQ7OG4/f6g87uzPY+j7hP+SHRpIhqRhu7hrvkGv29EACMewfGc07tQ8MsF3?=
 =?us-ascii?Q?ioN7CV+FxOLdiK+EMnq38IxmY18odZiRfCTN6xgdN1WB98MRXZrRaAugfnNM?=
 =?us-ascii?Q?g5A1z+OH+R+Kih87HV4FH04BqqAiG0HmXs6l70hWUOthEjW/DzeNXZSUWh19?=
 =?us-ascii?Q?If5i7YwC2NduMSF6XcvbrkI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7159a359-d9d1-45ab-bcbb-08ddc65f45eb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:45.6891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dJh0+WOGeTGPv1IYUP3b33WjcOzHDNgODsFnKu2KmNzS7U24JQPH4YuxOYbR+bT6SFKSrW5IGdOGP9mz+rLGUC4OJxMYeAWPF6agg9tZ5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

This patch adds support for airoha en7523/en7529/en7562 spi controllers

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 3ea25b293d1..8a9f72c7d03 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -704,6 +704,7 @@ static const struct dm_spi_ops airoha_snfi_spi_ops = {
 };
 
 static const struct udevice_id airoha_snand_ids[] = {
+	{ .compatible = "airoha,en7523-snand" },
 	{ .compatible = "airoha,en7581-snand" },
 	{ }
 };
-- 
2.47.2

