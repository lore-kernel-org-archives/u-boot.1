Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16639CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 05:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FD3783F14;
	Wed, 13 May 2026 07:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RTmzPiXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0C783FB0; Wed, 13 May 2026 07:46:53 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF0528341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bss4xR+iKqEQrkxmvsfYPnBwf25rKEauEUA8Wk9tWL4p985/hw/9EQ8Qfwm6bLMKthEFWUIAsfSBdA/59qNkb4j/Z3RhPcycyDlYspJ09pTyE45S+/Fecl2Q6y13L7nalG2QJPn8B6D+rfKRPMALP4XcZQ9Wy44oI2GmK5+5wX4Ef9qmoU88HuEqxTVL94LeEPjFGH2A97Pl20oEnp52m6QD+K1q7GDus2Z/BPjAfhICnGd1+8zxdGL9zrRERkHL+qL0go8poDQmOx2/BWMU6Vti37YhG78YYb9D/+NQgfwytIS7h327fSBBsqGgKPcD4ObQzw9lWAvashyLLbG6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3VEaCU1uA+UrFYrZnh+ehxmbzsOL7IfnUyDJv7q5kE=;
 b=hxqYUzRhwfyLzRu5yRLztjtLXHoVTopFWPmfIh8qK4IIYuluPfoesb6paeiHK5h1P1fiWA+zDW4Y3ywYKmPmvdtwVUS/KMPqU3m1rkJgC9gcrCxKTv9zu1HCHVzDmP7oDQf5W3+azsuG/o+MF5zk/IDUMHuKoOn1j49TQGRSBb6d/Caq06+54Fo+ABpHst8/MY+SGOKZiSJBtqUpPU01VQnFXI1LBOUUYnyXF+rFxJsAZWbLaOWqk91lWj1LqbHtiF+8naJHFsWjCQHUHmhm/FgMISiPf15kRl+oclX7HT3eOconCvIok0ixf1533pIdoplwhV0Io8ZoauvZBCvF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=cherry.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3VEaCU1uA+UrFYrZnh+ehxmbzsOL7IfnUyDJv7q5kE=;
 b=RTmzPiXi1FEEhhdxmo2RF5Kw6A9T8PQKtl97hbYQpE2kDZCkV57YVbjZevjh5/GiDAiv+GUR1GI+7FR5G3PxHI04hcU3u9Y8lNWKzmG4osP3Q3Oyrr3G/lje3yoso0wsqrDLnnWV5ZD65wccm7Y80hZHty9aSVhpv+IWP8xBjecexhCpJN4pgbMhxvaR62Yjxgx903Gzr06Q5B+k9g1w1r9s/SfFzKLXGrCsWhlAgtrHxrPVF4J3oPKBGEUFPacDSDwrWx88Y6kc44gA7nq/tw4Yi9itY2AGGpG8VbUfvP1JhvIFeECtixqlDSJznvpgMINhuVsmhHMyxZ8PffMGKg==
Received: from DU2P250CA0001.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::6) by
 AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 05:46:48 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::3d) by DU2P250CA0001.outlook.office365.com
 (2603:10a6:10:231::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 05:46:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:46:47 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:50:36 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:46:46 +0200
Message-ID: <8bddc5b0-70e5-411e-879e-0c1ef2bf8c69@foss.st.com>
Date: Wed, 13 May 2026 07:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mach-stm32: Remove remaining non-existent STM32_RESET
To: Quentin Schulz <quentin.schulz@cherry.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Simeon Marijon <simeon.marijon@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>
References: <20260430-remove_non-existent_stm32_reset-v1-1-8ec87c655379@foss.st.com>
 <f99cdfe2-4490-4e7a-bf76-edfdfdf2080b@cherry.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <f99cdfe2-4490-4e7a-bf76-edfdfdf2080b@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B90:EE_|AS4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5711c5-7ee0-4e99-053a-08deb0b305df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: yEIWXmDLGZ0NRObHEv4eCcKIX8TRo6KE/KrAzOSjrV2yxdUwBa529zOe2Bb7XCufZu7nWJj+ENJTiCgqZxpINeBuxyxT02CbI7wt7CfhQTp16GeZItvvLWntLC4yTfnKTUcOnC1DHPxvB7Rzo21i8oRsbRzV2nPyJtgeslLHeSbmlYeURKhA8nKCKbFRpTs8wgBnkjTroW6kIzsOjlgE7cJrKtq7XEvcvDVmuiNw1f5+I2uvnJ5qs0a9h1PN4DU4jA7zKVFryl012/b5OY9hXKxbDjBN6sNQ8rMk/v5wT3UDxycaqtVa5QrspATyWZEouKJlG+Y3s8wvr1CZ/o5KG3H6yeLZ2jILvRG9avuhRLh/nQRxribxf/wADfKIT4Km17pu69E8jJauZwKa0T0UCC0Jmp/LCOHg7SXTLvQpUnaIGnJxFBhSUONWPJRuFOMc4hYuqk1XAHdZEibwzvEV00kPSIci6NK8Vonv/QEVXUeegw9p+bIbla1qcA4RsI6bLZuI8EPTGJ5WwMWZK5C8B6MtWgiyzf9cwRBXfptrEsEXBA6Ljcyi4TwDwl/WvyLKqUGLjrpG92XlWt7pBkc6iiviayUCLCRVUtKkPNWfy9xEZUx2Wwwg5gs/SBYiun41L3iA0kn7MPkOxf5fwgiZrQYnGkaDBOQm+Vt9N/lpcS4wYYIJ0q3gc3+NlC/WYyFVBnJgkoiYPTNQ/ZRoFA1KjEHqhMV230exKCV6BQVUIxU=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b3Hql+tGht+iDyg4FSHTUWj/TlgVjafFX+a4VTk2drHpMl55qnTOB75hs1tbhwGoWaJE5qDkUsgOJl3tAObJiQ4ZVt8PeB2Qof40jT420eKX7hBqy8rs7kpdEcWxhJ/lBls5pqCXfgfxMATnFOsVE8NVamQp6TU4VNpmTPYUKQV+EFuyXvEWs0tQD7siYEZKRb1VYyYh3rAKg4NXagY4Lj8ti2gQsm8SUXz32hSg7PC6XGKMeuaQTXHa3Pzt78FCpd2/FA79nCpRCnHkrrSpDrPElDqKK2EpuAhb9jTToboZP4vu/J0UYXKTsadpaFZOZK7dH0BV9E6Pz3ggwzJ0LsrseVnxpbKceHLYPAcXfQM4Df71y51yZT4p4EtMt6RvdMfFnmykjNDFNI2ttquIT8bWoAdslwjanR4Qs6TFZ0mvBbmLIBVK8EsQvz3k+j5k
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:46:47.6161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5711c5-7ee0-4e99-053a-08deb0b305df
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6181
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



On 5/7/26 12:42, Quentin Schulz wrote:
> Hi Patrice,
> 
> On 4/30/26 9:14 AM, Patrice Chotard wrote:
>> Symbol CONFIG_STM32_RESET does not exist.
>> Don't select it.
>>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Fixes: fdd30ee308a2 ("ARM: stm32mp: Add STM32MP23 support")
> 
> Thanks!
> Quentin

Applied to u-boot-stm32/master

Thanks
Patrice
