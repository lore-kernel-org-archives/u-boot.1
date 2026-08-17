Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E497C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8CE14081B;
	Mon, 17 Aug 2026 15:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uFWznEcWRyrS; Mon, 17 Aug 2026 15:41:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB64D40756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981275;
	bh=02D14FrtOkQiiDfFDddz42caT3otLH1/I6WWq8Ht+Cw=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bmx5rKf0lfwk8E+xNqoyQTYk3AHVzKYIFDgvwRqOy0bbG8CRUO2YK7FKRNftwznBW
	 1J/eEacTBXNy5MPDysKX660zoWO9lqqbRYlZnresoL+8jIf2Xb9dn6+eMmywpkjEKe
	 lYLZKxWrFQc5QxJ7FwI7ZGfbjvdhOigFwTmyAWoacDtZ5T6wwayL49nZ9YwjfkIxUI
	 AJGuJYT7eDxZQYfLufm+eUHTomo/kSy7+pfQX/ksfAJUfNTG0sK171BRRgcQ013/cg
	 UxLcvytUrV/5z85VNhHJcOM539+QJnqUs4/PIs6NaaJ/GPZyx70SaY1EWWcQuOiGDk
	 DSlqg9Ld4jYlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB64D40756;
	Mon, 17 Aug 2026 15:41:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ADAE6282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93AD240720
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Blw7mGrLWEQ3 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:41:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2225406BF
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2225406BF
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=GECzgZRN
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2225406BF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urI9G9o90fpQFfXCrcBQDS40pObVVqkK5uuXle0QQhH6W8auuXRI0DJmedcoFSoF6YLXLmMHbL31gn2vDgVWEdwY0/RAmP1QfV7hknO8wKPckcDbOqwx4i8OQq7gENPW3XtrMNl3+fMBSdiVZwhLE6+pQRpYhAaiQXMHI/PG8XcJosAmd5lsqMYcQARwwv92xRUSpwUl1Lo0jWY8TTxMDx3P0GfsbJQOTWLm5J/uti69WwQhrikiRexjGRPkAUmqAPiFp6VYF+iZdJuEHmOutHXNroN+6xUbi7zFTTb/r9s8FY2PsUE8SAW9C9zbOkLVTjVSpek4c2TRZLCAfo4PiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02D14FrtOkQiiDfFDddz42caT3otLH1/I6WWq8Ht+Cw=;
 b=ofIdnvqJYaVlbijbtNYPkDDrRafjN7ynJaoLhH/kv5omtLZQSPaLN4wx3Tx+S/O0LO6Xt3SpFbNaJxe+Pj9VmuGgkbbUPftv8N+20yEMvnmd59ktYEgEdxDP253yF4eHUyhPHCXGaO10uzJsAt+BOVP1JBw4jdtntQsmAJ3inK5xHpFDUy5HvPepUWWwG8fZmuydUurxz+qRjQP/DaWTQ5Rc4wG6LEROpIq8OQss6HACFYns//zPtRu9GeQX9zz1diexaPAF8+UlAlRTE59Q/z4UDqJfp+TsnKiCNDIXFMp/gUloSqO1nGc+nIU3MDqGVDiWc4OHxvI59yCR05I9NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02D14FrtOkQiiDfFDddz42caT3otLH1/I6WWq8Ht+Cw=;
 b=GECzgZRNtNbyQnTsZQhqjWYJi9HyqrxaD1bu7k+mJRhQ1ZXcaWFuLKbWYcgrcwm/SpAOm6eb0TBoYGU0CnuX3tFHGzWYdy4e+Ti5yMCtDL/6V8AU8AJrwZa+ijzv3RHFFjnH9t1BfkbRUy6rFT7s9xfaOUoDbHmNDmzGoyRxkTuz4RNZAfS7z6z3F2HhMrOsHz7BhAbfRTJlDKmNT2bxHbNyxDE5I3omjZl9VTYqbaft7kw+vBHRy6yMGwAvSfmM0UW5A4axFccfWWF1Ze9x3NWMptBnIgeVG12JBBh2yVQ2KBT0rGKdGuqSENl6tlqHI6skFEpLwZHpZvEdQcy0Zg==
