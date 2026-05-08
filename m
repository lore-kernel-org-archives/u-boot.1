Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B58CD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 13:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FB784C81;
	Fri,  8 May 2026 15:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nQEKK9Vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4BF84C95; Fri,  8 May 2026 15:43:24 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE4284C3C
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 15:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hanH5ka3vKv+tBzKkMN9V1RHJO99NrMVxKp4Hm3pkhBdxiHncAcOmWGKBnwGrAfUb8u1RAlK8yYjDbUesnN/D5Nb5vPP+R+7QHCFogFdUpufzKvJXORbDRZiQbnyXU2M/r7Dl8dGDDEkz8JcAIYQ1Hj8uPm9IMv1f/IDG5x/sIviXVpzRF7mOkL+QusqaD6DroUatcmr1R0JLm4gLVZtUZGpQ8bHTC5GVgT3TC+dAiTcnrREXt9fu5woLcw3dRIeiq2ifm3OXuEPOusw0aGJ6pv0743YixPE41zUjgxvgMgDgGCpluwatAMv5kK6kpur+SUuHFqseCgfqrIIpjF2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Jlu+KUhD7WhoZgUs00jXoBJZ14qRqP7MgGtm6J3cG4=;
 b=EjMzTJcyc2YmcNZzvI2GQDl+KRUumy4XpnPqZB+l9XQOnn2/2ZDEeB+kk0QaUvg3+Eryf1Yx4Fsz9AemCt+moUW/w9XAUEK3KkEXFFI2iNgcOnVL040mEAoN6FwHRo2HO3uwoZiFCWP23WpqEoz3BYgonl6NjQsMNqldgHeU0KaejqgweZlz5SXcZVxWMA34Yel1rWaZylw3rAHi7/WRWjUrSZ6rlB3EHwcYSX266+atAeSukEiAeSuAcdbtgQiwcTkruNkzTSxeHD43M3smpvtSdgeHKmOi4Fj3DwW6ZwhtiOqZU4JbUfIFOdcr/5O0Er3rK8ba6ik91kcBYua7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Jlu+KUhD7WhoZgUs00jXoBJZ14qRqP7MgGtm6J3cG4=;
 b=nQEKK9VjuQj6LlBFbG+cqN0zhVU8hzhsqci6Ya4UZOXeWJSh9OUqOYjVmZhtCzvGyMDf0LTmirlst94YiMCupmUzmXINpOuXJRo1RRV6zyqqZWakR1clQWSe/ghIBo1iSNroNDLPAqNmVI+I943BrPBAinWmXwpu/e3CzeeYefg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI2PR04MB10545.eurprd04.prod.outlook.com (2603:10a6:800:270::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 13:43:17 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 13:43:15 +0000
Message-ID: <b0ade3ae-db3e-426b-b307-7ffaf661a161@cherry.de>
Date: Fri, 8 May 2026 15:43:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: rockchip: Staticize and constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
 <20260507164248.59353-2-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260507164248.59353-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0141.eurprd07.prod.outlook.com
 (2603:10a6:802:16::28) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI2PR04MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: e552a60e-49d4-4514-5e92-08dead07c0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: giATMIiq2uvqOd/axVXDEaG04KsnO0f6Ykp5eVrOu3GKFsyUwfZpAQqyJ1U5LOwzIZx2Ctgqpx3ZFa7v4TL+8+RfCh+CGiejd7lTSuPZ74WAlCVVJbW3Wgz3NZF7xtLWNHK7Wj2VItPsNWzMUHqKShytvNQtQRKhZawg/7WBnsSc0/ePtOnbOFIIMfVVDnz5beIcemRYFEfh1BEN5sCILOOvjyiL/U6jdTO7pO8N6HA+PhT6d0MInV1k390ees45Op+OWjyQR3Bmulx65s5DII0qCu+sRPiuSGL+hoAeSeHzSMq7cSWcNHVD2sGs7fNlgAqgliWh3hVbI/Z8xSgiG4MtDB0BhTMFXOUUoBkyTqtHtcv8HEtu0cambjilwYGUNTGVPgKrRmSlcuzIi7l6ka2lKM11IxVpyEKiWAVCpab7GKu+s56qtWPdUjrTwh6rKp9+ffyqSeShKvl/Kom1TjPjEZhVD5wY816722iq7GqrhccVuZm5r3lI4U5HtLUoUjAFS0UBcZUQ+vZjoYqWbZmmPEUTWU554EZKHvemGoK8z9gkWtxWRdidSWySPjUHY9uKiKwMOO3r5R95UWpCsqpVl1UwFdA3c+WvnG+9EItzLtnKhokwBxH+1msYw+yxgltcWVF2a3CQnf978kbSj+gv9RjF9VPWWP+MxRMVrxUcSc29lRhlsL+97Jqua5Mt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVzelJlVGhrakRlOThFamNPL3pCS1VidmZoeFVhbGcxZVFRL3hLaTJwSHd4?=
 =?utf-8?B?bG1UaHZMcmNaY2ZKc013MUVJd2dBUHZCQzZTMTJmTjJsM1MwVlZCUDdoUVVK?=
 =?utf-8?B?Z1M1V2hVS3dzdjduNGFjaFJVOTJnREQ2V2dwdlM5MmZabm5vNmVzTUkxdWJC?=
 =?utf-8?B?T2tCY3Q5VmZ4WFFoWnVKT05BSGY2VDJmM05tTHo2eVRhMXZBTjYxWmRHSXE5?=
 =?utf-8?B?ejYzd2tUQm00Y21GSzF0cnlGb0FpZFVGYktpTlBTU3QvSGFtL2loTklJcE9O?=
 =?utf-8?B?NWlEMlFwZTJTZFFGZjdEbE5BK2VET0dRVll1dmVIMkxrdHh5Z1RtVDFlNlIy?=
 =?utf-8?B?bDMxa2RjdFkxNzJuSHRvS1hNNGU3SlhKS0dPei80ckVKYVJ2VCsyVGQ0Slk2?=
 =?utf-8?B?eGZkVXhyWHU1UzQ4SU43ZWd0WFpOT0pQQmdJeVNBNzVjcHRTK0hQVHdDd0E4?=
 =?utf-8?B?NDdxZkJvSDN0bEVnbG0zSEcxVHJ2aHZPVmNhYjFXOEFQWWpMcXpLS0FOcmIz?=
 =?utf-8?B?enJRNCs0MFVCYU8zd3laRGJRTUlRd2tUd1ZodHM5QjFuZllMLzZEanNtQ3Ez?=
 =?utf-8?B?M3kyWHN0Qlh5eTRaZDZhdTlnU0VPZDhiemdxSzNoV0pDK3AvZ0R5QzF0d3F3?=
 =?utf-8?B?RkoxTERjWFRjM2NHNGVhTTFIWW1rYW1td3M0M3pXOHpOK3hPZGhxcTc3anhi?=
 =?utf-8?B?Rk81Wm9aa2tzYi9UUWFxaFpLbUQ3OEZib3NHbmhxUHVPVXhJL0ZCSkVpbEFR?=
 =?utf-8?B?Zzd2TjM5NHdQQlhsZ1R4dlZydDJqSWNKSUphWEIxRVdQYnlWQmpNVHQzN1lj?=
 =?utf-8?B?REZQQnpvTUhhMnd4amVRSHFxcGFxbWJkbXFCSGdNdU9xZnd0bUJBVGxTWkJV?=
 =?utf-8?B?UFlmTTUrREVIMXROdU50dTdCWHBnZzZ2WTFOY2haYk9menBMK1AwTGVHbVo4?=
 =?utf-8?B?VzJBZzVSbndJVWNIa3BRa3JGbUlVS3dTZHNQL2pDd0FHdnVBeExJU3A4anJ5?=
 =?utf-8?B?SHBweDBGUSszZVlRckZIN2lUZmF5Mlh3M2FWUTFuNUl3bEF4N1pWOURENGsv?=
 =?utf-8?B?R1lUMEtTbHlKa3dVKzJva2YycWJwYmMyQm1RbTc5YlplTTZZRHpxUVBVR3RB?=
 =?utf-8?B?d0R6WDdpK2ZybWpuVjlnR0tBR0hlQlFXdmpPR25YZXF4eDhVUVo1VXJGRkZE?=
 =?utf-8?B?Wno2RE1NU0NtTUZ4OTVOY0lWSmYwcXJLekdOS3c3SnVnd3FscjBpQ1JDV3hO?=
 =?utf-8?B?OFlBa1R6RGNHamF5bTk1Yk82enFZWStlbWpxQlYyOWVRWVIrRGROZzl5d09z?=
 =?utf-8?B?SU1qOGRrTHAvU0pUVHIrVnlMRlNGUGhydkJKQWFnOC85THFTMG5DcWhZSUlQ?=
 =?utf-8?B?SE50UGdiS0dCY2wzTC96bnVXdy9tdnFnNzcyQjRHeGJxUjZxWno4MWtCZHZJ?=
 =?utf-8?B?SVRqS1Zid1VjU2hDb2ZJM0FCYUZSV0UvQituaG9nSzZzaEY2aDFNQ1VDeFJv?=
 =?utf-8?B?TmhMZ3lrUmw5RWVkekFDSEltMi80eXE2NGZHZlU3WUsyMFFjSDZveE9QenJo?=
 =?utf-8?B?VDBndjRxY2JVY0p4YlZxMllPZGlMZjNWZEI4d1pHVktVVHVaZG9HNUtCbzU2?=
 =?utf-8?B?WkxnaThHSCtsRmg4VkpacXo0ZHhXMFQyaWJsazJFamVFMUpPMkJpbHIyZTBP?=
 =?utf-8?B?bmgybDdkMUpXTVVncnhQUnRhTWNYK1h4WEpHZ1hoUXZaYUZwY3VWRUZObE9P?=
 =?utf-8?B?SjZpZ1lPWm1mUjI3dDVlV0lST25CK3Y3RlFoWHVxZnRsSXVtUGIyM21WaGR4?=
 =?utf-8?B?VmN0SnNESVFHdFM2R2RXNGt3bVFVbzM3MVlwdmlhZytwRVVneXovaXdSVzRn?=
 =?utf-8?B?ZlhDQjZ4SDBpeUxldlR3K2t6d2ZuWEZlc29HcHVkNHRHOTFMK2JzV05SODBU?=
 =?utf-8?B?TE9RVXZkenZvZWhsUnNPaGVKYUhTeEV6STBYSUE4NW1RaEhDU3lIWGlsa2dL?=
 =?utf-8?B?UmNUU1UvaHhySkhzOHJjaUxBVHl3Smd1dU9FbGgzK3VFTURpTTdsSTFLOVJp?=
 =?utf-8?B?OExjTS9VNnJRREpkVmZQdm90YUhqMmFPNi8vUDBYVlZEejlvTUUvOGkxS1dk?=
 =?utf-8?B?SS8xQ0R5OHNPZmpGNk9pNFRLRHFjdW9QVlRvZlEyNythM1FDejRSWkNOVTRN?=
 =?utf-8?B?bnQ1dExMTDI1RjQrdEovNDdCa2ZlQ0hmZytjWjhHOVR0YXl0NVErWEJTcER0?=
 =?utf-8?B?VXBGZFM0djRkWjRuU2VDMnkwY0wraFQxaUZsQWpOMGFzZG5rYnhjUUxuMDJW?=
 =?utf-8?B?Ky9DWGRjWTVoRTgzSHlZZUNlVWIvU0I5T043OEtuYjBKRi80UlRsQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e552a60e-49d4-4514-5e92-08dead07c0ff
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 13:43:15.2265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3p3Lm8prP0LKw6KhZk96fnmQkgY3Xul6MdJaroF/QeMqirivedCyxsg+0d+XnM1L4ZyQLcathKbyf+xM9ZuLK06lZf/ygXlQkD76Cwoie0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10545
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

Hi Marek,

On 5/7/26 6:42 PM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
