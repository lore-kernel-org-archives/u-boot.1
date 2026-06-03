Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F384CCD6E69
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BEF0848B9;
	Wed,  3 Jun 2026 09:08:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="GcPgNeLt";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="GIdA0svI";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="a/zH5LXC";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="sMDm87xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC9B84857; Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7C98486B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6533Sqka2025246
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 07:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=MCh
 t/C7uCbZZfJWC+J1rTHAjtun+f8ilKYFCNKg+f1g=; b=GcPgNeLtYWmSXWJiI0b
 ZNO8WkgOU0apLHTDlx7B+Kyth15XyI0nUYWUkuFJZZv9llPivcTIe9eySoFflKWB
 Ye/ZpRlPEjvbpmDIBbgVY3cDDKZz7F/V+Qks9qtAy/Yl2BtF2q6Fnki9U2CLbIhS
 wJhzyLizRsjl3kD95lJAVZUdNc/GGmgt49IeYVVLcQZMLyqgrNBWcos5iDvjLHNn
 fAMozL4WgPmKYp+FBGK292UyOVT+LOMK+72n0fSLGexM0Pw3lX1dNPJcZseoJsp5
 HgWxfSkxR0h7bnqiY8a51t5y1R5ynXzZ1n4oRG7M4mLqBSj4RyUm3nd2vg13dmFm
 /0A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ejccvs0ne-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:07:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTYINNRzVt4HXo+r/AkKmYbccwEmonKEZgkOQmfEK58/30+LyIGHEYeMtLGQHj08+oBWOjuP2zQchAhE36hKK0Y33fbRqUIPMIvyovaWzDWdVMRwmQJX3NxbdxOiwR2jcJ8w84rWbiz7guIvgdgFl1ttTFUE93CvNvQOvXmFvGoRjXN3z4M/AewBfvr5+ZQ2M933LYZXuA4LOVsWPzLX+str80dqJxui4IcNhlJ36ExY/U9IB8TmkOwW7Sh5m1TbD2brWtw0SP6/y75Kng7kIxPXDktM/I2XeNZa1m3OoXyDNr9aCyQU2lzCptZRY1iKnYXuQY+YaFKSp0v3CjbW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCht/C7uCbZZfJWC+J1rTHAjtun+f8ilKYFCNKg+f1g=;
 b=M3U+VwIOjbTXCxa0wIA8GOnY1AG0Nv8uadBnqEKn1lFt+GhVFky8FKpVf8IU7+HxdhCpZlSqpmI4UoFePRPx9/UnyKJBjVrEk/c+d9o3WFUWWaBI4mkkyqtLuI0IneLoiLsVpEEmvja39CwQm7AUKoElmFh6Ax/4s0efF2h42jg+CgC38JpayTf3JaVz1RrLe2Y8im7nv7g/f35uDDi/f0VXAEwBL28OXwL3ApOcO5h6qMHhOHUZ7Jw6E2lZJL0aPiQVbUg7bKCKDt2xwhguBNeuZANqEfUymjDajbYBSpF++p4klT0AFJoim4uErrdFhhbhFKUGO7YXPGNrFL06AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCht/C7uCbZZfJWC+J1rTHAjtun+f8ilKYFCNKg+f1g=;
 b=GIdA0svInj7gJHiUlp6LoGAYqh6IXh65rHMROMde10nGllk1ikajHtpECcpZVEPhCz7lE5iySfXeFegOQWtwXbrdPlTSAvGFw+CY08c7h/38eNlbXwzYjZFmboukgxRhHMQOhWdyxMkhck4nr4geghqi62mA/EMmlpp98JAs+G0=
