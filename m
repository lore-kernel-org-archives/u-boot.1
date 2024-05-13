Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C160DC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 08:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49E428815E;
	Mon, 13 May 2024 10:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KvaoLOaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B0D88228; Mon, 13 May 2024 10:29:04 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391D087F13
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 10:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUak00slQfI5YMJVKvqcWFZqzdQGfs4hquGEe7gwmpAvh6M9YFHYLazND+htP3S1yVi1OeuihsG08B+0qnh/ftd4icv3CdSHHOC/xtes55d0ZMMywARlG1hN+DKcduQDxVSitw+btRgG3qRGosP1tiYxLg50hpfEvMoNBJRCbmnesUklMW3uxNA28CaeDXiLuvQHETPu8z2SKVIMmqXs5MnVR2Si5tYvY3lp1CmImWE8PXflJY2Egz1aCyj7j7GRlrVBtbUZ+UrIvRqlDEcNPO0kSR0TScDH3TNXZYKji9bsHwb+5jqg4oJrI+RNZGtQf4yGtULS8BhUfE4yVV3HYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mzK1dEu3QuoNsu7bIddboqVg4BERGkcucICYf8BdA4=;
 b=Ht3ZloO78wrdAhwT008uoeNn2lxV1+g/dtmzar/SF0hnvLUDATfte67yNnPlD0R8ZxC4YD09/lw1AzgPNS3+mCJhKmqcf+s9TZgftaCfc62UKNARRk79fOnJ3BYy45OMWTmCIz4Na+RHoazqW/i/YSI4US820SlEDDs7ovY/lwl8Dk4N2M9Hc1AMEFlXCOrk3FKZdizTGifK7KTmuSQWPmyjYSnnztnuNX28a5/5J7LN1oUYxFVcShTFrCv5V5h0OZbnTLGbacYtG5T3RvgNN/DSEzE+3D4fYyEP1cPhkfStYPRMWqvEWNXE2DBnuVKs0BLUajatPuMvY1oT3m7FiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mzK1dEu3QuoNsu7bIddboqVg4BERGkcucICYf8BdA4=;
 b=KvaoLOaVYS5KV3/713jk7/K4/HkvKyaiJWk9VBK3pzqlHDbcDqb738HVqa//5SxMR2pmAmWpX3Gj9pybsDFX5SLkOATjFinEuujFUj47I65EqAXvsMfZxRe1Woep2WEMU1WaFTC/hgRSLzbpn0yP4XEsr8gVp2gun/0y5Rl3R2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB8PR10MB3894.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:163::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:28:58 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 08:28:58 +0000
Message-ID: <36f1b695-5974-4c49-b5a7-43655588a994@prevas.dk>
Date: Mon, 13 May 2024 10:28:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: default to zero if int/hex symbol lacks default
 property
