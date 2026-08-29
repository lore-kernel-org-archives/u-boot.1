Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0CEC61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6517E60611;
	Sat, 29 Aug 2026 19:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FFjW3Zq1m1pn; Sat, 29 Aug 2026 19:35:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788032145;
	bh=NkLiLPkkkLVvucNbHQn3hSsMUeIU/aV3HdF0+r2cDb8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qJTK8bZNquvQ8aisPOgchG23TmRh+sR6ZdYziRb36LNacfTO/bZu5afpaWMjxMERz
	 IRVIbKDUezXhWQu/34Wx54tYOPgyobeNXA8hd4glxBAaFSoklHnNJJQuAb4Ryz0Yy9
	 aod1/j1g2n2JlqNALTTauwEJjr+ldiPym7nVoRH4fKpdhnc5Jj1ig/9F+SBxw6i2gG
	 Hg2oEkeRWPt1CuM+Q7ux2YnYX3K5nuofBDGhcOT+GAwY+/cE3yQpsA2OXQTeBBpeKn
	 ZdgiWNyI7b8VSj7n3AdlDx/8JDnOarPN6ZKvryklTzkfLqsRQyGaYvnz/Fa68dam/w
	 kF8oILt4iW1Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72759605D9;
	Sat, 29 Aug 2026 19:35:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C0AF9D4
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:35:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5B41605D9
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3ZaYii9dy10 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:35:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JqkKXvYH; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=o8nnaA5+
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50A26605C9
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:35:41 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67TH0GfW3572532;
 Sat, 29 Aug 2026 14:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=NkLiLPkkkLVvucN
 bHQn3hSsMUeIU/aV3HdF0+r2cDb8=; b=JqkKXvYHhTCnL3lNHSa3RaEQ/eO+IR4
 vvNYBf/JJeEcQ4jPSeiRDyLhU3Fwzpt9/Aq4Ttc/j9bUXeY6FBzCo944kyO81pjM
 4Ya9cUFnmgsRWq9BfwTNIChxsP1eAD/mw6n6dBnwD48LcQuiuTxB00CRm6wHF/0i
 fhcDrzGQsaoP0xxvQT8eA5qVt/yXo9G0QrINZC6A+pWz304pIw8L0Vjk34LeDazN
 c3PVfn4t9r72Te7hRrn0BxlrLhVnriMFQtGxwjrjvMnB6Dv9QXj22v0s0ZU38rnK
 RWVoz/1zOgaesDLDeymSg0slC+LYrrAniQaV3SNuVGE1gHwxDIBTUoA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013055.outbound.protection.outlook.com
 [40.107.201.55])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gbqmmjm2g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 29 Aug 2026 14:35:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3q2fR3vt5m3tAmJ4NWNtmOxDTDBbTRp5TOkTAgPlshTtiNeoiR+OsX2UTEdOfdnon6DUgXy3Rxmtqu+JB2IlbVtAMZj77WE1l8ixQb3yPWXKc16g7Ohcu6fQnUA9Glbn1r2V6JskFtCzxz1Fl+xKrf3ega0RHibMCbEkbdQgu541TmTILscQgI/bZN90QulaPHAB12Y+b9pCoo8dKrSvHOwD01uGBSsOiC9fyCw634KFm/owEUmmBOJ/u4hRcj7f3aX01b0Tb58Sqe0vBMnZ0Ey3mH5qe+71Qj+zE99M+YUk6GIygljiXVpWiQTtgEnfjA86uumN6Pa1i0b5mUVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkLiLPkkkLVvucNbHQn3hSsMUeIU/aV3HdF0+r2cDb8=;
 b=fTID3wSFGPZZFBNm66ec3IhRlT+K6Pd5Xl5f7dTeWhJBG4wb161mUMmskZwZ+TpC3cLPinAGU1MjjXrr0Iwykkp83JlhOmS7D/qj91/T1oOR2YHJI6PsLR09UPFZhdJPRAZY5Bka3xACe6spLThBi5Rd+ltM/zM2gcd/5KLlkfyo7TRq0SeqisRtb+4YjUJXUVkb9D8+Hu/46tXZ34/qy8Bhx8FXR6kVlfwWtjrG5Ais4r3PH4N6p2STSyaeaGREPnSYjG/7kPNCTjGqUcAJjvFpjFUjgaR776jGxqoT7jpy1V5Ql+BNZohZsBurfyDGhOhe6pQpM831XAsrhEqDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkLiLPkkkLVvucNbHQn3hSsMUeIU/aV3HdF0+r2cDb8=;
 b=o8nnaA5+4BM4dVBIkhxHtsBYw1u66fWMv0QB7oo+IYSSK4PDlWmHKL7zuBM/1u0aVfGbL4DZ4uPNwGON0/xZDvTmWaN43Lx6VjqdlinaAxVZ0ax8dwOTV0MnFkUAtk8VR3neMAMU5mShs/AUwoBKiJFLral8kPuzpohlO+lTHCM=
