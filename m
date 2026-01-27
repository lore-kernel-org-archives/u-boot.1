Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372A3D2FED2
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 19:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E81284164;
	Tue, 27 Jan 2026 20:04:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="L47nsvXJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Kos35NI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 362E38416E; Tue, 27 Jan 2026 20:04:46 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C7BA84148
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 20:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=WxnngxpNZgf8CgB6/JVL+WifSZRJYB8OI+zf0ltyY3J28w8DCWuqBtjZQIMZQFeBo1JqFUmvrrYgxT35TtiGwohvfW60QzgQcPcj6VDiLzMjhvRofV0X9T9RbuPR6ewubkpKNoopPFVcFGDBej779e2sfIq5NUULpqzRZ+BqaXWfKDHl+zM+Xh3Oz9xhYrq+LaFjJThGrkTVxZZ0/db21+1rJDgPzAEbzBXZaUtxRjfhCNhte70fKH0rBAY0Ysz3pPSQNVSzfZ2Bk+fFPOiUZY+4KHYlWSf8lsndJL2dsA1UOCDGIo5ae9XyUpJNVPwHAKDuGor5j1hlYA10/dheFg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL8jRNUDCpNzPEUdrZM+5zUfsAZWc0vHH5NhlfEftBE=;
 b=bNPg0ImdbnVt1awK8xVgHY3gWjW2HTjh5DPhE7UOW2kWfoN2amMv//Xj4T86jH1077WtWXr1oSi+HVNfxBAO7YW4j263kCots+IJEhWRGKsQr1gDdpBJLp/AGJz7X/827Vr/8gUveUCM2g4xib3L3E6KhL0XOiNAdvk68qnVjCz4RuQBm7NbElDUnYE7+dzn9tFmNKAOok/1XinDvQdzXsrtPHrv1bXfh1Bu7em2Q9518Y6zNBHL6w10dLqW2twSKCfhlR/SFGPFXiemAk2Fi5ooj6taaHvIFtogDPC5AeltfRunz6izCArfCdYrvjHUYsh5ajz43bNBC/nmDRPKCg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=analog.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL8jRNUDCpNzPEUdrZM+5zUfsAZWc0vHH5NhlfEftBE=;
 b=L47nsvXJYencnWfRj+hk23fBi7LygwdTe5zQkKGDRWCHvPLClMHBzXIze//aCmYSUYTaRhLj3rmMVKUHZWoUEBzyBx75ec/c9PabYEQROZm5MGbE5w10vtxd7RDGEBapADkxQYvgIBrTn59WjxvECgmFxQxWVkx1E2HcX+MdiZSJGISZpSxtSBjraARm72zfr1OyxlMxS/mXq5N1dpW3eloM85w/QxEYnE9pWTzjjLZNZAkTAamXJejhAbfu7c6xenOEw6z8i/maRRm72femSaNZMCj0tv2+qL/DN6FMRvmw/AEq+dPeQEGq2WzH62FXf4YeobUk17GjCAglCQOJWQ==
