Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553EAFF5126
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 16:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE32284118;
	Tue,  7 Apr 2026 18:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Gi+YZUdv";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Gi+YZUdv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C03284120; Tue,  7 Apr 2026 18:41:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2738383F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 18:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=VMumD9UXs93HWC8K/LBnAunpOQEq1tgVcFqL8qfFnviazmyoky5VHBPCm2UmvEiV9s/puAB1QKJ81bvNECSi77eOQx0LbEuDYtxZOlMidpNEnoibNaYphYahMnnRJ2B6eYDxKdSfTIgYP/qgppWL5C1x9pnT2AIPpx0PB8Aw2/FhF8EFu5n28XSzeKzzr27bpaum8uu7LPZDhDqXzLOHYfNohQbvDPW8Tmrs7uxyNuG4aEhaUqzxV1LAbBhEqlS+m8w2/uF36ypeUp9ivfSGOyxdusAlFJ4oG6Fl3nh5vGAxIjsmhBrxu7jcaBhrxUuTk/hN2znLwZr9ssfa+SmtAA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxLhdH6lDdeU7VDNqFykEGPFpLYQMX+xqjCtn6batLk=;
 b=pg2M7RieVhXG6LjS3T91zxGCLtKoscv9oSFwxEKjWp3JsuJaDnYbyDsewtPl0+1tZQi5ejZMOzSVLH7CpGy6rbr8iWrZEN10DSFeY53WDDy6/ZOyEP9S18/2ZwJakqKR538YWTqoqd1wdPXtavgF6RbRNhj7PNhQLJP+oYdSJOB0yL/zo6yG77yVecx6AByjHfeG8tgIvYbZ/9MlaBCOj420AyGVSSIwNs7hVSl+6H5cLXpGkWCH18RQGNkF991r8ipiR4cKQyHbEKPuk73A1E6WktB6dJxNOx9dkF2va7/HmGo3h6F7pwFYF4dT/dEIN5b9G5Kg4nW8wxA4p40Emw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=konsulko.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxLhdH6lDdeU7VDNqFykEGPFpLYQMX+xqjCtn6batLk=;
 b=Gi+YZUdvrmVyr7udhvfXT3RIDFLnmP5bw2kXbqHVYa3Nf3v/nb2PYeu+8Yhkd6n2cI1uny4P66J0HEKYdxbZ0k8qr7KKSTnZvhodY/FQZ1ys8ANHxUErBIi8OpuwS0/fXaAW8wW/qgM5RfzQ9ot7IYaiYqPmzPqOzLxxsyndWc+LwnucBVY2on/AOroZzIEfUq+BjEGGkKge1H3XH2THYTB6C0n/MFsVvsYlHQKXVSJyfHSbPQODYoJtLrv2zS4mDM+sraLlI9aCdD5IZ1grAK6Cu9w/RxPqD/predK+hXiMdNl9UaNQoRU/sUESKclhB0YkfwSCG0/OkzmlffsYqw==
Received: from AM6PR0502CA0051.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::28) by PA6PR03MB10451.eurprd03.prod.outlook.com
 (2603:10a6:102:3d5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 16:41:06 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::1d) by AM6PR0502CA0051.outlook.office365.com
 (2603:10a6:20b:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 16:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Tue, 7 Apr 2026 16:41:05 +0000
Received: from outmta (unknown [192.168.82.134])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 ACB5F20080F45; Tue, 07 Apr 2026 16:41:05 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (unknown
 [52.101.69.143])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id A3B7C20081263; 
 Tue, 07 Apr 2026 16:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImWmVfMfoLeYmB/YeZ9YNH/MnLQspbux0+T3TFG5wlhsb7f8Bc8TkUUWw0/mb4Lwh+mEWrx/i4K4LvydoojdP6msiJuBj6yvYrmnxyPVnRvGoAaXMBgDiwyiemPPa03wResrb4M6we3IsXBsvjkRuuxxS+J/7hH6aJUwFz1ibLDjGB51L9cma8PAay05F0AkVoEMNGnJv1Nio9adoKF8dvokwcjDqeuDAxHX5eggWoL7cEzooPt/Z5ilg5EDSrk9ugShSIQUXYy8yNqLrB8NbGENV5hnHfpy6By4pFYlzTLgcbTyZzSepn+TrChIf+xuMGgvArt6e1Hx2QkUqFSr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxLhdH6lDdeU7VDNqFykEGPFpLYQMX+xqjCtn6batLk=;
 b=kDlSj/OInm++RTIRcFQqCE7vUiS/QRffF1uBQzMJcPnKVJTbAjbhaj38+NjbmsNH/mol3kHOGrLEld1izUKdx4Hx05K35cO+4qlV7Iy6wAU3DNVwWZnnNPz6+yxp2N1VmZFTf2vAGdgsJW9/EpILJx5g0PSFkXzMXh4YiVh5OxdWp7U+NMu87kH9EDm0RnZpjUIBOEIRvldSzvLPtCZ0QrsMHB/pWm+xdtEFcWWYnwnDTjtReGMuxe/wIM1xDDptHVQkpqlvZAb2VTcSt5OsIQiN7ULOLRVVdxAq4apgHbWXbuBkwz79huX0i/yCEc6PR1xmHPgYFM8FPbk0ZMa3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxLhdH6lDdeU7VDNqFykEGPFpLYQMX+xqjCtn6batLk=;
 b=Gi+YZUdvrmVyr7udhvfXT3RIDFLnmP5bw2kXbqHVYa3Nf3v/nb2PYeu+8Yhkd6n2cI1uny4P66J0HEKYdxbZ0k8qr7KKSTnZvhodY/FQZ1ys8ANHxUErBIi8OpuwS0/fXaAW8wW/qgM5RfzQ9ot7IYaiYqPmzPqOzLxxsyndWc+LwnucBVY2on/AOroZzIEfUq+BjEGGkKge1H3XH2THYTB6C0n/MFsVvsYlHQKXVSJyfHSbPQODYoJtLrv2zS4mDM+sraLlI9aCdD5IZ1grAK6Cu9w/RxPqD/predK+hXiMdNl9UaNQoRU/sUESKclhB0YkfwSCG0/OkzmlffsYqw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB9438.eurprd03.prod.outlook.com (2603:10a6:20b:5a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.27; Tue, 7 Apr
 2026 16:41:01 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::10b9:4b34:65e0:ffb1]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::10b9:4b34:65e0:ffb1%4]) with mapi id 15.20.9745.027; Tue, 7 Apr 2026
 16:41:01 +0000
