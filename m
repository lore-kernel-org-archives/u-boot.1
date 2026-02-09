Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2B7EF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A9383BE1;
	Mon,  9 Feb 2026 02:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VomigvZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C943C83BF4; Mon,  9 Feb 2026 02:28:56 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE94805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfZv5PnLDfA0L4VPgMVqrYqyy1pg6/SUFSvuqBtjcz1KpzULIZDLwShYzgTcooYS8Rrpb5BNx+ShF0Xx8O/V0KzutUV0o/O8ADhO+vBUCDp96R3MuiR7PV/6sA1OIGLD/I2LUZP9hkGfesRoaKvkZA5aP/KEnCeCFcSzMfGwTV1LA5YyyU8EBs1VvIP6xPKGWDMPbj8Dl4vtPmT924efPWwiAWLam426PV9/E6iSFNncHl9eoXumb7pxwG5PEEi2NV1zGT/grYebUo3SViUOVMJY14yTUVOfp+aIp2g3PQ1njh6iHLIj0Vb43gX3KzD6UN6iaxovqH4vD+cfDRqN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcbre88kVGTB9S/QbpEuG1raIWF6QiBEsShazPxmj4M=;
 b=ymqVDFO7yRiLnHQzb+M8cyuH0C6zEdO9WxIr0SXVOHPQRBUmu11z7Zg3RW3YMwvrHTOPwmcBzcSFmKPwBb8fw9RP1NPd1v0VctxrzMwsoz9LGBcBomxT7+4zgH+D2ahvxUBvDh1q4XCkkq9/lo8jdvoBkI9cWmcbkMGoE9LGATZlUwcckXx9Kvmpjp1xYFs3gfo6w0uYX3ACGcZbPyhCgW73EpVLnPP8GxhuCXPdxIqdtKHI3YTmy/yB27ntJwg1wmrnEh8PtjmAd/XyaseDxUdYnpDVxD3onqk22jKM8QhtSTZnnTL9AeXAIUpsUP0/Zi0pXSvsT9sBRWka/ohXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcbre88kVGTB9S/QbpEuG1raIWF6QiBEsShazPxmj4M=;
 b=VomigvZAzMbTJAowQp3GMxnGfOiUZODhShM8kBjby8W4u7dUEJKPmhRona5TtgDYguY2B39QQFYM+EKNY66YxFuwZLYWmx/n3LZdUH05ZAMi6bnZ8F3ATKb5CW0nc+Wfl7rzMMNQUtygfg/C9hcArugCQnDL8Jb2ZaM4APnPLjrqmkf430Tmig73DAzCd9Kq1Lue63yO7Es+HU9LR2uXvo1wZ5BQx7VLISYbpRGmHM7ueb8M3Z5uW1vKYVR0duJl9nCygGU9hnCJcru9ueOr4gNhfmEOmuCNjzsM50zKU2yDHk/og3a3CYyabVrF9SIZRIgjl5eCFSGBH7DkAJJBhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:28:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:28:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/14] treewide: Clean up usage of DECLARE_GLOBAL_DATA_PTR
Date: Mon, 09 Feb 2026 09:30:04 +0800
Message-Id: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJw4iWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDIKGbnJOamFdaoGtqZpBsaWCQZp6UbKwEVF1QlJqWWQE2KTq2thYA8q4
 pBFkAAAA=
