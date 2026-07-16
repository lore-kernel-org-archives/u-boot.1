Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13BEC44514
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 20:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE2584D88;
	Thu, 16 Jul 2026 22:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="tSa80VrA";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="RNSdkqrz";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="Q9CmVxVQ";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="bkbiE9/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5243F84D98; Thu, 16 Jul 2026 22:53:09 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF2984D32
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GK9XS93110628
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:52:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=8QVrE7TCobjz37cRlXXzpU/bk
 DvD+oquRrImIJvLCG8=; b=tSa80VrAEQ4OZS90E0mYLKV6jK6nb3H1WdVllSrEs
 CxQB6Q44LWhgeL+LFczBfkN22Um3Dz6WDhOqClaPeHGg5pTvT3DqM0J52J2KBaO2
 9Jgw55LYYcb/SIGVsBRMnzhq31xUcETCV4OxWAbQWNY+bTKeI9kEwDR1hFtSX8OU
 bbZmIcHTT7F0aAjY6k3s4wjzw1UxYQEDUpG0vr/NOZWIYZOhMLw64Nbt+CW2lgrA
 gpT3siusNQhSia2y/GB22cAZpfQE9gsvgE4PUNH0Uxp5ffCmOwtkglmuOTsbqOR8
 P6UeBPbwjK7t161hs56mg8iwpxL8MyY44iRLl1gsQqCnA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by m0482517.ppops.net (PPS) with ESMTPS id 4ff5r5rmcm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyPUL7Y5esFZ5+NNUTxZNVJ43bmtbgmdAScNM+bY3RXZg+bni0BBUbDEJw8XNqTIQ7JWIKhRBoe8zx/Q0QaR5709jtZpNWhNH6ntEMtYcS/3mljrBX/vOTXtYoRoPPXp6jHqda4OVn4Aum90fdBvbEYgK6aPZyLPbTDBFgtYQIUUznuD/wHK2FsF2cDwsB/f69GojZJWOhYyv9Pq6iLb9lmhceBKJksTXxul3jgjuqT/XVfO6RqH92FCN7Kk2rl443b6e4XmfZv4dmoNZsuzYTEjUw/rHSK018lIHd3+9oTdwjfmL06Fgjx97yCgC6mgWWa+qiwyXgDXu72vcGmVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QVrE7TCobjz37cRlXXzpU/bkDvD+oquRrImIJvLCG8=;
 b=whKhS0UWyQ5UszuUb7S0ZpRp/TnHgk2k16LTd1MLzuKRhFxlN8LzdvHSLm0E7cJK3lURRwqhN1eyg0b0MsYpIzWZbdSiT/+rH9IzCrgarMF6piINt6K5OEdtcAAa8xTS6APE3ygJQoEdRNA5O6mULcdn25XcFMNwMyLQMqwABxtPCdbhLHnB+6SXyz1jLXxSX5U3Msfo9FsmbVgiMjmYAq1wu310xWW//zFAr9aGShAOhk8QRjiqd5fKnkzfmk55XQKn2hfutfe16bu0cGZTZQXbWCAHOP93vGnEXKger21z1whZoO0H8u4oK503G09OwNo4z3Zkj6Nbim1KGbBMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QVrE7TCobjz37cRlXXzpU/bkDvD+oquRrImIJvLCG8=;
 b=RNSdkqrzCmaEpMcHOurM8PoIwFxsQSy7Ojhy7902ga8F1XQx41sZRv5j5dSv98fpG6SbyjPzIQSr3UPMFoJJQ+ixP6i/PnnJdT2NPYIrrIj5dAu3a1507TICigvFZLFBtvyexJJJM3RWw0L2vZh+5NBzftPLmadvtpJdqxnQ0Qs=
