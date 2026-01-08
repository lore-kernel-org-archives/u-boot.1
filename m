Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353F3D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71ADA8423F;
	Thu,  8 Jan 2026 14:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TzZn9xO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5270F8397D; Thu,  8 Jan 2026 14:20:58 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE0383952
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:20:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGdvb5WRjBS+oIVmyrJ6AAGq7ad+2PLQbXRSspAWN24e169NTpqHBe7c6hJQhb7PlMHi0CL3uEYMAjS3Z/RhJUnMxVq63ZSOFGc+arabWQ+XqpMLLebgCsg+vO844nNbKOn1mIbBuky+FE9g4L3n8Axh7Hijb9wjVt8P/uH66PQZxoTw0W86DfChK2E6jRHBoMFp7v0EbIlkD07drXijDSzps2VJ/eU789uyIhXXm2CJgpjJhy6GZN8H+QwLgLx28pmPR+8DHjSqL3UNhYJStLtKjElHuysBH69WVSKGm9c1EnKBRjoLcP3Q5gvC1vigtjVw9pVNkSPxTgL2fzw9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHNlmlbIfZlxEddvkgGwL0BuCgDe0g3SWPpdMjTTRp4=;
 b=hUF5gHXs5owed00BL0crBy8jd17syRiZXhIvVRDF/SMCCydOtPt4Om0Mt0w1kw09nHBz3IiqWHZLvHvSZnZYJc2t7s4sr5TghPZ6s7cMmjK/wFlBcqmfVpIOBg8Kuur8d861gR/Dmogo8tv8it1QKcB+GZ34DWqxfKCwfQczrAvnX2kP3JWtpRhwqw+bzL9rEuhJXMaL7LBQoOSSwmeuT6hdvX2us6ISc6menyQ1CGZ9hX+o2i2/JcwdeObpHXjnqIzFwAYMHKQNvHY9b25jUVeE9mSnlaso4XxsQ8CKBkbvi28vhXSgu9SxQfUgCIs04/4eyXrbpF4Q7m4re+d+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHNlmlbIfZlxEddvkgGwL0BuCgDe0g3SWPpdMjTTRp4=;
 b=TzZn9xO+ZSh2PhtsYld7Z2FjTXFYEMI+qqlZNDtBanyQ9kzI9HVf32TwiIOWv3noDuN5IBXdo/MpPuMPwL9ucpAooggpyZaYtiKZMUQHB7V2L0We2GHRietkoHScac6AFP4nDoU9eqinyJ0qUJzVYYG8GCzZ325qrpBgwJi+AKILW4P4GefyruEYfOY91qMIVFCrLrGLr4m+5fy1AleOpJuggjnxbLlQak6HfXyFaqss861KgIAKYRttMoXeyJYUfvTtAzGAUjKnqbdgWb6woXCFZlBukP5MnB3uRIY/W8FDlkRLJIKaDNH08dIkk+6dhlpzxl4uwLclek5sbYmWYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8419.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 13:20:54 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:20:54 +0000
