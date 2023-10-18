Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF18CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 11:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E2986F11;
	Wed, 18 Oct 2023 13:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="T9amtGMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870A186F39; Wed, 18 Oct 2023 11:24:22 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CCA886F39
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 11:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.kubik@iopsys.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHbAayaeYPqzMVVFjlA28mHnXFVzbE44Wbrz7gZFOF1P0LQ5mzzMlMmpmV0xuTHh15gWCz7gdgk+UEQAEKh+azcsPToF6KlvGLEE5g3ERCGqBJ6aUhy4YyjWKfaax84gwVq8qn726joAKnhXlHHFpib5NNTZU1H9ldyq0/VnVMY5Gnx8iJ/7zAVUma5p2/cS4CsenC88y+3Gg0qz1epVgvAoRhBwKue2Cn4gh8bWWkYvhD/QtPP8TU+WUxYngffBzWLCPydZv5LovI9I59GrRKuveLjsTZJV40phf/y1wlrIDD38s7ovpWa4PKufsvAZRVMR3pSG/y5VARtpaa5jeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLQT/JIZlhZZ+ds80Sva6L29r0Q4Kh3fcJZzk1nrBxk=;
 b=dIDQeCO+DAjAWgmD/pfCuP/6hhlSt9V6UkkL4ozdj7lUJerOwZd/utghsxqKuPAkxsY2wMgr6ocSOKAK8X+9Zjsng1I3D2nG6Z+0MKmDbftzMYAgQZ2H/JaE1xOhifs+TDTT9/RK/MRnRUinbfHSGsDElf81oByN6hu/S9/qlrE7t0obEzw2tFJBTqZWepitwbuvLQ+1uFfj03jFBttZ0+J9R3cbwMefoqxWJU8AUDQyA7nc6NE/LfgfsXkj2JW2qIE3PiK3E2cZX5r0+wDfDU6EsY0Dt0uPhmp6HQyCNutFIKaBtamy5m9qw5nX/AUcGEhULDCR0HbXVmoDeI2taA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iopsys.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLQT/JIZlhZZ+ds80Sva6L29r0Q4Kh3fcJZzk1nrBxk=;
 b=T9amtGMIF/JCguiqM+wg4Ue5FosFkh84LoI6BkA0SCpmE6Me/bWHs5ffrhMkIKNcmwSdFtI/VsTtwYm/lMYk7x+tspTYnsDOxr/eV2GSKw4naoMiZWGrFFWywG+DDO+1/mWfnLtFSwjMfpU44nd2O4yAkWknakotDgM1NMp6aCs=
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12)
 by DU5PR08MB10562.eurprd08.prod.outlook.com (2603:10a6:10:51b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 09:24:17 +0000
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::1552:c563:b67c:a454]) by AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::1552:c563:b67c:a454%4]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:24:17 +0000
From: Piotr Kubik <piotr.kubik@iopsys.eu>
To: Simon Glass <sjg@google.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootm: Fix flags used for bootargs string substitution
Thread-Topic: [PATCH] bootm: Fix flags used for bootargs string substitution
Thread-Index: AQHaAOghD2N4wpiV5kODKYaGB5cRKrBOLiaAgAC3lYCAAGHmDw==
Date: Wed, 18 Oct 2023 09:24:17 +0000
Message-ID: <AS8PR08MB6806D08B61DB1A97ABF68BBDEBD5A@AS8PR08MB6806.eurprd08.prod.outlook.com>
References: <20231017105305.417338-1-piotr.kubik@iopsys.eu>
 <20231017163547.GL3119521@bill-the-cat>
 <CAPnjgZ0LEG9PK2j3YRRzkxZO_Vxu_J11xFFN21nc+T=efxRNDg@mail.gmail.com>
