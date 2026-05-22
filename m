Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5CDCD5BAB
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:16:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9061F8490A;
	Fri, 22 May 2026 04:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="QXZnLgNn";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="klKNpmFn";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="CPPh4tgg";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="fB0dYDZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF47C84876; Fri, 22 May 2026 03:23:41 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBF7847B0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367127.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LKEli03341940
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=YEx
 Kz71yfNawKu4sdtkZTKEzYdk67cwkJsfFHjeLZ1o=; b=QXZnLgNnSSGk/gUf5vy
 +zRBXY7aujsZaYXEIWGV9CTMANS0iUA9jptIrwljNcBYOL3yLd3SbMZhXL42T2di
 SN66IVYDp5CTUmauEOD/TLoy4/uWIOh+oRYjgeKff3+JtZwQC7ceQWtF25lgDX+I
 bNTrUN3gi5ttYA0QA8qoG/3xREcG34tOwGQur6/caKOCoIiEs8FiNWVa9b0GV8X0
 xDk4PigLytG1e0xs6UCjoSwSmdcWRZDBm7YCpasdH/tfmPJ6TyITzueYMFh3ZSZi
 BNQCHN4BUWsNvXPSUYUrld2nxJ8vVKEqRFpp41LAlBE0lIW1ia9lRuaJHWINfl0q
 zUQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ea5t3ut4t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:23:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQxKZodt44h1u9M5L/s7m8xUYDHX2DyDOOot980ROWiIhv1aQKhPfzgx+16ZIWDhwr76Sb93ECjuuQPHhbiHQxKbMM2J7RAvGPvrEb4xs7dYtxwrTuPlJ+ApoJdkMyvO8TdbrdcHKP/VAEKEaE0JrODmC8roNxYKZhNrnQPtVmxhqvdVJW/YGsWlNRX313qKC6pEqa5DkBJGYab8j6TJ0mchGJlbrscILQfi88RJGnvUHSOm5poe2M8ZIkPYvISskbjY0+7xPm8+SpLOsR8fpNMWylmfywm5oN2TPWR2aZd3iiIvjpDseaIitz5gt5AMdCoB44n6ODtrM2Nu26hIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YExKz71yfNawKu4sdtkZTKEzYdk67cwkJsfFHjeLZ1o=;
 b=lOaETWzTSMeBN2L+fV8fwTglVXFmYamKxA4EM82sJWuiBRjtiaLzFIsJgwOoMb6VrNARe6Bu8xyi9k9X8jTDE97LfcpU/G31YK8XVDGz2yfQT84vWXeJj4CGVXmdu4yvg0mXqEWc36JBNQmZG8cDpwaXcj2oP56Ra2klfYQN655r4vfaICXC9Edr2Cf0yh/t6is6X/EMZqDtb825Yn9Mxn1Pu+MfzpUqlsDtJJIpwZwmS+HT1miojdX9nzs/NTLJu7GcwnW/D8xg/z9MaXPnQ0Z7FlVQtY4OF+Hiq4scxAD0YFLCOp4Pcxxt5fZwymPeoLJKVe3PxtaaZXeF490Ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YExKz71yfNawKu4sdtkZTKEzYdk67cwkJsfFHjeLZ1o=;
 b=klKNpmFn3p02bTDvgpjG/VIHqu+N8TSk56Yg+n5Dt5v1IDbbxxl8i7xHnWjkul9moCA2iZeLFLKF5ixC0Uo+dzAxxqDhhCq43Zbnhv+s2pc/5uyGGJwbUPsV1kwllyhPdYMT9/5xeGWg9pe9cQ0l5E5ZBjXGNbO+DdG/OlfiyYg=
