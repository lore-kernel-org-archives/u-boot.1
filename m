Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2313ECD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292C78341A;
	Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="lWyhX2+4";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="GlPFzOln";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="k0eY+Rqp";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Z7v0uGKb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9CC6840ED; Wed,  3 Jun 2026 09:07:57 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C5D8341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6535Vlwu3160640
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 07:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=TRcvcS/o45leD9i8yt+gUeS34
 3zry6Uh8WCtBuu9Ls4=; b=lWyhX2+4Fi5eOCtiJwLr0qMB9Sr2MTiXjA1qPlOqh
 a6FDY4D3OTTQ+3D+vq+2vwi3UCMo5Ar0HqHyNsTuXhbqLoUHE7+vJG+CvXUpKrL9
 mJanPXpUTRHJKjn+KDudjkkdOwPqO9bPU5OOByxz6bBV0phVZlaJoi99ZvEMi/e/
 fzi/snlxTjRmzXvZsR3Vjo2csOzN+XlVywrocy1QPwPFop+VCMFs6NChtI3io8N/
 uvaIf19np4V6iU/3/jFwnipuiNaSXktXtDmniXvGzTdm5gQETWoQGkvQTU3/M+B6
 VaUqVmTnprslcmNECVMPKuvI1uq3xb9aw2G5DkxbPnY1Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4eje6rrgbv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:07:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCLY/uzs9GYhFX0odwywvScIM+kvMKW8AORATU03hEL0VbeXvX7Es2E9/Cae1xgt6YiZdAYDjE/wVvRhYulaZAlUOp0lbXKSQFSE6zp7ZcBZ8Q0iHOsT+F3B0iKTw31e+RiBPfqBhlYdl1L4PVbXQCWmpK1AgYCbtFPw+uIUiXaEn5rfoCL30L7kJfrmn7AtBmtL/ZuYLYmTJ98yRW6TefsF/o4AVei/ueDx80W0vi7H+x1Gk1xwAfomseOqBtJHS2t9/fSe+CkJR+Hk9cdr1iUdD6He4pxUUH1PU8GsvYfks4aCSoLbLjEUfrCXI73s/+IF9BWfHTzNnziGJwj1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRcvcS/o45leD9i8yt+gUeS343zry6Uh8WCtBuu9Ls4=;
 b=yaKNIVa122JgjQMuOliHhIiCUrd2frK3qqIuKXax+1qn+HQJOcnLQwiQy8xZvGAuwMk/Ceo7D8OrgOftlNA4oZitalZ6K25aw4tALKgLDKOmoYvqCgX0mc8ngq56hV7HycPBgTJwpYCrmd/hwmvInCX1EfP2uAsvd1sPev2B4kOD9LsrVr3I0iepnMVj8Hqh+EP2RZ2TSSia2W9ZPUjMELiHk5N9DdCAtn50RTckuGEJyz9kzOSi4ecx3guo5PqLuZuipgUQs5vl/17H/3A9MlNDsewlOGVoPL66piX2ZAONQWoSKnkh10cYuj2i2q4W2DuWhTD7upD3UOyTj+V3RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRcvcS/o45leD9i8yt+gUeS343zry6Uh8WCtBuu9Ls4=;
 b=GlPFzOlnp1GNFcqMo80cQPauUSOt6jultrtLwmL+Zz8Hg9WjoU+2q+fzhXFiUy8zSEx4I8NZVuoM2uRleAxL/Gw3lYxaq2FxpkrFvQFasbhKe6rpm25CWPnLNfHVpI5WH2JsdiDt4yrCxaJ+SkkyZXUXtW1rXUXMAKiuktv/yck=
