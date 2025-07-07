Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F16C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 10:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE5082B07;
	Mon, 14 Jul 2025 12:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VxEf5e0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC1182CFA; Mon, 14 Jul 2025 12:26:03 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5AA8003E
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 12:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1dD/kw/7B61QK/YmyC9qFev/pE9Nj1+3+jTsGHbFXUw+xAQdvnilS0buVZjD2hgQPWNvIMrb82vaP5YqhIllcP0yM0S5y+qnbyW/FWDoio1IHhN+sTMwBYJ0cC2iWfg57tOgvV2u49cpaGYrsgdlh/Iir4w3RhYZaQbuQed0lVUL3eBuBQeQOStQHOxPx4fjBsSK+M3JMV9D4qwE8vhud5fisb9nHWaUCAPXcalVlqg/0XaMulWxsBuPDOlnN9OmT6dXCR+iqvQa6/R/f2f57z91x9SR3vOeY9k6F22LTTMWwAnxxGndv5ErR3rGremmnBaqLHu0aAAfjM87VocnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOLBJtvIJAuXrV+kD6o9JG9wKJ8aeucHZMANeJvdZy4=;
 b=IFYcRrn2uX+mEdfuuXOhJiPpmJJm8XQ+J3fpndl+pCL+B1468vuUsKU1P4rNEycstqWmkQyP2Y1BYgyI9ikN2XxdyR+bSpUpmoFCEYJtYLNW0Y5FeKayZ+HfdxS1WBBnvhPdMJfW/mt7b8n+k8MjMvbdUEj/7Yucnjjc8FiNn1YLzq+fJnMkBIJtHa5Gmw+jX0fhakCF3ywBYrNqPpcrYpGg5Icht08GHlaoMda6A1SAilwsi/FX82Od7URLw+EW7ZvIw83plgSu/zzIDZieorQP6FCKhZU6qQfhbaPpyE1gF74FgFbx2MZ611vB78a9UE2mvRwq0Hn95k5htKyDDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOLBJtvIJAuXrV+kD6o9JG9wKJ8aeucHZMANeJvdZy4=;
 b=VxEf5e0oL1CmK1Lpsh7XGhcutZFGCdCtRd0ruVjPmfYndihbOSEUAFhf9Lt6sPQcxr5BaI1v4/Bb9sB3pi4d0B+ifmZYWh3DSC1gDCMxRGVNNTr8FUJpPnLmEBOfZ8kxEOss5e/9qiRc9XLD6LoTiwNfFc07Vn77hcseJdQtJwgqY6T1zq3R3lnHTXJGN9N6al3w3yA5u9diBz6fvRROvMpd5e3l6zgbmZ2OAj2G55+eU1dC1Ncg17sQhw9bJLsGIbiE5RuVnnATNWZApkgSEi9z0CXpwa82g9MABZ0v42a8QEZSrCM2eUFYTiL6hQdiJEdQFTmU3SVUu1pcJn0dAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:25:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:25:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: lukma@denx.de, trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, peng.fan@nxp.com, ye.li@nxp.com,
 valentin.caron@foss.st.com, festevam@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH] clk: scmi: Fix clock identifier passed to struct
 scmi_clk_parent_set_in
