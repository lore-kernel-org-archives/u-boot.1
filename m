Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5369E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 10:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 055A88031D;
	Wed,  1 Jan 2025 11:50:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gCFW7ne7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133EC80379; Wed,  1 Jan 2025 11:50:14 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 585E88021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 11:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SU/S3KvZMLDAspt+gkPPNUZWbSfRyIPfIRcV38asCKQ6seThJ6XVmuWnHOHT6kkfMY7sA6I2Mzd4woAQA/ERs1LkIHvM5O/afgC2eY0fIhCw40lg8vd32/t0eHCMafMAsnegBqjAfjZ9ZxZMnnNgkc7D9ZUND/vCdes0wJ5fT9n1wBUePe06jhaOMDrxxrrm4cftuTlIwnYgOIydoE5AdwcdUCM05509h6tUdyT0jBQbFP9ClITzXG1WyPMQgl3tad1wsECL1HwXfGvL1Dq8dTy8w4bxfBp06FdktLmT5ENCKNQsKGACeuABuZmlXsZTD3GioSsTKwVMe9rrnehQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ8YkBzmkJ/GEsNlLxJz1eeAQA2xMjUIvFGC2pMXoS0=;
 b=M0eL555WXfQi1Eu1KzeKpxMsTwHAjJsI/WpBOgwaTIxBLDPV63xVS6lz3EvqyJQAU8wzVlh3tlPADEoOkVLvE/MHYVxMEmET5PKk315VTsMEv3lg0ij8+rAyGNY5rEqi8CEv5gwk2qlEc1XFfDzl1b82A1sNI1Kna7SBBaEn4zaVqYwbb7G1OZ7lYh4oeUw2SIRYTktX5TZS4xIlcFqsUrzOEi+8lgfY1BMUY6qp5tV7UG0KWEY4pNn5Nw8zfKUdfrsqfbVr8DGBmYNQLXWKP2C3ck2QRsnW2bO/d9Sd1dcAqk3SJVxX6B6ioQDTSg7mDfkYrKiDUWn7AEle/xkDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ8YkBzmkJ/GEsNlLxJz1eeAQA2xMjUIvFGC2pMXoS0=;
 b=gCFW7ne7fEl2O+vDOxsigHlpihGUQXjRTnT+ImUJvWd9SCIDCeGJXAvrySeytZPU9WNVoDIxkE1uYAiIqywTmcFrfpo5xfZs7ecuRqVs/UW3nCKCNbN/UY6Yc+xArtC9CfPC+qj+dNHAOC/f9pKgoY2mEG2pJEom7u15/BBZZ4g=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Wed, 1 Jan
 2025 10:50:02 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.8293.000; Wed, 1 Jan 2025
 10:50:02 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: New Defects reported by Coverity Scan for Das U-Boot
