Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B1C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A1384A67;
	Wed,  8 Jul 2026 14:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="HuHioAz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCEC84994; Wed,  8 Jul 2026 03:13:32 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E03F838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3r7aHP26MAWqXrwCSaQNO/hE/ihfOjTAUz8Qq0xUCa8SnkGDVGtjqYstCJsrFg0PvEruSrUheU/l5ZeCngsN5TiP6vSHD7gVksrVnfgC8KacHSg5M0IhqCv9YChEU9Ag0da/jFxo3e7WSVla6m2NLgiVvMsMFl+w7azTdLzTNpzJpgWg3Jy+GaGX1FoeSKkJwyNeGdxTkxs8IVoZVcmeVMoT+jIVkYUmB7IB7/0ocbi1S+Pieb+ouV844Nc90UfHKwl5aG8Ws6MPIzzvPi4nATiPXF1+sYGWhGrjDEmTJLP9OpqJYRsQzgmhzDwa1TNRgI+IVOtiTkuxqn1jBsUnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N4KBgfmD1LlmypcSG0tkZ0MUg+aB2IcFtaybYmsOq0=;
 b=FblK98wjzhmv23YKhbl37TXxjMP4a1E509UfBu7FfT+qj60g53SATwC8MxxEWsxEJFkWWmLiLHCrtdNYlf5yKXJwpBpIw9b9pzPuCvzy/a7EUAOmEA0uNuRu698xYG6N9XbAPC0bTiuUOs0nD/ZHQaBLoh+hCkRJN9iyfmkGGKv6VLcWhIn+gIOkA/UrxaoWRa3itKEvtT6tNcrWziqPptr416zfgflyNKeQMoXJhK3/ZX2jR4O37ofx8wb8MunG5+zzMxPcdcttaxjN6Kuz/0vcsayJvAXxli1nIGjIO8lSC4w7ENc2C5zF+1Gn4JQBLrntBd72YurhN1UUF82x2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N4KBgfmD1LlmypcSG0tkZ0MUg+aB2IcFtaybYmsOq0=;
 b=HuHioAz5OR4lzX9VtO1wUBVWMT2+j8X3K7nrcaewIaBndUM4Nm7v/JXsbZtA3kWZ7bbRiRidz7jdxEcPyk2LIFjGBp607/Ck4jjNiA/NbajLpKLwSwuwBAp2EJ7FWkilxo3ik6ONflsj84sgXMQrcdWlRRs0CL+L7u0C7CE3qhL+vZkxdifieYM8DLoj5JDt8kxtdwM11c0UK3kH+1vz0m/fAdobyWQASjjioK3slZknDrGLl38nggw9LSpuxY6LBbMtyRdSMPw+i3UAV4eiGNK0GhdNJigsN1Zdk3c+Fa1SqanmJYvl6HXkQ8lvFfLUQA+jJENy90IZsW7YZOSfAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW4PR03MB6473.namprd03.prod.outlook.com (2603:10b6:303:120::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 01:13:27 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 01:13:27 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 09/15] ddr: altera: n5x: return error on invalid DDR
 controller type
