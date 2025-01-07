Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F0BE77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA08C806ED;
	Tue,  7 Jan 2025 07:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AIWsKBYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C6C8060A; Tue,  7 Jan 2025 07:59:39 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B6780714
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cktIGLBWY+bLva1UTYOujPwT2vnpejTQqn8CzVmA309UsKjEOpISJU7qLWxn7onSa9mJa8sa2FGvBoCh+24U13Xf5FKm5ehTnBn3VLF1dhRgAQGs8XWH/5GhLfmuWI6Np7qLGdbA/b5QCE2MpScE9yFPQh8z1OWFWE8apSPK/KL1Q6n/W5N/SfeiuG/vVpIW9tNProF71sjmLPtO5cnQ/zdrE817Sn3hozAVq/yGTlr3CiO5cbC7Ny3S0z+Cd20ReJ1HSBIPxbYqqIbKGoo22XI/IQ4O5BQRKFoRk0MqUQA7PY61juStrOmM46BY/r6K3G48pgePWCQUV30LWDOnRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=calklESa7qs83tKUBP1NiB+VaoVIhLcfT7M/gy9pAhQ=;
 b=FBs7q3FUi/NAHe0iQr0fRQXIhlvwQR/bA2N7rWo4FT4Y0s5qZ2MzaBSNF3w9Bl9OZLcd1kgGLibPhAdNDtLdmH9yLkQKesHsWcNHfecBcTsnuT9y2pVQl/rPL4HskP/lsMwhxAal6hwXMncl92o8DudBV9PLLc4qJ+OSQ591FFJcM0sjU2112FdT3HZnpqeSO0woUximDtj7ksaaYFza8qirXm0iFVcCRrj+aZo8AM/wWt4AThYkqcz3n1k7Y7L8JNFFM/NXolCjpgrEjpqLfgEMI92n2w1ixldpNPUKEJ72mZO+R064WpHGTekpJ5/xDoHeUsWj7asbDX58Gk0giQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=calklESa7qs83tKUBP1NiB+VaoVIhLcfT7M/gy9pAhQ=;
 b=AIWsKBYx1/vlnUfHsRTtgwTXv4L1/wRM41PImZ5eSwp6t2ElK+089yhqNz5WuD8TVwM3v55gw7gLzW+GVgHpWpGZze0C6KtCF99ANXdqis4c655YhPeEn/G/OgUUFh8JKeGtrflztRbG3lhJUH+IkjJFeawLYyvk432MvebCEUr0fErZ9FrRDR5kqLNkDXiC+7UA885t9F8RCClXlQPeGMLX9C5NRK/kmNL2SWC3MRrRJAqq+D+0QVQ2ndEaCLl8xTJa06ySzKQXlT+PcjhVcZNXNAl7l+9i22NXpft3Ka+Ib3kBF9efx0Zvs2HJwuKfnMtQ8fkgT0Jvvs/E6uLiBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:12 +0800
