Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82930C54798
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 08:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D005E879A0;
	Thu, 29 Feb 2024 09:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="gXI4VInV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3694587B7C; Thu, 29 Feb 2024 09:51:12 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7A98787C
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 09:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7CBYnQKld8VotoXr58jtXJ+wHpCLkAKQ7ROhNJflN+oZ6dCXWiZjC1u36/eU6LkIANqh7JLJMw+TCCEHI1gGTjIZ20frfNBncnli4zi7yleQxXYp+qWWxW6L73ju9tFDxxJKjnoA+KskJgKs5nGlqYlc/5yJasiljm0YN08iyEfi8X5vjZjdAaiaZIxU3wBvLFvD3ipg+KrPvRRtatIGPaw3PxAnJpBAF1iJsfSaZQxTzmuk4uK/3D8S1z08w/opawu6CzDerq9bQiyPi6N7a2r2U41GqHWNxv/3uGWdCOhNn+NEnH9wK6GHtiSV8MLP5yKX63XbgJ55y5PnBzZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNvs0drpNx5c+OX9ryBhA8/5/EeUIdezkgquedCB79U=;
 b=XJUXOnO5TJLH9oe2HXbB3VxSj0Nit6V740pOu6J/SlIE4VnHrDWn+5+0XpSrZzAwApz+D/X3/lymmKybOEQu6KE19btvs0lULWJMc5V8pP1LR6Pu024HLDP0UrCDbex22afGE9chPhSr8idJFPHUImDrq80JwJ3nwYUITzATq7+da/SX6FzmfUI+Fkq2TDVUXlgASRpBFakOkeTGQXQ6BZiKVuhIkeFdJtyVtzEVVxoQ8aDvHrJ4NzqNymEHICDLuGKbIHwh6vOoijrAF844XFzmkDhisDapB7Zxnl4qQhFY6AZdt3GoK2Izau28uaspS5XXWo3/Dm8fOlXfPJsgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNvs0drpNx5c+OX9ryBhA8/5/EeUIdezkgquedCB79U=;
 b=gXI4VInVFwGiMcJ3ei9WcXrs3Ef59vQWDCx3S7ZspoLyGVLpI0+m5tLbFzVX5zpW3Pls60D5oxK+JdORtsuhs94DrzloqCPbP32fi1zHDTMHaHehC56KiqZBxpouOohuOB0nPA+xhmkANrGrSNBdHq9hBGTs6CnVw5ZIpL75TrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6376.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:557::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 08:51:07 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d045:edb:e12b:93ec%6]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 08:51:07 +0000
