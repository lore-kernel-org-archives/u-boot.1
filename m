Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA13C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D4281DD6;
	Mon, 12 May 2025 11:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HREmU1cO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC2682952; Mon, 12 May 2025 11:43:02 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3387B805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCHeyLj43uBrHOQKd78/BxuGTB0w3Xo2mXdG1OV3nxjahDyai4EDxS5eROqIv1Oftwb//aYjDgthnUx+1jPz/F4rKonzV8K5EVa1C4FabyeKakFbuzdb/7KOR+HHYKBW9aLUb9qafFGYr77FDptpAatrsxcsn6bVvC+HQxOUG8ymHFT1SwqtgR770hKP5IQYfDmm9rn+8NVctrXnS9hAXGSb53If2o0WeLdR/In/FubyKcxmtJ0sSQMoJX+JYmHbKc945o8QvPzZA8bnEFXGZiBoIjRGRPqqUKOuBrpililxHs+forjUIyi5dCLUMwZDJIg9356zTCu+Z2vctrFtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trg63ZFKaKNMKu9Mdcq+fCN96cvVHb2fX+H8yZA6Cuc=;
 b=GpusNldqZjBzxtwYSlTnjrQHBJuQOQbyEhY0Y4I00wquFejJFZXJ1wOcCYzch53mVzISLPpyVTElbIlKLkN+jlx9g/609cYdNJqENGkqAm0liUO37McXBU5lQ/WOfwYixc5/mNNxN1PKXiwcZNZfq7WUnmiUevq/aQdvQwDhqHM0g9Q1fbGBICp5/EngiLBDtaNYxTAyGSWK7mMhh+DopcL8o4Ep+hA4qPyjKTPtud7Mn98eoWdZAZ1vyXgTXodZU0ksStDAjgw9YjHmRlexIl9qycgc1iqPZu2KFNAeeZ86q7Fg/dc+RE+nq82QjMDDB217mcdNeIuuDictLp9Z9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trg63ZFKaKNMKu9Mdcq+fCN96cvVHb2fX+H8yZA6Cuc=;
 b=HREmU1cO991CEPAbNiv4OPBxv1WnnLgXbMIaanrw/jg87Ns3qYEGnsMGPNy2aESLdB26WffKpIyfgJCvzQM6qMuxXa+tQDVMQPQjaJi2CCGENEsnqfBB8bjWe0QRFWPByNFWd+JABgk5s5l/x31nDwqjLsYlWjmON/0gtaHCbKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 09:42:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:42:57 +0000
