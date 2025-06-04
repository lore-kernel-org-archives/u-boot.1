Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C30C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 20:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F88805D7;
	Wed,  4 Jun 2025 22:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="j/nyYKAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DAF28070C; Wed,  4 Jun 2025 22:19:48 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CB4801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 22:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Im7OHhco/bEU79aF+YFRjUvE924++11tOacGqoQ5NPCBwb4dY1es/eLFzCYA2biYZYhQyJz7r++jDuHPwnXfNbQWLRwJM4/KE5GLl4nHVYQjVIyipGLusAIBRFLRztMR7w7VVa4eo3CEM+WobLH8sny3QOHkJUSIKRkUehHlc6ZfisRyYGYf8EITlzmmqo2JlmuoAjsgB+26tjrTMvL4QxDydw12JjfjGE+DZgjq5RGHMRqPkZrQsJHEppBsB6/ehsxHHv7BmldM6WbfZ1xMRjIIB1DyGnWnXBNAayBFqjzztiPg/ttItnE4G2ZvIvAvBh2ZpxUaaMOxl6J/c/u0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BufcdYs8scLOkdTd+4sgMoReWamqvJH5z/+/U1509r4=;
 b=d8vK5amMvra793dDv+W71kdtb91V0dFfrceqguRy0X8MKReUPD7K+E8y2aC4tEPv+IYL3ApBg7P1WqbrqgVOTYuH39ve8Wsfzl4+lsqtWQAM2DQgMBTUccYcy8A/SK7w4V31M9pFCg5CGyoihcRTaC+s/JbrSygx9RGfwuXnu7XILQm5AMdgoC2rJpwgGebeGXyNNixwQU1Y9Vq2CLUc08DlwGoh2pOsBH678R0CmVg7j2fuzDjuDWybjlkIA1JY9xMIopEM8SuexxjgnpavjlrOUtRIvfeWnKFGVs8P9Pm6yMy4meMkme0T+8aib43qvlBHxDWF/jlBe1w3N2cPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BufcdYs8scLOkdTd+4sgMoReWamqvJH5z/+/U1509r4=;
 b=j/nyYKAGlWESOdLXG9UoowFz2YP83jwY0EOt4ahhXfH8mW/bhuE/Ktrflt4aTUUCh4HnBliyRdG2wzxY0HY+yIwdc0k8EsdZ9U2ah0RtuV/PTlj03sX1UbDobiwLetrqMhbMrUQPsEOM3vUu02O7DdrHGz/AnOWbr0248RycsS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB7381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:447::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 20:19:43 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 20:19:43 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] mkimage: do a rough estimate for the size needed for
 hashes/signatures
In-Reply-To: <20250604142510.GA1922573@bill-the-cat> (Tom Rini's message of
 "Wed, 4 Jun 2025 08:25:10 -0600")
References: <20250516125430.1361912-1-ravi@prevas.dk>
 <20250604142510.GA1922573@bill-the-cat>
