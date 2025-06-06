Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EECC61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D566F81F0D;
	Fri,  6 Jun 2025 21:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="MbXdcdZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 914A582145; Fri,  6 Jun 2025 21:02:27 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12olkn20805.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2c18::805])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B8A807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHWUtaQrLUv3hLMQOnea4HpajGhMO+c3W4Y8Mezdjn+6iGO5ppd7dcIZhgWnPjrJiDewVfHKXE9pE/On+1ytKNW88IMVWWWudvHnXE4Lgh0/NILyOWPl8Ro35WDwNbYK+90uzry4zfYsvHM+1QdvOee4RK5b1bHVthXXDjT7fbqBFxmdIXFYXujZH3fpLgNO6Jwjj+MUI1nWIF36TxkN19mKQhR32wWmvQX1HcM6Sr6PKMOxwBT5vCZFW+H/lMvDXzaemg8FAWjFDTApLxZ4lkJkrXqYPuiZ3RQHdH6lWyHWsfuG5y8bcsND2np3xtEhEHlqhKNpYpg0Ol7Z051Dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jac4xEMBVjHcaPrNJgM/+o1f3pOVhjyXuKgyK9dhjog=;
 b=g0ZDduF79G9POjFzp3hdcL/1LANPcRRUyHbIdu423foZPn1alGGVvlW2wvb7qCXRvoXyvjOSefge8nToDD61fQKedZRTodCC2NbKml5RHWSbXTiWXgE7sV0Q0a6Vtwwc5x7QBi7l0F589ZNy+j5UkjqEuom6FLzupFodoM9NJcllsEfOjMw4iLPYsr2isJn51DaOJ/ud65vwaVZshqOIdDUsFVn6DJg05UwNwc4KLW7ankg+unUM1fRFouRVEjj5tIO14VWUhdWrL5xoiv18/i6Mp6hfAi7756gNlv7MLTKHd2tF0ullTE7qgtQIchBkTdz/fRNVDeYIHhEMdN5SWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jac4xEMBVjHcaPrNJgM/+o1f3pOVhjyXuKgyK9dhjog=;
 b=MbXdcdZbOOXbGwhFJWcA2MlMRx+Lmq2NwxxXQquenVcpJyl1/R22cAnZhNmZORVEqZ/z0zjZiFipdw+oqIepRd103APrygWW/JqDcIzk+M6kRa3qodAKuqFP0wrcXrGKy/CuY+zFbw9FBTxnnOXb75oMRZoGN8olJQ2LR5x1sLsotwGqU57QitYi/KvFBaO93r6VFJ7Zg5HlUiL7n1Vy6/vJHBhczVQUu8CmGmv/S3Rv866WgvGFnDeqfOtIcd6yAYoIcUgj95MXecFKBlF0IFNfVNBx988lZzsmWSrR/RPJQzJaD8ZEu6XbqsZE0TXujcC72GFKB5g7W5PMbNOVxw==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by MN0PR19MB6115.namprd19.prod.outlook.com (2603:10b6:208:382::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 19:02:21 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 19:02:20 +0000
Date: Fri, 6 Jun 2025 14:02:12 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 heiko@sntech.de, quentin.schulz@cherry.de, jonas@kwiboo.se,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com
Subject: Re: [PATCH] rockchip: Add support for GameForce Ace
Message-ID: <SN6PR1901MB4654FF109835BF12F4F39805A56EA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250603221344.372367-1-macroalpha82@gmail.com>
 <fe8f38f9-9461-4bbf-a730-091df493c8b2@rock-chips.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8f38f9-9461-4bbf-a730-091df493c8b2@rock-chips.com>
X-ClientProxiedBy: DM6PR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:5:174::23) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aEM7NIpO9J1Pw4sK@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|MN0PR19MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a9fc72-3267-4581-e1a3-08dda52ca665
X-MS-Exchange-SLBlob-MailProps: laRBL560oLRD5RrPfNelPvcHmz32ou5SRtB7EpyqR5hzl5no8HFaSQEJyxApGAxcwdDXRGkKmVFDsZCq7mNt5EjGKU5zu7at0BFXyBMfwhMRPCdaTbDPFqPglYnRwDF3JMHuscYPL5Seef19Ua9KraG2fJ9iX7g/CK4PggeGW2/Ir6BlHUggl89+Fo+SQ0tm7TMaZt+PvFPeb5OSuFY1wV8zuTHGqSjvuFLkT4+BP/qIn4Z23g/kX3DeBczxU3yPe+XSXvVy0Z5B9KR+aTdYQtwvY+mIwz7Ux8G+9kx1vqORq8k3zFmfb242qZyqHFnoPoG4ca1R84ob1YwtxIIlh27BpZpRg1v3/Qc8G8tqiKG246T9Vsw/a3+FC+Kuf6Oir+TZ/hQBJ5yPONUiD4jLCJ2jkdQTpozgA2AXm4XQ2WN2ON7/rPqvCW60Ud9BwHqGB4K1ULCGvtVMKV+rEtWr192MtPhnenuBwRTYXPvdaiC9WjktSvnoIHCvSAjAXNB9xT0TMTbvJHWyxvFurAquuJyspfDLb7HKHbKjqY/K2IB7VWWMOOjVvJ5T7tbbltV/HwZv+A3Jh1nJMQvhndvmYCz5a6Y+22W2cLFpXZiNqh7l3hFAa4zH7LCwpdmJauQ0cp+UbWB6TcqbuHapT26uojz7Lpq48LmfCIi7Nx26mB6A1B4DsBKRHV8n5Zzv249qHeJSH3dHAQR37UkZCkGFLcoOLux1seuki7YwdbPBaT3/COoppWyJxU+fzHtiqBA2OVh4i0IS5vPsiD49lG1t0BjCeugsgn6A
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|5072599009|6090799003|19110799006|7092599006|8060799009|15080799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ODEA3o9SBFBl4jP/xmdMV2W7UFRwM3UEIjXAClubpoSrIkGlNHdAnAh7pDE0?=
 =?us-ascii?Q?YuA2g4XKMUNiWeIbdXddY+TRvZ094nSYFPsf0wEWtJW3gC6hfnyjgIux7fMO?=
 =?us-ascii?Q?+1+WVmqEmstPLsgLkqcQerY3vzFfe+7lwpdkDaWtyrZjuPAGmFMCI5Xs4R1o?=
 =?us-ascii?Q?RYQb/5kaVnayarviIEKhQnEA8Qp1iRf5weJDjgbWZ2KSuBiSkLXiFPien8Lv?=
 =?us-ascii?Q?cuWcSkjUKCcUyUUrj+TPuDlziIvl8vItQUwMQbGY3wBP/tc88gL94VJRmXC2?=
 =?us-ascii?Q?LaBpxdZfL79ToJPbc4iAf/gYje1mlkNYC7WtAazcZbjACdrAlDIkREy9kRTt?=
 =?us-ascii?Q?g7WacfJF1hTffuAQKTst8hq7GVcnMpaN4wdCcQZw/fZSvVo4/1EqQXmDVWqK?=
 =?us-ascii?Q?D1ZRQhjnfmCFz6VfKlGIOxYHt9bwLe2/HQFeYxaD00611QSIWEtohM2X7UPg?=
 =?us-ascii?Q?noryj0zsoCoP/9qajrWiOc603rsCd4bWIM6nPD/ZnU7iQ5aBAE5HBru/6VFu?=
 =?us-ascii?Q?r0gTT3lXnPtKjpWMhj1Gt1U7r2l35E2zhq28heh/UC2rzjLxOaT34lOBnhvu?=
 =?us-ascii?Q?mlGFUt27Kg7CuuyYeqTmAUq5Iv6zOWGniieEUCJjf3XHXgY4QmD00C4ACUOc?=
 =?us-ascii?Q?rDOiZaUcyQ3EmhK4Sfa/FmJIyyRK3bynWvDlKuv3Z8uwTThDgYfouqPYJ0vN?=
 =?us-ascii?Q?USiwMcNxOpYmFwoCm2JLw/q8LjK/DrFJUAfT3nkZK2PkoKaLu4sBHR52tcQr?=
 =?us-ascii?Q?ozXKmjw0orYSDJnSvzbS8lZ7yUxq+gbJO65APt8cWr7ajenST8yztcbfD+7I?=
 =?us-ascii?Q?qNfkOqmDOKu9Q6T5vYv34GGQR24WO1qqI17mBLEOxkudCFT5TTUPOoKle9Vl?=
 =?us-ascii?Q?SS3+yfnXVUEOszcsBZk3Ko8qXXvI4IGrytCnFr61UWxRmWvCCAHQ/MKGiWNH?=
 =?us-ascii?Q?Fu0i7Vs5sodlep5eUQBcHVrYgA4W8FdDtv/yFtridohsSOvx00dLTonACnxW?=
 =?us-ascii?Q?IibvRfULKpNmAyqLrKMYRAdWmzCTs9OFirKfHH1HbTFDvJwwTQR002N/6m+Z?=
 =?us-ascii?Q?Hg7e3fgHUdZ5oGcdyvPj9NEZ7d/WHgrM8GzfnZcKs1fcNC0Vb5sgoby9dvtD?=
 =?us-ascii?Q?UT5qd4j1QoIBYM3JQfZz0m+ohrwrfH27oA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwSbo9WQwodRvmHGPfNKONkmexfV8uT/nj8V+uDXgw8HGYx5f/ItJTIc/LKQ?=
 =?us-ascii?Q?TV7EUwF6zS0MenBmirl+PZDTZu7Res1eAnv1EjnAavBJQisNP6WWcNCp1MfL?=
 =?us-ascii?Q?CAIXGXiLv1KfiiuARGsKQv9l+KeX+ybqw3D7ri7V/sRod5tHTjF3N2vdHxfR?=
 =?us-ascii?Q?ENvs2WpSc7q00h7xBbOrHuIFrDATH9BqAf1fvHiwks3nYikB7Qxdiu+NPByd?=
 =?us-ascii?Q?zS0tfnFse6hajEDAfdf5Tbr+9N02g7b8HLtjs9uZ1aPFcy6HNyELB8sEl7IV?=
 =?us-ascii?Q?q33N2CJzjCIHQSW0qkaoCNNMtbmi1R0JDd24jZfO9yg9fDgbGB3oAk4oJvbe?=
 =?us-ascii?Q?0eqwBM38yEDHOIAZs5lM1Ap4gqzrJmEpdhxIt7ZB17Pa92GDWiUZOVIld6LF?=
 =?us-ascii?Q?1wKtjRVB4kz9CSGBU1q0nhVHNCVv6LbmJ4KF8OZC1czJRs/k6NuKzfhZBSkK?=
 =?us-ascii?Q?tgWV4edSypo77Mai3D9kHDq0+tVpR3HUopskRq8uxRjMtKtW+VsNbp/T8bu6?=
 =?us-ascii?Q?QQAksHxyLH45WR/E/RkaFp2zuKm/lN5VWmbKlxWs/miY/VsH0CGZfEPgKmfQ?=
 =?us-ascii?Q?M8q44upY/QNuQ0Oqt2GmUxq5u+Zgy1PKsjmnK40JYQXpMpfWw3T6VYmBdbtN?=
 =?us-ascii?Q?SIwC1RmOBd7O1PnofToQYtNRkrvzT1uh0VmATfPU/5dcPAZA+k+r12Crltld?=
 =?us-ascii?Q?2gFZYx6QGZ+yFZ4ya8aSp/7PFg5d55zTarRHxiU+jRQXmAmQ94vY/OQlQmgn?=
 =?us-ascii?Q?77I9qBfuSYBUXHBP5BJuB0SSVJcna9erXYNpdN/amQPw435qnYAX15TEjtm9?=
 =?us-ascii?Q?MwW2ulf5vUW91glbihznD0HxQPCqW/PdSozM7KAko94LHYWmNf4pOSESfxz+?=
 =?us-ascii?Q?VvEO0zQu3eXNpckQAI9C+k6jyxRNQNorDc79EmCC1guD4bfDiSXop68sgGDP?=
 =?us-ascii?Q?hl3Z23Y+GD1MDkpe5epiY05/xR57pAendFYwVMU3IlRI4YiibqIznvcjQUX9?=
 =?us-ascii?Q?9dgbQ2uIRYkCWgN0HMB+WD0pqq5vZVnCJbv4SLW/3VTKbGlpu1C9aj/BrIkL?=
 =?us-ascii?Q?rb7KncJ+FOlw2p+FrdJeEvhg+azNaFw3SIleHd6AN3fc8OiYDq4YOmbirzcp?=
 =?us-ascii?Q?Y5pcejLybe4Bk8Xr5KKnYJ4d5ODjh7BmFqWtkheAJEfvJ4VBRHyIGn3TIePf?=
 =?us-ascii?Q?Che6BYhdfEvT45j+IseyN1smL+gS7j8ycluJCmSJ0EOoyt7WcEjn9xySF2Vv?=
 =?us-ascii?Q?JRR0KiLtZ+KZV23F4ct4WoPXa9+cN1OiEhW0AWX3tGvy/VH8/Jr9mD419Tti?=
 =?us-ascii?Q?7jaNlFMAjgao1ZstQ4xQOIsK?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9fc72-3267-4581-e1a3-08dda52ca665
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:02:20.6661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6115
X-Mailman-Approved-At: Fri, 06 Jun 2025 21:36:47 +0200
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

