Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 993BECF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F1188DDA;
	Thu,  3 Oct 2024 23:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DmD7P+nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E0988D47; Thu,  3 Oct 2024 23:28:15 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2509788D5A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/K3hFm92KUvEayJ+evW+0ExHSwsfoMtDNkIeF7SK+KdYWQkDafjmIYJ5jit24JLyh6rh/lFALkhBXqmaxfJE9pWOLYxIs7p9bLdKBLh6HH/x+XXh1OdxUkUS5f9yrFrMrcTywqD0owt9um1vGnioY6DjRHzQMryKB050JzjNFvcdByXilWoP6SKFfwM17qRDk61jIJtLGZPWvdQZAQlS2YIh+gyqaMy+d9hN5c4zPyyzOKKv5omqP0ygH2CV2gSmPCUrgourq6fDPEfYPUKCzeogf6bYov5KwlfC7r+a/yfhT8zyPJ26wF9/zyWZFsK97WQvWGysm1z6QZF+NdT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP95F6x76/ofVIQ12frDG5SSDUQM5/fneKppbdTqAt4=;
 b=IxX55Vni4Hk4IVicVFzRcVvaKYcrCt8HphdyilNRU4iK5Dt6kmn/2NUvlHbCGpWFH5Vh4NWaJ5tKlRR6VgSihSNt1hUhS4D3+l45lo2neFAgzWdKUwPgSDVS3EXzEeGtoMDOXSjwOAHd8I0/YOmK60Knd14ov2hPRwsZLwqYfkO05Ni/EF2OpE/GiRlT+ivOZOkdAzSB8gtBmyD5gfmRQCLbxEMWUZVUBmU6BWROxPKhv9GDwiU133qZLanjsj4sN+yu7stHZCWZ5TuNkuv9YsNaRsJpgEZor1yrc/6R/7tVyh0XNj2E3BW6MgiKUkCFXGEZikMAcBA3NctBzABAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP95F6x76/ofVIQ12frDG5SSDUQM5/fneKppbdTqAt4=;
 b=DmD7P+nf/kUCvsmERNvbqji7d+xGGSRblGYXITkdD0f/p77AaOQEzp8723wMMZjXf/nzwMdsoDXn3IKyoNW57FuiAfHB1DzzekZDbpjTv+9rrYhWMd3eC3tO7nwI1mhQJ9VAgoGvmD0VMej6HND9mAaVOQTNwWN3Ie5yzwuUBT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB8118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:11 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 01/13] doc: cyclic: remove reference to WATCHDOG_RESET
