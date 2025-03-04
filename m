Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72820C282D3
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C212817C4;
	Tue,  4 Mar 2025 13:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="o8HYmFAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B6A80F92; Tue,  4 Mar 2025 06:07:19 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C7D8006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 06:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIklRRnhaJ4fbnv5xCxKDSdxNLj9nUXUD5qGySUU2PbytNj80/z74K2A3EYoaFRhEyWum1T8/4f4T+IVasjI9XWeZ2/PbGAUtdzJFzxAYvXslc7G4PdfC4ztQgguD59C9fCvLkAzg69JXIaU6pdDAzmNSVjkAzZTbMzTIRbFv9s2KCx7uwXfU/ewRbLz7pn6KmivpYyPMt1qZweZbDztmIJXNRFRR+junAOQz724HXibxURZzHwbJByyPQGFOTUbzzZEgFeg4odtNfx7ezJPEVuZ6lwffZQSP6YEim1GjIXHp5BGCm4cTKuR/EJ2AjP0XlMF9M3GmVNRFzvK1OTfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI15nAcQGUpC3CW321eXNMiKS4ymMSsOURlov4lqn4w=;
 b=IllMqsNw+ZdbJVT0P4nxoVWT8E7qDkJQ+qOeIdnbYOvjErqNEmoeFjwTqn1UrjwX4BjHuu2IOYHHDKsBZ7JPZ2fs++RI2LXN+ES/t9mJFlfuEOs3jCAWPSp6+gSTzdU11gS9ILqcJuejKXY8/uJftF+rSTHumXHyoihvsapXgF6EJRhiHqc9Iwju4VC3BpxpNRjfuXJq2zu6z+JphZalBFPxCnvSdVL/vMAdJF7Zn6za0MNezuIVpWRuEzK8NUNbmgyjoRw4agDLXgmgKcGEOWdZfs3vKJaQTIU7qujZCJuwwwmbhNHuNZqNtQvhfVenzLOsv5E9xVHoH/PYRA5l0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI15nAcQGUpC3CW321eXNMiKS4ymMSsOURlov4lqn4w=;
 b=o8HYmFAjM+Vd3eSI4ziQDJl/t79wZcG1kk40r6ApEB6RbuXivCqe2u6PQExJhDInBEvoikAYf6wF6vLeKty/EsjOBJeHx+q5M0HdIz/JTb9WTWuKItV1sY5PRoyJKOG+sLa3tBx4Hoj4VYT3DFuXfl4r63SlNyFsQptVGhzawbr4Iyv+P2JQ75NwyEtPmo1HDyZq+VaxEYnpI1AEg+5cMEf9aAJG4pAr6lT8A8Zs79WmQulzZVWHDY9AVSSWQd6JQoerrWLrdyOhmoA2A5fxgB8LLrbiTwkNUsvdPt5mYdvw4PR7+MqHxgr5uGli8OT9jpM1ZLn+PPeYXHqYxLB1dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by CO1PR03MB7939.namprd03.prod.outlook.com (2603:10b6:303:273::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 05:07:15 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%3]) with mapi id 15.20.8466.020; Tue, 4 Mar 2025
 05:07:15 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 1/2] arch: arm: dts: Enable kernel itb file generation for
 Agilex5 SoCFPGA
