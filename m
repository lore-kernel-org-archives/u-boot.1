Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971D6C5AD5A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F24E340969;
	Sat, 15 Aug 2026 13:01:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXp9TXIprasf; Sat, 15 Aug 2026 13:01:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 282BC40947
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786798879;
	bh=cRTqe/scpTnS7yf3dOR7Gz2byNhgsk/MUtbXbWkYOsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gAFrW+XJwlk0aHk7l4t+Se9F+wBlUkwx8UvH3Uflk50QcwUnMzOw6w+1fnJYHbr+O
	 94gzYCXi/otsoLuXPyWq0TNeB4BJGo5B7s6XtCs8DuO/o6pY6JUS4YIgge+GW1IJQ9
	 9hYwOlWO3GtnQaRu8qqqEBUdNwCPCDYfwLCURmX6o7MOUBnH/I2ddy2HIT08g26lbe
	 J1Uih4lG6goeVVssqGaHYrgzqDyEG/3QZJS+jb/zJW5aDiO8txp6qQIAd2iE3E8R3d
	 YoOsod3lbp1NfZvTvOn7XZTKJL08ZxkaCbnbHjCLaVh+1RFKb4jPOXuaKRS1rMiSRW
	 I7JRZX0iAF7EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 282BC40947;
	Sat, 15 Aug 2026 13:01:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6857C2B2
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 519528109F
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ijVCZA5qjKYp for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 03:02:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:d001::1;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=macromorgan@hotmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 866F780F87
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 866F780F87
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=p8yOz/bO
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d001::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 866F780F87
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 03:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcnRFnQUVrph7dTVC8foIyX4r1m8EtNiWN+twcQMMNxy0sPPgjtoLSalvNI9bnmDiMuU611inT/gyKycJLK+qEnKu3VpALjqTtsIC3eDrTpwjwo+KpV79kbA8hg1IyMcpxZJqTAOYUbZA+nyhZwTkNtuMa8h/TeSwbD/vSnU3bRWflM3pxrThYH/fC7ATg3+9AT3lXgMiJeh0d+AcQu2dEJWlyCXVzpHY/e19kZsKNtTB5cI5Y2sarcjahIz9ib2/rWpE8twvM1DrIVpBfxJ7LDb3g1Uk9ySQ2zVItePhdrHYOvczX2qyqbcDJ1bWCdWTb1eAoCINQnDu1ug7Nk7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRTqe/scpTnS7yf3dOR7Gz2byNhgsk/MUtbXbWkYOsk=;
 b=MUq2Ju0o0vGzQ4OY5JBSR6aazY+nqWGK3xUZAobrqWhODUeIsMtk0i/bQJQ0ct+NQPuB+XK6jbPWuCDbLslO8lbsiOUXnIU88v7pducyOuZ29/NkRlIC/6SOorDrK0DkkhXPCPUaS/vwjkrdLNG4Z+EuUFQKEbct+IuZmCs5i6LQrS/Ir/PvRQYG7C12B2OZwln7Jm+Hk89Keedk5SK2nhqO2JugtMNz1RWVC7F43ZPOIu/HHbmPKJDdVUAOJJbNF8h7JuKctNnk/UowAUHVi0u1kRcgxTr/VIIs0pR55zq4BEY2uEtzfJR2HGrnD/rTN9PjachjWSYq4+GUV/vJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRTqe/scpTnS7yf3dOR7Gz2byNhgsk/MUtbXbWkYOsk=;
 b=p8yOz/bOyu3IkXOga42X4RqdrotkWLfNchFRO4Pab4s7rFBWNpChCydFkw+OquE3s0taMm5zaKNuUVl+pDEGfIQCx7SMz+mIBZrHvbMFIb+z1WY/bGfmfSiMTI4StmSLoLT+39gw9/Rixeq5tD/W0D45FoEkUX3RXZBlzw/2MlyD1wJjPgJacfkxs72yk63mUN01ujXJzTJ7KR7rrt0vTzyoDzKYbSHypwS9pCPsoM60BiRsPA31FlM/f4me3PSZIOy1FvBozGRSwULCHein/XkML3yMQYllgNUYtd2qNaHLJ7y43F7O0e9btsfbyBPCITgI3qQ3mNdDCDB1b6+fTg==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by SA3PR19MB9552.namprd19.prod.outlook.com
 (2603:10b6:806:496::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Sat, 15 Aug
 2026 03:02:06 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0315.014; Sat, 15 Aug 2026
 03:02:06 +0000
Date: Fri, 14 Aug 2026 22:02:02 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Daniel Martin <dmanlfc@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
Message-ID: <PH0PR19MB997338CED14F7601911D6491D8A5D92@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
X-ClientProxiedBy: SA0PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:806:d0::26) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <an_Wqkp09sxijfxv@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|SA3PR19MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: a4733a67-1f95-4391-a94a-08defa79965d
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|25031999004|19110799012|8060799015|6090799003|37011999003|51005399006|23021999003|24021099003|55001999006|12121999013|5072599009|25010399006|40105399003|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qaeCxvWB+6jRuVOAiZJc4xXNo8Oz0kALenPhEwBA8xultH07GR32xZ9XVUZ0?=
 =?us-ascii?Q?aTpiMCBL//YzBXae7iI1TFse7N5PpvgQBOqg4LKFvFGJYdSB7G8POTno4jpK?=
 =?us-ascii?Q?lyNgjr3KQkHPASCstuQtIXAeOEioYQ2C2887f7d96dRe0YY4N09BJFe6i1Rb?=
 =?us-ascii?Q?gh5vPI6dYW4zeqUyEehlTngJJ10oN0lL3SHBbuu/ye99FtHisrl++M1lS2aV?=
 =?us-ascii?Q?87zIN2khmkWer4p8c7I6y03nsGCO7wEKfSPz9IrKSeZhRUJyUmm6oMWi2KUf?=
 =?us-ascii?Q?+aK7ITQMNvEugxj6tiJJ/76NXFxnegPFaQ+OxbZX7IGS5jH9UTeBRI/kilzv?=
 =?us-ascii?Q?NTEJqtw8D0+wHr5SCseMh7LKnD9NLRsSifCeT3+oUXYNbt2k5Y51oZ6VwMol?=
 =?us-ascii?Q?dyxNXKehmVN2GPVLNqnXUWK2tAQvdifhLISPh0QVMo58MqHaDbyyF/fdOvhc?=
 =?us-ascii?Q?VdDV4TtZnwfxSDdLp+n4b+aKNH1cQdJ5ihBlpSTuKZ8AiMc8eeOEApEwx9Dv?=
 =?us-ascii?Q?QEYhyqTmJAennt/Hlic750SsIjzEP0eDF8542CW7K+d6w+8n3uRItDPys+GL?=
 =?us-ascii?Q?uQVNWHrfIzrZisC1dlC95EEQOf2vMj0FFogEWg4qey2ivtg2nwS2GhuNGJwc?=
 =?us-ascii?Q?70rFIfuAfXjO9xa2fqdcWSc/MCiTk38UxNnNe171PW2YsIKlXkk5yvcsdeYr?=
 =?us-ascii?Q?YKbSHIGVEH5o7eByAIXaclTtSjf9KJfegVRHJWKJtPeRV4BDfyo/YTU9PzX1?=
 =?us-ascii?Q?ixjrh/sPNKMZj4+KkdlwW4pzbxJRkj0Ye4BAR+ViMYzJPNUarstmmG5Zmb6K?=
 =?us-ascii?Q?iuzNlsE6EINuqv3ktyiPpKiK2G6vy5v94/EnBsshP6SFpwhhdoi47d5ulT5a?=
 =?us-ascii?Q?mTHxOVPOXLIBBG49rfPLk3awc03avOSk3RZ7A8coSVwl94I/HnGJSXASLjEx?=
 =?us-ascii?Q?2PRnEI9mJ56m2gbgWNSPa+JJLCUEgHkkBvDO47VX32jYFiVs6d68OqNYxCGU?=
 =?us-ascii?Q?PgR7574O5t5FGDxqAJWARVrT8FyWrpshC7Cs/AQeJaheHAXwgrh/owneCEas?=
 =?us-ascii?Q?6H5MeZrribdjoGzoLIf0OZdaNk5NgTsJw/cAM5FKBqcGGF+Meqk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCxeBE5EwH3h1pQer1RNLX49sXPzQvSYTI3+1UIhIPC1w2aqTvuc7q73IMua?=
 =?us-ascii?Q?vp+1PjFQZAOd3mUOlp2GheXCIr6BRg9mA2/S3Bt/l5NciYHv+chIu2lf90CX?=
 =?us-ascii?Q?0TCVSEdajybhAthjY1yYAa+MWihc7X43k/ajzOWg+/G2ZHeKh09e0YRVVSwj?=
 =?us-ascii?Q?ie5xMaQkY+E9G50rsGaSaMEd8Z4K4ykA7QoDFCdz5mK3o0SbYs5Kopv//Y+2?=
 =?us-ascii?Q?z5zpaUElfkdNov5GnVIhRm0XVd3r8xuesAx+5bRfq0oO5rkdHlYsgOuusw8M?=
 =?us-ascii?Q?T4aXZ00tQCaIARtuuRc+88fhJmH1TNejS/UxhRzKlde4B+KZ54yEzo/LVLj2?=
 =?us-ascii?Q?pBPg2oUwQ1HDOiFCKMMIRdnKAYSYXx3dNRn2LBiO1FM1jLvOWnQj+vaA824u?=
 =?us-ascii?Q?vfo23Q4BlYStbwZn2xLE0hdTe7jGPPSl9FRFsD6I2N4JqNMlJSSgQ6pzFbQ3?=
 =?us-ascii?Q?Cb11T6BcnJGNlHpJoKIucIy5jIRN5hOzvFFZw4nAUf+dTx5XrQABWcuEKfdq?=
 =?us-ascii?Q?hF1TqL1UM6RY9D+aCCIIMa4KXofyYIms6yLDWRVLaH//f1Q+eAfWDA6xYMYF?=
 =?us-ascii?Q?p7mjs1kEh5/8oNyHkbqK/EenfWmJor5+cjtZNfRQWoLWmk7ByszjpoMOTXKO?=
 =?us-ascii?Q?YebmqlVSHaVKIpR2fuIb71w3EdabeFXDt8jJMhZkiYSa9ZNX4SOexrhOccJu?=
 =?us-ascii?Q?24zx908Ppx1h15H/9p+ABY7peR7fAf+4GEDoWnTx4m9omJSZ6O3XGGnJDXoy?=
 =?us-ascii?Q?1/ORcsJeGgOhP44vNdYiaehpDI3WcMwFUMyEDVLm8TnNRMgFwwu1Z+t3mjC1?=
 =?us-ascii?Q?ieTC+gfr1kROL56tCqcMOX1rfD+a9K0IzD0Wi4wPCVx1b9W0xdasJ8xAJbeq?=
 =?us-ascii?Q?QDQ9lgEFUB1dTl/CUO3UwsHc5ItU6/DMQL1Uc5W91ogh+cRqk+WRIvG+dI5Z?=
 =?us-ascii?Q?EE/xte3AfwrUGcH555YP9PYm5pw2S+hYLq0itZcEKWnIk91Cyu9i0vFeSk+w?=
 =?us-ascii?Q?+IiHhLT3cxB7N8aOG4hoT+XRtTpGIM7WPOIGNhWMIJpKMNQufOnFeh+O7qSi?=
 =?us-ascii?Q?MmbztOrksb1NaLJk1LjDTs11m55law08vV3V9bOqVeoWCplAEEdpHEwxELH+?=
 =?us-ascii?Q?N6kSyYQACIenKkdNkxYyrddBl6KFENCKQ5Sq6CxV3w5rAyQQ+Rni3mIeUwNm?=
 =?us-ascii?Q?vxhI/1iDiJmqoqUoahfs3+qfrxqYMmzw7WMgJk/Ar1jxPsq+N5m7gPpz+kHg?=
 =?us-ascii?Q?5hMdJJABKN1B+KKC1Ofh5i5euMIz6p7eEB5BGcxlSLXSo2W2Fzq7wRM5Uq9g?=
 =?us-ascii?Q?eHQWv4oD+jez0fsv60jyqjfuO9PKorNOcO/3seqMcijkLABbAHRrIfgWwXwT?=
 =?us-ascii?Q?piIGXx0DFUEgF3qXSEC1LgBVB8dHgdH+qXflG2OLtOmFuXJc6i6LuoDla3oa?=
 =?us-ascii?Q?NEvi5i7ko5/F4Se+dY+LIFZNb0eLCU+D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4733a67-1f95-4391-a94a-08defa79965d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 03:02:05.9734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR19MB9552
