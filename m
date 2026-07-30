Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58011C55167
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 21:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1559E811B8;
	Thu, 30 Jul 2026 21:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqq4TVi7BNxz; Thu, 30 Jul 2026 21:55:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C998880F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785448514;
	bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kE/R8fT+Juw0qU0ZsePjf4uOAAaiWmr7KsKNYUbKW1kYOXwZifdy1Z8qKiccaFwH8
	 76Q/N/bskr7rnhHvw/VSar1cHpicf+w00VDbSDxsKjSuEpMiAtnRAd6mjeWeWdL/ZO
	 wW5UgQb1iZ8mRJ7U6cvVEvAM5isWaMSpQhvSWZj0iVGl4xJP3DXidHMRKl/WpXeTd1
	 r0nCGB24VhqhqkYXjYiSBt2i2GrsmrPHyAeKOZntp9axWpADzXn44+a3pMa833tsvT
	 wYlZP+GHWNwgkfUedL4ZElh9VHF56c6Kh90oOnN5xYyuNP94eN607DHbUOp++XBkSD
	 XUv2jgjL3HrFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C998880F1F;
	Thu, 30 Jul 2026 21:55:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A007C2CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 849C340A60
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXjMBOTWTXDu for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 21:55:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 39B4440A55
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39B4440A55
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39B4440A55
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 21:55:09 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66UL0qNN3683877;
 Thu, 30 Jul 2026 16:55:02 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fre5g0ad2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Jul 2026 16:55:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhQTSPjC0/OTcC6jcteRYJmYeQqZ2dOeLWBKBlyUJSr/lVRPfAOg9FiJ54AkLghO3QwuiewHm0w65UsAMWxrUO7pXTWDYOr78NiYKZbkXVcIBrAGQHQOpJHMtcyPzdGCN1GF+3TQhMiS6O+nFgYLYqcoO9bum7NfVYZqjDJKR8I1x96J/mah+rIs/uOu1R3f3d/phMjJXsXgZxa9yNRvDYVRaCkpCy2JBPmbN9HkI2fNUBtxknXRrIFj/ck3EcLQXqYj+yLCgQ9MKMymwPrcXm+HUOKujwrC1bOQ3i8ws1Av8QWS6pXXwlmg4Y6ZZim10qFuWutWSeGLHdJLTesT+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
 b=oRscKJe6EBiDxlhk907jZb0YdE1ljeqj5mB8yQfXuhL3TJpE94oeYKRbiKMz52x+j8BXFA/vqirBaujShL8h079rvpK0JXS0wfP4snkGtQSYl42G9RQ6AvbOxDJrOb795q5UefRWDjmzQB8UCoVKM4tux5K8GXxs2+buwsyljivl8zQ+0wJ3EUktLJ/0MXkPDKDlCvuvUFlUjt8hoz5kz6yOgV9laHk69mYi3P2IXDSE84h5JN4jabYOwsX19U1ZeN7RSaLBuZ67Kde/ipV7o3cCZda2A9x5arZ+P7hWUKrjXrFovcO5G3Fy1eBzaF/N+DMxihQwd9nqky8trdqSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from CYZPR05CA0024.namprd05.prod.outlook.com (2603:10b6:930:89::29)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:54:58 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:89:cafe::af) by CYZPR05CA0024.outlook.office365.com
 (2603:10b6:930:89::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.9 via Frontend Transport; Thu, 30
 Jul 2026 21:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 21:54:55 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 16:54:49 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 30 Jul
 2026 16:54:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 30 Jul 2026 16:54:49 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66ULsmCr3487016;
 Thu, 30 Jul 2026 16:54:48 -0500
From: <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <robertcnelson@gmail.com>,
 <ayush@beagleboard.org>, <Erik.Welsh@octavosystems.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv5 3/3] k3-am62-pocketbeagle2: add support for efi capsules