Thread-Topic: New Defects reported by Coverity Scan for Das U-Boot
Thread-Index: AQHbW4ugkEFTGXLE0ES1G0QUDOfqNbMBvSPg
Date: Wed, 1 Jan 2025 10:50:02 +0000
Message-ID: <SA1PR12MB8697ABC7BD292E5C69D0491E980B2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241231135509.GI3476@bill-the-cat>
In-Reply-To: <20241231135509.GI3476@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CYYPR12MB8750:EE_
x-ms-office365-filtering-correlation-id: 91d346e8-357f-41c3-9e5b-08dd2a520b9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wOltvRbd7gZRFXX5kt5UkB4PPlgvTJmXvfg7xEKVh3M2S0GsAGRLmjdqCfWv?=
 =?us-ascii?Q?2rRihsgl7+09BsZBJWjKowp1+HJAHP73XcTj4+yM0a7sN9lT2vdmTtC5kOfW?=
 =?us-ascii?Q?H0O20XHAdyj/KWmddy/4oBwEqlulhSTydYWbR0sdUs2fugSZrDn187RtyhZg?=
 =?us-ascii?Q?Ptwq8wNxDqJGrAd4pGROTHaMQ8DL+fgLmZAV4ybLfxxGTOeugyggjrBXE2Fm?=
 =?us-ascii?Q?oT6wqLlILOBaeYAvrmoeVZJl+KzVjJnw77W3/5ZACxyloikKBRpqZAmMcgFr?=
 =?us-ascii?Q?y4tvNjUprcPp20NtsQ8kYLgcqtaxUO9v9KHzCMZyc+qAMHd2oWDn5+fazA2O?=
 =?us-ascii?Q?b3kWFNJqEWz7NRQibYl7JWH2Jqd34DVazWuKrABvS35PDRpQhULMamvuHCtk?=
 =?us-ascii?Q?8NIb6rjb8MZr7twqu8TOXYTwzE28mbIquWnOC2ptSrgbtUf+f9XZtYANRx/n?=
 =?us-ascii?Q?45HMMWyxyAt6hs15dnc7zXII4Ju6Q6qa8m8h7E/KdEqYS0RCrD3fVZzKQeqr?=
 =?us-ascii?Q?5D0jBMzIji7aOKkPKZYJDKB/R8sHG9kVNDwaKzTftacH5sPHYNDo2r0H+U/v?=
 =?us-ascii?Q?nA7z6lP61Px0T0MJs87YSvw3Wf3t7m7gHq9X1jC9LX48YfOFdmUH9V891u7+?=
 =?us-ascii?Q?NFvj+yE/GsurwCjxvrW5MDU0j40FwhXkjL4WxLiXVw+dJi5M3g3CFHKiIl4j?=
 =?us-ascii?Q?WWQbi+k3AOIa6R85T33JCpSrzK8m0u8wx5WtNLzfJ3Gi1td0SSb3eR0oaVMn?=
 =?us-ascii?Q?e5WSQ3XF8wmkFeNbEMf4t48VKFLWJw+yXPOMFSCz+ecpvmlJlFnDAOP93BDi?=
 =?us-ascii?Q?ToZ9EzoCFThZuF+5GEEiOggJmnCiRgKqfSN+slmizXyXQBg5+CE7yqj8xhox?=
 =?us-ascii?Q?m3n9Jk7+XiHgPHDGKBuM0lb2mnNclpsZREZqZSeG4FEoSJ2m+rmZPrKWo1Gr?=
 =?us-ascii?Q?lYlc0R4tqGwR9ydI6eZlKqAAYZseOR/HD89LpFMJtbofgtaot3hGG9lVZnSr?=
 =?us-ascii?Q?1L1Qa9NQ6IbV4Muf/0ExjNP3uUiUVQY//K9XRREFOgbmeWETwCBd03sXHzZ0?=
 =?us-ascii?Q?7xEgM9bjogSEg85kDXbKl8D/zpmJCBdFlfusil/6/3GL78wXdMabQ1x7S1s2?=
 =?us-ascii?Q?QTfzf6zTOsyTyC+ryXhWL9rx1dV5Dpbm2aDZ0uiY466krbNpAFcS0LS9gkMB?=
 =?us-ascii?Q?dd4muFx6had3Bv/mzhZY51kfyczLwfQ1JVjE7lJCMvKi+sT06wMUcqV2auKc?=
 =?us-ascii?Q?GXYFcTcYejies44FbN8D1vuuyqUaCzUrwsm1A+lyysL5fbcDkoGZxOgjHTLG?=
 =?us-ascii?Q?wjjuTyABKkzsvj/+Zmwmzrh2YSAfSNkCsei3gwSFkBBIALkQltRXzvszn/3j?=
 =?us-ascii?Q?5So7l3h/IVoQ15BSdHzR8OqoIw6MlhQiucm3Onegh3RSiwcA0qRuU+gXPx9/?=
 =?us-ascii?Q?uVhmWq5bSd+zfwa3EAEy1sns9MUDzCAV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KAvM3O4e5cATA/Ghk7HDVIIRPg1YN3qucbYkl8F4ryk+CuF3iPgBf2yg7aPf?=
 =?us-ascii?Q?3UhncAEF9WPtgLGjrfpPQHKANtFOZ6wDuWaGG8PsiExSXRzEVii4qPwSpDOv?=
 =?us-ascii?Q?1AjaHBMv+Iq54r2VqKEuN/c9WpksXNyF4QBYG+ADUik0tAtjddyW/PvDeUlV?=
 =?us-ascii?Q?tvIs3aeSpN6HSAbv2INr6iwQvha/MYbEeDkDRmgWsiAIeex44jlNHOeKIouf?=
 =?us-ascii?Q?3Vur06rVULTK81NmOADY0xv/5r3TlAPGBmJtqKisT9RqwCiPvyDTAplnesUX?=
 =?us-ascii?Q?6PLVcFELLQvqkwDCxIQzR7QeJ8Vf/Thg7nS/uClVrMpFueMztdiGVRsE/sLz?=
 =?us-ascii?Q?BtEeWzGJHXHYcaayByH9uIIgdcI69/c5VLPJ+brpw3lLUfwL30vM4nxdfyv0?=
 =?us-ascii?Q?AVAyfsYbk8WSOHlRiFHPlG5Hj8FfEjmxdlJULlmIk5n/NT7sbRIPgWbSt3Ez?=
 =?us-ascii?Q?c9R0MJ+8/d6ZO8eJ6QTS/pGleSvgok/S62/wFSYoq+issLD0XovaQM84JHO5?=
 =?us-ascii?Q?uNWtaEGKiY6bgK6pumPyagl3c2IoHERaoB1oT32ICTo4rTTmizaeyrWlIjzP?=
 =?us-ascii?Q?0nVxq9LC35+WYj+nstM/wbewvgC5KcM/NVBIOzlPJgqGdt5RekQ7SvSKf8kR?=
 =?us-ascii?Q?Bdgh+kEAQmNTylGeisNCBI3zxzqlEANgR3aBeb+ddB9sfNqUgto2TLNckPDv?=
 =?us-ascii?Q?DAap07DGsKSj7SJzdLQv+2TvDX+hZtfePBJP+N7szR60E68lBhJ/a4lzqR6e?=
 =?us-ascii?Q?KZ2h194ifyxG3G8g7XAG0F61B66kPSQ/oXnk+t1B60cMvyKanXbVn7KEpaB2?=
 =?us-ascii?Q?BSWZAHhSBkbbaWDmUWseVBZjTQP7eWpMqd2l2DUh9K8URZI1wNrR2ec/51MR?=
 =?us-ascii?Q?jBxpcMKy9424tzxIPqTwOqY+BUVTztQUmespMiFEvIfL0IxecZ4tXDzWJAVj?=
 =?us-ascii?Q?GQUTMKMAzN+e/fttoAVX4KVmhA//9otevr4l+yf2ZCt2XaBe1/dkGFigWrUc?=
 =?us-ascii?Q?IJEYdNeDNuuEubdTErISj3hAXmWfUJ1P/Lhp1yqPyQ0gvdgiUXMD0GQSqFfc?=
 =?us-ascii?Q?NOBzRCeOi1MOQfy7iTYIzM8Msr2olpC5aXZ61a9LbyF/xQpGEd2AKQ/Bw6XW?=
 =?us-ascii?Q?88/BgZQweg8oPHc5rz9MY1rg8IqC3KNJ7pGghnDfHNAFJ9WMfdl7NRuezPOx?=
 =?us-ascii?Q?Y7jGefwlFolVe41VpTR9Ye8/Sdm0YGT+D43HN5kVWyYMbl9R3pkIvXghmfKm?=
 =?us-ascii?Q?ZHGE53pHRp03mscL/0+IqgswLxYQgfZAcr7/DDaSK0yfp1yieeC/dYGfdns2?=
 =?us-ascii?Q?WW4syjHDivcaZK+WV7lK37OHbFcuaUpxNfg+68OQnvAuXpJMpuu4h8LTVzMU?=
 =?us-ascii?Q?w8Jv/kKrJDszHERRFjaFxxA7GG4ZRO9mrnwVK2Wqs/ZhFUz7AGGdbCnwBSJn?=
 =?us-ascii?Q?QMXWe+f23GCk7RH26/WfkyZjwTIcqU7ZHf5sbEU9uiNFXCekYe/A5tHgi5Kc?=
 =?us-ascii?Q?EEQD6kF77gPTfiBV35WxhtQO4F3UIvo+SjxUQx7gLfOUi7CGmVwqcXbdUMr2?=
 =?us-ascii?Q?XqnQ4EKBSCN2vC9NaIg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d346e8-357f-41c3-9e5b-08dd2a520b9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2025 10:50:02.6273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOz8LzgptKmR83tZIR90h2HC1E5lXxcxr4rcNyxh0p3tZKv0b7tYjn5hv+4p9IyHxG1EyR8WJiNatefMB32jpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8750
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

