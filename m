Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADD8CE8D5F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D8218429E;
	Fri, 14 Nov 2025 18:13:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ocgqGsXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA5F8429E; Fri, 14 Nov 2025 18:13:54 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4550D840B3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie4XKwMZ5NSAb18TmAzXbASzIzNSFIfebDj4S3Hjvzxf/fMmMe/xHyI0rH6cfzXcewyhJ9mqk6NwKrfskgJEjOEy04jGL0Vh/h5v2lMvwfcupySI95aHGxIj2jhYn6FPkFeswxBtAv+LtgVZ6Kcrq+VaoGo9aYiI+mrk778fuva6rx4tJ4MHEg64GRmH2qmGlOznrFtHRg2JM2YUta0Qq4XmsV/VtF/pcH38nCWZ7J2+pIF61Y1bBngYKpAvOVMAaJ8YU8sAKfeREOxgjq8LVwlZxbnL9PlpV3tHqi4LX/Cai5PidzF/BMRPTLhODlMgf4/IOCOoJ47rNdpd8ntZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UamOqjPSOjF61IC2Fk1Iw914ZJa4Bpo46twbSnVQf8=;
 b=CgiS0hWPyAKHhPkW+OaWS98UYe4HsQ6VnD0oMyokR9nnRtD/T5dD9DISwD7gzuOsPw76qeKve1xwI01W3DG+1S4crxTBTRHnhqBobpjKOsRHRLaRowQeqVCDeiCgUJN1bNx+KDDCXl6uqKb54PmKd7rMiDcIE0RBf5YAfo9HWmcOjmzvvhbvnuazc37vRy+JrWGH0CuaF8Xsk9+tYNqw7SeVOHG7zoOZFdnqEakrER8KdPqq4GhcySIKg3JTxPXYnjfH5rHjYSIOdEz/kXABFdccWXUrKTyjrHgByOPkYngyjq7NhiJN2ArQsEcICS4QJvFC4YWRLnWU4Dl/VBmXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UamOqjPSOjF61IC2Fk1Iw914ZJa4Bpo46twbSnVQf8=;
 b=ocgqGsXo5PViCEBr1nDJZbV0hDPRhSy9vi0Fz18XUqSJUgYABjbKKmvn91GXqzR0FAoN83iF75SGODEPrVM8SU9ITwDAR6yRm3noQrXzGrbD5LhAmufQmm85qNHd0dtcKnzgBQJWrtfJGA7y8FjfESeXjJSiZeTkst4thTVGY0R5PhbrM+V86V18RajgeEYH/CHk3tdQENzPyu9G0Pk03EoiXkUy/54TWS3XlDh7F7A/EmXWz4GcBOP6zhzLjR7FUYtuM76OGYoXVloV57Q0SwX+8upVbENvt8cXRfnIXauskzdlBJYqIdyaw0nlLsNrAMcHmy1NmmLgdbLtvUvsbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 17:13:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:13:50 +0000
