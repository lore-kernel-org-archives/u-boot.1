Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5B1CDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:15:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51C3C89069;
	Thu, 19 Sep 2024 02:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FPTBFlVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE61789066; Thu, 19 Sep 2024 02:14:51 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C17F89058
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hm11LnkhcDSkIgkHP7G5MGMaGoTNtRVT6qnOZorj5bYOn/Jsta9LiMd+moYcoH+FmIbgYtggu0NLUe956sT8uZ5ebRVsJc9qmynLHjEPgibzmPqqN0couFo6+WNqt+RKZAS0opW1RQIyKTfe3pTkMOC7UFgiXwI5NDfm+Jew41BHaL5VeTF8//zsp4YFZqLibgW31lJYnxiYsYDza+rfJKaeAFtPbpM0c83VeuDfbIP9gEfwP9ILabD6GK4uBZmZpBUta50M/hMvz/4z3tqhwOlYhD8bdvuNNVDATdKtA47Efa9b4qqJUGc6Tf1X2QKeaEm5Kp0MieElWOmR3wctpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhDEhzS61Vkv9bDnfT6AoH9BA5bZuhIKaRCRi4GWIvQ=;
 b=lriB/GNIsJAMoD50NA1Pm4JrILqbp86rkEArkq0JxZ2MCkRm0e2Y8tqNVzh9XP3aBO5V1QVJF5VaIWr71f13VgOoK0RbowTzi44lKjUqGaY44Q17TaZwHYbTK9+SqnxgrwipEVP0yQQICNF26idIqfeHvA1rMH5JUXD5xkquWg4T3eBoyhEPUCINcPSufEM6H/DJ6OLi9K/iGwzGb3uumX36b7mAMSBlSISf5qG1g9ndcnqyS2ZTuYM3dTgCe7HjvlSAcNLXwvSJGxG68VcNbvDG7OAVz1wyfj9S0ZPkHbhsEBx/CxSliTUoK4v9ACqgL1K5Ix8lULAy6U+K7oqa9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhDEhzS61Vkv9bDnfT6AoH9BA5bZuhIKaRCRi4GWIvQ=;
 b=FPTBFlVz7NeHcdC7fWpuUgMtM8Z6KObTikwcY3T/CB5+HpTY2YYF1/j9DY+KlG+3TsGCOcNqwPo2Docx1GfbFwfKYHpuSe9ggtlMMJwlQBlprEt9U48ZndInqq+cSQOZcPNxjDk+pL0IOtq04VsUnh9HMYHleZaNAH8Jt3Xfvz9yJfZ8OY0CaxQGbRWEs9bKYbatiteQNYLyrY13bwsWKOz0oE3g/vIjbUqo+/zrpOSynbieU8d3cuxPCtPfoeqsZqVc6yvcnuzQYPPlhqeVaC9NZvLSGfzhzR77Gidi/tM23O0ojRBmTyPXdEAhFXv/LToDyOC1ZSChqihSH/diNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:02 +0800
