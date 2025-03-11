Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7562EC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 09:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF0B811C1;
	Tue, 11 Mar 2025 10:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="hMqTjlhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B08D81335; Tue, 11 Mar 2025 10:38:12 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EA5807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhFUh0WXgSEzNzW0Mu7ERwYvTRAcl9FgASSmGQmDtVJntQBXTGwg0lzkHJ+ImHdWbRj3uF4D7FJ2nOoNnKLTb7EzbMmonbFzCnBCCltVZ1oYZgIyLjPofTRUPqZQKyAKF3yAn9gNQEmkeQfqDOGwGQzbq1fynzSZZH/oxJUT4oktqku5JP6OL3P3gzkHQnLwoG9NaHjH4J1bo46A3olEjXlQEmW5zg/zpsqztcmOtUAVBICZmovi9ngFt9qed9KPP4LRmAIxu2vYGrxNDQb4pBUmP7vvmNF9PznQ7OieGVQLPKMpdVShsObuwzCAQ2NzvrhMZh9MQcbT5KitIWC/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD/Zxw3j5CVGSy1W4hAUgoEj/bZrBukkPYJ0aA+Zr24=;
 b=Bvud97sW2pvmjD4D/jdW6UVorE9slfYi6NMwi03EBhqn+8cZoUkQvVU7YnY7hiSxiFOF23yypN0ur3wVsFpvO/LC6TOCU3Paz/LNLkELAtt3w4D3y3X7fdJOOdlNvS2WFHXIMoqqjFwgj4VNDygV0Q86uqU3k4mWzHM0rGFjU9HsQNf1mWl4CVVfGh853mXkxK9cDUjept6b8lnq59nswF7VyYVIcZLhcQ+zu2fUPYAKDUGFrfsYhf1x6iZivTneAe1KIhqMexqhx1aP0IzHBDJ9KG5dK6zeQpZCzX6LPCcujjjnZpU2iseoUMCHx6r2BvA39hBv/Z7JPfL/41bwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD/Zxw3j5CVGSy1W4hAUgoEj/bZrBukkPYJ0aA+Zr24=;
 b=hMqTjlhzsl308YOhKB5MNKcwtBaNlEYVo6MlztHt44MiDdhI8qdGsqf0wlPOlSjXNrVTgJWOTcHrIkNbDl26H9jo5GZmcJaxAaBlOOIVzATPXT5/SJA/sRqc/dBaAq14GCSxgNeYuF+R3EfJi2CpC2uCZQ7+Nz8FeoLIe+6T90xC1yOTG1iTvPFF5MVylzLU4uj/sr5TT+j/CORvVuEtjS6Xq0B3ibsydkp/0ciScnSM7FKDivGo6ZSf5iaOU0TXjdU2TJl3oP/YJp/4ccdjz61GhRKzYmGK1pcMbhyZwn2aC6xP+F6j0LGg2pyKl4p2QuZNeDUjk0RMzy6+3Ytjwg==
