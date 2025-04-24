Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7B2C369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 03:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E08DD809A5;
	Thu, 24 Apr 2025 05:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="l8lMWZJP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD534807AE; Thu, 24 Apr 2025 05:31:33 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8F8280050
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlntS0rbaKPtB2prdPOXNd6BeZMy/Ki51KMWiMG/gCBwm0UKaRQRzVaX0icFb9krAW8/3mZWp5IEDBQheSwIPziWy3bI1hDQWZewjusAZeNfB9lMC+X+Kjy7a+dqkA06w+XuJCtl6VWOjJSes5k4lPZb8bTZZOO3YpxmeDo58yv3cIjXZtjM1pHL2x0ziUwDfO+B02ZaHRyJidzbJuYPcVDeZ6OpHdjwppYVUYvSdBGJCaxV3fIU7Y/8wzabopE9fKAqWUa9VvPqr5hbmq9o1K5X/Jer5WfjxMd+UYsF++6oiViSfvgxcKfhndS2lqWsaNqgnXd4APsQq3Vszeq8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfYLLNsmQZTW0GlaRz62dLeslTIk+c5VTk9m3gYFq0U=;
 b=os4dcQba9+O3qNQF5PM7cR3MZxRZ7D7bAH39HMfoCHIYIJhoKqEKcD/S4ydgsz5uJs7Ooqr30fST9vcTWGadvbtMKdOLFUiqQwazZrOiCOOt366ZN+A9RHh+/USxivKrVVQHFltFFtv2+FLWSXNtgmTnMb29sbZS7JDJy4o77ztBVT0UIS64mydqIDCsoiseF/LRltLyeYZeYWo0I5fK55Js6uMpybHT5MVcJr1AhTVmZ1KO14z+7GE0SJ1fSfdFlrYL7hBEwCvUMu9XlkotcQpKRlANPJBSmoOYx0PfTkNiX3QCdC+PYmaQ5NpLtOP0KqXa0Vaas1Phhu5d+tloVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfYLLNsmQZTW0GlaRz62dLeslTIk+c5VTk9m3gYFq0U=;
 b=l8lMWZJP9Qo0tjnFsJYqsOe85QDgs+HdEvPQnDBaM56gNvozLBKkP3fIwkvzdMsih0cd4awM7jz0Tc1DGqsKvilonBVPIRt+ENgs8e/Q5toj2IZqSZkKTydl1Da4pTLU0qyFKTucQDu/CIzRojyNy7MeXckNaj44aYbNFUnc4BaFyCmF49WiMYsvoqIxRy3R8FBb4gDF/HZFXK4Iy7N9vTuWKB1BvIazM0liOoYkCEXBdkWM7RaeS9sCBrqpNolBLbUgy84/Fb4UHVO1LScWtL7wdb0hIr/yXzpseR1UMtKaXv1tGMaa2+uFXNy/JmaIWgLpaZVkfw855HlydUjP4g==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.37; Thu, 24 Apr
 2025 03:31:26 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8655.037; Thu, 24 Apr 2025
 03:31:26 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>, U-boot Openlist
 <u-boot@lists.denx.de>
CC: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 William Zhang <william.zhang@broadcom.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@altera.com>, "Meng, 
 Tingting" <tingting.meng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Topic: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Index: AQHbrn4rcxt0E9dF3E6Vb/tAImrKsbOyNaZg
