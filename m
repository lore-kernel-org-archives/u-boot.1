Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C6AEFCBD4
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3867E83BC8;
	Mon, 16 Mar 2026 09:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Q2UPrKq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 129C483F53; Mon, 16 Mar 2026 09:22:53 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E2B583BC7
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnXEjp2RVb95n86gkWaPM13i3K7oHM9hqZPnSsPdSSR3z+oQ7dGCI/gF6jDCza/qWFQQKYvABbJtL39fu/mnvbS+MNfKps+0sZOLrMi9OMxKJPzKMgb88/MZzqCd2FzgsRLAtt49mcYMOV3Lc97Yhj+yTOtzGJIuTM3XBTMFgavpJX6ZtIRkGnMhkD+W/k2rBsQ6qiYvm39KLapNn57xGFaex1VD1cYFO1W9vXxExGlaisH3ADWzAru9DLX79K+Gu5Zs0FtfoW21KMZOUfmLdC5fExWs4X/8iSkWV+72+H4zuLqwA6CCADpglo9+QiItpHNJJ/uMgDv/g/Dh2+HKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ggVBpwQiqogI9nDAfz0fRq/uBPfxavpmZTWXOknVvM=;
 b=Rjg+ylpFGcHZa0U6LzA9kPTnMyewCFqrld9ENrZazMkUr912P5Nv/SmVeSanQ8RUK90dBykycVb3jGxhi73Og/5X3O04Ndoza6hXq06ybiBZo6cWrsx2BmxGvUhvetsWhSbibya9Wpydk1cpja5iVdE9/KJkB5nrIwfNXEj+xPNR7vgrHlNvueh+hHgP5CcpTUQ5LALH5Fk1vVr+7OfCgHoeYW8Kk4lp2WrzDESaKy4lYQroW3RiR/65lUU5vE2mxosZOU8W3mduDIm6VhTTsPM0ly0Gn2VY5Cazo6Lb+R9gGqtWjjSJ1s+EmQ3qt+EwOYFDTyN9coIPvnGzFo01sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ggVBpwQiqogI9nDAfz0fRq/uBPfxavpmZTWXOknVvM=;
 b=Q2UPrKq1ZHk3d087JexHgralOJxlj3EGtWSsg94tAGmpjHQa47BNCciEHTDB6nSGZyUtz/ytYqAybfXxb+0T3Gs9UHVZkzNm+PuihxZfmXgFV60v5kE4wbL8O6hX4eICtMKhobQ1iy+iLs+Q5qjIdlAtj9B3mbuWr7Df0eovJ2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU4PR10MB9620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:645::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 08:22:49 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.018; Mon, 16 Mar 2026
 08:22:49 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Anshul Dalal <anshuld@ti.com>
Cc: <u-boot@lists.denx.de>,  Francis Laniel
 <francis.laniel@amarulasolutions.com>,  Harald Seiler <hws@denx.de>,  Tom
 Rini <trini@konsulko.com>
Subject: Re: command negation in modern hush parser
In-Reply-To: <DH0LLC5YYZBT.150TWGKWHGJIE@ti.com> (Anshul Dalal's message of
 "Thu, 12 Mar 2026 12:12:38 +0530")
