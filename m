Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FCFC7115C
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 14:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC0680E9A;
	Fri, 20 Jun 2025 16:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=trendmicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=trendmicro.com header.i=@trendmicro.com header.b="H4B95pLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2FDF82CBC; Fri, 20 Jun 2025 16:23:40 +0200 (CEST)
Received: from muc1mailout6.trendmicro.com (muc1mailout6.trendmicro.com
 [150.70.233.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A56180C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 16:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=trendmicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zdi-disclosures@trendmicro.com
Received: from muc1mailout6.trendmicro.com (unknown [127.0.0.1])
 by DDEI (Postfix) with ESMTP id 7BAEC7F0AB9;
 Fri, 20 Jun 2025 14:23:37 +0000 (UTC)
Received: from muc1mailout6.trendmicro.com (unknown [127.0.0.1])
 by DDEI (Postfix) with ESMTP id 6186A7F0AB6;
 Fri, 20 Jun 2025 14:23:37 +0000 (UTC)
X-TM-AS-ERS: 10.36.230.32-127.5.254.253
X-TM-AS-SMTP: 1.0 TVVDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
 HRyZW5kbWljcm8uY29t
X-DDEI-TLS-USAGE: Used
Received: from MUC1-EXCH01.eu.trendnet.org (unknown [10.36.230.32])
 by muc1mailout6.trendmicro.com (Postfix) with ESMTPS;
 Fri, 20 Jun 2025 14:23:37 +0000 (UTC)
Received: from MUC1-EXCH01.eu.trendnet.org (10.36.230.32) by
 MUC1-EXCH01.eu.trendnet.org (10.36.230.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Fri, 20 Jun 2025 07:23:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 exhybrid.trendmicro.com (10.36.230.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57 via Frontend Transport; Fri, 20 Jun 2025 07:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW5DAXmmfSzEOTBeqybRzwP62JIhZPhizPuqbFGmJDQgoccgX/wUr5E6EGyHp8CMAOs2Vt4botCyMi1B0oY1woITMRhZ3g9Sn75udc46mikkqnPpVfhV8yPw6XnoXrcWgEZGe5urKYbCYqocbQzPrxV94ghslC64nictKn3xLlxnW3b3RDtxguJe9Zb08Fkz38iaClYS6dR3seK3uPI/Co+nkifW7HRT9xCBDFL4uDTB4+TXswWfjIEAVtwlNrBBaNroFnkPwqncVXAHCEPyMmnQDeRxLszcTJ/jhwnzh+dlqeAFlWyjwErD6/t/SPH86VOXsCkE9q+VAZBt0rqICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKi3kahZS94DB49SqUE0CJJs5YXR/AGNT/gRgbjYnwQ=;
 b=Ea/8aEkmLGSb/iHHKdXcll60vumudyzBvwjGIA0b7VvB+sZORtXzM+7AVXjlAnMJ3ro/486g2F9xJYdWBIkCs4aHvJOYHfS1w3AqWBotkkArGSde6fTw2TEL6+/KtEz1XzIEDNSUxnn2MoWogFtvjAP5VoTbod0foKCVEc3I3Uq0eRbhCpJ8kSmNcMdiEfyK+t3WPY8bNMZwJ5FDtrFDUdGXqOOFDiUolOphLqXT5qZLzhcdAlrMca3cqUNru0Pv9ktZn/eTb7G79rH9dKnTbUoX+JohFVlQP2DxMZoXBsh25dziw8JEC+PUFOgBxwuQLk/HKETNzhp1xG4OQzYSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 SJ0PR01MB8182.prod.exchangelabs.com (2603:10b6:a03:4e6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.30; Fri, 20 Jun 2025 14:23:31 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::3169:e6d9:86dd:7cf8]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::3169:e6d9:86dd:7cf8%5]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 14:23:31 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
CC: Michal Simek <michal.simek@amd.com>, Wolfgang Wegner
 <w.wegner@astro-kom.de>, Thomas Weber <weber@corscience.de>, "Stefan
 Herbrechtsmeier" <stefan@herbrechtsmeier.net>, Phil Sutter <phil@nwl.cc>,
 Siddarth Gore <gores@marvell.com>, Luka Perkov <luka@openwrt.org>, "Holger
 Brunck" <holger.brunck@hitachienergy.com>, Heiko Schocher <hs@denx.de>,
 Evgeni Dobrev <evgeni@studio-punkt.com>, Stefan Roese <sr@denx.de>, "Ilko
 Iliev" <iliev@ronetix.at>, Dave Purdy <david.c.purdy@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: ZDI-CAN-24679: New Vulnerability Report
Thread-Topic: ZDI-CAN-24679: New Vulnerability Report
Thread-Index: AdrZTXhy+e33dzc1SjW672SeLXWatxc/EHBwABbrJwAAAF84gAADBrYAAAfa6oAAAIYcgCrGfCAA
Content-Class: 
Date: Fri, 20 Jun 2025 14:23:26 +0000
Deferred-Delivery: Fri, 20 Jun 2025 14:22:40 +0000
Message-ID: <BYAPR01MB3830F2025F69E0F1ABE93CAF807CA@BYAPR01MB3830.prod.exchangelabs.com>
References: <DM5PR0102MB3477A6AC67623306D970177980AC2@DM5PR0102MB3477.prod.exchangelabs.com>
 <BYAPR01MB38307E0A0D8A480B35F122F6805B2@BYAPR01MB3830.prod.exchangelabs.com>
 <20241114145636.GF3600562@bill-the-cat>
 <868d9f51-0d84-4c22-abdc-95cd60184465@amd.com>
 <20241114163354.GH3600562@bill-the-cat>
 <CAJaLiFyw5jba5g=8h6R_aB26wqJvdN9eLvu3T6FJBBpm4LkzhA@mail.gmail.com>
 <20241114203349.GM3600562@bill-the-cat>
In-Reply-To: <20241114203349.GM3600562@bill-the-cat>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=ada65f2a-c33a-4ee5-a727-2f2f18537d1b;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no protection;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2025-06-20T14:21:15Z;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10, 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|SJ0PR01MB8182:EE_
x-ms-office365-filtering-correlation-id: 643d237a-5f4b-4aee-82f4-08ddb006088c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|8096899003|4053099003;
x-microsoft-antispam-message-info: =?us-ascii?Q?lOWyBjiKHVTGq/UhvpXQFdH/+rE6iKdZS5+qFgUKHoI+Aw4dlTfckBno0Owy?=
 =?us-ascii?Q?RnoFVnPhTQa4SNBiRacSl6SkETqBJvSW7ZOHWJZTpZGFaJv6eMkMaOJT/Iyt?=
 =?us-ascii?Q?Cd2AlyIe+6IJn+/k0Vfk1nMGQWr8OLAjEQIBb6eCi8Uq5Y9IrIqdHkfy3hlx?=
 =?us-ascii?Q?MA2rJ12+nmyMvrXf85sJAAg1N9dp7TEQ3Yc0LnmpyPc2mNtKFsAJjGQyT2/T?=
 =?us-ascii?Q?PXlxIYf3413spgE+Ofjjbe0qkTBEdOeH7q94oP/cobbMwRPAtaLv0AmKGUND?=
 =?us-ascii?Q?Fd/HJAvWlZ8zFI8FtOn+KbuQWGruzvIdyRw76QDzoNOzc87JRrsQuFZxL6iz?=
 =?us-ascii?Q?6htxanqioKP5wP7hIe0NwQ/Ntadft6RrJloFtc6C9LGZEKRSUqc2AnV5twxd?=
 =?us-ascii?Q?FHyXxq6WXyXrI+cYS3Zs3H8C2xPXRd+ViTbMevJG7Y1WOSU/asQ8/za7Ad3Y?=
 =?us-ascii?Q?K7bzKceyHkQcqVQGtF0aQmvYxsfXMRAhXbOsjFKa8AIgbduaHSaPQnpG2d3w?=
 =?us-ascii?Q?ZLXNmrH2eInZljHCBvpQBWg97Lqrlf2QaR7jEbkcfGfP0LOzMuf9vtXuYSIz?=
 =?us-ascii?Q?I7+cWlLs+wWjbE+5nL2OlF2pglGR646FVT7bfi9BWNbZ6FgYrHE1fUG4HVQM?=
 =?us-ascii?Q?BXjHmPDXeFg/i9IlGJK3Y2jgf4wv5c1oWbsm4uCPYdCNmi23YJJqBe3odE9Z?=
 =?us-ascii?Q?PKCkiO7J1BxeDtAte+7y+jrq/3f6P1DHSmqxpOg1KkFNfvvOJmJlHdNOVPT7?=
 =?us-ascii?Q?h4gs3G3FpSZhjIFI9dBTRtD3Z+7GPGNQoLF0dUDC0K2uDjublFGK31R50C8P?=
 =?us-ascii?Q?gKDCsce+h0ZNUMoIk7FXLWotYJbVmXGB9hY2110LwKQnUHZOjLNlH9DrYjOk?=
 =?us-ascii?Q?wsDM1e/g/1JUd692CqZdC2UymLBfE3kLbs1zHA0vc55oz/OWGyynhOdCAUKu?=
 =?us-ascii?Q?4kxgsw/KTf7AuOkJndmvvaBsVFko+n3B4O4HNv4zPGRZ/Wv/gc6pEmoK7UgE?=
 =?us-ascii?Q?H8E4PhCO9rYBIISb4rZebZNhV0Rwmy51TSvS7kkY0doiahRM/bqif04Kzsqr?=
 =?us-ascii?Q?9LpGcpyExarzWIVNuSbA/AT6EPVUjGAR1cKrV0PYoQy/2h5Fnzlyp7n7TqCi?=
 =?us-ascii?Q?NJSOgfhDWEC6Ywp9e5s27BtceWDFg0QNfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB3830.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(8096899003)(4053099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g+zr3iKibkroINAuGz0hNA1o/UYgoS+LKltLAp/G97+OMYvHLyDlZ+F4kq0D?=
 =?us-ascii?Q?HnylqIVMeqeSqsPlf/k+yC5qwJQCrGR2fQD1lsfH6Gg6ohYC1kK2V5C43Huv?=
 =?us-ascii?Q?UxLgjr4kTlfqfgeaaNU+/+aDnBq38p3sxh/NpJAhRriU1y+WB5CbqlICFW0d?=
 =?us-ascii?Q?EdamKod6FqBjv9fVyXx66LX5qci6GxOWF0GqZreFdUf5Ny6mRSK+gao6VusF?=
 =?us-ascii?Q?cRKzSt66ChcOWj9ADULwuAoftgKrUbxahlFhW2GKlgjoF8oDwugKgewxZ61K?=
 =?us-ascii?Q?lFm88Qc/ExiHoXBjyWpbeaVci6XsG4l0RGY/2cpoOi4Mcd4KDH8IeF9UR5xL?=
 =?us-ascii?Q?FDeAjdvvyBXwPLtQF8TSABJOJwYuPaBQpRa1UWPp7fMi0u1I5Tu7LL9uoqHX?=
 =?us-ascii?Q?aOP/juTf38ywBSs/R9oZOBFExRx1dLCWlkFKZmn/t/kmOQB9xB4y1/buddTp?=
 =?us-ascii?Q?EmSMdKuWxzXN36Lo8KtEwrkhcB9x60oHbazWY6JGngtSjlsjCwgifONidoZG?=
 =?us-ascii?Q?Q34F8R6X/kKns0iu8KIA0ZDhuZJDO9UgrTp1v2+fvXwUzRRKkOe/9Aana6yw?=
 =?us-ascii?Q?qVITPZX713/qEnyPjswLyf5lbSxvY/w4dCj/2nULmGSC4cw9qH7vMvSPHO3Z?=
 =?us-ascii?Q?5mUfmaV/dl6S83oFO6XO1xY1ZzlX7PoinyJrj5QHNgqWFMP6jTy+GveSG7dp?=
 =?us-ascii?Q?akjJAH/TVpMXsi4Pzn1PUrTRrhlv0KK9b6D6mGl6TwMHWSlvP35PjB6Q/Wtm?=
 =?us-ascii?Q?suYcSgxVwoGO66PhcOmFht0/FxUTEfymN4RtKSQx8iIjAOkpDa5v1iM1zuv0?=
 =?us-ascii?Q?hB+2S4MNz9PbYbumbcnMAxix6HyC7yqnniB+X2VM82hV0ap7vlfMXtwqnESa?=
 =?us-ascii?Q?ZT4XRVCXZHWs6IjRI4viQElLz9vFEmuc7cvNXrJFmp4U9aoCNtN8rh6Msaqs?=
 =?us-ascii?Q?cpKWEuNg2DS+LtIm/ZKth9AFpvbAZEeC7QN1JuLaXuKvol0MjKZJ/Hs7iazR?=
 =?us-ascii?Q?O6a649XooRlc7nHnmdQy8GOU/u/Bn49xIasTHwWWcgBZBMpKpfiTYzvUclWa?=
 =?us-ascii?Q?0pkvG2rVaAmZwyaXKsEzILcz+9R65B/mWjkzG41GHRsd6h5zm7qp0RUA/y1j?=
 =?us-ascii?Q?za+V3qQn5+fmcjwA/Mg0un8xZjojp1QtFQhf81tZBuSituTaS3/2B/xcaSfx?=
 =?us-ascii?Q?abYdpo0y5G5W7ej2esVm3S5l6CwupK3OuIztd9lW8oFAlgNsVFrX7wuap7hH?=
 =?us-ascii?Q?1EYLrR+X8KO2ipu67qzRGdrC/EZldzffVFsIaizr4kXNBsaDd7hbQAi/IlSI?=
 =?us-ascii?Q?cx7r3GNKkpXacD3mYNsB8iUC6/gyOX8pQo/2c5UeItz+qRpOScW3ZSpxOkTK?=
 =?us-ascii?Q?Y9jo9pNqKTLyCt76wXzj6/XiYb1WQ2t/VrNkP+AnefAsE/TtymKqlOGfUXdX?=
 =?us-ascii?Q?/pXzXW9AtsUytz+RwA5RFxfyLbDSOzeVPXtcHjLXhCip3ZD2bVeZwhOpY11q?=
 =?us-ascii?Q?VGvXKXrdFg72wOFnqdJ6MtOioKb6qEP5D/tXfaWcpX+nY7NonwgY23ZsWNJv?=
 =?us-ascii?Q?1xfF7uDJzuEFl3aWDdB554UlrS9fiNZSh9qEqUVQN1AMgrVbtxO5I3vLJu/5?=
 =?us-ascii?Q?hw=3D=3D?=
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256; boundary="=-=Hjb7x7JPf2GJbG=-="
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643d237a-5f4b-4aee-82f4-08ddb006088c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 14:23:31.5578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1S4EKKMtNQWCGMcIkbH+PY/SVQAQw0XO1g76TYcgzzOtYRZrUhIWgTfai6RtEK7twMC671Lbro+5Zvn/7wl7SntG9d/NoHr5QwHnrmQLh2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB8182
X-OriginatorOrg: trendmicro.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3197-9.1.2019-29274.000
X-TM-AS-Result: No-10--25.532100-5.000000
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TM-SNTS-SMTP: 3F5388C014F75D71F1CE66D29885EE2FEA9CB3E9B2E00FA15803A739C1582EA52000:7
X-TM-AS-ERS: 10.36.230.32-127.5.254.253
X-TM-AS-SMTP: 1.0 TVVDMS1FWENIMDEuZXUudHJlbmRuZXQub3Jn emRpLWRpc2Nsb3N1cmVzQ
 HRyZW5kbWljcm8uY29t
X-TMASE-Version: DDEI-5.1-9.1.1004-29274.001
X-TMASE-Result: 10--25.532100-10.000000
X-TMASE-MatchedRID: 7NIpADDPOAM2eFTDBkQySu5i6weAmSDKiRPU6vvejXJ4YeSlHZYFooBU
 1MgMaF4CnVGdm/iKvge4wd+P+PsO7CwbrGGIwrOmF63b38RTfu/eKe8oj/uqvTk80gd1ghWggGR
 F1k3+fNl57PigeFijGZ+FRP4Koee2S+4XHTSNKQEKnxSJyztfqgGZ/+APXW9k4+xf2pXdquShkK
 1lCe/qjS2Nk2udg7VFHqbsnjd5LzIcQvLacRAgcJ+stJjZFtGkMVx/3ZYby7+8MakitBkj0a7+K
 3NciWMTE1mUDQ21kEQBkd3PP+Ehpx51Aa+xzoOirMZ+BqQt2No1kR+05VC1hgMFD5cGHhglhfww
 a6XqPjkdxGhXTyoW15oivvFVRdDkrUxfJ4d0IRvOj/hxK35Y1Q2y5A4HtQVbQYaknL+rSlqtyaY
 Pv+ErX7No0doysLpNtfAeP8CayYYSMbwGTAneLwU5rQ/jDZbqV0vN9JEbVSO1PimItaljun7cGd
 19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 57e7166a-e4be-481b-b981-493e769ec924-0-0-200-0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
 s=tm-outbound; t=1750429417;
 bh=iarvLtlvcSZXSdaq8UbK7T3voGkMtLUwn1LreRLRqmg=; l=3854;
 h=From:To:Date;
 b=H4B95pLXZP8WBGzxERVPM4WmwlqelSfPWaXT5SsuBUBKX6nIyGvy9XaK4OzhfY3NY
 6ISM9d3kgL9r2MlT4ZGU1YIXmAVGXfInPmsgl3pXi0M0WGeNUjlrAKXotwIj0FaAP1
 RbZUgWe2TsPJWvSHb+1d/PnvOARpxWztghBDpNxQOv36l075YsYX3UbW2hK/W+pEZx
 7qiNIngva8pf3S+A2H/UvckcWkNyS6lc2yh2ZE8KvCs0jiJp5KegGjIcCK1/pthn0z
 RTDn7/m2wcysxdb13A8iIm+Ozic2EXfaTi/AzBiOyUM5DvkIL6nwp5GFJstmxPfyKo
 wyDPQ92iw0xcA==
X-Mailman-Approved-At: Fri, 20 Jun 2025 16:37:30 +0200
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

--=-=Hjb7x7JPf2GJbG=-=
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Can you confirm if any fix was made for this vulnerability?

Thanks,
ZDI

-----Original Message-----
From: Tom Rini <trini@konsulko.com>=20
Sent: Thursday, November 14, 2024 3:34 PM
To: Tony Dinh <mibodhi@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>; Wolfgang Wegner <w.wegner@astro-ko=
m.de>; Thomas Weber <weber@corscience.de>; Stefan Herbrechtsmeier <stefan@h=
erbrechtsmeier.net>; Phil Sutter <phil@nwl.cc>; Siddarth Gore <gores@marvel=
l.com>; Luka Perkov <luka@openwrt.org>; Holger Brunck <holger.brunck@hitach=
ienergy.com>; Heiko Schocher <hs@denx.de>; Evgeni Dobrev <evgeni@studio-pun=
kt.com>; Stefan Roese <sr@denx.de>; Ilko Iliev <iliev@ronetix.at>; Dave Pur=
dy <david.c.purdy@gmail.com>; ZDI Disclosures Mailbox <zdi-disclosures@tren=
dmicro.com>; u-boot@lists.denx.de
Subject: Re: ZDI-CAN-24679: New Vulnerability Report

On Thu, Nov 14, 2024 at 12:18:49PM -0800, Tony Dinh wrote:
> Hi Tom,
> Hi Stefan,
>=20
> On Thu, Nov 14, 2024 at 8:33=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Nov 14, 2024 at 04:07:15PM +0100, Michal Simek wrote:
> >
> > > Hi,
> > >
> > > On 11/14/24 15:56, Tom Rini wrote:
> > > > On Thu, Nov 14, 2024 at 04:02:29AM +0000, zdi-disclosures@trendmicr=
o.com wrote:
> > > >
> > > > > Hi,
> > > > > Do you have any updates to share regarding this vulnerability rep=
ort?
> > > >
> > > > Michal, microblaze-generic is the most active platform that=20
> > > > enables
> > > > FS_JFFS2 by default and so vulnerable here. Can you find some=20
> > > > resources to look in to fixing this please? Thanks.
> > >
> > > We have actually discussed this recently and we have other issues=20
> > > with jffs2 and not going to fix it or recommend to use it.
> > > JFFS2 should be removed from our configs and it is also not under our=
 regression.
> >
> > Ah OK, thanks. Adding a few more maintainers now then.
>=20
> Does this affect only boards that explicitly use CMD_JFFS2? how about=20
> boards that have not been converted to bootstd and still use "nand=20
> read" like this:
>=20
> include/configs/openrd.h
>=20
> #define CFG_EXTRA_ENV_SETTINGS  "x_bootargs=3Dconsole=3DttyS0,115200 " \
>         CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=3D2,2048\0" \
>         "x_bootcmd_kernel=3Dnand read 0x6400000 0x100000 0x300000\0"     =
 \

It's a problem for boards which read from JFFS2 in U-Boot, yes. So in the c=
ase of the kernel / etc being read from a raw location (or ubi or what-have=
-you), if FS_JFFS2 (or CMD_JFFS2, same list of platforms) is disabled the p=
roblem goes away. And if we're down to just a few lightly used platforms, w=
e can just drop JFFS2 support. Thanks!

--
Tom

--=-=Hjb7x7JPf2GJbG=-=
Content-Type: application/pgp-signature;
	name="openpgp-digital-signature.asc"
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERaNKnE03rptFhH0iHm778TjdmjMFAmhVbmwACgkQHm778Tjd
mjNUUw/+LpHmy/KUnpmF11HHqM/VK9m9MAPbAX+VzTwWlCB4SM8JCxDV8MInkQeZ
6tM/jxw6e6HM+Ty/+75uqLcP5YlTQxCe9/9F6MqUmD42LmN2yJ5TdDh82IZOulJK
oNwo2a1Q4PRP5KkwZRI3aTAYJw2p6/lN11W1S3p8K+rQolk66Drlj7nQPktlSu17
KdVoi+T4JopCY0RR6YZpploALNDqvCN7W5qRStRtrrHFHiL0iUxOWODMXuoNOYmA
LJ25n93SjUNZdMpOAs037kCRAbnewSbM9hp5RNnCxsY1TddXd/KBhFNbch4oTk0F
TAGVqtoctWM8yrNGdIIu8NfQ4lj4Ig0pgCz1xCJg1mnTE1/K5LHiau+vEOm5/A3d
OLU46aj8laHN5RVNKyTkxpG/z8M2vcrOZ/HNEmy+2phZ9hyz80D/v1O4zuSh7tkV
JMuQl5alZS32NLLBWm41jMczYIv83Rrblh8LvCPxypXELU8B9tO2Vv7baUs4Ji1I
g+HRbufhSeYRdSbdUTw/lyK/cZzgt8B4jnqc0qgy0LJkj2XEYfRdQExIZj9Mw8i9
ZJ4/8hcoSJt+0dxD+sSr1IH+DW09SF/pQ/Rjx1hoZJknhCyxXosu4ESO0VjoKRW1
j/DQt4PZYD9i6JbI9iXa55oMsiAgNlt5eQbf5GMiOiznlRu5oG0=
=n2H6
-----END PGP SIGNATURE-----


--=-=Hjb7x7JPf2GJbG=-=--

