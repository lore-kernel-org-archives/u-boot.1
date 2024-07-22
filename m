Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4384FC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 17:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7156C87D1A;
	Mon, 22 Jul 2024 19:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ogga.onmicrosoft.com header.i=@ogga.onmicrosoft.com header.b="GMDTID/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 992C6882AA; Mon, 22 Jul 2024 17:53:25 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AD688387
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 17:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ogga.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zli@ogga.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5E78nwHC8tLc1gWKvCrso9EnDEH3JioMGYA3sw6vN7NJL5D2SLw+XmbUppswgWgGBI0xlmSS1UNHlJ1k8l47wwyUFzt8zw3gQm7TDN9cJolIJZqyR1zreW2wxjJpRyQm9kyzOCqBCWy/CBF3tndF9vk450eoxeZo/3vph2jF5RK6sAwCJVnVkiw7TGG6VLE7iAC9BYcbjmvFAHj2V0wp76veChvelCuaXprKUpz9oV7QbGdQd06RBK9C6f8pAy/vSYWsQMQoeKM82Ml0FbgJuYElYlPs2SVvdePYGFuQljqAnbr58dHN5e3HXLP0IRl9UnPhwD4zYYALG79RG4emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKLemjazv+BPa/Kf4YsfJjOVfCBtf7sf7VaXT2H3Yfc=;
 b=WfJksq7ea3nDX5yq+SRX6GSrNXGVBZpPjaH2d2y2Bealfk1c3UcsObY81sDUThP6470hXbgAblGbe4yHfhbnowCYfOb/VboYQFHQQ9ss+kD8eYMNikHP5UD6kgeJnBQc4PX2quEZ4MRgHSBEDkwXdHDLxRnP3+oXg/rttQFuL+opel0tDemuKlwGVD0mHyk8EBSuVyJ2pRU6FPlOGimcyLW012W6PyogyEXO+5cO+rCQcN3HW1xRxCzDZHGyFbT3NrrOdtqWVObKbV2ZvauyRmYWYnJ8UMyJf5HTQytmUsqIlRHg2/BC56/q68AEHm6ASV3i7e6TnGmvDiY+SGTr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ogga.fr; dmarc=pass action=none header.from=ogga.fr; dkim=pass
 header.d=ogga.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ogga.onmicrosoft.com; 
 s=selector1-ogga-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKLemjazv+BPa/Kf4YsfJjOVfCBtf7sf7VaXT2H3Yfc=;
 b=GMDTID/AYhNwvW2sdogRKytb6ONrkgwfj6GVmSlqJpvKn3zblCiERmYmwz7YD4ahyowdD4xQSGZ9hgO2jrcMz6tB8iixh5bNOPjMdDmR+7vZQlfGljZfakgExXDKbqpdPoBupsz143rzuCVZTOIzSxSObY7kIRyyrX4JnhsJMhI=
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f2::20)
 by MR0P264MB4957.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 15:53:20 +0000
Received: from PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff]) by PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ead1:fb5b:e337:d4ff%6]) with mapi id 15.20.7784.017; Mon, 22 Jul 2024
 15:53:20 +0000
From: Zixun Li <zli@ogga.fr>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, open list
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: RE: usb gadget driver initialization issue
Thread-Topic: usb gadget driver initialization issue
Thread-Index: AdraksYKvUdWMPd+RkiQx27iAfyB4AATkGCAAFhrjmA=
Date: Mon, 22 Jul 2024 15:52:52 +0000
Deferred-Delivery: Mon, 22 Jul 2024 15:52:33 +0000
Message-ID: <PAZP264MB2974A94AD300B6A8210CD418B1A82@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
References: <PAZP264MB2974BB43BCE300D4A9E2FC63B1AE2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
 <7cd7bc33-a9c3-4235-9861-65d50338be45@denx.de>
