Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90317C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F418582E05;
	Mon,  7 Apr 2025 14:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="HBxYyeWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C843782E17; Mon,  7 Apr 2025 14:12:45 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5685182DB4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/fuBhaBvA+svapouPUw4Jlkq7WQ5wEaWU/bSUCy5vKWEG2X3TbgNR5Vh+8Y3meOxadcbwvVOEcM4dYsOpq7wcyMbaJqfxAvPSRY2K2TO8MJYciUD5YxjY+FY+8oIPP5JtdMrNTUvJHjI9P+EkqXuoIbZ60+DCggF6REYzwM9s8tnTHKlu8KIaCLMpRcZFnqTO2rmk/jWKY3G5HSN5WRmMt0ohh4F4PNIlYnHhR9MaJqZ3T20cfUE0V3I497k0EFiGC3WOg/Z/urtajcqf0cr5dM0dxJZyS3MeCFdUxB2NE/iuB7/3Bx3yt+Rd3zfFcVbSSIAjTbJv5CkX3Wxn0M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFnGQzfoHNrzf2a1129qDAx8gOu9IlTwb0j/ESY31co=;
 b=OYPBmlhTwfQetvTvabPWwAvNKqrG1oK9OE9wuNPCmXD+DCNBgXs1O9ewYE5eAlxW0txLOet5vl2eHfLsR4yR4557nUMdk9wDkctbBEmOxiVq18fxgy4Sgqc6bnygngnjx6P6YK7xgXgj2t0qA4bAs5U9wtFXA4XB1TJya2uPAM3sFbaIvEiQ9xrmAqas1p7+rpOC/gs6W3wviGa3i0VJslXaYADB2+QutkuBNjGy1OcSmeMrIUI5g9TyIs1g5q1ydW77HvSkZw3wCHYeF5VbEdSQJHGdev0vkkTX8nhJ9LIwT7WciSzatErMmFNkmR0el0J+Jdm2o9dZZQoISt8bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=br-automation.com smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFnGQzfoHNrzf2a1129qDAx8gOu9IlTwb0j/ESY31co=;
 b=HBxYyeWIFMbBUhgt5ncU8b9l3aRk4kP8UVP0lKLs9QK5WS8QvbNl46lmDaw9nevqkS06As/An2X7AYFgshqKb7KCu4E3qWh+dpxUqueMrIdGMR/q/fxpUKIPJnY9IGRIP5SwMj2+r7AE1TUNBcH3Fbl2jj/e6fT4QFn24UUwm6GLge/zVT7cnnSQgGOqJgVWdynpmplQSKBt8bJ7/FRC+YGst5NgocLgcR4oq+C1LpWu3dM/OhJPGMGYFl1yc2GPyvEGL8Rnag+HE74j4k8ttDOstK7paxNh6gxVNdDn3kZkv1/e0glbNQvDDaJpFSPmRCxpyKdkwbClloyima3oWA==
