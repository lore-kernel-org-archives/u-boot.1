Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EAAC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A9984DC4;
	Fri, 17 Jul 2026 00:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="sC0+KvwE";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="OdEW+X5T";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="GMQmSAx/";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="K+IrCxCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B5084DB5; Fri, 17 Jul 2026 00:34:23 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7630184DB7
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GK9NJS3192061
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=hVB
 ds9m8Aww8YG3v+x+zc3VB8d/fIDdB2mCuY7Y6ECU=; b=sC0+KvwEAzIYbW7Wb/I
 hpp3HX8GJYLn8RxZ9TbKDW75k13qhdJ93+AK+dSSt3pP1xfDBEPrwjV2svQsecBx
 RSxBmaxR40/hiP2e8IyHyiEXuZFLJTDHxK2X/wbbL2XCYtSqbJloXKpjhSuqttPN
 Z4ncwuTgAJOzdh29gFHbqnm3nD2jPY1Vj7aLz6pAlX6RAcTp88W4TBEam0q8k7Mo
 URKu1vAJbxXQ7U4FkQ9qPFjxRU46Pw/jnMkW9cq0y3KiOVyAn6NOpkplMYF7US21
 +5wdt7ReiQ2lSLA0+ewGu/n+DNOlbk8HETCHEUSvYLhl1jZp0/2amPPqbgkfgUj6
 3qw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ff4yp9vhb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:34:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXwUWB6AeWXwoKEeKbkz7loaHhf1YSFtvmZTwJk8R5H078P0iH/uns+wPboiheWZ2PbmlFCuRUsUZyx/pgLLMYMZBO1TYEzXyPcMMPT1gBDgEs8mnn67yjXUYIYG6dwl423vVXq+jh3WcxqNS04ex/IOu9AF0gq9gQH2pZBAHSavfzKnOEswwrEBbAhx3UiBWSQgihYog4Lphl63l7D9tQH2vo1V/DjEZKH+QMot/NaNL5y7Uh5YJdJ4lehQvx4NzzjSHMuUdt3PHKl2l2Y7nCQGaxTYdXhxr+CnyDyrof11Redfc82R0PqEuBEb/WgmiI6tWMn5uqzXECWCKjvECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVBds9m8Aww8YG3v+x+zc3VB8d/fIDdB2mCuY7Y6ECU=;
 b=SJtnThKvPQMFhxXQQjpzQ4esN2WxFXvJLAThQ/m3xxzrjFrTWrRwPyXvPu087uvV18DkhtSohUY6p0M/ZcnVIsQx1iVroQRwkytBe3SNiU9+CqOvMLflTkmFIHAKT/9EKx5hyuFOPKyqnVsSUiS4KubZGWq9wmqlc2xKhUECLUiYN4dcLo1xNTeJNJ46g5Up0vyRMHSqH1RUn8xUZRkOdTlpOHsp7l/i65t/XONtbKIUZWbQrBvsvW+jrG4b3sSrEiayIF2pJdUuXLXrSmQ3R4tT3YcEzLmJMtSuOpKuWIoQsEZv8kfN8IsjJhhuR/5luBiXp0sf+uKGatYTXT/HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVBds9m8Aww8YG3v+x+zc3VB8d/fIDdB2mCuY7Y6ECU=;
 b=OdEW+X5Tdzb23l415C5Dq3/qiB3oMGKF46T3P+W+t/drhjK1vob5k2OmEPGW2LlV07N5Fw3uCiWoeosE6cC3sqxteFNDn8FP6ojZGtk0SNUN5bqGam00+3P1s6cbfbsF7e+az40atTPBOLFcm5nc5CISuJS+lM0xhdb2bSPrnYQ=
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by CH3PR16MB5280.namprd16.prod.outlook.com (2603:10b6:610:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:34:14 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::b) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 22:34:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:13 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwLor2637082
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=hVBds9m8Aww8YG3v+x+zc3VB8d/fIDdB2mCuY7Y6ECU=; b=
 GMQmSAx/mezA/AkC5mZkXeHBUCLoC4MrQBs162vJxfm8Roflt9SqaJ4R/CFEE7I9
 mhg86GWtS4OO1WQr9suUGxik42SmZme1VAlw2tmPnNoszV8ExNQK9opnLYSaczCY
 T4H0X6gIwvnFtjjMWRZVaW8KykCAvGfgk/DKmfGKL9tdmo55IylSEnGh5FsCqKKf
 vD5XSRIgu/VKuNGpb2AyOtHr77TFoiel5aUMvMtRwa48X283MYwj+2mc1s+9G0sj
 16GbP2/ggNS8rnVFnlMJaSzIWQpk0GMuiIfH3eki/qcyA/dfrdgqGWQQxJTNwbCf
 ASpTMwOa+v9vg/XxONBqQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=hVBds9m
 8Aww8YG3v+x+zc3VB8d/fIDdB2mCuY7Y6ECU=; b=K+IrCxCOp6QNj1CDCbWHm+o
 qp2WJmeE2cTtyDqCoKNuZFLRTlik9vOPhdsFtSFndveMbLe99E6D5sPUhCPoveiu
 n0G1D99VUWQ2MJgPB2RwcxMThS9FEp04LL8nF+YE1UepG36NlJtJvYYt6r/gc6xj
 oGbPbaDBotONWYtN9vC7Te1T6q3bWCb0BMAqfFvjxaU067EoDDrrrqVQ0VBYf8oK
 bJVNjNNPwAyGxvEG2vH74CM+xTLx38U0cbC3i67eGN3ffEMD2vrxZULzdf7eN3wM
 d751NgQEXdIcnS4JViWwduJcNyeOcLxJlbkhPRT64UNst71omjRUkcTF4EpYvlg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fe3euacue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:13 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id kUehwnoc51FglkUeiwFkkQ; Thu, 16 Jul 2026 22:34:13 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUehwnoc51FglkUeiwFkkQ
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 3/7] drivers: nvme: Implement flush command
Date: Thu, 16 Jul 2026 15:33:57 -0700
Message-ID: <20260716223401.378989-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CH3PR16MB5280:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9647813d-8b92-49f0-279f-08dee38a5d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: xkuxDmgr65oEnhKc2T4P0KbcXjtqODiLmpuxtI/fTSxfR28PXxTmfMqmMIY5YqjNRR9ioISfjJwt1k9wyzzEhorvU/lnjqgvQxCFv82AI6U8r0Qk5XS4n0BT9aYWNe2AJ9JMGPzhDw1TGrPWy91KfNPbx1JXASX+ljmrdJj1QNC9kIkjIrdfbDoOhFy3lEp7Br4GCHjic150iBBUsV2CZsB4Rmv/SJH5VecjaLk5kBL88+nU8jcEz8Y9GrLFwLtIRd+Oa2Noo726e4AaMvXwIqWd5T028A7K+nlYRAVsGuSBVdHxjfvX8JF3/iMKpi/4Z9CqbzbxuYNw4Y0PiTUC2Bko6xClI97TvgSSk7UarDSY98z5JZRwx4bqjNE7WA71ftrgHJ0NezFEdSdPnd1K6OL68Wq1f56tatHwRxl6r2hTMIwu9I5ITD3idQfrpWjpQWSxf1o6sVSrnVR9JJKvPm0mK+eWhwwOldozXFIWIpiYlDjco359wGqdOhmJR2zDMJ2p3RjC8YQEGdM2m0m1isS+QK4HS7FHNVk1asuwQ/eaRKrtXOOwbWdabFHWr6Gf0eJInZ4r3HKzNBcqDwB4sQ4J61uCF2v1vqtuU8QCsCs0apdEmW+uk1eH2mY8lafqmWLpVAJa8742FNWI/xteE85dcBEgT2VUqri+gkahIc/bKu9aupS8GkiThwXsT7OKbl3BUz4DlDJa/8aNQ/snlQ==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZKWlIXSrd7Lg9+gB9CQSDguRoYB4cs5HotWlTtxpf1HAFc+BhnkJ5Jt/U9fDmScCiV5pkmrpzpIXu/s1/CE3v/wMrCqLJpSPrSq42yDoKkgivm9P6LzlgD5sBWovGJwMDUSYJmbiF2AAha5SXypQ3w/KAdqsQiangjmrXJdk0DqyXeEFtHQmRF00VR2JgzpGhUuUDJv3jLptDT3tqRDDqGD7U6O2NJ2iUTAKp8ku5zBe+68ywAiRJH9XEv042gXqAePNLaj3s6ZVqTquaGlt46DbzfFqsb6XXJ1S1AziGCda32X6/4lF9vtN8+ruPv7We+AkqCC2K6Rqru7wH+4WFEFGvCwxlj8TtXVQ/3VSAQjF6sTaB/zV6v3TTrK5ZAjn9THhM2KupRA3+9Peeoz21XApPNGgMaGttTcbRnxllKzUNXIBI6YVEASOVEnY1oXh
X-Exchange-RoutingPolicyChecked: i0gRRTzyOyTirP+7TL+W32RMsWRjN6FCsuZUkBwVnoamNyhc9pGbat91xxW74SpQn0/UUbvbSNe9qTes7qd++codAqJb3ASuW9wMYrw4/AIZh1zxd/nxFRN3Mwj34bkEdBl/QZuWIsO0KuM4g0l/SbBOWf6zm6mcRUQD0OK6l+/8rF+x51F8j+kqOVZ6JWpuRNABUuWqtbom6kRg1a+mFmmSSyCywGJflhaNIFN3JhgvEu1/sxKXUtqDHPFDYmBa334wrX8xKOXWuaMSPRPXh/SDItJOus+G0K5Z0IEEEnJNmsEkGohuAnhDveQiWaMtaaYZUz/nOwKvwiO6y8DLDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 23fIKBCdoU3Vzv47eyF5opg/TJH2I+NWoRUCkANXj7+a6jOEKGhrE+2x5cMW6fjYXihYdsZl6CRRwlLKo/FZ9XkuMgYwa6uEPgOdRx/WAvR4a1Bu3RMT0//tLhgpgZ3P7TlquIoHbQhaq7sUTosjqrTB4oa4rOQ4+k7b4GPitPixJB10kkRJaBmk4McNtu14nDd+xbqQZv5xytnrlW/gfZ3oi9jYxZnmh6Md8XnlEKrEykNWoPM1eqEyye7bx/hDzKFly+iwXCA4PaXZ+Oo/gK2NOe8hHUJg/bjFqW2dGaQs7fDbLLxYmg97Y835kEGOBJYrPXZWEji0pEicw5gZqYGQoBbWjPer6wtikxfi7/wnA/ORgcPI1WHQxe4tsk+zsBOWpYWn/2JsSDVGISw7hZ2GJF1oBkr3alLrjQGt6A/4FnnXd9JsRgYhvloRoQG95MdDYsbHxftazLZqll6aopAOxmc5t5nOb7ucRmM4u+e4zWV5YHuzupMzlKSyek4ujhROiPCyYE98/maXDHBZiWvrBc9PL6UlIpA3BjJ451SE6dyc3cT60I38pAVm4KEP8CPvWuStT5FCGd32j6mQCjbK4GZdkEY1Aq23Zc2DYfEW5eMpHoSm52MYV8xr+MwDTZmU0Udy5ag/Nr6Viyn9Qw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:13.8410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9647813d-8b92-49f0-279f-08dee38a5d0e
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5280
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX2kVmWW47FGyd
 4kl6gC+105o+oWmDwEYSPdxH/KLGCvGuxTPs+M0Y2O8wSobauxXN1kj0mbtR45YuNwkBmShNAG8
 RxBy2HaRFqM0/Zt6gMqBxMszm5ULGwnbC16evVkbjYk0+WTLhlf+
