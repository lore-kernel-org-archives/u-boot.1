Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1423C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FD88407E;
	Fri, 10 Jul 2026 06:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="panJrH3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68D88498C; Fri, 10 Jul 2026 06:51:49 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D31BC8407E
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBIQVdBFMZYtvyIexuGa2oZyZiGhFsqHoOqgp++q763tjek5zsLRaN4iFXfuheeOht3vrzbYIIp1RD9FDt7pdhe1cgB1/oQa0HjJJEwIzvVpceyjuzk3W1aD//QpBWRLPwkOFj0WRgQCFabSi9Sodj4KK9KZxplFyks/Rt3AgIrhoVob1xnkmDz2CBk5tZCmvll0bCAVeJx7elJz1l2usLp13yjW+mo8jdVNU0uJUuZi1XOtVuQg0QJMwE8TGXwQzJr43Q0vHSr3xIWOS3s/Aw+1eUGnNVXzU9MM4zOYHY+Ee9TvMKtsD+i1egBFQCqGmwMaKwASO0n8FuHVH2iLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mYgb/if+q1WNMsyNHYCTxgwAwKKMnERLmwASf29N6g=;
 b=pZDmuFiVFruWbQ1y/eDEfDAjDiQCNG32SYe48wTR+iWx38Kvy7g2alACD0XYJeb2qWvkkfm02HLapWT42N0ZPVrdcuyvSVUmfW8jEbJ+AnHvPSV9and3hCkzrchGIUkPqLgXlJIJHiO4oW+Lh5iEAaf7fxI+XABVhKhtP4jTtsyGvv7lWUWkaekr/0pcsyEjK4VlkZvagIHVpKEuFAtE8gCfqbnj2fNldpg1wji770jlHprC2AeVAfxrKWYNPaQtl2WinnWCoD8a/3JejacgOnq7jeBkLkXBCQfvqneipxRqa55l1TOLWacipDQhektiK8zi12jieK0co5BYSAs1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mYgb/if+q1WNMsyNHYCTxgwAwKKMnERLmwASf29N6g=;
 b=panJrH3iAn38zf8+wfqGPKN5FBZlwfT+n3uNg6H7tf/1s6jq00Lu9Pd9810fD9EecapUZ1LpldZREcJPYTHB6+Bw4RgBYru+3EYqoiveTlvh3IHQF1CeLIM3lIJvE4wyHIKGusCUejjKRZh5PccvbAeSC4BOXvKfC1bdj3b9AcDjzYOkY+qrDpS2iLIUDxXZHrVSVmT8BqtpoRNpOqHbMy41/raN0LAllE4UO3nF/YN35swv9OAKGvAgTklodSYqyihKyGW5ya4FQlP9003lBgO1OUTy/Sc9cvq4MXNXZ0qhQ+ZrL/9SWTB3xB8ZcP2qgvqp5az0akr2XgYT7+fXdw==
