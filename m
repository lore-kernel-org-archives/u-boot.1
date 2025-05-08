Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3E0C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6F3829A1;
	Thu,  8 May 2025 17:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="X+YjpGeA";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="X+YjpGeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34B6828A2; Thu,  8 May 2025 17:15:24 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3143828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CRjTjghFhHBW2dF7z8rA9B8KPVgwXKo/V24aMERhCNebYGWAgu7VhRsp0vjKjrTCZIecCoW0ToDV6KuP22bGVQSN6BmNcbO+M1deEQqnXFF7Zy+szbezTqRd2QGc3vLAljmRsJYgSyjMp/RkUNA2uBeJG6KKEfsyKvjQwt1jQN7SwOA1q/uRtvHXqnDl0Z5ZfMIT8uWyIZZqe/9O1muQITiIXE7lB+6nxk44fbyMtm0er24cDZqiFQqhpUC0c9bUpexdkQRjw4xRYa4w1h0+7BxjdlLdJgj4oCXNxAH1eV+Dn1UhMB9rpeRfKYRFEIFvSHlOBHHqUldJPxsPNbWQQA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIiNG7U1fxpBmNX98jR8zsYavrTNJm6wyEn7DsKqwiw=;
 b=pRSYe3fetxORqU5B/Rm1ZWuKF7AFR/+SQGio4Oopq4YgPAEBmucBDBzP40XRzX0dKJU3jUqBOrdsy0fmxpYncZN/67oQk+XMGix8fsDNSq1UCSwF+yNzmTVEV5JN+Qsxzuxsk2IHYopuitJRNHS2Zacm8QThd2qAGehNrus3kC3CLlbls5t+MFRK/oTAP7a1mkIQguH9yGd1v7+PZeSy5JLFwGpaSWWiIJC9vtr3I4ql1T/s24Esfqw7mo7Lo9G4fsk5yAJeYb9P1TmOwA9J0Q6I2zQKi6QqwPkK7ppQlQdgmcVnU2+drDWuOR84hol6GTahbVLv6PFIDfzebOBxhw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=canonical.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIiNG7U1fxpBmNX98jR8zsYavrTNJm6wyEn7DsKqwiw=;
 b=X+YjpGeAwn7QMDL47XghM6cb54ftQP8MOIkNIldYK2/4eCG1Ziz2HP7G3OIFwehBVFciX7YcKdqldczKg8R39Zc99WcaSpRirrV7uXP7l6Bf3IBXIquOkv5NZDCCg2vzBY+6d0rBwZX/75lm152JWBsC7dUxNzELi4We21ybiHE0rqz4HVt9WQfCMzPFEB//RhBfXnnXyQ2o3S4LOh+1Ocz+ght1i0HZKv21Xx5T6c/E8M0p2DyzIGCuwJTowJe7sbrxZ+jW8qaW79t8s/KTXuU/VOntWiw4899fEkqSFUhiFmckaO3YDwk4gETx6DcL1Zd3norFxorPQ3BYGBNwcA==
