Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545BCC28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865088186D;
	Tue, 18 Mar 2025 06:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PKo+H0Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDCE80077; Tue, 18 Mar 2025 04:05:01 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100A080107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9W3PCXd2Gw/E3dJ9B+ok9F1cB8ga0yCwOAly93XO4YuHlgR0qf95OIWSBUIKgz721ERz1sPLwNeI/QMrW/+eOZoLwyOSmB6YK4cnW4JQKnCe1uinCSJ5JPHA4ue/wXhcj4SWSumSBrTgt3YIS+v43BokxLgnFJ2ta+gbWffmscHwf3Yfz0D2NtR2HDTw6c6UbLTDot6MMj33kjhXDOe+0nHZ54RwGjG79NuIJ71OqT0GfiXaQVfNNjg2tzhpRGm7NPOitSvpzO9fU7BIAb5mZKLoOuY2MfKg0+kztkA9uYr9xDOZKy+Od4WSrc41XkknKqWS+9E/vA2t74te89SlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5UJJ/8BVz0hlI2Cn6l8T191i2Dup9+W6VlQmrPRzrY=;
 b=VaFqsFLKyBw9nSW1J8JFP9AdvOJbOZuDAwlYe4VXAiQRmEIVqn0/XgL+QAq1UTJ/SqT/9PCTVrKyUFNFwABO/pcpN9Ym3x1aF6YvztTopAuXunBytV+mm1jhfCUkHzSvJqcccJTu0kDXMJmbX+qCvlPoUaI/GzQLTFugxoQwXk1UF9fhrbVsfGxglXuY8pyt+PvKIKONfBfRvVHWnZFbbs39NvYdJSLuA7zwg01sWNb34o9KjIRBSrMQ3YtcqFQNJcp5ffl1g/h75Ek6kl7FcEdv+T2P0zqegH/t7XqwZe7hAcLaXbafj3METerq8b8SFt8/Q4fALZZuVke9/4VGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5UJJ/8BVz0hlI2Cn6l8T191i2Dup9+W6VlQmrPRzrY=;
 b=PKo+H0CxBAzYu6mW1J7mpfwcwyFJqv6f0jjCi9UrtpfdUawwxOyaubRm8lSnHzoxI2V9FGp7xl3OkS79o9ATu7dGQvBei3rfhrQpP7vMtr5jNkk0I7CozVt+CDs8oHcYVfg9A0dCoNMsp+IpVT3sJDz7NyNqEYZMJCi2sppy+ed5D6Oe9Vw2l8iCJNOETe6++emKRuefCZF6Fszr7rao3l7SpdQA4fxV180QsWm1Znvt6Y3NQBXKXdrKTlYzBRrLhSjkfEoARrZLm46WdnlD0P1IlLrwROKuaWeS5umwu/kByi8iUpZ6wOoNml9iLBnOqwcj13CKX6B8cKuz1ssbWw==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by SJ0PR03MB6876.namprd03.prod.outlook.com (2603:10b6:a03:43b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:04:55 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:04:55 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
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
 <jit.loon.lim@altera.com>, "Tang, Sieu Mun" <sieu.mun.tang@altera.com>
Subject: RE: [resend v2 06/13] drivers: i3c: Add i3c sandbox simple test.
Thread-Topic: [resend v2 06/13] drivers: i3c: Add i3c sandbox simple test.
Thread-Index: AQHblJb30ViJuRvE1Eyo16olG/NDx7Ny2gOAgAVhY/A=
Date: Tue, 18 Mar 2025 03:04:55 +0000
Message-ID: <SA1PR03MB637074E7C48C49DDD1B02466F7DE2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-7-dinesh.maniyam@altera.com>
 <20250314165323.GZ2640854@bill-the-cat>
In-Reply-To: <20250314165323.GZ2640854@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|SJ0PR03MB6876:EE_
x-ms-office365-filtering-correlation-id: 3b676764-20f3-4697-4fa7-08dd65c9a8d7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qSw3a4BuhL8JdERz81gM1ni8DuO9JbMrgJ8d6+q1HdCmE7mF1JX2eitrJH?=
 =?iso-8859-1?Q?Ca7yQEGr2AN95X9ytZ2+jMNc0KwBnKMZLHdfbD2Bs3BmobFby9yr1YIC12?=
 =?iso-8859-1?Q?12ol5oAczvZLmbU/v5XyY1TLJM6ALUcVG+SWygwY27pnjoHHH+vfv/LX/e?=
 =?iso-8859-1?Q?EIZMk3a8Ss/e6xsMZf1TqgEHwgMtScngblCVBbOr46gewAKTTfbeBh9Tee?=
 =?iso-8859-1?Q?7w1SmuK68bbG4tBD7ZLFbec9YVQp9uXB5b+D0/ey3vgkd1gW+IV8359Z0a?=
 =?iso-8859-1?Q?SZDvbccumRoglJ2PIuWFtSqUDn/QTGXArJnhYfMQHzZzzhR6GPXDpnS7Ew?=
 =?iso-8859-1?Q?xrKV/MZ9MGBj6MeDPaZnMcWjuPbwqdsjeFOkDEXUXuFMkiFyJXz4PNKd4H?=
 =?iso-8859-1?Q?oD+7ZojKTJuhT09yQnqj7/xcB0Q4/mJBk/rhR4qfx9CtGDa92jX37wpfJG?=
 =?iso-8859-1?Q?TgQZzFux0WNzq/3htXEEqoNMY0JKQ0lI0pEJinKw/8IgIHJhdxCTxVb+t5?=
 =?iso-8859-1?Q?LDyU/E3FklpXxqfeL9VFY62QVOgDumYNB+8cfqP08xwn7PQvQd47sqswWN?=
 =?iso-8859-1?Q?XYsH9Nmi9Ps1W19DPu73pGO1ZWAAIDfEZwwi4rSEuZul8NkfShFdf8GVrm?=
 =?iso-8859-1?Q?qzOsSUe+fbXXBfjZxOwVq/YOdVe+a9T0Gjj0sljVJgtuP47jGD8JXetQ1d?=
 =?iso-8859-1?Q?Sb/UlrZYLV29mPkdNVjE+EQZXEPB5hZI0NhTi59U7Yrva7HdmfQZkxGvMq?=
 =?iso-8859-1?Q?i5V9TCvQ2eAi8NusvVm6cVtxeXI7kMxRYY9rOmSTyEE2EgkkR1+HKhuQnn?=
 =?iso-8859-1?Q?JJjgDZ0ESeBOudQiFmfH4ek7+v7wtmaEm7UqsvzdKoKSUfMKx5PFxylzep?=
 =?iso-8859-1?Q?7GwmFlghidSp9SdJ/pSphZn8xfheh8jnCC7hnGMH6zIe7V+/JC+01UgizR?=
 =?iso-8859-1?Q?5jTFAUcG/7ox9wouHzNvejm35Y73zyucbGw2KI8+V8PoIrKhVO93JwmfSE?=
 =?iso-8859-1?Q?ekZX6bdtrGVsa71N6aPrmbcM0xZtaOzK8Xs8yj87Yq5jG9U3tHDcrluElJ?=
 =?iso-8859-1?Q?iV5iaTCU0Dx95jT5JYHdwS0AonIWqqlhiCG1bn9EptCUO2aqj9w0FiJGKZ?=
 =?iso-8859-1?Q?ba4XLnf2gxEdgQ6cenixMNiIzLZFy7vLO3Tg/ACUGWeisEwrR2R/vAzBOS?=
 =?iso-8859-1?Q?lUiCAK/q7u4p46nE+oKiKtRfj8hRAPcZaVr17yWFGF15ToJmWqocpFfMSk?=
 =?iso-8859-1?Q?Nw8UH7ko14QFVZbVJEu1HvyFKfs76Wko2VVEbRrrfQw+XxUE4JPxXTeHRB?=
 =?iso-8859-1?Q?xjNgJ/XA0jzQEkonFOU2p29lP8331WrwE6ID7WhnRy1A3t9Z/qyxFfd8Z3?=
 =?iso-8859-1?Q?7ARSG2u2LQTMlufnZG8xC1+gP5uO/DkcH8DFFUy93cnVq7FIyUP2MCMXMc?=
 =?iso-8859-1?Q?hw4rjWgYWReCNBlb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wd4G7/pMH5zMwVCxlqWDj7SnjEkYtQiY3fEpCRh9gJXbFPCg+hfNyc0QLR?=
 =?iso-8859-1?Q?jQ4J0Y7z+Cx/nWIpzyUoU6bkhxKdL0dY50AkOzO/9rJh3E2il6Lh8Woy0D?=
 =?iso-8859-1?Q?zcejDHUE1DRagsMrU24ZkPErVz8y0BD1j6FDqVxHB3nyawXKNZWCjRoyL4?=
 =?iso-8859-1?Q?OzVktGGJCZiQfeMuqK0ZvrzBlHfv95RBgCNHA7WCQLstF2jti+5jdhcYNG?=
 =?iso-8859-1?Q?gERjIHC8wxYTaK5CvPlJ2JcBH9+BxQ5+EMaKdFjSNoAb0Z32D+sMzV9mY+?=
 =?iso-8859-1?Q?UOJK1mrxxUD829eGu/j0CfYXJTqyLyEj9rSCQX9UxDoyIgzEIUDCn84YYY?=
 =?iso-8859-1?Q?RH2Dihrdm8JbUHTSfNR+1fOZ/dEpE4IoSF0ll8QiOwP5RRGUzvrdlt+312?=
 =?iso-8859-1?Q?gjvPkJV/NaAf9GhFJvMWEXLoxI7P7aqFWAbkYZmIgPFB4fzU1HX/WA/LdJ?=
 =?iso-8859-1?Q?SC5FQYBltaJFoJ0/Z3Lx4ZqPAlTDX0PQ19IhRvGwzY/vQG3YYimazTwhHy?=
 =?iso-8859-1?Q?uv0+Lc9cHNfsjM3RJwzk0ZkMfhN0/RSXj3Ed+TdgYtdp3OA7EhmJ8ZhXOi?=
 =?iso-8859-1?Q?R/j2m/WrUV/TexMkn0HQ2LYdbsI7OYrv4ZNaL3qYAINpDArkLREWczSu3d?=
 =?iso-8859-1?Q?T9eHY6vpcukDqntVLTcxOZJalvh/Yd7BWYwHxv2VOwygx3pA4GEQsHWbrO?=
 =?iso-8859-1?Q?i3c7wcV8G9ff6Sclus2Ej2NrCpL6q2dCYjF8JqM8RuhYOozSAp8rqfeNQw?=
 =?iso-8859-1?Q?rxD/nF/EcEcTX8kuql268NbXy+jj4cZq8Nn5KtSgGzxVadnf4dXLnOm6QB?=
 =?iso-8859-1?Q?2HPtuMVSfNstc/4ZxbIxSSgG2aWlbr9SEzztjvgycqYPZHrkOf/T7o0VfQ?=
 =?iso-8859-1?Q?+2FJxyDi+T4+eFRfFgJ72naSeVmmkAPawodtkI8SRpNr1xx5pkxDPecqT2?=
 =?iso-8859-1?Q?7IvJvILWkG7aPTOqxacE5yaWI5P6p3vGhIJDDMgynZvpqBXn4gkmxFBNJt?=
 =?iso-8859-1?Q?2MBMSbSlRq1DtTid3CPo4WAwgwAUze6cWFZAYNTGG6FFET37XD/W37+7W+?=
 =?iso-8859-1?Q?miaNDwML8hrDbIUECgJfXVnNDli8wmXPQrMhpYqVD1JH2DWqRR7vTPx82r?=
 =?iso-8859-1?Q?Ba/WaYOH5ytGPuoXmeZVVG5BID4KAfW8SviR2NkslCchPkMbyKZyODbsmb?=
 =?iso-8859-1?Q?AL5X/c6MPVaFyL3vYd4xhXi2ReTo2RtDVb5qRXsdKrxjyYloYCpUchKX5l?=
 =?iso-8859-1?Q?k3D1L+YbzRxvF17c6i7aehEXG/SrNLEriJ8AYWcxK1/1NL4W5DVbhHuu7N?=
 =?iso-8859-1?Q?lTk3iQdJLInB9oRFbXvIQRvbcCkgtWIhiORwRwD9yUszqwdd53UOSR4bWx?=
 =?iso-8859-1?Q?jR3Hpm6La2Zv8BHV3gkSwnaeHmoCY1iNHgPA2rseDQrcqsymWICG19c29d?=
 =?iso-8859-1?Q?tnGOXN7the8aUl+Sq0+zyLkaL0TkVp/bsgWDOmDi6NLKOGcy9YotkpQDxG?=
 =?iso-8859-1?Q?7kpbQTURG+1FYkxnxPXslyB9XuwP7LzZVPJ8P9t48PWxKn1VbqPnLr6dXa?=
 =?iso-8859-1?Q?GOZinh+uJGhtODiiie2K/lBgzf2MfSJ6mJ5ccHBwK1X2ZzF8aReJW4TCxT?=
 =?iso-8859-1?Q?KHJ3EYOTr83/0v7FBCt8H8ds3hRgZ/dLGWlgK+8H48VnqjzwDkZQ8MF9NH?=
 =?iso-8859-1?Q?+gFEjuPeSIyg1eY+PdB67B0roe6exPjvc7nShW0M?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b676764-20f3-4697-4fa7-08dd65c9a8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:04:55.1867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdh/MXpuBY9RdHgxo1HHVMyZgS7EG91ansLiOep0rlzZP42CUyyVDQhrmzHCnmfCxQTAW1RkhmjzUFNzw8yQa3b6xYUp3AuL7WX68oIZUx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6876
X-Mailman-Approved-At: Tue, 18 Mar 2025 06:02:03 +0100
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
> From: Tom Rini <trini@konsulko.com>
> Sent: Saturday, 15 March 2025 12:53 am
> To: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Cc: u-boot@lists.denx.de; Marek <marex@denx.de>; Simon
> <simon.k.r.goldschmidt@gmail.com>; Simon Glass <sjg@chromium.org>; Dario
> Binacchi <dario.binacchi@amarulasolutions.com>; Ilias Apalodimas
> <ilias.apalodimas@linaro.org>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Jerome Forissier <jerome.forissier@linaro.org>; Mattijs Korpershoek
> <mkorpershoek@baylibre.com>; Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>;
> Michal Simek <michal.simek@amd.com>; Dmitry Rokosov
> <ddrokosov@salutedevices.com>; Jonas Karlman <jonas@kwiboo.se>; Sebastian
> Reichel <sebastian.reichel@collabora.com>; Meng, Tingting
> <tingting.meng@altera.com>; Chee, Tien Fong <tien.fong.chee@altera.com>;
> Hea, Kok Kiang <kok.kiang.hea@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Tang, Sieu Mun <sieu.mun.tang@altera.com>
> Subject: Re: [resend v2 06/13] drivers: i3c: Add i3c sandbox simple test.
>=20
> On Fri, Mar 14, 2025 at 12:08:55PM +0800, dinesh.maniyam@altera.com wrote=
:
>=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Add s simple test for the I3C uclass in sandbox.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> [snip]
> > diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c new
> > file mode 100755 index 00000000000..99ce769988d
> > --- /dev/null
> > +++ b/drivers/i3c/sandbox_i3c.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2025 Altera Corporation <www.altera.com>  */
> > +
> > +#include <dm.h>
> > +#include <errno.h>
> > +#include <i3c.h>
> > +#include <linux/i3c/master.h>
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
>=20
> Here and elsewhere in the series, audit for adding DECLARE_GLOBAL_DATA_PT=
R
> without a "gd->" in the code.
>=20
> --
> Tom

Apologies. I shall remove the DECLARE_GLOBAL_DATA_PTR=20
because there is=A0no usage of gd-> in the code.
Thanks.

Dinesh