Date: Thu,  3 Oct 2024 23:27:50 +0200
Message-ID: <20241003212802.3810-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::12) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 543a9b3c-4dc5-4f42-e7b5-08dce3f24870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RlWrGkIvcTzBoWXMLvtPY7HrazrENoDQMofpTIrNxco6Zfoo4Pn9hVou+d0I?=
 =?us-ascii?Q?JAyhOXEHR7yiTWWLA33/sBWWwnVPNmYyBjn9QeO5F1t8Hc3rCTpnwxlmrTvw?=
 =?us-ascii?Q?DQ+lUt21lzN84hcHJU+kPe360DbdDUi7LDdl4KvbAerX8+DfMLDYl00SQRLk?=
 =?us-ascii?Q?O8tU0v3mMCvgfvWPs03UbkONVxgPkXUZByWO08fzCDfkzfbiQFxAubKjTT20?=
 =?us-ascii?Q?8/QRL2dtYzj1ZKqAy3Ln/qcF5aNt6MYw4yOzAaBe/WZow9SI8wZS6Ac8g3vo?=
 =?us-ascii?Q?c3J2ZVcPk8FjMMdJASBOuVQwcX/p43is2K+FSP2uGDBH5HjIEvsDrJ7MFd4/?=
 =?us-ascii?Q?usWmFTY+uSb+vsm1aGYefSV3+x+wus74PdlEEIlELVAG0K24s9Hofou/60KT?=
 =?us-ascii?Q?fjt41pJj1F8828mZKjz1PPE0tjsXsPU20TPKCzHzZ6h11jgh5aszNx9zPFkY?=
 =?us-ascii?Q?1VNJT0tt21kWDjqiKE7QZW6PEzNo20+tsTztM+1p0tMN1nJvtAsN+N50Is7r?=
 =?us-ascii?Q?GOcmSzV/NRfEqb/iYsT5OicBrIJfDLXsUiCK1Yp1JiohX3lyhBPILvzCnxCn?=
 =?us-ascii?Q?f5U9rk7j7NePFFZJpLc/PKX6yu9UgO5qwMUsCj8YesVGt4qE7Kx0p0eE6XRe?=
 =?us-ascii?Q?TlQ34r7HjIHr8hCx7AOogFqvBp5DV0dka/6e49XfhfLzcQvR4d1CnUvPMPQD?=
 =?us-ascii?Q?x3c1Alj7BpOSGrHt2ivjONleBvDF/XbXfW6oFL5Lu/8EL7vKIvGdJa5ES/d/?=
 =?us-ascii?Q?h0BrKdpGijaiplRZNth/mbxfrfcaFesKdaflF4nCV5BZEjdZ5aSv9eFX6ogr?=
 =?us-ascii?Q?kPE9jj/sdqxO0uyPaIn0qZ5HD37VBB9aGblbmhSiK0bYBMdvwTS8y9xHsRw6?=
 =?us-ascii?Q?3bz+lTvQc4PF4Q9+EntUdanOs99gcAjhayev7/jUPCUnAk/nSzhzYEGJMXG3?=
 =?us-ascii?Q?FaytvSWwbHwzSqdib68qL5TyXdwGVPhZZc5eq8BwHeufmxRkRlr/9wBAG8sL?=
 =?us-ascii?Q?YtTQkK4ZVpwHOrCo8i/IvjIANOMVM6cLlgp5KJxQLj5gDu5KrpToGsmQElsR?=
 =?us-ascii?Q?emieLSRTSoRIQlXn33QvTLfei6HcyugpVKwEe1E1qtYB0V3eUubE4omFphXR?=
 =?us-ascii?Q?7lW/MCXUWWJwKve+0bkhg/WTwcqqsSmezznAG0CdQQvkG9z0mZ0U+8llCVBn?=
 =?us-ascii?Q?vOdyY0L/vSojywNe9k+R7GPf+G4G+oNLYUPqsA7rR9LGad3jXHjq9WhvNkol?=
 =?us-ascii?Q?xSFlawCbyw47I3ZMSCqp5btVhwV7c/igGrOMX30s+RpIyc6Nd1qu1jL/TfNC?=
 =?us-ascii?Q?bVbt4eKiaEbVaMp9Ys7cz43ohrSVAM3H3Ajyzk0d+Exu+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMtBGE4ijVKF23zBbMbAPGBHGeIgnn92Ltd6FRPIqO7OHU5pgpkQ89hurrqQ?=
 =?us-ascii?Q?K/0CaNW9okgIwVZ5HVekyv/cbjieoILkXQoKpPaZIUaPANAk9Gvv2H9fmFVu?=
 =?us-ascii?Q?W6nwjN0zBzQLU1y+vY5f7B4lUmYeYjXRI4gXh8gtK7Ah9r128WqLjn/di5nX?=
 =?us-ascii?Q?VO46wfKtefb0CVt2pNe1C7lsQXhgvXdKsSi/mRa6GhpOWO8S1ZwDM58sDoTX?=
 =?us-ascii?Q?+CBXFcVeEWpVVCJEv7HTTLw2KuDqPI5H73h+YGFILTwJgrTpzVRxtDM9kIhw?=
 =?us-ascii?Q?bF0i5dI1AK8jMpBMoQVWJK75x1u6jYvXY5JzekXTjYguB3Wtn0IEJwyuO2ZQ?=
 =?us-ascii?Q?SwvTDOwoS1E9YwodPFexKq0MZqAZ5dDNS+wQB+TVIO+mZKp8fqy8GfqXF77p?=
 =?us-ascii?Q?BWZG1zqMl4HKvFTeiLHN0ZGsCTGlubXMTtV1+pz8HJFkIN2dKm5L0JMSUA2L?=
 =?us-ascii?Q?PmXdF5LNwf4Vc0V7QPsJu1eBZ8Jg1GPnJ8R06gcNnwUrcBTpORPuGUKfTHvn?=
 =?us-ascii?Q?MstgT5miEXJMkfUeWCxqWN20Yl3XMQlkOqz3OU3lE+dVbsU5RLbkHJwNPAtJ?=
 =?us-ascii?Q?zV8QDaQCCmLFQFdeBPJkQlUJ+wsrtvQykC0FNlBSbhaNXFEeo1XsXab7oJ4l?=
 =?us-ascii?Q?7nlsPI9QTIAtt0EPhSgX1UOlcPi6Ju/8uZlyMPhLzGE2oS/7d9G2rnWR+x/x?=
 =?us-ascii?Q?Eu6SDrF+vIfhHRp/VhwyLN6r8htt/A+1hCSG6j8N6DPt0Qr+Xr5ERErh1z+3?=
 =?us-ascii?Q?dih60LR1+QToWvifYjfjlF4wyeCuzBsOynPdhiOpo0EnE9tBzfjyNKYuyxqe?=
 =?us-ascii?Q?Fkh8mH9QiMBFip8VRPo5GMhQ3/Ze96hpEAncXaQ/WBxcRn7ZrryThmR6cffa?=
 =?us-ascii?Q?+fMGdriiTE2APRKEgY3mQrvOwtwI1Q1Q+aUHhGG6wJ23knoeGizSeutkCRjx?=
 =?us-ascii?Q?JCpEHRtJjFOuTOf8biwJEER2JYxXFFiRbR5bgJNv5LdWx9qOodcTlb8upZjv?=
 =?us-ascii?Q?meLwzBW8XUxV73BMzrkjASLDc1KKlRdEZs7Hy9iACYdX1h8LPw8axBB9u8Dv?=
 =?us-ascii?Q?NeM/Cr8q0diI9Gxt+fh497vpG1glk+SXPRxL0fEjg5ARMoVjk0hUVaZQ8o55?=
 =?us-ascii?Q?0JGd+jqlfXH5DS6eePampN9OernEHmworDiPK4dleO38YFNBTNP7IX3a2/0d?=
 =?us-ascii?Q?am6XregLhKoLOOwgAnI8HxRagUo5y0qNo3CIXFr8O2bLQ8s85xf6AA+Z7W5Q?=
 =?us-ascii?Q?jMwmy90CzTS+Gg/xaecyLDZBcFalV9h8lWM1rGtUOpSZ993a4i8dRrIVonXP?=
 =?us-ascii?Q?dOk15VcsA31c7L4DiWXoSd0EdbIewZ0lQekCcqml3ykB5/NkH2kcdis/29be?=
 =?us-ascii?Q?781sT5GRWFwrraoFA45bIE5w8ZxmBiTUTV2bNJ53FBMCa2fixQOrlrd7tLOk?=
 =?us-ascii?Q?6tMi4t0HgOAIR3AK0wgR47lKRw1theD6XNbD60jOqdU+mIx6eh5OtCUPFMjo?=
 =?us-ascii?Q?9F4FeKJA6iSLe5iEtok1eWjUNUnvqotMFofrWPwPsFF96HQwfHaUfi5vhEdA?=
 =?us-ascii?Q?PZ2FwHY16iCIr8WGBIA7O3D/OJO1zHDgdKxvNP17/lXtwIRmI1cGChtWK8pC?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a9b3c-4dc5-4f42-e7b5-08dce3f24870
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:11.7853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEhcjIKZOkdXkYQ/I1ETL/SbkMc838rJkLe3z35MXEViUTBLlIk1HcVhHs7eYAllKyrirbSNApEZ7qJgeZUhR4uLrGq14BqcwoUFamHrtjA=
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

WATCHDOG_RESET is no more. Replace the reference by schedule().

While here, rearrange the sentence a bit so that "cyclic_run()"
becomes the object and "the main function responsible for calling all
registered cyclic functions" a parenthetical rather than the other way
around, which at least to me makes it more readable.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/develop/cyclic.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 893c269099a..6f1da6f0d9b 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -49,8 +49,8 @@ executed all 10ms.
 How is this cyclic functionality integrated /  executed?
 --------------------------------------------------------
 
-The cyclic infrastructure integrates the main function responsible for
-calling all registered cyclic functions cyclic_run() into the common
-WATCHDOG_RESET macro. This guarantees that cyclic_run() is executed
-very often, which is necessary for the cyclic functions to get scheduled
-and executed at their configured periods.
+The cyclic infrastructure integrates cyclic_run(), the main function
+responsible for calling all registered cyclic functions, into the
+common schedule() function. This guarantees that cyclic_run() is
+executed very often, which is necessary for the cyclic functions to
+get scheduled and executed at their configured periods.
-- 
2.46.2

