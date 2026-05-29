Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6608CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8777C846F8;
	Fri, 29 May 2026 05:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="XiTaSMAf";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="XtuRwxaO";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="HxBme+5b";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="aYRKUBTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB13846FA; Fri, 29 May 2026 05:45:07 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D862846F8
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T3Ztpj2887764
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=pQK
 VRyfaW19uoblzzAbuWx2flmn1HqEWJGjg0C3hj3s=; b=XiTaSMAf5sgIw7W+0+t
 d1fUbgVQpcn8vxWvIM8h2CKFZ4OPgRUCw1Xzq2OrzbCmgdQRLbwXpq26snYFD8ek
 atYjIcQMUf7cIez941MOp7WiJFdXHpVXx+3i8XAJmpzznDkHaG0/twh28Cede/wB
 aTq/jpzaHcqeq99mSwhOMiDI9M4/6LwJ6YKhNV+SouHCSDW8MOkkf1L+QIxD7Tqf
 pHkBKTWxCUHxlbhzcT/bxpvyjdrJ5IHrc6kumzmUAmvxUO/wrkkwc/nKU/QGudIE
 aZkX9/N6Cw5wonx9w3CI49ukSpdHC+hRiQNuIOPn2pP43xofHLd3PRpf5ye0R2oM
 3gg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013007.outbound.protection.outlook.com
 [40.93.201.7])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ef31kg148-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:44:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhnCmJ7HUwzMnswJXzcm4LijND7UCYBKoXr39Ik6cYOMo5hzq8oxR8bocNEk1zEGztzgdAvtzIfwO0+Z3rbJivK6ENGMEIMwcAVjt98Up6Vk3zYCOgJGJ4eUhVfNY7INYCdH/oUokcXN4vKCdN6aCc/BosrGtlC0feIi2QGeWTLgiwBR3ISvq5FnTy355egcaa+MfYykkEs1mQRb8SNRlpeFZMUTONd5N+733BJ5q227F7nynYc+ezgSzmMM3aQOuBSD5+DdjnxAYBhmmJw7Tzb4r+G5Qqd+y15+HBaIP5g/ub8sNgbvhOTlhrBwvksFO3ZCw3IAycZoj73ZU11PCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQKVRyfaW19uoblzzAbuWx2flmn1HqEWJGjg0C3hj3s=;
 b=gtU1RWPiHXkoK8fkEMmhzMkCO46Pg38BDZoaaykVu8zu+VmJjgOrTvQMEx4dkBdlidfweZHRgCMOMLjjplqOeyqOiA+sdk4AGSAfGFjlNI5XAaUd2VYCMN5nRt2zYIrx0EI2Oz1rQODUMCeFmFxz14WETjwSUQLXJbXf3gpWalbxN1KG+NYVTuTF5EvUqJNK/JZC8liy6uSm7CvFIYMESBr15NDP6e92sYDLxoX8D0Z8X9o4MwotdC3RupFch4GvQVx4+T5zHbkaKgdiNsPHdcwCibC0W4IwX/jY6y+by9c5myAxPch4/67Sp5tjfjpM+h6Ju3NPPyd2voG2VgFUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQKVRyfaW19uoblzzAbuWx2flmn1HqEWJGjg0C3hj3s=;
 b=XtuRwxaO/ofM4VFBUpI885ERCbanoIBwysSptggZ3fzuxI0hW7veGdFZMOObHVYdT3Hngm0LJ5sR3eDoX3D7/2rJntURai+f3FIn7Z3vDtg+nB8iHaunev2YEndw8q2bF5wjLiIniojfUVeXQE5HSpZCgT6JkXdWTumGjv1cdqc=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by PH7PR16MB5187.namprd16.prod.outlook.com (2603:10b6:510:2bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 03:44:54 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 03:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:53 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SNrbO4289911
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=pQKVRyfaW19uoblzzAbuWx2flmn1HqEWJGjg0C3hj3s=; b=
 HxBme+5bC1Bpk4u0eo++nfIuSr2Ogzg53jZTg1g5wypV55w26Uy5Jql9EMx8fJkI
 MfZZ6oP0Jn5Ksnvq06UPdmetnyvrZBEL95D17QKotQB2pGRNIYahXdz0TD1DKxvC
 4Z5KlKO/nfUg05AiGhpnEwyCHMRGXVxcHIlp6QJ91g06cZOQmd1fHWs8/bsxc6V5
 hobMfNyi2s0ljS/V/PQjc336OScbQPFeSz+9i/AeJY7L4DtIO5dbBQrO4M9WegyH
 PgSecRgJqFw2PzwNyI5oRGT8tdEYgTftvs1LL04A0d3KHrKkR0TAOlqZLtghtuE6
 BR6k1b3O5hlb1G9y4zZwXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=pQKVRyf
 aW19uoblzzAbuWx2flmn1HqEWJGjg0C3hj3s=; b=aYRKUBTASg2u6/ZFXVsxX4Y
 FUrhQ73LY+C5qzy5wd9XovWcSxCy5P+mXCv+7kakrjEuMoxXZ8bhG02qik43cUf2
 wuuPPMlDFXFHf/AVFJn43UUtOdRUbpGVynMmWM+RWauNP59eLtmUiWpG3mv9yXrY
 A5FV4025IW+pQIbSHb9Hh79hmJjuRds9pKboEk9a4vUsQU0Dt1hVVw+bg8zjZQS8
 j5d5rN6AITTXtyx9bvtsp76ySmbaPZtVj3ipGcsvyn4i0LS3FWhZL5LWY0sPJCNP
 1N+vCASlLLyK1jWVtJpB3B4AnZmM+WMblqX7LXsTgdA6p0J67XPztHVIUHpzWhA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81tn2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:52 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id So9TwdZQZfWWnSo9Tw8Jba; Fri, 29 May 2026 03:44:52 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9TwdZQZfWWnSo9Tw8Jba
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 4/6] cmd: Add flush support for all blk devices
Date: Thu, 28 May 2026 20:44:39 -0700
Message-ID: <20260529034441.2075305-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|PH7PR16MB5187:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9f02d82a-b784-432a-09aa-08debd34a50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: UTAR/RvQEaZzUeVJgJQ1OULGiURyDOKdISGtm51FqU/sGaBnPdxu7BcVD/sv6b0X760GnaQhtCDHtmvYeL5zDfaKDzO2z+M99iJxuCGP3TVfzaESRIjMiFzm80/pCMSxPxHrY/d0FfbzP7YGAmxmh1hCuCxFi/Jxbs8OsHk8mTXiPDP39TatM7nBARlcbeI3O4dUJgkFgPSPtOCX43GYG70PUHfCXt36MVVUWbJQNLR5MW6d287tKvXRLp8/8VrBBZ23jM+73gVtzl/wsqmPwduHdRJXfPWp3tWssl3kcB05E7KIgLXXsSzf9TAg1K3KfDMLSKdIuOm9bnhgcQxDsq8reTI4CQn6ZIjK5IxKXJ/8i/nYqjCNepjOm+/+Zy1ZebKjYK1C8RWe78z+hz0bPE+1/EgcPb+H1eEQHWIxRhJSohomlyFliX0GRAdG32n0p9ZG+SnjhrVbvMRmtirkvgTuQPH8AbNZdz5nmOgv76RTc7kuSWuuRHzNj80xv5RJHPm4z4VuoB9ejPZFKyQELw8dBVDDqeod7838PHqbovVqueTJ/wonEMuyRkzfZXkX3Ntjqtetp4htTW8CV8/hjKAGdm0eoasZ6lWslr8NkMa0c1Y8vY4LFHY07OCjXE2QK6I63gYmnD2FSVT2ZNga07EQmgOWpbL8H4larhYlWn24Q8K4MhpMAGcPmpmHZUs49cIwkFtOapM5ydazRUVxnf5r88NPbcYwnAUauV5nRPU=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /IbyP7i6hBNKARYcRqaazG4VKtRbQo8oQ0ocs8dHpzGXcwP8zTE5Q2uLQAF+XHC+vL9wdVDVFkNh91muBmgkMBuuzCuyDUhd3Rs+j57Ag1ymQ8d1vZX7cgzevovi5DSeZdfuVtETGpfq0zzplwHYu89q62YzmD1eIySmP34jdax8b7RSJOelhuDgr0X1ll6asvEvvbnhRgWIJjFwQZL8q4jnOxhSLBjFv8fMyaZ9eHChmX9j09sCDfgucrLMJsHtXsaGs8H+dhA0kc+g+q3+YdU1Hz8TSbXnA/l5RjesPg4MQ25j9mjTFuzztB6RdulnA7Ug2CZL728Ke0vZxrr/tetl4EA9hH7RCRblyQn8LChyI7do19y3XeewRYCiH9k+Gge3fBYLoUe/zERm6k8OjoHvRMc4L8ltVBh4SJn0l06rSCm6pi3aBDsvDYwrhg/C
X-Exchange-RoutingPolicyChecked: LB8qOwFzG8I2DQ9rlkhk1egwqSBdKKkIHobNOMEdsdy7uBbpER+NhkOjtmSuZVUzwOmHovuP60wsGDW+YnjOrPrnt1mVpr5AuwUEMXCa/5HicCSdtvf5kdQmrocpObCsT2bv0YzpOD28/dHycy2mIhZqH0ZzJxC9cgfR7+vIU2pCnLUGLVqGce4qCQdxu1xnHqFWZ2vo2r6iiuZdG/qFAuos7ZWtVh79qTh5bwG9LymHchtGvv814DiTtIOeeUv6gEbgVZRymh/jCJTxGqDr+YTRenLWKqGeSHt7lPTWBMTA6rQKRQRM4SOEwa50u50Zg9F/5mNALTctDHOFiPMdXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OxNyBUZ0N7hHjLbWjPy5w/s4CRmCvTf6On9GDmjabDyDv51ipp/5+CTV+N/Z3zRrpiz5C1UQNDR2/n5NuzywOQwri693Ez1ZoM9UM3+XvAX56p+52J0jMHbxFHNNpjm1XfHLwCtnpV0iA+5jIyd/7PZ7poXC9IfV/eBuO4oOidQ3q67/n1AGQDB0K1KPd0TqkA99bpkDj6jc6W9S3HBWp+d+BLOHNNQ00wGMfCMGBr3qC2p2dpz4kYOvPtlqX5pnZZjO73QC5B1UuNfOTJ+TQSZV+mq+C9uACCw7CvBhR3szH0BL923FqI92Xgzq+2xu4/+1E5zHfaqB7ceUlKQ4wwHiRi4saK9r0sdmsaKC/xDjk1Kn/wusxXYTJCTZCn6c/ge+UTKmyckWHeMqidyB3tX3+3uDvQDQEy3hgjIC7K304fwlAkNaQG3Xe3F4Fl7tmdCdgtal0KCY49Q0uhEAE+014+PMdxlxkyaJlopAPM6ASM00uGbOuO+Zlkd8xRexFeOsxyp7q9UEc2++hNWcxS8Z/HVEJal3T9ZlTGXFfLbQEZ40yLEZuSGGs3JD7M8CnunEdTupL+eLPgx4oMVxfn8+9NcEMnrnVODfwHlmnzE5I5cngnFzXUI5SA73r04RZYZmHyFDued6QzfPTXCF8A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:53.5517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f02d82a-b784-432a-09aa-08debd34a50f
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB5187
X-Authority-Analysis: v=2.4 cv=KIJqylFo c=1 sm=1 tr=0 ts=6a190bbb cx=c_pps
 a=PxTiP5NnQLoflLcDylFrfg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=cbNQJ9GKAAAA:8
 a=vcpYzZXYjgFDKxtgoGAA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: CJR5lNZvOA3IJQ33CEby8byEgGpdBBR5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX/Zmoc37JarNa
 mQBNLmNb/DLEQf9rN8kunk/ecXaLb3oSG6MrUCjDV3hgUxy2c7MEPwTtVdiXQp1CY9D7DrkSsbU
 EY5xsRYn5eqlyP38l4o5+F/VniOIN1Dh4U9hBjRlOBoMYW+shtcM2rSXs5d9s4F0Mr/duaM1rB+
 eUdgf8nyRFaHAFqN5O13U79T+beZPozKo48blgOoYxoyidBfS6EQxz2CpJYovHcifuZC5/fRL0Q
 d4t6NJwwDaZjMAHWAsF7TMWH3nP/ws4Zv3c7/CDLvjkMQUm9wGo9xCXONpuNS/Usc4nRpNa0uP5
 ZqsfMmT5A/kh44lpMSDBT3junrzM3XR2Yt1syZv4S3KG7bvh9z+Hgk3nvWkKr8KagwOAtOWN6cj
 g/iJybE1Izd/wckAXtIEg4NxhjM+UsBK4tnxWFgXQguVre53sdcRlxI+q35FW5IZnxcA0M23XoU
 mmUcjlv+WzdEdHv1XtQ==
