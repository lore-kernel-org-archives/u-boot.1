Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC1C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 12:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C41D81E25;
	Tue,  3 Jun 2025 14:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lI40Tf5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D74081E72; Tue,  3 Jun 2025 08:56:58 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64DE980F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 08:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acnHs0ve6iklY2W+uPhxr0mDD0gxtcrG1etHkskhkX7/wcB5hzho4cs10ir+/n6hG3VLEm9o+8yd2gx/mR50rqC6t5dJLn2wfzgyQmZAie4sSJduQPPN8AK2TcFa3cRSXfMFQ/imX8qYBwKOACULKyntexoLVUs2vUmhE52e3zEdrBw4DbbAXoV3vPHk9rxlgYgIOJVhayZLH3DhZwgcWwqJAEjwjFWrS7duf56Rc9+jB4bd00QthyuKgh1dx/C6iivbuKPAg1/6lvPb98R1znz7qKfrYI75ioLLESAV9nctv/CcWSHJL5qJfvG1xm+PWKVOp7LOqqA9wnJIqAVm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5ouLXkcHslnAsRULzTYq58y9knqUp85ktB6KgI/1fk=;
 b=C8opHB5W1PqbvL+ROLvuiBij3W1FKEZ0Epc9bs1WOlm3YKFrU1y+lHIjD808M1ZKKp3crcIPbTBlgZi4PLsk00aSPhd+QDGsaeMtxQDQ9PtADqcJUx6kM/TkiFFDmuHQpAri+J046Yj4GC1N/KstO720vYLygy/EnUjJO0ldGddB9bDJbz5OaqUsWBwxltqwIksEvXgQ5TXbIdyZVBXX5cPz39KOnnLqchdwwYxnSmVPM4kiRbrmrbSEWwnss0t4MxX0dcezCeCT2vDNRlg32VqXP9ybBRb3TcSfd9pqaQSUn0n1v+KNNZG0QSkesMStGgLIqX9FhMu28KZAmt9HoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5ouLXkcHslnAsRULzTYq58y9knqUp85ktB6KgI/1fk=;
 b=lI40Tf5FdsF7Kgnm23PzP2XIGqkZdiS9Y/V8rnJ2mKdVNJLpzTM11W9XdXAydb8nS3HWiq9cFB2saK3U9Obwr6WCL9WmF5LogMCYZNbX2QUDfK2e6aFiU9/3oc97yDxFhBTk470f7faGfdF0he91gZ+KsuuBSXG7cI1fw0nEZXfxOMbSubQ5ZJxM/4TO8/AUoxQSQmtG6xjm2e3e2ZdxBqEGTH0mvf9dkOtTlL9IRkEFg7sVTx6Wgt3FHHdyqulydMhfxgnaUm0APpr/iHgDkFO9wr1ha4UU4vp0zR6Xe+816ozNcs3DrzNMJOCOfpBbQPy9P/sv9aPVWBMRtlIi/w==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BLAPR03MB5601.namprd03.prod.outlook.com (2603:10b6:208:293::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 06:56:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 06:56:51 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v5 00/12] Add Synopsys MIPI I3C Driver support
