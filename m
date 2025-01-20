Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EF5C02185
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 09:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20F4806DC;
	Mon, 20 Jan 2025 10:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="LIc5kRBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D21806DE; Mon, 20 Jan 2025 10:17:48 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA05580077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck5KDAEe1pQXcTmQECM3kEewy3aq7E6isapprFDWus/tO8eGkXJSLlZEz/gOhehMiNEOt4tmEhXqAEOagQm/E+E4yj0WDHjF/ZuOwG2K30pLBBO6cUUGJDMM6V3M6l3dNdqkU0mRGqGMgcwzUw5TlBo76h2tfkF3tUGBEzX0nk21f8NQseIjz9H6lXum0VSTO7G0gIJdtrQ9/idwfd5slYy2wCGA/Cg0h1xpzqL+ydvpaeqOOo2uy5TahpImfdsNP92dWfexgVBfrifkaO1rCnGLd6aBJSRF1fs7TuTq+0UNm8lx5CkmEnJm14l2pArJeFjWCaIxQ8adHpGmYhsTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=firUrhEgFh4JigWKuzeVaCeWqeovbonVoiGHZcqB0yo=;
 b=ePCLzc/1YbhozCFEApZ6Syig+Q0wIwlbqr056D6bjt1JzleVXz3HjVvM+d8ik88mxlAhqo1sFcN+xGPgXie7kHjkGSDoOxxcGTgRpsHTvP0gwASJO+0MNZSSpc2ZVJBvOJHZEupBAbd/oKxCysSNZLhp353ahlgId3UU8S9mB9rqBnq8sRUN1cIL7ZTPjZ/E91uetT2T9Ot64tgBMxiWiEdReu7h0gjtRqygMGbJXBx1/Jt5Lbp5cSHeVg6rIs91hKaDYNe2yhk5ESwKTPCbbvOknFjpWVbZR5tZKlRCDW51uxzpTPcg3Q7p0nUHf19s67zj7+JM1gk++cL4PfMpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=firUrhEgFh4JigWKuzeVaCeWqeovbonVoiGHZcqB0yo=;
 b=LIc5kRBdoNo2gAzYvWYxS0epzjKVKDjU2smJftPaPQbmS3UdNGe+dYpeeyEBj324/rTA3ugwpB1nVeADllkb+s2pi4sbuIsst0HY49ENIzk23djgjvi+wndJulepcyb7W2Q1YWJeOsi5EANXdNzD1X0kv31s5WrnX/C8xHwodak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DUZPR10MB8189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.14; Mon, 20 Jan
 2025 09:17:43 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%7]) with mapi id 15.20.8377.004; Mon, 20 Jan 2025
 09:17:43 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,  Aaron Williams <awilliams@marvell.com>,  Anatolij
 Gustschin <agust@denx.de>,  Angelo Dureghello <angelo@kernel-space.org>,
 Christian Marangi <ansuelsmth@gmail.com>,  Devarsh Thakkar
 <devarsht@ti.com>,  Heinrich Schuchardt <xypron.glpk@gmx.de>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Michael Polyntsov
 <michael.polyntsov@iopsys.eu>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Nikhil M Jain <n-jain1@ti.com>,  Peng Fan
 <peng.fan@nxp.com>,  Peter Robinson <pbrobinson@gmail.com>,  Ronald Wahl
 <ronald.wahl@legrand.com>,  Simon Glass <sjg@chromium.org>,  Stefan Roese
 <sr@denx.de>,  Tim Harvey <tharvey@gateworks.com>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/8] cyclic: Prevent corruption of cyclic list on
 reassignment
