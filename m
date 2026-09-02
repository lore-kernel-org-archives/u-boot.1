Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6794C624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4A3760869;
	Wed,  2 Sep 2026 08:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id goXrhNdlZX1d; Wed,  2 Sep 2026 08:54:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339243;
	bh=T50hFDugTjP9vErVvsPu/Grqz5pyYi3EmniCxHm8yM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n8BMED4w7h9R8FML9S9DKoUyoCgcMKE8/y89WA2nt5NS4gYA+wApWP2Bd7KeyXZ8G
	 RdbMFsC3KYuj92oRVRcboaT8NWqlM0iyJO9BfGjFQlohAMbfDKf8+K5dpj8FEpblmS
	 t4Uwqc/YdPVbk7o+BDJmqglyEshxuO5WWsUDZFKcgcTApUG16nZ3FZ+VIn2+Y7MqWL
	 gV5hn33u1sFek+z63Ik8Alg6EtKzl0Qo41yRnDBMtsAQdcfNOCn7ScqXznKRml8/GF
	 U+/dO94c2ZMoXW7wG2A2Lwvwmx50vERTy2PvdNQAz/0Fs9f8iBO7R/F8vRZp0rILsp
	 wjwgY8TlKcJNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D3F16086B;
	Wed,  2 Sep 2026 08:54:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C857B2FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAB6F40329
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qBCIwHZksCBz for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=1GB4fRtc
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFE2B4031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWxFHX3/dYD3jeY6b0qbYOwt3Q+aiM/Zg+elj+S1Si0WVJZi+fktJV7WmLbSHDyA3RbvWtmg9M0kWH2A4OpM1F6NNs4V2SkyACmXvAaAGrOxo25TJFD0bkn5PQpuofI2Bt9LxVCn/OGuIHWyJMgXAJN8eUGEojO7KAKswWWensvT8Z1iZBsdJ1Og0hdzB3iSSBCgknaNIZOIGFaiLydPM+Fg9fe+VVYLY5FtRE0Kx/fcReAyLnwYV8Tau2w4GjYE7ksYk+FUy8ocL9K9tKtQxXxtDfqb7Sw/qNaXQu+B3BSTsFJ4M4DQ2mdUu0aCymrLdgPINCb+di2m3RfDfwA+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T50hFDugTjP9vErVvsPu/Grqz5pyYi3EmniCxHm8yM8=;
 b=xCpaG65D0nqJH/wEFQGkx5CU7VR/voeEH/MCCnpP4VmUi/iTEZJg83nn1+nNJz0r+a+LU6D3Hqa5qO0yVhTFVRPXcWudMJNDZgtKl0r1oCJ2+CQq4Ny2EAtzScTX2m8kNWWeRBItWEoX51WQ2J5vL2w6ki3fIBh9QohGpjQcTsxQj/Oy9XoB52egBwcJqkd8JZzajPSQ334oN/SA+KOFx/mzq0CzxwmFDvoWISPfpZCTajiCLtgOHiYGYaJjSC0rTTVYFGcTho80T1UWz4kQPC9X42GHb3L/GHz8SlvyhGB1na1wkFJjmiA+GgaHubHdpqAAHv45Azq7AQkBFG+LwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T50hFDugTjP9vErVvsPu/Grqz5pyYi3EmniCxHm8yM8=;
 b=1GB4fRtc6s9jOkyeqj1oX40bCb96iPXaAfMdN6IeK5rJNKhJUTmH9xmOPMdyumGorz+JLUAo4NxBlRZjaAyKUQMK7klE0GEv/FCe1wfTFTFZNHvb3lMnHBHXZRMoix+6led/RO4YZowbeJzKN64Z6Rzx4rneIoKtKTbs5YQQ64YYMNQDcGGFJByI7/vBaB8WQyNvAFVS6Fc9BWFvsl4pfp0vIDve5/qbVnW+ZPpWV18ggxM3UeJEZqvkv3k0Y7PaBj5mTSjCY4Fdu8pTVo6NR4qvStryLp6Uwpfq6+93WK0DaC32EeCOJMjX3Hm2ZKce703vZNtsipmolE26Of+baw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:54 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:54 +0000
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
Subject: [PATCH v2 12/16] airoha: add PCS node for AN7583
Date: Wed,  2 Sep 2026 11:53:07 +0300
Message-ID: <20260902085311.1550804-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: bd836a7f-9c0a-4450-8ad9-08df08cfb78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5pCAd+j15j+gv7MXtkPioiESbTuB3+vno4e89vfZB2FqaWgHtHwj1mvwJpoVGAicCQi1mB80Fz4WTB0sL0Vcjtk1BvaNabmgBoStg5QTzwl88GAS9NelkZUcaU4goL18qpUA7gvbkJamfAJgBVinZpMcCqjQ8uvGHtPSIVRg8Rbu6VVIjo3NPsoIxS3chT9jwObSHAWyQxevdmIwO6PEwhWKbgvpm0C3AJhAHpgjRih29ss/x5WTxoz0r2ci0U7DVnCdzlTPYVk5qo2AmxYA210N5YJmPnhaMaGybtpjSvmSfR5Av89xYlWu05qvsB686BXHURfArMWYU7Mv4ceEeqCtTp6Ou5irkvUgGCjr/0Hgun7hU0IYj91p6pRktx/J/SJRs83MdcG6okPWOBEMa2GL1sEw8c1GFVTToPTWdcDHTNlyPZBSNCgcO2HcsWZRPq75csP15gJkJPp3HSUnBHpiLi/HSewDMqqM8EDYGv9KK9EWSQT9U8AgtJSSJO5AuOY5Uwb3t+nCUmuEIKmB68Hfu3cwuTgzPOVOnqjYVw98ByzgyIZRCEBsxr1xH5nW2fyiSEt4psQoLCa0wnHj/XA5d3wzDxLQ7hI9eDwjK6jAMaf32vBQip3EM6PGj7j0cElSWhvtkhxvMOrIqO5LULvt1RtcJlrcsbQ1+HgX1R+Nk6HAqh+rl+pjEHG18YKWiCQhaXwNU4nyftpt+m1aZaiugyoV/+ipvG8ak8d53+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AlSff9C3Iq4/IhiKdKPNgM/akqrSAW4FALZhGoVZyeS564WXgrUJauTFvuF/?=
 =?us-ascii?Q?EQVKr0TVUFPNK3eCyL2GVXfEjOWR8Rje842+08EwmyoYoBrHa61MR77AQddJ?=
 =?us-ascii?Q?D+UTTloslJplV6PdReYZMgdjGFOBmezc21xl6/sWvh5rizIWEiKCnsBmFJUM?=
 =?us-ascii?Q?AGHuxLG/nwUT5/H7ojGcAgcD70l/dHaeG7JeIuQyLhqGHPMw8fEJo3ksW/Wl?=
 =?us-ascii?Q?RLoU1ppZ9GZ5I7seLZcFYfd4YiFk1UZ8XxU8r6ffe2CXn9xBmP8aGXabkjPD?=
 =?us-ascii?Q?bqrOqwG8Y3XHVypTLe3SGsIPL/1x2MwsNQpc2DYjcGLGTJl6OC7qfpuz9eyf?=
 =?us-ascii?Q?wq3ZIzcWanSlTCoCkFksnkZu4Pdck8/MMbaRSZU/dn09ideneuo9ztgjStSX?=
 =?us-ascii?Q?XFvZAOA1R8HE3J7JToDdWjgphQGuB/SKuehr8uiaLkq1BdKsGWM+08ugjr01?=
 =?us-ascii?Q?4jCCnYIw4SOKnG/9J3fS3n6QqNTelZ/2QjUUPr+SGm/cUyVXZFo2VCFa7RYP?=
 =?us-ascii?Q?52nxVoYHgDemx5V/DfcM1ZLQQrZMBYlvtF3CE/ysbR3XlGDEV1osQxvZgYba?=
 =?us-ascii?Q?KCxNTOYMss0jqLx1DUese7oBIfI8Ir8BCOcytqhFR2hl9W2SCpPLlptyKZ+n?=
 =?us-ascii?Q?pJshX2WpEZsKYl/YqG4DeSbdpGm2EephQvvCWbISQ+w2fkrDlKNCzpiR6ri/?=
 =?us-ascii?Q?Ia7BhllHjQ6kN/9gX1Ut/qlz5FBU6wDh22l3qxNMkrmGCWM2v/SFS5W4EfZ2?=
 =?us-ascii?Q?PypRUcQQ3NPtqTLwL17CDjLXgPWC59dGunWEha1onWi5ZWOzTzgtrV+MTBkT?=
 =?us-ascii?Q?Dcx2gJXEm4d3AM87dtU0CnOiSxd+/U2Ur+pDzstVMZaBLJU81XERcJCsLdbe?=
 =?us-ascii?Q?m/OQfwKSty2OuQ2Ec1Q3j97KRxRV6T4q63b5dwnSu/ZmgnDX08I0MspX9vgM?=
 =?us-ascii?Q?a5mRbhliLkHyN/Bpv5+42OBeFQh62M1+eQO75ZNyKpAL3v7B/vcekhMv0QKz?=
 =?us-ascii?Q?n2UBLTnzR2PNrta3fl+l5jxX9dUZ45KOOfOuc+mRZ5Ysnw9Vnf10jkDUR0c3?=
 =?us-ascii?Q?fsbrg0Z2bB0RzcEceB8mRLIJRxkuYWbJigSvHLncPqqmgJteW3aeiNFlewiZ?=
 =?us-ascii?Q?gPKNfGusB224zky//3x1JldVAj/f64T+saJogRzA+eUiuDrf+A3J7fgRWoEs?=
 =?us-ascii?Q?JzOQZDcxeTu1WPANKuiTVaT6zi4JfM3GPlnWkLwFUpXc+UJqErgOidhyivzn?=
 =?us-ascii?Q?PZNk71CCb2dfEYopjRYp0/472wC0KjoiL0fE6YwMWIaRbVQuydG+zFhGBRF4?=
 =?us-ascii?Q?H+7Fn+ixE2bIYfmGj4Mn9uJQY3PSrwEqrYXIkUzeCTvkmPVTsrK28eBQBU0U?=
 =?us-ascii?Q?6bMJraMWDvbuTjDfdIhUycGHx3cljmPNyR/djNLgAhrMrj87E3SQrqXWdFr7?=
 =?us-ascii?Q?kTwuSkWzGfR66DxyZjg/96/Rd2DKX7R/PNXkQ5wids6hWn8TbjzrXlByQOHw?=
 =?us-ascii?Q?lnr24WqdGvzdGZ0Y0sbgzuo3veZbnMAKJC/KojScwEuCqCvg4SucAi+fPYIo?=
 =?us-ascii?Q?MXJNCQuKufubtO8fnn8GSsSYGeM9dK1qkv1hIPQnZ2sH2HHBuk8RfAhKQhj7?=
 =?us-ascii?Q?DgTA1n9GmzQ/YJY6rYtdvHSfQ2GZO+yJkJ4ivo0iCoQHJPPgcx7qNlRaQ6jY?=
 =?us-ascii?Q?536NZBuOELlLzzr/djo0NwgmfDHUmdsYcgmnhTjGS4XSwLTQ/nVgpIhSpXnU?=
 =?us-ascii?Q?XxDxjcIXEgDTGxcaX5T3UiEfWdhydQU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bd836a7f-9c0a-4450-8ad9-08df08cfb78f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:54.3936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drCPhs5bMDsFrmBhhfL46zCFrmBZ/ftSatnBHp1MQFOYoplogwhc9sDoQjNodBZzLtZZY9bwG0ShCqr9Xk1t7vVAiTGE00E00JUrHkHnOAo=
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

