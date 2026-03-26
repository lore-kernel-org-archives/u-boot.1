Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C87F109E556
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 07:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B9E83CF5;
	Thu, 26 Mar 2026 08:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ssbo2uQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28CB083F00; Thu, 26 Mar 2026 08:36:37 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4266680517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npU2aDBaNvMm24JQh82xxkVQz02MODDgiB20xkEC0lDlmalut/CYaxINGhNQR3GALJRk1dqbLRND3YhL0VSnvwnmAw5xJP20TLoGP+L5QmcHd0lupkr2HryTRYhfdzckFdrXe7YKw0cLoj7zxoijfbmj5qY/16ctJSkloHmIGcseqxPpgFLsP3/S//AhPgQCdAccVjLHk78I0c3usZ2erDHSg0d7rRa0jOjoyWyJr2q9vXTKPnD5YFTbaQ6fkycFLVnP8EC9OiXo3gn+x6HcGu3qoL5ZxdkV/5W4fC02Lgz+Os7G1qNCXO3rMqQRFWMEZbH+zSuEAbGtqV+rIsFMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xTi3oS8fGZiPhAmdQ/eWYiqTsCwgIwnmz2glHsWY70=;
 b=jAHeNPYaA4Pnv6XvdUw5N0y6s6kJ7N4tmb6h42/B5MsDP5oKVxXhA+iyejNRKqV1ZRa+3DvDPqNogCTdOSl00GZqp1a0YBIC9Aejpu7plrm1DBPbtPEyVnrjTGxiqAw4Dt2o+Ekw9Fs1P02O1N5sr1K4kecurcnc5mwWuMAOYyBKyPeA1MfNYE0WSfSvxHwjC+Xun8IdoGArh1SZR6iVGFEMiUTR1ScTkqUl3OZKuhtYFrQ6dY1BmiMX8J47r4YFJ2pJSTMqT2NL/AuudxSkkPo5kkoKWSv93sIdr3xhd4XOaUgaaZBvkZkGQCyiYYjFvp/FNtvoxHtVDWKW981QIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xTi3oS8fGZiPhAmdQ/eWYiqTsCwgIwnmz2glHsWY70=;
 b=ssbo2uQYpuTfmgenC7fWyEo8nIBaALOpXxJR2UFZeKCDi6stUA3YtDLF4L/wZ9zJHcfk+wtyEjhTwkAbPoYIHpSqJRxpSpmyIgXVyX9mRU4FN6W4A/zQR0y0SbRgo4Eo1S7WfY/LDjgA92v1O5z5Bpq4+0miyYgdamvdfWSLodC82U48y9AcqLA+fKhf6MgO3WsE/WMesT4wgbCiIL0GHgR/BKgnoZ76iJSH2DvE+dEc1nvURItXSl4rDJrGgOVwO0k1/gw7jhH92YY1v8Mm4H6gMqy2bp3lwTZ32lMPuKS3OzM85yI1M/DxmAjg3xGwSUemzNgbRivxvkPi6LUiHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:36:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 07:36:10 +0000
