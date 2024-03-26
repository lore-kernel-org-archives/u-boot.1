Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB52C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 15:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFD6E87FAC;
	Tue, 26 Mar 2024 16:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="UUciDOg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDC688043; Tue, 26 Mar 2024 12:07:19 +0100 (CET)
Received: from outbound-ip24a.ess.barracuda.com
 (outbound-ip24a.ess.barracuda.com [209.222.82.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BB48644E
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 12:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169]) by
 mx-outbound40-112.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 26 Mar 2024 11:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwvoC6hC0mxQDmSv9S839E7RWozZmXhCap7ueZ8UOq9pSP8dK3EXg1SqhzgiUD185LqyQCmH6FV/2QKQyZTEfymwvUXYujI0t7SR+8jIFANJpHx3kCOoTvr6r27IVNCNOAbgjVxpliQ9Pl2qqIyTqy/xV6mP6QTinXX1dMVxdxzmK1JxZ5xJDL9zo2HN/+aEDFD7gtbwPlaxXeocuDUBFpQU2DplRwlNOwrwb17IrhEZvqtYW1BtK7FpP5HFZ9K2/Lqazv4OSugpGYfRKV51g/uZxVb6Lqx5beXwA5Ixr4gScr8+tFZsNAUQNaWgxQLbmzmBWM8drfdL5J6fhtPEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX06AMW+o7yolVRNBmMXEcuNomiM8i+FKekkYn8MUTI=;
 b=OA2Ryy5R6sRJHGYq7bB4eQfdYz1izvZ2zvlreoIrwSBQ5kzP5/6hXBlXa1U3d5rfVI6vFBVmSbVjD7zTO0DfnLraBzyPsVTxHJyhca6wEnakPoleqhEsdzJJdDNxGZ177MPDngz3/2kkWon6cf09htcQGOWa9yDNHwQS/n7Gg0iVyI9HVqic24x0UnOgm/yqs/zH/ZCSFtVgmHRgBjAVSqqA1pxjCOtoROxmg7YL+z+l4fDalb8iM9KF+YsxBGumwRQCUOH0uXq8puQdMcNC5ynyCZwLZn7pB6IgSbTSXyNYVvLGh3bkfMEWLCtjEAtzP+N+1/p3mjzfXe8o31JIwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX06AMW+o7yolVRNBmMXEcuNomiM8i+FKekkYn8MUTI=;
 b=UUciDOg3mffSl8TKqOVs1+F7RbQqz+gq6z11OMPrdlXwqdk5MYbHAdcB2yI6Us0Gz1TpKp8OLaPVTLvFqiz+Bx3du5TrrcXGbI7i4nqj2VTsYhA2ft60sum0PGSVHvNeJr9SODU9RQtTLkQ304EFAagHWX2w27RHLkasXEggH5E8Z0Df1KUboRjKWO4xbuJhX+WCWcK1Y7BWyEDBx1toVGZk/Dtan9E2+TZNu+f+UTtbNXl2BkuTWkqVNCB9sQWIJtU3w56Ipaop7hyzSblkGThgR/jaMbsF5e5LVhSBXQA99dRBwmg5xuWNSM+E7KT4M3Z4F9SWLPnlssRFAKfx4w==
