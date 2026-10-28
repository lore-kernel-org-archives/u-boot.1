Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EF606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jBOh9m75;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s5G9GOIR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A6D080F32;
	Wed, 28 Oct 2026 11:13:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6H5ygOX8KUS; Wed, 28 Oct 2026 11:13:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 720A280F3A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793185980;
	b=cczrmw1ER9isjgKMtoT47Khz97+ljtK+rj7iB5y8WiKUPqn320Qlbs7c5KiGNkglb8gw
	 HqfQj8jEVHpgEMxBqWJ814a1CQJZ3JP4M+J0zrViGQUIBauRBqxfo4DE/hFWpVrugb2ob
	 oKQHJHyIvI+osVvvaqy5uJV5rqF+jq+oBQAjH83tuxE3KYYtLh5yxZAtn1QnZPMMhchW+
	 ilCUCrOQlc+nYuSNaLdWcUXh8nXTuRDjbQDjGybLGA/NZVDpdvKel+sg7kAv2iOipCcGO
	 l5bflmsCWKdyXpDcoAEkiR3Hep6DanDrs0ooPzXyt3cpLjOXsuZClSUt18ifmHO8rkw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793185980;
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
	bh=xMZO6f9BWaTOEz+4KlYc1G9zIuzqIOyUnwaovyKOS20=;
	b=HDWP68meUGo6x2JqsNeO4aV8Aw7ojDedqzcttqijdkptCoSnSYm7J1d5UAFhgi9USFtn
	 lDw2ZRsn/dRcQFUOqWAY6rse/kdHCc+rJotDuuTbi0ScHyxxqdjDSIcgob0AV2VJd/K4a
	 jMouvu7oYqnGWtJJUzZj3ruablNRuT54SFQEY/Vcvtkvs1tFzhJZhBlcfyUOXkghbIshU
	 WOJQcV41pZCIh8uMoaqtKhEdnES0WplS7yhzxdA+kDk9VM+II4+U5FsAhIpp0xfz6qtmn
	 qQVRK9la4cU5aQjQwYZrk+F+fshV4tdM/N2ickw9Qp6tBMEj6vq75wvClkOm6VWHxcw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s5G9GOIR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793185980;
	bh=xMZO6f9BWaTOEz+4KlYc1G9zIuzqIOyUnwaovyKOS20=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jBOh9m75jaTiru1RGEeCwKpGU2sRwOuQ9a7jFqvdarghcEA5QpF2vIVPBuMjThm24
	 wxcG2Y3DB8GnAmPFPBdYGrGgSVS6+yC0hcFysjTHYHfWN1bhLKNV6uJCtt6QwV7VTC
	 +3UZoYj3MlMgV1D3jlPHKdZEPZLwTN7nOg/lseS5L340qtd38d/OMp6h2O42+yfsbW
	 Khu33BNzQPy8IgNWoGHDFJUYb1x8GDfviQHndF6heAGNu75WUi3YfzJoPN4KJ1KB+o
	 zTPEOqG1Y1IJ0C2q6+yclaJYM5sPUUoakRsf6p8pyeLT0925ezVJcY19j5MVv4HYDq
	 NwOvzrRKlSBCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 720A280F3A;
	Wed, 28 Oct 2026 11:13:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F403529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3CB7980F3A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ety7OW_-5gf0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 11:12:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8C85780F32
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793185978;
 b=LW7bgzPWK3MfWW4r3iccFQd+hTZQr7WXb9IuTbiR3tcOqdMBBvaA5OYWllj82Z/qT/09
 PFd5uc4eq+V93tBg54ERixKr9AFVnrhtrL49/xa1r2Qey7N6WKjG3D5yc1mZaoyiVYXXo
 uHKVQlWfAqsoUL+7BfpNLLwBwwpSeBq57xDqH1RVmt9pLkKVdU/1rBB1OegAxrPx7rF0O
 krUChAi+n/VBqbxSy0a5ewoHi05M4CwmXLJLyz5fE8FlNmu2hs+Hnq6oE5VYZRwB5vN6v
 Gtw+7LPU2gD2es8HzYyoS/kNCtO45TrHuZeD8tZi+N/VZUouJm8RTEnJFPhNiVVagZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793185978;
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
 bh=xMZO6f9BWaTOEz+4KlYc1G9zIuzqIOyUnwaovyKOS20=;
 b=T2AwNPCs3boMUMp7I1tuuHsCyrlUDe5ZZPFgqPjqTG9FeikODrtcoVCpXY8MqEurLO1j
 uMcWi2TyFczmqeWjOeSACZpzbuLu+F4Mvtrg3/cHx1utw1y/+/Q8/fHltpTGchhWcb+LP
 Pafqs0276wt5/eRrtQRlf3poyT5w/AU2zbS3/ogBfPG+dgO/PgtvLR3nn5LlKjDMv8Dsx
 iXtlykIABeLYdVIsNiOXQzWGzcsvmaeHkC/WM2EjfvYklPFihFEnEG+NLnFJ84rVKpwxW
 N64J8BhC2877OLMU2mGGG7X7J0fX6b9oQ93rCZfJ8Awf2JQpdP2+uKcC+pWEBha72Wg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=s5G9GOIR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=s5G9GOIR
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C85780F32
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 11:12:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awzASCLCZ1dEhg5U/ifVEV17/RXT413JXAma81uYYavJBV5Y86naXOTIL3U9M2lR0FnqSYt9suJtU+xFvrI9Ovb5vH/mV5jmgbms9opWeInuV2qbPyVNsAphnCcRr7mXHGXYrBpg25rfDzr/5ZPwIK2ABP1b4oDFpHDSAqW+6J7yCyx7hPRjmv/MG19X+d3JrPEZv7FyasYk0VAbXpwMrxbD4Vk/PpLtV30lTIAW/54d01icALC/tF86UraWxri6IA02ehzE/qEN1StTkCzIsNvJPaKkmPzBd4PEhjXXB4sRdbvm2hiYTKxWqqV2L1BtFJRQ6/Nf8N0AzqIJoBWacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMZO6f9BWaTOEz+4KlYc1G9zIuzqIOyUnwaovyKOS20=;
 b=nsda/8H1pEqIdBrQxsF0Y1q7obfQv+E4jRL2MVtqR7ytiYXYSqOrve+NjBOBiRM0yNrHG7RvT52GTbL6T0a1n6cUj12UrsLb47R0uYYlxH8SNr767VvDX6OzGl8y33ERbD9fx3EhTZCmYsrGD8vW2rNT33fxrISAp4jN96lPSSwJhZOmU9FVEq9Q9JuUF5D8K3D0D/FEK3O7p1vL/Spmbtr8VfntRLqituDO9dBcEmSyW+8uzp7uYyVx2V9KpHDJfWGaG7V2+RAeqRKyz6Zbg/yqFJ1X1P0P948PYGJiczZFM0TXaZk4ukzF8dO5XDqFe2aBfd7qiK9Jsq92mHNrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMZO6f9BWaTOEz+4KlYc1G9zIuzqIOyUnwaovyKOS20=;
 b=s5G9GOIRPz7tI24OEAD43wsk0bKNVXVNJBqnXDU3uJCvkfMlnBRG4VSbrxYUq8krjqgR/QJEInFDgPWesTeET2+rhyedZ/J7SQmZtuNXtVGmzqtuXomuJDkzfI34b3D8HBnJQDYgSyRSrI7X7IcEmoXcfe7cedbR+2PRWoP4XoM=