On Fri, Jun 06, 2025 at 05:30:11PM +0800, Kever Yang wrote:
> Hi Chris,
> 
> On 2025/6/4 06:13, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > The GameForce Ace is an RK3588S based handheld gaming device.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >   arch/arm/mach-rockchip/rk3588/Kconfig   | 18 +++++++
> >   board/gameforce/ace-rk3588s/Kconfig     |  9 ++++
> >   board/gameforce/ace-rk3588s/MAINTAINERS |  5 ++
> >   configs/gameforce-ace-rk3588s_defconfig | 69 +++++++++++++++++++++++++
> >   doc/board/rockchip/rockchip.rst         |  1 +
> >   5 files changed, 102 insertions(+)
> >   create mode 100644 board/gameforce/ace-rk3588s/Kconfig
> >   create mode 100644 board/gameforce/ace-rk3588s/MAINTAINERS
> >   create mode 100644 configs/gameforce-ace-rk3588s_defconfig
> > 
> > diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> > index 4e7942ada87..9fbe3f225aa 100644
> > --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> > +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> > @@ -27,6 +27,23 @@ config TARGET_CM3588_NAS_RK3588
> >   	  - 3.5mm Headphone out, 2.0mm PH-2A Mic in
> >   	  - 5V Fan connector, PWM beeper, IR receiver, RTC battery connector
> > +config TARGET_GAMEFORCE_ACE_RK3588S
> > +	bool "GameForce Ace"
> > +	help
> > +	  The GameForce Ace is a handheld game console from GameForce with
> > +	  the Rockchip RK3588S SoC.
> > +
> > +	  Hardware features:
> > +	  - Rockchip RK3588S SoC
> > +	  - 12GB LPDDR4x RAM
> > +	  - 128GB eMMC
> > +	  - MicroSD card slot
> > +	  - 1x USB 3.0 Type-C with DP AltMode support
> > +	  - 1x HDMI 2.1 micro-HDMI out
> > +	  - 1920x1080 touchscreen MIPI-DSI panel
> > +	  - Analog joysticks and L/R triggers
> > +	  - 16 digital buttons
> > +
> >   config TARGET_GENBOOK_CM5_RK3588
> >   	bool "Cool Pi CM5 GenBook"
> >   	help
> > @@ -410,6 +427,7 @@ source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
> >   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
> >   source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
> >   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
> > +source "board/gameforce/ace-rk3588s/Kconfig"
> >   source "board/hardkernel/odroid_m2/Kconfig"
> >   source "board/indiedroid/nova/Kconfig"
> >   source "board/khadas/khadas-edge2-rk3588s/Kconfig"
> > diff --git a/board/gameforce/ace-rk3588s/Kconfig b/board/gameforce/ace-rk3588s/Kconfig
> > new file mode 100644
> > index 00000000000..52f98ccf897
> > --- /dev/null
> > +++ b/board/gameforce/ace-rk3588s/Kconfig
> > @@ -0,0 +1,9 @@
> > +if TARGET_GAMEFORCE_ACE_RK3588S
> > +
> > +config SYS_BOARD
> > +	default "gameforce-ace-rk3588s"
> > +
> > +config SYS_VENDOR
> > +	default "GameForce"
> > +
> > +endif
> > diff --git a/board/gameforce/ace-rk3588s/MAINTAINERS b/board/gameforce/ace-rk3588s/MAINTAINERS
> > new file mode 100644
> > index 00000000000..dc18e7c8849
> > --- /dev/null
> > +++ b/board/gameforce/ace-rk3588s/MAINTAINERS
> > @@ -0,0 +1,5 @@
> > +GAMEFORCE-ACE-RK3588S
> > +M:	Chris Morgan <macromorgan@hotmail.com>
> > +S:	Maintained
> > +F:	board/gameforce/ace-rk3588s/
> > +F:	configs/gameforce-ace-rk3588s_defconfig
> > diff --git a/configs/gameforce-ace-rk3588s_defconfig b/configs/gameforce-ace-rk3588s_defconfig
> > new file mode 100644
> > index 00000000000..19893a76c15
> > --- /dev/null
> > +++ b/configs/gameforce-ace-rk3588s_defconfig
> > @@ -0,0 +1,69 @@
> > +CONFIG_ARM=y
> > +CONFIG_SKIP_LOWLEVEL_INIT=y
> > +CONFIG_COUNTER_FREQUENCY=24000000
> > +CONFIG_ARCH_ROCKCHIP=y
> > +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-gameforce-ace"
> > +CONFIG_ROCKCHIP_RK3588=y
> > +CONFIG_SPL_SERIAL=y
> > +CONFIG_SYS_LOAD_ADDR=0xc00800
> > +CONFIG_DEBUG_UART_BASE=0xFEB50000
> > +CONFIG_DEBUG_UART_CLOCK=24000000
> > +CONFIG_PCI=y
> 
> Does this device has/need PCI support in U-Boot?
> 
> If not, please remove

