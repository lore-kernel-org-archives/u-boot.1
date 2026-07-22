Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F153C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEA196077C;
	Wed, 22 Jul 2026 06:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P2ZmK1I5NHve; Wed, 22 Jul 2026 06:08:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E8D5A6071B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700510;
	bh=w4fnfbWBW+QkbHDrDAdWA22Wf+1D0UHwC4elfJqK7bU=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=kawVEkbFfIK+yUyQikLSjQKdYvUdX+W6yXdJe6l713z/yuPDTrJdnU2RoFusRd2D9
	 nBKyb3pqT7r0KLR+GwcHNiXMgTkwYaPVch0qANG2tcD2WtKho4K5dqclzF4Qx1lpLv
	 yITTFpN2RvaDpT31HeJuC2YsBZ3ycjwxJxj2g5wAuEhFNQQiZKylHUCGX6z/h4zXXG
	 C8uMfGfq6x1DdLLxk4miXmBjFbFOrnUZ9KneScocLHL0pOK0n4JeJi3CZr2R/3F5Sq
	 rWIgxezkNUzuPL29MDcw45ODIS3RNzDs9Z3FMPqUu2w6qeJSLL5l3gof1WAMr6Tqe8
	 g82hGermoAzaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8D5A6071B;
	Wed, 22 Jul 2026 06:08:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 63AF5DF0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4747980DC1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PhslsepFG0Du for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:08:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 023B980DAB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 023B980DAB
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 023B980DAB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:08:26 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A6D48495B; Wed, 22 Jul 2026 08:08:25 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA94A803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:08:22 +0200 (CEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53iYU4168890
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:20 GMT
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3mk7b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:08:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90284139cceso98122746d6.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700499; x=1785305299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w4fnfbWBW+QkbHDrDAdWA22Wf+1D0UHwC4elfJqK7bU=;
 b=e+fKiRGFH9o40r61/ht1zZcDPW1TeeJsIjFAEXnM6kPvs0y44b+egF59NNSwNXUGPb
 Vbp8tsw3mGKw3xgL5xwwrhHwX8AZBBZ5lmLPSSpMruR643ITa0nvQbziodJnonJqA6IU
 Z5ooKTmjo1RzXVJmwhZp+ECTCkZmGrhGL3pMq5gNYvywoC1SgCAr91GqXZ4yIV6A/C9q
 QUIn/KNhQsLs1GCJ18MHmOcwkrXqVeEi8/+pitUVOvEl6RkmFteXAy9aJiDwuFtRr5HU
 s9AsJ7h+NETBd0s8FiR8ES3fbAzo1NR0Bv5nSe56x3JNOc3x75Rk4bvk6+o9hVqYx6nE
 NKIg==
X-Gm-Message-State: AOJu0YwqEtDcNMTQeoipgWeQrZM7XyQQAWURhq70yZFpftAPHKH2Z4if
 9oW0oWzUoKEbU6kRNl4lNX7EyNOo1NuuA0TQIx0CBhRMyYDDJ1ZJcK3hCm5wBCoskCfW21FyRt/
 8/Nx6U53V1Mif9Uk3S3Kc8+BFlNi+3BjQMzVaVkWquydthLbHA5T714Eu
X-Gm-Gg: AR+sD11nWPChiFWbN81Xpr9bC1oUNTk5t/d1LZGbL4bZo5UeFczWVrneVnX05ixHdme
 AaXdNfernQrug3AMaCBPM/kdUzx+MOwz5T47oqKM4Wdu1BXbvQhwLpwB5nXrh7gTyfyRz4iSf+6
 p9mbTyh/tVOrEjp1356qp3RqGAy/E/Rvy68joeBwa3quHhTdGIhQV69yA49tnDPDYxDtk8GeEFK
 k2q8qWHqGiFFtGGAUV6KCWeTcrXfEyxsUnhhuVC8R+T0f/wTNKCsQiftJ2b7IybB9i18JzfhBJ4
 SmqwlSmBU9qtGzsUxLVdyILHVhvxgdH9jFqwaxtLcEOkaUuJjbwjelJJHmgRL/skLzyAeg0jAtk
 GbmJ29fbh1HDfYwh+kMK9X6XlGOGlPrEWZLBzA3/RofR4rfmcKVE=
X-Received: by 2002:ac8:588b:0:b0:51c:753:4679 with SMTP id
 d75a77b69052e-527a8471b9emr32371671cf.28.1784700499056; 
 Tue, 21 Jul 2026 23:08:19 -0700 (PDT)
X-Received: by 2002:ac8:588b:0:b0:51c:753:4679 with SMTP id
 d75a77b69052e-527a8471b9emr32371341cf.28.1784700498432; 
 Tue, 21 Jul 2026 23:08:18 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm110860865e9.5.2026.07.21.23.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:08:17 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/5] ufs: derive the per-region RPMB CID and size for OP-TEE
