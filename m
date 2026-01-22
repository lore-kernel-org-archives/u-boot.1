Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DD0C44508
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 01:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 626E583AEE;
	Thu, 22 Jan 2026 02:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WMtlwP4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2421983AC5; Thu, 22 Jan 2026 02:34:00 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F3780077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 02:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqdzQbNX8n0xYaJIdbTJYtAClOQxl9V4kVf8a7H1NXFCT6BZLRO3T4pWLHKLf7jqdCNc4haaocb02f12ELgJ7SAGrUw9eXWyzAmM7F9hu2Ui45MoSWc/aLoQEXVwCkmAFK9W2bj6wTpV/XRtZGOA2DCgB6moYvOdBN/j2VLFcawnQPmcr/d8qsoQRP6stXZwDtoSrI74QJ3WUFatynC1dlTua8y1bsmSLYbxYotk7eHCTUfCcXwNyVQn/Tqh/LdoyycWp8cxF36/SULBcp5B4DUjhfGXdJzRlStJJw747qDJJ8zzJ5B6oik54Iq00LCpdtpW51cdQu5Ck4wfhRYxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CR+NEGQAFSUzMR5kyojdhw6auuxEeTfQFAUwibgesk=;
 b=ItPkZtdJyJYqOTwCIl6Sw60YN94NUYQ2ijRQHYgA8SAglfWmKR6D4FudNCpPypZMEeJuGJCuE4WTVA89gpB4AkIcqviIlLUhcQs7V67UyUZ6vzoRyMqi486BYfzgOuCgkm6vqnTcNeBYwTa0hCUVf3nttJ5NGh3vNAFgwamOgVXeUqurwAA+FlrD+KHdDLnSg7navinNLJ6WMlYOImS3cdl8czkVrxShLLVQ1hf4k22eptY6AVelXM96/LeK1twRhgCIPJFQfCHYc/gsgGvreW06Cgrp4mB/8RMHFtVgXmLs2qnxb4jcJw8f8J4rIjZaX74dyUu8miFiR+dwZf0Lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CR+NEGQAFSUzMR5kyojdhw6auuxEeTfQFAUwibgesk=;
 b=WMtlwP4ujj68LPkypKOt/QTfpFpUC/9WCMKgTboqDVFuYD06HMQ4kGXrY9vgLriKATwHpm+HFnHUhgGQagHnnqVNjwZkGBYLLFxW1SWupFbX8vGCtx7rZKlby/XpkvwC5Dr3CzPKNYSAs5Yu9CkDqFVFgnbJa5+53BZLPsYtY19tkn7v3yndu0FLe910FAY/v8S6B4cAP4LtikH3GSFd3EG1YGozPMAspaJZWlSHccw/G3Dq2bp33VfN4qfDCgSFUjePagoul5/RmEH8TQrsjOvqGPVgwIRavAKEFmDDJTSHzI664djI1/F3Z/HUz6I91oqw2uqjZoiwqTAbdGafWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 01:33:54 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9499.002; Thu, 22 Jan 2026
 01:33:54 +0000
