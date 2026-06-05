Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78395CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6058984A06;
	Fri,  5 Jun 2026 05:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="jce/yTU4";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="EPkCwtHo";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="ifSLk7ff";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="N2hxRNb0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92300849F3; Fri,  5 Jun 2026 05:39:29 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51EF784999
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Jq8eA982361
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=A9Q
 HHHkGvAunf8s3bB1TVPM9nIKtz0quTIXNGC8ghsw=; b=jce/yTU4T+NaaKSMQRw
 eqCaOJJlfbfGG6zsdgtxWYH5N7IopC88GnDWxwT+zfBIQKeaBBr+2JcIPY4gYaiy
 HGQjIRxNU3ZdMm/AjD582UpnmhgvukYu0mZgnJk/yuELUAyh1h64YK9WqU7AXO+e
 iTZX6k08UYxgAD0KPupa6ppbIl2/hLQ8UTZQKeoIWuyHqP71mIh0Ex+GpiKbuz2a
 kkyydfxGi/yvm1eo6GENM1Vc25JVVwki1dqBZCqQT8sr9TKDoFkdTB5Nz5K4woCa
 Xjo1G9ySfa39TuIZ8sMs6BSdee7K3DTfjgGT1N0/UV/aLQjT504a3C1ZipSWa9fw
 XWg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekfw6jgsa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQZO0uF0NNN6JzKAeXU1e7dujXBG+k+j5eLVPUU/AdAX7fl7Vne6fBisUMuMqeDWwwsKf8+maaa5o1b+NwztQOfLKDFYjuAMPlqzLSCQlJBZoP/jQ4+P/sRORZb7Or4VHQ417uPpDt2YKNqdmjjdGrmXOwBBjzzouSEr9WotUFYVHjLoDhYdA0V8Gu0sXb83uyHDvvQA4WnXz2OFhcOEMS6opOYF/dwy7U+StgAO8enTNWtasJhsiu5XnpnCCbMZJn9Uv+WZyARY9HGAJfCaZCpJiV+wbkaDjVRn5Trzlffe6UwtlOfr05GT3LDBlK3C3N4qh+q4EN6WumtVsnKqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9QHHHkGvAunf8s3bB1TVPM9nIKtz0quTIXNGC8ghsw=;
 b=xiCn58+VoYlMr8rY8aADnkWV1D5kWjwxW8DiMtkqYmXI1qDzWisOgvdb8vZF8hWAt627npVhr1pIU4DEpPn2rkyWf7gAOMwh2JyZt7W0oOtn/hzkKq2UjAP4DE5eXTPH54++OcEzclGOpHGWUA/CGFLx/I7ghK88yiLw/sZuMH9DDTfpD4acuuSc0zdtQTpkIHapfrD8HCXoZQQOlue+x8BFGyBY3RND9KD9GK8AIVHFtn20BnHLfPNwIuC0rdCDX8Fg5rGkg0++A5Y8/RVXjSMujNN8iCdph5uYPmxulIpFcbo73RpZO7lCjQ18AQ9ILkgEBp5Lkv98BMgfBoIF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9QHHHkGvAunf8s3bB1TVPM9nIKtz0quTIXNGC8ghsw=;
 b=EPkCwtHoK4A0H9XY9S2CPOsvisUXNOmpnHeDajsrUCjjGXRC35qedEkuLHl0S1fWkEyNGSFuW81472946J7xTYojS/ZpiUgC4yxKEQXjz/Oc5xCE0H1LtPSENamu8bK/YOjBZ7J4grYKp77j44r05BFQMtCT1AX2sNagu9+DrZY=
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by CH3PR16MB6417.namprd16.prod.outlook.com (2603:10b6:610:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 5 Jun 2026
 03:39:21 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::41) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:20 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65532fFc1071552
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=A9QHHHkGvAunf8s3bB1TVPM9nIKtz0quTIXNGC8ghsw=; b=
 ifSLk7ffqTsU5LMWwtIFK27RO5rV6aErDBPAf0DfbyWP9nDE4Nf0ldU3efpTi2rS
 6gJNmYxFtwkfTQzNsZv5OFQCxJ+jo3lOC8vfbHQ+H1Hjo2K0QpJmwU8mBlzV2AAJ
 KABV6p+YnIldncbEM88ZQHQtexCqk7fpIx0+96eEL4qTXITy4yfH5kSJiK419j4X
 PdIpS1wYwngX6Cubz4GX6GEIL78AHDWTKdprZ0Re2sxmJnL9wRZ8vb12hLbA4Wms
 lM00P4dbeDcMxJLyYFbVyA45SejlXPD0ebnOWLGBdSD+6GYXgSvrFOgraxXcq02a
 vKStJhtlhw/3Ht1YcqdmNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=A9QHHHk
 GvAunf8s3bB1TVPM9nIKtz0quTIXNGC8ghsw=; b=N2hxRNb0A3J8BTgwqCRWBLU
 aFkJxd7SwIp1ojhLiHiVjKU2mvEIQ+5W70cKSoPJud2aZA6FTrWO11VpJFRYmfwA
 3sZzM8DAM/iwXko+nAjrLckUlPypmpoKHBuvmluCgWQfTa9byOZZfd7HtmkCELYY
 62SuZFfEjmIVX7F0ZIewDit3B8VEbhnl1UKc3+Ez1oRlJePqz/IErLk16jknxEA3
 9+83gmPxcZ1JsmweScLjQCMg9bqbGHqQNzdhIZZ2EkHl2Fc1vJ/UoWzzT4GMiRwr
 9SmX+xlDqtvD0sQbhze+c+9ndNKz0ryvAo6ib7vVzYo9JXsNB6YBaId4+P2knbg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd91tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:19 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id VLOuwt2aWba3bVLOvw84Qu; Fri, 05 Jun 2026 03:39:18 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLOuwt2aWba3bVLOvw84Qu
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 3/8] test: disk: coverage for {read,write}_disk_flags
Date: Thu,  4 Jun 2026 20:39:02 -0700
Message-ID: <20260605033907.1909319-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050030
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|CH3PR16MB6417:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d57a1ece-1b00-473a-dab4-08dec2b40748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|11063799006|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: EvmN6GiBOqeV/D7XVZ5bnavBt1IHP8fp6+YZCeE8sGqnTThAXIRiHbIm2XvJ0Yq7QclVTAv1OqimFqgZ/ciqUy1HVmhYMMejQstKaRacRqhhKYyb/b1mbj7Q2uJDeo/mNDrxYXRR7/eeh+h86V/nKn7LlE56Z0vrhHIaSwcuUyRwBhg+wtqkk8jB/eBOt9Mr9warYU3iwJStpn+/keF2cLrUO/tR66To6xJwl4fsEGpLxozccbioAdGe5UtoiPmIW+nHrUuNVKAPp3RkdHLgLSVapgQTn8otpFQpYpO52FAYHIlquxCojMPgGrYAY2o+AKYvVxbUMSSewFuzDxWXFjepVzykrHLpX2FOzcdssC+jZ+4xWMvmNtvavR0GVD3IjmnJ9/ZihSMUp+xH2RcD6YsBL7Ewfafalpo//ek59A32u6KKaGZwj5yV/TTChf6mRo0jo5hLmD0LW4gzqI1hfhczlHKhHn1tFjZIpeLEAGuinU8jGAghZlILRGpCOGkeP5A0EJ+glAGGaydwRs4DHODnsTm3rv/ixUJbJCdc8V+fyXbVw77kyImxLVRVwMlWEuNN3lZtH/jopKQphnabKmkz540IzA2uzR/Lkx2ZHRhs1WjAqIn4/RjA8scHvzAXM+5riHcR5yS7HEuOfW6q0meHZcfPecZ0OK7DY+KTiQFHcnUzfgiZNssXji2Ltr5gxlF1i8uFS2rOAojUErpfm+Bvz5RgNjZBlsDmrxCyHzE=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(11063799006)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u58aio3vKCYtY7IXbugqtcbZ3yPGD0WuFEXqx3il1Kz0GEm/kPsmYScTlM85dZFlo8YJ98fdjjx//lXII1Wx5zpLfa026wwwpKv0KalBr4/fAOS4QX+3fU5jGdSAKS5fyjaEtNULEXAgUq+xUJAczb9YJgkjvPFRR8xyHGwvB7ePUYbbQudkNggqXVIivpM+SxZ+saPpoGg8bSkaY6A2Lsd8Z7pRiH+78wIu18vDZMjCLn2erwW3sgqfW+ioUTa8r23vtSo3j/TPjCgn6wZ7ZbZNWyCcSPiFOp3SOGJ+yBKyXW0XJSZjqSXDt20pF0BzzCb6F/xr78uQGwJHPKpNlMc7DWdjehhJGQLkdm9UY+a3cq0v2DDh9NosDvGDAtgnGfPpril5uqKTUJC+hsCPyZ67nFE2JK70bnP/V3R9R/L4LsnseN5lVmOtq305MpyB
X-Exchange-RoutingPolicyChecked: C4rjALpgy1Ked2AQqGnL8zFLjImSZ+CoXqJeqK5l92BTOFs8+tREKOzBkG8YCDTLZJt0t06DQWsC8AGHy2gR7LSGb/9/TQBnLA7GfpfaiWt4KnlUXYclklOEKSS0my4s6HA2O4MANIw/o6lK1KcA+4k7YKmbQbupLjB3R0XAXDZXiaw2uGJlaIwT9dZ1+mDf75LG+RdylKv36d0Q6hm+a/6sfhIVUmDB2+jhkdFeYYgUyjlK4EaTCouLIbKWyX+cXawShgK2Yt+OxbBo4rQCqDqpup4lSZ/cz++NPvm15twdbU8Unp+XD4KWQnau3x8ogIPPpAJ/UOq9fOt/Nv2ONw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0sLxH7R2hPBF/4B7hrbeRJavPpisTJVBFYktmVz4SAZKjWN3k9wJt3lrHV6Z9VsuD5+CZprLViKf9mqlU1kT2iumDEYAnRf2r74+PkGAZ+OAi493fNEk7mUCMyagUTtIMcI4snseqXoPb31AKb0o5Y3wbRLZlypk0yEVVrC37WQZW9OeJkNPt/SXsOAdf1KcDxpkuBqWx9CFaBbMmHPXXc4tZhUepUuMT+hDuXwnPIhSKAzRFsuAMwaLd2eX8d2j9bNPwK56+5Z3r9go/WvRR21kwWoMQfUe7qO8eG4YlePfUtHHHZ4VHvVZgbmUGjWxdn6Xhjws0S5tnXOUdaLnDQTmuhZJobneF0nkEWIpHrD3tIu9F+oT0ka+AAv9qRIxW3de/9KkT1hq9yYG5zRXleL8PBDjKpUTwN9yQQF5EmH/1d7ko+b6s8okgS50xboQJk0PNbrX5a98Lj7t6DuLPpyWqSPJicZyHjxPg+X9qhaIrHBUuHGPigAqqtUJ9+XmFZg8cqu70cq42M4J0Ki7Dad6Fh+cadwOFCIXxu79IihgAoI+yt28JM9UU4TRrdc69raa5JSpG52pX+vcGSr1+o1vKLRSTkbGrhimmgDCdYSRAN4em8nroL+catVt3/Dm
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:20.3105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d57a1ece-1b00-473a-dab4-08dec2b40748
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB6417
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX1ELicyVxmfLn
 LqfMaLrO2QzMBA3RW1+pKgqht2nsQ/ACIJtEWsO/iH50GeW5hPl0hxKCC3+EXY28fZTiRSM46eS
 z9llOmCBbi/9bpxo9KOGBItJNsCDICiErxQchz6kWs6g60xHO20kcOikGQnV1YpDrdOXo3gTlS9
 GgSxUcQ0ob26bAxrTNFefv5xN8gx5Q5hvjx3o0kVhWOfBQavI+EuSE3dRF28QN7NlGXEvDy6/gS
 G8wcG2d1okZCdwBRKf4sdyGo9yFSbIwOKKLHWhVbKS2hjUubl6+Cd9q8biuVq9L5JDQf4e2w6sh
 wEQSdCaNF8VbVdhC2OIFWDG/xf2YT4dY5z0+7qqzOUBc/5yKoFgi3L1xexlfDfFkkpOnmvyr+Gn
 8Py5Xj9mvQyWh0F3oEBPLBmgGkDaEGJJRUr8N27f9QGGeqRg5nWbz7RQF3kCl/o6Q5Lp7K+xXst
 FktuGhDG8+NR53pbxXw==
