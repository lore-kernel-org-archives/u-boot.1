Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC62EC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9D88212B;
	Mon,  5 May 2025 15:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PWq9r6X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 065EF82991; Mon,  5 May 2025 15:53:29 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8248801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hyu2X9aSB08KRDASSHkrn/hwtBiCHAjjGd590sLKLLmeaUJY4s384lSm+QTAllrLWJRigSCkxomJupxT3G/6nCLBhRWBaxrjrx5OSQpi76k1/UkNHb6UdquP66cYmvUyceOwWTMwBJadMC2avH4EPGVt87GizqTGZxbeyLm40x2TgQhrnXBv0xWyjzUMpmbph94P4Mx/G0pzsaBH/SRaNnyODfrJCAHn7wwEiYCN81wVDCkz2ZgrjcPQZ2bFsaffe6c6jkTTf0OCZkAMCBicMUgTSdoU+o68fh3Ifd8o4lVWjzBO/y7OwaI3qnyfriOlYgMv14psr53p1W3Ekta3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGJ8ydF0+8Bn8+o/IINqfW0B4C2o39cCao/axYUA00Q=;
 b=bdFn/HiZeA7ScaxE48YNFWQbhp/Hh+fZrvH+HEThBiHQ6Imm8awci9mpM3kl/S2kLV4y1Ce+mQMwBkAvC1wkt+CYnDmZ3H8tCtXf3xTPKi4sUQvniExLnE7BXKiydTvb9qGMI3izrC/WbLgQPzuYVrKSjmrAlFPw1pKOfmCu+klAAYr0cPtfD+bitahfUKpFMO6Av5tURKvBkkqSePTB64mYy6cjyitXqCBNKBisN1xD/F/SyIgmgKTUgbm6zsKAyN0R7A95GB+6EOc8ASw4OlSkkkLaI0SQ+FxyrmEQIwoi03DN4HGLZeKjFd4XY40R5fkzBfh8BzF6l43fbZEbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGJ8ydF0+8Bn8+o/IINqfW0B4C2o39cCao/axYUA00Q=;
 b=PWq9r6X4u+R0tqd6ILVCUHMbMuWSchTzbSBPnLOI514x+4pwoUOqyatQhJlSG47+Ij7GMRKlTjcsyweZIKpMUCTZxkNsgT4Lsqhfp9X04B8wS9gG7qItGeEhRCpRpFCq3SrnaMiaJThzNz6oo7InV9qnyTrWpqCGNkShmZsR+os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 13:53:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 13:53:24 +0000
Message-ID: <c04069a9-0035-4fbb-a202-b477b495aa1e@cherry.de>
Date: Mon, 5 May 2025 15:53:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
From: Quentin Schulz <quentin.schulz@cherry.de>
To: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 philipp.tomsich@vrull.eu
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com>
 <CABd623t3-U+TF9VD0O2dtNZzpZPBM9LcOQ_a4mDpv6ierbLuCQ@mail.gmail.com>
 <51a9d783-6002-48b8-8565-b4e7fac8dc51@cherry.de>
