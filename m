Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD00C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1723829C7;
	Thu,  8 May 2025 15:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JxwjWBfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9847828BC; Thu,  8 May 2025 15:15:00 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20721.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::721])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80AB828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r3Ad2lNTHXYpKaxt1JFuF0BAnM6kHukBPoH7vxT92LEKcoH9tGGdGR4K6nSJQAznyx9VF70HVhLXM6JTIqEyFWvfETVGoF2pn2SVtjR00VVN6aumfZ1PgNIqWpMH7WOsa+BbMRChgmpFmRJeMRv1jSqoPSdGxg1NGHpFIDSkriAOPrICQYn3MXhFi+UeJx7rU49+n6TgSEtyHQHS40bclUF68AbC8Zg3hUNEB0gRXeo0/EcLP3pmbCHrjhKt3yD+Q50LhbYvK5FeUBAILpps7QJlKGayFojo3E2j3jDIcS7JqRzq/JYECd0YCAVFrN8wHDxUq3DYTUReOQGIHk/pNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VStsGm2lenO4cboXfL0d+PGDrD/jUi3BsXFeb1bKQfA=;
 b=O7eRa3JtyD8ZYGZJWUjtd3aMa/+x/e6VSP5/RH59lUvnCl9hlJ85pVHfZ5b0fC72p5TS3sMKAXE8Fzd6DM099Q238bKbfCp14xDh8peEMpcru2jRFFvhXGl4ZSbMc0PvGFUokFxxXFbg63qyuphtFHc0mmgvfZHbQ810RxQRX8rdlGE5I9ueUUaxN01YyJUiRkKPIrliLm+0YckYoUWVbKmHyM0sUrCiKSc/hX9NsaejAPopiHYBbF09CKEukZrD2M3plD61szAn6w3DOZt416xtlaaYomroG0h24SgYD9c8JR10U/8p8nuoS6vJ7DvIPXj9I4GSA5QlbwEbSvp4Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VStsGm2lenO4cboXfL0d+PGDrD/jUi3BsXFeb1bKQfA=;
 b=JxwjWBfZus8yXTyAyIJcHZbzL2IItFLk21SyOIIok15+Fxvu3H1hKXOPvqSAL+iaGEW3NZDAB+n8jEePJZ455Jdhf5VfyEfeXm+Eub8e1UUxTusJnTAEHHuethnhxjNaTXVp/B9uDSkBT6AUt7Zp4Tuk36WM0QVgx4tTQC7Yu1MpyEMN+PjbJCFPo6gMRX+B2v1KhTzm/jH90QtZH8B2gy/ty96Zk7GxE19piyF0ObUzfm3zlutD7c5CIxSSAGtE2ODRO5OBL+oBYU6PrkCB/SIDD/VYC5pLNp/dhw9v0rNIMOHdH88kKaUlkaEZ1fV9iFlMSUl5SXhui6YAGAgIdw==