X-Proofpoint-GUID: CJR5lNZvOA3IJQ33CEby8byEgGpdBBR5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
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

Introduce `flush` subcommand for all blk devices to allow committing
dirty data explicitly to the given block device.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- updated commit message
- updated blk commands to enable flush
---
 cmd/blk_common.c | 14 ++++++++++++++
 cmd/ide.c        |  1 +
 cmd/nvme.c       |  1 +
 cmd/pvblock.c    |  1 +
 cmd/sata.c       |  1 +
 cmd/scsi.c       |  1 +
 cmd/usb.c        |  1 +
 cmd/virtio.c     |  1 +
 8 files changed, 21 insertions(+)

diff --git a/cmd/blk_common.c b/cmd/blk_common.c
index 56529702a470..d3b00e10f17c 100644
--- a/cmd/blk_common.c
+++ b/cmd/blk_common.c
@@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
 				printf("\nno %s partition table available\n",
 				       if_name);
 			return CMD_RET_SUCCESS;
+		} else if (strncmp(argv[1], "flush", 5) == 0) {
+			struct blk_desc *desc;
+			int ret;
+
+			ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
+			if (ret)
+				return CMD_RET_FAILURE;
+
+			if (blk_dflush(desc)) {
+				printf("\nfailed to flush device %s\n", if_name);
+				return CMD_RET_FAILURE;
+			}
+
+			return CMD_RET_SUCCESS;
 		}
 		return CMD_RET_USAGE;
 	case 3:
