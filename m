Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2720AC5DF81
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 20:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B144880F6A;
	Tue, 18 Aug 2026 20:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPuLIubzBQik; Tue, 18 Aug 2026 20:05:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787083524;
	bh=aFqTu3ngWLllGLPbmdZsyYeElu6JFYFraaOMk+33hnU=;
	h=From:Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wcdSkSQj9JRcHGnYHDE3fptylsaKnPeAhVr04hp2+iqx9rkA2nVwqJize1yhKvImM
	 0d2qOxib71Ayb4Hz8rXU/SxYB0p21dWJwTJ3v7xR8vyqRGBQGKwyNzBLnyUYwy5pFy
	 YtOsBQqg1MQbL+x7cxvEFlARISLRTzToCNgwibqCK7z+lRRG7IFsSNj+Bf2cS0VY2B
	 IYgLx7UGjiqOZy9Fb1lvnvf167s2l0Gv98P4AmcUQMD68X985avQYZ1ts09qcjG+o8
	 9JvGM1TeKxyz5kpYJDtYeVyMncI2dBl7czmGcVslLWyzFmMOXM3DjD/Stp93ZM1jVH
	 zkxakmuyfRwLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B62D80F81;
	Tue, 18 Aug 2026 20:05:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFC0429B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B595640216
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id urlq5fVNth_t for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 20:05:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=pWTX6C9y; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=YF7L/9X5; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=jBPpuXU5; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=o8+KC+Z4
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A8D640140
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:05:13 +0000 (UTC)
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJUO0C1656349
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=aFqTu3ngWLllGLPbmdZsyYeElu6
 JFYFraaOMk+33hnU=; b=pWTX6C9yX/LcBY9l9a8LogNsk9Lgjvap3K74QrIHEf/
 oeBzNa0V1m/FYd6sYMg+6JwJvmCZ74c7XKJuGDfSgxknrco7Itfzelaothn9xlDu
 e9x8bFXl3hud5NziEuRJk2aljAnngjAWf6jASi0VBUc1Qg8yYVdbyCS9/G3dgRDj
 c1Pb0yTsp4TPL/d/nYHk8gZmP7D0Tgi2Ud2a4tEoVYMfzrV2272kM2Hc7s5oBVFu
 CheRM9yZtOf+8yhEd+K5eDTpYUAEnp60gHjxpiTYeA0w1S6XBkayaRibEXQN9n4a
 7QtiSbb40CRW8M8ML0LwdQRIEomxp3Pcfx2httmjKaQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4g4udej3d3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:05:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INaCFTNfwZ13ui955WGmsgGCPEjsdRlwUD96J5yX1gCeRpzEpLPorbbnQxxcZ8JzAuGAwrVsXBHQGxkedMFLcZYIs71KFELUZfCYk4QQw5cf8LJiMCA3JG27uOHWSBe1/PmNqYid/UOIKLNGzovK3SOBobSclRe9md1l1wh75cG42KqUbNevmX93ZMaLs9G1HkREWEp4zTCq6SDEIzv8WTSQ5O/cvjX6szU2hJNZFjDrHyaBum2NODbCHJ+zMjCFqhc7vY+9ZMBN0C1iys5wIJllh8ZAlDS05meU3PDeRXo1mB1krmbjYbBlG4laBIGLl+poBBgkfAxq5ZT3GTD23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFqTu3ngWLllGLPbmdZsyYeElu6JFYFraaOMk+33hnU=;
 b=tBQb4gHDrzgqPa3me/nC2w3BT77gHdiCQ+tVHTrrEgSPSFc3zzmztyYsmUJMIQChZvuZNx/s8v8czz9pMjtQcjOb0Gbxm7UeRWwSFl2gdVjcdvZtqvdP8e5t1MUxNaoMbb79jCaeCxcRQ3L6vzqXHw/j8zg17NzspqYpFJRFmIjy8WMEaXzG3RFzgIM7VUxJFrEX1aBSRsoZ2VjKgJlWJVASNFu5bjAoXArcRtxqcX9vpaal83CcX3ISnGUs2HtxRPNw0gnFg3OgtqrbjPIJmSPPEMT+yUW2qFPDOxdN+eoTyqkcBDWrzV0Aanjqdq+9qwMf7/i42exoJTt1kEZOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFqTu3ngWLllGLPbmdZsyYeElu6JFYFraaOMk+33hnU=;
 b=YF7L/9X5W83NnDl1PoySlFOT4HUcuPApSCIiLwwo+9A2jhiK58Ox8eg9myfnlC3i1zzpX1ODhmSo2dhqoPXb2kfbPgaMlxUhlzHHKf0NS+MunA2miwfWpCaU8lxL+r8FfN6CJ6N+EQWOZBE1kqWFOtFJh4a9NtTa7ufwF1w7SZQ=
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by LV0PR16MB7115.namprd16.prod.outlook.com (2603:10b6:408:32c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:05:10 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::50) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Tue, 18 Aug 2026 20:05:09 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJX3ga2400711
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:05:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=aFqTu3ngWLllGLPbmdZsyYeElu6JFYFraaOMk+33hnU=; b=jBPpuXU5RXdU
 BmV8QrxeNx5g5K4hqybHNkFe9Ibfmcwi6YoGXe20FBJRTfso37GoIlMZATHRw2VW
 muQAoLIbkw8ObGCcrloHzREo13a3D1zkE4HND9gqMRSPK+4iDCqiHRyiLOyGtfYc
 LuU2gOy80bT36394FhfpF+H01Fq5z1wI8/ecloMaRFC+9xvQBz/rDfPU8bMzCmHT
 q162zWIrA4a04+9GC3psllbHaPMBtPKvPMUT0DVjEAe89WHaJN++HbOeUCs7S/wF
 PfxgvuRSRKFLlXSfW65IR/d0X6CbUZ+BAKaYCcw9gHQ0AL2hCGQ8FZoAsC6ffhed
 morPJpV2Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=aFqTu3ngWLllGLPbmdZs
 yYeElu6JFYFraaOMk+33hnU=; b=o8+KC+Z4LBdWC376Vke5lLuV7X1Ub9cqlXv/
 IpLWlpYStPKczD8ahHIq4Lccu4ysvJYiM5uYpql+ew/z7kVudHB6syV+KfMEEigc
 iiNA9pyX7gISNPgCc5nvb3iNR/X5qnh+mB9pF/iKm05gUbehiLpgeOcaY/rGGoVc
 Iw9fojUPzZty3UwxutNV+MRkK4JYzfLSlnQ3LA2NauiHYRZSKqyQbqMGa99MMIUd
 WZ3qTB6XtqlOwF3qTeMM9FTxCaPeqZE1eofVkv9+vLuZZLK+CvnHyKhMD33MEi8u
 dD6v+dP2wNqZw8S8/lhjCff8h+j+DQndPEp8Hp9wkwWk0xENuA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4g36r7umfq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 16:05:09 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id wQ3WwzAn2p7v5wQ3XwJuxS; Tue, 18 Aug 2026 20:05:08 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: wQ3WwzAn2p7v5wQ3XwJuxS
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Tue, 18 Aug 2026 13:05:05 -0700
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: Re: [PATCH v1 0/2] reset: small cleanups for x86
Message-ID: <aoS68ZxFH2Oh+OyL@kraken>
References: <20260729083826.2277173-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729083826.2277173-1-dmukhin@ford.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180147
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LV0PR16MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: a6038f99-62a1-47d0-fb2a-08defd640194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 08i+5nof3hg5D/w/ZCqo7U3xqiEzkSjBvBbub7kDugCetFAiOiqDgRA/1WfOKN+YESsz9eHhvYrT1RetvWefZx7V273OcC4z9Wc2MhqDpgMh2L7Ye9TUqbVmbeIhBNGdF4TuW3rDkHntFtF+PTdpHmBQrkvdj+DyxW/TqHawaKIA5bDZXZ1uW1U25n55MZakoyl1jLU0eJ9WM/O8LngsnEKmakPfBgZ1N2FO6GyGsEz87e4ldx92Sw22OtoWBI3/SNSbiqKO+Dx9Y5L4w2QUN9npU7dUKZ76U11ANZl+82F5twUpXp9wFAXF4hk2qJjHhvhruEsCfxyM2xcj8RAzy5TyhO4ctKw4ErHlni4O9K33Tw0W4ltLMuNllTv/BaWmoPtGUwqrIRxmVQDCgmyoPsfVph9+J9PH90n41guVJ7Xe+4DVLuk980Glu0ad8NbNQ04YvIX3qYvHwD0ZeybsNP2to2OfIdHCHNDWaPRZliuZSqG5+gFmpWDG1PytB+DG8BoHAFyCdtUnEyaNkvkVGjX2bVPIFn6ugXlS5l+jmAg4ONdZrlOMt+pLFBgnGfLgGUosNB6RQHIEmskQ8kmEQyP8+SJauULUi9xQhj/jDCvDxD7b20Nw9FtWcoAIGu089u2I00+v9Q6skpAAWV2sZrakLEWvtEbOVA3zAQpzmWzF5myGjpYhXhVE8IYdVDr/O/ovkAoAo9l/+YV1LtLhBg==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cy5XxEVXJlXrokHr2Ob+UF58xsb4DVzqwnzpRPu8xyvNx3fpnwCued6vsP0KRF+pca50+Ujbn+z8dB1jgc/OUyuk6udLD3n9gXNMh1yJBxc5i4Og7c5RVPR2NgFmH6/+SkOzbcKBKG7yDoRZ4gxLxRZY3Dvagobe00lo5khsnPJv0JYmDKZn68mRFhcfM0R4EaGI3mhMyi+XQ28j105ScxBEG9BKcHBEh67joU9F6HK0HDce9ev5pXzw6Js3taBG6Hkuvh5obTvF3Awnz/vSCinezuEoWejt0MeEcKbzsBFdwR5a9zYRgIl6ht0VKu36UKrEnEGaib/ZAlhNTXf+6OX3a6vYCh7HqYt2ghrsnFH8ytT+c9CTX8JwXdAjulN/b8kpHj4jXpkiqnmWc5PBK4tuHqjtvVWSDOPq/If8Pm3LwZNCZM3IyDHRUnqwUK0k
X-Exchange-RoutingPolicyChecked: Z+yTtzJS3chsgU9TtZAA8GlLcdS24wsXLeJEwESE04m/ZaF+RpsIff6GGc+FQ/POQoDMejlqO9nzWFIplqP0CMbUr1Wr9cEvkCLmVvbAO43sVXLTTtV5VHCwFl4Ow/OMuG4fwHtSPTfrZ15IfH0hnX+UmEQWojqxPUj5uVXSaR5hUTckkCH0Biyjvjn/XHU+XgMm2HErHHWLhMaMqrnaIiVbigli6Wu4C1NB8hc6V50ynI0Tfx2spmm7/O+r4kLgWnd0JKe5/Dl7Kj2FjSPMTngt/JiSvd0+mocpluzNzoBmwZR16Idel4ZW8i3u3PgfqaMKp9qxDHNfhG7mqiS6vA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yJGh03gLwXjZWsDLuUDY5SAx6AKp8t6GoMQe05R8IkpKu8GBI6Na7iQgMeavyaV5JxSjCE/RlBoI3Z28Safyou9bOxcVBvJvxb/qI65iehCLRifJMDnmk+hULLIesNi5vjYD8hqNzJTl9mrfiaSMFT4EkybZrON8uKFEeU4N79HA8jZw7X6AkngpJAkJou56VkO0DNQTfnMXPcIUmwFwBW4FNfr+LDBLf4LesTQz4VLg44+7krxStC+srfvjToe+k8EsBs7yadd0xDHQNlOn9aJxVY1oHOOFCdWLMuj88knEaCdR/zQ30CdgLvbmL+UEXpvUEcR5QeDvoziAaxCE9AiDN0T6IuFKtqtmaEikvcTaGKesCtRjjwFLEt4KLmFxbw+2QABmN08jpzwqqZUfVh2TCjlDQP7yZlSzdba3Kg46JNq7tb2U6atw4ylLBwndFBxT29DRAcquPzo4G4cus7nHmmU+wQKclON1kGLPc4McNzKHZ+sFkHPBgD+5uhJnsuaiM6aDUjwHhckbw+1FUMzy8cFWEMpOluWMdqKSuNU3NPE3tHT35WRbQn5bo5f3gdOiBUQ9icxGlcfPslbgn6v9gPnY9o/hCB4p/j7VIMSc6GpF00Jj4sPdBJqydvJ1oisbzQMhi2RIyU05pQIDAg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:05:09.6811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6038f99-62a1-47d0-fb2a-08defd640194
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR16MB7115
X-Authority-Analysis: v=2.4 cv=VsETxe2n c=1 sm=1 tr=0 ts=6a84baf9 cx=c_pps
 a=Eo0YKKWWvGv/UpXdOuOi/w==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22
 a=VwQbUJbxAAAA:8 a=cbNQJ9GKAAAA:8 a=DUCSIHLnjH2iOlWCvoQA:9 a=CjuIK1q_8ugA:10
 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: OT0XQmTsFm_qPbY0M9n5aIkUkN3I7otr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfX/gLNsD6AGByS
 /Pl2dRwil0/MmGxnkfok0Nyhr0GIXPTmDM+v7yjyBw2vRAaOIb8rmnLaJGsii7NV8amW/kgdl4e
 xlwAjX+MpfWbKipcf16UupLg8KGZRlD6Nm2liVBGsfjCJ1HC0GhrP5ra0NCIsvHU+XIvrsXtmSs
 XvDRXrVfxbv6n+L5opBVtkvJMbab3z9yaw7tz0vnQKFKyNC+KBc4PaJyEozrf1IT1mAdSvvzOc7
 0VYtHNCg8LzV8pONONd+s4hyUaYKb6OBnJCjVu3qTNUQgoifhMANKiIXEY0LrQkkyB6P7wq7jtX
 1ZIyLfZNkwAAig1VSIpMgZwycJmBF4hhhRajkNk8DE5TBYGhRdEc1pLaEGtftKXfI2mt99EQOh9
 7RzJIeGLcEC8/FbEY35zEyT99LhOkfUNyVP1b45GciVk0lHaNtZTrwb0pXrJvlHPt56rmV40mKW
 o1qeIGDVA9RnxjzqYeA==