Received: from AM0P309CA0022.EURP309.PROD.OUTLOOK.COM (2603:10a6:20b:28f::9)
 by VI1PR07MB6399.eurprd07.prod.outlook.com (2603:10a6:800:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.9; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:28f:cafe::25) by AM0P309CA0022.outlook.office365.com
 (2603:10a6:20b:28f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Fri, 10
 Jul 2026 04:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:43 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A0C8723C9B;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 10 Jul 2026 07:51:21 +0300
Subject: [PATCH 5/6] watchdog: sandbox_wdt: add get_timeout operation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-rinta-watchdog-gettime-v1-5-9a982fb93f49@nokia.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=1004;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=ZzpQIU5phrzhN4cQZzG0d0xx9ZPmhC5YIL1p4FkIwaI=;
 b=G77RI8xXSUhfXpsIEbNnPE9wuJp5BqMFl113okOEkQ443FbQvIryFq8mJhJrRGgPZtXE7R+jv
 yZixCMooxZIAYECzZ8LRIqjSVOaPOyy2nZHdkm3Fp8PvNrTer0gLjQt
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AB:EE_|VI1PR07MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: ff363053-ecf9-4ecc-0ba2-08dede3ef076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: m2jXuKR3slEogPUuud633JaT6zGzPavM5Er+7eCJ08NQAd+qqXu/nnTGbIP7mBKrPKdkCIKS8m7ywFXDQo/CFPnW4kp8NGk8DXcpjEjc5h2T4dcyoz+eRaN3Nw7Wem/E4Mpuqv5HpilQiY08ehyDbO69L/5H6TXCzWXo39j9rYIqnBT0EZ+EHzUgqxKwSUZ7FXjEAXsM5YC/pWwDtxggWCCMhXzWztuw/+2y4l9zIBDXLN1C7pX5o2kToiRz0qaADowZ7kmR4HmpTNIqTyXt5e9ZIOyUVJinwwdKO0PfWlzhhaoOOXU5MHMRcMR13CRUO6/kRNrpyS477EighoU4ap1SG7a1q5nwNLoBDmxx3QDow4SdMrgW+cs/TOIgyhEyARa1TG/+YjN/6Mklj0EiaGL3qXGN146gMb+Ck79GyTEzav2j57ejDiPoC5wrM3YSzampuPOENe7wy1YB8ai0tkfuBeE7F5V49+OqM0WQELanWDNnfobb7AGQPH3E6PxAVQU5J6BKcFkqViiahe6UZHEFqmIWgtIxxT6Xz4PRtCBc+TMlfcmCgyuPQBs/5+nmX1gJrMuLAVxuNwcELMBhTNb1CyjzSHlWr7Euox+NYnDaLhcPDWiDc9FeCtBZfyxpUERTjKutK8FxNTX7DwwAfqidAgrKNQy1sg47OOjiZ4GuKc/yb5eFG4NpnC1vkgwy
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cz7PZvDkBQVqvSgb1pI0e8cpkHB8n9xMMgWK3/bcZGwqHgtD4jZYxRcHjDgocJASdp4ZyoRZuJBRm0quf/RyRC3pvNTDtGL3jxBNdHIwmlvlX7n5dgkM+1qG7nUIivbk2X9Uxj9g/9mb0n4fm5W8yfN1w3rVKjkYoT1rMQrgDNUe9Y+pEuEPLA9fSdfhPBnpeilkFPELinqHZPG/l0fA/mTSSODZUs6pdrL6hH+IY4iBCXBeW+3IoIqPk4nEubZcy/KVPYmit5xISJyE6pqeXaT1Idvxg+LQn9J6lr+sJk1lAwq5m0M4DKyXZYjwIn7D0l9XwF1fQNf6xfwvuIVBu0ejveCrODe4A2qsmYEGCLn31jLpU/f0qaNmYN3plkarjN3pNs4vi3uwMBQzUHoe+VLtaNHYSlfb/9YMcC0UKvEICOXrzMCyDwpCZNLk2a/O
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:43.5848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff363053-ecf9-4ecc-0ba2-08dede3ef076
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6399
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

Implement the get_timeout operation for the sandbox watchdog driver.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 drivers/watchdog/sandbox_wdt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
index cd5eadbfd21..d6e8d71843a 100644
--- a/drivers/watchdog/sandbox_wdt.c
+++ b/drivers/watchdog/sandbox_wdt.c
@@ -43,11 +43,20 @@ static int sandbox_wdt_expire_now(struct udevice *dev, ulong flags)
 	return 0;
 }
 
+static int sandbox_wdt_get_timeout(struct udevice *dev, u64 *timeout)
+{
+	struct sandbox_state *state = state_get_current();
+
+	*timeout = state->wdt.counter;
+	return 0;
+}
+
 static const struct wdt_ops sandbox_wdt_ops = {
 	.start = sandbox_wdt_start,
 	.reset = sandbox_wdt_reset,
 	.stop = sandbox_wdt_stop,
 	.expire_now = sandbox_wdt_expire_now,
+	.get_timeout = sandbox_wdt_get_timeout,
 };
 
 static const struct udevice_id sandbox_wdt_ids[] = {

-- 
2.39.2

