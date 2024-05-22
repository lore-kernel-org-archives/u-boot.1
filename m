Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F86DC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 18:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE6F87F8B;
	Wed, 22 May 2024 20:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Dgx5bax1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6B088013; Wed, 22 May 2024 20:03:28 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB90687F5C
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 20:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egae5SCHC4Musa6Muiy7jlRdBlTwx6ljmb7HdG/mLPYL0JfXb2tQeZpX9tmLRovcAsGcwRw5x0T/R5oDybJJc+QQgqzDhA5qS6LR4OVHN7C/ubpr4F44doQSqlWnDWqs2VXQ6VaOM1LUSwhJz00TtzIOtfN0LIyaRk/nOkCB8bOVX19jqUxuYgz+BNp5r2/bYuYkJ465QLoqBnGSnNTgeNCdVZtf6TXZVGo/JS51xZr5Z2QWeJABKZjeuH1E5YCmMmcTgzR07AIrSQten8aGayaaU4xFCyiKVu7T8dI7ozxYjdO3CMfZ5LnUB7Gt+oAOcaz6X6JsYdl6wCti0pBPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/+GsULx9kQveFe1xI7eoXJS+PNsRhWlMGfFNHkvwO0=;
 b=nlUYs7CjqwOKpn72cDuRxgcT/8M/FWjieen102VFlts88vjA1DGdWgKZzfAGN4wjoCWRHkgfLBKp8S8VZviA4JgWDS5n1gycYDltzL+7oMRi4RVYSRf391r5iIlXH7SG0/mWLQ+jDufpfbo8TasUIW35QCGZ0ryWuyZdQJdjfmwg7n9FtatGsSbNstdi21avzAyUQw1Dm0hCtwtgBz7lbjVtSXTJxzG9Ob1D3MsF0hfnk6srCJu7/Sp7UnYrUCGT6IDZRMx/23Obba/qKR3XUBD5VobypIbuJYbW1Enqtv/VwFkZl+ZPq09HisY5vQYG0Jbiq4yjnZfpfR0+2FDeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/+GsULx9kQveFe1xI7eoXJS+PNsRhWlMGfFNHkvwO0=;
 b=Dgx5bax1uHNyuDCGULN7rjEnu46oOPQgwv6QKcNkd9uztfXqiPvm2TCpNVLgoCVwYg0EhOnNWzboKw5ibvauF6MSrqiIoTedfLRJ2iOpsxBXssXweQiFciZOz8LRkQYDaIxhQ2I0713UDVqb/AZznrjOmrvjODLfSBuL8DQbRpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by DB9PR04MB9330.eurprd04.prod.outlook.com (2603:10a6:10:36e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 18:03:23 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 18:03:23 +0000
Message-ID: <7e603c4d-bf76-4b38-894c-30d2cf128217@cherry.de>
Date: Wed, 22 May 2024 20:03:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add ArmSoM Sige7 Rk3588 board
To: Jianfeng Liu <liujianfeng1994@gmail.com>, u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki <jagan@edgeble.ai>,
 John Clark <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Riek <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tianling Shen <cnsztl@gmail.com>,
 Tom Rini <trini@konsulko.com>, Weizhao Ouyang <weizhao.ouyang@arm.com>
References: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522165801.1871915-1-liujianfeng1994@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0057.eurprd09.prod.outlook.com
 (2603:10a6:802:1::46) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|DB9PR04MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 36722195-9bc7-4ab2-425e-08dc7a89787b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a2FtVnVYakxua2lSUGZHMmFPSGhjbEpXbVRvU0xPa05CSjhtVndydVN3endU?=
 =?utf-8?B?cUgrRWFzRnVycnVWOGZFY3BEYnY0NG1weXMzbGU3UlIvVnMxU2UyNUVITzBr?=
 =?utf-8?B?Z0tZSlBpNnNXclJGK05zL052QjlCSTcwcHQvMFM0d21NQWgyUXp0Mm5FdEwr?=
 =?utf-8?B?SHlPSVUrSWlaOFM1UUhhc093akk5aU85blB1bmxQZ0F0SkpmSC9rWFNwYlY3?=
 =?utf-8?B?WjhZdlRRbWo2UGR3RWEwY29nSGt1ZTNYU1lJV3hpaU5TR3JKSGJDb2hnbXRS?=
 =?utf-8?B?QmM4djhXaUdpcWhPQTBIemJES3U3Z3JtMVlqUGU0ZlBBSk1ta3R0ZnBIYmNi?=
 =?utf-8?B?VTc1Vjl3Z08zNjFUR0drUnFuV1N1QWNWckVONFFCUUd6djNSeVRlS1NDN0tJ?=
 =?utf-8?B?MnVhdURmcTFqNnpnRTlBdWY5bG80S2NVak9MQlF2Rk45VEtlNGVHRVJIc2xU?=
 =?utf-8?B?Mkk4RnF1TitSdE9DbkpIbkp3aFNuYWJFaFFHWWFkUDhtSlJ4d1M1d1o1OEpS?=
 =?utf-8?B?T081MlRwcFU1NDZxaWxKMm1tMEZFTXdFc0ZiWlJuQzB4QWtmTTBaajJTaS9i?=
 =?utf-8?B?T1FGM1Mydy9uOGxWaHJaNnNjQ3BxZGlkOFJxT090YTY2cHR1bmVQTkdrcmRz?=
 =?utf-8?B?TmFZTjY3dk51d3pXb2o4UmJGMVJSeTNDMkRDTlR5SUUvQmxHYzBBdzVSS3dt?=
 =?utf-8?B?V0lpcHVRcjVsekFrMVNZU1lBTUxBejB4UkQxWU1mbjlEZmhxWnBOdThOQUQz?=
 =?utf-8?B?R2JUMlpxMGVPcVFkV3NDVU9DRGtHZWpLRklwQWtrOU85QmhkMHd4SDVVNEdk?=
 =?utf-8?B?OENCcWdPbVBSYk5IbkR6MTBEVmcxaC9icUZxVjlwNFNnMWhiY05MVm1EaTY5?=
 =?utf-8?B?K1A3QkNMM0o4YXA5TEtnemcrRFVmcmpwdVRHald0UHh6UWdXNk1wNkFnWkxV?=
 =?utf-8?B?eUdva2JzdWlTcEI4T0Y4cVBxNjdVUmxQVGxEdnByWU1mOGxrK1l2Y0FSbTBD?=
 =?utf-8?B?NE8rZnp6VzU5SzE0ajJTZUtwemY0KzNKWG4zUUlRZFh3Q3lPYVFzM1UveU1S?=
 =?utf-8?B?TS9Bc3h5RGoyL1VHV2VlNUQ5L1JQbjc1WHhYN3lyM0pKaGZoalFBTnQrTEJ6?=
 =?utf-8?B?Z0xDeGJUWGdiSjFLd3BEbzdFcEUwT3ZHNTdoYi92VXVwN24zU25IVXlycDhx?=
 =?utf-8?B?a3lENHVkYjBCb0xRbDdLRW1wRVFLckJkeFlVaHdBaFdxRUpuazdNbDM2Yk5L?=
 =?utf-8?B?OUxQbHhHb3ZES2pKYjE4SDc5OXZUdDVLMVNJNENvcXk5c3ErNlVEcGlJVFlz?=
 =?utf-8?B?T2ZEUVpjcU9ITjJwVDNPQlE3eW92NUxMOVRwbnpRUUJ1dGk5Skt1SU1jNy9Q?=
 =?utf-8?B?REUrMS9Yc0l0U0NXYVFocmdwZks4MEQ2b2pDakpQdTk3MVJUbFRsN2syNHJh?=
 =?utf-8?B?YVl4d290WFZwSXN6WEd3MGQrTENEeFpUTTArM0hHMEZyUTNWdmd4TmJxQjgx?=
 =?utf-8?B?bEtPR0l4TVM1R1VNcU5rL2I4d1VVWHpDMXZRc3l1cWVVWEtzb2xlOWM3akIr?=
 =?utf-8?B?UTRPQi9IVVJQS0tBNnNQb1FZMk9FZ0d3WFQ1MzRkK1kreEZvUzA2SWtoTVMw?=
 =?utf-8?Q?Rk4K31lttwo9J8LNvJlb3q+K88z4z/ud0+dIgoJwImh0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEU5TC81aEJoTVhXUDNqdEhUNG1kVlpFQWJLMTUwcjU1V3lFQytLcVR5OGN0?=
 =?utf-8?B?K2hQVHhldkJSb3VvblRwT0hpNXovU0YvYUJzTkVBcHZsWnJ1UC9XbTU2V3la?=
 =?utf-8?B?bW1ZRmlibExSOUk3NTkwTTBXd1BPNmRJMmJRTWl6TnpEK0pReGlXV0xsY3Ew?=
 =?utf-8?B?THFrYW5DZm5LNUxaY25zK0dNRVB0dGZyMnYwVzd6NEFDVFZkZWlpMGxRNzJN?=
 =?utf-8?B?MjFabXlIUk0vMmRQUzNnR0k3Q3hKZFByZzNQRHVzNS80NDlJaHdUdm56YWxz?=
 =?utf-8?B?bFdGMUdqQkUrSUQ0OVdNNmFsYS80aWtOd3hkRFJ1OThCME5WSzNRT1dzTk1k?=
 =?utf-8?B?ZkxUV1hmTmZEWWFiVk93R2V2cEd1TjhzYVZCbUF6RFc1S1dOQ0dUZ1dmMVFj?=
 =?utf-8?B?UUlLY0tsb20xZXdaeDdYR0c4YVdjajFORWUrbjVScVpLb2owYmxOK21pc2or?=
 =?utf-8?B?Q0VmcENrUHhabTZXUmVNZ1hkdnBhM3JIRyt6R2l0SUgvQmlFSDhSK2NwbnpT?=
 =?utf-8?B?dm9DZGlyYlhjWmkrZU04RVJUZ1BKd1JtbVQrcW1KSkViRmNLbnpVUHQrVVYx?=
 =?utf-8?B?cG90MlF5L2tHUWFDVms2c1dGNFRHb2tibERmTDNuZGJBSzFmdVZ6WEZHUEVN?=
 =?utf-8?B?QjRzcktaeGUzZE1NdEdJY05xWVRGTzRNVGYyQ3dXNTRoSXo1WC9FMDBsWFpt?=
 =?utf-8?B?aUczRTB6VmZROXAxekh3YVlzN0libFJFaGlRZXlPTlV6YjliVHh1RUV4REln?=
 =?utf-8?B?UlNqSXR5N3BUS2xJMG1BM3c4M2NWQm4wK20vVXdmUXAzMGV3NDF1UnFlOFcx?=
 =?utf-8?B?OTZNMHFuZnZpejcvaXpHR1VJN0d2WncxcDl1ZGgvd1ZuUDNhMHQzMlpMKyt3?=
 =?utf-8?B?c0hkYkxBcTFyZTIwOG9Ddm1wYkJCRGFnU3k4VzdCbmZrT20vTVZZY3RnTVRl?=
 =?utf-8?B?dHVyaXJQdVFxeFFxN1ZIcUFPYmpnLzY4azBpMVE4NnJFM2hBU09rcE9tTjJk?=
 =?utf-8?B?Vk82THFEczBHNEVtb2lzOHN2cHROK2VMU1dVcGJVM1hYcDZLcU9ZRTRDamRY?=
 =?utf-8?B?Vi9uSjBLZjlvQXoranpMWTFNUi95bHpRekhpQ2FXVXd4TVZUODVTdlZYVHk1?=
 =?utf-8?B?T05MOVJFaFRpZ1F2emE5RUhlNVladndua01PVElJaVlBMmNyTllSbk53TFgv?=
 =?utf-8?B?TzU5ckZMamtzRnN2M29IdTFBcklMZmF6TTBGZS81R1FkNmVVeVkvRkN2WEVZ?=
 =?utf-8?B?SUJTZlExZnBVcjIzK2FEd293b0pJa3hWRytId04vT2xzRjJQYlFIWDM1MDZ4?=
 =?utf-8?B?TUVyUVFUSk9jLzlTV2VzbEwvMk1DbElqTS9pSHJBK1JFMDFmejBoajBZNnhH?=
 =?utf-8?B?TUJjeXo0K05sSnVseVNFa2lJcTRxWkpLQzJsQ3NySHBNVjIzRS9qZGdqSXVm?=
 =?utf-8?B?WUdQb25kRkhIODhOQm9uQnFzQlZoR1BhVDNaMHVIcmYwMjMzTmdVd1Y5SnNo?=
 =?utf-8?B?NG5UNk1LOFJKTWtqdE5iUVdUWFF0T29UMU9NZjVrUkN0MmYvVXBkemlrUXNL?=
 =?utf-8?B?eGgveEZLOE02RzdhcmJzMWRvNWhJWTUwa0xlaUxlMXdMUnVESW1ZeVovUlZZ?=
 =?utf-8?B?cjdOV2phQVN6b1RCTnBlWk1zNHVYYUNuclgzUk9xT29VdWpvRE9IalRMUzY5?=
 =?utf-8?B?aHFwVXR6Q2krUHlRazFlRldYUVY0NENicCtIWVI2NktVR2FuUWs2MGovSUhm?=
 =?utf-8?B?WWx1MVhaWHVpaFd1Z3FLRkhXaVhZSUpZZ25YbHMydlJFcm9GZTJNczRGZEpB?=
 =?utf-8?B?bWdzRTFPVDNQWHBCQlphOGNEaVRROWxUeEw5TUlrbjI2SmZPZVZlNElSVzN1?=
 =?utf-8?B?eWl6cC9NNmlpR3JPdTI2WDRISm5MbUFVc1I0OE80R2FJQkNHYm1jQ1Jhbmdw?=
 =?utf-8?B?R1ExL0xReHFpUktlY3FpOUNLOURzMHhuenhhMENUaXgzamZmWFhMV056aUhq?=
 =?utf-8?B?OThCM04yOE51eUdTT1RoS1JnMzN5dFdIS3lNVHlQTzZSZ240dndSWnNtaFJJ?=
 =?utf-8?B?TEUwTUh3Tkk4Y0Fmb1d3bisvc0Jva1RJc0EzbGlMVjRGdWExV3RpeWxGMnZu?=
 =?utf-8?B?RkNVSERnQjcwNXQ3MHByZDVTM3lKWXpuTEhNYXRVbC91K2FNTThMemQ2UHBw?=
 =?utf-8?Q?G6/mIvpIwUFwDR4FufbTOP0=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36722195-9bc7-4ab2-425e-08dc7a89787b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 18:03:23.1590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ83Wzyl3y/pqrG1E1sG0lL/RqfRi6sPW65B3dVJzGDGdWYivBTWuELTP0v7N13vN8HNY/zraB77gMj56QInMDuag+EuELJneoQJ+aVNC+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9330
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

Hi Jianfeng Liu,

On 5/22/24 6:58 PM, Jianfeng Liu wrote:
[...]
> Note that these commits:
> - e18e5e8188f2 (arm64: dts: rockchip: add USBDP phys on rk3588)
> - 6fca4edb93d3 (arm64: dts: rockchip: Add rk3588 GPU node)
> are not synced to u-boot, so I remove usb3 drd nodes and gpu from kernel
> devicetree.
[...]> diff --git 
a/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts 
b/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts
> new file mode 100644
> index 0000000000..c7b46536ec
> --- /dev/null
> +++ b/dts/upstream/src/arm64/rockchip/rk3588-armsom-sige7.dts

Sorry, I failed to explain properly what was expected.

dts/upstream should never be touched except with 
dts/update-dts-subtree.sh script.

Sadly, your board is not supported in v6.9 yet, only in the upcoming 
v6.10 :/

So we have two options, we keep the dts in arch/arm/dts/ like you used 
to do, until we merge v6.10 dts in U-Boot (probably for v2024.10?), or 
we cherry-pick the changes for your board with dts/update-dts-subtree.sh 
script, see the instructions in the docs Tom has started writing: 
https://lore.kernel.org/u-boot/20240517174930.1028063-2-trini@konsulko.com/. 
I would very much like to see someone starting to look into the second 
option :)

However... it seems we'll likely need to also cherry-pick patches for 
the GPU (should probably be straightforward as nothing would be using 
the GPU anyway in U-Boot) and the USBDP PHY... but this one we would 
need to update all -u-boot.dtsi for rk3588(s) boards that have it 
already to make it use the new label/DT, make sure that the driver still 
works... etc. Maybe not a small feat, but someone will have to do it at 
some point anyway :)

You'd be the first one to do this cherry-picking into dts/upstream, so 
it'd be really interesting to us if you could provide feedback on what 
is unclear/not working, etc... so we can update the documentation or fix 
tools if they were to be insufficient.

Looking forward to your next patch,
Cheers,
Quentin
