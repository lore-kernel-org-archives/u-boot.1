Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5112CC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 10:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A08B7846AD;
	Fri,  8 Aug 2025 12:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ZWT/ZBOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622DE846AD; Fri,  8 Aug 2025 12:04:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E1A084559
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 12:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLz/LWipI1kcy9+zSJPIQ2VdOMJ2sylSBVG9nhcFyamsa4kKl6SrZpIMOf1nT6z8GJIX4OYF6xjAjcSrnDTxJHjh6ME8XQ5RclDh5hExB7fKkffQ0Au0pn+BI9egNqapwAz/tCPLmehhNQ6pJFq77vpgfqu+YPN5H98m7Cs97FwvsteSsjNdnFFX1K1QGXMkedeEfXAgPdCSmSsaxVPI7iuhuXy+TGOtWBOyzsXQkWWVfEBJd7ilr4fZ++yqVtSTTowrqinj3h+4s1ktbCxK/4JNeiTkv1j7CH2dIjUEboDnb72jH+u2q9SLyRu4TtraSvMW5nIStO1QQVxq0zB51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMykyzucuqU7bDZc2/kHwttJRYF1ilOn7yMafmQcStQ=;
 b=qwlwnel1NRlYwLmuJnM164CqfaHA4iW5fRkObrkGF4H6KbqOnWjaqTz//vpWiJdeWAIAkhrS8ntSbKFNmy2hfJu2SEaomBKN/SB5is+YFIU6QPT1OWD6bzvK/N9DlL/JA02Pvy9EUQDcjyxQvWOAuGVNwviE7+3Z+Uzzws4viYTwlXOW78IjB3vB8dCILvzxgfOAL05D2roDuMQ9CZwQnCRBaXJWJz2YDoMFVjfyTuoGKqn9Wxwv7KbcIG6bSyksmAV3qa8BsYeiC92mzmoieG1NK3WKEBxJV0llGPeuU40GYFuh69ayUIrvtgvC0GYxf3Ui9kmlO9tzYEV142nnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMykyzucuqU7bDZc2/kHwttJRYF1ilOn7yMafmQcStQ=;
 b=ZWT/ZBOfwnWKAp+cJy63Cw2RVs1j06fD1+0RgP9BGPgtHm9h9zjTFNPic9e2VHt1ynTP0RSfc3YKtJ8bwpHN2r8qYEaraeQOQw4OjThiMRzL95mMAQMS+g3EIcq3rN+U1GXgWM9REhj7H8+pk+ABWjma97BAA1ef6Hz3NgIBHH96/brotN3wZVtaKYh3xZQ9g5EGeBpNaxq+sfeXl2jCbV5GGJySn8SGtV13lgXRLZ4OGzl0l+9siZV/fFFw42NQaQojycVRVcxj3OgI/bKGddQmkxlKghQJf35lKb3RuDiIf5Ap7NYMuCyTFeobGpY8TJWYO7ruVQoRzBx5YGWb/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by PH0PR03MB7113.namprd03.prod.outlook.com (2603:10b6:510:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 10:04:23 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 10:04:23 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 1/4] arch: arm: dts: Enable USB3.1 for Agilex5
