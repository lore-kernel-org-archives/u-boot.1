Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C20606A323
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YkUh1EWo;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FmySCr20
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47E8660730;
	Tue, 20 Oct 2026 13:51:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L1UpehBT6CbX; Tue, 20 Oct 2026 13:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7EF796076C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504279;
	b=TrscRQc7I8iWhuAAg1UzC00pwX/IEkP7ECDSShhWqA0T1EnQ9P2AdtdI3Q6iPQfHI60Q
	 C8qHIUgmus6K5bg4RQ0Z7/eYvdclZR6dPoeBIbxKJg78YuFGgkvvBlVLJwBzTpPQSJu8k
	 uh2F2LVP+W1S0bRnmFedUsEC1f3X2zmEqsxus90EchbbfLpXBZePrnbq6jJMzoRgyY4WQ
	 Q+5hMmiXSE5lyUDmvNEUqel6DEvB+Bi/bMFPp2tjac60Hw23KIm27uQfRpRGX7kD5wOVE
	 5wi92tQIWIOYoOdYxRByqNd3u27v+1VyDY49M/tPB6/i8RFXVnGhPp3NHE8N4hXspSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504279;
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
	bh=spJWDuPHVbWj1rO2V/1rh/zwxwZ5LQ9OIUApk3NBhv8=;
	b=NrGZnZKt2E8ow3LRQwYSOmF1cImQBBnHcfROPuKZ3L+0BztlUDcx/fKc0oIrP0YX9Ctq
	 am8uq0IoIn+rQxABdxZwThwrpwnO2816KWVrgj/LVwUPsBITDP5riEOv3x2n3A//w7u8A
	 5rf7mv/7pHvkmGm2wkTnF7Zye1iTlaDQzxQ/T2VqkjysN7dOzBSiFy49nHbd+JtYLkIgI
	 cUsbl3rFe9L10HuD3sN6z5kP0qatkovAZQmEfRFgvGQmc+Dr6D7de76KV4sMnT3MkGGS3
	 H+V0JzYLAi+pCC4hHOZ3n3UMpqPho4HbiEL380VlBGKDwhiQuPmGHo2vmU97CDAfqeg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=FmySCr20;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504279;
	bh=spJWDuPHVbWj1rO2V/1rh/zwxwZ5LQ9OIUApk3NBhv8=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YkUh1EWoNnIDwMWOxTc06gL20dhekXLLCDWYY8M/Y3CtxhcqHJgzCDhKXolpZP6AQ
	 OIDH3RB7JYip1w2uelwCBrBmQPKo0trHRHLtnW2ggDpqsCZtQQjMtCm7geyfGPgVil
	 0uwZ3F17tIZ1xjhe4s/5hI1lH6L8I0+NaviEKQdV17bUnFzMvWiSPOrv+kmiF4yoqP
	 SOj0YHQN2gtLpD8rKc62Rd0yHCCm5OgWoY0Wi0DIPH3JuyCb3hRJLVIlr3u/iJ8h52
	 z/DNDxP0jdOh+r0JG+a+aPVyonM/dhIc+GGK/+8Kj8vD/UyFKUYES5Qcy2i+ySIGMk
	 1mERRnyJUSVag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EF796076C;
	Tue, 20 Oct 2026 13:51:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E5A7D769
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:51:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB3B76076C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fCgwNnQKXopR for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 14E6260730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.61.36
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504277;
 b=bHZme2Xnh/agjs7eQwWTKXdn1HH6c7Z6jtROvNEcg0N9n2l1xLI91OktU5qZmgCFhEZJ
 1F+MkV8PBal0berOz7w6W1GMrx8xgTfgq2L9A9vXNJnp9K0cC29E3GZqMm6AwE/G/JSpu
 veNwVhNvMAsIyWqSs6wBl0JyazUXVMNVg4v0jysm4FukoQiYI2IB7wYlIElr1XgSROTIo
 ASZfC2xHdAns+/d61CN1WN2qDz+OyxO+vpoYe/J5bc77/CmyKqgYZ51nkXRLhFqqws3fX
 6WQbp2E+JHw/YtskHx/+JpRUUzR1USoiB5u3S8m5w73siQGzwTCUMC56qu0xyQo+Ubw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504277;
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
 bh=spJWDuPHVbWj1rO2V/1rh/zwxwZ5LQ9OIUApk3NBhv8=;
 b=k/5lDwSVUa9GeKRNcQjg5A6unBQRXvoikJwO7+JzTyUNpzbdyxdW8QDzRMZGcFZUEPFr
 hlmlrO+bLCi0rAFswbaR3dFxHgzPTE7qsuMXa5UB/M/4vdHGAHoKuRjdddvvew+V3BI7g
 LOCbTEcAWjqW+er24//cVGm/rhZeruTL0Mv0KXEFqvzery6vgPx2b74JyaLlSFvLtKkyo
 2Is4EBTycpJZqqzInb+AphXGDVDN07uLMX83RvSZfHVbOqkUxe08butCErxsi7kevUero
 /YEALP7A4UDmahsFartDPWKpv1j/U1FbHTGnnkK+PAtercU1y6DYgRHebF2l6tfxyBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FmySCr20; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.36
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.61.36;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FmySCr20
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14E6260730
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKQipPGBBiUFA1B9eMo5+xsdcZMLiAlSEKnxMqP0hXBfDeSL3QWBJUwZcgymtP4oh+NSfgvy71TeM7E9rfKGQr4YfzqpVt7k6oXDDeyYKTOSbvKXBDxZOZg4cNkCqKjP+oCbMKOyQWuTmymo8vJwYseEuOxMsjpLTBA5ilYKfjYFB8VyMCNCK3v8PBONrawkytRRqDdopPet4DAxrqzvo7cVz2CZsxj2UGgzOszWSZSbnb01WGNlI54Yyc6EsSQdVJMGD72EDUans3o9d4qMvb4FsNZneLKQQ8CTEsFRHdfnCkJJuA2RDe+Ro+9Av3IIaIQV4j+3dWCLy5G6Yk4+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spJWDuPHVbWj1rO2V/1rh/zwxwZ5LQ9OIUApk3NBhv8=;
 b=Eytduz4PCjPIVLHJO9ziSstmRFBDK5b/8fS0a/D/B6K1FckIOtKVZN+oz6Xw3G3FNnIEZwxqo4x4bJD7NtBhXtytvxQUVlBXBOWCSuUyLsFW6yKb1JFd9oTrLZCQ6fkzkgZ8PtCKJrorYEsrlptoPlMPQet/TtLeYSVBKutJf6KUrDyU1rhZQRcrt4Mf1j4O3nVlEVt0i2diHcTW7qUa332nQ8sN3bH4f7pUIy+FJZ4v8f6WPInMVkXvz99UL4M0bx+UtbPqSvNn66F2cEX8+pkN/42FRAWdLmJZS+lzgVuoZo3WlIScpWUQ+x32eaFeJmbGGh4C3715GtNJ+xeqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spJWDuPHVbWj1rO2V/1rh/zwxwZ5LQ9OIUApk3NBhv8=;
 b=FmySCr201IB5UMbUY8LCSKyOc6qS2c46hmgS1DW3B6AqFKWMGyqkwEJPgXWCW8LqQ//lyJOXjDEXqknJUBo0+oQqPgAGhwJ3v87o9OoWoTbLeesPuwe4HKpxvQqHyMmMobALiaBVrfKPSAyNyJz/MrDZBhf58ac8YuUOYuiJ3Nw=
