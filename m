Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BC2C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 13:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 836DE80CC3;
	Tue, 15 Sep 2026 13:01:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bMuSe-2SGCh; Tue, 15 Sep 2026 13:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9CC7880C7A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789477267;
	b=tRIXGHlBbf8vFRPxXn8SQkXZK3fM5YZDLKCnpSx5K9C5L9o1Aqnb9M0HoRZvAH5eVV8f
	 s1pPgfzHYsvlYovGqerMgefW178Dm+yPVJxpf3nhgP2FvZZeXcGthboKtLy8kszXTM9Fy
	 9vfNqaOZ4poTfXJA7TgDMNpth47drTcePfHNqwDMtx0UORhW0rzDyOenLrdk4vp9VOpoN
	 e7VIsyn7iZcW/hKRJ+LlF2Bh9kIhgY3t5IHug03xITnjpa2ezn9133C+8T+lckLGik3Li
	 nj1Hwp6Ghdoao0Aa6eEbmvRxGwOt1yyWuo5ArgtAxxnf2jG6nFnm2sJcV+rxIK9M32Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789477267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Type:Content-Transfer-Encoding:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KXv+Kwno3TOwD50NNeFoOR7CT4ND8xAKO9tM3/+SQNc=;
	b=sYa/W8GU2ERYn8r/uh6Q0TqTPlc/zksZIYobNZ5QZSv4RzuQqFerZOnt1fNFjSdcaqwb
	 CXuLu1LGPyUMrrOSqJXb/D7OCVk4cOpHVXALI0jXt/w3mpCll5oGH4u5E+iVOd5okZPSp
	 NVkZuHB5GwKHF0f9i4KBP+UE0Z3T6tAFg9BTMv4Ki/vpMlJA3IB+o33SKqgCyPeSMV+2L
	 G9JQTZ8IvzUab0Pp7Vy1J+vjmPfpYux1+LFKC+JwHer+nvRsWF6i7wH3w96R0hwZ74R5R
	 CCDOBTaVQA7TZ/LK51r7cxabbMixBflTTYa6r9KQA9meoFoZrnuVsNRDvKqtqsL7ALQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="D/3h/97W";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789477267;
	bh=KXv+Kwno3TOwD50NNeFoOR7CT4ND8xAKO9tM3/+SQNc=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HX4MtlDxLJfke7xkVuUu4g7/sJFie8+h6hMsQgDHKsikU4XNz5sPOm0FtFoABlH6L
	 ESWglxLLsZW4nTYrH6SD7xgqVJ4OkERlEgJKRXzkDdP2ZTy1JqhzkagUETZudld8Qb
	 pS1yeBvWlhMNVyXWO5rTtNftVKliAkaMX2QoyWszyXXR0omX5iVu9pSpCSdyJpn9UO
	 JSJFBhZOfno9LLMm6CzpVVxk4E4uFGQffg2AVdK4sAEtzi2BH0IyoLOCBrKalsp2qt
	 MOEUzEexZh0cS9ZDqz6/GpeAAKLQqHdspexxRbM6DxbILC/beLbME7LjyO1VfpgXh3
	 AZs6UwC5dLoRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CC7880C7A;
	Tue, 15 Sep 2026 13:01:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8747259
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD2FA80C16
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5UQieaz0b8q2 for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 13:01:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DCCF480E4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789477264;
 b=CrDNjoSOkd0aZmmNR/bajfS3VSRTnWHiOvtdgUmeqEwEB+aWZbhZH/zue8jmzP9nV6sH
 cfnGOqa46b5NWww2qQ8rsSeXYDfi5kMSVHe2kUS4PVanpipqSCG4qrYzYARmPCBVISmw7
 L4gOyh0at7H8WKntyr04idk4fW2C+QCqURXMTpRsI7lWho4u7thOg0VV8N3X6mmoSId+Z
 XnfbyKBJ+pRIVfKq9UPCn/aWlup5WSEKqscgXB93vXxL2h4loe+330xcdBfaXJfqm/mCY
 vg6Icgc5u1E82B9rm4hnj3mO3QpPuIul50dmP22S9y+r9RVAuZXvAtGFDDp49fjsEug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789477264;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 X-Developer-Signature:X-Developer-Key:Content-Type:
 Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=KXv+Kwno3TOwD50NNeFoOR7CT4ND8xAKO9tM3/+SQNc=;
 b=espXxTx2VmO3/JPTcH8t+RHLBYytcca5HS49IhiA3JHQbR5REJz7gdGI5kGVgjCEAF26
 1fDIXaHJJBR7z/Z3HgBdeLFKYA5oROPeoiP5dCPh1n0VNTnDqL4Vws0p8Cx7Nf1AHc13s
 DjxdkmmQqYtKGQtMswe6u0d3J8y+G7UDST3wHCzAIWtXCZOdt70jm9UPHFPFaIS6f6kUi
 BRfx0P78Hau0i1cGadmDlLyojbC73YhS5tgwhwfpVKrFHLwWPopLdXjTWZ1GxEhHDpFCS
 o2JVcosRgx92yoJ2ZUvb7UiCuVy1D9nRHFokZzffq7I6YGMe8avnpx2Nq42rKVer6fQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="D/3h/97W"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=D/3h/97W
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DCCF480E4A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXJdDVgxb+1yOUk/MuR5y+rA+uWniSZiXpFoi3P4QtgzYSFAJzQaaxwkK+bQVzeHeFcu4HjqcUNkAT1tJ56uqprR8tJMwK9Ez7f+C5YY2G4RyIvVMQxAYX04mTVhgcCIeFqvvTHu/KvrzLO93+imja6gMaApey21GAcvuBQfJseSM2xdW24/SlfDAkx1gkYU86eEKsMhuOkVDGOwwYV+yEc6GvU5emMGCiE/V7GLADfDY5UTKKVdhyL+5+z1+Ry0Ww+3pd/g2iS2YnKXAD/Ub3qrGMM4Xxq8Z8Z7i1k7qaopZPKt26TLZMjpY0hqrQJzAZrlUiJMyJSmW8P5nVzCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXv+Kwno3TOwD50NNeFoOR7CT4ND8xAKO9tM3/+SQNc=;
 b=cy+YRzmGFjrOwhgIkEP5Vw10lNJySl6SpmrNO+75uS3HMEulApVDuWlD1sigVUvuBM1qcG0vthsnP7LRJ3hDEmKJLwBbpGL76yyzzQ8mx3w1mGNkQ1KnoFYYwey3YI5XimKf3fQ3/xFNBWl0BAQTWTrY+Ddo4rkzpSDCRct9hqjIB6/sFmSo/iFkrb3MC5mciawddFiqK4qTOqiN+207It78j0ik2kVfbb5XcomfBPKJoAhtpb+uB+P4aBXl9IXkwgAv0tyrouGjpFM61twmZkZQACGizhPpjM8mzTpQokiArZYOCBVOAAr1ygY0dRCX/V4aQqFmp3DdLuqGZ4e6PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXv+Kwno3TOwD50NNeFoOR7CT4ND8xAKO9tM3/+SQNc=;
 b=D/3h/97WIz/2/Ck76btuHQ0J2afwTI/fXtiZMkmX2kXHpZc+koRhPMwXFoG9vJbFTIdFhUns8nc0L2cR2K/A0ekv8CRaOJqxHsPR88gXQeZr7MbJnYcqBvP8mhJj68QN3gOsUDh8h4UCtzygd+q4R6h6W4RjZNf1X+ute3rYzLM=
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 13:00:57 +0000
Received: from SJ1PEPF000037B6.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::3d) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 13:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B6.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 13:00:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 08:00:15 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 08:00:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Andre Przywara <andre.przywara@arm.com>, Aristo Chen
 <aristo.chen@canonical.com>, Daniel Golle <daniel@makrotopia.org>, Daniel
 Schwierzeck <daniel.schwierzeck@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Hans de Goede <hdegoede@redhat.com>,
 Heiko Schocher <hs@nabladev.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier <jerome.forissier@arm.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, "moderated list:ARM STM STM32MP"
 <uboot-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2] Clean up emails from non-existing domains
