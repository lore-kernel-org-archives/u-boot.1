Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C5E77188
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 10:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5625D80431;
	Sat, 28 Dec 2024 11:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="pIRbpzjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E368056E; Sat, 28 Dec 2024 11:47:06 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20704.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::704])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA8F805CB
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 11:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9wItN2r8pb3cD+jT7lEEhNlN4/+r/03Jc79qKuuzgzC1BueErWCrSBUrBQ/qrXlCyDCqF43vYSF3fzZ7tOrSd7lPuqS2ATLrz4PtBNriHOkF+TgN/wXJ6ZpsV3PRQ+RJmR/+5/CiXnkQUeeXPrsfobEpbdsgDMbNn4jgDTMvaIHsDHOBd+TyhNKN0KPjdpgLc1qw9VfvWt9J3IQCeqiYqQJlmQVSQ5URFtrgpyRKbXUcG+pMluEmcliMUKDt/sq757Un1l5WOrycEk7TcxsRx1dlykK2qWNn663YoZxfSNeoUvNzFSMUvoQxG96GQypiKJUHSBfU+GOaZnQCtNb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+u8bdyboDepikG2SkgmMVwkfD7F1ouVTbYHyNOUCiE=;
 b=GLeiaRih+sDUTbGtQyfohejVD8aHCIxU9owxDjtT3ikSTnDfudgShjyp6rkiHvBpSMwH7+GpMItCDSrZ2c1LfBKnTOR+7TBTWhmg/HaU5/bpPfUIVW5LpkuagGDyfm4OXHGYLCq1/ozGy4PHjXGD7iA4DKHocJPQFdWrjolLg2gcdxN9FK+1RJslv+GB2vwpLhMMsLlmxYskhM+0K0XssNh9rhQNDT3XGMbC5o6CGVffdlI4US2i+w6IoGVNJASHBtLUgw9HVZodfRktluEUqCOrrpRkosSXktZLTMZcfYv0DRWEwqe3lVdAWbVvatjacPk13mV2vAgFB4IFAU8tXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+u8bdyboDepikG2SkgmMVwkfD7F1ouVTbYHyNOUCiE=;
 b=pIRbpzjCFdLvnP3R21CcMlmRwiAXoBrDiFlEEkv6L/t57kEfol6AcFmj8ghUZMBoz5aEpWoVvkJ/CA+8Zg1nWKHZmR+FUsskMvKYzFW0HCxVNSMzh7QtX8uQ99BsnjRAmlMeMHC9EdJqDIrOpME3jBhEHGm3ocNNw0wSqKPMZ5XH7t0GiRFbddgr/izANqk9xXUkrAva9mgTwAue1DjGRDMLsHbTmHSAQ91bYhbzEYiVObrLsmfd9OquHAGglUpqg4EVgZx2QvsqS/lOnrpZegQ5RdamDaXnA0DMDxNDrQKj3ytm4rtxLE7WuRqqtbwUj/NqsmDfZG5LHyzAZEQPdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB8437.eurprd08.prod.outlook.com (2603:10a6:150:c3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 10:46:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 10:46:58 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v16 10/11] net/tcp: define a fallback value for rcv_wnd size
