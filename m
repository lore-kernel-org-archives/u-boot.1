Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0363DC46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 17:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41BC987A05;
	Sat,  6 Jan 2024 18:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="PRh12zSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9024B879FA; Sat,  6 Jan 2024 18:29:33 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0D287A08
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 18:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il4KgSyRlBHZBHlrhJUqqAR1fnVxRxU4i5L0gGbxI/UjhkA35MXr79gKHIlDrFqmSX+WLvtVux5oOlXw7VfRILqG+lGq7Y2Fa74ZPucF7aE5vsgZhEmwIXp652TJ7KsyaMzg7rM7fPhIKHnDc3w/EhUQTVgVIjPpVwxBGjl1eaomi8SbQqZWwJgneECS5eu4P20j7gZTdzkVYCdh+Jl5Hnovg5z0odKq82SQQTwnBpo+oc2SdTGvIeio0steV0y8ynHizxx6RPgWArmAb1YHn/cYvemh6tVbURaETwUbosMzSWX7j9LHUhRUTgTsForYAL3uwNCUufq/5qHwnQIDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpDNGEVwva/xCxznxj/CXCYhsuxevLDsXKLeNjMwZQ0=;
 b=Eb0aOgO8luXm+HIQgYU829E4+t8yDafy9Xc3JOp+V4DeFRd0wsxSBwjZ7ndgfmSnhl/ywcFKnyTMiKFlJT+v8NBXRDpglZ7LwjBRO2OZ+b/xRWSSSlBakEz+qnpB15zVEo1MGssrlA61DmArW/Pih35bO7SKfrKN0RNedGtvtijkcumaFgXyYPdVA6Qst0qKnfR6Z6rmUK3G/bLyCOT5rpjPDzxUBpPCNPuNEtLL/6UWPD0ULLNC++DUpdn7xHjdPI5ePRYi7N3lw4K1DoX8Qp03WaLoYRISGUsdDlXO3psxoEH2CdXvKIt1LRdXTAVRg7x0Y0sDicit9uT1zS4AgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpDNGEVwva/xCxznxj/CXCYhsuxevLDsXKLeNjMwZQ0=;
 b=PRh12zSBKMeF5pQyUG86QfXiTK/BXHaMr9L/nAYDjp5v6k7apD4Un2CN+GuA4JS+0SqrCL57ZsdrKW6VFYryNO8rz9A0CRrptnvapwM1fYnWCkMKGa3VMqCzP1YB/2/EhGm8RnSf2eIf00ezNM16iSc/Wb9JRUlam+EC8SKCn+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7944.eurprd04.prod.outlook.com (2603:10a6:20b:28a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sat, 6 Jan
 2024 17:29:24 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 17:29:24 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 06 Jan 2024 18:29:17 +0100
Subject: [PATCH 1/2] arm: mvebu: clearfog gtr: add config option to select
 serdes0 interface
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240106-clearfog-gtr-serdes-v1-1-66cbc350c58d@solid-run.com>
References: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
In-Reply-To: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fadeb8f-de77-46f0-5de3-08dc0edd0693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N888ADR+XRmdFzUD/aw3ohF5E4PfwRroPOdMrfF4DO+3v1hDyqVUFNiqXlj/uuqTQqV59c5UhHcq5LsoNZX8eo4iXrX7J47s+BWhtCA0TIUmni2BOddsm4nCNjs3PEY6WGSoxdMQ2dYECIAD5AzmsmqJdp9t3RFztBqHkd1lwFrpaMem7ZTIBM/3TpIEAgdsXApcHbktg7BMmbqy+gJ8bv+3KOVpQ4Tq+zt1f96iGsU5vKWKWwiuwbK1h4VkUIM4ogan+g1l9q+zEeHFr5CB/xNViNLf4OJ4+GjmS/oAUL9HvcK/C7JIWzoa4lr6uv9CZRz4VvB9S8+BVdD5PXI3UmTCt32t+0eESEgLmOmT1QGK31BMWCCa4S+g/R0mVA2S7uCFs1yp9wi33NVgA9qeITGGE3jdqJGdYsi7kjkIZjzTz12ZGgi5vtGOqzQgesNF2pxfVtGxZmD+RFD1coBE2+/UFybylfMgauuTRKtX826Hkan7AJOGnOTYrBDD2a130RfIKao38uA/nd+g8PMHUgeRebUnUNrvvk7ga+Tv2AeHgxgJeFMP2OKeR4PnF/sZf6MYRXbXik2ktZbuJ8F7EHVPdjUsIWypDuoTwB7oz4VgDr5LzGYNdtwfaGtqw9sp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(41300700001)(2906002)(52116002)(6916009)(5660300002)(38350700005)(6486002)(36756003)(86362001)(6666004)(6512007)(6506007)(316002)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(83380400001)(26005)(478600001)(107886003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUV4OWxkcXhzRnlGSFdDblRBNnBtdFJHakZYeGtjcGJ2TjVNMTFmYkVEcWVK?=
 =?utf-8?B?QUUrMEdYYTlzU3lQcVFiZ2lGMmt0MjFsWFlrdkwvdVkvcnFITlJSSzNLOE9G?=
 =?utf-8?B?UWpoL3ZVRU5vb0pRZXEvVmVsc0ZCYklXZGw2ZVEycGVQMVA0MTlNWERNd2Mz?=
 =?utf-8?B?bkJ6c1E0eUNVSlUzQUFDN2owalo1c3RWWHUwWnpuSE1Sc1dXaXFTTTBqSjNN?=
 =?utf-8?B?L2xJR3l4OGthYkVGa1BlVjBwcXlmZDExcVAvTUg4cTB1cGFhL0l3aFd5M1dI?=
 =?utf-8?B?NENhT2tGTStEU2xEM2ZPbm5tWG93TkJhbEpFSENUUDZJR0wxenAzcXBsTU1C?=
 =?utf-8?B?TDY2TUtCWmtPZFplOUdQbUxGMjBtTzNkREsxeGYrdlZUSmw2S0ZJa0N1VFZm?=
 =?utf-8?B?MzgzNzBCM04zd2tLU2gwMDBrcHR2akNRZ2sxNEFnYllTMHpJYkl0cC9uTlFu?=
 =?utf-8?B?cnBacXl4YVhWbDU4MUZQQ25uRXBkcmtPRXJFRlMveXoxY3NBUnR1U3pTZXNM?=
 =?utf-8?B?M3JKMjgzTW5oc0ZPZTRUajdjSDJNT2ttelpJRUZkc2VXNXR0dTQ4bjhvZzB2?=
 =?utf-8?B?MHBvMkliVEZMRWlzSlMwdkt0cGVicEsxekNoV0VhczJhVnNaWEQrdkVsZHdF?=
 =?utf-8?B?dFlCbVBiNmZEeHU0OFVTZGdyVm5RcUJScWNjWmw2U3p1S3NqMHgyMUxYQ3dS?=
 =?utf-8?B?OWJEUnRzSWZHNDJmcEhIV2E3azlwVVF1OXkxRkpVcUp2ajNTdFRqamNDWGZO?=
 =?utf-8?B?dzB4Q2NWQXU2VTNHcEJoa2V6YjNrOTBxaXZhRTZaWGVtcWxITG1tSTByYVhU?=
 =?utf-8?B?bE0zQ2pid0FxcmlGRjdtMDZ5QXVqMWZBTlNneVNPeHhnVGJpcFJFOFRSaFlY?=
 =?utf-8?B?ZTZTd0l5WGNndENlMldwMjJjeCtrMW5xb0lWd2I4bDVqTzlWTm1DejZvWG0z?=
 =?utf-8?B?dVFTMFgyK0dmS3ZxL1dsSEdEa1V6V3VTQyt4UytMVnl4U0xXTU1FR0drNW1J?=
 =?utf-8?B?V2tNSjJiekNwSnFJWkl1Z3Nmb0FkUDhtSDJaSHVkQTYvRnBIWERjWktIM0Fh?=
 =?utf-8?B?MUF3clhjREludzdXaUROZWhHdnI1RW9WaXNvM1JaZjhsREJqK1FmT0NPTTVq?=
 =?utf-8?B?WElsem5Fbjc4Mk94WGpyTFZyYWxGb1N2UXJVZHNnQXR5UVd1MjIrekgyb3RD?=
 =?utf-8?B?dTRiT3RVR1h4UTN6WDNnaXhnRlFSTUNtdTJyOHpOc3FZUGJUNDZTS2RxT2ZE?=
 =?utf-8?B?aW5RNllVSnhCVzFZZEVjYk8yL3hDQVlZV1M1OWlERFFxVFF5ZlN6OVNTekFo?=
 =?utf-8?B?RkdQZUJsdEtCSFoxblh0SmtUK3BLdUYyUTlvZjM0cmNza1h6SjVUbDJaMXFv?=
 =?utf-8?B?T0hRaC92Z3Q2Wmk2TDlFWnQ0TWljMDFCQUszcHFQTVhWbStLL1RsQ2NwVlZ4?=
 =?utf-8?B?Y2F6N3JNZTFkVEFZYnQ0dW51QmJUbUQweDVxbVZPNnNXbkRvcENTQnBqajhD?=
 =?utf-8?B?Y0QvWVVoZzEvZkQ4UVREUHZnY1FnZUdGZzh3TjN6eGMxRktxSVhuVjNWUm1s?=
 =?utf-8?B?VkE5MXQ3dnF6UmowZkt6MFBJTW9pcFh4UDlpRTRaOWE3empXYjdHd01iR2RR?=
 =?utf-8?B?RDg4TitwcVlRdWlySmluYXhMNDBpdzZGR0UrQUFsdjhWazlnMFFPdnZRYXpu?=
 =?utf-8?B?L0h6ckkxWmFBNzJMdFpWdk1xYlp2Q1JiclZaK3Z2YVV5QXVTcmtUTzlwK0Np?=
 =?utf-8?B?QUhPM2FKMVJtdW5QZzhNellrblNjVndEeVB5Um84UGthY1EyeEdNamNsaVlu?=
 =?utf-8?B?WFplUE45ZkNTSHVhNkErMkYvZHhsMUt5N2pLSm1LZW9aUE5yZ21tTkU0RXpN?=
 =?utf-8?B?ZHBGVUxPTmxQOU1FUnQvaGxqeHI4UXVXdGZGMkdSUUdsNzJ1VzBaUVpkZFQ3?=
 =?utf-8?B?QlhlSE1GTFZ0bU5xU0VPYWVNWkFaSkRZQ0pJUHlHK3NKbi9GOXRLT1dscUxQ?=
 =?utf-8?B?YmhndERZbnJYM2lIOVNwV3EvVTdmYVlsOHFXdWVqclQ0SERmSlVUK3pEeXhj?=
 =?utf-8?B?Y3B0eVBXWVJZRXJMTkdEQXZpMXhGaGlEYndWVFl3Q2NwN0kxcjg5bDc3WmdV?=
 =?utf-8?Q?WnkT/s85zZfSzXCXB3obiYvUW?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fadeb8f-de77-46f0-5de3-08dc0edd0693
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 17:29:24.1355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akKH4UO8CiGOGQpyJLMnUOGc8kfJTXwdXmP7NE1PW/42uo6qJWeowzQZsu4RUx5eFg9+Ux8dDHutB2Sfk9UwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7944
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

Clearfog GTR has an assembly option for a SATA connector, CON18.
It shares the serdes with mini-pcie connector CON3.

Add new kconfig option to select betweenata and pci, defaulting to pci
as it was previously configured in board-file.

Clearfog GTR connects eth2 / serdes 1 to a 2.5Gbps capable ethernet
switch port. Linux already configures a fixed-link at speed 2500 from
device-tree.
Upgrade serdes 1 rate to 3.125Gbps to support a 2.5Gbps network link on
Clearfog GTR.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/solidrun/clearfog/Kconfig    | 19 +++++++++++++++++++
 board/solidrun/clearfog/clearfog.c | 11 ++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/board/solidrun/clearfog/Kconfig b/board/solidrun/clearfog/Kconfig
index 60d3921307..765d8a6355 100644
--- a/board/solidrun/clearfog/Kconfig
+++ b/board/solidrun/clearfog/Kconfig
@@ -39,6 +39,25 @@ config CLEARFOG_SFP_25GB
 	  SGMII connection (requires a supporting SFP). By default, transfer speed
 	  of 1.25 Gbps is used, suitable for a more common 1 Gbps SFP module.
 
+choice CLEARFOG_GTR_SERDES0
+	prompt "Select Clearfog GTR SerDes 0 Function"
+	help
+	  Select function for SerDes 0 which is shared between CON3 and CON18
+	  for either pci-e or sata.
+
+config CLEARFOG_GTR_SERDES0_PCIE
+	bool "PCI-E on CON3"
+	default y
+	help
+	  Configure SerDes 0 for PCI-E to enable CON3 mini-PCI-E connector.
+
+config CLEARFOG_GTR_SERDES0_SATA
+	bool "SATA on CON18"
+	help
+	  Configure SerDes 0 for SATA to enable CON18 SATA connector.
+
+endchoice
+
 config ENV_SIZE
 	hex "Environment Size"
 	default 0x10000
diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 6fa2fe5fe3..51c5be518a 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -90,9 +90,14 @@ int hws_board_topology_load(struct serdes_map **serdes_map_array, u8 *count)
 
 	/* Apply runtime detection changes */
 	if (sr_product_is(&cf_tlv_data, "Clearfog GTR")) {
-		board_serdes_map[0].serdes_type = PEX0;
-		board_serdes_map[0].serdes_speed = SERDES_SPEED_5_GBPS;
-		board_serdes_map[0].serdes_mode = PEX_ROOT_COMPLEX_X1;
+		if (IS_ENABLED(CONFIG_CLEARFOG_GTR_SERDES0_SATA)) {
+			/* serdes 0 is sata (like clearfog pro) */
+		} else if (IS_ENABLED(CONFIG_CLEARFOG_GTR_SERDES0_PCIE)) {
+			/* serdes 0 is pci */
+			board_serdes_map[0].serdes_type = PEX0;
+			board_serdes_map[0].serdes_speed = SERDES_SPEED_5_GBPS;
+			board_serdes_map[0].serdes_mode = PEX_ROOT_COMPLEX_X1;
+		}
 	} else if (sr_product_is(&cf_tlv_data, "Clearfog Pro")) {
 		/* handle recognized product as noop, no adjustment required */
 	} else if (sr_product_is(&cf_tlv_data, "Clearfog Base")) {

-- 
2.35.3

