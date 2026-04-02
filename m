Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337E6CC6B00
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 07:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDDA8408D;
	Thu,  2 Apr 2026 09:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF352840B5; Thu,  2 Apr 2026 09:10:21 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20731.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 076D584011
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 09:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFE8WOHmKCp5H8bPAd4NFj5OoIqDZGDZGsEhcvbuTUaO2htzeuL1zsa1StJEPy1vJgyi8SRTqGffsydSkH3KB9WTZOyTQNDDVlbA0bHusOZC/spSOmXNc3hFv+SVaKJkBTMurAsp/wZMOuD8B94i36BVPeY/J2k/YlhhdvOMMmZ5tA53Qlq1sU3Dmpmx7jyo362KqnABP2LFVNy12AYo7zY9oIvSzK0JjEC4WVy8Wa/bI+/WnEAO0c4x5O6YnYkqD0MDbmj9Hh7kIANc7I7pw2eE+sJiBkwa9SO8gJ4i/Y8pcSnlAxKfR9t1Kn2+VaAJWRr0W2K7WmndT66zvao5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrL9xXHtkp1VZOLRugYOrSvOVXZ1PsjVqWrpdSFCr18=;
 b=cFFnZBZfN9dkuBy3U99qVU7Ww5H6lkdVNA8jlosbruFjI6Aj0NE0vkHTMGwGR3dII74m/JHYirzsZRxuRR0zF+qm9tQLVZtUXaa5fZNz+7qoxEVkKb0rU/lOsFVBGC7ld+J81i1dCy9B6sbAwjuh30WO2xP5NxNTIKwdUPgcjBcw7ew/pmynX/w498Ko03AmXzrvcGc7m97NnJjXIf4f3xyelYy3ba5R/WNeUnQL+v1ARiIGaTFPQJRjOIC4iqBIDeEkUa882DXYJAMqZvskV7Z0EHZNgazaunvklfesU9EesrZUuLtwxRB8XlMtPjdWaLeMSJD8N8do7E1NWAjT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1180.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.36; Thu, 2 Apr
 2026 07:10:15 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9769.018; Thu, 2 Apr 2026 07:10:15 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 0/2] Add support for StarFive VisionFive 2 Lite eMMC
 board
Thread-Topic: [PATCH v1 0/2] Add support for StarFive VisionFive 2 Lite eMMC
 board
