Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA408C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 14:11:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9699B40533;
	Wed,  5 Aug 2026 14:11:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HB7sRc4QDxho; Wed,  5 Aug 2026 14:11:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3CC54043C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785939069;
	bh=ABFYpf7FNcsIz43uRV3KZHLDIz8i6UuPB9clDJKmVOE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hY9QCCoUknyFCAul6pEvywGPGnkCv3tjP0WpKLJBXEnsYgLRXEpp+IMqC2VpvJMXX
	 C94n2bTisDoMhdNRHX4RaD7hw6Q5ZmDeM1LrA89FCOmhxKJPnp4Hx9NpLO6tnqZP/P
	 fopiqjbUnbaf5e1DXmdGLlMMZUorimAt0lOgR1LPOCP5DBpDTXgkmvjLyOMNZYjAuc
	 wxBQ0HCMRz2QfvWd0VHYDz+L0qHW0ix+BcMOv57hsmMaObYQy4W2cbkozWYj3bKOA2
	 xegSiWg0pQyrBjbE57BFPPy1o/r5cDPX6styDgeZqdgk/P1ChlmBKhF8op1mdck74E
	 2EFt7sl0sST3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3CC54043C;
	Wed,  5 Aug 2026 14:11:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7E53218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99E924043C
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNvPAboiazoo for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 14:11:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.135.77;
 helo=mx0a-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C5E7C403C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5E7C403C5
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5E7C403C5
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 14:11:07 +0000 (UTC)
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675C353O647342; Wed, 5 Aug 2026 09:08:35 -0400
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fv397ghnc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 09:08:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAlRANBz3Q2TVqwJAAeLk0oOdCXU0kbfC5DieNKUVaEv96F7PODclKUqYIPjJCYwpDNF3EzNmWhH86Hl6hEgAcrDC9UkbgpXxvut20/XbiOPoAgjHXdZG87dQMWYGinil105EUn7zUtk5h8tsS7M25bCo9arbuQVbsWY2gfiot/Xjcz7c8tapsdSCQwCE1zTVCPxXxM4os6Sg3wQA8fvSq2IN6UqL33ONQZ2b9YqK+BNBG6uZjgSF3E4TDa8GL8ExeHj6n3dH9g2C7BBk47CtAaf0i/PgXsPbKL0OLGLEcFPuy4lbxYOknccxZqoqfWJuEU0rg/0k1X8Riz5UjdqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABFYpf7FNcsIz43uRV3KZHLDIz8i6UuPB9clDJKmVOE=;
 b=fssHm4eDR4q223jJD9acktMSxOjuWWiUcuFvu6TfdqMjEG10ANc6FWVs1gqVFX2kI7nMh4uRZtaW7nJMCVqdxJHvrw1Tv560X5fgE3KP5D4QCBpi8c5T2WRANxJ3qW/NVq520Sf2U2m+81X9oiSnkq8TlcU3Me8jdNdoskTmyQR7Ww09jIjEWwych+8NFhyHvYm2/Kdm7etv+y6GYy5CGQE/PiaHIV7oiuNvhOi+V1LYL8C/337ET/MteWs7Iq3uI2NOSCjPXTIJ2K0ytpzNIZcv+ErXgDoxQuFBxiLfHw/5qfRFq4iMv1tgzLgZor2IrGCnNlWKnQttd1TqTN60CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH0PR03MB6445.namprd03.prod.outlook.com
 (2603:10b6:510:b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:08:32 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 13:08:32 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 0/2] sc59x: Disable CONFIG_EFI_LOADER
