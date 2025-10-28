Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C84CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864D0838AE;
	Tue, 28 Oct 2025 14:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ANW3HI9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5516F83A43; Tue, 28 Oct 2025 11:48:34 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7982783A13
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 11:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyJzzAOS3fRKTGScRsRMER1F1BevaAoGyrFrvdbiJWDhV2InP56CBOtgQy/zMavaPKjnKUyxrn2ecH7bAilu6QFw05wMG3lwsnzJ7WvbI4aUA1zOOAJtfQaxsoDdNkVybwZiMSQ3gFb6PQgWKl+GD8ZE8586k+syzvaL3dAAqsNSSLf8OxBZ5P6WSQ0SxitGO/xNrpFr3F4C96JXM0e+QnMDQnJBlrt09Rs65WtBZQwzsYjMJULwVA13SU12GRz+iS4eASNYK7J2kfn3u1ZzvFRcyW79qMDUswaHoEFGF+nZTlN/yv8pNndIxwACwjf6NFo8ytoo9hPSaABnshE2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jNWTYhxBL3ebiI8HgonyNaWagan84kPY4RlkqlbnNU=;
 b=Y+n+Y/xbmDhCdaTNSdtNE2UgGSpMCmY0bHlgW0A3wJTjSF23zvM2bj44T1akdMo/SxBSFs9RmeZsICMSg1r2cmqtjxqFhygWVSugZtyuV4wrUGxMXPEnp80IcnJ4IOfYs8QmJFyafdDletGFu866v837pY2VbS+r+nDhxgbvpQDe8DKW+++bJXzUr/KNOnC5rX6sroxpahZ3Nx874lsikmjNbhmTcC76SLCAsNWWEQmGw04eWpEillx0VBnQWSIDlMV+HBR+uvwZW1+lxkeUIpVUrJEwwWFu2vNPaEM/ZASSmV4y1sT/iCRC5dsdFKvW5NkUfKtMFi6b+ncflvHVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jNWTYhxBL3ebiI8HgonyNaWagan84kPY4RlkqlbnNU=;
 b=ANW3HI9fbKKNYz/qP2IiQpCMYFJZ6caKVmKkpNrgu2Y94QxM/a3hzykbSogVOFtPifbnx5URZb9OFO1G8y6ciFkQVPuSnSH6xVVZiOMQT1fHx2b8P+bMYpIgthTXgiMjiQ87/2ykrA5qmdbRfAj1V5iGZD4aq7uhsRctBhawW78pjIaAHWAkGC0tj7CiWfMZghkiDApVLlOpzrR9PxEHrnspuu0XUzVUtVjs0f4bgFH7fMg4onLgb3Gix636Gi6terLBz5B/M2URKyvd4DMjuWE4gESvZ6EcY5w/rHDNHPbfSh2SByNq540EIGwqyYA1NZ5JIzkUIlyghyGEvl5fnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 10:48:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 10:48:30 +0000
