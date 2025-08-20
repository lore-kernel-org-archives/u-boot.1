Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4861ACA0EED
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 05:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C9F080FA1;
	Wed, 20 Aug 2025 07:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="pVPmAV0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8422F8211F; Wed, 20 Aug 2025 07:50:33 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79E1809A5
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 07:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjU+4sJZIsbb0+efxpW9BMmMoOWSH0zzWkJkOCCjdwBbjslpB0/vvoa7WmAMbAs8/1gwOyk26AP3wstzvYPzjUF8Q4SQN0Zf94EZv472dPfJGAlcIgQbG/HyhZfscQdfC75gp+909BYyVE/i6yIYIoNauutvoPiygGjJ9ZcTQ7tWN3RzyXKslVaYtsE3uJR0tL8+mLHATpl6COUdhP43BMFraFAEmZSXbBwnaforZeVOl+8K5CPWDBjPps8riQ0UojD4XkcdWQLZ8/ZJYqujxhevL285T6lRpXfvepWh7IwlQJSEiHDsG1WuUQkiPfdYNcVlJ3RryZvbI5TmqDemvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJIlHHwLH+UDcVvP0RQ+v6a6gw5r+Aq9g9TWq2uwzAU=;
 b=oxPVLYxqayNHF7++QRg4myrGh3tSTgItH3N960AjXXopRuECdEnfDuAOvXXXxgpkLEJyyE3xIEfvblXKcwuP7aEx7IiXEfnKRwF3H9jCjVMhobO2ojfSFJjHvQu2+BB7+hPuhWvkJjUgygTmzBGMKJZq2CmDcptkFAz43MNrRTuQCdR7IdGo/Gg91mACpUSL9aRsl69ke4ahAhB/7xfI7GBKjoW7Q4Ll+nZv51wLCazuHVMMQ3W6RGiig5Mq0Hs3kuuZiIU5LFP4OPC7Osg5IGfX8GwjwD4ZUIpOqQz2IKYLOE9LgudLbLRD/4DYQMQzhrn9D4z8Je7fGQMKB2g/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJIlHHwLH+UDcVvP0RQ+v6a6gw5r+Aq9g9TWq2uwzAU=;
 b=pVPmAV0Iyo3IUPRCmcECQVB9mGFDyDzQ4o95qfF6J1A2Hn/RSioj4esxoSwDU5BdO7DuKmKuvZETZjMgWICcyuM30C7V1YD8vbaXIiCWb7HsbSRScH4poboycoYApbTzCh2R+0W5sS7IKvs879kjkyOHNTmiaJnYJaSUxaXY8jWpjjJCjcNmk6dccVCd1CkcgaUuFOjM+NNqF3zJC+//Cmky3UHAR2yU/LWL1L4vGZPydxfmEW1H4WnKQo2xCiuP1za/OEoiWDREwhxEJI2ckW9FZP+Mb/D4UOIrkAXthJHy2ZiDXeZft9tqt95oe8U05tsfSCAiueWdikVaz8JcXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 05:50:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 05:50:29 +0000