To: Tom Rini <trini@konsulko.com>, Yoann Congal <yoann.congal@smile.fr>
Cc: u-boot@lists.denx.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240505135353.1507200-1-yoann.congal@smile.fr>
 <20240506174332.GN2568172@bill-the-cat>
 <d7c4aee3-47f3-401e-a66c-642ec5995ad1@smile.fr>
 <20240507172359.GX2568172@bill-the-cat>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240507172359.GX2568172@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB8PR10MB3894:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c4ba53-4847-4d6d-8bac-08dc7326bc01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzdoTzJSTUVMYUtDaWYwRTJIT2hxbWQyMHN5M0xiQkZ4Umw1TkRuaHg5T2Fj?=
 =?utf-8?B?bjVtTU5nbHVyUG5qRDUzMTdNdFh0R2JjN1hySnVEcEJ5aGdSMjdTYm5FT2FJ?=
 =?utf-8?B?cFllbDh6OVZua0J2dmdTeUM1K253MVR4bVd2OHB6bTYxZENXNFNkSFkxRmJl?=
 =?utf-8?B?NWViaXNrZ0VwZkJ0aHJrcStlQWxVeCtseG1uRFpnSXA0Q1kxTTBRSUl6T3h3?=
 =?utf-8?B?dTZXUEtnMTRsdHRMV3FteXVBbGpsMVpQQ2N1d0o4RVNBQ1pGM3diYXlSVWRG?=
 =?utf-8?B?aXRCblhXaFY1VnFDUlByTEpJQUFzNWhzYU5jZFYxWXFRY3lTK01UQ3phZU9j?=
 =?utf-8?B?SzBhVzgzcmFNUXh1YjRXeXJkWWhJakc3d0VCWFVyU2c2ai9qKzloVElOZDcz?=
 =?utf-8?B?Q1R6ckV5T3c0Ujc0cEJtRWViYXg4MTZkYkxYVHZNQkVLWUo5a051YmpyMHFy?=
 =?utf-8?B?bzg5Q0Fjc1czdkVHT2NUNGRaWStzYkFscXAvKzFPdllHems0YkkvWVNRUEFl?=
 =?utf-8?B?dDZMTEgxSUY5Q3UvSFN5eFREcmZZeDJxc2hBakFIRUVTOTJweUJjRjdhdnVl?=
 =?utf-8?B?bVY5UjAzYkVUWmV5MDRpbHBNRVl2WlkwWXBzY0kybUFVL3pUdUIxQ3NyM0Vt?=
 =?utf-8?B?MUlMSmNXVjNJQk5pVTZENTE2R3VqVSsvK1Fjb1o0dEVaakM5UlpoeDc5dWU1?=
 =?utf-8?B?VjZqVy8yRFNVdUhtMHVpakYwTHpuNFZTUDFwcDdkb2Evb2k2RXkyTW5HNk0z?=
 =?utf-8?B?NmFMK3BrNnFHU0YrS3kzeVQ5UWlkenNlcUZSUUJnYWRuTmE3dElsWmt6ZUJE?=
 =?utf-8?B?bUxhNVJVTG1KeG9udXZqaGhySW1IdFhXTEcrVVA5Rm1WZkZBNkxyNnJYN280?=
 =?utf-8?B?Q1BYSWp1Lyt2U3VObFlpUTBTeWV5d2E1SWtjZ05ZOWxtN2p0WGdJSVZrNUpm?=
 =?utf-8?B?bktmZEpCS2U5ZS9Wb1FjRGRhcGsyZXF1QU9kZ1FPS2UyQk9RTVV6c3NBa2tU?=
 =?utf-8?B?S2pZN1JEdDdLa2w2VVhnL0pvMGU2TTV2RXhBYmowM1I2SUZ4MjVHRy9jYkMw?=
 =?utf-8?B?MWxZOTVsRnB3STV3WXRxQ0JSRlNhRjgrdDdoN2o4UnNic1JvQThKbWdGemxN?=
 =?utf-8?B?TUJtckY1Z1ZLTk14TDhNZHdDVlA1T3NCNXA2a2l5azBZMEcveHlkajdBVHpp?=
 =?utf-8?B?allVVWFoU0M2b0x3Sks2ZTNxTEhsUlJSWGFSdXZybS9SSGxQcXhGM3hEd0pU?=
 =?utf-8?B?KytaWWJpZnQrTXptYU9YbzBhMnVCTGdVaWJSSHFJS0h6cmpPS0YxVG5GMXNX?=
 =?utf-8?B?TkZINkg4ZTZlOGNTVXl4N2c4eDFicUUvV3U1Z0Z1Q1ROTHVTcWNNU003SjI4?=
 =?utf-8?B?OUMyZ3pxb3M3N3gvVmZpNkJUZGlYKzVIK24xak9Gc0dHOEtNUDA2cUJiR3Mr?=
 =?utf-8?B?YmFkV1RQWFdYRHZYU2c3a3I1VTBsR1FOay9tcFBKcnQ0UmJGMW1iR3lLeFRl?=
 =?utf-8?B?NFFyWVFsS2twMXZ3M2w2M1ZVaTl2NHpvTkNPczFXU3d5bEJMK3lid01Za2V6?=
 =?utf-8?B?dWpUcTRkaDFUbHVWckwvUzh0M2tRY1dRNEJpd3JRQTZ3a05NSlZkdVYwOU5F?=
 =?utf-8?Q?HmpsaQOQEAZXsmcTb+213Wf1RBatX2d+BNrthlOa4Vts=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFZRzk1R3VZZzNsRW45aU03TVNmSW5sUm4zZjBaWjQ5K0dnbFlGc3hseGpp?=
 =?utf-8?B?cG1la25uL04xS1lYZlpVYndWUUpxVW9HZURsOHMxNERQQUhTOU1mV3hBRitZ?=
 =?utf-8?B?TmhjUUY1clBIcjRUZ000ZUVKeFhIQVdPTUpKMUtUenF4NmtSTGE0aWYwRUJG?=
 =?utf-8?B?ZFZTcnFoejJQUThScVlhdlloTndURWZ1aE1pOFhyREFhMHVEZXBVWGNFZCt3?=
 =?utf-8?B?YVBsZWNSMlhwUHE4UXVBV3hzS3NtRzRsYWRGSTREYzM2Zk05LzErQTdNRUs4?=
 =?utf-8?B?aE9DL1grd0hJZ0VrVU9NVTltNkhxcHJub0JCN1M0MzBmQW1xdTMrdmpoK3Bk?=
 =?utf-8?B?VWJ4c0F3ajFaOGFLWCtkbkEvZGc3bWRidUhHaTVGandqemRXTng4czdIb1JD?=
 =?utf-8?B?aGc2SGFjc3U2TlptOFhDOUU0TmFUZDNpSGVCcDgrZzZSS3RjbXpNZ0F6dmtl?=
 =?utf-8?B?YUJ4djlHVkdoazVRaHhWY3lqMkhXaHY2citRNGRmME5QTldxenArb2h3VVZE?=
 =?utf-8?B?VW5manNjVzIxS05hVHQ0L3UwbTFjcHM1VWhOdElDdTg2RWxnME9Yc0lUekx4?=
 =?utf-8?B?ZWhiVkFxbnFZRnA1QW9oUWlUQzVVYUJ5b0Y3d0wyQXEzUm5FTHhTcHBVQWp0?=
 =?utf-8?B?Mm4zRndSWURKekw1V1gvdVd2dHg2dnY0L1QzWnAwZnlWSlNsbzNienNBN2lP?=
 =?utf-8?B?UjZxaWx1QjRyVkIwTCs4NjEvc25Za29jOVN4cWUxLzdUVUJSaGhNbXhuS1Fh?=
 =?utf-8?B?b1BZSXlYQXJZenBPUUpSTHhuOWEvdTFpVFQzS0xhUFJhbEw2Tnc5UzN0REMr?=
 =?utf-8?B?SlJML0xnVmptNVpIa25la3JlZDV3V3Njbk5GRW1CRlMrNkplZXloUmJnVUpZ?=
 =?utf-8?B?VytGQTFpM0N0dlB4WDAxc1Ewb0Jpci9LQ0VWbFhmd3NGQkM0Z0g3eEVJNitR?=
 =?utf-8?B?c05EWGhyZnR0bkZUME1DUFptcTVCSmFQMkRoMlhWR09FT3ZYR2c1eVh1Tm53?=
 =?utf-8?B?SW15N1FPbGxHRmFlTUE0cEY1OTk3VVcwWEFKSjNSek54c2xrcGsvSUo4YlJB?=
 =?utf-8?B?blpucVU3ZEMzZk5QNzRUZzFBdlFmdDMzeFJPRHNBMkVLWTFBWjhrYWFSb0dv?=
 =?utf-8?B?czIvZ2hiRUhycEN5dHFRWXNFY1RuWUl2ZlZEcGR6cGJLcGp4dEdrNk9wNUwy?=
 =?utf-8?B?VENieERmbGJSNnJnRnc2dFRIM2YrLzdhVHhYZWhES0orejJ0N2xIQUVWcEFS?=
 =?utf-8?B?YWVvdmxFcGFvYzFpMGQ5VDltV3g1akFVUE13YXFibTdqV3hGbFlvUGgvNlhF?=
 =?utf-8?B?RWo2UnNVNzRjN1c2QXlFcGJSMDFoNDlKaElnR0crblE1WVVDL1hWUXJmSVpZ?=
 =?utf-8?B?R0ZtakNoV3RoalN1MG8vVHIrQXkrc09OcEFRc3VQZVhSWHdQNjMvajJPR1R0?=
 =?utf-8?B?aGV0clRUUlp5eDRta1l4aVFkd3NWSUl5dDBxN1hzMHFBc0MvU3hNMnNNWEZN?=
 =?utf-8?B?QmZIaDJHcFdsN08yeHJwNjQ4WDlmUXhrQVdNZzdqYThEd1JDR2NPQkg3ckhH?=
 =?utf-8?B?RzBSVlplREIzZVZLcUtSRnRmNkkvNUJWZWZPam5MSEEwQmtiZktnbDI0LzFT?=
 =?utf-8?B?akZwbU56Ym5hUU5vbTdkZTV0R1hidlJUVGk4SCtlQWZMUnJxbFhsekxydVQz?=
 =?utf-8?B?Qzc4R2V3bG9ISW0vanhRdDRUNUppeTk4aElrcUUyRnVWQmh1S09OeUVWcDdS?=
 =?utf-8?B?UU0yZHFkcDZ1b2YyYndGcHR0cTVuUXd0c1dYT2M5cytsSkUxVHFZYm1HOHVK?=
 =?utf-8?B?Vng3Yy9Tc2NUaTJLQVp3bmZjUzJHdnZtRFlycXdGZ1F0M2V1NkY4dW9NbFVu?=
 =?utf-8?B?M3htSHRDeXJjVmJDenY0VndHSWFVVk5xR0pxZ200MnMzWGNsNmMxWi9TbHBx?=
 =?utf-8?B?cXhrWDdxeXpkOWhydGZyTzFoNHRSM081bWJaUkpBcTlxMjFDTytDUVhlbW04?=
 =?utf-8?B?VmltQzN3RXhzcnRweWFWc25uVkVpOWIwZHZqbzZRLyszVEdkOGxhd1VITWsx?=
 =?utf-8?B?OFlGeFJvc1RMUExGSDA5QzZpdHkzOE8vK1F4MWxxTXhVY1dETEJlMG9SeEVn?=
 =?utf-8?B?cnVmSkZYV3NVVVdsNlVISExzMk44WFRVY1JTbnU2aUx0Z2xVZFBSUEwwUmlU?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c4ba53-4847-4d6d-8bac-08dc7326bc01
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:28:58.1125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1SddDMRLbSH0EHq2ZLUXD1yqbdnsRQfhaMGKVX2grgaTEaWIXbxbWALton/DgMahgY7S0puNQsAJ0oQYhYj3O7C8a0zB9T7oYiioba1Gkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3894
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

