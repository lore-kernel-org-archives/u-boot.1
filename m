Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3752DC369C2
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A286A82C96;
	Wed, 16 Apr 2025 13:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nR5RXeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8498282D43; Wed, 16 Apr 2025 13:34:56 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14B4C82BA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGg6pT192v5DDGIt9F2rtVkaS+J5ovVDUQYayPZZSPcTjmH47XjgVUObpsSeD1hX7OQkmilT0hd2kYE7vjejduV1DfjjZwbLDlB3cynSGUMv7KsrZTL91tQIuKVYi7CgfbwtmwtXpGNIj3+Wdpbsv0lxYTxJTpqxkpHjgncSmZ3osD00a82uhf0e2CqqnPhY+bl6pGWLkJII5BXbRMTB7i/2uYRrMtRwrdYUtSGsbWMvQ8Sx7ExL6GMYfTgfgetZcoFWrBwc+Qb11ElwEIUMrN8hJ5zB6OBervYsuIn8If+m9/HEyFa78c3SA5AApYTKeq35scNTkh0HtjRG5zVKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZMl8ZU1AxqBkJHSzpHak6PKHEJNDY78nHerRnOvpzk=;
 b=LH5EI3Ep7x8J2ixLz9NGW01rXw4hnk83TESXWBBq4iosNbB42F6jr1I412wOkCsssXft6jGL0/lyK8oEej+AGCiLRw+aisOt54gNBdPBb04P7H32mrs74Xj9V2dOHbZrygtFDz0lwQQ2uDIZmA9Zqph5K4dF9d3XQLGPPro1EmKLrTT6a708+dN7uSACbgHIzLkTqQamg8WN1CBzDXDV+eSJL3XNrzIyruZW6aQZY4Wz6vurA0qiaN7ZXO3QlcVy6gVhC7dR/QxUz0D5X+gyhjlIiYhEj87wxV+YbAfl9aIJ1Q7UM6rtqsBYFgFFnmozZkZprOrD6U95t9M1219CkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZMl8ZU1AxqBkJHSzpHak6PKHEJNDY78nHerRnOvpzk=;
 b=2nR5RXeQU1+y7HGJMmvJgphsfqrsZxtGol6KwKrXxmhW6cxW7KR7+cz03hWgMCc1oJtLlC2berksreZQ7ufIbPAaN7EMSwP3+crlr0tIa5dnSbehIl6lVa2JW8Rc2s972WhhI4YuqZe57oQ6h8BhlL5OPfglm8XX3YxxsB30pmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:34:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:34:51 +0000