Date: Thu, 26 Mar 2026 15:38:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mx6ullevk: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-ID: <acTiiNRSxwJ67Kt5@shlinux89>
References: <20260325190043.3428756-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325190043.3428756-1-trini@konsulko.com>
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a65dfa5-456b-4465-9be4-08de8b0a59bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 19Px+ItwhtYcCjUqYi5f2XxK1fXHiSs2BOvvtqnyIBdywAxtid5xoVsg5s6WalpXcE0jAHK7OaUmmMGu73WJIsgAHae3PKHwr/fuajOX3FovyZZGvy6tsQuzpVMgKTqvN69/3mv5mogH4a1faYY0nBX31JdJ7juth5aTiikT0Lsxs8joCoZK63rgxAuwwgCLH1GF9k3eQJwZA6wwpevTjYZ848kuTrFmAKNV52FIs39DQFg5MSr5k+T/mo5pR9Lqna/LKW1WojCN4lPv8mUdnFvg/5wVgC0WIVNPaNj7SqSdzvZtSQDQbMLtfVZ50LJTMSyqd7o3XqO4kntRFPsu/Pzbd7KcLBMUTK05sKfETLTfZ221/2Y3b5n4RxzFPDs7YeMjn7rlB/nekWmMjCTyoduntIc7hBhIJ0vqCmkXInccDjWRJm+RhZ25XuvT/KvVLW+CKgS1RPOjMbT8zTm+pqCzOd5wZRJugrkIGJiWPWRe1YkB/bQzNtAwhvUZem1DxIHMOlnJOwm9tOBLOp/X0AUSyhbIMUrConM5xUpDipNR/4HBD0Z51D2gwL2ntZeogoRsI4tUegZFD41eA0I70G5sVlvoStBDh+72IcbaZcuut1B6ZhCxh9iMORCVMewyNqtIlt4/xgOAnE5l0o2CIWeoWxKpF9ZsC662Uqz+o6RsN/4Tv1x0l8xTJLX8GyYU02eKHu39wI9To/OFKv5fMfdw4GkwgG6ki4O7i2S/BeFLHskufkUuy5T9RvIqaqo6rVr5w6ZkmMkSIAjbj06bmsZ1Tdt3Ckb1UOdB0RzbEVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+TpUvhBxXpiHUwLqSBIKHNFH6PXbgehX4alKqT92gjwL0wjaCUQv42j8ZFpM?=
 =?us-ascii?Q?E+E2Kwwlh5dMSmVowm6/aKAE3qVMTmMO0JriP1kI6jtGTGblnpyM0eVOUAEp?=
 =?us-ascii?Q?ZD1zH5GAGcbh52lBdxGdbpBIJ2pB+ke9e3q+a7I9nZm2RkvjBkGa8EwfWTx8?=
 =?us-ascii?Q?mPaSpSVQxhjXZa0VI1xQjDImlh2VyUCoQ/qdNSX1LpOcSYH+xeTxjsWJJYBY?=
 =?us-ascii?Q?ByalZwaImNf9rhcaEtnIwAuC/f/RhUyQAjKSlLDummAYQqwomY/hBd/WT64j?=
 =?us-ascii?Q?SZUl1mhtTdeFV+xo7yuQcG4atIYgv+a/aK2BeVllQ14M/SUbtZxiI7jWHFLk?=
 =?us-ascii?Q?I1SueQwkOocXNjkMot6CdZUey3D6xDKLjJGuhwDq+Q13e5p61bi+DbGlsIRr?=
 =?us-ascii?Q?vODKk/aXGuFXzbFSEU1y7v9xK/9eDmIo5tNiAo0mOJMtmKz3kH+1Ii2taXjC?=
 =?us-ascii?Q?g+oyLruBjztDnljR3smqheLorYrzfiqzhOCrfd9XlYxXS8nlw/VEGDFfNJA8?=
 =?us-ascii?Q?i9gK7dAU9Xo0KqCW3p6rfl1CxeU9ncMxjwmNNO9lFEbzh1whdOrYpZ358C0v?=
 =?us-ascii?Q?gnomkoGK+S6721UvEXFLtSar8I4CQDXOdnhUm2oTX07Qp9uIgLcvBh0B7QNj?=
 =?us-ascii?Q?gEi2ulCP3UcK5SXZgjZdNzfZct9ecyJcgjMtrfz3bHRdRld36M8wkdeA9iyD?=
 =?us-ascii?Q?v2313RSCJaCKlOtgyWxZ9DQj4Q2fYvPj9x1t1MUPD27WdZALtnnw+h2cwM9/?=
 =?us-ascii?Q?T1VFiboUe4wiXCsBwD+vHXH6Aeo5A4AJtX0reZcSFeTt+jTs5WpRC+jzL78P?=
 =?us-ascii?Q?YYWeNz0K3TX3wUqLSUNU/aSPFJqPrQmcGQCjyWxjzDpA5aOomdBzokaBuQvF?=
 =?us-ascii?Q?zNzx9LyxPnUyCpR5m02SdCkrNZy1NygTteH5qBknh5u7cRedRNd2NWOQ5yhE?=
 =?us-ascii?Q?evxFNsnchowWqsHS/j/noqpH22+IhPtvGSZyNhqhsC9M2o+6tB+dBhi+iGbz?=
 =?us-ascii?Q?femkI9KtyQknSkRmWLXzAQWnStUzKEHMugBno1bPspZog4cJu/2vNLJHUI/J?=
 =?us-ascii?Q?J5ZX58zOwFWuvmF8z4IpgsL/KesJaNY07CaYco6nzHAtTECkBZSkMB1dUoO9?=
 =?us-ascii?Q?E2EMCW9SGE2ySil3U8JjGWU/5HAEAB709eJjJkLEZpKJH+XAqbvmAR/xF1ST?=
 =?us-ascii?Q?nD2gLW5qKtP2C1/5q5ov+UAJBCglDd8jnQTMXxCNnRYMKk0CWUXBBChLaVS2?=
 =?us-ascii?Q?Pr0QfveHYQnxpgPLv/hPLkLcWZ7WUU4ZULj1piTreGtokTwQ98Oh0ZT7leqC?=
 =?us-ascii?Q?2EXDAUW6xOMIFukR2ioeBZhftLZPGUY4pS6SlLdpSQQ3uVTAcK69OJ+8xij1?=
 =?us-ascii?Q?mwaj1p089xH4gkFWdQEHMe79HfleUmg9upocYUoTKm3PDYqsb/FnDDJjlidh?=
 =?us-ascii?Q?4Oi2GHX+7SK1OgPXRXaK6oxvSZ0GvPDwZsDO4F/n8JE1qxPoZmwbBjYErL8w?=
 =?us-ascii?Q?14gGVVW+MGobbwYFbHei6qp/wH9fR/bzxRWJZzfIpKa5kFI2MYAHI00pbyb/?=
 =?us-ascii?Q?jwIFrlLMjc1PgtvtAk/+AL38Jxt9/FY0BjZwmeEkp7wkIylBrhi6v9iisF7z?=
 =?us-ascii?Q?IQ1AFCERJBLznje73cDudUzIbDAjUx19l+CieFfJ8M4MMsZWZr6r0fxSzSob?=
 =?us-ascii?Q?rLzdJP6m/nWj3n8OBiVM/mlms2knz01pJucnPG09I6QKBEdZV1iwNgMWL4Q2?=
 =?us-ascii?Q?faHY8DriwA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a65dfa5-456b-4465-9be4-08de8b0a59bd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:36:10.6008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL9M+R3BDj0yJXyvkrxDGgB2L9OdVlr8G9wWW/fIQAWux+i9T1W7378d7c5CHD/Nm7yIRVo3pKeA4wRntrcsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950
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

On Wed, Mar 25, 2026 at 01:00:43PM -0600, Tom Rini wrote:
>This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
>do-nothing board_early_init_f function. Change to not enabling the
>option and so not needing an empty function.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
