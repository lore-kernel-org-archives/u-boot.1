Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72693103E2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 02:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F86E8409A;
	Thu, 12 Mar 2026 03:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v/eJNW+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925B78407E; Thu, 12 Mar 2026 03:17:46 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526C48407E
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 03:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzxYpioHvxD1fNXXJarxZ+wphqIjrmNTzVLhjwIMvfu2pcFYq6ZjdymBIF/FfvHqenJTkWKhiERXGpRnOg1gHL8pokku+4UBxWl21BpZvVpQFSZhZRBeMpUe9DWdE7AkPAfUGAm21VPHEDTf3SJE1MeZipfiTCKoq0F4BHdzL0CgqBTqj9MeYcatFJSI+/uL39hdhi3LeZV0/uyjv4D5WnV1mh7EDjt+l8Xx2X4WlTJiV43rC1kEISct/UrEoRjVjFD2fHeqkDDXooz9EPGcqhviGJRZUK0yEbUK/qgfz8W156T8KozgJfz16Jp7xc7BhnH/8OQaeH3ku4kU2eaw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u97pfaJC/SCV6FAwINxcIHRJVmlXWCg9lUJDip/h4sw=;
 b=cnnXcD+iP3sOLqY3X1lG5e1irILZN2xKdi5rKda3cLwACrauVcOAPfMcD8VWuowXBZFFx5J1W6UHq1J8RYeD12jk1spabx/Z1bX+EeV49/IVArtlmOhDa7VYo9eFOWMZB8DfD6Qd6MwJKVC3sfacaieTYFSaTM3U7ktSydPNgOiOKFg90mT+0I1Fp4P1Z7UTCxXcu0mQ8wUKtjEATvpjB09+hHvCWyMBogaUZdt1+UiRs/DnwqRzAMudrttedvrKGj11LImPoZGVCHZcLuGbQ9ZeH6VeNYh3+z+shdPahD2wby/SyTOz6/yI7mXU/sDR4sxZuJYS+JLM4iUDM/ZVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u97pfaJC/SCV6FAwINxcIHRJVmlXWCg9lUJDip/h4sw=;
 b=v/eJNW+3L7etx37i3URieA1H0STzKkKN4a59XeZmK8v548PquC8pJSk5O9h+BNmLPt3JQEjwV6l9vCtLibS4/UKsmsLBHWwzV6dp/vNem4kiXIRM3/rL6r3Q4Hk2psPyUWfrmT7ZvdzWlv6WlH6qX3Ev3ul6dvYkHrqVmDOjXFzIEfS5PBds4w2o523ygVSWkf1AKk1E68Hp8yDQC/0R5GkLQeKe0GbGGj/uhDvrZpAcbFQmjYJSTRNPOy7Xaxypf2wHeO8Z74zkQ2eXGpe1HuveLsLD4H6snliBx/LnBTiuSei0LHBdfc+PgfwRkzTSDr7zmIP3ODDbrJT1l/NVjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by PA4PR04MB9246.eurprd04.prod.outlook.com (2603:10a6:102:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Thu, 12 Mar
 2026 02:17:42 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8735:53a0:b36f:f559%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 02:17:41 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 12 Mar 2026 08:57:24 +0800
Subject: [PATCH v4 3/4] imx94_evk: Get ownership of XSPI control registers
 protected by GMID in SPL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-xspi-v1-3-375b8c444dbf@nxp.com>
References: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
In-Reply-To: <20260312-xspi-v1-0-375b8c444dbf@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To DU0PR04MB9636.eurprd04.prod.outlook.com
 (2603:10a6:10:320::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9636:EE_|PA4PR04MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: f0430dd6-dc74-4dbf-429b-08de7fdd89bc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|1800799024|52116014|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FI5IRugbjwFbEUYtHoJjSwdnQ67N3Jx+ArWw66QOGZUVgi4P1BMYhWIwQA4wrCBdWfFqbi2TUJXd6qSm/L0YamPwam7GVxH6OKwUqUzcJ0rz3fkJMHst0am70DbS65IXH5RWTDYKlA1pJTSqSgR3RKlrqLuhWSTmyqxG5YGkzYMDzIYxt56F0GZBIu4ER29cEnljSArwYxzLygi9rIpxknbFqCKFDB599DUujYLBus1W3EIe71CDbtxNGYRMS5tFJ1hgdGklhvwLD6fEx7OcMhCNK1A+zTN+WcBaZba0p1L66Lz75fQ2HdxX82EqvibJkWcisX8tOfSS949gqWHCMJZ+f7PNlTqg9WpgAIYwHcxTZK5xLcLNvp2HqE187sB8VR/ltWdtikDsuZ8FErKqn6uVwIi4jTkQ+y44BN/T4fXrli+UlcFuSvjDQtQeG9pBdA+q8X5zYI4j+KLiiDt5t3zG6SlHASrN+luRMleaKKkdPevAR0O0HHS6uq4KCUN5ppH/LgoTC+dN3w5Vxu+P750IFejAm/M4WPDq2kWVRl4C1WViFSLBxBn0gYxY/EdkRq0C1pOvtM8lUMQImaSmMK0SnzEGs0/H1fXwb6EvIQJer5WddxIl2qByjOTMZ48IijjR8XbcuM9uxM18YUykBPbBrUxILw8/A7xyKBkAcvR2fqGGzpOyoAmLjS0/s67TRZEll5u/ltZwkhStG5tDcqCDlsDIbe7/P76p5fWsb+tcxEp2AhSLNuP1Xy7B0w7tti4bkJINSeyIQ7gYEw4T9kB0lsH6uZG/sSGeQXOZ5io=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpXemRyZDFKM0t2NTl2dWVOTXdXK0Iwck1FcE1NS0ZQU1JQTEsxYWNra2Y4?=
 =?utf-8?B?SGlHeWRaRE9tNm1JM0twcmp1ZXJnMzh3clEwdkM2dVpIYVNSb1ordnBSOEpS?=
 =?utf-8?B?Q3NVRHVZYnEvOUZ0RWFwRVhoamk4N0htbFJtY1FHNlI5NEg4S0xkS0ltdkhz?=
 =?utf-8?B?MjJaSVpZaEx4VDVrWmZpQXFNWWUxWWd5L3pzVWRIQytBcnBnbllGZzlTc2xi?=
 =?utf-8?B?UHBJMlltczhDVjAwcWpSUWRUSG9WZk1oa0lOK1kxYnhJVkZzSVdCOGNWK1c0?=
 =?utf-8?B?WmY2c2dLeTVZcWpxUDJOb0V3aDNFWGlPRU1SUisrSk5odk1kWFdvb2JBTkZJ?=
 =?utf-8?B?cHhZSDdpSVViMVFnYkR6bjNKVDJBckdYS1p5WDZUN2JLOGFmSXhFZjcvQklz?=
 =?utf-8?B?dVI3WlhGNHNKTmdYYzZiRm9UTEN3U2NlejBNRFRrc3lRY1hqY2VISEQ4dk5v?=
 =?utf-8?B?WEE4dzNScUJuL0p5ZDc4WFI3Vm56b04vNWQwOTNJK3F1a3VNcFd1eEEvZ21z?=
 =?utf-8?B?SlJndUdJUERUc1pINlB0WVlGSzl5SmkvMm1qR0RrR1RxS3ZBK0NxYWFLRUtC?=
 =?utf-8?B?cG4yZXd3NFZ0enVkdUlvdUh3ODJIUUIxZ0NRai8yd0QySlpPOXhSbm9OVEtX?=
 =?utf-8?B?Vy80dlZSaStFTDZRR1FoMmlNYmRJcDljeFpXOU1wTXAyWGtKcVdmRjU2Z3Jj?=
 =?utf-8?B?TFJFMnNzMzJwaDVYc1YrUzNWelJNQStoWVBpWW50bkdKOG56V2Evb0tibTlH?=
 =?utf-8?B?T29TWXloSmduSGJYVkc0MFVuQkN4QndkUG4xRjgzZjMvYUJXeW5FT1JpNGp6?=
 =?utf-8?B?SjZiTnlFZTZBaTFxdHIrY2JuYkxvbUN2RHRYVmpqa1dHSmlQQ2JrcklBcWRQ?=
 =?utf-8?B?U3hFVUNOSks5bjBaZng2KzJ6QTJGcm51VFlqeTBkN1l4TzJCeDEvZStRVDVH?=
 =?utf-8?B?cVhSZXVmR1RHNit5ZVZiSEZVY1ZaQmpIZGN1Z25uNk0rdkNUOU5yQVA1SWw3?=
 =?utf-8?B?WCswMCtUN0NBMXBWMWsvREJGTk5KUnc4bGdJUTQ5bHcyTjYwOXNkcWx3dGhB?=
 =?utf-8?B?UkRXTCtKK0lLcGpZUzJOZHpUUkJrbEdZMWdFd1hqbGUwa1NvTm1HUjlzNjJD?=
 =?utf-8?B?ZDV3THJ5R2Q3c1JaYjF4R25xMWVpaTBoN2w3c2ZndkVZTEJhdlc5MFB5MG45?=
 =?utf-8?B?VHhXN2dOUGwxN3A2bnFneVh4VEs4WTBkZmZ0NEYyc0pOdEZRYTNsZVlqNzBB?=
 =?utf-8?B?WFZNY1ZldkpPQlZlVE8wSmFxdjBnQ0VtOHJXc0hPSDdoTVhVTUg1Wjhoc1Fk?=
 =?utf-8?B?SGhOVHdIY2NqNXZCTDY1SjMxYnFXaklRVm1MaG81QUN4Ly8rZUFxb3NkUThk?=
 =?utf-8?B?cDBCM01TNXZ1M0NyRjBzelk0RmlsNE9Nb1AvR2lGSmtuYU1nRFR6U0VQSXli?=
 =?utf-8?B?dTJzSDNnSWdyMUlpTDJyYitXT0k3eDFsWDV6UGhhdG9uQVUwaTJBRDJzZXdM?=
 =?utf-8?B?dFZnL0tkQ3ZIRE13M01CNjNrTmM4Q2p1d2NHWDFYWFhZV3BmSDRvMENDc2ZS?=
 =?utf-8?B?dXZORERrNmFXQnU3RWpaeHRCSU9uTkdLVE5oV0RTRjFjN3cyOXFrd1ZPUCt3?=
 =?utf-8?B?VDVhT0s5cjBqR01EaUV0SHFDN1FJUVdNNXpoQUFZY2pLWUx2cmlYT2xpTERT?=
 =?utf-8?B?YXVHY1R4YTl2dlRLN3dnZlo3UXJwTi9qWmVsNzk5a2dmNVFJamt6amh5VTZr?=
 =?utf-8?B?Ni81SFpHdWc0QjRvZ00vZTNuUVNsZFI3ajlmTmxaVTRCQ0U4TnFLdHVpWDBR?=
 =?utf-8?B?dERlaU8vS3NaN05hMXgvbUEwM0pSWGhxVkhxUS93Y2tWNUJPTjIrVFRyY1pX?=
 =?utf-8?B?cVhnS0dtMFIybEtOZmgrcmlvUUFIdXNualBhbytzMjFLVnlWZFBydmVVVXh5?=
 =?utf-8?B?WHJwalFmNWd4ZUdwWm5vNHZSNzNFVWNlQWxIZURlQUNFYXJRZUNsOVZIQXNL?=
 =?utf-8?B?aW1ic2ptcVJIUWdINVg1UUNydzVZSXE4Y3V4ZzNqQTY4THZWZ1JMdVVSQ1hy?=
 =?utf-8?B?VnFQNHA3d0hmb0RiV3dUV3ExNEg0MmxVdktRM2paNGFqNVlFcTB6dHNzeXhH?=
 =?utf-8?B?YmllVlkrSlJLVm5OM1JtYXpQVXdEL1hhQnpxZnVyL3BnakpaY0RaelNTUEFN?=
 =?utf-8?B?YVo1emdNOXlPdTZDZmNZM09PTFIzWEU1QTJTdFpFWW9xdGVYcEtFVzlmcStR?=
 =?utf-8?B?TDZ0a01HRi91RVA4LzFsWVRqWnNLZXc0UDhmZG1wUkxzRDY3RHBQckFPTU5Y?=
 =?utf-8?B?QU45eHBOZVM1WHh6dENKWFBEaHg4aGhRZCtxOUZHV01iaGpFellUZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0430dd6-dc74-4dbf-429b-08de7fdd89bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 02:17:40.9872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KNgDDfrZQpjm7GdQHszDKwZLYlQJ2qz8cWoL5ErYucP7K896WQtYOD0jhsJSiiMyhZmCCQq5141X1M+yQdn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9246
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

From: Ye Li <ye.li@nxp.com>

To gain access to certain registers that are protected by GMID, the SPL
must release XSPI ownership to the current core.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx94_evk/spl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
index cc5b7f9ef0f..6eb0fff99f4 100644
--- a/board/nxp/imx94_evk/spl.c
+++ b/board/nxp/imx94_evk/spl.c
@@ -46,6 +46,16 @@ void spl_board_init(void)
 		printf("Fail to start RNG: %d\n", ret);
 }
 
+static void xspi_nor_reset(void)
+{
+	int ret;
+	u32 resp = 0;
+
+	ret = ele_set_gmid(&resp);
+	if (ret)
+		printf("Fail to set GMID: %d, resp 0x%x\n", ret, resp);
+}
+
 /* SCMI support by default */
 void board_init_f(ulong dummy)
 {
@@ -76,5 +86,7 @@ void board_init_f(ulong dummy)
 
 	get_reset_reason(true, false);
 
+	xspi_nor_reset();
+
 	board_init_r(NULL, 0);
 }

-- 
2.43.0