X-Authority-Analysis: v=2.4 cv=f+F4wuyM c=1 sm=1 tr=0 ts=6a595c6a cx=c_pps
 a=MDD208LlbW4bdEb8q+7A1g==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=clwLE12zPSX0YIA7b0MA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: 1vnBkNKg7xPDRUInfRxveTKPNrsdtXuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX7Klg2sxtyMak
 Zg1hoLZOLtYI244y+YxybuYUFB0giffCWvdAL3svxKpiNYcSkvx1K3+S43iPqeaEGWkY5gaKo1B
 Krq8UbN2Qb1GLUrF7LsG9d5HNiFGztxAJ3CgDUwJ7M5I7X7nmBVCmdfpyTiTMJgBxHLHgMO/zBS
 0IOg0vSQAfAIdxo79gL1dCiw/CyyNfApNHJDGgLFU1+6zOiJ81sSRrLSW/ENYv8Qe8LVwE1C64s
 K81BvydX7g7+03v7KffNv7OJ0ZtVWP0EB4D8jgUS4v9PuZT4mSn6XlV2QzxYZGXan+YK7I+IClx
 5zovQfXispYZp6NkiBm+0fE0SA72MCEc7ItLBNd/KhGVGsGEKjHYv5tOlCyZ0PYTn7ptK/EGd33
 V3SvwtHlv6r5e2oQLBPcz9Eg56FNoJ5ciVrbcSU+fptdEsXHfATYeeJLcDVCHMFgQAbqn0L0llo
 JiK2KJ4D6J4O6VrnkvQ==
