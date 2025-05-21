Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B2DC2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E940982E0A;
	Wed, 21 May 2025 11:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d+QTPb70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 751FE82D59; Wed, 21 May 2025 11:45:02 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE06282E08
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:44:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XL6A031715
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uD9iR31IZZr
 GHLYP+Qs3NIRjK3jWChDuL/mb/RgrjKc=; b=d+QTPb70SPUpxGIAnEjXuEFH1ww
 7It8N+doCTPcKuYjfnk1Ioqf2quVNgT/PRKB7eabQvBge3oHkoQ3ar4d41a3y42i
 gAvLhnTm9JxqYWcnozvVsaJdg7Bmu5isbjWAd10mWuDzaRKi0FyojQAdu7guIVoP
 UoXlya+BABUpoSZSJdR6kYSPyxTrJS8vUjM/Cv24RX7TixYrAG+N2ATltBWXeLzY
 iJQ8/k2G8fuu55FavRtCsd5Z95ibgqIQf3SMnZ5UXccOiJbwXfTYULOJDPDI+ic+
 sEv96PueUHs728F0EUIUQYWRI6de6czud6q7Bjce2uIx/+sdgSlMO9uqVaw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c20x2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 09:44:58 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b26e4fe0c08so3802960a12.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:44:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747820697; x=1748425497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uD9iR31IZZrGHLYP+Qs3NIRjK3jWChDuL/mb/RgrjKc=;
 b=bzLjxPEwC7Sl2CLrM39uShmJRz5GLUKYF9n6ber0iSveGsh3JgAh/KUlOanP+/cSr9
 bfiV9WqlRzzRIp5p1uNDXXfee4z8/qloYDv3ekjEmczlaPBvZWrh2npQeWC1ua/afsdC
 Rkb1QIEZ51FhU2Yd/wWmfrwkwGYHwyT3wZmSjqx9L9EEHiBFzoE2D+dc2w9et7mao5H/
 xLWTvaipSkm4LetT/zUKDW9PZg/R4SsttARhMc1DmTBHIdrr3UH6VMuhXpqBTyd8slBY
 8tkvro5suenWw0ejXTfqIvCt4fm+iG3Eg56DK++qWxb4492NENENXu/2XwyumIslehO4
 6vtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhwaNKF+jNVb9711fH/4bpbyYH3GlMMKywddetWwhjxYxTWiEsB7YpYhM9nOo7tJ9Zjg2IeCo=@lists.denx.de
X-Gm-Message-State: AOJu0YxKpxRvmXOlE2ToNXRvp8P59gP79U7Mgyl3LdLNUK5f1q7NNq2d
 nMAn4oWEzOat/NLPELSDumE0MmPMWh2TOUc3YpFrVCHOvgcVYaa0Efs17ABJAruwCsNNmzGbu0J
 OGYqM4ZyYKrxC+CrB/cQ2Nm80DvuDCjJ193PXj/jrwzQf0P18+c0ciXa/
X-Gm-Gg: ASbGnctf3UVcgLiylGIrkVuJE5ZOxM+qxOdOJiJAVqYnuO9LEKDts/fk6m4fS3bkVeE
 0nqQfBEXkhGjmM7ah15bA61pL+fhEXw2FLYJrFPkCB0YiE2UNfGPoL6E4qV1nN+Zk9d9w4N31Dt
 +kZepuPKQ6nEXYOm2QtbzzZ+ksqYQf9S6DnUlFR3DYcl/OdGWaEofT0Zvcsyd+gkHz0DJmCWxpR
 hVQ1ABv+SCoM5/zuqtXWdz/l7hb7qu80ud5OPNIjpxSGONPYlvb8r7P+0ECcrAD1YQwLAsBHwVi
 WyDXMd9hUH9AbCQl8H1XcCYCedA7mp//tTeHxPlt+8eMrUEYClIJt9UnvuyRH31RLOnm08dD6kH
 dUtLAViBAOkKqRy76fhiuamzFY7+5ejxyIguhlpVs
