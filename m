Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A32EEB364A
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 02:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149D883F7D;
	Tue,  3 Mar 2026 03:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HGfFuZeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE70A83F2D; Tue,  3 Mar 2026 03:30:59 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2078B83F82
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 03:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia486Pmv5RfAfPdA6obXFkf0uHHELqKoloepUZRMfvOiEqvQ3MxIs2x0/PhxKBw/aZXg6ttYBDJXkgSOuAX4pzIpN8chWAtmK/AIgkuGtBTJqR9IJb10YHf9IYqStZ7rIKplLxUBOdWBpGaliuzTFom0SIc15qanQAhcP8tI3xTJ5okbs+sZmNCYly3y6cwNahnuMALhCF3sAYuppRFpH4y18tH1J/3ifR05N84UB6RLbJI+qiQxOYhpb2C3dlRQNYr7QMNu9eDMRHWA2mFs6lnFNu2OSJGqYSZMnvfGrBt5GL9m67bIM9XGoFDitBfzuy12tPrPWW7M02Z7J+RqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLlsoLXv6QjdTe8yidsL/7pEEjCY/RIqJOc1TLKNEII=;
 b=fDtKmJEm8rOWGy3m12CoDNHh6TzIdUswvZwM6JQjmdaOLw9Z6pgnLAJWHoceJr6BFhtd2hDmLh0vPtdonYDta6OBnyyDlEVj1pQjIT9FuVKeRGemph+cm1wm4BIfU/4E2+mb3gk+2eyt4sFbXYAIToY6Ggae/bPX8DKsOG2pqerFJUseQm3NlQ60UsqIopC/tCZA6SDM64qjnLKA/OXIb9icR3xJHLB//rsC6OVHdQNPxtQStTb+fnlmlbE22RURMAQpoxncRJiEn6ZA+IGqerPH3qfHHBSyBwfxXT1V2HaFoRfGFUyhXZvRoL+WdL5y4ovf70N0jHXMUTPhdejMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLlsoLXv6QjdTe8yidsL/7pEEjCY/RIqJOc1TLKNEII=;
 b=HGfFuZeE2TLpkNweYPcpBSGVeEShE+FuaQlYd5PnuoLlb14ZdQ12JBEkkf/59+Wv0pNDoI7ppOrd3sDXWk3AjcHNODymtwCrIpmBmVzS8RNAUtdyg0PSNRPMOs1gnWyHRtuUYA7ncgmLTxXlpWS4Mo7lCe/IoHP7dwXHW0+AuPZA3yXH9cczNcqUJnifiiaNyXwGzUGS9pplFrM38rA3bkHI82C/tAXhGnxEyiGdcvarL9Q2xWgGRZKqQLE2KBTQI5bOcqj5ygCUylxGdp5vsyGN2dRb8cdqs0o4Imp6+Fu3Rp6jULsmPJRmqJwBDpLvWBY0e6Ktv9rF4s7l6sSaxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 02:30:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:30:54 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 03 Mar 2026 09:10:28 +0800
Subject: [PATCH v3 3/4] imx94_evk: Get ownership of XSPI control registers
 protected by GMID in SPL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-xspi-v1-3-8383ba6fdda8@nxp.com>
