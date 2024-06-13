Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E364C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4BD8891D;
	Thu, 13 Jun 2024 17:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Z+mpu/bQ";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Z+mpu/bQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6202D88930; Thu, 13 Jun 2024 17:34:47 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0718.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F29488897
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=N6qPolyr6FGYguDi9/ykLz52fU6HotoDLGix4kLCccjPn0TedUMa/XEiAp+ZEQsdwOJ3Am03UnrBSR1J3Tms89NooqqV0K78bfO8C/0YRxrtIZqYg4zAlz2SIUu0QY3dXqkik8K/4RWl21a38K0kQ0dVY67tjojYkiVBaoavJg872rSGdFgUJnUJAyqjvxkzahdDUMap4SAFMiveUbZ0PsbXBwMDKx2jusdMtraS03r4eukbFzpd12WLrWq7/6YazCxeTEKqENUDAGXTTulx4kSOZ39mRfCbATmuWyhlF52OHR6auK5qn7zVlhwwpsOEzRSKfNi00ab1NOVUnpsfDA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4W8K53JmYV3A/5xHuqb/1EmokX6V6ybdOg71RkJ1u4=;
 b=cE1FdWdbq2OQ8q46bFrEOsLMqxPtRcIYvVxqGWJDwaXPGXfvgbhJVgtK5DG1YvK2w0+DgxisV1ha+ll9qwe1kd78ScqgwajBQSi7g4LO1Rk6mj4tbbOXSimi+2Naqg3Huz0UvJ0GNtuWP8qNQeK41NPiXobIQ+sOfqicU63CL60TGU5QO08MPMEg2gHqnnAUMRmuKJZOT3abAf18DDeDpeiOPQYeeHz3IwGnlxgmABDQgxDU9Z+2WeJwM1mdbysgoaEckr2WKVKS9zpIiBoxvgdP+TcIZ6XmHEr+qfpkthTGWFqs0Fa7b2eHbK0ei0eQRkt7Nf9Py1sVs3K5m5r7hw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4W8K53JmYV3A/5xHuqb/1EmokX6V6ybdOg71RkJ1u4=;
 b=Z+mpu/bQ2Yv/c6Yfa1vSfI6z2uZULj8JF/qxxPi256nY0PNvHFnhk0tus9DwJfAYdxOW4AHfjAP3qEGS7j6+/vJOkhNOJQzde/TTPux8IqdUSsSGoEHq0FKNEGubtlzZ+BYOsmy8jeObN9e9MQ6Izk7fZivX8tYSBTDOYzg8Yu5mfuGjOzyavVcbaQakadLtY5vbAbQ42F3lvUJa5meLul/C6K1dRFrNw6jUptyfsYVJDlBYBwvsm92eMYDWBp5e6gjpfYgk+dqT7ZmCNiy7+aJjn7eSwNtl6+LZ33KiHRNDI3MOXsIanhBmdQn6xlOxVTjl0z9Ep+QvMJID+ViCLA==
