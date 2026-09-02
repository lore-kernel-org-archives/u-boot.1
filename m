Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26E9C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA5F281000;
	Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZcNch7yHUKZa; Wed,  2 Sep 2026 08:54:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339236;
	bh=sMKIjwsim571YepwxTDyk/UrA1erfDRWl+bPZdhL9NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MZ7G/Th15IyZp+MgsZscRKDG6kM4c5zd73tBePpiryyLkUItvV/nhkza5grxh92xD
	 mzd9IuWm5xoJgOo53rby1tolWDVgeQFwG/JBtQMIztt9hlxghQKi4GVJoX2oi3ArZe
	 My0ux9JMBx/b+FrrlW07dar4I0HrOv34TGPmwSUbgzxmYcegzLHDMzrxYJKmmDDv3r
	 aqocJmV+kwVylAQfwyzVDA0+gl9ahg+K37mCKzJOESwlO1LXSIOHdL/0/YV4wGK6wi
	 85Iflmpu3QhJw/8DWYvD/llJlPfjROHN9puYH8BN1jSNsVqMF1tNKtzd2wmZf43VH9
	 gbxakN150VsZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1191980FA3;
	Wed,  2 Sep 2026 08:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F3572FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40F7C40310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jIciO6iG7a7b for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=mxc2VhlX
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F9364031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylyZlfqDG5oYlynwcB/8YZ2pV6G0RmOF3QeFl32ue/zRZcXZtJejMmwSvIcsSvXMl7RmO98U+2KTXu+giV0WWcZGdne2/OCWtJne1q4v9PS8stmx0BPNj/xYXJn70hBVCbjDfFH8olnMwQtSR/VDh6oYBlbKA/q6XmBAv2uOHbcFIie3zhvSuEOQUjrBvi9JyaLqvE8ZyW9lam5H0H49XxCwwBHQzNvBGX621WXwUNO/OeRT/abk9WRQY4xRTUp77DmLlk/RMaNtFLYj8cSSnoEiaVxNtJ4ISAuShBP8B7ha52HyqSh/j22d2UQrZPIOSS8S6jaz+G2vf9K1iEVDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMKIjwsim571YepwxTDyk/UrA1erfDRWl+bPZdhL9NA=;
 b=bsz0QgsawyDpX/xUK4W7w9IhMj+AdWmeVNJvekCYxh3o7vbX5gkY4QgrNDHp6VzjHFfhBHZxiTzeJdYdp0v4meZ+NB2AAXQUzza5gnqd17kkVqwLd640FhKF+6dR0/P0pf6DRy6U1RUxQ0P/aMl3ZbdX9hd6f8VKDZuxFtJM/tpXy5zbmSei2vuS0Wcj0GVvO7jGxV9elCmZRd17HAF0TX54st6sQw2yobD1MNql69gWPh3a4a0u7YIWnXmhN4EY/cTXsOgnXt01vPfg4XdjAvxf0EpmhoCs3ehhZyfPZUSPbvOifnJGWXzDmPnj9B+MvBqTLQLyAYQfdf3zW66GRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMKIjwsim571YepwxTDyk/UrA1erfDRWl+bPZdhL9NA=;
 b=mxc2VhlXWLaviwkTSQe+Bne7WoYY6p4Iqs2ohlebeHq/0f9NDjEpHooGdH2pOs7JUtR9Xdx2wHJ03F5djp2LZLSAqsEToLnEmCcpg4mnIwuMxhWK8+ojtPqRTpG+a6ZUHzCEgwYATzUfL+cH5D2b0eU044LmwqvTtz+HP8YL/7VuzfZZUcch9rO/UBMI62x9MKn2ppfX/Hf2XyjBSE2VJHCIdFkp0Jgv7GhZl+hpXF9Na2WD7+XXd6c9stBeJ+diYFoJpuc3asqTk5fXged8XjEuM+zQ9ONBPgUhFlBQV5VcNikGNpSAkLfZI61+tdqU6XpRXwiS+gBRDMJ8nwPeHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:48 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:48 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 10/16] arm: dts: an7583: add mdio child node to switch node
