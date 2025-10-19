Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46A7CCD183
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 15:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C0783837;
	Sun, 19 Oct 2025 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="U4TpGNKB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF65F83893; Sun, 19 Oct 2025 17:43:57 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D9E283211
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 17:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6IY81G7UB5n3KJBGnt/RLzHj9lcI10JeDdUQ6Df4txwjifPaKx8C2zDbxSu6ORFIjLi9pfc9tGm5J/XLrXgYOmkuzy36Pjb9cTAnprw4TF541FURtHPJrRCfzDHj1BEW451Oa6BBO+qB8jsuFvPTQASiAtsXC5r4HUOkSq6L4Y77iu9ziPNgJREkdPaiqJadJ78XECZUUmahkfOVTzjmET22vE6c6iB0McC4GwZvadf4/dS/0k3eFJ0zNS02UPPuUSohm8KF1ZhUoIEA9KEClkOK1QTeh9bJvB+Cqli2yCBpNhTvtIIdyMbbt2sRlOjakBa24/594E7UjsmskXE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XHaH0oxc5aNGVgJ9ZEcLOixmKpbUnwqbf68HvT5pEo=;
 b=vqC4+hS7FfnjwzEQ+gDcD+igHVoyrY6IdJai5Mv0wnXUeY7cDUk0UtoqySDGJc+OTiMDzYtMwMpWjhjtsVkVFWPSgxiDZiFr1L+Z/Jd8R3sbVqEVYcUXPsqgbOhm9/TOfmPxxxxKkcjj0W3pepmdqEYdgpe9KFqnOR0A7Bt+BRAMfQODBnRPNn3CiiEQVPQ4AB/tjt8Ky+I1dLbneG/YZFwLg5PIk5jJbXec/uSI4ASNfiC/rD2xD+9HVDn8L0gY9Rg954juITdGcQbfFL6ePwZ5qGpywevWJu49pnDPdccteHBuOTbzBuKsQF0EtYUiTxiaN9mKKS3ibZwCRSTS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XHaH0oxc5aNGVgJ9ZEcLOixmKpbUnwqbf68HvT5pEo=;
 b=U4TpGNKBOHJ0wU5e4s973EYm0HPdKhKv2dimegbDBrXCv368NWuZRCJEjibdbrW4jd6tToDlrM3xw/n6ZpDtVvdgpKGid84x8h/tb2RPK6b83BJ32klwmPw+Vpj00APMI0ReTKvwteG6HmPxaUFc9y0h2rSoVJgMbotJx7ta8M3LPZvxfzhbpuLbFWV/KibnpLsYAYhKjtjVjsU6HgStnynUutPKr11h8791YpPVSVoaiuLP1/fqpYDutiIwobRWy4OPlYnzEj7qMOpzN6dxXB4+6Q+LePK8UVvlC/Zacz75IqBGAd8IJ6H3n+5jSKeXrzVqjO6FZ9hfm1lSpPSqgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Sun, 19 Oct
 2025 15:43:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 15:43:53 +0000
