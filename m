Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61938D2FEDB
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 19:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9AB84172;
	Tue, 27 Jan 2026 20:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Bn3qMuCr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="RsGIoWkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8660084154; Tue, 27 Jan 2026 20:26:33 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF95C84172
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 20:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sDcFA/f6aPLCITQL8vZVmdv+dXOjNAnD2VYC7CoKteGP7pF6LRL2tGrGTlVPNk5QZi68CbZyJRvistf9/yiKG7flZ+jdirxREkrI6Uun2tMU2Ym2Pwl5KSzYi7UePvpf0aMs0wALx2oGvkYPMYGRzdrflv6HB8ByzNTRpOEuHLDY1XrvoTEW01Tf/E6m26A+e/geI28g9OQH30MgWPbl1YWBaFpu1ksIEDNwlSXK4dJd6CYCam79Nl4wjXDTU+zchRgakbtqk9YbmcjQ8hvPDVTsJNQs1+HWuTnVw1uKlJ3jkwTtI3mI3ILjOs8ysPeQeIVDmh4znmjBdTFxNHGReg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/PmlIkJBCt6EZ/FE5P09qais4pd41jyJDh4lXbJWbc=;
 b=dlPZ2nefbltGF+/xboaBa/+NTxaeiqjIFvYGaE1v83sQpjvcydP3wkR3KHIvighJLYtvqZksfMh/FaH14jQlV7watKm/Ccp4+y+VRyiay28XZ2EXxy/f27r6AgpWppHRsF4EjaVAeW4WWBFLYxhofwfkFIJTxt1EBXvVcpZDf9qw8tn8CL6e88eX1w/RBN/+8zYNMquNS3mCwIn62fRSQZ2WdF38Begm+liIk8pTDDW9XcAdEhNIG+6P5K75qbVeRylSRD/JyXPfjqwNWykxYjfFpyCuE2szh3+hG5olD8e2SOKotAX0pd5hWh6+62fqt7O6iRF8oMGODgflmni96w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=analog.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/PmlIkJBCt6EZ/FE5P09qais4pd41jyJDh4lXbJWbc=;
 b=Bn3qMuCrsVKeXD7/sMECe1itmQMVG/1GKDxmfyU44V50fSQHZr9Aw+RvKdhfDnOT3/AspLw0mxXZN9DZx4u80RpX4rogHyV9G3AI5qRq8AFxVpDfekmuwvwA+T7I5Q6wWIxhnWo0tAODEV2uPWmNrlobYRITgETnUIgJzMHz42t/ewbJYHi5+Naf5thwcPx+BNkuMuZSNPTXbMKIz67S6xi5cuzFfckVzNQFQPakDhwtSjtxumbRm/BcntrOnQX6eaa/WrEQ6uGOCmRVrkv/2wVPdTmGmpUcQxsDUnHwFQIueWCMwlX4lw0ROzQyLiab3x/cHrcgX/853vfSKanpSQ==
