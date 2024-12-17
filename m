Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301D2E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 341AD8022F;
	Tue, 17 Dec 2024 09:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="VZi3+sum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2DB8027E; Tue, 17 Dec 2024 09:32:23 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB6F8021A
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRQOyZeJFsHU/388BCfUhmCoHhpD6H7PV5ex/Dn0YzDNzcAH1MYPotVu3bR5t5CXGSQjegLp9CsnsijezdE3arHulCyaXbPUN5RPESr2tYZripiDZELttXlmDfZnleYAYKz3jIBzYu/XTYFsxSCbPLQgzgj3nLZtGMqX8J0XpPyb1Aa+BtIylFln6nkKEWAnf0Mq8hgJM3SpPqN8Tr1GzRrDoGQ1uUTRRAlZNg8ntc+FFRpV5ffwKiVAWZGDW6RerKfwvunf1p4mcchUJX5lu8s4g0NasqxUmKfrqkARGbzCZD4r4Kg0aVSmP/cgJfbeZc4PX9XTUGCpW1oaWyKGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWMf7D1NFrLCQ6xFdysx7G4beie8S+vz5tshovka7t8=;
 b=kNSD7ukFSD6+ffX5Lj7Bt8NvirGc7orP69L03zjjffhgLWSB2D0h4XRYS9RoEofqBjV8p3OX79S/kKs7ojXn2Z38WXryQiwn3Di3LROdiv5QgSwFM4UQLl2cmzgCBBFseOgjtTJr4YOhVtkuSBYFLQWgMYsTYb2UHgiZ6QcqvW/ONLDUhaHX/nIk+2lScuolgmBbcMrHyDzm6kyaJEeDrgJWH7TTE6Uy2lthITOOQIcoF0icOsgfulkdzLLFxnmZxtPdGBHiJR89Y87f+zj50yhFQdSLyg8rHR8Tx9dayVhk6UkqUoFT/Sb3DFtuLYcJprwT31r/JeQ+9UeyuZ1IVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWMf7D1NFrLCQ6xFdysx7G4beie8S+vz5tshovka7t8=;
 b=VZi3+sumVpSwf5KzA7MliFmf/+imLaXUbIyWfKaOUTRKP21t4GQBGDjaypVJR37HG60hXxXR+B5Z2Xlf605s6MBEYoFLo8XV5M6EQCzA7vPffVMXNBauG519p/IOtBeYSEY6GEoQiEXyO8HR9CnvoCpyetMc/uEZfhCzLDCCi2h9RcOfaugCdR0YTYbfVU98DKolBdNGrHY/YjWDmTPMfRFWTMVIWQE71iJIPDpONVbsuS0vCyj0dgU4/O5hUHgngxGxoC+b9rsJ2dXD7q6T9WmH8GLJGti+2vUX//DKzq+B01U2UPJ9jyW5W1iJCpIvk3rS0ZnL8CdQz/nRV0kWTQ==
Received: from PAYP264CA0018.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::23)
 by PAZP264MB2767.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11e:cafe::a3) by PAYP264CA0018.outlook.office365.com
 (2603:10a6:102:11e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:17 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 81C0820213;
 Tue, 17 Dec 2024 09:32:17 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 9/9] configs: sandbox: enable mbedtls
