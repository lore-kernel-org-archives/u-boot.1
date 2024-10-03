Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475CFCF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4771688FBB;
	Thu,  3 Oct 2024 23:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="eMIncr9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0744C88D92; Thu,  3 Oct 2024 23:28:23 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA0588F91
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7l19PFnTg4VWGq5WbZQ+ZQLtb4NQGi1DqeW09l52fpMeuvzNF/5q/jj0l/fQChvd5ipiaU9h+SEY+7e56vY+2ATNNo8pZT+suW9IgU8mqn3U7hlOB/LvU1RgOqu9o2o7yCL0JtpiKJMCwWGuPBB239C9CjI1ZF7y0R5DFCCaqxRj16otNjm7OARWSBVALZ2U5Ju/r9HoyxCy1zxZy7a84xIAlHdJUZOPT7K7SpsJ5hsUzTbZoDI4flTj7ibFutbWAa/ijfLfoaVnL1O8TY7gcqXIEU9vlUUwC3VkKwVwi0nwp2fn9O98CQQHG24yWoZj2aEfmAOb8crwW219BH2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJRszOKrbbIXORg4CdYtrLBdWPb0NsTIU3bphbMiaEA=;
 b=cEU7hJDtIud5QBs3/2Cgw81MKsYolaqHGdfqCl7xqS5FKM1tMkTffrSHKO96XeKExCt1oTcQESy95ZHeDw2wDqlHusW+4GYv1Lx72L6dXF3q76TDxBFgRBkwF104PI3F5GPc9xjUDDfU7EiBJOmoPkTtx1V526DRgk0lLR8ePeN1hdOjewmVG/tAS8ZvGOtU4/SuDzxOc5U4ujJDSQCBvfoSB8H73i6Wh+O/1lMjoqy63Cg3VUK9PUboPXNk+bKavOdeZ7CCzwopPFYdQvOYFfbUWK+DaE6gSnuNzRMN68Z5xc+eeTrgbLj+r1z+g+UrqbPjZLjwAD9zJ7jg4Bbb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJRszOKrbbIXORg4CdYtrLBdWPb0NsTIU3bphbMiaEA=;
 b=eMIncr9zSGpxNL+nIoGcWksKrQqi9S0sWYihOtNNZPZgOUNh6uIJcGI3ODVgjY+JcQHARCYmVZPKO+5bSKMkhbZiCsBQqW76oWPJltmu5kR6NaUarsFCwz4e8m20xKn0ZJfN7MFRaOx3qJHgAxCqevvgJ11Kevgc5rkWilG2kNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:19 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 07/13] cyclic: make cyclic_run static
