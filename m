Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA0AC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 03:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5610480104;
	Wed,  5 Feb 2025 04:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5bWFv9Ep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83EC5801F5; Wed,  5 Feb 2025 04:44:14 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9866280087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 04:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUBzggVC6bL8fGbJ6UGNjJhJP+DRL5EFV/zaSW5nVZbA3I7Wqu1sr1vtfBczRxe4dTUyyou2PmCdEi5uwX/If+U7lIZuV68BUFLs+VI+gu5xArX1zDZ2g1lznuO4G4AqFdjvsVEsG3D2QmWMYcgQWjzgaD4nh3sLS2qkpHGG6lmv6qCIRn1pbkqkMIGttfwhw1vvebtIElyP1b4dwaJMiJlbw7jTJ7ajfguT1rK2K3XJkRc2mYZztkUKSWdvVpJqSE8tCIjpPnnLE5K3NIga+uR1Ad6hWsXfHBHIXzo3mxhbKXDQ3toE9COCpalrHTQgqPbCqFYq9zA5tvwquLI/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS5XGLsgsPPKh0LZS1qrWnItCnUKfKQHtbsr8SiR6IQ=;
 b=bUIvFAm4YZQycplmpYTIOWjwpIIG9nMoXD016zqIuc5V2TCXqu2jpXoPlctKNz31nq5oiCMNXgSmrsqiO7lQ5eVlOGlCUZpqrxkN61uT/exGf485wuhoMucF7nDJmcjSZbGKjErx8PR7bUHMhc6vF0BVzGwv/IJcE5Q3SXcT4w/wI0vwWpopr48pCvfXTHzsJvtqiD0Kb5VrbCkCKmUqyDAwwgNqejh5BIL2NIvedpA96zC9eI0sZyH8Bmm+JDlZtES15KsDJboI/d+TjHCqFSOd/uxHER4JVrpbdEvClzo/h6cPjDOymv1gYKiVKS0hKoA89AvgFamYykJ+TgaYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS5XGLsgsPPKh0LZS1qrWnItCnUKfKQHtbsr8SiR6IQ=;
 b=5bWFv9EpjGqFgHMe+rw/utJufBPsuVqj8p+HCQ3JuOLJkEOSFLcPGaV6WV/tWjmDRKO9fbMNmUvovu9qDCCZiB6MPXhyttV5ZwCdANWyYap4MUWvtyR9kVLYslCCuxFfxn6jJShF0enFXNRx5oVNtWtXc26P+R5rh1emvhvL0Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 03:44:08 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 03:44:08 +0000
