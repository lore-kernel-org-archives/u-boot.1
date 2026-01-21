Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50096C44526
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 13:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C027D8341A;
	Wed, 21 Jan 2026 14:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V9qNClW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411B383946; Wed, 21 Jan 2026 14:06:51 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A5183015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 14:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nu2dlJW7kIfppqpT9qN5U6FjKZEjZNSKLF/1ASuv+jyOEiyw5wydXH7GVPqqsRQAr7KoDNuAjMr9vkFE2ud5toeKBh/vRmCO1zUcQl5ocScVdNlgqsIT4vzHKUSriHnqqheDKOCUBm/3qi6cfVCR+Pc67pWJOQRqE8LHjOZQd9flGqRdk4IR9rmZHD4hib9eX2JeWsj7Nd3n8lpvY/VWBG6ICo+j/v0u/PveM0MK40cxXh3IwP3qLQ3QbG7KlBVHq0V5F8gyJhTSETxqyZvzAfkzZ7hNQLV2qTex2kFVXfxtOL3JX9s4WIf9WeNvPvJDDlA+kOglUBo6KI1okftTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF1/mqzywtztnyY6cw/G6eBk2giipQ1TP0PfR96r7eI=;
 b=J25gk8zLCLJ748JMCyLgaIrpA4IzNxwHJlLMfkLtj8qpG9JTjxujr7vyc7bzrW5oucmFBIHQsOxgQ7xeo7rIQ0EHnXanR0F3aKu2cau8gNjD5UF82vIaWZ/IOqDkS8kWqJS2Jh37WoJs9KLVEop0+6Z4tfZKiL6sYxHvtPMT8srCUe8kiHsquhGWh+XQ/Fh0Ta0IYNHrYnGXNvIgRaft+SWn2wDUEoBhXiNeQF2lh0mt08IpArgSDN8tV38+pXeXyjIecgdouUuqovtPwlYX+snuuadyS+JWO3FTUyQ0tm0Y4wQPSuq1tQzzmLEn+zCYZGJohKY3BQ6OUSH4m0mXkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF1/mqzywtztnyY6cw/G6eBk2giipQ1TP0PfR96r7eI=;
 b=V9qNClW4Rl8Vbg1/hlgpTXftIWiJ5eWfF6LzmKojmXkOTxTXXvcSwtzqm5Ordz4AxQco6U79CSSWQLrwFK4R2OK6oWy6MiZ+1kqT0/o1dPxb8gAMoUrI3p8Dp4HsNiQpg4zvFI+VPW/rVW1Oloq1ec0aOUuO0cRwIWgBAXBo7wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 13:06:44 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 13:06:44 +0000
