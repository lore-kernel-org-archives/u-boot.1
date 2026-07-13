Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F3FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:00:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BA3D84C8C;
	Mon, 13 Jul 2026 21:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="TB9wRnmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBFD84C69; Mon, 13 Jul 2026 19:47:42 +0200 (CEST)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C60584C6C
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 19:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DFE4p22869512; Mon, 13 Jul 2026 13:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=DKIM; bh=8akJouLGrRSJwwKdSRpH34YfNod
 Lq1/6ZsueBkPbGeo=; b=TB9wRnmyRKGko08xwEfsmRX2wDgVceWQOdxFxzuv/is
 j9IYjUhXWuxqC3ita44Sx3tYysL8tadtYC9t6brv0ZNpeaLnDJuD3pxNkNxq/Wdm
 fGJljvLlj//hEAencH17XbrkvVLdFq8tCniw0DpGD/T5vZf1vYV1iJTv0Dc+XkL4
 4bVzH+1LyxzhFEG7asAXgznlcEpIQZeSiIclDGFXdJGPHVCa1N4gPd9JyO0nJlgG
 qSQ0iixKzXh7O8wiZbEXA+v8gNBBPBNEpY0uCdTHzBJvGHQBq3twbGRu49BxSejA
 jrZIX3+Sn/9Q4OhTh8gw/8lYasADZPauOO50GSnBEPQ==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fbg3t6e59-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 13:47:37 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW6EuaW9vU63S9y7fJ4YeVVNBnCtR2O3y7mnNF2tox9O8WQk+D9pEIKguvn4VwwLR+Ubui5p76uOFCW2jGbM7px++3Gv7/B+badQtRKY+sw6iIn/+9hcyXAi5UCHt/WGj4CnekhYlv0G+4nEFCzSINkffb3kaLBeBc7XGXx/+/py8tdZsKVDTUyp7xYYMpv1jgLqk1a9o2yH2mTv9snmtowPWSigF+ZnMwlkS1lxm7mIeC26x95bCsiWjjjVIgZxLimidlAt5UO9AW6ZZat9rfhGZ+4iaPO2CWep424fE8UstZilloZsv12IMW1w8FZ+3evcmU3WLNwDFrtvduGwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8akJouLGrRSJwwKdSRpH34YfNodLq1/6ZsueBkPbGeo=;
 b=UAGWxGpZoLOl+5iI6ECfmNLvVUBOI8sIEPeJBBjc1iETAIGcDhokR/S3IdnHDi98HxqUInDI5imwEb7e8JYODzmtg7iwg03Fo9kdDDO9XMorfBez95E8BYhLu50kXkWgzQbqkoZ4kTwKxvaj17p/m1Ng9rGgb7fOUVbhmF4kCkqZyeC9cyFdT0nypDFCmk9iqzo/Ef5QI9IMRfCNpClQwQO8WeLRERFzD2t1B5syBMlqOKq0HRCHcBKnh49ikMyRiYJy63l6y0GFgrnnC9+Z6LlY5B6/54ynecVAxQQNz46pzim58HfwyLoJdRLPvLokCbh1/Cifml+0Ih1G7U/WKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by DSVPR03MB989243.namprd03.prod.outlook.com
 (2603:10b6:8:3ab::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:47:34 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:47:34 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH] arm: dts: adi: Add dts overlays for the sc598