Date: Sat, 28 Dec 2024 13:46:36 +0300
Message-ID: <20241228104637.4173913-11-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241228104637.4173913-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::316) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: b32b9388-3041-4034-f9d7-08dd272cf3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mBvN9+wjY5Fkyc/+GlF/FIEVwjTbMjUtBAa4YofmozL8+1DIVCMiy4hEBAS5?=
 =?us-ascii?Q?KY49+MxnLwPzraNEnTK9Xa4AIEqnjB5qrFlQ05vwM8EA3eFumrjzY0VG45Il?=
 =?us-ascii?Q?7HoKlgo89JeClVAF5ZAHQdUP48T+5zhX1FL+qNbSf/5SXCnaeayQ2LPrrgGT?=
 =?us-ascii?Q?P61nH3w7nSnW9MEQaDMArN1Ac9WD2Z0pzMzzq6T22/CmaykIdGctPsXEGO/v?=
 =?us-ascii?Q?fHIy84fd48T7SaMJDKAcFixO3DcKThCrEB6iDDq06e54dXsrFqpoj/Elc3lu?=
 =?us-ascii?Q?4jKeRqXN2icTvqfQA78gHc3pFCpTEYS/4VDG33ujT7d7tXj9u+JFQILCLtKS?=
 =?us-ascii?Q?3p9xZb/B1jmBxeER1nSFurWpm19m9XhcDvSFcWledbT5fLeQzLV0ztm0fPRi?=
 =?us-ascii?Q?IH/jD5y9zePphFKI7xNUMnXUA3Oh2AEmr2ESSBvURau5+DB/2+K12ZBn7GOQ?=
 =?us-ascii?Q?5xij0ftaNhDUdFwPxoQutc1q8fcpq5ovZZJ+tYRymEHKXorY0L2U/B7wCTjf?=
 =?us-ascii?Q?/f/lYErEn0bPCvwU+rnRV526Q+ByDDou4ZCZg8mDKLYdvIWz5CbkzPXMes0f?=
 =?us-ascii?Q?LVR0k6avBIIOzWIXxA9L5yjlY4dSfXVe5+IWHGLIZ4omMTEktQmeZLABAw7y?=
 =?us-ascii?Q?aUY0Cj0o9SeCSD+5RlNM0U1oKSAkcy+/QaML012JxdRTxqu0K26ME0FCOry5?=
 =?us-ascii?Q?TUMxxWtmWORKPOcdr1KlbZzFPkoAO+1rJYquVlWGbmcGVjUHSHe/AcwsRW2X?=
 =?us-ascii?Q?xqJg3xNoRkPkSy0rDZWM/0wc64JwXCr1zzZhOvXsiWf4GzSbf3W1B1UI7APw?=
 =?us-ascii?Q?LBnqW163gW0w413mnaenHTBBWcUBM2DcnuSHi5Y2IxghAUplDMVa7r4rAORV?=
 =?us-ascii?Q?ieePJg4FXZX8YJPFHWWNrJBttLqsFv53yZ/ZqC5HN3poFISdPyEpncn5FL0g?=
 =?us-ascii?Q?T4+Bx18pyF+t8KWWl4M9Epp3uxsoLQxv6iWFUV3v28ocBCW88AILpUKPEi/9?=
 =?us-ascii?Q?rrrnvqeto1dy6q8Ly5UPkJ/N+EmyjS+2MZfCfSnzMg/zysZgwzK9oRrgrjDl?=
 =?us-ascii?Q?6MTwGr/AsP2wuFZtsmOdaj02vw2Xto5IvVuUuWUDqOHe7a+tg9nUXgnMr4OQ?=
 =?us-ascii?Q?sTexBYQBfJ1YjIq+GqXaYo8YtfYSSNrQa10OqopYjUMr4jaMN8lWPSWeSQQ6?=
 =?us-ascii?Q?XfXqKTOKL99V8q6xLNLTmZNnHq4Jvf+mx435L3j+TblMTOGIH3sFj1UoS6mO?=
 =?us-ascii?Q?tF3Ih/ChaYYmLtMaCrkx23Q4QRr2QnFx5vi9d31gLbXGNxXs9+4fY357wqB7?=
 =?us-ascii?Q?I8jAF92Ndl7ykLNLdT2K/tHJClg2bhgRdhAdV1UMuxUjQPSGzSEcM66SquCt?=
 =?us-ascii?Q?6UjmYP6q8i+rVFaKtHkBrD8soism7mL2W2+ZsJmxZj5qEbav/L3G6/4WaXou?=
 =?us-ascii?Q?D9do5GfvNSXKxb1dVa8lAVpWPeQLK8lJ1xqroDSEtGmZQayFc/rAuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(7053199007)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2h0dCM1eWXDKvrJZIwa1NyQIE1ubh4xbb8K5VD6o+EhrPiYGu5/1oh9JuHNd?=
 =?us-ascii?Q?klhrdKepbcAbHsluxwFzeywxjzRtKbjj/Mm24L4ZES4lPLNR+n5TAsorQLmD?=
 =?us-ascii?Q?+zXI6kA5T0hkEq9vlIj3luE++XIL9GnJ4JWTXQ334Hn8dz/O0ViuCz8iuHVB?=
 =?us-ascii?Q?L1pkKNPly7NVYgo5gSOKb5BL9EY2skySLa77yqayyylSOzzFUT289IhcWccS?=
 =?us-ascii?Q?L1FJDfFWUAjVPv5OlsXAjsMKP5o2mFzmcth+rCwJ7QsLGeQeFUqy4mhJMj0s?=
 =?us-ascii?Q?wzKUFHP1fdu8vZsseYLLilxO+pTbWHDjfhusQEsVXAMGvPbItl8APHEzFWaa?=
 =?us-ascii?Q?XJoSyzt/SULsAPvOwbWmg4nsyIDDZTlSElWHj5VPMQP+e2yt85iiGF2hsgGr?=
 =?us-ascii?Q?WFNF2hD1bFSlJO751I3vu/nuiM0Dwc1Zi/sYtJzrkeD/3UC+WkVcRHTlTaK6?=
 =?us-ascii?Q?L/sJwvIKDhCzPxF2pUKdnzak1g0xtOzbofZReIvZRYQbXC32tra2lrwRP3g7?=
 =?us-ascii?Q?BJ6rZd39Tde6jhdirwrEBSiceoiEqNA8IQesNzLdFmZz/oMQ3Ts30hcWjVPi?=
 =?us-ascii?Q?Ndm/wJMm06N+irO8El8cely6M+i5y5NKezsYVdevm/zn9bE4XhuR+NEU7kK0?=
 =?us-ascii?Q?c9+FI+uw7HpX7iYJMwggQZAQ9hTCSVkjGxMpEQHkbQJHPxN8MZTZX1Jg5pdf?=
 =?us-ascii?Q?rnjlu3kIfV87ZPaiyHWUW3Z6rw1DWZ8/Hpu++3R+dVNnobC89O2Grdvy866W?=
 =?us-ascii?Q?jOTjJjjIhMSXi8rTwNgp9Xus9udaNMbWBKIFdDPCRnEVPveg9CRqeUmbzqyf?=
 =?us-ascii?Q?oyG7zwdrMB5lBy4OND/rrzzz1VgZgaV+ueYqGIuDhmDKNKC4UQn4iyirRJib?=
 =?us-ascii?Q?8D+4G0NXt5FROH5sbphvYg3yR1sGrpV6qVl47dwxcucAh1ITYmmJVUJ9zR3W?=
 =?us-ascii?Q?EJdjEUESimh9bzkvLdKkD3D9GwYPkzyZr1E1nZT84pjG4SGMwWB6AxCNGH/F?=
 =?us-ascii?Q?gbh2lr406oZNJbO8FyP9ghFyYXOGBB5dYWURXdoq2EETXCB3cLPD6BSCXutv?=
 =?us-ascii?Q?Kp7pU5WyNbkp6xhsalUr0A5t1lJtGso5f+fdyd7Cae+6aKozTj6tAxoDKja7?=
 =?us-ascii?Q?efoEDXxjruKpjyFJIcsgi0i6Te3KRYuE6LTu4ix+2l9wLiZ8H++AyNfI2OA7?=
 =?us-ascii?Q?3QCU4h7MtHfecWFdC7rCzWiFUXKrISYMP30mLwB6t5g6QjqxkoHR8t65t+20?=
 =?us-ascii?Q?Ae/gckRVYPnnxYXg+A+Jrql2hNq0WYgRz/t7KM6IyhABsopPNM+HhTp9gym1?=
 =?us-ascii?Q?TAFmqsLPJX53do4kxahn2EIZFFbf1jLJ1x8US0lZGmjekFZ/mLwwqLfcsGVO?=
 =?us-ascii?Q?TDbmvnkwDLXgLjUx+4ZR/9ysQlr/6FXR9PtEVi4bRm71qbf/beL7mPbzun2Y?=
 =?us-ascii?Q?WLJZDmWU4uiM/zzd8A7WyE0px+KrqqtPp7rgOKgUYr+6Zy9vk9lMnk1HkHzp?=
 =?us-ascii?Q?aPiP5JARKyECSfiNIbA5AIa97MXnMK5Nvy9DBM83jufE97DP5vuTriIhhc5C?=
 =?us-ascii?Q?QOItzc4OgGzMRzECZlfrwatlLzFsU02Rh/6BSQANds99FCbXopaCkLVNqp70?=
 =?us-ascii?Q?z1obgo53apT0p7OHtMc6bgw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b32b9388-3041-4034-f9d7-08dd272cf3f4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 10:46:58.2887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xb4pF5Dwl931rwLrfzQmxJRDf8uMtQPLuzj3JkdhFwrZMMvq8adFaJfeA5XZA7NeOF56D+p18Vl+pLjBsWO68/mys1D6Z9p6aeziYHd8+ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8437
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avoid it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index 2600f74b265..2635727f47d 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -36,7 +36,11 @@
 #define TCP_SEND_RETRY		3
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.45.2

