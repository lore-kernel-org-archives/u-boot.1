Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5422BD6E2BF
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 17:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0156383700;
	Thu, 18 Dec 2025 18:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="AvyhBmof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B7A82BF2; Thu, 18 Dec 2025 18:27:24 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7363282BF2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 18:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tp33a6uz/VJmGXE2WDF5X31cnMcOI9zbK+R3UyJfy2NfmVeWuzNBrrhAJ+lrcC1XPoW99VrGLvwW141AKiEOU2VB0JkwGvPFWwoZduAGlVPyZd60U9shPoNguP02xs5VNyOKYi0qlZFKfhtvVosrj2siDn5S0MZQ0wrWDaigFEX7p7K6WHWKJohyVAoJar8T9BQZG7YRpd9WTKZ3EqSBA1ykBG04sj6e8F9I2LnIdbg+iPbqhgIejwh/u7Jt0C3YSvRLe2IpMtG3UHHc6c1hRCnSh+/zOEhiH3YuXJh7M7P5ou12yCWWE4Jdr+qsr2N5JcgkFhumNHzGZKsorcVAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smcq56XJZdWtiKQPdxXGOoZDKmRm5jLl3OQQ+wEGK+A=;
 b=t5s/8MzyeWC5IevkjtZSt0Svp34sjBAFTL9eQULaUxTHMeADOYR8J85iEY+Ev6JP08UHO03TtZmA4P6pVw9mNv9x14kfB+TaJYZQQamb/JttL9fT3R8qS5HVfiH+dMB3MrbkKWnWFk7ScEHRONI9wpcpQfWjX/Pe2hZ2shQ8NLnvTFFRMIyHyR7fmIBd9f1q0YjZhnxYOAQ9UE00e7WlSfY2NNOym4bn+UEMHgOmyzRBs3hv0NqE48v2inr5OTM9eF62TyMWLABypw4K3aUE3uFllHBNPsSdGv0HqsUvRS1HTt/pAcQ2REXHEiMqs08HnrSu+c1/GS9bjYqRpEj6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=renesas.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smcq56XJZdWtiKQPdxXGOoZDKmRm5jLl3OQQ+wEGK+A=;
 b=AvyhBmofoCkZqqbv7QMtHh6ntmc9dMzwzsmOixU+FAlLhwausQqqSFklYXOO2+coJtLMuUmXjC03dKLcRhJhe/ds4bEgWogg+zowrTbRzaSXJ+cLBLsK2gb2vNnUHxRLRoxVXe6O7sdARGC7AMmZrdRs3TCpF79isxsuzmNdSC90enQCnp5vNkGjB7wYjoyB/sA51+ao9nkRJS5vdcfsRr4T3DlOaZkLkpDekV/9Blc5PysPQs/n5e/XPFIr1YvxLJtNKhFpdMZMAK79HSD3Ya9+MFxuPCPeYBqpl3OmqwFD8HIrxy0Ipd44ytCh9uZlifcnzuGK0+N9fIB8O1e7fQ==
