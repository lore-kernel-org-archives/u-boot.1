Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA77CFA776
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C516188387;
	Fri,  4 Oct 2024 14:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="BaiY5nz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CE489012; Fri,  4 Oct 2024 09:50:52 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6867888CD1
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 09:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVL8CW+XKLm/zARyNsbhcYQNFsSn0YSZ8H5bvoGogXPk4imA2eJJKm4OQ3Kt0nhWzzmjPlkChggWU6VX7XZwoOKLHYAS+5BjzXi5M9KBsQT2yhED5DG5XR2ur/BiPGyMWh3P28IAKM/Gob7jAzxIiyU5nQfQ8GWa1LRmBDdRLHOrxmHJ7L4ZMut91IZ5pkU/enerVaxsICE0+9KAGN15lbSrnkHKRlt9b03+8kMpbIyo7LauhZxT2aZDYYSgtF3eBwR5OjONTbY5+LsCFp+HoM1A+Ll+6hyRTKL2UDguCl06GKK4XSWlYgRQmIW6UWdL3FdCmeId0IysZyW9j3ZQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozdr4sBfY3LRtMg68eu22718byZmBWJr2U/29eEee8M=;
 b=s211o5/+eh3B8ofUiZ634LD2HzwChjwy5XfUVtB7XguPeSrvqey4NhYhfbMRMBRAMDvD3i50wl1NCd0LhN822FsRDpJ1zH1mgSBso6LOIlZ72b32P+OUQLYJvXLBAodUHF1xH2e9ATPGe0/wxc+CRtM1S2NKTGyIulvni0+PN4B3XmYqu71jQLQVHEl290DBV0GyugqggE4rh9rmzLiPuC2X8FUuk9zazKCHFUFzcn1zC5LgUuJqfYMs9RZDkmvH7lbOkHxbfkRloGmw1D2n4CUF6FL6rZKd9i8fCG5w/cSRmSfZvbZhbKA/TXQc9D+Jd3hGLlxir3mM5DiCHN7CVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozdr4sBfY3LRtMg68eu22718byZmBWJr2U/29eEee8M=;
 b=BaiY5nz0KPoJG+619uFPyX/sF2Q8RkHZuIwnnlxrd22VPYabI0Q69mbzyy4WzKJ9sGvU1RYC/w88xyh8UK9LfxmwmtdOni+e/jvUDpZKdNAKSva0w6bls2q8aMbAdwtw2spYJlDGJRtQHfDSE8PMWso2Xv7XWheWRcB/xbZYXTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU2PR10MB7728.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 07:50:48 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 07:50:47 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de,  manish.pandey2@arm.com,  Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,  Tom Rini <trini@konsulko.com>,  Stefan
 Bosch <stefan_b@posteo.net>,  Mario Six <mario.six@gdsys.cc>,  Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,  Michal Simek
 <michal.simek@amd.com>,  Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,  Peng Fan <peng.fan@nxp.com>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,  Sean Anderson
 <seanga2@gmail.com>,  Leo Yu-Chi Liang <ycliang@andestech.com>,  Sumit
 Garg <sumit.garg@linaro.org>,  Andrew Davis <afd@ti.com>,  Bryan Brattlof
 <bb@ti.com>,  "Leon M. Busch-George" <leon@georgemail.eu>,  AKASHI
 Takahiro <akashi.tkhro@gmail.com>,  Alexander Gendin <agendin@matrox.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,  Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,  Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marex@denx.de>,  Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>,  Greg Malysa <greg.malysa@timesys.com>,
 Kongyang Liu <seashell11234455@gmail.com>,  Jonas Karlman
 <jonas@kwiboo.se>,  Sughosh Ganu <sughosh.ganu@linaro.org>,  Anand Moon
 <linux.amoon@gmail.com>
