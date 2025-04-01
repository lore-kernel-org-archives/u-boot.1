Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10217C36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 09:52:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656E781703;
	Tue,  1 Apr 2025 11:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="UxmaM6Yt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B86818C7; Tue,  1 Apr 2025 11:52:16 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43BEC80584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 11:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv2IzxY6TMwJ34oN2YqE/qKDH3j7FEHBz050GC5CUCfIzPZdcmhyd/5uqTvQ+tZuTJn3iPg6fJiZeMHw8WvdToYEJbzTorom1SsEDthSdjfZBaseHb1BTsemDNnaMIDxv3cU7r98bDpSL0VrhhJGROBOaLMuOTelRccLiptr034WWEjzWKzQYNi6clhCFGT4KBRJzyU4Kq/ciUu3fo7kcnwYeVlJLJ38dlE+xsy30T8lBzPYXuxoOfw8Zoa/dtYMB6jtu5VKVVuRjfwMutu0KPafdHM0SGPh7orjVg5lfJtmbRsiW1ANFt2SwXHPfj/xQ2ihF8UjGMz0DxkO6yWyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP873+FAfIkYQVHRZWSUu1dUEIZLos2Ap3oeTtc1sIY=;
 b=RJO0EWe7ytQg5kFNws1z7y7jwuAyJJybGG7iyqd6q16AIPiFCCiSk6JELzS8FQXKnh2tj5m6VELWzpKBtIOLypJi/zbnZ3CtEremrGkw/YRxMOrcTyws9wM//6QOLYetdGT7hR+IN0vOWgXMr+Mdg4/6zMSDQvi+2mA3Ynkpvu3o/Ayv5R92B+fWxuQDOm/PXPO9s/voYIjBddT+OYo7GsBqxZNbpVXI2DJDhvVUmXURZF3hRxbHYHGsod24JYemdF9ikpVBpcAhmaCH1vlbBUZq5N7cy9/SWxS/Czk6o9FFUJRx1GSkye1bkHNnU5wTQHrPKKlh3s+eHSzrLyTUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP873+FAfIkYQVHRZWSUu1dUEIZLos2Ap3oeTtc1sIY=;
 b=UxmaM6YtXl1/nWYzywNuAzzfTAtor10caDL3BH5BHjBQntEs/s9xj+vjLbPuscHq2qICZkEC37Lc3x+yyDmRoa3t34yOoGxP1xZ+jTmN6TDSGuatcn9+1qKthR/QiWQz6UYtLjfLjls6UoRwwzq73i+NLlX5AKINGFSiESdg/7VrV42jsBnd3no4OUkq577HNMdYfQnQPPMv1np5KgSylGhqcHFe2iI/yioGlrUOMkHvLhyCQR85O+mq0HIkKgrE4WVrcSHQTx2OQvKISJ1+06ErSyHf4ooqtdcOef6meAX0lfNMCkzdbl9wJVP86QY0RfSIQoQkod6PR+7e+vMAhw==