Content-Language: en-US
In-Reply-To: <51a9d783-6002-48b8-8565-b4e7fac8dc51@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 88699d77-5a9a-4b91-c341-08dd8bdc3480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am5nV0JOZHk0dTBQNmVLL0JtSHhDVWdXeklpSW0xNXpKUTEzZGNIRys5bmJY?=
 =?utf-8?B?aFpBQU9HQnV6cmRyU3RBNS9tNUFqMEh0WlNmRXQ1UVEyTHVzVHYwVnlKbDMw?=
 =?utf-8?B?RDUyblhIRElhNzFKNTVkQ01KTHYvRjFUblYwRUM1SURBam9FWklLOWpYTXp4?=
 =?utf-8?B?cDliVGhGWGV0a2JzYkNHV1F4aExOOHZ1N2lrQUdvM3Z0WjRtNDVYRW9BZUpq?=
 =?utf-8?B?ZkNrZ0RxNTFaLzRHR3JBeWx5ZVh0Q2xGUGVzK2djUVBBZ0h0RloxZmFNdXVH?=
 =?utf-8?B?MDd0bGlGOXp4YkRlaGliMlVyb1VqcFhrU2NsSDlvNlNIWityTGVyQmVDSVQ4?=
 =?utf-8?B?SGo0Mk5NWTRxVWFFV3dQQ3lMQ3R2QnJNaDh0aEFSN3VJN1BEbkxSam9YWFli?=
 =?utf-8?B?MXRya3lTT3FZU0ZaVTVYdXpxR1R2dCtVZDRVbVoyVHp0OWRVYytGekJVblh4?=
 =?utf-8?B?WFFZWUl5T20zTE1GbkdabXZzQlNXK2FOdmRaNGpldVg1QUZFKzUxS0RxRGV2?=
 =?utf-8?B?anR4Q2cyeVpLWVRQbkJuRUt6eURORE1HSHJNbTgxSk4zeTFiRGFvRW1WYnF2?=
 =?utf-8?B?Y25nOGVUaGhGY3E0OUMwT3JtRTdhK2JKVC96MGkwb2xLMnRyU0kyNGpYdUY1?=
 =?utf-8?B?UmxoaEZsRmMxdVNQdXo5Zm5BNWZSSG5xbnFmNDZDUmF2cnNIaUFVYzdxYkww?=
 =?utf-8?B?TEY4bHRrQXhjS2lOdExhbWN0dWdkUUFEbHMwNU1qdVhPNUZIOWZCZk9IYisx?=
 =?utf-8?B?Y2ZMV1NOYVZic1NPSWNuYnhBTk5CK2gzV3BsOVZMTXk1TTJwaTVSM1Rycjdo?=
 =?utf-8?B?OS9TK3g4YU1LK1l1Z2tNQndBRTVzN1RHeFpKRHFhQVFpRmFRa0tNaVRVbVd3?=
 =?utf-8?B?aVI1cWZ5UEJqS3dKa20rbWVSYzBrVzUyb2t2dnVXVDF4ZUZjZFlzTGFMeUw1?=
 =?utf-8?B?UmpUdnFHVzBRUEVQSGdnMUR2Ny85QlIwcm8rSnpJUzN2Q2VNeTBvUDBXN0Zt?=
 =?utf-8?B?UzlzaGFCUnRzdWFEMVB1Zk5mcXJFVy9ldiswMXVLdTBGMDdrWElIanA4VDNx?=
 =?utf-8?B?Q3JrQkZsWmVhUFN4Y2pkazQvM2dsTjM0U2RJQVRhSHZPRUpIRDF6L25lSWUv?=
 =?utf-8?B?SW12dm5CaXY3d29tUlpwVFNIcUk0a2tDS2Q5d2ZGbk9BRzNHMWV3WXBxSTh5?=
 =?utf-8?B?bjVla3FvSkZuZFZDL0ltNGI1RnhUS2lVOE1MQ2JaMVFPODZZeEpweFZHeVJ0?=
 =?utf-8?B?QkQyeVdHSVF1VE9HOVBqUllSS210UDBkdHJGdWF1TzdQcnJGazFyaDB0clVY?=
 =?utf-8?B?Z3VwUEE3MENCWjJHSC9sMjZOcDErMXNvR0pXTEMzZjFaZUNjNWd2aTJRVUJO?=
 =?utf-8?B?Q0dNdnhHWW9ZdkRQVFZFZUFqTUF6QWh3USswR1FIM1R4RFRYZUNwMU5uUVFC?=
 =?utf-8?B?RHlzOUd2cTRFTHd5T1NpeUVxZVZ0RDZDanAwM2pqTzlXMEhCMWtCeXROZUM3?=
 =?utf-8?B?VWE1aGd0MFBZWVZGcDA0TFpHcE9DY0E1WnlXNzRjRkg2TnVqMk4vSEdVTmgw?=
 =?utf-8?B?OUdMR2hwSmxCbHFVamlxREhxMDhvdkdXbzU5ekpzbjQrb1p5WmN4TnRSYnIw?=
 =?utf-8?B?NWJCVU5BOTU4MUdaM3N0WnlIQTN0dzJVTk5FUmdrNjRPbmR3VFBJa0R1ZUR5?=
 =?utf-8?B?RlVkQ2JuaEJZNjMyYkNHS3JnZXRjTWcrQW00QkNIRDhUUmpNQTcwUTlhbGNz?=
 =?utf-8?B?cGlJTEpmV3NYZE9zN2trUGxvdUdHUDY4dHJKWVovSWt5WWxOaFlRQWZxeDkx?=
 =?utf-8?B?eFVnZDJxdE13THhRWG52OS9CODljTzEybUZiSEt1Y2pqc3U3SUJUSG1qb1Br?=
 =?utf-8?B?NXlFWEJGelVCMExJRlcrRitLVUZFd0xpMTB1dDZWMWo4b2dYV094ejJHVnNt?=
 =?utf-8?Q?9YhjmyUAjMs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MisvdHJQTmcveHBXZDBsYTB4QmRqSEQ1MzRGbUd2ZWE0YndGVjNrNm14N0Uy?=
 =?utf-8?B?T3hSZDMvSis4UTI4am9xOGEvRnBDeWpvSlp6NFZvN1c4K2d0MWg4ZkphNTdD?=
 =?utf-8?B?MWwyUWRXcW10ZGZVZXhnckRxM1ZhMFlXV3ptVU9WTU9Bb2VxV3M2TnpBRWVy?=
 =?utf-8?B?a04veHIxNTMzRVFIWUJ5SERTa3ZwcTg0VUpjbG9WOVN4cjBwbEhDNkZjak1n?=
 =?utf-8?B?RXFEWko4TlNiUWpXU1VaMTAvNU4vcUoxbUhqQjJ3U0FNYVdWSk1FQUorRmky?=
 =?utf-8?B?enZWMzZtcGJCUjB1SkdWNmJMckh4UkRUNWhEaW5qYzFkUnpHaVJtekhrV2lm?=
 =?utf-8?B?TDBFSUpVa3V5ZmVYVzBwNEhQNk5LNWw3cXNKVkl1YVhhUyt3ellxM3lxajVx?=
 =?utf-8?B?NHB3ZlpKMGRVZ2RPK0hiQXF3MmpYWkx4YjkvcnZKNjN1Sm1GVjlJTmFUSUJo?=
 =?utf-8?B?OThhYm9YVW5zWVE5QmdDWW9jblZqTzJaV1QyclpPUExSZWhBbzZOaEdtSFBZ?=
 =?utf-8?B?eDV4R3BjZ3BkRzl5RC94UlhrSjltaHU5MzFZT2JiblBsQUJiQnIvL0lSTnFO?=
 =?utf-8?B?VEpac2NpQlNraTNRVEtBS0pPMVlqZWpBc3Zsb2J4K1FQeUV0VWN6ZmdITHpZ?=
 =?utf-8?B?bzY2MVdnRHl4UG5zUmFhRUFka2E0RVpVWHJQMm1Ub1ExdTRvaHVFOGQ4V3Zv?=
 =?utf-8?B?dG5tNjhEbVUxOWV6ZU5zdzQxMEEwZFhlOEIrRmJ4TEgvWnZaRVRYWlo3bm53?=
 =?utf-8?B?SXFUeTBIdTVGeUl0d3JmYjFOTGVZYUt2RXRuNmt1RytSdUljWE5QWmJKQ0FQ?=
 =?utf-8?B?TllveFJtNU5mMXdSSTlLL0xIczFOSXowVVh3ZnByaklBNVRETGoxb0RtdUZS?=
 =?utf-8?B?TGpnTjdDaXZsQjV1YjdIaUNveVlzZVNmZm9FLzlza2d0emE2Nm5Uc21ObHNU?=
 =?utf-8?B?cnhDUmxYRTZydVFFdXEzMVlNaUtKMFJMQVlTSTAxSjR0UzZrY1ptdHJBVHov?=
 =?utf-8?B?THkzRkMrNEtiVGYzZFNNYmluU1VIL1hLcG1ud0lrT1JrOEppWEZmTEpkUDhD?=
 =?utf-8?B?anMvSG9ERzZ0N1hmNmVQNFhQdXRXMWMrdWRjdjVXVmlReVVRQmxQeTBPNHhZ?=
 =?utf-8?B?SER1K1g1UUhLNVRlc3Z5NUVDeHJpSVdwS0U0VFpJejg3MXhOWkhncVVhZlFJ?=
 =?utf-8?B?VU1USDA4RHZpT2lCdStneXBUVXdyNmtzRHVLb05IMmQwMzh5UEFTTWlTYjk5?=
 =?utf-8?B?NFB6b2JIUnJXS0FuNnpJb2F1RTNvWkx4YWc3VzFwQjY3TnFiVnVSTDlmTnhw?=
 =?utf-8?B?YkQwak5jZXI3K2EyZlJLZ1NZVXNTcU5mc211Tzk1Rlg0T0FKa2VHRi9neU5F?=
 =?utf-8?B?NnIvcmVxQUVSWFB0Z255Q2U3T1RwRFhlbC91SnQvOUY2ZFlrYjA5MnJITWh1?=
 =?utf-8?B?RG00NjJGalkxMkwwNDFzampFQVB0OUovSFg3R3ZoQmRTY3NDcURiVDRCajF3?=
 =?utf-8?B?Nis3ZlZuZTllbVphcGFSempKMzRwOUl0a2dVUkxGa21JeEhUVmowVnRGcGph?=
 =?utf-8?B?Zi9uNjl3ZkJRSjFnZjJyTkp3SHVmK1A4U0RDaW9HVmxRN0JrOUd2Q1RBQkRG?=
 =?utf-8?B?WGU1T0lpUHEveHhnSkptYXk2MnJ5dUR5UTB5Q2tqcmdQZEdzWmltaE8zN0Jk?=
 =?utf-8?B?eVdhZUhBT2xuc2x5RXZPbGZlRkdhM0V3L1FBcUs4N1J2Y2xTc2ZJY3BWT09w?=
 =?utf-8?B?eGd3UjJsN3RyZ3hXYVdiNGhYSTRaMWlFQUZQa1dBSHVPMFJVMkgxQkFkSzc2?=
 =?utf-8?B?Z1kwV2h0RFNoalEzYXlRa2tsdG5Lb0pGMVdRallJdUhIYjBxVkc5L29xSnB6?=
 =?utf-8?B?N3lNN0lrSFltNVN2Y0tMM2M3c1lZb3ZYSnVFNUFlMWNxM2FQK3p1NTIrODA2?=
 =?utf-8?B?cWU5VEEzYmJlUnNSMCtHSjNzeUp1ZHJJd3JkUkowRm1sQmcvODhMaGZnT3ZF?=
 =?utf-8?B?N215MUd2NnVEekF6ZnBhN3FVTDlhWThjZ205S3BaUWdTZGszbEpKYlRWNDFr?=
 =?utf-8?B?M3J0UHIwVGkxeVg0TnExNFpWbUoyMmh0dnBVZlV2YWJKUzhzQnBaUTBxSW5a?=
 =?utf-8?B?Y2ZXb2tyWFc0ZVhvQ0NXMEEvTHZhNzRJSHRMWVVGSmtZY1o2azNmTlBQQTJj?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 88699d77-5a9a-4b91-c341-08dd8bdc3480
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:53:24.8073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfNWy8zzWJtrqKLyNcePzqw7mc5s/DFo9G0Pk+L4+Oe4M7g//osdxUmIW3VsKuiRWmy45HHk6OR1mE/5nobbPeJmIPIPcEQLv+tcmJHfM6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7157
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