Date: Mon,  3 Mar 2025 21:06:43 -0800
Message-Id: <20250304050644.15174-2-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
References: <20250304050644.15174-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|CO1PR03MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efe629b-94b4-4d62-31a9-08dd5ada6e5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G6f9EmFUb2mup5z2ogXE3JP0lhsI3s30NIpLOLpl2FC0CC1KVEn8cvcE/stu?=
 =?us-ascii?Q?Ih5pudMJedpTWCCEV0zjk6wCVc7Zkx8zZsmXFMX1E+jvUsOMi5JSlgCiKknY?=
 =?us-ascii?Q?H1mwXKAbxLFXyPfZoOt1DJi89GE4QTcMRPvzXSvFQF1f339cpsDNCiL/fmnx?=
 =?us-ascii?Q?TaAKcqJcX0LR+FD+osYFfeNaNK+CAxSdt4Fv/uGmmGmpuGoBC+EJFWJQI7w/?=
 =?us-ascii?Q?/2U+kD3bH+KkBv1eTNDu0xNe98fy0WiaT9s3PyAylLS2OrYh6PCX0nmqfTxi?=
 =?us-ascii?Q?ve7jhqkVF7cl4vmz9Yb0ltHOsUy7+qpZah+TgS5Svx1D+4vnx3Xj2k1TobI2?=
 =?us-ascii?Q?ilXRLjGiusgijVnPmpnrg5fwuNVyZ/m7uu7oH9zH8CfH7ny7a1zlU4iOVX+k?=
 =?us-ascii?Q?E27oP9XXMg1JQ5CixCNdBQnmIFBTaYMyqO1K0lQegFZyezhIkZQ85D3cBEqi?=
 =?us-ascii?Q?OEwSQ4QVd8sKIARGGJstDauU2+jZ9H37DJl/3f5+nkeZUC6RkLESdz1CwBRM?=
 =?us-ascii?Q?9VmB1uVb66AvZB/kUfPylJDnndDrIawbDE0PwdfT7DaHQ1bO1nLeJFwcEz4u?=
 =?us-ascii?Q?U8YqkrG8lwMqayOiD61Cm+hTQsZ9XzwhewGzXp3oIjKnV/lPce9ClB+z04Ff?=
 =?us-ascii?Q?oAiDKiMRVtLnvwp41w8gahoYRpxaEKnbTKxwm99jfode2/ssmu3/JDEz4NHy?=
 =?us-ascii?Q?E4lmti7uku2rUhJMT//uLwYCo2NOdHEcJAAosSWDqN0fgBhHqQH+jlOCTGHa?=
 =?us-ascii?Q?xkU+AtOPyUcMLOYqh8omizbkP3aoy4j37W1sBV2HMelBXTVUjSIZkISFN0c7?=
 =?us-ascii?Q?ju3SMYFsObEP19gYCIK4Rxu6c/dFZlhtFES+38muLepJ8U6GMBqtVnGLLiwX?=
 =?us-ascii?Q?sQzBcJrYmbCoaraf7sxGUQtP6yvLj5UGiAzL907FukrHekKSYe91OecgOKSp?=
 =?us-ascii?Q?iGC+N+da5ZqfVMJKT+oyK9S+zj5T8TIrlOG10glmRvyIzW41AtzG8fWIJZYv?=
 =?us-ascii?Q?Y+rldgSrIaDlqzazJcExpCSFcDMchG5IvlQhyh7QNlNjJRYjGkiao9/2L+qh?=
 =?us-ascii?Q?3HwlvZItJg9QUpO3o5f0z4CNb9U9JW87IPTOgIzr1bTFXiU0kUuPiD/Bhnbl?=
 =?us-ascii?Q?B7mU70D0fLrYOQdVahDEn+oEy0sPiefhP0ucxXnxDj2OB15CQ7NV+CX1byWT?=
 =?us-ascii?Q?kVHQaHx+CfiREuQw/Ys8arZArFoqEK9lNwnU5DLpA1WPaWxhmrH6AsdnGlQY?=
 =?us-ascii?Q?M/uwiqstZerFiNu2OGGTtTBNxX5APOH1cFQkO49xAwNjUV86EIfKEh/BbgAg?=
 =?us-ascii?Q?X3d1xwF0RbxIZW3q5mnx3XckN6q81Bpf2XdsfKJh97iDkkWt0NR3L6i7ufkk?=
 =?us-ascii?Q?0WXqqM26MTelm91yKivWomvbxkS1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vUFOZ+LQYYpg4i3IEbtfhKxYKO1clW3RqEnQoYQd4Mz4rlkMfQcKWCkUClRr?=
 =?us-ascii?Q?w6ZTESZa8+Y6/UrCQ04/DpRarvtLWi58tzo7wgnLyr7RmaAmd35TMe/Knuhu?=
 =?us-ascii?Q?YY7yAldNHiytUJ4vOlmqEul9OJbZ+iTnCvgYcyeb9vtG74fnvtK8z5h5uCcd?=
 =?us-ascii?Q?rJKQj1SgGjMi5yyowUU0CqhkGPhVr+bAbv4SbokBnG4NFVN679wfcIbT5sOz?=
 =?us-ascii?Q?of/gSxpiruAgBhwmWswXlwpjgpmiAn9ANNySpGMvViEJChApt0GtSosR9N1J?=
 =?us-ascii?Q?EhoLLWMvCnGMN2LsEdz22fvJCIdU6uiCZFluycs6GJf7vrUxlHKpJUkeqoQt?=
 =?us-ascii?Q?W4qHUOGk7nhP7mUeS1xUvsy1Bm/wsPCjvwZBvRW52+g5uPbaE4QTzD6w48HQ?=
 =?us-ascii?Q?vd0hWZrP8BCGRiT4WsyCKq9gXK1qRbe/nqN59juqk90p1leLduMgb47KSNrT?=
 =?us-ascii?Q?BbZkflHMUxIfSNlyKbcmTYus/jBTfJNda3xw7InFt/Oi55lxxnxwIFgmyqAS?=
 =?us-ascii?Q?fn+Zzp/xWQqaKQblq3ZiBA9qTEcZ2iS+camNGbiZl7ZX3Pc7OzJeNc6nkHYV?=
 =?us-ascii?Q?XvvS+tIYnSJMTPbRlVI7teCPNbKiPjbcj4f1R7Xiwb1puyQT8a3LzrBb9WqP?=
 =?us-ascii?Q?8i5enlwX1QcqtQqaTN7QIodmnj0B+ASQHEEuwYPoQE2OMGgjsNEk/xjloXPY?=
 =?us-ascii?Q?ywxLEkkVenjmMgw2Ofnua0UZHytlqKlCMvshUobp35wDLsva/k5u7+L4SGV1?=
 =?us-ascii?Q?ufVeWlhXUS29D77JjyXemLbymTKzQ8xPiNLBOgVxXiO7B4fLtsfPQ950QxEd?=
 =?us-ascii?Q?gkopoTZNmAN5OnXSABEhURIbCS+vNLqkcwKRwkb1lwGTn6GaZ+Kh9P9f1EPC?=
 =?us-ascii?Q?Zs8CmMR6sYv08pYzCG7sj5HYB9k6bygtt9HazL+aedV1tHL/g/NPA+1E9LXQ?=
 =?us-ascii?Q?PJKhL2qR3P5+7MccfiPCHO7hyZK8JmmoDlJqAMnXdCEpW5NkJr8edQ78mlGI?=
 =?us-ascii?Q?S/i2OPX0i0tqcXes1znSJMbnfjYaMh9cDz2PrS/haqQ52AqX+bZABrmLZ0nt?=
 =?us-ascii?Q?QxVpukHz77qqSzi6+f5vS6Ce/ahkecyPlF4QG6G7Q4y6L6M5OZOmvj1+8EI9?=
 =?us-ascii?Q?ENLbFWr2rOJPAH1rIIUWZMBL+fMf0FYYVwmznLIvLGYMkqrP/enBb6PrJW91?=
 =?us-ascii?Q?skGoeofNeT/2A+P2KA31AaPw9QG0MTIDjy/dE9L/7ndcWcgDoliwt5uNTe6Q?=
 =?us-ascii?Q?hJDViLsq3e9sqczYKy+B0MwemIe9aO8nROzMiADXqH6K1b19x/tjyvCQ7JFW?=
 =?us-ascii?Q?5Fpew0qx8jCDy/1f9BlxQ/ZaV6hp60RrXhSw8LpL3WCi+GDEtMF8SA8rI9u9?=
 =?us-ascii?Q?4Z4Wc2zuApZonjYinQagrH2DiaRbf3JNeL3SX76wNjltHb4iPou4ljkIBsiN?=
 =?us-ascii?Q?51eTrWHnJWtAcOGLeF9Wvd2V2iBt+XdDpduZtcMNQQyI+FXM/ghEjVg2suBG?=
 =?us-ascii?Q?lvlG5RodotWZBdcmXZeKia+JtYkXdKGW/ky7vKHCVIPm7PVblgu6YaJB8nlP?=
 =?us-ascii?Q?4dn5yEWg8VmRrqYVzfIJh0bOqlLOB6OY4cF/sFSclN5BvQ6JogpntsB0zJW0?=
 =?us-ascii?Q?z7WqLPJSY+54hhJhaUJgpSs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efe629b-94b4-4d62-31a9-08dd5ada6e5b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:07:15.8671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guezXI0lCLxQSmpym27hQS+GlPb69brIhDHLG70MxvgDfLLMspiS9PTJHTh1Fiq3ZlvTPFXDmu/CvOQ5yj5cKA8ixLUjmjNIff9SLLTYS+KU/YXgAA8ku0AcG/J9DGXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7939
X-Mailman-Approved-At: Tue, 04 Mar 2025 13:58:09 +0100
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

Load and entry addresses are corrected for Agilex5 SoCFPGA board
which would enable to generate the kernel itb file with the right
addresses.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
index 15306db600..93a8e0697d 100644
--- a/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi
@@ -106,8 +106,13 @@
 					arch = "arm64";
 					os = "linux";
 					compression = "none";
+				#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+					load = <0x86000000>;
+					entry = <0x86000000>;
+				#else
 					load = <0x6000000>;
 					entry = <0x6000000>;
+				#endif
 					kernel_blob: blob-ext {
 						filename = "Image";
 					};
-- 
2.35.3

