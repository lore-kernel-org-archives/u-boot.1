Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1E8CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 04:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 015CD8346A;
	Mon, 18 Aug 2025 06:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1828338C; Mon, 18 Aug 2025 04:14:45 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20714.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::714])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3ECE8311B
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 04:14:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNDw7qPcXA+qQGE+UjJha/DnLaIZ0WhjJbsySURo6sn301UfX5u8h+MoI+73SRzqmWX3pkXPzpRPOSMMVA3JYU/SDJ5ZKxVXghT+sOAGIVA28CEM9IkY3HzTAt4nWVX/Ut0BdI+gXpURJj0QgjgD6c1KGi1UipHefnX99/PuAC/jfOF7jMTXqSa1uFoBqAMkAsiULD/XFgx2p53mUhOTZzT7vcaMkNDIEokocgN64lKz2uGYMZ/R0zXpxNfQx8oZyjrXqWGJeJu5hkqeGsx9te2TGwdKEmp8d/igw3oyv6P3/c3RFdLGd9BOA+iJ3bS/Ii4fabMlgQjVUt+NtrWY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgUdbMko1mAvcri2DixhTyPnM3mdqLg9UWNq+plkysM=;
 b=UJAZsGHBTLM/ni97vfdVjOxvC0Fet5tMGRRpv58gdgF5YHemvjOMQBw1yLBSmBJuhtePCDbjFIKAwuEmdIT3DsZWPI9U9L4zIga4eOkptvXB9bsCp0Vufz900P1uu8l9y9YIEssExDUYrbiIQflsPMG6B2PdIwtRozsRAH5i1fbEwQA5DPNs5zS/ffWB47a66mS5UzcstR4UGHVwmAiMpgyTVEK1euICKk/lUHWrtsCO8uKQW3BCvr5j3X2sR1fdon6z70uOlw9mIwRdMpHqbspAqlKrPMcjVeQ/6miGn7BRikr8FmTYm+RnIW+N+GHBVG0X5boEaBQzwLS1dP8Rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1290.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 02:14:37 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 02:14:37 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: E Shattow <e@freeshell.de>, Leo Yu-Chi Liang <ycliang@andestech.com>, Rick
 Chen <rick@andestech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/1] starfive: fix return code of `mac write_eeprom`
