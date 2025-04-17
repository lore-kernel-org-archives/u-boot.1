Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C1C369C7
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB33582FC8;
	Thu, 17 Apr 2025 06:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OPY+rRtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 054B582CBC; Thu, 17 Apr 2025 04:20:05 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD9A182F85
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o8qhgoKyDkxf34P2xgwIShOCFOmgDNGcba0PSv7+hXstaO51VWUT+Z3Eo7oYJcY7wm5sWTmIutYrzKhpYSvEvFjBS4SGmdnIFGr68jqTPsM/e4bTqbWEPtv9uF6XmzTk1Dtc6RUa7kLpf/zCXJrMSPnhwNJNqdVrKXXQQ6lnaB7r65rCYw86DF6ddmScYHVM7/XNe+ABW+vM4RyULEiKKwuQOstKjrVITdeoygMIBH19G+upd202BBcETS08eHFrVbhBvHWqHkPutK5c0/OKzVQd+m6IJp7kFwIYMG4Ch9TQnUKF7cFnZPMnP0bZmyoAtdnpoO8Kayoy82aGfvYK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=vHd79v+KaSrsGi+g0FgrgZOxheK2oo4ASwRZpqsicJAF1vIfumXdtaFTLeySjIF2d24+Q2QjKg/CXfwSaddRF6QhbvZs7Jcjf/n3oEet+2GQTKBbPMbYSGrzpwxSEsYGyn3SViN0WAAoLZ5Mtv14V+FQhzjaO2cozckD98ZqhrG5iXnPewZyCyNO6uENbiaUc+ShJhTwpcF+2705Z6hXMg17huu8vceT9Y6I/JU57yQ0pzLzUk/epbiVzDAR4Ue5uvrl2E9ruxlv8eos6qQkowGU/oG29GRHZXuAJ2u3wGEwNotgNuh1lrjUGAXyHFe4MD1V7G9o6hrH6gx0veA2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=OPY+rRtwe7CfHTqctFUM04ZtmDqy5Gpx3d0bCN/LGZQWQ4IT9szSULIG+E/fD+Gx4vi7ezt9xQSbxpa1XwqdFCtfihc/cKMjseX87ct6WAhY0SKeLcJkWjcJDVcV+kF3xI8eNbBM8ZtyEmFzNgZrR/DjOpMtaZYzSqwUeDhqIoReB7AUEp4jitK65kOYj2reXDkj99wLbYDK0eKXzk3LDLY6QPzP5kCribCD5s757zm4q4LrvhEZudAUk0kc5mryyO1h8DYndF64i4ZZyNZUp8NwRb20ALAE+Dj2IHmKJIjohsEnhUZ7IR7q8PWXd2xmCjowPt7eHsEXUivKfma1cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH8PR03MB7197.namprd03.prod.outlook.com (2603:10b6:510:25d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 02:19:58 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:19:58 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v4 04/12] drivers: Enabled Kconfig and Makefile for i3c
 support
