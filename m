Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0278CCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67BBE84312;
	Thu, 27 Nov 2025 08:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="uc2ZeguK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27ED684314; Thu, 27 Nov 2025 08:48:52 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9316684307
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXT710FDcbsV6YPRA3xjOGWFynJ0PpiH3idM2hUrNQMmEkgtrVygcLGwLgy8A+sX8T7lyPriTwRp/yvZRV3OFjoPNRkWaS1/Kter57NWV1gV9UiEM2VdH4DY2YWxYNoYz5gQepq98z9q8xCwZC8MPuaog1wuKGFk+BJjHZ7ovOuPebF2LoM8BAJXmVzmRFr7XOmkBcAMQYphXHYg8nVflJ0U/ZZX1V5ixDwuEuJv1hOOrYnr1oV5+7fnYN7sX9sWEbBc6DCK/Mo+4cnhwJv35wfL8frnxJFxUXmLMIFX92TAZPZs1aqO4qPbSrsHRAyo75rHq08lqhhtCqxEftr3Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri09Rmjetm2Bf6slCzFaK4P0F3ibJZ2kmG8iZhWngqA=;
 b=wTeeE2bes97ktqlJqoc8ikwd7It2wZVL8b+5s7hfJTWi7KpBDn+ZzfHhn+zK2liwPsdZjCYApT4OR73BQjois/7db5ULHyi+V8bGBk/egA6LEOehHdzEhMIiDT129jWh+j3pClQkAVO3naee1DAJzMe1nxQPjfgrVMquGms7q43VLWk7yD51nkAAvBgVs+x/5vSnilsBh0PNZ3qK9BtgCO/G3e4hsF8nkS3LRaGmjZjh5a2b9iYAWIYBP+0tFY8vWWMC+RbWOl8yKMNzJUC/OvM7Z189lJPQRJP0/x1ZGhlIp7s1APFRTzP2n4FfA4o7zx7qxFKd8xPNxOAvFX24Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri09Rmjetm2Bf6slCzFaK4P0F3ibJZ2kmG8iZhWngqA=;
 b=uc2ZeguKWwaj9bKhAyxEZh1CqH9RV27ae+K8ll0uMl28wESKccS2b/dcMSoIjWcTIB0WPJ6wFbJZ9i0kZlBi1lPUhOGT6eByqpyUlaeMHyQc7uYPRngyiv196ADUB5gbLqK5mwy/mnyD7apAjKlQuiEQgOsSaMdbl3tsgImULSo34gieO2cmGvtLbijx7pxIL4imY6MH2hgUbtIq5cyNSCBqWIyrF+OEVDE46qVP5X4rUqHDyKGLoyf1NZPuXJOsh+4NdU6j2xV9CySmzruScfZuGfS3wplgUkerhlO/gn2eaJJAxu86KmLOZxCGoY/jUJ/28j4JtK+whixeEaXn7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:556::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 07:48:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:48:47 +0000
