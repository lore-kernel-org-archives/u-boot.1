Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08A3CAC5B8
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:07:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522B7838FA;
	Fri, 26 Sep 2025 18:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X0LJ8Tkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 201A883666; Fri, 26 Sep 2025 16:54:46 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC65836AC
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdQjKXAcWoyB3dL9nyD3oEYTC1bBI5efGbcUfFjy4ljvCMufRqS70MIIjhWVkmO6ZLtRglJcz/uBqBqHyhPW0BI1qUmpqnsIrLd7NcqYn3rOme8PtJtD7YSIdvZLfjHCt2q0Lh5BKVwlRdzIn8wAaOvp3/fD+n265MhK5sjiX9yaKfxptDVYvPwhWrBu+xB9Lx5xzvUEQL0ahaulI13Bn2VowGVyRz6pRgDj7kDwrzEze6ZCOx0pyc8IUryFgQFc64mD/YNBjqD4KfTWCd1BKg0au7sWRtxdwWaryyXkUqmvTI7+S1L8acFS/lG7DVrH6gq8RH+OYmM5CBN4Uzv+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ei2byZQKr6RTe4RKA+5TVFO1AQU8go7hvrI9428Y1s=;
 b=mF3x8EaFovNsCzkfBSmlyX6IqTGU6SMihGHxr2gyQskLCNRquXDvwgUWuptgGzxJYWPrDGbzVspHad8w0bod951EYzE3mv8hXUHzCMofhO6gqr7Ec5DIBl5euFpWO1wR611OO7fW/aypWlufq0OPiF1cQ11ClGAJvlXCoehcRs+a9IbiHVdI4eCcyUqPJxxJabVzfBun1Xc92zqi5t0N2zdIdoOpfbp8PcMS+E5HOprCvpuXVaqSllsRozATvWOphPJ6IkQCcHzHcXRkuvUvv4HKTtNcKfFVISnGq1qGfcHQ79uR1tkOm7JadFIjrzTJgQHkMQhTCufXiovSCHzisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ei2byZQKr6RTe4RKA+5TVFO1AQU8go7hvrI9428Y1s=;
 b=X0LJ8TkmRNZJoLba8VYyD63ui929Zi96dA/J/kPtldcz7l+vrNkkV0XXB30CchLhm7mrzL+b264fJTHB3WYkd8xCXo9bHTVcvZg3/TcdZH5Q/FWAfOEcoSHgBCBZlUjo+m1xcHZsqjLeLotI0NYcWRfbDtndC4aKp0A7fPPIHVnvMi2JPftQqm55SfLgz0uFEvqV5wPoQcEuD/KozDYX4M0FDMip6nuqABhSt7Sz/rBuimQwzC7k2d629rPQdGdNrUdmqdMr5+oxAR5KHIksKGis3PO23lgYkFf/bDTyL2yMPhCdLxUOE1ANenoB1Y1MmYXkceEBRPtA/B1oU48OfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:20 +0800
