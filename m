Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4CBCD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CDD849BD;
	Sat, 20 Jun 2026 01:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c+b6fSvL";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LI9qz8w5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3159884873; Sat, 20 Jun 2026 01:17:46 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6220848EB
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 01:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65JLXvPT3073545;
 Fri, 19 Jun 2026 18:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=iANZHwGn2liO1IJ8O61EIvr89KOx/7fXWZAgYEZId
 Go=; b=c+b6fSvLu5nhTGTE4HXz2YPl5hHQSiib8vH8rlwQcx8YGVGvHzeb1TZ1w
 88xhfyQG3tJZexnKTZZ/IOBqBdRUZ4XHZ5wJK2gDkuzFwOZfvQUDcwqAwPt/fGm/
 jGBeD31mSn03gMUDzJW+ayWlVn8raAywdDfI38NnsETi1Jn5ll2WNHZyNJbuK9gt
 AV9pXfj6MXlqPNV7S5XrOZxVP6LxCO2MSFka5V36yqYGW+PdD/gGR6/DRGqwUSrT
 P48wI1xgKeGBcjB/YpTKVv8+Y7hnejuHYvBshT5J+kxWuZ921aENf+zHGw+GvMF8
 m1pqUfvlZH/1j2PtFfnmLegMnz1cQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ew5x93re2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2026 18:17:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBxOB1yqZiNk3zXmZlS8jfvGcYkmJBfn//xzGR5N0O5mpkZrEFsaik78gJGjim3HSzQZTV5FkJjybu/F3qqLAj7zIhu8iVOgPShuOTGra4/RLoqlTn2Gjo+FFXAt6jsnURqiE1BpEhLn3c0VDvp1bmRSkc/tls3jK5JGiPMEh/YnmTqJTWfS/pjlCIr4k+WJni6borjAzte5tBGf0W4XAyrQGT8g+errxnBHKbp4IgjS2g2pXWozzUD3m9vj7dONM7LAY8GeGcM8JDTEOvAgSaLQXj2y2eZz57j20rqOH4RJIeb++V4o6SsZrUytCgD0B36/cKFZuCWPaaIgZ1pv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iANZHwGn2liO1IJ8O61EIvr89KOx/7fXWZAgYEZIdGo=;
 b=OlJwEQD7HUnQmVwnoxtSQV84eupKQ10bWJoVP7cLx0A9HF6hZqAZ17SRA1ihlR7b9yjCi8LMLZb9MPkITjAtsCAfdo0DehAUFmWFm1zeTwRhdCvoIfMnpTMWaRxARsm+4vD5tpnio2e21uEf3oI7ml3k+1BttV4TriH4VCdBQ2CN2lxShrE3CKr3sbBz+6oLzFQS11xC5Wnudomsw2mSd9gUS83ck0wNvjprvBDQbc4wkWyQ2ktgJ0lYpOtxN3RCSnNAXrQamyuUEifhnCUfcr/jj7RntY7AkMNeUQO7wq7jHSmNGKnd1fg0XkA+gpBybGPJMXtY5tOVNcSXHdb7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iANZHwGn2liO1IJ8O61EIvr89KOx/7fXWZAgYEZIdGo=;
 b=LI9qz8w5FaArdONipoRyEeCxL3nSDeKQzbTJArTqye03MHmiNqoo6yeY0Dphu9IyDmLN+Mb0c5SDUz9Athj/Zsq5KsHhLm0aqePuTZM8UJ6AMHKainniYFvONW+dd2XuhRHfxdfBtj+kZstZezzbcl7lXOb7syw+p49bIChDmG0=
Received: from DS7P220CA0111.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::15) by
 IA0PR10MB6868.namprd10.prod.outlook.com (2603:10b6:208:432::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Fri, 19 Jun 2026 23:17:27 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:8:25d:cafe::6c) by DS7P220CA0111.outlook.office365.com
 (2603:10b6:8:25d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.16 via Frontend Transport; Fri,
 19 Jun 2026 23:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 23:17:26 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 19 Jun
 2026 18:17:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 19 Jun 2026 18:17:25 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65JNHPGU3686026;
 Fri, 19 Jun 2026 18:17:25 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv2 1/5] board_f: add a board_setup_dest_addr function
