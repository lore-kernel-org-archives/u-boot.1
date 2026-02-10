Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9B0EA3F0D
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 06:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF1D83C67;
	Tue, 10 Feb 2026 07:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="r2jdODcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F0A8388D; Tue, 10 Feb 2026 07:57:33 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9668309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omecFeKQvHmrrk/HwwpXQgNVA5NKRl5kjIaqRV4JZhkJ0VUkodUFNjM5UVG3T5pqrnoeqQyOCZuyEdWPSBhM44xRHJrQ7IjibwM74pftEWNxpKPDWNk8bQfgJENu1RcdsPokHt9oUm5cUxDJ/70tQPQw+/jqWn3EmFofqVQnQvekIfD+4Zq3zGYL3wHEtpfNb32GpYoFvDYJ+vPedG0y97pMpIpUuGJlJ61jPMEXnA5HBPWM4tbubqs1LdlBT/WB7gSUTpdHwYp9ACtn1aD2RKUiygRRhsPNNr6H0VpgM/I3ss2pPB1WMGZnj0wtr/kS1Ii31GVg4OLUwhoYOYpesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzX+hZMcO22BD2Nv0pHag3I9JhkgQuPrXD4qCuTpp/Y=;
 b=tD1ZyrJZp8B35NJZgzsBnv5tHqR2H/eYZ31kejaZd913fiqzpMe0par63JQGPUuWCMjgjpgNGb7rBz0U09gp+YIL2RUWj9/DcbSHRg1jzjJV1eje/4ILFrDcPIZBK7deLKur9DHdhILzu8UW4RGVIlB8vBmYkcmyIpSc+UL5pnlQILOIobjXKC+Jf96iuuv4ifGxjvRszkEwqJiKpVDioPJeRFDiwr06TLCntB3uMpZvSatms1pEoXMTPKUGJ2R9FQAOJm8XEPDCZA8a/VHj0wkzuniVayVMzWelDJUFK/IHHUNgohwadiyVGuaaoVVtEBGzhymmhBoixNx/5x7oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzX+hZMcO22BD2Nv0pHag3I9JhkgQuPrXD4qCuTpp/Y=;
 b=r2jdODcRv1r+L7U113MwwHrZ5RnwjZkf9xS3vgZrEnfZxYTsDyfGPLlumzL3IttglSOUFW7WdJXeGtZBiJsGt1vvXXXvS+uG/HeFQm6c/RRcRgK2n47RQiYRv6y9do/G6tiRkNh0qrA0AdbQTIfaWROFfgzxjy4TL2CLje7q/3S6ejklcJNAdHpM86UU1VPNOt5WYzScrXh8vm6GXCJHGdOALROX3KhjfPHB+fJhC5lrVCURHBw5/UVK6vR/AuSnHwIsi4+UuD4EWFmh8DDnflMWUzzL2khxzBcmRGKj+RTnFe8sNaTpWU8K5aaLRErN6qOcTPMQBjKycr0hH+iSnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7455.eurprd04.prod.outlook.com (2603:10a6:800:1a1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 10 Feb
 2026 06:57:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 06:57:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] Validate device tree node in SCMI/Power/IOMMU
Date: Tue, 10 Feb 2026 16:12:13 +0800
Message-Id: <20260210-scmi-fix-v1-0-0d75f57944de@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF3oimkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0MD3eLk3EzdtMwKXYs0i8RU0zSzxKTkVCWg8oKiVKAw2Kjo2NpaALB
 4NgVaAAAA
