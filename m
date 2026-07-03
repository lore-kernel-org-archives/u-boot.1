Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE496C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 10:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C42DC848BF;
	Fri,  3 Jul 2026 12:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bf50lkSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B0A848BF; Fri,  3 Jul 2026 12:13:02 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DD4848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 12:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYLDeUPK58a5dwRJv6ehJ/OwOXimJuN6jw9y3h3a+57safhN2vyIkNLxMfZ0BfHmV4ogKgWmD+vceziKxwqv4ONknjsVWOknDyTycp1CZyawap9jhOf7OCGTNdIWgEy4YZg3BPPmEOXDA2OTvo4fYnwyJBmdZ83XvZc1tLrrpI4ZmFIqS5gAaCt54ZWgTrHvshF5e+uOgpzedS+nH+EhOvvWKrzkWk8+f2gYm+/Y4hGfESeO2UNYh9tZ9lOYqTJP+uX4w+Wqrbd40J2NJntC2ekR+7gs3FrgkCwhK2jDRLs4Da5GOEx935YRAAdAqE+izS60GgNtwqsEbCjzs0mncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqzJ2/2W7uHSMgNIal8eS3uIly2iWOS8MeDtUmKm5qw=;
 b=QfV50pXDveK9KXn0gR6x4cUKlCUg+Wvfhtadjvo92sWvx+rXNU8PW80lmDGj9Ayg6iSzkhvGIqxh2h9GAlvZ1NCVL1SESaAPc6dTQyzVlq41L4dklAw9OcgvafiV3BQ6Da4H+JDk3eB0NNoM56MAvoRiWIkFqDQpQbaGDMUrBhx/3yJWil+RhzC4wmmEYot6qY7f+oHfhboQLp3Vrv05QhO6GnJ8V1qIfVczaBFkFUzlxgIRrV4x/IsDeCEcHPLzR8PGlGirmVba76brRsUoOeOdz3UpAZMjcfz1FDM3eRNUGwI7zizORH3sqbH4e9wxdpUOxD504Z+sLMebrLV1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqzJ2/2W7uHSMgNIal8eS3uIly2iWOS8MeDtUmKm5qw=;
 b=bf50lkScOVIAYBe25NlixmSKFEBU2szhAuqgj0b9uyVI476l7sbaowHLu3oWzR4bu6jAqx2iRiAzs3fhGwzyZ1xuiEA+R+Gb1ZfLIUN3RUumkgChJGg8d/yP9DPVvQqawipOSHtulrIb7ssPvVDP2TCH6NLhsxbYsei+BPPZRDJL16pC6ja3Pz5q2G1BLmqdP+3lYfG/GEDfho1mpu9VoSgVhm7ccfAiepmm3In6RlOYmhEliR9HHGFe6An2k1TstqRoxCxESBMC7bpCRkUXci42zhaIBrARPM274KHIkuNI34tAR3Z0jVj4TlNj43pNfMaYXy4dYVnYTxQ9B208JA==
Received: from DUZPR01CA0043.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::6) by AM7PR10MB3304.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:10f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:12:53 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::83) by DUZPR01CA0043.outlook.office365.com
 (2603:10a6:10:468::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 10:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 10:12:53 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:17:39 +0200
Received: from localhost (10.252.26.28) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 3 Jul
 2026 12:12:52 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/2] cyclic: update and optimization
Date: Fri, 3 Jul 2026 12:12:43 +0200
Message-ID: <20260703-optimize_cyclic_run-v2-0-81762cff0b17@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABuLR2oC/32Nyw6CMBBFf4V0bUnb8BBX/ochBIepjBFKOoWIh
 H8XcO/yJOeeuwhGT8jiEi3C40RMrt/AnCIBbd0/UFKzsTDKZCpXRrohUEcfrGCGF0Hlx14iNJB
 kVpuzKcS2HDxaeh/VW/ljHu9PhLCndqMlDs7Px+2kd+//w6SlkoWBtM6V1jZNrtYxxxxicJ0o1
 3X9AjcQC2PKAAAA
