Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F411C55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BF1060618;
	Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOp9r_XJLYyD; Tue,  4 Aug 2026 21:55:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6409760671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880536;
	bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YTu4=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tPebZvBM3cPaTS/8MxfotPEsngCIzF3Ssc3YEGVUzRXk1VNVDGkwUSDhDiJ4jkQ8A
	 hh6QUcQLDSNigq1yTCL4S1KNvCbKsTDRyIpeqIMid7xU1zt/eaGwAhICBte8qEPqHt
	 oQcVABxPrx3oJkt1jgBOMqGp+ewFVi1TN4+K1C6yQAtCLLi+KgisMLER5l4KFXBMcP
	 yDRP5D7Iyz1m0DRLfnseBJV4EfIHlnuMzZDR5hY9qLtYkY/aFOIjLhQD9eMbjrIpHF
	 5fXNJ8vylhaOuOFgGoxapI5kSMxUDVwo+PDLM5TUfi1NG8tpZfN3fmGHrAg4BP6e4V
	 pK+pAvhTU3Rbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6409760671;
	Tue,  4 Aug 2026 21:55:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6887210E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EBFD60671
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xxchq-jSx4Dt for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 440BA60618
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 440BA60618
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 440BA60618
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:29 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 674JoLvE333419;
 Tue, 4 Aug 2026 16:55:23 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fubus5y9y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCv4lI3BFHip1egvAOAW01T33KCZbFCRWDo+lM4++7fHZglK1F0hy7S5t7gFmXsrFMPUC0B+ICF9gw2EvfcJripGC4KvC+9irNiC9644ywWVBBmUsIT6XS5B8AbCBV92YG+ARzj1r+si8QnlivoQeWNkfQwqT+2GzgJftcWh75xPskL8ftWWRG9R3I7ttXpGBVr9BmR6d2od8nZT6wHc07jTMqEb+CeBThWmdnH2oScDnpjv4sUOtEGQCKeGCLK1TgsUcCP3oA/8ANGB2D3nJtwxrHGMgEBJ+unTNP4ATdgKCuFkuGanSXHsn2JZCRucIjc6yozrAJpL75AzPdGJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YTu4=;
 b=g3jqovTMdVfHerXv6S6oLymTDaxNqifv1s1Qktk5jh3SJClfQ3UspkwdcANx7vqLnI583rzu463A0dyuCbw27hHCV3gEjiR5H+KWNOwjkA9eXzBK8Tewj2gzBXzbol4q2tiSn7SjvZEXi9RqgTnuEuS6JfxLjIpVImQEjyDSt1piijnHvtyYhpr45l2oauF/NvhuYl1bIW/EO3RgaReqT4uYa9CMU0kjiuUmN3eqwaVLP/w/bHXnESP50HXi51csHXXlgUTRmL5lCs2ICe3iWX/gtXSIPf8JWK+enhD//kbN3LAoCiKvx9J4aYxT9UR9hFGpRl7jDQFOXD83kulSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:55:20 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::30) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Tue, 4
 Aug 2026 21:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:19 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIuH968766;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:03 -0500