Date: Wed, 22 Jul 2026 08:07:45 +0200
Message-ID: <20260722060805.1428110-4-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX+hBh1MOyUdLo
 GTWkRIGrt1n890Xz2XqXFo7ENEqkuUTQMeflGiToLIcEZ83K26V34Kw/rk1LgI2OLaG0dg7zaZf
 R2ZY8SBVSg2WotNvWdRuHR94I02AnFfe7fjqtcI1bHfhOcahTwKLbd7xnsG3KqhjFf3DdsNv70g
 PewoKfVonCS+CNVXdXGv3KHC5POi1K4geuPYrDABd5hOApnqKLgdmz9apAFNoz7I0FOfFKAD0uG
 0nplUnw/2seYiXvA8XM9nGxCbWlu3ohWs1P75zIae1AJixC+1UUdtiBp8jN2VbIoPeg97EmdwE5
 8xtEJOw/lU/6fZNBNWXlxJLTd+XQfKDgSFX7oBLMoi8YNbJYndQfJDvDtMDc+XAjyefkAsMGD51
 rOBXUJF2qxKYOjKNerOAWivmLS1y7H3nC1Tk6DBSM84eKzsdHjqZwQBwMrM27uaiJGNTn16OjlL
 +N1/IwPd3GxctfVrfCA==
X-Proofpoint-ORIG-GUID: TCEpa-ZybBljNkJMsKEFn1_kUB7hykNF
X-Proofpoint-GUID: TCEpa-ZybBljNkJMsKEFn1_kUB7hykNF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfXyfmHJXUU3CGD
 7ey1laeOPVdtXEQ4hXZF66vZHVrtnD6iAkWqsGr0TaAjYp72xpkrMaZHCW0d5ubIfNw4wTpFD0G
 KDV/x9aX+QLGEm4kHgYD4uWXZBnoLm4=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a605e54 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=WXW4Q8A3AKROXBPzGUIA:9 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=w4fnfbWBW+Q
 kbHDrDAdWA22Wf+1D0UHwC4elfJqK7bU=; b=UtFClmM52kr3oSnTEEmzo7vR5hF
 fVCTQgGxHeX0Box7gpjcirWN8u9hHk9gcI281+AtERCyzkwtFfkYCfouVWQHbKfe
 2rQomjWYNEw/F53hNbhQzln+qPenXmfjLrQgHd82cC42zyTcTVKnlV+hmNbvE3Do
 P3ivxsVyAFs5dd2gXn417wFHI3gig8KxX0JEzaTSjQEiWodSApfTOBiNTLCnlezc
 oTGvJczof6wAkUOn5o485nl0MEAsl1w5i0jwiLpJ/yVm3JXvfBo5/9A0SAbEK8Ch
 gKWTwmCKam3v+vB/SpsKvcjQVRDbK+fvRRYEsIW2EmJmU2TPmABXmMS/f7A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700499; x=1785305299; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w4fnfbWBW+QkbHDrDAdWA22Wf+1D0UHwC4elfJqK7bU=;
 b=giCvqJF8gQDAkQI5BoWdjrpTOxBShfNFJjGPa5wjnVjCS3dMBNKCXsmXKHYy5gl/ev
 smQil5x2yB++/hKyJI2zByYHxZWPMO074091//9f5ry4PYw8nwncIPgHuJaqoeRmyEy1
 zaR+1lZdCzucphP7DXDcKfOfh0oz6oLkxBUxgZKUd2eo8G13RCteWwAayL8Y3Bkr4rLu
 9P2Tt45QPUmu4Z350aDJ4Ot5TEMs9SKajIsIP2vR2QPeWaQv0HcPdqP3R714chhBR3KT
 y/QzwG7oh2uRSwJQbrRyLUeQPty/YqRAjh1I1IfQHcQ/94t9LSahIhTzz5bklD1xwtPe
 h4fQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UtFClmM5; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=giCvqJF8
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UtFClmM5";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="giCvqJF8"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Read the UFS device, unit and geometry descriptors to report each RPMB
region's size and reliable-write count, and build a 16-byte CID by
BLAKE2b-hashing the same device-id string the Linux kernel derives
(ufshcd_create_device_id() plus a "-R<region>" suffix), so OP-TEE derives
an RPMB key that matches Linux. Exposed via ufs_rpmb_get_region_info().

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-rpmb.c   | 141 +++++++++++++++++++++++++++++++++++++++
 drivers/ufs/ufs-uclass.c |   4 +-
 drivers/ufs/ufs.h        |   2 +
 include/ufs.h            |   6 ++
 4 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