Received: from BY5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:1d0::37)
 by MW3PR16MB3833.namprd16.prod.outlook.com (2603:10b6:303:44::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:07:53 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::70) by BY5PR04CA0027.outlook.office365.com
 (2603:10b6:a03:1d0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:07:51 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6532Y2eH1071542
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=MCht/C7uCbZZfJWC+J1rTHAjtun+f8ilKYFCNKg+f1g=; b=
 a/zH5LXCgHiRD51RAuPwIoh8ss+m3HO8eOJsDKJK5kABrfU8+WrBvfXIkozkGDs3
 2+qinewy7Oj1zpIV6p6VCSE8LtMnnV/5AlNZ0/Eb6vtZyY/42BxOlrOKj17eO4nX
 H0ZtNRIC5+QiYnLj+PYeDAtROqcOIWPz5osjws4ENgO4KAyhcp909WVKWlWSMmxO
 ZRvuW9+gBFvwntVwr6LHfVXBKqhqE19KhauWvHiGLoRUNzQMUuw63VG+qSZfVlhd
 tmeBOI6yARHJmO6j0fC/2sxtva6aLUJLm0Pqipdck+Kmd7MDTLr/9IoLs2rZKGsb
 nsTD3xtWNo569HEd2xNhEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=MCht/C7
 uCbZZfJWC+J1rTHAjtun+f8ilKYFCNKg+f1g=; b=sMDm87xdiUpWgEUg72Kvbf2
 3hw8QUgsZmp+6hd0nqOERLezERFOxJJPy0Actn5Uvcv/Kz1v3Rf+4KvTpOGTS5Uy
 RUBQ2FndCJE21O39bJgTr18n1havWsE76E4NMTMMltodNoNnDqxACbVXo3MWBKH6
 ZaiHlYDmn5nRO4aoYQ1xWIeC8z4gZwyvCyU1sim3Gp9+i/wFwPjq/zx7WOCPpBBl
 2M5PJY9w8sTew4RriEbhKb7/X0ClCzb0eAlztgg6Nvqk6GDYeDp1RtJFZ+4ey0P9
 RvqzjsinRXahsbg+8RV+9D0SxG3JtwvX9O4ikNIxZWt+2wRKTSVHwKhaMuDiPxg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd4kn3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:50 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id UfhcwlcZibrKTUfhdwiYaa; Wed, 03 Jun 2026 07:07:50 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UfhcwlcZibrKTUfhdwiYaa
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 1/7] reset: Allow per-board reset type
Date: Wed,  3 Jun 2026 00:07:37 -0700
Message-ID: <20260603070743.1268544-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|MW3PR16MB3833:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8b073c8a-4fbd-4f97-55c7-08dec13ed400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yBn/AYYlyNR6XfivI/IWfmbLZy1rqrh6+KbWfIu7V936DTPVWLs2aMXNl3cc2F3HkAVJOn1c/UBY0upanvZoYRtlDMhWdSYONGA2i0W2QnHqLVlMNsB4N93fIvHTRcncAZva1OBjV5kDu9d20pjn6E1LylpxHxgvZ8BMpOHjE2sA0MhQEIwGmxrMvE6juHorf53lo6s2TOYbrpdBVrlm2uwwz1ABQYWW2DW3tw+W+bS+IgM5pjt0X/tGMq6ZxA2qKWpF0Ke8sz8bq4WhuRY9LyiqOP7EEgMCcEh5xh4/ot5SSgHwS/E8eMDHv1jllbB5X1iySa/eQjhY6hQcvL2HtsvSrGZ+ApPDcSB2doR0v/sp3Dowcsr5tv4abg7AhVcu2NTQNbF6HEcmiPvZyTzmDuATYefPI1ffhe/Lc5bkFf9k/OCL8Zx76YHABL24FN5wMj55Te42piI+afzwhVWilyH3K0opn6Mz8eDFChwGDWsuymC+bScMW+poIk7YUHxq6hzQKRrD2FUBT//U/X8peofBJrRmW9kp11UVKitMbJwr2lCELo+6syhJn1fa5Gozs5loJHoY69Nh+1Z6UckoKJ6/j9SrTBossadCEQ1q87a9jX5DrmXbz5XPHootm95MqP8xzpP9ThlPuikzSLejFVM8y1jJm4PWkH78OVcGTHyKTZhHIahtYl7teHQLhbhmnbAifYAp+yUj4r4g21DT/B5dhNvJsPqWMiGZy4shYno=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F+gpP5TR7Oab58fpcWtjMXrLKqnIla41b/YssYxy4f2UQCvvTXmcN0KwcAYKraoXNjTRlkZ/lTy6iOSXzQuw9FP4rPNFLwpiPsGbG28zJsCBI1UMO0kjqeLVisJiyGanipwoJscouZ8sFfa70MN4Z6kvgDHQaS2K1yOfI0YvP0TNWEHusbfN9XuqM9oyH0+NjTPHcW8YA47W+NR+d6PZeHnCg4vMv2K9wR9X9cKhzU4rH0C8MBFpPteCJRFPp2yNetR9TqHjHXhjVp7zV7RsaD2q7BHpJn8yAW2Dgqfs3CvfK2Cw3i7ek4QlFrSSQw+Br3yyGdVvAPWsP3PkVr4J5MPXXqOLIslomEXPQKcBgCtsYKePLldjek5NezdY/TMvM4b+aYvefKvuydJurwJzY1VYo5mx2/rt6QO9asW/0hRutzn3Mx7AWPju9Ugc0vEY
X-Exchange-RoutingPolicyChecked: rjYnzVUMOa0QMx49KGk9SLRVuHvY8z6JzTWENcr1hIS8Z3Olgr1QLWhSxKGrAbiThHZVOEnegNEPFjN1PVS6PujyS2tfb3Zvq7P2ctpiKGVWBhGy0mON4zZBn/+5QTThj0qF4n5u6Po7KQ/pBUlGL88cHgA9UwAyFxH5CXJ8IhM9TbyyvdZodNsNQE8TYhkiZ08gB6H/RQrjXKqqQvWtH2xPrGkPx7ud4MC9jAolfF1FU5NQUEfjoPWiYcDOHhzw4uWKz3nvKjWDN2Jdwl6oe1w4MvX+LfHh7Vs+2RPQf6/lEUAgiPoMVLMq7dKxTHI+JfCrLx+NGWNqLBN3aDPA4A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y2YIQnjkrfNSkzSxJjodEKzHCcFqymEY3qrivuNmDZ6EttgLMrQRv+TTorOgohHfxvYVK5PP9B1qEQE8++rbiWeloFPVwY1KK2vDrc5ThKv3WxsUO+SGLdgsULPhWaFcTitGMGWwmRR5YlOpKNl0vf8kzHSD1DNUBk4n3UJfR4Vcg7eIO1TfyXGR0tqPNpi89FrZx/QC6fwV7lH68HkeEBJB3+jNiyzBVpEABrQwWjTBAFairwUSPOFnUPMbffdeqp8OImRgiOg/fCgexLZ/ZLzxIshfC1zjLM4d81oL7yHPr4aL/Q3p+nq4d4S9687JpVJ0YBKAkmEdVa1zGMi/+7f1ythhWri1xF+sT/u53dDVlqpjRUSHvHmSTqhiR3/noiu/HxhQ04xX9GkBNzAiIK8ojuXqFhnKABgWPWwzL7HqHJQPsP9wk1/bqD5mKNGAIm/egJe3IKInXXl8wgcHrljLmDc2bXiPZK0MQE1wTf4rRo47NSDlKu8DZJHA0plT+Bl5fpFavlOUeMC+kfLmaPNPYxyteoAt4jNOGH6XFJmQpb4dh852SrG95UBCfrb/Y7s0f4P0Vr8sgkmy0mzNVbStmA3E6Zh5rVUFvMUPxbikNlSnetJWB3pp+y5KY+AO
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:07:51.9894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b073c8a-4fbd-4f97-55c7-08dec13ed400
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR16MB3833
X-Proofpoint-GUID: L9Aj_4foFRR7GGP4IP7AtHRBA2OaKr3I
X-Authority-Analysis: v=2.4 cv=NaTWEWD4 c=1 sm=1 tr=0 ts=6a1fd2cf cx=c_pps
 a=HGE+/hAEzspoXCOliImplg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=cbNQJ9GKAAAA:8
 a=cm27Pg_UAAAA:8 a=cuDLjbAVpos2dk5GJLIA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: L9Aj_4foFRR7GGP4IP7AtHRBA2OaKr3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX/cvmBUDOg/OZ
 mNd7ymE7gdDoDX9auL+f6W9q9MMzS7LPj0VUrdT2yfGuN7Ch1vPlWTex6HsoavP5TJaqdjdyXq9
 oWuhpAKo1G9Rk/K0oDb69QuxNhpq0srMSyThxEEavV/STxThLBpUfpLgRQ/jek37HOKiO9x93iV
 01cStOtyt0zIktxBKq/OP05DiX6denRIb1JX53IwP0iX0YeWWxku0XyT0eBdm2kgVIP2vgtiQ9W
 WlcrCvkQ48nRGpFATO+BvfsQE1vySBKmKVz7pC+1zIDTgz2EbiJstmye5ClJudS619402DAcHTt
 yqZ4dyeZGi0YF1clO0VXINbRQ79zUM4OPS2/swAQed4jkfw+luA+IXOOcb27PYby+kSrg7SuTct
 bHwYG6BShmfHpp35djtPd7okWm+wXKD+bcmTf0RE86+y2ziw9u/KHqu84Q34uPf8QAsXEdGevwD
 6eOs3/Gr+KKa9uFNFXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030066
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