Message-ID: <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
Date: Wed, 21 Jan 2026 14:06:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.glass@canonical.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de> <aXDJ4PrbO2eL63B-@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aXDJ4PrbO2eL63B-@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0251.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db80496-2bf1-4189-c5ba-08de58eded43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVp6YnZDMG4xb05jSUQ4WXRjbm5nS3JTR1pTYzVaYW9vdGgwTDF5ckdQdHhw?=
 =?utf-8?B?d3pvZU9EQnozb2tGQ1luTWd3R0JjSUowNmJ3SDFsa0tWWWVMUk5VV3pNZFdh?=
 =?utf-8?B?M3ZKZ0RxUGNrYW1oMHA4RURHSDM1VVdnTzdGbmswMTVRNUREb1hZTTF3akY4?=
 =?utf-8?B?blIrU3U3R09DMVFyclloRWFzcDYzYWtvbnU3L05QUXE5U25JT2tWOWQ5Y3N4?=
 =?utf-8?B?c0I3aDlKb09ja2RDSXZzc3dOR2xlQWYrSDdtanMydWpXU3M5STExYngrY21K?=
 =?utf-8?B?bVA3bmFiNWVXM212NW1XNnZjUGtmL2crMSttU3VXbmdkWGs5Y2xzdUJCMXdu?=
 =?utf-8?B?d29TMmdSZ0lQNVpqbFRsRkhEZlE5Wi9Gc2ZiNEs2SWN3K0d4djlNaHNaVzBz?=
 =?utf-8?B?NTcwb3Jqa0FCTmtGSkpPeEZnaWJUNTFaUlZqdDZvVE02K3FuZzVoeHdQb0JB?=
 =?utf-8?B?NWR3VzdSK25WeFN4WFIxSnd6LzJLcWZVY3dyVldwU3pCTjBYR0ZkVkVOdU1G?=
 =?utf-8?B?UWZQM1JSMUtEZ3Q2WTVyNXVwdC8zMDluaXZKeE5zWEJ4VVB6WmltSWFhOWJY?=
 =?utf-8?B?L1JpOVJ3czY5WVF2UHZocy9FYjhvWTlKdUhaNnJwWERic215SU8vb2M0OEx3?=
 =?utf-8?B?c3F4YWwvN3hQUjNLVlVUL3U3dkFydzR2VHdqaHZsa2FRQzdxUE44QnI4Tzl1?=
 =?utf-8?B?cHc2S1BKK1FwNWNsemR6NUhnQkx3K24rZFRqdmV4alh3SFRQeVN4UWl6cXcr?=
 =?utf-8?B?TVQ1NWdxUGw1MnZyZC9MZ0M0dzRqZmRPVWtSZnpCNWlOdHFzN09VVTFFYzdh?=
 =?utf-8?B?VjBSaW90SXBpcExIWks0RVRGOEdKTjNOTXRNR0FubmFPM01lOEVyOHdQT08r?=
 =?utf-8?B?MWlyYk8zUkYzamt5azJ3S1lOWTk0Z1R6OWxYSytSZUxPdkFtdkw1cGNEdkRL?=
 =?utf-8?B?OU5LZElTNGJFd0R6L2ROV2J1M1Vtei9KMjhJMVpDeHpOQm9WK2FjL3BEU0lU?=
 =?utf-8?B?b1R0R2FyWGg2dVYrb00vSU9odkRoNmJsV0VwbkxPNUcrNk1nNVZPUndVNGg4?=
 =?utf-8?B?T2ppZ0N4MGNHaEk1WGl0TmhzdmJOQ2NHeFpMWVFtWmhZUWErem55N1hZVTRF?=
 =?utf-8?B?RFI1SEdYOTJYK0JXTmNHZG1HUk9IbHpsNzliQ1pIOXU5WkRSOWtQcTBra3R0?=
 =?utf-8?B?bHJRQ1UwWHhwNVlUTzZ6N09jVXBIUkltN0R4cjV3ZkRvcCtCTHFZNTh5WnMz?=
 =?utf-8?B?U3pRWU1BVzBiejFwK1VjeUVweUVqTFpBTWpPdG8vMlVyeTRlUXhFUGRnTTha?=
 =?utf-8?B?bG1kU3J2bEw3QmtJdXlYaFJDRTBYR0xjT2ZqUVd1UThWaHhrUUJ4aVpLazBz?=
 =?utf-8?B?UzFSTEFVNEg5cXhpZFNFWHZiWmJ6cW9INnMySmVydmZGa3VZZkl4Nkl6Q1Ja?=
 =?utf-8?B?bDFDb1dwUzAva1Z5MG5OUmxlcTM4eE9jYzdCRGhxQWxRWlN6ZnZPekUxRkFX?=
 =?utf-8?B?eUViSXBHeUNaV28xaytUb2VxQkRrcE4vMm9KUng5dCs5TzBvY2Jyd0lPcWI3?=
 =?utf-8?B?cXpUREtJWXJnM3pHTzNpOWhFV2pUMTErU1pLTDNMNXZxdC9jK2FPY1JKMDQr?=
 =?utf-8?B?dmltTTVsUmxmYzY1enlSOTlBRm9RQUVMNnJJdEx2WWE3WlY2ejF6R3g0Y0tK?=
 =?utf-8?B?QnlQSklHZHdzZUZmY3ByQ0Y5M0hXTmFQRitaRm85bkF4SFZrbENCQUtCNUZr?=
 =?utf-8?B?U1NydW1XQTRva0dEQnRLa0dkRHRJV3k3V2pBRmhyNHRhazJYQVdiR01PVGky?=
 =?utf-8?B?M1o4cUhldjl0bWRVb0o0OGRrTExISzNuYXlLdTNaQXpsbFJSOFAzekZqR1pE?=
 =?utf-8?B?c1lzMmRmakw5Ylc3ZTE0dFJqSTZQVEFvQm1iNjVsYVlSbFdNV0huSE83Vk16?=
 =?utf-8?B?WXh1M0Z0U3ZYZlRGcksvemNTcUlYWVo1ZEdxc1A2L1UvMWorcVpybHNRTXJC?=
 =?utf-8?B?eDRoZWpWTWl3UXduTzUvc042cWFuTG9INWkydkVuMnJVM2dzVlE1MzhMNVE1?=
 =?utf-8?B?NGZpU2FrZ0puekxHNGlHQ0FlVW92MUt5VDArVkt3RXZIRUdETURVQzR6bU4r?=
 =?utf-8?Q?Zm00=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VyMFlWNUVLTVAxZ0JjNnc3TVZNa1dQMXUxczM4VFRtVi9ad3F0bzMzamR0?=
 =?utf-8?B?My9saUR6NktSVWJnM0JxUjExa0NmM3NmMkhGN2hLKytHNTR6Zzhkcmc4MnhB?=
 =?utf-8?B?cjRyTG4xTnlWQm90UXZXM0tVOEFIU1lJVC9nVGEyMWNiWkxwdUNNdkl5cXpO?=
 =?utf-8?B?WGxYanFmbEtPUFd5Y0tkNnNLaCt1eSswZEhiVXV3cGE3eWZwMlhDWnBETm1h?=
 =?utf-8?B?MHU4MXpvTVBEN1Brb2NHSDcxcXFIREM5VWlWQ2ZlYzNvTHY5c0w1NTVBOTY0?=
 =?utf-8?B?TEpISXRoczlrKzdmdXFYbEZ4amRtVHc2eUhaZXcxMGZpcGRjMlJpQ0d4ZUdu?=
 =?utf-8?B?a3NyZis5YUJFb2RmR2xia2xwWFJaNjRleVA0RzRhOE4vYzJDa3VkMXFkNHVP?=
 =?utf-8?B?bWw3V0gzTE13WTRGdmc4STdjOVBzRGFoZUFJUThmZUVkdjZXdk4xVWdEK0ZM?=
 =?utf-8?B?ZTA0VzV2V2hiWlhHWXJBMTRqYTFhRGNWTGd3WnJ5VWNHdVdxWnFXZ3lJQlg2?=
 =?utf-8?B?UG9nRHNhT2ZMbW0yMldnWjdzdWFtV0huNGtwNnJxc2xBVjNSQm5ZY0Nqc0Vn?=
 =?utf-8?B?WTB6dnRIcVVIa1RiTmlYczNyQTVQQ25nQ1BEZ1JkbUpQUTEvam00cEdvd3gy?=
 =?utf-8?B?VWhUNWZOcFBZWDRhU0h0Ync0OEw0aDZRcjBveFNIbG42VHZWczZHL0pwcWtX?=
 =?utf-8?B?SVhTelZJSEJISUtrMnBzOUxhM1FWcXdqOXpLVEY3QnltWWc2b3RGV3ZJRXpP?=
 =?utf-8?B?L0JYT2h3SmVCd1ZvbFREM3h3d2ZOZTlseXlUV1Z5Y2RTd08rNGFlNllxQkIx?=
 =?utf-8?B?MFdGM1FKN2VXYW9pbnhyQWtHSWdtR1ZPZHpScnZpc2NYdmI3WkdPbDFDQlR3?=
 =?utf-8?B?V0RUdXJGdXMxajUwOFpRM2Ivb2QvNUk0VUFYUXQrMHdObXZnQXVidHpYbUV4?=
 =?utf-8?B?NVV0Q016b2Q4OUd6c0MyM09zNzFUZ2EyVzBCZmxwclk5R2xsY2Y2VktMVTVa?=
 =?utf-8?B?dU9PS296enp6SEJYK211Z3RzcDBWdElvdVF4bm1seHpWaTYvZjdtRENCcEtz?=
 =?utf-8?B?OG5vNXNPbWkrbUlZK1dBb0Z5eXVUWlp0UkdCamhEMlVZYlFIMlVaU25DRDYw?=
 =?utf-8?B?ZUZYeDNuS3Evbzd1SG5xeWo2WU9TamlIM09qVnpNd0Fmdmpmb2xlYmNkUVZB?=
 =?utf-8?B?Ry9tVnU0a3VoUk5OV2FNQjRpNzdFWXFrNmJiMGVSUzBYQXpVVmZzdVI0aUtp?=
 =?utf-8?B?dXZYZ0xCcS9WZ0ZJMHFFcHNOMlpjeUpqZ0FxWFYxNTFZWFc2akVFMkZNYmF1?=
 =?utf-8?B?M3pLRnVLWGhZcm9Va0pmYXY2WDJGdms5TUJtVEhUM2ZjSWEwdlZoeEsvUVZo?=
 =?utf-8?B?SlAySVJwVmwyTmZwOENoelUvUUdkbStsbmNSU3VkdDFnbjB3MldZSGtrYUVy?=
 =?utf-8?B?Vm5jMHg3VlJvbS9PNjVzUDhxWWQwbTlCVmNTdXg2cExEMFBKMkV1bHhOL0xt?=
 =?utf-8?B?L3R5c09VN1VaNU9jcUlmMk0rZlpPakRraUxOaHRWZVVmVm9HNnpvamw2MENJ?=
 =?utf-8?B?UUJKaWpyZm4yUzFRMkl3QlQ3aFN1TmU4RXRvdU03dncrVE9vS1Z3eXd0WCtY?=
 =?utf-8?B?ZHhBaStNYjdLaENxTDcvdXRTUkMvNnM1MC9RczNEUkFsclorY3pkVERPV2lx?=
 =?utf-8?B?dGRTYzVoZVZHRWVPMVRzbEJPZCsvdTlQTGcrZlBrRU5JZWhyYmJCMDRpYmJU?=
 =?utf-8?B?NjNhbmVzSDBxREJVNVJjcldKZmMvS0FCUllZR2VQdUVab3hsM1haNDNaT1pU?=
 =?utf-8?B?bkFxajBBc1lpZzBMSm1sL09CaGtNRW1MNjFPU0pVU1NsbTFlWGhOQ3duekZS?=
 =?utf-8?B?OXNmR1B0aHFBcmt2MDd3b2F6RjRwOVA3RG0vWGkzWGlGeFNuNm95S2srdFNH?=
 =?utf-8?B?amEvMEJEWUsrVTIyOHN5dFNUS1VXdVVNUkpEc24zMGw0UEVaRWtHVUFLNDNu?=
 =?utf-8?B?WWFkSVNzR21DMHFUTW9lUHRxcmIzZFE4bDI1ck5DZFBlcDRjbHpYOFdlSkNs?=
 =?utf-8?B?VzFmbmkrK2FRV2VQUFM4OE04WW5EZ2lSZzJoMWo5NTRWeFowQTRDZ0tmOURB?=
 =?utf-8?B?MmJWODJtQkFyaE92UHptWFNZZmtCZDJjaXlOZXB2OWVYdEsxeVJPSDQ2dEI3?=
 =?utf-8?B?RVJHYjRIdHVUN1AwVVZhaVFVSDQzRy9lVFFHdVpHVmJtaFRzUkZ6NkFOS3dX?=
 =?utf-8?B?dXVYVmFPTE9rZjcxbWcrN2RIVUQ3YnAyZzNBNkVmRE9jMGZLT0pGQnN3bWNw?=
 =?utf-8?B?RktjUGxvd3JSeDlWTS9mTmFhY0YyelFDRm42cGgySUxFM3VQTTBLRzVXRi90?=
 =?utf-8?Q?6Ougwa7PEfoZRh3bkYqiqRdpgZOySSucN9ySn?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db80496-2bf1-4189-c5ba-08de58eded43
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 13:06:44.5434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9NCoLPbKBP7uvdOxk3GZViwSHQIZAIf89YvrgMbx3hVFYPPMLqtoWi092sNOXy8QEkkBt5N4mWpfKD35ldtwcVL0lLs7Q5xb8mA9KRp6iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918
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

