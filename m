Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AEFF531EC
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 03:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3103E83B99;
	Tue, 14 Apr 2026 05:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ciwo1U/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 812D383BC4; Tue, 14 Apr 2026 05:34:12 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE79839D5
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejfF/YpiLtQfNgp0BlDMN2RAjAsHxwox0ujnBE7PZNWVJzA7VmXSN0HCQjofWNn52u0Py3qrSBzd/wmWZ8+imEG92ssOj/gFik9KEo0kJrnRQ63dHRJgK0DBXOf0yXmdrrFUgEcprRyIJln3PqW5YxOImzqntv5pVfOH2dGFt7Lt0kzdWn80ouTXVq/MLmLuO5RTDF1x634w/BuRAKm/fpnGH4rSUr/cIr7JF2NRnhw1K0T+Xwbz/vwDp6ir6+dot9rinBMCoVcCcwaedGvW7jxCWhhYgS4h/IOwICRIicFg5uaa3JHwKZ5KbFlTpr0SjKe7Pfj6JhLyPb1KPY/P2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHZ45+aIBbXvDAMlK+aP0DbAyFYN16KXDu5IA3QQaMM=;
 b=YShkhVoynOOvAPQ0WPZL+mvSfZUpEY5DA2kpc6e5oBJDHRQ8ofzjy2rUi91wMl3St0rBrHbeMu6+d75O3HMkMVfNVLxD/fCiGKPa8o0Z+IsvbFblQtJXDmDTk6uCX0aXTrLRfrH0zfK4r3yD+3AQqkedRbsuQ7ZlRykb6LKgfW1W3L3wiKWVfyqSGrWx8KPplPUNgaLQgk9VPmNWsgVQonOO91/qmqYm+6kBjQ1ayfRdAMWXfHHXHGxNd67a864Qw3q5vTwkEHpm7Qf5iJQbmJTHxDFs7xdXHdvmUg6fbnZacS/Ro0BGMrPIGp5yE/aBHLLdwXKCQnIr8/ntY6eR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHZ45+aIBbXvDAMlK+aP0DbAyFYN16KXDu5IA3QQaMM=;
 b=Ciwo1U/qBJX8ytIy2QUOrbK3ohFzEKnOKoWWity5plp+85tQME9HyYXkf8524dC7U5nziHvz0OUDwE+vRRyb7BWms6hsAZZ5VzDNlYQF/ZWsQwS5vwZqRXUD69DMzv/3LPNacsB+5l0JFRkVjx65vhlvErN1N4LzvnkZX05Qes2JPAkLplBPWlLOZJv4x0OnTMnk+9eE5syuj/rsxX9jpgX+HKrCy8capzFxDvz72vzMiL8e/e11Y5tcJTNQbs3d9gx8XWktvOaRanzLyNyfrRv6tgQ3vDYIhS7xfSAgI3lsGQ+/xW3pY7otr3QV0Xacva9xFG/QqBoHrfQgUa5Jxg==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DSWPR03MB989165.namprd03.prod.outlook.com (2603:10b6:8:362::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 03:34:07 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 03:34:07 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: U-boot Openlist <u-boot@lists.denx.de>, Chin-Liang See
 <chin.liang.see@intel.com>, Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut
 <marex@denx.de>, Naresh Kumar Ravulapalli
 <nareshkumar.ravulapalli@altera.com>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule tool
 build
Thread-Topic: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Thread-Index: AQHct5NhYEcwx8aNDU+9MkP3aZIY5LW13uOAgAAmm8qAAAK/gIAc1DJ0gAq7HwCAAHgxbg==
Date: Tue, 14 Apr 2026 03:34:07 +0000
Message-ID: <SA3PR03MB718767C602268BA968642A71B4252@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
 <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260319161609.GU502704@bill-the-cat>
 <SA3PR03MB71873A4FC785BA33DA3FA714B45AA@SA3PR03MB7187.namprd03.prod.outlook.com>
 <20260413202314.GH41863@bill-the-cat>
In-Reply-To: <20260413202314.GH41863@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|DSWPR03MB989165:EE_
x-ms-office365-filtering-correlation-id: 0e6461ce-4991-4e5a-2aed-08de99d6af24
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|55112099003|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Y0cHv55mTRb+6w6oj6tTjGiLLX7PeWp6QznNneicIUGqlnoFEExJlEQFgsJwvg+ozxGsjdAwYGXBE5fu2X1Kd4H5+G39vKxbj7ejnliKtC4lnk0+JRI/i17g30iPsQxrQXbs8CFFCJ5iBMh6maclArl/PcswCK8d1N8EX8dZAbM5eyj6//BUQEBTxhhEoJSjQo5HFxEctyfZpoh4RAP541uV3F6sPA15jR88V9yGD8W9f1szvdj/uWMkCMKywpC3FzBHGZ2CMHdc3G+lyo4b5Ifj657zE1ZCiB2sl54D5Hf/yaWc5RB2MCnqPJ/2h7Re5+gHQDZeYdEH2+j7+r545gKkUkuGTG0BWfXvZcHX7Vdn805Qxu7jrUZb4qA3//CYeJOEWlOcb2H3ZY7d4yfsosNYflDxQPyoEFphc/wLtrEFkDfgLJXYYsTVfHIAwimS+ja2ERr3vsSTNSMjTI+y8FPZuEEJBQ7BdU9IhfQ4wb2at7LVJOy9rBhHqgrGjq6wo+ZxU4qEqN6FX64iVIT4fiBjgan5P+TbyN34+LgV2Td/QjURRssWpwru86CmCrruDBvzC4vgF7Ck6T4+hG6PS9m/+HHy8MuNIjZqMy98AVHtUBw9ReCQaK7C8igfKOqrSxr1aaodGrBTu/uKtiaFuNuAr4xv/ysdtBmByH/bCnIayKhQaJBuTnGsN4nHIYp34xoH8ru4919GDJcE3mn6+T387OOHly8r13wAg11y0LSxOGGffEEqEvVr6RdmpwgeiMM7fJ52+Qlkb2J6T70q+hxJkmtyKTMMzt6G6zse+qE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fSp+yDarJjh31ezieX3wKvmnz/lgI17IZQx9xzKrE5SJwYvhJJuvovQ8ZO?=
 =?iso-8859-1?Q?sSe17KLxzmllg6wAocyU7PZkosPeckRGzA7dYbPXF1SLFOc52JCtAObeAS?=
 =?iso-8859-1?Q?OebvIOafDSOWXVUFnKBHX8rGxdUgoKJxFTG7w8k4zaZ09UUsDHVz38gzQo?=
 =?iso-8859-1?Q?qn1yg7IJNZQ+SICkued5lhPL6tvpfVIas6U/JEOomq4Ksp04BUHeTZMQ69?=
 =?iso-8859-1?Q?4GIfdpk2OYkKVAOfse+LGjpsVfbWxNi03zpevdPvzYnzpssuZWBCGwHLHS?=
 =?iso-8859-1?Q?IBKxj5o0OIScIotr8wxslfhK9WVKH4jIq+vVURJkKI0aHpXZTMP1K1+/Uc?=
 =?iso-8859-1?Q?lZsrjRjFXhIGF4YZk+MszNJ3f7ET0DDxeR8Lo0szSS3/axCw039U4QWyWs?=
 =?iso-8859-1?Q?WyGjo+JE9mlAcaQ5LBxtRSc/0Es3V9V0bx2sX1EZKXee59jd4QtpluOMi3?=
 =?iso-8859-1?Q?Jcz63yLlZhCj4NE/WRjisyYDwOBLUNVwXuI+lh4b/vx07L4jaKFzOIM+v5?=
 =?iso-8859-1?Q?omU3nZFYVCFzIuWGBgZBQvSCDCcjQpLVShSkiB9Cz22Q2SI8qnr0OmMLtI?=
 =?iso-8859-1?Q?zM0YvBNyVYGsecMClO1VF0DMTpyMPhwTRcOGcEZInJpMO2eP2IJao4oh0h?=
 =?iso-8859-1?Q?Dk3myqlTXSx+TxPxTHWh2w1n6GHWHRqOakg6XLsz4nFjLeO/QSG1kpKblS?=
 =?iso-8859-1?Q?yhCH8LGerX1E+diyvxDONCSDwYvrWqtM/ynKT4kyIEeu7nwn2MFUinvyaT?=
 =?iso-8859-1?Q?EKYsJpMAEnFcm0Vicuan+wCjPAtxwAjiLfdWmBWdh8hFloXDd2e/6PuED5?=
 =?iso-8859-1?Q?HEk2AVrv4fN1lvqoxR1fl5+cxvOr0lC52BRUhX1tjVCiv62FACd8b5C5kz?=
 =?iso-8859-1?Q?qExcvtJGEIanlOHNS7M7US70HFMpb/Pi9dcELxqwdiL1OfeY8uHjBoLolx?=
 =?iso-8859-1?Q?eGmWfFAv1SXRidtg0Cf6dpkSEBezXMyyk+iGtlwOxkdLHJby5pgVliwgqy?=
 =?iso-8859-1?Q?vNzsA+2Bmu9idOJBp+1QnJQ1peEW62/geupzYUZn6H0hoyEyiW7ntn1Dub?=
 =?iso-8859-1?Q?5ft691G6V4HjgJcjlRNo4p7ZK/OFCSsjp74W4Gz6WfDiF98J+ntcAfiAfp?=
 =?iso-8859-1?Q?urh7LB/dpe9kr+YniXJgepv8fZ2OQL13kXKQb7P9CIyYdc2qFQngGFZAEs?=
 =?iso-8859-1?Q?E5RxLEVW5beRJd8/GAQ54fC1GTEq4Ehb9/VaZ11eQU5tVPB4ajG3zVnH3F?=
 =?iso-8859-1?Q?LoKUWobYGQq/6WSRasiCwLpD/0K33DyZK8LXkylw+gXBa6sEVol+IpmVpT?=
 =?iso-8859-1?Q?azyqRDoKjodEGLXi3C4xp8rKldLFEkMMznp+wxRFkV2krg1dupf7F3ewxU?=
 =?iso-8859-1?Q?fyD3FZLJI0783vowPLeKhPif8GBMhY3pSzzIwvDBXQJ0U+dmFk62ULiB+n?=
 =?iso-8859-1?Q?Q3j0kLUQS2DkIrtYWxqXit3nlYXpTa9fvhHLiuVm0XquNqT+mniEuLYrz9?=
 =?iso-8859-1?Q?OzMhtWisER/ov/0f/ro76ua4NYHaxNPlhZz5QuSZiPmPjNcIcZ1ZujoI7u?=
 =?iso-8859-1?Q?jHalDjRDLgz5oMpo9qyTLBo1cvfau28g7l+QNcIrwePfCe7HBKq9GX+5N3?=
 =?iso-8859-1?Q?8GZ21La0UtMC2wEnpQrRswXTK88GB4kjXjY0i9/im2aTYN0bEUz4cnqpF0?=
 =?iso-8859-1?Q?eBq+g261OhRNNMEEYVlGCOIWP7X6lEPHOFq5ZeO1cJzRxQ8ZXXIT9pYNgK?=
 =?iso-8859-1?Q?D/wPmm/PcO+rM17VPwNZu+HSeD+RZ9grhUJyPmxdxmXN7hmE87qmgCEpw0?=
 =?iso-8859-1?Q?B7Vy8VTTOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6461ce-4991-4e5a-2aed-08de99d6af24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 03:34:07.3472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K8jGF1pKvQi0oZGQXSzOPnYRWX/PELD89kdDnD5N+EkqKnuY/t0eB1sEpDgBgtrE8ZyYoGdBx9MIUIXuYiYQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR03MB989165
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

Hi Tom,=0A=
=0A=
Thank you for the clarification and for looping in the EFI Loader custodian=
s.=0A=
=0A=
I'm okay with the implementation to improve the Kconfig logic to only enabl=
e=0A=
`CONFIG_TOOLS_MKEFICAPSULE` by default on platforms that actually support=
=0A=
EFI capsule updates would be the best long-term solution.=0A=
This would prevent misleading configurations and avoid unnecessary=0A=
build failures on platforms that do not use the tool.=0A=
=0A=
I'm happy to help test or review any proposed changes in this area.=0A=
=0A=
In the meantime, could we set the setting=0A=
=0A=
+# CONFIG_TOOLS_MKEFICAPSULE is not set =0A=
=0A=
at the defonfig first? as I believe disabling the tool=0A=
explicitly in the SoCFPGA defconfig remains the most=0A=
accurate way to reflect the board's capabilities and=0A=
avoid confusion for users.=0A=
=0A=
Thanks again for the constructive discussion.=0A=
=0A=
Regards,=0A=
Boon Khai=
