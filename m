Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DF0C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E849847AF;
	Fri, 10 Jul 2026 06:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="AgR1C+R7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D76484A3C; Fri, 10 Jul 2026 06:51:49 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E638498C
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWa7RyraioOaJiJfpnyWw9AYpRcp/pqVRTftG111T163vMoIBjHIyLHbOmhZLkn6efjGuYaa4KlAJPqaZDoUY63HsRbdtWZPNlWVuSu5T7/WBl2u147Vad8m8p/c4KGp70n/ZyzOppufPBc8Ytq4mYWqqsLVKI0MLc6sy7M3JfyhXTVDRdgsYrlJadmOPjeMtyQ2H66/K3HDMMLxPOI5X4tzqcqEfpl61Kp9Ky9EEomMgtEhxThhN+t/MKP+2OltGawouivMIws4MVYXxkPyLVcN/OXqatttgEYK0ZIBBFK/SEDAn2u9a9asDc5kyQncFAUQzRY8/z4+D1kAILMThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXpXFORhfc7nck6gRVX51KfIMOB45eTHGpjg7LpBVao=;
 b=yuu/ox7+1yBVnkUHaJJSI0efh9jd4DLEmaU+TFj8GcRI1vXJoESkhF4N55y/Pkfa+EeuP+ZX+dAuNOj0HEQqQtdTfv2vg/N7ETcCfpJBIAMPF6wwcEJAef/0SPbG1x+BBQO6oePa/KHMRq/Hzj9uUI9LWpt8BrAl/gfZq+DaJE/pn08ijy/+ve0GE2ltRm5iRVIao0lNBsmOUFT+XZMJjXj2rYl1gusi1lRoM+ovtez22x0vxwddBCdvqnHydr/0EjnDj/t2mJZyd5BSF1IEzhKw2BpoWaMGEIb/5VJIiGWehPGATkrws/WRW11yIN8+w0HSckzEJ18OX3HbnuXP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXpXFORhfc7nck6gRVX51KfIMOB45eTHGpjg7LpBVao=;
 b=AgR1C+R71gTHwtVfixLpUhbun2Yjuy15G1FhlARDU5URFbs/2CeT0KPIWHht8dAz0QooqcqBBFDfbL86YB++GIaPtZiDmQH3r+fjToIszIKcse5A2+sllhR7ssLY8wVBq5ONoGTMjeKVLAKMgq3iIGzNs700/q8yL08c+GJS96+SlGhuJunvFMm9BKHXSchprJ9gO/tIgOgloEMmODA7WKG3Ao5fRKvicKcVaTNVLA/l9lYsrZ7bce+ZV1pyr/FENdWOHqaAW7C1xas8mttUXmIF0G+5EGvBOX04hu+fVHDFD8+9RDvn7mx0xDHBlaNMWVUOsYCr7A8q70H0EVpkbw==