Received: from AS4P190CA0062.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::23)
 by PAXP195MB1229.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1af::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 09:52:10 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:656:cafe::12) by AS4P190CA0062.outlook.office365.com
 (2603:10a6:20b:656::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 09:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 09:52:10 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 11:52:10 +0200
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 11:52:09 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <upstream@lists.phytec.de>
Subject: [PATCH] doc: build: docker: Fix code-block formatting
Date: Tue, 1 Apr 2025 11:49:52 +0200
Message-ID: <20250401094952.8896-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|PAXP195MB1229:EE_
X-MS-Office365-Filtering-Correlation-Id: 12791ae0-bad2-4e6f-3eef-08dd7102df3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgUY33YFrtT0rpw2O2xvFCQeDeE/V84b1QYGRXMqXpK3fUr3svkJxKXeTfFp?=
 =?us-ascii?Q?Nih7rKkvul8sDIeqwG+k0wqMrWnsLLvIf6iFBdSgjpa3aSGaVNAypLwvNOsH?=
 =?us-ascii?Q?VguXnsOTHPGiFktL/xC63lLNHCmtCrcalhVz4lCHVgUzzhO2uiAPzVKfQGpX?=
 =?us-ascii?Q?jWF1qOKGmyR5kgxP15fBGpjZ33W3HPknMJ3bdn32hjKfq58M1a8WR5nMK+Ms?=
 =?us-ascii?Q?hV+Qgyr8Bda6khzO4pa1BdZvhZP8ENF4uazMrp5jyUweffgK4xXfD2iKuUi3?=
 =?us-ascii?Q?B0leOJf27+a86t1YfGeM0gJlcwCp62iFhZ/nczcXe/IJiq3D2xIy/ErRsUOr?=
 =?us-ascii?Q?h2FOVrd+gGYna/0TAyEn1PcBeaZh7HCddv+Sy0k9pBfsKrLQQ1KXd2kG2Dgu?=
 =?us-ascii?Q?nWiUvIwluO1izTJYHqJ1aZ313q5ZfG3dnStQx44HfGIK9wWY9BwpbHGVVgdR?=
 =?us-ascii?Q?8vNIK45s/oV0RlSkzCdyla9BS7pw7TIQEZ0MKoNBuRvlTUnFoXZyED98ymdH?=
 =?us-ascii?Q?cSuX5tGoSTGevl/Yrlf2yQapkj0TRnKe5BoSHcx5xdh/PiE7MiqlCIaPKitb?=
 =?us-ascii?Q?dgc7D5hNGeyovoZ+W9mOwcbhuCDCdYCswK04CTkDhQ44FhcKvGT3gbmF2oi3?=
 =?us-ascii?Q?rt2CNewr2ZdCsvV02GATc42IOmwFyGh3Hx0n/dnWF46hGmQjb1L6uxOMLoOP?=
 =?us-ascii?Q?M6h+s/8ebXpttWmJXFWGvdfLNSCZFs9rUFVuQrqyfbojrNhR0Z2ZMjRaIOd8?=
 =?us-ascii?Q?rkSEtDM6cciNIdpQEqIqhCy45SYMzhEv3aQvnPV5aW7jLBXcNfUESy7ixwqp?=
 =?us-ascii?Q?uXgcaW/HU7MH8lumkeBhcfeQaWJNC9vxfxP1qkfCWHl/VnVE1k6skNiHWPG6?=
 =?us-ascii?Q?fAJ/61AEK5nhmB0UIr3k85PgwhsFVmsFGolPUBRlXnqomef1qQyQRljG14zX?=
 =?us-ascii?Q?jXqHfTZHFTUQIn53vU3cO/aRLtMK9nJh1rAA74hGfXvypolsYUnvrAkwPCEX?=
 =?us-ascii?Q?KyChPZkKVJf6zKNtegFsQthhhmlYaqStVLGXqs2zLCck6TMIy+hZa5oCB5am?=
 =?us-ascii?Q?nlqrIfzlQy72KCp3YTqoBL/TeKIOrSMnAZNQ1ZxSPisjRn9PT9FIM4yvKVbw?=
 =?us-ascii?Q?cJSE7r0jjBi+3gh9BPFxLMYnOjPtCMm1ROYqpVBIpMvYyDB+NdKb1YTJQhAt?=
 =?us-ascii?Q?NjfLRyWN+5ypiMAJHPvtWT9YcYH/TaZIGkQklMHy9N6N74HsX4MQz9xvyVMs?=
 =?us-ascii?Q?fKiXHa1lX9BS/aBnbPVMfnDllHuaTRHkapx82temJ2RG9NDoeJ6vvQ4dQrMy?=
 =?us-ascii?Q?WVZNlL/etvav+ZALx6ewnMNIZB6Zdn1wJPuu3YlvVb9m9WNyvLCvn/TKga68?=
 =?us-ascii?Q?yfNzMiFyCg/ndMkvKn9XZxS1qRGXgcpx3jKTVFN1G0nNwUQl5u9SC/BKIMR6?=
 =?us-ascii?Q?X1L5Yoo0AdlOrHFS4cdZRdDhl+8iZCpjE4h24Dt1CTXETbVTuqMjtRpQu5dk?=
 =?us-ascii?Q?J5LoklG5jb954H8=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 09:52:10.5241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12791ae0-bad2-4e6f-3eef-08dd7102df3b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1229
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

Remove double : before code-block. While at it, use code-block for all
bash commands.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 doc/build/docker.rst | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/build/docker.rst b/doc/build/docker.rst
index 01ed35050908..4974a98d4af5 100644
--- a/doc/build/docker.rst
+++ b/doc/build/docker.rst
@@ -12,7 +12,9 @@ You will need a multi-platform container, otherwise this error is shown::
     ERROR: Multi-platform build is not supported for the docker driver.
     Switch to a different driver, or turn on the containerd image store, and try again.
 
-You can add a simple one with::
+You can add a simple one with:
+
+.. code-block:: bash
 
     sudo docker buildx create --name multiarch --driver docker-container --use
 
@@ -20,7 +22,9 @@ This will result in a builder that will use QEMU for the non-native
 architectures request in a build.  While both amd64 and arm64 happen in
 parallel, the non-native part will take considerably longer as it must use QEMU
 to emulate the foreign code.  An alternative, if you have accesss to reasonably
-fast amd64 (i.e. 64-bit x86) and arm64 machines is::
+fast amd64 (i.e. 64-bit x86) and arm64 machines is:
+
+.. code-block:: bash
 
     sudo docker buildx create --name multiarch-multinode --node localNode --bootstrap --use
     sudo docker buildx create --name multiarch-multinode --append --node remoteNode --bootstrap ssh://user@host
@@ -28,7 +32,7 @@ fast amd64 (i.e. 64-bit x86) and arm64 machines is::
 And this will result in a builder named multiarch-multinode that will build
 each platform natively on each node.
 
-To build the image yourself::
+To build the image yourself:
 
 .. code-block:: bash
 
-- 
2.34.1

