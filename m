Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C196AC31D97
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 13:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36244885D7;
	Thu,  4 Jul 2024 15:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF8E988476; Thu,  4 Jul 2024 11:31:34 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20716.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8812E88363
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 11:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnyUGUtD7bd+pMSCMmssiehblKYkIwxk7Op4AwHWC/qM+GKLCwdcW6m6wDHGF+MxCNmMeJteqJHRWVKxWwxLgixFff/R6Utz1srScWrFol3grOHMMK4lU+ImJkP/eemOTw5JRMOsfNU1zv2jkjB67JvMOIHhHoOxsy1Mjm/Bh/0ol5N8Xme4gQks3KyPDzrGDdIEzhg00ZNmJ7VHmaZ3RVC5qghIfyCkVib022TgungsVx20w1JvaneybkE8VA1HCGWL5fyNUoHiIuS+P6IC6PV1p0uLu5rKUHQj/6QYogh66+pkU7xWv9dKcvBSneTCKOpZP9ibDp3nIeMYHxgpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFda6Q2LlRhGQ0OsiKgRE7eglMEYYJ/SmQ/9y6vz7vw=;
 b=mR7nhNGzFsuVBXPvQZBCvBuBrG9rs6ykVjmtdVLIPe2KqDgfoDZKyrpoPFYgEtEd5IN1LJBSIdEY9mcQ/Jxv2TDpXa8q03fLRGUrCSJifkSy2jPEAmUjVniFtWGUQCVaSCbYZ15Q47tzq6rUP6Sk/iPBHJgrveguKJ9uqKdyJ9/NGX1QevIfzZdbquPmMaSKiAaKTzqYvA/z2M1i4ragbU6UcW/L/7Xqs9s/gHLLhDHPBJw9YDbCFPIHMnH4b3Fciw7mrNRrMirQDlOET44nVkc8cH76NihBB1N3vH5aZ1zT/79lY/Ybhle56I/vWKSzzxMOEYX5wbCsssLXjHIbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 09:31:26 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::61c0:a8fc:1462:bc54]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::61c0:a8fc:1462:bc54%6])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 09:31:26 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, Tom Rini <trini@konsulko.com>
CC: E Shattow <lucent@gmail.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Rick Chen
 <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao
 <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
Thread-Topic: [PATCH v1 0/4] Sync StarFive JH7110 clock and reset dt-bindings
 with Linux
Thread-Index: AQHatbnIbiLxXnmCIEekLm54C2xuSbG2froAgAHmwtCAANo5gIAAEX4AgC0NIEA=
Date: Thu, 4 Jul 2024 09:31:26 +0000
Message-ID: <ZQ2PR01MB1307D26D401D59133FF3863FE6DE2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20240603132721.6522-1-hal.feng@starfivetech.com>
 <CANV2PTPjbYEWr67bMSM_fg3kSS4Q2kDYdcHTLVp0CrQyeT=dbA@mail.gmail.com>
 <ZQ2PR01MB13070E142612139A6D955820E6F92@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <20240605143515.GP68077@bill-the-cat>
 <20240605-process-thinner-9ceb66006959@spud>
