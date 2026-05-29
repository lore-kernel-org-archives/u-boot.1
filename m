Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F480CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC87184839;
	Fri, 29 May 2026 05:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="DbnUlNz3";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="NPnGZm+H";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="FxyeHbq+";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="iPzGrvSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961C5846F8; Fri, 29 May 2026 05:45:07 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF20846CA
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367123.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1ZNiY2109249
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=yK8
 YeVhhR02yWa4oOzkE2YrHGnQbuquJoqe916pfpkI=; b=DbnUlNz3NKH8M0hqGpj
 ZltfvMxmJ5VjwY8U4+cIcX8t4NFn+ZOussm9wwUhgKwI8yTVzdUrVMNHwsXukGyl
 Vrx4hUc8ef/tO0YlCfwSwgfUDnuyq/ugRBbgWinnbxKE09uACGXQHUnYK49i2tmv
 CTJq+RvoDxOqW7Zpxx4pm3Rg/7kCRoipoDauPH0pf4qVs6Soz1kT8/HCkrPqhPlT
 UVFznr8rLLkaYKgDv7Sraq8u6tFAl2GqRp6c4W2NKubjRaoT62hayf//+9oCPsxx
 7Vb5ImSH/g29ubbBqCvw47RyAyzxB20SX4XpjWRH3w0DVXcgMsaq5YTRHwcqhA8c
 69A==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eet1uuxc9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:45:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0N4JX+cA7EhM+7xyySWabPCHxolKP56EU6IxnVdnwcA8ZxMz8BCs3G+e83703k0202gFNm1HON46UqCvGGCD1xuMPMrVwJa9J7kX1wcnNKbCqIDRFY9cTP1fYgEzU0yMrKmW/fnRsw9OQT0QK3qw0qd17qLLVDjnmA3oVi+a+rAWvP56eVF2xzm/cfIhYJ4y280EWh7/qyUkWVuUyJmkg9T9Wb6FuacdtEvCW+vdtBEQArtuWMk/cZXIMSoNYMryc0vP2FVA6UScOkJHhYSaY266bck32lEIkt/EV7xH7+T707bdSlAcz3bZIsYYXJg1egkonXW922LuVEiTugxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK8YeVhhR02yWa4oOzkE2YrHGnQbuquJoqe916pfpkI=;
 b=MSk2ovWZ0HN5KfXZ6bkIm9pQ8976BVfhLs72unztX63tuPJrs1qM0Eay061mbNya34BhF5dXoUfAjd5A3bTy83PKoMq5LigCnIHtFRiPdSiicxaE8YxlmjLq9TNkkjvsgmVDeYAAxaMSAHmNUguG61w25YjiAnMSYjleOVwc7g/sQK5VCjwjPV6ryj2kYizE7MoafCjHijxz/z3OCE9UyupIIBwH6UI4/fHPUvWZV9e2cWE+oi7buLYIDmrtqmboJ8y1X0Szf0X74l9dAPd1JgE5ilHcII1zv117Dd6hEpLpTbfXD5Y9KVOdCyCWkJZGZnKMDCUEr5AeyDkf9Xp5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK8YeVhhR02yWa4oOzkE2YrHGnQbuquJoqe916pfpkI=;
 b=NPnGZm+HI6nl74lAnArqIL5tL0NxZxcwtIsdpBGkNzNMHFEbE8xbeu8juWcGZI4MIcBkeW3exfp6HY3AqlQK3g6wZHMUSzGyFIhkn0L+TgydiqGKoyQ1S8dMsO1qziglQapOyTupV26DmEBvpdaeXIsQhu4rHlQAPMgNAIVsGbU=
