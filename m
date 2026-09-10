Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62999C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D37940A6E;
	Thu, 10 Sep 2026 12:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAeBdOAwdhog; Thu, 10 Sep 2026 12:17:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1350540A61
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789042649;
	b=tUEpMX3em+LlhS7Jyj9G56UXVODmnsLjSbn/BN/JAUlHyHn+1jUSnofC1SNPDx/qvT6Q
	 QIspHDK21IgnNf/ZA7u3Oovuax2c/e0L+lVV2l2bdVDKUq7hEIw2y1Mzln7ZTOcOdzlEj
	 toNjTgpY1VswUbCuDGGursBHV4siGnPqhOU4gumuGA9pn7zzCdgmyJnTSoXogw7TLVSIB
	 A25bzyM/PPGeEafiBzJgh5AX8rTelG1fypvF17+IAhSRejbh88OFm3UEfAHUFIa5ZSd+5
	 wtedhYJOHSh4sdEF6S3uHOjYXhTObT0VxsnKzdDA4ML60121mip5xMzbSrs880zz4+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
	bh=hM8R3d/i0e7jltGY46gJk2RzS04c4/DvQmm9H/pBCXE=;
	b=ARHUCRyvbf1r/QrLGztZmDa6+qIkt9+e0FGbRZlxe+x4+SLgWb368QuCAuCDA+lXR9/W
	 tP/nWOOXZDLHhGX+s6pGz2deCS7ceNdqiI3htG8seim3j/IWMC72gwbi7boKzexXAtIgH
	 a4Umf5Hruw/AQqCT7M8IAtr6PoeJKrp+KPui+Q26o6ihNtEeeArYDVIIqZOgGRqmV6Yfk
	 lwM5ZPHDZT4eukRU789EOIPsOKdJqIzKCA8nKRKqT9+sqZuAZG99+N1mSSUANxOMWwAMi
	 /HgdrXNTPZVA5xAvzFaEzvaw4y7OdSxaAgGTR4Ecqlqm2bYVvFzME7LiqzlyPfsA1Xg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042649;
	bh=hM8R3d/i0e7jltGY46gJk2RzS04c4/DvQmm9H/pBCXE=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0HZq/Jx94OwIPCFKiqFuZhmlBZHdHcRDlHKnX91ommlLEPsh50w1HBnOj0Cp0vlm4
	 Y9xfD4tBmQ1BNcMxtF7Cv6FavV5kl4xbBQ2AzLZrgnzRlGtgR28mFcr/YAQVdaiUL8
	 WgGjzH2ziOUOJPKrx9wDCTtXALKCOsuRDlqY9leZaRjuo+aD71lN2ev7GJ+dLULWwD
	 Unj1oLVwfqPd7mgp6uJ2rfycj8qGQzp2eYHcyRm9d+hMdUPasNYqAC3rFkj71W7YKm
	 IuC5L6otoy1jTB1W6hJcK9EACl7VzklazL9kFbc/GkFy8vhdOcxcPo7CDb8nLE3XdG
	 keuHBFvbIiL4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1350540A61;
	Thu, 10 Sep 2026 12:17:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1791C268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:17:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F12ED80F84
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBmVMTjDBFqo for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 12:17:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7A3CC80F79
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042645;
 b=rIhn8JY/MNdkqGl5YDz0gEi4rQ3FMdNfRBY34M/f0SJ5SyEKUC6miOHBGxsHwrxAqMx1
 KYUxTkkPUD3q29nA3QvEr2LQS2NrIAWAsxa7UIdTtt6kQYTVcJ5fP47uygzSSc71xYAYW
 BrIidSKv2MFP1Xpyv3d/OLCEf8vdfOEMdhn1wIV8V3bpBb7mf3ZgbOmUHknUXAkpgkLzc
 90vaz2WCaZjx6m1BnJ37pVUx9bRkDHNagLph8xONJBlkPNEcdCJsxaWCYxF/qEr8Yv3hj
 VU+Uk9NyA1Jj0nQDADyzaV9m0dkLvv9+q1p2AxehSD8vGef77Qd+OnSrohSs0z6z75A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789042645;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=hM8R3d/i0e7jltGY46gJk2RzS04c4/DvQmm9H/pBCXE=;
 b=POEWTzSuaFiA8K88n1uD/304NeQ2Hk0fkfEBA/QVRzAbdA2mXhRxpyNqe4/bXP/cFj3I
 mT1i7eHjdeZS35q1c4C9gWqPtkWtZf6kZt9SlWr0RbtjgFBy16kA1YobDBwVqIVJmhFRh
 wjiZRY9G/+JuV3lcYCPs7CVcXmbnQBX8zEpKX6I86SwDnQaR8qhYmOGMHVdU1qzv1W1gO
 IBy4BafQJp2/32flHvaJm8XyHeqeeaaBKtDA+B4L/sU0t5NwwRDAwNGti7qVlu+IqBqUg
 OMZ3LUXYpUR/rTHM0y99TJcWWLNtyuKZVbZeg+P2Ytby1mnG/oJJIT5AICFYUJuWXLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oH9sMmGC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oH9sMmGC
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A3CC80F79
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 12:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMUkK5eR19aOJip5USPSBxh1Uo8hyGahJDEf5aI8F6Su3G1TFHBWxjhvY9L5/Jq7yj2nSUm11EKOsyOhwwY6eRIFs9c7YyitoGjWKkJanW5ewPsERO5KfcF9M0ONRQR+57Q0/haxUj+EBZtEZvo1H09wx/WvS/oFMbGdT4F6SrgEKTnrxwwf+jyAiYFKrPQlSq7uitmjm10a5IuDEO4izdXlNPP+7BnYwB97hhkKpRi99OZPUGYzmEdR82KpI+AZnm4ZgCC2nzTsP+Wt9MM0Fl9wPh3SRUke3+YJTNZVQkZtcI4A4R/pNYo9nGWsUBPiJyW6sIV8rSQdKuIgeA+YYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM8R3d/i0e7jltGY46gJk2RzS04c4/DvQmm9H/pBCXE=;
 b=L3y7NsYvLGtJ6DfgXVu/FrI9N5HX34aq3a3hZJvM9c8IyMlYK98xz8bmDoyhlPGkIv/H/wPFj+XCrjKqvRC2SGXwj3hV1eSP9XpEICN868rbABtcPrf/sHHupJGXO6GusMDCf5b3e4rWL5gY6TBx+7mpEGNclcicwDLZQj4Xs7KajCji+fyPJ8iwPriDrZgyHjiJpaWEE3VbjLIkGXqJPgqEmtrPRssyt4cBLlR569WnicxTjkT8AhfglX1adgH/s7m2MUSvLig36RhIJKSeB/9Ut1VJKMuIIXz2Wlh8Ij+UBQErYG3DD5hPMXtPI54Di45Pjhm4VS49uHHFjBHqeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM8R3d/i0e7jltGY46gJk2RzS04c4/DvQmm9H/pBCXE=;
 b=oH9sMmGCwyREDAsONX+xKliQaQ+K2r4xafLI9jFmB+Q0k46gS5z3F/1xmtZRhLxmKFz+3nMrqYzxdfidlFkqX+6TnjpNy5wBZje0vGcF8OcDcyFUaEO/C1dpej2SEmWKN0aeKLj+V+kDZCcXZG2oIHR+alZ4fS9dzVV8C9l3Czw=
