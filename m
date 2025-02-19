Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB6CC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 13:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796D780F6C;
	Wed, 19 Feb 2025 14:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="B4/XFDHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F89680C98; Wed, 19 Feb 2025 08:19:25 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c102::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A3CD801DE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 08:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKoDMR9bV+SXZzQKOkYrZGOhoCrfJIFN1Tzuvz1fIBnugLlz8QqLrP4EZ/bBkfcVvuCc4KGWq7AVlWGQM/ohmp2+ip6eoLx5fSWjX9mlxB0i+Mhnh42+ROyTN2aIo0AUfts0hYwToKNOtQ8Knyz+6hC6GCqeZMKLyl7uoubIbXlL3x0ij20f9kyZHMFNzLNP4afOs/Ryc7kRVlobU5nodDhFtxrIUF4EFt/wIaYl+yuFF3QpchiQXLcaY2rV+W2lsJU5j+ev4HktaHTrYzN5xWp3grbXM7cOqD62OzjWWEeS3u+XRn5Tyr2VLJZoVMBFlox2rCQzbbT8pB7TKs0u3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZCNTGS0BkRJPL13NNTk+DEZ9W5uLFxi4WQ3+L6wiY8=;
 b=kXnzG+v+sL6IFowK20GKuzuSZjL00RDlZo5Cco8fFf+hYk8/1dUGwuRc8509SdK1Hbv0viZJDGu3x1ZS+GTWJAUvRl+RX0iEZa5U32lsiXDxkx7v3EKgGPbnEJ5pCs9bfCDFs24gXr/uxXd+CPxykipyFHVbu0LYzIrVqPPlx7dUpidu0/0iVrbifYO4iJdV/r3LG86bSLTin849l/WeZ0gGZs5r4PC78qmIdwboxmh0CIPKllAJ9GvPaY4SlkqLWC/I6yV9A76eHLFibEWIHY1/tKXkyxtkb5Q4bNsulwuz2rPgonvFZDVS7G9naKHhUrwpLA0GUX2iqYAJlfeWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZCNTGS0BkRJPL13NNTk+DEZ9W5uLFxi4WQ3+L6wiY8=;
 b=B4/XFDHSzxfXyTduBsUInWwdkI58TmHipDn6jbQaqNvo0qyxeL+bGJgD5LDmgnIOGYv3uF3s/V4Lb6S428P5E6M3yvWVEoMx3rTf9P2gqAH4vpUQpI7/65zrIwtpKZwIftc36cABdwUGpOqXq+T/NeV5CLL/yeJRW9/3SUwenVsLQseZknnxzBzN8Bn2qqzGvH+Sjav4MAK5VByrzTTeukvy2JR68kCU6MZSrf2iP0dL/qMt99Pcl2BM1CG0zECTUGKQaZfc7SF66CUioK/9tsq5NzpvVgRlCV13hnLvcfw0+gozOLM/383Sux5/ZIFbvUJp4aRrJp1TMVFhfn3BXQ==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by PH0PR03MB6679.namprd03.prod.outlook.com (2603:10b6:510:be::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 07:19:20 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 07:19:20 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "alif.zakuan.yuslaimi@intel.com" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>, "Hea,
 Kok Kiang" <kok.kiang.hea@altera.com>
Subject: RE: [PATCH v2 06/26] arm: socfpga: agilex5: Add warm reset mask for
 Agilex5
Thread-Topic: [PATCH v2 06/26] arm: socfpga: agilex5: Add warm reset mask for
 Agilex5
Thread-Index: AQHbgeAVf7vrZI+vKEqZYnL5K71AHbNOOWHg
Date: Wed, 19 Feb 2025 07:19:20 +0000
Message-ID: <SN6PR03MB3583409C115C3FADD6C7B940A7C52@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-7-alif.zakuan.yuslaimi@intel.com>
In-Reply-To: <20250218083511.29249-7-alif.zakuan.yuslaimi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|PH0PR03MB6679:EE_
x-ms-office365-filtering-correlation-id: 80cd1bda-e257-48fb-ba7a-08dd50b5ba5a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Xf0v1Kmb5NqOlpfqORmSgquQ8izucqGNRfpIZi2fhl8OwAkZuw631+bWj6KC?=
 =?us-ascii?Q?eTr1OqXy5Yy+xMOvSUGoF6UYDQN1Ehf78zLq4rJaGpa5vc46/qUYXnvPZb8w?=
 =?us-ascii?Q?tYmN1AqeUPnvY2RGVJpS0ZbmqljnAd8VVxUv4ICPecWAfivrrq0A56wb1QMH?=
 =?us-ascii?Q?Fni2h9IiSNNM+O1yMgwFAyD/taPdFqrCOgjz40+5ekfykLiTlHCu8ST6Nlpi?=
 =?us-ascii?Q?QCpn1tRF2d0YIaBvqumJeCyeFMTSO4EjBq8n9ZPMk2Z0AIGdtO9+rHrd9mgT?=
 =?us-ascii?Q?ukMtT1pBS0VcSTbqlbKA/epUje0dWlq35oEAVoeQCvq67OPpLNs8ejzPp39X?=
 =?us-ascii?Q?5+zt5ZEB4yAH3a7p/cz9/TmbrBb6LYdzjNTEKjkK0TRbHIRVRHbHmvKzvASK?=
 =?us-ascii?Q?is4Sx29GCmqHmpjZ79rDan5577eBFo8IWA8+F/aRi0+WwjwRttf/O1Gt+9tk?=
 =?us-ascii?Q?HhtIVGHuIX0n8+2HZ7l2XDhqwVFDxln9P4rnsFAiGwf57yQ5yo7gyr4FF/nd?=
 =?us-ascii?Q?K4HdLqPj2wl4b2BFO0LLk/oKUaYQ1RRy5yfZlnUQr6tqD3fh2S+uewPdGKFv?=
 =?us-ascii?Q?Hx1tJwWaQ3taYiJo1d0jHommNbH7uAGV5Av48+WSEr9DvUTaqFJKNXYBG+MC?=
 =?us-ascii?Q?XmKJtzAefOYIhoUcnVjGIUhPedRdzscmwI9L+I7VVOpz2EjuQ4RRFiqZW1CP?=
 =?us-ascii?Q?yKUQw0uqRgW/MDrKmcHhR9S6nTrRgBS5XYdoIc2ENPq8OPL+6DnhkeORXjnv?=
 =?us-ascii?Q?B3s7tJMSpcJt9QtzRAy6TU5cnopmFEO/wII5NuaQluze0CirQzFPCa/MOkFE?=
 =?us-ascii?Q?vQl+egKEdw+g0qGKILEiSnMGBhALOeGpLDZwbe6reX9EuLbput1yF/xitXpM?=
 =?us-ascii?Q?osmLcBIop5i14PdRujGHdlDJ6Qhgfbf2YUVOC0nu1b2ff6/53U4F/Z0rtg4b?=
 =?us-ascii?Q?ZJxPL08nCJMg38tontQgkPPngdhXRjCvxXbes2+XRLQUdzYZkweWhZYnXDgP?=
 =?us-ascii?Q?FJLua7NaDQXIk64Zml2+cTrz/SRSlPF1TjqSCET/UOKg2GeYEJjZNLRSrzlI?=
 =?us-ascii?Q?ciQWg0KhbNo9dA6oLqCfq8dxQmewYlSUfaqBooH2w3VcG/bBuvlgChDYmZHA?=
 =?us-ascii?Q?tD/iZOYPxYOOjt2JZFZQG0Us368DHxpIQK9NIPtralnnOqaQjLilVL+s6GC8?=
 =?us-ascii?Q?JR6z6ARINfty/dffMdPewC+ZS+wcKvSd47Pm3Wjh+ahAyWTnOYzo+mpPZe54?=
 =?us-ascii?Q?cYbKGDxg5sCFGcnn40u18Kqqe26YmBDw9bP8Or7ISappZO1G2HtsjbVnk8cd?=
 =?us-ascii?Q?mKwCHA9ddSyp0VqdGydPHUX1uVA+ETLz4v41UawYCuTETLIw5TGLA0Nd6Nwf?=
 =?us-ascii?Q?J9M/YA2/revm/n8HOSTaUATAFXYV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x257Lbf0ewnTJgDtFqDZ5G/PxyDhHIUUAE1zzehak4iu7UufLNlfGKNhL8GO?=
 =?us-ascii?Q?9CoKQIELNeb7rIewLlL/wyN7Eo4rDj59pvUfx+YijWi3fCE+Lga1TnuRRvst?=
 =?us-ascii?Q?Acjuto6kjPHhVNznkW+BNLPMAk5hRMEUe/tu3KiI2r+jtrOeb3v6w2bC/CeL?=
 =?us-ascii?Q?aZ4ws7Uxi3FiJE/IIjffn0s3gXYLpkOQ27meqKaSuOgkO0x5bCv8J4HOyU2W?=
 =?us-ascii?Q?g1sx6N3kOIcGKgAN7M1b37HdaORVoUFningm6zIu9EzJlCj2I3cxYRSm+BDf?=
 =?us-ascii?Q?MIL6BvUIZxKoKwkNjlaOkHVjogylXnGQpxqGixXz5DrvPmrGjyPsC0DCgwde?=
 =?us-ascii?Q?58PZP9EaquAFM73aQH5VevrzKKyEmUHijV3RvdW2+RWoCPK56Ve54L0IEc9J?=
 =?us-ascii?Q?vl/OvSCajPwIoDj915n/szOYtogJEej9R19AefKn1h3fVPLYtRb146Ig4bUx?=
 =?us-ascii?Q?kdNphD2v+pd2UKFUpO2PVm7DqogNVsO9D9zltyHbj361yPnCRUYx/PL7VAMa?=
 =?us-ascii?Q?a3+80toV1n0bhuIyHrJmiAAeS6U5Owo7H/E1iipXgNdjw5W/ZryPz4YcOi3n?=
 =?us-ascii?Q?G9xstaHRdRgJ/lAXNV1KKym+ZCFoKOhKsi55Mo5+OA6/3V6widHgV2+u9ed2?=
 =?us-ascii?Q?Xb1laxGj+SqLQe09u9dQCZbVF2l8Gn/O51D7t0kc/cFnoVruhkLDUqnoxc9R?=
 =?us-ascii?Q?l/cM7PqgYO9lpHXA8WMCL1/AGyj5Yx4oN6AeaylygivsISs4tmyyFgU/KQ/h?=
 =?us-ascii?Q?I+WOTBhqIlwxnTPvY7R1pMu4QRHOjFx+HVXcDd0QPMg2EQkezXKKYPUFv560?=
 =?us-ascii?Q?EFCmqTI36OH+rtOCUJK3OL6tzi9i71iEYFiR/jDHIc0wevzg+XUEl41lryrm?=
 =?us-ascii?Q?wvBxu6z5t+D6GXNKcu2npfiMObXlpPMBSC8o8163DJyaregwpmaBLi5dBWY1?=
 =?us-ascii?Q?dNz/Yf4H0QTI46+RU5/RWmQHvBlS/C35mq2/V/52ZM49GY5RFLdH7GrkacWR?=
 =?us-ascii?Q?gNRUrNvK3ioxAEGuzNXmKHXYVnzfR9hdOCMPZrHiN+vhX8xjrxI8fd6oq/cJ?=
 =?us-ascii?Q?u/R51xSudXbYuro/zx7hDm6TJr4G9SHd38RR1zY32p8TY6YTPgjT27h5JHKm?=
 =?us-ascii?Q?jUSrQ+GXVZ4lr/nPEw+C+ZWBzQh30FCJYsbUNpkbWyUyOFKDYspaha9ekK5S?=
 =?us-ascii?Q?Lh2Y1Aafbx/zeF+/JJGflHlt1OJp9q8XDhVzu98FhigzTEwNn0bVS22sGzBH?=
 =?us-ascii?Q?X1mzmv0RQSfNLWG+ACvFEfNMHSPob+PZhCTF6eBjESStC5LALbKIbCCbpDAk?=
 =?us-ascii?Q?Oz02m6GT3Dzg7uefK/S9fadLx6U5OvhvrIal2Z6omm4PxperfhdZcqh1XaY4?=
 =?us-ascii?Q?CasmDvQkV9raflMjO1TQLPO8/DLOINJC3XxgaiStcDmC5CnSKdT6fCqneOT1?=
 =?us-ascii?Q?hrPxwnn4qijcqockZ9F643LUxb6BNSMBSkc/m9x7/4tPzygajASsnFupeJUd?=
 =?us-ascii?Q?zJOLrgAQkxEAiEQ4VwvXouElSmnLahQGESM4ad18OB4folK7PwMHWfY98MSV?=
 =?us-ascii?Q?jfFqDCCrHgKd8OrIZvghnmIL4YezbfH3pJq1FlVT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cd1bda-e257-48fb-ba7a-08dd50b5ba5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 07:19:20.1914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mTu2XKd8Bv9H+nI6jyHZ6pIgdjnqgE15IGk7qenDpF5y/2KjNpEMUC6QJkhfcVXlo9YoovZyxVupvtqmKGEqqWd7xad/tn6zSVos3PSxd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6679
X-Mailman-Approved-At: Wed, 19 Feb 2025 14:04:13 +0100
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



-----Original Message-----
From: alif.zakuan.yuslaimi@intel.com <alif.zakuan.yuslaimi@intel.com>=20
Sent: Tuesday, February 18, 2025 4:35 PM
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@g=
mail.com>; Chee, Tien Fong <tien.fong.chee@altera.com>; Yuslaimi, Alif Zaku=
an <alif.zakuan.yuslaimi@altera.com>; Meng, Tingting <tingting.meng@altera.=
com>; Ng, Boon Khai <boon.khai.ng@altera.com>; Hea, Kok Kiang <kok.kiang.he=
a@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>
Subject: [PATCH v2 06/26] arm: socfpga: agilex5: Add warm reset mask for Ag=
ilex5

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>

There are 5 L4 watchdogs and one SDM triggered warm reset bit in Agilex5 re=
set manager "stat" register where bit 16:20 for L4 watchdogs. Assigning val=
ue 1 to these bits in the register address will initiate SDM to trigger war=
m reset.

Introducing new warm reset mask for Agilex5 to trigger warm reset to all fi=
ve L4 watchdogs.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h b/arc=
h/arm/mach-socfpga/include/mach/reset_manager_soc64.h
index c8bb727aa2b..058fdd6e548 100644
--- a/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/reset_manager_soc64.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  Copyright (C) 2016-2019 Intel Corporation <www.intel.com>
+ *  Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
=20
 #ifndef _RESET_MANAGER_SOC64_H_
@@ -23,14 +24,20 @@ void socfpga_bridges_reset(int enable);
 #define RSTMGR_BRGMODRST_FPGA2SOC_MASK	0x00000004
=20
 /* SDM, Watchdogs and MPU warm reset mask */
-#define RSTMGR_STAT_SDMWARMRST		BIT(1)
+#define RSTMGR_STAT_SDMWARMRST		0x2
 #define RSTMGR_STAT_MPU0RST_BITPOS	8
 #define RSTMGR_STAT_L4WD0RST_BITPOS	16
+#if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
+#define RSTMGR_STAT_L4WD0RST_BIT	0x1F0000
+#define RSTMGR_L4WD_MPU_WARMRESET_MASK	(RSTMGR_STAT_SDMWARMRST | \
+		RSTMGR_STAT_L4WD0RST_BIT)
+#else
 #define RSTMGR_L4WD_MPU_WARMRESET_MASK	(RSTMGR_STAT_SDMWARMRST | \
 		GENMASK(RSTMGR_STAT_MPU0RST_BITPOS + 3, \
 			RSTMGR_STAT_MPU0RST_BITPOS) | \
 		GENMASK(RSTMGR_STAT_L4WD0RST_BITPOS + 3, \
 			RSTMGR_STAT_L4WD0RST_BITPOS))
+#endif
=20
 /*
  * SocFPGA Stratix10 reset IDs, bank mapping is as follows:
--
2.25.1

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