Date: Mon,  7 Jul 2025 08:27:41 +0800
Message-ID: <20250707002741.353230-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: caabf64f-7df4-40f8-57e7-08ddc2c0d1b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBGYEbbLdB+h9JUdmD54oaHm4hrGOykPgtSNJFfiYoucnUDcTH7cI+Q8BPSA?=
 =?us-ascii?Q?rBSa6XxxEnvAap0myfNpj6v/AhDYweo8luDQQT0g2hduPT/CYoEYsmmfNBgG?=
 =?us-ascii?Q?Yh9SlKfD9GRcGaZ16JH/OA+nlsodOZ1WtYaADRB/HlhBBVoStkEs5yKnHngV?=
 =?us-ascii?Q?L5G/4+kuHzMaGZ8eXrCUOppBcy0frAdMA9KldRU/zpiqMmUaazW9M/3RxPoW?=
 =?us-ascii?Q?FwSN3AJpxnT32LYFZwqTDx8NgGFcrJmNKGaKu/YC/sOOLndVRbmAXYb9g8+X?=
 =?us-ascii?Q?qTAPVzdy6HumF6mcB0VXs3A5P2Q68SeZ6eCkmKniaKAGr3iU5sl1WEWIn7Zi?=
 =?us-ascii?Q?ROFXSatm4v4DprhffcJ36wcqpMPchLfeSjeC6fvTQGQKmLNO91m4cqKRBDN+?=
 =?us-ascii?Q?NUrCLXcZsaDL4m2D9ZfGswi8jnUz5bjih64GrqEqL6143gXAvCZ/aezyL3Bl?=
 =?us-ascii?Q?d1Xxxdpa2Zi5V7suU1jWJEAuNRMlglALgo+lCTNyQd/WUPJVI0Q715YAkrWo?=
 =?us-ascii?Q?/uT+zNn+NGhfkzkXhQIS4nfOa0TiGOD26qLRrndMQZkPugFcLL39vDd3b+nP?=
 =?us-ascii?Q?VPSZDjKN61WiB2PfFZhIRlrwgdMz2WJXMTCWrAXRwV5HLx8GlDUrC2IEYtn2?=
 =?us-ascii?Q?CJzn3sLv/cV4PAtS6yeUuQ8bbQ5nfdczcCQoIQ67x3CuFwBiGVPNolwl9dDt?=
 =?us-ascii?Q?MCoy0X+vzNVVhQ1f5NhTxaVBSnlLv5UXe9og/EPo55iHblVomzcfOXWedylq?=
 =?us-ascii?Q?axEy2NdCiS77k/kHPqlckJtXrqRrPwemLJ5GRAKgwgc6FqDY1QFbqjjpvv7G?=
 =?us-ascii?Q?97o5rOuXZmB02DjaF62KDRouO0Gza2H5X8qtrjRwGCDt7gv4aRa03neT3TtE?=
 =?us-ascii?Q?tMfzPsH7lleM+vDkf7caJRdXWfKqoULV9LCz9KsZxVGWgyR0nIx4duHkLs+9?=
 =?us-ascii?Q?/nikaW8NdaxWnGyQ+taYt43wzVUgYDbd+6hLw9cFVxeVtp6BveqykZlC4Y3l?=
 =?us-ascii?Q?2VlZ2gBYaoC6GzjZ/zxNZ+2HMTvJslC0svVhHmpm8EMhofJW81FG8nzNTAEg?=
 =?us-ascii?Q?bAfcJTVYR36ZGBaWiSks0kFEZc7VlP/kon3sufF1GKJXYYSzxEWm996R1Arg?=
 =?us-ascii?Q?fx0+u9Gjo05+XcL7zjKIM97D1JIBlsDwivO0LNIMt9pJWmkcfJaRUDfUll59?=
 =?us-ascii?Q?EyZolW1tNZZyVUN6wnUfSpUeXIN4RVGVnQZ3GuyM6GXUv7CrOfT9UjgVWMOs?=
 =?us-ascii?Q?pbqcFTfOWygarO0+yiKhNQN54lSeLfm1FBQKLKg7GOQnmEs4R6lntR9IQ2in?=
 =?us-ascii?Q?rVgqbgRuoP+HMJP7xQWdbWEuZmuMZlQT0CmEk4hITBMr3jGyNQB/7Ig/I2oR?=
 =?us-ascii?Q?6wCLG2ABcjaw3Mzmxxu9xhcBXyFz6nN5iZM7vecRUmaQnpnfdcxS4mUh9hBj?=
 =?us-ascii?Q?z1V1vt1U22/2XU7SKYjkLkugXFyjyw6lPi5M7Iymv4eOrIb+b7LXTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQlgOd6shN9g819kV38+Maxyt74GGDaJnsYGK3AgQZ4XTl8sHrVmmFyY1PPF?=
 =?us-ascii?Q?e3/actXJEwZjYncaCzHFZcLf1D90MZhwjyG3upMTjwsVW2MPv5yV4HVel9vp?=
 =?us-ascii?Q?DYOvv9ipRyPlteJJxals+9JtnU40Gr6HtC4lewyBVQ/eLif1/8jMX2INzYVl?=
 =?us-ascii?Q?YyCxbTXRYOcaB0AOktSq34Vv84quH41Mu54a3XlA/18lQl2CamEe97hd5U47?=
 =?us-ascii?Q?mCq6kzWejf356BMkrNNMCRloHXA2YQHihPgH+4MRdHIKMe1phhHxXrTPxQGO?=
 =?us-ascii?Q?bBGEnTqBW6ckOeBZIbqSmcno7lBo75GR2heLZXFU0/D079UkFlf05WoqyO4M?=
 =?us-ascii?Q?9kmYbYu+skDxX3RRWA5UiZuADjFDsdg0BAT0yyDZ8wGydvBWiBK01E+TZyyN?=
 =?us-ascii?Q?ka2sHgm2Nn0Z4p29ABGsDEhDn0iP1bmZtAzJk2/V35JXCtGUiVIiycCL4Yho?=
 =?us-ascii?Q?eZASLLdJiSC2FO4BIXSMFjAk2qIZhr3Zl7dPwFWAgEPLPNur0fIEV6Fm4373?=
 =?us-ascii?Q?YFav0mi8JLsLfLlfaYEDHQxhHZPdTY5mBhz23wfBZ+Am4LwgA8ha3lx0i8GL?=
 =?us-ascii?Q?nU2HTGMpZptEfG26jkjaEkNZnauHkpc9Hkvp3q5umnbhHdpNWNHW18eBQyWW?=
 =?us-ascii?Q?Z3KchRPFGWWqW3RmlevG2BsRuN2T3Wud/W3ZEaBU4fjGw1977VYKRIXlqtpN?=
 =?us-ascii?Q?iDApuYVDqLI15LKm1HYgShq8Ia+zunPrW/8PDl18gNjxSNg5PrGuyueDAkIX?=
 =?us-ascii?Q?3e5JzyVH9hKYabrJFQecYFQg9OGr3wb/GALTlnfwodysVbPhLfKjGcgIxaDw?=
 =?us-ascii?Q?tMfJYZy/82x8y5mpxfXeUDH5tX3bq0z7gO3PVN39UJcmvT+DEt1IU5uX3E0p?=
 =?us-ascii?Q?qmgCpF45XI+NQT4WqSw0+YRBNnjfoWZZxzolFIg7s7fb7sctcECSDx3npLUv?=
 =?us-ascii?Q?5U+2IQkjecxjls7jOc0y599rOkoQHNYVHrR5lhxk+MWd/pmQN3qv9mTEmv0S?=
 =?us-ascii?Q?Ke2mBFAhY+Q8Zl8RHu0soALGecNQLIZPx4XsOBtp8YB3uRi6ts5rshF6rx3S?=
 =?us-ascii?Q?jKvzrkSR2w2AEs+bVYfBIf6vKtlSlwsfU0VnWHWkhpt0EVXTGvKZx7mXWTcQ?=
 =?us-ascii?Q?dgoOiPBfyPAxl4mIbmfETQL3JxYArDTARXppd4uWjwLn9J6SlS28Ij0B/qjJ?=
 =?us-ascii?Q?jBe6iDSo4+BlbrfAfJwvKrq3d13x3jUxyWTvV9wPoGVjSTy0WsZ8dUAXGWZt?=
 =?us-ascii?Q?UXkxtaJ65fK2Hcc7rXPO545EFVL5GlxUdAnt2RlGtz4zDtQRF7LWaRtXojDG?=
 =?us-ascii?Q?pXPCzoBozeXNRWsnckkGk9C79B1L5y4ugZC+Ase2Y5GhckQAxxNS68ZqI2N/?=
 =?us-ascii?Q?XcWrR/m4ae2ynJJtyVh8Q0g2W2VvyGO1MPy/VcVUuM9RLd913dLE/sSTzRgX?=
 =?us-ascii?Q?A5lWibbcd7Bn02V7+bRvYIk/NQXIQTSQAIp4uI0IBf2iFaQP7VASL6jq+DSn?=
 =?us-ascii?Q?4wh3wY95eFdgg01ZgrNSGgqTwHFokQKtI36MeXSEtHxiCxtuWz7AYVjaEPha?=
 =?us-ascii?Q?3SU359IVxc2TGL1F+yRNyFy2vO/GQ+18CiWKmeW8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caabf64f-7df4-40f8-57e7-08ddc2c0d1b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:25:57.0156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIGxjxpTVlfDls2eywtN1fMcZ0lKrE/5Mv2DB2EBBh02cxGqgPICeSo9X7srMDRqIG6c7SO3+yzTX34tycbeCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
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

From: Alice Guo <alice.guo@nxp.com>

Clock identifier passed to struct scmi_clk_parent_set_in should also use
clk_get_id() to obtain.

Fixes: aa7bdc1af505 ("clk: scmi: manage properly the clk identifier with
CCF")

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/clk/clk_scmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index cfb372e6190..0c9a81cabcc 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -336,8 +336,8 @@ static int scmi_clk_probe(struct udevice *dev)
 static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
-		.clock_id = clk->id,
-		.parent_clk = parent->id,
+		.clock_id = clk_get_id(clk),
+		.parent_clk = clk_get_id(parent),
 	};
 	struct scmi_clk_parent_set_out out;
 	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
-- 
2.43.0

