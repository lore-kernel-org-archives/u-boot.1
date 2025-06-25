Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C12C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 17:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 062AF82CFA;
	Wed, 25 Jun 2025 19:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="lL3kweFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F90782D34; Wed, 25 Jun 2025 15:33:05 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1168006D
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=anthony.pighin@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I936L1+6aDZISTPDmDRTu5fsdLFqiZbyVHWIkT1PLq49DDTcD7C5DrRF3L7N13ENCDFtmW1DWxIKu8K9Mmd/gt7p2mrowteY4dtseu60gEzH8BKZK9+ixKRrZDHduiigtxX4dV8/a6p3WR1unRCOTOrjpIAcj+kr4sPIkJao3/FkMaAF1XKqS3s0KjB9i50HkVruIl3DDcgqfNM3GKA3QGGuoWV1zwIXq7GiMsOg7RucBvksuxrHx/95kvV6pEg99AtucPQteITxtLcPZD3FTvtgSmVAPG9sOps8ItTYYqmyRVEpj8/jUIbFBtNe9cYLY1c+r6v+p8mQhsxBrJOKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2auVyLkNBta1eY5dKk0FB8S8VJkGXeNttQEq8G6XOk=;
 b=LvoMQMrrUSAs2J99pQ+GjM5Mc3tQfJxIxjj6Q7d16bbDjc8252O/z32vCjTwZVnIG4SbYLwtM4LCu67SBL8BXjnqK/5ho59xiC9HNmglJGh0XgfDMamXGhpZUebqm1pGkSCXSiHNYA4Yfkgp2GpfBP7UG/pd/sbVooMf4kOdKuv2zdx5TwRsorrWPAaZwzCBkpqtwvs85zg5lH0beohvCI2E+VAulT4jnTAxl+UDAIRZO5oFvXRi0mA4w04cbGyQZcOGwrXB5i02dxeiFanQjeSQXbmJHEC8Sc53eyHO2PLstbDGwLkvay47Co2rTTFZbHf8C2YVYBIl1KMhw7WuHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2auVyLkNBta1eY5dKk0FB8S8VJkGXeNttQEq8G6XOk=;
 b=lL3kweFoxc4M2avZn1GfiPvCh2KXwrFshI9mOdi2Fvxi4wt26DZ3cnZlpaLkYPQ1x7KmYVvke1r0GLw/2H+V+Zgw4xcQzgnCRLAki9gYD/zIrY3Gu5ldt8YRt4Ymw8/qewTwRab1gzktd+xR41qIwmOoLaqKj7yd5eF1S5ek2ikpb36j7GEgqhmIWuwuwBSLFhBp+rGLFvk0307eDCcnCtb8HJttS8AjAHR4UlxhaQkkJgdWVxCfNUqGSEIaU1uSjnPmRoVVmZPsqKkGOp7zZFvl+Uwc1NJn/CtLk50cCK/14ua0UX4Q2VjsEF8Qu5/v4EzQ3amClxg/y1kr2bzMIg==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by SJ0PR08MB7681.namprd08.prod.outlook.com (2603:10b6:a03:3f6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Wed, 25 Jun
 2025 13:32:55 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 13:32:54 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: efi_loader: Sporadic build failure: Error: file not found:
 <path>/capsule_esl_file
Thread-Topic: efi_loader: Sporadic build failure: Error: file not found:
 <path>/capsule_esl_file
Thread-Index: Advl1JbsRu1RvrExQcKfnfzHrRLMIA==
Date: Wed, 25 Jun 2025 13:32:54 +0000
Message-ID: <BN0PR08MB6951841AE35F95A242553D91837BA@BN0PR08MB6951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|SJ0PR08MB7681:EE_
x-ms-office365-filtering-correlation-id: 99cdb316-3916-4417-e7e5-08ddb3ecca74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?5oYFPSe4cmudn6NKzFoIYrV8cPCdIITMM+siT5jp9STmmXSbdd+jtnYx3oyK?=
 =?us-ascii?Q?LCJN/uO1/2KB9QOUumdt8bDqXWnYOM16+PaoICPvNX348bx90+0fZlmfSEOQ?=
 =?us-ascii?Q?xLQFG3W5Kt9g8pavZV2uyF3PaFhlwrrRXbEi7ty2N6X/FOt43gjnXnijlP6P?=
 =?us-ascii?Q?J3I57yabn3rV9QKeayfC9XKkSGVydmZZe/Og4pQV6zGKW+oLAi6BesyAjpXM?=
 =?us-ascii?Q?7WyxBUDYYfzR/YplpfcamNqZRrccBsB4rVvfuoYc6XwfobSz3fuQowgctGhO?=
 =?us-ascii?Q?C/vUqqYFQQc0WtgkQ+BP3ZaaY/9338nGAb9khsAirT7IK3QkZcgUeWSbhTnh?=
 =?us-ascii?Q?lLhOtUEqvXpqeS1oHFXFkodEAHvi56L15kpsWCL0zmluLdOF6wXIcJ6aornX?=
 =?us-ascii?Q?vn2FIDf5B07vwenObxRBH3UX0MSg84QaULZF0nXgInN7v9SCP5+zCbRji1eq?=
 =?us-ascii?Q?Y6sanJlENErnDQv+4BWvgagQubWMiNMQFWUoew7oA+bpbusKk2oBVvCSZlYh?=
 =?us-ascii?Q?CxGda850AyqL4jjZhnYNtGb67yIAq5HHMzLnSXgq3tzNrYnYzUU7n9icMB/i?=
 =?us-ascii?Q?ePO95u5PRTs2/xfPLnN5+rF0dxPqCtguPtZeE0Aa69dGy0SLWV7GyidL8cec?=
 =?us-ascii?Q?GiDRTya8Nlx5eRm3gtfNm1c+obDNTgXvWlHgVRTf7CrC7g9oSfs8KwJP0Ixo?=
 =?us-ascii?Q?B/F+yg/jDnsdT/+5zBgysXJBUhALZaXi55y+AQin6hSRylHdN9O3999e6yDa?=
 =?us-ascii?Q?saXHu5sFRY4km/V/jUl8Kpk36a3q08RIWU4pwm5EqsEv4fKtDvi2mnrMp3nA?=
 =?us-ascii?Q?hAX8/nGYIW2pAFrksE01t4CHMQOc+yflHXTPBvmpv+lCzOsoIfPk2flmSZ2C?=
 =?us-ascii?Q?OdcAMnUDVEj2TnyO19DLwm7Xfw0V2i/4MO3IVlLpuxWaLOFb1dtK4jxjJgLO?=
 =?us-ascii?Q?WYnmso0FYKQ+Q17FfKWYJ715268N3g9g2h6LkIvxBoLcUuR8kWrsbhvLxDjG?=
 =?us-ascii?Q?LdZh2/7lf1iuRTaPsrfEeFIzyJ8/GcMDoNrGwLqQ8Fr6daV1FrJxp5BcJgZw?=
 =?us-ascii?Q?tTMfiMqrqcarAOETaOJHxJp8smk7Ia2v9wz/1b0vmR0tWttb0ij1tISmuftz?=
 =?us-ascii?Q?j4g9LxJIAgEwecjSDv5P44bukpfXvHWjcYvL4CNpjwQ0PE7HYlwxpBNm6AnM?=
 =?us-ascii?Q?p2TjEiYJDTkxRHWnVMn/Deyrmh48G+9ER2aOC8MUjG0dmrFRtMRMsuT4xROG?=
 =?us-ascii?Q?y9ORcJpgj/n9Fy5BKfRhKfuTSzIbPbqOH3GiqTNcMOsfnCq76iCN6VSyxNaB?=
 =?us-ascii?Q?45Mp5QPjd7Hqc80YuqC7vvzvdzNCov92km5VUoCGZmLZt0Tk+NHqoKpCFGR+?=
 =?us-ascii?Q?MhK5b3PynRPessKMwm2N9Uu+9PfI2bYxjFVW4ztpPlUTGzAQy7MvSmgVLxKb?=
 =?us-ascii?Q?gVaLb4SqOphLbLcZdPpgpfAHSKn0OyPUMCALfL3NC2jyuwu9qpgqOTInNxHF?=
 =?us-ascii?Q?HCmF4f8QHiJsmCw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1H6zVGoAWUPmesj3xuiS7YygKO/O8QzgUH2NXYdmTS/ImkYtli1nxO/5v0Tx?=
 =?us-ascii?Q?P6ysWMipkk87K+CAnvuchGyhuBAAxS/7ggS4k3IYonZ6LqNiW87MeEF6YBYZ?=
 =?us-ascii?Q?M8oXuEKFz5fjn4VtwdjxJi60VJtX8QUiz6bdVFxtharZgabP15DaPWrhptiK?=
 =?us-ascii?Q?YemO0G1n4zXs801VChE5IKFmGyMCr3HZ2Pjyacr6e0Lt66z/yLQbY8jS/XQa?=
 =?us-ascii?Q?sDRBviWzByu388OVb/R1Z99wINr+OOi8HuZut+25CIr1F/ImXQdp6Kix9Sty?=
 =?us-ascii?Q?FZNJD5Op/WyXZru11TwCBUtLMz/HZatX0/MO9CC7H+DqzL1IhLbC0A/AA1+c?=
 =?us-ascii?Q?Zbtmc9dELIkqCX5bxQQ3V19tpuf/X92sK8CiUhoE6WGrVEf0wi2RyB1qW62G?=
 =?us-ascii?Q?W87gK0yoDts60kEvTWcA/UXVJZKlcaU7y5eVKDvIm4kYU9bAKkRGtJqdfYpT?=
 =?us-ascii?Q?gd2Sux8Ub8xOKOa1lL3OPMu/OKCsTUtyUQAlNV+xYKHjaga4ziyHANJdXXqs?=
 =?us-ascii?Q?ZkkAlB7bFynUY5rBTF2hd5BQRtPTAJtV5V4aZZQq8HDTT1r+6cj+k3xQAHa6?=
 =?us-ascii?Q?GqYhbqksu16vh8ZfVi97Yf8KXiiti8ItEALjCWHTxgO9LC+0QlarLHGePIFE?=
 =?us-ascii?Q?hx9O8dGNUwXStmoy5t26DeNF6Obm4boeEHqUqL7auAkH/D0W2sa0Ijo50p49?=
 =?us-ascii?Q?+LSOc7R6JkuTxqp1S7xFD7y8rsDrO0Wqtlbhm5mVauzEmt6F/qcBgjy50kXe?=
 =?us-ascii?Q?djOV+/fGBGGFhdw8mlZn8wNXefLtdXMtLutDggp21hzmKi8ZwcSeVoWZHkBb?=
 =?us-ascii?Q?UOBQTfIQMY66ihonoRfQ42dH+TR1K/AGwWB3Fdk7YADnpbINW5eChcWu3Oi7?=
 =?us-ascii?Q?2ZWP7UhDdGnqH8CeuNYh75/g4u6MCl7YiYtLXPtejOicEN4Kj8dcyvyGp358?=
 =?us-ascii?Q?QbDbLkcNvA1wesHPAvcIEWoY9e2nWpLejS1IN/IkGHFpz97CxF7vBS6gJREb?=
 =?us-ascii?Q?3Af48QSBYWY5IX9gYrIdo8N16z7TuY+1Tr9YJKw9cSsyNS+AHPrG0ASbT7YP?=
 =?us-ascii?Q?n0g7ycn3fTRyuuUdOgWsD1E2KBNRvs7qHW0H4vDmfJNhxg21b57w2Fz6nFfg?=
 =?us-ascii?Q?zDAEzWg5k6O+3Bjz1N0fBe947PDXcujbJJfbYIO230t3IhmO7NaQ45KE0bu2?=
 =?us-ascii?Q?9hlOLQMRDbNx3D/gBduHR+gxKVJCqrQGUJKXLszMfruSW3FRQ15LnMBoS6au?=
 =?us-ascii?Q?S7QT/LELeJaI00rL5CCbX0QR8VZoKF12HbBPRNsO+YiIU6cGC6hLb2eAO+VC?=
 =?us-ascii?Q?Se/BjeYJQOv7ZJPh17HYL/JlAq9/2PRj1rMxXxNuAIbdwzKddlB5H5z8FxAV?=
 =?us-ascii?Q?/vCzySLc115MOlKs4pMZL60BK6Dw723v4M0RASHBlcPaL3rEHZWY+1C9Xi0j?=
 =?us-ascii?Q?27bjlHoQjSxKk9c8buAkZrvBJuoXdsziOurDLcAvsgvDbXmWZ67f3Z8GnNij?=
 =?us-ascii?Q?KqgXq/TPFfr+YCvDn2DReBYWPZ/OeKGPz5FhefSeKSMaSw8Tb4X2DkQwbHQB?=
 =?us-ascii?Q?ZVV8hGuDdvP9SqIn2k0V3/ZDgwSMt/7aUZ2ytJe4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cdb316-3916-4417-e7e5-08ddb3ecca74
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 13:32:54.6751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbALLPP3aeT/24blLQw1kNjjxFga11olpm54apGKcQ5jLg6TJYZxvzW2vA2jLQbl981Sn5Y6q5udMhAQ708diV+43/daOBCmwNsMFpLBi5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB7681
X-Mailman-Approved-At: Wed, 25 Jun 2025 19:05:52 +0200
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

Following the introduction of commit fd58c275f6ba524101ba0990e53f5a11ac390b=
d0,
we have seen sporadic build failures with the following footprint:

<path>/u-boot/2025.04/git/lib/efi_loader/efi_capsule_key.S:14:=20
Error: file not found: <path>/u-boot/2025.04/git/capsule_esl_file

Upstream commit 739ad58dbee874a3ad3bddd116e995212a254e07 also touched this =
area,
and we pulled it back into our build as a test. However, it still appears t=
here is a missing
dependency:

--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -87,7 +87,7 @@ $(objtree)/capsule_esl_file: FORCE
        fi
        $(call cmd,capsule_esl_gen)

-$(obj)/efi_capsule.o: $(objtree)/capsule_esl_file FORCE
+$(obj)/efi_capsule.o $(obj)/efi_capsule_key.o: $(srctree)/capsule_esl_file=
 FORCE
 asflags-y +=3D -DCAPSULE_ESL_PATH=3D\"$(objtree)/capsule_esl_file\"
 endif

Anthony
