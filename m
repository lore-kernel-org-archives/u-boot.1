Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6ABD149F3
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 21:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC8F88F68;
	Fri, 25 Oct 2024 23:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="u+Igrtws";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="u+Igrtws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427AA89016; Fri, 25 Oct 2024 23:14:32 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A9688B23
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 23:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KGzk2G6NTrnrb8DIIf5ZJHlvcTx+5dxXxY29KStTFfmqZ2WDrcqK5S1aib8VYJjDInQ522w4CXBCvosEKgP0aDy0LxZWmtrBtkITbrz4hJ5xUQNssjlc+K27vucvjnYcdnfHrRIPBPLnBUn1KupkZtByrxAC1BKa9lomQaPyy7QEjdRyosSBwwoZxO/s4BIBQqwD5+7hqZm2FRzQr16NJJmCNmXSUXnjfEJ5iEdEsaiLxki74Y59zhNyJwrmfgBsl2aYmkf2IwS4CFmb/Ecfa8ZSo1V4xMSwN4d19r7DNT3JFsqT8AP6gowmNg8QYnqkl9LHdvL4lNfT9d607/QHKw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1y6EhAWhBQdsvr10X9XWLgEXosBsNMKJb435+kbArw=;
 b=stDq3Ub5lrvCe0EsOS08dZlHSVc0TfaNbMTteSh7aWNNRU9EY4hfVhTlo7GrLHkjI0yE+o29tcLudpEYRXVR60/uIz1FG7jk+894fHZc8fL/mK3/4qZmMKyjCNBkK9zQuRpKFhmmFsd752gEyI1EeIVmiqttJHXWyw7BlK8dBuwfqVOC1stWQ83cmFBWKQK0rAAqvv1nkynfWBPvJc6ADfimWWom3kIYh8q+WLHv/WIIRd8uD/yG4xUF2W41yH07QarHeZ4bcD9lmUa89WXNsManX+Lze/nT0k7/wo224ki9efHDOMD4jNohgo6jhL7oT9c5i7eFw+KitpYCGKrg3A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=chromium.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1y6EhAWhBQdsvr10X9XWLgEXosBsNMKJb435+kbArw=;
 b=u+Igrtws88KvTlslYeYBECpxrQc5dMhiJA9zwwoO6tmv6moyt5u/mShVmNpgVNPomRsZpSqZd4u3s/vwCuL25afLsA9QnltFymh2TUalAaO3IKTeoqcKer9qmn0s2o6yFLWsOeF4mWzowJxFAy7WSoTFD3k7l8tRtUv5iGd40nnkSSzds565bBEZQCg5u+s5Gnq6J3tG4C6JEtTp6epv6uUYNFDoaLG4zug1ZsxzcSeS0AGMinI6oYcnao6SNLdb+VbTSWtzP4jNkXTMT1veKvAujyByWq6d8/r/5iUaBmKfJl1vUtEhiqJRQH5DtYmgHp6QawZl28eij7JvC3Tmrw==