X-Change-ID: 20260702-optimize_cyclic_run-ecdc46f12829
To: <u-boot@lists.denx.de>
CC: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>
X-Mailer: b4 0.15.2
X-Originating-IP: [10.252.26.28]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|AM7PR10MB3304:EE_
X-MS-Office365-Filtering-Correlation-Id: 72235f6b-4cfa-4a6e-62fc-08ded8eba53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|13003099007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: bjzDCCcicS4/Fiht8F1Lik2ytW4hRztiDj2wj21xE8s4mEnCkR9H+aS8P0w2IHHTnGnmwsbnFPRTjuTSlmE9Vbjwsm5R0jLFsOBCHXGxmTmSTv/XGzcVj6moDB2TV/gnrvcvmP4XfLi7pdtgILhuQTmj0dn5kELsRocYD611wm53WZRCkkKQpvx9HUszPp6DwRGXbTYIXonDb2SWRB1R3PTxBbKW9KKTdpOdNVI/Ch9/6u7/4ld2a9Svk9R7vmh5Z/TxTveLGXBtjLRgjMP7IDDUzSIW9lacm1/34gkBSdZYY2zJixC2ZIJidr0VqdQfuPo0jLCPmgjV4h8Y7dp0HtUoTQm9aPo5dNHvmm7p13HJ0jnJmIx4GB1kR21Izyk92GYAw9X/vhcgT5gsjk67wvhHdW2eumZJEi+e6DA8OfRTPGpTJUcXX6ZCIrY8BjBh82P1UVgo5CHF5VpoymoOZQk2W5U5MC08Tt0iOzYyn2U3VomGnkk7MuNP+BkhSUud5P6ke6fjfAMXhkVX+XqNEx/1UFsc7Y7j+uZILQYDCACwMcNqVEN30c2d9+ZrA/qolCwEsI2g3iDqazRdeWDJqtv0gB+ACrB6So99GQ9q9cRiRW5QYFlGvxaXOpZ1EwsjM3eAfOOo6wbvuYXYGoZSAg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(13003099007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rJnHxiEJKAKBmo60Ix8DdvWgW6+cN0ljJ26mTUMd48Y352ut+ZLTDwbr7IsXiDMt15RRJfHh9s1n0nJlg9jMyyY9pYYphcZqnkjRRApKWZuWGGgNHbS4my1sclSuazGlkO1Q+KP35NyAEFImCHJZi8cY1UoltKYCV+J9a4CSygh3KoU2Uv/lKV9Mo7zvYFLvhOn4ZoCyrzM9f0do5h1OcrOABaYRFSnG+qLLOFOowlYZhYBDKPhxPmY2J9cur/6UOjbXCZPlF6I2fkgbNKd0lEyogADDPWwbSlt1CUWDQkIIqLoRAe4ufvsY2YKfUjYnqGm1A/XqHAH4VHIgOVRxy/bmw7ViyxiDUqvAEZSOp1NX8jHZuyv0Ua8Vhqv7Gq0j/vTg0Ne2ex6aXQZiKqTPRZ+9y6jyOvta3nrjdPG/5fHN1N6Fd8975VXWQ4GmaY5c
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:12:53.3312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72235f6b-4cfa-4a6e-62fc-08ded8eba53f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3304
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

First patch is replacing uint64_t by u64 as suggested by b4
Second patch optimizes cyclic_run() to parse cyclic list only 
if a cyclic function's timestamp is elapsed.

To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- move cyclic with nearest deadline on list's head.
- Link to v1: https://patch.msgid.link/20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com

To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>

---
Patrice Chotard (2):
      cyclic: replace uint64_t by u64 suggested by b4
      cyclic: parse cyclic list only if next cyclic timestamp is reached

 common/cyclic.c                   | 20 ++++++++++++++++++--
 include/asm-generic/global_data.h |  4 ++++
 2 files changed, 22 insertions(+), 2 deletions(-)
---
base-commit: 1296a428c67cf103eca482d4a63349661c1b799f
change-id: 20260702-optimize_cyclic_run-ecdc46f12829

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

