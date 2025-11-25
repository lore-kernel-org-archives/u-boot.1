Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D2CFD315
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 09:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C0B83FBD;
	Tue, 25 Nov 2025 10:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="AwTxt1cS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2A783FC4; Tue, 25 Nov 2025 10:44:21 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A3883F88
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 10:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvZezoms1SXYgfogNQJqrVIPvKYoqwcAYI7DUra81el/m9bWMjj/GwXPZv/XS2qlAZaCrnOT1kVlsDE40UYzFmGMKjJVAIAp22LGRMoG57D24Uh6ZGtI+1Npah0Ymteu/0AKbjkDwVfXS0RkFz0t0Z9qmh7J5Ht2kUdnjFueBZmzoCRBMgYsoMnXYTcGi3UfZFg78hhEg+/Jo0U6CRkBRfj0HHEVlZLiJlovWI4y92udsJ1pqEMzIG+v8nPqTQXpqsHjjUbLUwhV/PRIIDAsjhEZHQZDCUUsyG4hjmvuiBRd7JsMnlceUlb/kSL9lI6/wzsM080WgfXj/iv/M+lKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E7J9ZMp5GalC78LWVlGFpmkjVr35kRvGNmkgCNSUVA=;
 b=FSXGzdKIYOLyzkG3Ik/A48AYY+gC5hwBX3O0+CmUGr6bhUa6nZ5t1czfmpwBZSWxi3ARf8Ae+7DD3Qn0YfjdCC2R8rES2zOs2MwC5SJ/tbkYOkajpQkT79Ynu67mISbjkioioadFJoALMCIxIsHlaRyAQmDw6NWIY26YR3Jr68N5ARUyV2otkZLbZ+IpDshf1I/pb3mmZpLbdlWapuJ7fqUCVe5UlEc/DtRodY0+uP1DKMOWnp/OnMHx8BDAMH7Y0YnvsD2VSzFwT/r9+mkHSnHT6R7lukYQfXf3LrqiIQ76GJ0+KukUf+e54DCNUz6if/uQds22qxbKB9qSAY7RyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E7J9ZMp5GalC78LWVlGFpmkjVr35kRvGNmkgCNSUVA=;
 b=AwTxt1cSMTLb/R6FBkRMQyctP38nKU5KBp71YV879dynylQL8kIxY445HBzbxvkMVXSI1w3HyUHIvKiZiK3iWnSc+xIsWsiwk+3LFyO76+uLmVXl38RwzBXyy2nAoMLYjXueDz7N9wQa+ddJRM3GdnxTVz5qjXA/qDVn2j/tH2lmPyJE4Ugc4Hw7XEmoB2lfnplwXf+aR68tZ3NPERKKAgPmTUJKNs4w4XZ9z80ma0MqqMdGdUE/axrnhfNANvfDKPoyihSzCERR5dAgtP/o05xpwBHTZlG/OcU8Ww6e9KdmDEEMOMA+cZ3QNcpNG8RLL5o6eUjtuPVSC6vem7JhGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 09:44:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:44:15 +0000
