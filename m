Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78E4C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EB3883123;
	Tue,  8 Jul 2025 15:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Er1f9/Vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33AD83323; Tue,  8 Jul 2025 15:07:10 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E718A830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1RYUHnszgmyw4D9/234AVCeWlA+coqfHP3N0b0Z+VYBV8Yyle5lUo2y6QniCADCd7j+gT2IYhIqdUkBqX7o6pF2LC5luqwRN/SD0m5re7JpxkWBdqP9PrJzQhhIl11StZ9Iqk8Edw5yME46a9TDFJvpGjJE3NNjoZ5DodRSOx511/d2JIduTXJt43nqTeqMls7CPPJYpejDsbbCo7wPH2xikSHuq7JTOxKlzBml8M2G9xYaU7a0iKf7C0Gk/Qad4ODm/1baUR+p7R86q+uWWZwpvpvGxr9aLjg/gVA/JsjWH04vTghnZR4rzoHUDODbXjae+VQ6jJH5vVHxiQehzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtLA2Zgx4xoAWHRpLmL1umYjz/oZnYie/wPdWAmPq8E=;
 b=A5zX58PqZ7L19gHwNdhNMS1fbAAPqBb/2hdj9k8L6P44FvwwyNlTrxtECoJytVXskU29rub0uU6exnX6/QFQD01IjGdLanWPrlltGwSfdLeunfdT/SH/rxImKSDf+Hppp2t5/ZOYC5Jlg9kL/JwoUucmSQ750VSxnjgRXhPqHPEocr/8poYrh1dFMw9HsH10wskinKvB0JzlDjDcXtY43P4YlQZZjhdk+ok47EuM4yTGRubA83PqP42guJ9q3SMSF7y4wETnnj/VkEwiv4zgLl7CkknOh6NDXX0YrvJJ30nStded751haAQEDaXvJzCKRv+6TSMF5UTM/U70y0AO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtLA2Zgx4xoAWHRpLmL1umYjz/oZnYie/wPdWAmPq8E=;
 b=Er1f9/VmONYXWA76Q2UiPiZS9Ir2NrsWllH80bUNfIcea1vAOi6o/R6E1BWt4BO0OurAh7VQbE8gU5uu9rpzPYNpKP8sVKXOBOcNlFK0Cp308xEHoRtTKojkZideTqLbxma3s244kqNi0Ym+15v5TE3V9B9uFJ7Isz1Z3qCh2bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:07:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:07:04 +0000