Received: from DU7PR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::12) by DU2PR04MB8661.eurprd04.prod.outlook.com
 (2603:10a6:10:2dc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 12:12:37 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::f2) by DU7PR01CA0018.outlook.office365.com
 (2603:10a6:10:50f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 12:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 12:12:37 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.11) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Mon, 07 Apr 2025 12:12:36 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DU4PR04MB10623.eurprd04.prod.outlook.com (2603:10a6:10:580::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 12:12:34 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 12:12:34 +0000
Message-ID: <e7103890-b243-408c-8f38-8fc63cb2d08a@topic.nl>
Date: Mon, 7 Apr 2025 14:12:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Use CONFIG_IS_ENABLED for
 CONFIG_SPI_FLASH_BAR defines
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 u-boot@lists.denx.de
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
Content-Language: en-US, nl
From: Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
In-Reply-To: <20250404095612.126753-1-bernhard.messerklinger@br-automation.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::20) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|DU4PR04MB10623:EE_|DU6PEPF0000A7DF:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: e510a297-c9db-47d3-9dc0-08dd75cd7c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?bFprV1RGQWRUMU1RSmEwaWE0L3JhdmRJd1k3Qm5RT2hZSy9IVmVkSTltNHVi?=
 =?utf-8?B?aUYwUm1lVGdnOGpkSWpBQTFnYVBqNDJaZlVDWkxyWmZpN3RjRzI0Y0ZZbGIv?=
 =?utf-8?B?VmZZTjRZd0lsY1pGMFp4dGF4ZUd5bE1CMFRORnljVXdJSHM1azhMdyt6anJq?=
 =?utf-8?B?QmdGc3VxQVBGK1JzU1FlTFh1ZWo5QnRoMS94NHlITEFwemc5Sld4YUJldTlV?=
 =?utf-8?B?ODBSclcvaGtpMWRsbjVRbUdtbDBZMnZNNHQxMGlMMWFCQlBZWktleU5Jb1Yr?=
 =?utf-8?B?SzYxaGc4RmNzNE5PZVh1MkVSR3UwU0Y0WURyN29FQklraVpEMG9KNG9wZlds?=
 =?utf-8?B?NzJqQUlRT3JEWFZTZFlqTmhrdnpYS1hZNG1zTkpINTQvanNNN3NEMURaMnhi?=
 =?utf-8?B?TmZIVTVUYnFiZlpEZUZOVmFVcGJReDYrY2xMYlhQNCt5L2dVaitlOWJnR0RP?=
 =?utf-8?B?YnE3NGVNMURCK3Y5N1JmWEhtOGJtNDQ4RnV2TVdBYnB3WWg4bnJiR3FzMHhD?=
 =?utf-8?B?Sjc1cEJHb2ZIQ3ovaG9kaHRnajJybHdjNTFnYW5Cc0JTN2UwaWs5QnlLUXpD?=
 =?utf-8?B?ZEppNWlGOG9tdDkydk8zenVFcHVId2Vibncvb2VWREdXdGRBVXZGU0YvOXZB?=
 =?utf-8?B?dzdWMEd1RzhwbWU0elErVlI1aDNUMmpGc3JHV1YxTU9veUhoV1dxMEJId2Jo?=
 =?utf-8?B?aFdtZFFVbzZNNVpuOEhKZ1JtY2RJN1hpUEVnS1RZSU9zaXlHaEtnbXZGbmFa?=
 =?utf-8?B?SmlxQ25SRVVjd0JhbklFOG9RWWFEUVQwb1d5MFZXQWFpUUJmQkZ2Yzd5cmRm?=
 =?utf-8?B?eU1raVRtMUtKa01ZcWdXWGJlSFV6dHExd1ZFZlN6SnZxN202UjN1b1Erejk4?=
 =?utf-8?B?YlZ5c2NmenBwTUpTcElHbnl3STZubFNZelNxU2tyd2g0SGNJSktRS0ErM3hD?=
 =?utf-8?B?ZXdhTGJhY0xYcXdkUHQzalhKVTlwUTlCSjJWRWJUK1RRbFJTeDZPdlVFY0ZJ?=
 =?utf-8?B?d3VlNWZyT2VLRSs4bEU4aW03d3RUWjNrWmJYMFNxN05aMlZHMDR2SEp0YTMy?=
 =?utf-8?B?eXpHRkJlMTZZL3lIQy9oSjNDd1BqYkNQbkw5Nk51ZVVObFpUNmVMUXo0WFVY?=
 =?utf-8?B?RVdZWVh1ZUwyZFpjMXhiWHFwM2FxazhMcWpVYzdUcGJ6d3B0RWlFLzRaenF6?=
 =?utf-8?B?L1BDbGJ3WDJkMkd3VVJYbk5EQmNRcWhmWTUyczhSZjVqZ2tIdmVPQTNUc1Yr?=
 =?utf-8?B?a2FKQWhaemZ1THhWMVBOV2ZlZkpicFVqOVdXMWZHbnRLWjBiZ1kzWUprb1pU?=
 =?utf-8?B?SWJ3REhqR0IvS3NJUkxKQWxQTHIxSW1pQXBTU3VTZ0hlaFlKdlh3Y0tMSDIx?=
 =?utf-8?B?dlZXMTJ4QllQSlBxL2ZrdmlDR2dUZmdWRTV3UHgzS2k4Rmc0aWFGVndzK1Q0?=
 =?utf-8?B?TUlOcXdQRlRSYW9uMmJaWUFFcUZVdk9UNnNJV1lqVTJUdXNrakIwL3dCR3kv?=
 =?utf-8?B?bG92eUUxb3VVMjcwTkh1SXVacXZqRERFWlo5MVg3ai9KU2JYU3hPdmp2THBZ?=
 =?utf-8?B?N1Z2SkNQblF1MG1CTmFiaW9rdnFWUmlmT01ZOGJsSnE4dUVMTitPUkFtbEY5?=
 =?utf-8?B?NC9KRnNTcU5VUVEyeDNIZEFTN3dUZ1YxcUlBcGh2VGcybzJvZ2JVNVhKbEc2?=
 =?utf-8?B?T2YwdUc4VFJUN1JSd01LMTl6eDI2a3Q0eDh6anJPa3puMGVVeWNPSCtTOE4y?=
 =?utf-8?B?OXdXL0c2akFQemJTNE9NdUpLeW1jTlEycnZBTTBOZTh0bmYyWlY0cUc2azBP?=
 =?utf-8?B?cnB4NFlnMk4zanY2eHc5REIyR0lMWTRBUExhYlJHQ09ma2QvdUNhNVBqdEMw?=
 =?utf-8?Q?sFpNcSuknVlyy?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10623
