Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C608C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 05:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C84480A46;
	Wed, 19 Feb 2025 06:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vKnrsQPM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0CF80F18; Wed, 19 Feb 2025 03:46:53 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C430809A4
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oI2r+nSDTX5j02LewW4cGqMEom2b6gusWaRChKzCVILkSd2pkBU8OGd45MaGwym/rKlOPMQeN+BLMe3VY4dWFUR4Y9HqsqvTGLylQ10mt8aMqPOpSwh50VVmjI9aRfs2mI2mp+i/oJfQ+/mwZohsMIkz9mz6nJELZl6xZFaBbfiRRKbZRg/bvcWbRD8yabK0gE83FQ96nM7p9dqABEHGG7gUqUuhj2t5NHESL8vhRn3DCPO8vhcZKyHuPyidPT77+YrinftAsI716zN2A85gVVN8a/BKjD6u+1TdJAWiU6R4ShE9Upnlvt0KaDNz6uVN/9r4oi8ckuH1u1esf5d0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8ApnekhncNVS1iHFXYe6iCkj5WOPiQKI31WRCJaJt8=;
 b=ZKzg+IVeyqZYq+V6a6DIkwVSVGytxEB298L5LIQpEZ+WKcP713R4tyROYY2ST3btuJr3wPcAT8Azjl/GrQ+iaz0XnmXIMQwBCI1O8pFmmAQ8HZRZaKcac5/Yrm0QsecsTm5Pje49LfS7LtRTWr1t6lOKdOwtKdYtP1EYSc0kYkT7yT5OTgRVzzQd5N6HZdAsM2lor8QEvWaISz0fsoTG1zFodeX9r7dhmrMU/ELCvU/wGBCVOt0PywIio5VgKwgaMR7ToCxuGbaHxT0V1hmTCmY9cpSBvXsgSjdcqqlQbErK5HEtMHNTw69hfvGfm6+kUr1/5nhRyCQya1aiPZp5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8ApnekhncNVS1iHFXYe6iCkj5WOPiQKI31WRCJaJt8=;
 b=vKnrsQPMDt3pmjPgGAW558Y829YhBwke6j2tY48YxFFIxvlQTk7CosnH1eTfP2iPm84ant9FvXNpKyr3/pBsB1z4Si0D8enQtMCTqMwTrMVnmclC6AJWyWs9BT34Quprw1quLXFXW8Brl1pEYkvx16uN3rEaprp/paqxJiFxjX0DbganYaVZP3Iun0WjsdQ/dONsiPXM8m4RoHmaMRY3Ux62lkfM1tJ8jbi+0sF1XJDvZI19/ZbRnyk7Ln1Cr9ciKFCSvDfxI8ofysLO3ckVnKgtAIhr+1o/QCgzxwikTDK8UK1bdqmZQKuu9GxVWQOjf8KuCIPIW6D14tz3nvjhvA==