In-Reply-To: <20240605-process-thinner-9ceb66006959@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
x-ms-office365-filtering-correlation-id: 03370f15-6e59-49ca-2147-08dc9c0c138c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: V/uCRJD8p10pFI/LVCRR4gInm38dx7lgvrkNX4qbBimhgU5L1ZRVEecdVyb0IEFYX4tHZF3ACrZluf0oOMCo1z6GA7WZTRddL7ecHdyYyC5I1aPVu9F4u1Rtf8bVG0TK9GjJ0T1uFelyXwz6bgn0HyVx7GYfUFFUaFfOjzNy4N7h5WBxmPYrBNHwJKE6aXwAFZUqyuPhFPexDk6EPQtHK6fnhauAkdENttFtFQxOo1TntLF7INgdyud92WuSYoLuQvKWas8yhKr88B3ABPxx65nITO4EHPDQbDAr8lfn53CODTxPPi8LW7C+IaKe3YpbJRwd1KIPzoWj89TIRPgLZzeF2klHqMlfY8cZaeRl+7A4wjudFeTdeI9xfv0lCUeoogAk3LtM5M3UMNSVshq7pidn1AgXOfgnlIessimRD5FKd54OOYcujQjvx9UgMY1ZncrLcH6MIO7SK/C2vxH7gdmeWgMI2XWOysrCQnSs8y3tEQHNTdFYx9yYX4n/gtMN35e0LcWbAtewSWhcjFkCj8jyqI92Pg8nomKVeagML/lsm6o7f/spDNP2dkFGi9KYAMpS6O3hYQA/2b830wrsisQitLi3mwqATwxOpficxsNm1wJoF73a2YV/EemTYGIj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XLGf6Faism8KY9ZxIzzDVkakyqE6e1BqewoJ7YnHBhAf1Q+eL2Je2Z1EXv8a?=
 =?us-ascii?Q?/1qtz+IBR2FxAP6NGSekrfrw5xk1xlfi1uu+2BDm9OR7pdGxeIPotHOuuTq8?=
 =?us-ascii?Q?Mk35ZfIdNlsA4AECnI4Y+ZPVA+Dm9KoQNn+M7CI5cin97INil7f+XnBMUBMW?=
 =?us-ascii?Q?tYhkSikRks35cj5FbY4HRs0aLrwKpZq+zi7IWn9eg28RAoNJ7aH2FsJuVQbc?=
 =?us-ascii?Q?7Tpvh9Jdko6aXxmgC3ZFXBR3cvqHMxRqn4SxEJBEsq72/M9gJKQJBcqm0AZU?=
 =?us-ascii?Q?VEMIl557EmKq/aksKTHJXpe9xu+RexZgOU/bTIAkojenltR0ZsqSTYOmGNi3?=
 =?us-ascii?Q?ahuanuFbobtJIzb13tPqMWLOOxJSBLA6QnZ4ZW7O7LDz+vjn59Kf0dOfIJNI?=
 =?us-ascii?Q?drmsJi6J1dmQyVU7Ed2N4wj5wcHm9Amnb6QQr+52dUG8Wi+8A5mvDasFIPEu?=
 =?us-ascii?Q?VBOatyK0zzcZP3nSSqoGPcZ+IKhb+FA6Vw9cS8X09k93YCgidfsP0qxCqF42?=
 =?us-ascii?Q?DmNWmIDe6PLmnqYTr0sPzp46Ljwwmu0n1VMMs54GZAVdB9CD7Hhj37nAArlF?=
 =?us-ascii?Q?fO0PD1WZyoQ6ZwWdqWw/od0W/BtaCtn9DJDu2wwgonS1ialWNK+fYAZ1h/Md?=
 =?us-ascii?Q?TMs1ZQlvfAZf+FWSkwpuH6cNkK3BfeKOM8KQLN9ZV6o2AOdyKBnEAv6RqhO+?=
 =?us-ascii?Q?yraYlIftM0VFHGsNa/F06O3MyKycuXK1ODML5uutnDUp0y/bqSKm1adjb+Yg?=
 =?us-ascii?Q?pN3A2d2Ig7RH3KHKpJAmvjLISvrH9Jw6UiJYQC2BKzO/8fiwYLqbuy3b19+6?=
 =?us-ascii?Q?L1ytwlH8/f9wI8dYJy0kRxzhOt9cL3WyUh59yhcTxVUiQzfD20LPA5Jcx2Sg?=
 =?us-ascii?Q?cmXyuLeuNRIYJfFN4a/JI/qucRzFxV20LAa8PWEjsHU4Z2/iD29AYVpBxz65?=
 =?us-ascii?Q?gIEt0t+eYPVu7bxzGxnWYNs0SEPbjzz8oaegQuL7xj6f2ZRIAnr9IJv1sIiC?=
 =?us-ascii?Q?A8Q7AnqlBl7qsEvZUKYhObdVZg7t5ZClqNIi/ObqAYu6wB9kNcRh0+j3KaTu?=
 =?us-ascii?Q?z88TAZABmSyx/mXFuNVWQqvDlgkvPLUh35vKGs3W2gfuy+eJhbz2jVJcF5fz?=
 =?us-ascii?Q?yuL9K6bYIZ+dHZKXPHRTzh/OicStzwSf3Z5q7ECqfNmATxk7JvCkJob16b/s?=
 =?us-ascii?Q?H77gEZ43e1CJxDu4zCcwpWEclSTv1Lt2wQzFHeOcjOTOojC16WxfrSfIkA+f?=
 =?us-ascii?Q?jAaygf5+Fkj9GEBHhqmtpz4rN4jRiZwdrHq05zg+pg1v3rPI0H1kFRtmWfox?=
 =?us-ascii?Q?vo4ORnhp5Q7qaTkVg4uWJdXSYzWvhGtuXQUgJjd/9BmyGvau9yD08jR6nasL?=
 =?us-ascii?Q?GhTwT8W9R7Tm+MIJcLZlVfIRR2OzyBlapcg1xnsA1+nWnLLPUifyJBsPr1C+?=
 =?us-ascii?Q?l/Ntvg+dXK1rOP0a+jaSCmIwTM95+aXsIcfIcyjYV7WHR4K/6/5MwuZjpUGB?=
 =?us-ascii?Q?InFqSY8v03qhvFHpvS6MunUT954Q6YsUB8KwX0rWNZ/HH3ceoLjC08ytlWQ5?=
 =?us-ascii?Q?nTs5kCtiFV2JyN8qt/SYfj8zn+WL/ObYGEp3KMXH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 03370f15-6e59-49ca-2147-08dc9c0c138c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 09:31:26.0715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkivO0qbkf5ajue9AsUbv0kZLvPPMA/jSS8dFF8apCcjHrtA+rEeita3PpxwiPixYzhLju54VZBK7518Netg9i3cjQJFLKYGmqIQvBePSNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Thu, 04 Jul 2024 15:00:45 +0200
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

> On 05.06.24 23:38, Conor Dooley wrote:=20
> On Wed, Jun 05, 2024 at 08:35:15AM -0600, Tom Rini wrote:
> > On Wed, Jun 05, 2024 at 01:56:13AM +0000, Hal Feng wrote:
> > > > On 04.06.24 04:32, E Shattow wrote:
> > > > Hi Hal,
> > > >
> > > > Instead of manual dt-bindings sync can we please adopt OF_UPSTREAM
> > > > for
> > > > JH7110 ?
> > >
> > > Yeah, I will try to do it recently, although I am not sure whether
> > > the U-Boot drivers and Linux drivers are compatible so that they can =
use the
> same DT.
> >
> > They must be compatible so that they can use the same DT, U-Boot needs
> > updating if it doesn't match.
>=20
> Other than the naming, I think they are compatible. IIRC there were some =
issues
> where U-Boot originally used different numbers to linux, but this was fix=
ed in
> commit 9a12e304dd ("dt-bindings: clock: jh7110: Modify clock id to be sam=
e
> with Linux").

I found the Linux DT of VisionFive 2 can not be applied to U-Boot directly.=
 Some issues
need to be fixed such as making drivers compatible with Linux DT, unifying =
DT names.
I am preparing a new patchset. When I finish coding and testing, I will sen=
d it out.

Best regards,
Hal