Date: Tue, 28 Oct 2025 20:00:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 3/4] clk: scmi: Postpone clock name resolution
Message-ID: <20251028120054.GD9371@nxa18884-linux.ap.freescale.net>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028034225.260469-3-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0008.APCP153.PROD.OUTLOOK.COM (2603:1096::18) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ba7049-9c4e-479b-2105-08de160f88a2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i/IvEIuPL3aulb6CUarzfBcKbXRGn6wg3vi74KJwx5dM65jJKPDiUm4eM/mb?=
 =?us-ascii?Q?N7AfCMVgYfYglJivhUa4lxm8EBr9juTLULQ3Bosr7pdGOzw+jc8FRxcWBzs0?=
 =?us-ascii?Q?uopjSnt3TDMdKG38zvM14Fu6DA2rqP9PHyqJHewNgkQP6IyqCLMezP1blDUZ?=
 =?us-ascii?Q?DRfNWf6Q0DuODmRnqI9OwUHUxiadmTserMH1ITSow//fy2sazLRPEvudiFcX?=
 =?us-ascii?Q?AjbUVlUXwWjbv5MeGar+edqXRw+yZd/qbHtB7tC/MLvWBcpU9APgoX4WCOXq?=
 =?us-ascii?Q?jaJfW4jFgJiV16fCQEyq3t758X+z9qcD410iglv4Cq0m9jC/GbYLl5hT8bzV?=
 =?us-ascii?Q?ssLxaoXjGGvmuB3Cc2RzfbOUoqM08waC/lPA7saQ8WR6gro+BFPiYEDKBtFu?=
 =?us-ascii?Q?r5WgE1qJBqKqIhxTyMis+c6Ty2E4K9Hj2YAbnjog72z0frRI/lByJ/f252/3?=
 =?us-ascii?Q?pcxy7N0LegKoJqWWFEOq9wVrdsfWZjlo6poMkFjDilLCt7YM/FkB2pkJg47U?=
 =?us-ascii?Q?B4hsnRjpebU0eWIFU2dyMZ99c2nNcIeXU2VKVXCZtlZrkGUTrN5IqlLelMTK?=
 =?us-ascii?Q?ePhWa473Oz091/f3dMHCp8WTR0jQSx5iPLfeTv87aXQEpS0UkgKOCfmbPL/k?=
 =?us-ascii?Q?C1ykbQrHVm3yeZYTGaelgFyKqmQFqdcyNd20m6NouNO8kVyRyS/jP//bYsnP?=
 =?us-ascii?Q?sWpDCwHg0KgOYa9WDDwHh5dwJIA5PuxuQM947PrXbzqWBWDAiYYpWMh3YMP7?=
 =?us-ascii?Q?P7/0MSqT+CEtgRa5lT44UaVBhyuUtI1IHI39CE9KI3ioh8AQamHd44IWvcfb?=
 =?us-ascii?Q?MVT1YA5baKMjcypacLmib24AHbPkrVN+iu+YA5kA+LlanCESo0aeLhS79M7f?=
 =?us-ascii?Q?8S97uEqJE3OnAcGSpMJp1uKO/Y626zv4sDwgvjVL+XIPXA4yThjnCrR4LnTp?=
 =?us-ascii?Q?Qlc50yN3AyN+fjc+pJW++Cg2hJ7i69vLe584NKHZkB6l5I7q8TndanJPDf+f?=
 =?us-ascii?Q?Sh2x9qH2cgs6aDAGMvgsMuatw6d1CJ7AuJhW3TJnvmQs2HIo6E8gFQpM/MPT?=
 =?us-ascii?Q?PKVCyKUw/DM7UUj228dIsmP++TjJbfPCiItgjYYmRX0G0xMWP+L+mBxQT5oV?=
 =?us-ascii?Q?749KUgla5vkxMx9DUH/DfdTpDwNgfQBowUCBJHRntD3Ltw3TKiLEn1rOyJ2t?=
 =?us-ascii?Q?MKvBK/gE9Kxm2U/FNJefo9e5iTgarE7rLLTdmYLOrGbeK05V9PFHVUvw0QuV?=
 =?us-ascii?Q?wT6KeajSsURrSZp0mNSVylJ6VBubTq254Bll0tbuk6NzI2VvahQDx++m9deY?=
 =?us-ascii?Q?vZE+DBnXfPHtRogdZ6VJU6sJQlkxZCqI72Qbm7+dTC6bdI+6cSNtvsP64nzR?=
 =?us-ascii?Q?xcoF3ergxUeF1lY1OpotbwX9ThvHMBHjDvKE0OTbU64rbbljsQtkILeCwF8b?=
 =?us-ascii?Q?k8c8z+y2yE4xJST5caVd1p4HMmgKhJpXZk7LWTRp+anKDHqWEvu3fll+th/S?=
 =?us-ascii?Q?hzlw5QUu4ziBApxWod8Q+1SKI5xRPKIv0Ayb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/eixxw5Jw+0ddrXNaNNRX0ECSI9vGlQBUAaMABiM0XqCYFQy03SfAcNTX96v?=
 =?us-ascii?Q?I4FzZunwI/WrA7CyuuoULTnm4gTeH3X94A7j5uHEQ5ljLzJ/R1h2I2Y9xh1E?=
 =?us-ascii?Q?MSD4gUmuLwde6apcijk3NylXin1Ak25LvCQOdqW2Dr9Q8rKOuPu8/Qoo+yj+?=
 =?us-ascii?Q?ihYm6XqKXMMbp7KQ6Vlm86+t02jTXllrDULqzxrGK7AUwWvCk6mxiAQv7ePX?=
 =?us-ascii?Q?TkWE5uUsqe/p1VI+A8QTK10sqEt/MJoy+xhdEjX3DsbXwMHhdWiuqD0nFnTb?=
 =?us-ascii?Q?iymgT1t+aeRdYOp0yFqdakOf3XWPCIRBgpT0U8hpmuJQDdbk37R7dt9q9VU0?=
 =?us-ascii?Q?jX9hOCFSXp8c6+p80bjjq+I1tDgj0647Ug0OtSwrPQ57mhLy0tWkG79U6Vix?=
 =?us-ascii?Q?I1xAb2gVeXL2igyowIEn9OxHcWB7tTcNqrVB53MN9qZu+2MhsDEDY2tzpW3s?=
 =?us-ascii?Q?Bqaz7/9O12c9sULXx26DSh7wg0MgCUB3azCkcUdgKwWRaXO9ctKaAcXrzDj0?=
 =?us-ascii?Q?oORUjB8VWa7CkKshwSKHFzaD5BmNBDuEHh1xUc7ae06hSnFoWbteMC7136Rb?=
 =?us-ascii?Q?npHvp76/PWH1lECvWKPw7i0AbNekjazeh44TYNcA8I6yEEKLw7UK1PPuno/V?=
 =?us-ascii?Q?/AIvSoxQX9wz7vSedajkvT5RKOFvdfTHtICLDLUciGbVpdcFrGNAYOOhCf7q?=
 =?us-ascii?Q?lX/NKBytanqeYCdFJ9GWzEPkKfKxHUG2oqQca+HsbP5nVjwToNsUREYnNH++?=
 =?us-ascii?Q?RGHnSBH+SPoQjxFpyEaFrAA5v8c/Q95gBW+06Ct9DA9EYflsIDG7J5QhxwSa?=
 =?us-ascii?Q?cxZF68Uc1Gfpvc8zUzw3MWIF9/RlXECoZMu6BZb47bsb3iGEZK2z6zEK3D5O?=
 =?us-ascii?Q?cxczVF4+MP3TCLSdCmbvQ1GwmyKnXkBpRnQZTL7VurdE2V3/APyvsEwqPgQm?=
 =?us-ascii?Q?N0y1EYRtlfiP0vcN7/So/AxH7TYHMEhnGayJGmb3UvDEFhypaxalCOTZ0bjz?=
 =?us-ascii?Q?aWH1KOldGjVpcQ/KX9iAVwx0K8GSqH9usZ8t8d0ViPBQQSfBycNtgGUwJWFJ?=
 =?us-ascii?Q?mi9PSX+kAHqfTBc99VxuVtA2mymzSEVtRqFyijp/K9GAwNVGewDYWcqEX7/T?=
 =?us-ascii?Q?RC/ovF2+Mv5HFkYoMotDfeWkXsPVNP98k1HLUJ6uiWR4VCbWcRa3JkgERFXU?=
 =?us-ascii?Q?OpNZmg3BfvBdRN2x+2WqdtQXzoXgyDFnmjGJmll5vamX1/EMzD2uWkQOo6rF?=
 =?us-ascii?Q?LQW5vqlqt6cdvNKZxogq1O144vofAZvJJHzyeDWnF/4S/CB1VHzLKwF00NbL?=
 =?us-ascii?Q?5G4T+qgp3Pp+2bAdXr09mtP7BZLwb5m9Q1rzLUh+Ore9Ugv3+61/iDMNYm+W?=
 =?us-ascii?Q?RKovlQcWk875ZgUk6pUr4dCrK6pMxd8RhPh81lKSd6rtWVBiaJGMw7Zqco4e?=
 =?us-ascii?Q?IsKOsWZ2h5tN9ZX/MoSWj4NGomMIFMm8ehoZzGuW6vsZ4K9ZPEX+8f+mTpm4?=
 =?us-ascii?Q?Xdb4NnlIzdM0tOO1hLTci5vRjIST7VzB0aRt3yljU/eiHuOl83rpdJgMjutB?=
 =?us-ascii?Q?2vsgbKrwroAkFm5cbS3GN8/H1Mzj3u6095kolEAP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ba7049-9c4e-479b-2105-08de160f88a2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:48:30.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCAfDKybqEAvlljsd0brxacI49+wZwebijx0u8KH6aJONy8sxKCf9IR1124yr48UujLhM1ZZKRFMtVzTpuJ/Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575
X-Mailman-Approved-At: Tue, 28 Oct 2025 14:10:51 +0100
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

On Tue, Oct 28, 2025 at 04:41:05AM +0100, Marek Vasut wrote:
>The clock names are retrived via SCMI_CLOCK_ATTRIBUTES, called for each
>clock ID. This may take a lot of time to complete and is not strictly
>necessary. Register each clock as "scmi-%zu" instead, and let the first
>call of SCMI_CLOCK_ATTRIBUTES fill in the actual clock name.
>
>This has a side effect, which can be considered both an upside and also
>a downside. Unused clock are never renamed and retain their placeholder
>"scmi-%zu" name, which avoids empty clock names for nameless SCMI clock,
>and avoids the name resolution and improves boot time. But for those
>SCMI clock which do have name, that name is not listed until the clock
>are used.
>
>This is a preparatory patch for deferred issue of SCMI_CLOCK_ATTRIBUTES.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
