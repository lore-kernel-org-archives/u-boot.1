Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D27C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 06:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 590C984AB5;
	Wed, 15 Jul 2026 08:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jABxqqk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5381584AC5; Wed, 15 Jul 2026 08:44:32 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA98584A67
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlO/3J/hTwVSaHUQUyozAYgXpOXelg9BfdI6QJ0SYHZiYE/0oSe3RKRSVcZV6u2cgeW1gCcEAUFLn0Z21GftQjEpIwjRSK2KShEUNN6yFsxqHMMISmoAyjYKZcAuU4OaeDiANGEQdnmO0RMf4eyR98fsZC4rMThaLtBVffiGUeZPgtGhF4j9jibKFvzkdPj5w6Rh2Kgs+8qbb8aVrZ++P/ws+CY2qtV0LlfL2g1s1eauaZxM3igD3yRHWrmjFrKOvfbgF4hSSpM3Ndrf8MHfROPJlnHdqFHweokr43yS7hKa2RRvmCS3rNKlUzZqVUvK+f4asMJOY9Q3Hj/xqf1CsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2c6oFguAoDWhSZVtaMkV487TA7iXNdO+Je6IbEu1+Kg=;
 b=dmQ1gNQlchzsbOlPpPe9l6Eu4MzJrkjRaQkzWhrQ045iCQrmnIkQZddZxsPo8vUEX++Hlnhfwsxyslb9J+ENMhVXH00uqnrBLnMPQIOdjOT7jlGeiaDpJ1YAtaphObhobbrERr7jROVFwc1Zlqj4YsGrx3NZEnU5xvNbUZ9mWu3SO0DUwynSZHvwA9445L5RCja3G7qkxCDzE9KufWXTdNaqFxnnhrFJT3mjxRvQ8c+2kB/XOiAtkaRLgNO2LEB+fae6ryAslRPAFxTD8AOlcJb/Asa0oHCJDtIRtBgiLxtfMO48uxqlTunX8hDYnwbzNgar/0GVfxsVWFKZ5NcKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c6oFguAoDWhSZVtaMkV487TA7iXNdO+Je6IbEu1+Kg=;
 b=jABxqqk9tZ22NgWXM2jXU7GSLoxolK75xDP39aAYoV+OZLZV1Ki1n9VO09OMtnLL4bvrI412Aj+YX7GeysjczQeU9ryDo6+v1IbIy9WLIXkeH6ZzZdhR1uBSwMAOvnArI1/Lqnz8/e7SeAbKqs6JDrFk7cvxieCFwAoqs7Y/7E1wFnT2rzMgk7U123gFFs8L83iM6ym1WECb94TfO7V6KU8B/0lnUeez76orZ0l7EunNM5nYQXWkmaUCFBLgsGjbvXmqR3/RgBAFOL+6/NGXboJ7DZ1fS7l9yZOAPsimzS0GPeN4is5bXLsd/JZ/6/TGrUyoQlQ335E1Nr//GZy4hA==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by LV1PR03MB989608.namprd03.prod.outlook.com (2603:10b6:408:3f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 06:44:27 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 06:44:26 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
CC: Christian Marangi <ansuelsmth@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, "Chee, Tien
 Fong" <tien.fong.chee@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "conor@kernel.org" <conor@kernel.org>, "jagan@edgeble.ai" <jagan@edgeble.ai>
Subject: Re: [PATCH v1] spi: dw: Allow bits_per_word to be configured by
 device drivers
Thread-Topic: [PATCH v1] spi: dw: Allow bits_per_word to be configured by
 device drivers