Received: from BL1PR13CA0427.namprd13.prod.outlook.com (2603:10b6:208:2c3::12)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 12:17:17 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1d) by BL1PR13CA0427.outlook.office365.com
 (2603:10b6:208:2c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 12:17:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Thu, 10 Sep 2026 12:17:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 07:17:15 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 07:17:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Akshay Belsare <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] firmware: zynqmp: Reduce CONFIG_ZYNQMP_IPI dependency scope
Date: Thu, 10 Sep 2026 14:17:05 +0200
Message-ID: <3d6ae0bf41bbab265dccf1db4475a199f78298dc.1789042623.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7612; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Rz1GRrHGvpQ8msBR3wdYwP7dc0GE5Dgpb/N/bAgBWT8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQtmn+C67vCI0+RWbZrOFiCNmYsVp5S/edEwHG/r/PrP
 rn9Si/a11HKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATWbyM4Z9u2hPT+QZu8T9M
 ilc1XBZfPLX72dqM5+GBU073LPs0vXonw//85CX133L2VyxlS8jIWaPecafRvKXEoP6H4+QU6eU
 ZnTwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: bf39303f-0c45-4556-9954-08df0f35749f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|10067099003|6133799003|18002099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: IXyLaPEt7ilk+CiuEhv7Gd5ose853JWjP+arRyNZPgQfozHdu1TOgYZ1dk6wyfSZ/Bc4loPhGj+UQzYYI2T4mU2/GRQqDJyM0EcstKgMwu0vQDzSQpYcf11H2cFxY+NJyqh2Q2gE+QbthUJ/ta4cKxt/DnHNQcvaXpCET8itPnLDM+r9Rma9OVCdSFdRcljf6IiddkGO+7HpD/CHhfXMtRrt6s9s215vJ7hBYAJDCBdEgQLlddEF/xZI+7zRoY5QPV/sqkZYegUTSAAf3SjHnUh6qzyNFnuSHTWHVYUAGvZId+y4XwChGZoAwZ7NgjHbsqWq0Tjfs6tewFBUvG5YKTlqjYcWfZDbwWcHdXsT4SbwTI/mzKiiIiGfHa+CM3d4zm6yPbdg7cAV6ngisNyMCP3p/k0d/0qOQzcLKLrkAxlQgwLvQox2ddaTX95B2MtRi1qRKsyi1ieiNdP0bFVnJhgLD39kChAF/Fmq6U4LBqDVNDjhCuOs8XZChkEqmFL5uq+gKa48gx2666TbM9JwKCaMTfKarko6E2VObenJF2OcMRo31gYjcwo9QvNhDZS7rOE8IHHz3l/nzv0X5UUDQ7XX50yulV/DrpKoTbJazRI88cKNY0WG37ThMZPNr5gu08IQ/UYMeJk429zLhrtCjOPDC54NuXI9hSCyWv40kPW0a4hH2fQ7J9n2APRVkTcZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(10067099003)(6133799003)(18002099003)(56012099006)(5023799004)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dPzmUpoBWs5MmopPp019upEP2/0fUrmtzFLqtqf6CQzn0ZiJ+SsbQsYSkSnpfBcDdfhPFShBZzbbFUtLq3S81Qh2FqWZfzAKDCWtBXr/vlvXa4hlVRlYRHwplUz54RnAqoLvem8cItgrQ/J35iyTRAFUVb7kV7vAmkLQiZSurfwPEp7JcDTmKyifafM9U3hkR/rqnVUzxjjavt0nNuvUM/bWwoEPCkmnqmrTqZwB7IwpsinvRqiG+OUG4w9sEJjlgJLARRfUUDickuGG7+qq/7JrxeaRHjpMLeZY3IBeAFMZDECRXVRzkOyejF/RKHVfLstSy69ZI9XEKBWp3UiBnVe2KHYnAha3H0V04tOfFG1NUP6PPgeimEuRgzLJjsOrVn7bmEMS19JYf1lekpSUAMfE/ygZZF31HS2IiR2lPuN5aaTtngC/ZGCSiPOeteMU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 12:17:17.3725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39303f-0c45-4556-9954-08df0f35749f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186
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