In-Reply-To: <7cd7bc33-a9c3-4235-9861-65d50338be45@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ogga.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2974:EE_|MR0P264MB4957:EE_
x-ms-office365-filtering-correlation-id: 0489b6ff-6990-4054-8264-08dcaa666939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SW/sM8/5UBgm7VYpTokeF6rSrY7RDNV/ySuOx+I71aiRt6gOHhgay4WQWe4j?=
 =?us-ascii?Q?vZSHsgL2fPyWm5Xlk2Dkf6Eoww0QHNzZZUNmAH96x33VVdwygLE3nG/pXEp8?=
 =?us-ascii?Q?OsVkQTTU+zmGSZm5H9Yvtbvx4xlQH+qoatPtSNjl9+RKwJJQL9nBGTQbnxcJ?=
 =?us-ascii?Q?8iWCiaOrAKzf4dQs5bVTqbffeeLkCcz8jrXWiLdtH0WiS4knE0DHtLL1/0a8?=
 =?us-ascii?Q?s5EEj1T3i5ajzOGdjpH3lpbbx8gDRk4JGBjRnUtaufsjYBlycJh2jbXOtZdz?=
 =?us-ascii?Q?guFqEzTByd/MaRpy1gZ89j70cb34mkzuf9aVkMZbNpfHqIWshjSxRqeQYGFV?=
 =?us-ascii?Q?3KB2sXyvtjwxAcHz80a6hV9XoXhr2+7B8k9Z8Eqb1H87w84FxHyy9dVGseKI?=
 =?us-ascii?Q?bOC9pcI3xogvtLXxN5JxTwS/S4Z1/i6v8dRBx2+GFpLLThj68hfR6yF6+vMU?=
 =?us-ascii?Q?9/u69FNrxsLjda1//Bxtuv36SIWA2CuNx1IJnvW+zSSoQ5A5rEr9USLnMhWR?=
 =?us-ascii?Q?zTVN8wik0j6aIG+goHkaoTXLdl4uHz61sKYqHurtLCUzoBhnluHFI+PsEqvt?=
 =?us-ascii?Q?aDLcjDClQVfOTQhCbGlLkxnW9KCjbFCLPxXkAXbwFrlz2d6hSGvqX6TrujLd?=
 =?us-ascii?Q?7sEqzsYQfdp2sL9ZoNLZyZhdMMrYrhFb4huXN7LeQZ2937WIJrB0r2xr9WVp?=
 =?us-ascii?Q?AGMqieIMEkVhUkbKtnqhIClX9dcPrgan0rEFCPN7lT7x8j9QXrEKqf/NVKQ8?=
 =?us-ascii?Q?E0FdUJn9WVfUdxP5pP6cXd9KeYvXFwdWr17rV8UKg9aPZ00T2ff01ug/1EyP?=
 =?us-ascii?Q?PP0r2Vh7G6KmXUPRuqofmNHpBk6OwRG2lBZ35aRAVxzzHQePQDULzJirJfFm?=
 =?us-ascii?Q?xV1P/XLxF+ljBcWY7ybt0l8gnb9GO/6p8NIY0Hi0gCA4KXhwPniNd36ODRUL?=
 =?us-ascii?Q?0fkqodeGuDEUR1Kji67jjpXZCVhLLk5V0GI1LZZQKtyMcFLogZQqmCpotswF?=
 =?us-ascii?Q?ZCUl8w/BO9L6+LECz9oe4pGtusA9GDXmx9zJOo6dCq0bR/Dgo0TOZiBEEhv4?=
 =?us-ascii?Q?wmSM2z8cfnCQeZ3r4fxMzaUArnxrnczqoGt7y1iWQt6hITMhB4IyTE3NPAb5?=
 =?us-ascii?Q?BB5HAtn7U3osD2ugPevIduaqeshiHLMuU3FJefziDTRuoyNhXFvYUGU1raqA?=
 =?us-ascii?Q?j3hC8lFHfUlpbg+XhpKXAbOSFPbRp3FoDuBujXeEV3JvC4PbavAggP3V9XKu?=
 =?us-ascii?Q?3KIWTnr9J5332JfjVGCiWngXY1qgQt3mcxGGRdSERb9Hb78qaWvwxFKtMoYz?=
 =?us-ascii?Q?BDUirtUtMjKd7ilfBKBBmfnEXc7KL35urtYPQiGSL2USermnh6LWJ8uqjFrA?=
 =?us-ascii?Q?K57VKn9sQXY/UOxTD49X2pYDNsErxQuP3lwYN7cxcv2uVyKObA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vckrbo6j6DZbHAF30oqDRUUtCQZhkIFix3CEoSul+YA0UOrcew+6xG1wkXU/?=
 =?us-ascii?Q?F+ScQVHk8o+TJDQByaY+8OVyCJ/disFNmZWrsfkkOWFoW5p2PYtK6vS90wnW?=
 =?us-ascii?Q?P8eIpRGoFC8wyqUemYWYic2aJc9FNfuBZWURbg2pQP2Uv1QvxHYNNg9heQ+h?=
 =?us-ascii?Q?75Ub9abwwCHqMyV3sVfbztuE+SyxoeTB7VCEwZINQ+tjQFDRI+/nwJwLqV8x?=
 =?us-ascii?Q?JnCIDDtUSll4waFllEtNDySiFw09k4n4NGzN6d2E5Frhq1Le1kS2xmnmDQaS?=
 =?us-ascii?Q?PDS9KPFgMp5lpTUd317B0+m/VfLj/2jv/MH0xSjdJORxMhPvVJqz12MVxKuE?=
 =?us-ascii?Q?JTD806Lx6WAOqiC/sHn+Ot9Mq5BfRfs2oekb5CZG1GAErbLvcaiFx2uwJnWg?=
 =?us-ascii?Q?LlGs4dCFDGIjLfx4cqZFysNHCJmys3dQIgGHjG/sy7oU7qREkrD/q+0vIaRz?=
 =?us-ascii?Q?BKsc5Nd6p54Km5hfFoHRMx2jbI1ED3N+iVMRtGkWaY6sBlxo3GdQmLVl60Z9?=
 =?us-ascii?Q?GpDfr8L0km90phAeBlMORYrpsrCrT7Fo9xCyTzMwWhtaRiag8kf1wHIYbYAg?=
 =?us-ascii?Q?rCug1MVlhnIM8w12LXcBWW5P8+tv2m4ciuDuRFU3DZ/cSepu1THlE+pVbLAB?=
 =?us-ascii?Q?h7l7boOoQfXPAEB6JmOH8/szJb7XgSIJFk8Qsw+2WZSf7T5eDX3VoKOtirE5?=
 =?us-ascii?Q?1B2EXhOGCXlL6fzrNOE5TS5rpZ8IlJMnioVCt5hEt9o49rlji78e3CsNUc7B?=
 =?us-ascii?Q?gNYVY95FNnqcEYS2cBTL5AR79fj6oFxlWrx4/zmmJoVjMyuHLOPZOykFacFY?=
 =?us-ascii?Q?iaE0Sso2w/EqHaJF3HtksWECBHVtZv0jcauwFZuKz/r3KAMocRB8M7yQBo1m?=
 =?us-ascii?Q?b6VXbVeZzlz6DV1tJdemMGCD+IHS/zFzhK8qemwgz/Q00Pips6Bk46Vs4zBf?=
 =?us-ascii?Q?RmOohCE7NUFs3EIrAn8K82jvo2YZ5+E5zLPND/GgxYWFiTsbEocIYDnuhkBq?=
 =?us-ascii?Q?kPqGW3/5dqNDf1X7nb6LwGDotwHqq6+ZBX/Ii0i3SEXU/ea7HDjKA36R4rnT?=
 =?us-ascii?Q?eeM5AAAgIoDzwTrN45Eeqo0igGSKqTjmsPifV4pzibwepwzdxN7yeP11z7VI?=
 =?us-ascii?Q?RNLWDLMm1wxtDN3tyPxsY0zYNA/WDxZF16zrZl4aH3rD3tKW10sebGPEBOwi?=
 =?us-ascii?Q?7eZ55IgV1A6dBFQt6MDnyZpKAzy3x1Izn0Nf7kPJaFsAPDUk3oNUVO5hFFeQ?=
 =?us-ascii?Q?hFgzl0z3XXPPy+O+N6P00KIgOLVCwga7tQTgmLG0rSdD/5y1U7A793yRmp4j?=
 =?us-ascii?Q?+jGacm4g128iIeq7Hy3errfsKY2KAbPDCInxUtYAQUAkCGh8WSjVokxV4++h?=
 =?us-ascii?Q?RhDzyu5Le5z/oZaJyRnWJ7b3GlI9OW1vZoBoMmA6BPaejDv8exHmrHR2rL8H?=
 =?us-ascii?Q?DVJ2w3vuy5n6TBPQQ2xVjEZGVf00JaKfXpcWQ1nJ7bp0q5u3rgym0N8dsf+P?=
 =?us-ascii?Q?bQJzuOQNk7gT1amO+Ltv4/l9wSn/YMV3B7ciw3xSOIkE7CHIbGYANM9ZbQ?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ogga.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0489b6ff-6990-4054-8264-08dcaa666939
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 15:53:20.8379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a737871-c9db-44dc-a24e-55df547c3098
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYyaw7fUFebuXuvecL+Xmdehy2KCAOeivvJR5JjJKrttyd7ETSdV92HI4Ii1kKP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB4957
X-Mailman-Approved-At: Mon, 22 Jul 2024 19:44:59 +0200
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
> From: Marek Vasut <marex@denx.de>
> Sent: Saturday, July 20, 2024 22:12
>=20
> Can you please send an RFC patch ?
>=20
> > I see recently there are many DM related reworking, please forgive me
> > if it's already on the Todo list.
>=20
> It is not on the ToDo list, no.
>=20
> +CC Mattijs

Hi, this issue only affects usb_ether, as g_dnl will enter event loop right=
=20
after driver register so the host won't see an un responsive device.

I think one solution is revert half of 718f1d41 to move
 usb_gadget_register_driver()/usb_gadget_unregister_driver()=20
back to usb_eth_start()/usb_eth_stop().

It doesn't affect the ability of bind/unbind mentioned by the commit's=20
description. In fact by reverting it usb_ether will behaves more like=20
running 'ums' or 'dfu', since running a ethernet command like 'dhcp'
will do register->event loop->unregister just like 'ums' does.