Hi Wojciech,

On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
> Hello Quentin,
>> Hi Wojciech,
>>
>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
[...]
>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
>>
>> This is wrong, you'll be messing up with the environment of all tests being
>> run in the same thread. You must use the "with
>> unittest.mock.patch.dict('os.environ'," implementation I used in
>> testFitSignPKCS11Simple.
> 
> Well, I have done so in my V2 but has been commented as wrong by the
> first reviewer. I will restore it back.
> 

Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't 
how we should be doing it.

This is likely fine on its own because there's only one test that is now 
modifying os.environ's SOFTHSM2_CONF but this will be a problem next 
time a test wants to modify it. I actually hit this issue when 
developing the PKCS11 fit signing tests as I had two tests modifying the 
environment.

The only trace of it left is the changelog in 
https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/

"""
- fixed issues due to modification of the environment in tests failing
   other tests, by using unittest.mock.patch.dict() on os.environ as
   suggested by the unittest.mock doc,
"""

and you can check the diff between the v2 and v3 to check I used to 
modify the env directly but now mock it instead.

Sorry for not catching this, should have answered to Simon in the v2.

[...]

>>> +                      '-CAfile', cert_file, '-no_check_time')
>>> +        except ValueError:
>>> +            self.assertIn('UEFI Capsule verification failed')
>>> +
>>
>> I don't think this is valid.
>> https://docs.python.org/3/library/unittest.html#unittest.TestCase.assertIn
>> states you need 2 (or three) argumentis, only one's provided here.
>>
>> I'm assuming we don't need the try..except since the raised Exception will
>> just stop (and fail) the execution of the test but continue with the other
>> ones? Can you check (locally) by purposefully using the wrong key for
>> example?
> 
> It has worked (failed) with try/except. I had to add no time check as the certificate
Thanks for the heads up, @Simon any chance you can update the 
certificate so we're fine for the decades to come?

Cheers,
Quentin
