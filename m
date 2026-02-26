Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1840FD4609
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 03:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2987A83E7F;
	Thu, 26 Feb 2026 04:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tEfYmYtS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12FEB83E8E; Thu, 26 Feb 2026 04:10:51 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013040.outbound.protection.outlook.com
 [52.101.83.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A8C83E61
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 04:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W13115ydhGN9M9neyMC25PF6pUdjhztgD7I/sRFkRtAbHV26w/5IlOZ7LjbyZejNOY6DjO6wIF4kiY0FIl7eYMuin0vqTWjrkGfz8fzstZMvff6vUDTyjAb4UFSkp3Vd7qjhUAui4nIHGoi1gQ0GdptHTGGOZY1IQWtFFslg+TOS8SEqRw/w9HImoz1uBituCsT52gOsIbPar2TVkllE0n0zMfbdGPDEZ3d0EkZjKYA27oeqdHmlUfAV7rbqA1CrUPnpsAv0QHN98R5SoPmWfpktP4sye+JdNLqCkjoeXZzaV1msAth5t0c689Jt72FEX8Qq7J9lE9m6kxM+YlQaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwRCudy2BHcLaHl2z609Pz4Ax0BDw5RnKrwBNqfxyio=;
 b=KHast2S2sd3kcqwjzG3oyBHJDQfEFevTfN+BQTOel301z0Nr0/aMwNiw6w9Z3ZS46KyMxfow5+kFYPhUDgFu7gTlKDqmSyCVbMD27F4QpS1ISI00gdOls+3VFagafaNaZMsckLz0lw/8ceqaGX8XqCQoNYiCBl4p6FdcYjwQWAdLekh6Qdk3gT8eVvptDTOmh+KSQqAiIqtTuOlgqaDSkKB+FKs0/ri2HcmpW3kNjjZdXEQY7oiVBUy32zF1lLiFAwO3w4KhY9N2gcNxmuUEUhsMYjGmCE/SBQ9DFKGCazeGNV4coxm/npUccsqCcNPjHZnrflJHP/8YB/HneauiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwRCudy2BHcLaHl2z609Pz4Ax0BDw5RnKrwBNqfxyio=;
 b=tEfYmYtSfKf511bO3u1Wdm2bxSPVRxvbLapkTjjMlzHlyDsZz6xBN92CBn8MEXSOZeTGV14BMn+fPTbXkmfzjdPy6EeaqdoLfrjOfgUsXdsONw/zUnMbnH+4XLLEwlQPCkhU8jRvEEuFto7BPeMmiFYR3l6t4UgwYJ7k1Jef2rsaWGs349tfpzCJ1AWfZN8MFguOgalnCiGQ+oGODz6xBWGI857OaQZo3gLVUS0CyEGa5Q+QdcXtzsJA4l0DS0XOZwa+yGSASfRFnEU7dN5HQBqg2bBcgWqmK5RT4w2jaL69qeIifSCj0AoN6jPbzyndfy2rP1o0HAB0H0dTJbF/sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11013.eurprd04.prod.outlook.com (2603:10a6:150:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 03:10:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:10:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
Date: Thu, 26 Feb 2026 12:25:28 +0800
Message-ID: <177207977392.1460793.6432347804019830498.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
References: <20260225065714.48562-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11013:EE_
X-MS-Office365-Filtering-Correlation-Id: 22eef72a-c25f-48ae-4eef-08de74e49b37
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: DDR7sP+Af6K1J60CcZWDApXAp7kC6UDtwVkBkOUfhjBoCEq8QcrCQuvLuprtUUkhT9mfAiph2pCFD0ouF/1+Aehnt93vy6JuCEqK2Me3nBEqSKeWlwuqqfAwkHufKjagastoeqHtyr3DdjZk8LX+s6lw+FFMSPU7Wg+vJxlil6twQVQ0uefSIuobY4GPOOWM+LFU4tZZKzFf7wdXY8T0B57CSU+14wIunoFuwTSJBGFQXixaiWvfMT44aTnKs4av4COCXzIL8LVr532xKSy4RAmxxUr31o6AteP2BZjfZjEI1hcH52GBOh6GNnLW/0G9tt7RJ+S0S3l49VCDLFqPvUlYCdK4I7mpVodieJMYSv1rWRQIIkwL0NLmWZRKMupVnwPemjf2bu5tL6MUuDcivxIOs70nORbonoE8yBYDnVTkAHPA6V1gYGXcfuz9f6DFQp9LXvWmdJ1uYkkCFZB31tCMYK6wiWDkUArIzuEAhrCJWEehLw2c+dpPD4M8KYWSBCuxiTMUiv+vRKEWBZjQhVft1d4o7HByoT7QSg91DOO5aj2OiiFGuIzZRx/YnPsW409p1oszkQbaxlMo33pXhFJ+E3iA9WVX8Rm49HbRBY+xE1bRC+5djB9WkxwyXneMvs3VljziBm5aUaUa4x/2c0R68QCherRBAMlunanzRfSZzWac1LvNmc9Njvk8MfG7pSmlk8/NQITlpfcwXDN/CrT7YdrVO2vKA07F5CNZU/enU6x5MoJ4a1SfCT7W0cSEowJJpSZJIBoLFZP8pHSgmMQAGcvcySgqojdoGoXoYKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9rM0dQM2FrenVURWFUalZFQVU3TXVaVXBKa3dFa2swdGtmb09Danh2bjhX?=
 =?utf-8?B?ZktOSUw0Yk4yc2pTN3VmUzdVSldiekhCUmQzMDJpT2dLUmQwQ1Z5RmVnejBq?=
 =?utf-8?B?cUJ0NDNrRTVHbEkxT2NQMXlrR3U4WlozUmdWYXUrOXl5TmZQWVhhbG1VcURj?=
 =?utf-8?B?TW1pUXRpVWR3ajIrYzlZK1BPbDRWZEtHZ1k0UlJjTGpXcVRxMDZHTXhrRUxp?=
 =?utf-8?B?d1lPeStVOUtPYTEreFJwSXdGYVpiTXNBTFpwYU9RUDh6YzIvMVNJc3lqSHp5?=
 =?utf-8?B?aTZrNFZJYmtiYzdDYUtBcW5pT0FZYkMvNURXY3loaGQzRFZlWkZLR3l3elNO?=
 =?utf-8?B?dlMrYUIxZVlOVC8yanRHMkR4ZFEwdW9oS25odmNoVG1ZYnNHQTNzUWpUNzZs?=
 =?utf-8?B?aUxEelY5Y0kxbmcwcWZ2bTl4QVQ3d1FPYUJJZUV4Q3FiNU1XeGNHRVR4RHJX?=
 =?utf-8?B?L0czaUtKQ3B3K0ZIL09RNFJWMEhkU05FTVYxMEJYUG9DMGY5MENMM0x2cmVm?=
 =?utf-8?B?MFNLVFlpZTNuZU1wdHRzbldLZkVnQ0FVVXRUQ0lVQzNzNGtWQVFkU1FXQ3NG?=
 =?utf-8?B?cXNGdE9aZ1l0Y2pOaXpPdUlaRzZwWEFOQW9TeVY4SjRuL1czQ3duQ09sbUEr?=
 =?utf-8?B?K1VwOEJLRHRMMmdxMGp5ZUUzdG8zWWVLd2hBT3dTTkxFMzBaaFI4OFI1RHJQ?=
 =?utf-8?B?MTN3NGg5bEVwTmJJOWxlZ3dkMXRkRkdGc05xbmtNaDVGYTF0N1FjTlJ3MEhH?=
 =?utf-8?B?aDNFbEQwSzlXQVJreG1PWnpPMGdYaHpBN0h2VThxWURUK0YxZU5VRUJZZWQz?=
 =?utf-8?B?YURKZ2kxVHg0OFl2LzY2WHpSbEJqdFFKb3FxMG01QUt3NGpkbkV5cnFDMUlo?=
 =?utf-8?B?NlErM01QbVZvZXNnRW1RaFowQTZ3WDFvMG1vaWpZUUFjZ1ZVT1kwcWUvTWV0?=
 =?utf-8?B?TzVDdGE4VCs4N1RGTWdsM2hURkFJT0gwVlJDZTFSNjBmV3NLb3cvNzFMQUlz?=
 =?utf-8?B?R3ZjZkxLNUY1Tk9lNVJqdnRtRUw1amMvejl0OU9XbXdaZFUxRGNXRGZkb2tt?=
 =?utf-8?B?eG5iblV5WEVVVTBUTWFBUmduclVON1Z2enFqSVZ1dEVKdCtKb1pRUmpaYWNW?=
 =?utf-8?B?N25xUmdyemFCcitxUHZUdVg5cmlqTTRtY1dadXBDN0FHZnZQVUl1YXZCK2VM?=
 =?utf-8?B?M0tzRkF6UExvKzEvVnhSU0M3MURTSWZ0WVUvVk43QnJ3bEhLbCtHUnJGdTlU?=
 =?utf-8?B?S2RDZnprd0Z6aCtRYjkrdGRidjdIYW9zZndoVUdKU1VIRjF5ZldnWXkzM1Z2?=
 =?utf-8?B?cUx1bXJwNWx6eTBsT3RqRVoySXZNMVplNmxzd0VXOUcrZ3NFQVpXT3ppZFVp?=
 =?utf-8?B?dmNhaUxRZ3pCZDBJYUEwdU8xdUpxQzhWT21tUjVlY1JhM0xZZ2JzRFNSOHg5?=
 =?utf-8?B?bm1uczlYcWZ3ZUhwR3JDeFpkbHdwRllwbWI4UVJVeUV1VVNhSjRmcWtNNzlt?=
 =?utf-8?B?VHEvL09ML1cxYUJtSk9OYURxeW9MSDBld1d4V255TlpIZ1V3Yzg3c0dlbXl1?=
 =?utf-8?B?VU12ejNQQ0NMeTZnYzJiWlVMM1MreDU0Y3BHQldqTTF5Y0lwT3U3czE0UXpm?=
 =?utf-8?B?T2tlbXIzUFBxWHp1S3JXaVJXNnFkYlo5dEhJeU9DNlJ5WlpydW1RRXBhNXJN?=
 =?utf-8?B?ZmEvZjhrd0VkeGxLOUJyaHd5c0tqVHhGV29ZbzBHZzJLa3pSclV0UGxEdHVw?=
 =?utf-8?B?T3RWeHRRb00zNTlTcEJ1aC9qeXlNd0xhMkgyUC9xSTdyUS9GNG5wd1diTW9B?=
 =?utf-8?B?Qjd6YjM5NithMHFON01uWXlxSUszZ2FxM2JsaVBpWlkvSkxQd3JZSmJwVTRs?=
 =?utf-8?B?NktTMTBNK3V3dU1md2Y0UjJKRmtVeDZYQ1pmckp3ZlJQT2RzcWhIS3g4bCs0?=
 =?utf-8?B?YWpGZnJYbC9MOWZxV3gvb3J6WnlQWVlLNEJzOGZ5dFdRRXRpVFZJaXU3OXQz?=
 =?utf-8?B?cVFJR0RwemxtdWMvVzlsK1A0QWk1WGwwMDR0VldsY25Zb09wVUZIeXdLTFpW?=
 =?utf-8?B?VDNZaVIvNDFSMDM3VERramt6SWI2UDV0NE4xY2U1Wk9wQllUQWZEdDdTWUc4?=
 =?utf-8?B?TjY1NTNyUWJGaVcvQmhNelVSTHlvTjNIQ3pacHQxeGh2U04wemlLS3ZOVzcr?=
 =?utf-8?B?RzVkNHE4RDZEUHh4YVpqU2daak55Y0V2R2pkS29qZzQzMmkzTkxhbFJsUHBQ?=
 =?utf-8?B?UmthQUgwYkdBdTJOemNFSndvQjlzNHdibHlhVjZxdG5aWHRPcXBNNkFFaVhK?=
 =?utf-8?B?cUNyQ3lQNms4aDgrLzZjcFBzUitmZGR5ZWVNbVg5Z0tLcHVCL2FzZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eef72a-c25f-48ae-4eef-08de74e49b37
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:10:34.1867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vbo3IhL/OOyEhh+ez7V4UYvRKTofpYJTTR3Cg4M1DsWaSu1YCtGsj9YtH/8NNt6hknPUu/jh2TNHfWGjA+HCsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11013
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


On Wed, 25 Feb 2026 07:57:14 +0100, Heinrich Schuchardt wrote:
> Symbol CONFIG_SPL_DM_REGULATOR_FAN53555 is selected by
> SPL_DM_PMIC_FAN53555 and used in a Makefile. But the
> symbol definition is missing.
> 
> Add the missing configuration symbol.
> 
> 
> [...]

Applied to mmc-next-2026-02-26, thanks!

[1/1] drivers/power/regulator: add SPL_DM_REGULATOR_FAN53555
      (no commit info)

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
