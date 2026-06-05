Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47710CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4117848D8;
	Fri,  5 Jun 2026 05:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="SP7Wm+rZ";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="YHVGMrN7";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="LB8Xdxxw";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="t/9+I8km";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58F484931; Fri,  5 Jun 2026 05:55:53 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C8628489D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482516.ppops.net [127.0.0.1])
 by m0482516.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6553b1Jv2261733
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 20:55:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=zlPk4Gn7fxb5WcPHhX/yuGVDWas
 Dlfe0JdB9b78H4Og=; b=SP7Wm+rZcUUPK/r07S7+dVTuOvk1M2Asg8uMWrlnr28
 tC4mjTP4zFOBd+WlA4Of1bu3UsdcbnIFLIJQn3c/alrVKHUIVbPeKVWCLOWnb7bS
 fL8dN+cQ0dI/EejxqdzTjwAv2if1dhxG1t5yuW4IlHp2vVdwSohjg6p9oSUGh8p4
 IPMvmRHxwgYNZBzIuT6TeUKRGWtEqZo0w8ejobdz6baCg+25uxBC5MiB2szlduR+
 T0Xqp0HQU1h9Su3oQNHRpboJrPIXgC/E/f48H7FpeJr3/sFyPopxm52B/g6Wf0ze
 N+mE10GTWoYJF2t6vR0VQy9uUgu+L191J2PNjuG44vA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
 by m0482516.ppops.net (PPS) with ESMTPS id 4ekpq6026r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 20:55:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWX3fYCevuUTzRv6T7/0bIS0MDuGT5XdxfTM94zCyuv4B+Nkvz/11jVPGtz+1W1CvmcMGO+X0uZgmo0KR6OX8nqr99KD6Kq9cPgMkmCtb+uMTqxrdBIheiIdL5Pmbzzp+dWzfK8347Ho0HcZaT7EGhD06dTxXoBv6of9fPptIinIpEThBceoGIAKja01Gv5V5A7Zgs2/UNZv5Fkj+u6HP75eBAv1xkmWwRdAjxMLaXe17CYrE2stOsnwg7M3OXmLA5JE/p9PpaReSwJvMmc78rXn32/B2aKTt5yVqNycTyCtubkElS8Y+aH3Qt42mIN1wIp8NmAOAYIbHa/MI0idsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlPk4Gn7fxb5WcPHhX/yuGVDWasDlfe0JdB9b78H4Og=;
 b=nTdlz88g6U+mc5sboXNYLUjI2LWbKSqe29+Gdk9/7TRDDoSbiCQc7D/Z5il2Xnxjxob4zcYjR8x0jzIarO8DpplQ2q/qoCiTKXokaJCodp762JkzwXeEzU8FGbHio/DbTmKwT+BH5hTytIP8atVblhF9GC26hIha0abiWfjmGMGFlQi6mNSxiY1beYYuQhG9Zx06qv++vzlGMagluma7PBD7T8B9N+WFN3RZsQGX2KJyfgcVv8o66K7x0ibObt7cKERBY7ANPQWsx/H9c1ZgqPoEKGyX7lSnk+7butbeq1ngZjcY3kpcVNn73t5mqO6ZEpUA4HBYX9WVmz55KxRUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlPk4Gn7fxb5WcPHhX/yuGVDWasDlfe0JdB9b78H4Og=;
 b=YHVGMrN7/11licSB8ptnUd8esHPMnLyvMdy7wW6XuEQqu+NYJHE+8iqE6oWzWQTxa/u1j9bUjuSioyuNxBkw9jYVb2kkhcrrSdKVgbLvXCzd07uaK9TRfNjPYGKDcs5FW4LpSz1RrPM3dni+KfnhqDJvC0r6cSHnWF+TSzUwF6w=
