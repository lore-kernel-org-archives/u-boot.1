Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91A0CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 11:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB986800B6;
	Tue, 23 Sep 2025 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VAnglPJg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45162834D4; Tue, 23 Sep 2025 13:12:18 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16FDA80050
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3BI2radOn9uL0TiCtwey0j/9VEEs/D5xaZ7NAIzMILSHt3cy8MBSr6CDcLU5eTgbtk4vCFk6QLV87AxYO5GfrCiLrlz6tWGn2+GQksg875OmX2GyPAz5hyh5F3he2bWSzbBa+e+5RkMkVmiXjLj99yFqdhO4Vm2B7WMO7SmBfrRNU1l3wbiyjr6a4E5BazIqtfCaUfo0W404p8xM9DKzKhin+LdFB2sKqT8PUeJ6VySR6ULy8C8L0yrpnfjmqhjViXAzQ1u/mD6dy+CjzrbMJPwzXJ3BNfguFeZo4qKq3AtlUaL6So6+gA5N14ZO9oHqAmnVi9bs8y8e1Tb0F7NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=iAmR0AbljFzAm9NmbX30XRH5X4I0RXUjebE6vs/JR6k+X5SrVXJ8IAEoGkkZbVhDRo27HALHDzJCv+tuC+5mL56MIsmGwtI6IOalffVYSFshdowVE3XV/TjzNYmD791PVrPcP+rMVQsok1qRUixNMUWUAFsQXxs6SXGRC9DOBjikpzkcNsXAR5IeBSdMc1HJ99wOv9KJ2tYqGKLI+0pPmlPOLC4MaoCKzpCuD1DmGpESRR7biioIogqhfRJLlP9/joewJW4S8WeQZsUCRByrwWPj4ak/THr7A7ccSlNxRU5D7WMAuIS6xAhXzMnHvwLQ9LC/4Rw3nZHWzbetfT9d3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=VAnglPJgRyfIjBH+wQO/z5e3R+rJzskuG5Z4O+cWiRituAUrBuL9r69hiKbvyWBHjcMTjZ1Cnk9olIJWR/UShgAN6yNQvk7jIc+pWShlSa18o3OTRRDGS+TkOzwloQpKU+sw+S6RHQ1xEeITt+7C1FO7HQ/b9tHZYPgSbyTzNKwmaI94jliZaJ4hKfbKdRd8/hjFeFHQgkDTk5vAIkCFcbkDsW0sYxZNqIwCC5dA8LWF/mv62NroUMwOonc2k28+9UQNC8lkkVsEVGwKtGuDWO8jAKYqHBdQxylFgu6/+jlQIEgFwSKb1roA51rqQaLnGHBc3cmDwCEBye0b/ug6bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:12:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:12:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 19:11:46 +0800
Subject: [PATCH 02/10] arm: arch-imx9: Add USB2.0 and USB3.0 base address
 definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-usbnetc-v1-2-507cddbe7214@oss.nxp.com>
