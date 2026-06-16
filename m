Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1E2CD8CA8
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 06:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0852C848BA;
	Tue, 16 Jun 2026 08:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="vThfcfXu";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="XMGpP/lG";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="R/JmxDJ0";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="qs+s4CSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C574848BA; Tue, 16 Jun 2026 08:36:22 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD94284869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 08:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65G65sKl1617738
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:36:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=+va
 zVtwXyM9TGVOPo0rvTZb6PyQimipHC85q9IdxDqo=; b=vThfcfXu4/4dYPwI4pU
 cIootUlXdHbuGJFX2XNnggEdKJZLxKrlNPK6jp6L1DgN/VePUTakS63QLQkHz0aw
 AxurkPjvQEWLp5TIKMa19+oICMTmB2JATnrgul5VrfUjS6+ykiQsQXMANZAxUmbl
 omPU+PWTaBy3Uw5w6aC1ogaKfv51X2u5VhVdCqKUf/wYQHVYu+CmhhdWkF2ajgAk
 fZRNC2EdD3tW2qHvbblsP9ibWQrH1CSUeGxkJ7x6jZOveYZBFKbzzURn1+Jy/2B9
 jibbZLKAl5dpfNj1EjQshAs9V9Vb/KupnCNJIZVMamPK4khZ5042Nd28LXzt07lI
 VLA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by m0482515.ppops.net (PPS) with ESMTPS id 4etup61xes-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLiRie1TQ4zQnEv+0JE/km2Ur9K01gjaCfGxILUDySgjpGa1wVU4lPXbS/1qEDnPVWefV2sLKGf5yumu0Ittb/Rn6AqSrm3zDxc23r3xMNgW9mCdrE17CNcf7qxeEwYtYpXmwo05szQW1Cw16V+T3eRu4G7aEMsvYKuPn4JBVKxNcZPSGernfqxrQdjSw17jVL8brKe+v7ZBRPDHJK+Dh4zPXRmqHdaJE7R9Sp5Aw0UNzslHx4M4ArCpxXok/SjH/9LUVM+KeLb4p97w0zmvT8nt1h+RzHVPaXbjO0npIqtXUspCWItD4KTPdcJDVM0oMnqtBCFMtuPQ3yoFrfCQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vazVtwXyM9TGVOPo0rvTZb6PyQimipHC85q9IdxDqo=;
 b=sqxKpg060S4x/MwF3lj+Puo7IAPJp7E878hVtKnga6VSObzkpvIscPKwKzXyrYCVcOBQqz2aL0faQeHVQChogkXjcAoiws65tD7jjRDCOuoXiTEyL70aXzHSLNpfPwYaLyh8IhmDQOcR9jUQscV2w+RTUGjyHUVDs8wUuY3LrkQsvdojoSBFrU0ITObSn/FZ136bwJaKnmYNU0+iwqSwXgR676RkKbr9R3cZJF3Ejmyw/vPjGbGByxRsxByaJu43I3Tde4ZeUENDxbcHZJrWXcxcd6Ju6daNZlLexUPE+T7+V/ULaRZf4LJJkNrB8ot7vBRFEvitT4DIDUNDWwEKYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vazVtwXyM9TGVOPo0rvTZb6PyQimipHC85q9IdxDqo=;
 b=XMGpP/lG0DcerjQSIYOPiB/QTzsyDDeBZ8lIQ9LorqyX+c+2okrpBdTu39Jiw0bp/ZmR6A2Q7nM9QApjjWSGpkOy4C+H9+nqX77B8LRWngMU7i+ot2pZHkSYsSIr3VcaKIuuiwCDOAhzqN2obhBXAljgVO0W6SxQ+vAOxzJKdYc=
