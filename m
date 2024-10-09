Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16754CF0453
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 11:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 844F389166;
	Wed,  9 Oct 2024 13:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Q6dxsegT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504BC88F5E; Wed,  9 Oct 2024 13:08:16 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 674738917F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 13:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCiRDn39sgVVIDLPKFs9VF7SDBVcGDSdKnyusjP72y8vLdjukQ/MKZ/DAaOzM2xxJu6UzMRVoT5PyIRx7WpnPFlkpX0nyVmE3RtZXiemIPUjUeO3ltrRNdxL+BhnN/3i3GcU4MXscegAuC/oUCSlaXUcEgVukzxhKeYPHelqSHJUtL50uylCTQ4NYmfHn3o0gDbjYlRy/xgskJG6n2JOeFAEeHPzBEBBK6n5wIjQzXwqn7oFhGY8COfCOhP0nC5T0H+pChQyA48CfdJ/2KZOQzCtIzI7AdTwNC26cd1yit/HzlOdjGVb91uIjVhsb4/zFwftYJFI6BlCkT+D1/NpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAA9DQI/dvPN9ROWUaOG4ffbp51/kZegzZJb/sRLUOg=;
 b=vwwlTC7vMq7lB9QlRlmS1SZbFi0qH+MjNitopcJQrTTH6D+JRuTQEaWsVLxiNvCsZ2O+Tyc9igpB+lDoPuZ7tT2REzayKh/olSPXvWWh1GQ8qK1fKY5hcb2BZ6BBW7QQGT/YF7L+CRXAxlS30dRObhVvtX/ThwJj9IaEyK/9To2DHAx8UslC/Ue9ggukOfwB/LACpjStVggoisViqGKp0VNN/unltE2Jp5JLD/T2mnIwQNUr5nTFuVQdwNyyqI+NCmZG+sizxNKmmg1BRQMu7tyq5dvHk/jKs4vGxARFxjtfD/t4usEdh5jwPE00M1X0T93RbKEUPDBHemo3sGWlLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAA9DQI/dvPN9ROWUaOG4ffbp51/kZegzZJb/sRLUOg=;
 b=Q6dxsegTCQK9glSsn8wF4fTeocQKLY82yAgpyB3KHNLULahU4xK3wAD51jG+G3/sMjVI79BtsNUM1lmzqiJXVquzvKi3BIcxZBoyn/vrYUFBOPpxEoGVO9mnFw+2dDOnGgEaf4ZU28/LQq+HkVKk4VWWqa+BDG1EZUL8Tyhta2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM7PR10MB3687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 11:08:11 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 11:08:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,  Stefan Roese <sr@denx.de>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 02/13] cyclic: introduce u-boot/schedule.h
