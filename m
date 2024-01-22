Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F35C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 08:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DB9876F4;
	Mon, 22 Jan 2024 09:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="lUwnuDYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69576876E4; Mon, 22 Jan 2024 09:33:20 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A5287708
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 09:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR3y9QIwGfgz0aSlVEPibr2sDVz0pV56VONPIBRMMcF1eApwLeWKbt6wQNR8yzzUkArZHXKEDMPHtv1cluG5duF879rNFACEjzY/RAmU+pNsVVXBj7X0t4LsbmG9xlxRRnBQ8sNcd73mIBwjf2DRwtpdnv5T+JcYtvADdlRrjwZS0lx8SE0o+7OLReerYfMM8PwBpkiBOKhGMpJTxoVped/GsTcKXHWeVigcnelfcANKaP178eZMT/D/qR8c0sUxN5vUaFP3QvxjVdVF0JLnDOSDaSzVRC6ClvqUVpVeR9vepO2oONechzSeXKNVRRpwDnGxeSmFQQnvvb686DSdEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+PTbRBQm7Fq6IDPa8ooOmRduFpCmlfu4Zk18r7KPYI=;
 b=lqD2S4dW3E+Ih36S6XpQEWKb2XPw2FSzBQBDz7S97FNj/kGJ+hkHegjTYFNUNHDXw/rUNtGdCZEcEpE2e1NnTHmKFKnS9MSavPCbPPWidqRE2SpnnPcfzIW2lq+AJxExXImoSTdUY7h7vXZS+FDXn767LoEB6VqMaTb8NI9yKoacHi0ASiqOiWCFRnmeouYH0vZSy8iBEd+Om+ER4CvBoVMCC3jZA+nUrzMq/IUM0Vc4mpaJQOvIFJqn7/aphZfG/ekqiZy0UQARf5JnB4dNQOl1CYHdPnvPa9rRzsE+1IPlcOQ6c829CjsgaGZRJn7hKVo7l1NyVQElbq5iIKHibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+PTbRBQm7Fq6IDPa8ooOmRduFpCmlfu4Zk18r7KPYI=;
 b=lUwnuDYhq5nlUq4lwwfCjuxxO6LqQJNV9esr0WCpzAgg+I+qrZYq0oppUYzBv2EIiaUNcQwZESWeNHLACEGNzqHJ6LAN4BMMQ5Qs/vpPRCdBneWKltwHQR1K3bSPiTngivyJm0eW1E4wJuUtOMlY3Kt7ylkVCQ+Yd3D1wTbvVtfJjUO6fKHtDzghDR9ywk1mArqDlhcAEJpXMO9Et/maVdS0xVMbTgTFKJYIRI7PHfeuDS8bf66TEEZrT43V+iMe729JejKHMAz+ZA+0yG7rFTD9XWl3DkbHQnlsc0yJn6tFuiUuke+pCMta44GC8epNIlsUkElrUlqFCbxdizzqjQ==
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9)
 by GV1PR10MB6347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 22 Jan
 2024 08:33:14 +0000
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1f5:cb7c:e668:56b5]) by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1f5:cb7c:e668:56b5%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 08:33:14 +0000
From: "Leto, Enrico" <enrico.leto@siemens.com>
To: 'Tom Rini' <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>
Subject: RE: [PATCH v4 0/6] board: siemens: clean up subfolders
Thread-Topic: [PATCH v4 0/6] board: siemens: clean up subfolders
Thread-Index: AQHaPkk63KGwCm7ovUuuA1eL0UlH7bDfxcmAgAXUYCA=
Date: Mon, 22 Jan 2024 08:33:14 +0000
Message-ID: <DB8PR10MB37376E05A348DE5E1AECA1BBFF752@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
References: <20240103133154.152886-1-enrico.leto@siemens.com>
 <20240118151533.GA2523070@bill-the-cat>