Received: from AM9P193CA0003.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::8)
 by AS8PR03MB7110.eurprd03.prod.outlook.com (2603:10a6:20b:23d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 15:34:43 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::e1) by AM9P193CA0003.outlook.office365.com
 (2603:10a6:20b:21e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23 via Frontend
 Transport; Thu, 13 Jun 2024 15:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Thu, 13 Jun 2024 15:34:42 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 8335720080F84; Thu, 13 Jun 2024 15:34:42 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.235])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 969942008006E; 
 Thu, 13 Jun 2024 15:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkNHyRRU9dx2jHJVAZSIIteKdOFdAD/4tzUSCTwPBYY+65wv+y5o0FAkJZwWcBRNExDdhRrzugo3L/TEN02Ep2RWYTkzZho1iYlbjFQzWITGKrahWjZ3ptHM0hhVFP0WajC41qYRJeRFvuGLPFQyWGqVWslx1v1ppvHBDrUYOZFUqdVb9XofSX5Zc5Zd38mqErtLyhhF8flBrXMSTLagsPforalmAqOsr+wSgWJnN6wNhMQp3aQRhxg2nNUWlTHtUaL2cBw5Dt3UHJyqWNjR0J4ZFeQabCiXuXwyJXLV0w4O/VuceDBcSGcj+0S6WodEBrrrf+yomrloP4XqSA3QOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4W8K53JmYV3A/5xHuqb/1EmokX6V6ybdOg71RkJ1u4=;
 b=Zl+5DN/islRDAA9EVp0eV7KCaYTp38rwJnFTCtfnwSY7tk4mgwsKESQcOaj14KPEGaz0Sl2ZVnvQy0jbatj3VPnWGGA9UubQwQfTszXOY3V9TvL6HPVRHoUpiOEHs/mwtSAMbnmFjR1lgHgWgSHuVitpIXUeic2HgryqsWq1hzOp6Tr5n6nOd6dZY8FgLOtnf6kwIcCVLtdA3n3xejvx8ZJju0v6MLqAjnPCNYpoVFB30+FwZOurhuJ2u3kbwogK+9Rt9ZErwUEERxRF7dwW8VqUyhlAGgI9noTJ9gdm6t7vS0u4zOlCmUpZ5ggP9A5jMHeOE55UvH+crmXahokgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4W8K53JmYV3A/5xHuqb/1EmokX6V6ybdOg71RkJ1u4=;
 b=Z+mpu/bQ2Yv/c6Yfa1vSfI6z2uZULj8JF/qxxPi256nY0PNvHFnhk0tus9DwJfAYdxOW4AHfjAP3qEGS7j6+/vJOkhNOJQzde/TTPux8IqdUSsSGoEHq0FKNEGubtlzZ+BYOsmy8jeObN9e9MQ6Izk7fZivX8tYSBTDOYzg8Yu5mfuGjOzyavVcbaQakadLtY5vbAbQ42F3lvUJa5meLul/C6K1dRFrNw6jUptyfsYVJDlBYBwvsm92eMYDWBp5e6gjpfYgk+dqT7ZmCNiy7+aJjn7eSwNtl6+LZ33KiHRNDI3MOXsIanhBmdQn6xlOxVTjl0z9Ep+QvMJID+ViCLA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by VI0PR03MB10353.eurprd03.prod.outlook.com (2603:10a6:800:20b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 15:34:39 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::3acf:6b06:23c3:6cfa]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::3acf:6b06:23c3:6cfa%4]) with mapi id 15.20.7677.014; Thu, 13 Jun 2024
 15:34:38 +0000
