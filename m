Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29332CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 23:48:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCC2E80C0B;
	Mon, 12 Oct 2026 23:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8buqxt6Ow3jh; Mon, 12 Oct 2026 23:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6CD880BE5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791848897;
	b=rrFlws4Lmnjjc4/OhQtYhIhvxzM4lK3UqeNbs5dQrTAYyr0naUy+ZKlJApx0Azn7KIxu
	 p4zT1MaxnYsiCqRwb3wnftmQmAWjP0jQ7dCgnDRsOjwGcAELzT0EGj+RCPTm38XUC2t9x
	 KmFA+DxzdPInjV4KX+gUXbnGO/zvEdnA0zOyVgrc28n6/2rue6ZjvxGmpnyk6SzcQLgxQ
	 rRahhlQtVM7W3QQaIWLZ6dV4X116MEyOeGGwUpd+Tda/Dsh19rRCmJfHDbHuFqFU3qLHk
	 9g1NhJTurFgGToVCq83HHxaYVed8NHLxeab4N/f46mF8w9wU6kHCEYy4sFgY6+HhLrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791848897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2k/11lW5dTf3OjtXY4cAO8UmGnza2rh9YZlZrnzg8oM=;
	b=sgr5yhUDj0g97EdcvIzFN75YJGoTy5ULCp0Yq7875Zuv7O9rvOl7iIUPH7RybellWJdI
	 VNclidImLGnTe9crLLg0kX2je3OZYY57+yeoZ7YqzymomjUTOenFuQ2w9soZ6fKogbYwS
	 61O1qzy3rVyqkNrMEHDWDasnwRrP2UKzUankkoHaA/oe1Zmf1Qfn4BOXtYdcOBDr2FiWN
	 RL8tzojMeoGVuIfufY0kkWRHRXRmmrmhplIGNq658A+TLttLz2hRuSH4gQ6ViUxpo7oOE
	 AO36FTMvRrPQjLJ2786nU89xv2s5ALCw+KJ5DqOXQxJaWIkho118i0ScSZE1AAYmXYg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791848896;
	bh=2k/11lW5dTf3OjtXY4cAO8UmGnza2rh9YZlZrnzg8oM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HIoneMj4/9Bj4aj8GfAP1/9WF+JdPpWKqyyjiQToAfgOzmIw/iqZEj+VV9NlXY+j0
	 yCWGqLF5pY8YqYHCSiztVFscalApT1fEebM9mgzuSX246eqlvKoFG40HJm6rf4p3WK
	 BSltLU1dLZsfd/0k8gG1IpnLvRM8lQdt6gR81Q+Wp5YRr62ajgQ5J8n4/y+tjPUCI4
	 Tvh9rQtXOX5GBitrAYue4Ll0Dzb5chV218UCylGUjCCnIugpodLKQh/Csea5bl7ChN
	 +1KOSiih66+sd9335ykW3uiYfI9vYArlCb/IfqqUzExUuc4wu3MpFFaEyGpTgLZefP
	 TZ9H8+Pgt1rsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6CD880BE5;
	Mon, 12 Oct 2026 23:48:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B48572A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A81B4010F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:48:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rLW1-M42Nkl8 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 23:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8C0C44004A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791848894;
 b=C7yRztt3vj/9O2RyHUD1ZI/u7ytPKt0AjC3m8MEaCnT4/yt7rJUkofhHDz3115pZIJff
 zoPcDjyKl8BUj+dHmHOqWCmfWCy+ep543cq1HryMUvoDK6i+Av2cb3OiPozb6WQANwARt
 1hoTbpez2bJ4mBRtFkJsUY7ClaJDTo+bX6twVzdvFMEcsb1U4QjX8tjxTFhZnzNPUgBwL
 PYmogj9Jb5Ks3uCytTfr4NTNifqwELerhze6IGeC4qNDQzjqad5jDSd2gsuvaQGZv24Gw
 rUws/q9w8sNiWVJGwJO/E7XPmJmN9IbavDkoK7KFo6fMKPZ6azYHAKbPQtzAFkfbFnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791848894;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:CC:X-Mailer:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=2k/11lW5dTf3OjtXY4cAO8UmGnza2rh9YZlZrnzg8oM=;
 b=WZEviwxGy4/2m8bv8kxhhKlTLLZX5mbmN/HICwTRkNJ84eMGoxKY8bFG04zKLOgAArpe
 aasEvpptzwZ7td0boRx8iPV0dVFiOkkA4/oYqG4r48Mw4KOitGIQBg5u+JR/cKGfDnM4n
 ReMTAPz5fbCYD+fIhO+31aeGY0ILM4KMjkzM8IgA2uwCbQABgtHi8chgbEtOUwHRFbioq
 SY5CXOccEIXrlamQZdfbBhFOEPjcOviSij7bKl0oQjaffzoJOGlS7na9f4X1ZI2ewA6WD
 pwmCWI5VTuRNqNQjLA5kGcY+50WD8dH8wI6Ll3U8pwGTMDChiMHFQmTwr3uM5n9DCHQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=hOZppeHI; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b="e/5OJlL1"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hOZppeHI; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=e/5OJlL1
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C0C44004A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:48:14 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69CKKNAP2420412;
 Mon, 12 Oct 2026 18:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=2k/11lW5dTf3OjtXY4cAO8UmGnza2rh9YZlZrnzg8
 oM=; b=hOZppeHImd/bTxPfTU39BMy9zDwEJg44ldMjvJVKnwz1LpyCfOurJPJXP
 3lOz7sStd0SiAN5ZJw5GqflFVkk1LLOtyduRgWkdl6sg9T4S9jH8Bh64dV85qwm7
 rFYTUAiFCP9pV01/PnMmYIZ+NaOZfOh68CSk2xoQohd4gBSFlqf5gi+wKVCwcrbM
 qxJez9LBCE3gB36FqZ3uznctlUdH/jv700nP6ZeDSDtNoQr3rqO2mp4F1UfmlD43
 A3ps3UzKffS8VMnIKkq+DMnGETmoZd2C45OIvuAruf6QhxVRhUUgQcMG7qlhIVJM
 O8x1kPO+51aZvjgF7K9DYM80U1VtQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by m0384305.ppops.net (PPS) with ESMTPS id 4h87an9m5x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 18:48:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKyWii7JxLr0FdB5x0qqdeSdEOYLcdHqCVTqc9vRh3S9YIa9V/Nwc3jucWgD/dqKvAUQMjTfe9+waq6Iwhzi80+QKkgUd/Q9xgOh8lZ6A8tXJQHcbm8aePZHrA86oHNyjf+e+qUmnstWep8Wpc24zXrRTYvAXoAc0pwjiEIxksijphXXW0FR3GFQDCirqH/VO3Ixjz9lherTttfTT+2y3gfW6F1jLxa7wBL9N5LYYBSrdjkgbGqr41C8rP4RL7XJfFqAVaeKzWYCiCs/77PhXS2f4lFH6jpBEFmMGdnel7RucYQmqVmtb8cLk4rOR5Rp+j33Wb0/8uspnKNtyzSeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k/11lW5dTf3OjtXY4cAO8UmGnza2rh9YZlZrnzg8oM=;
 b=p5du7nTrDbqqvENlgafbcxc4N/f++BX2JUmeiAINpT6dTXjRAUifztaN2aQEVmIhrTCSS6XjwlZanttHuiPKeUNe4lVNka0GEFkJN8ZmfUMj5Uv81++/r5bZtZdpoWrt0BR2QxzRziYTbzabcRrqf0IyG/nmQuMno66xLWMidQccjzSJ8VmYxlD4rzJsJYeMblJPKxwyN7EkRSCfoG0pVBP0WpQoh+E75EyqvUVk4VohWiTvWltMkkrjGau3zUJg7b2MDWPAPgDhrxoe69iYf208u2NPL5oOPBb+m7sLZtGfYv47DlyR0SxC60BZR+FtBDVTNKOFZgpqjwQuqYbnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k/11lW5dTf3OjtXY4cAO8UmGnza2rh9YZlZrnzg8oM=;
 b=e/5OJlL102arj9lRPvZpa5voLykpGHr4LeM8sUQDZB4MSCm9ysdlrOrF3TpHsUKweiBEGhXcoizjofg55fzdBvu9apSVokzZh8bPrRa+C6+fGau63IYV8rJr5p5dX3EfclXax1K9z2ZtYPb1HcPsPKs09vA0gN0sF3WBPLFJ1lA=