Date: Mon, 13 Jul 2026 13:47:26 -0400
Message-ID: <20260713174726.12157-1-Caleb.Ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:52f::27) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|DSVPR03MB989243:EE_
X-MS-Office365-Filtering-Correlation-Id: b870f110-e069-4eb9-f63a-08dee106d1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: LceQy/N5ARvQYlved0VkrYPYQJyBg4TTvfhFMFeSNI5GkgU0FLbGo+8gDDs1nEn3lLCTQB12g8n6nWKJwYVFRL8QHVkMQbbfRYQahvT98FFIIscqXfsQSQMJ0VxE8UCiBzo7SOnWOLkowzJtmTLwv66kSLFB+EbnQs7NgJKTGm2sMkvzEuZX475wSaD5q4Mpx0CsZerGOQdBhgk0Z9JMjKFSIMF2JpluIkleBgUjlaXs6me4Zr5ty1TkPVnFPmLf8rGy8jVFIGE9uPqpnAObZyryXOL6RkjhZ71l5y+jqVjzkwjU/mCfSjA7OXllinAm5eNacCXddwqip0foJwogKKNhwUvZbFwI80RS50I9yWxiqmvlFv+jwQ3JtRZ/FpNfiRwstEBhvwDoq0hm/UECD1mDgfpodhvPZxE92BHHYtb8bO9KlZBvtjQng7ucvgBIDujzUd8o5wzMiqiszbyB7MYOe/Dp4Q7ABJNGGle3GcuPvZA5AKbZQXnU7gBH+AGrvRCV8EW6n3QxpnkSE13zoMKWwLkkUc5d2+pX8l3rcax5LlfiODOy53CpWEzYckVUDj3ktHmflc/d0dZd5QGU305R8yJkqvsco3lVpXbqG3x0L1w0KgdTHliLMR94o/sKdNBNWg9vZHRx/Zf3NRZX0c6qs2d2ZTUjBmiUtNAen3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5sTyB87DIngWqTtt/S79TI0uRQjXWSaykod2x2cHlGbIb7SN+lbCi6tffwb9?=
 =?us-ascii?Q?AGqtpVye6sMTn/Vk762QjbRxaWiDwZUI8pa3ntCkT4IScJ8P/w8IfcB1bDK8?=
 =?us-ascii?Q?vH6LpFerUXseSYzmxEZMEhHYsHQULZarNjz8kM0ATnJJszi+0na1jjKECxec?=
 =?us-ascii?Q?fbDZar9k78fSo43FXzyq0u8DzqFGyrP8wRQN82ltgC2S5uzJLI4aywb+niGU?=
 =?us-ascii?Q?Os0RvxVTlNFT5fAYhsFXonscgZbaQg1UCHjkXj/jgeAGK7BpNhsfI8NMcKUz?=
 =?us-ascii?Q?xseFHETZt2C/1OGOab9x9ptSZB9cU/OxUV8FaPXP1qljIaJJIfI274d7Pxu2?=
 =?us-ascii?Q?HfS9cfiuq3B7uSyRQ+kHl73KnofgG89fosfnyGQt/tHAJan4MYOWmFd1hFYp?=
 =?us-ascii?Q?LuE6sHFxRaV+xDq6+RIrg+U2gDGHNefdqhfc3afD5pSiwmWoMJeHN2f2cbS9?=
 =?us-ascii?Q?7lW1KUTEFdhDPm3fIHanKNBHS2zPS0yBogpfn2KjeanqfiR+J41JymZ5XOPH?=
 =?us-ascii?Q?CCLUR0FAB17P2g8RQmE0O5wwD6dlGQxZDsRYvJrtiHmMG5CGVGu1CQ59HHQz?=
 =?us-ascii?Q?SkggZM4tqxOlY2GZdX7zy3xj0qX//zR3G6aO2K1pW9DtTpygzwnKg+9JPtGF?=
 =?us-ascii?Q?2X4MjbmkedhTutx0pChUMW6wZ0Awj8eYbi+n7sDqNm7hBkxpZ5O40sjZKrgg?=
 =?us-ascii?Q?RhvNopkPHayTx98Ck4adawSWuQzob3KD3UMNk90FS1NtA8BMF7FvqmyvBfPp?=
 =?us-ascii?Q?C97To2Hil3IYCmqEV4ZdQWZOUXykS+VwaQR4kgykcYQbAhOUY2b6j6OlprX3?=
 =?us-ascii?Q?0013y1qByVG7y17LletQW2dvbSk51whup5p5uQXimuK/A1MGeuk/DWVKR1Qc?=
 =?us-ascii?Q?rFROkmZdEpnRAbGl6EcKqZ1HV72kzQ+IlT7f7UY84jtXR6fc4UpLdkN51LJn?=
 =?us-ascii?Q?jqco7/6My06U/dpy7MUh336FMRYYhOsj9QWfcSJWRJz96s+1sBXx6t4Y8BzW?=
 =?us-ascii?Q?8AaeAplZjOEYG3qn2Ug8G4pR7S1Rl+IFiwNpNtg7vXh0vT44v80eDdSJbNNH?=
 =?us-ascii?Q?YToRGN51opYMyyDkakd78HLgb+8ssf7kxEYofoEF16rrqV5+fcJIm44ZYp3o?=
 =?us-ascii?Q?niBOX+BATWkcZtdqDPMer2k55AusHgO/FUHYoMMCjl2qgAAwne2Eoql9bx5o?=
 =?us-ascii?Q?waSCq8cnOE2u3LcKvVFXbgVOht6i7GevB6CMDTgW3vyqhPqjw0QoJHvdTJ7x?=
 =?us-ascii?Q?mZ3faigurqoWl76GJDZFxesdE/lPWu+Zs1Lh1K9YsicVK1B44FWywmqsbPrX?=
 =?us-ascii?Q?1q7ZiwKlkffYozaQquZBibGg1ntlHlF424J75j3nf3H3HR7fNb3BQQyi9Zfh?=
 =?us-ascii?Q?yyKOduSFlkq+sh3alpKXhYqSvyrevZlkUd59O6/7o43dVEUKGyUaJkHu7XzS?=
 =?us-ascii?Q?/2ayMdXlk/lO0cQ6tkGn7r3taNERnHvL0Dm+5VwZpWHNBuN938Pzeusqv6Qc?=
 =?us-ascii?Q?2SYIFlBDOyWYlY0BxXjkUN4MyrxgH2Sw5QHSiSYSC1NWt0eLxq9QzhDZT8cT?=
 =?us-ascii?Q?jKZS2QbXDSSjRJjJVTBb9fkCIrckjmn+grZMR8CzvJImnf2CWpKzdIW2uXBJ?=
 =?us-ascii?Q?dOxf87+awHu3OpDUIAyE0/TldSEi/8YVyZn8HKNh08NjaNhrN5tVEAS98g2B?=
 =?us-ascii?Q?bi0eT/UmX0LakSM0rreDIS83teOv+fcybJvs9h5y9QALj0Ry3svRKaNLxOow?=
 =?us-ascii?Q?NYCU9GKAhf3/nvhs98Q00EMJ+V5l1Y8=3D?=