Received: from PAYP264CA0029.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::16)
 by GVXPR03MB8451.eurprd03.prod.outlook.com (2603:10a6:150:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 15:15:16 +0000
Received: from AMS1EPF0000004C.eurprd04.prod.outlook.com
 (2603:10a6:102:11f:cafe::11) by PAYP264CA0029.outlook.office365.com
 (2603:10a6:102:11f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Thu,
 8 May 2025 15:15:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.83) by
 AMS1EPF0000004C.mail.protection.outlook.com (10.167.16.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Thu, 8 May 2025 15:15:15 +0000
Received: from outmta (unknown [192.168.82.134])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 F263320080F81; Thu,  8 May 2025 15:15:14 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (unknown
 [40.93.76.79])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 5D1E42008006E; 
 Thu,  8 May 2025 15:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya5pAYsN2BAvQmF+OWLA+VYAkeaUEcd8OrKVFdn8cLxn62RLQTk3DKNTCN2/lU2rpwCPdSBCDugEd3Q+te6KodUv8SBuCKTx3HHwuV4Uzr+vgw3/DYPzs0q4ehWVOK9HqIsxn7w4hFPlndd+sufZxWwn9hQ6coF+dKX7pGTgt6MalXrJfi0kEkjCCdZ9s+VUuwMIItk/23qvaBnbxx/8Gt4nvuqFhD0L9+faEyCQDgb8nzxVHnybaXCpfwKp1Y831dWJ9zi71sELgeMoD52CjHlmgGcdESe3lGMevKGiA+ne8Jpw80Dstu+mxAZS39KYXvD6d/IJLzu5lzDfCgvF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIiNG7U1fxpBmNX98jR8zsYavrTNJm6wyEn7DsKqwiw=;
 b=M/s0HV1lBIWnWBmMkeBIXBQ1z+9pWzPEn2Zp4w6OPCQg2iuVnRXrzhNmFMQFEH1oRbzYztTPgcwBTotHV0shbVR99SEJ2ViQyZc52gPmzGZzi3KrFbonHk/2/UG7FU0UW9UzmrAyH5W/MOlCFb49MoAZDyY6QfgmpLffyqPYGi2eEQm24W8Vsuzp+eU0HNzzRfad2H69qO84ikufaaCGKQui9KUPg0mHg8+wOb8ZevO++UVMJGf+CgusCzDqhrZeXhu6EQdLioG4IQgyO59Z4dX2mQrUQgujcNMqEf5T1jNOK/NEAZMfWTXMUQGkXSf1vmiGz2qwFY659G/apBZfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIiNG7U1fxpBmNX98jR8zsYavrTNJm6wyEn7DsKqwiw=;
 b=X+YjpGeAwn7QMDL47XghM6cb54ftQP8MOIkNIldYK2/4eCG1Ziz2HP7G3OIFwehBVFciX7YcKdqldczKg8R39Zc99WcaSpRirrV7uXP7l6Bf3IBXIquOkv5NZDCCg2vzBY+6d0rBwZX/75lm152JWBsC7dUxNzELi4We21ybiHE0rqz4HVt9WQfCMzPFEB//RhBfXnnXyQ2o3S4LOh+1Ocz+ght1i0HZKv21Xx5T6c/E8M0p2DyzIGCuwJTowJe7sbrxZ+jW8qaW79t8s/KTXuU/VOntWiw4899fEkqSFUhiFmckaO3YDwk4gETx6DcL1Zd3norFxorPQ3BYGBNwcA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AS8PR03MB6869.eurprd03.prod.outlook.com (2603:10a6:20b:23f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 15:15:05 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%7]) with mapi id 15.20.8699.035; Thu, 8 May 2025
 15:15:05 +0000
Message-ID: <af7ef477-edda-4323-9083-a1d81ff317eb@seco.com>
Date: Thu, 8 May 2025 11:15:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] doc: RISC-V supports semihosting
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20250507041716.27564-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20250507041716.27564-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::18) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AS8PR03MB6869:EE_|AMS1EPF0000004C:EE_|GVXPR03MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca2668d-3be4-4ef6-c1d3-08dd8e4322a1
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?bXdBSytacWxqVjdzeU1UbVZWVmR5VmNWZGFRR2dObm9CT2cvRmhjcGZIWHNw?=
 =?utf-8?B?SHE4WklMVFVrVWZEQ0QydEcwQUpab3lwVlc0S21FTnJVVng1MHpKVVd3Vk1p?=
 =?utf-8?B?Q2o0NGVTcWdTbVI1NnBmYVlwRDVvWHRBd1dKZHJSeUdBeFdaZnRPWkMwajZq?=
 =?utf-8?B?Q2pzNVhPYlVsWHdPTXNqRGptaTJjYWdQSWhmcm13KzFmK1pHOTN3bFNQNzFS?=
 =?utf-8?B?V25zL1NOaVFPdFhRQzk5WG93dEM5dDZROUxNbmF1RmtmZjBuM2duYnFMUG16?=
 =?utf-8?B?aFNSQ3g1OGc5UFRoQnlDZHJDL0J2aGdYK2JUR3ZLdi9FU1IvSk1aT2VQZlkx?=
 =?utf-8?B?a3RaenVRNFdRb3FaNDM3UDFTZEQvOTM4S1VPUnd5RGZabHo3ZlFGTG1HMWZs?=
 =?utf-8?B?Z0lORmJjWDdhZXl6czVyaDZFTERpMlBEOFdOVlJMTTBMcWtVbUswK3BlenMy?=
 =?utf-8?B?MDB6UWxCM2VkaUtadzhjS0hwL3BYbTFhSG85MWdUUEN5K0crcUhqMGhsMzZV?=
 =?utf-8?B?VGpiTmpSZm1LYzBwZFN1U1ZIOHk2dHV0TjZwM1VwbTFoOFA4YkhvWWZuV295?=
 =?utf-8?B?R1pqbGpxSDJsVjFVZW5IRVJjeVZ2RjV1d2czdjVJUHVpY1lxMnV3ZUpxakp4?=
 =?utf-8?B?bk1SVW52aThkb1NEblNXSVNxMUVJcVMyWTNBb3BFQ0ZrQUZNYzcrQitvTDZ6?=
 =?utf-8?B?a1Zvd0VXd0RidE9QZXRlQVp3ZlNOeFQ5Q2JuWEZyeGg5TmhxK1kvalFhT1Vh?=
 =?utf-8?B?cWJCNWZQUnZWYW5TaENicFB0R0RqN00za1IydnVwb2pXdEs2WFJCQlQvcVJC?=
 =?utf-8?B?QmxUeHFCQmlIUGVKZEs5VG4xWmtIYUJ3MHY2RkZGVjVEMXQvS0lqYlZOWVhh?=
 =?utf-8?B?cHByWVpsU08rWXplTlNVdHQ0aWF6QnRtUnI2OHdKNzdQYzNmYUlJNWg2NjhS?=
 =?utf-8?B?Wkd4V0xCMC90NzZKeFd1SmxvaHVicVp1WnZTZGl1dlJzL01VbTBlU3psclhq?=
 =?utf-8?B?WHVYTDhMdHQwWTc4U1F5TGw3ZXNGSjhYTnRHWUJianpQWkl5V1N0ZWtDcTFh?=
 =?utf-8?B?bkFlbmIweUZTRlF5U0hmTTZQaWk3c3YyUDhjS2pNd2ZQdFhXc002ZXFNNEhR?=
 =?utf-8?B?cnFSOW9pd1RrWkh3blowVFluMDRqVEZwU1dmR2lkQ2tNS0dtcDRjT0N1M0J3?=
 =?utf-8?B?Y2o3YkhCVWNScEsyLzVnNzFOZ21sRTNqTVlXOEhoaXE2SEtPQzM3RTRVQnZi?=
 =?utf-8?B?S2NoV1MxL3Z2YVRvMDNoTzh6NSs4N282alIvajVRVVBHYXB4ellUK3Evb3Zx?=
 =?utf-8?B?M1NReFJINVdYTnFBS1lnWTZxSFp5SjV5SGJEU0ZVZk1PZmlQcDhOczg4bzNG?=
 =?utf-8?B?Um9vNkdsWkRBOC9rNkR5WmRONTkzU3FtUTZjcXB1NzdBMlhRWCthK1Y1eXQw?=
 =?utf-8?B?SmhUUVVZZ3Ixb3I5cHpnN0RzS1BscHlHWUhxN0phRWdjY09UNnNndFEwQlNG?=
 =?utf-8?B?Q3AxdE1jMFBYdnA5RDEwV1JYWFlGdHJKeGxFdTNJSGVyaTduNVN1Mkh0ekxL?=
 =?utf-8?B?Ti9SajdzUlU2NHFPN09uVm1ENStKMW1FK0xnVHp5Umk3U3VHOWFDcHhHS3lz?=
 =?utf-8?B?ZnMyZEhrcU1DK2pmTkFYWEgwT2tNVFVSRmtqNFJ5c2c2WUYvUU1LNFF3SGhk?=
 =?utf-8?B?aFRGcTJhM3dLc2d2TlBZRjJDcVd4Q1l2djBvRjVYMFVycGNKdFJrTVVydHFE?=
 =?utf-8?B?Vy9WRW0xcnBseGVHc2EzVnZ1aEpkdk5PVU5ic1A1QWMzMGpaS1laa3RQL0tH?=
 =?utf-8?Q?MjSyeQCvsR6j89orIKnhEfoNaJFECBxjpn52U=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6869
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2dcb53e0-d01c-4193-dd3e-08dd8e431c19
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|14060799003|82310400026|35042699022|36860700013|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmdCVXNySTNnT1VidmxoOTNVd1pjODZ0a3lMblo2S2NBNnVlMmw0aFVxZGpC?=
 =?utf-8?B?OGQ5VlpCMHE3M1puS2pLVnlvaU9DOW84Y2IrMFdIUUg2WnVoYmpWZ28vQ2Z6?=
 =?utf-8?B?ei9zRGlsMG16cFdadm0yRzZHSVBLd0M2QnRqeGRKa2NJcmN2c3g0Uk5rb2I4?=
 =?utf-8?B?QVR1VnFWSDYzV1Y0UG1sY25SQzNqZXJ2QURyV2RBaDdOZCt3aEFsdHJWOEQ5?=
 =?utf-8?B?VHBDTklydXc0TWxoZ0dER3pydUJpUEIvMEE3WE8vUzNlUVd5N3h5RXovWlRB?=
 =?utf-8?B?M3FkcWpZVE9LcGR1VGVtMDdCWXBNTVc0Um1OT1lXVzhEai8wV293SC9yanVJ?=
 =?utf-8?B?UzE4OUNkNTNHOTZkbi9HZnRRZHNnajhTT1NRSyttTjVDL3BzckVxc2ZYNXdo?=
 =?utf-8?B?QjM2QjlTdG5YME52S01uQlRKaHNTMktoNHJUT2Zsc3ZRTFFvNWhreUZyd2xE?=
 =?utf-8?B?cmVMYVJzenVIcWw2R2U2NExEd21BWkR2R2NWc1FrVG5oODVDTGhhM1FkcFZB?=
 =?utf-8?B?ZmVvRWl3cUloVVRvNlFDNXdPMnNXaCt5OE42UU5sdUhYdlM0Z055bnlLOVVU?=
 =?utf-8?B?dnRQVVJTK0FFRDlCOWQ5dzFJOHpBUjUwUVpwWXZDS3FTMkNnd3RnRHZQdlhm?=
 =?utf-8?B?T25qZUUxUGcrdWRDQWVTUmhNSmhsNjVJREpZQk13NUpqc3RUaXhRcDRHTS9O?=
 =?utf-8?B?MlFRRDRhem45ZS90ejNBYmlYQWhOQXVReDFmVGdpQ0lSQXJsdEpHQnRLRUxk?=
 =?utf-8?B?b3hYVkt1MzFReWo1SWo3QkZ6SzkwaFZvUkl5OEJDcldHZ2IwcjZ1YVVwODJJ?=
 =?utf-8?B?Y1JYcVVaTzdqSVMrMm1SVjh5SUF5MTFXaWwyVWhlM0tudm5DTmpaREFvbjFG?=
 =?utf-8?B?SXhZRkVXRmFBejNWcUVHek1pck9tbWIxaWlPaGdtQ3lyUlhHMjNabThzREJH?=
 =?utf-8?B?enJiZDJYajFvNWM1YmZ4TytFUitMbVFaZzMvd3pSdnBQOC9oTHVIOERsUE9S?=
 =?utf-8?B?ZHZCWVkzRmtvdFZ3cTBJb2ptQnU0MDhjQUJFY00wYzVTblAxYXRCYUo2SDhX?=
 =?utf-8?B?VVMwbEN0Q2orNVE4ZGZULzBKRzFVQnNxdVhKRFhNempRTGw0VUxWNmwyVjRH?=
 =?utf-8?B?YkJNZkxtZTk1L2JPSS9wQXBaYkM0MGl3aHRBTDY0Z0YyLzZ6UVpxN0hVTHgx?=
 =?utf-8?B?dkVIZEUyNXhLODJnM0gvcjc1MzltdzVXY254eFo5VlljdC9DZHh1aXJpOUFu?=
 =?utf-8?B?S1NyQVltQmNSOEJTUUpoa2ZoemR0UGtEZ3hwcTZ1bVlEbXVRdUxRZmdYa3J2?=
 =?utf-8?B?OC9Cc2tRbGtHWjdpT3dNWmRtNFUyTGhkcUMvK0dUbHBweURYTTJKalRUVy9V?=
 =?utf-8?B?OEgrcEEzWGt3aHRQS0tEbHdoWDhHN2ZCOStOMkVGUHlGUW9zR3ZMZmNhZ3Qz?=
 =?utf-8?B?RE5UdXZ0N0lFd2ZuL0xKZmVxaVNkMXNGT3J2a09TV0RqTis0cW1kOExHYnFx?=
 =?utf-8?B?eGlLRFFicjlpR3dmaE83WWNXbTgvNXJDd2dUeFN3MGdGR3lINmMwaHBZVG9T?=
 =?utf-8?B?OFVyVDBqY01yRnluNmdJays3cDdjTzR6SzBNbS9EWFJ4MlhWSHRkalNlQUdS?=
 =?utf-8?B?bjUrR3ZCR2tEekFrZG5nWG5aR1JzbjBaSlJ0b2N1Q0FBOWhOeFBEazFxVkdS?=
 =?utf-8?B?d3FURFkwMm9DdG5PQ2lJNm9BY0Qyc0VNb3FYVzNaU0IxUXpEQmoyTzlmQjNK?=
 =?utf-8?B?WGxjTXNQMXZ3Z0t2RUJTZWl0YXZwOFBlWTc5ZnpNalhDa0gzY0U2QW9ZWmJO?=
 =?utf-8?B?cmw4aGZTMDJrZEFoTm15aHNseHQzZGVQY0xyRU5HWU4wcVhlUmlzU0dUM2Fa?=
 =?utf-8?B?WkswYm1TUjZvT3pkblhSNUxqNVJGVkpYTWFKa3dKZ1BCTzF4NUlidGV5V1lw?=
 =?utf-8?B?M0piUFk2bW5VUGJiSjZValR1TTI0M0o0QjY2VkgzN1oxVGdvZy9nQUNJSDRt?=
 =?utf-8?B?TkV4OG9Wb2lnPT0=?=