Date: Thu,  3 Oct 2024 23:27:56 +0200
Message-ID: <20241003212802.3810-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bb6777-7122-4bd6-7e0c-08dce3f24d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1e1X5hRegEL3Ra6hQjBh9tF2y7f09RcRHbemJnNOb1AUbofdH/pJ3kQne7vp?=
 =?us-ascii?Q?GLFtlS5wjZ+zhMRp65miCefqyyzz6pFObcLOtX2MyzIRU1C1vK1kBGYBvSMG?=
 =?us-ascii?Q?JVyuSStl5Cj5n9wY6FElbknN3AI7L9ciQdWB6xQ/ZVcklyZH8lhEtNqQirwq?=
 =?us-ascii?Q?8dSn8wTEMsN26wWPQdTM93CRDWKXgM62mHQDrKU/nq7XDXBWzX+6yMRHjfQE?=
 =?us-ascii?Q?8jHonGay9A3HmAFDxlup87dT/zFcmJlu42SvuZ7RTDGcNX9BiGALr8nsOuXH?=
 =?us-ascii?Q?1RY327kwk8S4UoDSSPQif/M3FVubAFiDLiZ5tLUBhAt+te9YX5v3mzWRSzWe?=
 =?us-ascii?Q?fzykBT62rRdmCBZiU+hIthLt5nbu3wbp5ufo+FgcCRM2v9iftffUIi8M8SrR?=
 =?us-ascii?Q?KdXUiV9vDBm6/5bbvKbkQq92k0ZFoz38NOGj3jLYj3IqXXfcfDE93O9/fHgo?=
 =?us-ascii?Q?NjSrBXyf9PjzXPmFS1hvWy3VhskAOI7WiYMsdRw7Jl8hOtoYy/spqrb/kb+N?=
 =?us-ascii?Q?NmYBoDHUFvpPp9RiqQZi73CaLo0DvpTN3wxNWCjZuobfFC5D3oZuFDiMMX4+?=
 =?us-ascii?Q?U/TqB4Dko9ryMvEU/stxNFWUyj8kHupwn6eG3ssWoPNsmPgyLWKQRKyFY7yC?=
 =?us-ascii?Q?LCR/RNqINkxKUpmC4cz3voMv1KJH2GyZRDehnHSH1bpJlF4vkaCFeH0Sz7Nj?=
 =?us-ascii?Q?FrnVnnT/NlXnaRRBdh/O0KR9XhynEFjs3UYb5okLgEjV1qcraUfh3Uv7uTDO?=
 =?us-ascii?Q?OEA/2DoDljEKF0ooSOOtGW67N6R/1P0r2JROcCA1UVNfJYueh9zsFBxkX859?=
 =?us-ascii?Q?dJlJxBuw+gecfl40bbzzI4cqOq7ASKuWl+aqeoInnAnKGS67mFZ4JhzIqySH?=
 =?us-ascii?Q?zj/cGIk33qneSUiJx8B0rQfwgftHsZxe4Y9HL7HxFoMUHn+QqedHLfjoHhId?=
 =?us-ascii?Q?CyQEMFpEQE8L8tOhQ+cdMgGpKWCnWPxzOBhJjPuD8vJOFs9Ql2DSJP1D0EvD?=
 =?us-ascii?Q?+gIWtQUy0ckMHYMZQ/67yn39Jhdy6f2YpFO/S/i3hGMPbMh0/yi9l0j5TZze?=
 =?us-ascii?Q?Z85dmobm63pVTLysltIblu7miKLyJtGzOfAT077RdKtfbspXoMmf5zzQOGE0?=
 =?us-ascii?Q?ngB2QIQWuwGi5mHjMd4XQ1BPI7eKikkBOhaYmvw+b0HeFXYha9ca66EU7hVN?=
 =?us-ascii?Q?qZryrP0CvsImdVvqVNfFMqcRzFXRFPlwnSGkNoAyM8zxXkta+ltUjSE4tUZV?=
 =?us-ascii?Q?zUuGl8bfHkeNbrv44+VaD/pVbaGCNqEDIC54sBSSK8MYk5rKslqbryYv3I9w?=
 =?us-ascii?Q?jRem+nflzcHzRwGDQfsQHj97M7D4dZ/Y/XapoN5b0YB9jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C6AR/beDlN1XXF4r6HJo9Rg/AYXYE/hcwb/zcJJeKd8X+r0ljPWTl88g2lrz?=
 =?us-ascii?Q?IVTEV/WnQlEBGsKDaAieMyKt6i6Dvpkb2VLjCfNJFvUNfv0C2C8bmdJXGrIR?=
 =?us-ascii?Q?oK6Av5s0CPcE6fAvB2daTjLxndEiCyUEgq0AOWy02HpaY2QZhi+Pq8xy4sCD?=
 =?us-ascii?Q?nDrkIgPXLuLAcoCpwakd/kP942cQmaN/DpyD7OBfdy78H5zcfvOhYY+dwLjF?=
 =?us-ascii?Q?3X2/M3Ql72CUNJR/K3tjN8yADqjhBEsTkKbFA9PM6tuKYYTWduVpsdTGldJE?=
 =?us-ascii?Q?npOADmMpQvP7aXPIrMudUWF56hUG5ptr+/bSIocsOha4+OdIxKPZfchy2try?=
 =?us-ascii?Q?X9pLQcCNiYmNU3/jjiX+7uIdU7lJvqSqdzEtL2qqmtAVP1B68TBKl+YsD/NF?=
 =?us-ascii?Q?VDJAfj5Jk4eddliIA/5L/PU7MP4Wcm83xjY9BuEZAIwiTe4eZl4NyQHarnht?=
 =?us-ascii?Q?VVRIgWj+OOBh8NKhcXN6fxcb3Ot7Jv1I8EXxgX2Yi1mOBu0iNSAlltXwIswt?=
 =?us-ascii?Q?SWccepILiimhSh4eRsDBGq8KHmlN04xb2rA8bwyA6rNE36DX7dhs8VHWTvhY?=
 =?us-ascii?Q?uIA7hJK8TRHSdp7K9a3Cf3P5/CPvEqkgV5mqkFcso5QlEGHZztYNSinviM6G?=
 =?us-ascii?Q?nxzdssuQrRBFNCKvauoAHH8GSfogOtKDUKwi5cOlheXRBESqbgHP2clpU4RO?=
 =?us-ascii?Q?QLFnnLLfV1YM0qnb9NlXolCgjMWfUDCw2M86GZVm9Wb7qxdINhLHByBEpe32?=
 =?us-ascii?Q?L8HEwErAP42E2gqWvEdJtCkCZAc5ayiwpsYcXbNFWJ/CTt84O4CJXQZV+jNU?=
 =?us-ascii?Q?kzyaRlPKx6vBDltVJAUPilOgMbUUWDO7BEC3zjmCo4XowlcE4stzxaquovxU?=
 =?us-ascii?Q?htzwbp7hBVN1wUC4Jmd/Ra5Y4BsaeNIXAAD0smSwd3c1RiN1VSkPlSFYLpjP?=
 =?us-ascii?Q?2I7cQVL7Kqc2ByLPOsASK7auOsp3uq0E+4zWqx2QvwE5j1/WZi6NFqn5oiOp?=
 =?us-ascii?Q?Qnv/ZpIXjYObqoXqkGGrS/XsLWOiHGGBmmGlNHrZxPvearS2yO2cX/7DF7MS?=
 =?us-ascii?Q?FBvBq9HVwQZBYO/f/kj3PX/Sg1dBTUe2XbSd+dZ897kY8/6m428fqzBSvXN7?=
 =?us-ascii?Q?u+3zvMwlLhRycsrk/Wnjd7cfHiORyN41QIjd+Un96DNPk7EjuK+Oeb1ZKhBw?=
 =?us-ascii?Q?20wfVsUbg8bd1wUEICw6WQgLW+BsGGgo8czIShfOqNRzv+lRDbqe3FrTl0Z1?=
 =?us-ascii?Q?gEaCKAdcuUsLZ6JIupaQ/wGjcd5CeFWBTkYSYdMyKO4MhD0zHOwxGiaN0dJb?=
 =?us-ascii?Q?PQ0MwCaN60i7Pxvj3k1VSrrqQi9TGC29CbPHXpiHBUsHoj5jyjbqstDS2sL1?=
 =?us-ascii?Q?kabozT/oo7AQUCOlbKVlfdX+NPQIQMgE0N0eA8V1Dd4Cb97Q14sI77ToBOnT?=
 =?us-ascii?Q?+9Nrizp+SjA/cF7ULTVpp75ITPv7m9tIO+QEFrMaT8WUYZnfBsvZdUS4prpw?=
 =?us-ascii?Q?1GevUECAk5g5eoOG2Y9r1fs1vvFlaKmQDYffp8CPYGQnsk9rIMISk7UP6bbQ?=
 =?us-ascii?Q?ugFt9tJNq8q7os6aBdg/Dtx2koIH3aqx9Pnhja3ntkxCyWX510/hGWbFrXxz?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bb6777-7122-4bd6-7e0c-08dce3f24d13
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:19.5287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DClEZFxo5R0XLDhTjcps7TEnsGoj3zDofI2+q5xWxLNzep4CH5kWKmTFfJlSZIWsPwfHdk7bERAKWgAo7LCnoQSKLDdms19pFNCPI7Cu90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8118
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