X-Change-ID: 20260210-scmi-fix-8f8ae5f6abce
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: b731d25a-5f10-431b-7abf-08de6871a724
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTIzSEFra3JVenpDaFhoQXAzYXVaT2FTZFczSVk4YzBHdzlHdnl6TjZ6eEZm?=
 =?utf-8?B?SjZBUHdvVTdqZVcxT3ZyM0lYZmxsSGs5eG9CVUkzSCtMUTJOS1RUa0hNeFlp?=
 =?utf-8?B?NVRhcVJBRTZXMWhQQjIwZXBoZ0djNVNHekNDTFk3TXpFNG1OR1l0dE9kd2Zq?=
 =?utf-8?B?Rk5lNSs4emhkTXhQeFJIRG81Y0xFRWZkSFdWU1VCajhDb29tWVFPeWN6Ykg3?=
 =?utf-8?B?Qk1yamc3SmlzR0ZSazdhWWFQM3oxNWZ0WTVEeHREcGhCRU5EZ3JPTkxPUGFK?=
 =?utf-8?B?OWlic1BsOTYwQmZMSm55aksxYjYwVTU0OVY2RWpQQ1o4M1I3VzZqcDZxQW9o?=
 =?utf-8?B?UlZjZGFGdTJzL2xRZGduRld0NDA1VytXbFhNcUQwK251TDQ3K1NVdmg2VUtD?=
 =?utf-8?B?c2w5ZDkzTEdrMDNPSldSaXl3WFlHdFZhWnR2NkJ2b1ZHL0tMZmtISVJNSmxL?=
 =?utf-8?B?d0hDbUliNlJNejBvTG5ZNTFORENlUjc2Vk9UM0Y3Tlgvb251VDRSUkJQNFh0?=
 =?utf-8?B?cHROcjBlWDZOWEw3Mm5xN0RVczVyL1FDZHpqSFNiMnNvVzRsY1ozZUxNMTA2?=
 =?utf-8?B?N1pyMlh4NTF5QVptTEhtYVdvNWc0TGZrZjJTc0ZkSlNyMXpRQzVFYmJhMUZs?=
 =?utf-8?B?NjROS2RRdFY2YzhVTEREYVNrakthZlMzNHkvN1dWMGdSREgyOTJ5d1pHOElQ?=
 =?utf-8?B?R0NUWFlMbWN4VTFiTjd0d0RvTklFSkc2Q2Q5RVlPYU9md25EUk5mUmswMklJ?=
 =?utf-8?B?R1VLR3dSR0ZsQmNTVTBES2trQ3lnS3lsWjAvVDVzQlhCbk9JTjlLYlNxVUpv?=
 =?utf-8?B?RE1uWWZMcVJRN2lWR2FGcjFtUitxc3UyWFk5c0ZDdk9UclhUOGwzanZ3b0dL?=
 =?utf-8?B?a1phaDJtdE1BWkR6SWJOK2IxWkJQMC9EeHk3d21iNkJxL2dmTnRSUTVlSnp0?=
 =?utf-8?B?N2VRcEEwNzc2d2RGdCtSaVlobUY3Z0w5Z2Z2ZUJXd2RnK3NnbWllUmhLZWpE?=
 =?utf-8?B?Y1hGZDhBbTI2VUU2STZPNjVVZlZrZ1haejJlNUlibjEzYkoxR2xFQXJSWWwv?=
 =?utf-8?B?US9pSExSZ2dmY0lRN2RjdzZRWnRNcnM5Tm51ZkN1S2luK3d3RG5JWmtWRHRN?=
 =?utf-8?B?b05mMFMzbXV4dWdJb0lzREkzZ1NhTjJmQTZDUGpqRjFoeEV0YSs4VTFtVVVm?=
 =?utf-8?B?ZEgxR0lEbjc3R3hjeHRPUzA1OWRyZ0JNZXJVendRaVZhMGN5aGtaZUdMakJv?=
 =?utf-8?B?K1ZqYmJoSjZjSXZ2bFZOdjQxTlhsd0RkYlpZUHBjbndOMk1TRlJJTGxQZ1pC?=
 =?utf-8?B?NFNCeEFNeHdadTdFeDVzOHZxZ2k5WWpiUXlSK3E5d3JkNDl3N0oySnFidFpU?=
 =?utf-8?B?L2FldWtRQm1kVmdEdHVmRmRXb0dhbC9FVytQeGlKVEN5ZzJxT01CdzBCY0RC?=
 =?utf-8?B?V0MzTTlXN2doVlBkOXkrbURiMGJ2eDh5VzdIaXFJY1ZNMmZXV1BSOVdZUEwy?=
 =?utf-8?B?TzMzUTBYVzg2Q1hvQVc5Zlh6ZFcxUSthR3ZDSDlEZzBscEYrVVVFOGlBZ3I5?=
 =?utf-8?B?dXJrb0cvTkFRSFJpOTcrTG0zZHF2bkpGK0RGSnBEeE5nR1kzeWdVUVB4anlp?=
 =?utf-8?B?VlBWL3pheTE2NDhrbGlzT3hXNm5PeXVHckl4b1NqQk9QQVhDcXBqQWxhYWpp?=
 =?utf-8?B?Rlo0VmRyOEd2VndQVHFHakV3VEdCdW5POFJwYTBVMmZOUitpVndzWGpDTzBh?=
 =?utf-8?B?cGFNK3FzRTRrUXVnVFpSOEpOYkR3b1g1cXNsMFFLMGFXSkRBK2k3dlBkZ083?=
 =?utf-8?B?cjNwTm16aGFIajhGaUFvOUc0dERmb1NVN3VxSGErVjRHTFE4ZHFGb3VWbmtp?=
 =?utf-8?B?NDJBSmQ5NGlHak5Xa0MyZmRmdWhnSXk1OTFEbGtRdU5nNmxqWXVsV0tMeGd5?=
 =?utf-8?B?SVFwMHlHT296VkpHUlNyeUt0U2t1WkUrNUYzWTEzSWhPU0hvVWlqTjJNenJY?=
 =?utf-8?B?NWJMVjdEY2JZalNPRFozd3lJWjlzV05Va3lwZ2ozL05CZ1N1V1FZWUh4N0Yx?=
 =?utf-8?B?bGl5UVozbWhjdVNmbHg0ZHBtdnV3T0NxOWIzVVlRZVdBUmpnUGh4MHBDbDkv?=
 =?utf-8?B?ZjBjY2kwZ1QrejZPa3JoRDZESHBFRzVHWFVKQXZMQnNwMWs5dGh5Ly9BRGxa?=
 =?utf-8?Q?d4Yhr5qE/T3kfQtfzpJ3p/Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3E1L0R6am5ndjdnbmt6akU3aWNRWkdEREVGN1VxcHMxUXpMMlF0WklHMTRG?=
 =?utf-8?B?NTQ2bERSTkthNFRwUmUwaUVEZ3JFRXZQSGhhR0R3V0pONy95NUlYUXVxTU8w?=
 =?utf-8?B?U01xMGROWnhtVWRBa1EwL1VWV3grWHQ4UkJ2Vmx2U3BpR2hmVEJsSXVjb1U5?=
 =?utf-8?B?UFBqU05Ea1oxT3NKck9pM1RYa09KUHc5WFQyNzV4aDdzMUpVS29zMlNJM1Nk?=
 =?utf-8?B?R1g1OCtqSWpYa29VRytGanlHQVpTeFY0dmZ6YkdEMTNWTmFQdG14ZDRHWWFy?=
 =?utf-8?B?Wm5aL2FZVlpaSTgzSTdWTFYvVjlselJSdnF6a21BbTlyU0hnbGVSMFl0YVZQ?=
 =?utf-8?B?OUduNW5mUUdiYWpXTEZmczdzTmdVRXE4TFV3T1duVDk3SnVMVWJNKzhwMm9v?=
 =?utf-8?B?cHZVUEcxSCs5UzYxcXlkNjNEWTl1c3JudURoS3ZscDJIc0RBUXBsRnEvelEw?=
 =?utf-8?B?S3lSQ01HNFNvUGpkbnF1YjZ5MzNNaGl4b1hhbVRnejRqQitSVGY2c2FRNTBj?=
 =?utf-8?B?QjdwUlZTa2FJNTNIaWFqSDVxRzJ5YVBydFFFUXAwSXZlZlM4aVRKR1dZY0pE?=
 =?utf-8?B?RTB2YzFrby9WbnNVWGp2NjBzSDJ3RGo1c2J3UmhiZTNBY0gxT3pLeklmeEk4?=
 =?utf-8?B?VTZWaHVyYUpGcmdRY3RPajl4Qk91YVFXM3NQdCsvdW1JQnFPOUxwZU1XL2R5?=
 =?utf-8?B?NzAzYzM2WmRERnBmV0g0SGdNQXhHSkdOMDJFRjMxQksrNTdtRTNGckRiS1RW?=
 =?utf-8?B?OFdKK1hhNXlHbWZxR0VLY0pSWjVIZTdnanpYamJMM0VmQVJraDk4U2xaY3FL?=
 =?utf-8?B?cEE3QkcvL1VXb1J2YnlaTC9zaDg2OXhyb2RhTHg0a3oxWllRYVdqbm5RVVQr?=
 =?utf-8?B?WEdYOVM1bjBPbjdNc2lRR2tKUm9tZFdkZnJWZjIwVkk5RTZhU2wzTkxCRjZn?=
 =?utf-8?B?aVV0dWpGNTNXSWxhU01icFBPTElnSk5HQ2J0NmhENGR0VlVCR3QyMnVEaFBq?=
 =?utf-8?B?YU13OVhmL3lmdDJPdlFoRTcrV2Z2b0N4WHM5Zk5zR1YwT3Zub0FpZjJrSy9H?=
 =?utf-8?B?SzBJRGt0Y29LZWtRN25GWC9MNkQzYXcwNlRBY1lWcTJrMENvbS9mdjFoKzlP?=
 =?utf-8?B?TWpwWXprSXgzM2pjVUMzcVBYSlhpUFRZU2FCTFNCNlFYMEJNUkJCTCtubEFV?=
 =?utf-8?B?cEUxeUpKcGxpcGloek5vNDNPM3FwS0lEY2t4aWx0RENJMW02T2ZIVWFFZ1Js?=
 =?utf-8?B?d2ptSE1PREM5OXlHaEJJRFlmQWdIU0p5UzZCV0d5Mk5sVG5iRG1oRnRPUFd6?=
 =?utf-8?B?ZXJFTzUyaHBxSmlEMEEvYXhrT3VPeEFSd1lJeFdoYmZYZjNLbGF2WWxRamp5?=
 =?utf-8?B?YldjRzl6bU9MTHFjdDJ2S2VVMjFiQmcxbW9yeWpleDhtL1pGNisxY25PeWRQ?=
 =?utf-8?B?ZzlvRC9KZTIraWZJSExVRHNSckRnYnV3YVU5TmhMVVVkbXYya1BnRm5tRTV1?=
 =?utf-8?B?OTd5YUFuTjRFLzlJTjhyTWJJbTF6Q2FKTXB2eFI3SkhlVFdjYWxpZWt0OC8v?=
 =?utf-8?B?WW90Qm5tY2tMZjRUbmx0bzVoUE42L0JCeng5dklWNWlRd2pBcW1vYVlyZ0VC?=
 =?utf-8?B?ZDJhMkp1c3lxdEY3SVJwbHNsNTJnczhhOFJWRjdrc2Rabk9lZFBRb2luOXFh?=
 =?utf-8?B?WHYvR2xwUVVoWTlUNmRSc2twNkRtUURSSFZMY3RqbTdPSzJPbUM3VFhsT0hK?=
 =?utf-8?B?SFZUNWVlVnRsZXQyRHQwOHk3MGMzbzAvc3hvdVE0SThUbS9yUVMrc3JodUo1?=
 =?utf-8?B?NVBLNVVtTE5rL1JYaHRXSGxkdVQ4UkRTQ2RzVFFOaGRycDVuL3E0NFltbjRi?=
 =?utf-8?B?MWJ4TEVYdHJpWGlDU1R5UkJNTU9UbnNUKzliRDF6bkg4SzZ4dXNETGJvYlRO?=
 =?utf-8?B?bk9HWUJadDZ2blRaaWFRNWNEalk5cUdQY0RxMzNtS3IvOWE2QWRRdFl0UDkw?=
 =?utf-8?B?SUN0eHljZlFqR3R2UkIvR282YTRGYlJTY2s2MjNiZ2grZWgvSUFZblBiek8z?=
 =?utf-8?B?cmFZdXhpaUlqd3RsV1hQSmZPU3JvcGZGOW5ORk5OdFVnR1czQ3k1M0F6MVdF?=
 =?utf-8?B?TmlwZmFacElERlQ5R3o3eDlzWFR6QkRnRFR3NlZyeXQ0a2E1Qmk3QXdZeEp2?=
 =?utf-8?B?YlhzSUliZHRzSTg2Wjhtak8xUS95TW1INnNJVDFDQ0VnWVVLVXFyc1ozQ1Rv?=
 =?utf-8?B?aWZIb1dsU2dzN1dkMWw1UUhZcWhYbWJpcmpRWWF2UG9ocDV4bklleTlnUnZ4?=
 =?utf-8?B?UFMwNVNTOExiWjVnSEZTNnJjZStWQWtxaDAzbkhrbXllWDRDQlh4Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b731d25a-5f10-431b-7abf-08de6871a724
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 06:57:28.0213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p44gwa5vUqnEGPw2Wao8/B4MbrXRl7N5WEyTn+OcjyCFHjixTnqcH1fLjM6GM9jPi19Fg752IiD4hwONqDfRBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7455
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