Received: from BN7PR03MB4387.namprd03.prod.outlook.com (2603:10b6:408:3b::30)
 by BY5PR03MB5218.namprd03.prod.outlook.com (2603:10b6:a03:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 02:46:43 +0000
Received: from BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874]) by BN7PR03MB4387.namprd03.prod.outlook.com
 ([fe80::35a4:cfc4:3214:874%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 02:46:43 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Frank Li <Frank.li@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, Wang Jie
 <dave.wang@rock-chips.com>, "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@intel.com>, "Ng, Boon Khai" <Boon.Khai.Ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>, "Zamri, Muhammad
 Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>, "Lim, Jit Loon"
 <jit.loon.lim@intel.com>, "Tang, Sieu Mun" <Sieu.Mun.Tang@intel.com>
Subject: RE: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Thread-Topic: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Thread-Index: AQHbgbDbNNz6e3ZDUkKfFBKSL5OqUbNNP7aAgACsO7A=
Date: Wed, 19 Feb 2025 02:46:43 +0000
Message-ID: <BN7PR03MB4387BDAB4D759CFDCEC5D231F7C52@BN7PR03MB4387.namprd03.prod.outlook.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-2-dinesh.maniyam@intel.com>
 <Z7S0LcUSb5y8Nr4u@lizhi-Precision-Tower-5810>
In-Reply-To: <Z7S0LcUSb5y8Nr4u@lizhi-Precision-Tower-5810>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR03MB4387:EE_|BY5PR03MB5218:EE_
x-ms-office365-filtering-correlation-id: 75a259c4-bb48-48cf-f422-08dd508fa4d4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Lmzj9zcsW2gZb4tcQjrBC2f9abbMcGzz2g48dUaS2bMGCFl7MZP300NQcd81?=
 =?us-ascii?Q?L3AuhUuqhRAgkMSLdPTpCFJRnASCu/13EMEAW3uWwu1cQJovyinmQZa/4JJp?=
 =?us-ascii?Q?kiq97UtEYVPfFPkuW8vRNUD8906ed6/KIHaZqSZ+4gKU+baTgdue29BUrXvz?=
 =?us-ascii?Q?Adc5UrWCcoTgTwR8C0C2OLLmPxt7XZXh9R0ZgXDy4xOl4/mqaGmgGKzTcG1L?=
 =?us-ascii?Q?e5xbWC5eXxzTgjKh8ne+8/A9MsaTud0aP+V58Q8Qx4Rni7olaiIdE+18gBnB?=
 =?us-ascii?Q?mG6dJ8Se3CzHlsQs9yWG/USrv8bdDjLe432n2RTtv4+pg8v8vhIdiPu6WxQt?=
 =?us-ascii?Q?A/hs+xjcZwDg79wewSMAGDok0c6x22TGTVh0hfsQ1efMrey0A48+dTEtDODx?=
 =?us-ascii?Q?D32PmcfHG5AKByjL1cww6RKqlogGs0R2edxEJPHZcbynN522fcREyMfFPJIW?=
 =?us-ascii?Q?dq1p3jfquVI0EH7cMN7CwFhAdnAromLVKe0/bJpUJykteH3747H9zd/+89lB?=
 =?us-ascii?Q?Moq+eWv9OjEUZFRRpzjn0nUJzGOY9iJppGhNTXjFf1623j2HnkOgMfJDy3gO?=
 =?us-ascii?Q?h9hIcG85f7q1zf5SxWjJHbisduQnjspiJ5WIaYS/SJBrzURHdFYrRK/iHZ2U?=
 =?us-ascii?Q?rGD2XCcCPhTangm9GplKpISezAla31ZhzVDdOfQISBZptgLTARg2B6sbUP7T?=
 =?us-ascii?Q?JzSwCnb7AZxmjkI7y07NYVmWDFUJu7hknD3Mi7aiA5IorVNY+cS6SoRXQO3y?=
 =?us-ascii?Q?zIHEjPRiwirKYyV6VFaRtW4B8phuayioEBduvRNws3Z2GNOv/tGmSQ/jEBDl?=
 =?us-ascii?Q?XTDH2e5bgI08zKW9Z3vR2Tk3wOcY4mvk4AShTe8vmtgs6WBBiPEq61hHjQvL?=
 =?us-ascii?Q?IDtR+xGmEF2SlF8FT7fQfeud5SxZe5nPRg3habm6b6t1NZqL4BXsl4hm+nih?=
 =?us-ascii?Q?GkoPzTRAnx5sEQJXHKvCjKDod+g9vHvTrzgKN/86+8vSd6RQwnJlNP9txJ57?=
 =?us-ascii?Q?Z48OvY3j48gvoXaJoRlMinz/6Yc7W1iMOylIrrfbPZ8sEJ0PtmlCRBeEAfI2?=
 =?us-ascii?Q?f3JxbptqWcd9VZOa7nw5uh0hp0igOQjjykoGnY2/qNYJr4ujwVe33aSkcMPw?=
 =?us-ascii?Q?rDcx2wYz1IOU+1bXfQ6z8YJoXouPysdfzbOWA17XF6vss4a+Uf0JAyLjVrRX?=
 =?us-ascii?Q?t6y5mX63m4XCGIxhsBZLWQ65brE/9Z8gDMSfkZJtlLJPLmi+jBUc2UEoKpUH?=
 =?us-ascii?Q?5Pdiep2Q7LbWp+bnUJtTjjmwZjblMnOJ4FOWM9eh9X6h41OZeJXlt55aX8ao?=
 =?us-ascii?Q?J9fb8WL+Iade2wODsuUZ23RgI3HXMGVvLBXUnjNcuLnNfkd23+WdiClgpOYG?=
 =?us-ascii?Q?wS7D76N/t36P/3zAbFgRi51BB63P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR03MB4387.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ps1q8S9RuTb9balItamSgKqtuDvPgaxHtg1VsQ6EPc2bTGvi8CF42JP71cVu?=
 =?us-ascii?Q?zzQeEJyP6Xn4rlMq0JP54E+J/z3K/SfnkNrfb+2qrXNzJCWe8azuaA1UvTZk?=
 =?us-ascii?Q?EVWDeYV0kRHDP0XGmkaXo5z9Bfjdv+wGC04cxXr4u50IsTv7HjKgf6u5mZZq?=
 =?us-ascii?Q?Nqf6o1d9USDz1eD1cuVNnPvEGE/aR4+yUH+6rBFHF+JZj7hLmZ3Y5i0SIz4a?=
 =?us-ascii?Q?IIIBJ7L1SgTXGxgC/A5ib1ShWBccB4ZwnNuUsDZCtH/zCA03mVc4WVs+4rek?=
 =?us-ascii?Q?rBkVvT5YvO69Xcye+AcU5ZG3DNcboeiHkp5Iin0Y22NsGLQmAGQJMYJNfW68?=
 =?us-ascii?Q?Tp7lrMgZzFKG1Y3JtAq9zs2iGr5lUko5x4hchABUOBTNAFgTKephSBmLWjxR?=
 =?us-ascii?Q?Jwf9yUrhumDhm0oSMq116hyv6kWBylKBZN2A9zBp0AVKNl3qPbZogaElogVe?=
 =?us-ascii?Q?L6Pr7d1YLBpQk3E/aGnJU7t2lQg1y/7PSWpCqWxAI3EHPTIwunO/iXDh6vAY?=
 =?us-ascii?Q?H5kyoneQdmgUBuXD3HGI9VsmneVeP3Mvlt+unVFl7IXy7Qejj6xS1yVrcbp4?=
 =?us-ascii?Q?Oxu69SnJlCIdCeIr8GnkhYc0q0GLVi6OTEBmBkoahoZ92d2dhh/DtUTwuZn0?=
 =?us-ascii?Q?S5zoMo9sK+BncMpPuZYIkEe6P27tvs5A7hnsNLt5iGJrT2JJ6ebqEYmpv90W?=
 =?us-ascii?Q?Ah+c2QsJ+sES2Zqx3pBVcWRHaF7xO22nk1LDcdBNsE9xsnaUauWUSjYq+8XF?=
 =?us-ascii?Q?xnVEFvc8g5rIy7IfZyt+MwFrV4b07xSyYp5c2hUHk4NXoftJVBOdpmRlXL+H?=
 =?us-ascii?Q?DLhZ+MdxoqqDUPklTnhb0vxJ6RnoGqMdyPDZxcThStTDolZZ6u/ql4lEPVMs?=
 =?us-ascii?Q?+EKnwRM7jauzImaevg7OEaLEQC32BKkedurH6Uyeu52aV2L0HAJ3KfaH/C2f?=
 =?us-ascii?Q?iH6rv6S+pVrL1GGoF5X9eSobrBdQrgeZgKplqQGT1XZ7gc22niFptHvhZyUz?=
 =?us-ascii?Q?4mDaCqp7pzFM3phCyms+ovkf5izgPkbXb+V9m1LBvtVo2gg3//blCucH6D27?=
 =?us-ascii?Q?K17JjJRwnskbm0pxMgLcFDm8wcYAyQVrBF8SmKRHtPxSApPCeV+2bbHusI2V?=
 =?us-ascii?Q?h1RRby0KKfMnaHsB8cNQor/FL5stPih1jyQwuAZl2o4KBjEl5scpex4u16gA?=
 =?us-ascii?Q?+FhBTTPy8js6bM/D8zdVVndTTDZcWZMPZ4JBNxJP3JKxV1toOHOasKkpdwQo?=
 =?us-ascii?Q?XVWdOTpg5xDy+GrBDvLihFra0CZpRirxUYkSyq6CEZvgMkjU+y0vz5OluNfO?=
 =?us-ascii?Q?44/Zc8yf5RPbLLaRUBNfymWWqcgMfJctr6SJH9NoZqgRGWWgI43k+aeJl6Jc?=
 =?us-ascii?Q?+L+iLRz1aVNtsM0iK/ZXwmWjJ0vbaArE7L9IGlCoi+hj2G6772/AbmgUI4+7?=
 =?us-ascii?Q?CTe2EVgTPlmZXu5jTUiQYMAyAnBbKzmjitLYeKHBbejSPEzq92R/WqC6Wc3A?=
 =?us-ascii?Q?nWt10XLE+Ilg+YDnfq842Xv3djt1YPLx0RmY2XvnyOwLT8llBlgcHHfvP/BN?=
 =?us-ascii?Q?HgU0U5NDvUS6fpa1IP34KOyCSJWPunzzOAERcdKir5mYz/kGncrXQUGT2TjO?=
 =?us-ascii?Q?D9k6aXIltH9yVHXkn2Wk/LvFFAVqUwD1talH4uALkoBV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4387.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a259c4-bb48-48cf-f422-08dd508fa4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 02:46:43.2280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MpjULytG0czKR498VmmfDN2dIHRr7CrF0Aap50U40a6dJ/YrfSSrcay55VGejxU/PfyhrlCtNcvdRAymiaSOPNUTsNCvQduIHy8itWmc7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5218
X-Mailman-Approved-At: Wed, 19 Feb 2025 06:42:54 +0100
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
> From: Frank Li <Frank.li@nxp.com>
> Sent: Wednesday, 19 February 2025 12:24 am
> To: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Tom Ri=
ni
> <trini@konsulko.com>; Ilias Apalodimas <ilias.apalodimas@linaro.org>; Hei=
nrich
> Schuchardt <xypron.glpk@gmx.de>; Jerome Forissier
> <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Wang Jie <dave.wang@rock-
> chips.com>; Meng, Tingting <tingting.meng@intel.com>; Chee, Tien Fong
> <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>; Ng,
> Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> Subject: Re: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence =
I3C
> controller
>=20
> On Tue, Feb 18, 2025 at 10:56:56AM +0800, dinesh.maniyam@intel.com wrote:
> > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > Add a YAML device tree binding schema for the Cadence I3C controller,
>=20
> Cadence or snps? compatible string said snps.
>=20
> > defining required and optional properties for proper integration and
> > validation with dt-schema.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > ---
> >  .../i3c/cdns,i3c-master.yaml                  |  51 +++++
> >  doc/device-tree-bindings/i3c/i3c.yaml         | 186 ++++++++++++++++++
> >  2 files changed, 237 insertions(+)
> >  create mode 100644 doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
>=20
> file name should be one of compatible string.
>=20
> >  create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml
>=20
> Where doc/device-tree-bindings/i3c?
>=20
> in kernel, and already have i3c.yaml
> Documentation/devicetree/bindings/i3c/
>=20
> stop here, fix file path firsly.
>=20
> Frank
> >
> > diff --git a/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> > b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> > new file mode 100644
> > index 0000000000..0eda16482e
> > --- /dev/null
> > +++ b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i3c/cdns,i3c-master.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cadence I3C master block
>=20
> Snps?
>=20
> > +
> > +maintainers:
> > +  - Dinesh Maniyam <dinesh.maniyam@intel.com>
> > +
> > +allOf:
> > +  - $ref: i3c.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: snps,dw-i3c-master-1.00a
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    i3c-master@2000 {
> > +        compatible =3D "snps,dw-i3c-master-1.00a";
> > +        reg =3D <0x02000 0x1000>;
> > +        interrupts =3D <0>;
> > +        clocks =3D <&i3cclk>;
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <0>;
> > +
> > +        eeprom@57{
> > +            compatible =3D "atmel,24c01";
> > +            reg =3D <0x57 0x0 0x10>;
>=20
> please use macro in include/dt-bindings/i3c/i3c.h
>=20
> > +            pagesize =3D <0x8>;
> > +        };
> > +    };
> > diff --git a/doc/device-tree-bindings/i3c/i3c.yaml
> > b/doc/device-tree-bindings/i3c/i3c.yaml
> > new file mode 100644
> > index 0000000000..8f9c440db2
> > --- /dev/null
> > +++ b/doc/device-tree-bindings/i3c/i3c.yaml
> > @@ -0,0 +1,186 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/i3c/i3c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: I3C bus
> > +
> > +maintainers:
> > +  - Dinesh Maniyam <dinesh.maniyam@intel.com>
> > +
> > +description: |
>=20
> Needn't |
>=20
> > +  I3C busses can be described with a node for the primary I3C
> > + controller device  and a set of child nodes for each I2C or I3C
> > + slave on the bus. Each of them  may, during the life of the bus, requ=
est
> mastership.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^i3c-master@[0-9a-f]+$"
> > +
> > +  "#address-cells":
> > +    const: 3
> > +    description: |
> > +      Each I2C device connected to the bus should be described in a su=
bnode.
> > +
> > +      All I3C devices are supposed to support DAA (Dynamic Address
> Assignment),
> > +      and are thus discoverable. So, by default, I3C devices do not ha=
ve to be
> > +      described in the device tree. This being said, one might want to=
 attach
> > +      extra resources to these devices, and those resources may have t=
o be
> > +      described in the device tree, which in turn means we have to des=
cribe
> > +      I3C devices.
> > +
> > +      Another use case for describing an I3C device in the device tree=
 is when
> > +      this I3C device has a static I2C address and we want to assign i=
t a
> > +      specific I3C dynamic address before the DAA takes place (so that=
 other
> > +      devices on the bus can't take this dynamic address).
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  i3c-scl-hz:
> > +    description: |
> > +      Frequency of the SCL signal used for I3C transfers. When undefin=
ed, the
> > +      default value should be 12.5MHz.
> > +
> > +      May not be supported by all controllers.
> > +
> > +  i2c-scl-hz:
> > +    description: |
> > +      Frequency of the SCL signal used for I2C transfers. When undefin=
ed, the
> > +      default should be to look at LVR (Legacy Virtual Register) value=
s of
> > +      I2C devices described in the device tree to determine the maximu=
m I2C
> > +      frequency.
> > +
> > +      May not be supported by all controllers.
> > +
> > +required:
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +patternProperties:
> > +  "@[0-9a-f]+$":
> > +    type: object
> > +    description: |
> > +      I2C child, should be named: <device-type>@<i2c-address>
> > +
> > +      All properties described in Documentation/devicetree/bindings/i2=
c/i2c.txt
> > +      are valid here, except the reg property whose content is changed=
.
> > +
> > +    properties:
> > +      compatible:
> > +        description:
> > +          Compatible of the I2C device.
> > +
> > +      reg:
> > +        items:
> > +          - items:
> > +              - description: |
> > +                  I2C address. 10 bit addressing is not supported. Dev=
ices with
> > +                  10-bit address can't be properly passed through DEFS=
LVS
> > +                  command.
> > +                minimum: 0
> > +                maximum: 0x7f
> > +              - const: 0
> > +              - description: |
> > +                  Shall encode the I3C LVR (Legacy Virtual Register):
> > +                    bit[31:8]: unused/ignored
> > +                    bit[7:5]: I2C device index. Possible values:
> > +                      * 0: I2C device has a 50 ns spike filter
> > +                      * 1: I2C device does not have a 50 ns spike filt=
er but
> > +                           supports high frequency on SCL
> > +                      * 2: I2C device does not have a 50 ns spike filt=
er and is
> > +                           not tolerant to high frequencies
> > +                      * 3-7: reserved
> > +                    bit[4]: tell whether the device operates in FM (Fa=
st Mode)
> > +                            or FM+ mode:
> > +                      * 0: FM+ mode
> > +                      * 1: FM mode
> > +                    bit[3:0]: device type
> > +                      * 0-15: reserved
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +
> > +  "@[0-9a-f]+,[0-9a-f]+$":
> > +    type: object
> > +    description: |
> > +      I3C child, should be named:
> > + <device-type>@<static-i2c-address>,<i3c-pid>
> > +
> > +    properties:
> > +      reg:
> > +        items:
> > +          - items:
> > +              - description: |
> > +                  Encodes the static I2C address. Should be 0 if the d=
evice does
> > +                  not have one (0 is not a valid I2C address).
> > +                minimum: 0
> > +                maximum: 0x7f
> > +              - description: |
> > +                  First half of the Provisional ID (following the PID
> > +                  definition provided by the I3C specification).
> > +
> > +                  Contains the manufacturer ID left-shifted by 1.
> > +              - description: |
> > +                  Second half of the Provisional ID (following the PID
> > +                  definition provided by the I3C specification).
> > +
> > +                  Contains the ORing of the part ID left-shifted by 16=
,
> > +                  the instance ID left-shifted by 12 and extra informa=
tion.
> > +
> > +      assigned-address:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        minimum: 0x1
> > +        maximum: 0xff
> > +        description: |
> > +          Dynamic address to be assigned to this device. In case stati=
c address is
> > +          present (first cell of the reg property !=3D 0), this addres=
s is assigned
> > +          through SETDASA. If static address is not present, this addr=
ess is assigned
> > +          through SETNEWDA after assigning a temporary address via ENT=
DAA.
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: true
> > +
> > +examples:
> > +  - |
> > +    i3c-master@d040000 {
> > +        compatible =3D "cdns,i3c-master";
> > +        clocks =3D <&coreclock>, <&i3csysclock>;
> > +        clock-names =3D "pclk", "sysclk";
> > +        interrupts =3D <3 0>;
> > +        reg =3D <0x0d040000 0x1000>;
> > +        #address-cells =3D <3>;
> > +        #size-cells =3D <0>;
> > +        i2c-scl-hz =3D <100000>;
> > +
> > +        /* I2C device. */
> > +        eeprom@57 {
> > +            compatible =3D "atmel,24c01";
> > +            reg =3D <0x57 0x0 0x10>;
> > +            pagesize =3D <0x8>;
> > +        };
> > +
> > +        /* I3C device with a static I2C address and assigned address. =
*/
> > +        thermal_sensor: sensor@68,39200144004 {
> > +            reg =3D <0x68 0x392 0x144004>;
> > +            assigned-address =3D <0xa>;
> > +        };
> > +
> > +        /* I3C device with only assigned address. */
> > +        pressure_sensor: sensor@0,39200124004 {
> > +            reg =3D <0x0 0x392 0x124000>;
> > +            assigned-address =3D <0xc>;
> > +        };
> > +
> > +        /*
> > +         * I3C device without a static I2C address but requiring
> > +         * resources described in the DT.
> > +         */
> > +        sensor@0,39200154004 {
> > +            reg =3D <0x0 0x392 0x154004>;
> > +            clocks =3D <&clock_provider 0>;
> > +        };
> > +    };
> > --
> > 2.26.2
> >

Will drop this commit, since the files in this commit are redundant.
Will make sure compatible string follow as per this yaml located in Documen=
tation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml

Regards
Dinesh
