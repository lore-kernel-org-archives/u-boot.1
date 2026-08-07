Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E0BC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:16:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF824813EB;
	Fri,  7 Aug 2026 16:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IOb1KbI8mYW6; Fri,  7 Aug 2026 16:16:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5C0E81393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119409;
	bh=dryu6WYpZv8csMjZD7EpMU0fZlcUT7KO7Wm56yNt2k0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YpNsLZHhghsT1WtVouf4Evig1/r8ZY2vxdVmqUW+SCVD+BlWbbARm8PSDcxYU6Fz4
	 3/BszVZ4UvlLDcdDAybrGudG0l7zpHdfqCvC8Zf85G2A426uPCGcXBF4ytNG69OYGT
	 2oMAkoxF8Wb4GK6WSrCXW/P03IzZoKiZ9xooDZaNNwVyXrLpcndOTAgU5v/y/8dN6M
	 cdFfZ8Tk7rJV382FmbNiKPYAGLYMLuq2Wxv5RRb6wXlgemqFsMZnBJR6xNwhvWYpoO
	 f1KR6lULUxxTxktPreDBqixY8nLGQbC40zm22pawNI2OdqmoFPu2wPXGj0Xc7O3NK5
	 CCN0SvFzxi7MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5C0E81393;
	Fri,  7 Aug 2026 16:16:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89C33218
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84252810CD
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rHhZblZQ2bnr for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:16:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C24B78130D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C24B78130D
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C24B78130D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgNzQGlWd9VtXLy/1HQcwkemF2h6CAX6950UpBbY3nashOs2lSrFotd3Vk7lPUp42EuG9DUKj9YlRXdvdyhUUc59XCKvgk485KF+rT/FlDm72GGE4ZJdtwKPYt4UQVx+jaUp/e7gGrAtd2Yt0z9ZivJx+j6Gry5UuuJpZdaESal19fnYGNbEI38QHxOn1PwLPk3FSXcYaHEUJuYAS0m2G3vEoPaZ+QL082k7FzvQLIcwGSHkcPDnGgLUSMmIQCs48l4xG3oKbIBM12jv1zPLM5VGNDdaN1gPsCa0QrIgDK5Kq4aDNDnNANO6cxlT6Hkjgnf6xEyvanUPE8V/HwUd1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dryu6WYpZv8csMjZD7EpMU0fZlcUT7KO7Wm56yNt2k0=;
 b=vYXknWbv+Auq7OMdCVmuBz2voeIbw7Hn+uvisO56+mBAfxkWNpk6SfziR4XH+mY2sY0uuurZRKd56FFdbUwp2MlGZabggwY4+zd9nydCTT46mfLovaqFMmb9vKuirI/rW7hr0IFVKDPEZPwvMtUIWKb/hZcT0E5qZr98DkJLkhD/wuqQXDxO7QweuqNTOM9wL23JIlA9W1tJEwVB6wOEDltMaiX1FPqrayHJJfP+7j/RuJr4BwDlw7hwuQo4WNx2Wsv7GsiCK2G+hyvgSOGQX8mRyhv4gzqIs5PywwKDtrKmkG6q5qaQWlSsTBT8TvfVUbA0EV5QAF7ExJ9boIyXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 16:16:35 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 16:16:35 +0000