Message-ID: <ca425556-fdbd-457e-8713-5176f925cce7@seco.com>
Date: Thu, 13 Jun 2024 11:34:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: silent u-boot not working
To: Jonas Kvinge <jonaski@opensuse.org>, u-boot@lists.denx.de
References: <6fc28b7090833e94d47ee3abfce1b1f5a75d349f.camel@opensuse.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <6fc28b7090833e94d47ee3abfce1b1f5a75d349f.camel@opensuse.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:208:51::14) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|VI0PR03MB10353:EE_|AM3PEPF00009BA1:EE_|AS8PR03MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: e63c66be-8033-4aad-d76f-08dc8bbe58bb
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230035|1800799019|366011|376009|52116009|38350700009; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TkJtVjBkcFFSaHV4SzNuQjhXT2JwVHpVODNZSi9mV2wzTVN1RDZpS29kaHRt?=
 =?utf-8?B?YnprdDB6UDF5cXFSRnZUNHdLL2VUbTk2RkFYanVvR1J5UzJDUW9rSDFTTnlQ?=
 =?utf-8?B?WU84cEFNcnV4WFVzdzRCenJFZjUxU2hGVkh4S1JnRTA3YVlCUzFWYjlNK2NN?=
 =?utf-8?B?ZlRmNGh4WXEyc20xbmFGbm9XVXN5dUFteWg0YTNzanFqdU15QXhrR3BCZUxY?=
 =?utf-8?B?QUpHcTliS1NOUmNBWXR0bjh1aDlYMThnOE5lK1FsbWl6dXlraUVMVXY3a1FO?=
 =?utf-8?B?N3V4RlEwLzkxMUdEeUVOdk80NTEwL0FKcHdZYmlZQkNxeXdITld4Vkk4TVNP?=
 =?utf-8?B?VzFoalo4RUdJZnN5UWtHMVQ3ZXdMRmhtSHd1VVE5NzJhb3d0Q0RURzFtOHhV?=
 =?utf-8?B?WlV5bGtPWlduSjB3ZldxdG54bFdhdlpXUHRLNjllLzNTQmJiSjh3UEYwd1Az?=
 =?utf-8?B?a1lwaXJ5NC9mUEZVZFByVVUxWmV3M3B2enNEOFc0VEtLbUgwSmRWdHM3VzBE?=
 =?utf-8?B?dGZHTjRSQkdPVTZFNDZYbllJcHlJS2xIamxoc3VkVUpuUnQ4dmI0NUk2eTBN?=
 =?utf-8?B?UHhvbHRrbytjRjRsOFRqN1pLZGVIYkVyNXAxb08zKzhWZ1dNQW5URml6eWhV?=
 =?utf-8?B?YjhWbktNRTdHNFUrT3lwekc1OTY4UlcyQTMyeVEwM09EaTBEYXd6VVl1SnY0?=
 =?utf-8?B?L3A0ZlhoU1k5WXZvalVYQ3VYUFhKK2lvTElCaWhzYjBkN2Z4L1Erc3lTQkNi?=
 =?utf-8?B?MjZkOW5ZZmJiL0Ivd2dPQThsdEhWRFBQRHh1T0tyV3hESmRMMmVheXU0N0Fh?=
 =?utf-8?B?VWlucE9ONXpxRnYyYjNmUWEvVko2WE1zVVkzTmV4dGpWdG5KeHBGVFRqVmVK?=
 =?utf-8?B?Uldoa2loaWFmMHV0RlE0Sy8ya1lBdWNDdWovRFU1R1o5aW9YY0VXYVdEU2Y1?=
 =?utf-8?B?YVlwNFF0aTRVYTBwaFplUnFENm96VC9NamFGUlZ3ekRDaHY3TlNHTEd6aERq?=
 =?utf-8?B?VWdwcHNrZ0hEOEFYc240d0ZINXNpT1VNQkNMamtST2RHemdiQUdySWpSV1M0?=
 =?utf-8?B?UEdYbk1mOWxrK3pqckxxQ054N0wyNmtQQ1ByMzlIZWxrK2UrZDNTbHRENVQ5?=
 =?utf-8?B?TnV4WVJ6cmlvNUtJUlBuWFZsWGw0UG1jOVc3RmRXRmhUTGVBdTQ0elpqclMv?=
 =?utf-8?B?KzhUUkZISzZWazBEOW5yTlRCZjM1SGR6bTJvVjRsUjQ0NUw2UzNYZUFCdzFG?=
 =?utf-8?B?QmwySkFUWXNJVHA4U1lBTFZjb3hTZHpCTm9iWTFHMk5iWU9zNUtjUUlaaEd0?=
 =?utf-8?B?N1ZzRGFNcENqejJ6bHE4aE5yR0FjejFhVU54Qm4zKysrMFdtb2ZLbnl6NzJT?=
 =?utf-8?B?ME0vL2Z3QWlNcWFQQjFZenpjN2hGQ2pTS2NtUG12WkMrT3dpU3NxeXp3T3k3?=
 =?utf-8?B?cEZyVFpjeTVkQ2J3UGROL2pFT2ZBWGRaSGlSenEvNkFwa1JUSC9yZnJvZnVK?=
 =?utf-8?B?U21nMS9XeVI1RDBBcWxJVW1lNDdaQkF1K0FEdGVTTVExYWRNQ0F5bjVld3Uz?=
 =?utf-8?B?TEI1aDhldEJNN2Ixd1pHajM0UldEalBYU2pqSnlQR0x3MU1hOGdXVkQ3OEQy?=
 =?utf-8?B?bC9wREdYS2tsbzMwbTRmMmczWnhmN0I0MGRGTlFvdWFrNTB5RHZFVmFBL1Az?=
 =?utf-8?B?Qjhvdjcza2JaYWxEZ0dHVzBTUFpWWTJYRkRZYUNRUEN4clZHSDk0VVlTcFI5?=
 =?utf-8?B?SGpmcU01OTcvSE0yb1JKWmtJR2w1ek1RN2hkVHNrOGpXeS9DVmQzcVRpNUtI?=
 =?utf-8?Q?BnF7FbIMYnkqcpqXHRaSOV+/oATsBO8MKR9HU=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230035)(1800799019)(366011)(376009)(52116009)(38350700009); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10353
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2f154da1-b577-4c72-5f85-08dc8bbe5648
X-Microsoft-Antispam: BCL:0;
 ARA:13230035|36860700008|82310400021|1800799019|35042699017|376009; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bENJTkd0eHdlK3dDM1dBZTB3bzZ1RFBmelBnVWFLaVl3Unk0QmpTa2lDQWM4?=
 =?utf-8?B?dkY1VGFSOExZdmF3N1c4bnR2UnhWaCtQNUlBVEcwTEF1Z0I4SU92b3BtUXd4?=
 =?utf-8?B?cjdXY25hajhRQlgrSEJyWWFJdVZBenBKK1gwemExaGhGTmUza1lwSHkxZmNy?=
 =?utf-8?B?S2QzSWw3dTYzUVdBS0VaelFHLys2SFZFTG9tREN3bHFhK2xvWEd4WGpaVGRV?=
 =?utf-8?B?WlBUR1NRQS9SNGRnbjZWRUQwUGVZOTVxcG5BSWxzakp2WDZ0bnZaZXlSYXVn?=
 =?utf-8?B?dzk0SDBXNG1jbVJabGRUU3FrWGp2VndmbXdFN3NLM3ViTk8xL2pXQjBMbUp1?=
 =?utf-8?B?K0NTZTVPN1gwdGs5NGRSMXVsck5qSi9zUDdMcWt1bUdTV2RmOVN4V2p4akdX?=
 =?utf-8?B?MFJjRzA2bVREbi9NVWlyS0Vza1BpeTlwaGRZZWhnL1ZrNEVKOEY1ZUs2THFI?=
 =?utf-8?B?bjhNWEJCenpPbk1jZlFPSm9NT0FyOTZtN0N2QXdmeFFhdkJTS2NrN2dUYmhP?=
 =?utf-8?B?NHIzVGdjRldtS2oyK0pINWpzTkFZcnozOVlMN0FPYm96Q2ZOWUZmSU9QSVd5?=
 =?utf-8?B?aDlKRlZMNngyOFZqbUZtaDlETFdsR2tSTjB5UU83ZkU1eTJNSjJTcXhSOEsw?=
 =?utf-8?B?czZsdCtRM1BpcURCTEQyeTZRUEdmQ2dvVldVdVNnOW5tMDZOclZNaEdJLzlM?=
 =?utf-8?B?aU9CbDFIQXZySm1pdUVyWXNKMkFNUlc1Zm9WTld2K2U4ZFdBMVRtbU5aY2gr?=
 =?utf-8?B?N1hsbnJ1TUxjRkJtaUZvYVlsSDhjUnpXektXTGRXUFowRzVCRUxMZU1VWkFk?=
 =?utf-8?B?NnN6Y01tSVN4UEUzdERXK0djd2p6TzUvVkYwaXQ4VWVpS2h6V05Sa2NtYm5P?=
 =?utf-8?B?OUFmamdMQmF2bGNLZWFNbzNZaHE5VXdWZFVnRHVuOFVkcDk4MmlwUmVxQXV6?=
 =?utf-8?B?NGJ1ak1kbFhMUEF4YVBScUlSVVF0bFkwMlp2K1Z4eEtaWWJoQzBBMzRsZHhB?=
 =?utf-8?B?SkU0bmk5OVdxdGxkN1c5UGd0MnhXMFBqbXNlOVlzUURjWFRud3ZUMkJrOGpq?=
 =?utf-8?B?b1ZtOFVhQ3Q2ZGNKenpwa2c4QlQyaEViLzFOMzJLcm1LeTZhaXhOUWNFRjJD?=
 =?utf-8?B?QnlNUUt5eDloZkt2c3JaMWdINDh1RnJGUFNxem50OFYzRDkwR1NHbUpZcnBG?=
 =?utf-8?B?Ti9LYlNhdGdyYnlpQmpsbFlkV0NQamJBdGswQ2lBWHgwUlNhZzh3Y2VwZmFQ?=
 =?utf-8?B?UWlYelZ5OXJXdVI4Z3hTYmZjWXhZV2NyaUtERDBXNFhHeGVOS0xWODVRczhF?=
 =?utf-8?B?bjdiekhCNnZtWVBtdCs5cVpKS3NVK1N0cEd5cS8ySUcxdk1xejlXUW5iTWxW?=
 =?utf-8?B?SGxWZUZxNm5xRGMyODhzL01TMDFmYktBUzA0eGNTY090RXFiVWZBS25TNkJJ?=
 =?utf-8?B?Lzh6M0grNHdPQTlXeGV6c25oeFBTU1NlSWo3dEMxczlvTmsraitCQW5VRCtV?=
 =?utf-8?B?MmZiakNVQUV5a25ha1FjQ3FPOW1jYVhqcVp5MmlZWTM5OXE5QVd1eXFPT0FX?=
 =?utf-8?B?a0w2d29Jc2cveHJLSGhXSzBVZVBNcjJXUXNjcHFCTDhydGFlaXVveEFiOUI4?=
 =?utf-8?B?cGNWclhYdGhkWFVNUUhuSVYrOXVrWVp0NkpXVkowNHQ4bUxNcXA1emdoYlNU?=
 =?utf-8?B?KzZ4SUxKSW9ranNwemUvRjFqMnhKTkpJT0xBQTZ6czZxNU16ckZ3UGxjSXM2?=
 =?utf-8?B?S0FHaHVaZzZCdldPWXZ5dkFFbU10WHpxMjBHd3ByOEZTOEF1S214NDdoUW9B?=
 =?utf-8?B?Z0xqSHVhZnczRVNQb1BxeXlEUndZek9HOUtvNGVwY1ZIUHE1TVd4Z0JPSUV1?=
 =?utf-8?B?LzdKUW1oeFU3cmc0MjZXMER6bkR0RFNVblNQa0NSTE1Ibmc9PQ==?=
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230035)(36860700008)(82310400021)(1800799019)(35042699017)(376009);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:34:42.8051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e63c66be-8033-4aad-d76f-08dc8bbe58bb
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7110
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