References: <878qbyr2wg.fsf@prevas.dk> <DH0LLC5YYZBT.150TWGKWHGJIE@ti.com>
Date: Mon, 16 Mar 2026 09:22:47 +0100
Message-ID: <87h5qgp4iw.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00023981.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::37a) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU4PR10MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a81bce-7710-4f2c-5104-08de833535b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: HEUP0UUbCySbF9vhhdrhrNUBycglWWqipZV1gPmGzknV9SIYdZsWAjxK8LngP7YsfM7L8MQRtJDqoanb7kO8d/M7wiUhzaIbe1h77n1lH41qZJL1bxiJ0EYqB+kpO1aBnLwnaGO+IjqlPhDukhhqb7kTD6kpIVDiDnxD3XZXxqmxtaQF/2LOuc/qiyEaTk465tVJfR0TDnZkFGBOs/lKX+GBAdmJLgl16FvSRByJvNRoLvr4kQuYD26/qZLl3MgYCxhpQ3UnDaMAF/X/hI0nZjopH/3qNs5hYTfUCqkTTyokwzUIKgXkeV9Hw6nyFAnXshsTPOajVAgDRXhia9zQvRv0fiNae9mLUqREAOwVGthjYvYOQr+Wqh8X46YGQce44ASmEgOWbhxogsqQOgXJsBxs7qXV8egSRrU6BQvjPqak6MOrwYgdb+J89xGI5hD+azK34CkLlLXDTrpLjb/cSvEGw91wVeBeEjswyxtTmGL2fDE6ty4i3ewRQy6pSmywqnS5fepG4tmp++kY1YdUZoBDdF8QkVBXY7SUf6PcU5UFXnpo3Xa1lxW9RfRCuh/f74SepziDoPOqsHNfCw8kS7rSw9qYwkh8d9kBCTDgj9ibIgAZbYr/l73MPXu//u0opAq9p/2Vd47u8uCF/9tieaoT51KoA8N3exQpRQ5BePzmjQl2GjLaqUmooLDetaYFzEzWLuaAwSuTL5YTcW+iCJOKQKPVLZWAHBqIF+uIp4ee3xFUZ8pHjQS5l14Nc/hAgLV4UJn0B0AVsHqAjZYoJdAbCTmbNMD5rOY97sUOo+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(22082099003)(56012099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZPiIsZ/6rDxJ18UFbpRWIllLPcqqNOJWc4YY+tZeHD4xVL+FWVQOrh8pMCi?=
 =?us-ascii?Q?4zQyu1Wfu9Rhejx1WK5hYWmHLSi8HWpL5Hmg6oSKRZ3hs+K1FHHlkZlhVt2s?=
 =?us-ascii?Q?oChOchi9ogi8/i3PdES9x/jo6VgHkmjrnsksX9bzamvhUhK8YJwFMCPGLV4X?=
 =?us-ascii?Q?je5tKm8E5jYn1Pw9CD3YiliaJign3JXkdIvVP5tEP7od4V7VNyDi/TG/Kyx8?=
 =?us-ascii?Q?qb4lC56tA/2jZ8YaLLdnDqUrK3VHkMyhpldGUEsTeVd7DQXUhoxCfJbr9B7R?=
 =?us-ascii?Q?Aab3n7EHqDbKWXeXb8aKSUbZUaCRVSnIHZ1C911edRA2CeRyYq/UoUoP+Fhp?=
 =?us-ascii?Q?mnnTrNbhAOl+lvoOfeie2x5Xa0U/639T9mTfvK5UBRWF3PYdQYE01SjURq5f?=
 =?us-ascii?Q?AfnttQlBjdybTIKYdxUeW5qX+j/F7VCgSF4ct5BZfvBPCBHyEMDMY17OClkb?=
 =?us-ascii?Q?fpW2BDtVgQ1mD4QE7vBFgzYrU1C/0s0qbxe8Rt3ylysPOfVWnGMKiHK2qcfp?=
 =?us-ascii?Q?R+Z8wlLEZxBmT5gLS6cTN7589o12Sp5IoEMe+uMbSJiFdus0sm4mH3S5SWC5?=
 =?us-ascii?Q?8bAZRPs3jDWi/PL9Q0OI6FC4cNoy+5ICZauPlMC5sTJLBBQjOIileZCNVLog?=
 =?us-ascii?Q?8iO4gB1+YdkQR6yr86/YTFV7koZQEFY2uDkQqdR5wkMGcwpc73nHA10rK7yN?=
 =?us-ascii?Q?LN6jvDivv/JHsVus8ZGwtHN9js612DiRViyTTehWzKMaqeYOOd5rWWYMxjly?=
 =?us-ascii?Q?8mEJ2s/++84mMLXfoLyQNUHxAXga78Ih7LZDeRHM1gu3RHWOeVcKruRMBcIS?=
 =?us-ascii?Q?dsTyIGQ+2BJ8cy/44JvkeUitW0+/DzERY7X4pkmjjI41vX/J/sZhCTS/Ls6F?=
 =?us-ascii?Q?vj91OFfpeTXV45JuSoWkEW+K9KACr/9Hf0ZYtvjXbDTq6+dY+LGNIoxi4B42?=
 =?us-ascii?Q?uSTObqDauzcWnPqevEqP4pFJE9MUunui6/ByV9AT/6lfjjmmUONHgy3ngcyM?=
 =?us-ascii?Q?2FeON10GExq79hP51FGwhi8pGuLzYKT55/b8eRE2bI/pu1StyF2viydwjj/F?=
 =?us-ascii?Q?EGndF4Js124S22L72k4bFjMUyVA4icMJMvSWO2weUG7bd9kgmkn1DFlh0wdk?=
 =?us-ascii?Q?p8tAS5qLi7Itw1zD2QObJrddKuiX7j7wvEGWeYsK4t7H2usz4VAEb6/us/AW?=
 =?us-ascii?Q?PdIZW044gmPYSLMMOgo75mHkt5hrGGkUGePRk6E5anR4B6i9PJb7oha1IEcf?=
 =?us-ascii?Q?hQm5Zgs14CG7ugiDwT3IIbZlFddkmKZbozFeNwDI0ifr7dTjmyeg+DUGupLL?=
 =?us-ascii?Q?0hOzXyQw9oP/y/HMO/Y4QSABz/OEGHcfdYU4O6soQz3l8G4aYtX/uOcVZuCL?=
 =?us-ascii?Q?USpmjChJzhavQftIZrNVrCBtULeRzSNxjPavoJnFW4I4MqIC20exiVJjI/PD?=
 =?us-ascii?Q?gtioN2PWohmAAD5YG9xbKVkKuJZ9YPmfk4f1Su96z9c03lNoH0C6MhrpcNjA?=
 =?us-ascii?Q?Mj2BTrJ6vkb2oEqIhjTJV0EYTUi6XGJelDME3ZCsE+rleM7W1bUg8Q8FPBzf?=
 =?us-ascii?Q?hWMYPZUQFPTTWkeFJ/ODKRSqEfo4QAF2eLzJaSEFrdr81D5+KrGfZEsDsAns?=
 =?us-ascii?Q?73lyhzlku4TnD5N0/c3rx6SfgPQ3qUCHeTSTq/aCm/0JfAk+JYdNlpspuJ+V?=
 =?us-ascii?Q?brwDf4MNFg5nC+qyUCIuALqtO1atYmt0wQ/4x/tw7VrCJWfJpHiMrrPmCR6J?=
 =?us-ascii?Q?gXvSjhDTFLdU8z6AVZ8rBeDv/xyGI+4=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a81bce-7710-4f2c-5104-08de833535b9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:22:49.2834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PxFjuss6OkVbtvRbGkrPGaGxOJeQNlQy7by7vRJeZawybXkHQzeXcpyUyfaSYz5TaHIVPhDUHW8w4aX7nbg8lfOqzIvwIkCcoczlE8KMSlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9620
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