Received: from BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34)
 by DM6PR10MB4185.namprd10.prod.outlook.com (2603:10b6:5:217::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Mon, 12 Oct
 2026 23:48:08 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:208:91:cafe::67) by BL0PR05CA0024.outlook.office365.com
 (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Mon,
 12 Oct 2026 23:48:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 23:48:07 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 12 Oct
 2026 18:47:12 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 12 Oct
 2026 18:47:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 12 Oct 2026 18:47:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.75.137])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69CNlCLb3331276;
 Mon, 12 Oct 2026 18:47:12 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Mon, 12 Oct 2026 18:47:04 -0500
Subject: [PATCH 2/2] arm: mach-k3: am64: remove dt nodes not backed by hardware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-cutdowns-v1-2-ce9e745eb857@ti.com>
References: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
In-Reply-To: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|DM6PR10MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 643b17e0-3e35-43ce-ffc6-08df28bb4405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|261009223027099003|10067099003|22082099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: PVr76AnKOwQ+tjS3oSdQuVRC4Fw4KkSGaynJYi7YncM41/Jklsdv6qg+4rNDLxQPb0VMVh9I1QX4a2AueC11pbMTq/wHnRGLQ4EsdlFebsed8rCMYiAJEf/cpexE2qIK/GKcl5fVNKDnORSY1MaMRMwufwkGkErI9rRHyelSKtg4u1NoYJRZo56JVqP5SGANBG9RKL8yzbQ0CRMa07rv7fp/K8Qz2kowxQee+eNjYmCvLqfF6HRPfFrulvZRQ0hT9UUdzsz+zRK97iufc7HdvFe7PXnCPb81ExjbxKUi9lqztQkQxd0rhc3npoohLblLJIZPHwQY9lf/m7NOUOofUPxXt7IgIDs0scMZPVVUYdpUxcwRxJIKZEO1Ldo72Vi51PwTKDKN9BE0ib4tXqrYp8VxM+dYytn/DQxenZEMHAtTo0hbo02LuQR5FGo2UdfTYBmjStj5tKg0CcnO9tWH1YKaAFDRo86oI0wcl0dPsfPnI7onlRjlQh4N3UI5FcOJ/fMf5jpmvGIfxa28kkf0v1fMhpOcPlcfkPEv0WBwZSbPMl8QlZjc5LmhE05TO43vcaUXbW/aKzzYbSvqY6JnRjRGVgRKGpbAgLv/NWOtU6cb3xJ010KkQcQ2IFHzSy2jtPU9EXC/9dAKJyNnsG6Wjg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e6MiADRdy8U7C7sGpoXmSLIhNnDF980rQg1F2nu6K7lQ/iZq0hjMc5WsNH1zKG7tiB/ySEMlsbyjIBWPZUWP4QRnKVToBfAzPJtjWpp5eYgU3155ZcLi/DpBhYFFIF/mX+1MWNPwq28UC9yGmtyudQuUAoY2LP6rJ1X6QXlyrMSt/n7qqc5y9qK99jYYTR72MiTy9MEPvEpE+JQwLk7eLTgVVq4Qh/QATL2rkMO/Kqmocwch4LbeWLd4HJ0UZyAan2qk1tW7/IO3pd+0nmXgQwEGvPHNCVBXAe8g/nAV16FiiDaoivgBSFqoFKIrOuS390xHyHY874kceA7QnS1nw9nzCqi6EPXWEUclV3m/e9UXpMpYHVw/UB+SKMszAklh7teXnxaRW8NhkzKbBU9oofwzpPodZfjAcX1GHv9AbWHNUak6hRijX7mlj7Z9ULUH
X-Exchange-RoutingPolicyChecked: 01v0mqodfUqBYDCxI4KqfpujIDMPH1O4CMfILHMAC3DgeHp5oHcSwogumkjUDluxn2Pk5st3m7X4pOwwERZ2gI5/Z3LSe3s0vizV3FTVaIAZc0t8cEoDx8oP79kGd8j9FJBIbIiJ/d9PmTtiYFoFQvmiQRwg1wDM9CukUUmZnR2AfUxLOORe/oJ/cFZtErUtpQdjmOX+MONEgsvvtaoL9gvCWPBupacA52RYKvYZ5N2ST3KpYMpI7kr7gKzAYoJNi2aCjSZFbXaxH2L9e8JCBFv8ymeCc1qmXbLJR/ax0fKm/rfF9sM5dnnnIWhB8J9L8UlLCsaixMmrnOvE1L4ByQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:48:07.3870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 643b17e0-3e35-43ce-ffc6-08df28bb4405
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4185
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NCBTYWx0ZWRfXxcQ2LZm1VSOc
 viVnjtTdG3WrR08ajdud3GU9Oc+7FSfedneap6vUY8I8nxReYol1KIYWi9L19+N4ysVNBNefTIr
 kTsG/ogzidEZdZU9Jdsu63GOFSZ4/PA=