Message-ID: <ff792fb9-c5ab-4d2b-afb3-97291192dd5f@cherry.de>
Date: Fri, 7 Aug 2026 18:16:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] clk: rockchip: rk3568: Drop unused GRF syscon lookup
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.u-boot-project.org
References: <20260730141308.1218014-1-jonas@kwiboo.se>
 <20260730141308.1218014-15-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260730141308.1218014-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0224.eurprd07.prod.outlook.com
 (2603:10a6:802:58::27) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DB8PR04MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b63e788-40b0-4db8-e8f8-08def49f40a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4iBEA0F6oFaxyJY6OTYbAvZwclLr18BvazjnTGXETYPhs1VS4AV9ElRPNrLml0Ye7eA1I6WYUmooSYF9+zMGkbJsdTYe59xKEPop5zEsIo6Ery8xHIq7XltNWNCCSO2oYNmLkv49b29xgk6JCserXU1TImitWtRnziIoyWWDcx2IEFQSawuFMjF/6j80ZRFnaQaAeZIuJhvxhxBl8UgAbGSAkBcGifbKTtufcIX0bslKNUs18h0Le3yzrVblZ7C9R9vh4olIwq/4ihO9pXDp7/+avr5hJmp3maRUAjoJCskLw4FrKaJwxf7V6p0e7MDNev2DILedUbUyxR4zO5/gqs4Z73SyVkhafhmy+pr2ITVSK+e6TxNUkriKT3eMwbvCsa/RWlXIRvEJi4l1/GHeesz5iY1VFt7WYWYi8Sv47WwNgLysUwbfzdaE1BNRCzpDUV2MJdjigzkbY20JW12Kfc00loUf+58K/eVdVmFFN3XrznUt52ArlKJ7RCuYfTY3j8A4qaTlVzWiplvkade2WpWFZr47BdIooRm3y590urcqs6d3FyBSBifnnKxwUO7bIlbpKoT2DlPyB5Ei2/J+f4/TfLmdGBATYU6wihaUYlUcvnAWY5DBJGAIt3WvHnBLe7I29WJJj28ctD976zyAfX4jLr9rLjRqVcL6e8swpDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1RBTTVRL3BsUDErSERBUE1Lc2xVSGJoK3BHVnE1TDA2bUx6OVVGY1BxN0wr?=
 =?utf-8?B?S083a29ESmNZVWpNRlVRZ2dKelZJMFNuaGRUakNiQkdNQUlxQWYzNkFKUWtr?=
 =?utf-8?B?bG9EaXl3bEc4NzA0SFovT01KOUpaZmhMeFdWeGZpVTUrVENtTC9qRU5NS1Zv?=
 =?utf-8?B?RHVkUTJBWE02NFpZVlZkUGZzdGJPOUIrR1V4MW0ycFFSdkpXcVIxNjcxZFU3?=
 =?utf-8?B?Z1hvNEJsMUJWcSswSnpRN2tnZklvczgyQkg3VzVsWmpNcldBQjFXZERhS2Y5?=
 =?utf-8?B?Q2VjMk12OTRlVGF4VHpRM0NQaG5PcHQweFd1V1VkV0J5RUoyQjdKVXRnVXFi?=
 =?utf-8?B?UlR4MWdhanFEV3dCSDV2Rk1SVjhqdnlOZ0VnZkJXUW5YWTA2M2FBQ2VkK2U3?=
 =?utf-8?B?aFZtWlFqbmUydjBYWVNGUjZhS3d3YkpreVhJK0RrQ3JabGtJMUEvbHVYSWVM?=
 =?utf-8?B?OFZGQTkycFJqejcyM2RtSWdka296czdnR1ZVeDFwVFhvZStoM2RlNDZDNWp5?=
 =?utf-8?B?cXFXQktmMTc5eWU2OTh0SjdGd0hJNmdYRnNQQU1VU1QwVG9XL2ZCWmdnNVlQ?=
 =?utf-8?B?RWFwUHVjUC9EYkNKK3pQb2VDU1NEL0RzWkQ5cDYvODdaSm5HSDFvSGxVQkxo?=
 =?utf-8?B?RzlEOXpFTFBydUw1K2xzNTE0aks5dlQxYmlqVnFGaUJ5dmdBY3pGbXpNcnhu?=
 =?utf-8?B?MnhiSlk2Z0RnZmVWWXdFWW1CbW9udklGT3ZzbkY2SXVZWmZlS0I0bWd0Z3dy?=
 =?utf-8?B?cGdRZnJ6MWdCNjdjZjhvNWhjWVNON3B4UEdqUzg5MTQ2VmVOWG8zS3VjakJL?=
 =?utf-8?B?ZWZlenp2N1lJYmhLeVlwSTRNVXh1QVFWdktkQ2ZqWFZIR0pRNXFwUnRUN0lK?=
 =?utf-8?B?dWZxNWtGOGNrR3YyaTliQmNraXFVbEhkMFB6anU2dlJFT0Q4WjRxY3R5RC9n?=
 =?utf-8?B?amRYT3NrMy90U1dkd1BYMlEvbk01WnpwM2hZeDdTNk1KbStZcGZOZDZSazk5?=
 =?utf-8?B?N3FLM0U0OEZyai9tYjIwTDdQV3Q3Y2poR2lJTTA5VktkWnZXaitHaHFobjZR?=
 =?utf-8?B?cDZzZVRnUXdnYXhtaFhYOTJmNEE1ZnRRQWtzdUsyMjQxdWhVM1FpaFQ5Mloz?=
 =?utf-8?B?MFpjRy82MVAyZElqU2RrNi9ubzNNRVNHZUFlYWRkVndLVTdwQi9wVXZheS9Z?=
 =?utf-8?B?ejdKaDMyVEVqeHVtUjY3ZjM3Ky9DQWl3a3lFN1luaDlNN2x2aGhrditIMlRR?=
 =?utf-8?B?SnVMdEpPZjRYRjVBZDU5S3J5R1dyWWlsZzBQbXVKMkhnVTRUcFJEQmJUSUw1?=
 =?utf-8?B?ZzVMSXFaSEVCYmptV2lPbWswMHhLU2d3L2dUU3p0ek9uSEgzTDdNWUpIZkZm?=
 =?utf-8?B?Zjk4TUZkVDEzUVQ0NXBoR3poRk1nVm9FWE1HNmlleWtyTVZKNU13RzhsTGky?=
 =?utf-8?B?RkZZMWFhclVzN0IwQWcybnMrYWxTZ2FPVjN0M2RvdkwxU1VVdUc3dzVNMUVM?=
 =?utf-8?B?QmhTR0FEL3JuSStSUUp6QmNUMEhSQ0Z5SHBGMTMrc2pkVkEvdnVrMWpXZWY4?=
 =?utf-8?B?VzFxUWpYSlMzc1Mrd2t3Rm4vMktJWU1NdXJoYWlBSzFxMUFPbHp3eEp4YzNo?=
 =?utf-8?B?TDlIWEhzbXY3WGU5QkE4TEdmeVdXeWs0eklQcDdPVUxiQVRWSGxCYVdaeFJT?=
 =?utf-8?B?SlFScklNWFNrcGNyWmNXcnkrL3F6UktNLzRtT3Aya3hGOFJEaEJuQXR4cTZF?=
 =?utf-8?B?RGF2TEl2M01VT3JaS3hOdlVwWitKNHpta1k1cmp5eWRHdVFwRTB5QUY4MlEr?=
 =?utf-8?B?VEh2VUltbmpvUGVjcGk0aFhSeWtiNndEYWU3b2xmU2wxQmN2TWJ3ZXNodm5Q?=
 =?utf-8?B?REkwNTNla1d3RTFndHBVYWxLSjYyMk5WRTBzUWhpZnlxbXpaa3VpNU01bGtW?=
 =?utf-8?B?OHdha0lxdGhPMkRvVUk4blJ2Z3JnUFFBRXQ3UVFYUE5IN08wNWxJa29ZczBH?=
 =?utf-8?B?djhHVDFqYkxMVEZ5WkRmaWI3Zm5JYlFUVnY1VmdsM0JMalBrZ0k4aTJkTU5E?=
 =?utf-8?B?WXU5VDdFWW9kVHc0eW9uRGZQbkZYdnlUbVV4SFprdEdLT1FsdU5oYUhCTzZW?=
 =?utf-8?B?aEpXSml6Ui9KNXl5WXQ4UW5lUUpHV3ZKZ2Q3UG1nVnJNSGV3ZHJkenlseHF1?=
 =?utf-8?B?enBGM3RuT1RRanR6KzJVVDBwRVRrS0JUUmg3bi9qanMxc3ZVbFB3QjVzZnQy?=
 =?utf-8?B?dHRyb2RpNCszMXptOTFZZzhnK2l0ZndrVkFRWHdqZDRFMlZYSUZQN2VsdXda?=
 =?utf-8?B?b2JwM2JyMXg4dm85R1lqeXh3OVRKaWlWRmczVWtoZXh5WEpqTjdCdm1LLzdN?=
 =?utf-8?Q?+4KpTxC8IykAryIvRf9icePkZE8Hraw0MwbRELCyWedEO?=
