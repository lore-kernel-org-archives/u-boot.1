Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763E2C3DA6D
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C7881E72;
	Mon, 19 May 2025 10:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oKccwVTE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F47681F66; Mon, 19 May 2025 10:41:33 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40ED1803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtnoIaVD05CCazGTthJZEeaGHvwT68p627hfItTvcqu/e9m4xuxvjEritkaXZb711ceOBwxc8fZyFJEJyBJGwM7eRUk2w5rgia1eNNxJEY1/HcPQtUE9ioJn92hWVVn87CeOBas761HlBcfvnAY34sb16PNL0x0igq7liMPgtuebgPf6AUXYLEVFcbrbnQ7pipf2hjbXAGLojewkIvRCeqXHReyIFsto0vjW1VX8fIg7T0lXjZ6Ztm1WqHccVhjf4Pr6CqWepUzl4wtfIVGOjZ838rs/Mb6W1On5tkKVwL6NA69PEbToP4jgB695T3Mj3T/zdkbOWXyOCJzN6eMmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foCTnugG1CVztkp+Uf4u3VjqpW17EIrQNg2VwGr6mU0=;
 b=cFu3z9FK3cCN5xoS2yetrcTDTR9nNUyPIuZMuRibyrhCh3jHn886BVITS0QQxC6X0oNGDowwOhlO33ISl4aBKU06Brrbb/locGKQOqV+IsiSAhnKTf2pp3gjzCivpcrVT/4LICKIP76vbY4u3+zrl7JLZTx/EKby5P6FbTaIbp0kGcM6BV6uGb/V0URKQFICybm2Eq7cD9u0ZKaDY1V3sVq7N5tmDnlmaV5uMJdZ6RDxm3Cfod9I7WjDCatx+0mcNSedSbw99uA9vpnQqw2H5dk51KuYRdrU5Z7GAnM7m7LojhcoVGCnhswab5pUlZlvWIyJlPTctqpNr9SUZqoR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=foCTnugG1CVztkp+Uf4u3VjqpW17EIrQNg2VwGr6mU0=;
 b=oKccwVTEt/MZCS3g5kMZhU5GqnhHDsqRimBOFG1WjLABTzEqsh1JQAzuAV6s9drZM2hknmTJFSi000598JJsWYNYEW08vHjMgeLkdo/4W7GbQxvIFnVqTkXITqZPgxl3T8bCpcH6H8B2jGaPt+fdp2OZzzi2NIR+EzCEUBLG+aY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8176.eurprd04.prod.outlook.com (2603:10a6:102:1c9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 19 May
 2025 08:41:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:41:29 +0000
Message-ID: <86a497b2-5b6d-48af-8b5b-a0ee4f54a075@cherry.de>
Date: Mon, 19 May 2025 10:41:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fdt: Allow expanding the devicetree during relocation
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250516141300.384736-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250516141300.384736-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f09f534-f87f-47bc-e0a4-08dd96b0f2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmtuREY0czZzbTg2L21LYlRGVVh0VHRGTHdxeTY1cEVxUjVOdU9rc3hTMUtQ?=
 =?utf-8?B?V2tUVWdIRTdWT2h0NFBjcXE2Y2E1citzRVZhQ2J5dng2THFsd1I5VFBuV1FC?=
 =?utf-8?B?MlkwNjdKRnVDZmNQMDJmV2dxOVQrKzRxNmZXY1lzS3IwY1l1dWJJaDFDaEta?=
 =?utf-8?B?bU1kKzVVUDNKZjcyVktqZW9scm9Qb09uQUFpVGQxRDNURWNnNG9QWHN6S1gr?=
 =?utf-8?B?Vi9RVnF4NUJmQ2hwSWxoc01LSkEwMHZQdFZqNmNhQnl5VmxOSlZhZHNzYldl?=
 =?utf-8?B?Vmp4aWcwYXBsNmhZdURwdU15UG9oUk5tbEovQzdycEpGaWVvV0VGVHhmTDRX?=
 =?utf-8?B?WU01TE11SEtBVnA5SFZQR0MrdzVuYTUyRlc1UlRYZExNK3hzNU1CZFhkdUlh?=
 =?utf-8?B?enlVelJVWmorMnBEMGk2UWFDcGlpcm5FSnlzTDFRai9jbjg4aUxEUFNlZDFr?=
 =?utf-8?B?RU5Xa3RadDZqYXZMTWxUVFgrb20vSmZHTmhyMjloSStvdVlSU2wvYnJVQzVB?=
 =?utf-8?B?Y21PYmhSM2NDUWxTWk1XdzFKRW5CODZFYVBFYkdRMGkwQTN2a0VvUmJKK29t?=
 =?utf-8?B?bmUvYmluMFk4UzdEdWRXK21JY2JYTkdqcGxkbFN5ckdva2w3b3owQVRBc1lh?=
 =?utf-8?B?V2JNTVp4RnZKZVdHRVFRU2N4TWRKYzR6UW1rVjRQdklBQ0ZQQkdmeHBDdTk0?=
 =?utf-8?B?dlpTNkxUYnkvOWVNNkl2WDNuTERYcHVNakNzMzVuRWYwUkRJVHhBckRXanp5?=
 =?utf-8?B?LytSTXB6cXppUmttNWxHVG5hUUVRalJCc1pwVmI1Z1FPaWxjdmpUTXJmUTB2?=
 =?utf-8?B?U2xNVG9SRDJCWlhTekI5b3N2Nmw4U2Nqb3ZQcEw3T3ZvaHptdXljczdNbll2?=
 =?utf-8?B?ODVnUi9Wczg0ZFppRUNTTW9laytDSklNdmFFNGlqNjFkazVoNW5LQ3NoLzJ4?=
 =?utf-8?B?SVk1R3JvYjZNekZZSDBWTlJ5YnZDL2FxL2lUS2NMTHFCN2RxTWthYTJBUEps?=
 =?utf-8?B?bXFuc1lub3M0VXJQMUtFWFNheURySGlIWlRWV1ZZY2FyVCtyUmxWTWcza1FJ?=
 =?utf-8?B?YmU3MVNnQnQ0WXJ1OER6WXhZT3RxT3R3SW5MR2JHaTRwRXpOWTNSdmZJbEVk?=
 =?utf-8?B?YmdXZmpST3NhWCtydmNWTUlDcnZscXhUNk5vYmtlTlkvMmI5bllKa3BkM1BE?=
 =?utf-8?B?SFcvSWxhT3Vvc2ZkYnFpV01LU2txYmdqVS8yUUFIN3ExUUErajBPbkNDQWNW?=
 =?utf-8?B?Y1NCMzdpTnl5c3FDYVdNa1IxRE1KNzI3NEZVc3ZuRnl3UTVMbzhNOTZTcERN?=
 =?utf-8?B?cG9tUzZCakdsNUc3QnJGaEtGSnd1UkFqaGdmakM5WkVJLzg5Y0E3MVdFSnBi?=
 =?utf-8?B?ZEM0aTVqU2xxM2ZlbXFOdjlDVzNaMVBjcjM4dWQ3eU9JT2l4QXIwV3RNVEd3?=
 =?utf-8?B?T013b1Q5cGlpeFNxZW9JRlZYbzh2UUtZYXBVcGlUR2tCSXVWYVRWOWVKTGxR?=
 =?utf-8?B?MFJtczl0NE9oSWlvS21zbjduaHRyOXhLQXdrOFYzd1RXQm9OaFEwSXRSb2F0?=
 =?utf-8?B?SVFNTGxMNVR4VjAxYU4zd081Nzh6YU9XMHNRYkxoMktQUS8venRTUHIrUkIx?=
 =?utf-8?B?elpEMjkxTGROZStZM2tRV1dtd2hzWWt0M21TZmY5VGp3eVk2dW82b1NZcTEr?=
 =?utf-8?B?ejlNV3FiektsQUZWTkpONGJNRHU2TVFKY0RFbElnUldjRWo5V0tRN0toWnN3?=
 =?utf-8?B?d2tVT2U5R3pHZkFLTXJ0N01hODZlbzljRXlTYi8zWmlabHlCeEtOZldrbU1h?=
 =?utf-8?B?aE93TG9iRHRheVUyaFdpNzhacHVCL1N2QXZUQUZtTEZVMklOcFdyNnZwUjhS?=
 =?utf-8?B?R1hFMUpoblA0VTBpMnFJb0dscFVHQktzU3Rqek5TWHdDbFFCMk0vU0JMS2JP?=
 =?utf-8?Q?zM20jOqdxWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJ2aFErUVpPUjV3UndKb3l0dWwvR21ydzRWUi9weUJOTXpITzJsZUZlZmdq?=
 =?utf-8?B?ZVRkZGQ5QWI5QUlhZUs1eVVRVU1zc0NKc2NBczlqTS94ZzFXZnhsbnc0V0NJ?=
 =?utf-8?B?YXh6ZGYweUVBanloWHY3N09ObU9aZmJwbG91Y2pzN1llVFV5WnlYUU1EN3Vt?=
 =?utf-8?B?MVpnMFFpanRvdzViLzVyQU5LMjQ2QXBxS2FpMDRNbzd5NUU0cmlYbnZSQzRj?=
 =?utf-8?B?TWh4elh2aWdkdWc1b2M1aktPVU05ajFTbmF6djZrSjZMOWRoRGFnUzBZMUYr?=
 =?utf-8?B?bU5IbDFZamIyaXhxR0FrUjZYOGtQWXY3M2hEdTBTVUtOTlpldmFtc2plMk5R?=
 =?utf-8?B?bk05R2ltQ2pDbHFtVzZ0d2h4bWNLQi83MlhVd2JZMkNNVDhGK3ZyTHFDK0E2?=
 =?utf-8?B?MkM1bnRmcWlYTFJDNEJQVm9PV25MUHA3Y3ZYd2Z2ejlmN2JuSVFCbkFoS3pN?=
 =?utf-8?B?N0JTejVxZWpGTm5wUENIQkdseHNUeUdKTmpOK1Mxd0lVNTBMZVhuSlB1ejR5?=
 =?utf-8?B?cXJqYzNMZjFWZHNGUUovQWZ3M0c2a015SFgzRDZKMnoxZzZPZTBrdHlYTHZo?=
 =?utf-8?B?RW5FNERNU04rdElROFZUcCtCYkU1RkFtU2NQbW14NGR0OStjNmNNVFJhY2RP?=
 =?utf-8?B?Mm53eTZxY2U1ZUx0N3dtWkVwTndQcXV5VlhLaHRNeWdLcTBxQXQ3dkd4bjJa?=
 =?utf-8?B?OGJaTTBHb3UxOGlKU0lGdFhnWU82R05VU0hvdE95aFBYOFBnV2ZHWkd6MXl5?=
 =?utf-8?B?TUJ1NFNHaG1tSmt0ZHZHdXBGRStBK3FFUlpETXlzS0FMZE95ai9vY2I4cy90?=
 =?utf-8?B?dUgza0lwbHhEdWZwQ0JIOW9iNENoSVBqWXdMYmdUaGNQNmxYS1kxQVo0OEpv?=
 =?utf-8?B?OC9qODhtRVBoS01ISXRUekxTSmhZUU1BR29DYk1vdzFUdTFSSmN2RlVQOFUw?=
 =?utf-8?B?REFhNzcvUmFObmtsaFplVkVSYSt6eEpSdVNZaDVQTXR1dHpSa1dSYUlScU04?=
 =?utf-8?B?M1AvY1lLSjdobFlEaE5pQnk3NmFHZGtsZnlKb1pRWnl4eWJjYkl5T0NvdGpU?=
 =?utf-8?B?VWVUa0FwRThFcDZuWExMdXpPdHNmL3pJa2pCV3hOSXcybFRKaFhxa29HM3Bm?=
 =?utf-8?B?Nnc1eHBXcmNnSkRyWE54aG03NXN0cXJvMTZla3hMUHltWFJKR3grV1gweml5?=
 =?utf-8?B?VzF3QXB6bFRTUHJnY1dlNHVlSG8wT09BR0xpVEpyVmNabG5vTjRiQ2I4Sldx?=
 =?utf-8?B?V2Zzb2sybk04SXJ1UGZZZExCNlhMamFjY2RZTnV1NFVBbHVwYTZXT3RqK1VT?=
 =?utf-8?B?bzRXM3VpdGdtK1Nzd3IvUUVIREMvM3grQUY0eEY2YmJMR1lLU09UNEhUY0Mv?=
 =?utf-8?B?WExUd2FROTJ4bEZHRW1ZUUNYT1Y0QzE3Q2tGenMydEp6K2JRa0FrcWZ2Mk1X?=
 =?utf-8?B?SWF6akNJNGlMdDE2aG4vd3BvQ0xRWkNEck1jRU9MQTdiU1B2WDh2WENJUjhS?=
 =?utf-8?B?Wk0wSGp0NzZDR1o1b3Y4Um1MRVVjYk55bkFIV3VDNzNIOVRMSmJFOTdvdk5s?=
 =?utf-8?B?UFlkNGNaZVpkRGtZS25Sa3N5dmxYWFRmMXg5TWtmenJiQTJ4a2g4a0lSTXlJ?=
 =?utf-8?B?Mzk1SUcxTzVNQ0VZVVgvdTE4WER0TExzbkZBZ3BBUWRyRE5IZW9QZnBxaHpm?=
 =?utf-8?B?SjNyeWhuNTJwR3ZlUkQvUXpldytMU1A4VkNnQXlxdDE2cXdyeTkxcXNIOFhE?=
 =?utf-8?B?T2tWa3ZTckFrb1o2VnJ6VjRUTG00UmJveVljYkpUYjlURTVRazJEb2piY1px?=
 =?utf-8?B?OEtBWEpsRzJTcVNnejdxNWRGalM0a2FwaTlreTZuc294OXdBWlhtUTgyZFlK?=
 =?utf-8?B?WURiQkU2VDdPdFBNNm9yc044MU1pNXlaZXlDQk80SUNkNUdINzVTNy9YTytu?=
 =?utf-8?B?cUgxZzh1MitBWDFiOEsrYmtheEJOUDZPbWQzNytZczM0TGtnY21HdGJlYmZw?=
 =?utf-8?B?VEZzTXNLTkFIRXA1b2gvcjlDRmk2T0hIQzJHaDFVV0xaRzI2cE5wRjdrNkVS?=
 =?utf-8?B?dkNPRUNaZzE0WXQ2MVVzNExkbEV4cC9RN1ByVzlWQUJ0YzZOL1VMN2pTRXV1?=
 =?utf-8?B?SFNiZlJDaTN4T0UzNzREMTVnRVVKenFpV3RnRC90N1ZUUkVnSFk1NFR5M1dR?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f09f534-f87f-47bc-e0a4-08dd96b0f2d4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:41:29.1079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUywT2daLz+ZIVg9ZASGYHPI389DmXAJwo0uao3csqmufdY2nXlPRLiPkpNFuZokh2E5Pn8jS2cZ2d+umAElCHKxp09Y38XGEoE4gHZgzWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8176
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

Hi Simon,

On 5/16/25 4:12 PM, Simon Glass wrote:
> Some boards set fdt_high to -1 which means that the FDT is not relocated
> in boot_relocate_fdt().
> 
> A comment in that function says that we assume there is space after the
> existing fdt to use for padding, with the padding size set to
> CONFIG_SYS_FDT_PAD
> 
> However, there is no guarantee that this space is available. If using
> the control FDT, then global_data is immediately above it, so expanding
> the FDT and adding FDT properties will cause U-Boot to fail.
> 
> Use the CONFIG_SYS_FDT_PAD option to expand the devicetree during
> relocation.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Use the SYS_FDT_PAD option instead of creating a new one
> 
>   common/board_f.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index bff465d9cb2..5b7370b62bd 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -583,8 +583,10 @@ static int reserve_fdt(void)
>   		 * section, then it will be relocated with other data.
>   		 */
>   		if (gd->fdt_blob) {
> -			gd->boardf->fdt_size =
> -				ALIGN(fdt_totalsize(gd->fdt_blob), 32);
> +			int size = fdt_totalsize(gd->fdt_blob);
> +

Maybe use unsigned long here considering that gd->boardf->fdt_size is of 
that type?

Or if you want to spare a variable you can simply reuse 
gd->boardf->fdt_size?

Cheers,
Quentin
