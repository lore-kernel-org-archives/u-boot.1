Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25880E9A03E
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 10:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17DB83AC5;
	Wed, 18 Feb 2026 11:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hit1cQhL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA67683C67; Wed, 18 Feb 2026 11:03:54 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7243F83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k11rq60hF83DNDrdk1PhhNBw2qxQWaYUcCIAy74k9/GYcLoo5znEOYVMcYHioSfjG7oiqR4AniszNVYyfqu01DahjDmLj12YPD2tTTxZRSJfxaFY6osaF1nYbjI4RuebJWhE0FA81dtom84FHOv+K7P+KirNQKI+sZ/Al8GIK7D1+K3dQ7U37+bcVlEtlt+aSXASTlx/lbxzYbHLXy+j08dv4mW8Dnsg9s7ZNO3C4IF3k6R47XQsQAnT3TK4IHmY7e5V6dot/2Td6t9dtf9qdAfsArxw3A9sFDb1zf6wFwhesjJq7hNjc+4Us2JR/p1Ya20jQ3xzcJ6Bzxce0S+YYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYnpgZqlwByXSlrNQHbtZjnjBzbViWviwjUr/BoCgN4=;
 b=mbtJI/G3tqbuZDTnkqtW60RMXn/UL1wupmBjKFShAzp2Ij0YDG3hPS3YhFUjOfHp8yhoPublF1YBkoCL3O2rvaW/ucG4Cqy0UMvsoocQGZNTo2RIuHWBos0qRjOv8WLinUi6ZJV1eZiQrD24yejQfiPbU/43MNp/DSgC9qpzlmX5nc9joMzDfu/lKN65SjIU+yC4+KYIJveXnP26q1OmXPF80/xaJCitABbAPJfmDXAj66dLKl1anDQixPbGzdFEKWeUhd08bCoaNmqA9TLRnwpRwbeyYKTtQnwKS8Waz7i/3P9gbMkPxBo9LDqqrwAtB8Nnl26tWlUr6fdtoCARbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYnpgZqlwByXSlrNQHbtZjnjBzbViWviwjUr/BoCgN4=;
 b=Hit1cQhLXMC0f0cyhDw5MOS72kiXiOmCQSgod7md7Qt01WktaWxd4CDCFE7t5cCFh98N+Y4vJTTVfGTXAJtpxkoeqic+EhggtApgkumAZpopC4slD9sE7yT8aCa6UYuVM4MsnlvtafDnWCropQNkjSsTqBMzEVzawxeUfzPu8Zg=
Received: from PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Wed, 18 Feb
 2026 10:03:45 +0000
Received: from PH7PR12MB7428.namprd12.prod.outlook.com
 ([fe80::e99b:6a9d:278c:f034]) by PH7PR12MB7428.namprd12.prod.outlook.com
 ([fe80::e99b:6a9d:278c:f034%4]) with mapi id 15.20.9632.010; Wed, 18 Feb 2026
 10:03:45 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "marex@denx.de" <marex@denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] spi: cadence_qspi: Disable the DAC mode in indirect read
