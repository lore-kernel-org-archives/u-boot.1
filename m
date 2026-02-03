Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBB9E87823
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0818683FFA;
	Tue,  3 Feb 2026 14:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dRWevnjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8684120; Tue,  3 Feb 2026 14:04:28 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1CA83FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzhtTYFwzEXu1TmWkh7xl8QtJ88anjrmDGfxQnENp+aXH6aUPxf5AcPRwh1QpFs0A2aUmWUiKQucwTNS4MvmCzYRHns7arlozXN6kYweH0eKwXTa0HAX5TSnv9VZ7OUnjX+r3ZT7EFmnIgMl2mvVNx7DsOI+8g8GRbJ8rOo/l1bwjYShfCSE7iEFwiOd8A3xmu0QBwGskwtW3CODhFiZhWLtRrphPrM0Pv7Mopt2JAxjXwQVHAh4lzPJxYBnOIOQBtdwIom1V1CVBOkev6QmkPwPCQ1c9FY1DAxw1uSV+gUmuaIgiLJPdKop7kqTTWI9OhlkFmhTdPH2On9nawYTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1wZiBU+zaohoLFV2sKFa5BwOfWuMKSXat6rhBFeygE=;
 b=LD+m7NdNTAzQeB6Do1trXEijxF74y7CjFPi8zJ3NFQtSXTDBjNGb7Qq985b+VFrEsPXA2Bue+VFpH+6KrxiiDY8+HGzxilM5v4kRGluCPjWLgZc20lYKPttAbsoAk/mmaK3nwic15+n1L+59jZ1puy5+uVe0kpgkLJTFG6hIw5bbaWd1eWLDDXR5RNpduCzKRnUAkxy2/UMfj5H2gsy9X6wKcyM6C/3KWC58HNPPXRJu3QBtbAeQbverdxcYCpPY/uO2MdV5eJ8PP4/fE0VMQagjo/fqGzxzG974M9rGgmB2fsnr5XCRnKHVGjwWUkhD9ACINyabB1+dwHZQB7Cq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1wZiBU+zaohoLFV2sKFa5BwOfWuMKSXat6rhBFeygE=;
 b=dRWevnjSgIpSBD+e7RRxh67ZT3f/C3lfqyqLLeODrUeB+K6Uc2OHce0+uo0vqnKg8O7LXxTIyCbuIWdXM6FcTQ3+LBNGajL0YEXelv16GjYNEAMJzARmU9BSOE6/6sTY71x8v46hRj2NWnT7eam5bIwPU1USi3tw8ix4Xfu0p4nEbxu+au+LRo2fueJDn1C7bHas+Ls8pT3gz7Xe9BaEJ1B3Uyn6h0ZH+1L20Ae9PJ43k+AMmqVRSFovWpLmYbcIxImbCANgd3fbk7StRoUhncjGJzh7zIQGjB7tWj+UIACx7NCFnPcr0joD+V8Sp1HgJ0nSIw/oaUiBQ1AefA0cOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8813.eurprd04.prod.outlook.com (2603:10a6:102:20c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:04:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 13:04:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Peng Fan <peng.fan@nxp.com>, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, festevam@gmail.com, ivitro@gmail.com
Subject: Re: [PATCH v1] mmc: Fix typos in comments and debug messages
Date: Tue,  3 Feb 2026 22:18:58 +0800
Message-ID: <177012816734.3125891.241992637218467768.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125123957.21295-1-tanmay.kathpalia@altera.com>
References: <20260125123957.21295-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 406d94a7-2025-4658-60df-08de6324c166
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|19092799006|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0wyNDRGamt5WDdHMlIwNCtsaG9XSXNUYzlRZkFJelNtNUpMU1BUbjZ3QlNI?=
 =?utf-8?B?Q0NzYStERTZuci82b2ZLcU9hTUVlUi8vRFZEYWtzYzhiOW9ZcVg3UlBnK1FE?=
 =?utf-8?B?UzUxL05VQUtWck5EU2dTeGJuNjBOanl3NU5adjBZZkZTMlkzakdrTGo1ZUVS?=
 =?utf-8?B?Qkd1c2xLNE5GODhGRXFKeVg2dUplcEc0SUx2YW5kdjJhOTVabGJrR1Q5MTln?=
 =?utf-8?B?TndQKzFuNzA3N0lHdkYzOHdaOW01NWpjSEgrZVdyanZicXhrYzJQNkprM3d1?=
 =?utf-8?B?M0l0QnhhaW1iREU1ajZiVWg1VHA3UnRRcWNPVmFwWUVXeDV2OXBlM01KanZE?=
 =?utf-8?B?eXY3ckZoTzJIbUNMMTlhUW9jTUp6RHMycEYyYkhJeHpMN3ljMURQMDUydHRz?=
 =?utf-8?B?cVlNVzZsUTF4WWhSaFJtYXo5UFp4NG0yVzJYRGVTM0dmTzF0ZGFnMjB2M3J1?=
 =?utf-8?B?aW0rMTd2dEpzRm03OXRZSGhUbUJYaURHVUFaQWEyYXV0N2NjK25MSEZ1TjZ4?=
 =?utf-8?B?WS8zSWh3V1Uvc3RwQXovVmhVYTB6N0daOGU0MWFnblJtSjFPbzVwMUtyeUNl?=
 =?utf-8?B?UHlEaGV0VnVrYjZoR3hqKzRLSTdJUXVsSC8vMUlZN1dKSFZra1gwN1JoZkhP?=
 =?utf-8?B?VFpZTzVsSVBadnJteGdoMk5MOVlYMWd2NjVmTzVlTERGRUdYa25KcnZOUGpJ?=
 =?utf-8?B?SkZOQ2JvbW50eDIwR09tQmlBVk53cDZRbDBsVjFQaVRrak1tdUpBaHE1N3FH?=
 =?utf-8?B?dFNENDd3NXk4cmh1Z29ZaXIyWmpTeG04b05vT043VlZjUlVINWJMQ0VPZTJ3?=
 =?utf-8?B?eVBTZFlremwyU0RLMGJ4QXRSd20yS25XUXloczdobUhyOEVoNXFoTUJKMlVG?=
 =?utf-8?B?VmdEalIxU0lnVGpQQTlMNEV1UXN2VnkzL3R6d3R6Tm1oSitRWmlLWWJZaDZX?=
 =?utf-8?B?WUtRcUttOHFDdU1uME8vd2NFRlBLVkN0OEs3M2RHZC83cXd2cnBXajdqUFNY?=
 =?utf-8?B?b1RUK0tTQU9qaldrUWswMVhvQ1VqbHN0RWxrZWlya0JYNlRndlAwdEc0Q0E3?=
 =?utf-8?B?TzR6ZGlxb1lqUythaTRGRy9iV3BCNEthc3dXYjNJRzdoOUxYbXJ6Z1BGVWhn?=
 =?utf-8?B?a2JKMm02TTFPVUdYWUViakJGZm5qOERCU001em9XSk5zRi83blBaOENwQUN3?=
 =?utf-8?B?aTlldXczbVlOeWpFTWozRWpoT1p5QXFHK2UyaERVUHlzNWFvQ01EbG5KMGhS?=
 =?utf-8?B?TXd2N2FTR1Y3TGpqbVN5bGZOZmxmZmJiM2JNUHA0STlMd2ZnOTJFMDFuck1Z?=
 =?utf-8?B?SlJwb3VoeWd2SXc1cW4vNUNzL2tpMWs2VnhNTVNlVGhKYjRhUW9iL2h5SFZU?=
 =?utf-8?B?eFd1QlVSckhUUjNpS2xDeGJFbnorYVVGYVY3N2hnckt4b21RWGx3aUdtU2pt?=
 =?utf-8?B?M2lBZ3Iyd1B5SEszcEtuTHR6SExjWkp4RG5ta2pUczQ0ZTF3RHdkY3RMSmZa?=
 =?utf-8?B?RldVQW1zOXhJYVVZUlFqYmlMUTdHL3hyU3Nrb24vMmcyMXdacC95dUNFTXVu?=
 =?utf-8?B?Rk9xbjd1VkpSSGVBU2ZPODhQZ0diVWs0L1JJdTBOTE5ET0Y2WlNtZWNOTFNH?=
 =?utf-8?B?ajRQOTczR3N5RjVPZWZ6c0laUWpLSlJZZ0pqSmM4cWdHM25LZHhZTHhzL0RV?=
 =?utf-8?B?b3FWMWhqRkYrUXVWUm03YnFHb2JBQXEwQy9TWW56QUxLZXU1SXdJZzd0a3JJ?=
 =?utf-8?B?eE9uaEExNEdvdk1BNTFmNCtRNnVUcUdnbGhObXRvLzBST0VHVERCcTIvRmtq?=
 =?utf-8?B?TGlxTTlLb0hMdE9NVDF2cjUwdjBxY2Y2c0VXZEtFUnp1SHhkdFo2MUVpTVVD?=
 =?utf-8?B?M0VlY1pUWGdPcTNzT3YvY1JGUWNFRll1L0V0Z045MS8xSUZIMmE2VGF6VlFF?=
 =?utf-8?B?VWl6WVlsY2crRlpMZ2VHaG1NSXFZMjdoZzJuWUVBMkZ3SVdxMHFmNEwxaEpK?=
 =?utf-8?B?VnJ1Y1BTM1l2SllkWGUzMUFyRTVXVkpaWDhjNk5GNHZuZ3lWdC9ySlI3UGdt?=
 =?utf-8?B?UTdqVitQbHROdU8wVTkzRDVmb0RNTTBoQzkvT2hvaUg4S0ZYOVNTZEFxR2d0?=
 =?utf-8?B?Q08wWmMrU3NPd2p1emxhcWs0eTIrc2ZYMlprUDA0NFZnNm1neWtRVDFRckpN?=
 =?utf-8?Q?6/YroJf6SfjGAET0wPUcnK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTV4amV2TVRFOFBHNTVKa1RWZ1V1YzlHWTdNaVY1OHAwZThxbG5hNkZqUmRK?=
 =?utf-8?B?NnNsQnhzdzFyVlQrbEU5ck1DWTlNQmx4dXNzdW8yeVQrcVRXYnZTS2tka0Fu?=
 =?utf-8?B?d3ljQS84SzZkT2Q3Yk0vcEpiV25wMEMwQlB4Z0NsQlU4VzFhcFJ5UjRNbG5T?=
 =?utf-8?B?Vk5uY0Y3UStubmZXaTRUTnJWVndHWW95aXZ0YkdvdDNPTmdSdWtxOHNzK1lW?=
 =?utf-8?B?VzJXK3VRemwyakt4T3JDT2RUODBaZFBlTDJyMlBJby9JdnZ4UlZUanduVVV1?=
 =?utf-8?B?Njhrb1V5d3NQRUNEeUkxWFF0Q00vNlZIaVcyTEtPU1o4VzNFV0tkRFJTQTBn?=
 =?utf-8?B?NmxGRWdST05kWGpYaFdvMjJZdVpiVmFqNXJsd29LNG94b1NjSFlFWFpNeEhr?=
 =?utf-8?B?aWtIUGVCYWlYc2Q3VnNzcVRIZ290UmtqZ3hJK0tWRmJYeURmQWNhS1Zkcktx?=
 =?utf-8?B?QlFVNUkvLzFVS2JneXVqeFZpNk45NXdJL0p2Ni9obUk5cGZzNjc3dnRYenVH?=
 =?utf-8?B?TkxHV1dGVjdQZjRvaXlXNUtoSWFJcS9PWFN1bDEweUR2N3dnVHJaU3V3MG5T?=
 =?utf-8?B?ZTV6bE56Zm52QU9xZmJPZjZjZEtYU2xrQklKMHZkMlVFM1Q4MzVGQWxpaWkw?=
 =?utf-8?B?VDA3dHR2NTdlQTgzMHM0WlJlcjc3NkJQWXFVcDk1elZtRzFFdFdoU2FxZjJ6?=
 =?utf-8?B?dkRLSkJwQ1czT0FIQUcvZE9ZK3V1anJhdU45cmlXS096VFd2MXRKT2lmWjhq?=
 =?utf-8?B?dUNNSGJoZGtndDlQb1ZEM0FJNFV2RDNsVmEwQ0VvZ1VDOFRmMjhvbm8zbFNl?=
 =?utf-8?B?ckhnU3BiMXpOUEpwSTA1VHdDT0NIcXpUSTcrRXNPVVN6RkNkN2todk1DQk1I?=
 =?utf-8?B?RGNpMU93anQrNUlLMnJxUHpNOEgwSlRrZEpaNUlVV0ZibDJ3VVk1VkxqYXJh?=
 =?utf-8?B?SHlZUTBEUUY2VGdwRCtDQ2VJQkI5Zk9zdGhBY21IRE5qcWxOWXE5SjZuS0lL?=
 =?utf-8?B?QlJUVllzY0xCemJpOXhNdy9jakVPLzJMQXVPVzJKMWs5aDRWNU9Xdk5tandl?=
 =?utf-8?B?MkhpZmdJdnpiUDQ2ZjBFRFFxQ2NCT3NsdXhhV2xmeUkyZ0hTNkowdFJDRDAr?=
 =?utf-8?B?WFk1T0FkQ2duSHZRWEk2MUJCVjFHQ0kzTnRzWDFaenZQVXJRV09tRzE1WlE4?=
 =?utf-8?B?K0RLK0d0Z2UxenBQMmhsRWJOMjJaZENtMWprU01LTjNQM294bFpVczVaZkZL?=
 =?utf-8?B?V0w5ZUU5TTBDK3pOcFB4NkZXYlo5UlpaQmlnZnllbEZweDgyMzY1Y2xXYnQ4?=
 =?utf-8?B?Z0lyMGgvS2ExTkxxdnBuYVkxR0dJZlVzTlFnMTdJU0ZHVFlzV2U3cGt2SFJ3?=
 =?utf-8?B?Vng3NU5VeHRFOWltU3VmajhKZnZLQUhYdG1yNlR4QU0vVUNiKzFyMGVkcTA5?=
 =?utf-8?B?QlhUbmtEVGlwaFNSL1NxYUo2TllSaUUyZVJjRHU3dmd4bDB4c2xjdk5PaUZZ?=
 =?utf-8?B?dUIwaXFCdGZjTHRsR2xmd3d6UUp2Q3MxVUV4RmNWQ21KZWdsdUZyNTI0c2hV?=
 =?utf-8?B?dVM3YjJQQ014cklQVEg2eDVhRUlBK1Nta3o0ekZTdUtZaERMb1ZwNXFvZVV0?=
 =?utf-8?B?L0RjckY4cnNlUXcxSXAzME1xMUpaQnFYOEJXY2I2K0x2a005TzhDU1ZKTDB2?=
 =?utf-8?B?V1M4enhtalJtTWZSVU9NUE1Mb1NCcUlHR2NVMGZSS09YekxoTVZpTnA3cGdk?=
 =?utf-8?B?L1FkM0lPZnpNNE1rUkM0SGJVZDJzWmxSNzMrZFJvTVRwanlMQzdyTElmaDRl?=
 =?utf-8?B?QjQwN0g2b3FyQy9wTFp6cEV4NGlnN05HM1dYS2QzSkFLUGZzcTdXYlZIaTk3?=
 =?utf-8?B?cGJWS2hlT0dsdW82ZFJ2R3BsTnVraTRBZThLd2lOdDhIa0ZkaWNacWl4R3FM?=
 =?utf-8?B?QzVZYmVTeGZoWUszcGRmUEJBL0tRSmhEQ0NuQTVKWE9udzlMdHFkUExNeTk1?=
 =?utf-8?B?YTBPMVdZb2Y5VVdpNmRRSmJKNnRLV3lHWkhkMkliZ0pxTTJlaE83NnBxVHF0?=
 =?utf-8?B?d2krT0tjSWV0WHJJdVE5S2xmU1BQM0M0QTNhQVcxVGU0azlkWUpDYUZQZCtV?=
 =?utf-8?B?bjZ0VXVIYUN5dTZsbllHRmVEbUZuN0czWEtWdXZ2NjkySW1pbW1hU1ZzbStp?=
 =?utf-8?B?YkhxVFBJOFpyQnBMQkUyU2kyYktyaGdBU0ErUjdLelp6bmthL0JHVDRYZ1Fv?=
 =?utf-8?B?NjNwZkFVQzA0Vit5TkZLOWNZUDB1NUs3M0hGL2tzVEU1RWcrVDVIVlhOMnlP?=
 =?utf-8?B?SG5WRURqa3VpQUROVFU1R0ZCZitxWk5wK3ZiWDZRWDhXTlREY0FJQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406d94a7-2025-4658-60df-08de6324c166
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:04:25.1434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a+CUGwzxKHHangJw6alHuNkvIk9z9+s44RdXsR5YQ0xi59nWqFDtLiQ81yWUpMC5jYyHaYMfzgJUnXfsbE0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8813
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

From: Peng Fan <peng.fan@nxp.com>


On Sun, 25 Jan 2026 04:39:57 -0800, Tanmay Kathpalia wrote:
> Fix the following typos in drivers/mmc/mmc.c:
> - "neiter" -> "neither" in __mmc_switch() comment
> - "witdh" -> "width" in bus_width() warning message
> - "enver" -> "never" in mmc_select_mode_and_width() comment
> 
> 

Applied to mmc for 2026.04-rc2, thanks!

[1/1] mmc: Fix typos in comments and debug messages
      commit: 7f9e9b50336777ce07ca7d7bc40bd82856d12468

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
