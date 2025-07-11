Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02865C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2335580194;
	Fri, 11 Jul 2025 17:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ws8SVHQc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 355E2805D7; Fri, 11 Jul 2025 17:13:00 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C910D800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcGAllqqHEc5IaEcRXLz9CXjv5Ut099eV+TlgYp0Ag0T0bQ2i8ep6sR4b31fL4BVA8bG/KIks2vV1Ilm5YIjI431JxrlXnjzbc8svKUJzZnSmOg+spkaemX1PRRvacVFnIMhaUMxXLWI8bsJqbWmGAXO4O9lK6Orq8gned/3gK8J//uy1tazCwWVGCeaaz3+nGwkNVmUl7qAbnZyiI+gevvMG6hNwTmKjReXgeH//UkrnGLOM/Zw4B1uFVup3+SKYSugLtlFty6FuNC5qDGiBVfLc1K5QxYfj5q3M6FGQLBD7o/OZ/GRiaATpOiqB86u+DNoLB8RGNfZwydu5/jy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+MITEJyiuz4ZyXy+rGvtyLkaY+Zhdzlx0l7+MTEe8E=;
 b=Eg/DVyQCqaCQXgey4CP2DyVu863PGHaECu68K+/RBflN/J/L+OVdepkQKo2zzkckple5rie9SvFDxM4qE6G33ixYpLbR4NlvuuM6Z5kX8UOidQFM90D0Z1So7iaJKnw6xXzWMR0ksaR6N99dO8WJ4FWVd6ussv1JPzc30EPTvH+ezmXhrs+bdfblmNv2esp7zIMbLV2q8MUXwF3Bj+Z+nPHBTKBLdExSfC9UsYe0HUC5bXl6S2Nx654MktBo8zXMBY1HlyL+gaiKk4w8HG/lxIE4s8DvVudd5z3cS5SyvBCsfaB5BljpuFzkgZy1NXnAh3Z//xiFqG9MOB3Z9N8G+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+MITEJyiuz4ZyXy+rGvtyLkaY+Zhdzlx0l7+MTEe8E=;
 b=Ws8SVHQcIqaefnH45ghAMaCtBJC2h8o7mxvBRxqF5+GTRBr6Wq7cevRr/1l9n4PLaNSa8H3xFqGVzjLUxtYJC2QCCMumgYYoUOGDqJ/tuSakrH0x62yTL9dmeIY25VNAXsxTLk4x8s00Wh9hE90DyOZk4IMxuEQxp0fDbE31Xb8=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 15:12:50 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 15:12:44 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Prasanth Mantena <p-mantena@ti.com>, "Simek, Michal" <michal.simek@amd.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "marex@denx.de" <marex@denx.de>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>, "git
 (AMD-Xilinx)" <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
Thread-Topic: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
Thread-Index: AQHb6x6eeo4pH3Bu8kCojgYyx2dNQ7QoPC6AgAOgd4CAATkk8A==
Date: Fri, 11 Jul 2025 15:12:44 +0000
Message-ID: <SA1PR12MB8697C766FADC9E623BE769C3984BA@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20250702065717.3871435-1-venkatesh.abbarapu@amd.com>
 <98275d4d-0644-4fc8-9ff6-8d5b8622fd9f@amd.com>
 <20250710203015.ocrira24b2la2or2@prasanth-server>
