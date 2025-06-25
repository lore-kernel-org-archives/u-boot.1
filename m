Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB47C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 12:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A59382D88;
	Wed, 25 Jun 2025 14:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="uLDcLHJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6735282CBC; Wed, 25 Jun 2025 14:44:23 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB14803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 14:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zlika_ese@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUe12+YekOxf+wvrzuPJCBaM2hWSHPkdbch63UdPFzsrZVNdNgt8a3ZJqayjAgpRRC8X412AXcBgfkgH17KB77ZOCiqenzanJt3+bQq9UTKZWyj/h8L6BJ7/fal7DzrrEN/tkOo0pT2f4UKO1jBqpOyfgvV9gdhsr+jLp7udOkQcyao5Hpl8Cs2cQpgGdhUruq2ZT4ZWwWjxR5C9NMtt1Z1IUP61H/MQ5Yw4APLdsld8iId7mgCxOp4tBsHf0MB67h6pIlWhm6wiveXOAHGjtejeHeOVfd+aP+qipGuLlKyOG4u0wk+E5bNBjr5Fz8TQl9fqLPIveu5ZjgYsbI52bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXCgpgwYyGmE9O3qoRXoA83UUTP77AOY3LsEgW4STyM=;
 b=rA6mwd9Er6ZWjrr/SNnY1W3jG5QZOatY37OrjcFRDEcElc5Xbzt9y06+9F2Q/gXolFTuMncVxEkfALn6xB9ewadXna83DysoqbMOSBhOOdS6JViU7aPlayffHmdjEYZcP3cCZdrT9CbwBLss+LPyq0Bt7IHsjHCEab5+KX6pFvdzzus/jcm21xYeUr8FR+OVcfJ8Q4Z7tvyP3433pEPeTZqmiiaMKq39J74qic1umX7yVRx/w2k0mA/ciuabL9QNrZYVoVnN9fKuDoxGzMUaGXhEtp7d+cUSy2nj6PsDTPmzLyZA1gKvnZ7FWa0UuNN3NSBN9JDkWs3uBMsKmZ0/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXCgpgwYyGmE9O3qoRXoA83UUTP77AOY3LsEgW4STyM=;
 b=uLDcLHJuFfMplumoJkv6BO5/DKA9B0+lwfTgACiNkUBtA7CRgxL1NUlqJvFuKp1QHH+assYqJBaBq2fxasfxvCoLof+wKZCJimstBWOAFIOb1TkfCvlmBrzxoZ3KHBVPY629lx2HTIppxt3o2JY/NxEI9doak9T5NKM6llb2IKMcDhmMzTM878geIn8c5g47GLgQdlxK3r1prLZ4z3s4WxpNuj5IW7ejXRbVDb/cPJ+BFdnBdEuJ/c5l29Ks9UJxwgdvHSsSTZ1wl9nYo8S7EM34lFEMurbbQ9Udgw2J8lVRPjRAkcn9N+RLjYJA0vyXLLsupxqXKnf4TfKBuylsGw==