X-Authority-Analysis: v=2.4 cv=A41c+aWG c=1 sm=1 tr=0 ts=6a2244ed cx=c_pps
 a=L+VognwtS2MEOC44XfDnJQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=cbNQJ9GKAAAA:8
 a=UhcxLawx-ZDq6oVTmBcA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: hntkVvMaziU6UbR9N1G3Qf_HnAPXmaUn
X-Proofpoint-ORIG-GUID: hntkVvMaziU6UbR9N1G3Qf_HnAPXmaUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 suspectscore=0
 clxscore=1015 spamscore=0 impostorscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606050031
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

Add unit test coverage for GPT flags functions.

To run the test:
  truncate -s 16M mmc1.img
  ./test/py/test.py --bd sandbox --build -k test_gpt_flags -v

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 disk/part_efi.c     |  12 ++--
 test/dm/Makefile    |   2 +-
 test/dm/gpt-flags.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 6 deletions(-)
 create mode 100644 test/dm/gpt-flags.c

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 6d5520e53912..9d94c1bd4efa 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -47,17 +47,19 @@ static inline u32 efi_crc32(const void *buf, u32 len)
 	return crc32(0, buf, len);
 }
 
+/* Public for unit tests. */
+int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
+			gpt_entry **pgpt_pte);
+int is_pte_valid(gpt_entry * pte);
+
 /*
  * Private function prototypes
  */
 
 static int pmbr_part_valid(dos_partition_t *part);
 static int is_pmbr_valid(legacy_mbr * mbr);
