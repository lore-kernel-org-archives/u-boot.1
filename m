Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675A6C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 07:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED68F82D7C;
	Wed, 18 Jun 2025 09:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qj58Bvpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4090682D6F; Wed, 18 Jun 2025 09:30:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F0CD82BF6
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 09:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PwGzIFOKqcOZNJ2z7q/EPmwZX4GDOpyzdHFsPmtxSSyqUbtEWsLMSySQn5E8Z1/N3oGQ4OqqhRFGl1UYLe2kZ4maOj34MXFpSIPWi9F96CjlqN3u8VUFe6htJb26QIC/aaisTRu+TIxfENvkri4EHXZi+myFS07adC2CnTrlCVakPPuZ3I2Ra3be08LxqFhY0orUjLacsIuqfQMNWDfrHv3bL3cCWF+SBpmA31o/YfL/dHi3wgqwPPCurAVfvB8woB0ZL7bCeDhMW1a7e7SzyOrJjclq7GSq+GLMnZ7mA0VLaPegvJc7JbvAz35xPnisI/390MVHMZJMf4AfJZe8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr4spESgWND16O/6xkgBly5uR5FOwcGDnflZtu/UNrA=;
 b=LluKj0Dp9pAgqcKbloDvvKbc7AtlMIEfT5OUdykM6XD8nSM6BiN9DsByuF9U0p4vfrVvvnkk2I2ua7YXM/6F+uJmR4KvCciRI7qJjp1o1QsezNVC/iikxRxh3unn/6rcRdhj7TIbLlcBx9zovdgeDfqVa0oMPH9HAR4CufVo+KkPTJW5gA8jZ3Vo2/vR+oE+LB3GgxaC0qLQSe05bkthLT7ZQ4c8JdcF5ynxhlILuyyOa3vaE2wtFjCGFSzW+T3uk+wU3dI+oakNdCIvWXuABxMltqfu8MvJVEe3NbI/AsjQBjQmLJX7LXUujg3ce9YomC1NweR0PlXWVCFls1oT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr4spESgWND16O/6xkgBly5uR5FOwcGDnflZtu/UNrA=;
 b=qj58BvpthgTh9Fxboi6yN3DxRQIeERuRmJCQC/QaePiuuJxTSdBp5i/gEZYz8mh6nn3snm59Y5i36UKtp/UoJz9KAsXoOLeMQb4+CWbmOq6FCFATBqBJvmLmkgmuGWpYDyb4lfxBWfciQk2GHh45qOGMiXgAKdpS+TL+ashhExJqSwmzZYkwwPq10T4fcT5JPY9GiYAPPBIai/9g8wN1syi7+eh6yjaL+FxcxUj5IWjV1RlNYBCg7NfJd+x8Ot0SlSfADbWPPF5lNb6gYB0oSHq4wjY2MduTO+1ItMMKu5BjP538brW/KonPcQqk8uOjjEKW6QF9g3iYAhTwK4WciA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 18 Jun
 2025 07:30:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:30:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 18 Jun 2025 15:30:18 +0800
