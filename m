Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96C4C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58E238304A;
	Mon, 14 Jul 2025 15:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="FFglPhZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D06382FE1; Mon, 14 Jul 2025 14:54:03 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C5382B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=anthony.pighin@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ri+YrJZnbIOxq4fk8sUKmDZrmoyb/e0B2amUZgYv0y19l9yFx0OE4JteiDsLEGdFIoUAQWILThZe+EIbZL2wsDW2W81tFvvSvBSPIu/ZDFnOCypT0/IURi50sRtI1tSE8a71WT6ZTHAUUyJ3slyOHMF59NEYHWqbOqq2nNw2dZKNuHhxxGCiOBegV8R3R0w0LzaVy4Ypev7Qat4HYU+A05cs7CoDafLNUFMBZfg5tKAtW918m869OBcBa0IWTohP/QlUi91QL4UeD4pGn8llwzRjyK1ld3/N9KPULy8lJEj2yD/W1DnQuzitmWwF7eLs3bQDWiVe/6JWcIGZd/w10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz/jDOc0J6WwugGS0ML620p7Vn1GF21ThRQlHIERJ1U=;
 b=fnyyMNJIKXm+q1hes/DUXklX3dwni1og1A+QrL389mC+bsSVKyHOtS50oJdwJwQkyV9B4dDT9uqvHXtZPIL6rkfj/E+RoWrLcBPXElnMHgdWTcJIJDpBXbijQMdDRMiIw/DWJZEbFSe+AjP8AewxjcDf7tvZ7/Q3G9WmfQ+uuZ19+EHK+ZLqQYJaxEUlmKM2ajbjztoZaBa/dNRXFZy3Fh9rPilywMpKqvanlbgw7u8mG/gHOAOqqGMcczZbuXcFXnc4dx1IdqoYXmPLCS32h8xyOWOnbta7qVoRL2dGrOO/iX910LXfHvvzWiiwjzvF9gmH9tO/RMVZ0GmWCwO5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz/jDOc0J6WwugGS0ML620p7Vn1GF21ThRQlHIERJ1U=;
 b=FFglPhZYNzrxv3/VFUG2QredHqftwUEtImB1dF7Eoc4ars2sln5o1vUD3ymfoesK1yXGFqLAX/quqmfYPdZ3XZiSBCyMU5tpcae9T1lJ4e6eqgorb9kCOqZvJHuFXmoJsLMDiJxWpmSo3gA1Inzao0sGKFUVyX1dIhaVh0IQC6BBqtsD0nZPoRr/zw0OrE+j9xk19hC74OsMIGRFVssPoQwdyCkWH7AGToBTwpYxEHRqXOwVLIS3kRc/zuXeDfnEkhBFL9SVFfrt4blqijxs6ps/y3zpyJgycGfE5Y+oQoXPcK1H4sY6+7ZqgF8ez0tjN/MT72aT11OJcshAwPLBxg==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DS7PR08MB6847.namprd08.prod.outlook.com (2603:10b6:5:3a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 12:53:46 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 12:53:46 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "gaurav.jain@nxp.com"
 <gaurav.jain@nxp.com>
Subject: RE: u-boot corruption from EFI CAAM RNG request
Thread-Topic: u-boot corruption from EFI CAAM RNG request
Thread-Index: AdvwbwjgPSuIydQbTdSM+RLk38cMCAETwn3w
Date: Mon, 14 Jul 2025 12:53:46 +0000
Message-ID: <BN0PR08MB69511CACF429DE68924BCB348354A@BN0PR08MB6951.namprd08.prod.outlook.com>
References: <BN0PR08MB6951B4921AD52EDFA06E885D8349A@BN0PR08MB6951.namprd08.prod.outlook.com>
In-Reply-To: <BN0PR08MB6951B4921AD52EDFA06E885D8349A@BN0PR08MB6951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|DS7PR08MB6847:EE_
x-ms-office365-filtering-correlation-id: e0442167-0089-40e2-55e3-08ddc2d57899
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?P7AqLdxFAQKRLlxZUsTy3TSLUPsOuuTDYpwxlwGSaz0qg/o1T4ALmgaiYlLd?=
 =?us-ascii?Q?MOVJb0KqrPTrk1GkPofwmZmUwbMsold4hdJTq8TBqaFBdOjUv0o531KcKT7Y?=
 =?us-ascii?Q?VTMTpdG23ljkvgThhTEfc12AQRaIrKrI8vTdavfG70pN9N23cesRTUQ0L4kF?=
 =?us-ascii?Q?LsQoiZhOhtSPfrn8pbE841NNhKiouGE1PtT/UtHd2wqGo+95yfES+h+uJ5w+?=
 =?us-ascii?Q?XWCZ+WPHRZQ4+6wNRE7KL0fdMBSfJ48K/PoJxXzdH14T1Vvfrxh1mmF4+SwL?=
 =?us-ascii?Q?C9uMAMI3aqGiLyti6FlHrwK00ikeHKlrZkFcRzsl4AebaCBZEo6t6aVXnyI2?=
 =?us-ascii?Q?SDf25KLDcPxzN4qsv1iRsN2k4XYOkA5jhuOdNr3XufeHVCc9LQtLtlN0D9Ju?=
 =?us-ascii?Q?Mmc/BGk5fkuiFjT1g42bPa5BMPOnsoVzmT67xk+y/HFjzl17SPkAQhTJhrZl?=
 =?us-ascii?Q?1sJkPLOu+1YuvZ/VpXHi8kVMbfa6jsrMBLtn/C3n4Xw5w/XEmZiEkTziGXCw?=
 =?us-ascii?Q?LTmVEILZ+H47SU/lsMfaNFyx92lkb6s082OJmgrr8HcWJrm1A0CVEsGhj2vv?=
 =?us-ascii?Q?1+KuxMof160gGOkFpJiKRTslIlSteku2HFNoS/KXzwoMrd1XBcl3G4bNgJux?=
 =?us-ascii?Q?Am6gytiE7MEQIbWPNoQByW7uL9JS/JHjq6js9uRlA90GBcJBvh1zTTs8EPew?=
 =?us-ascii?Q?ksdhnR0hQjupVvalIxNUFN23N8DdVU4F3glP7P4/RdwlLG0G1gS4BJRqbDHN?=
 =?us-ascii?Q?Dw05Xd+4yB6xbkrKPqsfZbeaza8iK9PKodX3XRPHP1uJBJPByHZzVR8JlRHx?=
 =?us-ascii?Q?bDjNMr6k68ujQPJjg3s7JtZx/MCg7+ORvUSH0clxwHGYqUMi+5MaA100hW0u?=
 =?us-ascii?Q?iUH3wmepqGGuhYw1dmpvB5jg7GrKQ96J7Xqhap+fdEI/G5Q7/tcfeww30h7o?=
 =?us-ascii?Q?HQpZ9BBugoAHI2ROPD3s8125FM0KArvGoMLam5MmW+F1+8rJmZ9GMuc9JjxR?=
 =?us-ascii?Q?RrFju4bcc2cHkDVwMIsvFFVutBTgKFI7uMr8HIEBheXnLrnUca6X8octvFHq?=
 =?us-ascii?Q?1Jb1CACFP8I8q8kLTELNJq1OSIM9CbO4FrBYaY27Irk19wc0VE0AXtBtxmIl?=
 =?us-ascii?Q?s5xab7wIMcHCh+Ua+ffgOEkCmdl0yUrpRDkIfMc0FnhLAHBqEs0KcNS4mZ4h?=
 =?us-ascii?Q?9XnfiO0pNrQT39FiEa97sqLn6+5DF+i/MHuTMkfH596+0z8vLQgTjNNpZ9wg?=
 =?us-ascii?Q?VHLcGNlUWa4vU2JPgChAUb7rsqt49UnT4VyNLz/zroBFMHt7agy8wxo2TO1Y?=
 =?us-ascii?Q?5pYAGqBdVCXbgkfHgByZb3bQXgHe1KvhYgARm/71OxihNlhrd0mKqsWttEBG?=
 =?us-ascii?Q?Gaq7oSxaM1wZ6bLjK8TrAZXvwlf/AsLylIcNXNDLelyPCU6dxd0vNTGFeQMw?=
 =?us-ascii?Q?7GaoqaSojwK7wRTAfQySYv4QvHSfVxPiNpN9vFOliIzGUmSAYdc59A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PmgzutjANqQFhfHvk61fWphyJv2OYYQPEsZZoPWlaFHdQCoHIQaczqrRyAHl?=
 =?us-ascii?Q?wHr+90Qhrg7qqAWHUGNaspI6mUMs1dhCD3o8OUf5GZe3o2CjtXBL4hAoRJPj?=
 =?us-ascii?Q?CyOMdcaBLtb1JFichy8lL0vqbkkXCUFKRpW2/vVD/B2wS+L3/kjlX2CatEVh?=
 =?us-ascii?Q?4TZu2tlz6aBf8FeXnSa7fI37jouEX1b8JMJ1Q4eSTX4Zj9W2YVkdy2FEHLQM?=
 =?us-ascii?Q?4rTMnPkKWLeCL7MvKR1cnXYQCjyKq7Z8XQqDvcHUOiGQ7CxLmJY2semP4wU7?=
 =?us-ascii?Q?s2MjsTL+nVKeSp1TBtWCUB1sdUie4V7RmC6cK3XYiEqrm7jvZzcsv9+/db0q?=
 =?us-ascii?Q?ak5vUcpxM0ZUrRTlU0DuGux9lx67y0SYJb8dRqmNbUycSLtQorwOI87HenSf?=
 =?us-ascii?Q?xlZb+DWBkX7eDzdoJSMU7URwJD62naNfoi6B0NgYdvahjwbRAetKW0KAggtF?=
 =?us-ascii?Q?WzwuQNkGhtPiWhc1B9qV8gZWTZ4QTdBekyjSkD8sME8XmCv8hqCg8vNqDZwe?=
 =?us-ascii?Q?AcfyF/RXFp61RvXa+ZxwlnnXiFwPtAS8NkzuUTE+xh0Hv/TjymhPr8ChpqA/?=
 =?us-ascii?Q?WVc8jXWRhhmIx+DFxC1VBFmsvAK0R+n11Jt4zOCxrDD57/5yy3ggwYxa/x4q?=
 =?us-ascii?Q?7/n7FuK3qCjQINA65f94rTjtgy1Ftfeyc+oikTbieK5z7ZhqYdO0yW0y7LWn?=
 =?us-ascii?Q?ivPMI4sbW1LNWN+WPnhu9Lgsad5vjWkQzQZlP1AoatknlBlG4fnqJlmrU73n?=
 =?us-ascii?Q?nO6ljWYmAjNejQS1yioEv9myI+i7gz6uO4SrEnBf6jRbY7zyylQc4rKsCIFt?=
 =?us-ascii?Q?A8dAtdCeQxJD+0OCXStJPP2zv/4BB0XmhgYQvUNA9A5OMWgW6O4UUoZSwZYT?=
 =?us-ascii?Q?yPtaby8Xn2MMLNg2gnS5C5Uy7vBdpEtBiYDOZzTYOSXRbT2OVjL5uSlpPSUU?=
 =?us-ascii?Q?wzSis3vRqiBU+Mbfp38dgdOwSYS1igza5iEPMyKum78b9+XjnNP0yJTKBwCL?=
 =?us-ascii?Q?K2DN4zQlfrxEMPnX9U7nQj0G+CF6AXI5buk2anG91aNLNy9TS6LLdDW/0dWi?=
 =?us-ascii?Q?6BcJEXRynqcHkmyZChbuo4JEZRqqhu7cAENiMK+Xf7vFQ5Po5DOTdVz+5L16?=
 =?us-ascii?Q?kAR1apiCHfQH8NwNCgV0VCeg5dNqoac/c3F1CLTynnwc/gDsfrq/czpuXNEM?=
 =?us-ascii?Q?L2O2HS/B1fVfNIvjnkZ52vLwXtwhbAb1wa5/mfimjkG7IOu8Kadxj4DSa+jT?=
 =?us-ascii?Q?ZUqEMGOs93kx952MPJJOoZZIgO1DJqWjb8bItXkEFmaJk0RCryrHL/oBRWNI?=
 =?us-ascii?Q?8RrJQ3pTFvE1lrAp2I8y9DeOwWxxJB29sxfj1A5VQrDzSNn6RS3Tqc/pUwxt?=
 =?us-ascii?Q?TGB4Va9JrFbnVDc5BvOqmPgbyecrPQ2SCi4P+qTRm21zw50UjNqv6XVsxnFP?=
 =?us-ascii?Q?iYvRqundPQei4JVxoa4yekj2zs84eOz99GPTKbHNtmzc+cpmpwKBKeKYe26m?=
 =?us-ascii?Q?LJZtaxjzpdiLIuO2lPxQ15xKRIjNXE9Jfs4mh9oY3uoxyB1iFE25mTFM7/JI?=
 =?us-ascii?Q?Poimo41iA9PwnnX6KY88TJbg6wpbwRcjfeTPJyfp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0442167-0089-40e2-55e3-08ddc2d57899
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 12:53:46.3216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SlnIKProOIGACKxFuQ0GU9DseVutOa+pdC2cAzArUpqr3LBWDSC2p5NWbOcm+KdihdzQbLr15L/4ztTLiiQ0z8EP/RoF+ri1Ur1VbqfKsRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR08MB6847
X-Mailman-Approved-At: Mon, 14 Jul 2025 15:04:16 +0200
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

> u-boot is being corrupted following a Linux EFI callback to get_rng(). On=
e of
> the many footprints is a corruption of the EFI protocols linked list.
>=20
> Turns out that a request for >16 bytes of random data is broken into smal=
ler
> requests.
> Those requests are fed in a loop to the CAAM RNG, which uses a job queue
> ring for interaction.
>=20
> The problem is that in u-boot, the job queue descriptor is created only a=
t
> probe time, but then u-boot needs to endian swap the descriptor fed to th=
e
> CAAM RNG. So this corrupts the descriptor for the next iteration, since i=
t will
> be blindly endian swapped yet again.
>=20
> Two issues arise. The number of words to endian swap is taken from the
> input descriptor itself.
> So on the second iteration, the length has been corrupted. This results i=
n a
> corruption past the end of the descriptor: whatever is after in memory is
> corrupted. Second, some of the entries in the descriptors are DMA address=
es.
> So if the descriptor is still valid after swapping, the data at the corru=
pted DMA
> address is now corrupted.
>=20
> Linux properly initializes the descriptor for each iterations.
>=20
> Example:
> Iteration 1:
> desc[0]: 0xB0800005
> desc[1]: 0x82500002
> desc[2]: 0x60340010
> desc[3]: 0x00000000
> desc[4]: 0xFBC17380
> jr_enqueue: Start swap.
> 0xb0800005 -> 0x050080b0
> 0x82500002 -> 0x02005082
> 0x60340010 -> 0x10003460
> 0x00000000 -> 0x00000000
> 0xfbc17380 -> 0x8073c1fb
>=20
> Iteration 2:
> desc[0]: 0x050080B0
> desc[1]: 0x02005082
> desc[2]: 0x10003460
> desc[3]: 0x00000000
> desc[4]: 0x8073C1FB
> jr_enqueue: Start swap.
> 0x050080b0 -> 0xb0800005
> 0x02005082 -> 0x82500002
> 0x10003460 -> 0x60340010
> 0x00000000 -> 0x00000000
> 0x8073c1fb -> 0xfbc17380
> 0x00000000 -> 0x00000000
> 0x00000000 -> 0x00000000
> 0x00000000 -> 0x00000000
> 0x00000000 -> 0x00000000
> 0x00000000 -> 0x00000000
> 0x00000000 -> 0x00000000
> 0x00000000 -> 0x00000000
> ...
>=20
> Anthony
>=20

Here is a proposed fix. The caam_rng_probe() init might not even be needed,=
 but I left it there just in case.

diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
index 786a710f5fb..85544f931cb 100644
--- a/drivers/crypto/fsl/rng.c
+++ b/drivers/crypto/fsl/rng.c
@@ -23,11 +23,24 @@ struct caam_rng_priv {
        u8 data[CAAM_RNG_MAX_FIFO_STORE_SIZE] __aligned(ARCH_DMA_MINALIGN);
 };

+static int caam_init_desc(struct caam_rng_priv *priv)
+{
+       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
+
+       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
+                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
+       flush_dcache_range((unsigned long)priv->desc,
+                          (unsigned long)priv->desc + size);
+
+       return 0;
+}
+
 static int caam_rng_read_one(struct caam_rng_priv *priv)
 {
        int size =3D ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE, ARCH_DMA_MINALIGN)=
;
        int ret;

+       caam_init_desc(priv);
        ret =3D run_descriptor_jr(priv->desc);
        if (ret < 0)
                return -EIO;
@@ -63,12 +76,8 @@ static int caam_rng_read(struct udevice *dev, void *data=
, size_t len)
 static int caam_rng_probe(struct udevice *dev)
 {
        struct caam_rng_priv *priv =3D dev_get_priv(dev);
-       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);

-       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
-                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
-       flush_dcache_range((unsigned long)priv->desc,
-                          (unsigned long)priv->desc + size);
+       caam_init_desc(priv);

        return 0;
 }

