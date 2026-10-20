Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF8606A327
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DAyPeeqg;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NImDl0ZK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA2274077C;
	Tue, 20 Oct 2026 14:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mk1sWXhfTAMB; Tue, 20 Oct 2026 14:10:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2C9154077F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505406;
	b=U/6NUolBR7dgDUo+7/OdJ4yECfQ5YgM58DQm7pieEeYDFwj+3OuyfzONVfrvoE0dJZy0
	 f5vAgHpC+8i6CDXulSOAFUJYdJ2LZk275+x9sjRwenIT9tGfkSkbCDlnSigPMwEtVteq5
	 RCMaw9lkW95lsxP6iEWGLmGz/2+vzf6hf5e6mkAe8t1NhEoNl1zksbHJ2L0BkHY9ab17E
	 rPnzzjLUaR9ASP86CkWzsklyeH0AkamLZNkjQ+pxxGqFh4M2jChNdnVM8Kl6V0NvO5G2g
	 ksvnDmHsgueWJrxCXhzCkqhww8n6u/z0yDKUEF2BGiRlkzztZxGvEDOPV9hJXyTqHTQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505406;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VoQq8mIW9abXXSsTF2pitu4zRIVgKKciESX+cX4mLeY=;
	b=L4aE9n306YndbYpFPfdg2iKLQL9zl7MoJZR4ogfcpQGAlKoMIuN7ANW+CiAnyVcEwU9W
	 PHKQVY81kPKEcoVtNQrjFDT0qimtOLQM70qV6jRRXBI+D/cYPLNoDt+Hbw8cphFPXefZQ
	 NMDO/36Ze+nIXF2TBuIhhOCTCHOMD+RyJFZbM6FgpMQts/1kTnbJ9Mvkl67qs1R+LFxYJ
	 gtcujmuqiNgendHbaSbloib/jgdipfWS1gVNykUJ/hsqCh/Pb6R60PionwWdwIcskCZpH
	 BEJh4wFHCkP+jt2WnDV67+24nz+tEQyEBqkPMM0XoJiX34H4LEBaY1ojd4TThHnymOQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NImDl0ZK;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505406;
	bh=VoQq8mIW9abXXSsTF2pitu4zRIVgKKciESX+cX4mLeY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DAyPeeqg1QZemNT6xIWt5sEC0JO81sj2JaDPt7LKX6t+dqdBCjKiudxiWCGO+rXrq
	 PVLe2zJoDBbzqmE+u5oNcCAW3vxivs118qEKOxVAfXhsrZVHH4F3mGlbDyEY4o8UG7
	 SLFx40qZTh9QmCcn1UZ6/4lVCzRZyx6wBosVVM1qNJ8j6OckHMcdIkxIK1Krt+OG1V
	 dBGnfzCx+zMV8ZvFMCWe3DBpWDBXJAw0ZDVJVssnOhj2mJuJRvvSGx7UXknbjdtX8x
	 Kswqc3E11QajcrSGSGv+574rsx+6DCnz51DEhFnl+SJJ2Og8BYqCgtgHwjLcSA8kWo
	 y/x++OxkzYh2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C9154077F;
	Tue, 20 Oct 2026 14:10:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 560771AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 482AE4077F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7PkNywqstmZ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 771C04077C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c110::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505404;
 b=ixKHjwP/T1HBXSjk71ms3A0Vq+eOyKiEzDL4TM8xuiP2H2GMrErsc//yl4UOOj+y1bZN
 0N0Rssc+gRYAfsBKeh/aLYyEshqrgi2LAPREdo11WMylHUGiq1IJD1zuM2MZLJdfAWBTR
 5uejs8RM7u3Ej/fw1ogAefgkJ8KEmtvHbn7hjyNWWxaKDCNY8Qx63IF6XUmGEvIw/bhoG
 NZjJIY0WDbrUzjqr1yo0oXzlDGJezEsYxAnDQrEILLPkYsL66x8RZn7xhDfce5M2j9yEC
 iyb1RNga+hp2AHs0PFI3T6QL4qvXYwpIElpqmmpyN9zNxYlM0UpDEYi4EX8gA7NacpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505404;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=VoQq8mIW9abXXSsTF2pitu4zRIVgKKciESX+cX4mLeY=;
 b=fD/As+icl3gS8O4eiMR5Q+NsH99ctN7qBHuuGJkQWalv7DLnQtFDYFabSvBwuaafs8eW
 mDYK7I9Yjt20cBb/2ha7xV1YBIk/S2g+pJ3nQrsAZqp+9t+/DZSZUK7x2oVXRAS6SOfCz
 Qi+XYbNVYWjywa8fBc1PFOQVVGD9kM7wSc9F24Rj7xDNuhAu/j0YRI3Uyil+7MBHeNk5v
 bvldWbiCZI3M730pOAYXSM5fnMij9QgAkZL1fwmcQb04oTKWE7CtMTp0AYZ3SYCv8DmMz
 7nv4EAvlkxOTgpyDaffkPDqg9hLTIHnAeT/IrEnAWM9Jyq8jcJstkDWN/qQ9Ht8pVVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NImDl0ZK; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c110::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NImDl0ZK
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 771C04077C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhxvwGRoE0D6em4F/8bsR2NS9NKTVIowo8VqjLfHW70FQy803np6ciTDjZ9Jo3kn5Y5bXRAW+k9PfHnN9EleXGfAK4TtLxFCQUPvg3jsv8llUn/XHgOfh0d4arLnt730Yh9i6aPXcCnty0uKVxKkUmXtH4lgEIXsHaljtBIZ+oX1EJyGu7ydKTdp4df0eyKml7DmxH6eHkvQUIHMFdPrMTFDGIvHCBPtnVTBvBMYr6tOZuWqpO0wNorr4EFrK+ZKP4x5g8jbJ8jYPK7V4PARgEsNNJK5xKQ2cX0UILEjA6busJ485sl1W1tQR56ZUl6m3crFOllF/4gdfzjDRu6F9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoQq8mIW9abXXSsTF2pitu4zRIVgKKciESX+cX4mLeY=;
 b=bIJEhGMnQWprg9DMxhtejnyCAoyZ3UmujPh1sZys9lo333ctXguCUIR6s0JjP6FQjzQcaTvJHA2ZRDEH5FlpWUMJknUEvLmDcF4J0gbBznBor23mOXITEk/nPffANZ5VQoPKYJIvbESp+HMV/RYzOzXOIakWdGlAta/R0UzVxy2i6Imb17Pe4cfq6Ld6GEQ4FXdc3k39LgR9hJSk7TPvLfPPPG+Fegq4yFPr3ApC5XCTRapsJSiIHVhTH7ztNjbb6bP4puuTD1OKQUenicGuLFrys0HQb0EIzSQQd4PToxuRHjclDvMhlTey6HjjA7g+Ej15rMD7C4m3yxNPgWngYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoQq8mIW9abXXSsTF2pitu4zRIVgKKciESX+cX4mLeY=;
 b=NImDl0ZKzzgq7grRAzZhA4+5gPOTlzQYDcr9IqCpmt9Ilpv75Pj57YFvq575vZ1D+2nbE+zPG/QwvBZ8f0IZU9KJJa2TMdonLb/lm2ZCb1Cfsy5Q6FV2bHTtRzx73l9JuUdLNef5fOqCAFa6e0LhgspjMCCAExX5h35bZEW5++k=