Message-ID: <ae96d38e-4e50-48cd-8c2f-71cc359bcbf0@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:33:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] imx93_qsb: Enable AHAB_BOOT by default
To: niko.mauno@vaisala.com, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, uboot-imx@nxp.com, vesa.jaaskelainen@vaisala.com
References: <20260121163358.21322-1-niko.mauno@vaisala.com>
 <20260121163358.21322-2-niko.mauno@vaisala.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260121163358.21322-2-niko.mauno@vaisala.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 3530a689-e9d2-42fb-9c5e-08de59564df7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|19092799006|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDl4UTVtMEVKTms5cUVOMXM5SzNyV1lEU1lEZTVqbjZpbjE5TDhteGswS2cw?=
 =?utf-8?B?am5yM0NsQmNNc1lJbkJoR05BWi9TZnZ3Z1BXMWF5L2ppYkJFaG9mZnhhcmFW?=
 =?utf-8?B?N2gvT1BVUk0rMzFBR3pUTVBIT1pKV0F3b0s2MjdoVzJrb3BRTyt5c1prR2Nq?=
 =?utf-8?B?SEl0NCt4dE5xbWkxSWtwS2hDR3pmT0U5N0drSnVEUGtGc2NYTGNxN2t5L0Fs?=
 =?utf-8?B?VHd0TmJVZTdRcS9sZ25teTQ4Wk9YTWdIYWM1R1dFNVg3amg5bExxbCtIajV3?=
 =?utf-8?B?NGxFTFBRaHFIRFQ3TzdqVmp0cjBCY1lLUzlUTFJkZWdxQmQrd242eU4rTWdy?=
 =?utf-8?B?cmZGT242eTZDWGNNMkUzelhabkMvSFYvYmVEeG9yeUNwMGlQNUl0K2RrNHRZ?=
 =?utf-8?B?cGI1bWwveTRJWDdiYkNiQTFSd3VLVUZ3WmFFOXhBV0QyUEQxdE4zcUZraFFu?=
 =?utf-8?B?d1lRVHBZZG9DNy9FMkIzRWJrMFhBUkRYTndoVHJTcDJTbHNvaS9YOUxHdjlo?=
 =?utf-8?B?OURscjRYZHpTZGRib1JIekVpZXlsdDhMZExZRkVTZ0QvUHFEaExsUUR1cjVu?=
 =?utf-8?B?K3RoM2ZmYzc2QU9JTndkWnJ1akUreS9UVW9lczBlT2tLNnhXczhWelB5enN5?=
 =?utf-8?B?V0pxSm9qK3RSUjNkRHNReW8rWHB0Y0s0TkJJaVRvOXp6L2MyMnNxQS8ybmpF?=
 =?utf-8?B?TWhMRHZVcTl1RGRDTUVZQVY2RHM5WDZTMVB3bnN3SFp4cVBJWGpRNUY2U3Iw?=
 =?utf-8?B?K1RseUFTbHVvL2ZRNnE2WW1laXZ2elN5bFZySVNSVXd4VzZrMkNlNzUxNHBR?=
 =?utf-8?B?anNLVjk4bThxRGpXUDNnM05ZU0F3djNPTVdPZnhuK0owTTIyQnJvNDVJUysz?=
 =?utf-8?B?SzltOVUwNGY4QW5hME14L3RKQnlhc3hIQWsxM0Q0aDRMTWFaQUFYUHRjcnBx?=
 =?utf-8?B?TWlGa1JJRVNhZEJzNG9MWHhNWkdxRW45elFua29CNVFobWt1NzNyWERtWTZ1?=
 =?utf-8?B?UjdHaWV5ODVxeHFIM0F1V3gzbk1ic2FqNVVNMU5mVk44d0dRVTUzWGlaZm5L?=
 =?utf-8?B?Qm9mRnhZa215a05yR3k0eW01VHF0Zkl3Y3QvN0FGeU1uSGFGdTZIL3U0L1o0?=
 =?utf-8?B?VlZQcFM5MHFUeUpPNGkwbDQydE55VlBiNW5yU0M2TEY5Q3R2SEZacXZGbG1u?=
 =?utf-8?B?Rm5rWXFTVXRDcWRjWmJyUDBXVCtVUHpSRTBMTlE2THVGQXNLbHNMNVF3MEZ4?=
 =?utf-8?B?bFIveTdsZzNxTjRsbjJ4bWNSTDZXS1RZZjYvWUVLNWRCUTkrODVScjF2V2NR?=
 =?utf-8?B?S01GcG8zZkd6ckhVRVl5T3JhbTVlenVLOEpuZVZKOWxmdzMzdVYrb3VPS0Fs?=
 =?utf-8?B?MzZ3dm9tc3lHQUU1aURGaUdYWW5hdTVQUEVIRnZWUEhJQms5SGl6YTlyNWtX?=
 =?utf-8?B?WnJiaGVVNW1DTFZSR0h5amY5ME9DSTNZZHAvUi9zMHhJOUlHQUhpNTNmeCtm?=
 =?utf-8?B?dUtIck10MXpnN2MvSS9tT2d1OWtwZklKWFVmZzRjZDZ6dVliM1lsVW8rcjZs?=
 =?utf-8?B?RjdyWi9DaG8yUUJoYmRGeXliaWk3UTZKbEFNSDJjeExObGRLN1J0S0lUTWNX?=
 =?utf-8?B?cTFoNWtNbWpXQ2RySzJiMmRIR2JFajhXTzRtMUJCenJFZnNxajRXbGVJdWxI?=
 =?utf-8?B?K0NhaFZObFJ3SEVoaGYzcGRNMmI3NEhKTHhWZHVXMUJOMm56MnhEdDNLOE1B?=
 =?utf-8?B?ODkwOWRmTjJGN1ZaVXhBMXJDd1EweGdkaWlaUUcweTdXOWpaYUtKNmJORytC?=
 =?utf-8?B?R0ZUT3h2SGhjVkhHL29TYUZTVE9LUUg1S05UZWdVR1p4SjJJUjVjTEdlS0Fy?=
 =?utf-8?B?OG9rNktZSGtEQXNvRjVteHZvZS9JSkdPVmhOMnhiTFFFazBUdDJ4c2svVGVL?=
 =?utf-8?B?UHNwNWcxNndZT2dZY2VqZU1aNWhSWTlPUmdzMGRKbEV4aTc4b3E1UW9LZ29J?=
 =?utf-8?B?RlhlZXI3dmMvdUhyY3JFQU5YWVo3U3dpVU0rWWt4dmhmU2J4bGRkWitZaWxC?=
 =?utf-8?B?SlNiaUVTNHYvWkUrc21zY0dJZllCK0hBWmpaTHpCRnZpSTZBVUxyeGRvS0x3?=
 =?utf-8?Q?FfsI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(19092799006)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1oyaUZ0cUk3aGgxemhjbjE0OEpEZ1hLTlo3c2xWVkZReURIMkMwa3I1NGR2?=
 =?utf-8?B?K3BqangvRW9WbXRFeTlqMDVrS1dvT1c1UG5vS1VqTFlwOWNMYk5uYlhuZ3cy?=
 =?utf-8?B?MmhRUVVMSkFudmZXdyt4N1NXb1dMWmJ6UW9oLzZwNHBDTEJRUzU1SDBFYlYv?=
 =?utf-8?B?L0FhM01Ma1Fpc3NNaENzMVVpbU9uNlU0b25TTWNBZUlKWTVSVDF5ZFpSdWNj?=
 =?utf-8?B?ZzhXTWNsRHZJSHVXVnJzb2IvZ2dxZUI5cGtZQTNPelZKTlBmRVVUUU9BeU5j?=
 =?utf-8?B?SG11SzZqVFVPV1hnSXpjN3E1a2FLRmZ1OEM5dm1lWHFBekF2UzRIcWlYRHhv?=
 =?utf-8?B?bTRjZ2RucjRYbGczOG9DeUNML2xCRlRQWnY4dU02c0Q4SG9ySXIrbkFuTXV3?=
 =?utf-8?B?blNValh4aU12eFRWU2ZUeFV5WVU1Q3FkRUJNUk5Gd3hJTTZnSmRmNEVtcGdZ?=
 =?utf-8?B?czQ0UUg4L3FGaHk5RzEwQzdBZ2tmTGE2NThSMkFxVVlWR0hucDd5Yks4YWNM?=
 =?utf-8?B?R0dnTkhaTjNxQm9ERGpGNzJTTGdzTTFRMW4vVlA0Q0VjT0syV21GbnI2QzNI?=
 =?utf-8?B?clpJNmhpR2VVT2xGa2F5Y3dEQ2xiRkdFajZ2TEk0RDZEVUMvTW5GejBhbnlH?=
 =?utf-8?B?NGIzZnRJSXRKSXhmZUhtczJXcVlDUnhZSmRMdGQwN1BXaHAyR0JHS3E5eGxE?=
 =?utf-8?B?QTcvdyswRmRGVXhhallERzE2MmhqVUNuTVBUQVN4YXNuTU5LRWltR3Jhc1Fh?=
 =?utf-8?B?bkljTUJBdzZiYlhvOXV2M29od0VRUm43eXk1WWFBZjdBOUt4Y3paUkhpdUpT?=
 =?utf-8?B?UzB1ZENZY0dvSklkRVNCMDFBOFNSNWpYZ2dTY2JJRHFzb1FCbjBpbEJKY2dW?=
 =?utf-8?B?S0lQaVFmYi9PcWhVckVmTlluYjBKYU1Pc1pSWlFCR1dGdGtiVEd4SWJueSt3?=
 =?utf-8?B?L0Y5dWpLbVJPdWxRYTA2TXI4Q3BCQitGOGZndXVpQXRjc1RnaU1VUHdVWC90?=
 =?utf-8?B?NnY0dVhXUldiUGl4S0FSTE9EQk15NmltMVhrbk9WaDNwclVZMXZjKzJyZVQ3?=
 =?utf-8?B?RkZoZit4QmJuWmlxcjdmUWdYTW5JSzVGcVVxU3dhQzB3WDFkdmw3UXBGOTMy?=
 =?utf-8?B?d2NmMTlDSWxwck9KNUpBaVk3K1h6THBPTDVGQVR3UXJGOFkwQVBweEVzUkFX?=
 =?utf-8?B?SFhsb3F3TmVNbm1COVYxeTJkQ1dZYTRuU1AzRys2Q0hvM2xPSTVXem14bFBE?=
 =?utf-8?B?Mnc0MjZtL0tIak1NcjhUcStNRWVyUnMrNFZVcU9keWhydk01RHprUkduWThz?=
 =?utf-8?B?aDdoVWtQQ05VczRib2hLdm8wWWJQOThzdUxZZllDb2Ezdnh2bGxMZEJCcHZK?=
 =?utf-8?B?eStBUlRFNEM5NERXQU9XTVF2TnJaWGdEZ0cvdVhvMXFwYTYxcEd5Q0lzcWg5?=
 =?utf-8?B?RFA1bG1NYTdZZzhuSmhsMVgzVnNhOTNoYWpvU25XelZaVC9qVk4zMlBYaUpH?=
 =?utf-8?B?MVJNejlGRGs3NUZVcHpFWi9jNjlGMFZmM1VkTm9uM3d5dlBXeDNpZC91Wk5l?=
 =?utf-8?B?UERjYlFWZlUwcTRrUVRmK0hUNVIwQVROTEltM0dHalVHMTV6TzRhTjNlQWph?=
 =?utf-8?B?aTRLQ3B1eGdCWU5SdmR0bnpsVkVLek9SMlBHZWU3dThFRGl1QWs3WkY2Szha?=
 =?utf-8?B?TWE1NWdYakhhVm9yNWlab084My9odWIveWluWFZDa1VpV0JXUUhlc3pjelFH?=
 =?utf-8?B?TzErcUhKUXR3Vi9iY2d5SUdjZ2ZqM2tiK2g3YWVqNUJYbDkzRmR1eEc5VDV6?=
 =?utf-8?B?VEV5UG1SdlJOblNxVVpGbk5tMGhxdDlUNVdPUlVtWFlydWQ2Sy9xWDlyMXJN?=
 =?utf-8?B?VFMyL1dLZkZsYWpvNFI1MkRBUGZ5TGFITHF0R0MxNjVWU25kS09xVEtGL2d3?=
 =?utf-8?B?OVNaUm1Ua0laNWtHek5MOXpvdStRZmJGNFZFZ2dRVEJsL01wYm9PcW9vK2JG?=
 =?utf-8?B?ck8wQTJHY1hKK0I4ZkIxUGJyQlM5Z1dwZ2FLN0JOTGVnUzZqUUcyU212Vitr?=
 =?utf-8?B?dE0vKzJ3SXZNMDZMY0xSY2xJaldTYktNVG4vU1Z4WEx1UDN5U2xTcy9ucCtq?=
 =?utf-8?B?Z3ZjdWV0aTdTTTZpbUVZVmQ1L1NIL3VoT0srQjljV2VScm14dGRNY0RwNU1q?=
 =?utf-8?B?WUdUcE1zcjBidmhMTUtWdEJOcTlCd1RtejFIdUE2RGt2S1hoK09JbExrRTVF?=
 =?utf-8?B?YkhoVWRyQVdDd2tPdVNNNGN1QnViblpheGpOTjIwWXZTUjJ5TVpFcHByS29u?=
 =?utf-8?B?QnZiL1pQQ0ZYRmZoRVgwV2dHQ2xNL1Fwby9ya3hSWXNDZk0rT3IyQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3530a689-e9d2-42fb-9c5e-08de59564df7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:33:54.6723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYTe2WU9+GZfOpVwzEvKaPY/KijA7YaYFjZRLKtMqrvw0h6weDRfyM/J0I4ZGP/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
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



