Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E5FCD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F38A8469D;
	Fri, 29 May 2026 05:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="S004key1";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="GlBvOL5W";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="d+b6Wo7u";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="dZ7pixMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BFF84671; Fri, 29 May 2026 05:44:53 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43838341A
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64SNsjXF1929798
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:44:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=kGihyHKXpr4Q4CLl0ZPIxfrGX
 Dwh/Rk3WYLN10lKapM=; b=S004key1dKyRGvAMLbZMd7Gr46ldyefs21RQrCfBs
 xYWAG3Kq7g2c44+7BauIOb+KdgndxbBdwfrobfXnVTKdTovRyyF3IGhiP82y9YMe
 xmZG2ZX85pgEyJL+AeXWQp9pW3G6+aarb05QlU5ayClK0GDGpkKKGghCbtNbIZoJ
 Wod7MlJcH06CUKXLIQloEKPwPPoQu4AB5uUX2XIdlJ8LUZHmey3jqZQ1tsTmOfm2
 1laTXIMvPMPirEZmof/DhaiQ4I6XzD8xY2BJ0/40qb7luvv7tSm6/Nt4/1LSoM9d
 DBAaFmWEuyAy1mlFLn0ZAVuOcNqjuUqeCV2eh9/hjh+qw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by m0482516.ppops.net (PPS) with ESMTPS id 4eevnnt3gm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 20:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txQe494p2W6ml+HbXyIkoaOBuyGRbXeIdyJZkcu1M+M/F1xaTHTNysCNLp/Ua5tSiLMlNU1aO7I2ziG1bwTDf9sHLfE9hFDSj2vi/dsO+3U7g6n/E44wrZDNB4K4hnxqdrEcZmzOku/ldv7t7+ky/fhUKOwrN/e7nP2M41l8PRlh8sDKOzlUuU27Wl3Nz855cyx2X75jfn6NcGPThrtc4AvNH78LFSCB4JZP1VVs0UWDfqfSezDi6dObKRG/gKkAHY64z0Kv6d+iggsIl/7FHP3d+saLYMCYOgjLUTWDtzUpjSgP9B5bEuXZ2SUP0VNs65u00NqUqJQpZMWXFTSrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGihyHKXpr4Q4CLl0ZPIxfrGXDwh/Rk3WYLN10lKapM=;
 b=FnDrIost5ZCXLWQvMeAxC1/JRz9iBAf8igPNN2Q/gb/bWXTCO67FXAmQYTTb7I/ieD/kWsuT2nPtBhqlTVVNZ2965Z5ikjWWEVH1ISQoCvDAlpDnvcor5jkRA94/odTn4acGFWJmw96FHCtADpm6CDa8/jix/ohSveLIsUAZuqh+yXun7ULvZd8PR/Z5DTyi7H3H6c8wABBSBLyWH2qPPwdLaForOm9/CIN3vj++MKgC53XiSq0MCUHSoOp82Za9g71/MlsUDo/SPR2RbNwhlmaRtsi7T9OYURU1/HQc1WrenB1gU0KcaR9o2H2S8hu7Nsc10rEstMQLX9ev/cn0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGihyHKXpr4Q4CLl0ZPIxfrGXDwh/Rk3WYLN10lKapM=;
 b=GlBvOL5WtgB4QqUZPLqrr1nPys8n5GwewKHK0QcFxW0yKvqO6EWKoOtE4M/DVXh31MUy+vvcEnlVfjZ5W66/PDmKM1N55Hji78rInvrsMYhmnQyRyAZwubG0+0escGrMy+2UKwFPn5D64UssockZm9r+CqFc0MTCQ0Uynze9j9A=