Message-ID: <808832bf-e185-43f0-89ba-58941d2535c9@siemens.com>
Date: Tue, 25 Nov 2025 10:44:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
From: Jan Kiszka <jan.kiszka@siemens.com>
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
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
In-Reply-To: <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7c1026-8cfd-4530-fdba-08de2c073283
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yit5VksyVStzZCs4eVNpUGNMaWRIK1FyZktGVUQ2UGxPdWZYRi91eFZlOFYz?=
 =?utf-8?B?cDJ4cGpoOWU3TWNNN3BVM2hrd1A1Y1BHV2FGL1pJemhJQ1NaUExLMlVtT1h1?=
 =?utf-8?B?K2paSGxGeXhHMFg3MXlnSmJuUXlTTmJqQzhIT0o0V3lXaE1jNUZ2aG9FcmxF?=
 =?utf-8?B?UXhOMXZsY0JsQWpDeThydFE0Yy81V09oYlR0T1ZyU3FEeGhPMmZFQ3EwcWU2?=
 =?utf-8?B?RFFYSjEyeGZZQ1FMTlREZGhST1c3VDNmbHhnS1c5U3VJMDdXdjFySGpSS3pG?=
 =?utf-8?B?ejg4a25hdVhKZ1VRRHZ0azBTVi8xZUFxVEF4RFd6MjhjMjhuZGVheW8yRnhQ?=
 =?utf-8?B?UWRWbHFOYXU2MmFGRXY5RTRKNzNtTEZEYTh1b0hHN3VGcXdOb2diamlJNGZh?=
 =?utf-8?B?enJjN2VxTTVkemtJSGN5WUpYRTRFQytQbW9sVTE3emNqcE5yOWo5My91eTZ1?=
 =?utf-8?B?c082eXJIaityM2V3c2MxTGZ3c2F0bmQ0OUk3d2lmbXlzWEQ1Q3IvUG5GVllL?=
 =?utf-8?B?Q01GWXBVUlFNQTJRR09aYkZDdkxybmwvSm0wWHlmZ3J0d1YwbnFmMW83aG9S?=
 =?utf-8?B?T1MzZ2YzQlVJSFZ2YzhpTmNvNmRYSzg2OWVtcXlCQ3Zib3pIM2xHNjNVeHoz?=
 =?utf-8?B?eng2Q0pwUUhMVkhQbE5xeGRGZTJCVnJVYzRjSW9pbG1oVVVBTlJneEpVTzlF?=
 =?utf-8?B?NThTQ0t2MkFXNlB6eFF3KzY0QzBOVDNUVDVYaWxmcXAwalVpSWRQYi82K0U2?=
 =?utf-8?B?QlJQbXljR3FweC8vdUx6ZS9ublIyZmdYQjZkenhGUmpjaEd4Z0xEbWdqcmxR?=
 =?utf-8?B?OExLNHlMc09NVlBEUVN5WnpEdlZidnNNdVRxZ1krb29JYU5WMC8rY1BIU0py?=
 =?utf-8?B?YmM2RFFVbTFxMHFkY2xYRC9ObHNXbWxTWndNZy9tZ2xETUJRNEgvRGlSQ0lU?=
 =?utf-8?B?WDFNM01sdFMvTmVmVG9uTlBlMVVKcEtucUUwb2VDbUJLdjRsNDNzZnR4UjBT?=
 =?utf-8?B?a3NCay9RR0FtYytqT2pWem1JRjJqUVNJdDJlWTh4T0s2UENOV3AyaFVlaFJT?=
 =?utf-8?B?UjE5dTcxVk13MjR2WXE0M1ljWUpjVXRKNTB5Z1kxNklhNU5RVHkvSjBScWVx?=
 =?utf-8?B?dXVpcElRSFVFaS9qZ08rNkNUaTI0RU9QTzQ2WnA4SXBmSjdJbDEyNEcwTUwy?=
 =?utf-8?B?Yk8yeEpBNWpBT0ZVek0zWndoNGpDVnk5Y09qanhyR0pYSEphVHQxZUNkWWV3?=
 =?utf-8?B?anFwWHRGMmpUSnJzNXBNLzg0eHlad3QvMkcydE94Mlc4V1JwUEV2Q2lheUo5?=
 =?utf-8?B?emNENG1IaU1OVng3cDhReFFLN1RZRjBscDRmUjVrQmcwaXNaRlJObDdFK0dE?=
 =?utf-8?B?aXQ0RGhyYXJTNE9tMEpac0hSejRHOGZPN3B1VFlISWt1TldpZkpUeUlWbUdG?=
 =?utf-8?B?N1hobGIzU2N5bDFteklkVmxBcDRoTmIwVWJLeHlncitRSThDb21ZcnJJMWVt?=
 =?utf-8?B?VmJVaFFLM0RHQVR3VDNnQzNRVGRxaFlkR3l2cFQ3b2kvSmVCazhndkY5L1p1?=
 =?utf-8?B?NDgycHRHS0xwVC9XM2ZaejhSU2hSR3RWWEtLMGJWVE42dEtPZGRoeXRDS3g4?=
 =?utf-8?B?ZUt3cytzQXdpNHpiRE41WjBPYmdKN0dsVFhld0lXRFFZazY5bXFFSW1KQ1FN?=
 =?utf-8?B?UWxSY29ZcUtrK1VTc2RFTEkzN1BtOSthUHFWalFlNnFpREhmc0ZTZ2RRVEhN?=
 =?utf-8?B?ZU85cVRWUElienUvSHF2RndDWHJORi92MzlIaHphRmFodWt0S3BUSDNkZ0Zh?=
 =?utf-8?B?bDA0UjBKQ29uMFNKSnIva281SnBWQml6d3EvR05INWVScHVWYW1DMTRud0x0?=
 =?utf-8?B?Znlmay9hUElBcjQyRm04T2daVHFYTUorM0I0dmUyb3dTYkNTUlJzOE85YmFi?=
 =?utf-8?Q?ugaRPwDglXCmRYsC/6CykZuXh69Ve74d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmh3UlI4VEFvZTgxTVcxa1FDZnFXTitqdzV6RmRmc09uUEU2QUYxYUVXTkFJ?=
 =?utf-8?B?ZnVwb0JFb0VNOGwzTVJSL05TTkprdXhKMFhWa2Uyd0cwRHdQMVlLNXdld0xU?=
 =?utf-8?B?SlM3MTM0MXlTQUVkRkNKY2tvMzg4aDlsQ0oxcjU2alBmYm8zUUhKRlFOMStQ?=
 =?utf-8?B?MHRtUWlhWVRBV3hjYk0vaWN2QzlrWlBoNFpvYjE2YStNeXlSRVJ0YTV6dUor?=
 =?utf-8?B?N3dUVTNBUndydTVHbzhYVkZxVVBaamJQS3FXSXkrRnlKYlZZaFZJMXRBNHJP?=
 =?utf-8?B?SWxwQTZ4QkZidmtvazJYbEkxZklpbjBMbEpXcWNFL1FBaDllQlNScjh5U0NI?=
 =?utf-8?B?Z2o5cGQxS29vcUhnZDhTRjVvR09xKzN0T0IxYkNHSmlDZHBNdUgwcXN1NEhv?=
 =?utf-8?B?L214MXRoeEV1bXlPQ3M5Skh1eVVGdVRwbVBHd3E3akNLQlZ6ZXBYOUhXR05w?=
 =?utf-8?B?cERNRUs0aURVdTlLYWIxdS9ZQ2dZbW9rb1JJK3VjM2JXWG5KQ1Q1VmpxWGhV?=
 =?utf-8?B?dHhhaTRrdWdLaFVmWEFRRXBWWXZMVHdUbWZjQ0NEV0JHN0lLdGVhYXdZekc2?=
 =?utf-8?B?ZmUvQjJZSFg1cGg5YTFLcldGenZBb0NIWHdObFB3V0VLM2hOdHpGdGNLQk5l?=
 =?utf-8?B?VVNWdzI2SWpmcUF1UGExdWs3YlhZMVZuSGxBN3h0cE9jRTdNYVdhMmdtdWdw?=
 =?utf-8?B?d2ZHd2tYR3dyTzNOaDc0emFiY1NMeXhBRDM5cDg0YjJrNVJZY08ydHVrMGor?=
 =?utf-8?B?VkM1SGpnVys3SFUrYmh1U0NFTFEwaDNXRGdJOEtrOVpwdFJVV1NjRkQrelBa?=
 =?utf-8?B?ZExjLys1NytuUzluWmpsOUJOMkFLN3VyUERjWlZKa3cwanZHdmR3WGpLYUlL?=
 =?utf-8?B?SjJGbGNOd245NHhvdTlOYTVRd1BqL2JIOXZRSGxxdnZ0cXkvSEREMTF4NWpW?=
 =?utf-8?B?UXF4a2Z2VHNCQ0c0VFNiQ2JmUUxjVldmbVJ5ZVB5R2JVNW9SQ1I2Z0wxbkUx?=
 =?utf-8?B?VW5LWERaZGxjaTNRYUM5elhFVHg4SFd2SU1zQlA5WjJ2ZnlncUVMNlVqU3hL?=
 =?utf-8?B?Tjc2QTFwejZRbGxtV1BJamJCaU56R29yd3NGcWYzZDFtb3RtbkU1Vk5HSm5x?=
 =?utf-8?B?S0hIMVlKTktid2FxeTV5TjRnWU4zekJWZStSTUZpV3dxczdVMFZLME5oNVNi?=
 =?utf-8?B?VFBSSDR4RFk1dWJoT3ZiYWpkRk5wY3J2STNiYm9DbnltUU5WYlFCTlQ5RFpn?=
 =?utf-8?B?WHpTNEZXVVoxbWxxQkdKZU8vVzFqYm9sQjNrMUl5dHlwSzN4ZGdSV2MxN3ZM?=
 =?utf-8?B?bnVaTkplN25FK0lvY2ZYYTZsdGJkclp2UEdGbmNvWkcyVDR0MldueGpxd2lK?=
 =?utf-8?B?eGJRbHZaMnE2LzJxdHBWak5iQ2o5WFZ4c2g2RVFDbGRxdllubTR0ZzZDbmZz?=
 =?utf-8?B?WVNVTUVoQ0hZWXdDV3U1c3dqYUJNZS81Q2ZkbjloVkF6VjlKc3RtaWUxZ1Vp?=
 =?utf-8?B?MmpodkJ0Qnk4YmZuMmpnc1hTcXN0MW1CMUV4OU1iTkd3QjFaNkRGWW9ZSzRy?=
 =?utf-8?B?OEJxMXlOTVhESjhOS2s0aVhFWnB2SG5aSkZnZVFGSnlnUzJoOXdvcjBQTWhz?=
 =?utf-8?B?bVhhZGNKeCtBNGFWcGhsdU9rZzRFQkcvSmNFSk9lOWVYc3ZFNXAvdlQwQzVZ?=
 =?utf-8?B?bHJlU2xsWEFrWklLUjA5NEw5cVR2eHdSajFrRVlRT2t3TlkyZm0wdGJHZy9V?=
 =?utf-8?B?dTFMSzk4ZllIK1hydnhydVV6NnJGeVlZK0ptelJ6dlZneDBHd0dvYUtSRE1U?=
 =?utf-8?B?b01KQXp4ZmJLdDRFeWhiNGkvc04wL25mcFgvOEFvc2J4aDNQanZBTXd2c1ZL?=
 =?utf-8?B?WFJmVG82M25tN0pPc1YxMnk0T25ZdkthdGxXYmZlZTVqcnp5VkU4NWNTQjRm?=
 =?utf-8?B?QXdsTWNEaGlmMFVGY0pPa09DSmZpcWM5Y1dScEc5cFRhSjArdnBkUnB6ZUNJ?=
 =?utf-8?B?ZXF2bHlxTEM1V0t2NGRqU3dsOGNzR2tJZjllU0JRV2FHL1BSeEFyMy9GOStB?=
 =?utf-8?B?S3RVMGsrZHVxOHJWUEJLeGxrUytZNzNLYjZmcGc3K01wZ0VZbTNZcHFhTVZP?=
 =?utf-8?B?bmtqSWpyTWU5eitXTmV1MGRVdUVZMW9rbXNMSjJRNXlITnl1MXdmMnBrMXNN?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7c1026-8cfd-4530-fdba-08de2c073283
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:44:15.8367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1U8MZT3AqnyjbP4XL4DHnoMij7bmBv5XmpjIOfK5+1IrcKQTY4XzgrFRvY28xb0CmgTLntEitljJXz3nGYqsg==
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

