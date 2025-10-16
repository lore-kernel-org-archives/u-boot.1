Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B82CCD19A
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 13:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23E4A8367F;
	Thu, 16 Oct 2025 15:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rbaOn/4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD1FA807B1; Thu, 16 Oct 2025 05:35:05 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99F0800D7
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 05:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGGAA/I/7qn1w3+62oF1KbmmreF5L6g8hbuRj8CxwIlms6KmUcdSHsw4g9mDO1jb8NTGoQKO0KTw7pXUOxzbWlvUJaK4As4X6Bpmb5aWAuAz3C+sJkusuVhwnU+DZ+rj0OMFufuV5TQ9VfxB2uO1DNP38imc2ZwGl85VqPEu6yZVrmxShKMyYp3lY06oHhKpkS6PP+DPozh3vnm8BhdCRrxhuQx/VVAcGROOIyR9Exu3S0bxxpxIcmpmxn/gQIDS4S12NziIfuAC1B35kWwCasW6Qzncp95dRdWTJeW1fBcAPen+ldf7JZbofcJsKF+hfp7UHn7lJM8+fDjgFlka9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsHAb9/ajwkSaPjdtuddoNEjD/qFR0kmLH2wVfsoPB8=;
 b=u57TwA+nqIa4vBQN0BYJAwo38wESKqALI7b5GyhFdua9YSb7rZLo7A9Ld6/8d+TFKp+8SLlGQs+8BaP1HxJ2eytYyEXcAP/9TG6RnqLffdlableo5R8ZP62gPvmB22sKr4BjFviY73O7qmzmW7g5sNUa6THO2Y7nuj6eOm0phAXw9M4OSHuFsqp1wyco4p4iquTTFU1iRUAwvlNmOBvWXo7sztjJvBUr5dQxs8PnRT0pXsGjrpM5rV9isknKoubsf4gRv2anBomkRgidS8SD+Jb2/t3CowmpZUgnd3YCwM9LMJl12aKAqWn/8IMj7/HsHyVK2oLonC+udp9k6BSKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsHAb9/ajwkSaPjdtuddoNEjD/qFR0kmLH2wVfsoPB8=;
 b=rbaOn/4r4z0bW7Rz9u+3+J2jKvYsQh/hvV6Luu2Tf+KxjfxFZ2Aonu5AdakOTrjmtTApgmiB2dIAnhcWERRqh1dcGD5eFDxx1Y2rMGnlaBPSgWjmbAC+M6pVvqqbfNQOsd2X7MqEeFfQMLbQ+ml6n3sxU6djM8KjtMRbKvgrhRcNa4B46csUPF8bdWizSLI6dOcc35UhPhpAklAkcgJgtrpa9hNAmPCk7jK05ws1hi3Yyc+gAUPmH/Z+0AbKsj2a8SF5FmB2OyCVYb86r657qhTQoSyEi2LJFEHgrK/tH7OwBSGHULKV5wAq+6B5ay2lHPYNXC2cLy8nyeyWJaniMw==