diff --git a/cmd/ide.c b/cmd/ide.c
index f99fb6f58246..16833e30319c 100644
--- a/cmd/ide.c
+++ b/cmd/ide.c
@@ -63,6 +63,7 @@ U_BOOT_CMD(ide, 5, 1, do_ide,
 	   "IDE sub-system",
 	   "reset - reset IDE controller\n"
 	   "ide info  - show available IDE devices\n"
+	   "ide flush - commit all dirty data to the current IDE device\n"
 	   "ide device [dev] - show or set current device\n"
 	   "ide part [dev] - print partition table of one or all IDE devices\n"
 	   "ide read  addr blk# cnt\n"
diff --git a/cmd/nvme.c b/cmd/nvme.c
index f2c9acba5c32..dbccb69042bc 100644
--- a/cmd/nvme.c
+++ b/cmd/nvme.c
@@ -47,6 +47,7 @@ U_BOOT_CMD(
 	"scan - scan NVMe devices\n"
 	"nvme detail - show details of current NVMe device\n"
 	"nvme info - show all available NVMe devices\n"
+	"nvme flush - commit all dirty data to the current NVMe device\n"
 	"nvme device [dev] - show or set current NVMe device\n"
 	"nvme part [dev] - print partition table of one or all NVMe devices\n"
 	"nvme read addr blk# cnt - read `cnt' blocks starting at block\n"
diff --git a/cmd/pvblock.c b/cmd/pvblock.c
index 3a83ac9cd92c..5e4a98a6b13b 100644
--- a/cmd/pvblock.c
+++ b/cmd/pvblock.c
@@ -20,6 +20,7 @@ int do_pvblock(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(pvblock, 5, 1, do_pvblock,
 	   "Xen para-virtualized block device",
 	   "info  - show available block devices\n"
+	   "pvblock flush - commit all dirty data to the current device\n"
 	   "pvblock device [dev] - show or set current device\n"
 	   "pvblock part [dev] - print partition table of one or all devices\n"
 	   "pvblock read  addr blk# cnt\n"
diff --git a/cmd/sata.c b/cmd/sata.c
index 8b923f9378b2..417e027cba4f 100644
--- a/cmd/sata.c
+++ b/cmd/sata.c
@@ -119,6 +119,7 @@ U_BOOT_CMD(
 	"init - init SATA sub system\n"
 	"sata stop [dev] - disable SATA sub system or device\n"
 	"sata info - show available SATA devices\n"
+	"sata flush - commit all dirty data to the current SATA device\n"
 	"sata device [dev] - show or set current device\n"
 	"sata part [dev] - print partition table\n"
 	"sata read addr blk# cnt\n"
diff --git a/cmd/scsi.c b/cmd/scsi.c
index ad7d8a4b6644..39be208f337a 100644
--- a/cmd/scsi.c
+++ b/cmd/scsi.c
@@ -47,6 +47,7 @@ U_BOOT_CMD(
 	"SCSI sub-system",
 	"scsi info  - show available SCSI devices\n"
 	"scsi scan  - (re-)scan SCSI bus\n"
+	"scsi flush - commit all dirty data to the current SCSI device\n"
 	"scsi device [dev] - show or set current device\n"
 	"scsi part [dev] - print partition table of one or all SCSI devices\n"
 	"scsi read addr blk# cnt - read `cnt' blocks starting at block `blk#'\n"
diff --git a/cmd/usb.c b/cmd/usb.c
index 13a2996c1f00..3e156f54c50b 100644
--- a/cmd/usb.c
+++ b/cmd/usb.c
@@ -706,6 +706,7 @@ U_BOOT_CMD(
 	"    Available modes: J, K, S[E0_NAK], P[acket], F[orce_Enable]\n"
 #ifdef CONFIG_USB_STORAGE
 	"usb storage - show details of USB storage devices\n"
+	"usb flush - commit all dirty data to the current USB storage\n"
 	"usb dev [dev] - show or set current USB storage device\n"
 	"usb part [dev] - print partition table of one or all USB storage"
 	"    devices\n"
diff --git a/cmd/virtio.c b/cmd/virtio.c
index a42a563ab727..94f1e82cc902 100644
--- a/cmd/virtio.c
+++ b/cmd/virtio.c
@@ -44,6 +44,7 @@ U_BOOT_CMD(
 	"virtio block devices sub-system",
 	"scan - initialize virtio bus\n"
 	"virtio info - show all available virtio block devices\n"
+	"virtio flush - commit all dirty data to the current virtio block device\n"
 	"virtio device [dev] - show or set current virtio block device\n"
 	"virtio part [dev] - print partition table of one or all virtio block devices\n"
 	"virtio read addr blk# cnt - read `cnt' blocks starting at block\n"
-- 
2.54.0

