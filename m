Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFFE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B616280433;
	Sat,  4 Jan 2025 04:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MY2b8yqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBF58048D; Sat,  4 Jan 2025 04:19:57 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C383803F0
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VybtF5FuU+B93jl4gpe9ic7cT7VgOT059GsH8Rx/ZKe28QivF2K8e0sbMiygkQRzzz9eRgK4p9RoT18nFBqS9uvzGv1REbJ3dGoJVmiEWS1SFZV6wAIswqhlm+Wkfn8w3MCC3mKOJkJtc5laNTfc99NFyRuVPhL8Gw1aruwRxyE8vQJMgYVckB9JfbLmMv2wWs9tWsvWKSORhXljUObHbvipbzYa7p2+pYjQ42aYGahHlVD+k7S7nEJmgKEG6u8ww9ALiSsmjTfN2/q8j2zFAT1iLOUdp5LFbgSq0wVn0hXU6xjbl/w8NuY6lmbnnf2zNTnYC3uTN0ZY4hLjOGG9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWO26QYm3gHzE7y5fd4+9JYiKxtDMyYjvugOA0aJVNI=;
 b=nzrexNqKImcb44+CJWjPtRvCPXvG+X4sDpVZp67T9H6hXkWokeNitvFDAlf0BZ1Z7kVYHWEMD4r1F3XnaX/83gd+t1LFOsukks4omGhEDZiAe7TLSU569oiYhhQrxLNBnYkNLj6MlNb6+RfLF4lVMqHWI5KtgMicDplYS1JaWg8BGFsmigXNAbbNI319a7YG3MJeSdxU6f704iSN+P/Xb7ilmc/WiU9l+SvbJamHgFZvHef6Unao3+30JOutveGWdDLtP+q/4rUoBD7tU8lrYRvHnefrvsz2x8Coq49AVMy9KOgnJtkIW/7bz2KeKpMJbGpxxyZwT7uj5caaR4QLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWO26QYm3gHzE7y5fd4+9JYiKxtDMyYjvugOA0aJVNI=;
 b=MY2b8yqZw8DBiVv+n23AUmhjplgy6ozeOihAQrIJ8KnUp0TovrJFwi3BYsypn1bwPLYXqOX8TZc0h2nbKlEO/gyaxQ19iy2yqkPAXZQ+05KGXo5F27wMfHazPGGVHtq5T+iflb1qfQUQLpLqIWUhli4UI+UEAbi1Wbhj2GohC4OKyfs51Gx6TCTyPKvPUGgVgfMvXuAYEvBG1O1FdvWkqjW2jrcOk6si/dcTq60zsgrYrf8jmFY0+Loy4YlPwiDHLcP6APaMK3qIlJEHF5HJUIN89QJU8Z3mKHaUVGy/GRO0XkjLmCzHJ4CQOgCHkFA98AaBMpIkFigwClAfympiUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:41 +0800
