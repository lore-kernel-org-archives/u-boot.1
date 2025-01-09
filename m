Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30057E77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18AF806DB;
	Thu,  9 Jan 2025 03:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v+asyOlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C6980691; Thu,  9 Jan 2025 03:23:34 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DAF806D5
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMOAGxp/wTgbf2GLKJXs4VlkpggH/rP9Mb/2YRro9tFEUXgfKyTQBxCPMcPRwocU0AkFRAAdv0t4seVaIdna36eUL4ZDlfLItHT7tZShNealiQ3AdKlWeyOx3vYg9AMAyR+ScHIWLsZhL2BTTsIFhGLAIl1o1BrXuhc8YOLU3s0hJsm3kFr0IjPZ7ImkwtfyL1ErFmxPTlJ+7qNLGtooEEKY1yMgAB8N/cyjuc+QRNiKvZWQWNrzAaxyh5IIEiuctfOzDWCsl/AehNWk56OjbjWBpPfyCz4SJs6i7N9iySzqEJWstQJxSwPFPq/q6NZvXEHVgEzL4Ws9M1Ny8AHKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xShNXIDbXB8pv7yzWUJsn7rSvYlKEfWH5DTk34j/QN0=;
 b=VjRBl2lrpgIAje8GYnFrVrQmnuDLv3lj+ojOTiOHIOV093UoJnW6de+AxV0mRr4/mHKXODCpmeBg2FT0lfBVB/kEZQiIr5qZ2vvZ5EaRI60YchTLvtTUsvlh30e5PisdxydlDruci/fpd7up+j9g0L5ZfHUOIuzKGCVEuDYy0qeUDpj5iBsTSnRmJ5735QSwGfJmlyQpKMqEcjvsFPOrqag45IlFlUv7LjKLoEGErgJo2EmvwX80lHmy/a/CmNVxBMLsm6acCeg9MPvpo3EudMjRWJrIAehkzTnNaf/yoeQ1fwqgPvz7fEVSjYwlGPiQTf0TTmCMcWhSJ512kpx/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xShNXIDbXB8pv7yzWUJsn7rSvYlKEfWH5DTk34j/QN0=;
 b=v+asyOlBRYcPHknwF3Q6LniGTElPD5GehrMvtDyYRVOUAb42ihy86b02AGmmVTUJ2bVqXuwzvwlkI7XdcFely7bC5h2B+tZBWFaPsqHjdRh3fUffPVPYO/xUunQJxwoqlBrVZ/+TTRnn/6Z3aqEss8nTZNqF70P0Afo68xq4Pvllrpi4uyJ47wyYuLSxOlnYi3JE0QTV5OzQb5cHtfcsADKU0vCO5WYZbxvOr8cwqLkgjiM/9H6FdPhW2VD46vucjWNGn7mJtIQCeGeM/g5dNWBw4iX0MH/YEL+gYmLP6PNuv8gCcSeaQeGn4c7qNWp3OUNqIHDruCPF/M7yTQj9lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:31 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:10 +0800