Message-ID: <ec321fba-d03b-4cae-87dc-07846cb8d893@amd.com>
Date: Tue, 8 Jul 2025 15:06:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence_qspi: Fix odd byte write issue in STIG
 mode
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: tudor.ambarus@linaro.org, j-humphreys@ti.com, marex@denx.de,
 jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: c934990b-6471-4dcd-09d0-08ddbe2055d1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHgyc0RRVFNNRjRsS3RZZFMyY050NVpKTGROWUI1cjNlRGVVZDhaYXRxbTAv?=
 =?utf-8?B?N3dLZjNreWFXcUNhK3poc1RzZmtDN29HaVNGZHhncGZSU0lnUlk0dGhLSW1D?=
 =?utf-8?B?c3lCckF2ZTVzcldZSTNzSkNvbjRrVzBjalFMQzFjZk5pQkRlYWRLN3BjZ2JO?=
 =?utf-8?B?eW0zNjZLMm03ekZDR0JMQnF6QnMzc0VqMVNramF4U2oveUlWbjRFTzVzOWtz?=
 =?utf-8?B?WkhCakVJNUVjeCtWeWVQWExCOFZNUm95dlR3SnI1b0VQWk5JbVE2U1V1eE9m?=
 =?utf-8?B?OTJpZ0xDZnNaNDRzaDNFdDRHT1NqZjRsL2h5aEhOQ1dqVG1RTFl5ODJRQm1y?=
 =?utf-8?B?MWN3RE0yVHVZVGFtK2paT3l6czZIQkJ1UzhTUVZIWXZtem55bVI2NnJSQm52?=
 =?utf-8?B?NUdPWktPa2ZqK0l5ZDl2TjVWZ2pOWFkxSk5ZWUN0NjErZUl4QnFjRnRibXA3?=
 =?utf-8?B?VXplUXVXclh6OFJSLzYrYlFRNGo3WkFUWkdsZVdIMWxiZ2pVK0M3MkJWZCtW?=
 =?utf-8?B?UENtaW5KVFNYZjRORU5hMkZ3K25PSzN6TEFQVmRhV09JcHh6VDdpZ1ovbDds?=
 =?utf-8?B?dEszZldEb3JyYitvakl4WDdVWlBYZlpvdGMrbVBoNTVIbHNGZHVnM2x4ZXM5?=
 =?utf-8?B?c25qc3E3UDR0WVBRa1Nwb2c1OXR3S0FWVEErYXNHb0pPTzRFc29ESmcreVJE?=
 =?utf-8?B?U0d6US9QZjFuazQ5UmJISHdmNXllMjVFV2c2Q3hTSGk2Q295a1IzN2xjVjl6?=
 =?utf-8?B?R1FRblBSaURhQ0VEcEwyUWQrV3dPUnBmWlQyL0Ryc2tTc200ZTA4ek50bExK?=
 =?utf-8?B?ZFJwUGRyREg1VCszRk0zYWhuZDU5RlNDYVRmV1NrSWJaS0R0Rk93ZTZmQTJu?=
 =?utf-8?B?R2ZmelJHYXphRVhtc3RmL0RCMlNmMXJXZGZ6VTNlTnJCdkJtMkhzNGtrdytG?=
 =?utf-8?B?VXRkeWpadmxWZnVQVlZOenE5RGdZTHZ3T0NKVGlibWtSMnRTWC9XeDlFUU84?=
 =?utf-8?B?Y1JaS0FxMll1VTg4Q0xTS25hbWFMMS9nS3pud3NWSno4UGlOVENjQ0ExZEla?=
 =?utf-8?B?UlM4K3VCc0dqVzdJT21kaFBvQ2p3cmN0LzArSlJ0Y2YzcEZKdkVXT1NqbGVi?=
 =?utf-8?B?VUVTWE1GU0NGZFA2dW53M1FvYTVyZTVJSVRNNW1kendVS015QkpLZXB1aHdQ?=
 =?utf-8?B?VHJ2dThCV0taU2ZXRnVJZ1VEeWhvQnBERCtjRm9tcFh4MFR4aU1ianlzSnVt?=
 =?utf-8?B?dDJIUlJldlVDeFArU0toN1Nkb3RCZ3BBSkNGNmNqL2xKRXpFZ1F6N3p0eFZ6?=
 =?utf-8?B?WTV4bGd2VUdVOEZudnRJTHl0VEhMeUxxWTc2MldoZVZlT2NuaWFOQklRU0Zw?=
 =?utf-8?B?OXZMeFZoTkR0djFxUXRhTlJ5UnJSUGc1UWplVFJzcU1ncERiRTYrd1RxdFZz?=
 =?utf-8?B?ViszcUFSdGR0NXZnaExlajBnTlpqK3V4dEtVeDZyOTMvd1dJWVVNS2lrdWhJ?=
 =?utf-8?B?ZGpKeEtNeGZlL2Y5d2taWSthMlFMclNIaE5BajFrdEN3TGZzRndjVlB2SmFL?=
 =?utf-8?B?aU43aHdtamc1Tlh5TWZMWERKMzlFNVd0YUJ6M24vU09GVXdBcVJOMDBXVml3?=
 =?utf-8?B?MXRoZDRlVnRBMXBRUWpvNW0vbjJERDRPT2xiTytqZzlVNSszSXNRMGJaV1hF?=
 =?utf-8?B?Y05FNE1oRVQ1UjQ3UG8zMDJCY1NMbXI5S1d6TDlicGFDbERWandSeW1lVWpJ?=
 =?utf-8?B?c3AvSWNMSFBNRzdLZGpyaFpSYjN3d2NnaGxhZURjcjQ0M1QyMzBCSmVWYXFM?=
 =?utf-8?B?aXh0a0JqT3RoUFlRZk1iOVh5Qm0zN09zTFlTQlpTOGZZQzZWckdTVjczdnBS?=
 =?utf-8?B?SndMUlQ2Mmo3YkRMc2lyTzB6NlNkeTM5NGc0MzN2MzlkdXJUVDZmRWNkdmZQ?=
 =?utf-8?Q?bz6Mu8vO0VI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk9UQXpDVFJ2RGhrdFVsWCt3MGQ1MC9yU0hwNHU2NG9Mc1JMWWxqSGJZc2hN?=
 =?utf-8?B?azR0WjdxV09YeHBZMzcxSWVKSmlDZmFmc3RPZ2VXWGFjUWtPbXdtbXZibUh4?=
 =?utf-8?B?SGgxbUQxNWdMeSt3d2YxRncyb3I5UXZ1M2paMWZZaGpBWnhicTlvU1luR2s5?=
 =?utf-8?B?VFNSQWQ1dmdicXRCTWJxTy82SXRSWWt6Um84Zjh3ZFVqeEpBNWRRcXlUS3hT?=
 =?utf-8?B?VUpuNWowcktOeHZUeUhuU0RQeTIwUkc3bXlVSTRQWFRkVmI4Q3NpUEVteS9V?=
 =?utf-8?B?cE9rZ3QrWXdGc3hqRGUxZWkvdWlha3FSdXRkZzJBRGRFNWlSTkxQMFNDZHY4?=
 =?utf-8?B?VmlEd2h0R0NMbWIvcE5zWEtJTWdRN3g5VERmeFVLT001SERPQzZFbkNzR01X?=
 =?utf-8?B?YWFuNzJ6a2wyN0lXblFEMVFaWG5qZ3BCWnZGNUR1YUgxYUJpb2J6UWFEQ0Nr?=
 =?utf-8?B?Ny9pOXg3MXJ2am1DMFFjYjYvUjFoTklaNVhMdFd2ejBDUUFpY0V1R3IyOVI3?=
 =?utf-8?B?VHJycXFRbHdJWk54cmJOZXpsVWRrUmEvZitEbmhSaDBBakJ4dE1kVzE4ZzFN?=
 =?utf-8?B?akMxcWREclNobHNJRjVpTmNkZHpMM0tqZHpsVUNXUkJ1YmhNeUdKZVdqUjZL?=
 =?utf-8?B?TW14VzYzQ2o1MmUyVzVBZ25SbGVFNitMQmJyZzlLajNrYnZjTWhWbU8yNmFp?=
 =?utf-8?B?dGREeU1xeHp2SDBQQ09QYXAxcC9KT2R6T0xmWE11N2gzeGhkVlNvWVZMK0lI?=
 =?utf-8?B?aitxaytuekZkdU9KdjFtNVN2VWh2WCtYL1EyVG4xVVRRZ2w0M0JVOEVvVHJ3?=
 =?utf-8?B?UXFDd2ljK2NJNmRJQndEa0xibm84YUFHQWlrWC92T0NVV0N3R2NLOU1iQytV?=
 =?utf-8?B?azhhUWkveW04VFRKZVkrS0lBTHRCZTFjeU54TDlOeFNFMjZpUGVVRk5ucmVy?=
 =?utf-8?B?MnZTWWNaUEVpNXJHZk5oSkhmTXF6emw4NVcrZno3dWVPOVZ6NEVjQitCQTlL?=
 =?utf-8?B?dWJiSlEvOGFCR0RKSjlMOHhQY2dBUE1MMXY2WE1CaWdoMUM3aFcwTzcvUDFO?=
 =?utf-8?B?NFRrMFZqcS93bGNhYk5HWmtMU3lYQ3crd0tjYW95QmFxMjVMT3U1czVUZXpT?=
 =?utf-8?B?a2s2UjdXdDZhMEFMNEIrN3lURVlwK2ZRd0p5Q2t6VkN1QnFrMVBLaFhmL1hj?=
 =?utf-8?B?U1VTZG5FME8rWTFmQTh2ZDVQcU5pZlYvM0VMU2RrUHhjWXZrR0V5N1pBMXJk?=
 =?utf-8?B?RXVUNFpCWGl2VU9EUFdkdnRoL1FHOXpWUU1MeHd2SGo3K3JrY0tMNDJVNnRK?=
 =?utf-8?B?a1NYb0xnU2FJWUtmWjlqQXFaNXIxa0RWamVrU0ZPdDh0N1lYTmIyUmRKNHR4?=
 =?utf-8?B?ZEVHdGtxQmNPd0FNSUNXRktrYXJwOFBpN1c2bjdteDVnY1cvYWR3eWpWSzVY?=
 =?utf-8?B?SXF4QzI0bitkNkFrNVk5R0lpWE41REY1cDRwTXZtNndMaForaWVFWDhaK1Rz?=
 =?utf-8?B?QUJWeTNwdnNSYkRIMXRtU0h2ODhia3hYQncwRlhUOVVxVW5RcEhEL01SSUJv?=
 =?utf-8?B?N1ZCTDdpamZwM3cwSWpybmtzaGdka0JndEg5NUJVT1hmWGZqZXdMY0VrQklK?=
 =?utf-8?B?Z2l4MkxZdGk2N2Q1Zm1GZXJybXFUOGFhb0dQSDJJY2tlUCtGSUdLSitpZkVT?=
 =?utf-8?B?b0dsY1c5OHhpOUFMNkxsZ3dvZEVYa1hvVjVHcERHNmUybktHbmdHYUFUMDdm?=
 =?utf-8?B?NHFSbWRiOFllV3lQODhhTnNWM3YrQ2FzZE9iWktUT3cybzFpWHFQUEFoV2hD?=
 =?utf-8?B?VzNtMEY2bFN1bW1IemhWUEpOL2ZYZ0s2eEoreHVVbS9NRTB5S2tMbmc4ZmlO?=
 =?utf-8?B?ZldpbWF4N1NHN1pnVXVScmZoZVV3NktWa05jcDVxZGtBWDIyN3pieHh2UWE1?=
 =?utf-8?B?R2VYeHRlZUhSQ1JqVWxCSWNPbzkwbjdkOWRvSlFvNUluNnlHZ3pETVhGTmxD?=
 =?utf-8?B?Y3lRMTM3cUdURkR0cnBlck1vaTNOU0d3cDNwR3NBL0VONkh1OEZMTkRjNmZV?=
 =?utf-8?B?RGE1VCt0NGRGbWhqTll1R2JtQU1aWkt4Q1c5a2tLM3ZKOWdYNnBOVGJhWThX?=
 =?utf-8?Q?5x6r0tMn7q0lw2uGqrPf4nS7G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c934990b-6471-4dcd-09d0-08ddbe2055d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:07:04.7022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyh0BwAYYC8+ZlGDUwqNaeUEHt53HLjm2edhGEJacjXLkwRcvARLI6hA8qPZz0ms
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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



On 7/4/25 06:04, Venkatesh Yadav Abbarapu wrote:
> Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
> mode for all ops with small payload") the utilization of STIG mode
> has been implemented for read and write operations involving less
> than 8 bytes of data.
> 
> However, following this commit, encountering timeout issues occurs when
> writing odd bytes of data in DDR mode, as indicated below:
> "jedec_spi_nor flash@0: flash operation timed out
> SF: 3 bytes @ 0x0 Written: ERROR -110"
> 
> To resolve this issue, the number of bytes to write has been updated
> specifically for DDR mode.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> -Modified the logic from using modulus and changed to use "logical and"
> operator to check the odd bytes.
> ---
>   drivers/spi/cadence_qspi_apb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index b579699d2eb..76569a8019b 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>   	void *reg_base = priv->regbase;
>   	u8 opcode;
>   
> +	if (priv->dtr)
> +		txlen += txlen & 1;
> +
>   	if (priv->dtr)
>   		opcode = op->cmd.opcode >> 8;
>   	else

Applied.
M
