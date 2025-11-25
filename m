Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DCFCFD37A
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6975883F89;
	Tue, 25 Nov 2025 10:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="nmTk1ZSo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D103D83F9A; Tue, 25 Nov 2025 10:36:25 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B630D83F88
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDHsZR/IcGuhentIAwyZWPP/VI9kQGbnj8vOqw8AM4MfJ87ffsJTj6yM99vJ1tndT2ZdBlIZowT7PYFXOguBcWlNYPuvbRfca7CZnPak1ssNY6uLuJ9wTvcNS6SZpMsGR4Kvl/OnJespT0pORsibS7niHCFmQ/B/QfqAW9HRB7M1Lv2loYBxd4FQubXISF3zD+m5ztleg+JxFBchFS0SZoH1xTHP/RuqwCKqHM/10XjSaz24aOnnw1p5n3Ly32O0i4V0IXKKRtTrAn7k7mKH7mj4g7SiAZ1Qy2XHLJczaTgT2jLPyJ+BSxyXc7v46ol63in0dSdyrbXuKlqmS93IQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJgvGjjOsEmQdX5H2bNIzpuUpyWrdz1rtVb1NQP9z/4=;
 b=e8ktBH6iD5YH/wejLwla63KvuSNwfSF2Snk1bw2inD7vhRwN1SqtBQ9YB6stxyUTsfXyIFY+f4hKFL1JJIntl4hTFisSmy7mAhO1UqdVjiMTYaxdE86YBK9DKBoDv12pVoMB55Qc277yGwFCmAMSjvdl6eR26PKhi4UDTFUr/DSStEpMi8yPHJJSOxlu8DIsdBaw6zvCTLBwOXhYeutQ3VtUTeMPGUcS100bljriUQs+KKOz1uSzvhsQ6I25uZvSW/RUNM2KLiNGRxPtxb7CGoKQvswVPOyuYjpjNifIq+9JuOh8RJIUbPUIhJjuDDNNWv8EX0SLK3gE1i1TFhd1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJgvGjjOsEmQdX5H2bNIzpuUpyWrdz1rtVb1NQP9z/4=;
 b=nmTk1ZSoL7OwvXv3VzzBcW/m3lrttPr2Qm/4c1pUuAC1qJJPEaOiOdt7eS5N4iSndDkBuKRTtukwMUTrJ7dBI9dvcLK9jRitZmfECWVs2HwTPyDuDe/biVTxaqonvA1HcRiVXSCzq61x50q2Zzh+XnDkqVvmEFnUcT0afmHCYv5/e3xlS+uFJ/16x48RUUVYa67KIe4AoXvgMrXemkncybFXquj9Fhl95KWv1dx8sGTvHvOUPCz9JvS6DG97SueUC2icbG0axuoi5gydwvHG0OhgkNjlEQweifnu7LuJrxaT7JuXQg5jgMTy2fzj6ev3YSQO2QoN08gzF6aK+QfAXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 09:36:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:36:21 +0000