Received: from AS4P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::12)
 by GVUPR07MB11899.eurprd07.prod.outlook.com (2603:10a6:150:33f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:5df:cafe::30) by AS4P250CA0004.outlook.office365.com
 (2603:10a6:20b:5df::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 04:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:43 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AAD4B23B1E;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 10 Jul 2026 07:51:22 +0300
Subject: [PATCH 6/6] test: wdt: add a test for wdt_get_timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-rinta-watchdog-gettime-v1-6-9a982fb93f49@nokia.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=715;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=mzX2LH1Be+jLjElZ58pSbHPZKUSF0SxOgzjNd0SDqqk=;
 b=WUdVO7BDXzaQSA5Q+otYhgemXonLUpFhlJ3ZubHhu/pY22jqLA2ORfUdezlEi+AsRx4MhvRn+
 2kH0M3mXqgDALL8lNBj+8Q6bf80i6jwZDja73+eiJHuSdPTrHFH0U1p
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|GVUPR07MB11899:EE_
X-MS-Office365-Filtering-Correlation-Id: ca96fe6a-4e27-401c-f4a0-08dede3ef076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: ki2+zU/GFPj1Wb06l2aJYvBT+uRNG8VXu1n8TAxrgwuVh/fpxUrm1PFa11hyd+9Z6KPjq2NHoTL3iGYfA3/DrQ7csAhCBwpoBXz3mEJQs1muK/RWE0J2XAomDVo4OJAVm4FBAVdzbQtOkdTI7vpwjIR6IDBHTcMYffczJ8oKqEZiMuQRIaxlrSwb6imQnZpLAq0WDQetLZ+MyygynnCHRqFh3PCcm6x6PdsPx0/scYJmIfBnY67PrebQ6GzCGZe3IWWNHWNuvSU7N1am3AIlG+i5Ea46EGX+s0MCSpmoeVfPtuVZFNpDw6hqk/Z7hmFQDuDT5vFL7PfQz/qNbRh+W8HkeRR0a82keizPD6Bm8VFKfKPio+lWyVBF1Bz5zVn1Cz/Qsaw9UEU1xe7O/8famhJkd6wC6ApnqrspZBUXwo/RhRwkMw78T7HEjkKdsxNpsGxk7rbPS2l4MqlN6qZo1kiMT96D7dVBzel+4fH4saX/zWCHqgUxS9xN8UiztKqZK+MY7bwA5px1juOsRJ5Ub51td+ITcRzCMDsQcfX/W+SNTt2vayLYV4h1ik4CbFp/+SctzUuTRqM3FEVBE22NA2mdnlmzSjPkMeNwXp0NIGZGhYg/uFo9/Atp9DtBjQfOFSyzDugP2hXXpDjmI8JKgP81JRhC6RrTOZXxxRtE3sCxSxAoX4d3IH9zploUjrR7gLpRlsi4jM/pMIXzNU8ITQ==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6WU3Tr4q6GyNFwJjKaEzDt+JRL0k6dzTusdVvRicOtF4oUeLQ7MwFr/IwThwY/P8ttSKtk3DRZM+93Ozw0FCz/pLiLrI/D2gN06SuumDIBjqMDOQlgzjWzU/IiUG4oM4B45uf83OB9xby4d/9klbkPf0GOS3sKCmOf04qdr8VaW9fqu/Q+tT48+YnquHn6bvH3AhCBIf6htc+Y2rmzXVKMdtTzKAvm050fMlP/ELst3KQMgp29Y0+AHh2ySk7EL4NX2hsHnqKIV7nIZ1zmC+qMPftRpFWmhayYGAqoxn10V/5YpoNTFrVGHFvV8AK0gAtiJwbuLTDzmaeBpu3HQh5nYt7CqI2K+FrW7ynPrQ9EaFRb4rgfNaoyjNTTQZ2eT1OZcqfyzrZaB1Drm6kpYSjKrhKu2T5KGG06MgWA4XFS5OeunfuVg1120r96MdGcjW
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:43.5896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca96fe6a-4e27-401c-f4a0-08dede3ef076
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR07MB11899
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

Add a DM test for wdt_get_timeout on the sandbox driver.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 test/dm/wdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/test/dm/wdt.c b/test/dm/wdt.c
index bef29591d5a..b7888556cbc 100644
--- a/test/dm/wdt.c
+++ b/test/dm/wdt.c
@@ -38,6 +38,10 @@ static int dm_test_wdt_base(struct unit_test_state *uts)
 	ut_asserteq(reset_count + 1, state->wdt.reset_count);
 	ut_asserteq(true, state->wdt.running);
 
+	u64 get_timeout_val = 21;
+	ut_assertok(wdt_get_timeout(dev, &get_timeout_val));
+	ut_asserteq(get_timeout_val, state->wdt.counter);
+
 	ut_assertok(wdt_stop(dev));
 	ut_asserteq(false, state->wdt.running);
 

-- 
2.39.2