Received: from CH0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:610:119::15)
 by CH1PR12MB9717.namprd12.prod.outlook.com (2603:10b6:610:2b2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 11:12:54 +0000
Received: from CH2PEPF000166C9.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::2f) by CH0PR03CA0364.outlook.office365.com
 (2603:10b6:610:119::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Wed, 28
 Oct 2026 11:12:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166C9.mail.protection.outlook.com (10.167.244.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 11:12:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 28 Oct
 2026 06:12:53 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 28 Oct 2026 06:12:50 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Akshay Belsare <akshay.belsare@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, T Karthik Reddy <t.karthik.reddy@xilinx.com>
Subject: [PATCH 7/7] spi: cadence_ospi_versal: Remove explicit dummy cycle
 setting
Date: Wed, 28 Oct 2026 16:41:14 +0530
Message-ID: <20261028111123.1198451-8-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028111123.1198451-1-padmarao.begari@amd.com>
References: <20261028111123.1198451-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C9:EE_|CH1PR12MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: a10e3ddc-a202-4135-d6bc-08df34e469e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261022075727099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AQkt85zxo0i7fANUFY7mImH76pBOoDzAitFkbC6zUZGyWJUkXa1SAUOs1tKLK0ZVJEOUw6WXiLnMFMZTIPuSHw/xvGvl9Nu9s4hiGC81TMKEwBHpJNY3C9nz1sod+raT08jgRjT6LmstJVaopySo7WfA9/f3DT3OKOT50Y5NWtsPQbBmgeZoF1lEFo9OFKdYr2mNnoNcaZzFWVwOeUJd+qvdDR81PsTJmN3IcvWyTFhbsKq4G7PQ/jVKPWGNrCnedyNI0rP6f4Pb7j2La52TvRHfLyWCeAgiLfT8wpvKyEk3cxRgELpEC3PLK0sFIdLGUjKdDPcXJX9iCrCBCZbXbmMJcjmUsYw4pj6hLeLsVThvcmbx2+FZjsCr1Y/67I+3YwTcMPf/jgaShhWx1TtpDYJjxhM8Am3YllsxX1RUGfDt7iin5HRP0yTFy2R20yzBglvmA0ujDO98jW5jCFM3F9a4oT8dGZSUNeOZ0JKfG+jSgepubhmj5mGabTtDo0XkbyF1pzR7NYt/tAGi/WB9hycmyIjvMZ4O1GmCSO/5oPKSGmxU9HFqf8Kae9qqwGupBCvoUkNHo1nf1/KF8JtI4MbMx80Ozj0S/mSo2aEzT7V33dVIu011MYLAWMHGe2PKsy3Bsf9lBndAbSSQ8UIZACgTRPIsxBMegZ/JBlZmNMmLmq6a1/59NdvBg0vkraYzbsSBDQ2kwAQHirg9HUTDow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261021123027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eGeO05jNPWU0tL88EyYpWBZGsf5LdDE4a+xw02mJuD8rVNdKtzxfM9d5BOJUwdE927chZPURyUsF5VrLGV1WH4Yw5vp/3wG0Bgzt1i2hNTmJhiumfO8xOdXQabZ/9DrZmeBU/Gn1vIUV3RdAcRRi8By+bhk3rTWe7R0SKDAA13VnP69H8hAaSqvMQZbuUA8UgzWODdlgZj3rWPkKoenSHsY9D9GTanjDibvxRbwfCygl/VPW+alkfCVKGNN+6x7QgEhVyYYuVckkNDWJgAn1E+f8DdFhpMn15jzPe8UG9Z1qJvEkExnTdgfg08dcHZnD/LzJMCaXmzkx1Dla4VuviKt+GGJB//1E6ONkg1l1/acqu9ZDEI/DpY7KUnc0qW9EVhdxbtBnkkSSCDLslAuyrjWuSfu03m8TG9hEbnXlo16x0TNBmSliAo560euFIEfT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:12:54.2889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10e3ddc-a202-4135-d6bc-08df34e469e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9717
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the code that explicitly sets the dummy cycles in the
CQSPI_REG_RD_INSTR register during partial reads. Instead, rely on
the value already programmed in the RD_INSTR register for the current
operation. This avoids the data mismatches observed when manually
setting the dummy cycles and ensures compatibility with the flash
device's expected timing.

Fixes: cf553bf20e51 ("arm64: versal: Add versal specific cadence ospi driver")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 0133c92b60c..680857e5c42 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -110,10 +110,6 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				return ret;
 		}
 
-		dummy_cycles = 8;
-		writel((dummy_cycles << CQSPI_REG_RD_INSTR_DUMMY_LSB) | opcode,
-		       priv->regbase + CQSPI_REG_RD_INSTR);
-
 		reg = opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
 		reg |= (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
 		reg |= (addr_bytes & CQSPI_REG_CMDCTRL_ADD_BYTES_MASK) <<
-- 
2.34.1

