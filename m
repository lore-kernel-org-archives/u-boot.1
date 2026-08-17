Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5872C5DF7A
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 15:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DACEC40817;
	Mon, 17 Aug 2026 15:41:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7RTjjE24YBwZ; Mon, 17 Aug 2026 15:41:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1BF294074C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786981278;
	bh=CIB3YC7VHhPpvw7ol53nKAFvgXpvfZwcgrH91nkAI4w=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dWSEdyMm+W/6spQntSQBFtWsfxL8mjp1/T6eWlgkpZxj3ybqy568MPrtEMMHoUx19
	 L6nbiWYTjAIwzxTeM9fT6h/SHdkxKUqhqfbqgTjE1BqoGUhPhGbbaJVU7B3hUe/RFW
	 AjFzfNGwjaAE5IOnblvkWEstJyqRA65P+MF0x2u0n/krqNVJpKxF7l1Sxc1dgDTT4d
	 36WgBUn/zOZTKe5djG+Zu+FCi1uQlvOWfOfm7HHKF6haP2A4Jd0+X1anYjVrgAKfRk
	 mHsHPL2JV0q+rAAH6agmdMytM2N+30gS8ciykW4PD1IIoBsvmkp8Lj6aSOCJ2kbxzq
	 aNpdcTIiC9Gpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1BF294074C;
	Mon, 17 Aug 2026 15:41:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAC1E282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9BBE240849
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wc-VCYgTgHxD for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 15:41:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0352E40757
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0352E40757
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=GBXX6Qie
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0352E40757
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 15:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGguiy/Ss8vf2HMrV9QuTbFhfgseJfDdMz7o0KWh7LSPGm5l4v3VLcUd94VhIjL7mOf0rWnqZ+qZUFsUukVwrs3TD5JzHY66reiRtt1E75FhhZ4VO6Ig6Vk6x57Ig1Ju115/qIy3hEgmrfXEaHPhIpzBPlqARoP+xm8qt28EieSmTX2wmtJTSw5e72HWYSaJpX/vFA27NQJNu6Nu55GjhJDjzKF6sgDs5Sc8PvFTqwQy4YJpot2TPNE1vwtWzNLPjdkQIKHl5D9pMQHcvQjJVwNO2vVW73+tVRiZ2RKu2NpVhIWGbmjRT0Zn6QZsLEgiZeO6py4ly3jTKr8VUF3f3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIB3YC7VHhPpvw7ol53nKAFvgXpvfZwcgrH91nkAI4w=;
 b=JS3AB8WfZq7uYJvQ8I/BgPDTwoUzd01pkOWZ/erXY0bXXgDzD1owOXjhqJ1z4VGdepBMVZ4OxNvwpi4U8nZcTp55tK4AFhz22pa1dxmo6wL9lGeOW8CS4/buL7ZOafehgCcOsvRj4LSDOeleRHzbAa1znJ0r4z9Ghoge7UKeMnIs+3j6P/9DsBh/wfoXzRglQo/nPDxJpJaeytT3aPrzVHxKM6yNuuZnN8e7CvIcJtZt+k6B7CnfOi27SBd1lnmznpgSkOjKMuPFo740R+wVpWORIdyv+PBLlYy7EP6zCSInSxU6OCqwrxFpegzZQQwtEXBj+2fBmk+jOi8E5hy6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=denx.de smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIB3YC7VHhPpvw7ol53nKAFvgXpvfZwcgrH91nkAI4w=;
 b=GBXX6QieFlTJJZzigtP/N2cHuSkE4NXvwpyl/e8Xx6/qEQLeY5sAbYsDtyhUf4R1+N1iMBsq3YILFZ34b5QzpWcRG7YvcF0YVtI4J2vpHhuzQB7BMUM4Mjy3y9bEYbBvTUf+QkljpXYsv4BST9f7uQRTmmD+WSDzWaaXljnLHhSMrFynX8rXUSO7N7SS3Cdb8UrSyTRcNA7Xz44fcNn1WcIGjMPRxemczPdAehzc14l56UqbRDm1ZZSC6F7Khn6ZeLiCF/WvbnkYuVDwEfVxlB918JEf2WjFr6gMX/ZGaJn+IcLL/DMDTGuQWK3gaN6D8CKg4wHjQO2u+hod2RZcvQ==
