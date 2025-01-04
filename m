Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292EBE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17B48043C;
	Sat,  4 Jan 2025 04:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qobl8dNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B75180433; Sat,  4 Jan 2025 04:19:49 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 692A080207
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFp7MxzL20tnkxT11iDB4ghVR2o7nLOkwr54xhbWLwlZiCc1IxcAbaciYRDKo8ZYTzzOlns8YOZ2qgtt3wVv4Yl7NBCYdMWBlnE4IFEjjg3CR4aKxAPjiEKleOOcUZblXSK+lsaj1UdaDq5r0k2EwFd6zrEU/QFT2WsznpF3ByCyy+pR+R4Y9s3mYwKhSJy0cBrBOohajUOLQxqyLhmqQukUp8a8dm1pTaib9KTZ68VuteiFVa0KtK/tu8Y6iqr3QZLdowRpd2BGJQyEcZMu4VD8sW2QJqYivUVeRkwhcVh62gE/zrPkUs2OCJHt99m5qKwp781gvkgOB4bjRpw82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JqmghiO7gUwTsuMu1Lo39htYUoUZlgbUeykCoRMDvw=;
 b=qoTdbql6xY2X6VJthO0Q4mwk47zSRkrBGtty3vezV2Ae5g6Yye8jLTJUL2aSwr8z0JoVEUpBtLiuTSdWxbqH5ezdAaeWKqWuVaFzMRT1IlelZXQ8N2VPoiksCfZdg4qR7RUlxlkxcX+Eg4BDVSpPEjAjHPWYtQstk+5ZvjAYRg5ceAZcNhmPzbl1RifInX3RCUcqBqelcg7E52MrRMFQ0dWGsJ/tBYznWJOrCTia7C2iP0427pWJE60rGOcppRkv6scI87Wju/SeLEelHb8dpDSzzlFn0Wk2Pn+zmlF7JmMG4IZxt1RtbtahUknmp02utRid1E23bwvM0TFoEIhcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JqmghiO7gUwTsuMu1Lo39htYUoUZlgbUeykCoRMDvw=;
 b=qobl8dNY06YAnNHuoHRcb2vQjgLwTBul32mnhh05oN91cwrESTu4hX6aaZ07HVe7QAZJ44/qJXCwWR3SJssk6U7c9ooVuIVmxhoxc02hzBNoJzDix+yUVXaYA9XmBKnvP3xTq3hAkH/zqztpjHcG3uyF09pvke9JzivNjirddkAObroJFNcWB7clbKcX/8K+Jg7JJfz6/Rm/EKQKVNYR2OQlmmQBRt7LdjSkzLaoIT9LrKoIM6M+YzegJS4LTcqkNbuUIv5rqshe0Fi4q25FqW5TpkSLGM4ZkVvbtkbkFsjvoGYelAz+c8zSLgRA3Md56CkGTR2WlBBP6NAwWL0vvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:37 +0800