X-Authority-Analysis: v=2.4 cv=bPWDs/+Z c=1 sm=1 tr=0 ts=6acd71bb cx=c_pps
 a=Uzy17SEabGn9o4QNHCkmvA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=twm4ZAnIgZo-ZPDnHFoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ter7OmNHrRJ8ieL4V7R8dXj7yq3Y1FQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NCBTYWx0ZWRfX+bazGlh1E28F
 oAWXjaeSGPz2ID6KTI707G2CrjS72fvpo+LEdnGOw0YjLpbRctZ8yHyxx9H7UrMYILHDp6o8mFC
 H/jzywlhAI0/SUISKsdJdEFaCObTg+aklRZqBGBqdj9lxNz/FpEph6nKB9J1vseNtZTHNMDgdMc
 5pqJoJvyny7asbMe1IEEXuoTUkB5LviGGtDmPP+jk3kvsI38KOnyqAGoGonUo/++Kr3ERlpEUAG
 JPhlF3QSdfwBZPAFLIk2UL3jJqz0hhuG6OVa6iW4n44eMV/Qa00s4+cxVVyE0+ww2MVbMkL4qI2
 PJrmkgcFOBK39TY5nQjl03CvO4+5u91aAjeBFSx7pUvnNA9/UQf5mLcAzAyb2K1JjEgWQni62I3
 NPapBda3vCEzNs4/DAuy7XZoCZd1dUgWWsZFS7YSu8ze8mlRwI8dMq9kzSd/7bFGutL4y7fjiYm
 +MpYNOZOkn6I1V3InVA==
