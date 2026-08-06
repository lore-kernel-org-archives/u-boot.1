Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14738C5AC82
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCA2840935;
	Thu,  6 Aug 2026 23:45:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6t_Q8Vb-Ye6o; Thu,  6 Aug 2026 23:45:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD6A140949
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059909;
	bh=T50hFDugTjP9vErVvsPu/Grqz5pyYi3EmniCxHm8yM8=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yoAl2fA/rL59UfJ+2eGu7gS2tYoNhgaVSWwmVRb3VE5Y1O3s8a7fSdxygCkRgkGYG
	 v/LBDDHbHDQEdiv9vNdQ+SNYF185R7oE4AAbEr+IZuuNs/8J+pIvm9rigy4zV4J7TX
	 5celo2Fi8mFWg8m2Fy25SrCUeOE9wkSjA4AOPjRP+ldpv68QPUE3PpgNy/b9I0p3LU
	 UBRYXHBv8gZDJWYLBnfUlrkfWThPd0BWzLtsN1vtMa1qZGgUBCrdR3evlezIGLS0t0
	 by0eC5ULtep5os3+L7sGQGiUm/iB+dGrNMw4IE7SEyTT88y9HoSzfG5uH8kDrT/o1H
	 I7/dPpFhfwuAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD6A140949;
	Thu,  6 Aug 2026 23:45:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B85C4397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A440D80FB1
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nYC6ZZeoR0Jr for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 87A2280F9E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87A2280F9E
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87A2280F9E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lXJrkH+R2558Y719gxpeJiLhIb4Yx/eUEiLQMyXfOQqKAN6TJbTD2ug7jzEfXSxwkmxvG1WIlNEYzchz/3SkkW9JZo94UXHPrHFaMF0KT+E+tOnE7lJ0dLWqGiv/s9XNvwj8is+UT6AMjpmkhZNon6XgKBmKKOrxvs6AGQYAo2jU86GiMNm6g7OmJZNuO2BmTzk1131TGA+P8RkWmd9VphvFZHVdBB59PXO5pS1G2Sj5ogbFXJUovrT/v1csW1JCpBpjmBk4uGs4n/xekX7/EvJOsxjPNlX/qdiqrHMTT+w21vBWCxNXME5Tg6wYdD8Nj2xE4itYbNH6ykkp8isw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T50hFDugTjP9vErVvsPu/Grqz5pyYi3EmniCxHm8yM8=;
 b=UQw2SBdJc3DiQp4kqJp1G0LjCQnHqwfQVLsZpx5snFutVigddA6jvBXF3Uo9ACfbFnS/idZjIzImFM9JLb7fcEgid4Q1o5jTQpfy+ZTD1ei2tDvqB+8oFFDiMJGuClQzcXYjQOgf9GY6bdGSWSGXKmtWCt11Z/eXdazifbMY5cPIjn7nDe68b8SDhhmLuc1ZhBNFCswORud9OF5HV7b5u5feF3I2TS3hts3VoUoC2TumIn9z3whfRsAuoIzvb0Nn2cpSHXHSAtKuT+TluMtRa4Td9rHirpMiDbAiLcf4i4H9vsZzDlYv0sTYeGGwBXV+CEkLh+ACmslCCRIkcTVuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:54 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:54 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 12/16] airoha: add PCS node for AN7583
