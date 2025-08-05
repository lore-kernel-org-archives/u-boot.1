Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FEAC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C0C8349B;
	Tue,  5 Aug 2025 08:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KrQIyWs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C194840E4; Tue,  5 Aug 2025 08:03:16 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7219F83327
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1mgV6H84miyyz+zkHQ0/LyGMG3GxoiCvpBkY8YWmNISEVBxQPzHTz3kFLc+i/vKLMcvZYkzELSIamTuoXesY1IZISrficDevTxF8p/WQQcwTQ//XgYiWfK8epezQeqIqOh/sjz+LPPewDomMKNNzx8/chyeyYQeVJwiNyQy8XHjbd5iUaYU7gaa+n82muHvyI83GtPkYJTDfKERZDXG/MoTFFnBlHvYAAj5rPELGaIBWvdnU89yeaYltZVazHdUv7hpbmOUCr3Ws+MyFEzDNfl+RVzWZB0T529M8kJXBc/xR27ihG7idRlRckDsH1rCUJ7UUXEQXnyfRPuIOCos0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye7Qv3k9PPjn1FlrnVVsEUMAx9H4ib2X97/1qD+3Vr4=;
 b=jZLeHE8RlRYVdgsMCaAaYmYKS7ADSHkhqTqyPuyyJdTdxxL/4cOjJWkStOjP4h44boj3cEqpf1mmKizgMd6GDNFAwP/L4NPUI/5+xk5htN/DN/KWmaxoZTJLhYWugC8vkWzigAUf6juXE3ox2GmQ9Rp5SS9EMHof37U6CM1DsSarJhjAQ/g00hVlObGMKb+cZ8vh6ITiLOSAXvZmhErY+hCTuQxJXx6RNW9ym2RgIGUIh+KScFDw9+o94JT434RyZ1VCN2T19vJjM7V4gPOpK2bxZEGkHF7w2HGcUNCSe6qH/itzer8HR4wZy87CaVqyIV2Y6efhicZMOkFP5gXjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye7Qv3k9PPjn1FlrnVVsEUMAx9H4ib2X97/1qD+3Vr4=;
 b=KrQIyWs7odwpa1h32kLtdzT3KB77AUGPHAdPeJIUAdVj1EwJB05i2ekdn30VCLvWqmc+hEvpdpK2/r4WRFcN1xVhiUEC3L1MB5y26qhLuPVRpRv+4N4WpXwpScApd92UCjgZj8U3euoZefQpQtq6pTCkFOqP3r1aGFTlZbbYEutX5N2HxxKerj1xshQyYiB0lijt9qlAwUtH+LJttDRNMrXGs68uprVZT4q2XOK26y/9J2CwVUuk+jdJSRA3iVBuapaX2BTJ4Poygyn+Y+Q7j3yxezBNcOS1ihOleyMxyM+48kpPl6KbYMlJj8gooIa5UxezB5xjCCvSbvQ8+CkPhQ==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MN6PR03MB7576.namprd03.prod.outlook.com (2603:10b6:208:4f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 06:03:08 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 06:03:07 +0000
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>, Marek
 Vasut <marex@denx.de>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Thread-Topic: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager address
 via clocks phandle
Thread-Index: AQHcBNlbuv8x1LOuUUKxpoyYzAEHfbRTc1EAgAAeuLA=
Date: Tue, 5 Aug 2025 06:03:07 +0000
Message-ID: <PH7PR03MB7063F3EAF4F0BEC770E333D3AD22A@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20250804004710.10222-1-alif.zakuan.yuslaimi@altera.com>
 <20250805040750.GF29103@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250805040750.GF29103@nxa18884-linux.ap.freescale.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|MN6PR03MB7576:EE_
x-ms-office365-filtering-correlation-id: e3ae6e96-d88a-460d-4a01-08ddd3e5bfee
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?D73OJArLYD8ATUmcUYQ0T+9GNwpKNIcuDz7yDpjQq6+56aRvabmYeiEhZsOW?=
 =?us-ascii?Q?j41dMm9z8fO0boBpiRBY7T1BzAninfL3J0xMgi20a9pFjv2luyJnH97fSf8v?=
 =?us-ascii?Q?pvZMGIgdzZmRdcmQZYHK1AhHNr9Zs7vHA3s5o5teMcDneP7zPnc4NxSXfrgt?=
 =?us-ascii?Q?/0hFaKlWNhPvAjYVvtUYk96nT1J+brRdjgfzsxFFcq1A++scgjw5oHWdiZV2?=
 =?us-ascii?Q?1KXG6XFeuwgHVS9+hKkjtO7s7UNP1DMIwt0FuMuzpUqXpuqJR5INPoBeH7OB?=
 =?us-ascii?Q?ElnTfKWl/AFEsUmX2QmCexJE0jyN5xcrO+ZmkrYFHO3kpBDTCdlGYb+dZFgQ?=
 =?us-ascii?Q?ttFxd5yd+1nOIs7joKQ2w+Br1avUncyUoANefuvU1ewEZFpoXoHj5Z5qxEmV?=
 =?us-ascii?Q?oxLdf2k7mD+wSdK2fGFZn1CBM0UNe5F8fhyCcD7VrYaw+d9oaRJYbkm5hhXv?=
 =?us-ascii?Q?aXEQFmVFbfoNuXX3YrUW/W4AtqOfiFmgz07b7fnx/O+19iHWfHySgLGWGOH9?=
 =?us-ascii?Q?6k0tLF++k4mbZy+lrvObF7QPDQsw7A6MA5gOmO2u/KuRrRxseRpKRl64aPTr?=
 =?us-ascii?Q?y0frQ6DLQZuGUWqfzxARSR0/JahWeDlCfMG6H+mu92LRCG8qL+18TsCmwuRZ?=
 =?us-ascii?Q?cwtFwocvGY3pHFl6r3Oz6NkaR3DhR8BeP85U3sEp/4lkyHn4DYaCEMan34j2?=
 =?us-ascii?Q?zbO+s7Hhm3xmW9h7se3T109YbzaxV1AU36BqnclczCBV5hwkd/JMiS3SeOFe?=
 =?us-ascii?Q?vZzu/doSGxr2Pie5CA4WxNXpFpOwzZTD+kv9xepLC/aGoPudYlrWWL35LTsc?=
 =?us-ascii?Q?34IplmYA5y3A0zE+zCdnsWDTaZZgQKbuPBpAvfTdFgSdWhadLWH8SGad3l2E?=
 =?us-ascii?Q?tpGzAtNs0jpxcWz+zcJuk44C4cf9j7Sk3sFKpA0/Q5noCbsm27tu1by/hutR?=
 =?us-ascii?Q?mfaTGfBO67ZaBucK+v0VPW5jB/71x/t2PZ6FXgb0Psqc3xZcOE315sHnkg69?=
 =?us-ascii?Q?1BkzcIXOgZACCO3QFR9UAr25/4TxFAOmP9Y3MnoYDejloM+HQVpLXTOrO3kC?=
 =?us-ascii?Q?1LhJ+68tA2Oz73dZCJdhAAMxzqoc+8YzZSNC6z3RrwrUlGnpCOrTBLoQZELW?=
 =?us-ascii?Q?Thr+RB6EtouR2Bfi6y0NkqD55NcYJxXPwW1p0doLmyGssEXzvURBOHjOoNVw?=
 =?us-ascii?Q?eRvrKt1IemoZSezpKWRk1z96y/Sblfs7nCI4I2qRoGZ3p66euLSFrZdl8NPv?=
 =?us-ascii?Q?+IxzYiARPsNcX9HQma68w6jCrAdT4ddJGWBWvkVnDQGLS0isgoy/LUZFZodk?=
 =?us-ascii?Q?2rTHtOBRXkT4aMVYH5j185BJdQuLbx10scwcyfzVnxQqzUsLk7R9W5kwh+8X?=
 =?us-ascii?Q?GL5+XmCp+DhNlje1LzRW0fomege4+J1ijmArv/BGqFySe++h9Mi42xw22Wcu?=
 =?us-ascii?Q?VaRC9x7Xp2uf2mBBA5E3tVOsK02AA+2+w/Jw5pPXQqXgd8X11rwQWA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUgNl7v8oFhohFVLcyrnA+61lVbWfQwePluQsvpVOZWxFHee57eYZxBxCaRz?=
 =?us-ascii?Q?+11uaq4nnPOnBbs3TXSG/qEDLltL46K+Y7y70XWWEKZNeXxqMmZKxT68UXzR?=
 =?us-ascii?Q?TH1LiSUFqBmhXA5FZLYr9rZZhzz1VtaEFJirQRAvaU9t1ETsc3iz/HHdUxnW?=
 =?us-ascii?Q?/Ori2Az6L+WQ2/ljxkOgIqfzphPCyhvOQ3BXqKn6+0EIqtd3JVxTEpJs0PM1?=
 =?us-ascii?Q?H0HM7nWhLtGmeRmfHFsPPjsuzUCJZY5Sp4qBdVtEk0uSn4xpveiAFR0QCLDn?=
 =?us-ascii?Q?fI0n2AM9bM+QI5QPTcWXLSa5klRBvbw1eoRUYcHDlWtJOiDOJovurIXDgCeD?=
 =?us-ascii?Q?cBqL9M6/7vvGfFH0OmViDs51GoKAoE5sx0t1r/IIW2ZvAACsltyLlkQiJlG3?=
 =?us-ascii?Q?GeJ28A6Tk4T/uhFzlivoyhEcKFt0wt6UmK0I0DI9sQsiMXnGgToLOalZT9RW?=
 =?us-ascii?Q?0SqoXgYxEVpN+EOzmRrMd1sTz2lFEAtBI9FV4TMrjYL/dSkhY5g5TcXdanrx?=
 =?us-ascii?Q?d9wUlkbAp+7IT/GFAY0kn5M9jXtdjEfBjY5oBiXZ0LNlq+k1musN74/oCuH/?=
 =?us-ascii?Q?ijjbGfkSH5CIjZUvp6Xzb9vx+yro0dxcgx9kvd9saOkVOtZTj3V03A3wlJ2z?=
 =?us-ascii?Q?3U9c0UBRXCp0kwy7zWHPmD96OD0bz9OBW4LuX2wMTc1gpKrEdCJsrPgwBE5t?=
 =?us-ascii?Q?1ZCwMv8MsdeQv3y3woyFqVV3AqwANA/QThFYW0lRWLDeTtDZ1NSYXSMaYU6Z?=
 =?us-ascii?Q?Ftv05HHXJK1lq9U/wnRqbyegLSJdipibxgzi/dQQPlj5+lLCask7ly8M1o5E?=
 =?us-ascii?Q?Cc9Wh6s0vwxDKqit3zPT4jPzHXUfaBwNvvRUR8ydNsOySWAR3/4j2US4So/S?=
 =?us-ascii?Q?5Cmnycb4VtTxX940zoSRnZDYk/o0lMFqBPCphCcwaFObzouYh8Zl6GoOUbmp?=
 =?us-ascii?Q?/iBeav7L0/wnY4fg+LTxblK2LwXL0HL9nc6GuMW5GmPqdpbGqdM9N1u7za+K?=
 =?us-ascii?Q?Cm/WvvT02jtnu57gogDoJhl9yhKIc+YcHccnkRIxU/d/ju5CwFnjrthDHMMu?=
 =?us-ascii?Q?UZw3S23oKlqLE1eOBLWv8uUDvI87j1gvYUQgT1ZJK2wmKqP16wx59ZpX2JFq?=
 =?us-ascii?Q?TkoZVinsvHc3vQ3I2D8RvGxLZCBjmDro8EH/ZhXgdQH7wUIpfKRTOvillj+n?=
 =?us-ascii?Q?KcBHPv+djdCVBnpzjL0q8pXj3/fm4umXzPUnezf5y+s26EG8tqilDfSSOMtl?=
 =?us-ascii?Q?6NnLtZMjVIIrIszNQ4pvWpXtqBSJSIdhvoeW+JruVrYeN8k/WMD653gSJeOb?=
 =?us-ascii?Q?QVTV5AzOURTej5rCMrCNS/4FMv2MW152J3Ox4hVMaBMcXahkJoO3nNJCQ72E?=
 =?us-ascii?Q?mEWfWdI0FnWP9DNvYaTgINeCu2uVSUgXsX4QbmtsOz+FCMSWr32hB96RTTU5?=
 =?us-ascii?Q?lqgBRDnft4mgbpY3+3oZ5OsHv/VKeyiUZVXKvmDzKLHS/JDj65WGbIsLbtrV?=
 =?us-ascii?Q?eQLmy92JUQdWszrJuZ+u6RqDjXfm2YlMCmCPKqFgybuel8dPPy3vRYllXjDc?=
 =?us-ascii?Q?9aOkDM3ZM82S/8AHqLjbrOH4B1ABt4g49xcOAukXU2C9MNsv2sHo2x4sgQXd?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ae6e96-d88a-460d-4a01-08ddd3e5bfee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 06:03:07.7172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpsqjIpHIaD2DoOU+FGUJ+eYJ+Tyg3qr+IxGwTNK9GToVWk2dT6Cz2Mtr3P5i5WZEkBBhdSXz6ytrOcTI/COwiWs+ldLuGlXIXFkW3QQhBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7576
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

> -----Original Message-----
> From: Peng Fan <peng.fan@oss.nxp.com>
> Sent: Tuesday, August 5, 2025 12:08 PM
> To: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Cc: u-boot@lists.denx.de; Peng Fan <peng.fan@nxp.com>; Jaehoon Chung
> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Marek Vasut <marex@denx.de>; Simon
> Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Subject: Re: [PATCH v1] mmc: socfpga_dw_mmc: Retrieve clock manager
> address via clocks phandle
>=20
> [CAUTION: This email is from outside your organization. Unless you trust =
the
> sender, do not click on links or open attachments as it may be a fraudule=
nt email
> attempting to steal your information and/or compromise your computer.]
>=20
> On Sun, Aug 03, 2025 at 05:47:10PM -0700, alif.zakuan.yuslaimi@altera.com
> wrote:
> >From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >
> >Improve the current clock manager base address retrieval by probing the
> >clocks phandle under the mmc node in the device tree instead of probing
> >the clock manager node name in the device tree.
> >
> >This will help to make the driver more scalable for more families as we
> >no longer need to rely on the exact node name in the device tree to
> >probe the clock manager driver for its base address.
> >
> >Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> >---
> > drivers/mmc/socfpga_dw_mmc.c | 19 +++++++++++++++----
> > 1 file changed, 15 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/mmc/socfpga_dw_mmc.c
> >b/drivers/mmc/socfpga_dw_mmc.c index 3b86bc9b18c..ff1dd0055f8 100644
> >--- a/drivers/mmc/socfpga_dw_mmc.c
> >+++ b/drivers/mmc/socfpga_dw_mmc.c
> >@@ -54,17 +54,28 @@ static int socfpga_dwmci_clksel(struct dwmci_host
> *host)
> >       u32 sdmmc_mask =3D ((priv->smplsel & 0x7) <<
> SYSMGR_SDMMC_SMPLSEL_SHIFT) |
> >                        ((priv->drvsel & 0x7) <<
> >SYSMGR_SDMMC_DRVSEL_SHIFT);
> >
> >-      /* Get clock manager base address */
> >+      struct udevice *mmc_dev =3D host->mmc->dev;
> >+      struct ofnode_phandle_args clkmgr_args;
> >       struct udevice *clkmgr_dev;
> >-      int ret =3D uclass_get_device_by_name(UCLASS_CLK, "clock-
> controller@ffd10000", &clkmgr_dev);
> >+      fdt_addr_t clkmgr_base;
> >+      int ret;
> >
> >+      /*
> >+       * Get the clkmgr device from the first phandle in the "clocks" p=
roperty.
> >+       */
> >+      ret =3D dev_read_phandle_with_args(mmc_dev, "clocks",
> >+ "#clock-cells", 0, 0, &clkmgr_args);
> >       if (ret) {
> >-              printf("Failed to get clkmgr device: %d\n", ret);
> >+              printf("Failed to parse clocks property: %d\n", ret);
> >               return ret;
> >       }
> >
> >-      fdt_addr_t clkmgr_base =3D dev_read_addr(clkmgr_dev);
> >+      ret =3D uclass_get_device_by_ofnode(UCLASS_CLK, clkmgr_args.node,
> &clkmgr_dev);
> >+      if (ret) {
> >+              printf("Failed to get clkmgr device: %d\n", ret);
> >+              return ret;
> >+      }
> >
> >+      clkmgr_base =3D dev_read_addr(clkmgr_dev);
>=20
> I see this driver use clk api, so why still directly map the clk manager =
base and
> configure it. Shouldn't clk api be used or assigned-clock-parents be used=
?
>=20
> Thanks,
> Peng

Hi Peng,

The direct access to the clock manager base and offset in this driver was i=
nherited from the legacy implementation before we had full driver model clo=
ck support. Currently, both Agilex and Agilex5 have their own clock drivers=
 under the driver model, but the `clk_enable()` and `clk_disable()` operati=
ons are still not implemented.
=20
Because of that, we retained the base + offset logic for disabling a partic=
ular clock in the SDMMC driver to preserve existing functionality. Once pro=
per enable/disable API support is added to the clock drivers, we can clean =
this up to fully rely on the clock API or use `assigned-clock-parents` in d=
evice tree where applicable.

Thanks,
Alif

>=20
> >       if (clkmgr_base =3D=3D FDT_ADDR_T_NONE) {
> >               printf("Failed to read base address from clkmgr DT node\n=
");
> >               return -EINVAL;
> >--
> >2.35.3
> >
