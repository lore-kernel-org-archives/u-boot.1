Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBF606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lKTPFdMK;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=EAtfM5ur
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49BAD60DE0;
	Thu, 19 Nov 2026 15:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTx3pZxlVc3f; Thu, 19 Nov 2026 15:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6469060AD2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103677;
	b=a87B7QWNrIHUt3HfTNSHj9Fpd7I/E8rgbCSs4xqb3vRuerBzsvFnkfent0CNnyCUOrgR
	 qffcwoYmiQ6Kzy1K5/Qgr9s7iC2fqrIBFCXyPyCGTG8zJJ+wWYlzc2qT6ZRJu+RkHOobw
	 Jym4lpJZ9XpHXHWUZ6MHmceLSdrMQgmgQru5nheLGdODrucF0p2dGSOVp8Gp1JQtCvfOX
	 MBprikLskCGgtCoJS0a12UCDaYNmBJ73443QMa69NkADaAnm7x/6I7Xx0uevEvFBnTnZP
	 UcbHnpn0ybtXH7wNQDLz/ChmJcqPalET/pmC1n1PS4OCkBKW5CpITFaPX5hYYx39/jw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=E6ckbsQ1fs0EGBKJuqJmHBi+Z50K0y44C0s0eHIH6fE=;
	b=NEvSM1MvZ+IiILVrnWj2UOzDaR9UIlt1QCkVO9mEQX+dny7mnmkjSRc7j5xJOOmhD/ZO
	 nUh/poX40zk3jPx2Y3H37OotXQyAY6y/qdr4/Tf5WJHhN8+7QR2i7D4RNE1vHtYuCTGan
	 XPvpETREH167nbrpfyg2KGgllxi4QbWpkKb9f7YZpzOmFgZnstC2Lun9Tfr9lUWoTUr88
	 wdL+se6OCJ12zghaiNHaO61Y17ikQ8PlgV0C/O1ZhCw7ztb5+BG+/UkDk0tDsllWYfUbk
	 8/hwQw2rLMyxGZQf5DMYh/1FGpAgRO0R/Sl/6+Qt1ZFkizmsRLer1TsNLMEaDW4wbAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103677;
	bh=E6ckbsQ1fs0EGBKJuqJmHBi+Z50K0y44C0s0eHIH6fE=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lKTPFdMKzorb+s+6j7fZuOy8vqzmZP/MckRQq4RJ0rF32qxy+AAs5TwcA0Ob+QuyO
	 wWod0cxLoTSmK0rAPkZnJ7rMGKZekepDtFQdh/eo84t203CrlqpNTsDZgyHL23Saph
	 budchnbvnFY1RDjiow4Ld8fKKNv0NMSVRnLaQk/wCv0sxoRqeqi171zkcOgVbBfAOT
	 lg4tbJevRqyThnx+ZZzxBfTJmV3VDqP/KTcrFFJbaAEe/QAO9WeIQUfXy8LwbcWro8
	 g7Q/8n025+7ksO3ELXd+8p+zaBZsOLCD9MZzLNJRKz+wj1kaXB6RUGPlj3ME/7jRcp
	 HLNhaCrV/QyeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6469060AD2;
	Thu, 19 Nov 2026 15:54:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FF0A1C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0628E8135C
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ydfB17NSvDaz for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F4CA812EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=t.schmelzer@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=EAtfM5ur
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F4CA812EF
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6ckbsQ1fs0EGBKJuqJmHBi+Z50K0y44C0s0eHIH6fE=;
 b=EAtfM5ur4xc75R8dASBG9mKqTU6mufWqGYXKLC9UWXpMNrNtRRbBomopx2Oluc3BkzTUrdO7p8bZaO2h+uQvUy7uL6HnkNJV2BBn0fWUkc2c00V0zbjhEfuAoC4m9KYIqV4NBTVtJ/xpWm+y6A9da/2E6ZdtA4e8VWexsM9Cw/YK6pg9aodncaA7LT6FcIk5AVCtjluvPtJ21QuCxypXc5cgHKFClBLGW8WnbeFvcWogLjP4X49fudL1talIDNNFRjGonwVZACSMsDcVmdWb+iCyG6Cay6JurohuD3SUNpl/M3iHUqOmyxTI3OqV3vh02YeOkKREVKzesuGzWTmjXA==
Received: from PAYP264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::6)
 by VI0P195MB3010.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 14:12:38 +0000
