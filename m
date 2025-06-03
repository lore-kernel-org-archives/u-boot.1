Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8364EC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE1382D18;
	Tue,  3 Jun 2025 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Z3j6MmaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F127681E72; Tue,  3 Jun 2025 15:39:47 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED07880F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDVsocwKQyPnko/ZHt8mLfPPc4D5B5ZUH+lCzgoR81QnJOQ6VpyOiZdGn5eoHG3qe0k/SL3YjlapGZvkSYACnL3EzOFolS6AnzmJW13jM67KXw5XSOLCE2f5oZ+fe/gbjiDNu1lDUhDs+Nuxm81HY+ICrdDUhB3zZEp/uQHAizh+Z0MPmBw1nwuQPFrN3+vh2tEBKGvSv5KzY86QpriXJu/El9yea9K7JSFk5RS6rpYvad5OyiUP/T5iyoT96hVC9kX273+7Eg5ZSxxyhi1GSR41oy5Vet2iZvfsWXlJlxW2h9BK9QufynvRcDFAF54SmXGWQ/n/4i89qkHJjM1sNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=RXJFCSv6szhTev6oh4aE808P8VnGHEtz8Q2Rsdt7zdc/t5u00283klhIgmwnxlHCCz3JBKDo371iHEzXJA/15CGcUwJSChHADI/3h7ZWVB1Um0zm/PhUj98vg09PLG/PoTD5Ix4SQ5BBgSQ8TJvp0gf0+GXF8At1oxSLtpoUIlL3CRyLROuCPGyDi41qwaSIZaeMH8B7OUWZh0W0pzrWRj7CeHtb4GS1nJ/+8r2fJAxLH/g1iPY4EyNZVkIM6OwedaGnslv1MypsXOeIJk7g9OJvcXRsobI8f35bcDhoa+QEPf/mi62ZbGeI8fUZONl4UmUv7jLOTwyv4RayFhQc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=Z3j6MmaRvnMoKbkuX9013DBwFxexHun/0tbRpVAJd2eCH+1jXisN0fL1+Oztn0cOlifldvqFSYdJPu7Rkyf/6ynJHBSpAnJWHmWQp2pRdnf0C8vpnR1hbepxOfD7ZsetSH8hKqcwSTmssvLKQ5io9jRt2LP/jLlfNK2Gjtg8+9hv/0rEzuejb1uCphjpOhgRqQtDsBPCYl6ZtNlhxW2+pjFzjuQ2EY1YKKuTS7MCqC4RNLSoNEEp7sTYrpng5+KRmoBkcIypAuk60L0K4e3bl1b1n/njfwqIaCQPj0dnZ6cEWpBqEyhb6GZNPyIo/UY0DjzB7KUIbddJLcSykKF/XQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by DB4PR09MB6623.eurprd09.prod.outlook.com (2603:10a6:10:3f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 13:39:44 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:39:44 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH 06/11] libfdt: Allow non-64b aligned memreserve entries
