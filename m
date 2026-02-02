Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88630E6529F
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 01:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C389983C51;
	Mon,  2 Feb 2026 02:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SvMj+C8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF1283CD3; Mon,  2 Feb 2026 02:43:11 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F94683C51
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 02:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh7/Cxg4hG/ra5HevyJ7BCdADDyzU7q33B7/41ONvkpx5eocUrlDX6emeKY/gVVyvKpRBbjSi5+zPjnnLAJyr7xLZbwnUgYS7QFcdpnrjbaD1NXhoAVhiEat4NDt9gNATzhU7w/Hy8nD/a8jgaIIVdbt5IWQYfnGzHIDc1sL7dhaPaW2eWYkRYp08rzk7iWB+ioqRmvJL6HBbTeffACR5c33HoiG3m4GvD8xadGeRSpClnB0nkJSb6hmAZlwiTAyXVpFs58/QiRYj7w8XP0O5yPWjONaSUeEbZT7rNSxG7jL9p+ot4oO90Vru0Sul6K9+KVyez3hll9vGxgQFLsiAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRA50LidVeaci26pwIsyGADZqetwRF9RhkyoVB1oYPQ=;
 b=ISCKRGFiagcxPcf/TmTvsBJ0BQgHg+JSPDqiyVtYblHlchbOJ7aYuvweg3l3f6wqpGsw9aVOFIolND4OEu765HwvZYA8ShDlREFtotx+FoOsF19RzazqkmUu6YJxhf/cuyeo/1LFMHV2J/zleXk41slpolzTk/SWhgLLaXZLWIijPkaBaWGwhcWW6s8DPGFHW0wUCieb3au0NQ2N5k7RIlqZrQ2vPBhTo+dHQJCVWqNsaEmAa4XA7M+ZxwFkRJShMHkcCcYFC6quNTcin7hkBCZOsauwg+vszpGEG9V+GsO2j5QR51vHmGuq49FTytHs3jpVWR3ish/T1zEx5Jb6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRA50LidVeaci26pwIsyGADZqetwRF9RhkyoVB1oYPQ=;
 b=SvMj+C8vBJn649Blk087oYG7QE7J2fQGknuqCV3QAZk4jf3A2T3Vjl0FSzV/paikFqG6nZUc+ibmA3Tr+W6FwafIPZLCwMHw/NV0fJ3G7hcmMNiGmVCVjao4mr+1Eq9/cTI9zrr23T8o+722GFhdLckffRvHup0JhoiPUNHmjtXJsMxJcx5ZaTIUWjyWdP0lklgitzpFTegZkA4CGO9pWVmEX3yMqEBCGDStxygejz5scH+Csl4FnCOMcEE1raFzVRV6uw12uM76+nygh4zSdcvUKbplFKoi9YOYIDeLS8jBPU/29eZjC2Y2IfC+aGBTR+vLoa4YaXhIWu/z5fDyag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB11483.eurprd04.prod.outlook.com (2603:10a6:800:2cb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 01:43:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Mon, 2 Feb 2026
 01:43:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Feb 2026 10:57:47 +0800
Subject: [PATCH v2 4/4] imx95_evk: Enable remoteproc for i.MX95 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-imx95-rproc-v2-4-b85fc7db23fc@nxp.com>
References: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
In-Reply-To: <20260202-imx95-rproc-v2-0-b85fc7db23fc@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SGBP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::19)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB11483:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe1e49d-734e-4f87-9b07-08de61fc6a0e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mit0d0wxNDlnR2pnMkVSaWRZbTRqaUJPcUNrUWFKZTE2cVY1aE52eXZPUEcy?=
 =?utf-8?B?ajlzdG1WTklqRUxLTXF5Vkh2SUk3eHJ0UkJlYmsyNlNlL01FQkduVzE2RG8w?=
 =?utf-8?B?OVllZkd6bURRV1hPazFrZmhlaXo2M3pLbFRLZ2NEN2UvUmlieHQ1ZE9HQVlv?=
 =?utf-8?B?czlxeFFyN2Y4U1BoRGV2ekJvdnFUeWFnK09OSTdUQkpJY0VCbHQrZkxvTGdW?=
 =?utf-8?B?UHZIZkxmeFVDOEpqT3prSkhyQytTcWIrQlh6dE8wc0doY0ZOVUdBU2w5cUVx?=
 =?utf-8?B?eGh5K1d6Ukp6Zjk3RGJOY1dEY240MkNaRXBLUnZ6clZUdkhFUE9DaUZFcXcr?=
 =?utf-8?B?ZHhVeTlDK2NZTnNISU9xaGNXU2xMYjNLZkJFOGlRWkxtK0tKV0c4anBMcVls?=
 =?utf-8?B?NnpMR0NSYkxWb01jMmVQa2VFN2hDcUI0TXlDV1V5cy9FcnBFUXdzZ1RPYlJN?=
 =?utf-8?B?L0lZM2VBd01wVmVNMlY5NzdxQzVlYlhkcGhEQ2ZRQysxNHZQSVpwMmp0djEr?=
 =?utf-8?B?Vyt1bUZ4VEdLNWJGR2FWazIxWFlzRlk1QklGVmRtOEEvbWFIdnFRNStBYVpo?=
 =?utf-8?B?R3dvcmFySFBaNTBlS1FSUGl1bmtIL2NwenUxZ3RhUGJ1OVNHSUkwZVJKamFv?=
 =?utf-8?B?YjdSdXR0U0dyL0wxd0tMWWxrV0lSSE5XRlgvUnlOeUNEZnI4VUxpVmN2NFNq?=
 =?utf-8?B?Y1RtRmdXSngwbnNmVFZ2TTBoMmRPMmJPVlpJdGVPenFRSGtaRDJnY0RPbGZ2?=
 =?utf-8?B?blRSUFQ2Q1VqelN3MUpJLzhCN1pIMFdyVHZIVzVzcFpSbk9jY1lWQzNDejUv?=
 =?utf-8?B?aEY1NEZhQ1RER21EQWdkd1JqTjRsM0tnR0o4N3NBT2xJZmQ2UDN4aVEvQ2di?=
 =?utf-8?B?Tmtma0lzYUh0emJVOFl3WFBOQlNSaWNKN081eTFKaXY4UzVSUHVWdXQrOHZm?=
 =?utf-8?B?RXJjRHFScnVtQ25mVE1VbFozQUdMc1BYd053c3AraTAvc0VoVDBZT1FaZmtG?=
 =?utf-8?B?WXprWGlEV1Q3N0VoSnBTMDVwekY1VTBNR3dIaC9VNGRldnFaL1prVW1DZmJr?=
 =?utf-8?B?VFhzTStFV2dYT29KU29VekhVeFdXZk0xMVZqQzJuL3dYbFNwZDZJM0xKSUJ3?=
 =?utf-8?B?YmxDVW93OWlNS2FEKzVHWFl6Y0RVOE9NQzdCSDNQWStVL3BMVVN3aDhhOFhG?=
 =?utf-8?B?V3c2elJRZFZGdFN0SzkxcUF4VWVQaGlyc0lJdEF3cm1rcUdTNHg3elRXaU55?=
 =?utf-8?B?QTVGVEFYVHBnNUVWTjFvbjRMT0lWMXgwZHdLeFJwSXlPNHcySVQ3eVJvRUJj?=
 =?utf-8?B?M1EwRXI0MFVmK3ZJS1pCUytvVm1ZYU5zT0o0Z216ZWRwS1RWdk9pbDBsNWUw?=
 =?utf-8?B?bzM4Slp0c3hzWENQRkE1cTVtc0hMMUhNZVUzWVhvSUc3cG4wUG1rUTJMNnVv?=
 =?utf-8?B?djNKTTg4a01kMzZnZG8xblE3S1lNa2lkYVZ3LzAzbnY5U21QNWcyMHAwcTgw?=
 =?utf-8?B?WTdIQU5qdy9qSU9ZRnRFaUttbHY3MVBZNm1qYzh4SC8zaDlkQjdLRnB5MVVp?=
 =?utf-8?B?OUZyOW1JVVZwSm1pWGE4bDhGY0FrQzZ6WWhhUHRYM3hkWkJ0c2xoSEcxOEZl?=
 =?utf-8?B?VVloNkc3UHlQcFR1bXhES1FUdXVodzNTQjFTK0xXc3ZGU2RQaVAraC9DeU9i?=
 =?utf-8?B?bWR1UGtoWjBpazM3cXRtaDFmbk9ITnhlZ1k3QWRvU0Uxb2c2ZmsrM2pyeXpJ?=
 =?utf-8?B?aFNkUlQ3ZnRjaXBTem5XMlZMSHZJOGc2K1JPVGxaM2tlb2pleVZ1MTB3V2Ni?=
 =?utf-8?B?N1BkZTZDelJtSTBuUk9RLzUxWTFXVk1CQTZ3Vk9XY1lqSElURk1KenVOSFox?=
 =?utf-8?B?UFI1UjBxa3EzRTEzVGhuVXYzR0szaERnNWh4SUNvU2hQRytsVFo5eVpsZXox?=
 =?utf-8?B?aGdUK0ExSHJJb3I0aGJDUlduTEVuUFd6SHYwMVRFNUxkSWVNdVRVamVueXNP?=
 =?utf-8?B?bTFVQ0h1Z1dnNUJSRnpwYUpBTkpnVmlHeHVQL0JBRElFR1JJZEFuNTJRcnhx?=
 =?utf-8?B?emw4MmUyWmoyRFVZL3V0aW8wT1krMExkbTBHeUdlQjN0TkNLemYyOC8vQUVT?=
 =?utf-8?B?QkF6OXhLTld1NW5Wd2hIUkdTQnZOT1lCSjZRaVd2Z2hlelVzRFFHQlJTTlR2?=
 =?utf-8?Q?GdEklb552XypZQo2E+WBFVQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnN4S0FRWlhoWlpWTzluR2NHc1ZHSW9NQm0zYW1QRFlMTldZMXBQNzFmOC9F?=
 =?utf-8?B?TGJnanVvVVZtckY5RmpseUlRYTFqMzhsL0dZb0pzYnR6UGI5Q0E4K2FEUGQz?=
 =?utf-8?B?OHRVTlFKOE5jT0FNaFQ1WUNmQm91RkxTaExBUnJCSkdOM2NnYTBhVUp0QWd1?=
 =?utf-8?B?YnBSV2RzeCtVcGI2RnJWcmNtQ2RpSVgxQmdvbUxGbnQ0MlZBOUYxL041YkVm?=
 =?utf-8?B?cE9nM3Y3UVpUWVNrcWlIZWxiUU5vNkJJZGRMSXgwTXNWWG9nVGVVbk9kei9R?=
 =?utf-8?B?N3Q1bnRXQjcwVnpCZnpmVXk2TzhscHJIUlZZMFRHQ1g0L1VxdWhQdms0blhs?=
 =?utf-8?B?eG13Z0RQdWpSUEd1V3k0d2V0YjQrdnk1SWJYeEw1RkpnTlhQVjVqdUx6Uzhk?=
 =?utf-8?B?aU5JWW92SFp1MVg5SUZuT0xnWDZaejEzN3RhU3ZFaDBKZlgvOXZzM09wRHZj?=
 =?utf-8?B?QXBMTjhhVlhMV0ZqNmtoSEN5TVdBbjFSUUt4N0NsaXVBSFJiZDNMaTVPdm0z?=
 =?utf-8?B?Ry9JMHU3NHIydTM2YVB1MkxjUmgrOThoamdqSWlERzMxYkd3ZG5RL3JWMGpF?=
 =?utf-8?B?RUgyZjRPQ0lLUTlwUHVsUXhCcWRVMVllQjNHQ3htUEtvUHU1SzR1TStxTEpD?=
 =?utf-8?B?cDU2UExWVWRObC85MzkyVUFuYjYzNEN3WTVFTFJaZ0ZZVlV4YVNWZVV3SEF0?=
 =?utf-8?B?VVJKMjJCVFNIR2pSUUtzRHN0Qy9HcjRGbStobUYybHg3T0xpd0xjTXZHemJx?=
 =?utf-8?B?YzlWSmpnZnFZbFhBQUFlKzVkR2xudUF1WlRuZ0liOTVjbGs2dTRreUpIaDZH?=
 =?utf-8?B?b1pvSWVyMHVQRkZaVnczOEdtVXlqL2ovYnBNTlRRY0tMaVFTMXVUY0NLeVhw?=
 =?utf-8?B?R1ZjU0QvNTcralNVWjdmWU9WTkZBOUdCNmVzb2ZUdFlHY25qdTF5T1BJbDFs?=
 =?utf-8?B?dTRSeDByRittQTV5OSs0VWFHdDhmRnpBZEN0aWRSenRDNVd4Snh1dG41bk43?=
 =?utf-8?B?cm5wNXh6eFZtTDBQRDNUMHhrcmpNSnBlZitSWnhDN1JrT1llejZJejdZTExI?=
 =?utf-8?B?QURQMVRhL1Mxemx2eEcwNWtvYWZ0V3QvMXgxNk9xWEdrU3QrczVZNndEMFpn?=
 =?utf-8?B?c2paNDBlbUw4RGxodDZMY1B1QUlwTDRwWG9XQ3VpZTlxSVZEcVp4UUF3SXFr?=
 =?utf-8?B?anZ3NXJOUENLeDRIOElNMC9BdmhNaFB2Q2NpTUdXb0tONE5iYWFuSERFcUJE?=
 =?utf-8?B?YnZxVmtHOXV2K3p0YTFybDNGbTltSno2K3JLY09rTDdud0xuUk5sZVNtbkkw?=
 =?utf-8?B?cXdoOFFBTmdqUWdFNUs2clFKa29WVzJKWWZTZUNEbUE1UE8rcTE1ZWZwTHRG?=
 =?utf-8?B?S2h6bkQ0WE5EZm1UVTJiNzBPeVk2Z3hSVkxnZUc4RUFpREt5TGRpZWNBcERD?=
 =?utf-8?B?cVYxdFV4STc5dzZMc252TUVSd1F4azNHQ040VTBPbUtmZXFSMkFnOEhtUHVq?=
 =?utf-8?B?U1VyeVBaSVNpaFhScm9OYXg4dTE0WHJEVWc5dXErK0cwelQ0L1VhaDQwbXpH?=
 =?utf-8?B?dlNZbDBXUm5uQUZkditiQzBZRmg5WituYnVwUjREeWdBZk9MRXVmSWRTUi92?=
 =?utf-8?B?SS9NSHU5TkxHRlRQZTlqemRTUmY3bWlJRmZQamluRjUxVERSUS9YVmk3OEtu?=
 =?utf-8?B?OVBYOWMvWStJUzg3TkcxMXBVRFE5a3oyZytUVTVXV3c3akZpcEh4VDAyTzQ1?=
 =?utf-8?B?OUpacGNRQXUrSXV0UUtXeHk3NkVUMnN0cmtHbGplY1c4b1l1Tm1lbFBkLysx?=
 =?utf-8?B?eXdmZCsyTTlVVkxacGliaHM1c2VhdTVibUFiSVNYaUVmaERjTTlNY1VrMm5U?=
 =?utf-8?B?cXlJMWNvM0RNSTVUR00yRnFacnR4dktUdGtqU1l1TE02TXBYVkU0T2ZjdTdu?=
 =?utf-8?B?UkhWU2w1dGpyNkxiQ2hJdWNlZ2t4dnQ3em9Udm40cVp1STBVRytZejh3S0ZG?=
 =?utf-8?B?UFRCODRhNENySGtMbjdlWC92TGhVd0xsRkpKT1BZbHdlL0ZtQWlLcCtBSHlp?=
 =?utf-8?B?T01wWC80MG9YK0U4bWpZUFRsdjJhZW9Ed2dGckx5bGRIVHJmd3FjWnVzZExO?=
 =?utf-8?B?WXI2em1xVTRhMkNodWo4a1pPaW9KbkxEVkR6UytTbCtaejRVSUFsM0FzTSt1?=
 =?utf-8?B?NTYyVnhXTUNXNUMxaDhFakNkYXk0YVlnR3pGM0I0R0NoRk01aDhSVEZGMk4v?=
 =?utf-8?B?N2twVmtzL2ZwaW5QcFB1Wmp3QUxIL2VUU3o3R0t6S2hYdy9PTE1YOXBQYWlF?=
 =?utf-8?B?U1ZTdzRFNTBJTTBmSGRIQ2UvNENVbkNzbnVKczhnREw1WXY4c1hlUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe1e49d-734e-4f87-9b07-08de61fc6a0e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 01:43:07.5338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMhcfJi6RkOzzXOWgJ7vjpjYmxYBGRl5C0i6Tgm2gRgXU8HncxFcMeey5Pa2ol1nJHnp6NQcp2bWoh2Z4hhKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11483
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