Subject: [PATCH 07/10] firmware: scmi: mailbox: Support arm,max_rx_timeout_ms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-7-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: ea42223e-5f20-4b0f-9cd5-08ddfd0c9f16
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmlKbUUyWXpPUXhJV0grQ3dEcmNjbkhPUkgvcEozZ05QVWcvMU00cUx0c015?=
 =?utf-8?B?eE1TY0E1QSt2ZUEzZnZNSEJQdllUVGo5VFpEYmkxZERJTVdvWG5FbkYvY29l?=
 =?utf-8?B?WmNvVURZb0tEaTNXWDJzd09hVmN3YXhsc0hrMHdHSFY2aVNWNXlLVnFHWkQ3?=
 =?utf-8?B?RHpPWVdUaEhLeGhod0tSSWxiVFdPUFljTzZqaUtEQi9md1VjeHlSc1Btd0JR?=
 =?utf-8?B?cWJOK2Jwa3B6QytCblBXQnppc2hxalZ2YU1tNUJDU1BVL0NXQ0Q4YUFpRVZU?=
 =?utf-8?B?Mk02R0tuODdVRmhSRXg2dW91ZVMzdlJ4cU1TazlQbEV0VEJ6THpjQVZQWHhJ?=
 =?utf-8?B?RFNpejBGRnp4WGdCQkVXRldhYmxLVEIxZUVjeHR0dVFQNlIvQ09ZeXRadFdZ?=
 =?utf-8?B?NWxGUSs2dHBrbEZDcWVhUDZZSUlwUklmZy9sZndYamVkT0N2V1FJdldUSXZX?=
 =?utf-8?B?cmdCQkRTa0I3Tjk2MVc3RW5GTFIwNUhwN2NhRFJudzF3Qmd3SUtWT0hVMS8y?=
 =?utf-8?B?OUwxUE12ODA4SjFPSVh3U3ZRdnhhWmJzbjhqSnF0NUladW1rZDFVa0hXUElM?=
 =?utf-8?B?YUh4d0Z5dVlpTmVYbkIrODE0ZDBCR3JFWkJIUFhHdFRpK2hDL01KQlRadlRC?=
 =?utf-8?B?RUVDVUppME5kRlBNYldpRFh1WXp3UWZ1Tmxjc3V2bnlmbmNhR2VoaDdrVjli?=
 =?utf-8?B?WEVjWUhJcVI1R2JDT0l5SzdrQm00Z3Z2cVg4ajJONjhpYnpoU0srd1NIVXNx?=
 =?utf-8?B?Tmc3aUZkNDRpN0Q5bXprVG1SWkx0N0lTZkxLVlR2clRndTB1S0RJcmZMQjVw?=
 =?utf-8?B?cXQ4WmR3ZUtTUm1mWWVtVllIRm9FMTZjWXNKUDFCUUtkU2NkUFk1WHhGSXhC?=
 =?utf-8?B?Z2YzTS8vMVBMUFo3SVdGa3dzMkJxNnpkMU5GTnFPY3VkR3V6UlBKWEVUZUFN?=
 =?utf-8?B?d3F5K1crMnREL2hnbzFZTUJ3VEdLYVRCdFY4Rlc0aDlIRTRNU0w4NzIyeU9J?=
 =?utf-8?B?enNReGRMRWpLYjcxamFJUG1EZkFiaDF5eU1FUG1TSzFrRm5tYVd0eTBDSytE?=
 =?utf-8?B?bzB1NGdZV2x1T2YrTlEva1gvL2VPbHNuTVRDN2NFQ2xrb0tLTENZZCtZcHJB?=
 =?utf-8?B?QlNmc1NIZ01nOEFNN3ZkZy9xRnhrdkMvMkFGbC9URXBuS2lRSDNMeWtDWk5t?=
 =?utf-8?B?OTlacWxaRllhdkJuczd2RWFXZVFGOVpmeW10OFNIQy83cWJkTlVaQ0Z2MTN5?=
 =?utf-8?B?aHR0cVZtSkNHbC8wZlpKSnVPbWplTjZMSngycGFJb1JDbzVaamEvRXBFM0F0?=
 =?utf-8?B?bDQwaHBTbnQxQjZKTFA1c1RUSXJ5OGIxdVhTdzVNdmMwdnV1emZib0l2bFpJ?=
 =?utf-8?B?OGhtdjN6QVl0WWl6eFBRczZvNXJYd29acnNia1hjY3dpMm05a21wQTdDYUxw?=
 =?utf-8?B?cXdLQkRNOFA4akZXbXU1bWtTRlV3d0dCNEsvQ3JLZENoMmEybW14MU11YVcx?=
 =?utf-8?B?VG1LTFNyem9ScjJUd2pWVHkwUGRrTXAyblpkOVBZeEZyWFZVSkhFY2lPY2M4?=
 =?utf-8?B?enh6Tlh4QWVKWGNqc05QNlltNk9DY0FzU3ZDUjBvN3NiWmljbmU3ZGdGVkkz?=
 =?utf-8?B?UkFuMThHSTQ1UmF0V1dONXlRUGgrcDY5T295eXlYaklvOGlPUDFjbW41WkZJ?=
 =?utf-8?B?OUwxenhXR2NiYkJFRUlMZXNQUDJLQTM1eHhuU2kwc2xLaTNva1g0S0hia3Rw?=
 =?utf-8?B?ZHh4bjRTb3dveTM1Qk1JUG5uc0N5SmZzQ2NNK2YzNGRCVm5lUFZMdmlNK2hx?=
 =?utf-8?B?bDZNMm4yaTc2ZnRxaytwMWJmS1R4WHZHaktadGZNaURrWlQwYldsSGxxdmkx?=
 =?utf-8?B?bWkrTE03SVBmR3RnZFZEd0U5a2l5U2F2SEVpalFGeFNMQ0o4eXBjZFZZemxP?=
 =?utf-8?B?YTFYUjBkUkF6Q3FoUUk3ZUVHeU5tYlMzbFUrd2U2U1FZTjU4NEVjaWFIVEpw?=
 =?utf-8?B?VTdxcmdEdmRRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVJOUFpvSDJxS1Qyb3JaOUJ6dlJRTGdBeU1qbnk0cnQ4eXJzS2JVYU9BR3R5?=
 =?utf-8?B?ZXhNeEl0THBuV0pNWHYwMTNCQzNYOHRicnc3UEFXTTYzV0FCNmNoZE04d05w?=
 =?utf-8?B?SlVDaEgvNzZJbFhHTXlLOHYrWjJnVXRySXlOS1dxL1JQcnhaT1UzYUwyVjI0?=
 =?utf-8?B?WHlaVitGOXBlL0ZJREtJa0VPZWhmZzM4S0NBeUhSeHNOWU5TUzlBTHBTWGU1?=
 =?utf-8?B?QlNyRnpWbXBZWWppeEdJMWVNNGpCdGN1THd6d25lclNkNE5Sb2dwRVJEZjU2?=
 =?utf-8?B?MUVqc0s2SnBLL0NaOHZoc1Z1ZUV3Z1BJNE1YZWJtdFk4SGs5T01tbk1ka0xY?=
 =?utf-8?B?bW5UaklHR1U1WXZqdHA2TnM3TmNzWFkwVHczdTd4aGdsSW1JcC80cHN0RFAx?=
 =?utf-8?B?aHd3YkpKR2RVMTFrbWZYbGRUanY1bVliM3RJT2JFL0cwRmQ3VmNoVmdrWkJE?=
 =?utf-8?B?cFJuVTFxdXpKTkdmaWlJUmExSDJUV2VMempvazFzbWdUa0x1WEp1bzdrZ2kx?=
 =?utf-8?B?c3lXcFVKWUxDSHZkMDQ3clNvamF3NndwaWhkelBha3ptaVQzeUJLT1QxL0ZM?=
 =?utf-8?B?bEVSVktlOHcxZ2ZHS042cStjT0FuQTZyTVBiZ3FIaWNNWXJwbXlJbmQ2NEtP?=
 =?utf-8?B?UXFCYTZMc0lObkk1d2VaM2ZuYnhzYkJpYnJmT1h2SlpkazF5RzJWWVR1U0gv?=
 =?utf-8?B?QXhUY2taWkFkaUU1bkgrcDFOSzE2MFFzajlzdkV2QlFxRGNuWWw4blNLY3dB?=
 =?utf-8?B?bXYxelJudFhqeGlLaGNkVU1HTENiclZkbzNja0FBeEN3NXB1K21QWnc3WnI3?=
 =?utf-8?B?ejRyaWkxZ25wKzNzN1Q5RW15OWZJek1UcTJHMjBuR3VJSHJVYmF0WUI1Qm9y?=
 =?utf-8?B?TzRKRkpQN0paV1BKbnVBVy9zdi84MVhxcDVyZDgyLzBWM05nSEdVOSt1TFEv?=
 =?utf-8?B?RmFmSXliNHZQSGFsaHZUTUhpUzNGVERNbS90RFhoTWhneDdiTDB6SzZyVEFr?=
 =?utf-8?B?SnpJMXR5ejU0VlY2eE9tOFlId3RDaDZsTHdhNU1WMjJoYmZGY25uYURWVzQz?=
 =?utf-8?B?d05BSkI5WC9IVDIwam1lZWNFRXZuT29EdEZmWWNPays4OTRvZ2FDeFNENENh?=
 =?utf-8?B?RXozWmExOUFpbHMyNDRXc2h2NThKZ1o0aUtzL1htQ1pmbndlQ3JIUFJFUHJV?=
 =?utf-8?B?aVU1VFFUSm82VTR1aEh5TFBpZTRoVm5TRVRRWTRQODBEZzRSSUdvaXp0eXAz?=
 =?utf-8?B?b21aNTlkUmRsYXJzaGsrWFFqOGMvWFV1alAreHhJTmFwdGJhcnlWZUkzNW42?=
 =?utf-8?B?b2llUWRzaS9aWFhxR1pJeXJYUjNZNnR4U2ZGWHMwREFwU2d1M0Q0RldNMXFG?=
 =?utf-8?B?ZEltb09za21aU2VmZ3N1WDdzQ1dBMnhscWFNaHA1OXRHREV1dUs1dXdCMVNP?=
 =?utf-8?B?R3pqZ0tmdWJrMEtNZUxxeGozaXQrdzZuWWNSR1JUUEJyMnpNWDJVd0dJQ0pH?=
 =?utf-8?B?cmdWOWFONlAxTFc4OVJXK01NbC9nSEkwdUwvZHU5bUMxaDlnVDArTGhiVGFu?=
 =?utf-8?B?QlVHdlE4MjYvYjhaRGlkTGlDSWVTZFpVaHQ5N2UxaEhLWVJBcHRTMzRITC9J?=
 =?utf-8?B?VkVvWFJndXRnRVR1TnZSUzZSTlRuL0kxeTFGTnJBa2EySVdIYWFzQVJnMHBi?=
 =?utf-8?B?dTFvQ2h1dTMzRk1IMkQxOEdvTTFoVHF3LzJrbTRRV1JpaDVkZUZ1c3U3eCtl?=
 =?utf-8?B?ZXVBOGxZR0NZNExCZHlFMVRUNzZtM05XQkFDSEdvYW15ZGlRZHlMN1pFd3R2?=
 =?utf-8?B?bGFya1pwRm1TUmNrOXYxek1QR1FZTGo3NThMeWlaK1cxbXI4MW5rejhRR0J4?=
 =?utf-8?B?UVQ5cXozZ0p2bEQySXJ4Sk1QTVhxdXovSW5PaTQxb3paSTZKakZHckVYK1pY?=
 =?utf-8?B?OWdUSDg2d2NmZnVxZGpKVlRJdnQzV3Z5T0dZUzl3aytMV0Y1SzlxWGN0Mzh6?=
 =?utf-8?B?UHZLTFZtb1BQVUErdERDRGUzZEN1d3VsN1ZCOWZSNXZBV3R6V2dBelc4S21L?=
 =?utf-8?B?bEFSd3RoTXl2alFQUm96Z0xCVlpobkVMY0swOUZQakRtRjVIeTZrTEtWMGJ1?=
 =?utf-8?Q?LL4fbF5ntEfUnAKgiYQPBn7es?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea42223e-5f20-4b0f-9cd5-08ddfd0c9f16
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:40.8213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N4wAMFwWxhmjMIA+Jutz83ry4iHQ1h5Vfh9O11COphpfHVmeJoXpDSMjnOfiBTSKZIFl72WW6UvGuuYgsA5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