Date: Tue, 15 Sep 2026 14:59:01 +0200
Message-ID: <31bafc6498b143285f2afe542d0251a896c8fafa.1789477136.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=22288; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ivbZj4NxKmMLtICfzE6IWQ4pkwyCH55rOjg6NAJ6Eio=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWStdIw4wtDM/sxIMzLp20G2eIm+ota3W86fUo5tdpo/d
 1LEDt7VHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRbTYM/8P+LNDwC/p52iT5
 Rd8hN7/OiW19z1ZwzQj0jKyRurZYQpSRYXu0S4N0R5SD9JGu0rfu1U1R7HsK8kzu7J7tbtrev3Y
 6JwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B6:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: b42edee0-c5e8-4159-8132-08df13296215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|6133799003|18002099003|13003099007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: RFe8Tgm1AsIV/ln+ipKLQICrGuWh2GcT981okmyHDZzxyXLKMNS4w8guefOCIna2ebFDsisUWXOGjSCPWO+YStr2akKvHybvmAy+8BYFMY0WMv3d0EAwUY66BPE7oKZ16/67KJGXDBYbKOCaqtJ78r/E7KAkbsNpqU3kX882CsaXk7W91B5wLLM+pW2D4gPm9Hz2USBQuqdU4gSla8iIT8T4qWSsTuvKmjrCsS9u0npoOPOosF34H4r6b0ftFQmy3CpVd/4DOOJcGBN4+ABobN6KbitNywhPZ0JfCbasJNNmCWcs1876XwcALfIqcRrqw4f67kSohH2y3T75htlXl/1B8eyIcYvS491jTVwUkhkNC9aT0o10cN7aG2X2mbhDkH+9Ms6aIba/zPYLeRxKc+2w2wDmE2gbWqjVDdAfoVpbTzZONSvo5KOxNqWwzpgX2zdUYAlFdtWg6GT0XbDoKKCv9ifQz4mSZl2eIgJx1HGvHT279WzdAhPoog7OsvHxFkTejRn4aPiy14nmav/CFvQOuarj8438eDqAvWxibfdy5v42HEkoxZQT4B0bg3/n0idfysHV1zCos1FqTtQobGp7G+jwgpgZtUi/z1gkg9sZbOq8yoNVHgMzGjwknG2eKLyPOdn4NFA7IuOJmbhsfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(13003099007)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 80a6gjQS2WpxlHZEmjHnyG0fQjXAj1hio1s95RZXGtLlI4mQelFLTdaSc9BKLoxmKE8My0LNRTkCcD+4/rv4qtv7kMHEFOeDdEHJbNqkiuDN0l63EdFhimYJsfaUKJ94KJNHrE2CQt5Id/gyW39HtaTPcH3vhi5sgTE5xS0Sd2XZrblGHXUKtpqbUtsqB64Z+K1KKD+fln0GI4Qn7HNrPJR6VtMnD9qOWtcVwMngaE3MWluGaYRbozYZlnTRh9VGYbdXkpkKgAzB2KYY7c/Mp3PZsq9zzo894X3Fu9VIHE8lQvsqhig0r+4+VWo+nTJll6ckmE4RGKfcx0CEc56zDm6x3EQ6qlacaWo7GY8o90kUzDQOXPymm/G7WketQ5XWyGRNe/yh8lCbqBS7gbQx3+Hbxf4MfAz9WlpEF2tk5zaKB7dP2B2at2T15GD5yk1s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:00:56.8806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b42edee0-c5e8-4159-8132-08df13296215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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