Received: from SJ0PR03CA0082.namprd03.prod.outlook.com (2603:10b6:a03:331::27)
 by EA2PR16MB5673.namprd16.prod.outlook.com (2603:10b6:303:259::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:36:15 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::26) by SJ0PR03CA0082.outlook.office365.com
 (2603:10b6:a03:331::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 06:36:14 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G65Cvo3706582
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=+vazVtwXyM9TGVOPo0rvTZb6PyQimipHC85q9IdxDqo=; b=
 R/JmxDJ04WojOrdzWwshfjF7mZ0CsKbPS4s33XcIEZKMX4iDOvgWGw6ujceCVNRq
 0bvuGGwUjWZcgCVM3QlKcHQODHOiL+6zTiJ2vDEtXNwPQMDih0vBaTQrQcyk9XI2
 e5+OT2FMtNvcnq9aijQ3NCMbWVFy6hUtb/9HK7c+GxLQZxyken2j39UyUs4vCcZf
 W2nTKktr4QBoHjTkCoTX0z96G2MItzOCteYjQ30FjHmIFMotE3/RGFAAftxBzEaD
 cwmgST1nG8EQJ/OLGh2PiwIJhJY2zWGuRbwXRsMajjIPU1hiibL1ZRBRx7wlaiws
 /0hrQCht3GosCzjtC8eSDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=+vazVtw
 XyM9TGVOPo0rvTZb6PyQimipHC85q9IdxDqo=; b=qs+s4CSUgi+BalCyEAmivZM
 GNtABERZLUHr1+1soHzUeJhnInhOhKL69FAeF3a26tbGcyMgjcmFboaH9yrfGvv+
 5ABH+ZjQCgvYDeIWG3vtXeLjzF6xI2QiEgoeSFpkYH+wPTrr3HaIGjfEWqO5AdvL
 5Y8xcd4uV+YGd0pHYz8SGNf2LOSesBRLH2t7C4LQYUD4KDZaXPpniFIwxusY5FeH
 2o2s9zxz1ovsq69+NLEdYByHXUEjQJ7Xb3clZRUhtprIFdObjEiharfRM9IYUfYO
 qj9LENpdRNUPZrcIRnv5RIqo3G/Gme4cKZR2ZHrwbOKq7zn/Ddx5mj+ReECDfwQ=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4esnu7anxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:36:13 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id ZNP8wY1GHKoqdZNP9wuDQ2; Tue, 16 Jun 2026 06:36:12 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: ZNP8wY1GHKoqdZNP9wuDQ2
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 1/3] bootdev: fix typos
Date: Mon, 15 Jun 2026 23:36:04 -0700
Message-ID: <20260616063606.825688-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616063606.825688-1-dmukhin@ford.com>
References: <20260616063606.825688-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160063
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|EA2PR16MB5673:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0695ef16-d22b-455d-be8e-08decb71906d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: FMBETHihtjKt0zXxh3yDdcHNuCoH1hZaoz9GUU0czErCYjWt5kyfmvGFANp+34se4C4BUISw/Jbxy1ClGzqaSZbDOPHtHdSVLK/nVOs+XPbW3gerJwp7BrUQv5BjpjZDBiMA5sp2BC+MfZd0DM0Yn60BmQreZ2Ez7QhW+EscXXeC1H+sQejTdJ6oHLu4ceTRB7I/8SaOEEfWxqEzg16KcdLDQJtqfuI48NF76VkcYtZR4J8AK4qMKL7flvktBt/5AM9GwqWnBuOJyofzel/sf4C77iRrwZUnBTm1/LBrlcfz+J1Rf4wTwXD+tiPH7gDROTBoO6KZo7SYeXjofQ3WImhhktjQX0eycPdMEC2VB5/ynCfjyq/epUXKVf7ZeW4ohwWsB0S2Cb3RcY5x2xOhhzvtjIGEodXmWDeNCCnSTrHSx9K/GLxpkCIuWPrOvmtnXnii9z7CHYvrVHWrRhSH0JJOdNlVAU1FVHPZdTKERJKBdKDnvz3FApvP+BR+cEQm3GfN3YDj18grXiTFuaIvjgEVqq+Fi6DHB8HACFU7CtTqvTAE76oZgp5XsrRKvUHWr7Pj2HyfNYgGjvT+Mx/rJKkugq+Aa4dyaDiJonTTAAsGmDgIA+y7gA5xxq8FszLz6cSyjuJOVDMPpRqjxUmEPA/QN5owdobFaR0SB3tgbJR62z4+cBA/WfUlduJnIfhOji+mRzLcbCErB/yfF8KWLpQ0h6ce97Zjuan+WQhqrY8=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aMnoCkYbw9mM5pn29pdAFTAHKjxeOo1Fa/3Q+DZhwv9TFSeHFW/cqmEBvesVo8Bv4axBoB6PjnfW5MsRJgJIVCld/E48Fe45PWygd3Eb9r3tims0bVuCJuj0f+KkH8oUKxe4G2TnCBZw+8HuksA9eU/jVXZMXfq2OzgkJnw0Lty7c62MxNPB8MFdhCc9XAuaKRQfKKUKSgPy6Ke5MXi6AiGSuiXrqz8wqLbPGscmxHXoVzyuz36Qetss7uBXtv20g7d3Qt7H2Y/duzwsqbYhLEJoQfKFaYSRd8T8b1Je91ABHeUfnBrKxcbend+iBY1zBunYi4M7cs0VqlcK6eY4vloQLj4HYI/BFTDRwvd+X+HIjc7/0w4ySS1UR3CkJQsU83Q/8UmzivOX/QFbuy2eln60dzfgKvtYFugEK8U5EgtH5R2fDKuDAjq2//+8tq1j
X-Exchange-RoutingPolicyChecked: VImoPp+3YIbhWnZEKZldql4gXsOJT2yf0iy5ALATiKPO/4hA/pd5OoXNumXAbcdiaOvC7J7IMHC1jd7v7o6OjlCH3Fg/OoD1tvEaiMIc+t6JuYkwrJ96KemwAobqI0zkdswSwZw6GgM3ajkcie66eMqtxTNg8xzToae+HDzYKHzQXGc7QlgOkG6OVghewdkQFIegucYkyMwKu/abIRowoGQ7r4s1E85Q+w2dsF+RQTAZ2EzSJW9gi7b03CJZGjG4HzGX2RZ7epQZHWuU3uKaCP52nBrFAg6pfvvIw9KCxE7Ua9EeM1wkKs/V8SM3I+fAf3BOwQrthKtv0Bdl/Ok47g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZK3MlWjzRgeezrNNAFTtEM7b0oh/OEkTJWumijeCS7RbjY9jtOLBLkv7Bcw5/YYTzgMTguRa008mXl7PEYaIP5HqegXJkISvkL9WZSXtm5ls+0n0nz6uXP9fvwr1ZDKYa+Qwwn62vz9BJZrH5YH5gBI7wE6IsKW/ToMBapcj6FDGx1guAjpBM5VRHLVtLtoYmYESUys1saz1yzISsdBwGRdd15CRufdpmXyfS31pE3GAZJfwzF4aaYrZcJTelAQ6kX2t+WE/3EXigvcQCQK+EhbUB2x+0ey/fuLMs2Dn9vBakWzs3wSNPeqZ0nzvrbke6gsD+lrqHKU1Ser2n4nqdPL5+oYyQPD7/VJSiaEQKQ7tN27a0GaI/EzhKItfBAWgxs96FXu+mkcdbuCer/x9T5IXcl/rAzB38XqyCvr5o+ZhDERgq8CildMMJdiVGu1Qiz5lAX7EIr3jpvmoMkytio4gAKJRFlxaOt9+YbqM6uB3EqBn97/kTMsla7yOMg8R58N53UhowgiPjbZtIsV/yU8OCY1YrJDa2K9lk4an9Q+b6bb5CiCXHnN+BGbtKmM3lp1XGD1UP7UBHka227w+maLd7CxtSGXd0tHVIQ1p2qq3KRwes5gTqpnf+CKntad184PlbVt7GLttPGr1URdsbg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:36:14.5230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0695ef16-d22b-455d-be8e-08decb71906d
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR16MB5673
X-Authority-Analysis: v=2.4 cv=H7PrBeYi c=1 sm=1 tr=0 ts=6a30eee2 cx=c_pps
 a=gBbgJzl4OEn/1oy4V0Rvig==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22 a=cbNQJ9GKAAAA:8
 a=cm27Pg_UAAAA:8 a=8pUfwE4-Zr-z-6C-i9sA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: Wq4oqF4sIxZhDT2rg0tb0gDrgpHQ6ObC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfXzlRK9UiDkxhc
 U5I1Rbi6VMqRbjnFWvo7xcqZ4aKRnLZMkWnDXfTUaNxLNbUsIx+VeqRmKpaS2osdfMhZnWeGY7l
 KHwUxSu6xMoSPUUPqqHrVtXpBnHltG47wkKy6jOOtDmFfJZinB/w
