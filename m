Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75447C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBCBD82977;
	Thu, 26 Jun 2025 13:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h68vyEF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0A382AA4; Thu, 26 Jun 2025 13:15:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F55B801BE
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu9zI3auAai9I4Mlxt1zoHHQPRTqnV5bbEAyOP+UbC8aXbjMmKnIJakbaXP4xJPeVwCMem6KnJ0GKYi+WkWdMfvZT1/4zEnrN+w897eGmm6IBd7rL1qIab2xsmOxidFEPjG0cCaK+j5AouAATNKemcZdZY76xpdb5pa7jHUhf3pWQQClgnNlERPtNktVuoFNYV2mNgaGAKqMF4KsFoq119WWp9C3Z4IZHn2GVOlTG6uKPVhSzKzGXOet5XlPn4tVwGyaM9HjEK1KSoltKi+NMZkN0uMMX6pGLH0Z62OP8WZKUViZmbja5SjwA7NNyin75p1d1L0dQ4HpnNCjYSj2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPPSEoSEvxE6W6WhBgNYsNKEB5WwVOBVsfL7YrnHHCA=;
 b=DrhcHe+2XYC0IRmc7KmjmNvpwKpWaBHkrXbZQzl1kQxv7kqjWsoWSXnj5wp4b+bdHyGgYw0oy9YUbeICZUyTFB13XNRKptiDd0mLMXLTl6b6I+WqoOkw073nQqCCoONsyssEINv76dppHSrUmK4NGTAdKhavIlN+5XVCYkeP2dUl+QELH/h2jtbSJPsMCfBMYAnTZAoqbcu5iVkbAuw1znhfvVpPDtUct5ZZdr/W+ynB9Ur1lLX2oHj/ms+wPLSLt8XWuhRFZg1vGd7rjM3TVW2Plg/RKdNqCM+RucQ3ZZ7+QSrMt5uw6BrS5CoTuaHPeyESnKsmh4UcINe5Z7S28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPPSEoSEvxE6W6WhBgNYsNKEB5WwVOBVsfL7YrnHHCA=;
 b=h68vyEF6nMRm//N5s2/KOGZPm7SnbbEz1YRpzx/N+fsDTFdLQoAPbs7RmAlXXTlr74SQ1CSxhQn731gre99abPJNEUxE8qald/JU60Vh5KBrwY60YhRtMV8sM5mi9oPl6GQ1oJWNVp0RBiuMIBPNR4fuCLL12I3wcllMjyVPe18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9681.eurprd04.prod.outlook.com (2603:10a6:20b:480::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Thu, 26 Jun
 2025 11:14:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 11:14:26 +0000