Subject: [PATCH v4 04/11] boot/Kconfig: disable fit post processing for AM62L
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-4-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=bb@ti.com;
 h=from:subject:message-id; bh=wbgv38cB5OHNVdmOutRz4qLQJJWqiNEggPIiUvUAjN0=;
 b=owNCWmg5MUFZJlNZxIjQdAAAYv///7/t7uf33A3T3ks++h3+oPX+/j/av9/3/v+Pu979+f6wA
 RswIepoAGhiNDQNAyAaaD1NADQaAAGgAyAGgGgDTEAAyGho2pkZNM0hpgTJ6IgaGhoAGg2kNGho
 Gg00MmQ0Gg0A02poaAGIyNGgMQ0ZPSaDEGQAAaaNDTRkxAx0NqNDTTQAGjQGQaGTIZDRpkNAxAB
 oaGEaZADIwg0GIaNNAANMIaGTEAGmgAC6DwK7kCAwA4WGn3XnczARH4P6cL7xQcFNMwWg+5BuW/
 c5Sjy5eMk8nyfMRYQYfIMAOOWDJsKWmOOOJTWeJpQOuvVXupjHIZiJZE16/SBAM0GzCJr4yVMav
 6aXKTRveIsD/mmRa/IbGoqNjnEeIaFW1nq/HhFI0wxQTwT/AVUlVC54d/+OIHAWhSp/rQhkmPI6
 IVaUNClNa5cz3tDbW7Gq4toJ2Gz4sFtVqthPsjhqhUnMoDm+j4YBETIXHGCMIBaLM2ZPLGH43Xh
 0OSmHYSOiQzIBmf2pMIftqPEHeVoHa/TBU9cxLe4IgsouJnQi7ieXMzB5kWWrZIUppDV787piYI
 rGcEGpBNiYNqAr+946BjHvO5OKaUP4akXIoBezb9E63qGCJYxCZD/3nBuo7N0yliiciZZUkubth
 gDlIL/hEnKI4Kuf8XckU4UJDEiNB0A=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 700e7209-e96e-4af2-d79b-08def27313a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|23010399003|376014|1800799024|36860700016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8cTV3wKHUcS/u+h3GRJ4q7VN37LFLUy6zspAtEZxxu1edAYos0/0RAdG8RIXSKM0SuKNpNefsebNRmV8afrrvXXpiExv+ZUAMm2EPYHTJeXLdQdjxXluVhT/qKTixd2dQaCgb7sSrIXrdey/UMascrwJnPjvhwdmsK7BGDGLf24p1xX72Ahcc2Q8Z6Jw3ysX7+TxlRFFWnXve6ugzr2Xd/5XiyqNi6y++Xs7KYvyblF+Zxnyl6ntNqy0OW9CQyc6eB1wBQO1Uj22tXp0ogGQRUKJAxhPOPWXSlgb0aW7wAcr8iMTvhbsajkqnDp3CSOcjYgVbNvDUS7A28rHV7HyeknrD+5HznZNNslgKo6qCEWVlpqXMhHPcOzkm1J+yCihEOhGtTtXf8Ayd0Pz8VsWu8Eens5girh/ka+T652BLtw0L35ZoSYoZVAAogwSb5WA8T2F6Nh+8/fw5Qkly9EJ+3h8Mktv/z8REH/Pt8b0drDER7LSJxhvFPJWu9CUiQkYLBtWTXJgrtUSa2475S1PBO62ERVGGk5CRL9ZiIs6kl+qtOUk8uowaC1zPdB16/Jlrb/H2gG3+wQUCjAaEq41zgxctuEiMDPfXqFZpSTd0em3ELb/NqMYFihUrxPciycvaOWTqetrTuCgJTDlySn6RG2cDpEpjdvkEvHTyu5BrGSCR78hZjWtvJ/xs01wjOrPJ4Veb1RQteJs4kRLftNqVg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vXnDQhg9322I7AxmeL4YnjCUMpdSZ7TQqBZfS7zbX+WryazNE3c4SMhi1+JpLWdGAL/8+QF0Tq9FjgBWwKh9rNQ/fS2w7AK2Q8OYzGa6hgCKPlCrXwYgcD1NOP6yxqkMPj/znOfoXLUXn5npwpLhpd4AcPL6NeV4KNUfitDwntt4gO/AZzj5BUluf2c3i+seMCuDt3egagTomx6r+FXwRCyaZpCKI4SzFeseAxCdZ3YcSo+/wLEX4DFdtN/hu9RHrsy1V0uAr+us+EmgqCbtiWQq6VIShbqMNQfw9U7CGqJGMYReqrrh4myFAl+CdoX3a0rxc/Ktx6SNo0ORCR4Zdhhn6VIyfaazz0zfRDxdNSLpdTL7lc1WrBis59xrj0gNlmh5Bih6yzlw3cvW280ZGZ6XLwcTyvvvjk8uaU1wOL3xUEwBTS+kYGagkrdejPuV
X-Exchange-RoutingPolicyChecked: f6xPAllFVTsmcW6veu/u2Xw3f2OnwbhGEelKS3rxW2OHVL+mwxLY+6/G0CdbVOSvnTpNzvOMzA2cv/uLamRhUh1YjyHY0itbt+Qf3l9HEzQNRMjfcuKYiakjkF0ArGySbDshbPlEJkA5mTBaXtX4MhA9c72WBv0P/nuITSaEY/XKDNdgdLZe1OdTid4AiK10mpXE/y6OFEYy2VdWLBJ7KLgBfG0SkpDWEjc5+lrp6q4vmZQ5RUNgU4JviAz/srotvuMywGOqaJMzR8V0m5B9ZZA1PJQHbdAXDjDx7MHDlOjGFOOH0IQB2K+qCJHFHtL0DzqgcqS6ti+QDgvi1RACmQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:19.6736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700e7209-e96e-4af2-d79b-08def27313a3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Authority-Analysis: v=2.4 cv=RaagzVtv c=1 sm=1 tr=0 ts=6a725fcb cx=c_pps
 a=MRNWLIXgA5QtCoQasNiLPg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=05-62igR9n6dfVhwZvAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fR1vOpDG2XPN-vyOyDl99_N2IZGyvqpB
