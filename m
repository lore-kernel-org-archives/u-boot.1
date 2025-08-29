Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B6ACA0EED
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 04:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CAC83443;
	Fri, 29 Aug 2025 06:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iOslDlaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152588341A; Fri, 29 Aug 2025 06:52:52 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C06438341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 06:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrqXwnSGGkHUIktRVVJAl3efKTBUtvdRY0Yf1wTt2XYL0VkYWU41Ho3mkpVkB7ZF9gbE/lj6+D56+rXgtkQGi4HaTFOVH6vvfg77xbT5OqoYDKbr/z/u8QCX2VmMbpAFmqKvv/1VrVFtkuKs7wJWQ9Atak2vvzH7/YKXl6w5uglbgB/0gt1vR5gLyNmBwfhYeZGceTs+bGEg8FiIs1m417o9WAOiqstbUwCOnPtd9ilbSIeEs72V7+raIEYCjbxRl8Ah7tvDCBvGx5iWveWWqvnhY8eLiUSrvacQU81OIQoPhM5v7NsuB5FCqU/AbB5PHhzs588D+YPKk14SYL4w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vila+U9+TE1CeCryir1UDSFXp7DZbVkDdHQTTJ931VE=;
 b=RBJ3m+1nlEFjFzyfEEEXuVuy6v2qRouM1d3cFIxZKVsOiWWFPTJ7ltzLAij3liAbBKbOiLDgThNn/Z6XXBvMFH0hsg7qbgOZMCMe6A7vdfg8mjoPPjpCXEIFadSCM9BFvHPz2DbiqjLbbi0d+qMgIRdvm8sons8YfKzHV39tgD7/EX+l+8fLTo3VBQXC2drUde+zbci4qT8zOMCVYuCEnCHAq0qaBwDSaSXawjT5A7LGAXczM7VBn9feTLUeAxfHI70o2Jp1vsZ0nMtzhAsAVlcQlgGkECLAYWPXCjLlun8xJh97hbpJEC2T6gppEJ2OhLQ4Am9hHxwHEGHulVRdbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vila+U9+TE1CeCryir1UDSFXp7DZbVkDdHQTTJ931VE=;
 b=iOslDlaA2MOgku5/jpWpufxdXscP7z7kbanE2vHm62Bis9ZOhWf9Rlrpip4YE4VDGIl/S55vUaQMdnqar2Qb/eyr8uXAYvU23rw+l3GNZ/vLnXnU8BQRi4opdKvY4U/KKCJRebr6yEqHv5VqGTus2Yqsp8I0Sl8jN0+dpZ8+0SM7iBoWMhk9d8rCWuE2xIhLBYqOSDpgIlBpd1e6kiX6AdR0oRj2NgOkmDFOB/MFZx3ohGbqgCOh7umk2UDMVTUQYAKDDJTYFdcjzeyK1qQr99LDANnIWOXt4hAlq+uSgqOxLP4r8wiS+AjhaqdFKi/RaUog0x3eOlWdlgyiON0cGw==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.19; Fri, 29 Aug
 2025 04:52:47 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 04:52:47 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v2 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Thread-Topic: [PATCH v2 2/4] configs: Enable USB DWC3 host drivers for Agilex5
Thread-Index: AQHcF+RnD2z9YesDkEKepofjqSIJxbR5Eaog
Date: Fri, 29 Aug 2025 04:52:47 +0000
Message-ID: <CY1PR03MB812180A3F49EE49FE330C735A73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
 <20250828062418.17945-3-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250828062418.17945-3-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|DM6PR03MB5081:EE_