Received: from BY3PR04CA0004.namprd04.prod.outlook.com (2603:10b6:a03:217::9)
 by DS4PR16MB6994.namprd16.prod.outlook.com (2603:10b6:8:31e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 20:52:56 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::64) by BY3PR04CA0004.outlook.office365.com
 (2603:10b6:a03:217::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 20:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 20:52:55 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwoLR149105
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=8QVrE7T
 Cobjz37cRlXXzpU/bkDvD+oquRrImIJvLCG8=; b=Q9CmVxVQJhnsMrNMvdJTwKx
 ArWCb5FQnyJGlKagO0cTOwYj+IhC264vnU06hUQdeKV9TavpQwcvwAG8TDQu67y8
 hvR8rki0mXPEsBPY0yzsjZQA3EC2MbE2B1jDu5ZIfkVQ1qVsFKEWB82a6QrOz/gN
 bL0bH7K+2oTjnJJ8njRKa5dF8y5/hlsCRkfzAYwC10v+yDV6ZYLOTuSes2bCHWki
 5mZGOrgZ24ADpZhmBhbuD8oTtfwD0bpVEUjXw59qjM8UxZ2rLxjvMwdOhtjH2yUO
 K8oglMgivJ2WyC2Lt1CgCEdDorwUsTa7JiCL8s4VFljJJmijOP6MoN8PrHOyMlQ=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=8QVrE7TCobjz37cRlXXzpU/bkDvD+oq
 uRrImIJvLCG8=; b=bkbiE9/PJdSFZV/Vi7eM1xI/kYp+LTCmCFzGy01ii4XHp09
 PfgWGDvJnbLZKYanWYpxZBine5133eP3cpttHCzV5S8YKtE7ypcLKgyrlCm+Bwst
 029htd6dEo2c2BUXcxkKuAPgLbxlXMJVIoWBbZoJJAm5Nm5/71Hy00isj80TVcuw
 v5MmFD4Vk1Mx2qS8jRS1zbuuIYw6t2r/28taVBJ6uqDmd3GZu6J4WwkLc2cBMIp/
 0RCD7w5q66YEsbmjYT986jjh9Lq+WqOcE8EfOgilTbw9bis3xYYGP3V5K5bCZx3k
 YdmMtytZya3pSGQ4erqmCAROv7cDsoGnm6wpXRA==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fc6pxxe0q-10
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:52:55 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id kT4fwCsw64QlWkT4gwnH1t; Thu, 16 Jul 2026 20:52:55 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kT4fwCsw64QlWkT4gwnH1t
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1] x86: add support for CONFIG_REMAKE_ELF
Date: Thu, 16 Jul 2026 13:52:14 -0700
Message-ID: <20260716205213.340109-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160213
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DS4PR16MB6994:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a37e6e44-6dd4-496c-fa46-08dee37c3641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 7RNxEX3HzjB8Tf2mOmy51O0k34Jas+Z9TapQhnshnoKeCtMoEjVZTHGzY1SLvI6wvHYBrpEvgos0paQd/8IYOul1MFTMHErL81ED2tCx7AdLgYyIV7HUPMMLNupfLZEluw60YOoK/LqF+z5dOllw/jJXRqw8shqaUS2DdKml+9194GDGc3ekxYtlo+2L2WlBNk8Su+zU27m9+xvnYXbSk/XQo+AI4vPQpJdJrIyv4IKuForafIkMtxV8k+mvgT5ssPbwkjfAp/mW1Y/GFPCgghYjWzbuiofY46xogskuY7Qh/gzzqw6DDXwn+D9m31t8hGa7s1ZwkPfbP5J6pB446L8bk5G3KgmnDW7H1IrCEjygeZ6UmI/Pyx3zHHQSBM8jKuF1yLqI7GxN4aDXbZAVOmFGmTY8PI9O6uePLc6e3aheYBeCVtCAemNZ6DS59DibG3UV0iukprwKXhYUYQeBgAjisNp90JUbE7pGjibNf/PWDYufIr+UNi224S2KCTPbIxyLcBWnbQB4JXZq01gz2WZ5+TBrENb6U8n3vMu6r2HjVSeZzhxJs3wAJu+rKcMtD5mwWlxpIsafgKlsexf5zqG7c90P2Dk9EhRWQQ2oe2oW/vEaUWXPUpzy0/Hlr5nPakX9UdENGCwpZCNi3EMFYRgJ9b36v/W5LDSdHmsI9FzsDlnAEm+lx8PSxPnVOtrItG/tihUvS2Z+6p/tei+fzQ==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SCrJsqj3BaycGO6MLnP/56twcvEue/ezmUMcY9qoKsp4ztFm7/6f/aXPLsRAZ6sef56DR3Uh8LYIcgE4A3e0ciZRZuCRQsHP888CoxPu8kqQpqVzIiSxbUFCuQZ5/drrnWrRDfp7UwkePsIHsyUd9TcYS0AAWDCfZ1zU0qAWgPn09p9FdvSiup1ltAxKCcj5Xv5xyzMXZclUoVcMno8KiDwCxHpcuCSU+WpC4fJhzxiLwK02+0HyhyjYfUdOjkMDSTctt4NCiMgbsXrdTWwGM5KBEPiJakK0Dn40DKsBA7TsUfmqzY/IPamPYXPXuLmmTkUEbqpr82yEAQiw5rm/pRldeBmgN9NkPQX4czDCYyaWDTKWkNvf7QlD8eJMrv5W3dZ0z2bX6RMIRpriSMaaxNQNEw1n1DEZX+dkVZR/MlKWt2BsOTAAW8RounsndMoi
X-Exchange-RoutingPolicyChecked: pqP1WssS4MTq2DHWwU4sNV5JpDWiN7Isazqj/NecOPdaaz/aNJKoQUUEdAmFHYSHPdwUsyxfX4dFPvxP5FsXx/1bdyeLbctnTQBChhTv1nZjm22qsdn7QVRhXBBBQe8TXcaBb0PjiX0lj98Hc2HhUiyQW3CKV37F7PHYVCDo/LuQLNsx7elOjzi72MOEBbbdx0Up7UMU8Ry60ji3CY5kbE81kOSblI7pLIdspuSicmkBUej4oDWwvY8LodjcZsQ3GuNnALnNJPR/mu0KChWgaiJMFsamd6rP2/kUFAvB8NnUCAkP+Wz4EmvY9BrhgVeTm7M4v43MhZA5aEaEaE21rA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E3j/hz1k6DdmzLOE8ruFp9g9gP4SlCFvMPw/h+dqzGOLAiqYrmclf/JmJ0J2rEzUJiAU7KFkNBsjQkmLbNVymPRvCvslWabHb7DDmQMeKPM/wbXQ0bu5wZX8HQgg1zrA3E+Em+Tksautk3MF0BLy7kvXEMnY8ZIsuDFK6b9rx13USzHjylpia0lA8oBv74qQeJgRYQruORqSBWdLbxfSHM9oal/npLDiTHqdIanpYOBN4OFAYOd5CqFSQMvT8SCUUH33HKWeVW5/cuf5PKiOaj1ZA9wexXoJbIv0tjvRDAwTqcidie2eiRWuHlNY6YShTZXQJyk45sSiJYvcDD8vyMbvegzZYl/yB0hv5UqpWjW5EOqhbIRJjASTjaO+fQPJ+IYdQcDrr4NFIvMN7b9jtu9eFYsGQpS1gaWjMqvn6Qu+nTuW+kHfB69wd/9baHPxeFzeIS93xlvofSjCedlf0z/xLptwzBNE/cSD9FW+SS6OdMQfn2T7OiPBvqQJbzIL71+nugQ2tpgWNSFr2wQtnx+H+cYx3Ql5aPhNza7zb13ogSK7qeJsUowi3VUaiTv0kl+44SUbNLgaHL9+GYZEAyK8Brrep4r7CzDyESTCMdkFh4AjMFTAHQwoxU0KrKEkCLrGetnb7FTCv6/ruO7kGA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 20:52:55.8430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37e6e44-6dd4-496c-fa46-08dee37c3641
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR16MB6994
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIxMiBTYWx0ZWRfX52yanurGKUoJ
 6NovFvuMACaO573c1yn7T9cdCwTJkELP1MUvnMRoH/E5eJtnWobTYUo0rrXeJ23u8HpXN0BRcyG
 GhmFMEFDJpslgCcYE0Ac7FARymowaVDemN+1XHuKpcOPiZnp0zOt