Thread-Topic: [PATCH 06/11] libfdt: Allow non-64b aligned memreserve entries
Thread-Index: AQHb1Iz3PUj7ES8orEGde/hMsDI2Ng==
Date: Tue, 3 Jun 2025 13:39:44 +0000
Message-ID: <20250603133744.278790-7-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|DB4PR09MB6623:EE_
x-ms-office365-filtering-correlation-id: 9318b607-1d61-415d-f3ee-08dda2a4199a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LBSNLwD0vw8qycYIlb9s2di5RbPkKZovXfZxJgH6DI75lzj294OZ0kkTQC?=
 =?iso-8859-1?Q?kkNcQuuKrcO2V7a9vCndHZpe3E/OvZFaiL42EqzN5xSYgJAFy3CKayS790?=
 =?iso-8859-1?Q?wCnVP/lv/Flj9Oa9oRruxiPkLRNKYyZmNyVmqZKFcSyW/1o+ukuWmnHaFZ?=
 =?iso-8859-1?Q?7dqqFL+k+7FGtYXwnja9q/gEQYejbYJXeWdi4/EEivredd3QiFh5r3W/nN?=
 =?iso-8859-1?Q?OPu1Ga4Xz+R5kRCJjEckVD6gJTcDsi5SZqBjhXEb4nQ8+fBzGspsoxmbXU?=
 =?iso-8859-1?Q?RmWJgVL41o+W6xImBlhqUWK190qNeWixpwd3QMAgcb/kFN14IYaxowtylA?=
 =?iso-8859-1?Q?+PIF2rVhs2e9oS9y93Z5XFV4dSGC+95wQb3b0Fy0J0W9R9qAtXIPAeYE6V?=
 =?iso-8859-1?Q?Rdiwwwsw8LZprX4tqrrTqrRzwOZUewx2p6i10ZSJYOjTjcH0x+TFxm9zZ/?=
 =?iso-8859-1?Q?wgUBVedrGkdI7XKzJLJVVQ7eIXazM0lYS2CUEc0VVwe83e0q0qWuZ8YhPu?=
 =?iso-8859-1?Q?QeibwUdYdOibhEXsFmoVqdtwfTUI80BzgPCm9L2oXozjkfjKiXJ0NnhT67?=
 =?iso-8859-1?Q?O8Bsht6DB58nWTPmOCnjr+9LHSkLUDtP04i4dNTMO7Y4XO6QYP5TQf/JO+?=
 =?iso-8859-1?Q?CZU7vmpxZ+c9Fg9VDz5YR7mbSuzJIMzJ4i0UeDqXL6jSVuUjOz1uocwlfZ?=
 =?iso-8859-1?Q?lAWITVbnwqnToaNXyoueiIhNWq2QwE+cNU5pJDytWtxtE8IPqA94YNcrxc?=
 =?iso-8859-1?Q?29GaqEWRlR+CH3lFQ2VstYIx9XkTu+NFQMMSER9OhggEUDqzzZhvRzt6Wv?=
 =?iso-8859-1?Q?s7nOTQ10kC2YZFNTG3l/lPjEN0xhYfWUizxMaZBv13ezRFzQdH0XOvcR9E?=
 =?iso-8859-1?Q?LTUmdJSxU/nto5HsIx+1xTW4DONcuCYkdPA946jtd5msIYI0veP6ezxc4G?=
 =?iso-8859-1?Q?teQjMKwn2YBfuEwaAkj2LoEZ/++xL5jQIinDQL/lRHbjX9M72TIDAuh7Mx?=
 =?iso-8859-1?Q?ITPMoQzo9xVVqmg0hrOseJ+4+SEiioVkQXq9bck65ycclIwyRL19AMZspr?=
 =?iso-8859-1?Q?zUf9wjFhQ4nbzpmv1CFE+N1bh6c+de3ib9GyHnGwdr5pDG/GXquGBmuoYv?=
 =?iso-8859-1?Q?/LcDUWEESu2tCw5VFMIIbsirsGIcToqmUToS0Kk8JmfwIN0aIuH3tSZRnh?=
 =?iso-8859-1?Q?rRRWSVbib64xr8nS5TU7I6crFzCS6n9mQo866VAxbog8HsMt3s34h9TolW?=
 =?iso-8859-1?Q?OOzU3XCtr8xtbADomToNjJshIICtGpcvBdrfliCESAM9NYuS10QlqbMwKW?=
 =?iso-8859-1?Q?cH6y4gSjq6y3UqhspbWIFr2Is1cPe6GsuRYwq80FV0alvV5fTsdeg20jox?=
 =?iso-8859-1?Q?f9jpCnBdMaL4xHPvZlE9njgeCoMv5nZWAM83qECSwVwXT+COII1gooflMc?=
 =?iso-8859-1?Q?qOP14XHXoU8t5Lh7yMACFpK3f6K3YrVzMvlBZFoxCH76SGlRW4cyLlEHI9?=
 =?iso-8859-1?Q?J1PJKUneaKOEHSuYieE9jd0bR4Mw3cjI1BCpb/K2F3GlnjcPy/fMfBkADq?=
 =?iso-8859-1?Q?dDjDYHw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vUDmle6STPZr9yxskMyAUHHm9lqS5wJ17cTKVZIZmrKKPtToYfKL5nEV36?=
 =?iso-8859-1?Q?7nKj/sT8ZzqjsmCZeer3bF0aqxUI2TJOVT1RWMEgRNootUlv7diNaK3/Go?=
 =?iso-8859-1?Q?u0VmAziVEkgf90O9T7//OqUyIRIaMCHCQ7DLzf0c6HrQ4xatYWivL7f+VX?=
 =?iso-8859-1?Q?IljxdHvWgJVkcpU7tt6KPbnW7QViYNSwc/kuUWnLnkrQ3vnKaR5afA5+2I?=
 =?iso-8859-1?Q?ahC++g+/kQAuffhuq0bZr98dnC8rwnHMW202ZTHxmbebaaFkCkDPSTSMni?=
 =?iso-8859-1?Q?uTgqEXOQjLBuvLtOEqmLhEd8F6Ic786O8TYNorXiKW4hdN0ZkPeNBB5Zc/?=
 =?iso-8859-1?Q?asIXtV15I9SaRokRt0xirLR8946aQW/Y3zD6mrBU2v4ib1E04uMOhkI1v5?=
 =?iso-8859-1?Q?qOCWGxWGHgfS2ECpddk5uLh6h/iaDO11XtMpVAus638BfBNMfKDu8wFX7L?=
 =?iso-8859-1?Q?yFE5wmm6k0to2CnsdPeTFBJ64O3xJygVMWkHVPwtEz/Pv2J88NI7bMT9fP?=
 =?iso-8859-1?Q?14paB4JNcbFTaxdWcVYI/afkK9bMuDM0lN+3HchkThxIHI656n5TEoQPqd?=
 =?iso-8859-1?Q?itiMXCfKbJoiwHnYK0MoKUYZzYKqHatGHW0xzPHqwnCzg/QT2491J+vqJh?=
 =?iso-8859-1?Q?t7pJlu98tXPaD3wYB6fWmrlS947lQG8iqIgvHrYc+B+ypgbTnPInpIH/K2?=
 =?iso-8859-1?Q?ILwfXH0akAejvqTXglzVmwEWX8aT6Rvn5w9k8EBqhnxM7/VG1KEIi8kvVS?=
 =?iso-8859-1?Q?swCuFShcn6GUUz186IjtYS+USgoFVFk0uMKlc8eiTYJCjpYn8CKmmJg1/6?=
 =?iso-8859-1?Q?8fqh0vimC1fW2TaMYzV5QJKfgZ402wukvxAf3va9yIcViNTdUFhxlRIkI8?=
 =?iso-8859-1?Q?yBxI2Dw5yWiUINrje39KcrH/hPo9LWUzis06Mx9SRJ6R4hIeXmTu32ZvNf?=
 =?iso-8859-1?Q?eCLiG65uaSL7CsAagpVbGkCinjd6MgtjbCes2gITHsylZlV19QuiWydyy2?=
 =?iso-8859-1?Q?gxZPm2R4SDWa1uC90INIvntG8+XaddmFrhR2owpEs/1UwXAoeCfw9bWKJJ?=
 =?iso-8859-1?Q?9kg6cTnd+U4vbF8sfJ0spx4/+6gAgz2Z96zsPYTDhiURI7Oj5TsmDtQeBs?=
 =?iso-8859-1?Q?ANOQU4fszHRQvK+jShx7qraebrwyVPfaUFPLrt2YKCBdDeNRwCIHvQ7N4g?=
 =?iso-8859-1?Q?u7DonBAOj1XZm5i9goJfYYbFlY+Dpc8PBU9y5uOze7hILyYa6prsIM6sH6?=
 =?iso-8859-1?Q?uVfi5II0fFLWu5Lygd3kWgllaLdUhwOzqSVYl8ZZxnxkzI82Zz/MewsLIR?=
 =?iso-8859-1?Q?WCx9rXETkNieEMCU/GH6VgzOgRsnuWkz+roZP7GVV/DeBtARi6E5Lochuc?=
 =?iso-8859-1?Q?lBxZRUbh7ma2pL+d3x22XwFRg8J3UQoTc3hyoZKBWLIJ/mGFrBODhFUyW/?=
 =?iso-8859-1?Q?reY1SHkCUyQzS3JfIXm0EGuANvDvf5IcQlpSpQN0DDoBYDrW09rTqfkO9V?=
 =?iso-8859-1?Q?eQwRdyN4JC0jUR1P495W++hUkeOGoThMrq7s/DUxK+uzSmj7BOZkSo9PqB?=
 =?iso-8859-1?Q?x5mIBWxc/0eXUBwQUij7wdDxETUAr4YNimr0cK1BX6n6kOOiIE1ZvKYG5O?=
 =?iso-8859-1?Q?CFSskSxUupsbbu4/CQ1eYKCsU88PDcNkZHHsMlKbe+6JobUIxznPWmGg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9318b607-1d61-415d-f3ee-08dda2a4199a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:39:44.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ws2Sy2OHulZp7ICuxt+fXb27mnibMbZmsmGtoysaKXHacAwRXcHMBgKGKeATio6tU3GJXNzxlhFvujGd66H4F4ox9wgcmpmqC7AvpK3JQzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB6623
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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