There are 5 domains which no longer exist. Remove all email addresses that
reference them. Where such an address was the board's only maintainer, mark
the board as Orphan.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- remove rosinson.com
- skip Angelo's email which was fixed

This was the way how to find if domain doesn't exist.

git ls-files '*MAINTAINERS' 'MAINTAINERS' \
  | xargs grep -hoE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' \
  | sed 's/.*@//' | tr 'A-Z' 'a-z' | sort -u \
  | while IFS= read -r dom; do
      if [ -z "$(dig +short MX "$dom")" ] && [ -z "$(dig +short A "$dom")" ]; then
        echo "$dom"
      fi
    done

---
 MAINTAINERS                                          | 1 -
 arch/arm/dts/sun9i-a80-cx-a99.dts                    | 2 +-
 arch/arm/include/asm/arch-lpc32xx/gpio.h             | 2 +-
 arch/arm/include/asm/arch-lpc32xx/mux.h              | 2 +-
 arch/arm/mach-lpc32xx/dram.c                         | 2 +-
 arch/arm/mach-lpc32xx/lowlevel_init.S                | 2 +-
 arch/mips/dts/ap152.dts                              | 2 +-
 arch/mips/dts/qca956x.dtsi                           | 2 +-
 arch/mips/mach-ath79/include/mach/ath79.h            | 2 +-
 arch/mips/mach-ath79/qca956x/clk.c                   | 2 +-
 arch/mips/mach-ath79/qca956x/cpu.c                   | 2 +-
 arch/mips/mach-ath79/qca956x/ddr.c                   | 2 +-
 arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S       | 2 +-
 arch/mips/mach-ath79/reset.c                         | 2 +-
 board/embest/mx6boards/MAINTAINERS                   | 3 +--
 board/embest/mx6boards/mx6boards.c                   | 2 +-
 board/phytec/pcm052/MAINTAINERS                      | 3 +--
 board/qca/ap152/MAINTAINERS                          | 2 +-
 board/qca/ap152/ap152.c                              | 2 +-
 board/sunxi/MAINTAINERS                              | 3 +--
 board/work-microwave/work_92105/MAINTAINERS          | 3 +--
 board/work-microwave/work_92105/Makefile             | 2 +-
 board/work-microwave/work_92105/work_92105.c         | 2 +-
 board/work-microwave/work_92105/work_92105_display.c | 2 +-
 board/work-microwave/work_92105/work_92105_display.h | 2 +-
 board/work-microwave/work_92105/work_92105_spl.c     | 2 +-
 cmd/dfu.c                                            | 2 +-
 cmd/gpt.c                                            | 2 +-
 common/dfu.c                                         | 2 +-
 doc/README.dfutftp                                   | 2 +-
 drivers/dfu/dfu_alt.c                                | 2 +-
 drivers/gpio/lpc32xx_gpio.c                          | 2 +-
 drivers/i2c/lpc32xx_i2c.c                            | 2 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c              | 2 +-
 drivers/net/ag7xxx.c                                 | 2 +-
 drivers/usb/host/ohci-hcd.c                          | 2 +-
 include/configs/ap152.h                              | 2 +-
 include/configs/bk4r1.h                              | 2 +-
 include/configs/embestmx6boards.h                    | 2 +-
 include/configs/work_92105.h                         | 2 +-
 scripts/get_default_envs.sh                          | 2 +-
 tools/lpc32xximage.c                                 | 2 +-
 tools/vybridimage.c                                  | 2 +-
 43 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5a2913ba48c8..79d4e8de85aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1360,7 +1360,6 @@ S:	Maintained
 F:	drivers/net/phy/nxp-c45-tja11xx.c
 
 ONENAND