X-Change-ID: 20260202-cleanup-560c900f7bc3
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 8108023c-b660-4cc7-4bd9-08de677a94ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUdSaERqc2dMQWlRcENFQll3SE5aT1I1MW1FM2MrVldsOGcxajk5M2l1MFcy?=
 =?utf-8?B?U3FtMklRWDNQNnpoNytqeThlVEpTZE1kNEpvTVJrRlU1TEMzblhFWTNsS2Nm?=
 =?utf-8?B?U0FiNlR0UXgrNjlFajN4dTRXWUhzV09uMEtsWlJDMDdZWG1kcW9yWmRWMnhC?=
 =?utf-8?B?c0s5cmRJTG82UDBaVE5yVnBjUnBGTVZwbUR5dCtTVTNhRmN6N0x6UTI1MDYr?=
 =?utf-8?B?eE5oSlNIYnpVcWVmZDRxMjJMZmJ1Vkg1Q3NXcmdwNEJaMkNTNUxwL0dITE9Z?=
 =?utf-8?B?Qlp3UDNZSHQxSmVtREcraXEzZWg3dWJ0dDFlc1dYb1VJbHZUdmZ3VXdKOWpL?=
 =?utf-8?B?MFY0azk0ZEtOMmg3T1dFS0VwVnluYWZmdE9adFZkaHBQUi9INjhTREhHNUtu?=
 =?utf-8?B?NHN3MEo4TE5wSXhDZ0xTN1BoQkVySjR4MUhzdDA2b0pYYkJwa0lUeXM5clZ1?=
 =?utf-8?B?RmRqNTU0bWNsWHAvU2pFQldEdjI0Yy9UTFFQYTlEOEVSUnh3bjRzQ2NBSDZh?=
 =?utf-8?B?UDUwNnZycDYyeWZkQ055bkdWQlVXeUpkMU5yVVdPbDdkM3g5ZTBoMTdTcW5C?=
 =?utf-8?B?UVcxZGxhOTFITVlJQnIrZEM4dGdOQ1ZMUnIyQi85Rk9NZ2svSlB4KzZ6RDZt?=
 =?utf-8?B?dE9rSURQOEkrSGJsbFU4Tmc3UFgwbitBVDhJZ3NyN2VFbytNYWNqV2tmOElH?=
 =?utf-8?B?K29wTjNTVy9tZmNZcjVQUTBYYVRCQmNKZHJDY0FrSmNRWnBSRFk3ZWhvLzVY?=
 =?utf-8?B?RlUrVGtOWmtDNENIUWVIQWxzWERuZGZpL1hZbGVHbXNlY0FycXpIN1dGMjZM?=
 =?utf-8?B?bmNra1lUWjF2ZlZKRGxrR25pNWVhcTJRTm9oWTVsV21MRVJwdWdCVUlzTHhk?=
 =?utf-8?B?Y0s0RE52N0NkMGRnM3BQTXVqRGY5TDltcEdaRUlGNmZ2VmZ6RGZ5eG1IRG5O?=
 =?utf-8?B?RWlkTWNSc0I3bGJpWVpldFhPNkZXVDVUdERQOGEzYU5wQUN0OThKdU9LY3lY?=
 =?utf-8?B?ZmVpM2Q2QS9Mc1B5Z2hYRlViMmxrN1RxUklvVjF6d3M0L1Z6VFVNZk8walVw?=
 =?utf-8?B?d1dRUzFRd29QOXpHdi9xZUtndzBTSkJoL081WlVpYXhQWUZBQno5dTloaFVm?=
 =?utf-8?B?MnJHdVFzUDVYTzBrcGFCV0s4UFhtOEsrWlZ4MTVpK1E4enJLMjZkR0IwZlpC?=
 =?utf-8?B?ZWpYYkc3UCt4M3pjeDZVR2hSWUNQelJqNFZDYVdaNlc5eTJtY0ZiTERWT2hs?=
 =?utf-8?B?S3JPR0JzYmlFU09aU2hvWCtlbnRvUWFFNnV0TSthbU5FRlE5YWd3Y21CWG9P?=
 =?utf-8?B?SXNyUlloNlljbDdqK01NNXZvTERBZkE0SjJyamVuQ3FNUnlHVzdwekdDZ01N?=
 =?utf-8?B?QmY5OEhpSW9UNUR2MG5ab0tIb3pZTUhHZi9ZL3VKMHJ5TFRkVlNIcTNSWWxk?=
 =?utf-8?B?V1pCalZ2QUxKdjdWSFd1Z1FZNkM0TlFhOTgwcUFLMHdGNXh6K1BiTzhoRmF0?=
 =?utf-8?B?eEZXNGoxWW5BazJlYjBjOXc5UnRyYm1GL25lc3dyMytIaU1uK0t5cHJQVnFk?=
 =?utf-8?B?NDhBTU1VQzNaYlpCM1IyS0RWQklMcEdEZXJGd0VKdTE1aUNRcHgxVDJFVUVE?=
 =?utf-8?B?b1VvTmlJYm1RRGkvcHlTSS9yYno4QmRwcUsyNHF2cmtzbWhrby8zQVFOK1JF?=
 =?utf-8?B?clRYZ3RvM1FBd3RVYjlYODhhdmptbXNLOWVUSXlRWG9DbEdoMzNabE80bmJK?=
 =?utf-8?B?bXJhRzhhbFNhT2dTcmhnYkMxeWplV210T0tsd3NyMXdETGVkUXVGOFBrMWds?=
 =?utf-8?B?VXl1c2dVQm11amZBY3A2WklEQ1grSGJDakZQSGhwWXpiQjlmcHl0andtcm5n?=
 =?utf-8?B?cElTOGoycmkwT2FTMXpqbnh5dnVuWElEQ3lJamd6THlIYWhvY2k2V2ZLZjAr?=
 =?utf-8?B?Y3ljMm5jK3hKclZRV1J3eGpob2swalM5ZldVNXlTcU9VZWRYS1d5R0VNeGZN?=
 =?utf-8?B?ODFwNGZMSXRpeThvSVdOSWxtM3MyNWYzNTBULyt5NVZWaTJFY2tQdmpWUTA1?=
 =?utf-8?B?ejlrNlNwQ2x1UXYyMm5lUjd6dzJRZy9YT3RMSHRVKzBLWHdQSGQwUUdWUUZC?=
 =?utf-8?Q?bAGlL9JDOwl0mXocKSDO7LYQI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ljRDJEWEptRzhrcTZmc3lKZzRoY2ZvUVhnVzdPM0RNQWpNOFM3WWF5aSto?=
 =?utf-8?B?bTNwUFFuazBBNDd2OTN3RGZ3UGdjQUpEMmxmVzkycGRFcFFSYzN2YVptRVZX?=
 =?utf-8?B?QmFMVUJ1eGdBZ1Mwd0RPOHcweFg2K1lxc2U2T2pXZldNMHdUTkZ6VExocW5q?=
 =?utf-8?B?SjNvWWljZW5WMGlsWklmVjcwVmNwam5Gdk9Bd0Q4Z1ozaGdmM0QvRVlNU1Rq?=
 =?utf-8?B?dlBJNkpocDZhNGpPaVQva3VCenY1ZEJSYlpNTXBRdWIyWnFMbWhRZjVidWh3?=
 =?utf-8?B?MzNVMDVUZkF2a25RWE9ER0VLaWtya2gwUUVmYUFmRWEwT0piMEVpQzhzZXRn?=
 =?utf-8?B?ekVXekFSZGxLUEtQVkhFZEpBODRRWXdOZ2ZOUkR5R3JXUEI3V1YyMklaYUVv?=
 =?utf-8?B?MnBscnhYamhBUHpISitnQi9lY3BGWUdxaW1uS3NsRUwvNVZQQXlhUTFGYW9Q?=
 =?utf-8?B?ajUxOWc4dXlvc2lQQlhtL2E4SWF0MXhEN3ZZUWp6d2lPN0pRMXZmS3ZaUUwz?=
 =?utf-8?B?UUJDQmtxdGhUNEFrdGt1WEh6V2hFK0FQZ2hIOFJRWnpQZjlsMlVvMzQrQWty?=
 =?utf-8?B?TW5EcERZRFRTcy9ZbHV5aHc3d0VINTNxdnBkQzJtWnlDR1M0Smw3akliWER4?=
 =?utf-8?B?dFNEYS9sbS9TNkdKbzhzYTV0ZTMreEJtTFRRajNYN1EwTUZTTmp5Yk1Uc0dD?=
 =?utf-8?B?QVc0Uit2QzlXa3FGclN3ZlowdjJKSThSMTAweHdjb005bU52WWw0T21kWVp3?=
 =?utf-8?B?YzV6eUZKSGx4b3JvNkR2MnlUK0s2b2hxUll6VjQzTHFhdW9hTU5Fa2FlOEZH?=
 =?utf-8?B?bUQzV09FMW9BZFRYUGtLZEJHL3pyQUdyQmlEanF6N3J5anBoWXZQU3dSWTRX?=
 =?utf-8?B?NVZMN2V6amlkL0V6dVlDY2ZMTiswb005WGF4UWQ1VE9MSWxteWFkYm85R09P?=
 =?utf-8?B?NjVLOEovQUozYmdCWHVUeTRwU3BCUDRRK3VpeWFWcU1yY3JIRjFSSFg5R3hV?=
 =?utf-8?B?N2N1MjZMUzNzZjZ3OGZqQStFT0UwTzl3RjIwM2Z5NHpiRlUxTDhSam91UzNs?=
 =?utf-8?B?SHgyZUYwYU1tNkR2NllHbEZsSERISHYvWWFrRi9UbkRESjZHcmxUNm9UdFd2?=
 =?utf-8?B?eExYTkh2VHU1VlRRQWlLcDVlcWlIck16Ly8raVhsTHJMVVFIaVhrMnBpTzV0?=
 =?utf-8?B?Z0VyV01iUkZQbmpSUERFWUY4aDFCYlB3REx3djN3U3Y5NHYxVEpvcTBVMHZq?=
 =?utf-8?B?eVRLWVN3bktKcEZvMDYydHdqWG5qWWNsVUZPeVlDUUhtZEt1TzFSOWxkOUls?=
 =?utf-8?B?MWVNK1ZIK1NDZ0tLTmxYeEFXMHJadVVvWTVNMGs5Wmg0cmZrSG81YmZHRHNU?=
 =?utf-8?B?S2VjV0wxUnBKa2xkK28xNHM2SjI4LzFmYnQzaS8rVkp3YWhlazRpRi9jWXNL?=
 =?utf-8?B?UDNkNzNsdC9ERzVZL0JiOXBVS2tHdmQ4aE5Vd0loNVhtRlVPZm5qZlN1OEV0?=
 =?utf-8?B?eW9CSHBzV0w3bFQ5VlVLb0Z0WHo5amdXK0hzUDdFM2x6akJzanhlcVdBWEho?=
 =?utf-8?B?NXhCSXJsa2QvQm5mQzA4V3phZE1OVkswdlpwZ0Q2cHNzMFFBMExjRlhTeSs1?=
 =?utf-8?B?K0RkaDhGSmtIOG9kalZGWDZ4dVN0ZmZnS2JJUG16bzE3eWplSFY0UkpQcjRk?=
 =?utf-8?B?R0U1TG5JdTVnSUVZUG5ObzVwSHNwNmxOWFpxbHdtU1ZMN041Tjg5azZsdzZy?=
 =?utf-8?B?QWNnN3NhVWhKbDRxZnJpZ2FPUXVDNk03TG1DeDlGdTFOaWNweW1qOU9aUDNy?=
 =?utf-8?B?bWRLcFZsR0NvNGNEZHdTc1JVRCtVSk9GL0VRL1NVR2ozVUExYmJYaTJ2emNi?=
 =?utf-8?B?WDd5YWtySFE3M05XMUxlMEpLRWgrQlZpaXVOWEQ3LzZxUlU3YzdCdFZyWWhY?=
 =?utf-8?B?MnNrczhuTWRaNFhaYmV3WW5HYUo1UEEzN1RMejVVdkd0KzBpcmJ2TTlOSGtw?=
 =?utf-8?B?QmM2Skg0c3RGdmsvYU5ONHpPbEhPeWZDckh3ZU1jLytJa0J1U1AveS9sYjVH?=
 =?utf-8?B?ZWN2RzJsMi8zamFxa1NvN1RicUFWRTUzdWJyT0tJQlhzSGV2dy9wRFdFWG9J?=
 =?utf-8?B?QnlEMmFJSDg5bHZucFFtWGxpbEVoVXBlUWp5WnYvcEowc3VwWVYwTGJ3d0U4?=
 =?utf-8?B?bzBRMXIwMlhtVDdsU2FhdGNtNGxvd0hncnJ3bFZwMEk5QTFDVUxRbXpuWjNQ?=
 =?utf-8?B?QVc1RDd1V2tNMWtWVnkxWGU5NkMwWDVkR0Q4STNZdmhJd05PR29jSDhHWjMv?=
 =?utf-8?B?TG9ya3orQTlNY0dXRERVYUF2bTk1N3lKdkFoaVhQODJleEtCOEZZdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8108023c-b660-4cc7-4bd9-08de677a94ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:28:51.4687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7m8d7QP5Lwt1DisaVfYoS99bMafdvOPPhKpQM0Vgye+Nl5ct+dLj4C03OP6qlGyrbkl5mMzMaaEXKPhNl63Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

