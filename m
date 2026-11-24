Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3010606A322
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aoKKmcRt;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SugUPJ3M
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5120F607DA;
	Tue, 24 Nov 2026 09:10:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jv34G7J21dYG; Tue, 24 Nov 2026 09:10:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 631C860606
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795511451;
	b=enHaP3oSslxX6EYqEs4fvFgHUq1xO8RF6WzUxl/cHMfSdmh0pyvb3oSF80WMoGPmZMxR
	 eG+oKL3Bb3eOd+gBpMqms4SJZQg4YO0xvtZsmqsmxHbkmmKIP7VJafYvE3XaxG8PHszZN
	 95qZMPR5YxKyA7Ju2kgtAtaCHg4O2AkPoFzuxY6wolE88MU4/vOrYxyxUaM/kuEiWUThE
	 DPBWFQCxHTvymlP3ISLivRzIR+vO21Hq4ozuXnlQ/aZ2ex6V5nIJ8UFV1wL7UcymhJztb
	 42u811RkM8IAB72kqvujeBIPBMGtfaiUebX598KYmIB//AggEE9A1Lh5T5Aq9Kc4mTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795511451;
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
	bh=nYjdyd22cx27QZjKO7R+oi3TyaBh2EcBchjSLRPZljI=;
	b=NKBbRdrv4yc5vP9Qr1tH1JojROjScFvwSePiClJEuL28YJV9J5ykY6NWVqoICPyOLhdW
	 8foNibBKBnPKpcHFqopDE0W5gq6XKaQW1guPxVXPVEBL9VP04IMafgjcfaHjUYpqArOei
	 DBOE5zbzNbZyTAtDiBACE47AA/Uln/w/6XkaTFOtcIFe6LLRvlzHPDs1z42pgLZYzTovu
	 2Hps0KBgGHpxg3PR7iSXfRpKmlTy3n4zDvW1SjV3rP/tcDko8Y40UNVumBtwz/3qVrhCZ
	 voZJRYvRbMTykwWlO3coOjAOC562I1tnMWhGOxPAxJDf4FrSzzEtpnJ9GTV844FF+2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SugUPJ3M;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795511451;
	bh=nYjdyd22cx27QZjKO7R+oi3TyaBh2EcBchjSLRPZljI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoKKmcRtjY5tYpI58Rxd9Vn5SikOaLmImyG4Y6GPl2JMsvi5O1bP5//4tmtX5RPwc
	 oQz9y7ozMLwIesaiA54Ob3/mkKqPqCNG/tPU09ifAOaQbrqrhGpWtb8Npofykttr4K
	 qwxUiVWAhco9BpgOm0IhZQtlrnzf3IVa1Qq1kOVrx0YLzFHNL8UC11OmjPeTSc/U/D
	 3nkc6/s1l/NGgvq6Ml+Y3wkAEA5FkdBu2iHX+03+Hpm5Aj6CY0BZ9/+KZl1HzJWFs3
	 p8TG5fWMEA4m3x0WXdQzfX0x2Nlxk6e3SAKtJAFp/Cm7QYLzOZQDM7qQRX0zpSvYoY
	 4SHG9le9CXKuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 631C860606;
	Tue, 24 Nov 2026 09:10:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E309D715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3E2160606
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V4GczOQV-o3G for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:10:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E234605E8
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
 header.s=selector2 header.b=SugUPJ3M
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E234605E8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYjdyd22cx27QZjKO7R+oi3TyaBh2EcBchjSLRPZljI=;
 b=SugUPJ3Mv5jN4om84KHBFUj6rr3GXabrwKgg+QuYQ6h3EEfZNju6fmOJ06JDVdUgUVpLxMI5ULtwGEkrHom3iGvmRtjtq4Y2LiqA+gQHziujiflGZE64qEiRjuJ9Jq1cphlN7JU4HPr1XwvFHOI2rcsCCEqU28916BrS24YbK29+H5hXdUWDIYzJZ5HxRjPUuiXBZraLT3Hg2uTQvAX0NwfG1EFfMU2rim/ldfcJLI2C0LnPR+cSX4KV29zKr5NiEoEeXIWxN/iNaezUr9qKbHqX9wsPSsX6Z9LLQd3lY0uazVdddqycMiI+LolhTUL89ZIVbtCdBaS5cR0K7tcqhA==