Message-ID: <ae68261d-57ed-4792-b464-b7243b309d9e@siemens.com>
Date: Fri, 14 Nov 2025 18:13:49 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] configs: socfpga: Permit EFI booting
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: b79c2dd2-e3d4-4b3e-3f2a-08de23a12e20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlVTam5qRHAvblpWNU1DQm1OREZGWk1ldnRWQTFyMzF0UitXd0dRQnNxamtN?=
 =?utf-8?B?Qk5WYk52SjZsVlMwVUZXT2V1Zk8xc3VSZStseklKR2hVbXNOaEg0V3Bkb1NP?=
 =?utf-8?B?cERXeUUwZ1BVRXFiREhWaVN0T0ozNWhQVVN4Um5PK1M5bm1WZmhoYXhCWVJ4?=
 =?utf-8?B?ck9BMmN4MnczRnFOT2g4d25hSkI0RzZVTC91QlVzZ3FLZUtYUVFxQmlmR1E0?=
 =?utf-8?B?dWNoLzBSN2krYjVxejFwdWhVN2RnamNWMVc3OUw4TGpjOEZvelhoMW9FTHEv?=
 =?utf-8?B?dlRjOUtwYXBlT09aUmtZU3h2bjJFR1RZZnNneWdUbDI4S3M5VGZtYTJqNVd3?=
 =?utf-8?B?WGdKUTJXaC94YlhocGRGdVZVZG53eVRWNjk3YnY2eGVEY05HNTUra1B6MTVG?=
 =?utf-8?B?UkRaSHBJYjE1WjJwWStlSFNwQ1FvRTF2S0htdTBWb0t3bUdtc1ZRdkdQM3l1?=
 =?utf-8?B?YUJFaThxazVham5FK3FKY1RQUXF0RndHVHYwZWhzcmpIdG1ZK1RCZUtXdlps?=
 =?utf-8?B?NlhIZnZ4azdpb01PT3NpWkJ0WXdXUmdVTDdiamRQWXJkazMwRHFaZUFPdlhZ?=
 =?utf-8?B?Ry9BT2JYeG1UTHg1dG5KZUFnS1d3WXljaTg3NGlhWkh0eENoYkc4RXJFZDkz?=
 =?utf-8?B?czNXdWdrbzIzUm11bnBtemVPMDVtR0JxaktKVG53NS9sV21xSU5FVnM3UHNS?=
 =?utf-8?B?T0JXWWVKSFVWOVZ0eFhKN2NtNzlOTTlkZU1Mckw2eVlmS0NiVzdHZnlEQ0VP?=
 =?utf-8?B?cVlqTjRtcHlVeDNaNzhpOU1DUGRIUG14eENsSngwbGU3MVUxaHNkK3RZWXZY?=
 =?utf-8?B?QTAxZ3BCN1R4ekFweHZwVzBrZVhyc21pSEt4WFlyVzE3U1hjaXhqUmlqRVE3?=
 =?utf-8?B?c091b2hWK29GRDFtMW4xTTU3U0w0eXRYT1BMaXRyQkd4Wk1YUWlxWGlDUTRG?=
 =?utf-8?B?Vll6bDV3dlBjOEQvZmJZVFJ4MnFpWEU3YUJ5Ly91TU5MU1p0cTZ5cFZMNGtz?=
 =?utf-8?B?SCtSVHFjTXVDZmtrRDZ2bjVOVFZhZVl1U0Z1OUp1YzhjUzFJd2JqU2J3RXRu?=
 =?utf-8?B?NGdFN0o0L0l2ZGVoY3c1ZDRtZ08xUUdRaTlYbHlWbG1NN3I0bDNZNUd3NGpx?=
 =?utf-8?B?UkVjVnEvYUpKM1E4L0hMQndOYXZsQis4YXZnZmFQOVlGOG5vUjQ4RGlnc1Ns?=
 =?utf-8?B?RGYrR0tqVFlXWHZNeEVxcEJSVWRxY3FWcVFaV2Rwd29WWXF4QnR0RnIzOVgz?=
 =?utf-8?B?dlE2MjZ6amd2eVowSWQwT1JWYitvK1NaVm9lczR4NmY5WE9MdXIrdlBMMDZx?=
 =?utf-8?B?UjFnVTBKTnFPUnFucjNEZmJiaUZGVEgvT1pCVndvei9zOGxjOVV2Wk9oTTU4?=
 =?utf-8?B?dDVvQkZGd1JzSVhMUzRRK2NRSDZpNE5hWDBlYURBeERpV2FyK0NTMkFsV3BL?=
 =?utf-8?B?ZW1XNklHd0Y4VTFjTlJRMk8xaURSR21xUXl6QnBpcC9XOXAzQmFoM0xPbG9y?=
 =?utf-8?B?UkZYY25oNXZoMXBCSnMwbU1JU0dJNXV0bjU1Wk5VakVEeGZsck1VNG1SeDVt?=
 =?utf-8?B?L3Mrc2VSKzdpQytmR2pKdmkyd0orOUtxKy9LalNxT3VNNVM5VXRsRVNMbjF2?=
 =?utf-8?B?VTcyd2dVQmRGZzVxV3pzMytYaHVNTzllQkRRcUFKRzFpYW95NmViR3hBam55?=
 =?utf-8?B?cHBQWkRoNzJHUzJIOHA0RjN5N2g4V0UzdTZwS3d0d0NhdUZWRFdDajdxOHVJ?=
 =?utf-8?B?L2dDWDM0VDRFOS80c2RJbjdkT2tSNGlnbmhWWDhjS2ptVDRpZkJ1ajNlNGl2?=
 =?utf-8?B?bUdBN05wNktMbHNyMmJGWHpHczF1UWFOdlVPU2YxOTZ6YllaS2V6bmY2SnFq?=
 =?utf-8?B?ekFiRTlGK2F4cEpkUWNFT3h3WFZ4bm5OZW91UTgwZm90ZEQ5WWYwTTRrUmY2?=
 =?utf-8?Q?A42/y/BGF9hxapN4CUE4LW16NEU/XaAy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3dpTFliYVg0UHk1YTV5WUdwNFNxQ2VRZWM1VDBreE51dFFTa3I2cWxjU3pS?=
 =?utf-8?B?UnprNU52VWtPcHkvc0RhR0R3Nmcvb1pPZjR1SGs2cE1Dek9LYVdpdER2ckFZ?=
 =?utf-8?B?b0VuaFB3Q1ZlWWl0Rkp4VzFmbnJlQTZiWmNFM0VQVHIvVHl6QkJRenBvNDJl?=
 =?utf-8?B?eGlRRWZ2NmdsOHFveGhiTC95QzQzOEx5TWhaT0l4SExCUVZRWTZCUjM4eGN1?=
 =?utf-8?B?YWlxVTc4VUV4bURQdTdydXR5OUpIc2VWOURDOWJ3WmZ5UmhkVFdvYUpGeUlU?=
 =?utf-8?B?eGxSWlljazNEYzRUN0tZVWFmS05PYkp0RFcrbWtBN016cXlaRjhKY2pUSWYx?=
 =?utf-8?B?QXFKWDQzWk9xZ01GV08zaFRnV0NUdjdpci9SSldQRkVqNzVzYm5GdDJTWjF3?=
 =?utf-8?B?RUQ1bFlTQ3FMWmdJQjgzVUxXTStwNmNjakE0S1lpb0hCKzNwR0Jsa2d2cjZr?=
 =?utf-8?B?WG1mK3hCSzFwMXRTUnV5cUpQNkZab1hOK3V2b3k4dDJ1KzNXeU1UZDdTRlpU?=
 =?utf-8?B?c3E0dnFWZ3pSb0hsU2tZcUdXc1RHRzlhem9RRlhLekVQUzRWUnZqbzB3T2Zk?=
 =?utf-8?B?T2lYL2hRa3hpTkgxcWViYVJ6VVNkRmprVXArMVgxTFZUOVBXTzJkY0RISFZa?=
 =?utf-8?B?bEJkQldpUkdCaFpDbnRnaHl3aGFhUGFaclM4T0hyQ1ZCK2JVNGFpWlFwZG1o?=
 =?utf-8?B?ejZlQlJvWWlLeHZzTHhpZ0lNZEVSOXRFT0oybHVBNy9zenZ4bk9BVGlXVkJ6?=
 =?utf-8?B?Y3B0VUtkWWFrTUhSR3lwK04xc2VLL3pka3l1K21UL1BGL2xRVzNXbyt1TnQx?=
 =?utf-8?B?OW9JeUZyTjB5WUFxOHpXaE1jbmZpU3o4T0JPaEEwanZoRkN6QVBzb2ozekky?=
 =?utf-8?B?TkUwZTIzN0xVNlgwNmFxMlczbndYcGljSHpnZnAyNkZIUWxtdm9Ldm5obXJq?=
 =?utf-8?B?NE5MSjMrTzdMdTRFT2Z3dVBkNStYZkV5V2hYNFVTYnlTQWxjRS9Kb1czQzl1?=
 =?utf-8?B?T3VYY2VIaWJWRm5ERHUwU1owcEFlY04vbDNyQnFwSFcyYmpBc3h0cHJIaXlQ?=
 =?utf-8?B?RGZDcU9SN0JRNzFNUDhidFJyazVNL0E4RXk3SkpHQUxTdnpMOHZnTFBBeXRK?=
 =?utf-8?B?aE5oR0lyN3RXVnZCakFObDVtQ0U5N1Zlc1dPWk90aENHSnEvQ0VwZG9hQUw0?=
 =?utf-8?B?WTBjQmsvV2tEVE5aYldWVGZzMnhkanFGZzFpNlFMR3Vjb1VleGpKcHRzcUJ0?=
 =?utf-8?B?dVFPOGVwd3JSQ1RnM3R2R0VpN0hseDBRRkpkL2kydngyZDl5TzgrUFUrREZC?=
 =?utf-8?B?eDRMNUI1ZlZiRHlMVGZkZjQ1U1RBWThCRVdJZm9BWXk1REhabUx5NG5LZjI5?=
 =?utf-8?B?NVFjcGVEWXlJc3J4VENJcnVEUmxFT3BBdkJXRmlyV2VNY0lOTE9sWlBMblda?=
 =?utf-8?B?eUpiUjQ1VzlrNHJnNVVZYzYyNzcvSG40dkJxZElZaUp6N1QzT2h5RkpDdGxs?=
 =?utf-8?B?dU0xNjRZVGliMURKZEU1dk5VQklJMVFOTUdKNHduL3VjMy9KYnFvSjh3UFpr?=
 =?utf-8?B?YkMxQjhFYmVTRTVBM1E4VmtURUJqL3Q3OUF3V081RXJyT09LNjU3S0JmQVh0?=
 =?utf-8?B?NGc0cDVhelpSRVdKVGdHT0pqU0swYUExN21FRnJha1EvNEVIV0dJdWhRWU0r?=
 =?utf-8?B?THVxZWVhWm5BczhCQlJJU2VNcTlOaDlaZ2dwSDY5MkZ6MHlkbURFOUJEV3Zy?=
 =?utf-8?B?dEplZHpVZ0t3TzlGNk05ZkFyUmlJK3lIcnlra2hRZGlnc0YwSmRHSlA1b1pT?=
 =?utf-8?B?SGQ4c0Ntc2NabTVlQ3J3dzhKZ0piYXdOak83R2hjM2R4eitsUWRzeVBmay9K?=
 =?utf-8?B?WWRpSmhkSUlTZlNvV01tUFVsVnhORDA3dVIzR0M1d3JJVkRRUVR6OXZpOURl?=
 =?utf-8?B?bkRYZ25JNVRieFR0ZzRqSmNWMXVUcDJBTXYzWHdiYllvM3pTNE9OV1ZYdVZL?=
 =?utf-8?B?WGtDTTM2ZzNmMGhVY0NzN3BrdXQ2RlNsQmVFTk4yMVQ2MmtVL2ZlZmJaSVBw?=
 =?utf-8?B?bVpmVm1RNnNPQURtdFlpcDVhbHI1YWZhZERlVGhJY1hkeGo0ZGZQcHRISTZt?=
 =?utf-8?B?OFRvYTBDQWlMQnBjbk5RN0FqYitVZkp5b05rMVlaS0Jna1ROcXpEWlUyaytR?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79c2dd2-e3d4-4b3e-3f2a-08de23a12e20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:13:50.5675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjhokvDZFu7TddDxl/9+MwDstrvCqp0Zshe+SVxwnxPIwUir2MNWa87RZbwNvQi+bEv1vJnlo81QYk1MtE0dnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7044
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Commit f369e1564cf4 turned those off because the SPL size grew too
large. It also argued that those boards would never support EFI booting.
The former is correct, therefore keep CONFIG_SPL_EFI_PARTITION off.
CONFIG_SPL_ISO_PARTITION is default off. What is not correct is that
those boards are limited to legacy boot - you just need a hybrid
partition table to make both the bootrom and UEFI happy.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 configs/socfpga_agilex5_defconfig       | 3 +--
 configs/socfpga_agilex_defconfig        | 3 +--
 configs/socfpga_arria5_defconfig        | 3 +--
 configs/socfpga_cyclone5_defconfig      | 3 +--
 configs/socfpga_de0_nano_soc_defconfig  | 3 +--
 configs/socfpga_de10_nano_defconfig     | 3 +--
 configs/socfpga_de10_standard_defconfig | 3 +--
 configs/socfpga_de1_soc_defconfig       | 3 +--
 configs/socfpga_is1_defconfig           | 3 +--
 configs/socfpga_mcvevk_defconfig        | 3 +--
 configs/socfpga_secu1_defconfig         | 3 +--
 configs/socfpga_sockit_defconfig        | 3 +--
 configs/socfpga_socrates_defconfig      | 3 +--
 configs/socfpga_sr1500_defconfig        | 3 +--
 configs/socfpga_vining_fpga_defconfig   | 3 +--
 15 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index bbe712f8452..6347090105e 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -67,8 +67,7 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIMER=y
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_ENV_UBI_PART="root"
diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index 1c3664bc0d7..a64f8a3a95c 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -57,8 +57,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_SMC=y
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_LIST=""
 CONFIG_ENV_IS_IN_FAT=y
diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
index 3c860f97ae9..de768269323 100644
--- a/configs/socfpga_arria5_defconfig
+++ b/configs/socfpga_arria5_defconfig
@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index fef4cb90516..2b97b2829f0 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
index 6564cbd03c6..e74f586a010 100644
--- a/configs/socfpga_de0_nano_soc_defconfig
+++ b/configs/socfpga_de0_nano_soc_defconfig
@@ -46,8 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
index 4fabd63f2b4..85b3fa6c666 100644
--- a/configs/socfpga_de10_nano_defconfig
+++ b/configs/socfpga_de10_nano_defconfig
@@ -42,8 +42,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 1c9ecbf2bc8..22eae742fae 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -42,8 +42,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
index 52ed0ff7ffa..bdec0cd2a65 100644
--- a/configs/socfpga_de1_soc_defconfig
+++ b/configs/socfpga_de1_soc_defconfig
@@ -42,8 +42,7 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
index 45d3b2f0807..50176c6f4b0 100644
--- a/configs/socfpga_is1_defconfig
+++ b/configs/socfpga_is1_defconfig
@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
index bff0c41336f..5c0de8ac8e8 100644
--- a/configs/socfpga_mcvevk_defconfig
+++ b/configs/socfpga_mcvevk_defconfig
@@ -42,8 +42,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index 5fe35fe6eb8..5d6f4173c1e 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -63,8 +63,7 @@ CONFIG_MTDIDS_DEFAULT="nand0=denali-nand"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=denali-nand:512k(nand.4spl),512k(nand.uboot),128k(nand.env1),128k(nand.env2),0x1000000(nand.rec),0x3ee40000(nand.ubi),0x80000@0x3ff80000(nand.bbt)"
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_REDUNDANT=y
diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
index fed1dd83dc2..57341a70552 100644
--- a/configs/socfpga_sockit_defconfig
+++ b/configs/socfpga_sockit_defconfig
@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
index a08c7c0d9e0..d61b5007fbb 100644
--- a/configs/socfpga_socrates_defconfig
+++ b/configs/socfpga_socrates_defconfig
@@ -44,8 +44,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
index 7744ff9a888..f4cb525439f 100644
--- a/configs/socfpga_sr1500_defconfig
+++ b/configs/socfpga_sr1500_defconfig
@@ -51,8 +51,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index f3b6cb717b3..60b3a6cc891 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -58,8 +58,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),64k(env1),64k(env2),256k(softing1),256k(softing2),-(rcvrfs);"
 CONFIG_CMD_UBI=y
-# CONFIG_ISO_PARTITION is not set
-# CONFIG_EFI_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_REDUNDANT=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-- 
2.51.0
