Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39CFC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 04:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC5E984A0A;
	Fri, 10 Jul 2026 06:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="i/8z4uJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5318A84994; Fri, 10 Jul 2026 06:51:50 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6848B8497A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFZjw/iFkKnxakpdbt3U/xK3rQLzdge5yKBrSJ3fVB0ZtPJlnKnEIqiA7af/8kKx66NDwpMcq3G/GbhwI70J6O8ez3ceVtAuDK/3XVZBq0lNIdYvz778PBZGbNWxc6vewanmz7WI/LiclJEk6yXcvIe7TXG+GpmHbCfvR7eQT13UWpIEmDCGm3x16dJaDKkMViTZgEozrAsiUDqG0mfI9kHP+yc/1He2m5+QYPUqZyYo/IzjQXeMSWRiphrNwEGUjpUAGmr/ATG6c9LILZOFChIngdZm04+a6U6BspnKc2Z8AJ+Rp/Hvmqhn0Mq4wgbTbcKpF8r62wHZ1dRIETyN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSga3MY+cad7TmLnqu/K/8cCe8H0x1ecPbYfPPCj8QM=;
 b=BJrX91tLEWN2X7KrKRAQO2nO+bPgXEi9ZW4DjlNDjvG4v5XyZP2koCOiICRm+6RbUq1RqcfeVZ1dQcde/kECYrg1JsJrxEzsbsR0qgXesMhFwtv6A7BBIXyBeaZH4ilKBaIjH7O+y3vtsjsZ7r6NaNgOuCIJnLSELoAgIFoLxHb8P1zeOSx+K9XEQVoiCVjbO3WELb7t4re9q5D4Eo39wlY2CFM6VCmaAUwetsNPygw39C7gpv8DaJH2Qh3fjKlo9mmI8dYIwhYGxAa80jAryksYE6J0/9JcLfmO2aUtGgjavnTlogcRwkDyoCJoSf7EoBDvdwVDRQr4I+z46gwEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=chromium.org smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSga3MY+cad7TmLnqu/K/8cCe8H0x1ecPbYfPPCj8QM=;
 b=i/8z4uJOt/UvE0wum3YIVbHh806v+sUJqEVPl377lb/LgOdicVGIpsUmx3gmqbq4ck1v6kg+78SbmMLUTQB9HwvBzEIVXja5wG0yx3NV+i+ZZE+UlzgX5w8ebc4XNKwqOpGzs5WV3NZYFC/Soi2EFRZcbjIqxC5yIME8gPcqUe7bmObVYRpjE0BO19giS9kPkPptFjEjsSo70o7XtP/AHxHp/dvfDrzzeCnDUBTgcjJ5xtBRTAuKRT903Pindqb+4eMR7T0YVwHgehGsVlKzrD9PhY0Z7kAXdXJDwCy68RFexz1AFsdNy3QM3KdQZm+P7N4gff7gJNHWLgy9AHOUbQ==
