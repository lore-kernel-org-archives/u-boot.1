Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D438CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 17:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93214849C5;
	Wed, 24 Jun 2026 19:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HWIP4MBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DBC5849CB; Wed, 24 Jun 2026 19:37:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69AFE80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 19:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg45Xy3hII8fX045/GOuovvMj9b6IEdZZRlzTo49KuxxV2v2MtnBlsHHiTDwBYpUi1Hhgoq7Qd+YUG9YlCjF7wsn7v22lVXep5Um4QLT72KB5N2u47Sn1tuajqS8sfEkmllKBKVIVE954CMH+/JyUdMzKNjZkNrA9YHGjSFy9iy3Fp64v7f8C6s0S/zGTrh11S24U61bYf8wTcox/eXqhB9BgKaAKcDfLqZ8w4r0tJ/goNNks6w/vnETsx0KDtbqKwLL9hW6VeUykI+B7XRk6TU6wVlfafyTNyoSmzT6R0DcO19EDwkaIf6ilrwdHDZ28msdqu5pymGaEHAh3NMI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64TQYQiZ0pVXBJjIp3VPKMGkRWpf6WukXoeS5mxXg+8=;
 b=iDKgqARxnzQNJq6aGcHSqjbtZtE/7KWR6bU1z9PwOd9opWtrKDGLlckSXCXIihQT7Qc1xbBqbH4xlyyc0vKeBIX1PaHVd3GlBs2IyxsIVs6YIrxlD0fdavvrpfXd8OUr7xs6J4xV5OAHZiElc7E1zXDtj+WczkKC3xPDgy09Mx/AQh8ICkiqtT9Yd3Amr9UQkCmoapLl3V+bs/GykJhbYBbFsvxg6gAYur9vNwkIMaJ1OeKJXJ72pPiNuwoRkkqek3htXrI0B/Qagt83aqs9ZqWVcgoV7PsExGEHj3Hw/vy0TrXRM+e3idwo52WOSW25y7D3wY21QiKX46x0WvQArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64TQYQiZ0pVXBJjIp3VPKMGkRWpf6WukXoeS5mxXg+8=;
 b=HWIP4MBPYSJupQNlnfoGT9+W05GOQSOS+DjxD5kjmRUCKZ11VDaA7McseZlfzSVPPxINLp5U9GDYhPOZiZpeNuAWDE/V5QqU+4Lsrn16YA++bIJCUulrzpK+m/4dLxh+OozEN5grWJXxAgvb89HcKpd3VR5Qv1whhEMWdJF221Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by GV2PR04MB11422.eurprd04.prod.outlook.com (2603:10a6:150:2b2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 17:37:43 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 17:37:43 +0000
Message-ID: <deba897c-5fdf-4de8-8de3-b4cb671ed12d@cherry.de>
Date: Wed, 24 Jun 2026 19:37:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update SH/SoCFPGA/USB email addresses
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20260624171428.33523-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260624171428.33523-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0191.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::48) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|GV2PR04MB11422:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fe9d47-c9fd-4066-d669-08ded2174c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: obwPZVdgSjq2E9zWTCxEKlNGfikBBODcdf5F15kO2OsdUgTtxn173oBLswgR6+KnMtyxA4Zitw9lrVNSKaXrwFwOM9YJ7uHnoydD+l8hV0q1mbwbQDeqiT6dxSfqpqFzaMjrCXkDkAQUrfcPxe038woZGbc7HMfDdC6UR6/W5X3xLFpPKSiYm2kPiP+ManNkOhZVcAR3YYuWP88gPOLr0IUluYXyt90onuhned+Je3HeKQsvDCMx5aOt3OE7As42Kte24BYIKCYOql1PpjhrdepqlRCKzg9hyf7TURPaoWddrhPM3uBOpmSmNOaumUIrVQ5Jg0Y4+jsp8HxosDrg2sEc/Ldshwv3v5fWhr+O3i3dilJXeWcm7DGN3MOtqOMHg7b2oN5WRxC0bZV62lHXsp2wlAEAF0Ma8t8nZUsUH48nGLV/IMF8M2YVTsBAq9eYtrTISzk8ySM1/CBm1r387x32gVHaW3INNcJ+8/ULmvQcfgoVSK8l+KF68Q8EtzNoRo6dRzWUQHEGS0LLjvqzqtdty+J40ou9Oab/5ptsKni/H7x0D2yFOPxqk66afjO2/bfPj7QL6OSXf+FPgL72kGr0tDRHSVpeW5Jnz9V6Md24mvEIe85VWLKXlg4XglAh9j7lGjwvcW9BTpQbc51oICKyLRdhvZIzsIpsDiElrCY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Umt1c05BQlhEbnBSS25PV0g0dlk0NGFBdld1bUxEZkhYRVhvaGFjNjduemdR?=
 =?utf-8?B?dHQrYU5FWTdIaEpGZjJZUzRKMVRNdnh0R3hBNEhiWW5WTXVENkF5eEZ1UmFm?=
 =?utf-8?B?eExwNCtDd2ppRzU5MmtYQ2hpSmUyRjdMaVpiMUUyUWFKdEdqVWJ2UE9rdVVa?=
 =?utf-8?B?enlyR3pRNzdRY2c5WWRCUXhqcUM4VE5tb2pxa2ExajBNUkJPSi80d28rc0M5?=
 =?utf-8?B?NDVLeDJ6dlBTVkkxQXBQOUx1NldiS29ERFFzVThHS1hIUkpzSjBGV09hMHVS?=
 =?utf-8?B?eXVPS2N0WDYyZy9KSm1Cd0p0UW5UWVRoVFNoSU9pS0grUzN2clNBV0oyNEZ0?=
 =?utf-8?B?aW52N3F4cDJ1bzNVTzhwYXZIWFUrRTQ4KzlaVWp2dXdxV0dXOEtRdnl0dmMz?=
 =?utf-8?B?S2x6QzV3UWVpenBldHc3eW16MlBxb255VkdGeXNZSW1yN0JQbXFUOE5QOE03?=
 =?utf-8?B?TzVCVkU2SHh6ZHhWdzFiL2lOSVFnRUJMMU1VTjNxOFRxZEFrV1dWWjBOc0FV?=
 =?utf-8?B?S2N3eW5NajAybmZaazFvQ3lsS0ZpNzRuOUxFdkt4eFhDRk43R0dDNEZTZ2Ny?=
 =?utf-8?B?UXZxSFhQUTg0VFNqa0UrOTYrUnBBbnNMM0hiSHBsRi9WaFVQQlFGZklpbzJx?=
 =?utf-8?B?NUtoSElJMFFZUVovU0VLbXNXVkJBOE82bmF6SnoyeVRTNUh2RW5hZGhqR1hD?=
 =?utf-8?B?L21nbzhyR2pTVm1vNVR0L0VkY3JQMjNhVy8xZ1plMXJhLzliWGJyWHlTWWxq?=
 =?utf-8?B?SExtbDd0Ulp0a3VvYUFXdlJIc1MwaHp5VlNDQzhqVmEreWVWRVhFNHBVSTNC?=
 =?utf-8?B?emU4T3czNkNBa0NFajBoMjRjeVpoNDg1c3JwYlZsRGNJK29xaDB1Q0pYM2Ev?=
 =?utf-8?B?UkJmcmsyeC9WZWVuREFYT3F4OXIvaEszMVZFQ2RQSzhLcGIxUVNkV29JZEU5?=
 =?utf-8?B?WVovaDhYalVqa3JOcEVNY1VsRm5WbWxSL1Y2czF5MkxXZUNuTTlsR1lOcFpk?=
 =?utf-8?B?NXBRcnYxcWpBUVYraWwrVmtmRHdkQlAzRXc1U0xOZUsybCtDbFBQMjQ3L1dz?=
 =?utf-8?B?dU9USUtwTzdpYkpqZW55TlMxaDNQRzVjVDdMdThUWWdYWnRON0Evd2k1cHF3?=
 =?utf-8?B?YlNFQ2RiOTdiaWJXUndIKzg5UU05RWYvOGlPOTBWc0VzM3MwN3dBWlgvVThh?=
 =?utf-8?B?TVNWZFI0TzhQcTI0dlE1ajBkWi91dzlMSGhrcWp5WFRVQXlGZzljWjluYUJJ?=
 =?utf-8?B?Z1YrdzByQnBHcmthZHNodktsTU14UkQzK3hoY1ZicGQxdi81ZGJvYnExWFVU?=
 =?utf-8?B?ZUFBUkpuYkVyMnQ5VjRMSVZVRnFIVUoyYWU2UFBZM2VDMXJGbFMwOWducGdn?=
 =?utf-8?B?eVRodFlEN2pZdTEwUzlya0E3cEU1djhzUHZIYkNVL05jZUgwWUpJTVBXNWc0?=
 =?utf-8?B?djgySHNSVWVLMFB1NnBDaHpDNy9ERjlMOUxrUkpSVzdIcmRYQUx0Y0ZITkJ0?=
 =?utf-8?B?MHFYS2RTSzNTMzIrQXdRcXp2c1JmMGFPeUttbGszRTc1eWJGOEMyRnZXY3dB?=
 =?utf-8?B?a1hMeWlFdDljeGJOU25BY2I5bGMvOWxlUzNjZGphODJMSTNNTzZ5M2RvTmIw?=
 =?utf-8?B?RzFCR0ZnTVpON3A3M3dzeklHTWs2Vm9KVi9VcXlCWHNiWTZwaHJKL1FqS1Z2?=
 =?utf-8?B?OXV2M3JCbnJvRG1Od1ZTa0xXa1REWDMyQXRFblVZZTlpc1JqNnZBdFJEaG5y?=
 =?utf-8?B?c0JMQ0dFcFpvam1qRGRyWmRzUlF4RFBVRjR1YTNjUEdPVnFOZXgxQldaK091?=
 =?utf-8?B?TktPSWlXVlptdWhMUnBpZUpKbUlvOWJ1Qk1yUW4zdHBzMFpXaEVlOEZ5K1FJ?=
 =?utf-8?B?dVJzWVl6cW1MNnNQcDdkWmNaQlh5QTJ6R0o1UW8yeVZkSW4wQ1BGQzlPa1V0?=
 =?utf-8?B?SmZLdkpZVmRHRVB3V3pYZCtzWFZGVG90NWxmSnJobXVvQkdUN1FvQlFSaGtn?=
 =?utf-8?B?eGV3cFpxTVhoa21IUkh4RFpIMXlXaXBIQjVxQzFLS2hwdmE1S2xUNzcvRUpR?=
 =?utf-8?B?dVBEZStaL2tOY2pJdWszRmpMZElMbzFmSFM3Q0wrYnh2SFhRbGgvbnlSVWJ3?=
 =?utf-8?B?U0RvOHVMaTFjbWtpcGF1ZmZjNzNaWW5HdkpLUC9Cb3Z1VVVVZlc3TFQrLzh2?=
 =?utf-8?B?VUMzRTN6aWg4L1YvdDlkSGtCMWVFbVFkNHplUmhYbHNNT1hMTkk3SkRLWW1k?=
 =?utf-8?B?ZUFZNlZ4WWlDVjJ1RVR5dUp2cithSDZCS0Y3RnJsd1VSR3kxMisxVjg5V0F3?=
 =?utf-8?B?bkxkcmRBSlZWK09WRXdVODlIK2xYalRNQ1JaaVhKNzFYMDZUVHhCUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fe9d47-c9fd-4066-d669-08ded2174c0e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 17:37:43.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiCQNOCh30J7TJEJRIcfieUlO7oh7a+TOn67V50wUVDQDdRpy+jBk4PiaIdGeUJ/KzxLMLWV1LU1pca5nlxsAHb3u93o9UwtQ730zLJfTm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11422
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

On 6/24/26 7:13 PM, Marek Vasut wrote:
> Update the email addresses to a valid one.
> Use N: usb to match on all USB related bits.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