x-ms-office365-filtering-correlation-id: 3303b87f-e786-4cce-5252-08dde6b7e677
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?74QxF24ssLkprjHSzoxZYvoQtAA6gbiZ8ETCHvc7nFv+sdjCiPtaJk6DV0yi?=
 =?us-ascii?Q?2YUy+PL9KF3JDNw9PJTxiBjmxhVqQ4BY3DM3+zE+NogR5NGbr8ti6KXatB2r?=
 =?us-ascii?Q?dcjIh9bVghQVOeGh9+fIZ0Dt1JPpXVexnxjYsZottXpAVUomvb35hFhqKQGk?=
 =?us-ascii?Q?OQCwUKkhjTWa3DJa4YDfFZ9VC6DHfxeFfXFasODnj5n/lq1Xdl0reiAaoC+/?=
 =?us-ascii?Q?Z9tCdC39dUiebDTION1gypHpM8JS41Oi/H5++AgE0bEVD3T8Q0qGTfGYtmHJ?=
 =?us-ascii?Q?aMrS+25cv33H1cMgl30+mn3PQWEIMe+HTle860N7FiEq/sdJw8jub2P32tx3?=
 =?us-ascii?Q?fsdvfhS/XyAP3PaZypRfdfDiRf0Rt9CRti0nyRuQxkv8sEKlmcvSkZDcnfq0?=
 =?us-ascii?Q?CZJ6lK6EFCAO8XouScEUBqIeOvrvdbqV57phi3u4Llxoytdb6MyIe/tzelU5?=
 =?us-ascii?Q?EeCwFSGkrwxi2GK6v/pzB+oWQJwFdHM2ptHyZBhKy6bFrsOmRjbWbDlHHUyq?=
 =?us-ascii?Q?9dYpg5HsozIKInCvoK2UM7R47oVNpGZY5KwoKJIJLXKZpgPYfds3WOAdSKIq?=
 =?us-ascii?Q?RVfYMqn314mupJpiPDCmAv0cVqh7RMiCipOcZSqy8xdoC4aNEnbSAxyM6w0/?=
 =?us-ascii?Q?yqK+d6Nd6+r5lIBDchdj1nAq4RDbAEXUa9DaWHxIqJSV4NdkESkbyzxNaHqG?=
 =?us-ascii?Q?xGObGnX5O/1WDql2zU2vtJKBzFP8bJPbfy0v5AMoQhvizDnYirwRQ8kOyVDG?=
 =?us-ascii?Q?NbUmEkdEnqAJwd9NNGtCE1J6DiAu+hmdpSp7iySEU3XBLgkJQrfPlKgw7abH?=
 =?us-ascii?Q?02axG2v3gxvbViafIIlmRXK8Xn+rg1O4iYIO23jsFPaERX/MCtSYlo4Sigad?=
 =?us-ascii?Q?IZGKIdgmIGRhyCQFN5YyDH3b1CP7eLxR1/LZ196cj5n4Ti1C8uM2zTlRsXOD?=
 =?us-ascii?Q?dwZmA3uVgWFk5sCqjgNItOnUR2q5D0A4/BVWorcCyFc8nrbAaOkHLlgQpCEJ?=
 =?us-ascii?Q?etRuMP+oYKJ4KrXXcMDq9ql/LbNxd0VPU/81A5qN7FmbFpXJHvumHmzIW9Tn?=
 =?us-ascii?Q?8us/DxnF3Yd67o+dQPuawtbIRVFDZWUYR9qZwCHiSp90dLTyErcrS9SZPiaQ?=
 =?us-ascii?Q?6O7aSqWqIhirW9tN7Xcw8KhtdHlIqmRbbqbHda79mNIQz/uAivm2y3iFzzlW?=
 =?us-ascii?Q?aZeJdwK5WqEfrmBtiNCdn6LDqulPA4c5rTKNNQABFb1joT3Xs0i+oIXx6BOq?=
 =?us-ascii?Q?GiVF5HWrfFeo1SlQH+SffxwcnhKX7KoALTP2MpPoQ9zhgOUzKv3JVwTYj6qP?=
 =?us-ascii?Q?lB8N7kzGxOQ2TtxtTwjXlUxrdI5BO2zRJjVcovuLUCAtILwMy+7gmBzYq74o?=
 =?us-ascii?Q?CNHpA/JR/TwywHA8hSbT+IjRXux59y3BHvhaz4RU0MUy6YTaUwzS27Yy0VjT?=
 =?us-ascii?Q?2vPSDZuaYSkZDXOanGBpV6aEux4uLy6PewwoJIV0k1h/4YukdpZPpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8zzH1Q9CgWdEU4qrXvrFirLuNWhF9JlX3eblrUkAZNRCydStrtyEog19Ltd+?=
 =?us-ascii?Q?8qNOFWr3UEzknPAQznXnkr5QaquIUa4k0KNBCRnF0h7Y4DX3n8yex6pWdMYS?=
 =?us-ascii?Q?3qmO1v+tPU2Gq4YhWZTzqWMvljPLolwHkeWVYb/Z7djCpF1eJbCvnLKs7dER?=
 =?us-ascii?Q?ff6UGdj/1IIA8b9IaP9j1RXvRHZRlajSLPJXbTMgVK6srLO1G3qq3KubGeqH?=
 =?us-ascii?Q?PboJCSxyLjdu8GUTSTkvpTBBljMFg3DsNoLTXFTgSlx7+TTJp4G7ERLuKjWM?=
 =?us-ascii?Q?Ims9gVhIs048WJkA2Wc+P7fH44VpJZDNaY6lmrDX7G1z7DbETg6caGNNje6g?=
 =?us-ascii?Q?bScvaSZKd+GY4J3LsnmQTGwcQc34z5iA9gQjmX9jNHTiP/tf33KkPC3a4mYg?=
 =?us-ascii?Q?MWUo1Klu+vGmh8Dth55WxBAgcbu6wdnlJyjiDFAm4+qEyby88N5Hpo3OC3zr?=
 =?us-ascii?Q?HVf+75xM1Vy0zktT/cb+R3HmWJWkFGNAGsaWcswuEXJ2PTVC3j1HTi0itwi/?=
 =?us-ascii?Q?wCucsJ4ZJV5e61sQbdgw9Ivma2fiUyIU9fmtiRwzdh5BEG/STEk75m+Pd8n4?=
 =?us-ascii?Q?mVgCwYjhDU4obsLEu0tnYSzab08cCqLz1nUfEJe7DyYyDdYVEfvlDaJK/roa?=
 =?us-ascii?Q?zyRmM1JffTUF7yV5dAodZdgrfc/eZqD+3zoSA81/ruJja5wJCldXeLDtdeqB?=
 =?us-ascii?Q?QDomXOJpx3PFh5FMR2COPiZSsMf8NRjhxkjqnrLw8c1cfxxiSlYY6ALozqry?=
 =?us-ascii?Q?FizrUAy9JT/Uj+7PbycyG183P4lTaN/R2ozeGtViSc2BRJVG9//EVMakU/AN?=
 =?us-ascii?Q?pAc401YZ6dBBAc3q9ZqVKzXInBcqW8h5WdZ0lDb104gkPRloyKuC3VizBXAb?=
 =?us-ascii?Q?ZbOrLTtM9ooOCzmFJP7pKl0SKkUtWs0CoAtbLIGF6+RP90CvwbECPcWW/Kem?=
 =?us-ascii?Q?lxlh/ajtymfMjYO5adERdoXLhJ0L7pi9bg6tBO135stnhqETAaRURxQeoboA?=
 =?us-ascii?Q?e6EVaWDB65VMmgtWCZwyAi3UVVokwpt2Nsg0p6TF7etO2xapyA0ueu83QH98?=
 =?us-ascii?Q?HFxkOVI04XeJdrWD0eGODPf7g5f/CFIDclN4hs6WWR1VmGO1BE9DNTHK9BHN?=
 =?us-ascii?Q?fR2ivxp7seOwHi4DwxEAEquBLk6P2fkG17/Rp3z2SNcg/8ivYudH45ky6fsb?=
 =?us-ascii?Q?e+a3fav9cnUo+7SrCnxZjOYIM1GUDW/at9WjNFgB2IU/yDvmjeCmLvXGijDT?=
 =?us-ascii?Q?kollj9QEpmBXu6JFBWD78alXmnHcNroLSPR+SL/bDAwOsCQ9G/GuCLAdfzA0?=
 =?us-ascii?Q?C3HBXlD6WCZ48N8e3UJT8gqDA0xXQQbYXVtOGr6ARgfHyMWLxMnIN8FZf+Fe?=
 =?us-ascii?Q?fuOOhq/+p1Z84yWbxBbIRRyQwjCUUiaACOd9GXzil5Gbg/PpR8lXjkeJRRDo?=
 =?us-ascii?Q?eO0P+rNqSxmyPL+JcDvdZigLNxNU24hU1tH+e2DbqfyS9IAHziWrB8LcxsOV?=
 =?us-ascii?Q?R35ExHHHVY9BzmScgQqa1FS3hepWCFnvoiLFdHnb79nsKN/0Ss37bKoa4WKJ?=
 =?us-ascii?Q?RhYTxXCdi5AnqIdFBa37jkIqWuAriGhRfoYmjPKm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3303b87f-e786-4cce-5252-08dde6b7e677
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 04:52:47.5962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TukCq1Hrk3RtrZkuDw1wXPKdkNhRsBzqhRiTNiaRozanIT7MARUe9Ly/b51XrTPJfUAl66rjFkFkfJqyziDE/2DP4beQ2YeU2Sd0sfrtxRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Thursday, August 28, 2025 2:24 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v2 2/4] configs: Enable USB DWC3 host drivers for Agilex5
>=20
> Required USB DWC3 host driver configurations are enabled for Agilex5.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_agilex5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index cc812c7008c..859750f02e7 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -98,7 +98,9 @@ CONFIG_TIMER=3Dy
>  CONFIG_DESIGNWARE_APB_TIMER=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
> +CONFIG_USB_XHCI_DWC3=3Dy
>  CONFIG_USB_DWC2=3Dy
> +CONFIG_USB_DWC3=3Dy
>  CONFIG_DESIGNWARE_WATCHDOG=3Dy
>  CONFIG_WDT=3Dy
>  # CONFIG_SPL_USE_TINY_PRINTF is not set
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
