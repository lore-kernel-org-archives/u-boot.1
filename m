Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F92EC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E1388912;
	Fri, 24 May 2024 19:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="kFWBdsfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE378882C; Fri, 24 May 2024 16:36:24 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazolkn190110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d000::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C73BE88682
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LblNt/yDXXlKvnaX2bFgOzY9NBwEAb+MaXZpi2eVFuRRlWkmyGxq8FCZAlPU7strTOrLgpdnhoE96QJu3x51Yzn6q5f4YCrQhpYiwGbXASYwXLoCtP5kMHlva8yoAUK9hR2OTlXclqi3/rizdwdbngVYiARODOroy3VBt9+ec2TA+h6a24w5IPA5q0tIArrFlGFZk2eH6w34AIodVdFxTkgwaEDkOtuxY+qDVIj8SrFFWnH+/AqPfuo136rfPhAXQSF3CB7ph6Y/cfXmz3OyM/P5FzsPud8z0wWrDHLL2SJgyhg56aho+PnaD8irlGJu/M/k3HFY8CWC3b19qMvKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=borgNsG0Guq5xR6TCInUzhNPELMYOHKyq5knlRHB3PI=;
 b=WMKc7dC78XJTruqjrPQRRu+IZUE0DIfuT/T9/kTVKUgnuECkCxoiUubXmsObaNfNRYDrnXuqbnC3PfMDjxceVa1G6ZG9xaRDG94uZD1gWxX5JO8oiiSRRgu1Yp+jVDQFcPkpkTgQG/r79hli0ebsgvOcx5hn62j0gbp5iVCRs/ig5LoPnS4NaXRf0uCxzZFTN1scbKiKKitFkgMb0XhIsmImeHqVK0q2BHaQhMujS4CwkhgALRtW74vq9unD0JHoqnTJ29wBKtsc66JtnFmpJcYlAFUM96Bc857lMYMfaQ+yFmyHE/J3IGO5djB9V8kZ85ExtO1ldR6oztSL+JbZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=borgNsG0Guq5xR6TCInUzhNPELMYOHKyq5knlRHB3PI=;
 b=kFWBdsfTlbnPmHWPT0fyw1t5X012Mbf0eSW+42cLRf1flZpAeyJRdA3HREgrOzzcCySeszNmDo9hlVKTTRQJD7We2NeTOBIi0RWB0DoCx39rmcOMaTKv/wwMZ8a/wZjhXDDVFsEraFi4g4WTu2XXjEM+ujoNTfivoo3aogD+cVQt+oo45+OA7nEXfZD86GZjDEHxMh8agPD3QuulU0iuDbw0bn7V8KCGCANxrRIFAHbum8UdCNOzqlw2cFLKyA5EJVW1Ah/nQieRAEHgiYKmtLFACCmaokNfJfSo0CCrv860A0DeXZGHqTt9CWy6+ldqGtmW2uMS4Xw5rUEuOm7J9w==
Received: from DM4PR05MB9229.namprd05.prod.outlook.com (2603:10b6:8:88::20) by
 PH7PR05MB9978.namprd05.prod.outlook.com (2603:10b6:510:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 14:36:19 +0000
Received: from DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff]) by DM4PR05MB9229.namprd05.prod.outlook.com
 ([fe80::d720:e9e5:929:c7ff%4]) with mapi id 15.20.7633.001; Fri, 24 May 2024
 14:36:19 +0000
Date: Fri, 24 May 2024 09:36:17 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 sjg@chromium.org, philipp.tomsich@vrull.eu, jagan@edgeble.ai
Subject: Re: [PATCH V3] board: rockchip: Add Indiedroid Nova
Message-ID: <DM4PR05MB9229F7268740BFB50395C6B7A5F52@DM4PR05MB9229.namprd05.prod.outlook.com>
References: <20240521153350.238644-1-macroalpha82@gmail.com>
 <5ee55f40-bd60-41ab-ad7f-13a9011ab84a@rock-chips.com>
 <20240524141504.GX2568172@bill-the-cat>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524141504.GX2568172@bill-the-cat>
X-TMN: [UK9FpFZPur6GVS0H2f0ceLedtr82vFFb]
X-ClientProxiedBy: SA0PR11CA0152.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::7) To DM4PR05MB9229.namprd05.prod.outlook.com
 (2603:10b6:8:88::20)
