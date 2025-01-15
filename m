Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F45C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 17:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1943C8033D;
	Wed, 15 Jan 2025 18:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hhVvo6Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72EA80657; Wed, 15 Jan 2025 18:51:32 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C256880214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 18:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bdp41rSJzL3GLBVcLZ1zXHhpeYQviGbrps6mSmVRk2Tk7g329uxMKAG45WL/iXRfvNac4GkRD1OpqsAr1L5JtOCPB/38+iyASYDj1MrpwQgNgHhN4grKTYPNR89HSQ4KgtwAO+7ueNnFNOlQw4aqrRiDSL1DjWgBNwox1SUosldfMmW+kQOOCMukj9mEe2BEGB3khqPJcN0hP4hLV5XrBTXTrEDvCL6tu4Zmf+VGUx0GC1AeXcKznaFmNulJK22RVVctxvglaZ5IYagN4IYWDn4BjCKTD9T707sHBosg+eZZXotcCqJ+hn6oWJoZpvEs25ycFNrhKhP74BBdOMhPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6MvQrC+ldmn2/VOVEf84hlc29mO0Rr5FvVMOHfRE7Y=;
 b=vFCmfUhQlFd2UM+9byVg07c4tn3FI8vAByixIUmcspcwkwVZlAUwY8B8Pe+2/4pvhoWkcPRIME32mD07MIyqdTPCXarNoMvcmjXM5ojvC04HX/nrPcBxCnCsXXEijk8olyWT0K4W82F8FZHsPuZPglavrAZ/lnLTqHvn3QWdkC4vDqx+vnw1ilCSrsPfLAIPzx8qjhCipvAEoqa6rd1lPdfeRrOi0EFgQWGnjwNo0QZ2wqZGgERrF64CP6DFwFYLqVlfsf21pm7Jx4frHW3hWHR9Dnjz8NPMtPJOeonwNW1vVP6VMOCRnvVxNvHUMnmv7h4Lzc8zN0cc6fXu+FkivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6MvQrC+ldmn2/VOVEf84hlc29mO0Rr5FvVMOHfRE7Y=;
 b=hhVvo6XcgjPrZ7us3NmY6iPYmQzmw7ARSazl/lebnXSiiC+Tecw9TRPLE2gHzpAC+pBAL1nHve7rpYSeYVZLV776HkVfLpHOO1QuT8DXw+sJFUhtk9EekXAuTsoUgGLmUD2wSdVLD6tNmGNivDZsVOi8kmtXxZ7X3TLoJAPScAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU7PR04MB11187.eurprd04.prod.outlook.com (2603:10a6:10:5b4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 17:51:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 17:51:29 +0000
Message-ID: <8d0713c8-06bb-48ca-badc-2bd752605190@cherry.de>
Date: Wed, 15 Jan 2025 18:51:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/6] blk: Make block subsystems select BLK
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20250115012322.215243-1-trini@konsulko.com>
 <20250115012322.215243-5-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250115012322.215243-5-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0139.eurprd07.prod.outlook.com
 (2603:10a6:802:16::26) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU7PR04MB11187:EE_