X-CodeTwo-MessageID: e70b7a07-93b3-49f8-afd1-d2cf08ea5ce2.20250407121236@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 93c886f4-03e8-4575-4c58-08dd75cd7ad2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700013|1800799024|14060799003|82310400026|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWd5Y1h1UzljdXZIZjZsUE54eitLTUFrRjVGMmhDRDBSNUpFbGdTNW50S2RS?=
 =?utf-8?B?dSs0QU1EcXVzekR1V1lhVmY4SFpENU5jZmJjditiT2s2Z3hPVEdSbHY4TGc4?=
 =?utf-8?B?YldEOFVKdTZHeE96UGZsSEhZV3lDWGVjempGb2IzSHl5S05pM0VSUTIxTHNy?=
 =?utf-8?B?ZEZYVlhkcVEyY0N2Z3k2cjBXZ2NkRUFSak53ZUlMc2Z4UFNLL045Z0hXUkdX?=
 =?utf-8?B?djhuS3VicWZocllXRS9iSjhreHdYRWt0MEsydWFybUhFTGd6Zmtmd2R2N1BV?=
 =?utf-8?B?VU9nUnZ3dHBhMWZxRGZEU1RaMlIvYVpCRDNZNEEzRHNTK3Y5VThRODhxREI5?=
 =?utf-8?B?clMrMHIraCtKZzNqY2hIRzlhMlI5Z2I4MWpQM0luVEhqejF0TGRPdE1IV2F5?=
 =?utf-8?B?dmtFWDBOREVPZ0RpNURPT0kycnkvWFlSbzNWb0gvb0JxbjVLQ0JlNUFsc0gv?=
 =?utf-8?B?TG5peERmNURMUHhEY2dEZDNMZ284UnJHbExBL29vSWtBbGJMelFTZ3RGdE5T?=
 =?utf-8?B?b29nRUZhelh2STV4eWhqODVKaVdMYlhBL0xCVWx5RFFFbTFHZmNCUjQ4cmdr?=
 =?utf-8?B?QjhtZHJNUnIrbisxQ1NmaGo2N1IyMlNVSWNrd3JLYlVnMUJtZ0thVDNsRTJw?=
 =?utf-8?B?S3ZuOGdyRlV0OUhXU2dDR0hLa1hsR21rbnZLKytUY3ZvYzBOQXBKLyt5b1dh?=
 =?utf-8?B?U2ZYTFV5MGpkbFRSTDdRQmxCcHRmYXQvNnZ4U3dFRFliY3htOG5obzMwaTJw?=
 =?utf-8?B?TUdCODU5RFl0Y0UzMUd6dk9Fem5Ga0xDV0ZRdUR6NFpMN3pGa25sdkZRZWsy?=
 =?utf-8?B?enNKLy9hVThtcjdpZG1QaHAzZG91WEZJdTQzSTNCbE5kWE5LWFpsRVFvMnY4?=
 =?utf-8?B?R1JPNlBQZ21ySUIrU0ZBQzBEVUNxdEtIdEVjNjRhOGN0NFh1eTJ0Z1F2VjJ4?=
 =?utf-8?B?QXQ2OE8xK1k1bkk1WVdUdU5lMFpWSitzQ2NyRTVGSGZib01obkxFNm9EbVMw?=
 =?utf-8?B?cWtJWnRJbzFQYXErOG5lK0cxZ2w0OEh6QnhIL3dRbGxLS01tQnp3MVNrLzNL?=
 =?utf-8?B?NTJqS3VSQThxRysvYS81QmcvOXJFbTRnMGpOVHV6ck9rU3dJaWt0TzlQNENP?=
 =?utf-8?B?blBFdGhoQlN1c2V2c05PMGV2S2dHcWtKMzNiUDAyZXFwSUlyVHNDaVJzaTlx?=
 =?utf-8?B?NU9EbFNuVUhySFhRRFBwaDdxcERQaGxQNHlQK3lDVjRpdHJTN1pjMGMrVEpD?=
 =?utf-8?B?Q1Y1cTlKbUFib0h3Lyt4OFRpb3l1UTlSS1pZbjUxVFZ4bGkxbUV5clRLVjJt?=
 =?utf-8?B?UjhzMks1cGdFZitDSHhmV2hHd2hSVStCVTV5Y3R6NU5KU2xuZ21aOGhUNXAx?=
 =?utf-8?B?R1FtZEZyQU02YUlObHk5UlUwY1dLeWFJQy9tQjRmcEpuS3JWYlczRnNpdFZO?=
 =?utf-8?B?d1pNemlESE00RFR5QXBMQ3lVc3ZhS2RvYktHck5meHZvSm1kbmxzYmhFRWV2?=
 =?utf-8?B?Y0lEZHdwSjd3U2dIR29xOXVkbFljeGRLc2RQZnQ5VUZmRURLS3U3USt3TGFa?=
 =?utf-8?B?Z3Jqb0Vkby8xOGtZRzVyb2ZBckNTQXJnTUtiQ0NCYkpoOVdlZlNOTHFDYTJY?=
 =?utf-8?B?S0tOaC9XZlJLWWd5ejRlTVE3eVhhbFRNallkZXJPcjNvc1NPNU5mdGYxUGY4?=
 =?utf-8?B?RDJ0bVErak1JUkFBeHpzbjJ1L0ZWQWN4aFZoUFZhM1l1NW4wYnNnVUY1emJE?=
 =?utf-8?B?emgzWUNvMkNJRU4vVUVVc096dlo4b0JJQzlnb2U0WTdEdjVPQUkvb3hnazhN?=
 =?utf-8?B?MFZFTUtWblJIUGxuR0dCd25DbGRmU1Rvd2xybXZHZkdmQWJIeDhYY1RLRnRT?=
 =?utf-8?B?ZEE3V2RxTlh3cnBtOThXbVpJOHZDOWgyRmtKWFdFT1YvSjNMTXY4ZEZUbHZH?=
 =?utf-8?Q?zol62RqkJgc=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700013)(1800799024)(14060799003)(82310400026)(376014)(13003099007)(7053199007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:12:37.5212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e510a297-c9db-47d3-9dc0-08dd75cd7c9e
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
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

On 04-04-2025 11:56, Bernhard Messerklinger wrote:
> At the moment a mixture of ifdef(CONFIG_IS_ENABLED) and
> CONFIG_IS_ENABLED(SPI_FLASH_BAR) is used in the spi-nor framework.
> This leads to misbehaviour in the SPL as there is no Kconfig option
> CONFIG_SPL_SPI_FLASH_BAR. This commit standardizes the use of
> CONFIG_SPI_FLASH to get SPLs that load U-Boot proper from the
> SPI flash to work again.
>
> Fixes: 9bb02f7 (mtd: spi-nor: Fix the spi_nor_read() when config SPI_STAC=
KED_PARALLEL is enabled)

I was hoping this would fix the issues with this commit, but apparently=20
not quite. If I add this patch, the Zynq boards still won't boot from=20
QSPI with SPL, though now it simply hangs SPL rather than causing a=20
"panic please reset the board".

So far, only reverting commit 9bb02f7 results in a booting system.

Mike.


> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automati=
on.com>
> ---
>
>   drivers/mtd/spi/spi-nor-core.c | 22 +++++++++++-----------
>   include/linux/mtd/spi-nor.h    |  2 +-
>   2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index 6f352c5c0e2..a8865bbd37c 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -655,7 +655,7 @@ static struct spi_nor *mtd_to_spi_nor(struct mtd_info=
 *mtd)
>   	return mtd->priv;
>   }
>  =20
> -#ifndef CONFIG_SPI_FLASH_BAR
> +#if !CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   static u8 spi_nor_convert_opcode(u8 opcode, const u8 table[][2], size_t=
 size)