The CONFIG_ZYNQMP_IPI #ifdef used to guard a large portion of the file,
including the generic firmware/PM helpers such as
zynqmp_firmware_version(), zynqmp_pm_reset_assert(),
xilinx_pm_get_chipid() and the whole Versal/Versal NET/Versal Gen 2 PM
API. Those functions only rely on xilinx_pm_request() (SMC based) and
have nothing to do with the IPI mailbox transport. Because they were
compiled out when CONFIG_ZYNQMP_IPI was disabled, the Versal family
could not be built without it - for example reset-zynqmp.c failed to
link with an undefined reference to zynqmp_pm_reset_assert().

Move the only code that genuinely needs the mailbox/IPI channel, namely
zynqmp_pmufw_load_config_object() and the zynqmp_power device probe and
driver, right after ipi_req() and close the #if there. This narrows the
CONFIG_ZYNQMP_IPI guard to the mailbox transport code only and leaves
the generic PM helpers always compiled in.

With this change the Xilinx/AMD arm64 Versal, Versal NET and Versal
Gen 2 platforms can be built both with and without CONFIG_ZYNQMP_IPI.
This is pure code motion, so there is no functional change and no size
impact for configurations that enable CONFIG_ZYNQMP_IPI.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/firmware-zynqmp.c | 200 ++++++++++++++---------------
 1 file changed, 100 insertions(+), 100 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index ef1852cc35df..27bea8b18579 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -148,6 +148,106 @@ static int ipi_req(const u32 *req, size_t req_len, u32 *res, size_t res_maxlen)
 	return ret;
 }
 