This patch set primarily removes unused DECLARE_GLOBAL_DATA_PTR
instances.

Many files declare DECLARE_GLOBAL_DATA_PTR and include
asm/global_data.h even though gd is never used. In these cases,
asm/global_data.h is effectively treated as a proxy header, which is
not a good practice.

Following the Include What You Use principle, files should include
only the headers they actually depend on, rather than relying on
global_data.h indirectly. This approach is also adopted in Linux kernel
[1].

The first few patches are prepartion to avoid building break after
remove the including of global_data.h.

A script is for filtering the files:
list=`find . -name "*.[ch]"`
for source in ${list}
do
        result=`sed -n '/DECLARE_GLOBAL_DATA_PTR/p' ${source}`
        if [ "${result}" == "DECLARE_GLOBAL_DATA_PTR;" ]; then
                echo "Found in ${source}"

                result=`sed -n '/\<gd\>/p' ${source}`
                result2=`sed -n '/\<gd_/p' ${source}`
                result3=`sed -n '/\<gd->/p' ${source}`
                if [ "${result}" == "" ] && [ "${result2}" == "" ] && [ "${result3}" == "" ];then
                        echo "Cleanup ${source}"
                        sed -i '/DECLARE_GLOBAL_DATA_PTR/{N;/\n[[:space:]]*$/d;s/.*\n//;}' ${source}
                        sed -i '/DECLARE_GLOBAL_DATA_PTR/d' ${source}
                        sed -i '/global_data.h/d' ${source}
                        git add ${source}
                fi
        fi