Received: from SJ0PR05CA0037.namprd05.prod.outlook.com (2603:10b6:a03:33f::12)
 by MW5PR16MB5079.namprd16.prod.outlook.com (2603:10b6:303:1cf::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 01:23:34 +0000
Received: from MWH0EPF000C618A.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::39) by SJ0PR05CA0037.outlook.office365.com
 (2603:10b6:a03:33f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.8 via Frontend Transport; Fri, 22
 May 2026 01:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MWH0EPF000C618A.mail.protection.outlook.com (10.167.249.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Fri, 22 May 2026 01:23:33 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0fIEZ3362593
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=YExKz71yfNawKu4sdtkZTKEzYdk67cwkJsfFHjeLZ1o=; b=
 CPPh4tgg+RwQUnht++787dZ61wXb7pdKASCgTU8hBtXssGsN71cfKmNfIj4RqrmO
 Z3s5s2PME+B6dd5giY8kOwCs2jesG9pYhg/hcIpElCi2A7UOw2Ay657yyzFg2/bH
 8neQWoKuuQsTNczwVeA9bbDG/r4ooZUy+wlaTK8tvjnBF96RNwV8WPBQtp4+mpmZ
 Pv+n8M9d/4J5ljL+EaDxlIpQuOlitFK4szBuQQsD9+lMvWXVf3rI7hOMb/U56JWM
 qw35+Rfbme5/nZyOmWyNHBEwXjrNURtEULW5VuXLPRs5+GpB+D63Kuq5Qpm+QLuE
 ETLocEDZdZxXegHoCxT6pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=YExKz71
 yfNawKu4sdtkZTKEzYdk67cwkJsfFHjeLZ1o=; b=fB0dYDZu7lm5rcQJi/XV5Ic
 1vrcAUHGZU9xtAWHUp0RZjbLxkGUEjRuSqmJGt2pDzDuaFhtR6nCnDVIGd/T130v
 aJBhmZuYuZlE72QkNIMurJmOzYTgDMos04NdagffNNOSYhVlMV8Gv1tD/zf+miDX
 6+WcbQzf5XT8p8aZisnxpSSb9t2CvBlCc8B7TpiQ5O7aR4EHlGVTMiNzagTUcHme
 kfOxO/BtSkArwd3BDlsCKZRGaB3Hoo5I+41E0UlOSVgt40CrAmDU+gctxp+2Z8zE
 clUzS6Ry83xBS8z7HV+9TLFGaZq4WhzsqYRGe0nU6+qOrd+0DuIV+JmSbOnpiGA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eactj8112-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:32 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id QEbpw9sWetgXKQEbqwNHkX; Fri, 22 May 2026 01:23:31 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: QEbpw9sWetgXKQEbqwNHkX
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 3/4] reset: Print reset type on diagnostic console
Date: Thu, 21 May 2026 18:23:11 -0700
Message-ID: <20260522012312.860026-4-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522012312.860026-1-dmukhin@ford.com>
References: <20260522012312.860026-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220011
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618A:EE_|MW5PR16MB5079:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23ce8f07-19cb-48fb-6c3a-08deb7a0bd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IShH+ZUJdQ/4vf2aGx3oBQ0VinfBzOq644IW+YyYOs8xfnNAlwBFDfN4xn69BEHIpvUjXBychMexU9uk6+E9+ByOI5nv/z3+bUvIom3L6BlJQxrXH368+HOnnobvjeKqHqCQ6Z6CR7shNQ5eA7tQr9F6Ym4pkOvRBxlOFzJi/VwPGhZBrTK22XepqmmhCvU7rHo9+jXQ2r47EBUsZnbbZfefqyEoazAuLW/7NBENErMERU+RYVTtotB76tmAFRJjcwAi106KnZW3cbs5dmxLUITkC7a4G+kXM8lAXa580C1LHGhHn1QGr/nNY/OeaTaEPwCyTZ+4rxRnmC60os3nnWwSVxxd2lLPzGKZudZuOnN7KJiKdj5pJxAgJEHdPafFJBSBPHPZXPTqq83GnolmEYr/Q7OyVa1k9ZxCMXKgciT5C7FWsXUD9Tz1fdud8iqbfuDU3gn3prdEu/fuhsVAFnB5uah9AinUFvH88ibAJpai0RjrjQHhoydaNfMqyzgYH9CN0/sOvH3oS+nh/s8X+hTcnU/1Fm8iVrNxACwd2T4KLjdmyWlc2OpnJ4GOpfa5iaNA01rWxtu7qADwCrHuy8Ys6DFZMhD6BMDX0L/NTw59FDkkICLhcw7aCA6utmQN/IWAyDvF5L1IFJjHHoP/I8dVRohnYoyes2M5JqEpfEpq0t/guOQaVxwLPjs4Nb9jXqThn1hqKB7OtOJfuUw8QLorgAcGHGKxIJlGlNnp8J0=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CpREv8P0iF0YQOFlMzeiN5cGQkxAQnY4F0B8zHeDZfVhf541E5vC6hI3a1O0boAw3wb6xwYVhRRE/lYM28lbyxdqh8V/HKik16ZBGI15qLbo8BI6ciKel5SqhsMtTSnhz0aAoTYzU69XK44lCM8rehzKVRW6GLIk2Sk1UpVTlRxbqgUruNJcVM9hnTc6Lv5KvE8VuUYwiSrt5swpN9FE0WweKODiXCQ0BEC9IFfSIgtBFal24BRO3w/O/K1s8qtI5rZMiS7Q4kLKbc0kElwkZFAqbO06gjVMDYYDWWW2oH1Ye7czb4wLCDVM8zRLxkSDIPAvO0cgI4jRkgYyudPw3mUb9HBwGYCVc9Ezs5+Yb5C6Dj4vFXTMMB1JUknN8vo2wjCatetLi4OTWg+NB0LbGRHfu/snDtp66zsV6RT1+jLwkItkmu0vaJYqce+GCE6P
X-Exchange-RoutingPolicyChecked: P1CjXDoD4TorV/107/59zJp/dorw5MlKjQZ9MoZma6S/39C7cVYF2QrZWcHwbI3UjrLNzKr+C0D6EcS4Ep7qNZd6PohqqLRcvmrm6rmNVNmD9MrDlNg9UF2MWJVwRbXUxDvlt0H4Ohmq7izc1ghCCxX+12eHH7/beLu3qRCigtvqYCqeKxgRzLxh+30/hsnJ4wwwNbjiFDoMb1MOci29fmKWMj8CBibSR7PBE1mvP+IDMKulypw4xef1fhsYyzX2LiCAB5AdF2vxJHdB3h6rJjWlN0ohxzMOcWS67Hxt4tjuhC4c18WfIO5tW/d7YtD2Gx+T9xqxgen0TcjCXAcjrg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9/fWwf28fvY8RUCh3PGdz1r8L6OSiJ35Mvp5wxAWweFxghopXwhzGgKBkTgQSb4FV8+jb8qKYjThg2/oFGF7L00x0Evky4aBepRwerg0Hx3/E9D4VON7g5yU1Daj8hh+O7cQT6lNNtZnMdIclvND7LaPpvbdcTVQQ45JZWPJ9/qxLySTrPzUh0ROgK6PpV5mk443JNOjcV7xILQz8hSJiQNVfXsqmgblg6u9nEroGV92SzwtCUnxjDosegUDvC4b84cYoEQMQxEgX3308+ZTXvVdQERCsxT2TP6rt0rZvwEA/9g3kTA2S8FVyG0sE6Vd8Tn3cFBsuZpF/Z6kWZGF1YfrKhoGfjTVEU2qWasLPAJHvNooDxZurI6ZuAuAJxyogJ/7naUkD2IhVQOLuJrik9Vnf7UNjFrCNnRQiOJKAdX8+Y+pUr4NzbfrjP3SxZ0jNjbFILgUZ5rXqoZm7KAG8Wzjztr4adIsQ601+Fr15d47BU6liEi0HatJlQ7yJ6kEPLpAkbU3ZJR3PTgHFyccE7usHC2VO/v30LbrH3j6AtMnfgx1TwJMQ6DqvBmYBmU9FBnVYqXdnL2aLK788NoTbGBzIyORABPumeOayuswPccIZr8ACpjfqp9+tUUkeMP1//hdVZFXgNyJn6ihP4OZgw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:23:33.2702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ce8f07-19cb-48fb-6c3a-08deb7a0bd7d
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR16MB5079
X-Authority-Analysis: v=2.4 cv=YNuvDxGx c=1 sm=1 tr=0 ts=6a0fb019 cx=c_pps
 a=p4VQxza1WQsAsw6m3tlBZg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=dw5MciS7gY-znkhJuOLE:22 a=cbNQJ9GKAAAA:8
 a=23Llz5wl3KhMZEueFL0A:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-GUID: jXFXYqmzFOSF0Ztp6vuhT2c9TxDTUCaU
X-Proofpoint-ORIG-GUID: jXFXYqmzFOSF0Ztp6vuhT2c9TxDTUCaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAxMSBTYWx0ZWRfX2tX0hX4K4VIj
 Br+nWi5SyL4nIwJups771NfxaHkBW3nZGnGtj+j0/RkcTnVyWAHjFugybTa/Da20VQSD8gInI8q
 7kp4eFO6RGw5MriPZurRENC62fJ8dnyQxYqTzr/WvxJMK0ScjjXFCT9vwwDYVJxq1SNGWbw72tC
 /ad8k1kD5HGqvtVh6jRc2cvpYraRaF3TB/TigoprPiYlijkFeTUNPqykPRPf8vMOmQXx614IoLo
 haOoT7Gf3pGcuhc3XIYVguMLbECn1N2LSEct+eSaGodbOiHJMNVWeVypQXpZwcR7swS57FYBh0W
 uFwC740Bdupg0ufHj1rqV5AMYv0WTqpMxq2grvG6cmRw7i2gx0GxOAhHJZWK8OwHRQxkca3cm6B
 y5dqlpSGW/BRDQG+Amvn36LNMXatA4TDLa5M6/MdL1iWDQdXUA+WPFhu154bIJlCnxJXQ9YsRJK
 Gio2XSNQ/M0hNXWutEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220011
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

Add a diagnostic console trace indicating the reset type.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index d893c74e9121..8af370e0fa8b 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -22,6 +22,22 @@
 #include <linux/err.h>
 #include <asm/global_data.h>
 
+static const char *get_reset_type_str(enum sysreset_t reset_type)
+{
+	switch (reset_type) {
+	case SYSRESET_WARM:
+		return "warm";
+	case SYSRESET_COLD:
+		return "cold";
+	case SYSRESET_POWER:
+		return "PMIC";
+	case SYSRESET_POWER_OFF:
+		return "power off";
+	default:
+		return "unknown";
+	}
+}
+
 int sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
 	struct sysreset_ops *ops = sysreset_get_ops(dev);
@@ -169,7 +185,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			reset_type = SYSRESET_COLD;
 	}
 
-	printf("resetting ...\n");
+	printf("resetting (%s)...\n", get_reset_type_str(reset_type));
 	mdelay(100);
 
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
-- 
2.54.0