X-Proofpoint-GUID: Wq4oqF4sIxZhDT2rg0tb0gDrgpHQ6ObC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MyBTYWx0ZWRfXwV1nvj2bmKFX
 xXOr0mRa50mIRaMXneMPyLRjC593wSRCGgE7zUQtvoDBkwdLwxuxM0AgcgYl/78JfThVxS3iIdg
 zF9hbH3SDdpbcAZ7EGn1x60yH/FWnRDnuSDaZLz2O5rEbaiei1wnHiSj9585k5DJL259JKQFofe
 aJ2MDhGMaHQsUfO07ZQJ6k3bE+8m2mrfmZOXA8sPNo1vnYt4fCvji9zBQt7WfVpjK3ArO2qMQYc
 L7lV4PD5DBBRYgswwnZlkbI6kC6jjeApAg5fGEL/RoYWJy6p6F82rzU3yDMA30azqu4yYRElPEA
 SioclALpThqYYk56jj3NA3Rpsnn3zALEQymvfklMynZrlUnrdjr6YZmfG6uxqq8oImyNe0N5P4e
 6VwxUmh1IwdfjU8ZG2nj6pv8gss/X2R0V6TChov7GR05DxcneRTi+sp9v12pFiOkSNsNDsSmrGZ
 ECOjI0Lj+VY9dpa1UAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
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