Message-ID: <ef1e69ea-ff7f-4bc3-a2eb-8d364d1d0800@siemens.com>
Date: Sun, 19 Oct 2025 17:43:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi: Select required CMDs from BOOTMETH_EFILOADER
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>
References: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
 <59fa7090-9ec0-450c-8ea8-ead768d4e345@siemens.com>
 <CAFLszTg5gOP=bNJBBrDsFf-BKYiZF27a0-1t0CgiF6Z0xBD0Zg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <CAFLszTg5gOP=bNJBBrDsFf-BKYiZF27a0-1t0CgiF6Z0xBD0Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: f441b2cf-4069-40da-c483-08de0f264e48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzltMyt5a0xtM2ExTjBDY2NoemM0d0FzaHprbGhSMVlyNTFETEs1eHNMK2pY?=
 =?utf-8?B?SlEvTE9YWlFYNDJibUllQWYzbmV4b09YbHRXY2FUSnRKN1R4ZXdMb0pIUXdP?=
 =?utf-8?B?akFRVlJoc0kyYVgyWkIvVlVpRjZYWEZ5YU9LelBHckZrRGF6bUJMeGVsWTRL?=
 =?utf-8?B?N2pGK1ZhNzJybFM0TG4wWTcwemxUamEwNXlweS9pajAyRGRHV3ZtTGM0With?=
 =?utf-8?B?STZDN3hFRENJbnh2d3pOdG1YZnl0S29LdW55TDRhaFM1RlJoRitqMUo2d0NY?=
 =?utf-8?B?TnUwV3ZBV01Zd0RqamJERHZkMGFjWTdRQXBUTDJpNzJWR0cwejRUV2JEUHd0?=
 =?utf-8?B?OWo1RzBVdnc1NVlzYXRHMEdGZDM1MlRNTG82S0FhMUI2WDljYitNOFVPWjhn?=
 =?utf-8?B?Q29UN3hhZzJOWXNrSEVvM1pzWlYyVDZ3TCtzbnB4VFBJK2RqNnlzNTZPK2ls?=
 =?utf-8?B?bDVady9sYUxXVU03c1RwcTdPSDRYZTRKa3laRGxVbVoydGZBUG1FamRxMTVF?=
 =?utf-8?B?NllMTzM0T25yMUxKM0k3SFVkV2FQVGsrNnVJUStxVW1DTkJOZ0x1M3BZNzVa?=
 =?utf-8?B?N3dZL2VzVG9LU0xwaUMyNEV6NzJkVFo2ekdzeWlWdSt1Mkkrd0JscDdwOEJK?=
 =?utf-8?B?MFV3eFVESXhmTUYyd3RtNHB2VUZpa29aei9MRU9WQUl1SEh0ZW0xTXNDa3hM?=
 =?utf-8?B?WGl4RkxnUjFwZzl3ZitlYUJ3cEJLQ1U0ZWswZjRLQWl5ZmMvNFV4d1plWjBU?=
 =?utf-8?B?b25HakNOSjRUNkNvYTRCbGdRZzdPNW1CeVVhRUJOM3JqNE5QS1NLZUNoOUJD?=
 =?utf-8?B?TGE2MVhFaHUvYjdvSXMzNWpHMlZJUmVDRUlJWWtUUEhneERUYTVIWDRGTVRH?=
 =?utf-8?B?Wlk2RjIzWDZGTnFYMmQvNDZPNnUvL29nOExYOVl2aWNDNXFoUUNMUmhlSmo5?=
 =?utf-8?B?b3Q0OXJvT0ZhUlRyMWthazhvcHdDYXlzeGdSR3lWT2Qwbk9hdTBIbHFBZnVV?=
 =?utf-8?B?aXNMMnVPOUtsclY0NTN4Q2E5bEdySTJLOCtGTW1FQjdTaHJ5NDRIdGlnVG1T?=
 =?utf-8?B?NXlGMVYrRlJjbGtIZXNkUkFaM256VmQ3a0srOHNPbUNHdmFPUkZDbkVqZFF2?=
 =?utf-8?B?Mld6OE9GRzZNNTMzcjBEKzd4QXZFTDFjelI3YUdLWm5TMWFBcVYxeW40MFVG?=
 =?utf-8?B?bnZyM1NYTXcydXg4bFJhRmtra25tdmN6TWNiRW9JS0hkaHFYU1lDdzhQZHo4?=
 =?utf-8?B?b2tMOW5iOVB2WGEwMExRTkFFKzU3RmQvS2d6YzNpN3BMS1BOL2JjVFVONGhN?=
 =?utf-8?B?eFBMTnp3eXhHMTZYcjRSV1NPbXI2NXFtSmhPZXZWMzNETVNMaW1sc2VnNTAy?=
 =?utf-8?B?MkVGWDZrZXZWU1BML1QwMkZLaGUwZUdqaU8yenYvYm16UEtpYUNBbUpQMDEy?=
 =?utf-8?B?QjVqMi94clp3cVFnYXAweVdkWEJreWdCM0IyVDdlNWxrN1lubUhTK1dxais4?=
 =?utf-8?B?QW9PK1lMZXZrbG9lY1hkTldZeDVxTEViS3pCQmhya1kxRUNibC93NG9tajZS?=
 =?utf-8?B?QU5YREYzdmVjN2xKLzlSZWZBUnpJUjNKWmNUT1FCTUVCVVk4b3JMaTVqMndq?=
 =?utf-8?B?bHhkU2tRM0htQWJUUEg0b0VUdjd4b3ZEVEpxSlBYN0RRSUljSFpKdFhJa2l4?=
 =?utf-8?B?TXlMdWpnWG0zdmZiUk9hTE1uSXJORklHY2h6MHNPUTlrdjJ1QWFwT1VTMkRZ?=
 =?utf-8?B?V1lSUE9Icm01WU9xSTBiUHZpd3hFbHRiV0ozelVOKzZBek1RN1gwT1J0QW9t?=
 =?utf-8?B?VzU2bVBJK3BGM0tZOFlXME5RV25QU05tY1E0bHpQdzNBaDFTTE15NEFwdVIx?=
 =?utf-8?B?UUUyYzBDdU5MeENRTmRiL0cwQ3MwNUNMdEFPbmFpWm1PMmh4U1JwSEpTanJL?=
 =?utf-8?B?MEd6SmFMQzNEMThjQ1N2V212bG1WRUJpejM3VVVRTiszTHdNVHlqVEJoRVdZ?=
 =?utf-8?B?MFN3RHNPYUNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW0xZVdjcGFrTmdXOUlZdDlZQlZIK0FNcG9XWngxZkJNenhYNlByYjF0VUV2?=
 =?utf-8?B?RmNuWUZlZlNzdzNkVWRBQWNuQmN1dzV6cE9nbTMzQ3VwZHlTNFlWQ3E2T3Fw?=
 =?utf-8?B?UEp4ZkladUJXMjVxSmljOVNsdFgrVlE5blE3Q2xQOVJtRGI0R1k1SEJMOUVs?=
 =?utf-8?B?emJTUVVKdmNmWUVHT3lsMWs2Q2dUU3dnTHZZYzVQUGpaa0lWN3pCeU5BMXpy?=
 =?utf-8?B?ZkZGSXNWRWZVTWliSlh1MzVXUzJWZ3ZYbnhzVCtnaFVNU2prUmdrSDczcEZp?=
 =?utf-8?B?VDE2VEJDTVBHSUc3SVFpQkZ1M202bHhxZ0k0bXVBZExkb2hWQk03MUUvbFRa?=
 =?utf-8?B?WWphaWRUc0g5RDZDYXNnUVFHb2VNYjNrOW9ZaTJWTlB3SXNCZ05ZQ3AwQ2xH?=
 =?utf-8?B?MVhpcFhYYjgvUExlODRyYkM1TGQ0bkdQTEtzdHk4U3F3eHI3ME9yV3J2T3Rh?=
 =?utf-8?B?OEwvbGdraElEQkUwUnVtajZ5Z1pzME1RVFJLajdPb29vUFJEMTFBUFEvMXRY?=
 =?utf-8?B?aEwzZXJ2NDBuak1hSWMwQm1UNTlCc0lwZXZzc0hKVEJIMmw5eVlDNXJtTXRs?=
 =?utf-8?B?ZUU3NENtelk2VWdKVklkVzM3QnMwVk9ka2RJT0lwc0ZTOGEzK0cwY0dkdmRL?=
 =?utf-8?B?TjJ0dzNZWHBKcEtsb1V5YTlnaHJJYyszR1dVWWViQ2JhenFVSGFwRGxvQWRu?=
 =?utf-8?B?SVc1UFkzTWpHY2pUQmZjL0tZWTFZY0o2NitML1cwTUdRejVCeFIzdlJrK2R3?=
 =?utf-8?B?bmVZRFR0Qy9oL2xRR2w3RC9TVTlTamVJTFFzY0tGWFUyeWNzRDJrUXR3bUpr?=
 =?utf-8?B?Y2lla2lxcys2SU1WZE5SaEdUd0lmV0kwTE85NmFYTUlsMEpsVVdhMmV0YzB3?=
 =?utf-8?B?bThRaS9PNnB1ek4yRWlkOGk1a1hLemRnU0szMXIwUlROTk54L0tVaUZYYkNH?=
 =?utf-8?B?akNwTWNxTnRldk5Hc2tibVlpeW1adlYveng1eGg4MnJmb0JsZE5uc1RIZE00?=
 =?utf-8?B?dUpiQWV6TjJJV3hTdXUreS93am5SL0x6S2ovQXZoUjVhUkdDUmtlNkx1VWFi?=
 =?utf-8?B?ckN2Qi9tdkNFRUtpNXJOVDdOQXBCZVVIZ3dDMlVVMEdmUll5VitEdGZseWFD?=
 =?utf-8?B?aGlaQlNXU0kxdnRidGRwT0pwSW5jUHY5NjRNSjdrbldMVWVCYUp4NHd5M1JJ?=
 =?utf-8?B?ZVRxb3drUFQ1bWF2VUlVVUZtN1EyZlJGNGpFVjJkVk1aKytVZ1d2UG9UUmN5?=
 =?utf-8?B?NlRXQVBpUVlYVTYzSnBWOGdUR0hRemF0L3lhTEVJLytvR1FPMkYrSDJDTWNh?=
 =?utf-8?B?UEZNV3VGZTFaa0tUNGh4SVE2cHBvZVhQUHdsQ0JyQjZqZlhkM0JURlF5a3hi?=
 =?utf-8?B?NzhXQzZvTkpaSDgrbFh5c2ZVdGhvZU9nZDFDZHNodlBQa2IvNVZBQjFMelJH?=
 =?utf-8?B?K3lEOHV1YndNVFVyWkVyVm9hNWQyVnE3b1ZDdDROcHBNV1hvOWpRVkhCSWlH?=
 =?utf-8?B?QS9FVHRkaG5vTDJ2SjNHSXFJTVVBZ1dlNU80c2R3RFRPTkE3bzQ2VGVtSThX?=
 =?utf-8?B?dzNmdFY4cnovVk1qaVJrdVdzZ01yRmtQNXlJdkkxdUF0K0cvM2NvRmRON0Iw?=
 =?utf-8?B?ZXhTeStXOG1sTTVkRnhmdlZEdXNlQVg4dm5URVVjeTlvVnV2WjlncCt1UXFl?=
 =?utf-8?B?S2JKRExwSXpuZzBmMjZuM01yaEhJZ3JCRFQ0ank3R2lBVTZjb0pEajltb1Zi?=
 =?utf-8?B?SVQ2YUtGbG1iL2ZnUEdYR0I0OTlndGM3SlFrblU0R2x0ajkyUnNKbkFGYjRa?=
 =?utf-8?B?cUNlZlN5ZDJ3N29xSDRCeHhIR1hodDE1eHJudjhRWWUvMVoxNUcvZU5ab1lS?=
 =?utf-8?B?eXJhOVZMSmxINnRLd3RUVno0bjFDc2FwRHBQd2xQWEs1VXJ6Z1ArckFsenFM?=
 =?utf-8?B?NmJTcVVYR2VGSldTc0trREEzbnRpUW5DZEdiNGdaaU15R0JGRUdmZzA1TzRC?=
 =?utf-8?B?VysyWUVQRHBoc1RUUk4yWlRoZGhGSVhrcy9LTkxjWGFCWWhhVk9EVnVrL3Z3?=
 =?utf-8?B?TXMxK0lRUHBGMEJFSjNWSUVaM1FXbWxzMlZTRlhqcXArMk40L3JGT0ozV0g3?=
 =?utf-8?Q?Zskj7ydfhJv/zC3qBUG4dT5/D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f441b2cf-4069-40da-c483-08de0f264e48
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 15:43:53.1869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bfpwI+WmM3pnbH9UQ4ldBAxi2SzZjAzLXoyes3YX4cOZamh1D1/jhbAiJNb+NfQG8V5nRRPEFKIM7T4oS5dGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5558
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