-#M:	Lukasz Majewski <l.majewski@majess.pl>
 S:	Orphan (Since 2017-01)
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-onenand.git
 F:	drivers/mtd/onenand/
diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a80-cx-a99.dts
index cf126bbd2c57..0642161ec969 100644
--- a/arch/arm/dts/sun9i-a80-cx-a99.dts
+++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
@@ -1,7 +1,7 @@
 /*
  * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
  *
- * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
+ * Copyright (C) 2017 Rask Ingemann Lambertsen
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
diff --git a/arch/arm/include/asm/arch-lpc32xx/gpio.h b/arch/arm/include/asm/arch-lpc32xx/gpio.h
index 93e7a8875215..103c0219c194 100644
--- a/arch/arm/include/asm/arch-lpc32xx/gpio.h
+++ b/arch/arm/include/asm/arch-lpc32xx/gpio.h
@@ -3,7 +3,7 @@
  * LPC32xx GPIO interface
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 /**
diff --git a/arch/arm/include/asm/arch-lpc32xx/mux.h b/arch/arm/include/asm/arch-lpc32xx/mux.h
index d661e8236f32..ec69a5da2feb 100644
--- a/arch/arm/include/asm/arch-lpc32xx/mux.h
+++ b/arch/arm/include/asm/arch-lpc32xx/mux.h
@@ -3,7 +3,7 @@
  * LPC32xx MUX interface
  *
  * (C) Copyright 2015  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 /**
diff --git a/arch/arm/mach-lpc32xx/dram.c b/arch/arm/mach-lpc32xx/dram.c
index ab7c13512a5a..a311455cd4d7 100644
--- a/arch/arm/mach-lpc32xx/dram.c
+++ b/arch/arm/mach-lpc32xx/dram.c
@@ -3,7 +3,7 @@
  * LPC32xx dram init
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  *
  * This is called by SPL to gain access to the SDR DRAM.
  *
diff --git a/arch/arm/mach-lpc32xx/lowlevel_init.S b/arch/arm/mach-lpc32xx/lowlevel_init.S
index d42da2bc5672..55c47c5a433b 100644
--- a/arch/arm/mach-lpc32xx/lowlevel_init.S
+++ b/arch/arm/mach-lpc32xx/lowlevel_init.S
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board low level init
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  *
  * Low level init is called from SPL to set up the clocks.
  * On entry, the LPC3250 is in Direct Run mode with all clocks
diff --git a/arch/mips/dts/ap152.dts b/arch/mips/dts/ap152.dts
index 1722290c731a..d0812a394817 100644
--- a/arch/mips/dts/ap152.dts
+++ b/arch/mips/dts/ap152.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2018 Rosy Song
  */
 
 /dts-v1/;
