Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1057C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4B7879F7;
	Fri, 12 Jan 2024 14:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rRrsPPf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABEA8879D3; Fri, 12 Jan 2024 14:35:20 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3376879F3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:35:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB4z4dT7K75nFAAbCXbN/jVg4kAs1KAbj0p4afTO62/zxvMV35jxMSpUG6klor1iolY8iU8DR86rnWRUmx1zPVaXfXaX8QyNuDZ2vYAVJa+avuP5lH9Tuw2stFKatPLVt/Xogzwz9FD+eeWakFee9PalktZRYMZ7JWmbC7/AaeFkYJ8zVb2ioZCaQe15yBZ0amzdB4SzaHdr9CefQyHgUpRYLjaOHC4A0KYwzyI1kTaFnvVj0SCsFTEvSAJzuLQ6t1LtrCBhdVZ+aQVpio1SoutAv9vcoId6tCPwWdkKNlDSW1gosYv5/evIxTo78PeBZ8L8YeFWkwbM0nVoX5gPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pzD0G7B2GxTLWkcfaz/uCqyAaBumC3n5Z2s7j//SJ0=;
 b=GRv5m/soTSr5w57A6p0LtiVOUkb7kiuStJ0TzuI0gCxCIM8OyuGUakz+OXaDhhq3W4eQxT3iQkIzfB7xuGfVuG/NXzypR4XfUWaga/N9jC/8WAh+BZpUhMOh+T+iqFR+Agt542UZIQmdEIPXNS9Sokb1HcvqUAKKL3gAJW5xcE8IyALVD6Z4UI2xaLWTvlvijt54cQuDwZBnSMzLlDmuOIO51MqEE5MC9uYq8lp0vnB0EBFyz+pkNO0BaQ7tc+nuGqkTNIp2toYpoLUSVliqgh1es8+302dcVqD1hn3XsjOgVp5nZW/0OXCo9yLxn86b+yUZUCR+oCxXlu74GXT7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pzD0G7B2GxTLWkcfaz/uCqyAaBumC3n5Z2s7j//SJ0=;
 b=rRrsPPf6d7jE5ijdj6iyz1Jc041ZQA4g1jOfq7t0Gdwn3VVqHcxuwfvlyn3bFpCdxvCYVlXrvelIP+jdoTIF6sCkoiPAomk8Ob9jaEOTAj4ffqJuP/KbdIcYayuxtdW0XCU3ThsIOap65L0YodquG73J06V8HRdl9/88Ab5p77g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 13:35:15 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 13:35:15 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 12 Jan 2024 14:35:10 +0100