Subject: [PATCH v3 09/17] imx: imx8mn_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-9-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 826a04a5-d8cc-4dbc-b712-08dd30549bf9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDRaQ1lrd1VjV0Q2TGdoa3RnVGloSC9GaGFlMHFkNktTZUt5TlVyOXR4ak9q?=
 =?utf-8?B?cDNiSWRSd2JaMzhUeE5BV2dYNkV0TUtRMy92bjBTMkNJcE9pZllBb2dqS0lm?=
 =?utf-8?B?MUtiTnVCMjZlSUlaUVIxeE9sWjI5cFBBeE1lQjlDWHE2c3A3SnhmRGN6Yncv?=
 =?utf-8?B?T3ZPblBNcGdKZUhRQjFiNzcvekdHS0xBSmJXY0Y0NkhybEFSZVBwSDFpd0NQ?=
 =?utf-8?B?bFowb3M5eUxnWlpVMEsyVitXY3M4Q1cwOStQWWFWOWJuam9kQWg0akxKL2or?=
 =?utf-8?B?OE4yeEZEMU51andReDF2M2VXUitmejFGWHE4Z3JFNDJxWVQyMkFvbHprSmFM?=
 =?utf-8?B?eCtCZWVlY01lcTQ5MEhjaFBqbUxOMVlIM0xzaWlrTjVKL0Fjd0tiazZZM3Fu?=
 =?utf-8?B?YityM1lZRGNaZGtrOVVEM3BlUTBSeUtMY2lJMWQrbXVzN3EvUDUzWHdEdXF0?=
 =?utf-8?B?S21WYW4vekVKeWVLalhBNzVLSGhsSmpubXkxdmRUMXFWeEJxZlJuR2R0Yy9W?=
 =?utf-8?B?anp1d21ZZTlKS3QyZFhjNmdLQTZOTStLSkpHM1NOeWU1Y1c3TGNRZ2FjYllX?=
 =?utf-8?B?K1hYRFNyR1NGZERvV2t5U2s4cU5jNmcwYTdXek1WQVJ0ekxKVzhOdW5zaVVI?=
 =?utf-8?B?TTN5b3VpOFFEWFh4UnVNMDk3dkVDSmFLc3liSHBrVzlJYWlPVmJXZDNZRFdU?=
 =?utf-8?B?UXVkeEpna0hReXZuZ3JEM1BzWit6U0dPZzliNXd2RGt6MWdlOHlNRUtGZDh4?=
 =?utf-8?B?UjN5cmhGYUozeWViRjFkeGcwclRSK0lvSlBpTDBuYzZHWGtUTlRsOXVVbUxX?=
 =?utf-8?B?WHhMYkpSMlppenRyVXJPK1ZvOWRNNEx3QlNRZG01VXg4WHE0SS8vZHJwK2N1?=
 =?utf-8?B?ZTMrVXJFZXpvUytiK2FzL1Bvd3ZDcVZoYmNtakQ4YXd1V0VPUTRNRzVqWG1W?=
 =?utf-8?B?NDdsL0NJYTV5VndtcHVIWkt4WVN1eGRQOEdIY1NNaXNQamZGcTR3M2k4QlFx?=
 =?utf-8?B?cDBCcHBZSTJ3dkVhVDlLRzdvS1puTlo5MzhDbmhCZ2FBUnFkeWZpVGZjREwx?=
 =?utf-8?B?ZXM2NUF1TjFWRTE2cndGbVdKdldaYUpOUlplZDgwekJVODhZNnhKK0ZHdU9K?=
 =?utf-8?B?M0l4UkJqTlJpMHBrV2ZZQ3BwMWgzSGI0TDU0OHBvQXQ1S0J4bVcyNCtiQkVt?=
 =?utf-8?B?cHFNaVpKQldSOTh4MkRkbVVPN1drZElUdWFkd29sR1BnbWRiUndJU21vcDlj?=
 =?utf-8?B?S290SE1ZYjNtQTJiTnVpUThKKzJUOTBicWwveHhhdkVWbjZVNmV6SjlsK2N0?=
 =?utf-8?B?b0R5RWQ4cy9yejhMbXQyK2JMOHk3OEc2U0pQUlEvT2U1VEhVUGtqSVlRZmVm?=
 =?utf-8?B?MEcwTjd1WS80OXMzWVN1WWhmbm5ZVzNkNmhrRndlZ0FSNUVzTjhQS1pCRnhV?=
 =?utf-8?B?Tlh1TWxaK2I2UTgrb3piNFFweWNpSitRR0tuWExPSFZpY0oyOWU1L2MrWjll?=
 =?utf-8?B?dWYzaFAvY0tTOXFJQU5HUkNuN0xyWVpRVmo5TWtVYjYxUmlHeFlHRlphbXJ2?=
 =?utf-8?B?cFRZeHlpOFVVQ2hRMkxiSmV1TFFkdGpWNnRyZWlvdmUvZlZMaTA0QWNoRDRP?=
 =?utf-8?B?NXlKNVg2UksxYXNFbE8wS0YwNFROM2xPT3lHV09UTHR6emxpdEVvVlpjRnFk?=
 =?utf-8?B?Mll3NFA3V1lVRXZzL0tyNEdnUFpxTlNCL2RaVkJLRnE0YmIrZG9Tb1dTK01P?=
 =?utf-8?B?ck9OT291cDZlUWRjOVlNWEN5bFJDd3hDcmYvakJkM2lGUEE4emZWc3N2UFZx?=
 =?utf-8?B?VldsN29JcEx2VytndzZSWTg3OHVqUytJUWpMQ3UxN1U1V3JzR2x3YmdZY0o5?=
 =?utf-8?B?VUc2L24yWWxkY1RSOERGSzRQWFZvc3Y4K05OMklVcVZqSUtZRGwwN21vOGhG?=
 =?utf-8?Q?KgHZ6NQhb3FcDzM2Y4OGGRl8WyKb0ycd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3pTTitQSDV6RmdPZFVra05yc29CdlB0ZmIvRUNZczVEcjc3SnpNL3d6VHFa?=
 =?utf-8?B?RVhRTEttbnZNUEJXRHlBclNrQktOM0Fsa1oxRVduV2JQZ2xqeW9uS0hUNHgw?=
 =?utf-8?B?UlNlbkVtQWVQd3YvTmN5eTdBUHZib1JDTkZHQVFaLzZGZzQ2ekRucCt5Z2VO?=
 =?utf-8?B?OFh4RHhVUDlRZHVQalA0alF1ZEJKTnJmZzlKaTJXYUlvQUN0Tmw4WHdIZlBR?=
 =?utf-8?B?Kzk1dXpDVFd3UmtMNEpHd1ZFMFQwUWhUNjc0NXhndFRhYXExRmJDWXE1b3No?=
 =?utf-8?B?dEFoaFJVaTNxUUREK29udXZpNURRWnpKcnRYTFYrUUlWaXQrZGdBQWpQcGdv?=
 =?utf-8?B?bldQZDNzUFBNOVJFRlJWaGYzTEN4QlZBKzBKdUZMUjVKM0NRS3M1Y2xKeEhm?=
 =?utf-8?B?bzQ3RWVLc2s0SU53NkE3RkgrV2NieStNbEppVDBrVHdLaDNMbENNT1RUU0E0?=
 =?utf-8?B?U20wSHZLNnQwKzJ3SG1Nb1FaUENlSDlNTXVYQmlGRVluVU5zQVg3Zjh1TUls?=
 =?utf-8?B?Vys0YWNQcnQvV01LU05WWENXV0xrcnVRcEE0eFZLbDJnc04rNVZyL2xyNjZI?=
 =?utf-8?B?TmY3NnJISXFTMVA4Z0J5T2FaSDVTcldxSnlSTTlwVXdDcWdwaFBtQVk4bElv?=
 =?utf-8?B?RDdWZm5jRG9nWjh3KzlwS2d3eDRmQmZxWkhjeWFVNG0zaUpCdncxb2xLM3V6?=
 =?utf-8?B?VXhydXYvb0xad1hEVFdlZDNnODRDQ25RVGdRaGs4OTV0MC9WRWx4WEtxQTBU?=
 =?utf-8?B?dk1RMzlYSGNzSXhWTGFSK09oL1JHNmh5WGl5M1U4U1ltL2d5OXljakE0TkNl?=
 =?utf-8?B?M29HSFo0S2FsdmJ6c3BXaVlvTFNrM0tFYWNrMjBkWWozdHJmOXUrODlFSEgx?=
 =?utf-8?B?OWYyNWJQbmwySVNMa0JmVFI4OEVraEdKQmFYRzFWS2NXREZ2WE9ZYU1qVVB4?=
 =?utf-8?B?anhYc3pzaGxISU5aTDEzbmZYMVIyL3ZUZGIxSEpMdHRac3djL1FBZzNubTBO?=
 =?utf-8?B?QmpLOXZ6SXZVd3IvTDl3ZkhidmFFWlY0S0lSTGhQcGRLdDZRR0RrQTRteStW?=
 =?utf-8?B?NmpXQUU4bHN6QXU4azNoOGhlWitlaU1ieHFXTFlzMnJKR2RPa2oyZU9TRUVh?=
 =?utf-8?B?VGx4M3YyOGVCajlNN2M1MGRVbDdpWkJGRStTWHBvNHlDdWlzVXdFdDJwWkhW?=
 =?utf-8?B?UVVwY0FMcWlLQmJhQ1JDaWpORmVWQ0d4VjJlUmJCQTNsQzl6cjZiazlkcm0v?=
 =?utf-8?B?dm8ybkc4NjNTYzJISEtCMkhRNURyUWRtUkF5d2lGQzU5b2l4a1R4aVN6QW9i?=
 =?utf-8?B?bnorWWdqV0RlVEZOTkQreTFod3NKNmZidUE1RUovOUJEWFFuQXlRTTRUZGFI?=
 =?utf-8?B?SWJpMjhWSGlQWk5OUGxnMFdEektQcENheWQ2QXhUSG11M05kRTBOaDhuSmtj?=
 =?utf-8?B?MktzcnZjbHozdm1CblBQbWJuQWtmQjRkV0oyc21ZOFpNS1loWmU5NjdTUk9m?=
 =?utf-8?B?Y0ZONDh1aXUxNEdJM0RoMVppRjBsMzQwcitxN0F0aWxwamkwU1picUhoRlR1?=
 =?utf-8?B?ZzVZT3JoWG96cEgzZTBCTzhQeHpJRUJBUzZwUHZIQ2UwcHQxV1E5ZitPOVJi?=
 =?utf-8?B?cHpuQnk4TVhoL1FmTlU0TUFST3lMRFNqNWhuUDRLaHd6aExOV1RxWkFnd2ZV?=
 =?utf-8?B?T3QwMVFNVDJjUnE4VmhIZEFwZ29sN2M4Skk2bHRzZ2p5TndET2EwYk5sOUEy?=
 =?utf-8?B?M0Y3L3BHOE55WTl3OXdPU2lxR1oxU2ZsRm1jbEtPUjE2ZVRwZUI2TzJPeU51?=
 =?utf-8?B?N0RWZExnN1ZvcHRkanhBUXI4MEVINUhPZ0xqMFBKcFlnbVkvNzV4VE40bnNC?=
 =?utf-8?B?S1NyYTBwYnVSbEVHNjhWS1doYWFNVXFSVG52bkUyOGNRbGpqVDlTOU5JRkpy?=
 =?utf-8?B?aGNWSkRqR1JqTUdsQWZ5MHpnWXF0V0l3SjFVa2VwZjZqdU42WW56eXUzTWc4?=
 =?utf-8?B?V1JOdW1GQWJEblQxZDBqWitzczBQM01QdTA5MWoycTBNK3VZVjIyOVIyMm9I?=
 =?utf-8?B?N0tid1pRZ05jczlqbHh1RXgySys3VmlFOVYzd2w3NjNlOTZKRnNBRkJTbHpi?=
 =?utf-8?Q?ZjVCj9O5by+xM/j1wzySJFIyR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826a04a5-d8cc-4dbc-b712-08dd30549bf9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:30.9619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEa8Su1mux8CeeSFVaAV7vF+h41uwQgmgB6WiD4Bcu7qRZNLZEwkOyLBIhOonp0uKtLhi1bYy500DGZtO4k9NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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
 configs/imx8mn_evk_defconfig              |  2 +-
 include/configs/imx8mn_evk.h              | 30 --------------
 3 files changed, 68 insertions(+), 31 deletions(-)

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
index 43860fe3f56f9a178bbf83dbedb6a2ca0bba19fe..967eeea4051bbb00a758c46bd1aaa3ce61bbb115 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -26,8 +26,8 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
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

