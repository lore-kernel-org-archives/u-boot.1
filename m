Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194D2C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 15:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3027480E9A;
	Sat,  7 Jun 2025 17:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="VtDPr1v0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DCB81F0D; Sat,  7 Jun 2025 17:02:38 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40f::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 731AC8003E
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 17:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyKNtEyUU2ICf+s1r1+SQ1oPehuGhOyoU2m6/094aiKjuzZ7TqGtplnkzXJT38EoZPBl1CyyW6Ioqz7Nem+UiFrk0FDP3wm5dEJzvesmhZgeE2owJIJS3qug3fajkyBBrcLvK6b2q7hxh6PGDijuA3s1eSDwQoz8ABqN9T2B0Plbl/dqVCq4yEesPfY5tyhSVL/QxZ3HAj5dxgMzgk5vw0lgWttz8cKkSmpLlrCpZphs4wiNQOJScEm3Oy2U7YxEYa0X4IcN0t2Y/22KVPetOSIILkuAcNMuAio9JOhCJmzP+e3rMw9CS/cQSfoysLtAoIIcjjyW1dnz9n6s2NGn2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXi/mUP0qyw24EY92Jie+uvvRWB4xJK6elzWhchp6ko=;
 b=wbLc+4lYiOVreRf/TG5uHqu935NF+nW7/r90WnbAPLmX7CF9OuTklQwDfgvk15wTzIwEaljCE3jZpgrh9Rja6qAVjG3Yxru1Gits/UpLG126bourgVDvPBvf3WgHO96qo9UzZAUaOt7CAO9RZj8zt/RhlcfEtgCtp7TWrvNWSwPikmQaRhIF4ol0caTxzU6tfdqxPgfKWBh77p48cAFr6nGpA/HY6EbrBB7xOIcU1EE2sqd14Gen/GonVdO8AcELpj4z+qHc9QWhEMLzLJZLUbJ0UFsaP7TqdZkDSzGYDIB4aMgyFxCIgr5D0DesMcdzCJVO+2LH+CpVvvA4qMWVWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXi/mUP0qyw24EY92Jie+uvvRWB4xJK6elzWhchp6ko=;
 b=VtDPr1v0x1w2r2JnYzFSmEQMQ7wQdo2vJnFWDpIuEoar3GdhVH3gwRwwGrk9tpgbhcjvjJQr3opieT0wWVviNHYunSgUabUR5kxXBByT3a6NSSUZQdifg0bKkcHBb/DaRZG6w02j9qm4EazQlbDCqZo+jRts7FPfHesxTS3N3oPEqJKfo5pKvNWG+ZNAFM7wd3qUyXuNonN/cy8eJmSnrt5q9xtgpNi2DnSdnk6DfMC2no473Nv0JIuh0dOCrbuM+ZsVX8Un4FzUUK6XX8swFyXa/g92SfGR6fy+hbZC6KJwSym4sppsmENrNnkiFXjUznyJlKg7XECVZy2V4K/itA==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by OSQPR02MB7958.apcprd02.prod.outlook.com (2603:1096:604:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Sat, 7 Jun
 2025 15:02:31 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::cb39:3489:a58d:107f%4]) with mapi id 15.20.8769.031; Sat, 7 Jun 2025
 15:02:27 +0000