In-Reply-To: <20250710203015.ocrira24b2la2or2@prasanth-server>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-11T15:11:01.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH7PR12MB5655:EE_
x-ms-office365-filtering-correlation-id: 04a1ca28-5d05-4dae-be0e-08ddc08d6331
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?V3mv9JnqVSYqeCtmtbK4zdUnYRvsjBCbRRCIWjZjpgbLXGwWzbCBMe93zL/K?=
 =?us-ascii?Q?J6FTQqHnUWzEYQQyT7lT/aPo4u3j9YtNgEOhVzgbBmUiWBuLbNk/gsngFpLs?=
 =?us-ascii?Q?SMuQ8j9/4DyDkx1b61SVrISNhxEd9/jsPsdbJhi4mNxLpgWZJjyDfGuTv1G6?=
 =?us-ascii?Q?3CFzwGogWWdSDxW9DTy3zkF7TvZlHsDZ+l95wGKsaeXYHJpqJTQETtg6TK8d?=
 =?us-ascii?Q?K4WlGwDAp7hlMqKF4Iclbme6AnM/R6qdf5Wc1q1DDc+Q6Ezpufw5MFsyNA7z?=
 =?us-ascii?Q?ejg/Uj8ZOI+woFNAcFZZhS1BRVkBBBNsEAu9dMRSyw3pvFgIPr8iU/ihA37B?=
 =?us-ascii?Q?t0m0EqDJK2NQYrSpXfW/gqtcS7xhxV3FbEB6xIO/1gwLZaQlPVUgXlT01mXx?=
 =?us-ascii?Q?GJtG0lAG1S/7WMXItmf+C7Uo2PvRIFOr7NeYCbU25SJBGA5qR3fNsT1N+e6y?=
 =?us-ascii?Q?sE+JHAxrJLPf3ua9ZUqWALV5kqM18xzYia18bQgxdbdFBzGcBnz7o2Y5IVTm?=
 =?us-ascii?Q?AvgXpZNRs+5b7HxP3ZWm634cYBMOWkAdTjnsEfiCLKIIKWtaVC0iJW+uZ/XB?=
 =?us-ascii?Q?Pc/7A+sPSXgR1tjTNBcx8Clb146HECQht2mkHKEN4eGsNY0D299BrgeD5UKX?=
 =?us-ascii?Q?TUKghysA5eZxQT9uldKaMWwzedRKPNwW21ujOiFu93lsPuVYJuJts1cKNAgA?=
 =?us-ascii?Q?wJ5/zqkOeL6xqe+vvai7/RPVw9eRUpPPQ1Hprvit42RrGAOhv0TGTSteqtF6?=
 =?us-ascii?Q?zTenmytH+eiy0kC/dVMXEBBdF1yrb/qh4GknZKwRFHuayCOFMxU+cMDe6bgC?=
 =?us-ascii?Q?e2YugdkkrPELLOVqW90L3OyelBAy6paXRTrV5KIlnfiSGuCOXcjSmohpp3a8?=
 =?us-ascii?Q?iSPW1yPP9IXlJNtnSR3/seM+LCc1BPYC3DUtWBmLFX/NcbzRaG2IfHIhzvRS?=
 =?us-ascii?Q?VUZH9TxOaIF5+PBRF89+d9DQcP4LxESvdD3vv28YXXfVy5ZznqGQHj74NnqI?=
 =?us-ascii?Q?vrQaNGagrcDVfJryR8XxtDJwUkxq4qgIxNy+PYujXEXWo8iu4WaHk9S78EZ6?=
 =?us-ascii?Q?Fz5nyS7xpqvWj9cEuKYv2+R1fq5+vlhGkORk3QyeV2k4OgEjYVWNrWFGQo3Q?=
 =?us-ascii?Q?4gxAQyc6FsDRW4Digd0E0sFFyrtLM/UDKuTOOQXhcORfkioTtzq7fW/KLV6V?=
 =?us-ascii?Q?W0LwHfp0hEi0OcXqJ2CNZerZ9nqGg5nar4JCBZ3XSfdMyLDWgH3aWCuru3/7?=
 =?us-ascii?Q?lU+MR5Qh/HJ15rHyRp9XwWCgjcJp5QgSwj6aGWggr++HRhaGa7k77VWGOcsT?=
 =?us-ascii?Q?FZBst3UsVc49NYjjDboYYMguLsbe0jMzHRmpLMl1M1ENpWfnI4Kgc2kzjRoX?=
 =?us-ascii?Q?H4IfBUiKsrN5m7rENhDcolWV8BegqHaNIfi1Gpu+tCY/wGcaOFt6RsUAfHDA?=
 =?us-ascii?Q?Nd3qcPv6UPeDd2MVp1AR1tDVWVfFAQbo5HyS8BonrVVLbUAlI5jl4Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q1jIEku+aKmRIkRkk15K8LvLZe4ADAs5dq389s1TuVfbT2tawBArUzpo315i?=
 =?us-ascii?Q?PXgUZ5C3XmS+8LwlDBCLBUg29DNRyu/dwUiGISk+1+2Yzljn4EvExC5SQLAo?=
 =?us-ascii?Q?ohc6EGAtUd4q5fXZRyB7tN0Fv28WOEayTbS0G/4/3r5vH2/qeMAwWyUY5XMc?=
 =?us-ascii?Q?3dAzf23I5MqlAWB8Osj3Vb2fJlrY34jVwPLLb5JoRVzdaC3GUQ2iJOq2z9AD?=
 =?us-ascii?Q?wuZ17gQzuRKs2vFiBjIlX7ea/gbN/7/jrcAG8S5FUYGy0pUnGwROdd0I6c6T?=
 =?us-ascii?Q?Nqtz50rkV3x8t4oxZ75/TaaBKUSg9cT+NmRjFpRiHCtGF8Nq9LAUvsINruXA?=
 =?us-ascii?Q?O5xNk54Babmlb10SRbKCag8efWAVVCYZvtfGZ3a0BMe5B76V7RbeKoP9u4Lh?=
 =?us-ascii?Q?Fh+7qDp8281nuur5RDbUZL2O5Vy2zte8B/VvMIejqel64dXGVtBaakDI758Y?=
 =?us-ascii?Q?JdSypQWrIqyIo/oHIQlqVchKhgjo372hq9XB8zr8jf22Z4eYK5SSGeUn0Sjz?=
 =?us-ascii?Q?HCSz8qDTw8vJ7R5KswAVHbW8W3Pf3Kh1bGv8TLLrxJpT0KYhsQzdFEKsQh5A?=
 =?us-ascii?Q?YFk5ejz41c6xH7ZGnfV38vUyQy+dRB4wJ5SYkM5QwHLV/izhsAQxys05lIKd?=
 =?us-ascii?Q?OHNR8ZLZSkJlhXujRs42juk0pRY0Fe9/nc8PztEj1uS15aqtCE+V6G2mtlS9?=
 =?us-ascii?Q?vENG9E46IFXT1VQ+xD4FdrpgQB/6ZlvZ45HcEDPyoTL0Y3CXqXQDNSipJXqK?=
 =?us-ascii?Q?zNIJCVL/SLhwt0Yxezx5RsXqJoVziX3FIgBlO6b6993gurhpQZmUm/UR7H9O?=
 =?us-ascii?Q?Jb5QbMSRrxJjrGR5LkcIOPfnmnLPB+FecvaUgb0clRvnXtD82Js6VIv1W2je?=
 =?us-ascii?Q?ffSwMLUqf0vs0wMOKHNxG/EDJ1u7ukrhFplHIcNyxo+pNwSu+liqlCGnRBdZ?=
 =?us-ascii?Q?au1CIGI5luCMAHtzyKRJr0EDzfm2gVehWyu76QiHDhaZ4c4jmruJAHkzx81z?=
 =?us-ascii?Q?J0J1Qf99eM5fmEYDLtObI7jt/IVb58+vvxeEv0ZXvIglu/yYHAVCtoIvRs53?=
 =?us-ascii?Q?gE11MypDjbDtWsFsgJWDcnL49OPWIkk/6Q81sS92Ex3pLPf8cMT4MImcEo+0?=
 =?us-ascii?Q?U8ognKB5TKhI9jtreTuTQ0A9X3B7BgmNuu4vVAcxAibUNRwh45NwUQ/gRKkQ?=
 =?us-ascii?Q?1fC5gWcliU40aW222ZJtxDoaSDxIRuKE2FIxAoNkC/bp638QhLMFEg9tHuGd?=
 =?us-ascii?Q?50cpdIfKAkTWCWx2SlxVPNhLTVJO+a/MeiPFLnY4JhuYk38KF66+i11/wiVX?=
 =?us-ascii?Q?399KJozmOz3+h5EREUGPIdTL/c40hYOd4zLSxcFY0QxxDBuiwJZe7J44av/o?=
 =?us-ascii?Q?ZAgjoTNATTf9+OTXh0BqLUJwoBDQlVk+VIYlUBkhQ2dqCIhLViAW942/2uQl?=
 =?us-ascii?Q?KrM3dtAsErxPYL2eOlDdzgoWdoQz5OXGAFLW5jiF4OTwMhypYlTQqPAclM+b?=
 =?us-ascii?Q?nzNzhnTwty3g3ivzqnQCFXv7bDLtxfLS5lVjsRaWcls/yRo1AjafqGYD5tJR?=
 =?us-ascii?Q?0QO9Kv/hc4xtGwwtuZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a1ca28-5d05-4dae-be0e-08ddc08d6331
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 15:12:44.3248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRCZFLjBFdtLBOBec8MhpJDtSaq8QZkr0LSbW/RQGa5UzN2QwjKmlYvFrfIJ224YCLltjTv3wThLTvKaFxPCJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Prasanth,

