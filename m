Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3AC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 19:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5519740912;
	Tue, 18 Aug 2026 19:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgQEgNLyyG_z; Tue, 18 Aug 2026 19:06:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787079994;
	bh=LQ6N+Q1gcwRgM84CNwgcoz7VV1svlM5K/jKoHBAJM0s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VQYz5RYGir1XbrDtlRY5bnLqBglvtDQKkLvjn3B08aZRn7GvsCUdWOaZtDHbHXH4E
	 ydqR8/dfZOzWcYYlrNg6uGsUPxemJ0fqBe+xqYyOEb8/PBzjaG2FRLIEi+z5rCE+XO
	 Jv5GUb+KE4C65qM9Wb0EPwOFuCp0IOC80Y3RMPh/o8Lu4b6l2By8S1q2nfYyv1vORR
	 7SgCxE+oC0MV+D1SfwF/TNiEpZeWQJuL/YIgKpBZUXmjKJ5QG549iOB2akXjof+WI7
	 hzbHRZQ0IYFmFPS5fbk5ZnoEKoHLW3PhU7ttpnEm5fX+mJ3ERQhJJ0w9cnG5GUz7XL
	 pL2Up32HiO9nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F16940929;
	Tue, 18 Aug 2026 19:06:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E359325B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 19:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C89CF606B3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 19:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcSbqlH_qlMu for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 19:06:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.143.241;
 helo=mx0b-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=YyS9umFv; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=ZFLuY5eU; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=jNOfnyiQ; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=eHmkjfs9
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CABC160667
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 19:06:22 +0000 (UTC)
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHnZeS1242370
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 19:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=LQ6N+Q1gcwRgM84CNwgcoz7VV
 1svlM5K/jKoHBAJM0s=; b=YyS9umFvleNFh/xKLpOhby5Thg0Xhq+2bJhjMHOG4
 7Yw8YElfBk/UWzyHUPgo7csMC69q5hkObQwyPF5ydje49SlEvZeodDrBwsjETJ/b
 u0SZoMImlFYq8Bd9b/pXib07M1zAo+xMQS5az/UPiWc+OXN5fE9zERoLoCuAOCVk
 TsYGTDXbnzGtnqhQkSumS5W8gNyf/bv8XinS0P3VxVCORNtohstyAe+JADf/TEUO
 +AZkHnFMpBQ5VryfTwFQ5TfZb8I+KeMj/OLLfUfYMAsLJopYMspQ5JHI2A+n3/UG
 32YGxFp/BTFSTU1maWOQVK+AzmY5j/7MBh9GcPeDjF6Lw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4g4v4ugw8s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 19:06:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySuA4qbWKvX8+jBiZp42HK2Ceyz+1EjkGw3pMrOhag8zyvso245+lBdhXgiRORlUt63pMff73twEyCFSmO+uWYrTFa2IDmy0QWatcHI3uhygronrZNlLFwQFihCaHcRE8qnLvaBVrnU4CLClFB7H/jm61V5chP5gqtpdXnVxfYSqqGbWPFqVKie9RHi6VnY0ZVNjFKF9+gM0xxFdSyyCAh5nFjFVmQXNu6UBoAPyms/sJ4SV3B4RnlUPiqhBhxC0Y86QjKA4KGn8y70qRtCUJncKnaeDojOPPM8LRyvjGwNQIYDzvVB29/Aal0u6zAzI4z5XKFgRpM4jEB7p5V/Scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ6N+Q1gcwRgM84CNwgcoz7VV1svlM5K/jKoHBAJM0s=;
 b=Ypb1XcslgISVE/RgHpxjXK6QFjDno0/ypYiWfsxlVndejAS7KxNSuWs6ecjRyY7vzpie9kq0sH67Dc7RIfDR8FzR5hQ070qvJqZe/XaKv2z0dLpOG2SFTyZdDJPVGaaOBnFJdtF2fOF6UmlEFY/1VwmG62Nn31Do0y8+VucSMoZbfzInX56ZyqCX4g8hOg0mI9U8iooTWqFZcF89B7nnod8z14TxRlm6yx43I1SOrvmkXxhdYBxU9rtnnrjM3yfAdqt7zb3n9orFrFAyK3ZtoJxJNg8HvXJcWLyXqDkcowH0Bh2k7NokGvf+okU5bM5fklt1hKV+0BhdWj6QfNVRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ6N+Q1gcwRgM84CNwgcoz7VV1svlM5K/jKoHBAJM0s=;
 b=ZFLuY5eUi27Ph+L9E/LCQCgVIrIOD/dp6nfD1qykVD3jJC0lmCWO6sFb5w9EKDnU5wtI+aHefMohiBEwl+yuNcPINBs/llHZxOAlp+CQRuDftrvvDzrvbJi71BLAvzSEzKXNJeY36m8WEMBmGOVJwu1IAh7/doe1wGyi7Dm7PyI=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by PH0PR16MB4086.namprd16.prod.outlook.com (2603:10b6:510:55::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 19:06:16 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::4e) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 19:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.0
 via Frontend Transport; Tue, 18 Aug 2026 19:06:14 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IH9ZPh1937057
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=LQ6N+Q1
 gcwRgM84CNwgcoz7VV1svlM5K/jKoHBAJM0s=; b=jNOfnyiQvr+8SrFCrt17p+V
 9DQlTOm7qatnd3Q/ycmTp11uMvyP5EvKnltbvTlZWegY3iMtmbMieJio8prwaO9U
 oSogd6XXHcxV3OzizXKY8UcZiYYeXcmO+JYJXMhkK3I5cretnLEMNUdRkMNjC5gV
 iBdMpN7GxNgTI7CIu2WcdQ+Xhv8h6dptVK6olHwasSc8jbYg3mw8wUIg1zjnG4xH
 iCxCceYfy2wG9RM+icX9nYC1lSl4Vi8qeuvL6XvJMHYecW4n0xKiYUNazsHpvxC2
 btJCmy5KhBT/lTXBbDiVwCu6QYY19YJFImCS73W6EYYLvHvZiX96+Lq+m7JCPWQ=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=LQ6N+Q1gcwRgM84CNwgcoz7VV1svlM5
 K/jKoHBAJM0s=; b=eHmkjfs9rT5pk5h5K4L1FBsokm8WEepyYSoDdINkxc8t354
 Vi/rElPnz/YCfMfg6cP85f3hBpV7Uk77SDcqFiI9yqt/Xi4ptflnAAX5wc8XTCQa
 lL5mrt4aOsNXqXv8mrNqPfOf3O26gWyycLW+N1gjILAyDN5KOyksFBRjhw6iU2Tv
 61mD94AKLDTvn1jSb8VYXw/aGMl1+jad9f01KjGpqBD5KEnZ1J77CqkWCaf+YV6u
 mHJ/X7wZdTHmkiD9RrFRhk/fbJ8PlSj/HvKEDlM8kN2AiybZOltXm6faH7qS9aPC
 q6wEziYASk/d686E9vJWEss5ldjGmhjWc2dDBZA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4g376rbnum-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 15:06:13 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id wP8VwSPuefYH1wP8Ww1Jvw; Tue, 18 Aug 2026 19:06:13 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: wP8VwSPuefYH1wP8Ww1Jvw
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.u-boot-project.org
Cc: heinrich.schuchardt@canonical.com, ilias.apalodimas@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, quentin.schulz@cherry.de,
 sjg@chromium.org, trini@konsulko.com, Denis Mukhin <dmukhin@ford.com>
