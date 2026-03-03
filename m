Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85FAEB365C
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 03:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4B683F75;
	Tue,  3 Mar 2026 04:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vYpskeAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49CBD83F7D; Tue,  3 Mar 2026 04:35:45 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC78383F4C
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 04:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqfJTKyH+COSdciuSsb+2hF3kxtVrjIKABYNVDUSjIsMjlspTahgAAA6J09giGjVcWB5YSSI752NrO3msGkFeFH8ahjgznPiK2Ea/sNhMeoVOjGAnK+Hj8Z8AzJ6oo4f6U8xqpYp1mEOb+zIiNZ7F/5uow36RCQAaDYNqnPhZ6oCM9qK7avEzwrAKaHyuoiUSiGu4dNPSrtf463PC/7ULu7QCBRWfuxgPLZ1IxrO+5R9ArrQBWF3srUVyzPyv2qFDmyfiWB+bIISpNORhXpEGpWPiIO1CRTSDysAwzoQnV5rlz2/D7LUs3J+GlMPDIT5rnUsL3bxaISnQYHxwFobUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1ir04fC7DZoZYcnJYTU+avY0Ye/H3NtmVrzeLw2mSs=;
 b=X9YJ5jwdgCKDTZ8MmqCf1xp1K2hvHGwzOnt85mMiqQQSpw0tlnpeT1FMNcmZeKPsmi+ymy8p/eg9iNeOXTTtNlzhe7m2e2QP38k4FtRHnb7FG6j2p0LEIjtsjNWlKtGLtNWZmcn2W6ToxUsKPaAFCI4L4AuMxzydjRR0yVckpGq1k4rxsQDX0YPkKkserVtMp5PmbduDC5DBHlPjWaDST+LFfRGjXKS+XwkdXo9rgbOinppe8kiG0PDwPptnGPMXD6TCT84OaQ2hm70rqrn6sYesRGKU3W/QK4OtZT55eIiW2OLzEotW79hjZjLso11KzWaDI/aPQZ0buL3GZWYT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1ir04fC7DZoZYcnJYTU+avY0Ye/H3NtmVrzeLw2mSs=;
 b=vYpskeAhJy2DlU9ucHlx6wSFBPx8c9wHz23U1HclIlVjIqzcJ1e34dPcXBFNweA6ILb4oc0mWBBQieapRdNSIl+uVe/jDGQYu6USQP4zI7P7xNgCW5Ey8JrN7sfl0fYWYkrENhQyH9gtXSk9bjDQMTacPIO1DP9uC78iHdrNU6Dx2JkIsEIacpLq1d5VgwXNzTwl5okuUqYgZP8js+L/JAUmANlIhexTml5E22Kej/nLC0SUe5n3LpmL4zWfvRn8n5ihh9hLvFRN+HcNoiLL2Fi/JT7M9ZvftsTAt5Ln0Afls5ln8q5kDKObZ/PHnymv8JO2FzGa4m8UV/ni39lc5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9934.eurprd04.prod.outlook.com (2603:10a6:102:380::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 03:35:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Tue, 3 Mar 2026
 03:35:39 +0000
Date: Tue, 3 Mar 2026 11:37:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org
Subject: Re: [PATCH v2 15/16] power: regulator: add support for Spacemit P1 SoC
Message-ID: <aaZXfzCofSpMY/kB@shlinux89>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
 <20260210151459.2348758-16-raymondmaoca@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210151459.2348758-16-raymondmaoca@gmail.com>
X-ClientProxiedBy: MA5PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: a407d178-d1c5-4bde-f006-08de78d5f06e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: qNPVsGoqprA3mxuv8tVK2VDBul6PYdHGOSAo3yZQX8SrgTNHXs88FWsp1bmR+PqhKpGX/l3/kw/HEEzRLQbedVTTeV+HUI8pG8KLkMn7jx69376tzy7xodYZKwwXTy53ylnpDav7Oa9M7PqKGSynZ6E26tZ/Jymtn5+A5zZ2xbCIqioaoIIOxHtn7I+vNJ+F9Iwk1zjRKL1UOJOeauQkOue6B0Djb9A2Yw2FM4Soblu8pBsSm08jtAWKrHICWFExG5D+G63+jl+MJgTUXqhCIBWuWZ+YoUHjid0xnhbEOqZ2/81fkRBXnmkdpvfr1Ve/kxXy3xczvbDS9SJ78OSlWSLvxxGNHAzip8Mf+y9JPjSaZ00uqpMGZ8MIevqkN0eHY2+OmnUTnVx9TEDjbYWlSJ+tASydy+nGdzwKgAInQEAEkPe4yit7sSdl4rMxfQuD6qF6MwvCYYK8LNfC1twm+nGpqhp3GS6e4j6B66xmt5iKvoEDOhPjIPXlXjU95/xGHs5UBjIm/kmV8G2ymM24Yl81TR2ep7AJYxxY+r44tDL88JWJimAB31l+X1iQ/HnGXF3cPOTWiU8zo8CiYOGjgvs4c96KMiIyGyNVhrzKRPS2OgyphxL7GbLeWPM234lL49EbrPjvzJQHHxBfZ+LreglFpeIpenU+JzsG0Mec7mxIBIMCdM8UMR+6PpP1UDUVESMT35TfO75zTeQY7xSLHbBxU/JZtScYEGlv+j/2fmsQvnzoClDzNeJoMB0ZGA0h/SzlcKHVS6I83zT12I/KudOdD3r3sBT60KX4TLJRtxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6d+dqyP97fTM6hU3y9rgm4bHnW7LeYGjztBW5FsTTb+OheD+zTSYxoedc/IE?=
 =?us-ascii?Q?uuyFcyqUgPfd/TAx6q8dAsF9qqsZxU4pr6tnKq+P6Kw7aLw2uWVNCvSjJPcs?=
 =?us-ascii?Q?CqFS/DeXmWz0KAJ1/4f5LTJMBYsqkpSG7GCjcFIoyTkC/dauVwjBilRDFAax?=
 =?us-ascii?Q?jT2I/Vf7ga/RGhPHP9oqqkotu2BHCzdIAhfies5/baIUzMngHCOkStexyp3O?=
 =?us-ascii?Q?R8QaQIbqn0++N3rS2KdWKQJSbI1jaPq+d3kLTLk1E5Tmr8VoP/ch7HywIS/a?=
 =?us-ascii?Q?JS4Zzt7WR0Oqi0ZT3l4rdh5D68/yOVPiWWqmAhFCJFYdmGw1Gxzlp+lMgco+?=
 =?us-ascii?Q?CAIvuTlkt4vqXnEDo7oMJl9MBUkrbRg5qW3GEU84eVkrTWCcwBhTWze4Nmc1?=
 =?us-ascii?Q?zvxTX7yyF29xs1Qesodo9P2xIPX4MM9igNgrmXoaLQuI7MsLdLKXmV3lkVH2?=
 =?us-ascii?Q?r0LsHEKkddoy0pDm2zHcYamGyKzEGjOukSt6LsshkS2OIUvl9zXCL1ziXlSe?=
 =?us-ascii?Q?98urUqHgieU7uumLQbAqNBzP1q19A546WdHWg8O5sLN+7cFTAJbU0tNxl9L8?=
 =?us-ascii?Q?k3AxSjRzfnF8ajMwyQi6ZA4neSBVawpaS7IBdMZlrhKbIn14vFRwz7KR/caJ?=
 =?us-ascii?Q?nJZIbtqk1TqTBMSyfA011jK2wcv5z3qOe1LKYH+pAiMDBeb5YP+oy9jKxoPY?=
 =?us-ascii?Q?HWqjYpUr5OIA0QkXLTv6IM2Hc3gPhEOqvLTlidaPAyhqfVibbHqp3mBGx9SE?=
 =?us-ascii?Q?96tLfCts0/f4lWYgM9cz90uATMeb/iAz6xMxk0vUI4eQmKenzK2HYCE/CuBr?=
 =?us-ascii?Q?GiV1Wo7rPlLzH2gse3qr/8pTAnxsmYszAtuULLbG2jyFG501zeWjEqwjOPH3?=
 =?us-ascii?Q?XmF3W++JFftoKWekm6M2INb+oA67ae3BUCPg36+TxAe7wdcSua6ZWCRZDLyD?=
 =?us-ascii?Q?dj6WxLHXc2hQc2PPXEBU55fUzktBwLKL2dZM/eqLbwIASFBO5mINzRWKCE23?=
 =?us-ascii?Q?9nDCxGK5+XFIo07jP3m618gjTLAQBEXWwJ/daAMD51dtRzA9si1kpV7M5Wz5?=
 =?us-ascii?Q?z+H+CVAS8qidF0sQQjGRigqfV1CrGhBS4AzyTi8R+hIZEGdhhROuvlw6kjRa?=
 =?us-ascii?Q?BzxvKo6ZoZb9qORDvQV15RzCA8mpG8ZEyyAdlOtxf3n7GBxmtl5u7m89KLI3?=
 =?us-ascii?Q?CK+73BWqQiI/agmKAS3oG+tUAf5/s4dhv1X/SWYtkGovQqSunM6Cbpjj3qjD?=
 =?us-ascii?Q?9zLtvmTLaG5fWEMvu73nvYuEelDh5RQtUlBr0s1s8boVGLp7CWFGDWDnJB2H?=
 =?us-ascii?Q?p/eDhhG/c47SCla0CRz/Jyd9H1HUOGn/shYHMQyZtCF5GTf6/wqHt8lxCIt0?=
 =?us-ascii?Q?0TCo0aSfv3l12xXwDDrFc1wpGwcxeFEvRvjbVsnAXg8NyqjSKAGRluVceF1M?=
 =?us-ascii?Q?VV1AnAMcrcLrzGfpwery1dVhepNdGdQtNWfaYFeXQwN6d5UMSaqW1ElrWAG3?=
 =?us-ascii?Q?inCt8ozCKPYHM+pLnweyJsnAnm96QjlTnvTb6piu7JzGpfNPcYYPxxdIp1R+?=
 =?us-ascii?Q?GibJiQDxZn4X7Zxi1Zlix/e/NJ3JY56OT7n+kHAWbz6ysvrv5E88BavDkQdp?=
 =?us-ascii?Q?nlEbPEKGGEUwJUn+f8eegcrzclbeO/h5dagybEsstn7Nu5bmMbJ3G51skvV/?=
 =?us-ascii?Q?0xOr0khzyBR57jDtAqJ/ZJMgJNzUfhc5C/0JEJWyfVLwfyaJvyXbUvFeRwb0?=
 =?us-ascii?Q?Y496GhzpDg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a407d178-d1c5-4bde-f006-08de78d5f06e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 03:35:39.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOiZDr1eFVeBb/vQ3P7rhVyZGXbGol32p9jP06FT7IBU5oh7FB3w/DC2SM/xry2KxOzfY08GGNfjA/rKsEKZqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9934
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

On Tue, Feb 10, 2026 at 10:14:58AM -0500, Raymond Mao wrote:
>From: Raymond Mao <raymond.mao@riscstar.com>
>
>Support voltage regulator for Spacemit P1 SoC. It contains 6 BUCKs
>and 11 LDOs.
>
>Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