Subject: Re: [PATCH v8 05/27] sha1: Remove sha1 non-watchdog API
In-Reply-To: <20241003215112.3103601-6-raymond.mao@linaro.org> (Raymond Mao's
 message of "Thu, 3 Oct 2024 14:50:18 -0700")
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-6-raymond.mao@linaro.org>
Date: Fri, 04 Oct 2024 09:50:50 +0200
Message-ID: <87msjk5msl.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU2PR10MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f30884f-baee-4dc7-b60a-08dce449424c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UE7Vky73xwDCxyO6fYA6cp+hK9tL774RclEu94Cfj7AytvpDVXICkEzD4OZB?=
 =?us-ascii?Q?jOgHGDt16S7Dcwp+PSSzGDdrqKP8l0lp1+pI9uhc3nF4LrlVkUBbf/AnTCaS?=
 =?us-ascii?Q?YkCzeIxUmmym1qGtvzo/MtCre8rN5hPttjHd5kg9eRpugFXsT7HzYEGBRV/e?=
 =?us-ascii?Q?6wbjE7GW5gzpW4YVXd0EBV64t5ObD6zWSLtka9yT147qIa3gZbYDyzLvSVN1?=
 =?us-ascii?Q?gVSZ9EziI87SaPUneCBdGhiNQGMxjvrhMBad94wjZE7TxUw9zbhVSP9zoUtC?=
 =?us-ascii?Q?2tVF6nhnk+uKPJMq9D/nWOImYsNzsbkWrJbEg5JbZKOynEIMFNoS39MIoLr0?=
 =?us-ascii?Q?Ugz1YVVHZs1bSNimAgtaKwshHPY2Toe7gtRRgTDRXOgu9oPM0y3A8yD8+TB2?=
 =?us-ascii?Q?19nds+TygE9HytQyPq2zsno0OZJ3p9kjY6+JEUx1OCww94uy7AyVKAtKaNd+?=
 =?us-ascii?Q?HcnrXxsYN4Psjq8XnZM/+21HQSwLuBuMO690Xjq7dfqkA20+Q/vALY8ua32o?=
 =?us-ascii?Q?KP3hKn+aPRcr9nVwNteTHoY9dQZvHkoDaCZcZIm0Dg1LMLxVDOJ8/d7oCwQr?=
 =?us-ascii?Q?R7m8I6n+DcjgFkr7CmkAmfb7GO8BLz0LklDzDmRZOGIntuA+DCFPaofEJ5Tl?=
 =?us-ascii?Q?iVHP5sMzpQIEZkbvGFqAVWGl5FpH0IhhjrdIDHlcA/sxfZOlmfK91L5JFUBD?=
 =?us-ascii?Q?PY86ACDfCL/9QLGtzB0Aaro4y3mAf2QDMt3A/yg5la8ltT7TwAMbJzc7O5PK?=
 =?us-ascii?Q?ruJGmfpWXeQBb97jorqEtohxMoUfJ32uiWUZEJTM9VUKw6wZqDSqWWm1IEfF?=
 =?us-ascii?Q?4iyl1kqS89m4rPCJgIwnleIatj0mJq2ro2rIE8Ua/i606ePhyNq0xtWDdFea?=
 =?us-ascii?Q?SOMqtKKYvqGQys3x+cb7G4phGhBqbWSaTdDpA9i9gED+Sn1WfX8ACcb7KPTz?=
 =?us-ascii?Q?IOjAEYgwQ6WBugerYr7SHw6ltP8gO4aj7tJaDdIZ6vdCbQWUzQkGjzyFQvkH?=
 =?us-ascii?Q?4iwtDIDYlApbftdBCvchxYFX4rRxupp0qBrxBhipSb2dH4JbZrzcx4GoSbZZ?=
 =?us-ascii?Q?UfE1C3ZSA5B9fk+rLqLDi/BaxsLoXJzJXRhIWmfSBwnuT1BRzeoFdUtsLpD0?=
 =?us-ascii?Q?zPTMQP6S2c0IXLa0B7T2TIZU9J7l6FzkeUnfOM9ZY6YKoz9/zemW4Z2pkb7Q?=
 =?us-ascii?Q?XZVAgVU+QTgYui83Q1PE+5d5v/j/8wBwmrCfM/GAYPudaCGkLGNL5ATrjdJs?=
 =?us-ascii?Q?BWVegT0QYZlhOzWFDu4x1CplAfLKKOUv6Su5bYpzbNbSk3/Uo6x8tTzFNYZr?=
 =?us-ascii?Q?FwNkbpWJoyKA+OpojxgcBF1dthQa/J4XO9FSoigQekjIZw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QkMoAAH56SgnHD2socFQcmxN3MaYvXlScXx2Bz19Xoc0BL8gOEYG43BBtA5K?=
 =?us-ascii?Q?Z7L6+l/3NcqiZ8ejOVb5ffY98FfP80YdW2qAKu4bTpP3++X1JdaCKVC0nHWO?=
 =?us-ascii?Q?pCjt0aFcZBun0Vm2+r5gR82+vEGR/9QXYTcQDPds/0QtsN6MtJgfBQN+AVAW?=
 =?us-ascii?Q?VNPOHVsRWyeNYuji9niazo7+W80Vyw3nadbDIRFq0EdDyyUxR62MvyLvRkR8?=
 =?us-ascii?Q?fx3nZdT9v31B6th4KYGSlGbttXpCZeEpzRlAEuvMmLN3xBnCD1K7svRSiWfy?=
 =?us-ascii?Q?wM/hdWrOqaYbGnz07MIWlSH02AFwEwOTWXSyzxnDt2CcnjrsB4GiaX9rjOMr?=
 =?us-ascii?Q?n2Dt8pw05P19+E8IV9s3JgugvfnQwv/aN68Uas/Al3yBpJKfVXv2OUYMgjTG?=
 =?us-ascii?Q?Zttx7Mk5dY6UfA7j5aN0k2915PLH9fMlH959WZDUMGJZ3K3XVsDgW/qaJqyf?=
 =?us-ascii?Q?h8z+aWihQwRLetgcjX5fpJa7ZHK0dg0ZKKg25xsmSo+u7nZBSstKuBNceZAA?=
 =?us-ascii?Q?ML/IBe2DU86hb2CRyS4O8OBAY14J/P16xfBALRmvNPskNr8PPWdMYQo1EjZ4?=
 =?us-ascii?Q?4zp79v1BjK4upLSNDSmWDrw5QpRfdLHhQYn5ahXXVvV8N+dr+4CVlnFl4zLT?=
 =?us-ascii?Q?JoNUsEL6yfQB6jsep9xcQtVeXQ8PLpecVqBVd2PG02iEuIJWMR/6m7nKp2Zi?=
 =?us-ascii?Q?fK3Nz3oIR6zWlZ09YHKi8OjjMaVMLmF5qesLXVjD7YvDCdPRq77Nv1imb0Cj?=
 =?us-ascii?Q?FqG/auffq/XJdwz6SOfnW65VPtCbT8uxZssAHXpxZ8ozBLoi1mtVi9jPJYo5?=
 =?us-ascii?Q?cwLhlyljaTYWuMHD8E61lYlvvle/Yc3HJ5Yt9N00zq55o39uNb8E/dFSrPaD?=
 =?us-ascii?Q?DmMBNZlSBVqMoHO45q7O+ujxdA8AZcO4mvNV6Oxo9P0woWI3EF0SP2nDzrGR?=
 =?us-ascii?Q?ZIqxr2euGSmu7CbLPdFqY/RGlqu3wrXu47UlTOnCbWJtobhcl7Gi0hX6t2ZU?=
 =?us-ascii?Q?We1M4/nEOOBJTD5B0c9owQgmdhisfJ8PA0wZkY/VU8zbgAspH+izwONZbW17?=
 =?us-ascii?Q?Iybxv81yhRhal06GOjKfBpX7JSy4zLsaS+NLL+umpNbusPMQFNz0AwgQsLLs?=
 =?us-ascii?Q?TbC5JapFIIw+lx079/Rka1WG5302HP2migvWqkXrpswTH0dzS4QnipTk/lX0?=
 =?us-ascii?Q?5O+5qWRBU1ugivQw63Dowk6UOt3v1VsNGaeFRUOu6MEiT6flNzaiDH017jJZ?=
 =?us-ascii?Q?hKYSTQl2RVDofD0b4rGWpsJRBfK7yL6A2x7ezP4KcLjrRUbJQHLuPDXLDwbh?=
 =?us-ascii?Q?n4bogoczueGFhQmDT1bZQ6V3APO3FJjLhU2EzNSX8tJVxjzjKtyjYRLAFiLr?=
 =?us-ascii?Q?wAN+4nWul1FpO6fDsiAIhAyOEbuW4yik6Bv6qnOW3f0A3FoAPRwp2c6AeKXB?=
 =?us-ascii?Q?qZjWByPUxs2y4belJBprpcHqC99O2FtVgNIMZ6leZOij4jEz8Z/Dybubxtg/?=
 =?us-ascii?Q?kgK57zWJlr/EgcYqxfKYrj9oBj70N4pDOvOMQNdF89cocDny3DZmb1s/iTCF?=
 =?us-ascii?Q?Q0YXaYLwaGxH6Qp9eNDCA6G4MOXsbpb/E5GSFr0fFGfhCAppv9ZbVTliLgqB?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f30884f-baee-4dc7-b60a-08dce449424c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 07:50:47.8362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsmYi49HzwUtlfUl92CFdZXT6hyFTtZ+ZtQN/LybW2WLAiCQmgeV71JG+o6crlK1Sy8VF7jSX4xiE0hu4a0sHwQchzZ2qexvlDDdPbV8wAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7728
