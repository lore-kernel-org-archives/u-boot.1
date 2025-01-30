Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B876C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 14:16:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6D980EC1;
	Thu, 30 Jan 2025 15:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BqV5dlvr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EECB81F69; Thu, 30 Jan 2025 15:16:56 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D234680E9A
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 15:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqBjRH0XtfSU1MN9Hi5nuPvV/HcnH5DEl/nC5ylW9BUHsREapQ9uoZNUJFsFNocNiOqW4L3N3KJbg0oZKuBqYk8oy8ERfU5ioPULL3Ug0YRIoNVn9LNcWuyscR2eFa7KFB4SxIg2Xp4lRFsV1sLOJ++kAyFqb66OTwqRp7E6/ukwVoManHW7kLDVmwwQeFIXvOBZYSZkTxuBmKHnjLR2tAG/YhGTACFPDNohGAyMGudWYEZJs7pSu121IZ42eadbgvkn9DUm9KYElqSQSapkel/TrvZNK7CYNGsWXC8bg0k88qe0fkeUnf62ElLhG6pbhHmR2mDeLzk/wRDDOkN64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Stsn42xOWiOdFbZCb/xWUIFGnzR35VFFWOxWg2Jku9Q=;
 b=S+GVM4JVnorNcIgTS1WArRVjq/ZsqQfJscgKqAmk78Qlh7hgIOS9hrOWjO38oxGHScpY+1S0I0/NJMj5CZNzOnUx2T5sosgyyOIdgKCPjZ6sJ+kURnixMS6TnSIMT7Q0b20nN88y2SSy5CHWfZO3qUzjrPibe6yBaPHrFrquP/hK/TllQb1ZtBbHxQmo29fp7Z2ftYIEw9p1WZ3jvMU1E6LsW3LrgiW7Hhbjl+h86lnxJ0SNcNfYolHF/+AIVRMsEZBOIMPnudNbrkak7bLZWQO738MgbzmgGCpCFbBXtGPqhY+Z1cVkyrG7B+ttGr8Kx9guEnkzKg2ot0ErjEo0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stsn42xOWiOdFbZCb/xWUIFGnzR35VFFWOxWg2Jku9Q=;
 b=BqV5dlvrTRTIh8t9GK1z5UPJujYl6pBNQEeav4SVUjIz7wUMI6FOoggVtw5Ttjz3NFjFv5I1cOQ89eR8RAgv31KerphCcqtIDyvojaUjLY6MImAb79ngzsuTqMEWzGURznazBlN5NdoU/GDl9sf/zb7WiXGgVOk+ojaLez4Sjhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7730.eurprd04.prod.outlook.com (2603:10a6:20b:242::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 14:16:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 14:16:51 +0000
Message-ID: <70588c5a-fca5-4600-a229-f30b8d97ac6b@cherry.de>
Date: Thu, 30 Jan 2025 15:16:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
 <0ca2ce57-8efe-4de2-8f83-71623867e51f@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0ca2ce57-8efe-4de2-8f83-71623867e51f@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d44880-8be6-40e7-2043-08dd4138bddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3Q1d2Roa3FvdWpSeSt3SnBOREJ5MFRWSjE1ek1TRG9JQjluRi8zUFc1M2VK?=
 =?utf-8?B?UnpCbjJ3ZFQ5cnpRWW16ZFprejNVUGpHSjlydGZxWWNwcGh6YzROaGtwWnIv?=
 =?utf-8?B?SDhLd25sNmFmTmJjbTA4d0FKRENxdk0yWUphNjVMN1N5cld1NlJNL2M0NkVw?=
 =?utf-8?B?cUV4QkYvU1VFN1lTSzRTQjFDdkdGWmh6RVdXQjdlRWFpcWVjYzhxdjRyUno2?=
 =?utf-8?B?K0JXY29ocW9Yc1F2R2xWbitjR1czaThpS0lidlZucHhjY2o2Q0JsN3BtMzRr?=
 =?utf-8?B?bTNhdmpxZ1QvS3p1Z2hKcmtWRDBURzRBVFY4ZHhWTHM2WElYQ0RuR3FpOXhq?=
 =?utf-8?B?T2w2ZmVjdmRNNWpmWGNJaTg5N2QzellDSUVsQWsybnpQbnQrem1ySnhkZThv?=
 =?utf-8?B?TmZCVFJVUjZpWHQvUzFOYU9IdGVSNE1va1RqcWdyS28rTkQ4b0pyQ3JvMkRO?=
 =?utf-8?B?ODNOUmJFUHZuazQ1Nnl6cjlhbEx6VnBuNk02TkZ5T21hc0NpNG5jRmZpMnJq?=
 =?utf-8?B?MnFTaFl6akxLSHlZajV6Uy80MXcvNkNqMEF6UFlXWEZSVTJacFNQN05ielVI?=
 =?utf-8?B?blE5bjNaYzRtaUR6NnoxZlpJRFRRd2FxZ1gxV0pwZzU1LzBiMGlBM3IxbnRX?=
 =?utf-8?B?amhDYnRzSWhVLzVQQWlSTkFQdVJhWXdXa3kvclc4cXlBL1FFVlpoMkN1THNV?=
 =?utf-8?B?blBsbFdWZ3dKcm9ieWFGYTNOS2svSWNlTlRUZjYyeTdwb1FGWVN3My9ubWtU?=
 =?utf-8?B?SzJ0RFJIRDFKcWdzWjVmWnZBWE9KYlRIaGNsc1RpeEpTdkRVdG9POS9wMGxO?=
 =?utf-8?B?YStrVzZjT0dlRThBNktkOFpPb1ovb0JQTmJOUU1NSGo1NXh5THFOZjQ2cUtK?=
 =?utf-8?B?d25TU0hiQWV5RnFKRVNVU1g0MVhEMFNic0tOeHNUOU5lRmRqQ0pnUk5FaWVq?=
 =?utf-8?B?ODRGRDRtOWI3bkh6VFdaN0Z6RkJkZzJMMkxCNTh5OU15dmNBTDJFOFhCaGpO?=
 =?utf-8?B?WGQ5SGFvYjJtNUZUOExUYWM4aGpUc1lManhhT3NldXpOdFFaTndsdWNxTjJN?=
 =?utf-8?B?ZmNieGxmenFOczNMMlBMM1pIWmVjZURDSUdTc2ZqOVltTjZoZGdmUkNHRkRj?=
 =?utf-8?B?enNJZTZNWVNXT2dCK0ozL2NCUzFoa29PSTNQWExKZEdna3R5WFJKWDFxQnVX?=
 =?utf-8?B?T0h3MktGcnM1WTFkZWcxT1pKL0JocWh0Q1UvU05CV0xTUFh3QmFCNmFpTUU4?=
 =?utf-8?B?SWNJUXlIVTFOOUlYMndibjJERXI2WGFCQjJZYmVWdDJDSFNEcmlhb25nUWsy?=
 =?utf-8?B?cVRRT0RickwvbURvdnlKVHBxSUtYc0RsYkJHZk1td2pHZEVTNFRTNVpOSUsr?=
 =?utf-8?B?Q3VJYW1oWUhNNmhVWmEvUzc0K0JKSUZiL0FTektsN05rNlpSblRqTW5PUFB1?=
 =?utf-8?B?MFI0RnFNWUNvWTc5YjZQRkpzd3lFYi9sTEN3ZVBEYzZsT2dSTU4wdWE5bnc0?=
 =?utf-8?B?RnQrRmVYb3Y2M3FQWGhUSHBvOG5xV2hmRkJ2U3dKMGU0azhsS0EzL3g0bUVk?=
 =?utf-8?B?bi9CSjFDSUZuZ1VXOVZYcXl4ckxqWGNHWmRxR3FsVE5kSjM0KzJGSS9QZzF6?=
 =?utf-8?B?UU5DME1NbG01UlhSSVRaK203VDg3d3lpdnJvYnJGUmxWLzU0UmNSc0pRalh0?=
 =?utf-8?B?amNkUmpJWUtBZU1CTjdLTXdpYXBvTkRqQU5TTGtxNUUycXhHZzRjVnlGbVNN?=
 =?utf-8?B?MllhbFpJM082cG82emlBa0lWeng5dHV6MzFiWnVXanJjQXVtQ21QNTRTY2xF?=
 =?utf-8?B?YXZFcDNXVmpHV214dDc4dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEVYWUs4ZHRldlRpZXVQZnpRd29QZkZJL0xZeEp4RzBlVkVXeDBvaDVoR3V2?=
 =?utf-8?B?TWVSY0hhcElmOEl6c2VORWcyRFlnTzVTQ3djYzF0azd5VTA3Ym8xTjUzbjJE?=
 =?utf-8?B?OFJ3N2Z0Y0grd3ZkRUE1RHZTUW9aOUdqUGI0czJDcG82TjFCRHdhZmU1MHd2?=
 =?utf-8?B?TEk4MTFtdlRESHo1RVg0aVdRUmRoRy8yTVpwSERxSmxXdnRKMDFza0NQZ25t?=
 =?utf-8?B?c2F5ajhCdGFSK3lwSXcyOE43eVVHeW5TZkFEZzFQbllJcTdreC9UN0JYMjFD?=
 =?utf-8?B?TkRLR0NXR3BrdFBZTzlaMyt0djBVaGt2T3pQaE5TUVEzS3p3RWNNTGZkZVcx?=
 =?utf-8?B?RUJjemFaNW85Vk5seE9LdGozK3R3T1h6V0NiNXFCNTZUNVdFK3NGM1laa09Y?=
 =?utf-8?B?RFBIcitoR0RKRmRFbzY4TFBnb0lnTHg1Y053dFQ5alJDRVBZN3FTcmdwZXdt?=
 =?utf-8?B?U201TlRQTWZtUVo4UldPNU1BWFJsUitwTmFWVG0ySzZqTDB5cW50OXQ2USs3?=
 =?utf-8?B?Y0o2a3NxdmpqeDZpL00yZVN5NURMZVc3MmttSWVPUXRlaWd1QzhxRHV5OHhL?=
 =?utf-8?B?NTVYcXRHL3lEdEU3bHowWDV1aGhaQ0gzZDBKZ2E4cGhpbm9hNmhSWnIwbklp?=
 =?utf-8?B?Uk5nRkNQL0l5VFV6RWlwVUg4a1ZyZTdjeUx2b0lwaENISkJqR2xJTWsrWHY4?=
 =?utf-8?B?aitWQ28rLzBkbStDSW9DOGVwcFBMTHlhRm9zWmRnSHdVOG9WYWp0L3lzZ2Ni?=
 =?utf-8?B?VUJ0ZEVMTXliL0FwdTVtaUxvK0ljWG9wVVVQMjVmbmdXYVBsRHYwZWgrSnVk?=
 =?utf-8?B?VEVPRXRhMGVHUDM3RWVjK2lIZnVxaE96WG1zM01mcXhQZjRjNkY5V29TUm1p?=
 =?utf-8?B?Qi9tb1B0R2RmRE1WKzhFS2x6SEt2M3NqQ3BaOXNROE15NGtnZzNGOG5oMkNU?=
 =?utf-8?B?Nis4elZTNnYzcTd5bm00d21TQno1VUE1eEhPakg4WEV4WnI3aHg4MXpaY25S?=
 =?utf-8?B?cWVLN2RnTTRUbXBIMkl3ZHc1MTZuaGd6WllsdEZmc242R2IzTTJqbUxnY0Z0?=
 =?utf-8?B?eDlDM1V5UVdETkdBSmJzSVpvWVBubUZ0RG9GWHFOakp1VXZuamQ4TEFsc0JP?=
 =?utf-8?B?aU44R3RlZUVodU04ZlMxV0xhNHBReHJXSWg1MS8zY3ZsT2Z4eGVsSzYvMjJM?=
 =?utf-8?B?V1pDNVRZcU9USzY3ajUvN3NzUHpyYkgzZUQ1YndsUEJ3ZjRlUTJ2UzlrWFhY?=
 =?utf-8?B?Z25CUC9hUGJZWEprWTJHbFNITzNvU2RybE0weGZnaU9NZHJTaEJBeVJFclVV?=
 =?utf-8?B?akpXQk5UdGdlVlNYaTFPKzBGVlRjcDRuR0xqbW9JSlF6WkdTMXB5TWdiMHBT?=
 =?utf-8?B?UWZCZTRqUmNLcjhWV29uOXBTVjZiMFF2VW4yd1BUOEk2S0pvdGdlV3Y2cWVB?=
 =?utf-8?B?UzlOd2UyYi9uWlJwbyt1Sng4bSt6YW5GeFpIOGxzdTREdTdRT3RFY2VxZmhW?=
 =?utf-8?B?eHZoMkpwaklvb2JsV3haYlFLQmFpR2E4YlpWamZFT3lkMHlXcmNVR3AxWXRz?=
 =?utf-8?B?RFJPR3c4R2FUQlJOcHN2UStYRWZqWSsraTk2eFJSeEpoZm5BS0VHVW9EKzVC?=
 =?utf-8?B?WGVkbWlsbzZXZUNlb1F1Nm5QN0RQWm1kOWdFYkloZTdsMG0zL3dRQVMvdUpH?=
 =?utf-8?B?QnBzSkhVRytVWkUvdXN6d3lCZnJSQTJ5Z2o2cVZQMDVyNFNJZDRpdFBub2pY?=
 =?utf-8?B?UjYrajR4Q1RDa3A5VGc4ZVVuWWh4eGlnMTFnWmhZR2FCa0YvYzA4VThKT24x?=
 =?utf-8?B?MUg0dzYyMFh6Rlo0QUFiWnVWM08rZVg2SldVWnh4eklLS1lpOElUK21vLzdW?=
 =?utf-8?B?UE9PVzhoOUg1WUJSdnhINERMMnNvenl4UkJHSldDUkd4NDNEK3hXb1hRTWUr?=
 =?utf-8?B?bi9xRTVqSmVLTkdHMUp6L20xek1aNWdHandWVHBpN2VhaG8velBoQXh4OU8z?=
 =?utf-8?B?TUVHYVpvYm8zS3A5RDR6bzhiVlNNeEVvUlNub2lwNDEvazgvM3lyLzlMRjJv?=
 =?utf-8?B?OEVpem4rR1JPV3BzdHBiWGZyZ2F0VU1PdWRvQlRHUmZ5WDVlelg1QlpESDU5?=
 =?utf-8?B?RnUrQkhKU1VWUmpzR2tHU3UzYVNWQ1g0WE5pUmg2bWNhSDBKT2NBSTZ4Szlq?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d44880-8be6-40e7-2043-08dd4138bddf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 14:16:51.7507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmFDyQiy8JgnHdf0o+mTe+QHMFnZJ5QKg2T2mypgioznGbgcLH4vLQiI5G4O1w0rIu13FDTX1pcVtuui/NIjrDKiIVErZEalewTb0L+t5OA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7730
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

Hi Jonas,

On 1/29/25 3:20 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-01-29 13:42, Quentin Schulz wrote:
>> While testing some WIP work done by Ilias Apalodimas on guaranteeing
>> read-only memory areas truly are handled as read-only[1], my RK3588
>> Tiger couldn't reach U-Boot CLI anymore because of the pinctrl driver
>> modifying a const struct rockchip_pin_ctrl, triggering a CPU abort.
>>
>> Instead of going the lazy way and unconstify it, let's fix the actual
>> issue in play.
>>
>> The member modified in the const is only ever used for setting a member
>> from another struct (not const that one). However this other member is
>> never read! Therefore we can simply afford to remove it which means the
>> sole reader of the member in the const is now gone, thus making it
>> possible to remove the member from the const struct as well.
>>
>> This also means we should be able to constify the private data of the
>> controller device for all Rockchip devices, instead of having those only
>> for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
>> branch[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all reach
>> U-Boot CLI. No further test (like booting into Linux userspace) was
>> done.
>>
>> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Quentin Schulz (14):
>>        pinctrl: rockchip: remove unused base_pin bank member
>>        pinctrl: rockchip: remove unused nr_pins controller member
> 
> pin_base and nr_pins is used after my "rockchip: pinctrl: Add support
> for pinmux status cmd" series [1].
> 
> The pin_base should probably be moved to udevice priv data or similar.
> nr_pins can probably also be moved to udevice priv data or constify in
> driver data.
> 
> Do you want me to re-work/re-store these fields in a different way once
> I finally send a v3 of that series?
> 

What I can suggest is to remove the setting of ctrl->nr_pins as I 
believe we shouldn't be modifying it and we don't need to store it, even 
in your patch series as we discussed on IRC, and keep pin_base from the 
bank.

What I can offer instead is to use a local variable to replace the one 
from the controller struct.

"""
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c 
b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index d449d07d32e..14aba6f370b 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -531,20 +531,22 @@ static struct rockchip_pin_ctrl 
*rockchip_pinctrl_get_soc_data(struct udevice *d
  	struct rockchip_pin_ctrl *ctrl =
  			(struct rockchip_pin_ctrl *)dev_get_driver_data(dev);
  	struct rockchip_pin_bank *bank;
-	int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, i, j;
+	int grf_offs, pmu_offs, drv_grf_offs, drv_pmu_offs, ctrl_nr_pins, i, j;

  	grf_offs = ctrl->grf_mux_offset;
  	pmu_offs = ctrl->pmu_mux_offset;
  	drv_pmu_offs = ctrl->pmu_drv_offset;
  	drv_grf_offs = ctrl->grf_drv_offset;
  	bank = ctrl->pin_banks;
+	ctrl_nr_pins = 0;
+

  	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
  		int bank_pins = 0;

  		bank->priv = priv;
-		bank->pin_base = ctrl->nr_pins;
-		ctrl->nr_pins += bank->nr_pins;
+		bank->pin_base = ctrl_nr_pins;
+		ctrl_nr_pins += bank->nr_pins;

  		/* calculate iomux and drv offsets */
  		for (j = 0; j < 4; j++) {
"""

Something like that to replace patches 1 and 2. This should allow you to 
keep working on your other patch series without me making it too much 
more difficult for you to rebase?

We need this patch series in before 
https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/T/#t 
gets is otherwise we don't be able to boot anymore on RK356x, RK3588 and 
RV1126. I don't think there's going to be much bikeshedding or 
controversy about my series here (in v2 if you agree with the above 
diff), the pinctrl series from last August seems like it could be 
opening many can of worms so better not rebase this series on top of 
that series. Do you agree with that?

Cheers,
Quentin