X-Proofpoint-ORIG-GUID: ter7OmNHrRJ8ieL4V7R8dXj7yq3Y1FQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120094
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

Some version of the AM64 processors have reduced CPU counts. To avoid
boot stalls while Linux tries to probe these missing CPUs use the
DEVICE_ID field in the JTAG_USER_ID register to know if we need to
remove these CPUs from the DT before booting into Linux.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/am64x/Kconfig                |  1 +
 arch/arm/mach-k3/am64x/Makefile               |  1 +
 arch/arm/mach-k3/am64x/am642_fdt.c            | 36 +++++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am64_hardware.h |  9 +++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/arm/mach-k3/am64x/Kconfig b/arch/arm/mach-k3/am64x/Kconfig
index e8b7d54d7ac3..026a9403fcf9 100644
--- a/arch/arm/mach-k3/am64x/Kconfig
+++ b/arch/arm/mach-k3/am64x/Kconfig
@@ -16,6 +16,7 @@ config TARGET_AM642_A53_EVM
 	imply BOARD
 	imply SPL_BOARD
 	imply TI_I2C_BOARD_DETECT
+	imply OF_SYSTEM_SETUP
 
 config TARGET_AM642_R5_EVM
 	bool "TI K3 based AM642 EVM running on R5"
diff --git a/arch/arm/mach-k3/am64x/Makefile b/arch/arm/mach-k3/am64x/Makefile
index 053a82399993..9ef6d9bee098 100644
--- a/arch/arm/mach-k3/am64x/Makefile
+++ b/arch/arm/mach-k3/am64x/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier:	GPL-2.0+
 
+obj-$(CONFIG_OF_SYSTEM_SETUP) += am642_fdt.o
 obj-$(CONFIG_XPL_BUILD) += am642_init.o
 obj-y += boot.o
diff --git a/arch/arm/mach-k3/am64x/am642_fdt.c b/arch/arm/mach-k3/am64x/am642_fdt.c
new file mode 100644
index 000000000000..a8e6c946d584
--- /dev/null
+++ b/arch/arm/mach-k3/am64x/am642_fdt.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <asm/arch/k3-common-fdt.h>
+#include <asm/hardware.h>
+#include <fdt_support.h>
+
+static int fdt_fixup_a53_nodes(void *dt)
+{
+	int nr = k3_get_core_nr();
+	char path[32];
+
+	/* remove the fused out cpus */
+	for (; nr < 2; nr++) {
+		snprintf(path, sizeof(path), "/cpus/cpu@%d", nr);
+		fdt_del_node_path(dt, path);
+
+		/* remove the cpu from the cluster */
+		snprintf(path, sizeof(path), "/cpus/cpu-map/cluster0/core%d", nr);
+		fdt_del_node_path(dt, path);
+
+		/* remove the watchdog for the cpu */
+		snprintf(path, sizeof(path), "/bus@f0000/watchdog@e0%d0000", nr);
+		fdt_del_node_path(dt, path);
+	}
+
+	return 0;
+}
+
+int ft_system_setup(void *blob, struct bd_info *bd)
+{
+	fdt_fixup_a53_nodes(blob);
+	return fdt_fixup_reserved(blob);
+}
diff --git a/arch/arm/mach-k3/include/mach/am64_hardware.h b/arch/arm/mach-k3/include/mach/am64_hardware.h
index 7e33617151e1..53c05f44fbe9 100644
--- a/arch/arm/mach-k3/include/mach/am64_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am64_hardware.h
@@ -19,6 +19,8 @@
 #define CTRL_MMR0_BASE					0x43000000
 
 #define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_CORE_NR_MASK			GENMASK(23, 22)
+#define JTAG_DEV_CORE_NR_SHIFT			22
 #define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
 #define JTAG_DEV_SPEED_SHIFT			6
 
@@ -89,3 +91,10 @@ static const u32 put_core_ids[] = {
 };
 
 #endif /* __ASM_ARCH_DRA8_HARDWARE_H */
+
+static inline int k3_get_core_nr(void)
+{
+	u32 devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	return (devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
+}

-- 
2.55.0

