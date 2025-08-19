Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05ABCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBED88311B;
	Tue, 19 Aug 2025 14:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="dfRtTY+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4798681FEE; Tue, 19 Aug 2025 12:33:32 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A83802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0CEDZSsYMB4IbY5Uow2oBPI3QzplwZ5DdqLz6dJV8FsFftO6tGf/otZvT3MkuXBBde7mywB38cuI2Y6L2i70RgKljnjT/Z7QgTo+0cIsbH6wM0N4dSuh31Ot8yCwtxKJJlXs9TijVd0gU1X2Amw175KBHTcHokislTUc1PKBfzSU0fmAVNp4IEpz9dFitWQJMntz8v/0e1oqYZ/SOqrYz+oXsmsH8DzOi8FCQwIcA9uRxWa4Pj08O0472ZRef0/TNG9ggcRB821Fup/lbBRAVrnEnl0v9xe8WIoOA7SDI9/cga8fywE45YrjxgABG9BdKc/L7eFfpLAb1N1EIZoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=rHWfxejfK9Ni6ryapMxsI18kPaakg2Hh42Y3AxJhYtrOErhu6NPmziX6cPTO73Ap8dEFy4cv5T8aR8HdeFH2yV5r7Wh0TOt9nn2pBqUhDml472O6iBCQi5XH6o6LVAan/4shigUu53HMm3rp6x6Yxb8PA6w50Uw2rQHdeKaUnXpRlAeFG+hdfmRQx0p7VhnV0T5SuL0uxMX59cL1jrG1f39a57cklubPHjZD3VItMBY1/neo4GxbI9wNN1aZuNUcdll9yFXM1W/MePI1zEQiA9irSe0z6vWP/vGVrSqS63NQqnd66rvZyr/c32019JL/BAStLsh8tPTiFuV4XmKa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=dfRtTY+LHnSPuRTYgr5Ca4czZa75/lPZTNnFPtzQXgY5vsOe6iF8VuR6tJKgYPntUxz49Jbt4V/s73ouJOafxdNdVM35wrY8GkETqJdgCuBW3L2qieLdMN+kfKH151Ntn/F70GOKjxMRyYSpcGp8ElGBbKegMwFWrQ9FFrg9Z/iDIuNIa98A/JTFuTA8IKloTOvYP4xt4rrZc94GJ6YjTZtQqM345KPL0bbtMCvN2NvRsKUUCvns0QfZAnJf+abeB1siiwCrTBnoXzo6FuFPrp3uRNunl1Utfop43PwcmSlP+OGqeekSUKrAiE238cdde4XWgH6GcJgDimgum7FTDA==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM0PR09MB4321.eurprd09.prod.outlook.com (2603:10a6:20b:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:33:29 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:33:29 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 07/10] libfdt: Allow non-64b aligned memreserve entries