Received: from SJ0PR05CA0120.namprd05.prod.outlook.com (2603:10b6:a03:334::35)
 by SA1PR16MB4705.namprd16.prod.outlook.com (2603:10b6:806:228::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 03:44:46 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::97) by SJ0PR05CA0120.outlook.office365.com
 (2603:10b6:a03:334::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 03:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:45 +0000
Received: from pps.filterd (m0426318.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T2thxL3751406
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=kGihyHK
 Xpr4Q4CLl0ZPIxfrGXDwh/Rk3WYLN10lKapM=; b=d+b6Wo7uQFIZ1s1fM0k+oWU
 REw7yZdT5oWqwryC6Uc8yPWUDgdfWwyixWz0StXdPFq8VbDC0ieHzdOsRdR6fcNH
 9Xr0wtdB+MBqXSmCKrmUyhy7uDoyRFbZWTRK0XseEO84DSNC9h8Z8tU9Yqt8Zg7d
 rVKY5oy7+i0EMU4DqeOGVANqLvtz8S86tyInwfCFLXoSR6tHXQ3wn1uQihWvzuVh
 KWINPmP9XrwuzQZ06PJDWHbNnlA+dUTbrA9CI+C4EcEu2bKHMzE8n5Fbo2cJalYC
 gPUfk5rwdRioXS5z0vFDnZEdoU5xLpVaMdY+/3FQECjuSz6dRe3nDU1V9PknKfQ=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=kGihyHKXpr4Q4CLl0ZPIxfrGXDwh/Rk
 3WYLN10lKapM=; b=dZ7pixMITUh29HKBpumvqWHVW8i/FeltQIqLmRul5GIk/9h
 U59x9gLapcM+EuoAtSdUks1VN9cTOZSj2i3NCZaIIyyNu+NGMvwA0XVI3bZH8iCN
 VWOyUe+SjMW2vSJhhsRaQe6OOyGoVxSDVx1fhf/1pV0Aql3TurG3au4rHXInDkwy
 eJhuGgq32NDgYKQC7scrsg5XQ7bT4dmQZrzOCLluw2e3TshZTdslTMcU8PsLbN2q
 1K7vgkkovuFvBYBPsWwQuhj5JebZnVaFUS/ypo6sA7jxTzkrZQYTZwiS1dC4H9+r
 Ga82M3hRHH+AMd2tlaWaKP0qVRKLZmntnXwNeGw==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x81tw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:45 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id So9Lw5vHn8Hc9So9LwKa2B; Fri, 29 May 2026 03:44:44 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9Lw5vHn8Hc9So9LwKa2B
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 0/6] nvme: few fixups
Date: Thu, 28 May 2026 20:44:35 -0700
Message-ID: <20260529034441.2075305-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SA1PR16MB4705:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7cc59149-6b35-44b2-a1a6-08debd34a035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: IlaDYMUoDgARx9QfEdBYyRVTHe/0552W50dAD8bDqlKxdTxvLDd8XY2tpslQG44Vq6xJPtROWb2zbJ5CJI6YaDGs6Zvot+gGhcDR9yXyzxkMtHY1OPhaBSJG3cNYMWFM4Yc+xFcA+MNhCzlocAlPtj7zbT1M4R+jLtGBE59YJdYen4Dqv+SrT87EXyLx+SXV4WTSFVBWLR3Vvfick6NdAYmMc7td7UCA6FIRKsQCZ8HW527NcYr+8ge5fTH7IH9MMNR9EpQNzouwhfXPvZC+p3VPM959VE+xMX8swn9TMLV76bsHy9d2zDPx9bm2PAGgwnCTcsLW9On7uEioRhLWVohB9Klgg+AUetrWdrLcupSWIU6b1bNtHxA+2c+W4Mcnr9m7xLew/HpcfZY6tI0DzJmohiwuUewPu9FciOMTfZGUSVbQGENMDh9OxuKCghahbyWOWAJ3SqpVpi7JAgj37/XOQMRRpTn6AiS0SckA18o9FEFq9EcOs4vEMu8wPBtAFeV4ddPYrQAt519LmpInX1Ux66CyYQTIDhpMgLw17yst06muZs98/0vreV74IrF8t8btBligFRMuLaiyvJont4LAzjZI6i67KPUcAfKG18a+yeNV8kDJHAsYdQtf6ohoY/4TU8L2+YOG3kF+xzarjxHBzQU3ivbKY66Q7rQNRIi8fhA0b/rq6WYsxgc4K8ob4dIWYt4i1gzoxx98gRhsJMs5sYKSW8hBOC1kmXyXeSI=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VKq3hicQbDicfjZJQAcGBeUyEaVEZpIo2zCe+bxNnLpLyyC1cy3y7Fh5lI+us4ruBvGM6hUZcWzXXaYFNEv2/Xb4K707cG1fmdBkNB4X2byEZ5Gw+XmGOIFTLSsiWTwCDcVR9M9BS/9rCtEX4+4WN9UwIM0FL6FwJ2q3lUUycfLx4nLJTqe/A8fGxL3SCzP+ubkI4cBikdxB/F3ZrkwSVA/9iVXzZmDZ3mSLy3I935MBPtbsHc0qrYAatug3wDAldMn/RjObaueKoKt8qfAZv1RWM6fDQz5avLAs95SNGDTLKFiJQBRXAhDFbKlRIbgIFsY4/2Wz70xjBAIgzJKsTrmSfVpNgIv20l8vA//dupznLONAnDplzP/iOgbWFegOHzo+laL7zx7NTheAE2dsHKVr56QwEBRzfNhtfDd+B8R9dd/r2tUg0YLE1ZwXOd+g
X-Exchange-RoutingPolicyChecked: fV8LfHOuPayMlo+ei4k4rnEv9xCUtQsVBBye6N+w6j1jMwIYIkF2v2abWNXKx7TGDg0S7ArYBS1H3vcweViYJ3NT61gnm2eGXzgI+J3iEYqOKDQUqSM9rxAuwEPVdyrGYdXdAQhj/DD0WsELljTq677R7V+v4+aQme0etmpeXQ7TtRf+A3o+8aHLajsv7iogWPllIbx+h5cy7PMvtmSaYoVcGvFh37ZQHrWdj0zFGnaQ9lPelyP6zXI2/tO/0KCmYz6yiReJcxBP9mpg9jI2+tdTKaMGoeHfl+1YDE8VmV+6nBk9QvXIwEKhR42mdBpPXrqGhyyeRzkOp09oq4ujpQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZT82rztPTQxdo5OIchp1fR23S7QpA1M4RJHGsjjXEuuRoD0JT85l+W8Aj4gl+lt5qRERYQrOemykFRXBZKHknKuOt30aod0AtgLeAQYMFfNKfIqgUrhn/VY7pw9w0zmp7NXlPE8IB0A0rVs2MKBEI4Zs1gUqoRZ+70xQGxKsK1D+PmFvPsqfCTbpKO1FLG2QR+C+DWKxn8UPxJVRTTKq9JBwg1siZIrPrYdpKBMFei8pt/hUUlL/QFY4cKCoCgBoDBDEskC/xMFFuEMLbmCJDBxJ7dQMDaNNMorG/w/cAE67wmOYgx5rU5NMfjr/VS5rNwx2D7dPPVZVAiDkuKESdFGdtTZV3UcH5tBOE2FDrBN/wIlkydm5iksKLsrpJ7Sc8AgF7GxA1quagP8qxZx1fTDfnsludImSSzX5qfeT87M+R/j5eqJXFOdfB02Sw1qlIj2c85XxnM5HZ/skBeFLYnHxPFaAUez1us0R4MSfBhhMgD4Uoi741KzeaBX/pqZC3OQ4L/0M9ssk93Ad1FGm19kIaD0E5SPu5JcuLdKVLk110a5t4WXOiA2NlkogGKZqAJ7vbDyVF6B2Mrj/aunBDKO/9PFA4PpYNBXnqsMlBAWKdWCVbSYsMkGSIZBaoeY0RRJgDnbb2p3f9g64l9sJAw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:45.6502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc59149-6b35-44b2-a1a6-08debd34a035
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR16MB4705
X-Proofpoint-ORIG-GUID: 4MXaqz4P_q2axhKwpnHSdcFxk8CmPsWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfXzViESQriWCPX
 PVwLLi+Q8mZt90dreQn70G2WMYqI/r0IkOoIsEIU6388Jt1taex0eoB7K6j9BPiiNn9Ln8DTy5f
 HDjQpbY9IScwZR2eFHnOKK9HCsLyeE0qxmnrXNKxe+Zp/aYTErOM0Z2U2+WcelKk80H+kt6nHpm
 3HL3U3beh6j5o+PMVaD56/8wCyXBvaGDu7LwUx8YnsUqbc1G5+bkSBkKdaDd1T+Tg/2wOmo9h02
 a6DK7UYfLmnKBp/1YjUSc2aSf72MAyJjmT3Ah+dkzXzuI3yCUuk/i03PR8mx/YuFKAkjJOIjAI4
 R1GosiYDhSdfZ8AFbTljfmYO2DP6s/zxIUdG7JE/tNfRSbEMjjSCmw7U3PlWeoymrUO6h/Up17p
 M83/As2ogTVfEZJ7bvRCxBsGJm8N6nhgIjxllbp2+eCKmqE3oAgmAcd3tBHUA9yYTz0yc1b+cyp
 9FQFLNEjxpXfGXucPGA==
X-Proofpoint-GUID: 4MXaqz4P_q2axhKwpnHSdcFxk8CmPsWy
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a190bb0 cx=c_pps
 a=Ovo9riOs5JmVBBfNyWc1Cw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22 a=zFJV60gWvoO_ChBBrkcA:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
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

The series adds few fixes for NVMe subsystem.

Patch 1 adds logline for tracing misbehaving NVMe drives.
Patch 2 adds plumbing for blk_flush()/blk_dflush().
Patch 3 introduces NVMe flush command.
Patch 4 enables `flush` for the currently selected block device.
Patch 5 makes nvme_shutdown() symbol public to enable use of it from
        board_quiesce_devices()
Patch 6 tiny fixup for QEMU command for manual NVMe tests.

Denis Mukhin (6):
  drivers: nvme: Log I/O timeouts
  drivers: block: Introduce blk_flush()/blk_dflush()
  drivers: nvme: Implement flush command
  cmd: Add flush support for all blk devices
  drivers: nvme: Export nvme_shutdown()
  docs: nvme: Update QEMU command for testing

 cmd/blk_common.c                  | 14 ++++++++++++++
 cmd/ide.c                         |  1 +
 cmd/nvme.c                        |  1 +
 cmd/pvblock.c                     |  1 +
 cmd/sata.c                        |  1 +
 cmd/scsi.c                        |  1 +
 cmd/usb.c                         |  1 +
 cmd/virtio.c                      |  1 +
 disk/disk-uclass.c                |  6 ++++++
 doc/develop/driver-model/nvme.rst |  2 +-
 drivers/block/blk-uclass.c        | 18 ++++++++++++++++++
 drivers/nvme/nvme.c               | 24 +++++++++++++++++++++++-
 drivers/nvme/nvme.h               |  7 -------
 include/blk.h                     | 28 ++++++++++++++++++++++++++++
 include/nvme.h                    | 11 +++++++++++
 include/part.h                    |  8 ++++++++
 16 files changed, 116 insertions(+), 9 deletions(-)

-- 
2.54.0