On 1/22/2026 12:33 AM, niko.mauno@vaisala.com wrote:
> [Some people who received this message don't often get email from niko.mauno@vaisala.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Niko Mauno <niko.mauno@vaisala.com>
> 
> Enable the support for AHAB secure boot.
> 
> With this change, one can issue 'ahab_status' from U-Boot command line,
> and see e.g. following kind of output:
> 
>    Lifecycle: 0x00000008, OEM Open
> 
>        0x0287eed6
>        IPC = MU APD (0x2)
>        CMD = ELE_OEM_CNTN_AUTH_REQ (0x87)
>        IND = ELE_NO_AUTHENTICATION_FAILURE_IND (0xEE)
>        STA = ELE_SUCCESS_IND (0xD6)
> 
I don't agree to enable CONFIG_AHAB_BOOT by default. It is only for 
secure product for OEM closed LC and secure boot development in open.

Best regards,
Ye Li> Suggested-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
> Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
> ---
>   configs/imx93_9x9_qsb_defconfig            | 1 +
>   configs/imx93_9x9_qsb_inline_ecc_defconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/imx93_9x9_qsb_defconfig b/configs/imx93_9x9_qsb_defconfig
> index 7772cc4ed11..913eb821249 100644
> --- a/configs/imx93_9x9_qsb_defconfig
> +++ b/configs/imx93_9x9_qsb_defconfig
> @@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x700000
>   CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-9x9-qsb"
> +CONFIG_AHAB_BOOT=y
>   CONFIG_TARGET_IMX93_9X9_QSB=y
>   CONFIG_SYS_MONITOR_LEN=524288
>   CONFIG_SPL_SYS_MALLOC_F_LEN=0x18000
> diff --git a/configs/imx93_9x9_qsb_inline_ecc_defconfig b/configs/imx93_9x9_qsb_inline_ecc_defconfig
> index efa0bbd92ad..3e954a491fc 100644
> --- a/configs/imx93_9x9_qsb_inline_ecc_defconfig
> +++ b/configs/imx93_9x9_qsb_inline_ecc_defconfig
> @@ -12,6 +12,7 @@ CONFIG_ENV_OFFSET=0x700000
>   CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>   CONFIG_DM_GPIO=y
>   CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-9x9-qsb"
> +CONFIG_AHAB_BOOT=y
>   CONFIG_TARGET_IMX93_9X9_QSB=y
>   CONFIG_SYS_MONITOR_LEN=524288
>   CONFIG_SPL_SYS_MALLOC_F_LEN=0x18000
> --
> 2.47.3
> 

