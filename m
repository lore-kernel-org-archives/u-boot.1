Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCD606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sYp2uPg8;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OCVv/VAQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5521E81068;
	Tue, 20 Oct 2026 14:10:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdRttC9U4WAx; Tue, 20 Oct 2026 14:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A304A80D9E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792505430;
	b=IyftJ9ObprZQ132mOLtIOyJnOnRec4tw+B8L1XnRBg86/0hHT+Pjn3k9J1g331c0Rktf
	 S/NRkmhiSkkECjL4Qs+Nh/U39Unp06ffadIGdBnmr36PfT5RJi8jQusdKAqws8ugvdeKx
	 PFXUiEgsAFIlZwRt1A4qBPXFg2IsiGMS25A84ydsUAwcq9FYFQpj/Snw633nSKevxu5aR
	 QuoXj7kcCJiBqZJT/mr7f5BD4WG3+7MFPRHC4VjR9+FS5gOJ8qLpqKyJDemWORZS4d1C6
	 eTCOB8LKRh53G/ATGyD7+GsZR61SK1hMo1jXJmyDJRyR9ohz8rJN6YmKDq2SrolGI6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792505430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=DK2FeIrB6ylKgj+e87zkjlTiVmkI5SupZ7RhutGm96s=;
	b=XHjG9+/J7vIuLg4iFYhy/6nRGNX/qWUBRdQe2OjZKa600rF3MdoAKbZmzrB+tLCTYtZu
	 Dbah8aTIv7HCPCCNMDJT/FMjmmOXC47nUMLGDr4DJInx0MUEPbFplg3ExIEj8KENwjV1K
	 OviU5DDXW5wHk2I5s/0yXZ/H60Nav97FwS4vjHN02Xce2txonDJHjXvZe87Cy/CGamqMd
	 Mfl0KfUVy+aBSCAwexStBOW3IjugLXyDUSvslODxhsUtQBPTnIZfJs3aNEF0TAs+5vyMl
	 y7XjP96F1y2Fbq+q82QH9kEEaTFJ2w0uF/IB/5qXQGlZ9BnHFjXP/Sv4Sz4AGIw6qUQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="OCVv/VAQ";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792505430;
	bh=DK2FeIrB6ylKgj+e87zkjlTiVmkI5SupZ7RhutGm96s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYp2uPg8jV+VZ66gUKRtMSg1s6I913XVFXYanlhWBbS6dzdUgfnpkVNT7Efdb72ed
	 JfHIlA/uJAVmVrzLdt83yL8r25xgVp6cQlPB6aDFsk7AANMi04DG58FDXRoZCe5/vR
	 /Yfnn/zqVSQziutgVbRN6prhHuVHYg3UW+xxbjG1TLHUsrDRJr55Yxho5Xy6y9mawz
	 WnInWWnJpc3YulY9YiY9+sHeptFxpuGRgRrnfFNHJTYfgEo0Ds1ivofSRd2Qo3O00D
	 +Ep4BFocNLhcfPgSNWJ8wmXQ+H0SPMF44JX+4dYj2YuIaG9pylnV2crL5LaZL6+tqh
	 bBIm3bamHEE/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A304A80D9E;
	Tue, 20 Oct 2026 14:10:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 859C6769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B860810FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PUZXOry4SX3D for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:10:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B4F980D84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792505428;
 b=rfi6Dim3OOEgLdg6xLhnOl2zYU1+uE2tD/T28qXHIF/k5PTqDO2KCBfn8EfuvD5U6yUF
 CrbmKG8lB9gY/5macr/TniHCdrum78omSPi9+0wFuzh1H8gaaplTt/X9z4qTGJAG2asE4
 GHhNidDsdRJzI7v7whUgKwAefT4fBnd9DrSPjv3SIfz0JQ7pn61cYbZl1TxeaHyHyafzq
 ea0+/zAssxIGXqdReEi8uxY6zJZ64II4RqToCFfxHkfQ29JvSurRiN4uRDmk5UifYyTWO
 tPGuV4hYR4MENItyISz6lGbFyRaQt8XZ6nFHP2wfexGm7MOEMjupnPJ98oKX0nPrPRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792505428;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:X-Developer-Signature:X-Developer-Key:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=DK2FeIrB6ylKgj+e87zkjlTiVmkI5SupZ7RhutGm96s=;
 b=VVj2cdK454hBzd645HpUFtq3eb6Z6RzLdx674FTsbt2a8avO/d6FENT/kX08HxRLYekb
 feozpDpDnirzlD2gjp5jtVWgVXqVnm0WKhtOLj71fddILwpac16nWStWmjtbMOD0M3hmT
 FhfCJ1kYdPmrfpkwvKxsF2V3Y6UsDMZj+/V+EMOfntUXQiZYKbyzR/M677Smw/ez7D42N
 rscxxB5moUiWwe8JlSRR71Cn2mxERDR2ciMXI/ViSRmaDH7PWEENmas19bdcSQ3+EYqm0
 ypZgwfLhLHlzYZfD+TrHyoogPoy6D9IhkQxvpRB+4rlJI156N+L1HRuPPy6EAupxu6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="OCVv/VAQ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OCVv/VAQ
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B4F980D84
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uO8FYbzABCM4JxdvZUXo2AMwld+4JpAt7IlwovdrbLO0ml1MPZSfTtWTEua4k05AlqdNWkhBSAS6q1Mi0LFjlrQ0G0c6n+C/pMfIxZ0iTkIvP5Zn1pEuRWrTghY+4PHzpIIVRCMTRJU1vr4LOYT8TtdYPTvKPgF3QdQoSEVffscVUE6IC5js9tDt9Rc97VSD3Boenvq2ULWAYRgGgsg2gCTbM4IaPosrgeHgPYkQfgkW21IyF2JO6pVS3t+DnC0J3J6McgLeBLiOmmiCOdku4eraImgnrTYPs/II2TdWXAlPJKD6Xu4gJB98E555u1BSmNQ3faNRG9h6pQ3oHal2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DK2FeIrB6ylKgj+e87zkjlTiVmkI5SupZ7RhutGm96s=;
 b=QXuys3TlYGR68F4XenxbwG2bciZONCP2dxddzhzebIFCTWhZfL77NJU3QddVaANd/JA63PN/5y//nPL2UuXpxS8ZQxwTlAJp+tCUXnoRqPQUSvA2bR7TytPSljNA9q+wr2u0Q1X6TXtxH74UXbf2oSamEclOwKchWNiiGqaBSJEyg0kdx1AKzlAvlbmbyG8RMnAkQoaZdT5VR28ekQoZuz1BFtDo1IvTIrC1KgDtAniFSP3ctp+vkqKE6+kWlFYYMDqsF4R1A/WLIpeiocklCKgUqohAmM/D5P8DauZQC1MDFMi1scNVA7JHDgO/lZVzRgaMVqRL3ePFWU4GisaItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DK2FeIrB6ylKgj+e87zkjlTiVmkI5SupZ7RhutGm96s=;
 b=OCVv/VAQ8dIfh0fttDc7PdSbCM6jvs3h8eZl5v+MpORAOxNQ21JtNyCuYpJ5whiT1EVTg8DOW/hYFLUpmNYiHYLKlI1tJ9bTVkthcQ3lBXwl9q2OnZcX472ajfJS6p7mAOcqh7tl1aOe9ECecUHdDZ29EIYX+qZR9DLY7r4YTts=
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 14:10:24 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::93) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:10:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 14:10:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:10:16 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:10:16 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] xilinx: mbv: Add SPI-related board config
Date: Tue, 20 Oct 2026 16:09:32 +0200
Message-ID: <b7381c6e7ded55683f4d08b5947d1f2ca0cac095.1792505359.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792505359.git.michal.simek@amd.com>
References: <cover.1792505359.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=m9mec+kdMT1Ca+UwJzLov2mI1RyNtTuV2C+9lL1zYJA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL1PM+t7iH7SarbWsWyRETqriY/b2i+wLrm++ZR2iL
 BV0V7+yo5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACay9CojQ5eWt4rbt3vZ1y60
 7w09H++Rf3X6Ad5yW3X2U6XR2e8rlBj+qVQuzI7lvB8rr38ojS1P+chZuQ+bDfQctZnvXXywZud
 qfgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f257c20-3885-4698-2366-08df2eb3e1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|6133799003|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: PHn7KsG9BKwMx6PM175eJxTVezD+zmr3qqe/2o1YfixippXO8QdIQ9hO78BtBuIMIfB1Reyd5XPjEO4TExOYVGnLHcxzdQfMZid3RABeLYNoOEd2JAxBUJuYQjDdMKHnLoH+/J9FMeu8auzP8tmKw88W354w0tn4T+mlxxJl6YfiVxPWznWE3bMdHP8NDkm5RlNvFfO6jzoLjr0VVFOIJjE67soLA/flM51xJAjjfaudjZX40twJjb+fFM4b1wItjiENfkTqZ6NzMuQ/NE1i/7T8vlKMRr0JsSNaCdbfFjsZknPEG4OdLGVStFNM/a5pm+WG5igmGS81b6hQ4vkWkNckg8AoAyKYmFM9YlnfaXBh8n8ovfgw0hYRJJ3cQlI+LKUBM7WgglRCfH4b14oQeFw1lBSA7F48/vWc4taD2nnfQsPQi4g9Dye5pZqpTJsmDmDn+dDtzJ+xDkS6ONjcfmxqJdnJQSLvQO0p+5P3/VE5rYhAIlFU9H+MZAvJxDxFxGfvdtQwmDJyccEBDFPn/tOa3p/sb2eJEklZr4wcFgHUdvNTu6G2VqjRo0LC13Mb/MKvenoNNta/Tu10TYqxl6CQVmXdBlx55lwfqmiBL1fLkuaeqMomYicX5eaX0eQoV8/qqAD66n2OB86Vd0LWL/amKoJ14RjgxudCI/eQUFo4XvbHy1XiHEThGJMCbd/mHuEehY3GQEFENk5PNEwG5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mrs9stgBC2rDoocRSvE0d4J7Eg1gly8t+w15CCWqpaWhxviKOxE+8gLTO8RJX6OHwXYKlOVqTfe/B2K7oLmttXtZI+VLNYpIVYUtCt4taxPRXfvOlQRUei6/KNGwgbZh9gM+JUwKdaToEZHu7aoWtfCUYDKXSGYXfuWuHXsMUKUIf2CiDKWHs+zUKml841xRtaDl0sy0phqIsjrnbCyuwbkHLT1QLWkWujRuKsFiXHOfUiOyaeKDJr4ekXQzWQoVW5auj2czrCSPajDEi1Vc7wVvZgyqztruK3eZcR9DYZvY4B9kJy1x4paP+LtASg+7taYuXZhxYtf+GAU1wudnd2F3SvrX4UySgPsavkNIHIrx/V2+M3K5GtbWUhxRpoI7yrVW0KXjKViMBp7Cv3r9X/+wbWYlaqG6m38D1yvgWCiIXwQDE2VMtbGgR94Ej9iW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:10:23.1344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f257c20-3885-4698-2366-08df2eb3e1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

From: Padmarao Begari <padmarao.begari@amd.com>

Add SPI-related configuration to enable SPI flash support for
U-Boot SPL. This allows SPL to boot from SPI flash and load
the FIT image from offset 0x10000.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv_spi.config | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 configs/xilinx_mbv_spi.config

diff --git a/configs/xilinx_mbv_spi.config b/configs/xilinx_mbv_spi.config
new file mode 100644
index 000000000000..34b744e8ac1d
--- /dev/null
+++ b/configs/xilinx_mbv_spi.config
@@ -0,0 +1,14 @@
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_SPL_SPI=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x10000
+CONFIG_BOOTDEV_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH=y
+CONFIG_SPI=y
+CONFIG_XILINX_SPI=y
-- 
2.43.0

