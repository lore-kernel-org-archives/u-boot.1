Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88034C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 11:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 956BD60890;
	Thu, 10 Sep 2026 11:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6rVZbDza_s6K; Thu, 10 Sep 2026 11:44:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B8CB66061B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789040697;
	b=bfxsM6HplldNVaqETl3XZSeQovEnmNvaYjOOUt7UQCz0p3oyWDxlsMp20/7jckRy2eTY
	 C62rwyDii0gG05bTHYPD+TzQjf7y6vixiBd+9UF9QtRN7qqhgoVmtLyj9Fs51Wxg1UgDw
	 QJaCCI6B2H24v6CLHDS7aou3M0kET5yWkC1ZwmIkNvNK/vf8EuXED2qc46iKxwFxhKwy6
	 +bRU9aW7ly1z8f2mI8PzHtvcdzIZGnfxqMR4Sxs+1sRgD5+4Y6WHsNw+vQfoxVQsw9ZYt
	 2Q5wiXwUNGps9Ln3b/yxGjIHZa93ilvwc5jwk+X46EIB/H6vrJ3IObSwf6X3xdzKICQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789040697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dcRh8i8xjT3JkcfmACSJYq+FlzuQGrWs/7VfvzhVS54=;
	b=nxnsMSRMwsRNy267g3A8g42Xe/MJSMXYFPa0SwO66rJJ9I+F8s00NfvSg5GohAfuwUiC
	 t4VqSwKlur2GjinVHLGHLNIyq04uW+AotsvQokwcnuakfHBlE+fnIrwz09qS14y1NSeUk
	 GYrhTre8YMQutxOUWlt3rTRuMxUU7uG1O3twGmviKOrtUdS/KDyw6wjaERI3a282vniWH
	 m5u+j8SHYVgGcI/7CdLMwAotJWOpCPjdqRMztBsWE6TN739ctSSjCCQ02hLMGDRZ8F3yT
	 /RIB9L3DQ1CwNe4sP6LaoGziSP0CRTVFAbCqBb+ot/sDsrn/lzuE6chZ8qIBOCZujfA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789040697;
	bh=dcRh8i8xjT3JkcfmACSJYq+FlzuQGrWs/7VfvzhVS54=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e/0/EOCjWyngiQaHf1jaFjAWnPQkccR2lkgtjIZ4Me1JbuN9bNn//Nrco7vG/cQEq
	 89069rd6Zw5PE18bktJv01BcXVkVUKEhdHyScPgdsGlbkoCzVgejnZAbh1NCYH0Kuk
	 v6fPmwYjPV+u/+VbXBs54Wl1dT1MwayVv49L0jRFLW/HX41jDsClaRv3ySLHsf9CwD
	 p96EmTzAr+53bcyuNcO/wgTIAxCNzi1HnhirhyruTHvbbO23tunDipqJKkszYChAy7
	 AOOVxc7nLUY+/SP3Fz4W/xccILhpQt/7SRpIof+oTzqbHoCqxm/u0FKHSMbnQR+kaL
	 gkikMMiPN49dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8CB66061B;
	Thu, 10 Sep 2026 11:44:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E60A43F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B3804006B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id arHw6cr7x6SL for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 11:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6BA4F40024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789040695;
 b=rojic7F/7IeuC/rYPiRyiJ547SSjtchRZGKE//Oa9njjqvHgwtMZ9H97GodKMfgUdTf0
 2Qm7WfNgVun9C1VMOG+sdSoaR8JojFBk87Xqi5UtH6FZuWpeJ1KF8r/Y9/tJuKyWiY7/C
 xHoess+c+Rpa9CI5rm+wqxar+Tfq39qhfqkh/UvXTQcue8kh//0tBPsFaZBzaziW1TqAW
 oEI9l7FcNtA5tnBv2RNIMwut3pxZKWgl1bj6FaPTWZSwh7SLofEpLHTe3oTTc53rAXHfP
 oVhgJ58i75JbrUwc0BAlyTIaKCmpXnAjq1QLk+6wWsI6w1wR6/FzrMREik2yZLt03zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789040695;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dcRh8i8xjT3JkcfmACSJYq+FlzuQGrWs/7VfvzhVS54=;
 b=brkGLpcRKYixmRi+ZLgmUwlMOnVbXVkKBDMitaAuh67uFzhZ3b8nQEgrrIyW1sSeQh7r
 RXjEKGCTkdMzfTnL93hVKuO2HSlx8is6+SiGFswyR11i+2Ducx2mfxaFXqZkq0XKxIqoJ
 bUbyDAfUTsVTyhlMdhyt/LvE3yXMDFZ9QYF3wti/ndJHXfLEp+nSio1Jj9pmVuUxh0o5P
 l1xqt1pLj9RnuBfwFYML+5ZNexuMx4pfGjS6HQBKp9RxXWDsKggwgOpNKJdZLO94N0eKr
 e70PIIomKgB9kyM8fnxBdB9E74jSy0IFY2Mt0J0syw2ktjg65tEdO0FWhoF9+pb+Ifg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ohB3wrEE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ohB3wrEE
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6BA4F40024
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 11:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IINRnYqChZaN3sGZs3w8f0ZDNE0xPjaMRhU0uI39nR9sO0ql9FXh9QkR7E9a7rN+vM4w1frkVlzWO59m7y8osDLyki0HXincM0eM+GB7hBRNWXDyJio1H+WEStgT9jcZcUdUkYCflUAM2WRCzwee4bGr/rLDXxaT3jEVJSb2b25DdycoSVZPbbHK7jq0oX2bFq+6vDismJUBtVc6f+CAD4OandrCXbBDzUngbz/oip9heQ3dFNXkxkWcuezvOKT+PorQbVZL7N7bm0dxbSwarZ73wL5UTgArR+yFzYvFHfsJGESPfzdY2/cy0wqizifaL3y6YkKePYy8KzSDRZHyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcRh8i8xjT3JkcfmACSJYq+FlzuQGrWs/7VfvzhVS54=;
 b=VbLSDpHmji3Vp9y+nZxbDjs62fmUzVPSnW8NQRm5bILrLsMyqJaX6kJJ6mveWhRtPn5cTHwVCcYcLE0EiB6izV4GiL2voSjRdG5laqGf8g8c1aO3RwMqTCySQJGeCdjY9kaO1M7YZkgdXnbXxzMB6itCQN2hcuNeUJ2kqKYf9J+OZq9zosNGjG0XKGPjldF3/snbhrDq+ZXog/vSGE58YXnO/YVSNNel6hn03UfdthSMtrSedZg7EeCyI0JrJD2Pb9dwM3KWq7XrqXrIEr555CcOvoAVux0vAJERQxMU2UZOSNffnjslkw8GNOSSzXGe1av+A29phHLGAfjjRCnb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcRh8i8xjT3JkcfmACSJYq+FlzuQGrWs/7VfvzhVS54=;
 b=ohB3wrEEYghMkRlPR0/9Qci1CxnpVYfVvmCI19YciSZbuJgGkhEH8VLDThJ1Z/V1CJnTCh1BHykSQidLeEhq2S22rbJrD31e4x/hcUAlqnUjSspqf4V/CVuxH4JTm/HLxhyyzpt28c8SixAR1aW7TcpHPBaxfoOTC2pI4JtNUo0=
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by CHXPR12MB999245.namprd12.prod.outlook.com (2603:10b6:610:2fc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 11:44:47 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::37) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Thu, 10
 Sep 2026 11:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 11:44:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 06:44:45 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 06:44:45 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] gpio: Add missing dependency for ZYNQMP_GPIO_MODEPIN