Date: Thu, 30 Jul 2026 16:53:20 -0500
Message-ID: <20260730215319.965327-5-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730215319.965327-2-rs@ti.com>
References: <20260730215319.965327-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: 086ac38c-33a0-4d53-11ae-08deee853165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DZHF2/O85wMz3mO1dzDVUdhZGzPl62+H65a/NzNzvAqQqMMLEIIX8T/JnQGdu6HBp8nZxOhDz75P93KQ5Gqoz1urTM0YKDu1RkXQgsHGoDIiYaCW3jZE1MfS+lceFhyHttjycXji98synmVZijenCUdc4oqu0PYCmceIG/qYQluknLUkG4BKOiBHJIfJVLObN8zDW1tn/yp+L3JDsC2FFdd73PtH6/9a+wCO0/Se+OXAOioVWASgv/cLkBJNgNTQ1Zbg2v/kDk8ti5ggJQ1Njvo8K47fY8PxGqWOkxTj+UOBMC+ylyg9RIDR4wjDMPQZPKa2MXdFUKkpBT7Qa3il6XKXuoZfikYh0EZELsoh/z0vxmNcbgK/TSoTb9Rq6TLjK56efxgqIyJaPbqUrhD6IEuGqESBbKiZ5fK4zUpTUQAb3JOuejn/mMDOJbBjTuTC6FgAxFJomFA8KYF/jaFl7iXCcvDE7VL2CSqwvvgGvO+NH0bapEFlMNo7TUYnlT/hzsQsI3dG+G3+yBJsWu+bMWRPNMNfHR7qeQ31MomE0m/GZ/b8DocHXtLZ1bX9QXEflM9QKLa9HoMFxaonXCIzyoUHuuXmlyjgCuHRRMlpQq7eynLEY+YVFnX9Xdd78eT8PWW00MH8BQaME4kC9jT5dhid1UmVz3N39mR/U0zjSmlbcUYsEznHX10Q7G+1ik2btmaxyNOpWYCyb/bt4sgOgw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lT6/UaiHq/C7SV95S6hjax2w4CzhgUUPzjlrcWfC6+vMPM1yK/P48PjUiux15GPt3FxDR1qmRG7MNwC68+XdUYUfecFAMkMUDZGklo8v4vi1p5faNpcWUemXUBPeguF7vZ85JtrSoeUMxNssEj3uYrlwhDBFsUmDr6B4shesylxfnks2+B7tdj/pM5YQjI5QTe0rINRcn2jcC1pwshMtr8YUDD27UaZHpIsPKdiLcaaLLyZVxi8pVIx7ntW3BP+960rNhpe3gGq/KQEHnithQDkEF+frWZsT5w1SRrg4u74UVsziD3WVIR+UEnAyF4FXHLce0UN3y/ja5fo8Mz57bzaoBpnqLdJkZYfbZvpS6RYysLfzMV/h++hA2m+pz6ZIraq/fYOYRrcsvNlovykxzpPvVQrEVPvHy3nEVeeFEQ0Es72IgTHnNQDnpVoqdp/D
X-Exchange-RoutingPolicyChecked: mHX0FqVjVI1Qhh3kZAfZ+CJa1EpzJ7AFiWk4owMYuJH+MtI3jUefqH2mF3jDEzl6fWiuDSUbua4DxBFfS2E1cq+X0qd8xQ9s7unno2Xgyi158D+RRK1qqU7oJNADrwpy4p2FzeboUfS5Mhc8HT5mjbWK8lg3Pw38JNuEptv4adrnlefalIdj6G3zwJxPIF28Vkf26eSqS/0n7bBZdHaJGztZpoo59kRKIn8hQgiTHCcg3M72UGHHvwi4PZy+Wk1SfsqIgzAilWHZfN6hjQcW9RiwZOkB3uYCc9YokFyM6tIUDL2wzU3Pm9z6Dl6XzQBBhXxaHEnV8ZEp/k64nc4U/Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:54:55.9084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 086ac38c-33a0-4d53-11ae-08deee853165
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=6a6bc836 cx=c_pps
 a=UZZKR2DsB1PZv1vhPkDPDA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8 a=496d86qWRiBu538VFjQA:9
 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX+Jk3ZvbYpdeU
 utbW3kWWlw7loEaA1z07AwAiwZCNcA33J12jFU+Ge3JbF1hYMuqYicrDPE76AQPHJgVyRC/hXej
 n1EfoEq9F/1mQztoikrsviTykXNHPYY=
X-Proofpoint-ORIG-GUID: E6kPr92Y4950_7FWICDvEAUP3YT2fSwl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE1NyBTYWx0ZWRfX0ux61Qkv5r2k
 A1KvHer+KZ0EGEs8siloK/4qQjWpwozqdem4XqYnrCSb9eayESX2do+aRCo27DanZ4nm7YjmumC
 HPnJXJ8BlDzYLUImf3KOsMoBX/z1Lit5T02qpExEjpmETnexlg/nMClLEE7ibAIMgsowaA69DFL
 UFEa1uixUSIGaFytQGbGlsXTLsSy33OZ5fzQWTlEsQ8wAC9IXtWn8l/LotBP+94CRBuW0E5odBF
 A0QzoFT7GB/ufsG58sQLSNhpdQuQPgP3wqUIiFMvOLTkCupbhlvudgb9f0YvAJYZKtQS566l7YO
 PmVZcKB0RstjyHERDo5HTFzMj8cNWE3hSRO5BRtTo30ac287kPLKYkUc73F15/pj+BglKrkQubF
 KlewBMo90nZ6c2fbse75Gx7eU5UwZ5JH3/AtVptq+W3UMwOKjeWARDT4MgOaTLDyU2vcz9jgYKs
 m4UhNUe34ZjPkhZSGtQ==
