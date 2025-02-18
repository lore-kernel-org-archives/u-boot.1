Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E714C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E662F80F7A;
	Tue, 18 Feb 2025 13:11:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QwCFU+hG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2B5E80F7D; Tue, 18 Feb 2025 13:11:28 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71BB807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVKvxJj3pjNcAWMcVro9m/LhVU9AVY7gpnKRPI5P0QPnEuYeQt1nbqGJkZ0loHaJ9ha5m4HtbOEJA9eCadJRwT42anGsVS1NEaaKCO5IyCOf6kPABuk/7RVzSpILdILw5+21u0HP2UC2qi+w/Pcempe5NjyChjVSaf9oHa1q9QeIV3/EL9uSlVSv8mehjydU//cbwOcC8vlEiDVrla0UcMF7VKbkWL+Dp7bHqDZlwEpPEYWZ+Wd4ii4TKt+qCinOlWZN2+P7875/gpeOHynnZBw7qf7h5TByPWFZMWCEZqc8U2sRjylcsMRF8oXg0GRey9zmV9tldIJ8JOh5q5pUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eqK1lKOmKnIKQU3ThoVLII5l0msyqS2zk20qUHNJlc=;
 b=hIs/pCwFwMmYOqyUnSEKVrgjZh45jYLqEs83kRywPckRTKId8GoQwvch+TZC2+02WBIk0fRAQ4zextdFc+Mkh+UmOWyZrm+mMH/zXL24ojfEl3lv9Bx2wtBNJz4FwVYhrrpgs/1ohtVkkLfNPrT5LgA1RBX6Ik+mbmzcVm+U4jbByPfAhPdsDnNPK5H0eE//DTpv0c6d/RSVU1T4GEWBV25pMVA6Uz2wLb+BC2TlODlwwEIl3p3gEPUIku+1cuRKlC/PPstij8zbIAR8/7Ikd+6wkpo+wQDsCnlAbiCktRGxmKz6ROzJUPiXCcexqeCWNaXFKiMjefdRACZumRC1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eqK1lKOmKnIKQU3ThoVLII5l0msyqS2zk20qUHNJlc=;
 b=QwCFU+hGFcQtwY/EysU6X32pIfigL1UpEKgUwvV7iwLxmha6WfpUTk03nrwAxFDowCuPkz6JMZ3siv6ZsyBlsLrMNv0dONIQSDHrjiAq7+RfYVl1OaH1rzHplprZ8+1ZGAT/DBYgLwpMjPxbs3jikEyA1yOg0ZF+8DiFPhFxVhIdGOFzbfyigxmAaLbxeT546/pQHZmdJC8e2M7oDvuDyyoLD+4bNcXe9mFZqiLAuLl0pzO7z9oj++aS4ZZF+Lj/K9BMrpApMfBG+QIIShkCUxPQIMRSD1jFGx24JpB6Prgp4hfxi6N1X/bM9RTMw97nEnfScHHtzIr6tcuJojOFxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:11:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:11:25 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 18/20] doc: imx: add document for i.MX95 Image Container
 Format