Date: Fri,  7 Aug 2026 02:44:28 +0300
Message-ID: <20260806234432.4098414-13-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd5550a-42cc-49bb-c558-08def414b734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B5KgixRsSQhdLY/5cQ5HOLM9prBcYZ/cdhAgihGbjwBZIU/9TsjENW+uo5o91OyDjf3js80QrKOcFCyroOtAoWZfZK23Y10CsFOM9cBSihU24J6/JZzpZDpfsUDYajE/u/hN5E5hQjKEALH5gIdP1hlnS7VDZv1l/yzyh6HCihonqx3hdvCtrmNhhMOq1524+CMRVAsSkR1TZL28MAuaKINpMK8pCJ/ratSN3fJR4m1Bwx5a1bWSC6kvHuT9xJC44qg7VQehzfQ/N5dQ/on/eGuhgBSlN4LjW9Yn/eoEaoIb4VSHZMztuonz+TFRjR4Q3fqyxWIRfpQVwIzf8kMbw12LH8vGxCYYgK6/G+pomna9Xknt2B0/7PBwL4d2i+1J0WcpOexl4XW54+I4JBXCeCTROwMwjqPnI/7uc9aQepoWF/mazF8lSmIUPU3vUnmUYY812E6waVzEL0XX8LB5JIFyzAvRRjNLc67A8YT0Q7u2N3MUf53agPL/S6PESAu5X04GXEg53KeuShQxLj1dKGa6uTu8DlF+qfJBd+Lk5n/Fgk1z5MlKgZww6W4d2oMXtMJeNcDNjSsVZEPKKqa0KYtnpPFn2DvKGFu1MrdCVrrtEjxuS1qV18GBQX3Cd4Nlh3g9SEmTYZiFjugqZhYMelRERewnBGwewAiC3OAC4xMTtOWmS7VhyMsD5g8Ge07nMUSer1Iu47uqYDAO/T3gMVy+X3N8RN67SKjo/t9s2+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LAv8QL2MymCvuEVaV+tdwjco0p21QecRcjrXL5ONB3XF41DRB3YDobaqH9f7?=
 =?us-ascii?Q?PB2SRWItTXXx9WHZaQR6VHHDymrLuvPjZbrhVaI8sXiKJR3km56+AIPT3rsz?=
 =?us-ascii?Q?Ze6ItVngn2FkfdXUERwlWl9+Wlc5+jgRUUrcxLFlf/i277MxEisHiesdU5so?=
 =?us-ascii?Q?bYvmZFN+zJWj/W0hDeCUhxsA5chfrUxHnzpubn5W2xzCXgzdUgyiJbQ10xsb?=
 =?us-ascii?Q?0TIN9H8rC5LJ/1eewWH9xyf9PoyUocVAGeyRaEDBCNG6qIwA2CTSI/AikxfG?=
 =?us-ascii?Q?MbpQJZy0u0E92IW0pk2QRAl6qi29U/rW/Ek1tJgIJy0t3f1fgdMgSVjPTtSz?=
 =?us-ascii?Q?/jHPXxx7Sh65odGrynbk0sVqz69vAG+i/Vc9f7iC0o/LP9PMcc6xf9tTN2zZ?=
 =?us-ascii?Q?fB/wBt4GcaufeiMQZYLQ1oTqy45QcGY5NoGKhazlNR8H0ooJBKlRxq+gTZ5i?=
 =?us-ascii?Q?Td1dysEUMcdvVtdYOKktn24wi0jgGL0aICHuK5e6Iz2kePaJoTUcgswGGnM8?=
 =?us-ascii?Q?Pn4mkh5pOO8Zk1S2NEkBi3kDJNnTu5C0qIrMHy86/TNuOGcatvQkr5c23Ava?=
 =?us-ascii?Q?zZ+6Oz1/18LNKgkFu2/rRLjZ635zzXrVZAA7EnpPxTThwZuEIF7ZVaTNl2qu?=
 =?us-ascii?Q?peludHpJT5DDNPoeg/1vIwBn+PHrwyAMLo9EiCZR4JseJPQxLKbvnKZWYa04?=
 =?us-ascii?Q?My8Fyuv9yJ/efsOEjTZqBf6NOC8OAE21rIpQ3UQ9t/Nl+qSXDh/tLH4H9v6b?=
 =?us-ascii?Q?MUu0CPbNRcXXMWyq7OY1kjRArrlIMVOaqW03T+hLksL450Xj++vnF4vGZNpq?=
 =?us-ascii?Q?6uNVh8WDzC7mGrfi8n84JtU/n57Y3ZwsTj0BrZBpt53S6S1lTuociQ5Nb8wV?=
 =?us-ascii?Q?2wfHqzKEt03ILaAKk5bDM+A7r1R/MvyC3YNhS8AyyOSrZBVsHRUQpPhWP8ah?=
 =?us-ascii?Q?47WHeRE2eWs2+9MwuSXivHrYRgZH6OvraafmE46tXxGwsC3Lg6uMy3RbkxIg?=
 =?us-ascii?Q?kUjz3kwkvbnaooc0dUALHArjfavxd4Tm7pCK1w0kH4LuzJZpBnOJ4kpSJMZV?=
 =?us-ascii?Q?lXtyxt4avoQ6WSG72uD3aAvgGm9puTqjq335faC0giikbrpqu0aNck6A3rSU?=
 =?us-ascii?Q?fkstfbnYtvnUoO0WMEc/o9PLtDMeIqXDsOdBfglpWL8W2AZAvqb9bDocUdfL?=
 =?us-ascii?Q?UawQHChNIgTXjUo4wQHXA81s3qbg0yrkNM9MCM5w9WtbFUD3jdP6Q0vkGSZG?=
 =?us-ascii?Q?2jZFYcl1jP+3edc7CNhefZjWEsJNGZ7S5V5f7cWGIPt0TlhTfCwG4kqxUxry?=
 =?us-ascii?Q?AnArWhc0Q0yMowWbtxwG2UFyTTJUPTpGFHWwFg1LHtgFnmRSnHEluDz0WU2b?=
 =?us-ascii?Q?vjJ9mEwRaoACsmhu+8ir+A9pNo8wc+5ZSLp5FldKDj1pXibSEIr2q/dKZCGX?=
 =?us-ascii?Q?OG/1zt2vjqFNy2t7t6o4kQj4BU4Jzei0YDwNjJjHgoIDJqTc6xvGJ0NVeOKx?=
 =?us-ascii?Q?gLTqBlRxDq5Z+8ulEnnFCGPyiqXNVoPvWR6UoThupmXd3n+MXIxapyH91yMt?=
 =?us-ascii?Q?aolPHL4vDmhDxIqWWkaB6zvrp7X1Z+2wa61q/VvxKeuOdKQyEU1vKImHJrTH?=
 =?us-ascii?Q?9brNNf9Nt4+uaTOBcMXIS6ly+ZK/lZK907t22zHKsh0pN3kRBBvVRyRNyAwf?=
 =?us-ascii?Q?qLylVpcJRzxayFP4ZO3erknOvGbchj3f1a5ZymerdOpkJiAwGRIUXZOWsYMJ?=
 =?us-ascii?Q?WxDZBl8vi51j/AcTP1EHlXOB/BOfGiA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd5550a-42cc-49bb-c558-08def414b734
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:54.4890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxmSIH41PTdkC0E0zrxW9BsqgNMaZzPJhFbcXFZpdb4gKFhdJc7mIu3izELYij9YztlKkxKTFv4lyJSLL8cprvnhGjPsu/XJTzWBEDqNPP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T50hFDugTjP9vErVvsPu/Grqz5pyYi3EmniCxHm8yM8=;
 b=Lm3ycxNSuMfuLciFqSkuXMTT0ISLvtIu0yqN4kkl7gDPh7mDpvd4Sm7S1wmvLjGkGITmNqCv+O5A90B9Hyn9KMIj34Ruq9yy6fxjUfcgIx+quWaD6XImIGhBg8TfzlvvOBjUJQwybDjgRk2l4rZCt1Ww6p2j5U1429Csxam3qh+Uk4hZ+7b45dQ30Ho+8gfCDx0VqYip7Tx76s9Or/ljBLY7aPWXFSsTJm954CfBHNHiXMx2RBkliQG5kzq2a+BUqldbRCfR3cEEaxcPnZCY66eX8FyD5sHlVwnyN+aKZuQ8zF7fTy3AlPdBlbzB7+VDtKhGWt7X+atxwB9DBTLRog==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=Lm3ycxNS
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Add PCS node for Airoha AN7583 SoC to enable support for Serdes Ethernet
and PON port.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583-evb.dts | 18 ++++++++++
 arch/arm/dts/an7583.dtsi    | 72 +++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/arch/arm/dts/an7583-evb.dts b/arch/arm/dts/an7583-evb.dts
