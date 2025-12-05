Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617E5D2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 10:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD471841BD;
	Fri,  5 Dec 2025 11:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D5784181; Fri,  5 Dec 2025 07:44:03 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20729.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::729])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86A5184057
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 07:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9vVlZm+tDqOTLrpCSM7KwXA/87xQkQ65rqUUPNkRnQUVr8dQZnWt7ZuS8UEP363Yu7ZcHOapSyFXTERelz7LxIsTvdlg6DRSFqcHwOqKg4msE4wXxZIzXCzyFR5nR2J0jrYn69GnCsfkzazFd7MaOwW1qnHHXdGTDTgjqn4YNIpkzeP1RteKJz0SjBiMsu7PgkpEFLDVF1T5jarlULtpdpfsoIPW5cYHpkHE/hn8Rn4UpJCEm7fA0+8CCTtn/IbocaakgSrj12io4/Sr44qH+fsvMe3SKYH7n8g42QhtnE3LGjIqM0GnlqQ2ta47kmG/y6sEenRJsiWopkpItUmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDvVx9E2mejEcnjcqQGZzTlSCyvvUalutUntGCx3ppc=;
 b=AIgSrlPNXCdVF7wnnlOAM0+dEXZTN5n4BWLfyU/lSwgOBnelRBZBif7wpj6tC4hxpsRDYXeqi6pHhqAbcghuL9zDpONzw8fT2sEGqKiHk7KjSSL27dbqoio5X1C/mvREp9ID5xIqnoTvy6iLgjQlHOL1oHhJxymW2V9aMaY5xb5J9EhtTLVUJ+DJ6PDqXsACpxPw4vktJ0ETSLuM4yusBes49/XrjFiavtzL7Rl3UCw9QvRw3r0OKQaO9aPEcRWpNT6ik0X6MEPn8BXmAhu/1hh6908gjs8Eq5pQ7xse8Ag5P58xI2rpqtVLhYosL/lBAZdzVHsAO66LQ6QWfm9WrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 06:43:50 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 06:43:50 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Liang <ycliang@andestech.com>, Conor Dooley <conor@kernel.org>
CC: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Topic: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Index: AQHcRMSITAF/Ez7TCUSKxA/KpCGn6bTRIJ0AgARk6SCAO/QfAIAAAoCAgAAOaICAAU2WAA==
Date: Fri, 5 Dec 2025 06:43:50 +0000
Message-ID: <ZQ2PR01MB1307333FA4ACAD7710DD3A5AE6A72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-3-hal.feng@starfivetech.com>
 <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
 <ZQ2PR01MB13075E9B291AF6D313AF347DE6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <aTFWSF-MFs40a37w@swlinux02> <20251204-exemplify-tribunal-bae6a028909e@spud>
 <aTFkgSMcRONFGI_X@swlinux02>
