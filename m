Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274E5CD6E5D
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 02:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8374B840ED;
	Wed,  3 Jun 2026 04:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88EB4840ED; Wed,  3 Jun 2026 04:15:28 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20725.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::725])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C6284837
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 04:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1tTiyG2Fm8qp7X7G9AJCUYLdA2T+ICErKqvB2G2mVvp61adok6bW+CGvA9Iohnf9y9K8PefmWnuIf/O7S9cCva0H/HGbcvt0eQObn0o1Lm9SIoMSDNJyLOP1z/EXUd/kWCOy7hWdpEgdzjekrDN1575S8EmD2EqbYILnd3L+FRS7jmwRQBSaPdefxwQcQxapsNoozTdF80cKZsqaAotbI/KPgMj3Ktrt6RMy69zcv31Kuf5ATTqJzceQldIf1CXpSMjViFiq8Znu1Iz/ks9qa5fJCJ/AYJYd+hDMYoOQAMjCjntr7eiWnJjO3vsnh1czIf1/U6wbzq+LUYtO7fBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqExHxuWmJjt/dzwkNXMR+yhFvSEkPejJqvVLPh5E24=;
 b=LfBArz317MGc+18tcvbokvHaVmMbYuFziDUjxnXD/ASHTh3HG6JIz4UMAsIw585odqTEXxxfskJrAO8N+UvhHi+lKqqFpBnpAvF8iWsZAjg9BqOQTEyPdtIvGr31gI1clkHf+TxTi9tnWmrKZlo47VzvJu3XQabj+vsSlM/doGTmM2vo7QjbJHjf44uXC0DMMkCbm2v9VLKMRb5B4WqTlDJaYGyTVZ1eYSMjeK/+8eVd7te5LqSsZ5MLqk1I28ta9Mfc1tWVgyBBltKNpjA5uBlzbQB2fo7OPI5mr5RXtvmTAlD7y6aVKbbPhlIdg1w0lV5uKrUYDt/2N6I1OzEU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1163.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 02:15:20 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%3])
 with mapi id 15.21.0092.006; Wed, 3 Jun 2026 02:15:20 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [RESEND v2 0/2] Add support for StarFive VisionFive 2 Lite eMMC
 board
Thread-Topic: [RESEND v2 0/2] Add support for StarFive VisionFive 2 Lite eMMC
 board
