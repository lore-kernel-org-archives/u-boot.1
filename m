Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A850CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FFE9846D0;
	Fri, 29 May 2026 05:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="ADYIE8uF";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="hxw1Z9y7";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="Wy8wnH0I";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="o0JvqEC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3325A84874; Fri, 29 May 2026 05:49:01 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D45F847C4
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64SK6fhR1362068
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:48:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=e03
 2JdeoBywzAsnuSy+/H2cwhTpZxZsev1EulK5Pr08=; b=ADYIE8uF8t1mRL9nxo7
 wpgLztsYx5OTKipLTzisTjGYSEXesYOca7ChffMCLoL/irewuDIdLQb27MbAZam6
 k5Rq6QOubZtI1IFD0g24lD13pAhZLzS6NJnz4wU6aSI05DunyUB4/uejs7iRn49Y
 lJj5j4IzbxEwbyItjCkYZQRrxWNfzeX0F/WyXA1j4bKERSTGZawpROnzsDF2/TAU
 Lc3N+u9GRfAHKkMlOc5mJPw3hEfxoVlv2r7n/cPLX5tjtQNsMvtQW5eLZvJc75UT
 xEuOS1bfxAFOmLfE1GsxaQ3xYciZE/Ef3KWiTWYWovKKr6zoekmAV7Blyxhrw1R2
 OrQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by m0482517.ppops.net (PPS) with ESMTPS id 4eevf3jbbg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiReMfyEwSLnlQs+KuBuS68++t3dVHm8w/0Nwmg+PLddh/01FdpnVpl/OSJTNw5KuiLrUMc28F8Wyxq5Gt6xHnFT/vzP4b3z6xYx1rFlF3+9AI3ECDBt1YEZHSJT9Dfl2hDHJCQHw16rU5Pm26MAvwx/8mwQh4L8umTxjfmQVEwDs2vyI6Ta/mIJeBqi6tZaQtv6xkmD/cYoO0pcp/DyrRbL7hyROTNjdz5sNPjQJm8N3v+8aLBEG2TlHl76i/IS4HXkgtDAfiNG5KWWE1ajtckS8AUmGJFJm6fASZJGlFgGDHvG+IY3GcJM6oFuPKqBBEiksZeTi8xBaqGKtDRw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e032JdeoBywzAsnuSy+/H2cwhTpZxZsev1EulK5Pr08=;
 b=wr3+4gskT99rKz5JNOKVkzfxBuZ/XBtOCl0TmBPcsGyYL0hx6Lt5sn7KLmD6qYYrI8nx1nmU3a1jlpNTVs2cPO4jg5D1CoDvCkzV+XHP0dtYk6xHAarfhjLW+6S9vxLpYW4+JDq2lE2w4JehFTCAIQvxPlog4u6uTvmGf4yDBsSs0LGHQYUaCS2/bTTiYILvxGPflzbv1vhMA9u9orYbxio+FZlwDX6pLJeq1sZkHNZDv9ivQyHSqDazSS42tUfiPeAIJ1b5JLNqRg9/246t6qd/WKAiCbmh7LVuEY4B/gKdUbVjS9NoHpAi9tlbWBX9L/NH0s3cfNYCrArsBqoKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e032JdeoBywzAsnuSy+/H2cwhTpZxZsev1EulK5Pr08=;
 b=hxw1Z9y7zWjQaqJ9jL8zLJolJZJ8f+4rz4cYYIZ3iGr88AQ6ApydZv5TbaqVQJLexmvBKvAUIBzvlO4XZawZc5B/O3+OafWHmdgnMbtOn0AjUephlB5erzbLmY9SWyx5W1uiRBQkpEZgsGGtzauxND+FC1Lxk7jCf/vsUsHhUTI=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by CO6PR16MB4242.namprd16.prod.outlook.com (2603:10b6:303:b3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:48:52 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::68) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Fri, 29
 May 2026 03:48:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:52 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T2e62W3752013
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=e032JdeoBywzAsnuSy+/H2cwhTpZxZsev1EulK5Pr08=; b=
 Wy8wnH0IEGdSjsAEQPp8gjAMFK48PEqVwdT7r+eBBWbThHJC1fIewjIu4F2igVeV
 NzjoANyGzHbeqY8u6jnZXn6McjAzfgbaw7OLUasmvB+skV+BZxUEWrcgO9WxTzn3
 oj/xIqfR6kr6bjyl5RqiClnaDUi/dt22M6Ro5YRHp6raBkGkbyO1LRbuW+b+LM6h
 eiEocooEGhy4GurT+YoFwaC7CXvVsjGLP8a8b87dzyqrJd3jQy1TRD9RUr39l4hD
 01iLoQNR2+3e+sOyIC0z5PLKfN8OkRsDAG0X+xpakQtDBVdyuh4GAQ9oqiwjXFwl
 rhWGUr6/4ZFIpI/hqc1ZeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=e032Jde
 oBywzAsnuSy+/H2cwhTpZxZsev1EulK5Pr08=; b=o0JvqEC9AsVdRdBrxvpI6ZO
 dhSCHqkNaaj/W57fDkb/MSs3glSuO//PWZEZvZauwhMPRBdBFdu5GOZ8EFYlnKGZ
 Q15wVtBsDgn2BrVobq56wQPwU26xofdrkbUA45Dxl6gW85XnvrVc0ZkH7nBzbRMf
 Jyf9fcqVLAaf73+fWSKTg8mcyGsi6fwZRPOgQuhSWPdtxoRr7ONcIm6PCiWj42PD
 hzSuA8xWx50nLJL0CTqo7bf9033HrJGuYXtge9XSZBnjYq/0OQ1Yrjhi6ROA5/IX
 rgdeG3oSwFYk/EKKpV8NhyizaKpM9R9Ko1IqPR4BPZ1qyHAv6VjHa4gvciXdhKg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81u0m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:51 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id SoDJw2SXGonD5SoDKwboko; Fri, 29 May 2026 03:48:51 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDJw2SXGonD5SoDKwboko
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 3/6] reset: Print reset type on diagnostic console
Date: Thu, 28 May 2026 20:48:36 -0700
Message-ID: <20260529034839.2075806-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034839.2075806-1-dmukhin@ford.com>
References: <20260529034839.2075806-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CO6PR16MB4242:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 026736f2-b141-4a68-7b24-08debd353337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IgVwzv5eBB11NLrBDLeFKi6rTaSS8/UQTI0vuSwGj0+P71sFs++HXrxRW7nTyo0AccK7eTSOXVDW/KXuUTm9PwnYFUjYaG40SRw0ATy7j2A8bqMrHBzvj0Mv68S5k3SXx0o1kAcRtz84jcCK9hptAwf6hE3y10UEjLhDDOGP20Q229jciU2QgYmBdTwc7Z6gYOq5dMU5AucnjFKrBjiH838OckbNbQSH26WagpaBOQDtnV+JnkW5muOTZ5tdkSIHEfhElvHsiZHmGBaQLQVj3NsbU+kzcMUFtgjg09KggCt3u8no+73bW3sHWfLvyYda67NhNi6jyOdtzAd3duoDaE/PqDgDEXpQFoCjQqFjXuGaBeaSrxFNKTMjyaefF+McF1qPeJJjWm3FOkCkDlf7froAbLv1vYHWKN1lQ+EJqJVnruH0qa3ZLrrwheGbIlmDhGPjSBBCbx+LjXTRR6TbEXAcBkl8WXBxMVE4B8FAfkOLMY2enC1lJTweVuTEAvZhUj7HpkHaS2iZxZiMWtOeb6aaSDjh+bZkVtD0RJ5Npq52V2zwhf4HHF8xjanw1UQ5rZQNQoYSMjmHmf1MGEns/rodlQZb0ZhlWVJQs6N3sLkimjjoICtzW3eSZl8OMdYwj0GepKAbARBxRmWdyIrDAPOaorFXJUfM9m38Pk3ByQNuky2jtzok84l78hKNwPPsWP5Kqd/YqeVxjEGnv7zsbbwgdkk5lA9wVKaeJyuRNaw=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9RKK+oI2qq5mo7xVyzokiD6wH9OPfZDSWmJuB1lYa9kxvvwwCi3Nncw68Ro5s1CIB/AZ5bfO0/JykYeQC2uX2LB7V82ugcEYidYXl34f/E0XTYJqiyInVdJFhRGQUNyjHAZq99uJDbKVKEuINubbOPrx/CMJHSkgkm72Z8DXT9m07bjcBeSnggiWJkXX8zBm6QtcXD+grnm9oTEW8tgcNpG3rZNyT6HVeR/FG/aJ4cpjG/EXR3HEm2AAxaG/qNh9HXxsnby1UvUP902z5/jzDZjAkMzk2FfIe+nqVEIkB4yNIYObxmkoKtcJEAbPIa8WRn/Iy9txc1EmQG63rglHfKoXCNfcQ04kimkR3HFVuZe42OloEzIdokooZNUwLnQy2CLK1xxUFilb9W79xsHCRyNGRKFpvh91XuTSlCdIBbXuXnjUpUV+lYMbqg2whxv+
X-Exchange-RoutingPolicyChecked: UB4XP5EgY89qwMc9LyymyftHgfOhKWAYRP/OlE244uoY3f9Bdro/g3xsb8BVcJKqNpg5EDLr42CaM8bAleeMPraDBRlxHkF/lULrjLUgIcGVvR42DZGf68Xj0/+8JxqOyXYWVXxIesnfaciLggRVckPax0j4YR6cIpC1r8X7SY7FRA6/FV0dAmzqV5zT/INkw+B7EWla2zA/GbO3hD6eroTS5e3Q79YAxxtYcY5tntxMMYJJ02nQeXvJfjrc4ui6nHWu31KAUtdzNo4cxNCA1aSIrfXVv75eOF/o4DUF9KakWAUqY2gFK08+uBZv7nebjcBJlTIGfWKFzngGedqG3w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7XlJ9WvpJURFm4EJbddfXhsx9X/B6ifpygQT0HCwHXU/c4kV9r6pfQr3FQdC407FQJJQ98PlKH67AC2CPuXxf1s+n3Rc4RRcZRoz6MyuT2wHfrpuVYoIDvjBtoW7tUh0MqgZwhiO1WVxHu4GqprQ9SoCqNQwQ3T5SaPx7pgtd5BMCFj4YdbUPsg1tUht2cR1+1m1QjwNHMVZGfdq47YQWlmlZ5TFXcfKjm7NnlYnOxaNiU7Qp8f43dMeuPLA+vyMEHW6IEsclwDYw0dLjR4yjD4A9C7Ign3PDA583Cw7k5z/PaXVUANjHFInWKij9fsFPOdjFm1gWn3vXwpVx0qVZJO2GIE5A6Ao0Il/ySzsl4gvp86oq57ZLRGbOxRlWS/y54m5i4txa3yXFQ/+HV0rXRe92oa+JjwH6m+zDbNx0XiFm1EcKOaoqOyk9g36pX+N+0mCiD4DWhBOVLPZ8iO79/FoRJcH3P8U5V5l+caezpQ9YeBEHNMFscHQKmPmTxIYp+qm27/Em9FQBq5bJDhL121qRlV/piVW7Vsd8f85RCFisAbTZD7rpQsjsLnCdIJggO9hqiJwookOmq2AT0yGgfFa0WWyfXeGVA/CEBwD2/d4l9GJm8zl4XrIuuYdWd+kz/aisQ83YKHB/d07/bAUWw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:52.2901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 026736f2-b141-4a68-7b24-08debd353337
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4242
X-Proofpoint-ORIG-GUID: JD_lCB6ZR0wdcpLlFBZzHAxmsRPGwcLl
X-Proofpoint-GUID: JD_lCB6ZR0wdcpLlFBZzHAxmsRPGwcLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX3nWY37MDchLP
 vR11hY7ZtFbOsqu0m1w/v4dGEOnUQ2/urXI4vR2XJUafrdhevrArHlQRkdfHepzKzHDOuX5wa8k
 pf3Gji5IruAVcPSYJ9nA3co3D6vwnFpylTei80tJ0Ol7xKagtLzRcMasV8/nERX6R7ahyWU+0L+
 rjtgEGcoH15StVNcQ/NLXgtO8xLrIFz8OjHd+sKL2fGNAUUN8iJHXG2nSOkrnhYWOeVPLqXZeU9
 /XfYOtrmpeLUfs3zvy+JAkwIAlqHdATEYW0t1FE0WvMl1Ayw02BDsFfEDRrxsZIR8O9H24ZFRtx
 yansLEOWGB58aPpTBYhwnQVJmIzRAzAQqVsnmzXn3zLiB0VlDQu1R6JMfSu3eIdnMutx8Ep47aC
 zk8srxbnVAN3TzJr+sjlCBDEJdgbp34V/ZTOJuQqGsZCFnonaMBFTpNE26yfe/mt8KxUR5iJIZp
 GLvgLqfo8gPyoWH35rg==
