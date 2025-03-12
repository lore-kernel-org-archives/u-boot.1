Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A980AC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A71E80F9C;
	Wed, 12 Mar 2025 06:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QmUPegwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE529811C1; Wed, 12 Mar 2025 06:41:42 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52A2805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9nDI+lKQ/8ROZky0kr+bStgTCEua40DEF8ne0WPgB6Y8cp9vi67ZDgUPxGJQpxRMb1bkmy+ch/RLbajbMeSDpqzEGR7dus/wMbreXYgK7Yj6bdOAaSSzX/PjJ8wEPhVLQ8Gq1paPKrrWZeYKhExSJuKTW9HkGC9BjV7t0h18UzXUMO7O+TcQVbwbPyXjFmQ8pRHe+Gx5cr4USwNk0R5WLxosu2/KZY6lN0o904fazTk1lAs72c1J1583BwMX8KyUceTnmX2aQj3BPhUhbCI+XIijZIjYskKaYCmy3hdmmegwOLdZHhigOWiwcp8nJs0QHJzQhoHHX2cG7UHQG1X2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qxVo/T3cvnW3fm3wrmMX+wQ2Wy4jbGAT3ExKaYh2a4=;
 b=mXJZ0R7fH4qQc4Nrst0Go5ZYtL/NXhoO+42J6k7xL8Tf+faWiQirYy/LXr+AsUcYGSe+ojAK//ZZ3PPj3T+DznRBodn8dLKDneuXWzfI9I9fRJbWX4XYL4m2jAFjBqW/i6BCbsczLr988HSUWRy+l3z41kttiUks2IwygO9F6m4ZO4WELPOuLn3C2HTqMY6oC/9v/Xbtp8NOjewBGpYNkVNVqoqUsyZWG1Wc2IqNiF/uJhzEMGSY5e7reV7f1zc9LE6IrV99LWsXXUBht6mAzIHlWymvY6kBv8B3ElHOdBNVQ1BQHW2QUDmslwRns11rGncOwr4yzmF4LxKGPn6AIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qxVo/T3cvnW3fm3wrmMX+wQ2Wy4jbGAT3ExKaYh2a4=;
 b=QmUPegwHFP6NX2YVkMJKq8EoROa3cxu7R5zODGp67O3XTh/7v00i3VttcJo7pflQNx1zf+HYoTyQkLAQg6CDIj10uW3875NcMKfONtMIntU7xnTSndV8r41yHlf1gThnfajEp2xpiCKHr0sUNr+jV9YPXteSyMp4Al8LInJioVzJlYNexpK08U6xFbV1fEIPQ19DZYLfOrTsllAr+f7kCwi0W+JzPcNLMJEtj56Zg7chv69W6cLqWohaY38XD9HhkbNNUsWlnGMOwpOIvrNLLW41FWGFtrj4pgSa3SnvcdcS9SCZHNpW7yYEvr1zMRnqA38BR3HIq27U8360biYPjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:41:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:41:39 +0000
Date: Wed, 12 Mar 2025 14:49:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 10/10] board: beacon: imx8mp: Let clock system enable
 UART clock