>   {
>   	size_t i;
> @@ -739,7 +739,7 @@ static void spi_nor_set_4byte_opcodes(struct spi_nor =
*nor,
>   	nor->program_opcode =3D spi_nor_convert_3to4_program(nor->program_opco=
de);
>   	nor->erase_opcode =3D spi_nor_convert_3to4_erase(nor->erase_opcode);
>   }
> -#endif /* !CONFIG_SPI_FLASH_BAR */
> +#endif /* !CONFIG_IS_ENABLED(SPI_FLASH_BAR) */
>  =20
>   /* Enable/disable 4-byte addressing mode. */
>   static int set_4byte(struct spi_nor *nor, const struct flash_info *info=
,
> @@ -930,7 +930,7 @@ static int spi_nor_erase_chip_wait_till_ready(struct =
spi_nor *nor, unsigned long
>   	return spi_nor_wait_till_ready_with_timeout(nor, timeout);
>   }
>  =20
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   /*
>    * This "clean_bar" is necessary in a situation when one was accessing
>    * spi flash memory > 16 MiB by using Bank Address Register's BA24 bit.
> @@ -1141,7 +1141,7 @@ static int spi_nor_erase(struct mtd_info *mtd, stru=
ct erase_info *instr)
>   					nor->spi->flags &=3D ~SPI_XFER_U_PAGE;
>   			}
>   		}
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   		ret =3D write_bar(nor, offset);
>   		if (ret < 0)
>   			goto erase_err;
> @@ -1175,7 +1175,7 @@ static int spi_nor_erase(struct mtd_info *mtd, stru=
ct erase_info *instr)
>  =20
>   	addr_known =3D false;
>   erase_err:
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   	err =3D clean_bar(nor);
>   	if (!ret)
>   		ret =3D err;
> @@ -1630,7 +1630,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_=
t from, size_t len,
>   				offset /=3D 2;
>   		}
>  =20
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   		ret =3D write_bar(nor, offset);
>   		if (ret < 0)
>   			return log_ret(ret);
> @@ -1667,7 +1667,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_=
t from, size_t len,
>   	ret =3D 0;
>  =20
>   read_err:
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   	ret =3D clean_bar(nor);
>   #endif
>   	return ret;
> @@ -2016,7 +2016,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff=
_t to, size_t len,
>   			}
>   		}
>  =20
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   		ret =3D write_bar(nor, offset);
>   		if (ret < 0)
>   			return ret;
> @@ -2090,7 +2090,7 @@ static int spi_nor_write(struct mtd_info *mtd, loff=
_t to, size_t len,
>   	}
>  =20
>   write_err:
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   	ret =3D clean_bar(nor);
>   #endif
>   	return ret;
> @@ -3791,7 +3791,7 @@ static int s25_s28_setup(struct spi_nor *nor, const=
 struct flash_info *info,
>   	int ret;
>   	u8 cr;
>  =20
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   	return -ENOTSUPP; /* Bank Address Register is not supported */
>   #endif
>   	/*
> @@ -4577,7 +4577,7 @@ int spi_nor_scan(struct spi_nor *nor)
>   	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED))
>   		shift =3D 1;
>   	if (nor->addr_width =3D=3D 3 && (mtd->size >> shift) > SZ_16M) {
> -#ifndef CONFIG_SPI_FLASH_BAR
> +#if !CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   		/* enable 4-byte addressing if the device exceeds 16MiB */
>   		nor->addr_width =3D 4;
>   		if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index b8b207f7b5c..4eef4ab0488 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -569,7 +569,7 @@ struct spi_nor {
>   	u8			rdsr_dummy;
>   	u8			rdsr_addr_nbytes;
>   	u8			addr_mode_nbytes;
> -#ifdef CONFIG_SPI_FLASH_BAR
> +#if CONFIG_IS_ENABLED(SPI_FLASH_BAR)
>   	u8			bank_read_cmd;
>   	u8			bank_write_cmd;
>   	u8			bank_curr;


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