index d02cd194e8a..714c90eadfe 100644
--- a/arch/arm/dts/an7583-evb.dts
+++ b/arch/arm/dts/an7583-evb.dts
@@ -65,3 +65,21 @@
 &snfi {
 	status = "okay";
 };
+
+&gdm1 {
+	status = "okay";
+};
+
+&gdm2 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "usxgmii";
+};
+
+&gdm3 {
+	status = "okay";
+
+	managed = "in-band-status";
+	phy-mode = "2500base-x";
+};
diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index ec6eab327db..c8f445b2c41 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -145,6 +145,49 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		pon_pcs: pcs@1fa08000 {
+			compatible = "airoha,an7583-pcs-pon";
+			reg = <0x0 0x1fa08000 0x0 0x1000>,
+			      <0x0 0x1fa80000 0x0 0x60>,
+			      <0x0 0x1fa80a00 0x0 0x164>,
+			      <0x0 0x1fa84000 0x0 0x450>,
+			      <0x0 0x1fa85900 0x0 0x338>,
+			      <0x0 0x1fa86000 0x0 0x300>,
+			      <0x0 0x1fa8f000 0x0 0x1000>,
+			      <0x0 0x1fa8e000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk AN7583_XPON_MAC_RST>,
+				 <&scuclk AN7583_XPON_PHY_RST>,
+				 <&scuclk AN7583_XPON_XFI_RST>;
+			reset-names = "mac", "phy", "xfi";
+
+			airoha,scu = <&scuclk>;
+		};
+
+		eth_pcs: pcs@1fa09000 {
+			compatible = "airoha,an7583-pcs-eth";
+			reg = <0x0 0x1fa09000 0x0 0x1000>,
+			      <0x0 0x1fa70000 0x0 0x60>,
+			      <0x0 0x1fa70a00 0x0 0x164>,
+			      <0x0 0x1fa74000 0x0 0x450>,
+			      <0x0 0x1fa75900 0x0 0x338>,
+			      <0x0 0x1fa76000 0x0 0x300>,
+			      <0x0 0x1fa7f000 0x0 0x1000>,
+			      <0x0 0x1fa7e000 0x0 0x1000>;
+			reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+				    "multi_sgmii", "usxgmii",
+				    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+			resets = <&scuclk AN7583_XSI_MAC_RST>,
+				 <&scuclk AN7583_XSI_PHY_RST>;
+			reset-names = "mac", "phy";
+
+			airoha,scu = <&scuclk>;
+		};
+
 		eth: ethernet@1fb50000 {
 			compatible = "airoha,an7583-eth";
 			reg = <0 0x1fb50000 0 0x2600>,
@@ -161,6 +204,35 @@
 			reset-names = "fe", "pdma", "qdma",
 				      "hsi0-mac", "hsi1-mac",
 				      "xfp-mac";
+
+			gdm1: ethernet@1 {
+				compatible = "airoha,eth-mac";
+				reg = <1>;
+				phy-mode = "internal";
+				status = "disabled";
+
+				fixed-link {
+					speed = <10000>;
+					full-duplex;
+					pause;
+				};
+			};
+
+			gdm2: ethernet@2 {
+				compatible = "airoha,eth-mac";
+				reg = <2>;
+				pcs = <&pon_pcs>;
+
+				status = "disabled";
+			};
+
+			gdm3: ethernet@3 {
+				compatible = "airoha,eth-mac";
+				reg = <3>;
+				pcs = <&eth_pcs>;
+
+				status = "disabled";
+			};
 		};
 
 		switch: switch@1fb58000 {
-- 
2.53.0