X-Authority-Analysis: v=2.4 cv=Ort/DS/t c=1 sm=1 tr=0 ts=6a190ca8 cx=c_pps
 a=5+b0Cb5m1vs/r/JsbObUdA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=cbNQJ9GKAAAA:8
 a=23Llz5wl3KhMZEueFL0A:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290033
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

From: Denis Mukhin <dmukhin@ford.com> 

Add a diagnostic console trace indicating the reset type.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- n/a

Changes since v1:
- corrected the string representation for SYSRESET_POWER
---
 drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index df68b5c3f9eb..8f49a6093d49 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -22,6 +22,22 @@
 #include <linux/err.h>
 #include <asm/global_data.h>
 
+static const char *get_reset_type_str(enum sysreset_t reset_type)
+{
+	switch (reset_type) {
+	case SYSRESET_WARM:
+		return "warm";
+	case SYSRESET_COLD:
+		return "cold";
+	case SYSRESET_POWER:
+		return "power";
+	case SYSRESET_POWER_OFF:
+		return "power off";
+	default:
+		return "unknown";
+	}
+}
+
 int sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -187,7 +203,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		}
 	}
 
-	printf("resetting ...\n");
+	printf("resetting (%s)...\n", get_reset_type_str(reset_type));
 	mdelay(100);
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-- 
2.54.0

