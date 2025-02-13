Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDA4C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 15:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893CB80F4E;
	Thu, 13 Feb 2025 16:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="cAlVUbL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1716180C7E; Thu, 13 Feb 2025 13:43:42 +0100 (CET)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBCD6806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 13:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
X-CSE-ConnectionGUID: 43U74lMHRC2LRImIfgerrQ==
X-CSE-MsgGUID: 1AIwJLOZSh+8oztNdkFi+A==
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 13 Feb 2025 13:43:39 +0100
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 3AE26B5A87
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 13:43:39 +0100 (CET)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id 86367B5A86
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 13:43:36 +0100 (CET)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 13:43:36 +0100
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (104.47.51.172)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Feb 2025 13:43:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfZS2k8YgSHnZV2Hvbgh6yDdgKdv1qFXSYiNpXnCyLzmRHB0JRNkwNaC0LdmH7xx0jqookrbO/Vl1CAVsWRPiEEpHk3dIgBC3LT+oQut8Tk1UFJcfuVg1PUc/X7ZWumtKXTx1UmTcKipvQHou+COKqIFnLEj3XqbwOhf0a4EvRjgc+ydqkqNZrwk/OkkRgu8VQFFLsyaFB6G59Uj7ReZXrWCt6sijUtEUgnb3gx0kFlMDuj5CBFQtFpvf4PeY1+43fElCF1A8gpVzRStviNi0WRzxUer03c9utlSEYYEVMHTMt9pMSc6vgAUiwaLJfQNdK5YBoOpfayUKC/vv1QKhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTAIri07D+7Imor53ZhzX6fxsFJSwyLkDxEap68wv2Q=;
 b=I0BM8Za61pqQURH+PuyI7UHPDgYmFct3QEX18nd0kSycz/59jW6F48DbkpRdbmdEhrMWj0Su1Ex6XfkE96MArQSfBn8MhQ6HSvHO75aCtwrcGwYvmOGwdYZwufoP3QrjpdrW41USSfqPm+ZPdGuua/VVsgkdbuo5ICpHlguy5pxHCUVEsKVjYGKIkFdvcBZyLgvNwPoE2I8E3d46+14qbQmBMI2zU7TIMm7WAojm/7jQcVzhPPbm2lQbSa3nGN0bEjwZFaQN79qaNB85tebxY3Rr+ApXF5jUD8/yNzZfIN4j/stj9KRP9DhXFp2bA0pb7d3BRexjsteEvVkfbeIXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTAIri07D+7Imor53ZhzX6fxsFJSwyLkDxEap68wv2Q=;
 b=cAlVUbL2zAvk/oss8c8LQL8fSWUuibUo4uHmBqX1dCjoE9FsJNF3x3pQKAU9y3tvjANJYJK7zoAuxoFHKF+0XheObTPOcxfy+zZaYi4yQIddPaMQ1VdsI/2OZ/sHyn0kQNda+82NN7Ml2YefLnF4Kgqty0G8zIouL9E8oE53POw=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by PRAP250MB0637.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:298::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Thu, 13 Feb
 2025 12:43:34 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2%6]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 12:43:34 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Michel Alex <Alex.Michel@wiedemann-group.com>
