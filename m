Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B73C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28C954094A;
	Thu,  6 Aug 2026 23:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tt57pSdNVUoD; Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DFDB4093B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059906;
	bh=jtjQZ23tt3D4yxqY0iHqzavtKN6O4J9ze6nfYavYv3g=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IoCtWKO3koe3O6TVOVDUGfziNesAetjG4oMNqcUILO/gbE1s1zH/g9rWjl1BcKUHc
	 2XuiEoFTuNgQU9Y2Dah4ds7fRn7yEQ5mcj9wWSD5pC6Wiv9mqzImV1dw5Xntl9Nmmk
	 21GSMNjQHpmyP1RZfAKKak9mx+7ogdeJM3NijWuOMOA6lvg98qffL+4H8VPQ05pIHJ
	 1GOIZrp2mg5iifcCAcHDzhwRjdCmlQp1WwYBOsRxFbpf5qaulQL77vdl1jFFEjFpbK
	 ZOU5Fr19p+erHxgGVdN3sBhA68cajB4cJwHYoBqq8v0Z8AtbRPwjITpwvtAs97JaHA
	 aHzGQ40LVHrZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DFDB4093B;
	Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8819397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A54E040910
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5RiKFK_6JVq for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2F32C4090A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F32C4090A
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F32C4090A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y50sKeRwwFoLMsduSe7jn6O4mC5T0TMegFvKZKqiGJMgmHY8QmaSs6IZIvmFyLA2X2UtAieq3oGm+VK3m/2BMdSmjF6Voy1zUS0kEqb0pq3dV5MLtSOmziOHOguxaCrtcLKyFZQvgql7US/Q9fhfy0utJORJBvm3pI9QCZLlo73Fdym05kR7/aSMTYG6FraVttvt8tS00ylm+mtF6OykYwcMvbCiUBaozWqB/qXUrFu8JVRHNwwXLwkvO9h8kEc3CJ2JPS/U5ZPGGsta+ka03NU4pj4wypmt/5DypatPW3DWwamU7AT3yEuXKI98mQbr+sdWn/KaWy8WklLSZa90LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtjQZ23tt3D4yxqY0iHqzavtKN6O4J9ze6nfYavYv3g=;
 b=G4l+/3RBnH7BHqeDIDvPx/eFlSkA33zYc8p7lxVNRBZZlBl/JZzqeIkM1PwIlhOb6m01RoLa9Blo03i0UcGgklUMKEcICjCq0iZmiMfUiQvQkpxlANSuI1pHTuvpOI7zwLxedans5OMfwrCl8jAaJ4lDej7vEuHgxaktd6lKDpMhlH/MbMIm8vJWVCdMnDzfflkpUZftP5nBXkAjL/G2Fj8Y4CY7wOVonQUqzqFWE2I8+8P1pLj1Z6NXcfbsP5NQidJyen4+5CB1DC9E0SSF9J90HCzEx91E1vFxVr4LcEVfUJqgxs3ILfc8msX+ZIE3rln/MaEn452R2DKGULryPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:48 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:48 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 07/16] airoha: add Ethernet node in AN7583 dtsi