X-Proofpoint-GUID: OT0XQmTsFm_qPbY0M9n5aIkUkN3I7otr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfX2JFf9vq4XcAW
 gaZ2G26lLaxxMScmCxkQj9ZSraFBvL5q4VvHQ8lUQ4J1lvabJUrwwZKG4L9WH6xBpL9appg/r/f
 tDlaWw7IQvQcHfA8Oaler0oKs8HJkEe1FTZ5ZGhaSbAy9SGBAoES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180147
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

On Wed, Jul 29, 2026 at 01:38:24AM -0700, Denis Mukhin via U-Boot wrote:
> This is small cleanup series for x86 reset device driver.
> 
> Patch 1 introduces a small fixup for the x86 reset driver.
> Patch 2 introduces a small fixup for the x86 EFI reset driver.
> 
> Denis Mukhin (2):
>   reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
>   reset: x86: Use cpu_hlt() in efi_reset_system()
> 
>  drivers/sysreset/sysreset_x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Just following up on that mini-cleanup series.

This is re-submission of the reviewed patches originally posted here:

  https://lore.kernel.org/u-boot/20260603070743.1268544-5-dmukhin@ford.com/
  https://lore.kernel.org/u-boot/20260603070743.1268544-6-dmukhin@ford.com/

Thanks,
Denis
