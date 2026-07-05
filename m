Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A08C43602
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 18:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4765841F2;
	Sun,  5 Jul 2026 20:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="L+N4v5Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67104846F8; Sun,  5 Jul 2026 20:28:42 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364C084105
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 20:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyN53cMhNlZzFW4lpGhGfuLpajyRNRFNl9PJcrHSovp3swWlUPh4lDmOk1JZOCzgSUEXzGCr357rdEw6JvbkkiKdNu1tldG3BilJYgYMmlISMQejPLREk+Skundt+86aCCQAWGJmTzZobV8XODMq+8ahUgi5lQXkhvu52WMQU+PhQHinEVGuaI5Y3yTJluhMjPnRt/QkmJB2jyfqIjdy2KuabvJy7H9DMTHA06dRuNw8x8U7P3L38iuo6kHRkXWZ6JDAx1q9ZWqxZQSXO6jJx5SE03OkVQH6UGntw8OQLw0tBEpyY7/vWBIAMx2MbavUdSYIajhLR8gfPGTh+z5ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvZnJlDWR/j3Eh8AT6q7uZR8k5v4n4ogsTTxNzgCo+k=;
 b=PRIwOeRmUcsb8H8/JyNTU/WYq1FtmBy7TbDkkTbxF6on1l7TWMo2F5OirRYaEeHeoDyWcM4h51bk1xMG2MXe0lRu3JTcqlappARiU9CRILGVDyiQ37qgBxhe5PAakHdLJEn/UwUz6mfVmpngw75N1BstBMr+gMZDKKViTep6azFqtqVTNrFxb0KEKp1clv2TK1flCcnlLGnzM9vmXlmKGGsrWYSBhiM49mCGt6ooL3B1n2AUxC1YfJBluuyR6tAZaWslDGVUVzk4t6R/vOVYvVFRVlx9dtMlACMUE6kvpSKedkeKHkrH0ZnU29tdzrqdZ4rmikox3gfj6GG/i6OmnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvZnJlDWR/j3Eh8AT6q7uZR8k5v4n4ogsTTxNzgCo+k=;
 b=L+N4v5Bn82YetjSNdGzkCGoFDunGlCngvbPFM1vJrPzammGj2Pof7sWvm5VJSCfP4Yv5kxk/SsHS8U8a3AevQxny9gOKs06WmVGU8r2T1/1FsD9sY98HyXAN88nAQnyAu9UPdk7rXNPAyKifn6c+Obd7eXEDY0bnkUKh6uhSJWfszzNIAx4Ib0eAc+N6gQ4hSri3FEz5yagSmTJgz//bQ82lYzVkkLDiwrUE759K/+KvJu1vZ9+C4ocNSW6RH3FxgNAfGVCwzredor54EM3E5MX8UoqM6HbmpuoHursiFsWQFCeu8W2Feq1M4nCc6tznNMGamKKr4iBO6cyfCZtUNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BN8PR03MB5105.namprd03.prod.outlook.com (2603:10b6:408:d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Sun, 5 Jul
 2026 18:28:35 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.012; Sun, 5 Jul 2026
 18:28:35 +0000