> -----Original Message-----
> From: Prasanth Mantena <p-mantena@ti.com>
> Sent: Friday, July 11, 2025 2:00 AM
> To: Simek, Michal <michal.simek@amd.com>
> Cc: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>; u-boot@lists.denx.d=
e;
> tudor.ambarus@linaro.org; j-humphreys@ti.com; marex@denx.de;
> jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> trini@konsulko.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com; git (AMD-Xilinx)
> <git@amd.com>; Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Subject: Re: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk=
_ns
>
> On 15:07, Michal Simek wrote:
> >
> >
> > On 7/2/25 08:57, Venkatesh Yadav Abbarapu wrote:
> > > tshsl_ns is the clock delay for chip select deassert. This is the
> > > delay in master reference clocks for the length that the master mode
> > > chip select outputs are de-asserted between transactions.
> > >
> > > The minimum delay is always SCLK period to ensure the chip select is
> > > never re-asserted within one SCLK period.
> > >
> > > That is why tshsl_ns delay should be at least one sclk_ns value. If
> > > it is less than sclk_ns, set it equal to sclk_ns.
> > >
> > > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> > > ---
> > >   drivers/spi/cadence_qspi_apb.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/spi/cadence_qspi_apb.c
> > > b/drivers/spi/cadence_qspi_apb.c index 65fb2d8f9fb..4696c09f754
> > > 100644
> > > --- a/drivers/spi/cadence_qspi_apb.c
> > > +++ b/drivers/spi/cadence_qspi_apb.c
> > > @@ -303,6 +303,10 @@ void cadence_qspi_apb_delay(void *reg_base,
> > >                   tshsl_ns -=3D sclk_ns + ref_clk_ns;
> > >           if (tchsh_ns >=3D sclk_ns + 3 * ref_clk_ns)
> > >                   tchsh_ns -=3D sclk_ns + 3 * ref_clk_ns;
> > > +
> > > + if (tshsl_ns < sclk_ns)
> > > +         tshsl_ns =3D sclk_ns;
> > > +
>
> Hi Venkatesh,
>
> Just referring to the Controller datasheet, I found this in the register =
map for the tshsl
> delay register field.
>
> Ref : 2.3.4. Device Delay Register
> "
> The minimum delay for chip select to be de-asserted (CSDA=3D0)
> is:
> 1 sclk_out + 1 ref_clk to ensure the chip select is never re- asserted wi=
thin an
> sclk_out period.
>
> "
> if this delay configured is exactly equals to sclk_out, and if sclk_out r=
oundsup exactly
> to ref_clk without a headroom, then the next transaction would start righ=
t after next
> spike, unless if the controller adds any delay apart from whats configure=
d in this
> register.
> May be thats why it is having that one ref_clk tick extra added acc to re=
g map.
> Please help me understand this.
>
> Thanks,
> Prasanth

If the calculated tshsl_ns value (after potentially subtracting the inheren=
t delay) falls below sclk_ns, this forces it up to sclk_ns. This ensures th=
at even if your initial request or the controller's base delay logic could =
result in a shorter actual delay, the minimum 1 SCLK idle time is always gu=
aranteed by overriding it. Ensures CS# remains asserted long enough for the=
 slave device to properly latch data. Avoids signal integrity issues due to=
 too short hold times.

Thanks
Venkatesh
>
>
> > >           tshsl =3D DIV_ROUND_UP(tshsl_ns, ref_clk_ns);
> > >           tchsh =3D DIV_ROUND_UP(tchsh_ns, ref_clk_ns);
> > >           tslch =3D DIV_ROUND_UP(tslch_ns, ref_clk_ns);
> >
> > Applied.
> > M
