Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CDFC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F34D84942;
	Mon, 29 Jun 2026 17:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zbhrBklU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8EC8849A3; Mon, 29 Jun 2026 17:44:29 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54E1984A36
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7x5IK4Gptir+WvA8ZRtAuIE0+SjIvvdXQ7o5G6JQ7sN/hTbZp58cGzGUiXzeAFrVqm1C54uPQcRKX3rWZF1XYHyKgXVynbT3l3mKjtTpyZzoJWKqGvDRSTwyrH9e3cQwQcU/hCvA/BaxcTKSVuuqQHOENnV/lab71hkxQvah+oPOotWbUvXoRmQL6GEwhqKetfO6t0OrWIu126XxrrNsU0igGYSCdsUXvN0p/2HuLtSAQeQHrBl7hSkgCUZVi55z/C6/5wj9wCfMYAX3aX9E7HOoxP28ZUDKX9FxuHrI5epQoVXpgF4Ej+r+6OSTMkxtptjb0CmhKeb/y9AOCQhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82T+pFP1hpt7eDYUDBkuediLzDtdz6lWz7PRBrd3Lk8=;
 b=JzwQbzCmnJgaSsNkrSCq0xRXbHdyUZkB6INTmma+ZIqj1maqU2GzWKunokwMYuLpGZnAyUTgRQNiiykYhfAxklMFIgQbeV3J0ZoDlxD62B+NSr+HNLv6m/ZKA+XhMtv7pZCeTnQB4grDkUOZdoqvV1lYH4nwGmCuDJfcPQIbBJsBE1ktbMiLMQ2qdkNnNOaB6Yq0T9Rcp83KYUJC/0rYzKveWWptdyH8GrSzcOgqwO6cxl5rT3WvtBj0raN1vT1fISLV08okg7UDKMrTj2qudT/pwUNRu+MrzCTP8jI/UsZIx5ZV5ZDS95gHYTIDbgsBH6ZXE9MrHlyGy6GdzDKZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82T+pFP1hpt7eDYUDBkuediLzDtdz6lWz7PRBrd3Lk8=;
 b=zbhrBklU2mSyqmagAYumY//KCEUHFL9g0yT6bE3hwsmRpLap34T7etyluyfnk4Y1Y0vL9o2meWmAkBYHfVzFcjdVK6bRaknZ+Fs6j19ICv8EmKsB9ABqkwkZTzjP0EyCM4k/Wa4GPS9KXmqnsWgDs4MuRMtgIVAx5wd85tGtPHk=
Received: from SA0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:130::23)
 by CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:44:21 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::a4) by SA0PR13CA0018.outlook.office365.com
 (2603:10b6:806:130::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 29
 Jun 2026 15:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:44:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:44:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:44:17 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 10:44:17 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Eugen Hristev <ehristev@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerome Forissier
 <jerome.forissier@arm.com>, Linus Walleij <linusw@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 2/2] .mailmap: Run mailmapper and sync name locations