X-Proofpoint-GUID: E6kPr92Y4950_7FWICDvEAUP3YT2fSwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300157
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK
 5Q=; b=CC+xcaa8pvS5vAZlfMu/JeAmTRclW17cEkpYLVLbh5MMz5kpgpNf11l3k
 5Ri7Pb6Qtze1Ex56t9lhwrziuKcXIP5trtkrWj2z+SP06W6m+88YmNEUaWoUR5PX
 Z+0a0D6DvYxLe70c4Ib40tHobQvm96ncBKP7NB/4tZcTB/YcgBIEwsK/AWQJJR5f
 puFSMkiILPH21UhxLiUFeJ/v1266UAG11UtcFpqxMTOC3AHK3CoVG3bUrCDN3odv
 H5u3zIb2hlea8AezUD+iaCWPAdrlby20Kx9EcQJccVHmACfkWCLeb87KMU/fS6A+
 lYI7+fkFZMNSIb6FiESKyJoTHCT2g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
 b=P5IV1qJ7ioUBgtYm+63B960+ogvk5uStTfZAhsQozxV41lqfemkxJwdXrVPhjLu31CvQ+kBfFr6+jccoExs9vzkpYXiNl4XwyGDGajtloLouOjcGtPvkX7y5K3Wf4osmeDBuZ7wr1jzpQMeOh2/dGtkW0H/33/DYf1vb3hDZWtQ=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=CC+xcaa8; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=P5IV1qJ7
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Randolph Sapp <rs@ti.com>

Add support for EFI capsules for this device. One large caveat is that
the partition holding boot binaries cannot be the ESP partition due to
the following ROM limitations.

- The boot disk must be MBR
- The boot partition must be labeled 0x0c with a boot flag

A separate ESP partition should be provided for EFI capabilities.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
v3:
	- Remove unnecessary dfu_alt_info_ram variable
---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 29 +++++++++++++++++++
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 26 +++++++++++++++++
 configs/am62_pocketbeagle2_a53_defconfig      |  1 +
 include/configs/pocketbeagle2.h               | 25 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
index 452161115318..283e26380e48 100644
--- a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
@@ -181,6 +181,17 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR "F0D53723-106E-5346-8A41-85EB2D07C720"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2 */
 
 #if IS_ENABLED(CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2)
@@ -304,4 +315,22 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_SPL_IMAGE_GUID_STR "C73FDEA2-3964-58C8-8A25-E55102172E1D"
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR "520E1012-DE6C-5992-B43A-95D53D8332F2"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2 */
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index 291a1c6c3db7..acc694c253ea 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
  */
 
+#include <efi_loader.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
@@ -19,6 +20,31 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_SPL_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_UBOOT_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 1=tiboot3.bin fat 1 1;"
+		      "tispl.bin fat 1 1;u-boot.img fat 1 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/configs/am62_pocketbeagle2_a53_defconfig b/configs/am62_pocketbeagle2_a53_defconfig
index 8964cb3b1955..7428926a8ba6 100644
--- a/configs/am62_pocketbeagle2_a53_defconfig
+++ b/configs/am62_pocketbeagle2_a53_defconfig
@@ -122,3 +122,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
 
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/k3_efi_capsule.config>
diff --git a/include/configs/pocketbeagle2.h b/include/configs/pocketbeagle2.h
index dd6956aa8b90..aed60d325742 100644
--- a/include/configs/pocketbeagle2.h
+++ b/include/configs/pocketbeagle2.h
@@ -8,6 +8,31 @@
 #ifndef __CONFIG_POCKETBEAGLE2_H
 #define __CONFIG_POCKETBEAGLE2_H
 
+/**
+ * define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID - firmware GUID for PocketBeagle 2
+ *                                           tiboot3.bin
+ * define POCKETBEAGLE2_SPL_IMAGE_GUID     - firmware GUID for PocketBeagle 2 SPL
+ * define POCKETBEAGLE2_UBOOT_IMAGE_GUID   - firmware GUID for PocketBeagle 2 UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID                                   \
+	EFI_GUID(0xF0D53723, 0x106E, 0x5346, 0x8A, 0x41, 0x85, 0xEB, 0x2D, \
+		 0x07, 0xC7, 0x20)
+
+#define POCKETBEAGLE2_SPL_IMAGE_GUID                                       \
+	EFI_GUID(0xC73FDEA2, 0x3964, 0x58C8, 0x8A, 0x25, 0xE5, 0x51, 0x02, \
+		 0x17, 0x2E, 0x1D)
+
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID                                     \
+	EFI_GUID(0x520E1012, 0xDE6C, 0x5992, 0xB4, 0x3A, 0x95, 0xD5, 0x3D, \
+		 0x83, 0x32, 0xF2)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.55.0