The only caller left is schedule(); everybody outside cyclic.c now
calls or references schedule().

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 common/cyclic.c  |  2 +-
 include/cyclic.h | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/common/cyclic.c b/common/cyclic.c
index 38d815bec35..196797fd61e 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -45,7 +45,7 @@ void cyclic_unregister(struct cyclic_info *cyclic)
 	hlist_del(&cyclic->list);
 }
 
-void cyclic_run(void)
+static void cyclic_run(void)
 {
 	struct cyclic_info *cyclic;
 	struct hlist_node *tmp;
diff --git a/include/cyclic.h b/include/cyclic.h
index e8de616dcd5..c6c463d68e9 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -87,14 +87,6 @@ int cyclic_unregister_all(void);
  */
 struct hlist_head *cyclic_get_list(void);
 
-/**
- * cyclic_run() - Interate over all registered cyclic functions
- *
- * Interate over all registered cyclic functions and if the it's function
- * needs to be executed, then call into these registered functions.
- */
-void cyclic_run(void);
-
 #else
 
 static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
@@ -106,10 +98,6 @@ static inline void cyclic_unregister(struct cyclic_info *cyclic)
 {
 }
 
-static inline void cyclic_run(void)
-{
-}
-
 static inline int cyclic_unregister_all(void)
 {
 	return 0;
-- 
2.46.2

