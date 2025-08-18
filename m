Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3E4CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 02:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E7583164;
	Mon, 18 Aug 2025 04:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ep30EjMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DFE8338C; Mon, 18 Aug 2025 04:28:42 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05E08311B
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 04:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zla8lJfV+mVZThuR+8S24RbYkyw4Wqa3zdIyE7Q4erYWplmi04qfAgXPofjtxXX79bInwsv/di9sT57dwAZgQZiDM8AZU/CK2/DNMFFm0Fbve0wtfUhfAtfoIbcl/FtDk0ivWsPCrfYJP3PoP7hmFmg3yBBV5SX2gwiIril0oGdpnXMSEnCcsUiFhA5W7mIIalTdYbPcVMuPBurbmRObMDuY8v3wU2l+cP3m/1s+nv7jvxUXQQ6VAcRaUknwsJenZrz3d5PtSCF1MOxZqDHPIEFUdTc3IygLORoYVCCJEH/h6En56KG4X2OZko0S2r89lBW8PCEcjBVd7MXt788m7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL/B0qC2lG/Q2wmj7wR8c9M04c6yHq0KBa7zZ1ChZ9U=;
 b=i2/VKXxEs9Sg4GEjPZNovoM7/ZaYkvl5NqC3YViC7mBp+MtVVYCOS+xyuo62PA0mYl1XKvL2P3opkOxQaUgGRxvSddu5Ba8CgwmBwWnshjKHCVCrq2PwrrqgxNJfnDlsBb+eq9PNE8qTdh6WmHBaMByNhZ4QYJ6l9h52bVI+HnwDZyvqMMoBIiCU7woy5IjGpNDkvjr1nVJ7Hh9ysVG88TqNTdbr+bhMpUNhB8KO1MHOYTWjh7lMLhaAyuPJZHAHwVnjl4ro8vohli4mqOJfIGWW1YitqVOMG9AhtqVPJ7liYkcjDWOsvpV5ewR51Bi7M3gvgcpb1vAmICfg+ZUAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eL/B0qC2lG/Q2wmj7wR8c9M04c6yHq0KBa7zZ1ChZ9U=;
 b=Ep30EjMGQKEw+HbRDpHZO1NY2Osoqh2tjM2B1HKvkQ8upAYXec9lwL+4dp9FSc0Ycb734gwMLJ1E2Ubtb6YhAVdQTFNrpkCOITcRsTX6Feovifc4blzLCAnNsV0fgup4HbjKcCjQJwhO+I4j/Ga23lGPk55101W6MH94ohLBnceCHih1k/0PwyDawW9Un1PHs36nH3Zwgx5KnQV6Q4sAndy2CpUkd46Hj1LEpeIJmF+qR67XpwzWquSATSvJQGKTjFvLToKFv638PhfH24fYz2DFD8rscVif6dWV0Ptn9pjMOuXVvtTPP1D/hPsN1xwKQLAt/jCQLrapkUlitfwvwg==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM4PR03MB6127.namprd03.prod.outlook.com (2603:10b6:5:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Mon, 18 Aug
 2025 02:28:36 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%5]) with mapi id 15.20.9052.009; Mon, 18 Aug 2025
 02:28:36 +0000
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v1] misc: fs_loader: Initialize actread variable
Thread-Topic: [PATCH v1] misc: fs_loader: Initialize actread variable
Thread-Index: AQHcBbMtgwdEyMQ3PkGWjrSbdKjPurRkIbkAgAACgoCAAAEHgIADnu5g
Date: Mon, 18 Aug 2025 02:28:36 +0000
Message-ID: <PH7PR03MB7063D87090F15F03A7E22E3DAD31A@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20250805024630.24558-1-alif.zakuan.yuslaimi@altera.com>
 <20250815185818.GA55961@bill-the-cat>
 <b4df190a-84b7-4c4f-aecf-116b9a1f4899@mailbox.org>
 <20250815191057.GU124814@bill-the-cat>
