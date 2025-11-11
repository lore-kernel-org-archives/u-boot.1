Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1537BCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B29D83B5E;
	Tue, 11 Nov 2025 11:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="i9mPhVf3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6CC83B6C; Tue, 11 Nov 2025 11:10:49 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01AC83AB4
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp1tXa1KMM5Jx50X/RKAeiWi8+dnQGxu3VXSd01QdpExWcv6v7/WX0q+clOh1PQRThPd7QvU775kqqxw1cPSwwQ9yVRnwHUYFxcXVHj9dhp+260pUOM3EaLpCD2UHTKGl5naf2H68UIBRwhMiSllpcpXYGM+1MxM2gPNFBHHfCUvi3hdutPU3oHq8YuSWuYtNGWcNRFICC8ThisC8NXGzoCZSiI+m1oZeguzUCrI3GbFqEtRObvvWpz2Y/PPCJctfWGqowjcyAwXdtBt5HxqHLQx+NOlnetI+R0yTc/YSulQ2Gx0nimBMbOYTpWx10vQe2CN20jrXU2jrkL0rJquuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GfcQr2yBSHiv3XlnhT9VpkmpMkEijYIGLmJVUhxJGM=;
 b=dqD4d1xZMQm25WpoDgfbealzPsg8QEWTNv8eqiqE8fKakf0Lls6HSUpogx2GoDzes5Q7x1BvX0x+Sp1mFfl3ZYsf7pWfsmRcH4i3DCiSNIjcFZbwElnz6eXsz/uOwqgORMvjxuKIjOjHiYJbn5bn4MjTYlgcauGKnVdI0OoRaX/3AItFHxT1w3P+VgCEftGXCuXVd4w23k3sqy7y2THRCEG0ilyTJz8lgeb3XsXmEXR61+40PX2a43tV6PhlVV1dbnNtnD3b+VMNtWTMXKicS4JKEbOYFNwLCLAPeaXrvR5y13A84g10LeRJ7YRAXNpSYmm8Xx3a0daGvQKJAWniOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GfcQr2yBSHiv3XlnhT9VpkmpMkEijYIGLmJVUhxJGM=;
 b=i9mPhVf3saME0w/aqSEESexQzF28H4GbiLqNrRtKqzRUgA/DStbiGCq36eTAiNhA3+14np0fF00DJvvpjRKzMbrGdRz+ydYrzqlYRmoGTfxl35EIh4ce4rVsEKfR+7hSs5wSM1rFKdYjx0hb0xC67Y0DPeZRVCc/J+EGrVq/KSawd4vEA6W/JtuzXOFw9tHqV22lmqgo2jzv8YHkG9uSMc0Xp/+BYzxLuvqX3PC4e/Km5G+6U0O9hD0xavCJtkWN6Haw88A2VEoI4ZDs8N7rEOO/A2Vhua3JwpiIABjUwSdFAEyWudHL+yzky1q+Z6xMOUeVK4XKQ4hJk82RQrFAAA==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by PA1PR06MB10090.eurprd06.prod.outlook.com (2603:10a6:102:4f7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:10:45 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:10:45 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Quentin Schulz <foss+uboot@0leil.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>, Paul
 HENRYS <paul.henrys_ext@softathome.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov
 <ant.v.moryakov@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Bryan Brattlof <bb@ti.com>, Quentin Schulz
 <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/3] fit: support signing with only an engine_id