Date: Mon, 29 Jun 2026 17:44:01 +0200
Message-ID: <ca236aec5f56408fe30ceef1b56bea1be086fb91.1782747838.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dc57b5048b5c64693b5347b811ffb8cd5107770a.1782747838.git.michal.simek@amd.com>
References: <dc57b5048b5c64693b5347b811ffb8cd5107770a.1782747838.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6372; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=3RgY0UzSeJSoWxqmzG82yVzf5ZkDeYHmJiRc5PHWYD4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ5TTpWdOGteE6rgPEfHY33c1OLV99fGKb79PZvVgXvr
 YIPJdlXdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEyrgYGS5xnAgwfBctyfzu
 luVS896jOxNXf5hzZ+k15swUe+cJGcsZ/tko5r5Vv3iX31jx5d44d4EJkuwbeCea13ocl1644F/
 vCxYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: b30d8c3f-bf90-4686-20ba-08ded5f548a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: cYjObxfU0oWp/ccf6eUD2eobFJc8hcLaiEuat/f6o4Th0HyiEgdAB5m8TPoQEcnWbUD6+GW+C/ZYmEY6pQbUP7OttGfm4YKL+9N2ipg8VIy3Rc94kb4QYnylfmp7jkizq01zo654GrOHl5qijMxPfhZyocIjV+rTvVhqMHyJa2M17WDkMBdfV4VJye1/8mClz3RRUA4XWwF5AuZCHXouAIMOfhA17sm3cFDmMtf0HedhsMHuLZwff4DpasVIjjKqQ5ecSPr8j5aYCghefpnlWuWuDxjCRKeXQiOGJ2sn2TxrFSgoCscAzh2ur52o8z23po0ORXAZMtZclfZ7/7ZcNIA+1XnQTKoIhCwZUbSxhZqTggkyRJfSJ5uqIQ5SdXnSWOMIi7jareQnpeZ7DUUz7aLrjygdb4aZhaED4li80xIrPEf3yCI1T2WZaJ4YrsmQVamBDBOWyZf8h/AGcFWLnO0azk8it/di6sHdY35dVl8Lot1nt1xuieDZoFlUqci43g1iC24XHnRuWiVC+doVrLhbZoaxv3eA4Vdv8CP1JYLrCbT/XNS0MJgE7ZXAclReWXqUvHp3UkWWIFviatZ9QEt7GdAhYiSqQTDk1/Oh8HSkgSw9L9US5FGocowsVjrhXG7cFeV48R/cWXX4faHUnlMdwzdZUpHJt6VS5IVve7WCvDYnYCvFCEBJfxGk5oFFcehi0Mh6kTu7IeEIKLqB5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DgU2zKAPxi5aF1tXlR+sQA+kU9OlUtLDA1vlktpwG0iiZ/9c7yb5tFXJIQB2rkjNrDvuLjAIB7RX1TKvu0q4GJUS/7OiRUTEDiTBKMO9NZ5LV97s+j7K0OrQhnEiXnMxIRdJx7YwThzAY8Ygg7ayng5EPQj9WAP7MWMCCrzFcHVBUjNqLLZNfIlAMHSuQOJvu+eyxg+VlxMKDd87kBHAhFSoo1jPdBMcVvVmyLxVO1cvMrFV2SFK7yHG7n/iJtnjBWLfQnED0Z++Tl/KezVMa+1HdAFPITv7gtjyb3RZb+jbEDKsalN5L6NVK6bEVy91ysZKAFI+Fn/1ZYKW9ueqOyYcqwsebapj9TVRMgDpbkiiE+tFW5fOhhoDXZVg411W5RkF49vEbIfyF0WMg0XjovTsdwxoVROkwOHdAttNz5M6loV8PldVFRNqoulZoigW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:44:19.5074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b30d8c3f-bf90-4686-20ba-08ded5f548a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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

The patch is output from
scripts/mailmapper > tmp; mv tmp .mailmap
with moving <swarren@wwwdotorg.org> and <swarren@wwwdotorg.org> to the same
block with "This contributor prefers not to receive mails" description.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .mailmap | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/.mailmap b/.mailmap
index d9ba6638728b..81883490934b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -15,6 +15,7 @@
 # Proper Name <proper@email.xx> <commit@email.xx>
 # Proper Name <proper@email.xx> Commit Name <commit@email.xx>
 
+<duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
 AKASHI Takahiro <akashi.tkhro@gmail.com> <takahiro.akashi@linaro.org>
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com> Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
 Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
@@ -42,21 +43,20 @@ Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
 Christopher Obbard <christopher.obbard@linaro.org> <chris.obbard@collabora.com>
 Dirk Behme <dirk.behme@googlemail.com>
-<duje@dujemihanovic.xyz> <duje.mihanovic@skole.hr>
 Durga Challa <durga.challa@amd.com> <vnsl.durga.challa@xilinx.com>
-Eugen Hristev <ehristev@kernel.org> <eugen.hristev@microchip.com>
-Eugen Hristev <ehristev@kernel.org> <eugen.hristev@linaro.org>
 Eugen Hristev <ehristev@kernel.org> <eugen.hristev@collabora.com>
+Eugen Hristev <ehristev@kernel.org> <eugen.hristev@linaro.org>
+Eugen Hristev <ehristev@kernel.org> <eugen.hristev@microchip.com>
 Fabio Estevam <fabio.estevam@nxp.com>
 Greg Malysa <malysagreg@gmail.com> <greg.malysa@timesys.com>
 Harini Katakam <harini.katakam@amd.com> <harini.katakam@xilinx.com>
 Harsha <harsha.harsha@amd.com> <harsha.harsha@xilinx.com>
-Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
-Heiko Schocher <hs@nabladev.com> <hs@denx.de>
-Heiko Schocher <hs@nabladev.com> <hs@pollux.denx.de>
-Heiko Schocher <hs@nabladev.com> <heiko.schocher@invitel.hu>
 Heiko Schocher <hs@nabladev.com> <[hs@denx.de]>
+Heiko Schocher <hs@nabladev.com> <heiko.schocher@invitel.hu>
+Heiko Schocher <hs@nabladev.com> <hs@denx.de>
 Heiko Schocher <hs@nabladev.com> <hs@pollux.(none)>
