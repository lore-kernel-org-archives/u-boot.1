Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44CBC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 09:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCBB88AD3;
	Fri,  2 Aug 2024 11:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jcrm+rqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A785188B22; Fri,  2 Aug 2024 11:21:23 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C40B881BA
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 11:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRSfWINFd7wzLhvSDr5OQHwi9vLob11O86LTKhTYSUoHfOLliZqc0QZqIfLx5dN9GYdsAJySenAq3mhJP7LElWHzGgPxoXBqD/uO6D69MC1+2YOs96o9Prc4EKPM6tZQBFuLn0VB76xP+eXYcD7+JruYpu/wYQFWJ8lnD1aDz4q7ZRDi6z9iGSFy0WQqiB+1NZ0Q+CuE8Ag/8Oj6FR3anUEzwYg+5wFCDxYJhjpy8BheBwTxK1B6GotgC+Qvo/OrHDW9lK0TF/GAZhlFa2tuoKxPoMQ8MXLE7TMkR8zAjR9aBglCm/nJ8JVxpgm3H44XQW9J+doKhXuoNmsYcqyZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYXfFpGQA4tEcpSJpBonvAhW40E83p8rFOIANeCi6LA=;
 b=zVARn9iDIJgrIQUHBrxaXHzHW0Ygl8kOqOYdc+PPbqSoMVypUhAS9JJU83cZz6giiowePgLltzbNp1l2xGhtFulDjBjFAUX2OiB5227U7WcZH1+LbOrEyRIdUpVjG0/biafkB6D+lGLPSx9KZPZg5lDdkGSGzXsamKUjanhsCR22+OWQkXLH+0fLYayrk5EX5VbMRf73ACcpxbBw625NGPvVqx3+pYOCKDeE/Rxf9pdTel9yZmMKCvT7ETNMVJ5fFWwzsg0pKqsi7RWFVr+DY2bHSxrBJClMCydkWW/Vrt1pUEWAHwhvPDiPGWgycP5pj30PiFwbvZA84Pg4CSp5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYXfFpGQA4tEcpSJpBonvAhW40E83p8rFOIANeCi6LA=;
 b=Jcrm+rqOIn/l0ElOs7vTQc0BJOW140qLSoIkil9dl53rya8dH1gvxcY4m96bV+mynUJpXDWmwgzkYaLAia+39BvmnEHmcyWJxcE1J257e1AjwUsX9pyARepyCx7LQnwBZU9K2E/tmxmQFG+Yw4N9+1hO6PK4gaRBwELgbzf5gsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 09:21:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 09:21:16 +0000
Message-ID: <d388c065-9370-498b-96c8-d22af41d2e64@amd.com>
Date: Fri, 2 Aug 2024 11:21:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] initcall: Adjust the failure message and return
 value
