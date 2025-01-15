Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B6E77188
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 02:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF718069A;
	Wed, 15 Jan 2025 03:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="heIy57De";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C095B806FB; Wed, 15 Jan 2025 03:11:24 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77DB98060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 03:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJRGcLyA1AG6S77AbzqnphyxSroYiWO5z6EuivAyqWGmYifMJFxRbZ0/dHUGTgv3UGHoaaQ9tPlUK2kXu2zsUJS+2AVyd9Qdh/tHMS4nDJUwQvVCKZp5/O8jC3u47hzTS3D+uT07rIKqVEDo7ewhsXkh4W4sP0/x/h/Ip5sKsxgmfC5nDm5Cz5ZQ9aaSqEq2FxcVFU9ZdxKrO/omHtkPZWh7cQDHS8IDQ7W9pNlGQvx+JjnAUiJW6XjtMoE4YyCD1LuMBQ+h2ACrk7iFQDkjsX5yr2dciwikqopuJe3PRxCXFfg756d8lnaJyIRtAzAbybrDNJxSVF8RvB13Gx+r/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qfV4Y/1W20wJOCSjRGbf3SvAwTjPt0lXqLFymROQ3Q=;
 b=hjC9rYMyFGdyDDWPvjfGj0jMev55X48A2WuwOUlXcL/uVFRzpvUMkuubzS+6gTybYQSriK5ELEorNFyu36bRDbmOP3yPdBjkJy4AbFegqnEfMZsOOMyw7UN5Ns0z5W3IMkIdYPcpxOKME4zJ5GcyChdC69dxIBF6X52kKklUUrvLSXUUswTFvcCffYrGAV5wHnyiisibhOHAQFzGymB47ToEoAxuIEwlYTld+qOEMni6Onvs1jvYARyCSftXl8ubFPmOI4BXmBBeCIuIouhhFaC7T2vPTi5VkBoPlWWyI/QH7NoHeyjan4cfs5qp4/YdGbCL28441YL/mKF/EXmtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qfV4Y/1W20wJOCSjRGbf3SvAwTjPt0lXqLFymROQ3Q=;
 b=heIy57DegnsyK4zsJBH49D/ira5Z1ZKjtlpkqIt3+oHGLSqEeYH6D6HWZWTS543VuWAQ3LHSgszcoomjDiJ8kYdhrwNbpWsYGEEcvyyZsSiseEabL/d3qPSo9El4KVacNmKdeYICKkjBFSMy0r6kyk8UZb6FQr02iu9cNdlgFMBgse6ZmaOVn+OvlysFXW04fTNtgCSwFx3uTV06epWILSw732OpCsAfBVRmmwLm+vU/bUlZseX3vkz8XxHxt7+e9LYwVzH+MRbc3KtIo9OCkghBt70i6YkNrnr6tAUmVOb2RlO8afSVfkGYTHcoHxiI6dc6qilIXfzABcpaYhSu7Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9847.eurprd04.prod.outlook.com (2603:10a6:10:4d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 02:11:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 02:11:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Jaehoon Chung <jh80.chung@samsung.com>
Subject: RE: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
Thread-Topic: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA options
Thread-Index: AQHbZvJCTC/DvFt0EUmRStjKR4PGjbMXF4wg
Date: Wed, 15 Jan 2025 02:11:19 +0000
Message-ID: <PAXPR04MB8459AC7848B87D13DEF0DD4688192@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250115020737.230558-1-trini@konsulko.com>
In-Reply-To: <20250115020737.230558-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DUZPR04MB9847:EE_
x-ms-office365-filtering-correlation-id: 9f6c6d74-df99-4b38-02eb-08dd3509e688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t021ysk/plK6BAXgHB95NREsbbNH7mxqnfJKUrhlGA4g9GeN7RfUqh6YjLHR?=
 =?us-ascii?Q?pjidjN2QeKVv/HR2XJD5N1LANWFWmkqj5V0J/CwZ3sVAJb0WggRRVC8OEGd9?=
 =?us-ascii?Q?9lBu03p6kVVWo9GWeRxMgauR+ap5UnXMSM8RFJ6Lvc5p34Z5ZtQFXigsf+xA?=
 =?us-ascii?Q?yN1yunE/c/T1qPTrmoZoLUlffjXh5dO+fvRzWg1EbWT8OuLaUIHfXpAgdpHj?=
 =?us-ascii?Q?uG9Fuq/saWw3m6TvZp5/dElbAc0Ob7Fa1rHgMnoyKaP3kMzQRVhkbWuQJHiy?=
 =?us-ascii?Q?OOe8l+gkACyZqDF4WiSNUpqrHjNOFFCsGL3TUnxASi3IppjYCRZl2BP9+eMG?=
 =?us-ascii?Q?R2P7riXq5GVq661m+lrWlusRH14rdC/4IewmJwwWc1y9I4P0/ENuv1dbMaka?=
 =?us-ascii?Q?VeaMwu/SJ24YrDoqoIsfekHA7n7wCNNp8abAXOvN5TxRapkCEgWCMc6deRSJ?=
 =?us-ascii?Q?imKrB21LPh+tEIdGRRKA0ZX2GwNUuil3TX0rW368HjSoiR8XVznO0qeS7DdP?=
 =?us-ascii?Q?wwYI5MEh6BUTVk5F37VOSrUGYt/9aAac/QAFAAgptUfFwtoqtnvPisqCDAsO?=
 =?us-ascii?Q?9nBSEQvyrolMm9qZsM+N4ApAzsLnt3YsOYbRGZpC5Pm/j3XDs+z/erE5DKBk?=
 =?us-ascii?Q?s5d74iGG8FtwIn8TOoszRx7sVT8LjzA/dtAOcm9ZYOQu9J8s40OViIdeHFhK?=
 =?us-ascii?Q?ompTkhS15qqnTXOe2z1pD4Em4Z96uCwD5FmRo8hceW9B2oHrskc1KSyi3CiM?=
 =?us-ascii?Q?T+WIesCs+wpBdejLgEXJMhKsh1LEtrdh8ySotA5xKl+vij+E7mF6FAEREvUF?=
 =?us-ascii?Q?iRv2oxetwvVm5TFwoObBMhp4Kxd8AJ9jGRnRCYlSvEHHqo4XGM8ZNlv8RlKi?=
 =?us-ascii?Q?FDvkCoLX2L9RbWknWC6Mr45euhEXErA/Obpj0hLXLa4tN6CXpt68LZ7L97WA?=
 =?us-ascii?Q?gxpftv3Bcg8EJlb7weKdR7jTxPKF7/ooeSYb3TgNlH20YBTrWpT1hbSoBnrR?=
 =?us-ascii?Q?7R/bZ+HWqjJYbTazwX8YLcuXWN/Jn63InJUvvW2hk46DrCBqgjdeccuV+0w+?=
 =?us-ascii?Q?eMdG5U93j3gQCp4F0YMX03nGN1UZ+948Hq30E0PQWIkblIiBQCm2OpqMhAqK?=
 =?us-ascii?Q?a+NoxyWdB222LKbpUkT1yDFQEmZQ4toGo4nMdyr8vIg4J9eosJsPHcOOTYM7?=
 =?us-ascii?Q?sZahBQJMypW7C8CA8OgYEAdnAxa/lVHm1jPbVYhS7Hwf595T0fxFHgqlb+9P?=
 =?us-ascii?Q?1Zx26UV4SX9J4Dj3DwTP9v6/CmPlFyFzLPylXB+YZ4D1+D9X31N1cSNAnT0T?=
 =?us-ascii?Q?Kr9uJ254yPXrAUlw+hAAQ1YP10gjSQrqEMPBVMH/DBkpX5CKQf+fY6fOJsQ3?=
 =?us-ascii?Q?xs+Xc9EJFygp/ss07fnfgXnVL6JCU00jez3y13d1dFUG7Fz1SXrse97UdUXJ?=
 =?us-ascii?Q?4+wHWyFgmYopyg+zJYkVoO4MT9zh723s?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OwWVCkBFaVlbO13m4+xaUkxxnA1cZVAWZAhTHxQ+8Na9+Ayb9A0Co32kLjFN?=
 =?us-ascii?Q?gC56iFprYeWKq2smn/d3UuY4/CTxlc6fs5UUAj1YDvKVG0aBn1inV6p7sk05?=
 =?us-ascii?Q?O0rtEPcruf5eY60n6MSKEUvH4HWL/CHBZVItSOBiTvhPzxLUNJp8tCst3DgJ?=
 =?us-ascii?Q?QHx3gGphqIqbVoEM7mnrQ8rJA8Ztoy4SZiDvwfJk9A7uu7gJY/gJsBcAWf0M?=
 =?us-ascii?Q?dNA+SoPFz1I433JyLAf+MzX3vHhcqSQAfxNHlF5AR4G1R+XZzii72Z763eLi?=
 =?us-ascii?Q?sKxr3pceOHBube+oUfa7xDps9AXx7iAbOSM2AYAkR2RSVBIjdNHiwdmMwpYU?=
 =?us-ascii?Q?kTQIUeWpi2GD/ZGAw7fOS2nGPYdW+Vxd613MQQzU3V9wQ35BbpcXEbOAVaE9?=
 =?us-ascii?Q?QLBCm+L2k5zZr7jV4rjq2Sv2/3g5oLKmqpxuuLCXp5a89KojnFJFDP2mFQUt?=
 =?us-ascii?Q?vVFEeULb/4QXJ7vsSl0ICq9e+bp5w4FdMI3M89Emmc/E+ZNNi/nAlwKtgso+?=
 =?us-ascii?Q?lgidB04aB0aED1838x3xKDsloAAqSAM4FzHXSiSdHmtRDavfnjWE/8GsrXBw?=
 =?us-ascii?Q?52kpaHFkYEd8AY0exF2j69d/Agio0pyEKEdG9RLadsPgAdT4r5gIBVTZqZkM?=
 =?us-ascii?Q?V1TCQG/TTYWVOARBtCxa0ZqFI/q7Xo3298umIQxWJXEf433o1Fc9ZHTGMwcD?=
 =?us-ascii?Q?7isa9AqUAKWFRD1qjmc1uDmjAbm4VbMEy4xIK8Thp0SRnLEOd+PF9lG2WM1F?=
 =?us-ascii?Q?4yvqMqejmqgyAUQKgJKgvmrkMq6UrIbRwX8aFDUI0hcvT0Byv/dTejxzj+U8?=
 =?us-ascii?Q?KTEENfN5LlMi4iiLcS8tQfx0YEEmmNxMPMaYNgLYDcJLqVwgfWtb1iJ3GE69?=
 =?us-ascii?Q?aLrd+a2ZS8QmMktWxJk+rVWIUwTcSAQAWkDjSZrM1AHxmteW3nYxE6vVGoZD?=
 =?us-ascii?Q?F3EMROsya1jv6fSD83m6/AiAFFyZ4YgaqYFp1q+zxHspXOzeiyN1zvLOzWrq?=
 =?us-ascii?Q?8VoVf98Hlj6CrJFe9VCSi0p4m+JzG3r0XJEMfzV1BjLox0pB7ye1X5rcrZuq?=
 =?us-ascii?Q?nMx0Z+sUPhbJRkafe/Sx82GQBls+IrKtIydiga8YZuhOFPnvz6uXvUmJe5l0?=
 =?us-ascii?Q?JbFPM6tQIuAfq3Pxa6Qze4eIPr2LYGev0NNDcqaWRnPHimK2joj/5k9vhbgO?=
 =?us-ascii?Q?kOouiO7EKN8x/eYL7VLTbADTZ8r6U7VKLPb9p7fB9ceIxoaPPuFtk32ODvhk?=
 =?us-ascii?Q?/CiIZqIIHCqT1ylmuMEv/469YwOd/z2X0CTidwQX29LnvV/8A1gSGJ5Vb/P8?=
 =?us-ascii?Q?NPFxs+Cp74seLQC8x0FnBDXmI9cFcqDEWWElnjg1PlJu8s/iQOgDXVfuKMMZ?=
 =?us-ascii?Q?iDlg/j635Ny+gqE7cfHtiXowJlkklye7AzFz9ere85BQR+25rqyija3rcgbJ?=
 =?us-ascii?Q?GMEK1DSFtsIDFjLv2SaVrhbBOg2bgAjgx+PFMHPiDCPn2aK9BttxiGJdAxY+?=
 =?us-ascii?Q?reZIyyXLlvo0yKRfE7gZl1iqmrabP0Ie5RrSszz280+4A+hPjC5kzp9YwgXy?=
 =?us-ascii?Q?V+UaimItgDj6+/swd8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6c6d74-df99-4b38-02eb-08dd3509e688
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 02:11:19.4860 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 543Gow2NKtZEEG5I0yIz+KXrObwkxBpFlVUnueDZoHFBtLwJCjDj0ykOualyZ++F2hBDqCYEl4lv8BaWQ794Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9847
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

> Subject: [PATCH] mmc: Kconfig: Correct dependencies SDHCI ADMA
> options
>=20
> The option MMC_SDHCI_ADMA_FORCE_32BIT is only tested or used
> when MMC_SDHCI_ADMA or SPL_MMC_SDHCI_ADMA is enabled. And
> for MMC_SDHCI_ADMA_64BIT the same is true except we also require
> MMC_SDHCI_ADMA_FORCE_32BIT to be disabled.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
