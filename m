Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7F9CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 06:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 881288484C;
	Tue, 16 Jun 2026 08:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="XzhKXsgZ";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="NCRTXVGn";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="PptHNeFj";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="YP4xl5n+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46CE8484F; Tue, 16 Jun 2026 08:36:18 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5943584704
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G640bH1372676
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 06:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=iQDEU6rvYXA9RuM7vmZC2g7Xq
 MUTQqP11/dmMYhDVG4=; b=XzhKXsgZPMeeI26+7hmkkcQJi/fwafyShFTzLHq0s
 dsSTs4FGECqJl56Du/lTGC4j2FvxFraDDIM9ZQZnNlhT6H5RmoW7vYH9Oec32iON
 mArAnyHM2rZQhLE4+dIMbUhn7QbkCfVRUMNcD+Lbg0eyVau3HBvtus/WgTwL1EC0
 UF9hxW0kcLor9mJs6rqCG9MnQTCCtz7ac67D8WNlFJ0GqAMF/oYOzRL8po3laI0x
 7i5b5UeQSd38vMUPt6WoULh6a5WK7YCy3za3alLhKIj4i9sfpxDViyTTAgyXFnBl
 UsoWnBMtLwrbXflGmkuolHIwVoMaWmHSbRYBBn4+AXWlw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4etqb8v5ja-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 06:36:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4rU2rEydaxzsAREhA4TQByraAADUWpaj1X/hKryQG5001FKja0wzudhX/6vKIydZxbnNujzsrtjMk9EOIupbUp6uqKyK8NJ/GuoY88SNpoCkkXjI2+OYU/xv499a5mRNva+yJorm8xlCxbKE4Ak7TYkKgSDeF6X/r99Jg4+c0dSkMyr7V2DfQSM51AoUeVryXFrNOjKqTTZHLcG+Cg9nSmw/ZUhfETMe5NLJjDywcYZ801zB2wgIuDtw5xTpQSjm70x/q0Dwh6rJDmrTrPunRXO35qxJh7gFZAlEen3i8Vg+qpCX5W3hR15/RchZT2TngGhqU0qt27Pxopo8VddnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQDEU6rvYXA9RuM7vmZC2g7XqMUTQqP11/dmMYhDVG4=;
 b=RtUd9JCQKZvfS2FR7p+sp/1vD+yGEsGTLZQGISgE8ZfExg96tPwArU3sW4naCMluKb9sWkkx1PBS4vdnLWEAXVcesAm/xeI8FstWAofsx+pEkdgPCKKQ15eOOd+8mq5Ks/6hwcqduZGs9rnLzO4kaAmg/OneXcv05jZi20TmigT2t7z+XLGlBQkuDMwiT/ujak0FOH0p1Ov4Mxm7PAR1oF1VXPjJFUeZ6fSD5nNxHmJaggPaBfqbO5cuFqZM+RhYqP/WftYPtpbWNzncje6N1EYQBxU8IHLEIiDOF929K1sUy4irlBOeIxXRTXKq/IOlmFa9znyEFgi+2QULrPFG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQDEU6rvYXA9RuM7vmZC2g7XqMUTQqP11/dmMYhDVG4=;
 b=NCRTXVGnv583Hn2AeVz+ZWmiDFrFsUR1yKLP20tYPnKnk/5HQ8pck6yFROl9VzM+P55gDr2ObhLdkBD1rHqjoAOGRSQ4K1ZBsGImTdXXb/FDkb6B8oURj8ycfocbNSpUpnigM+Qa8jO9vXzCDAQJ6D9GdAEUSTtoVZ/JPsT0VLQ=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by IA6PR16MB6984.namprd16.prod.outlook.com (2603:10b6:208:5e3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Tue, 16 Jun
 2026 06:36:10 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::57) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 06:36:10 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65D0N2619586
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=iQDEU6r
 vYXA9RuM7vmZC2g7XqMUTQqP11/dmMYhDVG4=; b=PptHNeFjJl4sPklomdNYlLh
 p1h7wRHK5I8yDWTY4a+YE037A/FxZgEcj2U9lwaA0ksH/1Lgj0zGA0Vbk+4dTc8Y
 GM/cKMjcY8IykBLtrk5ws0Fo7rljypIr4Ct8sYfHe0yd7cBMBZKH1LeqEtswk+g/
 BsdO67HD7cQP0eQRGmpCnO8WZ8pkcOMQ3Rr0PeTRvL2mfoBbAaQNJeJldefNukTq
 /OTIoIhnehYxr6jfyT5Yd4hi0vucIE9J76E/lezfDBTZ404TH3+c+10yh44D7E27
 Eq1vQ2Yc+RI6/XLTAg8CNDm3OHnLA7uXZZIvaQlxLk5EHl+t3pxi6kAKoe00dCw=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=iQDEU6rvYXA9RuM7vmZC2g7XqMUTQqP
 11/dmMYhDVG4=; b=YP4xl5n+EXzPABs/Z6mepYNHix+/blnLCMfShF6Zsc2kXfo
 k1My0Ay86G8+iD29gBqTbfKxPlAxoxVZ9zX0MjCZ1Lw2m2kttDIPAGVgacyELhzV
 V7V3Flep95xqoH70RPsmns23zgd5ZkXoUXiPnwDrWz1iWWiCeNsiUkfcD8LaQL23
 ysRhlo6Sf4636nK4cQlfM+vYULNKIuKaEwuvcS3hpkhdqxeMeVbuvjHlYm31gUN/
 u8ZB2SV9+CA7fTz1T2BnBW6gBF9CNAe2gMvr0DWmzH9GPKmNoi6/xOli0gt+PEbX
 qsKsxBjV3O1gmhd7fDb3SHCX4QsBxIDidH0Ht8Q==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4esp8bjp52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:10 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id ZNP6wqKPt8Hc9ZNP7wox0s; Tue, 16 Jun 2026 06:36:09 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ZNP6wqKPt8Hc9ZNP7wox0s
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 0/3] bootdev: few fixes for automatic boot
Date: Mon, 15 Jun 2026 23:36:03 -0700
Message-ID: <20260616063606.825688-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160063
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|IA6PR16MB6984:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 82814abe-cb6e-4dfc-2f96-08decb718df5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IFbK3PuzaAQetnSPyc1ar3MwpuNvLgP7cVRcxbwkHBFRYEVeZAtz0mG3gRCp9z6QuG6x2kWmyfX4R6i/DpABOplKSZW1OER+veyuy6wckHJex17Mw2ryqzasAQO+TJsjxXdJAs7sACJ98fUPq+TaiCDryPlipeVcaKWIPbaW7CEdt7pjKnKwQfsyIp4jgiLfbzRTjPwKxCaiOGOK+MqAKRV/q6mO/4i+oDhzK7Us/j4oAOeHMZRDm5u4oHrxpo0gcDgr2wHJg/ASm/Kra11dcQHFbujorW4HWNrIp27Ky68VaWnGQ2bEGWL7hYR3+Yh0mHTcuOYjmaxM8ypjykfix88MJwws1cyuBYzY+7/JcHdBXFDeHbvmB/Jc0lGncBQka2Y5/nGkRNhspkrEbp4DrFg/9nQz2+poOR+OMRjxpXlczKGmKf0ikfCTEWa/A5MXyPjNmMvgnNC/XdeH8hL2svy7mQZr6z8c7wAx7nUujQpsYEXKjID6zAvPW7jCcNjgmAZ9y3ZqzPT+Vqf6Vot95tw7xmDbVUZgRBhB2+0iMrrPByQZ1nel6h/doZZcjxoW0rGKZEJN6qGbPT9Z3d8DPmtT4f+ZYPJbXaoARd7b+RBG8oLjMS1vjQpIyZZOlcT1kbZlpWg0Jh4HZzaMH/aLZ32F0mvqq+LVEcWVMrQLB3RaEEif3ocWAJxTJfFBBy0fi4VN4tOpxjXK7Knh6TIeL571qYSxd58fElU7/qSxrJs=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JkvdyzBEfxkqC1/jyWDWeI2uAep8leH52Vp4Q1M3csJSiZOPR42L5Ek6J67T4Ojt1vVm2iz1sgne1Nl5bBU0BWAdPip8hH36ieGvIBVA9L8JoBLljMVz12J8Y2cIRWTvVYvyyIfQc2TGf9LGss/RSYU4wTKhrujqiFIE9H2WuOExbtfdiiE0h42/B9QaNo321thCqn2ZO6JNzD3+KBieetlVGqVGVpWKdecRRslYJzO2QoUxm47Ip3woJKY+0AMwM1aJoeMhPScPDLsDtW1azObqkcus3U+bptkaMCd2I2FG29IoDWlOz5I3Pu96Az1etm9WGdCPds2s3WqmKVuGWzPQDdHMYxBM+5fLWllkLCIgHvaIIXSRNPn6d9TkQWSURuKuIPwI2qTngqE0ZFh7TUOXTpJoZXPLbERz/IbhXoMz/gD8eN+s+Di+kBa7ahe7
X-Exchange-RoutingPolicyChecked: CE5KN1C2/7dskqZiUQSU8gFg727wdRXP0bivRX4gDR68uXdHFymmTHWeTho9HM0iExU4dzd5r1qn0oIFVhQ42anOFuQREI4d/K/k1vihOU4jzv4INOdSW4ADiDk4NChDJ0scsHPjjesOGQ9mtfNRrSrWeS/Xif/LzsupV2Me0d5ToTg4JjLyg4PvtlVBbcDOug3zlWOY7b8Iv9dp35I7NjYz+8yg3S82Misf9navxloCiABsSwBHVp6CApXdWSUu6PiQUQe8VF24Bjx536+YWCH4tMNzHeWCD3GSLYSUz8unU/jrDAo0LYlgHZw9UKaLQE9lxFJm+jUIlUy2La4Cqg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8OWMct9Ce2NfXm9IKEZeUZ8BwDC2bS9dOwfTS3KWjSgtpv7hRpIWAXmx2QyPsRSr53/4JKnrKhWIdjpDRe6ycu6f9s0z15s8kLhBwsa8Tm2Z1LI/fVkykpvoRkXLSdHpfFD6xv9dsUrZ7TbQV7vW45klSettPAvCP7TMXPhG5w+lYgfBTPWUD/2UxlRQisN8QqqCBcBeytqFbcCOdhvjJR3LBMRtFGYzQJoQ9yOHfJscl5CgG84kphlMrwgmHH3cwMDRgIRv8OKds7hxlsavC16HN+AR1kz2Zj6OVv4MH+BBa4xYGGJh/4rWvIMuCLlz2gNdJIun1P4ZPuqU026asz6CZB37IaqYtuFlKa6idb9YL8sn63727ETH93LW97k3/bfc4sUZz38iUzRlv1jdwbIeH4VQH5mpX9h5iJnFeQz5Uv0S5kmFBMxL/F3q4+0qDh5Ry0wepb+3TlcawCjtBwtXY8w53nmrIpJcC2nB+PIWcdbyEofHFCk+HWU6ZLEW9XT9xizx6kEGX0b3AFij7vUrlB5Afh64KdgZPmw7Ox+SbdUAeQSY3j+v8BHlzEyuguT1I7GU5PHQtlte+Drq3uETJuxy4I6AaTm0FZyHeYf+rLR4q4F1Ym/Xy2dmGIEVcL6tIvpIOsni9Cb9qfSQoQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:36:10.5724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82814abe-cb6e-4dfc-2f96-08decb718df5
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR16MB6984
X-Proofpoint-GUID: pvM8_pmU6T2xfytDEoKyVFtkvHjCzjQJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfX1Wyr5MxeCFX0
 i+IzbyiCCm6mfSgzJCDv9J0SKLa1qHizpnX+K+FHBd24QeTdTRp9OGO+cAacBQnsWXEd6MI48IP
 K9fRpDGv84W7pAWxUlYUs46CCwESURlDPsdpbHz+0r1lE7B7KQuk