diff --git a/arch/mips/dts/qca956x.dtsi b/arch/mips/dts/qca956x.dtsi
index 6cb360b3f860..a7a358bb854b 100644
--- a/arch/mips/dts/qca956x.dtsi
+++ b/arch/mips/dts/qca956x.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2018 Rosy Song
  */
 
 #include "skeleton.dtsi"
diff --git a/arch/mips/mach-ath79/include/mach/ath79.h b/arch/mips/mach-ath79/include/mach/ath79.h
index 2eda38885e36..8d65d05bd45f 100644
--- a/arch/mips/mach-ath79/include/mach/ath79.h
+++ b/arch/mips/mach-ath79/include/mach/ath79.h
@@ -2,7 +2,7 @@
 /*
  * Atheros AR71XX/AR724X/AR913X common definitions
  *
- * Copyright (C) 2018-2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2018-2019 Rosy Song
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
diff --git a/arch/mips/mach-ath79/qca956x/clk.c b/arch/mips/mach-ath79/qca956x/clk.c
index 6138a915efcd..84be2e485715 100644
--- a/arch/mips/mach-ath79/qca956x/clk.c
+++ b/arch/mips/mach-ath79/qca956x/clk.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2019 Rosy Song
  */
 
 #include <clock_legacy.h>
diff --git a/arch/mips/mach-ath79/qca956x/cpu.c b/arch/mips/mach-ath79/qca956x/cpu.c
index 7da8d0e60f19..01c850b8df3d 100644
--- a/arch/mips/mach-ath79/qca956x/cpu.c
+++ b/arch/mips/mach-ath79/qca956x/cpu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2019 Rosy Song
  */
 
 /* The lowlevel_init() is not needed on QCA956X */
diff --git a/arch/mips/mach-ath79/qca956x/ddr.c b/arch/mips/mach-ath79/qca956x/ddr.c
index 754e2573e37d..462fc87b5a23 100644
--- a/arch/mips/mach-ath79/qca956x/ddr.c
+++ b/arch/mips/mach-ath79/qca956x/ddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2019 Rosy Song
  *
  * Based on QSDK
  */
diff --git a/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S b/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S
index db54b575fbc9..621c9529dcc3 100644
--- a/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S
+++ b/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2019 Rosy Song
  *
  * Based on QSDK
  */
diff --git a/arch/mips/mach-ath79/reset.c b/arch/mips/mach-ath79/reset.c
index 62da8b92a7d4..5748b36d535f 100644
--- a/arch/mips/mach-ath79/reset.c
+++ b/arch/mips/mach-ath79/reset.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
- * Copyright (C) 2018-2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2018-2019 Rosy Song
  */
 
 #include <linux/bitops.h>
diff --git a/board/embest/mx6boards/MAINTAINERS b/board/embest/mx6boards/MAINTAINERS
index 0ffd4668b42d..6c9d590c4b77 100644
--- a/board/embest/mx6boards/MAINTAINERS
+++ b/board/embest/mx6boards/MAINTAINERS
@@ -1,6 +1,5 @@
 MX6BOARDS BOARD