Received: from DB7PR02MB3676.eurprd02.prod.outlook.com (2603:10a6:5:1::33) by
 DU5PR02MB10748.eurprd02.prod.outlook.com (2603:10a6:10:526::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Wed, 25 Jun 2025 12:44:19 +0000
Received: from DB7PR02MB3676.eurprd02.prod.outlook.com
 ([fe80::d70e:6735:1ae1:8f43]) by DB7PR02MB3676.eurprd02.prod.outlook.com
 ([fe80::d70e:6735:1ae1:8f43%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 12:44:19 +0000
From: =?iso-8859-1?Q?Thomas_Lorblanch=E8s?= <zlika_ese@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE broken since commit
 2a00d73
Thread-Topic: SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE broken since commit
 2a00d73
Thread-Index: AQHb5c5puaY0sdV+LUCjdkh7U/LGqA==
Date: Wed, 25 Jun 2025 12:44:19 +0000
Message-ID: <DB7PR02MB3676199B1B33A23B5A3DEC33967BA@DB7PR02MB3676.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB3676:EE_|DU5PR02MB10748:EE_
x-ms-office365-filtering-correlation-id: 56d41bee-ca82-44c7-de29-08ddb3e600d2
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799009|461199028|15030799003|7092599006|8062599006|8060799009|19110799006|102099032|51005399003|440099028|39105399003|3412199025|40105399003|21999032|12091999003|26104999006;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6C8WsLR/nImQxfwaoHBqcoTJBCY/AwhTcHKhnXwu5QxXZnkkF4kRchlLsC?=
 =?iso-8859-1?Q?o0hHFr9JKcaF/j0jN9Od2Edt9dhDnJWJDl1dRb4BtoGRiQWAarNdQ5LZCA?=
 =?iso-8859-1?Q?iwVx0mOmvMuqWDmMhMt+6ttYiyizOp2HtFM16aW8JPh5LGrMB0SwK9+mPB?=
 =?iso-8859-1?Q?9sUrHXu5fguZJ3EYwgBJ/+zLN8z/D8Oj+1fddjH7WfbfmJp0iDCDwjKkwa?=
 =?iso-8859-1?Q?gdko6E7/jv0Lvnfz1W37H/MCQcv3sjv1vjKz/ICUz7BnVsOkzjtQFPf8NM?=
 =?iso-8859-1?Q?Q0vt2cyqHtEj67G2oBLHnE/AxpBvg/+DuBzSkaRQhlRnxQ3KGq0GlMx+0J?=
 =?iso-8859-1?Q?d12VPDHAnP1gufF7Ow1Lqi/CmUeJFKTGANP/bKBhZwf/iCrsmqTTlb8g7z?=
 =?iso-8859-1?Q?2GBDwQem5ZwW6nf4aUmhfFR58r8NEzLnYwaYCvxssnw3sj4ZSsViTxRBlC?=
 =?iso-8859-1?Q?g/ydxGUeutGZKTe3Jv6uLh8jv1MbhJVX0E/WC6Qh1qBE6TVhap5AnM1H0f?=
 =?iso-8859-1?Q?MLGCUQq+5S8I+63ZewtQuCtWBUAQf7xBwIQH8ryc8ifJ7LhYEzpBl0SMjP?=
 =?iso-8859-1?Q?Gz3Mxt6xkayLG10BFiph/nmzeHZb1e9Out+TKofDGk/o9c+0XSwISnGa0P?=
 =?iso-8859-1?Q?oTpljXAsZUGOsCnNuMQG/JFiQsZb2ty5txwhmxNGN5nGZSrL6nJKsMgF4H?=
 =?iso-8859-1?Q?w8Hyp6qoGU01Am+eO8JcOJ0AosVt/tx1yORie/SMoVuqzcZOoGKwNkKfQS?=
 =?iso-8859-1?Q?H7WiEUDOe5fVv2cO4/tUhikcApQVTgxL7V7Ofe7p1CS8csFl7tXNn4ObR1?=
 =?iso-8859-1?Q?ead/JpcF8HeHgLq00iHDwE7+UlOzEZFC//huTRLhtyxABRqXmEMuG+Oapm?=
 =?iso-8859-1?Q?jXmrimIy7yfRKmKYkyLIf8FQsTLzDKp5BNTBL8sotFGfQIk6H4HDrXH3n/?=
 =?iso-8859-1?Q?3gLoUawW7vLuNnljBINlvs7W7YqGfjur4hKIEqENx9jGnCtY+3qFqTDug7?=
 =?iso-8859-1?Q?TUJlOtCrIZ/2D5tVrrrjATYEQhnuEXk+m4g+MoV2RIMXvVzFAgICqLQ6rG?=
 =?iso-8859-1?Q?rMjKbhrdk1O3NSZSzB/KhJTkQ/aasno6C8JFrkx+USQFk9B//RxB8/CcXD?=
 =?iso-8859-1?Q?VJAkIy8nNd6Pb3ZLfXU2AQMez+JqZjoVSL1+P0me8MtnkIhKCjx6Vy5QqF?=
 =?iso-8859-1?Q?5QQkhdiQFm/ZUqh+kxi0jpL09U5jujSl0l0rXHZAbksxpZf1xhJhcGF6dA?=
 =?iso-8859-1?Q?6vYG5+soXr7bVqMW1J8BovkVOzTuiDU8S1HrgCXjTAm8uzCbmALYvhDPVM?=
 =?iso-8859-1?Q?tkDA1jQ1CknoCyeSrg9qpltXpDqtVbnqoZJInYEoToBj2GIqqm/Eip+09C?=
 =?iso-8859-1?Q?tghsQpvuUp?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6qdtv3OJO55vdm5bq9t9m4ii2VI94FQQ0a9TSSVl+5Krp7YXfmdjALorxV?=
 =?iso-8859-1?Q?lej0181Tp88GWlLwX3u0pBbx5CZt+D0AZnAoHrup1+zu35m5zOnI5rX93F?=
 =?iso-8859-1?Q?NTv1JydkJ6UEC7b5ka6sdbcAx3++yB6A3ocMTytbsVOjZ1RmyiS/jJ29Uj?=
 =?iso-8859-1?Q?voG7Kya51v+fnZ2NeLDsbzfLip/At5k2fC3RavExxd5Pcmjmyv/0n2JqCa?=
 =?iso-8859-1?Q?59rR1WwAxnX83ddEDPLJV+833AD1lzzbO6haMRfEAN6SdJedMb0NbZH8i2?=
 =?iso-8859-1?Q?Vg+EMtFhDU6T2e5TdIYQ4N25nYDc6h7leGUFqcI6v3OtXPraHdg+wQhgQV?=
 =?iso-8859-1?Q?xjWFW1D9g9sWg9gJd2Q4MY0Qfi1Hq+uqE7Pgcei7utQrAlZwiT3B5PyHGm?=
 =?iso-8859-1?Q?BOyyG2KPZa55bWvYyC3lwhdh0SL3dSKwYieYBKgEpS2WEqCGYCW4669O+F?=
 =?iso-8859-1?Q?em3E/Sr/JAzbFltrubrwjXr9HVYdJzRvjNGeJOue4svtKCtqkpUPu0Dd4H?=
 =?iso-8859-1?Q?0+Na7bryIkOnaf5FI7AkjD6gNCqte7NK1C6tOuQyNrzG4kUbJwXFAHfxJT?=
 =?iso-8859-1?Q?NRVUUvXd3NLRiP9sozN7sW0WgrqA2nI9AcDnsg5LI3e/R8PN6pROmG02oB?=
 =?iso-8859-1?Q?VtZhOZYFzGYZo104NzWCfoz+A414eHwRN4KBoWIb0GQ+jTiR6qaLDy4pAY?=
 =?iso-8859-1?Q?2umiByB3xSnXNtSbATfecNsMYylyXsnYGF/CdigHHrph+qoR9fZDgrxyhI?=
 =?iso-8859-1?Q?Q5GQ1yu3CFQ1ZloChoDjbdN/4H7R3LuFz3PrPJg84/XZZ33tiXdCcTcmmd?=
 =?iso-8859-1?Q?WakbNE2JhdpiFFCFNFlsW7br8Yc+M2M3Wv/ilPt7+wbUOhVD9sFVghT/06?=
 =?iso-8859-1?Q?W/Yz2Vu3fOyfM3hp2vq87gM/lqwGy8+TeMAEJ4wvbVquKGTmol6p77Klnl?=
 =?iso-8859-1?Q?KoMwa/TWvhiy/PPB8WTw1ajmyqdFcU4gNqfLJdUoK87HpgDQ5m4Asskr78?=
 =?iso-8859-1?Q?RhKiVjN0ai2nAs2vDxvoMAlSAN+IQOaTDEPaUipWP9JdB7S50sNDIlt+vI?=
 =?iso-8859-1?Q?Lmc4tDvnPxiezSlNYY3QG6CWosFuPJPqDDdKU2G9KoTu5ULcNZpDb9T5MV?=
 =?iso-8859-1?Q?bCl/Jil5WB7r39Yt5JNbmkLWw9VxTUkgzB4po/lcDwoq4XaF4FKZ6NV6hx?=
 =?iso-8859-1?Q?A7j6ZzWfo4dZcl6bmrkCLFFUmiHZXJXrayStwZkb4DylehzfyOpcyzGGdC?=
 =?iso-8859-1?Q?0gPeKlxRME6vsOyUrAYg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3676.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d41bee-ca82-44c7-de29-08ddb3e600d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 12:44:19.3559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10748
X-Mailman-Approved-At: Wed, 25 Jun 2025 14:54:41 +0200
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

Hi all,=0A=
There is a problem with commit 2a00d73 (spl: mmc: Try to clean up raw-mode =
options):=0A=
now options SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION and SYS_MMCSD_RAW_MODE_=
U_BOOT_USE_PARTITION_TYPE are mutually exclusive. =0A=
However, SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is only used in commo=
n/spl/spl_mmc.c inside=0A=
a "#define SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION" block.=0A=
So this commit breaks the option SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TY=
PE.=0A=
Option SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE only makes sens if SYS_=
MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is enabled.=0A=
Regards,=0A=
Thomas=
