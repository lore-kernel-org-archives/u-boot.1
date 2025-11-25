Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6C2CFD368
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 06:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE63283EAE;
	Tue, 25 Nov 2025 07:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="a7/HFrrY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29D583F61; Tue, 25 Nov 2025 07:48:51 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC0683D13
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 07:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pf2MsgPtP7WchmkbpMondqZFzUftOobsPTLBojHXkgU305c4qtNXm9aFYmcvJaERVm4W66AXj8K1ZC+9k5fVimZlh+s3DK5GjObZUmWAsGCcyiMCJnAu+OY/h21nw+gAHkyl7F8GBNwqTF18XuHB8lCBTliJtCWRiu8+eVpcsHiVjE1UDfyw1bm2fNf0S5yECvZVKwTjeil9A7gvGISAAgjJbS9FO3yJsiBemVbOuZhPmYv//7zf66NCRuvYJ0mD8Y0qbMbHwJU8rtnY5y1AXrN19alvgK+9BPBxd1FKSkQB9cQYH5jVopZuCJLY0ksgzYULktE9KiJSvOlLlegCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkChEmQ3aQER5UPNCzDM3PZ6kvfyA5aQbRXor85cvp8=;
 b=yeaYRjJGsQqOaW8lw0+WBwvlpERojrZNFEq82dbPGRhLC6ZhTgn9vJ8Qku7EzzA8uW5tsS4Esjg13kjGnh8xyh1JT/AwlTILAbEpLwQqk9iCMLrz6YdHoCJAYP5gn7eVGIJMEqIUwBpPxVmL+DfLGPDdMDLzeVbpMivMemWDEYkP/CN1T9adXzMBbk7Ej9FZiIbJ1+QKHgAXqXr2IHDybEYM0EAGACmosm0+ZciiKxoye1UCo5wBALn38IeFVRRoLGL8sEhjJg2W1mzOC0Y22LqTR5IOsqzEFLeRn/zJCAD3tvt2Jt1Jaml6iWbDxOnOvxGCkTdQnbm/DOhElgLRbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkChEmQ3aQER5UPNCzDM3PZ6kvfyA5aQbRXor85cvp8=;
 b=a7/HFrrYPFcTP2z49mb4VRlz5FpaXuHCe+W2tPHU2zDdQODTjfRFM6RIrO45xwDFVDT2tHpzkKFub6WJLXQgjEKvhqexspecWGfaBZSXuqq0Uv/E/8UwPaREodT2QEfZdpX991fUAmFbBD2kLYCmATNhPW7wmXI8iaYNcKs1vLRmSMlxc6qAQBLa2b/zXSD86/YkKd+CtbcgF3UsBGyaU3/pfvsIe23EwOfVdVbCmIK7U0HmN5EZVYiCAjNjn+40ntbTzZhAha0WWY0vHewjLRGBWCd7VdVjXZFejpIteYxm9TCNI/nW96DaPTfYMjUCzgxsFnf153LJMzDgddKPRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 06:48:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 06:48:47 +0000