X-Authority-Analysis: v=2.4 cv=PerPQChd c=1 sm=1 tr=0 ts=6a30eedd cx=c_pps
 a=OG2go9lluqTXThMTGVaEpw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=YYtsPH28dYhHwjXZH80A:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfX80Uu3u7jHPw9
 0AhQAb0TWLNQ7CUkibEidZ5zfXE56dDwifaaeWIhKCJvIsB1/nFs+mjr/p8t4Hm/Bb+466NpfXI
 rA6telUT9/QsiWBbDMKPyqdn/8SH8gfPEkORMUzBR1VM27s75p4SzmDLk6BUZwKzpdet8wn0pXA
 ysr4je5GSOG9jx3acqfrVRpsbNrTViBSmnfxpNXN876TB5bgtwmA1rSF+kfg8cZqsZC+No2H8Dz
 r5WjabevCWb/aJITcwm3ON2GGnZAAJv9z1D0nMi92SUPb68I1BPxLaRNOrPxLEbzXnhf8qoRyLC
 Jm0rEQBZwuTqTzVY4/v462D5pUffGmBFF8IOkLXCQi7k5q6hkj+RGQm6DyxXJDgJNzumTzE3Erm
 3sCr+6LtaPQ4VrXxhTriir4YFsLkkG2zn7cxvBMpRwQg7Xq4s9TxSF0L1R4FdhmFHA8OYcfi7cX
 QpskId2/O5+645n/rhA==
X-Proofpoint-ORIG-GUID: pvM8_pmU6T2xfytDEoKyVFtkvHjCzjQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160063
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

This mini-series addresses few findings in bootdev code.

Patch 1 some typo fixes in bootdev header.

Patch 2 fix for automatic boots in case higher-priority bootdevs fail
        to be hunted.

Patch 3 adds unit test for patch 2.

Denis Mukhin (3):
  bootdev: fix typos
  bootdev: scan boot devices at each priority level
  test: bootdev: scan with a broken high-priority device

 boot/bootdev-uclass.c           |  2 --
 drivers/block/Makefile          |  2 +-
 drivers/block/host-uclass.c     | 18 ++++++++++
 drivers/block/sandbox-bootdev.c | 64 +++++++++++++++++++++++++++++++++
 include/bootdev.h               |  8 ++---
 include/sandbox_host.h          | 17 +++++++++
 test/boot/bootflow.c            | 51 ++++++++++++++++++++++++++
 7 files changed, 155 insertions(+), 7 deletions(-)
 create mode 100644 drivers/block/sandbox-bootdev.c

-- 
2.54.0