Received: from BL1PR13CA0343.namprd13.prod.outlook.com (2603:10b6:208:2c6::18)
 by CH3PR16MB5369.namprd16.prod.outlook.com (2603:10b6:610:163::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:55:40 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7c) by BL1PR13CA0343.outlook.office365.com
 (2603:10b6:208:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:55:39 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654MjNet913785
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=zlPk4Gn7fxb5WcPHhX/yuGVDWasDlfe0JdB9b78H4Og=; b=LB8XdxxwzpC1
 UUveGpv/LT6lKAo6eA14kTFFw87MlCjQhWtQQlppkAmmhZJIT5Mryk8w5o+954nv
 XUrUn+sUl4//miW76GVbAeFmY2DeZyJTifYgqM/Q0C4GJeiJvTMnaT/+zsaL8V8k
 BmiM0Nz057eaOcFCPHWhdVS6pcjWkL4VsbvhNGEqnAphppLapMQRhhVXbrlDW4S4
 RIcL8zaoevgbtYqnPWaukhkhiUTf+REWvn3jGL+1FJi91xr/7HD38rO3sugHq60m
 QFtv6ZewnfIpeTLTlNpQsbphxhpKgV8vAWAKbBRkD93jr5oolIn0Yg2lxTKG5TpJ
 Cj9o7Wfgdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=zlPk4Gn7fxb5WcPHhX/y
 uGVDWasDlfe0JdB9b78H4Og=; b=t/9+I8kmk5GEGlw8UBY4cHrIAZEGuq1ixhoE
 TKLJq/gUHdX9v1WPFBmwEP08C9Jt6TaKmWKsme6+ZyXUnBkBd3MxA5azycKDJgFe
 vjy5arsLT7B6h/h5+QEpSJzKVYf7WmTO5QWc6cIbB6eCuteofmJKQlyzy5t2CYW6
 LtpAZAMu3zlh5YZ4Ac04WGbhPzu44RdzTH0SXw6kD47v1E+vnPRB/E7OpvZZtMao
 oFam4QmkX3PlW5KEZjHuvvCVXnaYQIlvz4Mg2J3bVvOeCjaLhKxJ+Rus4nYkxvMy
 RGQQ/7o+10E2EB+hn8XjZ25xtWoKVfuAQGmrc9BRll1FuvaeGg==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eggry1crr-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:55:37 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id VLehwCVEmEF2CVLeiwqksg; Fri, 05 Jun 2026 03:55:37 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLehwCVEmEF2CVLeiwqksg
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 4 Jun 2026 20:55:35 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, neil.armstrong@linaro.org,
 trini@konsulko.com
Subject: Re: [PATCH v2 4/6] cmd: Add flush support for all blk devices
Message-ID: <aiJIt29p5fFDySZD@kraken>
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-5-dmukhin@ford.com>
 <CAFLszTgO6Gbg+TrpSwyTffPVjd5Pv8Pw79eq7RG_gj0W-E2uqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgO6Gbg+TrpSwyTffPVjd5Pv8Pw79eq7RG_gj0W-E2uqg@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050034
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CH3PR16MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: fe007a3f-0311-43b2-54b2-08dec2b64f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|11063799006|4143699003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zQsTEViZwBLer6VS8ygpxb2/BxfnmahcFVCGdRzEARhXE9di5/RHM4HxuiTywfgzH7om1zAJMulwP0mb+MqbcWPq0wVy+rvskJS1b4IzxwzoZ1YcCnAE9TDnNxwXU4YLGM6Hu2uiK92rnjkaJy31Hm3DrgpFKoKPBih0i6dPf282y6ZKy7tbTk10aCGJFblnp7m/AueSCY3AcSpCvhF+/bikcIqV8eMO4oNUWU2GPwrajc3BjnzEq2G8nNhb75ZySZDsDY8HFBf6u/7R7J82+2luw4ourbdrNMedczHnRzLbuG5vMKRYEr7J4NftmiN28LVdSd2vG8aFP2GuuRzdmsFCD+WMFwTBRODMpoYrWS2EYFwxuYnkMb1Lx5HV7J/hqQ2tbtCHIgJF/U6LftiVRAuLAdowGj2+EraQrBmd9jTfOZWnxd6CBqHFrTZupvX1aouZXu9qajUFiXzbRdhtpR1Qf+Cu6aJ/DB9Dz3f0Og2WVGtJ8oKzFsICRPflRl7jKjKqMI3nXoNbWU0BWtTw74VOcvZLoKjD6O4pr01OkqZ9upe1cL7UQshGGMwJ4vq1zOqgGzH8SaC9rjh8CAIYd4FqZgP1nAkO6seaTge9yJ6mPCr4TWmgBVNnFN1hUk/RWpMUkZFTub526zGaIclWg/ah2qogEIb1nY9Ze3FmWcxXrBicHWmidii7OMbLQufU6Y/WTFktkWLEYKxGLFhS2Fkj9Opl9eYG9OB14LLopTU=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(11063799006)(4143699003)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4zOHiOBCab0jh7/wYu5AVI38QvLKjtiPDrQ3pL80oGPUBqXqYVXkD1SFiy+MX9NP7uXdVMdt1HUEPtDoI3+95SJjDb30OvE7YmuirjjQotpqFJ9EXf5SsNXemLfjK03HuVRTX/nQBtaeXjzZnUK41VuhaejOeUc07tOQOTVCIIYXKtvancIJDLXJPSEW3DuOsRjlHS3v1zZRLsuq7qlx15rEB7fnO39+aU6SdnLI3z5rAJFPX91OyFtKgNTrw5RmSuYU9tyA9SoMMdVPMoIurs5JW6JveCaEXW2vvqT3wPirmLGGAmiNmfCujYVyk1knNTV4W3EdTu4LOWef8o98z+LxMj95JHtuWxNGHYAhRRGRI0juI28mhMJr5DvGLqUcLsGhUbZD1iRJ7hfSBi5bAg3wqiWzRflZiNICdHvHTDqd01NS1973TXGiYZar8rNB
X-Exchange-RoutingPolicyChecked: IJDb8G1A6sIZzVVnuAuHTfRhQrJoQlJodRo7xwNnRMkBsyz0PM5dXsxUaSWdVA7R+poWdxgv3lRRkXRMLuD9NxWEwHxTj8dIDwXWhM9q3/orld+JaEVNDas7psqvrlCFKahRwaHw14nXhMWCeAHJlhaRjlMzHQS38mmc8H13KumFdzeFBfwJ/WGExXWEb2EKC2LMFyZkxCM/xGWJ52/7sNDWUnhFDIhMMh813QwBej/wW8SH0uBhguDm58SXi+ZP2wtDX8l6QZ51BO2SH8eiAv3Xj4II7qBo6AWwxYbWHLTAV0WdC9YAlXuVI6VRjy1nBn+w5Tv45kTu46+sFA9l1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xkMQaJuw5VsghjimGKcKGXTULx2YlEETjb6ytxJs+4hrmzq0bPLlQcpDdxa/8cSShrpOBY8VZKBTqyumdUqt1gkTafk4KIUPz/+Ye3nxPxsifBQYPYd+8baz1OThpEyaMTfSWBSZo5aAlLjU1urTHhzWIXKc2nUKGEFAvmw3iTfU4XPsdVZyvrqg35VyIQ1XxN1Ycm+vKhqf/P7Z4/HSz0t+iP+q14RfoSMgrcn0zDsJ9Tqvcp0GqM2YYx/bJ7oQAoGEckULII54eGxDp7UWjfOb5+LNOVDVC15H0RwMw2TCXETcO19owerM/kYiRJQ8/mp9ucLG82nqSHw+t6LWj26sQ3tjHUW8swblxyNIgposTTNSXissIaev9XDOW6/p+hhlj/1nTU5FEr06NLy3YPS7AgA2Ni05uLY/knh/O5P7x5pH9SLDhUiPYhN5Q6sWJS78Ie+mWtzJ+6wNSVDzDMuyZ/apau91B8QvoWI+l/tGe5nt4/T68tjtFIMNZ56i/nGBPcF//R4jolzofjlON8Pq3nek3nRpN1u8Eb7iIZaRCizjFOcv6ON330qg/9Au1g/nq1TQD4lba2hidJbALjGYuV+SsnGw6glKaUhT4wB/MW2vkBfNeRvX8SfLfMIK
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:55:39.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe007a3f-0311-43b2-54b2-08dec2b64f13
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR16MB5369
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMyBTYWx0ZWRfXwd3Qucs+m6AO
 PldwHVgLyGoaZyqAozOlx24QDkULavJ0hyL1PRhriwpKtbyaco2NJE+zB5TocQWkOHx11BH18Nk
 56Y6fMEeKieldEOi+wtw4JCNRwEh6EUXRlagDOxbQAqXAddtUt7F8XALHJdDswMwTyu7ohXUryN
 oLvsD9JnUdb3Qs8MB8F9lrwNT4hgkI/FV7PfFWX9drAddXAKFvZ2g2+63YMuSHCH3QCy1Enikh0
 juqpJumtr6hyGwyK1PhcQync8sMnJhXUCAbOhVaEQnU8AHe+zNzpPiKOpHsSDPA/fERf4HFxQ1c
 rIxNuIv3YLD5EUxayH6HLlW5PluYKrnX8Pu8uByZHGPcgJUEWIo/PttUFFfZGoOxQf0TL38trg1
 oZXMDgubpD/pUifHGWnFnSnPH3r9QoIKhf5MxbQZDoCAQnrRK/W4Y3wWLCbFolFtlRRCKN0A8XR
 PNhon8PTha+bHjaJvcw==
X-Proofpoint-ORIG-GUID: aEN7b0wjcetscW0QDLX9pqgwgNEyVjmP
X-Authority-Analysis: v=2.4 cv=Yos/gYYX c=1 sm=1 tr=0 ts=6a2248c5 cx=c_pps
 a=AIGQXw1SJcVyoLDzoYNqyg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=NvsXeTrgx-CJMFV-xl94:22
 a=cbNQJ9GKAAAA:8 a=4-nNkR4AnbT6JM2uincA:9 a=CjuIK1q_8ugA:10
 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: aEN7b0wjcetscW0QDLX9pqgwgNEyVjmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050033
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

On Fri, May 29, 2026 at 04:57:48AM -0500, Simon Glass wrote:
> Hi Denis,
> 
> On 2026-05-29T03:44:35, None <dmukhin@ford.com> wrote:
> > cmd: Add flush support for all blk devices
> >
> > Introduce flush subcommand for all blk devices to allow committing
> > dirty data explicitly to the given block device.
> >
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> >
> > cmd/blk_common.c | 14 ++++++++++++++
> >  cmd/ide.c        |  1 +
> >  cmd/nvme.c       |  1 +
> >  cmd/pvblock.c    |  1 +
> >  cmd/sata.c       |  1 +
> >  cmd/scsi.c       |  1 +
> >  cmd/usb.c        |  1 +
> >  cmd/virtio.c     |  1 +
> >  8 files changed, 21 insertions(+)
> 
> > diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> > @@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
> > +             } else if (strncmp(argv[1], 'flush', 5) == 0) {
> > +                     struct blk_desc *desc;
> > +                     int ret;
> > +
> > +                     ret = blk_get_desc(uclass_id, *cur_devnump, &desc);
> > +                     if (ret)
> > +                             return CMD_RET_FAILURE;
> > +
> > +                     if (blk_dflush(desc)) {
> > +                             printf("\nfailed to flush device %s\n", if_name);
> > +                             return CMD_RET_FAILURE;
> > +                     }
> > +
> > +                     return CMD_RET_SUCCESS;
> > +             }
> 
> Please print the return value from blk_dflush() and the device number
> in the failure message - otherwise a user can't tell -ENOSYS from a
> genuine I/O error. Compare with the erase arm just below which reports
> the block count. You can use %dE to get an error string if the board
> enables it.
> 
> Do you want to print something on success?
> 
> It is a bit misleading to suggest that all the commands support
> 'flush'. But I suppose we can worry about that later.
> 
> > diff --git a/cmd/blk_common.c b/cmd/blk_common.c
> > @@ -37,6 +37,20 @@ int blk_common_cmd(int argc, char *const argv[], enum uclass_id uclass_id,
> > +             } else if (strncmp(argv[1], 'flush', 5) == 0) {
> 
> cmd/blkmap.c also routes through blk_common_cmd(), but dispatches via
> U_BOOT_SUBCMD_MKENT() so flush never reaches this function unless you
> add a matching subcmd entry. Either add it for consistency or call out
> in the commit message that blkmap is intentionally excluded.

Thanks for the feedback!
Will update the patch.

> 
> Regards,
> Simon
