Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC20CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 06:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0918583280;
	Thu, 28 Aug 2025 08:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Oh2Zyf/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537CA831D5; Thu, 28 Aug 2025 08:24:32 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08F5183214
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 08:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVERFHLGIv005x0XWD3bUtftfTAon3BD8I4ImJAO1CRb/UlUCwHKt/nbZYiace+VEQf4UyXjcUjLae5+FJZIsgw8SFtXvH6KPdr/UcEkIhjEIyMxZVkKY2XBwi0901X3ZygWP4ytk5wGvSNyDiCGrr4M0l+mt9ACsfH7m/DHa/1plhct1S3I5jxn76j3rTfTFN78gtlc9h3Mh3IzRdUnQD2OM8U+7kVPnyRsNpnf+AynVob/i0xMXnUIl11+UK/HrckW5oY1UDKzAmTzttAzEy+PBpnZ74tDeT8z1Kmxc7DfkWcG/Jl3WVt0VrtgcSLdW+s3sf+LPpt2apiq9Vzz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njI3b6SOjINJfMTWTmrkKd6tL/1avkflrbL9rAAydbk=;
 b=QD1kkjXcZZi1/9MXIpiQcwSfcVVv6r1uAuD6s4+gBjmI8DqElthCTRHEGnDBAQt2NEAZwunkQwTWlMEWgJjuBI53V+wHCK6MmSmz3wyzqVQoEEsb94X5Zbulxfi2qH1/x/xmDXuDzxQH1qKLywajwx7P0b6ofVi9lKU9eXpgLUAzpZPodkPqVJ4V6l8FxTqSLumwIss0Vj9a7RAUzUYcLe8uqAgUeJB54RtOjWqGYbvV1vFvE0tMJJIANp/a5Aoh/VXXrXGmVnvVNBfu9C6t0eZtQrP/UXTChtlYPd1jg1+pPsR9RjpadnidsNpIsh09SvkuxlH3gj0YeqguRqPc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njI3b6SOjINJfMTWTmrkKd6tL/1avkflrbL9rAAydbk=;
 b=Oh2Zyf/mXi/3IgOVrCedeU2V1kjarb/8YK80GjA1spSVljALbBAQY1hL2ynknuag22OQELVuP0ob2ISGj0ZxGyqooCJZtE1TUXDZg0SIOo1A0hno4B38EpX03KnmkpbNvuFnWBL73Y17uvjZ7YcdovcfUkJFlD8q3oVYI6jziKhN4ka9q12ImlfKQwklztrsvgs9jh2JeingzrxWN38JP8HzKXr2eXTaIu8iUQeddlpGZbINUqhS7ayMRVmXtzJylTzR/jGYFZio+cVsAJdrbZAK2B61YqQO0VP6HfIZXZkybm+QwwrqyBApk0Y1h8b8n8Nn3NrzxDPdMOIUC0+9IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5676.namprd03.prod.outlook.com (2603:10b6:806:116::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.6; Thu, 28 Aug
 2025 06:24:28 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 06:24:27 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 3/4] configs: Increase USB Hub debounce timeout in Agilex5