+/**
+ * Send a configuration object to the PMU firmware.
+ *
+ * @cfg_obj: Pointer to the configuration object
+ * @size:    Size of @cfg_obj in bytes
+ * Return:   0 on success otherwise negative errno.
+ */
+int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
+{
+	int err;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
+		printf("Loading new PMUFW cfg obj (%ld bytes)\n", size);
+
+	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
+
+	err = xilinx_pm_request(PM_SET_CONFIGURATION, (u32)(u64)cfg_obj, 0, 0,
+				0, 0, 0, ret_payload);
+	if (err == XST_PM_NO_ACCESS) {
+		return -EACCES;
+	}
+
+	if (err == XST_PM_ALREADY_CONFIGURED) {
+		debug("PMUFW Node is already configured\n");
+		return -ENODEV;
+	}
+
+	if (err)
+		printf("Cannot load PMUFW configuration object (%d)\n", err);
+
+	if (ret_payload[0])
+		printf("PMUFW returned 0x%08x status!\n", ret_payload[0]);
+
+	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_XPL_BUILD))
+		panic("PMUFW config object loading failed in EL3\n");
+
+	return 0;
+}
+
+static int zynqmp_power_probe(struct udevice *dev)
+{
+	struct udevice *ipi_dev;
+	ofnode ipi_node;
+	int ret;
+
+	debug("%s, (dev=%p)\n", __func__, dev);
+
+	/*
+	 * Probe all IPI parent node driver. It is important to have IPI
+	 * devices available when requested by mbox_get_by* API.
+	 * If IPI device isn't available, then mailbox request fails and
+	 * that causes system boot failure.
+	 * To avoid this make sure all IPI parent drivers are probed here,
+	 * and IPI parent driver binds each child node to mailbox driver.
+	 * This way mbox_get_by_* API will have correct mailbox device
+	 * driver probed.
+	 */
+	ofnode_for_each_compatible_node(ipi_node, "xlnx,zynqmp-ipi-mailbox") {
+		ret = uclass_get_device_by_ofnode(UCLASS_NOP, ipi_node, &ipi_dev);
+		if (ret) {
+			dev_err(dev, "failed to get IPI device from node %s\n",
+				ofnode_get_name(ipi_node));
+			return ret;
+		}
+	}
+
+	ret = mbox_get_by_name(dev, "tx", &zynqmp_power.tx_chan);
+	if (ret) {
+		debug("%s: Cannot find tx mailbox\n", __func__);
+		return ret;
+	}
+
+	ret = mbox_get_by_name(dev, "rx", &zynqmp_power.rx_chan);
+	if (ret) {
+		debug("%s: Cannot find rx mailbox\n", __func__);
+		return ret;
+	}
+
+	ret = zynqmp_firmware_version();
+	printf("PMUFW:\tv%d.%d\n",
+	       ret >> ZYNQMP_PM_VERSION_MAJOR_SHIFT,
+	       ret & ZYNQMP_PM_VERSION_MINOR_MASK);
+
+	return 0;
+};
+
+static const struct udevice_id zynqmp_power_ids[] = {
+	{ .compatible = "xlnx,zynqmp-power" },
+	{ }
+};
+
+U_BOOT_DRIVER(zynqmp_power) = {
+	.name = "zynqmp_power",
+	.id = UCLASS_FIRMWARE,
+	.of_match = zynqmp_power_ids,
+	.probe = zynqmp_power_probe,
+};
+#endif
+
 unsigned int zynqmp_firmware_version(void)
 {
 	int ret;
@@ -610,106 +710,6 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
 	return 0;
 }
 