Subject: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
Thread-Topic: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
Thread-Index: Adt+FMb8bmfTybjzTt6jwqR3i88GxA==
Date: Thu, 13 Feb 2025 12:43:34 +0000
Message-ID: <AS1P250MB060864865460745C69F23D74A9FF2@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|PRAP250MB0637:EE_
x-ms-office365-filtering-correlation-id: 065fdbc5-33d9-45eb-f964-08dd4c2c076e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PlKn5WTeLWOfV0m5A48mov0AV5EzIG6LGd8vIV0qnInQyOS6etKMimoAJk+Y?=
 =?us-ascii?Q?N57Z/TGDZZY+TC2upc9fsdPSV4TMnUasujFs3B3Lfc3id5Mmik1oeMByEGMA?=
 =?us-ascii?Q?KVPhxK+Ayc23yq6FrkXLlr+U6XBX8nNtYf1xqerNN+eX4oIP6CiEJn6N8Maj?=
 =?us-ascii?Q?nQP2LUbd6Az1xVioy+U0EwgFmhovOfUAOU+zLadUBCGXKlHIcQB/PWloSE0g?=
 =?us-ascii?Q?roynjb8hBY+IsTc9CfVdj5Ffqd6k2dcYDQ7EC4FA3wH9df88Cozp1FyAAqjV?=
 =?us-ascii?Q?jrhDxQFeFSpul+K75DgXfxZ9O2qifHbLtCDUYiRMtHF2xLmWPXjv4FflPiCI?=
 =?us-ascii?Q?csopkKxzr5gKWSPyzoPei3wz7GJyCR6qWdizmx9/ioAxXQ2SWCfyZJYMAW1l?=
 =?us-ascii?Q?jyuHMTrFqcnBJpaY24rC+Fc5GFl4EcrSZH3A8e/RxtOeqMCTQRdj1pgnYPKT?=
 =?us-ascii?Q?R4dgKOEyY3KSsbCWwopCnHwJLkTjZ+EU5W5gIxp3ZfOn3+VYgPrLrEWyH2qI?=
 =?us-ascii?Q?2ShW6bJXmrGukS42QDjfpUJOn9WxFSGvkhscRdPcM7aRdqzwJZefdqseOlb7?=
 =?us-ascii?Q?59g0v/tmUxAdv1uLyTUb9Ze1E/7Ev2+UlNhPqMHnVzxlIl7F/2vKPDcc1Igi?=
 =?us-ascii?Q?XSzkDlGZmYSYmKchzmylJFKUSoxAe5aTxLsUqrH4/S+sAhwpyqtmGMusuoNw?=
 =?us-ascii?Q?4S01bMvd04kVYe3UsmNxDkP6BwoYSi+RrWdYNhgk98d33NzkaahE0q/93Fy7?=
 =?us-ascii?Q?EMl2vQ55KtKM2pUZv3HMrm9IyROTIic+rDdSHm4fp61Q5l2gDccgNGxfh3vi?=
 =?us-ascii?Q?ANc4C/Vn7rfv2U9PCUdEJ0+729ntvbfpofEVRU8yi4AK1LnLMjFBzkXXfbAP?=
 =?us-ascii?Q?LETe3S2uzkopwoGMkb14Sk+t/S0Ojo8RAYN77IiderBqfYCL/zZMxnychkKJ?=
 =?us-ascii?Q?qDMAmAiEpGJLa4igiYrZR3cRj/rJ6kJFHk90m2t9aI46UYoTvXAIxXTjsW7G?=
 =?us-ascii?Q?ZZVsF+QsBegLInjDTVSctfOlHqMZJzaymLLptRbWTLt16CVbg3sgjlpY9Fg8?=
 =?us-ascii?Q?+iVIKG3PJcrt0xUkMhb0f/NINY/4v/Zma45a2VH+mwYOYD6YcQ3ZbqpkKBw7?=
 =?us-ascii?Q?JYAGI+WtHJFNI84mYNyNpdfxGAViJcytJeIPuKmNi/4mY5lKglpH7vClKcwT?=
 =?us-ascii?Q?0MRpdVrxbI7bEIZ2QhYqIfGgeN1IJI7XJw5hOsN5S6I5NV9D9mp2C4WKW1TP?=
 =?us-ascii?Q?31dH8teNhOJxtgK9a/K4nDzzboWbN7g55991+RANudfTnAR2UOCtxhyFuWl1?=
 =?us-ascii?Q?09n9ZRQYuHHJh2HkAkPPLoe+I6Wqw84rswY63CndkWCK+qzoqOleBoQHZoV8?=
 =?us-ascii?Q?WcVFyilJohb2Ew/l3b5iW7wNgQYeiIeuGRo/y0s6NgikL9LmA7QTSjICDvhd?=
 =?us-ascii?Q?ErrCh3sLcwFKEyMqVxDluAP9OwGAtY8D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pxYfEjFceYQA2WMipl9HeApEzv2+elSE1wo2imTHH/RvS+/W+vHvRjch5uzl?=
 =?us-ascii?Q?85MspF1csg7CeMkWuoLKXK3mwhuytdM9QiutTmfO9iXf0UAS4cwPFfJ12tDy?=
 =?us-ascii?Q?jeUyOaXTdarJR162wlkb9ynYpM3jsVFtUVXb5pE6fVELeFNI/BL5KwDOU6pQ?=
 =?us-ascii?Q?yz5ispAb/iApriu4kmgLunhGu4D7e8/2BCtUFZZhSNrV7aazXvXsQw2JwSyn?=
 =?us-ascii?Q?qXoA3YmPom856G/VUg1AtO3v2mHFYjGhF3oRiSAi9Qe34o+KoUQ9prRqE5PW?=
 =?us-ascii?Q?bhLbXMmVwGhmGmZ/DNK6U3/o2h/N0WZ57E2KoNmGVtDD/7q4ZUD293mu8GCu?=
 =?us-ascii?Q?N13YEWoSfMhpOwR2+RFVCmP6JdEiLbanfBE/Ab6RnMT9JYBoj6J88Qek3jsb?=
 =?us-ascii?Q?WerdRVPqr2QgXz2ndi8GRPPYQOVIs7Fsu7dvTb7DZ5DJQAl8GkftQEpO98Lo?=
 =?us-ascii?Q?dgvntVDfsI9O7O9KiN/m1CmwifSVHBuh9kYKmIWmP6Y0eS3XrB1vpLEp+0Eb?=
 =?us-ascii?Q?lYeLLk1Vh5kB5RB7Nqqkfmy9rbRu0n+SeNYvjngc++Tpmw9Yt9luBBIjGtUS?=
 =?us-ascii?Q?5VT1aE/ACVD3cQBFDhBbHsRWTSqlcZEUnfjUHksdngPYES0bv/dcyJHSCUyq?=
 =?us-ascii?Q?w29aZAKhyTzS6IWWCZVbNWfQOB2H2SaS/g0ixWrGXmXaVMkNHuZIAOuF5q5I?=
 =?us-ascii?Q?yVIxPCGmhg4I4oWjcjyUUBmy7RUEhOVNFZJNFF+7/M3gboOwucyvu3o+ugda?=
 =?us-ascii?Q?Eawv/xrt8iCHIbBUR9eRY0mlPiEHTWFbOaUkklVYmSJjhJ+DAk1fM6yoP/zb?=
 =?us-ascii?Q?nvt1qeQOOHATcZXCSRBCKSKqaRAXYJUQu8KF0M1De8yKHgcezUJ1IEvXyKT0?=
 =?us-ascii?Q?DxOBmoGQgIdtF8gOCcZqL4JwnHywDPqewXQXoocj+P01zvC5qMtgx5juWslc?=
 =?us-ascii?Q?kuYyckBHDRlK/P2k1Rark4F2TCyhcCYgNQ9eUS3DSPXQvdRK8fUnZZAc4ohL?=
 =?us-ascii?Q?pszou99U6RBaYoa36P2ZNnc6Jcw45c/18RDhPsmhk/48FSTPFGx1QcjG1jph?=
 =?us-ascii?Q?I2rRyulCc154eYanlSvmA9iW+GlrVvaZwYQpIhVYx+HDq69ZIU/nNnT2jYIt?=
 =?us-ascii?Q?NtxD7eTXkd+8+y314Q/I3q99f2GG/uSqHMLyDtYr8dpORx4RhiomUZk2r7KO?=
 =?us-ascii?Q?gPxcqaZWYM+wIm3woWKHgetdTU1y0t9wM2qLZGKL12CfkrqfWg7S4hDU9AY6?=
 =?us-ascii?Q?cHk/MO4xpgfIrCthnki6BhRa+9osOgzhMPWddITVNX+u5TRKss3iaj1Aiix2?=
 =?us-ascii?Q?HIBp2Y16mMEZM0V0aI3rLeLg9+5GC3CLts4nJbwMR0R8cPfWBqXT3iI1aULj?=
 =?us-ascii?Q?HCzWXGIJ2YMzSdLwwSLP5sUFnTvwVzjho9zWKE3ldlIOeVcWA4h+71hwnliv?=
 =?us-ascii?Q?UC8112QjAbFcth3OOd9rW387lG9ivJkHk4Hj7g9ycgoZgmMJOYKS93WriwD1?=
 =?us-ascii?Q?0WcVITFMrQM5ijGm24+V9CKW6QcQHbGYZ0F5fE9kzkyUVQb9TvNSlhxhFw5E?=
 =?us-ascii?Q?+qHhFcFAIYp+hcHZSKB2skh5Ih0pserPwvaj+IWredBoi0m1UC9mhkumVeOU?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o+xbTUrCuLi/YXzRNrpBbHlFJ2YcDn0ms2A3uhlf2MPdd+z9qImQbKnc08GZ3IkTOTDw8iAb9qOGbj35pm/LxyDAKNfJLEhSefnWg0pJ1y74w4Jr3fAj0wNLMmPUiGcdZaz1bfXmr9fVyooS7q/WrZCOHw03+bNwVSbDlvpSZxVKRySmIprgxi3os+egHFjKLIsiVCY49qXtAmxfyTiNg3jQGMfYvTn1ekhJldY++JsoD3rWIEwDa+muMIoQiftuCayBC3Uhr1Vn9BsauLUwwQzr9uAcEAdnTKS0K811bwds8kVnJlvDSoNdAiCMlHawQHIoC+ufT2lKso0ydDOC634BOrimZSUtXR4qLgChNEng3PTh/JWJUOIduQq/9g1C2KKswOnsFd2Fw4bh03hLF4MTPzo6R38ltPSg2sGLLDKnI4ERQZboRbpZ3NCIulSQtyrAKWW3TPa/jdA6Rdtd6Ipw37X7cFRImkkeG5xxECbqg50UFej+IuaMO+6O9l6yKwBicLU5dRAU7CqLXZl/YPCxuOoH6DQMi54S6qmfKTl3H4b6GHIzEq8VU+MSj0UXJPWOBu01Bp1TqV96FWFKgA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 065fdbc5-33d9-45eb-f964-08dd4c2c076e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 12:43:34.3150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vb+WXn3m8gPZWqYL3XYDLq7RTaNl9W1SPDZhJWrQAs2B0Xi9ZmENKuPk8SiEOmooIl4aqklimvNd30lNt/gs+BqV5HYg10ElzN6pAQZWBUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP250MB0637
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-TBoneOriginalCC: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 13 Feb 2025 16:08:16 +0100
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

Added 2 HMAC bytes to the command message

Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
---
 lib/tpm-v2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 9ca7933c094..4a082af78af 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -264,7 +264,7 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 space=
_index,
 	 * chunks below.
 	 */
 	const int platform_len =3D sizeof(u32);
-	const int session_hdr_len =3D 13;
+	const int session_hdr_len =3D 15;
 	const int message_len =3D 14;
 	uint offset =3D TPM2_HDR_LEN + platform_len + session_hdr_len +
 		message_len;
@@ -277,11 +277,12 @@ u32 tpm2_nv_define_space(struct udevice *dev, u32 spa=
ce_index,
 		/* handles 4 bytes */
 		tpm_u32(TPM2_RH_PLATFORM),	/* Primary platform seed */
=20
-		/* session header 13 bytes */
+		/* session header 15 bytes */
 		tpm_u32(9),			/* Header size */
 		tpm_u32(TPM2_RS_PW),		/* Password authorisation */
 		tpm_u16(0),			/* nonce_size */
 		0,				/* session_attrs */
+		tpm_u16(0),			/* HMAC size */
 		tpm_u16(0),			/* auth_size */
=20
 		/* message 14 bytes + policy */
--=20
2.43.0