X-Proofpoint-GUID: fR1vOpDG2XPN-vyOyDl99_N2IZGyvqpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX84XkNOA/+FqU
 j3I4H/yU7xb2U98oncYoc6mjCxijYc0tY7fRoNkZjZZG6gcByUYWi6uLAOrdpe9Dkimd5XzTZcE
 SPk1VbP+roMFgdt+ZFCyJAnEh2B2TJxAAxrARJaAyxoLUGrQoDrolLbDf3PtX/YDdh6C6xi8vHa
 n/i7yPDkBXmrulFMIgLpSWUu4WpDCDMFfkfv0mm+snKGQvMYyX+Hxfv8nYrLXbXSdOTQeg1Ikek
 QRESuH4sggk1U+Confx67XeVriky+w5r3KIPXEdS1TO6hayIFvSrcakNDvfA8CqaLYBBBo+XyqU
 2TyIOiZlJUsqI8xerMrUxwnqLyK27vNaQcCLB88Md6L7dAZckcTR50tTK9dThFKlxTOHYOwg8Cf
 0DXE/i1R07TDycYZE+ijh3cCjjn+7ON/7woTKhyAV3Y1dFA4cuz4FkaaWF5nDb8BAm6T/TF7OwN
 GGO0/TtDQ53KyuG+E0A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX92RN7aVhFVLo
 wQifBZoL+ZPzKDSqAfWiGi50bIvM6ihgAobKc6F511mCHu4yP3CFmRTYu6gDXNklh5GG5Bz88W1
 t6DWaDWjvylJB9SM4DUVCBi1XjiU7ug=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YT
 u4=; b=AlWj2x+QUO/+FrzH212ls8o/XFZxi8J5Ifd6Bozb1VmliJCn/pyekDqwh
 2lwFJT1CxsV3O8GT4+kw4w0+KuZLyNjCaYZmcyT+JhQKZLRf/DDiIegc+ifQKZIe
 9D9y6NK3Fjp9rPoYba6vcKZuDJkbnv1UYIWiKe03OrAPRMx1MdNCHngL6wZnnPyz
 7Id3wDZoDLFfWe1yoaogj7w6SPK0tI8bdty7crKAxmOUpw5rx2+Y0B4/t7qemDbt
 nuQE8Hx5KRun0hXHOPN6qgOpCZC1zRwQAmcOBI0Lt9hurkw++LRSpBzQNgnlTUZB
 0Yd5euEWpxtG8q1SwtCLJ2zUL7RGw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVlR4oi+Htk9lEVWoqChyW4qQ29kHev045o5Fi+YTu4=;
 b=rQkaqm7l1+3XuExWxsgxrpXpZULj195bdolLSTLLbnFVWxqudNmSijLAh4wjYWoA+SQOHoSgWiXTRdhaO48zYTVvWx0QUdg4+fEAaEV4OMT8wg+yglB/hJ8Bro5b9xUSaO+UWpfpTMHHjQxKHqNSd3GEu1RCj+X3sa3VpOtta3k=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AlWj2x+Q; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=rQkaqm7l
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

The AM62L family of SoCs utilize a 2 stage ROM boot which uses x509
certificates for booting securely. There is no need for processing of a
fitImage. Disable it for the AM62L SoC family.

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba4932..b942be6ceb3b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -335,7 +335,7 @@ config SPL_LOAD_FIT_FULL
 config SPL_FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by the SPL"
 	depends on SPL_LOAD_FIT
-	default y if TI_SECURE_DEVICE
+	default y if (TI_SECURE_DEVICE && !SOC_K3_AM62L3)
 	help
 	  Allows doing any sort of manipulation to blobs after they got extracted
 	  from the U-Boot FIT image like stripping off headers or modifying the

-- 
2.54.0