Thread-Topic: [PATCH] spi: cadence_qspi: Disable the DAC mode in indirect read
Thread-Index: AQHbuY4ZX1dcaDia5Eesv73b0MkfebWKB58A
Date: Wed, 18 Feb 2026 10:03:45 +0000
Message-ID: <PH7PR12MB74282B424C0D91F616819527EC6AA@PH7PR12MB7428.namprd12.prod.outlook.com>
References: <20250430050923.135256-1-venkatesh.abbarapu@amd.com>
In-Reply-To: <20250430050923.135256-1-venkatesh.abbarapu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-02-18T10:00:25.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7428:EE_|DS0PR12MB8503:EE_
x-ms-office365-filtering-correlation-id: 3e897018-d256-453b-8b67-08de6ed500a7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6x8v+qzVMOmAvKr8x09hk1CvDWFqlPcLSUMja246KOAWRdy/Es9DdqLsbvsd?=
 =?us-ascii?Q?ZtGotzjCy259HTjJ+dN+kNZoDmHAsjqe4fGRlUTzFqtE+PzceYEk3BKqY/xa?=
 =?us-ascii?Q?1+2qQ2VQ2CWn84SF9HEIEaeVvSnG1Bnxs86fXOrOzKFOb9kOsNVxkJu3NmMH?=
 =?us-ascii?Q?fx9ysun0AIZsIgEwoCU2cBkXdyh13rjH/uhZUhV5I3L7HtnlpW+sCqOotN0K?=
 =?us-ascii?Q?+Mr9sWzYDJtocTikuVw8xpugerPwZ3x0HRb3qJL7jcjybZlubwaBrFnlw8Mf?=
 =?us-ascii?Q?esDAyAT9cOSybhWtBWPqHexZ0+uAATXAiqV6fuLifYkVGxHhMNmeDKW1wxOO?=
 =?us-ascii?Q?HbDh7mRFFqNCSqVRGQvr1ll4+SlM35yLfEQFadcEtrJvNJZMHPV4kiZ/WL+P?=
 =?us-ascii?Q?AGktfI3mhmr8A+bVh5LDXlzPzi8Wbw8r5S11f0e1B8yzNZptQgHxpj0eXe7b?=
 =?us-ascii?Q?Sgrg/A/Raj27Iw8WtczGHYkokK30ZFg2Elze9Ut62+jMY8j0Hcz0E+LjVsLj?=
 =?us-ascii?Q?Ir7MJOxwZHrdeTvevew3eZz4JUtH/k2U5ICFSyKtHzhEBLkX767TZ7/xC0gO?=
 =?us-ascii?Q?7GvrXvvmu9lpjlsPjkTviRdfzDksZhkJQodr4vr/UP08WEanVZZFdLiyDcYH?=
 =?us-ascii?Q?Ktm5+lOWwKx1kaAWa9usPx2UxwAPj6i93bFTfJYKcgwvqInUtx6UX98JIbqT?=
 =?us-ascii?Q?PatX/oFtk6s3hvEgZs6ngihSygSmUmG9rW7pg9xui8U+/MEQJF1r9pA56npo?=
 =?us-ascii?Q?FLYLwecpuEiEfOC75rdchC36ViqjGzJWSpXllZ/e/ukhe9w1mxCo08y9NeNe?=
 =?us-ascii?Q?Jff110vFGWqoOdJToDhn1NCnC1KOejcHuS4eoLY6L6G7knxMibPLPf2JIlpm?=
 =?us-ascii?Q?ElK2il1BxUucic7xx/u+7+U5elKMhRpE+WXpoKMgIHCYbfGJ6rInkU5raIKL?=
 =?us-ascii?Q?LU+o8ptzlfSJxj+B1dy6MpETKfFSOK0TjERDskzRZ49GMgl4C0ZcxMQgIvFx?=
 =?us-ascii?Q?hY6GZjcpHD/Yz7EcrwLzJ9UuSU96p/I33ZH7vAstgMx3nbCZDAjeb0Hm5ifb?=
 =?us-ascii?Q?6fI6nuYCfcxOv4dQn46Ubg+8Nf7YlsIVFr0zSrCKxjLeEWE9VeF8lHBm8rrR?=
 =?us-ascii?Q?k0Oe6dhXWvenc19j9FyYypRIEi76PjjIG74nSfOev+hy7x5XDV+vVCP3CIZD?=
 =?us-ascii?Q?ZXUPOOVysS8KVeK9to+JG9aOtmiLNHHfp1Z2aQ/elCitDKtKPZp0EUDUhNWi?=
 =?us-ascii?Q?DlCkuHsEHyk/meC1Nn1tDt8vBr/ZNeI171dhKRbis/xJIGuQMuD3Ilgiwy0z?=
 =?us-ascii?Q?VqZW3+SSeQYotf8SVpMu/Qk/6Lxc0kg/lm+47/CKthVjF5l1swemBgvHmo+i?=
 =?us-ascii?Q?Fr59mFi/Ya/cNHUkTibwcW76ZB3Xd4qmoi3ydB4446MUJKs82Xsl0lfHIyvN?=
 =?us-ascii?Q?KyoG0tZrKbjFNsnfXCPn6h7QY8/gB60A4qacJ49io4mq4Y2c1vQsNJqbRC7x?=
 =?us-ascii?Q?/yGrWB7Xor+D76QOSuAUe6FX+L86UrEMUIFFYXCoJph1ViSXvtQ2+pFf6V2O?=
 =?us-ascii?Q?Biav0CRBv8T6RUUUn35X4fKLvlFZxdWODYWiCwkV548SSULkDvOLMsMl97tD?=
 =?us-ascii?Q?Q00APuzB0HHBkB8CRbx3CqU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7428.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InkMxW8SQCkcVGXCKdFCuuO5/pZYLRQZAHTQhu4hLuMzB/pFz5r5PjTQ/SG/?=
 =?us-ascii?Q?+rErZO+CTNsCf8WNY3wO3RsrERm9CiN/trPrQamZJcbg8kXKLJ4hjUYsXEty?=
 =?us-ascii?Q?54H6OSaE6LLFCY9/WMed3p9rRI1ScIhoM7jZDQp/iRDsn5dsfC4MaLeCDam1?=
 =?us-ascii?Q?ttKlcy29aCtuIrBm8rBYInOfHpnJuMV6GX7OnTxCAY+yVjDtjxo7RTffJXRg?=
 =?us-ascii?Q?HNS8NC2DtVsuZoBhM7w5ihw7yLHNXmMlJSgkBoabBujYEDodjg6BbRSrPzQ5?=
 =?us-ascii?Q?VdT3gZ9Ml5fyyZ+igZbCGAQ0DGH3bdgUgWWAeS2kH7GABt2FPxW1vYst7DV+?=
 =?us-ascii?Q?NE25qmW5UcCGgit4OYb6Kiih0p8mAb7yyOYRI5j/JcVrntcxNKZUbNpvZf9e?=
 =?us-ascii?Q?ZNSNR37xLM3sTsTuseFL+owvNjG/+FpYGn271jzekCIJUxwn5/+sVpx0bqo1?=
 =?us-ascii?Q?5c6SZCIclXgTFtp7/2kwhUrhmIQ7YZqd4tk874mEnw7wsXhbweILwKoTyozs?=
 =?us-ascii?Q?XvrdCMu3WfpYCBnSnr5aCefvkz9HEToysL6ivGomed69p79pUK1/P8zkK2/M?=
 =?us-ascii?Q?1O73OH0n/SUSPwQswsW3u7UrlyGGsDaQc/Vdind96zFW2c7Hts/1DiJm6JcA?=
 =?us-ascii?Q?AxOGBbKJYpGZWF4UpFU6sES9xQLnBQG9v/TKYLJsqEmOTJVD631pDiZ/1kLQ?=
 =?us-ascii?Q?r0aEfMz3+S6DeQyxqXilCh6ckyideF2mbppYfO0IppYrzzHk2BDzu8c/KcrX?=
 =?us-ascii?Q?Y+dQ8yfdM/dOARIYmwl7s6NU8upfvgiS1DOsJ863taoT398frNDLwlGBrfyp?=
 =?us-ascii?Q?4tAfePDLV2VDq9+GSJX2Wwhs1HESPOgeel2zoAVLSVDY9fhxpk/kQBPgGVz0?=
 =?us-ascii?Q?j0E9RdFqOnCGSTaewJzDQOJCSOwG9Qs6VA5WTdOa4BsdrwYuprpnTLS/1b+e?=
 =?us-ascii?Q?cD5N0jAGeahEsEwEh4d6F5dICD2HKyUJT0/iidzuOHrgQn6DVyQX3mj3cfvG?=
 =?us-ascii?Q?a/ZRrqICthyh12jvkqHdA+cjSkXEaO7CbR9b1Mkz/SBg4zkiLPdz+/TqxhB8?=
 =?us-ascii?Q?tL32e9UQ6YjwlMe/KyfQCmSQV1SrxhKKZJzqGiRf2vuQBrkzHvIpXeQMcZ3T?=
 =?us-ascii?Q?nzX8DFgRd3OkZQ7K7wt4p2SK3ujk5ZwYAfhnmqMjWCyyik8i+nLZcMHKhNj4?=
 =?us-ascii?Q?qieP0O+EUTA793X0S6ICa1H27csURXZiII4dpJ5KrqQTYsqQmc2guvY2I4bj?=
 =?us-ascii?Q?gmJ8m6pPwvGaYk/iiuuYUqjUBPwhK7MB3STi+FTuZDEW6xgojDSIMD0SPChf?=
 =?us-ascii?Q?v8E7CmIL0aZpBwioOb5oyLMS6qAbSSAbkx0CLNnRDwF8jbI2oxRj08KPZ6j2?=
 =?us-ascii?Q?aCs+Uz6uYbP6OVfroz+DvvMjg3ZzS4Gj+2NcSAN4F2S2VBItRc9U0kZYp8se?=
 =?us-ascii?Q?9Fn23XjZw87K9smj4oIugeg2gIKyk0HO4Rd1EAFjm042HojOAEpHsbXFna41?=
 =?us-ascii?Q?Pyow1Dr9bMRImZjgkE+RPve9k8l5jjbgYT9U4wcMy8WWULZNXgE/XwIKQoe8?=
 =?us-ascii?Q?pWD5N8mMRoEo+gqvXKJjbkd8DFROOgv1Vx8CaUsN3jLYvqnsQkXyGmxDQUVd?=
 =?us-ascii?Q?XmIr1f1e4RjdHyvT02t6suIA3ykc/5HG+3sMDklo3hrTRM/jinS7QQhEIxZB?=
 =?us-ascii?Q?w88xU/XZ6/s0AyqPT1uWmEyrANZRncV9ANMk5PjGvYyJ82pK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7428.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e897018-d256-453b-8b67-08de6ed500a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2026 10:03:45.1006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJ8SjW/WSmjBMXtnyp0KBi5a+07aA/2BDw+JTXb+4FcDRalPl6Nqz1Q9Ks1v4c0zJE/MvLm2qklXiPEOWSDzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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