Some prototype boards may not have (temporarily) all required reset
types supported (e.g. only warm reset supported).

Add a Kconfig choice to select the board-specific default reset type
used by the 'reset' command, allowing it to work on such boards.

Rely on 'poweroff' command if SYSRESET_POWER_OFF reset type is needed.

Keep cold reset as the default.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v3:
- updated comment for SYSRESET_CMD_RESET_DEFAULT_COLD in Kconfig description
- added a note in commit message on SYSRESET_POWER_OFF
- ensured no unreachable code
---
 drivers/sysreset/Kconfig           | 27 +++++++++++++++++++++++++++
 drivers/sysreset/sysreset-uclass.c | 13 ++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 90f740f51d42..83bfbc5a30f7 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -57,6 +57,33 @@ config SYSRESET_CMD_RESET_ARGS
 	  additional arguments for implementing arch/board specific
 	  functionality.
 
+if SYSRESET_CMD_RESET
+choice
+	prompt "Default reset type for reset command"
+	default SYSRESET_CMD_RESET_DEFAULT_COLD
+	help
+	  Select the default reset type used by the reset command when no
+	  explicit reset type is requested.
+
+config SYSRESET_CMD_RESET_DEFAULT_WARM
+	bool "Warm reset"
+	help
+	  Reset CPU while keeping GPIOs active.
+
+config SYSRESET_CMD_RESET_DEFAULT_COLD
+	bool "Cold reset"
+	help
+	  Full cold reset of the machine, including CPU, GPIOs, PMIC and
+	  other logic in the machine.
+
+config SYSRESET_CMD_RESET_DEFAULT_POWER
+	bool "Power reset"
+	help
+	  Reset PMIC by removing and restoring power.
+
+endchoice
+endif
+
 if CMD_POWEROFF
 
 config SYSRESET_CMD_POWEROFF
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index f25e09e9cd06..5c6dd7cc1c55 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -150,9 +150,20 @@ void reset_cpu(void)
 }
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
+static enum sysreset_t sysreset_get_default_type(void)
+{
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_WARM))
+		return SYSRESET_WARM;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_DEFAULT_POWER))
+		return SYSRESET_POWER;
+
+	return SYSRESET_COLD;
+}
+
 int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	enum sysreset_t reset_type = SYSRESET_COLD;
+	enum sysreset_t reset_type = sysreset_get_default_type();
 
 	if (argc > 2)
 		return CMD_RET_USAGE;
-- 
2.54.0