In-Reply-To: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org> (Marek
 Vasut's message of "Sat, 18 Jan 2025 05:00:55 +0100")
References: <20250118040130.74921-1-marek.vasut+renesas@mailbox.org>
Date: Mon, 20 Jan 2025 10:17:41 +0100
Message-ID: <87cyghx2ru.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::30) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DUZPR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: f76cc334-f1da-4810-06a6-08dd39334b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RNOgxkBsISeOKLPfsVbKnrPoDJa5MrurM57kouSNydIB2IC5ncQdm/qN/L3Y?=
 =?us-ascii?Q?i2FSqAQcc5f+4XsV/JWZNUE5bMrcwdAryKGGriuMopZ7HLmuB1PDR7hB+4Nv?=
 =?us-ascii?Q?HSypgknNmD42AmvSG1z94+ycjlvjej4reB+iwT9+S+/8qMp0wHrebofBxxuH?=
 =?us-ascii?Q?C7i+inVTvYQ5UztYVubHET4gZaRz4tu1j/L0Gqxvo77wTKaqXXW9uMmsd6CT?=
 =?us-ascii?Q?mDguxxM4BtfOfZHMDW6yO1eQLBowVOmAGQ0Ky613JuZecE9Sw1RvZCFOlcna?=
 =?us-ascii?Q?LAGRuLYBMl6ePUt9PoHCWy0qQP6wyMRJn62gs7tvlNCLOI1o+qRwxNfDfhxQ?=
 =?us-ascii?Q?1Yym1VkbjozYWfWP6STTXdmgeiPeUM7RRztyfWF+ilWhT9cI6pdkWwvJOxau?=
 =?us-ascii?Q?kzjF1hdL8PCTRCnDvTD85vileDAOU8kaERwLYmeuTgnuDiaxW40LrutXWHQ2?=
 =?us-ascii?Q?hJ+HaeFeTwgetGUOQ1CwY2PJ/8R9DK6bBWyavu3BmS98u2w6lppFxMgcXAsz?=
 =?us-ascii?Q?T/TIyKJx5tm+vGEe4nj+yB+OBAq+0lfUSojyIkRnFbDiLHYCpT2Q5tp9rEK1?=
 =?us-ascii?Q?IT8QzfDmlZObwlECeJ8evHqtxPNkPnAYF3AE5+CXuMCkxPTU/uRvwvxdN7nl?=
 =?us-ascii?Q?J5HgF8d4u4urMFbmPPFxXc1QbQPYk03VFfWuY97Y6Bi0JaTGp45hLR0X67OP?=
 =?us-ascii?Q?FLEm8BUc8pC3IbeolZh/2lBFu6BotpqTFh+w7VWojcd98Wg4TAr9g375DfSj?=
 =?us-ascii?Q?EFjfSc0cbWqgIdBxkQxSZVQl0N34WRquxkrvbpr4+zLzL45NbRAEc38nEPiw?=
 =?us-ascii?Q?KloR5fc1T4G36UjPcQn4o5uzvb15wg21EFxlxV8Fw5HnoGOHLp9wA+KXefRe?=
 =?us-ascii?Q?/O/J0bXWK8hK0uy/duXoN/2Ddaa340r2Pl/7VVfV0HZMfXo8mmFHoFbL/hFw?=
 =?us-ascii?Q?tSIKmGJofTO/Ncaej4tV9CO1A9BKfL5Rzf4Wq2uAmOijS8rTtmmqN9byT7Wu?=
 =?us-ascii?Q?qFaOgVpyMbDLN6qWvmiU0DZ18tifdGS3UTmhzFG1oFd/j8ccKVN2WaHIxHT8?=
 =?us-ascii?Q?IPbAiQcjtz52btZe5rUf9ad2f9A4iMLhHXLXcL7IkeV1pOHCFClnFZZ6FDAU?=
 =?us-ascii?Q?OLvjD8XNWxaffg44oK5vFZhIRbdam3YkjVG/goXFg0YK7DDItgfnMhAXTpIB?=
 =?us-ascii?Q?h2YTeqSN6SJitTlrGB9F1/h7oss3+67M7gfxYJGKpXGozPu7D31f8wdyoUod?=
 =?us-ascii?Q?YqDXjKEVPH6tnEzwrsOdNHG4D+edISYGfVnbwtr6N6APOvxgbgkJoAZaQ97B?=
 =?us-ascii?Q?uKQCHAL0FNH7q+OXO4CtviakdQvmQsflAeEQ3/marLlZLzHh0G5TRsq260Wm?=
 =?us-ascii?Q?i4Hiw79bvxshPe+IzKbeQmroxy9z4OZJZbUxR0mmmwIcanKFImYPB3uSJJP2?=
 =?us-ascii?Q?h2QqgplJkJZDcg5ypyN2tzYI1qFkACdk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54gguFVxn6mtoUNwqBof5ydclkeFkggZYjPktVlRp5iap70EVRhOChpWrvgB?=
 =?us-ascii?Q?2S6pgS2/ySvysxggzvtRKSVN6qr8Y9+FWodKLT2nJGLMs/U+9bnQy3bLFqgV?=
 =?us-ascii?Q?U8yHP1ARTUKn2IwQM8GtGPgZErZ/DmFE6jYgawxPaKVrcF/xva+EuxevgfOO?=
 =?us-ascii?Q?z9tzgkN4woR1fFcuyoVX1ZKQYqEunZ01dePT/tojWNYosZYmtaPHvEHJA1VX?=
 =?us-ascii?Q?1lEL8upBszygFQyMcGRoK9/FkYfySXaa5dB2H48uIa/WkoTgQY57FlXGzTyM?=
 =?us-ascii?Q?kAbS3vQ31Vmn1ew2AdM+u82Jk0zOBdS4Xc/snWhZLVKRWT4Pt2+nD/mpD8Dt?=
 =?us-ascii?Q?fNQN9mPUDA82Gk3ZTBpY731qbZpIW0qpK1yUek3fTZeeQsr3nP28/gAR6Tlm?=
 =?us-ascii?Q?BLZ8o+dvkwLsYnRGInkC+pnc7S1K+J3eYpNoEkLTsGkjdR8mThkZbQuDrWco?=
 =?us-ascii?Q?7BGOGDK8oYdc6jT3PUW4KVjCnVtNuIbzI/a+UvxmFiGnhJi9eQL6HT/FoCro?=
 =?us-ascii?Q?5o5uo5F5IAmgcOcU7QT6tRMGIfIe/FrC+f7HlVcABOiqSyKFXfD48fjGXOIi?=
 =?us-ascii?Q?vNMAq+HhYQTOE32tmpvAWGgE8C0XxEqDNuykEBrwIWzxX9Vd47AfqHMHRF8a?=
 =?us-ascii?Q?0H+m8SXtAs0ghSzAe/SntIMv4J3/xJWYcHEAqTQ+/1IqswEiAo2U4qXbAnOZ?=
 =?us-ascii?Q?kvGSmRoyzxYHhmjQpnOOoaGo91rv/mOlZUVe5HWu0Dqp+HqQOqHyBPB4vTh7?=
 =?us-ascii?Q?QzIgpGV2pXfdoeR05JayM4N8WA0cU4l2P8QkzR6WuAkSZM3CC8CCr8N8sQtq?=
 =?us-ascii?Q?6OCs5OTdWwmCI3I0D4QZT2EVCwN6Wd2FryHERMRpgWihEvUWCAEN7UDdlnZ1?=
 =?us-ascii?Q?QFwcJOCaDYeCLRHhwj/F+CcFM0khbi58VMKMS4BaUxobZFyPpYgX5od0+UdX?=
 =?us-ascii?Q?1DPWfrmKtW1Fk8W+Hq6XrZQH9xMLdrxHnolITXL0Kk4SaEz0HVEpC42xx6vt?=
 =?us-ascii?Q?6FLH+KBiUOC5uvh0pBdklMP2w+OjvxAgKKF3g3sy/4LZ1u42zuecWt0d9DCb?=
 =?us-ascii?Q?t5W4uJ8gvFw1Xjr05tQHPZm7mT/G7A69YhjwN7mKP9BLDPL5HOCo8gyzN0Rh?=
 =?us-ascii?Q?gRHDP67X9H62HjCxyyoy++9SkMF/CVJdUb3hFOAOOuVIExd8wnjnS+/DJHb+?=
 =?us-ascii?Q?+TPDc9Pr+Ymb6rUDKpd7/M13ny4DW2DcNoeH95DNArDKIk8u9ZCj+WSymWRX?=
 =?us-ascii?Q?OWc1lijRsMuNCZe1i/mvb4wNi0BopaO7rp8YbtW/lzI976B2AKoeH3CNEYwg?=
 =?us-ascii?Q?o6Mx1jVNSRg1NpuBsM6D4TohWLhXUTkT8qYvfnA/tjU1eXo3BD1aadQp6AzU?=
 =?us-ascii?Q?hRSPe0IrgUxdX0o58WQdL5wYbllcXNd2Lw0JE5S6K5ZQNFdGYCVP10r5/aXW?=
 =?us-ascii?Q?bSjwe90Dxcgb4q3y99ruoK1fy7K7HhT/jsrxr1J7iEWCCjU/3h7+AFRLKf/Y?=
 =?us-ascii?Q?HoYiLeevjyM9YWQGKiUvvSoXO9WKODblxPKrEOysfG6IQ3mjOXqrXeLCLxVc?=
 =?us-ascii?Q?9NtIcsbadl2VPRVANP82wEEWiPocEuMqeGQoqw6v81dNjltaLjZltDhb6ZIE?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f76cc334-f1da-4810-06a6-08dd39334b91
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 09:17:43.2427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaDvHiXJkR69DIUgVffMSn2yl2HC278mF0NIWwkRAtLXlYztgQGpm5ivGUfkbH3NI1myxP0FdxK3zKS/Wsf0+dw6Sl5X9UwxAF0gLEwEECo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8189
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