Message-ID: <d6c28b7b-aef2-4d9f-97a0-0b229bebfc52@amd.com>
Date: Wed, 16 Apr 2025 13:34:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amd: versal2: Enable SMBIOS command
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <c1e236003c6ec250dbcc5178c873c171fffccd29.1744270535.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c1e236003c6ec250dbcc5178c873c171fffccd29.1744270535.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 88282399-9ba7-4080-eb7c-08dd7cdab351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVdhT0xydXgwdTB3WGNkOE5aTjZKSFFRNFlzbG1JZnRSUm9sWndQRnVZcGUv?=
 =?utf-8?B?T3Yzdmtra1hLd1Y5a1MxdWxDZ0pXYU5wSEhWSWRNOXJFcUFHSVpkMjUvdWs2?=
 =?utf-8?B?Q0piNC9mbFB1dWhJMWlxVi94N0JYa3Z6MEF5Vy9lb1crSzIwa01BWVNQQVd0?=
 =?utf-8?B?Vk9KeXBKdjR0MXJHZFpYQVZjVWY4WldRUlVQaitnbVBiSFlaQUM3NmgrUkxM?=
 =?utf-8?B?Tkt2RXlxQkxMWk9vclQ1YVl1a2hpRGZPK1VQQmlYOXhiZisxcW9vZTNnSG8z?=
 =?utf-8?B?ZFNJSWE1ZlNXd0FSRkc5WWNFaXNnZENZWTNGcytYRzNHdDV0cjVMNWhJR01y?=
 =?utf-8?B?ZUkzZW4wMjN6eUpTa2kxZkpLWkViWUw0N3BQNGRCZVlKS21sdkNhcDNZbDhk?=
 =?utf-8?B?cmxmcnVhVjJRYjg4WVBtcGRBUzhBQnY5ZDBVY0QzTjQ1NXVJT2lIOU9zSm5X?=
 =?utf-8?B?L2ZWa3RyWHR4MFNRSjdwMzM5dnNKMEkzMytmVXdONnc0Q3ViZkhPbmtDOUN5?=
 =?utf-8?B?MDdMcFdURzk3aWcwamd3YWltd1lQeEkxTVlLNks3SGlSbnh0MzBNamo0cXp3?=
 =?utf-8?B?bjYyRzNLbmxRdmVZSzdCMmxuMithT0psQ2xuTUxyNkFKTW9zdmFXZVorRU0r?=
 =?utf-8?B?WURTZWdndkNocExabmdGTzhCQ2ZrZis5VFBZVU5ZMFhXbGlBWXpINHFQT0F2?=
 =?utf-8?B?MkRtanNPZ05RZmlWZ0RScGlrS05LcHo1dHplYVcvVDBuSGpsVVZlWnBBdmdS?=
 =?utf-8?B?Q042WjYrWnNmSWV4eVFVMjBGc2FvZ3pUb3FzRFNsTXBFZWlrN1BqTzdPa3di?=
 =?utf-8?B?NS9mcmVWU3pBbEYwT0NtUXYxZWZNZTM4WDd0aUhERFRLTldjMVd0NzYxbG8x?=
 =?utf-8?B?OFkzRWkxN1F4dnV1dllpK3RmOXM1U3g1a1E1Y2hFOTJKc091bEhPWWpnTG82?=
 =?utf-8?B?Z1JmNGZzenpnT0w3Tk9NVHNFOFU5L1Q4dGdETzU0RXdhc05UM2kwUnRkOThW?=
 =?utf-8?B?Sm1IcXZsUU1mZGJJMVJyd25VUDUzR29xWm1wMlVFTnlSYkJwN2lPWS9OZC9H?=
 =?utf-8?B?SjJCeElKZ2ZkVGhhOEhBNE92aWZpT25aN1hEKzl1K2kvV1dPSUk4YlJwUWZi?=
 =?utf-8?B?cEF3NkliRjh2Z0UxeGdBK1RTc1diaXF1WEVzMlQrd1FEZENydkp0NTRQRFU5?=
 =?utf-8?B?ZGVvK3ZnTmFBN25tZVhCV2w5dWt4NFh1d3VrWlBpeDdDNm5rdis4Y0xaeXZ3?=
 =?utf-8?B?czg1dFVyVE5HYlI0TkVUbnF4RE0zRWY2TjZEYmU2SUZIV0RyZlRyTmJ1alRw?=
 =?utf-8?B?c0t6YjZQdjhLck91NURLWDZNdzVNQ1RsWDFmbHpSSUdKMlVZWlBLWUJVWnRW?=
 =?utf-8?B?T2pheUd5U3I4Nk1zYkE4YUdzSHp1dVBwcmFFUUkrV2JDTUo1MlRsbWptQlZG?=
 =?utf-8?B?SWwrdlcvQjlzNGo3T2p3ZzEvTnlQYUt1WWl6SzVTRGZESFc2STQwOVVBT1lz?=
 =?utf-8?B?bFdEdFk3OUFTTUlla3IxbzNRRlByeWtWR1hTM3NPd1dYM1J5UHgyQkMrTGUr?=
 =?utf-8?B?VGprdHJXUit5VTVkL0s4aTVIbldwMUVQT1pDWSs1VlU3bUtxR3BZZk5hcmVk?=
 =?utf-8?B?RTFWUzZrSDhuWVdDdFVsTzdGUDcybUxpSzFTc0F0ZkJ6OGZwL2dlK2NtbGhS?=
 =?utf-8?B?L1RiaVJqSHFaNDNjTVdTeGJ1VDkyeWttNHo3NWNGQnJweXQyYUtHK0M2K1ds?=
 =?utf-8?B?VFZBaUhEMUFwOTkxV1BFT2o5cjV2d1RSUms0cEQzNUlkUWNPSGJ0TzBsVlZj?=
 =?utf-8?B?Q1ArMURaRkpJNG5QMm9DZGZVSTlqZFhlTlF1cjExcmcyQUJMcDMvTzBGUVJx?=
 =?utf-8?B?b0s3dzdQY1VQZFptUEJtVG9kc1FCZkEyMjBFUngwY1RGcFlObitUTm1JczRk?=
 =?utf-8?Q?Yv+iBMZD/0Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay8zVXlUWHdsQkxBZ3hKai9KeXlhM2RjK3lxdGtUYTlqVWZERDNOZ1dtLzdx?=
 =?utf-8?B?MkZsR0d0S0U2R3h5ZnlaNy9SSGtxVEMrS2VWQ3EvWS9DNUdFTkI4T1NPcGp6?=
 =?utf-8?B?QTZxZHYzak0zckhUQXV4Z0p3QThacUlqc2lUUFdiYlZxMHhUR0hQekpraEFy?=
 =?utf-8?B?SG4zMkloNUg1SjZoZEFxY0w1dTQzVStMSFBsdXZMTEhLWHdEYWlQc3BPUGZY?=
 =?utf-8?B?OFdxMjN4U2ExTmtiUHRpK3ltSHlic29NeVByREYyNlMvUFpTRU1Pb09nQW0w?=
 =?utf-8?B?bmFtWDBKZERsTFNoMFdCLzBsYTN2U3NXZ3RjakIrZXp4Qm5TbmRBVzRBdnpt?=
 =?utf-8?B?cHFrbXdOOGIvWGljQnpPR1gyK1VnZHc4NzBnZTJMNzRLc3g2d2dEV3JlQ1ll?=
 =?utf-8?B?SU9SYUQxd25VYjBNMExadC95U1RwL1dQQk4yNmVtcWpaL01NWnkwYUQwN3dr?=
 =?utf-8?B?QmFuWU1vZDVEY2ljVzNEZjU0bnRSa08zNjBwTGZhUlpjRFQzSmxhcWN6RzFj?=
 =?utf-8?B?UHczYXdaZ3ZlNnBFbFJkT01zMEl4cmQ3KzFMd2hsSng0c01lTGVKUkcwU1Qz?=
 =?utf-8?B?TWIwcEdHQlduZVFsMlhRMUZ3Snd4amFPNmtGNnRxYWJMWUVDYWZoTTZadUN3?=
 =?utf-8?B?b1k3TXVaSm1TcnhmdHFSUW9zeExjOGkxZ3BtMWtxS0lQNnVMVTRHQnNwN0Nv?=
 =?utf-8?B?MG9qVWlPRUxYekxNTGdhNzB2dDY2aytCSlQrQmh0N1dxK0pka0l4c0N6dEVs?=
 =?utf-8?B?Z3BleFlLTDFvc0hZeGZEUjI0T2xkd2J0VlZqbFFUa0owd21UcC81YTRDV0Iy?=
 =?utf-8?B?R214cG5IUGdWNEJDZjArNWhNZytycWcrb0pKdlZqc1Q1ZStmRzhaYTlTYm1R?=
 =?utf-8?B?Tjh1RDg1S0t6STJuZW55cWJmMUZ3Q1phOUUxbmphWHVsMTltaXdLcUNWbVhr?=
 =?utf-8?B?bUZCM24yYXc3M3FIOVFZWHcxNmlnSC9vdVNRL2Z5cnA3RWkrdllmaXJIb2Rs?=
 =?utf-8?B?NkpENW1ZbDNydXNtS2E0WjExMlNoMWdyajNYQjhtUXBnaDBjazBaRDI3c0N2?=
 =?utf-8?B?MHZ5THhEbjZXaEF6cGplMkVYUUtHYXpDS2lpQ0x0V3RCVXMrMmNZeDRxSDln?=
 =?utf-8?B?UWsyTS9tWHJ5WXlweG1yVkc2OFV4dWJrZVJ1RjA1Q2pEQ3pNZ1l5YmZFWkVn?=
 =?utf-8?B?QWwwaStsOTNpYVBWUko5Wkh2QWpoMmluaVZXRE83eHBrUXVkZTNkdDgzTGJY?=
 =?utf-8?B?RWFZUlpCRFVxeElJYzdHSHR4TXN2am0wUGppSUs1YUM4bW9YemNjc3cyeWRL?=
 =?utf-8?B?QTRmODdDL1F4YU43ZFVPcm1uWGx1ZzBJTEFlQW9tMjNtWlpYSkZRVHZBRzU2?=
 =?utf-8?B?QWVhd2RxN3RtTHRaYUQxS3RhNjlpYUdGNWp6STBnb2k5NmF4UGVnTWlsTWVT?=
 =?utf-8?B?QXRVSUZmNi9oMTJBUFlaNUJEeis5S0dVK0p4T3JkRTJMWE1tQ3U3YUdzcDRT?=
 =?utf-8?B?Vk1NNFE0b1lma0NBOXF3bUNBL0pwMXdPdit2Rm1TYUtaYnlETEdUUmlzMXNJ?=
 =?utf-8?B?bVE1RDB1R2tNaGsycXYrMnVhOGNIbTNQSFhCSnNZVnpLcHFDbkI1ZFd1MjNl?=
 =?utf-8?B?ZTFudFZYNHNsZkQvMDdXai9JeUdrNUtpaHl5aEozVFlFTS9EcnYvcUxkTjJl?=
 =?utf-8?B?S3FNZVV4eUFqZENSR1VGM1NPc2VpV2JLYUdIN1F3elU3ZzlBZmNTeloxMDhN?=
 =?utf-8?B?WFdXOG0xUjI0WmcwVURuZHEzZlJwVVkwdURPdXc4VzVpNy9NWEUrMEpmdm5V?=
 =?utf-8?B?WFdydTFhSlNpRUtzU0lIc0VqS0VRWHp4OTdONml0V01GUFcrVHAvWUJ3cTZ6?=
 =?utf-8?B?cW01TndCVHVHUEFGN0phTElTZWc4WTIzMTdJa2tPamY1V0xJRUdibVVBWTYw?=
 =?utf-8?B?L0VBaVMwQlZPWUNOTE9rbWJYY1l3OExlQTVvR1J2MUhNY3grUXFnQWUzQmpy?=
 =?utf-8?B?d2hyTGNaVFpSV1RMcHcwWVo2ODdtdmZZYnhpSk5GN0lvUkprbmVoYUJlenM5?=
 =?utf-8?B?SlNubXNwNDBldnp0OW9RRm1NRG9JaTh0VlhKNVJoT09lSmpwYnhXVDlicjRC?=
 =?utf-8?Q?/XWfpR1i4dTDQ5ILpStjyFhKX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88282399-9ba7-4080-eb7c-08dd7cdab351
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:34:51.1902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKvfjubJkKi1kONNkJI3sUj0kZCjZhVFiG0eYHgFiSvUOsFvlgTzr/8SL6rypIQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/10/25 09:35, Michal Simek wrote:
> Enabel SMBIOS command as was done by commit aa815e6c7603 ("xilinx: Enable
> SMBIOS command") for our other platforms.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index e19d0b5596ab..d722f3c811b4 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -25,6 +25,7 @@ CONFIG_SYS_PBSIZE=2073
>   CONFIG_BOARD_EARLY_INIT_R=y
>   CONFIG_CLOCKS=y
>   CONFIG_SYS_PROMPT="versal2> "
> +CONFIG_CMD_SMBIOS=y
>   CONFIG_CMD_BOOTMENU=y
>   CONFIG_CMD_GREPENV=y
>   CONFIG_CMD_NVEDIT_EFI=y

Applied.
M