Subject: [PATCH v2 03/21] imx9: soc: imx9: soc: Align UID endianness with ROM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-3-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6a0bd0-f123-4320-e0ab-08dcd84012a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmF1Z3V1VHZOV09WaGVyd2g0RWs5cUkwc3hYaUdRaVRaOTZzOUQvZWo1ODli?=
 =?utf-8?B?NE5vTWVFcUxFY2IwTk11aGZLTDdWQjZzQ3UzYmN6V0pQNW9EZGVsbFRaNldS?=
 =?utf-8?B?enluYkpNRmhXM25GZDByN0pYUkg2Q0dGWWx0QUVndmVIWTBDVHdhOUp3OEtv?=
 =?utf-8?B?RzlNeTU2c2d5cGhUOFZsdDlNWjRvWGpUZmdDMlZvSHhJalcyL3JwcjhWZWZ2?=
 =?utf-8?B?SkZ3SVhxSjZReCtKQ0RxSy9YaXU1TEQxYVVONnlhQkluZVZObi81MDkwYUQw?=
 =?utf-8?B?T0JzTHpuQjhMbmNHM3R0ckF0UEZqMzd3YUQvVXRjRldTMEZkQnFRSHE2Tm1S?=
 =?utf-8?B?YlpZbEdJRU55ak9ZKy9ZMzFKLzJMbzAzWHBoR0FwamQyOUdKRGZXV1hocDFN?=
 =?utf-8?B?cnNtMkd2L1V6ZEw0UlZCYXRON2tNV0NZamJkbk92c1pYcXZQT29wSlY2a3JX?=
 =?utf-8?B?aXNTcStMTXd6cDZDOW1waTJuQ2Q2K2FmQk1mMzBtTVUvSDJ3SXNtYk84UW4z?=
 =?utf-8?B?YXcrT0VFY08wejZRY1B3ZWhEN0RBVFNRZnE2UmlNSmtiZmN5SWN1czNidDdQ?=
 =?utf-8?B?bjl3MElOdVkzamxVUnNmcE9jQ3RKTHlycjhxZHh4cVMvd1g2UVRIN2V5R2Nj?=
 =?utf-8?B?anRwNkpTQ200UDZqVTZGOTJvNG4vUHJQc0hBREQrUzFtK1R4R1hHY3N5U3RG?=
 =?utf-8?B?Qi9mWE9ocGJYUVFmWm4rSkozMnhPbUdPWWk1MWtzVWV3SHRlUDhNdEd4d0JC?=
 =?utf-8?B?WUQ0RGpsVmk5NWxmNWd3TEFVZlk0NzF2UnRDZ0EzSmltNVBYblRIZGp6eE43?=
 =?utf-8?B?aWJ1VHFDSmFJbG9sNElmUkdDUmlxUFYrS2QyUXNTUjFtVHE1OXo0QVlSc1U1?=
 =?utf-8?B?TDdQSFBIRnVWRFFxcFROSDNEVy8wZ1V2NW1UeEdKeG4zYkZZbEpEK1JEM09l?=
 =?utf-8?B?RHYrRjFmTFRhazE4SlN0Ykk1bTJ6WS9vWVBSRytzdlBwRWx1bmJwOTlDakwz?=
 =?utf-8?B?ZnFjdDlkRjcwZFFEQ2dGVU41UWZoVFN4N2xvZHZMVFh5UWJ1TFdBSHJmSEp1?=
 =?utf-8?B?bTcyNzFQMFRJMXl1VmZwMVdSekdqT3lzQk9DdkhLWTh0enlmSGtoeE1vdGdK?=
 =?utf-8?B?cm9nMWlUTVdtbGFYdWsvSlNMSHJoaUVzQ2Z0bU9Tc24xdi9vQmpDVUVVTWty?=
 =?utf-8?B?cXBOV05qSFpQVXU4NWRmb2pkZVVMQmEzeHo2aXc0NXJFV1R2NHdBc3hDVmpl?=
 =?utf-8?B?WGNBdnhPd3ZVQVBtQWx0c2UrdDVCZ2Iyb29qR2J0bjh5aWlGTkpWODRWZU95?=
 =?utf-8?B?UVBLQ0pWWFIrQTkxTENqRjQzNUZTZVBlM3JKS2dkcER0cTZPWWRya3NGSktT?=
 =?utf-8?B?elhybnRhbWtZempmRzV6N3ZxM2doRHZRdkhBeU1oZVlPaVVGMUFDKzF0MGRw?=
 =?utf-8?B?bUJ3cFZWYzhuZk12cVpxSm0rM2VFVkxZNklTVTFoVHdDc1orTkh5T1FaQTNo?=
 =?utf-8?B?RTQ5OWh0K1k5K1pqYk91S3RCSkFJNGJVYUhHKzgvVmQzazVXa2I4NEtGUTlw?=
 =?utf-8?B?aE9WMVZicGxjcUY4cEkrd3N4VDVBcGVydEprV3RYUmgyaS9DN0xVZktPaTAx?=
 =?utf-8?B?QUVWWHdYWWpYRUEvZHBweUowZzBKQlNocW0rLytrV0hjakpyTFlwTDJRS3pm?=
 =?utf-8?B?UTlGR0xaYnVZaE5aV3ZOaHFudXB1eG1SWkRuTTczWVk2UFRWSkxSaktYQlZM?=
 =?utf-8?B?cmFsWXdCKzZBbzE4UUNSOFQ1RDFTcG81enNuaFQ5cWhqZGZQRWNJaWhoTHV5?=
 =?utf-8?B?T2dXOHlqaEJXbThNM2dTWnprUTFjVjVYSUVVeWJlSjl0eDk0L0NzRVJNdWFi?=
 =?utf-8?B?SjJUa290YzZoOWZKRlk5UGh2K21IWUc5cmpKTmxxemZkU2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW8yQzIrT2RDbUdqd3czaVViZ0N6MDdhM3VIaU5Pb2pZMGtlNS9EUmt6RVhV?=
 =?utf-8?B?bUwyaTA2WUx6Y2d4SG8yM3N4SlZXTjRmVk9YRUVTOWRDd09mMlQ3NElBUkFh?=
 =?utf-8?B?VHB4VldCS01lWTRjb3FLUkl2R0pRV1JCVWdreUFnR2lvWHZVVDFtald5L0Jh?=
 =?utf-8?B?a1JHUzBkSmc3TXY3dTRIR05CazN0cnJwa293WVlValNtMmEySVUxSnR5VjNn?=
 =?utf-8?B?bDVjdTdPcWt4dFBGT0lwVlNZNXU1cHAyRitCdVhPNGFuZW5lbUxGaGF6bS82?=
 =?utf-8?B?dUEyK0dhdXhjbFVXQ1FUTUdQWnByZk8rU0dzaTJTbFUyRFZDQWM1dStZVkhR?=
 =?utf-8?B?dDIvNFBNdXJHY2IyNEN0OG1YWFBhbTRpbWZ0SkxSbXB3ZDNNY3NvQjZmYXQr?=
 =?utf-8?B?ckhRcWg3b1V3N0hSckVDUTByRkZjSUZjVDBEMDFQS2MxNTJtSCsySTVyblcy?=
 =?utf-8?B?UVpQaHpneHV2ZUgwTWNHS0FYam9mY2dQYXlGUHl0eEIwKzU4a3FHMlVtSEdJ?=
 =?utf-8?B?eVJUMTZPc1UrbHNLL25iL2RjbDZqajYybzZiL1dQSFVyQThvUDM3QlUyWjVj?=
 =?utf-8?B?d1U4V2I2WUxpODlwUGNBVWJUVi9SOS9mTTdZRXR2bUR0T21RQk1ZeWphcnNy?=
 =?utf-8?B?QXRWc1oxeFA2aUNVSXZxNGtkWXphaHZtbE83SGNqamJnWnVSUm9yZEpLcUZT?=
 =?utf-8?B?M1hOWUJ4dWE1UlpDK3c1NVRFTzJjTURIek1RQ2I1Zm8zRUNSSHR5ZzY3ZXNL?=
 =?utf-8?B?TXNmalhxK0hMZXozajU2MzJYMEtKMWhLQkd6b214Z3N6cHZHRlhVeHpwNzZW?=
 =?utf-8?B?eDhMYmtTNUN6MlVnTXNRN0NtRE5aUzJUOTRoUjFyTFB4T2Q0bDlNOW9DcnJE?=
 =?utf-8?B?YStGeUYzZU9BTEJTZjF0bE5CY1VSbnMwT2VwSEJ5ZmhvOElBK2V0Mk4zUHd3?=
 =?utf-8?B?bmV1aDhDQWFuaTl4UDQ4QjFGOTNJY1hiZ2xSUG45QXRTeWNxdmhYR1owcUhS?=
 =?utf-8?B?WmNBZW5vYzdOQmRwNUUvcURUVVh6eW5JOThxN0dBWGFKckZ4TDI0L2hYK2Z6?=
 =?utf-8?B?OFdnbm9OMDhrWXN6MFhkb1BPbURac2tvR0Q3bVMycGN3eU12bkhwcVJrSlZN?=
 =?utf-8?B?S08yOUpDVW51djJvRU82d0JYMmlheGlpUk50MTdTZEt4UmZqME1OMnI4d0pK?=
 =?utf-8?B?ZUsvaUFjSm1heUV4dDVabFFhcU5Ua0swVTNBV0RpWW56WEF6ZjVkM1FnY1hu?=
 =?utf-8?B?OHEzbEMyK25PZ3lnbEl3MmdCY2ZaNnpxQ2F4aFYrSnh4RGhLVFEwR21STmRD?=
 =?utf-8?B?MkppM1AwaFliOU5OclBjQkpOQWM0c2NTOHB4Y1hWL0VVWlk3UG9yMEpnTWVy?=
 =?utf-8?B?M1JSUklTUFN2bElUKzYyckNERytobUkxcGUydXFkN2Nyd0h5TXNNbHEzbFMx?=
 =?utf-8?B?L3d0eXlTYzJnVWduRmZTczRHeEsrTE8wNzBBM1lKd1BJelRBR3kwQ1NhT0Vt?=
 =?utf-8?B?ZUJWby9VbDlpYjNJQjg4OWpMdWYzOEJLRnpnZWlXa2czRFBRZjFNNXQyUElU?=
 =?utf-8?B?Q3BwREtuNDJtNzlHeEV4ck0weWxrOC9qRUJGYUszYnlBcFNER2pyc0RiU3FF?=
 =?utf-8?B?VHBuSUJLb1ZDSDFwSWRadFJaZmtMRUtweVhWOWlVMUpuMEpMdnNHc1BGTzNz?=
 =?utf-8?B?ZVI0cER2Tnh5M2JJRWMzK3JZSjJhdlUwc2s5NC9ST1FlTnlQbm5VY1hQc1Zr?=
 =?utf-8?B?clV2bEFvaUZrYmgvQm5RMGJ3L1dqdGhLSWs3VjRzSEEwK1hJdkI3a0pNejk3?=
 =?utf-8?B?Z1lrVnJ3ZHdwV2V6aEdrK3gyeFViQW56eHdvbEQyb3JxWmduS2JZekVVTjFz?=
 =?utf-8?B?NFA3cEpZOG1mSjk2YVA5dXRhUHl5ZGFqeTJxMERoUGxLMVhRckhvd0grSEow?=
 =?utf-8?B?WXI3eFRpdElJbDJ3N205YWplUzBSdnNvMzdPS0UxeXh6NWYxbXBvQ1VVdU1k?=
 =?utf-8?B?dXo4Z3c2WUpXMFVLUUMxaTU0Mkc0QzI2cmhOc05jNVFPZ0xISHk5MlJRWUdv?=
 =?utf-8?B?RUhDUkhwNm5UWTNWZmhZMHlzVXlXQnpPSjQrZy81M2hMWHRFWWZyaTYxNk5w?=
 =?utf-8?Q?YsFTjZV0rQZmtbPmteGFGpO9+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6a0bd0-f123-4320-e0ab-08dcd84012a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:48.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgJ6MV2IqQHcrJrTxA2DBHi1K2QE9B0gNiAKIp87QlPTR4NEqAIxAzl1h05l7bVtsrgDHhXMZHRCeALRh5NSeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

From: Frank Li <Frank.Li@nxp.com>

ROM use UID[0] and UID[1] as serial number with big endian when usb serial
download.

After update this, uuu(>1.6) can use below command to filter out devices
when multi boards connected.

uuu -ms <serial#> ...

[sudo] uuu -lsusb can list known devices with serial# informaiton.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 25b9116f2a6..f458fc0564e 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -563,8 +563,8 @@ void get_board_serial(struct tag_serialnr *serialnr)
 	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
 	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
 
-	serialnr->low = gd->arch.uid[0];
-	serialnr->high = gd->arch.uid[3];
+	serialnr->low = __be32_to_cpu(gd->arch.uid[1]);
+	serialnr->high = __be32_to_cpu(gd->arch.uid[0]);
 }
 #endif
 

-- 
2.35.3

