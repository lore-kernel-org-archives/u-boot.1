Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A366606A323
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MbfV8WaG;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iAEyEaXy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DECB680F50;
	Thu, 22 Oct 2026 13:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CP9oSbh63Tv9; Thu, 22 Oct 2026 13:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2989081103
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792677503;
	b=Wi1BlHwD6RZvsa+bJ3EdnTV0HkagANLCPuXNC7dJQgkHieA4NpwTXgNHQkfZIqoboqqG
	 G27us/ngPdSoxlRNv8+SsxQXxXM1OpEDM8BFqt5Ba0UG0Nvkq1hFo0wmKB06Qz3md8qhp
	 8vWr6vOmle9tawGPZBfw9x/jW4E1ruxQEpCIbx3lztLCsYifiGk/7meHi+qiosQtRwhfv
	 CHp6fMRW/rbCrKMBHM+RdF333Ic/oITPQ/UmAUhnWm+6jV1yvqUp3bwOnANbMfMl2XJhs
	 A9C1r3q471yiaSEMT2rkdxFtKbTkxEZ0F6vWXGPvDOrTPBvwctwn1jOviVHm7+a4seg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677503;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=KcMLI3/E5dIW8Dkv0a3rxiPBz72hOZiUD3/NN4hxF10=;
	b=EN8Ar9kbK2W/oANWfPHY0kKBfYO+6LAvtnAhVs6GedVPkW41f5j4h8EOkxUUJXchZDFv
	 9VR7PllBwS9t+wVXPZLvoTTAJc/D8d1R7oTVAhF0E5bua39M2keopg+la5BfIalspt+NJ
	 wMPi3rH61wTqllDPBBQETMs0dWRnDf6CjGxJyFw49k4OFwEBSZeoyskGvc3EvbM83DSMi
	 Qew/bayExLxej5r0Eq4ZB7jza9WuB7KSKWBH5auMgag64Hh0pSadnuMQWV1w5/s6Ii+pL
	 U89cVj44KKoYNa8sruF7HKmtnhGt1iYaRe4PuYnDLIQZVx65KfFh7aqy7SaVQ+DJfcw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677503;
	bh=KcMLI3/E5dIW8Dkv0a3rxiPBz72hOZiUD3/NN4hxF10=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MbfV8WaGP+KUJwIC5gMG9BsSkDr7q56V7B8fzEipj78ahIvofLv/W6YiQ8ZAMeyMF
	 TuYcqwzzKlUPqCQZXGFbl++d1IzguxdfbSb0YWjSvMLh9hbkq9ftdrddtTdzs1JlXn
	 xEirJg7Q46AWjyZXNXz3IutoJCK2S8sTZU5LWXJBpySgePo8tOSwiwOBID+2VPRpdg
	 mC5/oYMS327z3xe0fG+wMoOLMpxSLKhy7/j+E3hbazbpcw5TOXb5Xv++FWVf9UTu6r
	 839Od8MEiRXc+df9mvIh9okM5H3YNQKiSv2gtA9zxKm2n9UseDTL48aF3QfiPtLAyJ
	 Wil8dRxN8XQWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2989081103;
	Thu, 22 Oct 2026 13:58:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A44082A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 944A240122
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S-5IkhTyoC9o for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BFBCB40086
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677500;
 b=bDsFtw49ivK0NVJ0BDa3t/AEtgFicOCjmVx4l4ZI6iLFoOGX0VSmQ8c2KhDEu4cwdVxm
 Gnqu+NIOIx3RGThW8PqhDCl0gvOwftaw/H0o+XfO7P+MllIsIiPswiGg3zJlbJCu8J4tI
 HLcqRxRMPVRd1R3fwUSFqTEMRvr4GFo/m71Z3XtzygkOIPLrmUlmBTpTBHNSbQOXIsNrG
 NNaU92GdxwIqFjGclK0TUd2TK8srL4WEPFqDdgLPw4BsUeRORZBREIJwY9YGmIuAYIwkK
 AedZelQcx8RSZ0fZ9FeAJ/+6go0gW+Do5F7mGgnbAKQ88RsBGBd/MBcYVicqcTWHEXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677500;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=KcMLI3/E5dIW8Dkv0a3rxiPBz72hOZiUD3/NN4hxF10=;
 b=LtKBU8TFMlSR4PU1GAgTTRN8MbF2mrfH3UmH+OtP92G7hG174HsvjdQZg0V+0nMFHhXi
 mcnKPHHeFl2HMRcNbF8CncBJVTGTgCXyeyTd3YeJgG5/wQoX58WD/AufGpXTCoh7FDC2f
 PxCDxmlZLLHTqOBaOPvYEKGoxLXWJHJzMg/AOB2mqqVn8EzOXnaA7UMAaYQT37mO6w7U6
 8gs6zGcWG7m65xmA+1/VKlKakhLPlQK6Ex5WHWYg8h/YEiDG8UUG6ApvAvwrQfYeyIFpu
 NCGarBWMk7rG4xTy4nLm3o+DsgAURVEzBErodgKp3BYtFvBhT2yQrKQyGFsMEjnFG9Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=iAEyEaXy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=iAEyEaXy
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFBCB40086
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGUDNWZKhmyY0a+yM2GVs+JDiURJlB2Mw/bFMZF7SkBojsyCmnLYj23ccBt9d+8Xi0gcH4g5SfUUzce1gL81qrfSiAL+AYGp06sFCWX9TKyTXg2QR+RsnQpSF1nugT7Sy3IzbmDTLnizdjuZ47IiKshRzxnuZE5WY63NrgzOr4B5IR5wDl5od9jSAUPe7YHLRf149bsTQlU2GA+HTXQDujoea7Ly3xiEJ6cMWWMUBjsQZhbbfn185Yfq/P+JCzjrcq4yEAOG4zzsL7p2zFDp40W5/0Yu0PFtFaaKpiVOOw6M6WTUGRDsNBbcYUwrlRQZ6uGdWfabqD0/RWwKW/B1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcMLI3/E5dIW8Dkv0a3rxiPBz72hOZiUD3/NN4hxF10=;
 b=PJEdMC1vvAY4JERIUYqcfwgVzzAkvLtcEGN0YvjuXfJJ+XCb98XtYRCshVzKG7N2vBW00H4XI3JnR4k09NeN0OmaUwwVKmLLdkZgAA0D9QDdq3hot92Rj/GIyLwUoFuZJVcBpp8kqNL+G3bII6BcmNBLNtw1e/CCKkBwvgqG9oYnimtcT8eLgeee6+M6eBXd/T8T8skQRdmjllB6hY92HIkjEQnCMii0W7R4BLI/CXQepuh0mKOBsXM7rTQhcxu6YspJ96050HGH3azanht6C7itnVfZhAAIkkLWKIytQsSpIsS9TjMcO1pZuaw4BnxSU6HPl4DhI6bZSGcxp1DTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcMLI3/E5dIW8Dkv0a3rxiPBz72hOZiUD3/NN4hxF10=;
 b=iAEyEaXyyX+vzdn8KT6jhBTZrZyAbli19jpG70r0LDA8L6szKOqW1IevmCkidV2FLCHWdM76eMzyCcngM4eunskXpfJaT/rvwY3aQ9BFG/UHk6t7e4SH3ySUO/Aj0MXZCKMHd34u0cggCQEZRZVwz7G9FqheXUJTmi1hA88mQoA=