Received: from DU2PR04CA0304.eurprd04.prod.outlook.com (2603:10a6:10:2b5::9)
 by MI9PR10MB098474.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 09:10:42 +0000
Received: from MA3PEPF00000407.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5:cafe::45) by DU2PR04CA0304.outlook.office365.com
 (2603:10a6:10:2b5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 09:10:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MA3PEPF00000407.mail.protection.outlook.com (10.167.241.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 09:10:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 10:11:28 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 24 Nov
 2026 10:10:39 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 24 Nov 2026 10:10:15 +0100
Subject: [PATCH v2 1/2] usb: onboard-hub: add support for Microchip USB2422
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261124-usb-onboard-hub-v2-1-ec527e27994a@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MA3PEPF00000407:EE_|MI9PR10MB098474:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c572ee8-217a-4c25-b7cd-08df4a0ad07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|261028144727099003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261009223027099003|261026140227099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Uz5UWZPqfn0bh+5dLOzn0UK2C6V/IMfQWa4sDACK+tYizVimA8B9Bih2tf1fxP3KL0gSYeSyGWB9IKLE3eWYVszrgogCXf3Fbz57lcOeS2siCelStQzX2ERTKt0L0RzHHQcFW0ZrKVf9AHIA5bC1afXO4oNX1zwHk2AcsYNX7qqpBdOfvzuoDl1FZ4F0BfHbdh0ueACxmF4xbzeOVKElVUAkcsVf/VazxhRARgB7xHhtTwTRypAa4sJugV2DN7ILI6NGhA7GO10cnhvFraGcUsqF5atSM5Nzda3X2sADKZ6T20I88LcTjXL+j9u99WYpJJEMh468v/bFMpA+U4/FwZ4zRg6n3pxmVXrjxSGT585GSMUYlQGNnUA6LU/fafb6VYpW9dM7xbamJM0BXdYnl7i2xwlAd9y+tTCf0O89+aoQCj+AXbz1KpCzpIZ36BPLJplYwgIeJcNfXbox2sKXFcLOKvM/Ttx8HSmMd2FM1lbWQjy1vIPBPJVY8PvuqUSFb0IvVIpU7b7zQDaiGYGUVOERtxMHBONddIFFUbxwFA7KSEX2q34Dklq0h4uChuabsJ2AyQtOirspZ+0EEPOOaz7vUabhLXnajbe6BQ9PZY0G16y1CVoJltwHaLlCLm3zH/mPSjg6HE91VG+KJKtstQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(261028144727099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261009223027099003)(261026140227099003)(261102123227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RmnR8h5xcDJoRdv6jEcEn4h1E4Cg3mUGEa+UeUfdfuwrJxa43qfjE1WKDX0SQpI7klPmk4DYoK8fDBNzRmHrJoYDMz93ijHwdDyfPGt1MUaCpB2RnBHwm5/J2Syr8CPxV9DFv2lB6PQPy0JPi76AHXOFhq+PXkwLdOkEdghSc4/RmikKsrwCzZRRfzZ6QoOb5bg7MGp4AyNrFrfusarKikBG2XSP4HfNtM9jIks5Zs6rYPEFVlxi9kIWSsTok/Sy9mtzIulIyiFrqBynhMufy+TvfKZ4kq0GAv///sAjhLROQ+KSpX6L/P0cc9fxOtpwT5D5m1coVlD0zP3edHfMQgrZod/AWKBGK2u3AhhQn85wfcYKe8cpWzKL4Gwm/f3yfTt8gC8uvUvjBiXptEYG04uZF67iA2AwzHC6ksCXlHw56HVErVdyfepc7F+8096h
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:10:41.6634 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c572ee8-217a-4c25-b7cd-08df4a0ad07b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB098474
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
Changes in v2:
- Rebased on usb/main
---
 common/usb_onboard_hub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 0ed70a6ba34f..3807bfda61ae 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
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
@@ -308,6 +315,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
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