Message-ID: <b8e3d928-7f3c-46ef-bf6d-6eb8a48931ac@cherry.de>
Date: Thu, 26 Jun 2025 13:14:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: Prevent use of uninitialised variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250626-mtd_fix-v1-1-1ffcc59a9d0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: f25ba06b-1056-4a64-f50c-08ddb4a29c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUhxSjdsTzcyeTFrQy9hMUJ3NEZRRDlwamI0MlE5MGdoZUpFVXIvdG1YU0dR?=
 =?utf-8?B?bFMvOHd4YUZwalhveXNLbmg0NXBEaWVSU0Z0NTAzckpqeDNQVGxNUWF5cXM2?=
 =?utf-8?B?emx6OTNEVDc0c0tmRDBhYU9aMWJsL3FYd1FnOWFleFdpa2ZTU2tDT2QzbWpp?=
 =?utf-8?B?Mnk4TTRDWFhrUUtKZ3I0M3dKZHdnaEpkckcrSnhYL0w5WFcyQm45MlUzR2Y5?=
 =?utf-8?B?S2ZOdnJJWDFqVFhGTit0alhISE5rUE40YVhhdW1hRHRXNDN3MHZPQkNNZmdH?=
 =?utf-8?B?eHprM1hTSUsySHpPZURaTm1jbWNXQ25Ld3p3c1JxNDNkQWVzRVFZY0xnSUJG?=
 =?utf-8?B?MTczM1hDRHBPdUpHRjFyMURGV01TSk8vb21hTmNudStOMGFzcGNtSlIwajBE?=
 =?utf-8?B?cmpYcU5rM2FzV1lRM3JBQ2o5VEVSeVp2Zlp4L3hqb2hHcWJkamJBRkllLzIz?=
 =?utf-8?B?SWsxMFdhd0sxMHU3MllXdVhYazkwZWVVdU1RcHFpanZSSkNFMkN3K2ZwWW0r?=
 =?utf-8?B?b2prTEZRMFd1c2hJL2pVLzB5MDJubHNOdzZtUElyQXUwblpJbmZVTVZkZUF4?=
 =?utf-8?B?cTl5bjgrUVdWR3k0SjFFVjFwVWRZbklYcThXU2VjTU9EL0FFYURwaGhLWCto?=
 =?utf-8?B?dTF5bkYvWVVtZ2c1S2d3cHBDU084aXBPZGRwRE5zTmNCbms3a0haZzd0QUQ1?=
 =?utf-8?B?QUxGSG1UZDdKRE1JMURSNzRRbWgzS1RSUUx2OWR6VVAzRldRRmZ2T0Nuc0d4?=
 =?utf-8?B?aVhJcTJidzB2RE9QNlJ6S2VDbmV3cS9YNldZU1c5czFTQjFNTzRwZGNWOTds?=
 =?utf-8?B?TzhkVXA5ZkpQTGZ3cm5NeWYrVXFkamliNFNFWTlZQnhoNW1EQU9qUXpKMXM0?=
 =?utf-8?B?TkpXWjAvUjB5aGNhYXpVaUFtaFBTMVJ6TERIdkZ0Q3BZWXBxbmhDcC9TV3hs?=
 =?utf-8?B?Zm1SRlBOek1KWHM0RnloenQ2cGV2WUEzV1NwL2VhUjBobUFrdFdtMExOVjl1?=
 =?utf-8?B?VFgxOFdpTEVmKzhLQXdmS3FORS93aVkrNFRCVkFad0R5dEhWZWR1N3poWHFp?=
 =?utf-8?B?RUFxRCtQMjh6a2hLQ3F1R2ZRd01qR1hPSDEvc1VSQUVjaTJnVCs0RFY3QVBX?=
 =?utf-8?B?U3lYU0tvUGRWUjNEN1UxOXprNjBFUHpMRW85Zml0WTU3UG1SekJzN2RoQ0c3?=
 =?utf-8?B?cUduWDhQU2ZWMXNBRkVaanBvTTdQRFB6MzlYWFoxNE5udU8xMGNRQzVtVVpL?=
 =?utf-8?B?ajN2dWttS251bWJ1aTdUclg2cmUxeGpEclF1Qk5aYW8rdGFwV1RDbklMUXdT?=
 =?utf-8?B?d1dRYXpVM1Nlc1BTYmQ5c1FkZEhzS2xkb2JwOENVTk45OUNMZjI5M2JuMmJU?=
 =?utf-8?B?TFpoVDM5Qmp2aDgyL0ZCUldjaUt5T3dhTSsvdHdKaDZuWG54RTYvSkRjaGtJ?=
 =?utf-8?B?SW92K3BnVmc1THNBQXM5cnpmaWNaOUVxMDNtekRkWitJNTNOSkhheWF0Nzha?=
 =?utf-8?B?WVdpYTBhS056ZDIwQkI1Q25lb1B5ai9BOG1SemZPZk1waVF1QWI4UVNZcERm?=
 =?utf-8?B?SVMrRUdWM1pvQnNTbm5TN2ZjZWlWczRaYmxUazgxTTZTdXR5dFdPYm1SMjR1?=
 =?utf-8?B?L1ZXUEc3Tm5aY1ZxZHhDVDlKTUYyRmlLU1NHcG1MNjg3ZkpzWUtRY1krRjlG?=
 =?utf-8?B?UTVGTHNjQVNXelJmUyt0OS81c2pDeVZTOEc3eDBHR1FnVkFtQUFPamVudHVr?=
 =?utf-8?B?N0FBOFhVR2xTVWF3QmpTcGRvdFZJSTE5TDlVTnBhWXorZFc2M0NoYUlxdk9w?=
 =?utf-8?B?Umc0S3kvbzhxYlhqaEw1L3F5b0dBcFkvUURvbjlCWnVvU2ZZUHVKbkRBeFFG?=
 =?utf-8?B?cVU4MFlwc2U5d0ZrQSsySkxhenRmUEUwcXdqd1hvTGxuMlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkhaNDBmbVgwTVJQTS9oS0dZZWhLaCtocjhYMkNnWFVQNUtpMHpoQkF4Vml2?=
 =?utf-8?B?VnA2YUZQbDlzTDhpZG5rYU5DL3B6UDJMOUlJQVVKV25qb3k0eTUzQnVOdGJY?=
 =?utf-8?B?aUpKaGdOa2dNWXFXVHNsTDZrazQzUnRhTEhoUW5HbVFPQmZRMDNaSzl4Uk5P?=
 =?utf-8?B?ajR2WStGT0tEV1NBUXZpQ2NFczlma3ZndmZmN0JiRWg0YThTckthYzV6L3dY?=
 =?utf-8?B?am5zQzhvN1VnejNVN1hwNytvaWJoc2h1ZC9FWklhYUpVNzhYZEh2TEMrN2g2?=
 =?utf-8?B?SitXUW0xY3BucUtYcHV2aExmYlVrNFk0M2VVUktadk1NM0Q3M01wdkpxNzJN?=
 =?utf-8?B?U3hCd09EWWxxV0Z0TXBjNUpZR21aUkVJbnVvWVhPZzVMUndSNHVkenZnU3No?=
 =?utf-8?B?TEszTlJpTkF1VTZBOERySFBoSEpodHd3bmRoSU82bnA3YnlQK1Q3TnpuQ05l?=
 =?utf-8?B?REtleDkxdTltYnpPQXpKZ2FGbnp5QnlyNUlJZlpBK0pQWUp2dlBZZS9GOWxz?=
 =?utf-8?B?UUdMeDdIN09xbUNWaHRBZXBTV2dNcTYzVkRwL0I0VWQ0bDRGNC8rMFY1SjZ2?=
 =?utf-8?B?UkxtdkRUa1BWeUFieU82UFd2U3hhU3V0TnpMNlhWT0s2YXorZVQ0cjF2WFhD?=
 =?utf-8?B?eXpoMWxCU0toSkVyVzRiV28yQnZ6WDdSOTJNNU1sQlpBL2ltWWZSRGE0UnU2?=
 =?utf-8?B?bXo2aStvcUxCTmN5V0xSNVhlMmJNYVBlaFpQUnN4Zk1yWStnVEdYSlNDa0pI?=
 =?utf-8?B?K01GVnpSZWp6M1FIQWJLWUtHU3VaaGQrOXoyYVkremR4ZE9DQkpqVjB1WndC?=
 =?utf-8?B?VS9nSDlkQmlXbmtlQitYSE0xNkdlRDBsOGRMVXp5aGJpbmY4dVpndU0zbzFq?=
 =?utf-8?B?ZlJXdTdnWUwwRjMvMExJS0tYWlhIZ2RKbm5ra2dUVUJ2NDJMYWx5TFZ1ZU1Q?=
 =?utf-8?B?STJiMDJPeUxLTzFTd3ZCR21uL2RmQ0U5am84OGhPSGtVNGp0ZkJyYksyR3lx?=
 =?utf-8?B?MzVxeW9La09rc1BLcHhva012clFCQXNpTmpPU2gwV1hsRUVCWnB6SEp4cTQr?=
 =?utf-8?B?Q3lTZ3dWV1ovR3laZllYVDg1Y3BDY3pVWFhUTndmeTFmcFJ0M2E3NURuaXpH?=
 =?utf-8?B?UG1BbXVNdG0vWE53M3Y3dVpWVzRjcXkyeFh1TlFmVW90ODU1YThtb24vZmVv?=
 =?utf-8?B?WVg5cy9weS93VU1ibjl4UXVyeU4wMEg1MzVYUklxdi9uTlM0YmswMWo5L3Ry?=
 =?utf-8?B?OVlEUERCQUluQ3JBeC9HOHhGUDZkQ0JhN25McTlLa3J3dk5MT1JDT0Y1OElH?=
 =?utf-8?B?anpzdFdRWER5SWFpU1NOY09oZTRZK0QxOC81ZHRsKzB5dkZVbm1Qem9iK1Zh?=
 =?utf-8?B?TkdCcUpUc2xGUkFocFJFV0Vxb3IvcUtxZFBMSU5Jb3JoUk1iWkViV2NSWnIv?=
 =?utf-8?B?MDZndHpNdzZoUVVwUWFLRlh5NGY1SjRGbFgyY1QraXUwN3FsTjJmM3ZwRVAw?=
 =?utf-8?B?VHFGN0ZFN2g1NUkwSHNDb1VkN3NsTFlueGVXQzZZTVg5L3JaOGN3d3kzdytu?=
 =?utf-8?B?blVhellVdTQ3TnQ0UVZnWHZlNHVYeml5cUQvRkkvZlFVUHJsMFdveVJkMEh0?=
 =?utf-8?B?d3NleldJa0JNMXdqSnFTc0Y1S0ZCOHdGSXJMcEExRmhKNFBwQ1NWRUlBSWlY?=
 =?utf-8?B?Tlh5Y1JoWTY5cGpDOC9pVlBCbXhDOVRYVDVUYnkvMGErZ3hDZjl5alpUck1M?=
 =?utf-8?B?RGJDRldWb0hORWZlc3QvSUQ2SFBwOVlua2docXI2V21Ta2hza214OFdsOVVU?=
 =?utf-8?B?MFBsT1RoNnJUdHlHd3FXSDB0V1BrOGgxdjdFZFFUaWZOWTIxWGs3YzFnTGM4?=
 =?utf-8?B?V0E5akVXcXhaVWVrR1d6MlpXVkNOM3oySmYrNEZIVncwWlhhOEVTaUJEUmxl?=
 =?utf-8?B?azlJWmNDT1ZzWXAybmdlWTdwQzVPK0FWK21VQ2FRbW4zUzNwU2cxQVFMSUx0?=
 =?utf-8?B?SnVWRXJYU0lnV0NrbSs4MDllL2o3bjBnb29iUElWN25zVDJ4ak14U1Iyek0r?=
 =?utf-8?B?L3F3TndsUk1YY0VsMWdUTTVwbUVhMXM1cmtWNTBoZ1Y3OFV2VytwR3NxTjlv?=
 =?utf-8?B?R2NQWkk3aWxuUmNiMlRHTWMrRUYwZFNtRG9MK2lOTUYzL2lNdktHWmowaVBQ?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f25ba06b-1056-4a64-f50c-08ddb4a29c96
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:14:26.3662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHVPacgUcV4f36uo8ofW+IGgH54Ae42OUl/ACueyhLl6njdKSNqcHv+bEsFaAMD2zQnpwfvRhVh3gq+asNjF429wF5LxHwEPitS0PcjRdc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9681
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

Hi Andrew,

On 6/26/25 12:49 PM, Andrew Goodbody wrote:
> ret maybe used uninitialised in some cases so instead
> initialise it first to prevent this.
> 

I don't believe that's true, can you tell us which code path(s) could 
trigger this because I didn't find one the 2min I spent reading the code.

> This issue was found by Smatch.
> 

Seems like a false positive to me?

Cheers,
Quentin
