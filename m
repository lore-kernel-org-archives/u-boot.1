Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFF606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XuGnJuqd;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=l5C/R+dY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5351407AD;
	Tue, 24 Nov 2026 09:10:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G-Ru-EhvVAAs; Tue, 24 Nov 2026 09:10:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3276E406A4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795511456;
	b=E3mNRiIj5c31Z4ZkKmdMUcMBeRruX4AQraUZ8jPBc9TEYZOLWZUBeN+EQLDBep9/LP/c
	 AoROHQ/az4R/zy6lW+GZKMfC/ke25eY9OXgkM2zIGk6eL2yGuMBtTb2JoaiOcKJWnApR1
	 9lJycxZvslwYQThoiTSAkKNW1T5Yp+SdOCXMgzYwCsqMMo+bTlHpZu3TIblH9rkYDp+dX
	 Icf6G6/R4QOHlwUFreHifFpwoatp8R36xjfFr/lSXuHoOKXHoEwOJBAc4m8gKXf48sWo+
	 0ttKZyYmXeHTDLxqWKogz/w+l2yuVI4AhAMVMOm83IWcfP9fFGrk7i4le5ENaHkQmCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795511456;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jLmoPyPN6xt5Tm1i4AfYeCvLtGb1OLWHdAOoiXUHocM=;
	b=C+jkJqwzHhBEEYLy3DPlPCpJ7yh2ALFujngPpzF4LTMICKIOOISUKk4dKOf4B4bZUOab
	 mDF4Hd42bdFkHo414XkL/mhatBfvK7PnnnsozVEgjizfYmEomti2pf8d1+buuwxgaIAOH
	 FGmA+yTp+t9RUKYLIxD6p332DXUTmFPpuYMHVpbWl1D5dzzOFpJt862h5fQvgVtTIh73f
	 J+hzdkm42B/npsuzkqzurCgmI1PAC7pqOoYeAKYrIwV3L1PHVYan28X0755ToxH8v364T
	 s5oEWF72UPQyp9d5hpcdjH4rLzN6DlCm4bVZks1blV1wNOsoSiWuhop6eUbtWOl/KWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795511456;
	bh=jLmoPyPN6xt5Tm1i4AfYeCvLtGb1OLWHdAOoiXUHocM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XuGnJuqdTkn96Dk4IeX7vtZ5eq7/6Bl2lgBaFNfrDPfIO7ON2ui1lOOuWDwdyRreg
	 oRgOzTz2pJeHVfBTFXOKl74s6/6U+DItuWMMyeveTcJOqjWtduZIJMp0dJKPH5YeAJ
	 bAQbeJJg2R3x6QpKkUYVTx4dUkP/zB3eUOp4t8jmOoNvZvsYrg4wz9vj6gM8ZylTTy
	 MPJgS4j2nbtt4C+ZbKaEE2nYNZgAkFDzJtJ35yhRCQcFid8EGR3jSL4S37O4jFHFlA
	 bhGJMY9fxELsV4+PtidPOy6yhCfErESLQKkjj+H0Z6Yn6KRCla86BennUyxMN+gXcU
	 MOxnkS7qjnUBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3276E406A4;
	Tue, 24 Nov 2026 09:10:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 122B2FBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 026B6607C3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1pDh4rkMg0E for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:10:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7489A60606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=l5C/R+dY
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7489A60606
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLmoPyPN6xt5Tm1i4AfYeCvLtGb1OLWHdAOoiXUHocM=;
 b=l5C/R+dYsSikf8FP5EXzv/B63YGJxgOiTtiyCrgqCxQ1057AG+367sg8ChStRZFekn15xJ1pbumVgjZhXu3cFkBCpY1j/z8v1Tl8TXklqYQhgycbyeRToxzKaQUWnqTfTR8QLrNObumEAkci4DnWRMmtcdUTt1Fe5gS/0VFpNYL8jLXiT7YRk77Pn934qhsHJ+GobuV+9qgVHHsg/RQIV3P4H7VqXc4ZeLdGvdmgCc+zk55MgiVB771aS3cpYiiKUiciku5LvS7ylzqZHzBlmJF9AidxsRK6d+RGfhNEEZqS1XKqdZsbmfh6wM26APcx6HMwLdoavT9E8ye0BhdeeQ==