Hi Jonas,

On 6/13/24 09:16, Jonas Kvinge wrote:
> Hi,
> 
> I'm running openSUSE Tumbleweed on an RPI CM4, I'm trying to silence u-
> boot boot messages, with the default configuration there is an u-boot
> logo on the top right corner and boot text, I'd like to get rid of the
> logo and all text if possible.
> The keyboard is not working before the Linux kernel is loaded, so I can
> not interrupt u-boot and enter any commands, so where should I put "set
> env silent 1"?
> 
> I've followed the guide on
> 
> I have built u-boot from source using `make rpi_4_defconfig`
> configuration modified the configuration with make menuconfig, and
> verified this in .config before builing.
> CONFIG_SILENT_CONSOLE=y
> CONFIG_SILENT_U_BOOT_ONLY=y
> CONFIG_SILENT_CONSOLE_UPDATE_ON_SET=y
> CONFIG_SILENT_CONSOLE_UPDATE_ON_RELOC=y
> CONFIG_SILENT_CONSOLE_UNTIL_ENV=y
> 
> Copied the binary to /boot/efi/u-boot.bin and /boot/vc/u-boot.bin
> 
> I've also tried to define CONFIG_EXTRA_ENV_SETTINGS in
> include/configs/rpi.h according to:
>  and rebuilt and copied to binary again, still not working.
> 
> The text and logo is still present during boot, what am I doing wrong
> here?

I implemented a silent console recently. Here are the steps I took:

- Define CONFIG_DISABLE_CONSOLE
- set silent=y in the default environment (CONFIG_EXTRA_ENV_SETTINGS)

You can still enable the console by pressing any key at the (invisible) prompt.

Let me know if that works for you.

--Sean