Hi Łukasz,

On 1/17/25 5:18 PM, Quentin Schulz wrote:
> Hi Łukasz, Kever,
> 
> On 11/27/24 11:21 PM, Łukasz Czechowski wrote:
>> Hi Kever,
>>
>> On 2024/11/27 03:42 Kever Yang <kever.yang@rock-chips.com> wrote:
>>>
>>> Hi Lukasz,
>>>
>>>       I got a new error base on patch [1], see full log here [2].
>>
>> Looking at the file efi_stub.c that is used in the failing
>> configuration it looks to me
>> that some functions from debug_uart.h are used here for convenience
>> (i.e. printhex),
>> even though the DEBUG_UART is not used. This is contrary to my 
>> assumption that
>> DEBUG_UART_FUNCS macro should not be used if DEBUG UART is not available.
>> In order to apply the patch then, either the efi_stub code must be
>> updated to not
>> use debug functions or the assumption must be relaxed - I'm not yet
>> sure what shall be
>> the correct approach.
>>
> 
> """
> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> index 40fc29d9adf..5172cd78a7c 100644
> --- a/lib/efi/efi_stub.c
> +++ b/lib/efi/efi_stub.c
> @@ -83,12 +83,14 @@ void puts(const char *str)
>           putc(*str++);
>   }
> 
> +#ifdef CONFIG_DEBUG_UART
>   static void _debug_uart_putc(int ch)
>   {
>       putc(ch);
>   }
> 
>   DEBUG_UART_FUNCS
> +#endif
> 
>   void *memcpy(void *dest, const void *src, size_t size)
>   {
> """
> 
> Fixes it. It builds fine with and without CONFIG_DEBUG_UART set. Not 
> sure if it's proper but I guess that's fine?
> 
> While reading the patch again, I think we made a small oversight.
> 
> #define printhex8(value) do{}while(0);
> 
> is an issue because ch may actually have side effects.
> 
> Take for example an interrupt register where reading is acknowledging, 
> if one does:
> 
> printhex8(readl(INT_REG))
> 
> will read the register when CONFIG_DEBUG_UART is set, but not when it's 
> not.
> 
> I am not sure if and how we can handle that so that things are executed 
> but only print is not called. Is this something we should care about?
> 

Can you send a v4 that fixes that? I'm planning on having a release on 
the upcoming v2025.07 for our devices, so maybe you'll want to rebase 
for your client's product too? I'm pretty sure your client will not be 
the only one who doesn't want anything on UART in U-Boot on Rockchip :)

Cheers,
Quentin