On Thu, Mar 12 2026, Anshul Dalal <anshuld@ti.com> wrote:

> On Wed Mar 11, 2026 at 5:31 PM IST, Rasmus Villemoes wrote:
>>
>> => cli set modern
>>
>> => ! false
>> => echo $?
>> 1
>> => ! true
>> => echo $?
>> 0
>
> I was able to reproduce the issue and it looks like we might have missed
> reverting the return code based on pi->pi_inverted inside run_pipe in
> the one of the cases. The following diff fixes the issue for me:
>
> 	diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
> 	index 748ef60ac90..c01ba00e475 100644
> 	--- a/common/cli_hush_upstream.c
> 	+++ b/common/cli_hush_upstream.c
> 	@@ -10377,6 +10377,7 @@ static NOINLINE int run_pipe(struct pipe *pi)
> 		debug_printf_exec("run_pipe return -1 (%u children started)\n", pi->alive_cmds);
> 		return -1;
> 	 #else /* __U_BOOT__ */
> 	+       IF_HAS_KEYWORDS(if (pi->pi_inverted) rcode = !rcode;)
> 		debug_printf_exec("run_pipe return %d\n", rcode);
> 		return rcode;
> 	 #endif /* __U_BOOT__ */

Indeed, that seems to fix it, at least for the tests I could think of
throwing at it.

Will you send a proper patch?

Thanks,
Rasmus