On 07/05/2024 19.23, Tom Rini wrote:
> On Tue, May 07, 2024 at 09:17:46AM +0200, Yoann Congal wrote:
>> Le 06/05/2024 à 19:43, Tom Rini a écrit :
>>> On Sun, May 05, 2024 at 03:53:53PM +0200, Yoann Congal wrote:
>>>
>>>> From: Masahiro Yamada <masahiroy@kernel.org>
>>>>
>>>> This is a cherry-pick from the kernel commit:
>>>> 6262afa10ef7c (kconfig: default to zero if int/hex symbol lacks default property, 2023-11-26)
>>>>
>>>> When a default property is missing in an int or hex symbol, it defaults
>>>> to an empty string, which is not a valid symbol value.
>>>>
>>>> It results in an incorrect .config, and can also lead to an infinite
>>>> loop in scripting.
>>>>
>>>> Use "0" for int and "0x0" for hex as a default value.
>>>>
>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>> Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
>>>>
>>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>>>> ---
>>>> Added context that was not in the upstream commit:
>>>> The infinite loop case happens with a configuration defined like this
>>>> (a hex config without a valid default value):
>>>>   config HEX_TEST
>>>>   	hex "Hex config without default"
>>>>
>>>> And using:
>>>>   $ make oldconfig < /dev/null
>>>>   scripts/kconfig/conf  --oldconfig Kconfig
>>>>   *
>>>>   * General setup
>>>>   *
>>>>
>>>>   Error in reading or end of file.
>>>>
>>>>   Error in reading or end of file.
>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>
>>>>   Error in reading or end of file.
>>>>   Hex config without default (HEX_TEST) [] (NEW)
>>>>   # This loops forever
>>>>
>>>> NB: Scripted config manipulation often call make with /dev/null as
>>>> stdin (Yocto recipe, CI build, ...)
>>>>
>>>> This was discovered when working on Yocto bug:
>>>> https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>>
>> Hi Tom,
>>
>>> I'm surprised this was accepted. In the past I've wanted to avoid this
>>> kind of change in Kconfig because while the empty string can be easily
>>> be checked in the code as "user didn't really configure this, do
>>> nothing" a value of zero is a valid option in these cases and so then in
>>> the code we need a bool symbol to decide if the hex/int symbol is set or
>>> not.
>>
>> For context (and what it's worth), before this patch was merged, I've tried to fix this problem with a patch of my own which only exited the config process when the infinite loop would start:
>> "[PATCH v4] kconfig: avoid an infinite loop in oldconfig/syncconfig" [0]
>> ... the v5 version was a bit more severe and exited as soon as an error was hit, it was then removed from -next because it triggered a build failure [1].
>>
>>> Today this is less of an issue than it used to be in U-Boot with
>>> everything CONFIG-related migrated to Kconfig and so there's no longer
>>> the question of if we missed migrating a file that defined the value but
>>> there's still places we have in the code where hex symbol is undefined
>>> is not the same thing as hex symbol is 0x0.
>>>
>>> Is there a specific use case you have for this in U-Boot? It's been a
>>> while, but it's also been cases of newly introduced symbols in Kconfig
>>> files with incorrect dependencies, where the infinite loop in kconfig
>>> happened, CI failed and we caught the problem.
>>
>> For a specific example, one can trigger this with CMD_PSTORE_MEM_ADDR like this (tested on today's master):
>>   make qemu_arm64_defconfig
>>   make menuconfig
>>    # activate CONFIG_CMD_PSTORE=y but forget to fill CMD_PSTORE_MEM_ADDR
>>   make < /dev/null # This emulates a Yocto/scripted/CI build and loops infinitely
>>
>> But, my more general use case is the Yocto dev trying to change the U-Boot (or any kconfig based software) config and accidentally trigger this.
>> In Yocto, what they will see is a do_configure task taking a very long time but they won't see the looping logs the detect the problem (This is caught later by filing the RAM and the build process is killed by OOM, or the disk run out of space filed multi-GB log files).
>>
>> I'm sadly aware that defining a default value for this kind of config (fixed addresses) is not really sensible but the build time infinite loop is not good either.
> 
> Exactly, but to me it's worse to cover up the build issue and introduce
> a runtime issue instead. Something builds but then crashes at run time
> is worse to me than builds fail / get stuck. Using your example,
> CMD_PSTORE_MEM_ADDR depends on CMD_PSTORE and so if someone enables
> CMD_PSTORE in a config fragment but doesn't define the address, the
> build should not complete. Using 0x0 means that oops, now it fails to
> work and might not be obvious why either.

I agree with Tom. Yes, we've also hit those yocto failures with a
multi-GB do_configure log file, and that's pretty annoying when one just
starts a build cooking over night and then the next day one's laptop has
a filled disk. So clearly there is/was a problem to solve.

However, blindly adding a "default default" of 0 is not the right thing
to do. It seems much better that, when there's no configured default and
kconfig gets EOF when asking the user for input (as in the 'make
oldconfig < /dev/null' case), kconfig should exit with an error
explicitly saying "no value given for CONFIG_XYZ which also doesn't have
a default value". That stops the build, and leaves precisely an
indication what the problem is. Then the developer must either provide a
value for CONFIG_XYZ in the fragments, or send a patch to add a
reasonable default when that is at all possible (not so for e.g. PSTORE).

Rasmus