Date: Thu, 17 Apr 2025 10:18:32 +0800
Message-Id: <20250417021840.6212-5-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH8PR03MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d9080e-14e0-4dd9-3f33-08dd7d5659a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azNYV2w5Sk8wRlM4OFZWZ3cyVHFodFduaEJ6VlRRNkNnZ0haWm1sb2VueWdC?=
 =?utf-8?B?dkhHZmZodVFKcm50Z1pHaGw4SGpaSS8zUUJudjdXRmZXMUtMSUY1Vno3aVVv?=
 =?utf-8?B?dHYwUzZ6dVFzU1dnaFJJazFZd09oQ2NXUzgyd3RaSGkwbjloVHNCdjZkMW1o?=
 =?utf-8?B?UUJEMDNEem5RRnJXNmdvUms5VGJrdmR5Y0pBaHFxcHh3UjE2c0xrRXFZZm9Q?=
 =?utf-8?B?TmVlUmszRzErR3cxODRIbVk4OGNCYlI3RUdwK0w1Z0JuZkVwUGVJVnJweEY2?=
 =?utf-8?B?dnQyR0Qva2FJTnE3ZXhxRTZtcmx4SHNGZnFvanVxN3ErRGRxVUtCTDdIZ2lS?=
 =?utf-8?B?bDRPREZGcWhmaVRaaG4vbFA1eE9kM29pSVdZSU4vT2Z0a0kvK1paazBtbzBk?=
 =?utf-8?B?K3BxZ0dXcGg1NGtBV2k0M0lXSHNSaW91Tmd3bk12d3JMWkdJRG1oSVljdkFh?=
 =?utf-8?B?SGYxR0VZZS80WlM1RXdTUTJqVTNQUXovWk54azBEZm5FelhFbHBTZ0NoZkZJ?=
 =?utf-8?B?ODdrUDIzbWM1MDJUd01TSXdma1E4SGlUeC9QeVh3MlBJblVKc3hDZFdpenlL?=
 =?utf-8?B?RkwyWjliNmZCcHN1cWF2MURTZ21peXNPUHB2VElid25KVlU0QWN0YU1TWjZi?=
 =?utf-8?B?blVEZ09XMUpHdTlwS2FEZFI5MW0yWkxoYUo1aVpLSC90azkvNGF3RGlZbWJk?=
 =?utf-8?B?c3VRUE9HUitFS0dNUEtEazZWU1VKLzEvZi9WZmZKMGEvRDVrV3RLenRTWkFK?=
 =?utf-8?B?Q2lZcVJuNUpVRW9BWlN5WWJZOUdITjkxNjAwYzE1ZFY2SGk4K2x0Vm5WcUpO?=
 =?utf-8?B?T2hDRmFHYkRXUW9OZkJ2dHNjQWtMakR6YmxpNzk2YTRRNFRkeXo0YURWWTNV?=
 =?utf-8?B?MXdyMTE3ZnZOWFBINHFQU01lTTRralZnSStmQU1YdTFWSXJndDFlMjJTZHVn?=
 =?utf-8?B?b2RQbXBFSGdLRlJnL1FnTCtyVW5acXR2ZzF6Z0dZdkxqelpldFRsTTF1UVFW?=
 =?utf-8?B?dFExc0ZPTHcvbDRMc1ppekZHOVRnOWcvMmpFSDlWQzQ0cjN0QjhPZ1IvWWU1?=
 =?utf-8?B?RVp5MEU1SlUvaDlpRHpGMHg4TkgxeGlBYXFpSGs1M1A0V2cwdnJ5STFGZm51?=
 =?utf-8?B?bzNiSXk2eGpJRjhnSGVWeEc2Y0syME9zWk5GOTRNMVJ4aWVrUGlITFIrNzdJ?=
 =?utf-8?B?YmNwVFdTZ0dxZFBxelpmVDRyTGx4bXhYbkpqMnVvMDdtZlppbkxQWTQxT1R6?=
 =?utf-8?B?d2FPSXcxMzRlZDZjVzJSaXhhb01DMXRHbFF6dld5RXYwUTBSakMrV0xXSzRG?=
 =?utf-8?B?cmhJNWNQVE03dSswb2JOWHZwNmZ6R2FxT1VOcEk3YStiMUV3QjRFOXBwTitm?=
 =?utf-8?B?Y0hmSHEySEt0c2RLaHFRd2EvK2RDQUlZcDkxNHdhRzI0aktaRkhXUE5zdE5N?=
 =?utf-8?B?MlluWEZpbzFUWFZ2ZHZZaXpDeHlxT29UeGhHTTBVL2F5VnF3ZkRuSytzQ2V2?=
 =?utf-8?B?VzhUdnMwcXFIaWxnL1RCS1hGZ0JzNVVGeGxycFlVQWtjZE5hVUxjbGl5YnYw?=
 =?utf-8?B?alh2UUNGWnlJYmdSNkNXaDhvY283TXI3eU9PVjZoZjczRHpQS3Y3QWNlbE9G?=
 =?utf-8?B?SnE4V2JqaUhicVVkTHkraWRzVGxEa0FNRUdtdzRJSFpodm9kdlJ1RXVjek1m?=
 =?utf-8?B?R1M4eGU3ZUJzcnk2VmIxSEtCeGRpVkpLSWJ5UVJkZVF0REcxUnhsVTJMcnJq?=
 =?utf-8?B?Q3dsU01QZGpWMXBnM0szSy9DZXFvS2N2MVcwUmFUMXMySys5QXVsdVBRV3V5?=
 =?utf-8?Q?QS975oV53uMrn8thC7zpHH23DlOUtgVUToGoM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hOVm1JZzBmdFBBRXRYVlNvZVhTbStlSC94dWc2UUt5dTFmSlF4MXphcGxl?=
 =?utf-8?B?K0owemFXYTFUVWFXZFlFRmRnM2pRVlQ3cDdKc0hhTDl3TFUwWlhFTGV5WmJl?=
 =?utf-8?B?UUgwQkFNZ2V0VXRqT3lMelNUWHcwN0NvcHR1aUVHb0RyVzI2ZGNSYUVUdHh4?=
 =?utf-8?B?NVE2TWdJYW53WWRPVFZYbTJLS3FXZ09samwyOHFHTFZzSVd0aUZCVldqS0pL?=
 =?utf-8?B?bVRFNlVWcDVDcDBJNnVpOTcrYTFOTXpXUWFkbkt1Y3lVZjFvOEFQK3dCc2lT?=
 =?utf-8?B?bmdQcDdWMXUzMlk3NzUrNDdZY3k5NFRMbWllWWk0TlBTdDV5c0hKd1RNblFE?=
 =?utf-8?B?UHB5NVd4ci8zV2sycEtNeU03Z251UnMwVFdidW85b1Zkck9UOGdhWXRqaWdH?=
 =?utf-8?B?T2RGK0toNU4wa3JyeTJVUG5FNTRYQU1VMk1zblJ6Tit0YXBteXlGdmdFRWdo?=
 =?utf-8?B?NmZVRng5ckNYdDZVK2J5NEdHaHZmdnVSbHFEQlJ6aWtrSklBdHRNbTdpbmdr?=
 =?utf-8?B?UWc2M3lIUWJ3bHRCNkdZanVic01jSjFlbjlOeEVKMVEzYjBoYmUrQTJLSStr?=
 =?utf-8?B?aVpwT1RuY0RVOENhamNYUkMyMlZ6aFRUd1ZnaXFPZ3NMSVRTeTNuQlh2SXc5?=
 =?utf-8?B?bDJXTW5uNVYySWptbW56MFNzWmE1MGZYZlM2LzVaa2Z0dGNCdkRnMktheXFk?=
 =?utf-8?B?R0dBalVKYmNhTlBGeVI3bkZHdTZLSEw1aG5acHlhV2pWM1BCVmczUWxoS09F?=
 =?utf-8?B?anFJdmVUSHBrKzE5MXN0Z1lCRFEzRGtzK3BkaGk5a3VLYXpyV2RyZWc1djlm?=
 =?utf-8?B?RGdJLzlaVCt6SUVWYXlzd2lIMHR6WkxKRDBuVjRUSmE5NnQzNHpVRUlYdnEv?=
 =?utf-8?B?dGtKRlBjanFTbERKMGs3TjRyOGozVFdybTBnN3Z3cmV6alc1WU9nbDZUZkNk?=
 =?utf-8?B?dGpqRDdHSkg5K09oODRuUURrZEtEUi9uN29BS1h4TlZRbFd2VzJxVzM3SmNR?=
 =?utf-8?B?YXo0R1Y1REl4NWQwRkwreDh0RUVwOUFqUm5LVjJqdE9qSWNleWNGMFNYL1pY?=
 =?utf-8?B?WllQbS9ISEhwSTd2UDFOcWFTaGNXRG1EcGYvcWwvT0h0QmxKKzRYaVB2RDBL?=
 =?utf-8?B?eHIzMkwyZytzTm9vTktiOFdKdy9FSTB2OXdHd2pRN2ZaMEFMTS9oRmhOWndR?=
 =?utf-8?B?WmV2TkVPSy9Dcm1EZWxVVUk1V29INysvL3NQN1BrWHk1c2F3RXh0VmhLV2pW?=
 =?utf-8?B?ekc0dDJCMlJtSzBNaytyTmJ0Q2Z1T3QrcFBDQWJRdVhTUjBMZ2NJbHh3OWFS?=
 =?utf-8?B?UTJKbEYxbmREdlJRUDlyOXI2Y0ZlblNMMjBEUE0rTHRUZ09aemQ1NUVaSFhZ?=
 =?utf-8?B?WFFBMFpzWk8xWmllQXdaZkhkbW9qbk9STUdqY1RPNFR4dG1IMk1rMXJLR3Bu?=
 =?utf-8?B?SGdJcnBEcFJLcWNGRHQ0Umcxd09JcnZ2ZlcrUSt5YnhYZWN2RTFXbFNZaEEx?=
 =?utf-8?B?cXFmREtiTXBXdVkxNmcyV0hnQ1ZaS3ZBcEFvaG4rdjRDSGxsOUxHZjB5ZUd3?=
 =?utf-8?B?K0FQZTJHMlRPZmlzTHdvcjQ5dFdDamVHYmFhTEVxYmdCSmRISzk1ZWM0QWto?=
 =?utf-8?B?dUZZbGRJZ3ExNWJLdWdQOGc5a0V3U3J3RXFYb1RhQWxqY0hNNDQ5Y2VXTWdi?=
 =?utf-8?B?WDYzNFZpK1pobkF6MUxPTCt5TldPMzN1OVFxaHU1U0RUejNncTduY2ZzTXpN?=
 =?utf-8?B?Rk9CMFlabUNnZjd5czM0b0NBbFFicll1TUJQMGZ1bDkrRzA0YmU2Q0NuY2Q4?=
 =?utf-8?B?YkZGSngzTmZXNGpNMzR2YVhkMWlxUVFNZWg2bG5COGpYcUZna3FLeDk2bk5N?=
 =?utf-8?B?R2N6YUtTRjBhL0dBZHV0SVA3M3g0YmY4OWQxZTNvRFVLc2hyaHZPUTJDRm10?=
 =?utf-8?B?TVJmbTVLMTZlUlRoc2xwOWNudjErZE9EcXAwaE93MDNYUUFBRVlmZnMxYUla?=
 =?utf-8?B?ZnVkUUZoOUhhVklnN3RseGNUM095S3o1ZFl0QXcyYUNwZGF3OCtSb1pQbEFp?=
 =?utf-8?B?TDV5dERGb3N4ZGZRMDE1cHVPeWtwL0MxaWpoM2lMMXhOT0NscXBwWVZRNnJO?=
 =?utf-8?B?bjcvaTREdThGTnNRczZsR0JnM0wydmV2cVZ1STZXYnVnZ2RNVG54M2xPNUl5?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d9080e-14e0-4dd9-3f33-08dd7d5659a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:19:58.4502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKPljUOXBOLWnc2UztGWe+l3S5kyDIWUodCqvYfyAOGHnMAEua9iUYIgQnS/9QHmLVft4EUZdEA5nyHuGXNDVoyCyRDTRmjetgjhOgnYFIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB7197
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add new i3c driver to U-Boot drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 MAINTAINERS          |  7 +++++++
 drivers/Kconfig      |  2 ++
 drivers/Makefile     |  1 +
 drivers/i3c/Kconfig  | 16 ++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 5 files changed, 29 insertions(+)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 0315c606744..6dcc566eb72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1230,6 +1230,13 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
+I3C
+M:	Dinesh <dinesh.maniyam@altera.com>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	cmd/i3c.c
+F:	drivers/i3c/
+
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26d..0b0c610e629 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -56,6 +56,8 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/input/Kconfig"
 
 source "drivers/iommu/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..fd155835ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
 obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 00000000000..fa68612787b
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,16 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 00000000000..5bb44a8d64f
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= i3c-uclass.o device.o master.o
-- 
2.35.3

