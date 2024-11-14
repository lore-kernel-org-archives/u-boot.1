Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA957D6A250
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 22:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CF48969F;
	Thu, 14 Nov 2024 23:19:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LQi3Xz16";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LQi3Xz16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC43689672; Thu, 14 Nov 2024 21:41:46 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E1F892FB
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 21:41:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=m8ginAMddaV+2wPcj8MTTir79qdLEvwJzJCFPzerGwCj1a02YiwG3MVytYpQ4HHip3S+hsLZv+i//7X0RpHyWO2PnbDSaEFdbYLdf6RMw6wOM5udYNHvMQLeY9s5OGSQG8qofXV3QsD0aUmASWTdlbGWPDID21u2G62PG3pgB5DbUwXnEK9xB+rC148zJugEJ4tKHo3gAUjoZ1+ztvvV2coCD/74oc+3zxtaQ/o2IqEBc22nfyew2rm4Pdf6iDPR4HGPCiTSXzmZoAwYYt7V5/VEh5BG5NAEaUli953oticBc/k3AF7KlI2ymPNnNq9oWTHnSrtjUodBYNpWeezKwA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgMK1JQo7ckeHy4OMlgHhakyWiZBp9awHdmgSd8AZ1Q=;
 b=WVsTlywqkECm9LVBnWuXHH+/rCVLVvIHlKdQMV1spR6vAN49guO8LtM4+bjLCjOP7nNw2tMSYfslBRRnR2WFBYoJ4MAXJ2C7dTzGGAz97Ejla7QQiZAYaPc592BRdG8+/O1mCCLgHLQUvdFa9ElkJcQHVUO/k7uRHgcKVtPDI1I3xBospaHFLqnA97ZNCQ7O8KpPJRbti/vO7P2cMibiaIABMexLgmamlpOU9spG8ac6ZpgWAAYKoPCWfA35wtC4lygy28D7wJUHZBEMS4gsdHED+JmyNPJ7Pa8/EfIflD9StTHPgE0N51xbfcEfdi54BJaanqc/J5vIJqIpVL288g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgMK1JQo7ckeHy4OMlgHhakyWiZBp9awHdmgSd8AZ1Q=;
 b=LQi3Xz16UWJ9lgdqQC0CRigCaO/En1wMvWuFagkWmCKohWEZ0DhF5aHLHR54lNoKjSMuIyc38tZ+JXMLFgURl2zGveWsLbCuGhFh5gRYoDfzYe2mTHQshkBjuLpKyVZhxWLY81H1sTEkYx2Jm4cpiLfm+0p4NCLhBOqfbfbZzwA=