X-Mailman-Approved-At: Fri, 04 Oct 2024 14:47:11 +0200
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

Raymond Mao <raymond.mao@linaro.org> writes:

> We don't need an API specially for non-watchdog since sha1_csum_wd
> supports it by disabling CONFIG_HW_WATCHDOG and CONFIG_WATCHDOG.
> Set 0x10000 as default chunk size for SHA1.
>

I have to say I believe this is a step in the wrong direction. Having
everybody call a function with that _wd suffix is ugly, as is having
them all pass some pre-defined constant. Moreover, nowadays what happens
every chunksize bytes isn't restricted to watchdog handling.

So yes, we don't need an API specially for non-watchdog, but why not
just make sha1_csum() be the interface to call, and let the "maybe we
need to call schedule() once in a while" be an implementation detail of
sha1_csum().

The same as with our zlib implementaion; we don't have a separate _wd
set of routines, we've just hooked schedule() into the main loop of that
inflate algorithm.

Also, I think the IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)
guards are wrong and shouldn't be copy-pasted to new code. Preferably,
the code shouldn't even have any ifdefs, but just always be built as a
loop with the (possibly no-op) schedule() every xxx bytes.

I just sent a series which is the beginning of cleaning up the
CONFIG_HW_WATCHDOG/CONFIG_WATCHDOG/CONFIG_CYCLIC/when is schedule
defined and when should it be called.

Rasmus
