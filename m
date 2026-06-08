Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22834CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C7383EEF;
	Mon,  8 Jun 2026 15:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FuSwyPeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC39A846B1; Mon,  8 Jun 2026 11:37:52 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 427E9807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTE15MLitr2KVOrHFwPsZwVNnf80pTxdcw7X+lrZnoFc1noYcToqnsq+pjrhg+i1oOI1cqV6Yghl75L2EMt5T3AcZMDhoZdS7toGnAPaRUzyzn9N0799MOlLU8yQJPGawPMuUj5VP0nyYgunsr+9VAekQKhacTFJOzqJlftGwMtnCErIj7mG4c24i3gz68s/KTc4DlfMRZkg92PiNErVFzknOKgD/aG6yoQar5Yw74PTxXFWw/QkUjlZoIW5dfkLZJkA7LFFwh+aToO1UceeONwUAcztFU/7/QeDZz+ycEpNIZHwF0hww0RppnDpT02gC2zLA95dIxrtonar9UMnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM+nhJx9osSMKUlQNKEWm46U2UmTPSA6AeGGbFCT1is=;
 b=KyG084crAUAcWS+dMtbEnnlMxqeshpCVcLqBaecoTTNLU3ikXaEY+ZJqj7dnhVcjdXHPLLhv6m79xkTJFQuweMMFeVTp4xLnk98Py8KlN2vNVs2ta6biugsgEYKEKAvZfz3n9b3c9p/+fgZJfwUIrzmz2Z6s2qAoTX3nJxen2zJspdu2I9go/OIulRwGJ09y1mTkEOW6WRb+3fsuqaiTtqSzZusz2ShHnwcoDI4htAcTIocGvo3o8DyYD8CbQEIs3i3g03nniUmpeTXmsKjKM1wZ3uuXgPrJdl67NgTZYL+fgCJKr/AhwGPMeQFMvgrh2Nw+56eEAaNm82487ubxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM+nhJx9osSMKUlQNKEWm46U2UmTPSA6AeGGbFCT1is=;
 b=FuSwyPeJxfBaRxAnS9r4d9y9Bt8zk1HVEomQpBTAc/3PYgcy/D0fY/P0LRsfctPRjIUmI+5G/zuAuujxIxi377zCYLTCDQfhVSMZhM6wByzh71pDPgbpLa320dHa8RyzrA7LewxSTGkGAdzU+4K0bojLik6zMbSvHOfo3nTpVwVaWfe0AbU42NcIUGn3LkE9Y1P/dg/3g1/1gdvmG2WZ1h+yZIY2J+ZqUxvU6MRebZChct7GJOB1/datyRAmQtEEP3/vsoouVR/HE+UrBgqvohdZOgZ1c4J/JNhYCmlt1zY15l6EHE52dy1HI85ufmG8IQ8bRfsMyp8RHN/8X80Juw==
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BLAPR03MB5444.namprd03.prod.outlook.com (2603:10b6:208:287::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 09:37:44 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 09:37:44 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: Michal Simek <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alexander Dahl <ada@thorsis.com>, Tom Rini <trini@konsulko.com>, "Chee,
 Tien Fong" <tien.fong.chee@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>, "Rosdi, Danish Ahmad"
 <danish.ahmad.rosdi@altera.com>, "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
Subject: Re: [PATCH v4] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
Thread-Topic: [PATCH v4] drivers: fpga: Use FPGA_INTEL_SDM_MAILBOX conditional
 instead of Agilex/Stratix10
Thread-Index: AQHc1tApwUFoyAnwhkGP057WCjDO9bY0GU87gAB8bwCAABAUgQ==
Date: Mon, 8 Jun 2026 09:37:43 +0000
Message-ID: <IA3PR03MB80217E71C2F3A3995608F304C31C2@IA3PR03MB8021.namprd03.prod.outlook.com>
References: <20260428053030.19532-1-chen.huei.lok@altera.com>
 <IA3PR03MB80212DA982EA73C977D48CFBC31C2@IA3PR03MB8021.namprd03.prod.outlook.com>
 <dbfe4a51-22f1-46f6-bea7-7b2e4e4e0414@amd.com>
In-Reply-To: <dbfe4a51-22f1-46f6-bea7-7b2e4e4e0414@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8021:EE_|BLAPR03MB5444:EE_
x-ms-office365-filtering-correlation-id: 90b58fcd-8b5c-4720-1fca-08dec5419798
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|38070700021|55112099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: ImDziawMIusC8Dei15BWXOO4y8fE6Ol9A3b4heCFZftx87cvHxuxl/WLdQ9TB+NN5lHVggT0LsLsT4qP2YMmmNvrWaJnQRTZr60cvRLBP190gDQ4QsAmmaBpRiAH+O63vPDnQZFBUNRIegYY72h2w5Zk71MTl0HC0KyDa2eJx+0DN375mPiQnua32LEGHZnJNNlJymNM1NmLn/ltVqqmZOuU9Tg4rOLM/JVmEBO3i/OUTsWqbV/CGTS8CQfrqP1+FPDCuwWWRGDpbhy5rs+/xZBf9FYmZPWy+YVBQ2OUCkq5nNOaATmmwM5p9LeoeAUBeewSEpJh3rC7R14XFoaRJ96sOTRcg9CfgcvUYiN1szdtYzPZlZl2rcm3xRuc1iQv932Wnq0kC7GGAU45HPAmdH2IGAd230M9N+RxmGY6szHQsvdnPwy0jyBWRY23Z4x9jdDMRzedZ2UQx+gyX55H9zDiV7bml1F0WWvb3QKypUoVA3/g0KHidHa5o/WawVlgRI9u7K0HP/jqT0cfc4757tV8ydIRCtil7iR7WT+PbFN/kY+KKzyh3WJ3wAtvi7FLWV7fRMw59iprdXPuYHifUf3KTiBW43jFaoc4ZM6aKt5insmQ/4cYlSw/eAFJ4MxlNqYSqU1dZIe9A/87FIbbgQQ/tbPsXnZUY8e2FCbuhCp43BGiaSzdIo3w/sRqakaRuhXzj3AEgZTkTXVjqPhIXwwGx0SAve0SlW1+A3BRqJ+XHWXqjIjWH+4DwHtvoy1n
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(38070700021)(55112099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fl1sRbNWSMJqlJvuVEXWbL1CVZKVgI2QmJdth/5G/owyxBnSNwkGCvjJc1?=
 =?iso-8859-1?Q?KCWcjI9fcbBNtEeWFgi6RGmC3maoTn11xgWGB5slEE0Ha+WPIgapkZ+Jf1?=
 =?iso-8859-1?Q?5NzoWYTaG5y3m1aB136pT56q/rq8gKbelh9roLwynUebpM5TQqhXgtybhj?=
 =?iso-8859-1?Q?sHMe5//u5r4vDgaUBnabneJSWSWhYDukDJNLfsaw9pR9J1GWVaT2H/PhiM?=
 =?iso-8859-1?Q?8mN7TaanALWOvXJ3ZtKh6lrl9ZLIJBO9T7AUPPdKY4gyRIbVDnHakgR2zH?=
 =?iso-8859-1?Q?DTyNUL6BeRMUurMvItvyRcpqqAAXxWNi/ZAg7H6gE7bdInleG18ckG6U2h?=
 =?iso-8859-1?Q?qn7bLjLDZuTRjUELlqyFkz/0nPwrSWws3qt2VQBW4mp/rBVChJQoud2B52?=
 =?iso-8859-1?Q?HdoZ66f/B+g3Om4qFZwHe6X4ZDKfSkNabKq+ffg0I92QC6ueQMslk6I2KL?=
 =?iso-8859-1?Q?qGEA7VIMfK4+gMNQ+9Yvxq6P/1zlq9UgLpDmvDQlAXzQr0JR+eg4rUObmR?=
 =?iso-8859-1?Q?VvUBz/1A2yv4lQq5Uk0ewl01w3DZkSNeORcwXcTZp/bVDekKo9tm/6XnT+?=
 =?iso-8859-1?Q?S2cl8Mkq2QKXEBYiL8fa0dpgrpRjGoYo/zTLkKsx+XA/SsKu8LXSyPPwP0?=
 =?iso-8859-1?Q?7NM2oFILItmGqgyF/yrUB0YPhvvsbI75wNGiljlgYjAqHKyZ1/94F6okm1?=
 =?iso-8859-1?Q?cJ73VprjJgtw/2qovPl5nyZ6ofpDAOVoN5zZG6kPBBMOmbbId4PD7lSzee?=
 =?iso-8859-1?Q?uapXHOZzfzu/l8a+rwBCIewBO5SI0MGzewT2ZtIyeX9sMiFGfWSAScJDsx?=
 =?iso-8859-1?Q?1JKNkTNgpYvCFgqACrcdqb7enHklA53meMxfmQG7HCNcayRmMRTPnl0QeA?=
 =?iso-8859-1?Q?d/LBUTAPBQpWL3TgJZgDxPtJY9n+JZ6RWvoLavLe2rjFyk8MGC8mqq46Qa?=
 =?iso-8859-1?Q?GrK0HqYoWYV9o1YXzi4t6WabPuvBMkH0xW3Gy/XScH/f25aXApl2TpWnhK?=
 =?iso-8859-1?Q?doWwc/vZqheNkEijySw+jmvVAQK9blthkJhmrJwATBTdovGsBPnI+zs4F2?=
 =?iso-8859-1?Q?WCfpS3HSI8f0SfNJVX66mxzNi81AEYXPHHtFzOgWKvLzIK6nKvjxrh8MeJ?=
 =?iso-8859-1?Q?u3/niunI7nCeQO3CL2b0a97Ck0evNkNqFYglr/I08RTo3g9nprrHsiJLY+?=
 =?iso-8859-1?Q?u8ld/FCHo2VQVeIqL4F2zBxrruKnUPM6bEv8ZsmQlSSuwZfDQc83wbuE9+?=
 =?iso-8859-1?Q?Fw9Y0KRe4Y9daNWxcYD+7hBWqpRKPVi9UmieB4aCYxGXeqZfnLHDARb/I1?=
 =?iso-8859-1?Q?z1votiCr+TtmO85NWQqhyzDKZ52qvJimE5G6SSLqy3f20/bKwEJ4LqUKzh?=
 =?iso-8859-1?Q?2J9nfdGL/sLbD1+WwssmOxm/0vjootTMEjhy6u1yEwHaWhUFrDSdwfYA5F?=
 =?iso-8859-1?Q?QNip0LytJAkngRnA1X1CHBIS2Q7TCCd9vroXNcGfbPvHxP6GB0OykE7ZxL?=
 =?iso-8859-1?Q?hpTCzJzabntgWebkR9Ocn28Itr5QvcGfSjoM/tIDvNafLWzfAJevnXitwg?=
 =?iso-8859-1?Q?yBykjEHjhM79NMdHpaCHJbN/O1fboYptZA4NtH9gmxOe4D5moBCa1n8ing?=
 =?iso-8859-1?Q?fQVQg7QOkwztG9H4AWMIKoXo/tBdshvoAaIBclinUEtPauh1OuYguRI0Ur?=
 =?iso-8859-1?Q?+++VpeF1wEY4lv6Pr2NLO1AC0ZRiBn1YGhiST0k5GgfaPRImICjSlwajGQ?=
 =?iso-8859-1?Q?YMM2yP37dTYEjeMZ6Jp/E5FdW2ZEEG7MePbEtL8sEVgo5pQuFC3uZJGflQ?=
 =?iso-8859-1?Q?CLr8Wc717A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b58fcd-8b5c-4720-1fca-08dec5419798
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 09:37:43.9949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3urlhE4kN1ZG/9l63iVuh/1ql1B5FM1EGyXIIsbFvc3jvrkNRX8aXmp0Z7URZkWabAk+zZ355TlccnmNnR27ko+IhbzaXNxDC5fMcx3L1B0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5444
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:05:23 +0200
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

Hi Michal,=0A=
=0A=
On 6/8/26 16:34, Michal Simek wrote:=0A=
> On 6/8/26 03:19, LOK, CHEN HUEI wrote:=0A=
>> Hi Michal,=0A=
>>=0A=
>> Following up on this v4 -- this addresses Tien Fong's review from v3=0A=
>> by switching to CONFIG_FPGA_INTEL_SDM_MAILBOX as the conditional=0A=
>> instead of the per-SoC arch checks.=0A=
>>=0A=
>>> Replace the conditional compilation checks for=0A=
>>> CONFIG_ARCH_SOCFPGA_AGILEX and CONFIG_ARCH_SOCFPGA_STRATIX10 with=0A=
>>> CONFIG_FPGA_INTEL_SDM_MAILBOX.=0A=
>>>=0A=
>>> Signed-off-by: drosdi <danish.ahmad.rosdi@altera.com>=0A=
>=0A=
> Obviously this is wrong name. Please fix it too.=0A=
=0A=
Sure. Will fix the Signed-off-by to use the real full name in v5.=0A=
=0A=
Thanks,=0A=
Lok=