X-Proofpoint-ORIG-GUID: yn7N7gVqEaylhgl7WWcDfCKLnSDNWJqJ
X-Proofpoint-GUID: yn7N7gVqEaylhgl7WWcDfCKLnSDNWJqJ
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=6a5944ab cx=c_pps
 a=bC5vtrucsabJqGOS5glf1A==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=NEAV23lmAAAA:8
 a=cbNQJ9GKAAAA:8 a=zj9vqKdtkoC_s2dQ69kA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIxMiBTYWx0ZWRfX0WEkKmucfQSr
 TLjDDCJwBEiJVP6N0w4sGEgl2Kxy6wp404h+JLuMJ30GFhltsQN+PNO7x67PB/wM4ZeOh7CjnlF
 wI/Le4iU86jlPhie28Z45AWwwq49OsM5ErUps1h5ELa0lurqvyfzOgMiLCLdmnl/sWvKWEDhP9z
 1cU2WxOFnUxp26PCgbSUVT1hF4betmMUVdFQonKuYx+xeLFowVGOyMdKNjCrVfIfvmy845IMbUo
 dEHbXIljQ2ExkkGF2Ph7JEmbXZCVgR3CrzoptK+qyM03sxkKVQ7ABYFe2jrDcvfCTn505dxh8zA
 aV7YbTjR+N5oQ4EvG4xqCvi0k1DWcBg96us88JVVmp3Uz5U0QeHpKhYNKa5lWvAlxouw6dm4v5V
 Lq6g2x1iRnTh6I/QsLCArTNkx7CaU9G89nileeALZ22zAPGweIyxpt8KT8fOc69wHCSHjJ/vMje
 cOf5EDhl/6eXF85Ik0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160212
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

Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
configurations.

