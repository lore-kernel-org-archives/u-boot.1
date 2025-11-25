Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB98CFD368
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 07:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 213BD83EAE;
	Tue, 25 Nov 2025 08:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wiQoes/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC4983F66; Tue, 25 Nov 2025 08:17:28 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EBE283E8E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 08:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbTnlM8NnQ97RmWCst161XfUHdiZZ7/FEI4pwx+aFwtWBvNAz8BtPjRnMWyohouOUMd7xPKhVf4nQ9kkpgsmFxpun9fG9gZVumLjTmQ4fxmi4U3V4820ArdVEsJUvQP6yBtgtiEY/ybaD01B3FHrmTTzzCWUMDKfXfJl6V+rT8q1GPLkmg6h45/MNINZ/asCcwYPQ/547xDYYAIdNj5GK9R+YiakaztPx89wXutKB4WvNwVmxDUTWi/3mFuLi5lvSLNEDiq1cChGeqPbPrJEORk1/ta86rDpxtVZlFw0GJLs5ROV/nJU27Q3yNnX8BprO0Xa97qlLpF5dYeZ5j7wxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OjV1lsCQOeJvArPtnBD74j4Pw15Io0w50vIHAmdMKU=;
 b=XlZJi1EzkayoyxEENmiFnktzS5rVOW3EgSJG4PgsflAR6BgJ+hOGlHuauR9jpQjxWr3jZ897ewdbFc1FQDx8nulPOlPrRkSRx854ZUXugRsGqdt/ndtg4dQv2mnUNIiVBvDdqSQDLpyXtDErOmP4shZU6qCWrtjQpgKqCaojiib+44KnCkLHOoyHzlkJNbTtb5aLt/BibcK8qGics7j7nD/ckm/RT90qbxiEMufcN/gxggaBUMPu7Ot/jQ0gyDIu8easwkbm34hpxAZTJKWh7z344MihVSqITzRrMCdCMg1ctEtjNqTJvYObGKmKBkDE7+lasZUDCHXu1zcJcTRdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OjV1lsCQOeJvArPtnBD74j4Pw15Io0w50vIHAmdMKU=;
 b=wiQoes/uhsgPowSfyK5r5R+TVprVwAnCaajy8k9lyxXSnqNDO2FV7j1t+hQNpuI6Vj3QPtkTlJFEfwHt3vGJjsKW1bIVV+LalLewD4TNlnxAXstOj8GBmL97EaOIQE80MwNk2oSMEDrEmSPrBoVytQJ0fAJomcMElRMCqDc9erBVuLxnCsMDnyILHgRhTSlnzPvfW+0+7sYJcJMRHUiDf0m7I4smFOpWKIZ2HXnx6ElxLlX7pmGBLKGF3A3qqFM7WLmWoq7h7JeYSJMN0TZpCUiXHq2dHKjPiB7gIqdNG+ZskikPo2h9SH3Ju7z62DQr0qtXoVgpcUTNDhHguiudHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 07:17:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 07:17:24 +0000
Message-ID: <c813c1a0-d224-4e82-8494-1a7d2676b29e@siemens.com>
Date: Tue, 25 Nov 2025 08:17:23 +0100
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
In-Reply-To: <CAN7C2SCEnkiLtRyiRx9ykLWOWJFNkUOh-UNZ+Qaq=bD5wk_a=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3142:EE_
X-MS-Office365-Filtering-Correlation-Id: d07173c0-72f9-4725-615f-08de2bf2ae85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2FwaWViOUk3R1JRSHFlWnkvTUk3L1hBcVp5TnM1cnRvdy9YVWRrTExUaWZj?=
 =?utf-8?B?MWUxSUJYMHgzN2lTMTNHVk5SQ2M0d21Wc3VZVXZkQ1hBNUwzQ0FvVi9DSTY1?=
 =?utf-8?B?QmFTdVZWTEdzelUyWGZJdWhLY244ZkovV0NGc0tENkcvN1dQQjAxcXVaWGNs?=
 =?utf-8?B?Ukk4RytldS9JVCtwWXM4SnlWWkFKTkNIOTVNRXZVb3Z3eHJCVEMzd2tXTW9I?=
 =?utf-8?B?YWRoOGtHVTRlMHEvcy9HTHJyenlkU3VTWmx2S0dKN2hpS2tjY2tkVWtqQStD?=
 =?utf-8?B?dUJXYTk1Zy9kWGxudGozMmFCSkhhK2hKeHZjNUtIN04xbUQrWGxrOE9BTHNx?=
 =?utf-8?B?c2h3UDdXWTZXZjc4c2krWi9nNEdJcUp4RzRKbW45dzlFRHppWUlrN2V0b0hF?=
 =?utf-8?B?VDF1aEtFMkhOeWlWS2Z3TWFmL0JtQ3F2T1lkTU5WZGpLQjZLYmFieFRyQlM0?=
 =?utf-8?B?WnJsaXhlRFlkVFYxNTNoVm4vSXE1RExUdTM4cEJCM0lBNTR0Q1VuMmNqZWNF?=
 =?utf-8?B?aXN1V2F4R1V1djBBcXlIOFhpdUFKaENWM2h0MElPZ1EvUUkrTmsyR0M0WGxq?=
 =?utf-8?B?UEpoOS9kaWlsY21KSWpmRTNqV0FRN3RmdTdxS2w3cVdiTnpaejFQUVE5dDF5?=
 =?utf-8?B?cjFXYlU5SW9oTmdGTk9pTTJjckxuYmthVzNSQmJpUTBlUEJrbWNSejB5Y2hO?=
 =?utf-8?B?UkFIR0UwV2tRa3ZpYTVCK3NuV09KSVFoSkhkZEQ2R3ZzWDc4WndXbXdjWkZ0?=
 =?utf-8?B?TXJWTmVvWjNqY3IyLzdoTnBCRUpuNVpJQnpWZUFIcW42b2l2M0JHdms0WVBM?=
 =?utf-8?B?cloyeWJ1dElpT3A3bDF6ZGhHSVpmcThja1VSVUJScnNyTnAvMG1NUkxjOVh1?=
 =?utf-8?B?TDN3UFlGNEV4azV6WWppT0E2Vm1kakU4OVhiMU5RVEhtRTRFSnBPRHYyZTFp?=
 =?utf-8?B?RUtLbEpRbmk5bkZIcUZmdFpKZGJhZDluK0pTdTRoYnliWUE1MTdKcHg4NmE4?=
 =?utf-8?B?L1ZET1hIazJxd2xRd2d0RlFQcEpQVDlITFp4RXNuU1pRNzk1TlRqN3E1dnBk?=
 =?utf-8?B?RjF3N00rWUc4NG8yYng3dGY0UnRJTzJxVnY0M1RXL1FwSnA0aWhWb3BKSHFZ?=
 =?utf-8?B?LzJqc1dRMEhxS3VXRjV1ZzV4WGpWalZ2NGxmSkE1KzJEczBCMDZpWmo2SFBS?=
 =?utf-8?B?NnhocytuQmFMaDdOZVNoRzl3TGdBZGhkbWtXVUNSZ3ZXQm5OSlUxMStkbmIy?=
 =?utf-8?B?VVJ5RXdmWFJJa2tQbDFFcmNId1F1ZytTTUYxckYvSG8yVjNTVjFMV2lYR0lY?=
 =?utf-8?B?a1FxamhaeGZqcDJNNjQwTlRhdEJCV3l3dVJkMGtXd1hLeUJGZm5RdEdKc0wv?=
 =?utf-8?B?VWVBSFlHb2Qxd3BSSEloRmNodzcwSVNqVEROd1d3aUlpS2cxVmZPT1JjU05r?=
 =?utf-8?B?Y2FaL2laR0syNXhZd2FkVTRyaFlxMm5QSGNaMzBsczVOc1VMeElpWVFaaHRH?=
 =?utf-8?B?Ti9leFhjdWVKRzgzTGRqNlZFSDNQVExBb2QzR1JWbDZDcnBtNjNXZzFDM0Rs?=
 =?utf-8?B?WWlzdlF1TDFnQVRieDVqQ010a2w2RXl6L1J3THVTdFp5NGxiZ1QyWk4ybTJk?=
 =?utf-8?B?d1gycGhhdWg2OUl0dGVadTA5N1p4OEh1Zm96WlBWSGc4VDdZclRWZzRsV0Q3?=
 =?utf-8?B?Vng5NVYwbmc3U3ZMNnVzcUVhWFFiVFR0MDFxUU1EZkRDVDRLV0djMUZybVl1?=
 =?utf-8?B?K3NuQVpYNlRpNHVKR2RRa1JOQVAyMnJ6YkRlT3gvbmF6MVZmRlJiTWNPRW56?=
 =?utf-8?B?YWdaaUhsVmdzelhYODFweW5tQkh2SDJ4bkM2WnhnSStkUExYYTZEQW05TnN0?=
 =?utf-8?B?QWRGdDRTS3cxaVVyNUhtcDNyYVpkMy9PNXh0eVdST2lBWDlzcmFjcXZmVEMr?=
 =?utf-8?B?TVZNc2haUm9yelV5UlZNbnhlZlptajE1cFI1cEpJdEZxODJsbm94Q0J3NmM3?=
 =?utf-8?B?Zjgyam8xK0h3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rlo1aGR1MElHTjhRbjI4eC85emVOa2toRG0zNjJxazAxSTlDNHFVQnlXNytQ?=
 =?utf-8?B?QVVYSnFsSEZpbTVKNEZPeTdORlVkL3drSGFFNFhaVmxXREN4ZnR4elBaVlJv?=
 =?utf-8?B?Z1VJdkRNYm5YdU5McFcxWXlyZHp4c3FiQkt6dXcxWTIwSHd5MDdEcEJqbnVa?=
 =?utf-8?B?RGw1WTVvd3dCR3p6dmxzVEJFTVFpTGZxbFNxRWU0QldMbHh0K1dzU3RNVDZ4?=
 =?utf-8?B?dzlrSnFtaVozNUFCVVR1dGNvRDBwUnp1M1hJTEY5a3plQjdXeWZzQThQK3Fp?=
 =?utf-8?B?MTFJZDEvd2pWR1VuSkJTNmp2OVRrd2VuYzBVK0haaVVxUUJlWUxOKzJnN2dZ?=
 =?utf-8?B?SWFGSENZamo4cC9SR0N5aHBud2pKSWdsVHJ2cHF2L3hONzFja05HQUFNUkph?=
 =?utf-8?B?N0ZEK0kyMlE3Q0F2dTF1YURGc0pVWFJxbnJ2dk5vWXUrYmRKT2Q5SmhHc0Jq?=
 =?utf-8?B?VzAydlZvc2xCaU9OYVNnNXBRWUlZcGo5SmVLcmRDdUVGVmdYMHB1SGNGSkta?=
 =?utf-8?B?bm9wNnlsVHNiUXR0ejAzeitiZUNaSDIxUHJSZlFERzNYMDlNVWQvS1NLaXhU?=
 =?utf-8?B?Qmpta3RjcWp0ZGlzWldESkl6YVhsNllGYTRraUhUc3J2NEZxMzZPbmVBaS9a?=
 =?utf-8?B?cHc2a3p3cmFiT1lYVXo1Qi9sa0taOUVzNWR4Qk5LOXl5OFg3bHBLa003YzJJ?=
 =?utf-8?B?NG9QcC9YVGRubkltNHBNUHZGSWNIOGZMbkVOd1lxTVpwWjlCZ1hrVDhKTWw5?=
 =?utf-8?B?Z2NxcEtUaUNPWDRUN2ZLVklyQ0RwU2I2Y29vUHRUSVhXd0dvMTB6cXR1UElK?=
 =?utf-8?B?NnZ0SFQxZnN0cmp3WWVZNndSNFJtVUFhWDJYMHJqbTV0RjJjWE9OZDVkaFlu?=
 =?utf-8?B?b0tlcWl0MmhueHQ5SENzWGZaZUU3OStYWUY3WGEyY1J4TE5oL2k4bVBiRXV3?=
 =?utf-8?B?S2VpTjE2cnRFWnBvNFNCbEVXbDkyRytnVmJ4YlkvYkdWeGsvV3lUaEdoSXhO?=
 =?utf-8?B?UCtrS0tOUS9VaWpERHdnZjVLZm5MT3YzelJTU1dsUkRWU0FFbTJDZGkvUzRG?=
 =?utf-8?B?S2hXUkZSQkZ5aitKakI3engzaHVsai9Va0NzNDY4eTRraStCeWYzdzZtdmNF?=
 =?utf-8?B?Z3ZJcWdGb1l0RzJTNWhBN3g5bEFNWG8wZ1h6ZnM2eWxBWHk4Y2ljcEQzRExE?=
 =?utf-8?B?Vm1qS1hiRWpuR2JUYzRhNUkrbXZrRjFGUlFuVXBYSWNqajRKN3VTR2lkMnF3?=
 =?utf-8?B?K2tkSTNLMy80RzgrWU9JdzIzV053Rk1xb2MyVTM2eGY1SEVkZmhOWFpTSFFw?=
 =?utf-8?B?RHgxWnJZcko1Qkw0aVNMSWhzSktvZXUwWGJwdEVJMVFSUTZwNEhNZWM5OUM1?=
 =?utf-8?B?cmNXZW9XMEhUc21WcUdEQWh3cjVLMWFTWlVUZnpJNkR1Ri8xR1Ixbm5TTFZ1?=
 =?utf-8?B?ZHFFNVg2Tnp0VjdiQmdZRkZITktDLytkdXNZY0NxWVFaV2NqK3RFY0dlbFNx?=
 =?utf-8?B?aUtuZmVnZW5pdGZsRU1HZjUrTngveGM3Y09mTXpCY0FMejRNMXY1a1JMRVp0?=
 =?utf-8?B?OUNBOXlPek9PQThqQ3JubHNzcTl4T2ZLVUhjeGJhTFhlcnRGa1Iyd2xFeis3?=
 =?utf-8?B?SmVDWHBGZ0VmeW4wYU1RdWZBYzA0YVZtTEdaRnd3c3N2eTBKY1NNUWIyZkRn?=
 =?utf-8?B?ZXY0ME8vYlluWkp0L0lISlY4UXQ2STRoOGxjSWUza1J6dDJkL1V4ZjcwZHVW?=
 =?utf-8?B?bmxHWU11SDJNVVpKWlZhSEVLb3lFVXgwOWNmK3lUVHdWdXdEOWxRb2M1enRr?=
 =?utf-8?B?MDlMSHA2UlREcEQzRndORlFuaUJXNHlWc1ZuK3VPY2FMUExkdTQ4UjhIdDN2?=
 =?utf-8?B?UDRpZE5veWRzZlphcUc3WlZXUmtqZWdmdlBSVHJ3cHNKZDhhdWUzVVdxMG92?=
 =?utf-8?B?aFJiWkZjODA2YnBYYzJsSkVXc1FSNDlqdXpqYm9PdnlDZTcrZDNrYys5bVFw?=
 =?utf-8?B?SHp5MFN4K2J5bXROUEphYzYwUXVvTVNQYzRuNmo4TkpkeXJKRmZpVlpwL2pr?=
 =?utf-8?B?Y01aNkpDcHdRd1dCcTNMTmVCeTNmMzhsc0lJemhTY0t1MDlUWWxRb1d1Yi81?=
 =?utf-8?B?Y2VDU3BnUnl2a2FFQjR6NXJJOHZXS1Y5ZTd0M0V4Mk8xQlRGZ2pERFN0MFBZ?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07173c0-72f9-4725-615f-08de2bf2ae85
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:17:24.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2WBqSLr2YX8gBKyrO3VAURMaE1eb2TigK238tPfBxjIHe8tbvAYts3VkBPQFwYG8m5faWXN5cxT6NfJRO1ivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3142
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

On 25.11.25 08:08, Sune Brian wrote:
>>>> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>>> +                                                unsigned long raw_sect)
>>>> +{
>>>> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
>>>> +}
>>>> +#endif
> 
> Hi Jan
> 
> I am not sure what this is trying to fix btw.
> But A2 partition might not be located at 0x200 it can place to the end
> of the MMC.
> It is very personal and really nothing to do with board but only some socfpga.
> 
> But what this actually trying to fix or improve from first place?
> Maybe Jan you can explain a bit?
> 
> Do the RAW referring to A2 partition if so really not always.
> Correct me if not, and current three settings on
> 1) partition #
> 2) offset
> 3) partition type
> aren't enough to make things work?
> Not sure getting this right.

We are booting the DE0 Nano SoC from SD card, just like we did for
almost a decade. A fresh integration for Debian trixie and UEFI is at
[1][2].

But that boot approach fell apart after the refactorings of raw mode mmc
loading and now starts to work again with my patches. Not saying they
are perfect, but at least the board defconfig gives something that runs.

Jan

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=1024655
[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/next?ref_type=heads

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