Date: Wed, 04 Jun 2025 22:19:41 +0200
Message-ID: <87qzzz1cpu.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 03a87fd9-6515-4370-c0ed-08dda3a52441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5WNpA+DyT42RZQJH9fsM+QVzTbG5J6odcl36XRVxXtbMHgFw9gTgqgWYANtA?=
 =?us-ascii?Q?625nB2UGm/XqLa7SwvkAVfJB2SpczlIRg17TZPCfQV7Dh3NBMVvGzAZf5Z4h?=
 =?us-ascii?Q?pX4MEXPddhTx45xlPNo+BRBQkw81CGpu+ph1p3ln6XLvvDi8s9WZejhMnyMZ?=
 =?us-ascii?Q?jdEOYJHQjgJU55Ur3SGxsrPN0vzMpvJHPRkrRlkFOYvBQ1vMpEzq5nxhCXGR?=
 =?us-ascii?Q?xjLsnJ1GkZTziRstSP1E/m88OvmcB1QN5DdQeWx3AXFSBSZ9iGuuLADuxQUm?=
 =?us-ascii?Q?MtvS5XB5lcQ0u2u0TBcDlKKdHyPFfwETbx0ChQ6rocAXxkym6XMNJVfK1mkD?=
 =?us-ascii?Q?p4khx9CuujOOQoKUciQg2U0t6x3ZlJuSCqwZP9qidaRjRxDF3h76eKxrUtOA?=
 =?us-ascii?Q?QvYR4RHrKyEXqsmAAV8dT79AbM1v5hpUEMjunqpwhSq7uP1c5iAvi9MgnBBp?=
 =?us-ascii?Q?rpjQY2ZEh6Mxww9jymZiOTl72tMxepZ7w7dPnJfLr+CRKz0aPJksTzn3Gpdf?=
 =?us-ascii?Q?i4KLS7xTjyOlRLjsIjhkIg079qJ+oiNCYDTUL1Cv8omQc/UF5V+UIk5KUyNl?=
 =?us-ascii?Q?KBe1mnzieSD36ABGa06M82SjGOoVmPU+RSkzlwILkFZMFqlVB08TOyyUwO61?=
 =?us-ascii?Q?ha8wbsumlpOZmmZxMWspSI4otnuoHpElzvKLad4SAoa3Lm2RkBlONa+6D1j5?=
 =?us-ascii?Q?nZ/GJRYCMMZ/oUbAo7tLekqvu63cfzCk9wC+Te+pSFDmjLxSGtuCeOboSNYI?=
 =?us-ascii?Q?s7C43JczId4X6uqWHToAImCoydsTnY6zOVx1krVkpX7XFglBx7R04+PNel0z?=
 =?us-ascii?Q?6R6sn1ZtjNt2yPM8UeJpRx7S/NZuM+j+Gktbsenu2GGySd41Vi3slzndH/5n?=
 =?us-ascii?Q?pKbW5xvw0D0Y5YaHN08jbrw/cCuVSRPgz3eMKBdmDYu6H331IBCviTDterYn?=
 =?us-ascii?Q?HP1zcpmLSFKzXTBinCxOmDwOIuxU6334iJIcU73QV+8DwM0BdWE2s3KKOxTc?=
 =?us-ascii?Q?aKzMLy/3jjxArk4el3kjXhT/KIgfjG+11/VxJ1FN3Fz0eggx19sc1+duq14q?=
 =?us-ascii?Q?S59ed+9F5LWmLjkiF+qQ+WlW1mmW8s1OrAnyiJh5MlKjBBwRGNtWMZTGVTSw?=
 =?us-ascii?Q?rQhGqkCwhImR5OoR0GmikTLDQ+NeF8u6XVEWj9xgqHOqcXOQn5TvM48AHgKU?=
 =?us-ascii?Q?4Rsf6ODs2vUfEQE8XUFSiVNlC6365lZQfBMCaPZXXPCNrgZpeLRD7AANkkVT?=
 =?us-ascii?Q?yY8pg/AiPtWaUa/2ZTJ+t6+ZqGFvt5+ug6dcVTuBSkDvgEdShYBq8JtGZyCY?=
 =?us-ascii?Q?2W+ABktVM4/9FQryRyPehzhvSUEPsRkJBrykOs0g6Rx00IzE0vrnjdkgzs0I?=
 =?us-ascii?Q?/CBhX/njg9o3G/cXH3x+rtxvfkMmGGXccrWp4i6unouQ4htyT47+UpKUhVir?=
 =?us-ascii?Q?YZWFJYHmIEo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OfeUXXK1x4cgVw0B5ERVRmcfWO6LeoALzG9MeStqMQ3x8cArinCxCsH+CSPh?=
 =?us-ascii?Q?I4TSBftxEEx9H69kAXndjb3+/XnFSqX2TdIuxOK6xBI+sr3V4qHGMafqpc4r?=
 =?us-ascii?Q?wZLp1nLb44aB/XV/aOjzI3WXYcl89yImp589LlaDiJucdPWEI/XJpqi9Px1K?=
 =?us-ascii?Q?DeyxW6hw/bfmIS0NL9JIXCV462HbUb87PlqxXStmQVq+mA7Pl+EBQWOBG5eZ?=
 =?us-ascii?Q?smfx9DO6cToKL519O1Q4vJZNi69Qzlg4HlTbcYUf5JtBT9TvjaVWGwAyHJYQ?=
 =?us-ascii?Q?Bv9rACGbe9CWdKD8TDRD+2P7kAzP+9azhambOP8S6dTXxl3h8ax5SvUhJRMu?=
 =?us-ascii?Q?PoKVcZ/I3yIUD/srPXfZDhmsibadrcO7bub9MbKsYUVdbmkjly9KC1iGnDGA?=
 =?us-ascii?Q?wkfAxXtML5duE6MY47GPUs8SbGHd9cvmRjuA7ZrZcUtZyARaw5s3wKyTSx1O?=
 =?us-ascii?Q?ROT//P8LzJlck+RSEaBUWLW4Evry0Li+C3t7la68JpqtQ0EsP8Y1c+ZSotSP?=
 =?us-ascii?Q?RWWFtMuqPow5iARzxjY+40/2e9Mt37UWUgCwPBW75o03jVOXRPsGXARXOOsU?=
 =?us-ascii?Q?IZqppyIs7zTP+DtKC7MT88BwLMvw1OlOTDaZEGobmatri9KsrSq9g5x0XLmV?=
 =?us-ascii?Q?7+l9sH6QDfyx1R4BbT9NDjnyKQjheWFXxsNfgkPsAnNJID3brayOjt/DgWf1?=
 =?us-ascii?Q?ueNtMplHJunf5xTV/2kRTOVml50WM6sh7GX3YglnJbb63vQtgc88ZkHtjNQc?=
 =?us-ascii?Q?kxvVLG3v3IEOuhCBitNW8KopCpLsUL1gTkYwZ6xS7HnYeehqhwoAm5omojXi?=
 =?us-ascii?Q?GIEvRX5QuJVAXLowkOvsQ6s6RHA8mvDSm9ymod2s9sVjluBlZANAzRoZ5q9I?=
 =?us-ascii?Q?FOSf+m8TCJ6EHtL35hUJRBpT/KycUn07NUEIVS4rAZU9pbZpciG3q1maSwF2?=
 =?us-ascii?Q?l7E8A/PqCVxJqcOkj4iVAlprwT0fjIaDOVPZH3XnvCPvvti28BnIW3tToe6M?=
 =?us-ascii?Q?a96xHaAaT43z8VwsLWaUKxPVrQrHUpsuuEfaSFiwHeLH0OkGKpCkOEODs8UF?=
 =?us-ascii?Q?7Y5ByyVA9PBKiiRMqCde4Iw40t0xvBObhrrTuEM3taQohSbCT8M48ZkL2u5S?=
 =?us-ascii?Q?AaN1Diq7nXgRFV6e/tL4bPW2u7K1xyd/3TPMtrUsj+HCwTo5tpmu4JH++oDZ?=
 =?us-ascii?Q?byYAQUC4Lip/GLpCJ7eduPETowOkk+wLiU7RFJ0tRur/UaMgC3amrXkUWXsd?=
 =?us-ascii?Q?dyXM0eyd3Ygbnfu5rHL5Z0PyjuL4L6EJQhb00VPGgyfU/cVONkpHm0+DoH7F?=
 =?us-ascii?Q?9iGluETsE8gwEQO4hwQRd640uBuaarqreSmNt6tDBDQ7R0Od/H9dYl8vzplL?=
 =?us-ascii?Q?7I5XD5oYG9SAmQiR6MQqgb8PhfAk1JddBbbIPY50cV2q22MduhCwItAuhWag?=
 =?us-ascii?Q?WBHS0O1W26AdEdhuQ0YR8d5rtRBJdlRhSp8qos3B/PGCKsT48ui4XCnu7ooh?=
 =?us-ascii?Q?Kik6+ZKFizYXxhLx2ri2Y+R5LQ+Rm8KNgAbLlONfojFJJXP7SWYk7vy/T6Fq?=
 =?us-ascii?Q?cqqanyfd4RhSZRIy2y8qNto0cZ2ty9Ik9ckPmayjlVSIdfT0L72qDzdSMo5V?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a87fd9-6515-4370-c0ed-08dda3a52441
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 20:19:43.1203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWwG6g2G/UQuu1iW2mZLX84YnUBW0TcQLn+7++M/h9qSD/QC/7EQvOLctQ2/nEjqBUPS8lNSQg6KLSrZBXy16gLJQgpVR0u7eewALeFrzxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7381
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