From: Peng Fan <peng.fan@nxp.com>

Select remoteproc related configs for i.MX95 EVK to support manage CM7
using 'rproc' cmd.
Update doc to show details on starting CM7 using rproc cmd.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx95_15x15_evk_defconfig |  4 ++++
 configs/imx95_evk.config          |  4 ++++
 doc/board/nxp/rproc.rst           | 13 +++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/configs/imx95_15x15_evk_defconfig b/configs/imx95_15x15_evk_defconfig
index f3099f14401..11d91e25c3c 100644
--- a/configs/imx95_15x15_evk_defconfig
+++ b/configs/imx95_15x15_evk_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -104,6 +105,8 @@ CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_ADP5585_GPIO=y
@@ -137,6 +140,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 631ec23c335..a803e61dad4 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -69,6 +69,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -105,6 +106,8 @@ CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
 CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_ADP5585_GPIO=y
@@ -139,6 +142,7 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
 CONFIG_DM_RTC=y
 CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
diff --git a/doc/board/nxp/rproc.rst b/doc/board/nxp/rproc.rst
index b023c1fadf6..7836935bbc7 100644
--- a/doc/board/nxp/rproc.rst
+++ b/doc/board/nxp/rproc.rst
@@ -67,3 +67,16 @@ corresponding board.
     rproc load 0 0x90000000 ${filesize}
 
     rproc start 0
+
+i.MX95-EVK
+-------------------
+
+Steps to start the Cortex-M7 core, need to choose the correct file for
+corresponding board. The example is for i.MX95 15x15 EVK, use imx95-19x19-evk
+if your board is i.MX95 19x19 EVK.
+
+    load mmc 1:2 ${loadaddr} /lib/firmware/imx95-15x15-evk_m7_TCM_rpmsg_lite_str_echo_rtos.elf
+
+    rproc load 0 ${loadaddr} ${filesize}
+
+    rproc start 0

-- 
2.51.0

