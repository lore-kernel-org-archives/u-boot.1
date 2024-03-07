Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7D3C48BF6
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 15:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF56987DAF;
	Thu,  7 Mar 2024 16:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="Q9iz12Yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F96287D8F; Thu,  7 Mar 2024 16:30:15 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D78CD87DA0
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 16:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX6RpzvXIMylbqMZWQNWl4i6kgnAyjnu/Mzy8PZXFVG6BmSMH+mtKbweFZ0Z30NnIQlkSgsX9ZxYNdHXpWLrXPNbOrsV5G8/c15tuW2gSMojrHdMHk0qI9gDVKykKuxZXYQ5ixbo4YwEL/EyZnITgBgYuo5SfJRtJzxUfyMi6DLRTR5akd2NDjrw0ON5cgzPhQ1aLis/WDXLnhIE0Ki8qmYG+tDBHl+CWOR9+bbrBQdgPzbE1mHxP95LoWV4RjOaaUIuBlguDvLzAOnVyMXsN7ZCZHxlTdbhrzl4MDz2JeAnDckrAfNQhgL8++QdL9oYPN7FYZ5FfVkUONNWrNHfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feSmP4BfxGy1N7FU9Ohg4JUTXnmZkCgZg3/MGa1iDBk=;
 b=gOOUPPLglkeTcKGqWc6nDUnniMJea8q9WK7Ywf1FTLjpIL35nqxhYRUj9ZrnI1nrnKThqF5O/1TV3YN3EmKcLMU4VfQcQq0+pbp5iNd53/OF6vEzv8HCXg0Ef9uawu6nTgBrLJfiG9Aj0rnzu3vXZ0L/pdK+hs1ViVigGRQd7oQR8yxuvpsj6dEkjORtkiN3dU6If2JOISUP+3tGAw+7W9A+Ai/r1DWwj6U5BXqfe58tPEyJRTK25A44j/6YJHL7GutC4Q3lwBtGh3XTF6wMc/GzgD/Zhmo90J8ZR3JHePDQupZXxG23nDbxyAVOjHcsrdYA6aWbnzXiJ11cHNIvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feSmP4BfxGy1N7FU9Ohg4JUTXnmZkCgZg3/MGa1iDBk=;
 b=Q9iz12Ybq95+2PJpjoI+IyRu4JYOL0LlRGwzhJ1KRWbsZQOPfHY3u9nHyKJmo5qaTQxLM2M/c+txD2RRAxSXzSBWW7PrCWOOl9qKywyq+CjV1QA4ojpuACDjZ79aE85K7wn4TTXW5E69UcEnXAas8LZTWHGNoiWkmuoZDjVf7+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS2PR08MB9497.eurprd08.prod.outlook.com (2603:10a6:20b:60f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 15:30:04 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 15:30:04 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v2] arm64: zynqmp: Add label to pmu fwnode