It depends, but I'm going to disable it. The device has an M.2 2230
slot, but it is not populated with anything (it's designed for an
NVME drive). I'll remove this and the other pci-e references.

> 
> > +CONFIG_DEBUG_UART=y
> > +CONFIG_FIT=y
> > +CONFIG_FIT_VERBOSE=y
> > +CONFIG_SPL_FIT_SIGNATURE=y
> > +CONFIG_SPL_LOAD_FIT=y
> > +CONFIG_LEGACY_IMAGE_FORMAT=y
> > +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-gameforce-ace.dtb"
> > +# CONFIG_DISPLAY_CPUINFO is not set
> > +CONFIG_DISPLAY_BOARDINFO_LATE=y
> > +CONFIG_SPL_MAX_SIZE=0x40000
> > +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> > +CONFIG_SPL_ATF=y
> > +CONFIG_CMD_MMC=y
> > +# CONFIG_CMD_SETEXPR is not set
> > +# CONFIG_SPL_DOS_PARTITION is not set
> > +CONFIG_SPL_OF_CONTROL=y
> > +CONFIG_OF_LIVE=y
> > +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> > +CONFIG_NO_NET=y
> > +CONFIG_SPL_DM_SEQ_ALIAS=y
> > +CONFIG_SPL_REGMAP=y
> > +CONFIG_SPL_SYSCON=y
> > +CONFIG_BUTTON=y
> > +CONFIG_BUTTON_ADC=y
> > +CONFIG_BUTTON_GPIO=y
> > +CONFIG_SPL_CLK=y
> > +CONFIG_ROCKCHIP_GPIO=y
> > +CONFIG_SYS_I2C_ROCKCHIP=y
> > +CONFIG_LED=y
> > +CONFIG_LED_GPIO=y
> > +CONFIG_MISC=y
> > +CONFIG_MMC_DW=y
> > +CONFIG_MMC_DW_ROCKCHIP=y
> > +CONFIG_MMC_SDHCI=y
> > +CONFIG_MMC_SDHCI_SDMA=y
> > +CONFIG_MMC_SDHCI_ROCKCHIP=y
> > +CONFIG_PCIE_DW_ROCKCHIP=y
> 
> also this one
> 
> > +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> > +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> > +CONFIG_PHY_ROCKCHIP_USBDP=y
> > +CONFIG_SPL_PINCTRL=y
> > +CONFIG_PWM_ROCKCHIP=y
> > +CONFIG_SPL_RAM=y
> > +# CONFIG_RAM_ROCKCHIP_DEBUG is not set
> > +CONFIG_BAUDRATE=1500000
> > +CONFIG_DEBUG_UART_SHIFT=2
> > +CONFIG_SYS_NS16550_MEM32=y
> > +CONFIG_ROCKCHIP_SPI=y
> > +CONFIG_SYSRESET=y
> > +CONFIG_USB=y
> > +CONFIG_USB_XHCI_HCD=y
> > +CONFIG_USB_EHCI_HCD=y
> > +CONFIG_USB_EHCI_GENERIC=y
> > +CONFIG_USB_OHCI_HCD=y
> > +CONFIG_USB_OHCI_GENERIC=y
> > +CONFIG_USB_DWC3=y
> > +CONFIG_USB_DWC3_GENERIC=y
> > +CONFIG_ERRNO_STR=y
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> > index b88299cbba2..941d729dbe2 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -141,6 +141,7 @@ List of mainline supported Rockchip boards:
> >        - Rockchip EVB (evb-rk3588)
> >        - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
> >        - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
> > +     - GameForce Ace (gameforce-ace-rk3588s)
> 
> This should follow the alphabet order.

Sorry, will get this fixed too.

> 
> 
> Thanks,
> 
> - Kever
> 
> >        - FriendlyElec CM3588 NAS (cm3588-nas-rk3588)
> >        - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
> >        - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)

Thank you,
Chris