Date: Fri,  7 Aug 2026 02:44:23 +0300
Message-ID: <20260806234432.4098414-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 283dfb46-acd6-48b6-91d5-08def414b379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ofmiup23thw3bPFsfmLjU8J5ra2e6VRhJsCRjf6DAmV8nZN5wW6Cuu+YK9tMjCEA/4PiibDkqeswyVvpDxYGv+OaWAqvdAHPvdXEbVN26CvzFL+fdc4nnFawChGxhtcR3Wb/Dki0nhlsul3YUIKss+4Q7DYkkP8vCWKCBI9xyiI1X5THTSfQFlMOXhK9/Id2J2cFlIZTBuLcF5PebRUKd62+qMNPG7GNhtbreznkyeeZUoCu1RkwiYiBQDT+c6CQMYGguZtzJp56WRiqgNa3WUn+YL4t1e/gfHweDNmNBkgBeVhzgb6FoBnolR1m9aQFWojj9FtiO9ZMDXLBM8g9JEteaR4HKkYX8572rI4p4YR/PQoRAh8w7UhRRvGCzJAiRGsGtS3EUqUiviIeAt/b5I8dJyPRgrWoL3I+xwK7Wc7aTHwBfQPUbN3mmdTM9knTxB7Y1KPgmZS+5Boat2jCiK402pAh04GEuuGUrvyZXga5kTJv/QEglRnYKuGcwdOw4iMdeCM+GL01FG38teNLQWqds8J+3rqLta+2kVefqcppWLqA9BtMJqRh3M9bLl17etw69H/G2DmDqJLR2TrsDw1RNU4I6prd36F9JDqo5y1wzwHR1FQOSonxFqBiMnxL+OvQ7JaFG4cKa00bbPxJKRRxZA6VrmVNjuxFB2iyGO5jhWWRkE5x20R6KjOQtTYVsqiRkSQGE9MTWEic87eQwIZdPSWun8QQcR8AzBY/AsI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTXoRjClqxz+RiQRR+NOxIpW6mDP6H2RiVEpP6L5GxUfXTV1ew5KEgKj+fgn?=
 =?us-ascii?Q?PF3EdFiKG5KHeQq5li/xR+EBD9uLAJQqZKTGgykyke0SkZAJ5GhZ/WFC3DLU?=
 =?us-ascii?Q?PBiYuYOIjdRnc7E7hnkFFFKyOEkaiwQDtZEqxKxUasUp88d8HI3G7PqrUx4m?=
 =?us-ascii?Q?bzRQ1+Vb3VIMZbYrpt/p6vCo/Adl43fvJ6q6jf31ys+/Jffch0oPxl26MKYn?=
 =?us-ascii?Q?t2Lz3Kd48aWfNqo51INGbAPlLdXaKOJWerZQLciII7etz3SvgkfQ7PMjDIv6?=
 =?us-ascii?Q?3ph69Os/XjIT1xehqHImYKtfik3a5clYhq0WAmnZ+qWJ6GYgH8JvBPtpYe43?=
 =?us-ascii?Q?+v2sqcGFhemEQ/nBG/t9Py9OfsEySQ9afteiSo3d5yvjoNt0rxqihDJ7fWDD?=
 =?us-ascii?Q?PxBYYPBMN94BJ1XD/bx6BlFP+PLTU0iGz2+nVmP87qKO2EUZdc8hw7xkMvAh?=
 =?us-ascii?Q?CmDCrLNMI/5WZvLKWUdXkcVZbHOgl4Iou4CTHjsPJIyFCDa2J2KLYR2+Vr55?=
 =?us-ascii?Q?YdwtFgCmL8S3r58Asmx8HXgtXki+WV5w7RdxWfNq4+LNhYSBkNxQfFaemvac?=
 =?us-ascii?Q?Nhq97ZtN5vGR+tzJAW90F6wyG9IXpqhtFEBeKUTMy/dGtfagcnn//WVYOpX0?=
 =?us-ascii?Q?pORUB/YCoXlN+KiFnhQzCarL5HUnBYS331CAkvOeA3Ueh/oi8cGZhOJL+xew?=
 =?us-ascii?Q?TXJo9IsHVLwHkwY03XF3TRyqT37bM0KYpcJIfCurVaYb4dT9ZKnfPZSHi6iK?=
 =?us-ascii?Q?KuUUd4JAJaJCz2wj7Pu8bZ0X2FmQV874cGKOIGFk0+rB9y557PBXivyOAgjG?=
 =?us-ascii?Q?W1Kca3t2/0jjvQDEBdJGt9P0RAFt1FryHDYJBwjk6oRhDfU4Z/8h8goY23p8?=
 =?us-ascii?Q?sZ9npdbvFl96SfakCOgGOqbROxgsqnzFiq5DKjToyBYWMNbFuoaiULu6GfZq?=
 =?us-ascii?Q?T0+tO2KQdphvXmrFjMyvhPkqSqGgSCrUcXFG1hfIuyLeQ9H2R/2B3Gc+HQGw?=
 =?us-ascii?Q?XmUj+Vr5ouBH3oSvMtI+9abWh/fe8AwVrMaQS1PsnWoFgP9RDWUyt3Z8ZqfX?=
 =?us-ascii?Q?1rWMg/spRKW6X6Bl/vdSm54NT1BC+V5fwWMcBjZLQ+PKqlHNDL9n/J/kokTN?=
 =?us-ascii?Q?uZisLpyBW0ITQsqQFK27PtmanPXJY9vLcoCJJxqMCqWjkIc/e1tEcu6mjd7C?=
 =?us-ascii?Q?22K31RC1AgwPcANmTaJmKGovU8DmQmGVCxA1jZssxrG3fwFGNa5M6oypdfvb?=
 =?us-ascii?Q?NmTLeu8q8UrkWXXpiwyblylf+CpAhgKX2VP5BrO+lP+F5mqQR+jWvwqDwisk?=
 =?us-ascii?Q?MGrLWMzhptpkbaNdo05rnTFS6qAtMGNWq05nIxncj8Zp8uGsWvng4fipVypj?=
 =?us-ascii?Q?pBK7S8wxZhlDNhUFPqJ8FI2VAljclY+f4dBf9wWETQycS2+8TPJI+kko874K?=
 =?us-ascii?Q?L368QIJvU4G+cILa2tSmPWufJsdZzjxs7YiE6JbXLFx6EUkQ+TrHHMeHoRSe?=
 =?us-ascii?Q?cAjLnWhyguUSdLe/KlfThQO3gY1ue6WX+H6/ZNPpljTxzT9bwQlB00DmnH6n?=
 =?us-ascii?Q?zeDL4BC3Z+U6pmTgXmGnr67zCgnfUbA5q1dl7MgvneJSrbq9koOu3VkkVM0O?=
 =?us-ascii?Q?EMnLQWqQyGb2rfpBbZ/dASNemlCzBlRtVGCsRo5hGB2L9cxPiegh+B3ceh4m?=
 =?us-ascii?Q?9LVwdP387ryFV5jtnQREuL5ChNtB49r6QGx3XLPFRSIG9H0WmLTfVPaeQE8p?=
 =?us-ascii?Q?+2QcjPfMgOXzPCYCkV4Gt9swnloSseU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 283dfb46-acd6-48b6-91d5-08def414b379
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:48.2604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnHulXp2UwkEYLmn0kAUe7g7atNl01QC1lc8Z4ZOgWlrNjDppNSvQlZfGwou9/XBWeQxR7tlJdkHmlh6cVlC7SWr3p3REuEF678+bOS2Z6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtjQZ23tt3D4yxqY0iHqzavtKN6O4J9ze6nfYavYv3g=;
 b=5fFOJ+6z5gu5DnF3N05zkAsK5AnToXkztwmCiMh2rmHs8ZxeRgjEMmk757nmeZzRslvzSaK1+hbswEhGdDbZ3r+rSEC38FrgkLMJHaju5eQ3Gd22w/rJHLgczD+xNkD5JLTldw88D4ucGNGQXKjjskQvAsgE+5q5s5/xTbXv+jWpHBHFQYK8uVcKN++O6BprWMQA9eUwCuO4rGshEBsfZM1uhp1yQ/T+s3dI9mxDk8spbtL7UeQH5BELuxGaabL0xCnjf2C9Eubt+NNTdmx1swk/aGhDBI+FrCFwKkjmQqRNC4Qg63jiKL7D3PCE0zdxFV8p5V33N51F2alQd8ymqA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=5fFOJ+6z
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