Date: Fri, 19 Jun 2026 18:17:15 -0500
Message-ID: <20260619231719.3823195-2-rs@ti.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619231719.3823195-1-rs@ti.com>
References: <20260619231719.3823195-1-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|IA0PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a5f50c-226c-47e4-7470-08dece58ed13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|921020|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: k9dKBVc//ydgraIja23KgYCJPvy4JoWKNWmJRqQwhtL5hLm6osZsNKTamk4LWeW7aGX4K/nbu5gp6Dtmj+awygCsNaBqtknt0JUs1LsHkuXKYW086GY+nSH+93LU6ZGyy4CHpIesJqJpItvEwmCQoSJkVeWpC+HZM3TJBFB0t1PpR8GlSFSp7i1r3gOpHmpfWLMRVnlQNppmeaA3EkfrzBm87rC0t0AiuqLiVbXC7Mcgh+2YxKFiU324o34LmgJkdGGgUG2uU3weQQiFV2p0+Z828nts9HNAr4yJ1oMSG/b6DOOpu17T62HXoGu/kRrBPIwIqc6WSP1RHzX6ZLSh4Upbufw3qv0fFJWX4V0HsKVwksr4lyahjjRhJ81hfDjbZOjkHYgO5J39zmkV5XJ9Jril76HDH5Y+W7scCkxaRZSQ3iFcW9Ew2+DAJ+5tSf+YRm3FWsa7B5DOeHsS6zIp+ALFoZBCtvIsgd+GRMA/0XYI0J5stuFhKDT6BgRufwcrtInbQG/nQi7anMpxLryopkOFPrBDvvHjb9mcGpYlGZ0yFMCuZSZRvQbQU/K0VPO1SNGQRJvTZ1NHF6m2kKI189ix3Yw9doyUYzDenH9/stLNSTwNdS3Th6D5JS16/474+TFvnQv5mnlXrIwzqhshwcOxf2Z8hNmbY3m2MLRtbZ1EvdPj45ADqGk5QoyAMVEB4gpXH7XDs9GyXQbTeP3ZSJkaR0ZVHzwkhtDvnIzTdAca0YdZweVSK08SKWP3WlMX
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(921020)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t4qovdBPm4ftEdIDxyuc5hE5hN0BB8tVXLXsT9x5LgGs6CQEQu0+tKXdO0xkD5Jy2+ZxkVrY878gOaekZyBfBIYmznXJaQj3YoGfcFkOU4MWtdHukEaVn2bQEc6aajc+DvdtgAnaxxIFQdS5nL895Zk+24UhjQMsw8o2jK47TJbhAiXHyx1RMIr59eC+ctzFDQ/2oqxRgMxVMHuzwwgQTSB9WJXJW7B0WcwsVbpDouB5pDgGGEbBYjYKQRd0tXtwbz5IqGGRyUgIkLG6sbDZk2Ey9XFzhQe2Xq3R0BJZelyOxIH8rBw/Lkpjux/OA+pybqHIOoRFIHVnfICDqFH/eojHyvfKTGPmChvuPaD/AEuAaiPO+nyqk7FrLUpMmW1pn2Z7iMgLiBVMqvSCZjDXbRZfOpJqi54TY/lgeIBWW3F91cD7oJxPlaDHsZM4e2sd
X-Exchange-RoutingPolicyChecked: nRmSRrWgu9P7oCNSkpHdCxDkSzAoZVvMV2Ytdsy4dkGYwou3xk+kunCGMxHcJePhdfpXdADAqmNCmBxIF85aMZNbdVtX7Z5nd/n/PsIoEJNMTkC1UEbvLJt/oRyJCLJqyiQhJ/Jkakzk0+7Rlr5eCIQIu4bVWUmREA05QqCAR26VOp29AnhjxYuNohmG7fN8oObtTEBYYK8fCuMixQgYw4dN5vwwMWejZnfpkFA+LnJ8030oPuAK7J1SjFGXY7nE2VT8VthAakW2XeJxHyGReEzM3+MTVDIo8GfdsdNC9ef3qhwhfQU28REDB6K1y0ALWv9iAESEWOuZk48N44dnyA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 23:17:26.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a5f50c-226c-47e4-7470-08dece58ed13
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6868
X-Proofpoint-ORIG-GUID: R-SsMFn-1guK_dysOSwTg0MxG0n1lbk2
X-Authority-Analysis: v=2.4 cv=B+eJFutM c=1 sm=1 tr=0 ts=6a35ce0b cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=jU8SXrr8R60sTTSGE8oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfXypdv+9qaQh9H
 9g5K9t2GDEhiW5hoAu9pYESgEvPq0L+YiRTBVGVtSaeCjqyUh0W2XpMEPdmzxLvfFT1Qke8rj1X
 qMO6OUk8EVq85xKA36JWBsiQ7P9dN+E=
X-Proofpoint-GUID: R-SsMFn-1guK_dysOSwTg0MxG0n1lbk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyMyBTYWx0ZWRfX9lL0DWGG4cmq
 OXk36ibNLTjWXhaDNaoWyyHRyZCgaN0kPoK06WvtIyAwW9nbkWWUM2ZtYKbrND0FnJ6HewDhx3J
 c8KlO2YuCotdWDeV2BSxo2k0MKZkmOcgDjFpQVIp8vw0hoZg7DRw9/UrGdgeM03YR1IWfPlCEME
 SDACfXd18TBTS6xS+gia/f3+x5T7YdAA2AXcrbTw++df1yKKsGWUupSQcuxYrZzyg/SzZb1GbJq
 rUgf3IxGLodXCAVbtGyKN3kQ9eMSnIQ13mNqHjFpzItqsVAEM6VWnULB7wGD85RPolDx2pFPfeN
 Qlyo5d0eT+W34Fo4MnxTAUNQuUWcJGw5RdPF6IjMBRUr05XFhuSRNo8wS47xZdnNQYZaGT9L0oX
 4ohl2CmShE667DhqQOoGx9Byz5Gsevy3P8Gn25UWZ8PfKa2x5/WNk1j13bhi3qlShq2G807IDnZ
 o4fYuFaXuuuRxp4MCnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190223
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

From: Randolph Sapp <rs@ti.com>

Add a weak definition for board_setup_dest_addr, as a way for specific
boards to override the gd->relocaddr address before the relocation
actually occurs.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
 common/board_f.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/board_f.c b/common/board_f.c
index fdb3577fec09..d9d09ac94bf2 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -328,6 +328,11 @@ __weak int arch_setup_dest_addr(void)
 	return 0;
 }
 
+__weak int board_setup_dest_addr(void)
+{
+	return 0;
+}
+
 static int setup_dest_addr(void)
 {
 	int ret;
@@ -362,6 +367,10 @@ static int setup_dest_addr(void)
 	if (ret)
 		return ret;
 
+	ret = board_setup_dest_addr();
+	if (ret)
+		return ret;
+
 	gd->initial_relocaddr = gd->relocaddr;
 	return 0;
 }
-- 
2.54.0