From: Denis Mukhin <dmukhin@ford.com> 

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v1:
- added Heinrich's R-b
- added Simon's R-b
---
 include/bootdev.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/bootdev.h b/include/bootdev.h
index 12c90c4ec1ba..14f8a98633b3 100644
--- a/include/bootdev.h
+++ b/include/bootdev.h
@@ -30,10 +30,10 @@ struct udevice;
  * generally very quick to access, e.g. less than 100ms
  * @BOOTDEVP_3_INTERNAL_SLOW: Internal devices which don't need scanning but
  * take a significant fraction of a second to access
- * @BOOTDEVP_4_SCAN_FAST: Extenal devices which need scanning or bus
+ * @BOOTDEVP_4_SCAN_FAST: External devices which need scanning or bus
  * enumeration to find, but this enumeration happens quickly, typically under
  * 100ms
- * @BOOTDEVP_5_SCAN_SLOW: Extenal devices which need scanning or bus
+ * @BOOTDEVP_5_SCAN_SLOW: External devices which need scanning or bus
  * enumeration to find. The enumeration takes significant fraction of a second
  * to complete
  * @BOOTDEVP_6_NET_BASE: Basic network devices which are quickly and easily
@@ -327,7 +327,7 @@ int bootdev_hunt_and_find_by_label(const char *label, struct udevice **devp,
  * Bootdev scanners are used as needed. For example a label "mmc1" results in
  * running the "mmc" bootdrv.
  *
- * @iter: Interation info, containing iter->cur_label
+ * @iter: Iteration info, containing iter->cur_label
  * @devp: New bootdev found, if any was found
  * @method_flagsp: If non-NULL, returns any flags implied by the label
  * (enum bootflow_meth_flags_t), 0 if none
@@ -342,7 +342,7 @@ int bootdev_next_label(struct bootflow_iter *iter, struct udevice **devp,
  * This moves @devp to the next bootdev with the current priority. If there is
  * none, then it moves to the next priority and scans for new bootdevs there.
  *
- * @iter: Interation info, containing iter->cur_prio
+ * @iter: Iteration info, containing iter->cur_prio
  * @devp: On entry this is the previous bootdev that was considered. On exit
  *	this is the new bootdev, if any was found
  * Returns 0 on success (*devp is updated), -ENODEV if there are no more
-- 
2.54.0

