Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BAFD1CDA1
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 06:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43ED088EC9;
	Tue, 22 Oct 2024 08:09:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ISuYZUkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF02188F82; Tue, 22 Oct 2024 08:09:53 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E08A588D97
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 08:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaW0GWEtcCsRHuPXMLEfc7BkWlCvwkWVUEI6kmjOiG9wkpcs0D0pOMhD/e5ge+CeO/vRag+eWu0m0MAVToCG8jjm3Smv5mxNOtT/Vt2b0BIbvTFmQ8hoeHmkUhaIrt6OsVwU8prUKZswVFyXcsO+61UqCU3iT8A8UGgaSZq8Ym3iFGCuRhAMNr4ZSl90vXliCG5QzyzIN2QYuAh1leMsdoCUpUZAFg7POq3e6kB9mEYd9RZaCgTN8K82PeWjR2TQ875qImp89rjPyYo30KPtvzng79DhY6x543yUnOQggB9l3g39F2XBVm/GQD8nXKJLiwIVnoRqg3qO+dP37mAw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhnLj31jnnmjKRH4eSfY8iLhrdSnhf4sz3lgwhwlJJc=;
 b=ZifIukYi9FXcAWzKZmMQSHtBJRZoDnSen26GJNxWHDkSiGJBzuOVxQrsAGpehOwym2j812s0ClSkd18dzqLj1/5zyvUXedWbWw2TNzRYdFQYXY1cix9gNyHQmYv2oJazdfYL8lpOdIocoOZtmaF3r3+scCC/0axQGG4c6W/ywCQ5vlBEafXxRCMuegq46+vHI1IEgnFvF06omUwmdyK4h08+JGRCYM9TF0AROhCm324puAN6m2TouhWWEor+HZYH4AtUo4ldRo104Fzcf6ECeqKiFs/8xKpP8PTbFGAqAVraHdMPRNg44u0JLclHIh7sf7+ii+F1y6zNLXhVFL4Jpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhnLj31jnnmjKRH4eSfY8iLhrdSnhf4sz3lgwhwlJJc=;
 b=ISuYZUkxUQXMjp9NtmFpOzH/HB74vwfZOLvuQGrXF1zWSzA9663bA9HpjEpCKGYDgOV4g4ioElJDSPuKm3AQR1D5cYwPlZu+68+Hs8E0zHFDkd5TniC8oa50NZD7/5ikuCYHBNhTISsc1jClOeWzaE3Ea00MkBm/plPhLwGjW3lRP6EP5YAiaKf9pHfEYadDmlTNwhtXqqZHg92XHWcwC3VNKmwSsgI/qznZd+D4k2h0zrB8/qdg2x4JDppmjZUUbjtNiXzIFHjd6NPJuTFUYSEq045IFPyRz3xymP5VS0y4nR1JCbvtbEkbxzXpXjkAnKgLNUhbZz9R9I65t1+t2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6123.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Tue, 22 Oct
 2024 06:09:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 06:09:50 +0000