Subject: [PATCH v2 12/16] imx: imx8mq_evk: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-12-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1acc9b76-128a-42ff-03b8-08dd2ee8d534
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDFBREVUNE5Db0JZb3FKdE5NYitURko4RmkrU0g3T2t4d3loZHU5emlsU2gx?=
 =?utf-8?B?YnplR0ppTlI0WGhsMDJaQ3ZUUGo0VHkxZkN6VStYa0lZZUpwcmdldFVPbGla?=
 =?utf-8?B?SGRIa0hFdnB3UXU3ZFpXcElaeVJFeEErNDkvb24vcGJpY3VtSEFXa0E2MDJ5?=
 =?utf-8?B?Z0JZUWN5Y3ZTcDlFT3BaenJ1c3kyWXk4U3hLU0grZ0x3R01LL29EaWZJdVhy?=
 =?utf-8?B?aFUvZXdrQ3JiZjlxb2UvZDVsNTdROXRVakE5allnYkxxS3RtU1E4MDhJU2JG?=
 =?utf-8?B?ZXU0T283empCV2lQR2tHSWdaOVQyc1AvVk1tSEVTeFZMNk5oRFFXNUlvQU80?=
 =?utf-8?B?MlJ1aGZhTzhLclFidExKckFNZHlOeUZCRDc3RU4wZ05NMzU2alExV3dHbFMr?=
 =?utf-8?B?OE5qQ2JrUW9kemM2eTRnT3dmTkYycE9US3doU3R2bHRYMzdNbXowbnh2RTNt?=
 =?utf-8?B?TXI0MWtXRG13N3RscCtQaExWdUpPV29mZVRaMlFTcXpwcSttWGh5KzdNOGJx?=
 =?utf-8?B?Z3NkSVl3Tis0ODI5V2hIeTlPdTJjdkp5L0JWaU9IakwvQm4ybFRoNzVPZjlt?=
 =?utf-8?B?SzNXT0M1STYwR3lyRTR2c003dFRNQjB3MVQ2TVVCdDc0MjZFRVZISDh6dDB6?=
 =?utf-8?B?UWVZc2ZibFFSMXh4RDBUcWtEeDBETmM3aUIwS0tOM2laYWJ2QW5Qa0pGNW82?=
 =?utf-8?B?QWI5YktqTWY2Q2c4Z2t5N0VFTVpEY0FhRWNjSzkyZnkrVFVjNnNJNUJUdDRm?=
 =?utf-8?B?M2p2OUFsai9DN3lkVm9saWZGOXZidXZGc2pKUGgvamV0RW1iQ3ZBUlRLbm1m?=
 =?utf-8?B?bk91bkNlOHdKb1crczUvKzFWT1pWM1NOMXlyYVdocDJua0JJMEFDbW9JaHF4?=
 =?utf-8?B?aUs4VmtzR29iYmFkdHVhM01kZW0rM1FoOENPckpwODBnRXgzd1d5SndSemxk?=
 =?utf-8?B?ZE4zdVRNVysvSDVwcnpPY3dDLzRZS05tcEM4WGJqVVJNaTBReTF1YnI0QmZO?=
 =?utf-8?B?VmE4aVI2NUZJczJRYWpSQlBiMVZEWE5HY0FudHU2WTNYcGFNWWtqNmJIRzRN?=
 =?utf-8?B?MmhXNndrSjlaRWFWK2NzN29hbGpSVklEV3Z2R0lIV0EvNnpKZnV1dTFIdEFq?=
 =?utf-8?B?L0JycEMzVkRVZnpzZEVxcU5KK04xbExvMGowdmVDeGQ0emhVWEJ0cVVEYXJE?=
 =?utf-8?B?NVlXTk0xeU1NMWw3VVdNUFErazVRbTRrNWdxMzJNclQ5SkowbkxETXZvalhr?=
 =?utf-8?B?Rlp2YUhOMytRcFg2d3lqQWFRdXducHlIVkpXN1dHUHhvSlZJOVRLQ25EQmlt?=
 =?utf-8?B?eGI5d2lmVkdTMm1NQ0RRZFRsby9uc3R2UUNLY3AwRWlZTVhEaGVCMHFQY0hY?=
 =?utf-8?B?cWVpUUlWclhRai9lcUNadXRlN0JYN1Z0Y0pqQlluNW82QlRSdC8wTVMvN0FQ?=
 =?utf-8?B?S3J6ODFSM09WSWJ3YUt2L2ZqKzNQWHNRSnIxVEJyTTQ3eU5GcUp1ZURkcEdC?=
 =?utf-8?B?MHkyVU1LY0ZzakEreUxseTZGK2FRaXJXOGxyUGk3d3VkVUQwRHQ4aUNhcGVE?=
 =?utf-8?B?QmdnQ1Q3WXlQcXdQWW5hczF6MW0yR0xVQWlUWmtUS3BuQkxJbDFOeld3RGFY?=
 =?utf-8?B?cC9sRWJySXVhQTNibjQzLzFsUmlBZmFuT2Y1RG1EVzhvcXRUQTJvRHlpOEZR?=
 =?utf-8?B?YldZRERacjBKM21xcVYxb21nR09RcnBCcVdHS21oMjRMcXRTL1UzblZxall0?=
 =?utf-8?B?RDIydEJISGxNSHkzbjJlVDR6bVVGaGZRaGNmclY2ZEN6TjlSTW5BOFNGcjQx?=
 =?utf-8?B?ckNFcm1CbzdMNmNmV001TUY0SHF4QVJrSExSeFdSOHFoYmNLM3dUNUVWcUwr?=
 =?utf-8?B?T2xOczBQdlRNUC9KbnY0TlFXU3RSMm93eVMvZEd5d2d2V3NIZ0ZOMHB4VEJn?=
 =?utf-8?Q?G1h1kRJBcb0pztyl+ezxzNcu0fu5QtP7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdHWmNTTUFLemFkeGxqQms3OVdZa1dSbVVsdDd3VXd2U2F4R05jWmRMWTl5?=
 =?utf-8?B?c0VOd1dzOGw5aURjOFl0VnFXZzk4b2ZQTExGbVd4b2cyNnhkQThHb1NoN0Vu?=
 =?utf-8?B?UktoSXN0bmJ1OFVsTWloR1ZzM2dzUzY2K3RxSlJVMWQrR3lzTDVRaHBPdC9Y?=
 =?utf-8?B?cWV3UlZVZHVIMDdkRGRkdHlHcE1iS0o0R3pCTTE0bEhYSkI2bWRvL0VlckZs?=
 =?utf-8?B?QnlUQWZUNVFDRDhIdUEzZGpDTmNnQ2gyeHpHcEZycHNyZTBOQlltQ2VGNExG?=
 =?utf-8?B?QXNyakxITHZDcndqcTJSY0dEWHJ4SEFWazdvdEZuRGNLSk8wZ3JTS2N4MGFB?=
 =?utf-8?B?Vm5VSk5HMUxLYkxxR2E0YVpZOFhHUm9NeVRIQ2VVUGtQVWVJUCs0U0lab1NG?=
 =?utf-8?B?eXdLMFFCSDdWN25SRVhmdkExc2NzdTFOZ3Q5WngxWHRRVDZnV3MrekUzZlZK?=
 =?utf-8?B?MG9hMVE3ekVaQWl4QUdJd1ZFRGRLazlwYS82Vk5yUXhLalpYVExHZkh4QUM5?=
 =?utf-8?B?KzVsMzAwR0gySVUzSDlZM3BmUFVKYWtWV0EwWlg3QW8xR0ovNW5LSVBEK1Jt?=
 =?utf-8?B?NWpZK21jL3JxNUFWaHpPM1BUWCtHQXhRZ0t2YjUxeXRYRDJGK2dMRXovSE5j?=
 =?utf-8?B?VHM2d1I4TDJIQ25TMlRGR2RuMWVDd0trK2I0NUVxUDBYdkMvcTNGeEhTSzRx?=
 =?utf-8?B?eDdGd3pEMnlCclpJYVM4dTI2K3VZQWIzZG4wc1VkakpoSTNKVnNKUzJOd29L?=
 =?utf-8?B?ZEdEb25Hc25NY3hKR2lPRlZtMEtjOGNwTlFUeXBmNXF3TzJGeUdMbGJ2TStY?=
 =?utf-8?B?VjFqQ2s3WFBkWlNZc2pkdzlwM0IwcStNc1UxSlhGMFlDZlRyZTRSVUVBTzZ2?=
 =?utf-8?B?c2xvVHF5SDFQVSs2L1ZYMlBFNEN1eUhZOXZXV3I2WFZKb2lZK0NRTGxkTEFP?=
 =?utf-8?B?bS95MWJnaUM2SU5yY0k3M2w2bjRRR09PZ1NwREV2dGlYN3EyS1RCVnF1OEZP?=
 =?utf-8?B?QlZlSnZyUGEwOTBjWS9ENCthN0RBRk5zUTFUVmlWY1l4YzBnQTNnbG1HZzQ4?=
 =?utf-8?B?MEpvTkw0cXJiMG5hcE5DeG9aUkEwSjN5MWNoY280QnRPR05ySEJBMU1tOXNi?=
 =?utf-8?B?ZXVIVFBTNDA3c2tXNVpZVjNOQk5SSEo0WWVEQk5hOWFETzV1SXBXS3djbVZF?=
 =?utf-8?B?RnlsWDNzeitFQzdJZFRFSWozTlIxaWpVN1dpKzE1VWRRdFM4TklleTlsQU40?=
 =?utf-8?B?KzNHV1lka1B3anB6akFER1RCVm03Z1MwSjJ5bjRySVI3WVlXUzVWY0p1cVRX?=
 =?utf-8?B?NnpZdmdSQWgwQ3ZVc21rVStxOVlJL2dIZm9valQrT2RPMG90L3d1NjRTRDV2?=
 =?utf-8?B?Q2FpaFhva0JPQ3dIZ28yUGVuZ3dsalozWjg5SEdlRDRnZmVLSGFVYmJDRmRs?=
 =?utf-8?B?bm1TQ3NLWE5DdVdyYk9uQklBVkd3UnBwb2tVN013Z0t1aDJsMWxNUkNrK2JP?=
 =?utf-8?B?Wm8wMW10K2Rza09uZU1nUmM0MlVpczdNa3BLOEFTYWVOZ3YvVElFclNhNEhO?=
 =?utf-8?B?cnBNSGY1Zk1DTDFUUDl1V29ySVZORlRtbFpoai9ETit0VzExSzVVTFZvc2ZI?=
 =?utf-8?B?NW52NWhjS0huUXpEdk9SSTExN25jS1R5UjNqRkhDczVJSmFqdDJXOXJsQ1Vp?=
 =?utf-8?B?V3JhUzlxb1A1Y29aYXNkZ0FWZnRDby9vSVlvbURxc3FzV3lLTDAzdlh0MWtT?=
 =?utf-8?B?Q3BoeEZhaWpLeGxOQng4SjVGdWhadEtBNFNTeU1BUUpnUGQ1UDJpOEhUV3oz?=
 =?utf-8?B?Rm1sQUFvN2ZYc2tHWElHY2pDVzhGMW9QOWZLc1hSQi8yMnRpOXowUEZ1Zk9v?=
 =?utf-8?B?Ukl0UHRMVHFXUTRQaDZQamRqdWRwbGgwajlSM0JSbi80d0RhUUh3Nk5RczNT?=
 =?utf-8?B?QUNPaG1uaHlNV1UrR21aemZId1ZKOWpCcFhMbUU3bXcva2ttQU1peWJUY0hH?=
 =?utf-8?B?djhlcFN6cmlGWnhrV1ZYRk0xMnFOOE5yeFRja28vNndjYW9jd2dXNU5FMjlE?=
 =?utf-8?B?UmMxcDg5RGxlcDYzc09Tbm5zSDNCcGpKZ0NhNmZLanIwdVJvYTczUnpTWTQx?=
 =?utf-8?Q?ItJ8VKvsjs7vMLp3LEtht6U1k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acc9b76-128a-42ff-03b8-08dd2ee8d534
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:30.1721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMrbvs7nXmlx0xs1N8kC0BF3ZTalKOFFDvzqL8T6U3HEGQmc2Xgt860Y1ISj6UQN0BRa4iU9Y/dsdr8ysJ642w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

Drop unused headers and sort the order.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index ab920a4539cdf9a77607e1eba5640fa8a6233436..64a2f258f7a6f9bbc58466a47efa0098ec2a2333 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -3,28 +3,12 @@
  * Copyright 2018 NXP
  */
 
-#include <env.h>
-#include <init.h>
-#include <malloc.h>
-#include <errno.h>
-#include <asm/global_data.h>
-#include <asm/io.h>
-#include <miiphy.h>
-#include <netdev.h>
-#include <asm/mach-imx/iomux-v3.h>
-#include <asm-generic/gpio.h>
-#include <fsl_esdhc_imx.h>
-#include <mmc.h>
+#include <asm/arch/clock.h>
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/arch/clock.h>
-#include <spl.h>
-#include <linux/bitops.h>
-#include <power/pmic.h>
-#include <power/pfuze100_pmic.h>
-#include "../common/pfuze.h"
+#include <asm/global_data.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <env.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.35.3

