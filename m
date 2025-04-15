Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0732DC369B2
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 00:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FCF08214F;
	Tue, 15 Apr 2025 02:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Hhjogjxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386FC8215D; Tue, 15 Apr 2025 02:04:22 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEDEB8214D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 02:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA2K5GEUlUGqBvEw9N1+XCgkt6bu4u/eYgfSJ0QO38hf7w2TOjYw30Q6npEpv27sP6IkrGpcf5YEOA1CWCMJ+6hVrvhnSEfxLxNrgo7jwscE4+9tQbt8ZPRO/pi++8J/iTfop0LNFbphuG4+5mwzNGdtxXKArCS20qPWpp6cQxTh2h7CnstQFgKmLynWteJRPHjKtxVLvBKxkNjTpTI3Wul1VKGzSOq8RKHHbFuRE/gdfx7olBPdaZfThn49NbYO8wr0CasRaPkbguEw6UmKdC217YJ5xjS9qXSD+LNyn3qDj5MbsNNGYOknbwXOiEmjZHH7im3ucQPWA0UwlUmceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAUwsor/66EctIYxu/iidd+nf0s5QmPQnw+Ne1UimWk=;
 b=Zf1Gvb4+HYz8jHYqkyNfAJbVQ10NnXSfIhR2go+0u/wErdHaTlHHaghz/lK1gJTDwXGWJCU+0WqHl+Nbw8XEWlbCdUEIoZXpgJFLphcOPVDnVzALEXJeBNGS4X3utQH+M0qEmy7JAqO2790V8vSGNNYjNHRA6/qSZvM6RVJIBFyzXWnUnCMre6wWCFgenUrsbx4R2bF6ShiiGXsVwys61MXngkjjGr0ZsjpK140litlgOoKUCjhbYuTX3anHcYEZo75WCtjSmx5Ew71SUcftO9IOTo9EhtqPFCGYzJSqNmkXlM9Utw0JtxXUwS2hLX5yyFbM8IFFwFX4/Wnggj9KGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAUwsor/66EctIYxu/iidd+nf0s5QmPQnw+Ne1UimWk=;
 b=HhjogjxamWW0BxAD5QK8VstBnp5XrKHE3L48Tole1XUw6KezldUY1YAo9MNaGpOoUs49LEFcRVjeu2MokE5scFqKMF2m600ao8TBm9a+VgwkKfmlt4qjuJZKKOWrKxzFc250XzICaYvvT5BapaHD2FkfqtP46u8Q0csmxKLMHIArooZFs7E/aBWBSAxaDRQ5UOQkh3IVXVrek9FbDKxKX7XhqEdnQCLaTk7VOcu5BgQamkW53+6B44Dft5rZSFdDTyXjOilAc/fQdpJxHCda1HJxVBPVhdp80ahi5Gav9u1fPE5EZv1H0tDWeY+NIO4H575Os0SVqQBWGmzDpy01+g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10197.eurprd04.prod.outlook.com (2603:10a6:150:1a4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 15 Apr
 2025 00:04:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 00:04:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/1] mmc: type 'Relatvie'