In-Reply-To: <CAFLszTiiCgKGrn2vuMSfrg9Et=Oi+VcEEycQjYK7qS7zAQEesA@mail.gmail.com>
 (Simon Glass's message of "Tue, 8 Oct 2024 19:52:38 -0600")
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-3-ravi@prevas.dk>
 <CAFLszTiiCgKGrn2vuMSfrg9Et=Oi+VcEEycQjYK7qS7zAQEesA@mail.gmail.com>
Date: Wed, 09 Oct 2024 13:08:13 +0200
Message-ID: <875xq15yaq.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM7PR10MB3687:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e25079-567d-4748-347f-08dce852a9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/rpH6UKyBMDiomFYqsua10fVIuvavCzr7lt4K2UN6bdeEIW+7OdH5O5UOwdA?=
 =?us-ascii?Q?hNJYbEEg1n294tOtB+weUyqlAIJEB9XZnj08El2Dj4mu6gmL3wS9RXcgleZ3?=
 =?us-ascii?Q?Suqfvf1UCQsV5bEZOuU/sRr9Qc2tRiEEEaAiSLnhW6DBU1kWH+8EZ1CvVfHt?=
 =?us-ascii?Q?qa2SfL5vOA+JzgfQANo07WujvG/3mDeIIxoPvIB4IliwBrmye+4qiX45igWj?=
 =?us-ascii?Q?0da7cKPXBe2J3m4JHkTaMw+HSWI3bAsnxXwTqcXRgm8jeHE9mzSba4cekQYY?=
 =?us-ascii?Q?9DhjccVW5JlCV+1zcvt2L1c11dAezcOsCGwwAeXHhuD/5VBuemL/24yRUkSD?=
 =?us-ascii?Q?/q+BvcXMJKR2gii/398EE5ToOJERvkElIxWM0xwuiu1OOu6c3iSQCwFMK/jU?=
 =?us-ascii?Q?/GB+DBczbF3PPPKFLvneUeEsvXB/BE0N60J87mYPECSX+vX0NIaytzurgFjJ?=
 =?us-ascii?Q?dWei+bOeg9VanvOHq66BcZXznsNTLUyLOI5+++hIQ+W3qUfHRFcWDLDUR7Tt?=
 =?us-ascii?Q?odAs6ub26BSx8mji0IVGpVZQ78EQTBhrummYpGzKwoCOPGYYuqxxSBat2LaQ?=
 =?us-ascii?Q?UxLPJ0+djRwCnFwHAahBUlUl0u84TfrMXaJJwnL20P/yRYpPTXibrN4Cw8iH?=
 =?us-ascii?Q?5q4SXjKrp8kxtoOO4B+OV9gegasFwTZSQpVtdLTk4t4ElS3w73Q9OD4vtTkm?=
 =?us-ascii?Q?epm7UNP0uKRobHE6OYbLwTRYoL5X8fGTOmxUQ2L9C29oI2lft2FR0g2mOPdl?=
 =?us-ascii?Q?upqjasYDreZdFyo7U3JXlEMgDWs6CqMEKcllSAqO5H1DKfqhKOXGFCRv5oBv?=
 =?us-ascii?Q?eYyn9Anx/lhTf5P738q1MDTBQ1f/r3FW5PtpK9m5mG7hrLkmJ4nwfVPOI8Za?=
 =?us-ascii?Q?ip5LXBjBlnSAOH3Ao1MZvNiIcAgWUCXNF01oE88aPZ4K8Nlt0XOfo1CAQxdW?=
 =?us-ascii?Q?pWqKH+2dbLD1TzFW+MNs9GjMBQ9i0FgpxOEEJBnwlPeBcLdU3iFGpXT4XRNx?=
 =?us-ascii?Q?1xx4HnCw2vPGkMWFXvy1eZQ7R50InDGWeUetd42whuTpnB/PiTeegifXvN04?=
 =?us-ascii?Q?kJWL052BY0Rv2uLleY2+4fV+t7a+0QEidLBE2roqPqlqr33pnjdX/NsTbCxv?=
 =?us-ascii?Q?V89MxvZ+hscXIZigtEBJ+3uVnolog8x0JfHChSNvowQyjJE7poujrwLd6qzs?=
 =?us-ascii?Q?EvPHy0PaxjybhNqNXGVaP2gSUyOrRuLMh5IVR1ZLHvSAvS9czFaxA5lXxgqz?=
 =?us-ascii?Q?Y1jbnaUBg4z2SLtiPqfEJU/1RkLLvXEjH4wugRIhyRg2tKwC7AXedOSH78ZF?=
 =?us-ascii?Q?uBY59/wLuknbpzyAatz33D/hxBvZP9YqV7lyCcD5zudB1Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+f5pFKhqNYQ04JzhI12f1cA6DuySvn7Qa0ZPmbqrijUkWtrNuJkq+jreSfe+?=
 =?us-ascii?Q?vrC0pQkhDKdyrW63XdEr8pXrJFAQHwjBjds+Q7nD1MPj2Yj4vqFg+K3jqqmN?=
 =?us-ascii?Q?KeXLaCZly20wAe9WUN5z6V5dI66KMCOacC/raDd3to+Et6ymt40FjvxwcGtI?=
 =?us-ascii?Q?7WJvRMZDn5NGH+9n5SYXhU04/ExrQNDbJ/iWULNnTMus+Bf44S/l6I17iD11?=
 =?us-ascii?Q?pYDrEPSpjY01HJap6Wd97O0z3mgmpBa6J15svoYUvjeNFNDco1lM67GT7XVb?=
 =?us-ascii?Q?LquVbWZi3OQyDnmOYPut3IGxK4LFCWdBISNwnuaH1dbri94z0dVFMxjKji06?=
 =?us-ascii?Q?gCRUa6hvuhmDdEip07JyeK+phsb556vsdYsJ0TxRlBHWbHhtHFbp8TUA6Az1?=
 =?us-ascii?Q?JSVauvJw+70RMISqEQX4cf2SVUiG99myvA9rf2/836ZPsVQj8YkCzNm0ZZk7?=
 =?us-ascii?Q?8eA3dByFdwEcAfQLEyWRuTJdMtLlfxqFgbyV8dn9u5N0SY3O9SVyZeUOCwKY?=
 =?us-ascii?Q?YIwCZ8kc9y3/YVPm/TevXZ3ntHgoVSRnO5c0HBHCf5LZLALJ2Me0dCMabqG9?=
 =?us-ascii?Q?tm6pjZF4JGJNMA47MBGYrV8ld9QwWE6lggfA9Ne4DAbEHu2WHQ/VuPjvlD/f?=
 =?us-ascii?Q?ox0pQmZexhmzE0nkzKwyfr1/OiSK1+79bUE1bvxQfvK2bftV7ZRHIZXODv8p?=
 =?us-ascii?Q?/eP7d3vlwW1X7NdUnSc6a7ayhE7tk1+v3BlpF1YdBz3GwvQJ4N4ZVw1msxw5?=
 =?us-ascii?Q?F6UCB8I2Twvxg/CHG4bhMACGe7XK+T7RC1Oj9qIX1oncWPGB0E9zBi8ni49u?=
 =?us-ascii?Q?2l2qsCxB1tBfisYlX7tDim2V3rtOD9JGoLe2940lz27DuzE2p/qOBtZDKLvp?=
 =?us-ascii?Q?oYU4RaPzx9L26tUK05KpqCRWtTsakbPnwG8Su4qxzcYfBr89QrdGf24hoUaG?=
 =?us-ascii?Q?RVB2PLWrMSTQUV89W4uuTAAiNtofoJHMawZ1iZrEkVeJ2n7BcRLdM1qQdBKT?=
 =?us-ascii?Q?VvunCC/JYnPmR7d/fovrOKVu/ChSHGzclXSt8eWgmfnwT37q1cRXTTf+mGqv?=
 =?us-ascii?Q?q6cf2ckZ4HwCr4wK1oCpfUI0IoE9sgkTT/rmqQR32NRdaXGmV7Hray9mTAVD?=
 =?us-ascii?Q?NKibLP4fgxtWraO+D0HAqds80Zhzp56fxHcMC5QqoftO+M/867YBxeK1AcbS?=
 =?us-ascii?Q?du4JGVC7vVdeXSD+qCIFpOYZ50tiyOerV8UgbUZo9gqHPSbLQ2kgzw7rNH07?=
 =?us-ascii?Q?9jDKROnV5D1bOJFhX2weCYWpjYLVFl8ptrWir2QMXxAZvcD0LkvqPnt9qEk2?=
 =?us-ascii?Q?0HwUYhTJMNOJcX1lKxzh1iYI5uPOE3RvhLR0Gq4fC7V3vgBjunJpqWdIgmta?=
 =?us-ascii?Q?0yWWLWKMNtr9NYaFcCBxLN3zGZd/GI1y9JBJTj6/QTucgAfXHNbLp6aZJU+1?=
 =?us-ascii?Q?aMSIb0kVscMR428tEhr9bdwA5nkwhJvBqIQ18pdw/O45fI9UoMcoaRsNuaxq?=
 =?us-ascii?Q?VoQvOIySGlPUxQwhPqkzLrNe4ydwxVyCw945JFwPtfdR26/vJ3qrGm3lX20u?=
 =?us-ascii?Q?aJ9sEBAa8EN4rdH56Wvg5YvQ0h4PvUt0Y7sRV9BWaoyAUkE+aXObJEZPPGB4?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e25079-567d-4748-347f-08dce852a9a0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 11:08:11.2070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H0sC0xrpxlpg1vnTXTY/BZgCtYlI0rQ3OpPTILHj6HAs9hs80DVdV75cONjlFOiPlG/OYSk5/H/Kqm4CRdrV8Ka4ikosdYBiil+rQHpC3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3687
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

Simon Glass <sjg@chromium.org> writes:

> On Thu, 3 Oct 2024 at 15:28, Rasmus Villemoes <ravi@prevas.dk> wrote:

>>  common/cyclic.c           |  1 +
>>  include/cyclic.h          | 12 +-----------
>>  include/u-boot/schedule.h | 24 ++++++++++++++++++++++++
>>  3 files changed, 26 insertions(+), 11 deletions(-)
>>  create mode 100644 include/u-boot/schedule.h
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But could it just be include/schedule.h ?

I think the last paragraph in the commit message should answer that:

>> Testing of later patches that explicitly include <schedule.h> when
>> schedule() is used revealed a problem with host tool build on win32,
>> which apparently picked up a host <schedule.h>. To avoid that problem,
>> put the new header in include/u-boot/ and hence make the include
>> statements say <u-boot/schedule.h>.

So I tried that at first, and it worked fine for all my local builds,
but the CI told me it couldn't. I can try to find the old github PR
where I got the CI to tell me this (it's months ago I started doing
this), but I don't know if the azure logs still exist.

Rasmus
