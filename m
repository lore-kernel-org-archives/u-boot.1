Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73967E7717D
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 01:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A85E801DB;
	Thu, 12 Dec 2024 02:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="oK9s37Ys";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA30801DB; Thu, 12 Dec 2024 02:04:21 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A79D801B6
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:04:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlAeSwXEu7Zsjh7t+3fMIjgO2uYhRK/g45QeZEFHd36AKjrfjT/VUR2a1KgtipAQRSnrEo4yAyDxzt+i3nK32M14ITbS9ChSPCIAzQ9HlglQ27FODCQrPb0xaKYI+zwAMvUw63SchMPrBs7bfmtoaClMJ+Sr0BQQHuF2GNW6h9/OGhoP5tP2bWbXZe/DYR4g+yXklKIpZdbNmX+6bTAywEQiFsCZAfKFRs8D5gxE+KbL3DzsqNVXE3/eATkpWHlsLlFfrhTNpoxKICp2kAvgDVHXff0433Xp4wTRuIfpjV5hsz+yKeUfOawWrtHmXUfF1Ml+P06LGfG1mg2LKHaLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7kUNOqP08rQ/1MditFNP023We63Ap2mjJaCypa2zt8=;
 b=gU3m4ruhbo4SwdnBcGOdZMkOTne2D7hEpIkYIgzHYRS/bBzuCWTtQX165msj3bgBuCypzb1OwDqeflWHpQNc8BM3/PKKCbrYhPKOvJaj8AEDp2PYN/4s7SlQBFvDkB3p5pEPd2niioSlvy9MOFMkKK+nsMqwCIObDtQODyTK/1aPk+ciLA/wMFL3BJvcWVncSag4z90LZFZlW4FWL6F3FtiEd0Q8FTj7hSS8mu9UJ4Koki+Xck0wtGXfso3//ABv9Ugg86X4unh8gz5UgLsiOUKZz/q1J8NFAexOFo8tZtojnvrBBsU69UCaVju4/GlCXiZSQu96brJPe8cXDUnQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7kUNOqP08rQ/1MditFNP023We63Ap2mjJaCypa2zt8=;
 b=oK9s37YsQ1bVURcVGxJEQIBxMN78934VCRDP4RhIvyQOzhLCpBfsnSnnT86S9fMLd6yVL4IB8NhbzVpNoSwZSyo7weznRfI1nFggctuyCYY7AUInQA4Kh6v1OOfrbE2xmL1s4HTAwW186rnwtKAzy6R2891ayyoP3lpd46iDMo+Xfp8qeI2OX3cnyM/7cr+rXGNZd+y8TrQ9cPkAw4MEXswjbkujjXmmV+qMbSNGsDk4TcvMlMMmRnFIsQrx2/UD8J9+bDu1LG8aMW/ygr0NJ2NuKfvtTkT6eVfiQ3KnxUZNg2uviXYlq/9sw6ZZDUf0Eb95/DeF3suGLGsOF3qbhQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 01:04:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 01:04:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Ashish Kumar <Ashish.Kumar@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jason Liu <jason.hui.liu@nxp.com>, Emanuele
 Ghidoli <emanuele.ghidoli@toradex.com>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/3] board: freescale: typo volatge
