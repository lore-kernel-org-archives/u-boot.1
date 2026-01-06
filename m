Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C9CE9D41
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 14:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C373383EB7;
	Tue,  6 Jan 2026 15:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="EBwWPreH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E82483F9B; Tue,  6 Jan 2026 15:38:18 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96FDB800AE
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 15:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIkCrYz4BQn4GGk9Jvye8sb76PpodkzJiiA5mBpulqery62yPeJCWcfiCFUzVpc7l+60LWmgSXHwyQ8S3RWUDGp1dQcCRYF4t79TovG3KzgzT3UjBlKPYn/JPHqS8RNwof04e5YRKeGJPplQRs1kmLYSIv2PXCHUnQkBxd8FwJLdbDao3fvg114ltrmbX2BxvvClOC6TwKtIfG8wm27J9DfnaaCI4PSWgKdXXPGp70kF28SlXtsmTUalnrdslee8ALNWwyKkNsZoDVjqEgCJHHIn6HDWhWjb7GEis0FGnrXrz9BT7kxpfdKe469AUSqRv2pbBhj/cQj50xbL6gHNUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7PjfST1HY1lZiXLuVdeqAGZ2/k8XfX4ABDMauOGQ/o=;
 b=ylcWPirfesnjtt2T70Z7S+pZmUiR/otCcpnXt0mbzYg1EK1sboAyoCV234OBhvd6tk5YFEK4RIvwAmL32jb3O6feb6HJhuL7TW5A4AtY07TQii8qhcdhNf0tNxqxi5jvoAq5IR5YoIlndoYBJqrOEtIP5wlQDO4oyVgDlqhyvTZkuo4+qqM71TSw5tDAmQ/W+jFcFNt/ydmnpSRYUszxFGca9NY6FdUDwP6/t2r0G+jfZbeV6X973lV7gDYEaYQMdr0k8/BZnSelQOEpxkQH1HaFKE+WjsNMyGEC9n9/O0TSvn2rsH7b0P1ZGPvIGBSQpyz83LUXG/3PDSp8X2XMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7PjfST1HY1lZiXLuVdeqAGZ2/k8XfX4ABDMauOGQ/o=;
 b=EBwWPreH8ZWmNoNM8E5TBD0NWobByIXKCYx2otdb9wQ8N2lZ8NAuJq7rVP5HpxS+TMEzVZmoHqGfxH3NtxlCwSPFlwwgpj0kNwgSEbeIrzvCKZoLj+8DcHuo+r7p2+cR6yb7oXm8c8DLkGBspbhBALMUnz5xas18u8eToR20Q8vq8yA1ZifFGxIL+bOY7RGJ6yO495R2UjkyRfuEjY0KtoY1+VwumcTykur3WpGcCM95vuGRvzVsFhrJRTZ8QR3iD4mu3esgKOopwwMEA98J7452zxWTWFRmvzI1BmmxAZr4C1EUv2ih/YExT13Hz4eYC3n75/z0BxGMaao/a4vSVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 14:38:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 14:38:13 +0000