Subject: [PATCH v2] disk: update partition type reporting
Date: Tue, 18 Aug 2026 12:04:28 -0700
Message-ID: <20260818190426.3567429-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180140
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|PH0PR16MB4086:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d0de23a-5fb7-49ca-837e-08defd5bc6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: imjFY2C7yrLfbJrkb+FdrSQ7FBhKrhZoLDD+o8J23Ht8GvXRNUtjRjjTTqPkSorBcm5affgCJoUpDh3nRA/PyClwZeo7oQVz+B7wcLzBURmist8igkJbUz+m5BlgvTplRh8YybJxF+8cjyt0lGVV0bzlPc1fuoiNHXqtALCtdnZYydNRh2s148zghUtctZqd9v5+AEWBB9uUU2S61cDIdKWVHaQdbgF1eKMYE8W1pTcsxYdIGXracbl+5j1oxRCwpA0Vnl76mHcjMZ8RsH0QCxLmdgIH4yywqVPq03lf2ls5O+8aVoHjPXlolJTFonTaxuWoTCCNkebivfP7jfnr1G90lBtL9Rgm3EnGebpoMyzxeS7XuhiHvZocJzmeNwFWRCtHqnozsSVdRwYBzmCcYLpp7NX8R/ATyq+nNQ1jNvnsyKU+o4tGb43YGKL1854tR5MR1fkEFI7uuqcSlbhy+0BIAZWrphgvIHgHqnpJvUy66Wl4ojR6jVJ/fKaIgFlD+ZHduotviavGEdptFHJwRVa8rIDJb9KcF8xCVkogE7i/8Pz+kt5OfRmrybE335UvNLm3F2rvTnCQDo43nIBr74PhY09rVfoIKH5D6bokItKqP/jARkKSdXEzVwT7Yk4P2OfplOJymasMAGfiWWku7Hn3AfwKxwjtpoC7YqS7mKLBHBl+laFl2/qe18c6sXgFFocjoQepjzlDzXQ9UlQtZQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CkiHd+slRGt4MKb+GgpJeZ6lPrt2wCqPQhwJ9WgQuQOGGTOoZhFvk3NofyXqykQ1WVo0JznQDHPBqKwBqZlil5yITI6ee4985OU2e5dUVKtYZu8VgTFrXu59Zi+B+oAnkYoMKHRkVCnjiDEDpkUem12U+JbcPJB9uZLoE8VBcaxSDjght5PSEU/GTjC+XK7XyxtyvaqST1nIsxOqxy2fNgerUPETZl67XFGttu24mkNXTlaQdnG1x3fqaeYD22X1Ac6wWPG/M2HpdFs0RDtwUFKJOMRjF5AN+s+6jnXWYqW+93ojikHZocqgHY3ei5ZXHDqIJxYuROAZRO/vX4vDfwDEsn5LzClXqRTy98VtNiluEE1woZT03zK3uyF3SFmbo6rr79ho+TPkTFm0SJYP/kdWLAGelm+R5zd4/IUWH3CUerY6/bbwQuxueZgksbFZ
X-Exchange-RoutingPolicyChecked: fk/fq/GSiYQy/XhzCiEgTXx+hLvqMOW4asrWM3Y3396YmNTY7nLTh7gE9CI+vvqCE3NXPNslqfEtAkZNzUiHVKTyE6Q8DD49ZpzfJ4tldTELeI5upzSpmR7Snvi/gl63ZmuJcmUdAuGx2fF5rYA9idM3E9AAdESck/rGrYKKzx1R4L1ELADA8PkJAuIbFX0/oR8mjA3y+nKHRtk3XqKv/W+RlRFPMzvRYmpHVs6yz5Udy453n8xfYIgQd/uk6ji/JjvJbnuXV4TFcg953oF+7RCEq6RgMp+PJZYoULZWDshO6kjn8YmgrFUV8qx+2X8S0JRHidN9PH4XM4k7sWWAFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aa0CGygh1PqUs+kUZiKdF4k7IseGRqclSvlD1/FnPIk468oLyMsAaV7YKLf06KTcvv17Kb9KNHt/j60fNS8g8iU+FFnFY3xikDIE4BM+6acVxv/XDTSZzUDkbCQBuCzixPlqvF4u4UuaBb/Qb2uh4ZWjWjbXWHBP1263RI1yQ2tl2CQmuJ1+zD5w+jXROeAbE4AhZkzqgeCF2A/qMfgFagT8xoQ/JzxvboeNZlbwE9gYwh8jfglu2+DUoFvosyIuGaovocaQ+pcRqR60jvZrUQWG42FGuuQYNdl6BKIOXR3XKjjqJF2qbXVjPQ5hPT+KBLrTu/vlfhFCU6OU7CKNWQW4s4nAL+0umw+NjbFUu/LCHZC4lBlMpomCVqN4m4yS9y/2kGRphNIbVOAOEB90f7jsb9yDLhq8vp8J8YKBQrrOzQfAZWhJZhOJ1XUOrA4AFQImdNCMjzAByN7piCoaPvpGR0HRFUUHxzvEK7utm8kGcAKBJxl3GJcZs90eHUhL9eVd/6HtHNJ1WAua13kI+uGqJ2tRZtlOBaC4usJzrszl6ZVlt9V0uUsNxCK0FiImTUaExZ9mo4Kvt0iB2c2P7c1YJOHTrMVq5DiKivl5fJGe2MSfPOUyoytsTADyLlt3H3e5is04vK2CImRv0RV17g==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 19:06:14.9972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0de23a-5fb7-49ca-837e-08defd5bc6d5
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB4086
X-Proofpoint-ORIG-GUID: hwyNJ1jqAyiy4mddJOcQL6GJpAs2Fy7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfXzN72yFVdFJby
 dzg+V0JnEzmqs530ERyv4gtpmLjRwu0UgtpMsWLI80qRfU4nEMS9WrygJDO1nYr0DMq/vnYyMQH
 8lTcsZThcQtYMXEvshoM+4mWnBPQNjlufn0C7gVbHPhql/1yn3YFsI3hZhiD2FlN3sVA5p2Fyx2
 /X1j/qQ3XqyqWL7uy0Ua25fEalhFUuZ9ZuSMGy7aUPXTUldKywH9v+PIRLUjs3c2qoRzlLzi7JX
 O7mq/bZiZnQA+F4/InmXdaHdVfd1DwoSn2YU0FuvFkh0nu64u2k9KAeeuhVM+JjRmzhCieGZYW8
 T5jHGV4rjhaMOpkMLiBA44jy3p5uy5zC38rs2u5FdjdyB5FE651JJwEswxGwW70Cxg3BOs9LqAT
 UuWKI2SSTTw/GU0eqSB1k7hoF68zZ/y2uM0LF5aCUOKHK++ELNDYFEznww567HXJGENjMPTcW6r
 JTpBY4g5qLOqILa/c+g==