Message-ID: <85b3b8a8-fbaf-4e30-a38b-af4299820487@siemens.com>
Date: Thu, 27 Nov 2025 08:48:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Brian Sune <briansune@gmail.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
 <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
 <c536c33d-8330-49b1-821d-3d218c49ae23@siemens.com>
 <0720e9a5-536a-490f-bb28-87efe50289a4@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0720e9a5-536a-490f-bb28-87efe50289a4@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9516:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d10d2f-453a-43a9-56a2-08de2d8965b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WitQNEk2T0VHaGYrRTI0YTEzclRuUnMyKzdEL2ZEMnhMTlN6TEpxaVB5WVNM?=
 =?utf-8?B?eDNaSDdqclBUVUlrSlVLdGVPalh3ekVXMUprbEZUM052dzJteHA4MEZsclpr?=
 =?utf-8?B?UDV0cTRLU0Vpd0plem8za2llZVhiZFhaVUx6dnNWbEc1UXFBb0FucjhOdFhE?=
 =?utf-8?B?M3cvUGFWK0lQWC8wS2NodEdPVEt1MU9QaitreGlQUzZkS2RPV1g0cjRQZ0cv?=
 =?utf-8?B?MnBRM1lOK3ljWHhTazlENjdzV0NZK3ljaE5rRTEvdUhSbGFiODdOSk9GR2ww?=
 =?utf-8?B?cWVEYUVmS3FyOTh5SjJvbjl4eUtuYU03WjdOMVkwT1hhUmd5TTdnY1VqUTR1?=
 =?utf-8?B?NEQ1VkxpQ2xFSXVmaUg3Tm5tRGFQejUyNU9ZOEFmMU5sV0FidW9OWnRsc0xV?=
 =?utf-8?B?dW41bEd1UWppT1dnUUtLRHJ3Rkp2bWxIQUdCRVJNUEpjaklPNUtaWDBQVGtx?=
 =?utf-8?B?ZmowL3NoWnlXZkx0RUNRWVhoaGM2b1BCYS9xRWFRejRRcFB4ZFJkNFZ6MDVy?=
 =?utf-8?B?VVRhcFFwbUVQc0loVzRTWERlYXg3RVVGbzl3UVduRkx1bld5T1hVdkRLZzJZ?=
 =?utf-8?B?Mkd6WVpVb0puNW90czRjRTNwQ2NQVVlxMDJsYXBYUkIrSEcxMkU5TnlkdFMz?=
 =?utf-8?B?NEQ5RTFURDBCMGpTYUdUaTBWWHlFTnljVitFUzA4UkpwaTJkNzJZODNQWDFu?=
 =?utf-8?B?ZWlNamNPK1lrVERJTkZFWGhpTDJqVVFOZHhMU1hMa1pqSzhpQVRJOE1QSUs4?=
 =?utf-8?B?QXNocDlKbnF2KzA4Sk12QndzQkIrUWNqd1ExQWxXN24vdUpjTHRGVjcra1BL?=
 =?utf-8?B?UWtqMVc2eGl5MDBQQ0lmQnE3UUNSZkJrWjhJVDJTQU43V0NnQ2huOVRqdjhI?=
 =?utf-8?B?ZUZ0OERXdXdIK0ZCWnFKSEgxYVlBUHE2VG1TWFpudk11a3VJS1ZENjNPQ0o3?=
 =?utf-8?B?Rlg0L21iVExJajRPLzI0R1lWY3pCSnd4Qzg1dnk3bFlVZE1MSjBNbXFoMjY1?=
 =?utf-8?B?NWE3aVlZZ29TQUtBUlNJR1N0Yys4a3o3RmFjRkdyMWQ3MjAxWnFIZ29ZRWto?=
 =?utf-8?B?SytVOWNWWjhPei9iUklQNUk0TFdpWVNFVFlWVXNKdEhETTd1SnpZOTJqYUtE?=
 =?utf-8?B?SkVLNlhjMFBhNDlwWDRQTDAreUlDZU8za0JRT0lRYlNHZ1dGMW5SN1RBam1Y?=
 =?utf-8?B?dDVHTkt6SlV6TFRQUVo2RU94UkpQeStTTU1zaTV1aFEvSFovdVhKWmtybHZM?=
 =?utf-8?B?WHBpak5VWEZRT3dBYk9mWEg5alBzVGxXT1ptR0JEM2FSWWxZNVdsa3M1RlNO?=
 =?utf-8?B?dlhvTFNZZTFuaVhwa1dYT0d6bXBNVDAyWjRjYm9reFlad0w0cFpGd0MySnZn?=
 =?utf-8?B?cGxKYXRQd0FzYU9HdkFTR1J3UnlxRmhBbG9KRVRnM2dBWFM0ZUFkNzNGMEJD?=
 =?utf-8?B?VnJzU0RmTFhBWWJxamlXcFU5MEs4VWhrUEZ0UERIV2VSTWFNV3k2MTVNSkNR?=
 =?utf-8?B?OTNDcjFrelZpSWhlWCtKUFYwZE5oZUhoaytobU1DTlh3S09nU3d3STR4T0du?=
 =?utf-8?B?aWdzMUUvV1RPcmZheUF1YmswZUJtWS9sdllvZTVwZmp6RWtHUldza2p1djVV?=
 =?utf-8?B?R0xNejZFRVlMdzNGZHZBSGRaOGNkM0Q4blVSSzVMTWtpczhMM09WNlNuVENW?=
 =?utf-8?B?Y0JJbysvY09DRXVRYkp5MENuQUVrbFZKc3BQYk4rNWNDZzBqV2Uxc2tqaVZ3?=
 =?utf-8?B?a0loblE4Y2Y4VVpWeXhONml1R0QzRCtoKzEvaUZXVjk2bS9VVkJXdEp5STdn?=
 =?utf-8?B?dmtHRGU2Z2ViTkwvNDNBa0k5NnQ2YWM5bnZuYlU1QXpsbXl0eWJEWjhqLzF0?=
 =?utf-8?B?TFlUQzh6bnZlUWVwV0hXU1BDNjBZYUg4cHRrOHQzQis2dXVXOVlDZzRVQmpZ?=
 =?utf-8?B?WjdsOXF0ZWVLRHZmQmtEWG9COWZxaUxvK2VMYU41aGdPYkNhd1ZTcGdVeUV4?=
 =?utf-8?B?QmpmZUo1cU1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmNFemVCTFJUOUhzOWl6Ty8vdEM2Ykd0K1pOa3FOL25mVll5USswelZaMDVw?=
 =?utf-8?B?UVpsRDZ5Tm92NExzZGpwaUlIUElFMjJDSThkWVd2YU1SWHRoQXN4biszUmgx?=
 =?utf-8?B?YklXMnBSbUJVb3dCdXc3U2l5ek9vOEREaW5oTWI2eFJhc1VWcVJGQkVZZi9Y?=
 =?utf-8?B?dENMd0FwM3ZwTmZaN3dscTlNaXlqVzhNVWFYYVhKeXBwN1ArVk00ek5mRXdl?=
 =?utf-8?B?L0JXbExLZm5kZi80cER2cm9MazBKbUxoNml3NWptVEtMWVhqbzlUaHhkYmpE?=
 =?utf-8?B?bkFObGlpMGE0aGFqS0ZodzAxaWhuYVdRMk1CTlgwbzZ6WUczM3BtRUZ6eEhM?=
 =?utf-8?B?dXZLWE1DMW1ySXNabHZlTDhkZ2FMcGtCRHl1ZEZZdUdsTnJsU29WMnEza1NF?=
 =?utf-8?B?WFNKMFRNcDIxd0thL1hXUUJsR1ZrTVgvVVRKdnVqK0ZqeE1WR1dyUnE5RVZk?=
 =?utf-8?B?SEJVWUk5ZDdmWVdRcFZmUTV5ZktGYVFFVWhYYzhleVB4UFkwUmFGRlhCbS9v?=
 =?utf-8?B?elE2K2RrWFpkaHppa0o5bW94bHltUE8wdXh1c0xXT09Kb21OQjBOcnNrWWc0?=
 =?utf-8?B?dnA2UGFqS0lJTUNTZkhteGdFM21QMWFQT1p4OVhtODZhcExlajFYWGN1eUtW?=
 =?utf-8?B?QTRtWWp6K3Q3NEJpZFhQajlvV0RTMXNVS1VYZTAvZzNEUkxUOS82SVFxRzVZ?=
 =?utf-8?B?bTViT3I2YW1qb2FlRi9Gc1ovd014L1kvbWFCeDlPZkRHWEcwM3pvWFJ3eXR2?=
 =?utf-8?B?T3BYSm5MNVdhSzRPV2lBQlFNMS92MWRESlJ2QTJHOHRheFdTaXpaS0U0eHNT?=
 =?utf-8?B?d0FKQ25XV3NQMXBoRU5QSzh4SGYxSUhNaXZjaFNORDJhbVRoRzZqTTZ6cVJR?=
 =?utf-8?B?Wm5UNEFFSHhxZmltQ29XdS9wbXlObC93R1JsMjhNS1hFNmdPY0JXWThVaWZn?=
 =?utf-8?B?MERURFR0Zk9oTDNoZlpkUHl5R1FjS0ZHV1ZCblhDT0Q5TVFrQUc3WkFJcDFQ?=
 =?utf-8?B?OUxQR2hvcE5VczlVWGxaakVodTlwQ3NRSkgyOXExWXgzUmMwU3hkQnM2S1F2?=
 =?utf-8?B?VHFkdzJFRDM1a3FqOS8yZ2tvbWhZd2hObkJJd2FOc0dBbVYvNVFrK3pBa205?=
 =?utf-8?B?cy91NnMydEFySUZpWkhQRW44aEFlczlQUXpnWWVJVzlOK2sySktXQUlySEw0?=
 =?utf-8?B?TUMvNlhZNzhYOHJtT1RpTDkrQ1FpZW0rN1kva1RJSFozY2w2UmZSWjdXeWlj?=
 =?utf-8?B?UFJuY2VWWld0NUdkMVoxZncvbytjelkwTDcyejdTbEpPcktWc2tOUGd4TDRP?=
 =?utf-8?B?blJQOUh6NlgyQWxGWlUyRHl2TVRvZFJtSUd6ckRFQTNwQ1NVTS9XdnJWUFp3?=
 =?utf-8?B?UnI2TzlpZTB4QWRnNnRJZ1hTbGszQ0JTRHVmSzhYWjhiY1E3TFlVNkVuYzcy?=
 =?utf-8?B?TUF6QWx5MU1nRm94MU8xcjg0U2FpTTNNQkhuanE2WEQ0SWs0VURRdjltMUFC?=
 =?utf-8?B?VWtoRjRJOXZQNkxRbmNtc3FtTElwTVNGMDYzUTlZLzRQVDRQRWlqeG9wQ1li?=
 =?utf-8?B?UHRRS1NVVFlEWS9ZbkY4OURpSTBhakpJVzYwdDZzaE5GWTVEcVJyUmdWZmwx?=
 =?utf-8?B?MW9mRFRIWU5RNWp1M1RDd3dkaTRQZnp4dCtZbGxNZFBna0ZEWUNpY1YwTTJl?=
 =?utf-8?B?SUxJS0J0Qm5FOG8yMjdWZVY4aHZDZXVWdzl2c3ExbEJkckF1VGhrL3UyeldH?=
 =?utf-8?B?cE91TSt6UTVoVU03Rk9uSm95WWJKeUgvNHhnaFB5dUxyTUFkWEJEN3dLZThv?=
 =?utf-8?B?ZFRqQVpnT0VOU0xKbXJSd1Y2dXlOTXVjNFBqNjk2WS8reVBXWEY5dGlZcjFh?=
 =?utf-8?B?ZnZIeDd6c3RXcjBSNTlDZW5aZ241ZXg3ZGVyakk0RmJCc0thbXpGNjg1a0hL?=
 =?utf-8?B?bTR1SWZwSG9PaGZsVmZkZFVicHhIZ25jWW9CdGo2Y09CWm92cnE4VFBlejN2?=
 =?utf-8?B?V2VSSXMwSGhkMDJGWklGcFdwVlE1dzlNRGRGYmY1NCtoL3hhVXJLSVVXNXRr?=
 =?utf-8?B?R21lWnhnaUtjUGlEc1Bkc0xKOEFGbmpkclRuQ3J2dWEydkFDc2Q2VzVwbmRT?=
 =?utf-8?B?bWsvQXJ4eDZSZUFWYStnMjFoSDl6bGY1U2JLVTFNUjk5RE92OUhWdG5BQVdL?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d10d2f-453a-43a9-56a2-08de2d8965b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:48:47.4622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo+YmH+QGFBs23qfoSWyzxQG+TKk+0rxc12rXlaUN6ug1uwmPEa9BaWlF0zQ9FQGjCXZybk1B65E4wpsM5Vtog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9516
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

