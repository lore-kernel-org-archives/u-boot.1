Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8024CA5FA5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 04:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C88860803;
	Thu,  1 Oct 2026 04:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O9Gq3eNJQ-gP; Thu,  1 Oct 2026 04:11:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC60560B65
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790827902;
	b=Kqda9lTNQs0toQyplC2RUfL0VbMfcz35miN/yQjrjEoshGIBXpozlLP15AJTSH6LAAdI
	 8Qxiv6flbtFpprWTVxrvMmeVJTtE1DGAK82gV4O4GKBpitPHqeIpYhHm8NQeXsJWRXeEA
	 r/YOqh7eJTPFJOY3lQ+YKsYKR/G4yxCVjjui/dveS0xqmwdYsjcmhfiIzQTgtyIRQtqEl
	 WCdSpA0sbriFt+x8LrfbKADG8BflU5VPNXgKWLym0aV89W22LprRfgjMQeDyP65cPA6E+
	 xe3U13hC+XUt0tW99V9QHggZvskdZz4IeLlXvuc3N/QVkZpvIcuUZGslTUn7KfurRoQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790827902;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VePUgyy0yhWa95jU8I/jFxB2Of2PFbqcFVdlexQ+4W8=;
	b=SrcjeicKUDXh9c89P+V+6CHmEctJM2i8qVwy3mnOY5ilq7kHWlmsgN8iRaS2I8SosDDj
	 sxgZhXG8lOA75UWrdBUrKHSZTe1a7ev0YWGbipoxxS7OMc4gYw6J3vDWDEiuhlYk3aOX7
	 x8e0hB96di6+tKquJNIFh2os5uQLswVv1Ia1/fV0s142SdZadeap4n7w9EnDxDj7DW3Nh
	 9ldOOTtSCi3K6P5y/8jx4wwjScZ9McU2Bb8hKCtqB1MDkxIrENnWSuO5+leE4LodEu4Qa
	 ZRawZLFLQzqYaoqHWuK5xD2vYHXcAzA21HJjCrMVDyztk0F3kjMG8wr0Qw/09kwrfqQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3qAd2IJX;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790827902;
	bh=VePUgyy0yhWa95jU8I/jFxB2Of2PFbqcFVdlexQ+4W8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i1oEOMh1iVRXdwclqueKvO6cHmZhghWYBobgwGGMFVFRQOsmX1LQhh5ZRG87CjIg7
	 9Ww7418Gx0lTc0iiIRLKyrVFL4uwF3ej/jLEE3fuaUEILHN+CzT5vfBH87rGr/Wj4q
	 LNxP2Klps/qyHFfEWgEfYfICVi77c25EWzUFmoErMzbRxjlerMKQKyaM9zqejL0fVB
	 pBby1aODSOz0qQRIVmw/udB4LHvSU/ox7OSnnY0sqEKMx8HRSKcOeQ6N766S/QkjYH
	 c906/xO1i2wbdQd+svMGIAvets+P/Dg+CozegDJfFAhEyUnXZEdNBQMWn3q4j5kMXk
	 mSq0tXcT4t8JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC60560B65;
	Thu,  1 Oct 2026 04:11:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AAF9033B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 04:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C78760B65
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 04:11:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0NF9SK0uppBR for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 04:11:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 040BA60803
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790827900;
 b=YcWqa4vQCghSswpSDnvsV8C87qcYeroS88z4xFePGSSRw+dQT2LH++0WiCfMWgk5jFK4
 hxO8H41lQS6oVwCwjIbmlFa4wSQV4lNpEqsSVw4w1s5hdtipr9z0p/C3+PVIL3EK88fOv
 fsQPd3xb7EirCyDEtJMLzTREGAMWKmi+eqO02ENNDV5zhHbYHTx3GLdqJmX11R8dlaBIy
 RX/OrnSwYVEg60EgeVMhXAgKRrLYQkuf458XP+ONPJoHK8vfUz/84aqaOXDxFo28tMLnj
 NzOt5rik8eu5MiFwW65KBHk/4jQ7EK6f8usSrZ5D1gdiUmrP+2F0piBjtfL7EqevqSA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790827900;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=VePUgyy0yhWa95jU8I/jFxB2Of2PFbqcFVdlexQ+4W8=;
 b=Eto3mVA69hCgRB2Ve2BSlItANKenxEF0zbMeqBUPf3uFTDKXS8HMXlvD6JrqEqPZJjPl
 L4S91oZQya+GyozJrLHiAuJmyk9IpxF5Yqkc+0ToG7wk6sB+Mt6dL1XYFVq0FVKzLl5c0
 sOCHRQIUpPmZ34eNOYaL69BpxNANSzPrfDLifFXe/l8ltkDN62AZgjymzJz2aFzKpFBJo
 P5rNTEtzB3UsV3xrfzP2jP3S2xJuMhX9I+SjVQA0oDi0HLoHeZkFPlp5+tarxLGyUcFvx
 L4CpHThgujdaMewgINdSyyOBjyOzJWlfPsTLRfXZ4OMGGeJqUrKqdQ82+DSFKlFht/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3qAd2IJX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3qAd2IJX
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 040BA60803
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 04:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kx1eyMN3FIHWMc7wkSrZ0EHZSiPK0+iSjbo1cp2y7UcJAs0NYndHpNcmAy7Q8wp9FyCtwS6SFX3dFEFUJvyCFAioj9Eqre2joG2XFYai7yXpu5fVWsfeMc7o595kTQYXDWFompkDcWgYuHhbmTkFHovirU59PK38QLJiw0qXb9GjWjSpHyVzTCBMGSqBjm3fzAzqqOzjINh2Ow5fjDxFBum1OT8jGGndqHEc1W0jF+HZK5eU8eJGHngRjEi49VVZNiwA9Oim1wXet6tllBj9OmDF51ybPDKjvGld+Epj76NhvRV4wsm4t1QaAo7NHjazH+rka687pjyfjb11EB5veQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VePUgyy0yhWa95jU8I/jFxB2Of2PFbqcFVdlexQ+4W8=;
 b=G9Wh2XE3x30Ak0X91m7Bj3KIKJz5akIzwfpAv58EJqGsNL1g6Y5n0h398RQFCUXZKfc0dWoCdEOOD2fv7kbMZsbwXeMroFukLrbIUAtViExlgy3XRAy7G1aJpIR0lWn1lrbQR56vf4S4GNxrG5kIxgPuStgFiDFw1rLMQ4hGlQt+8L04Fsvg/Rbj5+H2nKMMIyt4BWCacsbKOVM0jV6ncE44mpXY1OQKw4AxVQWUMsXzkmRXadWuCuAspu/7/xRKPu13+d6B+9xmSemToMz1bEn7EeAhDvEfI2HeemqXkK5n2OIPLXRmWMQJCrLo+DGAK5O9MEbPDT1y5atepWEirA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VePUgyy0yhWa95jU8I/jFxB2Of2PFbqcFVdlexQ+4W8=;
 b=3qAd2IJX7IZDrbCf+ArMox6MNhShGHg7xpITBjmoe7ppibTUQ04wNAQFFNTtSf0rE1VED8IhZrLPD15lFnsk8QrJg0bWPOf/aehYCqUrkosFqVRuPFhX0Ytefbu2Yctfw+HNP7V5fLyitF+ms9ZHTugueAkvy16lr5XkftrMiBI=