Received: from MI3PEPF0000855A.eurprd05.prod.outlook.com
 (2603:10a6:102:11f:cafe::78) by PAYP264CA0019.outlook.office365.com
 (2603:10a6:102:11f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 14:12:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MI3PEPF0000855A.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:12:34 +0000
Received: from [127.0.1.1] (172.25.32.137) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 19 Nov
 2026 15:12:32 +0100
From: Thorsten Schmelzer <t.schmelzer@phytec.de>
Date: Thu, 19 Nov 2026 15:12:16 +0100
Subject: [PATCH 4/4] board: phycore_imx8mm: env: Add fastboot raw
 partitions for UUU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-4-dd6db9e5edfd@phytec.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, <upstream@lists.phytec.de>,
 <u-boot@lists.u-boot-project.org>
CC: Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>, Yannic Moog
 <y.moog@phytec.de>, Benedikt Spranger <b.spranger@linutronix.de>, INgo Rah
 <ingo.rah@linutronix.de>, Thorsten Schmelzer <t.schmelzer@phytec.de>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000855A:EE_|VI0P195MB3010:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ce6a12-dfdb-481b-4896-08df4647286f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|42112799006|261026121527099003|10067099003|261026140227099003|261026130827099003|261021130227099003|5023799004|56012099006|11063799006|261021123027099003|261022075727099003|261021133027099003|261026135527099003|261021135927099003|261021121427099003|261022115727099003|261022105027099003|261022113327099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: lglDyuTr5D+r1t3EGxUF7Ef9TFu8SRkr7kDeLo/mZ/bWFysLRDnW0ih6OcKDbGYoFTCrFox9IeAjnMkA2lr8+RiQGGV4pspI7bsCt41MpGQrEEXkzD7eWUvZ1WRhcY/LdsQICc/E9QsSSYEYJnRuYMuf8paMuuyJUPThqP+Bho//XscAejOml9GcECZd3z8KGoGqYiWBsd/40ZHdJPET2Yy1KHtnx6zv1ftlkerodgqf4MSdgFRBLgAGABZd1D2HPSMmdah0HO+1KZap5TXdJgxD8bZgA+c5GeEAItqFU5dPVSRT0QZzeyeqedlhDkvOR3DiU5H0m3T6tv0lzpKS0+dhtu6i5+gEUfkXzwnUli8ZbfrPqS8s0SUa8ZorOjQKk6PO5+7RFGbYFHgU8uzUXTUTV36WY4iMqw3wQhDXlvMlP3SK34ElWvPvo2NARh4vFwThliHtQALiZZNOUMZdQLKFingOqetJWv1fFrmpRn7QURQsg48A+28t5Fh9x/kX5K51TSdahkYPh3oSch4oMIavtnl9qtYcqhe9CCmudvuq/ZSm2+icZuWi8gi2nNS0ZT6lkfy5YdW5yeOY7D9UmSFP7ZgzTwkiSGQsXxSLQ1+DTSWh8TS3xhM8/aU+4UMQYAXrTueVury/gwnT+aXDI/1tRoFvgtyUYq6Yoau/9tBwX16UWGLHiBQSZZXjG58H0HRz+DyXD2CF+plPtIiaZA==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(42112799006)(261026121527099003)(10067099003)(261026140227099003)(261026130827099003)(261021130227099003)(5023799004)(56012099006)(11063799006)(261021123027099003)(261022075727099003)(261021133027099003)(261026135527099003)(261021135927099003)(261021121427099003)(261022115727099003)(261022105027099003)(261022113327099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +Chry/Y4yp5s4ryb4riZpL0RDvznJlGETDRmRX3w9P8m5tT204kpF07NVjAz6jzZyAdRLyHUKGiCjA+LGPAei5ygvQtSFl02rOFC7yhp1kav3hu4hdeR4m1CGBMbYadtNds6lXHbfCDyGm6pZxEpUix0Rx+vv9ZlwWmNhmGPWcDtn7W9dzG62/KOwpwPsvTecucruzjXq6lHZCxPJ99pwzTnQyDBcII1vVsXauruWszsNGCepRFOl1KTlyXYgOwvu+Jm6sqL0R9EA0Gbur++v0NVzV7c7/Z10baClxfUvtRFfonp2VSdPVREHi5eGNDJB9fExF+ohZodu6zPNxiS9hOK6emnbd6d8UjwVz2Kof8MWcCsFN6hozcmYweXjEtAofE/QzA+U9oqUJ18AwL/aUAT45u8129/btJUU0/TX3CQwDXsYdPv5eKGF7vtRm7m
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:12:34.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ce6a12-dfdb-481b-4896-08df4647286f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000855A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3010
X-Mailman-Approved-At: Thu, 19 Nov 2026 15:54:27 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add fastboot raw partition configuration for 'bootloader' and 'all'
partitions. The 'bootloader' partitions allows writing the bootloader to
emmc boot0 partition at the correct offset. The 'all' partition allows
writing the complete emmc user area.

These changes allow to use UUU with the inbuilt default scripts:
        uuu -b emmc_all _flash.bin _image.wic

Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
---
 board/phytec/phycore_imx8mm/phycore_imx8mm.env | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/phytec/phycore_imx8mm/phycore_imx8mm.env b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
index 7cd601f8cd58..bd018f9d0061 100644
--- a/board/phytec/phycore_imx8mm/phycore_imx8mm.env
+++ b/board/phytec/phycore_imx8mm/phycore_imx8mm.env
@@ -1,6 +1,8 @@
 boot_script_dhcp=net_boot_fit.scr.uimg
 console=ttymxc2,CONFIG_BAUDRATE
 emmc_dev=2  /* This is needed by built-in uuu flash scripts */
+fastboot_raw_partition_all=0 4194304
+fastboot_raw_partition_bootloader=66 8126 mmcpart 1
 fdt_addr_r=0x40480000
 fdtfile=DEFAULT_FDT_FILE
 fdtoverlay_addr_r=0x404a0000

-- 
2.53.0