Received: from DUZPR01CA0223.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::10) by PAVPR10MB7539.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2f6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Thu, 18 Dec
 2025 17:27:14 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::e2) by DUZPR01CA0223.outlook.office365.com
 (2603:10a6:10:4b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 17:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 17:27:13 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:55 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Dec
 2025 18:27:06 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 18 Dec 2025 18:27:01 +0100
Subject: [PATCH v5 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251218-sqqs-v5-1-9c7e2466b797@foss.st.com>
References: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
In-Reply-To: <20251218-sqqs-v5-0-9c7e2466b797@foss.st.com>
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|PAVPR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: cb43c176-6457-44d5-23aa-08de3e5aaeaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGNXWTRDejBsVys1K1pXQnFOQkZSZ1dTNDF5TG5tZExjUldBMDlieEpkd2tD?=
 =?utf-8?B?Y3E3NzhkRWlkMGxDdGxHNDJRSUx5RjhGeGl4cWlwbkhhdkNLOUlkWnFoVndR?=
 =?utf-8?B?M1hQWDhZUFlZKzhxbXdzR25jbnpOZ1pYY2FMclA1MGhDaEJ4b09ObHpzNnJF?=
 =?utf-8?B?VGZvOEU2bUJsZ0NrRWp0ZGhQTWJxcDhiQUZ2ZGpIdWExZE8yWDgzcUppWTVV?=
 =?utf-8?B?dDVrNU03NVVRaFczZlpaNEQ3NjhRRUJ4V051SXNqR0h3dmxZZUpjb3BkdDNM?=
 =?utf-8?B?cjN2UDhyUUU5VHloSW8wZi8yTFFrVzg0NnNiSElEdmJEeCs0akdpZ1gyYWkv?=
 =?utf-8?B?WWR4MnZyTHZPbmpzcTlTN05iekxiaVlmYmswWVUzaXZBenFnbUh2c1dQRkJh?=
 =?utf-8?B?Z0ZvclpzSi9QRklzbTlrRGJCcUxWMFRKZDlIWDhhQWRnbFd4NW9ocXNIb2dC?=
 =?utf-8?B?V096cDZTbnpYY1gyQjQ3aXBsaDdwWWhkck41cTBlRWptOUJlUmZCbmZJeXdh?=
 =?utf-8?B?aUNHQWI5bEY5Sk9ueTlNV0JiNjk0NTJHMVQzL3BqV3hIdEk3Umw2WlNFTXIx?=
 =?utf-8?B?YUhQS3BUS1M2a0hUa04zTW9XQWJOS0lvdjZwSytxTlNIU3B5Ync1NE9wNE12?=
 =?utf-8?B?bnpLZXc0ZmxhUHQ5WE9WRlIrUFlRbm1rMFhoM3diV25mc0toQ1NSZC9rN0k5?=
 =?utf-8?B?WUdXbHBCWnF0SzFyMU9oRk5VRmJOK2I1ZzZMMkpVbG9TRUhkYmkvRXRTZFl1?=
 =?utf-8?B?YXJQUGZzOExLZGkvTTUrdlVaMUt6amFoekpjeDl1aDBNenExTzJyRFRNd3pk?=
 =?utf-8?B?UFRqd0xyR0JoNTFYS3YzRGZ2eXBrWXBkRHk0MnNIV3p3YWxZTjRuRExxNEFZ?=
 =?utf-8?B?d01BV3c0UFRhaU1SWGpCeHdzUXBxZTQ5Zzg3SVphWGdUM2ZSKzM1SXN1RGJy?=
 =?utf-8?B?MmJGK2pWbkhaQ2pncFRMbmUzRjMrVEdLY2lTbUtJenc3dzlLQlN3TENuQUtE?=
 =?utf-8?B?U2tLdHdrMm45TnZsTXo4V1FUN2xFVUEwZ2ZJV0Q5a3dOTENzRlA1YmZtYTha?=
 =?utf-8?B?aU9mTlcxbVcxb2lrZ3htbFdObkZ6ZTlHYkwwUFBlcFR2TzhBMVBxdHlMNlpp?=
 =?utf-8?B?YmYwNWlpTXlWT1ErcjAxWkFkZ011d3M0OVNjSnBVdUI1b0pNVXhRV0JNV1lp?=
 =?utf-8?B?bytjMnM5ZG1XU0JJS1lXQW14MmtsRlc3Zyt3WXhieVlEWHhjVkRvajRmMWJF?=
 =?utf-8?B?YkQ4K01uSXQ3eThQN3MrTzByNXNhYUlhRWp3K3BTcyt2UU5PSExMMXJDYzYy?=
 =?utf-8?B?UFFDREV3dkd5eEJla09OQ1h6OHRRY2hQVEFoRElacFYxQmZjSW9Zb1FvTGFV?=
 =?utf-8?B?N1NPM3pZREtRSk5sdlFyblJZQ0ovTW1YbjVidUgweFdFdUphek1ucG16SVVF?=
 =?utf-8?B?TisyLzE4Ym5VRGNILzJsYk8vaGVKUTFuR3FtV1RTY3RNNFlKMG8yNVhwNVAv?=
 =?utf-8?B?M0YvTjJCOVFTTy8vZ1hUMXd5TERIbXgxMmpmMjFrMHF4OEY3RWJKbzErak5N?=
 =?utf-8?B?cXdsemRqSFN5UE4vZEkvamdkblVkSUtXNUJvSkdnSUNmTUJTQ2FQa2wrYmM3?=
 =?utf-8?B?QWVtQ0lKOTQrYXB4YmdTQWs3d09GTVhZbzJsSkhaZDdEdERseTNLOWtHc292?=
 =?utf-8?B?M2thQityV0hwaWJOUVcvRFNaMzdheGoyQXFoWnFDYkdDRHV6c1pVMUtJekxq?=
 =?utf-8?B?Ni82UFN5bkZ6RENzVk1LVERwYk5BUEMvYlh0cTlKYTZ2WnBEMllzdXlnK0lq?=
 =?utf-8?B?UVAzdmZudnUzVjRKWDArd0hnNGJZU1BWRHd2ejRST1lEZm9uQWwrTjZpNDRN?=
 =?utf-8?B?QVJJMi95UzN1aVF2Tk9yZ0NIWi9RZkVrSTFlWGd2Q2FNc1Uya3Q3VnpneS9o?=
 =?utf-8?B?dWNKOU5JNEJFbUY1RDN2MFRMQjFYVUdwZ1JRRGFPeGY5R0pXV0YxbkpzZi95?=
 =?utf-8?B?bGJvQkRWVnN5ZWVFWlRXRHVQbUMwdHlVNEwrbzJIU1MrUlZDdkJaS3dlZGpO?=
 =?utf-8?B?bjAvSEZwbHdrOFo3dUU1a2FvRGNTMWdUNjVjZjVLK2xBblpHSjlRSmNUSWVH?=
 =?utf-8?Q?Ad4g=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5qS/F9CpoioieNNYtDX58T+PXlG2ba/tKrzj8pQax8FHAClmkLfiivq5FcaUzymt2KX9Rob+OXnB5rKDELKEnvl/n55ljrWCe8L7UQlHpAnNqORsucdXD437itGKIDoNAFJWpDmCClg5gMFJnHKnqW8L9yNAG3fI/eVAEGUukB+nkmQHRiSudpLn+iz99e2loAvX4MW/zP+aMf/gc6pGzT8WY+wfb1QFWutoRamkcc4R/PXXjYUQvOSJDpoyvJdrqdMVRWsmDeq0l6LUwNgr16Bk9m6xOcfHijPeoDY6K0Y3IWBWUNOfD8XPS3unRjNsAGjt87dYf32JZDoREmUfIMofZztvOJnPNXqUjRbhcZF/StR2oQ3FK7VUHbr/E3cVO+Q0g3BX9E8H0s7HnRU+h9mdu2XDVq8PyMrzcfRaCPClgY2fYy7hPFg/2zvWKc79HmxNGs/pYajkvD9gesS/jL9Vb6gsNkRFfy9IiAzc9mStjhOxzkS0nW0GLPO8jBXCojnWyQgKJwXkExTGvnAAEzJIDZmBCiZP8PA1aPPpqRIKsbUknJ38iM52aj3SVkyofdpJ8/1AYtuGXwbGdNzp8z4mUl4Qg6Cp443E1PEmvDWtmhYivknWlIL4MeWxGayM7tYhIzmenDhnIg2ht4Il7c4hD2TK81woXHi1Pg1cBg0U5HA+VPDhb6ZERW6H9JJN9iUNo+xn12h+jQNmIEFAyQ==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 17:27:13.0504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb43c176-6457-44d5-23aa-08de3e5aaeaa
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7539
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

Fix typo attibute, rename scmi_clk_get_attibute() to
scmi_clk_get_attribute().

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/clk_scmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 683ac822a01..f6132178205 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -87,8 +87,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
-				 u32 *attr)
+static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
+				  u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
@@ -183,8 +183,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
 	if (!clkscmi->attrs_resolved) {
 		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
-		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
-					    name, &attributes);
+		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
+					     name, &attributes);
 		if (ret)
 			return ret;
 

-- 
2.43.0