That adds new 'PLATFORM_ELF_ELFLDFLAGS' make variable for injecting
proper linker arguments when u-boot.elf is requested.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
CI: https://github.com/u-boot/u-boot/pull/1013
---
 Makefile           | 1 +
 arch/x86/config.mk | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8cb9a06f6a41..31db0d37a631 100644
--- a/Makefile
+++ b/Makefile
@@ -1937,6 +1937,7 @@ u-boot-with-spl-pbl.bin: spl/u-boot-spl.pbl $(UBOOT_BINLOAD) FORCE
 quiet_cmd_u-boot-elf ?= LD      $@
 	cmd_u-boot-elf ?= $(LD) u-boot-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
+	$(PLATFORM_ELFLDFLAGS) \
 	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_TEXT_BASE) \
 	-Ttext=$(CONFIG_TEXT_BASE)
 u-boot.elf: u-boot.bin u-boot-elf.lds
diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index c2bb5549b7c8..4a6404344679 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -24,9 +24,13 @@ EFI_IS_32BIT :=
 endif
 
 ifeq ($(IS_32BIT),y)
-PLATFORM_CPPFLAGS += -march=i386 -m32
+PLATFORM_CPPFLAGS	+= -march=i386 -m32
+PLATFORM_ELFFLAGS	+= -O elf32-i386 -B i386
+PLATFORM_ELFLDFLAGS	+= -m elf_i386
 else
-PLATFORM_CPPFLAGS += $(if $(CONFIG_XPL_BUILD),,-fpic) -fno-common -march=core2 -m64
+PLATFORM_CPPFLAGS	+= $(if $(CONFIG_XPL_BUILD),,-fpic) -fno-common -march=core2 -m64
+PLATFORM_ELFFLAGS	+= -O elf64-x86-64 -B i386:x86-64
+PLATFORM_ELFLDFLAGS	+= -m elf_x86_64
 
 ifndef CONFIG_X86_HARDFP
 PLATFORM_CPPFLAGS += -mno-mmx -mno-sse
-- 
2.54.0