Received: from DUZP191CA0047.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::14)
 by PA1PR10MB8920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:41:06 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::81) by DUZP191CA0047.outlook.office365.com
 (2603:10a6:10:4f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 15:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 15:41:06 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 17 Aug
 2026 17:46:04 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 17 Aug
 2026 17:41:05 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] usb: gdaget: f_mass_storage: various fixes
Date: Mon, 17 Aug 2026 17:41:03 +0200
Message-ID: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI8rg2oC/yXNQQrCMBBG4auUWRtoopjiVURCTP6akZqWTFuE0
 rsbdflt3ttIUBhCl2ajgpWFx1yhDw2F5PMDimM1mdac205b9RpXOAkJcRngOAvH6gGY3JwKfFT
 6eAoW0fSd9VQ7U0HP79/jevtblvsTYf6Gad8/NXx/noUAAAA=
X-Change-ID: 20260817-move_schedule_inside_sleep_thread-134c7ed2f87a
To: <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|PA1PR10MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc9f92d-815d-49a0-4518-08defc75f3f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: +OC65/S1edHl2uKlytO0JpEY/Shx0qjTMqsrgk2i0kvtF6z8uLbfaNPZyU8jRP5TTMCw0Uyqe767EUFzVnk8utELWxXYvdpCflckVpgI053mKOEY+24mGQCHcJOV9NI4dRA+tAsgIGiNB1yfNb0fmXQesqQDxUgl9+kqBkaG3c1e3spVlD4VSCB2/SxBjBbBzLnFM8oYnVIgpNyanwg+gJuqp3I3Hfk/ffzDl6lnBP/cPrr9DsIOVEeHWwa4VeIGh3sk5hz4OaeFa1rpL6y0QUSOYfiDqm2q30Kj9NIz5bnVH0iv7JXfkTtWY7k+ZLUUnCnpQu2YalSGisWjOv5KyzpF78mSsqh00adn4HU/09EX8EztbMnedge+QRX0pWvg6mClLC5NpjOqHGK4uwwrrB8sG0Zdm3KgCwLAhCD2CorJN+3RWCedtHs8GcdxdtxULBWDFgYoUsQ6EefdG/gMgD91dCiWNQ/ILvTdcDOs8n3sd/8Q+Ric9KsT7hO2WH9pgpRxBcWMkaHJM31jnQzpPE1165t5YXqSDuuLk0m7eral7Y42AAVjJdwBt7o3oQYlA0ROKELEnMSGuuxJibIsZtGuOpspWIwyjIVHu3X0CKHrYJuHK85JloF51GypP2QKC5udl5h4bJmQz8GSSY01mGFXb2gYGXxWym2KpbwOKiqYAp3Vspvmfx0XM5s1/LZZZXZDtrR/+HRgDtBinUgFvQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dHBRQ5t9fmjK4FCLBOaQX4TDt/8S6799ujQmE/9r7t1iKhUzzeVeEYoe4Rcibn36HTeZw9oOpXX9MlKHR0AtyNfmL+ruf6jPYnAt0pzIJuGJJwrKbBvrCNdIa6ks/BIBlF58j3PI4MEyI46uBGQf7f/ixEsYPuxPsxgmhB82s8QP4dfQRC0zcNZCxfQeHILNb9oAoOpTwSf6ttbUFyWx3G3R+T1rPNUeZGyG1PzltVXUNVzqn5E3GlaAKACnnIJ5NCvKgDy7JzugVwpU0oiuSj2RHRu85IUxleipmLgVpjeyjjajUxmwZNMuI+Kes7HMZaXeVPEGR+YpNu54mZjrs/kA+UzdxeWqhGsu10eZEie50W8MJQ7s6H7IdE7wbKWejmR47ucaEcSyDGBiXcYPmQcurSwKZLm4WwraqH+6Bu1hdIBdY4t3v4FIl6LFdgou
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:41:06.6526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc9f92d-815d-49a0-4518-08defc75f3f9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8920
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

- remove useless "rc" local variable
  - optimize schedule() call

 optimize schedule() call 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (2):
      usb: gadget: f_mass_storage: Remove useless rc variable
      usb: gadget: f_mass_storage: Optimize schedule() call

 drivers/usb/gadget/f_mass_storage.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260817-move_schedule_inside_sleep_thread-134c7ed2f87a

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