Received: from DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) by
 SN7PR10MB6498.namprd10.prod.outlook.com (2603:10b6:806:2a5::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Tue, 26 Mar 2024 11:07:10 +0000
Received: from DS7PR10MB5167.namprd10.prod.outlook.com
 ([fe80::2991:3274:498f:f9d5]) by DS7PR10MB5167.namprd10.prod.outlook.com
 ([fe80::2991:3274:498f:f9d5%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 11:07:10 +0000
From: Javier Viguera <javier.viguera@digi.com>
To: u-boot@lists.denx.de,
	uboot-imx@nxp.com,
	festevam@gmail.com
Cc: javier.viguera@digi.com
Subject: [PATCH] arm: imx: fix signature_block_hdr struct fields order
Date: Tue, 26 Mar 2024 12:06:56 +0100
Message-ID: <20240326110656.21110-1-javier.viguera@digi.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:610:74::12) To DS7PR10MB5167.namprd10.prod.outlook.com
 (2603:10b6:5:38e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5167:EE_|SN7PR10MB6498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bjns3MHGrOUvVDx+BW4oMWRRjpa7nJ+uHBmOfsxH1hegMvW9aU93dmkDk3cZR81qblUrOD7dOufWb3iwGLORq1dmW2paEPRXOMOSvKcFDb5u5CqG01SBnTN3/h53GnRhkvUY9BFea7n665DH43h/2IBR9TjsIgidsMA/fygxYtFwjTEG9fVLc9UosrRau9ZviJLu6p+++2FSLMZHcVaRd1aJivDwA427JqTu10ET4Mm8bkvgmbn+bUdLgffPnGK6/rJe+7bZNJEja8tNnbMV/AJRHOIZNFJsf/C/KEX2oHAKB2ZtkU3AXWqfy+S8CNEq1ZlofPwA4sOTBv6rUt8bOxhn27J+q0dxE8ddQGYZ24spQLaHsAaqybi/tMGpIvvxFwjN7s0jfvZsse+L4PTZ4HHdk+YSBjCVs0HlBJu9F5zy6yc5/NFnwO/LfOo42YEqXkyBfhWN7z8B1m4pXQNpfzXhrgqrh6YPH1fzStOV34WG/L4jXBQxK8OH9yOmc83w52CGPV+it4/68OR/DUER1tmE9+RHBJ2wdbxRHLzP92CzQo3W0w9YTCYJJSHSzNKI5A9qo84T7L1bdy274W8nRAI3jwsL2I8qO/ARbCNd9SSGBPNF2gM/HzRJCN5+zdqIHCfbyqbIA+H0rA8yQ8PEVUas03CWDgzUkGicdIQsoLyfl3toB3tXB71VQ6XIOIY0MSypERB7UNG0sEjkVtNjS8ak95pn9ZUcQxBkcHrUQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5167.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vMbLuIdsSGmxOP4kZqVzH9LsWTxe07fVZpRrn5TFXcPqg2p85y/ex8qIZ1T?=
 =?us-ascii?Q?RHWQ8u5z5C1uRklKcquEJCOl6HEC4/bAnO0pBpt+hO5PpIY2pqa+AYP2/tV7?=
 =?us-ascii?Q?eRhIA15+Y7aD5gCcSdFLyRVDEpLRmtQQmYxRIVSWpxmzYFXXOPJSjRdZ46Xe?=
 =?us-ascii?Q?bjl19q1xqUlzvCIHEUDCH7Bsd7lF4bEUGBfgtMfPuZrrRToMfwDlvKiTuhMm?=
 =?us-ascii?Q?V5L4Uuf2Se4FdALhBJFGpjxutLQaFsyqesyvpaFXxL8V4eD6dREbzu5N0+zS?=
 =?us-ascii?Q?NTiYR+3aaT/2+711ksXRGNgvQyMkOitRJJgwrDzsQawtQlWCC97RkUEsmDcr?=
 =?us-ascii?Q?LCTh2Q5L326MnLfL1JYcFvlesyVtAauygjRZGCTdFGS5nDjZvYBubcZUgM88?=
 =?us-ascii?Q?9EetJByvOzaAA/oaCKhho3rL+FZkd3eACy7PmtzUV1e/YMsdhxOTD1cX1Loa?=
 =?us-ascii?Q?8AM9KXw8p8LQu6+Yjbm4j5K9vzeTNFmsc4jxL1Ed3KXe3uxX1dFUBb3a5RXm?=
 =?us-ascii?Q?Q5StidIt7QGd9A+oBH5Fd/jBM7bAQnyeAPgYoGl6BGH6SzcqSbzlh55Mhren?=
 =?us-ascii?Q?GKz5/Yrccrh55t5bmHO9L9YUzgG9BHb1DqBCUQIVlIrFWTUtssLW3eAez6Pi?=
 =?us-ascii?Q?51yH8JmQiwfDCQPClBB+1TfUxXh3URNreAJILEUrmhrq2fm2/RGkfEIZzXE0?=
 =?us-ascii?Q?aIuOvPLJ+qpsaWCIaqUuPaX3IC+WuirBEd933UHYAXdQquX7KEBLOnQJtLFl?=
 =?us-ascii?Q?Bg5J92ErxYopl42jplUIXLq/PfGPsqIL7Y3R2fgdzvIb0hRvCCTGXJtV/zH1?=
 =?us-ascii?Q?qcx6wFizXMlQUXY4DIgBw6IM5Oonu6EFtdZbFAP3terWC6d9tOTXA25tk7ur?=
 =?us-ascii?Q?lEHcb2OaJ22vvkks6p9wyfgRf2towp0SxLlC0WwjOXbNyu5XfrTIhfr1BK/H?=
 =?us-ascii?Q?7Ejx7RC3mUhNdsUHTA1QVmQEN7AbfIimfnOYUgiy8PBpCEs2LuveejU8c5g6?=
 =?us-ascii?Q?8VHJsmU5FXySlMhxwGJdiwGE9pfrISQAt8DvpTYhiRsGAI1cl1BwljOE5800?=
 =?us-ascii?Q?FnXL6fQqP+LhpHnSOT1pu6ALixxIof06Xnq2kjaS3Df8Px1hbL2DqA7Ij6E0?=
 =?us-ascii?Q?JSSLe4XnALYkgIO0NrsvXqXGGOknlyZ53TXrH5y0ImMFYkamT2xMpxH7kXWX?=
 =?us-ascii?Q?oqPJbW2mbTB2ZGyt+VnETtn+IBjn21Iwj8ZzFPtyUqlbwXXwzIn3arXNdI/P?=
 =?us-ascii?Q?TNw9Uncxgd7E1MUT+Ienni7GJ4ygQlHyog10BKiCrthglzOv62YmmzngKvus?=
 =?us-ascii?Q?Xd9ovG7HUh3Ug7plW+OQ7berZ46gepd53Yusm1PQgv7f0lhFhDrswmf/gN8C?=
 =?us-ascii?Q?o5BNavCut68J68DSj8htfEVHIhD8GKtTzn32eFTwxdilPcHwGFsBT45Ibwq+?=
 =?us-ascii?Q?SztWCh4Vw0JnNABoBYRzcnvILMC+f5D1yEvgORz1/lREFr4ErVLkaT5TXsyw?=
 =?us-ascii?Q?9SC1UVu3EPKJlRfjaNkii+IBfGygAJwo5AieCgaZc97eWXYv4eDjk1TBowOS?=
 =?us-ascii?Q?Wu/15iLhMrDIl+YDCw702dtwMgrJ/krysXW4oPx5?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a9f7ca-4ce2-4307-21c8-08dc4d84e20b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5167.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:07:10.5572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rj//aKhR8eXm5hRTze5tuGEOz5GPVxO8rLdGvx/sbxgY54z0eTs7MVtwx39APq1MOSFI0/EEJSY91hapmZ/6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6498
X-BESS-ID: 1711451232-110352-12637-915-1
X-BESS-VER: 2019.1_20240320.1941
X-BESS-Apparent-Source-IP: 104.47.58.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoaGRgZAVgZQMDXNxCzZzMDSwi
 QtySjRyCjFLNUwOcU0MdHQ1DjRwMRSqTYWAEJq/PNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.255133 [from 
 cloudscan17-31.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Tue, 26 Mar 2024 16:49:00 +0100
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

According to the documentation (for example AN13994), for AHAB-enabled
devices the format of the signature block is:

  +--------------+--------------+--------------+-------------+
  | Tag          | Length - msb | Length - lsb | Version     |
  +--------------+--------------+--------------+-------------+
  | SRK Table offset            | Certificate offset         |
  +-----------------------------+----------------------------+
  | Blob offset                 | Signature offset           |
  +-----------------------------+----------------------------+

Signed-off-by: Javier Viguera <javier.viguera@digi.com>
---
 include/imx_container.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/imx_container.h b/include/imx_container.h
index 54cd684e35d5..691c764b3e5b 100644
--- a/include/imx_container.h
+++ b/include/imx_container.h
@@ -50,10 +50,10 @@ struct signature_block_hdr {
 	u8 length_lsb;
 	u8 length_msb;
 	u8 tag;
-	u16 srk_table_offset;
 	u16 cert_offset;
-	u16 blob_offset;
+	u16 srk_table_offset;
 	u16 signature_offset;
+	u16 blob_offset;
 	u32 reserved;
 } __packed;
 