X-Authority-Analysis: v=2.4 cv=E6j9Y6dl c=1 sm=1 tr=0 ts=6a84ad2d cx=c_pps
 a=1XVf1DeqYCuQPrRRBBNiYg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=NEAV23lmAAAA:8 a=YUneP3UB9ZmWW28UWM0A:9
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: hwyNJ1jqAyiy4mddJOcQL6GJpAs2Fy7j
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MCBTYWx0ZWRfXwUL7V9Die9w/
 nG0ELPko0xyDcnj6Wqk+Uio5Lu4NZlUBxtxT/WjO5AGAZNS8nZyZKyAFT2dyO0ORZpSoPTJSB4U
 UY8ftY7cANqL1iKfCtNchN11yiPwpWuRfNnFfmg4luGg4BQG2Zg9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180140
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

From: Denis Mukhin <dmukhin@ford.com> 

Partition drivers currently report "U-Boot" as the human-readable
partition type. This does not describe the actual partition and can be
misleading to the users of this information.

Update the human-readable partition type from "U-Boot" to
partition-specific type.

For GUID partitions, when CONFIG_PARTITION_TYPE_GUID is enabled, use
gpt_pte.partition_type_guid.b directly for type reporting.

Update the relevant tests and drop "U-Boot" check in
blk_get_device_part_str() since it can match against
gpt_pte.partition_type_guid.b (e.g. "linux").

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- use gpt_pte.partition_type_guid.b for CONFIG_PARTITION_TYPE_GUID=y
- add per-type partition string names
- updated commit message text

