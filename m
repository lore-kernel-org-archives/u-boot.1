Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEF4C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 164DD60ADB;
	Wed, 29 Jul 2026 08:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UVKrrdS3r9Tw; Wed, 29 Jul 2026 08:38:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 487D860768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785314318;
	bh=kMUDTzfUjLKLNaQRDs24+qd279fHi+GcdF5GUPip1Fo=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=X7JTkkIHJ9UKR29ZKosasFrY1+voP8ELwZypQWqKghhV/L1mJVubteuUJxRDfVu4D
	 q6stWtvjbw+agUiFkjwmHUW+FOKKLNXhj4XPfQXfxmjGyYAFnXeWG5M4I30NWLRW0K
	 l2GC8OWEZvr6WLKLFBBBQbJZpx6slYsxFX4nwdLmI0qCaaIDcc+C8BEiV5V0cRj/Ic
	 Mo4MYZbKzOWAGdC/Q9w9g9WwXaAVA9wFdrvpxZxqJrjXCY8dJldoZNSzNpuwF/i7De
	 56aADXIp6+iCXVcfdGPTiLyWwNOC/KY6E6IPVjKYqw02QWbmwO5yV/BXD9UbMRBItB
	 8E1gytuF+lmJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 487D860768;
	Wed, 29 Jul 2026 08:38:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BDE31490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8F7B606F0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0ReVnVDmDI3 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:38:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C848160768
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C848160768
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C848160768
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:35 +0000 (UTC)
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T8UWZM827145
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:34 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4fq4ns3js6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:38:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRz8/XJPXiskDMjHLdegU4qzNQJPXn5D1vUXsf/8U+Gqs3sYGCTncVkdwPqMDULqSXnQxEq39QNttLitQ9aIxr2s52EkvpN4TzHbFPp/mwzWYwAL4C1J/JFsmmZSQz6FYcGrgwumiKWGkJptPeG9GSIo8GHDqmTIys7/C4dEj67+N2xF8bZ9KVhbnavlrVqnD09iXeRrjkBqH7UiscovPoh/WSXFwuS0PsO1UuaxEbJCGehlHlgciF9KIERx60ZYJgm0s98nxNQHd204y+9M0M1OZf7KT7WsJbDBDKC7SYgcYu9ONOcW2E/1kU+5OhRNxnZA++3TCAO/2mqLws5hqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMUDTzfUjLKLNaQRDs24+qd279fHi+GcdF5GUPip1Fo=;
 b=CNTHQO271rjHM9w1svtMYF+ti0YKQRPNTSpKSLuYdMTSP/KE6M0/FbjGEfEJA31VJjyHl9kwmGp+Yn0Jqdnh6NFxo8v+vcOoie3m16xNaRYuu7moyfHSeUzq/30La+eMYdroFZDwrARdFwegA36Wn/9a93IxBjve8RHJEygtaGFynq/LzAXS3UguR7AukZp+SqOdhp6i0+Q/EUL7RkXPT6EKbvX95+LbOwJgLO+J12AHL0dwaRbEs9sqWqfQTsbJs7eQ4kF7EI02HTrbfojjYEs3qrLqkEex2c+LxbGljBjbzLDWoyPu2gq0I3nX8m/BeK8sKLNxdPfR1xm4iwbbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from PH1PEPF000132E8.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::28)
 by IA6PR16MB6861.namprd16.prod.outlook.com (2603:10b6:208:5db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 08:38:32 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2a01:111:f403:f90e::4) by PH1PEPF000132E8.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 08:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 08:38:31 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7dHG52181527
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:38:30 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fne0y4961-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 04:38:30 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id ozo4w0DRBjJj0ozo5wokM6; Wed, 29 Jul 2026 08:38:30 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ozo4w0DRBjJj0ozo5wokM6
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 0/2] reset: small cleanups for x86
Date: Wed, 29 Jul 2026 01:38:24 -0700
Message-ID: <20260729083826.2277173-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607290070
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA6PR16MB6861:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 04003db9-4bba-4535-687d-08deed4cc51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: VY4FBhiaAfySCVpHaH/JsBcNwTeNVJjRNqpd/9rK6Z6x9j8KfKYmd2GfjzX4yu4GJzd52HGd/dSO5djoAJvWTr4U7LnbKPIPC6onPJYp5+x5ymUvTPEMdyw4k8tjySh8q/XPzjO2QhTjGnLDxE6ZLBJpM5n0NNaXhSH7R9OXnQz6jHnGpZCCr8VRvZmauTNVOWB+zYRGWipHqd6tjQI/aUyXiTQjEy8zqeRrOaiDXu3TTMCCMtwmtw9F0UyR7Pp9qIkEjKzWh8VhI3MaxlMyfgursK+mfTc0xRkbr6GXYcHn1VNdBsrqii6jICfqFfXbp+OQ/VG/Toc/tZpMuCTHieHRLKMIXx+Jcj1ZsoLgt4fEE9umbklqNXoYBNS3V78ve+OmjP54vuDsIvIUot5rmE60H6+NC7CYP7+AxOUSl1MdithBN4D2sn76+eIp0+tmwTQXFCstITKGzAI8PneSAAAIYwv4AEZxcKI3NTAjSE4Owz3lqJJha6VLCbpu6i2pLZ/8HO2u5vvz4jUMIBJkxhIf0bB8XhCAcYBi4kf6pBwn++rUBDiXCEXa6tQkXjJhf57wO54AiERivssTzJUJz6O4wyDBPVCbJqn6Pc3drjsd4pmARrezz4r77GIWz1z+SCAfsDkwRvC9ak1Arxbbjn1cpljZSxVaCI8yV97I2D784zkB1CXejmNamgJW/TllnH1QrTI4v7lZZjSxCnmfqA==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hNxxtS/5QxlaeJEVOaJlam0FQtllJzfCnbrSkr8NZpsPdTaucKw+iGeeA84FP3vwBVUlrwKFGGQKUOHzupFbeLLNpJvs8JFE3vi+tRy0v/6ingcP6qi5VBj1OKahFNZn+Q4Exe9GeGGQ6H3nboiv76bqVjbaskvDyOMBH7cdUZpV/Yo3rkdDCVr7KRaTCOM51XbNJlR7hIk7UB6eRkw7V0M6Pbqey5OAmSWgE6EYicPvO8J/pOMEAYXIfDGzR+7BttcBs5qFNn/aZfSgvfvXMEb7nmo01Zyl2/qpSxeEL5AqQ0d88yRpWeQLvJLbrUPMB/Iu+7qOVffES2g6GGZyadpVV9LA6NjWDpexgytcDJAt1zr3mD2lVk235R6cbV/rF8Hey9lndreFMLboipNW/2BiPSqvGW3Aja1A8KE1+SLVOxmo0FrcRa3lq+0RNX7z
X-Exchange-RoutingPolicyChecked: Mmc11goQHdXnh3ghJzDkCvGwm3N5YG+AgocNvUv5qutOCm4eA381Y5cGa0FLZHeTasZmimyB86JpDIE2ChccAZKshqJ3TVQiQ+4Tz9lYaiKZzcmZwmTVgiawfmPl4lVKja0tSwOfpm3kEuY+rXT3krRSNVgolCOzolGtIkecaHC+yCMUFqhlSejuL8041WO8Sl1uRw2w5MvuEwiZ0xxZc2GZj+TtuyUdCiWGjvWxUO0RbhlEdtQMsetlMqM+xjAFNhPe5q7EtrzlMVCjZahewZI7naH90OuQ0LlEJGIVEeGegJkrByyNRfww2llzRNgweKi111oDDSEwXW1oAs5wpw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kVhMRiBoIjT/Q3SBJJe7oXYGxhq3tONVYAcs9ml0ccpvlmMiRt3eiymp2/j2U3vX/9o9n+LjlJIftnW4RJgkgCDJcic8bzkmGOGm7TwXrOKH/ANPg+0wcaiEmZpgiqYqU2Jrf9YIZ/CF+P/64WpQwiy+llFcHw1EQ5f4arKmtWsG7BIskNG2kQ19A7lwehapL8YEhDsOK6/vKjN3xIAi7ckePvaPKPeCstenQrlrHWsbJqtnfzxVOEPRsjUt8P+CSXft9BSwOg6spOLLgTplRZRV9Gj0P46sVL56L0uNTZnVxc7GB6h+ipF3cTAm14l14IJxvyBhMJPEy3r5maKS1oGjt3emg9ooEFsElR0mfNY7kIHNG+NG370xsrLVOCZ59Gc0fJNkGi4UzufKn44UIjnvOaAZx+qCFjtDxpEmKASnmOpmhnIq4X6ypFF6UvIQOnsSipEaaKWtB+MavgSa4w1BmNWlFqGdQ5dLmkEyiYQ4J37L5ZGr39py5U5kpbGogXIgiWhy/oZeCf8IOCYz/66O/nHQQTZZXtB3kxen38sbfQCxh+8USs9rv3rBbt2Fpe9A68nKM1BPFzjdWRzEzgHLN+lDR4tjPUZ2qIRPqseEbO0ISYrsuRmVfaV9SlveBJi6h1C4F8La4piLdfoiJw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:38:31.1919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04003db9-4bba-4535-687d-08deed4cc51e
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR16MB6861
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2OSBTYWx0ZWRfXwjy2KURADnjV
 WaJ7Ou76gAP2WwlmgWA8Qck/qBXPCLW1HF8wEhcpMfT/khWyHv8Aqqd6sxwW5j62fX6N8p3Eew9
 d5i0HoU5Viriw7wbAgrJh0zu+vEgJP6w6Cd/nCXludwYAWHnL9Ro/5AgahqWIQQzwRIvruICZ3c
 ZY3xC/zhtxdzA/w0jc/eS2KfDsiVf7f3xDjxg07HCOVh1gkgUk2qY1hE2HzHXPjnvZ1rwkbVXaI
 0xz5L1C2nGQ10KeiltI91lHjLJpmvydQCDZrx9tAcMZqgAaJttnA1+RBgnXNv60ZDQa3KZ7rW/U
 5AqaUqZB8k4VCs55h0BtmhFOtpf642L5/6t8wGVPa6pS9hxdmOSWSMU9VArQ97uVoqqzQR7+Nt0
 O3WuRCUp8/CH5Fx0D8McGQdfsC8gB59AKhEizzI6WmlvQzQkK6LscV9D9/k2bvqQ8U2YQ30ke+5
 4hwPUdsukXaDa/SPlBg==