X-Exchange-RoutingPolicyChecked: MW4mL98xAXrU34Ai9WSRGId8jxYVXyzmDl0gI4i9aU+La4T2Sr1R4dzeTB0IbvuoeUxELxu2AFZyu33pdC/bWQvgzl8id6zQvVmNO4lBFY1+AtOG3xFevjvSwnawh8W/MygBWmevcr8eo9zr4UxHmIM3JsYptDUH35Efa5cnLqd2vKH9CE/khyi2yZPUUaO5pCxS6AueGDbIKj7rteBP5mXcwSTM+08p4xFNFI2GK3suVz67x+SjiD13s5MNEX90SBI/Pj/mKQH1CCAflNt6GiDTiY01VqrdLduZM66mZbkzDfqAAIyqyyTYq/y9lk1TWDqzOF98itkztxWwRPaSOw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b870f110-e069-4eb9-f63a-08dee106d1f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:47:34.3653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE3NHQDdCCznd5du6uVh4Eig1f3h3C7aBGEQ2Ug2lKwhb1iCT9sXqxYi+ZlJXtGgV3j7nVfaXq7FXp5m2A1lcGyJYA3ESWgIRE1MKaXHCzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR03MB989243
X-Proofpoint-ORIG-GUID: G4pS7_hk1fTZdrbADmcyy3ZxdK4LDWsk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NCBTYWx0ZWRfXwQk6E0EN9QmL
 mQIO+olZn7jD4EaVafl+P1z/TWsl5qcni0LgIAu3dbHndZhoBpnZgzneeG3Ch2af4+cQIJ1d1Z6
 YoAKc/KAxOZVpKUfCubsO+fy/5S/q6Gm7jXaA9cVAe2JItq6HaKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NCBTYWx0ZWRfX2qD54FRkK6Vp
 i68a+VlZEStgtOysQnoUjM3UZ5uo782veTL5U1pXsyhgghIs/jb1+JsB0CSxHFmO6aUZStymR9z
 L7TD8kLIcjPbLm5rT27q0VnXwDFvM2R5TKwghN4RnHV7DUpogarr7EpeeUYU5dTcYL1/IOFGxfO
 LH2ksyLUyH2xzBTjTWeqYvnih10ULZ1SLNXKHtZxBGXEgWE/24OqAnPwXoSHUeMS0mlLBDJKAn5
 an1aOOtXR7kgOB7wYkE6f7VPz7TKF9+RuuaU1doB45+BKJdJFxjeIqT5a/eeycZV5RdVIUlZEsK
 H2BD4nYgR2BIrS5YoCeLQIidEtXlQX29Rj88pkJAL20ROYW7GBVi8wjxJxhXCnsuX7nW/7BDJyv
 TnVkV3JrptgWwn8mn8RfecFzdIBnSwfq3qCeMIi2TvSwL4Z6EK06KhHaNP+hmCBuGitA3PXV7ss
 P4B7z4B+wCSK3aZ+Jrg==