Received: from SJ0PR05CA0204.namprd05.prod.outlook.com (2603:10b6:a03:330::29)
 by CY8PR10MB6705.namprd10.prod.outlook.com (2603:10b6:930:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.9; Sat, 29 Aug
 2026 19:35:37 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::1) by SJ0PR05CA0204.outlook.office365.com
 (2603:10b6:a03:330::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Sat, 29
 Aug 2026 19:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sat, 29 Aug 2026 19:35:35 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 14:35:09 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sat, 29 Aug
 2026 14:35:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sat, 29 Aug 2026 14:35:09 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67TJZ9Gv1913452;
 Sat, 29 Aug 2026 14:35:09 -0500
Date: Sat, 29 Aug 2026 14:35:09 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Apurva Nandan <a-nandan@ti.com>
Subject: Re: [PATCH 00/14] board: ti: update and correct files MAINTAINERS
 entries
Message-ID: <20260829193509.aa23qy3sddwyem22@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260829-maintainer-fixes-v1-0-e4e03971e14c@ti.com>
 <20260829155313.GN3959812@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260829155313.GN3959812@bill-the-cat>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CY8PR10MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 942b6a3a-d048-4d1c-aa55-08df0604b2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|4143699003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 72NGwfFC63rr4xmeWmoAXnYis1wffFygLDZobTpFHHA5zSov+4bFPhVca5R/zgh4nO7B/JnNq5qd7CjNNall/xUpQuJWA40m/CGOSE5LUe2ycBucl0cMiqFf8J0/BUhGNLsgr5zUu1NHhcFJ27uASxYRQdMwveDBimwPZmMoaV7+2hQ3DgkUbJ8g+XLiRcbYKZZy2kDrCS8GYqRS8zLooKoStEL1iJBVE5bs65urDQ0PvsmrlGgdtnYkwObzk8CZk6caT+bCIIpiJrkkm5BLt4mKowtH3hTq6wJ9L0UiYgVM4WVxqBDjoJ7fgxXQ7IxCAb8XssuiYMBTiIsuMDXYDWhrmnR/I4lkUmf56bOlkuiW0Af1mH3u29Q1fXoxn+TOyC4UVn1AZD9Ros5MeWu9pLBbXK0rtxcy3+hr+U6lDwbDI9BaIurtvabKn/SUYs32s3/1/ARErYUhvnPbwN5gEGrAO3qbp4qJVOfbqmS9+9EGCexpUOpHdWsHCDVHpKLeskewD+AOSeb9+GJxKfPTC+GRBBtG8k+6RivWP2riLAhHhsdOfFDoOPnhPBDjJXlk7dhfYovN3iPUXR3hed5CMG2GUn5woefz+82C95uCFzJ7i9LMhObXLDsAY75jmDr+DcX/PK8PJy/ko6LU2XJPLitqo6Ruc2ZMmSesuoTjBDiRFYwSRU+OlVedYb9AwUaJ+8gOY8/OE3vAEyHTFJ8o2Q==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SJQ4PjCCl3JTZu8cEkNyXzJ7RpU5jiGMNFqIKp2M+RD0aoJWTwRYMnpo0SADCYSZH414yEK73Ie/BV4ax8Nj8aZR3KQYPv6sISFT2h6Ana4cSh9lS3PZYYZySapfnCETtYZVTH+bN2KSYGcT016N5xIIiKaIuVr9Kd82dsTG48V1AP8OLdPJ8tgNTnEKjEQSFJJzWXGjdiOLlG8yyHfuZFYELMyIgaXA0JVzMbtH7sHv+B0Wz8d2z5QDLpk7LXLl1B06OP2xaYCSDT64NtBYhqbV2U31fMpHenwmhst300npmvEhZhWhe2GJWns0cHU4mz8vz+Gs6uwLfGpbWeva2OVS9HE4iwroaKPHlq6UCpS9XdK3HACl/Ci3mnTxDVSG1kteKk0cTnJjC84jYc1HAbEjCsGk5/XIEjLGeKdZb02R/qKe+NMomqLGHNDy2wDt
X-Exchange-RoutingPolicyChecked: ZiblGilWJM6V87PeEezI3j21LnzppXg0gltZqpa5vApMzWF620pMiQ0dbbxKqokHloNCqjFNrqzRQRGwzzrVLj5WARy/FnpX/axCNh+iWGsO3N4gXoeo73FgQZGFu8xpaJgEpK5gk9BUrCppcFmM+kdOn6glYM4glLMlV0i2ZYB+3naAyBQpwJnbWwhYHgshZ8uh8oCYxLDDBA26SPsEn9shu1oQqv422aqcYZehTXTR62BoUALlMIKHhJIiZMtkhsJgwkhV+SOV/YTUGyeXvezqajkjbg+yeSHCmOUHUqm2H2TPgKzQeky53okmsijHTeIYDVL+FAvAIeJmA1i2ew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 19:35:35.9077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942b6a3a-d048-4d1c-aa55-08df0604b2de
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6705
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDE2OSBTYWx0ZWRfX0/Q333lM6aHh
 AdLbeLukcb3DKt1izzqgPqQwpRVWrZx1rSi2S7dh4HKRLcGeBZBpmVSroX1iyDILuhMRc61XETO
 Rq3U/SI5bMiGtwyjBYLFRobIjPoLcEpA20ki/gtYLGl5nbs6omRBK7X9itCd6OApt+VTRqH23zU
 L7o5eoPHRngZrFv/BGw0VQ0YHuPPZRyfyR0wa/5bS1l9Bh130KqopUMDENwc1F09m/Q3ktaQ6lc
 QxtI5qqvROj0jXKqQm2yq0uFUHXgbqA6kY1rvpQWnqpFycJLUtT2RWPkY7bzfk7GZMVdGQo30qj
 PBd217NvroiUyszlkKI1KxsI2qbJY1NIxo47jSrItx5Fym3tsHSQv5IZYbfgoG1GDmqwNIqO6qQ
 t2o5rz/kuSsb3Djn5WGEVhgb2ECOlnbu1YoNdKt0ax1jzfvpWuZBxWY/pFiJKo71jdlFL8VHKqj
 Q2s6Q8s9g1jJ1fm03TA==
X-Authority-Analysis: v=2.4 cv=YNuvDxGx c=1 sm=1 tr=0 ts=6a93348c cx=c_pps
 a=PNGgPGJBypDwtINamOK0jA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=sozttTNsAAAA:8
 a=D2MJPbZdc-Xe2n0qxIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDE2OSBTYWx0ZWRfX8ZU71mJJx/Vt
 E7J89LcabJykuCxOH3cM7oxAbbLVZQQ3a5j8DaewyYyh7IZOn8MJKhrYTlwrowyghopr9SsVbn8
 bVp4skcYVBGsudDHH9DeV524C6XekBQ=
X-Proofpoint-ORIG-GUID: WdGhI1Qs02f_JbORNCZYCJBP70KWD3Ai
X-Proofpoint-GUID: WdGhI1Qs02f_JbORNCZYCJBP70KWD3Ai
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290169
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On August 29, 2026 thus sayeth Tom Rini:
> On Sat, Aug 29, 2026 at 09:34:18AM -0500, Bryan Brattlof wrote:
> 
> > Hello Everyone!
> > 
> > While updating the check_maintainers_files.sh it was noticed many of the 
> > MAINTAINERS entries in board/ti/ are out of date[0].
> > 
> > So this series aims as trying to update all entries by splitting each 
> > board into their own block, sorting the F: entries, correcting any file 
> > names, and finally adding any missing files I noticed.
> > 
> > Happy Hacking
> > ~Bryan
> > 
> > [0] https://lore.kernel.org/all/cover.1787555916.git.michal.simek@amd.com/
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> 
> Thanks for doing this, I'll drop the boards/ti/ parts of the series I
> just posted.

Thanks! Sorry it took me nearly all week to get this out. 

~Bryan