Received: from BY1PR03MB7190.namprd03.prod.outlook.com (2603:10b6:a03:52d::10)
 by CH0PR03MB6164.namprd03.prod.outlook.com (2603:10b6:610:d3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 03:34:56 +0000
Received: from BY1PR03MB7190.namprd03.prod.outlook.com
 ([fe80::554b:ee27:5c43:7ea0]) by BY1PR03MB7190.namprd03.prod.outlook.com
 ([fe80::554b:ee27:5c43:7ea0%4]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 03:34:55 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: Jagan Teki <jagan@amarulasolutions.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Chee, Tien Fong" <tien.fong.chee@altera.com>
Subject: RE: [PATCH v1 1/2] spi: cadence: Add driver for xSPI
Thread-Topic: [PATCH v1 1/2] spi: cadence: Add driver for xSPI
Thread-Index: AQHcPPNIil/07AXsIUy7XXwfRn6lJrTDyPoAgABXTAA=
Date: Thu, 16 Oct 2025 03:34:55 +0000
Message-ID: <BY1PR03MB719006799BE98987B8856DFBB4E9A@BY1PR03MB7190.namprd03.prod.outlook.com>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
 <20251014101354.11182-2-boon.khai.ng@altera.com>
 <20251015221706.GU6113@bill-the-cat>
In-Reply-To: <20251015221706.GU6113@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR03MB7190:EE_|CH0PR03MB6164:EE_
x-ms-office365-filtering-correlation-id: 20daf667-5660-4090-d46f-08de0c64f9a9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XwXg6CAVYxYqt1dbqs1FAZ6INi2U8ZQ7EGf1W4Dn+5hSiTszDeqil2wMLGai?=
 =?us-ascii?Q?mwuiedFrvndxlMbQtIj+BriE9UCVsHhlmjwd3enG5KVDmasxihzLUHZew1Cq?=
 =?us-ascii?Q?g0Jq8FA1zd3fOAlhwZqQSwmNUCFxAP3Bg8ACA/l/6dAWZTaMHXj7fhOVyrj4?=
 =?us-ascii?Q?AnPohlu8GP5IY6I9JEiysLjJ6S4yrCitnz1k2aIng9cizGPfH7B3aL2iwc6P?=
 =?us-ascii?Q?1yWrn6gflIRNm0xYdmatDWQhjRZ3EAJGk4zDIc2KG8jfv8F26Nfe2imasxxH?=
 =?us-ascii?Q?vB0KqjiZaE4cywF2TdJiDOChaRvWml7j2ehE7fVikpXRX212o0vud+muFs8C?=
 =?us-ascii?Q?0rU5rOlcP1GtpRjk8v47LMvFCZvdKxNfLwg4pgwNtc22gFoEgBwKq9hJoYN/?=
 =?us-ascii?Q?RnIw5ywTXKWoGB9E3b/oiX+BWX06E9DlBJkstAsQr58IhSrS1ltqAHdSIASs?=
 =?us-ascii?Q?mS9A7E1OsaDnvPb62K3drkUaKLDOolQI1+cpPR3a7a+3pqia5Uv/PEkFVMAI?=
 =?us-ascii?Q?gvmKagtcw8fNd8aE25EzcgcYv7S5yaS3O3VpBPVHwPCK7FreGOxGICShE+hO?=
 =?us-ascii?Q?WPrm1DUzcw1AiRP3dYZUErp/c2uQSA7L6fcOlR9VdX2Y+mlHQt880Gmpf3Uu?=
 =?us-ascii?Q?3cXxgAt1XNBrleTLEzWKjib22JBFVhHjJNEQQNiq2ukp9ax0ATsMVmw6hRSN?=
 =?us-ascii?Q?nSbn0fu65SngQYfzdVdz+j1aw38mLeX3wQJqpBHCtZkj8tpNtzHF7bGRu7n1?=
 =?us-ascii?Q?qJt2m8R9d0xPRqvX85bfjtQNO8r3qG+5e5S++v+swMBlv6okkALC0OlcX4uV?=
 =?us-ascii?Q?1GoSxbC/rSvCWv5UKyaahiF3gdazUMKRAnOI0hOBCA61ifOxL92mgiDSnRvI?=
 =?us-ascii?Q?ilYvNUWLVOLXhboUn8zsORa6gDu78/GIU0ylsBAZMG3Tp1AQFm5OopuW8OA4?=
 =?us-ascii?Q?P2u8vjFjMXaksGtS63UL01Enu4CVPK3f/XQpXuM8h7phf3OPcoauyzIoovik?=
 =?us-ascii?Q?sILFgRUi2mjaISspcK8LXE3Md9r2UXpHSFq7MJ1HhuEX0fifZGO8Fh6eSgDZ?=
 =?us-ascii?Q?+jlJ24a2LdCkUuRCB6FtUEiF62uBMtHSR/a138UTtBgqcLVaqU8X5vAYClRg?=
 =?us-ascii?Q?YL6jnRcr6dvR/eZcq1HRTIbPARRDKhhhE7YIB8QRh4nWrgmQAAPUaiP9+lzb?=
 =?us-ascii?Q?b2/KxHwLKHjPtdN8ZUhJ9FZObKGNF8lAP65irv1BUj/fW4+PwRCOY+MhboDJ?=
 =?us-ascii?Q?NgARL82CeH5pun/ylXJHxe9bUgGisv+o+SIB2sSF8dnAw9LHa6gvZUnPCLn5?=
 =?us-ascii?Q?t7A3Bclelfrt4x+6PRGebbPc3SwQ8g5GGQfenWaiGf6GhV9Kh+77KRF9nxHG?=
 =?us-ascii?Q?e25XbLC2bYPail4CXXPQMP/vq/zcC6j2yolrGrjnYqSECGuWJwVh8RtiTdbQ?=
 =?us-ascii?Q?bkhvwz6Sv6RbsxNKOk93KAH84NG8DyeWYBm+Zz2RN+A+XiKrrQLwlw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR03MB7190.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sO0htWCqY/R74F9zSjGyn8y38iJkUsuYST5zc0diApfJHXGEyMZGWZ84OLT0?=
 =?us-ascii?Q?dnezOCwsujLgTXO/VKVeY0TEFuPAUGaDmvzJ9INUJpLGEB7waGS1hFfkfDCJ?=
 =?us-ascii?Q?vtGsZlZM0rZIJ+3M7DrBNpY4+AqtWKxehGEO1Zx4RNPuR4bqyGK0i/IWeM7+?=
 =?us-ascii?Q?77bSeC+DcVjMqZjqFHMdL7Za/qhttECUgAm08CXEgYhpsVgDlhDLgKm1tVY0?=
 =?us-ascii?Q?6o8w3wgcajLp/qkPWDzh7tRi7Mxk1h+jzjlVruJlUDG+ZaDXR6ZGOBwyc3r4?=
 =?us-ascii?Q?1+v3CRwtYVCM3FttNH88N+9puvLThZH6tplCHk0g1aPru0ZfePp/Vix8okG3?=
 =?us-ascii?Q?3D3Qw6W1Hz0PfKgvb8oSJUrkh/+7dSbUSfrB0bsW1qM/7K8NurKVxlTZB4Pt?=
 =?us-ascii?Q?i5ZDRs1mjRJpHhkM+09ggwqJX0jfMU8dLQVWWu7dNwzCzM2iW4y+PJqTP+wY?=
 =?us-ascii?Q?GxlHlIHqakxJ+ZikkphDPEvASx8t6/U8LWlynPmGsq7A3q+KiZvAKp1EUWuq?=
 =?us-ascii?Q?iS+hSuXi0Mb+0HtlXH7iDRuCp2g+33Z2VhFm3i/9E4zw9035flaHCH1hpnHA?=
 =?us-ascii?Q?5Qya6/kBWzlH3AxC8iKEclWa3Fk9+DsJ6QFCFbcSKzuU0XecVlyWAal1B62J?=
 =?us-ascii?Q?Gz7lxP0Wi4tpyu/XmfMDTbwzyKwG2hq0zg/61i6xp/f76/B5GaxZUIphNKn/?=
 =?us-ascii?Q?pwhX+SXtxrtOyW3agZft7+RFJNnRGGDhaT2fuEMXITLkzicrinyFSrx8WE38?=
 =?us-ascii?Q?Kch8eP6dt/OK5f81e60PpZWwoEUTgjSRCcvT5unDiMzfZ3Hs/3D52lhuL4oU?=
 =?us-ascii?Q?V/mByaYDkE8RGe/wqQevyuf2LV6As09Ol3+Imlp9qgKY3BNI4KNlrPSmnbG/?=
 =?us-ascii?Q?SblQegFP9aQiLhHIS6MfJUFpnRJS+EGa+XoB5dKWoAfwTbZTkaZpTtYoJK3u?=
 =?us-ascii?Q?BwnDYEJ6fsbt+juVsJpDiLJa91BWzJeVh8gfG0HPqGSmaN+eqOpN37+8q31s?=
 =?us-ascii?Q?Ydq6BmdivxPC+Eqjuvmzv5jM741s71ixNNDPJGDoNTS4tLD9ERH1E1cnUEbm?=
 =?us-ascii?Q?7lU8JHo9XDafDKOClmbbPO8msIbI5I3lS0nhJBalJZQzZkXiN9C6B75GVGjg?=
 =?us-ascii?Q?Jo62jgb6LiRacpuzVQMQCfcL2LUv8pRYhpCGgTnint6/Xt2qeBVwwZ7OrvtK?=
 =?us-ascii?Q?KMEL2EC1YkEQ0NsY/+eGlfeKKPUWVItQJNexNDTkZgzGwsCCtW7F0QxCH0Pj?=
 =?us-ascii?Q?bXPz7V/8Zr0GAj7MAoQI8mnHX4XLRhe2cOqWAVvKdIQ/hRzLbBdVTq16spCt?=
 =?us-ascii?Q?lcvsTGnhr1IspXoGjnZUrndpi9uSIl39CP9TOQCPEMcyEHS36G6j7Zh7jezB?=
 =?us-ascii?Q?iRvtiJ7kpGmsN3cVEqojjE9bke7w+bkHb9DaeQ3FpdWcQyvTe3JuXwSTXJEH?=
 =?us-ascii?Q?ZxvHc4g+5X1qxYkchlJF4vv1a5CqVhcNCc0WrLeYN7Gnxn1h2ZQfTgC5novh?=
 =?us-ascii?Q?72xb0JP+Tv+nDKbcstYPUpnMxswL9ZIVjsH11WgDFLj+6K4zVdfCdlU+9O7b?=
 =?us-ascii?Q?d+XktlTZ0peFL7jZXkXfLnLlz6JcnTS7m7IqcfW1hC0/LE5T0sGr93tf5SsB?=
 =?us-ascii?Q?nLCUpPhyd942HKk11pOOuOBuaKUM7FSL65GP11NQEXHq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR03MB7190.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20daf667-5660-4090-d46f-08de0c64f9a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 03:34:55.7688 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NoNz3vCgCB0t+WxKp0qylK17Hg504TaZ9wIh8LW59pEHLdRfHoxzFWYky6BDAJgjym30DXE1NdG3uN6qwod2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6164
X-Mailman-Approved-At: Thu, 16 Oct 2025 15:06:00 +0200
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


> What's the status of the related binding in the linux kernel?
>
Yup, it's already there,

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/spi/cdns%2Cxspi.yaml


Regards,
Boon Khai
Ng Boon Khai
