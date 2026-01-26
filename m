Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFCBE63CB7
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD6183CF5;
	Mon, 26 Jan 2026 02:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CGtNLrkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B49883D6C; Mon, 26 Jan 2026 02:12:24 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7E583C39
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YapzHXfsH1C7U6S+U0XyzgeDjP0DFvXHjvPVj1FHVNBClXS/IW6Pc++znpQRgVasrQu2zI6D5jJJY8MXmxMJvVWUkZUKG0OmPR05qNXoozh8bMsYoPyyYr2XjBr76zO6rFZRcX0IHJVm4btiUpDRW74gcriGUYEVi+zEjIFNMiAC/o59HSmlmg5FISxLf6Tf6wM9yDRyA/S3AqKT7AskGf47bk3XMtUn8okPRnPDZCKGPbvfIYa3MgOCHdr6KLMD3HP3Q6OYrB5DD3oieLUQH+jP8vxcqBoPDlyP47juukpy6ER8t9Ad5GxdOUrM+uo6eC4k94DCl7hS6fE5KUwKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jj3Y3ySEVt/pmDKIGQ7YbEYdVY8HxOO3FX+RnJwJeU=;
 b=KwTQ4a6MZl6n/bKJFmC9afk564KZzfyz0E1qbHj8/S1B4sKlwOE0Blw8D5SCwQeViY4iAP6ZSZeXjLQnjFopIKsw1PWiPVFJOU0JGUPYpIMWPDbN9zXfSblaTrWW5X2sKh0oZdky55GfNOOwjCz/udtv13VlbtiAUBZEwtachbI0neJsAacC16x1kCDSfq0bUHGBLv2GwexAA61L55aOtyDk4u8nxzBiCC2rAe+ARuu4z2eVucrS7f8Qx3+j5iKphJ/66qcs335W7qcGRIAL+/EcGJYklaVURJy0MZa+zClHFt7uMInAKpbNcc8T6p3zXytgB2piA/ExNNdesAOPfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jj3Y3ySEVt/pmDKIGQ7YbEYdVY8HxOO3FX+RnJwJeU=;
 b=CGtNLrkV5OPanL5A6FvPFbGgEFvsXluAtsFP5Ne2TnHFI4LWlmE/sO2Da+wzE5vsYMwGMW2DyY5J2OT6wZgOEQFi3bTDGlh7Rn0STxmvAVFWynFeOTcKQJU6EBXEeZJpXMiUocLanfzrptc1t1Hdprmo8YvIWgJEd+3/da/kxancLZ/hPzhJvcz7UUTytR6n3X2w2vHffJKX2P5mbF2KmizoxVjI6DYMY/0pRnIZ9N9Dme1DaQaV1GMXbO98f2mYdVhFqmzOYoHhXprniF2s69E2i+ojDw7z7JHD38d/WS98gV13xV9D3bj5tXDykFpTmrDJ3JNZ4wLL/2GM4G8+Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:12:21 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:12:21 +0000