In-Reply-To: <20250815191057.GU124814@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|DM4PR03MB6127:EE_
x-ms-office365-filtering-correlation-id: d744c8d9-2c90-4f02-3520-08ddddfeef65
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mYaqwnW30biIafjdhITl6m8AV2Vk0otU997Hevt7jJB2mYDd66NRyM7nZuma?=
 =?us-ascii?Q?jHTMOeLQ/3YnyOvZz2/hSQ9aAAmU0GGNO+Qj+fhxlS93ITZBHTuoXGq847xB?=
 =?us-ascii?Q?tro4XZZ8GFhlFg8F7jDMxtkw++1yvr6nBAj/e2KXlpPb7u01bwRc8Mte/tbp?=
 =?us-ascii?Q?I7rjtTtsrB5dE2cof9SGsvVrSektxyQrDqku7/L/zOXRu3cKjzF9tCf7/azD?=
 =?us-ascii?Q?4Ca5/TuW+PPFTksLIAV6LWSx6564HxqLm3o01oFzu6VCQtwIiW6XnJerywsn?=
 =?us-ascii?Q?02/SDHdUfOcLmoxDDWI9EB3gYuEKraptGZZ2xT6Arx61d7v03433PLmrxNNG?=
 =?us-ascii?Q?8VLz6CEUVG0GOtAXxwo3O/wA+g+XqJko3KAgnsa9fwf+CBzkqeLcv6IJ80NY?=
 =?us-ascii?Q?FsPr0QzCEO1wEg5mPvbj3YbD+V5PbPFLUlaRzcftbBsgyuGPLqVRqHs0ZrLJ?=
 =?us-ascii?Q?zo+8VkhOIXwlhVietwT4pg81kXEAPf5mPQ8DyJ9+hSeNCYzBEChYWq+l+q8X?=
 =?us-ascii?Q?Rj0ifDYBNUyuIrJoqJsS+M0p1CPOfS89OAPW3Hi4M9Y4ztU55m67j2bxdD6c?=
 =?us-ascii?Q?47gOf5SOg/y1gQC3rP4mag+ALa5ljH5HvEzFZEp9vTJ7ldV3nkveMgZLGXxc?=
 =?us-ascii?Q?usXHYoUoxPNw5ZTbqwxxpHTMUr+B+AyrtjCUVBLnlUueZwCQ/QQhxJBIMxxv?=
 =?us-ascii?Q?JNdENpX1ndujbNi7QXqwiKGYc4xkOgyTV0IKPVpJkFhTnYsqtbvasUZxw4RQ?=
 =?us-ascii?Q?wXGJ4CW2GomMACRwHRN5f9d4q6sqR7nnnaKCSb7+Pe7ipUwpgGdVHDHr/0MF?=
 =?us-ascii?Q?I8khXBdzhgJLWWtcSOQ2hnQqi0KDH/Ri4Rz86rjIBaZhimd+vusNaW4mj5uK?=
 =?us-ascii?Q?fKjoFuM7m5kW2nAQxNJtKLdlnGhgzErsc9vZMd2B4sMX2AEyDjzXiB6il7Pj?=
 =?us-ascii?Q?OODwrIjoyk/cvqpfIDR5MQowpF2BsRSSW8irAB6yum3UGiMFevX/uALrgF6e?=
 =?us-ascii?Q?25limXXIl3Pw55n8tOJCEbgCmR+sq0ASAwXdwrF09O7II+EhTyqwzIkjAhlS?=
 =?us-ascii?Q?sVlsfpxDXhLwiVmvLTUtH33Ck0Bte8vt+CfxqCB9STAyTkSPxa+iWo18vEgx?=
 =?us-ascii?Q?uCYGc6u+cEOloXCKGFYCLwUKl2jT1so6EzgoW8ks4ONx+EKXQ0FdH49h1xeR?=
 =?us-ascii?Q?KAOgz7mT9ukACzmJZ5/zdi7NpSD38ADh8jSGqzvIvMrqSe0V3F7IfbyIl3AN?=
 =?us-ascii?Q?OpMqvfIv1GnbsYEknTh2eLC/vLdUXIpVZ9HZuskJqljhdxt2LLXRCs9JOU2g?=
 =?us-ascii?Q?9iRgRiMc96m7mQtJyRrhng51R4c5cdERapqO49taHkrMlOGGnnx/26vVRoKG?=
 =?us-ascii?Q?7s6sv9aP5gelAH4/Ud7r4U57MCzj9ji4QY514AdfGZkxvd44afLdHjkz5rR+?=
 =?us-ascii?Q?p5Gqv6bJtr6JbEzMjhLoHaGTUWIc1rmlsWk0v2GZJpAGdszjxF9C8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xWLlbKTyi9ooBQ8HiV2R7YjdkehUbpKO/dHhcJgWDvpR8rGuwbL/Tyn8DSzo?=
 =?us-ascii?Q?n7O8jg7KSCYUJxxoALve0gxA/wkyAo+fP2Bx8kFFS84CY02xTSlfhaz4y67V?=
 =?us-ascii?Q?wQu2JXQvI+opVcyx+DVr/7551rexFP7hANA6hUx7e1Ba+DgvRKpOlQNTp3lP?=
 =?us-ascii?Q?oiASYSEd1JVJgs+oANb6YvFlmoYfThkJmBz+jCG1HHW3UuuIQwVhgCeAvpgR?=
 =?us-ascii?Q?KpkOIa0nG5Ct7i5bKhQj7U6wIUQ5vu75tg8bVOmC8bT5mWTpuQunDZPvpFCm?=
 =?us-ascii?Q?I7JV8fLQJNiG5rvn3eRw4c2YLGfCEE/zjnvqoqJZDddPgrYminWe63UgG6tA?=
 =?us-ascii?Q?WUV0bmHeElOxS/DBN76bQP7xfNsLKLLj7HISYpXdAu3D4MZKLSfD00jEyUma?=
 =?us-ascii?Q?+RpxaISc/NDvue/3b18GuTL7hori/w9sVKWTm2O0/4sKG0f7eezjFJf8KRPA?=
 =?us-ascii?Q?JbRTG+3nPEJuk6wb2YwC44I0YZe6jiVX00uq0xF68fFQgkPDOYIGdMZQnl7H?=
 =?us-ascii?Q?DRlsah1C9f46UfZ7Z0pB/viLxbehgmDlwRxK1mNfb3V7qVWM6HBFSDEDcaix?=
 =?us-ascii?Q?3TveNBdC5/lLgg3oYHTXV+dihRmNF4GcavXm3yimm4wT2wcVTk0o/AZAT6q9?=
 =?us-ascii?Q?1KO4EqTePYljotsxb50FbBVQlvyVSNbY6CwMUDNlmaSoPIlemCZ5kPe5eT7M?=
 =?us-ascii?Q?E4aXa54e4myDLWeYhpZD4igAgzQOL+VpehZtXzoqB+yId4jR2tiZJ9gebccv?=
 =?us-ascii?Q?u3x/A/uCiq4SoMCrZOLHwiWMj1vrfWS8SG2/5G7K6dN/WzjrTpwT3TjeL2yn?=
 =?us-ascii?Q?7QaRbme/UDhAmimGiaA62cmSCZtjpadqbKTl0wn0ijnruyMiuhdommlT5aOE?=
 =?us-ascii?Q?zA9VyZaUNEXFTfyrBnqdae9uTKiWCCEAClZUi4pm9guMcPXWUde14pj43DFk?=
 =?us-ascii?Q?4XrZOrG3sMjyWXjIJZ4OachtnVGc3c5IL8ym59iA6qdtBz1QTdC0hDsh+sFJ?=
 =?us-ascii?Q?ROyHLUlHlt2B3PWrXyZjiDzXXOQ4FSEAsAW31SFsRLVs8C4e7CIUONkHDzFH?=
 =?us-ascii?Q?GDRYJQlKxl98j4UPjd/2be1TbW1Kc/wV3GIGevPkyij5bcyr6lLgKWXc1P+I?=
 =?us-ascii?Q?5bxkM0Yn4Ul8Tyl0GbjJ1DHXw43ATrV9OzDBw7QHRNH4YSp/hyThMNnbAOcQ?=
 =?us-ascii?Q?mmQum6Y5XBSTpLqcEr5SI0ZTwzXhpG96AmaoiWZ/0UJWvqX9q8KxJ89oohuF?=
 =?us-ascii?Q?8U/4VrL1BH7Udz3a4NxRBqhHrLYhrGKTUMJJhctNWMgpP++WDeQAQfswV2lc?=
 =?us-ascii?Q?mKujivOGTCi6gzYvIY1j5TrLNSU1uqH3E0Bp+knDw63WSlZLRlkET1983Qdv?=
 =?us-ascii?Q?iiwI6kFkVecnEB6iR5hjVaY3eP8ZG62+8y+dgY2q8Pf1VWZdvPz1IGs4xR/K?=
 =?us-ascii?Q?IQUjyBvIDbrTsNcTfta1PHp2KswZobQ7Ol3I5KSm4Oy4+Mayjktppc6ZPYm1?=
 =?us-ascii?Q?umQ+OJVMsY1tt65BjyzRvtT0GSwCZl3uXCx/Djy8IWSod10mO9jPa8GgMnq2?=
 =?us-ascii?Q?i2a1T28fvn3w5hF5/LEMydJ9Asc4XYIVNAUY9sHe2lFZV6M4N7F2QivKzliK?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d744c8d9-2c90-4f02-3520-08ddddfeef65
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 02:28:36.4058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMEx6MH3hgGzAEHyfYVmYq4F4HyUiDAK6GaGo8RAMOiiBwWUYQAZ7oBQ4H6cG9urG1ExAqQIJBaq/eSTtdvm2lQnhLvz4XKMJ7lC4oicUBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6127
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


