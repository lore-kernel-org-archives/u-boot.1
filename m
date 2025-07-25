Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF7CC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 734E583955;
	Fri, 25 Jul 2025 14:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gemEt4iE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6823483957; Fri, 25 Jul 2025 14:03:32 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 449228393F
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYEDU7q36QrV6pwj61YVI4gqfsMf78hn32ydn/Ywv/Ma7YG9GtIAhafBmdqp2xRLgCnc9YIXmM1SUhwPfOk5u3lZmNssqEcKsNH6yQ9XRklUnhTnwO2GlxfYN6rknYv2i2pFhaF7GmB067R5D/qS3hK6ACiKKMulIbuSJM7IPQc921f52VmXFG7Nl0uxfHjkyTCXk3N5noZuBF4fSdOPxarSBlMjCfzWnO+u8clsb3Q6Dtutd+9rrwL7mdUTXkI6lx+wsSwNq+1bFkRPg+6l+QWMABiR/xhAb45GALnVjvqbK3xXPceNGPHDn3C/D8DocIfY2yCKJQIy257Cqzu61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIel7EFt5gLHXWwJgCu7t+230V9djhdxlhJJsWctE0k=;
 b=L3JsOt1KeAeaVHNKtaBo31vpoMtir7u3Gyf/F08Dp5rqTdwmkSr+DSX9eE0gALmvA41G5WKbOYLMetWJ7cc7io7ePEOLaJftGACITiLu078oEIDua3V7PgsjDITluviTJ3edPzolgwqgNthUJ0463ZZxEQygnSLDabW0roHWGQfXsDvkWTDY6ZB8103/wmz+6o+kTefWJ0IKHnv8e6dFW0L1sc6qtZBYky+jrs3eKGf3d69lUC3sFGVcaaM1aQdO2wl721sRBWz/d9R1+nGnP262MAuugkX2YrvFLFoqdeGZvm8AbIqKCXfopP4NFt4Md4BDTZaPpavz8/bxOGDrVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIel7EFt5gLHXWwJgCu7t+230V9djhdxlhJJsWctE0k=;
 b=gemEt4iEoVkik19RDOzuRMFwrT/c4S/MauN4o46YHiE/BzmcKLQl8JfwVZ1pHXgLSui4uysJbBckwfTfptiPnDIdOjeZEKcB6UsojHQqXiRL/iXOPXt9RVl0yevMAx18Zpb4/nHRuuMou/yvG86iyObl2qrNV2kAN4pm0/YpPH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 12:03:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:03:25 +0000