X-Mailman-Approved-At: Sat, 15 Aug 2026 13:01:17 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Sat, Aug 15, 2026 at 10:06:23AM +1000, Daniel Martin wrote:
> Thanks for the further details Chris,
> 
> It would indeed be great if we could move this device to mainline end-to-end.
> Let me know how you get on with v2026.07 and if possible, test your
> DTS with the stable kernel (7.1.8 or similar).
> When I reverted uboot, I encountered inconsistent I/O issues with the
> latest stable kernel, therefore I ended up going back to the BSP.
> 
> Thanks for all your work, we appreciate the effort.
> 
> Dan

I've just tested booting the device with a completely unmodified
version of Arm Trusted Firmware (checked out at tag v2.15.0), U-Boot
(checked out at tag v2026.07 and changing nothing from the
gameforce-ace-rk3588s_defconfig), loading Linux 7.2 (tag v7.2-rc7) via
extlinux boot method and it seems to be working. I do note that it
seems to be slower to boot since I upgraded A-TF and U-Boot to the most
recent releases, so I'll troubleshoot that some more next week as I try
to install a fully up to date Ubuntu 26.04 on it.

I know you said it's hard to get a serial port on it, but if you
continue to have problems booting it that might be required to
troubleshoot it further. Otherwise I can send you my binaries if
need be.

