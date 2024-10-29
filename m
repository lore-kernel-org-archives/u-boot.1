Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E874D3A66B
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 15:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB47891DB;
	Tue, 29 Oct 2024 16:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=hcltech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hcltech.com header.i=@hcltech.com header.b="rBPu8NlE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hcltech.com header.i=@hcltech.com header.b="rBPu8NlE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F10589166; Tue, 29 Oct 2024 12:23:46 +0100 (CET)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200e::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D4C688BB7
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 12:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=hcltech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=santhoshkumar.janar@hcltech.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XsKzGAk67cWkto0mSrNC/ROCbqsHg7HXUGRYgklIcOeJ5gEGIBPuH1lRSQ9PerCcQtyZwxk2NoNOXOx2D3LlA23j/v+87VmuyOcBHN0/E17ZhGitcPLCbiFMyeCyzpyv1B9G/lg+xZ7JtU69DxAgmlXLOEr6cLLy4uRuKN/u0kOB4rk5CecHZ/kTL1+bT482ZiMDjJAN/n6MBOHRlYWjhB1DYpUWycHTKaXHe355CQtUHfHI1culASpogJZ5zRIo/qSFXtiKFRTzjrbDBkPbI1nvqk5kjcSEX2+0MWlljPdbjuzNLWZO3jAnMCV4bx466zY9HZ1k0JQr2g2Sy94eYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBZ06FovqICxp44HaPLcBnHOTE/lCT2gmvS6IaEr7OA=;
 b=d08B3k9g5SJRvTnkJa0PqvDfZeZWiWSqb4bR8Jl4wrWnXH2Wg8rn+zuFvxyoT2mqsf6nrIl6co/JHXe0Z/RLOBJQfuz71Qi//8zptxNqig3E3/G/TsrlNM1O65rUVE3E+QSIfcIT1iHonrbvCnlkrPJagWLqePeUOEGbNiiH5XgO0DcAngeuBAhcv8uot3fsRumD2OMVG7o8KTvL7YW8s9i0msRFuxhFU+vpl+Rg4adoHSe2uZXsfuf8RAvnzNs77+j+g3qqmXT6Xbpc9KuFGZSLDvDoUO2YJeK0wsB12KFogQ7sFyKQBpVQuZHzZEW1MbuDqmZ7yD0L117qwaTACA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 144.49.247.14) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=hcltech.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=hcltech.com;
 dkim=pass (signature was verified) header.d=hcltech.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=hcltech.com] dkim=[1,1,header.d=hcltech.com]
 dmarc=[1,1,header.from=hcltech.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcltech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBZ06FovqICxp44HaPLcBnHOTE/lCT2gmvS6IaEr7OA=;
 b=rBPu8NlEOEaZEJOEyBXNeHiuyVJwtRv7a1NSc3UuNFM2eWfP9Mwqw1blMA33eikbykK+OJIs/Swf79llTHvTVvcCoBRC3pHD12F4/GC5byNl5YMkNsmcGDaXRKGg6lWQogNrxavgaviyTXwbay1Y5qG/33atLSIeM76WTlNFYndKFCneaN4P86JMXgRoAcuNY8eh/0MGl0gP6KSKIUWZKLt1Kg2Uc0fOO84sQmvgTwRlqVmknKWqWGpALKURXISMnlblsA7uD215mDUl/497fPd1KKJoDWJlwoGjOtymbbISbUmC+Nl0vHhQUGCrD/EykxHVNDWfVt5LShloTFqVIw==
Received: from SI1PR02CA0030.apcprd02.prod.outlook.com (2603:1096:4:1f4::8) by
 PUZPR04MB6535.apcprd04.prod.outlook.com (2603:1096:301:f4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.32; Tue, 29 Oct 2024 11:23:36 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:1f4:cafe::f9) by SI1PR02CA0030.outlook.office365.com
 (2603:1096:4:1f4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Tue, 29 Oct 2024 11:23:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 144.49.247.14)
 smtp.mailfrom=hcltech.com; dkim=pass (signature was verified)
 header.d=hcltech.com;dmarc=pass action=none header.from=hcltech.com;
Received-SPF: Fail (protection.outlook.com: domain of hcltech.com does not
 designate 144.49.247.14 as permitted sender) receiver=protection.outlook.com; 
 client-ip=144.49.247.14; helo=mail.ds.dlp.protect.symantec.com;
Received: from mail.ds.dlp.protect.symantec.com (144.49.247.14) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 11:23:35 +0000
X-CFilter-Loop: Reflected
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGNs4cfLoSb5ZD2WG6unFt9PB+OSH5i9O/if0pd2eQIStVdgEDOGip7zDygMsmtox24McfdUz1rI3HHg7PBMrgxODUJfI3/SAAOz1QXE4+xX4w5My0jW9UPJUy2HRIiofUHl2ZQHD/3GkCA9zDOPMqXHyGnk2IZFLOHRUnKJcoeGf7AiRzeg5uQQM+ENkOHNc2i0VdjVPAMk/LxAfw9TUPcRGPy117HW87b8kicP4Y85F2aX0y4EyVjBeNXH4qDaSD7ZhSKEO61YXtlxw0jDiwj0GXmyFfa6jO6Au9YtLV9IZGfcrYi23WCsnqcQ4xYq3RIA/xnsGoGUEp2oIbGbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBZ06FovqICxp44HaPLcBnHOTE/lCT2gmvS6IaEr7OA=;
 b=nYIpDYfX5JQ2m7vfr5XSv/eY8Pyy84Nn7axu2BfYJ2Rvb5kEMAMl3+zuVSnUPL5AGbdV4SN5MmrtSnm2oLOuN/Q/lXfgaq66NvTjaWMTdXyWRObK+NfH9UOnALKR1kaZaDrxGqtXVRcoj4VTsnzw86rKSvil6XQMF9IaHclLRnL8GLYXHYIbroznEsVMU9GUKmc9IPPTVoJglfEtXhDBsrKXe2m3GYwi4To1X8v91L+Y+Q0D4ALh2XThrR5VGu40hC07O7XcIPp1kvHK+D5HeBY7WhHJGPJvHVC+aQXg/5Wnn3Z9bNilqZ0gVl24IofwqgR6IEMHg5VUiLRdy5qPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hcltech.com; dmarc=pass action=none header.from=hcltech.com;
 dkim=pass header.d=hcltech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcltech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBZ06FovqICxp44HaPLcBnHOTE/lCT2gmvS6IaEr7OA=;
 b=rBPu8NlEOEaZEJOEyBXNeHiuyVJwtRv7a1NSc3UuNFM2eWfP9Mwqw1blMA33eikbykK+OJIs/Swf79llTHvTVvcCoBRC3pHD12F4/GC5byNl5YMkNsmcGDaXRKGg6lWQogNrxavgaviyTXwbay1Y5qG/33atLSIeM76WTlNFYndKFCneaN4P86JMXgRoAcuNY8eh/0MGl0gP6KSKIUWZKLt1Kg2Uc0fOO84sQmvgTwRlqVmknKWqWGpALKURXISMnlblsA7uD215mDUl/497fPd1KKJoDWJlwoGjOtymbbISbUmC+Nl0vHhQUGCrD/EykxHVNDWfVt5LShloTFqVIw==
Received: from SI6PR04MB8663.apcprd04.prod.outlook.com (2603:1096:4:26f::7) by
 JH0PR04MB7173.apcprd04.prod.outlook.com (2603:1096:990:31::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 11:23:29 +0000
Received: from SI6PR04MB8663.apcprd04.prod.outlook.com
 ([fe80::783b:7a9a:c07e:8b80]) by SI6PR04MB8663.apcprd04.prod.outlook.com
 ([fe80::783b:7a9a:c07e:8b80%5]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 11:23:29 +0000
From: Santhosh Kumar Janardhanam <santhoshkumar.janar@hcltech.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: Issue in probing QSPI flash in Cyclone V SOC
Thread-Topic: Issue in probing QSPI flash in Cyclone V SOC
Thread-Index: Adsm5bmMGmByuCJQRESjkGpAXXOAVwDDxjgA
Date: Tue, 29 Oct 2024 11:23:29 +0000
Message-ID: <SI6PR04MB86635577F61A16056C0B4B83E44B2@SI6PR04MB8663.apcprd04.prod.outlook.com>
References: <SI6PR04MB866386533BCFB2811EE892D0E44F2@SI6PR04MB8663.apcprd04.prod.outlook.com>
In-Reply-To: <SI6PR04MB866386533BCFB2811EE892D0E44F2@SI6PR04MB8663.apcprd04.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hcltech.com;
x-ms-traffictypediagnostic: SI6PR04MB8663:EE_|JH0PR04MB7173:EE_|SG2PEPF000B66D0:EE_|PUZPR04MB6535:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f88451-fda7-4aa8-7713-08dcf80c2144
X-DetectorID-Processed: 7a3ff160-c3d4-11eb-a2f1-967d7d39dbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?pda0WrpVrUR2FZxYivWpz+GZVm41FLtC1/OIpsXyVCdccvl8q0jWeDw5VhHb?=
 =?us-ascii?Q?1/G48vDjMHWYUN0bY1KsV0pihXKMDQjvM3jGVW3FuyXKCOkbDMZQB5S5fGt6?=
 =?us-ascii?Q?C/VlRShwgGpOlfENosOJA8uZlbjAO8cdSJIhv4BoLXASzoeOn6sD86UFTcPB?=
 =?us-ascii?Q?dJLxO0nxc0ftKFEQMdS08lFDd9NRZhJY7dD02kPDri8v3VChr3FqfDNXJHY7?=
 =?us-ascii?Q?9JtzV2q3jWiXbGW0mAfL+zoKiC4K7Dg6cZAK8i7C4Ub2O034VUXT95q9sGdF?=
 =?us-ascii?Q?65PpGtjA3bUuMNh05GYpfNdKArKnENly5uO42T2rHcdoIYHXyyafJsuQXbu3?=
 =?us-ascii?Q?5/o5XYf/jXhpK7K4znUxvlb967yLbGO5oteMVfyhqtV1nP8gr0R9s9rAqhxB?=
 =?us-ascii?Q?W6ZGSlTShrBvymcJj3Uoxcvv0vNCCzDeUXjInBwOOn9cuTAXawj7t7dWCBXW?=
 =?us-ascii?Q?D0pbiLmmXBukwVRd8KPvX2acP2D1yJD8yLunrAKvQuj5DHXh7i+3r+tJYEfF?=
 =?us-ascii?Q?2q32LX1ULWcZkhnqPFch1DcvX98CGnPIzQPdrX1DH9KLQLh13uM0BGShDbJN?=
 =?us-ascii?Q?2A2IvVoCsT3EuzzhTppvB6t6jfrLifarajD5v3+ZmIxuigAPeNKjqCUNxdCV?=
 =?us-ascii?Q?uh02stxfnERtNJScNJJhe6bItuGuCwcTPlPMOWY4f/PFuSzOAjUesR4wEDDF?=
 =?us-ascii?Q?6ONYXN3tT5+Hqm/W1ug/xcPFHL04Yru0AVFurvUF1Cy16gaIECGEd4iUhxYg?=
 =?us-ascii?Q?bwNoDbFZy1271kZ4k7PzW7HTsX44c/ljhbS+UvcOdsHtdIk49R2zmL6ABSpt?=
 =?us-ascii?Q?3/nuTGEo7xskWb90Z+eZQCoe1zqfXwADlpU0YNHw7yxCwMeEwr2EN1/gFoep?=
 =?us-ascii?Q?f4qv4Fjekk08NXqNZ+dtLI17sFok+tDyJANrIh/mktur7O1HFZ6snAn28Fy+?=
 =?us-ascii?Q?xghaC/z5mzHFyA7cWyDvvUR11fUPrjGwJ0RaHi7+46zyeYq62qqtHE4YlTFE?=
 =?us-ascii?Q?q5BRieUZXk4MYM7vShon0PXMfOnYnahET0SJhV2z4WY4jc6Itu+AtWaEQL/b?=
 =?us-ascii?Q?IHxMfsm4smDlXSn7Ty82jYIGVjV0CMlU313HLmHEFH+ZV/DtU3PtL0YOAa/H?=
 =?us-ascii?Q?xzb9xM1hA0ug3ufFdr+UbRvyG+7zTR/2Df8hgn7wJji04BTtTIT6/uIm+2BX?=
 =?us-ascii?Q?xoxTYxkXdoRCYKFoT5dpV5cCAwrh09jJMu1kEDN86JcI0UVtpKvILmAL9by5?=
 =?us-ascii?Q?u7jxcDcah+WojLXRJrww9c5iLEjLcWgZKwHIFz6f8Vms/l7Fn6/rKp5yi6+Q?=
 =?us-ascii?Q?88bC2b3isg6sxVhGFPe9d4b1EWJoc3ahZE5qqDV1v9E+vyewoN8NJ5H1k5aj?=
 =?us-ascii?Q?/uBhvRg=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:SI6PR04MB8663.apcprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7173
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 49f4455a-a1ba-46a5-5524-08dcf80c1d26
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|36860700013|82310400026|8096899003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sjp+5u8+1SWeXNDQZy1PKsS77RE7BMVVnfQyYu67BY1aL7esQRH65gOxzbuz?=
 =?us-ascii?Q?ycipoZZqrZnVlloW1YGhGjvtjOW/aHmPx0vAhheoghWKru6dQptGG7eg6fI4?=
 =?us-ascii?Q?trL9y/Ulj2DnB9FKXasHIM/PtlA5P9hlN0nKC1z3M7ZS0iyhEXDIittC5Kl0?=
 =?us-ascii?Q?V9uQ7/hw2wa9qIS/d94zoZ5FfUfZruyQ61pH0eWX1EM3JcptKjnV9A7F7CuM?=
 =?us-ascii?Q?xtrJTsWSUhaBJIfD+hkamBp9g5/o/3P2BuivGAci6MG3GivfJpoaWSQzdIH6?=
 =?us-ascii?Q?gyo6q1ImixxFxu/B0/4gq+9hBuA9IwWpWU2227zrcYhTpsYIH8FDnxutv2ef?=
 =?us-ascii?Q?z2Ylt5jJfaGEpXWAL3afJrKFIWvUJhFO0rtbmQCb81707Eg3naTsym6qKtFq?=
 =?us-ascii?Q?utckIxvcJ+5aXr78zgK7WpUZWKrEtX29MrqY7YFJiMriJYvry6fT8WqFTusw?=
 =?us-ascii?Q?Ame9YrXYvM3ssqizGjrsSVvjzvhGtEb/hA44lm/NQmyxTTZwlP/nWEc03++I?=
 =?us-ascii?Q?Q6ZcU5hFNAIOk8P2a4+UfrtfEvHon39MHYvHh5BqD5twa3VDyV4quTdu3MQo?=
 =?us-ascii?Q?Rgfjc3O80xqSYA/Nq7sthZ1+tFK45q8a/YF/m95UxJJG/b+/HkPyGoxSk2i2?=
 =?us-ascii?Q?IrU+AThH5zCokQ7atnZFqxcfqukpn/QA8g8pTlsw9r/2w8QcHyqm2MP/Fnht?=
 =?us-ascii?Q?quUrqpDTOTB/jtEjU+1bV827JYPdxNQVjn47H9hM2dZ0WjJDQh2JbXyxB1/x?=
 =?us-ascii?Q?U1I0u8pC1NkS1EvAGtiQUa+LbJAJ07Cuz5zdhCM/O8YJhQcBVh5nI/qIvdvt?=
 =?us-ascii?Q?t9Ee8YQLTIHC9r6x/cgqbPKoMxGauQVnLMJT0cFHOcf6BEjxP2pPOn/NRyZQ?=
 =?us-ascii?Q?tORe7lpHQT6pzb1WLMmDGp+OR8RolPNza+jEdLQH3wdcuRODx7pW5CNed7gt?=
 =?us-ascii?Q?xjSQOyx77M7C6PlECHC0exdjYLQHuhO4TJQUgxkevAd7HHWkEBa1P/L92c93?=
 =?us-ascii?Q?bASR5nb7sEMEesRkD92zBlPq0DJWlrBmgjTKWn+Pt8Hy22C+JQzTZ9W1xcL4?=
 =?us-ascii?Q?tHzpnJhYRevpScAyQkTkP+RezasYmSymHvvykFmxnvP7fBi/PT0bMSwufJv+?=
 =?us-ascii?Q?oGJfbWsHXdU9d0jcaG8kDizhPpK1a+ZCOujizRTuCTMgghZmEgnwS2fkTfg1?=
 =?us-ascii?Q?FqItkTX7VksmECDJcyo2uHjnm+lj7A5dwMffO5OOxeB2LUPC7QR5w1B20jKU?=
 =?us-ascii?Q?6DBJDoMMZYZsPUbcBw/cQDD5c2KPeWJ8j2UUJQfiR+5M05LeEzHHYXJe6fL1?=
 =?us-ascii?Q?VKfQc2E1+Un+RIvdiSVWgmfr9ToltSmH+D+P9HXlStFIbfwURZfRhFhF5P7H?=
 =?us-ascii?Q?KTN2EBMgv+8OZSZuF1Ti6fTtXAeF3emV+ezbh/7xU1Wcxv6KVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:144.49.247.14; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.ds.dlp.protect.symantec.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(36860700013)(82310400026)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: hcltech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 11:23:35.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f88451-fda7-4aa8-7713-08dcf80c2144
X-MS-Exchange-CrossTenant-Id: 189de737-c93a-4f5a-8b68-6f4ca9941912
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=189de737-c93a-4f5a-8b68-6f4ca9941912; Ip=[144.49.247.14];
 Helo=[mail.ds.dlp.protect.symantec.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6535
X-Mailman-Approved-At: Tue, 29 Oct 2024 16:18:23 +0100
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi All,
Has Anyone faced this issue, any suggestion to resolve the below issue woul=
d be very helpful?

Thanks,
Santhosh
From: Santhosh Kumar Janardhanam
Sent: Friday, October 25, 2024 7:42 PM
To: u-boot@lists.denx.de
Subject: Issue in probing QSPI flash in Cyclone V SOC

Hi All,
we are testing QSPI flash in Cyclone V custom board. The QSPI pins used are=
 same like cyclone V sockit board.we are using uboot 2024.01
when we do sf probe, we got the below error. we have verified the pin mux c=
onfiguration and also enabled the clock.

=3D> sf probe 0:0
jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff
Failed to initialize SPI flash at 0:0 (error -2)

The DTS file contains the following entries

&qspi {
              status =3D "okay";

              flash: flash@0 {
                             #address-cells =3D <1>;
                             #size-cells =3D <1>;
                             compatible =3D "n25q256a";
                             reg =3D <0>;
                             spi-max-frequency =3D <100000000>;

                             m25p,fast-read;
                             cdns,page-size =3D <256>;
                             cdns,block-size =3D <16>;
                             cdns,read-delay =3D <4>;
                             cdns,tshsl-ns =3D <50>;
                             cdns,tsd2d-ns =3D <50>;
                             cdns,tchsh-ns =3D <4>;
                             cdns,tslch-ns =3D <4>;
              };
};
The flash chip is connected in bus 0 and chipselect 0.
As anyone faced this issue earlier in uboot with cyclone V? can anyone guid=
e what needs to be done to make sf probe working?

Regards,
Santhosh
::DISCLAIMER::
________________________________
The contents of this e-mail and any attachment(s) are confidential and inte=
nded for the named recipient(s) only. E-mail transmission is not guaranteed=
 to be secure or error-free as information could be intercepted, corrupted,=
 lost, destroyed, arrive late or incomplete, or may contain viruses in tran=
smission. The e mail and its contents (with or without referred errors) sha=
ll therefore not attach any liability on the originator or HCL or its affil=
iates. Views or opinions, if any, presented in this email are solely those =
of the author and may not necessarily reflect the views or opinions of HCL =
or its affiliates. Any form of reproduction, dissemination, copying, disclo=
sure, modification, distribution and / or publication of this message witho=
ut the prior written consent of authorized representative of HCL is strictl=
y prohibited. If you have received this email in error please delete it and=
 notify the sender immediately. Before opening any email and/or attachments=
, please check them for viruses and other defects.
________________________________
