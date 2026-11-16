Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B748606A337
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aSxTMX2k;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=MoTOLvls
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0847180E03;
	Mon, 16 Nov 2026 13:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1jIqbdGLcwVl; Mon, 16 Nov 2026 13:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C8B880D62
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794837260;
	b=tWuuFEtYd1PvDfkd2Qk8gnF+ypiF0xQb/TfT/sy1uvJEg78/Y2N+F8lpbZJj9K/nE0an
	 6tMdmGzNNOHAepJEaQuTW6G3gaQ7kIhtWvyiOyac9lrd4bfB68mNkSHyXBz3iYRm7Ksgl
	 8IF2tDRN5uO+fPtJP0hYTbCO6iZeOwEbYgJpGyq6un74wOxGWy8jWgNreLnoMVqNUVUQ+
	 2s85cx8Z9JtobI12o4JmVWcVRSyUXVrb5i9l8+IzDkPZyq1QH1kGJJolEUmgMjP9oOf1q
	 SslIZSbzx5SeTF6MAay+rSTN5yoMkTnVdQgDa5zzeX9hMSfDO6sPlByY41uGNXZ5QKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794837260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=joFgw+JEoNgUNO0vbt0o39juTBSWcncsbagPT4m+SqY=;
	b=fwc9BVK/cpYhoZ85SbHb7fVX0aCgGqJ8lssItQUNiK6Ca2qY//9cnK2KK9imPmD3VxO+
	 0MeSakvpy0g2ah7hvNnSHlLkrKk0nBUimIJyL7gB4zUVKd+s7aocCzU+Hp7Weg3j+QOsw
	 tXy0D7mjYY3s9m8uDffJd3jSyxQxRRF1XlXAUJRMVq+GiXgiZ3IKr1h8nugYQ02MYM2rJ
	 bxJTpTgytc5yjSMdQrHtmRxo2E9ZD7255iRcuzkvtWuucEaozpJS2Ts9Xv/5qsG5njChZ
	 EvhIQjGxuiSMqiFvoVMUhnFUOM5X8+53i/MyQ13lh00abhLqh7H7Q9QinIJZ6RUIG/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794837260;
	bh=joFgw+JEoNgUNO0vbt0o39juTBSWcncsbagPT4m+SqY=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSxTMX2k3TYFh80ljCldo4JZhiLDmmzXDFl7c2RPW12TxZIObuf7wui2z/qJ8vwlS
	 WQrBRDcZCcQVZD9SgTx9Xy+yS8+O8rTdzjAa/9OLDLaHe8rV2ZLudAccG3BfmT+BrR
	 sJlI+vfAGZmzwpKP1zpqYPQdKncVOji56yQZplD5gP7Y1X8nhJw3Df8BBEtavEI80A
	 EVyRdKyGqiLPcD1np4px65Z1kw/K3JHYpsDqhpiOMSA98pgUGrEBFB973nLRMGzYMw
	 +qVSiU9kbgdozCB0ST8LQm3I9IxAggbL1WJutn75aMJmYuA1sN+xZdIGxLj5gz53Sd
	 0lwheER4Wpbew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C8B880D62;
	Mon, 16 Nov 2026 13:54:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E77A72FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C012F607EC
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:54:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M9YA3ZdQfwxX for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:54:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64A4A605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=y.moog@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=MoTOLvls
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64A4A605DF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joFgw+JEoNgUNO0vbt0o39juTBSWcncsbagPT4m+SqY=;
 b=MoTOLvlsej1yob4J1fIsbbnsRENbFDH2jGtQFtihwbAh6qv0F/Se/YJsINcEMjHGWgRiteQTKLKjyN8or+Aty7BBXB5PV5aIhxE+WgOoCYKqe2KuVuLQFVJ0GcdbZV7AfdKRFaawF66arvVHTJZoaL1NugRLOA4QcOzGmGz0XzSsz1uGkRPp+tsidjQFAusHEonGh/7beMooSagXQmKzqBciiU06ZPQeb1Tt6HefnjjjC5pz25wSddp1KqJVlU5EASIAGw479maX4ZjNwYp5/cowFuDft8MReDfhLc2ylSSElwaC6uNggF6n5yME4iiom81bVbYsf8tywy8A+Py/Jw==
Received: from PAZP264CA0115.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::11)
 by AS8P195MB1144.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3d2::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:54:08 +0000