Date: Thu, 10 Sep 2026 13:44:35 +0200
Message-ID: <c4b7a0b4461034976b18c94ad4e296f5ebba924e.1789040674.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=820; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ii59jVMqa2IlAFgRSmtt29hVcjfvqKg2A9kZ3u9GbxQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQtmqH1POHWQoUS8X75j8eniG4vPBJxYrdQf8eb4OlFf
 9xSv8y42FHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATaU9gZHjztqvh0o93maY2
 jadjjJfsv21qdnHN548rnjq9nnDdfn4LI0PXT6UXhlcmG/0WOvBq0oNobb7tU69teHTq+NeyF/d
 +R69iAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|CHXPR12MB999245:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e881fb-1f3d-4c63-c6b5-08df0f30ea3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CU/lHNV1dBDAeFQiaxniw51ei3eCkwf70FswAJMLLpzh5WcLc6xZy3UrwAwa1bgNncdabWccdTCRg46wkTGYf3JZabDx0DzLoGoUPaVwdSrB6wRc/PNWlMNUTfjs7JTKE1U210a9leS44vqP8iiTHK3ZjPuoolBtFOkIX/9qTWc1xrJ+SoumwjKSUrdSAY3QDIiWqxVBogVLtbD1cwtIeXOWoXJIJElxOGKVqmF8RBfzsGmIfmk1lNcH9gJ4YW4AKCwUXOkAAAI2Mn53qMbk051b8sKzKHVmz8SsZtS8h2GjI8iXY8+wDTOIl6GJVwKp3mYg/q0+AJKrLchkNUEybgv1RDfLF5kBy9RUIBPCJ2rC6UfvAyLPWM2zKa/e9xy9rUGHAyCkTwvylX+OG9OJt7s4ux+fnZNwDox9aGZY51POmamdhFbMNUN14xW6F5ASIF4eCWLdapPPfcUjt5G7om7vTBQA8P6MRL6ax80ymRQpR6kvt9IK+7pWzXH8GMokoTXl3Z9zmXjN2H2GfU+jihmD9AoKlAPCQ45dGN5Fbei8IpfcXBxGZzwF4Ka2W8IZ2poVcCCguymRslAxD6WMeykKBb1Qplv/Yk+dAVe0crtDlTjy1oSRDFBqw8be0sfcU+tbcB2LXY7XSLlxHMDCmyplIdc5ru/4I8j2QbvDAbQ8WemeG/Mrxl8ChvXNmXTBuue6kaGtSRcQjHmjdQgjXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lf/JxftxB+Engz0UFGfsVY0OwiMmdWjLZ/l7uRxsuX3eKPvQQoulUPzzjfCStJ8h6oQ2lUqcH0qZhqq8nLc8cgvfdnA9juvu6SSDAqRXO/HvKdDxeyZoivzdLH1krzGCR1cYlE4j6VU+Aag+8uiIf//3ACynI6yilhDj5u82zWFFjVVMbBIUnSF9BvLq5++UlfNHa35Whvve6OSSPrSfvOPjFW65OI02f0RtsyZQP2vlsRPS1S37PPQhjqEFVEUXow7ErPaTjvhgbQhkSsnkUQj+cpzSHrCmhezpPILnuak80OAwmF7hmq7PErwgY0xf/5feXxq+Rqs3LYE34CEEG+TRr9OAbQI+14OxQd+pOdU4GHiai2Bp6PPy/XlWBNfXMUYg3Kr8TYYvzpK0GghPzQ2ut3mB/Q3+Cr5zGIB/b0vwFjLqhx+SgpaAlPdGsUe9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 11:44:47.1505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e881fb-1f3d-4c63-c6b5-08df0f30ea3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999245
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

The modepin GPIO driver can be used only on ZynqMP, so add the ARCH_ZYNQMP
dependency in Kconfig to prevent it from being enabled on other platforms.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a11f30436708..6da66b6f3f31 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -714,7 +714,7 @@ config NOMADIK_GPIO
 
 config ZYNQMP_GPIO_MODEPIN
 	bool "ZynqMP gpio modepin"
-	depends on DM_GPIO && ZYNQMP_FIRMWARE
+	depends on DM_GPIO && ZYNQMP_FIRMWARE && ARCH_ZYNQMP
 	help
 	  This config enables the ZynqMP gpio modepin driver. ZynqMP modepin
 	  driver will set and get the status of PS_MODE pins. These modepins
---

-- 
2.43.0