On Sat, Jan 18 2025, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Make cyclic_register() return error code, 0 in case of success,
> -EALREADY in case the called attempts to re-register already
> registered struct cyclic_info. The re-registration would lead
> to corruption of gd->cyclic_list because the re-registration
> would memset() one of its nodes, prevent that. Unregister only
> initialized struct cyclic_info.

I had considered something like this, but I don't like it, because it
relies on the cyclic structure (or more likely whatever structure it is
embedded in) being initially zero-initialized. And if the caller doesn't
know whether the cyclic_info is already registered or not, he can't do a
memset() of it.

So my preference would be that we instead simply iterate the current
list to see if the struct cyclic_info is already registered that
way. Also, I think I'd prefer if double cyclic_register() is allowed and
always succeeds; this could be used to change the period of an already
registered instance, for example. Also, that avoids making the
interfaces fallible.

And cyclic_unregister() could similarly just check
whether the passed pointer is already on the list, and be a no-op in
case it's not. Those extra list traversals are not expensive (we're
traversing them thousands of times per second anyway in cyclic_run), and
I doubt one would ever has more than about 10 items on the list.

IOW, I'd suggest adding an internal

bool cyclic_is_registered(struct cyclic_info *info)
{
  struct cyclic_info *c;
  hlist_for_each(...) if (c == info) return true;
  return false;
}