-static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
-			gpt_entry **pgpt_pte);
 static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 					 gpt_header *pgpt_head);
-static int is_pte_valid(gpt_entry * pte);
 static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
 			  gpt_entry **pgpt_pte);
 
@@ -1168,7 +1170,7 @@ static int is_pmbr_valid(legacy_mbr *mbr)
  * Description: returns 1 if valid,  0 on error, 2 if ignored header
  * If valid, returns pointers to PTEs.
  */
-static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
+int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 			gpt_entry **pgpt_pte)
 {
 	/* Confirm valid arguments prior to allocation. */
@@ -1316,7 +1318,7 @@ static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
  *
  * Description: returns 1 if valid,  0 on error.
  */
-static int is_pte_valid(gpt_entry * pte)
+int is_pte_valid(gpt_entry * pte)
 {
 	efi_guid_t unused_guid;
 
diff --git a/test/dm/Makefile b/test/dm/Makefile
index d69b0e08d66a..df2bc28078d3 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -82,7 +82,7 @@ obj-y += ofread.o
 obj-y += of_extra.o
 obj-$(CONFIG_OSD) += osd.o
 obj-$(CONFIG_VIDEO) += panel.o
-obj-$(CONFIG_EFI_PARTITION) += part.o
+obj-$(CONFIG_EFI_PARTITION) += part.o gpt-flags.o
 obj-$(CONFIG_PCI) += pci.o
 obj-$(CONFIG_P2SB) += p2sb.o
 obj-$(CONFIG_PCI_ENDPOINT) += pci_ep.o
diff --git a/test/dm/gpt-flags.c b/test/dm/gpt-flags.c
new file mode 100644
index 000000000000..2792597da021
--- /dev/null
+++ b/test/dm/gpt-flags.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for ChromiumOS-style GPT PTE attributes.
+ *
+ * Copyright 2026 Ford Motor Company
+ * Written by Denis Mukhin <dmukhin@ford.com>
+ */
+
+#include <dm.h>
+#include <memalign.h>
+#include <mmc.h>
+#include <part.h>
+#include <part_efi.h>
+#include <dm/test.h>
+#include <test/ut.h>
+#include <u-boot/crc.h>
+
+#define TEST_LBA_COUNT  48
+#define TEST_PARTNUM    1
+
+int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
+                 gpt_entry **pgpt_pte);
+int is_pte_valid(gpt_entry * pte);
+
+static int mock_blk_desc(struct unit_test_state *uts, struct blk_desc **desc)
+{
+	struct udevice *dev;
+	char str_disk_guid[UUID_STR_LEN + 1];
+	struct disk_partition parts[2] = {
+		{
+			.start = TEST_LBA_COUNT,
+			.size = 1,
+			.name = "test1",
+		},
+		{
+			.start = 49,
+			.size = 1,
+			.name = "test2",
+		},
+	};
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_BLK, "mmc1.blk", &dev));
+	*desc = (struct blk_desc *)dev_get_uclass_plat(dev);
+
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		gen_rand_uuid_str(parts[0].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(parts[1].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(str_disk_guid, UUID_STR_FORMAT_STD);
+	}
+	ut_assertok(gpt_restore(*desc, str_disk_guid, parts,
+	                        ARRAY_SIZE(parts)));
+
+	return 0;
+}
+
+static int test_gpt_flags_default(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+	u16 flags;
+
+	ut_assertok(mock_blk_desc(uts, &desc));
+	ut_assertok(read_disk_flags(desc, TEST_PARTNUM, &flags));
+	ut_asserteq(0, flags);
+
+	return 0;
+}
+DM_TEST(test_gpt_flags_default, UTF_SCAN_FDT);
+
+static int test_gpt_flags_some(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+	u16 flags_in, flags_out;
+
+	ut_assertok(mock_blk_desc(uts, &desc));
+
+	flags_in = 0x0111;  /* priority=1, tries=1, successful=1 */
+	ut_assertok(write_disk_flags(desc, TEST_PARTNUM, flags_in));
+	ut_assertok(read_disk_flags(desc, TEST_PARTNUM, &flags_out));
+	ut_asserteq(flags_in, flags_out);
+
+	return 0;
+}
+DM_TEST(test_gpt_flags_some, UTF_SCAN_FDT);
+
+static int test_gpt_flags_update(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+	u16 flags;
+
+	ut_assertok(mock_blk_desc(uts, &desc));
+	ut_assertok(write_disk_flags(desc, TEST_PARTNUM, 0x00FF));
+
+	/* other partitions must remain zero */
+	ut_assertok(read_disk_flags(desc, TEST_PARTNUM + 1, &flags));
+	ut_asserteq(0, flags);
+
+	return 0;
+}
+DM_TEST(test_gpt_flags_update, UTF_SCAN_FDT);
+
+static int test_disk_flags_invalid_partnum(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+	u16 flags;
+
+	ut_assertok(mock_blk_desc(uts, &desc));
+	ut_asserteq(-EINVAL, read_disk_flags(desc, 0, &flags));
+	ut_asserteq(-EINVAL, write_disk_flags(desc, 0, 0));
+	ut_asserteq(-EINVAL, write_disk_flags(desc, 255, 0));
+
+	return 0;
+}
+DM_TEST(test_disk_flags_invalid_partnum, UTF_SCAN_FDT);
+
+static int test_gpt_flags_headers(struct unit_test_state *uts)
+{
+	struct blk_desc *desc;
+	u16 flags_in = 0x0111;
+
+	ut_assertok(mock_blk_desc(uts, &desc));
+	ut_assertok(write_disk_flags(desc, TEST_PARTNUM, flags_in));
+
+	{
+		ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h1, 1, desc->blksz);
+		ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h2, 1, desc->blksz);
+		gpt_entry *gpt_primary = NULL, *gpt_backup = NULL;
+		u64 primary_attrs, backup_attrs;
+
+		ut_asserteq(1, is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_h1,
+		                            &gpt_primary));
+		ut_asserteq(1, is_pte_valid(&gpt_primary[TEST_PARTNUM - 1]));
+
+		ut_asserteq(1, is_gpt_valid(desc, desc->lba - 1, gpt_h2, &gpt_backup));
+		ut_asserteq(1, is_pte_valid(&gpt_backup[TEST_PARTNUM - 1]));
+
+		primary_attrs = le64_to_cpu(gpt_primary[TEST_PARTNUM - 1].attributes.raw);
+		ut_asserteq(flags_in, (primary_attrs >> 48) & 0xFFFFULL);
+
+		backup_attrs  = le64_to_cpu(gpt_backup[TEST_PARTNUM - 1].attributes.raw);
+		ut_asserteq(flags_in, (backup_attrs >> 48) & 0xFFFFULL);
+
+		free(gpt_primary);
+		free(gpt_backup);
+	}
+
+	return 0;
+}
+DM_TEST(test_gpt_flags_headers, UTF_SCAN_FDT);
-- 
2.54.0