Date: Wed,  2 Sep 2026 11:53:05 +0300
Message-ID: <20260902085311.1550804-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: e355a992-2207-4b87-614b-08df08cfb42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9MJ5ouM8K73+P9Yu8FxU2YDMo/8FNIA5+DmKKZlH322VgkeevtB0SKPPrCu7CQsyd4e1gZ1t+GKuF9oBnBPjR/dHT+b/0EHaH5lqh5iwBYdsyzHEV0lo6dqP8GF3jbBS1xxbLdAk6tZ7uU0rD3CfJHw8rJnHhuo8JjK4k52wcZJX/p98p13BKL/uM87X6QXmfWUWqZfwqBSYRskDjJ+arlA4bqLYmR/FSR4syqrN5Zur6F97jB1xYSmgN56xLYLyW4HWbI6TFpXdrfPnV8lNXTBTDqso/SLadhQRZ8sSzAziYUA3FY6zQR6mtX4HtL1vYMnZp3TX/4ixmMSvC/3kBB2vzqbzhDCd6lobGKf3pUbTB/LTHXg8AyfDrxfyjh9L/H/q2RRfNeV5P9jGKIMLDxWxochgtQDYKnm5v+3Oor+A5Vsq7ZIntjbgn0RoYCOlWkQ12WWXt0zmfBCGwJZ1uFxWaljaYc0uMQI1qlZ2mqx1tPjkIUsQFSdqBTd3K49hPOrtqKIY4j7LPkS1SISCQrjfUWYN01Xp3q6tf7IWwMx1WDAKxjVV96YMQ0yxzqih86udwF9iK5rmX1FV6aY7EMQBdm2o8njQdwWrZdaNKpUHUbOctj+H9y0gAECXy3iyc/0vLUtbl5jCABiO3HB7jxU5kXDuIB/mEAHPPH1t9kQo73wwZHZEeZ9JsVoRovRI5gL0P+G/9E7Hz+JSKwdKMucokwnk0H/rOv0rpB8NtfN1fRmEycJfz43sSg7ebtET
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R0F/5G5xn0QpXAEer05FI4zh44J+ZvbWpINgTp5J1X1IGnOSeSx1nmqx5JRl?=
 =?us-ascii?Q?Q8IsSKPJoNUH/PpCa4yIAndTnka8zhTrSu4m24EK7kv3U0ppvtKC4z2YSRL6?=
 =?us-ascii?Q?lD6jONYeYUxFpQ+f+NzXo9ez+k5SgIAGwfPu+NDqzUgVkmckXdnRrA2prKHP?=
 =?us-ascii?Q?GjPCOpHBLmBc/qAT1AzWupOKJWPuut4szfSE5DrbzHqLDf+Ja827m0xzlOxl?=
 =?us-ascii?Q?KmpdvExNJMo4gcAB5RkWHIqKFWzBiM2bD3hUOrEi6ZuWMYQ9k+LT5fpJEkTd?=
 =?us-ascii?Q?AICbAqgHGIY+AElRzfMID1BwM8pj8dZbo9WNyWG8Xfo1TAVzrC6xqHNBdP+2?=
 =?us-ascii?Q?PYaFW0d1STzKEnObbphsvdpZjuHALTbiFGnFbgYGZkW8fchaWPwT65i30AYu?=
 =?us-ascii?Q?V1DSezAo8wA9qFCItQM5lh1+2g00xl+vvjKAmETM39zepTbre6KjF/atV0iB?=
 =?us-ascii?Q?omUdyzZ1u6R4yvntAJ6AcLE6wEDgb11tvTzZQVTT6hXH3FSCHVzJo0xljkTb?=
 =?us-ascii?Q?hgSPmZ2U5LnFyZe3tlhnUTlMkI3Kq5AvukW0a/pIyve0dHYA87kfDIheVO15?=
 =?us-ascii?Q?QqEUVM+CqNdh2UfmBv4FYtcY/FA0ve4jj+cHAmwqHoOx4+ajjm6rHGKRc/zP?=
 =?us-ascii?Q?ssRo+V3bMkwP80UVVoQfpW4On89QO9sTvjYaHFNTSMXDOP0Llm39EGBQpn/A?=
 =?us-ascii?Q?gdCut2ZlhsmYxNkMDTtT//YguuiPqZTGHo9Fleoka5nn0kFASbMWYc5TVdCK?=
 =?us-ascii?Q?G4Q3NSuWqU3w068cdYTR3Tb9hvqdozoVjA4sxH6R+XCQixhUHLN3oyqIBn5e?=
 =?us-ascii?Q?4nASIwvrNBCUuw1W+PNP307UUtzV4IdEY1LCzYy7uE9mPYm2uRbPrwq24F4F?=
 =?us-ascii?Q?ytnaMqlXV8/8YikXSHZR4y/6SqNrfZJUEkP3Asr96nmIP+BAUHCAQJUwq6lz?=
 =?us-ascii?Q?K06bsOQaaz9iuntav/0wWB8yr/AP7pK/tLQL7g0EYox+0IUUmTAvxxSj5rmv?=
 =?us-ascii?Q?0CUt8KUIoNWmohWOM6V7nf1HSSyBBoHdWnn6zoI+OFFD3NWQF+QiTEfn5b3D?=
 =?us-ascii?Q?zzdQ1G0b4Id9BvCZfy1x8TJieLSq3xstBnwu8lrKqF9QQB76dgwlTFK3XRSf?=
 =?us-ascii?Q?9xPn179VfrTxLvBjOmi3Tngi37uJgpNalCzh55KrIowT8HbJgfNnmURsk8Sx?=
 =?us-ascii?Q?R9SGNhRYBaplSskP1R13Cxir1WxBIqSOkkLNhzXmYJgeKzNZ7AlmVxpebNQh?=
 =?us-ascii?Q?BOtOaHrVuwycO/o0Hb/WeUjIaaS2wobQOSSTgACy20s1TnhjarNZZ19jpJVp?=
 =?us-ascii?Q?0FkodDF87yRu4EmjpL9R09t2Cntl+chqSQ9vxr7/AkNE9osuetzZM4qQY2gD?=
 =?us-ascii?Q?P0ON7u4Rms2QWz9c19S+Ac71jpDYGWQHiWkTgyDZl18x6HiNiAXdaWjsLL2l?=
 =?us-ascii?Q?aWqS7UM9SHJ3YX6xvFT8mThmp42ttIcTCHgnkbKzRA/gAw17bAxmNXOAzoKe?=
 =?us-ascii?Q?YVutqB5x3jG1Bwf+zXWERpUBE6UE8YVbGDumNuvyoVbtAtgScJBxs2kmMPwq?=
 =?us-ascii?Q?Jl0h200yWp6pA0UuUPo1vIgmIajBCTLQtT3++ZQvGnz/8THVMH3BdtsK14XJ?=
 =?us-ascii?Q?ruxCcWt5PIeU9j/x33jMzMYfitK1/aQpnGyLrNtXm0Wy7PY4m4ZGItSANpQy?=
 =?us-ascii?Q?wt3VZCCOTo+la0VU+O2wfp39AMamZ/GkgjvjG4PPMuC/iqMDPCq2DWIQJX5H?=
 =?us-ascii?Q?wpNbKeXmROV/1dGZjqTy3o+g+aeJWSA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e355a992-2207-4b87-614b-08df08cfb42e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:48.6645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cz1jhNgoos1TQOfaru/V6QB3R6ocIJfm47g4LGSVRPyVZlklk8v+9huQLn/BDQ918FV6p1T7BgfOe87D+gT6nAzFYWFsWQwcapW67EYd0i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

add mdio node to be able see switch port states

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/dts/an7583.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index 1a64f48e5f1..ec6eab327db 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -166,6 +166,11 @@
 		switch: switch@1fb58000 {
 			compatible = "airoha,an7583-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		syscon@1fbe3400 {
-- 
2.53.0