Message-ID: <a4f191a6-071e-4202-9578-85502c3da88d@amd.com>
Date: Wed, 5 Feb 2025 09:13:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Fix page permission on arm64 architectures
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <b0c9dc17-4229-49db-beab-7a825270be8f@amd.com>
 <CAC_iWjKQbJuGcxbdgC=E_yR1vFr8E+NjkxDPs2y0jw52EtLm1A@mail.gmail.com>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <CAC_iWjKQbJuGcxbdgC=E_yR1vFr8E+NjkxDPs2y0jw52EtLm1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 391f937b-03f5-4910-0e54-08dd45975854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXd5MGxUMk9CWjdQeXFZTW9jbnVRV3FlNVU5TGR3MlI1eEJ6QzRtZ1FKQjdM?=
 =?utf-8?B?bWowMFFsSWljdktpaUo3NUVMTXhXZmpETTJqdzIzcU4rd1JnWHNPaWd0MENF?=
 =?utf-8?B?Q05tRHJMQ1NadUdLM3NUZFFwOEcwRmFTaW9relF0RGpXUTBnZ0lCWFA4blZG?=
 =?utf-8?B?VzNabDFkNzVXS1VLN2d3QXR2b21WdkRydFhXa0ZaT1VPNFFhRUc1YS8xd0l0?=
 =?utf-8?B?UE9HMThLTWxITU5adGt3Mm5aNDlnV1ZjdGVhcGs1UjdvY21WRXlpbkxXOWZo?=
 =?utf-8?B?UXk0WGMvN0RiSk8zbVB4bEFiNldvTzdlUzRPNWZxZmtMWElBNEt3Ty8zeWdk?=
 =?utf-8?B?K3hNQ2x0T2tEdCtGODJGdUxucHAwUGF0RitlSEk0WnVrQ1Juc1lmSVFpUTI1?=
 =?utf-8?B?R3NzTU4ydi9hNEo1U2lEc1FESzhNWE8yUVd1amk3UnM2L0E0NGFHTERLY1Y0?=
 =?utf-8?B?QUkvT2hMQ1Rjb0RkMDgxMVR5Y1VoR05LVmVWd1RlZVRrcE1Fc0UrUzNsSjhw?=
 =?utf-8?B?V0krRVFDN05WZmMvQ2VzMzBacFZVNE55U2NwTE1IZmxVRC9GUTRUVFl0YVFT?=
 =?utf-8?B?OC8zWTZPN1RScHBLZjBQcDYrbG9PMDlHNkpDU2l0WGovdEJIMEJ5VzQyNWRa?=
 =?utf-8?B?NXB0TG1KZVF3SDZmc2M3WWlYVk8xMnhrMTVzbjB3RTRjcWdCYTNoYy9SbW5T?=
 =?utf-8?B?b3NnMEZqUGRQb0xTekhjMGFUSjdhR2E0UDh0TWZGbVR4TVZhS1hnaUN0UTV0?=
 =?utf-8?B?aG9tZ2NEbXJaVmNLR1B5VXlwanVPWmNYdGhnQ0hMcWpoOFdTQUNlT3hITWlW?=
 =?utf-8?B?WG9HZ1c3UGU2cDF5VmEzNEVTZ2taQ1RnM2dCR2o3UVYrVFBrYVdmbThXVndj?=
 =?utf-8?B?djk2ZEcwdW9iK0JJOWVSaW16Qzdac1ZaUzBKZVlxUnpNU3FkRUF1YlM4bER0?=
 =?utf-8?B?V2VuSFI0Zk5kRGhZM1h3REh2aTN5YlRJTlJPbTY0SFc2Tm5rRUhQMlpTTFUy?=
 =?utf-8?B?YVI4MFZReVVPUXpCbzZLeGZzOVRmZVNNNEJLckRoTy80bFJZakRBbURPTDI1?=
 =?utf-8?B?d1BmRDMxTlUxR2RWTUJwMG9mUmY1MjJ6OWhrLzl1NUJVVFU4Y1A1dCtaWnNj?=
 =?utf-8?B?L2hheTZFZUpsOXZ4UmNtekZWYXZLeUxqRVc1WVFFeTVSNUNVcnEyK3JTNGEx?=
 =?utf-8?B?aEtFL3BqUHFQT29vcGo4R3BsL09rWHlHRm1LYWo3ZnVlc25hcHRUeVZDREM0?=
 =?utf-8?B?cDFPSFRKcW1leW9qNHZ3U0JoTW9Ja05MTXVoaGw3dEljMDlOTzNsVDZFQkY1?=
 =?utf-8?B?SWdnWkVpV0c3WnFOcklkL3dQNXIxNHp3d3kyZHBiY1Y3TVF0SmI4QlNyeTNw?=
 =?utf-8?B?dlZ1MVd5Mmd3YlFuQTlZM1BVcE42NWQ0TUNyVkk4L2h5RiswRFdOTWdDKzU1?=
 =?utf-8?B?RUJsRGRkZkxXZVNwK0w4REVBSEthanpRbC9aTCt4d1N5cmFKSVErcXk0Rmpr?=
 =?utf-8?B?emJQYUdWcjFUbDY0WVcxU055WkRqMFBCczRHZHdBRy9YU2V1V2k4TVVONklm?=
 =?utf-8?B?R2MyTFNERStMdFN2Tk1jZ3Q3OURVWWJjYU85c05nbnJvMkVRb3UxTjlVZUFJ?=
 =?utf-8?B?ZWplVHZ4Q2llVVhYWHJLSHFLYjRVbGoxaE9GcnFnSXZVeU5ZTk5HWXBxa01p?=
 =?utf-8?B?aFRZVXFHVU4yK0MyMHdKTFBtSmozd3FpWjNWQVM1OFhKcmE3a05oYVlQY2l4?=
 =?utf-8?B?MWZ5K2dlMk5PbStpY1hJY3pZbGI4K0tjajBzS1o2UnlOMDFhNTZUQWNLSVVy?=
 =?utf-8?B?WWZvdVRCcHB5SVZaYyt3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTFEWUpxcDRmZWMvUnM4KzNST255OW1uM0NiL0NiKzk2VVUvVlQxQU11UXVt?=
 =?utf-8?B?SjBjM2JTcmlnMVJRZlNDai9JVlUyRkR1ZzAzRWVZNXQycEpKR2J2cVpEOXk4?=
 =?utf-8?B?RVY0NnZKd0tQbzlha2JJT2hNTktUbnRkQ0wxOVNBemVvR3A0amtYai9BTkgz?=
 =?utf-8?B?aEJScy9UMjAvQmdRbWlrV3diL1RCR0NkTnBMSzNFWkNpVm1sR0pVM1hkOGVC?=
 =?utf-8?B?bW1YMURPSTgyaEdwcktUUlJtcjZZYkdQTUc1cjZ4V0J6WFZ1U3ArZWlmWkND?=
 =?utf-8?B?bDZWbEMzQ3JtT0x0RTBhb3EvbWp1RFQ4MWY2alJYMGFIWXlxemE5dnlHTk9F?=
 =?utf-8?B?OWc1YkUvaTNQaWUvS0xtOE53a0F6WjhrYThsT01hWHpoY0tNUVh1T1R0Rkha?=
 =?utf-8?B?QWNsaVMrelJzNzJXSU1jUnNuMCtRTEZsa2xaa2tzVElrbEtwTzdCbXlYSk9r?=
 =?utf-8?B?bVVOMXM2dE5wMnYxMzROaDYzelRaV2I2dTg2eElEdGcvTFQ4dlBJVTZqZVRI?=
 =?utf-8?B?Z3hkSVlTOWYxNzZQNllCYW9NUzlmL3JMUmthUTBpZ0hRVVpxVnZJOFdBYkFU?=
 =?utf-8?B?YTA2cXBWUkRZL0prblZSbjBSSEhMaUxzR0tuRDMzZUlYVk9CcjVLdTkwSHZn?=
 =?utf-8?B?cGVXOUF0akp6Vjg2WmNyQ2hkQUFua08zY2lDVkVxTHlMelZKeEZUV3YrZWp1?=
 =?utf-8?B?Y1FIRllTcVVyZmY3TGRaMWtKQ3FZNkQ3cHVMK2UwK2JYN1R5Mm9QVlpzUXg4?=
 =?utf-8?B?RSs4dzZjWGhsbU9Fd1FNTmZ2UWRTZHlGZkZNcXZtQkZBbEQ5VlJFNGpvZ3FQ?=
 =?utf-8?B?VzV5Kzh1amp3eVNMRngvRVZnSWZkbm1VejFpZWw0VEtIWFgxWnJLYUJNODJv?=
 =?utf-8?B?d05PekQ2cUh5QW5pcHVLa21PSGtheHFDNnBvMEV3NlJPVzNLcFEydGk0OHVH?=
 =?utf-8?B?Nlh0NjFaUnFvd1h5RmpjMkJsVlBMTGh6MFVoOXNxZlJENTg4RkUyVndYUVRp?=
 =?utf-8?B?eHBsblRUbWlRYkFUQ2JEd3RDZXBUZGtPeVVlWU1hdEgyZXVMNjVoV0dHQ0Fr?=
 =?utf-8?B?OFAxZmFpOCtmZmxpZ29xZmJSdVNCRTBXZnBmNzhHVUNoNk82Z3ZITW5ubzdV?=
 =?utf-8?B?MWlDOTVFWEZWTVNHNDdQa1pyTGVacCs4akNuYmZVeFdBMUsrTHprR1NyTzIv?=
 =?utf-8?B?REYzUkNnR215ZUx1cjB4Q29pRXBIeGhMTElneUFWRWZIUXVzbnVUdTQ4WkRN?=
 =?utf-8?B?Uk9DVmtJZFhIQkdmNmxFWjlpNDRBR0JZUlNKZk9hRmhXK0VGQXZNcU0wYkFl?=
 =?utf-8?B?djRKUzhvSXdJTFBXeGM3eGdRWlFCYUIyVG1FSmt4VU8vTWRNSUdKa1ptY1JP?=
 =?utf-8?B?bE8wR3hiZmE1c29wZno2cENOcHdoUnNNNWYzbnQxRnRrL1EwQnFKWDA0ZFox?=
 =?utf-8?B?QWVBcUJudCtjUzZYaFlhN0c2Qmd0Ry93OUM0ZDJIUzJsTEJHTFg5WGJZWWdp?=
 =?utf-8?B?a0h6RkZQeThETmxsdlh5VjhWRlI2VkdmZHZTRnF0bUtDS3VWSDVTcFhObTll?=
 =?utf-8?B?eFE0MytVcXhTYXVTM2RCeEhRSDY2ajFlaEpPd0pFMjM5Q2tYQTc5LzJxaldq?=
 =?utf-8?B?L0NWNTZVaXI0QXNIZS8vNXhUYUJKYm5ZbFFhTmI1Y1U1ckNPMFJaam9udDFP?=
 =?utf-8?B?ZC8yaldCWDlHbUE1cTJ3VU01eWJaSzRkVEVmTkVZV09NVWoyV016TWI5TjBX?=
 =?utf-8?B?TDN6bTJydS8vS01aRlRzd2NlQnVwRFc2YkM2ZEhOZ3IyMFVZanp0S3ZXVytP?=
 =?utf-8?B?eFU2aUNZOW1CT0NQV0w0emhSTXFTRlo2cWRqOFBwdElsWEhoazExYkJkOFZs?=
 =?utf-8?B?OE1ubXJDQVA4RXJaektHSDdDYjhDQi9xblpOdzU3eDFVaUNBSFFycDZ3Y0xS?=
 =?utf-8?B?K2JPTEd2Sk8vdmw3WlloM0N1Si92cUE0REtsLzlQN1NQbzBoZU5pendOMWhW?=
 =?utf-8?B?TWJIMFRoWTdtTUhUNGhlVFR5RkEraWhvTzRaSWNubURpSXg2em1McnIvUkdF?=
 =?utf-8?B?KzNPV3lEYXcrbHI4Tmg4dHNhYlZmZG9wUGtFUVlmVVpEYTYzVFpSdlJ5bGla?=
 =?utf-8?Q?YjUIOtHxbejo0k2i01nGwEFia?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 391f937b-03f5-4910-0e54-08dd45975854
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:44:08.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtfVwydXECe6IYeoZLyw4V+Vtlm7DuyajzsiuST1xgDZ6FGW4pUM4g/fN8dCMpB6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
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

