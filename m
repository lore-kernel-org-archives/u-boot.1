Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE23C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 11:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D4D88644;
	Tue, 11 Jun 2024 13:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RFg21oIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7393A88652; Tue, 11 Jun 2024 13:04:15 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 458208860B
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmDe6Kb4wZaGM6xhkbbK0EXiIYc3RHveEVaXMvpzP3ckFbNXjOt7kRVw12UjdJZ9Lb6zS3r6mqep0j1pH2i6lwhggM/Dy87lHR+0hav3DMXi90wXJL8jnCwbggEiUz5nq6ScDVRSI1AnY9fQFQbp/7F/e31r0mUwLQu+sKhT7ju8I8xFIiDi/lJYLcOaGucM1vW6NzgVJFfDtiSzqokGh839WGYRaVGDh5YQLyCwuXR+QSKKJrXn5sSw0ge7btp5y8o3tIn1oKHk7EILQo/0Lxs3vT6nUnmCgXEL2AK5H52tvfNNC8qrDflXC+EvkwK5GTyuAM9DT11EOGTWCUj91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwY1Cm+Ho5oT779D8gOw9cuLNr1eENnVQYhlX9BOCBc=;
 b=fBtci3bScWsAPwWmapS9U6K5O58dYob1MrH3C38MKi0XZrTgR8ozPYQRWCOTLIZ7FkcxQc5ThrhO+poz+Gl0taqZmp+d0rEat3atkYmDnjX+/h3elSEiCkYwJchM3BzVoAeRb+OpUnst7cidrnpPwZV/WaauhVwhq02xYwCkOoxiYtBhKIO+in54TkKuQRZoTkNTNSQi3Q3dMlME8VrmWjQ3khMEmxqJNrAK33F54KxQxbpqWPAH7+LCUD4IY1aA4wJ9gzSKqWyOLG6xU8lUERpL0F4dRMr5tIQXqXDl9ZIxDfRFSDHpwoZlgYx9wC1HTOdnSJy5KQSfvyHCyRH7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwY1Cm+Ho5oT779D8gOw9cuLNr1eENnVQYhlX9BOCBc=;
 b=RFg21oIUIW5LYb+JVc8MP8eWQY5W30KLZIatUcK+27AxjUkt8WfpCwOej49SRHZgsZPp94BkRUnzbWwunExW1pxwiG4uKQ674t+CSfPmq+grXrF43fD3YEJ/o/jNKXB82ysk5Bk3RIpuQ2/ZrgYWqeJOP4mIbQE2A3OyE4fwdaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 11:04:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 11:04:10 +0000