Date: Wed,  5 Aug 2026 09:07:57 -0400
Message-ID: <cover.1785934620.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:408:e3::35) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH0PR03MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e067c4-679d-4bdf-7576-08def2f2a637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: A1Km7H2145dwH0H90Xy0zhWBvU130OXgoWYKCYq9ibjkHEkjFKeSeLdFpI4KwXyxUvL1s9HMugYumcsa17ay5qFQ0Vzjj+d1KVwUv/msv/HdbyJwKbJyvTvYFq/qCIDtP8CDd7RHoM5nd2h8O9Z4QOlo2De9fbMNWEc9IsSQpolpVkzQO4SmSn4xlCr08agjEs4ypgbcmO9rHHgH/PbBYPV7JGZuo/3yfOTLUXgoen1grAOon7GIaYjXi2i0+HL6IdcgDD4Xa9NjnPAD7uPGpI3srnb7hvLGE03d2C+gPlJxxeMEwOfyXF9QglyMDH/8RuTJUxGi212MW7NjwLWhx3dH64A6R0MblrGXeqluRKwuD9xC35Di05Q+CK0kmvI4SdNf+YzeJRbetcHndOZB/QODvZm6AB6oct/KfpObHfioeagZeM7qQ3MtSgMzyodjlbxDCtoqpDRBFYmmTAYvm6Eosjiic1UTBmfDqZsVzW0MESwe72mNLeAdnfe3Yyh91ukwtVBKJtQBlP9oQrc4ZI3fco4N0E2kUDX70o/IvUpyqR4JLk457iSYugKt2bCXeQikarrBddnmJGI/zkbO1tflWoiOIKql0XfKcvPFOF0wEwuMQPoJDQ3gatJXHhyetcPAhUfEyZw8ChWHgmrc2T5HWJH4bCn/7ZcuTep7VmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SJ1efC9nmrbuhIOdjoj4Eobd84II5UVUdSqWWsLsEiy3lAKJQUgBen0s4xXV?=
 =?us-ascii?Q?Rred7Iekfm6NtejFskCETsOD01mrFtfMEQ+Q0/lRVnrpaX5qtXEnL8bTAyhu?=
 =?us-ascii?Q?jKRKCLtB7h+IagjfUbmtjM4yCTqBKUBhGNoril/T+vFRfQqQ7H9f10cRh2sx?=
 =?us-ascii?Q?SWlYpvorD2qquKLyhzcvOCobAFIpYsOqVfB4IB3FlnZu7DVScsmaTxzUadVA?=
 =?us-ascii?Q?z/s9GzNBWLhOJGhXRblVzMyAFn/zacaqi3f0aQ+TrJfaP/YYnXxXTtPO9Z73?=
 =?us-ascii?Q?tAN7slAfv3E8GR3TEMxqGkcPyFUR48CB74GF1hA+W77sp7VbqX+bXRnchLns?=
 =?us-ascii?Q?++ZMOV6K21nf+lmV5j8//utlSIqgePpo0Qyxd0+/DaJz+BS4W+EgB0+AB79m?=
 =?us-ascii?Q?mCbV40E2G/vRSB97q7KHVGecaGI3gS7708R0hnO+VbYPoyD2maNVIFd3yHcQ?=
 =?us-ascii?Q?K3XkyRrH9uuxuA1bjyJKqoM359iD8oZaZsg3nnA6pY0RW0tlU1ORXR2awSxR?=
 =?us-ascii?Q?PGK9Eh/Hi8402Vdd3rhS6PdaqmudJXMQoibkD5DduSJAucOfAPH1MCqji15M?=
 =?us-ascii?Q?7DQEWePF4XIQUEZiWHId15qqfvuUI/tTOEc4K/vOmvLh3ZORvKTXP+FOnKbk?=
 =?us-ascii?Q?u2R10GaSylvtjVB26RLRzLLGolUwBtK1XzOHmYKE0X4I2gV3J9pJlnpBJ/8j?=
 =?us-ascii?Q?agxYvh890zmMHTnc84RhYmQWKzDMKflaGzjEH/Cke3NjxpAWz/aKVZeeMBtE?=
 =?us-ascii?Q?HjGo45P1oKWlZE2AniPR0M2YjmI/xq3LnTRMIO4ZUcHeyIrdZxOct9zRzB5q?=
 =?us-ascii?Q?yCktl/Ke7QI1HRbk32tE9jHQ81YxAQXyMFGArxAMQAWY9Zko1r7mobTpAXg7?=
 =?us-ascii?Q?qU2d5osG5AVeBlT4CUudCqV6oOnCSCpkFJJ3TIDWKcqAlkMenXj0XBK7UmMK?=
 =?us-ascii?Q?Xe1TFDJiJ9+MTVytD/linjTtLdEQl7zv3YZU5/tqpVGHh1vUnszJvWxxjcfz?=
 =?us-ascii?Q?+TDlcnK3Ry2mz1UmBTqCLGCEFPaxu5J9o+iIl6er64hnsJXpYNwt/McXwExP?=
 =?us-ascii?Q?8bGorrelyLXO/+k883zp722XWWBf6pjCpcf5nxF8KTw2YShpGQIUI6l6IbFb?=
 =?us-ascii?Q?+3DSGbdUgNl9MsiJ6pqgA3j5LAT3btPeYBZnpmapVE3OHm/BX7xaZJmenDmm?=
 =?us-ascii?Q?3VY1+G6JexF4cjChNR/Ars55ud9S8gXBxlUS8HByQUkAQx1Gm+Ioc3WMOPV6?=
 =?us-ascii?Q?dxds2+KwIIcv0z9Qtpu9B6ZTdBUiTCflPej96iLgdrEJlVBMfc31ArrmgrG2?=
 =?us-ascii?Q?zs9HURWXFyMtlBjyhWbJPDH12AFr6KrsubiySMM7S7HTxyF/kYkIAGBZ1hef?=
 =?us-ascii?Q?9Sxpabwjll6I3WAILmYmCHTw6ho0KNFlJPeAYMn4r3rmYYKDLOOStlSi7DoG?=
 =?us-ascii?Q?D1JKNUIzmZXqciKptn+6dR1VAG9NwjApQFKqkEYfSwFVFJamnU9oPZMLUk4r?=
 =?us-ascii?Q?2vQ/zF+8CNVA4IQkmtrwx5Yb2d459rTXKmO4r0uXS0OLB6ZbZtKSubQ8x2k3?=
 =?us-ascii?Q?maqNp07xyIaeTbZ4HSVATMIZXt5M5259JQdgu11Ly6Q13bmSd9zk2698JHcC?=
 =?us-ascii?Q?KQ8G9l98TfYa1Hnzc8ZPuMJtiW4POkwti1Md+jGLbti9fpZ5kcvyBPEynm+m?=
 =?us-ascii?Q?hs6/NbnxEJLK0y/jIWC13TZnpiaourG3qZQgQKBTFVpqyXoBv8+Gl/jgl6hG?=
 =?us-ascii?Q?ZdTIKqrs+YqQbiZtoiSjh2ebYaTvQf4=3D?=