X-MS-Office365-Filtering-Correlation-Id: 844ca1c5-e52d-4bb8-3eba-08dd358d3d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MENGeGpYeU5jVHdtVTRXT2tCb2c1SnRtQm55dmlkWFRMeGdESXh2N1JUQTlS?=
 =?utf-8?B?NkhCZXRsYWNQWExZWU5McUdvckVJUEQ0bGthU2FpRGJRSUN2RnF1RjNyZUpW?=
 =?utf-8?B?VnZEdFBjQnpGUXFWYW5GZldwTGlDSXZKQWEzUS8yK2RGVkNWR0p1VmZFSjRn?=
 =?utf-8?B?VSs1dFMzc2dBVWlUYUtlTXBJRTErVjZTL252TjBNem1MUE1TUE4rTnU5NWNJ?=
 =?utf-8?B?aU9TZjUwL0JsU2ZOWGNHUWsvWnhiL1BQUEFzQUYzMzBpc2FZTTdrbVdQNjNM?=
 =?utf-8?B?U2k1cmZKODYzWmlWK0ZCNk9xeUd0SS9BSGx3eHlvNGQvL3gyMFYwNm4yVURJ?=
 =?utf-8?B?NlRYVGJjRCs2ZmxCekVUdVpzTysxNkpRRzAwWkpPZEFSamNOOGVKcEVFa1Ft?=
 =?utf-8?B?MzFocWk0Wno0Zy9VY05zbFZpWitHcTE3a3FOZm1Ka0lXVkFoNnVnUk1NdDVj?=
 =?utf-8?B?Q1IzeTlqUTlWcEJYeUJQZVZ2QmxCdnpHa3pxSE9HNzdXM2pHbjBDMVhrQVZH?=
 =?utf-8?B?YTdxa1FhK1JFdzRSMW5IOHBPNjFncEhUdjdjdWRGTGZENXBLbmVBeERiaFpO?=
 =?utf-8?B?UGNQV0JZNnJnenhEYnRQMDI5YmFFMzlOd240R3RJU3dHSU1YblVxSHJzK2wr?=
 =?utf-8?B?YjhRS1dYUDJUem9rVitQY3ZWTTFPWldJanovSlhDVTQ5QUkvZkJ5aXRrdXAr?=
 =?utf-8?B?RUg3amUvNFlCbjVoeXQyaERrTWlsYUlsWGlPWkxjdHJvSUx4dlFLSXBFWW1O?=
 =?utf-8?B?Sk5FekN1bWthbXkydXRWczVoVHMrSHd2RDY4SVR3ZGhJTS9MbUhlV0dweWg1?=
 =?utf-8?B?U0NCZWhOenJLUFNZR3dPaEpBUmNmQW1WcnhJcndLdzl2eExVMDU1R0JzZUg3?=
 =?utf-8?B?KzBDU1dYYWVzZGttWC8raUtxQWNrcmxsOWVETGNIbFhyMWpiS2crSXNoU1B5?=
 =?utf-8?B?K2IvQ2pUZ1RCOE4wZmZKaUxPZVBKeE51SGdKZmZUc1hyTzdJaUNQS0lDakgv?=
 =?utf-8?B?VHdnZmY5dS9kVHVVYjhwWkVBSjJrdHJNQ0ZwUTMzOWgvcGgxTzJMVnJUTkdL?=
 =?utf-8?B?YlJZd3ZJSTU0OXJONmZMN2pGeHdLZnU4QUFyZnpITURWRkp6Yjg3bDB1M1M0?=
 =?utf-8?B?QVp6Ylk4MDdTcTY2TlRPTkFDRk9OV0Nianl4WXZLcWxzckVybXZFYTl4cDBQ?=
 =?utf-8?B?WnZwbjBiWldqV2E0dklxMWRLd2FLZm1PQW0wUFJyV1pHaE9nNDhFTllSSDRF?=
 =?utf-8?B?dkY2bTBERzduOGtQcnB1QWRUWCtUN1M0UGQyWkpmTmFEZlpPbUNiWklZQzFP?=
 =?utf-8?B?Q2xvRjVDWTRySkplYmNzZElXR0d0Ynh5bVQ5Q0dzck1ZcGpTMk5aSWY5Z2ZN?=
 =?utf-8?B?VWxJSFlWNkxRVkVFQjVDV2N1VFRJc2JIdy9oVDBmRTVUY1JmVEN6djQ0cVFu?=
 =?utf-8?B?emJ3WFlKdDJYVXpkZXE3bTVOWjhTQ2N6ajJoTGVrUW9sQnBkTVlxSVpiMlRD?=
 =?utf-8?B?SXVUUFplekordklCdGxTKytndTM0UWZ1WTZBaVpzMXlGMmorbjRsaGEyb2d6?=
 =?utf-8?B?TTBnVWMybG9RVDV6OHd1dDRydmNSTVI1UEc0SzB2WEFUblNTZE96V1hpRHJL?=
 =?utf-8?B?TXBmYzI5WTJBWWV1TmxrbVhCZGVxSG0xTzR5T1JqL1hlQjUvS2drbGlReElM?=
 =?utf-8?B?OVYvc1ZLZkJvOW5tOFZNQzcwTHBwNnljTDA5aU1wSzZQZGxEc3ErOEgzNHlr?=
 =?utf-8?B?dDBYZTFlNVRUaS9ocThmdDRFdm5OUlBuV1oxcWVEWTZGYXA1cmVKb3lRdmpG?=
 =?utf-8?B?RktkNzBocnpmREJINU9IQjJROTU2VUFLWUdITjluLzloc2FKUTJISTZjakJ6?=
 =?utf-8?Q?z0OjwwliiOs4S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGQ1a1haQkNaanptRzdPb1ozTDI2Q1ZvZ3RYUUdRTE0vYmNmNFA2R084NTJX?=
 =?utf-8?B?MUlTT0NIdUlEc01HYmJobVZDMHdaaFZrVDRBL0EyMzNjZFNtVHd1dHVOeUN2?=
 =?utf-8?B?NjNCY1BVSllqTW1xUFpBZkVCWHlOUFZXSXQwTGkvRFd1ZGhONEtxdVZaem9j?=
 =?utf-8?B?Z1V5TGdUaCtLODRuYTdUdXFZU1IraWpLWVNpUVdsS1pCZ3FwczdhWUlPU0RB?=
 =?utf-8?B?UXRMeXJKU0l4T1QrWVBKaHFMdTZYOTlzZFNqWG9XWmdRQ2srNWJjRnNsb01U?=
 =?utf-8?B?WThrQ284a05Gano3VW1HWFJTUGY3a3hDY0lXTi9KVFh3cUNJcHhURnRpdWpV?=
 =?utf-8?B?eUU1b0lIcmVMa1dCa3JiSmNwUVhPUXRvU1BxVFl1ZlpDUVZsaWtVR1RrV1JH?=
 =?utf-8?B?NnViQzRHY0J2a2grR0JRcWhSdEtxRFp2YnZiUzg1S0YwWXgwUVp6dFN6a2hx?=
 =?utf-8?B?Nm1aNWtHSzUxNW96Wmp6VXVsVlhGSHB1ZnhmY3R5cExjYmorOThnRFNMSmFF?=
 =?utf-8?B?UFdLOHQwUG1FMzgvWkswSk80QlRjdVQwMExqMlh2eDk4a2Jsb2lwRlkxeFlP?=
 =?utf-8?B?RDdyTjlFMnYzNGlLWm9tUkJmcS9Zcm9CRmFkcHd3SWhkREJJWlVLR3lCM1p5?=
 =?utf-8?B?MW9HdFRCQ2hZLysyVWF0ZWRkaW84dFluSFZyY0h3RWxPYVUzSTh3ai9PNDQ3?=
 =?utf-8?B?andLL1ZLOXZGRTZ6aUthaXdJS1NUaVlRRlJHQ0NEdVRtWXR2YUJHTG9wbzBR?=
 =?utf-8?B?Z1dtb1dIeUIvRndIMzVUN01mbXhIWnQ4Q1RzeFlmRExJTzlDOUlTT0lpZGFF?=
 =?utf-8?B?Nk41QWlwUnpSS1orQ1BjMkhCS1ZQUFZaNWlFdE5HczNSWU1yTjNKQmhjVVZ2?=
 =?utf-8?B?dkI1MWdTYmJkaVlmd2d5RTg4aTlxcVVsTDBScmR0c3BUNENEWkNTd2NmQzUr?=
 =?utf-8?B?eDFLMkNBTHRhZmcycENwNjMzL3RWVmNVWlJaSVdqLzFLdk15NzdwSm91dDBy?=
 =?utf-8?B?UVpteEhYbVU4R2xxcGVWSHFsNjJHSFM5NGlEZ09wbkpWRTMzRHl3ajJ0d215?=
 =?utf-8?B?V0E1UVhrQUhPZmFKM1FwQk11M0pSSG93VTR4YXQxZkN1RHFnYXd5R3hYTzBT?=
 =?utf-8?B?c3F6UUZlelVFYUc3MWZVSERkbXluWGc1NUo3aVRBVDNJbmFZS2tCT0Q4OS9k?=
 =?utf-8?B?YTlxQXQ2UWJMTGpZYWtVNFYxd3hWaGozWW9mb3RNSE93aERkQ2VaQysyNnM1?=
 =?utf-8?B?S0VOUGJPYXZVTEtvY2trTXBPMkRGVUtXRmwrUUNFUE5qaXBwMmNqOHNTd2RD?=
 =?utf-8?B?bVpvc01DUzY2cVQ2K09vUC9qSmVrK29uUDhKQk9TcnIrMGxVeHpIQzFaNWlh?=
 =?utf-8?B?Mk1ZMkw0L1lCV0tOanVMMzRrNUdiSVFNTWRQSHYrN3hlV1pnZGlzcUZaRkt1?=
 =?utf-8?B?SlZDY3pkSUdVcXhTOGw0ajR5enpuOU5wZFdoaUFTVWVzZEpRRGJTMFNBMjhX?=
 =?utf-8?B?SUMycVlGZ2VvdGdwR0ttVDFBczIySGRITnlMeHBjWGovcElRZERWNjJlSzF5?=
 =?utf-8?B?VE1lNnZFRnZMTkd3Vk1uRmZuUUZsbXJaSDRJZ2F0ZyszTCt4dEdQOUEvYUJY?=
 =?utf-8?B?OXhaQ0hXWk4yTzcyeC85TFUzV3dwdzI5SjI2UTVYNmVlY2FpbG5IQk05VGVo?=
 =?utf-8?B?NFFjOTN6cmRiVk1HVFN0YW1pN2lLMC9VU2RFbnBQREdsS2haK0dsSnVIRHpL?=
 =?utf-8?B?eURwV2F2by93R3ZSaGRwaHhOMHYxT0VOcGhHeUpRMzNzK3ROTlQzQzZKUUVY?=
 =?utf-8?B?NVNTUldBWng2eEp6aGRvNERHTmEyT3BadHFGRUxwendMZFBlNkNQZWFRWjdl?=
 =?utf-8?B?VVZ1a2pDLytNZzkvT2FmNlFVd0xwUVArYmJJUTdkQ1ZVRklabDdVSVlxWFpY?=
 =?utf-8?B?d09ac0x5RXB4UDg5c3AvcHgxdWptYzE0aTQyaW9jbjhaSmllWnh6NlBOaEUw?=
 =?utf-8?B?OS9nM0pseCtTTzdudVoxUnpxSWMrZ3RHNjBHNG5MTllpOU0yT1gxbmJWbHZj?=
 =?utf-8?B?M2VUSGRTS05YMjNuT1p6YWFVNjRETTJHQy8wUFJCeFB1VTZZVEk1SzU2cXZU?=
 =?utf-8?B?T0I0dEhQa2x3cWo5L1NlUXc5Nlo5T0FvUHU1VmpSdWRQeEp0dGRVS3U0KzBE?=
 =?utf-8?Q?80HwpHUGnSKuRZ3NiBtLjZU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 844ca1c5-e52d-4bb8-3eba-08dd358d3d79
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:51:29.6088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpONnI1jeVOGfCTdV2nQgPnDJ40c4mypa1vGOYA4GYWYIMkZqDiv2RQ/IlcfwzLAMI8pW9oB81bFyBr3wILqeXh8DWRqiDog3WpQ84jKXSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11187
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

Hi Tom,

On 1/15/25 2:22 AM, Tom Rini wrote:
> The BLK symbol has a few meanings, one of which is that it controls the
> driver model portion of a "block device". Rather than having this hidden
> symbol be "default y if ..." it should be select'd by the various block
> subsystems.
> 

As just replied on v1, I would have liked an explicit mention that yes, 
this diff doesn't include a change to PVBLOCK symbol, because it already 
does the right thing.

> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