Hi Ilias,

On 04/02/25 5:42 pm, Ilias Apalodimas wrote:
> Hi Love,
> 
> On Tue, 4 Feb 2025 at 13:53, Love Kumar <love.kumar@amd.com> wrote:
>>
>> Hi Ilias,
>>
>>
>> On 30/01/25 12:50 pm, Ilias Apalodimas wrote:
>>> U-Boot maps all pages as RWX. Sadly it's not not 1990 anymore and we are
>>> better off mapping binaries with proper permissions.
>>>
>>> This is an attempt to map the U-Boot binary properly, but leave the
>>> area we load binaries unaffected and RWX.
>>>
>>> patch #1 adds printing capabilities for page permissions in meminfo
>>> patch #2 prepares our linker scripts, aligns sections in page boundaries etc
>>> patch #3 is adding a function to change page tables
>>> patch #4 sets the permissions for .rodata, .text and .data
>>>
>>> There's a few problems problem in this RFC ...
>>> - U-Boot has no MMU APIs in place. As a result I just wired up the function
>>>     changing the page permissions in board_r.c but only for arm64. In the long
>>>     term we should add an API that other archs can use if they wish/can
>>> - meminfo doesn't align all results properly (Caleb?)
>>> - I am not setting the permissions of EFI runtime services section on purpose.
>>>     Since the OS is allowed to call SetVirtualAddressMap, we need to reset the
>>>     pages to RWX just before ExitBootServices, so the OS can relocate that code.
>>>     In arm64 this isn't a huge problem, because we explicitly disable SVAM if
>>>     if VA_BITS > 39, but other OSes/archs will have a problem.
>>>
>>> # TODO:
>>> - Long term. Add an MMU API and use that instead of exporting arch specific
>>>     functions
>>> - Add an enum in mmu_set_attrs() instead of 1,2,3 arguments
>>> - Set the permissions of EFI runtime services anbd reset them before EBS()
>>> - Fix alignment when printing pages & information
>>> - Add a Kconfig option so the feature can be turned off.
>>>     The reason is that QEMU CI and some boards, fail because they are trying to
>>>     write RO pages. This usually happens due to variables being wrongly defined as
>>>     const, but with the updated page permissions this leads to a crash [0] [1].
>>>     In both cases the reported ESR is 0x9600004f which translates to
>>>     "Abort caused by writing to memory" "Permission fault, level 3.". On top of
>>>     that not setting pages as RO (and only setting .data and .text sections) works
>>>     fine. So until we find and fix the bugs above we can't turn this on
>>>     unconditionally.
>>>
>>> # Open questions
>>> - Is initr_reloc_global_data() the right place to change permissions? Or is there
>>>     a better/safer place to do that?
>>>
>>> # How to test patches
>>> - Aplly them an enable
>>>     CONFIG_CMD_MEMINFO=y
>>>     CONFIG_CMD_MEMINFO_MAP=y
>>>     'meminfo' should print something along the lines of
>>> => meminfo
>>> DRAM:  8 GiB
>>> Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
>>> [0x23ffe1000]                     |  Table |               |
>>>     [0x23ffe2000]                   |  Table |               |
>>>       [0x000000000 - 0x008000000]   |  Block | RWX | Normal        | Inner-shareable
>>>       [0x008000000 - 0x040000000]   |  Block | RW | Device-nGnRnE | Non-shareable
>>>     [0x040000000 - 0x200000000]     |  Block | RWX | Normal        | Inner-shareable
>>>     [0x23ffea000]                   |  Table |               |
>>>       [0x200000000 - 0x23f600000]   |  Block | RWX | Normal        | Inner-shareable
>>>       [0x23ffeb000]                 |  Table |               |
>>>         [0x23f600000 - 0x23f68b000] |  Pages | RWX | Normal        | Inner-shareable
>>>         [0x23f68b000 - 0x23f74e000] |  Pages | RX | Normal        | Inner-shareable
>>>         [0x23f74e000 - 0x23f793000] |  Pages | RO | Normal        | Inner-shareable
>>>         [0x23f793000 - 0x23f794000] |  Pages | RWX | Normal        | Inner-shareable
>>>         [0x23f794000 - 0x23f79d000] |  Pages | RW | Normal        | Inner-shareable
>>>         [0x23f79d000 - 0x23f800000] |  Pages | RWX | Normal        | Inner-shareable
>>>       [0x23f800000 - 0x240000000]   |  Block | RWX | Normal        | Inner-shareable
>>>     [0x240000000 - 0x4000000000]     |  Block | RWX | Normal        | Inner-shareable
>>>     [0x23ffe3000]                   |  Table |               |
>>>       [0x4010000000 - 0x4020000000]   |  Block | RW | Device-nGnRnE | Non-shareable
>>> [0x23ffe4000]                     |  Table |               |
>>>     [0x8000000000 - 0x10000000000]     |  Block | RW | Device-nGnRnE | Non-shareable
>>>
>>> [0] https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
>>> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/1008714
>>>
>>> Ilias Apalodimas (4):
>>>     meminfo: add memory details for armv8
>>>     arm: Prepare linker scripts for memory permissions
>>>     arm64: mmu_change_region_attr() add an option not to break PTEs
>>>     arm64: Change mapping for data/rodata/text
>>>
>>>    Makefile                                | 15 +++++----
>>>    arch/arm/cpu/armv8/cache_v8.c           | 45 +++++++++++++++++++++++--
>>>    arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++---
>>>    arch/arm/cpu/armv8/u-boot.lds           | 32 +++++++++++-------
>>>    arch/arm/include/asm/armv8/mmu.h        |  2 ++
>>>    arch/arm/include/asm/system.h           |  3 +-
>>>    arch/arm/mach-snapdragon/board.c        |  2 +-
>>>    cmd/meminfo.c                           |  5 +++
>>>    common/board_r.c                        |  7 ++++
>>>    include/asm-generic/sections.h          |  2 ++
>>>    lib/efi_loader/efi_runtime.c            |  2 ++
>>>    11 files changed, 97 insertions(+), 28 deletions(-)
>>
>> This patch series is increasing u-boot size by 13kB which is breaking
>> our mini u-boot configurations.
>>
> 
> There's not much I can do about it, since sections need to be
> page-aligned to be able to set permissions.
> On v1 I'll have the option under a Kconfig, so you need to keep it disabled.

Thank you. That will work for us to keep it disabled for mini.

Regards,
Love Kumar

> 
> /Ilias
> 
>> Without patch:
>> text       data     bss     dec     hex filename
>> 0        115632       0  115632   1c3b0 u-boot.elf
>>
>> With patch:
>> text       data     bss     dec     hex filename
>> 0        128688       0  128688   1f6b0 u-boot.elf
>>
>> Regards,
>> Love Kumar
>>
>>>
>>> --
>>> 2.43.0
>>>
