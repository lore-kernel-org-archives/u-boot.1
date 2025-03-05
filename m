Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF8C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CF858144F;
	Wed,  5 Mar 2025 14:30:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="D2Dbbfk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA2B81276; Wed,  5 Mar 2025 14:30:08 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A20807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6Cn3rCCVSOT8yAiK2Oh9G1ym6BMRkCuCOtFqZ6V2kJ+bAvgp6vf02a2sR4ADnaQsNIhfqUKbiPllQZd0Ep4ISWlde5ZLhZsaem4CB3oL+2B6F3OgMXyat3A3KVJdKhYAF4FrGr4Jb3a4oEOLtgZYANNUojKAbEV6t/uLDatKyFkThdG/CLStFNg/PfNeBaEy1u/T/I2WGCuhToeAPFpbG+PUihjF5lu0jDmMhjJSlpY9qGSMo5T5gSTFwk+u8tn2bSHdfphS3c8+zlLHTVkTkdwDnN3eiptTJBsGI4pAERzsTDU/mUe7zT8sHN4508wvSl++uOhdXj0Ps6PsoicAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFNWkcwWJHtLtP7wLxkU0cyeqf7jGX5cQ82Uy7BSHDo=;
 b=pz3vcOVvFcgJxJT0Vu7YUcfagNOMr1wmX1t43da84mJvW68+abA3dMpp/gxWX/OWes4QTl3k15aUtqydQNiVETDqaYYjjjKgDOFvDnalDPTgev3vVkTstogTxc6vYuKEnAeyBXJC98NwEgGxgG57kwWHi3GhsbLOxj7HadPNsky5Q1hqM+LuRzxXjQzmCBAvAo6wqxUk/fneUR/3Mz22OdsvzdYOVNd9BXwqZCSuKI80BIitD9a39ENVA06QdrogLFvJGVjyeMXgSjvhxssF3RvZssVeDDnOUEcHaAlCZedmACpS0C3dImL365GWzQlni8PQJPW6o3BD9c4vP8eWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFNWkcwWJHtLtP7wLxkU0cyeqf7jGX5cQ82Uy7BSHDo=;
 b=D2Dbbfk2HH3dQNZBohnL6Mi3J3vo9CqLon+qxaD3LNG7BbNfw2g5J0M+5VuFDUD7JRIRjIVvh7lGDoQXg7/WlATUbamMKOfqDMYMDHw7ucBLjXy2gOXxmZsW0mw/ACsM2ttT0Z55Ej9fIiuDy9x13y5tOwQ7vG/t1+UDKk/eGUWjqbgGWzD2gNp2IugjhPhRtFIKNbhGoOZ8PJiTN28cmJyoK1Xy0f39Gf3Rs3pKHBBKpz5xQGhaeVB/IZeWi1Fe3cy711FAbldSeabAg2jyyjVn3mXRlFQUyAb3hy/TRSkO0IjaHM+UyJji0kphkAcoUIaYv1q33jF7EfsSmix0qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11028.eurprd04.prod.outlook.com (2603:10a6:800:27e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:30:01 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:30:01 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:27 +0800
Subject: [PATCH v7 15/19] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-15-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB11028:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c2b95f-2c92-4b4f-cd80-08dd5be9d4ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUhINFNaei94bDBMbU1DUGNZNmwwTE1RWnNpRVVLbFQ3cEVNY0JTMldheXpS?=
 =?utf-8?B?Zm0rUkxoQlJWMUJjR294QmFITW1NeFB6YldFdVdqVE5uRExzcGV4a2l6TDJE?=
 =?utf-8?B?V3oyM3JDQ0UrU0lERUhnL0t6eVhMQlU5VWZIeUJxK1BqbmVEYmUzYisxa0t2?=
 =?utf-8?B?c0wzQlltN2c0MGZKL28xVnBLVGkxWWUwVVZRYzhNcTQ3aXNLNUVsSFpxV2Fs?=
 =?utf-8?B?L0RoQU9kMmMreEJyUlpwWmJ5ZEE5d0d6dk5hck9Wc0JWVkdDOVVyTDV0TW1D?=
 =?utf-8?B?WnVPcituWjFLSXRFS2kxN3FDOEQvRzB2dnNXVEU3aktwWWtZSVVyakpPWFp6?=
 =?utf-8?B?UytKUS9kMjZhd2tRN0JEZjJHMGhmZTBVZ29YZGRjakRkQkZzcVhPalRkaGZP?=
 =?utf-8?B?YThLS3dIYVcwWjlsVmJxRW43dE9hcEhjVkovVTR6N0JlZ0JzWUQvdDJGUUxr?=
 =?utf-8?B?ODJiWG1keXhSaDRXN1dqWHdLQ1Z4UXZ0bHZXUjZ1YTBZRFdGa2hySTQxb2JW?=
 =?utf-8?B?aTVhcFR5Zlp2cHYvSzB4eFpZRm9kQTlTRVVIbk5OUkxyZzMzY0JmOXU4L1FS?=
 =?utf-8?B?d2dIOEEvOUsyN3dJTjhMNVlBMmxHWXlMT2VCUFhjaFdpSW9hdWZQc28xTG50?=
 =?utf-8?B?dzkrY2ozaVdIOVVkY21vaHhtTVBYVTZNSzk5TFh2bmkxeTVrTkVSVUxTVDBk?=
 =?utf-8?B?MkxNQ2xzWGtDUDVxaG1lMU1ZQjVkQTByRENEeDl4MkR3YU9GbmZFYzVqcHdK?=
 =?utf-8?B?RDM4R1dIM29pL0NBeDV0SUZGdlBCbzgxM0dPNy9Rbm1zTjdUeEdxUFFLaTFh?=
 =?utf-8?B?aWhqYStaZ3ZZWk1mcjBsS2ZHT0c1eWh2czJiSkswbUdFdnpQOUxVTlhuemF3?=
 =?utf-8?B?S2hiblFaZE80N2Q4cDNvYVc5WWFWSDlIMWpFZkZNYmVuTVVWTVc0K2FrSk5Y?=
 =?utf-8?B?NER2cE4xZXhLeSszd21zREpSbkRid1ltMzRDdExyZVdFT3JNdlBpdUZZMHV2?=
 =?utf-8?B?QUNMOXNzZ1hUa1lMY3dyVVlCT3cvakdGdktGQk5Yc2JkZHkvSUJ2Z20yTzh5?=
 =?utf-8?B?czkvbnIrR2NmcWdpUVdFanNRbWd1OGZ3bjIvS2FJcFZFRjAzOHJCZFVrY0xt?=
 =?utf-8?B?bytBeG1FaWZMYnNsYkhUUkV6MnlhcUh2NndMSUxXelYrWmxNc3VzOTVQdnZT?=
 =?utf-8?B?d0FDSFJ2Sy9IaWs4d01UaFdlN0Z3K29hMkxUYk1PYU9MemFhTE5QMFdEQWVC?=
 =?utf-8?B?WFRpUnRuMXRFRnIwNjQ4d0dqREFlSCtRKzROZjZhLzdMdU9NbHJjSlc4Zm94?=
 =?utf-8?B?ZHZhdExtbm9ocC92ck5QTjFvOHh2STZJRWpyOW5xS0ZWWDZjcDJWeUFqK00w?=
 =?utf-8?B?YWR5KzVWbjhJQXQ1Z1pJd3NTckNMc3YxNTRqSFcyTURhaXhiRXBvVFFrYjNJ?=
 =?utf-8?B?NW9rUld6TWhiVHQ3REVyenovRTkyTHorVUJCdlI5eTYzZVhpc1dUVmFTMXNo?=
 =?utf-8?B?blV2NXQ2QlAwL2RrdlJlbGNyQ3pFUEpQVzU1YWdQaVMrQytvMjFRQmZLK2lT?=
 =?utf-8?B?allrYUVxa0hWZXh3dEtTTlBtc3VvZ2FFZFFsbmpnbU02WjZONVVHNHBzcm1x?=
 =?utf-8?B?S2cxbnd6bkFUL0lLZnlhTkEzRWM1WVNrTXNpR25vNXhma3U1QWpuQVVRMnZ4?=
 =?utf-8?B?MHM2US8zYVRGVHdqaitDN0FISmZKR0wvVmJXbDAxWm1hMEV2Q2hzVE9IVzBW?=
 =?utf-8?B?UHRnbGNtSGVkYzA2dDBSNzFDbE1FV2srY3pUcERqQU0wYStwVFdBdElMRHlx?=
 =?utf-8?B?c01OQTc3cXk1ZnFsUXBqZXlsVGF0Uk5HWDNqTThsaCtaT0pEd2laNFV0Und4?=
 =?utf-8?B?V0RvRmRDQncxRUNpS0NibW9WemZKOUhaeU9oTGpmNmlOVVhTeS9Cd0lGQXdU?=
 =?utf-8?B?aFJYTTBMcDBFd1hzdGF1SEJRcU9panpIaVFHYWxzalF6MjMzTU16d2lpd1lz?=
 =?utf-8?B?UEtpTUlXdzR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitWSTZubnVpVzRNeGp1cnBhRnR6dXJiSGNJS0ZYSGtHeHV2cUJONzNxQUNs?=
 =?utf-8?B?U3ZsWldZRVN2QWtxaGhaak84WWx4MVpoeklUcFpjYTB5R2krQk44eGxMOU9o?=
 =?utf-8?B?QkU1QzA1Q3NNRXBnUXNtYUJBa0dva1kxNGFwZjYwL01PbGYvbXRxYmMvVEFK?=
 =?utf-8?B?b1FhMGxVOEJCT3BwcGdRd0FTbGxXeXRScHYyRkpHOW9MMVI0NG9GUXJwSjdm?=
 =?utf-8?B?ZWljTnorZFFXdnpQUXN1UEtTQ005YURIRWs3VnNOZmJ0anN2Y29VR3NuNmZR?=
 =?utf-8?B?aHprUjEwRVNreHkxQU1mczlSWnZZT1RxV1FBZG9nVDZUOUYxU0ZFNmFReGdV?=
 =?utf-8?B?MERheXN4M3RhR0IwbnBsekNFOGY4eVQwQUFOdERtUjgzdlBwMDN3TFBrdWlH?=
 =?utf-8?B?eWdaTHU3aXVzYjlyTUk4ekgwc00wY3lHSmFVcGl6N2J6QlRvU1lSZTlKbTZB?=
 =?utf-8?B?WnJaT1FDKy9HN1ZhNG1ZWXhUaHdlOG9vYnVMMlpDRVlJalUwMkV3WUgySzhn?=
 =?utf-8?B?SXNYNE0wb0MyNVlIdEJWOWl3dzZXQTh3bzZUVXM5bFQ1UERkU0dwM2pTdG9H?=
 =?utf-8?B?KzNhQzhhSHRFaTRudWp2K0pyV2JvbGs4cElCS25TL0JQNUZaR3hyM2RTWjdW?=
 =?utf-8?B?RXpoaFJYVVNuRkZBSVduQnlkcC9JM0pSdlBTV2JhQkRCcjBYYkovL2poVFo5?=
 =?utf-8?B?dDAvdFowL2p4Y1F4UU9FaXpwSm1XS1VrUmhxejl4S0o0eHdYOUZObjd1QXRV?=
 =?utf-8?B?YVFwM2hnN2F4aHhvZmNNd0liN2ZLQkplMzhTTy9pVWRBNlRBUm5Ub0lpdW1n?=
 =?utf-8?B?N1NIc0ZRaEtFT3l5RkFPaXJMSDZyL1JxclBvcG1kM2t2aXZ3bWNUZHdleGx4?=
 =?utf-8?B?a204QnNYY1VteVRxSXZWK0NwN1EzZG9seWIwSnlaa25hMXVnbWw3bDMxVStj?=
 =?utf-8?B?RXdzVng4ZmU1RGdrb2VFd3NjZjNIYmJIM0xqdXhlN2dFZXhwQlFEMjFkdHNu?=
 =?utf-8?B?a2xnQllxN2ViNlJ5RXRwZkkyY2xUUy9KblA5WUIxTnZDeElHVHN0ZFM1RUpY?=
 =?utf-8?B?WWE1bitDczhuNWt4Wk1hbmZsKzdQQTJDVHZTeWg0UUpXL0xIYWRwUEJHOFJt?=
 =?utf-8?B?c2JEZ2l3cVdMTEE1bGZMMWZlaTcxQnBsUXNEVm5tQzU2NERZN055MmJHMGp2?=
 =?utf-8?B?Ly9OZzFXbjFBdkM1ZWNMM1JvcldPVmFyRitGelp6cEhQL3BrV0RCQ2Z2cjZV?=
 =?utf-8?B?VTFCeitzcmVHWkdUN3hVaTB6SlZmK0RkQ0JLb0ZmRWI3eW9PVUhxeGxUbmxU?=
 =?utf-8?B?WmJCSHIrc2ZqWHVrblM5ckdQcjR2MnRWMDZOWVcrbm82U2xPNFljbHhSMVZQ?=
 =?utf-8?B?cU91ZzBIVjF4TFFBWHNpaWVTTVFQejhZanBKRTZGc2h1VVp2RElXc3JmdFZF?=
 =?utf-8?B?YmU4bVErRTZRR3FmQ0FlR0F0bDhvNEZReVZKMUF2dS9xK09QMFZqQ3lPa2ty?=
 =?utf-8?B?MVlqNnYrSUdYcU5qRmlWWVlMU2s2WGFlMWxWS1BEU2JDdEowMDdSQTBTazlh?=
 =?utf-8?B?ZG4wV1ZxdmwrRElsaEl5blZ6R0ZrU0h1Um9PaE1yM2d6NlgrN0Z5akZUWHVh?=
 =?utf-8?B?Y0lSRUFKVWRhYXZqVXlaaEdXbUhQbkVSQ0lGL0ZtbXZIaVI2UFpOQkpxejd3?=
 =?utf-8?B?WU5KM0k5amJtVDYrZmFLNlcyQ2FndlNjMEhIczVkR3I5Y2tONitrUFlwWGdq?=
 =?utf-8?B?YkJqdGZWOHpOWGFyQ3hBSU95TFZVM0pobUZKWHZOZndIVkNlQzBKTzEzME5w?=
 =?utf-8?B?N0lqVW92UmpYK09kQWFXdk5OdkJJZXhYdWkwUUdNTXFZV0pnZmo0M0JLL0Y4?=
 =?utf-8?B?WUFCYmJncVdLNHV1NVl1c29NaWJDalBJWUk0a3RPQUtVOUh4UFZuNXE5b01F?=
 =?utf-8?B?dFpEaG4rOVJzZlgxOW4yK3I0Wm1UbFF2SkRabG5DQmJhbU9paU45WUhSSU94?=
 =?utf-8?B?bys1d1ltL0VjSHNJbjlHcFM5NmdrK0UzeklQazA5UUtsQWt2b084Zk9PT25D?=
 =?utf-8?B?VlBHdzRPQ0EvdVJtejhGYzJOcDBoa1V6NHJGSXRGU1FnWGVrdFlOVm5iVlBN?=
 =?utf-8?Q?/Ccxb0BTh7MbeTGIWz3XisxDx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c2b95f-2c92-4b4f-cd80-08dd5be9d4ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:30:01.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZcODWOwPqmWN4WgihCCKTzYeMKk1spP2+BGcrJF36nDTWmI+SVVxfWJSaDBb+BHHnFFDX4FQXb7KccHnyFPT2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11028
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 143 +++++++++++++++++++++++++++++++++++++++++++++++-----
 tools/imx9_image.sh |   8 +++
 3 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb5..b48e2b0396 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 0135b19095..94b1efacd1 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,6 +55,8 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
 	{-1,                    "",                     "",	              },
 };
 
@@ -66,6 +69,8 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
 	{-1,		"",			"",		},
 };
 
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -549,6 +578,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -558,7 +588,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -580,6 +612,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -587,8 +640,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -687,6 +742,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -709,15 +773,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -726,7 +801,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -734,19 +809,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -838,6 +921,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -861,7 +945,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -870,6 +954,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -892,6 +977,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -963,11 +1072,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -980,6 +1093,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -1000,7 +1114,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1031,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19..6523d1a0ad 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.43.0

