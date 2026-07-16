Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608BCC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 13:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5555A84CDF;
	Thu, 16 Jul 2026 15:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="aKkEtTo/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A88084C9E; Thu, 16 Jul 2026 14:27:13 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE0484C83
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 14:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GAGjq92296061; Thu, 16 Jul 2026 08:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=iE8iI
 GQP+2auTytJolAVT4eykTzZLkUH7GSXMpSwDJA=; b=aKkEtTo/Hq1GHT1zL3h2R
 cVoPW61JP45AmR/1+y1ra9xtNZBeeddT/JSD16WstxRm8RjEIJT/Lv1TdZ6cILcl
 LV8v0bvZPxA1UhFco0VxuZ70wPmH53UoPTEItTj2wpmtcAOUlFgjDf4yHCsmULik
 GkTEW6I27FBXl4yc9J5eS45/8IzEnI89OnTjRXLLEwZ+u5OaW7z4ElJTtmxYXI8D
 IrcbBgfA26gebylpEVd0hy083Zuuc0qlOkMQfpRdeim6GZcUHCQKjabyPiZlc8dQ
 c0DXd7z5bo6E86sonEaRs35foODO5+OzFP64SxLH+AeLRt4ibOMOAfmHcJCwqmq/
 g==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fewdj0cc2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 08:27:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MwGHzUDzReex0HPRTwuYCJM/4k9jUJXNX89NF41RAyYu+6LYE0aBPfSGTobtw3C0iqTNRnE42SW2+4xHTGSUxeafLrMtmTMrOdGqtTgEeRxhKJiV+9giXbhuDP2q5SE9IsWeBR8DSuirwhhruG/uMW2I1CZNgRU++8q5juXD3f9GEpED5Fq/PqiLqa5iJ/mKSNrPS+BzNfGmYFtC7gjWczwANloFbGu1F5gREQ6gaYedRGbPwuyUcgHGMdxp6wSgaG1qz//YpZsgRJK7uKwGwNOPQ/RBrOsF+P+r7ockKu0mAdjVhSnFe6GGFSssUYwjQyrfZ/zF+4JOs1uez+vbEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE8iIGQP+2auTytJolAVT4eykTzZLkUH7GSXMpSwDJA=;
 b=e0fZJJHeP1GeNTzk3DYINluHyLWY9g7jvtGXsUGT1eA7blkPMrvbFfPwQDoKlQ28d/z46hdt3zZTvk19q9R8tFt06FlZDi0gX8UEKAro3StRzEMttRLtsNGfA1x6O3L1PFt8fDadrfbaL6MOaJf4eMOKEmO9YbjC/VIOVTe+1bnpNd3aOvEopEYF0CRuGEj/j6diXh35JYo0PI13g8cVPFZqdLuCFOUH1qnGPInTCvuN1PedWcA9Cq/xmjyqM8npdyGnDjmOR3D7VLAbIdt3H8/UFmtyHhNxBpNdcz1IxvE+u/a/TErjibwfniLQqliZd0YuZxsh4vWTC3DIv1lU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by CH7PR03MB7881.namprd03.prod.outlook.com
 (2603:10b6:610:252::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 12:27:04 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 12:27:04 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v2] arm: dts: Add SD dts for the sc598 EZKIT