+Heiko Schocher <hs@nabladev.com> <hs@pollux.denx.de>
+Heiko Stuebner <heiko.stuebner@cherry.de> <heiko.stuebner@theobroma-systems.com>
 Heinrich Schuchardt <xypron.glpk@gmx.de> <heinrich.schuchardt@canonical.com>
 Heinrich Schuchardt <xypron.glpk@gmx.de> xypron.glpk@gmx.de <xypron.glpk@gmx.de>
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com> <ibai.erkiaga-elorza@xilinx.com>
@@ -72,14 +72,13 @@ Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de> <jakob.unterwurzacher@theo
 Javier Tia <floss@jetm.me> <javier.tia@linaro.org>
 Jay Buddhabhatti <jay.buddhabhatti@amd.com> <jay.buddhabhatti@xilinx.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
-Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
 Jerome Forissier <jerome.forissier@arm.com> <jerome.forissier@linaro.org>
+Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
 John Linn <john.linn@amd.com> <john.linn@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyothee@xilinx.com>
 Jyotheeswar Reddy Mutthareddyvari <jyotheeswar.reddy.mutthareddyvari@amd.com> <jyotheeswar.reddy.mutthareddyvari@xilinx.com>
 Kalyani Akula <kalyani.akula@amd.com> <kalyani.akula@xilinx.com>
 Klaus Goger <klaus.goger@cherry.de> <klaus.goger@theobroma-systems.com>
-Masahisa Kojima <kojima.masahisa@socionext.com> <masahisa.kojima@linaro.org>
 Linus Walleij <linusw@kernel.org> <linus.walleij@linaro.org>
 Love Kumar <love.kumar@amd.com> <love.kumar@xilinx.com>
 Lukasz Majewski <lukma@denx.de>
@@ -89,8 +88,9 @@ Marek Vasut <marex@denx.de> <marek.vasut+renesas@gmail.com>
 Marek Vasut <marex@denx.de> <marek.vasut@gmail.com>
 Marek Vasut <marex@denx.de> <marex at denx.de>
 Markus Klotzbuecher <mk@denx.de>
-Masahiro Yamada <masahiroy@kernel.org> <yamada.masahiro@socionext.com>
 Masahiro Yamada <masahiroy@kernel.org> <yamada.m@jp.panasonic.com>
+Masahiro Yamada <masahiroy@kernel.org> <yamada.masahiro@socionext.com>
+Masahisa Kojima <kojima.masahisa@socionext.com> <masahisa.kojima@linaro.org>
 Mattijs Korpershoek <mkorpershoek@kernel.org> <mkorpershoek@baylibre.com>
 Michal Simek <michal.simek@amd.com> <Monstr@seznam.cz>
 Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
@@ -105,8 +105,6 @@ Nava kishore Manne <nava.kishore.manne@amd.com> <nava.manne@xilinx.com>
 Neal Frager <neal.frager@amd.com> <neal.frager@xilinx.com>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nicolas Saenz Julienne <nsaenz@kernel.org> <nsaenzjulienne@suse.de>
-This contributor prefers not to receive mails <noreply@example.com> <pali@kernel.org>
-This contributor prefers not to receive mails <noreply@example.com> <pali.rohar@gmail.com>
 Padmarao Begari <padmarao.begari@amd.com> <padmarao.begari@microchip.com>
 Patrice Chotard <patrice.chotard@foss.st.com> <patrice.chotard@st.com>
 Patrick Delaunay <patrick.delaunay@foss.st.com> <patrick.delaunay@st.com>
@@ -147,9 +145,11 @@ Stefan Roese <stefan.roese@mailbox.org> <stroese>
 Stefano Babic <sbabic@nabladev.com>
 Stefano Stabellini <stefano.stabellini@amd.com> <stefano.stabellini@xilinx.com>
 Sughosh Ganu <sughosh.ganu@arm.com> <sughosh.ganu@linaro.org>
-No generic patch CC mail please <noreply@example.com> <swarren@wwwdotorg.org>
-No generic patch CC mail please <noreply@example.com> <swarren@nvidia.com>
 Sumit Garg <sumit.garg@kernel.org> <sumit.garg@linaro.org>
+This contributor prefers not to receive mails <noreply@example.com> <pali.rohar@gmail.com>
+This contributor prefers not to receive mails <noreply@example.com> <pali@kernel.org>
+This contributor prefers not to receive mails <noreply@example.com> <swarren@nvidia.com>
+This contributor prefers not to receive mails <noreply@example.com> <swarren@wwwdotorg.org>
 Tom Rini <trini@konsulko.com> <trini@ti.com>
 Tomas Thoresen <tomas.thoresen@amd.com> <tomast@xilinx.com>
 TsiChung Liew <Tsi-Chung.Liew@freescale.com>
---
base-commit: bdcadd64dd750f617943ee7088ea4724e19d1f8b
branch: debian-sent3

-- 
2.43.0