Subject: [PATCH v1 5/8] arm: imx: Update ELE get_info structure for i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-binman-v1-5-373e66c7a51f@oss.nxp.com>
References: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
In-Reply-To: <20250618-binman-v1-0-373e66c7a51f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Enric Balletbo i Serra <eballetb@redhat.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS1PR04MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee36976-84b1-4fdb-c0bf-08ddae3a0406
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWZUNkZwcGdhVmprZzk4MEFtYXB5VHdKNjV1bmRNdXoyKzhoMFY4ZnBaUGo3?=
 =?utf-8?B?OHAvek55Y01zOHdFZUJzZW15cytFMUtVeVFwVEdua21kVnl1R3A2dUxIM3RW?=
 =?utf-8?B?c0JBOWVNREoxY05jZHpJeWVaV1dmOHN4QlVSMEUrRm1qcEo5RXBmSFlhUldP?=
 =?utf-8?B?R2xlQnJjQk1jcHBweXA4ZzhqZmFSbkcvTnNIbDZ0VWRDekhYNFlvOWU5ajhM?=
 =?utf-8?B?dW4xUUx6YzBpSXFBSnNxUHp4RlBKWnZyQXc3NHZPa25lWVVrd1VyYzNNYVFy?=
 =?utf-8?B?d2IzSExkTDlOeVRnWUZ1VmhTenMwb2ZwNTF5bVBhUllIZWx2VTFqaWVyRE9y?=
 =?utf-8?B?c1A1RU9qc0k0YUJCVkhCbFU1K1NhMno1UUZPVC9DSkVOT0p1VTVqY29wWUVU?=
 =?utf-8?B?UWpEbGlTL0wzcXQrSlVlcHhBTUphRWVRMFg5ZW9sQWsrQVpQMVhqWXhXZlM2?=
 =?utf-8?B?M2dBYnpSbnVSVzF5SHNMVEM2WVBEVW5zTHZ0TVNFRnhYWkZGeElPakdxa3h2?=
 =?utf-8?B?aUhxQkhGNXlIUXhIbkdTNjlpQkQwdmd2SXJtM2M5cEJvV3BuSE9tNUYvRWZV?=
 =?utf-8?B?NUlOZmQ5NGhYbVhKRUdwcllGQnpveHZoS3oxNFlKMmE5WUsya0UyMXBBMVRr?=
 =?utf-8?B?MWk1WEZXbHpxZG5BZHArNDNiczI1ZXhMMVlqUTdxWHh5MEhXQlpWN0VGRGM4?=
 =?utf-8?B?Z0krREpJKzE0RzJZQmdFbVVteHRJTUJDSG0wc1RtdDlicFhSRDQzQTIrRExB?=
 =?utf-8?B?OEhsRUhtV3VsQWJHZ1I3ZklzRVA3b1dLQ0VPaW01SllTQ1hGeW4vVVJ5Vk1s?=
 =?utf-8?B?YUkyNE5vaEs3OU9FUUxBTjNObFdHNGJiSjdhNy9ZbjlReis2RnNzejloNnJu?=
 =?utf-8?B?TDRCVXd5VEE2QTBOTC9uKzlsNzVaeDNzMjhaM2p2YnAvR25oOTE4ODhCNTFD?=
 =?utf-8?B?clNDdjgzOERRSVlodVdQY2ljcUNqdGZWUU5yOFVzTkNzbHo5cUNiZHVDVnFs?=
 =?utf-8?B?a3d5N2llYytsTG4rMjNDM2VJVGN4SFJFMWNFU0lyT3JjTXRWQ0UvZkp5eVJE?=
 =?utf-8?B?RFllM1JERG55UVVkNHBnUVUzQkNrT2NQR2RKSU5EN0tCbW9pN0NNMWcrcytF?=
 =?utf-8?B?M1VyMzI5RUN1ZkQ1OW1CaGt5MmNjNENMZEJjeVlFRG5rcFByTlVWSzBnUlJI?=
 =?utf-8?B?SEpCa1hoUzF6TlBUT3UxT0Q5SndkNFNGVW9lYzdkQkZGaDcrSkNjMlFCN0hQ?=
 =?utf-8?B?ck41K3BjMVIydjdKcGNyaVpSc0FHOTFtTW1KN2hicXRUbjY1dnBMbzhOR3Yy?=
 =?utf-8?B?SDZsV2FXeTZMa2dHQk1vY1FSc29kMTFqOVd4QUFnckFKMG5GcHhhaFp5TUpY?=
 =?utf-8?B?MHhYekxZN3pmNU54UGVob2lCdlQwOTN0d2krb0NCWjBRR0p0UkJMcnJqTEsr?=
 =?utf-8?B?WkhITEIyb2R5dXQ2bnJtSGUzdk1sQ3dLbktjWUtkTWZFSWlUOUdXbURsakc1?=
 =?utf-8?B?STAwMStVL2RXV1VINExheTF4VGZzRExBTEtNUXYwanRqenlLT3NYUll2Zmhn?=
 =?utf-8?B?dzJQeFczTkk1M251REEyMWxDZkQ3R3NlV2dZUm42LzZkeUd0ZnUwWU9CTWJo?=
 =?utf-8?B?Unlvcnd5cytLVmdzczRuZUd2NjdIR1Q2dGlJSlQwMy9hcGdPSGdweWI0akFa?=
 =?utf-8?B?aVhYR2ZZSUE4aldEM09oWWlYRUh5dG1hWGN4bCtlSlFiQ2JUK3ZIbElpZ2hG?=
 =?utf-8?B?VkJ0MUtMT2YyL1ZuSTJISGJEdnBzRUZqLzd2RlJ0WUsveTlkT2plNjg5MjM2?=
 =?utf-8?B?NUN0K3BGRFdoL3M5VkRrckZZNlNjQmZ6VUlkZnAwMmNTSjVveDdBdWRPRUh6?=
 =?utf-8?B?d0RNbVpleGg5Nkc5OTNlNjJFMTNHRFdCUGJSM1MzMTU0bkR1STduZHd4bGVG?=
 =?utf-8?B?NjRNQXZzSlEzQWV3RUo5VGlieGpsRWpyWXFGQkE4OVdzN1Nma3VGM2lCbDRY?=
 =?utf-8?B?d25QVzRjU1p3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS8vQWxWcStuQmpNdFFUSHlFY3dWQmpDVmUya25ENFVDeng2RTQvbTdBZXEw?=
 =?utf-8?B?NVVETThOekxrRjVYU2RTNnZDQ3ZGWEdRU0wrL0Y4YXNpZzVoN0RUZ1k5bjgv?=
 =?utf-8?B?em9rbFNad0t2MVI0MVRJZitQZWpEVW1FK3ZBWlk3YnI5Q0xJZWFEUkdoTk5X?=
 =?utf-8?B?MEJ1algwVzlETWdIZERUOElPVE5RQUc5dHlVM1RZYTZtK1FRL2l0dE40dEc0?=
 =?utf-8?B?Wm1YanhXU3k4TUNtL1pGVnYyQjhlSmQ4MVA0ZVRzc2pwMEhKNEZXM0tXcXBk?=
 =?utf-8?B?dHNFT2JVSHZ3MUhxUU5ockxLM3g5WDg5elFUSytzQU5jL21tUDJ0M1ZpOE1Q?=
 =?utf-8?B?M3Z3ZXZ3QXAyRWNrZnhwRGVVNE43OWpJYTIwdEdTVlErNmIzWVpBMEE1OHVG?=
 =?utf-8?B?TnFKWFlLbURKRW5uTVR6N3NORXV3dzZmODdadlRIM2RnMFVpelNFd0paaGNY?=
 =?utf-8?B?Wmw5cUdHRGZFMEhubFBmWWFURWRUZlVzMHNWd1FMTVdQaTJKb04yOVVacXdw?=
 =?utf-8?B?aG1IL0dacU1PU0F1TlpJeHd6UmJIdHdlbWs4R1NLbUp0bWRZNnVQK2hpVnN5?=
 =?utf-8?B?Z25GUjRGQ0Eva0xPUG0zQzdRYnpmWjMzcCtSdC9LWGJUdVFIejNGNW5TWVhs?=
 =?utf-8?B?SExja0d1NmNsdUZIREg3UlowNkxOWm01Q3ZudHpDUGNnOVlZTURqYlBZMk03?=
 =?utf-8?B?a1I2UWJRS1ozV01QZkRvQzd1eEYrOFdvL0ZIVGJsTlF4QlV2amdZVkhMVmhm?=
 =?utf-8?B?YTc5RU92enZiNjRFSWQ3Y3J0NUoyaUZvaWRiajhXNlpsNnJJTFJLbnlGWThy?=
 =?utf-8?B?NHArb0dtZ2hNbmt2bDZ6ck5lbGV2NnlHelNrbFV2bVZnQXZvTXZxakVTSllt?=
 =?utf-8?B?dE81Y3huQ1M2d0tibXVzTHk2d3RIdzFRWFZoRW9wUUpqZUtldWtKSE5Nb0xJ?=
 =?utf-8?B?bDdqSnRmRG1HZEtPNFB1aHAwYTY2WWY3R2FQZjQ1eUhSL2dQdkk0WUdoWndx?=
 =?utf-8?B?QTlMZUZUNFYyb1BlWk5ORVMrWUtISS9WQ2w5RmtST1dRZWlxZkdrUnNBMFBu?=
 =?utf-8?B?aHNrUnBweEdWOVB4TnRQaXRObDdBZk9KVXhSemtKSFNrSnN4SkdNTWlIQlZa?=
 =?utf-8?B?ZG9VTXR0Yk5XMUZidDNrREgyU0pOTllrRDk3M2o1WE5qUTFYaDBzeHN2QU96?=
 =?utf-8?B?TnhKa0dQNlVGOEZ3Z3hyWEU4UVdyOFdPcVZBdWJUZ2o1UlBnM3d2MFdEcFJL?=
 =?utf-8?B?cGJvTXJJUUNLeHY0cG9KTCtybEVnZyt0c21QcExmY2Ztbm82b3hvREhDMmFv?=
 =?utf-8?B?Qmc5UjAzZGJIRHJxcnpLekhYR1c4SzFROTJMUzBmOHppSEFTejlNaFBjN1Mr?=
 =?utf-8?B?dUFMUG83bFVFa3NEakpOZzl3Wmt2djRWNUZyMVVqZ0U5OWtaaStPa0lNRFI1?=
 =?utf-8?B?WUZpM3dMWktTajAzSFJRdmxwN1ZGZ2R1VVR2a25oVEl6YmIvNW1CYmQxTVhM?=
 =?utf-8?B?U2cyMmFvWWNQaXdpbHUwVDFuZCtVK2JuU2lUdHJIaUNHUUR3ak5aMjFzL0Yr?=
 =?utf-8?B?YjJpQjVSTm9hVXcyQUNiL0JUaUFoWW1HVTlEbU1qY1UvV1hPbFJobFJNMnNv?=
 =?utf-8?B?Q3FKY284WHY5UVRXdkNESXZ6WVpKVnNoeUVuZzcrZWxleVBIM0Y3YXNqbkEv?=
 =?utf-8?B?bFpEUnhNNTdJamJ2YXFrMjVFOTFCaGpiWE40ZHNOaFBtWnkwK1Q1OHlXZ2pu?=
 =?utf-8?B?dnpTSTk2cXJpczRlSjJjbnlDSThBL1RjeTcrdjhVTEVwVmRMZGtyZzYrRVVa?=
 =?utf-8?B?UVZ4VkRvNjdxN25tR2ZhVFZpajRaT0dDQjhLOXBPMmhDQWtiNnpsaU5PQTJP?=
 =?utf-8?B?TlNtejRVREkzYURTV3o5TzdJM0w0T2lWcXlMZjZOMXQwVFZsbUYyREJLa0dl?=
 =?utf-8?B?aWNaTWVIS2xGOVlBS3BxblNRcUYyKzlCQmR0RW1jNmhqaXFqM0NYVmtHTnVX?=
 =?utf-8?B?YSs3bVQyamdTMmFTdWphb0U1aWp6OGUwZzg2eHlJMXBJL0oxRE5sbjlQdXRL?=
 =?utf-8?B?VnIzYktLVFhMZnQybDlzaUhxNWFPdHluQUhpaG9aWjVwL1RDTFlZdFNlT2lH?=
 =?utf-8?Q?hrTN5vZegVuE7fTVnN7zRHAzP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee36976-84b1-4fdb-c0bf-08ddae3a0406
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:30:35.6845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcmzFHCUcXvuvmgOGUNsXp50UTZqJzPeHPVv6qu9zh0L0XHzJA2zn+0xN+UK7EeNcwt5ro2xzj0FFaBOmbmFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

From: Ye Li <ye.li@nxp.com>

Since i.MX94, the ELE get_info structure is updated to add
OEM PQC SRK hash, so update it.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/ele_api.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index 19d12696a1e..64b243dcaaa 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -134,6 +134,8 @@ struct ele_get_info_data {
 	u32 sha_fw[8];
 	u32 oem_srkh[16];
 	u32 state;
+	u32 oem_pqc_srkh[16];
+	u32 reserved[8];
 };
 
 int ele_release_rdc(u8 core_id, u8 xrdc, u32 *response);

-- 
2.43.0

