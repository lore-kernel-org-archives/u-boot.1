Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAF2CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 04:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EEA839A8;
	Tue,  9 Jun 2026 06:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mQMYUY0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59FFD841C2; Tue,  9 Jun 2026 06:31:14 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8A080087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 06:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMaOUF8ZnmeqHQKI6/ziNp74vgeCLXx45kidMq5AaCnv52YvLqjSEEJYT20ZXKyN7A9XOqJyO/OYHTwxXhEFviAHcbiQHQDR9iU7NJeR9h28aZnuB9svzvFVq3mvrRugBqNCn1OO3bNlTtKXxq8XwJ7guXf84FyR1UVQV1bJ7w8l0M7eIsfNCkkt2N069lgD6C33i3goDvswyvhlV/a14RkgsobgxB/xviWMmgMDJKgBEzsA+ASEuQCYzhSm52/ZYkhrGdO74PNCocjotUMlbUXRR1UOwrnvZFdClit20VUI0zMECXha47sDyBHztlNTx5SYItYXLgdXawbbpQ78og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIelTkt4lWMYx0rxs+YK6Q2PSOzqWDICENVgvOUZHGI=;
 b=m8ECtF6bqlEzIkdjF9JUB8xtoakRDoHYj7lrsBlDE3+O+Ei5N+iTU1GdMf+wLcQZhf4ssdLTeV2pmfFPPjsOBzG2XrdpfMBxXiBf7cqlKUJqxpuZbgKcXNF3fnc4MP8vT7j7VOB+nHhzgC8U0wCL+Mjpxkrl00UgtlQy1meIHQWapI8Ip9l4iubYK30OPXQV3OOF7iCL1XimVTOcz2bthvAmYA9gfs9IE9AFIksvzTBSpGTSqHu290ocUWrG/TQZcONreNq7sFj64x4gc8Zv8hgDQFcjtUGJbqa1cMFEQU7Jp+PhgHyW/C1G9KvtTsc53yNUG6VQktoo/JsgtTEK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIelTkt4lWMYx0rxs+YK6Q2PSOzqWDICENVgvOUZHGI=;
 b=mQMYUY0mIDREsP62IzrXtTAxaidW5ZHe03mxR10CnRfvZxdA918/Mi6A+/to6v/81rJ5wyBR6uSaDY10zmYZ6TIugznaVkQE2OclCmKg1gUPm3oAUTLhmfvPBF+i8pPb/6gp7+Tf5ofz03xRLqgMAsrII/z2ODtQkzbV3R0Og0hOk8blOOqopSKPshiHnIkh4gdvT1VGivTOc+OI5WuqYvEQMNfdUI5h6pKSax2X+27a6hBXDiwUszvHIZIVm/yw1me19+6BWh1TtVqLA0DSncUCv7ejdSvzIhEF1I7HOtwAocla48bay/J0+xd4fVkNYVphDX/7ByI/8NejINeZjg==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DBBPR04MB7563.eurprd04.prod.outlook.com (2603:10a6:10:206::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 04:31:09 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 04:31:08 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>,
 "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>
Subject: RE: [PATCH] power: domain: scmi: Allow failure in getting power
 domain attribute
Thread-Topic: [PATCH] power: domain: scmi: Allow failure in getting power
 domain attribute
Thread-Index: AQHc98NmzVhu2VydWEWiB8ytw88kY7Y1ofKw
Date: Tue, 9 Jun 2026 04:31:08 +0000
Message-ID: <MRWPR04MB1233065DBC62A6A0537D49D0B881D2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260609035432.2011926-1-ye.li@nxp.com>
In-Reply-To: <20260609035432.2011926-1-ye.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|DBBPR04MB7563:EE_
x-ms-office365-filtering-correlation-id: 75777d82-6174-49a1-ac28-08dec5dfeda2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|56012099006|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: FUK44m+qNZgymtAtxBL04mniude9PwBZt1Ul+CtSoFp4shghgIa1Q0kU1cD7bvjcB7RHtFCAOdUjAWRJG3RowY1+ORQtHXKnzwzxxihcFXPjQvl7g3+Js/pYhCkqGEimzJv9c5bwZHzGkf8DlfgA4rPP6O0bl5CBTlwuCi0GmFZOl3j50C77NkbUaVWSe/u9yytzKClvNdSOMUYBcprW1Uq3HoyKnhXp7etK+7h0NWtcAWKULwvh4MG4Hl33fcq+f8HsVWvhe9q0AENdGrmDA/ey9+mbEdIgzirQ4B2qA5NOAfEVh9zfcV8dRksUNQkBVqOm6vzeyIdCFNKhAcoD+zXsVPXIuH4+aO70VdZXpfWOKcHJOnW8eSBJ72aorVdQofxxWO1CzV8sVsjqQjOc8XPS+qwnI9ELwY+PSRfrdAoTcw6FlEq4rnpUfnkQFqo4KWwemsj/RP0NYRzM+7bJz8q71knIPO0u6eYaJL5ywiZMbWYk6U4Btr8iSHeYbZvL8XBJTrqFlBJUxYbxhKQI8rHkDLyEjkVA3HrlY/7H94MHHWtIwYZ6PgXiJzpfolkY96IfjPdrra52w2FFZv2BSTx1W0975kPepZJeYvIdyFmvWjAsoIaBr7rrdrF0t16Q4B5xt9j74WBKua7a/3T3gh42GOERPNEfrxN9T7QYQPw1HTAMKZVfxeYxLUfXYXgDqcflrKyrM76lKRev7xbtHcS5dmRZMM5UNUK/BdfnjGIqPif08SkTKl9gSelRS82Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(56012099006)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4fElcFPR9aYEHz4otWFopTTQikb/7kW39gggs7ZjpsosGKOFyf3S6T8EzSV7?=
 =?us-ascii?Q?X/c6EdNHYkRZ2SJTtOepaNF6Xkft6uS/Zi+4rtZl+r8epI2nR2INm7HIAHG1?=
 =?us-ascii?Q?qdBADwGxo6DT6oyFQ/Mqq61zh+bifT/iLzBpME+CawaYLNN/o4IJVU59rycH?=
 =?us-ascii?Q?3FahUteCL9sMNcLlbDsK5aZTgtdJBIQtX4auryzwwOT/qoamKRB4DjVu8kvr?=
 =?us-ascii?Q?gwYKM/TvALCE1b/tfojgFHHPK4xC6ToU7BHYWQtIg8MxZG3IxS+2POxjRw60?=
 =?us-ascii?Q?9bkuqg3UkZnRpMJ2lhYigTeIdyBAx/JABC1L7msTgJQwrh4Hk1yQVe1hMU8O?=
 =?us-ascii?Q?Ol2wuCzDkjuOUoLd/p0monZZfO5diGTtNRpn8Ji0HnMuhvbofvOgW3/1GbLB?=
 =?us-ascii?Q?odJbHiypkTgpthtXRcCxcAkAtPrckCDbOry+obCnqktT4sSGZrLCmsjJTQRX?=
 =?us-ascii?Q?+ulzd7+yehRt+f7zADX31fgSw5XYV3rC4XYuws5FgHqn/WhSTFot11Bc4EFE?=
 =?us-ascii?Q?emar385flzRdRUMbrIt8G/LlQSS41qNOKKGwcfOh/10UGJDNXQurdRojVsOY?=
 =?us-ascii?Q?IfAJ8Y59vS9ZJ5wce0e6SVtUGCcWdIR7upR/eTE39kIrvUQ1Z1yZDv/CHvYR?=
 =?us-ascii?Q?b/j7Hf9S2OD4UBZHwJaZFM0QeAGqAAbHSts5mGNeEt7PPkpJ6jdSlIMLz+RC?=
 =?us-ascii?Q?jeb6y81bd3peGFMpUgrbEKj1Ne5j7PSXkQO75R5n46Cz8DAxg5G0M0RGg9Kd?=
 =?us-ascii?Q?uPJNxHRuK6iqzXLLL/B02DeEMwNBtcYmUwgnNnKsTuZS5oMmchP+pyirKl70?=
 =?us-ascii?Q?UFZ8dkmOuDvUQQDozGvBU1bfaTWX8Pm8MwOXDfJRq3t+ZH92LBkkkVEyMpsB?=
 =?us-ascii?Q?PLjv1K/bmBjJsXNu9bd7DplAG+f1w3NZVjO/Vyalnvy3b/XDhTfP6bxcJ8w8?=
 =?us-ascii?Q?pJ8+lC6UVytkbYqk8hrXveFN2wLmoAOHkFDCsrFzvnUFUlG08oUaUKAKOLyc?=
 =?us-ascii?Q?44mWYirpZZ/XF1dVe6diVQ2oddRZlsGDROr7aP3srR1BJ4Pc4CFfmzg/2gDy?=
 =?us-ascii?Q?aydU3aMJ7OldTeuFOrSx/m6nTlaqFRwDXCw1gsYaXA2oW7/wGIfApDjrFVAC?=
 =?us-ascii?Q?+1whieBSEux0VDIiGpoBhP2jHjSSS01956crbgnLsCYDJ7GppGNXF/Nnb1G/?=
 =?us-ascii?Q?8NSt4w6eu8XkLpRK4lfZGdS/7r1b0X6b+wHhBKEfG42+i67KPd9uON00h3+D?=
 =?us-ascii?Q?87UkkGuWJ9bj1A2dvWtez6Kw2P5TaCrOANF11Cyzfefye8rOAghZos00IswW?=
 =?us-ascii?Q?C+0d6R7/a4D+CgcORl7EDeVTONHTLONvF1Ih0+Wokfk0Zc6s5owCvXkPY9f8?=
 =?us-ascii?Q?YQwMB0IC9fVNX4c/3EeG4J8b1MvJaLoH/xAngvl34uqIIWk44HfeBbmTGo9U?=
 =?us-ascii?Q?IkMnrVnsKclkyxVl+Yj1jGwqAAiP6zWTYpILJnjNQM/ROEOaO7n17BzgIJnQ?=
 =?us-ascii?Q?h8DbWI1A9gC0QsfV2Fi6fIKa/T/156VeBWLum1lq0NG1YW4UHWfY0mydr6i2?=
 =?us-ascii?Q?IZXF34YRIdOhvLJlhd+LD7np5zLRvdW3uUqbPv7tBW36u10YmITFu57M4I6/?=
 =?us-ascii?Q?HYKAZSOTDfyvsZ9B5MLn5erQWvwuGbG62ONWSXjogUaauDT+Ih70mUTQtf65?=
 =?us-ascii?Q?QI8bK4F+GhdzM7nkoPohQqjny3Rl3Qn4p5q9RfWxgjwWobP1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75777d82-6174-49a1-ac28-08dec5dfeda2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2026 04:31:08.7878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUT239rkaRCkoZoj14vnRUNGvTR9LOYcE3xr3tjjulcg5Eb0PKNY4Klo8zgbtX7C77Ib5ko5rm4ex7/NoX9qxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7563
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

> Subject: [PATCH] power: domain: scmi: Allow failure in getting power
> domain attribute
>=20
> When one power domain fails to get attribute, continue getting
> attribute for remaining power domains, not return probe failure. So
> other power domains are still functional.
> It is possible that one power domain is assigned to other agent or this
> power domain is disabled by HW fuse, so platform returns denied or
> other error.
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