Message-ID: <SEYPR02MB555756B5B864E71D805658469669A@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Sat, 7 Jun 2025 23:02:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm: armv7: fix a bug that prevents CONFIG_BLOBLIST
 and CONFIG_POSITION_INDEPENDENT to be enabled together
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, Mikko Rapeli <mikko.rapeli@linaro.org>
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
 <b80d6fe8-d477-430b-bf21-eb7662541c28@cherry.de>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <b80d6fe8-d477-430b-bf21-eb7662541c28@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <97045e16-c265-402a-bbc7-5c78170a875d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|OSQPR02MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: faf32186-57d6-4522-c359-08dda5d45147
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TXLgAZ3D7SN5ouXXOSMMCC3F2KfGSeO1Nz49qwZaUOZGRGXugqdxY+y/HfRdwea99VJO+ySOj8rZvCeUcxs6suLBE7DDaRlPPYVuaZQrLkQ1G7+8Atu9rhWmZkkOghKPyb2UkCT4f+Mlous/PW0w4krZS5YGyUbU8o69ykMr3HhKVU93Y+p+81fyorUPdJfySGo6pIqcoUfqVdEvT5xzslfCmvYCXYkzzhxjCOLLOenhp6cF3CGMiEvFbldc93o4B7NydlV2tYXe+NNOAXPcjPef8xpgxjUTwBmF9ABdg04sLM148nleejZMqrfsruR/hPFpdiIt2RCtgkkYFKQiWCTL8Fcxp6lPxzKbI9mJSlRqO+tQBLMaF5CYehsfW8OIA51YYtX44+Gc6iCANU1SHIDkO/kPiQche7M3eDHg5l0ghkuE4CCQqrNJncMMeu5bqr/2cKqiszVZUliyA/PA4wkgqmylqJOYrmbjGZVsH4/ps9wDESw3sKCRF61fiWL3rm5/e/VBEwaLWb1JZtCNZbWU8Aq1J42YbrKN08tuPrDMT3XtkP2M0Mob/AhSiRW06RzmiqpBLW2gYNQYKGj2ed0gyykXO4tRPb7h2k/xveXD/sGd3qwFj3BpTAvmDJ3l9wzULxn7aNGQacBLRPDbIGnoSaOFwpRODKhoZeVVaHk3Zklr2sPjY/kh/ymv3zrJjiaOtnxvhscEE1bJ+eumQvuL5Qi7VCzp2MIJR4Qu3w0Z4f1EF5RGz22A48rF5l2abyYeuw8bqNV8c1Zw9mpz9SsogHurawDn8k=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799009|19110799006|15080799009|461199028|6090799003|5072599009|440099028|4302099013|3412199025|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V29aQUxoZzJybUx5MlRxTkxhQlU3bVE3NWVBL3UzOVl4cHZoNHgyV3lrbmkw?=
 =?utf-8?B?SnZYd0N6U3QzdWE3WGE5dmo4K0thRC84cTJ6S0tOUUFrTVlrNmVOYlRGYng1?=
 =?utf-8?B?aHJNQ01ISjZaNmxQZ1lZNEhLVGZpOUl1U2hRNVhtL3A4c2ZjcS9ZQzRUMWhB?=
 =?utf-8?B?U0xHQmdLYXNtQ3NraGRGUTVjNkY2Q00wOC9QTWZ6aWx6YlNrbk1zOWJCenZL?=
 =?utf-8?B?cXNJdWw4RzU5cHdLdCtLVjdsWk04dzk3bUNGMVVqb0kyOVIxdHFBbTFMdSsv?=
 =?utf-8?B?WmtVT3ducThFQXZsSDdGeGgyTWJnaDR3K05XMWNuUXk1Skk3ZUxhU1M0Tk9J?=
 =?utf-8?B?MTcxNmRkR2dHRXFXbmpieGJaRVJDS3k5OUIrOHROUjdQWjFUem1ST2UvWXcr?=
 =?utf-8?B?SmhKanA0VDU3UDlNZDdoM2t2dTlUcUVobStNU2JaaGVaaU4xWmVrQjlxR0V6?=
 =?utf-8?B?d2EwdEk2Vm5OWVkzYUx3Kytua0tVZjdPazY1aDJvWk4zOUxMOEZITDVQMzE3?=
 =?utf-8?B?dVNuWUEwbWJBRjhOWEdnWVk3M29tZVc3WTBLM2tuV0dtUys1UEpOWWpSMUpn?=
 =?utf-8?B?QWN2dGNvNTk5aWlSK0ZtTThCOGllUEQxeHRmcFpMeGpiTkFRc0g1ZlM0cSt5?=
 =?utf-8?B?OUJXMXNpcWk4UUphOS9ZWkdXNHJJRFRsOGk4QnNDR3JWbER3T2FVbFd6UzNt?=
 =?utf-8?B?THNOMUFaSE41aGtydHRoMXR0RU9aaTlPUEUrb01tWmYxYlRYZUNmaldRc3lO?=
 =?utf-8?B?bWs5OTVoWmpScTc2YlZqNENVQVVrKzJJZ2RHdWRvSnRiMllnaHpQMC9PcUI2?=
 =?utf-8?B?UnJMbzBZMURiYzZ3aytDbDllNnI2WDlpUkJRdzk0b3hTcnJEYTBXdnYyUzV1?=
 =?utf-8?B?QUxSUC9rdEpiZ0dBSWtFNllnTFBSTjlIZUp2UkJndE80cmltd2dMamJ2dFBm?=
 =?utf-8?B?K2I3RGNMejVVQU1uNnRNRFpVd3l5NmtEY3dOekdudTlqSzVtcURpdHluM1Ru?=
 =?utf-8?B?YXlBSHV2aFUxeHdmNnB6K1RHbkZ0TEViY0xVNXFwcDM4Sm5ZaVFhaDRaUHJt?=
 =?utf-8?B?aFNMOGVVMUZWeUZLUTRZd0JvUE1mY2FsaTBQRTNidWdKenpqQWJKRlAya2Jq?=
 =?utf-8?B?MlhmM283L3dDTkNnNGVqMFRhaktFbytXdnZkMEExTGIwd1lxbTBKYnB4SWgw?=
 =?utf-8?B?VHgwTXN0c0liT251SG5WSm81UUFBRXZtZWdNeFZnclRXYlA2OFcxNFRzV0FP?=
 =?utf-8?B?UWxKRGlNWE50ZlBCT3gwTDVmb1ArTmlvcmtHYjdxeTVlUDZUZTI0RFVGWnlj?=
 =?utf-8?B?anFZSWJuUWpjUzFCMUFaSEp1UFFZU0Y0bGFGVEVPMEZmc3JUSDRiQ1hXZVNq?=
 =?utf-8?B?ZzdOemRJS3AwYW9pQXp4VE54OWZsYTdMUmhzNURudUJBV0kraXZ1ajJZY29x?=
 =?utf-8?B?R2xWU1BHK0EwVzl2S210eTZwbHdYcTB2Q2Zid1FGNGJRUlY3M1hIaksvOHhS?=
 =?utf-8?B?SVRqdVJxUldPN3FvWEhnVGtKb3QzdFQ5aEN4dGUwUEVmWm8rdzVCbHR3aGxN?=
 =?utf-8?B?RFFQM05YQ0tqNlNCNGJsakdSN2ZyNUpzM3p2S2ZSTkFRQ0RtNUIvaWZvM2xJ?=
 =?utf-8?B?d0Y2aGFKczE4Q01JcXdZRU1VYWlqYUFJaDBUbGVTMWNmK1dHRTJyOUtMMzhk?=
 =?utf-8?B?UUEvNkNaYzlqdG9VQ2xFVEZDSCtSRVhPN2RYdGVzR0xrSlJ2LzcyR3dBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTE0WmxaRmxBOGxjZGQwemRac01LWXFGbnFpZC92aGI3eCtod2VsN1JGNTdL?=
 =?utf-8?B?UGg2REJjYVM2elYzNzllUmFlY21MNExCZlA0cXFVdTdYbG1UdHdzNy9SMWxs?=
 =?utf-8?B?VHVmUXlZR1hhcWFEV1ptSWpmZjY0eDZZU2piUHRGVkE4aDM5ZkRRNHJVSnVZ?=
 =?utf-8?B?RmRHU01FeFduTW1LN3RDd3VCRi84M2NIaU9JTFBhc2tYMERnTG5MOWtyVlp1?=
 =?utf-8?B?bnh1Zk9aT0hGUURCNXZKUEdFdWthUHBBdGlXZ2xZdnZEZHFFaVFjWmt6dFJU?=
 =?utf-8?B?NWI4UHdxSnJ5bGo5cW1zeXk1OTYrQjBXdnluMGVlNXRnUWZkNzQwZmlXWHhF?=
 =?utf-8?B?YVd0VkhuKytQVkdoSzJKblQ4dCtzODlLWXd3NG5lMVhpem9xSU83bW1OOERh?=
 =?utf-8?B?OXBGejU3Y0RsdWx2V0xuQmJaOHlhWDdJK2M4cVZ3bFVUcWR2eHVrd2xaQUVP?=
 =?utf-8?B?NFJERUwxY1ErdzliV3NoS3l2S0V1ZXhYcWJJd3lZNndFcmxEVks3eUpzMkkr?=
 =?utf-8?B?ckpCeDdZQU80bmRreVlrUC9FMjI1b3ZUYVpYUkJKQzNsT3F2NG9Xb0lGWGw1?=
 =?utf-8?B?TG00UEM1R01kbzFFQjRzc0ZUTWttdUVNaVZvbVVZVlpNNUw2dkhKVXVWbkZS?=
 =?utf-8?B?M2N3MWYrNklUZ3puWWxTSjgvZ21LMCtKd1M0Y0loRWhXdUtZQ1hwbjhGKzRm?=
 =?utf-8?B?Sll3S3gzcTVSL1doZXFhQU1oR29wWkxqSnJybElmMVJWcE1HZzg1RVZ3aGFG?=
 =?utf-8?B?RjlFQlQ4ckVjQmU0V2FEY2h6QTlTWEkwV2U3Yy9yMHhsL3VBaHFRdWFmZ3M2?=
 =?utf-8?B?ZXUwU0E1Yms5cFl3b2dlc2p6clJwRzloL1ZVa2N6Z0diUDBFNWNwOE5BMFg1?=
 =?utf-8?B?YUptM0JGN2ZvalQ0YnU4bE93dStFeWdRQkV0Qkc0TEtTZDd0TE9Fc2lwOUow?=
 =?utf-8?B?bW9BbHQvdVhsSmkzWWtYQVY0YTVNTWQzb2M5aTVRTkhBZ1ZORk5ob2o3b2xN?=
 =?utf-8?B?V3NrSFZzcEEram9YWFhZUklpWDZTMGRqN2NWWEo2bFFSZi9maDNvdXFDdnBL?=
 =?utf-8?B?enVwcWIzbVlrejJUQ0Rlc0JKT3hUcDJBR1grTHpjSlNBcE4vTTQ3K3pheCto?=
 =?utf-8?B?ZlI2VS9sWnRDR0pEWjFxUFZidjlRR254VTFKS1I3aWZ6d3JzYVJFV0c3U3hI?=
 =?utf-8?B?eHlrYmFFM1ZRMEJ0R1pkcWFBUzdyN0tERms0aFNBN1UxZWJ3RUUxTDNOMHQv?=
 =?utf-8?B?NHNwd09xTEhadlZwaGl5OGZveWtEWjlDcVBpNkhBcXAzZFp3UkxiVjNKeWE5?=
 =?utf-8?B?R01WcEV0b0xBdXVKYlJpZWhPRlhnKzB2cGpvODgrM0hsS2Rtck1HVDd4bFlK?=
 =?utf-8?B?TkwzQUZlV3hxeUhYbGpuTGkyL3lnS0syUjZSSmJKalZieTJvaGNtWkhoa256?=
 =?utf-8?B?U1U1OEZiMzE5MHZRMzJib3ZmTkhSZ1I5OEtrK0xzSC85Vk9UU1pNcXFTcDl1?=
 =?utf-8?B?MDEvN0VsTElseGZiVjI5T2IxM3F4TlRZbW4zQllTWm5XZXZ5TUJtSlNYUllx?=
 =?utf-8?B?SUJsNEdHVmMxUHdORmRRL0R3OWtEZ0RrYSt1VDdqNzZURlhFZG80TFdVZzQ3?=
 =?utf-8?B?U3BUNUZvNndjZk5INXY0RklVemIwY3JjNjRsbTNDL2tHQVRMMnI3T0JibnJS?=
 =?utf-8?Q?LVzYKgYoXzuW7U0hWfC2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf32186-57d6-4522-c359-08dda5d45147
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 15:02:27.6409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7958
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

On 6/2/2025 6:37 PM, Quentin Schulz wrote:
> +Cc Mikko Rapeli who's attempting to patch this in OpenEmbedded-Core
>
> On 5/31/25 3:10 PM, Yang Xiwen via B4 Relay wrote:
>> [You don't often get email from 
>> devnull+forbidden405.outlook.com@kernel.org. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This patchset also enables CONFIG_POSITION_INDEPENDENT for qemu boards
>> to avoid similar issues to happen again in the future.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>> Yang Xiwen (2):
>>        arm: armv7: restore section to .text after saved_args
>>        arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT
>>
>>   arch/arm/Kconfig           | 1 +
>>   arch/arm/cpu/armv7/start.S | 2 ++
>>   2 files changed, 3 insertions(+)
>> ---
>> base-commit: 93905ab6e7564089f5d7b703b660464d675e5ab0
>> change-id: 20250529-pie_blob_fix-a61229c8fcc6
>>
>> Best regards,
>> -- 
>> Yang Xiwen <forbidden405@outlook.com>
>>
>>
>
Hi, someone please review this? This patch is so small that anyone can 
review it in 1 minute.

-- 
Regards,
Yang Xiwen