Date: Thu,  7 Mar 2024 16:29:56 +0100
Message-Id: <20240307152956.431104-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0191.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS2PR08MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cd86b2-9067-4247-90ac-08dc3ebb7610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUUoR53kzFq1M5vomdEhj9ZoejbvmHeLsfRH8ecmy2maQdg9gmGc6PuW/yxUtFb/Q4WfJNlIW3yfTt8nkJ0FkEIy5k9qxO/6W3mofkVDHC5Dp376xRoDaux1Sko2zUQ1VvsjND48G7NBTX6WhFS6a+WBxIePiVZQt8MzCdl8LPYiA5bEFw0SUcaJb8WbJcXpFWOEAjUCyrQxohko+AJkIpCr+odRqKyVFp+G7Hd96rSI+SboRxVdCfQ7xXEqA+bJw5y74fyFjHHBZ/yP2enkCZj5qbFFyZRg1khOxJNcYn0K+YvNRoSq/Ml+bFpvERaxNQuFeh0KgCzwT0WTbVVx188O+segNby9H9PhT71fWlurDbTlJ97LzeOrM0eTYq158ZqXXe1NaHe8gu9dMvkDiuoVZBlQ7gIUe0FZu2e9d32fq83wyaR0o7weG76xEDr0RV7BLZDvpsz/F9o+K0rmAaZJNb3jaJ77QWt07USWbja0VyKGpS3QdyMDVzJof6kNsw3sjUdRjoc0M2pGRV4a5+n2F1OokH+F8m9vLu2jG/qOKjUWSysBVZyG+EvAtGRrHvmrsz2pwdE8aGMpSIMNSTFGc/bc6SQx4KvbqrjF9AECOetmGOTjKxbqNwjUNaK3EVzzJkoCPIj8nPWwW9ySeueQnv16DDrFy8jKe2Qbp1HVLzTAm4Bk8e4TF47ncNuKnJT2INIL/whaEsqweZBmyVkRkRX6nta/phtI6qyV5R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNULr+8QzEEfcsB5hpcpbfXpiN22FUQvxcowsjBoYWxhpqun+u245cbP1YiY?=
 =?us-ascii?Q?NdsPHUSGZCkbgrMdHiFyTudwABBMBawnvDBeBDic5SfngIGz6nmd/kCZpx/L?=
 =?us-ascii?Q?HauA1V4D18Auph7o/3cUN50qKJImPYsGlpB+B2p1aPIvDtcbzheBlGhoIMfM?=
 =?us-ascii?Q?zCjItvp9Zj+ZK/KZJZGdBr536iSnp7OIia4etajW7HUPmPT3UinMpB2BsXSV?=
 =?us-ascii?Q?iouM3T/fIVLem/pCfMQ+SHRvEg9/sMiH8TSowKIRzhn+MR+AX5YD94oef1qb?=
 =?us-ascii?Q?XVabuhnNDqWEqU0NayMhN/e31CUKgZFN4qdmOuVFT/O3x/stqObStuXQ8aV4?=
 =?us-ascii?Q?cNPPvMLO8prj0tMYuRna6MXlP6VX7DunzO2eVjPOe/qESISGpdvgxKFvGabb?=
 =?us-ascii?Q?MfKDnBKsz+a6GVFHTJwZ6Q2sA4hmUsyID6vOAmyeAbu6RnDedbwaF5osxuTT?=
 =?us-ascii?Q?/EjG4EqfxWVSZvwuKfBsA+U8cVzyu5Rp5/8CnRi5mzzzqirz5ChHLasPoDm+?=
 =?us-ascii?Q?9B2VXzei3T83Mw2vyoQYwDLgPQEgEFH9NA38eJK3eyDlmO84cYCDvLdF+qud?=
 =?us-ascii?Q?Zws8ELlpxaGTFIH98aknsEIvxBEWcEQ7EG7XR3CVgepsM0AYMrCvcyyGVPzV?=
 =?us-ascii?Q?GrHTeRzf+Atx27LuIas9pMC2AmehbL64RXcOQNfz86J2uqe53nkHKGDqSjjI?=
 =?us-ascii?Q?bgdqSmfbSNhPdKjvOu2HjCZkzRw4do5mDHNTHM0Mlm6PMt5RnseAlyuIpnLw?=
 =?us-ascii?Q?f0nB2IDG8/EhUOi6olgWrpO7rEdoIIn8iw/+cfjT5kYjXdgvKFKU5Tr0Tutb?=
 =?us-ascii?Q?Mu77kFxW7i8iNZHLlrqZYOL0WOpEuofmjuxC5HJfORf68rCsdipUS0aD+MTZ?=
 =?us-ascii?Q?J1h7qgIkzEVo+HvCOq0b/5QGYJtor+mucrt+yK1aAZub7WNmFjzWSQjVtR47?=
 =?us-ascii?Q?ZnvZ6Wq+x7c0hcpYsHC5www8XmpRW+A0HLzwwLzQaL3MyDetPcyOuKOvuLiz?=
 =?us-ascii?Q?gmlgX5qbfJLVozxmuBqaZJ7fybVUTN9O+AbkjHxu0C9/nSvVGmLAi74PkEIf?=
 =?us-ascii?Q?fjCQxuBQN3+VIZcuaURddp9rEpADCxmdA/tXyllhXUpmpnKjy9hMIUQVFnYI?=
 =?us-ascii?Q?415rXK0WCkh0q4A/UMR/P1MpPDbURpIvz2HxJKng09aeTdkJAIfl+yn6uq2r?=
 =?us-ascii?Q?W93vceo3Ufe/Msh4IXceDA2/CAa30btK5bCxEZxzsBAaEpjZjzCkHDKqv0vG?=
 =?us-ascii?Q?jQi0C3TMxTUUZvz422FEqwtLJjd1KkEiyDSpuNLYUAmnm26nqi/qrRD9DK1u?=
 =?us-ascii?Q?UAxEzJqYVIs0yP1awnFWwXTaUYmz0i3KO+Z4usuGy7NLnj0G0OPWB6Ownnjh?=
 =?us-ascii?Q?Brng++SPACXh7+sr6rsKQo65kmYW/PFZ5yuecRz9WHMv/sWfIU7dhgYf7JfW?=
 =?us-ascii?Q?b2Acv8PDd8x149VVdTc+QhmdkyX7V06SptqiLtiLywUM4euH7kTif23dhUeR?=
 =?us-ascii?Q?tz5Nid2qXDdL/F9N++vUz7sCRCeGzMYakIy+AHLWfz5E0zx8uTDoS3HU2W4k?=
 =?us-ascii?Q?6JgL2t7S6MAzWxlxZ0ZBk3xaSOWEUPy2P1l3XjyO92eRxHtvPownx6JXFoWR?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cd86b2-9067-4247-90ac-08dc3ebb7610
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:30:04.1409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: styX29fpQCzCB4ANjouGoy/thxxcnYdnXIwuuVYvWB4R24df1Nn7Muo/SmdVZ0CyVl0HWA2Mmxy2bdpQk9jr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9497
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

ZynqMP CG series devices only have two cpus. In this
case the interrupt-affinity property has to adapted, because
cpu3 and cpu4 are missing. By adding a label to the pmu fwnode the
interrupt-affinity can be adapted in a device specific DT.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---
 arch/arm/dts/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index b50b83b772..457f8e394f 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -168,7 +168,7 @@
 		bootph-all;
 	};
 
-	pmu {
+	pmu: pmu {
 		compatible = "arm,armv8-pmuv3";
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.30.2

