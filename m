Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE35C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 09:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2A6F884C3;
	Mon, 12 Aug 2024 11:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VsI2cz/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B36A98861A; Mon, 12 Aug 2024 11:53:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A85CC881A2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:53:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoQu4LUw1e9i6ig2KvxXNoTKag+Sh7HFqq8XJdeao7YogDDxIvVLJ+jpDLw1bKxzNk5LdDmd1Cf/zSB2arO7VYKN3JXzk8NJYNCvnjFT/JlDWIWA48hfuCLb3736FXHaQnIzMag3OqDaog7sxPP7R7ULq9Xi0x8Wh7/bQcpOfVdbugO4ufqPJ24UMETyl95+0EZe/xK5JS7K6YkY0eVShEjMbLBCtHFfm4gXtQw8XgS868+EeCifZV8vue9GtwfnhywrB5A8FulR1B7TVq3wrpUxWhvLz7wokNW8RQgIiMlD83Xa1tCV7qB53LHGVlFmZS3E3RR//UKzlBRK1BTTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90YTj9jLzgJ0HEUETHrN80MFZ63RcTYNRM7IynLIywo=;
 b=rJ6sVQX0sHlfW27rCM2d73i9Lf/qvKIWqJhxrEzgt8d+a0YsR+5FsgsGnU8yLI1/I5rz/fgYDtmcNJA1L3EXvWUYbfR3c1ybXoiamxlwJxhOFocba2xqdEayzNlK0wf0MRltBBFRwPNaI9T8epmQTFnAlWPB94biZOXmmcsKBYumlk2E9KnjB96cAvn4y1PUmrAkA5LKxmLKAD8VchR8JRcCql7qjjPGTG5Q+2vNQ6XJdqmiG0WfMSwnNN3SWpX2dV0htMfVxza3RP6lRALQrleenD7X8q6ZaZELqd8IumEdA9Q+UBbvq0wJQADEcvSMz59ERG3nnlj+6PVzJM8BUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90YTj9jLzgJ0HEUETHrN80MFZ63RcTYNRM7IynLIywo=;
 b=VsI2cz/vnZIUveNjJKMPs/c5l8YpCtbj35j2ptnwMDqpeLqewst8fyfJ4/Xp4lre5m+EfRSHnsNb4ZULdFD4tpqm6CHs2VSYx9myyL2CEgNIc4L1TyIy5lZuCSZc7knpl3hSQdmn0VuQcFEOquVANu0d7q9fIuF7FroyhJIjp6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI1PR04MB7150.eurprd04.prod.outlook.com (2603:10a6:800:12a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:53:26 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 09:53:26 +0000
Message-ID: <1226caad-ae95-4c5c-be69-f774f01f975f@cherry.de>
Date: Mon, 12 Aug 2024 11:53:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/15] spl: mmc: Try to clean up raw-mode options
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-13-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240811122924.4035982-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI1PR04MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 8570d415-122e-4acf-8cac-08dcbab49c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGRvQXhmTkUveGhTY3duMjBYSDJFMGx6eHQ1MG9wMTI1RGZJTVJ2U0JoazJQ?=
 =?utf-8?B?RUZ5bkJoWlV6TVRkdFhPaW0wM1Q1UWpISGRReWNiMVo1SEhrOHdhRlRya3J1?=
 =?utf-8?B?bmd2ZHBORGF0dWc1ZytvMmxVbWg5WWh1eTJuRWxRWUlMaEt2TnB3NEJ5U3VY?=
 =?utf-8?B?TkJCcjlxbjY4T0hoVk5Udk5LSW1ST0Q0V0djQ1FMd1d4NWcyZzVTbzh2WG42?=
 =?utf-8?B?c3BYcGJOcDRxUXNpUVFFWkE4N2k0VXJCRGZIOERqa0tGcTRZOTFUekhmWVpn?=
 =?utf-8?B?Z3g2Y2toeklsQWdoQmlXby9nMG94QTQzTXJYbWI3TVBUZWZuN0pjNzNRNUE1?=
 =?utf-8?B?Z3kxMWFoaWd5VGNaUTd6VUhrLzVmaTFlTisvZ0xPbmlJWXhEU2YzK0ZLL1Ew?=
 =?utf-8?B?TUREOTgzSG9lenEwMC9QaGdZeGRnbStEbDZZZUtxSHNtWm54SzhSOHNWK2N0?=
 =?utf-8?B?K3JJek9GL0FLZzM1NjA0SUd0eThFTzFBc2JXMFZPNzE0NnR5QUpMMks2cEtV?=
 =?utf-8?B?d25ZcHRZS3NqcktYOFY1eFlxcXkrdllTTHZFTFJoVVU2WkVOOTV6cXdLZDg5?=
 =?utf-8?B?bUpGbVNyc1UwUVl3amFucmZ4cDdnSENzMkN4T3FFdW9nWTZ3S2ptRVpoMEhx?=
 =?utf-8?B?TWY1OWNXN1pGUDQ2TG1Tbms5V3RIcmlLUUpNaGlBZHVIMm8xb0hpNFhrQ2N1?=
 =?utf-8?B?YVhSTmRUOEMydzRiMFlOS053OVF3QURjeVhLMVBDdnZtYTM2NTlldXZLdkxR?=
 =?utf-8?B?eFFTMzQyT1VJRVVUNWhhZWVtbk1SUFVjNXh2SzJIN3hFSFRYRzlSQzRGL3BV?=
 =?utf-8?B?dEpsUXBvb3M2ZE9zY2FUSWpFL0xmdk9VY1l0Q3RHUXlOc2N4VGlvSmhReEJo?=
 =?utf-8?B?MXQ0QzNiRlZ1L3hqS3JZcGliVTRhR0lJWHZLTDBBRURvclIyUlpReU9IUXJm?=
 =?utf-8?B?ZWRvSnBoSmRtcTAyS04rRk9vcUVYdXZhRHFNZngwWFRxYk93SmhBUFZVT3p5?=
 =?utf-8?B?ajdmREY1d3ZpWW1JcEVsNWU5SnVLd2Qxb3o1WHVyMTl5RHpWUTRsNHc2dERV?=
 =?utf-8?B?a0dFR1BPeDRVWjFka0hEcjZ0RHNEbnM4VGtPTVgvWHhIdzRseGVucEh4UHlo?=
 =?utf-8?B?RS9JV2lTa0F5aVBoQTZVWGNKelc4cFZiNEhCQWYvSkVCV2ZsWnZibjlkZjU5?=
 =?utf-8?B?b1FEMG1KWjBYTDdGM3BUMmlLUnM3cjZaWVFUdkh6eDlMeGpzUmdRb05DZ3NH?=
 =?utf-8?B?dVpRalNmNjluTjU0SGZ5ZWJ4c2Z3dTA2ODhDMlMyeFhudFVNV2RoSWp6Znp0?=
 =?utf-8?B?VkpJYy9Ib2RlZVRaUkZDN2RJSEh1U0J6THNKNmNVVmt0YTZZSnZLK0xuaUhz?=
 =?utf-8?B?alI0cHhNNWllYThTMDM3SVdhZnliN013OEc4TzVVdVdacW1ZWVNMMy9HZmg4?=
 =?utf-8?B?bUw4cUFwQUZBVXlBZFA1ME9VSUZFQVdCdUlGVWhhMlBqTENqdVdzeFp1aVdm?=
 =?utf-8?B?L2V0NlAwQkxPNVpYWkVvUkd5aFhPdjhPUlpjQWtTZmJzdDBJcVBRSklnbWpl?=
 =?utf-8?B?cUJHb0tRcTRHdTU1L2l4UUw1YzVUdTBpTUFROGhFSzBQUjN1aXp6TUJsaWlK?=
 =?utf-8?B?ejd6ZUh5UXIwcyt4a1QrZTM0VkY3MDZZK3VQY3djbi9HWG9Nck53aisxU2lW?=
 =?utf-8?B?aG4xSGJMQ3BNbjFvNU9VNzJUTTJ4Zm8zQmpVUVRhSlJaZUZmSWh3V3M1TmZy?=
 =?utf-8?B?TVVQWlNpcU0rTEtUb1VESDN4NzMvemlnYnhYcURzamk4RFZSQkwrU2hOckxx?=
 =?utf-8?B?VVZBeDNFWTZZL0RvaTR6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGJwNWwyNUdzeTJjSmVrUFcyM0t5UE1hN2Fibk9NUVdUKytqaW5YOWpXbjJv?=
 =?utf-8?B?SDExNE9ZL0NwZFVuNU9JMnlvOE52aVhveDJOSXBVQ3VtcmdZSUVxRTlwOWdu?=
 =?utf-8?B?eHFLeDVtZEtZNG5TdDRkTFBLL0hlQ3gxVnB0Z09IenZnckduYXFzRUZaMUtC?=
 =?utf-8?B?dTlHdEd1WU5weFFCQ0JSWUJsNkg4bitweUV4NnNVeUJRRVg1QlRvcFluMkpJ?=
 =?utf-8?B?TWJueTFzQlN0U2RFend0a0IwdnVTaTNpM1BLK0FHWnVSQWhJZWNmMmxDSjIr?=
 =?utf-8?B?WEZ4MldvcTQ1OWExS0FDUTg1TXRxb25GK2YyVnh2ZlAzY1IzOERtM3hmTGg1?=
 =?utf-8?B?K2NvQlNrWG1uQW1QaGxBcHZVQVc0dmFjazUwSFV6YXpmYWF6aGNPVk10bUxl?=
 =?utf-8?B?TTNNL3c3Qy9zRWEzU0x0SXRaK0thVWlKSVR2aE12MWN3RjhzU3dJbVZDYm5z?=
 =?utf-8?B?MXN3Z2ZHSmpHSWsyTHlrM3ZCcnFEM1BnekkvVXo2d0k4c2JvZnM2THlDQTFj?=
 =?utf-8?B?MnlzYUlUL2lSQSs3aFNCbE1EMDRYQlhnOENPS3Z0SlM4WTI4Mk4vdkU0U2p1?=
 =?utf-8?B?ZVIrRmRta0NPU0lRNVk4eFdIQndpUEdWUkh5TG9vaXdydkp0MjhCZllad29w?=
 =?utf-8?B?TVBoaG1HS3ZhbERFK2NjSU0yOUNqZC9vV3pONEh4a3FmNGJQbzJCbUNhaFdk?=
 =?utf-8?B?SDZ5dmhWN01wV2lOYmFUeXI5cHM0U1owa0E3NkRTMDNaaUp3M0dnZTZUNnc2?=
 =?utf-8?B?SVBPaHE1WVE0YWFqUVZZblVsb1I0ZHl6dm9LSWdSUHNDTm9jUWVFOWdSU0dO?=
 =?utf-8?B?UUx2S3VBaURkemh0Y0RPZTI4c2hrWi9zYnhDekFaMWlOK2tVd244eVltak9Q?=
 =?utf-8?B?NXhGOHZ0cW9BZWt6b2M0Um9jelRKM0FZWW5HWXZ4NzFnSlJMKyt5cE5teitp?=
 =?utf-8?B?M0FOZ0Nsbk43aysxSjN3ckZqK3Z3K1dMZVhiTExJcjVKN3l4YThONG1oZk9R?=
 =?utf-8?B?Y0NQZEQwRkJDUGpGdzVCeUtNSVVtMnUyMXN4cWtESXpDWkJDcFplU3BqcFFu?=
 =?utf-8?B?YVBmbHA1eXE0R1dIV0UxR1czZFRMTE5GTSsxb3ljZmFidm1teDlKcnl1RnR4?=
 =?utf-8?B?Y3g0S2NqSFg0SW5LZXNRcUhNYlpMYmp4eWlZUGhmbStRWnFKUlpzWmVXOVVi?=
 =?utf-8?B?alBsNHdpNW9LbXZrNzlQbnpLQlJ3N05hR1BjS0VYejZSS0VWS05HdkFkelNi?=
 =?utf-8?B?c1NZbzRKb3RxZ3MyWFVFeUlmWVMwYnRJeWhkWWEwQWF4bUt4d1pyYjd5ZVhM?=
 =?utf-8?B?WEtvYVNxWDU5ZXFFMEZMbjBDbVcxdmZPZ3ZzUFg1T0lsVXBpKzZ5Nzl0Y2Np?=
 =?utf-8?B?ZkNITjd0YUhLWjBQL1pmRmpoZDJnWDdXSkMrTlZDaENCU2xJZ1dQRThOODBo?=
 =?utf-8?B?S2ZWcUxYN2s5TFNOR29nU1M3K2RDSEg1ZkE1M0I0aFhTRUdhNFd6RWlDNUVk?=
 =?utf-8?B?Mk9QTVdybHlEdTZERlF5cmhzOWg5M2szTkNiNHdZMkdEZmVkOWhhclVrTUFD?=
 =?utf-8?B?QmRNZTdGaS9jS0NLcWRhWEFWcUpDSWtlRVdicTF0T3NkWE9QRUVLSlVGYndZ?=
 =?utf-8?B?OHFNdm9aNGYzK0R6MkhIQ0xwMjFSRUxQb2JSOG5XaDNRSnpTVzJiSm9PaVB0?=
 =?utf-8?B?Tm5NbFdXZzZhMVVnOERMOE1ubm9DZWw1YmpXOVQ1YzA1TE9kNjNhQjFoSWhm?=
 =?utf-8?B?TmJmQ3A2MjlaR3ZOUkYyYVZyN1JicTBwQXllTERTODlNenI0UGo5ejcwMit2?=
 =?utf-8?B?VEhjZURYR3hENzN3RDlDNmFlUDZzdDhSS25mSVgwa205cmhObmFLS3hqN3Fz?=
 =?utf-8?B?dG5EUnpHWlJXRnZyWkN1clprb2lvSGJVYWhKR09oYXArNjJkdTdNdkFjWnAz?=
 =?utf-8?B?N2lSMGFaME05ZXVwQmFjZW0xb3hLUVpaNEpEMXhYbS8rOHhzdVk0TldIRGVs?=
 =?utf-8?B?TGx3UGoxR1dmZlBYY2k2ZHl5Q05CeUgrU1dCZHVZZnowcFRPZFBEeGw5bXB2?=
 =?utf-8?B?YzdCN1N3bjhrWVlJY0VjQkZ5NnZMQ3h6cE01N2Q0NnE2ZktFdTlxd0lXYU94?=
 =?utf-8?B?L2NYOUJTZExEb01kS3FYaFdyQ29Cd09mTzl5bktESTZieGpybjdHTTVyRlZZ?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8570d415-122e-4acf-8cac-08dcbab49c7e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:53:26.3010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5OlRl1IfJSRLAcoNGfbPjhBr+ZN32TSwIuE8NjEf059sJDXwBWthPJTc0y58YBPkGvvRkKC0pLNnJjJZ8/rEBB4+xzL7PDjtZaAuhTM44c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7150
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

On 8/11/24 2:29 PM, Simon Glass wrote:
> Make the raw-mode options depend on SPL_SYS_MMCSD_RAW_MODE in a more
> direct way. This makes it easier to understand the options with
> 'make menuconfig'.
> 
> There are three different ways of specifying the offset:
> 
> - sector offset
> - partition number
> - partition type
> 
> So make these a choice, so it is more obvious what is going on.
> 
> Update existing boards to enable SPL_SYS_MMCSD_RAW_MODE where needed.
> 
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>

For the Kconfig part:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