Add Ethernet node in AN7583 dtsi to add support for the integrated
Ethernet Controller.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7583.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/dts/an7583.dtsi b/arch/arm/dts/an7583.dtsi
index 9362d2fbedf..d67b7459870 100644
--- a/arch/arm/dts/an7583.dtsi
+++ b/arch/arm/dts/an7583.dtsi
@@ -130,6 +130,29 @@
 			reg = <0x0 0x1fa20000 0x0 0x388>;
 		};
 
+		eth: ethernet@1fb50000 {
+			compatible = "airoha,an7583-eth";
+			reg = <0 0x1fb50000 0 0x2600>,
+				<0 0x1fb54000 0 0x2000>,
+				<0 0x1fb56000 0 0x2000>;
+			reg-names = "fe", "qdma0", "qdma1";
+
+			resets = <&scuclk AN7583_FE_RST>,
+				 <&scuclk AN7583_FE_PDMA_RST>,
+				 <&scuclk AN7583_FE_QDMA_RST>,
+				 <&scuclk AN7583_DUAL_HSI0_MAC_RST>,
+				 <&scuclk AN7583_DUAL_HSI1_MAC_RST>,
+				 <&scuclk AN7583_XFP_MAC_RST>;
+			reset-names = "fe", "pdma", "qdma",
+				      "hsi0-mac", "hsi1-mac",
+				      "xfp-mac";
+		};
+
+		switch: switch@1fb58000 {
+			compatible = "airoha,an7583-switch";
+			reg = <0 0x1fb58000 0 0x8000>;
+		};
+
 		syscon@1fbe3400 {
 			compatible = "airoha,en7581-pbus-csr", "syscon";
 			reg = <0x0 0x1fbe3400 0x0 0xff>;
-- 
2.53.0