In-Reply-To: <aTFkgSMcRONFGI_X@swlinux02>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
x-ms-office365-filtering-correlation-id: 95352b8e-994e-4ffe-5ce6-08de33c9a61a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|38070700021; 
x-microsoft-antispam-message-info: Vi5AikR1ZsldJjbpFcjLOMJXNp9kHucyMRhJSUhcg+d1UFaTE1bYHLJaQwTAer31eDFYb0t4L9WPiEAuR30y6yfKPggPOUOFO2pPhH0ACODRPMP3R8rN0oJU0Mb119dvHP6n5a2/jedPIwlV2ukW21dmY3s2BBIBE4kLczm99rz9KBVNngqCQMrIQaNS5SCVulHWuRLKUPdyqOyKF5tTkisI8xx6/XJIcx/zSqs0Kz9bkipElQmD06boVC0XUAbSjl6GqnTOgpFQ4FMjoY5w+ajuwtjzn1RimHVqElau8T2N6zJS+1h5sr2anbLESWpxcJMI+yIHVR6okSuqvVyiV1b40RxpmhQqf1YjiwP7z7OwytK3H0RhBNc2RS9Uh14rnopmuqZngfh8vSp04W3ZKX1iP3VwOBsOQJrvBN8Mu/6VkV7pz+k9mjhAjJvYHmNIHqurErBZw8BYMqKqVpMDQeuWDur5VoMFzhiFXa7ELN77BBUdfEBiGUl5JwnZzKv0y6eVXRAR414/SWpzLRDyeBywZSAIMUpSAd8wIoOYEemR2lA8VRbTT9khoDMiGWw/16u1bdJKy1W0ExrlKO08QA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(41320700013)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IzpJHq5O7W6tL089w7s8OjIHy+ZCuOwa3Qz2h/Q6Ho1v1j8UTH1U/PMAjoeB?=
 =?us-ascii?Q?LRN0IXZIzeZuqLlQom7sTJY6s52sMmvYJeDD6iZ8S7aRHYIZGqpAPdbgFZ4K?=
 =?us-ascii?Q?smUkBQUINlR3ra3jyhIBeCNoXyPXPBslCkxPbUwf+ur05nCtz2P3A449muDq?=
 =?us-ascii?Q?fT4Gu6gq+s8Kw7r4NkO874OPcaH+Yg9KTqkW/Z/Co/Peda5/su2HLUeEb4YF?=
 =?us-ascii?Q?rhFxHFlrlkuVBJiL53FgNIIpU/tXxK3ZBJNm5/gX5wyZVmKhbAr71BHdUr1v?=
 =?us-ascii?Q?kObVc3WEN+8fNaF4Bl4TKe4Cc0wu96jIylcRONbuIl+UIvBEhhWu1N9F5hqN?=
 =?us-ascii?Q?UfWjw2kufPWuN0A7oSq7EqnCu9jOfKO1AdDNwLVGMoG2vh9DDY0zbEudaTVg?=
 =?us-ascii?Q?lOt4+zDE2+ubzvAlB6yg9S63Gba/ACF5P7TDr9U1b+0OoF9dEHVYA0I4XSRs?=
 =?us-ascii?Q?8ORCzRLae9HZtsmM5dWzWk6Z1BMCgAEYNqXkNJu/RM42cX9T3zFAFM+OuVbV?=
 =?us-ascii?Q?qfjbJcVApjXm/Ik76Bih1FlQq3Cv1u1HhZ0N4EXTSTfDzZlwkykCCRUqnxJ2?=
 =?us-ascii?Q?ZDJv1w56SplEnWft6tqQW7eFQIsJOTpvXXZ6kwqm/AyfxW2ORo33C9Yg7EcZ?=
 =?us-ascii?Q?H6jAX5nJoWqlDOYtV1XjGlkQ/whox3+mTqJ+lIGhZHigIVjmagjD4n6LsQBy?=
 =?us-ascii?Q?MNeasMYfody8MZL3WG0/n4iIMlAWo1fUkgOZJ+U5vP0KNVTc56l2ZY6Cc4pC?=
 =?us-ascii?Q?sEUgjJrrKA+ERn5NkThB+blthGkTDAfhAwa/TJooKDRP0LEl5pOcb7H/UaxH?=
 =?us-ascii?Q?WyoaOB5dlpQkTiCgLAWvOVnOwt/O6cMFi1SK4k0GXUvx0+Bu5rBZScnd9AdC?=
 =?us-ascii?Q?wPUNtgkx0XL7KeYgNU8aetnLzDJCI6Kgv5ERlf31UUOA9ZDkgQxUC0p9eT/7?=
 =?us-ascii?Q?ehL0uHMFpzIKXPgZRyYdk8dnmxpB4AxHetT6l96SNzd7xB+nRDW9Bl+AGKAd?=
 =?us-ascii?Q?mryTpMYJUJmOX9XlcPPt0dH+NAyrQKnA9gFIKQOofrN1Sdpi25HLUhQhZOtg?=
 =?us-ascii?Q?PgIoRFDcbl6yIXQFLtTZql1CMHCUWYLet5CZojAU1gz6yaUBzlUdlxyLGpra?=
 =?us-ascii?Q?eWOvSpr3w5RoHs6VJA5yoL9WCUPZvuHYmsMocj8pwNAD0e0RkYYi8AlphZgt?=
 =?us-ascii?Q?64NRze0He3zJLanSg68Ndjv0SVQUtbztgnNuznT1vr25fbVse2yrqp6VZTX/?=
 =?us-ascii?Q?LBFM0a+HAaQvxLyHCY7HD1/jl9/gBCouMNJ4a26z0+CmNqrvmdj76uQ+mDff?=
 =?us-ascii?Q?SuT5IEvV5jOMN2R5wat+gM9QB+e5YDw65N4PH9iJU3l2CB3n/wmJ5Ouq9tb0?=
 =?us-ascii?Q?PznUiYVMyhoDpUpJ2WTfiKtXwXMkBphKqUFkDA3kZbFdFFbGLTk+/ONwM2Wq?=
 =?us-ascii?Q?8QHLwPHBBoGvRmQ68Q5Dg1T+CbYmZ6wVFXRzn3WkKZ9nLVxAjXVb8grXpWgD?=
 =?us-ascii?Q?v10cssYHadiJBUk5PqqI/l6frVO5ygAMijmjy6HH3EZoZ8l3SEhxTnlYdPWk?=
 =?us-ascii?Q?Iw6vLgksDhwRRmvJ2qUpvs755EMkmd7uM31HJORj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 95352b8e-994e-4ffe-5ce6-08de33c9a61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 06:43:50.1282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DZ25yMLb8eQplUptUxHR5MHhE0XoDCvK/VZQoo90jP9g4w72+G3s+7FfkrUw9JOvKw5xkLdU0PTfb3Pt6pFAUEkgTsjJ0JP4ZeHJzw1cyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227
X-Mailman-Approved-At: Fri, 05 Dec 2025 11:04:35 +0100
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

> On 04.12.25 18:38, Leo Liang wrote:
> On Thu, Dec 04, 2025 at 09:46:19AM +0000, Conor Dooley wrote:
> > [EXTERNAL MAIL]
>=20
> > Date: Thu, 4 Dec 2025 09:46:19 +0000
> > From: Conor Dooley <conor@kernel.org>
> > To: Leo Liang <ycliang@andestech.com>
> > Cc: Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>,
> > Tom  Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Sumit
> > Garg  <sumit.garg@kernel.org>, Emil Renner Berthing
> > <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com>, "u-boot@lists.denx.de"
> >  <u-boot@lists.denx.de>
> > Subject: Re: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2
> > Lite  board device tree
> >
> > On Thu, Dec 04, 2025 at 05:37:22PM +0800, Leo Liang wrote:
> > >
> > > Got it. I have learned that the patchset is still being reviewed.
> > > (https://lore.kernel.org/linux-riscv/20251125075604.69370-1-hal.feng
> > > @starfivetech.com/T/#t) I will merge this patchset after the
> > > dts/upstream/ is sync'ed with Linux device tree.
> >
> > Something must have gone wrong, because I applied those and sent a
> > mail (via b4) that I had done so. They should appear in v6.19-rc1.
>=20
> Hi Conor,
>=20
> Understood! thank you for the clarification.
> I'll wait for the dts to be sync'ed with linux after v6.19-rc1 before mer=
ging the
> patchset.

Hi, Leo,

Could you merge patch 3 and patch 4 first? These two patches are just for f=
ixing.

Best regards,
Hal
