Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38451F9D0CE
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 03:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A99A83936;
	Wed, 15 Apr 2026 05:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UC5eL9wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8841E839D5; Wed, 15 Apr 2026 05:01:22 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D73880086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 05:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2wpU85+H+cLibrfgll+iBUJdj0CgS/3GNCFFfDNKjtWp2OAxMwMMcwj3XZJ1sKDPSDGF3A/u6nusI+s3vP0qsDcJXQfhnMOc1nlMy0q0+z+UDQwl0+afvbkDetviGPwh34lzlqzqAK5/NOs9cjI7OJXxIVXBPmPg2o5vH896lD2K8QFHfrnTuRzIVnnzhwZ9J28Rx3YFjLPI5cf8xGoQdiRwT8XvOuSTO4tPcxciX5mpxxT/yu9q4Hqxy6t8fsEvxMHbMLUydUEFzuSl43Ix01/BtX+dPqM7rPwh6sw70MMFdHkhOL5d0g+8aSQESaM09XeYYVqDbK5pXlhYuPzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow8TWXVfAuY0r0AWOeCENrbJrv4qYW4iuEfigsQBcbU=;
 b=eClFBW7wuysifJkQXtzcjg/Rty5xhdTewaaaSm8E6ZfhuQuKwLE6BwB1Kk/5diBNLCxE1QKfcRHHa5U224dAVi3TpSetS7K0FvRP46vPsub/EdVqOT5RjFwaTK0BI1pmf9WjF9muPXLMQk/Fbt46A9Fuv7z5hB4y98erlfXb0q27v3v/PJt3y1p8aAbJdP4uRSPxXYnMaNlS+bQrKV7jPXLnqXiquEOAMRYW2bpjJn7KseXY2dCIUoBuE76AUg0ZLIpi2Q17xNXJyGKx3E/TAFGjG5Nxn3EWlmCXjoFT25JMXUIdsS2U2IGdO7RuJY8yidN+2eXkPrdLjithx1gkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow8TWXVfAuY0r0AWOeCENrbJrv4qYW4iuEfigsQBcbU=;
 b=UC5eL9wis8vj2joSuVe93BqYLC3S8vbpowtBtg88NcwY9V30slE9WL+UDM6BpPkVF0EnjXIaygIuTf3KMQroeh9yXfZdZY0ZIR0lCdoACAenhou3ciRdrb7jovgw1cQuS00vl7XZs7tTZJLr7VXfPJekkQaHo7d1OgRtbzUEqPFGh+Eu5hTbXwDAdjsZiMGt9MYnC18gvj+us/8x96GdzCdHIpnRV0oT/I9YVGmBvrsdschWgED5xptsfdVQLAPuihnpjiG0cBDgS/EzNmzg3S/jqjHqa/7F+fmNrlVp4z/RzTujWSxESTAMxsz4S2TZoT0Vs+HKkHo5hTUwOpaD1w==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by BY5PR03MB5347.namprd03.prod.outlook.com (2603:10b6:a03:218::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 03:01:16 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 03:01:15 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, Brian Sune
 <briansune@gmail.com>, Marek Vasut <marex@denx.de>, Naresh Kumar Ravulapalli
 <nareshkumar.ravulapalli@altera.com>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tingting Meng <tingting.meng@altera.com>,
 Tom Rini <trini@konsulko.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, 
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] arm: socfpga: Gen5/A10: Enable Designware watchdog
Thread-Topic: [PATCH v1] arm: socfpga: Gen5/A10: Enable Designware watchdog
Thread-Index: AQHcp8XzLz9/aGGJl0+IfBQQI9f7nLXfuI6U
Date: Wed, 15 Apr 2026 03:01:15 +0000
Message-ID: <CY1PR03MB81211A0B4E95419D7CC49235A7222@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20260227084856.21468-1-boon.khai.ng@altera.com>
In-Reply-To: <20260227084856.21468-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|BY5PR03MB5347:EE_
x-ms-office365-filtering-correlation-id: ba4ff365-6c01-421a-90e5-08de9a9b4266
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info: DY2g1DC77VP/OKFIWQlN1Yb6cq6RmOzAkvAtHmgb4eaQhE+9jX1QRc7kZ0R6jw0JQo1Q8mInsPBoV98y75zUpsU3XqEdRB78N7a2wcp7tm/POxU4ndZCOfSmdEQsXrOub7WNhp18FI7djKo71sapMROGHjOto5kOS+jLfl/upQmuicOoWML6ihrrx15CnkPWR5wqqRylVdpsSrA1R6CTBcck1ozIY3D6uWHyHjU3DfA1mNkBXLtg6/mp1RSWPMRriUWs9nbmm+VQE/WHrQVoORSe7Mi6bFCYnY83/1FTuVW4tE4mxnBVoIpD3ATl5nvW4B6xQuLou4vC1OKh+/Hnqnc5VL5GZA9AmMzwrTsJtX9jJS/+jP2EqYalq3n5o5DtgxOZeAUNGcBzNbE5sAP3UJ/G7R/UbTAn8jfHKsrMeutpMBpL0ROMQQibujewdslJpzVHFxXR7uRylQZ1B0zKVt2pOLHehCRq8GvgJsmszXqlaqwN8C4lchtudnGyUYApCqfvnGtobq33r9JFLGtY5OUmueG7jRomJZICH+2fwDWXjpF3tyFMDGMFUT1wvbGa1D9R8Ic/gB5+S2D9ERM7/ZpEOwusypRSc0KZGeATlaOe8EtzWC59zFVZSDdyBgN7I+tnoQr2kHWnYEYgTVmqyPG+MBB8ckmR3eqj6hKWwx/ip5nC0KD1Fbf8jkvwzBfq14Grnc4NCh9wsZiTtkJ47sx201YYr8onSCCIJs5CFfbN06V8fzVg1+O75B3BwrCpuc4e7qUDHW3ZvsxtVYkmj+3BRFf8v++WsGEsrrQUAUI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4bf/H7/4mK5x2y71ovdqdvn8dK0U4djzC/GEr1FnPWhjGrR2vXk6mvmive?=
 =?iso-8859-1?Q?sJiiOqCvXRr3EQtFx5NuB+sNxDuQMt0SqSPqemFf933xf7gwhptjPFMla8?=
 =?iso-8859-1?Q?mxH3NF2m7w3TW8H/tAaAQ+jg8aiBEvfNUq85wOBhhED3XF3ENkbmBJGsUP?=
 =?iso-8859-1?Q?QdrUx9DtYUH8BrV2jFLdp7+/WWkFO0AE9wVtpa0s+hxpnnuj22G8egSbzM?=
 =?iso-8859-1?Q?a+sGnRlDlIst52xmRWOMS3r1yivZpY0YDyLuUD/jzOKUhoYfg/l2XZROSR?=
 =?iso-8859-1?Q?ZxbeaS6dbf/qV+/+dbWVFx4Fs/yXZowVhYSz8PHdrxyu/Iu1VqCtQqqgCN?=
 =?iso-8859-1?Q?HXFJg20MZLBjPitnEIJzbnWPjn7pU3JAzTtI9GxZiqx7YMTxo9ekuwVC51?=
 =?iso-8859-1?Q?O2xp+3/OE7M1RlPEG1H6CFURahz9UH8eY9BHo4MwLQqJRpXCfyGyVTddKj?=
 =?iso-8859-1?Q?rkROO3C8nyK1njI1ZNLPM0AZ4m2Itk2ti7Dut/pSoHZfhvmvskKEKp9ao1?=
 =?iso-8859-1?Q?4Lik3VdmDFperCHB7UOLXyKfpfpkzNYE6U8HZzIjcK6Dy4+LRmRlaL7Cmt?=
 =?iso-8859-1?Q?US5D6YwElG8blqd7Kv0g9v1ROEXNMHhDXyrSGOYOupNqDl5a5ZO3s/eNvP?=
 =?iso-8859-1?Q?fROG+GrTtJ2Uhb0f3QfKf8R5eQUowJhPu4u6UJLlC0EzWyJKhNTgz8goHD?=
 =?iso-8859-1?Q?5qdU2Xx97GSVrGXhqJlaznN//5XmWvlwpQohEiP5brsX7UQ6CR+G7yPgr2?=
 =?iso-8859-1?Q?E3cd4pFhux/j3yGncDj2C1ztRZSikgptUCW6K3jc80Ahxu4MZ3wkZt+ccN?=
 =?iso-8859-1?Q?KpUsV77QJ6gJWYxTe+JjM5w/l3nBTOkQBJr1ssfWEvQNxGexzs26AgL0hp?=
 =?iso-8859-1?Q?z7tNvfMN+s6KiFscA3levMijWnNr1qiCwDlM/IXx4x3UPXofP1YwrCHJ7v?=
 =?iso-8859-1?Q?9Fj/aNgH9exirjgUxQUkzExQhBenBY/1qkm/5DzeD3qBN5Q+O4+3dIEUMB?=
 =?iso-8859-1?Q?mbfHZe8USx6y1x3hgULWku3+SJEsy17y9x4r88GCka+o/kg/NcpNFZnY+H?=
 =?iso-8859-1?Q?DPq++9U6TXzMgCQQ6UNj0GekmhSByh7ZZmtwF4/FGj/m3ijoAb65IkmvCx?=
 =?iso-8859-1?Q?mXbYSBcP4BZH44nMRVIvsnOFZ9tYCu1oQLm+7nNhW3xUfM8YSI9kU5fsoG?=
 =?iso-8859-1?Q?2yXyrCl8k0AMxV9ynTwTHtmaR/Mp2i0Omo8+uowoKy7eyLt09pxuEiPvgq?=
 =?iso-8859-1?Q?+AmnuwnLqa7Pn70cWl4dec5+Cr3tySrPeausQWFN330gMY/GUGdTwg5/rz?=
 =?iso-8859-1?Q?8XBAVbBHav31qIedkGIQY8a9yNdXyB/SZyn8oRWheOe1/4DeWFdLEulMDR?=
 =?iso-8859-1?Q?91bO9NY/dQPOAcGNnU0PlFcTAxls9XFehu4v6rsMXNJKRIaRYHNvLhyHRK?=
 =?iso-8859-1?Q?dxy/7smyx/xyYynXhVr3528D1oe4n87a/tWYeK5QkZ6aZF0NhOO5TWo9SD?=
 =?iso-8859-1?Q?xEFjVutH7g31PNO22LtyP137yLWBPLxeaB9eqQjZIsCs0ptHNhT84Zprum?=
 =?iso-8859-1?Q?iFlvRioBEk6Nmz45PLvsIOeJ93g8OGIhxi17sPdYRYgN8SEZAHkQMVSE9V?=
 =?iso-8859-1?Q?82Toyh7dsy7FjKdFVbHHiRc4JgCQjvEoDnfAyjEw6Sv3h3T9XdTH4WA491?=
 =?iso-8859-1?Q?i4nrE7YVLT0jHeqzvDaAjD+aXRMVrf/8/PvvKaU/m4DSVyUKftkNqkJ0Fj?=
 =?iso-8859-1?Q?g6z8Q6Rgwg8B9sPUFSdC7g2E7rvy7KVPh0ManGnZVvHUG5gBM/b88L2MA3?=
 =?iso-8859-1?Q?E7DhiECypg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4ff365-6c01-421a-90e5-08de9a9b4266
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 03:01:15.7763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kkxd+p4l/rVAgwmuyzureNrlIhON2swjSR7FjQsORexvU2vIEKNMyqoR6zyuAVIWO6sdVgpqCknWLyJPFk84NZGKVUsrAlVB0tutJfJVhtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5347
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