X-Forefront-Antispam-Report: CIP:20.160.56.83; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(1800799024)(14060799003)(82310400026)(35042699022)(36860700013)(376014)(7053199007)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:15.0984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca2668d-3be4-4ef6-c1d3-08dd8e4322a1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.83];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8451
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

Hi Heinrich,

On 5/7/25 00:17, Heinrich Schuchardt wrote:
> Mention that RISC-V supports semihosting.
> 
> Update SPDX identifier to current format.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/usage/semihosting.rst | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/doc/usage/semihosting.rst b/doc/usage/semihosting.rst
> index 9303a6364d5..dfd6c58222a 100644
> --- a/doc/usage/semihosting.rst
> +++ b/doc/usage/semihosting.rst
> @@ -1,14 +1,17 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> +.. SPDX-License-Identifier: GPL-2.0-or-later
>  .. Copyright 2014 Broadcom Corporation.
>  
>  Semihosting
>  ===========
>  
> -Semihosting is ARM's way of having a real or virtual target communicate
> -with a host or host debugger for basic operations such as file I/O,
> -console I/O, etc. Please see `Arm's semihosting documentation
> -<https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2f100863%2flatest%2f&umid=e1d32e91-40f3-412a-84a3-56231fc0ae28&rct=1746591449&auth=d807158c60b7d2502abde8a2fc01f40662980862-c560455b43c648ed3d71f92bb5fc9467eabb905a>`_ for more
> -information.
> +Semihosting is a technique to let a real or virtual target communicate with a
> +host or host debugger for basic operations such as file I/O, console I/O, etc.
> +Originally introduced by ARM it has also been adopted for RISC-V. Please, see
> +`Arm's semihosting documentation
> +<https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdeveloper.arm.com%2fdocumentation%2f100863%2flatest%2f&umid=e1d32e91-40f3-412a-84a3-56231fc0ae28&rct=1746591449&auth=d807158c60b7d2502abde8a2fc01f40662980862-c560455b43c648ed3d71f92bb5fc9467eabb905a>`_ and