Received: from AM9P192CA0016.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::21)
 by GVUPR10MB9750.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:362::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 09:10:46 +0000
Received: from AM1PEPF000C1AD5.eurprd02.prod.outlook.com
 (2603:10a6:20b:21d:cafe::8a) by AM9P192CA0016.outlook.office365.com
 (2603:10a6:20b:21d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 09:10:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM1PEPF000C1AD5.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:10:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 10:11:45 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 24 Nov
 2026 10:10:40 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 24 Nov 2026 10:10:16 +0100
Subject: [PATCH v2 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261124-usb-onboard-hub-v2-2-ec527e27994a@foss.st.com>
References: <20261124-usb-onboard-hub-v2-0-ec527e27994a@foss.st.com>
In-Reply-To: <20261124-usb-onboard-hub-v2-0-ec527e27994a@foss.st.com>
To: <u-boot@lists.u-boot-project.org>
CC: Marek Vasut <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Alexey Charkov <alchark@flipper.net>, Michal Simek <michal.simek@amd.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD5:EE_|GVUPR10MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7af209-8d75-4821-fe5f-08df4a0ad303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vDwTDb32gkqKFOXtwXoEq2zmUbaw8bHwP58IDAAZ/bZpncdTQr9EZ591xIxBPXKarmt9AHU3en39gX1S+0YzeBz9CNABiAtVrteW38CFOLYmMyKJLpMxAjs/UbZcvNJTHTVpr/5eu+BXW/F/IPAdu/F+tIV831asibHXYU5c0rBSUSRwrzDtVkIcmE73/X/Ore6LxrWyGzR4syWnSvHsLNhZldmS1Ku7Zq0khx1410JN2z+w85pPq3Fkl52q7xnE9Kp2uM2Uh8SJ/PJfalKLTmAqN8klEFd1AQ9IEaDAlkBotorjh5HnrXcNjqP8yOErEbABVi1gy/vtmqMPXZPJYo6IFvn9TqzjPUVe4Mj16h8nDwZ4zy//k1AmdViyHIZxgQ3da+bZUqWM075mA16XOyJyKNuZSVX1u5q/BiIhWEYFPD4Q+NsqRvlOd1zCwEJicFbzylKhnbinNS6HHKnbq5Sy7zpkWzUcXmcLt35mm5wJRImaMj6odCqykISpDxTwKxxNoMTAgU9OaJ+X+I3cQNn/Tjs/3uhc34bdSvuV4yPJ9qlF8mTNovqxqk/GDGas1yV4yHbXFOGNW3kISWWGHogZM64AtnlZfgVcprIDSu9mnAgk/Pcv06J5zsSLkIWs6Jqq5t0zoXgZUVHOP4bf0Q==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HeWcNdirLKeK5x2EUVtA8VgL48kU4x+91lWubI2UizrVBtQWjxr9v/uWvRo7tN3DFl7/kxVcklr6jINsKMDE0cDOyRdVjzzH8Sad2mNSSS2GyeoW316gF1LTVzFcaJHRSVvQoVfQ4k8aWxWM2gj+1X9x/auylbllhR0jlQKUwCx4HIVidl1YdB2Sh5PUr4nyvNxuEIE3FH1KRyWaZhs/wXciGdCVEjJQcRMjUDo6cJKFX9tVQXNr2FIb04j+ipPfvGQ5AzgjpBYcZv2KpwT6+zcKY/PL/8fRYMlrZN065qVv07dNzXzrEnDZ8hTlQTqrfHkF+UtejLZyYcTYRwjILW3Xl9WaFPt+/9h4sfJlCDbiaV9zzPTLOnsUO1V6XXiSTtTjMVJnGeZptN/+jW+ku+CPjLtA+dRcQy62Okhu2WkvaeDtLaTvDa7ZMrdW/1zc
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:10:45.9454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7af209-8d75-4821-fe5f-08df4a0ad303
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000C1AD5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9750
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

This hub is powered by digital and analog 3V3 power rails, so provide
the possibility to use different regulators for digital (vdd) and analog
(vdda) power rails. Both 'vdd' and 'vdda' supplies are defined as optional
in the dt-bindings. The driver also gets them as optional.
This is inspired by the Linux driver [1]

[1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Add a note in the commit message to clarify that supplies are optional
- Rebased on usb/main
---
 common/usb_onboard_hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 3807bfda61ae..b94101be8106 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
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