Thread-Topic: [PATCH v5 00/12] Add Synopsys MIPI I3C Driver support
Thread-Index: AQHbw/CSN284PFykdUGl0oG8ydVDwbPxIMmw
Date: Tue, 3 Jun 2025 06:56:51 +0000
Message-ID: <PH7PR03MB69428AC3ADC4EF7381A11678F76DA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250513101913.30880-1-dinesh.maniyam@altera.com>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|BLAPR03MB5601:EE_
x-ms-office365-filtering-correlation-id: 470e83fd-1088-452c-68c7-08dda26bd186
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|10070799003|376014|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?a5V2iFv34nSk5c7SbF4i2EaSwcvbKt1mwZs1Hx3AJcuB1t0oVinIUH1EVu2V?=
 =?us-ascii?Q?c7nb7f0TR0oLeo3Bf/HgnMZk4HVLanxSGo2R61oVB0dIFenvt8nW2nMxUy+u?=
 =?us-ascii?Q?Yed00zshHrLWIOfDWbKuRvAzDYjTYDtLocW41x8mpEKCxVvKeIqBBFrwYLm3?=
 =?us-ascii?Q?eRNpyaZkMTl2AkZkfpDlA/iQpWMpUhT9rjEhCYAHyeLRdCNiY1WT6HwPpi3q?=
 =?us-ascii?Q?ff8DIUSsXMT1lM1PftHhPmajhjA9jRiEQ4bbPzQexe+gKhAFnsCHp6/UHl2D?=
 =?us-ascii?Q?df+CvzrsCBmNUqzv9j4A7h6uhAonvbfivAPbNgN+ZH06i6RjzmG8GVRfiQnh?=
 =?us-ascii?Q?jHpYwsROl4lS20qHkMwPkZvk9GJEr0X/YjoTMH8O+rPENDxB0/0lWWrDC0c0?=
 =?us-ascii?Q?9U5+/73SQ9tM2rKGZpu9G1aBPiZ3znPSXSiqGC4bMA46aUXogkIR6zzVdYl5?=
 =?us-ascii?Q?+rzGXh7qEWZp7i2UVgKeL1eCysVSZaVpB9FBRf5oy1kuoXc49BIKjT4HDCxH?=
 =?us-ascii?Q?Jrz9lK2l99pSMhaVyXXnpnrudstiih/5Abt6JvnQcZYNi6mUMwoA1nJo0WL5?=
 =?us-ascii?Q?AMWf2UQx4t+MU64B65yiqcsQ0g6O1nkD+ybzav9WbvSxU/ZXr2Unyz5gxVQd?=
 =?us-ascii?Q?UVSerzmhlRowOPWEUt0k3xgtXVDnG4nClN6Pfofd0X2roVmtqqApIsJjGeuo?=
 =?us-ascii?Q?mU/XEyWjGSUe3zXilM5+FPLptqmj5UnnDKaf2/1vKki+qvOYFFyzENBHfMAn?=
 =?us-ascii?Q?yzXnT+efIdRO6dRE553UuEmYrwBbjuSW7ZRznBJNS6ZfKoLU/BYQxb5E01yG?=
 =?us-ascii?Q?nWuaMXj1qjL1e3wI3v8L+pDhBWYqiqPY/RCLx6u0OTABRzKeOx4htSmGMDhM?=
 =?us-ascii?Q?6K4RB0dCtc7sbJ5E6kyoRfLHDgtw8fQlQgE1738KbA0vtf0oia28Qxf4XhW+?=
 =?us-ascii?Q?yr1iqaTA2ThGpPiasJj+mDvfPIsqHnJ4WMt8JSWO8LQ5beYua1gORN58vZMB?=
 =?us-ascii?Q?U+M68NyWeqhVDn2x5GhJ9DAT1sw6VI7KySb/kqgFzMVL/pHlkWMsIA679Qw1?=
 =?us-ascii?Q?jSZ1rZdXrltYqgVWC9uTfd6CYkh3g4X/i9GnTD2/ojSLgW6cOS8AVIKWu45v?=
 =?us-ascii?Q?/NxkbjfcDWI9pzVxzP29Tam8eRQYgRw6Iqitm3tytuJbGJXT+XdwDh0J2uQY?=
 =?us-ascii?Q?tN5ZnP0tiTTcrilr4WU9qg8HQ3NrWmQ4XlJCgkrBjmDgApMsBgRvHn5MekCi?=
 =?us-ascii?Q?jk8CUmr8vjmEZua1Gqvc8Ew4Ud/VN+985rSKkmhQYyZyhzlFVGRNdQrIbIuT?=
 =?us-ascii?Q?GqCfe3A9a0N/n1WeasRRL8uNIdzv1AoqOlyWTeaX0aZutRVTV5CaxdtH/RuV?=
 =?us-ascii?Q?lWUhszZj8WHESB1cWb58d5P4ggdIiwVVgC0+a6K48cLVGp9CB4g0HOGkOHx4?=
 =?us-ascii?Q?XfXvJ6jZcMlcEAMvEOQbZUgxOssCoEty1mMlOp0XtJRHeIsDEqQp3zRxp1zh?=
 =?us-ascii?Q?1aWMBlCCnfrel2Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(10070799003)(376014)(1800799024)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nq3nVABrEoNueQX1luoPW639jekhNd6rD3CHmZS6St2OjOwam6M+zUFo1uHq?=
 =?us-ascii?Q?p7qe4TprzctXsmOw04lRJj8W84VMRTzTAVC4CzqJUyvncwH63IylrFq3bdil?=
 =?us-ascii?Q?AJWgmZz4oPRFkJr+mDejxwv8wTSRomZA2u3fPL0eCVssr+ugpaTyIidCi1/+?=
 =?us-ascii?Q?5mu+F7yMxSoYVOEde3RsKRfhkIHKbiuKauYLvCuRnIoRDOuguTKuilzastEu?=
 =?us-ascii?Q?wb4vd16BNZzbPRaE96la3oZ0r4F0n4XDYdmnilvNqoRT5hbhAA7E6c7dFq1R?=
 =?us-ascii?Q?31/0sVenZysviqXIdO/w2Unr3ZD6GDftSPq3WXadsaAt0R+cKbm4ceUooJln?=
 =?us-ascii?Q?OBOmzrn9lUGTYOcnT031y/930+AMIyOphq+k9VK2om6EGrX3Nc3bYZlbdw5p?=
 =?us-ascii?Q?ch2ukrbhXpPFpBdSMR/07XvHPetcoowNlZxHFSTClZGVjg6kUFO5hm3H+nBz?=
 =?us-ascii?Q?lK6G6euN3df/Gtfl79Uk4kLTsKo87aWdTNg3koOnftDBWIq9/C0+1b+PUyLq?=
 =?us-ascii?Q?VDG9c3+M+ZALjc+th3FfgedfKuwoT3bWw7PXAOgX8nx+nb404LgNyQkt9TOp?=
 =?us-ascii?Q?/M/8waIjWKyGWzgliven8I4O8uTLUswYxG+7C1Prxb4FoJp2prpek3dwX8dQ?=
 =?us-ascii?Q?1npSXaVjr/YI4k3wpDFsr16g+FFIc4m+ven2XamBe+NwpYYA7PQCW/PMrE0m?=
 =?us-ascii?Q?tshr/JmRbzUdMnAW0mp4Azux9nUyYvL7YOfskc/OgtrfIcFAnRjZaicOoKwL?=
 =?us-ascii?Q?ynzfYZPFzRbmwFPbxknWe+hlmop+P1bjmolp4PDxRa8y680PygxvyBh8urss?=
 =?us-ascii?Q?vx8E6FenB5MsgIGtUuxjauAsC7spl7jzoIrkcIvd0CMlFUELsnVsgD/OzHbR?=
 =?us-ascii?Q?Sr6ViCwwDQmAkZ+OPBf+ugBE/XNj0f2agg1U4Hu0mCFXLimOmCZfLMpEWk60?=
 =?us-ascii?Q?NPN6l4uRi+xVt4PDhg5tsixAxfrrrZqyqbdau3FyulIZ/Ou0i88ohrhMQIiM?=
 =?us-ascii?Q?kA4oxCzr9GHwi+BqrtRKSqVn0wttTlK/Z/viQ1k0Bth/NeG/QamK2zmYHa1w?=
 =?us-ascii?Q?qbn8+HsSbLboJyVIDvgVnsa98XzBKfzIlE5XM/1ARSnMZuLlU2/ebETR63GK?=
 =?us-ascii?Q?r843dicCWGOGZ+iUSaJy+oe9mjvby5CfZwCmHpadztaHAXvarvkery9+uOa+?=
 =?us-ascii?Q?KvASFDYJfnUz6bKPDRZ2ETQCAFyPw+O3meOFaHGVsj7Jcqo58kiPXwoj6sYe?=
 =?us-ascii?Q?v++uOzaFwz32nKLlQTdJ2Rao/ObfEBL2Wpa5Opgdio+uwS7I9JWQGMRT8yWS?=
 =?us-ascii?Q?2gg/jlB0fz+7/o+HsHygTEAd95d89QuljotuBMg3uhJ48r3fMnooH+iew5E5?=
 =?us-ascii?Q?9QWrAtHrvnCewynrMSVxOvHKJ9I3VZfPyrx1ESHMgqBcfYtDK3+2O2FfXraa?=
 =?us-ascii?Q?UZI3ywMViUwkQL2hdBkkES9fGb3ptUsZWlO4XDNJGpTjvqQbiPH83bTAd5+n?=
 =?us-ascii?Q?DY5V2NGGWIl9ooKyKV1wNvxHq0rPDsUD9d8bWt71vgL74Iptx5aug1pYTL7u?=
 =?us-ascii?Q?q2Ffh8QohuQQAZvG1EeiCrpYMY43Oy+m89gLuR5wclRkf9kLGBQ3X/BUR1vC?=
 =?us-ascii?Q?uvi7qN1GbVT9+IwH+vhvKk9NHklFGkiQ0Tlen4a2W0hQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470e83fd-1088-452c-68c7-08dda26bd186
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 06:56:51.6692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01VQUbuv++/pcC73NFtfRt2WDfB9It2XdlL8ZT2DpfhzbskT/wJ/4zRvJ8Ydx6zAfREYcRSTR952Fo8Rr7jEwpc8yuvlPd8zX/yaAmxnLP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5601
X-Mailman-Approved-At: Tue, 03 Jun 2025 14:28:11 +0200
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
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Tuesday, 13 May 2025 6:19 pm
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad
> Hazim Izzat <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v5 00/12] Add Synopsys MIPI I3C Driver support
>=20
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> This patchset add Synopsys MIPI I3C Driver support for Intel Agilex5 devi=
ces.
>=20
> The i3c driver is leveraged from the master/dw-i3c-master.c, i3c/device.c=
 and