Thread-Topic: [PATCH 1/3] fit: support signing with only an engine_id
Thread-Index: AQHcSnpMBE5zv88q1EGNp1M46mqQ4rTtUDIN
Date: Tue, 11 Nov 2025 10:10:45 +0000
Message-ID: <DB9PR06MB8512AD90ECF9AD5DA1578979CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-1-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-1-c13c1b5dac43@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-11T10:10:44.746Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|PA1PR06MB10090:EE_
x-ms-office365-filtering-correlation-id: 812ae03f-62e8-40c2-221f-08de210a9433
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hAf0VLyxlWHE27wHR20XQp+jcKLc1ewH4ne6+ijXiDopgHB4AafVeRU7oV?=
 =?iso-8859-1?Q?S6+zn4rr7NfqMXO5ZueDAIy6iuCdQ1cRvWqRF8ddWYtOAnf2R4GPTsb/dT?=
 =?iso-8859-1?Q?uJi43DuD0Bl5eWhxUHvCGAAPTFta6QwWrel4fnlHyt+RmR12JARyKMvVnU?=
 =?iso-8859-1?Q?j4btrNHaYOXraOdkvnie5uI7QzoV6MU/oQ6x0x8hY3hApPl35D/ePiVsKb?=
 =?iso-8859-1?Q?oGoX4AI9W7Z0IEYuMABicQ96QVsTrQEV2XV23U1ygHsUFh2I1G+UkInYZm?=
 =?iso-8859-1?Q?1ZDlyk2wgNvHEKfUN+kIFvIuhtf8AvOwDkZKFmFxcSFxLFdxw2oq38yNwa?=
 =?iso-8859-1?Q?u12+E6GY/AQwCPT6sA37CY5WFBGuPjuB2+ye6CyupWTNb15RZQr+2qrzfX?=
 =?iso-8859-1?Q?XNnnB/lJQu8dx9WbUZ0PbzcBz/Vj/h7TUxHIyNfeMkjco6CxgUzyDCygHD?=
 =?iso-8859-1?Q?E7TjO5wve1/eSpTo+ngXv3vuW8pdOkjUl6TMQn2xqW8GqV/0DQKo6QZ2/X?=
 =?iso-8859-1?Q?JnL5ZLfvucPNoinz0HkExVSVwtiDu0ff3lXS676alF2YqdbOgfkMnpiryN?=
 =?iso-8859-1?Q?A2eimSyVxyv2/lwYkz5w+7ql/zlIpp2vTjsby3yZQ2++IiiOPHai8e7fRg?=
 =?iso-8859-1?Q?0zXndbkXycY0FnMI1Sm4rfn2KqPgAkl9ulQVO4fzcRnBC8kgbmpuhEMNQy?=
 =?iso-8859-1?Q?fIP0SWS8cQNGpolleYudFO7AjY1fDPlxsWCnumQBafSBkXPPpy8s0vsTc+?=
 =?iso-8859-1?Q?CSIFiyyNw3IKHhvbVqaCqIkYa8D/XhZDMcLOE9MQiROE2ot+COb9LucsJM?=
 =?iso-8859-1?Q?RjUNOKFApjqEUnCHf2MP8CFx3OuiINRISw+lT5G4utlXw7N5iV7EWtrO8F?=
 =?iso-8859-1?Q?Vg9+tQ29OrxwEqFXkMdl42QAHGhLOScVehpBF3SMa4B/tKaH2YX4dLj3oH?=
 =?iso-8859-1?Q?wl6Gb1Tf7HXQcEITy3fBpbrG9N7cKwzkO/FXxf7RVYnDFLZRluCBlEO3xl?=
 =?iso-8859-1?Q?7n8iUIFEizLqmf9xLMd2F6KWUokbFsJisV7KU3ZUDvvmQ6gg0sg9oWYyBD?=
 =?iso-8859-1?Q?m2gybpprGpq3te8IQmhHlbDiOVwWwEzDlo9Nhl2oKxXTo/nfiQ6a0MagAF?=
 =?iso-8859-1?Q?LD/U2PHtdpDERw2ytDEt5wXt24pSTQaj6Z9R7sVqViEMnxa8a0kxxAbNQs?=
 =?iso-8859-1?Q?XtsPtgP4dPgUe3CzQTy2joB3Qoh7yJWv5P0pczIR9OFBQVpEMyd0xb7yQU?=
 =?iso-8859-1?Q?v79BJfrlKcVWJAcw9HbDBSnWkRuCRNs2miLFdP4WkJCLDA7nPjLqRADTNU?=
 =?iso-8859-1?Q?WViN9XttYm0/2A6ZO0yhZIbfej8SlWaNn8Afl/Vq10Z3v5UdtdArGEpVoM?=
 =?iso-8859-1?Q?xfI9QcSJqWF5swBEUiqC0HdBs4xcDWor20drF31d1fVvLDMfRIL2xqwelf?=
 =?iso-8859-1?Q?3u+Y/RfBZaJfSJSZhHwz7M5FcFa1SFGCx/X5vpr61HGHKk4iBBV08aswGD?=
 =?iso-8859-1?Q?14a/x2037q29xNZDGYY55apoYKNm9hUJv3wD+AfG7Lxtdw4PxeucnMkIoV?=
 =?iso-8859-1?Q?fyVFfjlbqc2pEKx5g0q4gU3rgC2n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bpb8vPFAFEU02kCZ8xDzoiyQ/o/W8c7vEyLlQjCC9s53p6R4EHFdcL3vI+?=
 =?iso-8859-1?Q?1XU64Cv68/sl2mu4790lQlkmWbQfgM9ymyVu06Y3sTX/usrd1kdNlpDA5G?=
 =?iso-8859-1?Q?O+3++LcL9z9IXgJoFeb5rbNcGye3ILjEgKS89d/zmPb10MbonXvhdrHez8?=
 =?iso-8859-1?Q?X1l9XAJ4Xu2ATROq8/iP7+5UwlnBzO4xYCRvLsAlL3EBdCC32gzKzUR7sB?=
 =?iso-8859-1?Q?zRie85sIkMTPkEeFSsGAuqz2O2KMigtgs/3kddpn8j4apuir2/u6nUKvV4?=
 =?iso-8859-1?Q?MGLSG7cQGbuOKp/YM8ThsgF5NrMcEz156MFMPP1PSb1ZVv5OAwHWOMrWF+?=
 =?iso-8859-1?Q?pwdgv1nkR1QFaBF8Flt0h7udpJ8wIt0Dzytt5WH5ItF+UtiUa7bH/zDnsB?=
 =?iso-8859-1?Q?3AFfAGu389EVJhI/Fhv/CM6pQBRfGPxmQwF6YRnqhNl2lwgm9BUDXVKVqC?=
 =?iso-8859-1?Q?NCXa6k6Fh+szz4583xIrXmNqjHJ6zrypUM2rIw+IHhN8NagD6k3yTrdIPg?=
 =?iso-8859-1?Q?ICUifxPS0dd9DK8BEC9rcJlT8l7rqfic5DJydnbE1Jt8+POZSkO0fEAzIc?=
 =?iso-8859-1?Q?M5hKl2pHmol+HTK+ZE8m/n3Dmp9kN9CQA9EddaCNR1veSxSylorqcGFuVb?=
 =?iso-8859-1?Q?yA+NwE/TQ8O1N+0e2WWDRTMtVMoBj20WutqJkMeVDyYJMUo0952IF6AWVt?=
 =?iso-8859-1?Q?DO+o/a+VKfb4ja1NmaCbuIanjc4CnJe2f7tqXraeOwWXueHThMiV1xAVqW?=
 =?iso-8859-1?Q?VbPrCv2pb3jaTVhtR4zYvU81fv4ruqNNLgaCN8cNj4sC2kmSs9DQ8GkdeC?=
 =?iso-8859-1?Q?gfI/osYIDr0RtlkTORzgOsC6HE8iP3AK7cVOPmcaveL7/8Zvhlfxg08sIo?=
 =?iso-8859-1?Q?tQ/fAGa6ttPSw8FMje3pcZWXmwKLwJevTJz3nBjDfxPz3X22tr4PmOyKqI?=
 =?iso-8859-1?Q?jciuRZbcnaI0QIZh0jkMyNL5eQMY91NfbNUc53NJpXhc60BoyZt43SaEMM?=
 =?iso-8859-1?Q?tcufC2Q3+3XjKrx6HmKpE6j5LGc0gl+T0ovIaAQwzTqFfWnzyn+xUzqLX7?=
 =?iso-8859-1?Q?6BVtsL1GpQRzemlCEDG2exyDB6TA7Gfi9FojDZ60+PrH8uNwUFXc6yHyNC?=
 =?iso-8859-1?Q?/M3c51GlN50Vzn8jQIalzxYWYR5HoOzI3x706wwVFlFsgx8bVtACJCIME7?=
 =?iso-8859-1?Q?jHJvVHprXFtIXUSOSlup5S1P6k45wLrU65bh4MHhwWm71XttB3mjN2NFZl?=
 =?iso-8859-1?Q?l2JA/pJQtqCGFk02HadAA3NY+GLag3fuverXarm/AGpIRQ55RqPBrnVmIK?=
 =?iso-8859-1?Q?GE5ytjwmXgwGqLllDCcvGrvtwjCbSawgSK2h+m1vDICFnQ/MstULuBIq8i?=
 =?iso-8859-1?Q?GEPzjI0C8UALXx+IYjosdWRu2TLyXSNPkI+syCHqYvyeIAL+ThdgYBONLt?=
 =?iso-8859-1?Q?InN8jrvKkHeBfGNaPi0LRwYUOE49c8dCkjkIJksi/y1qEWNimZG3gq993m?=
 =?iso-8859-1?Q?5RnKeCUhYQAVvRJ6Km4bs0hVfSIJt/crYAGUgFO9N3bxUMNOf5AnqA5jBS?=
 =?iso-8859-1?Q?hhUFtL+9XCClmx/AG4BYocrYKIzAOurmhM4IEocnsT5PJ05Gaow4kpNonx?=
 =?iso-8859-1?Q?oNCsgYZTv/uevtgkRAPLZ1mU9MMj1XVno7IdNmeSNXMbvJ7rGAi9nU6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812ae03f-62e8-40c2-221f-08de210a9433
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 10:10:45.2447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cyz8Gwc/8FTCuGVwEZv/HkdD/yWFIPtd3BdzzHf9nGwmaWOrcKG6HiuuGoCJ3SqSf1D0E2WJVsVdz9LmgyQme5LE3yO/8AaO8gYqZ8qnX6WuPOWbwlzmITLBLbcckW99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB10090
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