Message-ID: <20250312064918.GI11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-11-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-11-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: f696efba-5a92-4ab4-a2ab-08dd61288f56
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bm8rerXBnPBm9gmTAZGH981l5oy6WqDEPswo2pqFKN071i5LAGn58vIKQhYS?=
 =?us-ascii?Q?P3C9+1D3aJbkx79O54eehXMEHTs+Ry48qvBt+lmlkHCvKGTcUOCTciWN2hef?=
 =?us-ascii?Q?EnpO5OCMOH6Jhfg7r00RqPlRXYmrqGbc1Cw4vhexLPYsT6q376Z47ncRGII3?=
 =?us-ascii?Q?h3OQ5cKeTIBAsuc1QIt8bRIQ2OqClG/FZSnvdJK2BqVoyVHg2dl1l8BzgVMb?=
 =?us-ascii?Q?F88Y4pJQA3BcECaASwUFLHwioxERoDMtQnAotq49+xjmz3d7W8yUnMEMxvRo?=
 =?us-ascii?Q?2p/AI1cq0xRqc371sFXek978kIO+hG+EPnLcVG0GUlz2J3GVQw2tKH6hIz4R?=
 =?us-ascii?Q?z6Q30YNBT0JhBIx/GtNcgZvd8F50dmyk5ojecxEk3hsc8qQ59qE3zs0vpOGd?=
 =?us-ascii?Q?6JEHmmg7gj82Srpn9BwNrIisqmriftRIOjAcU9Dd2vLpDjZ1/T6Zc7YKH4tN?=
 =?us-ascii?Q?vEWm6xBJ88UMNacS48PsoFomCqm3YhilQGhLfekhJBWVGiNuTEC7T8dmUbNP?=
 =?us-ascii?Q?sfltqaJUAEP7bN53ki/OxrCxwOFawF2X0bDAtJTSelW7cOxDO2Agv8ORk2Lq?=
 =?us-ascii?Q?rZll00T0DrUoZ/qG9+o4J4EJdwBdvxbu0PIbXuOb94G+qwZmhV/wgWwbyrjj?=
 =?us-ascii?Q?xEQc0ViAdI3pQvUBdrcWxp211fgsV0j8RqPx98R1HyKiFn3/0+5U8SDz6g4c?=
 =?us-ascii?Q?SG+KTF/ScMCbaz31xNjqff5xlaKcr9CQDvlIx30ZPfJ3llOwFLUoShSjD5hj?=
 =?us-ascii?Q?nTC+3Y62S9xGp7cEthnI9cP53i9pqOkHBAKeMxm+kkANXH13ViJScewrTLbe?=
 =?us-ascii?Q?FB7lBTK7WarEHnxqL8twmKRR+Kin892UGSQ31B692HCadHzKpqnee+sGwCJS?=
 =?us-ascii?Q?2WPSrwZtVblhpwM5HrVdMMotsUw4RzU/Q5nRwrqduVEB3qJuiDRW99a7WbCb?=
 =?us-ascii?Q?lHKg6Vg2cI6lk79S8UatN1d7gg89rYP43MnzWojiQGj2g/V69bMsqyePsH9l?=
 =?us-ascii?Q?7pUNffvcXYUV7KPiMLtOd8WeX0unFWgvGa/0ylFbD4ymJeEhGjFJkdGqv/DY?=
 =?us-ascii?Q?J+zSe+Q0nrZco0xfndyDcTQ6miBIgqdCUlSUErrFgK2s9UPzMGZxx4UFkTMS?=
 =?us-ascii?Q?i5FaDj4EuZ8er50lhuECGw30MbUbotR+D1PoeXBx3C0dMwWzhpxD8l0r9Rdy?=
 =?us-ascii?Q?B2Z3WNKrOygu/SBFlKcYsK6d8Ob51TlmZgU3SdS6gZq6yFEOG/p/kMOcSNSS?=
 =?us-ascii?Q?91e217WIFulju3PgMSZsV3cykIuF9P3bhQ3qJ7dXsVszwRlFkkm+HdA5ZhwR?=
 =?us-ascii?Q?z8mx9LSeGtXzcnn49vXXPjPhzKghsETTprCzW6XMQaeGvQ3v3ah38yhCuaA4?=
 =?us-ascii?Q?N3xsTEX1nZhxy30YpqU1iD25lUMVwOsfKtpXkAclhP3O2wlk3FuQRQaOOzdZ?=
 =?us-ascii?Q?cMwxtjgVPcrugxoNVP0mrK22jtxa6Yfr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+i1qxh30xRSo7UYhpDiu1wttVRJsvi4PeTgpdU7jXNOU71Nu8gelv9SffCdf?=
 =?us-ascii?Q?8EeVzNQJ/asU1FtaSrB/deMABZ7u9TJjLEpcdolEMRa+CwBArb52X7t9Kvq5?=
 =?us-ascii?Q?JTT7MzyWhVquo3NWoTehxnOW0I4cFhpOgVA++G3lrNi6urWMFSdyrgy/Bshq?=
 =?us-ascii?Q?Nnkjkya2GneoLuGJ+jhe3kpgVlAcZEd2xSiRy6OkIn7fj8/rXe/A6UdbVOYK?=
 =?us-ascii?Q?txWtbbU609gD/zbeerwj1s8zbzhTeIaVdRABXVw46oAMN8VKCBR15TczIbpR?=
 =?us-ascii?Q?/z09FaanqXDaQJH/vZu0hynlZjqEH7W1zcYopfk3waIbphpNc9rArqW/Oii4?=
 =?us-ascii?Q?xcjsAiYsQBARf2JOw7LH27KnSdr9+YAPv61B3rgEee/LeA6ZfVkmkByXadXV?=
 =?us-ascii?Q?YUHl9VdT0KZX1rkz7yN5pURqLRRYm3JMgFKCDB5cAWYyVKZJEw9ZN2vXe+83?=
 =?us-ascii?Q?oNedh9/r+eTt5w8V0VoEuShxKWbybVlzeAtonHxyHVGEBHoCmFARG4mM9uxL?=
 =?us-ascii?Q?lMI8zMzYqPCRQgrZc/s3/46Um0sW/jOCfnTGiyKXJlvxpzze1WjycaHTmhmn?=
 =?us-ascii?Q?Bypxuu5VJpHglDbg3kUKH4gN9fvLHGbHmjBF4cB4LSUvhktm9wq0ks7rD9Wk?=
 =?us-ascii?Q?UYV1eKR9nLOyQwZV8++zhOLpjP52UA6vEap4YKEZE9dKp8bGTGIuam0xXB9J?=
 =?us-ascii?Q?pQsnUJIozyN6TZOIAf5wp1CJwuwxEjH6pi9DRh23S4owrg8hFp8dHRSligLQ?=
 =?us-ascii?Q?h9fO+BlftWtTQ/UWA3Zli979mwjlgiP74tQy27n0FvMJ9HTb/JiaDiWQeKKu?=
 =?us-ascii?Q?fypef2XcZimpRLl2XBtnIh2SS4JEBoYaZxfufYIQDiN8tRWUR9F2Yr/Jb77s?=
 =?us-ascii?Q?0BFULcyI8sNo9w6tJqTEE1Z3xSUHIj3Qacsq8/87K3QveUX4DfLRGtHZTnwC?=
 =?us-ascii?Q?MwBwjwwJ1XTgPnu+o+42sjahaChZfpBXOBmFpIA2jmClMVwhs3t/TIfP47pK?=
 =?us-ascii?Q?Bx4esRG6FOnvL/o4rz/PMuoTSgPzJPN1AM10uxVzlg3F5UJjQLBa/W93yRLk?=
 =?us-ascii?Q?D790wOQIqqRrtAbBS76xIysv9h0YZIynJHYRs3X4afQ0vGtxVkiFz7VpeNjA?=
 =?us-ascii?Q?TcfE6mGzei9eOJra6BuxyH+B886tm/L/+kInEusy340E5YVFVZGYh8wF4I3S?=
 =?us-ascii?Q?I0uS1W8OZfJxqjbyKnmK8li4GHJumqWrR5xYB6VtKGvZ/Kqay1RenNx7t7c4?=
 =?us-ascii?Q?70cqdHdxt9yb27VNQ08Oq61PgXq6Bl9+u5UvBGbY1KoO5bHFr+N6UuL0zdjB?=
 =?us-ascii?Q?7ftx0xKur5ua2JYpRieLJ6AMzqPzi8PC2hQQQZCOwUcNh8VnKvXULCTNg10A?=
 =?us-ascii?Q?3Jpi2iMcZsj86fUsR3QSIL28ro+7Bgwt4I6/bJjuOg0nPQPFdOb69GWkUvYg?=
 =?us-ascii?Q?EC9D/iXA2E1aaYbBqjhKnmPKjB1Zx6WKW6jX+u/gjbcEg5ZdwlG/squUmk+U?=
 =?us-ascii?Q?fUHUIyseyBSdNh6ibUTw8ntcpfFuuBz18Qe9RN7O+ApBwcn9JVIXKsgTRvn3?=
 =?us-ascii?Q?TW1rPxoHFALMH1ZNE3g/wb+w+12yiqBjDxsalBmG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f696efba-5a92-4ab4-a2ab-08dd61288f56
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:41:38.9623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahf7WIIFbFVnI+W7S/M+Rld3I9ebfpOMv4CnEXQbBPVKpZsexvPaRWiS2JL8naDKZbvFdAf3WQQw2Uy1w5DOBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939
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

On Tue, Mar 11, 2025 at 07:30:30PM -0500, Adam Ford wrote:
>Now that the UART driver can enable the required clocks, remove
>the hard-coded clock enable.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