Message-ID: <74bf28a9-dbcb-4bf0-8f99-9239018a94a3@siemens.com>
Date: Tue, 25 Nov 2025 10:36:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Sune Brian <briansune@gmail.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
 <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
 <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
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
In-Reply-To: <CAN7C2SBtyc_i3inaCMBCUr_x40_d1LqEARtb2iJms=rHt2TtsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c105cc-72f6-44d9-6160-08de2c0617be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkRvaGx4WjUwZ1J1T2FZOWZtdTY1dU13OVpkWjdwQUt4RG9zSnBRMGtCVlZr?=
 =?utf-8?B?UVdXVGNyS0szb3Fha2FrckRCUzJGdm9DUTBJRUV3SHpLa2xZK2JuZlRKOWl3?=
 =?utf-8?B?OWVMcm1sSHdqc3V4TmRCcHYwYWNBazN6Ukx3YWhSbEFKYmxSK2FJbUxYUG5s?=
 =?utf-8?B?dXAybmxLYldSZHNHZmdSWS9OWXlEUU1ueXMwOFB3amZVNm5rTGgrcUVDYytV?=
 =?utf-8?B?QlhwTzBWbnBUeHg4OWNmcDduTTBzWkJyd2U1TjhSS3JWa1dMSk5vaXlSbzFG?=
 =?utf-8?B?emlnUGQ0dDcrNHVvUHFMZ2FZMXZZMStNUmwyVHFWOGd0Vm05a0RDRUpwemp4?=
 =?utf-8?B?bTgwTjNaTFFzWElOL0xxQlRqOFFoVEcveDIvTU5BWmJYVzVsNEJiRm5kMFBH?=
 =?utf-8?B?Ykk1WnM2eGtpSlhRbmVFdm90b3NvSjF4WDR2emtDQVo3eDBCdjhUMHNvVWpw?=
 =?utf-8?B?emxwYUt0RUgvaFZadElpWFMzVTNaNFFyUkxBVW16VEJoUzBLcHEwdEpIaVVF?=
 =?utf-8?B?b0ZJVW5lZnBCV2ZtVFVXNTl3QUEzdE5mWi93aTZndXZkZmNlNWFnQ2ZhVTRL?=
 =?utf-8?B?Q3lFU01nRWJWN3lTejFHdkZkTWxMbElWV3lxWmhuWTBEOVpzcGs0VVV4N29K?=
 =?utf-8?B?c3QzdUhxZllXenB4SkZocWZjb0Rqa3VNajdoSG42V0pDS1ErWm1kakdIMS9G?=
 =?utf-8?B?OStXbWFQdWNualRJMTJEZ0ptay9sSUlvaXVHZTRzRDg5aU52ZW5laENzdXBn?=
 =?utf-8?B?c0JOZHhjRmk4WlFDOXoyZjd4M1lERWV4d0xyY3V2T1BldlBkOXdxRmI3Y24r?=
 =?utf-8?B?Y0g2WGIvclE4aFZ3WGlKazFRTGI1REJzV1hGNmVncFRQVVU2amo5ZE1aWXdP?=
 =?utf-8?B?NzdHRnpaYXpNUHdJUFFWT3hSK3RYaXNTUXVuaWRWOTlzL0J6RmdjdUNLOEd0?=
 =?utf-8?B?T0VsbWV5NGJxVm1aTC9IMjlTQzNRa3I3ODdiZ3RxTE5scjI0ck9hR1p3V1dz?=
 =?utf-8?B?Q2hPUWVqbENkUlZwY3pPS0xoZFNnWTAxWDdCTFR2R2xBV2VGVUEvVWhUWWJ5?=
 =?utf-8?B?K2RROW5zSDhqeHFvTnQxWmpmTkZoVDdKSFdzUy9HQUhvTUxmMVBSdXZoNE1G?=
 =?utf-8?B?WUYyeFVyNDRMMlZwaWRKUWxDUFptczlZK3hveXE5a2xJZGxReEVKOEVNdGpi?=
 =?utf-8?B?VjhXbWNpK3V5NTNKWVQ5VE5MeFJwY3VweU5lTGcvMVU4dXFqS0dQY2FJSFds?=
 =?utf-8?B?UWtDVEltQ1NZM3JGdnBiZm5KVjRlanNucDc5N2JSejNUdEJ6L3pNOWoyanVj?=
 =?utf-8?B?MVNoUTFTa2tIQTBJQVJNSUVnZm9HNCswUGc0L0VOWi9jTzFzV3VzK0JvMGFo?=
 =?utf-8?B?b25ubTZ2SWY0UnU3NDNBMENWaUw5TzRFbUUwdEV4OER2dVFqK2FZckdvWEpw?=
 =?utf-8?B?UlJXZXJTMWVuRnEzZm0zN1Z3Z013cG05U3gwMzZHVUM5WmNoemhZWEZ1T09v?=
 =?utf-8?B?bDBxS2xpbFk1RU53NCtCRkhsYy92VTU4Snp0M0g4WTFzV2U5czk3UFBCeFRx?=
 =?utf-8?B?dW1wckdWQ09GR2lGQ1l3bmh4bnZRam5zTG11K2REM2JaZGk5V1FYUVFCaGVT?=
 =?utf-8?B?K2t4UlZ2Q3JCbThsMG1Qam9QR0NzR1VnN2EyVk8xY3JNcWdZQ0JHc2ZzKyth?=
 =?utf-8?B?YXkzaUU3VVdtYk1ZNmxROU5DSk1EUEVOTHZjTm5JUXZDQXB6WWdQeE96eG5h?=
 =?utf-8?B?L0FOYUpsaG1oelY5ZThEYmpyRVFBOXlEUldSQXZtNDZYd1hFYmlXQVM1Vk9R?=
 =?utf-8?B?K2FPVSsrdjVnU0Zpb1Y4Wm9rTGE3TjA3V3Fhblgrb0dOM3h0dFR3QnlNc2lS?=
 =?utf-8?B?cTJkL1lhVnlXdERsa3NtWGxEb0lDSnNHRWxmd2xqcGdiZkFwdWowMHBva3Zo?=
 =?utf-8?Q?gl+7tplRhK/GhW7DA4Cv8ydutEobDY1A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qzl2ZWJXU3k4bXBDV2txSEZ3TEFrZnVicittOVBKQmhHNDNsSEZieHdHdExC?=
 =?utf-8?B?RlJqR1NPcU5CeDJBUUZkakZuL3BaRk5sc0l0R21GRkN1ckVrK21WenZyd24v?=
 =?utf-8?B?OWo2bGxCcVJReWFVbzFHd2pMdUpBYUdVemRhdUE4YUttZk9tZlkxVmRZOUZT?=
 =?utf-8?B?WXJtazNwWHJQL3I4RCtQMTdmL3d2bm9zdlV2bWg3aEpTek1pc3JwREhWZWRR?=
 =?utf-8?B?M09kWnhhSWRuTjBJMTlCMnlvOHYzdTJBNTg4V3FKMEhsdklYdHVacnFaRjdB?=
 =?utf-8?B?aXltR3RtVjJzdmlUWnlkalZ1eU9Ld0ZUVHdVVnMzdmZrSTY4aG9JL3M0blJM?=
 =?utf-8?B?TGdMWHViZVB4N0hXRStab3BGL3U1QzB4K21Eb2RvcjdXRzlNZ0cyRTZ3bTN1?=
 =?utf-8?B?bUc0eU1DVDdSYTNxci9iQXI3L3ZWSWVGYUQza3dKbWU0V01HQzBLTUFqU1p6?=
 =?utf-8?B?dlkwWFI5TjlrWlJqblRSQkpjNURqbW05Z1o3dXVYNlJ1SnhQR2tyckJwQjhr?=
 =?utf-8?B?Y1laMHNpNUtKa0YyRlhKb25lenZzd2JXZFBCakU0bURZYmlxTXVVZXh4S0FY?=
 =?utf-8?B?VkNuTFBsWDdYRmhHcHpOSkRkZUtDRUNMSzE3Zm55UlRNZGhrMldnbCs3ZU9p?=
 =?utf-8?B?bHA2dkUyQUlIY3VyaGN6NWFYdUxRQ1hLTU5JNGY4bWozSHVvaDBDWFF5L0k3?=
 =?utf-8?B?eVN6Ynp4dENjZkx6TGFDWnhBQW8xdXhVQlpPa1NQbW5JajNYT0lkWURWWEhj?=
 =?utf-8?B?ODJwKzRKNFNYTEFIbjdjT1hJb2ROWDQ3VmV4a3ZJSm55aEtPcFUvWlhmQVdG?=
 =?utf-8?B?eDV3STNWSDEzMFIxM25id1NHWnY3cEl4dWZNdzhLL0RWd0IzSEUxbCtWeW1K?=
 =?utf-8?B?Q0NUWktUTmprN0tSN01Fd3dXVGpMYWZWa0hvaW9lYm01MzZrTzBtZnFwMUo5?=
 =?utf-8?B?UDNNTEhHZUdiaE5lQkJqVldZZXBhcHpFdmpCNnBoYlBQa2VldlNjY21jdy8y?=
 =?utf-8?B?YkpOR3l3bnFzUjBEeWRkSzRhZWxTOHhEaTZNTUpiVXBnWFhNM1A0Wk94Zm1J?=
 =?utf-8?B?ckM3OTdlbWpUdUljaEFYdEtKYXk2NVdZNUZmdHNzR1d4em52YWJBNFlEbE02?=
 =?utf-8?B?Qk12U21LNmtwUDk4RFRKYnNXcjZ5aW9IWHRIVGNjcGFpVHgvL094aC9PdmlG?=
 =?utf-8?B?c2dEMVoxN3YrYnpSSnNleEY1ZlJLbmZleitxOTZDYndWQVlPSDZpSmlRUmJo?=
 =?utf-8?B?NFg1WDhSRFU0RWNGU0RVRkxXbFI4N28xTGxLOVE4Z2ZMSS9RcEwxMmhwVUFq?=
 =?utf-8?B?UDFxeTFZZmJWTEQreXlxWERDb0pMRWc5cGRaMmNYdEQyeFpKRldmNXNRSEhl?=
 =?utf-8?B?a0t6aE9RazFoN3JGTkRQL3RoNlZmRzZZaVRaRHVocUtBYTZxaElTZFJiYUR2?=
 =?utf-8?B?REJkWXhpd0NwTmZlQzIxOC9XR0VzK2lNLzNmRnN4aE04WFBpRld1NUMvK1k4?=
 =?utf-8?B?MjNiY2NoYlBDc1orbC9Bek9RVDJ4dGVQR3ZqZnA2LzVHU2hwOCt5TDdVZnlw?=
 =?utf-8?B?Lys0d2ZhV29WakpzaGtzOGNabFdDcHl1N2ZscFRITGJFa25GVlRZOXdqZDd0?=
 =?utf-8?B?WU1iK09jRFdWeUtLck52ZzgrcWlVUzZQb21hMGxCcFgvc2FPRUxSc1NabDNv?=
 =?utf-8?B?Yk1MZVcvR1ViZWVkZVk5UFhUMk1scTc2L1dJbUpMYUk3Q3VWN3FRNmQrdTFJ?=
 =?utf-8?B?RW9zN2k5dEpvR3RmUlBTZ1ZwQWpsb0VTNWE0YTMzUWh3Q3BOUEVlMHdCRXV4?=
 =?utf-8?B?U2VYY3owWEFCNmZDUGJBUytqUTcxcDNPMzE5Y2lyZGRBRXJybWMxNjM3TzZ3?=
 =?utf-8?B?Zk03UWtUdHM0TVNjbWtzeURERThydzBVd3cwUnlCTHh3dFlqVHNRU2NoTTRa?=
 =?utf-8?B?SEdMNnVvaDg1eXMvQk1aWThYVXpTOW1DTnhOaGdjUzgvUEhPdDdiUXBSUTdS?=
 =?utf-8?B?ZUphY3BSMGhDTEhKSE0yZUhLaVEydjRpeWhvczdvRCtZeFZ2cGtRb01YeFZT?=
 =?utf-8?B?dXlNYUUwMEFneTY2SFB0OUw0Umt3NE4vZmwwN3J0bmR1NTJtWHozS3ZoVzZP?=
 =?utf-8?B?MFY0M1JFUUdxWER5cHFWT0dxUHFtelJmTGhHTE9DOE0vdktrL25YVkdXeVNJ?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c105cc-72f6-44d9-6160-08de2c0617be
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:36:21.4797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBwQer/afe27n136RMESbfzAmY6/NvQUEVg13pyWCt3x1osciwtbAtd67QNKSN+6dAD2sFguGpYIXxmBY/mjnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6218
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

