Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E04606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wvYEZWbC;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XtjliFzX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 313FC60DA3;
	Thu, 19 Nov 2026 13:12:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J-L5asFPek1B; Thu, 19 Nov 2026 13:12:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E1B760D7D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795093937;
	b=d1w5ZiswdiT004BzOBNjIGA3zk2v7kFI7JLeIZMmhpOlawYshRVm0Xx9QXtw3rFpVDnr
	 G2CQ8/X174meEc7uB3aXOGSFsDToadfLqziM00lzq83iAdmM+YkDg/vogPRNrUrFSmFfa
	 iWcrUIuU9IjYMJeIKxKmIjkshyiAtGIutOXc6FCvjWGw1NUHadYUh1rowpccdnSJUIxw9
	 JGiGbywdiR+nLJKNudVZU8kuimoR5gvwTFomdWiWGjmz1GjA+seWnx8EHJGuB9fLGyQYo
	 7ptlFrAbSo9uQN6NnLG6pu2Xs8pWVdosO2pMkF94P1FeMwAmEnVbjDy9/UXOuO/r/uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795093937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rE2+KeBe1Spyn1CHeXvbP5UwCZpUndzjWtVjHfN6AIA=;
	b=e5wscNH60JE1T/nJt/GQm/NWT31f3/1LpnI2R+b8ODz3HeGEecFRIwPBhbBxlV9e32jZ
	 GNpePQzAypjwfYjV6ZBcjTHKrMQOO0IkQrf2TyG/viHiXTnIrQoa2anKqaFt0w/UZovTu
	 qzpj4JStgXcF2HL+5Y1ZW55SBPvR/59/opf6LP1J2Aw/b/P9afZCMCbaiYZkECwrTHsGZ
	 iJ/cHr3KXSbwO43CpqJ1aElOgDVR6vEbq4lBOxN1Ib+FXv5SmLNuV5huwN7J/hmSZdI1T
	 HwcfArrJbgDv/N5ABT47BeJDm5cdxCxx71FxnhLjAP1Ux4zlTz8fj4WKM4jxNuCX36w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XtjliFzX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795093937;
	bh=rE2+KeBe1Spyn1CHeXvbP5UwCZpUndzjWtVjHfN6AIA=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wvYEZWbCW6WdjB/qO9JIyV/MlQtZfHoCYTQFTZxrKKs41zCWJ7zG2osPW8d/ee8Eg
	 Biq+j+sumAGiyrqR08KIYuE5vT77xlO3wrPNbHjbD4KDFRoDZEfYDkQS4N2aKjYMWH
	 6sAK4jy/Lerejhj1saOFXePoVB0oP3kpNP9CKN0mBlur2JhewhPjtc4oUkETcFC2ba
	 m0nNStu2/ZoHtsei0nUVDDVtW134Dl29bgK2+6GPbpv6UirHALkww0BeR4fO11wsaS
	 8cLIrt0KSruuKzb8cofzGPxHUe8xVN2hbRNtL7aV6K0sZAsOw0Gf7cIPcEqU62YlwH
	 EH8Q2szO5f+uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E1B760D7D;
	Thu, 19 Nov 2026 13:12:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CA5022B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A1A160658
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hwsJhdwkzXoA for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 10:59:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C99C660D53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=XtjliFzX
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C99C660D53
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE2+KeBe1Spyn1CHeXvbP5UwCZpUndzjWtVjHfN6AIA=;
 b=XtjliFzXA5zUoUA0CE0w+me5LZ785rrX1M7Z+Na+0OT7xNODuh2tcfyAcpoeg/PjbaMeDtB6nLIIVqMbsHBXYqrDxBzNixOOtfzMN3E6bcuO+aR7T0lMO07PRykS0fVFp+LeKAqbLk8MkA7S/0lDAHwiqsNiNxaWivCZNRaElKvqHnCGG7aFep62aCOHZna2Cw/jqGjec5t/BdeB0QZtqTLArtU0kf75/tBIm43F1pLqyqDqSlp3urWHEWjcrpH6DsT1YedmM7Dw3GmqX8E6koE8lKm0IPlEF88lqgT1+VssNMZOjl5arGyuy9Vlg71nF5W2m5Oa3Rg+L35TBVd9PQ==
Received: from GV2PEPF00046834.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::338) by AM9PR10MB4119.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Thu, 19 Nov
 2026 10:59:30 +0000