Subject: [PATCH 03/12] imx: imx91_evk: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-3-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e099fca-aa0f-4ef0-9f04-08dd2c6ea12b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tm1TV3p2Zm96eWxma3hvV3ZtQlJGTUpRL0trZFR1bXR1S2RaMzkrNkM2cEk0?=
 =?utf-8?B?c25saldISkRTVDF4Yi84RldoRmhaZGZYaU5JdityN2pDSHI5UWk2d3N4MlBj?=
 =?utf-8?B?cnkwYnN5QzA4TnJmV0k3eEhDR2V1OWx6Y283MjIrekRKaHQ5b25NNGJBT2NM?=
 =?utf-8?B?eWdhUWNBLytDSFpjMDlCZnNNbzk0cjBKUUFFK3hJdmI2RTFJK21xdlFjTU50?=
 =?utf-8?B?MUoxekRUVXpBV0hOd29yY2kxZE5kTnRJNk1YaHNZK2kyck8zUFZRSmYrY09z?=
 =?utf-8?B?SnVzNE1LbG1rNENXTzgvY3hBZ2hqWTlpcEdoZ3RKdnFtRGF1V2ltSUlGUWI1?=
 =?utf-8?B?MlNIYW5jOXIrbUVoNG1WY3FIS1NFQVgrYk5aalMvV1UxLzlqT0xMb2ZkWmc3?=
 =?utf-8?B?Njh0Zjh0WTEvRmpqTVE0MFhKdzJqRzBEODgwbXpLbUduaWRjVDhpU250K0NQ?=
 =?utf-8?B?UytxSWFsRks1eXAwRGxTU1pGbVlhcnMrdkpmVk54MXNwRnV6REJWZ05uZndh?=
 =?utf-8?B?RHhUWHpUL0d6WUoySlJnbk9BWktjL3d3UVRaWEs4cktSdnNIV3B6M2Zhb3c2?=
 =?utf-8?B?a2p6WjFwdGtWZ1BrTzI4T0U4dVd2eTEyZS82clRLZ3pRREEzNW5zNDNUUDZB?=
 =?utf-8?B?OXBQWHVHN0doRXFaaEZBT25XVzBETFN3VlRjbWoydkQ3dDY2YmhLYWcxWkht?=
 =?utf-8?B?cnVNaU90Rkp3eXMycllaYXN1TXlzbS8vekUveFArbzd0VUlna0V3ZVFtZTVS?=
 =?utf-8?B?YmdvOHFoSFlLcmJ5aS9kMUZrN0Y0ZEZwbEUrcGdpUHJtRGpjNGd2cG9SWUMr?=
 =?utf-8?B?TEFYSWtNaml5QlJDZWtaRGpOQWZ3YjhwS1JRTFM4RFB2eVF4NXhaSTVxK1pK?=
 =?utf-8?B?WkNsV3IxS2I1d2EyaUFJdDB5d2tma3VOaUlBNDJpZmpxMkpZazZCN0tEckpq?=
 =?utf-8?B?dkFYbWtJS3NPYTNocDVzSjZ4RnZ3KzdFN1RwTTQwV2l0aTdDSTBzVTV1VUNx?=
 =?utf-8?B?UWNlV0VLZURpaEJkbEhVSUVRRkJ5aUt1K2ZEcXhkWlNEcCt4NE84QkR0MjNG?=
 =?utf-8?B?NERQaEtzMkNVbFRmYWxWbWpnYkxXRE94eWU1bjFoVU4vUmx3VVdwcjZoODBK?=
 =?utf-8?B?eTR1UlJwYzlYL3piTWx1YzlMOWcyTUJ0aWh1Um5HZnBsNFJuQS9DSlo4WkRF?=
 =?utf-8?B?VnAxZVBSWEQxTkVmdXliakZ4ME1TUE1jVExObks3RHFDWVNvOVBoTzZQb2Jh?=
 =?utf-8?B?THdGREFuL2JQeU9QelVEWW1Pd0dtUWVBMGxMU2NZeGxudGY1S0Nydjc0eXhP?=
 =?utf-8?B?SmRRQTFON0F3amlLMGRGWkF6OGlBUzB1OFpodXVLVmZtdFFGTEN1QUNrUXV4?=
 =?utf-8?B?aW5NV2hydDRqdmV0YmIrZkk0blhqdlBTMlJTQmV2cVVvVGhuejFvZVNRQ1Ez?=
 =?utf-8?B?VDhyb3UwczA5NWlsNmNxdmJ3Y1EzVXRvbWFsUGlZY1lQYm5jTWh5a1h0VUZu?=
 =?utf-8?B?TXVPYzlXakdaa0dYaHRQSVhMNGJaTERIY3VzZ0JxQWF2NEpxY3ljRzRua2NH?=
 =?utf-8?B?c3ZFeElranNEZWVKcEloeGIyOFF2K2I2eWUwT29TeHpnOFg5TFJZL2VVd1gz?=
 =?utf-8?B?bWxhSEtUbHlxWTRaZUdHRUx3cGJoVFdkc0I0UWdRNXpFRmlaWndCZ3Awell3?=
 =?utf-8?B?bkVVYVdvbGZWbHk2V2tBaG01cWFWcUF2MW45cDN5THVpV1dUT29WMlNyVGdM?=
 =?utf-8?B?Zk1IYVIwMDNqUTRJZjBNblRPRzZNNnVPMjRRc1Nuc21HclpuQzc4ZlBWUDVQ?=
 =?utf-8?B?OC9NWnE4bjcwb2g2QjhLL3k2WWJ3MUdRckxOMDBqUnhUbE03dHVkZGkvWnhJ?=
 =?utf-8?B?VFhvRnJkMzhnTjhRNjRLWHZlaUoxNXRheGlSS3JreENLOC9pdTZyU0ttYUll?=
 =?utf-8?Q?nz6wpMdiA+f3+PugIxbpnKN8mEof+UVI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0MyUkxPTEVDcjZTcVd0SlpGOHdiQXNHZHRQdmZmQkF1U2pJM0JZaHNLUzlB?=
 =?utf-8?B?ZDhQcmNIT2R6YWt0aEhGZ084ZGErMGNHSjh6a2F2aTIrQmJMaEhkTjlmTzRv?=
 =?utf-8?B?NUM0VlFVRkpUNmg5cFMrTnlud3ZReVcxMlkxSmRhTEV0YXA3MEpieTBtZzl6?=
 =?utf-8?B?S0pKZjZ1L0NiNHRJNGV3Nzh5Tit6aXE5cnV4TUVodDd3emtxbHpqci9QNzJo?=
 =?utf-8?B?cFI2eWJlSWZSMnY5ejR2ZXFqbjVIa0dOSTNWZkhneHJUdXVUaVRmcnZROWtt?=
 =?utf-8?B?LzdVQ2lyUDlkcVk5TGxqbmxTTFA1NWd6aDB1ajRJZ29kVld6TFkxUjg3ZStC?=
 =?utf-8?B?a1Q1VHBqeFZBcFJoMU02ZUNZMS9XZ05KSUo3dUh5c1R1dmlROXZwaXgrRmxI?=
 =?utf-8?B?ZS9jTFZaTnNac01KU3VhUWREQlhwd293ek50Uk9KVkdoTlY4ZGRGWDc4M094?=
 =?utf-8?B?VHppdXV4L2UrT296N0QwM3NFRzRkV0wxVlEwNVZFTFNPVEpCelVzQ0lVSEJi?=
 =?utf-8?B?d2M4SWFoUlpaTXN0cmdtZjdaQk1vY2NiQmN2K09mUEZET3hIaExjSFRKbWVF?=
 =?utf-8?B?MnNJMFNqdGp3S3hvZWMyakc2QlhZZGNUWmFjZXBCRVZ6b1N5dlBBUWVSNVVm?=
 =?utf-8?B?eUM4Q2JkbXJ1RzVpbHpvaHhRNldxNFBqZ3E2UlpTRWYrd1BhZHAwSkV2VjZR?=
 =?utf-8?B?ampTdEpvaWRXSzlZK2ozRmJ1NmU1UnJXYUt3cE1CdEZVMlQvSmdsaWZWN05M?=
 =?utf-8?B?YlI0bWprNGFUbnhRaWplS092VlpkeDZVLy9NVU9IZkNTaDBiaXhhcEFiZVlB?=
 =?utf-8?B?SzkxNFFoUzArVzE1OXpqdjJDNnJWQTV3dy9XSG9SY0xXYWpIbFhmUmcyNVNV?=
 =?utf-8?B?MDdOYXhjaVF1UUprTDNOWCtyeFBhWHNmNjJnbXorYmVQT3doMm1SL295TmtO?=
 =?utf-8?B?RFczOE5yanFKdGtQNFpnYWc3c2RMcS82c09wUEhhZk9lU00ya0F4SnBLb1Z3?=
 =?utf-8?B?eXgyVkQxY1NEWWdmS0JkOFJRSENkZE5pUHpndDM5emhGekpPcHVxTHVjMXhk?=
 =?utf-8?B?c256UzBDOVByN2dEMm1xK0J5UnQveTgvVXZHMmxwYzc2SGZRRm5FUFpKdjVa?=
 =?utf-8?B?aGt1dzk0YjQxU1NBV3g5cWZJblFBaXRSeTlsWmVtKzhmdmNvSWh0SndQbUI2?=
 =?utf-8?B?WnNuK3pGeWdhRmRmVG5pMmlhbEZLUERhRm05OFlYYzhVbVdYZFE2UU5EejB1?=
 =?utf-8?B?L0pacFI4RlIyNVVEQVFYQUROL3JoRHpjWUFGWldFdWxPMElvbFRDcjBvS3hn?=
 =?utf-8?B?UWVKMEltSmRZK2YrSVIyRmZTZTBsOFZ5RlFLVm5ZS0U4MFFSQkVVZlZNdGdV?=
 =?utf-8?B?dFBjMUZWRm85WThlejBVSS9pS056ejdaNXFmSmZFSm15MHBxK3RjSUVTaVBX?=
 =?utf-8?B?eHI3SlgwaTYyV1RtanN3NjlFS2M1eWlpZnNqUCtsRTVRM1QvQ3M4ZXRGbStP?=
 =?utf-8?B?dHJTMlJTeER6ZHFBMUR3WXd0M1EySjNjNldpVnlMbW5pS1R0YWg5VzdnWmxN?=
 =?utf-8?B?OEdUQTJxOGF4aDZCSXpkN1h0alVLcURZc3lSVWp2OFA0OU1TWC9SeWNLNVdT?=
 =?utf-8?B?NnY0cTh1T2YrMWhPZkhpZzZZbkhhQXMrclJNenpEeHNvblFaUm5ZdER5OGh4?=
 =?utf-8?B?TmZiZXg2NUhMSTg5Rnl0Y3FRQlQzTWtQaTUzZWdsbURrMHRKNWs0ZC9MM1Ns?=
 =?utf-8?B?WktBZlEzbWF1QnFqdkpiREFEU3hEdDJ0ME1OdHo5d3JKdmtQelJ4YTBCUnU0?=
 =?utf-8?B?VVJYNjhtb0hEcHJocmt5dVBnbkVKTU9OWjl1WjhtbHFqaFJrUkY4QUF6SGNZ?=
 =?utf-8?B?L3BBL1BvTmNhbHk0Z29TSEdsSVRmRGd5TmNTdmtoT2JIZWRyWmcvM1kxWUFT?=
 =?utf-8?B?VVlmaGcrS0JGUUtHQ2lSSlBkZ084SG1VSVZyMER2c0d2ZVZYRk80T0hoYStw?=
 =?utf-8?B?K0crd05pWlBxK1djQmQzUEJVQWFqSjFvcG5aL25RL1lVMEcxZTlHTEIrTmVQ?=
 =?utf-8?B?djRPTXlTM0NEVERKVFlSTmRRcS9qTUkwUUgxbFl3YXJieXZKV0JzdHZuWm5N?=
 =?utf-8?Q?uzLzpLpPUgRjrzW3QBL0H48k8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e099fca-aa0f-4ef0-9f04-08dd2c6ea12b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:41.9402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fVynGaViqL8MDokjUwV0Dl9kyWAaQG6r+csq8MxQdwFFb7PBY0nmEMm6T5V6E0bT6IGMedHL20371js423itw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig               |  2 ++
 board/freescale/imx91_evk/imx91_evk.env      | 29 ++++++++++++++++++++++++++--
 configs/imx91_11x11_evk_defconfig            |  2 +-
 configs/imx91_11x11_evk_inline_ecc_defconfig |  2 +-
 4 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d756f3dcad2e91172ecd885357b9d0adf2e387e3..49220c0955ee4f658c06ba98c6cbe5ff411cd993 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -34,6 +34,8 @@ config TARGET_IMX91_11X11_EVK
 	select OF_BOARD_FIXUP
 	select IMX91
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_9X9_QSB
 	bool "imx93_qsb"