Date: Thu, 16 Jul 2026 08:26:49 -0400
Message-ID: <20260716122649.646-1-Caleb.Ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713174726.12157-1-Caleb.Ethridge@analog.com>
References: <20260713174726.12157-1-Caleb.Ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:335::19) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|CH7PR03MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: acf2c03a-84f0-433e-5fcc-08dee3358b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: G5AoJCUH/GKEbbRbbJslbZ9N6TCBF3ATX1kEdzjsYJMNx82esQRFZlp5g43/s6tHbO15A0AimIIR90Bz59egL3dAevXhopWl3t89Xle2xx9fZhiM0pOIbT7e4grodfptxPK1apgzkpryAvu788A0Y7GrkllyiSii3blcWLGG6tZIfCfiES7df80DnIlSXpBCVYKtKnSuzLhlr0EeOcKPPI+j7mxVYMJktZHjZK9/cGtPGxlu055s43zy4tBSNnrTZD+Ou/0x1jSkt1q85nalxsQyG4qf9NspUtJPBg76jOLXSKSG+7WCnPR8FD1bxesFNkkzYNu5+sTtWvXZwzlBnYJRVK7cmozToxSE7Ip0oADct7DROfoVEMn++whwPMqdASBjec2KSBEKycZ62RJCwgelVbj3/JB/OFD82GBBCcfvY39z+vhmDmH4ESD4ceIbheobe1m0yBtmjDIyIdKasczb3iyW2/YOGJ4AfgYfFoWfzQqLTZK1p5GvYVY3xRA1n3962UkGwWZsD2YuCQU4WJQhBz55oYuLM7YA6frBnRiEvM+3Yin49/m1I++UGcIqOFpr4yRMxLwpakqg1gU91vv2uJl7thpdg5czM5eG1UWqbtL1DZWk0W/SqqbZyHiMQK67uytiKRfJRg3GHOIN/qeOyp4ZuDpdSgEcqvV1Eeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7db5+9UUiBj5eh4QrFT8wRAd5hLSEnPLBIA8vKJuwUHqkYKXSkwwcsUYIl/o?=
 =?us-ascii?Q?TX8sxMTqUKxIyE1ujijzyHhgrpoMnwlipMUrC4+iYBNHKzZZKOlpk3KPrB2u?=
 =?us-ascii?Q?YiP26e7HgsIX+PBHoNQtomWbIyO2A5hPK640ioQ0Gw7cPamFAyZqKR9XL0f7?=
 =?us-ascii?Q?tqVzJynGetYVCIi/Fb2buCuaFGjBc5ALwZ/vlpafW31XqvYVmhIP/qbjSRHV?=
 =?us-ascii?Q?IhGY5c8HPHlEvp9gTUhfDjq8R9gAup8yyapHhlUJyfegKGqOX0xOpA+5DDsI?=
 =?us-ascii?Q?4fT82SpLRDgaSzB/BKwNm4bee2STJXSMonT9H1X6+690+vQYDRd6ci/eixTY?=
 =?us-ascii?Q?6CITfZ6AB3Aj4dd0xBe/IprEZlTvAwuzT8H6+8y5B0iPM1nDMrG+lZdaJ6N8?=
 =?us-ascii?Q?eCVHtbAVEBLxPur4WWGzAE3om/Y5MCEuopCaJW3u7zn0IhP6oiHVlBMBFrlB?=
 =?us-ascii?Q?bH1ahNntINAYkCkWVBkkoeBK0w0uiL7J88qFU2rZ/hcBuncdVW2elckDK8n4?=
 =?us-ascii?Q?3b3LmRfMdMr+02WzEAPVpEuf8arD0VHqmn2zmxNhGIfABARwqtHFgPaoWCIr?=
 =?us-ascii?Q?exQPfChDHVqLHRB0JRQNzopsTwvIqocJj7w9Z9akLmDiRQ2p16zD72pNldkc?=
 =?us-ascii?Q?WbwxnBSMVVMOfhGC+rUPykhHTejc2ZGkxezDMFz6BbLyDsw7YnAoHmuM/11d?=
 =?us-ascii?Q?QoRSLDP+rAW1Q+r4JTY3BZz7F6QI+FPMlrDtF8DYcIL35j/J2Q3h3tR7hUaL?=
 =?us-ascii?Q?pDdG9xhyky/M8hHuAn4J3EHGaLOWCvueRw/sMpe6qelyTjODA0AWFWZjrYL1?=
 =?us-ascii?Q?2YecspE8ScCBa2sssgujlarTNlluHY8X6IcxpFPLmstzF+S43Q/F1GFF7OSy?=
 =?us-ascii?Q?1FVmRwse4msQ+WRAqYMOJ1Ic3urmzmnj2pUuv/GxKrww20ZIs/1rbB+5MTcx?=
 =?us-ascii?Q?tyeYvmPGv6rZNRGTFctE/K2VFOU8t6JAUbx3NjsadJu2c6Yzpjb4WFjnQxLc?=
 =?us-ascii?Q?WKYLtvafmFB2Ilh8r2Jnk9TrutTPg/cFMQM1Y4PH6ZY9EXCeeTC8bENQ3FIG?=
 =?us-ascii?Q?N+9EDnidt4qRJtqhDJ1wzAzcL8ru71BJ8cRGNE90SqJ7+Qx57j85YG9ed0PE?=
 =?us-ascii?Q?7NVQvTku8/lZewtiZLiK/FY7yieAWo3u/Q2KYtt7bKzQPRs2rizYTkVroJ6R?=
 =?us-ascii?Q?S4nyEylr1rc4jBf5CfZlHkW2OmLowKf0YIVLc8zJ2rtAeU77WHvmpRKV+j8O?=
 =?us-ascii?Q?RNSJzcq0pTAZLQx6j6ZBU1nMm8umvHOAvT/HZF/hHqEmx5GVMgKKVxEh8JRZ?=
 =?us-ascii?Q?e5rCj49pWKJc7d7Lp7nrS83hxdNGP08intQBJOYOrGRaMnvBajoC5agiukNc?=
 =?us-ascii?Q?mR8vmp8AQfs/VlIMVDhMvV2p6zMZasNcwuwyUKuJ6W4I2U/PZfrevgNzp8in?=
 =?us-ascii?Q?icmL2kWXitFVlwgDtCnEiWCxLqtbRUWarS/oymBECeTUZSuRIm/ikL+D2gAP?=
 =?us-ascii?Q?tRKGN1cOytxt2PCuA2Kdtu93prM68pPr2JFxNhqZo3cdReMN8OhsSgAFFy7J?=
 =?us-ascii?Q?Ypy90FJG8LzhXS0ajofVhoZw3wz1rCJlciFOnbZKR1MDouyhTYQOcHiqE0Wv?=
 =?us-ascii?Q?kYjULlybbTuweBq0KCeDGUWwYQ4YDyzT0FfURQuzlnZY8sPsV4W/U3Y/wWHm?=
 =?us-ascii?Q?0PqYfGJlMcq08LSaUCFYPmKnK7STZOZKxA6F244ja4GNGjsO4ANI8aQSlD+v?=
 =?us-ascii?Q?cKnQPsRLWisne6q8Y8R8RPM907c0gsI=3D?=