Received: from DU7P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:552::23)
 by DB9PR04MB9625.eurprd04.prod.outlook.com (2603:10a6:10:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:38:05 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:552:cafe::2a) by DU7P189CA0026.outlook.office365.com
 (2603:10a6:10:552::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 09:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 09:38:05 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.107)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Tue, 11 Mar 2025 09:38:04 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by VI1PR04MB9812.eurprd04.prod.outlook.com (2603:10a6:800:1d2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 09:38:01 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 09:38:01 +0000
Message-ID: <282a304b-29e4-42aa-84de-485944377806@topic.nl>
Date: Tue, 11 Mar 2025 10:38:00 +0100
User-Agent: Mozilla Thunderbird
To: u-boot@lists.denx.de
Content-Language: en-US, nl
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Reading QSPI on zynq7 broken since commit 9bb02f7f4533
Organization: Topic
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM8P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::23) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|VI1PR04MB9812:EE_|DU2PEPF00028D01:EE_|DB9PR04MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcdea11-9139-4b37-bd83-08dd60806ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?bDJ3bjRhK1BvUys0ZUZOVkZpVjBqYWlrb0Q3WEJKMExiaGJkUVUwdndBYWky?=
 =?utf-8?B?dm1qQ0hrZU82cUN0REZOK1RtQUNZd1BnS2I3WkdCVmMwaGdmcU4yUTRIalM0?=
 =?utf-8?B?ZkQ3R0lkdVhpdlUrTWpZbUNzdmRLbW1PTXBKN2JnZnBYUFNSWTBoa1k3akYy?=
 =?utf-8?B?Qk44U3c3TnVRWGJDQW91ZjF5SVNMVnh1QXJsSlJLUGdmeUU1STF6d3pVTzlV?=
 =?utf-8?B?NUdUYW1ia0xtbWNxbWFBWk5BUmgvRnMxQUduZ2UyRCtyd2RkN0NZS2wvWFhi?=
 =?utf-8?B?cFlWR0RtZk9rS25NVnFjQnQwS1o5a0V4VTJXd0syUmRmaXhpL3VFZnJNK25K?=
 =?utf-8?B?ajN6QkpFVTRSVjBuK0Zta0pLZkNyRzBuYnJSTWQ3VTh0a2t1VXkvT2FHVXU2?=
 =?utf-8?B?NUpPWXUvbjdxTktEdEVoVkNVNHphbWd0TWNLOWRhczNxekpaZ3ZqRG8vS3Bz?=
 =?utf-8?B?Rld3cWJTR1NzMEV6bmg4cGcrR1UxNVBPNldaNWxPc0l2eEt4bmk0eW9QRUVS?=
 =?utf-8?B?VXkrSkRrc3k1WkVOanNSdlQ1cE0rY1RrNHpTK3NRTEp4VE5RRVZaMkRjSzRC?=
 =?utf-8?B?S3NXMFBnaE9ITTFVSDRlQVZZMjVwaTRHNVdTMm5xQ0dyZDI4VVpxOFN3SG5l?=
 =?utf-8?B?L1BHa1lYL3lvWlVMY0tjMmcySGxHM0FsTHo2ZHFFZHhmOFZIV0I1UWR6MnZO?=
 =?utf-8?B?clc5VEI1UWp3SGxGdzR4c1ZPMTc4UExxanFtalBJUENTbjVBUjVKRFJsT1lo?=
 =?utf-8?B?MVhwZS9pQjMwdWRkWE8rRk9kYWFUeGJUelhFMDA0T21IUU5EcTIxMEh6K2kw?=
 =?utf-8?B?QUk3M1hhMmMrL0pYQ00xREluQTFJZ2FUTjZTUDB1dENDcDVNbW5TeXdSZzBV?=
 =?utf-8?B?REVpNFZhWmp6NXFhcis2YThURmxwNVVvR1JZeEF4ZXpEQnBHOXA1bFBoQWxj?=
 =?utf-8?B?YmlXNEVsY1FyeTZOZzZlKzEvN3dkbXdvWVNqaHMrTUUxQTZtSE04NTg4bU5m?=
 =?utf-8?B?dWsvcG1ObDJKaDdhdkZieXpETDZLR2tNclpNQnc4M0pBVGpWTzJsaGk1WTF0?=
 =?utf-8?B?b0xPQU55akk1UkJ1NzdieGFMTkE2TXhDY255ci9KdTViMzJ6UGhOaS9ESGdn?=
 =?utf-8?B?UzJTTkdjRlBlTXlvM2dzYjZicW1QQ1pPQlQyQjd4ZXNEWHZMRURWWGZiK0c1?=
 =?utf-8?B?ZWI0TGdFd0RSM29RQkdpL3FmcnI0M3pOMkNuMWdtUlFaVElONDBXaFhzQ2c0?=
 =?utf-8?B?ZHBzMHk2RGpGZkpMdDBnd3M1aWZ6Rm9HRGUxMlVBT1YzZFExRzcwNElMN0Jx?=
 =?utf-8?B?SWNVTUw1U1NYcDNPSmJ0RDJZa0o0Lzdtd2YrWXpaSHUzUmp6S2ZrSlRPdUc0?=
 =?utf-8?B?NmxpV2N0bnRjZ2hkeFE0NGhYeTFMdDdoVlE5WDQ1V2JqRTIxZlRlSEtvajN4?=
 =?utf-8?B?Q0QyRVNlV1F2K1V4R3NycFpzY095cnI1Y0NVM0ROS3dNeWlkV0d2aFpRQ3Ba?=
 =?utf-8?B?YTZsZUxrL3NCMHlRdldLRnh3Ulh6YThNdkF1TEdkcU5Id2xDUDNrY1VyOE91?=
 =?utf-8?B?ZzQrZE5qbTNTbHIxL2xWb1M5UEZMTk8vNWZPYWNOaWlKdTBpTTZjcjg3RTUy?=
 =?utf-8?B?NnVmcjhNT0hldkdTZ0MyaGxWQjk2TDNyQ2VFZk1tUTBGMVh5aFhxUW1ZUk9y?=
 =?utf-8?B?VlZZKzBSWG5Sbyt2VkQ3NVAzMFhDRnFXOU1hMnA3QkZyQ1NVaGdxdFE1bjA5?=
 =?utf-8?B?SmxnL0xvb24zZlNXaWlNVHFTc3JqWm9sLzNYemNiQlVpYjkzOHlwWGZsNWIz?=
 =?utf-8?B?UW1kU3ZzVEJlZkt3T1JHcktaTEgzMGIzS25HSFhFZkhIcWh4WXN4ZjRmRjRl?=
 =?utf-8?Q?/IcLyMYV50PVs?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9812