Message-ID: <1d8381ed-655f-45a5-97f1-b7e998d1523a@siemens.com>
Date: Tue, 25 Nov 2025 07:48:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
 <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
 <009323c1-98b3-490a-912a-35249efbfd9d@altera.com>
 <CAN7C2SBU1xozPwfRG_tdcqos4jDZRm-qzXR5MEVTG7jXebp_7Q@mail.gmail.com>
 <20251114173535.GD6688@bill-the-cat>
 <9cc70ebc-2391-407c-97c0-78c687dc7915@altera.com>
 <e2557c4f-19b8-45b9-b956-a8131271c7a6@siemens.com>
 <CAN7C2SDc9uQO40+hR-tsTW490sCMUAsLsb_52a3kvHqiDOLtYg@mail.gmail.com>
 <edcf7ddb-966e-46e5-9fef-b218c0d4de1d@altera.com>
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
In-Reply-To: <edcf7ddb-966e-46e5-9fef-b218c0d4de1d@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ee752c-b0a2-4be8-b61b-08de2beeaef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SCsxZ0Z2WHE2eVVLRnd1QjFxcXdncTNpWk9YMTJQZHQ0ZEdoakRkb0ZGcDZV?=
 =?utf-8?B?dTMyd2w3aXNFdVcyaWFGVDlKbHVSQ1NjRllvUzlRODFSbDZwOGV4N3drVmlq?=
 =?utf-8?B?THlWYWxpelUzREFXcmJwNm9Ja253Vk5tTDYyQnBJWk1KbmZzN1JQVVdkRFdE?=
 =?utf-8?B?QmtLMUp6MnFNTzZBUlg4QmRPbnJGRFl4K29uZmRJN1haY2JLdEliZEdtSlFj?=
 =?utf-8?B?N2hjMzRubWJoNVVBUnpkYzdvT2xrUjlNYWE3Y2xyZGhVdmRSeWxYSHUzeng0?=
 =?utf-8?B?YmVOYndxOUNPRHJZUW1xWXVvdEVreHpuR3BlS3lLU3dsbFZZbm9YREtjNXBs?=
 =?utf-8?B?SmxBSTNZV2ZGRHJkMWI5RW4reXdMQjF4QjZQYklOZWd0eDJmRnBRcVRwQnBD?=
 =?utf-8?B?ZWFlTEh1QUdISkdGYVlhWkQxVWhrVi9XSVdYeGd0MnE2cndVTUxGUWVKVys3?=
 =?utf-8?B?MUkxaWNLWmZMemh6dC80a1FkUzVUdXJ6TURwcGQyMXFoZDh4NEM2bVRMSzNn?=
 =?utf-8?B?b1kwT3VuK3dEMEtuL3BTakF4QnBXemRDWDFKaXVRWlVocHZkenlBN3JDTW53?=
 =?utf-8?B?VEFmK09RL3VHanlBMy83ZHZHTmxFYXJtZGJLOFV4Vkp2YmdsTStHYnJLWlZJ?=
 =?utf-8?B?YURVQWcrQ3M1NFp4YmxXN2tPdktyQlp1NmhvYVNsWHdEeGVQNHI2eE9hblNx?=
 =?utf-8?B?WWg5a3FpVkJXbDVheTVIMlJTcTJtU3VZUGlzZm4zMm0vZTNHcVF6UGM4b3Nj?=
 =?utf-8?B?RklUdVRIY3QySTVGYm5sdTZ6VmV0a0Rkb1drenVmVHpVNTBzVWNQanI1S1g3?=
 =?utf-8?B?NW5hbzBuMW9HcEJRSk1vQllQN2lyNnF1RHhoNDJRK2JaVnZkb0wwbUFlbjBD?=
 =?utf-8?B?blBxL3RSaFRrSUg1L3doL0R2VFZoVjY3R3plUU1NVmFhcCt2eFpIWDQwNm1B?=
 =?utf-8?B?TlhGQmR5SUFBOUhNeE9TWEo4NERXc2RXMWdKSUk0UmRmZE5NSEdmRktySjIx?=
 =?utf-8?B?MUhub3RZTHpGVS9iVVhpbjdkQTlDcXhTVlZkMnhGZU4vRXdyNE5rNDUxdWNR?=
 =?utf-8?B?Zlh6NUlXN2ZDbWNGc0dqNXFvRHJOTmo0Mld0QnJiR0dRaE5TUXpicHA5emFB?=
 =?utf-8?B?cmlrM09lTU5xMy9pUzZPNXVhZmo3OE53MjBwTjVseDNDaCtPZlBFUzQyc3hn?=
 =?utf-8?B?VkxncThtYWZHT01QUy9zT2tWZjA2TVdkbmo3NFBsUmpQQ3JxOU1CazdFOW1o?=
 =?utf-8?B?bWs2Z3F0Zmc3d0N3Z3M2amI2SnE3MHdob3cyTCs3Y0RsMTVOeHgyYTQvdEI1?=
 =?utf-8?B?VTgybmNoMCs1VVhBL2NwMjN6d2VTV0ovVTg4TmhyVVlSZkE3am04NUpUZ2Vw?=
 =?utf-8?B?YWdwcitReVBKam1ENWI1MnBsRkh3aW5KdDhnVG16dlY0aHFFSEw3YjZ0TStH?=
 =?utf-8?B?NEVXMzZ1R3h0QWZtQzlOQUtrQzllLzdrOW5rWkJhYk95MDhWeGNZMUtEcnda?=
 =?utf-8?B?eTlyWng3eFdwMElkczFiRTlpZzdtK3lIMXFjWlFJckNablUzZzRlcmQyRVZQ?=
 =?utf-8?B?T0FoL1VDSllqdzc4cmNRUVpndjlJS203SklpUFFDbi9iMUlURG05Mi9XSjVu?=
 =?utf-8?B?MVg1emU0alBVV0pXcmdvY1BYeHB3MnVvTVlpTGYxMXMxZmtRWHNGNnczVzkw?=
 =?utf-8?B?UFAwbnM3OUprRUZPZHdSa2RvOTN4cVRHSFJFcFBmbmpuVlpUU3hOOHBWQ04y?=
 =?utf-8?B?ckZGUElPTS82Q0tJcnViSjBiR1lBZWJOTGhNRXQvNzlqUllreGdabDA4SEpD?=
 =?utf-8?B?cXV2UktTRnhyajZheWxSM3lVa1lkS1RnZHJVL0JVZnFuRDJuWGZMcmFRZFZ1?=
 =?utf-8?B?QWtsZG5wc2NPdjFRSFBDWG9yWS95NjFvNzlCcXdpTTQyTitHNGl2VEwwd1Za?=
 =?utf-8?B?dFFqa29oa1pKangrMTRoZlVUdW5lakJYWUhZdFpBWnJRNlNCMVBKdDdlM2tq?=
 =?utf-8?B?UXBMQWZrT1hRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm45dGxSM2RiU0hZU0kvS2RsRW0yNzIzNkdiaVBIa2ZJZVVHb29zZzVVSVBm?=
 =?utf-8?B?NlkraUwwNXgzRnFwTjUxM2p4UWRmS1NEd1B2NnhNUk1YbXl2WEl5V08ySFAy?=
 =?utf-8?B?TnNoaEpUd0JITjlxdk1KdVpOZVlaOVJxZHRnZG1uVzhaYm1Ld0RtSWIvYUsw?=
 =?utf-8?B?cFFFRExxTFh0N0MvQUJWUjVvaGxQVXRqdktpSnJ4ZzlmK0VWZExZWmZKMlEz?=
 =?utf-8?B?YzIvTXBxbFNYN01ZLzdDTEdYM08zWFR2SGdwK3VJRGhLQzQ5bWVvM3ltQStR?=
 =?utf-8?B?dVF3R2JySU0wenFqMm5oNFpHTVBHUVA4Q05KNWtKZFl5WnBLeCtxQTgxV2p2?=
 =?utf-8?B?eWE3Q2VmSUEvUXRMdG9jOHJLV3A2V29aUVdvRERXWWprS2ZtV0ZUOGlqSzJJ?=
 =?utf-8?B?aUdGVlV1eHpJWkdYN1VHaHZvTS9zVGNrd3hxeHhZMGlmZ3ZJcm1Ka0NrSHBz?=
 =?utf-8?B?REp0UTRoeXV0ZkE4ZHVNWjJ0enMzZm1YVU1KTFdWb0RERElka2R3NGNZdVNs?=
 =?utf-8?B?aHJHeTd2RlNSdVFPTXpaYXlpb09NbytJUXZNYlpHUmFGTGF5OENtdkp4SDkx?=
 =?utf-8?B?RmxMUHJYbU9pZkFlS3hmSGVvWFlvSjh0YjhNWjQ3QWFIbmoyYm85ekc1SnFo?=
 =?utf-8?B?Mi9lUldFVUdsaFlQRUZUekp0WlptRDgvZ0VFQ3c1ZlB4RVF6YkhIQWJ4ZjBi?=
 =?utf-8?B?UUJiYjZ3UUVybyt2MHpuR3UwSWJ5dVVFci85Slh5QzZ3ZXNSeVVvN3BvWDVv?=
 =?utf-8?B?d1FybUlVR2Nhc3NHQ2NMUnBBb2tXREJuQ2F6bndpMkQ1eHhEUC9nZGgwRFdU?=
 =?utf-8?B?ZDhmU0xEUUgrSHcxVkpDVWg2djA4M05xc2pwUEZ1VmhnYjFyemtBQmhkVnpl?=
 =?utf-8?B?dEYzQ2lIUEFWMTF6R2xwcFVYaHRGTDBWWVRVVVNCazdwYU5IcUdvbjBDUHVx?=
 =?utf-8?B?akRka05KNCtIRDFKcUdCK2k0b1FtMkdhYm5Pd0xEM0lhb1RvbXRkZm1UUS9k?=
 =?utf-8?B?bmFoL1lqNHNWcVJEOGd4VDZSM1VpOGExZkdzcE9Felg1cUZYUWxjVlBpYkI1?=
 =?utf-8?B?VDgrUGhQMzR0U3l6RXlEQjRTUzI2ZExpQzRrUmhyZ0F1aWJtbXVUeHQraG0x?=
 =?utf-8?B?MHh2NnR6WmV5QmxDUUI0cVFVYXBSRjFWVlJ6VjNWYW9GWmYwM2tSVE9Pd0pj?=
 =?utf-8?B?ZmZLbUVwenhPSExlbEowbWdHa2kwdjBHeGs1Q1dBY1h3SCtIWGthVzBvVVVG?=
 =?utf-8?B?bUFKMUJheXZlbERFanZlMjBuRS9mNzRJUVdTNzJITkhsUWQwZ0h5Y25QQ0FJ?=
 =?utf-8?B?SDFkV1M3L0JKTkcvejc0UE9iTnJWL1hZRFZVMk9VTWUrUGQvdjcxOWpsSTBZ?=
 =?utf-8?B?V3krTS92bndLaVZCdUhaMVh2bm1xK0tlZjd1V09DcWQvVnhHOStzZUFqS1h6?=
 =?utf-8?B?eWhPeHFPVXBwMytKY3FLL2pBbTNnZmJBdWgxU1lVcm5DQU5QZCtUWDczZVo2?=
 =?utf-8?B?eVUwVEdiSEV6ZVN4dFlMNlVKbFhONnRtVGhocEF0UFZJS0l1cmVqYmFHMFh2?=
 =?utf-8?B?bmc4SStmUE9yWGMycUZhbVphZVZ1SklEd1ZCamovaDdTeVBBWE1IcU1aRjJG?=
 =?utf-8?B?SEJWeTBpRFlEY0ZWWVRZRUlTa1dYOFEyNUMyMmpoVHRTZTQ2TUR4UEhNaUxD?=
 =?utf-8?B?bGJxamVSWUoxSFhNb245ZUJvM2M1clZXY3lDUU5yMW9pZkZqRlR1eE11aFo5?=
 =?utf-8?B?VUZaQWZmcXhnTzArdDJ6ckdEaFhoMGUyWVZuUjdsZVpOd1Z5VjdRV25pK2dN?=
 =?utf-8?B?VVF3NVkyWDNvM0pqd05kN2xGY0NQSUxGVUduUGM1RVgvaDEyOFY0UmY0NU1v?=
 =?utf-8?B?NVplQUtKRXNkUlZRQ0doaU9JRDlxVnFwWFJUeE8yNUo0bmovS2pMZ2NSbGZl?=
 =?utf-8?B?bVErQ01Zd1EzQzNXbE9ySkxocE5qZFlXMGFtMHQzVHl5QUpDZ0hGZFVNYUJ6?=
 =?utf-8?B?QW1tN01qRHp6YmEzdFlyNkI2cTIrU09LNFRkSlBlQ0dFRWdRTXlENy8wdGdF?=
 =?utf-8?B?WFhmaXhPaHJaK09LV2ZURk9FVjVIVXhxZWM0QzR6eGpwelE1OW1ORHRjbDZ6?=
 =?utf-8?B?Z2sxRkpxSWRPNkRFTFJtdzBlTmN6SEpIZzNIK0RRYkdmekEzVGp3c0FPbWFl?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee752c-b0a2-4be8-b61b-08de2beeaef5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 06:48:47.2189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zDlhYeNWNiF2+b/XQ9meRybwGAHxcMgXXYJC6l1OGZH/tCmtzIOEPQaunNL39Uueubqld/12AdvdSdtOodVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8831
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