X-Received: by 2002:a17:90b:48ce:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-30e7d53fedcmr36533844a91.17.1747820696524; 
 Wed, 21 May 2025 02:44:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7I9FGB9Q3dso0+Yie63+LlMML3cXW2Cq5LorTJf8MNNi1Q5IuwEbQ8jWeKwRoWZ3lAOELeg==
X-Received: by 2002:a17:90b:48ce:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-30e7d53fedcmr36533800a91.17.1747820696023; 
 Wed, 21 May 2025 02:44:56 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f3650000csm3226367a91.37.2025.05.21.02.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 02:44:55 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 1/6] doc: board: qualcomm: document Dragonwing board
 building/flashing
Date: Wed, 21 May 2025 15:14:37 +0530
Message-Id: <20250521094442.3522036-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NiBTYWx0ZWRfXwuq1sYMCEy3f
 2Wk7iBXMsuxb2gw1bekdBkuVtI6RiilcrTZhcuo4eML1pRsegucFzXx9iBvKpPaRscjv5AnpG1q
 33OOQpHrW+aXkwlz+AxZRva/VX6KXP24LOj4K189KP2wc1fA10pTuu6ZCSAExR0jxuudnAjTV2u
 ZsfH6kYgzDFKVCKBNxqLsBa6rmQ8nG+1rvIrKEmJ0YovyB7+3bc7FM8zPbd3qaQdlLa8v9xj3pw
 4cZ9LgAGRYfIqvrDEIjUd/SSHpkm9xOzshhs8bue60lu8DxdT+6e7d4GYX8j4AqF/yRkyZ0JHOv
 qlqwcMSncSSjBC5mvYwLiEhqEf1dyZiGta0eXBLHTC/pcTjv1AzRGn5Eqgm4n/hZ3c0cwTwh/AC
 C5hUs6OJKkHhRHW6HKNuRwhBJ6clRouzPtChFGjzpBbARJXDRRdVkoJac/vCiffB4wKOwutd
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682da09a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=QRC5FBUSQmOKMuYLiD4A:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: P3xm86GNhcreTZ13VF9vg0l89KTd_qYH
X-Proofpoint-GUID: P3xm86GNhcreTZ13VF9vg0l89KTd_qYH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210096
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

Introducing documentation support for Qualcomm Dragonwing series
boards. Documents the build and flashing steps.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v3:
- No changes to this patch in v3

v2:
- This file is newly added in v2 based on suggestion from reviewer
---
 doc/board/qualcomm/dragonwing.rst | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 doc/board/qualcomm/dragonwing.rst

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
new file mode 100644
index 00000000000..18788cd6167
--- /dev/null
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. sectionauthor:: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
+
+Qualcomm DragonWing
+========================================
+
+Qualcomm DragonWing are industrial-grade boards that provides various series
+of processors such as IQ6 (QCS615), IQ8 (QCS8300) and IQ9 (QCS9100).
+These SoCs are used for factory/industry based applications.
+More information can be found on the `Qualcomm's IQ6 product page`_,
+`Qualcomm's IQ8 product page`_ and `Qualcomm's IQ9 product page`_.
+
+.. _Qualcomm's IQ6 product page: https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
+.. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
+.. _Qualcomm's IQ9 product page: https://docs.qualcomm.com/bundle/publicresource/87-83840-1_REV_A_Qualcomm_IQ9_Series_Product_Brief.pdf
+
+Installation
+------------
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300`` or ``QCS9100``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcom_qcs8300_defconfig
+  $ make -j8
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+The firmware expects firmware ELF images to be "signed". The signature
+does not provide any security in this case, but it provides the firmware
+with some required metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+
+Then install the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+on your device.
+
+U-Boot should be running after a reboot (``reset``).
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
-- 
2.34.1