Per devicetree bindings:
arm,max-rx-timeout-ms indicates an optional time value, expressed in
milliseconds, representing the transport maximum timeout value for the
receive channel. The value should be a non-zero value if set.

Support this property if platform set it to a non-default value. This
property is a per SCMI property, so all channels share same value.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/mailbox_agent.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
index 32b0fd9f589a30c2bb8bdbe8d655c3d47d0abd5a..16a82f55ab7f7550e7744066cd640b0c439f75eb 100644
--- a/drivers/firmware/scmi/mailbox_agent.c
+++ b/drivers/firmware/scmi/mailbox_agent.c
@@ -16,7 +16,7 @@
 
 #include "smt.h"
 
-#define TIMEOUT_US_30MS			30000
+#define TIMEOUT_30MS			30
 
 /**
  * struct scmi_mbox_channel - Description of an SCMI mailbox transport
@@ -73,6 +73,7 @@ out:
 
 static int setup_channel(struct udevice *dev, struct scmi_mbox_channel *chan)
 {
+	struct scmi_mbox_channel *base_chan = dev_get_plat(dev);
 	int ret;
 
 	ret = mbox_get_by_index(dev, 0, &chan->mbox);
@@ -87,7 +88,7 @@ static int setup_channel(struct udevice *dev, struct scmi_mbox_channel *chan)
 		return ret;
 	}
 
-	chan->timeout_us = TIMEOUT_US_30MS;
+	chan->timeout_us = base_chan->timeout_us;
 
 	return 0;
 }
@@ -127,6 +128,9 @@ int scmi_mbox_of_to_plat(struct udevice *dev)
 {
 	struct scmi_mbox_channel *chan = dev_get_plat(dev);
 
+	chan->timeout_us = dev_read_u32_default(dev, "arm,max-rx-timeout-ms",
+						TIMEOUT_30MS) * 1000;
+
 	return setup_channel(dev, chan);
 }
 

-- 
2.35.3