Subject: [PATCH v2 1/2] arm: mvebu: clearfog gtr: add config option to
 select serdes0 interface
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-clearfog-gtr-serdes-v2-1-4c24b751d838@solid-run.com>
References: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
In-Reply-To: <20240112-clearfog-gtr-serdes-v2-0-4c24b751d838@solid-run.com>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::12) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6573e3-719e-49ce-8139-08dc13734f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0Gs2hKKg7tKSWhKL6KO3TzgxHCNzJRG9t4fqmZRmfVcgmBset3AmeVjR649IYpip5bZ9Uj+ezaVnPqMfE0bongbYxrCP6+fxGZAU5BDyb0Tn9aC54uv0/n6C8IJZksgyhVWh/+FIsdj1Yq89dMuQE0yqtglCG9Z9Zm3JqKplFO2CTsfZglpCZmAONlPihz0+Wx+hrMgpM8LqXP7dFlVUK0GXx9QFkIVCkMY/puvEQEHXul40c2ex7o7p+EK6Yeh0ke1za1oLczrXU2o3oEOtEjFzm34pitxZEYI429WYzHnlZGbMeGWkUakvYk1XILbkUAxzNyRO4aV1fr0bgjN8HtKtAl+64FAmoMTdR0noNE+I6htuEn6uu1N47uZP9VlNBzj/3VTO0sBhpRGhrlArHxtWWzYW+A20Je+Q/sdcr3OKhuBAyCEPQD06U7QqIby14kfVcQgG2cPUilGz+5gGc5PYHEQDDf3j+adbuFq3nYGugeqAXSQgtt/vcp+w1OivCysfG/1YVgLxWAwGZhgHiYojfOwHPZbqj7rETazdenNa14K3ZGGwbFd0CYYnreSNUmuntib5KxcUe6DAu7oIKNaHSCDTwoYuEfPRrPnQ4+nBLKdluS/xxUd7bsw9Hy7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(2906002)(5660300002)(8936002)(8676002)(316002)(66476007)(6666004)(41300700001)(66946007)(4326008)(66556008)(38350700005)(478600001)(86362001)(38100700002)(6486002)(107886003)(26005)(6512007)(2616005)(83380400001)(36756003)(52116002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0d5Nk0xOVE1U3VoSEVuYS9MMGwzZ3E5YS9tSDdqMTRuMGVmcVBJeXJFaDl6?=
 =?utf-8?B?TVBrWUsxN2U3L1ZCOUFNTzY5VzRnUlhBTDhqdFg1ckJlYS9CVGVoUjZkL0c1?=
 =?utf-8?B?M2RNYmllenZRVzdiLzRESGJDdEZNb0RQS2l2QWVaSTczQWFyWWxuekRHZWRF?=
 =?utf-8?B?L28yUEVOZXpqNEZZcVE5cDJ4NUZtOGh5M0dvTWtqdmR4SmFhU0hROEl3UnNm?=
 =?utf-8?B?Ri9NUHdFL0hmYWM1eWtxZGI4ZTFJbW5tYmY4ZXNqM2FqTCsxVlhiU0dZNEtO?=
 =?utf-8?B?T1dEM0x2Qk5teGNzalR2OFVHSHU1cG12Wm14OU1WK2Vtb0xPV1k2d0lwcXNS?=
 =?utf-8?B?WUc3bWU2cWpFdDlWS2lZOEdqN3VwM3BrOFphbUZ2NEFXVS9ITmxna1JrdVp5?=
 =?utf-8?B?NU1peHdyRExCd0VmazIrRTVRZnkzazhPNXIzbGY1QTk2QWFrcnJ1Y2Y5ZjZP?=
 =?utf-8?B?RTdxNngvdHFJVnZCdm1jNjkrazg1Ykk2ZjVrdDA3N01rMXJBNktrY2p3MnpS?=
 =?utf-8?B?VklBV1R1ek90UzJ6NXRydlJ1Zk90SWNuR1ZZSEphMWZIbXVvS2ZqdG5kSzR2?=
 =?utf-8?B?Q1c1ZDdMQ0pYM2dUSEV1Y2Z4N05aUStWTDYrQmF6Q2NzSVR2RlRNMWNna0U5?=
 =?utf-8?B?eWdZZXgyWTh0d2dWd3QxZTc0R1A1R1lMdHVSemh3S2FCZkFUb0xtOUM4emVp?=
 =?utf-8?B?VlArNjdmS0czNmxkWlJFNWNpcmdQL0dPSW9ldjIxTVdHbkw4ejZTdTR5QURW?=
 =?utf-8?B?dHlkYytWM1RJZkx6cEZlTXNYZUhZbXpJN2Q4VndtZDJHSlN6M0RrZm5jRU1p?=
 =?utf-8?B?NW13TU56WjQwb0RRSkxYOFN2ZHJLcUlVRlR6TWdpVGhOWHhaaWt4eG9DbkZE?=
 =?utf-8?B?MHQzamg5a1JtT2FUU29qcFJaSmZaNVdCakxnN1lIOUNxdldkT2l6T3BkTTVU?=
 =?utf-8?B?aGpmOS9tU1pPQjlqck56VXh6QStiWG9jbEN2RTkrRTluRGtlTkd3T3Myek5M?=
 =?utf-8?B?TWJGTzRmQkxzQ24xWUxFeGJJTG1CakFaVDdtL01yRW96dDlmODVzS1l5RHd0?=
 =?utf-8?B?MVlVWjZ2ek9wL2htMm8zMlZSaDBBV2VCcERIWFgzTnUxMU9FWklSU01XR2lj?=
 =?utf-8?B?eDd3RDhDOFpiVHBQRlJBUjcrdTlxNWozRlhvVnc3N0lFc3JzbE93ZWkwN1NK?=
 =?utf-8?B?aTlqMElneXBrQXNoQlI5Y0Zpc1RoRUQySEpyNjdnWVFVdStWQ0pQWkNQdVJi?=
 =?utf-8?B?Y2lFSXlWNitnbTgvbzZ2OU1rMkhodXRmTWtJZEV3R3QvRnQ2OEpNeEpaVHkx?=
 =?utf-8?B?c0I4aDRFY0FOcTl3VVVHUHE2d3BMbk1tWFNTK2JTMXdsc2xETVJCSW5nSlZX?=
 =?utf-8?B?d1VFUkFrL2tKV01QRjdlTkJhZVFMYkFzZG00NCtpTWhaQWtWWXQ0V1JLcDVo?=
 =?utf-8?B?Tm1MckhZMkQ5TllSL2JQTGxIRHJ5RkJuMzg5MU5nZzFFdndHdHl4MkphVGJ5?=
 =?utf-8?B?NjdFdTR3Tld6RTh5TWR0d1VmVWZmOHp4RUlpbzRsNUlvT3AzVmJHU3FEM1Bv?=
 =?utf-8?B?cHNJRTBDT1VmWUg1eGh5QUcyN2tHZEk5ODdFYUw1ZkZMS2x3dFRsNmVwVlhm?=
 =?utf-8?B?YXhiTWZMa3ZKVTZ6WmFqSlcrcWtBR3g4b2c4cUR2ZUVhMEtIK081NDRlZlpw?=
 =?utf-8?B?NEJVYUcyckNXY1JSTEZoOG5aRGxLMWswK1dKQklZVW1GWWpreEtkOEdmOU9s?=
 =?utf-8?B?Z2lpZDNaN0xrL2ROWDU5czlkVkV3OGtsKzdaSnFUaWZ1ZUliZ0NUUG5lSnpx?=
 =?utf-8?B?UDlSeXBHMVZUaWxKRmZjR05QUThXTkQvQXJ1SklWNHRad1E4VnFLUDAyQ01t?=
 =?utf-8?B?QXQzaG5UN29yUytBbjhNRiswdzhZbG1YdFVHOVIrSk5JUmpiSkpVc3lmckhE?=
 =?utf-8?B?RDNTUHJGMkZXbGIxSFVjYjBIUmMwQzBzNmpVN3VpNDFnbWZlTUVHbUtkbkpK?=
 =?utf-8?B?a0hVcUFFYjlFNDZrK2orZVU2TFhsaksvbDdlMHQyNklMeitIaVZTRnZPOEZl?=
 =?utf-8?B?TjM0OTgrUDUvTlRuOXc1UU9wNW0rb0w5V1RsMGM4Q01BT0FyUEdBSnUzd0ZW?=
 =?utf-8?Q?BP60Yyy7IUegkwM/tiby1NtZr?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6573e3-719e-49ce-8139-08dc13734f25
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 13:35:15.0989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/YmObsMZ/NoO8P+8ZlHLiRtNifHsWvtQZiZ5f2g6hozBjbwj65679dFTqSkL+jN84BUTMtaxUtsACG/dmox4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
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
index 60d3921307..b1623038d0 100644
--- a/board/solidrun/clearfog/Kconfig
+++ b/board/solidrun/clearfog/Kconfig
@@ -39,6 +39,25 @@ config CLEARFOG_SFP_25GB
 	  SGMII connection (requires a supporting SFP). By default, transfer speed
 	  of 1.25 Gbps is used, suitable for a more common 1 Gbps SFP module.
 
+choice CLEARFOG_GTR_SERDES0
+	prompt "Select Clearfog GTR SerDes 0 Function"
+	default CLEARFOG_GTR_SERDES0_PCIE
+	help
+	  Select function for SerDes 0 which is shared between CON3 and CON18
+	  for either pci-e or sata.
+
+config CLEARFOG_GTR_SERDES0_PCIE
+	bool "PCI-E on CON3"
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