Date: Mon, 26 Jan 2026 09:12:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 01/11] arm: dts: capricorn: pinctrl_usdhc1 cleanup
Message-ID: <aXa/cbId+p3GZ0yj@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-2-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-2-hs@nabladev.com>
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: 021cb1aa-1982-47bb-e192-08de5c77f4da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c8fXnigmYrnXImGsMMdPMfh7+C7jmvuJVnnX2iBQM1um3rkh9gBKJjBa3OZh?=
 =?us-ascii?Q?64EiFJO8779PZKOLurJrHF7uVtJFj9dTdxQv5mgL6ghBsmKThpp7NtgZZPFa?=
 =?us-ascii?Q?BRbGRwlJ2PrV6daZGICvJafkYkOXQLTZdX8p6K3K+mK5iH411DOF5MIY55yj?=
 =?us-ascii?Q?BtttIh7dHpvu9Bl8oD+1E2c4VZhlItsHDRf3QnBw7Rx220ewTn2dXaD6WHj2?=
 =?us-ascii?Q?kuArWJqZXXfYqs6pFuPEeD5JrEnsqXVXhLWFUr7/huqTAUDEotEB+iYddGt3?=
 =?us-ascii?Q?tMt58FPLdQd2zGVS83OxkHX1xIFbrRS3hfTWXNcZfQeflLMlMtb1jB3rICtb?=
 =?us-ascii?Q?1jty3f1i/KJg7EXLQJZCxLfnxsUGQcT/8PBbjgcmuOkYvBfzNvME6nI2Yqvl?=
 =?us-ascii?Q?T3TnS+LAaWga0chdnSp1MHgSYiBaJ6NPMFRHx41L+Jj+UMH0o6Mp0/jpHBjy?=
 =?us-ascii?Q?dnrzLcCF/dKViFaM1zOJOdD4pqFIQ1FsC+fOZ19u7Lplxjq0/Sn8zIrTygEZ?=
 =?us-ascii?Q?/2EYho2IuDde5X3bG2YtKpiUq0B46M3yPzU/hniL2xuJcGq2aMnVTZfefJz3?=
 =?us-ascii?Q?jgNMb+schUiUSy1cWSYHjLE9CzBCTXjjXatrctOEfgWBCpBCJPz5eb9BZcD2?=
 =?us-ascii?Q?gMy30uS0HGBXq14FdC01hfCh1Jp88Q7WhYOAvoca4dXxDxWPVwITdiXqLwEt?=
 =?us-ascii?Q?/twXX6R07z7Kzm4CqfgBWa7qK4weETuCHm0L1DQ9aCl5STRm3xdSr6MRjHVk?=
 =?us-ascii?Q?L5PJqINjt3QPf+joi83vC3uQLzaN4WRgbUsVeZoLYQGfid40lfcAqyt2sxxL?=
 =?us-ascii?Q?H13fqPot3YTBZ9xE71uPBMlPlWDpLK0k27GKRX5L+gP7LcHsjuEvu8W71ozU?=
 =?us-ascii?Q?RgiMd1W109dkMFfEsyhhdsxetCDcm+ofP72R4kA2M2Izd7lI6aa+KHxpSSM9?=
 =?us-ascii?Q?Ig8ZXGrnxXf51znYGrjm1dGf3BbM8rvsLVQ8QPmIkChkHaSFxHuEo5R8pS1u?=
 =?us-ascii?Q?rC7Szw4us/ANjNZ6H2L2n6mTqEvYmbk5TGBI8ATpk+zKrXXptPnE70k3a+nm?=
 =?us-ascii?Q?PD9Dd0wl6IIOiwNlicBCjDmvdJqRlvrlcV6/658FVabZPkSeYBRl5eCnvLIF?=
 =?us-ascii?Q?tKWg4ZTMUvCiTxv+ltWr8hVs/DhCQsjhPYwAUWWtAshqeWClNizw3dhoB9vb?=
 =?us-ascii?Q?gBvo0syQ6t4pIjiLbxBEh5DzBsfEqYtDeh/6xNwxI6f9WMsAmke4RkI4cu8o?=
 =?us-ascii?Q?1lkKwQHuLBSCL4FXQmRKbI+6r9ljd3aaSr8V06xpwYwlme7rU7X/CyHjM1BP?=
 =?us-ascii?Q?vEChiWGGewauqANvtss+m/WwAX5rOQiCAkF5+lI6FcTHnTTPuriaA9cWYa7B?=
 =?us-ascii?Q?8DcZyYZmnDBbsneK81yRxVPRDy2yrtdLeDPSZZERqNRMdCzXn16T4yu0d+Ym?=
 =?us-ascii?Q?oRAnaJYhdGhazr4KCIF62mdo3NacVddUOvTYdyIum+c4Oj7c1kEjvck2sLuW?=
 =?us-ascii?Q?yjdGAxaq9G4giEZZ8bTAy93LWHIVIP+mENq3b2tUKVzTSb0vQPVYuMhhlHFS?=
 =?us-ascii?Q?44Uqczu/RF0ag8r7P6fEwAooE++LrY9rvFerusughw115ThB6cIski15Oj7K?=
 =?us-ascii?Q?as5HPzT2o4h1a4KXJTeMdBI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubq/P0p92s408fYzQNRufGRZH3wcdf/DGBd8q8StsMxLvUaCDn4J9QYYcQnr?=
 =?us-ascii?Q?COJDCLCxMslnSeciCqyjafMslVpQPAeIqQcy5hVUk9zSFj6hiUTjaE6AcHTc?=
 =?us-ascii?Q?btNGo35ri5L7RIgPNttWDbawmQTajTNPF3eWEgcPXZlzCUHITKG5ZoqpJWXt?=
 =?us-ascii?Q?mRv7HndZN6QLCTIFjUV1HDhu/HA8DD/p7KrPwbzHp7g0pubPtT4CO1MdONHI?=
 =?us-ascii?Q?Jku60uXIypIoiE37MbpJ0aJpwJjioTYMGJG2GURpoaSkdrrw2KA3NT6594zC?=
 =?us-ascii?Q?VCY4uwGohoxEC7ipD/z1X3WDA5PPZP+BgKgh2ODR+8NBw7Ghif4+qq85m2Hg?=
 =?us-ascii?Q?4hiWDFjsXvBKtQkr0HNCAH1vRW8FpOFXJ/IS1p+g88wYC0r6DoSkgE/mTC4i?=
 =?us-ascii?Q?YLgeGUQD8hOTS1Qe1IZUmfdOszCLJ8JUFiq8RFOPXysHvb3sHTTrS9NMbTnC?=
 =?us-ascii?Q?HTiNlTst1mAO9Im7WcBSqzEoli6QDcTSKw+eqYCPrs1NVfie1VVi4cYIdUbm?=
 =?us-ascii?Q?S0O0b6exm7ETfX1k0kpfSsCdvzJ0pjeMJ9ibbG4EiYPhUtl8rRFMAd5oJQR/?=
 =?us-ascii?Q?Se8Cti2R9iXLhUs6z5Mj593e+usz1R2jM4QfXOwBg+73zab7Jkpeo4w4UL6g?=
 =?us-ascii?Q?gjsJv07r2vCJom3IXgFmfNIeK/jsv6fDS8QfkQduZh8hFUge0p5Cg7W6WXc0?=
 =?us-ascii?Q?AyE0orAEdBO/+DrUjd0Nvu1ji4pG5puktZQWXqxPaMav00PfXZKGqAoq0vQR?=
 =?us-ascii?Q?Rqo7MNBYNYQSMTQYYupG6W0lZCnZbpjyPiPk/jugz5vuxGDZ1x7ZBUCpOOWh?=
 =?us-ascii?Q?ou9G7//qgmaHTE/iXiPhbr0X+rygqrGCnMbl/3lrfWbP/XcvXBf8XDGZGqD+?=
 =?us-ascii?Q?DRZtBMLq1ym2GdQ2ynFzE/HWG/x1fNvJ1moDiQqb/XpqaWtCzAKJWU6wPHal?=
 =?us-ascii?Q?NrXrwLquU3moNe7ud1OoDi16ONwMjSfgPDRU3Y2QLdhKbLTczsgXDecxP8yD?=
 =?us-ascii?Q?FGHpwCERzy/6r3i/lwVhE/TixRrf8cozgWcARpa0lEVCHTWAYhN7Rw/JspkV?=
 =?us-ascii?Q?83EEIfYdslaf9aL7yqt0kGMyCEEf90RY403uIjmUeQ07F7nPP9rE2Q8w9GaU?=
 =?us-ascii?Q?TnmY+M5iNGk+t23OykPxYnn5oGQJVf7mF6J9j9lZGc6G4wUYgXPSgYNc0LLu?=
 =?us-ascii?Q?qv93Xh+RU022iKtmZRxsbAje7JBxFTLdLEs0KevJQdXdHev2tAi/3GLDXwPN?=
 =?us-ascii?Q?rr/sQ/ERdf5HNbQxLMc+Db1zXM9lxmtj3GjXUzDTUd0FuQPsCZrhtGMUiHUh?=
 =?us-ascii?Q?kmzKSnH1pAuZnDD49FxDnscsP9ge5Pmb7tEeLqawDgn1MMDUvvLCoPS81B/D?=
 =?us-ascii?Q?YRP3QXTAbC+WPFw0IGItq4/J3bxc+MjDfG0fkSt0kvy9eoG2AI4J1iFDDGUy?=
 =?us-ascii?Q?QEWURjyqdLY9A9ZqHYnGyjP5ePlJK51xsSBerJ6/9uNNN95PBW/0XILfHdOW?=
 =?us-ascii?Q?JJkALIVysJMxq+aKxbx7sZSrlMbXwYAw6PyIVbshTvHgIXx3ILOaeiRoPhbC?=
 =?us-ascii?Q?k8gPj8EgAGZbq3l3H+J3c3fbMNf+kXiU9DkHSS6s4gctSwVSFyDgaK0yXBkF?=
 =?us-ascii?Q?9geYw/7j1c3koJNbrGD5dUHpojzlO7oUMOS6e6b1vJ8OvjjfGqeBbOOV/8KS?=
 =?us-ascii?Q?ODPmc74n89B/4jzZBPU/BWRU9O8n4+n/PypsvcWB+xd0Gvz4iDu4dmNAAGr9?=
 =?us-ascii?Q?vznSbh9EJQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021cb1aa-1982-47bb-e192-08de5c77f4da
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:12:21.3307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CElNXpD7eXqd28FIAqirKCzws1wNC+kRteEKPms4IVunwgDBJ+SmSNzLLt4L7yNT3a0Mg4k8AqDobzdm3tVT4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779
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

Hi Heiko,

On Sat, Jan 24, 2026 at 06:54:42AM +0100, Heiko Schocher wrote:
>From: Lukas Stockmann <lukas.stockmann@siemens.com>
>
>Remove gpio4.29, vselect, from usdhc1

It would be better to explain a bit why remove it.
The board does not need 1.8v or not support or else.

Thanks,
Peng
