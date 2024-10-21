Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD72D3DEA1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 06:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFFD1892C5;
	Mon, 21 Oct 2024 08:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wQjBLwKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7F1892C5; Mon, 21 Oct 2024 08:21:15 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDE88811C
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+5rB2k8s+jolljPStDRLKkUlITpLSLpdkTIPRPduVnOTrQr26/ReOn1cC/l0WCNpHAsA/p7pcGI/sjcFdPkJ/QS9vStPcYB983WeWOCpYR9RhGE21s/OKHIUKBstRfmMlJi+DC0jN1icgfezLsmRNUV1tMZYGqdBBN4MDgFVPlKra4nBcG0kSpcn4beHCO2DuBLjoiQNspdaqN/vEBXSeWg76ZOJhMkleUG+Bd0InWbwFn2hpxc6SSAo33wC9JkY70FBb+u1zHiNUOztNHspIwQRsATtoKATRY24PvVCDxCM4yyN+tnAau6Inco2y6YHMdBiOZW1nsCzFZxhj6lhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEjYAON35SI3+WmvwOgmN7yhKHeUCk67P2MiAFxOLT8=;
 b=cWw2ca+B7rqD/miWdsQnSrNVulvSsOan2VkstJm1rorfK/Si2CBcP8iOzQrqTVwRIzTi+NYg/ApIbFs+9wpCsZhQikrcS6XqhXMJrhS4J7v9fpuddStUPE/jT9/PKTeBULZ4ZmXpH4g1NLkj+6FtbrM53ypnzYP+2U9T9mzXzWDzUJKG9s3mz//ZDGui8FTTZd1ZqUSXMovADKbMV2ByvgFnnT3DKr8fiJk2CDAMwz4bfd9N0Gbv4cNkhYloeFormpXNGmIFep13wOJ2oJe85oNGLHttl2iKkrr6sR2whkfx2hp8/p+XgUeMClwecj/A50L6tiRhwLqdjnc+QsTE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEjYAON35SI3+WmvwOgmN7yhKHeUCk67P2MiAFxOLT8=;
 b=wQjBLwKQilGzXN6cWyWiCpnkG4NrgL1t1Rugo1U84fu/0ClG9UvkHwYcY8hcxj1yeOq2a/5qrCPnjjeogjLr+Dztj2+/CRizC5HkcfMKy8ZsX1xBB/c/7Lb5wyT9n35Q9xJBzN0SpN2JojvNcKl7tcoCuUACuNwTgc2YF5cQdO4fP5nz9aHp0iYNet5k4YE9CfGzWZq902GMSTA5UcYGfYiB0QSnncDi0BArdDUMJmIKSFHAwiULZ8+Uv+fY90V4BqncvZuL0zSvJeG0AyR+8S2UXt9hTdEooGun4skhGXfADNQYKLwgRlOKX1HCB+vz/ABNP1+kQS48GY5X8juq+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 21 Oct
 2024 06:21:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8093.014; Mon, 21 Oct 2024
 06:21:11 +0000