Thank you,
Chris

> 
> 
> On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
> <macromorgan@hotmail.com> wrote:
> >
> > I'm having trouble with my usual email client, so I'm sorry if this message is formatted weird.
> >
> > I have tested the device most recently with 2026.04 with the default defconfig options. I am using mainline Arm Trusted Firmware though, not the Rockchip versions. Using Rockchip's A-TF should work, but again it's not something I've tested. I can note that if you're using mainline A-TF along with mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=N, otherwise the device will fail to boot because it won't protect the Optee regions. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is optional unless you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLATFORM_PARAM=Y).
> >
> > I'm going to test the device next week and see if I encounter any issues with it. I'll report back if I find out anything weird.
> >
> > Thank you,
> > Chris
> > ________________________________
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > Sent: Wednesday, August 12, 2026 10:22 AM
> > To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>; dmanlfc@gmail.com <dmanlfc@gmail.com>
> > Cc: Chris Morgan <macromorgan@hotmail.com>
> > Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
> >
> > +Cc Chris who maintains this board and may be able to help.
> >
> > I somehow didn't receive this mail in my inbox, here's my attempt at
> > quoting text from a mail I didn't receive (and it's also not available
> > on lore.kernel.org...).
> >
> >  > Hello,
> >  >
> >  > I am experiencing a total boot failure on the GameForce Ace handheld
> >  > console (Rockchip RK3588S) when trying to run mainline U-Boot
> >  > v2026.07.
> >  > The device fails to initialize or display any output during the
> >  > initial handshake.
> >  > Unfortunately, due to the tightly integrated form factor of this
> >  > handheld device, it is exceptionally difficult to break open the
> >  > casing and wire up a UART serial console to capture early boot logs.
> >  > The target operating system (Batocera Linux) environment is running
> >  > the mainline Linux 7.1.5 kernel.
> >  > Given the complete lack of visible console output, I wanted to check:
> >  >
> >  > 1. Has the GameForce Ace board target been actively tested with the
> >  > v2026.07 release?
> >  > 2. Are there any specific or updated build instructions, BL31/TPL/SPL
> >  > combinations, or proprietary Rockchip firmware binary requirements
> >  > (rkbin) needed for this release that may differ from previous
> >  > versions?
> >  >
> >  > For reference, the build configuration used was: gameforce-ace->
> > rk3588s_defconfig
> >  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bin /
> >  > rk3588_bl31_v1.54.elf
> >  > Compiler: GCC 14.3
> >  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
> >  >
> >  > Any guidance on known regressions regarding this target, or
> >  > recommendations on how to isolate the stage where it hangs without a
> >  > hardware UART, would be greatly appreciated.
> >  >
> >
> > If you have a known working version of U-Boot, maybe start a bisect with
> > that commit as good and 2026.07 as bad to isolate a commit that broke
> > the board.
> >
> > Cheers,
> > Quentin
> 
> 
> 
> -- 
> 
> Kind Regards,
> 
> Daniel