commit 0535e46d55d ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c"),
causes i.MX9 SCMI based platforms boot failure.
SPL panic in fdt_check_node_offset_()->fdt_next_tag(), because offset is -1
and SPL_OF_LIBFDT_ASSUME_MASK is 0xFF.

fdt_check_node_offset_()
       |->fdt_next_tag()
             |->tagp = fdt_offset_ptr(fdt, offset, FDT_TAGSIZE);  #tagp is NULL
	            |->tag = fdt32_to_cpu(*tagp);                 #panic here

In [1], Ye report the issue, but per Tom:
"In SPL we must assume a perfect device tree has been passed to us, both
for design reasons (it's not a user interactively, we built it, or it
came from some other firmware stack) as well as practical (performing
the sanity tests would grow all platforms by several kilobytes and
overflow size constraints). I think the SCMI code needs to be reworked,
in short"

So we need to add a check in scmi transport driver, also need to 
add a check in dev_power_domain_ctrl and iommu. Similar to the check in
pinctrl_select_state and the check before call into clk_set_defaults,
if ofnode is not valid, directly bypass. With this change, we could
still keep SPL_OF_LIBFDT_ASSUME_MASK as 0xFF.

https://lore.kernel.org/u-boot/20260207141750.GB2603314@bill-the-cat/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      firmware: scmi: Validate device tree node before setup channel
      power: domain: Validate device tree node in dev_power_domain_ctrl
      iommu: Validate device tree node in dev_iommu_enable

 drivers/firmware/scmi/mailbox_agent.c      | 2 +-
 drivers/firmware/scmi/optee_agent.c        | 3 ++-
 drivers/iommu/iommu-uclass.c               | 3 +++
 drivers/power/domain/power-domain-uclass.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)
---
base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
change-id: 20260210-scmi-fix-8f8ae5f6abce

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