Thread-Index: AQHc7xry6dpngclujkGstWLsUIujP7YsH3Bw
Date: Wed, 3 Jun 2026 02:15:20 +0000
Message-ID: <ZQ2PR01MB13076C1532CCFF71BBAF55C8E6132@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20260529032624.6868-1-hal.feng@starfivetech.com>
In-Reply-To: <20260529032624.6868-1-hal.feng@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1163:EE_
x-ms-office365-filtering-correlation-id: 0f6563e7-d17b-4f24-28f0-08dec115f669
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: lbo1aqKfbPlvPT+d2OO17rG1fRt22T79d18w08tRQEu4c+EfP6jw0ZtdtWyjrUl+nwri0LgtNsmliqs2yNiAniecvhpG3BiAGs+wSI1+pgNyGhtfzi9mUop+y0BXnUYlepHxLFu7duSjxAcktbhR2HlEQNDcmtD5FUbSlfySehRclD86bBzaTqfXYjBryIzUd1GSwRxTXjoRlqLqfBrH1WKHekUykieFrnKKlGN5oJD+f5wUlIXYUpKr4eX7Yefib3zylQGI4SMKWiNUmZOSn0sXghBIVmMFnr9UrojUq3R9xv7pYDPL7JTB1Szm8mFBu5RDg25luqvtsXzJ0qjmsZEoDEBb5+/WHW6eITGpgt+w44ppX6xZaj1JGYhiT6rCJPzv+gV1INYtjKIQ19L75zd1q4mcx9QaW9FuOp+DI784wT7KWSnpki53nlmdFB9kruCDhRAKvjPnZv1CGbNlw8Y17ORH0KG/Y8OUSYMrOCjd7UX+dd/8XYyN1gesyQJsVzJPKtzMre84XKCTAs+TR6FM8zCrLjn+TNZYYop+aGn8v65w4E++8WVzeLGuNwpg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IURntcqryKDw+FzLrlGA7ctNQzE/qafE8UAc4V6FmRLmYoEKUOQSI1msxG4o?=
 =?us-ascii?Q?vpgcrAZ1+5VHnBZ5NbNOkyFesiSlP+rTmZrdRzmbfbn29YrSKax7pRxguyi6?=
 =?us-ascii?Q?FjAeNGdL4Tit/MMo65ZHhgHBr9bj17cfS98fsCkGXF7IkanwYPiW/EkJ0QCI?=
 =?us-ascii?Q?YJINzduZ3YB/GISJjuV1Ladc33lEj/+rzOcCXkDrOHSFVnzJoaQQ1EIkYhhS?=
 =?us-ascii?Q?htQV8b38M2HKze7kf1evmrSyatX8/ChitDg+/iRvBbI4kKdEAxbK82Ned8Y6?=
 =?us-ascii?Q?Umzoz3N8GvoTiLKtIH5KT9jM+1DfuCiDZBAVBsTYX2tzmoUZLZyuYAFoCWCA?=
 =?us-ascii?Q?OclPgS+A5XLsa2aVvYlC4kpBo6gXpAd1lFXqWsVzjpiKhiCk5nVj47Qxk48U?=
 =?us-ascii?Q?h4CzRgE3pfseviQvU5MPlzpJAJnZw72EAnm2Zu2LLxVA+XBnRrqkbbfSPQw5?=
 =?us-ascii?Q?rfliYo6+T3NEmJGRIz/pVaI63DbT8nDRbHclifnUIQ7bRKf2PK96i1iDQl0i?=
 =?us-ascii?Q?dmplyEcFHBSTzYESbKRtB5hX8uSWtmkUgS3AqosSUCRN2h4j80/M1kxuX192?=
 =?us-ascii?Q?5kWezu7+8t8vvhP+zfU4z845SOC93+vDeFkam1stQ6dNJxdme0Eay4b0/JLa?=
 =?us-ascii?Q?lc8HDIgzpxSOWoMKmPe+C+9l/It2dPepNcmBddx/N7hFYFnT+cWK5tbNbqAp?=
 =?us-ascii?Q?YHiB7Nw8HLC8VZYv1GQQ9zmmAEwXC3ZmWiA+WdL4zHnNxcPMMt/MTIAlc+ig?=
 =?us-ascii?Q?dEUO4PCadJjth6Gf9bgO83wWigC6LqiOtPR9Ih0M3XtO1Yu8G7H/MHgc2Pji?=
 =?us-ascii?Q?6qFdF/+r9rWJYjbhOQrSGC42bGFjb2ncmyEV+ewQQAeV2oA7QOIOh5Da4Y0O?=
 =?us-ascii?Q?swODYgvJWXQn9QrmGEylklA6dPgLqzZ000sdOl0E8QSpVglzxhCcPZLnchhy?=
 =?us-ascii?Q?UbBTNZzT3TNqeE4oJ0f82X6WoWLxZPhG6habG3tnuTzgUbjEII5zepNA2BCT?=
 =?us-ascii?Q?mi5OoWAc1lRzQk6TH8nUj8tFX8LfkqaF5RECvclREATX6pxA+L1geYIbtb/1?=
 =?us-ascii?Q?ftwme3gjq7boAZZV1Tg6GE9xnDC9n3PO3gfqcJJ11qr0mgCvymj4Dmb2taAC?=
 =?us-ascii?Q?ONXLY7Sn//GDEpLiPqoVCD9nHqFgxLPFha84nzRMs61FpEcOIyRQCZAFN3yP?=
 =?us-ascii?Q?xIvHYBEPjMvpfSLmT1r0wWyY4Jy4kIJPxcwcs3kUrgojB1/y4AELFth4Ic+K?=
 =?us-ascii?Q?HN0KwREozqcu/ntGtEZWn/Dw1tlQuJOt7ydBBpsZQEkxrhLksKZG+Tqxkyvs?=
 =?us-ascii?Q?gyKFmHFGA+Qw1p+b9IhZrF/1Ah8QJDDI6RMPPdOWkf/g2T0ORBEYMk4e7/HM?=
 =?us-ascii?Q?3M1jAQXlZ59P+MloojT4Eks6w0HSmjJ6iXuoPpAqqQRvQsBtDNzssw6KPSVR?=
 =?us-ascii?Q?Y3C2TMMMX1fBkTuCdsvqw/7zkN8bfDfQIvNl9gvrDG7MOQRV6u4D4p1YAmip?=
 =?us-ascii?Q?x4Eqt861nN8ePcCB1QjqnguU4k+Jf79G3CrBxkRXHUx0pa8MJnDKKPwwidOq?=
 =?us-ascii?Q?4TEcfVQrQLzTBeY5ByXtOb5AeR5yVjAiyps+XUZmkveSJjkq6CSnd7TXtmHv?=
 =?us-ascii?Q?miBUjGbHjVS5umQDiTIit6+MDWU5Edv07MsRLP3H9Fg5mjmuvnKAiW3fIMdw?=
 =?us-ascii?Q?eUoZDgzJgQPVQy40REZxB9w/nRBbSpvmkW9QkokpYMwFjK1ir44DsQTESZOC?=
 =?us-ascii?Q?nP1uP+GwIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6563e7-d17b-4f24-28f0-08dec115f669
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 02:15:20.5185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ig5mBRKsedp7WyeeDAI8Y+0nkZJkLLzTNgf+1p53ZnrvNSG4C7OI4HPtoeDNKk2Kx4jR+eu/hVdys/3QsfzuKTz5EhjT8l1DaQAh/AveLWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1163
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

> On 26.05.29 11:26, Hal Feng wrote:
> VisionFive 2 Lite eMMC board uses the eMMC as storage component instead o=
f
> the MicroSD card in VisionFive 2 Lite board. The device tree of VisionFiv=
e 2 Lite
> eMMC board is already upstream in Linux, so add support in u-boot also.
>=20
> Changes since v1:
> - Add Reviewed-by tag from E Shattow.
>=20
> Hal Feng (2):
>   configs: visionfive2: Add VisionFive 2 Lite eMMC DT to OF_LIST
>   board: starfive: visionfive2: Support VisionFive 2 Lite eMMC
>=20
>  board/starfive/visionfive2/spl.c                  | 7 ++++++-
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
>  configs/starfive_visionfive2_defconfig            | 2 +-
>  3 files changed, 12 insertions(+), 3 deletions(-)
>=20
>=20
> base-commit: 987907ae4bcc5d6055bdf7d318a3edf53e14d5fa

Hi, Leo,

Could you please help review this series? Thanks.

Best regards,
Hal
