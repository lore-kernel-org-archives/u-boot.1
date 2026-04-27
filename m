Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB25FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D89584119;
	Mon, 27 Apr 2026 15:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="YvwkPBBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C958383693; Mon, 27 Apr 2026 15:53:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F9A83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpqtCpBg5vS3Yk/pusmVsG/DytsIRl3MnywGbQkv+d/f7RPapkJwnK0veO5BxCFBAxW0LouhR6MOSeitQXPDWj+vdbrhzQKjFamEqXj24a+TrxFjzfI1mZn9ywQJw151czrC6s2ORWLd1vfvGG5OGM3YhZ8yuHuKGPs7/Iungz4grg979SG1nYUk7FPMeaQNgEhFbfp8a3/gfze2wfq8v1L69xVAn7xs6PUsRxBvdW3z9lMgUshqSXztU+eNI/TH88WDPHg15sOlVOSVG88WSAMNkNjVksdXLVjRcTxNv5HB6G20P6sxbvn38aAbh0CygfQAXMGs8q1p1qX32EWhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kyoce+SXFZziVBfdqmpUezQPo6tPe/MKBWkgTt67y9o=;
 b=kWNKmVadq34oVZe+Aex9bN8S1JsbBFHCzyFzstXhQ1uQkHucFqMIxZlVLH0O4m9L+W5X/exKOTjy1E24iyqi7GxeZoePG6J+H+F/YDYOwJgdO2zrxaeBotEyQXoXNx4drH5MI+0D6CgDDGfcdfGN6oqK87o+hrddajbikDRRQjMe0nIe2EWjwlw/uu213yAHYj50kEUvOI7zfHzMgxfkx+pxvVAMOm4a5HWCIKuHxVj9g+yD9a6uiFCD6172D+hf9aBRoFFuf+Uy6Brqih/QonUqygaxESIjRRhH56xgq5xj4OShQJo5ckb99XgAan7bQFKlHFpHTaVNB26fduHE5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kyoce+SXFZziVBfdqmpUezQPo6tPe/MKBWkgTt67y9o=;
 b=YvwkPBBtyPvQkZDXWdZELZeglve+CbH4/CLMe30KrjCDTCWCO1bE874XZ3IKKTquKvLOHC6EiygwBb/Gg+wCbIHo+Nk+RD2mrlxO54YTd7fA7gIKCDNhOzL/8v6D2GimAzNHJS7s2y+C2b8/ZH68Qzjsn05wrtb6Fdco0qgupimLkaGFl917pZPbxzM7SbyVGBzGlW8T3MfXNHAU15BNQtH67E8DMYMieIJIslljQ9+LKrFNE4CY4+Dt1r7lMr4hs6gH8hz4i8QvLkc/Za7ppTBTtKn75Jyp4cVuBS0esJcx4Ir0gaRqo6HGxXCoKGUOrHkyz9EXO9Fqd2YGy5nqoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11519.eurprd08.prod.outlook.com (2603:10a6:150:2b1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.25; Mon, 27 Apr
 2026 13:53:34 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 13:53:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/2] configs: airoha: an7581: defconfig fixes & improvements
