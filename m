Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52151CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE698836A6;
	Fri, 29 Aug 2025 16:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tuTWU4Vk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4382F8346A; Fri, 29 Aug 2025 04:31:28 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45DA83443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFwth8WEGmpLY3kusoBETT5v9KLxL1eY7AX8JqayP1QDVPOngzgb9XIR1X1SgZFqlcGkUx95B7aGuS8kJRCy7o0QigYg/HQO9c1bMQayIJbi02w7NRJyDe6Ib8ThA8Tm7JDvGIK96Oqap0WrfAKnKLyaBrPM6E9rgtjjHbEDvFSHC15z+2kBwbYaUAhb003iPbSDuaf7RB74lxM7hIK6MR/ATcGaOI92pFizKHRbcApHjbI85ded4VMLoVF86rZT1OrPJoG7z9bNNd48XqMlq3ThF7NXyriZpgASc38tKwUI5ZnIMSojMhP/mBxal3ZjwGHi+ntim3e7pDzuDh+IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RY+B/jgk4/+CUULq2P+Z8fnjD0G3rfsp5dzIUvrnS40=;
 b=eVyxZUX/QmoXVBSl027qbk67uxZoIOXEOzB4Je/Zxo5uaHQuUipqJIYgH1e7Pdk5gq6zrBPj5039378bOOPnV6jM8ID8M4mmy+636BxNZOzPe+H17Dd5gJNT4cSvEmnQFQsKBogRI0vDT/Pe0hM1Tw9kB2xHLuXn4EslCMKjS9PKzwf/fanuTYPFWfXjUeWxtMvW9by6/beKvDgCebx0nLVKLJwEtotdyOw+A8HnWANQRdIbhewh49/G/4/hGn3LO5kU7+PtH2M55IhkWnZSLfv6OJFM1n+1z0MtTaSPjhKZiiKP/sFQuJD556P47l+h/Jx2StL8we88Tf/dUvXM4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RY+B/jgk4/+CUULq2P+Z8fnjD0G3rfsp5dzIUvrnS40=;
 b=tuTWU4Vkq1jSC2EIRpfriekKYstcucbRM5GlLl142IEnTaPzTKQPa0T5TLVYkQFDtW2luNQSBmmi5+SKy9ix13pCl9RZBkcG6W4plkU/BmjWT9YFUx8ehBahcs/Rie5hCQKDnYVrOdfwe/q4QWMWrsiR3qEQfmT9GspFw9m2mhKRossSF6KFpz0NOG+J+P9x00foDwPEajVvWrCiDSAtzrnnxZDaprCRCrH4CA4H8LDPqxJ+vudoNDBxHrz8Kb+YsyFTNh9aKr03xV/xgTuvKc7GPidF9ST4y2tUaHoZVC+FT5QUcHvNtRtWB/5VdVRX+SvuOWIVRZ5ZYnC00CH30Q==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA0PR03MB5387.namprd03.prod.outlook.com (2603:10b6:806:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 02:31:17 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 02:31:17 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Nikunj Kela <nikunj.kela@sima.ai>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Topic: [PATCH v2] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Index: AQHcGG7kEnkw2dzFtUSRKLOzDr8ZjrR46EUQ
Date: Fri, 29 Aug 2025 02:31:17 +0000
Message-ID: <SA3PR03MB7187F9667AECD463030F7F3FB43AA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250828225532.1147284-1-nikunj.kela@sima.ai>
In-Reply-To: <20250828225532.1147284-1-nikunj.kela@sima.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SA0PR03MB5387:EE_
x-ms-office365-filtering-correlation-id: 072264b1-0329-48ee-ea74-08dde6a421d5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?M6cjzfWMCJMn21IhL3Tfs1eLl8jw2u5OPdqNmLeoaio9ODTELPysrgCKXx1F?=
 =?us-ascii?Q?huJKqzdjyqTK179GzmLva0T2nKIl2geE5WLh7zfMMX24iHPIsT8msihBjNot?=
 =?us-ascii?Q?kUx89hBJR2L9PeF36Ll65xkX0LOXKUEJrxMs+39Sqst/ImBU8ZM63HTw8DG1?=
 =?us-ascii?Q?Y5oBFA4QiLwpCC7kIn00GTm6UMVXknMdaiq0TzFbzBcghLlKe81SlO0ob0Jd?=
 =?us-ascii?Q?ubbWkuorFp5FSVuL8JuimyeRYyU6ilSwnMRI855CC5TDm4XdtHNPhdOSIkTM?=
 =?us-ascii?Q?TxhEJydxZ0YQAb8eBiU5HlJcQu7Z008O/QuJvLBBLGn6DX7z9GMB2zPf8Vmh?=
 =?us-ascii?Q?0yeFKEBLVxMh38HeV5LNQVc+LcMDHo3KeVxGJ9MNS/vkK3AHS4jisIYYC8EE?=
 =?us-ascii?Q?eTBq5zFdM7N13GknjXeM2MPE6PiJQbn93vSlNyCpz/OMLInEM3Y3CihQu8yX?=
 =?us-ascii?Q?5Pz8xutHsEzNZymgrnT7qtKC+vL60y2Mi5zUmQLfPuG/p88SmNIyjr5+EVMS?=
 =?us-ascii?Q?ZXKMowJMSZu+qtkAFUzbPujl1rPvejjm8uUR9/70aEfCVNiPPpRU4ktQKsZG?=
 =?us-ascii?Q?oiSy+mssUHms1ztl2APd86qa9/ItiBzvIwJBRFAdxYjdjYd7b8g84orsw9B9?=
 =?us-ascii?Q?pNiR2cmEcd57Mixo16Kn8qKeo9OshEKkI4be8kPcoHSknz5LTAKI8N6bdVGs?=
 =?us-ascii?Q?8VpsOyzhPPOC9gSDSDYNQHW/wF3g1sDe6lbnw854XTTzC0QmJTwmTFcoaCZa?=
 =?us-ascii?Q?IheUJkghpxCh15g/a7wJKoukM65zqcIg6x5AT8NHH8aYb0cWl3sDzE8X0DLK?=
 =?us-ascii?Q?O9otqXAt013IGPFYgBosk4c0D2VIs+1zNHtVqckM5RbvWMnjR0QTWc9WkvMr?=
 =?us-ascii?Q?pok9/G/Uhn7dAa5Ug5Cg+JVgmOG9b9GyV/8/9bYOls2ZuSOFIpDqSPlfRu0v?=
 =?us-ascii?Q?maAEyrdp0MSN+ymWzikfyaoYoIuvQde7mjO9j28x0aiEPKcLwmVOrKQI0oXN?=
 =?us-ascii?Q?dwwg49astNvqxK4qi5MtmgZ1CG/hohuFJC7HP/SWRs/QQ0oHY39Vty+LpIdc?=
 =?us-ascii?Q?h5/xzLIM4nAWTu2Uk8NAJMwtp0j9hRG7/5XWEmFP/wb+7EK6r+vUt3bSAhii?=
 =?us-ascii?Q?cD7u5eogPPmmgh8wYinvC1xdLyG1WjlcJpW1J+ezxmbATMGg46pQNPVbIcKd?=
 =?us-ascii?Q?oHvZHRkHZGOIMGtHhANFmhH0TkK+K5h4z43SN8c0R55GAwaAJCpgrIYgbkBL?=
 =?us-ascii?Q?Lrgkxb9wEzSUjoSMDQnfqSrDZShcflq6Ok8DM71kEEQl2enmNn5fQphpnDjq?=
 =?us-ascii?Q?buGrh7xyxFySQDMMEUUMxSB7Qq0gjJgAB9xMkX4eXRFvREy+DonMDreKrwWe?=
 =?us-ascii?Q?YIEqkzTvwqzPMFPNd/dOnUcjsFVIuIQTGensn/rGDEZ3BCqIgtb84YAwWrh3?=
 =?us-ascii?Q?ISkZlCliKrxm84ocjXcu5gInxEqLQumTce5Jd3pq5Mvw5y2L30QC8w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9tucdLCbViphPj1GZKNnjsSPDacfNUIMkZxWoQk+iAX/+wUhj7ki0eHUz4eh?=
 =?us-ascii?Q?WDCIUGh51pDxKTWQfX2d2BbiQ7iPFNlx3GfV7Hb+RNt6QYRwAbqIrBT30bey?=
 =?us-ascii?Q?Np0mdERGS1qxQ/10VNMgkAMhsLtGZ8o7XSuWiJcPcX2DeGsn+Jll54PoOBHC?=
 =?us-ascii?Q?KVjT0UmCg635Tgy7Ldk5N/2Bqn3u7rVNuftGh6fBE0b3Qfve4rjPRiX/2P6T?=
 =?us-ascii?Q?vkkji7pNvY8M7MkztYYPCdGwcFD2Cy+o3TJhJUpEkXO28j4+4FSlxyjBdhNg?=
 =?us-ascii?Q?mCQUDpxfczv1FstJ83DUkCHOvuIewUXfKeAT/SPqF//xJsoqId8KxQiaDRJo?=
 =?us-ascii?Q?2YpMyqSDXaXeSqR6tSeND1TpvntBmZBhZzzui639MNLXJHJufYUqTO37CDXm?=
 =?us-ascii?Q?eNO0YaPf05/OmRXuPGf+bJDIj9sCRBC8FIJzAGYTmEOJolrp4xoPX+ysIKt4?=
 =?us-ascii?Q?WGVhl8usguxJDUUkOohkO7Lfp87sK0I9mBvbyu3jTaL14pDsHpc90kw2V/a/?=
 =?us-ascii?Q?DxFqgiMdW5AoC1IqCt7ZyXDwhQdpGuz3/+GJrmCsQKcqWoBpm67BHzJazw2u?=
 =?us-ascii?Q?hk5AKJzei189Sfn61SrfPqrMKOShVSU+Q6JrFXNarieTBzpTMgPF24DnmlF6?=
 =?us-ascii?Q?o70z0jl95Bco108kRHDnjUKUM82OWYtQk3T4vYCZUUyaWv/ywcFc1slbBtZd?=
 =?us-ascii?Q?FL2UiHx/6CbbarzDofiFlY0h/KSQbJJx75/jnwwGK2ocNDUgVrdQGSqu7+NL?=
 =?us-ascii?Q?lGcDEv7Vao5VZ8MkADuR/uLXJ6rybw0Q63N17xc2i2r9XzBFn9joSKvaIeKN?=
 =?us-ascii?Q?VLp35b4x4DimOFdyQ6y+Nc8DmGpfPoAH2Xu/nFg9pN79muUO25WfMBdoKLJT?=
 =?us-ascii?Q?j3xu2LTu78fziSdPfNcx8+EGNVFQn84Rep3m2AOKn9kR+0k6XfvTAuCVcoIP?=
 =?us-ascii?Q?/Eq/bHIKtv7hpSGIPdxTfG/6SEiZO9UROI0K4Bk8l/OQy6ZmZ9LLElx8E3D4?=
 =?us-ascii?Q?uGy6MTNLHcAhYgyinn2sMe0EG9ACbcVShf7XahTsGyjYHvNbWaOOUdAPNCE4?=
 =?us-ascii?Q?K7IzK0B141p5PyGOiJir7Ka6+olk5PU645srdR3cmyXWCsft23ZY+jpLRF1L?=
 =?us-ascii?Q?gjolAnH3PalbExLYhh6EQcZlx8eRJ/XokdOOAPuQi2fCmFxOXinKnXOGBvgL?=
 =?us-ascii?Q?vgfQvHkIw/QHvBHJoi2+fXXLpGhVc/kKnoMl57L4q9sKI2Y1t154/v/rk1SA?=
 =?us-ascii?Q?V0Cd+SPjKXXHKzi624k8JipneedQCKZSK7C35gGj0y8v/8SpQSzNxqVUyzcE?=
 =?us-ascii?Q?Q2+WrY3QlfrfB9QwfohLQxqK80UfWTUb6KBSw7IRyzQ3klJbJEa4RyMoxA0p?=
 =?us-ascii?Q?Ksiid01JJM8YF3MUP13HcsN5q9T546q5oV3l+0/v/iizmlPWtR3vNUpN86Uw?=
 =?us-ascii?Q?8hWX3mkvhZpsrYWr7IbJqQ6ZnRN/+0x4uF5HEa8gPInokf+A2mfiBN2msHVp?=
 =?us-ascii?Q?ivjq+yddkOraw0HMmZaiot9DPWPF2cH8l1qVvHwKcODH800BWGJxC3tf00aF?=
 =?us-ascii?Q?ucl7/RoEazUN6p7tPRObDgqib4Ku/cYutLVSLh6OrN4yNfd1IBYQHcvSPhPo?=
 =?us-ascii?Q?+FEvJ7V7dhnj1Un82lEuRew7FatT30Fd41rGUZ2Up2t3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072264b1-0329-48ee-ea74-08dde6a421d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 02:31:17.2735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YuObE1q248gbJqRijaNX7isJo0ghkWMTQs2+jZz2nkFOjwGrlpWNjq5ab4Kqxq2FYwB55q35he7YN++mDBIQ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5387
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

=20
> Currently, clause-22 format is supported. This change adds support for cl=
ause-45
> format.
>=20
> Signed-off-by: Nikunj Kela <nikunj.kela@sima.ai>
> ---
> Changes in v2:
> 	- Created separate function for configuring clause format

Reviewed-by: Boon Khai Ng <boon.khai.ng@altera.com>
Tested-by: Boon Khai Ng <boon.khai.ng@altera.com>