Thread-Index: AQHcsds7HwRRcRhI+kK9UbX3VPelubZu4vs9
Date: Wed, 15 Jul 2026 06:44:26 +0000
Message-ID: <SA3PR03MB7187C29B807FF1D6A27A417BB4F82@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260312044633.29242-1-boon.khai.ng@altera.com>
In-Reply-To: <20260312044633.29242-1-boon.khai.ng@altera.com>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-07-15T06:44:24.588Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=1;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|LV1PR03MB989608:EE_
x-ms-office365-filtering-correlation-id: 55dd1a8c-260b-48b2-774a-08dee23c83a2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|38070700021|13003099007|6133799003|56012099006|11063799006|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info: CH7UwmGEwZ5vi8ICLJCyv1avd/DojT8l43hMD3ZOZfM9vscqMj7VCUIcWG+nRETrDPvmtN2AnPyCpSA9cK2qWHvdrrv5kBAlV0GWtjk7AnPyMBMJREsYIOsRUcOwFiI5qs/HE+qye18e0PplEWbrFtSxr473ZTQ2agHxtJXtttDWPkcJBP9pG8mY3GZsCUAVNfS5sNgKVEQV7oZQT8EC+pPaDQ160C34IlDjXZx0DQLdPVaXRvnnvqLaYtN6NU4kcnGOLACH10ElywLAbiePnDeSbEvPB2Nu3C/Gev9195871+lnQT25TAdSaGIRqWsZ2yDIlhVSwClzp/1xG0H1PS5zpxRXQyyTij2i7OznmLDbLUVvUFuElsyxKO6mH5NQMRVi8Z9BkN0MRBo3Cof2ZkNdR5pPgrBW+LPa6P6I/oymZPQ1OMeAiomaa/TdhgYNAtdclPR4F94hoenVHctonodYUA6IAFHB7Ba5JY2uCJyfZu05wToUKFr3pRMQOgX8tZZN8qGTOAyfd5g/7tWs7rU7rVNZQOAu3xWtTJVwwHp+La8PGStvJeYHa7Z5V2aZFbMgkHiZveusENOdwCw9FAxhvAiTUViJckd0eXzsUfZIKtRxOCdCeubKCGugRyTLcua0/b/NPFOtc8WJ0XlwWX7mxL9wHr3Oc/vNIGk7vlc/a7lkpqBfVOaSYDomUTLVjYttgfSK06DaZyt+wiOrDcQ8M3b3a4XXnwtZaFlDdqU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(13003099007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xQkGgFMtD+Pucu33ymoss5f9JmPmVJ8Gs84uuacY0MjvAgkGoTcdG0qOpY?=
 =?iso-8859-1?Q?8f5V9WRzQfDSrvstSwu9kojqXPHVwIREfd3EVYviGLvQwf/760aS8C9ruT?=
 =?iso-8859-1?Q?40ZkluwUiFLgQFur5//x8EzBlfDnVvWyAkxWyN/nLLYwGbiaVtSuUF3YYc?=
 =?iso-8859-1?Q?ilYiFS683DWwmpVahAPmLRevlNCmoz8rBudwXSLKzoKT4L+LguEFyxOYst?=
 =?iso-8859-1?Q?lLx2AUt5xV3RpIr3arMGO+ju+5HjkZ17UGtkAeSxygqBZn7ANr4tT5M0Is?=
 =?iso-8859-1?Q?+Zqa4wuitBY0ml9zt64RD15ydgDVO6A8dlbHwXsAwTGD6Y+C5MXuyJM5nD?=
 =?iso-8859-1?Q?QmbdouJeDzItTs3g1WYFV2hegYUsbqVdQXq6+XDRwXcS+argOw1q/5wPP5?=
 =?iso-8859-1?Q?7lcM0Qoe1jKCfPaG057sb9YPytX3IldDlLpSL7s0M5mNZRfsLKtXIW9GF7?=
 =?iso-8859-1?Q?umwFEXA/G9IfqSwPItDf96oNhVgGcbIM0VXBZUkpN27v5z4eVsngjIzFUP?=
 =?iso-8859-1?Q?jAemgO5gfqFbyZyYMBhRXbC0m1pU/G/4MDMhMzlbjn+gMNw60awiDp4CjF?=
 =?iso-8859-1?Q?xLhCF5k7yNIEwMqpPSllPC883ZLiTBuqLjKcRSXQl2nGSUmAjRuN2qNeIn?=
 =?iso-8859-1?Q?GD6YSJc4gJRcBfMhIUxwepYfFiw8pk0QIF+DNJfJl+SBF9gTgpP0z/0fCc?=
 =?iso-8859-1?Q?pG5hquI5JOrJ33wmSN/k0A139UkfwvlJV7Qa9fKCijl8OTt7MnhioRN7w4?=
 =?iso-8859-1?Q?tYEay8gZVktuMf9vTe0yJK5A6FzDYrMykYykGZEXhJH9dHHOAYBl7h/nk4?=
 =?iso-8859-1?Q?14DNz5TMlMKzu1uQzOHuQQ5tqNdObHudeIKl3NjGZH9rMrO4rXay410cWW?=
 =?iso-8859-1?Q?nBjogmdS3ZLcqfDvNNQcTbRZ8arp69VHDIAs2iQL/be4yVCWFWA5fyc8Ut?=
 =?iso-8859-1?Q?OD4GwWojT1YB9XW80V9dvZsGnyao1rsj/Pt2s7DHejBtI2nhelmf0BbtZ3?=
 =?iso-8859-1?Q?nYGF+EXKjTDUCxnHfZXHEAg2kDMGiog0pgrm5Ao5yYPwUBn0Mblq7+pml4?=
 =?iso-8859-1?Q?Ahnd44eIPrBVopis/h5BMdra8j5AovrjfSnWjVhzTq34eZd/Otfu7KTaKv?=
 =?iso-8859-1?Q?9R+LCkmkwnb3q/MtHdRWJTWM0Xbz+9PAVEw2O79nI569n6IKLPug1cY49i?=
 =?iso-8859-1?Q?Fl9X7Jffc/yenPtgBrIM+dRaXMU6AlYgzibx/PuyilR7uoZgArNw2D3XIP?=
 =?iso-8859-1?Q?e6PI3WwsFZ65HiUB9UqTSn8YgUakemWsSoa45NpbCc0OcAwEWVmdeH69Hp?=
 =?iso-8859-1?Q?kKC9amX1W/ZYOkWfIdF0HwvEwtZPKjK14euwoIJWOlRl9s98TlffxcxZ4K?=
 =?iso-8859-1?Q?dFvfTTnUhJrNfmXm1plsgieAI9eOSuUoFtmZbXmLzUzUuJnV6fHl4ZlNNj?=
 =?iso-8859-1?Q?dpcXHRIvr9KD6SNwcEjoSHjT4U8HiFA8ZCElZAlt2Xzlo75gA5X0FWnM4K?=
 =?iso-8859-1?Q?ao3aSe2yJG5e8RDMD8fjTdneVCChD1oKjIVsyL8sY03DZS2hqgtrL6zRgk?=
 =?iso-8859-1?Q?IU3F4VAQ/DTPuNzgvtJunyb0PwXm53KRaG5bSAE5p0giuJrGMwP7tDe9ve?=
 =?iso-8859-1?Q?BEdgSMrSudhNAGZXQuStIuEy4Sxi6qp6uUpkcqIuoOtbndbmE36vWwUz9U?=
 =?iso-8859-1?Q?N2orQO73f5ikyKRXyRobMJhU9Ueu/+AkglAv7vUkcuHvAe5APA39KD9sVY?=
 =?iso-8859-1?Q?96h8QyKR6rOhBlQJR9C/+PKMkG6w+QL0aH6AmTtRh39t6H8ho670mSKi2o?=
 =?iso-8859-1?Q?l0OjSK3neA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dd1a8c-260b-48b2-774a-08dee23c83a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 06:44:26.7228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxoNPIij9NiIFU9To4885xOeKc+6R6qZFLNMAoqRbjSyaW+Bh7G20TzsGAGptG/FBwsbsTwUJv+JSicSddknQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR03MB989608
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

Hi Tom, Cornor, Jagan,=0A=
=0A=
I would like to follow up on this patch.=0A=
=0A=
The original patch introduced a Device Tree binding for =0A=
bits-per-word, but based on the feedback from Tom and Conor,=0A=
I reworked the implementation to follow the Linux model instead.=0A=
Specifically, the updated implementation:=0A=
=0A=
Adds bits_per_word to struct spi_slave.=0A=
Reads slave->bits_per_word in dw_spi_xfer() before each transfer.=0A=
Validates the requested value against the controller capabilities.=0A=
Defaults to 8-bit transfers when bits_per_word is not set, =0A=
preserving backward compatibility.=0A=
=0A=
The updated patch has been submitted here:=0A=
https://patchwork.ozlabs.org/project/uboot/patch/=0A=
20260312044633.29242-1-boon.khai.ng@altera.com/=0A=
=0A=
For reference, the original discussion and patch are here:=0A=
https://patchwork.ozlabs.org/project/uboot/patch/=0A=
20260227110434.5058-1-boon.khai.ng@altera.com/=0A=
=0A=
When you have some time, could you please take=0A=
a look at the new patch? I'd appreciate any feedback=0A=
or comments, and if the approach looks good,=0A=
I'd be grateful if it could be considered for merging.=0A=
=0A=
Thank you for your time and guidance throughout=0A=
this discussion.=0A=
=0A=
Best regards,=0A=
Boon Khai=0A=