Date: Mon, 27 Apr 2026 16:53:24 +0300
Message-ID: <20260427135326.773903-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0079.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::18) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11519:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d253c1-cb38-4c4a-d25c-08dea4645fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: jorTw0KRkGj2wuE9A5t5scdo0RdZyllCVPrk+GBgW4alN2T8fi4ViO30NcCDrT4oIGfu4A14eXJXCNJsKRl9xoNFB6cFgxTR0WTzh5Oxnbh4KNTJl9SB9pLSXxkfOA0UxP0r8F0qIBviIiq4WQGmHCtCMPj1LpUxEn1rRDinjLkotcrbmk32dH1f0bsn74XWT2+PftaIl+mwde8yQj03C3o2dsFDD5eg13NURBuEV841DB6IltVCZyhduHn4d94zcQGMdOCbAAwStV3mBzUoZAZNGupX6PAZVpDwpuJ9tL/Kb7oxqnBZkp9+5/6v16MntIm7ATB0ZdgJlreBvSTwvEqx4d8thIpv4vgzv1w1aT2amoD+fJGGoD59H8pgiQTcTQ/+uyxVCI+PVgjKC4Z8EJuauaIzjZM5N7sunjqFEc/3ZP1SGi7L62fmHZj7gpopeXJwWLAIaH+ZN3/ZWtV9VOMcchUn9tn6AZoyY5tHb4NDEVCY+Klt3cWPcXGDqDm4qP76LyMIwrGCpPn+RfrTPVZevuqXDOHGQqgXPEoeQBaL2eIetgrrvsbTB/n5NfSuA+vHTBnTZ2dWgW6Hj1ouGQi0gFSoBClcNhId5RGza7dy9Wpy88gniUmVbpQgXOMg/LpB1k8UWdnWhMmZC5XErZ5Bp9mqotSpirYUp3eSaf0Bf2VGeOSY4LSL7+Og+2BIdDnNF0iRVuYTuetWM9JHGkIXDUHeGPNhldO+4gq68om9MZos8LubNQdMyQxPtwmQkyEqow5jxCDe2RIss88DNYR7yqZ0D6jhtQkZtUJkQE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Qtvcff+UdhsyFdBr7ft0Z66/fPPDjerV8wAgLK7b6uptIdbNqhWa/IePc+F?=
 =?us-ascii?Q?lVkiXIyvbhCMKZZN0olXIlglF1Sdrj5taSxSbPqkDZu6jdEIMSlMWVJXUU7I?=
 =?us-ascii?Q?puTfkJX7RBwBLayB/xFhSVbk2hZJBPY9JW1yxeDO+3Eom2xFcNxWMgDkpOjJ?=
 =?us-ascii?Q?mapu6vdb+aY17gcSB3G0LjiFnJN7G1nZq/6rmStfmGy2qAWjWPZohWpSBzLM?=
 =?us-ascii?Q?NHHY39IJZGrP1/l13yKFvTSdPVpUCIJ/Q3nstvsq7PcloqQhjtMUUnwLWTAi?=
 =?us-ascii?Q?Ut+TidHSmkE6sOX7B8n8h/bpITycORD94Z2AV+vrGau3QBhqQbltk78AcyrH?=
 =?us-ascii?Q?QxRAxctyaBS6wd/kS/uDzstlLlHJGK30LA99VkWBv0R1/48oPVBzT0zmdZnA?=
 =?us-ascii?Q?kXJmYNGKqi4Gg0xbB9ABKznm2BwtGd9L6m2OaWvVkhQjbun+qcXCjniAWGBj?=
 =?us-ascii?Q?/PymGB8QnMH/6LAgf7zmkhvERzGu+r7Z3fOzD7n1kTK9sLL8Talo3ayQLdC2?=
 =?us-ascii?Q?sTZunx/XOiCjo++xUfTeDDQy6XuRCzNHNNKf6cbwkdc1V5BG4JztFbzBs6UR?=
 =?us-ascii?Q?lRPMhausI2/5e+XHYQ/ydKajzo+WRAZvgO+P/4x1SnumUrpqDu1YxsGgiTov?=
 =?us-ascii?Q?X7+PgPTCpw7cYhYOXVHT8+P8jM7nndKM6mDLBKJp9h/xt+qzp3ZsBZoV7lXX?=
 =?us-ascii?Q?oUzGk4fJMd+F6s8uJU+Bx1yPr6NP2vm8NQNr+6k/putl9EC6/Fab2vZTEqdc?=
 =?us-ascii?Q?5TlPmbDrGsU6JJk+0k7iV3Tl0XqtdDBtRusl5rw2l88OLpCgUNhXh/SaaeK4?=
 =?us-ascii?Q?70tqPqrgzXfwETKUadHIibfgslPQnqjon9Q9hx0+4zN0nHdDvFIagLF6SjJo?=
 =?us-ascii?Q?TwQDHiHrlA7U/U9Yoncpajf9agqnOrEZ5ZdFv2XW4jPdsTgkG/VZI2ThKJ7G?=
 =?us-ascii?Q?NuJhNN2zvMwo8Y+YshMBra6Gh57eaHgq7z2YGmhQswe7LOvjKHeXuG+WW3pJ?=
 =?us-ascii?Q?uRCWyY0UBld0g9E+7TSntB69NOnwjaXxjhzUmDpbMYf+cX4DHUKcDhxRa++0?=
 =?us-ascii?Q?8VgZ7lPlwk73EifmcUzMBgVjviFw1heVty7Nbc/GaxqxDCyy8fz7FcnYfb9G?=
 =?us-ascii?Q?nkvjbd7P/DZu2FQUK+pOP2ApHlExtbSc+943pcrkIFysITJyZQe0WUkqGTSV?=
 =?us-ascii?Q?Qc3LgfXXK/mwGfgSWJCsvrrGSXOF1aSPzXNgbqT/wUTTES3K/OdKWWe5Ev68?=
 =?us-ascii?Q?EoUNTClPIym3137NpO1L5PvsRfOWML6CS5koLtTyFMMRPOOJF6C4D+fERtBd?=
 =?us-ascii?Q?wKcP+Me0Hzlqy/V5HNi67fUZIQYC98ReORVhBPQOIN+wpq+oXJ08KrwdSk4m?=
 =?us-ascii?Q?Yh4IauUnzbBNF4MiAQhC25DoMaVV367U4ssBEJgXh1RH9fty8gJ3ltEMgW2L?=
 =?us-ascii?Q?P5Ne8bsr3dRe8SyuFvLyIdpuTMi27klAHDVTT7qlkU15g+a8PYBGtalPhdKn?=
 =?us-ascii?Q?fyGHEavINUKt9rFW/u2yE/mWrzxHTfNBK+8szg99ciCFqHDdVJc3cCsjpUBY?=
 =?us-ascii?Q?r/LYPD5AWH8ROgGCWos8GiELjAI7dXkhDzn1bN3dmf37IsIr2bMF782jUi4a?=
 =?us-ascii?Q?CEUT+F9x5vA8ZxdtxuSaq/Rvsz5JMIb4ezSGC8BruKJZTkPkXAhxHWazsY2S?=
 =?us-ascii?Q?5+X9M+5fHc5c27B2EoN32KxTOOyYq9qeSoPOD0+QPfhQftgTQuueF/tV9OPA?=
 =?us-ascii?Q?ubkCpK9FrLHlsr1OAu7yRGpf7rp3bZ4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d253c1-cb38-4c4a-d25c-08dea4645fd7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 13:53:34.7599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1H2A8dyx7UuIr1kscU/I4usoWmwyTrSOfDYuIs7V30sYUKU4DsdXhMkTGYDE1cFPwPbX/amndDVf6E8FPaSSiVoXwg6J/0RFJoRY6huDdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11519
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

This patch series fixes an7581_evb_defconfig.

Mikhail Kshevetskiy (2):
  configs: airoha: an7581: enable position independent code
  configs: airoha: an7581: disable ENV_IS_IN_MTD to avoid boot panic

 configs/an7581_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.53.0