Thread-Topic: [PATCH 1/1] starfive: fix return code of `mac write_eeprom`
Thread-Index: AQHcCQayohy2IPZY5kWbuSjGFH06e7RnuMvA
Date: Mon, 18 Aug 2025 02:14:37 +0000
Message-ID: <ZQ2PR01MB1307874E4F87DBC0CF2CB514E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250809082155.6929-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250809082155.6929-1-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1290:EE_
x-ms-office365-filtering-correlation-id: ffd13f0d-54be-4dac-4852-08ddddfcfb1a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: aVgmOFcVV9WuS8zS7PE/ArJeRQUKQ3PsBJvABIb8KDTluhQV9RWRoPyrJYEuiZElsT5zo706xwkd+mgT9Y1TmQtP7Vvnni5NlWIRsOKmBWwqBaCm4zGYwicdAsOGEzW7wnPGigQAcjN3+O+3gSNsB4kYvpntM6xnkiaqr0Fv+5Y7rH1PpABOvKKgnCyUsTJ6sYkITmb4i60uwCX2XtoH16V/I2XduOI27LeAxkFDJF1cirwHIUXZ/SqkS0clAacwV5IYqZTY6E81UFNV17dwfLaazGgC9ZfeeihKDA63ImvnijauEOLttZ9rZSxwagW5RATh3AUlxLoKa05g2W99K/ZpT2icUuV+X72VnD9eWKNABVFzAd1gR0oZr5cJM4DvivgC8y5e4CSfZGBMu/ucMu3xtFrKPdDgAVu0dFzOgRXbx7b3I4NsKq4P2Z0X+3CUQkLHpjQ4Vq7asPJ9wo48SFDKAmTzF1PnVIVEMlUwxMOJ8Ewcmm6KHJQ5pZUzt/JY/9I4gtRcmraBVbb8G5Gr+DloKHCuXWOtyEOjkHIbiAqmlcRg67ggBfs+hwhLjju5bfw5tMthoYSQzBJR6OV9K0G4VFGuQkWTxZjn5e/qmKM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(41320700013)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qOPb4qIzTSickiUQANn6vc0ei2gHMvkiWN9s0QNeMhPSkdacgdvHe77VpSbU?=
 =?us-ascii?Q?7tKFMjCVdRJ6vmEOGxFNjh+9Ku9HiWzgXiqbwM0oKhsKvJnauOFAteNUbmL4?=
 =?us-ascii?Q?pdJszAyVGrj8KYo6h07owsCSNSQSPZS53hDNaF2+vvEXrXixvfMcUyywpdKK?=
 =?us-ascii?Q?FG2RXTKYRxLECd2xL3hL9P69JmJRVL23a7ydXaQcsVs/ZzwyhhqbKGqDiOBE?=
 =?us-ascii?Q?1S75HrJGFG9Pv2w9GD1AINLtNW5ey5OqpNzR1WdWAha03/3+fuGhBsToauqx?=
 =?us-ascii?Q?O1UNaXnchOdUQkwuyW4kQeOufqMc0c6E7GGJPkwr4C86vS1a/TvWAAxE/6B5?=
 =?us-ascii?Q?SH/uDRFWg7XhRaVVMrrIvNsMC/OfEreC0hkD+6b8udRdA7nRbrDl5XJC4Y7b?=
 =?us-ascii?Q?lD4j7oSYqY+R0g5+1kPNrMYV+5ThipmJGBOltHq6kRBepU9i2Q1FOqPBjIXz?=
 =?us-ascii?Q?nDtLjShR/P7JaS5lg3XLabWT0GWA/QdwCRU66vwi9DZw3eauKLZJ8ezrdCYs?=
 =?us-ascii?Q?d4pNRX1dKpkuKVe8mmJCuRMB7DJsFLLi4FQgSRPLKKCNuepSf1wx4WLy4aK0?=
 =?us-ascii?Q?o2l46QvO0/ol7Fj44N+fpMDqVCAeA3cLuAlsg/tgUzUmbB6+XVBAsMSgX3e/?=
 =?us-ascii?Q?KMXOSzhk78IzTCl6c0ym3usFAqSGRzw7wEhF4quL6LLHY5vGbB7vhJBdAXyT?=
 =?us-ascii?Q?nbozqPFncd6TMisfM6h15+iF3mEhXSDD3qqBTQcfufqr3OwEFBXENvLdeeoR?=
 =?us-ascii?Q?BCb7ZA03/WsAHd2R0gDIwLD6T4RYsFM5g62fCAQQx7iqzSMjgmh19pYcnwuZ?=
 =?us-ascii?Q?lD0Glq6BIqerAHrcbAimIZglQSZ3Iw8Lmj1F0e4Mf/t6SP4ZBcthbuUeCIT4?=
 =?us-ascii?Q?D+06AoTVd9aMMfQc83wzjKO6QNDm+wz220n1/PeCBLRHexpyL82w+essx85b?=
 =?us-ascii?Q?KnrL8IL6I0S/iyaBxfSlNKiXLBQalaGP5DWqWs2OVfWj8xUr+AlORIXMwtX+?=
 =?us-ascii?Q?EmPe2PxY8+akj9rht9xPL9UcJdIqX3YWemip57jb2pMOMm2JneVkbRf4+0B1?=
 =?us-ascii?Q?UH7v6zHco6uKJTW5HOB7CuDW+rFm+f7gbnat4mAaguoGBydVIhsjmnCW3Ul0?=
 =?us-ascii?Q?Jn9qXwt7o/wazLorub6T5NwD/2DgCAWuMDf5gCOfQT3zVFKbaic5kIsZ1XKS?=
 =?us-ascii?Q?QvIsGXtM547Z9bn+q+r0+9bOThmANQpCdZWYJReT0Y/EO5ecAFZmiezVnasz?=
 =?us-ascii?Q?iyXa5YWn0CNQfjQzdQ+QA28zWVwXJ+G+E9DxeweFrz6TEBavWMkVKzW8RloZ?=
 =?us-ascii?Q?670DOTZFxioHsPo9T4BzgFDfa5JwjHoyOh59/4T3qDIXr9LqMcxN+K0HF7VK?=
 =?us-ascii?Q?k7zRdn8PN9T3QCLiuZiAuxYFAfgDA8limxGwn08Fjf/mMJ6O+K8trPRqah3W?=
 =?us-ascii?Q?qAQynlnaqztiP/yyMXOgE3Em1c+nM9vU9EZ7leX5jLDGqNJXAYonQKTR3Ptr?=
 =?us-ascii?Q?Ler2WpGM1GpJccCXy6F/4qlFwYIkcAz9Q1mH/x91lSLq94MEz4dL7LPFN6AV?=
 =?us-ascii?Q?EmGpjLQsnXW7/EYzy3P0nHSkUink1AEqDA0jsKic?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd13f0d-54be-4dac-4852-08ddddfcfb1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 02:14:37.0349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IFQ1wOSjJq+R6rgpPPOKxQOYPNFAhMfL1yD85HDT+bO5v10w+8OnMB15dMQp17TvEXCMqUoyGgH2w49flNoI/IGER9obwbtoOiyrDJiVLFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1290
X-Mailman-Approved-At: Mon, 18 Aug 2025 06:24:28 +0200
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

> On 09.08.25 16:22, Heinrich Schuchardt wrote:
>=20
> When writing the EEPROM fails, the command usage help text is displayed
> after the error message. We should only display the error message instead=
.
>=20
> If writing the EEPROM fails, return CMD_RET_FAILURE (1) instead of
> CMD_RET_USAGE (-1).
>=20
> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