X-Exchange-RoutingPolicyChecked: R6faTKTJRDcwHK42S3lDIXULN6oPf6fBDiGGuEdexX8BCMO5mCT0V4GRgZ7eEBmJzeZ/dxlKqruys0cT/J6p8Ap1SRJ8fKYgZ7j3MY28RSgB/4zrFLtZK24gQbNWhJe9wissRm+G1iiii/ACkWIfIIfbIuDLoXPXp0q8/aGlQetWk1FxsvquSkqHXQtuchFUul64I5uZQT/+6ebAwfbCPS84K317qMt0uU8ieXTBfOGJFtvXj/pXygNRapffzGPRY9kMKMOZwL7uQmO0XAd0nTpBaIAY3bA0MNq1uzlNCVPDZkPXaEZYd0Y/escFQjKRFYxqE4lHv/9bpxBE+DyFIQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acf2c03a-84f0-433e-5fcc-08dee3358b7b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 12:27:04.7323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CIz3zmjcI7EJy8uaop7FhPr+1F+cjMC9XY4JVSG48ApDj51OJQw/n3nAwomjieoizIasOC9kf0qZrPYpP7f8LueWmBM2lYaAnCScqNNNmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR03MB7881
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEyOCBTYWx0ZWRfXwo0cXvZojmE/
 GLx1DC9UtPOdEEeemkt9Y4RfjUZHLOXDo5XRofDFBYU98U9fU5q9RDkGTyUB+n7u4fUmHzCurSg
 qR0bFa8/4M2digd0N8V8Dh3CKwD9pETtrD5OAYted6vSus8F/dsZ
X-Proofpoint-ORIG-GUID: xEpxx73VAlfMkmvvjSZR7GoawXureMkt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEyOCBTYWx0ZWRfX4I7slv+gvHpG
 bIjVXPICyFOeeWmUFAFWhE9nWFUjO0hkWEljOCmwpm+gFaIshxDBWZB1a3wfq1OvO0J5qE31aDl
 xZYZNffI8zbb4mvZNxfN57XVDYIX3I0gNtOP8FqXhtdXav8G7WXyNIlQQ6ybVj9spFE2Eo3ZIhE
 232YJJOfRVwVnsYCB3Otg+nVzUbPLk5HrAv8xIx20UwR8EUcP4mUaoBubd6JCk6JyzNwYlDDKHT
 dvsV4Oj2hxGvERJ1vwjSoz5B137w7WhOZGnwiOxuYQe1xM4geIj2fTf1NHdrrPNUAZ9AyUJCgL2
 bnldTyfgIegdyFVko3hESCYZzBnrWSvAOO8A45HI+c17aAchUt+Wvu+zclocGN7LrrGo8Swnuwk
 I4zp4XSQ3HgPQ6yMVFGN68GjOqs6jFe8R3x7lVBYyndY9xMKrZT7GviCaeHWAPblUzH88QVHcOt
 ZNuerfwTL3kzhvxKA9w==
X-Proofpoint-GUID: xEpxx73VAlfMkmvvjSZR7GoawXureMkt
X-Authority-Analysis: v=2.4 cv=Up1T8ewB c=1 sm=1 tr=0 ts=6a58ce1b cx=c_pps
 a=yPbt1s1ZvotafXW9/QH5sA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22 a=gAnH3GRIAAAA:8
 a=g7soJyg0bVhNlfqxNd8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160128
X-Mailman-Approved-At: Thu, 16 Jul 2026 15:02:25 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The eMMC and SD card on the sc598 share pins, so they cannot be
used at the same time. Previously, this was managed with a patch applied
by the relevant build system, but patches are brittle and have to be
maintained. Instead, they have been replaced with two separate device trees
, one for eMMC and one for SD card, which inherit a shared base dtsi.
The build system can then select between the default device tree which
enabled eMMC or the other device tree which enables SD card support.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
Changes in v2:
- Changed implementation from dt overlays to inherited dtsi files, and
  set the default dts to select eMMC
---
 arch/arm/dts/Makefile               |   2 +-
 arch/arm/dts/sc598-som-ezkit-sd.dts |  32 +++++
 arch/arm/dts/sc598-som-ezkit.dts    | 179 ++--------------------------
 arch/arm/dts/sc598-som-ezkit.dtsi   | 179 ++++++++++++++++++++++++++++
 arch/arm/dts/sc598-som-ezlite.dts   |  18 +++
 arch/arm/dts/sc598-som-revD.dtsi    |  16 ---
 arch/arm/dts/sc598-som-revE.dtsi    |  14 ---
 7 files changed, 243 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm/dts/sc598-som-ezkit-sd.dts
 create mode 100644 arch/arm/dts/sc598-som-ezkit.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 25234697e6a..dada5f9eba2 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1154,7 +1154,7 @@ dtb-$(CONFIG_TARGET_SC589_MINI) += sc589-mini.dtb
 dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZLITE) += sc594-som-ezlite.dtb
-dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-ezkit.dtb sc598-som-ezkit-sd.dtb
 dtb-$(CONFIG_TARGET_SC598_SOM_EZLITE) += sc598-som-ezlite.dtb
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
diff --git a/arch/arm/dts/sc598-som-ezkit-sd.dts b/arch/arm/dts/sc598-som-ezkit-sd.dts
new file mode 100644
index 00000000000..9b5f60192d5
--- /dev/null
+++ b/arch/arm/dts/sc598-som-ezkit-sd.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2026 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc598-som-ezkit.dtsi"
+
+&som_gpio_expander {
+	som-emmc {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "som-emmc-en";
+		bootph-pre-ram;
+	};
+
+	crr-sdcard {
+		gpio-hog;
+		gpios = <9 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "crr-sdcard-en";
+		bootph-pre-ram;
+	};
+};
+
+&mmc0 {
+	max-frequency = <44000000>;
+	bus-width = <4>;
+	no-1-8-v;
+};
diff --git a/arch/arm/dts/sc598-som-ezkit.dts b/arch/arm/dts/sc598-som-ezkit.dts
index 493d2010e32..40350cff105 100644
--- a/arch/arm/dts/sc598-som-ezkit.dts
+++ b/arch/arm/dts/sc598-som-ezkit.dts
@@ -1,179 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * (C) Copyright 2024 - Analog Devices, Inc.
+ * (C) Copyright 2026 - Analog Devices, Inc.
  */
 
 /dts-v1/;
 
-#include "sc598-som-revE.dtsi"
+#include "sc598-som-ezkit.dtsi"
 
-/ {
-	model = "ADI SC598-SOM-EZKIT";
-	compatible = "adi,sc598-som-ezkit", "adi,sc59x-64";
-};
-
-&i2c2 {
-	crr_gpio_expander: mcp23017@22 {
-		compatible = "microchip,mcp23017";
-		reg = <0x22>;
-		gpio-controller;
-		#gpio-cells = <2>;
+&som_gpio_expander {
+	som-emmc {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "som-emmc-en";
 		bootph-pre-ram;
-
-		eeprom {
-			gpio-hog;
-			gpios = <0 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "eeprom-en";
-			bootph-pre-ram;
-		};
-
-		pushbutton {
-			gpio-hog;
-			gpios = <1 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "pushbutton-en";
-			bootph-pre-ram;
-		};
-
-		microsd {
-			gpio-hog;
-			gpios = <2 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "microsd-spi";
-			bootph-pre-ram;
-		};
-
-		ftdi {
-			gpio-hog;
-			gpios = <3 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "ftdi-usb-en";
-			bootph-pre-ram;
-		};
-
-		can {
-			gpio-hog;
-			gpios = <4 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "can-en";
-			bootph-pre-ram;
-		};
-
-		adau1962 {
-			gpio-hog;
-			gpios = <6 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "adau1962-en";
-			bootph-pre-ram;
-		};
-
-		adau1979 {
-			gpio-hog;
-			gpios = <7 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "adau1979-en";
-			bootph-pre-ram;
-		};
-
-		octal {
-			gpio-hog;
-			gpios = <8 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "octal-spi-cs-en";
-			bootph-pre-ram;
-		};
-
-		spdif-dig {
-			gpio-hog;
-			gpios = <9 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "spdif-digital-en";
-			bootph-pre-ram;
-		};
-
-		spdif-opt {
-			gpio-hog;
-			gpios = <10 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "spdif-optical-en";
-			bootph-pre-ram;
-		};
-
-		audio-jack {
-			gpio-hog;
-			gpios = <11 GPIO_ACTIVE_HIGH>;
-			output-high;
-			line-name = "audio-jack-sel";
-			bootph-pre-ram;
-		};
-
-		mlb {
-			gpio-hog;
-			gpios = <12 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "mlb-en";
-			bootph-pre-ram;
-		};
-
-		eth1 {
-			gpio-hog;
-			gpios = <13 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "eth1-en";
-			bootph-pre-ram;
-		};
-
-		eth1-reset {
-			gpio-hog;
-			gpios = <14 GPIO_ACTIVE_LOW>;
-			/*
-			 * USB0 lines are shared with Eth1 so  Eth PHY must be held in reset
-			 * when using the USB
-			 */
-			output-high;
-			line-name = "eth1-reset";
-			bootph-pre-ram;
-		};
-
-		gige-reset {
-			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "gige-reset";
-			bootph-pre-ram;
-		};
 	};
-};
 
-&ospi {
-	status = "okay";
-
-	clocks = <&clk ADSP_SC598_CLK_OSPI_REFCLK>;
-
-	flash0: mx66lm1g45@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "jedec,spi-nor", "mx66lm1g45";
-		reg = <0>;
-
-		/*
-		 * This is board dependent to some extent.  We've been able to
-		 *set it higher on some boards
-		 */
-		spi-max-frequency = <66666666>;
-		cdns,spi-calib-frequency = <10000000>;
-
-		spi-tx-bus-width = <8>;
-		spi-rx-bus-width = <8>;
-
-		tshsl-ns = <50>;
-		tsd2d-ns = <50>;
-		tchsh-ns = <4>;
-		tslch-ns = <4>;
+	crr-sdcard {
+		gpio-hog;
+		gpios = <9 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "crr-sdcard-en";
 		bootph-pre-ram;
-
-		cdns,dqs;
-		cdns,phy;
 	};
 };
diff --git a/arch/arm/dts/sc598-som-ezkit.dtsi b/arch/arm/dts/sc598-som-ezkit.dtsi
new file mode 100644
index 00000000000..54ba866db4b
--- /dev/null
+++ b/arch/arm/dts/sc598-som-ezkit.dtsi
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+
+#include "sc598-som-revE.dtsi"
+
+/ {
+	model = "ADI SC598-SOM-EZKIT";
+	compatible = "adi,sc598-som-ezkit", "adi,sc59x-64";
+};
+
+&i2c2 {
+	crr_gpio_expander: mcp23017@22 {
+		compatible = "microchip,mcp23017";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		bootph-pre-ram;
+
+		eeprom {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "eeprom-en";
+			bootph-pre-ram;
+		};
+
+		pushbutton {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "pushbutton-en";
+			bootph-pre-ram;
+		};
+
+		microsd {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "microsd-spi";
+			bootph-pre-ram;
+		};
+
+		ftdi {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "ftdi-usb-en";
+			bootph-pre-ram;
+		};
+
+		can {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "can-en";
+			bootph-pre-ram;
+		};
+
+		adau1962 {
+			gpio-hog;
+			gpios = <6 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1962-en";
+			bootph-pre-ram;
+		};
+
+		adau1979 {
+			gpio-hog;
+			gpios = <7 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "adau1979-en";
+			bootph-pre-ram;
+		};
+
+		octal {
+			gpio-hog;
+			gpios = <8 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "octal-spi-cs-en";
+			bootph-pre-ram;
+		};
+
+		spdif-dig {
+			gpio-hog;
+			gpios = <9 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "spdif-digital-en";
+			bootph-pre-ram;
+		};
+
+		spdif-opt {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_LOW>;
+			output-low;
+			line-name = "spdif-optical-en";
+			bootph-pre-ram;
+		};
+
+		audio-jack {
+			gpio-hog;
+			gpios = <11 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "audio-jack-sel";
+			bootph-pre-ram;
+		};
+
+		mlb {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			output-high;
+			line-name = "~mlb-en";
+			bootph-pre-ram;
+		};
+
+		eth1 {
+			gpio-hog;
+			gpios = <13 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "eth1-en";
+			bootph-pre-ram;
+		};
+
+		eth1-reset {
+			gpio-hog;
+			gpios = <14 GPIO_ACTIVE_LOW>;
+			/*
+			 * USB0 lines are shared with Eth1 so  Eth PHY must be held in reset
+			 * when using the USB
+			 */
+			output-high;
+			line-name = "eth1-reset";
+			bootph-pre-ram;
+		};
+
+		gige-reset {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_LOW>;
+			output-high;
+			line-name = "gige-reset";
+			bootph-pre-ram;
+		};
+	};
+};
+
+&ospi {
+	status = "okay";
+
+	clocks = <&clk ADSP_SC598_CLK_OSPI_REFCLK>;
+
+	flash0: mx66lm1g45@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor", "mx66lm1g45";
+		reg = <0>;
+
+		/*
+		 * This is board dependent to some extent.  We've been able to
+		 *set it higher on some boards
+		 */
+		spi-max-frequency = <66666666>;
+		cdns,spi-calib-frequency = <10000000>;
+
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+
+		tshsl-ns = <50>;
+		tsd2d-ns = <50>;
+		tchsh-ns = <4>;
+		tslch-ns = <4>;
+		bootph-pre-ram;
+
+		cdns,dqs;
+		cdns,phy;
+	};
+};
diff --git a/arch/arm/dts/sc598-som-ezlite.dts b/arch/arm/dts/sc598-som-ezlite.dts
index 40cabd1db0d..3424a967caa 100644
--- a/arch/arm/dts/sc598-som-ezlite.dts
+++ b/arch/arm/dts/sc598-som-ezlite.dts
@@ -12,6 +12,24 @@
 	compatible = "adi,sc598-som-ezlite", "adi,sc59x-64";
 };
 
+&som_gpio_expander {
+	som-emmc {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "som-emmc-en";
+		bootph-pre-ram;
+	};
+
+	crr-sdcard {
+		gpio-hog;
+		gpios = <9 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "crr-sdcard-en";
+		bootph-pre-ram;
+	};
+};
+
 &i2c2 {
 	crr_gpio_expander: adp5588@30 {
 		compatible = "adi,adp5588";
diff --git a/arch/arm/dts/sc598-som-revD.dtsi b/arch/arm/dts/sc598-som-revD.dtsi
index 06d550b8532..0eaadc25c90 100644
--- a/arch/arm/dts/sc598-som-revD.dtsi
+++ b/arch/arm/dts/sc598-som-revD.dtsi
@@ -73,22 +73,6 @@
 			line-name = "uart0-flow-en";
 			bootph-pre-ram;
 		};
-
-		som-emmc {
-			gpio-hog;
-			gpios = <8 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "som-emmc-en";
-			bootph-pre-ram;
-		};
-
-		crr-sdcard {
-			gpio-hog;
-			gpios = <9 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "crr-sdcard-en";
-			bootph-pre-ram;
-		};
 	};
 };
 
diff --git a/arch/arm/dts/sc598-som-revE.dtsi b/arch/arm/dts/sc598-som-revE.dtsi
index 1f48d52109b..212e8334fd9 100644
--- a/arch/arm/dts/sc598-som-revE.dtsi
+++ b/arch/arm/dts/sc598-som-revE.dtsi
@@ -47,20 +47,6 @@
 			line-name = "som-flash-cs-en";
 		};
 
-		som-emmc {
-			gpio-hog;
-			gpios = <8 GPIO_ACTIVE_LOW>;
-			output-high;
-			line-name = "som-emmc-en";
-		};
-
-		crr-sdcard {
-			gpio-hog;
-			gpios = <9 GPIO_ACTIVE_LOW>;
-			output-low;
-			line-name = "crr-sdcard-en";
-		};
-
 		led-ds3 {
 			gpio-hog;
 			gpios = <15 GPIO_ACTIVE_LOW>;
-- 
2.43.0

