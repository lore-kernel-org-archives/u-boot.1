Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673BF606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XCAD/noP;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=g3wmYsH3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C5D1810E2;
	Thu,  5 Nov 2026 16:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nL_Uo1XqyKCw; Thu,  5 Nov 2026 16:53:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DB4181082
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793897599;
	b=dPGea+NkjgVOaK6+d5fKmA3Z1II8TzT4EHpmac9c7F7dZSD8+/3mrCOzTZ3PG29L6x+E
	 97qz45UduPjFXrwkidKeuXMnAat7RdoZ2gRrP6eZuVE6paLvcpsx0mUdhsyi/wHbC3/9w
	 Ke6j+2DKaWE9PQQ4O0dhDqOaDIdfddr6zigZ9H8KeGJV1k0uj3vh9G8tKqWyD1pvIc8UB
	 QUxSUgKsf6GrFd8exWiaRDVALcGNd8Dv9aU0OAKcsOn0LKx27eQ87QTg168CncN70LVqT
	 Xi6pekeEENqkT932rYy2FhsM97Ohah5ndsxRMcFzzVjZhKkaM/8ZB3hdAJe2a6paXLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793897599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=zPGw+pcjnSHqshxhLxp07AlXNsJjiiMTDJL/4yC6K44=;
	b=G7J6iqaft5BZSpf0BLEVi7XWRxWiViOocuIDEK5YTUzY3aQTA8dEVqLbojzBP/3FKNUJ
	 Bquhy86uJRQJu5wX4AD0G8oXbd7nTuIq5pnKBAkkS5/90wvALxdbv/onvurQmJja8wdgb
	 GxK5h+gfQIf9pfVCl5DgCwKOhyyTAFrC/3lGoMSH/FoBFbD8bJNUSTOF+BmPKVbrq0mkU
	 8atxMtMQajbVRBNiDNs1yekXVKLJWdtlduLTogaM2HxrN3pyBaZrDipzs7UOnHnqReVkU
	 lC8aIONT8HydKkngyodqkd4ZGPSHQ6fWAnmtdPwjnNIZtHb67HOnAgKuWxakQuexnzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793897599;
	bh=zPGw+pcjnSHqshxhLxp07AlXNsJjiiMTDJL/4yC6K44=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XCAD/noPR46gpFUCPtYtVHKFSzRxImqYWsPKsSTrhq2W3Wt6TPnSfZ/O0SeSFGVst
	 3pfrRiuE+36s6MUByBSM8oKKphbXIwKDH6iPsW1j8YcvujJyN0db4UI/nsUcS8N9Rn
	 A5WqvRwXQVaJh/E8AmkQsvKHqZWbcim0GVYuCtCL851lnwcDReAUnckrIhHmxj9IXd
	 izoMM521o5PFAmqTkhuWu8oht3VaiJTgAYSZ5zzQz3qs+4lUiRTKoosxpvuAJXw++X
	 worKqfT3m717HG+M2eEJlCQYNcGB7cjaTgtwoBSELctMG6hiHdS3Ii8gQWKotefQWd
	 etLLWnkBZCOow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DB4181082;
	Thu,  5 Nov 2026 16:53:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FEEF52B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C70860808
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hia4c3uXXyn9 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:53:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1AB7160697
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=antonio.borneo@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=g3wmYsH3
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AB7160697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPGw+pcjnSHqshxhLxp07AlXNsJjiiMTDJL/4yC6K44=;
 b=g3wmYsH3bXEGjfhVdpxCS1NZiq/qHa5BeaYIKSGn+E1S4Kk3ToDHsA+ojj8FQ41q6cqfvH5Md56hEqOmLEtEtj/0HUzO4cbN8LmktcYGplX1cFE2WqBVTjNtkpfKORflaKoxxZWE6laejDKxNpQ7T/1R+T0+v9QKMTEDThtu/f1X2vIUbSIovbmRHKxU7AGLHFu0fR4Mh+0f8E6k8gudV+7CvGNhpeNjwwk+4/3mCIROtYuDoPUK7uw4mA2qPO8xRFrnIDTJ5OEGFkOgb1L7bYWKRpAhQLQoPEEMCdkByvMS9fGERCwMcMiWnJhtEXT/Xpwz4dyp1wzVfL5rb+yspA==