Subject: [PATCH 07/12] imx: imx8mn_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-7-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: daefa0e5-758c-47f0-0c28-08dd2c6ea5ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU5qdDZYWEs5akNwb1k5bExEVmtKUWEvUmdDYUdUVE1IcXQvcnV6bmlxYkQw?=
 =?utf-8?B?WEVoTzlmOFkzcEw5TCsybU5qMDZkT1Y1clJoSXY1dHplUDJxcTJ1WjQxNTRY?=
 =?utf-8?B?S3ZUTzNSdXdRVyt6RlJNcHE3a1pDU3dNY1RMUXdNWEI5S0JycWFVRGlBTThk?=
 =?utf-8?B?dVhYWi93azZnbk81d2ZLVyt2SzQ0UkUrSlR3RTFiZTdpNFA4SFd6aTBQMzBD?=
 =?utf-8?B?ZlFxb3RZclhXZ0V4cU4rczNuVzhndi94aXluUDI3QkZLRmNDWk02L3dVWVF5?=
 =?utf-8?B?SExuV3BhMjdnKzlkREozV1RxY1BYOXoxRWVZRHBGd2lJanNmQlF2SXZQdk5n?=
 =?utf-8?B?RkJna01nUHg2c2U4N3l6Q1V5WHZCYTFFcGg2Z1R6NWV6WjZZWUVVU2d1RW5j?=
 =?utf-8?B?Q2NYQkk4aXc3UGEzM2ZuZHJhVko1dERJQ09ESkloRXluK2E2cE9BUGNrc1By?=
 =?utf-8?B?U0pMM3oya0VpMkFiT2lURTZiU2xOVDN0aGczclNnenNzNyswdExvMllGcHhz?=
 =?utf-8?B?RHFrN2hrS0Q2ZDlxT0gwcW93bWt1MW96YVNPanFYdnQ0TWVDL24raHY5SHJH?=
 =?utf-8?B?M2UwaXZUK1V1aWxJdlF3Yk1JSTVMbmZVUEdnK00zZWh5MVJSS2s2YlgwK09B?=
 =?utf-8?B?OXpUR1NkUXJlTE1lcU1LMCtPMTYwMmhNN0xwUW45T2trTHlFczlPT203QllD?=
 =?utf-8?B?dzIyTjVrNWtwekRwVVV2ei8zempZcVFUNzVhN0owdlNqaGdZTzgrelhueENs?=
 =?utf-8?B?akQ5TzNQZUVnQmFzYWpSalFpZWJsNm94Z0xXTlY1SDNBNm41Z2FoNWErMCtl?=
 =?utf-8?B?bkpuR3R2cWFUd2p6TkgwYytRNVU5TWtXR29mVk5naDZRM2xjbDhkbjV1SjZW?=
 =?utf-8?B?YW1rUUVRTUp5MTBYeTUvdzJLaXJYQVRrRk5mUG9VeFI3V2JDc0tSVm9ZTTVx?=
 =?utf-8?B?Rlp3MmpUNlhuV3RVOURxSXdsaktVRWZYWFFVU0ozTFhrVDFWcmdMZjBQeUkx?=
 =?utf-8?B?SVRVTk4zLzQvSS9wU2xMT0REcDN5andpVEc0eGR6N3lUU3VmS0FJZGRSYXo2?=
 =?utf-8?B?emtSZk5MakMwMTUyNGhVZWVXMExvaEJxeU9yaVZoWmxyVFBoYjIxUkJNZVA2?=
 =?utf-8?B?YWFlZEhkY1A1NFc1bU5QMGRLK3JHdlh4WjVDVHNlQkw1bWUvbzNJT0VheHNF?=
 =?utf-8?B?RVpnb3ZNNGNJSmtic3pSMU42WDR4SVQyS29yWTVmVDc1bnpLRmFIRnFtY29o?=
 =?utf-8?B?Y3VKMlp6akVTSjlOODYzSjNLZnNXd0syYmJTaEFvcHBvSWk5RUZQSXhjSXJl?=
 =?utf-8?B?ajJpMjJ5Y1g5QktLVVpUYWtueGNNdVFUT0lndFRrTkdmaHNNK1lzUU9SNkRv?=
 =?utf-8?B?dzBSdDdONFhaQTdtOVg3RnlkR203b2ZJR3JPMDBBSENRRjI3MGtDa2d5VGdH?=
 =?utf-8?B?V3ZvTnhocWdvZGIzVG0vWlNHRGpSbkFjUk1TZ2JoeDhDYXdxZUpBYVdDdjFu?=
 =?utf-8?B?RG51ZFd5NXhqOXJXQlJIZXlLYjJOcWdpeEVscmdzWVVDcFY1VEZjOG5jU0E3?=
 =?utf-8?B?Smlpd2NKOW04azloRUJxa2F2dENvMFdwVW5ydDVYT1ZvUkJrKzVVbVJJaHZH?=
 =?utf-8?B?ZzZGZDZrQTJ0Y21RL0ZDWGxsTG1ianltd2xKOUpvSG9yZFVsQVFTR00vOTFH?=
 =?utf-8?B?WkwzcTFka092RlE3SXNkR3V6TU4yUDVaTUVsZ3FUMHA4a3hXQVdPNXp3RFBM?=
 =?utf-8?B?SkYyOHNNSDhqbFR2S3RjV0xuVjhDbHM2RC9kdFVnaDVFaHBxUzR5a0E2NE9Q?=
 =?utf-8?B?WnMzRkZNblBoeFFEQzBYV2Vtd1dxQUx1L1h3Yk8vb0R5QXRtK0FlUjRacFBB?=
 =?utf-8?B?UnExd2pYMnd4SFBaTVhRVm5CRFN2WmNCZFpQaEhTNGRPQU1SRVFwWC9xQS9R?=
 =?utf-8?Q?eZWodvvTlfh3Y8iFfSb48p77WPYPoLkm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdHY3U5U2lRTWFtbURDSDRqVS85UWdJYXZHemhLTy9xWWNxeEFKR1ljZmVl?=
 =?utf-8?B?VTJBWEhQVmxDK1p2OWQvczl2emlsdVRZZDV1b3NhM2s3VEp2RGxUb2w1cmw1?=
 =?utf-8?B?QWFzYmRPK0NKcDI2T3V3ZkUrWG9tWWhvd1VtOXJzQkdRd2F3S2lrSk85Z1lk?=
 =?utf-8?B?RGZsRlpJZjR4cGlrcHp0Qm5tbzFxam9GSmNhZ28yaERUb1ZuMnJ3MGVBR0Rk?=
 =?utf-8?B?Q1RDdDdrdVBTbDhTc1BGcDNMVXhqMGhWUE82dlR6NW54UDY0d0Q4L3BhM3VQ?=
 =?utf-8?B?M0t1QTdoWWw5SmZxOXhjUzlwNGxYeFJmTHhmTGRpQ3FMZWFJZDgvSk0yNHIz?=
 =?utf-8?B?dkIyTytVYlMyWExBUEowSGh0V0VQVkhiQVY3Y3dheHFhZXl5cVd5RXZBMFI0?=
 =?utf-8?B?ajF5U1d1U3orZXBDLzArNk54d2c1cHhSRnc1cC9tRTdPUzZZdW5JL2hSdFFj?=
 =?utf-8?B?b3lod0YyUjZLVkwyYlFVWi9GMyszUXBIMVBjSC9STkpvNUVacXVzSTQ4MnVW?=
 =?utf-8?B?Mk5pWlY4UVpZb0JWTWVpMExqQkdJSFJjOHowaHZkcVVHUzlKSGdtM2I5Zk15?=
 =?utf-8?B?Q0gwOGI1QlRaNjk3eDBnN29PdGRxZVRpeFNZS3plVzRDd2Zad3NkbVg5OUZy?=
 =?utf-8?B?bjFqaysreTliSER4Um9kbEY4RUp3RzIrdVdmRHpCb1NnQkdBYXU0UWl5MU90?=
 =?utf-8?B?U3ExczUvTnp1WmZUTTd3WWFKU2JpVklQallMT3FGUU9FdlhIS2JpYk1PSktm?=
 =?utf-8?B?SzIzY0lMYzB2MTNsUVNQY1JTK0pwQnh2cENDT3lFOVk3RURGUFhIRmlQTWVy?=
 =?utf-8?B?QXpBbzNlNzMzbDY0U2RBRkZPa2dsOVlaY1R5TEdsTEF2Rm1ndCtYNzNKV01s?=
 =?utf-8?B?K3ZKaXNTdGV0WjFCNkZDRStRdUg3elBsM3V2Qm40SmU1V0RaNEJtUktsK080?=
 =?utf-8?B?MWNWYnRKakxzc0xCb2pZdk9jMkxCdUxEVVNJdzg3MjIvZ2lXdnN2UGxWeEM4?=
 =?utf-8?B?NHN3WkRqT3RyRUhzeDJ5RnllcnBoQ2RibXB2djlLKzJjemoxQVJXeUxBaGRI?=
 =?utf-8?B?ZXFibXgvaEdWSjJ6bEFxVFJFbzN3Mlh1OGd3K080eDdyZ2tLaGc1K1pkeFVK?=
 =?utf-8?B?OGZiZWNWV0twZCtKc2pBbitZVG1xMi9jZEJXK3NxdnZqbVJlaVVJcWNpNm5D?=
 =?utf-8?B?dUtEWWxyYSttdGRLRnhZSVprazhORTJReTY5QnJYMW5sVkJEZ1RFM0xHb0cz?=
 =?utf-8?B?aElSY2xPOGMweVM5QXpKazBuK29yQ3FteUtMOXpaUXh6QVg5bmpMb3VJenNK?=
 =?utf-8?B?ZEIrT3lmQ2tMZm51N1FyelJkWjl1QlFjWXlKR2RoTVVNZ2JPZHdKVkMwTUVG?=
 =?utf-8?B?YW9SUVFtWG96cVUyelkzYnh2NGx4Z3ZDWmJRZ1NOa3JFQ0NGanh1UzZFZ0sr?=
 =?utf-8?B?enFyeEs5M3VwYzdZb0lzeUNZNjZtTDYvRzBLNWk2OFIzVjlBNTNsSTRsaTZZ?=
 =?utf-8?B?L3A5NUxJYnVpem9rNVprWWNzVDc3STdnYnpUeWJlK2tvM1RlR1drNGw4Wmk3?=
 =?utf-8?B?enJJaWQ2ek53TEJpSGtQMHRXd08zVXBHYmVGd3J5eUdIclcvcFI2OGh1bndY?=
 =?utf-8?B?b2dLL1JYS28rT0N4eGVwbWowVnJ5OU1CeGZ1UVllcUxGdFpBYkozNi83OHFq?=
 =?utf-8?B?WTNvalV1VGNZWEl3djJxT0hlM2RhZ2R4RThsRmtsZlVnbDl4VWlNb2ZmSXBu?=
 =?utf-8?B?Q3RRVEhnMGhmL09Rd1dybHJLNUJTOE9oT21TaElCWHFrSzlwaUtGbUVBdGpk?=
 =?utf-8?B?bmE2YmVQSUkzcndBUlJ1Um5vV2JCZTBRUGlIVjgrQkZ1T2tkcWxoaCttSTBl?=
 =?utf-8?B?TlpTN0ZTZjBudjhCTFBDVG54K1hOVGhySnhEVnU1UUlvWkRCcEZxUUhMSzBx?=
 =?utf-8?B?YlpYME5PSTV3REt2TUMyYWhYY0ovOHJob3RBcnl3dktjcm5PTitEZk1oVDdV?=
 =?utf-8?B?ZUZEVThtVzJTUWd2NS9ybTZNZ3Juc3lKb3pnRXlTYnYxTDdkS3pPUyt0QitY?=
 =?utf-8?B?UlpTb3JIRE1IT1V1eWN0aFNYbjlBeTFFcWhHTTFleVB4S2FmQVMyNnZzNVY2?=
 =?utf-8?Q?UXAfxVTMAJIaS+g30hWoIItgs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daefa0e5-758c-47f0-0c28-08dd2c6ea5ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:49.9320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pw/YHcpWsMXPZsep9PnedhngodsNXgPba0ZD0zWfNqj43FdfBQdJZmd/Nds7RhPqeuh5DREfs6U47DlTTA8tVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