Date: Thu, 24 Apr 2025 03:31:25 +0000
Message-ID: <LV8PR03MB81379CC2A6E99563097B5B93A7852@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250416031751.23483-1-boon.khai.ng@altera.com>
In-Reply-To: <20250416031751.23483-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SJ0PR03MB5837:EE_
x-ms-office365-filtering-correlation-id: 036372a2-6bdd-4433-e8b0-08dd82e07e48
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?aXSjp2C1MKtCnK332FnslzF9VI9B2e7KGeLXj53gU9j2pkP9DCtbVmJJ7g95?=
 =?us-ascii?Q?x7Yc0mvtdIZrQMwuXl8IF9jaov4Mj9DEwDZqpIXzy59ZI7RIz2KihXjumAuV?=
 =?us-ascii?Q?yDd2HLYxM5qpU5whW4ZzJ98JfXPGdFo/HDCysGj4Uqk3a1C4g/uuaA7KvCLI?=
 =?us-ascii?Q?NRMsjr3rIbcNSNWEtskjEYc0MEPQKxJlRooX+xRo9XjKsLVvfbEpU96ozwxG?=
 =?us-ascii?Q?f1+E6nXgYGsQS7Cca6nY4TjerDoxVoOJxmS43d/29ED/9eLQKAOAoOLedsvN?=
 =?us-ascii?Q?cOoZrMDI1K11BS3FbP/dWefrr4tDIp4XZGWGgPwp7D+cbCC4S5rHKQ8R+dEm?=
 =?us-ascii?Q?w7awpNFDvEqN7kDgeBamcGnEb4Ghy9NkUxd2KXbRZXrn6mmhF+so8ogIm7hu?=
 =?us-ascii?Q?cRu8YduVadv5zJHJQta8y6ANbI1u7KZYu8NRtlMyBhgLVDY8mQAYT1YeYCli?=
 =?us-ascii?Q?js3Vf2IgAe0nBDHWhSEHMY7zpwIvZnV0Z1rTmot/hvP51P1175hS1pX8FHIi?=
 =?us-ascii?Q?gVZ5pKBK+Jp0kDt30NAEwziLE2AcMNwOn71P7c97n3JdMc5Fl4p+qwcwqF+s?=
 =?us-ascii?Q?3kU4Gs0DhpT9F3T5wH4ieRl0GbOGt8R0QB7PYP4qs95UUdKOpGHkwFwLswz7?=
 =?us-ascii?Q?FpDl9OxY+ZJwsk/Ry6cE7ImgL5/yfSfFQ135tgpYvRYB8FSfWhv59y6a98I3?=
 =?us-ascii?Q?u/GFOpueNU1+H+YoM0ACrgYPRHVq5kxwWlZIp7LjLzJBf5qEE8ApXygGwMaE?=
 =?us-ascii?Q?fVOh9fWyeJZ+HiaJqjLdi9VK3zkEAWNXvBCpiTNzeDcI5r+zpF4Qd/CJlY1x?=
 =?us-ascii?Q?yk6E7Eq7PNLCg8eLK6DVsr5I98wskrg5Tce06/4UyV6NH4Z74hjCD/Shd0Tm?=
 =?us-ascii?Q?iBW5KoVYy9y8Amo4aZPqE8QsH6ghBi62yiibEITIH8J9r32Fi3A4q4Je4vi3?=
 =?us-ascii?Q?saq/yNprMMAl3UYBF8cyKUnXN9CoW3AVXkcdW8e1WnJq/aIJn1zY4kfg81is?=
 =?us-ascii?Q?sLbhSBd2UgW5ubVFvhSGBhE9oWzcALHROhptNsCQMM95xEIyG/IEQAN9wbDx?=
 =?us-ascii?Q?SwiPp9eCkSrOHGb/RJbaHbctlfA1G+q0TjMcbaNZqLJBsz1wccSAkRSeB+/f?=
 =?us-ascii?Q?mNs4K/qZch4gA/nl30iDHuaLNRshhjc6CaIXli821Z3D+eEvxM8flMgCYEfJ?=
 =?us-ascii?Q?Is/9FYcJoxHtu/9ZCt0mV1WZsW+KIbmh9rPRclKEg+b/muzAkGk8iQm+x61g?=
 =?us-ascii?Q?nW8amPDhp05pTq9HRL5T5jYJXPpKDz2J58Gtkc2oWBb9Iql2Lf82aE8U6oLt?=
 =?us-ascii?Q?WwZAEcNBkG3XOT1ZyJ/yX2icDSMOOAycMybKp72RpStW9tkSKYh9oCKEL2Wx?=
 =?us-ascii?Q?wS75XySlk9qkUc8+o0n3Uc2eX7jPKz7DxMErLa+D22eNVtVEmzDm0Sk1FHUY?=
 =?us-ascii?Q?F4kVV1qHRL0RpCBs4wCgZxgR3rHvl+9Yfl8hKqJV+cDJ1RmMxs1S07mkVzP7?=
 =?us-ascii?Q?WSZz50pidz4SMhc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lupwU7GK/8CYsstd9aTrXqVyCDaHQ2170ljwq/q56sAw/+ZIHKjzmayyLQiy?=
 =?us-ascii?Q?EAVFAdAYj740MGWZ1nC0EkcyqEboKtkq7lSVDEnOpF6X4gag6NspSHITSBvi?=
 =?us-ascii?Q?ytryRvxSBhoeO1pNOeOlgm06ActWxcirwUyUyVtCCtUYcePm1fl70Z7RRmhL?=
 =?us-ascii?Q?kOUohHTYFog1WhS7nAhcSKeSwivn0YQev2DNH1bQPyYgKbbndTkrFo8mkAzb?=
 =?us-ascii?Q?E5wtrxSb7RLnEmbYGobr25WBmudcfNSjQTuAiwOzwsy4kNvnxMMEnKTaYx7s?=
 =?us-ascii?Q?CUFbFz3MEhvxalSxhcosovFKcjhXxAlfaCl6N6c/GVOC8ZnQHQ05+ABIMx2s?=
 =?us-ascii?Q?sRg+Lczv890NKNxjg+pgjictinwBiVxzl2CJ/ZcuwGwxHknYlsQJ1U7zdqFj?=
 =?us-ascii?Q?+vULSG1Iq7kHBKueTToTVn2pj/6AB6UEMpFBFVVnTJnJEf7WoCQg4ExsEZpw?=
 =?us-ascii?Q?4p9313ffbqNfyVC8yrh+zc/w8EIe2E+5nG9NCye+UyFcT7U7+XatCd6RjDpS?=
 =?us-ascii?Q?9KMPQQMA8ztrp3XR0UwB2jit+UiloXGU2xrYWOor7DFRAwPnG0ttoZ0clddq?=
 =?us-ascii?Q?yXf6ajOjh2UbYkUbATB96/9gFQMmaSGEeHLrf0WFO84pETRkgcmdOPbVnRbV?=
 =?us-ascii?Q?TcvpxTvND6KJPCrxYwqPUfmZASLkUNPDivaRheJHczCaEa30joTof+e+YGNn?=
 =?us-ascii?Q?6VqGhrwYiqcVpvXmGqSxBNXaPFXfqlQQwi03c1yC3ruz1xLWGak2JHEIJK99?=
 =?us-ascii?Q?EELKgBGXoELdYdHaP+Wog8id8rtN6elOQPWBu5agIggYMETD4kJalq4cEF+R?=
 =?us-ascii?Q?xhKUQxfWJpShsIsn9Kwrum3IB9qLjFBVKyAoqF+LcXUbdVUPAEjcvVoWfEhS?=
 =?us-ascii?Q?1MJMqQ/9U5CS1QMlczBAuu9yxzbcXT85ONpTWimG/uiTuzP/RwpbEsn3mRV8?=
 =?us-ascii?Q?jKWCpkMVOo96+M9l4QQy0EnyO7g2+fvHAjg/GoaTo/wqEcKuYmUEMRaeRnuz?=
 =?us-ascii?Q?gJUtg7Juo9Pui5/deR+wXqfF0UCtry2dhWag/5TyAB6GnMLr4WCz8vJwYk9g?=
 =?us-ascii?Q?U4zBorGf6LkD8WRNDp3LUEhU9UDHNZ1IW8sNG4AwuTMWN9YCXaM67Mj/S4jp?=
 =?us-ascii?Q?OkuWvuIyE/J3CgLEQHu8NT15XkUuuIyC3j/WI3daNRzHQZvb00XefIFwWDDr?=
 =?us-ascii?Q?EmgBi/03pn6XR3CcMKUd12roJRnVOjXSylNj2F+5RQPUDsMsBGZrbZDpOUjG?=
 =?us-ascii?Q?K8XjfRMQPBkChkpXFhXj+ZP8nKrWaHP3EbOWDhAsNEme7GXlNIDAVNvccJjM?=
 =?us-ascii?Q?G5e/yB7KZUUiNNAQYa+l+s7XXMzhT/F+vI9xp4ESuyU67FxduCquYCV6JStg?=
 =?us-ascii?Q?0I0bKKBdriEN75HYzeDhFQJRXgZWX8xjaUcTC2mwozfKfSc8BP/tOwqa/jhH?=
 =?us-ascii?Q?1bLdJH+q/MeV6Ih/QqGA3Ek2K2sf8dhYg+YeFZcj1XGAbNvJ1/GzGMeLHICC?=
 =?us-ascii?Q?R2mL/GstmBXIk3PRIcQrWuGqjFMFfRp44PjP2nr7TcVR2hldCnn8xIWhT9CF?=
 =?us-ascii?Q?3/bhb8DovE+anEC/jO729rVRrvJ543Kap15AhXqU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036372a2-6bdd-4433-e8b0-08dd82e07e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:31:25.9174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3KMmKbxxgPAT1wnGl0lNwGrgBDcN1g+valzE/bTT0G0uvWmhwWKH/NjVd3SQJ9Vat0bL8krRvt3PE4WRvnd6pOjV10Kh2MfiIVXYD/F3t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837
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
> From: Ng, Boon Khai <boon.khai.ng@altera.com>
> Sent: Wednesday, April 16, 2025 11:18 AM
> To: U-boot Openlist <u-boot@lists.denx.de>
> Cc: Jagan Teki <jagan@amarulasolutions.com>; Tom Rini
> <trini@konsulko.com>; Michal Simek <michal.simek@amd.com>; Venkatesh
> Yadav Abbarapu <venkatesh.abbarapu@amd.com>; Tejas Bhumkar
> <tejas.arvind.bhumkar@amd.com>; William Zhang
> <william.zhang@broadcom.com>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Meng, Tingting
> <tingting.meng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>
> Subject: [CAD QSPI v2] spi: cadence-qspi: Add disable STIG mode quikrs.
>=20
> Adding quirk to disable STIG mode since cadence controller has issue for
> read/write using the STIG mode. STIG mode is enabled by default since
> 2023.04 for small read/write(<8bytes).
>=20
> Updated STIG mode reading from dev_get_driver_data by assigning to
> platdata struct before read quirks variable.
>=20
> The STIG mode is disabled for normal read case and enabled for QSPI Jedec
> ID read/write since it requires STIG read/write.
>=20
> Porting from linux implementation
> https://lore.kernel.org/all/20241204063338.296959-1-niravkumar
> .l.rabara@intel.com/T/
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/spi/cadence_qspi.c | 29 +++++++++++++++++++++++++----
> drivers/spi/cadence_qspi.h |  7 +++++++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c inde=
x
> 623904ecdad..c2990ac833e 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -27,6 +27,9 @@
>  #define CQSPI_READ			2
>  #define CQSPI_WRITE			3
>=20
> +/* Quirks */
> +#define CQSPI_DISABLE_STIG_MODE		BIT(0)
> +
>  __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>  				     const struct spi_mem_op *op)
>  {
> @@ -217,6 +220,7 @@ static int cadence_spi_probe(struct udevice *bus)
>  	priv->tsd2d_ns		=3D plat->tsd2d_ns;
>  	priv->tchsh_ns		=3D plat->tchsh_ns;
>  	priv->tslch_ns		=3D plat->tslch_ns;
> +	priv->quirks		=3D plat->quirks;
>=20
>  	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
>  		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
> @@ -307,12 +311,16 @@ static int cadence_spi_mem_exec_op(struct
> spi_slave *spi,
>  		 * which is unsupported on some flash devices during register
>  		 * reads, prefer STIG mode for such small reads.
>  		 */
> -		if (op->data.nbytes <=3D CQSPI_STIG_DATA_LEN_MAX)
> +		if (!op->addr.nbytes ||
> +		    (op->data.nbytes <=3D CQSPI_STIG_DATA_LEN_MAX &&
> +		     !(priv->quirks & CQSPI_DISABLE_STIG_MODE)))
>  			mode =3D CQSPI_STIG_READ;
>  		else
>  			mode =3D CQSPI_READ;
>  	} else {
> -		if (op->data.nbytes <=3D CQSPI_STIG_DATA_LEN_MAX)
> +		if (!op->addr.nbytes || !op->data.buf.out ||
> +		    (op->data.nbytes <=3D CQSPI_STIG_DATA_LEN_MAX &&
> +		     !(priv->quirks & CQSPI_DISABLE_STIG_MODE)))
>  			mode =3D CQSPI_STIG_WRITE;
>  		else
>  			mode =3D CQSPI_WRITE;
> @@ -427,6 +435,10 @@ static int cadence_spi_of_to_plat(struct udevice
> *bus)
>  	plat->read_delay =3D ofnode_read_s32_default(subnode, "cdns,read-
> delay",
>  						   -1);
>=20
> +	const struct cqspi_driver_platdata *drvdata =3D
> +		(struct cqspi_driver_platdata *)dev_get_driver_data(bus);
> +	plat->quirks =3D drvdata->quirks;
> +
>  	debug("%s: regbase=3D%p ahbbase=3D%p max-frequency=3D%d page-
> size=3D%d\n",
>  	      __func__, plat->regbase, plat->ahbbase, plat->max_hz,
>  	      plat->page_size);
> @@ -449,9 +461,18 @@ static const struct dm_spi_ops cadence_spi_ops =3D {
>  	 */
>  };
>=20
> +static const struct cqspi_driver_platdata cdns_qspi =3D {
> +	.quirks =3D CQSPI_DISABLE_STIG_MODE,
> +};
> +
>  static const struct udevice_id cadence_spi_ids[] =3D {
> -	{ .compatible =3D "cdns,qspi-nor" },
> -	{ .compatible =3D "ti,am654-ospi" },
> +	{
> +		.compatible =3D "cdns,qspi-nor",
> +		.data =3D (ulong)&cdns_qspi,
> +	},
> +	{
> +		.compatible =3D "ti,am654-ospi"
> +	},
>  	{ }
>  };
>=20
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h inde=
x
> 1f9125cd239..e6ea9e6c1f4 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -220,6 +220,7 @@ struct cadence_spi_plat {
>  	u32		tsd2d_ns;
>  	u32		tchsh_ns;
>  	u32		tslch_ns;
> +	u32		quirks;
>=20
>  	bool            is_dma;
>  };
> @@ -251,6 +252,7 @@ struct cadence_spi_priv {
>  	u32		tsd2d_ns;
>  	u32		tchsh_ns;
>  	u32		tslch_ns;
> +	u32		quirks;
>  	u8              edge_mode;
>  	u8              dll_mode;
>  	bool		extra_dummy;
> @@ -266,6 +268,11 @@ struct cadence_spi_priv {
>  	bool		dtr;
>  };
>=20
> +struct cqspi_driver_platdata {
> +	u32 hwcaps_mask;
> +	u32 quirks;
> +};
> +
>  /* Functions call declaration */
>  void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv);  v=
oid
> cadence_qspi_apb_controller_enable(void *reg_base_addr);
> --
> Changelog:
>=20
> v2:
> Added commit message explaining where does the code refer from.
> https://lore.kernel.org/all/20241204063338.296959-1-niravkumar.
> l.rabara@intel.com/T/
>=20
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