Received: from DU2PR04CA0244.eurprd04.prod.outlook.com (2603:10a6:10:28e::9)
 by VE1PR10MB3872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:162::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Thu, 5 Nov 2026
 16:53:10 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::7e) by DU2PR04CA0244.outlook.office365.com
 (2603:10a6:10:28e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:53:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:53:10 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 17:53:27 +0100
Received: from localhost (10.48.87.124) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 5 Nov
 2026 17:52:57 +0100
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Lukasz Majewski
 <lukma@nabladev.com>
CC: Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Antonio Borneo
 <antonio.borneo@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH 2/3] ARM: dts: stm32: disable iwdg2 in stm32mp157a-dk1-u-boot
Date: Thu, 5 Nov 2026 17:52:52 +0100
Message-ID: <20261105165253.587809-2-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105165253.587809-1-antonio.borneo@foss.st.com>
References: <20261105165253.587809-1-antonio.borneo@foss.st.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|VE1PR10MB3872:EE_
X-MS-Office365-Filtering-Correlation-Id: b3821075-3145-482c-e4f4-08df3b5d45f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261021121427099003|261009223027099003|261102123227099003|261026121527099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: 0oSfJJCMO/CkWJ0/JGVfqNTGeYrWNSOkGJdC709oUcjHiOWODrgKqxHfzE9AzQjMxU3I4eW8EwGZ5LSqr1Ndg9PWXHF1N/phjtWWLtfWStjcqUsSM6+eD1DIK3UuB8KVkjyl0ykMhwuWJH7mR1VnV8qj2MK6x8yy12X/VoBeyoyebQH6ibypQHRi9I/UymKrDV1zf9HRTNRkWDZuwjpSVQzz5pg40CW5arLWYixObpicEWJTeMmCMHYnsg5Ljq5gFZVzwj8iaGEJPjgfk1o5sJBtSfO6ARHETc17pXrHAymqMv1/i/vOIGvIeB2b+2LS0j8lb0f5kT8v2LnWnwKQ3M+RCVejao2yHam0MwC24+LO15EU4CErAvvArL1UjHBZ8Le5ooLytWQmCZzOh8CFyCZuK4flWsPe+8fXgmmpY413I3Ro3dDtNjx32hljX7bV7+aSn06LpnR/6N0Nk5VAS2YX+xG8C7ofum4jWuMZOAKBio6oEudGrIXqFQF5Q3pUv7Schhgoa1urmCuzUDvdGFfHGZlBn3UJePqxPlvnUWrHIzjHCIhj6BhB6d4yy4d3LXKUfKVfVGq4/AmL1FilvLLwa6ZhSa3aoUsrf7xldtqByZG6vuYpIB2UD2Rshr9OXc58zWVbzCW3JSTM1qpP9PCysWBJOTSwiyearvOL6GKZU1dwADVoNK5BkEvD8FtphhwG0ltwYiIL9+Q3SeoIIg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N9EPSTFPGNJOkaVI7VzQP/CnhuKqb30DuUmQBqhb6pA4jAbvPRUzCmq5/ccjzjywAabRcQh+C2BcbSHJyPOzy3wSMH42h0zBg5T/OiXrtzBcBC0SEABe+igSU1LlMQNvzgha5g6IRvHKbu7/2giWaUL5DijeCcf/6lmueo70reGutcBjeQfoJjHz634AESwSc8mRW3iotMDa3dLOyU2prAOqm5o4sO89P2wOFWu/diIgdqmSdA+mL9wae2h7L7YnZ2dcJKPXDgE9mB1beAAJCTv69vHWbIP/SrOIKUy1tJMjOL7LwlOdrbJeijriaGdNgGRNI64YeAd2G8XYC7D132SMw2IGEGU+TkeATFv73yEU9A/1OS8y+GiWdBwwKzfeg2FdXsHgJBQYt8SCKM7Mp5tzI6Pc/Y+7PuF6l27K3aozh9OM0g5fRietX1fMLlPW
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:53:10.0483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3821075-3145-482c-e4f4-08df3b5d45f4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3872
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IWDG2 is not used by U-Boot, but its node is enabled in the device
tree inherited from the upstream Linux kernel.

Disable the node to prevent U-Boot from starting the watchdog when
	CONFIG_WATCHDOG_AUTOSTART=y
as in stm32mp15_basic_defconfig.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi b/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
index 78ebc3d3ea3..4ed747db6be 100644
--- a/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi
@@ -88,6 +88,10 @@
 	};
 };
 
+&iwdg2 {
+	status = "disabled";
+};
+
 &pmic {
 	bootph-all;
 };
-- 
2.34.1

