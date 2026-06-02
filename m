Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE24CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 06:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 435128488B;
	Tue,  2 Jun 2026 08:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="raiT3el3";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="KYhtzn5n";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="WtkI1D2z";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Ztn4tMbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0501D848A1; Tue,  2 Jun 2026 08:32:04 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A03584884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 08:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65261Yio1756807
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 06:31:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=QX3RMZIJirlOSNwFvoIiQNVcX0q
 OdSN4DzJVoL161yw=; b=raiT3el3DuOV1GtUf96QO7rR4v2W5eNE43i6XEddlEf
 yeIgEFOzWAH4NtfFbZlzddA2w7Sgnc2o7vVVrpoFMpZFzcj84cKC0d6tm6DZc5L1
 /kW/Ttp0CPsNKdw88TD0v8rkyU3mXhsBJw0zgTZrZ12U2+uRNS87ij6Nhmz+ioiX
 hCU/gAVHYOOK2XLv0Z4PVPKzF85JqxDw2326MV6vxjijhEUcZHjlM9fP3SC1+DDN
 KefQcbWxTGyH07G3rGp5ZRzT737NO+Y8PoXfhTPJc0vbsZ3EERGaM35GVU4VVXAT
 DP46lYruKOnHAB/DnMHH+5ypNZBpVURHdCKIfSpGJ1Q==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ehshxr5p9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 06:31:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHUJus0epraVIthfNQA/gTvWr/N8+AHPxWVebimzRJ3KplbjGbk/x4dqFQUDh8dnQhoG+ojjZuRmUXwARx5dtBP8lZg39+9BULZI/DrqEOocCraY6WmEkCMDDsgQH/Oi0cO/BW2GANdLVW3X5+EsyX4JGzojIwFDUqARI4QTKfLdGjwVpZOMGDnevvJlUMgIk/ISXlT0Tbq+ND8a+e58+bmkPHjZukYZj9Z4OQr5NdcVUrDtwxtIDOMH0zSRKKNQOKEeWFxDS4gDZz22LD+Ok7YTh/U+YBY2+EoME1rvAX+ld//C1z0SBnT2kTsd/yFSoala5ydBUgnGyezACb1FXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX3RMZIJirlOSNwFvoIiQNVcX0qOdSN4DzJVoL161yw=;
 b=yJCw6kw6imj3V2wS87hmWWntWjUCnqQH6f0ciW1iRXegkRXlFOYoyWK1HfLhYyWEhEy0NI/yT9/0nXb51urfRU+RkD5Ad3pJagkNQGTBg/y4TLf4458YxBrrCp+/zxF1FI/PrvjRn9MVFbgTfnqoq7YYib4YYalfWPggnERQ8PaRegocuwsiTTtJ3apxd/FMZa06J2MNIs3CZPpvsrC8wxNvIB1uvPLZuePd0eGPHr7oyeRiq2DFFcfSggMz+sQTGJ0POGBYR3RUr8gxBmhllWpNSXb0KQwk+/4CvrmFvuBz2xQ5QMzS4mO6FbSPs9a7VPkklirwOSexMbWatqH/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX3RMZIJirlOSNwFvoIiQNVcX0qOdSN4DzJVoL161yw=;
 b=KYhtzn5nkk8Gft7fPrGKPMoQeoMSF2TuOmlFo1iwhKIqxCQoQMOItEaVb2zUzGmowLg495hgwAlM7n6e9U4VOFYXew12EXwvA3UG61p5ypXXM1bxdvGNhzj7FfannBheGRrQkYuNPFrGGvKurhz//nxEiS41pjg3fl9l4i+DY+Y=