Date: Wed,  8 Jul 2026 09:12:22 +0800
Message-ID: <20260708011228.15613-10-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260708011228.15613-1-chen.huei.lok@altera.com>
References: <20260708011228.15613-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW4PR03MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 2904ecb8-7061-4fa1-52a8-08dedc8e1d66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|11063799006|55112099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: +4g8xb0sMFCgFkMqFXEE+2C6T9QV+QnexHxs2CMiflSQxkKDdfRrjI48pwG6a+ZB5onj3TO1SeBqitjHYSCQOkIkcwb46/0GHRpxOHAq7qD3Lqd3x/i/G9bZWYEKgdSfTVWwFmhZUyWlhnOKjct9RKr13iM0Mrc2u1vu6cZp0VD9y4DNQgXvOrIrzGyi5kjUglBFqVwu1wedbaSttKRrcB8dinTeIpj6oqLyFL7ymjQD078HzyDGQa9861H9MJufWQ59g9nhe6TYo1bpTlQ8wCEGKB/sWOJc104/hU5Q3gDDTXTQG0gdcxTOkZbfhGzcrQWvUUP1FcWqB9kcMa8PEyQ6KdL7l8j2fSLHVd28idBI3br90Lo9mb9Jbb4MAw6me+lOY7n7QVo7+Cz+/N+BCACaMmjPRnt9HRgcrEWTCM+7ijU3mhU+jSGokuTHhmw8BeMLSbleua4Wo73ZIgAJsw3kYWL5OxDlsPdRT33lsnTUt5KhwuT+K/oYS0ygaQwz7d/ADPYCKNbV/sDnmYCHFJsgOGwQnixnFqK2B43F9Ul7ukangXwT7XywSnkfJZDOFwAVuj+rlILBthT7dipurnsuJPqVmuV3KF/nbZW9YPFu4i5XTLPbuoyrBqk2Y2GGSdJw00avttU6PvvnE0r4wfyObx5xHYvUJ8SdesNCagI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(11063799006)(55112099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?29RvIWT72Q3st1JZyHwwut7tyCegxco+Ubri6UOp/A4Q9DJx+56Q0TJ0GkHt?=
 =?us-ascii?Q?Z3V4dOqBgXyXXeZ/KqLzijKj+jMOmNCXwFYePSt7Y6SfrRw6dATdaKQIL7vJ?=
 =?us-ascii?Q?axnSGHG0RWvwBpNFlYdi3jzTAvHP5ya3xf7c7OfN5pe9SlV/6tkRYHnDliX/?=
 =?us-ascii?Q?u6wfrxAS4lhSPN08Nw/jQqSs1C/sour0igyY/6IOPxGl203MQ6D3DMS70IPG?=
 =?us-ascii?Q?vxsmXY2ahR9ZJmsXq3zikNuC+k9bckkTF9jALQNzA/o92zX6GAWfl36JpjUd?=
 =?us-ascii?Q?xU503gTriGh7NTxK5OcPrnwl16tN68Z7Yj0mvfZoyWk0Znd5xoPkY63j/JR9?=
 =?us-ascii?Q?Lw71JbmVfnWEa7LTMvDsklwMFsfkDcJrtmcRztwwbeL6WEoixHw0iC+CMlPl?=
 =?us-ascii?Q?Ism5vlBk5c9E1w4J0bOCaF7gm7n/p3M6O0OT30N+FTGbgYKnBnxjNNjcgoyY?=
 =?us-ascii?Q?Lc/ImWNwfRh8v0MedaOYOCHqF+2aA5UjIzEh/R5ELVtoyRD9G6GEUuOY2+Oa?=
 =?us-ascii?Q?qZFrzjTfL2SKv5jx2fNMn+IdgxrQ6X6kuLmjK4iDluvrIaMhwsGT3i7rwaTL?=
 =?us-ascii?Q?0l4zxP+klYctVuEXRFE3t4XsIiFnfWMFw1qEnrNpuqKiny+QGxXxJRHf4rFN?=
 =?us-ascii?Q?GdqDlvYrp4FRCOF2D2rG2Q8AwDvLdyI43K0Lv4ZD54nAxtGm8Cl4Xt5XZgV9?=
 =?us-ascii?Q?dtKCFKh/wUN40DXe61HDaA77j0WBr8m/+ruAhG55mRYa/ybfDe+ikFpQQZxp?=
 =?us-ascii?Q?R3NfVpwfY4rma2zXKZ8QISJ/RorVjdAfat4HkHjqa+j1XsE/7GD3hZWMq/mb?=
 =?us-ascii?Q?/3PFCV8++pqbfTP7zkxGX6qli92qpshUZfgG0SpRzuW+3qcsuEi3xkMHEfpQ?=
 =?us-ascii?Q?i0k87OKt8Hn0rXuCNZYcLl+eEASDhOlwLivYmrwPeWqOOXEffxS0RjKw7WN0?=
 =?us-ascii?Q?Ci/J0DwqFO8/cV4Sq4kjbcWtVOTo2sDQ8VSYn5xeNyFWqp1YIEW04uzIn/1B?=
 =?us-ascii?Q?kz0F+jS3nQkge2WX91s/7ybYn5D8Fg3s1x9Xl5vjiFnuBM4qfKFHJ2CL9huZ?=
 =?us-ascii?Q?9PUMgNW6CUX+oBfSrNlQASqp2/TKAgDGrkTP0jarEGpzwcnlUjQdREpcAbjf?=
 =?us-ascii?Q?N5LiDMV/7fAB0IzDWesdg0MYR1XxHRucaBWW3dKT/j28W1w2mrrVsrzww9mE?=
 =?us-ascii?Q?CkMel+LAq3XZ5GvOpBGhOz++QPIB3biJyYknIWSU4/lau4fC3tM4ZM9LcFg+?=
 =?us-ascii?Q?lTmSkFHNoMXcxZ4U/nFJqQ3AuvSd6Krh3NWwH+IQOnzGq1tQu1saCwbt/E9J?=
 =?us-ascii?Q?XU2hyPJQ2NWtY5IlHM12Ug+RRoe9t67SnVJDhwvZEM6/85KI4AdEWFcvR7L+?=
 =?us-ascii?Q?ZGASktDr/HUnu9mxWIk/D4p3UOzH4rnIF7aW9W4vu8/FvpAX63wObkSvglRz?=
 =?us-ascii?Q?m7EM36RtwlVJ6buE7/YfGXyHKxKL7rX73rzG1cCRuTuS0tR+7Glp+ymtCH9S?=
 =?us-ascii?Q?9YMfBPAK+pm/K/05y9ebJSYh/tZb39dUt5wi6Ks7j4yvrHJ6XELDiyhTkJCL?=
 =?us-ascii?Q?K2nc83SP0SH0CNkB9o0/PtLbK9K5WiVih5U/jxRjzl0lQQ5U/AkjcY9uLQ80?=
 =?us-ascii?Q?4yjJyVjKXmWdgEOxtFPBzK9y82+wuTvae5R8hbBmii+1fekEwRf3cE8Ge7eB?=
 =?us-ascii?Q?80RucTkl0dsW4Dia1WtMptMMg76x3g3HVqWS9XKdxEXM9UwNgt6qo5a0WD2/?=
 =?us-ascii?Q?gMrLnNH1XeQzYIgyanXf8yAyAcTIaXQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2904ecb8-7061-4fa1-52a8-08dedc8e1d66
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 01:13:27.3471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbKsiEvmSZr3XgL1ZQm+PMKQumnAjOoMG3ahTI6CoO4/IcqvZZ5l/Ct295DpoRHHLphLqCF/fmTMux5xRVXY/fYOtH13XiDfRSr4lD2Gel4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6473
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Return an error immediately when an invalid DDR controller type is passed
in, so that uninitialised local variables such as val and upd_val are
never used.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 drivers/ddr/altera/sdram_n5x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ddr/altera/sdram_n5x.c b/drivers/ddr/altera/sdram_n5x.c
index 538a0369a39..c101123b14b 100644
--- a/drivers/ddr/altera/sdram_n5x.c
+++ b/drivers/ddr/altera/sdram_n5x.c
@@ -2445,6 +2445,9 @@ static int set_cal_res_to_umctl2(struct ddr_handoff *handoff,
 
 		upd_val = GET_LOWB_DATA(readw((uintptr_t)(handoff->phy_base +
 					DMEM_MB_CDD_CHB_WW_0_1_OFFSET)));
+	} else {
+		debug("%s: Invalid DDR controller type\n", __func__);
+		return -ENXIO;
 	}
 
 	upd_val = max(val, upd_val);
-- 
2.43.7

