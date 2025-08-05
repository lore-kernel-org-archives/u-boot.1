Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C223C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF4D84015;
	Tue,  5 Aug 2025 04:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZKAOZI86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C77AD83A81; Tue,  5 Aug 2025 04:47:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4149084015
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpzfjUP3bdm+VGoUUJ9XAkI4qBnAMLOcsVKYvQlASJowBZFclUqqWt69hLcaRMOAd4B/brW3PvBqZCuS20isYlc0GA8RhMXLYtjAtVS6paee6aBMCDlIUOic0NTcC7Ugy9TuZGY7NUTjzT8n6VqEgXaI3trXXOroD100kftvgEAWvcSA6B/M2IoSVoQAP02OFMLiduxpO8jeqV6CKcZE5/bfbdzOQaL8KVG3V4tDy3/FhW0XmSX49mokN1+rJXXXUG3bd7f4wDiUV+A+ZQu/OjgL4CvFg4dJ6olnOR0j3ZlQld/D4HSc0QQ7hAEqfUyLm+vJlvA19k5z9Xr6qeputA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf8ga1RxKidlsUQMro/dcHI3Q3iQZMP96NP+nfcI3S0=;
 b=YTy9THTXDAx3DIN5aowqvuo+Ee354PToI6vO2lqqfOEDPT4ULCaOwymDI320R5hFhrRHXxEtvL0XNd++2vW4GC2uQ0QdJmgV6WowB5KB0Xrn0xNShgFAZvxZsNhT2LwTsAi2HhxW8k4jVP8uJRDvPYgZus0zH4Y59ksSEStB1+wtc8e4W+lHNbGW6PINDYR0iSKW+WqgixlBZuHX4h1W619xVR2Lcg6RBI35JJ4Bdlo90gCa90iVM1BCKWHFD+0HDLPV3jCFLsN+cbJ+Z9I0Yr9YmY+oSRW7mOqxAUFd8R96cFC5CHXbIdr5iVKnwWBi1Cg2+xq0px0/t9KgIeN2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf8ga1RxKidlsUQMro/dcHI3Q3iQZMP96NP+nfcI3S0=;
 b=ZKAOZI86Wy3ely5+2ycCKeD1vGXcGXVbDhq0flQL46lGc0WqZZ6YNT+k86ZW12N3H7j/Lmz9luvzzYumgud+9rt9yfgT/p8tEN6tLO3/KGKdWFc7aQW17cAA53xfugHilwraT4gXNvgdZfzahhuHkIoKE942NXC7dbop/KGgdSkcsCN6a1ZUxXOHMyn1hzWJXsePRpC1TcEL20HxQV01YI9kOkWJcpdInZ5t1Vy3wBkGN7rR9ugfoII9YPH3uSvNNlfk+f4KJBXEnvy7Bqagvs1zqPuBd8pPl0Wcq1V0a5+qrJLuFeUwXRouITwKg1E62d7nuGvKNnzAdRtFdMf6EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Tue, 5 Aug
 2025 02:47:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 02:47:06 +0000