Message-ID: <15bb48c8-a19a-4c0d-8cce-e886b891b5d9@siemens.com>
Date: Tue, 6 Jan 2026 15:38:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Drop default y from CONFIG_EFI_GRUB_ARM32_WORKAROUND?
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, ilias.apalodimas@linaro.org
Cc: cip-dev <cip-dev@lists.cip-project.org>
References: <c999bfc3-e95c-4a1a-98a2-952ae66959d1@siemens.com>
 <71CC4A73-1141-4B07-A766-98808F082734@gmx.de>
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
In-Reply-To: <71CC4A73-1141-4B07-A766-98808F082734@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8681:EE_
X-MS-Office365-Filtering-Correlation-Id: 105f0c20-16fb-4597-9e67-08de4d313905
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3RLT1dFZWkrZ1pHNkY5STdHbWFjYXNzUk16VmJjMzh5Q3BwSlBnMmZZaHhw?=
 =?utf-8?B?Y2EvZ1ErOWVlSWNXc3UrSW4yNlpuMFJwK2lwekhYaGZuSG4rTFJ6K2R2Rmxo?=
 =?utf-8?B?dFhYUjFlMG5WSEZjbExhTW5DSTJucW1vUWdoT2l5SWg0bGFWUi9tTEU0S3l4?=
 =?utf-8?B?ZHNjSjIzYi83cld6a0lvZ2srbnpYUkxZdDBRVVhVZ2tsVFM3ejBGK1JqVEZK?=
 =?utf-8?B?Q3BPZllPMDdyOTdXT1Q2NTh0RGd5V3lBSnJTOUN4eTVmSzFCZk03Y0h2alU2?=
 =?utf-8?B?N1ZmVlF5OFBlOTEvb2Nkb2RRVWZNSWhDSHpNVlRpcWc2NjEzYkRsdU1hWWM2?=
 =?utf-8?B?c0VIdkpyK21sZVBxRVZ1NEJTTUJlUnZXY3RoaFY0TEk2V2x4aDhaQ1hQOFp2?=
 =?utf-8?B?SHpBdTkxV3I2ZFNvMjhyL3ZWdVE1ZVYzeG9KTVJxRVRLYS8xWEh0RmE1S3Zr?=
 =?utf-8?B?SEUrRkNTU3VBK2V5b2dVZlpTRUdvRTVWV0xCTHZUQytnRHM4M0plbW9jZS9T?=
 =?utf-8?B?R3pYMEQ3dThDbm80RVBndlBVdFowbEQ1MFA5N2MrakFTUkduYlo4ZTJTTTJk?=
 =?utf-8?B?NEhPLzZkeThsUXA2b29iZG5vMGFtQ0NXbW1VdnlkamJCM2I1K1ZNTld0RktQ?=
 =?utf-8?B?cFNFUmsyekpJTzMxV3pSc1N0MHp3REFRZXZQWXJuak0zNFQvdUp4a04xcjFX?=
 =?utf-8?B?WVB3M2Y4WkttbUdBek9yU3ZMSDZYbWxPbjFNWDg1TnNOZDRHNFkxNDRNWnZU?=
 =?utf-8?B?NHdYczd4RTc0YUJzVTJITmxEdjIwUnJrUkpPTENlUGVtb2lGcmV4OC9naFo2?=
 =?utf-8?B?aTVWNWRlV2wyRWZ3ODNJYTlmd2hlZzl5VzlhKzNjTVpOWFcrYmRncHk2ZTBk?=
 =?utf-8?B?TWMrbnNPQ1FZc21rMzZZUDl4ZjVYSW5hSGUxeUJmUGtOWEhtRURodmZ5aWFF?=
 =?utf-8?B?M09abWVnVG9Kazh3dktOelBybEtnb2VKaDhiMDZEYXR1akU0RS9uWVhxbFc4?=
 =?utf-8?B?VUNWazNsVGhPbnZ5UUdaUS9ndnBXRmM4RzZQUkg1eWovVjhpUnNwK0p1Qnk5?=
 =?utf-8?B?ZnlTZVVtNkhlRmZqaFdtVnRnaWFadHY3MkJJQXhTdVFZV1dseXZ6Z3RBM1h4?=
 =?utf-8?B?aWd3V04yWWpTQVIwZHRTdEpNNmowTzgrK3NkbG1jcUcwMWR5S0NURG4yWnVx?=
 =?utf-8?B?VEtYRGpROUU2bnVjZlduQ2VZRXMvWU9EZDl5aHNCVU5HV1htSHU1YUVycjVw?=
 =?utf-8?B?ZlZKanRncWZDcVFtWnpXTUt2WDZZVEE4d1Vza1ZURmZWS3kxcWZTWHJCLzBy?=
 =?utf-8?B?NUgxVCtGKy9RaDhxeWwwZWFZYXhybnJSNFpqeEY1bFc5dFI2SFZ2blZEalhp?=
 =?utf-8?B?cloxNGdnampzSnZaUHJzNmlrdUsrYjFWd1ZMcFZkYjE5TzVMTS9KYU1Ndlpu?=
 =?utf-8?B?QWNueU8vYTZBVkhvQVk0WTVSRkJGWTE3MlFDcjZCT3MxNHM5ajZLckhIcEV2?=
 =?utf-8?B?V2ErR0c3RjUxMGFFQ3ZGQ1VUd0JhbDVwWEVIWSsvbHZZU093UUFmbkp6alEr?=
 =?utf-8?B?RnQzY200QmVBTjNXV0xmVkNveThKZ2R1eUhoc2hxSHU3VjN3eG1DYUxVMlB2?=
 =?utf-8?B?YXlsSGxxakw4WklUb0VNNERDU3ZvVGxmRmJ3MUdjK21UbUJxSUlGeWtuTitE?=
 =?utf-8?B?NWM3S1kxaVJWMlNvZWhqUkh1LzZzRjNwYjd1bHZHZ1dzb3lSOFJZSFo3LzBM?=
 =?utf-8?B?L3dpcDJha2FGdkxCSkkrTTVwQjVFMGs0V2ZSYmhTd0ZMNXhrbHlmTUNUL3NU?=
 =?utf-8?B?L0lqRUw5M3dLcnJwVnYyYVVRdUFPUDZwRUY0K1JMTEoxZjlKL2RWNzl1VU5Z?=
 =?utf-8?B?dGdSVXhxMHZLb0xqRittaXJHVlp1eGVJWGtVR1B0b05BaER0YmMxMkR6T3Va?=
 =?utf-8?Q?PV0PDPmZ90TMTlhcuxszYIXHNOjBErVL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlhFdlNGYlNUeHlkVW1JMEROdVdHdmI0QnpCSVFvWm0xY0xsNXh5NUdnNEpz?=
 =?utf-8?B?dmxFVStGU01QR2crSEJ5dnVTeURndHUyL2RJMlVXL3Z5VHFBbm4yN0hVNzBu?=
 =?utf-8?B?SjNSRnN1T1hYS3kzRytycFpFNjl0eGwvM1AzcjZkczZkY1IrYXRjSVFUWm84?=
 =?utf-8?B?UkZoaVJ2R1NlMm1hSXRvNENzNGR0RmR1aTBUVlJ5SUgzOGFSaXZpZDM2MUZ0?=
 =?utf-8?B?Tk1qR1MyK0xmNDVubEVmS3FsQmtiUi94RG90QUlmVjR6eTdiVjdNRjJwSjVY?=
 =?utf-8?B?UHVmL2I3R29xejMyR3BPTCszMmtmeXY1L3NlbnBHelRQaDhvQlM4dk0yWVVS?=
 =?utf-8?B?ekY4Mm16LzN6eU1CRnVmL3I5TFNZNHdCeXZLdHBzK1Y1M0QzTmtySlJXV29X?=
 =?utf-8?B?ME5vS001b0Rydkl5aTlmYStkNDk0bU5DRHd5cGRSYTROZHJVYjhWVXJBQ2Ex?=
 =?utf-8?B?aC9jOEhTbUhiUEFCdmFMN0lMWncyYzE5clRiVnkyVFVTTThIMzBWNVd6UGZz?=
 =?utf-8?B?cnRzdWpicTVLV2lSUlhOK2VXamdDMlpSamZXZUdhY3gyMDd5RElRM2k0dnBF?=
 =?utf-8?B?OWxuK1J5YUpyL3JBK3l1dWcrd0ZvSFJDVlBTZGFPVEg2a05mbjYrbzhweDdo?=
 =?utf-8?B?U3F2V1JIZS83QnZucWVqT1JWQ1R1MXhOcGtOczYvWCt5VWZ5QnF0TVpQUWE2?=
 =?utf-8?B?YWVtTng4eDZJTVBobFgzdGJ1U1JSMGZCOFFXTk1WVkVma1FsMjNKczRJMHhk?=
 =?utf-8?B?VVlnMXVIMXZJcTFaa1pJUS83eG1PUWw4OE9RSUlnenZzQXdxV2kzSkw0QVdC?=
 =?utf-8?B?TFh1WUZ0YjBxQjNPZnBXU2xqNFFBQmczVHpCWUpVL04ydUFOVDJWUmJWeHND?=
 =?utf-8?B?U2FYN21ZZ013MXRaaDdaNUtOcEJ3K1pwSEdmQ1F1VmJpcXhXTTA0WDN1VWNm?=
 =?utf-8?B?cCtuYUorT1FWODNpNzNqdXpUQitML0k2cGVHQkVFa0U4ZkYrR2VSWm0wL2cv?=
 =?utf-8?B?d1FPNk5NYStib0RoaXk0eGwwLzF1V3FGMEM3VXJDTjFrVjNNd08vK3hFbWZM?=
 =?utf-8?B?YmM2M2xWMksyeElUWUpPSG9nWTFudTRpbnBzSDRqUkM3Z1JCZU1wUDkrNnJ1?=
 =?utf-8?B?QzhnM1FqOHZHZ2d2bVdjOU1TR0hYNkVPc1QreWtLS3IrNUZweURWcEgzRENq?=
 =?utf-8?B?ZU55OGpVWDRUM2xQL2puaVNZVlZlM1pmR09nb2FNdHhXU05CQkQ3TE9CTVdI?=
 =?utf-8?B?eXBlS3FiT0FzUkpuTGd4SklIcjdUMWp1dlV3RTdnZ3JqTjJGaUUzOVpRTkdO?=
 =?utf-8?B?SEt3Vk80ZDlhbmRBeDh6UFdQM0p2bEFmMEZOK2VPMXlLaVErbTZKckwyOGs0?=
 =?utf-8?B?VU5MdWVKbUtnN09rTUovSmxkU3BMVTNZRUdtam1qVWtZWStDS3RHaEVrbnJO?=
 =?utf-8?B?dHpkTUYxVCtHa3BXMXUxU25tUDVlMzA2Z1RFUFhOdWN0Y3ZGVGpSN3BMSHBr?=
 =?utf-8?B?WlYyczZYRjBxYlh4QmJTMHM3dXR4QVJ6b2tLRlJMUThGTVZhcUNjUUpIcUpF?=
 =?utf-8?B?NVc3Vk1BL0ZUOTJZWEJRWEtIMEp1ODQwYlJ5eHdzOFlQNXBIWUpRTGxVUHZW?=
 =?utf-8?B?ZW01TldIU2lwTGh5ck9QK3RHM3I5dktLb0NmR0xoRXdxK1N0S29wdUI3UTh0?=
 =?utf-8?B?Y2pmTGkwb0F4a1FWWDRxeHUxV21YbGR6cGpkWWxCVkVtbTVCeG5UUEtwU01T?=
 =?utf-8?B?L1Q0WGN2YVl4cTB3cWVHWXExZGs3ajVlTmg1M0xHcTVWVzhmZlE1WnV2N25j?=
 =?utf-8?B?Z0RiMFVwSHVFRG9pQTYvVFkvb0EwMVcrM1c0VndRUGVLazdpclkxUmU0aU9s?=
 =?utf-8?B?eHpMR09PeFhDbm91SlJNNUJDOHlzT3AwK09JMkhkOTFYcDZFRjZHYUpPZ1dF?=
 =?utf-8?B?YnRZdEJEdjVUY3FRM1IwVjlXUHlHTXByZkxsbW1lbEJib0szejMxUmdQSmcv?=
 =?utf-8?B?OGlLSU5rZHJzT0c4S2h4RklXMlVQS2Q4UWcwZjQ5bHhXd0U5cnk5T1ZweGpL?=
 =?utf-8?B?MUwrMTkvblplMUhXcWhkaTk2SXdvMUVPamZSSGp5eXdZRWVIS1kzYVUwSmcv?=
 =?utf-8?B?L2IwYWhFOXBCZzZIcG1OWCtSenhnSTB6SVJ3VGtTcDFXTnBOYnI2NXNZaWc5?=
 =?utf-8?B?RlNRRzVUMW5kc1RmOWFyQWhyNmRTK3BpZXphY25IZWk3OFV4OGF4dmFjWVVY?=
 =?utf-8?B?RHhaWVBhdkhCOVdjdXY3cmd1OHZLd0Z5eWpTaXpVSXl0QUI1R09XNUJmNU53?=
 =?utf-8?B?aE41bjNMTURVTWhsQlpKbnQ1VTBjR3lZTis5Unc1RzVpVU1iNU9EUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105f0c20-16fb-4597-9e67-08de4d313905
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 14:38:13.9510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnViHHL8t4+6w35cYSsz9Tw4O9g7GqfB8wnA5Wo0CMMriOMTlkYXbFKXCIT7KDAk/4L5DG3sQK6lnvOLdpnoxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8681
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

On 06.01.26 15:30, Heinrich Schuchardt wrote:
> Am 6. Januar 2026 14:47:30 MEZ schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>> Hi,
>>
>> it seems that some kernel configs can cause problems with the
>> CONFIG_EFI_GRUB_ARM32_WORKAROUND. Namely, 6.1-cip and 5.10-cip with its
>> current defconfigs [1] no longer boot on the BeagleBone Black (other
>> boards still need validation), both with the more recommendable
>> systemd-boot and grub. I do not have the motivation to debug the reason
>> in the kernel / its config, given that everything works fine once the
>> firmware behaves according to the UEFI spec.
>>
>> Meanwhile, grub reached 2.12 now which is far away from the old, broken
>> version of 2019. So, should we rather make this workaround opt-in in 2026?
>>
>> Jan
> 
> Hello Jan,
> 
> Looks ok to me. Will you send a patch?
> 

Can do. Just one follow-up question:

"This workaround currently is also needed on systems with caches that
cannot be managed via CP15."

Do we know them by name? Should we keep the default for those?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
