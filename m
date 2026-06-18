Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72394CD98E4
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 01:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2ECF847C3;
	Thu, 18 Jun 2026 03:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Pq/1H8zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A17384874; Thu, 18 Jun 2026 03:59:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27FC4846B0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si8h4E+lrWPeVZa9fotRhDpZY06QAY2unqSpmJa5bvGrcA1MCRbHKogoKNVd33uqgaP/IPGzHx+RD7bXqe75S+RqAbukY3TQFpe6L5SU844HMQSWHKjhRB7njpBMzlgKf82UbnKvMtiSaSUQEhfSindC62xT7KZgNG0GFer0N1U73f5m3m1LDphQECz+F/xqzzyR4CGavECwedAE/HCTwWmMlXimwK6A9dkqq5UHwMpB5EIfAmKT+r/4+5iYztCAJyP+S+X9zU1bXLQdmO8lPErF64sHKAWdW+f2Gc75KzHcctNUdsSTrNN9iz2/8z+AGep7eaMZmFM47lv9gy0v7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a218sRD4z2DfpwIM/YtkARzC13Bp4FIskOncWyTBtTo=;
 b=wJenOoSdKnvPiFwoyR6RSwBoR6B80ZWiuoZB0uZp30BCJaIgeAJUqLnAIqxrRW+f9RzWvavOatLr2mozphURxTtiuNcVfnE4AMk5/XKR88j2bCLK3Zff0WuVSbNShA434BrV67X6pwnlgv7BwP/aQTx9N8GpQ3zrBAV3+oJ8YVsr2AG9jZLqwMwGy9AoYFIQVCDsaSMAvosi0wFCSEUOZkb9lHg5iXelojqqlYxS/xG/sPSvOVk56l93IJAoSVGV/GRP6OkEhAD2DwbQOiyjZhMievo1DThZi5uZxPQyDmOlvgZXpriiCJT4WkkRAyMU8KdiywCZIFuylgTrpComeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a218sRD4z2DfpwIM/YtkARzC13Bp4FIskOncWyTBtTo=;
 b=Pq/1H8zOQrYALBhWcibUXgT/nsR9c1HOYvKihchdL1oLULcaLtHP2RgsbC53SYHPOYQRnXH6clJwG7jqrdyIGUHMKSGTA6rXwAxYA2iblny6JCoeysgxkgsnh1bN+KlWFUqZk60Hcp0JWnO4XpxNsW9iKBiIU1gYeGUBogULwPAq2UqzPpKphWkP+tPXu/Q9sggGJ1heD8UjJ6uo+Pgp0d052ZE/Yj7xPlDgaIOp/xwjU6aaFhqWnCuZQfjp0+y0hfIA0kpl3b8SEUFBD05Ff661UW8tCXLSoG/wKOL0XaFjfkWp7ocqSv1yJFTwZa7J2uBgUCv3dj9+uAbUcS7u3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 01:59:38 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:59:38 +0000