Received: from BLAPR03CA0171.namprd03.prod.outlook.com (2603:10b6:208:32f::31)
 by SJ0PR16MB4190.namprd16.prod.outlook.com (2603:10b6:a03:32c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:07:50 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::3f) by BLAPR03CA0171.outlook.office365.com
 (2603:10b6:208:32f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:07:48 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6534tPx41074460
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=TRcvcS/
 o45leD9i8yt+gUeS343zry6Uh8WCtBuu9Ls4=; b=k0eY+RqpkkEt1B8vdsCB3cQ
 BNfwO6MLDs1YlMuBHPLjekuF3GRIYlYaaMY2z3njwBUw/E123grtpAhVS6+V0+HB
 UqZ1u3+IiFAaJir8DLPLVK3J/eR5cVq+0TGeQegRs8OMTx73Yent4Uzan+wO4zZO
 +OfstPRCwQjaSZFieOPwAEm8hRv2kF7iis7zF9F5I32ZmyO9Jk1kfjjJir+vxEla
 R0kIvh64R9YU/NarbUL4HTJzZHIlAFKgao/3MAvjFUAxAYenyOXkgpJAt4lP8Yz4
 2sU+gbnMbyUo60kP9ootsuyFZCUXj2FkgSHJsU3CHOP8TFuWXMAPfOxeXwilJDQ=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=TRcvcS/o45leD9i8yt+gUeS343zry6U
 h8WCtBuu9Ls4=; b=Z7v0uGKbSkBncsNFh8pYwv8aJSclH392KhJFiIewepJq6VO
 dYCyR7PKZ/3s8bbs+NVbbLSZ25M28zH+doUyKsYPigTnNXEvaX3t/BrR7vkBU9Mn
 HLDQ9sNAbwjsvKefA0mSr4v+abk9VT3aapYR4y+Be2ehKFpP0aDTjI6B2IhPMPp+
 LNQJzQyS6wYfpBCzVVgA6MKtDfFVVcn2vClmqsPUA0tK6eCqYc6cb29hCwhW2qQq
 NJfYDscK/G8ShJ12IM+WnY8gdcMPY/2Mi7PLT9ZqBsnSmM7EETKOv0VeuR1nH3HQ
 TC1/GEfz9KCGLLGECCKCoqqOdG+qExdY5W3kZGA==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egexd4kn1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:48 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id UfhZwYdS2KoqdUfhawSuZa; Wed, 03 Jun 2026 07:07:47 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UfhZwYdS2KoqdUfhawSuZa
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 0/7] reset: add board reset type
Date: Wed,  3 Jun 2026 00:07:36 -0700
Message-ID: <20260603070743.1268544-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SJ0PR16MB4190:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 454d54b5-aa8f-45bc-3ddd-08dec13ed218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|6133799003|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: vBlODrxEPsdV8wDVmR9PdyxbepZEhtjhlbyJjQbZyH9Cpa+qsNylrq9DzGtX7trCjSye/nnQKffkzjvgrRsxaDHVsNiOQfXG9TxNWzCEFFp/U4QCMSU7wjLViTSH0KYHx/iGmu61tXqu+V+rm0/ycHwqiKoYWUXH15lJUML6NA1buNvLAeiwaeWbKt0z+9tTBXoUkJyzA3FO47zlKCCAnuee/M4s8cyM98Whz3X0OzjBd9DSSzs4vByRrR7SObCwDIDWGL7Xz7BH9BYuYjOPga1O9FO5y0DNoSS4y2jepDqjq/Jpo5q6slmHuxWRe/OYyLLkab3GDSTFJk5+G4WwiNK+dJ60SB70fXhz8bMT1nOW4sIFK/b34GoGTvM9l6/fWWKwQQD4LVSzinV/5XdLVslJP1gybIZq/OOTjpys6I909IXEVIxd3I5JvNaomqleMOUyXrrbExbkihRAyKphSEi7HKs/uWs98pm2/pqhKmxB7uPCvMcjT/5ElDgzOgZaXJHQUQdtQ1JOL1vJ/4xaMggE1eNFZAdHKMjysYl2ECJLn/3ph3P6cwVurxAkNf23NDLI2ZjTzlJ7yFk2uk5medYG8K0ZYqpqtbkcazq6Q5VuMJPwkd00GYvTZ6/dJFqCC6++D5ror8thA2eLX8/ah2wrMudtSkLf+0vXNDdZXz15zGAymrG/XTMuC0Y/wQdADI3hUPB0j02rCCjdAzM/ayr0Ne0WN2eoJPpDDPzh1THxpYaZ7qnf8yjfuwcATUMl
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(6133799003)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /aCLjOnfLS9G1IX2tQERrpm911Dz5FUXVoOrjuI9MbAz4GdyHvN7LQlvtiDkTruoGSIgmY0DmPKYPhvFuDQHLLd//KrWkv9A1wHMc6EnsNCnXZkJ/nipGBXFc1jomqFmJOmN0l6xYdnWuK7pXhEpRXJVnYXoHWsYmcVVXbYoOje4+Am+R44+BK1SrFbDv7NrS1QrHfP+mnj+Zeppo0yVUISGTfVuxsfv9mu1M8ydSBWaKa5RN45kRvOafXwLv8N8TzP+EtfMo7+Stfq75xN/0ZX9AMnmL20xx1t3yI2vTojVBmRLK4vkdV3lVOUIMdbHcVR0p7i3B3Ic1r7iNcKEvdm2HmXMtUXbnA8NeGf1AYhouYiYHxZKXn2Fxwl50c2ltBGfd6yrTfz9pU73ySXgeGgs1Zux1S+e8uojyEp4aVmAwlxMr1tNCAtyxf25i7Nf
X-Exchange-RoutingPolicyChecked: jpZIezbPiw5K4rG3hjw5qRiEsj9sw3c+DZ1oVjRScQZuzmgPz+Upa5GdbDftBJZLFW0S0vzlU6vOt9Vq81ifMXu03RxHcG7x5k9zntOSNRsG+l9LfPrSoX3+hoE7LDH6hzqWcccEWPhSNLTTjniCNUU4TeJAqx9do2NhAuSV+q+/5cuol1XB9viX7SX1zYSj8fIK7inYLOerpWfxWF30ztDkwzbxCfrRiJYa/zg9E0ZR5TOzVe+/HWrQD1spaHJg/Je8rfdp2Rm6q0a9lgn6hDCLmm0HGgTXXycQwWAjf5jIA2MZQPs9ZAY+Oi7CCM+Zcmn4iwG4bl2zein3skjk3A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9MNVkBCtiyAGeQR3s3dF+ouy50tYCv1lqnbuQ2vNK0efyu1mCD5DW7hfD4KgWqpjTSHOT5wMxdIxvukCdQKyete99bSHexfOdMZq06R2G7mL2rzJ+nA6jVhhOS5sxVt8d5CqdqMee1ShwKjLz52/9C7BNr9EqVH+UASFQwKn4sSHXywgoCzwBnTm+J+GclErcbrqaDLGf5ZVrXpBtxIUfhlJQDcsQ+tuIWurq5178xwslTCA9VboQKJjjC+QmOw4QVCHCEWAHYI2UHIs/BBnUy3oRjTfXsY3p5haQ3B2K2hDh4xGSa7TFZgy01DWHaQy/bK+SHJv7JKrOeOa6PSdj16a9TFLXiD1Q8PdMY/HWaCBU9MQXWS3mW4EPKxPKidhBQ7SAYn0ZYnAeFg9VDzkXPC/5B+pqHJxeC99aK8hNgtxehUEUZXhw1sFgjWXaezDP+P5BeIRnPCl+uIEQmAnBnBlgpCOF8YBpDIAbN8BlEUq01PcshK5uAPPVNfeNFumoeQ3PYDQx5SfSjJGVvIw1yruVkJUouiMQz240H9Oe3Q19hnL4cnh6bJur1OTB7dRqhNJqUs3Xs+R22HDuvKLY2c4uO+ho62AYylK4q3gSU05NWGItYsJKfqtXAghFAyd
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:07:48.9237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 454d54b5-aa8f-45bc-3ddd-08dec13ed218
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB4190
X-Authority-Analysis: v=2.4 cv=Cb04Irrl c=1 sm=1 tr=0 ts=6a1fd2c9 cx=c_pps
 a=cAYAfY5XwGGlFG+HVYY7CQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=T6tav2ulMAw4HyuCmNoA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: BTKfCMcuwhm_VjcmDyJvalcONV48X3-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NiBTYWx0ZWRfX5b6ppoL/0QlK
 om1rVjGzJ6XaZVjLgULg7+Oh865LZkibi01UoDbjqfrmsh+ZOa4qgQczVp3pVYoQ9wphGY+jy3F
 CxVLevPY26QcYTClXjOLRPpF8bVRJbfLT5WUjwcqGfKWprovy9dQ7bwtdT/WTIHpL4F3cIH5vkb
 FC1x9jmUUhPCZNd4NViY+e248vLZin/ftK4G7Zm0Fewn64wSTWkfORePIvkFmk/gKPSYDojfpJF
 HSwfxBLotsdvOFHCs+lUW7pBwfHiSqFwn5S47y7/Gvwo3m2R/9k4g3qkLm5MJWhi3lTeLiyUQJp
 AoPhWYuvxdqL79QaE96jhkPQG+9VmvbXs+PMP6qAJn+dMbNBmvsvpGGY1ZfGcw89ZRsxwv0yOSV
 tJopCimWslt7bTlMm4slyJFX20sC6snfx7a1RsMfpvgXxl/p4KnvaVUYreKxMsKYPKyZdF259wL
 hA+Cw5ta9xB4giUeAUA==