Received: from DBBPR09CA0048.eurprd09.prod.outlook.com (2603:10a6:10:d4::36)
 by AM9PR08MB5889.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 20:41:41 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:d4:cafe::7b) by DBBPR09CA0048.outlook.office365.com
 (2603:10a6:10:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 20:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Thu, 14 Nov 2024 20:41:38 +0000
Received: ("Tessian outbound 70f2252b2aaa:v490");
 Thu, 14 Nov 2024 20:41:38 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6ca18e7cbe0c74c2
X-TessianGatewayMetadata: bJcijmmiiaYXRE9Pv3J/mfIR/Lmen2qsVZEJXPLpjsttplain23ZHxC8ztCjNH1h5ILMv2JpbmWEjBzi+l1yp/NJiwF+Awxkqt9ebYR/GBuyZwmbB6fziMycXA9QrgrgCPUb2wR9T62gExcACVK+rPDlx7zqi9NvVN97EW4KULSfR+9LJn4k5mnJ1kVQA5KrzpagUF4z7AU2wAvlOO4Hbg==
X-CR-MTA-TID: 64aa7808
Received: from L9ec2a61e0e89.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 F6060303-EEF6-445F-B171-20EDC0A37ECB.1; 
 Thu, 14 Nov 2024 20:41:32 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L9ec2a61e0e89.2 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 14 Nov 2024 20:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkV1lHthS4Y7CJhiTKOpMrDsy5EC6sSpX5pldNyU4zJ2CkgDnrYDSQITrVlRpCHvl0iPBS5f6AZKlusn4YzPvWdd8veQEPhAhKtff1Dd8WG0c43i5NbiUDEFUmJYubosaU11jMlapWFBSzHzLuiF0+AIT0y6LOYlfKif9dg6hRTS6o5gGO/c10ryUP8QKLoeFAKR56J3YpY2bbmD0svGdNj7Lx2LLNHMZBnFkMllcAUPmNHirP8JKpBRflnAQ0Y+HUT2gNuUfmNMV5g0jt5Zphab9Pjnqqyuyeek8wL+EQfBCqFQlJjgbar7P51zzQbDqjUWRLQ2l6AHoS+QFW7+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgMK1JQo7ckeHy4OMlgHhakyWiZBp9awHdmgSd8AZ1Q=;
 b=aHVHPXbm1Kv+1oRqaR1rSpgZ03wa3UgXvQja4+gZ5p3Nj1WjMtJNLsVuCtgOCFw0kOheo45KCiVeD0zIPyDTKCiFLm+tSitJ1mQDCq0BMh7PJ9I4HSm6QMnTelngEQCaYL5xbaRWX0OktRjar+G58AAfDY7DyShBAMNJ4kMCvPYSy/XEoEiwEeaXkvHKpgn2ugT62um8A/Rudl3YdLaiXVYEhAUhrAdH40692fMOfUu8mep6nH2qJhZ7G+7MUuJHKG8liMeG7AJnheoKbUqtxMIw44y7y/wk8y6VH6yIenXOiI5tHSKXoU3PS2TfH9jlA48MOmZaAWRN47PG+amGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgMK1JQo7ckeHy4OMlgHhakyWiZBp9awHdmgSd8AZ1Q=;
 b=LQi3Xz16UWJ9lgdqQC0CRigCaO/En1wMvWuFagkWmCKohWEZ0DhF5aHLHR54lNoKjSMuIyc38tZ+JXMLFgURl2zGveWsLbCuGhFh5gRYoDfzYe2mTHQshkBjuLpKyVZhxWLY81H1sTEkYx2Jm4cpiLfm+0p4NCLhBOqfbfbZzwA=
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by DB4PR08MB9309.eurprd08.prod.outlook.com (2603:10a6:10:3f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 20:41:29 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 20:41:28 +0000
From: Harrison Mutai <Harrison.Mutai@arm.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "sjg@chromium.org" <sjg@chromium.org>, Arthur She <arthur.she@linaro.org>, 
 Manish Pandey2 <Manish.Pandey2@arm.com>
Subject: Clarification on Bloblist Initialization Settings
Thread-Topic: Clarification on Bloblist Initialization Settings
Thread-Index: AQHbNtR7IfdNwkr0VEGp6Lj7wE9r1A==
Date: Thu, 14 Nov 2024 20:41:27 +0000
Message-ID: <DU4PR08MB111882C823AA07294E82B4FFC935B2@DU4PR08MB11188.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DU4PR08MB11188:EE_|DB4PR08MB9309:EE_|DB5PEPF00014B96:EE_|AM9PR08MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 9047a5ad-a559-4585-1dc0-08dd04ecbd39
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?p3Nuy7PkhVeAVehr1KMg9FHyR6cZcowKG9DrbdchtQeYVxn3XzsQktsrEyEQ?=
 =?us-ascii?Q?zEO75aPcFTJbvGOxsklpTXHqJo/SSasOoaG7ZQRuEI2yXPLro4YgQbe9pm6C?=
 =?us-ascii?Q?2eYGRrOqS5tA+Ix+9lcYvYPgeOuPEGpGyZUMcmAU8XM4VXsPqRF25+vPJ8K8?=
 =?us-ascii?Q?brg3eDiAzGhZfzvOC/747II3sIT6s+aTrQlRXMXTeJfeQa8RyL1ZNDi79WGp?=
 =?us-ascii?Q?0GK5+YRqH92OiVMITT43U/4s8wIn6UEcSQJbmbh5pYBb/OLGxjnNz6gU/9e1?=
 =?us-ascii?Q?uipJj3+N/DrG/qWjxbGipDdqy9d14N4kN9+0fhnHQs2Y9dm6x5gdHYPdNRAG?=
 =?us-ascii?Q?FMEiEqiHCiYZCgIX2KHwJUNDEFGmesuRAjQS4Ihwws4gGCZdH3f2nYjMsssI?=
 =?us-ascii?Q?8fzSBOzM6LR0l5Lc1SD0PT/e52f9SGfP52WkkFhwnX+8xoQ0znhRI1JzNFmT?=
 =?us-ascii?Q?H6ZbdlPmXbhqjnDHyGnWpzQCsoF0QmJ6yM+bI0cZjv/bcVoXs6KVOQqxsRGC?=
 =?us-ascii?Q?xoUCnMm8/ydhnQW/nd20KhdvanCTMskIR6gBgDHW2UaSRtyqvcKAVscRriIH?=
 =?us-ascii?Q?wGIJ1E+7qOdPkldtpIDkG1T3SeQAu3Cz/9cwbVhGQc1onH1QAXol4bXMaU27?=
 =?us-ascii?Q?F6YjrNfZTMZ3dkMPQ3lEMuQZ3307Ls1LGOVvN3FaufS09rIwzboj8xQOhWwH?=
 =?us-ascii?Q?y4j4NF80UBhNQZIsDIpnWAagH27Niqp6ovrPIjjHtqzLlaTbtY3cFs00o6x0?=
 =?us-ascii?Q?9AOHDNZhi441fvi74My4xQnYkUyJwfNaJe7M+dEvX9jHISLYia72mTuvqFU3?=
 =?us-ascii?Q?yt7cTaJwymAbbtFCKE93tU5Z11qFWO5SZcfoXz3XM0se2IXUkj+z18wDhg/5?=
 =?us-ascii?Q?s7x8i5ICODDT0Et6QC6jYc8EXsZyxAvSnEFIrsaO9mPNpNvJxGH8hEM1Qp6S?=
 =?us-ascii?Q?t66qjCMZYwFhCNORP1vTWKxdJN3pBhYSEL2W763pemwY2sf5TAPV2WFCSmk7?=
 =?us-ascii?Q?s+a9W2N+8xZU/+YFgUaytDEclUr2cvKZWdj/FwNLsaujt0eusK+aKRklkToe?=
 =?us-ascii?Q?W1licUtG5bxNblIGzE2eVAdJabhZqFZsESgKhWJ6zsRsBtyut0dSM8BTiWOJ?=
 =?us-ascii?Q?YduElmmQY1q6Is+DVPRRHiEzsR5zzccQ0le9g2wJ8hUg1JDXBYdOR/H7QqTt?=
 =?us-ascii?Q?dDzDebxoHcRjT4mgT+Z8YidEjP2R81mNfUGf9PQc8mMsWZGkjRvlQUXuN5qH?=
 =?us-ascii?Q?m5u7YsM3SaJfHN4hqToB5w3WkuaSkuZA4VzGDf+XC//PkWHWRHe2BoVH9cza?=
 =?us-ascii?Q?4PhmBKOet2lTd1eBwlAkJPCvuCJzdzwuZERhlY4UyqeNp3tIiheDJR2IUWCw?=
 =?us-ascii?Q?OQuCap4=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9309
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c71ed90-f1f3-4d92-322c-08dd04ecb695
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|35042699022|376014|14060799003|82310400026|8096899003;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?9Iqh2TpUCFhkfaB8YejWrJ8OIIKALBVqCzkEw4cWyiM2lecdwC2oN+ymZe?=
 =?iso-8859-1?Q?dNOd9BjB+4+j48fFP3ZF1svq1WCP9cs4llVOdTbj1U3Xa+MO6W9q6Y8zQl?=
 =?iso-8859-1?Q?oQRg+Xtbif7tM6cdPZ4TlsBT0squOvHe2LdVntY86g/ojNB/CSAKiE6kIS?=
 =?iso-8859-1?Q?PaXjkmEMlf27aN/xVyXEJuKqZSloY+AZ4Y871jZNsxKaktg2ySDBY9FXMr?=
 =?iso-8859-1?Q?Urf26jVEErT5Q4RM2LMCtlP6NFtEb8PGv0WBOAFY+e2HgGRzujN2AMZCSR?=
 =?iso-8859-1?Q?H7U2kGAA2VFP/jiwhxnxMep3UsBWmqBA03HKDQ4z//3axYVfvzsZkhsJbO?=
 =?iso-8859-1?Q?mbg1PHYfiQ9qj31iilxZPzjip9AQ0FT3SRvLz8LwPT+R+9nAznZI8IgRy3?=
 =?iso-8859-1?Q?JTBVbXaqnVOHhbDocSzXZVOlmp031eP62FpjuOuZnEVeixdFqyhkD1G/dm?=
 =?iso-8859-1?Q?CUXkUYmF327CMMG/eQ5+ux6AuhUOtLCi6op6RZn9iOWqk6wK89qwU9wdqf?=
 =?iso-8859-1?Q?Vmapm/eyhJt47JEhY3CjIC5vduzFpNO1hor32obno1guqCFRhF8cx3S+I7?=
 =?iso-8859-1?Q?aB+DkvBsyMAlMU4r5ewo3NshALUAAQkxwrLbmfuSI6haWp9MmWF+VY64BT?=
 =?iso-8859-1?Q?8TH/vDb37uTbElpussM7Cb1sCunQxPn1XIIoeBA4NnsTOcIfesB2W15bhs?=
 =?iso-8859-1?Q?DLHXQMtDWATrCY/0jPPlfRdcj1aJr0Ln0Jlv0eIjY96QiHHn+xOPW9qRsA?=
 =?iso-8859-1?Q?CgqFUjncwq+Oz/mSqs3Q9NfOW0zOCP8lC0Uo+pYnlX2gOz71t8XIOHyRq3?=
 =?iso-8859-1?Q?F1zYrfIzKRT/hnVlaNUQhJf73RsA1e2O6Pd91nIiiEiPJPo3MSxzgtU2FF?=
 =?iso-8859-1?Q?WDvG4qneY7FUDWZrJ/3aS6AKA75lDmwCMfABEExeZ42v75H38VjeDZJCCq?=
 =?iso-8859-1?Q?kNl9jpCyo6UQFMW6GH3E0qeZyqJQbX4xT3aSPTxKlZtyQNDBZu7+y4JDiC?=
 =?iso-8859-1?Q?0bBXOld0oo9CCY+4NogjRp11axzQ0naF5bFNQtGVttjEI0KhmdxQ6QrFEq?=
 =?iso-8859-1?Q?fw5p7a3/14+V8IC1br/479IBJsfuYagQo5RezQFEuxATV5ln9Cd1y6hu3J?=
 =?iso-8859-1?Q?tXV85wFySnRzB8Je5VfaQYNqpdOqROcdCXSDsmLl4I8Kkhsgjoz/nVzv1l?=
 =?iso-8859-1?Q?RwAlaIS8ECIMwnw0Zdzp+IafN2SgTe/UV3SSMWbEy3i+pys8C70aRok6/o?=
 =?iso-8859-1?Q?X3QVvfr/U3YayCavfLfoNQ1Ssi2/n54gw2TwX80diT84DBEhvtO6LrTcz0?=
 =?iso-8859-1?Q?m5jqEmH3p4/d9MbeP9rUh/9TLSC7eYsSod/0c7vumykgmjAtVBmDMFeF7J?=
 =?iso-8859-1?Q?gCRmzQLIbeASekcWb2YOLhubnP2QIhhsiE6J6EWaNzH0Q4ebHNCfODlIjh?=
 =?iso-8859-1?Q?Gk1DEZZoj6TQQu8Nd6I6s1GBAlAsCmnA4JtXTw=3D=3D?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(35042699022)(376014)(14060799003)(82310400026)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:41:38.9752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9047a5ad-a559-4585-1dc0-08dd04ecbd39
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5889
X-Mailman-Approved-At: Thu, 14 Nov 2024 23:19:54 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi all,
I wanted to clarify some details about the settings for initializing a Blob=
list (i.e., CONFIG_BLOBLIST_ALLOC, CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST_P=
ASSAGE). The documentation states that if CONFIG_BLOBLIST_PASSAGE is select=
ed, it uses the bloblist in the incoming standard passage.
Does this mean that the bloblist is used in-place wherever the previous sta=
ge places it? For example, if TF-A passes a bloblist at an address specifie=
d in the platform's boot parameters, would this mode use the bloblist in th=
at location?
The reason I ask is that I'm preparing some patches to add bloblist support=
 to vexpress64, and I'm looking to configure this platform without specifyi=
ng BLOBLIST_ADDR or BLOBLIST_SIZE (i.e., automatically detect these).
Thanks for your help!
Best regards,
Harrison

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
