Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9567C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2899580FB9;
	Wed, 12 Mar 2025 09:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="QCJRFSD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0C18141D; Wed, 12 Mar 2025 09:43:59 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1AE805D7
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8bpGq/2MLlMRDgpZPnOVsQulJZjk5XqyIakRnCijhteYMlEyVVHf6+dk7GPFmA8/Z1EbPJxBy+DhDnKG6sRVaUSvlQw5DoqSSIjvCtXIAJA9OERGvp6DL951FmvvnKFyd1WCgjhbDqJVoVuFdNi444JbREzSZQn3sTlrOmRHlZXGRCAA+0LPfBS9d/sCBZsKoV4ziO3SZW94keQWrBDIS5yEniqf5UL3bTxRe981Xnwh8X9U/BxVXpTekZvMAmWhmtPA9+I5drYHQjf3xFAJ2bekTl68g2r1AHjs6ANYnUYOH0H5R6t8fQFNkjWtv8T7mbh3aOgSSgbXfDEnRzG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpq4J4Rf6anCJyUa/yhl5AaBi/K+1DL3S+PFwE8yFsw=;
 b=GrspJLY38Q7wHYuelQjZ34WI0ZOLWhCpv0A+2OCTo0x2mCDv39y67UDkHeSOr4oxB6k1kGS3X/Cd6rsjAYGTBwphgksQXeYYcnU74zxfwVAUcPzlPibu/vN6gVzspW4FUAu/2gLP+8T6JrypBOQhx9BQoHISzIELeySSs8lO2Yeb+81RVevXkItNCcb5E/fdONNnFghfIurgMIOxMSIybUwnF7U5xfTQXKFFUaAf8vLI9FckjH8QlyGZTm3860X6NW7tDfHMoG/ss24OWX9/Yu/TDOn6IlPuDr4AOjDzwlvDDGHEH5r4LY39s+5iOLvls5IK0MyEjM9w4OisV6DSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=amd.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpq4J4Rf6anCJyUa/yhl5AaBi/K+1DL3S+PFwE8yFsw=;
 b=QCJRFSD/IrPQW6NxM5O529frsivn9Gk6CYDP4zkNJUm+uvwkRlbeOUMsUL8XiLIjIPIyI9FTFkssHcxZ0Mpuz3yYVbRVclbgRwR3xo0uEajy0O/KHrybHimN7c4lW8vmv1QR+sQl1ble8YN7B0kivIhgyHWM3m59GmA5XvJ/2PTouBjufKbfepQIKJPXxT8COT94xWVHOdbgscYkF3xQVFxJ3IR5Cilp2LNXKlPr+A5cZgSxZUawX2pP5kJSF5w9xPp5Ei3W4i58ViXh+qMxtcWltZ1bBbbFXgokKW2NaTs44yttxXx/30fd9kqqzRWmhVXW5due/a9we+duwsyHdw==