Thread-Topic: [PATCH 1/3] board: freescale: typo volatge
Thread-Index: AQHbS+o2za8AQ/Yaz0iIeWkIpuXR2bLhy49A
Date: Thu, 12 Dec 2024 01:04:17 +0000
Message-ID: <PAXPR04MB84599177340E090AAD1EFCE1883F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241211163154.56272-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7913:EE_
x-ms-office365-filtering-correlation-id: 6e53afab-9d43-4566-a467-08dd1a48e70a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Tn3muvlJvWU9pe1DzaRHezyD4o/Z9Mo0Aub5svnn7xu/J2O0tBl7k0koScyW?=
 =?us-ascii?Q?KeEjuZ3JUIGIsZkgKbk7V6o3RM81wZiykr9iBrsbZDHyzZZjOChtqy1N5xyZ?=
 =?us-ascii?Q?S6DxnRK0VSzYdhCsCTIzSIBJAPdkAt4sDZbmMyUZbZwzTKBcmIErKuPil0xC?=
 =?us-ascii?Q?OOLAPRus/0+tZEFkMEJ39MvK3wTlJKwymJ1B6HhEwA9W1G310bXdBl5mKC48?=
 =?us-ascii?Q?2dJ3jO/ukdS5vEM3yjS9dW9SDutkIZwUYpnI+HZRD0/Ee5DjzYljw7aI2Q+i?=
 =?us-ascii?Q?16T6h+es4spn2saAWa6EBAewPUvkGecU9b/figPFOlxdgD4B4CK/kKn2yNM0?=
 =?us-ascii?Q?0wkuQWlQMOvXABHDF8N9J8QX5LV/LtMzYLIrn/Et0oaKgR5HnKNKqzNXc5hK?=
 =?us-ascii?Q?yxJ5QGDaT8DxJYkQgiZ6Fau5QUM7uF2ZU3x5KizN+p4r4W6q7j4NSTkL7LJ+?=
 =?us-ascii?Q?NU3ofCzrAvXJoHeesXkO7F1fyXoCCEfctsaQ9V+9ujero3c/cDzBwHIB6uk4?=
 =?us-ascii?Q?53IcP5DZvJg7rslkGjaU1Rxhp0sHBFfmk/u71CVEODEdFMFqcz+ZFXPgqakk?=
 =?us-ascii?Q?p+AQiJu9Aomi+PGAy6ntKirFB2D3tKt9z/lUhLhBO/L/DhffnGM4Ok7kvBjt?=
 =?us-ascii?Q?gNxhxScD5POoqS8oGkJ3XPB2b4ZMNY/U0ZH2M15PuePMda6lXWtWOgiZib4B?=
 =?us-ascii?Q?Fl6/R35H1xrlAbIKW1CFoSWvHOMPb8jX+jSs2Jk/feoXsL6w+GfPVhO7TE+P?=
 =?us-ascii?Q?LOxuiI1VuHwTa0di9oko2cfmgBAUoPQ7M0KvEqZH+2XUC4M1eWBzr8/MxtaH?=
 =?us-ascii?Q?USM9MO7+l92MK5iGSQA3RZA4NFscAyS/8ZtwNRaq5Ebm8gbhVOlzLhQzbW9e?=
 =?us-ascii?Q?z7SxxL1pn14+NPV9fW+GCCdtlvriCtO2cQlbNOpZ3Gt9Yw3fhqhckmqnOjh3?=
 =?us-ascii?Q?epXXce+5gMMUgWsfnj1vozoaABNHZsdwVKXGPLPseT3uo0crwsnuuCAkxv2N?=
 =?us-ascii?Q?7CmJTINvi5rTsfrUE0xvlmLGMCMa9ZyQohzzEfozjbZUpG1+qOu62BIKyYvX?=
 =?us-ascii?Q?4zJGidH5qmMj+zwIMs4CHZJsOxRMQXgIPQ+oaoDS2sCgEXiN8CJRIe7j5Q63?=
 =?us-ascii?Q?au1Sf3+XZh9wxBlHrnxg+Yb1vhK2vfF9Ub68iof2wV/5YgSHxL0386GhbxCB?=
 =?us-ascii?Q?e4R1mWJZImU95Cij2qcZQwxBJ7aytMVRpzxEuZqaJSq7WWn7akEL/7raLR/S?=
 =?us-ascii?Q?6ofJXJhg3xX4uNGss3eZpoKjeFs9NembmIDCWxnC7Q56hNqnAb6xvUlz4c8C?=
 =?us-ascii?Q?mKuyE5c9ALgDyTBGsOEus1ZfNTqEuPuewqN+xZKAVVi+q4iQzN1nnyylaaif?=
 =?us-ascii?Q?SkuF32n06cD+JoR5UvbTR0OuVuIhktjLxBUHjAgJigkR9dkPzA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NHJ/qwy8qN/kd99seQ34ghCJ6Nwk/ss1GRqy3RC5XPueKNTU0Zwn0ciM9vvO?=
 =?us-ascii?Q?IX0Dwcvq/4MsSjXvkyDDvxUyu5rm8OtFeQpOj9gkem1b3RZd4hWcC7haHALm?=
 =?us-ascii?Q?HblglBW6PTLI3F5/NKXFw1BRQfJkkkS102eIDbnUtGE+MvSasc6bUPNIyrwC?=
 =?us-ascii?Q?hFrUnnSL+Wy9A+RdJgVgS6HzMilMJLJtywnWeEQ6g2+HE+Hz4xiIsp7YvD23?=
 =?us-ascii?Q?83mNu/kXREqVFaHfL0Bfk1iDu2UybXVb8AuJM0ymMbtaxQfqwbhwEY3heRNO?=
 =?us-ascii?Q?lLk+AhuoDtgeIFF/qMV7Q132Y1LGHbcE4KrdQyHi2YAalMnuKiwzh6nC6oTQ?=
 =?us-ascii?Q?dSGRw3bWkvk00nh5Mjhbls767PpTfDqxZrXc11it04IViyPrDb/YGsFHx1kl?=
 =?us-ascii?Q?jzIAd6C9wx5FyE7s5EV3tnEa+l6K4IXqrY1Jxxnd86rr/+b2I7zLpUEM8qnw?=
 =?us-ascii?Q?Rm7fSb4JAYM+NDr0OW2kKfipCEh6LCKsVcC0a08v7pjhZgygwetZU9Rd5/DV?=
 =?us-ascii?Q?ukMddVp7jJCCkzrk9lV1TaIqJnuDx/ZCX+J2k75//cdANGMSdMgByho0gG02?=
 =?us-ascii?Q?Pe8dRkm5VlIgLhk6+Sxz0I8XS9fHdoNoQvaBWV4biv6cX9EUX53SzrGeG+kl?=
 =?us-ascii?Q?fbtrPLd16rHNuFoG+UFRahouNByQVMiEGWdEnqmKbgSRHCeAWHF79IOJdHrl?=
 =?us-ascii?Q?urWY39zG0+dr6djDo8FQ2+540H0gmORMTBXAYOoXinh+5VFX5n/hxYfl0sTQ?=
 =?us-ascii?Q?8JRw4l9i86k9csNHUO9ay1ayQKXByW3XNukJ5JCdPRr8l44Eaqrrc4d7Qiaa?=
 =?us-ascii?Q?b0GTTH87qwXnnjYrOPaZ5BSf315CSFYtZ/ltIobR3pVrh45Q2kTkMdzLmFQG?=
 =?us-ascii?Q?FpZ4mwwX1MaEopkSvLPAalFuTNGkmXq7PrF9csJe3fZJVqTyReL/A3J+HpBq?=
 =?us-ascii?Q?mihinsZlU+7pSw/xRxKVjMYVCWWFgMKdDgy8Hf2GAlPGHV38jMmxkU9cHUGe?=
 =?us-ascii?Q?yStQa33b07jW6VZEMK+aFK386WqL9I3/EwEI248vyY/M598NlgGzGeNBxw1h?=
 =?us-ascii?Q?bxb0cAD/hVSTM1ew+U1OflyQYiHhJnX0ZlFUSELKOi8cGnLx1wlk32SwE0m4?=
 =?us-ascii?Q?eYikCG2j98p0osD61IAfCxPGvgE6nQ1+5IDnc9CGOernbGYoQPzTtmuIWb1w?=
 =?us-ascii?Q?rLwrXqpbvwR/z3UEiDzUpsCMZxS+HMezScqBjhdE2ctGkRKvqqka+rCtFglQ?=
 =?us-ascii?Q?AkxpkvXZ7jvzKM4YzS32Ss+lmAmDmuIW99E9RBm5euRxid46a2qj1n6tHQof?=
 =?us-ascii?Q?TjkIomN3+VAC88lJYPkLFib+ypSbsm2id4JzqH+Q16Q6AsyxAzUe1gYtMI9Z?=
 =?us-ascii?Q?d0Ppasbz/hTqSAk83YSTmxC9vqAvM1kiDMEQ70N0Di7bJAdYu6fLgYO6yl98?=
 =?us-ascii?Q?CZbNIrZWCR4LXIcmWIKjD/z3mf9v5ej8PeM3VtzPKcMrdi/LobcXWNm2G742?=
 =?us-ascii?Q?w9NmPL6a25KnKe5KFt2p77H/mCOQCDVdqdQ/EXJNRXy99gETUolMgYzp5llr?=
 =?us-ascii?Q?gLQ4c1jXs5nTLH6Mz3E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e53afab-9d43-4566-a467-08dd1a48e70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 01:04:17.2170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfbReAEL/q/tanQLw1pu7Cv7Q0ayoSyOZukWj2Y4asVD2Dd7huUICp8zL3GEVbUh967Lz+GiWsYl3EzKFzdtXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
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

> Subject: [PATCH 1/3] board: freescale: typo volatge
>=20
> %s/volatge/voltage/g
>=20
> Signed-off-by: Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>

Acked-by: Peng Fan <peng.fan@nxp.com>