Thread-Topic: [PATCH v4 07/10] libfdt: Allow non-64b aligned memreserve entries
Thread-Index: AQHcEPSzTq+DoLkPCU2oXFXpyOhWAg==
Date: Tue, 19 Aug 2025 10:33:29 +0000
Message-ID: <20250819103021.1518687-8-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM0PR09MB4321:EE_
x-ms-office365-filtering-correlation-id: 9651aa76-ebf3-41a1-dcde-08dddf0bd666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1ECoZDw365JwxxhXTRRFwruROa9rnieFxag+cLkDPI0wwRxi22HSShpse3?=
 =?iso-8859-1?Q?5TXWcPnn+vQyFkQWKBBVL5+25zR//LFtkZFe5/OXHjsfN88aYSXmk8r2hK?=
 =?iso-8859-1?Q?9RUSj+1lN3TU/nGLFOkHDpg9AvWxyILtBjFfnXVEZvf1K1SScM03pq98ft?=
 =?iso-8859-1?Q?r9LlSXfS02MkGatJq2udHCjU0qMIuhrA5TnldC25r2iekSQ0EpwSI33vp+?=
 =?iso-8859-1?Q?xGW4c76d/7WFmGUyN4R+qzAYC99rwb+mCnzNJmNjxxVJKNqGVAxAU0IfD3?=
 =?iso-8859-1?Q?5n5e6obfrmISIWQVvnfwxcsrPJHaOXgcIVEuquZd/2rYsXptDMCLfVlApy?=
 =?iso-8859-1?Q?ywjipXpVtr+3SWx/TNVTiW9YNSMoRLz3fRLt1FTJPWaG7xNm2LoUOmzEcv?=
 =?iso-8859-1?Q?qpwsJ80z71gM4FsY1es8/pljQ0S54Fbkezx4MOkw1d5/LiVvfM95iN0lss?=
 =?iso-8859-1?Q?AZxPfIz1u/p379bm9O3GjMUX2jG2o33p5Lq7nYz6MvxS/ILqrHSqUZk2l4?=
 =?iso-8859-1?Q?15MAkT1WCohVGRh2dQvoEWIixkF17ja6TjJc/nnaKqFn9srkqLcknkSC2Y?=
 =?iso-8859-1?Q?U+RfpOdozskPded3i0L26L7EF/i/FAj5IfXsvACefBTR+Y0VvbJGkTGr/o?=
 =?iso-8859-1?Q?G7fwJNv7LafsFTO0rQa2A5RNZvAk8IcQJWN5P7PzrqXIBdDeCm02rOil7V?=
 =?iso-8859-1?Q?H/wiTXR8V34dqmxl670uZmEPOcCFYKtCSbVgUDrDr/HpC53gxsIc5NLiTf?=
 =?iso-8859-1?Q?laznJokc9JquaAG1wAoOyCAuWygPjWD3eSpY2x8+PPxZbVGmhd+zBRr7tU?=
 =?iso-8859-1?Q?y/HAvxOjffjEoDv6AeAbpqpJtFsq4kIA+NByTbMgXZ15727AIxXU0A7jBY?=
 =?iso-8859-1?Q?8Bm61n2DotJ0uLr9jNHWaq8mSBKlv3OGExHHNoYCiwqAHi+Zf6M4Gqfu6k?=
 =?iso-8859-1?Q?ERO9PiFHhbkMwOVqtWAf16cGbW0wPkfwuAQTmyemyEQ/idMUJhwC4HhoJj?=
 =?iso-8859-1?Q?IXW0TrvbcjEygqTSeQ93QieQVVTDQwRC3RIPavqt1JMQynYl8iuMORWTjn?=
 =?iso-8859-1?Q?nbdQ/4IIdYbAqd1TNMHdFu9rciJrk2UJ+872mw+Z4EMsTReLgVePx3y8Vv?=
 =?iso-8859-1?Q?sNq6PzxHHgWEm/OBgpP0V4Vu/FM+rYWY2xjTdSYltXhj8LY2Wc/kjYReTe?=
 =?iso-8859-1?Q?VLWwYIldtqxbUpqNtlR+7gdOjywOp/TpzQObYi+v2Fk/UVghBPINZHldUP?=
 =?iso-8859-1?Q?sUhP4b4kFpKJ7dlQAvMNWg5Tr90r9g5MAMzt2aGEtz5yPitx1w7fTaF9HW?=
 =?iso-8859-1?Q?zeAUPkT27fwc7g5TZC8Pa4YtcVjPUsXhnzghjT8H6U7lwDeJ2MMPWOzUKv?=
 =?iso-8859-1?Q?Ef7Bz6Qj+cwMaS/Ti9gMBOMR0WaGmXbL8irq1z3rnjnFUzDVXRSURCSzha?=
 =?iso-8859-1?Q?gUFkuekGRVbBRKJ+ynp8TWHRXdQzjZ8N1w8BQPxGwG0suQCSoncwqjyqwT?=
 =?iso-8859-1?Q?/ogQR7/OPefU00JsHlg9n/k0XH06/OYVAKmpXbTJl4GEWpTtYEqfNAx14K?=
 =?iso-8859-1?Q?lPSc8H8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AG6PVuSF9tCXDX63tBP41VVg3euIdebl1U0WaK1FCISBkth/Irbx/A3eHE?=
 =?iso-8859-1?Q?31QR+/Y+YlbMuREtx1EF8ZwY3FHnqbYi7gkWYVHZ5Fw0EHhuEUsg7qZI0n?=
 =?iso-8859-1?Q?VF7oOjGbyZzsCAJU7KnoHPeloM6ZcwyBnVEmmHqEZczPBf1IOq/7lgRfew?=
 =?iso-8859-1?Q?C1GEvBAqy7sJuMWAOxHcuHM+9z9KbWFa9Tf9tPQIFsi/L9zcjMBYm0kTCJ?=
 =?iso-8859-1?Q?PaTYyar7epU1AuN9xiUElRu/b8FkEgQYjXVAAFllKzac4tMpXZwyxM/1jM?=
 =?iso-8859-1?Q?V2NWhOCsDRQNX7i6GLcDvQIFH9GMk89enlUoFOKMRLLLvJpwnTSy5zADvp?=
 =?iso-8859-1?Q?Isjr+Rbt/COmKeo3nuRCREhrlqaCGRFd0eDMn3/5rdNyV+DpSIOuXowzPP?=
 =?iso-8859-1?Q?A2EImzEfR7nE0gc/GtwwAu6Wfc6vHoCQ1j8KRq1YGrYHorPjYkYRp/uXiV?=
 =?iso-8859-1?Q?wtpkt73IzIR/DmryBstYhL6sJRZJ8FB5J+1KepurymBt8ivg9c9C6SSay7?=
 =?iso-8859-1?Q?8V3sJdiC+wmpEkGgfIbqWVRs0aWxvpOoUKDkxwF0X5X1Xek/LsfQYIBjXS?=
 =?iso-8859-1?Q?mchWRjlPgekv9l/gn+VtUk8wwRxGTlZuBvjo5TrS5dW72GD9YG/w6r2phP?=
 =?iso-8859-1?Q?443hdlaTGRpRFihCKar2Qsa2QLlHr0WJCIMbqtkDy4u5HQ+N5i0b/vkk7R?=
 =?iso-8859-1?Q?JVGO1lrKil3UexQapOe0epGrw65BvV+zUMw5H6SBvipQ37zoN8YHp/CXOW?=
 =?iso-8859-1?Q?SIOwLU9fk3fZpAsBdyzBhh0upNj7kkhrEqoSxzR26BE7tuz9+Pl3FWTLzc?=
 =?iso-8859-1?Q?/6F+BWJGcBakRBtx1oeIzGirT9HyebJOULI9LpAhJFvebSjUdfn7mQDfMG?=
 =?iso-8859-1?Q?JqBKELyTvAerrhqSkau/cPtxfkTZWy9mdoF8jREdAMrXPBWVffigtK0KYk?=
 =?iso-8859-1?Q?UC+eYFjDVrUjTZn2QOiBmbDNbiB7FDiP//vZWeWMubmAauW4QmEoD8UZWZ?=
 =?iso-8859-1?Q?ox+xoqE0wTgXFBVnAtv0WCK+8/bngFvj/a1snT2/lJS1MTAfrTj/E1raIW?=
 =?iso-8859-1?Q?bFuZVWs5HFbPuodKzmOm1LVv7giey4O5TuKK5MTZuDQ0B1fXCOyBHskAfQ?=
 =?iso-8859-1?Q?QoPN/CX/xPEjwle9xv8SnnbULFx/oZneoxBkLkY0Q4ozVQlAOg9aK1cx+B?=
 =?iso-8859-1?Q?sawiANG6QsbjrYh5/9Y9YpgeU4RgHIKykQN3Rjj1Hnf8lm6FULK/B+oiKl?=
 =?iso-8859-1?Q?lH85f+20DeOpaWBY8YnSVKmXsM7LjjGIerqan3gi7o1zTgOparDp7wA83A?=
 =?iso-8859-1?Q?lzJZ5sYxJXGd3puWqrVjfKbILYEgahMZdHvWIajlPeRx2VItkas7BTvsMq?=
 =?iso-8859-1?Q?Aw8GaN3gAa3dmcTv2WlFQHFiPqoX7qDUgtTsIWhH3jv3Jt4wlCE7HYFTD3?=
 =?iso-8859-1?Q?hWsyygAbLj4oD5hVc+/9iPP37/YQZgoLmJZ/z0lpYt+a3XMOV71zcdVOHC?=
 =?iso-8859-1?Q?bShWjx8ce7iScLTGoLPYvVVRzoGyjiJGCrm/dlf3Pn2i1DfHyo4/JfSXc7?=
 =?iso-8859-1?Q?vLAgNPlBPNSzFf2LvX+d7FjBshrSynrWDj/8eeYTjEZtYdPHB/c8rUXha+?=
 =?iso-8859-1?Q?mq0g5KbTIVUfpy0XoLJl1nYVV894vR8bYW8F+Zpqu9corUItl+DKgWAw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9651aa76-ebf3-41a1-dcde-08dddf0bd666
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:33:29.0750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: io1GSVuq11znL3f9+TyNXgS5F+8xUTGtiQvpxBFuNxHsye9I032uEncsftH947NwDhXBTZttvvvGl6cUSM1o7ue/E6m+uE7lDeo2fW+oeZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4321
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Although memreserve entries in an FDT are 64-bit aligned relative to the
start of the FDT, we cannot guarantee that the FDT itself is 64-bit aligned
in memory. This is especially common when using a FIT image, where the
alignment of the embedded DTB cannot be controlled.