X-Proofpoint-ORIG-GUID: WZJjMP2ktzgEspq7ccR7nmJsfawfoVXE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2OSBTYWx0ZWRfX1GdAKGRG7VBf
 c1p3goa0F4atjr/kVFrMtpOFlbugBYn7R0qxHEHaJXKbsX+htPEa/PzYQYrptv24PNjzkY4d+/F
 osCAuDfnIwbnfQSeAIQ/3Iy6wUhIxp1lBxb8NihjPnT60fagbjlx
X-Proofpoint-GUID: WZJjMP2ktzgEspq7ccR7nmJsfawfoVXE
X-Authority-Analysis: v=2.4 cv=bfxbluPB c=1 sm=1 tr=0 ts=6a69bc0a cx=c_pps
 a=Sm015RFco05wDkMfClhrzg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=QA4VxX-MxNer2SznsEgA:9
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290069
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=kMUDTzfUjLKLNaQRDs24+qd27
 9fHi+GcdF5GUPip1Fo=; b=bYBCqZFTSsErEr2m6OL7Pq3a+PZeWt8iYRXCLsbfq
 pMrHcGd2jUvO5+JD2I+NN0S1p2BuG2OQUiBdukEY51rjPEGWZFg6agRbBllwZftT
 XJ6mShAasOQpni+VeGknbcstUqQ/EJQgXUVgOCuDN6Gl0MZCUDBkUTuxcVsUZ+m3
 VQ6s1ZYKlesLX0xw6btQrKaJ7KG2/kE+BXyqp20FIV77ADrLyCGV1SF0RNy4hj62
 4DK4Ls+3eyYkWjqrz9zvi+An70fel3LXLX61Ispg7ZXmU6l+Z75vCJECSInP4SE0
 kjiJR7WZDHr9I2ubptbDnTkbgBx4ZTx/3WKHRfbjkP9OQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMUDTzfUjLKLNaQRDs24+qd279fHi+GcdF5GUPip1Fo=;
 b=W1zo57kifoRZ9tMFbT/8Rc7fLc8JMHfsYZW4lIzieJn8FiXXHQ+1xhagKshWGWoaQM+ZHvQHKE7ToJJdpMh/dai1siCE2UcCfsDPwdlZz0AHk/RPn+BbyPnPi/myufTfjGYrph14e+d7qXGhtWKig2rfl1t+ZRIu5C0oCyVkOe4=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=kMUDTzf
 UjLKLNaQRDs24+qd279fHi+GcdF5GUPip1Fo=; b=GG0DxHnDjUbWGkUtYzmxAO0
 eevkFhkBtIS4mRs7AECfW/CKEigSQyivsNMMY4gK4V/bJhYJxXn0eOeXubXE9Q7K
 maI6Y7TfENS/fWPmxWc/gu6Rgy9BM0H6AGNw4BXPhwbIo9f8vFZM2ex0LBFQml/I
 sxV/gnE1iblO8EoNIvBt/0wlfbUNXx7bQ+Tl2GrBeWJq1jW2gEJJS5nlvP3Tshwa
 uBHI7ABR4vUwbB7CV/+TAFX11T5Pbwiq3CzMxTU7ZjuAMj5NOHlxyJXEXT6WvAD3
 3fsR+h/lcXG6uFz9+gOYH3imMPmxFAQ4YgEvaen9C7+ttEAjkKX18mo62uGjJRg=
 =
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=kMUDTzfUjLKLNaQRDs24+qd279fHi+G
 cdF5GUPip1Fo=; b=Oby5qmUXUXf6VOfaq1Nyp4vTucxrLxl+OxHGqb6YZzYQXBV
 hMKN+zCvtg5wEx0onGodvOK0wAhJhAx9Zpl+NX0WHz9Zywtln/at99ZzB2d68br1
 BKps1gP/OOMJBHXtz536dAPpCbgK6fqpdMpC7Nx0OCBCl6GGjyXGTbR/2g3ItvIB
 jBY/aLRx3jqzWwgB4cFRuYEXDPH+0/cIrGURGg+Q8mbHcILV23FmTy+M54C3PfG5
 pBAqFNHkJMoMAhamz0oPT/kZ1EpvA9rtBdcBYlKrMxZO/s5FAJ+YicdLAMQr+E/U
 HrW4tZCabGMMSwtfKW5zLMvwXC+Bdz4xQ+MKWcQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=bYBCqZFT; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=W1zo57ki; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=GG0DxHnD; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=Oby5qmUX
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

This is small cleanup series for x86 reset device driver.

Patch 1 introduces a small fixup for the x86 reset driver.
Patch 2 introduces a small fixup for the x86 EFI reset driver.

Denis Mukhin (2):
  reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
  reset: x86: Use cpu_hlt() in efi_reset_system()

 drivers/sysreset/sysreset_x86.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.54.0