X-CodeTwo-MessageID: 919fc3d2-fcd3-45f4-b050-6a3cff531dc4.20250311093804@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: df7061e0-2bb8-40d3-cb1c-08dd60806a48
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|14060799003|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTVlYzBqWmN4NzJJK2ZYVGR0dUVvaTBaL2JzYmlPc3hzSDR5ZERZOVg5QWwr?=
 =?utf-8?B?a0tVcnJ6Qi9QRGJDNy9lL1ljcGIyQ2VtOWFobkcwajk2dnhpMXRlUkJYZjlU?=
 =?utf-8?B?U2RLR052UU1DMnBLTUpZZE56SzM2ZFJuUlZ3TmhvZEgyS0p5dk0zaEZOVkJ4?=
 =?utf-8?B?R2piUmxDNzArWDRRT1g3bHpKTEVGSXFWNlAvbnFMUG9XR1N6Ym9aWVdubUxN?=
 =?utf-8?B?QWYwWGswWmFpZVJqQ2Z0VHlYd2xNWWp6VTFPYkxmeHd0dmlYTlAwQnMrb1Q1?=
 =?utf-8?B?eDRkR083RHpvcGw4L2UrM3kwMkVGWURJb2tWenc2UHJJdG0rZkxjNjFhSDl1?=
 =?utf-8?B?ZWFkNk1veEF3TTdkSU52ZC9Gcm1iaHVmcENaNVZDRnhNcFFvQWlHbFF2eTJF?=
 =?utf-8?B?MW95NFhpNDZGK0pSTmFrbEZWeVIxZ3g2MThyTmZRK2RtcEdlakJXc1ZXM3o3?=
 =?utf-8?B?VUs4dWFIb2thaEh3UGM2d0lUd2Z4RS9UMGFWcHEvelUrb3VVZHZ1VlpQaXlJ?=
 =?utf-8?B?Y3hVOVlnc1hHSkMyUnpwK294NTdKSDdlTkVQQnhWWEdCOXZCazdXMXoxUHE5?=
 =?utf-8?B?MUxDQktyaklLV2N0TVNWeEJNYVltUjBWWHZncnh0UEhlb2pLQUc3ZUt4SXVV?=
 =?utf-8?B?d25aWGExQkw1MHpYcDFWbGZBOXY2YWs2Y04wWExTZ3VWOFNvUHI5SzkzcGly?=
 =?utf-8?B?R0N1RGVWWHY3VWxBQVZ2amwxbTRaRTcrSHRtclF1QklHM3J0cnJ3K3BDbmRN?=
 =?utf-8?B?czF4cEVzaUpCcWlaK2d5YUVkZlpLM280RmF0c1kwbUFiTUZWbC8zcC9RYmxQ?=
 =?utf-8?B?MmZJcVU0VEMvQlpYUkEzaHF4VWFyMHFSbzlhRVRqNWJSM09WdFV5NElpcmpP?=
 =?utf-8?B?dENHazR1YS92b0U3eWJCamN1VWoxcHN4SUtuZWF6dHlBcGJFYWZib1NGMzVx?=
 =?utf-8?B?U1k3MEFzM2F2M3h3dFZEKzBRL3c1SVNyQWU3aW1uMEJqekVPZXFxSmVjeDF6?=
 =?utf-8?B?LzFRK0FqeXYzNFBZZXVxMUdIeFBaenRuOHVzcGhyWm4ybmlNYXAzeERUY2NZ?=
 =?utf-8?B?a2RESUlDbXBNSTZzOWw3MmJqRjFFSkFvS21QQ1gwL3NHMGw4T29BQ012RlVB?=
 =?utf-8?B?eFptWStvSG1pcDdRYVJFRmhtVFJoZUtkLzNPU3k5NTl2QWN1eDVvWGt0YjVt?=
 =?utf-8?B?QjcvMGdzNlozVjBqaXVvMGJFVnhNU3c2M1pwenlwNEVZTDF4KzBreDhTbmYv?=
 =?utf-8?B?dDMvbVYzQVpFOTFHSVZWeWRjVFZxVzkyVjdCQkMzSjN6TWNoaWFWQmhOS2ti?=
 =?utf-8?B?TGVMNGJoYWpYVDFhQnM0K2ZUZ1d6c3BCSHk3ajYwV3djb1Q1S0pHQTNqSlpE?=
 =?utf-8?B?dXl2Vi85VDhHM29DZzljN21yZXJ0OTkxc1M2akNyc2dWMUgyU2VaeTZkdUNl?=
 =?utf-8?B?ZHcrNVZPYVl2b0tVUUNwODNza0wrRytxMDVFM2ljRW52aVRRZjlKYWdBOVJr?=
 =?utf-8?B?OWRBbDZHbVlvcUwwV1BKUWN3UVBQVXlhVlR4SkxiTXUyWUtWd2tFNk5sbjZx?=
 =?utf-8?B?M0VLNXlzZzM2TS9yVkR3Vi8rd0JLWkwxUGhvNjFyNVRiNzRTYmRqdzU5QnB2?=
 =?utf-8?B?S1Z1amRzRzdMa1N2dWN0RllEZzJKRzhNREVKcWtBZG5NVXNCNmp2VjZERHVL?=
 =?utf-8?B?bWxTejR3Tnc2QmwxVy9nbmVLRWZQL1JENmR3OGlsNU5abDF0cElaOG41Y0hE?=
 =?utf-8?B?VExQSCtKMGpLVjl1Ui9zdVdZTXI2S3lkalk1clhmZnpaNnZqUGZTcjU2TVFW?=
 =?utf-8?B?bVZwQ0VvamxLeFRKNkVtSitSTDdSdlVPd0NRUXB4ZEpaVVREYkRlS0lNcmRl?=
 =?utf-8?B?WXFseUl6eWRuNnY0czA5dWs2bmgxeUo2bVBwaTBHYWEwejhvQjc0WTN6TGF0?=
 =?utf-8?Q?A/rerJPZy1U=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(14060799003)(36860700013)(1800799024)(35042699022);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 09:38:05.4798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcdea11-9139-4b37-bd83-08dd60806ce3
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9625
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

After a bisect session, turned out this causes my topic-miami board to=20
fail to boot from QSPI:

Commit 9bb02f7f4533: "mtd: spi-nor: Fix the spi_nor_read() when config=20
SPI_STACKED_PARALLEL is enabled"

I haven't determined yet what the bug is exactly. The board has a single=20
QSPI chip attached to a 7-series Zynq. SPL fails to read from it since=20
this commit.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