Message-ID: <5d481eb2-801e-4771-93b8-e2c6877df4d6@amd.com>
Date: Fri, 25 Jul 2025 14:03:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
To: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1753442748.git.michal.simek@amd.com>
 <20250725-residence-stingray-818201348f2f@thorsis.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250725-residence-stingray-818201348f2f@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0309.eurprd07.prod.outlook.com
 (2603:10a6:800:130::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bf9834-61b4-4ca1-13ae-08ddcb7342c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RisrV2RnZkI3UnlvdUdUUGhkSlpkdC82c2FibDN3U0hyV1lmZHo0MmhnMTdP?=
 =?utf-8?B?UC83VG13ZUpzeEFjQ2NNVjhlRndkWUp3VGhHQkFtUXpzS2xiY0NnblBINm1z?=
 =?utf-8?B?ZEhwNkN6UjY4RjB4MDdpQmV3d1dPQnFoZnVwU3o1ay90ckNiKzVxZWx2cDZ0?=
 =?utf-8?B?Q1U2L3hCamJmM1J3dHNEUjdzSG0raWR2OXI4aHpmUjg1ZkpGMy9qbjMyd1lu?=
 =?utf-8?B?eE0rZEE2NmE3ZkdxN2lEcnkzbklOazNpUG5VNHZ2RER0OFcvZzFkUVVkYUcr?=
 =?utf-8?B?dVpKdUpFZk9Lbks2NTg4Nyt5OEF3Qmk5MzhndDM5Yld5RlpmdGY5a2ZJRW95?=
 =?utf-8?B?NEd0S3pGanM1bnFTSk9jUjhENi90YmdrdlJJQnIzV2NmbzFtZXBNbVRERHY5?=
 =?utf-8?B?VXBYTHFncXpxRUhkS0p3TlVNcDZMSUx2NGZjS1BmeUdWazhOYUdrYWdtWGJF?=
 =?utf-8?B?a2FuOFFUOGRYeVB6Y0crY1l0Wm84RmxvWGhMSE1Rd0hoWnp0ZjA5VUdjdFlT?=
 =?utf-8?B?eXlkTUZNekFMbE5yeU9QRnpDZTFUcTRJckNxelhwVzR3dkZ6Z2pKazZQcFhT?=
 =?utf-8?B?WEQxOVpkTGp3UjJmbU9nTkJxV25aY1lLUmhJM1AxNjQ4L3dwaFlUUXBucHh4?=
 =?utf-8?B?b3pMeFRjakt4eTFpR2pLaWg4UFJ3K0hrbCthM3hJVUxENVFCKzNuUHUxLzZP?=
 =?utf-8?B?blZsaERkSVVPaElQTUNlMHFSZVg3azVxdWdHTG9vSGlxbzFnRktXZ1hpSC9S?=
 =?utf-8?B?cDd6RllTT2k3dDk3WXVQWlhQZ2lTdlBaRS9nY3ZmZnpSSnFMWVVHa29XZkt0?=
 =?utf-8?B?NU5zWGlnbmwrSkhGcXpJSng2Y0NDQmwwMWg5YXFGdHg1cHU4bkZqSkdEZU5k?=
 =?utf-8?B?d0djK1g2VGY0OU9wUzJoVE04MmVkLy82ZlA3THpSVCtsVlN3ZUFIeEtsWDdI?=
 =?utf-8?B?NS9hWUlCZzB1UFljT29iMjkxUGdOdDFMTjBzUlVFcitJSFRwaDdLclZpbjFU?=
 =?utf-8?B?YzFjU1RsSzlidCtrWk5kYng0c3kwK3NLa2ZVV2k4eGhlZmNjNDJuTUNrSStU?=
 =?utf-8?B?aHBJd2g5a0VSMStPcU9QS0NCRnJKN01ocVNTeXd4bGFOQ1FrN0ZoYi9CVGtz?=
 =?utf-8?B?VTQ3TGRJdHU3VlpKaVJPU1R1RU9TQ2xxK0I0T1o4RW5ZbFR0RVUreEtEOFJ0?=
 =?utf-8?B?NzVjdVpYWlpibzczdkRrcjhPYk1kTmRnQkc1VjhrME55TXQwMnFqTGFiRytO?=
 =?utf-8?B?KzBiT2RCbHltWWxRRWxTTkRlRnROYUcwVlhDcHlrSTlPa3VQeXlZRFd1VC9z?=
 =?utf-8?B?dEFuQ0tVVGd1QVIvVDZwWUhCWmM3NGNSWFY5STUwdmc5dUhOV1M0SXNwRENV?=
 =?utf-8?B?TWh2OW4zVVc4cFB0a0hNV1k1eVVmNGlPc25vVCtsbW1rNlJLbTRFMUgvaGFq?=
 =?utf-8?B?cTZQQTJYN0xFZGNObHRrUmxIeHpVUEpnNXRQbkp4emI3cWluQ3JJOHE2T0hi?=
 =?utf-8?B?SHpCUm1tRm0rMUdmdXJ4bVpWRlBaUjNwN0tpeDdtc3R1MG80NGxaM1N4bUJK?=
 =?utf-8?B?QitseE1xTXgxYkI3UW5xazE3WWxsVEpIdHFyRm11dS9kMUEwYWZiaklQOVE2?=
 =?utf-8?B?V0FnZ0FBUmhwTFVvTzlBTlhDMkd4UlArWWlQMjFtL3pWbWV1cUNhclZkajR3?=
 =?utf-8?B?ck93WU9aNnROVFJ1SFhqMk1BOU9UMVB5TnpGOTJwV29MRVV6ajltNW1saFp4?=
 =?utf-8?B?emhSdzJFMEtTQnBtRmVxVUFqS3NvdFBLc0ZtckNBNUlYZERCWTZOc1VXa0R1?=
 =?utf-8?B?cTVDeFBhUHBBaXhqTjZFOHpaektaRXI5TkRTSmplZjZ5aXg1dHhETU9nUmFl?=
 =?utf-8?B?QUxaa0t4NDIwdG9qSEczbmd1akExUHpFc2JsMjFkcG04UGJ4MkFvc1F5U2Q2?=
 =?utf-8?B?ZFBjOWUwZVZjVk1IQmhCcmtlMjJwZXF0MEJ4NXpnTXRLYmhNd2pZeWs4MFIx?=
 =?utf-8?B?MjRxdzdrczlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNpcUVzVmFYY1UxWU1yQ0RlekZJR1ArMno2dU9ZNWRsVjVQNUF0Z1E5QmFH?=
 =?utf-8?B?ODI4Ymt4bHdHaVRKaXFEeWFRd2Mvcnczd1lHeUZCVCtUd0ozcVdaSVVMblB2?=
 =?utf-8?B?K2ZtT1BjdS9rYTZvcWVwTG9CVEtRVWtvS1hTSVR5bGMyQ1RXTzA2Q2JaL2s2?=
 =?utf-8?B?OGc5SHVRTWxCc1V2SFh1ZjI5VGJuOG5UcUNTMzJNUjJNb3Z3N0FETDh1Vjdt?=
 =?utf-8?B?VkdMbXRVdGJoQjVhak5PcUR2VGhpQnZqOFR4aFlsZWRUdzdmeTI0RDlCQUpU?=
 =?utf-8?B?Tm1YeHV5bmRHNjhUdjhNZUNqQ2ZhY09zWlN4clBnQW1DVnNXNjloR1BHaUlD?=
 =?utf-8?B?SVUxRnlwczhlNTYzdWQ4MlVYNVRoc0YvMC9UT0VzOE56YjJPcFBwYzMzeXUx?=
 =?utf-8?B?bHNCQXJMYnVlZThOZGU3NDVjc3RmMG9jYlRTNFZRTjFHcW5FTDlFbDZPcVJz?=
 =?utf-8?B?aFQzUXM4c1Vzd0ZVQXY5d24ySE1wNlBMTmxHSG9KZWRVUDN4SWY2SFlIQm9Q?=
 =?utf-8?B?QStycDNpSCtKRlJvOGZYODU5MG80SVIyWGNIVnI3aFRxYm9mTkIrMGh3R2NU?=
 =?utf-8?B?NFVhTmYzUzBWMExXRlJ2VHpwMlByTXNPajU4ditOWEpsYjJUc3ROUWNCYW9N?=
 =?utf-8?B?dG9TdTloRi9ZVzRrZ2srUzhnN1VDL29UYWc1ZEhYaVg2SVZLM0xtV2sxOVJR?=
 =?utf-8?B?RkJFM3JwZEM4MDkwa1BkajNveVlwRzlUQStNcnpjWUNCQXhJaE1NV1VlY2hh?=
 =?utf-8?B?OFBxdVBjR28xL1Mxcm42MWdhS1NYblc0R0J6ZmpRYzY5UElrMXVKN0hIOTZH?=
 =?utf-8?B?T3lsb0R0ZXNTSUpUVmp4Q25pVzFrZDRnNzFIL2pvZDlvOTBzUUNreUtqMTVt?=
 =?utf-8?B?b0twOUMrdVk0WEd2T3A2Uk1NcTY1U1BoVThhcWFacFBBeCsreTY2Tyt6NVpW?=
 =?utf-8?B?N01OZmZFWldNQVVwUWUwbFhNR0x5aTNMR3ozWGVxVDJaL1pDTDRLd0lvalAr?=
 =?utf-8?B?Y2xnazRWZWNvS0F6TGNoVWhvMHRDQjB5VmpPcW1vYTRQUmorWHJ1MmpLSnUw?=
 =?utf-8?B?eGZwREFZZFJKUllvNVNqMkJVclhuRzArOGE3VTB6YUs1K1BEM3JmN0FsR0Jj?=
 =?utf-8?B?NGhlZjU3LzFzZlRoVVJ0ZUVkcS9GOVNhVkZicnU5UHJZT21kMDlNaTJTUnNJ?=
 =?utf-8?B?cXRMdnU4QmpQbC92REtoWjFFZ2VTVVkreElDK3pEK2FDZC9QTWtldm5ubU9X?=
 =?utf-8?B?TUhFV0x1LzUwSG1zL2RFSVBiYzFrUEZZMHBJQUFhbGpBai8rNjJnMzR2OUxZ?=
 =?utf-8?B?WG1CTk5VZTEyVnA0dHdPdzFQd0FjUm5hdk9EWXdMWEhuV2xKODNXWG05QTRq?=
 =?utf-8?B?RlpQY1Jtam8vem1PV0ZzS21vOStxUUgxUVloOXdZeUZHczFtMUw2VTViZUxT?=
 =?utf-8?B?ZmxJeGd0L2xTQ1VFWXdaaW1vNW9NNTUzajkvVmVLcSsyQ1hxT0laNlAwcnZq?=
 =?utf-8?B?RWQvLytPNEYzTlJDMXplVGRDaGxXWVQ3R0ZwQ1RPVWJNRDd5UkdQN3BnOHFQ?=
 =?utf-8?B?WDlOenNwMGVQK2dNWkxEQnJWUGsvV2VYc1Z5aE9FalVIakRaU000dXphdjM1?=
 =?utf-8?B?eEFqQW9JbFlRNXYvYW1aQjhONTJzKzEvUGVhc2F6b05UOWcyYVRyR05OM3dN?=
 =?utf-8?B?RVpydGJHcjdkeEVVd28zdEJIWDFvK29LcVVEUU52REtsS3dWVzRqL0oxMFBu?=
 =?utf-8?B?MjNHV1hRTmRUcWRrVnBSaUp0akZYeFBqOWM5NEZzWmp1K1QrSWhyZHNMS09S?=
 =?utf-8?B?U2ZmN2JYQVQxZ1ZsVTF3cEhSRE9wSlVXSExvQjEwMjNXdFM2UVFpVlZjWWl5?=
 =?utf-8?B?cEtxZXhxd3RqdUk3THFuOG1XQnZpLzRwdVhLODBDRXlQK09DNk5zTmNyd2F5?=
 =?utf-8?B?YlZYZjRFMUlwaHZiVi9mMEZHdHEyZnJ0KytiSE9LTGw3eHVMMGRhbWZ2Wmt6?=
 =?utf-8?B?Qk5RRy92a3Jhc3Vabnl4ZXVMTndKVjl5UXZhdFJxZjlCZW96UmE2bTRRNmN0?=
 =?utf-8?B?T2dXWkFwdVJaSnRXRVJONjdGdGlCYWNpZENRdWwvVmhYN1pCSG1sQXBnbTFP?=
 =?utf-8?Q?wkzj96H8f1IBy3J25pxUmgJy3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bf9834-61b4-4ca1-13ae-08ddcb7342c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:03:25.9297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3+5RBNbFGet/CvlTln41/ROioDCZ6qTTjnM+DP2Fn3RPSAdpG3sNFvaGwBzRUHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
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



On 7/25/25 14:00, Alexander Dahl wrote:
> Hello Michal,
> 
> Am Fri, Jul 25, 2025 at 01:25:51PM +0200 schrieb Michal Simek:
>> Hi,
>>
>> when fpga drivers were enabled via sandbox some coverity issues came and
>> make no sense to fix them when there is no user of these drivers that's why
>> it is easier just remove them completely.
>>
>> Another candidate for removal is FPGA_CYCLON2 which is enabled only by
>> mx53cx9020_defconfig.
> 
> We use FPGA_CYCLON2 downstream with devices containing Altera Cyclone
> III and IV or Efinix Trion T20 chips.  These are _not_ legacy devices,
> few quantities per year, but still produced and sold.
> 
> If you need board code to keep the upstream support, I would need
> to talk to some people here if we can upstream our board code, or at
> least some of it.  That might be difficult though, so if there are
> alternatives, please advise.  O:-)

CYCLON2 is enabled in one board that's why it is fine until that board is around.

Thanks,
Michal
