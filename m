Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3DDC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:38:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89C0860ABF;
	Wed, 29 Jul 2026 08:38:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adg7rXuxLSGH; Wed, 29 Jul 2026 08:38:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 894EE60AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785314322;
	bh=ssr3z5L+c7y5TGnEFzsAui9Pr/EBroReLlAzKqVY2R4=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=QrGWHjjBlBFutM85Fiu2wpFZhyVdWYdbCfmGB6qRyGpEuvulbzTfqOCYAM5+d01f6
	 QC48V1ZZy9UKw8gD5MJNcClpEJDzJRYPgQURXY6JrMVh7tYCz4yX6X3d4+Sw3RyzTE
	 x9RmCi1ox/n6o7/jy3h7YviqBwAhvP5fibbjurPlqyA57NoN0EX0zJb5ChCEzKk1Az
	 ZmoO52Bdj6/sNzn2HsrdI+nLTGhB411yFHSQHE0eiMwhaXTKwtYOXLpDvBiIBYXk9y
	 3H3aN4m3yZcxT/TCWo1/p4hzBY+BSb2ELUxiL8LyAdzsIlWg7qSRvQT6+8aLlDEs8O
	 xRanbpY4jv0CA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 894EE60AE2;
	Wed, 29 Jul 2026 08:38:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9286923F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7887A4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOrkMIF90LX0 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:38:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DD6F74004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD6F74004B
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD6F74004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:38 +0000 (UTC)
Received: from pps.filterd (m0384718.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T8UYL8545898
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4fq8k8j6mu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+x+aGdYZojENs+pidK8GwiKW9iOBvFRxNg/7r7YejCfNxlYO3EAAkJAavTan7fWvEhPto9ZlwTm536mlGf0/qyoQ2dBIJywCQ2hkH8du0WWRtDUWgpGlmz2lK2ReIE5oygNZMyFTZUGbLIOJfRCAkVVavpWr7MEWn4ZkmXdv0xe1+LSwX0VSpsC40IZXPxvSySaBgycXgclFjGo6Zmm55csUY32CWDF8juoE6Bluv9JC6JjhVleRqg4EIkX+uOrKTE4F1pMuLUMkpHaWFk+EvJDwl5zVwm7N+RDOO73CoxpcTUZ2nR3kbVNvqcAeiUOXIHbnrvLVTZPO4NQFIMO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssr3z5L+c7y5TGnEFzsAui9Pr/EBroReLlAzKqVY2R4=;
 b=gcQ2Fru7qU32nehaJgEX7nMm+6wNA3VMsRZXUZCR5h+w7HuyMZXlMIo/6vWJMljpsAnQ59zSFiWzb5hn7FKIIHZNmYTiVRwknzyhdHK9C3+Ee7nD+sIATp3oU2zNqkCQpbzLR13LM9BulNsDT2EOpgE0BCsrqAewYFzkrB5oZUiUCPT82lftacF0vdqrloqwZplkYfyX4tdneLgUI/VbJ1EiHioEtwJSBwPDJzGlxijzZIwgNPLZzK+oQ69KYmnJJ+0/pCWWoF2vv2R/Jl/VljfRRR1SO2bddLEAlFmQ/N3SNCFqV5EdRihRxP05Yd7ZEqQME6QSw9RC4BecN1txDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from DS1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::6) by
 DS0PR16MB710418.namprd16.prod.outlook.com (2603:10b6:8:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:38:35 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:455:cafe::7c) by DS1P220CA0011.outlook.office365.com
 (2603:10b6:8:455::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:38:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 08:38:34 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7bt0a3648943
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:38:34 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fnf1sm1vs-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:38:33 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id ozo8wDsyjERZKozo9wki5r; Wed, 29 Jul 2026 08:38:33 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ozo8wDsyjERZKozo9wki5r
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 2/2] reset: x86: Use cpu_hlt() in efi_reset_system()
Date: Wed, 29 Jul 2026 01:38:26 -0700
Message-ID: <20260729083826.2277173-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729083826.2277173-1-dmukhin@ford.com>
References: <20260729083826.2277173-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290070
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS0PR16MB710418:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03d93901-1bf6-4d38-734c-08deed4cc736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wU7EJJkSrm34cf3ukEFNMwNCz/Krl8g9jJ2tKd0BhzwBMG2B+0bXz7U9AGZHdTJaxl4sIs5DjoPcFDm2AuUl+qxFbt/6CQOpIUVpqnSYw/+m8vYKJvDhFwCtj6LfE5IUCXn3T3ZzGdJKTSNTqZ45kWEW9RtQcmZvMMIGDXdkQ+C/X9Herc+JvXStSLkoKiH5OQXH3TLUP147FEmOt6ryjaf6qyP8ULLhk9TH8f3Ax9i10GKaE/oYqGhxobhhiOwe3t44KO6raPwWFxW/so+ZsaYY6H2H4oaiKTKRDSqd5NwCWrWIzEgXHOe3BRZQdoMDQSvAIzO8AarnY5scrr+OfmTa6e3Of7uuBJ0LpNhwkkp0Dg1p0jZZBtQF0LgNTxs+v+oPex6fRGjXodN+lOce6UtL2PSd1UviN5JsOjGh3glQ0dtoquk3jTJOUmYqiRYHRsXP0wCr+lWXONN9e5mGWTLVMtrg7zojX16ZMnsl0il0ahLyZmaZPwPx5q2SGNkKWcFMeKMRQG3Qv4S1jS0t7DgoSkstZda7Zba/Hna3OTAXfq59pir8gAEi8B+DO5oDlNgSr3pk7RQn3ub3bEkPn4k+HUwqxQQ2lwmiUDnKXxiTDMGuG/nzTnEzhrn6H9nhpoeUdo+rF63IIBrrVH9h1DGeTyG/vgpxZhGuBYR6BuxZn9BdmYQYk3LQNE6RIQt/eRRwNQ+p+xIdRRdcFmU+LQ==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rAKr84ztDJUcO7Tkh2TVPXko6kT92DrKf/r96lOA5XC5qntI2ylYMmyibFbuwVXsJuZJHKgHaAFHIfjUiXjokic7DSDReSdnSJVdLl5iuhEOu2gnl4W6Wjka+2uQfySdIY2V9TLP+h6NoMv4D6wYUnCa0kV4k5Qxbx4FGqHFXzkkyI1NZIpwM41FRHk9uh56BmYIQFKMNUOti6xXYnN+6qkoKuSEMMDu4Y8XwwcfRdS+pT82J46mYl/piCDsFwOtBpraruybszjy68aVkMxLS7CzE28e72dd2d96E7uzA5NG7OaxSol+aynYgp5UHpowLSSQlJW5P36KlXhgYLFZmt9If/BSs3OGhWArDZBl6Z7b0DezCyok3MJy5UPRPKQhIwASf1RiSmoN2H8GdrG/r7gP8nI2b4MUc0t7/fyEZy2WMXd5SdaPdjovh/twmpmM
X-Exchange-RoutingPolicyChecked: ZA7VV6wMh+Olf5jILDpTYm22JNNSwg2plFtaPhxx2qWxdjjGMpOy4/QPhC6xsBA9m5B2GxFdhPLcpyHI5Th9LuvaVtlPXa4BLdja5jyn/jiO9ArEuWWodWTTNjhU3Tpf8YMeI+EpEJqi/gmWiKfxmHg6rsmQ6X0OJxW3ttg+PqjqsVbwEWltfdJ8bm9jzCMNHNE4EPzr7lSfEY7jBh4CguaP2azqhpVbjJVgZouMmCw+dOZuV8jTbzAK7SJKNL/pGhUN71wuiveT0aVb5Y684f7h3JzPoIU9CzFf3d09d+HveTSjqYEUMlP5AJpMrBkdiOou0aOoQoATM9OKNGSrHg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A7Zf58RC1MSqgDAoEak3idtCLYgoWkR8sLXpys8jiA7O1FPCL6CuT6dddmBxSas5kKFWV0oS8xIvowVf2QYYMDWmVanBJdCNF1/mtPArxK5JPw/8LzxLFPQsFxEPuTiTcE3wmHr1ZbbpIRgwy2se2k4x1zdFYd+e+Hw/md3apekpuHsBcKgy22JA6bZsvTVXqmuNrZkdp1sZJN71PdWvH6pRyz2i84Qxg2yJlODbJ87fAWZEPburaqR54cpt8zDEd3sxmoxbAR5VqFfo6LEqDqyjYbtre/WqeO2XoXP3vqDsQWDT0ECY0lly9OL8l3G+OBRYCa9oYON7G+QiEFGxBZ7qxR3IHMyO5Vj/TLiTkBvXY2V0pKx5nHiuP90Wrn9shB8agRZITtUebMG8Q7RMICYmvlQfXrb9BOnc3feU0+agMZYWb7H/Ik+kUArQmbhA8za8E48bVu3ludUAfC8FrcKkkAoM5gtdoKho9hqwkhBGdmtwEsKu131SKWe1mQcZd6ChecXd/Fv6kzwQLLrOXIQI9Jif3i2QLbzN9nApXMYLEHKGGV5+I1uVVDf1jyHNQ2y/soJK57cfDJE/RM1whRLMroZu9eqdurJODKCdvqnAC6xycJB8P7PkmGPggtIOnMCr8nvjod285ZAMzbWqTw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:38:34.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d93901-1bf6-4d38-734c-08deed4cc736
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR16MB710418
X-Proofpoint-GUID: t105-aH8WHoFNTSbmAWwxW1ZfKcLNUgA
X-Authority-Analysis: v=2.4 cv=JaiMa0KV c=1 sm=1 tr=0 ts=6a69bc0e cx=c_pps
 a=kBTuJkHEWKOaoYTOH1TR3A==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=ARvDHhclS48edyKYUbLB:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=o6LkJJwk8_LHii0vGK8A:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-ORIG-GUID: t105-aH8WHoFNTSbmAWwxW1ZfKcLNUgA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OSBTYWx0ZWRfXwsTf0QpV+Ezw
 H3g6LbmX2dqqBzfNGbJbCsvoy+YPYVibrmypIJi+FKFSm2t+1wFMGfmTFVAvz4OfcXG9q6CJXnX
 6KIihpALKHf+GlDFmYi6aZljTXc/ILQ/fkTrLED0HGBHdRXTRh210lW9K+y40W5yg4cPYEzPuX8
 d80I4X0FLxhTO+nG6nCTcmwzmqqilPVxC8gLXHHw1ZIxykP67IvixRGRYYUi4+OmtC9Wmi1Pl0L
 /jN8gxm+zGTtBJc5MVCr+pdck5krWL8Oplp0xnVig95xasQbU24FhhLQpqJnQh8NY/VSz5QyfPC
 tk/rh9pDHReaxT5PrfewBEdrsn8oz+PqMZy87HJmNkaMVEHGZUYYO95aGXU2Y+csadsdfDVdkZQ
 zGYcvIqspFX86w2380c7DaA3RyDag5kkOtYUMqWXUatvZGX6iHbTxPt71RZzXXxo7GznvQDoiiT
 Lhmr7Jz932ExCDDbQRA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OSBTYWx0ZWRfX/D9AzJtUmPZP
 PMNNWZHyl75aIdiNq7HtufqBSxU+YnbSmFjXzN05gw3CONhXsby4zKihLZUezZShqG3ImeVo7V8
 UoINCdCVGKt9Y5d2ooNFoWsbAU7MkM6SdFOHr6o0j/q8hIq/3fAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290069
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=ssr
 3z5L+c7y5TGnEFzsAui9Pr/EBroReLlAzKqVY2R4=; b=i7mc9ZaRRX8tGA7dR6j
 PvdUW1NoPxpwPcohMLZDJ0La2QQtKrjCg0VRV5CDG9u0tlrWJ5NCXPGNsXujIfcQ
 m3eIaEs2ixgJK+rTTS1HDkD8hannqk9IAbGXydg2mbVMdxBQmI99TwGi7EsirdHO
 1CF/XoIPDrBu4J4h1N/huIj8CkCqH72oHc9aooi5CwDIeR7D2Z/KAfybt0jkDiFi
 UOxzBsTuXsSMAIo7ucZAZKCDfXm4DCKVqslXyxFmK7jaRTdPSSOA674QinFBUXgl
 cBIKN+4ZSz7kCZk/Yn+4L8Yrc4VnOp00tvjM2CC7bQdZE3+Ol7PEXccZ3Bb3JP0A
 Rjw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssr3z5L+c7y5TGnEFzsAui9Pr/EBroReLlAzKqVY2R4=;
 b=H4IrjoUR1tVmVsQBfqsx1Hiuh6kuMnbGpS0JRpQ0Hize4hBtNO17Oop/86leHNqZY787R20PpqYABxAfd0TfmI+hIts2WuDEzxrrlFZ1y0yNwdaPswx/DW8GeGeCquc3i4eSnStIpLd8buz7CdyAsGOIEeUXnpUEcgXL87Uwps0=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=ssr3z5L+c7y5TGnEFzsAui9Pr/EBroReLlAzKqVY2R4=; b=
 mQmEzeZ9awiszYeA2lRM3aCTExFDY5XIyeV9UUKRGjJwMSJhaDCGjb8hDsH/WZiV
 2hsHYRCO9HORJPpkiJNYgyP+ssVMq4xIj1vBPMSROjLvwQ/cQWhiRNFJ9dHasFVT
 GQaRA2S+YTY3dibVVZfi/BGgO5/jteErBF1XD4HzKHrpxlGx5BTo895paL88o5ej
 ZcZD2MaANMIL8zjUYqRd05MLVMt4IVABDAXU/uwrrlahQvxdqS98KFKo4GwPGYpP
 Pt8NZiG91PqRbQHcHAbDBvHVVaOgKY1kWlxoDOO7hrGNjl/373SOlK2KHSyV/7lU
 0BhjcOJIVdtaKH/D149r8Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=ssr3z5L
 +c7y5TGnEFzsAui9Pr/EBroReLlAzKqVY2R4=; b=kjjVnkHulMeaNoVr5MevYBU
 02rDGk8IGVy0PPnv4bJSBJm5+RdNOBr1/MIP2Epp5r0IA9c7TUwyf+9y4IUARPap
 Nq/L6YMMayLsJryO6FH1Mkic+AJXezGfngtzH4JCdc1eHNkohz2tDyLSZ0L5AFbK
 RXK0s1e5tzdBseOHIc0xFXUXMMtYlA6bSKYbl/Bs3MkrR67f9Bys14hZRRYFsrp/
 0Q23pqdQJ3cy7Vi+QjzUJvqCFQ4hgM61j54nvU7qiw1f62o/ORta3kVf1D1QBDBz
 5AFUWbDXVzGSDOnQ0rNGoylMeX6ENA+o/Z2WkZ76FFGq+Q4AEBrCDsN9qLTdZvw=
 =
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=i7mc9ZaR; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=H4IrjoUR; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=mQmEzeZ9; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=kjjVnkHu
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
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Denis Mukhin <dmukhin@ford.com> 

Use cpu_hlt() in busy loop in efi_reset_system() similarly to
pch_sysreset_power_off().

Note, this is safe for __efi_runtime-annotated efi_reset_system(),
because cpu_hlt() expands to a bare "hlt".

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Original patch: https://lore.kernel.org/u-boot/20260603070743.1268544-6-dmukhin@ford.com/ 
---
 drivers/sysreset/sysreset_x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index 05a3ff9c8363..afb77d9c5c21 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -120,7 +120,8 @@ void __efi_runtime EFIAPI efi_reset_system(
 
 	/* TODO EFI_RESET_SHUTDOWN */
 
-	while (1) { }
+	for (;;)
+		cpu_hlt();
 }
 #endif
 
-- 
2.54.0