Hi Quentin,=0A=
=0A=
From: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> Currently, when one wants to use an OpenSSL engine to sign a FIT image,=
=0A=
> one needs to pass a keydir (via -k) to mkimage which will then be=0A=
> prepended to the value of the key-name-hint before being passed as=0A=
> key_id argument to the OpenSSL Engine API, or pass a keyfile (via -G) to=
=0A=
> mkimage.=0A=
> =0A=
> My OpenSSL engine only has "slots" which are not mapped like=0A=
> directories, so using keydir is not proper, though I could simply have=0A=
> -k '' I guess but this won't work currently with binman anyway.=0A=
> =0A=
> Additionally, passing a keyfile when using an engine doesn't make sense=
=0A=
> as the key is stored in the engine.=0A=
> =0A=
> Let simply allow FIT images be signed if both keydir and keyfile are=0A=
> missing but an engine is to be used.=0A=
> =0A=
> The keyname member is already filled by looking at key-name-hint=0A=
> property in the FIT and passed verbatim to the engine, which is exactly=
=0A=
> what is needed here.=0A=
> =0A=
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>=0A=
> ---=0A=
> =A0tools/fit_image.c=A0 | 3 ++-=0A=
> =A0tools/image-host.c | 4 ++--=0A=
> =A02 files changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
Reviewed-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>=0A=
=0A=
Regards, Wolfgang=
