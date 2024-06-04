Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A0DC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 13:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B71884C8;
	Tue,  4 Jun 2024 15:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="u3eO2LUW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3843C883EA; Tue,  4 Jun 2024 15:59:30 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 974958849D
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 15:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwK4ZSCRy3Fgd5YzzVzg9by/qPuzm44CSxYkg2gnktDHbjie7GhtiNWmJVwhsY9AG9rrgBlCO2CjdguHOY6coVGOJ2jPwh96PZQds1A2LppL+qmLk/5RNtXoKGLDJYjMHF8ZZUnIrdl1Y6CJpm+QI+Yjfrm5PdQ4n5mpstiSPh0Vf4twcKL709jqkJazsnvO4FmeJJijcK0XI5/ocHufLOHgKVP6TJRdJylAxxN/gID+zxjScDjSQXcWwc+RsUzijRo9QPIqnuqYWdn66YEg9sqmDDbGV/2QC3S0+9+er6zC8HAMJjzhtDCqJLlVleGdyGVINA3enz7eUJ4vTn1ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aaOdl4elTPbrO6EDqX9j6hFJ7Kd20vdf2pNWlOC1pc=;
 b=iVrnXahHlL/PJMkEbA6r3Tm6KoH3cn/ezg5Vtu+CSpXxoJcLb5oTsftSRUUFuuan+Nb1RB61K2erL5KgOIgVxtiMgFsUAFStG7iJjD6MFRxI8i77uVZVCEeCopz+anOLH6HsFK5ngVJe0DmMpKD63F50cvm3JL3deVGlgUtIP0lJKEn8MuM9NEB3UKjrphgadqS3RUEnQ1dA6jlv9/ylLBNdGkOqjcu+kJBiyk3Ahoj1XCQooxkTzKgKfwgrwc1IvPsWGnZ0UVOH0x2/twZBS0HEZONQqFYdLJOikRcXwH/tb/mF2PA2Q6+B0aTHby0cpNoScTPV7tdjWUNqy5ew3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aaOdl4elTPbrO6EDqX9j6hFJ7Kd20vdf2pNWlOC1pc=;
 b=u3eO2LUWOCLThgIVA+Xu6g7ft5dRvDec6sj3NfdcyQsEIoJIn9s43m58aaQh4UNraVA0xxSbDVoqG7Ar6+w2hvFaYEjdZhFbvv1GkVDF3OTn3NMiUv4KaeXgmvvlFxEyv93eD9eqKY9E2bQsqixNEQJ5uJU0Jai53/zku6TB/1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PAVPR08MB9795.eurprd08.prod.outlook.com (2603:10a6:102:31f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 13:59:24 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:59:24 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 0/1] Enable reset_cpu() in SPL for ZynqMP