From: Peng Fan <peng.fan@nxp.com>

Move env to imx8mn_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mn_evk/imx8mn_evk.env | 67 +++++++++++++++++++++++++++++++
 configs/imx8mn_evk_defconfig              |  3 +-
 include/configs/imx8mn_evk.h              | 30 --------------
 3 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/board/freescale/imx8mn_evk/imx8mn_evk.env b/board/freescale/imx8mn_evk/imx8mn_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..16a6543ffc692f5ddce5baf1ced11889c444f3b1
--- /dev/null
+++ b/board/freescale/imx8mn_evk/imx8mn_evk.env
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc1,115200
+fdt_addr_r=0x48000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtoverlay_addr_r=0x49000000
+initrd_addr=0x48080000
+image=Image
+ip_dyn=yes
+kernel_addr_r=0x42000000
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted;
+pxefile_addr_r=0x40100000
+ramdisk_addr_r=0x48080000
+scriptaddr=0x40000000
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 43860fe3f56f9a178bbf83dbedb6a2ca0bba19fe..b112c30b8242aab890b5861b67a9c8a01ddbc460 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx8mn_evk"
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_DM_GPIO=y
@@ -26,8 +27,8 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx8mn-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx8mn_evk.h b/include/configs/imx8mn_evk.h
index ca02e26c26e42f7606be4e17f77ccf25bdcf9bd1..9972dc17812b7da4f2996f96a618cf8abc871288 100644
--- a/include/configs/imx8mn_evk.h
+++ b/include/configs/imx8mn_evk.h
@@ -13,36 +13,6 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 2) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-/* see include/configs/ti_armv7_common.h */
-#define ENV_MEM_LAYOUT_SETTINGS \
-	"loadaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=0x42000000\0" \
-	"fdt_addr_r=0x48000000\0" \
-	"fdtoverlay_addr_r=0x49000000\0" \
-	"ramdisk_addr_r=0x48080000\0" \
-	"initrd_addr=0x48080000\0" \
-	"scriptaddr=0x40000000\0" \
-	"pxefile_addr_r=0x40100000\0"
-
-#define CFG_EXTRA_ENV_SETTINGS		\
-	"image=Image\0" \
-	BOOTENV \
-	"console=ttymxc1,115200\0" \
-	"boot_fit=no\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-	ENV_MEM_LAYOUT_SETTINGS
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