In-Reply-To: <CAPnjgZ0LEG9PK2j3YRRzkxZO_Vxu_J11xFFN21nc+T=efxRNDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR08MB6806:EE_|DU5PR08MB10562:EE_
x-ms-office365-filtering-correlation-id: fae7dc09-a18a-4920-c2db-08dbcfbc00a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYx+FEPLyEMYB7cIxinMyjDCqWWclKh0bB7W5F1dJ+M9aEXt3IDFqb7l0+j6aDPfowu/tZOn+2blc0wyu4a/8P2WM0rs1rRH0gf5b9C2Ncn95VYdhdAvOCsptBD9Hw07RYgJa1I71t70+TsL1FTz5ZQ6y25EgP0Hg/7xk2B5e0BIb9YJd+F6wpLuayW5GwZCeegdK8Mp17VWpt8MXJSsZ8Wqv4vwSyvP2zeNNj7hjVvW/KWz9FeEbpNvIw+hdRhsgXRnWkGDfg3gq2arlLEWWQyR9QK01MoMUlWuJFKxJo7zjQx2ukU4N4BdvwCNBOpQb3cGc5a5D2rYsXUEYcouAL54wah4W+/1eRzLq/oCMaxXStkRwLD2UHM2XUq9Dkcxk4L7X1qywiLnXCA7W99SO+S9GYD7jpBTrI3yIrL9Y/6fp1bSFcMCTCPj3kqgMWqQ3+gPD9jDZMSNknTzNwgam6n4R/szSrdN8MfDNRzd2DDJNfTaF5vwTCD7KiSdIF2JrlLc/5xNkfRUWW5Y9MatkPTqD4fQIf2MGFJvXJ76IgSnnGhO0B1Sw0AeTEqIC5n8FYhBWhobJWaZrRK0KsmYeWjfqhd8lygWQShJ2uRK+Ut9CzsC/jw9YKj7INDk/A2N
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB6806.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39840400004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(71200400001)(6506007)(53546011)(9686003)(7696005)(478600001)(110136005)(91956017)(316002)(64756008)(66476007)(76116006)(66446008)(26005)(83380400001)(66946007)(66556008)(52536014)(41300700001)(38100700002)(44832011)(55016003)(5660300002)(122000001)(38070700005)(8676002)(8936002)(33656002)(4326008)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vi3Bs2oRdTUtgqGNUXHN4ojc2BmpmF4GjBA/mavYst2yv9ziVGfzy4BXJx?=
 =?iso-8859-1?Q?4Ig2wgDeJUyM8s8W81RxA8I3W3jHsFAtQpe1CarD4Gbr01y5cZG5OlO1dL?=
 =?iso-8859-1?Q?FCqpp2i2NYPFeZj3eCXLfEprqLODOaCS/0gR+mEJ74O7jqz5w2coqYNM+S?=
 =?iso-8859-1?Q?X8VN78/RJyshgmq3oSaP2Hkv6r1FuBQQrWpd9JdTLIfKGXnzpEezX7IjUY?=
 =?iso-8859-1?Q?PnoqQtEaDURYG9n66m/FaU+QceDoq6AZVglB0bKRYK/3kgh6siLGYzp6lp?=
 =?iso-8859-1?Q?xk66KJ99tXTGj8sBPHga8t/N2cf1oDcseIkIrQs6fogOXYalhm/Gy/vY1r?=
 =?iso-8859-1?Q?4w/teEgLDvuE2a1QLocwj3PBlvtkMOihNt5aIfYslCOPzOlw4UghqXU6SM?=
 =?iso-8859-1?Q?7y2UqNa0/TaIsjDHJIJh2ILB+iJ5JnINK/HcpZsi3j6aZYZGlqGy4dTNTN?=
 =?iso-8859-1?Q?Had6fc4H92mS/FPGfmWDW4MV4ryBNuOSM5RINxUOW0MGTiJAAIWwfuu0Fk?=
 =?iso-8859-1?Q?cLc8mZzVdau0Fx4eXp2rmDd/YZua0Kbxu4j7fdlbkvujyecezS3P3a17NN?=
 =?iso-8859-1?Q?8NhtVJCWslRngCovwthgh8UMua9nQ1tHt/rlTMhy7FSYwdzZcW5OpeOuOT?=
 =?iso-8859-1?Q?utTgsx6uXeRKcReC31H08YhLmRmJEGBiW9y8MFgE7sXgkFzc15mtIasIuY?=
 =?iso-8859-1?Q?apFBdle53zq7CjUjmvOxoIJDQU+jd0ksEaM2wHt2H9XiEa2ukIZwQ8I4Wh?=
 =?iso-8859-1?Q?/IXYwcU04gHHF/GhbVywDw/+z/+8fWys0ydG3ZoG/tGjZ+zuwiQxVk6b+8?=
 =?iso-8859-1?Q?8AuJ/kkgDauTk7vFfR+R6EI+oWgmKxnEX7IKiMQdio33ahlusvI+zkNMde?=
 =?iso-8859-1?Q?auYDpwNXnbVNwKpX6x4EuYiXoKnB5ah7QvTerU9f4zrJCt4xsn4qM9HCuf?=
 =?iso-8859-1?Q?HGP680K19R1bk3fOayOKEaZIuv7u5o11jwa+mMd+21Fr3nfIXLWt/AJQbB?=
 =?iso-8859-1?Q?oqyLmg9AFzTsGBZ4Z7ZMNzOnZBkeZXxJONfo75RfczPHuRvHeTYMkzhTzr?=
 =?iso-8859-1?Q?d/1qBvi5CLqx0iOQY6/3uqAimIM+zOX4zOSY2v6Yp5B66eUHIpL709KQLz?=
 =?iso-8859-1?Q?oYsWG02Kks1cO4LE9GHEEI7AxKNgO2KG8RLJ5XWU5VYr3tldl/F6cXaOXd?=
 =?iso-8859-1?Q?GflwVZfI0aDfkC/RJ7YLes0qKZV/1v159eH5uH7alGue2GVgjrbzjKaYZ4?=
 =?iso-8859-1?Q?w6J0rQlPh2EPsDov/BUJCw2Bm+bZi/kI5IRRvzzct58Ttv3LP64UaNHCKD?=
 =?iso-8859-1?Q?2CKW3ADn6aouYvMAfblRbsa9UbwKzZe0kmlh1y9ro5aIXAIGAX8wJMtfi6?=
 =?iso-8859-1?Q?MQ0dgh4iGXDKgJfHZeHoixDTGY0Zvs59Us389TEgzWJn7ltPWF2YW0y+a9?=
 =?iso-8859-1?Q?lzdUPTysbxwnS694a58P5a7/692y6G7+FOCbUU9efi8RRGNqVsIQYti6KR?=
 =?iso-8859-1?Q?Gp+BPK2aQ6PFNPQG8ifCje7d1TOX7pHlTiaJuxGuFlOESCXCmnTgo1ZYhp?=
 =?iso-8859-1?Q?undujycwQjtpd4Q40zeHA/oyaSztBQ48B3E5bhlkpo3JviBAiOJkobnVEU?=
 =?iso-8859-1?Q?o64KbO35DBhAA7lvBN/4QgSZLYQ4L50FkB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB6806.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae7dc09-a18a-4920-c2db-08dbcfbc00a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 09:24:17.4197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZvZ5EaR7gHJFiYAYONW9xlHTgbm2HnUhZKzzt2gMjmYSG+0bR/aZlP/mZGwdeCGKzCFGqmr4wop2S9YYbJBB0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10562
