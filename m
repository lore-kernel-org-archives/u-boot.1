Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28B3C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D74819AA;
	Tue, 18 Mar 2025 06:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Wn0dTA0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09D7F80F70; Tue, 18 Mar 2025 05:03:51 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1E8480077
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:03:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr3UqX24lnk24ad11q4lKzmy58kSQCbD1HMLcjF9mr6vVQ3q/W1/7dcVv43pxekfafUjuEYM56SK6BVwX+Dc4+Xfz8nLtziibzsupiLtSlbmiVC+Qx6ZYSqMp9fa3szKfaFYEjKbKWge534++4HdBLuYHsDUbaHI0U4VgVo/w3B+6HjpUBN6svNtIv/cqWQSwFP0/sQ8IGIzZj8CKLnByC8JaVEvDMt+CVbPGXUuNuq0x+tiacESJt4YGS8pzUInREedNJQOy1BvLxbKAB3ulaYu9W8q2JSQmVVjX3HHQJgoHZgHd1eweb31ZGW8jQNrJn6OFUB5edgWWXqX9FnBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgWfV9cTV873MM1OP4O491B7p5Dl+/6HQAduBB6HBjQ=;
 b=G5eR+oKjsw4HlqVSlBCV5Ov+kcasu1+Q/PR3fXOpNjgWc7WpcKUNSOkhFsnIw/D8iIqh7kuPM0t1XiznSJuh/z0NOQNGGNbCvFlx1Ikg3xf5yVCKnEzKO06Hp7r6KyN/Hp2+hX0yy5oQJgVo47FGheuNZsagdjY9QvPwBiJZved0GVP4wI+l6i2hiQB8/ggyvLCKBVs0hU/WQEqiEyv8O3ecAjAYiztbOI8NvTvFoPm1JGuGTdh2u48KVBNC50mhYGktLMn6MKvOrYVUid9oxDwwCRUUi3J7NLKCkGdGQlV3IO0vyv9RvOVmm6DWGqVMNoJ3U5zqJVup/CKX2PmidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgWfV9cTV873MM1OP4O491B7p5Dl+/6HQAduBB6HBjQ=;
 b=Wn0dTA0jAgLOJiY1Kn2exreIUgHqvSOFSS19PGC7rMzLDHrtNnvY95HaC3WqYLT9eFetRaG9HmXxuGXsKCF3989iW4mYIgCOHXu0rn3x79eE8SJj+HsE6dBoVXIGbAGxiKdTBKB3ghg4A7kKLU2tJVCltpjIxAAe4Ey9QKOE/DxL1uQCqKAqJTMyb3pAlC+botXXuhJNbyDDQayqPr6vso9FYvlqOd8+8y9ZH8U59q+xnFBTQIyuRPjh34bqp5bba9mz6I5pASFBzuRUggu8KsLMX7mmUfnhDygkHewRtXjEorzOw3Kl6k2GP97RzBkXznbAtMAye3U9Wn/p8gRAPQ==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW4PR03MB6990.namprd03.prod.outlook.com (2603:10b6:303:1b9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 04:03:44 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 04:03:44 +0000
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
Subject: RE: [resend v2 09/13] cmd: Add i3c command support.
Thread-Topic: [resend v2 09/13] cmd: Add i3c command support.
Thread-Index: AQHblJcErAQx70szvk2Uwije5fl7PrNy2hwAgAVwvyA=
Date: Tue, 18 Mar 2025 04:03:44 +0000
Message-ID: <SA1PR03MB637070BEBD29DBBFAC504048F7DE2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-10-dinesh.maniyam@altera.com>
 <20250314165344.GA2640854@bill-the-cat>
In-Reply-To: <20250314165344.GA2640854@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|MW4PR03MB6990:EE_
x-ms-office365-filtering-correlation-id: 32272c81-fb5a-4a8a-2dd2-08dd65d1e09a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?C+Yivjg5qBcF+AHUuPzxXmJpt9XqGkRimErlO3+Fbw3skGqiBefHIhWs4JRb?=
 =?us-ascii?Q?5pKYIQ28H4lgl1ablDa1G8RlUuufhebt/Qmd6p0Al46+rswnzLVsgacMZrkQ?=
 =?us-ascii?Q?8M4x4aT2sPuJ5v/x4AA6yGN9taCri2/2h/0rPT3KUfAsHrZG8c+4NCzljswX?=
 =?us-ascii?Q?ZL5vmKqQ5ZR1eCaxjnJVubMaI+PshzV16xS+NdOGN5Y17BdSJ6P3MPu81N8Y?=
 =?us-ascii?Q?iifskS3dnIYNP8AtvVrkF3Fv8+jZ88O06pa8keNL6qQtUx7EqN4o9NnclU5F?=
 =?us-ascii?Q?/Vu/yhaxevegBSgVzcRq9q4rslhs6rphQXoUd3vFr7NuG+QkDNqhlCka1+2r?=
 =?us-ascii?Q?98qhx4Wsj9qw+QRlTGel5VE2xwasAkdbmxgY3XJsnsf+Ay7UOKBVh2ma5E6O?=
 =?us-ascii?Q?5W1lkAfBOOLL5lBBlkqhQAY7e+G8urM/9rWWDAQE31Uk16KyyLzzMRVYgb5A?=
 =?us-ascii?Q?huqEehgFkzAAxsfQX6zppHUtKzaP89tFKVwAyn6tVYqntsCTCsvAB/eVBltp?=
 =?us-ascii?Q?rT61wSCsI7y5MU6u2mq3maCkRDXJWHvciILiOVL7hF5AAtpzyAiGwdmieww/?=
 =?us-ascii?Q?Ds0PVm1OGSd2+S+8XXiPVT+MCfFTfrwkP3zZzdRkA+LRS1pJDYbrnTn2PgNj?=
 =?us-ascii?Q?ILs74z/WA8WbupfLGf6HX47+2TRFtIcLaoznX57iHFyzN0Rl3nNBgXf333OT?=
 =?us-ascii?Q?JtcHlOttbeIWdMPguCC2znJr1sXaZ/+tSpHXo+ezNUPBbrBrF7vqMR9d2IDC?=
 =?us-ascii?Q?0ueWhwhf07+hifIPsE0ru5+dJR5Q8VbDBB2olh787SdiLE1A090fnUvXhyIe?=
 =?us-ascii?Q?whCY3hvm/78rmINqWE31diNfWG5OgD9PtrquOAuHrxiTFQ+XILEl/oyKhk4V?=
 =?us-ascii?Q?ta1hZBGVBwn27G4xWbg5NPulIlw4dahfMfh8UqGIhs1ibTH4uvyYL6maiPID?=
 =?us-ascii?Q?yfgITOcVNFy4It1N68NP4hA1/NCveZM+DNv/e8aE7bD8LibzMJelQdJWBL4e?=
 =?us-ascii?Q?nqMOgGO12p8rWZWHHmKQIMhIppPpmd2kN5F7PUgst+BGtoBNgXQsLJeG2E4M?=
 =?us-ascii?Q?IOhHtRZZjn8MGiVYOX4CCmmn5ZoDOyLpAe09TMtU10PYESd0mY3lMFvMqFkv?=
 =?us-ascii?Q?JqFghl1gqKSy6O9Xft3Jek6IOEIqgzqTjPRq6LkwuM0KoTsusPJRWOLXqdUB?=
 =?us-ascii?Q?rYa+AqcuMeNs8ntTyqmlwj3Gwk5uKIpEn4zWS4acfq5hfi+GzitD8mFOAOcs?=
 =?us-ascii?Q?bioB/cVaUd4LSFOyJILdaLIOQetD/knkqpVVhjr4Ph6dukd1srfSq/qrBn6V?=
 =?us-ascii?Q?9JSPz49BkA9weX4f2HXLXkm8t1p9utIZypQSskJMZvKyXExZBReoaIBGh1BU?=
 =?us-ascii?Q?MzO8V7svPzWpQT1jYYZeExO7qqY8VXb14ew7DNEIbI8d7kkvwGRc0RIAT8c0?=
 =?us-ascii?Q?LWHu8YC/fNvEuLuGfpoy71a9Ulhh++5n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/yjgWpkRUcOVMd81s1IM25gzDVTmNOOGGiabUeyBMxUuOTNlFJRZThlmjAIv?=
 =?us-ascii?Q?KDOpst/wnWDMy4n89GL0bt6NBlD0WM6O/vUUM1IrVx5QTzWrNIMFw4xA1Y3M?=
 =?us-ascii?Q?M9V7N+jQ0OEzhFSzGHD7jFsB0t1NaqTKe97lonxfuekF+XVXu2gS3AMaKxBx?=
 =?us-ascii?Q?Z8zOpiMMN3SruDO4qIYRyIbzipDUnnleOdlO8/BLG1GpbtpTwdGaEG9SvE9P?=
 =?us-ascii?Q?0LY2nMeOma7Wi9O0t5IX6c5DqC+wiGOcchF7n3FZszpVFC2vLe/dkZvN0+Il?=
 =?us-ascii?Q?r/Fadize8mqEtBsxFDTVEXEhEK7UpcIr6CTkSkAU1o17eef56EQnrIgnMzLG?=
 =?us-ascii?Q?8h6ltuvYZith30edn9cDjZvaV5ZQ+WnwNi6HAQLBG27njwNtnqzykz2bKaIr?=
 =?us-ascii?Q?QENVQNsZVnZzy9fh5Gri5EtdPhrpOBxT6HgA35M2AUJEU4UK5P5WqEHD+dpt?=
 =?us-ascii?Q?px8FhfW3YwgRnr/GudvBSVuSHR1VqyWbsa3EBEHB5z2KN/0LBAY+Kxl66TEr?=
 =?us-ascii?Q?vJiOSLae0Xa+KcSA/5TaJKJ9WS6bzXISvMCukdRYdpqFCE2G0zjXO9Ikx/ty?=
 =?us-ascii?Q?T04RbV7px1V1djGgU3qAp5iILJIQubndcoGfQFKi+iAHo5uZvbgV5lyefeae?=
 =?us-ascii?Q?auHpWg0+MYj9gmk4So8uYBjVjjaGT4Nvia6QJvj8qt6AvllR1c9lqaIW1+ke?=
 =?us-ascii?Q?ugEM00H/GGvd67eoR5IOzPGSiHDO5uBjrA3mH2bQz8N91k1xonuKpIotpRse?=
 =?us-ascii?Q?98CchtCUb9kLqszO6q5yUCKR2o1oHc59vmVPt58+vbk1gDAi7siH9FIXveiD?=
 =?us-ascii?Q?iSwmDAIZZURYKawFjyrlnNE8Lkcm6cBtQ/S5bwI3uh2GW3xB7wruYjW1SE4c?=
 =?us-ascii?Q?WO0Wl9iNdusuZAoS26N0ZTHLsLhFVv+xaNM+OiGDLsZSp4hO1fCM3Xle3CfX?=
 =?us-ascii?Q?1x9ojQ/iN3+W4VIwF6gSbeDWEM5LjkTQKs7IWpMZE3QG++pv94xzHq20qivb?=
 =?us-ascii?Q?zsJWifo6ROttcMppjRJhebExdg5Ni/8hBF8brW53eCVZT98rzfsN1CGmXt9R?=
 =?us-ascii?Q?iwOV0wfM/60bvasct0jBdY7l8KqsD8UKepK7K3jhJWHpIHRDyMpN0F29taZo?=
 =?us-ascii?Q?x+CeHIV8LXTs1UF9SbgDRnyXI2aTrNuYLiCzQzx1j8yCUoAG8bXKo1rflB+0?=
 =?us-ascii?Q?emmlbQt2VTkhrq7vfk94AEtEhoz548HMvvSxk6RAC9/UjbiEZfRxqAYdxEKC?=
 =?us-ascii?Q?yO9EMiz4e2a7NxNMvjZH1+gpaudJ2i4fF3zepeaLYHXQLb5quEeU8p+/wP91?=
 =?us-ascii?Q?hWGKSMkyuOqh79tzBoSZV+VejsniCDGeRL5e+Rg1IJ1qp0FtwgYiIZW49w07?=
 =?us-ascii?Q?ZPt+8Qj33+CP+gOMN7zrBw8hkAM8vrbW7AulVjDSuI5sDzOChuaSUVCVqx6X?=
 =?us-ascii?Q?35wrzXQqEPSolWsE0K8H5Z7JCBfBRU66xPF6ataLhUoI0a737tKMekkaEAGV?=
 =?us-ascii?Q?5P+eeoXVZnuTUaQzqDUWlyIrJNbWK6b+iloWHIZiFn0AKAQ29rkah+ZpWefz?=
 =?us-ascii?Q?aya+h+a6yzdqkmwhhBi231eKiITkhb2E2j1FUNztSJUPHx0MvfipjspmNur2?=
 =?us-ascii?Q?kc3SVrcltRemnJBEAoLQ1viDufN9p3AGHBmtVsSJLAze?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32272c81-fb5a-4a8a-2dd2-08dd65d1e09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 04:03:44.6902 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4m/r/+PonuYZ3h1ikJ0kytbeV70RZsYC4Zq46AOFDsos+NMdAyVCxA0pmWWxxdvARcyXuOvUZE4/stYBjERShSRYA7NJp7ChilUee5Zf34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6990
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
> Sent: Saturday, 15 March 2025 12:54 am
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
> Subject: Re: [resend v2 09/13] cmd: Add i3c command support.
>=20
> On Fri, Mar 14, 2025 at 12:08:58PM +0800, dinesh.maniyam@altera.com wrote=
:
>=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Add i3c command file to support select, get i3c device target list,
> > read and write operation.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > ---
> >  cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
> >  doc/usage/cmd/i3c.rst              |  98 +++++++++++++++
> >  drivers/i3c/master/dw-i3c-master.c |  35 +++++-
> >  include/dw-i3c.h                   |   2 +
> >  include/i3c.h                      |   4 +
> >  5 files changed, 331 insertions(+), 1 deletion(-)  create mode 100644
> > cmd/i3c.c  create mode 100755 doc/usage/cmd/i3c.rst
>=20
> Please put the series through CI as well as checkpatch.pl. As your new do=
cument
> isn't listed in the index, that will fail. I've not checked for other rST=
 issues.
>=20
> --
> Tom

Noted.
I will check again and correct it.
Thanks.

Dinesh
