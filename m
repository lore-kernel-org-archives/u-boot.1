Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9C3C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A9EC80FDE;
	Wed,  2 Sep 2026 08:53:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9nchkaUyoHKq; Wed,  2 Sep 2026 08:53:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339231;
	bh=jtjQZ23tt3D4yxqY0iHqzavtKN6O4J9ze6nfYavYv3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsIxxAKqMgFj9vBfiQ4/hc3HdyIokrFFlWFY7JDVM6jNRXV4/jbgT/mX4XZwP7+1n
	 Dzlu/O4qbD3B1BKmbDMZmac98eACXEDT5zuwqMW5SXM7fC/r+1unbJBr0WY16XHTwY
	 r4HRZBJfVkkW3rQdwSOPmGw6xO4IquvVXfafm1WOs5Xjm87UyF1pAsNMkHysbSBprO
	 iTZTZC08LUT6Ts8xojE6L61E/DCnC2GusOP93QThkqFOe77NPylCoWfL06kpAhAA+4
	 7JkeHfVlp5RbQyL8fdElGq46i16XFZYCJCPMd6cTG8UHX6vfbeWMQAwpDSyarmg7LU
	 H/4PJJm+xBrxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC7580F63;
	Wed,  2 Sep 2026 08:53:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 19F5C265
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B5EB6086D
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83HqRgsVzDoE for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=GWzVCETH
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C90D6086A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5Ce4mqFtiB5QIcg+MdTgQUu286vAmdvdzDhYLfZW23bEOEhQjMvPxnCODYflCxUprh8OEOWvhOfzls0X/tfa+muUEbEwQSEudRvuy0/vKRAwuDGd42W0+usTYm1B0I6EAT4zIarKH2fOYV4BHDfKrahTqZViNmeynw2XKXdyylMPcVVFnBtTx2BFi0YIXYV636P200/jIp4J3FZNpp4Hd6jt2iGzh5J0fvD0ab+hdastqER6XPLVuC7xixiCuCV9ESlVPJg4MVCgLtG4zj2x4ZYJ9pLh1BC9Dqc5tYbxXgny5IgHE+zv2oD5SzOz7e+GERYuXj7J4ItSQQN96Tupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtjQZ23tt3D4yxqY0iHqzavtKN6O4J9ze6nfYavYv3g=;
 b=aI39pXSfxDnWAeQg8nrdWd3aG2rhMwsgKVaFaPSlspU7xF1ReLVUbiDidkLH35czHFE71hDjdBolquVqx3YWBLlD0aTb6Hvj1Ag2sl1y4jFfWCJPOtAR/T5p4u4xEOoUcHqg5d5rljfRVooOsTSgibvB0UGrYPRkwf1pSB9nXW/YVncqAdE7AK3sbOy9nInW9yjkmZUe0V4el4uO+F3wEViquclaU2LR9LDYNAFElgJzjp29qsLZixDAIXVAEOo7rvvyUqUpFBzi6vzGcTc6S2O3hrGhhgO4/XqMLhe+zuAisn6x6QiC07R4aJbWNsn2S0g8SNMt/HcwxjWkQnWghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtjQZ23tt3D4yxqY0iHqzavtKN6O4J9ze6nfYavYv3g=;
 b=GWzVCETHjJinmiez5VkQdrkZj4FOEmfWY3i5SLtBrvNGLGBlJaRCJlUKW398ev4yQr4ek0Aa1iN15rUynI/55AReNghY2+W3eLzwny4VJxPJ8mcW3U9VODaCyA0mb1qtT21OF+Q9bMWCrpAiLydyvcWaqkclbhGjolklCuseHBVAguvyYj4J4BAKe1G9XKGjXyU/NOT3U08gGUjVEnfu/MUCJjFtTAlrco0chHAGRICfI2Af/15dGCfoMyxc3K/VQIv1kY4NthTmK/iVevOnh3qyzg3DVhTid/qEkoq/b3LaCltfcSTyeBjdxhokVjMWAdBX22gwzKXWPj0lEkoAVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:40 +0000
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
Subject: [PATCH v2 07/16] airoha: add Ethernet node in AN7583 dtsi
Date: Wed,  2 Sep 2026 11:53:02 +0300
Message-ID: <20260902085311.1550804-8-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 698059bf-cb7b-4f25-0b35-08df08cfaf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gOIEkC33CX6ojZriGHZ66k2xWR8MFrDi52cPZfh8e0qwx1DpzAvblYhIcM0NqAd7uJ3QRBzxjXzMjmoJFGTja4yw0aEBEtrX80qcwI20DUoSHoPNyD7j6B7c54FYjDRXFYsFTKKrW4bIrD0jufA3cwvijCH9sQUNeSYb8m+gmIAERVwopSmbrUfIffE87Hzb1RDHc6Oc573MTBVDDxbLyYAotBiw/XXmYPpcwkZYQQPKr4rDUq7Ag/TTGGTW5qmc401dskPn2kXW8F1rVDKJDXQoF/BL7f5zK8wHaw1K2fvt/8nmuMdrXY3ZlKSAT9jIuE2f9UbyuCFfKw12B7znqP2HdQ2MU2ghnCbBsd3Xf9iiQOlj3VE46KFfr8G/wvEIefJAiLvr1hUvWRWiqwQYWJBQMl/EsPnLfhbu7dCSXA7/9wxJW5VOQ++BzV7B2CTYul9qnlA7FXgIR/Tg8FiP/0CzDyIXKaKJCzzSuKArEVknAjcYKBfi0VB4vZZYexYNadbJR1oG+cWKv+jS5LZk4wfCNRT0huZoTpROmE+JLAda1IXdR+nLHr0IfTfMEuAvLqxHMK+/iRI9COuftjxmT2ZRuDPXBujmv4d6KF6uP2pLMstxkSyjwaVIoFMduK/Fyv+bVr9WM9Lq+49ZpOLunHoQ/iwHm/5q8ebpKko5nJF88/rZ82thDBQeuXQPSctzm3XsAEgySgUpLjsKHPeXh/rhaH5vLC9pxdsh1wPN+AI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9u9IsD331XtQ6ZF7VewwT9wp1NSMqry3B2H+7zFUklvR70NMR58/FxvOKui?=
 =?us-ascii?Q?zQXwOBEJWnUo6uVZLy3WrKXz1jQAk5gNKW6HQFhVK6g/FfFVDX9IuoLCTPWw?=
 =?us-ascii?Q?EXC7c4jTcVKAHQ/GJE3iOSt0kO2tq1PzwYp162lUfksfiCfQBex+sCXb29/r?=
 =?us-ascii?Q?zv9vqllzmc2cmMrMD06DpFS2HTsIaOKfiGTmXYghIxSQfUAIs1W5Q1W0IjeY?=
 =?us-ascii?Q?k0FmE8zUsmDr91v2uSFVyS2yrZpgmjTrVheYw2Y1h2bAEVw5MsaREhIHlWAn?=
 =?us-ascii?Q?J88vYjdGG4XwSpiqdqoU086ia50x9xiqXJqUSYrYAb4SgFM55+wf1Bs4Mbp/?=
 =?us-ascii?Q?EWIxgz5bxDjhpL0TmNr0ztLkKLmMqXQqD465gOEkuZcWQq9QdeTqjTUi0ve6?=
 =?us-ascii?Q?1/u/hfapGaPHDQ+3ex1WzG6f83y9GbquIw3LBV8S16RYspz+m59mVe7Jd07p?=
 =?us-ascii?Q?fSf6aNL53A9chWD8YCKoLIX2ye6T96OsrhJBS5nL3LPvRbzjXwr/WROMogC4?=
 =?us-ascii?Q?Qoly5bZE+0YVaXMWtcynmd7QeiG0YzlDmlWYUpBBiipxeQbf9fTUK/iR4d7s?=
 =?us-ascii?Q?q1gtTJ1fpi1qyacfqurqZGTkHrB7TG3xr4A45E48ehC0+RYXh2Lvv27KreCz?=
 =?us-ascii?Q?uQwklkHg5SycOfJ34CS0MFT1DrVjQbUjCzqUeX8QTBJDdgcMlzor/2m5xRGw?=
 =?us-ascii?Q?53vAVYXp7DMxE37owmtccaJm+Y1o5kL99M4/dQMNVcbrWbqNENjBMq1ZR1rV?=
 =?us-ascii?Q?9+ByKo0loa0umS8uCn0EQB4eMzTkbVqeIqdOHMWbkExr5leaRpo9NmMuQKwy?=
 =?us-ascii?Q?Jm+R4D/QKSQloQBpNJZCqxvxtrG4ZOlKPktEAho7w9jtdVMku0h/9iuraBG8?=
 =?us-ascii?Q?S3tOAnPCdBOB21MIOpYKOO2P+UVtbDDeOapM7ubSgE+M/AJJ7ZfTlqU5FFjL?=
 =?us-ascii?Q?pJ140pSp0cBT1/WT1upPwx1yuFmgZP/hmdleEFuFOMYZ3vOkIXxdgusjqZJ5?=
 =?us-ascii?Q?NY9hEuc0XoOQ2TcLx1wkIRRXRgcHtk40a73W3FSiTNrt+DzCRN7U0JkWiTRf?=
 =?us-ascii?Q?oxZL92zODYcuPWZAOvLzhXoj+A8rw8S3Sl0y4x2eqFq31kB4h5a6JfJtfiyt?=
 =?us-ascii?Q?nVIZyznYLUJLyQXHyLvHM6+9qPl41LOTZpHDD/jAiYP+KicrqVM3XKM+GlNr?=
 =?us-ascii?Q?FmrPHJs6sEBDAvm7jg64aTg2hUeiOKAfijs+8uhNcmhOCLBENo8oOOw93ngs?=
 =?us-ascii?Q?S4AkN54GPMN0gaZ+DnplX+3TAGTaMEwWhUeC3gbvKP9VjIbwQRC20fcU2dH3?=
 =?us-ascii?Q?C9XgMsThNMvuWrLZjeA++IyroKQmNM7gb2dCJXfHkWEREcEJ5sNgQ4cOBC0C?=
 =?us-ascii?Q?AyBHI66KDsQVDlcanrxA8Nbl6YdzLaS0KN8H37QQOKJaTAUWlAPNNYKrwMT0?=
 =?us-ascii?Q?EXXMzcNu62V/i0YuyQrBjGK7TmLGU879v0ZAplUi7bzKrvsUQQ3NCZNjY0Ua?=
 =?us-ascii?Q?dRcGMuTyatKuxt0XNrAzVP95cabYFuSZmYAd+PmaGnkWbRq6kP+Pq89HQlEv?=
 =?us-ascii?Q?ISXTBTluF1WWlBZs4CfpXGPNpz/wyH2f4wsZRIM9haeULCdwxQ1welG0SNK5?=
 =?us-ascii?Q?Gcp8yxzub5rOl3pXw/xF80hT9wBidEMRBQFgJdq5xyphy58RsTTeAMKkXTw2?=
 =?us-ascii?Q?Gq3gn+iXaRsYyvHebkHCdehPiX2fKYSHPuPxAYwOVPHVxgX7j6VC8vTyKzKl?=
 =?us-ascii?Q?KpXccKdSyyTtjkg9j+PCQxT/f4KgMJY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 698059bf-cb7b-4f25-0b35-08df08cfaf31
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:40.3485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV5ZbUxgY5wwUhbwKPC8DsA8Z84SFmUYUK/pmIAFBeA9FsBz9Wlxlauj6Q9/9BtK2gP+fsjSKKH8ZEDcf7lg50w3XQUWDJZuuu1y5aF7iaw=
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