Received: from SJ0PR13CA0221.namprd13.prod.outlook.com (2603:10b6:a03:2c1::16)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 13:58:10 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::85) by SJ0PR13CA0221.outlook.office365.com
 (2603:10b6:a03:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 13:58:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 13:58:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 08:58:02 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Thu, 22 Oct 2026 08:58:00 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>, Tom Rini <trini@konsulko.com>, Johan Jonker
 <jbx6244@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Daniel
 Golle" <daniel@makrotopia.org>
Subject: [PATCH 2/4] mtd: Add virtual concat support via device tree
Date: Thu, 22 Oct 2026 19:27:05 +0530
Message-ID: <20261022135740.3869144-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022135740.3869144-1-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: cafe246c-b60f-4ecb-ec19-08df304481c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|261021121427099003|13003099007|261021123027099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6wGm1SPVFNVR3CHY/iQFy6s9+pm4Q6QQ40EICU8cQWVvn1mbTRbXV1nQTTC4fOglkMoS2M+rEN4b8TheG55vSHYuyms+hsPJblEe7UdmYP9SD2W42NsKbTy/E9WiEydarplRdeHimqdtCcz/YwQ4xShbO3cghW2Iw+KwfWGxMJzx2oLI/sgDWfvgojAZzTXkjEYQ1Pr349lHQ/PjOJjBxoTa4fau9yRnZoQX8vDDh4fdcO5rtqEkd3T50tI08/mL8KMNEuBnWILwv763KoT1W+4UOLMFjYP+PzClKMIFRGAUDH+TzrsrTIDGkhvsOTHjvKDGMbnIZMMgBI946yxYxw3DPJpUG2AUNL708PSBBsSSq6qHkE2wJp7NrfbeFhHN0KqQrvFYuBxTEfknCfNDabQQDn5kdNLo7EPTzcizCsMzPwpgbFkao7wnybgmp9FG9aD3r5chymVDY2BrufCArECLpjdp3xyj0pZdiFMy9qHmI2DiqGa0KfjEk7ytsYZm36TLntM1jJCR7kD08c4sFmZMQVp7cVsBAqJTDW1CkA8R5ynYx7uqZmFhwTsAE2McCODoVPVcrHBQXUIXnj50oq5GfB0zgB+aQRh1BwHpRh1N4gGguvcW4weQ+5oY+Y6IoajqaLzLDQ02D7i3B3xTFb/MMDFGa8BWo0te/zuwDfM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(261021121427099003)(13003099007)(261021123027099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mUJFux5eBtDCl8w15yOHsP0gbqbdeUnpXMAPqvpeS9EXG0eO44ZStbvVKUoOdiKUu9+0G2UXgrDyxeGq//7LMeexe6RFK8MORL+gOHhwkkTTpgz8RmHU4+GuT7FdWORQ3YTAUPmtVAi6YUnQrRZ63r5ByjIyWO0DdS8DVwHyg6Eq1kUGC4tDG1WCUGz9tHAPwD+BgJ/wsH1lQvd4JKn4mAWq+alkyIXQR3eIrQf+EqepFvB7r6WSpTM/eNZG9kLcbpRpUG9LRSitzbCFhzB88zjbkNPgbLcv8FlqP7EQ0Q4GTtCCKvtJfRFnVLNLJkPYe7att6G+W4H/qSrXAse3/+q3m1uhIN2R/GJ4z8mmXP52GLThGUYEkV9YErH3SUCmr1ioFyXhrCAYhdB3b16KVnKvaKr8dLKjQrOnIBTk8nSCS5h5BpEMhQNJgO302ufQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 13:58:10.2086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafe246c-b60f-4ecb-ec19-08df304481c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce CONFIG_MTD_VIRT_CONCAT to separate the legacy flow from
the new approach, where only the concatenated partition is registered
as an MTD device, while the individual partitions that form it are
not registered independently, as they are typically not required by
the user. CONFIG_MTD_VIRT_CONCAT is a boolean configuration option
that depends on CONFIG_MTD_CONCAT. When enabled, partitions declared
with the "part-concat-next" device tree property are transparently
joined into a single concatenated MTD device and not registered
individually.

The solution focuses on fixed-partitions description only as it
depends on device boundaries. It supports multiple sets of
concatenated devices, each comprising two or more partitions.
The "part-concat-next" property is set on the first partition of a
group and lists the phandles of the other partitions of the group, as
described in dts/upstream/Bindings/mtd/partitions/partition.yaml.
The partitions are joined into a single concatenated MTD device named
by joining their labels with '-' and appending '-concat' (e.g.
"rootfs_a-rootfs_b-rootfs_c-concat").

The implementation is based on the Linux MTD virtual concat series
(v17).

Link: https://lore.kernel.org/all/20260204-mtd-virt-concat-v17-3-5e98239bb55b@bootlin.com/
Co-developed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 MAINTAINERS                   |   7 +
 drivers/mtd/Kconfig           |  14 +
 drivers/mtd/Makefile          |   1 +
 drivers/mtd/mtd_uboot.c       |  13 +
 drivers/mtd/mtd_virt_concat.c | 502 ++++++++++++++++++++++++++++++++++
 drivers/mtd/mtdcore.c         |   8 +
 drivers/mtd/mtdpart.c         |  12 +
 include/linux/mtd/concat.h    |  57 +++-
 8 files changed, 613 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/mtd_virt_concat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 28d090d3c36..081d1726764 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1315,6 +1315,13 @@ T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git
 F:	drivers/mmc/
 N:	mmc
 
+MTD VIRTUAL CONCAT
+M:	Padmarao Begari <padmarao.begari@amd.com>
+M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
+S:	Maintained
+F:	drivers/mtd/mtd_virt_concat.c
+F:	include/linux/mtd/concat.h
+
 NETWORK
 M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index f6bd9f6f2e9..c82e377a1c7 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -32,6 +32,20 @@ config MTD_CONCAT
 	  into a single logical device. The larger logical device can then
 	  be partitioned.
 
+config MTD_VIRT_CONCAT
+	bool "Virtual MTD concatenation via Device Tree"
+	depends on MTD_CONCAT && DM && OF_CONTROL
+	help
+	  Enable virtual concatenation of MTD partitions based on the
+	  "part-concat-next" device tree property.
+
+	  Partitions declared in the device tree are transparently joined
+	  into a single logical MTD device. This is useful for QSPI/OSPI
+	  stacked memory configurations where a filesystem spans multiple
+	  flash chips.
+
+	  If unsure, say N.
+
 config MTD_BLOCK
 	bool "Enable block device access to MTD devices"
 	select BLK
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index ce05e206073..fd3c3ac7cc1 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -7,6 +7,7 @@ mtd-$(CONFIG_MTD) += mtdcore.o mtd_uboot.o
 mtd-$(CONFIG_DM_MTD) += mtd-uclass.o
 mtd-$(CONFIG_MTD_PARTITIONS) += mtdpart.o
 mtd-$(CONFIG_MTD_CONCAT) += mtdconcat.o
+mtd-$(CONFIG_MTD_VIRT_CONCAT) += mtd_virt_concat.o
 mtd-$(CONFIG_ALTERA_QSPI) += altera_qspi.o
 mtd-$(CONFIG_FLASH_CFI_DRIVER) += cfi_flash.o
 mtd-$(CONFIG_FLASH_CFI_MTD) += cfi_mtd.o
diff --git a/drivers/mtd/mtd_uboot.c b/drivers/mtd/mtd_uboot.c
index 69cb3b51f92..fdd997283f8 100644
--- a/drivers/mtd/mtd_uboot.c
+++ b/drivers/mtd/mtd_uboot.c
@@ -10,6 +10,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/uclass.h>
 #include <linux/err.h>
+#include <linux/mtd/concat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <asm/global_data.h>
@@ -315,6 +316,7 @@ int mtd_probe_devices(void)
 	const char *mtdparts = get_mtdparts();
 	const char *mtdids = get_mtdids();
 	struct mtd_info *mtd;
+	int ret = 0;
 
 	mtd_probe_uclass_mtd_devs();
 	mtd_probe_uclass_spi_nor_devs();
@@ -357,6 +359,12 @@ int mtd_probe_devices(void)
 			printf("Failed parsing MTD partitions from mtdparts!\n");
 	}
 
+	if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT)) {
+		ret = mtd_virt_concat_node_create();
+		if (ret < 0)
+			log_err("Failed scanning DT concat groups\n");
+	}
+
 	/* Fallback to OF partitions */
 	mtd_for_each_device(mtd) {
 		if (list_empty(&mtd->partitions)) {
@@ -366,6 +374,11 @@ int mtd_probe_devices(void)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT) && !ret) {
+		if (mtd_virt_concat_create_join() < 0)
+			log_err("Failed creating concat MTD devices\n");
+	}
+
 	/*
 	 * Call mtd_dev_list_updated() to clear updates generated by our own
 	 * parts registration loop.
diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
new file mode 100644
index 00000000000..fa0d1c9a483
--- /dev/null
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0+
+#define LOG_CATEGORY UCLASS_MTD
+/*
+ * Virtual concat MTD device driver for U-Boot
+ *
+ * Copyright (C) 2018 Bernhard Frauendienst
+ * Author: Bernhard Frauendienst <kernel@nospam.obeliks.de>
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ * Author: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
+ *
+ * This driver enables transparent concatenation of MTD partitions
+ * based on the "part-concat-next" Device Tree property. It is used
+ * for QSPI/OSPI stacked memory configurations where a single
+ * filesystem spans multiple flash devices.
+ */
+
+#include <dm/ofnode.h>
+#include <linux/compat.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/mtd/concat.h>
+#include <linux/mtd/mtd.h>
+
+#define CONCAT_PROP "part-concat-next"
+#define CONCAT_POSTFIX "concat"
+#define MIN_DEV_PER_CONCAT 2
+
+static LIST_HEAD(concat_node_list);
+
+/**
+ * struct mtd_virt_concat_node - components of a concatenation
+ * @head:       List handle
+ * @count:      Number of nodes in this concatenation group
+ * @num_subdev: Number of sub-devices collected so far
+ * @nodes:      Array of ofnode references to the partitions to concatenate
+ * @subdev:     Collected sub-device pointers (used before concat creation)
+ * @mtd:        MTD device returned by mtd_concat_create() (set after join)
+ */
+struct mtd_virt_concat_node {
+	struct list_head head;
+	unsigned int count;
+	unsigned int num_subdev;
+	ofnode *nodes;
+	struct mtd_info **subdev;
+	struct mtd_info *mtd;
+};
+
+/* Forward declaration - destroy path calls this before its definition */
+static void mtd_virt_concat_release_subdevs(struct mtd_virt_concat_node *item);
+
+/**
+ * mtd_get_node - Get the ofnode associated with an MTD device
+ * @mtd: pointer to mtd_info
+ *
+ * In U-Boot, MTD devices can have their DT node stored in either
+ * mtd->dev (via mtd_get_ofnode) or mtd->flash_node.
+ *
+ * Return: the ofnode for this MTD device, or ofnode_null() if none.
+ */
+static ofnode mtd_get_node(struct mtd_info *mtd)
+{
+	if (IS_ENABLED(CONFIG_DM) && mtd->dev)
+		return mtd_get_ofnode(mtd);
+	if (ofnode_valid(mtd->flash_node))
+		return mtd->flash_node;
+
+	return ofnode_null();
+}
+
+/**
+ * mtd_is_part_concat - Check if a node is already part of a concat group
+ * @node: ofnode to check
+ *
+ * Return: true if the node is already claimed by a concatenation group.
+ */
+static bool mtd_is_part_concat(ofnode node)
+{
+	struct mtd_virt_concat_node *item;
+	int idx;
+
+	if (!ofnode_valid(node))
+		return false;
+
+	list_for_each_entry(item, &concat_node_list, head) {
+		for (idx = 0; idx < item->count; idx++) {
+			if (ofnode_equal(item->nodes[idx], node))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * mtd_virt_concat_put_mtd_devices - Release references on sub-devices
+ * @concat: pointer to mtd_concat structure
+ *
+ * Calls put_mtd_device() for each sub-device to decrement use counts.
+ */
+static void mtd_virt_concat_put_mtd_devices(struct mtd_concat *concat)
+{
+	int i;
+
+	for (i = 0; i < concat->num_subdev; i++)
+		put_mtd_device(concat->subdev[i]);
+}
+
+int mtd_virt_concat_destroy(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_node *item, *tmp;
+	struct mtd_concat *concat;
+	struct mtd_info *child;
+	bool is_mtd_found;
+	int idx, ret = 0;
+	ofnode mtd_node;
+
+	mtd_node = mtd_get_node(mtd);
+	if (!ofnode_valid(mtd_node))
+		return 0;
+
+	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
+		is_mtd_found = false;
+
+		/* Find the concat item that holds the mtd device */
+		for (idx = 0; idx < item->count; idx++) {
+			if (ofnode_equal(item->nodes[idx], mtd_node)) {
+				is_mtd_found = true;
+				break;
+			}
+		}
+		if (!is_mtd_found)
+			continue;
+
+		if (!item->mtd) {
+			mtd_virt_concat_release_subdevs(item);
+			goto cleanup;
+		}
+
+		concat = (struct mtd_concat *)item->mtd;
+
+		/*
+		 * Since this concatenated device is being removed, retrieve
+		 * all MTD devices that are part of it and register them
+		 * individually.
+		 */
+		for (idx = 0; idx < concat->num_subdev; idx++) {
+			child = concat->subdev[idx];
+			if (!ofnode_equal(mtd_get_node(child), mtd_node)) {
+				ret = add_mtd_device(child);
+				if (ret)
+					goto out;
+			}
+		}
+
+		/* Destroy the concat */
+		del_mtd_device(item->mtd);
+		kfree(item->mtd->name);
+		mtd_virt_concat_put_mtd_devices(concat);
+		mtd_concat_destroy(item->mtd);
+
+cleanup:
+		kfree(item->nodes);
+		list_del(&item->head);
+		kfree(item);
+	}
+
+	return 0;
+
+out:
+	return ret;
+}
+
+/**
+ * mtd_virt_concat_create_item - Create a concat tracking item
+ * @parts:  ofnode of the partition that declares part-concat-next
+ * @count:  total number of partitions in this concatenation group
+ *
+ * Allocates and initializes a struct mtd_virt_concat_node, populating
+ * it with the ofnodes of all partitions in the group.
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+static int mtd_virt_concat_create_item(ofnode parts, unsigned int count)
+{
+	struct mtd_virt_concat_node *item;
+	ofnode node;
+	int i;
+
+	/* Check if any target node is already part of another concat */
+	for (i = 0; i < count - 1; i++) {
+		node = ofnode_parse_phandle(parts, CONCAT_PROP, i);
+		if (!ofnode_valid(node) || mtd_is_part_concat(node))
+			return 0;
+	}
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return -ENOMEM;
+
+	item->count = count;
+	item->nodes = kcalloc(count, sizeof(*item->nodes), GFP_KERNEL);
+	if (!item->nodes) {
+		kfree(item);
+		return -ENOMEM;
+	}
+
+	/*
+	 * The partition in which "part-concat-next" property
+	 * is defined is the first device in the list of concat
+	 * devices.
+	 */
+	item->nodes[0] = parts;
+
+	for (i = 1; i < count; i++) {
+		item->nodes[i] = ofnode_parse_phandle(parts, CONCAT_PROP,
+						      i - 1);
+		if (!ofnode_valid(item->nodes[i])) {
+			kfree(item->nodes);
+			kfree(item);
+			return -EINVAL;
+		}
+	}
+
+	item->subdev = kcalloc(count, sizeof(*item->subdev), GFP_KERNEL);
+	if (!item->subdev) {
+		kfree(item->nodes);
+		kfree(item);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&item->head, &concat_node_list);
+
+	return 0;
+}
+
+/**
+ * mtd_virt_concat_release_subdevs - Release intercepted unregistered slaves
+ * @item: concat tracking item whose concat was never formed
+ *
+ * Each slave in item->subdev[] was intercepted by mtd_virt_concat_add(),
+ * which bumped its usecount via __get_mtd_device() and withheld it from
+ * add_mtd_device().  Undo the usecount increment and free the partition
+ * allocation.  Must not be called after the concat has been formed (i.e.
+ * item->mtd is set), as the concat then owns the subdev array.
+ */
+static void mtd_virt_concat_release_subdevs(struct mtd_virt_concat_node *item)
+{
+	int i;
+
+	for (i = 0; i < item->count; i++) {
+		if (!item->subdev[i])
+			continue;
+		__put_mtd_device(item->subdev[i]);
+		kfree(item->subdev[i]->name);
+		kfree(item->subdev[i]);
+	}
+	kfree(item->subdev);
+	item->subdev = NULL;
+}
+
+/**
+ * mtd_virt_concat_destroy_items - Free all concat tracking items
+ *
+ * Concat devices that were already formed are unregistered and destroyed,
+ * and the intercepted slaves of groups that were never formed are
+ * released. Called before every DT scan to discard the previous state,
+ * and on error paths.
+ */
+static void mtd_virt_concat_destroy_items(void)
+{
+	struct mtd_virt_concat_node *item, *temp;
+
+	list_for_each_entry_safe(item, temp, &concat_node_list, head) {
+		if (item->mtd) {
+			struct mtd_concat *concat = (struct mtd_concat *)item->mtd;
+
+			del_mtd_device(item->mtd);
+			kfree(item->mtd->name);
+			mtd_virt_concat_put_mtd_devices(concat);
+			mtd_concat_destroy(item->mtd);
+			item->mtd = NULL;
+		} else {
+			mtd_virt_concat_release_subdevs(item);
+		}
+		kfree(item->nodes);
+		list_del(&item->head);
+		kfree(item);
+	}
+}
+
+bool mtd_virt_concat_add(struct mtd_info *mtd)
+{
+	struct mtd_virt_concat_node *item;
+	ofnode mtd_node;
+	int idx;
+
+	mtd_node = mtd_get_node(mtd);
+	if (!ofnode_valid(mtd_node))
+		return false;
+
+	list_for_each_entry(item, &concat_node_list, head) {
+		for (idx = 0; idx < item->count; idx++) {
+			if (ofnode_equal(item->nodes[idx], mtd_node)) {
+				if (__get_mtd_device(mtd))
+					return false;
+				item->subdev[idx] = mtd;
+				item->num_subdev++;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+/**
+ * ofnode_dfs_next - Return the next node in depth-first traversal order
+ * @node: current ofnode
+ *
+ * Return: next ofnode in DFS order, or ofnode_null() at end of tree.
+ */
+static ofnode ofnode_dfs_next(ofnode node)
+{
+	ofnode child, sibling;
+
+	child = ofnode_first_subnode(node);
+	if (ofnode_valid(child))
+		return child;
+
+	while (ofnode_valid(node)) {
+		sibling = ofnode_next_subnode(node);
+		if (ofnode_valid(sibling))
+			return sibling;
+		node = ofnode_get_parent(node);
+	}
+
+	return ofnode_null();
+}
+
+/**
+ * ofnode_find_node_with_property - Find a node with a given property
+ * @from: starting ofnode (use ofnode_null() to start from root)
+ * @prop_name: property name to search for
+ *
+ * Walks all nodes in depth-first order looking for nodes that have
+ * the specified property. Works with both flattened and live DT.
+ *
+ * Return: the first matching ofnode after @from, or ofnode_null() if none.
+ */
+static ofnode ofnode_find_node_with_property(ofnode from, const char *prop_name)
+{
+	ofnode node;
+
+	node = ofnode_valid(from) ? ofnode_dfs_next(from) : ofnode_root();
+
+	for (; ofnode_valid(node); node = ofnode_dfs_next(node)) {
+		if (ofnode_has_property(node, prop_name))
+			return node;
+	}
+
+	return ofnode_null();
+}
+
+int mtd_virt_concat_node_create(void)
+{
+	ofnode parts = ofnode_null();
+	int ret = 0, count = 0;
+
+	/* Discard any leftover state from a previous (possibly partial) scan */
+	mtd_virt_concat_destroy_items();
+
+	/* List all the concatenations found in DT */
+	do {
+		parts = ofnode_find_node_with_property(parts, CONCAT_PROP);
+		if (!ofnode_valid(parts))
+			break;
+
+		if (!ofnode_is_enabled(parts))
+			continue;
+
+		if (mtd_is_part_concat(parts))
+			continue;
+
+		count = ofnode_count_phandle_with_args(parts, CONCAT_PROP,
+						       NULL, 0);
+		/*
+		 * The partition in which "part-concat-next" property is
+		 * defined is also part of the concat device, so increment
+		 * count by 1.
+		 */
+		count++;
+		if (count < MIN_DEV_PER_CONCAT)
+			continue;
+
+		ret = mtd_virt_concat_create_item(parts, count);
+		if (ret)
+			goto destroy_items;
+	} while (ofnode_valid(parts));
+
+	return ret;
+
+destroy_items:
+	mtd_virt_concat_destroy_items();
+
+	return ret;
+}
+
+int mtd_virt_concat_create_join(void)
+{
+	struct mtd_virt_concat_node *item, *tmp;
+	int ret, idx, offset;
+	struct mtd_info *mtd;
+	size_t name_sz;
+	char *name;
+
+	list_for_each_entry(item, &concat_node_list, head) {
+		/*
+		 * Skip if not all MTD devices for this concatenation are
+		 * present yet, or if the concat device was already created.
+		 */
+		if (item->count != item->num_subdev)
+			continue;
+
+		if (item->mtd)
+			continue;
+
+		/* Calculate the length of the name of the virtual device */
+		name_sz = 0;
+		for (idx = 0; idx < item->num_subdev; idx++)
+			name_sz += strlen(item->subdev[idx]->name) + 1;
+		name_sz += strlen(CONCAT_POSTFIX);
+
+		name = kmalloc(name_sz + 1, GFP_KERNEL);
+		if (!name) {
+			ret = -ENOMEM;
+			goto err_rollback;
+		}
+
+		offset = 0;
+		for (idx = 0; idx < item->num_subdev; idx++)
+			offset += snprintf(name + offset, name_sz + 1 - offset,
+					   "%s-", item->subdev[idx]->name);
+		snprintf(name + offset, name_sz + 1 - offset, CONCAT_POSTFIX);
+
+		mtd = mtd_concat_create(item->subdev, item->num_subdev, name);
+		if (!mtd) {
+			kfree(name);
+			ret = -ENXIO;
+			goto err_rollback;
+		}
+
+		/*
+		 * Store the pointer directly. item->subdev is no longer
+		 * needed; the concat owns its own copy of the subdev array.
+		 */
+		item->mtd = mtd;
+		kfree(item->subdev);
+		item->subdev = NULL;
+
+		/* Add the mtd device */
+		ret = add_mtd_device(item->mtd);
+		if (ret) {
+			/*
+			 * This concat was never registered; destroy it without
+			 * calling del_mtd_device().
+			 */
+			kfree(item->mtd->name);
+			mtd_virt_concat_put_mtd_devices((struct mtd_concat *)item->mtd);
+			mtd_concat_destroy(item->mtd);
+			item->mtd = NULL;
+			goto err_rollback;
+		}
+	}
+
+	return 0;
+
+err_rollback:
+	/*
+	 * Unregister and destroy all concat devices that were successfully
+	 * registered in earlier iterations, then free all tracking structures.
+	 */
+	list_for_each_entry_safe(item, tmp, &concat_node_list, head) {
+		if (item->mtd) {
+			del_mtd_device(item->mtd);
+			kfree(item->mtd->name);
+			mtd_virt_concat_put_mtd_devices((struct mtd_concat *)item->mtd);
+			mtd_concat_destroy(item->mtd);
+		} else {
+			/*
+			 * Concat was never formed: release each intercepted
+			 * slave that was withheld from add_mtd_device().
+			 */
+			mtd_virt_concat_release_subdevs(item);
+		}
+		kfree(item->nodes);
+		list_del(&item->head);
+		kfree(item);
+	}
+
+	return ret;
+}
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 3d3a84df0a6..47c68021e21 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -33,6 +33,7 @@
 #endif
 
 #include <linux/log2.h>
+#include <linux/mtd/concat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
@@ -677,6 +678,13 @@ int mtd_device_unregister(struct mtd_info *master)
 {
 	int err;
 
+	/* Destroy concat before removing partitions */
+	if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT)) {
+		err = mtd_virt_concat_destroy(master);
+		if (err)
+			return err;
+	}
+
 	err = del_mtd_partitions(master);
 	if (err)
 		return err;
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index f3b7f1ee13c..77849cd8ddb 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -27,6 +27,7 @@
 #include <linux/compat.h>
 #include <ubi_uboot.h>
 
+#include <linux/mtd/concat.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/err.h>
@@ -940,6 +941,17 @@ int add_mtd_partitions_of(struct mtd_info *master)
 		if (IS_ERR(slave))
 			return PTR_ERR(slave);
 
+		/* Intercept partitions for concat */
+		if (IS_ENABLED(CONFIG_MTD_VIRT_CONCAT)) {
+			/*
+			 * Store the DT node so that mtd_virt_concat_add() can
+			 * match this slave against the concat node list.
+			 */
+			slave->flash_node = child;
+			if (mtd_virt_concat_add(slave))
+				continue;
+		}
+
 		mutex_lock(&mtd_partitions_mutex);
 		list_add_tail(&slave->node, &master->partitions);
 		mutex_unlock(&mtd_partitions_mutex);
diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
index d46ba8e1689..876a821c7ba 100644
--- a/include/linux/mtd/concat.h
+++ b/include/linux/mtd/concat.h
@@ -33,4 +33,59 @@ struct mtd_info *mtd_concat_create(
 
 void mtd_concat_destroy(struct mtd_info *mtd);
 
-#endif
+#if IS_ENABLED(CONFIG_MTD_VIRT_CONCAT)
+
+/**
+ * mtd_virt_concat_node_create - List all concatenations found in DT
+ *
+ * Scans the device tree for nodes containing the "part-concat-next"
+ * property and creates internal tracking structures for each
+ * concatenation group. Any state from a previous scan is discarded
+ * first, including concat devices that were already registered.
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+int mtd_virt_concat_node_create(void);
+
+/**
+ * mtd_virt_concat_add - Add an MTD device to the concat list
+ * @mtd: pointer to mtd_info
+ *
+ * Checks if this MTD device's DT node matches any pending concatenation
+ * group. If so, adds it as a sub-device.
+ *
+ * Return: true if the MTD was claimed by a concat group, false otherwise.
+ */
+bool mtd_virt_concat_add(struct mtd_info *mtd);
+
+/**
+ * mtd_virt_concat_create_join - Create and register concatenated MTD devices
+ *
+ * For each concatenation group that has all its sub-devices present,
+ * creates and registers the concatenated MTD device.
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+int mtd_virt_concat_create_join(void);
+
+/**
+ * mtd_virt_concat_destroy - Destroy concat that includes a specific MTD device
+ * @mtd: pointer to mtd_info
+ *
+ * If the MTD device is part of a concatenated device, all other MTD devices
+ * within that concat are registered individually. The concatenated device
+ * is then removed.
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+int mtd_virt_concat_destroy(struct mtd_info *mtd);
+
+#else
+
+static inline int mtd_virt_concat_node_create(void) { return 0; }
+static inline bool mtd_virt_concat_add(struct mtd_info *mtd) { return false; }
+static inline int mtd_virt_concat_create_join(void) { return 0; }
+static inline int mtd_virt_concat_destroy(struct mtd_info *mtd) { return 0; }
+
+#endif /* CONFIG_MTD_VIRT_CONCAT */
+#endif /* MTD_CONCAT_H */
-- 
2.34.1