Received: from BN9PR03CA0696.namprd03.prod.outlook.com (2603:10b6:408:ef::11)
 by PH9PR12MB174847.namprd12.prod.outlook.com (2603:10b6:510:415::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 04:11:29 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:ef:cafe::9e) by BN9PR03CA0696.outlook.office365.com
 (2603:10b6:408:ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Thu, 1
 Oct 2026 04:11:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 04:11:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:11:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 23:04:22 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 23:04:20 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Francois
 Berder" <fberder@outlook.fr>, Jerome Forissier <jerome.forissier@arm.com>,
 Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH] boot: pxe_utils: Fix buffer overflow in pxe_label.num
Date: Thu, 1 Oct 2026 09:29:57 +0530
Message-ID: <20261001040012.3491713-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|PH9PR12MB174847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e78bbd9-b787-495f-37a5-08df1f721150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|32650700020|82310400026|376014|36860700016|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ykf0ct0a3ZGuW5kFj4VWjXDeZBtom7TLcoK1N6xalp8/7FLEb4w5yHcmlKLhajST3PeD4mbhk0UGtPlb+roroYJLgTTfKwhzHCgADNDxYaFZIt3xWNRWyTst3x0stox8mlgw7SAP5kCkeT3GCUiZi0qmZWuPr+6qOqehhA8fEGg/nP5/aQsUufN8xjHREpiSHIdbcUxWVgT8t9rNY6TxiO5AO9+fzFcvBpBcoX2g5GCGIvl1GXkqsNP6A78yAEwbUgfJMTVE1AvHOHHuEpvPTP7cXP7p2UnLEE/jE0zpZrXd8jwwY8rGKpqbJ/mcAdq6JSPQ+l4o/qRPTJ90Nck8CXL9sgjjhCd2ku/2xUmxpULljmpuDrNHRmad/0eDwOiFZZMMTj1fTVeb/QJC2UK+mByY3gFexFP4/qDlzq6/J58GUEGkKRZzs/1Whrdb3sBmk6ckgFDOLzMawRhmByhIwIhNDuX0DzI4jZ94keT79VeDaxRnZF5LodEVr2NhIt1yb71EypKvAL3K9VZALsj1Tl5Y03PpRpO/W4/qy86/NUqTDCgN9/hMFuHIPvDtwR7sjejTNpWThDCuwSXudZDeaCKqeHbHao+oNiohcLSSThGV3qOWdaADucGyXT2Y7ZKGesmO/tCSKIv+rw7KkZJlQb+XUmzAviyNce5Fc2A0zDx8OevduyxoMiXCw5kN2fyGZVC22E3oTPFwuisTuzQZ4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(32650700020)(82310400026)(376014)(36860700016)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +0hWJlzM/ml456A3CcPZuWQoEfn2qEMtBMShuozQAvSy5TnM/91MUWTpl7skmiG7V4dUMKHpUYIFy7PpVBBWg34qK/XG2xdBq+aeDY+k5vGoMZq9gx+ulnsRDbtygsAliaYKrYZmF+n2GysLT9Cu2sHCII15BOsZZcWn9TsgASRtekqPKuZYM+s0skuq4CUb1SaUpYoNu3ORgJs2lAj/vBdhsqAD1GD1g8SgpYAvQkCBqcjLC7aGVjtvxrh0KhAja9Il3tIoCVFMdIKwBciHUZNavOuT9SlLAe+UFib2c+nl4ogLCFRw4D8SsLc+2TGcxAwLhSLgzugz27u2/IDOyNJM0PA16h/W3j8/UwmM6zpEN3OzFXD/11kAGcYa/0yycRMARWyrDjEDuAireEtn+LGi5U7r5pqmBNNM/ivpSAqm8xYlRE3Gqr4pH0zUK6vP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 04:11:28.6733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e78bbd9-b787-495f-37a5-08df1f721150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB174847
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