-M:	Eric Bénard <eric@eukrea.com>
-S:	Maintained
+S:	Orphan
 F:	board/embest/mx6boards/
 F:	include/configs/embestmx6boards.h
 F:	configs/marsboard_defconfig
diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
index 5ed41d01d9ba..0269259269e5 100644
--- a/board/embest/mx6boards/mx6boards.c
+++ b/board/embest/mx6boards/mx6boards.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2014 Eukréa Electromatique
- * Author: Eric Bénard <eric@eukrea.com>
+ * Author: Eric Bénard
  *         Fabio Estevam <fabio.estevam@freescale.com>
  *         Jon Nettleton <jon.nettleton@gmail.com>
  *
diff --git a/board/phytec/pcm052/MAINTAINERS b/board/phytec/pcm052/MAINTAINERS
index 66fe06e49c0b..4883e2ff4d6e 100644
--- a/board/phytec/pcm052/MAINTAINERS
+++ b/board/phytec/pcm052/MAINTAINERS
@@ -1,6 +1,5 @@
 PCM052 BOARD
-M:	Albert ARIBAUD (3ADEV) <albert.aribaud@3adev.fr>
-S:	Maintained
+S:	Orphan
 F:	board/phytec/pcm052/
 F:	include/configs/bk4r1.h
 F:	include/configs/pcm052.h
diff --git a/board/qca/ap152/MAINTAINERS b/board/qca/ap152/MAINTAINERS
index 785ec2766d16..aef8207010c1 100644
--- a/board/qca/ap152/MAINTAINERS
+++ b/board/qca/ap152/MAINTAINERS
@@ -1,5 +1,5 @@
 AP152 BOARD
-M:	Rosy Song <rosysong@rosinson.com>
+M:	Rosy Song
 S:	Maintained
 F:	board/qca/ap152/
 F:	include/configs/ap152.h
diff --git a/board/qca/ap152/ap152.c b/board/qca/ap152/ap152.c
index 53587288c939..0647656c4300 100644
--- a/board/qca/ap152/ap152.c
+++ b/board/qca/ap152/ap152.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2018 Rosy Song
  */
 
 #include <init.h>
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index df745f146494..1291fb3ab7aa 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -572,8 +572,7 @@ S:	Maintained
 F:	configs/sopine_baseboard_defconfig
 
 SUNCHIP CX-A99 BOARD
-M:	Rask Ingemann Lambertsen <rask@formelder.dk>
-S:	Maintained
+S:	Orphan
 F:	configs/Sunchip_CX-A99_defconfig
 W:	https://linux-sunxi.org/Sunchip_CX-A99
 
diff --git a/board/work-microwave/work_92105/MAINTAINERS b/board/work-microwave/work_92105/MAINTAINERS
index 29a92c5ffe26..e81a90cb7be9 100644
--- a/board/work-microwave/work_92105/MAINTAINERS
+++ b/board/work-microwave/work_92105/MAINTAINERS
@@ -1,6 +1,5 @@
 WORK_92105 BOARD
-M:	Albert ARIBAUD <albert.aribaud@3adev.fr>
-S:	Maintained
+S:	Orphan
 F:	board/work-microwave/work_92105/
 F:	include/configs/work_92105.h
 F:	configs/work_92105_defconfig
diff --git a/board/work-microwave/work_92105/Makefile b/board/work-microwave/work_92105/Makefile
index a96098d0f2a5..e63901a0c2b1 100644
--- a/board/work-microwave/work_92105/Makefile
+++ b/board/work-microwave/work_92105/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2014  DENX Software Engineering GmbH
-# Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+# Written-by: Albert ARIBAUD
 
 ifdef CONFIG_XPL_BUILD
 obj-y	+= work_92105_spl.o
diff --git a/board/work-microwave/work_92105/work_92105.c b/board/work-microwave/work_92105/work_92105.c
index 9a236880e3cc..641c1cd0e6fa 100644
--- a/board/work-microwave/work_92105/work_92105.c
+++ b/board/work-microwave/work_92105/work_92105.c
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board support
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 #include <config.h>
diff --git a/board/work-microwave/work_92105/work_92105_display.c b/board/work-microwave/work_92105/work_92105_display.c
index d4ab2299895d..0cc4272e8841 100644
--- a/board/work-microwave/work_92105/work_92105_display.c
+++ b/board/work-microwave/work_92105/work_92105_display.c
@@ -3,7 +3,7 @@
  * work_92105 display support
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  *
  * The work_92105 display is a HD44780-compatible module
  * controlled through a MAX6957AAX SPI port expander, two