This link is dead. Can you update it to [1] while you're at it? Thanks.

--Sean

[1] https://github.com/ARM-software/abi-aa/blob/main/semihosting/semihosting.rst

> +`RISC-V Semihosting
> +<https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdrive.google.com%2ffile%2fd%2f1qu74D4%5fEmjGmc03qzfQ7Pf4g6m0fOtcD%2fview&umid=e1d32e91-40f3-412a-84a3-56231fc0ae28&rct=1746591449&auth=d807158c60b7d2502abde8a2fc01f40662980862-de1a27031ffe508a9d6a130a34bb51a84ce2447c>`_
> +for more information.
>  
>  Platform Support
>  ----------------
> @@ -40,7 +43,7 @@ Foundation and Base fastmodel simulators.
>  QEMU
>  ^^^^
>  
> -Another ARM emulator which supports semihosting is `QEMU
> +Another emulator which supports semihosting is `QEMU
>  <https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fwww.qemu.org&umid=e1d32e91-40f3-412a-84a3-56231fc0ae28&rct=1746591449&auth=d807158c60b7d2502abde8a2fc01f40662980862-5d24dd3c7adadb856edccd27bd81ab7444841d34>`_. To enable semihosting, enable
>  ``CONFIG_SERIAL_PROBE_ALL`` when configuring U-Boot, and use
>  ``-semihosting`` when invoking QEMU. Adding ``-nographic`` can also be
> @@ -53,8 +56,8 @@ running QEMU, refer to the :doc:`board documentation
>  OpenOCD
>  ^^^^^^^
>  
> -Any ARM platform can use semihosting with an attached debugger. One such
> -debugger with good support for a variety of boards and JTAG adapters is
> +Any ARM or RISC-V platform can use semihosting with an attached debugger. One
> +such debugger with good support for a variety of boards and JTAG adapters is
>  `OpenOCD <https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fopenocd.org&umid=e1d32e91-40f3-412a-84a3-56231fc0ae28&rct=1746591449&auth=d807158c60b7d2502abde8a2fc01f40662980862-9fa3b9bde769a53933330d7aa1eb430d081756fc>`_. Semihosting is not enabled by default,
>  so you will need to enable it::
>  