X-MS-Exchange-AntiSpam-MessageData-1: 099DBUrWMPY2iAyN+OGA7L2GWlPM5ODd0FE=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b63e788-40b0-4db8-e8f8-08def49f40a5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 16:16:35.6665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAclwPRjE+175H4ZsSj9shU97mPxXcRBKfrNIowNXsR4niyV2gct2FBkDV8FaAx77VsJSjf4QgBQIKJheIVsmkQ4g3OW61sx1J2ekzzqG9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dryu6WYpZv8csMjZD7EpMU0fZlcUT7KO7Wm56yNt2k0=;
 b=Z0efpckKTUvtvHhY1sQRFTvTfkGDBp4TlIHZns21CNTHU3IGWoVk3UyG0Tdt+qprysLSnT80b621hC0A1LKT7eIqoX9JrE6BKQLQtMMeSUpL3BBm8ArlfviWMI6i9GF1HS1BuxR5bv1q8m2MqVmyaf8TkiYnGj0XTxc5ZnsKtVo=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Z0efpckK
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 7/30/26 4:13 PM, Jonas Karlman wrote:
> The RK3568 clock driver lookup and stores a reference to the GRF regs.
> However, the grf field is never dereferenced, let's drop it.
> 

The kernel has the clk_ddr1x and pclk_edpphy_grf using the GRF I 
believe. Those are unlikely to be supported in U-Boot I guess. We can 
always add them back anyways, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
