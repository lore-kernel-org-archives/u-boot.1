Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DECCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 03:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F078683390;
	Mon, 22 Sep 2025 05:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Pex353LX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D379833D0; Mon, 22 Sep 2025 05:30:59 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F51C83211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 05:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP1cfBi4FgcHdE4XTWId5cnrZ75rWKp5MfFkcCDfa55cHss/F6HDD+y+a36ClmG8vLBP+ajav3G+iKXm5n1P83NuGBiF786nTe7+3Sb9iGxLZWV7P45Q1YTUUzKUfvRe6xZFJ4RLIFU1Vzbi9Fg4MN0Ms+BVXTpCvmSyRdObwT/aT8QirCi1JpyWqIfZ7wS2oeJ15pXKcVSsPEsq3p0DZbiId0Lt0kz3y5hiVajDf2EFPqMkESlzZKkJkrLK/J9a87CR1StTwCyG+sk9pZvL/Pj8jWhHWoyUz7H6Fax8ieqoWA4Wg39Jg+hPEexKguun2YmaZKDDxmSfsN5OCb7EwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Hi2V+kUPT6x7jegj/EkpWLJbnFrgja57TaYMLfekgU=;
 b=btT2ynCdemReQy6sE1EMN+Z/rzZQ1AODlBEpd1Gklexh90S9RgcXGoaPYF8fy74bYbzyhQnD9ZpxeHK39StDp0/2DZXv3Jo5dZ7UyIIZnb8f/j57E1imPzU03epFPTCMdrSTMsNDf3+jQtVKDnlWThBbQIo9PR7Rl9cQNCAO/v1s1VfSa4uIk2KRWtjfJqGgpJsdR1U42LK5+ygTM+n1/ljhM9UzHVQ4NxMu0K90pfiNJemMKWn7ESdDA33sEYWiMppvmWr3c71FD5hZ7wjO4ZEncYTffVVJg6eIgZNgYtYAZTmj28/AH7SYSzte15IPvKX6CBngsNOCox4XRyLNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hi2V+kUPT6x7jegj/EkpWLJbnFrgja57TaYMLfekgU=;
 b=Pex353LXwPnXj+5n0hne1XCCLlgZksgMp5N179Cw7J7xEyjeXcB6B9riDrnUT8zVOdP8aRTNOw7824aL1f4wBvRltjXpi95Tx68LHVHH9vsZ4gngWNpEQZkVEbkahfCv2bVcCo+IiZp/PUS//I6oBjxZ+EMDGwzyQ5xe8z3mHaIN+FzfHqFkXELZ3tteY1tMFcM17pSR0cGL0/Ft4wkH5jQVSke51d31bVbA3+sokJeCQJkJhydG6c53u6+84FCPvxE8FnE7lgStsUYymKie+KzBCQdrQz272cpAcBmtBVnKl/ho/ZXkllMsRkSsaBA9dsDQHAqGdQj1qETAK3WQrg==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB5600.namprd03.prod.outlook.com (2603:10b6:a03:286::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 03:30:51 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 03:30:50 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v3 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Topic: [PATCH v3 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Thread-Index: AQHcItqsj39Q4ttV7Ua5MEMg7Q96VbSenHXg
Date: Mon, 22 Sep 2025 03:30:50 +0000
Message-ID: <LV8PR03MB813731F41B88C7F8C6200EF8A712A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250911051207.10479-1-nareshkumar.ravulapalli@altera.com>
 <20250911051207.10479-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250911051207.10479-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SJ0PR03MB5600:EE_