X-Mailman-Approved-At: Wed, 18 Oct 2023 13:30:29 +0200
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

Hi Simon, Tom=0A=
Thanks for your feedback=0A=
=0A=
> On Tue, 17 Oct 2023 at 10:35, Tom Rini <trini@konsulko.com> wrote:=0A=
>>=0A=
>> Checkpatch will complain that this should be:=0A=
>> In commit 51bb33846ad2 ("bootm: Support string substitution in=0A=
>> bootargs")=0A=
=0A=
Actually it did not complain, but I'll fix.=0A=
=0A=
> On 18.10.2023 05:32, Simon Glass wrote:=0A=
> Oh wow that is a terrible bug. We have lots of test coverage of=0A=
> bootm_process_cmdline_env() and below, but bootm itself is still quite=0A=
> spotty.=0A=
>=0A=
> I wonder if we could add something to run_fit_test to check this. We=0A=
> have lots of tests for bootm_process_cmdline_env() but not much of=0A=
> bootm itself. It might be possible to add just a few lines there, e.g.=0A=
> to set the bootargs to something and check what ends up in bootargs?=0A=
=0A=
That's a good idea, I'll check=0A=
=0A=
>> +		ret =3D bootm_process_cmdline_env(images->os.os =3D=3D IH_OS_LINUX ?=
=0A=
>> +										BOOTM_CL_ALL : 0);=0A=
>> This gets hard to read. I would prefer a comment and something like:=0A=
>> int flags =3D 0;=0A=
>> if (images->os.os =3D=3D IH_OS_LINUX)=0A=
>>    flags =3D BOOTM_CL_ALL;=0A=
>> ret =3D bootm_process_cmdline_env(flags);=0A=
>>=0A=
>> As the compiler should be just as smart, and that'll be clear about=0A=
>> what's going on.  Thanks.=0A=
=0A=
Well, I followed previous way of coding this part and it was:=0A=
ret =3D bootm_process_cmdline_env(images->os.os =3D=3D IH_OS_LINUX ?=0A=
						BOOTM_CL_SILENT : 0);=0A=
=0A=
But sure, I can update to make it more readable. =0A=
=0A=
Regards,=0A=
Piotr=0A=