Received: from MW4PR03CA0278.namprd03.prod.outlook.com (2603:10b6:303:b5::13)
 by CO6PR16MB4115.namprd16.prod.outlook.com (2603:10b6:303:b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 03:44:57 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::2a) by MW4PR03CA0278.outlook.office365.com
 (2603:10b6:303:b5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:44:57 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T1MFcv2484454
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=yK8YeVhhR02yWa4oOzkE2YrHGnQbuquJoqe916pfpkI=; b=
 FxyeHbq+4CD7lEhWPyZ7jDjjlRuctgcUQ0nuhBmKq4A19jJ4sVuPjwtkJOne8xkO
 Nhqw6DYgLTUnAS56SJ8lPUfw0iL4aUBF52LdWKgDeubgxuUZ2k9ZX1xjTQ3zWvDE
 KjVIkemIEMa8pugDyTG0puLj9Sj/Mss77xy+WQOdqGO6khmGH8DqP2pNI/vMm//T
 OqdeyL52NnBqxla5O1SI8QJ8ZZNyhfNuIue4d5nZgUR4SGKgkv2i/3zFZ6gV/5nq
 Fkfl2zA0MsR1zSQMmsiMx+ay7mJBNy0SjEOFxTZLIn651AKr7HBO0klXYeJt9Kli
 aawYuUJPXInopM/8xducgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=yK8YeVh
 hR02yWa4oOzkE2YrHGnQbuquJoqe916pfpkI=; b=iPzGrvSybRA3H4TyVRJDVCE
 wxDtgMVIYKJVoGcWDRfddpwxW2croA6Rsb1zbqdDLc8wlAzf58hyHCB31avoceD/
 cNI/C7sOuQoz5iI3DXVVd8Nt/uhQ2zE7EGhdWfmv20QBBqnMdmNBc5UkJYWecuhm
 XGddaBJeW5xkRZlLAGe6lvZ2Xdt6Ux6movhtaajijCUlKIISHR14nnHrAge8Am2v
 VZpGrPfG6oUqtsTbwPYW+6xC7rzmSfIJ/3RRbnASjWyCRe2WCsUrAUkPqnRTXxsw
 WuUjWxf4qXA3VDl+X7+m/X2zuzln87d2JhR0PadGM6lTx03izk+1r3xA6CiehSw=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x7stex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:44:56 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id So9UwObwWYPuRSo9VwXq2P; Fri, 29 May 2026 03:44:54 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: So9UwObwWYPuRSo9VwXq2P
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, sjg@chromium.org, trini@konsulko.com,
 dmukhin@ford.com
Subject: [PATCH v2 5/6] drivers: nvme: Export nvme_shutdown()
Date: Thu, 28 May 2026 20:44:40 -0700
Message-ID: <20260529034441.2075305-6-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529034441.2075305-1-dmukhin@ford.com>
References: <20260529034441.2075305-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|CO6PR16MB4115:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e49de08-6124-47b7-0e22-08debd34a75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: c4QjlTbpcrehDzB6mP2+wDWJno8SPRdrluqzihlNgXTDd+APKvH5MtYsMnh23OF41mhraTi8nadNJf8/2ITOM25nhfr2BpmgvreME/O3zZp6S/KpOhcIKJqicZBnGALEbAbn+CzGXr/Bj6fc11+uoYIm18M/O6zQjAx5GVuU8tndGUwiRNo/KQkk6mwwWPQS8xSqq4eA6kjQy8HAQbniJyX1kphcoE3pymYfLtEe17/nelhFmQYkkUB86P8yPhDgiLgN3cQ/D/bUh6J32t077VRGx2UwjEc6XI6QVaMpa+upr5HSdULKsZo/qtfN8w/9OLKEmCTE5TqoGR8n1ljEQgORiQ9xB04slp0ef/UK+4CMSR770Ib7XtofV/b13B8nvx0EBFCTcDbo86DQs35azK/EEExu/1HGSc2MVdj+LsvYn8o1DTxMxF+GJQJM/s1PJGX/M/FHSuld4PaXq4rnGS3dYB8TLiNGYqO6E78bxUlLuDBzDKsyq/QkZ/iI6MjA37ohtBYc7e8QYjVfUx3ofGJgsKkDGvuPiSZuOs+p6Gz+zIXn6ITNHh672rpYthgtpR1ix6Q+SHP6dGRPLsHkHpT6SRE1deYE0pc61Yt14qoh5M2s3sH876bJOJORhVXpFwyhz9a82RtwRt0CUELRkinet+PeHnVL8vfpCsCT6T9+ZsHqhqegZLI3BZgeDlb/wc5E3oNdfWKxOq8izkCXKJArVYHPpBF/Oy7QUY6WuJM=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pUrVed6sCY7LgtEeVPAJ8BtbARkFJTgDj7jYHurJ6+RrZprZ20ZNdDN6UEtfs88qMDbU5FI1mau4rai7g7kJSlrFL8zViwHjUxv3SW/FLgWIAYc4B1CkH9HunH4Kis6lJYeJ9w6N0Rc+JCl0Ap8J5d3qpScO1Lm0HzPdCcLbb0Kc/preg157WHYR6oRUvvfEZf4gKZqey0eBz8O2HQpOtD2Ytt7mGH+smlI0QBtku7ictTvNyhRwBn/Cy6g8eHIfwz1TePDhYnIFedcpJQQr75xOmd72Hn4gMnWpr5cpAPJtshO8sya+ZU4wUIZ3h7rzSEFVRm34ntwGsqYrw5OEISJXVR4+3/hxI0zhNErmLFkDJ0pxntw+TbTymwRlqK0hzc8W2iJDxOyYckaZqQIr9rz/9Uo6/egSld5AL3+NNDrG+qD9VsAkChJOIMTfJ1fv
X-Exchange-RoutingPolicyChecked: CWUq7/xihWwzk9gj/sxQUluvjntbXin0dxJ9njAW6FIVKKtRtvQyfu5fFnkCZX0AJeSOudO0hIHxgYiBCtDow//6OYbVvMUPSLwFLlV7O3+ZcinVMw/hcVBfANnilfrcshfT6i3/KOjvTezPUcbXdI3HxPld8Ui/kIEsaCnWUAn3VGq9nC1by5XTRcwmIjHVPX4u5/kkJW2k6M1TC+dEgoLMJYBsWUM6IIzMzzENpIi7dCq8CWVi9QYEL3z/2fopvY5rBnQY9ZakwJYZJmp7KGU/vBENwu2mRPVsIkq1t1F+Pt3VvC+JKLKvOsib+A0sLU2Wdyzd9Br4jJKENnGxIw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0umnrXveIJfPMDzhBmon2WaMLtM3TZ7pMsFLyHZC10C/DrBo+dunnQQ+yJaI6QHOmfCJJ3kgA5o/jqBiYnxtMO2tC5KPFvGFGGRj1Xd6BNvUSQvPpJP7rNE9hou8yn89IvWa7X1i/npArTysKn3zFMEFdDnrfkGqgI161z88i9/eUN7Z+zgxnFkigNQjeYG00kERnkBfxUGmeccYAR82bi1FpTBeFHE8Nh1+GiA1G/vNcph8P7/fsNiKpHA13s4wnD5KMISDp21O3b3vb5OzMlT45xaTsdYF+3lmC3h3zeqNrzkZJNIlmgyFhvm5Nw7b7JjuzH66qi6a8ybm8gR8VzHefcgbzbIe4469tBK4VWMnaSMnvrZiPqb2CP2mIT2OJDr0vWAcwwOr9ywNZCV10NpL5bK/wzZgykNR990aZVXx+mL1zDXiahA8Cl52ZsmPYhfHu6Gio5mWT3qvBAbjxmDJ720UgugrclCHmXAxAiSZRtFgsZt2uAXVPAbD4EDZnOgXT7jU4dnQIgpULungFK3gysa79F/NBQBgY3krj8Vew4jQr0FzswPOj219XEnQmhtHJgBO2gKLQCvcXOG8XlF2lNd+Q0Nh1U+3buh4xWj4ssg8uZ5CmAVxlhPuJeF+Q0D500syz6w+sIxeBUqAWA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:44:57.4628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e49de08-6124-47b7-0e22-08debd34a75b
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR16MB4115
X-Proofpoint-ORIG-GUID: -jJMV8awJa1OR94rVnRzFrDQ_NYHjezz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX9lKkXbIxY9op
 22PzKIAdTv+8Q8uZ73joaQpezysZex/Lu85uKj4DjQSODjltgJPxfQ3e443I4jtoCRDdCOa+VJ+
 4laH9LaNZI1KDmymXLSWKoii3DvlMSSQRHSW6Wd6vfkeZ5B3YcFW4NlqyZpULiv5Q4+Acg8Yikl
 c9gFMpfver9SKov0juYLdQ9zWR4AdL5Tkt4vu48sMKJ84vMpJpb6XsSl0EcKfrDd8dpuQn4bPHc
 dcKM5jxjiiatVo1rYqkrhFbEedDZDtwktXPEfqBxI0rHg+d5eKIo4xeqb1mvpGxNZBydQ3eRnUJ
 eJKSKJdD8yb8GxxsB3+6k1vKSwxhgwfHkX076acVP+ksaLNb+vyr71bkLiLDb0ntybIIfYiHXTD
 Op2o/F+fwfapD72imbR/Mgk/uw/gNfOvMsRKGyL0S1tOO+lryZkjYjhru+2SzilXfkFHi3xFcZC
 jk47JsY/TwWwU5xz8ww==
X-Authority-Analysis: v=2.4 cv=DulmPm/+ c=1 sm=1 tr=0 ts=6a190bbd cx=c_pps
 a=DQgCSL4B2z8Pp8IQPtpfIw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=N9_n2FxmZfwfyRXvS9-E:22 a=cbNQJ9GKAAAA:8
 a=Ien_xjyh686n1DXYAIcA:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-GUID: -jJMV8awJa1OR94rVnRzFrDQ_NYHjezz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
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

From: Denis Mukhin <dmukhin@ford.com> 

Make nvme_shutdown() public so that it can be re-used in
board-specific board_quiesce_devices() before OS hand-off.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- n/a
---
 drivers/nvme/nvme.h |  7 -------
 include/nvme.h      | 11 +++++++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index bc1d612dde40..25a8b0b17772 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -698,11 +698,4 @@ struct nvme_ops {
  */
 int nvme_init(struct udevice *udev);
 
-/**
- * nvme_shutdown() - Shutdown NVM Express device
- * @udev:	The NVM Express device
- * Return: 0 if OK, -ve on error
- */
-int nvme_shutdown(struct udevice *udev);
-
 #endif /* __DRIVER_NVME_H__ */
diff --git a/include/nvme.h b/include/nvme.h
index 2cdf8ce320c1..c7b301300097 100644
--- a/include/nvme.h
+++ b/include/nvme.h
@@ -90,4 +90,15 @@ int nvme_print_info(struct udevice *udev);
  */
 int nvme_get_namespace_id(struct udevice *udev, u32 *ns_id, u8 *eui64);
 
+/**
+ * nvme_shutdown() - Shutdown NVM Express device
+ *
+ * Must be called before booting an OS to ensure cache is flushed
+ * and the controller is in a clean state for OS to re-initialize.
+ *
+ * @udev:	The NVM Express device
+ * Return: 0 if OK, -ve on error
+ */
+int nvme_shutdown(struct udevice *udev);
+
 #endif /* __NVME_H__ */
-- 
2.54.0