Hi,

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Saturday, August 16, 2025 3:11 AM
> To: Marek Vasut <marek.vasut@mailbox.org>
> Cc: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; u-
> boot@lists.denx.de; Chee, Tien Fong <tien.fong.chee@altera.com>; Marek
> Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>
> Subject: Re: [PATCH v1] misc: fs_loader: Initialize actread variable
>=20
> On Fri, Aug 15, 2025 at 09:07:17PM +0200, Marek Vasut wrote:
> > On 8/15/25 8:58 PM, Tom Rini wrote:
> > > On Mon, Aug 04, 2025 at 07:46:30PM -0700,
> alif.zakuan.yuslaimi@altera.com wrote:
> > >
> > > > From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> > > >
> > > > Initialize the actread variable to prevent undefined behavior that
> > > > can occur if the variable is used before being assigned a value.
> > > >
> > > > This will help to prevent potential issues, especially if actread
> > > > is used (e.g., read, incremented, or returned) before being
> > > > explicitly set elsewhere in the code.
> > > >
> > > > Signed-off-by: Alif Zakuan Yuslaimi
> > > > <alif.zakuan.yuslaimi@altera.com>
> > > > ---
> > > >   drivers/misc/fs_loader.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > > > index 66803f4b997..cc07bfa7f14 100644
> > > > --- a/drivers/misc/fs_loader.c
> > > > +++ b/drivers/misc/fs_loader.c
> > > > @@ -1,6 +1,7 @@
> > > >   // SPDX-License-Identifier: GPL-2.0
> > > >    /*
> > > >    * Copyright (C) 2018-2019 Intel Corporation <www.intel.com>
> > > > + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> > > >    *
> > > >    */
> > > > @@ -148,7 +149,7 @@ static int _request_firmware_prepare(struct
> udevice *dev,
> > > >    */
> > > >   static int fw_get_filesystem_firmware(struct udevice *dev)
> > > >   {
> > > > -	loff_t actread;
> > > > +	loff_t actread =3D 0;
> > > >   	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
> > > >   	int ret;
> > >
> > > A one line "initialize a variable" is not sufficient for adding a
> > > Copyright line, please drop in v2, thanks.
> > Technically they already have a copyright line there, they only
> > updated the year. This was probably written when altera was intel PSG,
> > now altera is altera again, so there are two copyright lines, but it
> > is the same group of people.
>=20
> It's been a while since I waded in to discussion about copyright lines in=
 code,
> but I seem to recall that a one line change of this nature is also not en=
ough
> for extending a year on an existing claim. Something about substantial wo=
rk
> needing to be done.
>=20
> --
> Tom

Thanks for the comments, I will drop the copyright line in v2.