On 27.11.25 05:21, Chee, Tien Fong wrote:
> Hi Jan,
> 
> On 25/11/2025 2:42 pm, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> On 25.11.25 06:02, Chee, Tien Fong wrote:
>>> Hi Jan,
>>>
>>> On 15/11/2025 1:13 am, Jan Kiszka wrote:
>>>> [CAUTION: This email is from outside your organization. Unless you
>>>> trust the sender, do not click on links or open attachments as it may
>>>> be a fraudulent email attempting to steal your information and/or
>>>> compromise your computer.]
>>>>
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
>>>> More precisely, SPL is stored 4 times. Take this and its padding into
>>>> account and adjust sector number via
>>>> board_spl_mmc_get_uboot_raw_sector.
>>>> This allows loading from a partition, without the need to hard-code the
>>>> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>>>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>    arch/arm/mach-socfpga/board.c | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/
>>>> board.c
>>>> index 28554b7a109..d756f7381fb 100644
>>>> --- a/arch/arm/mach-socfpga/board.c
>>>> +++ b/arch/arm/mach-socfpga/board.c
>>>> @@ -14,6 +14,7 @@
>>>>    #include <hang.h>
>>>>    #include <handoff.h>
>>>>    #include <image.h>
>>>> +#include <spl.h>
>>>>    #include <usb.h>
>>>>    #include <usb/dwc2_udc.h>
>>>>    #include <asm/global_data.h>
>>>> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>>>>           }
>>>>    }
>>>>    #endif
>>>> +
>>>> +#ifdef CONFIG_SPL
>>>
>>> The guard should be CONFIG_XPL_BUILD instead of CONFIG_SPL to correctly
>>> control SPL-specific behavior
>>>
>>>
>>>> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>>>> +                                                unsigned long
>>>> raw_sect)
>>>> +{
>>>> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
>>>> +}
>>>> +#endif
>>>
>>> Global impact:
>>> Applying board_spl_mmc_get_uboot_raw_sector() to all SoCFPGA boards
>>> could be risky. Older platforms such as Arria 10 and SoC63 devices use
>>> different layouts, and soon U-Boot proper will be moved into FAT32
>>> partitions for cyclone V.
>>>
>>> Offset calculation:
>>> (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect assumes a specific SPL layout.
>>> It may conflict with the default 0x200 sector (https://github.com/u-
>>> boot/u-boot/blob/c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9/common/spl/
>>> Kconfig#L592 which eventually assigned to raw_sect above) used for
>>> SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR on some boards, so this calculation is
>>> not universal.
>>>
>>> Suggestion: Consider gating this behind a board-specific Kconfig option,
>>> or limit the change to boards that actually require this offset. This
>>> will avoid potential regressions while supporting existing platforms.
>>>
>> I dislike more magics here. This is surely not board specific, it's
>> rather partition specific (raw vs. fat part) as you pointed out above.
>> Probably the romloader version plays a role as well in supporting one or
>> both, thus the chip generation. Let's encode that into Kconfig, rather
>> than magics.
>>
>> Are there more modes to tell apart?
> 
> Thanks for your feedback. I’d like to clarify the current status and our
> recent POC regarding SPL and U-Boot proper loading on Cyclone V.
> 
> 
> Cyclone V (Gen5 – ROM-based boot) - ROM supports SPL loading in two modes:
>   1. Raw mode – from LBA 0
>   2. Partition mode (0xA2) – from a dedicated A2 partition
> 
> Our POC confirms that this restriction applies to SPL only. Once SPL is
> running from OCRAM, it can load U-Boot proper from FAT32 without issue.
> This reduces OCRAM usage, simplifies the MMC layout, and preserves FAT32
> benefits.

Right, I confused romloader constraints with the way more flexible
options we have for SPL loading u-boot proper.

> 
> Arria 10
>  1. ROM loads SPL from its fixed boot source. SPL already loads U-Boot
> proper from FAT32 today.
> 
> SoC64 (Agilex / Agilex 5)
>   1. SPL is embedded in the FPGA bitstream and loaded by SDM. SPL is
> never on MMC; only U-Boot proper can be on MMC, and all boards use FAT32.
> 
> Conclusion on required modes
>   1. ROM loads SPL from raw (Gen5, A10)
>   2. ROM loads SPL from A2 partition (Gen5, A10)
>   3. SDM loads SPL from bitstream (SoC64 Agilex, Agilex7m, S10 and etc.. )
> 
> U-Boot proper loaded from FAT32 — this reflects the standard Altera
> devkit MMC layout. Other boards, partners, or vendors may still use raw
> partitions, so this is not universal.
> 
> Implication
>   There is no single offset calculation that is portable across all
> generations. Our POC shows that moving U-Boot proper to FAT32 is safe
> for devkits, reduces OCRAM usage, and aligns with long-term MMC layout
> consistency, while older raw modes remain supported where needed.
> 
> 
> Please let me know your thoughts on this approach and whether you see
> any corner cases we might have missed.
> 

I'm fine with switching our setups to FAT mode as well and adjusting the
defconfigs accordingly so that people use the optimal mode by default.
Still, if you want to continue supporting raw mode as option or even
still as default for some boards, it should be fixed as well.

I will try to refresh my related patches with the feedback you and
others provided, I just need to find some slot - and another test board
(gave mines away now as we are re-balancing their distribution in the
CIP test labs).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