> From:=A0NG, BOON KHAI <boon.khai.ng@altera.com>=0A=
> Sent:=A0Friday, February 27, 2026 4:48 PM=0A=
> To:=A0U-boot Openlist <u-boot@lists.denx.de>=0A=
> Cc:=A0YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>; NG, BOON K=
HAI=0A=
> <boon.khai.ng@altera.com>; Brian Sune <briansune@gmail.com>; Marek Vasut=
=0A=
> <marex@denx.de>; Naresh Kumar Ravulapalli=0A=
> <nareshkumar.ravulapalli@altera.com>; Simon Goldschmidt=0A=
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong=0A=
> <tien.fong.chee@altera.com>; Tingting Meng <tingting.meng@altera.com>; To=
m=0A=
> Rini <trini@konsulko.com>; MANIYAM, DINESH <dinesh.maniyam@altera.com>; L=
OK,=0A=
> CHEN HUEI <chen.huei.lok@altera.com>; Hea, Kok Kiang=0A=
> <kok.kiang.hea@altera.com>=0A=
> Subject:=A0[PATCH v1] arm: socfpga: Gen5/A10: Enable Designware watchdog=
=0A=
> From: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
> Some bootROMs enable the watchdog before jumping to SPL, so calling=0A=
> WATCHDOG_RESET() is required to reset watchdog timely especially=0A=
> in long looping. Enable Designware watchdog driver is required to=0A=
> support WATCHDOG_RESET().=0A=
> Gen5 uses non device model watchdog HW_WATCHDOG due to OCRAM size=0A=
> limitation.=0A=
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>=0A=
> ---=0A=
> =A0arch/arm/mach-socfpga/Kconfig | 4 ++++=0A=
> =A01 file changed, 4 insertions(+)=0A=
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfi=
g=0A=
> index aec0fb7b1c8..49920a8a4d5 100644=0A=
> --- a/arch/arm/mach-socfpga/Kconfig=0A=
> +++ b/arch/arm/mach-socfpga/Kconfig=0A=
> @@ -90,8 +90,10 @@ config ARCH_SOCFPGA_ARRIA10=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_ALTERA_SDRAM=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_BOARD_INIT if SPL=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_CACHE if SPL=0A=
> +=A0=A0=A0=A0=A0=A0 select SPL_WDT if SPL=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select CLK=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_CLK if SPL=0A=
> +=A0=A0=A0=A0=A0=A0 select DESIGNWARE_WATCHDOG=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select DM_I2C=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select DM_RESET=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_DM_RESET if SPL=0A=
> @@ -100,6 +102,7 @@ config ARCH_SOCFPGA_ARRIA10=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SYSCON=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_SYSCON if SPL=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select ETH_DESIGNWARE_SOCFPGA=0A=
> +=A0=A0=A0=A0=A0=A0 select WDT=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 imply FPGA_SOCFPGA=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 imply SPL_USE_TINY_PRINTF=0A=
> @@ -117,6 +120,7 @@ config ARCH_SOCFPGA_CYCLONE5=0A=
> =A0config ARCH_SOCFPGA_GEN5=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 bool=0A=
> +=A0=A0=A0=A0=A0=A0 select DESIGNWARE_WATCHDOG=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 select SPL_ALTERA_SDRAM=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 imply FPGA_SOCFPGA=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0 imply SPL_SIZE_LIMIT_SUBTRACT_GD=0A=
> --=0A=
> 2.43.7=0A=
=0A=
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>=0A=
=0A=
Best regards,=0A=
Tien Fong=