x-ms-office365-filtering-correlation-id: f3b21419-79cd-4d81-b008-08ddf9886d9c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oBFuRpn0aj1F4wCrQ7HMp4I8inLjN7p7a709CpUy5/2bwpUAFHli8HLtW1zw?=
 =?us-ascii?Q?CfkFtAnujCs2Wh4BC6GqOYoWU4zWNbaLHt1SEop+jLDHMFMPL7fX6vpa+JjT?=
 =?us-ascii?Q?pWI/hnBCZ1d8UBsvefB7X2/YVPaGPEuJGX7XphFUasS3O5rzL4LAsRW/Fm4A?=
 =?us-ascii?Q?42NivIquQldh6yTbulVDFRSVOj+x37/d1bPzsk6izA6ZO1Fy2Ui3IyVvBsvl?=
 =?us-ascii?Q?Qb+//SiBXGD5b5t1vqiiEw8LCmCUV6r4E7pGnMQ0YLzea42tXn3zq2vemy/j?=
 =?us-ascii?Q?+5u3US2WVxfIVr9t9nRlLQkiqAmMN4PMNfLYOAF+B6DlAv29rqEr2ZgS+IBx?=
 =?us-ascii?Q?Uy1iFpPldd4GlVjZVEIuHk37EyGWYg/CtPB85xhfcOUgS0H5IBmdAHQakgYt?=
 =?us-ascii?Q?ShYdQGzYEhd076Hn7Vh00O9NluxmzT3qddRPiV5k3Xa5XgOj0RIGQ8wsbluu?=
 =?us-ascii?Q?DscGtFmPMeYFUzMNWta4fVYw1YCz6TnokeSNeKG6WI+223j8NQfHVOzJEoQJ?=
 =?us-ascii?Q?QIV43quzhgdBYVLMzETMoSUIAs/9+qQoDYFQhJEOT7Z18iwids6SaDvKXRnj?=
 =?us-ascii?Q?fUWK33AUhz15vTYqF7UdLmSqZeuqIMKHlCXLg2iU07xE/URNvxJxvkhMg0Sg?=
 =?us-ascii?Q?DUxd1PDMhh7nkbXh4JBMVzXYfBcP7s/97i1UDhxeevwcoZf/holYJrHpW8Jh?=
 =?us-ascii?Q?bMgeo0G+7B7rDOK8u7Dg/6uMsNoteIaN+GB6jLOrehrlbhYM3uhSYH+xQsIF?=
 =?us-ascii?Q?kf11yBusPjCX4i56IEnpPSj5byoV6q07qBQzzKxFT0qXzVvvRy+nB2qb2TXb?=
 =?us-ascii?Q?vPIEsL0KixwMcfRPzjjaOi95eLFEdS9+3h6zmyVw1c6gdgg4L1kN8CfR6L4h?=
 =?us-ascii?Q?1p3lcj1RK7sx87Y4Jb5TrV4b69YQXjTvVd7Oc/SEeoQ7xlSpj94PanxDI/K2?=
 =?us-ascii?Q?+J6h8gROcNuM3HYMjaWoletCcVj9/oxYpLnUu5YkD2tPj7CSZgq0JT15Uw7r?=
 =?us-ascii?Q?iC/wh8d2uS5FiLU0HvcrfawA5kl5OBGlzn9qd1r1u+fMTyJBPr3AxDdQ4GN0?=
 =?us-ascii?Q?/n/f4H3Fd9jNL7vl0fmvyyQ5gTabvsOxnkL8447oBWUE7AEia7lEzgV7k49M?=
 =?us-ascii?Q?BIj5hRrPLR02HmfFPLdlXxmDc2DdMC4f3ILKf9LktoKmvIaiiSOMEMddDM0I?=
 =?us-ascii?Q?m0weXaJ5lhV9JlUFp7IZJ1pVunlxm1kPk92wM4JZO5Jve2HwJbo/RzOv7xzF?=
 =?us-ascii?Q?LK3wjp1mq7UkdnqX1gKiVErsyYS4/zg7TEQD3jUl+sQA14NK3N/Ha99Ml7ju?=
 =?us-ascii?Q?SIrrauNQRCxxVnuuGn/OpF5U/iEhMdd6lsEUK8slq04w3cks8Ob+Rn211X63?=
 =?us-ascii?Q?Sw29GKkIOEHBwgJMNIDUf3J/Fs8G9uYJeh1yCxUqxfwrtsW+eXAeJ0mY0iG0?=
 =?us-ascii?Q?ZuVBwr7blwE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q1wIr1MUsJm8ZyyVuzf8cewi0ViRUJfu/lE5QIM+r6lPdJJHFYTQcUSlGD47?=
 =?us-ascii?Q?4bsXqZypjGc7vUl6zYl+MCLYcvOmL1B/pEjSK+6ZD4C19P0eN6r7mqi4Udsh?=
 =?us-ascii?Q?XTOaLYairVMtATYzRc4PMV5oItZ110lZPPqyvI5+XJV4coveQaljMqVAzMlZ?=
 =?us-ascii?Q?DRkK/QMvRooPraoYICjVCZUl+EXUSwzvwjYgErHXQ8E+/XjYOIt2d03Q5/jo?=
 =?us-ascii?Q?0VtjZeHKs8pLOmU8jjxly94QxvbHU5s10M+kRYp4AMAtry3R88r8kzWBKrcv?=
 =?us-ascii?Q?FSG5PssC/RGG5KHdQLQ6T1VS6LAwiJtpBTlwI6LJJxvPLV/RFaY4pIXKhEe9?=
 =?us-ascii?Q?FioaFpgeXDSs53V+FND/ReAsrKNFZgmE4+h8zJ09FpQq9lS9izqlN6CjCXfd?=
 =?us-ascii?Q?UBExRiKJpXGO7GalAuN/RVKIMfmly0HyUuVPqyGRd8T6dYlA4EyuFPdDhwXW?=
 =?us-ascii?Q?c1HA76mDOwsZPqobZ92kcJ/CzaUMMJYQ0DSXvBGsQwcrBSWcWaFdwZOuNGZe?=
 =?us-ascii?Q?mskE+FrrxbP+uEdMkzgVob6SvI4JBTMMZue7ilnPNz65EFHYqZq/HckIp+a7?=
 =?us-ascii?Q?/1e8fovsx/vfBvheOLbM6H5hThuK4MhtYx1tVuRAjmDrQ9W/QSlM0BVCycyh?=
 =?us-ascii?Q?spAYyfXhKHDgU8euxeZYFWyzMTxFYM964ytqI53/LyzCMIk5pRtF3rKBt1gV?=
 =?us-ascii?Q?lKboa9JCIqyvfcCNfAzQScQl2Yirr2jzmPNuWdHZ09D7mXaPPXip+KvqH4AJ?=
 =?us-ascii?Q?KW1XDEDmWpaVj9bWW8f0c83uc2bbHp4eAWPnqYrXNsYl077snOiZ2Ydxf+fX?=
 =?us-ascii?Q?I5sW5zqevdbdrPwrRc0COWq/IFZ3iLhR87iWsUBMhy13UY63w4F03VBd/+Bm?=
 =?us-ascii?Q?mMhEHNWXIDkIl5Lhq19QIq4bJfOzHlkNwHHAOKlIxNlQ5SB7o/NtXlceAHEG?=
 =?us-ascii?Q?Vg2QTIUuz9a1ngYRkW037ah0hNsfRIvPWNt2s4RWJNAfdkPykjrF0+UM3Clt?=
 =?us-ascii?Q?Bnyfe1vveFow3wu1EnjBSYeeCjY61OPNDPH24LKknsCSKHqf5lvrxNEgBQ94?=
 =?us-ascii?Q?+c/94ynLocsjmabILziNPFflSmLIX9+pUm10Jki8Cs/NI+NO8EdIVuLhVocY?=
 =?us-ascii?Q?40eIv98aiJWOCXAiRJ/cxl3OEHH2rbd0y0g5UNwyUrBuBkg6dRCq3idZOjhT?=
 =?us-ascii?Q?AeHPFEyrNvvgKEfQ1krqm2UY36dOQ1WZ3BqZMUyRkbWfcqqr6DQoeDAM1Ekm?=
 =?us-ascii?Q?RkZQYEz+myQe1nt9P2Syr6slCW7YvhT/B00vH9z9hr6gvNzQ3Js2qeERw6Td?=
 =?us-ascii?Q?Eg/p0fk7eHeKKtwXfMeyTaHqYZrf3tJLI7Q3hpSQqnEQSP4GUJROLmdk16tm?=
 =?us-ascii?Q?5fJdTHzyR2sp5QWjYP3Z+JPqLcRMwjTvCc6/ZWNj1vz3i8K1Q6rMU15R/zd4?=
 =?us-ascii?Q?Sop3sylE/TjnvoHtTd6433pPoLCsTG98KET0H7RBeTKZ77AiTGlTDBR0127X?=
 =?us-ascii?Q?pXM1nI8lh7i4YqVJx/Xt0kS4mW4vuFHS5pgRTgv4uEpPxeTMB+O9lwdeBpN2?=
 =?us-ascii?Q?TTjhpy6aoXsxAorvMv4TzMo8sSv9Eythwj1Lwu8r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b21419-79cd-4d81-b008-08ddf9886d9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 03:30:50.6121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uel9iywFYo/a/3/JXqPIExqSuNI0MMUQDXdwijk5bWuL8jKyXUVTp4lNMUtca7cfRI9jTX61IZ2A1YsqqVD4gDpD39QsQ4tJic/zJFrh+Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5600
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

Hi Naresh,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Thursday, 11 September, 2025 1:12 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v3 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
>=20
> USB 3.1 node is enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  arch/arm/dts/socfpga_agilex5_socdk.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts
> b/arch/arm/dts/socfpga_agilex5_socdk.dts
> index 2ab143e38f8..86e6d374948 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk.dts
> +++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier:     GPL-2.0
>  /*
>   * Copyright (C) 2024 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>

The current code changes do not constitute a significant modification suffi=
cient to claim copyright ownership. Please revert the changes.

[...]

Thanks.

BR,
Tien Fong