add

  if (!cyclic_is_registered(c))
    return;

to cyclic_unregister(), and have cyclic_register() unconditionally start
by a

  cyclic_unregister(c);

and then proceed to initialize it as it does currently. No other
changes, apart from documentation, would be needed.
    


>  common/cyclic.c  | 14 +++++++++++---
>  include/cyclic.h |  9 ++++++---
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/common/cyclic.c b/common/cyclic.c
> index 196797fd61e..53156a704cc 100644
> --- a/common/cyclic.c
> +++ b/common/cyclic.c
> @@ -27,9 +27,13 @@ struct hlist_head *cyclic_get_list(void)
>  	return (struct hlist_head *)&gd->cyclic_list;
>  }
>  
> -void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> -		     uint64_t delay_us, const char *name)
> +int cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
> +		    uint64_t delay_us, const char *name)
>  {
> +	/* Reassignment of function would corrupt cyclic list, exit */
> +	if (cyclic->func)
> +		return -EALREADY;
> +
>  	memset(cyclic, 0, sizeof(*cyclic));
>  
>  	/* Store values in struct */
> @@ -38,11 +42,15 @@ void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
>  	cyclic->delay_us = delay_us;
>  	cyclic->start_time_us = timer_get_us();
>  	hlist_add_head(&cyclic->list, cyclic_get_list());
> +
> +	return 0;
>  }
>  
>  void cyclic_unregister(struct cyclic_info *cyclic)
>  {
> -	hlist_del(&cyclic->list);
> +	/* Unregister only initialized struct cyclic_info */
> +	if (cyclic->func)
> +		hlist_del(&cyclic->list);
>  }

So this already shows how error prone this approach is. You are not
clearing cyclic->func, so if the caller subsequently tries to register
that struct again, he would get -EALREADY, while a subsequent unregister
could would lead to exactly the list corruption you want to avoid.

And unless the caller immediately himself clears ->func, other code in
the client cannot rely on ->func being NULL or not as a proxy for
whether the struct is already registered (and the caller shouldn't do
either of those things, as the struct cyclic_info should be considered
opaque).

Rasmus