[Public]

> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Sent: Wednesday, April 30, 2025 10:39 AM
> To: u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com;
> marex@denx.de
> Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
> vigneshr@ti.com; u-kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
> caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
> stefan_b@posteo.net; quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.c=
om;
> p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>
> Subject: [PATCH] spi: cadence_qspi: Disable the DAC mode in indirect read
>
> Hang has been observed on QEMU, as it starts with indac read and fills sr=
am, but
> after dma is triggered, it tries dac read instead (based on priority) whi=
ch gets blocked.
> Disable the DAC mode in indirect DMA read and enable back for writes as D=
AC
> mode is used.
>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Tested-by: Padmarao Begari <padmarao.begari@amd.com>

Regards
Padmarao
> ---
>  drivers/spi/cadence_ospi_versal.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi=
_versal.c
> index fbeb0c6a85c..a78a282c543 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -36,6 +36,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv
> *priv,
>       bytes_to_dma =3D n_rx - rx_rem;
>
>       if (bytes_to_dma) {
> +             if (priv->use_dac_mode)
> +                     clrbits_le32(priv->regbase + CQSPI_REG_CONFIG,
> +                                  CQSPI_REG_CONFIG_DIRECT);
> +
>               cadence_qspi_apb_enable_linear_mode(false);
>               reg =3D readl(priv->regbase + CQSPI_REG_CONFIG);
>               reg |=3D CQSPI_REG_CONFIG_ENBL_DMA;
> @@ -116,6 +120,9 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv
> *priv,
>               memcpy(rxbuf, rxbuf + 1, n_rx - 1);
>       }
>
> +     if (priv->use_dac_mode)
> +             cadence_qspi_apb_dac_mode_enable(priv->regbase);
> +
>       return 0;
>  }
>
> --
> 2.34.1

