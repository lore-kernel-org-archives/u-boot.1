Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E804AC87FD2
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 04:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D17A83AFD;
	Thu,  7 Aug 2025 06:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jIAzNvoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90FC783B27; Thu,  7 Aug 2025 03:08:29 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12BDA83B1A
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 03:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1WICHcVOKNGiknrcdP0ArixIY4P3K2mLKc7mu+0TCAx50zxN+HDRTvpGVS7evj3lQV8UtMW1L0w/3h1/BxR3CXjP7VQPNkyiWBmYhAg3RRQ0oeeToHNLZauHiPzAjuMsg/kB3IY2pnJ8lLoSiyy2aQA9JJaA+gj8GqA6FFntZl6SXCOXvWNTZLgGYsxJYGohZ7he2QMRARbRE7b2shMada9x2Go9G0W7kjjtUvhaDg2H+az7D9Xenxp1PAFE5rgn1uGhlRZyfNEiKSQUJSOItqcHNmAPCcQUov8seomzHd4iHZB40NKipuhwpCjOk5TJ793zRiLsNw+4NzvWY0DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4Qro2pGF+4CjwJrO4VUBjtnP7ikwnTOybTqZVtds3c=;
 b=V4TxOpAJDIeFZU6NiF6rAhpyDPl7KdzW8uZZvQJT1oog6ST1KdjAY+kQtxH+c0dX1xqpxue7/ZYzK7KIS6yq5rd0ktIeE5Qt4gnW3geYIzdS4d9Gwy0RlQM5Wh4wM/geHRneQwGAIfQYdeN0ZIlizxq5cbghu0rLU2BYwPWx2tK79qmTsnFvh5vY2VdbEtosmyKFODWq8697TT3bgiIXf4mh3kSjaEc43ZtKFdtTbagun8/pyYzw/OkOKxutNddFbXoQHgXnWIex2tDJmV6HDbBMOvDtounWtnLd/CxiRctbHYcZU4KHVjuH2e+6P4h0OFtYxgsyIDbL0s1wK8E7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4Qro2pGF+4CjwJrO4VUBjtnP7ikwnTOybTqZVtds3c=;
 b=jIAzNvoUiyazlYGl8GZ/IyrPErBXQlIg+5TRxWI2aEUThMR3pd5YFPLaovEFy8jpu/PzbehPTgGg6H4r7tZG/uTWOLe/dJKbTyQ01vCqjnrF5FqWfS92axReIiOzFjhP+z/gDQoNDOH7aS3Y/P17pmN9d7gnyiGaisb2xNeGeDlilucqbqh+6ptjcaxMtcGsJ7h+9I6de3yUAC2uszQMxLXAx9oL1CCNT3DZZ4z1niic26uEzDY0mkuFBZZ/kkD9yuI/flMrU87YVNm4OWReO3C47fk79rat3fkbv7uFiArI36bUHdbjwAbWD8KDEVEhHpcHZTogG1zMqeMOb19Gnw==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by LV8PR03MB7445.namprd03.prod.outlook.com (2603:10b6:408:191::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 01:08:22 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 01:08:21 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: U-boot Openlist <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Chee, Tien Fong"
 <tien.fong.chee@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, "Rao, Mahesh" <mahesh.rao@altera.com>
Subject: RE: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak
 function in cache_v8
Thread-Topic: [PATCH v1 2/3] arch: arm: lib: cache_v8: agilex5: Add weak
 function in cache_v8
Thread-Index: AQHcBoFhEBHL3hwj/UehvObAJCQrPrRVpioAgAC7hoA=
Date: Thu, 7 Aug 2025 01:08:20 +0000
Message-ID: <SA3PR03MB7187B3809CE6E420A2715E33B42CA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
 <20250806032206.16688-3-boon.khai.ng@altera.com>
 <20250806135412.GM124814@bill-the-cat>
In-Reply-To: <20250806135412.GM124814@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|LV8PR03MB7445:EE_
x-ms-office365-filtering-correlation-id: 650bb2e3-3031-4853-311e-08ddd54ee67d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9097ROjZcr7f5TiKColh+6PzPmbAs3TYgNGMaKscRiX6vRsCma0AkiNlvvyn?=
 =?us-ascii?Q?daaSceW3FUG2Zdm30E6K6MeW5tUXRufXtxFUXRuIqoZ/wUeBXG+DBu5879bo?=
 =?us-ascii?Q?QjLbmDpXdSMrInQGhewjdF9Dx9McyeKNyscFl6NjR7d/iM6DpIeYbtGW0gHY?=
 =?us-ascii?Q?7rWpFvzVA7R2xdiOTgTv6AsXTh20glXxRwlHTRSCZzEU1jSkCZhIq+9LB2ze?=
 =?us-ascii?Q?NnfngnfvzoZkAcoCoQw9P3TZVNPPOwQ78SDCY6QPFURcltq767gD4Ev70LEv?=
 =?us-ascii?Q?ccZntG9xitnWAj4QlokeDy3xGPw0dp7w3rDwPYhWUTqKja28uxQkWUV+jK24?=
 =?us-ascii?Q?CdUpC6nn/RVl57hCFKdhiZSGVi3JgqRG/YqvZcTHBqqs1OnB66h00RZ12p+i?=
 =?us-ascii?Q?+0bTrCjzr73HowF3Aif1/kgfQvaAujMz0t+9MRgIrNmea+N2rrDt77EbFDNS?=
 =?us-ascii?Q?hRj4zaF01o3hcrRF6ai+0+FgTpAWntbsB7OleIxg8BVFoGmiGzePwLeKgx2I?=
 =?us-ascii?Q?ZJkGI+R1p7TTEDcUVEfTAp9nEL/YTjM366xyTEw2vm6JEQSOQWCrPjQmlo7D?=
 =?us-ascii?Q?45i19GxfOhys16VMG9OvVXM3zepmjW/FzjYvabj5EPKpNgHGNbXkVH57ngtE?=
 =?us-ascii?Q?LYG7fpr7yNZsjA12/ycxjMN/W048qWGtgO4OizlhOBUi8AMXmPebuDqBNUWw?=
 =?us-ascii?Q?JC0NPf7lC/oS/U1kEwkzpNLbddMvLP2huJmoBfAfbZqsiXNyC1UYgOo0Ap2e?=
 =?us-ascii?Q?2OxDTwjPNFQgGb0fx25EVnjjZ4064A/DoAWG/ac0ASe3pk5gJwcz3SDOiSFu?=
 =?us-ascii?Q?7IjiUkFHLmg63wrFxS3BWLDwuj20B4AfTOueixoiauaxp5dY5GfOOduLuMpp?=
 =?us-ascii?Q?R/Za14IIxO6wJ9Ud4ttPTBukTgtEJg2wQJ5oA0FyCai3Ymcj0QeNGsEv0Qzh?=
 =?us-ascii?Q?RHUHssm8UqZKZvQrh5wSl2X6BkBFG/mk4MzvgnnSjHMvJJNs5yWQ68Qb2Q8X?=
 =?us-ascii?Q?SDAk41BFFm3UOm2QMr1mzX0RKGzL5bg2Z/xO1SZUpDKqiJQVn83KSis75DEb?=
 =?us-ascii?Q?UT/rckrDjgW7SM6J5AIG082hmeZ4f1tYPSlZE8rcYW8BqWvXRt80iftAp5GA?=
 =?us-ascii?Q?9igSfLd1Hw04tgxoNFu5DBiI4164gSwyqmdOsfyOOhduekf09i+sQzD5oaX5?=
 =?us-ascii?Q?wkKU9uU55pk+kJN81eHpkMZ7b1cOv3jX0F/kDRabK2apSpTl3v8i/NldA9AB?=
 =?us-ascii?Q?W5LDlTwwVft0bAxqlEHbau6cvo8G+HlhteKbKYZIGoN+WYrlhZ5yFy5ZkorF?=
 =?us-ascii?Q?ZxlKrnnDeD3bPFnLoTdglXNLrGW/hS+BOfc3uuB7WTXWce3LBT4tP1sxbdi4?=
 =?us-ascii?Q?hZsc/0YCjFptGACHydpmCXhbkEjZ0V/WZ0Z4in7rCZ/ozr88zbXC3uUr5wwt?=
 =?us-ascii?Q?XLsOxYnLC0OzpXqNwxffWh9qRC5UWBftHfXuqvagCeo9FBJZ5GX/TV0NvkiM?=
 =?us-ascii?Q?CmsWz+QTGzv7ywU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GOo/jV1S252DTMIjZpmqQn8u68OiZT6LXjc4jeJ68HRKfDo5jix30+F/BkWr?=
 =?us-ascii?Q?pfXmCT8oIbhRoyhhjaw0N/UWUV+SSr+wlrZxfdo7mJT3I0oLbE1nJ9P8syG5?=
 =?us-ascii?Q?ROUet7ASuPok2kBwcV5QXHHoDrnxW0Mr7WaJatCvFjJrJlpv6DCxnnEoVYDH?=
 =?us-ascii?Q?1a/W6oB5ff4llFHyBCrt30rlRIh6kIGLOzvrnkoAR2E9i3QQ77fP6Hik/5hR?=
 =?us-ascii?Q?IQ2Uk+UMm2m9u2w3hRjNnOZBMskInLgR6sGVEycszoio9Yzy7zRwzKLxKqDU?=
 =?us-ascii?Q?DDxiu3YOqRtUC7kL1BKEDPtQpC6ABGfBUadc93DNTBU6T7BFvsATFfW8npFF?=
 =?us-ascii?Q?yoDtzDN01fjqZUHqRLk0blekEQv6E6uBmI733CBTCIAEjo3L0LvWer+dkbfG?=
 =?us-ascii?Q?8RN9C3yMz5xNfgb924xIFkT1DhMcrGrImdCX/dswS5GOjAMDfBzHNbrX3Cof?=
 =?us-ascii?Q?GWCapvwy5Z2B8ySXOE4gbsKscL9sz9vBcasppnXm/CAi9LIcbAxn+w2O/snn?=
 =?us-ascii?Q?8IaJNgHLKGUp3Y1s0kcWYoV0eR4Uz17WvDBj0qintKjf35mECu1cnaZr485S?=
 =?us-ascii?Q?k9pSBykDEJ4oPfGlnOM5DYn2EUUSqVABX4uXJEvJqQQIPbFGaKUKWyOnRlHv?=
 =?us-ascii?Q?6WrD6+/y2OeLl1kYGBQnI5RaV0Uf/plk7dg7bmcdJoEZ68d/+B4HBdw8oqav?=
 =?us-ascii?Q?YbAxoY0HZ09ANaXhJtk52K9140UM/srus7/NXIPGXkUI+GmEVWnGoLURvJP1?=
 =?us-ascii?Q?SLFxBU5keWXt/lVB9t1GTd5X6jb5BXGjjvzS64wP7YpoHaFwsBHMy+p+wUbv?=
 =?us-ascii?Q?YShg9K2vgxGibedtJYHNuTIO3cKGZGzKWlHN6Xeq4h6NzSykhuYl2f47PJro?=
 =?us-ascii?Q?8E3aZ8EpEK4vCJ8Asj1vSyJuMTMsfnPV3jEL+mlq0T/KLwF9fiUNrOPCaB89?=
 =?us-ascii?Q?cGnTkIlQEqGaRYwp0YMnM+04uD1TAnpW8Vm0o6rokpQk11mPpSA1GAPKPWe2?=
 =?us-ascii?Q?v2cQAtEwNDWDquFvy6/VbAihQBKdUi6xe/YCXsCOmDMVEMFiB44eXEnUacPB?=
 =?us-ascii?Q?JgfnsicnmkwYv1PCuJZFsrwNFvVkbuXmfSEp1mK5t9By3bJGrcO6P5wtbOA9?=
 =?us-ascii?Q?Zq9FzZI1bLEGsoNUQfxfDDZXEvxEosLghpW9Dcns4GaZ7Vh/a6z1QMfr4P0X?=
 =?us-ascii?Q?OBe9MdZObmvhD357F5if9CwwtFp6kl46SvU/iUHPxmMkCk3JPBNDrOH4BzYr?=
 =?us-ascii?Q?PsKxmG3aFSeiL4cTIGEvWT47fZChXuCG1QDOH4/qodOl1UFbMNDUlPjMGfWe?=
 =?us-ascii?Q?0NvyOM7biSC7HhdGDZad4oOT+5dRO4eOnibzBm55GuxaBvGJuf2foJzaSra0?=
 =?us-ascii?Q?qTB6mk/xNWzdhXOGXb8dCEUEQgfcxZUOxac+bJa8TI3jzHVxPc9ZGHTVlWdj?=
 =?us-ascii?Q?x0dC/H8ve0u/9TuTrZNqnAdS76IvqAc7Lv1/OZPDhjxSs4QNCSBEyH88ZIza?=
 =?us-ascii?Q?jbyEQ/4ZkNQGBJyBOncDH6zsAATc7AI7+CDk+FMizec2JmJnLZnXrnRZP8jH?=
 =?us-ascii?Q?EAPDFD+Rhg1iCc2RIR81HKJHRZIykiYzP5ilJing?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650bb2e3-3031-4853-311e-08ddd54ee67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 01:08:20.7568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1MXZlvkXXUGE0Guoz1reiUd5GTx3gIIhmUkJM0oyluYwZgO3ZFsHZEO19J2YoFKKGxyB3usXgctvmnCDmEpLiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7445
X-Mailman-Approved-At: Thu, 07 Aug 2025 06:50:24 +0200
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

 > The callers of dcache_disable/etc should be doing:
> if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))

Hi Tom, just get to know that the spl_atf.c already implemented
with the fix above, will follow the fix in spl_atf.c and submit in v2

https://github.com/u-boot/u-boot/blob/3526f990b
77fca1c933f1d8b24eb9385010a05bf/common/spl/spl_atf.c#L206

Thanks

Regards,
Boon Khai.
