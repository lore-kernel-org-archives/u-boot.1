Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBDCC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 15:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1738B82F49;
	Mon, 14 Jul 2025 17:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ddgseLNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64F082FC7; Mon, 14 Jul 2025 17:38:31 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B024082E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 17:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOohuZPsJqdFu5yfhzWujXhrMv0TEc5ZRlOZBNE32/ve87mYFHSRMT0OVIzwbaAhPfGme74t3IhJEdO23nh19VwsnD2NQ9f8HsSQ5gSssURkLbiC/3x4OYyMD8bjNoLBXzSTlWl/VIMCjYZhF9d2+dNsfdjTLULSo388tcFOotKuUawPrIxKMs+ahtMNUdpk4IPJWmnwnBK6R2DtMfJQa+8riqGUV6xFSWUlVxtAwoac+4Jdvs8hCX1P5puAqd58CdK976RUaFG0OcgsqXVVhlczFJVQX8ZOcxazZ0Y2PlPv7uB5HGaqj23cjfIFTnGmaZrU7BxGdoxVC9jy8snMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX8/YfoyXYVB12HlltiZ4XfIXGU1oM0IH2AJ/LhzxQI=;
 b=mOGL/adhoyE1VJsVCrUPQa9REgQjqGX4GL3DaK7khkOH18YunfinDy5Xqq6+AtH1uEABkN7qfzlsXPxk4zxkVP26Sm+vDWpBT/qdq7GdH6WzJ1QrYbH2+88FbfO7xDrqEMiAhCxgQe1yBzyLwyyfSCguFW3Y6P3HYVx7TsuCCCIWgwhg2fLU8iwq8CR05VB4BcENhzq2RE0PGawFL/GGYiORocxJrqfwwUQ0Aa4h4jeq63hEWX11fcqglfY+3wzLot52+NwG0EqkWFtAvEaC743qj83IkmnRBMZwpKb3rkKlKlOowJydLWghk0D/pyWRP9gPbrPkcpcYdMqZh4gNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX8/YfoyXYVB12HlltiZ4XfIXGU1oM0IH2AJ/LhzxQI=;
 b=ddgseLNYpE3d9RaIev5GguGEc+9ke/jODTF3Gp9v3mQ5/Q0qaKZHMddh9gWpQW5NfBXyWA7hjjbXyjbpo4k/mSXVLuZyGHuU3HACPbMePcGbiiO4KmYK1lLlDTejmQs92YGRqIGcPadFI0scpajFJLGcGURgnHMPPn/0K3EMbyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB9016.eurprd04.prod.outlook.com (2603:10a6:20b:40a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:38:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:38:28 +0000
Message-ID: <f8220dee-4f70-42c7-af38-53e5a649e31c@cherry.de>
Date: Mon, 14 Jul 2025 17:38:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rockchip_sdhci: Set xx_TAP_VALUE for RK3528
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
References: <20250710162110.3592089-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250710162110.3592089-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 472d3488-4c70-4517-90f5-08ddc2ec7a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXJWSmpWSnpaZEJWdTFXb1pLbFJmMlZjUHZ1M09wTkNRTFpwNkhjQmp0K0dC?=
 =?utf-8?B?OUk0SWdwakl4eC9oUW5XT293UXlWUHdNS0pQSnRmdDc4TEJsN3BQNTJYUEUx?=
 =?utf-8?B?RUtwdjN1TDdZd0JQSWhBZ2hpbjRabkUzelhENzB3RUNmSkJFbWdweCt3UXpE?=
 =?utf-8?B?eVNpWnA5Mk1qcjc0dWp1TVV4MCtTYzdub0J0aGFEMSs5bW5nVnh1aDNocSs3?=
 =?utf-8?B?NmNLODc0WllwaExEL1VyVWVNUEhWQWpwU3lQa0o2c1IzMnBhQTFxL1B6dEd1?=
 =?utf-8?B?dnZabVlENW1ZNmRDNkZqSlpNb1RWbDhVRWZHcE9ydWpZQlhyRW8ya0hTTjBQ?=
 =?utf-8?B?eGtCOHpZcTNtZklRKzJRQW5Bbk42WlRDWEU3cklTWmE3UkVQRXd3dXVCZWdh?=
 =?utf-8?B?U3RvbDVwQUduMnprcE95MWxGVjZsazBFWDdLSVZqaTBiN3JxZmZxRnlSUzRr?=
 =?utf-8?B?aWIzMTA1cmVtQUs1RldoditzUzYrUm1kUGVYZXVHa3E3REcrTWtiTXJKZ1l0?=
 =?utf-8?B?NzJyNElLOUR5R0UxZ3I2THhwWUYrQVF3SzdGem5vcVdnbjdrVHF6RlpWc1Nt?=
 =?utf-8?B?d0g1WGJONnFuK2hBSzk3UFNUMExIanVHQUdBbk9tc1J1TnZMNFhYYU94ZVRN?=
 =?utf-8?B?aGRwVm1yTWVyMDJ6dlg2UFduRVJjelgwSXlsQmYwdG91a1psalRYdnp4WkdO?=
 =?utf-8?B?TFNLNXUrNUpLVWxEQ0ErcVZVY3ZCK3VxUWZDMk9LWHVsdDd2d3ROaUJzbjlB?=
 =?utf-8?B?eGJLb0NYalN5VU42a1h2VUlDZVoydmN6Wjg5Y2VVcnNOenluMzFxQ1ZLUEF5?=
 =?utf-8?B?L0JtcFFNZ002L1lJRkRMSWdTS2xUYk4zcjFmZXdBMW5yMGNCVmg3YUl2emtU?=
 =?utf-8?B?TWlsQllWRGJjNmh3SmZ0TzgzdzY2alNoWDRxWmhURU9FQnpmQlhuaE1EVFpj?=
 =?utf-8?B?VjZCQ0FoTkJTQ0o3VFAreE1zOEl5Ym1qSDZCM0F6TDlEWjAvQUVQbnRwRG85?=
 =?utf-8?B?YnlJeW4rYzBaQ3loNFN3VkFPQy9BdzVRZGhneS9GT0ZSelpWVTZJTFd0SVlo?=
 =?utf-8?B?QzFPZTdJTjdNVzJUM0lWNVU0WGV3NVJNSFMyZFlvUmg3VnB6and1TDlXeWQ1?=
 =?utf-8?B?SEpVOUliRERxc1dxWjdIU29zTjZCeFZrOE5HMlowVnVMeXd5eTJHRy9tQUdx?=
 =?utf-8?B?NFdNenlHL0VHMG9WUE1MT3pPdXhvRWthVU5YbzE0Nzh4VVBMNXhWazVaejZ1?=
 =?utf-8?B?REhWdDUzbG1RNUgra1Z6QXhwWFY5dHUzbTQrZkN5Ri9lVExHVjlmNWhOdjJX?=
 =?utf-8?B?VFhESUwyLzBXZ0t6d2FnZUlxUlg5STAzaUQ1NmVZNUtDREdpclRGWHVHcVlr?=
 =?utf-8?B?YWNiTm0yMDV6YnFucFpOZ3hjdjBMN2I1VjNORkJiTTgweFNvT1RpZWljbUxi?=
 =?utf-8?B?eDM5RmpIdUE0d1ZqVThtbHhBeE0rTTBRV1oxSUZEM2FFR2FQRmNWSDBtMDlT?=
 =?utf-8?B?MDVpM2FGTmFjUlo2dFRPdktXRTJpVmluUTlPQ2dXOGo5ZGxqSm5VbFdpSzRW?=
 =?utf-8?B?aUczazVZMklxckFlRDErSmFod2VPSnN6TFkybWdVZk1QeCtmdFl6K2pmWm1Q?=
 =?utf-8?B?Y1MwKzFpbHJrbTFxV3J1blIwd1UxQXlwQ1BPRXRMWnlaRE81M0g2cEFDNWRs?=
 =?utf-8?B?NGZtc1ExM0JHbjBxMmJVanRkdm5OUHNSK0wzZlRZc1VQNHp0dXFnQVFJMGhJ?=
 =?utf-8?B?bGh1NXl1YjJBamZWV213cGsvZjduc1Yxd3NvU0d3WHNkWFlUQWE0L0VtOVBD?=
 =?utf-8?B?S1hLUXlxWHFsa2NycU5UL0FEMzlkeERVOGNpQmVjWk13dkV4aDJLN3RSSUpN?=
 =?utf-8?B?ZVRyb2tKdVRFbjFldC96VFR3eTB4NW16MG5ySkxoaE1mb3JGZlRpNkE3cDN4?=
 =?utf-8?Q?/wHMrFKtZ0o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm04djJhVzJwUnFzRGw5R2J3ZkVtRDdSM3pKSjVrMmt6V09XcjMrUVV5K0Fv?=
 =?utf-8?B?OGpyd3pheGJXWnNMeXJ0R0dqbVNOMUhWRUEyWGhQcDYyWFcyRGVkRmtiZFNW?=
 =?utf-8?B?Q0I3eWJsQmdzNDBuc0d6UHAycUdneS9MM3I4SEpEbzFJeUE2MStBaTdMekZm?=
 =?utf-8?B?OGZwMFFRZkVkMnh1TUZaZHhJOWRCTytsNlNjN2JOclJJVERnZjB0MnEzMW83?=
 =?utf-8?B?OENsUm9Dc0JFSno1TFc2TUdHeGZEV1VjamozM2RZeTlJRndCMWtKMVdkZVo1?=
 =?utf-8?B?a2tMTUV5aXpKUUNNSTU4Szd0OVVQNzg0TkZKVDZkM2FHRUU4bnlBbm80M1ZZ?=
 =?utf-8?B?M0tTTWE3K0g0TGYyVEtpR2g5ZldqcjhPblpXZXVhYVJEWkdneTQ0aFVmTUFS?=
 =?utf-8?B?dFdVeTExeE5SaTRiTThyaDFUWDBZYld6dWkzNkZTM3lTRE1sWGZ2YWpBY0wx?=
 =?utf-8?B?aHlkbm5xRndkMExpSHFwNCs2dHdzTWRZMnlabkNVbi9lcEM1U01NZU40dlJm?=
 =?utf-8?B?UnJYTm1HOWwwSURZanlFYmVaNmh1NEdTeGtkL0pSTGIvR09VTDhTUmhZcDgz?=
 =?utf-8?B?WDBIUjNESWI0OXgzZHQ2enpnRDF3dDFFRTZ3aGZOTjIwNW8raXN1OFdRSi9C?=
 =?utf-8?B?TnZ2SjJnZ1o5ZzFLMW02a29XaHFRc1ZkZm9ZYTZuekk0bFAyTzRzd2pWVHZq?=
 =?utf-8?B?TCtEWVFtSlBnUFZrRm03Z0NHUWsrS1orUW8yem1XcjlWcStnWkhraGFuZkxy?=
 =?utf-8?B?NCtyVDFvV1dvZU5RQjFqQTJZNnBxZFRtdXEyeHpuNWtiOG40YWd3SElQWmVF?=
 =?utf-8?B?bThLV1FIeklNK2VBaFFIeW1lbjVYRElkNzV2QTVzRXdDVy82bWdCZS9LRnpQ?=
 =?utf-8?B?RWp1Z3VId1E3L21iaHZUVzdYZFlHZnR4djRUU0JlbnF2eXp6cGdxTWhkNndx?=
 =?utf-8?B?bXVBM0ZIMEhvM3ZDOUZXdE1Ha3Y0dWgwZVRjM1hBYzduYVhucUV3TVJ6MmF5?=
 =?utf-8?B?SFdQSWd2VWpVSU5hMno4akUvN1M0ZGlwN3I4d1hMUVNva1JFbG1GZ01JRDgz?=
 =?utf-8?B?TXd4Z0xjRlUxNlVNNVFveTEvMmkreVhmUnhweGZTL2YyQXY2WDAwMSt3bnZP?=
 =?utf-8?B?Um1SMGpvOEszTkVpOTVVU25GMDduUWx1NHUwbzY2Ly9xdTFEQUpLdzltbzhz?=
 =?utf-8?B?ZnJkNXl6cmk3dnlKbVhwZmoyY05idHJ0VHgyR2FzUHdzOWYwMURhYkFJTDNQ?=
 =?utf-8?B?QXBKYTNSaG4wKzhONUNjZWJSdXNkK3A5bzhuaWFZVlpIUlFEQWppVVFKMlVs?=
 =?utf-8?B?cFhuMTlWbmFxaXdwdjMzTFRvYXlocEVudGZEU3h3bXpBU25jaFlrb0NZUzhM?=
 =?utf-8?B?TGdBNUVZMVM4a0xnUC9KR2NLaWdUTFJHQjcyZVMrRG5VeXdQaWRxbUtkUEVy?=
 =?utf-8?B?dEZTbDhqa1Arb1h3VmtDWGZoajRDdm5oTDd5U2g2ZGZ1SkpneU1NejZTYWxh?=
 =?utf-8?B?Ujh1eVNCSVNpMUx3U2liRHVUNGExbmY5cWpmdTBKTVBxMTZHNE04UStFYkd3?=
 =?utf-8?B?eFlORERYWFB3SmtpWXlOcGRBNUdHbHVKOVRUVVJldHd0bFJCa2xBaFBKSFh0?=
 =?utf-8?B?KzFYOHptMjJPMWEwVEkvYWxmeU13Vlc5RlMvRmtWN3lrNkJmYTZhODVhTkNF?=
 =?utf-8?B?NGhBQ29lUHFEYTFKVExPU2xaR2FieFdRTmJ2V1UrRzVxUlZERnlrTUtrQVVn?=
 =?utf-8?B?SlYvSnlxY1gxVEVjU2VmR0JSVGljZkN2ZmFUV1llc1NwL1FpdGRSS3VmcHBt?=
 =?utf-8?B?cVdpdlRZR0ord3Q2a09odU55aVhpUmx5YlFCYXFhVEt5Sm1xbkhjZEVFVEJE?=
 =?utf-8?B?S2JwcGxrS21vaG9ORjlyN2NySWQ0UFlwOStkNFU0Q0dNZCtiNEdTUHRFdFph?=
 =?utf-8?B?ZkMyNkFkbFVwdEw5L3B2TVQ1em1QcHBCSWtQbTlSMzVpS1Vkai9RclUyRjlj?=
 =?utf-8?B?dk04Zkl5ZFExRVpvdS9VTjlLaVhMdDM0b3ZSVm5WWStycGcvL3N2QitLOC8w?=
 =?utf-8?B?MGQ3WE4vTzFITXo4d2MzZVFnVWM2Q0xNZ2s4RGYrYnVLNWc2eU9jMng0Qmhs?=
 =?utf-8?B?OFVPZjJyNkhPNmh3Q1NHU2paRzcwVGdtZ3F3Z0pNeXFLbW5oRzRpOWU4NnVT?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d3488-4c70-4517-90f5-08ddc2ec7a76
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:38:28.0060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnQl/QXs8JbrLFrEAbv7drL6/OFTkMj/CsndYH0EaZ/NDTbZsrKNH2LfW960gTmo4j/62dR+dDHPnmKOs8TZk313ymjCoIYafAEuE2H9k0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9016
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

Hi Jonas,

On 7/10/25 6:21 PM, Jonas Karlman wrote:
> eMMC erase and write support on RK3528 is somewhat unreliable, sometime
> e.g. mmc erase and write commands will fail with an error.
> 
> Use the delay line lock value for half card clock cycle, DLL_LOCK_VALUE,
> to set a manual xx_TAP_VALUE to fix the unreliable eMMC support.
> 
> This is only enabled for RK3528, remaining SoCs still use the automatic
> tap value, (DLL_LOCK_VALUE * 2) % 256, same value we configure manually
> for RK3528.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/mmc/rockchip_sdhci.c | 28 +++++++++++++++++++++++-----
>   1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/rockchip_sdhci.c b/drivers/mmc/rockchip_sdhci.c
> index 761e3619329c..f15ea7c9c6b7 100644
> --- a/drivers/mmc/rockchip_sdhci.c
> +++ b/drivers/mmc/rockchip_sdhci.c
> @@ -86,13 +86,19 @@
>   #define DLL_CMDOUT_SRC_CLK_NEG		BIT(28)
>   #define DLL_CMDOUT_EN_SRC_CLK_NEG	BIT(29)
>   #define DLL_CMDOUT_BOTH_CLK_EDGE	BIT(30)
> +#define DLL_TAP_VALUE_SEL		BIT(25)

Maybe match the name for the other tap bitfields?

We have DLL_TXCLK_TAPNUM_FROM_SW for example, so something like

DLL_TAPVALUE_FROM_SW

?

> +#define DLL_TAP_VALUE_OFFSET		8
> +#define DLL_LOCK_VALUE_MASK		0xFF
>   
> +#define DLL_LOCK_VALUE(x) \
> +	((((x) & DLL_LOCK_VALUE_MASK) * 2) & DLL_LOCK_VALUE_MASK)

This seems very odd, why do we need to binary AND before and after 
multiplying by 2? Trying to avoid an overflow somehow?
Also, where did you get you need to multiply by 2? The RK3588 TRM 
doesn't seem to be hinting at that being required?

I believe you could also simply use

#define DLL_LOCK_VALUE(x) FIELD_PREP((x) * 2, 0xff00)

and avoid having to carry the mask or the offset of the bitfield in the 
code (not tested though).

>   #define DLL_LOCK_WO_TMOUT(x) \
>   	((((x) & DWCMSHC_EMMC_DLL_LOCKED) == DWCMSHC_EMMC_DLL_LOCKED) && \
>   	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
>   #define ROCKCHIP_MAX_CLKS		3
>   
>   #define FLAG_INVERTER_FLAG_IN_RXCLK	BIT(0)
> +#define FLAG_TAP_VALUE_SEL		BIT(1)
>   
>   struct rockchip_sdhc_plat {
>   	struct mmc_config cfg;
> @@ -317,7 +323,7 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   	struct sdhci_data *data = (struct sdhci_data *)dev_get_driver_data(priv->dev);
>   	struct mmc *mmc = host->mmc;
>   	int val, ret;
> -	u32 extra, txclk_tapnum;
> +	u32 extra, txclk_tapnum, dll_tap_value;
>   
>   	if (!enable) {
>   		sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_CTRL);
> @@ -347,7 +353,15 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   		if (ret)
>   			return ret;
>   
> -		extra = DWCMSHC_EMMC_DLL_DLYENA | DLL_RXCLK_ORI_GATE;
> +		if (data->flags & FLAG_TAP_VALUE_SEL)
> +			dll_tap_value = DLL_TAP_VALUE_SEL |
> +					DLL_LOCK_VALUE(val) << DLL_TAP_VALUE_OFFSET;
> +		else
> +			dll_tap_value = 0;
> +
> +		extra = DWCMSHC_EMMC_DLL_DLYENA |
> +			DLL_RXCLK_ORI_GATE |
> +			dll_tap_value;
>   		if (data->flags & FLAG_INVERTER_FLAG_IN_RXCLK)
>   			extra |= DLL_RXCLK_NO_INVERTER;
>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
> @@ -361,19 +375,22 @@ static int rk3568_sdhci_config_dll(struct sdhci_host *host, u32 clock, bool enab
>   				DLL_CMDOUT_BOTH_CLK_EDGE |
>   				DWCMSHC_EMMC_DLL_DLYENA |
>   				data->hs400_cmdout_tapnum |
> -				DLL_CMDOUT_TAPNUM_FROM_SW;
> +				DLL_CMDOUT_TAPNUM_FROM_SW |
> +				dll_tap_value;
>   			sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_CMDOUT);
>   		}
>   
>   		extra = DWCMSHC_EMMC_DLL_DLYENA |
>   			DLL_TXCLK_TAPNUM_FROM_SW |
>   			DLL_TXCLK_NO_INVERTER |
> -			txclk_tapnum;
> +			txclk_tapnum |
> +			dll_tap_value;
>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_TXCLK);
>   
>   		extra = DWCMSHC_EMMC_DLL_DLYENA |
>   			data->hs400_strbin_tapnum |
> -			DLL_STRBIN_TAPNUM_FROM_SW;
> +			DLL_STRBIN_TAPNUM_FROM_SW |
> +			dll_tap_value;
>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>   	} else {
>   		/*
> @@ -663,6 +680,7 @@ static const struct sdhci_data rk3528_data = {
>   	.set_ios_post = rk3568_sdhci_set_ios_post,
>   	.set_clock = rk3568_sdhci_set_clock,
>   	.config_dll = rk3568_sdhci_config_dll,
> +	.flags = FLAG_TAP_VALUE_SEL,
>   	.hs200_txclk_tapnum = 0xc,
>   	.hs400_txclk_tapnum = 0x6,
>   	.hs400_cmdout_tapnum = 0x6,

