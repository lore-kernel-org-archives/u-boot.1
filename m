Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77767ECD9AA
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8C0831AC;
	Fri,  6 Feb 2026 01:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jUx1xcIw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C383D8382A; Fri,  6 Feb 2026 01:36:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E496383015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uc4ViQBuV1JHMX/XOCcpec7LQweaB8QDQiHqs+F28QwAS6FHaMxTe1mof+ZGjb/m1CAkK8JgxsxbmogvNP9222aotJ6RfQDzu7r5K5yX5U4LfjzapuN/WZKMvhB3d6Pa/Pm9nXIa8tYAQQ5liy0p+sxoo+QLQVUr7lK2Fn7JLCQZ05ZQpuzhVJ4RAwhcxanu+om2bLTwno9hp+LxpE989WLFad/jqunz1ywuwQi+xGDV0NUmeoG0LPcKEP9C3OH6Khx7MwThERXjAsHJ0ENGxiu/4pKEJWTIQGIrADeIwKQ3LF0Jbkj5UJN8FM8IJo1l9f8g3Bm4N0hNHuPq6TO8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF5OR97bNjubQYSTaEuA4EcMwEPErAkACYlt1gVxgK4=;
 b=kKOS3aal8Calx0p39hMnEclclRGx2iqHV/6VPB8f+7dF9TC3xCyzluUQFImXfa84YLrzYqs8KFBmc2r/nDZmHleDu0MWuYxMi3wpevNvBFChAwjpMVk+htDKNuP4u5g0TedGn/Npe1XNLcWjEJryJzZW7vMH9Fgm5btZz/E1KSTGYbSVH8cSIhtX+hIivpxjY9Z8i6Lnk3zrl78Ba7n5shwnJUMu8Vs+34XnuP4AIPIo2Li3MnmXXBETlLxYwEnxqx8PsChO6rvlK0D7W/TTA06+d40Dr1m2580c1c3HyPQ3BVDBryN/97TTxanrqHfJv4vnKP1yHSdc2lB5nRUuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF5OR97bNjubQYSTaEuA4EcMwEPErAkACYlt1gVxgK4=;
 b=jUx1xcIw1N5KNQ6YYAIW14SDsshqoQ+vakCkNtQVbw01Choo/t7J5SL0uRNmxx1JhX4CjjBwyEJUg/PKiUMmbge7t3h/3DU38m4wYpnHwQpUO5bnApgW9+Yd+4j1Ha/o78+lyt3UrXDECN4GF6a6h/ClcJzCcmfCmD5o2rTxYHw3aUl6ZrS+GViVTiy+aIAmL9yPObl/lRMkSDBuFuv8vc6TELI08UwDbEheFNUwY0J6mpVILxkhT0aKDCieYYM5YUDLvyKBBWPNS2yN/zLNqTeLK17rRdOOZCEe79kKheP101xCZuESBH0RwpbNKUiEo1TthsSFpKwM4d/h9kR6OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:36:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:36:12 +0000