Received: from AM0PR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::24) by AM8PR04MB8002.eurprd04.prod.outlook.com
 (2603:10a6:20b:247::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 08:43:53 +0000
Received: from AM1PEPF000252E1.eurprd07.prod.outlook.com
 (2603:10a6:208:aa:cafe::a4) by AM0PR01CA0155.outlook.office365.com
 (2603:10a6:208:aa::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 12 Mar 2025 08:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM1PEPF000252E1.mail.protection.outlook.com (10.167.16.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:43:53 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.9) by
 westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 12 Mar 2025 08:43:52 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by GV1PR04MB10425.eurprd04.prod.outlook.com (2603:10a6:150:1d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:43:48 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:43:48 +0000
Message-ID: <311f7735-6447-4d51-8896-ebbabc6e6a49@topic.nl>
Date: Wed, 12 Mar 2025 09:43:47 +0100
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH 1/2] xilinx: Allow alternative boot strategies in
 zynq-common.h
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.39d305af-e006-447e-a675-c4e243ffeb48@emailsignatures365.codetwo.com>
 <20250311070124.20696-1-mike.looijmans@topic.nl>
 <84b5bf66-fb4f-4590-b6ab-fa1ee3011aa4@amd.com>
 <5f2f81f4-7248-40ea-969c-9f37686ba8a4@topic.nl>
 <0ba5c795-8775-4bbd-998f-692095496a16@amd.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <0ba5c795-8775-4bbd-998f-692095496a16@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|GV1PR04MB10425:EE_|AM1PEPF000252E1:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 175309c6-2661-42ea-10e7-08dd614204bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?NjlXclZZR05zQzl1SVQ4elRuUndWR1Zkd0VOR1NBNkN3cnRSc1BYQUp2UDlB?=
 =?utf-8?B?djMzSnRHU1NpRmxJaDAwRVJjZW9KNC9kaytvUEQ3dHhHK3VUc2RNRlhSajFU?=
 =?utf-8?B?WnI2bDVncmd3aHRaL1F3SXQ5WTZXWWZBZmlBd2E0YkJvWTREMnZGNjdMRTJD?=
 =?utf-8?B?TjdEbzJNWnJNVlB0ckVaeDYyM2VGcGJ6ejRYMktYSTRGTDhaRXA5WVFkTTVG?=
 =?utf-8?B?QVd3bWo4TnF6SjRBZGRSTVQ3c0plQkFlU2tjbWNJS2kwelBXYnJEY1NVSDVT?=
 =?utf-8?B?VjZVRG5oWC9rbjB3ZWpoMlBVM1k1TDRtSTA2YnExY3k3cmFBOENZZElsT05X?=
 =?utf-8?B?Y2VNcUdJeVl3SjNEaVdLNWFBWU45bWp5QzJWWjhtQTRXSk9ZWEZMcGlJNXdX?=
 =?utf-8?B?ZFZPL3l0ckdJVlh3eTNjaXk3Tk5MbmtQRVRla1NyVVJrYXNMVStnQnFYOWE5?=
 =?utf-8?B?Z3kwUU9CUGNiU0Z6Ukl1amU2WHl2S3VxTytkNmlNVzdVQ0R4cFN6RnVZeEtD?=
 =?utf-8?B?dU9xT1Z1QVRBN3RIWFRwMnA2bGhvQjNJVmJLOGVFWHEyYkI0R2dJWHFnNGlQ?=
 =?utf-8?B?U1Z0SnVVSWRNV3YrQWVTUVBiaEpFd3FZV3VibTJSWmxXclExNllVRDN1c1RS?=
 =?utf-8?B?U0xMcmpkUUVpcjArQ3RSaDZJUnNQV1BMcFhyVVQ0MXM4NGlUVXhTT25BSW9I?=
 =?utf-8?B?TXFqZ0hHRDlBby9hSmt3SC9OK2FLd2owb1VhVUFvTDgzT0NTZldPdFhCL3JT?=
 =?utf-8?B?b2IwUXZsNGZTaE9rSENBbmNDMzIxNEVoUFdOWW96L2VhMGdUN2QyWUM1MlYr?=
 =?utf-8?B?WlJOLzRwK2xXaWNlcE0yaWx3Ym1aeVJPYllKUEFHTkxNOVFMME1GVXg4K3Mv?=
 =?utf-8?B?bmZRekhER0g2bW9QUjJDMXhodXJ4Um9uc2NIOFkwR0hvRmc1UVZDUUZQTFFw?=
 =?utf-8?B?Z0FWN3ZrM3g5N2dBSHNUZSsxMTdySjRtNlZlNlNzTHVSV1VGNzh4OTI3WTVU?=
 =?utf-8?B?Rk92Ym54cUVBNWxoN3Myd2gwWk5uMGUzQUpkTXk5R2ZSY0ZmQ3ZTMXdZL1JN?=
 =?utf-8?B?WmwyUlBlZ3o1RHJhWDRHaVZqbWJLaFQ2T3gvaDY0ZG84YWFJM0t5azUxWHp3?=
 =?utf-8?B?NkZQWEhkSXEwNm1Tcm5JeFZGSDZkVUxoME1EeUdxc2lwRFlFQlN4QzJlc0ln?=
 =?utf-8?B?OStNZzBSRm1yajJnVHk5NTJ6MWY1SDZ6azNUNkpWWFRKZmloQy83TjllRkdY?=
 =?utf-8?B?aXBHTVA2aUk5emgvNVIrbnVnTklSZWtVNE1xMU1JVm0wVlRFRmZUWGlHNFZq?=
 =?utf-8?B?SUkwb2NOZjFQYThKcHk5LzBUSlNIVjFNZzJXUWw1b01uWWJFOXlnL1I4ZHNK?=
 =?utf-8?B?dzFwTGRTbHVBZUtpSENvSjJudWdXYW9KVjVXSDRlcVZOTzIzQkJMYm14Nk9X?=
 =?utf-8?B?bkJVWE93cStmb3hudndid09ZMk9QS1dpVHp6NXd0Qks0TkJoYnc5SE5KUWIz?=
 =?utf-8?B?dXZMai9ISXBHV2FndmNCbjRWeEsyeWF6dVd4ZmQxOGpuRXYvTEpEYjBsbWJ3?=
 =?utf-8?B?QjRudDJRdGZLQ3Rrc29vK2ROL1JpUmdzYmJ2K25hSzFseDAvcHB5VXptVUlP?=
 =?utf-8?B?MTBqQ0hQZ2tCWXRUREpzTDdaNmVIYkFtWUhnb3lNVytRd3ZOdS9RNjJQTUhy?=
 =?utf-8?B?YVF3Y1F6aVNiMUtDYk5LbndGczI4UHJ6NlNBTUh1UDVXR3QwNWpBM2hrSURi?=
 =?utf-8?Q?FYCkI4QZii2Ses3FmyrJx9FhP6v7aTJZHntY3ss?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10425
X-CodeTwo-MessageID: 495ab79a-e025-4577-961b-c3fa8894edc9.20250312084352@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3829980d-1389-4f07-3f7c-08dd614201d1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|35042699022|82310400026|14060799003|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Kytnc2J5dUNwcThiWjNsMUpKaWZRS0Mra3QyRENLWDYwb2t5dU91RkdsT0FG?=
 =?utf-8?B?MUJaTWg0K3I5Rko1WkMyNFVxNDBNVzUrSUVWSVNDMnd1MXg0a3c3YThPbGM3?=
 =?utf-8?B?dUxQR2hyMnZtQWF3WGx0R2Fob2lPbzYyVTZBc0hJdll5YXRVdmgyZzFLdVFC?=
 =?utf-8?B?VkY5TldaWVByMjVpR3BQZHdvTWQycGZHZ3BWNk5JTmszUWFTY1ZDWmpmQlda?=
 =?utf-8?B?RWY5NHRMTkpoY2Y0UFdnMDdKTXE3a2ZkV05MbDVaOFJzbXRON01McTU1VXNE?=
 =?utf-8?B?cTFYZmVENjRKTXRlVWdMV1gvM3RSQTRtTkxCdGVJdDNpdDNCSmRTd2RVNUZX?=
 =?utf-8?B?eWpnU2RBK3RRbCs4ODAzTTdYZDdMUzF5WTlMak1CbEg0enpxaVhQc0x2cGFa?=
 =?utf-8?B?RzZ4VGxEWXduTlBQSHVsaTZGSFdLQ1pRV3lWMXdmeE4rbnBDUVJHQXdwZGFP?=
 =?utf-8?B?dFVmMVlvci9GVVpCV0l5RlpZR2dHWk5wMW5oaHo5aFpkT3BTdm1KbTZOL3VY?=
 =?utf-8?B?bWZBTUNXZS9TOSs2dWdvYUg0dDdLanRjYWErRUVKL1JUQjNUdzUxU2o0MUwv?=
 =?utf-8?B?K0FqeTR1YmZvYmdJVFNVcmg2anNDSGVjQzgwSnBjQ05mb3Z5dHBxZVgvVjFj?=
 =?utf-8?B?YS9aUDJsYk4rUEdKM3BNRmlPckgreFlQbVRraEpNU29xUVBmYlhONHQ2aGhN?=
 =?utf-8?B?N2plOFBFTVZ3c0dSbC9sWkdScUJDOE5YalF2eWhGMzZzejBYZUhFc0xOODZD?=
 =?utf-8?B?U3ZVRC9iakc1d2s3aUxMNHljR0tqZlhlZ0JFYWVIM2t1eTZab0wvNkNYeEVI?=
 =?utf-8?B?UnBnRmNJeUk1N1B6ZkFxTlhTNWF5L1ZDRXN3aGU5LzRXZkRUeE1JcEFXSjFN?=
 =?utf-8?B?QUgvdzVwZkx6cTJHVUlnT051LzVxZDFXWHp3YVEydHdYOHZvZm9OaHdIMlR6?=
 =?utf-8?B?TzhpV0ZFVnFQU3RtRzVZUEdISy82MERva2QzWVAwQy9sMDRTb04xUHNzcE4x?=
 =?utf-8?B?cTc2amFlUmx2RGpRYmFnRjBVd0dmQTdOcTY3M0hEZEVMVTdIRFZkSFZsMThP?=
 =?utf-8?B?cUZIalVTSm1uV1dVcmlid1N5ZFZFaHo2L0phOGNsYmtyY2x6RHoySWw1ejdY?=
 =?utf-8?B?R0xrNHBDZXNQblBPY1I0b2cyeEc2THpkNHVGZUF1anJxNE1heFZZSEwxY05O?=
 =?utf-8?B?Uk0vaTcwc2FPYUo1YU5MZEJlKytvblIyQkpSVFNtUy9rK2t1NDJvWTErTFp3?=
 =?utf-8?B?cnRPMll2YnlKNzVvTkR5QjFQTWxaVThwcTB0N2tYQStnbmtZK2xRT29XUFI0?=
 =?utf-8?B?RFNKeWUwWEp5Tm5oYVQxbDVicjc3RmhBRFlJbEZ3eTQ5MTRWRzhUVjZqMXJ3?=
 =?utf-8?B?dTFWQTZXT2oyRVJQMThWQmJtYzBPcWpGamJxdFdBK0pkTFR6N1ZYYUFhWVNk?=
 =?utf-8?B?MG1hMlV6ZkNlZExlNjhwOXk2NHpTaTR1a1BHM0pGZGlOZXV2UmpuZHJodHlp?=
 =?utf-8?B?V0dNTUZnaUpqdUhsdVd1WVlKT2R3ZjVwSlRhODYxb0R1VG5IMjNRTktUR1JZ?=
 =?utf-8?B?ZzdlMWxiS0JMdGxleHBjeHhYemZTN21GK1doYUN3aThhVVZUckJEZHBGcTRW?=
 =?utf-8?B?SU1rTzJVcittc3B4cjFIa0ZaYzBpcDJTQkdRemo2b0VMZ3A5UFREOUk3UytD?=
 =?utf-8?B?TjVCWDNOVlY3M0NWdG1sYUQ0a0ZpUFJ5UHZ4c1dXWHBTMTlzcHJLQWRVZTZB?=
 =?utf-8?B?ek5qUk1xTHhKSTYxWkd5VUcvSmhWbFFvS0dhMkFxSjY1cFlXKzg4NXBhQk1t?=
 =?utf-8?B?YVExY2ZmR1AxOTlOVjlWUUhra21HdkpKZUhJaEV3ekhjaEN4UW9hYWUxNSs3?=
 =?utf-8?B?S2JoelRCbzEzSXF3eUhEUTQvVVlPc2Z1VXJmTGttN0grcnBncWpMN2t2VGVV?=
 =?utf-8?Q?XdaSWkx/+Ns=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(36860700013)(35042699022)(82310400026)(14060799003)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:43:53.1179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175309c6-2661-42ea-10e7-08dd614204bc
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E1.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002
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

On 12-03-2025 09:37, Michal Simek wrote:
>
>
> On 3/11/25 10:32, Mike Looijmans wrote:
>> On 11-03-2025 09:03, Michal Simek wrote:
>>>
>>>
>>> On 3/11/25 08:01, Mike Looijmans wrote:
>>>> Allow config headers that include zynq-common.h to provide their own
>>>> (distro) boot strategies. This is implemented by skipping the section
>>>> when BOOT_ENV has already been defined.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>>
>>>> =C2=A0 include/configs/zynq-common.h | 6 ++++++
>>>> =C2=A0 1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-comm=
on.h
>>>> index 37c77aa1611..ad872c9d922 100644
>>>> --- a/include/configs/zynq-common.h
>>>> +++ b/include/configs/zynq-common.h
>>>> @@ -48,6 +48,9 @@
>>>> =C2=A0 #define BOOTENV
>>>> =C2=A0 #else
>>>> =C2=A0 +/* Only use this section if no BOOTENV has been configured yet=
 */
>>>> +#ifndef BOOTENV
>>>> +
>>>> =C2=A0 #ifdef CONFIG_CMD_MMC
>>>> =C2=A0 #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MM=
C, mmc, 1)
>>>> =C2=A0 #else
>>>> @@ -167,6 +170,9 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BOOT_TARGET_DEVICES_DHCP(func)
>>>> =C2=A0 =C2=A0 #include <config_distro_bootcmd.h>
>>>> +
>>>> +#endif /* BOOTENV */
>>>> +
>>>> =C2=A0 #endif /* CONFIG_XPL_BUILD */
>>>> =C2=A0 =C2=A0 /* Default environment */
>>>
>>> Why are you sending this again?
>>
>> Sorry, forgot to mention. Sending it in a single batch shows why I want=
=20
>> this change... The first one got out because I forgot to say "-n" to=20
>> patman, but it was fine as it is, so I didn't recall it.
>
> pretty much this should be v2 and you should reply to origin one that it=
=20
> should be ignored.
>
> And in connection to the patch itself.
>
> I think you should do it a little bit differently not to have complicated=
 if=20
> else if endif endif structure.
>
> What about just this?
>
> #ifdef CONFIG_XPL_BUILD
> #define BOOTENV
> #endif
>
> #ifndef BOOTENV
>
> #endif
>
That will make things cleaner, yes. Also avoids the "#ifdef CONFIG_XPL_BUIL=
D"=20
in topic-miami.h

I'll create a v2.

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl


