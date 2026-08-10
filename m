Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1A8C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 12:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75103405E9;
	Mon, 10 Aug 2026 12:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4XmZAbbdxxP; Mon, 10 Aug 2026 12:22:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F47D405D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786364521;
	bh=EFv18x91K5aKGlHDNtJvF4xW+L5tewx/gvTvz2xZKb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YCUyQX2RQQCwDNfvZh5nMdQfe05uE9KHsC8puUy6h5rhxMPBiWWPyIeaJaAnvZu67
	 WniMvCNqHxZk9mP+QJ4y7oq9nMYAqmeZmiNmHF6+cKtVQ+jcO4bD+RnAMxETsAvI7W
	 ZVwWCrgm/5Lf9If85JqsSm6xpSCEWt2SzvQaTNhl8H/gGMjaFcGjWjhyfJ5yqXW9Fg
	 BmKRCeHbypNEBlCpt1TqFRaxGAqEiup1iW7N9jzKK2mbeldSxkKDIGjQeU5yH5c99N
	 fo9R11hnWGv0PVLeRk0ZTh/SpUSh461OKjkQzorblgRoB8HplRX8qE94YWyzG+NN2x
	 FqeMwiPM2AL7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F47D405D7;
	Mon, 10 Aug 2026 12:22:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 152A423F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06A0A606E9
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7nox4dKTLVe0 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 12:21:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 91EF7606E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91EF7606E5
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91EF7606E5
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 12:21:58 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67A9TT6V3080646; Mon, 10 Aug 2026 08:21:56 -0400
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbba7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 10 Aug 2026 08:21:56 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY78eMTkxmGipTPKslpBK+0XU7W41WJYK43pcfCFFGZoGB7lgL6x+cjX9ecPfWCb/da3Btk2Pfu/lN3EZa+hj6YzKRimH/xsz8yzwLCEw3G0t4sQ7APMvx/qVZ5m/OWB+vegq17H282zRcoe+4/JklzASBBA2fS77RVOwZvqCURm35aKAH63/D3JQ6TuGYpYyRT6BHi8vYguL06URZ3Gu9JNcZbrxFV9IbumZB49iWhtLXMHNU1RQUT2G8DXYShK/f54zUiW8Vn5X1XGWHvzwUsib8tnuu5Ebe7/mXILtt9K+sMysTCj1R6AaFqiHmry6FWAXkE18LwEWy03mwkEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFv18x91K5aKGlHDNtJvF4xW+L5tewx/gvTvz2xZKb4=;
 b=FKwBv5ijkphHy/5/IjZ5USAuO+8jJKaYaiMb3pGFYU8QbIFTetOpSzZ4yPJSZXdxGDZYEGAFbK5mKrda4+rnQk4vp2xw01LqH1C6leQlCbSfP9GpGpyoicK3NR+u2feS38UkvVwaM4z4hHPzOOKOX4MNmV7I/IfwESD+ZEwJLDvW+SpVu2CjD6XQu+8YUVd7bJpUAqffn9147zSvMGkRvR8QpDxLlL5rlSWaE/JaIbReSssayc/aNHqPbBJMcgrYMobmuuqed44I4aXZI9Q5xnWZilZzLXbd25xTTc6S7RK51WslW4Spwx+ISUq5oERy0/ow8Zp+e8cPPKvnaXc3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by LV3PR03MB7521.namprd03.prod.outlook.com
 (2603:10b6:408:19f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:21:54 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:21:54 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND PATCH 2/2] configs: adi: sc594: disable CONFIG_EFI_LOADER
Date: Mon, 10 Aug 2026 08:21:38 -0400
Message-ID: <134552c7c8ae901e77960d35342d0c7371618328.1786363875.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786363875.git.caleb.ethridge@analog.com>
References: <cover.1786363875.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::8) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|LV3PR03MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 195f695c-12f9-4ca1-e81c-08def6d9f699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: xEGUtx0HVefZz3uHPMqSKpYriB9o2Ss4TE+K+F6zGP2h0IMZpByuV/lTIhUlU7ZuhxtpzdLNSTKa6fNBlU+JpxTTgP9Oc9hQhqI5hcDUTsNgQ4XkTbm3goZk4pcCoLUgytXR1CBKY156yQoLF98/u14Iferp+fgtawYFWP2I4gmCgGxa//xmAU2MCtmEg6fJm/e07+KdT1flpIYFygN8wUFsgnJlrfZa1SCB4j9cF8CDSEkCj9GLGB3mc1kqvMWWT9lCa1sU1fNXu7CEaAsGaICx1cWxx9uKJoDEHrhu1qWiBSH+NGDh4pZ/lqsAvOQMRp/s/w8LnZKwkFFlKfd9VZfv43+Q2OAif2Q8DIv6QaW1PvPpCdn67b1sNq5nwmCK82+EXTfOYS4oee7Q3CsZoTvLRTxMfio6KsOrM25W7G2SMdEi+f7ydVtKVlH6yVKjWDtsjMrM1XZxaubL/1Id/NAtjVHLur8Rf1VTdy8pCKp+3/8OnQ/09ntfGFWaj20YE5JyR/lObcO74QmHYi5U+/Qnroe1KTK3sVlydh5gu9dUbQRj/spR5KzoB4CWuihCJbu+9JkIGdS+qNaEDEc5FEODvYtlOJpAonECktSLQfW58cvojS2SQ4UGSNiZdtT1OUATkTayG8vWjC22MWFfgX8/eBeRT95ZGqhEt2NWuls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QwSBPKzBZ3bwytq9VbWr5YdnzGRJxxrlIpPcB2uh+r3pZW7b8Qsq5Grh7cQA?=
 =?us-ascii?Q?K0wJEwk844Bi/lwOp4oHF7hO1qKN8lXWNgd4/CydMalZZlXWGwil1rT4XGOt?=
 =?us-ascii?Q?z0g+AKL0xbOwNIxNAl42BLBmIYoxzn3dooZSOM/2EqntiJPvqba6qm+XCRtR?=
 =?us-ascii?Q?b1jiRz/2TxCQayb1X+ifKOYWT8bPsJQBiIVXvptJLWfTHSzBFq9Skrj/wFs8?=
 =?us-ascii?Q?a851DYA3+GbygkgRNprXbV4VfhMFacupqZJjA/duH9U+imOy5Oa07I80cWCq?=
 =?us-ascii?Q?GrEJknD5N5pZpi0TmsgLPF5b51TTOkWCexGJoJy46Hn0g7nSAg34eSGrFrwp?=
 =?us-ascii?Q?XqqSN9+RGgmszP4uFsChj0VyiZiXZFxZ9P09PVDuGGA7ZPmGiCSc7V6qA7bQ?=
 =?us-ascii?Q?N+yIUB4iiackdz2kn/m4tC48oEZkb5SA5gfWTOwkNfJGrnfCx24SvXZyMW8y?=
 =?us-ascii?Q?nkGEqNNNYRkRqD3u5xs/k4gK1hKS9Ppohk3y9SHTdY/hpjTIuI86A9zuYNSG?=
 =?us-ascii?Q?0iCCxRC9DCfVYPqSuvWTNwd1OLRngYgWEgbm+vnYwukQPk6tRfJDszEUt7yn?=
 =?us-ascii?Q?W78iRFnnIEJSP41NGGbLZvvh5KLehqubXnHaDv3U7Do/BDg0d5YjM3sG2NrG?=
 =?us-ascii?Q?Aqxp1lQzcXSOis/vuLKh1XSLNR4DDCRVCXWVpZtYr3R4KejMGSxk4IvOo3OP?=
 =?us-ascii?Q?dGTTz424T2V9TNb87w6n88fB5KDuS8rqYkzc/VaLdbpUlOt4Ag7FE7J8ZQ57?=
 =?us-ascii?Q?xHaj10x6rrAgCdI0s/jPvAOiZxdYBR2NgBTt0zTqPK8raa8B/0EPMIO7eKjB?=
 =?us-ascii?Q?+dYsziiHa8hBN4C5/ROcClQoD+cZcz3NyX2Mh8k0aRTsRnBXSrXbxRKXK18x?=
 =?us-ascii?Q?CJhHDw5uWJLzOYby/kKXElqrP/x/3yeDIoQ3v2MPC5hb2Lv4W2a3dM3a1QJ2?=
 =?us-ascii?Q?OQEZkGFthhGFNAZ97zM14qW/KqwMYsOU5IpW9kKMHWtHQM9mN4KR13Sp0ul1?=
 =?us-ascii?Q?22iiSJFL4wA9v9OUe/fb11QGfHVSKVwt0koc/CbkLcr2gjrB27PoDBgh8+fe?=
 =?us-ascii?Q?2c+RoyjWNaQRme03+wHzMpqBjR10XcPRf+Xg9gKwkwVC1Sh9rzCnx9gbBUy3?=
 =?us-ascii?Q?Qqo2OuFrAIH8T3oEksPZMuHvg30h0FmsR512xqWflz4J0Nyx9GyTn1t+XSZ8?=
 =?us-ascii?Q?rwS0whb5Ffj+5tLxXdLPZPVJYvGKwyEwDn/l5IR2Ylh76Ox5+u2aJ8m2upY/?=
 =?us-ascii?Q?lFK9pcOIUgC66KH7niXeYElX01k2NllaJxcpjAHpzolyckve5mNQ7DHFynuO?=
 =?us-ascii?Q?n4m0bHdvvPjG2tWj+Vm4amlkIu7ovhfpj55rbolcmkqNHbw57/bPb7hIFr8S?=
 =?us-ascii?Q?jKVpkkh0Y7YG19IQNblYIdUi7f33gdXaUxYZdhXKTZH4XAN46hn8chCFDjId?=
 =?us-ascii?Q?sQseaRY7ngm3FqCUCNlr0WYjFsggawsmWHCKElFYiafgOUb1T5ScH3oj6wT1?=
 =?us-ascii?Q?S74bnqyy2sK07ofUSJB/bT+M9d0Xi7LiGUF1SQMzCiCAm0o8CoGba1jTnX9s?=
 =?us-ascii?Q?AHnamGdHA6BT2TwiT1/QwFr4oIuJoMBsNeGPx33WfnyLTDeqSWh1VrZISvD2?=
 =?us-ascii?Q?H0fiI0zcOV6XrYTFqh/Ip4TQd62drgLxEmUC1hQ0CW+I60L/4hlFjSrH3/5H?=
 =?us-ascii?Q?d89m5G6DX6oRGYT/zK2vhLHza9roHXoY6iu1dDrTGlEzAK12L94YRM8G6F8l?=
 =?us-ascii?Q?eCmQO7EGNMCQoN1Yj8C4fzGLbbf2sxo=3D?=
X-Exchange-RoutingPolicyChecked: Da4KAspO2U8XUJshuXLog1PrhEBYRus3focFVIdHa3ih/1co4Ui6bVKErxYX9Emoh3iKb5KdG2FgggNFHqEnLFv32KBvhokasealAvgfeUnet03jg63OWbJrgWZKGgVG3N96IjFHO9tklhb5HvFpdR0P0HAoD7SMb3hTMkHWIjIS7yiOug0RzINu0Z+n64w+pgNcKuSN+6jC4Szk4KKKNe/D2R7X5rhWzGMg1XqW1Tphry6yICiRPlBTLa+aDMzBlhJgIbuRwKIrAL260hNdTlosiRBWf00B+KTNs3W5r9FKHxGeM8JP4NWcTeXbxAZUjy3DwYKPCK4gd3muXcrpYg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 195f695c-12f9-4ca1-e81c-08def6d9f699
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:21:53.9267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMvRjZC2eQWdB5CagMFLMc+Bmi1ereVilvXIKEF7z3sSUq/hUsLm7A42UgVd0J3CSoBAGBTB8Hyu1Ceacml+LBP9fC5gb6zfOUeMHSirg1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7521
X-Proofpoint-ORIG-GUID: ZTauK9MEneV4Hzw_6J7XTQD-diR9NKZa
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79c264 cx=c_pps
 a=ojhc/3A0J58/V7uwnPnIuw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=PHwNFRM_nU-O8OdgQzEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEwNSBTYWx0ZWRfX5uFZAbHclLka
 je32MZgXxDa3H27Nr1qm/qtb+OzwCMAqE1Aqs9jjBxu2e7Yx4n6kjp+Bg/Q3F/nRwSWPHUZwjlY
 R6WdgPBkuBlM2qVGRweRDG8lKO3vJjCgf48Nndr5YRlUtqNTmPJjEI9NFBSNQedtGC3sa+at4PC
 HAToTwo5O72dtvx73FReSSDo0Dj4NtTj9rGqBEXsrI+xQb1Wi0Z0Xc/Y+ngBq/x9qb3OBySdO5k
 eCTihrUce5zRf2kMIEQVHMoF1luV37Yo2/eOP27GTrZDEKuy1roeeBl/nQdq2CIdJKvqPGooVZi
 UXszjAj0hbJS6d5Y6f7xbX/up0IiiVL6abrzIJMhuP5ttSxhi4KYi5IHMq6pkB/9SiUNIDv1vBr
 X2o6K5RXlrTzQFW2sAyHwesSuy8liCn6ZGGI88sWPBU3bGRrftzTBuCZBy1Ms6Oq6ZYjPalYF9O
 ZmttK495KolbZnPx7iQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEwNSBTYWx0ZWRfX3ezhlD+5qwCG
 m2Qb6Dqy7WrHbnLQildEumq2jvft17BFERgVoXn+Znr74k1Kt2EgdDg4tys5u8amyWThRZYiALL
 DcT/WC/UQDAeP7fgXD6Cdk9dnFVXVTHwPH6eod0O4kmxcs4wmHf2