diff --git a/board/work-microwave/work_92105/work_92105_display.h b/board/work-microwave/work_92105/work_92105_display.h
index 17a9aa04e022..be67d929c750 100644
--- a/board/work-microwave/work_92105/work_92105_display.h
+++ b/board/work-microwave/work_92105/work_92105_display.h
@@ -3,7 +3,7 @@
  * work_92105 display support interface
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  *
  * The work_92105 display is a HD44780-compatible module
  * controlled through a MAX6957AAX SPI port expander, two
diff --git a/board/work-microwave/work_92105/work_92105_spl.c b/board/work-microwave/work_92105/work_92105_spl.c
index 3f91221ce8b1..bc841e979b18 100644
--- a/board/work-microwave/work_92105/work_92105_spl.c
+++ b/board/work-microwave/work_92105/work_92105_spl.c
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board support
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 #include <asm/io.h>
diff --git a/cmd/dfu.c b/cmd/dfu.c
index 46f0190588e0..b571137c1aa9 100644
--- a/cmd/dfu.c
+++ b/cmd/dfu.c
@@ -3,7 +3,7 @@
  * cmd_dfu.c -- dfu command
  *
  * Copyright (C) 2015
- * Lukasz Majewski <l.majewski@majess.pl>
+ * Lukasz Majewski
  *
  * Copyright (C) 2012 Samsung Electronics
  * authors: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
diff --git a/cmd/gpt.c b/cmd/gpt.c
index 205f696c8072..abbfc0fe46ae 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -3,7 +3,7 @@
  * cmd_gpt.c -- GPT (GUID Partition Table) handling command
  *
  * Copyright (C) 2015
- * Lukasz Majewski <l.majewski@majess.pl>
+ * Lukasz Majewski
  *
  * Copyright (C) 2012 Samsung Electronics
  * author: Lukasz Majewski <l.majewski@samsung.com>
diff --git a/common/dfu.c b/common/dfu.c
index 1af8194139c3..341fd7ca7812 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -3,7 +3,7 @@
  * dfu.c -- dfu command
  *
  * Copyright (C) 2015
- * Lukasz Majewski <l.majewski@majess.pl>
+ * Lukasz Majewski
  *
  * Copyright (C) 2012 Samsung Electronics
  * authors: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
diff --git a/doc/README.dfutftp b/doc/README.dfutftp
index b25f398ee2e0..184dec50f975 100644
--- a/doc/README.dfutftp
+++ b/doc/README.dfutftp
@@ -2,7 +2,7 @@
 #
 #  Copyright (C) 2015
 #
-#  Lukasz Majewski <l.majewski@majess.pl>
+#  Lukasz Majewski
 
 Device Firmware Upgrade (DFU) - extension to use TFTP
 =====================================================
diff --git a/drivers/dfu/dfu_alt.c b/drivers/dfu/dfu_alt.c
index e9132936a90b..8d2e85856e5d 100644
--- a/drivers/dfu/dfu_alt.c
+++ b/drivers/dfu/dfu_alt.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015
- * Lukasz Majewski <l.majewski@majess.pl>
+ * Lukasz Majewski
  */
 
 #include <log.h>
diff --git a/drivers/gpio/lpc32xx_gpio.c b/drivers/gpio/lpc32xx_gpio.c
index 2b537e007ba9..9c35f45d5487 100644
--- a/drivers/gpio/lpc32xx_gpio.c
+++ b/drivers/gpio/lpc32xx_gpio.c
@@ -3,7 +3,7 @@
  * LPC32xxGPIO driver
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 #include <asm/io.h>
diff --git a/drivers/i2c/lpc32xx_i2c.c b/drivers/i2c/lpc32xx_i2c.c
index a4e42e64a9b8..31fdea7c4054 100644
--- a/drivers/i2c/lpc32xx_i2c.c
+++ b/drivers/i2c/lpc32xx_i2c.c
@@ -3,7 +3,7 @@
  * LPC32xx I2C interface driver
  *
  * (C) Copyright 2014-2015  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD - 3ADEV <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD - 3ADEV
  */
 
 #include <config.h>
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index 7779e63fa5d1..d9b05aa42fbc 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -3,7 +3,7 @@
  * LPC32xx MLC NAND flash controller driver
  *
  * (C) Copyright 2014 3ADEV <http://3adev.com>