Date: Thu, 8 Jan 2026 21:22:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: mmc_spi: Select CRC16 if CRC checking is enabled
Message-ID: <aV+vk7VuRBtj97Wl@shlinux89>
References: <20251227105946.332061-1-daniel@thingy.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227105946.332061-1-daniel@thingy.jp>
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ebb515-c501-42a0-d331-08de4eb8c069
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FoKojJK1c7Tm6smLZbeH1o2/3elNYgVs3xRxERVlEA+VyoKPYrEen5exj7AR?=
 =?us-ascii?Q?kD2Ru8zPw7uxj3yHJ7uR8TiZPYyDtSBDrtM/FIr4V5LZ8zTEx/p6Gwmyo3lY?=
 =?us-ascii?Q?Qina0D+EA+E2KF7b3RfWCZ1FnFBJfhWw/w5j24o1l3DN/4ETfMm1Bn2e7pDD?=
 =?us-ascii?Q?Um2Y++KTmrfWQ9YGqSxsqB8BxjsG0Mxr6HPP71YiRXc2A7sLTOZEkZxRfGdq?=
 =?us-ascii?Q?QhoDcixs1f5+oQDYUCo5dX96q+TbGsOFYdRohOd6fhYoMtgQXp2rxgfIf1Kq?=
 =?us-ascii?Q?i+dXLOA1pbGC8n5HEvcyAAJN8kMgF9gcjZLZc7bKFnakcZtDZZxGEIvfO9Fg?=
 =?us-ascii?Q?sZXQl+KxDk/qNxBWcznj+LNbY2WHmPNSuAAqRzR7EHQ7k4Q7K5ioJUlg5CbW?=
 =?us-ascii?Q?tT/uu1gCEtrwSliH4DY5ijq2V0VG8K2bTJGukMM0w893eGepQkGtSPf0LK0W?=
 =?us-ascii?Q?8tDtevdPCQZs6QIdiEpe0+ynYSgJ+NIj7Yehk6VfHMDrepAfzP6rXE6GVeCf?=
 =?us-ascii?Q?gmykhw1c1j2/vcUwKie88weO/IAeVVJLm++hTudGjDBvrhbXnsP8KKb/DTlf?=
 =?us-ascii?Q?CIAw4JPikY+I0QUwh2Wf+qU1LnjpgXh3IrH3SZPwvseaECtGbU7cXqwdgccm?=
 =?us-ascii?Q?MrI2nQmZyaGLoB0pcSwOhrORJOJgLJiuFbMDpuzq0OPOpXPECVxmr0imYTxx?=
 =?us-ascii?Q?6KTDn74E3WIuPZTccPV+4KNZ4z50E2Qs7WtbSbfIcIlPW/4ipbVW0AKRJ6su?=
 =?us-ascii?Q?BddZvOadwx5me9S3bxJmaq0jxIj53oWvJikFuD7aFWuZ7fd9FSzB1zsXaLyk?=
 =?us-ascii?Q?BndaRpD+zuWq2PP/5lFIADscdttt2SEsReMhiJeHYYYhDRV9mvurNNNoPyNY?=
 =?us-ascii?Q?BCL/v9l3KPzhCZn85/g4roiMNqB3/xn+j9AfxBvJ9sJ5E+OnDeJmUz3bJ3aS?=
 =?us-ascii?Q?axILfNi+6M+9szzixjDM6hW00Ayh3OltTzOyVDCUipHqZYiXBN4CJWkCdLtx?=
 =?us-ascii?Q?dEN08+vUTa2zqlom2jhuX4L5lNy1/6UyXXOgmkb46SG/8GJxq0gYRsIEkXuJ?=
 =?us-ascii?Q?ALKxFBp0wiJWIcOvCfcNX1vtgSCURKccWOGt2OppKmN3f+PyQAyJlh4Ss6cL?=
 =?us-ascii?Q?gd/2oYCypkVTHaYKQiCLJwYRtX28XfEoTvP5q3XRwrAsLZU7vBr9ezWwznU4?=
 =?us-ascii?Q?VS791zsjCGfamrxHjcc17w8NxEny05hi74cYvCQfbMFGy6xHx43Hbfnk3VGL?=
 =?us-ascii?Q?OHog+hf9dkArTcEqnz3IHXdD2R6QZMfxflm03Qc1np+LmBsR5zqpmtGdQ5gg?=
 =?us-ascii?Q?84EVXRrqjdcezzb80PbY0tjuHzOk6qdA+DQyd4fSut+bkBMJPCv8B7DfmE9L?=
 =?us-ascii?Q?4b+u8B0fdQDqjblYfs9zAHmt2xrxxkqidIWGRllp31PsEagwvFoxG4MIX/UR?=
 =?us-ascii?Q?vtHgf7Kyne1R/e3LKDxIxgWYc7iOpYDCIMiXod2hvfwuuPleX4E6gWI7j1SE?=
 =?us-ascii?Q?5QgYKTvnPqgp5CEX2uzGFGl6eEiT5FGhD6Qz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5W8vTNGM/VmOOLY5HwNSDN3XuyvaR/58cOcaUZDZ3xD57z+0O+8oS/1W4rnk?=
 =?us-ascii?Q?YBiHS9oN2UHD74MT8uTm/vyt/hEIR4Mu/RizCxBQ/HOPiY41OXdvOgcZQmNX?=
 =?us-ascii?Q?bH6D2/Qf9BhKZCEn34DNz2O/Tk0zaxc7a3W6YxyibuqjWZP7joYjHyogsnkC?=
 =?us-ascii?Q?TuHD80NacNOlRxgENdpPv/trmlE5i19k4YDaPiPpFKb5O4wIadh9CWzNiz8c?=
 =?us-ascii?Q?P18U8Yej7I7fHCLQWS1qYi6a2BQC0t3DNmef7fOV7VVQwSw2/VhBIZ6RouNj?=
 =?us-ascii?Q?KMdVmQePhfuCgsJ6VsPXbtKmGrAJjlqIvpBlhQ8jHpAzcHEJZ5J4ardKNJjo?=
 =?us-ascii?Q?s+znP4ztReKQFsXqiC6OpBTAmf8GHVUC9dgg3dgtwi3+yuS4Ih1UZkM9hedu?=
 =?us-ascii?Q?BcR+jUv1zUkGcYlIUTVFjRrmBA7dKdLz+YxMhBaopbRagAFUOelTL8IKTLXU?=
 =?us-ascii?Q?2g3TApCvwDBGbhTOrLcnT3c9LoEQGagiJwrCJwaNKGqySrWL5ZjI8GDVnfpv?=
 =?us-ascii?Q?lKlVxqPb4NN/ixA8jV4jK+wZGf0H5o1E4V2u7JwLpnJgqj/W24holvBtCN2Q?=
 =?us-ascii?Q?xRwPaaj3TcT2ysSz3w4HtTFTWLHwO12Ypzi6IZkZ3IZDdujYDyxZHGOiUDrW?=
 =?us-ascii?Q?7YcJpMUkxC1VZGtfEncnm0ckOM1KkMzVevfV58cmyinxHPohzXVLctDnUB2B?=
 =?us-ascii?Q?JVkphcNiMszWlXwGYNgdJ3DPy5Zw82XPL0pnlP23LL6fKBaWBmFr9kkzm7ko?=
 =?us-ascii?Q?ZRntQhLk3i/BA+mopbdJLIE6cRywVGVw/bgQ+S7qlRYFIgugY+PRF/lxqhFH?=
 =?us-ascii?Q?I8LeX6ArCeUof2ehQb2BLXEY3t592Z7m1N3eFHYUpZ283/zmr4Yv7jT1n6oI?=
 =?us-ascii?Q?ZGntriQvzG5J+SKeD9+UrS7ThCWF9c4RUnaJQQtymXkc3VmzTAR3w8/w+mN0?=
 =?us-ascii?Q?Bol8u3mHpSpG2o8NoJvzrIPaBndnLLNgvIexYViVSy0EYV5eimNtKLXVsSkQ?=
 =?us-ascii?Q?jzclqPritDo8PBvvjNXpB9tgqT6fL7v1Ucmn4vhBVwBE1ZkAgwl12gby6ITA?=
 =?us-ascii?Q?F/ISFt9GcWJi+O0IIXErW8hYokN/13TbvPBABLw/AH7/Y7W3vGlQwEGvGyv7?=
 =?us-ascii?Q?BMrth5chP3avim5GFRBFgZR+mTraeYSr7BiuWn3e+TtswkOHUtflVCcSHldR?=
 =?us-ascii?Q?h405Q7QIaLSk5/nSksgEbLlrM9a7hzcjJ3J/tONiRLBQOd36NrVEoR9S7NdD?=
 =?us-ascii?Q?+gV5xS7l/7iDTjHO64FgHVo6pIL1p3+LyvSQkD/jWHjeS7LFmVauxFVNrrKd?=
 =?us-ascii?Q?kuKzDTHw5zKfiour+26fdxVP8T9trYUma4VCSO6SRmkjOLwjMKF7Ine1hpTf?=
 =?us-ascii?Q?0ZJbYjxp6GldFX7P4eE9nGKDQKI0cL8XaxR0AAAohJdnEzozhUmwapPGLP1y?=
 =?us-ascii?Q?Pl1hC5/4DSOD6uLjGPrcGqrxrLAS/aVzYtDwgbePdb5r6FHyGWkxm4v+UD+1?=
 =?us-ascii?Q?a1+EmBQfG5CEOqXWEksy7iP4cl1Be8d7ONjK9xYhwuRJl19V/klgXxidjFGh?=
 =?us-ascii?Q?xNirJQfxuRsMvI/yNyTMpsJJCJlG/vV1Ob9L2tK1Mf7fugG+6LZK+mJphHxP?=
 =?us-ascii?Q?tYTJL5BjaEr2tmxSxKgf32MSk4MupmrdwEZrkdao9GWH8mXLya32xZ42RMox?=
 =?us-ascii?Q?1CYQCJvjTF9QzxDck0XzHrKTIGcTOC6VeZ4PElYfRyGRveMmPjFbbs9F4Z1B?=
 =?us-ascii?Q?/irqISYjdA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ebb515-c501-42a0-d331-08de4eb8c069
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:20:54.3384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOP3893u2ypv2pohXInzQZfqblZDJgci1J+nzihnJW+X/pd69zqxm+WypUWG09XCld63qLfEhD0dO11fcyszvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8419
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

On Sat, Dec 27, 2025 at 07:59:46PM +0900, Daniel Palmer wrote:
>Currently CRC16 is not selected when CRC checking is enabled and
>if it wasn't enabled in the config otherwise the build will fail
>because of references to crc16_ccitt() that doesn't exist.
>
>Signed-off-by: Daniel Palmer <daniel@thingy.jp>

Applied.

Thanks,
Peng