Received: from CPH1EPF00000523.eurprd05.prod.outlook.com (2603:10a6:388::1e6)
 by GV2PEPF00046834.outlook.office365.com (2603:10a6:158:400::338)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.639.10 via Frontend Transport; Thu, 19 Nov 2026 10:59:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF00000523.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:59:29 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 12:00:09 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 19 Nov
 2026 11:59:06 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 19 Nov 2026 11:59:00 +0100
Subject: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip USB2514
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
In-Reply-To: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
To: <u-boot@lists.u-boot-project.org>
CC: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000523:EE_|AM9PR10MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ee5b29-e74c-46ad-4dda-08df462c2f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|22082099003|18002099003|11063799006|10067099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: o4XiKeKr7vcUsexjycslJSYoYEgjfjDzQbu8y+mbS9OqarxWzQPe/vEWEo+KHH5VgMp5eSFIZROvSKPD6XBwVPuKwiGYuen9Kq3ra+jqNPmYxdZ4W33ULJrN9Z7I9A2GhhnnPIl8TSLtnlK2AU35/1GtwI7dGHUYEOHacTqwUMkZj5Tggcl//rl6n6u7uXbfm2KCtUlLHgObwD6pCwQ05mGnWzz3bq6kM2UaIA72nAnvjnmaATDjtWAk1NA/5qe7CKBIowxr7SOw19e8wMsuwCyaFdBvV/CyNuor17kz/TynXaGiW6mqi65o0sRgSKNC/O7t1trP/ercpg/Q3nawYVSZ7n+DKqX1qq43Q/hGEAtB5UJoc8StdUMx/jGueD5Y0XDau/FiiwkgDpiW+k/NjpN51AOK78pKfSL5w6Tdlzf9ELrEaWTmAU2DJHbG+d+slR/0hNTjTGuC9l5NVY4HONIqkWO5tAiipGvZCSR72bsENCwR8mi1k5gasY1UfB9bubcBD/beoaHOvx7RpgUrc1woC+b+XVipCMpR3cZGtSrfjFUyOBLoaMFzl74s6UDdQyw4zlWcAdF5FyPkBUvVhKRke4VAtVDL6JKjouAWY8zubJODFY2TjwF1jATKnsknpfBohhV3ClIg+szJFrjRhA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(10067099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zYxhmRtMRJNMIAqSA5N6P2kbj//SRxGgu160dGQ5wdcxU+mKEEkequt7RwLInT4GsxJGxUMpzxqcPR0zpslPxKjACh/ANGljrg7KGxa/kUPMNPUoi5t6MB6YRH9hXOuLUOtwX5UQi4ZqCqqKAWHm3Dho9mYmPoTwI1WRizv00YGBeIB4cO5sZ5NtXq5wJiSxSq3EMkcAzpaT3FOCFppLeZpir8v7litxh5hxYWmhEdDF5WCVnFpn4mBhcXdnXI7MT9IY6KqVg2bL9sEKsnH4ENpSb4Qfa/d9Ok1at1TwsAECmSF9Z4fTMkFllDWf+G4WoPHbKMi3FHswUsXaA+Y1vyf2ciTc0Ex10XZUnLsoCqjcSYVASaPm0ArRIdM6xpW9iKBr7Mq2oXdgOjd/0fJrEwso/yStlwic0bt+ERkJ+CKiBU/sxKJHw/HtnAhVwqpU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:59:29.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ee5b29-e74c-46ad-4dda-08df462c2f5b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000523.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4119
X-Mailman-Approved-At: Thu, 19 Nov 2026 13:12:11 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This hub is powered by digital and analog 3V3 power rails, so provide
the possibility to use different regulators for digital (vdd) and analog
(vdda) power rails.
This is inspired by the Linux driver [1]

[1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/common/usb_onboard_hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
index 0c84c1fede03..4b96defc2d93 100644
--- a/drivers/usb/common/usb_onboard_hub.c
+++ b/drivers/usb/common/usb_onboard_hub.c
@@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
 static const struct onboard_hub_data usb2514_data = {
 	.power_on_delay_us = 500,
 	.reset_us = 1,
-	.num_supplies = 1,
-	.supply_names = { "vdd-supply" },
+	.num_supplies = 2,
+	.supply_names = { "vdd-supply", "vdda-supply" },
 };
 
 static const struct onboard_hub_data usb5744_data = {

-- 
2.43.0