Date: Fri, 6 Feb 2026 08:37:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 04/12] arm: imx: Add i.MX952 CPU type support
Message-ID: <aYU32yRbzhG2mYgb@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-4-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-4-2103d0222a0b@nxp.com>
X-ClientProxiedBy: MA5P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10925:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a3e732-39ef-48a5-73f0-08de6517ba5c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8U5HKvTe0GJdj8Oi+KG3TIqSQFTJC9uljw16O1B+PRVqNp2wz8qb6TrIp1VE?=
 =?us-ascii?Q?UwYLMAMX0aCOEe+a/0g4aM4og9DPwLKbxygQ/SttJjJuSlas0H61ftQpUmfL?=
 =?us-ascii?Q?wiczpsG1kCo5InuvK9yGk9PeNA6KO4KmW6rBmzAWY6iZonLyCUAe7i9DRBD1?=
 =?us-ascii?Q?VmkiXjXpONtKChqb3FEHGU2jLRcYpGFpWbMw/oaU4MxPBGzW6bhJl6jslcwM?=
 =?us-ascii?Q?R4EgPDBwzwmp665Wgkr9G+XFG7aPFLPYWOHJLHdAHh39aBq1wmM5GBbrkw4j?=
 =?us-ascii?Q?roPVUYge3dpWoHaWVRp4yNMPMXvyr5o8YsRKZpHWQn8f0d2dg/6dkmGzq3Uj?=
 =?us-ascii?Q?jFtefpyOE9+Rgl/gQQkgaFUxIeQGM+3meRaFB7Jw2FQZ9vV3/XLqMYjnPZ8D?=
 =?us-ascii?Q?gZYSvVGno3mu6GjHN9cxvDx2BnHs8XiBYchraA7idVXn1cjliNr3lvDapJzU?=
 =?us-ascii?Q?YwXUODtkGG92fmATTA60orI5lT6LBgoqEw2EuHF/xtH0cN9/NVS7PyekR0n0?=
 =?us-ascii?Q?HGuVrcku/Dn5J0Z343JaH0jqekK+6XU5PWBo+J4I9GNJ/7wCcSVn4b6HG17B?=
 =?us-ascii?Q?aC+Qo9g/OxE2Ve1JNhcczEHLlQQpJf/3IAqFXKPnD2XKlM+bXoKPsEhuSZZO?=
 =?us-ascii?Q?3dY07asGJJMrCQ4qM6efhqKpmX2iuYycdpQUKHUbYwcSX+xcf4YjKn/AyFby?=
 =?us-ascii?Q?Nkg9WJ0/QptSjQ88V1w9OMeDI4z920C2ekryqxym6kElUJCGVqUIy+DE/w82?=
 =?us-ascii?Q?nGax2Ogf/rE8h25lDSj4vKnJeAkdNb1i/YIs473tdpDp9tiruh1QKAqmnLJ4?=
 =?us-ascii?Q?T47PeI2x/ajz7mvPU8ctnAKFVGhdN550nR/IJBntjz+fl+Z+RKZzj2e+W2Ne?=
 =?us-ascii?Q?yqK4YjFZ6Rqw93hEzAYDd9pFwIK94sbMsPPT9IfW4j4Lrxo6TsuM04XVMDft?=
 =?us-ascii?Q?dab8LNlWXk773iZc/rWH06OlshxfFuOOC+UH8ve8wUvfzOL87NYx1vyE9j9Y?=
 =?us-ascii?Q?0lLOcvs2i9N4xN34hWW5J0H6kxPno/SuGGhLi5rYe0OrIwjihsnGYZeiCSDb?=
 =?us-ascii?Q?CuX8NcmbeTkOp/2h83aTwJw+OJHVGug0YMazCVsMASdx8NnhshxzMs3D1ikf?=
 =?us-ascii?Q?51gEdI1UgY32UntoygilTeWBiiJnj+fuodjtEg4y4nSkNZ7otRAj8I92dRKr?=
 =?us-ascii?Q?JmgXMrs47AeG6ggsUP+MHKqWYLLW9w6qHcSlTljk5H00GeVIVczn2b8i6UGJ?=
 =?us-ascii?Q?/fzgPYZw8aAdAeji+6BclAv3M2c3xHqkIP6swj4QaNUgZ4at6L2pJAswByME?=
 =?us-ascii?Q?5oTMFH5mrWOjXKvb2erccACKaZnlXaeph5PbWqs0+2zwYEvjHLZBS2Z7n0GV?=
 =?us-ascii?Q?C9G9BnzEcSl9Tm8/ZP2uMxomu0qQu9WjeI0eyYRx6G9VocCckNOJbsC1b+aV?=
 =?us-ascii?Q?/V3iyAGcwhd9rX9oJki5H9iRcHC1WCM0dBFghn0o2LVBxeR2bcoYCBNtXFWS?=
 =?us-ascii?Q?jQFXKAManhL8l6LFPrf5b4KLElptOCFWdG/1e+8MxImXY/t7vtzVq79q/CBa?=
 =?us-ascii?Q?ZVV588JZ7RefNrxplDg8YW+2ys/U4P1VN/eUA7EN9DqSob/RHSvXQNaTP0VA?=
 =?us-ascii?Q?1cGc/7K27q098yZ5CAnfcz8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AJ5jsAIzImpkt0clk+C3k47UVKMEcUZzr5xzIMyXaEMqDWZJtmgY2BfvANjo?=
 =?us-ascii?Q?t7Cs8GWP9dwLKXpUDpkEmDf/ehhY6oWUvWiApQabUXF93eOELwaWaiXa/Hck?=
 =?us-ascii?Q?7P64thJdNySF3pxwEIyUbthm0FHaVHLnZUHVZEr0PDSqhyGkAhx0/4AtZcjX?=
 =?us-ascii?Q?25CN6cBR2aYptlP1j0CY6mqAaSHGUJ3ko8tPFxY/HgIvk4RS4is95tptLh/X?=
 =?us-ascii?Q?qaX1Q5Bqa5BeAPYO+j2P7vq4RrOe5HKoqSkaiATV9DvpoTgiw99OQE5V1ZVP?=
 =?us-ascii?Q?4Df5GVX/I4ZctB/8kGQdd0gcqK0FIDMfsbMwv5b1wf/FcgL/3a7lxGzMn3pp?=
 =?us-ascii?Q?lMiaoEMFDFbzL5vp5ZW2fIKhY+sgGBWlfEBBQeH7/RJVNHhqtSOzsDAtlmEJ?=
 =?us-ascii?Q?ZYsSvqJcryOH1mAdsZH6YLkTouE8p7KyZBr9lswxj+PS6mIM/XO8o4RbB3N3?=
 =?us-ascii?Q?lkCH7kaiJWaoLAWKc6krbR7ZtMf1rmF0Ch9/Vz3cVkOEx6s1zN5LYmf54vgX?=
 =?us-ascii?Q?V74yVIGLRTaP1S4RUNkKRMcmlbiPVMqrqaH3zZYfCyjh3xJ9wxoG8oB+Rp8h?=
 =?us-ascii?Q?kPRa+wiPj5UOpIuYWQde9iU+KEcpIEfXo8K7sJas5ftn98D10rxUYtguItoj?=
 =?us-ascii?Q?RraP63Vpuqvmdocn/xUj0C74KHlaMbxPxV0+M62RJMfpZOKIF5osJC/alAwK?=
 =?us-ascii?Q?GrwxMt3vQuRgZ+wUZklo1jtD5vF6NvFb0yWlhOtNSPEyfEc2qgnjKSyd+WS5?=
 =?us-ascii?Q?PkNazDzAItcTf9WV+VJUU+Z6hCnXiv/KAneVQIT+SjQHZHDTzllIteB1H1/t?=
 =?us-ascii?Q?Ww7BQV0NfUBnI+RaUo8bYY/QconkNzkdgqGry+J1Ey5g+YP1zNz+uNbjwT0h?=
 =?us-ascii?Q?tNoKNvVwctBUvyaTH15COs9x//TSR63qjksx/Wkjmsxr6kf+gZ0VNsE2AAx5?=
 =?us-ascii?Q?3WtL5+AqGHa9AuuM+E3s12Tl3MkOVMKwtpJqXpOewYvUxw1oaMmcXEFgcZ36?=
 =?us-ascii?Q?q3tPqQttLKPOQnqyTflNEiUntJbtydmeP0zZg5eFmpDVIe6IQbD1U/lhbArD?=
 =?us-ascii?Q?Iy00ocRy5+YxEhv21JOrRBf9LTP0pYKu3FdyI4ei72zhCsf7Ru8ayHzQ1u50?=
 =?us-ascii?Q?PZjaFErTlqhyA7HgHWqXHGDbZe0WOTL8xRYFL13LoFu+Y9uSVKPGM+R2kXfY?=
 =?us-ascii?Q?w1PSSUgxlETCV9CcXjRBA3fYnwqW1nIllTL2YQDpuNqQOKnpyIzqwLsoJItH?=
 =?us-ascii?Q?yFSIF5dP3WBFPvL+/8Sf8SKEEXWZWL1bT78a9P4UXmNvrmot1GVIst7MlE/b?=
 =?us-ascii?Q?mYlxfdAXtDOCIs+8+SEo5y2rbMVoiVU116tT9l9FkmQvUe/2R8wMpiUn5nFk?=
 =?us-ascii?Q?XbJhT3G1ZhUw7ehgRIcfwLIsCXQ8N2AUJaSGsrmWO4aR2eTe3Y98Yrcjg4l7?=
 =?us-ascii?Q?m/zBvW0EL5GgXUafusLVGLRWUzLvatniB3X3AIK/8FtaBF9Tta2/bLNHIm3q?=
 =?us-ascii?Q?J1f087l45q9twXnD/fcUDcKv5Y9r/jpPHo4srXZtG1iNExwlTsca7HlW0ba8?=
 =?us-ascii?Q?/tPzX6L0ZyD1kz9qRtBhMquA5QDZWMIajwqJVH3rTv8r/vGeA6zPhirNfrTi?=
 =?us-ascii?Q?wu1A8YCOS2wXz+iimuCp75Uv8vHSBXstNGpGT2fML8ZhU/y1PFYOw/QKbyy2?=
 =?us-ascii?Q?lSkS+gTgoGVLMX2Qbx1pV6UUtZMGXZD7CUsB/5ej+zJsjFHqdc0Y06v/2eXd?=
 =?us-ascii?Q?niR6/LvhyA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a3e732-39ef-48a5-73f0-08de6517ba5c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:36:12.5109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2Jv/A9S/qGRgyiRm/VsZgr2EdzFXUjo3EWi9o/yDBnCMdwXdZvxo9g83TAK3sXFmQi+cC4d/HoUK91n9+n7mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925
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

On Thu, Feb 05, 2026 at 09:55:10PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Add CPU type definition and detection macro for i.MX952 SoC.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
