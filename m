Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A86CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FB284A57;
	Tue, 23 Jun 2026 08:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="r1cMCGWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD67A849D1; Tue, 23 Jun 2026 03:44:13 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E48849BB
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZIUQOX1Sa/TEH7OWOtL8ts68cfMmTZSTKAdsqxh9L1H2vIEnn1XadY1zkB7us94EFDwxdSURMEe48wF5YtlKZDu4QT9dkmSZYK4ujpKUtdGfUdHXGo+EWVvULKX1K19bJppduoDsp0H6FQ0gZvlmopJtL6gPZdXeShIMFJn2pY6Iqkp616WB99WdgkApgctHcfuhbf7XwhRfjxAPK/SDyxaaDG6L0xtUH+M+PsIM8uF9btkGfL4l47B3DUePlgY0GRU8v0ElUsatNtCjTRX8q738sYV0UjDazr9ZDajxaGe5dC19drWmwaDiLtInUzWV5AmS1qo9mjNm43WqfOR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPz0x8KRFiN2Wi3Qx30bjfK8Gl4H0be8UbrQW3ZHPX4=;
 b=Ypv40j3efaG43yfjY/ByZovU6aFejls/lDVN5VoUJwLc7GtLWKM3SQ4MDHvxxw5Kf9WkJn5OcM0dEJLPa070BQjiu7VwQgBC8b/RYTHApMo8v0gpoJGxlbVL6ApRV+9O6JFT0oMa/sKov0+NEAb7Eq+M4ENEFT0jtl2J3vAdDg25rxrwmziVdfE3asz+aAKWgRfmFdYeeTsM4xYERNXP6EZF92HHZHDzKk0n73Bhb4JLogp8Yx7o81FUB1t2ZPUiwEadBvPe9Ju+b/RHbEzKIXYvHBX4sm1KfMQU/5c3M/0G4kc6rl2IOdtRMMGgl7AYZnNOQnURMQVzbMrOrzcfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPz0x8KRFiN2Wi3Qx30bjfK8Gl4H0be8UbrQW3ZHPX4=;
 b=r1cMCGWYMXFNfCpQUr+Y+kBWR/Mw5EpIkqWTwUX0elMIKYGh84FXQ0kTNftXXQxbwNKLjXWN/Fajb+Em57kennnT8Z9sU+3zaoqgBQ7BYL/CYp3cZmZAxJtgsBoVQfUaAPDfgwk2HPre+CveNghCTcmYgQDA9IHUgM6BzAl2xX51X9i5Lw8SZ7/GnGhE+LxDE5iTvdzMpbxXdSJ5ZinSPJnBxHqADWTULYKVhPib3ZcuAPHF1i52M53SxLBq0A14LeRBCVwvLupQTpK6TPSUhL2tlwe4+j0Z5u6wxJi9X3v1BbrUdwmgLpP8psEK/AVWS/0FeGjzwhJdMDlyXGj7iQ==
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by PH7PR03MB6970.namprd03.prod.outlook.com (2603:10b6:510:12d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:44:06 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 01:44:06 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "YUSLAIMI, 
 ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>
Subject: Re: [PATCH] drivers: clk: n5x: Fix incorrect EMAC clock source
 selection
Thread-Topic: [PATCH] drivers: clk: n5x: Fix incorrect EMAC clock source
 selection
Thread-Index: AQHc3gA6cAFZ+Tu7E0eKfl8deoQ2g7ZKsw8AgADyulU=
Date: Tue, 23 Jun 2026 01:44:06 +0000
Message-ID: <IA3PR03MB8021DC13E982C1A379FD09F4C3EE2@IA3PR03MB8021.namprd03.prod.outlook.com>
References: <20260507090215.18074-1-chen.huei.lok@altera.com>
 <7e026192-7939-4a89-9268-8d9bc7c1b7f8@altera.com>
In-Reply-To: <7e026192-7939-4a89-9268-8d9bc7c1b7f8@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-06-23T01:44:05.839Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=1;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8021:EE_|PH7PR03MB6970:EE_
x-ms-office365-filtering-correlation-id: 31d1e362-9acb-45d5-5690-08ded0c8e98c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|22082099003|18002099003|4143699003|55112099003|56012099006|11063799006;
x-microsoft-antispam-message-info: 4JsFByv0CGQQ6DnF+isgOMCF+uo2dH3YtfKJqisM+6n2LFYzCaJjcf08RShbK1qjA3eD67LCc2XB79TurjN/xZYnCvMVraI8kLCgbhPf2XpS8rbSdxQ6t6857WNgoKyO8YUJ0REuhzguzG74TgTTc+cwb5d/ggiBlxBLMu5IP/ZD/zzCAvLCmPhc0yzoKBb3sK66imYYr4ofvAKqDX/uYkoNkv5smoiiYTD4KI4Mf/Br/hTLzbCWIWcpIp+9iAOVcyMN7MgKqK7OEnyHNKy1sHgl8jwDkF7pkKUAq9+7lctmXo2q8Jc5bHLJx52m8xWpVX19LxaZ2TTjc3v4OgoFfNho/1BvEUMxOVm6fbtoO8x2cqcqB5MolvS8N5YIjNt0gtqDz/ABzm3I6YxlRItDkP9M5aBEDhwYoc2jmmgQt3LrlpCUKSAKcbn10oaiJYSkFxcE7vGch8Z50Ke+6VXAcvSBMxTb07DNVExVnJMZTYmyjLiaSuMHvZuYgYyDYxHJuQIF8RI8IGtwl1nLDKQeY1q1Sw/ljh7W653DyS+prGlpgLyqs61BearPPj4XnkVwuGgEoi5Pf25QrN+4Ck3mH7XE7F2LwaifOFohrSsfTLbGNQnyXWvlhLeEoHytIdodYlVYzkBDjyrOhNegbqPiG2MCoMX1M4xg+vyBeQmn6Zd3QRYxBM/l+HBsQn5h0xeb5+IK0GJ+mbhQzgRRfsaHPyJJuZ4hLScqVdltLpMlrNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(22082099003)(18002099003)(4143699003)(55112099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cq/Urjt55k3J+wddPT4UGTB5OuqbftpPTbkWJ2t5Z4tfqv+66olM1r8lI/?=
 =?iso-8859-1?Q?c5CwhUXr50+V9Dw5CImFN5lx0f0FH0p6UJlrG1bWtLZRWJLfBMmRCchlaf?=
 =?iso-8859-1?Q?Z9g9EX9MaIHCfG5Z3civEdrJBp9yG0+bYKAkXDgxKDb2OJvV0TTIJVT9HC?=
 =?iso-8859-1?Q?go59a2C4DBfNNwY1/79GuWfAVBM3Ia72cZX4+xYQsFJENWW1lGfJXa07oc?=
 =?iso-8859-1?Q?tIoTK7cEffXUOAlqn9sUXZTLcxQQsw0oy6h1E1jFpe7OAcKJ4HDTaTDweU?=
 =?iso-8859-1?Q?+o9Z26iuLhU7G0A0ipFADvYIb0fXW0rZnClJgj20inIuK9JChIZKrBDIyC?=
 =?iso-8859-1?Q?oDAVrbhLwycJ4vpCQR27+/uPBClKZzwZliC9hmHddIUFo/gEkLJEcVbE4I?=
 =?iso-8859-1?Q?mviRC5t6siDeXRmJTuGFus3rUiqGZmmRHiJZkzWPXTmwh6Bx31JmLIrY92?=
 =?iso-8859-1?Q?qVCWxFnmMBc3lYM9lackd+rD3IWVaSvzqQyyNiXipJ0tuDAWS7XF5h00QJ?=
 =?iso-8859-1?Q?lODYBgRrCi47CuGSHMW+oAB33ohCqMIcR9/qvEaHT6SUAVuGkfajkKCWIs?=
 =?iso-8859-1?Q?FzbJIofxwDUG+y2/WzZHMJ3uDjlW1lzlbhrxmruoZhGYQ6kL9VWb2dNiOw?=
 =?iso-8859-1?Q?lA8L1NknZwZIA39mWk3hgZyjFvi/JAQXyXYabZVcSmRmHLB1Hytaq04GCx?=
 =?iso-8859-1?Q?6RT9LkGPMIf269Frc44SgHaUckXxNZZiAu2d5xigMC3G7Vn4saCQ1s1GzI?=
 =?iso-8859-1?Q?yHW21VRt1FiMOg2qDn3j47sg0L6oOCRl6aII6ngB+u4hH1GGKus55wlxuo?=
 =?iso-8859-1?Q?219xWsEsVIR4taJsnSDA/Q45P/gMNotiTBHDKOof4b7QriQRPIJaFd1nUx?=
 =?iso-8859-1?Q?dHJPTLYTl+W6Phfcaw/S75JmmGrfYl3vbu1i2eM/EBbZn1xORqwqCU0oH4?=
 =?iso-8859-1?Q?efScjDWJWbRfr9OggHyCDJKL4AGPqlxqSFP7WJsHqgHBPsndMuuR4gX9xh?=
 =?iso-8859-1?Q?s0nwaWoEGOUG2cXkFgyACToNtATcFnnQPHXnl39EI2fXu2H1wR9xRsXMgy?=
 =?iso-8859-1?Q?qvBUQXOevC8TbJKh9+qJL+cVG4tHssguMzEL7Sh+g+uZrzQZmYOs3FR9FS?=
 =?iso-8859-1?Q?wT0XpIuJNNMhoj6RepFNBbM6eYtXWh4wn7/0gdgg0eR18qYb8kT0+BI7cA?=
 =?iso-8859-1?Q?bivKL8h05TdAO6CaTx+TZzSkRsOhcW1b9FiNA0iAtOool46PJjHWU2/WFu?=
 =?iso-8859-1?Q?Av3128MDJMCWlIfRRHxZ2E/mX9axgm2HZVVoBYSF48kbsuoEcW27mDWkvF?=
 =?iso-8859-1?Q?4vdvDpRZHznnGT3O2LxvQMdfh8aeuDHjqxp6b+X91ySG2aBCF5S1TqfHbZ?=
 =?iso-8859-1?Q?XahxUYHNl2lac6wTe2G99OAQzHBTdZUogKw8lS8hqaf+493AjrUvlpu24z?=
 =?iso-8859-1?Q?Q9wEK3scJnZ7qA60JshN4i4XltnMR9+POrAv4BrNumydG/VUOAhDJtxSYT?=
 =?iso-8859-1?Q?ylvhOJcoH/kADcr3YsYPZNIg/pQpCpS6t8a8FpFWN/hs8yg3d48XQHTqFn?=
 =?iso-8859-1?Q?LFe6MVieXXuVe4ghJgeBJ5+NRYYxWOpUb1c3CgUkdVEbmbcsz0CEg+pQQt?=
 =?iso-8859-1?Q?NkN/51nyTlwVWeNPnLl/VEyWqijIOcA8MZXYqRL3hxBhB6HsrTsGrTNjbh?=
 =?iso-8859-1?Q?ANH22VWOpDRPXFvDovUpOFpRVWC4lWrcsWu7LNLPHXDs0NIUjLU6CzQ/EA?=
 =?iso-8859-1?Q?oy5XzO/BLkODK23wViYOkjWmkzCcCp81i5+tmWjFYTvVlalknTFhfgrRdb?=
 =?iso-8859-1?Q?z5+JAJJgwQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d1e362-9acb-45d5-5690-08ded0c8e98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 01:44:06.3491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cJJJRjMNFAIsIf4ErJlHyHPUXUnC06qQAEI0NncCXfOYLhW5zA+18xAfOdZJZWK/Yn7lhISg9Zx/0M+QLv43PHRrhQ4QulC2y7yzQ/8r+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6970
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Hi Tien Fong,=0A=
=0A=
On 22/6/2026 7:09 pm, Tien Fong Chee wrote:=0A=
> The fix is correct either way. Agilex uses FIELD_GET(); Agilex5 uses the=
=0A=
> same mask-then-shift this patch applies. FIELD_GET would be a minor=0A=
> consistency nit only.=0A=
>=0A=
> ctl =3D FIELD_GET(CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK, ctl);=0A=
>=0A=
> Add FIELD_GET in second commit and keep the current as first commit.=0A=
=0A=
Sounds good. I'll keep this mask-then-shift fix as patch 1/2 (unchanged,=0A=
the functional fix) and add a second patch 2/2 that converts the field=0A=
extraction to FIELD_GET() (plus #include <linux/bitfield.h>), matching=0A=
the Agilex clock driver.=0A=
=0A=
I'll send it as a v2 series. Tested on N5X SoCDK hardware.=0A=
=0A=
Best regards,=0A=
Lok=0A=