On 25.11.25 04:10, Chee, Tien Fong wrote:
> Hi Jan, Brian
> 
> On 25/11/2025 6:25 am, Sune Brian wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>>> I'm all for finding the best technical solution in the end, but I wonder
>>> if we can at least come to an intermediate solution for the upcoming
>>> release so that folks do not need to carry too many extra patches in
>>> their pipelines (https://patchwork.kernel.org/project/cip-dev/patch/
>>> cf43e9da3cfc59771e801d3215d3b3794f3602a8.1763446144.git.jan.kiszka@siemens.com/)
>> I am not sure why point to patch v4 but I did provide the final path
>> version that T.F. should be ok with.
>> https://patchwork.ozlabs.org/project/uboot/
>> patch/20251114160423.1518-1-briansune@gmail.com/

Due to recent discussions in that thread, it floated on top of the
mailing list history for me. No other reasons.

>>
>> What this delay is that there are several feature coverage on the same
>> file.
>> Meanwhile, there are several similar patches pushed and T.F. action time
>> is a bit slow.
>>
>> The very first patch was almost two months ago.
>> https://patchwork.ozlabs.org/project/uboot/
>> patch/20251019092341.1158-1-briansune@gmail.com/
>>
>> So I had no clue why that huge delay. BTW it is supposed to revert
>> that pointed out patch to easily fix things.
>>
> 
> Thanks for your patience. We have completed testing with Brian’s patch
> as well as Jan’s patch series, along with a few additional issues we
> identified during integration. We have addressed those issues in our own
> fixes, and we plan to send the patches out for review today.
> 
> Brian’s patch:
> https://patchwork.ozlabs.org/project/uboot/patch/20251114160423.1518-1-
> briansune@gmail.com/
> 
> Jan’s patch series:
> https://patchwork.ozlabs.org/project/uboot/cover/
> cover.1763140421.git.jan.kiszka@siemens.com/
> 
> During our testing, we found an issue in Jan’s series; I will follow up
> separately on those to provide detailed feedback.
> 
> Once our patches are posted, we would appreciate your review and
> testing. Please let us know if you spot anything that still needs
> adjustment.

I'm happy to test if you CC me, at least on the DE0 Nano SoC then. Also,
please tell us which patches you need updates of or which you would
integrate yourself.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