Message-ID: <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
Date: Mon, 12 May 2025 11:42:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
To: Neil Armstrong <neil.armstrong@linaro.org>, verdun@hpe.com,
 jmverdun3@gmail.com, u-boot@lists.denx.de
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
 <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 08678881-4f69-4f81-7e39-08dd9139605f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3p6TU14YnJWQzU3bkNLT01QWm1zRi9XeVNnMVpOTTBxYXJCeVdhaytLZWdF?=
 =?utf-8?B?S1lFREQxVEtlRjdjZ0ttMW9VbmNtWnFndXg3b21sL2Zzcno1TWVTOHhiNDFu?=
 =?utf-8?B?eUxjWG56dS9MR0x2bmd1MmM3ZXNZU1dJT2V6clVNV2NabFdLKzljd09nTGJl?=
 =?utf-8?B?amYwN1BYam5rcll1aE42N0F1SC9OSmpKTklBWVJlNml4bWJORTYvclJNMCts?=
 =?utf-8?B?VllxUVlNb3BOVWRpc3FmL3YxQTdMV3dxSlJQTHNvUDZxOHlqclJqcjdqdHh2?=
 =?utf-8?B?R05lUUhUYlE1Z25QUHJvclBxanM4VXQxNXYrR096dlVnWjhUZWdsTUo1MGVV?=
 =?utf-8?B?ODZkT3RxK1RhcDY4dnAwSnZXZ2FGb0RTYTIwUWxFMVBPTGpETmVKb0RaWDAx?=
 =?utf-8?B?UE96andBa05vdkhjNkp6aXQ3NEU2UGtDRTM3RWRqUFp4NXk2L3A3UTJ3Q3pT?=
 =?utf-8?B?ZSs2MVNhaXU3Z0k0cFZ4d0RRUjdtMkhNQ0hSLy9VTzhzZTU1UEU5dGtITlli?=
 =?utf-8?B?TDY3akgxTlRVYnlnVlZpOUJBYk9ERENobnJ3V3FrWXVGVGg4SEUvRWxMNWVZ?=
 =?utf-8?B?RUdZdW5hdzhITTY2K21XbzR5MnQvR0ZBYVg1anRld0srT2toU0REUnBKSGVx?=
 =?utf-8?B?TW5GQXlSeFFzQkdZNjl5MEQyZFgvVVpHeFhJRkJnRmd5dThFWExNNy9oNTAx?=
 =?utf-8?B?cnpFT3RsajVUMlpVSFhDVkF3bWgxNTNaYjlVTlVKZUEyeDc4YlF5OWd2OWpN?=
 =?utf-8?B?cXh1YWowK1FrdU5kTThZQ3FtWlJvNmJJOFkxdHkyKzZFcUE2RlJVZTNOMzZS?=
 =?utf-8?B?WjhCeWVZZjg3YmU3R0VuQmpRbWNjcUgvUmtiNzVhTFYzTlN3ZWRldmdMUFcr?=
 =?utf-8?B?Z2hQSFU5MVFWVXovMDQzVWRlL2NIN2J1elh5SFV2U1VLYnFGTHQ2eHNYVGNz?=
 =?utf-8?B?K0piYVRDNEZ4QWVDeFdQamM1bnJWdFlNTUsvS0Jab0FEZUhydC9ZS0xCR2dj?=
 =?utf-8?B?S3hNSjR1cWF5andnTk5za2UyakdHSE5LT3U2N0pmcGpmMVJTMit5aldOWTMr?=
 =?utf-8?B?dWd1eU5RNzQra3VNaEF0MWROVWNsRmxQaHZFUHR2cFI3YWdxa0IwZTFlMDNh?=
 =?utf-8?B?S2tPMm54WmZtNUlvdlMwa1hWNW8ycnFjVy9BWGU3Vm1hMEdmeFQrQnNVQjds?=
 =?utf-8?B?byt2cWRXQyttNUF5V1o3aUNnWUx6RVQwSGxrY05mQ20rNzJCRGI1WC9yZ25v?=
 =?utf-8?B?ZlU4Q2ZWUC9ULzcvblpRNWhWbVdBbnlkOS9BeG5LNW5QR09sQ08rQnV0V2d0?=
 =?utf-8?B?a2swZyszYzA4MjdzYWlmeTIrSlZla1ZzTWY0M2pMbG90V2hDQTJnMnlZbmVI?=
 =?utf-8?B?dGthLy9JQlREbjJNK1FOU0J2QldXV2REMGFLQVZxMklEZ1hsOGRlRjk0NGtm?=
 =?utf-8?B?UFd5TCtCN1lkY2Fpb1k0SEpsRERiR2I5SjVaN0I0UTZGLzBSZnZVLzVUZENZ?=
 =?utf-8?B?MHJScklvdWszY3JseTRkQllZTWpnOExYWGs3b3ZhQWtLTW1pcGF6T3FkVmtH?=
 =?utf-8?B?a2RJVWdlVTdwMTQzSXg0clNWSzk0bnB3eHdxRUg4bW16bElIdGpxYjlXL1BL?=
 =?utf-8?B?U2x5dkdJNC9kTm1IZE9QWlBCTXJpd1lVaGc5dmhDWi81ZldFS25RNE9VclFE?=
 =?utf-8?B?VnZHNzlMMjFPSEpNWnpPUE5tYVRWZDYvcmpEZDBia1dwZ2RocDgwOWJOTzds?=
 =?utf-8?B?Uk9HV3JYWDNQQ3hyR0pUTUFEVy9iMHA0aUlrS25ZR0krdGtDVjV2V2h2bWZa?=
 =?utf-8?Q?Dh+ac4kda2+flYKpjW+M148oeIAWL6ToS6czA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGQxeTI4TVIvVytiRGw0bzhUaktVb0xTeERyTnhhOHJHcS9penpJRU5mdDl1?=
 =?utf-8?B?aVpvbytDOEZHdFQxSjA4VHFGUUZ2c0dMcmZ5NnNSRjFRTHRWR2VKMUR2d3E0?=
 =?utf-8?B?c0pQN01SZTkyL2NveWNocjFJZy9OdFNYQzZGcDJkeW5SVE1EL2FGbnhaY3Zh?=
 =?utf-8?B?bUNkamkwMzFzUUNXcDk3RTFtWmhwbFlBUFhCcHNMNHVrZ3BscW0rem50bGFM?=
 =?utf-8?B?dUQ1ZU9WSnZVZ2cwUWFuK3Rnb0hDWXVQQ0ZUZHYxNlZMZXdVMkI1Z2tEUk5y?=
 =?utf-8?B?Z2RNdkVPSmhZTnpHd1oyeE8rRGU2OTdFK1IvWVZPQk13TVVXMHlWQmNOQ1JT?=
 =?utf-8?B?a3dEUHUxUXhYdDNsT3c1YlFkQXJpb0JWNENJdCtKUGdpZFR3cUtYQTFsTEdp?=
 =?utf-8?B?VklFd1VKdDBOUmo1QjJ1NFVkNFJWT0RtYWM5QWxnK2dWVklVRmFCbllQd3Nk?=
 =?utf-8?B?bUU5VHkwQjFtcEdSYUozU3BKTVBSS0hsZU42K3E1MU00bDV0ZXVqWHM0ZmdK?=
 =?utf-8?B?YW54VnJEVkJyOUZPdW9XRnU1Y1BKODVPMXQ1U1VYK3ZkOHBRUTBhS2JURW5m?=
 =?utf-8?B?RkpmZlo0M0pwZlIrOThGR3ppQlFiRnlUSXBuL1NTK3N2U01GRlUzWEFPVnNm?=
 =?utf-8?B?MmFVQzdSZVA2WnZDSWg5UCt6OGxJOFIvSG91MDZkVFh0MlZhSE9YaEozOWdu?=
 =?utf-8?B?bTdTV01hQWVHOGVoV3RKSllDOGE3bUIzMm40d0t4NjJabGFZRkxOS2pVbmF4?=
 =?utf-8?B?N3ZMMDZEdkN4VVJSbGRWSEVjSk80RHUvN003T3JxY3hqQjB3T1JBTkUreit0?=
 =?utf-8?B?R09FT2FEb0pTd2NFZW5nbS96L3VhYkZUWXU0czFxQlhucGpScEwwTTJTaHJM?=
 =?utf-8?B?aGRkT3VzSFcyaUhONVlRSEUwcmhreWN5RnBPSVpnZWZpNVhuWVlrUS9IV1E5?=
 =?utf-8?B?TXUwNDllZkdxcWRRZWEyRzBSZDdLR3ZLcFptWTBWM3UwTElWSHVQVWVsdFFF?=
 =?utf-8?B?LzBQSFl2UUttWUVqbGJpaEZOYUlpMjZiL3Qrc2lVaEZuZDByTUQraUdPRGp3?=
 =?utf-8?B?ekxEOXdWRWtQcUtFOVJSS3A0M2hRS3pyVFYzSWc0dkFIbXZZTGkrN05vTk9a?=
 =?utf-8?B?RjhrR1N0R1VXTE5HN0ozQ1lTR1IwY2tUTEc1ZHU3VFV3VTdFazl0Ym5Hckdq?=
 =?utf-8?B?bG9MS3M3MUFmQkJmQzk2NnBpeUpIejNRMEVHVXBKaUtNQkYvMyswc3VtUnF5?=
 =?utf-8?B?L3hOZ2xYQ0lzRWxvSks3b1d1NVN1NFVPc1Z2Ny80YTd1Mmk1RTR5R0RSOStw?=
 =?utf-8?B?QXlRQ2s1ZEM2MzVKYUd6aFZDR3VQZzBBQm02UEVGMUVXMjlUakNhWk04bk51?=
 =?utf-8?B?Um1EZmJuR1FRVjlOeXhPZHQrRUF4R2VTR1ltWEFDVWE4Sm1RQjVuUG9KbFVR?=
 =?utf-8?B?cjVCdklXOUdObWtNNU1jRmtGRzg2TXN4ajIyUE92ajlqMnIvcFVuZ25VSlkv?=
 =?utf-8?B?djJWbmFMK00zVjcrTVY3b2NrZllEbXAwejRiZVNkYXlhc014QVN6YllUMGo3?=
 =?utf-8?B?b1JLdTZ3dFIrNTJTV1BHUWFvYXY3Mm5adWlNdlZVNi94RXlZcEF0aXJDV0sy?=
 =?utf-8?B?NzVGUFpwdmRpczB6TjROTFBFVDEzM2svN09vR0p3cUJTRjdvWHRBSStMV0du?=
 =?utf-8?B?ZFdnRm1IbFlEbFZMTVkyYzBpTzZ1U210MkFXakszc1M0a3pnSWJDY1MrekRk?=
 =?utf-8?B?YmpZK1pXa1ZnU25qYm9QSVYzZGtDVk5JbTNiTHV4eXV0VmFiL2JpWjNKRm5z?=
 =?utf-8?B?UHlRMHZJNElrWkZaTGlTK0dKcVVlSGlVbEZkSWpMQTBsWlBZeW9sZ0J0Yldh?=
 =?utf-8?B?MXdzeXpaN0JnbU1lSzFFUk44T0YxdEpXZ21ZZm5tWXAyZmROZG5pS25PSFF1?=
 =?utf-8?B?akNDemdVZ1o0clU1YzdGQVhqM2p3SmN1Yi8za2g5MHh5Q2kraTJETWZJS3c3?=
 =?utf-8?B?RjdkNlp0S215VmU5SXVFWmFRWkI2Q2d3aDVCa0VtQkh2VTJkTWtjdElHMkNj?=
 =?utf-8?B?NkE0WExXR1RxRTVFd0M3R1gwNEM1S3ZUdWFMbkdpbEJ6LzdIdmRJUzJKc3ZJ?=
 =?utf-8?B?NGpzQ0lxZmIwTVgyWXRRTENjakpLUjhkeDNIVWVrRm1sMjZCNStuSzdpdVdL?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 08678881-4f69-4f81-7e39-08dd9139605f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:42:57.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1f+owv7Bo3sy8Ma84CZXHyA0kPFRrJ9VUEFPIqIS+GXluIyeQdUwHc2V+ugcCluZL6jU9e4/LGbdBio+X6w+m2uaAay0m/ReoyTHgKl7K2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551
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