On 25.11.25 10:41, Jan Kiszka wrote:
> On 25.11.25 09:13, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Enable support for FAT filesystem with SPL for CycloneV instead of raw
>> mode.
>>
>> Recent changes breaks CycloneV MMC boot from raw mode, and so we are taking
>> this opportunity to migrate MMC boot mode to FAT as smaller OCRAM size is
>> required, as well as aligning MMC boot flow with our other devices.
>>
>> Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>  configs/socfpga_cyclone5_defconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
>> index 2bec82b0625..2b2435a27bb 100644
>> --- a/configs/socfpga_cyclone5_defconfig
>> +++ b/configs/socfpga_cyclone5_defconfig
>> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>>  CONFIG_SPL_STACK=0x0
>>  CONFIG_SPL_TEXT_BASE=0xFFFF0000
>>  CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
>> +CONFIG_SPL_FS_FAT=y
>>  CONFIG_TIMESTAMP=y
>>  CONFIG_FIT=y
>>  CONFIG_DISTRO_DEFAULTS=y
>> @@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
>>  CONFIG_SPL_NO_BSS_LIMIT=y
>>  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>  CONFIG_SPL_HAVE_INIT_STACK=y
>> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
>>  CONFIG_SPL_SPI_LOAD=y
>>  CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>>  CONFIG_SYS_MAXARGS=32
> 
> But what about other boards for the cycline5? If you want to switch,
> switch them all. This looks half-backed.
> 

BTW, the FAT refers to a u-boot.bin file on a fat partition, right? And
the SPL will be kept in the A2 raw partition then?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