X-Proofpoint-ORIG-GUID: 1vnBkNKg7xPDRUInfRxveTKPNrsdtXuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160229
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

Implement the NVM flush command (opcode 0x00) to allow callers to
synchronize any buffered data with the backing NVMe storage.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- gate flush by VWC check

Changes since v1:
- moved generic disk_blk_flush() to a separate patch
---
 drivers/nvme/nvme.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 7bb6bb7b53f3..869e906396ae 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -821,9 +821,34 @@ static ulong nvme_blk_write(struct udevice *udev, lbaint_t blknr,
 	return nvme_blk_rw(udev, blknr, blkcnt, (void *)buffer, false);
 }
 
+/*
+ * NVM Flush command (opcode 0x00).
+ *
+ * Applies to a single namespace; the controller must commit all dirty
+ * data for that namespace to storage before completing the command.
+ */
+static ulong nvme_blk_flush(struct udevice *udev)
+{
+	struct nvme_ns *ns = dev_get_priv(udev);
+	struct nvme_dev *dev = ns->dev;
+
+	if (dev->flags & NVME_VWC_ENABLED) {
+		struct nvme_command c;
+
+		memset(&c, 0, sizeof(c));
+		c.common.opcode = nvme_cmd_flush;
+		c.common.nsid = cpu_to_le32(ns->ns_id);
+
+		return nvme_submit_sync_cmd(dev->queues[NVME_IO_Q], &c, NULL, IO_TIMEOUT);
+	}
+
+	return 0;
+}
+
 static const struct blk_ops nvme_blk_ops = {
 	.read	= nvme_blk_read,
 	.write	= nvme_blk_write,
+	.flush	= nvme_blk_flush,
 };
 
 U_BOOT_DRIVER(nvme_blk) = {
-- 
2.54.0

