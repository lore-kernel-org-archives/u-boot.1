Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC79FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B4981A10;
	Tue, 18 Mar 2025 06:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CfFzA/cr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2628C80F70; Tue, 18 Mar 2025 05:05:02 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF91780077
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 05:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVrN2sHlVFVKQ0CV0yjjK08/nPnAfr5jCnhzakcc3MylAhhZlNHAADYIJegAxyasHQDBlEImVkM5+rB9yaCWLPDd2p13QwF2dIzYrh8swxK3YD3gM410DNuCk0pPw/nvEk/QBhWHA/4ChDtub4E+tvu1V8gg81p88QiM1E+f2IXKUbrpSVm2febEAV9AV9OQv2Ei2WtJzBMLpu1oOVF8n2jOzBi0sDPVHp1kxN6kbB19PW1hLacNkAcCQfKlN5tent9rdPrGdL4c5Qp9N3DJz4qJFiTo7CX0lzOGJNwbquuvxLTTbiGtBYnWcB2iEJoqPEKB84xWv2AFa3lh98XpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN8E07KID3zgDXi2mr0AqA0Zh23cQBj1RuNj54RtAOY=;
 b=qlds0l3T7XJ52PWHk9mK4c4CuXDnYSKFS2kALT9unKE1ECMMNse4NkEQOYw7iqzLpjFQESw5znHeZ/ggaelkdKV2iGQ1rfe/rQDzrJUekfzTkiSjHX2Y7oOxc2BQU3llc4PNpphJZPA6XSgBwwT6e31Myp4UVKL0YW9CeC201pm6jWbMCH1h1BYNG5Yjh6jX1yKTwwL1m2HEmw+RhUvTGwMg4DZtqUz/lPZz1QyzH8Rv6PasYPdDZSqvmiJGfHHg+0QOFXno5OVJNZ+sQdofWKoGNHpE85lcONATRVkkNGiqDF60MyaVDU76ZCevishkfvO5eVUeMxXpjJ2jdWQ58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN8E07KID3zgDXi2mr0AqA0Zh23cQBj1RuNj54RtAOY=;
 b=CfFzA/crSLTY4sbcu3alS41PqW35f8a60ARctiHtSnn9TANMiZDmdeZrY5eSJEV19ocgsxchCp3XO09vkfes0PD5W177hjMta481f/din3lxjASdueV4gTrG6g+7BKtH+DlrX1IvLNY+kMxmnW1sLM/u6SPHU3KnTxQm4mg8NRsL8lMWtGBNJo0xSZNUFIe/blBLmDtSvu8N+j+nKdErYmaPiQqeF7P1rtAbNKTq5cCBNtbW5TpPlrfw5xD5pmOvHzRLISZhp8QXA9kv2CcgKjIoIX2KCNs1Vmt/VSJ5j7rgDNYbQXjT5w6vOb04WAT/zCz3j3jQRInI2ZZjhHZ48Q==
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW4PR03MB6990.namprd03.prod.outlook.com (2603:10b6:303:1b9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 04:04:57 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 04:04:57 +0000
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
Subject: RE: [resend v2 12/13] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Thread-Topic: [resend v2 12/13] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Thread-Index: AQHblJcRjdPpyI8QLESdPFn49G3IeLNy2jIAgAVyK8A=
Date: Tue, 18 Mar 2025 04:04:57 +0000
Message-ID: <SA1PR03MB63704765CF4D1CC094A1B3EBF7DE2@SA1PR03MB6370.namprd03.prod.outlook.com>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-13-dinesh.maniyam@altera.com>
 <20250314165402.GC2640854@bill-the-cat>
In-Reply-To: <20250314165402.GC2640854@bill-the-cat>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6370:EE_|MW4PR03MB6990:EE_
x-ms-office365-filtering-correlation-id: 7736f8c9-ce78-4344-aab6-08dd65d20be1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MMh+NvWSluKvyNSttfk+XiHZK5jFq6Vpj+9FQSp/7T2LK06W9ylxmQ3ouSes?=
 =?us-ascii?Q?jBevMKOSY6so2bFrApNB3B57uXbEwwxeU3ayzgGnRn326k7kt+h7FJ5adrCu?=
 =?us-ascii?Q?Qgk+zGI77OBNIcHZTZTqzyWmCa8JBexuCMYs6vNBOBnbzMY/TOnM1Y28OJ28?=
 =?us-ascii?Q?gs2cnrLBedhCKZXlPXy6X8744BJbdqp0YkjF1y0trVqNMPUegE+qRsuGe5yv?=
 =?us-ascii?Q?aI+Pv9rOAwn1yZJ0bTXJV18VnqIj5jcgtT1IZ4Q4uSUAkth4jmsN/OVW32WX?=
 =?us-ascii?Q?nZJ2P/q5rvsN9Qt3qJSbU79ZPLNuJSQ7GRJFzd/iglig9LgRf3fxCU/rm04Z?=
 =?us-ascii?Q?s/EHLjgmmbtAEsxGD73zebhbo+zCm/Hvy069v3zKQq1yr1ZjVcDotJJRfvGG?=
 =?us-ascii?Q?k+mVQK38RThjtta4FoPR4aoJ72PmDOgen5gMpgUBKPnabyPgJ5ZF4IVYo3h0?=
 =?us-ascii?Q?olsTZyhTKR04hmgYfKvrn6rUKZqcnFWRvT7J/pnQ/zHUnHaRDGaaxjmgTyeN?=
 =?us-ascii?Q?p8Ii2C66WoRZGq4FJi0oKoJgqMmBLgdcRL01EYkilwhJu6ftvy1TxxrufkVK?=
 =?us-ascii?Q?rx4UacAxbb7reKEI3wHbtE/crGdxRrVSHwr6Eo2lziNLzrx4mioA3S2fbH8+?=
 =?us-ascii?Q?qagopkAVFyQ6QwATsOIb7AN6d/hlaAe+NwKMs04zushAboc6Ob/ASUBZ1ChK?=
 =?us-ascii?Q?pi2pgVjC4DkFdhNTQkgscS+Hug/jExamUwsiE8DIOfk86RgbnU5HliDDg8qx?=
 =?us-ascii?Q?2fL+UiIWKI33SDjfqJHVIYGH5a0C9tVLH4xhguvNIpPbVJovMBYxJnRrLqPv?=
 =?us-ascii?Q?8GYr/7g9eiC4ty5qa3VL9fvA+aTaKWfqHU+wN1C9qYXu9YDR4eFG0E1GfJtI?=
 =?us-ascii?Q?nnJfwm02SmjoCQAfV/bXWu5mBUTpDBPN7WjqHZ0sVZGKSubR0RuUFMnqQomo?=
 =?us-ascii?Q?nGNYlF8hQsmdrohj/YmcrjQa3g7aPx4kaQpSWR6BWsGoCrsuANK2FXFTZOjJ?=
 =?us-ascii?Q?yrQZkIaRsTE1RhOwc4Jd6LzrRxgH05CeX6YSttncAEB4ie4J8Tvdg0LKe8q0?=
 =?us-ascii?Q?MXOUHkvDN91Y9qyPzMtRokqecgHbWqYYoN0y6MbmvvL0W3u1teAFzvnBz6QQ?=
 =?us-ascii?Q?1CTDmx72iH4Vcp/HJ8owL9bK0v4Yc/vcsbuFmZd85iLiLtAthG9Ak5CQN+s0?=
 =?us-ascii?Q?4ZR/y/uXo5qnf49vIVBFWz2xKdqHWXJw90vXk7avcA8UzsrtucA8/jiV0iHs?=
 =?us-ascii?Q?EPDI5jJlyMiMlt+y1g1qWb6oTgRsT6R5Tk3xbqH9eVJtVFNI8MjZQ6VXO9HG?=
 =?us-ascii?Q?fSpj8vVWB93bA3jMnIFz+h+8QQ1H70mNI44ZlL+oB4kCti3eIfkSHIW05bWh?=
 =?us-ascii?Q?ykcaWAuvvaSo5F7R1ghzvxgJFMY/2C7WfnjzqtL0PgTfBI6hfz2/OohILpRR?=
 =?us-ascii?Q?MyR98nWLrVJu1wkeKkiwFONGI2s6k3nx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBP8vSCkqA9b/cA7v3NxCbQNVkDBnwfKg/8dxrOFYwjHD8Dhh3jYJR7Dtlp3?=
 =?us-ascii?Q?BH0vSB3nohlanaHisv24qZybpUvAlOv9O+1tNMcYc6DTnRclgJG+ecuQYFDa?=
 =?us-ascii?Q?oEED5RwW0jQPcP1J3YB4T92T4oIsXRPVSokykowvvva/A7LVJy74Guem7aoO?=
 =?us-ascii?Q?aiBwt3+Yl+RBlcWFxJa013uvPl5wgYlb6rVQiv6PVo14SPldu5v07yT8SLlt?=
 =?us-ascii?Q?YcdHYOzM0l/GO5YXeCruHmUyDgUAgpCjn+nDziNRjuUS3rXJr+Dwo5XQegiF?=
 =?us-ascii?Q?KywSs9aFXI8Twhx+S3D5TfHxxCSzVyDC9Y942wjQgEAs+WaB/fMhVoxO9t7q?=
 =?us-ascii?Q?ajjjbZj2p6UrO58h/vM9iJZ7Uumfe34tJwc0k6GU7sSeUugFnjwEPZXd6Tml?=
 =?us-ascii?Q?yI7tLWoUiu5i9chBhxVIklqFKtbw1nZGH5H6w/jD+wdoIJRX63rhE3HBKNVq?=
 =?us-ascii?Q?iN6z9DR0MXrIRUuYomGtNNa9q25/p+ZB14Z7LvphTOp//NK6EvuZ7k/M7qAG?=
 =?us-ascii?Q?M3cUw1mA1WHi7bGO2xF0MuQ36+5BbooyChmvNwm3KeIAxSFj/Kt6DAhAv44Y?=
 =?us-ascii?Q?QCKtzXJ7xhIdv1vhs84j9e3ta6IsrDfW0EwYL5oJ6I0WWt1bZvN/0WbRnDvn?=
 =?us-ascii?Q?OqVNbtWsEUL1W+ot/4UI4IkSdiqRCh7Dra/TENusfphBT+WCiwP5SUT32CEo?=
 =?us-ascii?Q?nWu4N3mBTpy3i1njLJnCvdBIQkIZ8YbyQEacwW808tvZiCXxwhRx9B9x6bnW?=
 =?us-ascii?Q?c76l6FzZugjwdp9qTDo3Nb2YRW9TSUHy7jEsGQU3U4XHKRQZa24jP9RBURPl?=
 =?us-ascii?Q?6tLqIm0HA6229JCIvOrW064t8+VVcLC+bi41t5GM7BKHE4JPft4IsKzf+0oM?=
 =?us-ascii?Q?iu5yItZH1sa7V8NC0Tmrjve3fxgsC9+1efFneJnqFvThqxKtyevY/gjAv1qd?=
 =?us-ascii?Q?lexaHV0litj31MH00+TsE4Uth+vgzCQUih2PPIVAsm6GUvESpDxg5eM7O2qg?=
 =?us-ascii?Q?5ci77qM0LDRENvsdE96iVBvCJn5UCSS+bPRPBTsnxLP7KMi1BN14cCRtRShW?=
 =?us-ascii?Q?cvfiN7zCDL/pCoxNbuzbfLA9aVhs8eUlmZq9qH54lKEnYcFUpFlcs0yx5rQj?=
 =?us-ascii?Q?C7xvT3YAvWQd6JFYl2n8aBwxBSN/YgdJAdjSASB9ebVGphCVb13/hKqoG4ok?=
 =?us-ascii?Q?EEf8K8J8gbc4IYHioqNCY54Y6aveJ8Ytq7OP9oO1CnzwxDAWnQtTDjTlnxiX?=
 =?us-ascii?Q?9szRwxuqYQgUlBwzTUwVOQwSeuF/koyRb+3cqhswp7KoLnoJlzyVRmEvIjkR?=
 =?us-ascii?Q?Sa0ItS1Sq0jEx7WtjnSdLNsUwouTRkUOVhtjp34iT9qIQaReeDPQh4EK4VCU?=
 =?us-ascii?Q?3G9FuXvL9WcJVIHb0egt8wc7bNpa2V8gUi0Ahc1IcRhPBKWdgjirTeY1Vykp?=
 =?us-ascii?Q?Sh5aRLk2w2abb0zaMeLUmho2pmKOQBj1WFd/nE45E1K3qaX5JP58OfuIGvVD?=
 =?us-ascii?Q?/b9Y26yFffZuMN+sj5Tk2RJWv3MRePjRwH0moefkZ5ZAOCWoM8NfVPzZv30K?=
 =?us-ascii?Q?ZU9OJC/6SsMEXu6h5BaoogtA8psfFndH7Yy6qJ/KgsC1JqDXRb1NjGhrmcRJ?=
 =?us-ascii?Q?F17Gqh6cA1lXu2zbI19Wft99YL7Ymvo8LZCkXLJrxNvq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7736f8c9-ce78-4344-aab6-08dd65d20be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 04:04:57.3043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /FBFhYGX3r8gI2FFfV9hicQwxIL0pkk5F0vkie33JsaOShHWlpWpt6qhRmP7JuIiLY1jp0P2lJFyICTVdkO14HMHhJsK2GJSx2cuhjkCyR8=
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
> Subject: Re: [resend v2 12/13] configs: sandbox_defconfig: Enable configs=
 for
> sandbox i3c
>=20
> On Fri, Mar 14, 2025 at 12:09:01PM +0800, dinesh.maniyam@altera.com wrote=
:
>=20
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Enable configs for sandbox i3c.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> > ---
> >  configs/sandbox_defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> > index 861a1f4cd90..d3617da8792 100644
> > --- a/configs/sandbox_defconfig
> > +++ b/configs/sandbox_defconfig
> > @@ -364,3 +364,6 @@ CONFIG_TEST_FDTDEC=3Dy  CONFIG_UNIT_TEST=3Dy
> > CONFIG_UT_TIME=3Dy  CONFIG_UT_DM=3Dy
> > +CONFIG_I3C=3Dy
> > +CONFIG_I3C_SANDBOX=3Dy
> > +CONFIG_CMD_I3C=3Dy
>=20
> In both config patches, you need to use "savedefconfig" when adding optio=
ns, not
> just adding to the end of the file.
>=20
> --
> Tom

Noted.
I will take note of this and will rework the commit.
Thanks.

Dinesh