Date: Thu, 18 Jun 2026 10:02:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
Subject: Re: [PATCH 1/3] imx9: scmi: Fix SPL trampoline buffer for 1GB DDR
Message-ID: <ajNRzj9jkKH/Lwhn@shlinux89>
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618011749.2871269-1-ye.li@oss.nxp.com>
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 5531e5ca-67b7-40bf-d953-08deccdd4107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: qvF1Kr+oind4zDQqwGVpsSsCsx5/3a25Y3wjelQ7qlO7FzujdzlSZffUq8r9WQ+I4RML5I7iOuIqoTyaRSQkyxq8R/DUsjmjc7FoTiDU0o/6iawserb+0Jqk7zOXvG2uBDf17euelFDx92XSnuEMJIvKWfbtTEmCW+ecJDY5EHR41KRquzl7ppV/qLmHixzH4CC01ckVgk9qjTrr6nFE5AGlBxO5+OO/IikmIVyiHZHL6Y6DWfcivUb/nQspWD6MfliAT6EvltYXu78TNLfYQV9mVhtaDa1BGBC9mJvo7F35vd7wjmH7eOhILtvDes2Vnd2LueYWVz5nZJuUfVoUrwy9YkJX9zVr2lpJq93w89KCpRnnbSfhw4+0HboZSMrKkhjg6HoV9Uey1mTNAB4v3HcIHfrIjlq0cuKe6E1Ip1eqLTBDAUQ2c8UTuilLE1VVUAe9do/QoMkog/3TbesGR1hUS6KyjYUsv3RngXfjTyIl8a1g2bpSsrTg2F5FDD95B78BMrdPb7RBQM26P0OPb/6tlWGWpLiN/ZhH3xMn8EG69XZisNmWn/xKN2UEWR7JKP6vD5JAhIwXtq5lw7hVqoIUi0YIpqR/Ep6uzNvzcYTgDeX8ph7eNTpFazxDeO9Wwu7vwIIbE92B1Ug7xXvEdjExN2PI0XuDJq1bHyBHQT0rT4qAZASp222NqjVSgBYH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T8fwPSsbQBuKaqtXMErg1yVVU2/XkI+LhIxi9/6P1Cms+pVFHbFuFVWKYuC9?=
 =?us-ascii?Q?cFR4skVHUvKl6Pe44VRDfjqy6C6eCtC9sCawz15HL7rADm/5nU0WPhV3ZSwk?=
 =?us-ascii?Q?0sFG3tRIF0HicROZI9m1aXyjALjQJEjdfevJY8vdN7A18/j1R7IxbPEQpco8?=
 =?us-ascii?Q?Vd+QumTdj/QrDzrAJugpI6FTTJs9GGUva3sRvFfajCCihH0zkZpIXqNwtUdl?=
 =?us-ascii?Q?MM0R+FbV4L7d/wqDq4HQ1yD/hi0tYv4AeWDsHvkWraLpVC9X1khlqGPUg/ws?=
 =?us-ascii?Q?SSYV3BOZvjQJySkW7rjFZt2fKqGz+3WPWZTI/JLi0SKI3aBzQ4PI6SiExMNH?=
 =?us-ascii?Q?xlq06Us1i60ADIBHsep0CT99wNtUCh6Pww4APUMkU181B4ZT0janXmL2FYkH?=
 =?us-ascii?Q?8FlcsxD4k2MXHDk3hT7S9SJZAEmzkAqEN2DLRJWGXpGQORW92mgSlIEtmTf7?=
 =?us-ascii?Q?TZyPN92oHjHg0/Bs7pXr3VOu6+0FgZyyuQCCsIcJdNpq3cVOysxHQl+eRuyw?=
 =?us-ascii?Q?EeDV+yuXz+pHmembOP0iOTWtqAogx58qO47jhKjJzXc7Ck1w/P0D9haZTBFs?=
 =?us-ascii?Q?TV/kwStSXWcn5+00sPdbnQMll77RczyWAetH/ViLlaLTboBc85D7Pz0GJLuS?=
 =?us-ascii?Q?06rShaW6lEFF9MkNOfN2+95iBAlb1U/e6BpQrsv85UG2RuFudVqIAzyhfeYc?=
 =?us-ascii?Q?UV2OT6PblLjOUDtInbs0r38OVUtVjtavqhx1gFTHwNC7sBhJe3SjZ5P1ZFHj?=
 =?us-ascii?Q?/EZ05xa/10y3Rv+5x3mUkg1pA/rVSGc0LAir1WwTGmaFxWXYehIiGs3YjRj5?=
 =?us-ascii?Q?d52F1mMT+isqLHPmactm2wcwwPlW3VXhxa+4yTB9ZPyAB6ETne4PlbjlKMZ/?=
 =?us-ascii?Q?AXC+IHnnmT1HIDGbKcW7hIQK5+KT6EZz4T4p1BGKt8+maMeDobpYSszSUj2S?=
 =?us-ascii?Q?daMtHKep3NOQQNCkfXr5RBibAcQchPWBbq4Hzac77E94IxzXpTQD5RO3pR23?=
 =?us-ascii?Q?Iskopd3ifORLHJUHJ8E7UgNkxvMRnrPnUtH9qcgrRdqlas/7fkSz64vO2RD4?=
 =?us-ascii?Q?la2f2Q6Kd4YeEeuPGcsV1TdeiaagNZr4/BaHBI1RsBLsf53Kx3HNzuLZO2Mf?=
 =?us-ascii?Q?OLuvlQ+IyShj/fR2dgnxFFi5+Ek7GQvWw/RO4cvOPxwtzFGdYmNiX4lwGm0r?=
 =?us-ascii?Q?Zg28vIcXfDuvZTZQkly3+g40HAJWgW6T8WCCF94XztqTo/bO4dmvY7oJzHN3?=
 =?us-ascii?Q?46RRK7HSfu5nkh/5zeNo7mjegJ/UzqCDjmYrgurBpEw7bvJIMRD6TdAZVO63?=
 =?us-ascii?Q?3thFyvYIRZm8svU/sSkhdgAMvnuloo2z7zE5rn4iDS6i6dR4EmjZj6oY1+1r?=
 =?us-ascii?Q?Od2BVyt0MMwM8/jTPPytgwOIis7E2Xm0YPQ+csGbYTioufjAN8nyGO31ap3R?=
 =?us-ascii?Q?gEX+q2e92aBxcUim1HhJNRF0ZUza0HNc5O3tbrfVbeUXnX1TCHvGKK+nNGad?=
 =?us-ascii?Q?fklEOwUSZQbB3nxoSB6xUUh3HRve7RXvWY1opPQPVq9xxnqfcY6Y6olIsMUu?=
 =?us-ascii?Q?dLpuIzExN+XL0nevIkonRnesgC6S2xhh/b0lEOHRMANB8oPyreqghmkGjPW5?=
 =?us-ascii?Q?YZymze31lTQR7+2HymucZR78eOlliaQNHna3cBjzrDVmAfF8BY6+sO0s1zqB?=
 =?us-ascii?Q?hHTrUVko0stQzVz2km9QCcfrfGgX5SEebt3OFHztJcSSnYx4cT6AqEQLmI1V?=
 =?us-ascii?Q?Fi8cZ3nqcvU9QppNNxpgl4/KylTCM6mK7Ng/Np3zq6UoLvyZ4wuF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5531e5ca-67b7-40bf-d953-08deccdd4107
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:59:38.5117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HP7qgw4EVck5EFvcIiUcvk4yM+doRDBVi0jBHw9vckscvdMIGuilo/QKkIWuqBiVSCaqjiOCEIlIZyhVyOw+ccSbQUv/hftTCP5j05hYP/yQlRtJ+/nPKFcVabh0uUB2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
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

On Thu, Jun 18, 2026 at 09:17:47AM +0800, ye.li@oss.nxp.com wrote:
>From: Ye Li <ye.li@nxp.com>
>
>After supporting get DRAM size from SM, the trampoline buffer address
>still depends on PHYS_SDRAM_SIZE. If the real DDR size is less than
>PHYS_SDRAM_SIZE, the trampoline buffer address is invalid and SPL will
>crash. So use board_phys_sdram_size to get real DDR size to calculate
>correct address.
>
>Fixes: e1cc7117b630 ("imx9: scmi: Get DDR size through SM SCMI API")
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