pxe_menu_to_menu() numbers each extlinux/PXE label with sprintf() into
char num[4]. That buffer holds at most three digits plus NUL, so the
1000th label writes one byte past num. On 32-bit, name sits immediately
after num, so the overflow corrupts the name pointer and the menu prints
a corrupted label. On 64-bit, alignment padding absorbs that extra byte,
so the overflow is not visible in the printed name.

Enlarge num to 12 bytes so a full decimal int fits, and use snprintf()
with sizeof(num) so the write cannot overflow if the count grows
further.

Fixes: 32d2ffe7316b ("pxe: simplify menu display and selection")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 boot/pxe_utils.c    | 2 +-
 include/pxe_utils.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 8c1310dabeb..ecea2ed74d0 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1572,7 +1572,7 @@ static struct menu *pxe_menu_to_menu(struct pxe_menu *cfg)
 	list_for_each(pos, &cfg->labels) {
 		label = list_entry(pos, struct pxe_label, list);
 
-		sprintf(label->num, "%d", i++);
+		snprintf(label->num, sizeof(label->num), "%d", i++);
 		if (menu_item_add(m, label->num, label) != 1) {
 			menu_destroy(m);
 			return NULL;
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 0378f2889f7..7365a8787b2 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -39,7 +39,7 @@
  * list - lets these form a list, which a pxe_menu struct will hold.
  */
 struct pxe_label {
-	char num[4];
+	char num[12];
 	char *name;
 	char *menu;
 	char *kernel_label;
-- 
2.43.7