Received: from AS4P189CA0012.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::15)
 by DBAP195MB1052.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 13:14:54 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::c9) by AS4P189CA0012.outlook.office365.com
 (2603:10a6:20b:5d7::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 13:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:14:54 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:14:53 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:14:53 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <joe.hershberger@ni.com>, <sjg@chromium.org>,
 <d.schultz@phytec.de>
Subject: [PATCH 1/2] boot: Add BOOTSCRIPT_DHCP Kconfig option for
 boot_script_dhcp env
Date: Thu, 8 May 2025 15:14:44 +0200
Message-ID: <20250508131445.2557222-2-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508131445.2557222-1-w.egorov@phytec.de>
References: <20250508131445.2557222-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|DBAP195MB1052:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7d08c6-d82e-45f1-7b20-08dd8e3252f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kg8s+M2UwATPAlG0t4tw9gelQWkLqx0MaifTx/nOMXlWNP3WmAbgzXGBcyes?=
 =?us-ascii?Q?PcNnKOKq46DaHXJxCw6Bu8h/jecl7UWNfF6Yq67177V0eJceZpr5DIAeoO1C?=
 =?us-ascii?Q?MFbTIYpGqn3M2f/o2vc0isLQ4uz455CWDJpvktUUmzPF0zUceufZBsupZZ+D?=
 =?us-ascii?Q?oNQw8/ZEbuPMK9qTodb24H0SGZ7t64KeCuL3MoIljtsiaJCWwpLuVrmJETXz?=
 =?us-ascii?Q?yJWW4JhIHKcW3VBbqx6DfGYN5D/n7QFGVQbUtVrnZw0ZLpHZoYXFEIyhKTP1?=
 =?us-ascii?Q?oPzydWEH5UeGpzFXn31LcWpd+ugvcXvEYzw0oBOm9jGMd6wHq5dY0tRdTUMH?=
 =?us-ascii?Q?nRPFd/xZr+ysuIqTXzzmZY5CzYP6emGMnAxm1jxI/k0Ia4WUkxr94/0tdTKz?=
 =?us-ascii?Q?AuyoS4W6/qvH4WKVuVEwdPeGRjpk2EfVSIcYRXbtFFkmJc124ZMAyU5nNRn5?=
 =?us-ascii?Q?H0L8ufAvej9FP1y3GeRISkNe6egYpFpZH9oyGIEHg/Vap/4AGsldxg3iEUls?=
 =?us-ascii?Q?zvHpsC6gcKveZ2Ds17/Bwuz8gL5mXm8AG8sK3Zc3MTI1p2s0LzLV4jMJfEw0?=
 =?us-ascii?Q?qq6XgURf/xcw11mn9lrnDLzk9PZYbykha2stBgT/6ncI15NNCLlPZgSyMAE5?=
 =?us-ascii?Q?axoV0SPgODhXZWKbpoDrIsiA1H2euwBkopITZHINLtZQXhUJpo9hqkqEejjx?=
 =?us-ascii?Q?IDcsPYTNJmdJocissH/xsh/GEBqmZo1aj2KvrK+MOlh+97DR9X50B3fhBy/I?=
 =?us-ascii?Q?xNLN0Nb1r2lNRy+jH2+R4PuzvJJG00hP7jJhDLO/oloMwHGQgLRWmFuRNEH8?=
 =?us-ascii?Q?VtVlJPU0NRPQmJirnveOZIIy1QhdFPy1JfojBL+g8dnDO20WzcZYYtfU6A97?=
 =?us-ascii?Q?4qui2hxqdXAUfKktp5zUcAIy5x5DM4Jjaq0RE7UJ9YF4smbt2qBfCFA61yxx?=
 =?us-ascii?Q?UV9Rb/wLznDV0SVZRlEqAnn4D74f+ftrKlJEUYtT1UnNfUHrQw8P0ssUsAcb?=
 =?us-ascii?Q?fr/SE5PlbaS1XC+IgLk+WVkunrSPxWKsAoih9lkfp+6S92vAJs5HccAjOeaY?=
 =?us-ascii?Q?oeEHSsOC+xfK/9izXYIahHcywPYMmfMTcIjmRKRR1SR4HF21+L6oG3eMzs8R?=
 =?us-ascii?Q?74X+bXTxfE3gaYCmvderhwrKVM5ONBZsf/JuVLEOiZwchpc81Z4vCK0megjX?=
 =?us-ascii?Q?p3uVQKbCBGK1VCAPAlWZPp6khc1W93j35wmF3/NAZJCWcK3zIISoszRRJXrw?=
 =?us-ascii?Q?bYis9zX9yZc2Iw0IqyTOefn7exN1EjhqXVw++lxWQKh14CI9PjHhmfWJ6vxq?=
 =?us-ascii?Q?r9ZpQZIWnHFcu0QLPKw++z/Pi30BuyhdyIKwUSECIVoO5zuA+SjXzlVopK3x?=
 =?us-ascii?Q?OBiKDE1NSyNSaQZxXVlvxYoifbbbd22UwiyygZUKRnCw4qno5WCQ/aA+f9ga?=
 =?us-ascii?Q?HM87Fay5FnJgTiPJecPKdOcZ0UPRVmZfMLA4Mo/c83HGrsYJqTZ3I712KBos?=
 =?us-ascii?Q?uhdS50X/ZP7ZHF0v+9ExNHbhg813zcdbtdPS?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:14:54.7008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d08c6-d82e-45f1-7b20-08dd8e3252f0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1052
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

Introduce a new Kconfig option BOOTSCRIPT_DHCP to allow setting a value
for boot_script_dhcp in the default environment.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 boot/Kconfig          | 18 ++++++++++++++++++
 include/env_default.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc9..ed34eff5b7a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -875,6 +875,24 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
+config USE_BOOTSCRIPT_DHCP
+	bool "Enable default DHCP boot script filename"
+	depends on BOOTMETH_SCRIPT
+	help
+	  Enable this option if you want to set a default value for the
+	  'boot_script_dhcp' environment variable, which is used to fetch a
+	  boot script via TFTP over the network.
+
+	  If unsure, say N.
+
+config BOOTSCRIPT_DHCP
+	string "Default boot script filename (boot_script_dhcp)"
+	depends on USE_BOOTSCRIPT_DHCP
+	help
+	  This option sets the default value for the 'boot_script_dhcp' environment
+	  variable, which is used to fetch a boot script over the network via TFTP.
+	  The script must reside in the top-level directory of the TFTP server.
+
 config UPL
 	bool "upl - Universal Payload Specification"
 	imply CMD_UPL
diff --git a/include/env_default.h b/include/env_default.h
index 60c39f9853f..c72cf123004 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -124,6 +124,9 @@ const char default_environment[] = {
 #ifdef CONFIG_MTDPARTS_DEFAULT
 	"mtdparts="	CONFIG_MTDPARTS_DEFAULT		"\0"
 #endif
+#ifdef CONFIG_BOOTSCRIPT_DHCP
+	"boot_script_dhcp="	CONFIG_BOOTSCRIPT_DHCP	"\0"
+#endif
 #ifdef CONFIG_EXTRA_ENV_TEXT
 	/* This is created in the Makefile */
 	CONFIG_EXTRA_ENV_TEXT
-- 
2.34.1