Received: from AS8PR04CA0069.eurprd04.prod.outlook.com (2603:10a6:20b:313::14)
 by PA1PR03MB10626.eurprd03.prod.outlook.com (2603:10a6:102:480::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 21:14:27 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:20b:313:cafe::21) by AS8PR04CA0069.outlook.office365.com
 (2603:10a6:20b:313::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 21:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.14
 via Frontend Transport; Fri, 25 Oct 2024 21:14:27 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 5A56C2008009B; Fri, 25 Oct 2024 21:14:27 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.30.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 92A932008006F; 
 Fri, 25 Oct 2024 21:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mf2IyHTbD5ybLjMyzHJPEpwwFosGmwMZWYM+i6Hdu5DKK1WiQPOyoPT4QdotMH8KUlJxWvvVfqpHz3d/WR0Ew2KKREq2O+eQa1LovVZNy0fYm4mi0ZdTt/DXjAPH+ZUjAWHsMgsV3U1eRSDbquIjJc5G/oT5wwp3teK6OehG3ytKewM7jYhPSEakH93aRL9zmKXJb68YB2WXcpgwhLZIyYuAqOS8UHZDKffKwoLkY8lzWvVkjPT77G5WVZnn9klJVWQok4ROelGaprZPtNgwkpslRtSs31XuLKVXsElwNsin/IFPOivCaZdpqOrkHTlGvMW0irQyXnod+7sT4yQl6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1y6EhAWhBQdsvr10X9XWLgEXosBsNMKJb435+kbArw=;
 b=SwrGGGeXdZdfAvMaAGGb6kJ4e3Ho3bllyRg+9lK6KM1uVKvlPzQrKHuBwvMgvQmLeExa29gwEIesl77/yEcMse1zzps1j8/+AKjGZ/tOkNWvqXfzG7Cyg++jVU61MOkOFOiTfitHOD0YO8VzQgLAgnsJKFYR88fmLf6mcpbVlPWXLAT8aCdVfaPcsOdvX94H6s/JxRwHjczveeD0DHGUtuKHmUEDpMi20MzwBgg6rHe5EN2Z3fw8QT0GDQbz77AQNsmUcnS8rjV/JbenAOp18CPb/gc9l3sojaBWa9P4/a8iSl5/sGVOpn2KI85z4C+MFb3IXMNdXvTAu73vCO9HtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1y6EhAWhBQdsvr10X9XWLgEXosBsNMKJb435+kbArw=;
 b=u+Igrtws88KvTlslYeYBECpxrQc5dMhiJA9zwwoO6tmv6moyt5u/mShVmNpgVNPomRsZpSqZd4u3s/vwCuL25afLsA9QnltFymh2TUalAaO3IKTeoqcKer9qmn0s2o6yFLWsOeF4mWzowJxFAy7WSoTFD3k7l8tRtUv5iGd40nnkSSzds565bBEZQCg5u+s5Gnq6J3tG4C6JEtTp6epv6uUYNFDoaLG4zug1ZsxzcSeS0AGMinI6oYcnao6SNLdb+VbTSWtzP4jNkXTMT1veKvAujyByWq6d8/r/5iUaBmKfJl1vUtEhiqJRQH5DtYmgHp6QawZl28eij7JvC3Tmrw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by DBBPR03MB6892.eurprd03.prod.outlook.com (2603:10a6:10:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 21:14:22 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 21:14:22 +0000
Message-ID: <7c6e4d11-a49d-44e8-8424-9669a87de073@seco.com>
Date: Fri, 25 Oct 2024 17:14:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: FIT signature security flay
To: "Lev R. Oshvang" <levonshe@gmail.com>
References: <CAP22eLHhOnBXh-E5BDxLN06T6W1EsdUq4x4hfB9+rC4pDiMwwg@mail.gmail.com>
 <79fd246b-f5d3-4d6b-b8cb-d109dd135988@seco.com>
 <CAP22eLFJTw-Aggq7TKCAc67NCJjLbc-H92F6+pBxdre3LCnyqA@mail.gmail.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <CAP22eLFJTw-Aggq7TKCAc67NCJjLbc-H92F6+pBxdre3LCnyqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0153.namprd05.prod.outlook.com
 (2603:10b6:a03:339::8) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|DBBPR03MB6892:EE_|AMS0EPF000001A2:EE_|PA1PR03MB10626:EE_
X-MS-Office365-Filtering-Correlation-Id: e3548ee0-012a-47c6-6c65-08dcf53a025a
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?Q1FsMDQ1NTNDRCtYMXBCRG5udmFWWTJmd01ja1JzdHZKZXVNN1RaN3dvQjNv?=
 =?utf-8?B?WWxzQndtMzFIbG9Qd01zR1R0dmxUWmJCbmdGUGF6SUxrZXN6NmJJSlJTTlpl?=
 =?utf-8?B?ZVRPMW91ZmxBZzlTNHpRUDIxdmZKTWF1eGI4OFhGR2RGQklrV2V6NkhFeTlX?=
 =?utf-8?B?dmJRbEdWUTZaYitDRGJpaTdvdTNFRU90SVFqczl5ekNoU0kzSGpkakN1d1pu?=
 =?utf-8?B?MXdQS1ZlTVBRandUekVIV0Q2RU92TWxheGtxczZxUWgyZVhnb2ovaGNSdlh5?=
 =?utf-8?B?RmpXODBxS1JrQWQxWEJONVk2bXdvQ2NwckJVcGNVeVNTT0Jsd3BHUHRia2Yx?=
 =?utf-8?B?eXFadjR5UGtnaDg5THJVS2orNE1lRXA0TkxhN0tqclZodWk2ZEJuRGZVWjZr?=
 =?utf-8?B?NVQ1RGZzditRL3Jqd0dQWWZsVExkY2pzc2k2OXovcUVvRW5HUGh4UUNhN0ox?=
 =?utf-8?B?a1BXVjUrSWtnNnJhSmJpcXFHWEpJSXRJTmxHUllLc25TaVJIR2tjUm5wSTNC?=
 =?utf-8?B?NDdEZWFBQjN1ZzNVVmVJUWxLZDU0a0lDUlBaWnkzck9DRk9sVTZiWndEdnJ5?=
 =?utf-8?B?OTJhMzR0MDg0eEh5UlROZG44LzZWT0VHcEluV1gzOUJVdTRSajJvTHpGbm1L?=
 =?utf-8?B?bkdnQkozeEU0dEV0bis2alFqNkJQWDdNek0yaHRQZWtFOXBQVjUxWkRzMVcy?=
 =?utf-8?B?MUJRcktDT2pPcHp3NXZNcXk1dHVBMWdjdXRFWUg2YldoNGdXdEtLcVY3Rlhy?=
 =?utf-8?B?eWROV0NaR2g0dUF1ZkxHUmg4ZGtVZTBaeVBmaERhaklPTm9hOHJnYjFrNUNV?=
 =?utf-8?B?bkZvY1c0d1lTcGxoaVQ3VEx3aEZOMEVHNmpZc0NOQUY2clFQaVphcDNaS2NK?=
 =?utf-8?B?K3lTMHhTL3BPRVJRd2FNMEFnV3NBdERPQk9RaXVWa2ZHam9Yc29RK3MzUU42?=
 =?utf-8?B?VVpUUkVXU1dEK0xNbzZSU3VSZU9OZlFtZ1poQkx6OFJRWEdvcW5saDRLMVF2?=
 =?utf-8?B?VmJmdThIdXBoV3dOL0UxZllDNTMrQk1EcUFEcDN5OUl1ek5FR2pvVEZ3Mkly?=
 =?utf-8?B?azNiN3hKS0sweTd0VURtamlzTnBKcUdMc21Hbk1aTUhwVkt5bTM4TVRMWVp2?=
 =?utf-8?B?WThVMVlkcGcvUS9xdmllUWdlblJHamY3NjUvL2E2VnJCN2lQRGJrU0dYTDho?=
 =?utf-8?B?VHZsa1F6MnA3UzJid1dNNVZoV29ZTFZvaWJMazhJc0ZoOU8yaWFPdXRQcjFw?=
 =?utf-8?B?V1VjdGRrenVCNHpvcEFsMGRHUDc5MnFzWmtROEFaak5pU1ZGTjJoeDJNTVMx?=
 =?utf-8?B?Z0xubVpacWV0c1JTb1lTR1B5Uno3RjViK1E3OWRWYXNtNUUvKzgzY2pvQ1dI?=
 =?utf-8?B?SFpnQjArb0JxUmJOdnJwUGRNak40TWVjNGUzWDlKMDhBd25SK3Q4STlBRCs3?=
 =?utf-8?B?WlQrSTg2eGJnK1NqRVVlNVNCQ1U3YnJqdFNGRWlFK0Z6MHpYRU93VXFsd3hx?=
 =?utf-8?B?WFpGQmxJamxjblplcXlUYXVVWXFZQWFkR0J3QWNrT3paTkxSUGlKKytiNTY4?=
 =?utf-8?B?TEZTakk3ckhLVkpkSTNrTERkZlpLMXRXMFUzMGxzZFVWMGtkZXRSSXh6eW81?=
 =?utf-8?B?QThvYnlVbFRETkJOOVczZ3pPQlZXeXY5bU0yVXFVT203dWtkZGZJOVlKNnpz?=
 =?utf-8?B?NktKdFV5K3VTaVpmb2ExcHFJQmh2UmRxeFlYNG4reDVzTkpBaGM3SExwQzl6?=
 =?utf-8?B?ZFZ4OWF0VTErcmdlUTQyN1ZEU2pTSG9peEk0ZVgxWVIrUWFzb1hoSGVEemdF?=
 =?utf-8?Q?nQuhi36gv0QA3t+pvkLYTUesMSyGnPazuSwmc=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6892
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 54880152-05f2-44e0-b26b-08dcf539ff42
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|35042699022; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlI4RndwYSs5RXgvT1NBRTc0YWo0cTNMUjc4bVZFdUZkbVNGamZrbTVBbFdi?=
 =?utf-8?B?cU1rVVJQQmZ1ZW41RUdWeEUyOHRzdzNvWEtDME82T0NzQkVXWnNnek5leFZD?=
 =?utf-8?B?cWoxVzBrN3pJMUl4NVlaV2dnZExjSDYvRlpxSk96aS9UZUt0THRNa05qM3U5?=
 =?utf-8?B?TnZKQVJ0azhtRkhVWnhrTC9LM3o5eGlsb3VmVTZobzVNZEJnVE1qczdTQTB4?=
 =?utf-8?B?dUxsZkYzVitlUzBGT0llVUM0Y0FyeXRsdFliWjNXUTV6S3lNbUxkbUZOcnBs?=
 =?utf-8?B?L1BtZTlScGFtV0pPZDB0MG9IYjJ3R0x5SVVqYzRYOHg3NTAxQ0ZXYWw5NEpw?=
 =?utf-8?B?NXRZR09kQWs5VklWbWpzRkhRTSttYjNZRmVWYmZIWHdlUnZFa2JVdlA1dW82?=
 =?utf-8?B?ZGRYYU9uSkhLeC9XTVJkb0N2NnBickl4UEJiYUJIcDlCYkRBdXZjSU9hZnRi?=
 =?utf-8?B?T2pYNS8rUXpRb1RwcTlYMDVmTlFRdnI3dm1vZXJNVmU2V0RtTEsyNU9FeU92?=
 =?utf-8?B?TFBKTmFpWm45REwyS2lwQ1VqWkhJV2VvbWM5QjdlWTlEVVI2eksyR0xwK1Bz?=
 =?utf-8?B?Y2Z4Z1FpcUtYb2c1SUFCT3p6OUIrOGZaY0lraUF1RFZqdkhkWXA1emNBZUhx?=
 =?utf-8?B?ekUvZ2lNbXN0WDZZN0U5YlcwYjZhdmJQZFNBc0pDT2VkcVlIampJTC9BZXJj?=
 =?utf-8?B?QmpVRFRJYTVpTnliUXBvTGthZEVUendkcnBqMDBHell1S2lvY2taYi9RS3FH?=
 =?utf-8?B?NFM5M3dPTFdKNFhkdmVEVlE2NGxxdjdBTXZvMTdLc3Ura1A3M0hVRWxKTFBT?=
 =?utf-8?B?MnN2VzBGYnltQ1lUYnQ4WXQzWTBFUkRRRFVFd3ppVUlzUXFGS3VGaGl2SjBM?=
 =?utf-8?B?V0dxb1R4SW5UUXUzNzdqbDlZK3B4alFjaWJ0YlhZeWZWOGNVQWZIOHlDVXVa?=
 =?utf-8?B?NnVtZUx5SnRHOVFoaXdjZnp4dTlTVUVQWGhRS0FrODkwMldkNEsrUW9IemJj?=
 =?utf-8?B?ODk4TkdESE0rSkcrQkNoZWloSXNWSlhOUlFONkRrd1d2SllzYU9aeFhsRzRn?=
 =?utf-8?B?Wm1BNThBT05LUmExQ1Q0NDUrc3RuYVFNMlF2VHY1Qk5ESVd2R3ZOL3JLek1J?=
 =?utf-8?B?cWEyaFMvcW9BWmc2b3RzUDIzamI2VkVxdkM0OUFCbUlEQTJkN1R1bHNpRndC?=
 =?utf-8?B?ckg0bXJkQXl4TmUrbFQvL3hPM05vVzVkUUNMMUtlWlkzdjZ6cFkxcU1wMmJO?=
 =?utf-8?B?VDRseWdWc0xiZjJEWjVvUWpjRWQ5ck1WU01WSmI2TGE4SnZZWFlWZnpiekNX?=
 =?utf-8?B?QkRtc05UL2M5ejdBbXBHNUZtWmJmalBtcnBQTEQyZ2dBdWtkd1orOXJZSXh4?=
 =?utf-8?B?MjBzWHdZSlNvMXpiT1d3NU8yMW1zZmxmL1pWdVRxamJ5cmlLQzNKNVE0ajlo?=
 =?utf-8?B?MnFGWkNiWVZkMHc1TW9sN1Y2K255OHhKZlprUWNyazQyVWhkMDBHTTNWcVRY?=
 =?utf-8?B?Yi9aUnd2aVk4d1hVcUk4VWlNc1NObFVhRzQ0ejR1YjN1Z1JIaTZHKzJpMm1J?=
 =?utf-8?B?UCs1TjVxQW9QQ2R6TGZNd2JVQUdERDZjWFlpSmRYOUM4ZHJHRWNWNzhCdVVu?=
 =?utf-8?B?UFVzMnoxWGtoeDRlRElidUNGOVA4M0NvUm5pWm5Jazd6SzBSRDZNY1Qwa0x5?=
 =?utf-8?B?QlJINzhUTmk3emM3NDNITytqaHNpNWY3WUx5RFgvS1VVVmdOakp4akViQnBn?=
 =?utf-8?B?OUpxbCtPYVRsNVNobW9qbzNHTXJEK3BpaXpBN3Q1VVFRS25Cb3BVYnNJOEpN?=
 =?utf-8?B?QzRiZi9FOUFaVDRKQkJYelRWS2phQ2RvVGp3WjFjdmtJU0JRd0luQlVRQyth?=
 =?utf-8?B?T21ubmRuQ2U0Mk5oRFVGWjNQdXpYSjdaWlRDR1ZCV1plakE9PQ==?=
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:14:27.5687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3548ee0-012a-47c6-6c65-08dcf53a025a
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR03MB10626
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

Hi Lev,

On 10/14/24 13:15, Lev R. Oshvang wrote:
> [You don't often get email from levonshe@gmail.com. Learn why this is important at https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2faka.ms%2fLearnAboutSenderIdentification&umid=d3086c41-4950-4369-b35b-dfbad134e05e&auth=d807158c60b7d2502abde8a2fc01f40662980862-da2f573d80b6a54ab9f8699b0376fb4e503517ea ]
> 
> Hi Sean,
> Thanks for replying.
> Of course, I have public key embedded into u-boot dtb.
> I see it with dtdiff utility clearly., that it has rsa components and
> mention required property, but there are no means  :
> -       signature {
> -
> -               key-dev_key {
> -                       algo = "sha1,rsa2048";
> -                       key-name-hint = "dev_key";
> -                       required = "conf";
> -                       rsa,exponent = <0x00 0x10001>;
> -                       rsa,modulus = <0xca0facd8 0xc8a49486
> 0x9785b0a8 0xd8560eae 0xffaefc34 0xd958e8d9 0xba5b1623 0x197b8ae
> 0x216b0699 0xb5f048ab 0x1167f69a 0x3d02f44b 0xe1bdc8f3 0x533eaa9c
> 0xd2ce119d 0xf34d90e7 0x9f470b92 0xa672fc84 0x25ce9a70 0x1ba0422f
> 0xa92f1dc2 0x8a6026e9 0xc06c080 0x23d300b0 0xe1c325aa 0x9c229a84
> 0x40a59d7 0x3f59c482 0x7eb27b44 0x9e6d300 0xbd36a4c4 0x5cc65b1
> 0xb5708d8a 0xfc19f30 0x11ce5b3 0xed2c646b 0x77492129 0x4b0382ab
> 0xcf7ac83d 0x93ca0078 0x6f4db3f7 0xd9934ef1 0x2bdb929c 0x4e0726fd
> 0x56568874 0xf0950b02 0x1b2c51ae 0x94d685a4 0x6edd9044 0xb62bb692
> 0x3b131cc8 0xce8c1649 0x41726a8 0x34282ad7 0x7c978b86 0xf970b5cc
> 0xc0505052 0x392a0a39 0xf9b25e93 0x5f32ff98 0x38b8ceda 0xda3a2855
> 0x2bbcb269 0x61db7b91>;
> -                       rsa,n0-inverse = <0xc1255a8f>;
> -                       rsa,num-bits = <0x800>;
> -                       rsa,r-squared = <0x50fdcf54 0x76c283ab
> 0x897a6a96 0x5011d310 0xc70c897 0x638fdc61 0xbde79c4c 0x5a66d6a5
> 0x7747e613 0xcac6b564 0x62456d6c 0x73d3f181 0xfd1d48ae 0xf8159021
> 0xa5c7cadf 0xf3ea3aee 0x3a801e43 0xc4d573cd 0x2c7e8dc 0x44030a5d
> 0xa679da1f 0xad11fad2 0x93fc1da4 0xb3ca4d43 0x30cb4202 0xab21f661
> 0x57041882 0xa63b5c94 0x89c38732 0x8f2b191 0xe9e4a99 0x8292fc7f
> 0x6e7cf63a 0x9eef2fab 0xa1414bfc 0xfdea67c0 0x713fe78d 0xaf176725
> 0x72168246 0x7ab0706d 0xac7f19b4 0x500118c8 0x5915e449 0xaf2cf688
> 0xb70d5fbb 0x8740ba88 0xc89fde6a 0x91931a8d 0x915b76b5 0x5dfcb2e9
> 0x7fe48d92 0xfec26649 0x541dd9c7 0x82c4957 0xb1a7b46 0x1b29c87d
> 0xbb76c881 0x8da006a5 0xeaacff4 0xf39c1d12 0x82cc7dfa 0xc8de4237
> 0xf03ee80d 0xb060a204>;
> -               };
> -       };
> -
> 
> 
> But u-boot control dtb does not impose any requirement that FIT image
> structure MUST have.
> I think this is a reason for behaviour I observe.
> It would be better to add FIT nodes structure to uboot dtb for the
> case like mine
> 
> I am attaching my  2 its files, one that do requires signature and
> second that requires only a hash
> Both flawlessly boot kernel.
> 
> There is also script I use for signage and CTRL_FDT file my-iuboot.dtb

I compared your images to some examples I have and they seem correct.

It may seem silly, but do you have CONFIG_FIT_SIGNATURE set?

Also: note that `iminfo` will only report if *image* (not conf) signatures
are correct. The conf signatures will be verified, but only when you boot
(or source) the image using a particular config.

--Sean

> On Mon, Oct 14, 2024 at 5:24 PM Sean Anderson <sean.anderson@seco.com> wrote:
>>
>> Hi Lev,
>>
>> On 10/14/24 04:42, Lev R. Oshvang wrote:
>> > Hi Sean,
>> >
>> > I am looking for help with Uboot FIT  signatures problem
>> >
>> >
>> >
>> > I  started to work with FIT image (u-boot 2024)  and managed to sign
>> > kernel and load this image with Uboot using 'required' property in
>> > signature as  :
>> >
>> > signature-1 {
>> >
>> >                                 algo = "sha1,rsa2048";
>> >
>> >                                 key-name-hint = "dev_key";
>> >
>> >                                 sign-images="kernel";
>> >
>> >                                 required="conf";
>> >
>> >                          {
>> >
>> > Iminfo reports"
>> >
>> > ## Checking hash(es) for FIT Image at 01000000 ...
>> >
>> >    Hash(es) for Image 0 (kernel-1): sha256+ sha256,rsa2048:dev_key-
>> >
>> >
>> >
>> > To test the procedure, I generated another private key and signed
>> > another kernel with this new key on another Linux host.
>> >
>> >
>> >
>> >
>> >
>> > I expected bootm to fail, but it just happily loads this image!!!
>> >
>> > Even an image without a signature but with a valid hash is not
>> > rejected against my expectations.
>> >
>> > In this case iminfo report only hash is OK
>>
>> Did you embed the public key into your U-Boot devicetree with `mkimage -K` ?
>>
>> --Sean