Received: from DU2PR04CA0340.eurprd04.prod.outlook.com (2603:10a6:10:2b4::12)
 by DB9PR03MB8821.eurprd03.prod.outlook.com (2603:10a6:10:3c6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Tue, 27 Jan
 2026 19:26:22 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::d) by DU2PR04CA0340.outlook.office365.com
 (2603:10a6:10:2b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 19:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Tue, 27 Jan 2026 19:26:21 +0000
Received: from outmta (unknown [192.168.82.137])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E1C6F20080EAF; Tue, 27 Jan 2026 19:26:20 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (unknown
 [40.107.159.134])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 89E0B20081261; 
 Tue, 27 Jan 2026 19:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecg3xynq0Ow2I1jw3XQHFmNQAfKnBGnMX2wO2UdCbItVlGqrE/Ieet6R2Wuii/tZ+4ZiOmiOseoep5QT/1NQMKm5/FfQOY24oKSW50xvxnD34PWds3VR1xekqdmFmxv6b7HI1BwBnA1a4UGux6D4qq8yyWUcLIVDyk/ZG9QeH6xN4h2G6yBboUrRI9GWt1dsCje1PgfnamaUAvkkMHNO55Ay7UVqSSMNLPdANZZPOl173TlHdGdMs5TqFVCTKC1HnoUqasp0G4mHm/ZZM9e5C11QzihLgBR7JTLIalLgjN6yQ78336xL6moN+IGEUgfH+3m+zuPJXLA6LIQ8DPYDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fFt+DO+z6z4kywwEfCta2F4junaHW4h1+hj958om5A=;
 b=wo60aKn89zZCIl+41mFGqo87sM9tNI6PZ7cZ5sqs7lsA5nyKz6J26ML3GUTsWQi03rD+MwsDfieTKxpNTNuoDJX6BieMe1E7sEJ60rwAunI6CyM81NkAt8NuzMxuilas2BxTdjdH9/bBaK/bN+0Ajj7x8vhAcTqc0GMSnBZq74w2ms4g0PhN/AmAbs0CUlgw/t+Z/S19O0LvcSjRUCVVYTAifLmMo0L2PHwun1Smld3oYv0NHhLS51eZyyeHRD1/XBc3GcmJwzgxNTHKBpBBF/GgeunGdKhry5wo6coWIkB9qWbPCbv+5uqzwxpFLcZA6RaTvsEJ5X7hAfBW/07rAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fFt+DO+z6z4kywwEfCta2F4junaHW4h1+hj958om5A=;
 b=RsGIoWkxk5T2tjaYxStPZqwH/Qa5K8ci/0nc2xUXylOjpQGzF3H1XvKYVVqMg0sOMj8TZzQDMusvBwuV8BzGHIe7bOXDoP6WIkvq87T9EGJFhRpKhajcJvmdL7J24qI+F+bpLTDe/e3or+aFEIO2br2/GZ98CwFAkmtKznu74oqA28EDDwsGyYKPrcPoMyQ2rYWuemfnf1wNt2fH8kLVLRXMqVNaLI2N8lj0T8QfinLvuB7ATIa39fGNWMRlF+RzxvX7qIqgx3P9Ymmim4SP+IPevnUIH+sGqwUoKyWHiPQ6Y9b6shAC4bicQ3EzKS9UgapoNu4EeA5oofeoyr7hfw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DB3PR0302MB9062.eurprd03.prod.outlook.com (2603:10a6:10:42a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:26:16 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 19:26:16 +0000
Message-ID: <63d8c6a1-3ffe-4bfe-bfe3-d6973c177452@seco.com>
Date: Tue, 27 Jan 2026 14:26:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
 <20260126225842.GY3416603@bill-the-cat>
 <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
 <20260127160637.GD3416603@bill-the-cat>
 <b09e8fbe-1f5f-445a-a28b-ff6386a728a5@seco.com>
 <20260127163844.GE3416603@bill-the-cat>
 <79af3d2e-7948-4610-9b8e-69aa61e5965d@mailbox.org>
 <545772eb-dec4-4228-9f7f-e20b6f5677f6@seco.com>
 <afb132fc-5658-40e2-a0f7-f7a5dc96688c@mailbox.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <afb132fc-5658-40e2-a0f7-f7a5dc96688c@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::20) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DB3PR0302MB9062:EE_|DB1PEPF000509E7:EE_|DB9PR03MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: fb616c9f-a6f5-4aa9-1d1d-08de5dd9f3d9
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?cDJKNmpsRTNldVZSbENqWEhsUVdPWGN3NUtqc2RneDd2QjM3R1JWdDJIdW1V?=
 =?utf-8?B?NjYybG5uVE1mcyt4TExwRlMzMjRLbThBbzNHak8rb3E4LzFOblMzeldMYzRu?=
 =?utf-8?B?Z3AwdldENXRmUm5YeVUvME5mQjlGSE5QWDgyemRXWFpROFpNcW1MWUF0NUEv?=
 =?utf-8?B?bDNXc0pTMnc4Z0xZVXBXRUlYYmhNK3RqSXh2V1g3dHVVdnZ6SVEwSVRRWUdJ?=
 =?utf-8?B?ZTJ5bnFsdVhhQVVOOWdmUjhOWWoweHVlMW5ycXFGNTRNSUpBV21FRWJ0VE5N?=
 =?utf-8?B?WGpsV1gwdWVqUUFBSUduL0dzM2ZsbGJ3eGpibmZwWlEzNnZtbXY3Yk50aWRY?=
 =?utf-8?B?dm42ellDSkpUU1B0engxUnB3WVlrT3g5WFhpWWcvSVJGQnZrSzAzOUxPaEFw?=
 =?utf-8?B?SFVTR0Y1UUhZbXgvbTRseHg2NmRmb0pncTJGelFoREtKaWJRaHlKZDdNaDU2?=
 =?utf-8?B?VGY2Z3lIcGtoQS9wcGxwaUZkUk1JcmJmK3JFSnRnSTRxU0ZtcFNMZHBxcWor?=
 =?utf-8?B?WTZxT3JjaUMwQ3VLSVNxd0lzOGVTemRhRkh2N05rQ3ZlOHRxL0xFYkhibDFB?=
 =?utf-8?B?YkF1Ujc3b0pQWjZPbWtMY3FWOER2NjdEMzEvNDAzRUV2VDllcXByR3MrTFJo?=
 =?utf-8?B?MXRCeWQ4NzBzQkJyeWRLNTd3Y1RNTXN0TVh3R3dVWXcrUkwwTC9DWlVxdzV5?=
 =?utf-8?B?bC8zRG9tSHhZcy9ET2lGS0VyLzY5b1ZScUlRZHRKM3lOYkxIZ0VYWFVCMVZx?=
 =?utf-8?B?L1h6Y290Y3F6eDJHV05hZ0NsUDdmR210cld6OExTdmVnd080RW9MNGJEN2VP?=
 =?utf-8?B?S0RMUm5ZNHBqZXFManZ5ZzFuaG5TbTUvUzZLK2J5blh0azhhRlVLOTRBbW80?=
 =?utf-8?B?ZE4va05id2gxU3luSjNOcTlVbklvMFpiYVp2SXZNUHlMbExCMXFXcURqc004?=
 =?utf-8?B?cm9nSU9JOExoUnZpaS8vd1JtQnVxbmNLZWdrSWpmdzFFaFFES1JsSkJnQmpY?=
 =?utf-8?B?YkdyUVZrLzRpTUcrMFBvWVhUVnl5RG85alVybk9ibVNKS0gvS2w0Q2FvQTJP?=
 =?utf-8?B?dHRIRDVndnZRSzZnaVJuU3VFS2NSaytzWFNZTXJXdnM1NUV6VUNPaTJaOXFU?=
 =?utf-8?B?d1BBMmp1MXE0eEs4T3NIaENMTS9UaTdrTVB5Szk3cGxHYXExajkzNWhZeVh6?=
 =?utf-8?B?dVd5SlpONWlDbm5TM21iQ0JGcnRtSGt0bnZnWjR3cjBJblhjd3c2M1Fjd0tT?=
 =?utf-8?B?blAzdlRQVm8xQ3RHcGk4Sllud01uekJxcm1CVUhsdGN1dXh6Ymd0aGJ6MGZF?=
 =?utf-8?B?MW5XeURKVmVCdVcxaG9sQ0VHS0Z5MGNvWWQ0dFQ4THdONUxUcG41aURXa0t0?=
 =?utf-8?B?VC9VOHdZTGVLeHNyRmh6WTk4dUNwL2wyWEhJdFhiV3BCc1VzeWxjQ1FHTmUz?=
 =?utf-8?B?d0VMMHBCdGNKemJUYjQ2SHNBWVZQYkIveWJsVWk3TlhvdEFmTUZzS2FyTExO?=
 =?utf-8?B?Y0kwbVhacVpaeko1dTBOMFBLMGFyQUg1T292cWlCeVBMUzZmMHhFazl0eWpr?=
 =?utf-8?B?NzFUUlA1RDZzbnA0VzduRFVTWFEycmo1N1Z0TEVhNjRlejFJTm5EaGprOFBw?=
 =?utf-8?B?Z3lsc0ZxZDBRRVpReXlUNTZ6R0E2UVN5RjYwZkJLVlFwNzlBU1JKM0htci94?=
 =?utf-8?B?dTAyVjdCOUttbjZRbmI0cFlxNmp6ZHE4L0huOE9iaURLUTNaOVlYWDJ5M2VN?=
 =?utf-8?B?T0EvbWpKSFY1ZEJPc1N0NUJIeEQyUmFhc1l4K3BYcGk1bUxUTFpNeWM5ZWg1?=
 =?utf-8?B?bHArUTBiQm9SWWJyd3d6TFQyYTExZHJ3TDhpd2NLMU1PZjFBVW9sZDA0UUNS?=
 =?utf-8?B?OGxnSmdabjM3a1EydmhwNEJodnE3M00ra2srVGxhVlBUZlJzSFVETE5IQTgx?=
 =?utf-8?B?bGs2cVNZczJKemJ2Y1E3R0NGazlqRmxkTUQ5ZTY4bWJxSW91V1hFdGpja1hH?=
 =?utf-8?B?VENzWnNuaUZGV0VvM0c5R0NqUS9FLy9MNVlab2VXY2Jld2REL0FTUTFyUUdp?=
 =?utf-8?B?aU5yMTI0cHFuRVVEUUVrTzVXQ2w0UytJTlk0dHlhaC9hSW5OaGRlY1dac2pn?=
 =?utf-8?Q?N1nE=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9062
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c5bd23f2-0960-4dda-874d-08de5dd9f0a1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|1800799024|36860700013|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0MrUnlmK29jM3VhK2NCd1hPa0R6OHRwcTJlNURXT0UwNEJtVXhXZkFIWXgw?=
 =?utf-8?B?U1V5MFN1d1JQR09WWnlHWlhpSTAzUHYxRmd6Q0tjQlp2dDUyclBNMlJ6dDg1?=
 =?utf-8?B?VDZoVUVVeEZ0OHI5TEVadzlMOE9mc3NiSXNseUx1emtvb0dYaFZqOW1PYStq?=
 =?utf-8?B?QU5ENzhSQllIZmNaVVA0azJWejQ2RDdtQytqZEJrSUlaaWlDRWJ0TTYvc0lC?=
 =?utf-8?B?OHQzRVBaZEl3SHo3UTZTQ1dCQ1JYa1dUT3pFbWpLa3l5NDgrdWZreGVQSGlr?=
 =?utf-8?B?WEZCZThrK0ZRYUEvenhjMU9EUkx0NlFWSlY0VHFUWFg5Y3dUbGZFR0VkWHM1?=
 =?utf-8?B?STFROFBDTXgxbERPZ1ZSZGwvMmpwWlZwcHpIbXlxREdaQ0RpSWxoSGU3TnI2?=
 =?utf-8?B?TG5rQ3djT3VaUDIyYXhnMXVNYTdEa08rOXd1aDlhZ05jRTdxS0NlM096RUwx?=
 =?utf-8?B?dmZpNzZNeXBVeENCaE5Tck1OTng5aXVYR2Y5VHZMeWcxbWxwRjhzWXczc2h6?=
 =?utf-8?B?elBNUTA1cG9nTGNMUHpUTjVxMXhERHBTbEgzaytwNVlYc3paVmdpUUhTYkdt?=
 =?utf-8?B?UnlMalp2aUFNOTNHaTl4ZlQ2WVdkc0xZanVNTk5NbUVwN2llUVQvOUNic3dD?=
 =?utf-8?B?aEN2VURCTlBZUVlMaTFwdFRLY0ozOU9abEFaWkwxYk45VHExODBpRjJNQm9v?=
 =?utf-8?B?eW5MejIvKy8xOTZiZWNDd1pTWCtmT0pFRE9Tay9Sck56dk04Zi9XaEZQZGQy?=
 =?utf-8?B?clI5NFdNVHJnYjRKVUd0UWVrT3RlS0NkT20vUGd3L3hTVzIyYXZRY3VORUdi?=
 =?utf-8?B?bE5Gam5QdGxTQVZKUWUrVS9VVGtBRStDZ05YWEwwOGF3VHUxbVVEWnRZbFpZ?=
 =?utf-8?B?M0J2dERxMDV6WnA0WUFxMHZMQjdBS2Q1OE80UWFRSXlTWGN0MDNmUmo3VlYy?=
 =?utf-8?B?Rm9EbHowbHpTaUZoWGRralc0ZkQxWXFMU3NiT1NGVjdNMGVvUHcvdzAvaElU?=
 =?utf-8?B?T3dLT2s4QjFaMDBVd2RQWEhHTExHZXdEWm52UUVnTjd3NVhoM2FSb2xKYkxk?=
 =?utf-8?B?S0h1d2dKK1BqUHV6TExkWVBMU3pmUzBMSG05b25vbmxjdkMvZ0pWK2N0dFJq?=
 =?utf-8?B?SjFMYUhEZ3hXTFNHSDlvcEpORFJEM2ZqVFc1MWx6eUxKSXhBRHJVR0cwdExn?=
 =?utf-8?B?VVVETXVzL0MwS0RySlVhcTdOY3dGMC83bzNSMS9ZQy9rajB3QWN3YVFVQVA1?=
 =?utf-8?B?cWlsL0Vrc3hqS3pLejZLdWFWV0szNFhOenpFZjdkMWdtQ2xWRWUwNTJtSTdr?=
 =?utf-8?B?M05mWk5FaDMyTjYzSm9qajd6VzhmRHYwR0xKWURXVDVXR3lUbStDbmxmUnVQ?=
 =?utf-8?B?Z2hJOTBGaEE5cVZmSkcwUmJXK2x1TnBVVXFhWURyVWs1ZEF2dE9VeTZjdU1t?=
 =?utf-8?B?STRaTHUrYWZzUU9aTUlrSFBrMUg3d0g5ZzV4UlFQMDNMNjRQREZkblhvNFlB?=
 =?utf-8?B?RWVqanRzQ1I5NXBrcWF6aFFJVXdlSzZieWNrS3pLTUhmVjdVN0RBY09GbzBt?=
 =?utf-8?B?aTRVdVNpU0RHQm14bU9WcjFLeDlDM2RFWjFaZzhndTE2TTl5cjQyU2hLMFU5?=
 =?utf-8?B?SWtTMFo1MlYxaWRVR3piYWY5djVXTFByN2ViL2M5WDZQSEZ6TUZEdityc0o2?=
 =?utf-8?B?YnpjYUNSTUxSVDJHOVZuRm5PMkJpdUp5amVZQ2Jja1Z6RURlWlYzREpoYXZY?=
 =?utf-8?B?NUY2dVk3SHRSVHFuQmlVakRWcUlDbUthVTZ6TS9wVXYrZU9jVlBVR3RiWUgz?=
 =?utf-8?B?bSt5RS9MS1BISkpPclZRTStWaU1WSTlUM2tyZ1d1M1pTNFg1RU1PUURyd1gw?=
 =?utf-8?B?ZFd0MENMK0p5dnFsNUl1QjFKQXhMZjFjMzBYZzZtVHlXUnB5M2YxMTRwb0lm?=
 =?utf-8?B?OGprckVjZVppM1IyMEl2UlIySE52SVE0Tnc5N2FsNCtoU0FOUXlqR0dKUjg3?=
 =?utf-8?B?Z1JhM21xR0I3VDI1VHlDdEFaRThKd1JVLzZMYXd3ajJ5M1ZmUU01RnJzMmRN?=
 =?utf-8?B?TitjTTdOV1BDalU5dXhubXRIVXNjRjJCV0ljOXhzNnI4c0k4bGFCWnF3TWxy?=
 =?utf-8?B?UTk5UWc3UHhmekhySU1jSnN4T010VDBFNVlRSWJodE9QNjR3N2toN0pNYWd3?=
 =?utf-8?B?RTJBVFNKd0R2OFcxMUtYOEt1elpIT1RPd09TbnRkZkxFa015WWc1RlVZT2pH?=
 =?utf-8?B?OFN6bk4xVnRMb3RaOC91VmdPOHhRPT0=?=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(1800799024)(36860700013)(14060799003)(376014)(7416014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:26:21.2634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb616c9f-a6f5-4aa9-1d1d-08de5dd9f3d9
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8821
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

On 1/27/26 14:13, Marek Vasut wrote:
> On 1/27/26 8:04 PM, Sean Anderson wrote:
>> On 1/27/26 13:52, Marek Vasut wrote:
>>> On 1/27/26 5:38 PM, Tom Rini wrote:
>>>
>>>>> No, the check in fdt_getprop is only for the name, not the value (whi=
ch
>>>>> could be arbitrary binary data including many nul bytes).
>>>>>
>>>>> I think the assumption in most of U-Boot is that the provided FDT is
>>>>> trusted (or at least not maliciously ill-formed).  functions like
>>>>> image_get_checksum_algo read up to 6 bytes beyond full_name if full_n=
ame
>>>>> =3D=3D "". It's possible to read off the end of the DTB if this is th=
e very
>>>>> last string in the strings block and there is no trailing padding. If
>>>>> we're really concerned about this (e.g. to avoid false-positives with
>>>>> ASAN), then we should just add (say) 16 bytes to the end of every DTB
>>>>> when we malloc it.
>>>>
>>>> Yes, we rely on the sanity checking in libfdt, which I think the kerne=
l
>>>> also does.
>>>>
>>>> And no, I'm not sure if we care enough about all of these corner cases=
,
>>>> but if we do then I'm not sure this right here and now is where to
>>>> start. It should start with upstream libfdt to see whatever cases aren=
't
>>>> handled, and then what cases fall on the callers to deal with wrt
>>>> security implications.
>>>>
>>>> Because I really, really, really, do not want to block fixing booting =
on
>>>> some large number of boards because now we're going to depend first on=
 a
>>>> security audit here.
>>> So back to my and Sean suggestion:
>>>
>>> fdt_string_eq_() does effectively memcmp():
>>>
>>> return p && (slen =3D=3D len) && (memcmp(p, s, len) =3D=3D 0);
>>>
>>> So do this and be done with it ?
>>>
>>> type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
>>> if (type && len =3D=3D strlen(FIT_TYPE_PROP) && !memcmp(type, "flat_dt"=
, len))
>>
>> this is wrong it needs to be
>>
>> type && len =3D=3D sizeof("flat_dt") && !memcmp(type, "flat_dt", len)
>
> ... because ... ?

Because the check you wrote is equivalent to

if (type && sizeof("flat_dt") =3D=3D strlen("type") && ...)

which will always fail.

--Sean

[Embedded World 2026, SECO SpA]<https://www.messe-ticket.de/Nuernberg_SHOP/=
embeddedworld2026/Landing?code=3Dew26561753&returnUrl=3D%2FNuernberg_SHOP%2=
Fembeddedworld2026%2FProfile>