Date: Tue, 5 Aug 2025 11:57:53 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] mmc: octeontx_hsmmc: Fix two Smatch issues
Message-ID: <20250805035753.GC29103@nxa18884-linux.ap.freescale.net>
References: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-octeontx_hsmmc-v1-0-440c5f963e09@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0ab092-fe91-4689-5747-08ddd3ca5d6f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M8utPWiMFb9FeJexKlIL0tmLTTmNHMAjBt9dxVR6EtaNn8G1oniOnRAWDcyZ?=
 =?us-ascii?Q?v/7E+QPu/Vn6yPMcIkPD6DxtXesKA8TO068gBFCNxEuMA2R23ougOYVVaZPR?=
 =?us-ascii?Q?48krdW7BNzZO7lZNxxaSpbNfS7arJPO61Ue+NLHVd29WcVtQrQiXkR22F69l?=
 =?us-ascii?Q?TLjY48cxE0tTCDjiSp7CXCshuc9VNLYjxBAIjIzt1nKBexff9kDxI7MbmS3Z?=
 =?us-ascii?Q?c9xJCM5HOM5LXTddJgzmbOfjaKNLYb6pJYaWINDkaQ79Cr6VYsg0+kV1yhZ1?=
 =?us-ascii?Q?MKyK2qYx7Oftz6MiTX9qQCTplx9SQu2NMGmWyado6JOnReI90sF2cEzbWDs2?=
 =?us-ascii?Q?JFZi5GrfEVU3HzmT0myATb/JcXZQVMuntAHQZBvbzwE5KFP6kHtYzX5md7LW?=
 =?us-ascii?Q?UHWPUXzLlwfzUWB1wRJCXz4X5mhELIwnD8DRsxMOj/IlVddaifTkLykCcd1B?=
 =?us-ascii?Q?dueGhBlZFmKYx8EtvPUy8OuBgHUVNv1pg7wcyA47DXoWgPBSKz2mGJKf0Z/q?=
 =?us-ascii?Q?eHjkYNusqfTYMWTYSEg9dLOpH+UyrZQ+thfiZ3MZMF7vffEbAyG/ttL24wBo?=
 =?us-ascii?Q?PtaFIFKR3kCYPhCup8ZqFgPPnPiu7N3VjJ5ikbfBFX40xv/6BGJfepHhHM2c?=
 =?us-ascii?Q?mDYI6CFy+07Z7hax0Vdt2Rm/R+yd3QlzBzAxKi4cPipzgngc8+15NeCBIPCH?=
 =?us-ascii?Q?eXm9USV1lBEdbGMfaXNtsmBRoC+wByAdDx12vXWC0b7E9vvF3RDuVXvZLIeW?=
 =?us-ascii?Q?uOVZhLX29DZ8epPeTX2IOnPOd9CrmRoWYpV76f63Q2pFfGTWZRrLiipvq0BS?=
 =?us-ascii?Q?H2rodQTatgDi4BLC7VV/CprTVgdtxrzfG6Lz8mqHsqXHqmDLQNntpvUzujlf?=
 =?us-ascii?Q?m9gR4ie8XlNB8Cf5nFKudgtL07M7F1HI40nZ3Nw7xSEy/YFoTl/yczl5eiVM?=
 =?us-ascii?Q?3RSHHG6l1r8NpucBrGaybywAVztzzDdimFiUunUSC4+lCPMrllyqpoy6JoQ7?=
 =?us-ascii?Q?qHPn27imYM2wlm8h/y8maHV6lqI/iI7u90jgZhy201PX1m231g98X/pMKnsN?=
 =?us-ascii?Q?UOiavqoFCvlDbqcbBLSJ3lJlneBhA6T2U7YkNfVNgpv61JJ922eca5R8/4rR?=
 =?us-ascii?Q?SbLvOP8ZpsIcXjPAendo1VGhVooXFeOSSx3DFSSM+SZQrrDw0XcD7cJlRV+i?=
 =?us-ascii?Q?lmwgxVLbwAk8Yk4ddZZiosgiQvkxgUyoTdn3IUTilOAYs3nVXnCyK37z5DLZ?=
 =?us-ascii?Q?XVhrqE38RBuVlPrqg4wGUizdpsKyEtZQPwAgWWFdlToZuZfhWAA1RVQVcASx?=
 =?us-ascii?Q?O9q4MIoFkJl3CXTMqwU9L67m18bYTxne3qJP8uPBCHpdfM5CgClG+L1InSst?=
 =?us-ascii?Q?1+PhRdQ4rsimr+WzcOnECp+t9gGaajf45mCRz0wF8KGTeQwDPeIRUo3+p1mP?=
 =?us-ascii?Q?jPI5hwhLqz9/A+87jPz6BFcX5UJCnFW0ZbasPQr5OauWz7uoWlM0og=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QpyUR/5Saa6QpiYz/58bKWkz8nN1QGXvrW8Fs3f1PsjsV7CQQtUtIFQ77UDY?=
 =?us-ascii?Q?J5VG5+zaD2xgyjoF+fJU1Zk+YjHo8MNEJTsVjb+9bHk2OTiexQTgm3FANzlx?=
 =?us-ascii?Q?zTXhbmWNi3mewGkV5CtzHn1R8SaqwJc/CHs7GPnvPTn6l/8nRtQfSMJWHSxp?=
 =?us-ascii?Q?4QqoCUmuaEHYpd0FdExU8Xuh+QzXjuZ/4qV0OVi7BFpKG86UXtlZ+/jaO1wC?=
 =?us-ascii?Q?ohdvHoXcCb+l3SZq4eRcvHM8YnvlRLD1NxIGre2od2OlOaEKhGFNhZku/7i2?=
 =?us-ascii?Q?f5LCiZwC/duBleafByF8g6x6fWsapBSKaRVyQjCgbJofIiUPsbhUsSoPZEdj?=
 =?us-ascii?Q?RW5b3fqiGdbDl3MT4Kia3wbyrDY5vy2XIb7Qkv82SrX2tUOj78xUBSU3QfaO?=
 =?us-ascii?Q?HkYC9mo7swoyyrYa9blPO/uqG2tkvprsWkmhx7w9iqEJXtRWz+ORzyR+p3Ez?=
 =?us-ascii?Q?7gTFCszHr61XDgM6VqDag9Byu+FWguMsGvFi1coVU7a19/iva+NXP8gerG2q?=
 =?us-ascii?Q?TzjQjLxzp7FCH7MsJ6n8BMluZ/loxu7TIr0O+ZIwPE1mIM55lqwkZvfSgftz?=
 =?us-ascii?Q?B5HJAMF53hcLVVQn2ydtYv6SoIxjibo0VlaaMxLnf7q4ksNrtn/qBXZl2YB7?=
 =?us-ascii?Q?ITPvA11d5+zFjvLdLtZfJGttY0X44Y3Je+PyULSFJk27YytiTWG4bGoYawSr?=
 =?us-ascii?Q?sROr8Rjf1vAB/hrHpNK2+6Owy0Oc5dWFZAY8BQF6cvyhk8bgP2snE8TebeNd?=
 =?us-ascii?Q?xXbrBWk48+evYMR8mW+LvWWFf9UnzOcnZVeBIyyS/0OkEwlumISEtOG8bBll?=
 =?us-ascii?Q?JLuEzOIw7oXlCQzYNZniDvJn5b8VhdiIdAF3IqXPyuRdNssWdL99klcCd492?=
 =?us-ascii?Q?Y/o5wHVmsWE1aUubCkFsmcvxKYkxtdFk630ANOePuBZlLlL5Sq7pBpU0arUN?=
 =?us-ascii?Q?xSQoy7uVd6s+wI93BPX08hVlY+LT/gTr87/TjXnkEW0+tUi71RrVD5basam+?=
 =?us-ascii?Q?+iSLlkXeIUrjaAaWIwrsxT3OhbS6extW2LQ7F9A+VsR9weIGSzNV+cT2I9Pb?=
 =?us-ascii?Q?uNZ1itul7IGU+37OspFYYdGlZ9w7l27D68PqG/4MEgCYkUtkOYRc34qtmShi?=
 =?us-ascii?Q?WhVUwAJVK/3PR8/iQMEHrhm7ay59E0DOltiVhxd+K062p1ycf6PmIW9TfzT8?=
 =?us-ascii?Q?+y5Lz16uuT0eJ3r9gY+hUOwdVSUkI944/DHyOHXMrjJjlkm4PdZAvA915+Rc?=
 =?us-ascii?Q?QeLt+XfJeY8MPRauZZ/N08bHW+tlen++pfzE53UJ7dQiIPiRhXaStvfAYF1P?=
 =?us-ascii?Q?2Ggisw8d76vioufmXh4eFoyK1v7K31n7y/ApYQ8z9gURi76AQ+/FnvUAPv57?=
 =?us-ascii?Q?H03+di5oeYN8X5U469OecVDE91yrdaNSR3+sMsWdd0K4+48ObDtb39vmu2Vj?=
 =?us-ascii?Q?2LA5ihLR5K5qgAgg0r2TPtDZAhNaanuEOzHoDGe447FYFUpoFNJ4oVR692b3?=
 =?us-ascii?Q?7V6f5nuUDh57tTCtYdxSrU65s0pOx8nEWuakB5Fmrm5jeeuvU1WDJVmKohjH?=
 =?us-ascii?Q?uaLzWeG3x+Pcb0tTNzNXYDO3tfIsVcVlE5UZJt1m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0ab092-fe91-4689-5747-08ddd3ca5d6f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:47:06.2897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFSqx5CPU8U883loCOBhoGUpe/kB1hCAbjhAFkspe4uZ+LPgpxMPDk9x1mgO+jKHRQiIuFtbwVUCqPhAhfc/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
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

On Thu, Jul 31, 2025 at 11:51:20AM +0100, Andrew Goodbody wrote:
>Smatch reported two issues. Firstly that an expression probably needed
>parenthesis to be correctly interpreted. Secondly that two unsigned
>fields in a struct were both being tested for being less than 0.
>
>Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>---
>Andrew Goodbody (2):
>      mmc: octeontx_hsmmc: Need parens in expression
>      mmc: octeontx_hsmmc: Remove impossible test
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