On systems that do not support unaligned 64-bit memory accesses, this leads
to faults when accessing the memreserve section before the FDT is relocated=
.
To resolve this, copy the 64-bit values into suitably aligned on-stack
variables before accessing them.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 scripts/dtc/libfdt/fdt_ro.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index d65656aaa8b..1c18aea66ab 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -174,6 +174,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(cons=
t void *fdt, int n)
=20
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *s=
ize)
 {
+	uint64_t u64;
 	const struct fdt_reserve_entry *re;
=20
 	FDT_RO_PROBE(fdt);
@@ -181,8 +182,10 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *=
address, uint64_t *size)
 	if (fdt_chk_extra() && !re)
 		return -FDT_ERR_BADOFFSET;
=20
-	*address =3D fdt64_to_cpu(re->address);
-	*size =3D fdt64_to_cpu(re->size);
+	memcpy(&u64, &re->address, sizeof(u64));
+	*address =3D fdt64_to_cpu(u64);
+	memcpy(&u64, &re->size, sizeof(u64));
+	*size =3D fdt64_to_cpu(u64);
 	return 0;
 }
=20
@@ -190,9 +193,11 @@ int fdt_num_mem_rsv(const void *fdt)
 {
 	int i;
 	const struct fdt_reserve_entry *re;
+	uint64_t u64;
=20
 	for (i =3D 0; (re =3D fdt_mem_rsv(fdt, i)) !=3D NULL; i++) {
-		if (fdt64_to_cpu(re->size) =3D=3D 0)
+		memcpy(&u64, &re->size, sizeof(u64));
+		if (fdt64_to_cpu(u64) =3D=3D 0)
 			return i;
 	}
 	return -FDT_ERR_TRUNCATED;
--=20
2.34.1
