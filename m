Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCC5D25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 08:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C444283F9D;
	Tue, 27 Jan 2026 09:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OIM7fdkZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B6B83FC0; Tue, 27 Jan 2026 09:05:37 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19A983F53
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 09:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZqOJ640MS78GiZ7T0WAKsbHxGMsuaZFGLFZ92tqrbZ+045bKlf7xlONgrSC931HuodhXZ2Y8nZC8Ms+XOccQuZ4C7lcY8s2Th9S41d72AEmE9IJYco2tdgvSXIpsdVYLekBGtrMwLa6b6Y7q+OFWWGN+8hO92voMXg4LtK4DLZN5qi8P42W9UnNSztfB5LJH8keF1ySxf4JJkPEQbPNHrBMo5weRtwVNuVPDQQqfGhfW2+B4DQ/9wQujcCx7Pg3dUHiZQLviC+Oz1rMIyrsFveHHWP49bH+fgnrd6Qxqi6vz57sBItpbSBrxdPBFKqUB1KSBb/wgVsJHmmUvc1jAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3tsCNE/EjlcBKDvUtEPGJr6tAUnDrPxQcsaIpG4WT8=;
 b=rUzrusaF6Kt5cmv5D7V34Czw8/RzI8qY3Cjo64YLyzOnzQlgC4UJJdalPfSbwF13cnhB4VE9L/CPNkF6YB8SSaVBZ0IklZIt5iLZzHuEt+vCSS8oPz2kM3oleqoBTzvQAUlwKO2n2NakzCD3Mm7A37Bxc75Iuw05lwhjW0KhVay9sEvIrRpFclQRjmloTbZv91pMjOk5ccy2z6wz2DOUCX3L3CNHay7CBHcPo4UciVK70mKJ6VBF+X4LwoF+Z9YzKgv8cUd99mJBPlX6xki+FUMl0d7xqIr9LtI8eoeK0SNtNbkkEcyIufcC9uo/o5WNcS0ZKjqKO0OE67a3mbs2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3tsCNE/EjlcBKDvUtEPGJr6tAUnDrPxQcsaIpG4WT8=;
 b=OIM7fdkZRG6eq6XhZ7p9tHzfO8IK+GHZTbjr+vZkDVxEc9KiQ+go4HPqaN4Pka9jpaL2d+29rN6ZBUSVJTCmpJ53hnat+tv7jFgpjqPsjDr6UpHtZlsAZhcP0I/IQ5n3T5XGuXNH0zon9aOCCAlrwwDflxHBxD7YyZIIrV+XOvkTCBf2hxLztkZlrjK6z3PVgXI6IYlurNy/ydxHIRKL5oXONBecBtjUBPwwV+ac2lb7tOIS+CWhpyrgNtNttSIYV13s96838tAEsSQyqL9VVapDvKhKTH5zFFR4czcO8YUbJ6+INn5IV4Iv928I1IoHU0c+8bpoi/YdRp5aDgmw5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB5168.namprd03.prod.outlook.com (2603:10b6:208:1ec::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 08:05:30 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 08:05:30 +0000
Message-ID: <3c8e098b-ed24-4bd3-8065-eb1982ef9068@altera.com>
Date: Tue, 27 Jan 2026 16:05:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] ddr: altera: arria10: Add DRAM size checking
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-5-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216084623.19589-5-alif.zakuan.yuslaimi@altera.com>
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: 842a8a32-7e6c-4823-787e-08de5d7ad678
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUdmbXprNW5PM3ZTYVdGcGVQb01KdWpBZGNlQmFQZVBPaWJXcHdwUEVUSjE1?=
 =?utf-8?B?MDE0UmVKRytBOFFpcGpDcm9QYjQvWE9jdUpqQUtkMXNSMEhHZ0FOTnJzMDJT?=
 =?utf-8?B?ZTFQaytBZ1VTVGxZS1Z6RTh4eFJ5bGNMOGRvU0J0V283VDZBZmJva2NQUDZn?=
 =?utf-8?B?dEI5bmpQT0hpalFKYnprS0VzQzhFaUxZYnZGaFVtRExrMm1TVTBJeFNSamJY?=
 =?utf-8?B?L3RkVmh3Q0tZWnVBUWkvMFJrdVJUM1pYKzk0NWtRajZPSVN6WGVObDhsRWlu?=
 =?utf-8?B?Q2pIREFyempROWNKb0x1VVRvWUx5STE2alVlSHhCU3ltMDdFOTJ6T3RtSWd6?=
 =?utf-8?B?dU5aZmJBUXp5bzA3MEVpbTJnUUdiNDFkNktndlpqR3FkcVY0Tk5kVkdlVk91?=
 =?utf-8?B?b25wK2thMGZ1cUwrOGVZNDQvOUxVMlJPZTJDRjRiK1NqVVNQVlRtYzJoU3Ru?=
 =?utf-8?B?ZHpQY0pHaTdKK00rR3paVEhUMWdCY0FON2tncnd6T0pOUUZHVHVSWW5hQm94?=
 =?utf-8?B?dW5xNHR2RUN3Q25IeHpqVFgwQnJpV2E4Nkg2MzM3SU5WRTRjblR6YTZXaDho?=
 =?utf-8?B?YmVnZDdWeEIxbUNtcWxjYy9aRzlPT3dOUEhpb1UweFYzc1Q1UHA0b0t2czdZ?=
 =?utf-8?B?WlJISUV6ZGRkWHBVSFdBNWl3Nm80bGliT2RTSXJLa3FGTGxCU1IwRVFZakMv?=
 =?utf-8?B?TEp5WWJpcEgzV1RhZjFncjI2UjRKeWo4LzFQMzJEZE9LUzNtdVVmVUppSmpz?=
 =?utf-8?B?N2VzWlp5SjZ1MnhOR2Uxc1dTNDNhMEFrTU56S2FMendGb1YzV2EvZnZJUmla?=
 =?utf-8?B?YnFxZWhYd3Bud2JTMkVzSkNKN0FjMUhTYnVuTlNwTmNKSnoxaWhJK3UzVWlJ?=
 =?utf-8?B?UnNNWjFpRDNqV1RqZFU5eTVGY1pkaTEyUCsvQnZKLytscEF2ekJuUEx2bFBK?=
 =?utf-8?B?SnN5TE1rY2tLdHg0dmNwb3lyR25BZkZoc28zTnlVZWYvdE9ENk15Wit6dk9F?=
 =?utf-8?B?RmNtK0pRd3JMc2p2eXJrRmZ0Z0hrY01xajZ4NjZBandQOGFYQVY0SkVGUDZY?=
 =?utf-8?B?ZHU4WGlKMHJCdlZEQjVVVUV5czBJQ2N5N1pkTmFLSFhhRFBXWkR6c29JVGpY?=
 =?utf-8?B?QlVXS2ZpOXJmMDFnSmd3M3NYcWtGYTIwTGorWnUrL2I4OXFPcHFjd1hNQkI0?=
 =?utf-8?B?RnI2dUxYa0w4SG5MS212VmpqZGJCaEcwWDBSSVF6QWc2c2x2a2FBdXNucW1C?=
 =?utf-8?B?RnlrK0pjU3hsL1dTMnlpeTRYYnNvcEZFREVSWnZSUU8ySTRtQWFyVGFOdU9Z?=
 =?utf-8?B?SzRvSk53YkJ2MkVldlprUUJzT29TKzJub21BZmFMNDlkYjJYUHJ0cWZUcjRr?=
 =?utf-8?B?eE9KL2pFT3JCeXFIR05idmFlSG43MXlvbHgxLzM5QzcybElERHYxbmN4bnBG?=
 =?utf-8?B?blRlWE5YSGxqeVZtVjZGTkozYnNKWHpCZnF5MUp0U0thcXFWYmdxV2dvNjN2?=
 =?utf-8?B?dFR4aUVSTjhEbjV1WDNJT0VTcUxma2c4TkhNU1hhcjBVRjVFc3ZvVFBsYThB?=
 =?utf-8?B?c2Ntblc2OW1Vb2NiTGFOVlNRUEw3N1MzUlpVcU5rak5QZ3lPNnY3eVhzaCtV?=
 =?utf-8?B?SnQ2dlhtUkZLRi9OVmErK0R1Q1JIb3NqeE81T0l2dFlDdk1sVWxRd05LVnlG?=
 =?utf-8?B?bjlIc08vb05JU1JpZE5pUzF0TVA2OWx1a2g4U1Z1NGZQekFnQ2JLN1JNbHlz?=
 =?utf-8?B?b2lGRHBZeGIrU3F1eXFKOURudGhoQUExQzdzNFM5cGR4WDdwNGp2YlJkL0pj?=
 =?utf-8?B?b2hKSDJrUHQxbkJlbndVa3hjRGJQR2VyR2hsUDJZcndBLy9VMVRMZTc4YnBH?=
 =?utf-8?B?S2hEZ290OVY3c0hXejV5bzdUQTR0a3MxUFNSaHUzU0htVGVaVEtsSTRFNkk4?=
 =?utf-8?B?NjRFbGl3cGFBNGhDRVNyVnJXVHRQOE0zcDc2Qi9BMFJsNnh6SStSOVFMbmNT?=
 =?utf-8?B?eHpYWkVsYy9LSEtETnJidi9pazZMbXVSa0V4cWZNcjNkZ0txUE5HaUViSGNs?=
 =?utf-8?B?eHE4Zmx1L2JpdjRYU0cxdTc3NkZpTHNEeVZJbDJyeGRVNTh0dERjNSttOExv?=
 =?utf-8?Q?WWl8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3dUREVkN2E5dE95eSsyUy9SZ2JvcXdTNjZQMCtZaHNRUldHZnhOMVVlalJL?=
 =?utf-8?B?aXNhQkRleFN2VGZCRFZ6OGNQcEVicWpSVXYxQ1RyUGRUMi84M0FBSUJKTWh5?=
 =?utf-8?B?alEzeDRBUHhrRnVZV0FDMVZjMUcxY1VPeFRJc29wSFFzczVDTThmTUI5STRX?=
 =?utf-8?B?VmZIRDIzVXkwaVlISzFQWEVCWjA5QmcwQ3VqQVozbDdlN1pDSVM3dWIxc3J3?=
 =?utf-8?B?eU9IL1dFVDFOZVpDaTU3UWU3aUYvT2RqZE5HYndPNFFSd0x4Z0NoRW4xM1d0?=
 =?utf-8?B?YisvL1psM1hBSUI5S05ReVFRQ0xrK3RrbkJWcVlqOGZrWmUxaUgwK044ZzBS?=
 =?utf-8?B?NmNmZTgvVHlKc0ZoZGhlY1hzSXgxTWozaTB2UTlxSlZMN3EzempvUXBBL0Zz?=
 =?utf-8?B?NkVxaS8rNlpORER0ajJGemROMDdvR1FPTm9TNCtESkcwbTVGaXVlbER2Z0Fk?=
 =?utf-8?B?T1dhWHZoSVJzZWRwejVpS1hrSk9JcnJ2TnUzNHQzQ3dMNTUvRjNidU8xMHpQ?=
 =?utf-8?B?MnVrcGFRYXJyNDJNQXdVQ3lmTlI0Z3p5bzV1MTZvSEdVVHFsbjg0T1FhS1k3?=
 =?utf-8?B?STZ5eDU4ekVwTC9KODl6d3NrVHp2c2NyY3R0eHJqYTdPTUFob3Fqem1uaEJ0?=
 =?utf-8?B?NjNYNWo2Y3ByN2xiSFhCWDZjTm5hMVNQOTVnUDhueVNOeFowYUNKS0o0SUJa?=
 =?utf-8?B?KzlDRVQ1L2Z2aUxNQ3o0Rnh3U0RLWFcxeVByMVVvZU82Y2lMaXpWVVh6cDlp?=
 =?utf-8?B?TjdTc25aMUc0TmUyOVg3aTAxRFp1bXpJckVFbVpWWTRrcEhtTmx5cGhsd2kz?=
 =?utf-8?B?VzRBeFV0U3ZORHdNVGtZY1RPTURRc3BiUGNYNFFpeTlJaElsNVkwQVlVUHV6?=
 =?utf-8?B?Qzl4L3pGU3BzM094RFVnM1JkUnJWSG53N292WTExNkI4M0pTK25xYzVnSzJX?=
 =?utf-8?B?QWM0TzRURVVFaUZmM0ptU1RZMkkzR1V4NmIvQ1FxZ282R056UlRVbFZiRHZI?=
 =?utf-8?B?dUhGdHUwZGhNMS81UmxjTUQwSFpWM1lVaW15UGVtRlV0RUNPNU1RSW5najJZ?=
 =?utf-8?B?aXNOZDd6WnRFdXVkQXI3OXZWY0VPdmhsZ3dMS29wUnRiTldWVzZtWkp1MlNF?=
 =?utf-8?B?STZpd2h2VkplRTI5UDlHNXpQU3hpczRiRGw3MXl3V2pQUGRRN1pCZGh0TFhk?=
 =?utf-8?B?bVdtc0lCTmR2TlNKMzU5ZmxIdFZjMmQ4cXcvVGI3eWZMWlFrK21xTERZN05V?=
 =?utf-8?B?VTBvaEk1clNGb2dpNnpLeThvdE5zbHJmdmhlRW0vcHVUSThPWmtDRnJuaFRy?=
 =?utf-8?B?SzEwMFZGckNscy9xamYvbFM4aTZYcFZXa2w1VGJQTGV6aUY0SlFkMnhDVDdN?=
 =?utf-8?B?WUlWUDhpL0tERi9jYUJxcU1JVDlpbFNsT294akZFbElZRi9XZGJualI0Q25u?=
 =?utf-8?B?YTA3bnNwR2xNa1MxTERaMW1JK20rZ25jd3c5OEo3V1N6L2xUeUlEcWtrTEpY?=
 =?utf-8?B?N1dxeEZkeEFuRldHeDJKbFNRWENGVzVraG1XajM4Z0xPMHM2dlE0am1CSSt0?=
 =?utf-8?B?a2JMQkloMTFqTTBxZkZmNWVUejVCWmxsQndmUFdaWFNnS05UNHNMcDRncXMv?=
 =?utf-8?B?YWY5RU4wanM2N1FzMDE4MlNkajhPVVFBS25FZFFFblF0Rk1BMU5CVHFvZjdp?=
 =?utf-8?B?dThORFNOcmdkMUtvQ0NQaTVtWHROL0pJUlBDTWlDbVhxc2lwL09udk8venI1?=
 =?utf-8?B?UnVUNFR3bzgzVDdDZFRHWTJzYWVCRk1NZWhaOTRrSkw1TEROYzJHN3RzUUxQ?=
 =?utf-8?B?QlJ3bmFCSGk2ZkVmQXJDRi9GTFRVekJJaG04dTU1ZHZqSzhQSm0rbnZ0Yjh2?=
 =?utf-8?B?aEFNdnNDLzE0UHJQbkJxYkgzWkZaTmxqc2RwSWFPS25pMGpwc0x3MU5Jd3Vi?=
 =?utf-8?B?Zi9JSmlxZHFxcmRPaXpVUTZwN3pwQzc2eVZtTjJnSVNQMFFXa2hwVThnNDlN?=
 =?utf-8?B?S1BPUWp2Q0IvMGRNOFlFaW5TTHViVzF3RnJkcHRzYVU4cHNHODhMZzdaWTFZ?=
 =?utf-8?B?dE05QlJCOFloQmZQQUo1bGxFQUF5Q1h1WWMrREFkRklzdzJ3bXZIRE95RUVD?=
 =?utf-8?B?em9sWGVyTFpFeFc0SGFqTjREazJoYlQ1b1FxT1BlM3F4NzJYVDBFakVMbVpE?=
 =?utf-8?B?SjdRWjY3VkVZK2htVjBTNEVoeHYydzNNcURXbGhLN2t3RUJBMVp4RG9xV0VO?=
 =?utf-8?B?djNiY3RrbFBYUWJQS0p1c3YzQXEwRk01WTRPMWJwMXNVNUlkd3ZvaDdBdE84?=
 =?utf-8?B?M3FzQTdIOGpHRnYrVUVnazV6aVpYVUVhSkR4L0FLb0tEK2RJNnpKOUhrbUlQ?=
 =?utf-8?Q?d0lDktgGAUI4CF2s=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842a8a32-7e6c-4823-787e-08de5d7ad678
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:05:30.3987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f/PJxSzIfwArg5HHOxV6yJHm1m2qqst9QpsnX/l47k7XwCigFqfS27OfejjksmigyKD3TMMB8bY6kePlDl4UcCqXDZLFwUQuo3qB13Y9WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5168
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
>
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>
> Trigger hang if DRAM size from device tree is greater than actual hardware.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>
> Signed-off-by: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
> ---
>   drivers/ddr/altera/sdram_arria10.c | 32 ++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
> index 0e3a1d42f34..d75c464f42a 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -8,6 +8,7 @@
>   #include <fdtdec.h>
>   #include <init.h>
>   #include <log.h>
> +#include <hang.h>
>   #include <malloc.h>
>   #include <wait_bit.h>
>   #include <watchdog.h>
> @@ -654,6 +655,22 @@ static int of_sdram_firewall_setup(const void *blob)
>   	return 0;
>   }
>   
> +static void sdram_size_check(void)
> +{
> +	phys_size_t ram_check = 0;
> +
> +	debug("DDR: Running SDRAM size sanity check\n");
> +
> +	ram_check = get_ram_size((long *)gd->bd->bi_dram[0].start,
> +				 gd->bd->bi_dram[0].size);
> +	if (ram_check != gd->bd->bi_dram[0].size) {
> +		puts("DDR: SDRAM size check failed!\n");
> +		hang();
> +	}
> +
> +	debug("DDR: SDRAM size check passed!\n");
> +}
> +
>   int ddr_calibration_sequence(void)
>   {
>   	schedule();
> @@ -689,11 +706,26 @@ int ddr_calibration_sequence(void)
>   	/* setup the dram info within bd */
>   	dram_init_banksize();
>   
> +	if (gd->ram_size != gd->bd->bi_dram[0].size) {
> +		printf("DDR: Warning: DRAM size from device tree (%ld MiB)\n",
> +		       gd->bd->bi_dram[0].size >> 20);
> +		printf(" mismatch with hardware (%ld MiB).\n",
> +		       gd->ram_size >> 20);
> +	}
> +
> +	if (gd->bd->bi_dram[0].size > gd->ram_size) {
> +		printf("DDR: Error: DRAM size from device tree is greater\n");
> +		printf(" than hardware size.\n");
> +		hang();
> +	}
> +
>   	if (of_sdram_firewall_setup(gd->fdt_blob))
>   		puts("FW: Error Configuring Firewall\n");
>   
>   	if (sdram_is_ecc_enabled())
>   		sdram_init_ecc_bits();
>   
> +	sdram_size_check();
> +
>   	return 0;
>   }

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
