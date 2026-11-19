Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2DE606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CLv5E/8A;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=S+I13X5C
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD44940ACC;
	Thu, 19 Nov 2026 13:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hen9nLV3wgFM; Thu, 19 Nov 2026 13:12:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 00A5640AA2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795093933;
	b=J9MLbP3e8/mOrbQx6P20mgP/O4JZKZbovLvZDsIZIMNBxvi+Dm7UrvJ3p5VHDtpIpcBT
	 cSlScrEMLrr9NJFki8t2ycuwLkTKHd3tCY7UABe5DlDzIUXnZnvLd7OwDd9GdvigWDxVO
	 RRDOSmRmcP7Xn59f63tiRRRiHCQsfYnZBrTJ5FqT3nAtyL4twbvU4b/mGX2stCXnIMmXq
	 ZJYS5v23h8rCpSVJIDCKCDcHv6ew9pEole4ix4wrUyDPA+Dxe1Oeoy8GKqpf84KNjqa0o
	 733yVqlTJGkdQYa/cYncG1WDC5BOyTeTYda1R1MK5rGO+MuWTXBIzLHileFQgypjzKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795093933;
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
	bh=ADcR/p4B92n7jjfW/awABt2JyEjhWA4dt9wJ84mFGAw=;
	b=sltGK7n+SBBrHWDRTj1sSNVHJs8DfEsvi7HKLwah1ws+Wqz5GhpNUskyXTL89E8iWSNC
	 hOybM8zHb9ArJ9jRqnmceh4ioWG1+g0fROj95sL6mpCwCZxBH/flBsBREnJw5x+jCdxSB
	 x0EBsr+oEMkGaC70Rcz4ZENwHRGVqAmKCEoaDBxM0nm37YAOXn4EfL0ZDg5jZtAwaqERq
	 CBC4ceI0zZx+Hu4AFCYm4TKZTLGPRd0HV5GhwZLvS4dIgLegLDTaq0PHfbn0+Fse2ejE8
	 sJb12KzbAfDJzPq94zMeSBLNz7UUM8o8eoMFpEfoqcANr/tW588qxftnowpXapbNoyg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795093933;
	bh=ADcR/p4B92n7jjfW/awABt2JyEjhWA4dt9wJ84mFGAw=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CLv5E/8A/dSIOQhUxlOuHD49jiyYe+KDsI16Sv+tFtD2uoX//3A6IvjHHGPpqFV07
	 iOAMPKBpC3AIs7DLrnahiQUJeOxsY/jOywFQUnwlF7T/WYsXc8fyud5dNDcJh8DeAs
	 btRA2jsxxTVfz0B5EECAElxAwMkPbxYYiZ0p7LeVykpoU1pqLoiKEFetolOl56VlnF
	 B2ujqirktLCzarouIpNz1dfGn8nG3l8hElHKjTZUPMI2cK7Q2g7RpyUpcnmMdkaAiE
	 Cm9ks9XMsMnmovoJ/K4VfAA+kfozpD+zepGu+WUPlJAA1chL0PvVcWk5lSqFYsP+v/
	 7OXZJgEwRmclg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00A5640AA2;
	Thu, 19 Nov 2026 13:12:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A76C70B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C52D4051C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C0X6dj4raxnz for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 10:59:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 50D234051B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=S+I13X5C
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50D234051B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADcR/p4B92n7jjfW/awABt2JyEjhWA4dt9wJ84mFGAw=;
 b=S+I13X5C3knza+WPhc1+jUvMHgYBAikRl45p0t1lqk8rlWvE+b4fzo4Hau4903W+OAgHcRY+ZXFJDynmOmwuC4m5Z/K2z6DvRr2ILh2+i0xCZD/sVKMGkP5YCNWlefuYecdEiKPOAxxU/fIiSt1gYftNfxEAN6lx9rn8PNmeIhnzLNRsC0w/ANKssQY8YbIZXdCkwpag5NA4tvoJifhTFTIBpnbyQoBCgS89si36UoSng7t04+7SvUFTSqGhO4aKCteCRmKb/5/yLM6Tsq7KUMHmA9qlCQY8I+LP6Z/ATNkQA3+Sr1fh83Y+xZoGZanZ+H66EvGHtwIwxmiGsNetqw==
Received: from AS4P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::8)
 by DB8PR10MB3845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Thu, 19 Nov
 2026 10:59:09 +0000