v1: https://lore.kernel.org/u-boot/20260730013946.1858341-2-dmukhin@ford.com/
CI: https://github.com/u-boot/u-boot/pull/1036
---
 disk/part.c     | 13 +++----------
 disk/part_dos.c |  5 ++---
 disk/part_efi.c |  5 ++++-
 disk/part_iso.c |  2 +-
 include/part.h  | 10 ++++++++++
 test/dm/scsi.c  |  2 +-
 6 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 4923dc44593c..0661394d2e5d 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -383,7 +383,7 @@ int part_get_info_whole_disk(struct blk_desc *desc,
 	info->size = desc->lba;
 	info->blksz = desc->blksz;
 	info->bootable = 0;
-	strcpy((char *)info->type, BOOT_PART_TYPE);
+	strcpy((char *)info->type, PART_TYPE_NAME_UNKNOWN);
 	strcpy((char *)info->name, "Whole Disk");
 	disk_partition_clr_uuid(info);
 	disk_partition_clr_type_guid(info);
@@ -475,7 +475,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	 * host's own filesystem.
 	 */
 	if (!strcmp(ifname, "hostfs")) {
-		strcpy((char *)info->type, BOOT_PART_TYPE);
+		strcpy((char *)info->type, PART_TYPE_NAME_HOSTFS);
 		strcpy((char *)info->name, "Host filesystem");
 
 		return 0;
@@ -493,7 +493,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 			return -EINVAL;
 		}
 
-		strcpy((char *)info->type, BOOT_PART_TYPE);
+		strcpy((char *)info->type, PART_TYPE_NAME_UBI);
 		strcpy((char *)info->name, "UBI");
 		return 0;
 	}
@@ -645,13 +645,6 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 			goto cleanup;
 		}
 	}