done

[1] https://lpc.events/event/17/contributions/1620/attachments/1228/2520/Linux%20Kernel%20Header%20Optimization.pdf

CI: https://github.com/u-boot/u-boot/pull/865

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
 - Rebased to origin/master to resolve conflicts.
 - Added tags for patch 14

---
Peng Fan (14):
      beacon: imx8mm/n: Drop useless files
      mediatek: mt7622: Drop useless board files
      common: cli_hush: Include vsprintf.h
      cmd: mem: Include vsprintf.h
      test: log_filter: Include vsprintf.h
      xtensa: relocate: Add missing headers
      toradex: common: Add missing headers
      tegra: pmc: Cleanup headers
      rockchip: evk_rk3308: Cleanup headers
      nxp: emc2305: Cleanup headers
      pci: layerspace: Add missing header files
      renesas: common: Include asm-generic/u-boot.h
      socfpga: clock_manager_s10: Add missing header files
      treewide: Clean up DECLARE_GLOBAL_DATA_PTR usage

 arch/arc/lib/bootm.c                                        |  3 ---
 arch/arm/cpu/armv7/s5p4418/cpu.c                            |  3 ---
 arch/arm/mach-aspeed/ast2600/spl.c                          |  3 ---
 arch/arm/mach-imx/imx8/clock.c                              |  3 ---
 arch/arm/mach-imx/imx8/fdt.c                                |  3 ---
 arch/arm/mach-imx/imx8/iomux.c                              |  3 ---
 arch/arm/mach-imx/imx8m/clock_imx8mm.c                      |  3 ---
 arch/arm/mach-imx/imx8ulp/cgc.c                             |  3 ---
 arch/arm/mach-imx/imx8ulp/clock.c                           |  3 ---
 arch/arm/mach-imx/imx9/clock.c                              |  3 ---
 arch/arm/mach-imx/imx9/clock_root.c                         |  3 ---
 arch/arm/mach-imx/misc.c                                    |  3 ---
 arch/arm/mach-imx/spl_imx_romapi.c                          |  3 ---
 arch/arm/mach-meson/board-axg.c                             |  3 ---
 arch/arm/mach-meson/board-g12a.c                            |  3 ---
 arch/arm/mach-meson/board-gx.c                              |  3 ---
 arch/arm/mach-socfpga/clock_manager_agilex.c                |  3 ---
 arch/arm/mach-socfpga/clock_manager_agilex5.c               |  3 ---
 arch/arm/mach-socfpga/clock_manager_n5x.c                   |  3 ---
 arch/arm/mach-socfpga/clock_manager_s10.c                   |  5 ++---
 arch/arm/mach-socfpga/mailbox_s10.c                         |  3 ---
 arch/arm/mach-socfpga/misc_gen5.c                           |  3 ---
 arch/arm/mach-socfpga/misc_soc64.c                          |  3 ---
 arch/arm/mach-socfpga/mmu-arm64_s10.c                       |  3 ---
 arch/arm/mach-socfpga/reset_manager_s10.c                   |  3 ---
 arch/arm/mach-socfpga/spl_agilex.c                          |  3 ---
 arch/arm/mach-socfpga/spl_agilex5.c                         |  3 ---
 arch/arm/mach-socfpga/spl_agilex7m.c                        |  3 ---
 arch/arm/mach-socfpga/spl_gen5.c                            |  3 ---
 arch/arm/mach-socfpga/spl_n5x.c                             |  3 ---
 arch/arm/mach-socfpga/spl_s10.c                             |  3 ---
 arch/arm/mach-socfpga/system_manager_soc64.c                |  3 ---
 arch/arm/mach-tegra/pmc.c                                   |  4 +---
 arch/microblaze/lib/bootm.c                                 |  3 ---
 arch/mips/mach-ath79/qca956x/ddr.c                          |  3 ---
 arch/mips/mach-mscc/cpu.c                                   |  3 ---
 arch/mips/mach-mtmips/ddr_cal.c                             |  3 ---
 arch/mips/mach-octeon/cvmx-pko.c                            |  2 --
 arch/nios2/lib/bootm.c                                      |  3 ---
 arch/riscv/cpu/andes/spl.c                                  |  3 ---
 arch/riscv/cpu/cv1800b/dram.c                               |  3 ---
 arch/riscv/cpu/generic/dram.c                               |  3 ---
 arch/riscv/cpu/k230/dram.c                                  |  3 ---
 arch/riscv/cpu/th1520/spl.c                                 |  2 --
 arch/sh/lib/bootm.c                                         |  3 ---
 arch/x86/cpu/ivybridge/model_206ax.c                        |  3 ---
 arch/x86/lib/init_helpers.c                                 |  3 ---
 arch/x86/lib/zimage.c                                       |  3 ---
 arch/xtensa/lib/relocate.c                                  |  2 ++
 arch/xtensa/lib/time.c                                      |  3 ---
 board/BuR/brsmarc1/board.c                                  |  3 ---
 board/BuR/common/common.c                                   |  3 ---
 board/Marvell/octeontx/smc.c                                |  3 ---
 board/Marvell/octeontx2/smc.c                               |  3 ---
 board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c         |  2 --
 board/advantech/imx8mp_rsb3720a1/spl.c                      |  2 --
 board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c       |  2 --
 board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c       |  3 ---
 board/andestech/voyager/voyager.c                           |  3 ---
 board/armltd/vexpress64/vexpress64.c                        |  3 ---
 board/beacon/imx8mm/Makefile                                |  1 -
 board/beacon/imx8mm/imx8mm_beacon.c                         |  8 --------
 board/beacon/imx8mm/spl.c                                   |  3 ---
 board/beacon/imx8mn/Makefile                                |  1 -
 board/beacon/imx8mn/imx8mn_beacon.c                         |  8 --------
 board/beacon/imx8mn/spl.c                                   |  3 ---
 board/beacon/imx8mp/spl.c                                   |  3 ---
 board/beagle/beagleboneai64/beagleboneai64.c                |  2 --
 board/beagle/beagleplay/beagleplay.c                        |  2 --
 board/broadcom/bcmns/ns.c                                   |  3 ---
 board/cloos/imx8mm_phg/imx8mm_phg.c                         |  3 ---
 board/cloos/imx8mm_phg/spl.c                                |  3 ---
 board/compulab/imx8mm-cl-iot-gate/spl.c                     |  2 --
 board/coreboot/coreboot/coreboot.c                          |  3 ---
 board/cssi/cmpc885/cmpc885.c                                |  2 --
 board/data_modul/imx8mm_edm_sbc/imx8mm_data_modul_edm_sbc.c |  2 --
 board/data_modul/imx8mm_edm_sbc/spl.c                       |  2 --
 board/data_modul/imx8mp_edm_sbc/imx8mp_data_modul_edm_sbc.c |  2 --
 board/data_modul/imx8mp_edm_sbc/spl.c                       |  2 --
 board/dhelectronics/dh_imx8mp/common.c                      |  2 --
 board/dhelectronics/dh_imx8mp/imx8mp_dhcom_pdk2.c           |  2 --
 board/dhelectronics/dh_imx8mp/spl.c                         |  2 --
 board/emcraft/imx8mp_navqp/spl.c                            |  3 ---
 board/emulation/qemu-riscv/qemu-riscv.c                     |  2 --
 board/engicam/imx8mm/icore_mx8mm.c                          |  2 --
 board/engicam/imx8mm/spl.c                                  |  2 --
 board/engicam/imx8mp/icore_mx8mp.c                          |  3 ---
 board/engicam/imx8mp/spl.c                                  |  3 ---
 board/gdsys/mpc8308/gazerbeam.c                             |  3 ---
 board/google/imx8mq_phanbell/imx8mq_phanbell.c              |  3 ---
 board/highbank/highbank.c                                   |  3 ---
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c                     |  3 ---
 board/kontron/osm-s-mx93/osm-s-mx93.c                       |  3 ---
 board/kontron/pitx_imx8m/pitx_imx8m.c                       |  2 --
 board/mediatek/mt7622/Makefile                              |  2 +-
 board/mediatek/mt7622/mt7622_rfb.c                          | 12 ------------
 board/mntre/imx8mq_reform2/imx8mq_reform2.c                 |  3 ---
 board/msc/sm2s_imx8mp/sm2s_imx8mp.c                         |  2 --
 board/msc/sm2s_imx8mp/spl.c                                 |  3 ---
 board/nxp/common/emc2305.c                                  |  4 +---
 board/nxp/imx8mm_evk/spl.c                                  |  3 ---
 board/nxp/imx8qm_mek/imx8qm_mek.c                           |  3 ---
 board/nxp/imx8qxp_mek/imx8qxp_mek.c                         |  3 ---
 board/phytec/imx8mp-libra-fpsc/spl.c                        |  3 ---
 board/phytec/phycore_imx8mm/phycore-imx8mm.c                |  3 ---
 board/phytec/phycore_imx8mm/spl.c                           |  3 ---
 board/phytec/phycore_imx8mp/phycore-imx8mp.c                |  3 ---
 board/phytec/phycore_imx8mp/spl.c                           |  3 ---
 board/phytec/phycore_imx93/phycore-imx93.c                  |  3 ---
 board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c   |  3 ---
 board/polyhex/imx8mp_debix_model_a/spl.c                    |  3 ---
 board/purism/librem5/librem5.c                              |  2 --
 board/purism/librem5/spl.c                                  |  2 --
 board/qualcomm/dragonboard410c/dragonboard410c.c            |  3 ---
 board/qualcomm/dragonboard820c/dragonboard820c.c            |  3 ---
 board/renesas/common/gen3-common.c                          |  4 +---
 board/renesas/common/gen4-common.c                          |  4 +---
 board/renesas/common/gen5-common.c                          |  4 +---
 board/rockchip/evb_rk3308/evb_rk3308.c                      |  5 ++---
 board/ronetix/imx8mq-cm/imx8mq_cm.c                         |  2 --
 board/samsung/common/exynos5-dt.c                           |  3 ---
 board/samsung/common/misc.c                                 |  3 ---
 board/st/stm32f429-discovery/stm32f429-discovery.c          |  3 ---
 board/st/stm32f429-evaluation/stm32f429-evaluation.c        |  3 ---
 board/st/stm32f469-discovery/stm32f469-discovery.c          |  3 ---
 board/st/stm32f746-disco/stm32f746-disco.c                  |  3 ---
 board/st/stm32h743-disco/stm32h743-disco.c                  |  3 ---
 board/st/stm32h743-eval/stm32h743-eval.c                    |  3 ---
 board/st/stm32h747-disco/stm32h747-disco.c                  |  3 ---
 board/st/stm32h750-art-pi/stm32h750-art-pi.c                |  3 ---
 board/technexion/pico-imx8mq/pico-imx8mq.c                  |  3 ---
 board/ti/am62x/evm.c                                        |  2 --
 board/ti/am64x/evm.c                                        |  2 --
 board/ti/j784s4/evm.c                                       |  2 --
 board/toradex/apalis-imx8/apalis-imx8.c                     |  3 ---
 board/toradex/apalis_t30/apalis_t30.c                       |  3 ---
 board/toradex/colibri-imx8x/colibri-imx8x.c                 |  3 ---
 board/toradex/colibri_t20/colibri_t20.c                     |  3 ---
 board/toradex/common/tdx-cfg-block.c                        |  3 ---
 board/toradex/common/tdx-cfg-block.h                        |  2 ++
 board/toradex/common/tdx-common.h                           |  2 ++
 board/toradex/smarc-imx8mp/smarc-imx8mp.c                   |  3 ---
 board/toradex/smarc-imx8mp/spl.c                            |  3 ---
 board/toradex/verdin-imx8mm/spl.c                           |  3 ---
 board/toradex/verdin-imx8mm/verdin-imx8mm.c                 |  3 ---
 board/toradex/verdin-imx8mp/spl.c                           |  3 ---
 board/toradex/verdin-imx8mp/verdin-imx8mp.c                 |  3 ---
 board/xilinx/zynq/bootimg.c                                 |  3 ---
 boot/bootmeth-uclass.c                                      |  2 --
 boot/fdt_simplefb.c                                         |  3 ---
 boot/image-sig.c                                            |  2 --
 boot/image.c                                                |  3 ---
 cmd/bloblist.c                                              |  3 ---
 cmd/bootefi.c                                               |  3 ---
 cmd/bootm.c                                                 |  3 ---
 cmd/date.c                                                  |  3 ---
 cmd/mem.c                                                   |  4 +---
 cmd/sound.c                                                 |  3 ---
 cmd/spl.c                                                   |  3 ---
 common/cli_hush.c                                           |  4 +---
 common/stdio.c                                              |  3 ---
 drivers/block/sandbox.c                                     |  3 ---
 drivers/bootcount/pmic_pfuze100.c                           |  2 --
 drivers/cache/sandbox_cache.c                               |  3 ---
 drivers/clk/altera/clk-agilex.c                             |  3 ---
 drivers/clk/altera/clk-agilex5.c                            |  3 ---
 drivers/clk/altera/clk-mem-n5x.c                            |  3 ---
 drivers/clk/altera/clk-n5x.c                                |  3 ---
 drivers/clk/rockchip/clk_px30.c                             |  3 ---
 drivers/clk/rockchip/clk_rk3308.c                           |  3 ---
 drivers/clk/rockchip/clk_rk3528.c                           |  2 --
 drivers/clk/rockchip/clk_rk3568.c                           |  2 --
 drivers/clk/rockchip/clk_rk3576.c                           |  2 --
 drivers/clk/rockchip/clk_rk3588.c                           |  2 --
 drivers/clk/rockchip/clk_rv1108.c                           |  3 ---
 drivers/clk/rockchip/clk_rv1126.c                           |  2 --
 drivers/cpu/bcm283x_cpu.c                                   |  3 ---
 drivers/cpu/cpu-uclass.c                                    |  2 --
 drivers/cpu/imx8_cpu.c                                      |  3 ---
 drivers/cpu/mtk_cpu.c                                       |  3 ---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c                   |  3 ---
 drivers/firmware/arm-ffa/arm-ffa.c                          |  3 ---
 drivers/firmware/arm-ffa/ffa-emul-uclass.c                  |  3 ---
 drivers/firmware/arm-ffa/sandbox_ffa.c                      |  3 ---
 drivers/gpio/gpio-uclass.c                                  |  3 ---
 drivers/gpio/nx_gpio.c                                      |  3 ---
 drivers/i2c/mxc_i2c.c                                       |  3 ---
 drivers/i2c/nx_i2c.c                                        |  3 ---
 drivers/i2c/ocores_i2c.c                                    |  3 ---
 drivers/i2c/soft_i2c.c                                      |  3 ---
 drivers/i2c/synquacer_i2c.c                                 |  2 --
 drivers/mailbox/imx-mailbox.c                               |  2 --
 drivers/misc/atsha204a-i2c.c                                |  3 ---
 drivers/misc/fs_loader.c                                    |  3 ---
 drivers/misc/imx8/fuse.c                                    |  3 ---
 drivers/mmc/ca_dw_mmc.c                                     |  3 ---
 drivers/mmc/f_sdh30.c                                       |  2 --
 drivers/mmc/jz_mmc.c                                        |  3 ---
 drivers/mmc/msm_sdhci.c                                     |  3 ---
 drivers/mmc/mv_sdhci.c                                      |  3 ---
 drivers/mtd/nand/raw/pxa3xx_nand.c                          |  3 ---
 drivers/mtd/nand/raw/tegra_nand.c                           |  3 ---
 drivers/mtd/nvmxip/nvmxip_qspi.c                            |  3 ---
 drivers/mtd/spi/sf-uclass.c                                 |  3 ---
 drivers/net/dwmac_s700.c                                    |  3 ---
 drivers/net/fec_mxc.c                                       |  3 ---
 drivers/net/gmac_rockchip.c                                 |  2 --
 drivers/net/mvneta.c                                        |  3 ---
 drivers/net/octeontx/smi.c                                  |  3 ---
 drivers/net/phy/fixed.c                                     |  3 ---
 drivers/net/phy/phy.c                                       |  3 ---
 drivers/net/phy/xilinx_gmii2rgmii.c                         |  3 ---
 drivers/net/sandbox-raw.c                                   |  3 ---
 drivers/net/sandbox.c                                       |  3 ---
 drivers/net/ti/keystone_net.c                               |  3 ---
 drivers/net/xilinx_axi_emac.c                               |  3 ---
 drivers/pci/pci_octeontx.c                                  |  3 ---
 drivers/pci/pcie_dw_meson.c                                 |  3 ---
 drivers/pci/pcie_dw_qcom.c                                  |  3 ---
 drivers/pci/pcie_dw_rockchip.c                              |  3 ---
 drivers/pci/pcie_dw_ti.c                                    |  3 ---
 drivers/pci/pcie_layerscape.c                               |  3 ---
 drivers/pci/pcie_layerscape.h                               |  4 +++-
 drivers/pci/pcie_starfive_jh7110.c                          |  3 ---
 drivers/pci_endpoint/pci_ep-uclass.c                        |  3 ---
 drivers/phy/marvell/comphy_core.c                           |  3 ---
 drivers/phy/omap-usb2-phy.c                                 |  3 ---
 drivers/phy/rockchip/phy-rockchip-pcie.c                    |  3 ---
 drivers/phy/rockchip/phy-rockchip-typec.c                   |  3 ---
 drivers/pinctrl/mtmips/pinctrl-mt7628.c                     |  3 ---
 drivers/pinctrl/nexell/pinctrl-nexell.c                     |  3 ---
 drivers/pinctrl/nexell/pinctrl-s5pxx18.c                    |  3 ---
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c                      |  3 ---
 drivers/pinctrl/nxp/pinctrl-imx.c                           |  3 ---
 drivers/pinctrl/nxp/pinctrl-imx8.c                          |  3 ---
 drivers/pinctrl/nxp/pinctrl-mxs.c                           |  3 ---
 drivers/power/domain/imx8m-power-domain.c                   |  3 ---
 drivers/power/pmic/bd71837.c                                |  3 ---
 drivers/power/pmic/mc34708.c                                |  3 ---
 drivers/power/pmic/mp5416.c                                 |  3 ---
 drivers/power/pmic/pca9450.c                                |  3 ---
 drivers/power/regulator/pwm_regulator.c                     |  3 ---
 drivers/pwm/pwm-sifive.c                                    |  3 ---
 drivers/pwm/rk_pwm.c                                        |  3 ---
 drivers/pwm/sunxi_pwm.c                                     |  3 ---
 drivers/ram/stm32mp1/stm32mp1_tests.c                       |  3 ---
 drivers/reboot-mode/reboot-mode-gpio.c                      |  2 --
 drivers/reboot-mode/reboot-mode-rtc.c                       |  2 --
 drivers/remoteproc/rproc-uclass.c                           |  2 --
 drivers/serial/ns16550.c                                    |  3 ---
 drivers/serial/sandbox.c                                    |  3 ---
 drivers/serial/serial_adi_uart4.c                           |  2 --
 drivers/serial/serial_htif.c                                |  3 ---
 drivers/serial/serial_xen.c                                 |  3 ---
 drivers/smem/msm_smem.c                                     |  3 ---
 drivers/spi/ca_sflash.c                                     |  3 ---
 drivers/spi/microchip_coreqspi.c                            |  2 --
 drivers/spi/mvebu_a3700_spi.c                               |  3 ---
 drivers/spi/omap3_spi.c                                     |  3 ---
 drivers/spi/spi-sunxi.c                                     |  3 ---
 drivers/spi/spi-synquacer.c                                 |  2 --
 drivers/spi/spi-uclass.c                                    |  3 ---
 drivers/spi/tegra210_qspi.c                                 |  3 ---
 drivers/spmi/spmi-msm.c                                     |  3 ---
 drivers/thermal/imx_tmu.c                                   |  3 ---
 drivers/timer/ostm_timer.c                                  |  3 ---
 drivers/timer/sp804_timer.c                                 |  3 ---
 drivers/usb/common/common.c                                 |  3 ---
 drivers/usb/phy/rockchip_usb2_phy.c                         |  3 ---
 drivers/usb/tcpm/tcpm.c                                     |  2 --
 drivers/video/hx8238d.c                                     |  2 --
 drivers/video/imx/mxc_ipuv3_fb.c                            |  3 ---
 drivers/video/nexell_display.c                              |  3 ---
 drivers/video/rockchip/rk_lvds.c                            |  3 ---
 drivers/video/rockchip/rk_mipi.c                            |  3 ---
 drivers/video/sandbox_sdl.c                                 |  3 ---
 drivers/video/tidss/tidss_drv.c                             |  2 --
 drivers/video/zynqmp/zynqmp_dpsub.c                         |  3 ---
 drivers/watchdog/armada-37xx-wdt.c                          |  3 ---
 drivers/watchdog/at91sam9_wdt.c                             |  3 ---
 drivers/watchdog/mt7621_wdt.c                               |  3 ---
 drivers/watchdog/orion_wdt.c                                |  3 ---
 drivers/watchdog/sbsa_gwdt.c                                |  3 ---
 drivers/watchdog/wdt-uclass.c                               |  3 ---
 fs/fs.c                                                     |  3 ---
 fs/ubifs/ubifs.c                                            |  3 ---
 include/relocate.h                                          |  2 --
 lib/efi_loader/efi_capsule.c                                |  3 ---
 lib/efi_loader/efi_gop.c                                    |  3 ---
 lib/efi_loader/efi_rng.c                                    |  3 ---
 net/eth-uclass.c                                            |  3 ---
 net/tftp.c                                                  |  3 ---
 net/wget.c                                                  |  3 ---
 test/cmd/exit.c                                             |  3 ---
 test/cmd/test_echo.c                                        |  3 ---
 test/cmd/test_pause.c                                       |  3 ---
 test/dm/blk.c                                               |  3 ---
 test/dm/i3c.c                                               |  2 --
 test/lib/test_print.c                                       |  3 ---
 test/log/log_filter.c                                       |  4 +---
 300 files changed, 22 insertions(+), 851 deletions(-)
---
base-commit: c7fbe028ee5bc83df833a73e1491f1a483b65d98
change-id: 20260202-cleanup-560c900f7bc3

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