Message-ID: <2f1ea8b4-f8cb-4393-86b6-766cd6def6aa@siemens.com>
Date: Mon, 21 Oct 2024 08:21:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] boards: siemens: iot2050: SM variant, sysinfo
 support, fixes & cleanups
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
 <20241019141655.GS4959@bill-the-cat>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
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
In-Reply-To: <20241019141655.GS4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: fc78ce2d-bf99-43b5-c19b-08dcf1988ee5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0dKOTFRSVZFb0FrSFdvM2d5cVoyWUp5anNDdWFsTzJYZzVJNXVrY0x5WUZl?=
 =?utf-8?B?ZEhSOGsrb3Z4RjRBVFBheVdTSERDWEl3djY5cW5CRmtNOW1UZDBXOG9zbFA5?=
 =?utf-8?B?amJIakZRZkV3aFZFOWxaVVlHUUd4SjR5R0pCY0ZXNHhrYjkweWY1OCtVTzBz?=
 =?utf-8?B?dmlIQWh4cHc3MDhHcG5ISUxJa3hraHRpRTdNZGlKckIydzRRK1NSbk90QUdR?=
 =?utf-8?B?UDROamtsb3IwcjFsTzd5MVAwZUdod2RiMytQYk9FZ212WG9SZjJSbXM2Z2J4?=
 =?utf-8?B?MHN2SUUydTlFM1JHVE8xWEpYQUZwQlVDRkNXOEp6M2RydU42VUZBSGw0QVNL?=
 =?utf-8?B?MmJHR1RmKzlBVWZJUlhxUktwZFhxS25HNW96QjZMeW9odllEUURzM2VFMUdM?=
 =?utf-8?B?VUdQVzNHdUI4SEhESlI5YmpXR09mK1UyTDhsOUM4L2tBQjJDZWwvT2xFZ0NJ?=
 =?utf-8?B?UTdBVUhzb25lR0xKQkhicGIrZ2dJbHMxVDZYaVJSNTRaWFBHZTJUL1FBa080?=
 =?utf-8?B?NnlPMTM1QzAvd1Ixc200WE5NbGp4WnBUQmVoUUJJME9qcEhidjNZa3hWRXZF?=
 =?utf-8?B?elJ2NXdBbDkxa3d5VTV6N3JrdTBqdHN4RXhSM1VKNHNLYkIvNDhXam1PZXJt?=
 =?utf-8?B?NkY2blVXemhvYTZBZkl0V0xrZC9kOTlEU3BBVXR5MGtzSkVrRktiUXJqT2dH?=
 =?utf-8?B?bmlSZmpIR1NhRUVJa2VWVUU0U0I2THdJbUZKOFBwOG54a3JTWEZJTDEvMm9D?=
 =?utf-8?B?VUxjWlM0Yld1am80eUdHa1hGcno0S2JOb2gvR3RzWnFENldDNm40bnBuQTgr?=
 =?utf-8?B?YmVvaTZDelhUY0NzWFFrWnVCTjJ4d2xObTAzbXJBUXNhbUtNdTJvUmsrUU1u?=
 =?utf-8?B?c3NMZUtlZVBXaENla0g3T3N5QlgzRXBrd1BXZ0JCOVo2VnJLYzJaV1VqNUhZ?=
 =?utf-8?B?N0pNV01Mb1c0alZFOEVDV0FMeGZac0ZrRXI0ZlpRT09pRmhrcHA0dzhld1hy?=
 =?utf-8?B?bVRSOXVaaDBxZDdzemdzS1I0S2FYTG9sQU9WS2h5MGt5Qmw0VUJ1NDA1a3dI?=
 =?utf-8?B?ZTllNHpucWZpaFRKZXNSdloxNTVOUFhPbUF3dGRUZFczSVJ2UnNxUVE3ZkNj?=
 =?utf-8?B?N0VncmE0eHQ4eHNVSldBUEdGRiswTHEvbmM1RUJlQk1MUjJ1Y0VhTUJUN1NG?=
 =?utf-8?B?elNmLzFidmdBUjlXS3lvY2kxVFJqdG5mcG50ZE5Ia0VxS1QxeUxKYS9MR2Na?=
 =?utf-8?B?TmR5Rlp5ajgvVDZlZk9RTUs0QVVBV1hYMGVzaFFEQ0lTSWk3UXdXcHBLTVpX?=
 =?utf-8?B?ajgwVU02TmIxb3h3TlBmVGk0cjd3cUZTVU1Lc1dDejkzT3d3YlRxQUZNTGIy?=
 =?utf-8?B?NlUrNjlLNWFPMDdZVi9DUDA5Rkd2Y095SjdjSlZhOVd4VDl1d1gxT2dCWDQ3?=
 =?utf-8?B?RFBZdmhuQjlvQmRQN2FCWXFiSXZmcU1FR0NpdlZneFdxaTFPeE1MTzVUdXhm?=
 =?utf-8?B?dTlzeUdZZk5oMmRvUWk3S3hFWTl4c21oY212dWR0MEZHa2VXcGVSRWVNN3pP?=
 =?utf-8?B?U0RITnlhYW9pc0RhNnZYNDdvdVJxYWV5RkxyRzUwNDd1OUtxQXliQyt6YmhK?=
 =?utf-8?B?T3R4aXo0RXFyZ0dzTmkwT2tkVWlKTUU3R1pJVzVtT2FPbWRpRzJSOVVUZUEy?=
 =?utf-8?B?N0sydGRxTXovTk43b3RJZDZNYVd3aUtkR1FHWXAyYTVyUXIrNk02RUIzaE5k?=
 =?utf-8?Q?c+nIEqeSTFuAE7fpAx+obeUaR5xkQx2njtfhJ2M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUd5djIrdmovbUlWc25LS3hiSmhnVjkrU0FhNzd2VFIyckRVQUt2MndBR2hZ?=
 =?utf-8?B?QTZDQ2FDSjB6emJDaVFWTStZNlVaTFZ4VVEzdG1vdDVFYzRtZ2RDanhmLy95?=
 =?utf-8?B?YlVRZWFWZXVXdnd2Y1lTTzV6VStUZXgrZUxJQVRQeEVGV3NqTTJoMVp4MFZv?=
 =?utf-8?B?LzVrY29ZL3A1VkJQQ3pGT1pYb05CYjZMaE9MajJMQjcvdWxKUjVkT3BtN1Rn?=
 =?utf-8?B?MXFJaXNyZFl2S1lRbWdhKzhQYUZzaWV5TVR2bzBudjg1VU90ZDBkL3VoaWdj?=
 =?utf-8?B?b2NheVFYdTFFQ2JOcjV6ZGhSMERabjIvU0l1akVDdVlvZDA5VFdDZnRSK1Rz?=
 =?utf-8?B?eXZRZHBmMzF1MWV5WGg2R3pMc0xJSlh0ejdkSkpGb2dRZnRpRithdWowR1Vp?=
 =?utf-8?B?NE45U2h2YnYrVG50VDVicVBjWG9YSkQ0SWc4NVlZMEhVSVd2V1JSa0xaR29l?=
 =?utf-8?B?eVZNSkdJVTdhVmU2SENmM3ppSkJUeHZOd3Jhd2dmQ1ZBc1E0Z21vaDQzNmZr?=
 =?utf-8?B?TnlvZys1NUxpWmpkbUhtaGVJOHFaUkRSem4xSG1Dak44NmZFUTNGSXFWdVRN?=
 =?utf-8?B?QXY0V3ZlbUZUYzBCNDRvKzJQZnJXWWFIWHkwTzBHSWpGU1Jnb0N5d1Nna2tR?=
 =?utf-8?B?MWJ3ZXVHbmZsSldRcUtJYjYxRjlueTcyTzN2UzRUMjV5RWIyMDVWL3VZOHZK?=
 =?utf-8?B?TzcrSWoxMHlUQkZOdWl0NmxIQldKbTl0M0gzQjliUWRlTTd0N2JYMUxGbXln?=
 =?utf-8?B?RU45Q1NxSHlodDQzUkxKcEF1T29VQkMxc0pueXJOMmp3eXNnNkFZbVZFc1o1?=
 =?utf-8?B?QzZRQ1Y5aG1mc3FBQUlESVhpQnM2MW1nbUZmZVNpMEozdGFQbWdNTUkyQ1ds?=
 =?utf-8?B?MTBGSDJMdFZlM05jc0VDTjZPZU9JSVh4VUs3aXR1bTlqdnNxeEhSTk9BVEFw?=
 =?utf-8?B?QlNud25BRkRYbVF2d2dhWit1OUcxRVZuWXR1UUdBUkI1UE9YQjlQa1Irc1Ay?=
 =?utf-8?B?OVJoWkcvTlE4R0plcTBTeWRLZWEzRXFIdWVZQlo4SXl0VjIwV0VCWEJqMng0?=
 =?utf-8?B?aGNTUDNwcE5uZndsUGlEZGpydCtTTUt1enpGR3J6dkpxb2I1azV4aDk5eHZo?=
 =?utf-8?B?VEkrZ2xHaDNDRnl0dkNnUWtxcTFLbkFoRXVtaG4zN2s2VWFNVFBnbGVNZy85?=
 =?utf-8?B?d09yMnpOOUliZ3JFRFd0T3NGT3hYdVVubVBOd25iSFUrN01oZndIUW1TWGpK?=
 =?utf-8?B?SXNlVUNZcW9PODVyZVVTZm1RWjBUR2dGbU1rTUFVNVhwUFRpeE1DdHJ4T3Jp?=
 =?utf-8?B?cndvN24zdThMUWdRdldiNnNGN3o0dDN3RjB3MTRGbnRwSWc0NUFwZ1I3QkRx?=
 =?utf-8?B?dDJqTXQxMm9nbXE4cTRzK0ZpSGRXZHBxMThDUGNncWY3UTVTNjU2MUVRQi9u?=
 =?utf-8?B?ZzJ0bmNvUzkwYnJUSmtSRXAxUzUxeVBJdWlPRkNPS29XUmxmeWo5U3N5cjdI?=
 =?utf-8?B?YUF2bFZ1OFNYYk9xbWxBZVFqdGdESXpMYXltVm96eFkzT01nNVBRMEUxREtP?=
 =?utf-8?B?Z0FjL2R4MmlqQ0R6WEdvTGNZYm9uNXBFVXFkakI2ZDhqVy9QY3hFNWY4TGZD?=
 =?utf-8?B?ZWFlU1o0WGIzUW0rOFc4UVpTdWEzb2I5SWc4NlhmNERkaG9WS2p4cFZlWmlh?=
 =?utf-8?B?eFBwU0NYeWhuZ3Jvdi92V0RkcnpVWHMrSDV2NGhrUVplam1jRGw3QVVhWXpU?=
 =?utf-8?B?d3ZaYVBZU21uU0lZZ0Z5OThLeEZST01iK2hGY293RlEvVHVqMVlaRDRYdzlI?=
 =?utf-8?B?VEhCTmdzVDVaZGQyVDF4a0JlMGp2UCs4SDdML0U3bkE5MkpMSElBT2YxMElK?=
 =?utf-8?B?Njc0cGtGSTJMUkZlN1llYlovV3BzRUJBbUcrQW5QUXd5KzlPUE84aFo1VjVx?=
 =?utf-8?B?SWYwRmNndkVTMDlpWng4cjJvMmNoZ3FVbXhqajhHSXNzVzdwUGsyb0RtcDUz?=
 =?utf-8?B?Si9YYkxxbVVBY2lPcmN4WW9VbDhEdDJScmhka1F4dkZpQnpqb3RZMzRjdU1i?=
 =?utf-8?B?eXhrQXRJM1BMZENSY2FpQ2g0akhDZE4zaHFPdGFRVW9RSUErc1NLZmRaSGpK?=
 =?utf-8?Q?/BoC/C7RFOoyEcIvDGBk186Ut?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc78ce2d-bf99-43b5-c19b-08dcf1988ee5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:21:11.5604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuZYWk3JPlMQm/QrPl880vyW3ZXd8yBqNFQ+2yfSJSBQpWfphlsxRYsQITS6hW7QtoumIDkcuexud1yXZHZhuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8922
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

On 19.10.24 16:16, Tom Rini wrote:
> On Thu, Oct 10, 2024 at 07:55:44AM +0200, Jan Kiszka wrote:
> 
>> This series depends on:
>> https://patchwork.ozlabs.org/project/uboot/patch/a54b501a-9a98-426c-a5ca-faf547411a30@siemens.com/
>>
>> This adds support for the new IOT2050 SM variant, introduces a sysinfo
>> driver which also permits SMBIOS support and switches the board to
>> OF_UPSTREAM. There are some further fixes for the boards included as well.
>>
>> Not yet included is configuration support for DMA isolation via the PVU as
>> this depends on not yet merged DT bindings and another overlay.
>>
>> Not a merge-dependency but still needed to restore full support for the
>> IOT2050:
>> https://patchwork.ozlabs.org/project/uboot/patch/6c201a24-422a-41f7-846c-1ad5b0ebc7e2@siemens.com/
> 
> This currently fails to build on iot2050 on master, can you please
> rebase and re-run CI? Thanks.
> 

You need to update dts/upstream to recent 6.12-rcX. I thought that
already happened long ago, but I might have confused 6.11 and 6.12, thus
did not mention this dependency for switching to OF_UPSTREAM.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