X-Exchange-RoutingPolicyChecked: VCfmAnB9jysJIEWrcxa+1yzl60CRPFNj3TtN8618miMGMt+3XEP7Kt28FKhtDdCB0aQ/nXHTlWDtrd/2TwtVvppJIn9ol0+Ns443nP8ztrjbZjH4ELfj6xqMYtL1hYuLrNrhDfbUq5ivloLOu9sMjL2l4Az3Ia20H9k7Uf6gW4gaaxJq/Ttd1P3e3D63IBTaY+JAosYn1hEfauR0IhlutW5s6eGj8xqUBOA9PjfD3qfNA84DWTX2ZTkRvUIQjBoB4ZSkj9U3iWGKaVTzFnRJxSvr1HcsTuzfLcnTI1z+OBvJVP++A+IM6zxgU6yvDkipA5b2hSjIzaleOuHClQDgfA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e067c4-679d-4bdf-7576-08def2f2a637
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:08:31.9373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6e6BL4lbGfWaaAR9e71bx7n/QIjLuEchAlksAli18Dmqcn/g5r7o7WoQjXcqMFeDSJtyiLDBthdCyxyjg2Yf4PnZWCTY1nmW1pBd/2tgcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6445
X-Proofpoint-GUID: bhFy9UwdXYTCMuropbKUWBmMddhO0XKq
X-Proofpoint-ORIG-GUID: bhFy9UwdXYTCMuropbKUWBmMddhO0XKq
X-Authority-Analysis: v=2.4 cv=Qv5uG1yd c=1 sm=1 tr=0 ts=6a7335d3 cx=c_pps
 a=Sj0aQRr/q75bZ+qk1Z6sNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=7FwiKlg-Ykqa2fLWAkYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX0eEY126fVQHj
 b05HQF2ueAbepDQNZABXLOxsZxzyMdEHRzFGoGdUnC/n2WO/MhO07y5VNk2ey7AXlmoKhK+k/lk
 4S6lfvtnKNEg/YE3VR+w3mXK5uKjsTKs1ZYrMo3LhhecmQBxWmdr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX8nx23V/68Ekp
 Xunw8rvCo8jQkTp8wy+mVpWy5UoFzLLqq//RlGl6Nxm/gUvlfyVJ140BavFUAYywhyYLqNk3bGD
 cFXEs0joiUSuegCUwcn40jocZuq+hkXai/L70tri/1ppofpUptJ0GvEuJy3rdtxHDUpprxzwd2k
 xxw+ysN9S+AqXmeHDoPbXI+cXJe+fEULJYh68rm9WaeVEJmICFWbV8kagfuChlJKLUG49jmbzC7
 MVY1mYqScwescNO7pqWsKOVjNvA3REFFMjsRK7sZkUajFo5mCrwETXgiLx7chs5vhQBB5vM8eD2
 q6ufloipc9Hn5Ukeygxrr3auHaqaMiS509wtG6AyQhrvkDzH1e17QHsZbA0DoHr7BY86RfKbWqU
 uB1XekeczP0g3BOMpupiL163F9gV6hnTK0+CqtBgIGxoBiDNAUtiQwtRbbXMUSs+oUSRYhirBwy
 jxNLhdh2ho/SLWipZEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=ABFYpf7FNcsIz43uRV3KZHLDIz8
 i6UuPB9clDJKmVOE=; b=EDDH2nIhhlVYxjrd2KowdTsK5VGm3m0xIoIIiW5t3u1
 lv2c0oIyvFLjyyAjA2BukN59nDZ9Xx+O1g1B47L8q2KjSEbgxQOMidoipCv0Un7C
 YNB2RBIAS42OO4OfgUbVn+uFC0hDxOeKTc6zJx7nfp3ITQY9TwnKiqndy9GzoDb0
 rukg7uwnoxHfcbgRTd3Cf7KDhptizN+6Jix5ncqBN3LsOuMSEvan+wwBNmp/m0o7
 2NJPKsJPlaq4gQQkbsEq+KZrwntkAaVCZJwVT9xUrmGGKhIzrAxZauzDnYwIfU8K
 digKiHgGMmOXwNNDj3lAXfBUdCEKMQozzKXKk+F3DUg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=EDDH2nIh
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

The sc5xx boards do not use UEFI support, so CONFIG_EFI_LOADER
brings in unused code in the build. This is already disabled for
every board except for the sc598 and sc594 variants, this series
extends this exclusion to those boards.

Caleb Ethridge (2):
  configs: adi: sc598: disable CONFIG_EFI_LOADER
  configs: adi: sc594: disable CONFIG_EFI_LOADER

 configs/sc594-som-ezkit-spl_defconfig  | 1 +
 configs/sc594-som-ezlite-spl_defconfig | 2 +-
 configs/sc598-som-ezkit-spl_defconfig  | 2 +-
 configs/sc598-som-ezlite-spl_defconfig | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