Message-ID: <1a51168f-e7b4-42c0-bebe-fadd3996014a@seco.com>
Date: Tue, 7 Apr 2026 12:40:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update my email address
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260407164011.210590-1-sean.anderson@linux.dev>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20260407164011.210590-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:408:ff::18) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS8PR03MB9438:EE_|AMS0EPF000001A8:EE_|PA6PR03MB10451:EE_
X-MS-Office365-Filtering-Correlation-Id: 39abb853-bf4b-45f5-473b-08de94c476ab
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: NoPgJcOs3LW3TNml064rgIjE8p4KtrGnAtkd1fh8PWOoZZgcK89Yt/It6mRn2Jdg/vj9WJKrLy4ByLkx2DwgDPwLpLwk4chsYItvSQ7c4+r75GpCsOICbNWcHjM+fMmFoERmfhuB2Wv4gyFfWYNRrjqGd7InUKdy+Gl7IoIcroLOrdGbZERUs1MfXr/BKD8P4EiZ+QzaFqttCc3NINHPew0ixEyOZb/ZrYy7fFDMHzBOslQYfazg7aKPUrq2JsNO96TpiF9rDR8+OE7M394e/HW2VgR1pB8B0E7ETdwtXnC1mqs6EgbXTXiEgoKPmDosSb902RTh4DIDmM/BWvr9+vUygxWde3PIwFVbZAgQ1v+6uRAGVeaZT8gckBmbNfAM3FfyWgfM1sKWhW5Zaa3Z2xlRIUe8/0M2LB2TmQM4xazalccQphQ/RR1Twq/LmFijfELIUAXGqYeCWrhso8E2k82l91jQS8RmeYbh7wH0qBBMSSiCSTeHwRdzcMkTEcvCb+z8vVC+ezEY9BEUzqsGJAKj+RshqbEfdcOfxsRDESxj32/w89CVYsXEQrrNfXm8vQ0gd8ZdxFo/uXD28kKA6vJhkcV5LI9U2OxDtaHDSuE0MdcC1cI7t2kNeDXbyW89MbLcVmc3qM68iZ3w1/lqz7VZmxSYik6xtVdEyYLh7XYg4wTO6R7NuCi85Qb5EgqFddnuFRUb32y/n6gbGNwnOoORfCuYV2xcOdoCHXfJXGM=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: dZvcOCzkmFFf0ie9W1oFhFBBL0PcwwPFnDXmAREj95GZEVaw7o+VfH220CrGPgcyDUzUH3EGR7+zd/ndcatuChdp9tNY5NtYQy2yQRcae44H07lySijNCPxeY9NIfsYlQ06lI9i3AvFvUO1oZ/OcgWW3feYCGLnfWGEHbnCLm5ZqB+Ve6AfHMEBTx9pcEhqp+3J177AAFi4ibB+IZjRXHPlObrbJFyOBZ7n5DsNnYMMdFGKZQxLhY0ISxlaOQGhZZgDx0aUxVRS+zcWbq6zkTIYvWI1Ls5eWu1WPRL7NtxBBb6Kqq/CsvdxoPPfsqf053YaQuSGOFDOpP9damaIjPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9438
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f5a75ca7-8c37-4c4f-afa2-08de94c47401
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|14060799003|36860700016|82310400026|35042699022|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WmTASQlkMAddKgg5bTLAs4YZCnbd1inbRCxya/8P0NSbPnG50sjM6TUNC+O01AFCF+gHd/RwOLYqeIAaELRyBjorKjFygkKzZBcZOJCcDBWxMyiJU4+OdZMRM1KLpb1Bn3GCx9tMBj3EyJUpamXphBh786wW5QY8JEr5wxJ8wCnCc1ZT2aaVUfYhtcR0CFt1EWIkMKO4nf2t4NSSxfOX6nx179UQofWBjvm5rysGGWVyEURQq83+BEFw1wy4f3tR0mECN/3O/oDC535l0M34Ehp1adYrZT3oIk6NusRVB0rTcM5syueNfyhFq7viu273DYT6RBvR9ervKrvH+lIg1fry0Nvh79T0/R/Kpz7/AB1fMpZzaaNy+hHnhTDNKpbxRPpnMAax6XM9AaBOfKA+yZc4SMMUqwfNOcizcvVLfQvczE5iAtkdn9CZJxbHnRn8BaxdfN7kTUVNbbQEpsWmW3rp9L/GcaYQV0ZrNL14gIXP+gzdSOQy+Su7G0U2N477LffAuB2OcCvcV6dz2fwlNKH2nDfEVXSQSh8K8l21RjNIkKt1NSgqouE2JKRAUx1aVdMfWikNgCsRADUSxhhHAwXObiBAgO3FD8WophG9oGpXCtJaMnEE5HmJ37TJJItWekSESHQJy/4NsbNik0OcsyAwE7HgYlHNsKWXH7+ZArh9Z+DWZRymAW9O1qNg1wRl65DIOey6Fc9fj6hrXoU5hB5Qt0bJnANxGI1qwqtRQ9FfUOUPw+sk/oHL/vypPJAv9TpYUUTIIMyOANxeJDYncg==
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(14060799003)(36860700016)(82310400026)(35042699022)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sIE8ejQ8+srIgzlBBtft24+L27eRd2nAQ1V/akswzOJWQYiw9CURgkdKnZR5O+LT64binjMj79Ay1E92W5GqG+VtC3Uo4UsN53tMEXt1ceIHNNFvUBHY+0n0cxpswgvWfM6WVAydJNs5FcfRu69lr3mSNECaM4q6jtoqnbv6kwWP6UbpncsPnhi4usHbDy6nwjnv9DV2o1NRg1OYoXKt+fBz2ui1fuTRuFKfNz8CAi7KV48aEpp4nYibFDEr58m85l3FgdBFwbpJ6sx+fQ3hPAGMLbdeIduRPfzSk3q4/DzfvYv6V6QvCImHgPwGRvvh/PoRPUiN1WsVttDNqJsMuZzPy3p/LH79nQr8iB7SHbO6ZNUZO1ZcY3jAnYyAubF17Vf6W8H+S28Oj9dKF2ozbun1nCiDSGQS8Az6pXsGUw6f1Xm4XGvX7UGhrnbmo/e+
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 16:41:05.8175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39abb853-bf4b-45f5-473b-08de94c476ab
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10451
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