On 25.11.25 08:23, Sune Brian wrote:
>> But that boot approach fell apart after the refactorings of raw mode mmc
>> loading and now starts to work again with my patches. Not saying they
>> are perfect, but at least the board defconfig gives something that runs.
> 
> Hi Jan,
> 
> No it did not.
> 
> My latest since 2025.07 built on Uboot not even used what the hard code setups.
> 
> grep -r "SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR" .config
> # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set

That's because it never used that (intentionally). We always booted from
a partition ID, but the old versions had all methods enabled, and that
papered over the fact that they were mangled into something that was
supposed to use partition ID but used bits from the other paths as well
to compensate mistakes.

> 
> I simply used the A2 partition settings on SPL and it booted properly w/o issue.

At least for the CycloneV with DE0 Nano SoC, this was broken. Maybe your
setup was lucky to still work, but I doubt that was by design - see all
the changes I had to made.

> All you need is to split the u-boot.img to fat partition.
> I build this and boot almost w/o any major issue since the changes from
> mixed setup to 3 individual setups boot by "offset", "#", and "Type".
> Still not sure what you have trouble with in the first place?
> So I really dont understand what this is trying to fix.
> 
> Maybe T.F. can have more better comment but u-boot after
> 2025.07 no issue on boot by type=A2. I did not try boot by#,
> b.c. raw type must be sought from first.
> 

Just study my series to see all the breakages. It was never clean,
though, and that may explain working setups by luck.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