Date: Tue, 17 Dec 2024 09:32:12 +0100
Message-Id: <20241217083212.70330-10-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PAZP264MB2767:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e6cbdd62-ff4f-44d7-5b86-08dd1e75511f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4NtDUW9MauLL7j6RUp//Z8V/X8zVvS7I5NAd3G6/tLvzKP/qBsi5iPJmncoO?=
 =?us-ascii?Q?ja9H5oSgQYefxZIBj3jNvLNHiz9C2lFjzg/b+tP30bz3f8Zekv67X/T/Y2cD?=
 =?us-ascii?Q?oA21LmbNCq17NK//nRzTzMMb3jel2YhAp/yxsRedXYzb3NhXKpMwelWseGbr?=
 =?us-ascii?Q?pT8hfNDqwfSX+idxYaSU5+O8J2fkDlZKbzZ4IwMsJ8qfGBegJD8C+VUzmzsc?=
 =?us-ascii?Q?qPHvlwyq9eFs5wJtL7h11dFwHn8ykq/zRhx6G+dDu/8M/lYXqnBd5kfhYlsA?=
 =?us-ascii?Q?VCPJY5lGcHRafKzAmu40lhBCGhUMxU1nkAe3gLxZk6pKMmOnPHDYC+ABgBGF?=
 =?us-ascii?Q?FHp9Z9MXiA+wGjArg8nYQh+r6gZeoYPPueygY7UUpiKphooMaz3w6YjFEpTn?=
 =?us-ascii?Q?tkydHr74bZxo97/OURi1tKIlTxQO2/LBwMFzeOUhxK/U0L8wMCrdTPTeyoSK?=
 =?us-ascii?Q?g3Lj1+u+zfXd9cYW8Owxs+VOG9hcA/oeBUoV0aKsZobPwv338pjmzXG8C049?=
 =?us-ascii?Q?s/eEMc6GHuEPtSyLDBBo5Qyx92vBx4HPxQR777JRlJAG+7vnk3v8BikUfFSJ?=
 =?us-ascii?Q?wbxR6NyMtTdHzf09ld7vlayrd0Y8Jfhc1emnPL8REvAmRS407P3tYHf8Oj2X?=
 =?us-ascii?Q?80xKq1KD2mX9ahOIj006shs/OKt9nJOHyClc36WaLMJskJzaKDtsQ1Xp8GA9?=
 =?us-ascii?Q?+qiTGq2dUwhbYc6TpZCPicqZjz0bf6RqnXHXt2908vr3h2sZBcFkTbLL0o2T?=
 =?us-ascii?Q?aKxBO/4PZ8qipKjCnp5n4z1dEKZdtuSgBshHOKMeaNS/FuZNWthsYQl+vUBs?=
 =?us-ascii?Q?tVJJf4oF81SaGRrWlDsgvrLZpHCD9FVBVtjbg4fVQ930mryJD7Y6f+SC35gF?=
 =?us-ascii?Q?tcHCXtPa5aBxuw4bbiMhjoKSQ1Fbnmf70ZFY1mIpfHhtf8x5oG3R+gZg7VnW?=
 =?us-ascii?Q?nmElXIngyyliYO1zRJw3TPfkRzbyyY38MeGPY8fULsAshR82BN1PaiAz3CMT?=
 =?us-ascii?Q?WDKcl9Bl+22cvshf2jqKArGtH2SMKOn7v6Kb6ZrYl3oxwKk43+JGwur8WsD5?=
 =?us-ascii?Q?E//47ZJJGYQ1Bk4yipBAu57sc1M9R9J6y8PCcfc2DAvlqYVQPEPu+CsyTQUC?=
 =?us-ascii?Q?TG8zXWO/dgQKG5zR/0OdlHBeuR14bLuYqEpTFAZptP6z9D6CDeLYJKcmtv7L?=
 =?us-ascii?Q?TAfgucLibjY6yRonBs9jDUQ5OH4JetnOsaekrv9TunVj8bxn9SUU21eLnO3A?=
 =?us-ascii?Q?ACUywTbtpy6VxvuWG0hZtmZkG+WXmLknfQUfYVk/fu7EYY8dvuFFxBnDjIfW?=
 =?us-ascii?Q?vdvA8Feq9JSJHbxyKhJWNIq5PuYhAKOQ72wjLCGuvJVTNiUsBL3VsKCUSAyr?=
 =?us-ascii?Q?YZx8W8ke88CmELXgr8Eoi1seRK9/dkpPdMNgDOJbNVgshrMNaVwTtT9JP1tJ?=
 =?us-ascii?Q?OV0csiDCBLCc6TSn6xDSLjpvs76eWC90ZHGOqPowhdWz2dNLVcq6c6wiWKR3?=
 =?us-ascii?Q?yNjGGeJuRnv+9f0=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:17.7026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cbdd62-ff4f-44d7-5b86-08dd1e75511f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2767
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

Enable mbedtls to have at least one config with
mbedtls enabled.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 configs/sandbox_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 718e4a8283c..1258044241a 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -352,6 +352,8 @@ CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
+CONFIG_MBEDTLS_LIB_CRYPTO=y
+CONFIG_HKDF_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_TPM=y
-- 
2.25.1

