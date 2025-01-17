Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BAFC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 03:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EEE80312;
	Fri, 17 Jan 2025 04:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="T4JRiYhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42EC80312; Fri, 17 Jan 2025 04:22:11 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B38801B0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 04:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jc1jA6HhbJZC9YGalWlC1DAOqEdWmHi2b50x8+I1vm//sR02T1CIL3NPGoBSyjUjy1LLHZ0Nyoy5XdAbLyDf1i55Z8T6n9jH/2J9mgrx8dndNKfOTQXR507O82Yc0t6vTBZYfepi69kFtwhix21A7q6CeZTwlRPIodo9bLLFzxDZRRfnfuQI/prpfVFF/kzS11DUn1J8Eno17lckaVeQ8g0suOc/MP/qgMIOuemzAC3v/PyvJW43T7TXcANYNQ8z2cTHCMZruOlk9i+pQpqGlllIxH0DefpsyLB4/dr2rVbq0ix/t0b79J+8l9cdmhXtrdwqIQbPbYQWW1l1FKwkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+mOqeBFF068wYouuzQ2fbAM75KM/l6tAbEAEmNKGqI=;
 b=bcEPf0FWJJaZL/mJ29N0teoETCYqmbgYyfZPGRjqSQ1tltH7dveJcl0mrLbC+Aka68l4vtqo3mOqIyXyCp7Ufa0eNOioPmptIwxSY2gSbsU33orO/Z1jXKosRoScRq6nfhxe9cF1Cc5rI1gLhWpZUYOpRYHV8ULaqoEyJBj+zgMRSp/BSwfCT8EnD7hZ6ImWsq+NhY3aLbcuWjtAT3RzTd8c8xcQuptDEO6XEM9NTLxbxlKF/eyFOHI8S9XLgkcjDhLjcfR3P986S5EeAizp/KKyXS8Uf5OIl1iMt6Fb4mBqZYthBdzx/CW50kWODf6S2Mgb2LANJOloMuYFhS4v/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+mOqeBFF068wYouuzQ2fbAM75KM/l6tAbEAEmNKGqI=;
 b=T4JRiYhQO5rJRQiw4qpFOHFQg95Ns9ot0N2qBgux8/ivr+YIzWA9psGawcLrvuXI1AJrrtTfos27CWseHmMhpijt9WgcI8Q5KlpsZ0c3yATI4hgpBGw+nYEbdN3gcS0cHLROHrTOFsy7FNY0jTgLUVjUu50FXLmd9ol5stebB07/OYftcSzL21R8VY/gJDCY9oe9q3pufkcSrn1XD1bZ9g1MrrF6eR4u5wonJx/mxomd3vI4B+GpmPb7duHIvnrsVz/SVAfTDmqWzN1KIUIykq5/GNprssctqK8V8RNgNdaYceGCstj79OEYFq4q8XlQmgXxY04ay1e+cgNf4eO/qw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 03:22:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 03:22:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jesse Taube <mr.bossman075@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Giulio
 Benetti <giulio.benetti@benettiengineering.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, Sean Anderson
 <seanga2@gmail.com>