Message-ID: <985f8309-7622-40fe-9352-36cdf7853556@kontron.de>
Date: Thu, 29 Feb 2024 09:51:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Introduce mtdblock device
Content-Language: en-US, de-DE
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240227100441.1811047-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc23a1f-436e-4444-1367-08dc3903919f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfgxErHzpvBU77nm5B6n2Znu9oNPAURhol/foXUrWs7rAYxlC1zgZkK6WRKu6bCxB37baz67dLQAIerNYy7hrBbRDTJlJL6En/3oeNOU8RqJmtH1mh4Cb+WRpjEup9/+CDN4C8lPmsyf+rkBWkGMpgcFI3DiXxIKFQE1iTqGOv33QpqKGXvG8K2cDR2dF7aQ8cJYl4NOTIx61QFRH8ECbva2oPSJARA6KD4MWPht9EI/5dSTWHJSXB4xZeOqX5+W6lvfNm+c5xrFXM+vwlMTtciTL5/3R+ixjf0GSaRyZ3Dxbpdoaoi3dZzP9lPk/P8crDRx8g/NLyWlEIlvmy/WdTK50fQ31uL78A/7RDMOQhqgYQ3xLww6yXBJq9ObFOY8kFdcOVcsTUGe5L0oJfsZILNiK/jseD2xrqMOiHGgcfrAqIuDnrLM2Z2XnAbEOXVZ3ZJktptZsx7HBoPYpyKniD9kE3pynJkOmfsb+/GwNh2t2WewETePSLb/TZrxc/CB6ZZ27ry2Eynj/bkudV0EkqjYzQ+hhB22Rdt+5HeZ/xgMjQrmfPMJAQf2C5I8AanFhUWjNZqND9ErT33nQJup/jQo9TXGCjBbSI270+2Q/ccY2ukVSnaYoio9qRojgRsrB2vfCNKW5rgqPjC/A9hrI1A/QTxYfiRw05amUOJkQTS/8lCzXlH5HvBhBYFU8Tpw/d/LinbQY+w9F/RXrJyRBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(921011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VSaFh6aWREZ096TFJhczlFWDJkR2V1RGlFaXQwYWZQY2JvNUhJK0wyK2gz?=
 =?utf-8?B?b3NJNlh3SEhoTTdVV28xeTZOcHBOb3lsdmg2Ly9tSnlYNGVGMHNUSGYrekNn?=
 =?utf-8?B?WEpyNHZpakF5K2VTMERyUmsrWnVTWkg0UmZ1TFRQUHRHb2I5SmhzV1lTK3Rw?=
 =?utf-8?B?SC82dWhtTkp1akVqMjhwdnhUelkxSFZ2YkJCSy80eE8zSHBCNWtON0M4YnpV?=
 =?utf-8?B?aHlNTzFKN3RRVFZ5M2NOYjl1MHgwMG9wY3ZyV2hnY1duaFFiZG00Y2ZpMGc4?=
 =?utf-8?B?MjJPVFdpUVlsdXRvK3pVc2E4WlA4WStvaXlwSkljWUNyTXFTczJFZkxEVlRp?=
 =?utf-8?B?RVVjTk1obzlvN043NGp5VVhXdkdBWGlxMkRySTZ5K21zOGFTbnlFejdqbmhH?=
 =?utf-8?B?MDhLTlcrQlFvdzVuR2lmZWJjc3I4eFh4QTc4eWtYNTNOMG5RRWZRU1FsaHo4?=
 =?utf-8?B?L1Rob0Y3OExvVElsNmxUcmJWZGhocWlKUk9oS3hQdi9hU3ZrKzRGSlRhc1pG?=
 =?utf-8?B?YTRFbFVFd0xvM0dsY0pMUHZVMm5NQm50bEh3ZjhIdHNJbXlxa1dTeENHZGNr?=
 =?utf-8?B?WEx2YzU4UUpna0wwZVp1R2xRNlJ1VDB4SDNwbUJqM0ltaUp6Z1VuWWttcU5k?=
 =?utf-8?B?YlVhNWxlRWJOazlrTDNHTWVMeTRCb0oycHRtY0hoeGh3Y2VyYVpNQUdlRUI5?=
 =?utf-8?B?TFdqR01PcVhmK1RNeHA4SUhqMVBQcmNmSS95YkxjVzZpYytxcEdLK0wrN3oy?=
 =?utf-8?B?Z2o0azR2clNuQndTZXZOK2QyVWlMZStKdGg0a2cxdzJQdFduUGVuTEtKV3d2?=
 =?utf-8?B?ZTAxbzRkRmljNUpidVFESWYxZFZXSVlwemVsNU5nTGhjV2VQMEo0akRrZElS?=
 =?utf-8?B?WVpXMU1ITHRFYXdCMk1xNENDdlhRM0FFYXRST0pYakY3NFRlQ3RXRUZYaTB4?=
 =?utf-8?B?c1p5RTdVT2gzSjdhdzNBY0NGbU9yTEZyUWhCeHIrMmJaeld3b08wNlNOOUZ4?=
 =?utf-8?B?OCtOcG9LQyttSGF4Y1JmTVFhbTFDMGVsRkp4b01jTW9XSncvSldxOGxyZlky?=
 =?utf-8?B?UjZRWk1IZVJWRld0dkdsa0J0RW1IN0xXOWQyWVREcXJmaThYRTQ5KzYyVENl?=
 =?utf-8?B?UHc3WHhoMDFFL0FnV0NLSUpWTlc1S0FVdFhTbjJZbEJkdEJtbVBhOXIxOEli?=
 =?utf-8?B?T1Q0dS9JQVkwakoyMEJaQVdIZm1TZnE4UFpPR2hYWVlYd1dSalZFOVNkK1c1?=
 =?utf-8?B?dnorckZYL1BabkxCSHRjT3JGWXJQKzJjb1BRbnlMdWpZaGp2QWEva2lSa1VL?=
 =?utf-8?B?WkVPVXJyOW9JZ2tLbmVQTERWajdDWVMzMkdIWXRlaU5QUVhEQmY2V1BjckRk?=
 =?utf-8?B?RnR5REtkOGxBOUl1SXZxMDV1cnpnSlE2L0VZa1hZTGNkVVFTOG5IbTRlalM5?=
 =?utf-8?B?TDNaN0YwSlF2b2RRTU9Tc1F3ZElkcVVOM1phdmFISFA1bGV6VzZ2T0V5aDQ1?=
 =?utf-8?B?c3A1dlF2MTQ2eHNiWmplV1FpZlpuSFBpM0ZBeTVNenpia0lwS0RwZis5UTIx?=
 =?utf-8?B?cm41MHd4UFhhUTUxNHZvTGFOZkJYNFVuU3ZrTHZ2YXI5TnJJeTZOTFNRWWdY?=
 =?utf-8?B?eWR2SVVselZ4UVlkTU03OHpNd0ZBMDRvVXZTK3JzQTg4N2tZNzhJZG03VWxW?=
 =?utf-8?B?WlpvZmJzU3ZvNWZGbzUxKytmOXpsWVBrMXR6bVBndFBaL0o0VllabzdlMmZL?=
 =?utf-8?B?RElkMXlGVjkzbW5ScEVaREVrb2RCWW11NHJQUkxXbWRPQTVVWWhFTkNIclRH?=
 =?utf-8?B?MmtVaWVIWGJldGFTSEtFK2ZPZjFrNmUrdzhGNTQ4RCtQN1pQQ05wWDF3UVdy?=
 =?utf-8?B?VXQwdDVZWSs0TUVyU0NnT09vamVzdUJDZmNSUDJTSkhVQ09QYUZtamVNME5N?=
 =?utf-8?B?K2VFN2N5ZzdhbGhsaDJQV2d1ZVBhZCtKS2k3dG1oNUVPUDhrZ2hGNTJsU3dp?=
 =?utf-8?B?dXBjYnhGbTV3MGtZLzViNjdvUVZ3KzBWTGFGYklDWmtlQkxka1BJa28zamZ2?=
 =?utf-8?B?Q3ZwYk9aVTRlVXNVdmNYVmtrcTl5VVphL1lHQkkvN3FhUXZlcmNtNWlDYW5s?=
 =?utf-8?B?KytlTnVGSG1kM3MzSWFkREZRVXRWK2QwcldWVTRXd0E0RWpCaGtuZG16MkJi?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc23a1f-436e-4444-1367-08dc3903919f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 08:51:07.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P/okAvLTA1XBUsS+S+lt8M5qkPtQaiuVAVCUfFJ5XF653cHrMxeZviuBiKD+Mw6P6mv0zHThwVnshcq+Y0+bKMV5v5SxMWZyqlXd9WYF78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6376
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

Hi Alexey,

On 27.02.24 11:04, Alexey Romanov wrote:
> Hello!
> 
> This series adds support for the mtdblock device, which
> allows to read/write data block by block. For example,
> it can now be used for BCB or Android AB command:
> 
>   $ bcb load mtd 0 part_name
> 
> Tested only on SPI NAND, so bind is made only for
> SPI NAND drivers.

I don't know much about Android, but as far as I understand you are
trying to store dynamic, boot-related information on the MTD device.

This might be acceptable if the underlying device is a NOR flash, but
for any type of NAND device it sounds like a rather bad idea.

NAND devices need some kind of FTL (flash translation layer) in order to
work reliably. Using a block filesystem directly on the NAND MTD device
will cause problems as soon as any bad blocks or bit flips occur.

People are therefore discouraged to use mtdblock on NAND and in the
kernel there is even a warning if you try to mount a NAND mtdblock
partition.

Maybe you should reconsider this and look into how to use UBIFS as a
FTL. On the other hand I'm not quite sure if the UBIFS layer in U-Boot
is really stable and maintained. So this might not be a good idea either.

Anyway, I'm against implementing mtdblock for SPI NAND (or any other NAND).

Best regards
Frieder