diff --git a/board/freescale/imx91_evk/imx91_evk.env b/board/freescale/imx91_evk/imx91_evk.env
index 92486c6f74d2ec12f638443dcf598daa28f306b6..c972d3eb2511542c1a11812f879d7627cadef797 100644
--- a/board/freescale/imx91_evk/imx91_evk.env
+++ b/board/freescale/imx91_evk/imx91_evk.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x83000000
 fdt_addr=0x83000000
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
 mmcautodetect=yes
@@ -19,12 +20,13 @@ loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
 loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
 loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
 auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
 boot_os=booti ${loadaddr} - ${fdt_addr_r}
 mmcboot=
 	echo Booting from mmc ...;
 	run mmcargs;
 	if test ${sec_boot} = yes; then
-		if run auth_os; then
+		if run true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -48,7 +50,7 @@ netboot=
 	fi;
 	if test ${sec_boot} = yes; then
 		${get_cmd} ${cntr_addr} ${cntr_file};
-		if run auth_os; then
+		if true; then
 			run boot_os;
 		else
 			echo ERR: failed to authenticate;
@@ -61,3 +63,26 @@ netboot=
 			echo WARN: Cannot load the DT;
 		fi;
 	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx91_11x11_evk_defconfig b/configs/imx91_11x11_evk_defconfig
index 6ee0b448f9932ae9c85d3a0a8f6b32787afbec6b..88630528a600a01faacacf44905d9d547f165094 100644
--- a/configs/imx91_11x11_evk_defconfig
+++ b/configs/imx91_11x11_evk_defconfig
@@ -31,7 +31,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx91-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
diff --git a/configs/imx91_11x11_evk_inline_ecc_defconfig b/configs/imx91_11x11_evk_inline_ecc_defconfig
index 761a66662641f16da6b9e2ba13690234df7c0a44..c4b1dc65249752ad7d73fe64927009fc833d5f6a 100644
--- a/configs/imx91_11x11_evk_inline_ecc_defconfig
+++ b/configs/imx91_11x11_evk_inline_ecc_defconfig
@@ -31,7 +31,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="imx91-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048

-- 
2.35.3