On 19.10.25 17:21, Simon Glass wrote:
> Hi Jan,
> 
> On Sun, 19 Oct 2025 at 16:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 20.08.25 07:50, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> There are needed because distro_efi_read_bootflow_net depend on symbols
>>> provided by those commands when networking is in use. Imply is too weak.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> But I would like a bit more info on why 'imply' doesn't do the trick.
> Is it due to a depends being wrong somewhere else, perhaps?
> 

Honestly, I don't remember anymore. I think I tried, and it just didn't
work when only using "imply".

Jan

>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> This obsoletes https://patchwork.ozlabs.org/project/uboot/patch/fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com/.
>>>
>>>  boot/Kconfig | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/boot/Kconfig b/boot/Kconfig
>>> index 54ef7052c5c..2813a39b102 100644
>>> --- a/boot/Kconfig
>>> +++ b/boot/Kconfig
>>> @@ -605,7 +605,8 @@ config BOOTMETH_EXTLINUX_PXE
>>>  config BOOTMETH_EFILOADER
>>>       bool "Bootdev support for EFI boot"
>>>       depends on EFI_BINARY_EXEC
>>> -     imply CMD_TFTPBOOT if CMD_NET
>>> +     select CMD_TFTPBOOT if CMD_NET
>>> +     select CMD_DHCP if CMD_NET
>>>       default y
>>>       help
>>>         Enables support for EFI boot using bootdevs. This makes the
>>
>> Ping.
> 
> Regards,
> Simon

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