Subject: RE: [PATCH] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
Thread-Topic: [PATCH] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
Thread-Index: AQHbaIv6+N9e1s3SyUKtJyRT1OeJvbMaTJKw
Date: Fri, 17 Jan 2025 03:22:08 +0000
Message-ID: <PAXPR04MB8459F5D8C54A1C406D408036881B2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250117030027.3874367-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250117030027.3874367-1-Mr.Bossman075@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB9415:EE_
x-ms-office365-filtering-correlation-id: 8ef2aadb-5984-4ac8-0245-08dd36a61fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?aoGXKhPp4/RuYZbUoXPsE6/XNIDjMTq5+8ao7Ttt6XyYc97oedlqSxq7dh9J?=
 =?us-ascii?Q?NJ81+PFx4dJ0xvfjh1BhNMmCPEffjiulv8COuaDUDiFuHNBFZ5NWWPOn2Qfo?=
 =?us-ascii?Q?M9YR/v5Y4dPVy2CmKAViS7RJS0tjq5eItYVMiNmrYH9fCc72C1kAG34HqYu8?=
 =?us-ascii?Q?6Bl0rBaD4QElqDKZEJ8Yln3H1E87wycKZcxqxBBYIXFVzs9CDMjAE+/dX0yN?=
 =?us-ascii?Q?BblVOliWYVwyUPGv6XdzH7VI0Tne7BN+AOlvrXYvyuzEyY5mC+u3JdFKb0PR?=
 =?us-ascii?Q?XW94ckq/tD7zPeYVkwWa/MF1U0HEk7f6fE/m8eP6H48F4O3tW8xiHw4kSUdP?=
 =?us-ascii?Q?M33FhILyirVdm9mVtqSuIaqUb1Ln7pU0xc7uM9K9xMYUHmMVY1YLJ8fAXWxC?=
 =?us-ascii?Q?IA14uOOfaY4aoCrnsyjMJdTV/FEgud2KYl3BS9wFmHNxZyXOWbEfbSgbfxpa?=
 =?us-ascii?Q?7LW1gYOtL8z5MlMAs8A22SfMhWZgFuDlFKxgfQU2NTJTdsZC9aAOtjaAicgg?=
 =?us-ascii?Q?jiwMsGXRk+avBO3DRGsRZRx2uDmBt/WaqNfWzqFaawXkljxf/tiUtgv/fAym?=
 =?us-ascii?Q?0eKTCZ0p0f7NO4+2NUpZyb+CmkCvdOjS2WlcPd6SRIeTAeChSgnE1gvLDV5s?=
 =?us-ascii?Q?qQ/1byXMGzdJj89V6oaFdIvAzdXKcBw2oyCVv5uupVm6BllH70bzadx5TLNf?=
 =?us-ascii?Q?nCKPHJixozLtELCi1pmrXmIc7uxulUHtnQEL7vYYI/gVaFAo4Ez0IZPUXqFp?=
 =?us-ascii?Q?e6rWhGqWeh6Polx7f5L3RIIr92YnSmucEdEj7WUGMK5IlA9mANyftKYmlhlW?=
 =?us-ascii?Q?wTpv+oO3XAsDu2U5lMjprVZBG6fGErgWT5n81NHqdRO9a88HuyegwcnmTI2E?=
 =?us-ascii?Q?wds5POTCrlxWzQl8P44Y+lzGbt13z/wJrgmh8aY/PKdkWLVzRznqMNasGjh0?=
 =?us-ascii?Q?s7/KXZ52xRrVryUA+xblDYMrRtiRz7Fo2QYpqS8wGoo1Sssdpmj/jaumltWA?=
 =?us-ascii?Q?zDl1htMDkyHIiinref3CFgZf0p5Ifs7ih0hM32zZpR8OkmyT213dp1OVndm5?=
 =?us-ascii?Q?uAb0KQV/u4+k7e1Yp9aD5jK+OWXVYOUqUOVUo64lebiEl0HsndVDmfbp9hLI?=
 =?us-ascii?Q?vqHy3/q96ORyjYx7ZUI20yE0ckYK0+p2584pAXrp5zmTszcFM89Dk2JqzdsK?=
 =?us-ascii?Q?XcbCaLCze07GhqMA8iaVXq5evfjexjSHcwNXoGqr4DisuznjhMQYMIJBng+m?=
 =?us-ascii?Q?TxYSHkzK15eF80LZMxPgt3qQYcwrdiyRxUIfNDAhsag7cC3pZuxQ/lbJJqx6?=
 =?us-ascii?Q?xa5rBxs/cd31fc5XKTcKh4RXIMXW4RCKTPMfso36lwfizS8ssLF6rlHaLe29?=
 =?us-ascii?Q?fh4uMZ24jgPULfMY48WAze2ty2CGpav+tzkuUN8lRDBbl3833+AoPSXMXTcB?=
 =?us-ascii?Q?g2jKez7Cj60p8lvj+41mPOJQOe1bSyFH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JbQAf5Sqm9MV8B993hTEzbu/xGsN6V52ubyziXUnQLdA50AAQMssHw2zEheg?=
 =?us-ascii?Q?MQ6tRS5RISlOoEc5VHo8QWVJjSKnb5BD/ftcFgRVj36LT5g1DBQDOupGwFoU?=
 =?us-ascii?Q?1oaxakJCxNfl70fB1hlvQ594EwYl5Ao0m6rq6a2Bm2x3n+nVAjX7+wfPO7ek?=
 =?us-ascii?Q?1w5z9OjA5sUvsM/fcRKB94gawTfEl/Gd5eY1Mcv1piqU42hQoGU+QbjYSIZk?=
 =?us-ascii?Q?zrX5IHVzngPLFjuJReBI5HL4Rw/i7eZXPX4Euh9C49mSnahwV/ewtKG6YtQp?=
 =?us-ascii?Q?4QracJ/5gXsUT0R/pfHYfPeCt7MF1sAzZTHqTXplJL00Nv8K16CryILriGny?=
 =?us-ascii?Q?rmpWaPc/EjtKcvkIQbwcgbKQHze0gAeppdxazuypE6X4FT5sxhbaqmo4SUlm?=
 =?us-ascii?Q?sJ4Gv5/vDpEd5JpU3tcE07swKvL4/gtY3cS3ejiw13zoaRQ5PawzFdgmHUiV?=
 =?us-ascii?Q?T1bsVHKDzC8rdHmWmK6eo8VbmNZnElr4wFVrgZQc51GnOPTCOF5FBnmmzAO8?=
 =?us-ascii?Q?gMPpXWK6N2m8EVXxObgnV1gkB4/tMi4Dv0C9dBC596FzwxzxOjsv5XeydJ8d?=
 =?us-ascii?Q?AOyTXbaF0xZ3S9Xijd2ZrW6uZE0CAqC5DK57oYccxIX+5bSmKcUTgwRie8p/?=
 =?us-ascii?Q?fI6IyEeBmpsj9INrwM8tn+o2qaGDkxbO3Ss0QeSTCswQ21vmaJlu543p3IV/?=
 =?us-ascii?Q?Pc8svSDWToBEQQSn5gOo+/zKATPIyusvO9vgo01FGc+rP/h314so0fmJX7KD?=
 =?us-ascii?Q?lOhSliyQ1cuj1LeegC05558FxJ2suQlkCFgcMTAEA4LPUA1EiQsYWhECfYcm?=
 =?us-ascii?Q?bhda0OzgfjOAprroBILGlxXEQd5kG68ox8WGhMJyKJr1sIUNhWVZXRj+g23D?=
 =?us-ascii?Q?k5cgji3q6KAnBrH586frN45T7OXTzZNECVxkmykcv2OODvN5+lu9uVq9adca?=
 =?us-ascii?Q?bPKRzg+YVNwKv4oG3+bJWROPeqKUbew+SkjBkJC8hRjnTPZ86tl7jDcO/srG?=
 =?us-ascii?Q?JYV8qLO9tGJ2xYWVtBI+24PIXUIiI6+H2fAGeNIIAgy+n6G5acEDzlf2qMAH?=
 =?us-ascii?Q?KZvUvXE5zkFqpJ09JW6sndNJGg9WYsJ1MV5Tf0V9700HfJTI6srrojuAjEoV?=
 =?us-ascii?Q?SYgHtWNevtlI+PRwFUpOSS7qm+93riAw/FNY97eTztDB5hFAiA6TURV0u4oa?=
 =?us-ascii?Q?QZxeoBeFmKp0IC+Mh9QMz2a4MbFWUCiy5R0wRzlbv9QJgraKTd3dizzTG3Bw?=
 =?us-ascii?Q?unC2qekRpVZWUu7abxJrHa6gzaW7RZ18GvIFAWXgwDUdh5nVlX8PhD+t9ewy?=
 =?us-ascii?Q?qTgNIHiYpw2MU9nKEtkIzN/gK6d3hQCVUAGL3ZvH5qF702Mn5vWnkwrzBI2x?=
 =?us-ascii?Q?yZz4N4gmAqUn6Mo24jrRqhQbHOaaX079WKXQlBL5V2Ea0/0MxvcMvPyf48ae?=
 =?us-ascii?Q?sbKLJzJLY7Ety/sciLeupiAA6Z79IGTs4rYCs1ItwtbJ0n5SSw3kal7u2Thz?=
 =?us-ascii?Q?Q9jMM5rQeHhY5L0EnAUYtX57zlzHJfjheQvQS2Dw1uuK+hBAkgHKCZrTGzNg?=
 =?us-ascii?Q?ZRaeJp/jxRpEYsd+ahc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef2aadb-5984-4ac8-0245-08dd36a61fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 03:22:08.0583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeseiRCGo/QxPpgrNClJMb8U8M44PYHSF8UoDE43PN5VTkDxGSIOLqpgnFE4ZhSNGSXqFFDKMhkdR/l4ZOgE5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415
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

> Subject: [PATCH] ARM: dts: imxrt1050: Migrate to OF_UPSTREAM
>=20
> The device tree for imxrt1050 is now
> available in the /dts/upstream directory.
> Migrate board to use OF_UPSTREAM.
>=20
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> Please note /dts/upstream still needs to be updated
> the upstream commit is
> 5f122030061db3e5d2bddd9cf5c583deaa6c54ff

You might need to update the dts/upstream to make
this patch in.

Regards
Peng