On Wed, Jun 04 2025, Tom Rini <trini@konsulko.com> wrote:

> On Fri, May 16, 2025 at 02:54:30PM +0200, Rasmus Villemoes wrote:
>
>> 
>> While not perfect, we can give a reasonable estimate of an upper bound
>> on the necessary extra size by simply counting the number of hash and
>> signature nodes in the FIT image.
>> 
>> As indicated in the comments, one could probably make it even more
>> precise, and if there would ever be signatures larger than 512 bytes,
>> probably one would have to do that. But this works well enough in
>> practice for now, and is in fact an improvement in the normal case:
>> Currently, starting with size_inc of 0 is guaranteed to fail, so we
>> always enter the loop at least twice, even when not doing any signing
>> but merely filling hash values.
>> 
>> Just in case I've missed anything, keep the loop incrementing 1024
>> bytes at a time, and also, in case the estimate turns out to be over
>> 64K, ensure that we do at least one attempt by changing to a do-while
>> loop.
>> 
>> ---
>>  tools/fit_image.c | 80 +++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 70 insertions(+), 10 deletions(-)
>
> I think some tests need to be updated now:
> https://source.denx.de/u-boot/u-boot/-/jobs/1156824

Hm, yes.

I don't like blindly just updating such numbers so they match, but in
this case I think I can at least explain the delta: The fit image
described in 161_fit.dts has four hash nodes, so with my estimate we
first try with an increment of 4*128=512, while previously we'd first
try 0 and then 1024. Since 512 is enough, the fit image ends up 512
bytes smaller, and that is exactly the delta seen in fit:size and the
other numbers affected by that.

Should I fold in those changes and resend, or is a separate followup
patch better/ok?

Rasmus