Message-ID: <e4b36ebd-d605-4e27-b3d4-8be6ffa39faa@altera.com>
Date: Sun, 5 Jul 2026 23:58:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] mmc: sdhci: enable CMD23 for multi-block transfers
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>,
 Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Johan Jonker
 <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
 <20260705-m4-v3-3-5a9bc7f25fc5@riscstar.com>
 <52987597-bb11-4193-a28e-223eeab093eb@altera.com>
 <CAH22mJwTcvbvoR=Bp2VLm3tgVpVx+wNF9+y-ua37Vw50Qw2O0w@mail.gmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <CAH22mJwTcvbvoR=Bp2VLm3tgVpVx+wNF9+y-ua37Vw50Qw2O0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0216.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BN8PR03MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e7222d-2282-4342-c9a9-08dedac33996
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|55112099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Ktan0bsM/GYvzODzYCVuXUFhKWQkwvcIm/GfEeTN2uxQyRu6Dl+yLcXdw02jAqEkPwMJkrjGBr9p8/4DYqJy2QrN3SMsSYc/zLDbDKV2WuOQplnQMyVcUzkIVdatiUwnhU87cTVlraeYlJ+qEBA5sdfSg+itWDBKMTz8pjjhTxLisiiTK8s3m60Ig9AhflEsBa8s7NDAC4BIJUPfppRxDYoHd6F9ukQy/V6Usr2rSxo08KydARkY1Wp53ffh8wC4qKrPPTfGOdeOHxYDVEYZyiDrHcZ5QTsYXfYusHE9SpKRy1bQ8pnDGUuB2HnS9kYarmBw47jI48mcnPaP/vmW+/X1BYcwNiRx7SRzjzUtKA1P9HZY8Uy6qTcgQ51gS6GzlIPozqFsyKks00Gl2bfNjrecII1pt4x3Jm8pDt+Ln3iHh3/YxK2AtyPTrQbf7SCBk+VZjMYrlR3mFSOUxnNFC0a2AJmwwDQM9x15EzMMK9Pv2vWy3Q4+efBpMdP2iT2YpuFRSmIZzbGX01j0YEMOrlkXiNbX2V0MjFELK4z8ps+GFf2SeT2TenvbT1bUXR+moQCEtGfK5tO5P35j3DZY/O2bi3CDZaT/1qIkgI17hDKBDxNIjIL1ih4pWPICHDJCZl0T9T32M8lqSUJYqIH64svo9qW/YpVAhKOM97yVayc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(55112099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZElMeVRsbVpoVVNnSWIzWlVCZ3VoZ0ZTK1gvU015QjFrbUVCa1o3WGt6cjBz?=
 =?utf-8?B?TGtESTVUU3M2ZWpCYmxhWGxnZjBIT3pIOVBpWDczalk0VDdnNGhTbFFUWWdj?=
 =?utf-8?B?N0NFUERzWHZDYmVzbmw5UjNYTFIrWVNJSmhsbTgxcmVMOHFJcnhFdlYxMlQx?=
 =?utf-8?B?bmNBL0VOTkw4WFZ0MDJHYXRjZ2tWYlV4dXEwdE4wRWM4MEFjVmo0Sm9meTEz?=
 =?utf-8?B?Tm4wL0VaZlJXUmxPMEpSU3BJYWM5ZkpCclV6RlFUOC9rSDlWVkZPV0IzQzJW?=
 =?utf-8?B?dDRra3IxeSt5dkI0MVlrMTAwNnhPejdmZG1nbXFYTkdndTh0c2J6ZFpnL01o?=
 =?utf-8?B?UEl0b1cxTEM1WTVsYUk4bkVONXlwd2g1ZGlqSG04YkJRdEQySmQwZGdGQzZl?=
 =?utf-8?B?a3hGVlRZeVB4VVdRdmZYNW1uYnBES3Q1cFk3Ty84cStGS1RTM1NlMitML2xq?=
 =?utf-8?B?c2dScGprUDZqaGpnUitkWTlmYVJZSURzcm1qeVVFbWozWlFZWTlwMkdUTm9z?=
 =?utf-8?B?aHQvVWN4ZWF2RkJQdFhwUnBJQUM3N3JUVmNxUDJFTVc4M1B5QW1LUTgxcmZl?=
 =?utf-8?B?a05SVzVnSFZzZWxiNlFwQlkzbmx2SjR6QTRYVnAvU2hJWGNNWXNUYVdYWlkv?=
 =?utf-8?B?aktXN0JtQlczR3hjR2dLbklRSWFDSGFialZwaFVaRHRtMDBqYlRxSDJRbmV5?=
 =?utf-8?B?SHhwMGF2WlFoNzIyaXM1bkVoL1h1TWhodzdEL2V5bHZhckozcFZwbGdVQWFP?=
 =?utf-8?B?bWZpRXZQUTNwSTN2WGxLekh5M2d1dTdVUC83NUx4VzNXbDRZSkhTbXJqbmhy?=
 =?utf-8?B?SzFCN0tGbFZpdi9BVE5VWGFSU01ueVZ2ZmFWNjZ2V1RoODFKbVRvUktCeUxo?=
 =?utf-8?B?ZVV2SEhkb0VZOXp2Qi9Gd1Z3dm5JRGJMTXk4Rnh3YmdJQ1k2aHFmbit0SEZa?=
 =?utf-8?B?TUNnZTBXVmVCenhYV3o5d2UxdmtDUWxmcmdPUnh3NnAxZm1ZbjAyN1VFRlF1?=
 =?utf-8?B?YVJ5U3Z2OHdvdFhHZCtxbVFiZU0rQzFsMUxQMk9HWk1laFlMK0JJWFIvSmU1?=
 =?utf-8?B?QndLb0pEZ1poUWp6WFhIZFZRNzJHWWx1VlR3aWVSUmJUamVXZjVyMUVOV2VZ?=
 =?utf-8?B?SElVby9rNEJscXFmUm1pem94RnErRnpJYmNSTE8wSzRaODNCNjAwL1FZN002?=
 =?utf-8?B?UEwwczVVTTlnVTZ1ZEc5K0hrbnN2bnhWb091ZjNCK3lnUHZyYzBEUXVlSXBG?=
 =?utf-8?B?VW9QV0djRGVzRWdaTTVUeEtYTkdrMHZxWW5nenA5czFXMG11V2ZwRCt1Rzhp?=
 =?utf-8?B?VWh2bXRmMEZDR04wcTdZVFN3eFRHNlg3YUxjS3hheE5XU0lOWXpCZDFYVmF1?=
 =?utf-8?B?QUJycVhYRkU3RzhvQVRXQnlGLzRFN2xzdHFUb08yelRpM2pCNE95MExiY0ts?=
 =?utf-8?B?SWtDV3FYakhJMlV2N2RPdXNINEI2QUd2VjZLQ1lNeFVsbEMxN2hSK2lpZUpZ?=
 =?utf-8?B?K050VDAxL21abTVkd2QyRi9hdVdXNWs3T0xnN0FZNGJ2a2dBQW5tRUVEWkdY?=
 =?utf-8?B?Mk00UThVZUttdEl3Wlo0NFBOVjRJNjJScFVFUWFERWNsTlRIUmVuNTROcFZT?=
 =?utf-8?B?Ym9vTHNqamRDaTB6YkFsNGxOZXZyMFpodVIvdklsdmF3ZmNBUDB2TEs4S3F4?=
 =?utf-8?B?anJTblFjNUg0MGxiVzhiYkpYQnNUQm5tYlZENFhuN3puaUE3V1l4NC9tcEVC?=
 =?utf-8?B?anVOSTRUT3JiTjlPU2dhTnN1WE0xZUhqK2hGQ3BXSWRnQ3M1ZExVUmFIbVln?=
 =?utf-8?B?ZzBndHdpL2tBem5ud0l6WENYWlZZN1M2bzlwRkI5dzdEVGZNVTFqdi9vb1lk?=
 =?utf-8?B?bm5TaDhxWjhVdURKKzF0YXRTRzF6dENwUXFyZHVGN01RU0tIVXptK2pVMkdL?=
 =?utf-8?B?bW1QMHRPdDBsazAxUEJ0MnBaaUZJckFMSFQ5UHU5cXFsdUM1R28waHg0alpK?=
 =?utf-8?B?K3g3c0xYVzJWdXNUVlJTcUhZZHBkclhQU1FFVmpFNzAvOU5KT1RURVBlUUFP?=
 =?utf-8?B?b0FVZERMNGczaHhzaElSN05heUpsNFRwblVNaGlvdjk1c0h0YVpuUXcvT2tN?=
 =?utf-8?B?cjZ6aGMwV0pBbkZuVGtFUU5DWVZCVVg5M0lwSHNuQ01CZ0cyVTZTOTI2OE4r?=
 =?utf-8?B?STkyWTMzSTVZeFZrWWJTYVdWQ0hlT3h5RXVseThEY3VFalJpL2tBOE5tNHFt?=
 =?utf-8?B?TExDY2tKMXNFd0I0ZGU4c21JajNVVGlPRUhVWHl1NDRZOHlleWpoMFp0d21u?=
 =?utf-8?B?QlZmZFNkejBrZndNUjBkTXp4TzFPaWJ5VU5GZXpBTVRzYlVIRmt2SlJWN1ZM?=
 =?utf-8?Q?PJsXfyYo7v+6P+wY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e7222d-2282-4342-c9a9-08dedac33996
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 18:28:35.6563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjMaNjwkCfmWCjk9ZpAF/sMtD+Sgz/uXbI0Hw4lOtJPykE3C0CjfoYJGd+hxHUkGhc7hGVvHqwXND5t8uH7V0PQm+Re4Lsr8Xinn8tZL5WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5105
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

Hi Eric,

Glad the review feedback was useful.

I have some SD/eMMC spec background that could help make
the CMD23 implementation more complete. If you're
interested, I'd be happy to collaborate on the implementation
before you post v4.

Let me know.

Regards,
Tanmay Kathpalia


On 7/5/2026 8:51 PM, Eric Chung wrote:
> On Sun, Jul 5, 2026 at 5:52 PM Kathpalia, Tanmay
> <tanmay.kathpalia@altera.com> wrote:
>>
>> On 7/5/2026 11:37 AM, Eric Chung wrote:
>>> Enable the host controller's support for the CMD23 (SET_BLOCK_COUNT)
>>> command to manage multi-block read/write operations. This allows the
>>> MMC core to use CMD23 in preference to the legacy CMD18/CMD25 plus
>>> CMD12 sequence, reducing command overhead and improving I/O
>>> performance on multi-block transfers.
>> The commit message claims this enables "host controller" support, but the
>> changes are entirely in the MMC core (mmc.c) and header. No SDHCI host
>> driver sets MMC_CAP_CMD23 in this patch. mmc_write_blocks() in
>> mmc_write.c is not touched. CMD25 still always follows with CMD12.
>>
> Thanks. I'll apply all fixes.