References: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
In-Reply-To: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d16ca7b-d4f3-4400-ed93-08de78cce511
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: QcwPHZh6lhDMIjF1RN5VwZIjwZQ+zIjoZIS98A65jaJbsiYM2kkBdWRPGuXVCoVEAciNrkEGwon/7kchqw+nbgnZfLYz9572F7sDfdbrOQtyqy+z3QCWa6/aAtuNIBZFW7NIXhARy+ow1eMk+9IDOxrICmGLr07YHSptm6Fblu7KMKQYKyoIhHNLiuvaHi/42tiyocwR98xjE7VaiZnTt9HAzsJ4YEs1LEjWfIWLhISaa55UTR41JP5C1HeK5ehdyIbc0/i70/hJD1vahxgp1HCsYbBxD0CCtsQelbQVVtuH9mlbkqcCZJ93hd2xeyfhr7Gng+N4Qc/neJQmVnVnmztV+KkUd7j6HKrB7qNQw4gTKgn4Ytcz0TKj6zio9qVvgBPEQzL6JZKjGVkDgkfP23JeRa8bt/XQ5gnersco6F8gKeOOnaSwoauAcoanEymhH0+IfGYYA2YCaDaEstnIRoSjB7z2kTEa1IOANOeRCNp3Dh3235/H4wK6FkoHMLjB8c1S5GZpCMMMrqY5Qrz1Y/K7Phuc8hNAvmxVau/FDR4/9D4ZV8Gd+sBAEK3rik4edqxw2HOa+9YxbGmTuCtiwL1OnL2BD2/dh2QqAhfFyrUjF3R8+BkFpOw3C/EquH8hmlqfZ+Phj52q574yyxz/4T818S0QrVlsjuwj5sD1CUxRjt5ulPxCxpnJMCyVJpBuSqa12wYmmiwPEQgFElXRw9Zi9ClSZqKDeUvA1a8LTRTgB9IdFK6V85XzZTN7CGphNfnZaOkKFI508wATy7qrcNgYtgYFYkXCpsE+aYbiqY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEErZHZWVkJPcXo3YTVjVVVHK1RmSWFxOFRpQVJINkVURmFyVmQ3bGJHbTRR?=
 =?utf-8?B?ZlZYcUxhKzRrYkN3Tk9kTUEyMEV1ZHRlWDZwZ3krMVdBR0lTdWpBa2Q2cVR6?=
 =?utf-8?B?U0FPeGtmaFpQUDFMMnpVTUc3NklvcTg5bTV5TGo2ZGsyTEhJcVNhUlFvaUln?=
 =?utf-8?B?K1NSVlBFQXB6V0VZTEthUVlERFpqZFpwV09TRDNlRENIcjlNNHloR2VYOTdl?=
 =?utf-8?B?U3ZnRWJsdGZrR0RNT25IeitEQkQ5OXMvMk1peE14aUlhUS93SEQ5ZmZxb3BO?=
 =?utf-8?B?R0x5RERTdkdEZUhCYnFUallMeXlWQWg0UDAzRW5XM2hROFBRYVEyOThPM1BM?=
 =?utf-8?B?S1ArNHplamtTMWNCNHQrRE1hSTk1dGpoODNKQ0crQ0E0bmJWeTdEVm92dHdz?=
 =?utf-8?B?YnMvZzAzVW15Q08yKzBiYnlwNnBybHVtd0dXTkZ6ZHBFZGJkblN0VnZXeGRN?=
 =?utf-8?B?L1k0dUlPdldRZVN5ViszbDc2dWxtMitUbUZ6T3RCcEprNERwS1laU0IyM1do?=
 =?utf-8?B?bG5iaWhVZlJsQ1BjSFJLa29BMHJxYlpGRU9Xak5XRzczRnJtQmRkMnI0elFp?=
 =?utf-8?B?bW56ZFE1cExsQkExR29XRXV6cXA5cHZOajFQVUxDR2dGYlNJYjZpYUxUd3Y3?=
 =?utf-8?B?NGRDVUNxVkpFL0JsM05lSTB2LzJydEN1MG9idS80a3J1YXl1a0k4bWQxL3pS?=
 =?utf-8?B?eUdCQ2pJWTBBbVluZXJEUEEyelIxbWVwbkphMmczUHVpZTluZ3dDckNzWEZK?=
 =?utf-8?B?ejV4TUhpa3VTTXJsZ1habHR2MUNtU09IMVZ1cTNKK3prY0w4bjRYS1loL3Ji?=
 =?utf-8?B?dDVjdVh6RVoxUmtGRDVZZ1lncmgyMWxkQjZmS3IvZ2p6dm1YWE9UejhXVVRZ?=
 =?utf-8?B?ZVlMcGluMkwxOG41VGF2bWE1VWVrOFA0UFJEVlFGcnZjdnRrVjhYOXIvWGtE?=
 =?utf-8?B?Wk9Qdm9IK01lSUZ6b0lvek9rVTZxSUtTUjJ2RzdubGtMem9wdjlUdVRqS1cz?=
 =?utf-8?B?Z2tBeXRKdlptUStLVHJUbDlmM0VCaFpjckVSeVc0SWlyNVlMdlNRVTc2Y2Fv?=
 =?utf-8?B?L3h2MElScnJFNXdhbjZaNldmUDlvQXozVnhuMjNSTnZ5U1lqdTJQcC82ckd6?=
 =?utf-8?B?SEpjMGZ6d0lLcUlsZGp2SkJoZUNwR0Y0VGFOZ210a3AvYkVlRTBDclhWMWVO?=
 =?utf-8?B?OTZQN0Ixc1J6d1I3VVBHdnVHMkQrck1sRnQ1QXNLeVlYRWZ3a0h4eGx5dzBq?=
 =?utf-8?B?TEJGNTZaZEtWcEttYUw5VkFDQS9yVStnejFTMm44Z1RZeGtBbzJYQlA5M1l5?=
 =?utf-8?B?SDF2UWdLYnBudS9yYU1peUNwaVhNUVZSQkREcFpaWTcvb3ZoekpTdkt5c1ZE?=
 =?utf-8?B?N1dBTmgwZVBJeHlBeHlYRVA5WTExOFdWeS9jQjB5RkpKSmg3L0EzQnQ5a3NY?=
 =?utf-8?B?dWo4ZC9vT0dFMVF6QTVzNzMwMGp6OUFTazN4TmxxOVVCdVA1YkU4Ukx4S0xG?=
 =?utf-8?B?cTdMdXN5Ukk2TzQ2NWF2T2d6Rnh5eFZtUHdEcUxLbnh2dTVRWGJzTTNuSGo3?=
 =?utf-8?B?TXdUN3VibEVVYjFRTXhTMFpxWFNLRGE0aS9YSjBuaUkrajJUWkQrZGtvRVB2?=
 =?utf-8?B?Mkh1NHFvYW1jZjh4Z2lBa1kxSFFObVRuTFRHM1RhZ25IMWk4SERnL2YrYy8r?=
 =?utf-8?B?TDZTNm5aUlJHWFZQYlVJTnhXU2dDNEoyWXBkWDJwUnlhaGpnZ1NIMndUSkVp?=
 =?utf-8?B?NzRTdlBjd01kOWRmcUQwMWF2bVVqOUR0YWVoZUxuUGF3elI0RXdrd1g4ZmNP?=
 =?utf-8?B?YmFyM2YzSnBWMWtvWWpaUTNBVk9XWHFSa2FsQU92MkZuZ2ZSSzZFcmMycnl3?=
 =?utf-8?B?ZEZSUUM0UGJGb3VkSXR4ckJYL2lpQnNMWnpNY3VqUnZLbHdHMEx6NmFUZUtL?=
 =?utf-8?B?RUp5VzFpbFFBbWhaOW5iaDdhQ29LSDBnVHRvanAwRm9uWFgvTDJuR2Y0UzNh?=
 =?utf-8?B?QWVKMGRTYUo3YUpyMlp4R0pjRXljV2pLM3Bqd0FSbm9YcVBlSjlqSU80eTlG?=
 =?utf-8?B?ck5GVkRIeHh5WmdyZnBhZk90OGFzZSthOUJoUVZYR1cvVVM3ZFA4SDRUUW1Y?=
 =?utf-8?B?TkdMWlY5VVpmcXJocnlTVGRtQktRamhTNmZHU0NKcysrWS9GTmZ0WmRZQm9p?=
 =?utf-8?B?SjdVY25hV1d4YU1pNEhpKzRkVEsyTHYxZzJtS0FaY2sxdldXcWRUVmNMT2JC?=
 =?utf-8?B?WDFRNUxWZUludTBlZmlOOG11a2VRVW1KelFmbFlpdXQ4QkFGc2tKS2pyeUpN?=
 =?utf-8?B?amkzOWZadE9tRExhd2YxTW9RZjVjSDBSUHlVdk13VGtBdHppR1NPUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d16ca7b-d4f3-4400-ed93-08de78cce511
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:30:54.6238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSgg3ac1xXQ0hMJ2wsJV/fqb82B6RjPTnXOT+X2E7+TrUcgC9/b5DutHFOD98mOQlGRpujkL+1P/QH3+NmEGtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
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