-/**
- * Send a configuration object to the PMU firmware.
- *
- * @cfg_obj: Pointer to the configuration object
- * @size:    Size of @cfg_obj in bytes
- * Return:   0 on success otherwise negative errno.
- */
-int zynqmp_pmufw_load_config_object(const void *cfg_obj, size_t size)
-{
-	int err;
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-
-	if (IS_ENABLED(CONFIG_XPL_BUILD))
-		printf("Loading new PMUFW cfg obj (%ld bytes)\n", size);
-
-	flush_dcache_range((ulong)cfg_obj, (ulong)(cfg_obj + size));
-
-	err = xilinx_pm_request(PM_SET_CONFIGURATION, (u32)(u64)cfg_obj, 0, 0,
-				0, 0, 0, ret_payload);
-	if (err == XST_PM_NO_ACCESS) {
-		return -EACCES;
-	}
-
-	if (err == XST_PM_ALREADY_CONFIGURED) {
-		debug("PMUFW Node is already configured\n");
-		return -ENODEV;
-	}
-
-	if (err)
-		printf("Cannot load PMUFW configuration object (%d)\n", err);
-
-	if (ret_payload[0])
-		printf("PMUFW returned 0x%08x status!\n", ret_payload[0]);
-
-	if ((err || ret_payload[0]) && IS_ENABLED(CONFIG_XPL_BUILD))
-		panic("PMUFW config object loading failed in EL3\n");
-
-	return 0;
-}
-
-static int zynqmp_power_probe(struct udevice *dev)
-{
-	struct udevice *ipi_dev;
-	ofnode ipi_node;
-	int ret;
-
-	debug("%s, (dev=%p)\n", __func__, dev);
-
-	/*
-	 * Probe all IPI parent node driver. It is important to have IPI
-	 * devices available when requested by mbox_get_by* API.
-	 * If IPI device isn't available, then mailbox request fails and
-	 * that causes system boot failure.
-	 * To avoid this make sure all IPI parent drivers are probed here,
-	 * and IPI parent driver binds each child node to mailbox driver.
-	 * This way mbox_get_by_* API will have correct mailbox device
-	 * driver probed.
-	 */
-	ofnode_for_each_compatible_node(ipi_node, "xlnx,zynqmp-ipi-mailbox") {
-		ret = uclass_get_device_by_ofnode(UCLASS_NOP, ipi_node, &ipi_dev);
-		if (ret) {
-			dev_err(dev, "failed to get IPI device from node %s\n",
-				ofnode_get_name(ipi_node));
-			return ret;
-		}
-	}
-
-	ret = mbox_get_by_name(dev, "tx", &zynqmp_power.tx_chan);
-	if (ret) {
-		debug("%s: Cannot find tx mailbox\n", __func__);
-		return ret;
-	}
-
-	ret = mbox_get_by_name(dev, "rx", &zynqmp_power.rx_chan);
-	if (ret) {
-		debug("%s: Cannot find rx mailbox\n", __func__);
-		return ret;
-	}
-
-	ret = zynqmp_firmware_version();
-	printf("PMUFW:\tv%d.%d\n",
-	       ret >> ZYNQMP_PM_VERSION_MAJOR_SHIFT,
-	       ret & ZYNQMP_PM_VERSION_MINOR_MASK);
-
-	return 0;
-};
-
-static const struct udevice_id zynqmp_power_ids[] = {
-	{ .compatible = "xlnx,zynqmp-power" },
-	{ }
-};
-
-U_BOOT_DRIVER(zynqmp_power) = {
-	.name = "zynqmp_power",
-	.id = UCLASS_FIRMWARE,
-	.of_match = zynqmp_power_ids,
-	.probe = zynqmp_power_probe,
-};
-#endif
-
 static const char *const pinctrl_functions[] = {
 	"can0",
 	"can1",
---

-- 
2.43.0