In-Reply-To: <20240118151533.GA2523070@bill-the-cat>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=82ecd57e-bd52-4da7-b61e-4c2bb302af3a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-01-22T08:16:57Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3737:EE_|GV1PR10MB6347:EE_
x-ms-office365-filtering-correlation-id: dd57356a-d470-4c33-b21c-08dc1b24c6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +aZUaaNL0v+M6R9gKRwIisTMCN+9VgzCQ84RIfqKBkRPzAiCoqpAnGgMcfGTJs0fl11RJlVT79glsPOP0BCdUCLbsVreqsv5JvwZtuJCc3FVqmHu0Jh2+S2nMPxWtYqz5oBoJt5S2FgaWbgDTJ0t5Z3+7eYWA9yEpgm1B/JDajRZflrQKCWRLzAumJBZ6s/xKKyqXutU+z2PhNyXQmZwx/Gh2xyiW7jMqAjdGjOq+Hno/2SFJiFVkdvZc2DdRVzuJPR9TnhekyU7oGQ17+2iF4TK6ocZvpX182x+TVkYn5yngIveLM6mtXor86YCwUxpdKRfwMm+mafsqNFidnKgkhRupyDagH82AMFIUu2rBHksoooEQIahLIsB9kcJl/ghmrH1ybxc+RLYN8+20wikWznDdvV6WyryUDVJMSAwlngPd+uje7diCSfSkTLIBUi3Onqbv5pOhnCR62YlJMTjBGpaVsivh7ZOYVsDgl3NbICy3tzQwrUo429xPwUAodhbFfGQs3wqxnuLltti6tJERqBOeaGOZ/y+/mXv4tX3atyE1koetw3zWtIC7qhP+1KuNjF80NB/kEo52zymMrRWGmMF1TY9iqwVfDOeB8lUFJ/3fv6BShUxjhuMUJ9cYb9VSCR4wfp36AB1PAJ+A1RJPeG94E6aq8mxCo/R1ayNENE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(55016003)(6506007)(107886003)(82960400001)(9686003)(53546011)(26005)(71200400001)(55236004)(76116006)(66946007)(86362001)(38070700009)(7696005)(38100700002)(8676002)(2906002)(4326008)(5660300002)(33656002)(41300700001)(8936002)(6916009)(52536014)(64756008)(122000001)(54906003)(83380400001)(66556008)(478600001)(66446008)(316002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yT4opcKJC3DbmCrPkyHbVvJNm6ur2cdDQ0y2MHZkUNbrlpLX0bUyB3X8rD/C?=
 =?us-ascii?Q?ZSqty+CZCVyk/218DRMKEnVbeMnSXFPdkMCW+QLCqL7H2ZWnUIWrmWNw1OAo?=
 =?us-ascii?Q?UNbIv+Ig2QsxPia72upQh3oywQ/c/QiZBEwxuw91Tunu9YSij0/whLPjZVxE?=
 =?us-ascii?Q?eIj36hslqgYow575g7elklAV3GYxce2fpfzgqlNozekC6Hu1MHtNkbIM0bz9?=
 =?us-ascii?Q?jGciumA2T1ufJi7HzjiFlabS1SJxTy4KtNqrhmaw80P5Cr8zo5aUGavDk7ah?=
 =?us-ascii?Q?F4o85uDibd1y1w+fV8o16qUXIA3ng6vzpIlfmXA/ZPCjHaY1Id/j6XDNAeHI?=
 =?us-ascii?Q?gwzC9rH4Hcs3I1K5y6z12Snbgs1ZZp8QqMP+Cv6VASF82ElyYkbca+CUpLBB?=
 =?us-ascii?Q?GNOO+776thvua8iiRKgt1Vigkd0XfQIUa337itWkVbDdEMq9BhLiqkJvDvYQ?=
 =?us-ascii?Q?UrqE1BnL+H3fCSM9HMuptqQtxJD0RoO8fR5/wfHsa40xDuxFylnX5pK2KEMj?=
 =?us-ascii?Q?4IpeLIw2aNdnzGdYQ8Bd/0+ufcjOqgwNKqiWSV4qVqYxR3wgmu2oxprDsrB4?=
 =?us-ascii?Q?lfElrD6NFbPzo/8/hKNPV+tNO6Bd7w544r8ZT1o2x+r9pjqESRsuwBJLbWYm?=
 =?us-ascii?Q?uzMauGIdpcPzo5sAT0sPcnhv+DLB1V9h29LdkWH8jFNJ9G7Z3q5DWwxNXWKA?=
 =?us-ascii?Q?ULLFdn2gHUpQQI8oAdP8aq0BOmRR9wfXp5aNi6WRatppvxUZMHhMhKHBTv4x?=
 =?us-ascii?Q?Ok6aiRXe672KKIExS9u8nherZ8CMhHN1npVDvnRTqhPGAvVd94erFBbkA8f9?=
 =?us-ascii?Q?mYJUVEbBPphg5Brqn4VCxbUJuOkDBFmbwQWjKjJsXqPllysWsueFxd7YTYvi?=
 =?us-ascii?Q?ye8py7UwzAc2t8iRQahyN7OHeZBwwsL490yywLjeiT0d9ZmIOazbKup/xhUy?=
 =?us-ascii?Q?pazk8ovBZhXu5F9CDdklkxLEJUPKDslcXPpuZJX8r2ux4rKPU2jr8+CTeVY5?=
 =?us-ascii?Q?wNmqJjTEpa6YcyjhFmKXrmHSep4CWb72YY5RTD/dQJa6gdcgnqqlaySMsuDD?=
 =?us-ascii?Q?uGrSQMCFxpsbcKaYocaeE1r7h23rxEeFwijwvUWpb5j1l+dgWps7BG6R/7gd?=
 =?us-ascii?Q?dBH/lWgCGArq5neudvEC1EBQ50lWvc8uY3JFDIUIfut66f+HOLbkJpa0FhRM?=
 =?us-ascii?Q?WFpyEBHdlWHKxj17VkuK3DucBW8ftu5DsYdsoSHuDe6WfLWYWV7Z2ZbyY76L?=
 =?us-ascii?Q?1SJGV2jESqzb6wZpI//WrQ17fPvC5Fb6daSnAVojaH0+mYLhXu4MI9esVg0F?=
 =?us-ascii?Q?JvE3AO7gLIv/ho/DoBWKFM+WIKtQ3Ucu7Esobhbym5d3HLo4oVlLARNPoiMo?=
 =?us-ascii?Q?83eqHfR/6JTLLAeb1rG9n12FOqod3e654frTwyjNUrcZ01yGBaX70aDSpiQv?=
 =?us-ascii?Q?fGOB+p0+Xyr/rncKFs8rQLfZDv++Ao68vak85ughNnu0iCX4lDVNzVNbmYeV?=
 =?us-ascii?Q?PFbkYjPV6z0Aj7aLhgAdWAiADUvriRMbYkhM9qEUKL/ICfOm3c+E+mU469PL?=
 =?us-ascii?Q?UggPXGjnStca8z9IcAUifXj4+tDfyy/1uHnfri9P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dd57356a-d470-4c33-b21c-08dc1b24c6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 08:33:14.8287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGddmUWjYUNPS9/IVu0MJzl4X8jx9moZ5hvhQHjEoMELsxreHSb5g0S331zn+Rg93qp5iMQnGN9z9cWdwip49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6347
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



> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Thursday, January 18, 2024 4:16 PM
> To: Leto, Enrico (SI BP R&D ZG FW CCP) <enrico.leto@siemens.com>
> Cc: u-boot@lists.denx.de; Sverdlin, Alexander (SI BP R&D ZG FW CCP)
> <alexander.sverdlin@siemens.com>
> Subject: Re: [PATCH v4 0/6] board: siemens: clean up subfolders
>=20
> On Wed, Jan 03, 2024 at 02:31:48PM +0100, Enrico Leto wrote:
>=20
> > This serie depends on the serie:
> >     [PATCH 0/6] siemens,am335x: clean up the draco board family
>=20
> Is this not applied already? If not, where is it? Can you please repost i=
t?
>=20

Yes, it's applied. I'll remove these lines.

> >
> >     The common folder was initialially created for the common parts of
> >     the products based on draco-am355x board family. We have the
> >     product lines 'pxm2', 'rut' and the base line unfortunately named
> >     'draco'! Adding the new capricorn-imx8 board family, the files
> >     were enhanced without cleanup.
> >
> >     Simplify first EEPROM probe and access that implements both i2c
> >     with & without driver model. Use abstraction functions for this.
> >
> >     Move all am355x specifics to a new file 'board_am335x'.
> >
> >     Clean-up includes, config checks, maintainer.
> >
> > Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
>=20
> The problem is that I see:
>=20
>=20
> > ---
> >rm:  +   draco-etamin
> +(draco-etamin) board/siemens/draco/../common/board.c: In function
> 'board_init':
> +(draco-etamin) board/siemens/draco/../common/board.c:88:9: error:
> implicit declaration of function 'board_nand_cs_init' [-Werror=3Dimplicit=
-
> function-declaration]
> +(draco-etamin)    88 |         board_nand_cs_init();
> +(draco-etamin)       |         ^~~~~~~~~~~~~~~~~~
> +(draco-etamin) cc1: all warnings being treated as errors
> +(draco-etamin) make[2]: *** [scripts/Makefile.build:257:
> +board/siemens/draco/../common/board.o] Error 1
> +(draco-etamin) make[1]: *** [Makefile:1859: board/siemens/draco] Error
> +2
> +(draco-etamin) make: *** [Makefile:177: sub-make] Error 2

I'll check why I have not seen this problem by me and fix it.

>    aarch64:  +   Deneb
> +(deneb) WARNING 'ahab-container.img' not found, resulting binary is
> +not-functional
> +(deneb) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.o: in function
> `factoryset_read_eeprom':
> +(deneb)
> board/siemens/capricorn/../common/factoryset.c:149:(.text.factoryset_read
> _eeprom+0x2c): undefined reference to `siemens_ee_read_data'
> +(deneb) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:177:(.text.factoryset_read
> _eeprom+0xb4): undefined reference to `siemens_ee_read_data'
> +(deneb) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:172:(.text.factoryset_read
> _eeprom+0x264): undefined reference to `siemens_ee_read_data'
> +(deneb) make[1]: *** [Makefile:1766: u-boot] Error 139
> +(deneb) make[1]: *** Deleting file 'u-boot'
> +(deneb) make: *** [Makefile:177: sub-make] Error 2
>    aarch64:  +   giedi
> +(giedi) WARNING 'ahab-container.img' not found, resulting binary is
> +not-functional
> +(giedi) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.o: in function
> `factoryset_read_eeprom':
> +(giedi)
> board/siemens/capricorn/../common/factoryset.c:149:(.text.factoryset_read
> _eeprom+0x2c): undefined reference to `siemens_ee_read_data'
> +(giedi) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:177:(.text.factoryset_read
> _eeprom+0xb4): undefined reference to `siemens_ee_read_data'
> +(giedi) aarch64-linux-ld.bfd:
> board/siemens/capricorn/../common/factoryset.c:172:(.text.factoryset_read
> _eeprom+0x264): undefined reference to `siemens_ee_read_data'
> +(giedi) make[1]: *** [Makefile:1766: u-boot] Error 139
> +(giedi) make[1]: *** Deleting file 'u-boot'
> +(giedi) make: *** [Makefile:177: sub-make] Error 2

'giedi' & 'deneb' are based on imx8x board. This is another family that are
not affected from this patch serie.
This patch serie is not the cause of these warnings and will not resolve th=
em.

Additional info.
We also have everywhere this warning since u-boot version 2020 or 2021. Thi=
s
doesn't affect the u-boot/SPL outputs. The complete boot container incl.
'ahab-container.img' is built separately with the mkimage tool of NXP.
On first appearing of this warning we asked NXP. They didn't improve any
solution. Maybe there is now a setting to remove this warning.
A patch serie is planned for our imx8x boards.

>=20
> When building.
>=20
> --
> Tom