X-Authority-Analysis: v=2.4 cv=AMUiSR+a c=1 sm=1 tr=0 ts=6a5524b9 cx=c_pps
 a=XJaUxuKKdFC3a9vqRM80qw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22 a=gAnH3GRIAAAA:8
 a=--Iop-btRuD07nOOeDIA:9
X-Proofpoint-GUID: G4pS7_hk1fTZdrbADmcyy3ZxdK4LDWsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130184
X-Mailman-Approved-At: Mon, 13 Jul 2026 21:59:56 +0200
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

The eMMC and SD card on the sc598 share pins, so they cannot both be
active at the same time.

Previously, this was managed with a patch applied by the relevant build
system. This patch replaces the build system patch with dt overlays
which will create two separate device trees, one for eMMC and one for
the SD card, which can then be selected by the build system.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/Makefile             |  5 +++++
 arch/arm/dts/sc598-som-emmc.dtso  | 27 +++++++++++++++++++++++++
 arch/arm/dts/sc598-som-ezlite.dts | 18 +++++++++++++++++
 arch/arm/dts/sc598-som-revD.dtsi  | 16 ---------------
 arch/arm/dts/sc598-som-revE.dtsi  | 14 -------------
 arch/arm/dts/sc598-som-sd.dtso    | 33 +++++++++++++++++++++++++++++++
 board/adi/sc598-som-ezkit/Kconfig |  2 +-
 7 files changed, 84 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/dts/sc598-som-emmc.dtso
 create mode 100644 arch/arm/dts/sc598-som-sd.dtso

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 25234697e6a..fb8a91f324f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1156,6 +1156,11 @@ dtb-$(CONFIG_TARGET_SC594_SOM_EZKIT) += sc594-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC594_SOM_EZLITE) += sc594-som-ezlite.dtb
 dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC598_SOM_EZLITE) += sc598-som-ezlite.dtb
+dtb-$(CONFIG_TARGET_SC598_SOM_EZKIT) += sc598-som-emmc.dtbo sc598-som-sd.dtbo \
+					sc598-som-ezkit-emmc.dtb sc598-som-ezkit-sd.dtb
+
+sc598-som-ezkit-emmc-dtbs := sc598-som-ezkit.dtb sc598-som-emmc.dtbo
+sc598-som-ezkit-sd-dtbs   := sc598-som-ezkit.dtb sc598-som-sd.dtbo
 
 ifneq ($(CONFIG_TARGET_IMX8MP_RSB3720A1_4G)$(CONFIG_TARGET_IMX8MP_RSB3720A1_6G),)
 dtb-y += imx8mp-rsb3720-a1.dtb
diff --git a/arch/arm/dts/sc598-som-emmc.dtso b/arch/arm/dts/sc598-som-emmc.dtso
new file mode 100644
index 00000000000..67007e1efb2
--- /dev/null
+++ b/arch/arm/dts/sc598-som-emmc.dtso
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2026 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
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
diff --git a/arch/arm/dts/sc598-som-sd.dtso b/arch/arm/dts/sc598-som-sd.dtso
new file mode 100644
index 00000000000..afe9181474b
--- /dev/null
+++ b/arch/arm/dts/sc598-som-sd.dtso
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2026 - Analog Devices, Inc.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
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
diff --git a/board/adi/sc598-som-ezkit/Kconfig b/board/adi/sc598-som-ezkit/Kconfig
index 9abecbe1dde..e8298b1a7ab 100644
--- a/board/adi/sc598-som-ezkit/Kconfig
+++ b/board/adi/sc598-som-ezkit/Kconfig
@@ -14,7 +14,7 @@ config SYS_CONFIG_NAME
 	default "sc598-som"
 
 config DEFAULT_DEVICE_TREE
-	default "sc598-som-ezkit"
+	default "sc598-som-ezkit-emmc"
 
 config ADI_IMAGE
 	default "minimal"
-- 
2.43.0