Hi Neil, Jean-Marie,

On 5/12/25 10:10 AM, neil.armstrong@linaro.org wrote:
> Hi,
> 
> Thanks for fixing it !
> 
> On 11/05/2025 20:02, verdun@hpe.com wrote:
>> From: Jean-Marie Verdun <verdun@hpe.com>
>>
>> Add support for the Wiznet W5500 spi to ethernet controller
>>
>> Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
>> ---
>>   drivers/net/Kconfig  |   9 +
>>   drivers/net/Makefile |   1 +
>>   drivers/net/w5500.c  | 584 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 594 insertions(+)
>>   create mode 100644 drivers/net/w5500.c
>>
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 950ed0f25a9..74668f477ae 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -19,6 +19,15 @@ config SPL_DM_ETH
>>       depends on SPL_NET
>>       def_bool y
>> +config W5500
>> +    bool "W5500 device driver"
>> +    depends on SPI
>> +    help
>> +      Enable w5500 driver
>> +
>> +      Adds support for Wiznet W5500 device. The device must be attached
>> +      to a SPI bus.
>> +
>>   config DM_MDIO
>>       bool "Enable Driver Model for MDIO devices"
>>       depends on PHYLIB
>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
>> index 67bba3a8536..6d85c38d869 100644
>> --- a/drivers/net/Makefile
>> +++ b/drivers/net/Makefile
>> @@ -103,6 +103,7 @@ obj-$(CONFIG_SUN8I_EMAC) += sun8i_emac.o
>>   obj-$(CONFIG_TSEC_ENET) += tsec.o fsl_mdio.o
>>   obj-$(CONFIG_TULIP) += dc2114x.o
>>   obj-$(CONFIG_VSC7385_ENET) += vsc7385.o
>> +obj-$(CONFIG_W5500) += w5500.o
>>   obj-$(CONFIG_XILINX_AXIEMAC) += xilinx_axi_emac.o
>>   obj-$(CONFIG_XILINX_AXIMRMAC) += xilinx_axi_mrmac.o
>>   obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
>> diff --git a/drivers/net/w5500.c b/drivers/net/w5500.c
>> new file mode 100644
>> index 00000000000..a15255bb457
>> --- /dev/null
>> +++ b/drivers/net/w5500.c
>> @@ -0,0 +1,584 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *  Copyright Hewlett Packard Enterprise Development LP.
>> + *
>> + * Jean-Marie Verdun <verdun@hpe.com>
>> + *
>> + * Inspired from the linux kernel driver from:
>> + * - Copyright (C) 2006-2008 WIZnet Co.,Ltd.
>> + * - Copyright (C) 2012 Mike Sinkovsky <msink@permonline.ru>
>> + *
>> + * available at
>> + * - https://eur02.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2Fmaster%2Fdrivers%2Fnet%2Fethernet%2Fwiznet%2Fw5100.c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cc46cc28f1cef4e123f8008dd912c7e86%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638826343382626512%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=nnWuRiS1B1wya4helTsVcJ92ZEjG81Ir%2BlSt0Kh9woI%3D&reserved=0
>> + *
>> + * Datasheet:
>> + * - https://eur02.safelinks.protection.outlook.com/? 
>> url=http%3A%2F%2Fwww.wiznet.co.kr%2Fwp- 
>> content%2Fuploads%2Fwiznethome%2FChip%2FW5100%2FDocument%2FW5100_Datasheet_v1.2.6.pdf&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cc46cc28f1cef4e123f8008dd912c7e86%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638826343382649703%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Z57oXSn9Nmwbd5RkkxVq9BfG56JB0LgWuYavpYOJgA8%3D&reserved=0
>> + * - https://eur02.safelinks.protection.outlook.com/? 
>> url=http%3A%2F%2Fwiznethome.cafe24.com%2Fwp- 
>> content%2Fuploads%2Fwiznethome%2FChip%2FW5200%2FDocuments%2FW5200_DS_V140E.pdf&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cc46cc28f1cef4e123f8008dd912c7e86%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638826343382668572%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=uDhG%2BbKQyck51qSdZCMvFbXJCDcj4I40Q18Ogl2oBnw%3D&reserved=0
>> + * - https://eur02.safelinks.protection.outlook.com/? 
>> url=http%3A%2F%2Fwizwiki.net%2Fwiki%2Flib%2Fexe%2Ffetch.php%3Fmedia%3Dproducts%3Aw5500%3Aw5500_ds_v106e_141230.pdf&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cc46cc28f1cef4e123f8008dd912c7e86%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638826343382685514%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=NkSjVHnMa4kAWiB21NDTTF%2F2ODvFbUS33zwz5%2FK69Jw%3D&reserved=0
>> + *
>> + */
>> +
>> +#include <dm.h>
>> +#include <log.h>
>> +#include <malloc.h>
>> +#include <spi.h>
>> +#include <net.h>
>> +#include <asm/global_data.h>
>> +#include <dm/device_compat.h>
>> +#include <linux/delay.h>
>> +#include <linux/iopoll.h>
>> +#include <net.h>
>> +#include <malloc.h>
>> +
>> +#define BUFFER_SZ       16384
>> +#define MAX_PACKET_SZ    9000
>> +#define W5100_SPI_WRITE_OPCODE 0xf0
>> +#define W5100_SPI_READ_OPCODE 0x0f
>> +#define W5100_SHAR              0x0009    /* Source MAC address */
>> +#define W5500_S0_REGS           0x10000
>> +#define S0_REGS(priv)           ((priv)->s0_regs)
>> +#define W5100_MR                0x0000    /* Mode Register */
>> +#define   MR_RST                  0x80    /* S/W reset */
>> +#define   MR_PB                   0x10    /* Ping block */
>> +
>> +#define W5100_Sn_MR             0x0000    /* Sn Mode Register */
>> +#define W5100_Sn_CR             0x0001    /* Sn Command Register */
>> +#define W5100_Sn_IR             0x0002    /* Sn Interrupt Register */
>> +#define W5100_Sn_SR             0x0003    /* Sn Status Register */
>> +#define W5100_Sn_TX_FSR         0x0020    /* Sn Transmit free memory 
>> size */
>> +#define W5100_Sn_TX_RD          0x0022    /* Sn Transmit memory read 
>> pointer */
>> +#define W5100_Sn_TX_WR          0x0024    /* Sn Transmit memory write 
>> pointer */
>> +#define W5100_Sn_RX_RSR         0x0026    /* Sn Receive free memory 
>> size */
>> +#define W5100_Sn_RX_RD          0x0028    /* Sn Receive memory read 
>> pointer */
>> +
>> +#define W5100_S0_MR(priv)       (S0_REGS(priv) + W5100_Sn_MR)
>> +
>> +#define   S0_MR_MACRAW            0x04    /* MAC RAW mode */
>> +#define   S0_MR_MF                0x40    /* MAC Filter for W5100 and 
>> W5200 */
>> +#define   W5500_S0_MR_MF          0x80    /* MAC Filter for W5500 */
>> +#define W5100_S0_MR(priv)       (S0_REGS(priv) + W5100_Sn_MR)
>> +
>> +#define   S0_MR_MACRAW            0x04    /* MAC RAW mode */
>> +#define   S0_MR_MF                0x40    /* MAC Filter for W5100 and 
>> W5200 */
>> +#define   W5500_S0_MR_MF          0x80    /* MAC Filter for W5500 */
>> +
>> +/*
>> + * W5100 and W5200 common registers about the same with the W5500
>> + */
>> +#define W5100_IMR               0x0016    /* Interrupt Mask Register */
>> +#define   IR_S0                   0x01    /* S0 interrupt */
>> +#define W5100_RTR               0x0017    /* Retry Time-value 
>> Register */
>> +#define   RTR_DEFAULT             2000    /* =0x07d0 (2000) */
>> +#define W5500_SIMR              0x0018    /* Socket Interrupt Mask 
>> Register */
>> +#define W5500_RTR               0x0019    /* Retry Time-value 
>> Register */
>> +
>> +#define W5100_S0_CR(priv)       (S0_REGS(priv) + W5100_Sn_CR)
>> +#define   S0_CR_OPEN              0x01    /* OPEN command */
>> +#define   S0_CR_CLOSE             0x10    /* CLOSE command */
>> +#define   S0_CR_SEND              0x20    /* SEND command */
>> +#define   S0_CR_RECV              0x40    /* RECV command */
>> +#define W5100_S0_IR(priv)       (S0_REGS(priv) + W5100_Sn_IR)
>> +#define   S0_IR_SENDOK            0x10    /* complete sending */
>> +#define   S0_IR_RECV              0x04    /* receiving data */
>> +#define W5100_S0_SR(priv)       (S0_REGS(priv) + W5100_Sn_SR)
>> +#define   S0_SR_MACRAW            0x42    /* mac raw mode */
>> +#define W5100_S0_TX_FSR(priv)   (S0_REGS(priv) + W5100_Sn_TX_FSR)
>> +#define W5100_S0_TX_RD(priv)    (S0_REGS(priv) + W5100_Sn_TX_RD)
>> +#define W5100_S0_TX_WR(priv)    (S0_REGS(priv) + W5100_Sn_TX_WR)
>> +#define W5100_S0_RX_RSR(priv)   (S0_REGS(priv) + W5100_Sn_RX_RSR)
>> +#define W5100_S0_RX_RD(priv)    (S0_REGS(priv) + W5100_Sn_RX_RD)
>> +
>> +#define W5500_TX_MEM_START      0x20000
>> +#define W5500_TX_MEM_SIZE       0x04000
>> +#define W5500_RX_MEM_START      0x30000
>> +#define W5500_RX_MEM_SIZE       0x04000
>> +
>> +#define W5500_Sn_RXMEM_SIZE(n)  \
>> +        (0x1001e + (n) * 0x40000)    /* Sn RX Memory Size */
>> +#define W5500_Sn_TXMEM_SIZE(n)  \
>> +        (0x1001f + (n) * 0x40000)    /* Sn TX Memory Size */
>> +
>> +/**
>> + * struct eth_w5500_priv - memory for w5500 driver
>> + */
>> +struct eth_w5500_priv {
>> +    uchar host_hwaddr[ARP_HLEN];
>> +    bool disabled;
>> +    uchar * recv_packet_buffer[PKTBUFSRX];
>> +    int recv_packet_length[PKTBUFSRX];
>> +    int recv_packets;
>> +    const struct dm_spi_ops *spi_ops;
>> +    struct udevice **spi_dev;
>> +    u32 s0_regs;
>> +    u32 s0_tx_buf;
>> +    u16 s0_tx_buf_size;
>> +    u32 s0_rx_buf;
>> +    u16 s0_rx_buf_size;
>> +    bool promisc;
>> +    u32 msg_enable;
>> +    u16 offset;
>> +    void *priv;
>> +};
>> +
>> +static int xfer(struct udevice *dev, void *dout, unsigned int bout, 
>> void *din,
>> +        unsigned int bin)
>> +{
>> +    /* Ok the xfer function in uboot is symmetrical
>> +     * (write and read operation happens at the same time)
>> +     * w5500 requires bytes send followed by receive operation on the 
>> MISO line
>> +     * So we need to create a buffer which contain bout+bin bytes and 
>> pass the various
>> +     * pointer to the xfer function
>> +     */
>> +
>> +    struct udevice *bus = dev_get_parent(dev);
>> +    u8 buffin[BUFFER_SZ];
>> +    u8 buffout[BUFFER_SZ];
> 
> It's dangerous to allocate 2 16k buffers on the stack, move them global
> or allocate them at probe and store the pointers in eth_w5500_priv
> 
>> +
>> +    if ((bout + bin) < BUFFER_SZ) {
>> +        for (int i = 0; i < bout; i++) {
>> +            buffout[i] = ((u8 *)(dout))[i];
>> +            buffin[i] = 0;
>> +        }
>> +        for (int i = bout; i < (bin + bout); i++) {
>> +            buffin[i] = 0;
>> +            buffout[i] = 0;
>> +        }
>> +        if (!bus)
>> +            return -1;
>> +        dm_spi_xfer(dev, 8 * (bout + bin), buffout, buffin,
>> +                SPI_XFER_BEGIN | SPI_XFER_END);
>> +        for (int i = bout; i < (bin + bout); i++)
>> +            ((u8 *)(din))[bin + bout - i - 1] = buffin[i];
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int w5500_spi_read(struct udevice *dev, u32 addr)
>> +{
>> +    u8 cmd[3];
>> +    int ret;
>> +    u8 bank;
>> +    u8 data;
>> +
>> +    bank = (addr >> 16);
>> +
>> +    if (bank > 0)
>> +        bank = bank << 3;
>> +
>> +    cmd[0] = addr >> 8;
>> +    cmd[1] = addr & 0xff;
>> +    cmd[2] = bank;
>> +
>> +    ret = xfer(dev, cmd, sizeof(cmd), &data, 1);
>> +    if (ret != 0)
> 
> if (ret)
> 
>> +        return ret;
>> +
>> +    return data;

This is dangerous too. How do I know if the returned data is an error 
code or actual data?

Right now, xfer returns 0 if successful, -1 otherwise. I would suggest 
return ret only if it is < 0.

Or even better, propagate the error code and return data through a 
pointer as argument of the function?

e.g.

static int w5500_spi_read(struct udevice *dev, u32 addr, u8 *data)
{
[...]
     return xfer(dev, cmd, sizeof(cmd), &data, 1);
}

>> +}
>> +
>> +static int w5500_spi_write(struct udevice *dev, u32 addr, u8 data)
>> +{
>> +    u8 cmd[4];
>> +    u8 bank;
>> +    u8 din;
>> +
>> +    bank = (addr >> 16);
>> +    din = 0;
>> +
>> +    if (bank > 0)
>> +        bank = bank << 3;
>> +
>> +    cmd[0] = (addr >> 8) & 0xff;
>> +    cmd[1] = addr & 0xff;
>> +    cmd[2] = bank | 0x4;
>> +    cmd[3] = data;
>> +
>> +    return xfer(dev, cmd, sizeof(cmd), &din, 0);
>> +}
>> +
>> +static int w5500_spi_read16(struct udevice *dev, u32 addr)
>> +{
>> +    u8 cmd[3];
>> +    u16 data;
>> +    int ret;
>> +    u8 bank;
>> +
>> +    bank = (addr >> 16);
>> +
>> +    if (bank > 0)
>> +        bank = bank << 3;
>> +
>> +    cmd[0] = addr >> 8;
>> +    cmd[1] = addr & 0xff;
>> +    cmd[2] = bank;
>> +
>> +    ret = xfer(dev, cmd, sizeof(cmd), &data, 2);
>> +    if (ret != 0)
> 
> if (ret)
> 
>> +        return ret;
>> +
>> +    return data;
>> +}
>> +

Ditto.

Considering the only difference between w5500_spi_read16 and 
w5500_spi_read is the 2 or 1 as last argument of xfer() call, you 
probably want to factor them out into a common function to limit 
duplicated code.

If you have access to the info, I would suggest to NOT use a u8[3] array 
but create a small struct which specifies what each u8 is for so it's 
easier to read and debug later on. This applies to all other functions.

>> +static int w5500_writebulk(struct udevice *dev, u32 addr, const u8 *buf,
>> +               int len)
>> +{
>> +    int i;
>> +    u8 bank;
>> +    u8 cmd[9000];

You really need to justify that big of an array, why do you need that? 
Can't we malloc it based on len?

>> +    u8 din = 0;
>> +
>> +    bank = (addr >> 16);
>> +    if (bank > 0)
>> +        bank = bank << 3;
>> +
>> +    cmd[0] = (addr >> 8) & 0xff;
>> +    cmd[1] = addr & 0xff;
>> +    cmd[2] = bank | 0x4;
>> +
>> +    for (i = 0; i < len; i++)
>> +        cmd[i + 3] = buf[i];
>> +
>> +    return xfer(dev, cmd, len + 3, &din, 0);
>> +}
>> +
>> +static int w5500_spi_write16(struct udevice *dev, u32 addr, u16 data)
>> +{
>> +    u8 buf[2];
>> +
>> +    buf[0] = data >> 8;
>> +    buf[1] = data & 0xff;
>> +

Looks like endianness swap to me? Is this supposed to happen if you have 
another endianness for the SoC than the one you're currently using to 
test this?

>> +    return w5500_writebulk(dev, addr, &buf[0], 2);
>> +}
>> +
>> +static int w5500_readbulk(struct udevice *dev, u32 addr, u8 *buf, int 
>> len)
>> +{
>> +    u8 cmd[3];
>> +    u8 *data;
>> +    int i;
>> +    int ret;
>> +    u8 bank;
>> +
>> +    data = (u8 *)malloc(MAX_PACKET_SZ);
> 
> Why not malloc(len) ?
> 
>> +
>> +    if (!data)
>> +        return -1;

-ENOMEM?

>> +
>> +    bank = (addr >> 16);
>> +
>> +    if (bank > 0)
>> +        bank = bank << 3;
>> +
>> +    cmd[0] = addr >> 8;
>> +    cmd[1] = addr & 0xff;
>> +    cmd[2] = bank;
>> +
>> +    ret = xfer(dev, cmd, sizeof(cmd), &data, len);
>> +
>> +    if (ret != 0) {
> 
> if (ret) {
> 
>> +        free(data);
>> +        return ret;
>> +    }
>> +
>> +    for (i = 0; i < len; i++)
>> +        buf[(len - 1) - i] = data[i];
>> +    free(data);
>> +    return 0;
> 
> or add:
>      out:
>          free(data)
>          return ret;
> 
> and replace with:
>      if (ret)
>          goto out;
> 

Agree with Neil here, go for the typical goto solution for unwinding 
code in the error path(s).

>> +}
>> +
>> +static int w5500_readbuf(struct udevice *dev, u16 offset, u8 *buf, 
>> int len)
>> +{
>> +    struct eth_w5500_priv *priv = dev_get_priv(dev);
>> +    u32 addr;
>> +    const u32 mem_start = priv->s0_rx_buf;
>> +    int remain = 0;
>> +    int ret;
>> +    const u16 mem_size = priv->s0_rx_buf_size;
> 
> Order by line length
> 
>> +
>> +    offset %= mem_size;
>> +    addr = mem_start + offset;
>> +
>> +    if (offset + len > mem_size) {
>> +        remain = (offset + len) % mem_size;
>> +        len = mem_size - offset;
>> +    }
>> +
>> +    ret = w5500_readbulk(dev, addr, buf, len);
>> +    if (ret || !remain)
>> +        return ret;
>> +
>> +    return w5500_readbulk(dev, mem_start, buf + len, remain);
>> +}
>> +
>> +static int w5500_writebuf(struct udevice *dev, u16 offset, const u8 
>> *buf,
>> +              int len)
>> +{
>> +    struct eth_w5500_priv *priv = dev_get_priv(dev);
>> +    u32 addr;
>> +    const u32 mem_start = priv->s0_tx_buf;
>> +    int ret;
>> +    int remain = 0;
>> +    const u16 mem_size = priv->s0_tx_buf_size;
> 
> Ditto
> 
>> +
>> +    offset %= mem_size;
>> +    addr = mem_start + offset;
>> +
>> +    if (offset + len > mem_size) {
>> +        remain = (offset + len) % mem_size;
>> +        len = mem_size - offset;
>> +    }
>> +
>> +    ret = w5500_writebulk(dev, addr, buf, len);
>> +    if (ret || !remain)
>> +        return ret;
>> +
>> +    return w5500_writebulk(dev, mem_start, buf + len, remain);
>> +}
>> +
>> +static int w5500_command(struct udevice *dev, u8 cmd)
>> +{
>> +    struct eth_w5500_priv *priv = dev_get_priv(dev);
>> +    u8 val;
>> +    u16 check;
>> +
>> +    w5500_spi_write(dev, W5100_S0_CR(priv), cmd);
>> +    check = read_poll_timeout(w5500_spi_read, val, val != 0,
>> +                  10, 5000, dev, W5100_S0_CR(priv));
>> +    if (check != 0)
> 
> if (check)
> 
>> +        return -EIO;
> 
> return ret
> 

and use ret instead of check for the variable name.

>> +
>> +    return 0;
>> +}
>> +
>> +static int w5500_eth_start(struct udevice *dev)
>> +{
>> +    struct eth_w5500_priv *priv = dev_get_priv(dev);
>> +
>> +    debug("eth_w5500: Start\n");

Please use log_debug()/dev_dbg instead of debug().

Cheers,
Quentin