Received: from SJ0PR13CA0206.namprd13.prod.outlook.com (2603:10b6:a03:2c3::31)
 by DS2PR12MB9775.namprd12.prod.outlook.com (2603:10b6:8:2bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 13:50:12 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::96) by SJ0PR13CA0206.outlook.office365.com
 (2603:10b6:a03:2c3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 13:50:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:50:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:50:09 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:50:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Pranav Sanwal <pranav.sanwal@amd.com>, Simon Glass <sjg@chromium.org>,
 "Tom Rini" <trini@konsulko.com>
Subject: [PATCH] gpio: delay: configure wrapped GPIO as output on first use
Date: Tue, 20 Oct 2026 15:50:01 +0200
Message-ID: <05b8bc65fe5c2cdc8b93400570b9f77f2684e571.1792504199.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4QvvBbxVLFyEQAftrAOZmC5/Pk/xwKbqDeCLBXaruC4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL+zbdunOCqPKOUyxzzzZHqovvvXtz3TZjfOzuEOky
 szijsoHdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEHFYw/BW51j7rryDvvWes
 n+uDrj7sNbBn27xs58kYV777yZ8MfzEz/Pdq+xg6+emF/IBf5/adsJoSNkuH77PhpgPLPnc0MmS
 r/mcCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DS2PR12MB9775:EE_
X-MS-Office365-Filtering-Correlation-Id: af7c9bd6-bce7-4e33-012d-08df2eb10fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|18002099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Fhv0W3ML5kt8QsPspQvZcgw6IMAWnoV/gXBemP+VBMCLGWE4VNHyTMFauNylwDQxukty3C48XxZVZh1Uap5izdWX2L7ktahnFZkgN8GuNPyl5NpjKNQUodphFMQF9ZTeX+i+r2JUH03CzI6v0j+1Q+L0rh6UiQgIwIV7U9XuslJHLLo8dEFVRK9TdeAXuG+8DIKeGhrxquh8fYqu3+iy54A6T68Twku8YeVf6pXfyHKPD+yvTnKVt1S5ZM9UldTkve8rtASoeQMQqXaKVhXEoHjEv7pJ0DENzDMtlKMZ1t0PMH/mMrt/8LE8LUQhwyTY1AFUwzty25YJnxd6af2OctF/LZVpemdueCvWCOTh+fUJCaGj610RTqTS8t2GYMF54rn6yRYpAbwDKid8BL701hZo2Bmj7SEkkTVi+bJmoafyOGVIe/Y3ALVjleA3kf74he9yHJ3t6Qu0ECRskWCHGP7dKHjJaBKWoqEFwfh5oss+psmPVRs9vC6JgI/LZr/Yba5ZEpNrIBStZU80KlG5PVU1hNpMGzd+g0sysAs7tFJx8y6x/AhLL2a6VJcgqaMIdB8UqVfq1Nwe9UfvDjQFlV3Lh9RiIA4LhxwzqiYwIpO/HiAOCqAZF1pKo7DR1JqiDmB+rtT5AVYjBRMC4nNRRXnFXmiRgpmaCezv0gjz7I1oRfUZxYuQts0JqAn2cRq7W9iioWSILcj9Pjc2uBisRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cqhIMQAbjS96klCIqLBAWJ4AZANk4Ptc+LZZUND1FTuOImwXr3Jkir1+hjM/wWin7IY9WPAt8RfJZ/qR8FHdqfAIA+SLirom1vtHeC1anK/rHHP4XICelU1NUGk+9b53cHbPuJZ8Mapp71vZNXj+VgpYBdLpfpkpiHA4R3R5obbIJZSX2fhx3jfIjFSHwVdk+Lvrpj/C0FCKcOJogpuQCH/QT1bL+SdhXafDp18ANNHPYcFlI6ENkyCia3+rWS9ZRydzOWpe/4p4FGKO39quk+Tzt9JUQifbGMVGOjSo/R/WPqizoCiJRReBEE9TV80vZFgEbrS7jr3BJWtXaRFDqeFcVu5nmuz4hpO6rtC3E+u/FgleEJvgEVerGm7Ksj5HUUYUxra/vLdRywIozjpkl5UT1QdA3VCSCGY1HlR/7O5J+nVfRcPo8dC5i8jnWRO8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:50:11.9879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c9bd6-bce7-4e33-012d-08df2eb10fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9775
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pranav Sanwal <pranav.sanwal@amd.com>

gpio_delay_probe() requested each wrapped real GPIO with flags 0, so
direction was never configured. On native SoC GPIO controllers the pin
stays at its default input/tri-stated direction, so gpio-delay's
set_value() never actually toggles the pad.

Rather than establishing direction at request time, defer it to
gpio_delay_set_value(): use dm_gpio_clrset_flags() to set GPIOD_IS_OUT
together with the requested GPIOD_IS_OUT_ACTIVE state. This way the
wrapped GPIO only becomes an output the first time a value is actually
requested, and that transition still goes through gpio-delay's own
ramp delay instead of being driven silently at probe.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/gpio/gpio-delay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 747c520fb46f..5caa6d750460 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -41,7 +41,9 @@ static int gpio_delay_set_value(struct udevice *dev, unsigned int offset,
 
 	dev_dbg(dev, "gpio %d set to %d\n", offset, value);
 
-	ret = dm_gpio_set_value(&desc->real_gpio, value);
+	ret = dm_gpio_clrset_flags(&desc->real_gpio, GPIOD_IS_OUT_ACTIVE,
+				   GPIOD_IS_OUT |
+				   (value ? GPIOD_IS_OUT_ACTIVE : 0));
 	if (ret) {
 		dev_err(dev, "Failed to set gpio %d, value %d\n", offset, value);
 		return ret;
---
base-commit: c5a62cccb6212fa870c46c08232358f4712c954d

-- 
2.43.0