X-Proofpoint-GUID: ZTauK9MEneV4Hzw_6J7XTQD-diR9NKZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=EFv18
 x91K5aKGlHDNtJvF4xW+L5tewx/gvTvz2xZKb4=; b=kYH6Ihc/WgQC2jz9aQo5J
 OlrqkShzfCcQ5q29v2RHc9ywlMN1fGx/X9Djb8ugpc5bFjW/C3NQZHNtdtxhzNdc
 OKNhYUmLAPmC9onkCUROK8meDzx0eRdvqu47BCRY7Fr7RFNx+jIJjaS0z7phgeiA
 PuuoXJ5aN90jm+4Qogry6ho2JWGw7QrFIHcq9MHr2Z/YRIyNK12RXgBAL9Vc9Fjg
 1G4I7/PK1bbvc4pjnJMjb0oag5AhGwVwbq7XoC4CVY6dWQpQKRN+M85dNbM1Fe/A
 IxA2I7fhBMTUWgvHxMYfYtDdFaK7IaJLBkuN0J+WgMmhxCx/+ERletd/xGb2lreY
 g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=kYH6Ihc/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Caleb Ethridge <caleb.ethridge@analog.com>

The SC594 boards do not use UEFI support, CONFIG_EFI_LOADER brings in
unused code. Disable CONFIG_EFI_LOADER for the sc594-som-ezkit and
sc594-som-ezlite defconfigs.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc594-som-ezkit-spl_defconfig  | 1 +
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index 4f8be110ee4..dec454d6472 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -12,6 +12,7 @@ CONFIG_SC59X=y
 CONFIG_TARGET_SC594_SOM_EZKIT=y
 CONFIG_SYS_LOAD_ADDR=0xA2000000
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index c045c67569b..9571c521176 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -15,6 +15,7 @@ CONFIG_CDU0_CLKO10=5
 CONFIG_SF_DEFAULT_BUS=0
 CONFIG_SF_DEFAULT_CS=0
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -83,4 +84,3 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
-# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.0