References: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
In-Reply-To: <20250923-usbnetc-v1-0-507cddbe7214@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: ed39c59a-964d-476c-be8b-08ddfa920cb1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkdDcjRMT2xkZkY2a1NIM0tOUjczWWhhRTRySSt0dFlJYTNIQ1NYak5aS1JR?=
 =?utf-8?B?cXdNYWtYd2ZyU3hLOXNuSW9nZnprRmw0K0hSWXpUajdla3NncmJSVSs1TThS?=
 =?utf-8?B?MUpQb3FVazBWS2NQMWZDdzg1b0VDZEd5bnlOVVNRUm5xUGwvZzFHVTR2MlVF?=
 =?utf-8?B?aWc2aStFdW5nR0Zzd2J0aUxOR1J3cSs2aDBVMGZmVkxjUy9Rb2taK0c3em5y?=
 =?utf-8?B?Kzd5bXpraUZtQVFaN2FjZmUxcmk3elE4ZTlnR2x4NnF4YWF6ak04MEg3ZlJB?=
 =?utf-8?B?YVBZK2NrWUJvL1lWS0s0LzNhekZBSXRHWlRwTk8ydlVGazhTY1NaTDM2Rmxs?=
 =?utf-8?B?L3VvYmIyOEJUM3FrTUZZcEJVMHZJeXJJSEl6OVczSm1zMmE4enlnTlphOWRj?=
 =?utf-8?B?OU50c3RQd1J1U1YxQzZWQnRDTVdvL1pPTGJtL0NHK1d5eTRUU3R3ai9DNlpE?=
 =?utf-8?B?cFRXdTRhZmZ6VXBqY2pmQWtvdVhhZHJJaXRQNlFWYmdHMFhjTGE0dzdQNUJq?=
 =?utf-8?B?c3NWMEY3ZldvSkVoUi9RTmZuU2gzY0xSL2RvMmh5MXg5akd2QlFJWlZWRDhE?=
 =?utf-8?B?V3NrcnBpQ0tuWGdqVWVoc3cxcTBVL1BvT0JrODR0VXp4eHRXVklKMnV1OTJ4?=
 =?utf-8?B?ekVDMkErcEc5K29DM1djZWI0NzV3aSs5MDNqcFgzVXd2NFZPUVpPZG5mc2lT?=
 =?utf-8?B?K0hMcXBpMkJjK29JeDlhYlZNYTd5VzZpbGo1SGlFZkQxZWhRVlBCY2VETC8v?=
 =?utf-8?B?WU8veXFZT2UraURta3RNZ045WTQ1LzhGMnc0emM4VU9QWDZYdEJBQjBNeGpH?=
 =?utf-8?B?RmlLN29qdlJ0OTU2WFZXb3BBZVNhYWZmY2VBTC8rbjFJVHlWYUU2NmNQVDVv?=
 =?utf-8?B?Z1pSZzBMWitoTm5lQjNPWE05TDVnT2xSRXNZZXRGQ2FRdERTZVdCU1hlcWVm?=
 =?utf-8?B?K1BHVnhjY2hIYVZJaTNSRDR6bnZCai9CVDBKUUdHQzJobUhoYXlZMGs5d1lS?=
 =?utf-8?B?RXZsYWNhWmN3eDNIMEozYXo5SU1Tckl4SFNDY3JScTAyWXRGQi9KS2p2dFdL?=
 =?utf-8?B?SzN1MzZ6YkFJd2hXVVVsY3N2OHlkRUtScm9BZVpMV2VuWmQ1U0dYMmdwTi95?=
 =?utf-8?B?UUNxaHY4dWZvNnVTaHFqdEo4dTJWQnJSUXRJMHdGbkVnbmxXSENQb2tYcXpj?=
 =?utf-8?B?d3FaSTRFcThFMCtuM3VnRkZGU3BYcHFXblFreUFjUGxOdmlqNEZiSk9heTdC?=
 =?utf-8?B?VEpyOFFCZ0ZkRVVvSDFLN2pYam1qUzV1cCt1Mlk2K25XZGJFeXJ4eDh0bkJB?=
 =?utf-8?B?RkxSMGlRYkhlZERGa1Q2ZjE5THBzVlpwV2lpYWhpYzJpeEJWeTA1bldmU3F1?=
 =?utf-8?B?cC95SVFyYkNhS1lDcDJrbUNNbTZnM09sdnM3VmRlM3FMaEhheFd0UHByMzcv?=
 =?utf-8?B?NXpUaitzREZlcnpDK3NIamkwOTE1azhOZHNOWTB0Yk9pczFSR25oWm9WRVVB?=
 =?utf-8?B?UDFZZGlSOE41ZXZTWC9rTjdZc2M2SHRHN2FsT0t2MW1lMTk3VDBUWm54ek9x?=
 =?utf-8?B?dTZxTE15T1AxNGlDMmlXOGxjYkUyRUh3ckRRRmlkMjZBOGhUZ21iWHVQMTda?=
 =?utf-8?B?NVlhendidDRTMHVBeG9GZmpQWmE1NUFjL0kwZlRxSVZnT1F6Q2Rqb25TNjhF?=
 =?utf-8?B?ZnlTNjFPc3gyTXNWVW1sQVlwMmdxRDJOVDQrSm1jR3RZNkEvOGgzK3h1b3ps?=
 =?utf-8?B?dWpyUFprdlpCVjkzWTFjanBKMUlEeHpNYUhyOGcyU3BZK3c3SktHTko5VjBh?=
 =?utf-8?B?c21JSHpQY0hpNkpZM0JBSHVRZFBlM0VJeUdLSlE2Yy9rajZzWHZEbERZRURu?=
 =?utf-8?B?L3E2VzgyTVZwT2FMVXpya05pOTFTVS80VjUzdUxSYUhsbDdzbXljSUpRa1ND?=
 =?utf-8?B?dTFNUlhSSFF5Zkx0c1Jud2J3UTBaNGc0bTdOUEZITG0zS3ZhSnhqYm42cGxr?=
 =?utf-8?Q?zKXqMnxhiYCjRH9OgNj5H4vuHP7o5k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elJZUlAwSXE4MEJWSy83NFFyV0NBL2dTajBRZE1ucGFUSzJGMzAzUFdwamxN?=
 =?utf-8?B?Q1V1MlBGeWxxckdXVmRBZFlOMVhRZDdneXluY0greERFYUVBZlZnNzdJdTc2?=
 =?utf-8?B?R1hIMkQ5UXpGeEJKcHU4WEpxZHAxcUFsWWoxcXRSeUIzRmV6d3p5ekJoWXZ6?=
 =?utf-8?B?RnNndHJtTmlwS00vZGlPQXd3TnIyMUNWd3I3UUwxVmlBb3hIb3hia2YzR05E?=
 =?utf-8?B?K2QyK1l0a0xxK3RQc1BnTi9HTHpqN09qSEp5SS9FWU1DTm55VlBmNURTN3lm?=
 =?utf-8?B?SzFPZGNSQk9odWxycHhVek5oWWVtNEJQdVdlR0xJVzFQdXluay9hY1AvTy9L?=
 =?utf-8?B?b0FrWUFQeG5WRkF1OGE2YlhQbUFaSVBiL3haMCt5SVROdEpyZmFFZlZpQzJP?=
 =?utf-8?B?ME05VmhrTThqNFc2dktid2gzSDNxa3BZTExza2c4QjNkQkUrUnI3Q1JnNDNQ?=
 =?utf-8?B?ckJldWZhckZ1Uko4VmdKL25QeVJyTGZUN09KTE9rNmFDRENxQzlDNTFnUVRK?=
 =?utf-8?B?bVNsNkhaUCs3T1pmajBwU2F5enB2eTVjYUZQS09HTHdDMXdHRjZHaDRaWldC?=
 =?utf-8?B?SS9kZjlBbTh2TDNManA0c1V5MzFRUy9SSEtkVGRYRU9iYjVIa04wSEprS1N5?=
 =?utf-8?B?ajdjbDg2bGdDcThkSFhVNC92cGJqbGJaT0hGQkpYL1psMzIvVUdqNGNRN0M0?=
 =?utf-8?B?cmQ0VWpFYnlrdk1hbTNHNS9vaVJmMlV5RFZ6MW96RUJ5VXlwZ0J2eHB6TDZq?=
 =?utf-8?B?VkJjTzZFZUZLYTZkMFlMVElmK1VVWmJVRGQrREZRYWlmUWo3bEsxbkR6YWhv?=
 =?utf-8?B?dnhFR2cwTGdrbngzT1RUY21mVE9BcVlMSEU5ZmM2aDBZU3UxbTNuLzlVTFMz?=
 =?utf-8?B?TGFwSEEraGZOcVBZQ1k1QTlNVmJNeUhCNE4rQVN6NlhsY0JSbmpid3lEd2JR?=
 =?utf-8?B?cGhhTFN3aWZTOHJNM25abDV0cldYV0piTWZBb2FWN0d3RnVReUgwbURFbFMz?=
 =?utf-8?B?N0wxN0NsMldncGZ4NkozdlhmUkJlS3Jac3dBTWx3RWtEUHdVSXRUWW0yN1hx?=
 =?utf-8?B?NW5FY2NabWtYK21vWFFaUGplbFY0bzJza2tHQWpPbFZLSktXZGZvTTlpamNI?=
 =?utf-8?B?b3NUYmxUc2lpeWNJdUdCUHBJVVJEOCtJbDNLYVRCS21uUG5JdGdzSEZMeVR3?=
 =?utf-8?B?SGFzTUJua0NVN0FtMmFsRU1MZ3lRZVRUTzhkK3l2OFp6RXB1TGZkcDJKL0FD?=
 =?utf-8?B?VWV6NHZXSUlxYjJuRW5Td04yblRBaHhxN1VPcTByc3IwUk1vS042eGMwMWhJ?=
 =?utf-8?B?WEhsRmswbW1XWUpKZ1J6SDdGQ0tlM25mQ1VLZ2loNDUxWklxUGhSaDhSUjZL?=
 =?utf-8?B?MzByR1VWbysyN0N0QjRpODltY2g4QlBGRXRHbFA1dHNlK2lkZmFhazZ6TnVD?=
 =?utf-8?B?dkU2NlNYbEZ3MzJIQ3gyYkhtVnNIMVRIRWF5WTdPK2xBQ0RmeHU5ZnZWdUUv?=
 =?utf-8?B?SmN5K0RGNjJNQ0RJMTl2ZU5iQi9PdnNPUFhneldxM3RrWTluZ0RSaUdRVTFy?=
 =?utf-8?B?cUxrNDZ2SDhlcVdxVlhBc0dFaEJSRzdQU2I2OTdaUE9LVXBXQmhRS085QStw?=
 =?utf-8?B?OGJHcERIcmpUTEU2WDJIOWwraVMrYTh1UkFQUHRZQzZKTkgvNHQxbzZmL2RN?=
 =?utf-8?B?WHR1WVJQcDJMWGoySUNZZjlGcmc4Y0xldHpjcWdTQkJ0VVlGVHczaWNVbGow?=
 =?utf-8?B?RWNLcCtHNitSWW1rdVhtUnJIWTNOYURpNTU5R0JnNXZlMWtDUllBZmRRWXZD?=
 =?utf-8?B?RFg5N2sxMkpldGNHUXFxV1lKVVdVMEk3QUIvbEIrSDNDbkNTR01uTzMvVFZO?=
 =?utf-8?B?b3JWcVE3a0FsSzJ6QnY0aktlYnN3a3EvWWZYNDVJVUlJNTVMcCtYeUgxUXpv?=
 =?utf-8?B?eTFWMjVMRDBaNEtZNzRBMmZhTWJYbFFLTXl1dlp6ZXFrVmFOWVdjS1VWZTRs?=
 =?utf-8?B?cjRaNGRjUjArSXl0WjdQNTNKY2FWaU9TTDg2dHRodEp4YTh6UzljaUtuYnlD?=
 =?utf-8?B?WXFLUmozeHlUU2ZZd0orczJGMjM5UDM0RWdEc0kzTEpCZUdGTGlFamcwdkJl?=
 =?utf-8?Q?C50/kBOjnA7oBXAVNRKpkX69L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed39c59a-964d-476c-be8b-08ddfa920cb1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 11:12:14.3030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYmJFqVMkzmT+OYriuWhyTIVi7b1t/tvg0JGpBjyNYnuNUh1eE2oJbHgGtlJawRnngo1MuqTMX6Y9DfnRewdQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7919
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

From: Alice Guo <alice.guo@nxp.com>

Add USB1_BASE_ADDR and USB2_BASE_ADDR for i.MX9 platform, and define
USB_BASE_ADDR as an alias to USB2_BASE_ADDR.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index e641ed299c0..2d084e5227a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -39,6 +39,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#define USB1_BASE_ADDR         0x4c100000
+#define USB2_BASE_ADDR         0x4c200000
+
+#define USB_BASE_ADDR          USB2_BASE_ADDR
+
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
 #define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000

-- 
2.43.0