Date: Wed, 27 Aug 2025 23:24:17 -0700
Message-Id: <20250828062418.17945-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
References: <20250828062418.17945-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a4f6cd-f182-46e5-abad-08dde5fb8a0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dKEVMd0OPpy7OLFJ4CiRKBcEw2A9FmpQ00QBV7CyjjPjYkKW6Kruq1wrKJ4k?=
 =?us-ascii?Q?wR1BqEuK5pSUV2ImU/jMCpSicoL5devzAHp4yqcwD1G2J9wrLauz2GY2l8FH?=
 =?us-ascii?Q?0iXts4nDfqAsaoC++7PkUP9kda80L0+/vCELMuXkjJOoUv+T1gBenrLuYMhr?=
 =?us-ascii?Q?EiZ+yPh/hWR6awYQ2DB02CAKotpCfl8uQTHXBl85V3JYisPNd/tGdwwbiFm8?=
 =?us-ascii?Q?FtkMNQ0GWqvKJuYSJ3usOlbMGnzxt+9rA0VKRWFC9pcS6wiUgTjd6RKEMkyY?=
 =?us-ascii?Q?Tek2+7caf1ghECODGrpiMWVpAjDDVzhizGWWtt5qHxhJnMrNdA5A9oPANwIG?=
 =?us-ascii?Q?YP8OZf79TPNlKWr8uWbv9/+/hIzqvcwUVDNqV84n1VnrCR5A7EAB83PXE4Ek?=
 =?us-ascii?Q?EPMqQbyRIcqbYFF0SKqwa2RLTLRcMisAmnPXskevzjsnDsZ8i0FVwNatohah?=
 =?us-ascii?Q?ahX8QkwVinR0T7Kxj0gO/I30l+2Oc1mbEMqcyQuxsfVRmfi3ubIQzy77V2GO?=
 =?us-ascii?Q?Bhi2WVUBod5w7PNYJRK7Ish9fNcX0JPeD3b/yjVDCucB/D0Phz2X9g/VAAht?=
 =?us-ascii?Q?YgwiC1blXw6v74Q4juVWHwhYGjiT7K40KlxhfEUp8F+N6WuT61jhZQ+T9Qqy?=
 =?us-ascii?Q?hQIL+2UNsDyrA56gKDvYwYbkVlxHaqW+mvVnfpuQjULKhXF+rTChURTFOsZb?=
 =?us-ascii?Q?AmN+0p35XDLlYS4s8nUeEGYhAOy36qd61yDas5Awx/QeW9RSgRWGjzwtdYX6?=
 =?us-ascii?Q?4EsQMMmLlAcs4sPDLX0g9h0OtKHfVYk8i+q0I4ZFaUb+PN79DduebTEFstF1?=
 =?us-ascii?Q?ijWE1EdPphnN40StcaRVx6q9KCXs0Gma7bOy5ouxTZJU1MYqJM09nsiuOr/A?=
 =?us-ascii?Q?nBRyarNGv1pHCyIpnju/WcVeURVTe2FXIudkqYymA/RePC54E9niRvhBD8hD?=
 =?us-ascii?Q?KNfIG7XSiVoXdV/yM0MwKhIBwqRDvGmhLS+IW8QdCwmXX+Vaq8kdAsy9bJPP?=
 =?us-ascii?Q?WrEIo3WWRNsBKFm+bZwK28cUm6w36NDwcO5OEtQwSabvetrWH5qlDZtCNIZ4?=
 =?us-ascii?Q?tvhnJlKQt72jBs4WvoP5wTS7Ag1gVRrWGa39b3ZwaZZr556JbQGIsvELBn6f?=
 =?us-ascii?Q?gqwj7DVbkqiw6ACtsyJ0Cpb50lpIUpFfPc/dQiSMzOZU07sDl0Yd4lb9tk8X?=
 =?us-ascii?Q?mFLMTJuRhQrUYVbVD3h6dSqFJ0qS1iN7SpblMUTNDSHYre2Zkcz6W3mqncue?=
 =?us-ascii?Q?lu2ecGAOUn4B1jDnE6ZrAQbdWEhGq5iqY4s6LZZq9nw8iw7TaAFPtZdmHb+w?=
 =?us-ascii?Q?jc7eNxu8h9iuFQkhRESEjxTwrxv+qbAM2xY49ujLV/Xh+nwDwRMjFt8T87pA?=
 =?us-ascii?Q?k36fk4YRGCYOFU8LztpFQ5QV+4/tWsN/voyog0mQYsLxJN9bTl4/m/cYB9mn?=
 =?us-ascii?Q?0z3HbdkOZ74=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tlhdHzFM5603XzFSbtOjUFS9vG8Y8uqr1eGn6J44Fvu8v/+yQzjfN5EeXxsR?=
 =?us-ascii?Q?voS6r4fSWmrAteb6/HOh2JNl5zYLU67PEKsA9nVvb7u2MdFCQ5H9rj866gsv?=
 =?us-ascii?Q?PCH5Ft8dbuunzMoO0J1PeIaYwwdb3vRGgwPvPXa5uGIh5teb3MpoqVZwbcfT?=
 =?us-ascii?Q?0sxZKPrnHmuyZ1nzAZXjI0IABNAnXqzS2E6rW6wm2uTVe+LNUqLtEzrk/eTM?=
 =?us-ascii?Q?9GDqs0DYMblLUa3G5aJ6usyJzY43IEXqgPvfP/oFhi5B7XZeTIvF6baxWF9Z?=
 =?us-ascii?Q?wOVQTwIUI/qqGV1c8TOyF4cjJxyidCgcf/28lTmV50NS3VSAaHWDHkx2nvwO?=
 =?us-ascii?Q?nEOV53MIBDpWyuE8VcLCNyD5DDnJlWYfjIWkTXWSXnMc0W6EBDid23GDZ2/B?=
 =?us-ascii?Q?at6YhtJGIR+dfoflUFLfc5u/J/CYhCRhWFD42qSOppNteNmTmeUii80KkciY?=
 =?us-ascii?Q?mSzrrOL55BS3819RcO2EKPbypiQ75FEkOv9nYWirtdYV95f5t9Pe3L48vyob?=
 =?us-ascii?Q?x6Qne4x+4gXSb68tiX56/menCX75GqA+w3rhOLLH1qorceZ+mAKI1hab6Umc?=
 =?us-ascii?Q?xIiDXvzeK8GYLBKuFlRi6KonvGDEmpLcBVW2lhEifA620fV311zq3g1tG12C?=
 =?us-ascii?Q?6PcgQGY9iawh+mY0OlRDQNhzWapaX/wM5QDhpNkbS9H0zoocWa7yKWOX8TAp?=
 =?us-ascii?Q?FcU5a2/ZFbpAXZqVV+JKjmDRcnKeb7qZtzG8y1GYPSNLs/aZjRWC/+jeAIqf?=
 =?us-ascii?Q?fSULCU/MEF8TChJAdaGT5x86E4abEdelBdSOF3UmRpje4w9wohqx/6wLphoA?=
 =?us-ascii?Q?hTtjn0YWL06rkeRm1PXS5dizMeW2fs+GzIBBSJ8ACr1U1ZdrtSaL9t6h2/Ud?=
 =?us-ascii?Q?/SBZI7TDrq2bh9H1G2CgAGm0QDEyjNcqQNbbtOnBvSO8T+vYZhMby4ihjwS7?=
 =?us-ascii?Q?heNnbuAqiY34WOgiGi/ieMvqBiBAosDlTez61fuBDSifunaYNPF9CDzhI3uw?=
 =?us-ascii?Q?yvFkcRxXCH2OWGzRqnJ60zCzHA6aZHkv6aG222W7hriNq4wYqOVI+Hm8WpD2?=
 =?us-ascii?Q?cPYgK/iy0H0YFbSUzpdyie5/wQ3KHXvl0Ds/p+bH44+IMYG0NdkOevjy+1WB?=
 =?us-ascii?Q?nh+52Bec7G5a0ERIbKEqSpcrXoWwCQiF+l4p/uftSmrOZC+etrDCunt5YsVS?=
 =?us-ascii?Q?tEaJmcuwyoafosWtcJ4RZOiloP2l4wjP6QHQ6xhwMEGZdNWb/d+Pa/K7zV1Z?=
 =?us-ascii?Q?8tsOo2W/DgWpE68DESRVy5wDbkThteFu0yuKncmiDdhBobsAG+AERDvrYLQS?=
 =?us-ascii?Q?GJxi+CQpQsiPuveazmbCqjcOycuVxN0SmLePN/UVgrGo81x2lwF0fDwBLtgH?=
 =?us-ascii?Q?RDPspvCQCgo3BFPcvJ0vnnugGdufUoNR3yQuN4/bRx+x5XTtF9QmTy/ydgho?=
 =?us-ascii?Q?RQY50RQLNgqQUUlQJoaM6x/wSE1ypsVoy7EORYRE2ekJViHs5jwk4sX+rW+2?=
 =?us-ascii?Q?S4Tw60p01A2qWOq4tpcC3lSCY1JLM5nRfZRXv39UJw1P3D94RPDDj53uCfvl?=
 =?us-ascii?Q?tKFqENxPYREtLT3KFn43rFcUTGE9WAwV3HUkbo7U28Cp+JNwmHsEmWrb6v0A?=
 =?us-ascii?Q?YbbZ+YpyiPftm3FMmjWJE9U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a4f6cd-f182-46e5-abad-08dde5fb8a0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 06:24:27.8793 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S90XyD06ukGMBiCWUN80d9NsVZBwWQwq5nRgPp1z+9dfNcu7s34tVfrETObE0AOTVDOxAPAvV1PwaYI4zVhwiDMx+kPfmuYwZLCnAzhq9oAhh41/1qIiZr5UajDsgRHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5676
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

Some USB devices need more time to be initialized. Hence,
increasing the default USB Hub debounce timeout value for
devices to be discovered, connected to Agilex5 boards.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 859750f02e7..6f7a2cb11a5 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -101,6 +101,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_DWC3=y
+CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3000
 CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
-- 
2.35.3