> i3c/master.c Linux version 6.6.37 LTS And few header files included to be=
 part of
> the migration; i3c/internals.h, include/linux/i3c/ccc.h, include/linux/i3=
c/device.h
> and include/linux/i3c/master.h.
> Additional i3c uclass driver and command files added to support i3c read =
and
> write in U-Boot.
>=20
> Patch status:
>=20
> Detail changelog can find in commit message.
>=20
> v5->v4:
> --------
> - Add header file to doc/api/i3c
> - Rephrase function description for i3c.h
> - Separated subcommand as a function for cmd/i3c.c
> - Used memory address to transfer msgs from i3c
> - Rephrase description in cmd/i3c.rst file
> - Replaced int with unsigned for positive variables.
>=20
> v4->v3:
> --------
> Resolve ci test:
> - Add i3c node in index.rst
> - Formating error in i3c.rst
> - Resolve cpu_relax undefined for sandbox
>=20
> v3->v2:
> --------
> - Squash commit 10 to commit 9
> - Resolve index for new files to pass the checkpatch
>=20
> Commit: sandbox_defconfig: Enable configs for sandbox i3c
> Commit: agilex5_defconfig: Enable i3c configs for agilex5
> - use savedefconfig
>=20
> drivers: Enabled Kconfig and Makefile for i3c support
> - Add maintainer for i3c
>=20
> drivers: i3c: Enabled Kconfig and Makefile for DWI3C
> - Add empty lines for if/endif
>=20
> drivers: i3c: Add i3c sandbox simple test.
> - Removed DECLARE_GLOBAL_DATA_PTR
>=20
> v1->v2:
> --------
> Reorder commits.
>=20
> Added commits:
> - drivers: i3c: Add i3c sandbox simple test.
> - test: cmd: Add simple test for i3c
> - configs: sandbox_defconfig: Enable configs for sandbox i3c
> - configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
> History:
> --------
> [v1]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250218025705.50051-1-
> dinesh.maniyam@intel.com/
> [v2]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250314040902.43621-1-
> dinesh.maniyam@altera.com/
> [v3]:
> https://patchwork.ozlabs.org/project/uboot/cover/20250324083704.26259-1-
> dinesh.maniyam@altera.com/
> [v4]: https://patchwork.ozlabs.org/project/uboot/cover/20250417021840.621=
2-
> 1-dinesh.maniyam@altera.com/
>=20
> Dinesh Maniyam (12):
>   drivers: i3c: Add new i3c uclass id
>   drivers: i3c: Add driver for MIPI DWI3C
>   drivers: i3c: Add i3c uclass driver.
>   drivers: Enabled Kconfig and Makefile for i3c support
>   drivers: i3c: Enabled Kconfig and Makefile for DWI3C
>   drivers: i3c: Add i3c sandbox simple test.
>   drivers: i3c: master: Enable probe i3c without slave device
>   i3c: master: dw-i3c-master: Fix OD_TIMING for spike filter
>   cmd: Add i3c command support.
>   test: cmd: Add simple test for i3c
>   configs: sandbox_defconfig: Enable configs for sandbox i3c
>   configs: agilex5_defconfig: Enable i3c configs for agilex5
>=20
>  MAINTAINERS                        |    7 +
>  arch/sandbox/dts/test.dts          |    8 +
>  cmd/Kconfig                        |    6 +
>  cmd/Makefile                       |    1 +
>  cmd/i3c.c                          |  261 ++++
>  configs/sandbox_defconfig          |    4 +
>  configs/socfpga_agilex5_defconfig  |    3 +
>  doc/api/i3c.rst                    |    8 +
>  doc/api/index.rst                  |    1 +
>  doc/usage/cmd/i3c.rst              |  146 ++
>  doc/usage/index.rst                |    1 +
>  drivers/Kconfig                    |    2 +
>  drivers/Makefile                   |    1 +
>  drivers/i3c/Kconfig                |   27 +
>  drivers/i3c/Makefile               |    5 +
>  drivers/i3c/device.c               |  262 ++++
>  drivers/i3c/i3c-uclass.c           |   38 +
>  drivers/i3c/internals.h            |   26 +
>  drivers/i3c/master.c               | 2070 ++++++++++++++++++++++++++++
>  drivers/i3c/master/Kconfig         |   11 +
>  drivers/i3c/master/Makefile        |    3 +
>  drivers/i3c/master/dw-i3c-master.c | 1062 ++++++++++++++
>  drivers/i3c/sandbox_i3c.c          |   56 +
>  include/dm/device.h                |    2 +
>  include/dm/uclass-id.h             |    1 +
>  include/dw-i3c.h                   |  252 ++++
>  include/i3c.h                      |   93 ++
>  include/linux/i3c/ccc.h            |  385 ++++++
>  include/linux/i3c/device.h         |  286 ++++
>  include/linux/i3c/master.h         |  698 ++++++++++
>  test/cmd/Makefile                  |    1 +
>  test/cmd/i3c.c                     |   50 +
>  test/dm/Makefile                   |    1 +
>  test/dm/i3c.c                      |   34 +
>  34 files changed, 5812 insertions(+)
>  create mode 100644 cmd/i3c.c
>  create mode 100644 doc/api/i3c.rst
>  create mode 100644 doc/usage/cmd/i3c.rst  create mode 100644
> drivers/i3c/Kconfig  create mode 100644 drivers/i3c/Makefile  create mode
> 100644 drivers/i3c/device.c  create mode 100644 drivers/i3c/i3c-uclass.c =
 create
> mode 100644 drivers/i3c/internals.h  create mode 100644 drivers/i3c/maste=
r.c
> create mode 100644 drivers/i3c/master/Kconfig  create mode 100644
> drivers/i3c/master/Makefile  create mode 100644 drivers/i3c/master/dw-i3c=
-
> master.c
>  create mode 100644 drivers/i3c/sandbox_i3c.c  create mode 100644
> include/dw-i3c.h  create mode 100644 include/i3c.h  create mode 100644
> include/linux/i3c/ccc.h  create mode 100644 include/linux/i3c/device.h  c=
reate
> mode 100644 include/linux/i3c/master.h  create mode 100644 test/cmd/i3c.c
> create mode 100644 test/dm/i3c.c
>=20
> --
> 2.26.2

Hi,

I have reworked the commits based on the previous comments and suggestions.
Please help to review the commits.

Thanks for your time.

Dinesh