index 5417a4ec0bc..49ecb38816b 100644
--- a/drivers/ufs/ufs-rpmb.c
+++ b/drivers/ufs/ufs-rpmb.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <dm.h>
+#include <hexdump.h>
 #include <log.h>
 #include <malloc.h>
 #include <scsi.h>
 #include <ufs.h>
+#include <vsprintf.h>
+#include <u-boot/blake2.h>
 #include <asm/cache.h>
+#include <asm/unaligned.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include "ufs.h"
@@ -25,6 +29,15 @@
 
 #define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
 
+#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
+#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
+#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
+#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
+#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
+#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
+#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
+#define UFS_RPMB_REGION_UNIT_SHIFT		17
+
 static u16 rpmb_frame_request(const void *frame)
 {
 	const u8 *p = frame;
@@ -166,3 +179,131 @@ int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
 	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
 	return 0;
 }
+
+static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
+				      u8 sizes[UFS_RPMB_NUM_REGIONS])
+{
+	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
+	int ret;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT,
+				     UFS_UPIU_RPMB_WLUN, 0, unit, sizeof(unit));
+	if (ret)
+		return ret;
+
+	memset(sizes, 0, UFS_RPMB_NUM_REGIONS);
+
+	if (spec_ver > UFS_RPMB_LEGACY_SPEC_VER) {
+		sizes[0] = unit[RPMB_UNIT_DESC_REGION0_SIZE];
+		sizes[1] = unit[RPMB_UNIT_DESC_REGION1_SIZE];
+		sizes[2] = unit[RPMB_UNIT_DESC_REGION2_SIZE];
+		sizes[3] = unit[RPMB_UNIT_DESC_REGION3_SIZE];
+	} else {
+		u64 region = (get_unaligned_be64(unit +
+					RPMB_UNIT_DESC_LOGICAL_BLK_COUNT)
+			      << unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE])
+			     >> UFS_RPMB_REGION_UNIT_SHIFT;
+
+		sizes[0] = region > 0xff ? 0xff : region;
+	}
+
+	return 0;
+}
+
+static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
+{
+	int nchars = ((int)raw[QUERY_DESC_LENGTH_OFFSET] - QUERY_DESC_HDR_SIZE);
+	int i, n = 0;
+
+	nchars = nchars > 0 ? nchars / 2 : 0;
+	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
+		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
+
+		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
+	}
+	out[n] = '\0';
+}
+
+static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
+			      unsigned int region, u8 *cid)
+{
+	u8 raw[QUERY_DESC_MAX_SIZE];
+	char model[MAX_MODEL_LEN * 8];
+	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
+	char idstr[QUERY_DESC_MAX_SIZE * 3];
+	u8 serial[QUERY_DESC_MAX_SIZE] = { };
+	u16 manf_id, spec_ver, dev_ver, manf_date;
+	u8 blen;
+	int ret;
+
+	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
+	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
+				     dev_desc[DEVICE_DESC_PARAM_SN], 0,
+				     raw, sizeof(raw));
+	if (ret)
+		return ret;
+	blen = raw[QUERY_DESC_LENGTH_OFFSET];
+	if (blen < QUERY_DESC_HDR_SIZE)
+		return -EINVAL;
+	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
+	bin2hex(serial_hex, serial, blen);
+	serial_hex[blen * 2] = '\0';
+
+	snprintf(idstr, sizeof(idstr), "%04X-%04X-%s-%s-%04X-%04X-R%u",
+		 manf_id, spec_ver, model, serial_hex, dev_ver, manf_date,
+		 region);
+
+	if (blake2b(cid, UFS_RPMB_CID_SIZE, idstr, strlen(idstr), NULL, 0))
+		return -EIO;
+
+	return 0;
+}
+
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid)
+{
+	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
+	u8 dev_desc[QUERY_DESC_DEVICE_DEF_SIZE] = { };
+	u8 sizes[UFS_RPMB_NUM_REGIONS];
+	u16 spec_ver;
+	int ret;
+
+	if (region >= UFS_RPMB_NUM_REGIONS)
+		return 0;
+
+	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_DEVICE, 0, 0,
+				     dev_desc, sizeof(dev_desc));
+	if (ret)
+		return ret;
+	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
+
+	ret = ufs_rpmb_read_region_sizes(hba, spec_ver, sizes);
+	if (ret)
+		return ret;
+	if (!sizes[region])
+		return 0;
+
+	ret = ufs_rpmb_read_geometry(scsi_dev, rel_wr);
+	if (ret)
+		return ret;
+	if (!*rel_wr)
+		*rel_wr = 1;
+
+	ret = ufs_rpmb_build_cid(hba, dev_desc, region, cid);
+	if (ret)
+		return ret;
+
+	*size_mult = sizes[region];
+	return 1;
+}
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index e320a6dcfbc..3a0bcd287ea 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1801,8 +1801,8 @@ out:
 	return err;
 }
 