Hi Tom,
These defects won't appear when SPI_STACKED_PARALLEL config is enabled. We =
can mark these as false positives.

Thanks
Venkatesh
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Tuesday, December 31, 2024 7:25 PM
> To: u-boot@lists.denx.de; Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com=
>
> Subject: Fwd: New Defects reported by Coverity Scan for Das U-Boot
>=20
> Hey all, here's the latest report.
>=20
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Dec 30, 2024, 10:44 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>=20
>=20
> Hi,
>=20
> Please find the latest report on new defect(s) introduced to Das U-Boot f=
ound with
> Coverity Scan.
>=20
> 2 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> 1 defect(s), reported by Coverity Scan earlier, were marked fixed in the =
recent build
> analyzed by Coverity Scan.
>=20
> New defect(s) Reported-by: Coverity Scan Showing 2 of 2 defect(s)
>=20
>=20
> ** CID 528528:  Control flow issues  (DEADCODE)
> /drivers/mtd/spi/spi-nor-core.c: 1644 in spi_nor_read()
>=20
>=20
> ___________________________________________________________________
> _____________________________________
> *** CID 528528:  Control flow issues  (DEADCODE)
> /drivers/mtd/spi/spi-nor-core.c: 1644 in spi_nor_read()
> 1638                            read_len =3D len;
> 1639                    else
> 1640                            read_len =3D rem_bank_len;
> 1641     #endif
> 1642
> 1643                    if (read_len =3D=3D 0)
> >>>     CID 528528:  Control flow issues  (DEADCODE)
> >>>     Execution cannot reach this statement: "return -5;".
> 1644                            return -EIO;
> 1645
> 1646                    ret =3D nor->read(nor, offset, read_len, buf);
> 1647                    if (ret =3D=3D 0) {
> 1648                            /* We shouldn't see 0-length reads */
> 1649                            ret =3D -EIO;
>=20
> ** CID 528527:  Code maintainability issues  (UNUSED_VALUE)
> /drivers/mtd/spi/spi-nor-core.c: 1613 in spi_nor_read()
>=20
>=20
> ___________________________________________________________________
> _____________________________________
> *** CID 528527:  Code maintainability issues  (UNUSED_VALUE)
> /drivers/mtd/spi/spi-nor-core.c: 1613 in spi_nor_read()
> 1607                            }
> 1608                            rem_bank_len =3D SZ_16M * (bank + 1);
> 1609                            if
> (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> 1610                                    if (nor->flags &
> SNOR_F_HAS_PARALLEL)
> 1611                                            rem_bank_len *=3D 2;
> 1612                            }
> >>>     CID 528527:  Code maintainability issues  (UNUSED_VALUE)
> >>>     Assigning value from "rem_bank_len - from" to "rem_bank_len"
> >>> here,
> but that stored value is overwritten before it can be used.
> 1613                            rem_bank_len -=3D from;
> 1614                    }
> 1615
> 1616                    if (CONFIG_IS_ENABLED(SPI_STACKED_PARALLEL)) {
> 1617                            if (nor->flags & SNOR_F_HAS_STACKED) {
> 1618                                    stack_shift =3D 1;
>=20
>=20
> ----- End forwarded message -----
>=20
> --
> Tom