Received: from SJ0PR13CA0108.namprd13.prod.outlook.com (2603:10b6:a03:2c5::23)
 by DM2PR16MB6805.namprd16.prod.outlook.com (2603:10b6:8:2e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 06:31:52 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a2) by SJ0PR13CA0108.outlook.office365.com
 (2603:10b6:a03:2c5::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 06:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Tue, 2 Jun 2026 06:31:52 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6526Org1096930
 for <u-boot@lists.denx.de>; Tue, 2 Jun 2026 02:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=QX3RMZIJirlOSNwFvoIiQNVcX0qOdSN4DzJVoL161yw=; b=WtkI1D2z/l/a
 b0KpGjhb6VZA4vEzzi6xTe+Uc77nABVvjP5Ka1hoAdTbEz4Xc9KM7lL1RCk+/wT5
 qtDm3i5lAbx6yYnOT8DFqmtTmIlBFiqu/7J5tEvMClwX9KRQZNDX+OQ98Ufp9DNi
 1OMO0B+PeESzj4ZPNfCeKcZUhuZPRdjJi/iUE6zaBQ18UeL1D05xwavqjCLCqNgo
 /9REjw496e3RiZBJAXXZFsHPm/sXq0ub/hbFIiMQdi6G7UCD86kGK0o3pjEIACVN
 EaBKo9BgYt61ightPTGOL/qUHhMJ/Cj1KL/srhv2VORqO8mFnFtQLip5/anv0xLM
 Yqhxhl3f2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=QX3RMZIJirlOSNwFvoIi
 QNVcX0qOdSN4DzJVoL161yw=; b=Ztn4tMbIH5qsBWpwhM85HMHpOwl2/Y6WhnJ1
 V79JjBfdT4xkxN5N95QsTBDsVHCvTo8JKQ7E0AN666X9zH002EVn04L5lswmet00
 Jr1EFwWXDscuKgQJZlD+BCuBihp7c8hvBALMt+IcpgZIN5yJY0QweooRA7fO6SPz
 HZIQUIcJhkeGWgIRlXIdwtYLJ3eTg+R71rleLbJ0y/SB+VHaZOOJZ5hXs6M4G/VF
 8VXzxnTilAEHOIzBV6bNGnW4IX2x/LAcqMZbVa3j1+E1E6m77mi++1FaYfdLfLxR
 IzOFXLAD5wt8P+9psKOBvuV4ZasmqLeX7dhdYIupcrMJ4xANHQ==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egeh8b3dt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 02:31:51 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id UIfEwyxevpOFEUIfFwVIwG; Tue, 02 Jun 2026 06:31:50 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UIfEwyxevpOFEUIfFwVIwG
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Mon, 1 Jun 2026 23:31:47 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
Subject: Re: [PATCH v3 2/6] reset: Add explicit cold reset support
Message-ID: <ah540+djuS/XDbHO@kraken>
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-3-dmukhin@ford.com>
 <CAFLszTgsoLcMuhy6qQQKhwQOpWxhpF6VJiYCFt8Nh=Vs7drhkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgsoLcMuhy6qQQKhwQOpWxhpF6VJiYCFt8Nh=Vs7drhkg@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020058
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|DM2PR16MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc671a9-c0ba-48b1-2a21-08dec070a241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|13003099007|18002099003|56012099006|22082099003|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: UbFQ6xZ3DBClWltP9lTVXUTZYAR+evSuiIxw5fXxnVorXWcxHDvzP76HPhwsAkbwQ9ZsM45L2XQ78iljh44OVffLKMQPcpnt/wn1ss8N4DWaXNjHh+ndOhC8I3oz+owjRnvzdtFOq01jQBahE/3EehZOxIcFnEhRnRgxqkWmMyodRvHrYSZ9yFW9AVgl2mg8aATOEJfq+B2bmYq83pfVRkTzvlXriGlwRkacg2WD2emSFxhJmr9KCpK19PWuBKc0ZM1pvdh47GRwGRR4KJVEHwb4sLwwwhwHdQxTxKa03x4iA88CB5bdJqbj9PfY/yg2mZ3AjpAuaBIEDPovEfoV8N+aP0pcgvoCuu8OiDEIcsH0zhKtVssDdnVwJXau7+0Ph5P/E5ui1cQon/Sp07UQlH46pzwxnaqu8sICMK3k1vDS8OHYy0pdQ039SnkW/zR3Bt/qUbFotY08rn+0GfHi6W3jwhoDnH5nJdo/xlIaZkGXRmXNG2PxLWDtETak3uyeCTHVAzSavrHrzCyyeBQ+VCnIkrR8NfVKLwKXNSXA5iRMv2B2PXboIja/Qj1RhI4xHJSGZSbGq9I1q4CzfZhuKsTL4CqaKe/2L9/f6I85gVo9QAGGlNX7Ft8i+0ecTkl6VIJ4hq+hsBhOU1s/7lxUG3ydIuce+CgIjd8lCvkb8RSSIYMJ7vbH2KlZIRY02aF7pUwBInZcdYGE2shsQ+MSkcD3A/vJ28nxIY/zW02QKvE=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(18002099003)(56012099006)(22082099003)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YbBkk2YdESBD62Qymg4X6vdFUu4SxUAEjc6J6AxHvuMp+tjH1Zt2wq5YH11uKvERONsGSOudYThpewoJS8WmuULgm18om77IQEuI2tnVP11zX6MhWcp5jILYPkcCw0LQSt8PE6vDIuxUvTRjaoxV7lLx7wlkUcrqX9wgJQJXtRrYesAEFclq9d0lFumNFS1Tv7s8tNqi/9oFwHNp1VRHn3NQUDqzLRYVV+B3dZm1iNyTIqyj68ntvi/S9DvZafRh6VzIUtQi1m0s5vkoh/7odbQtCzfpbOlJgwo9imbrkhEbDSp4ka9k+tg6C7vvq9cBMDra0AFrPgWNKt+8d5xy4AN1Bp/lQ2Nf3Jc8lb3wQM+p8wPVeteUwH0TIKq6rI96wXEG8fKI6+yCs/Pnt6hZ+3hmQ2plu37kWrwO5n5JKUGJ4qkpLOVuQWUWYF6cBPGJ
X-Exchange-RoutingPolicyChecked: diiZitD2PBi1Wqj4Ccw1mIrKdahYr6yUkpYsFEKJbhgRiHjBMlOIdXdga4FUIxWMjnRom2OcV52tEgby6XJP8S2pIC0HUip7itK8NxriJP299O7ksfHN2qQdzW6cmLXOsO88IdtHSxOQoMvIotvXTnMZf4PDQCAzLzAMSbwc4Nlpqw/i1a14GuMeskCztldGuwG1jCMaUZAphG8pyt8DstvCEBDRDF0kkAbdlFnhHzPHo7R0G539XMoiYW5nEPMxf1aCSegwFIeZ5pS2Ws/nXav+KyufaWPydPhKliRcLHX0inl1GTdXxObgFAAJNlvwSvUDCigLZXNrcqJOm1+2aQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +zwrM8tLiXRC3uEKT2yqP8BLQwPb4w+Uv5c94qFqCqC0Xw/IY3hdawts/sFbTqYTH7bVRjMoUn1UYp6uY/iZZMR05TmnH4/stUpdNUhqGy65kujA0PyaZscmYwtw7pqy2+jM5/cuzQLAts9d7rjx7BFRz5JvBV5i1ussmBXRS2P4PGPJ3SD9UOULJxeBhZ5shUDqLASywUzcGZjnFO7NWLp53npyGzLF9btSc8i5jrrWsheufqXWyENyEh3dMZ6CJ8EYGaR00ARcO5RN4/AXscp47TnCWiM4U0pNQFmfibKvQdI+IHwtwNKswshfHTj3kNuz0zOxbv+9DG647Lrl5wB9w1ga5diPS/FlycoNqB6a50l8rhHH7+bjBEnRntweg109UTCmTLmaVpA22zkaW4rgRjPy7P1cAEJ+HooqkiUel0nkkeR3r6fLyxEgSfo68sFvt3LFopUdGsBrnt3wwdT2yz/Vbtpow4zoHhJfSTw13+4gKdncVFQs0jTAYxgy+0zpc1b3AGC/npgc5n4jUm8Ta85OJLCrjlj3ywF9bkymKLTYBbEaPDzt3rrsPH19vfwGbxXi4LGfbKLoAi4O7untbNWrKi4FZ+ZV8n9f+MGHz+1nDQWOQ/nCQlH7upJf
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 06:31:52.1553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc671a9-c0ba-48b1-2a21-08dec070a241
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR16MB6805
X-Proofpoint-GUID: -E6hhsbggUFi2VN0nIiELgnALs3Ltk5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA1OCBTYWx0ZWRfX9GJyngKtK9Sk
 ZMOU35Oy1O6F3NPjUZR+k97p2Lz3qDADElQ4/lQ0/R/ShQf07aDxGxdeaby6BFOfXOdxSyP4bpt
 HKUixdNIpkqAP6VtoyFLlFcNfW4TEDU9mLphRgMieZJBw0S4gODyiRYG0gtRwVU6x13P+MEdkZy
 uplaUQqsVX8YV0rQxCRHNCpYhIpSmR7HQViIUb4MijnVu8DQSWxHgsyw+jX9DqQRp5zbtpxRka2
 8xq+ARHHGBIEZQWIKRfZndmkNyr7YkiQnvYo1w4UtgD6timUbVTQaTVeEskpD71YnH5h2Rxm9k1
 QYPbRiQ3a17HjsbAL360sXsA66PHvn0qjDA0MFNSv9CgCLLV5v0bTEytNabjhJ91lH+EBlcC1MC
 YOCnnxVIT2usPHAOKxXVM3w61kHnObyBtHkJacNLQEyYLRngIiDDvVAVrN7HNNz2WpXcVvutb09
 1rkWUs77YaFejtzmSLg==
X-Authority-Analysis: v=2.4 cv=M7l97Sws c=1 sm=1 tr=0 ts=6a1e78db cx=c_pps
 a=VvAZzv+PhNtEUaR8E1V7rA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22
 a=voM4FWlXAAAA:8 a=cm27Pg_UAAAA:8 a=cbNQJ9GKAAAA:8 a=xb_JWtlUtwjV85O_-sgA:9
 a=CjuIK1q_8ugA:10 a=P0bj-C3X3jJDpopQwM1U:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: -E6hhsbggUFi2VN0nIiELgnALs3Ltk5-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020058
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

On Mon, Jun 01, 2026 at 08:54:25AM -0600, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> > reset: Add explicit cold reset support
> >
> > Some prototype boards default to a non-cold reset type, e.g. warm reset.
> >
> > Add reset -c so users can excplicitly request a cold reset when needed.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > cmd/boot.c                         |  3 ++-
> >  drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
> >  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> > diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> > @@ -174,8 +174,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
> >       if (argc > 2)
> >               return CMD_RET_USAGE;
> >
> > -     if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
> > -             reset_type = SYSRESET_WARM;
> > +     if (argc == 2 && argv[1][0] == '-') {
> > +             switch (argv[1][1]) {
> > +             case 'c':
> > +                     reset_type = SYSRESET_COLD;
> > +                     break;
> > +             case 'w':
> > +                     reset_type = SYSRESET_WARM;
> > +                     break;
> > +             default:
> > +                     return CMD_RET_USAGE;
> > +             }
> >       }
> 
> This regresses reset -edl on Qualcomm. Previously, an unknown -x
> argument fell through to the SYSRESET_CMD_RESET_ARGS path, where
> qcom_psci_sysreset_request_arg() picks up -edl and returns
> -EINPROGRESS. With this change, argv[1][1] == 'e' hits the default
> branch and bails out with CMD_RET_USAGE before sysreset_walk_arg()
> runs, so reset -edl no longer works.
> 
> Please leave reset_type at its default for unrecognised flags (so the
> arg-dispatch path can still claim them), or call sysreset_walk_arg()
> first and only complain if nothing handled the argument. Also,
> matching only argv[1][1] means reset -cx silently behaves like reset
> -c - please tighten with strcmp() or a length check.

Yes, will do; thanks for catching this!

> 
> The could be a good usage for getopt() but sadly it increases code
> size too much [1]
> 
> BTW -edl doesn't follow the normal flags approach, so we should
> probably change that at some point.
> 
> > diff --git a/cmd/boot.c b/cmd/boot.c
> > @@ -59,10 +59,11 @@ U_BOOT_CMD(
> >  U_BOOT_CMD(
> >       reset, 2, 0,    do_reset,
> >       "Perform RESET of the CPU",
> > -     "- cold boot without level specifier\n"
> > +     "- reset without level specifier\n"
> >  #ifdef CONFIG_SYSRESET_QCOM_PSCI
> >       "reset -edl - Boot to Emergency DownLoad mode\n"
> >  #endif
> > +     "reset -c - cold reset if implemented\n"
> >       "reset -w - warm reset if implemented"
> >  );
> 
> The '- reset without level specifier' line reads oddly now that the
> level is no longer guaranteed to be cold - perhaps '- reset using the
> configured default type'.
> 
> > Add reset -c so users can excplicitly request a cold reset when needed.
> 
> Typo: excplicitly -> explicitly. Also please use single quotes around
> tokens like 'reset -c' per U-Boot convention.
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/cover/20260519233207.2765755-1-sjg@chromium.org/