-static int ufs_get_device_desc(struct ufs_hba *hba,
-			       struct ufs_dev_desc *dev_desc)
+int ufs_get_device_desc(struct ufs_hba *hba,
+			struct ufs_dev_desc *dev_desc)
 {
 	int err;
 	size_t buff_len;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 9f55735602b..5dae8dbef72 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -816,4 +816,6 @@ int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
 			   int desc_index, u8 param_offset, u8 *param_read_buf,
 			   u8 param_size);
 
+int ufs_get_device_desc(struct ufs_hba *hba, struct ufs_dev_desc *dev_desc);
+
 #endif
diff --git a/include/ufs.h b/include/ufs.h
index f2e46bc5fbf..8cdd4724d66 100644
--- a/include/ufs.h
+++ b/include/ufs.h
@@ -20,10 +20,16 @@ int ufs_probe(void);
  */
 int ufs_probe_dev(int index);
 
+#define UFS_RPMB_CID_SIZE	16
+#define UFS_RPMB_NUM_REGIONS	4
+
 int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
 			  void *req, unsigned long reqlen, void *rsp,
 			  unsigned long rsplen);
 
+int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
+			     u8 *size_mult, u8 *rel_wr, u8 *cid);
+
 int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size);
 
 #endif
-- 
2.54.0