Thread-Topic: [PATCH 1/1] mmc: type 'Relatvie'
Thread-Index: AQHbrTNZWaygzJfwH0Cz63GK4izsR7Oj2VYw
Date: Tue, 15 Apr 2025 00:04:17 +0000
Message-ID: <PAXPR04MB8459BB7CEFFED0878A4CEE4A88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250414114943.55224-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250414114943.55224-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10197:EE_
x-ms-office365-filtering-correlation-id: 38fe46c5-7488-4765-0fe7-08dd7bb110d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/CC04BftjhIy6jO/LbsydwtXRu+UVuK5y5IiWUVclw2VTdxmW7BXoSWeyWI4?=
 =?us-ascii?Q?88jyp6S4QnkaLXw8wkjILFG2QOycB+VCIIHlNbQXRLUoaOac97D+f2mV57/I?=
 =?us-ascii?Q?bVTBFtRL6/aDc1g+R+S9j0sgepfHCGcth3oMvXztDeAuoDm21X6naDgUHfD4?=
 =?us-ascii?Q?vzD/gP7p5aub87NbOV8admQPJnZtH3laswHXnZQvo601/hh4GaZKex3Q2EYm?=
 =?us-ascii?Q?gAj5+S/d7xLwcC/sFsLFmT0H9iKq0ev5zb4VgMbFZzCM4o9wvWYY+8TL1hMi?=
 =?us-ascii?Q?STGRZn37hEjuX4GQloV3Oh+4LZoBE5B6bZQTRx87lz8B1MYj+eTmYeut52Bn?=
 =?us-ascii?Q?EuGiJkkmPM1QNRCzcswodqd1Ez6RihxOaCarFC+MVEcNT/nyT7at2aWFDR8c?=
 =?us-ascii?Q?ezRmdwtQ13UfQeRAHRbbKkRTuvndRjSORazozTF+pW2Y+w8t151+dIbnUt05?=
 =?us-ascii?Q?6WwMOgc5RSPXre9tw49FpuE0OkbRxIMWs3ba8AHxpl05oMjoPVxfr1vksJN8?=
 =?us-ascii?Q?p4swL+ozS/XLoZe/UchJApYB6E7+lWMfX1Z9dFfPK/PQq4QhiqPjLa8LTQzX?=
 =?us-ascii?Q?P2IP84lgSJgC28K87SqPbtlzki+CEpYu/DlX3BpB+DfWqLvcFJhvJsQifpVb?=
 =?us-ascii?Q?bNjttiOHMHm1UkU/IiP4/ge6Hne9ct5EjL/h4NA5JDCIdMMtjaKE4H6r8dOs?=
 =?us-ascii?Q?Rba7oJSUKAuVPI46IdqyPv9wEyCDsBuTZSs00a8uxR6KhGZtLbPNq6A90FEz?=
 =?us-ascii?Q?1VatS94DZ8uc2eLg4mAvQ0OkUOoNsIyCyVCyinaUzBqJYILNu0auun4CSQ+Y?=
 =?us-ascii?Q?/FP0PVLnyXLDiiIBs1WXUtd5Yg4MJ4OUUvWjItkrcZQqqa345ynjAvKVZ0Tp?=
 =?us-ascii?Q?HZDTpGO4IN67mIfABgSaN1wt9CoptS++i+zs4Q/J3wDy0GuFntguoCUxd0f8?=
 =?us-ascii?Q?jxnB3wi6+15YNZr1b5yrOviVEIkZTeMrD6dZzFYiRdeMUedWSPrmVjFOIl3K?=
 =?us-ascii?Q?Vrm3dtJxoiK/B9ojE1DittQ+z2kDOOfsh1O3UD+42Gmj4GVNHFYGte6sax/1?=
 =?us-ascii?Q?9Gfl50BMcJF81QKPaQaL7CREINDEwFUQe0d3qMPP9WtfY8nbGlgjF+K5PlKp?=
 =?us-ascii?Q?/5H3rrhSup/FD0w7vdjwc4/NCyeduwKqoCe1yMW3FLpCYJiF129VDSWpHBWJ?=
 =?us-ascii?Q?207i844+yiYwDV13c/QEEc1hAfpPJVpRNjEZCtIV2F0XUUwDyOxmMABqZQ25?=
 =?us-ascii?Q?jsU6tzpdKgKqkRO+t8n5eYmtcfRNvHJZstQeAbDNdQdiknrD5pLrzNUQ8q8f?=
 =?us-ascii?Q?lHRpkgYp8ElkkAgOT1X+tMYcKEvUD/yfqs0lJOckAtKkukH04QoXTI2S9Do5?=
 =?us-ascii?Q?9F2VLa0faEn1mSC2EKJ3+E7D4HQGUmZfyYel9cgm5osZeufsKQdoox/hr//Y?=
 =?us-ascii?Q?hAClbKM8Rq62hWI8Nz0SN+vcHEIUvD4xOzu8m5pl7g50IwfwaJDk0w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kl44vBbzb4XHzB/gzNAVlSB+iTIscqAqOSd+hfk9J2Kz5VnLKZVIx+BzQG1J?=
 =?us-ascii?Q?YdpksqzvAsjYDR+srqsVTaOrT35SXbQdUfvR0E1sxXshYurIeod71XKKVNeL?=
 =?us-ascii?Q?8u8wyfySOFUSlYTy4JiuyGchenlYdnNgzVZNZ79/F31W9w0xxnqJfHzLyM2E?=
 =?us-ascii?Q?yJUE+k+kCDcuQstiQX6ZYghN1+VKM9GlX327xT33R/UFncQ5ZcUomHPBXA6m?=
 =?us-ascii?Q?aqWwkHhrZUebP9AaNLVkQjiTmRAwSxBjUnPggnthORuRrEvqJPffQmOoxejs?=
 =?us-ascii?Q?xpBBaieni6qBqqns6IJ77kQ1RzUcwKgheaHsorslPmIUBmkyihB+n2e6cz6k?=
 =?us-ascii?Q?y8U5TYu26B2vpC9eHF5RPLKIVDsKxG2MAktYpf6LPf104/He1PkVftzacqV+?=
 =?us-ascii?Q?JUSah1PHuTOJDRrCAlalFWQVghHsi9+wZMa21KAF8V6XkfsN+r2mNArnwNKX?=
 =?us-ascii?Q?uUBP8MEBC0AQUVrm9O8ypRsy841tzQun9dQ+NeDMQDUbDjZ+OFFs2QlOvvVl?=
 =?us-ascii?Q?TQ/KgoM2b0vIGWzQ1yQtyvRCw8djvBTIzRmos4nL0nqPt6QEsqDV8eQg5nbR?=
 =?us-ascii?Q?zGvhbBPjM9pROtPuCHzd+5Mtn+Ikx2aG/EMjf75i06EhHIsgOrBF/81x0rQ2?=
 =?us-ascii?Q?uut/fi6K+4Zglh5FZUzWtqwpgkZxdUzYwERGK9GAY9Trchd+3h8DVlNJNQUn?=
 =?us-ascii?Q?aKl+FgKyojoqQalBKAdgSGNQrrzGZ28e8RtKPKW96Aj+Al1FGBj3Ex+dv5bb?=
 =?us-ascii?Q?ymnHVqM//CZRCqqHvI30AaqyskRNSZeej2QEw84Gq6/sdQLn7uwHhLRi/p2v?=
 =?us-ascii?Q?LF8i1gB5fL9gnVdF3fBb03XbJrOl3I0ozckrmnWrQChMG1LvfsZ1ZtEH+EoC?=
 =?us-ascii?Q?FJoFk79+w/JnMP00no6kG5W7Wu/oDpnesj3T6YVcupSd6AZYnqvT6BiiQ4DD?=
 =?us-ascii?Q?Rcps4mtTJB/O6bKLGTg7UovdNmfUaSr0Id+YL1xgSjEV1waLLsH0TdNVEKqk?=
 =?us-ascii?Q?o4taz4ZoiIx3kDlOsYn5RWYRb7Xffc34WJ6eiqpKtJPnuLeLUKWk9DhiaVl2?=
 =?us-ascii?Q?XIyCS4zMYbeKYWDf3hHRJoQp/7IEcQQSCMjYjk767r/5LwfZgA5SPksi7czx?=
 =?us-ascii?Q?yk0pTe8BHNG4qBnMBjuvcn4ELeS5qYA3wz0hCLkJpkwGZFlWPbFP8mYvtYBe?=
 =?us-ascii?Q?1ofN/T1ondhIpkwNPKya9Zme/bQkzrvww0+jOaUMrNbkTaf7RicnwmPTBU9U?=
 =?us-ascii?Q?HIAOVaDdhBAZcRWH+bgx6dydIK84l+M8KKf/oHQrmc6SR8XPstkrNFNt8zjC?=
 =?us-ascii?Q?GzVgQCGLmlyXlF8vql8npl5MgHZJVLBXlcZMHJSnpdjpQG0335nfDPpAzi3p?=
 =?us-ascii?Q?O52pN9ZjkdRnM2GE0eCmSyNvCXDnvdcTwEj9G5mdscj011PmdAf19F6sRmQ6?=
 =?us-ascii?Q?xP7JbmmyLZAfzH9cXUPnTxz3AwtD7L9a6lPqogV20BoXoB3ktlsgVkFfL5kv?=
 =?us-ascii?Q?omOtySacVwsUyKGnkWNRC1Z83p+hk1lXRRRTXN3F2QkTikOFJ9ToHwnfkvZA?=
 =?us-ascii?Q?HZYCAq20raUu4vfatL8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fe46c5-7488-4765-0fe7-08dd7bb110d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 00:04:17.7974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Ek57h49RpmLNr7vi3viAf/iy/WDLJ6ASHb21MK6RWcLdS3myZTYOd/rNMsmBj9Mk9bCuOdcN9l+PDesevnIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10197
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

> Subject: [PATCH 1/1] mmc: type 'Relatvie'
>=20
> %s/Relatvie/Relative'
>=20
> Signed-off-by: Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