Message-ID: <a2f2b1cf-aa2a-4628-9d04-f293591f5f9c@siemens.com>
Date: Wed, 20 Aug 2025 07:50:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] efi: Select required CMDs from BOOTMETH_EFILOADER
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>, Jerome Forissier <jerome.forissier@linaro.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 83052b3c-1f83-4ec5-1f04-08dddfad77e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzFpNk5ISDlIMDNUM0cxQmw0Z3RzSDJTTGFUcE5raWk4K0ZNS3VHcXdJOTMz?=
 =?utf-8?B?YlNlckpjMXRWMTc4N2NtRE1iRWNBNWFuL3l3Wjg3RTljUEE0U3ZRT1dqeDU5?=
 =?utf-8?B?cXdJL3RhVitERXJLSGZLczE1NTNDbGpRelViMEYxZUVRNm4vc3M5RUg1SUx1?=
 =?utf-8?B?U1M0WEFJMDN2Z3V5QjAyUVM2OFhSSFN5K2RmQ3E4ckRZaDFXVHhSOXRtazZD?=
 =?utf-8?B?bUxLSWV1NFdlbmNQcUlPNE1oRldsSlFwL3AyOHBNem9NY29LQktqNFBlMXE2?=
 =?utf-8?B?VjQ1UW45SXVWbDNCRUFKdk9kTmQ5TW93cFFxbzhYYnM5Y3g3MjFBN2F5cWRk?=
 =?utf-8?B?L0ZyaklDUWRJSlFuNldsQWZvZ0JGUmlLdlc1S2lqQjlsNXBzbUgxK1cyWldN?=
 =?utf-8?B?Vm84ZXNzdkpwQ2N4K1RKUVhtTld3NnlqMDVKQ1JTN3FEaGE4WmhCcTllNlgz?=
 =?utf-8?B?dEhzLzZ3ZWxOY1EwNDYyRVEremRaZnM5dVJBSE9TOFd1UTQxNVFSM2ZRZzNs?=
 =?utf-8?B?a2VHRzBnVzc1UDFVQ1lnN3ozUHN0SHFJS0Rqa2xFY0tNanFOdk9XQnRmQ0lL?=
 =?utf-8?B?TS9LSGJ0bDVGQVd4dmJxR25wTVQxaVlrMFh1NTlYUXFuSUx1MGYraHdwcGJQ?=
 =?utf-8?B?VmozNU5QRzlpdjZxNm4vRTVqOW9mZ1pCaTR6anNDS1huSVF5d21rMnYrODdW?=
 =?utf-8?B?YU4zQ1luRVo3QnBwalc2aitQZm8wenpRUnZYbWRQYmdLOEYzUDdhby9IdlFF?=
 =?utf-8?B?S0dsYlhrSm1WWlhxUEhJQXpjNzJLek9ZSDdNamFyc1lvOEE2bDBSTWZSUVRu?=
 =?utf-8?B?c3Z4b1FXcUVFYzZIZFAxZ1UwTUJpbWFYUkxjSFRWelpVR0Z2N1JJQThYcTR1?=
 =?utf-8?B?ZUZvZ05JbU1lL3hBRXNqTjlvZG5WeW55V0VvQkFvLzVjZmdwQXd6bTJBYmVq?=
 =?utf-8?B?bmRHY05jR04va25qeWkxMmk5UXFEbVJuaGVKMGpsc2lHb0VqdDM2enhsSUFB?=
 =?utf-8?B?UnNkMjZYRUpWM05jSGFrTkErbjBiSVo1dzhram1UckR6SjNnRVBzZ0pxTGpJ?=
 =?utf-8?B?V1FnUmZZV3hUb3N5MzQrRVkwQW5aRXpHYVpTeWZDOEEwWUNQTW42ZkFGSnFv?=
 =?utf-8?B?VkpnYzBoRi9Fa1Q0amR4TVBsUHN2ZzdDOS9PVnc3T1NHaklNcnJBc2lBMGNm?=
 =?utf-8?B?clAyUDcxbGJpSFk5QjVFS2R4YThsYVRaK1dLLzFpKy9xd1RnT0s4QWpuZmtW?=
 =?utf-8?B?KzVRQW1pYit3aVBYWGZUOWI2QXd2Snd3ZkxNazBZdWh5RDZ4M1poMmhJZnl5?=
 =?utf-8?B?RCtLVzRNNEN6b0RRZzB4YzQzNEkreG4vbVoySmN4VHJLZEtaVWtRWUpINUpY?=
 =?utf-8?B?bC9GcFZjTTN1Nm8xWU5Xcy9OUWlrMkxyZlpqcUVDbTJzR3hodjdTa3h5ZFpR?=
 =?utf-8?B?Sm91aEFTUmpGd2g4NXpwbUdkb0RzcW03blJPKysyZTdUYzdZcW15WDlUV1JQ?=
 =?utf-8?B?aXU0ZVRvanZ0bEtlMjZYc3RadW9tU0RGTVkzVlJtK2NiMzV3cXhqbTlLK3lu?=
 =?utf-8?B?cmowRmpQdE9HZVp2aDJZQmV2bmhQRVI5em5zcHZXZG5XcXRHZDFKWGpHQXRr?=
 =?utf-8?B?emJGRXBIMi8yclozWHRad3NkNXIvNzdNRVozQzhlaGZoWG4vUDZ1S3dvT1BX?=
 =?utf-8?B?SWZ3UzFKUkhaQmhWSTNyc1NLVkhoRGwyaWdVbkFXU1owVkVybm45cVE1bXNk?=
 =?utf-8?B?NUdMNFhCbmNoKytSWVdkc1NWRURyWXhXNWFSMXorcXA5cHhsZXlzdVNlYkJU?=
 =?utf-8?B?SExOY1UwekNnRUxkT2dhMXFRejAvMG5JbU1CMjJIay9QL3BkZnpJQWlCRytE?=
 =?utf-8?B?dzlxSWZGVHkzSkdHeFNnTVBXejQzQkZMZ0s1aE8xckFZRGRuaEVFOHVZaDl1?=
 =?utf-8?Q?d5ex/e+MJfg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTFkbEV1S1V0OFlYYjZVOGdSQjdZUXl2ODhmeHZKbmdKOEV5akVQaFNkMzJB?=
 =?utf-8?B?RWZsVEpiSW9KQXZIbTZKZlB4YTMzVjNYRGJNVnF6VVNLR2VZYjRFeTJ0YU9q?=
 =?utf-8?B?c25xYWdqY2dzaE1vRnFzVU9mcVhuemRpWVJsMmtxeXFYNUc3R1JvMEdtNVBQ?=
 =?utf-8?B?LzZzcGpkZHVsWG02bEkrWmpPd3JjUnhGYmtoWEI3dFd0VlQya0JwTnlEd0w2?=
 =?utf-8?B?STZhN3FuWVo2US9Ldll1UFQ2R0xpTkZHcnBET0NDbWRDcW5reHl1U1lnY3RV?=
 =?utf-8?B?di9kbXVOQlFiVGZZMGpGOElmYkdNWVFqVWV1aUlDK3E3bXpGbW1jUzdvQ1dT?=
 =?utf-8?B?UzIxNy9SVUEvQmdUTGZPSXNaK0xQdDdqMTlSbWNPdDdKMkgzZFV1OUpoWDZI?=
 =?utf-8?B?clFkTTdkZE9vZW9jZm8xL1lRWmxyMXEyNXpMa3Q3ZkxseXYvZDZhTndnU2RP?=
 =?utf-8?B?SFlkTFRKUS9uYzVHbHJSSUhNbkZydHVQSE9OM2RIdGNGdTdjV0k5OUJjNktp?=
 =?utf-8?B?UDdSZTRJblFFNzQrRlRxRVR5Q1ZvRzRHc3ZMMnU4Nmp2RU5Nd3cwWXE2Vmty?=
 =?utf-8?B?MmRIZXFoV2h1WUU2ZFJ3K2JLOTgwaHdtbjNsODFQM3BWRTY0Kys1b2kwaUgy?=
 =?utf-8?B?L1hNSmp2d2hUZUp0SnlDZU9hKzlkNXdjUTE3SW15UVFWSGdZTzl3ZVR5TWJZ?=
 =?utf-8?B?ZS9kcUZGU1pSejRKOU01VW9ObzNrbFhRSzhnNUFBcFFBbzhqN2pIaHhlcklD?=
 =?utf-8?B?d21ockR2YkltVm5jb0VVaVlhN2Z6RGlOaHlmczF5NVUzOUlmcW9hYjV4MkdR?=
 =?utf-8?B?MUl3S0gzSWwycjdjaWdLRE96L1p6cWpkckVCVURHZENCTERkblYzd0VDVHlQ?=
 =?utf-8?B?NkdvazhQN0JMeFI0QS83TFN3TlVycVlvMzN2T0ZhKzhxK3p1VTFKaVhZRjBG?=
 =?utf-8?B?ejgvOUlPVktiS1R5Z05LTEZzVms4ejZhbzFkejlXbGhicVFJOFhHbFI2YjBL?=
 =?utf-8?B?ekhlK2x1b24vWU16VmlTaFJBdHpPOGF1bnpaZEpUM3p1ODNTUW02UEpYWHdz?=
 =?utf-8?B?dkpoY2NqSHMzUkh0TkRZNGV4cUd2VllRSVBiL2tvUFd6UTkvQWxsTjAzYm1G?=
 =?utf-8?B?ejgxSzhDNTZ5Wkd1WDhOMzN2bm5CelJZaWJpaFgyajR5dGpUclZKYjdQR2xk?=
 =?utf-8?B?VEl2TmE3MFdWWTdXZEJVWk9kK29TbTMySjZGalVIcXBMNmhHRm1qZEptck1E?=
 =?utf-8?B?V2ZqYjdnMHlYWTYwRDIxekxqR01WWFZndE5rY29WZ1BvcWIrUzNncS9LRWI5?=
 =?utf-8?B?b0trWk9RbldINk04eUF1THl1ckRjSzhTdzZNZEx4RzczY0hOM0xRaWFOa3pZ?=
 =?utf-8?B?K2d2dnhaZTB6ZEVjZWNwaGZ1OWR2ZkMyblp0VGdzditJMXRKQzdINDZ5RUdY?=
 =?utf-8?B?WW9zM3dkMkxJaVN1d3NIVGx6ZS80QW42MXFRVFRnZE9zWlNtZFlsWXVsR1Bk?=
 =?utf-8?B?cUxpS0d0UEU2S1pEVE44ZTl3L3lLbVRXbzZqaHR2V3MrOHF6ZDBTTmtJYlh0?=
 =?utf-8?B?R1VFbEtkbGNFSkl3RWtRL1M1ZU10UGFVdWtvclViUjA4czIxajJOVVdpUVQ1?=
 =?utf-8?B?bVE3TjJOOEkvOHBtNkJNd2ttUDJTdVhRbUcxQ0FMMG9yZDFYaUFjVjNLM2J2?=
 =?utf-8?B?dWRwUUErbURmNkJzdFBiQ3Vwa3RGZFNJN3EreXlaOG0rc0FpSE5IR3ZpQWt5?=
 =?utf-8?B?eFBmeEJuazRweTl0MlkxU1FpUW4zcXUxQmJUL3dVUnBtY0NDR0QyK3ZDZzdN?=
 =?utf-8?B?KzdORlhUR1FGcnNaQldDSm9yTE1KdS91bnBPNTFldVRZNkw4QXg0QlJxRDBz?=
 =?utf-8?B?anZjQ3dyZXJuUDE1b2FxTXREajU1Wng3SFdPc3lhQi9iclJ2RGtqZlZ3cHkw?=
 =?utf-8?B?ZXFVZEhSa3NHdDNjSUVQMmJUbC9hNk14Kys3c0ZaTE5PbU9XOWNUSXBieXZV?=
 =?utf-8?B?QmpxNERTek1rZXFlbW5MRCswRUxnOFNJeU9IWFYyaVcwVjVwL1ZTa0dtRWEv?=
 =?utf-8?B?OTJsWHJDc3Z0MERHYkZsN3dPZmFJSk9MdUpFQ0ljL3dPSkk0Y3VMQ2VWRnlY?=
 =?utf-8?Q?aIwb75jAXEXb0gDmOoPskBt+R?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83052b3c-1f83-4ec5-1f04-08dddfad77e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 05:50:29.1801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV54UdaFyBjVZ4aL94pA41QweX1xOD4oNb0n4OvSJHJ+gtkBkGo3dKjwmtSwVs+T7eEEabUhBcOXmvpiYYFPJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7102
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

From: Jan Kiszka <jan.kiszka@siemens.com>

There are needed because distro_efi_read_bootflow_net depend on symbols
provided by those commands when networking is in use. Imply is too weak.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This obsoletes https://patchwork.ozlabs.org/project/uboot/patch/fffc4713-4f89-4a04-acc6-8b295e453226@siemens.com/.

 boot/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 54ef7052c5c..2813a39b102 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -605,7 +605,8 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
-	imply CMD_TFTPBOOT if CMD_NET
+	select CMD_TFTPBOOT if CMD_NET
+	select CMD_DHCP if CMD_NET
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
-- 
2.43.0