Message-ID: <18705aa9-acf7-4876-ac6c-ba81e61cfea3@amd.com>
Date: Tue, 11 Jun 2024 13:03:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Enable reset_cpu() in SPL for ZynqMP
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240607092608.712996-1-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240607092608.712996-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0242.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db5c269-f35b-489c-448d-08dc8a063821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXhXd0ZWdFUxamlES0k0Y2cxTlYyb3RZWEdoSDUvRDdZM0pXekdKUjFpNnV6?=
 =?utf-8?B?MUMzUFdSRUQxdkVldWt3MFhGRGhBYVJCcFlMWU1qam8zUEwxczhMQVc4YzE4?=
 =?utf-8?B?dzM3UEJhZGlRZHJuZmR6ajBHTFlIRSs4cmh1TWp2STd6VGVyZE12WE52b1F4?=
 =?utf-8?B?S3ltT2d2NWovWGsrUkRZU0xqMW9venJpOXhKUXc0NmlaWkRyOEZjZDl2L1I1?=
 =?utf-8?B?VkZVOVBvcyt4b0RaK3dwM1ZMWnFjWXZuSGphdG93dTdaTXg5YkFvenU0dHpa?=
 =?utf-8?B?Mjk4SGh3N1ppUGhhNUhHRXFYV0hnbEhYN0FTKzUxcE8vWjU1QzR6dk11ZnQr?=
 =?utf-8?B?alA0NDk5SGE5MjlhZ0N4Z09OM2xoWHJpV2ZVdFRZQmlBdkpSNW83Y0Q0dlE0?=
 =?utf-8?B?cEUrOVR3c3FUZ0VkTXhxd2ZlMWhrUWJ4QTJZVW5CbGQrcmtCRTFCUTBMUklr?=
 =?utf-8?B?WXo4ZG1UeW9DUU44Zi9IRndlVjJXUlg1MHRZT2g5Q2srQ29sS0h2blBFMTFT?=
 =?utf-8?B?dzRZWGRmVTNLem1qenA1WGxxRU9kY3dvcXhvcmtGT1FuZDc2c0s1VFRTc0pM?=
 =?utf-8?B?SEVBT3BDRnN1U0wzQmNWRE5JcjlPeHlMY1Evb0JJRjBuYUtEZXd5aXhSN1p5?=
 =?utf-8?B?d0UxV0U1R3c1SFJUWEtTTTFuN0JDSUEzU3ZwTG9USTM2UlBOeDgvWi9tK2sx?=
 =?utf-8?B?OWFlcDB6QmVzeUlRTmNVZWIrT0gvMHhudEhKTC9YWnZ4QUZnRDBML3VmZWxJ?=
 =?utf-8?B?WVFzcUVKaWNnRTN4SDBJMUVhN0xhOVd3RXk3WklhSW95MFppM3lCV05rdkxT?=
 =?utf-8?B?UU85NUtrNmJOK1hEamZKS043aUgxYVNTbnJWYndDZGo3SWVCMitKeW9JWkVm?=
 =?utf-8?B?N0FUK1ZmUjlnTGVjdVdUYk9EY3A2ZXJSOTlJbittdUNxdVVOWldXaThpY2Zh?=
 =?utf-8?B?TDFBbmZVZkR5Y1VZSloxc00wcE9pYlFhMXU0V29WS09hVmYwM1RSQ3ZEdjRs?=
 =?utf-8?B?NnlUMlMxTFRKMmdiRitWdlkvaXpsMHZBZ29MdldybyszT3JUMUhGdHd3blFz?=
 =?utf-8?B?U2FMQ0hURTNoLzdUcjgzeWhwR3lBTlhZVlgxQitRSTIwK0NBbXp2Y3RVRWRT?=
 =?utf-8?B?V01mK0c5NXJxSDNNdjZPWGVvYTJhelcvL2pla0NLYXNrbGQyWWFpUjd6VXBW?=
 =?utf-8?B?V2Z3dnFkOUk0Rmc5M0Zrdk14VWFCMHRjam9NUTNrakNMTm83eWZVcDQ1M1FD?=
 =?utf-8?B?SWo2NEx3Tkpmc0c2SUJuMUw2blg4dmhjaDRnNlRHU2ZpZzVTaTdzSUpqdEZ3?=
 =?utf-8?B?UGZnOElkWEplejlkRmsrSFIxZkNiM05YRzhPVFZ5elJYaUMrRkkyclNHSHly?=
 =?utf-8?B?S21vU1c3VmZaMVYyUnVWVUVXTG5FSkRtVzZGU2poWEN5UjBNZDlUc3FXSXNH?=
 =?utf-8?B?UFZCbmRjWDJKK2RlWEVoL0c2NXhEWVh1MENtZGo5ZlR3UDBYRmJXTThsTmlZ?=
 =?utf-8?B?ZVNZanlWM0thUlc2UGVJVzhhb0VudmZLeVJwb1JPM0gwVVF4WnZMbkFxT3ZW?=
 =?utf-8?B?S3pRWFg4YzJ3aFdQZmpNZkdySExIS0dEYlJjWGZYZ0lsdThTV0puNVZqenc1?=
 =?utf-8?B?ZG1yZU1NSGU0WjNZby92OG9xOWp0WC9RVjZwdEpXdlF5TzhhYnQrSkFtVXlJ?=
 =?utf-8?B?U1lpc09qNnNybG5FY25TalE5VWovOGZvRjlYSmU5NUpSRExUMUlPd0xIS3Z3?=
 =?utf-8?Q?X0+wa9pt8v43bPdfaOCt8wE7zvjBo7ZcBKartDv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hFUWNiWDY2YjJUYmFvQ2JKWXdqUVNPOC81cWFNY0dkR2JvT0NCRkZ0aG01?=
 =?utf-8?B?Q2dwSWJpTHJyUm1IWmZFZzYxeWMxZmhlUjBEUlMyUXNnci9mRHBWTTV1K0lB?=
 =?utf-8?B?S2pyS2d6dzJubVF6YkVweTNjTDR3YlNzVmFhQjdaUGVwYm9OYXFZeGwvdDRL?=
 =?utf-8?B?MVZ6WlRFdXR0SnpjaHJVbzV3cklHbFRsa1pZRG1scG54WmxSZmREdzJaT2ZE?=
 =?utf-8?B?M2doTVNBV1RzTU9MSFhxK2VxT0ZybWNQb0YxWVA4cERRYXlsYVJ6d28wc1pW?=
 =?utf-8?B?TzJ4bFduMC9KdW9OYkliY2dKMVhDS25HdnNqT2RLVXRvbHBTaEIxb242ajRU?=
 =?utf-8?B?Tmp0dlZUUDZqZHI1Wk9QMHk3SlRkcFIyaFU3Uy8yNXMydjY2MktCaGdteGdS?=
 =?utf-8?B?cTJaZUJUSUFtWjRvMEUwdnkyWmh3ZzIzQlJ0aVI3WllmelFSeERiS09MUW5p?=
 =?utf-8?B?Z0lEQ0FkZkVFVDdPN09oTVYwTEVpeitFbTg4ZUhuNDJmMmZteU9ZTE8zN211?=
 =?utf-8?B?Mk10bUFLQUVrNytrZjV3bHowelc5MGZhL1FUVEZXSi9NMVF2VmFnelZBMC92?=
 =?utf-8?B?SmQ1RFNGZVB5bmlBWEFaL2J0NEFiMEZlMTdhWUd5a0JmdC9jMlp1SjgrYkxm?=
 =?utf-8?B?VEhWSzlMaHpST1VXTFBRaWtxNjA4aU5HSWJFSWZDOTRPM2hMcXZZVFFIRldU?=
 =?utf-8?B?RWVRemJ1V1o5MFM4RDhFSnNkVVNRaEk2T2lSMWY2Mzd5V0E2aWZ0TkFZVG5t?=
 =?utf-8?B?cXdTQkJSYVZoK2hmbVAxRXFtUDJoWHpvdy83amhiL0hkdk5YeVVCeGtlRGJp?=
 =?utf-8?B?bUJYOTZaZXB1cGhYRVQrQkRiSlFnL29zQTZIZnZXaFRFVkMxVnVJU05LaVpE?=
 =?utf-8?B?dWN4V3Aza2JlT3p3REVreUc4UjlRMTU2c3d5ZkZLQ3FBWGwvQk1vOUF5TDE1?=
 =?utf-8?B?QkRYck93V2pIOWsrQWFSSlZGaHM3d3R5SFNORWVDUFFJNGQ0bzIvRDJURDRW?=
 =?utf-8?B?ZnE0alRLVmxTdFNvbFZ0Vzd1NW4vVXZjMStHdWE5YTNSNGhjM21ycHhqVldZ?=
 =?utf-8?B?YVI1VnZ3cFZGUnFCNllpZU1tMWR0NzZDMmhIeWw1RmYwcGRDdkx5K3REWkUy?=
 =?utf-8?B?WlUzLzd3YUQrTU52MDdiRjNOckV4TVM4Z1FqYklMdEcwMHcxSngvT3V3dG5H?=
 =?utf-8?B?N2pYaHVTRnUvaldoQStBQW51MU4walpPbk4rUjNKeFMxSW5JYnlFeTIzZWZT?=
 =?utf-8?B?ZXhVam5RSHp1SGV0M0RPRzFzNTNnK1MvN1lXbTB1eVJsWnhCVFhyZTJTaWxN?=
 =?utf-8?B?YTM3cytHNlBrZ0J4WWs2UElUZTJqNVUxb2lrZUpDUVNid2ZEQkRXT2pUbzcv?=
 =?utf-8?B?ZkdLa0VKRmRJTG5BTG1YQlV1VTJrSmVLa3d6LzdRWjN3czVUakVuWDdkZnhC?=
 =?utf-8?B?KzJ4QnRsL21XYlJaM2w5U2NZV2cvQkVXUU11NG1jemlPTTFDNkFUMGtIenQy?=
 =?utf-8?B?QnBEN2ZDT0tlS0VmODRqTW1MRTNKQzk4UHNYNlU2U3BVdHBNWlRuUVJmdmlB?=
 =?utf-8?B?djRuK2JncjJxZ0t1NERJcjlEYnFGd2Q1L1RZZ0NMUmJUeXErM1VEL0M5Wm8x?=
 =?utf-8?B?RkNlcU1ZQ3kvR0lxbStqYzd0Z0ZobnJmd24vSmkvQVM3Umw3UTNqRm1ZaUdH?=
 =?utf-8?B?eEZ4RDhmaW5Pa3Q0SUo2ZktidHo1UkZ5ZmZ4TGREenRmZTRkSUw3ZWVjRVdw?=
 =?utf-8?B?ZGR4U2tKSzhFaFV5c1FxN1J1MXNWcEp3RDVUS2JUbjMzV21UMUZya0N6UzNN?=
 =?utf-8?B?MmU1QzdydUR1cVo1VUg4RFBKTkk3VitBTjgvMWgrN0JoMmd5VTR3QjhqN21Z?=
 =?utf-8?B?MytPb0tzZ1BDRlpheG1BS1ZmVjIyMDR0Qk5xeWZZNjRMNW1CTHZCSHQ2bURl?=
 =?utf-8?B?UUxyeWs4d0w0REVEcml2SzAwZ0pVS3hJY2g2bENqOG1Fb0NkVS9oQVV6N3B4?=
 =?utf-8?B?d1JMSE5vRnN1YjVBNFc1b202K1NNRVZ2ZGVIcW9ubjdadnQ3M0V2bTNRaThr?=
 =?utf-8?B?QkQyMHUybi9WMDdGRW55cE8xREpGT0JIdEI1UW04b0tma1hKV2ZXQkFiL01M?=
 =?utf-8?Q?CbxaXoafAclyTTPjCOYCRoqk0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db5c269-f35b-489c-448d-08dc8a063821
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 11:04:09.8351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3260BMq7Z7soaDd88XfF2quQb1xcwguho+oliwzWZD4SvWWDpP9QD8P9YeRIcOaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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



On 6/7/24 11:26, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> 
> This series enables the CPU reset in the SPL for ZynqMP based platforms.
> This only works if CONFIG_SYSRESET is disabled. This is usually the
> case since the the regular sysreset requires bl31 firmware to be loaded
> in order to hand the sysreset over to PMU firmware. In SPL we can talk
> to the PMU firmware directly and request a CPU reset.
> 
> 
> Changes in v3:
> - Use 'ZYNQMP_PM_RESET_SOFT' directly
> - Add comment on what happens if CONFIG_ZYNQMP_FIRMWARE is not enabled
> 
> Changes in v2:
> - Drop 2/2 since reworking ZYNQMP_FIRMWARE dependency is out-of-scope
> 
> Lukas Funke (1):
>    xilinx: zynqmp: Enable reset_cpu() in SPL
> 
>   board/xilinx/zynqmp/zynqmp.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Applied.
M
