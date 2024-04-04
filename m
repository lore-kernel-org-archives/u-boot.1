Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253E9CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 23:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8EA87D66;
	Fri,  5 Apr 2024 01:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=digi.com header.i=@digi.com header.b="eGAGtYLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC95888277; Thu,  4 Apr 2024 17:11:28 +0200 (CEST)
Received: from outbound-ip24a.ess.barracuda.com
 (outbound-ip24a.ess.barracuda.com [209.222.82.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55A968826D
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 17:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Javier.Viguera@digi.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by
 mx-outbound47-164.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 04 Apr 2024 15:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTZIOIMjnjM/d4qE6HfJiN6DMq+JSjYctD4DqlQkm29GavUX66/rFXLDXhURKoF2RVO3oLWx3wsvY60LaByN6EFvSXjMBh8XsR3o/0pk+zfafZMh3oqQ5HfiPgdzcRfpReB65pGvVWglGGJCZd9csKPDhSSn1vTd/7q3y3eUzTNmbrz8KbNWad0ktVkyuvlxtEB2cxs/J8i0vlgA8d1V3qKhGezNu8UQ6pgE6H39IzsKd1PmOZRajvZkoCl3DajO06LvKequWpM2z96rx8wGuZ47R0FyHGVeEBJt9CXw7rzWKPcAIXCMoPD29L3G5Gmln5H77wTL4SOkC3d967m4AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcRgNvnX2NuxeF3iPKqc0uJFl8rcVI0GO2Eul885FLk=;
 b=CLjs23Dr5oRiXkO3urWzH/rXEQ3usV/H20BawWPLusJ1T4QrV3al6wPBtG3Pq3UYZAxyR9vTRcrbpMK8jTKYG9FNRAk5Xnf2qxcd9byf2JtntimDOe1PeyKIouTLQPi6ZXbpFgFLsbsRq1YOLUJDXPfQPBRKZr3HvZzg9OoubB0QbdWJpCpdbddRp57eQ/ncTWz+rZ9C8b3QWuNwwYKLBxF/0BVG6TiGoYBZ4bPWcfukCLJSpeckd0ND/RWibR8JnuUlar12sEF0zsaYB6qjoUuSFU+VN17NFydGt9gRGd0p7vezuJQwypwezxVSuoXZb7gF4D1UYD3tRiwlwwft7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcRgNvnX2NuxeF3iPKqc0uJFl8rcVI0GO2Eul885FLk=;
 b=eGAGtYLKirzxX7JkUurnuL33tu4zOJ6YWXM1HqrUw6Lx/nSQGHcGypwzzsz08HBSF3brnTTkoKM+Tsb7EXJq1Ynm8XamaS1xJzTGAzf3GZTvge6+vHVhx+2Bb1T/6V3Nr0CAJRaaQfwUaQDocixZnaUNBWx0NLglnE7mFTy7DCgLxDQcOeuKJ2+zD8oz/7qFQyzD7dbz18Se2DGi/HO3HlqIpXVbBssKMnhaXckdn0k01hcZEdy+Bb5efPx7DWnJhAI+hjDY7q8EOq5QM4nQ0VvJqD/iS7/vi0nXf1gShNRnqNwadxHQCBz0sNVU08P4Vly2HULHqMu4YCiSj4n3mg==
Received: from DS7PR10MB5167.namprd10.prod.outlook.com (2603:10b6:5:38e::9) by
 CH0PR10MB4875.namprd10.prod.outlook.com (2603:10b6:610:de::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 15:11:20 +0000
Received: from DS7PR10MB5167.namprd10.prod.outlook.com
 ([fe80::2991:3274:498f:f9d5]) by DS7PR10MB5167.namprd10.prod.outlook.com
 ([fe80::2991:3274:498f:f9d5%4]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 15:11:20 +0000
From: Javier Viguera <javier.viguera@digi.com>
To: u-boot@lists.denx.de,
	uboot-imx@nxp.com,
	festevam@gmail.com
Cc: javier.viguera@digi.com
Subject: [PATCH v2] arm: imx: fix signature_block_hdr struct fields order
Date: Thu,  4 Apr 2024 17:11:09 +0200
Message-ID: <20240404151110.2890691-1-javier.viguera@digi.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0426.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::9) To DS7PR10MB5167.namprd10.prod.outlook.com
 (2603:10b6:5:38e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5167:EE_|CH0PR10MB4875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OeMIwqN9M9/0PVuLHpWZBDePyKcT19lDt+xuYXp+R9l2fzGY4eymG1SpcpuICv2mCUKMwht+htuQ9GVxKIuW9X2cDFEI/T4n7ZPXSpgGSb7XzT9PFHf0HEG6K40iw+HyRPqqS10bz09on7edUBI4zAz01QAk8UysHBUsm+H1062lKKc3KNNW0Cw3LDUFU06cV2byJukfczeDq8bK/btol5ddLiG52lV4iIXMlAZn5kIwZRNmZqIGnqA5HP3pe9OIEM7NHSIfnClOIKHOzO7mE9qaefunqFTExCXkEvqDoXGEkfQzbewu+ceTIkgd7d/pvw0SLmSyb7C5rvrzTq8SiW6hsD9h1Bg7FxN3Dq8orqTbZTS+7EZowabs3XfIvsC7uhMD9vLNPkADOrzoMP/wy6hdXiiulmB/7Gkwkkrn4s/E+7ngpUgiorQauhLKQkWel9y6v9+3+5Rg4Ua4dUOhxptaQXtKBI06DTYhko+BcXkukNSX7PUA08gZn6mPMot3vmAkPVGCn2soWkVJjFUrVSX2484iL8g0U1TCy2UO3VqigMh5QqsDju52V147SzS9wGkpjAnhVc1F/bb/LSsQuqN3OiFOJN/0zriiRduYwCuSqeIki11tpOgbeaW9lHPqw/mt5A/kx3WdeaQGMWFQ+eyX8lm4ybMYZp0Drpch+LD4a480VlRvnzd54MjqIyHu9o/9jXblahA+w3j5F1TbUGT4EFDv9/xjYfg5a3P++4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5167.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49s8vndvfglRFfjPo9cWKujp48v6HRqDzcX3v67YjTIR505IZN8rQV/s6s3+?=
 =?us-ascii?Q?PwERMxRmJ9nySrNc3UOEzSEV99vbI8ChxbiV+AzA5FoEoQ/cQCovn1mJFbje?=
 =?us-ascii?Q?wBpe3AfJqW1X8qX9XZqvPq+5Jl6oU6qt4OG6yrioLIP84s6bdcM/cG1bs2S+?=
 =?us-ascii?Q?MrVGwB0OBXJtEO9rHNAtnA9s9mxE2NU8bRY5UVPaVNrNAFR0yeUt3Sz0rUCF?=
 =?us-ascii?Q?IU54X2xPIi1DRuqK/eT+NQM/USMKMTn9/NG7Z9pa7T9ulpi/S6ZOFKqI71Bb?=
 =?us-ascii?Q?ZbBXQdK9JF780LYdkVvv4hV2RDLzN8izlrvBJ0UghpZTYLWF5t2KYwavRhps?=
 =?us-ascii?Q?6DA1tVRgTdqSg3Ip8exnPs1KDNgbj0UZ7c4ndSs0SZ1weiabUNABSJ3abO7v?=
 =?us-ascii?Q?dynaDpkcCwRzG1EDsbXoxi8sjx/pQiBdTDLjF8yUWffGtrTyJyemHosN9zbn?=
 =?us-ascii?Q?71NhqaDXWzh7lx12O8ks8Ysh2FnCYxpyY6piOGrERAqVVzxN5h+cxs0YDgkw?=
 =?us-ascii?Q?WlPWbmSFv8HTOAAo0krjXQdxKIBkJj185h2aP8w1qQWoUEsTI1EF1OgFyiKP?=
 =?us-ascii?Q?RMQd3XMG8UV3u49oZxNWKHB1LXlMsk2ZqhooSZVvX93SGMeYx+qeEop9Q52N?=
 =?us-ascii?Q?8kTUzBDVRdmiToJkSKM1NUvORM8e6PDSMh1z2IlnGuEUL86VmXNHWHJhpT9f?=
 =?us-ascii?Q?IKct51G+AJspACIrttiPs0/+aTSa9ksF25bbYSxBMlaXR8pDoaRimwaAUdQs?=
 =?us-ascii?Q?lKqE399SkgZQe0rugGiJkDoj6MVLyisYhLbl1cNjYf5BpM/Dbn1ZlPNo83dV?=
 =?us-ascii?Q?nS9GjzciaFflXZ50SEjYB2EvB1sq0phB+77klA+7oe84ZieyiE2Y34WzQLHd?=
 =?us-ascii?Q?L/+56k41KrMolg8lThuDLLhJx+kjXkDusv+dzPGzUB2kklPVBhCVJoxaEH4b?=
 =?us-ascii?Q?6bUY9F1wXuQyZttCCJnQRi6xDlF8PIgTeMy0BHRJD6+YFvMDFUM0LcVdOIp0?=
 =?us-ascii?Q?yq+yQSxM7hZbWBP98TQmL4YnMt01f73SCDAKGibn6FAZhMKoFJOycTjeVq4M?=
 =?us-ascii?Q?txYuQ8aMeyij+3CsFf3tL10dws8lBuyp8v7HhsF/PpdFT0xA/e+PSsIL8zwq?=
 =?us-ascii?Q?wpx7GAMP0ewb1jKjj2sq6zppZDfopYRvqMauuoFdPupyrSC/DaFn7AaV1p/C?=
 =?us-ascii?Q?XgAzzym7xTgLIZZWwWPfnXHR1BmEwzkRP7l4fmI+LwJREPcQnqSh0YinM5SL?=
 =?us-ascii?Q?bpTBaC/fHol4cXo/rx7yX3QDP+Wo/uiUD0AJjvK6OwWKmiRKHBdKufot1gjr?=
 =?us-ascii?Q?MomaBkJuoe2Fsr+LzTGgOIFZBYx7fP7Fqi1a7yFtSWC0XDCIg0n4UD8c+2Do?=
 =?us-ascii?Q?eHnul/YpNVJOz0VapoeXKsr+aClqOw7D+g8tontLU4jCnRBnfoele7BZRnVe?=
 =?us-ascii?Q?FfZNv4X8idMjly6qm8+6dT6y1IvtRGAbDC2+Q4Oapxuoa0yCpnG4bdYsKu8t?=
 =?us-ascii?Q?Fk3j3IOSWulu0AdcWhEm/Z4efEdDmVB3Uf7hvb1wVReSbSGlyOw7EBJKOT8C?=
 =?us-ascii?Q?A2uWBQ+oXVCSocxHn3AwkzY4ZoqJTcd4vREAoL74?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac2f9bf-22bb-414f-a086-08dc54b97bb2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5167.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:11:20.4376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61Uw70LVC8jjhJZcEq2m2mgBhtw9MaaUS/iDzEADHeNXXiRWqcZd1iqnPb9gJS2N0Wall7me2FoCRpuGxeiJdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4875
X-BESS-ID: 1712243481-112196-11141-4444-1
X-BESS-VER: 2019.1_20240403.2023
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmZmZAVgZQMNnCMMUoOcUyxd
 LUNCXJLNUg1cwoxSgpyczEzMI4OdVCqTYWAJKl+qRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.255334 [from 
 cloudscan20-202.us-east-2b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Mailman-Approved-At: Fri, 05 Apr 2024 01:55:23 +0200
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

According to the documentation (for example NXP's AN13994 on encrypted
boot on AHAB-enabled devices), the format of the signature block is:

  +--------------+--------------+--------------+-------------+
  | Tag          | Length - msb | Length - lsb | Version     |
  +--------------+--------------+--------------+-------------+
  | SRK Table offset            | Certificate offset         |
  +-----------------------------+----------------------------+
  | Blob offset                 | Signature offset           |
  +-----------------------------+----------------------------+

There is no runtime error in the current u-boot code. The only user of
struct signature_block_hdr is the "get_container_size" function in the
"arch/arm/mach-imx/image-container.c" file, and it's only using the very
first fields of the struct (which are in the correct position) and thus
there is no runtime failure.

On the other hand, extending the code to get the data encryption key
blob offset on the signature header gives a wrong value as the field is
in the wrong order.

Signed-off-by: Javier Viguera <javier.viguera@digi.com>
---

Notes:
    v2:
      - Improve commit log

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
 