Date: Fri,  8 Aug 2025 03:04:09 -0700
Message-Id: <20250808100412.9320-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
References: <20250808100412.9320-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|PH0PR03MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fe31e1-bc1f-418e-135d-08ddd662f2f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?umsrpwORkklWFQ0LdTf0D3JNuJI/8pa2YviG4qHTfQJSc+YfUaT5Uwy8eR79?=
 =?us-ascii?Q?TgJlya7q7mDcBwoEluDnEmNnZByUc1fEQRHzV5m34Eagr+1FxsKdC1h0QGNK?=
 =?us-ascii?Q?+PW8WwQuO8JUFZT6e+EYKR+6s+4LDF4jYjqX3TYyiie/0oWhbVFzZK/ox+d9?=
 =?us-ascii?Q?tnulzknBTr7b1qK3qukPwHrbaiBw9M3en/ni0XZ2yKZSuRGtjWDUHy9DfRwb?=
 =?us-ascii?Q?FQm1EXL1PdVfryXToRskWJVp5oyVa7DfpUv4uokrY8s8EP8MvKT/MobxtwBd?=
 =?us-ascii?Q?OxUWNgxMco+v7l9nO8GLGJ+gPBbkyVlbHkB/gJiM33WY3BDh0GIXUNvQTfDJ?=
 =?us-ascii?Q?y7Ir3HU0Zhil9/o8Ul/CNl/zt4CGW3fzgcg5Pd2sYLkYdO0AWKBb3rh9ho3D?=
 =?us-ascii?Q?JMq9hoCRXaPJX5UdsSzgdG9CKMB2ZyZBOxHJ5P5X9udlJE+32cuCvMQKrFN9?=
 =?us-ascii?Q?RH1AAAA3GA206q5YsKaXi4G+Cdqynd6kp2VOoi5JmQdyXrgydZASVrInvJIg?=
 =?us-ascii?Q?QORiR4HGOWK9HunKFLMpFBnWfsQ539faG2HrxE6GL97uHJ9cFCfjMt9mAPBp?=
 =?us-ascii?Q?1ecH94bhdO2gvENqabnv5IpPZlAMNswuMxTEWEat9GohZjnu8CKVidOj9MTp?=
 =?us-ascii?Q?E92EXqPWhMVzy9qs4aEBQTq2m8u8vOQUVwf70QQXaqTdSWXIHlimtLPfoB4d?=
 =?us-ascii?Q?Z6yNTY6kuZqr1yqSCH80Qdx94yU0lIYHAk1M11xW+vi/ChfX58pa3DPEIDlT?=
 =?us-ascii?Q?2MB1OPQshhfaW9pZ2tdUp4WJO7hyLbvJC5Y9BQgcxp/Rt+eivV6ckRQNgEvk?=
 =?us-ascii?Q?JI6O36qav/6xdiaSGVleMDQt9Y3XVJHjlolTzpHfal9Xs/b344Bjz4Fks0w0?=
 =?us-ascii?Q?3e68uf9D449KJl1NLn1up3u88AG3BMG5c2B26yjASxiLX/48CK4WL1i7fFjU?=
 =?us-ascii?Q?NnwZ1pFbLYvvUTxOk4sHeApAxFYAnxgjFuLegmrbpn+gwSZn6/oye7IffOCX?=
 =?us-ascii?Q?LMMPyqwRFISv8h8Syy2b2V8yJgs7siB+g/g+a1pmNgUwY5Jcjhr6uTF5BdgT?=
 =?us-ascii?Q?cDRYclzYRVZEYadvRUxZs4CAOsyN1ZLaV6/kSJuUPrwH6bUoewepw2+5gxTH?=
 =?us-ascii?Q?hG8m4JasL2fE8flJXBjr/Jm2cN3cmtLVB9qMHzrZGPrPkC288fVZK/nFRZ3N?=
 =?us-ascii?Q?ZXJR1t81Se4Qm59SJKsxkU4xn4poaVO/w+3Entz3nxl4eC5ffmnlyjMAYe8R?=
 =?us-ascii?Q?X1SSSP7iWH7v8tmOF0QdyaqAmdwxyI5U6E0RlBMFRxqNBxB0t+DC3v4UrUJP?=
 =?us-ascii?Q?buYKqL1mTHFuwYlFHYLOmJwUrUjGbZ9QQUahmARFr+pNvRN9WgChgfMOy35C?=
 =?us-ascii?Q?t/tzk3U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MZg5tSU0nA7uxof+qKdcFWx8m/Nr0SlUGS7zpKko3wnKlNaE3TG3mSlmB8m0?=
 =?us-ascii?Q?ZqHeASGVOWGYO8iepl9gQU+KqhpyhzjUkt0JbmHvKGvblffWUpbcYlYKTPX1?=
 =?us-ascii?Q?XPH9kxJlSDpxTGxuk078UkmJ1AtUjM84W83Uk1l/CvT2MlGiIXegg2p6X1BP?=
 =?us-ascii?Q?KEbb9mNJYINjyf+kDvPypwfIYGjlWIMRAt87q+mKlxwI9n5wAh3iGh149mht?=
 =?us-ascii?Q?iZzy05Sj/KAxaKAdjw5Nxf1/XJPmQ68NvzEW1X33sylPJCBS7HMcyNHBtmDP?=
 =?us-ascii?Q?3SO1XyORWF4SqjwHoZyuLewZls+Va4Y+RkuLIeFd1R7N9xl84hy+YVDT8JuV?=
 =?us-ascii?Q?9xjNo9LsSnQf45QXprqBJArwL9MkOKBU/gP6ANAiTalt4QQ9aPkv81p8dvqa?=
 =?us-ascii?Q?cMjt5np9+E+ePDIUKlAoBJuSFoejt12ZdsjXWcFK92v3ysg4cwbqh6Gm+ONU?=
 =?us-ascii?Q?V43xsxNjFXSTYiCCvugOl9ojNBM1pwdkVFEJlUZDtVltmVX7Gyd5En/pgbxD?=
 =?us-ascii?Q?MkbtdoV5vD8wO0Znb3N2ehSJLqEapdYx0d9OuBL0+2EB/oFNKl+Run8y914T?=
 =?us-ascii?Q?SW23ENwkIVnkWbitz0AcpgR9jfexuZDJxJAS/5F3+JbjITPuNv0OiNOMSPEm?=
 =?us-ascii?Q?XhSC6rhZbRrnOwx/Str1zezE23V45klHGDcOgyuSMH4aagpfP05H+JqjLCho?=
 =?us-ascii?Q?1guTsyNnhMatb/EpQu0OH7mgeNcoZmZhWkWx52LS1uJ95J9WSLwAJiQ8wiYe?=
 =?us-ascii?Q?h4rnVhSGlhOnlJevcKh2FeHsB//7c95czbtlasvBHJhnixfIUss/zj66n3eB?=
 =?us-ascii?Q?OEsdYz8ugUxs5O21GUnnm5/nuDjORcRedpoWrj5wDswCMlHDSoUL92scv1Db?=
 =?us-ascii?Q?esiWrQAFDIJkYw+/wgUXt+EeHhgL9GFoireVNjbIVNw0/4dOIx/8xwxHRpC+?=
 =?us-ascii?Q?LV2WlOA0V+DN9vThRUuhhu7bSS/PfHQ07nSclYnJ0G8+tqtNNODNIyF5r+i1?=
 =?us-ascii?Q?zf0W4Atg/ohvDWLyig7yc6GeqWwsJJQSTwuRfOFxFJqFFYlr8RfLHoDnxGiq?=
 =?us-ascii?Q?ht0euYFS0A88WpoXikVx6JeQXvtPhk4+TG8X6qyD/MuO0uierA/PZ3zsiN1H?=
 =?us-ascii?Q?Tt31PBhEFFK7SptdQ1Rv6p78HGnn/EYuB0krzO3Do2O2OfzTB9uHKnPQTCBo?=
 =?us-ascii?Q?Ptkiht8AweqxbB/PCL0EgVH7aYrpxsXTnzmEAbtXw/dHIqY3g72knHZzK9se?=
 =?us-ascii?Q?9fu7P5y9FW1EINavAmGAK/oBPD215pYrUA0KVCsL8GF8dLoXjBgfQZW5r+cF?=
 =?us-ascii?Q?Z2ZcE6/Kw19sGc0Q64FAMAVl5QTqwm6yW8ePuQ6c13Xk/JJk1x5iNan8UYCs?=
 =?us-ascii?Q?BZludayV2Cc0cWKo0o1MuOlxAkWuVcFu9LfJ8B+DLtmQXl0TWvbPl1wedVku?=
 =?us-ascii?Q?AdDwoAdxZTfYiPRINeWrSl5DYk/w/h8oACQKGCCOiADj2ILGvE+TJ4u2g7Hq?=
 =?us-ascii?Q?ZRlQj1iQwHr+XUDkQ3p8G2WTAN6U1iv68zbiwkDmgrTeVjPFDXygPBL/YCwD?=
 =?us-ascii?Q?/ESZjOkzXZIPeV4DFyZ4arfhK77fxEGDY0o7XiBHNrgeLxd3rHr3edjSeUeF?=
 =?us-ascii?Q?JTmv02K8xkE05Au5auhEfJA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fe31e1-bc1f-418e-135d-08ddd662f2f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:04:23.1984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /eM2D3tS2ptVYI0cuuGKVgBAx92nv+kkDj+W9AvwXA2kS+sGL30k1UPh/mPTMUoC77iX8GTm3TF7bvFMDpSoWaoODAL6ZsEgOIAO0Kcu1bEX2yCYqVLrEVL8Zosabz3r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7113
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

USB 3.1 node is enabled for Agilex5.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk.dts b/arch/arm/dts/socfpga_agilex5_socdk.dts
index 2ab143e38f8..86e6d374948 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier:     GPL-2.0
 /*
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 #include "socfpga_agilex5.dtsi"
 
@@ -87,6 +88,10 @@
 	disable-over-current;
 };
 
+&usb31 {
+	status = "okay";
+};
+
 &watchdog0 {
 	status = "okay";
 };
-- 
2.35.3