Received: from MAD0EPF000008C5.eurprd05.prod.outlook.com
 (2603:10a6:102:1ef:cafe::7c) by PAZP264CA0115.outlook.office365.com
 (2603:10a6:102:1ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 13:54:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 MAD0EPF000008C5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 13:54:06 +0000
Received: from [192.168.2.222] (172.25.39.168) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 16 Nov
 2026 14:54:00 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Mon, 16 Nov 2026 14:53:50 +0100
Subject: [PATCH 1/2] board: phytec: add phyFLEX-i.MX 8M Plus Libra RDK support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-1-e44000b3d3d0@phytec.de>
References: <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-0-e44000b3d3d0@phytec.de>
In-Reply-To: <20261116-wip-y-moog-phytec-de-bspimx8m-4196-v1-0-e44000b3d3d0@phytec.de>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
CC: Benjamin Hahn <b.hahn@phytec.de>, Christian Hemp <C.Hemp@phytec.de>, "Jan
 Remmet" <j.remmet@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Stefano Babic" <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Yannic Moog <y.moog@phytec.de>, Peng Fan <peng.fan@nxp.com>, Adam Ford
 <aford173@gmail.com>, =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794837239; l=99636;
 i=y.moog@phytec.de; s=20250509; h=from:subject:message-id;
 bh=kujVfpZKDug8oZ8EWoBZ06hb8OezsRJAo4JQM3Swc1U=;
 b=o5fB+pzRNPnZHZtp9K1NQ66jMLaFlp/zCY0Y8flxQsunkHI4ipAo53NxaPHWnjXm3eyuE988K
 CUr+MJC0HlhAlEa5KYyQfZ1j8lw52YNAmJ9j8QVGzfr987PbUdOZAe9
X-Developer-Key: i=y.moog@phytec.de; a=ed25519;
 pk=rpKoEJ4E7nD9qsrU/rfKVwMTWNWYaTBylZuJUXUiFr8=
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C5:EE_|AS8P195MB1144:EE_
X-MS-Office365-Filtering-Correlation-Id: c730b6ea-6222-4c56-b6c8-08df43e914c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|10067099003|56012099006|260925021311599003|260925022911599003|260925021911599003|11063799006|261026121527099003|261026130827099003|261026135527099003|261026140227099003|261028144727099003|261021135927099003|261021133027099003|261021123027099003|261021130227099003|261022113327099003|261021121427099003|261022075727099003|261022105027099003|261022115727099003|261102123227099003|261009221227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: TF6mwjSb5ToHlM2Na204YdoSD0ZB/IKWYfJQ0+4w3BKwHKhy6gR3tGNCZcYsVH0xl4fr87UOPbxo3jH6a0ME0vwuAfiDNIlFSyqoH5KaqdDi9VNu9B/5a2rvp0r/Nxmd0zVP4P8gn/dZtZ8Qd2xwZNNZMqeNXNjI4VxPlgIrmOEVJqUbMK9Or0VL6KVrC9l+iDzzZtCsDKvg5L2VVt813hsJ5gdQ8E+ncTUOoH458vCWnqhVAHz2FDSCBRNosp+3+piHRq1si373lX7I/lUfVpe4Cnjz/gleNp+uA3OrjqfB4jK1yaZ/je05nmSOXphg9pRHta1h5bnKilzC2FQsQGBGD9yka1bX6cjoaGcbd214bvVyTOltpBlsBlv5YTwql6uhwzPlwEf8o9LSK3UDxoUf83oYLxsRQ9nAdcLv4qxJaIbkMcul0Yy+/MLWvyPn/eZz8AF2Rq5dbUD/psLPdHLqmY5TX1Mzj9tui8JR4xIs6/Yb/YRDyIIO2yzibG5yHeNOro8FnaruEG0rpjWlkZmFZB4Zp1qd6+YwQOsvwaFmBSbXs6VEjgXFA1kBcM2K+tMT5SNZEZ5KuGXDg7kn0G+Q/cyOHLb3EAVWGiX9HFAFwlaL1G5U515ZJuXbf4sa5RnSSY1NAYAoyVvMgeroBQ==
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(261026121527099003)(261026130827099003)(261026135527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021133027099003)(261021123027099003)(261021130227099003)(261022113327099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022115727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0dapj1DvwGRBkuD6g40uvIkCLLMB/3onHazLOKvRt9NrfjC4Pm9jzxwLNUUdgnB5qa9PCnonrHnXTxtlQWzNL0bdSql+ExK4///FVmNFYRH0ivuZQ9mOAQHdIzlWpvcExCxTMZnTYo0L3whBUvdnBK0Vk5+PgFWcJ6BOVMdZfAkAmJXmo+GiyBECPDOC39TeM4qXtjDRlqz5RnelNKtokelo6/li425L6Pm1ei6wC3hypo7Kd98aTPvGkXYlbG482Wa6GpVNX8dM9/RS50CeK/yQTSKbv9MsjMR1C9RBWldNwENPXEHpGO41Pzydl+NfKtMLiO9SkwGPJT66E72UtNyX/74xtqHQcchn1xAQVSk3pnVOtrQh1/C3h3Ppy2yD7tZtLY0anCdrAJ8C2vnQm+0f88W1JAZr3Rw9jECDoR5oiH4KfFq7aThoKP15D6Ne
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:54:06.3821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c730b6ea-6222-4c56-b6c8-08df43e914c4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1144
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

The phyFLEX-i.MX 8M Plus Libra RDK is the successor/replacement to/of
the phyCORE-i.MX 8M Plus Libra RDK. Both describe the same product.
Supported hardware features:
* watchdog
* i2c
* e.MMC/SD card
* Ethernet
* QSPI-NOR
* 2GiB RAM (default)
* 4GiB RAM (needs be selected through Kconfig)

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 arch/arm/dts/imx8mp-phyflex-fpsc-g-som.dtsi        |  858 +++++++++
 arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi  |   68 +
 arch/arm/dts/imx8mp-phyflex-libra-rdk.dts          |  592 +++++++
 arch/arm/mach-imx/imx8m/Kconfig                    |   10 +
 board/phytec/common/imx8m_som_detection.h          |    7 +
 board/phytec/imx8mp-phyflex-libra-rdk/Kconfig      |   45 +
 board/phytec/imx8mp-phyflex-libra-rdk/MAINTAINERS  |   11 +
 board/phytec/imx8mp-phyflex-libra-rdk/Makefile     |   10 +
 .../imx8mp-phyflex-libra-rdk.c                     |  120 ++
 .../imx8mp-phyflex-libra-rdk.env                   |   18 +
 .../imx8mp-phyflex-libra-rdk/imximage-8mp-sd.cfg   |    8 +
 .../imx8mp-phyflex-libra-rdk/lpddr4_timing.c       | 1823 ++++++++++++++++++++
 .../imx8mp-phyflex-libra-rdk/lpddr4_timing.h       |   11 +
 board/phytec/imx8mp-phyflex-libra-rdk/spl.c        |  141 ++
 configs/imx8mp-phyflex-libra-rdk_defconfig         |  183 ++
 doc/board/phytec/imx8mp-phyflex-libra-rdk.rst      |   81 +
 doc/board/phytec/index.rst                         |    1 +
 include/configs/imx8mp-phyflex-libra-rdk.h         |   32 +
 18 files changed, 4019 insertions(+)

diff --git a/arch/arm/dts/imx8mp-phyflex-fpsc-g-som.dtsi b/arch/arm/dts/imx8mp-phyflex-fpsc-g-som.dtsi
new file mode 100644
index 000000000000..ed6167d85292
--- /dev/null
+++ b/arch/arm/dts/imx8mp-phyflex-fpsc-g-som.dtsi
@@ -0,0 +1,858 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include "imx8mp.dtsi"
+
+/ {
+	compatible = "phytec,imx8mp-phyflex-fpsc-g", "fsl,imx8mp";
+	model = "PHYTEC phyFLEX-i.MX8MP FPSC";
+
+	aliases {
+		rtc0 = &rv3028;
+		rtc1 = &snvs_rtc;
+		/delete-property/ ethernet0;
+		ethernet1 = &fec;
+		ethernet2 = &eqos;
+		/delete-property/ i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c5;
+		i2c5 = &i2c6;
+		/delete-property/ serial0;
+		serial1 = &uart3;
+		serial2 = &uart2;
+		serial3 = &uart4;
+		spi1 = &ecspi1;
+		spi2 = &ecspi2;
+		spi3 = &ecspi3;
+		usb1 = &usb3_0;
+		usb2 = &usb3_1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x80000000>;
+	};
+
+	reg_usdhc2_vmmc: regulator-usdhc2 {
+		compatible = "regulator-fixed";
+		off-on-delay-us = <12000>;
+		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
+		pinctrl-names = "default";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDDSW_SD2";
+		startup-delay-us = <100>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		bootph-all;
+	};
+
+	reg_vdd_io: regulator-vdd-io {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "VDD_IO";
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&ecspi1 { /* FPSC SPI1 */
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	pinctrl-names = "default";
+};
+
+&ecspi2 { /* FPSC SPI2 */
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	pinctrl-names = "default";
+};
+
+&ecspi3 { /* FPSC SPI3 */
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	pinctrl-names = "default";
+};
+
+&eqos { /* FPSC RGMII2 */
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-names = "default";
+};
+
+&fec { /* FPSC GB_ETH1 */
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-names = "default";
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			interrupt-parent = <&gpio4>;
+			interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+			enet-phy-lane-no-swap;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,min-output-impedance;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		};
+	};
+};
+
+&flexcan1 { /* FPSC CAN1 */
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	pinctrl-names = "default";
+};
+
+&flexcan2 { /* FPSC CAN2 */
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	pinctrl-names = "default";
+};
+
+&flexspi { /* FPSC QSPI */
+	pinctrl-0 = <&pinctrl_flexspi>;
+	pinctrl-names = "default";
+};
+
+&gpio1 {
+	gpio-line-names = "", "", "", "", "",
+			  "", "", "", "PCIE1_nPERST";
+	bootph-all;
+};
+
+&gpio2 {
+	gpio-line-names = "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "SD2_RESET_B";
+	bootph-all;
+};
+
+&gpio3 {
+	gpio-line-names = "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "I2C6_SCL",
+			  "I2C6_SDA", "I2C5_SCL";
+	bootph-all;
+};
+
+&gpio4 { /* FPSC GPIO */
+	gpio-line-names = "GPIO6", "RGMII2_nINT", "GPIO7", "GPIO4", "",
+			  "", "", "", "", "",
+			  "", "", "", "", "",
+			  "", "", "", "X_PMIC_IRQ_B", "",
+			  "", "GPIO5", "", "", "RGMII2_EVENT_OUT",
+			  "", "", "RGMII2_EVENT_IN";
+	pinctrl-0 = <&pinctrl_gpio4>;
+	pinctrl-names = "default";
+	bootph-all;
+};
+
+&gpio5 { /* FPSC GPIO */
+	gpio-line-names = "", "", "", "", "I2C5_SDA",
+			  "GPIO1", "", "", "", "SPI1_CS",
+			  "", "", "", "SPI2_CS", "I2C1_SCL",
+			  "I2C1_SDA", "I2C2_SCL", "I2C2_SDA", "I2C3_SCL", "I2C3_SDA",
+			  "", "GPIO2", "", "", "SPI3_CS",
+			  "", "GPIO3";
+	pinctrl-0 = <&pinctrl_gpio5>;
+	pinctrl-names = "default";
+	bootph-all;
+};
+
+&hdmi_tx {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hdmi>;
+};
+
+&i2c1 { /* FPSC I2C1 */
+	clock-frequency = <400000>;
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	bootph-all;
+	status = "okay";
+
+	pmic: pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&pinctrl_pmic>;
+		pinctrl-names = "default";
+		bootph-all;
+
+		regulators {
+			bootph-all;
+
+			buck1: BUCK1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <950000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "VDD_SOC (BUCK1)";
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1000000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "VDD_ARM (BUCK2)";
+				regulator-ramp-delay = <3125>;
+				nxp,dvs-run-voltage = <950000>;
+				nxp,dvs-standby-voltage = <850000>;
+			};
+
+			buck4: BUCK4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "VDD_3V3 (BUCK4)";
+			};
+
+			buck5: BUCK5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "VDD_1V8 (BUCK5)";
+			};
+
+			buck6: BUCK6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1155000>;
+				regulator-min-microvolt = <1045000>;
+				regulator-name = "NVCC_DRAM_1V1 (BUCK6)";
+			};
+
+			ldo1: LDO1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "NVCC_SNVS_1V8 (LDO1)";
+			};
+
+			ldo3: LDO3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "VDDA_1V8 (LDO3)";
+			};
+
+			ldo5: LDO5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "NVCC_SD2 (LDO5)";
+			};
+		};
+	};
+
+	/* User EEPROM */
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vdd_io>;
+	};
+
+	/* factory EEPROM */
+	eeprom@51 {
+		compatible = "atmel,24c32";
+		reg = <0x51>;
+		pagesize = <32>;
+		read-only;
+		vcc-supply = <&reg_vdd_io>;
+	};
+
+	/* User EEPROM ID page */
+	eeprom@58 {
+		compatible = "atmel,24c32";
+		reg = <0x58>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vdd_io>;
+	};
+
+	rv3028: rtc@52 {
+		compatible = "microcrystal,rv3028";
+		reg = <0x52>;
+		#clock-cells = <0>;
+	};
+};
+
+&i2c2 { /* FPSC I2C2 */
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c3 { /* FPSC I2C3 */
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c5 { /* FPSC I2C4 */
+	pinctrl-0 = <&pinctrl_i2c5>;
+	pinctrl-1 = <&pinctrl_i2c5_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio3 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&i2c6 { /* FPSC I2C5 */
+	pinctrl-0 = <&pinctrl_i2c6>;
+	pinctrl-1 = <&pinctrl_i2c6_gpio>;
+	pinctrl-names = "default", "gpio";
+	scl-gpios = <&gpio3 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+&iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__ECSPI1_SCLK   0x82    /* SPI1_SCLK */
+			MX8MP_IOMUXC_ECSPI1_MOSI__ECSPI1_MOSI   0x82    /* SPI1_MOSI */
+			MX8MP_IOMUXC_ECSPI1_MISO__ECSPI1_MISO   0x82    /* SPI1_MISO */
+			MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09     0x106   /* SPI1_CS */
+		>;
+	};
+
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI2_SCLK__ECSPI2_SCLK   0x82    /* SPI2_SCLK */
+			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI   0x82    /* SPI2_MOSI */
+			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO   0x82    /* SPI2_MISO */
+			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13     0x106     /* SPI2_CS */
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__ECSPI3_SCLK     0x82    /* SPI3_SCLK */
+			MX8MP_IOMUXC_UART1_TXD__ECSPI3_MOSI     0x82    /* SPI3_MOSI */
+			MX8MP_IOMUXC_UART2_RXD__ECSPI3_MISO     0x82    /* SPI3_MISO */
+			MX8MP_IOMUXC_UART2_RXD__GPIO5_IO24      0x106     /* SPI3_CS */
+		>;
+	};
+
+	pinctrl_eqos: eqosgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXC__GPIO4_IO01				0x10	/* RGMII2_nINT */
+			MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27				0x10	/* RGMII2_EVENT_IN */
+			MX8MP_IOMUXC_SAI2_TXFS__GPIO4_IO24				0x10	/* RGMII2_EVENT_OUT */
+			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO				0x2	/* RGMII2_MDIO */
+			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2	/* RGMII2_MDC */
+			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3			0x12	/* RGMII2_TX_D3 */
+			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2			0x12	/* RGMII2_TX_D2 */
+			MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1			0x12	/* RGMII2_TX_D1 */
+			MX8MP_IOMUXC_ENET_TD0__ENET_QOS_RGMII_TD0			0x12	/* RGMII2_TX_D0 */
+			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL			0x12	/* RGMII2_TX_CTL */
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x12	/* RGMII2_TXC */
+			MX8MP_IOMUXC_ENET_RD3__ENET_QOS_RGMII_RD3			0x90	/* RGMII2_RX_D3 */
+			MX8MP_IOMUXC_ENET_RD2__ENET_QOS_RGMII_RD2			0x90	/* RGMII2_RX_D2 */
+			MX8MP_IOMUXC_ENET_RD1__ENET_QOS_RGMII_RD1			0x90	/* RGMII2_RX_D1 */
+			MX8MP_IOMUXC_ENET_RD0__ENET_QOS_RGMII_RD0			0x90	/* RGMII2_RX_D0 */
+			MX8MP_IOMUXC_ENET_RX_CTL__ENET_QOS_RGMII_RX_CTL			0x90	/* RGMII2_RX_CTL */
+			MX8MP_IOMUXC_ENET_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x90	/* RGMII2_RXC */
+		>;
+	};
+
+	pinctrl_fec: fecgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC		0x2
+			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO		0x2
+			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0		0x90
+			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1		0x90
+			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2		0x90
+			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3		0x90
+			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19		0x140
+			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC		0x90
+			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0		0x12
+			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1		0x12
+			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2		0x14
+			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3		0x14
+			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL	0x14
+			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC		0x14
+			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL	0x90
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_RXC__CAN1_TX		0x150   /* CAN1_TX */
+			MX8MP_IOMUXC_SAI2_TXC__CAN1_RX		0x154   /* CAN1_RX */
+		>;
+	};
+
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXD0__CAN2_TX		0x150   /* CAN2_TX */
+			MX8MP_IOMUXC_UART3_TXD__CAN2_RX		0x154   /* CAN2_RX */
+		>;
+	};
+
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B	0x82	/* QSPI_CE */
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK		0x1c2	/* QSPI_CLK */
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00	0x82	/* QSPI_DATA_0 */
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01	0x82	/* QSPI_DATA_1 */
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02	0x82	/* QSPI_DATA_2 */
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03	0x82	/* QSPI_DATA_3 */
+			MX8MP_IOMUXC_NAND_DQS__FLEXSPI_A_DQS		0x82	/* QSPI_DQS */
+		>;
+	};
+
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_RXD1__GPIO4_IO03	0x40	/* GPIO4 */
+			MX8MP_IOMUXC_SAI2_RXFS__GPIO4_IO21	0x106	/* GPIO5 */
+			MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x106	/* GPIO6 */
+			MX8MP_IOMUXC_SAI1_RXD0__GPIO4_IO02	0x106	/* GPIO7 */
+		>;
+	};
+
+	pinctrl_gpio5: gpio5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_EXT_CLK__GPIO5_IO05	0x106	/* GPIO1 */
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x106	/* GPIO2 */
+			MX8MP_IOMUXC_UART3_RXD__GPIO5_IO26	0x106	/* GPIO3 */
+		>;
+	};
+
+	pinctrl_hdmi: hdmigrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x19	/* HDMI_CEC */
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c3	/* HDMI_SCL */
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c3	/* HDMI_SDA */
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x19	/* HDMI_HPD */
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		bootph-all;
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA	 0x400001c2      /* I2C1_SDA_DNU */
+			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL	 0x400001c2      /* I2C1_SCL_DNU */
+		>;
+	};
+
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15	0x1e2
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14	0x1e2
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA	 0x400001c2      /* I2C2_SDA */
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL	 0x400001c2      /* I2C2_SCL */
+		>;
+	};
+
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e2
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1e2
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA	 0x400001c2      /* I2C3_SDA */
+			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL	 0x400001c2      /* I2C3_SCL */
+		>;
+	};
+
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x1e2
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x1e2
+		>;
+	};
+
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA	 0x400001c2      /* I2C4_SDA */
+			MX8MP_IOMUXC_SAI5_RXD0__I2C5_SCL	0x400001c2      /* I2C4_SCL */
+		>;
+	};
+
+	pinctrl_i2c5_gpio: i2c5gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__GPIO5_IO04	0x1e2
+			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21	0x1e2
+		>;
+	};
+
+	pinctrl_i2c6: i2c6grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__I2C6_SDA	 0x400001c2      /* I2C5_SDA */
+			MX8MP_IOMUXC_SAI5_RXFS__I2C6_SCL	0x400001c2      /* I2C5_SCL */
+		>;
+	};
+
+	pinctrl_i2c6_gpio: i2c6gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXC__GPIO3_IO20	0x1e2
+			MX8MP_IOMUXC_SAI5_RXFS__GPIO3_IO19	0x1e2
+		>;
+	};
+
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__PCIE_CLKREQ_B	0x10	/* PCIE1_nCLKREQ */
+			MX8MP_IOMUXC_GPIO1_IO08__GPIO1_IO08     0x40	/* PCIE1_nPERST */
+		>;
+	};
+
+	pinctrl_pmic: pmicgrp {
+		bootph-all;
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18	0x140
+		>;
+	};
+
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x106	/* PWM1 */
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO09__PWM2_OUT	0x106	/* PWM2 */
+		>;
+	};
+
+	pinctrl_pwm3: pwm3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_TX__PWM3_OUT		0x106	/* PWM3 */
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_MCLK__PWM4_OUT	0x106	/* PWM4 */
+		>;
+	};
+
+	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
+		bootph-all;
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19    0x40
+		>;
+	};
+
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_MCLK__AUDIOMIX_SAI5_MCLK	0xd6	/* SAI1_MCLK */
+			MX8MP_IOMUXC_SAI3_RXFS__AUDIOMIX_SAI5_RX_SYNC	0xd6	/* SAI1_RX_SYNC */
+			MX8MP_IOMUXC_SAI3_RXC__AUDIOMIX_SAI5_RX_BCLK	0xd6	/* SAI1_RX_BCLK */
+			MX8MP_IOMUXC_SAI3_RXD__AUDIOMIX_SAI5_RX_DATA00	0xd6	/* SAI1_RX_DATA */
+			MX8MP_IOMUXC_SAI5_RXD1__AUDIOMIX_SAI5_TX_SYNC	0xd6	/* SAI1_TX_SYNC */
+			MX8MP_IOMUXC_SAI5_RXD2__AUDIOMIX_SAI5_TX_BCLK	0xd6	/* SAI1_TX_BCLK */
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI5_TX_DATA00	0xd6	/* SAI1_TX_DATA */
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI3_TXC__UART2_DTE_RX	0x140	/* UART2_RXD */
+			MX8MP_IOMUXC_SAI3_TXFS__UART2_DTE_TX	0x140	/* UART2_TXD */
+			MX8MP_IOMUXC_SD1_DATA5__UART2_DTE_RTS	0x140	/* UART2_RTS */
+			MX8MP_IOMUXC_SD1_DATA4__UART2_DTE_CTS	0x140	/* UART2_CTS */
+		>;
+	};
+
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_DATA6__UART3_DTE_RX	0x140	/* UART1_RXD */
+			MX8MP_IOMUXC_SD1_DATA7__UART3_DTE_TX	0x140	/* UART1_TXD */
+			MX8MP_IOMUXC_SD1_RESET_B__UART3_DTE_CTS	0x140	/* UART1_RTS */
+			MX8MP_IOMUXC_SD1_STROBE__UART3_DTE_RTS	0x140	/* UART1_CTS */
+		>;
+	};
+
+	pinctrl_uart4: uart4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART4_RXD__UART4_DCE_RX	0x140	/* UART3_RXD */
+			MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX	0x140	/* UART3_TXD */
+		>;
+	};
+
+	pinctrl_usb0: usb0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO12__USB1_OTG_PWR	0x106	/* USB1_PWR_EN */
+			MX8MP_IOMUXC_GPIO1_IO13__USB1_OTG_OC	0x106	/* USB1_OC */
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x106	/* USB1_ID */
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x106	/* USB2_PWR_EN */
+			MX8MP_IOMUXC_GPIO1_IO15__USB2_OTG_OC	0x106	/* USB2_OC */
+			MX8MP_IOMUXC_GPIO1_IO11__USB2_OTG_ID	0x106	/* USB2_ID */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO07__USDHC1_WP	0x106	/* SDIO_WP */
+			MX8MP_IOMUXC_GPIO1_IO06__USDHC1_CD_B	0x106	/* SDIO_CD */
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x106	/* SDIO_CLK */
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x106	/* SDIO_CLK */
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x106	/* SDIO_DATA0 */
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x106	/* SDIO_DATA1 */
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x106	/* SDIO_DATA2 */
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x106	/* SDIO_DATA3 */
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		bootph-pre-ram;
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B	0x40	/* SDCARD_CD */
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP		0x40	/* SDCARD_WP */
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190	/* SDCARD_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0	/* SDCARD_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0	/* SDCARD_DATA0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0	/* SDCARD_DATA1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0	/* SDCARD_DATA2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0	/* SDCARD_DATA3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B	0x40	/* SDCARD_CD */
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP		0x40	/* SDCARD_WP */
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194	/* SDCARD_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d4	/* SDCARD_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4	/* SDCARD_DATA0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4	/* SDCARD_DATA1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4	/* SDCARD_DATA2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4	/* SDCARD_DATA3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD2_CD_B__USDHC2_CD_B	0x40	/* SDCARD_CD */
+			MX8MP_IOMUXC_SD2_WP__USDHC2_WP		0x40	/* SDCARD_WP */
+			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x194	/* SDCARD_CLK */
+			MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD	0x1d0	/* SDCARD_CMD */
+			MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4	/* SDCARD_DATA0 */
+			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4	/* SDCARD_DATA1 */
+			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4	/* SDCARD_DATA2 */
+			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4	/* SDCARD_DATA3 */
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		bootph-all;
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x190
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x194
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d4
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d4
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d4
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d4
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d4
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d4
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d4
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d4
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x194
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_CE1_B__USDHC3_STROBE	0x196
+			MX8MP_IOMUXC_NAND_CE2_B__USDHC3_DATA5	0x1d0
+			MX8MP_IOMUXC_NAND_CE3_B__USDHC3_DATA6	0x1d0
+			MX8MP_IOMUXC_NAND_CLE__USDHC3_DATA7	0x1d0
+			MX8MP_IOMUXC_NAND_DATA04__USDHC3_DATA0	0x1d0
+			MX8MP_IOMUXC_NAND_DATA05__USDHC3_DATA1	0x1d0
+			MX8MP_IOMUXC_NAND_DATA06__USDHC3_DATA2	0x1d0
+			MX8MP_IOMUXC_NAND_DATA07__USDHC3_DATA3	0x1d0
+			MX8MP_IOMUXC_NAND_RE_B__USDHC3_DATA4	0x1d0
+			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x196
+			MX8MP_IOMUXC_NAND_WP_B__USDHC3_CMD	0x1d4
+		>;
+	};
+
+	pinctrl_wdog: wdoggrp {
+		bootph-all;
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO02__WDOG1_WDOG_B	0xe6
+		>;
+	};
+};
+
+&mipi_dsi {
+	vddcore-supply = <&buck1>;
+	vddio-supply = <&buck5>;
+};
+
+&pcie { /* FPSC PCIE1 */
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+};
+
+&pwm1 { /* FPSC PWM1 */
+	pinctrl-0 = <&pinctrl_pwm1>;
+	pinctrl-names = "default";
+};
+
+&pwm2 { /* FPSC PWM2 */
+	pinctrl-0 = <&pinctrl_pwm2>;
+	pinctrl-names = "default";
+};
+
+&pwm3 { /* FPSC PWM3 */
+	pinctrl-0 = <&pinctrl_pwm3>;
+	pinctrl-names = "default";
+};
+
+&pwm4 { /* FPSC PWM4 */
+	pinctrl-0 = <&pinctrl_pwm4>;
+	pinctrl-names = "default";
+};
+
+&sai5 { /* FPSC SAI1 */
+	pinctrl-0 = <&pinctrl_sai5>;
+	pinctrl-names = "default";
+};
+
+&uart2 { /* FPSC UART2 */
+	pinctrl-0 = <&pinctrl_uart2>;
+	pinctrl-names = "default";
+	fsl,dte-mode;
+};
+
+&uart3 { /* FPSC UART1 */
+	pinctrl-0 = <&pinctrl_uart3>;
+	pinctrl-names = "default";
+	fsl,dte-mode;
+};
+
+&uart4 { /* FPSC UART3 */
+	pinctrl-0 = <&pinctrl_uart4>;
+	pinctrl-names = "default";
+};
+
+&usb3_0 { /* FPSC USB1 */
+	pinctrl-0 = <&pinctrl_usb0>;
+	pinctrl-names = "default";
+	fsl,over-current-active-low;
+};
+
+&usb3_1 { /* FPSC USB2 */
+	pinctrl-0 = <&pinctrl_usb1>;
+	pinctrl-names = "default";
+	fsl,over-current-active-low;
+};
+
+&usdhc1 { /* FPSC SDIO */
+	no-mmc-hs400;
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-names = "default";
+};
+
+&usdhc2 { /* FPSC SDCARD */
+	no-mmc-hs400;
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	sd-uhs-sdr104;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&ldo5>;
+	bootph-all;
+};
+
+/* eMMC */
+&usdhc3 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC3_ROOT>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	bootph-all;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-0 = <&pinctrl_wdog>;
+	pinctrl-names = "default";
+	bootph-all;
+	fsl,ext-reset-output;
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi b/arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi
new file mode 100644
index 000000000000..383ded33508d
--- /dev/null
+++ b/arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+#include "imx8mp-u-boot.dtsi"
+
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+
+	bootstd {
+		bootph-verify;
+		compatible = "u-boot,boot-std";
+
+		filename-prefixes = "/", "/boot/";
+		bootdev-order = "mmc2", "mmc1", "ethernet";
+
+		/* order of bootmeth nodes matters */
+		rauc {
+			compatible = "u-boot,distro-rauc";
+		};
+
+		script {
+			compatible = "u-boot,script";
+		};
+	};
+};
+
+&spi_nor {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			reg = <0x00000000 0x024a0000>;
+			label = "u-boot";
+			read-only;
+		};
+
+		partition@24a0000 {
+			reg = <0x024a0000 0x00020000>;
+			label = "env";
+		};
+
+		partition@24c0000 {
+			reg = <0x024c0000 0x00020000>;
+			label = "env_redund";
+		};
+
+		partition@24e0000 {
+			reg = <0x024e0000 0x01b20000>;
+			label = "none";
+		};
+	};
+};
+
+&usb_dwc3_0 {
+	compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+};
+
+&usb_dwc3_1 {
+	compatible = "fsl,imx8mq-dwc3", "snps,dwc3";
+};
diff --git a/arch/arm/dts/imx8mp-phyflex-libra-rdk.dts b/arch/arm/dts/imx8mp-phyflex-libra-rdk.dts
new file mode 100644
index 000000000000..4311fbe22c02
--- /dev/null
+++ b/arch/arm/dts/imx8mp-phyflex-libra-rdk.dts
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "imx8mp-phyflex-fpsc-g-som.dtsi"
+
+/ {
+	compatible = "phytec,imx8mp-phyflex-libra-rdk",
+		     "phytec,imx8mp-phyflex-fpsc-g", "fsl,imx8mp";
+	model = "PHYTEC Libra phyFLEX-i.MX8MP FPSC";
+
+	chosen {
+		stdout-path = &uart4;
+	};
+
+	backlight_lvds: backlight-lvds {
+		compatible = "pwm-backlight";
+		power-supply = <&reg_vdd_12v0>;
+		status = "disabled";
+	};
+
+	can_transceiver1: can-phy1 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		standby-gpios = <&gpio_expander2 0 GPIO_ACTIVE_HIGH>;
+	};
+
+	can_transceiver2: can-phy2 {
+		compatible = "ti,tcan1043";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		standby-gpios = <&gpio_expander2 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		data-role = "dual";
+		pd-disable;
+		self-powered;
+		typec-power-opmode = "1.5A";
+		vbus-supply = <&reg_vdd_vbus>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hs_ep: endpoint {
+					remote-endpoint = <&usb3_hs_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				ss_ep: endpoint {
+					remote-endpoint = <&hd3ss3220_in_ep>;
+				};
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		hdmi-pwr-supply = <&reg_vdd_5v0_hdmi_out>;
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
+	m2-key-e-connector {
+		compatible = "pcie-m2-e-connector";
+		clocks = <&rv3028>;
+		i2c-parent = <&i2c3>;
+		sdio-reset-gpios = <&gpio_expander2 6 GPIO_ACTIVE_LOW>;
+		sdio-wake-gpios = <&gpio_expander2 5 GPIO_ACTIVE_LOW>;
+		uart-wake-gpios = <&gpio_expander1 13 GPIO_ACTIVE_LOW>;
+		vpcie3v3-supply = <&reg_vdd_3v3>;
+		w-disable1-gpios = <&gpio_expander1 9 GPIO_ACTIVE_LOW>;
+		w-disable2-gpios = <&gpio_expander1 10 GPIO_ACTIVE_LOW>;
+	};
+
+	/* RTC (rv3028) clock is used by default */
+	m2_suspend_clk: oscillator-suspend {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768000>;
+		status = "disabled";
+	};
+
+	panel_lvds1: panel-lvds1 {	/* FPSC LVDS1 */
+		/* compatible panel in overlay */
+		backlight = <&backlight_lvds>;
+		power-supply = <&reg_vdd_3v3>;
+		status = "disabled";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&ldb_lvds_ch0>;
+			};
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		interrupt-parent = <&gpio5>;
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>;
+		#cooling-cells = <2>;
+		cooling-levels = <0 128 255>;
+		fan-supply = <&reg_vdd_5v0>;
+		pwms = <&pwm2 0 86958 0>;
+		pulses-per-revolution = <2>;
+	};
+
+	reg_vdd_12v0: regulator-vdd-12v0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "VDD_12V0";
+	};
+
+	reg_vdd_1v8: regulator-vdd-1v8 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "VDD_1V8";
+	};
+
+	reg_vdd_3v3: regulator-vdd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "VDD_3V3";
+	};
+
+	reg_vdd_5v0: regulator-vdd-5v0 {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VDD_5V0";
+	};
+
+	reg_vdd_5v0_hdmi_out: regulator-vdd-5v0-hdmi-out {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio_expander2 7 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VDD_5V0_HDMI_OUT";
+	};
+
+	reg_vdd_5v0_ref: regulator-vdd-5v0-ref {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "VDD_5V0_REF";
+	};
+
+	reg_vdd_vbus: regulator-vdd-vbus {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-name = "VDD_VBUS_C";
+	};
+
+	sound-hdmi {
+		compatible = "fsl,imx-audio-hdmi";
+		model = "audio-hdmi";
+		audio-cpu = <&aud2htx>;
+		hdmi-out;
+	};
+
+};
+
+&{/thermal-zones/soc-thermal/trips/} {
+	atrip2: trip2 {
+		temperature = <55000>;
+		hysteresis = <2000>;
+		type = "active";
+	};
+
+	atrip3: trip3 {
+		temperature = <75000>;
+		hysteresis = <2000>;
+		type = "active";
+	};
+};
+
+&{/thermal-zones/soc-thermal/cooling-maps/} {
+	map1 {
+		trip = <&atrip2>;
+		cooling-device = <&fan 0 1>;
+	};
+
+	map2 {
+		trip = <&atrip3>;
+		cooling-device = <&fan 1 2>;
+	};
+};
+
+&aud2htx {
+	status = "okay";
+};
+
+&eqos {
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0x1>;
+			enet-phy-lane-no-swap;
+			ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+			ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+			ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		};
+	};
+};
+
+/* CAN FD */
+&flexcan1 {
+	phys = <&can_transceiver1>;
+	status = "okay";
+};
+
+&flexcan2 {
+	phys = <&can_transceiver2>;
+	status = "okay";
+};
+
+&ecspi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	num-cs = <1>;
+	status = "okay";
+
+	adc@0 {
+		compatible = "microchip,mcp3208";
+		reg = <0>;
+		vref-supply = <&reg_vdd_5v0_ref>;
+		#io-channel-cells = <1>;
+	};
+};
+
+&ecspi2 {
+	status = "okay";
+
+	tpm@0 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <22500000>;
+	};
+};
+
+&flexspi {
+	status = "okay";
+
+	spi_nor: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <90000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+};
+
+&gpio5 {
+	gpio-line-names = "", "", "", "", "I2C5_SDA",
+			  "GPIO1", "", "", "", "SPI1_CS",
+			  "", "", "", "SPI2_CS", "I2C1_SCL",
+			  "I2C1_SDA", "I2C2_SCL", "I2C2_SDA", "I2C3_SCL", "I2C3_SDA",
+			  "", "GPIO2", "", "", "SPI3_CS",
+			  "", "GPIO3";
+};
+
+&hdmi_pvi {
+	status = "okay";
+};
+
+&hdmi_tx {
+	status = "okay";
+
+	ports {
+		port@1 {
+			reg = <1>;
+			hdmi_tx_out: endpoint {
+				remote-endpoint = <&hdmi_connector_in>;
+			};
+		};
+	};
+};
+
+&hdmi_tx_phy {
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	/* Factory EEPROM */
+	eeprom@51 {
+		compatible = "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+
+	/* User EEPROM */
+	eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <16>;
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+
+	gpio_expander1: gpio@21 {
+		compatible = "ti,tcal6416";
+		reg = <0x21>;
+		interrupt-controller;
+		interrupt-parent = <&gpio5>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		#interrupt-cells = <2>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "VCONN_nFAULT", "CSI1_CTRL1", "CSI1_CTRL3",
+				  "CSI1_CTRL4", "USB-C_nINT/AUDIO_AC",
+				  "CSI2_CTRL1", "CSI2_CTRL3", "CSI2_CTRL4",
+				  "CLK_EN_AV", "W_nDISABLE1", "W_nDISABLE2",
+				  "PCIE1_nWAKE", "NC", "UART1_nWAKE",
+				  "UART1_BT_RS_SEL", "UART1_RS232_485_SEL";
+
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	gpio_expander2: gpio@21 {
+		compatible = "ti,tcal6416";
+		reg = <0x21>;
+		interrupt-controller;
+		interrupt-parent = <&gpio4>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names = "CAN1_STBY", "CAN2_STBY", "NC",
+				  "KEY-E_nALERT", "NC", "SDIO_nWAKE",
+				  "SDIO_nRESET", "HDMI_EN", "RTC_nINT",
+				  "LVDS1_BL_EN", "NC", "NC", "NC", "NC",
+				  "NC", "NC";
+
+		vcc-supply = <&reg_vdd_1v8>;
+	};
+
+	led-controller@62 {
+		compatible = "nxp,pca9633";
+		reg = <0x62>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@0 {
+			reg = <0>;
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+		};
+	};
+
+	usb-typec@47 {
+		compatible = "ti,hd3ss3220";
+		reg = <0x47>;
+		id-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		interrupt-parent = <&gpio_expander1>;
+		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hd3ss3220_in_ep: endpoint {
+					remote-endpoint = <&ss_ep>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hd3ss3220_out_ep: endpoint {
+					remote-endpoint = <&usb3_role_switch>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				hd3ss3220_orientation_switch: endpoint {
+					remote-endpoint = <&usb_phy_orientation_switch>;
+				};
+			};
+		};
+	};
+};
+
+&lcdif3 {
+	status = "okay";
+};
+
+&lvds_bridge {
+	ports {
+		port@1 {
+			ldb_lvds_ch0: endpoint {
+				remote-endpoint = <&panel0_in>;
+			};
+		};
+	};
+};
+
+/* M.2 PCIe */
+&pcie {
+	external-facing;
+	reset-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	supports-clkreq;
+	vpcie-supply = <&reg_vdd_3v3>;
+	wake-gpios = <&gpio_expander1 11 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcie_phy {
+	clocks = <&hsio_blk_ctrl>;
+	clock-names = "ref";
+	fsl,clkreq-unsupported;
+	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_OUTPUT>;
+	status = "okay";
+};
+
+&pinctrl_uart4 {
+	bootph-all;
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&reg_vdd_io {
+	regulator-max-microvolt = <1800000>;
+	regulator-min-microvolt = <1800000>;
+};
+
+&rv3028 {
+	interrupt-parent = <&gpio_expander2>;
+	interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
+	aux-voltage-chargeable = <1>;
+	trickle-resistor-ohms = <3000>;
+	wakeup-source;
+};
+
+&snvs_pwrkey {
+	status = "okay";
+};
+
+/* RS232/RS485/BT */
+&uart3 {
+	uart-has-rtscts;
+	status = "okay";
+};
+
+/* debug console */
+&uart4 {
+	bootph-all;
+	status = "okay";
+};
+
+/* USB1 Type-C */
+&usb3_phy0 {
+	orientation-switch;
+	vbus-supply = <&reg_vdd_vbus>;
+	status = "okay";
+
+	port {
+		usb_phy_orientation_switch: endpoint {
+			remote-endpoint = <&hd3ss3220_orientation_switch>;
+		};
+	};
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	adp-disable;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			usb3_hs_ep: endpoint {
+				remote-endpoint = <&hs_ep>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+			usb3_role_switch: endpoint {
+				remote-endpoint = <&hd3ss3220_out_ep>;
+			};
+		};
+	};
+};
+
+/* USB2 4-port USB3.0 HUB */
+&usb3_phy1 {
+	vbus-supply = <&reg_vdd_5v0>;
+	status = "okay";
+};
+
+&usb3_1 {
+	fsl,permanently-attached;
+	fsl,disable-port-power-control;
+	status = "okay";
+};
+
+&usb_dwc3_1 {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usdhc1 {
+	bus-width = <4>;
+	status = "okay";
+};
+
+/* SD-Card */
+&usdhc2 {
+	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
+	assigned-clock-rates = <200000000>;
+	bus-width = <4>;
+	disable-wp;
+	status = "okay";
+};
diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index c852c1c742e9..55d4b3184e84 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -372,6 +372,15 @@ config TARGET_IMX8MP_LIBRA_FPSC
 	help
 	  Libra i.MX8M Plus FPSC is an SBC based on the NXP i.MX 8M Plus SoC.
 
+config TARGET_IMX8MP_PHYFLEX_LIBRA_RDK
+	bool "PHYTEC Libra phyFLEX-i.MX 8M Plus FPSC"
+	select IMX8MP
+	select SUPPORT_SPL
+	select IMX8M_LPDDR4
+	help
+	  phyFLEX-i.MX 8M Plus FPSC System-on-Module on the Libra baseboard.
+	  They form the Rapid Development Kit for the SoM.
+
 config TARGET_IMX8MM_CL_IOT_GATE
 	bool "CompuLab iot-gate-imx8"
 	select IMX8MM
@@ -445,6 +454,7 @@ source "board/mntre/imx8mq_reform2/Kconfig"
 source "board/phytec/imx8mp-libra-fpsc/Kconfig"
 source "board/phytec/phycore_imx8mm/Kconfig"
 source "board/phytec/phycore_imx8mp/Kconfig"
+source "board/phytec/imx8mp-phyflex-libra-rdk/Kconfig"
 source "board/polyhex/imx8mp_debix_model_a/Kconfig"
 source "board/purism/librem5/Kconfig"
 source "board/purism/librem5-devkit/Kconfig"
diff --git a/board/phytec/common/imx8m_som_detection.h b/board/phytec/common/imx8m_som_detection.h
index 0176347414fc..bc80b4b1c484 100644
--- a/board/phytec/common/imx8m_som_detection.h
+++ b/board/phytec/common/imx8m_som_detection.h
@@ -13,6 +13,13 @@
 #define PHYTEC_IMX8MM_SOM       69
 #define PHYTEC_IMX8MP_SOM       70
 
+enum phytec_phyflex_imx8mp_ddr_code {
+	PHYTEC_PHYFLEX_IMX8MP_DDR_1GB = 0,
+	PHYTEC_PHYFLEX_IMX8MP_DDR_2GB = 1,
+	PHYTEC_PHYFLEX_IMX8MP_DDR_4GB = 2,
+	PHYTEC_PHYFLEX_IMX8MP_DDR_8GB = 3,
+};
+
 int __maybe_unused phytec_imx8m_detect(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8m_ddr_size(struct phytec_eeprom_data *data);
 u8 __maybe_unused phytec_get_imx8mp_rtc(struct phytec_eeprom_data *data);
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/Kconfig b/board/phytec/imx8mp-phyflex-libra-rdk/Kconfig
new file mode 100644
index 000000000000..2c4835921103
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/Kconfig
@@ -0,0 +1,45 @@
+if TARGET_IMX8MP_PHYFLEX_LIBRA_RDK
+
+config SYS_BOARD
+	default "imx8mp-phyflex-libra-rdk"
+
+config SYS_VENDOR
+	default "phytec"
+
+config IMX_CONFIG
+	default "board/phytec/imx8mp-phyflex-libra-rdk/imximage-8mp-sd.cfg"
+
+config SYS_CONFIG_NAME
+	default "imx8mp-phyflex-libra-rdk"
+
+config PHYFLEX_IMX8MP_RAM_STATIC_SIZE
+	bool "Set phyFLEX-i.MX8MP RAM size static instead of detecting"
+	default false
+	help
+	  RAM size is automatically being detected with the help of
+	  the EEPROM introspection data. Set RAM size to a static value
+	  during compile time instead.
+
+choice
+	prompt "phyFLEX-i.MX8MP RAM size"
+	depends on PHYFLEX_IMX8MP_RAM_STATIC_SIZE
+	default PHYFLEX_IMX8MP_RAM_SIZE_2GB
+	help
+	  Choose a RAM size configuration. Default is 2GB since that is
+	  the default hardware config for the Rapid Development Kit.
+
+config PHYFLEX_IMX8MP_RAM_SIZE_2GB
+	bool "2GB RAM"
+	help
+	  Set RAM size static to 2GB for phyFLEX-i.MX8MP.
+	  2GHz timings will be used.
+
+config PHYFLEX_IMX8MP_RAM_SIZE_4GB
+	bool "4GB RAM"
+	help
+	  Set RAM size static to 4GB for phyFLEX-i.MX8MP.
+	  2GHz timings will be used.
+endchoice
+
+source "board/phytec/common/Kconfig"
+endif
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/MAINTAINERS b/board/phytec/imx8mp-phyflex-libra-rdk/MAINTAINERS
new file mode 100644
index 000000000000..11fbb4a60556
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/MAINTAINERS
@@ -0,0 +1,11 @@
+phyFLEX-i.MX 8M Plus Libra RDK
+M:	Teresa Remmet <t.remmet@phytec.de>
+W:	https://www.phytec.eu/en/produkte/system-on-modules/phyflex-imx-8m-plus-fpsc/
+S:	Maintained
+F:	arch/arm/dts/imx8mp-phyflex-fpsc-g-som.dtsi
+F:	arch/arm/dts/imx8mp-phyflex-libra-rdk.dts
+F:	arch/arm/dts/imx8mp-phyflex-libra-rdk-u-boot.dtsi
+F:	board/phytec/imx8mp-phyflex-libra-rdk
+F:	configs/imx8mp-phyflex-libra-rdk_defconfig
+F:	include/configs/imx8mp-phyflex-libra-rdk.h
+F:	doc/board/phytec/imx8mp-phyflex-libra-rdk.rst
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/Makefile b/board/phytec/imx8mp-phyflex-libra-rdk/Makefile
new file mode 100644
index 000000000000..3e30925ea6a2
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 PHYTEC Messtechnik GmbH
+
+obj-y += imx8mp-phyflex-libra-rdk.o
+
+ifdef CONFIG_XPL_BUILD
+obj-y += spl.o
+obj-$(CONFIG_IMX8M_LPDDR4) += lpddr4_timing.o
+endif
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/imx8mp-phyflex-libra-rdk.c b/board/phytec/imx8mp-phyflex-libra-rdk/imx8mp-phyflex-libra-rdk.c
new file mode 100644
index 000000000000..a7e4962b9c70
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/imx8mp-phyflex-libra-rdk.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/global_data.h>
+#include <linux/io.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <dwc3-uboot.h>
+#include <env.h>
+#include <init.h>
+#include <fdt_support.h>
+#include <jffs2/load_kernel.h>
+#include <miiphy.h>
+#include <mtd_node.h>
+
+#include "../common/imx8m_som_detection.h"
+
+#define EEPROM_ADDR		0x51
+
+/*
+ * WORKAROUND: Set mac addresses as expected in the board code
+ * as imx_get_mac_from_fuse() can not handle FPSC naming scheme.
+ */
+int board_fix_fdt(void *fdt)
+{
+	unsigned char mac[6];
+	int ret;
+
+	ret = fdt_increase_size(fdt, 100);
+	if (ret < 0) {
+		printf("Could not increase fdt. Can not fixup MAC addr: %s\n",
+		       fdt_strerror(ret));
+		return 0;
+	}
+
+	/* set first MAC address */
+	imx_get_mac_from_fuse(0, mac);
+	do_fixup_by_compat(fdt, "fsl,imx8mp-fec", "local-mac-address", &mac, 6, 1);
+
+	/* set second MAC address */
+	imx_get_mac_from_fuse(1, mac);
+	do_fixup_by_compat(fdt, "nxp,imx8mp-dwmac-eqos", "local-mac-address", &mac, 6, 1);
+
+	return 0;
+}
+
+static int setup_fec(void)
+{
+	struct iomuxc_gpr_base_regs *gpr =
+		(struct iomuxc_gpr_base_regs *)IOMUXC_GPR_BASE_ADDR;
+
+	/* Use 125M anatop REF_CLK1 for ENET1, not from external */
+	clrsetbits_le32(&gpr->gpr[1], 0x2000, 0);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	int ret = phytec_eeprom_data_setup(NULL, 1, EEPROM_ADDR);
+
+	if (ret && IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION))
+		printf("%s: EEPROM data init failed\n", __func__);
+
+	setup_fec();
+
+	return 0;
+}
+
+int board_mmc_get_env_dev(int devno)
+{
+	return devno;
+}
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_copy_fixed_partitions(blob);
+}
+
+int mmc_map_to_kernel_blk(int dev_no)
+{
+	return dev_no;
+}
+
+int board_late_init(void)
+{
+	switch (get_boot_device()) {
+	case SD2_BOOT:
+		env_set_ulong("mmcdev", 1);
+		if (!env_get("boot_targets"))
+			env_set("boot_targets", "mmc1 mmc2 ethernet");
+		break;
+	case MMC3_BOOT:
+		env_set_ulong("mmcdev", 2);
+		break;
+	case USB_BOOT:
+		printf("Detect USB boot. Will enter fastboot mode!\n");
+		if (!strcmp(env_get("bootcmd"), env_get_default("bootcmd")))
+			env_set("bootcmd", "fastboot 0; bootflow scan -lb;");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	if (!size)
+		return -EINVAL;
+
+	*size = get_ram_size((void *)PHYS_SDRAM, PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE);
+
+	return 0;
+}
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/imx8mp-phyflex-libra-rdk.env b/board/phytec/imx8mp-phyflex-libra-rdk/imx8mp-phyflex-libra-rdk.env
new file mode 100644
index 000000000000..60e967da49ee
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/imx8mp-phyflex-libra-rdk.env
@@ -0,0 +1,18 @@
+boot_script_dhcp=net_boot_fit.scr.uimg
+console=ttymxc3,CONFIG_BAUDRATE
+emmc_dev=2  /* This is needed by built-in uuu flash scripts */
+fdt_addr_r=0x40480000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtoverlay_addr_r=0x404a0000
+ip_dyn=yes
+kernel_addr_r=0x40a00000
+kernel_comp_addr_r=0x43a00000
+kernel_comp_size=0x1e00000
+nfs_eth_dev=eth0
+nfsroot=/srv/nfs
+pxefile_addr_r=0x45800000
+ramdisk_addr_r=0x45802000
+script_offset_f=0x0
+script_size_f=0x2000
+scriptaddr=0x47600000
+sd_dev=1    /* This is needed by built-in uuu flash scripts */
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/imximage-8mp-sd.cfg b/board/phytec/imx8mp-phyflex-libra-rdk/imximage-8mp-sd.cfg
new file mode 100644
index 000000000000..8aadedb1028c
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/imximage-8mp-sd.cfg
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021 NXP
+ */
+
+ROM_VERSION	v2
+BOOT_FROM	sd
+LOADER		u-boot-spl-ddr.bin	0x920000
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/lpddr4_timing.c b/board/phytec/imx8mp-phyflex-libra-rdk/lpddr4_timing.c
new file mode 100644
index 000000000000..dde5e26a5a94
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/lpddr4_timing.c
@@ -0,0 +1,1823 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 NXP
+ *
+ * Code generated with DDR Tool v3.5.0_9-1ddf053d.
+ * DDR PHY FW2020.06
+ */
+
+#include <linux/kernel.h>
+#include <asm/arch/ddr.h>
+
+/* Initialize DDRC registers */
+struct dram_cfg_param ddr_ddrc_cfg[] = {
+	{0x3d400304, 0x1},
+	{0x3d400030, 0x1},
+	{0x3d400000, 0xa1080020},
+	{0x3d400020, 0x1323},
+	{0x3d400024, 0x1e84800},
+	{0x3d400064, 0x7a0118},
+	{0x3d400070, 0x7027f90},
+	{0x3d400074, 0x790},
+	{0x3d4000d0, 0xc00307a3},
+	{0x3d4000d4, 0xc50000},
+	{0x3d4000dc, 0xf4003f},
+	{0x3d4000e0, 0xe30000},
+	{0x3d4000e8, 0x550048},
+	{0x3d4000ec, 0x150048},
+	{0x3d400100, 0x2028222a},
+	{0x3d400104, 0x8083f},
+	{0x3d40010c, 0xe0e000},
+	{0x3d400110, 0x12040a12},
+	{0x3d400114, 0x2050f0f},
+	{0x3d400118, 0x1010009},
+	{0x3d40011c, 0x502},
+	{0x3d400130, 0x20800},
+	{0x3d400134, 0xe100002},
+	{0x3d400138, 0x120},
+	{0x3d400144, 0xc80064},
+	{0x3d400180, 0x3e8001e},
+	{0x3d400184, 0x3207a12},
+	{0x3d400188, 0x0},
+	{0x3d400190, 0x4a3820e},
+	{0x3d400194, 0x80303},
+	{0x3d4001b4, 0x230e},
+	{0x3d4001a0, 0xe0400018},
+	{0x3d4001a4, 0xdf00e4},
+	{0x3d4001a8, 0x80000000},
+	{0x3d4001b0, 0x11},
+	{0x3d4001c0, 0x7},
+	{0x3d4001c4, 0x1},
+	{0x3d4000f4, 0x799},
+	{0x3d400108, 0x9141d1c},
+	{0x3d400200, 0x1f},
+	{0x3d400208, 0x0},
+	{0x3d40020c, 0x0},
+	{0x3d400210, 0x1f1f},
+	{0x3d400204, 0x80808},
+	{0x3d400214, 0x7070707},
+	{0x3d400218, 0x7070707},
+	{0x3d40021c, 0xf0f},
+	{0x3d400250, 0x1705},
+	{0x3d400254, 0x2c},
+	{0x3d40025c, 0x4000030},
+	{0x3d400264, 0x900093e7},
+	{0x3d40026c, 0x2005574},
+	{0x3d400400, 0x111},
+	{0x3d400404, 0x72ff},
+	{0x3d400408, 0x72ff},
+	{0x3d400494, 0x2100e07},
+	{0x3d400498, 0x620096},
+	{0x3d40049c, 0x1100e07},
+	{0x3d4004a0, 0xc8012c},
+	{0x3d400028, 0x0},
+};
+
+/* PHY Initialize Configuration */
+struct dram_cfg_param ddr_ddrphy_cfg[] = {
+	{0x100a0, 0x0},
+	{0x100a1, 0x1},
+	{0x100a2, 0x2},
+	{0x100a3, 0x3},
+	{0x100a4, 0x4},
+	{0x100a5, 0x5},
+	{0x100a6, 0x6},
+	{0x100a7, 0x7},
+	{0x110a0, 0x0},
+	{0x110a1, 0x1},
+	{0x110a2, 0x3},
+	{0x110a3, 0x4},
+	{0x110a4, 0x5},
+	{0x110a5, 0x2},
+	{0x110a6, 0x7},
+	{0x110a7, 0x6},
+	{0x120a0, 0x0},
+	{0x120a1, 0x1},
+	{0x120a2, 0x3},
+	{0x120a3, 0x2},
+	{0x120a4, 0x5},
+	{0x120a5, 0x4},
+	{0x120a6, 0x7},
+	{0x120a7, 0x6},
+	{0x130a0, 0x0},
+	{0x130a1, 0x1},
+	{0x130a2, 0x2},
+	{0x130a3, 0x3},
+	{0x130a4, 0x4},
+	{0x130a5, 0x5},
+	{0x130a6, 0x6},
+	{0x130a7, 0x7},
+	{0x1005f, 0x1ff},
+	{0x1015f, 0x1ff},
+	{0x1105f, 0x1ff},
+	{0x1115f, 0x1ff},
+	{0x1205f, 0x1ff},
+	{0x1215f, 0x1ff},
+	{0x1305f, 0x1ff},
+	{0x1315f, 0x1ff},
+	{0x55, 0x1ff},
+	{0x1055, 0x1ff},
+	{0x2055, 0x1ff},
+	{0x3055, 0x1ff},
+	{0x4055, 0x1ff},
+	{0x5055, 0x1ff},
+	{0x6055, 0x1ff},
+	{0x7055, 0x1ff},
+	{0x8055, 0x1ff},
+	{0x9055, 0x1ff},
+	{0x200c5, 0x18},
+	{0x2002e, 0x2},
+	{0x90204, 0x0},
+	{0x20024, 0x1e3},
+	{0x2003a, 0x2},
+	{0x2007d, 0x212},
+	{0x2007c, 0x61},
+	{0x20056, 0x3},
+	{0x1004d, 0x680},
+	{0x1014d, 0x680},
+	{0x1104d, 0x680},
+	{0x1114d, 0x680},
+	{0x1204d, 0x680},
+	{0x1214d, 0x680},
+	{0x1304d, 0x680},
+	{0x1314d, 0x680},
+	{0x10049, 0x618},
+	{0x10149, 0x618},
+	{0x11049, 0x618},
+	{0x11149, 0x618},
+	{0x12049, 0x618},
+	{0x12149, 0x618},
+	{0x13049, 0x618},
+	{0x13149, 0x618},
+	{0x43, 0x21},
+	{0x1043, 0x21},
+	{0x2043, 0x21},
+	{0x3043, 0x21},
+	{0x4043, 0x21},
+	{0x5043, 0x21},
+	{0x6043, 0x21},
+	{0x7043, 0x21},
+	{0x8043, 0x21},
+	{0x9043, 0x21},
+	{0x20018, 0x3},
+	{0x20075, 0x4},
+	{0x20050, 0x0},
+	{0x20008, 0x3e8},
+	{0x20088, 0x9},
+	{0x200b2, 0xdc},
+	{0x10043, 0x5a1},
+	{0x10143, 0x5a1},
+	{0x11043, 0x5a1},
+	{0x11143, 0x5a1},
+	{0x12043, 0x5a1},
+	{0x12143, 0x5a1},
+	{0x13043, 0x5a1},
+	{0x13143, 0x5a1},
+	{0x200fa, 0x1},
+	{0x20019, 0x1},
+	{0x200f0, 0x0},
+	{0x200f1, 0x0},
+	{0x200f2, 0x4444},
+	{0x200f3, 0x8888},
+	{0x200f4, 0x5555},
+	{0x200f5, 0x0},
+	{0x200f6, 0x0},
+	{0x200f7, 0xf000},
+	{0x20025, 0x0},
+	{0x2002d, 0x1},
+	{0x2002c, 0x0},
+};
+
+/* PHY trained csr */
+struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
+	{0x1005f, 0x0},
+	{0x1015f, 0x0},
+	{0x1105f, 0x0},
+	{0x1115f, 0x0},
+	{0x1205f, 0x0},
+	{0x1215f, 0x0},
+	{0x1305f, 0x0},
+	{0x1315f, 0x0},
+	{0x55, 0x0},
+	{0x1055, 0x0},
+	{0x2055, 0x0},
+	{0x3055, 0x0},
+	{0x4055, 0x0},
+	{0x5055, 0x0},
+	{0x6055, 0x0},
+	{0x7055, 0x0},
+	{0x8055, 0x0},
+	{0x9055, 0x0},
+	{0x200c5, 0x0},
+	{0x2002e, 0x0},
+	{0x90204, 0x0},
+	{0x20024, 0x0},
+	{0x2003a, 0x0},
+	{0x2007d, 0x0},
+	{0x2007c, 0x0},
+	{0x20056, 0x0},
+	{0x1004d, 0x0},
+	{0x1014d, 0x0},
+	{0x1104d, 0x0},
+	{0x1114d, 0x0},
+	{0x1204d, 0x0},
+	{0x1214d, 0x0},
+	{0x1304d, 0x0},
+	{0x1314d, 0x0},
+	{0x10049, 0x0},
+	{0x10149, 0x0},
+	{0x11049, 0x0},
+	{0x11149, 0x0},
+	{0x12049, 0x0},
+	{0x12149, 0x0},
+	{0x13049, 0x0},
+	{0x13149, 0x0},
+	{0x43, 0x0},
+	{0x1043, 0x0},
+	{0x2043, 0x0},
+	{0x3043, 0x0},
+	{0x4043, 0x0},
+	{0x5043, 0x0},
+	{0x6043, 0x0},
+	{0x7043, 0x0},
+	{0x8043, 0x0},
+	{0x9043, 0x0},
+	{0x20018, 0x0},
+	{0x20075, 0x0},
+	{0x20050, 0x0},
+	{0x20008, 0x0},
+	{0x20088, 0x0},
+	{0x200b2, 0x0},
+	{0x10043, 0x0},
+	{0x10143, 0x0},
+	{0x11043, 0x0},
+	{0x11143, 0x0},
+	{0x12043, 0x0},
+	{0x12143, 0x0},
+	{0x13043, 0x0},
+	{0x13143, 0x0},
+	{0x200fa, 0x0},
+	{0x20019, 0x0},
+	{0x200f0, 0x0},
+	{0x200f1, 0x0},
+	{0x200f2, 0x0},
+	{0x200f3, 0x0},
+	{0x200f4, 0x0},
+	{0x200f5, 0x0},
+	{0x200f6, 0x0},
+	{0x200f7, 0x0},
+	{0x20025, 0x0},
+	{0x2002d, 0x0},
+	{0x2002c, 0x0},
+	{0xd0000, 0x0},
+	{0x90000, 0x0},
+	{0x90001, 0x0},
+	{0x90002, 0x0},
+	{0x90003, 0x0},
+	{0x90004, 0x0},
+	{0x90005, 0x0},
+	{0x90029, 0x0},
+	{0x9002a, 0x0},
+	{0x9002b, 0x0},
+	{0x9002c, 0x0},
+	{0x9002d, 0x0},
+	{0x9002e, 0x0},
+	{0x9002f, 0x0},
+	{0x90030, 0x0},
+	{0x90031, 0x0},
+	{0x90032, 0x0},
+	{0x90033, 0x0},
+	{0x90034, 0x0},
+	{0x90035, 0x0},
+	{0x90036, 0x0},
+	{0x90037, 0x0},
+	{0x90038, 0x0},
+	{0x90039, 0x0},
+	{0x9003a, 0x0},
+	{0x9003b, 0x0},
+	{0x9003c, 0x0},
+	{0x9003d, 0x0},
+	{0x9003e, 0x0},
+	{0x9003f, 0x0},
+	{0x90040, 0x0},
+	{0x90041, 0x0},
+	{0x90042, 0x0},
+	{0x90043, 0x0},
+	{0x90044, 0x0},
+	{0x90045, 0x0},
+	{0x90046, 0x0},
+	{0x90047, 0x0},
+	{0x90048, 0x0},
+	{0x90049, 0x0},
+	{0x9004a, 0x0},
+	{0x9004b, 0x0},
+	{0x9004c, 0x0},
+	{0x9004d, 0x0},
+	{0x9004e, 0x0},
+	{0x9004f, 0x0},
+	{0x90050, 0x0},
+	{0x90051, 0x0},
+	{0x90052, 0x0},
+	{0x90053, 0x0},
+	{0x90054, 0x0},
+	{0x90055, 0x0},
+	{0x90056, 0x0},
+	{0x90057, 0x0},
+	{0x90058, 0x0},
+	{0x90059, 0x0},
+	{0x9005a, 0x0},
+	{0x9005b, 0x0},
+	{0x9005c, 0x0},
+	{0x9005d, 0x0},
+	{0x9005e, 0x0},
+	{0x9005f, 0x0},
+	{0x90060, 0x0},
+	{0x90061, 0x0},
+	{0x90062, 0x0},
+	{0x90063, 0x0},
+	{0x90064, 0x0},
+	{0x90065, 0x0},
+	{0x90066, 0x0},
+	{0x90067, 0x0},
+	{0x90068, 0x0},
+	{0x90069, 0x0},
+	{0x9006a, 0x0},
+	{0x9006b, 0x0},
+	{0x9006c, 0x0},
+	{0x9006d, 0x0},
+	{0x9006e, 0x0},
+	{0x9006f, 0x0},
+	{0x90070, 0x0},
+	{0x90071, 0x0},
+	{0x90072, 0x0},
+	{0x90073, 0x0},
+	{0x90074, 0x0},
+	{0x90075, 0x0},
+	{0x90076, 0x0},
+	{0x90077, 0x0},
+	{0x90078, 0x0},
+	{0x90079, 0x0},
+	{0x9007a, 0x0},
+	{0x9007b, 0x0},
+	{0x9007c, 0x0},
+	{0x9007d, 0x0},
+	{0x9007e, 0x0},
+	{0x9007f, 0x0},
+	{0x90080, 0x0},
+	{0x90081, 0x0},
+	{0x90082, 0x0},
+	{0x90083, 0x0},
+	{0x90084, 0x0},
+	{0x90085, 0x0},
+	{0x90086, 0x0},
+	{0x90087, 0x0},
+	{0x90088, 0x0},
+	{0x90089, 0x0},
+	{0x9008a, 0x0},
+	{0x9008b, 0x0},
+	{0x9008c, 0x0},
+	{0x9008d, 0x0},
+	{0x9008e, 0x0},
+	{0x9008f, 0x0},
+	{0x90090, 0x0},
+	{0x90091, 0x0},
+	{0x90092, 0x0},
+	{0x90093, 0x0},
+	{0x90094, 0x0},
+	{0x90095, 0x0},
+	{0x90096, 0x0},
+	{0x90097, 0x0},
+	{0x90098, 0x0},
+	{0x90099, 0x0},
+	{0x9009a, 0x0},
+	{0x9009b, 0x0},
+	{0x9009c, 0x0},
+	{0x9009d, 0x0},
+	{0x9009e, 0x0},
+	{0x9009f, 0x0},
+	{0x900a0, 0x0},
+	{0x900a1, 0x0},
+	{0x900a2, 0x0},
+	{0x900a3, 0x0},
+	{0x40000, 0x0},
+	{0x40020, 0x0},
+	{0x40040, 0x0},
+	{0x40060, 0x0},
+	{0x40001, 0x0},
+	{0x40021, 0x0},
+	{0x40041, 0x0},
+	{0x40061, 0x0},
+	{0x40002, 0x0},
+	{0x40022, 0x0},
+	{0x40042, 0x0},
+	{0x40062, 0x0},
+	{0x40003, 0x0},
+	{0x40023, 0x0},
+	{0x40043, 0x0},
+	{0x40063, 0x0},
+	{0x40004, 0x0},
+	{0x40024, 0x0},
+	{0x40044, 0x0},
+	{0x40064, 0x0},
+	{0x40005, 0x0},
+	{0x40025, 0x0},
+	{0x40045, 0x0},
+	{0x40065, 0x0},
+	{0x40006, 0x0},
+	{0x40026, 0x0},
+	{0x40046, 0x0},
+	{0x40066, 0x0},
+	{0x40007, 0x0},
+	{0x40027, 0x0},
+	{0x40047, 0x0},
+	{0x40067, 0x0},
+	{0x40008, 0x0},
+	{0x40028, 0x0},
+	{0x40048, 0x0},
+	{0x40068, 0x0},
+	{0x40009, 0x0},
+	{0x40029, 0x0},
+	{0x40049, 0x0},
+	{0x40069, 0x0},
+	{0x4000a, 0x0},
+	{0x4002a, 0x0},
+	{0x4004a, 0x0},
+	{0x4006a, 0x0},
+	{0x4000b, 0x0},
+	{0x4002b, 0x0},
+	{0x4004b, 0x0},
+	{0x4006b, 0x0},
+	{0x4000c, 0x0},
+	{0x4002c, 0x0},
+	{0x4004c, 0x0},
+	{0x4006c, 0x0},
+	{0x4000d, 0x0},
+	{0x4002d, 0x0},
+	{0x4004d, 0x0},
+	{0x4006d, 0x0},
+	{0x4000e, 0x0},
+	{0x4002e, 0x0},
+	{0x4004e, 0x0},
+	{0x4006e, 0x0},
+	{0x4000f, 0x0},
+	{0x4002f, 0x0},
+	{0x4004f, 0x0},
+	{0x4006f, 0x0},
+	{0x40010, 0x0},
+	{0x40030, 0x0},
+	{0x40050, 0x0},
+	{0x40070, 0x0},
+	{0x40011, 0x0},
+	{0x40031, 0x0},
+	{0x40051, 0x0},
+	{0x40071, 0x0},
+	{0x40012, 0x0},
+	{0x40032, 0x0},
+	{0x40052, 0x0},
+	{0x40072, 0x0},
+	{0x40013, 0x0},
+	{0x40033, 0x0},
+	{0x40053, 0x0},
+	{0x40073, 0x0},
+	{0x40014, 0x0},
+	{0x40034, 0x0},
+	{0x40054, 0x0},
+	{0x40074, 0x0},
+	{0x40015, 0x0},
+	{0x40035, 0x0},
+	{0x40055, 0x0},
+	{0x40075, 0x0},
+	{0x40016, 0x0},
+	{0x40036, 0x0},
+	{0x40056, 0x0},
+	{0x40076, 0x0},
+	{0x40017, 0x0},
+	{0x40037, 0x0},
+	{0x40057, 0x0},
+	{0x40077, 0x0},
+	{0x40018, 0x0},
+	{0x40038, 0x0},
+	{0x40058, 0x0},
+	{0x40078, 0x0},
+	{0x40019, 0x0},
+	{0x40039, 0x0},
+	{0x40059, 0x0},
+	{0x40079, 0x0},
+	{0x4001a, 0x0},
+	{0x4003a, 0x0},
+	{0x4005a, 0x0},
+	{0x4007a, 0x0},
+	{0x900a4, 0x0},
+	{0x900a5, 0x0},
+	{0x900a6, 0x0},
+	{0x900a7, 0x0},
+	{0x900a8, 0x0},
+	{0x900a9, 0x0},
+	{0x900aa, 0x0},
+	{0x900ab, 0x0},
+	{0x900ac, 0x0},
+	{0x900ad, 0x0},
+	{0x900ae, 0x0},
+	{0x900af, 0x0},
+	{0x900b0, 0x0},
+	{0x900b1, 0x0},
+	{0x900b2, 0x0},
+	{0x900b3, 0x0},
+	{0x900b4, 0x0},
+	{0x900b5, 0x0},
+	{0x900b6, 0x0},
+	{0x900b7, 0x0},
+	{0x900b8, 0x0},
+	{0x900b9, 0x0},
+	{0x900ba, 0x0},
+	{0x900bb, 0x0},
+	{0x900bc, 0x0},
+	{0x900bd, 0x0},
+	{0x900be, 0x0},
+	{0x900bf, 0x0},
+	{0x900c0, 0x0},
+	{0x900c1, 0x0},
+	{0x900c2, 0x0},
+	{0x900c3, 0x0},
+	{0x900c4, 0x0},
+	{0x900c5, 0x0},
+	{0x900c6, 0x0},
+	{0x900c7, 0x0},
+	{0x900c8, 0x0},
+	{0x900c9, 0x0},
+	{0x900ca, 0x0},
+	{0x900cb, 0x0},
+	{0x900cc, 0x0},
+	{0x900cd, 0x0},
+	{0x900ce, 0x0},
+	{0x900cf, 0x0},
+	{0x900d0, 0x0},
+	{0x900d1, 0x0},
+	{0x900d2, 0x0},
+	{0x900d3, 0x0},
+	{0x900d4, 0x0},
+	{0x900d5, 0x0},
+	{0x900d6, 0x0},
+	{0x900d7, 0x0},
+	{0x900d8, 0x0},
+	{0x900d9, 0x0},
+	{0x900da, 0x0},
+	{0x900db, 0x0},
+	{0x900dc, 0x0},
+	{0x900dd, 0x0},
+	{0x900de, 0x0},
+	{0x900df, 0x0},
+	{0x900e0, 0x0},
+	{0x900e1, 0x0},
+	{0x900e2, 0x0},
+	{0x900e3, 0x0},
+	{0x900e4, 0x0},
+	{0x900e5, 0x0},
+	{0x900e6, 0x0},
+	{0x900e7, 0x0},
+	{0x900e8, 0x0},
+	{0x900e9, 0x0},
+	{0x900ea, 0x0},
+	{0x900eb, 0x0},
+	{0x900ec, 0x0},
+	{0x900ed, 0x0},
+	{0x900ee, 0x0},
+	{0x900ef, 0x0},
+	{0x900f0, 0x0},
+	{0x900f1, 0x0},
+	{0x900f2, 0x0},
+	{0x900f3, 0x0},
+	{0x900f4, 0x0},
+	{0x900f5, 0x0},
+	{0x900f6, 0x0},
+	{0x900f7, 0x0},
+	{0x900f8, 0x0},
+	{0x900f9, 0x0},
+	{0x900fa, 0x0},
+	{0x900fb, 0x0},
+	{0x900fc, 0x0},
+	{0x900fd, 0x0},
+	{0x900fe, 0x0},
+	{0x900ff, 0x0},
+	{0x90100, 0x0},
+	{0x90101, 0x0},
+	{0x90102, 0x0},
+	{0x90103, 0x0},
+	{0x90104, 0x0},
+	{0x90105, 0x0},
+	{0x90106, 0x0},
+	{0x90107, 0x0},
+	{0x90108, 0x0},
+	{0x90109, 0x0},
+	{0x9010a, 0x0},
+	{0x9010b, 0x0},
+	{0x9010c, 0x0},
+	{0x9010d, 0x0},
+	{0x9010e, 0x0},
+	{0x9010f, 0x0},
+	{0x90110, 0x0},
+	{0x90111, 0x0},
+	{0x90112, 0x0},
+	{0x90113, 0x0},
+	{0x90114, 0x0},
+	{0x90115, 0x0},
+	{0x90116, 0x0},
+	{0x90117, 0x0},
+	{0x90118, 0x0},
+	{0x90119, 0x0},
+	{0x9011a, 0x0},
+	{0x9011b, 0x0},
+	{0x9011c, 0x0},
+	{0x9011d, 0x0},
+	{0x9011e, 0x0},
+	{0x9011f, 0x0},
+	{0x90120, 0x0},
+	{0x90121, 0x0},
+	{0x90122, 0x0},
+	{0x90123, 0x0},
+	{0x90124, 0x0},
+	{0x90125, 0x0},
+	{0x90126, 0x0},
+	{0x90127, 0x0},
+	{0x90128, 0x0},
+	{0x90129, 0x0},
+	{0x9012a, 0x0},
+	{0x9012b, 0x0},
+	{0x9012c, 0x0},
+	{0x9012d, 0x0},
+	{0x9012e, 0x0},
+	{0x9012f, 0x0},
+	{0x90130, 0x0},
+	{0x90131, 0x0},
+	{0x90132, 0x0},
+	{0x90133, 0x0},
+	{0x90134, 0x0},
+	{0x90135, 0x0},
+	{0x90136, 0x0},
+	{0x90137, 0x0},
+	{0x90138, 0x0},
+	{0x90139, 0x0},
+	{0x9013a, 0x0},
+	{0x9013b, 0x0},
+	{0x9013c, 0x0},
+	{0x9013d, 0x0},
+	{0x9013e, 0x0},
+	{0x9013f, 0x0},
+	{0x90140, 0x0},
+	{0x90141, 0x0},
+	{0x90142, 0x0},
+	{0x90143, 0x0},
+	{0x90144, 0x0},
+	{0x90145, 0x0},
+	{0x90146, 0x0},
+	{0x90147, 0x0},
+	{0x90148, 0x0},
+	{0x90149, 0x0},
+	{0x9014a, 0x0},
+	{0x9014b, 0x0},
+	{0x9014c, 0x0},
+	{0x9014d, 0x0},
+	{0x9014e, 0x0},
+	{0x9014f, 0x0},
+	{0x90150, 0x0},
+	{0x90151, 0x0},
+	{0x90152, 0x0},
+	{0x90153, 0x0},
+	{0x90154, 0x0},
+	{0x90155, 0x0},
+	{0x90156, 0x0},
+	{0x90157, 0x0},
+	{0x90158, 0x0},
+	{0x90159, 0x0},
+	{0x9015a, 0x0},
+	{0x9015b, 0x0},
+	{0x9015c, 0x0},
+	{0x9015d, 0x0},
+	{0x9015e, 0x0},
+	{0x9015f, 0x0},
+	{0x90160, 0x0},
+	{0x90161, 0x0},
+	{0x90162, 0x0},
+	{0x90163, 0x0},
+	{0x90164, 0x0},
+	{0x90165, 0x0},
+	{0x90166, 0x0},
+	{0x90167, 0x0},
+	{0x90168, 0x0},
+	{0x90169, 0x0},
+	{0x9016a, 0x0},
+	{0x9016b, 0x0},
+	{0x9016c, 0x0},
+	{0x9016d, 0x0},
+	{0x9016e, 0x0},
+	{0x9016f, 0x0},
+	{0x90170, 0x0},
+	{0x90171, 0x0},
+	{0x90172, 0x0},
+	{0x90173, 0x0},
+	{0x90174, 0x0},
+	{0x90175, 0x0},
+	{0x90176, 0x0},
+	{0x90177, 0x0},
+	{0x90178, 0x0},
+	{0x90179, 0x0},
+	{0x9017a, 0x0},
+	{0x9017b, 0x0},
+	{0x9017c, 0x0},
+	{0x9017d, 0x0},
+	{0x9017e, 0x0},
+	{0x9017f, 0x0},
+	{0x90180, 0x0},
+	{0x90181, 0x0},
+	{0x90006, 0x0},
+	{0x90007, 0x0},
+	{0x90008, 0x0},
+	{0x90009, 0x0},
+	{0x9000a, 0x0},
+	{0x9000b, 0x0},
+	{0xd00e7, 0x0},
+	{0x90017, 0x0},
+	{0x9001f, 0x0},
+	{0x90026, 0x0},
+	{0x400d0, 0x0},
+	{0x400d1, 0x0},
+	{0x400d2, 0x0},
+	{0x400d3, 0x0},
+	{0x400d4, 0x0},
+	{0x400d5, 0x0},
+	{0x400d6, 0x0},
+	{0x400d7, 0x0},
+	{0x200be, 0x0},
+	{0x2000b, 0x0},
+	{0x2000c, 0x0},
+	{0x2000d, 0x0},
+	{0x2000e, 0x0},
+	{0x9000c, 0x0},
+	{0x9000d, 0x0},
+	{0x9000e, 0x0},
+	{0x9000f, 0x0},
+	{0x90010, 0x0},
+	{0x90011, 0x0},
+	{0x90012, 0x0},
+	{0x90013, 0x0},
+	{0x20010, 0x0},
+	{0x20011, 0x0},
+	{0x40080, 0x0},
+	{0x40081, 0x0},
+	{0x40082, 0x0},
+	{0x40083, 0x0},
+	{0x40084, 0x0},
+	{0x40085, 0x0},
+	{0x400fd, 0x0},
+	{0x10011, 0x0},
+	{0x10012, 0x0},
+	{0x10013, 0x0},
+	{0x10018, 0x0},
+	{0x10002, 0x0},
+	{0x100b2, 0x0},
+	{0x101b4, 0x0},
+	{0x102b4, 0x0},
+	{0x103b4, 0x0},
+	{0x104b4, 0x0},
+	{0x105b4, 0x0},
+	{0x106b4, 0x0},
+	{0x107b4, 0x0},
+	{0x108b4, 0x0},
+	{0x11011, 0x0},
+	{0x11012, 0x0},
+	{0x11013, 0x0},
+	{0x11018, 0x0},
+	{0x11002, 0x0},
+	{0x110b2, 0x0},
+	{0x111b4, 0x0},
+	{0x112b4, 0x0},
+	{0x113b4, 0x0},
+	{0x114b4, 0x0},
+	{0x115b4, 0x0},
+	{0x116b4, 0x0},
+	{0x117b4, 0x0},
+	{0x118b4, 0x0},
+	{0x12011, 0x0},
+	{0x12012, 0x0},
+	{0x12013, 0x0},
+	{0x12018, 0x0},
+	{0x12002, 0x0},
+	{0x120b2, 0x0},
+	{0x121b4, 0x0},
+	{0x122b4, 0x0},
+	{0x123b4, 0x0},
+	{0x124b4, 0x0},
+	{0x125b4, 0x0},
+	{0x126b4, 0x0},
+	{0x127b4, 0x0},
+	{0x128b4, 0x0},
+	{0x13011, 0x0},
+	{0x13012, 0x0},
+	{0x13013, 0x0},
+	{0x13018, 0x0},
+	{0x13002, 0x0},
+	{0x130b2, 0x0},
+	{0x131b4, 0x0},
+	{0x132b4, 0x0},
+	{0x133b4, 0x0},
+	{0x134b4, 0x0},
+	{0x135b4, 0x0},
+	{0x136b4, 0x0},
+	{0x137b4, 0x0},
+	{0x138b4, 0x0},
+	{0x20089, 0x0},
+	{0xc0080, 0x0},
+	{0x200cb, 0x0},
+	{0x10068, 0x0},
+	{0x10069, 0x0},
+	{0x10168, 0x0},
+	{0x10169, 0x0},
+	{0x10268, 0x0},
+	{0x10269, 0x0},
+	{0x10368, 0x0},
+	{0x10369, 0x0},
+	{0x10468, 0x0},
+	{0x10469, 0x0},
+	{0x10568, 0x0},
+	{0x10569, 0x0},
+	{0x10668, 0x0},
+	{0x10669, 0x0},
+	{0x10768, 0x0},
+	{0x10769, 0x0},
+	{0x10868, 0x0},
+	{0x10869, 0x0},
+	{0x100aa, 0x0},
+	{0x10062, 0x0},
+	{0x10001, 0x0},
+	{0x100a0, 0x0},
+	{0x100a1, 0x0},
+	{0x100a2, 0x0},
+	{0x100a3, 0x0},
+	{0x100a4, 0x0},
+	{0x100a5, 0x0},
+	{0x100a6, 0x0},
+	{0x100a7, 0x0},
+	{0x11068, 0x0},
+	{0x11069, 0x0},
+	{0x11168, 0x0},
+	{0x11169, 0x0},
+	{0x11268, 0x0},
+	{0x11269, 0x0},
+	{0x11368, 0x0},
+	{0x11369, 0x0},
+	{0x11468, 0x0},
+	{0x11469, 0x0},
+	{0x11568, 0x0},
+	{0x11569, 0x0},
+	{0x11668, 0x0},
+	{0x11669, 0x0},
+	{0x11768, 0x0},
+	{0x11769, 0x0},
+	{0x11868, 0x0},
+	{0x11869, 0x0},
+	{0x110aa, 0x0},
+	{0x11062, 0x0},
+	{0x11001, 0x0},
+	{0x110a0, 0x0},
+	{0x110a1, 0x0},
+	{0x110a2, 0x0},
+	{0x110a3, 0x0},
+	{0x110a4, 0x0},
+	{0x110a5, 0x0},
+	{0x110a6, 0x0},
+	{0x110a7, 0x0},
+	{0x12068, 0x0},
+	{0x12069, 0x0},
+	{0x12168, 0x0},
+	{0x12169, 0x0},
+	{0x12268, 0x0},
+	{0x12269, 0x0},
+	{0x12368, 0x0},
+	{0x12369, 0x0},
+	{0x12468, 0x0},
+	{0x12469, 0x0},
+	{0x12568, 0x0},
+	{0x12569, 0x0},
+	{0x12668, 0x0},
+	{0x12669, 0x0},
+	{0x12768, 0x0},
+	{0x12769, 0x0},
+	{0x12868, 0x0},
+	{0x12869, 0x0},
+	{0x120aa, 0x0},
+	{0x12062, 0x0},
+	{0x12001, 0x0},
+	{0x120a0, 0x0},
+	{0x120a1, 0x0},
+	{0x120a2, 0x0},
+	{0x120a3, 0x0},
+	{0x120a4, 0x0},
+	{0x120a5, 0x0},
+	{0x120a6, 0x0},
+	{0x120a7, 0x0},
+	{0x13068, 0x0},
+	{0x13069, 0x0},
+	{0x13168, 0x0},
+	{0x13169, 0x0},
+	{0x13268, 0x0},
+	{0x13269, 0x0},
+	{0x13368, 0x0},
+	{0x13369, 0x0},
+	{0x13468, 0x0},
+	{0x13469, 0x0},
+	{0x13568, 0x0},
+	{0x13569, 0x0},
+	{0x13668, 0x0},
+	{0x13669, 0x0},
+	{0x13768, 0x0},
+	{0x13769, 0x0},
+	{0x13868, 0x0},
+	{0x13869, 0x0},
+	{0x130aa, 0x0},
+	{0x13062, 0x0},
+	{0x13001, 0x0},
+	{0x130a0, 0x0},
+	{0x130a1, 0x0},
+	{0x130a2, 0x0},
+	{0x130a3, 0x0},
+	{0x130a4, 0x0},
+	{0x130a5, 0x0},
+	{0x130a6, 0x0},
+	{0x130a7, 0x0},
+	{0x80, 0x0},
+	{0x1080, 0x0},
+	{0x2080, 0x0},
+	{0x3080, 0x0},
+	{0x4080, 0x0},
+	{0x5080, 0x0},
+	{0x6080, 0x0},
+	{0x7080, 0x0},
+	{0x8080, 0x0},
+	{0x9080, 0x0},
+	{0x10020, 0x0},
+	{0x10080, 0x0},
+	{0x10081, 0x0},
+	{0x100d0, 0x0},
+	{0x100d1, 0x0},
+	{0x1008c, 0x0},
+	{0x1008d, 0x0},
+	{0x10180, 0x0},
+	{0x10181, 0x0},
+	{0x101d0, 0x0},
+	{0x101d1, 0x0},
+	{0x1018c, 0x0},
+	{0x1018d, 0x0},
+	{0x100c0, 0x0},
+	{0x100c1, 0x0},
+	{0x101c0, 0x0},
+	{0x101c1, 0x0},
+	{0x102c0, 0x0},
+	{0x102c1, 0x0},
+	{0x103c0, 0x0},
+	{0x103c1, 0x0},
+	{0x104c0, 0x0},
+	{0x104c1, 0x0},
+	{0x105c0, 0x0},
+	{0x105c1, 0x0},
+	{0x106c0, 0x0},
+	{0x106c1, 0x0},
+	{0x107c0, 0x0},
+	{0x107c1, 0x0},
+	{0x108c0, 0x0},
+	{0x108c1, 0x0},
+	{0x100ae, 0x0},
+	{0x100af, 0x0},
+	{0x11020, 0x0},
+	{0x11080, 0x0},
+	{0x11081, 0x0},
+	{0x110d0, 0x0},
+	{0x110d1, 0x0},
+	{0x1108c, 0x0},
+	{0x1108d, 0x0},
+	{0x11180, 0x0},
+	{0x11181, 0x0},
+	{0x111d0, 0x0},
+	{0x111d1, 0x0},
+	{0x1118c, 0x0},
+	{0x1118d, 0x0},
+	{0x110c0, 0x0},
+	{0x110c1, 0x0},
+	{0x111c0, 0x0},
+	{0x111c1, 0x0},
+	{0x112c0, 0x0},
+	{0x112c1, 0x0},
+	{0x113c0, 0x0},
+	{0x113c1, 0x0},
+	{0x114c0, 0x0},
+	{0x114c1, 0x0},
+	{0x115c0, 0x0},
+	{0x115c1, 0x0},
+	{0x116c0, 0x0},
+	{0x116c1, 0x0},
+	{0x117c0, 0x0},
+	{0x117c1, 0x0},
+	{0x118c0, 0x0},
+	{0x118c1, 0x0},
+	{0x110ae, 0x0},
+	{0x110af, 0x0},
+	{0x12020, 0x0},
+	{0x12080, 0x0},
+	{0x12081, 0x0},
+	{0x120d0, 0x0},
+	{0x120d1, 0x0},
+	{0x1208c, 0x0},
+	{0x1208d, 0x0},
+	{0x12180, 0x0},
+	{0x12181, 0x0},
+	{0x121d0, 0x0},
+	{0x121d1, 0x0},
+	{0x1218c, 0x0},
+	{0x1218d, 0x0},
+	{0x120c0, 0x0},
+	{0x120c1, 0x0},
+	{0x121c0, 0x0},
+	{0x121c1, 0x0},
+	{0x122c0, 0x0},
+	{0x122c1, 0x0},
+	{0x123c0, 0x0},
+	{0x123c1, 0x0},
+	{0x124c0, 0x0},
+	{0x124c1, 0x0},
+	{0x125c0, 0x0},
+	{0x125c1, 0x0},
+	{0x126c0, 0x0},
+	{0x126c1, 0x0},
+	{0x127c0, 0x0},
+	{0x127c1, 0x0},
+	{0x128c0, 0x0},
+	{0x128c1, 0x0},
+	{0x120ae, 0x0},
+	{0x120af, 0x0},
+	{0x13020, 0x0},
+	{0x13080, 0x0},
+	{0x13081, 0x0},
+	{0x130d0, 0x0},
+	{0x130d1, 0x0},
+	{0x1308c, 0x0},
+	{0x1308d, 0x0},
+	{0x13180, 0x0},
+	{0x13181, 0x0},
+	{0x131d0, 0x0},
+	{0x131d1, 0x0},
+	{0x1318c, 0x0},
+	{0x1318d, 0x0},
+	{0x130c0, 0x0},
+	{0x130c1, 0x0},
+	{0x131c0, 0x0},
+	{0x131c1, 0x0},
+	{0x132c0, 0x0},
+	{0x132c1, 0x0},
+	{0x133c0, 0x0},
+	{0x133c1, 0x0},
+	{0x134c0, 0x0},
+	{0x134c1, 0x0},
+	{0x135c0, 0x0},
+	{0x135c1, 0x0},
+	{0x136c0, 0x0},
+	{0x136c1, 0x0},
+	{0x137c0, 0x0},
+	{0x137c1, 0x0},
+	{0x138c0, 0x0},
+	{0x138c1, 0x0},
+	{0x130ae, 0x0},
+	{0x130af, 0x0},
+	{0x90201, 0x0},
+	{0x90202, 0x0},
+	{0x90203, 0x0},
+	{0x90205, 0x0},
+	{0x90206, 0x0},
+	{0x90207, 0x0},
+	{0x90208, 0x0},
+	{0x20020, 0x0},
+	{0x20077, 0x0},
+	{0x20072, 0x0},
+	{0x20073, 0x0},
+	{0x400c0, 0x0},
+	{0x10040, 0x0},
+	{0x10140, 0x0},
+	{0x10240, 0x0},
+	{0x10340, 0x0},
+	{0x10440, 0x0},
+	{0x10540, 0x0},
+	{0x10640, 0x0},
+	{0x10740, 0x0},
+	{0x10840, 0x0},
+	{0x11040, 0x0},
+	{0x11140, 0x0},
+	{0x11240, 0x0},
+	{0x11340, 0x0},
+	{0x11440, 0x0},
+	{0x11540, 0x0},
+	{0x11640, 0x0},
+	{0x11740, 0x0},
+	{0x11840, 0x0},
+	{0x12040, 0x0},
+	{0x12140, 0x0},
+	{0x12240, 0x0},
+	{0x12340, 0x0},
+	{0x12440, 0x0},
+	{0x12540, 0x0},
+	{0x12640, 0x0},
+	{0x12740, 0x0},
+	{0x12840, 0x0},
+	{0x13040, 0x0},
+	{0x13140, 0x0},
+	{0x13240, 0x0},
+	{0x13340, 0x0},
+	{0x13440, 0x0},
+	{0x13540, 0x0},
+	{0x13640, 0x0},
+	{0x13740, 0x0},
+	{0x13840, 0x0},
+};
+
+/* P0 message block parameter for training firmware */
+struct dram_cfg_param ddr_fsp0_cfg[] = {
+	{0xd0000, 0x0},
+	{0x54003, 0xfa0},
+	{0x54004, 0x2},
+	{0x54005, 0x3c30},
+	{0x54006, 0x11},
+	{0x54008, 0x131f},
+	{0x54009, 0xc8},
+	{0x5400b, 0x2},
+	{0x5400f, 0x100},
+	{0x54012, 0x110},
+	{0x54019, 0x3ff4},
+	{0x5401a, 0xe3},
+	{0x5401b, 0x4855},
+	{0x5401c, 0x4800},
+	{0x5401e, 0x15},
+	{0x5401f, 0x3ff4},
+	{0x54020, 0xe3},
+	{0x54021, 0x4855},
+	{0x54022, 0x4800},
+	{0x54024, 0x15},
+	{0x5402b, 0x1000},
+	{0x5402c, 0x1},
+	{0x54032, 0xf400},
+	{0x54033, 0xe33f},
+	{0x54034, 0x5500},
+	{0x54035, 0x48},
+	{0x54036, 0x48},
+	{0x54037, 0x1500},
+	{0x54038, 0xf400},
+	{0x54039, 0xe33f},
+	{0x5403a, 0x5500},
+	{0x5403b, 0x48},
+	{0x5403c, 0x48},
+	{0x5403d, 0x1500},
+	{0xd0000, 0x1}
+};
+
+/* P0 2D message block parameter for training firmware */
+struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
+	{0xd0000, 0x0},
+	{0x54003, 0xfa0},
+	{0x54004, 0x2},
+	{0x54005, 0x3c30},
+	{0x54006, 0x11},
+	{0x54008, 0x61},
+	{0x54009, 0xc8},
+	{0x5400b, 0x2},
+	{0x5400f, 0x100},
+	{0x54010, 0x1f7f},
+	{0x54012, 0x110},
+	{0x54019, 0x3ff4},
+	{0x5401a, 0xe3},
+	{0x5401b, 0x4855},
+	{0x5401c, 0x4800},
+	{0x5401e, 0x15},
+	{0x5401f, 0x3ff4},
+	{0x54020, 0xe3},
+	{0x54021, 0x4855},
+	{0x54022, 0x4800},
+	{0x54024, 0x15},
+	{0x5402b, 0x1000},
+	{0x5402c, 0x1},
+	{0x54032, 0xf400},
+	{0x54033, 0xe33f},
+	{0x54034, 0x5500},
+	{0x54035, 0x48},
+	{0x54036, 0x48},
+	{0x54037, 0x1500},
+	{0x54038, 0xf400},
+	{0x54039, 0xe33f},
+	{0x5403a, 0x5500},
+	{0x5403b, 0x48},
+	{0x5403c, 0x48},
+	{0x5403d, 0x1500},
+	{0xd0000, 0x1}
+};
+
+/* DRAM PHY init engine image */
+struct dram_cfg_param ddr_phy_pie[] = {
+	{0xd0000, 0x0},
+	{0x90000, 0x10},
+	{0x90001, 0x400},
+	{0x90002, 0x10e},
+	{0x90003, 0x0},
+	{0x90004, 0x0},
+	{0x90005, 0x8},
+	{0x90029, 0xb},
+	{0x9002a, 0x480},
+	{0x9002b, 0x109},
+	{0x9002c, 0x8},
+	{0x9002d, 0x448},
+	{0x9002e, 0x139},
+	{0x9002f, 0x8},
+	{0x90030, 0x478},
+	{0x90031, 0x109},
+	{0x90032, 0x0},
+	{0x90033, 0xe8},
+	{0x90034, 0x109},
+	{0x90035, 0x2},
+	{0x90036, 0x10},
+	{0x90037, 0x139},
+	{0x90038, 0xb},
+	{0x90039, 0x7c0},
+	{0x9003a, 0x139},
+	{0x9003b, 0x44},
+	{0x9003c, 0x633},
+	{0x9003d, 0x159},
+	{0x9003e, 0x14f},
+	{0x9003f, 0x630},
+	{0x90040, 0x159},
+	{0x90041, 0x47},
+	{0x90042, 0x633},
+	{0x90043, 0x149},
+	{0x90044, 0x4f},
+	{0x90045, 0x633},
+	{0x90046, 0x179},
+	{0x90047, 0x8},
+	{0x90048, 0xe0},
+	{0x90049, 0x109},
+	{0x9004a, 0x0},
+	{0x9004b, 0x7c8},
+	{0x9004c, 0x109},
+	{0x9004d, 0x0},
+	{0x9004e, 0x1},
+	{0x9004f, 0x8},
+	{0x90050, 0x0},
+	{0x90051, 0x45a},
+	{0x90052, 0x9},
+	{0x90053, 0x0},
+	{0x90054, 0x448},
+	{0x90055, 0x109},
+	{0x90056, 0x40},
+	{0x90057, 0x633},
+	{0x90058, 0x179},
+	{0x90059, 0x1},
+	{0x9005a, 0x618},
+	{0x9005b, 0x109},
+	{0x9005c, 0x40c0},
+	{0x9005d, 0x633},
+	{0x9005e, 0x149},
+	{0x9005f, 0x8},
+	{0x90060, 0x4},
+	{0x90061, 0x48},
+	{0x90062, 0x4040},
+	{0x90063, 0x633},
+	{0x90064, 0x149},
+	{0x90065, 0x0},
+	{0x90066, 0x4},
+	{0x90067, 0x48},
+	{0x90068, 0x40},
+	{0x90069, 0x633},
+	{0x9006a, 0x149},
+	{0x9006b, 0x10},
+	{0x9006c, 0x4},
+	{0x9006d, 0x18},
+	{0x9006e, 0x0},
+	{0x9006f, 0x4},
+	{0x90070, 0x78},
+	{0x90071, 0x549},
+	{0x90072, 0x633},
+	{0x90073, 0x159},
+	{0x90074, 0xd49},
+	{0x90075, 0x633},
+	{0x90076, 0x159},
+	{0x90077, 0x94a},
+	{0x90078, 0x633},
+	{0x90079, 0x159},
+	{0x9007a, 0x441},
+	{0x9007b, 0x633},
+	{0x9007c, 0x149},
+	{0x9007d, 0x42},
+	{0x9007e, 0x633},
+	{0x9007f, 0x149},
+	{0x90080, 0x1},
+	{0x90081, 0x633},
+	{0x90082, 0x149},
+	{0x90083, 0x0},
+	{0x90084, 0xe0},
+	{0x90085, 0x109},
+	{0x90086, 0xa},
+	{0x90087, 0x10},
+	{0x90088, 0x109},
+	{0x90089, 0x9},
+	{0x9008a, 0x3c0},
+	{0x9008b, 0x149},
+	{0x9008c, 0x9},
+	{0x9008d, 0x3c0},
+	{0x9008e, 0x159},
+	{0x9008f, 0x18},
+	{0x90090, 0x10},
+	{0x90091, 0x109},
+	{0x90092, 0x0},
+	{0x90093, 0x3c0},
+	{0x90094, 0x109},
+	{0x90095, 0x18},
+	{0x90096, 0x4},
+	{0x90097, 0x48},
+	{0x90098, 0x18},
+	{0x90099, 0x4},
+	{0x9009a, 0x58},
+	{0x9009b, 0xb},
+	{0x9009c, 0x10},
+	{0x9009d, 0x109},
+	{0x9009e, 0x1},
+	{0x9009f, 0x10},
+	{0x900a0, 0x109},
+	{0x900a1, 0x5},
+	{0x900a2, 0x7c0},
+	{0x900a3, 0x109},
+	{0x40000, 0x811},
+	{0x40020, 0x880},
+	{0x40040, 0x0},
+	{0x40060, 0x0},
+	{0x40001, 0x4008},
+	{0x40021, 0x83},
+	{0x40041, 0x4f},
+	{0x40061, 0x0},
+	{0x40002, 0x4040},
+	{0x40022, 0x83},
+	{0x40042, 0x51},
+	{0x40062, 0x0},
+	{0x40003, 0x811},
+	{0x40023, 0x880},
+	{0x40043, 0x0},
+	{0x40063, 0x0},
+	{0x40004, 0x720},
+	{0x40024, 0xf},
+	{0x40044, 0x1740},
+	{0x40064, 0x0},
+	{0x40005, 0x16},
+	{0x40025, 0x83},
+	{0x40045, 0x4b},
+	{0x40065, 0x0},
+	{0x40006, 0x716},
+	{0x40026, 0xf},
+	{0x40046, 0x2001},
+	{0x40066, 0x0},
+	{0x40007, 0x716},
+	{0x40027, 0xf},
+	{0x40047, 0x2800},
+	{0x40067, 0x0},
+	{0x40008, 0x716},
+	{0x40028, 0xf},
+	{0x40048, 0xf00},
+	{0x40068, 0x0},
+	{0x40009, 0x720},
+	{0x40029, 0xf},
+	{0x40049, 0x1400},
+	{0x40069, 0x0},
+	{0x4000a, 0xe08},
+	{0x4002a, 0xc15},
+	{0x4004a, 0x0},
+	{0x4006a, 0x0},
+	{0x4000b, 0x625},
+	{0x4002b, 0x15},
+	{0x4004b, 0x0},
+	{0x4006b, 0x0},
+	{0x4000c, 0x4028},
+	{0x4002c, 0x80},
+	{0x4004c, 0x0},
+	{0x4006c, 0x0},
+	{0x4000d, 0xe08},
+	{0x4002d, 0xc1a},
+	{0x4004d, 0x0},
+	{0x4006d, 0x0},
+	{0x4000e, 0x625},
+	{0x4002e, 0x1a},
+	{0x4004e, 0x0},
+	{0x4006e, 0x0},
+	{0x4000f, 0x4040},
+	{0x4002f, 0x80},
+	{0x4004f, 0x0},
+	{0x4006f, 0x0},
+	{0x40010, 0x2604},
+	{0x40030, 0x15},
+	{0x40050, 0x0},
+	{0x40070, 0x0},
+	{0x40011, 0x708},
+	{0x40031, 0x5},
+	{0x40051, 0x0},
+	{0x40071, 0x2002},
+	{0x40012, 0x8},
+	{0x40032, 0x80},
+	{0x40052, 0x0},
+	{0x40072, 0x0},
+	{0x40013, 0x2604},
+	{0x40033, 0x1a},
+	{0x40053, 0x0},
+	{0x40073, 0x0},
+	{0x40014, 0x708},
+	{0x40034, 0xa},
+	{0x40054, 0x0},
+	{0x40074, 0x2002},
+	{0x40015, 0x4040},
+	{0x40035, 0x80},
+	{0x40055, 0x0},
+	{0x40075, 0x0},
+	{0x40016, 0x60a},
+	{0x40036, 0x15},
+	{0x40056, 0x1200},
+	{0x40076, 0x0},
+	{0x40017, 0x61a},
+	{0x40037, 0x15},
+	{0x40057, 0x1300},
+	{0x40077, 0x0},
+	{0x40018, 0x60a},
+	{0x40038, 0x1a},
+	{0x40058, 0x1200},
+	{0x40078, 0x0},
+	{0x40019, 0x642},
+	{0x40039, 0x1a},
+	{0x40059, 0x1300},
+	{0x40079, 0x0},
+	{0x4001a, 0x4808},
+	{0x4003a, 0x880},
+	{0x4005a, 0x0},
+	{0x4007a, 0x0},
+	{0x900a4, 0x0},
+	{0x900a5, 0x790},
+	{0x900a6, 0x11a},
+	{0x900a7, 0x8},
+	{0x900a8, 0x7aa},
+	{0x900a9, 0x2a},
+	{0x900aa, 0x10},
+	{0x900ab, 0x7b2},
+	{0x900ac, 0x2a},
+	{0x900ad, 0x0},
+	{0x900ae, 0x7c8},
+	{0x900af, 0x109},
+	{0x900b0, 0x10},
+	{0x900b1, 0x10},
+	{0x900b2, 0x109},
+	{0x900b3, 0x10},
+	{0x900b4, 0x2a8},
+	{0x900b5, 0x129},
+	{0x900b6, 0x8},
+	{0x900b7, 0x370},
+	{0x900b8, 0x129},
+	{0x900b9, 0xa},
+	{0x900ba, 0x3c8},
+	{0x900bb, 0x1a9},
+	{0x900bc, 0xc},
+	{0x900bd, 0x408},
+	{0x900be, 0x199},
+	{0x900bf, 0x14},
+	{0x900c0, 0x790},
+	{0x900c1, 0x11a},
+	{0x900c2, 0x8},
+	{0x900c3, 0x4},
+	{0x900c4, 0x18},
+	{0x900c5, 0xe},
+	{0x900c6, 0x408},
+	{0x900c7, 0x199},
+	{0x900c8, 0x8},
+	{0x900c9, 0x8568},
+	{0x900ca, 0x108},
+	{0x900cb, 0x18},
+	{0x900cc, 0x790},
+	{0x900cd, 0x16a},
+	{0x900ce, 0x8},
+	{0x900cf, 0x1d8},
+	{0x900d0, 0x169},
+	{0x900d1, 0x10},
+	{0x900d2, 0x8558},
+	{0x900d3, 0x168},
+	{0x900d4, 0x70},
+	{0x900d5, 0x788},
+	{0x900d6, 0x16a},
+	{0x900d7, 0x1ff8},
+	{0x900d8, 0x85a8},
+	{0x900d9, 0x1e8},
+	{0x900da, 0x50},
+	{0x900db, 0x798},
+	{0x900dc, 0x16a},
+	{0x900dd, 0x60},
+	{0x900de, 0x7a0},
+	{0x900df, 0x16a},
+	{0x900e0, 0x8},
+	{0x900e1, 0x8310},
+	{0x900e2, 0x168},
+	{0x900e3, 0x8},
+	{0x900e4, 0xa310},
+	{0x900e5, 0x168},
+	{0x900e6, 0xa},
+	{0x900e7, 0x408},
+	{0x900e8, 0x169},
+	{0x900e9, 0x6e},
+	{0x900ea, 0x0},
+	{0x900eb, 0x68},
+	{0x900ec, 0x0},
+	{0x900ed, 0x408},
+	{0x900ee, 0x169},
+	{0x900ef, 0x0},
+	{0x900f0, 0x8310},
+	{0x900f1, 0x168},
+	{0x900f2, 0x0},
+	{0x900f3, 0xa310},
+	{0x900f4, 0x168},
+	{0x900f5, 0x1ff8},
+	{0x900f6, 0x85a8},
+	{0x900f7, 0x1e8},
+	{0x900f8, 0x68},
+	{0x900f9, 0x798},
+	{0x900fa, 0x16a},
+	{0x900fb, 0x78},
+	{0x900fc, 0x7a0},
+	{0x900fd, 0x16a},
+	{0x900fe, 0x68},
+	{0x900ff, 0x790},
+	{0x90100, 0x16a},
+	{0x90101, 0x8},
+	{0x90102, 0x8b10},
+	{0x90103, 0x168},
+	{0x90104, 0x8},
+	{0x90105, 0xab10},
+	{0x90106, 0x168},
+	{0x90107, 0xa},
+	{0x90108, 0x408},
+	{0x90109, 0x169},
+	{0x9010a, 0x58},
+	{0x9010b, 0x0},
+	{0x9010c, 0x68},
+	{0x9010d, 0x0},
+	{0x9010e, 0x408},
+	{0x9010f, 0x169},
+	{0x90110, 0x0},
+	{0x90111, 0x8b10},
+	{0x90112, 0x168},
+	{0x90113, 0x1},
+	{0x90114, 0xab10},
+	{0x90115, 0x168},
+	{0x90116, 0x0},
+	{0x90117, 0x1d8},
+	{0x90118, 0x169},
+	{0x90119, 0x80},
+	{0x9011a, 0x790},
+	{0x9011b, 0x16a},
+	{0x9011c, 0x18},
+	{0x9011d, 0x7aa},
+	{0x9011e, 0x6a},
+	{0x9011f, 0xa},
+	{0x90120, 0x0},
+	{0x90121, 0x1e9},
+	{0x90122, 0x8},
+	{0x90123, 0x8080},
+	{0x90124, 0x108},
+	{0x90125, 0xf},
+	{0x90126, 0x408},
+	{0x90127, 0x169},
+	{0x90128, 0xc},
+	{0x90129, 0x0},
+	{0x9012a, 0x68},
+	{0x9012b, 0x9},
+	{0x9012c, 0x0},
+	{0x9012d, 0x1a9},
+	{0x9012e, 0x0},
+	{0x9012f, 0x408},
+	{0x90130, 0x169},
+	{0x90131, 0x0},
+	{0x90132, 0x8080},
+	{0x90133, 0x108},
+	{0x90134, 0x8},
+	{0x90135, 0x7aa},
+	{0x90136, 0x6a},
+	{0x90137, 0x0},
+	{0x90138, 0x8568},
+	{0x90139, 0x108},
+	{0x9013a, 0xb7},
+	{0x9013b, 0x790},
+	{0x9013c, 0x16a},
+	{0x9013d, 0x1f},
+	{0x9013e, 0x0},
+	{0x9013f, 0x68},
+	{0x90140, 0x8},
+	{0x90141, 0x8558},
+	{0x90142, 0x168},
+	{0x90143, 0xf},
+	{0x90144, 0x408},
+	{0x90145, 0x169},
+	{0x90146, 0xd},
+	{0x90147, 0x0},
+	{0x90148, 0x68},
+	{0x90149, 0x0},
+	{0x9014a, 0x408},
+	{0x9014b, 0x169},
+	{0x9014c, 0x0},
+	{0x9014d, 0x8558},
+	{0x9014e, 0x168},
+	{0x9014f, 0x8},
+	{0x90150, 0x3c8},
+	{0x90151, 0x1a9},
+	{0x90152, 0x3},
+	{0x90153, 0x370},
+	{0x90154, 0x129},
+	{0x90155, 0x20},
+	{0x90156, 0x2aa},
+	{0x90157, 0x9},
+	{0x90158, 0x8},
+	{0x90159, 0xe8},
+	{0x9015a, 0x109},
+	{0x9015b, 0x0},
+	{0x9015c, 0x8140},
+	{0x9015d, 0x10c},
+	{0x9015e, 0x10},
+	{0x9015f, 0x8138},
+	{0x90160, 0x104},
+	{0x90161, 0x8},
+	{0x90162, 0x448},
+	{0x90163, 0x109},
+	{0x90164, 0xf},
+	{0x90165, 0x7c0},
+	{0x90166, 0x109},
+	{0x90167, 0x0},
+	{0x90168, 0xe8},
+	{0x90169, 0x109},
+	{0x9016a, 0x47},
+	{0x9016b, 0x630},
+	{0x9016c, 0x109},
+	{0x9016d, 0x8},
+	{0x9016e, 0x618},
+	{0x9016f, 0x109},
+	{0x90170, 0x8},
+	{0x90171, 0xe0},
+	{0x90172, 0x109},
+	{0x90173, 0x0},
+	{0x90174, 0x7c8},
+	{0x90175, 0x109},
+	{0x90176, 0x8},
+	{0x90177, 0x8140},
+	{0x90178, 0x10c},
+	{0x90179, 0x0},
+	{0x9017a, 0x478},
+	{0x9017b, 0x109},
+	{0x9017c, 0x0},
+	{0x9017d, 0x1},
+	{0x9017e, 0x8},
+	{0x9017f, 0x8},
+	{0x90180, 0x4},
+	{0x90181, 0x0},
+	{0x90006, 0x8},
+	{0x90007, 0x7c8},
+	{0x90008, 0x109},
+	{0x90009, 0x0},
+	{0x9000a, 0x400},
+	{0x9000b, 0x106},
+	{0xd00e7, 0x400},
+	{0x90017, 0x0},
+	{0x9001f, 0x29},
+	{0x90026, 0x68},
+	{0x400d0, 0x0},
+	{0x400d1, 0x101},
+	{0x400d2, 0x105},
+	{0x400d3, 0x107},
+	{0x400d4, 0x10f},
+	{0x400d5, 0x202},
+	{0x400d6, 0x20a},
+	{0x400d7, 0x20b},
+	{0x2003a, 0x2},
+	{0x200be, 0x3},
+	{0x2000b, 0x7d},
+	{0x2000c, 0xfa},
+	{0x2000d, 0x9c4},
+	{0x2000e, 0x2c},
+	{0x9000c, 0x0},
+	{0x9000d, 0x173},
+	{0x9000e, 0x60},
+	{0x9000f, 0x6110},
+	{0x90010, 0x2152},
+	{0x90011, 0xdfbd},
+	{0x90012, 0x2060},
+	{0x90013, 0x6152},
+	{0x20010, 0x5a},
+	{0x20011, 0x3},
+	{0x40080, 0xe0},
+	{0x40081, 0x12},
+	{0x40082, 0xe0},
+	{0x40083, 0x12},
+	{0x40084, 0xe0},
+	{0x40085, 0x12},
+	{0x400fd, 0xf},
+	{0x10011, 0x1},
+	{0x10012, 0x1},
+	{0x10013, 0x180},
+	{0x10018, 0x1},
+	{0x10002, 0x6209},
+	{0x100b2, 0x1},
+	{0x101b4, 0x1},
+	{0x102b4, 0x1},
+	{0x103b4, 0x1},
+	{0x104b4, 0x1},
+	{0x105b4, 0x1},
+	{0x106b4, 0x1},
+	{0x107b4, 0x1},
+	{0x108b4, 0x1},
+	{0x11011, 0x1},
+	{0x11012, 0x1},
+	{0x11013, 0x180},
+	{0x11018, 0x1},
+	{0x11002, 0x6209},
+	{0x110b2, 0x1},
+	{0x111b4, 0x1},
+	{0x112b4, 0x1},
+	{0x113b4, 0x1},
+	{0x114b4, 0x1},
+	{0x115b4, 0x1},
+	{0x116b4, 0x1},
+	{0x117b4, 0x1},
+	{0x118b4, 0x1},
+	{0x12011, 0x1},
+	{0x12012, 0x1},
+	{0x12013, 0x180},
+	{0x12018, 0x1},
+	{0x12002, 0x6209},
+	{0x120b2, 0x1},
+	{0x121b4, 0x1},
+	{0x122b4, 0x1},
+	{0x123b4, 0x1},
+	{0x124b4, 0x1},
+	{0x125b4, 0x1},
+	{0x126b4, 0x1},
+	{0x127b4, 0x1},
+	{0x128b4, 0x1},
+	{0x13011, 0x1},
+	{0x13012, 0x1},
+	{0x13013, 0x180},
+	{0x13018, 0x1},
+	{0x13002, 0x6209},
+	{0x130b2, 0x1},
+	{0x131b4, 0x1},
+	{0x132b4, 0x1},
+	{0x133b4, 0x1},
+	{0x134b4, 0x1},
+	{0x135b4, 0x1},
+	{0x136b4, 0x1},
+	{0x137b4, 0x1},
+	{0x138b4, 0x1},
+	{0x20089, 0x1},
+	{0x20088, 0x19},
+	{0xc0080, 0x2},
+	{0xd0000, 0x1},
+};
+
+struct dram_fsp_msg ddr_dram_fsp_msg[] = {
+	{
+		/* P0 4000mts 1D */
+		.drate = 4000,
+		.fw_type = FW_1D_IMAGE,
+		.fsp_cfg = ddr_fsp0_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
+	},
+	{
+		/* P0 4000mts 2D */
+		.drate = 4000,
+		.fw_type = FW_2D_IMAGE,
+		.fsp_cfg = ddr_fsp0_2d_cfg,
+		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
+	},
+};
+
+/* ddr timing config params */
+struct dram_timing_info dram_timing = {
+	.ddrc_cfg = ddr_ddrc_cfg,
+	.ddrc_cfg_num = ARRAY_SIZE(ddr_ddrc_cfg),
+	.ddrphy_cfg = ddr_ddrphy_cfg,
+	.ddrphy_cfg_num = ARRAY_SIZE(ddr_ddrphy_cfg),
+	.fsp_msg = ddr_dram_fsp_msg,
+	.fsp_msg_num = ARRAY_SIZE(ddr_dram_fsp_msg),
+	.ddrphy_trained_csr = ddr_ddrphy_trained_csr,
+	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
+	.ddrphy_pie = ddr_phy_pie,
+	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
+	.fsp_table = { 4000, },
+};
+
+void set_dram_timings_4gb(void)
+{
+	dram_timing.ddrc_cfg[2].val = 0xa3080020;
+	dram_timing.ddrc_cfg[39].val = 0x17;
+	dram_timing.fsp_msg[0].fsp_cfg[9].val = 0x310;
+	dram_timing.fsp_msg[0].fsp_cfg[21].val = 0x3;
+	dram_timing.fsp_msg[1].fsp_cfg[10].val = 0x310;
+	dram_timing.fsp_msg[1].fsp_cfg[22].val = 0x3;
+}
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/lpddr4_timing.h b/board/phytec/imx8mp-phyflex-libra-rdk/lpddr4_timing.h
new file mode 100644
index 000000000000..fffff592f63f
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/lpddr4_timing.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+#ifndef __LPDDR4_TIMING_H__
+#define __LPDDR4_TIMING_H__
+
+void set_dram_timings_4gb(void);
+
+#endif /* __LPDDR4_TIMING_H__ */
diff --git a/board/phytec/imx8mp-phyflex-libra-rdk/spl.c b/board/phytec/imx8mp-phyflex-libra-rdk/spl.c
new file mode 100644
index 000000000000..6de386a3bb2a
--- /dev/null
+++ b/board/phytec/imx8mp-phyflex-libra-rdk/spl.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+#include <config.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/ddr.h>
+#include <asm/arch/imx8mp_pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/global_data.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/gpio.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <hang.h>
+#include <init.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <power/pca9450.h>
+#include <spl.h>
+
+#include "../common/imx8m_som_detection.h"
+#include "lpddr4_timing.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define EEPROM_ADDR		0x51
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	return BOOT_DEVICE_BOOTROM;
+}
+
+void spl_dram_init(void)
+{
+	enum phytec_phyflex_imx8mp_ddr_code size = PHYTEC_EEPROM_INVAL;
+	int ret;
+
+	/*
+	 * Pass 0 as bus number. SPL does not make use of the aliases in device
+	 * tree. Will be i2c1 (FPSC standard) in later boot stages.
+	 */
+	ret = phytec_eeprom_data_setup(NULL, 0, EEPROM_ADDR);
+	if (!ret) {
+		ret = phytec_imx8m_detect(NULL);
+		if (!ret)
+			phytec_print_som_info(NULL);
+
+		size = phytec_get_imx8m_ddr_size(NULL);
+	}
+
+	/* Overwrite size with static configuration */
+	if (IS_ENABLED(CONFIG_PHYFLEX_IMX8MP_RAM_STATIC_SIZE)) {
+		if (IS_ENABLED(CONFIG_PHYFLEX_IMX8MP_RAM_SIZE_2GB))
+			size = PHYTEC_PHYFLEX_IMX8MP_DDR_2GB;
+		else if (IS_ENABLED(CONFIG_PHYFLEX_IMX8MP_RAM_SIZE_4GB))
+			size = PHYTEC_PHYFLEX_IMX8MP_DDR_4GB;
+	}
+
+	switch (size) {
+	case PHYTEC_PHYFLEX_IMX8MP_DDR_2GB:
+		break;
+	case PHYTEC_PHYFLEX_IMX8MP_DDR_4GB:
+		set_dram_timings_4gb();
+		break;
+	default:
+		goto out;
+	}
+	ddr_init(&dram_timing);
+	return;
+out:
+	printf("Could not detect correct RAM size. Fallback to default.\n");
+	ddr_init(&dram_timing);
+}
+
+int power_init_board(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
+
+	/* BUCKxOUT_DVS0/1 control BUCK123 output */
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
+
+	/* Increase VDD_SOC and VDD_ARM to OD voltage 0.95V */
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
+
+	/* Set BUCK1 DVS1 to suspend controlled through PMIC_STBY_REQ */
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
+
+	/* Set WDOG_B_CFG to cold reset */
+	pmic_reg_write(dev, PCA9450_RESET_CTRL, 0xA1);
+
+	return 0;
+}
+
+void spl_board_init(void)
+{
+	arch_misc_init();
+
+	/* Set GIC clock to 500Mhz for OD VDD_SOC. */
+	clock_enable(CCGR_GIC, 0);
+	clock_set_target_val(GIC_CLK_ROOT, CLK_ROOT_ON | CLK_ROOT_SOURCE_SEL(5));
+	clock_enable(CCGR_GIC, 1);
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	return 0;
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	arch_cpu_init();
+
+	ret = spl_early_init();
+	if (ret) {
+		debug("spl_early_init() failed: %d\n", ret);
+		hang();
+	}
+
+	preloader_console_init();
+
+	enable_tzc380();
+
+	power_init_board();
+
+	/* DDR initialization */
+	spl_dram_init();
+}
diff --git a/configs/imx8mp-phyflex-libra-rdk_defconfig b/configs/imx8mp-phyflex-libra-rdk_defconfig
new file mode 100644
index 000000000000..2767198a9cda
--- /dev/null
+++ b/configs/imx8mp-phyflex-libra-rdk_defconfig
@@ -0,0 +1,183 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX8M=y
+CONFIG_TEXT_BASE=0x40200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SF_DEFAULT_SPEED=80000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x3C0000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx8mp-phyflex-libra-rdk"
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
+CONFIG_TARGET_IMX8MP_PHYFLEX_LIBRA_RDK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x960000
+CONFIG_SPL_TEXT_BASE=0x920000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x98fc00
+CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SYS_LOAD_ADDR=0x47602000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x3e0000
+CONFIG_IMX_BOOTAUX=y
+CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
+CONFIG_OF_BOARD_FIXUP=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_FIT_EXTERNAL_OFFSET=0x3000
+CONFIG_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
+CONFIG_DEFAULT_FDT_FILE="imx8mp-phyflex-libra-rdk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x26000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_BOOTROM_SUPPORT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+CONFIG_SPL_I2C=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_SPI_FLASH_MTD=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+# CONFIG_CMD_VBE is not set
+CONFIG_CMD_BOOTEFI_SELFTEST=y
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
+CONFIG_SYS_EEPROM_SIZE=4096
+CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
+CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MMC_REG=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=2
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth1"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_CLK_COMPOSITE_CCF=y
+CONFIG_SPL_CLK_IMX8MP=y
+CONFIG_CLK_IMX8MP=y
+CONFIG_FSL_CAAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x13000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_BOOT1_NAME="mmc2boot0"
+CONFIG_FASTBOOT_MMC_BOOT2_NAME="mmc2boot1"
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
+CONFIG_MXC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x51
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_BAR=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SST=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_IMX=y
+CONFIG_FEC_MXC=y
+CONFIG_RGMII=y
+CONFIG_MII=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RNG=y
+CONFIG_DM_SERIAL=y
+CONFIG_MXC_UART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_IMX_WATCHDOG=y
diff --git a/doc/board/phytec/imx8mp-phyflex-libra-rdk.rst b/doc/board/phytec/imx8mp-phyflex-libra-rdk.rst
new file mode 100644
index 000000000000..623abe44c28f
--- /dev/null
+++ b/doc/board/phytec/imx8mp-phyflex-libra-rdk.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+phyFLEX-i.MX 8M Plus Libra RDK
+==============================
+
+The phyFLEX-i.MX 8M Plus Libra RDK is an SBC based on the phyFLEX-i.MX 8M Plus
+FPSC SoM. The phyFLEX-i.MX 8M Plus FPSC with 2GB of main memory is supported.
+
+Quick Start
+-----------
+
+- Build the ARM Trusted firmware binary
+- Build the OP-TEE binary
+- Get ddr firmware
+- Build U-Boot
+- Boot
+
+Build the ARM Trusted firmware binary
+-------------------------------------
+
+.. code-block:: bash
+
+   $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+   $ cd trusted-firmware-a
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          PLAT=imx8mp \
+          IMX_BOOT_UART_BASE=0x30a60000 \
+          BL32_BASE=0x7e000000U \
+          SPD=opteed \
+          bl31
+
+Build the OP-TEE binary
+-----------------------
+
+.. code-block:: bash
+
+   $ git clone https://github.com/OP-TEE/optee_os.git
+   $ cd optee_os
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          O=out/arm \
+          PLATFORM=imx-mx8mp_libra_fpsc
+
+Get the ddr firmware
+--------------------
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ chmod +x firmware-imx-8.28-994fa14.bin
+   $ ./firmware-imx-8.28-994fa14.bin
+
+Build U-Boot for SD card
+------------------------
+
+Copy binaries
+^^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
+   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
+
+Build U-Boot
+^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ make -j $(nproc) \
+          CROSS_COMPILE=aarch64-linux-gnu- \
+          imx8mp-phyflex-libra-rdk_defconfig \
+          flash.bin
+
+Flash SD card
+^^^^^^^^^^^^^
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1024 seek=32 conv=fsync
diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
index 4519079ab3dd..10c3696996b4 100644
--- a/doc/board/phytec/index.rst
+++ b/doc/board/phytec/index.rst
@@ -7,6 +7,7 @@ PHYTEC
    :maxdepth: 2
 
    imx8mp-libra-fpsc
+   imx8mp-phyflex-libra-rdk
    imx8mm-phygate-tauri-l
    imx91-93-phycore
    phycore-am62x
diff --git a/include/configs/imx8mp-phyflex-libra-rdk.h b/include/configs/imx8mp-phyflex-libra-rdk.h
new file mode 100644
index 000000000000..95046bf563bf
--- /dev/null
+++ b/include/configs/imx8mp-phyflex-libra-rdk.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026 PHYTEC Messtechnik GmbH
+ */
+
+#ifndef __IMX8MP_PHYFLEX_LIBRA_RDK_H
+#define __IMX8MP_PHYFLEX_LIBRA_RDK_H
+
+#include <linux/sizes.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_UBOOT_BASE \
+		(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#ifdef CONFIG_ENV_WRITEABLE_LIST
+/* Set environment flag validation to a list of env vars that must be writable */
+#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_ORDER:sw,BOOT_system0_LEFT:dw,BOOT_system1_LEFT:dw"
+#endif
+
+/* Link Definitions */
+
+#define CFG_SYS_INIT_RAM_ADDR	0x40000000
+#define CFG_SYS_INIT_RAM_SIZE	SZ_512K
+
+#define CFG_SYS_SDRAM_BASE		0x40000000
+
+#define PHYS_SDRAM			0x40000000
+#define PHYS_SDRAM_SIZE                 (SZ_2G + SZ_1G) /* 3GB */
+#define PHYS_SDRAM_2                    0x100000000
+#define PHYS_SDRAM_2_SIZE               (SZ_4G + SZ_1G) /* 5GB */
+
+#endif /* __IMX8MP_PHYFLEX_LIBRA_RDK_H */

-- 
2.43.0