X-Microsoft-Original-Message-ID: <ZlCl4cqvgA4t6U5f@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB9229:EE_|PH7PR05MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: d967a9c9-3265-4288-58a9-08dc7bfedfdf
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info: 5AbkZNl24sOAFJa2ZSGH2nj1hbnmebTf+DVb7DHqT01S/THnq9EtLWFWp0th4mxNpMJUwmJ7tAyseLdQ8Nvh87VVYgoG81hHA5zgOanXx5FIFU+Mbz8dc+F5ruT618UsGfC+DX+Qk8BjWWcH7dlraf6o9StF0ip+ZsOYZslov/XbA1D4SJiXgX7HXik42y5FbJ9kxYii+gD5EjHMzfm8+TF6Wh5pBjnUSWJ9zKV+7Fvma27oVpeey2haXjEXRP7+QyLLZrD9Nmq4Qc2Xos9Hc3YQmJd0oYr8IoE3aqImF/Ti0AnuaoM2oxYrZsytPc4J5Y322fonna4SWnn625zIHsIXMcBuwqm3VmEHYsyHbI0F6Vo1/GXj7EjEU/WYo+cC8FoyipTScjXrIQzUQw5XMCKMELDsSgxviQrYki1fwWeVpWTmwvuTEcsGz479z0axxzTmCdRNdKrDKTdywAleufLW8rr5rvIWy2fCiQKJaJB5Ak5Wy1EuMgosh/G6hxDG7HrYL1rVGBmEV40vlLQemYUb107Kyo6Vmslla/jTtg20rFmH+YBePJh/lXY3tcDE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fCHmEYMhDPJOugU2QRlKxhe0jqXV4WHAjnOWSfuHPDOSjnl+jCzDyM5SHL?=
 =?iso-8859-1?Q?P+YfzEkzRZqgmeal62n1Ov7uhVxwo3ppME4WikDabb+SI5xQUTO6vHdsOX?=
 =?iso-8859-1?Q?s/O2+FosgAZXpTO/8ou70YSxDkfXJu1Zpnpg82sOWbd0N+B+EHPsA7BRER?=
 =?iso-8859-1?Q?4FLw+i1jV48NIviXPYSL0v4pUM5PSotPBQSCHHeksHJf623bbrAk+nHJ0o?=
 =?iso-8859-1?Q?Es6m1Rht9DSyILDAENvAYrw+XpDOrm5xXo6XigMAYW7ocNdlqzCNZm356t?=
 =?iso-8859-1?Q?K4KXAZ0wjBPBV0YbRhr5WEqfkUC6mh9uKp4zGaUM5qIb5CaRWmgUICgRaK?=
 =?iso-8859-1?Q?O8yjdXSPMT7jfW+SlZj0hPsQoT8yp0pqO1fz+4F2XbtKkfTw5gboLD1ZWY?=
 =?iso-8859-1?Q?53rXwoVyumNrEc+y2BzVbVl+/nxuNdPF0RWJPooM0s1b6Q6bWb/v2d77c1?=
 =?iso-8859-1?Q?9tAsJcFAmmye+Jd1iGn/8FjipglAAxrm7bEJHg/XIGSga/tEK5X276AAD7?=
 =?iso-8859-1?Q?f2/hj2QVqjqNHYRBuysxt5KNeoO1O8O/1pR5FblRA28Nk95117K7XRV1rO?=
 =?iso-8859-1?Q?d6P8+YbY4NLX50GQ5mgCHJ+gX2BwIazmxUI0vaFEivQbyXIoDnct2nvV0D?=
 =?iso-8859-1?Q?kxkRVELzLrSFVhRiO8+HNLC33IaM5tefkbBq47+VzzTBcEHtTS2kSXlsTh?=
 =?iso-8859-1?Q?7FAUIfxcVZ4fDv1Gyomq2IsWfv0ypx6Z0nrTMCalZgpyGg0VEqkrly/Zjk?=
 =?iso-8859-1?Q?akPydCZ0Omak+HNO4CpdtiTgIE1rj0hhI313JMWleSGcISpqYnS+/7t8VI?=
 =?iso-8859-1?Q?p2+edFBsF/zOMFq0YHbRgOP3fD4azW90sjuZciBSnUs12C+b/erR5IlFYR?=
 =?iso-8859-1?Q?2QuFU5JLOTFDp944X2zcxSUeI6+mMobhiVvELjhLyHVs7CH/cIIkwgO360?=
 =?iso-8859-1?Q?C3ClAENdh/fay5l6tZmsqK8/UDddiy8r86jBwnzio1a8Whyc1DJZa4equc?=
 =?iso-8859-1?Q?E28X8jW0m29so0d4LSpohuFSxddyDNkFjfSSUKeeR5ZVMEybd++vXlYYV4?=
 =?iso-8859-1?Q?vkDH8Abv7zvnTl6Tzi6YURT+oF80CW9Tm+IEhXqtN0I0u5c37Q9veZ1sEu?=
 =?iso-8859-1?Q?HmeCx+s2RrKFZnyoRLlcbT1xo23iqPeeb2u246KiH5aI2E3tFaY1KaMUQG?=
 =?iso-8859-1?Q?czQw4bKcktX7fdnI1oQqf+f+Nir5ZYoMjYSbhXWnRkFEs4lAMvbdz/wBHA?=
 =?iso-8859-1?Q?TXfMfxWeGyt8y5DGtsaWdc6BUC0KDwaBQCYr8xJks=3D?=
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d967a9c9-3265-4288-58a9-08dc7bfedfdf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB9229.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:36:19.2590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9978
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:44 +0200
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

On Fri, May 24, 2024 at 08:15:04AM -0600, Tom Rini wrote:
> On Fri, May 24, 2024 at 05:58:34PM +0800, Kever Yang wrote:
> 
> > Hi Tom,
> > 
> >     This new boards has MAINTAINERS file, but the CI reports:
> > 
> > WARNING: no maintainers for 'nova-rk3588s'
> > 
> > Could you give advice for this?
> 
> Yes.
> 
> [snip]
> > >   arch/arm/mach-rockchip/rk3588/Kconfig | 10 ++++
> > >   board/indiedroid/nova/Kconfig         | 12 +++++
> > >   board/indiedroid/nova/MAINTAINERS     |  6 +++
> > >   configs/nova-rk3588s_defconfig        | 69 +++++++++++++++++++++++++++
> 
> Here's the defconfig file, but:
> 
> > > @@ -0,0 +1,6 @@
> > > +INDIEDROID-NOVA-RK3588
> > > +M:	Chris Morgan<macromorgan@hotmail.com>
> > > +S:	Maintained
> > > +F:	board/indiedroid/nova
> > > +F:	include/configs/nova-rk3588s.h
> > > +F:	configs/indiedroid-nova-rk3588s_defconfig
> 
> Here's the entry.

I'm sorry. Bad typos. I'll redo this one more time and make sure I get
it right. Sorry.

Chris

> 
> -- 
> Tom