Received: from AS4P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::17)
 by AM4PR07MB10853.eurprd07.prod.outlook.com (2603:10a6:20b:6ce::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 10 Jul
 2026 04:51:43 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:5db:cafe::3a) by AS4P189CA0030.outlook.office365.com
 (2603:10a6:20b:5db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 04:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Fri, 10 Jul 2026 04:51:42 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 7B9E723ACA;
 Fri, 10 Jul 2026 07:51:42 +0300 (EEST)
From: Juuso Rinta <juuso.rinta@nokia.com>
Date: Fri, 10 Jul 2026 07:51:18 +0300
Subject: [PATCH 2/6] cmd: wdt: add gettimeout command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-rinta-watchdog-gettime-v1-2-9a982fb93f49@nokia.com>
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>, 
 Juuso Rinta <juuso.rinta@nokia.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783659102; l=2049;
 i=juuso.rinta@nokia.com; s=20260428; h=from:subject:message-id;
 bh=Q2K8tZJFP4+flOU4yzoC13+keIvNKj+suxBLXZTPvC0=;
 b=PnJ3m3j/WOyiIrXgFmn48USIO658Qt/lVAheQ8rqpFZsHp98TAws8EYuZ5SisYh+2W48vMauI
 iEwV9IZxQ5bB8dBXGymiBV01Is4vchx629O6gTnkv1NAhbRLerRW4Dk
X-Developer-Key: i=juuso.rinta@nokia.com; a=ed25519;
 pk=CnH7U1WPlQ4t8gHpzhFvPnTjoealqDnbmbLMYEd5GDQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|AM4PR07MB10853:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d9b6b1-315f-47b7-f8dc-08dede3ef011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j+Jv9KTN59PgJ+uRNSSJ3HesTywGDTkEMS42lNV8pVpx6xXKtC6HeZN5gEEu2cg2F9B5ZJ+itlNBQXIl70DIhKRxmgfJ58ggmpbdPZiDS4PQ10AUbx0WgFkcRz2DnGZsV+9Ajp4nmdh0xm0ukZDjbrGFZsV6ZD/qIo1dDSyfV3cC1C/vLZIP4qg1dSPdNHgZi3HIq8kq88fwWrN+bR+kMTgy8yRe7Ev/mGgwx+6rOQOc3+lfcaJNtoPBgZ+bzQFimVLOfCrBNcqYjZ5VWm5YRmb79F0mEnayFXPD4epR92s0/AmfVP81uKMHiU4m587kbra2FhY57ySoeU3iceZIhpbxdm8jJTRGonkgwSwBFUpsA8qPVEnIZmaJ5riyxeySONJij0292PLRiexaGv8Srnw4fXsWtEapC+1wfVDGOsRmaV0tYDgvuVaz1thNdVktFprp8Cvb3Yssi0uB3rL+LdnrNWbw1xTbKPgZ65sTXKZHHg4PwWvOmmBWSQAsKq0adhVsz5Pc6y5DhD8TZSN9MDntWYbhjS13NADpLGcYS3wMVCj/qivx5TblwOkTYV1ndrQydxODqeg2ZxWmzwmWyKL1dPGfaUTEqMKjgIZlAWrsxXSUtm1DrZF6L31BMyacFY9WpT7YNRdi2ylhKhCYKteB7/DkOJebln+prNJT17VqJku7MfyUrUNSj4KVM1rjvMnW21wBzQ3rQZ3wE7EXxw==
X-Forefront-Antispam-Report: CIP:131.228.2.240; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0735.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PQgrgRQSKwiDJxiqZj9pMGZdhLX0nXCuRcYUu9hPGRhGaPFI2dzdeyidniAL5edQzjsLfBtQF1eGIsKFIVSQTt94huNT1YEW5BOW4a7wftFdAY7gWkG63CY6SBW0Q5FNXdClM4m8+p96bt9C5WECyEmKlc22t9V0i2Vw8hqYFOEgtxHeG+jVHSMiFM1PskXur0taQVkrLjqCIvSSQ1Y7qZlNHvuZBmvpcHKRVM2TyDbL+Pgj6pTGhLPAymZ6i16hJnrxkypZ8HL+QLtXjfCWtIpSjla/Xm8ihNPhqg2XZr/ZV7Ub41VJyRw4SNLYUcvByQ0l+kYP/cm3xjlfig8vYiUoscTfarUobwLq4mOBf9WbIJ8M5hllkcNWYSw6tILu4BnMzTuZybv5o2p9gBMoaCTwkUJvdfARJ5G2I6fx+twGm6IZpqDzWDW1vAdxFbj8
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:51:42.9282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d9b6b1-315f-47b7-f8dc-08dede3ef011
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.240];
 Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB10853
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

Add support for the subcommand wdt gettimeout in the U-Boot shell.

The command queries the selected watchdog device and reports its
timeout when the driver implements get_timeout operation. This
exposes the timeout printing added to the watchdog uclass to
the shell interface.

Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
---
 cmd/wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/cmd/wdt.c b/cmd/wdt.c
index c7a06cca181..3e2ca069fe9 100644
--- a/cmd/wdt.c
+++ b/cmd/wdt.c
@@ -131,6 +131,30 @@ static int do_wdt_reset(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
+static int do_wdt_gettimeout(struct cmd_tbl *cmdtp, int flag, int argc,
+			     char *const argv[])
+{
+	int ret;
+	u64 timeout_ms = 0;
+
+	ret = check_currdev();
+	if (ret)
+		return ret;
+
+	ret = wdt_get_timeout(currdev, &timeout_ms);
+	if (ret == -ENOSYS) {
+		printf("Getting watchdog timeout not supported.\n");
+		return CMD_RET_FAILURE;
+	} else if (ret) {
+		printf("Getting watchdog timeout failed (%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("Timeout: %llums\n", timeout_ms);
+
+	return CMD_RET_SUCCESS;
+}
+
 static int do_wdt_expire(struct cmd_tbl *cmdtp, int flag, int argc,
 			 char *const argv[])
 {
@@ -162,6 +186,7 @@ U_BOOT_LONGHELP(wdt,
 	"wdt start <timeout ms> [flags] - start watchdog timer\n"
 	"wdt stop - stop watchdog timer\n"
 	"wdt reset - reset watchdog timer\n"
+	"wdt gettimeout - get device timeout in ms\n"
 	"wdt expire [flags] - expire watchdog timer immediately\n");
 
 U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
@@ -170,4 +195,5 @@ U_BOOT_CMD_WITH_SUBCMDS(wdt, "Watchdog sub-system", wdt_help_text,
 	U_BOOT_SUBCMD_MKENT(start, 3, 1, do_wdt_start),
 	U_BOOT_SUBCMD_MKENT(stop, 1, 1, do_wdt_stop),
 	U_BOOT_SUBCMD_MKENT(reset, 1, 1, do_wdt_reset),
+	U_BOOT_SUBCMD_MKENT(gettimeout, 1, 1, do_wdt_gettimeout),
 	U_BOOT_SUBCMD_MKENT(expire, 2, 1, do_wdt_expire));

-- 
2.39.2