Thread-Index: AQHcwm5vVEdyX+q980uBpuA0L5E0RbXLWqQw
Date: Thu, 2 Apr 2026 07:10:15 +0000
Message-ID: <ZQ2PR01MB1307E44699D8568B4E40C48CE6512@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260402070041.2418-1-hal.feng@starfivetech.com>
In-Reply-To: <20260402070041.2418-1-hal.feng@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1180:EE_
x-ms-office365-filtering-correlation-id: c86b83c3-596c-454e-df85-08de9086e3eb
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: OsvwfCM0QYj0Xwc7G2mwDISmI8mkFjBt5v41BgT811xDZKPOnlpEGk9S2JffilhCfrkC3galLTwaka2AMuts/S6lKcS6uET8QM79A+Ng3Z8meF91XtjgpsbZAwvhihSE5aIIHY1dBTgHKVaVWlNAWjvvbsAelzdhe2Ods60bTRPLh29yolwXD4uAo1X4pnaFpD6yVl67gB5WiiqfUNAxU6g+ybuzUbhhAuJOy6cLeWnUpzq1Yn4ooMvnn1vQsrYG5R9N6gAl6LmU7US2p7FyXmBcRuDsHwJcTd0hx8BBM9bJnsWGcLtrR9wKWEuM9hh2rqHO1NJpt0mlWcv0kWDbtfU+SbSPfuv+DP6twUkwz8emZI+IQdt9QzUtzdkVgU1iJ1yaYyeGqEIuTLjaehGJmFCK/alIwjiWHkrfZbfTPVxbshUIAbYT/Ta/Qws0kJ79AIhmOi7WU6fT9MEYe3RLHwxqrCl9ZN9juuiojMQyZTiadUmGWFpu9YZ0ptBqziFz2QpFyql/f2HMnDBKo82KET7Grj+/9pX6bEAI5ZsCehVzYPwYtFG/hBpmEuQbF4xmT+bBas1oHx55q9o9ER3kLvIQkOyf/0ZZKmjYM55mPMA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D585ahPj8KfSSKgWmv574buPC5reL5oJgkbZhAcT5tJK3scs2uDRSSUHgfW7?=
 =?us-ascii?Q?p6P1OtVXKoCQtlsoSeaGHdr3N+1NkE4AkknwvVl9FI6lA14hWUdzQ1YmPYP6?=
 =?us-ascii?Q?rYP6fTwP96x+FRah6MrQIZulUJDcTAmDyS2vGeAqXIR1l6C3cKxA9UhbDQ3K?=
 =?us-ascii?Q?u8NXfnRTDWX6AvEud62o04iti6Lk4eqADaUKZtWZCll3B45ohLR1IeKE9twa?=
 =?us-ascii?Q?iquQrQ+dd/87mz5qcLkPVItrXzF/oDn/Q+eT/gRqoGcYlWBrU9JS7GKaY7Y8?=
 =?us-ascii?Q?KRGaXspHRmNJXLyu3Hz5qC1LSayOBUH6RGPnifu9owy1KdvasuZbwE8dvvZC?=
 =?us-ascii?Q?rb6It22LkNM0NBAtMf/KFtcn0PViju4+sqtCTvZlKgxA0GebmN2R3Kkek9mk?=
 =?us-ascii?Q?Q2Ot9V/7Gx9E2UTzK/gp5tQ1OINsjhRdhxkYsn99F398E9AOx/qZgt5LcuRI?=
 =?us-ascii?Q?DhfLsKuZZLWp/kYUpjI/tGwnIeF6MVFMPXK42PR/59qs6N1YmMPpna8WSbsx?=
 =?us-ascii?Q?6Y8kAfqXw9X0o37aG0CGI8i2GhTJF9ZRv54ehIxv6TAfsu9txSmNerWExNNg?=
 =?us-ascii?Q?cWfHGiqNVPEG5CEAsQALa5FOCie0ex9ID+OMNxmvwAVVkVtkSZyPlrfh/eLL?=
 =?us-ascii?Q?SJczBabaMO0yTDdmSxw1rTDkNNhlUB/H97p1RMX36O9aRkZvUI+HKMnqO1mu?=
 =?us-ascii?Q?FyMYKw6jL5FSJkrUR05aiKmNWKZz3i8of3SpJYu3nZV5Nt2jaMaDntnemEO0?=
 =?us-ascii?Q?bc5dyQu7BccDy+Ys8s0k9A2UGh4+wXVljWGA1OKQ6CZmMgJIKEoq8z9LY+15?=
 =?us-ascii?Q?YVz7fVM9Y2CxCz12jKnfIL2BroCc0I9wyDBS1JIBDIJCex3CzLgwm9omhOI2?=
 =?us-ascii?Q?9NZYuWNF/3yj1KxE2rQkPiAsvDDhQgd9/Sh6Tq0hf5gs+a13UXwDJkm5I3qW?=
 =?us-ascii?Q?ErzbLttLJ+ZU+YSAlDHG1O9Bhd7q5H1vKokmiMKF/E58RQJI98R7si5AdQN1?=
 =?us-ascii?Q?rq5aTaSpzfWJk+C4U1le4ZxvRINipEWsEL68e6f4fYYO05D72wyc8V37OUb2?=
 =?us-ascii?Q?jw+lm1dDcUc8LX5Bor5GmAOUkcpszMXpkw3Y4WnxvI3WdqqWg6OK1NFYInfz?=
 =?us-ascii?Q?Sf1l14vGMoyM4T8U0/5x5b/1AK8oXRccAtVMafo8IdrxCMcvcHtxhX8mYHiO?=
 =?us-ascii?Q?f5BT9pD2Bb2kMM6aZZjjEVOq1gqXca0C+CKpiuAlODIF1CkuPUncQnoKV06T?=
 =?us-ascii?Q?daCc0CrL1PuvZwLiVnSo0tYpN2+FDNxVE8qqs9d8oXrYcxJfTK3GMD9437DA?=
 =?us-ascii?Q?bfkrc0KzdiSYXNkrudc5hmC25TVg4M+zCCehkoNPVfpqt+6Y4S3sve7Fpjux?=
 =?us-ascii?Q?eJaavs6L/omDeGlKg3lnwmTkVj+6KBq3pbghdYOa7/sDnus11tUfsvGg0T0W?=
 =?us-ascii?Q?AkJK1fuviMofXxzMn2uUmYWcjOnJX8zKOI454YgnMFW1oX+Oit6k5Yz0oCSN?=
 =?us-ascii?Q?0he39o7x4sY9hMrygyueNl2on72EvcEjsewCIj2qQjWr4VhnqsWYXt/TFLXr?=
 =?us-ascii?Q?8qqL6t6UmXlTg/9P6QY3+UwMrgaKvF/w67mn3NjQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c86b83c3-596c-454e-df85-08de9086e3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 07:10:15.6432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEQOzvL3W0y/O94Sz49afCi3zjmCFSiL6FUq3zfXcGp6jy1fdPYyVgsGlE1y7ZYTI0YEtcFCEW5hhk9A+HfOlJNkQ6M/mkw9dozlE9Sqh44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1180
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

> On 02.04.26 15:01, Hal Feng wrote:
> VisionFive 2 Lite eMMC board uses the eMMC as storage component instead o=
f
> the MicroSD card in VisionFive 2 Lite board. The device tree of VisionFiv=
e 2 Lite
> eMMC board is already upstream in Linux, so add support in u-boot also.
>=20
> Hal Feng (2):
>   configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
>   board: starfive: visionfive2: Support VisionFive 2 Lite eMMC
>=20
>  board/starfive/visionfive2/spl.c                  | 7 ++++++-
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  configs/starfive_visionfive2_defconfig            | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
>=20
>=20
> base-commit: 98cf83d81617f489d7ff7bf78d33e693e2799254

The patches are based on the latest next branch.

Best regards,
Hal