Date: Tue,  4 Jun 2024 15:59:14 +0200
Message-Id: <20240604135915.405660-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0273.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::10) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PAVPR08MB9795:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ed2e0c-e84b-4979-2da5-08dc849e8a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|52116005|1800799015|376005|366007|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7nAuIWO/bNNtTNgleCmuPHJGmUfVGXiyPu6NLO7E/6mHYJ2PgI1d4+w07TTc?=
 =?us-ascii?Q?GRVUwZSnGm9Hrx3qLVw5Ud+fyAdmboD6++M+FJEDNZCJB2IIIIgpVj0GeFpk?=
 =?us-ascii?Q?+SM0sr6NQI97qprf3FlRLmbj84mzNdYT6dg3wccOfyR0lUUHhGfphtUaf7Av?=
 =?us-ascii?Q?rgqGnrQo+sN21qGhGtc6e0M8v1v5YtQBGZbkLTWcGMbulu0GqUlEO5F58X5+?=
 =?us-ascii?Q?O2VdLV3CPEcMov53vtw3/ajdnwquJRxkEJgVPTZkPsQ3k6T9JK4UebrrTeoc?=
 =?us-ascii?Q?X8v/ze6jxkdFT53piqqdCk/xLhTI8Jskpw1La5121OwBoUyNe0AIZFQaPNot?=
 =?us-ascii?Q?zAtewCCQ6mFsM083iy5UPZ1tZHVNgVMGjv06BJ2pJkajJmb23oQ7Jt7E/wSA?=
 =?us-ascii?Q?LRPNdOxcdv8ZLgConfyBu2m44MSoXvDOaO3Er4BUfDTt1fBY0gqmXmnzonXM?=
 =?us-ascii?Q?B830fnumMytvRALD2156AY1pNxBXeedUrW6Mgpm9sZonRLrzhDV4BS/4c7J4?=
 =?us-ascii?Q?BYcZbONJ/2Y0zHTOt4uX8qdvnSXk+Cf/q7zGCfAhsBXpBTtRm01NATe/0pD+?=
 =?us-ascii?Q?qa5rhSIlu9TSQl31v+CnFOb47BAdvhEigiw8/VM90xAcOPPiyZ52ri4f0742?=
 =?us-ascii?Q?nYEGzIukXr1HFxc6krU6OFPLl7NcR8bJsC0gsLXRFJ0pDuL8puGMSELyLFoP?=
 =?us-ascii?Q?TOSYgnm8FSaeJ11FRiRG+6YkYMiEUe+JDra4ePXQUW6AEwj8M5fxzUkRaZOJ?=
 =?us-ascii?Q?1dUzKDJzY76MHtWyUYKEEPCVXy2ub5BJF5p0UqGEjq4zFSiOOZtHSAkvyU9q?=
 =?us-ascii?Q?8obvq2CPAyHiN4kObv1N8lbUl1KY46bPniQUkNssrJTRHUeCFdWa8Z53yfrM?=
 =?us-ascii?Q?Ec5EctcS+FlfPirhb9ZHl4VQGQVbcoieMAHi1U9OMJrgK7qD7azk4HcdEFDd?=
 =?us-ascii?Q?0AuPccH93uObBd28kEdGQBpDHHfgCXHl8Z9zBBvK3YoSkcJmQYeTr+kXg/ue?=
 =?us-ascii?Q?Fa4tOuOyv43IfOzj83k76zRskoLNhEiqcTiNxHg9/R9n9nwBjX2I3ZzicwKH?=
 =?us-ascii?Q?To+rZq+QQhZ3VSOI9nmktfSYqYEFJaqaGbXLGmJ2qkrxKRs/GuiRj6OOGVCK?=
 =?us-ascii?Q?+d3+hDMzFEvEH6XzUhIXh3rPZmkDDswWzVDC9QamMhbYHrVe1yDgg+5txmEm?=
 =?us-ascii?Q?tGpV6eRP+04aUNvLKvNY11qqHiETouNHeAKZIdV1wKnzcAUjxgFerB7rhtC0?=
 =?us-ascii?Q?PHvBpsD56Jl/DiZtOFRUVqWiAKGbcLXaN9niI1WIjZGWinslumufOlCSF9G9?=
 =?us-ascii?Q?2uQT+zaDQ6uj10Kqgv5E7ehn8C//3BBBaVle3MnkcjTRiA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mHsKegLQR56Xe46R6ECkwMocCMQKeMqpAncXWTW8qRuClzDavQjVnL3emxmU?=
 =?us-ascii?Q?2CR6Sy3OUwSHgis5KRcAgM2wq8AXkVVLBQJ942Up9aDct8ol+iXEbcNp2oaq?=
 =?us-ascii?Q?4hRTKAnifENDaONv56wTcRE2invjy+Id1xqCrXP7Q2RzgXajYUeehzu52XhV?=
 =?us-ascii?Q?CFxMdHQAf3dlCpyR3ks07zMatdfbX8scIQrdE8v2k3Ss1GbCIexbS1SVEADS?=
 =?us-ascii?Q?KGaZ4XoMc2yLgUolm5QY8RyHJRIah5r347efQgvSCTPLrx/FStXcYcDuo9Ol?=
 =?us-ascii?Q?KQbyWlUwgcZVC8nGPVk8OSltPteol90vRogXQG7/8PNayhLB/SxIMDFYsrew?=
 =?us-ascii?Q?7apNQfUSo3YqZU9145GKvL2VBlvG73ArYoQyDdStpClx5JSW3JSPK2W2vKOT?=
 =?us-ascii?Q?kcsK7UcBoAjeJE28KjKZY6TSuFGJDB1qLdhdQnfnwfy6t4PD0i+8+CD1tncD?=
 =?us-ascii?Q?cT41+AzpbUFbkm59aGGhAqG9EshwTA5X5bMEVzBi+kfiXPoaJbkLKPtETtlb?=
 =?us-ascii?Q?IXMWjt+f0wLdrsyfZSUakZb7lW9k6v3CRhanDzyMY5aDQ36+FX3MncfbCLO6?=
 =?us-ascii?Q?vGvsOQbf+U/CJrKAplMcCgOYnwWRdqX7Csu21mCaO5wVM0yfkbI8NMopLpsY?=
 =?us-ascii?Q?J838FiwNB6h30XMJv3Dd1PWIYlSSzy9bjdOlF0RStmzK24GxgTP4P8h+ulgL?=
 =?us-ascii?Q?AGVmBQEcTqLaVNXUYc5OQwDhXgu7XvFQ80O4ixPNhqpuQpx68yZAoM8aRTat?=
 =?us-ascii?Q?TQA3yw5Nic6GSUlHBb1s7p1BxJx+ExZtu59eSe+Bhjocd+JiFheUnbpSMtYT?=
 =?us-ascii?Q?pJyJVWeGydN3e4qPXHVKqcciHIUamuCrSK7isdr4Szv1R24gzAaINg6jpBR0?=
 =?us-ascii?Q?BPBPfpDBXDToeEiAXXfquuTTQRwdb0Bv3sYAQ058OlqZCpuACesmAzfEHkwc?=
 =?us-ascii?Q?2TZcHWCJczifVeqXUlkk5lcW/AxgXGCWzyWu/+xpCRVT/XZaRbltnGCu+ymT?=
 =?us-ascii?Q?lcQ+HH97u0JoMtPZ1n/k2dm/uU/kKvTlEW3VqTaWsC+fTU84Ve3aqoMiYJWz?=
 =?us-ascii?Q?fSMPGMxAmhtOzG6z0FiPCpTogQkqQUVTpQ+fkXzFulVW+2QhwFFSW3itT+Eh?=
 =?us-ascii?Q?zWE7AnUcTGK1e6/g2OUT2umCTQWZAkRGp8q9ue52yTYF2nbDD+9L6aTE31jO?=
 =?us-ascii?Q?4r8QupO0nwRxkD+L82N0187TF9ot54IvuX1uUyaswzTC/8k3jAIzWrphkG5R?=
 =?us-ascii?Q?agVA1o/7KvlmtRsZyPjGcePRhhsUk/z/UT7tp2CmfcGEGOo8/2BAKRAA/3L8?=
 =?us-ascii?Q?Gocn1aN/4NkzC9X0WOYLKQgplWgeNHYt3WyEbxwPEyghqc2odCIwjnSJ5uOc?=
 =?us-ascii?Q?5CbristcfCUfsGt3/lKRQoaQl5X0W1+jVtZtPxmqwUEXTJCOUaOFldFceU2V?=
 =?us-ascii?Q?3rEHM+frSgPik1FERau0UTuMjxATFJjBqqzUX2n4k3YLYxqnxwjetzWOM2j/?=
 =?us-ascii?Q?oUzUfUDjUmpGt9yzhsXEIN/G/Y7h8YAfJLUf5PeBim+azjYqm5jBgRr0OCj6?=
 =?us-ascii?Q?yj2otoDbj3dFSnlGAPusLy+uIG1AHcnz2XuNgaW6uc9Q3nVLt158fBjBfKns?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed2e0c-e84b-4979-2da5-08dc849e8a55
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:59:24.1777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SYCHAiFCXTwCLOREKFByA8jEr0JhEQiCL5qnbhSN76AzXvdy3ZhFBcvPFe/ZfWNFDvusH16ZnJ0O1TEu5H33ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9795
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

From: Lukas Funke <lukas.funke@weidmueller.com>


This series enables the CPU reset in the SPL for ZynqMP based platforms.
This only works if CONFIG_SYSRESET is disabled. This is usually the
case since the the regular sysreset requires bl31 firmware to be loaded
in order to hand the sysreset over to PMU firmware. In SPL we can talk
to the PMU firmware directly and request a CPU reset.


Changes in v2:
- Drop 2/2 since reworking ZYNQMP_FIRMWARE dependency is out-of-scope

Lukas Funke (1):
  xilinx: zynqmp: Enable reset_cpu() in SPL

 board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.30.2