-	if (strncmp((char *)info->type, BOOT_PART_TYPE, sizeof(info->type)) != 0) {
-		printf("** Invalid partition type \"%.32s\""
-			" (expect \"" BOOT_PART_TYPE "\")\n",
-			info->type);
-		ret  = -EINVAL;
-		goto cleanup;
-	}
 
 	(*desc)->log2blksz = LOG2((*desc)->blksz);
 
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 4e1d01b2f21e..2336321dc77e 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -273,8 +273,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 				info->size  = (lbaint_t)get_unaligned_le32(&pt->nr_sects);
 				part_set_generic_name(desc, part_num,
 						      (char *)info->name);
-				/* sprintf(info->type, "%d, pt->sys_ind); */
-				strcpy((char *)info->type, "U-Boot");
+				strcpy((char *)info->type, PART_TYPE_NAME_DOS);
 				info->bootable = get_bootable(pt);
 				if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
 					char str[12];
@@ -321,7 +320,7 @@ static int part_get_info_extended(struct blk_desc *desc,
 		else
 			info->blksz = DOS_PART_DEFAULT_SECTOR;
 		info->bootable = 0;
-		strcpy((char *)info->type, "U-Boot");
+		strcpy((char *)info->type, PART_TYPE_NAME_DOS);
 		disk_partition_clr_uuid(info);
 		return 0;
 	}
diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91a..de7048639a6d 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -304,7 +304,6 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte));
-	strcpy((char *)info->type, "U-Boot");
 	info->bootable = get_bootable(&gpt_pte);
 	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
@@ -316,6 +315,10 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 		uuid_bin_to_str(gpt_pte.partition_type_guid.b,
 				(char *)disk_partition_type_guid(info),
 				UUID_STR_FORMAT_GUID);
+		snprintf((char *)info->type, sizeof(info->type), "%pUs",
+			 gpt_pte.partition_type_guid.b);
+	} else {
+		strcpy((char *)info->type, PART_TYPE_NAME_EFI);
 	}
 
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
diff --git a/disk/part_iso.c b/disk/part_iso.c
index 6e05b2feffba..7b4e61f2099e 100644
--- a/disk/part_iso.c
+++ b/disk/part_iso.c
@@ -135,7 +135,7 @@ int part_get_info_iso_verb(struct blk_desc *desc, int part_num,
 	/* the validation entry seems to be ok, now search the "partition" */
 	entry_num=1;
 	offset=0x20;
-	strcpy((char *)info->type, "U-Boot");
+	strcpy((char *)info->type, PART_TYPE_NAME_ISO);
 	part_set_generic_name(desc, part_num, (char *)info->name);
 	/* the bootcatalog (including validation Entry) is limited to 2048Bytes
 	 * (63 boot entries + validation entry) */
diff --git a/include/part.h b/include/part.h
index 15daacd7faaa..6fee58b290c9 100644
--- a/include/part.h
+++ b/include/part.h
@@ -31,6 +31,16 @@ struct block_drvr {
 #define PART_TYPE_MTD		0x06
 #define PART_TYPE_UBI		0x07
 
+#define PART_TYPE_NAME_UNKNOWN	"unknown"
+#define PART_TYPE_NAME_MAC	"mac"
+#define PART_TYPE_NAME_DOS	"dos"
+#define PART_TYPE_NAME_ISO	"iso"
+#define PART_TYPE_NAME_AMIGA	"amiga"
+#define PART_TYPE_NAME_EFI	"efi"
+#define PART_TYPE_NAME_MTD	"mtd"
+#define PART_TYPE_NAME_UBI	"ubi"
+#define PART_TYPE_NAME_HOSTFS	"hostfs"
+
 /* maximum number of partition entries supported by search */
 #define DOS_ENTRY_NUMBERS	8
 #define ISO_ENTRY_NUMBERS	64
diff --git a/test/dm/scsi.c b/test/dm/scsi.c
index fbc36a742446..fbf4d1000a10 100644
--- a/test/dm/scsi.c
+++ b/test/dm/scsi.c
@@ -30,7 +30,7 @@ static int dm_test_scsi_base(struct unit_test_state *uts)
 
 	info = &part->gpt_part_info;
 	ut_asserteq_str("sda1", info->name);
-	ut_asserteq_str("U-Boot", info->type);
+	ut_asserteq_str(PART_TYPE_NAME_DOS, info->type);
 	ut_asserteq(0x83 /* linux */, info->sys_ind);
 
 	return 0;
-- 
2.54.0