Received: from AM2PEPF00070CF8.eurprd02.prod.outlook.com
 (2603:10a6:20b:5db:cafe::45) by AS4P189CA0016.outlook.office365.com
 (2603:10a6:20b:5db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 10:59:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM2PEPF00070CF8.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 10:59:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 11:59:52 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 19 Nov
 2026 11:59:06 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 19 Nov 2026 11:58:59 +0100
Subject: [PATCH 1/2] usb: onboard-hub: add support for Microchip USB2422
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-usb-onboard-hub-v1-1-22aa6ef1d9c8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF8:EE_|DB8PR10MB3845:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7758a9-9ffa-43f1-6080-08df462c2308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pTejeedEVgvxK7hMdYyMjZhiCv+J0lgOs/SVD2n75HR6Xp5aLN514H3P/pNB41yZhlkI13hnBzpkZNJW9XuKjifnlrc7waRMNCVh6eBXXQGWZrBVd4829WIB51rkbanD+Q2cNSxHo8gMGKPCIQmEPxNh/9npTqsoUEwRP0xmDmeCx3oe9pPdXR8ZRh17sz6vKjnGIYRHNWwtabo71/d2gcj2SAZg6Ir027btzT82v/88M7q9ie72XgeLzTFSmR0Hwg0DzFQXesyyg2FXZX66PA8nqZN2C7rsw92TADSQYF2IvbWwCpUyYAtyCqt7C7xOKdbp+VOTO+TmTcKlpw6gemZEwHX/bJ9RAR3CmnF+vLb6HHFpTfC6YI2AxX4eregAIy4ePaBVwQqxvmNfc3vBuynOLIM86MOX0z7UM5QP/I1zBTjPjnjMrAqe2EXGAnthOiBL1tcPU5rzZCJ9mr++fmOi5K/dAw/L9lEDuvieiWCILZqL6LR+sMfwkSn1ksySa7Qea8yq9ySCzfAUcyu/lRCkzZdyQcDiGNrVsW0dkQ1JDeYiOgWxs1WJr23K+ZDGSnKPfbXgzJ60mFoLWoNHULm8wUvQiqxqRLN3c55OzGujo7u0y0MshOb1gUQ9B++J7RRsHbs6BvQLk7jKm6qy1A==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gRWkKIAkkIxuxTWt7CYe+QDL4g7ag3EykbFutHBs08lv/PspgLbvv79Qxkuw8LtJzG4jdvv3YqXeWukz80nHR6dowFVRwEK7LaagOP6vwq82dOcthJ9J4/FU3X6550tE5prP9lHcocvWv6+OlOKibv+NDyLpeWRINstE/qRHjfb/2kze66O9NniVr0UFRgxyu0+HODriJ5C6ysB/nDSCr02QczrBMkYsoihXWVQqtBCTuoLNkBIqiSp9xsPUt8At5JBA5nsTLpKKkz9BmEzqBMJUT7pnFEYHfHVva79kUnVt4xs66lDfXUdKdswqFKBji+rbdaiB00diyjDxtnTliUqPWLXAaiMRE0oTrL0PAL/DuPIiWKRCSVLkEvRqOmP3B19nm8k8yqwxYytlJqdETFnSAR+JNqk/r+15y3f8W2PHLkZ5UyDZP5LRp/YjDu89
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 10:59:08.9311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7758a9-9ffa-43f1-6080-08df462c2308
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF00070CF8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3845
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the Microchip USB2422 USB2.0 Hub. It provides two
downstream ports. It is supplied by a single 3v3 power source, and
provides a reset pin. So add the generic compatible, defined as
"usbVID,PID", and a specific data table that may be used by other parts.

It is similar to other HUBs, like the USB2412. So use similar name for
onboard_hub_data struct, e.g. usb424_data which is inspired by the
Linux driver [1].

[1] https://lore.kernel.org/r/20250213094338.1611389-3-catalin.popescu@leica-geosystems.com

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/common/usb_onboard_hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
index 0684f7bfd479..0c84c1fede03 100644
--- a/drivers/usb/common/usb_onboard_hub.c
+++ b/drivers/usb/common/usb_onboard_hub.c
@@ -268,6 +268,13 @@ static const struct onboard_hub_data corechips_sl6341_data = {
 	.supply_names = { "vdd1v1-supply", "vdd3v3-supply" },
 };
 
+static const struct onboard_hub_data usb424_data = {
+	.power_on_delay_us = 500,
+	.reset_us = 1,
+	.num_supplies = 1,
+	.supply_names = { "vdd-supply" },
+};
+
 static const struct onboard_hub_data usb2514_data = {
 	.power_on_delay_us = 500,
 	.reset_us = 1,
@@ -296,6 +303,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
 	}, {
 		.compatible = "usb3431,6341",	/* Corechips SL6341 USB 3.0 */
 		.data = (ulong)&corechips_sl6341_data,
+	}, {
+		.compatible = "usb424,2422",	/* USB2422 USB 2.0 */
+		.data = (ulong)&usb424_data,
 	}, {
 		.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
 		.data = (ulong)&usb2514_data,

-- 
2.43.0