Received: from CWLP123CA0014.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::26)
 by DBAPR03MB6391.eurprd03.prod.outlook.com (2603:10a6:10:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 19:04:40 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:401:56:cafe::27) by CWLP123CA0014.outlook.office365.com
 (2603:10a6:401:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 19:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Tue, 27 Jan 2026 19:04:40 +0000
Received: from outmta (unknown [192.168.82.135])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 EC036200800BC; Tue, 27 Jan 2026 19:04:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (unknown
 [52.101.83.139])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 7944A200C4FE5; 
 Tue, 27 Jan 2026 19:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYbk4lDG+pS/9SbWIGb/4zVRW47cOJjZDz1i4FwjXYZENA9NLmTYGEIggedAYQJ9wME9McWwFwJPH0PfHmywRWt7qkExeSUANEX0jIrA/DS4MceG3TN9vv5X5oFxvgQO7ho3N2YhO/g9UIQZ7hnz8QdEMgYwgXMhXQxapyzBgojmq48su7iLvTKY1svJH5XXId1lK1YMPwiY6RuLgFKXPrp83oD3WWWQlir0tBxoDy3isBL1K0NX4FDdNnJWIeUTqXQtAALdyP54RJB5gUK2JHhansm6oAdAMCLdS4+WPudKK8JhLLr3R+a+JJTz4/cyub7qmAVQeZsGokBFGxEv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGpgloANM6/wOXwDGPzfgRIBgIxMsEOdMTL1Q2in4Ac=;
 b=VcIpmltgeo9p7iuiNlseZMD+0xX+xfGHIXLh5Zrz6TXDM8j1c5DXvk4AIuq435/6DXn5FdavSU0FD97bmphccj9AaUC1L6YeYZFwbmNcLb6BTG3r9AZHIc36PCiHkmNs5l2F/95fDbMunWY406c7nWKDZLB6aDHOuF33YB85ro+ryMcuMv10z4lvKM0xvpqqwollw7d0mfks937zEhE81mJEZdp4GcNEsyTxKS0d02AwLpzDdC9b2LKRUIpYugpDx8oAfZ9z8uNuK6smKt//vD/6wJMMpD37BBepRXxJ0hWghEW37Q+A5Rke+cAi/mV1OtqKDGVz3df6P5yYLDL82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGpgloANM6/wOXwDGPzfgRIBgIxMsEOdMTL1Q2in4Ac=;
 b=Kos35NI+YLWY1hQgLZhvaDHx8NvwxZhe7i+K17J9nUcF4OieHq6qeE3qCIb/2dEQXa/q0dwrd8UYvn8m2umhE499SKsz9A5VMtEWTNdePNQ+vDAyjHReKvuOYnOR/KlkbYvTNKiGjh9eviklpssCdyQLf2nM3bLrnYrS7Hx3x2sC+CHiDa/7p2kXQGfgBIUqnICo94Lfw5occqUs217v2WhBwmdo7RoIlEW/wJUfWNbfFiH9bmFDkajo94AJSOPnHuXgfDQuGal776RKNKXq5qlCWodbqQcvobYUPq4avnW4HqN6wE3anQX2BX8QTQEHf+8nhs8DjzlT43tMbS9WOg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PR3PR03MB6586.eurprd03.prod.outlook.com (2603:10a6:102:77::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 19:04:35 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 19:04:35 +0000
Message-ID: <545772eb-dec4-4228-9f7f-e20b6f5677f6@seco.com>
Date: Tue, 27 Jan 2026 14:04:19 -0500
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
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <79af3d2e-7948-4610-9b8e-69aa61e5965d@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|PR3PR03MB6586:EE_|AM2PEPF0001C709:EE_|DBAPR03MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 491106e8-aa5c-47d9-dafc-08de5dd6ec3e
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?TXJKclBsNklMcDV0cWU1RTFzdXJDSldIcnNCVGhFTlhvMWpGZnJkS0VydUdU?=
 =?utf-8?B?WjBXenBMYlBlL0RGNHBuU1dFQ0dwVjM1K2lpV3RKaTJJRG9nbkF1MDYwVE1R?=
 =?utf-8?B?WElGMjZWY0NYQ3lWMFFwRnhiQWZxOHpjVG1jTXRWM1FzWU5sMGRTOWgwMlFV?=
 =?utf-8?B?bVNLaWM0Wlo2VzhXUlJRT09oS0ptcVpmdndxZXFpRUdXQ0hpbzRoUEFlYUhu?=
 =?utf-8?B?c3FBL0FCUGZ3TDFJUjliL2I0REhDaVA0L2ZZMDBpYnlvUXZHUm5UVytTdlhF?=
 =?utf-8?B?UnQ0Y1M0d1g4MzE4WHFIaXFPclVyMks5Rlo1TEd5aGU1K2ZNSXNvVUFCTG9T?=
 =?utf-8?B?TkJMZk0yU1JxWmtUSUZiOFU3YlpzUXgzV0IvYnZoeTErY0kyRUxMTTN3Qkcy?=
 =?utf-8?B?SStreFE4SkRzWHVvbUplaERpb3hMb2JrREtCS1dwZjlSWE90aVFMUFZVQzFk?=
 =?utf-8?B?MEpjRWZ1YnIxSGwyN25xWDBicXQvbEJjUkE0RHp3REtiU0QvYm15bWhzNXRp?=
 =?utf-8?B?M3pKQlErM21zM3VtOC82TGt2ZGNhYUFBMzBGd0Zrem0wSitvT0JIcFIrTnFh?=
 =?utf-8?B?WVZoYWYyVWRKbnEzWjRYOWYzTnpqNUZpRWNQU2JBZWlrcGZqb3J2T2FOQ1hY?=
 =?utf-8?B?WHBFa0QrSFREMVdrSjhUaS9kbVpHUUZYWUFVSURtclBhNDJaQmU5THJKUGM3?=
 =?utf-8?B?dXE0YmdDYk40WFBsWWc5eExDQk5xTmJpcEcvNWpOUklBWW5uYlBWRE5jMlZI?=
 =?utf-8?B?K0ZOYjFuYkswYkNpTTBndXJncm1CWGVDam1obW9BUFJRNnkrUGUwMHJSWWdE?=
 =?utf-8?B?L084TGNvWkdUU0c0V0dZRlUwMlk5VEd4eDZiZWFxUUNVajlVa3RTNTloUUtU?=
 =?utf-8?B?dGZTZnI4anhsV0RoWmE1aHM2Ung1RkRiODFrTEc0ci9zMURCQ1VnTnAxR1NH?=
 =?utf-8?B?R1pCbTIxM3FEUDZmc2lBSlJCalFXOGE3UXFxVjFac3ZUY3ZvNmxHK0dpTU1I?=
 =?utf-8?B?UkpDbnFPQ0hzYnp2S0cvaWFvelZLQmViUXhuTHZaK1Zvd1ZQVm9ZQWgwdzdX?=
 =?utf-8?B?d1dMYWs3Q083UU5aOHpqbUhVTFNnYXBQRzk0MU8xT1Y0Qm84Tk1UUXV2RldG?=
 =?utf-8?B?b0J0MUNUMjNPYXVDVUwwakZ5WjVwVHpxS3FTTU53dERGaktrMnUrczlmS2RP?=
 =?utf-8?B?UHhwN3Bxd0dUbHRXWFVqUzg0OENUVTJndGRuUVYxUEZQb04vUUtRdGhWMit3?=
 =?utf-8?B?QlhFUXptNjBOc0puS3FsRmlkc2krTFNWZ0luRE9MeldsQml0WnN0OXlvNHkv?=
 =?utf-8?B?Mk5zMXhySUhaTTZkRFhEQSt1REgvUStlSmtITkFPbEE4cllLUXRLMkx0Vk40?=
 =?utf-8?B?WUVPTVk2dnY2TTVFandvM2dIcnRQZlFPdjIxRkFDU2xjdmNFWGpLMklIOWJj?=
 =?utf-8?B?cTEySDJoK2FDUm5weG5PdFhWbW9GZlU1VGpabVQ3K1ZrRjkycmRPOVRKbWhi?=
 =?utf-8?B?WHJZeUh5ZXBkTG5sVHJ4SDZqMUtaSloyYlBFRWthTWdCTlFqM1lzK0dwSXhr?=
 =?utf-8?B?ZXM1em1rc2RhZ1RkdjYyQmsrODVpR28zdFB0YTBtYlNKWTZoTldwV213SUFW?=
 =?utf-8?B?dU0wYTA3b1lVdG10d2lRaFFGNEJjdEthakdlOXo3Qko5OVh2NmczZ0o4MitM?=
 =?utf-8?B?ZnhURkRDZWxPMmk5aWQwcFBHQVl3NXFSV0RLVFVLcGw2ODJVeFlQaHNPcytr?=
 =?utf-8?B?amlXTjBYaFVrUm02NjFZa1lFc2hBNU5pWU9SbVd4ZFRsUmxWcFlwTm03T0R0?=
 =?utf-8?B?TEdsT0JZMExoUjFpUk1HRERzd3RkcjN4WGQvakFTbkhFeUdMWTRVL3pmTFhs?=
 =?utf-8?B?L1llZ0tVZktpaitmSUQ4L01PczhGcnVpOHF1Uk1vdktDTVVqUnF4a0psOXJ3?=
 =?utf-8?B?VkJVQk9tYkh1dnlHdTdKRGdubWNQcFFPZEppWVpvUWVVTEVJZUZibnh1a3Fx?=
 =?utf-8?B?MnpXRU4yZVZkbVprWHhXRldSYkg2bzVuY3lsZDVpRUkvTHUwZUhzVm90M2F3?=
 =?utf-8?B?RVZENVZTRW8xVXRhMEVzcC96dTY2bWw2Y2RsS2JNNDMreG5MWllJK3hJbTAy?=
 =?utf-8?Q?7iNo=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6586
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3ac074ea-3361-4c5e-1bd6-08de5dd6e952
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|35042699022|1800799024|14060799003|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vmt4aHI5c1hKSlVPZHpVdFViRXhadGFHMVIzSjBvZjd6WEpaM0o2RjBWaE5x?=
 =?utf-8?B?Mk95MTVaKzVRVC94eDVsNjFPeHdJOHE0NFAzenhqRE5HT2NWRlNHcEd5QWV3?=
 =?utf-8?B?dE5wV2x5SUplWk93UHhqaGRvMUdOdjF1blRqc3VMSjgxQzZHNlFMYXd1OEtY?=
 =?utf-8?B?UkxMNE9LcjU0K2VQZ1l6eG80aml5d1E4Q2FscTc2VjdXekZEOHNwRmEwUDgv?=
 =?utf-8?B?UjFrSmRPMnJSV2x4dnlBWFJrZUdvRll3ZVZqU0E3anBWUTBacXVrQTJjZzBa?=
 =?utf-8?B?b05Kbko0Sk5vcHhMeTFua1p1OWk2cjJyQ1NXNHp4UlY3aHRFSWFSNGlYRFhi?=
 =?utf-8?B?RndXWGVPWmt2SlQwOHc4eEZHdHpYMC9SYXkvVUtjdzZFRDQ4MnZLbEt6OE1Q?=
 =?utf-8?B?M3ZTWEtRa3hTRHZPWVhXOTByYTlxM1lLZUFMRUpwalI1VzVLNUdKSk1XMDFl?=
 =?utf-8?B?MktiT3R5RFpzcGx5eFJyNzR4K2U2SHFtTVF1SDRQWDdLVmhwT1Fua21zZXBx?=
 =?utf-8?B?NjNETmRQSkN2TVdyVVJydmF1ZkZGYW1WZEpRZUtYelEycHdMSUd3d2pLTm4y?=
 =?utf-8?B?VkZPSFpsWHZMSzNqUHMvSXlsQzVlMlFsM05NejdURmZHL2RzU2lNQU9zMjJn?=
 =?utf-8?B?YTdBV1I4TnpndTVUYnFGQ0JGTGFCVWo1QkpmaXRCaWw0bVVIa3cwbStFUHdN?=
 =?utf-8?B?eksvNFIyNnM3MEZFS2M1WkhuYzBNOHN3OFNFSzRCYmY5WkQ0TDJuZTJ3emlG?=
 =?utf-8?B?dW9yQjhlZkM5Wi9teUFQZHBRdDk4cEtIS1R5cVpWUG9DSGVSaVpDa3VnbHl1?=
 =?utf-8?B?WkgzWG9Xc0lVYWptNjFpTi9JNGRjZklLcnZKNmRsdnIvOUc4Q3hrVHk3SC9M?=
 =?utf-8?B?Rkl4ZkNJZnM5dUprUjBYeklkWEIxcDVHeEp5WUpGdHdyM24vakVIanR5bndD?=
 =?utf-8?B?SVhDR1ZIS1JFWHVEbWhwV3czcU9NSmVlZGZ3NkFESHdUK00xTk43SitJYUJ0?=
 =?utf-8?B?U2VBaThFejM5alVJTndSN3VTMURLZTRLZUs5N0lKa3NEbFA1RlYvWWNmQXV0?=
 =?utf-8?B?MmpsSk9Ud1I0OXBPMjI1VURBOFgxdjVRRjFzQktLRlBLT1BzdGVsR0FWL1FG?=
 =?utf-8?B?N0pHazZ5S3JTM1Njam5CWFpjcy92V3pYdTRrTzdkQjlRUW9NL3lIcmlMY28x?=
 =?utf-8?B?K2xZK0UvOWtWNlo4cjdtRmpwbW5XZEtQTWRXck9CdTFJdHRSMXp0Wm1PSGtR?=
 =?utf-8?B?a2YzbnJUaFFnb0dmc08rSm5uSllYNmk0cWlMMGF4cDhocEtqeFZNa01DSGpk?=
 =?utf-8?B?bTc5OGc4Y2JySEMzUEN2VEVjV1lGQnVOY2t5K0FoZWlCUnFMdUZUMWRTYXd1?=
 =?utf-8?B?NmgrSTloOHZqUEkyTEVmZmQ2cWxIREdjdnZEMHhxSmJuVXdPSWJuMDdkRW1O?=
 =?utf-8?B?aHV6dkZSVm8zcTBWbUZPTDlkQ3diTFhRdlQycUhPMWtrMlk5TFJtbG12VTZI?=
 =?utf-8?B?ZlpmbTRsWWxTWmV0WXYwczBoMUEwM1k3SVE0NXdjY0hZTUVqSTJFdU5EaUJM?=
 =?utf-8?B?MTh4SExsZnVSNTJhMTlnSXJ1QTBUSmR2T2p3MisyVmpjK0pFSnhrVTYxRkFj?=
 =?utf-8?B?U1lRNXhONjdaYUc1YTZ2NXNFUXpOMmUvSStvWk9qYldjZnhLRGpZQUpyem1t?=
 =?utf-8?B?RjN2Y3N2bml5emFYb3I0RkIyZUVDcCsxYmxXVDhRME1uNTYvZC9zL2p1NU5o?=
 =?utf-8?B?ejMrM0lBVTlhbHNRVWJoUldKNkVaVE9zYTZDUzV3WjdGNjBIM2JZWWUwSGRC?=
 =?utf-8?B?Zlh3TGxMZTluUFlmVmZLR2FubGFpWGZ1eWI0djJwYjN0U3A1TERlWFk0d0xx?=
 =?utf-8?B?ajBrMWlodXlMalpobDltZkhwcEIwVmRwYlhCZmpWU3ppbnpvQ0gvb0N0cGNE?=
 =?utf-8?B?QmJnQmQrOHR6ZjlBUmpDQU0wemhrUUZGQ2lndVhZOHJFNTJpeEdkTCs1NXJz?=
 =?utf-8?B?c2svVUNVNHd4TWNsRFVuMi9EYWZ5cFVXR1F1MGQwTnBPeTBoWnNKT1ZKcVRG?=
 =?utf-8?B?TEdrSXpCeUNwY3hVQVJOQjlyNlZ0MithdlNGbFNlOFREdkpOWkNPVDVvRGFl?=
 =?utf-8?B?dW01RFVhU0hNRWx6dEcxcnZjeXFTQ21uSTZvZ1R6cFhUOTlmdWI2a0JHcXRD?=
 =?utf-8?B?aUs0Qjd3TE1lTHkraklMMXlhcktZamwrVGM0SmpaZ0VRa01Yb0lyOFRPMkgw?=
 =?utf-8?B?SlF4UlF0NzNZUThKUmtodUNHNG13PT0=?=
X-Forefront-Antispam-Report: CIP:20.160.56.82; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(36860700013)(35042699022)(1800799024)(14060799003)(376014)(7416014)(82310400026);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 19:04:40.0648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491106e8-aa5c-47d9-dafc-08de5dd6ec3e
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.82];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6391
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

On 1/27/26 13:52, Marek Vasut wrote:
> On 1/27/26 5:38 PM, Tom Rini wrote:
>
>>> No, the check in fdt_getprop is only for the name, not the value (which
>>> could be arbitrary binary data including many nul bytes).
>>>
>>> I think the assumption in most of U-Boot is that the provided FDT is
>>> trusted (or at least not maliciously ill-formed).  functions like
>>> image_get_checksum_algo read up to 6 bytes beyond full_name if full_nam=
e
>>> =3D=3D "". It's possible to read off the end of the DTB if this is the =
very
>>> last string in the strings block and there is no trailing padding. If
>>> we're really concerned about this (e.g. to avoid false-positives with
>>> ASAN), then we should just add (say) 16 bytes to the end of every DTB
>>> when we malloc it.
>>
>> Yes, we rely on the sanity checking in libfdt, which I think the kernel
>> also does.
>>
>> And no, I'm not sure if we care enough about all of these corner cases,
>> but if we do then I'm not sure this right here and now is where to
>> start. It should start with upstream libfdt to see whatever cases aren't
>> handled, and then what cases fall on the callers to deal with wrt
>> security implications.
>>
>> Because I really, really, really, do not want to block fixing booting on
>> some large number of boards because now we're going to depend first on a
>> security audit here.
> So back to my and Sean suggestion:
>
> fdt_string_eq_() does effectively memcmp():
>
> return p && (slen =3D=3D len) && (memcmp(p, s, len) =3D=3D 0);
>
> So do this and be done with it ?
>
> type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
> if (type && len =3D=3D strlen(FIT_TYPE_PROP) && !memcmp(type, "flat_dt", =
len))

this is wrong it needs to be

type && len =3D=3D sizeof("flat_dt") && !memcmp(type, "flat_dt", len)

and it's exactly the sort of error I was complaining about earlier :)

--Sean

>   align_size =3D 8;


[Embedded World 2026, SECO SpA]<https://www.messe-ticket.de/Nuernberg_SHOP/=
embeddedworld2026/Landing?code=3Dew26561753&returnUrl=3D%2FNuernberg_SHOP%2=
Fembeddedworld2026%2FProfile>