Received: from AS4P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::16)
 by AS8PR10MB7475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:41:07 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::2f) by AS4P189CA0027.outlook.office365.com
 (2603:10a6:20b:5db::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Mon,
 17 Aug 2026 15:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Mon, 17 Aug 2026 15:41:07 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 17 Aug
 2026 17:46:40 +0200
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 17 Aug
 2026 17:41:06 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 17 Aug 2026 17:41:04 +0200
Subject: [PATCH 1/2] usb: gadget: f_mass_storage: Remove useless rc
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260817-move_schedule_inside_sleep_thread-v1-1-0023194e8c47@foss.st.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
In-Reply-To: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|AS8PR10MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d845830-0996-4dc9-1e81-08defc75f451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 4c7zEmsc1830tRTujsGq5CM8IZVeoQNoks62zs4tZ2CY1dYDjvWYLbbbeGVniu7Dr3qPznFUNgXNjpxT5Mf89+RkvYMpCYLMc2nGo5thvQzl2/jvyofzCpf2gA3iCycXMCGui//RWCVwYLh3fD21M2A8E6dCVnP5/7EQdJFM3kmiZgY+ENKEJn6jeCh6Gbt34qZg5vFJszxww0MZp0wej8fGzpHYxCr6Nrxt2YleBshfOkNdh9IfyeISJD4piuwjgWsYBFCnBcEtAMZ+lX1qqfEFbBeUuMKe3XBnElQX4WvRdN6YLgjNwj575VbZy0OBcxGq0W/e5ioqG21gtsSkYkgLtftsZcUhw/BCYjemcPOh44/KIjLqmHihqq+a/CmiY91DjdkfxQTqDyTWjcruz5CrBpNgFrRCL6UphgWEtBgcl7lk/kkTNVeNOn+jQt8kmgV3LLnZTbTntDy0bJCUHJ0igG8YYDEuuwUtbF+mSQqUFiFmdHEBTd/ezFRUHrr7ss9pzNKZnhiAg7CRalgVF+3MZbkJ/Sax71p1vsgA69QjwPjXKVjKYoLUGUYXp9a2x6hqCkbYjyQTot5OZk0ggy9AXkR1xYN4x3M5/VyzYTkdpLjLT5/LXU3Cm1SDki1H3UolagvbkMdzSzVPSc2X1qn3yfLxi2l57sUxQPxu5uVHhcDu1d062cc6jeiVeclxoIaG57pvxvicOvmzsYCxYg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PVWZrsuM0txmFRK/pjTVj/CDtw/5ORM7H4DcyD6Z7niElfX8l741NxQE2ts7wOkYPJ3L7+BUAMt+SsakuQ+RwirDxShhlaLiS/jhXDgaEY9Nj772B98DS718DLzMcCfG9s8LRchA+lDHZ4u8Lk9ehOObGlNIvyNyDrVr5xfN0mKdu0JXrc3XllKIZitvfyWqgat3RBGVtTInObVJps1Xm7jXb+BmQBHUYADvFChe2IUhSy4Op0C3hgCd2dimVXv7XA6p+lRxXgZLmKAGeqkQYTYBwW2o/aG/1ZZ87T2xLA1dY7/Jpt/lrFIe5JVkXfpP9qFY89z1Dy4StZwCp9tDwMu6s7l5n53W8LHbMI6LdmQrdijBORIiLFvkdzDVmrCx84qDItIPygka92DS8HM8z7zVKckIDfUjta5bUS3EYOcP7oBem7dodafZbcP5Idvd
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:41:07.2655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d845830-0996-4dc9-1e81-08defc75f451
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7475
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

rc variable is used as sleep_thread() return value.
It's initialized to 0 and never updated inside sleep_thread(),
remove it and return 0.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/usb/gadget/f_mass_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index 7eb667c130d..621852080e2 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -650,7 +650,6 @@ static void busy_indicator(void)
 
 static int sleep_thread(struct fsg_common *common)
 {
-	int	rc = 0;
 	int i = 0, k = 0;
 
 	/* Wait until a signal arrives or we are woken up */
@@ -684,7 +683,8 @@ static int sleep_thread(struct fsg_common *common)
 		dm_usb_gadget_handle_interrupts(udcdev);
 	}
 	common->thread_wakeup_needed = 0;
-	return rc;
+
+	return 0;
 }
 
 /*-------------------------------------------------------------------------*/

-- 
2.43.0