To: Michal Simek <monstr@monstr.eu>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20230822031705.1340941-1-sjg@chromium.org>
 <20230822031705.1340941-6-sjg@chromium.org>
 <CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0202CA0015.eurprd02.prod.outlook.com
 (2603:10a6:803:14::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 2295c45e-5663-46b7-796c-08dcb2d47638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnFPV0lzYmlVOGRIVzJSTnhGTFJtNmp3czI3LzFNRE1JRi9qT2ZxaVZFU04w?=
 =?utf-8?B?TFBKbjY4VkVIeWhPT1VmcEpaWFhyeFNsbE5CR3pDT0RwYWE0WnBCK1k2cmVV?=
 =?utf-8?B?QURwZW51R1dkS1RkSm9ZMGdvWnZNSCtNRTBXcTJzS2gvSmhjbkk2VVFuV1lL?=
 =?utf-8?B?Ry94dVFpVTArQzUrckFSenJTaEpNQmNWM1paWGIzbDNMeFlLUlZQMGlqUThm?=
 =?utf-8?B?dTFZcFdEeThHZEZsUW1EQ2xXRTNMUHpLZkZYM3FzRHFoK0ZtUWl4NEJ5RHh5?=
 =?utf-8?B?WmhXZ29wUXU2TUVOZVZYWkR1YW9lL1VNU3VTVytmQXBnRFlQY3BYamNKL0R5?=
 =?utf-8?B?K0lXMEQ4MktHOEZRSXN6Y0xSNXFSRVNRNkcvV2R6cmZDYzE1Tndyb2RTTkgr?=
 =?utf-8?B?alhQVk5nRlR2RG1JWVEzRndjY1lpQ29KZ3d6a2tVY0dOVU5Jb2VWTWI5dTQv?=
 =?utf-8?B?M1dFM29LalUwZFoxSDNCc08reU1HNFYrR25LZWlEb0NRdzlDTEdxWDVmUHVC?=
 =?utf-8?B?SFhjZ1hjaC9vWDB5OGQxTjMzTmZGdHFTK00xQlNRQWpmelpvdStYRVQwQ3lD?=
 =?utf-8?B?ZWU2M3pyUWtoQ1VkVmVvNjJvdndFNmpsSStWVVpySVQwclJQRkpLMkdYejRp?=
 =?utf-8?B?Q2dXMzFXOHFOUWlTcmNtZmJtOE9OZWZOdEdzcEtPV3dIOWY1ZTdEbG1JcVFW?=
 =?utf-8?B?NE9EbWQ2TnBOL051MXZ5d1FDWnpaTDVyVVFUNVpSMXpiMzZuR1NxVUprank5?=
 =?utf-8?B?RU0ycHVsNnE1UDdKb2tNOGdZNGdpUlBJMU9YSmZFY1JZVDJmQkhnR3ltUW1G?=
 =?utf-8?B?V3BzanNSSzVZNzgyT1psMXFlbm5SbGNiayttS0dvVGtSTzhkK05RUFhZeVRF?=
 =?utf-8?B?eWVyejJ2a3NicGdpQ1JjZDJnRm9ETlhVY1pwM011dFE2eHZ3c2tnUGJHWUJI?=
 =?utf-8?B?NVZJNlZRRjBld3hsWjhkaW5wRnRDbWd0aUdkREdXUy9OdHNsRTA0Z1RpTHgz?=
 =?utf-8?B?MTVHckR1eTJTMFh6RkduOXZnMU4xS3FmaHlZYWZaRGxSTjRKQUl4Nld1dEZU?=
 =?utf-8?B?aFZUOW8rMDNieWlpdE1sQjV4MzEwK0F1TXNmM3VZR1Y0VTZsSk1YSWkrSjlv?=
 =?utf-8?B?RDJkaUxXVzBwQW1yek8yVnBVcHRua2tIVVp3U21OZGxobnFEci9IWUp4blZm?=
 =?utf-8?B?REZaaW9PMkxsQ1pSMDdKY2p2ajNhVG1IdkxyZHNlVjBqOXBuYmhscDZtTDVF?=
 =?utf-8?B?c3NWVnRmdml4cHpEUE5jL0FrNmJVc1h2TUp2M2NPMGtBdEZXaUFXZDVJV0ZE?=
 =?utf-8?B?Sm9MbDBwK2hwVEwzbTQ1NjdmeStXWFJuYTM4c0tneWNBcHlzdHgraml3dW5X?=
 =?utf-8?B?a3FRT200a0dTMWZYeHhlYVhuOHdLNkthcXpYYitzMEpQa2Z2eGFXT2JVLzg4?=
 =?utf-8?B?QUJoQ3VvV3FRcndFWC93akRidUpSdlEyTnRyK29iaXQzQTZEc0RKY3NHaGtR?=
 =?utf-8?B?dkViNlovUU1MY3R6am9PS0FiWWZQOXVpak90NVRDRHN6MkMxUEM5MFRRYnFM?=
 =?utf-8?B?ckM2SjgycG5SeG55WHB0ZlZCQ3dYQ0xBZVp2eW1HaUMzYVlFdWZkUDA3T3Fs?=
 =?utf-8?B?ZjdCRXpHeE5WOUdPZEprL3VQcG5rSkZzbFpNQWpRYUtFTk9CSFBsUW5kSjNS?=
 =?utf-8?B?RHZUWnNSeDJLYTVFZDJEbDJFenNObkRiVHpLUFRrZUV6RXNkZ0ZmaHJkWG1p?=
 =?utf-8?B?ZEYvdkVEcCt5eEhHYXB3MktpZzBzYVRVWDJ5aHVXNjQxMENwLytZUGEyQ2p1?=
 =?utf-8?B?eXlRNXZ5TmFqbk1SR21sQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS94WHZvaXErNEVWQmtiUGtjT3hSUDUxVnZyUnBnYXJKdlRLOTdvMWthdVBr?=
 =?utf-8?B?cVRwQ3poeG9XTEJMaDJhOGF0THUyMkdjUmY0dFBTdzI5MmdOM01WTTkwRzJ5?=
 =?utf-8?B?OEVzbGU4UUt4V3pVTXB3S0NmbnpDZzRuQ0VmSWNKZk5nTVpMaitYSFlIY0Qr?=
 =?utf-8?B?KzlJY0lNMlpESXNsUkVONUh4dG1LTWNPREtiT3RKSjBCb1lrNFdCcWxjMEtJ?=
 =?utf-8?B?WW10OFlwQUFxQXYrUitJRk5RU0hncXNwS01mc05lWS9MUnliN3BkcFBYd0Fu?=
 =?utf-8?B?a1RwUmZkNTVMMStmaWgvVzgxNFphMmV0T2lydTV3VjQ0U3llU3FzS09xYjBk?=
 =?utf-8?B?WVRXMFVVMkgyRzg4Wkl5MUxzVnQwblYvSVFjNlJtREJ4R2NHaFJ6M25EUlRp?=
 =?utf-8?B?UU12dDlIWmFBamsxWlF1ZjYyS0hqaUw1ZmFYMVdLRElyYjc3K1FxTUVlYzBn?=
 =?utf-8?B?TzRMdlJudzVqSDA1aDhLMjk0V0RxSjRYUjAwYldtdGcvRGxtUy8zKzhrRzhX?=
 =?utf-8?B?MlhBcTFFcEkvTVArTk91NGxKRG1HK0dVbXNoZk45VCtZc0pBeGtSbTFiNXZS?=
 =?utf-8?B?VklXbFg1NGYxZG5xbEdmMmlrS2VCcndHcWMwWDdiTlpFaUN4bzNERDBXb2R4?=
 =?utf-8?B?NEZ1amRYSHcxYWU1L1NIeTVLVkt1TUJYeGxMN0FIQndOT2dwTDROemd1OHlw?=
 =?utf-8?B?OXdUOVRWYlBFR3M5SVBWVkxUaGI0VjVISTJhL1o3R1FSVFQ5NVRraUZtb0ow?=
 =?utf-8?B?THUxTXNpbzV4WDB4TmMxaERBZUFYWWlDb2VCOWk4VlpqbFVaejFTVXlsbk9F?=
 =?utf-8?B?T2RqWFRtL3VPcUxLbk45cTRPUjY5cm1oblhUc0FQaWkzSHRXQm8yeUhPL24r?=
 =?utf-8?B?WGh0VGxHTTFEejl2blVwWTBUUzVQTFVibnVUSUdxM3FVRk0rTk5UTStXcmJW?=
 =?utf-8?B?ZXZ3bjRpbTRucHJXSVBndmlvQkt2bEVNblZkbTYxRkd0WTd5TmF3ek4zN2pz?=
 =?utf-8?B?UE9YVWo5OHV3dUxxZ3gwNWwwTHhXS0dPT1k5YW5KWXFCRmh3UmFwTzhPajN0?=
 =?utf-8?B?TjZSVFl1ME1JWFVLTTRkRUdJZ2o0RUQxQ3dweDlTQ0JxWlY5cEVKbnhwRUxx?=
 =?utf-8?B?RkV5TXJVNEFJc1prYmxWdXhDdEJibUx5R2Uxb3dEUHFRZVhtcjdNVU9ZbVlh?=
 =?utf-8?B?UTR4MEJwZU5UckhzUVV3a3hWTXhvSDZhU0haM1hhdVhCWms2RE4xSzNFdjJ0?=
 =?utf-8?B?SmYxUEg0QkRUODRBYzF2OEJTNzlYcjFHdjBaUW1pN1ZCbmxZYmU4WW5OSm1T?=
 =?utf-8?B?dmdqVnVSV1UvT2N4OVlNMXZ3TFhFUWpySkUvMVNTeTV6VEhOc2VvWUpVZGtP?=
 =?utf-8?B?eUVpWWJIWCtHUlRrOHpqOENLc05pbS93aXhIL2NwTVpCTjlBcTg1V2Nkd1lx?=
 =?utf-8?B?SHZ1S1g1OG4zWEw4V3ZKNFc4NlN1dnNaL3hWZ0MzYzhwbENhbHRhZkE0OUla?=
 =?utf-8?B?bmE0djliTldaSWxKVFIwU2tLLzRRUUN3azdMM3cweVFnT25FSFhlYUhhWjRN?=
 =?utf-8?B?RHE5K0kzVkUrQjBMSXgzdzZYdm1YTC9OcFFMM3ZPa2lFZ3JmSDZqcjJPeUdL?=
 =?utf-8?B?d3JIOGgvdklmaDQvMC9reFZIQzVyYU9wTndDamZRSTZKZ0lGSXNTZ2lIazB6?=
 =?utf-8?B?YkVGYTVJYkw3cnV2RUk5dkVYa1krL1BNNkVDWmx1K2J2dXArc1RobXR5VCs3?=
 =?utf-8?B?Q0Z2Z2JwSllvYjJqRzNxakl4RGhiaHNlZ2dacWVhZlptWHlkZ0dVOXlUZDFX?=
 =?utf-8?B?VHVNZkM5NzU2MnduZG0wY3VhTXUzQ2ZuNUhjVkt2UjdQOEJsVG9lTXczd0cr?=
 =?utf-8?B?U2xkb01DMlcrRURjRkZpTmxza2dURjdWM3E2SzhmQ3V1U2puT0R0aGMvVndN?=
 =?utf-8?B?NXgxcFBKTlkrdVN6QWtpM2dsbTJjNVRzbnozdXRMVENueVJ2ang4ZmZxSDNE?=
 =?utf-8?B?WWQ3a3E1WEphSHNtTFhCRUtYeVg0UDQxUlZEK0tMT0R4SnFYZFJON2kyUGZy?=
 =?utf-8?B?dTNXZ0JYWGhoWUxLb3pMSFdnK0RVdmY0OGdjdkt5bXFidUZIeDV3blpTZFpK?=
 =?utf-8?Q?6cm6YNRaQrzlZT6PL3QNqnFkt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2295c45e-5663-46b7-796c-08dcb2d47638
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 09:21:16.8423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r115az9CeBpy16rgXhVafb/Iif1csGapBvno5i6crsiBbK3W8SKYXUEZacmQZ9Pa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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

On 3/22/24 11:22, Michal Simek wrote:
> Hi Simon,
> 
> út 22. 8. 2023 v 5:18 odesílatel Simon Glass <sjg@chromium.org 
> <mailto:sjg@chromium.org>> napsal:
> 
>     Move the failure message outside the loop, so it is easier to follow the
>     code. Avoid swallowing the error code - just pass it along.
> 
>     Drop the initcall-list address from the output. This is confusing since
>     we show two addresses. Really it is only the function address which is
>     useful, since it can be looked up in the map, e.g. with:
> 
>         grep -A1 -B1 serial_init u-boot.map
> 
>     Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
>     ---
> 
>       lib/initcall.c | 12 +++++++-----
>       1 file changed, 7 insertions(+), 5 deletions(-)
> 
>     diff --git a/lib/initcall.c b/lib/initcall.c
>     index 81c5d2450735..0f74cef32f85 100644
>     --- a/lib/initcall.c
>     +++ b/lib/initcall.c
>     @@ -46,11 +46,13 @@ int initcall_run_list(const init_fnc_t init_sequence[])
>                      }
> 
>                      ret = func();
>     -               if (ret) {
>     -                       printf("initcall sequence %p failed at call %p
>     (err=%d)\n",
>     -                              init_sequence, (char *)func - reloc_ofs, ret);
>     -                       return -1;
>     -               }
>     +       }
>     +
>     +       if (ret) {
>     +               printf("initcall failed at call %p (err=%dE)\n",
>     +                      (char *)func - reloc_ofs, ret);
>     +
>     +               return ret;
>              }
> 
>              return 0;
>     -- 
>     2.42.0.rc1.204.g551eb34607-goog
> 
> 
> I am debugging one issue and I get output like this. And I dig into it and find 
> out that failures are not reported
> on the function which is causing it but on the next one. It is because of 
> pointer is moved to next function;
> 
> This is what I see.
> initcall: 0000000008072de8, 0
> initcall failed at call 000000000802b14c (err=-19)
> 
> And this is the problematic part.
> for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
> 
> Fix should be of course to get that if(ret) code back but maybe you want to see 
> different solution.

Any comment on this one?

M