Message-ID: <39bfa764-452a-4cb2-b4e5-78b44ceb7039@siemens.com>
Date: Tue, 22 Oct 2024 08:09:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] board: siemens: iot2050: Fix mistake in list of
 writable env vars
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
 <f1a4ce2a80a6d49863717f5f4cb04fd48399b304.1728539755.git.jan.kiszka@siemens.com>
 <CAOf5uwm+pKx8o3=AxGcQJY9SiPSDE_2hjRLQuzFgdSr4DdFLZQ@mail.gmail.com>
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
In-Reply-To: <CAOf5uwm+pKx8o3=AxGcQJY9SiPSDE_2hjRLQuzFgdSr4DdFLZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2c0f21-d939-4518-6412-08dcf260231b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFpNSmxnc1lUR2Naa28vQWZLdS9DNmtqRVFVR3pWK3Z2QXdaaXBhdG1BVTJR?=
 =?utf-8?B?ZitKb0hBUkRxT3Z0RVM1UkpyM3FJWVVSbzRpUjQxanU5TEtvYVhWUEZkaFov?=
 =?utf-8?B?VUV2VkVHOTBUcTFsbEVrSUJZMWpDUENZdGNCM0xXZEVINkZZek5jS2p4ZUpW?=
 =?utf-8?B?enZRK3d5dFJlNUo0cnhrdSt6SlBCSjJrdjZZKy9HUHI4ZTZOaVJ6SGZQSzJC?=
 =?utf-8?B?TW9nQVVDaXVFQ2orRU14R2xZaEtDRHIwSnkyOXB6RFBlWFV4dXRZbHpubnBO?=
 =?utf-8?B?NHU1SWFoUlZNOXBIOEsra2o2Y3E5VEROZVpIT0ppcGNTbFBnUmFjbTdIaEpL?=
 =?utf-8?B?L3NWeFpxUWN4TGRNSUtiNGdkeWRDK2dQeE4zWnlSM0NUdUtCVDFaVnZYUzR0?=
 =?utf-8?B?QlhEOGd5eVRvTk5mdXh4SUZZelhqaEc2OEgxMVRIcUVBM1VSTHZVZFR0Mkk3?=
 =?utf-8?B?T1RHQ2NMbG8venVSV21FRnFhaUtEU3lCRmttTmZTSUJEeElCdE9KWEdMZ21H?=
 =?utf-8?B?bUlCVDZ3M0JILzF0R215UjRRSm9kamxJY3ZGMWYrSU1yWHBpU2xMbFRGSjFN?=
 =?utf-8?B?UThiQUNWWnoxU1VHSWIvTTRtc2QzS2U2TXVycTZFd1kyTkZ2aHZyUThMb3or?=
 =?utf-8?B?SXRDQVpPWVdVbzJjZkdaY1UvVllFWjNIckRYYWFPZ2J6MUhaWW96R1dGWkEr?=
 =?utf-8?B?REtTRWVzSG9Fc1VIM3p5NW5ia2pEZml0TXhmcm5jWUlEV3RHdC9LaGpLK0R1?=
 =?utf-8?B?UkpLT3Avb2UzNFVmOUMzd00vaHc1VlBFNFBvcUh5bzA4MUxRWStFckMyMzBP?=
 =?utf-8?B?cTFZSnFtV0NhRUdoOWZsQTZSUmhic2M5UjhZbmhZOG91ZEdTTS92R3ZGL2h0?=
 =?utf-8?B?WHVhMmhYMEtRekF4TDRqUWdYYlFHSTJpZlNqNmF1MGFrTW1MVmt3M3hDTmRv?=
 =?utf-8?B?b1dLbUhlQ0pHbThYM0RPSDFjaEJHalRHdm1rc2o1WE1DdkYrMGk4czNEc3Vr?=
 =?utf-8?B?UmE3Sm5lVG9vRUpoZnNic3Z1SDhrVmEva1lUVTh5UzFPVlVkVUcrRXZQY3RE?=
 =?utf-8?B?bGR3OHFQdTRDMy95ZzlXVDllN1Q4MHhFTFpMMGc3dEVNQzdnRHoxQmk5eGVB?=
 =?utf-8?B?SUlLNUJYa2JuVjZweHpvYnQ2NDQya0dDZm43RWZaNlF1VEJ4L2dEM29pK29u?=
 =?utf-8?B?bVJLY3dGUXpCeW41YWEwblZoYzg5QmhpTU9CR0R1MW43MnBBMUhmRThJMU9a?=
 =?utf-8?B?VWtHL1RHSzdTOXlRbFlXY0NleGZSUVFYM0ZBUWVGWERFRWNQK3NZN1RIdEFM?=
 =?utf-8?B?MC91aVRqOXQ1RHF1RXFlZEFqMi9LQS82UCtRenhhbkJQMkw1cWJlQTBaSXlF?=
 =?utf-8?B?RjhRM1NQZ2FnU2trSU52NWZQVHhtcEY3NUJOQjNWWU9WekFJeHNaZ05NcmlE?=
 =?utf-8?B?Y1ROanhpaE1iY3g0RWU4V0wrcGs4NjFyZHVQU0lqa0VlclI1ZW5ITWE2TjBq?=
 =?utf-8?B?dUtIbTlkejNrZTk1OG1sTnliN1J0d1RBenhPekJmTDBjbTF6NSthVFZxeHBB?=
 =?utf-8?B?RjI1S2pNeit1TFFsbGU4ekkvMXVDU2ZlK0dTQzZUeE9rQTBSSWdYR0VhKzgv?=
 =?utf-8?B?OExiOVA3d20wWEZnY1d2TmxQMVJJN2FKemhwZm82MDdxeE9nNDRKSUZTaHdK?=
 =?utf-8?B?b2NFUVlXR0ZrZ0RBSHB2VWQzbkZGdWlVeXBvU3RuWFdsajMwcm5tSTkxTHhP?=
 =?utf-8?Q?nzleV/0xzBAohsYKy+c497NLJBA2SlEzGuCP50h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHIyekpoeGZyTkRBUFZGSzZBRmYxdk1IbkVLM1c3K1FYQk1Hb1BSTm5JaUFX?=
 =?utf-8?B?M2FvLzhmdWR4ajdzbUkxTjY0a29DbmRRZURVN0ppL0ZZSVJMSWRkU0h2Zjdr?=
 =?utf-8?B?akFpYkdRYmVJc2VjNFFGc3YrRnVXOTg3NDNUaVFUMG4wZ1JUU01vVDZRMkFy?=
 =?utf-8?B?Ujdabi9veS9KdU9pS01YZDBnRTdYS0EzMU1BdjUwUU4zQ1RXSkpoZTUyeCtl?=
 =?utf-8?B?a1dXNGprTnRIbEZNV2JlTm1tWlZWa0cxQU1GYS9pWmlnOHlvUGhReno3M0Nq?=
 =?utf-8?B?Q2hWdlZKKy9TYVBjc01JTnNIODBHTUhxN3FQVVZIV0Z5ZUtNUkJBT1dmLzM2?=
 =?utf-8?B?NTdwYVVYcDVMTkoxTS82UE5YSGZJZzcwSy9XanJJZWtOU1FiWk1zTUJiVDdV?=
 =?utf-8?B?OFlKaTZyQXlwS2JiUXgwVWM4Z3BMQVBZQjNPbUJxYUpjRmdvdHN3TDhhd1ps?=
 =?utf-8?B?MklJSk5DZktNREhDdFBPNkJRMDRmMkpmdFUyV2lIb1hVcUtWdTR4aGxtbUFx?=
 =?utf-8?B?dFZ3Z09IblQ5bWc1eHpabVlPQ1RpVE9YUWNDeDJ0K2hkUkUxb1RqQ3RuQlBJ?=
 =?utf-8?B?MzN5ZW8ya1lsUE5ONDNUT0g1dDhmTGJpazc3V05lMEQvdC9zTUlWWEhmcnhD?=
 =?utf-8?B?elAzdmUyb0lXN3p5aW9xUGQ1d3g2VVZ2ektNeU9FT2VnNmh1MlRFMDN3YXF3?=
 =?utf-8?B?M3dQRjRKNUJuTTJJRWc5U0d6ZGswZnY1bzJoZ1d1TFJyQWw5cmhGNUxmR09G?=
 =?utf-8?B?VUxNdDdkeW9IR2p6TVZMTmFiNUwvbkFBYlhHTG9DZVBvRGkra0NreG5GU1RK?=
 =?utf-8?B?djY4VnkvUkNwUGVCeTBaNlJ4VWk1K09HTFc5KzdxaitXOTFNUWJLTHp6L0VZ?=
 =?utf-8?B?OUZIQ21IdWVlY1VUaVJZTUw1QkFqL0xXOGM0RkNjemZUWVgxQUhsSG1pei9T?=
 =?utf-8?B?RitXNUN0RzM3RGZIbWlKZDMvSHRhZytub0pNbHRQQUgrVm82LzJLS0pJWTFz?=
 =?utf-8?B?KzRrdmNUYmd5SmZFNkVuOVRZQXN0L05XNm5pK1ptQ3c4a1F1eDkweXZZTHRj?=
 =?utf-8?B?T014SXVMQVdqRFBDRWhsL1RQMjJSN1VFWGl0eWVyeS9aK1Z3cE9uTFlJL0xP?=
 =?utf-8?B?UGNvcUVYZWpCem44cE9MNE9NOUlEdUVvbU9qN3MwRVVYUU1ydnJVaGtBVWJY?=
 =?utf-8?B?eWE3MWZrTmZLYlZvRXcyeTRnY0MzSnJLN3pPUXpqNi8rYUpzK1didy93MmJu?=
 =?utf-8?B?NkxFUk5OQ3g0ZVNvV0p1clY3aTNkTmNFLzNUeWtKeHN4REFwdHRXbE52WjlB?=
 =?utf-8?B?ZEkxd1FSaVJ0eW0wMW83ZVh1Ry92SzhNSEU1UUpiNTN0eGZadjJIbStYQjVa?=
 =?utf-8?B?QS9jVHAzOHhOWGV4YmVKZmZoQW9qeGsvcE1oTTdrdmg0WnZkeExLR3dzSWVT?=
 =?utf-8?B?NFhLQjNWaVlsSXB0KzlkRjdGekpHbVJHZG5pVEV0cjV4UnBxTzNOd1Zybk9m?=
 =?utf-8?B?UEE4SWxWbnFWSXlGV2JGaXUrVDFHS25kaDZUbGlnNW9KK0c5V0l1eW5KWUo2?=
 =?utf-8?B?WVgvUTZXWGZLMVVIZVZYRHBaY2JzZ05wSldTR1pwb0tIby9tQUx0K0l2SFZJ?=
 =?utf-8?B?bzk2RkJCUFRqbHRxVTJGRHNKSjFvWWt1cHhEZGVTUkswNTI4ZDg0Sk5sSjVT?=
 =?utf-8?B?ZjkxZFREZnhKcXlKRlljVUoxbSttcFpCQmJJMGd0N3ZuNG8zOGdkQlkxQmF0?=
 =?utf-8?B?VzhYcUN6emRPWUdOQ0YySDZOdEc2cW9jNDRWVHpZcTJmZjRROEpjM2dZOWF5?=
 =?utf-8?B?NkQwWCtQb0hPVDJDL29aRUdWUERoN2VZVzdFaEp5OVphQzJOemZxTTBKZzdH?=
 =?utf-8?B?WlMzUC9WM3RBcElVVGQ1YlpKVjdQS3IvakdDa1pidmhLdEd4THNCY0psS3B6?=
 =?utf-8?B?TXRpaVRDYmJIc2t4K3lYR3V4YkE3Z1NKNVpYM2ZMaVZFMnV0U2MrcUhxZkNj?=
 =?utf-8?B?VzdxUVZDVUpWMG96dGFmczJycG5tWFVTck5ZRUI0NG9RSlBTNkdROTJLYXNT?=
 =?utf-8?B?SWhzVVUyNkRDbjhudDB0dmVEQjE4V3orWnBNSXlVdE1Zdk1vOHE2VDNvZ1lP?=
 =?utf-8?B?eW9mdG5pNEpETFhLZTRNc3JUOGdLc08rdlBSZmhiTkVKWFkveFlUTC9ZYVV5?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2c0f21-d939-4518-6412-08dcf260231b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:09:50.1589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8w3MPQcElU3cv9BurTlt97KTmP58uxef46V5UQrljnJjST9txJIMYEB/tDJKRgIP6IkL4lGY8swc/L/o1EsmcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6123
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

On 10.10.24 08:34, Michael Nazzareno Trimarchi wrote:
> On Thu, Oct 10, 2024 at 7:56 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This prevented to set m2_manual_config - as evaluated by
>> m2_connector_setup - under strict configurations for secure boot.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  include/configs/iot2050.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
>> index 94a9c767882..0f92e0d25dc 100644
>> --- a/include/configs/iot2050.h
>> +++ b/include/configs/iot2050.h
>> @@ -39,7 +39,7 @@
>>  #define CFG_ENV_FLAGS_LIST_STATIC                                      \
>>         "board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"     \
>>         "mlfb:sw,fw_version:sw,seboot_version:sw,"                      \
>> -       "m2_manuel_config:sw,"                                          \
>> +       "m2_manual_config:sw,"                                          \
>>         "eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw"
>>  #endif
>>
> Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> 

Sorry, just realized that I forgot to add your reviewed tags for patch 1
and 3 to v2. Maybe Tom can do on merge.

Thanks for reviewing!

Jan

-- 
Siemens AG, Technology
Linux Expert Center