Date: Tue, 18 Feb 2025 20:05:55 +0800
Message-ID: <20250218120559.451678-19-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 827ebefb-0594-48b0-fe79-08dd50155d88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUg0eUZ4MjFFU2JRL2lHZUVuVXFiMVJVUUpUZUc4cmROanVBNXNDNDU4Ujg4?=
 =?utf-8?B?bElMeFZEQjFNd1dpY0NZTVNSUFJFYVZRQnJLNnFpZ2NxWXBpVEVsVm4weU51?=
 =?utf-8?B?VzNuSVpOaHJIcXoyQzgwMm9mV0Rja1BJcHJwN2t0M2N6Zi8zTkNhN1oxd1lJ?=
 =?utf-8?B?Uk51SjUrWDhZeXh2Umt0T0l1anpLdnFXZDhqQktzSFVwTkllbWw0YVNrc0ky?=
 =?utf-8?B?Ylc5SzByazJBR01SNndsWG1XYU0rcnNaU3R0RkxKakQxZFVLSDhmR0ZXRkda?=
 =?utf-8?B?UGxYUlZ3SDFReE5lck5ieXpxcEhWWFhaOTJkNHB3dXAyNEtVckk5WTJyNEs5?=
 =?utf-8?B?Z3NkSy9oTW9HajQveVZNTmxmSjJ4bW15RllObHZ5TmZLTjVMbWNHeWZTNEx5?=
 =?utf-8?B?OG1GMm1xNTlqTXNRRmhITWVkNUZtU1RRY3VLbURwUHB3MktaSkRkU1RHbzRM?=
 =?utf-8?B?UEU4SGx0MGlDU0k1YWFyNStqTzhPdm9zWFB6MUtTWi9ZOTN5dDFJL3p4ZUFU?=
 =?utf-8?B?QU0rdG41YnlEM1JmWS9QMDByYUQ5ZzRnNE1kd0J6SHc4TWZ6MEFhU1hDSGla?=
 =?utf-8?B?bGtna0FIKzE1OVZ5ekNIaXIxNXlKN0F3ZUpaZS9nczhiaHIyUExMTjRsS3dP?=
 =?utf-8?B?YnRYNStBcXp4dXRlQUZWcWIyUUlqdG1NdXFWb29XZW42UWlhbXlMeW1VUldG?=
 =?utf-8?B?NDEzeUoxK2dCdmd2Zm8vanFzb0ovRUxhdkdTOERzTmhpeGZhK2t4SXJyekd2?=
 =?utf-8?B?czNpNlJhTmxmSlllS2N1NzhvT2F5ZTNsZEJJQ0I5RmRnL0NGTllRWVEvTUd3?=
 =?utf-8?B?aGJYVFh1QVZmem5GUG1XaUwzd3VMU29lZllnQTNZb1N6R0NnSjVSU3J6TStW?=
 =?utf-8?B?Q1lEY1Q3UWUvNFVwZmJJZ3ZQdkJNNlo4QU9KcjBKTW55YyszUml2a001bkhG?=
 =?utf-8?B?YUZ1V1RsVEVJR3pyTUR1WUNacnpxYUtZVGtXUW5tU09UTjd5anJobVN5NUta?=
 =?utf-8?B?MXVnWlFnVHZCRHltKzdKUnE3aGtqNEN0NEJJUWJlQnZYcjgrcTZ1UlBCQlIx?=
 =?utf-8?B?bUJydHI4dTBwMzBqcGlyci9oZ2ZmenYrTEo0dTRJWGhDc0NNTnUvaXYvOFBP?=
 =?utf-8?B?elNwbkxVVGdPNWlkN05scWU4YW9ka1EwK3JRVTJmeDZwWVBDaE8zTE1OTzlL?=
 =?utf-8?B?M2RNcWRZWjFqQVk1U2Zla1NVbm15WEdmWG8yeVhtYWxYRGZEUk5XOHhGNGpV?=
 =?utf-8?B?NVBDdTlMWk05UktRRG5yRFdCL0JBS0VHUDRxc3hURlFiNDV5Q1EycmxmNExI?=
 =?utf-8?B?ellHRGVPZmFqZXo0aWVlQTNBRjhQVjg0dTRhWWkwTll2VEpxYkgzKzFad2Vl?=
 =?utf-8?B?TDJqTm1TV1ROVFJ4Z1dzNkdydUNWRGovZE1adXIyV2pheERvT2swV2xiZUsv?=
 =?utf-8?B?SUc5ODRZcGVDUDlKMUVONjhiRHhKU1lXVEg3clpVc2NnRGJjL3lILzhNc1g5?=
 =?utf-8?B?REhpSllnZlBFeXJ3VGlHanQvZ1V2ZjZmNFh0RHVPczFheFZPcE5BMFJZc1Br?=
 =?utf-8?B?b3FQeHlOdzNEK2NIYWlobWRubjZHZXZDNlZyR2p0OWo3aWJZZ21HZkQ1K0hx?=
 =?utf-8?B?OFVYTVlKNEhTUWtremxSWHBndUtiWGluNGpEaTlOVE9JcS9Ud2JLaVpDR1RH?=
 =?utf-8?B?S2pvdlY2SXhiNTNGMzhLVW4zUTVuVDhvNlNFL3pWRGh5cEh6QnEzZTU5OXJ0?=
 =?utf-8?B?ZUJRMXdBMzRJYW42STlaMlhWQzVSR1I4cHlkQitXZVFNeFRHTHgzbERROVcz?=
 =?utf-8?B?TUdwd3FtOHVRWlRLc0liVW9ndEtDUEVGck45RExCckxRWVFOZWg4d1R2MHhp?=
 =?utf-8?B?YUNyRFZYalo1cFFoOWpZLzB0T3YrM09nZEQ4OU40V09kR1E5RElHYmNia1pV?=
 =?utf-8?Q?RFFVXqmGKn4cIBMq6BpBYnHVm+rhrBNo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2c0OUsxTWNyUjU5bXBjWko4Y2RzY0YvQkM1NVF2OUsySjhVaXQzWnJGN3NW?=
 =?utf-8?B?N0s5Zm8yQlF5VHltdlJuNlRRYm81RWZtK3g2Tkx5R3B2d3ZIaFZaK2FMSzZV?=
 =?utf-8?B?Y21jUlhXU2NEL0pXeDdqalBScm41MVpzY2N0Vm1EZG1sTGdWd21Jb2FLRXBa?=
 =?utf-8?B?VVJFT1I1T2xtQ2tmVnBvUEFQWEIzS3Z4TTZ1Zm1za0xldC9TaUJWd1JqVmt4?=
 =?utf-8?B?Sk8veDZvckhVTEN0emxCcWFiQjhvRlVjaW9qTnpvUWJ1cXE2bVZvMDQrRFVp?=
 =?utf-8?B?OVZHd0xFUjJXZjB6blhKTENaK3NwRGsyVmkrMEYrVXJEYnE5cGFHeks5bklW?=
 =?utf-8?B?dW4zK3pYZ1ZlYWRKajF1M0lwZEdwSVhMQVNUayt0QnlGNm5mM3VzbDlCM1Qx?=
 =?utf-8?B?NTVZRXlzUkd1TmFsbTR4bU1lZ2JUZjRpRlVSVUY1ZjJxT3lXSEVlS3lBdTVn?=
 =?utf-8?B?MWRxRHdBS3A1TEQyeVpJbGZCN0xqbmd5OFZyYjEybDB4eWMwUnZackFteXNz?=
 =?utf-8?B?eG14eDhxeWcrY0ZtTS90YjVwQ2VuUjFhZ1BhMFpLakwva1Fscm9Qekc3SUlN?=
 =?utf-8?B?YzhkekdvK3FZMVUvVHNDZVBzaDRUUStOQU03SFJ3eW4yM1B6NGFNZWdyQXMw?=
 =?utf-8?B?ekNrZDNzUXhnL1Z1ZjBaNHhCejRpeHJoNHI4NENvZTRBY2xHZm5qMGJxM3FU?=
 =?utf-8?B?Z1VZdU1LRm0yZkpocjVVQllZNmcyM2tZSExkanNRUnFFWGdLVC93MDFTS1Zo?=
 =?utf-8?B?YnQwUVNqZG1vdzdUQktFNVNpVTdWQlo0NFpTYjNVTExqeGFueXRTRi9mRW52?=
 =?utf-8?B?a25GVzVUczFJTlJaTVV4clhnMUVRNlZRODZ4ckU4NlpXajR1SDBZZjBhT2FC?=
 =?utf-8?B?RzNxaVBMMlVFTkswaDJweFpXMUs5em9XTzl3ZmJEdUtxTE9Wc251Rzl3WlBE?=
 =?utf-8?B?N0xYanJqYnd0UzBzZUFiR2d3ODFjaTN2R1lBaHl3Q1dJMnoxN2IzTkdGRDg3?=
 =?utf-8?B?eCtObUJQSytZVWlHd2Z5YVZpdDU0eEFwSllqN0h1dktJZk9BcGpmMnRERndV?=
 =?utf-8?B?OHlyMk82cHZCSmpBc1F3cHhrTGhPb0FIQ1hMSTBKQm52T2hMZ3Vkc1VHODJO?=
 =?utf-8?B?TFh3aElzend5ZnNuTm9WV1VLNGNldDdzRnFmYWdVU1pmMnVLM1NuSTh1dlJr?=
 =?utf-8?B?ZTloeE9LOWU0MDF5Y01zV0pOWFF3UnRHeDJyQWtNaDJoSUhsczhESDl0N0hz?=
 =?utf-8?B?UU0zejdnSVppZUJtSHZPak5OdTdPelkyeVNNbGZLdlJnWk5WcnplenY1RjNT?=
 =?utf-8?B?QnRHV3hMQ3BVV21qSEMxb0dVa1BjWFEySnpSQk9vbFlUM2wrbDNndmFuQi91?=
 =?utf-8?B?QVlBNFVOR2hjWUVCZkhESHJ4UmNHMVhyeTlTQmpQbEpucnlrcC9EaUN1aHpz?=
 =?utf-8?B?MUNMZ1pmbk1rV0N3TjRmUThKdlVFUWtjbkNxbWpPU3U3d3lHVCt1VmFwdVNE?=
 =?utf-8?B?eGo0QjkrUTcva0RBS2Noc2pCRzV2Wkhqb1czWUFESmFJUXRTM3RjalpNQzha?=
 =?utf-8?B?bFloRUlKdUFHQTMvNGVaRjVPY0xkbC8wckxkQldYOE9lZzVQYTRiMVREb1gv?=
 =?utf-8?B?NTFKais0ay9XTGFta3hLYjUwTXhhdXViRW92OXlEbFZ3Zkx4aS90L2JBVGRW?=
 =?utf-8?B?T2hiTzNQeXJzcisrL2ViU1EzQlAxeVREcy9WQWJGU0NCOWNLZTRnbHRqMDM1?=
 =?utf-8?B?OHpiMWdRWFhoVFlzdFNmQ0pPbE5oUGRBQnBiL0ZaT09KYXlnYWhmd2pRc0Fs?=
 =?utf-8?B?a25MREVVT3Jpb29uZTMraFljU3FNTU1IdUZ3TFptVzZYWkIxNks0S1NISzds?=
 =?utf-8?B?ZnhpTlFYRVVYeXJheDNmdWMwL2pYdCtpdkMzTjE1WWJrQ2pwbGxxK0hwcXd2?=
 =?utf-8?B?RlNiVUlyblNNcWR3eTg3cGk0SzRVNWRzODErdUtjUjY0Q3VLVnkvb2R2YUp2?=
 =?utf-8?B?bTAxMUc3VDgzbDJ6dGNRd1FXNU9odllYNGoyZXNlK3c2dmJ6OG15ZjFqOTk0?=
 =?utf-8?B?L3R3MkR2V3YzeEtRRElSZXd6M0VvMW5wNGRLSEdESE9PSGFqQ3pQNVZKZStV?=
 =?utf-8?Q?KhFBVHte78vMz5hGZx2OkLlUE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827ebefb-0594-48b0-fe79-08dd50155d88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:11:25.2400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNgVV/NFMjyxCk6aZGX0a3t9gffKXsCYvEE11zYgWHrUNAmSuH9Pnj/1kDsV5JSe29o8ITWwS6c4er0icc8fJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 doc/imx/imx95_container.txt

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 00000000000..2ad57345069
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Conatiner |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Conatiner     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
-- 
2.43.0