Received: from SJ0PR13CA0067.namprd13.prod.outlook.com (2603:10b6:a03:2c4::12)
 by CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 20 Oct
 2026 14:09:51 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::45) by SJ0PR13CA0067.outlook.office365.com
 (2603:10b6:a03:2c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:09:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:09:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:09:48 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:09:48 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>, Leo Liang
 <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 01/11] riscv: dts: mbv: Update mem size to 2GB
Date: Tue, 20 Oct 2026 16:09:23 +0200
Message-ID: <9003fb9a0d41c3c16082b511a815b0991c825dbb.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=747; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9tHvEe3WRWFIs/yl27gWngHZRtTYT6F5+Ugh3P7HlGY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL5Pyv6x1XF3vZ1XO57l7du8Ke/zvd6+3UrVP6pL+m
 kcZQX1zO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiExQYGZqEp/guLfBRC+VP
 vJQxJzuDc8cPbkOzJ9W/J874xP4heBsjwyqmXMO6cu/EfT/Npimt+vPz2pL2puj2zWf/Gn660qa
 hxAkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b502145-86cd-4cfb-3377-08df2eb3ce54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261009223027099003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: g3+Fbmkn7NmqvRV4iloEik0uyelujYeDCrKdAxInfrbzR0/Q/VTlkae8EO5E+/oXX7micVADKwY5FGXHNdM6PYD/Kem56GCFmYLDmSO6Ng1iGk6fJk/qu61kouK+Ik78y14igdWsIeD9INBiY0F0oTeqdjpe5TKSTiks18+j0ID608cq55AdyhQPuV8mrvYQcVLHvuz77jspzUB859dXvTEiiy6ALiifgN5oV/99njx8pi/Ba0UsSJ7LaTV2eGTSBOpcwQ+1cuY3jRkpslFezJ+q0WZGD2urehGWT+41k3MRqGy/6xciw9nPnzXtVq2AAX4QyIgyMFN1DBXHJlZluJyVrptL1WvFGxHkgftpHRfvZ7cJgTkLBJryRgiobp5RiUs0WjcSN0K5QDa7kYd8zeoFezT77wGVatzd14AFUGYnq2ubN87scbrd7GAvwaZs46JjafTB7FTdIXZw6XdpDF4k3Ak173smOIkT5rzwFKHscT+x/1pzJxKTprbyPwWlu2ktvqcnNjY4CVvnJSn7MykZW66H9Eow7/UFzKqaeX2xq44Hte8Q1MiguI/yw7Pm9KDnHPQjlDbuiyfJj0XDL9DVxCE2FndoVTxnVl4cTBNQAp3elBav1f7rwFFu7RX77yiz46hnWK/YjRcmBpcoxgzIN6jwun+TFNciliR7KGnrCZDsucV5I8uSRyE5MproGsjhHvVS7LeQnPSZs53alQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261009223027099003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S5s+NeI7+J8PLDzIO0Qij3UhMculkgK+Wws755kXDCWvyalxE6EbLTM0zbWjrNMCDqMl1V05v0ZRsrqszkQHy7Wp/jAS/ynHj/FwwdYQkgi4dZVNYjtHazShWnlSLM+eXydFWRAESnLOHnrr8jB5xq75o1HnBmPbSVXBQIKdEPiJTaUYV7BBV6G+hduom/2yBATFRT0NEM5uHmssxaCV08XLWOrJIFQN86XeUk+QULPeEHJg0iL7FgsDyJQVvg3ENtc0XF2UzSIQDXFNVB7zQHNll0Lawqm8Xbc+0NN49b7vcQmhbdZqxgGM7ggS6LT3FkyOxqeeRIxVfEBlQjhQg40V+eOZYnFI7XaWzVoI0+zZ2sHXj3/yydyx6iToOzYvBdys8dsC+NxZC4XcPcZiTbW0guqHFCIOmZel50z1EqHbb/4rM9rhLdX8tTNKA+2k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:09:50.4283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b502145-86cd-4cfb-3377-08df2eb3ce54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>

Currently memory size is set to 1GB, increase the mem size to 2GB to be
aligned with uboot-test-hooks setting which is using -m 2G.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/riscv/dts/xilinx-mbv64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index e6235ed2f525..cac7f65cd569 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -47,7 +47,7 @@
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0 0x80000000 0 0x40000000>;
+		reg = <0 0x80000000 0 0x80000000>;
 	};
 
 	clk100: clock {
-- 
2.43.0