- * Written by Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written by Albert ARIBAUD
  *
  * NOTE:
  *
diff --git a/drivers/net/ag7xxx.c b/drivers/net/ag7xxx.c
index 059a65d46610..5c853fdded08 100644
--- a/drivers/net/ag7xxx.c
+++ b/drivers/net/ag7xxx.c
@@ -3,7 +3,7 @@
  * Atheros AR71xx / AR9xxx GMAC driver
  *
  * Copyright (C) 2016 Marek Vasut <marex@denx.de>
- * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2019 Rosy Song
  */
 
 #include <clock_legacy.h>
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 3fcf9d53d598..761da36acb23 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -16,7 +16,7 @@
  * (C) Copyright 2000-2002 David Brownell
  *
  * Modified for the MP2USB by (C) Copyright 2005 Eric Benard
- * ebenard@eukrea.com - based on s3c24x0's driver
+ * based on s3c24x0's driver
  */
 /*
  * IMPORTANT NOTES
diff --git a/include/configs/ap152.h b/include/configs/ap152.h
index c56b35150a5f..efc281bd18c1 100644
--- a/include/configs/ap152.h
+++ b/include/configs/ap152.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
+ * Copyright (C) 2018 Rosy Song
  */
 
 #ifndef __CONFIG_H
diff --git a/include/configs/bk4r1.h b/include/configs/bk4r1.h
index 4a0b9edf4579..ba81c04eee55 100644
--- a/include/configs/bk4r1.h
+++ b/include/configs/bk4r1.h
@@ -4,7 +4,7 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  *
  * Copyright 2016 3ADEV <http://3adev.com>
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  *
  * Configuration settings for BK4R1.
  */
diff --git a/include/configs/embestmx6boards.h b/include/configs/embestmx6boards.h
index 61c0d755a8d9..1d398a4e4a02 100644
--- a/include/configs/embestmx6boards.h
+++ b/include/configs/embestmx6boards.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2014 Eukréa Electromatique
- * Author: Eric Bénard <eric@eukrea.com>
+ * Author: Eric Bénard
  *
  * Configuration settings for the Embest RIoTboard
  *
diff --git a/include/configs/work_92105.h b/include/configs/work_92105.h
index f1a7853a80e6..6c4f57f61b5c 100644
--- a/include/configs/work_92105.h
+++ b/include/configs/work_92105.h
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board configuration file
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 #ifndef __CONFIG_WORK_92105_H__
diff --git a/scripts/get_default_envs.sh b/scripts/get_default_envs.sh
index fedf7206fe12..b2432bb88d28 100755
--- a/scripts/get_default_envs.sh
+++ b/scripts/get_default_envs.sh
@@ -1,7 +1,7 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2016, Lukasz Majewski <l.majewski@majess.pl>
+# Copyright (C) 2016, Lukasz Majewski
 #
 
 # This file extracts default envs from built u-boot
diff --git a/tools/lpc32xximage.c b/tools/lpc32xximage.c
index 715a55a5b5b3..52e96bb3df42 100644
--- a/tools/lpc32xximage.c
+++ b/tools/lpc32xximage.c
@@ -3,7 +3,7 @@
  * Image manipulator for LPC32XX SoCs
  *
  * (C) Copyright 2015  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  *
  * Derived from omapimage.c:
  *
diff --git a/tools/vybridimage.c b/tools/vybridimage.c
index c38886fa9039..7177e78d74c2 100644
--- a/tools/vybridimage.c
+++ b/tools/vybridimage.c
@@ -5,7 +5,7 @@
  * Derived from vybridimage.c
  *
  * (C) Copyright 2016  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
+ * Written-by: Albert ARIBAUD
  */
 
 #include "imagetool.h"
---
On the top of http://lore.kernel.org/r/20260910200310.3503830-2-trini@konsulko.com

-- 
2.43.0