On 4/7/26 12:40, Sean Anderson wrote:
> Soon I will no longer be working at SECO. Update the mailmap to redirect
> to my linux.dev address which I still have access to.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  .mailmap    | 1 +
>  MAINTAINERS | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 6ac4b9b9e5e..337dcba5545 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -131,6 +131,7 @@ Sam Protsenko <semen.protsenko@linaro.org> <joe.skb7@gmail.com>
>  Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com> <sandeep.gundlupet-raju@xilinx.com>
>  Sandeep Paulraj <s-paulraj@ti.com>
>  Sandeep Reddy Ghanapuram <sandeep.reddy-ghanapuram@amd.com> <sandeep.reddy-ghanapuram@xilinx.com>
> +Sean Anderson <sean.anderson@linux.dev> <sean.anderson@seco.com>
>  Shaohui Xie <Shaohui.Xie@freescale.com>
>  Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
>  Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <shubhrajyoti.datta@xilinx.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c596971ae4..01293b23d25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -361,7 +361,7 @@ F:	drivers/rng/msm_rng.c
>  F:	drivers/pinctrl/qcom/pinctrl-ipq4019.c
>  
>  ARM LAYERSCAPE SFP
> -M:	Sean Anderson <sean.anderson@seco.com>
> +M:	Sean Anderson <sean.anderson@linux.dev>
>  S:	Maintained
>  F:	drivers/misc/ls2_sfp.c
>  
> @@ -1700,7 +1700,7 @@ F:	doc/usage/cmd/seama.rst
>  F:	test/cmd/seama.c
>  
>  SEMIHOSTING
> -R:	Sean Anderson <sean.anderson@seco.com>
> +R:	Sean Anderson <sean.anderson@linux.dev>
>  S:	Orphaned
>  N:	semihosting
>  

Reviewed-by: Sean Anderson <sean.anderson@seco.com>