X-Proofpoint-GUID: BTKfCMcuwhm_VjcmDyJvalcONV48X3-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
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

This series introduces convenience functionality for prototype boards
where reset is not fully working - for example, where only warm reset is
functional, but cold reset must still be enabled for the production
variant.

Patch 1 allows per-board default reset override.
Patch 2 adds `reset -c` support to explicitly trigger cold reset.
Patch 3 adds reset type printout on the console.
Patch 4 introduces a small fixup for the x86 reset driver.
Patch 5 introduces a small fixup for the x86 EFI reset driver.
Patch 6 updates documentation for reset command.
Patch 7 updates reset command tests.

Link to v3: https://lore.kernel.org/u-boot/20260529034839.2075806-1-dmukhin@ford.com

Denis Mukhin (7):
  reset: Allow per-board reset type
  reset: Add explicit cold reset support
  reset: Print reset type on diagnostic console
  reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
  reset: x86: Use cpu_hlt() in efi_reset_system()
  docs: reset: document cold reset option
  tests: reset: add cold/warm reset types

 cmd/boot.c                         |  3 +-
 doc/usage/cmd/reset.rst            | 11 +++++---
 drivers/sysreset/Kconfig           | 27 ++++++++++++++++++
 drivers/sysreset/sysreset-uclass.c | 44 +++++++++++++++++++++++++++---
 drivers/sysreset/sysreset_x86.c    |  5 ++--
 test/py/tests/test_reset.py        |  8 +++---
 6 files changed, 83 insertions(+), 15 deletions(-)

-- 
2.54.0

