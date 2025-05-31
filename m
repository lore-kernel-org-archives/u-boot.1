Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1783CC5B549
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 03:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E451282B8E;
	Sat, 31 May 2025 05:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3QBQ16V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 321BC82B6B; Sat, 31 May 2025 05:20:26 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7931582B8E
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 05:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54V28pLP008617
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5qM3SrV0ZSG
 tcu0nZsg1WRxS92oN97v6D/cAbUd35Tg=; b=J3QBQ16VkGvJZqzRYdTWZ3uDnLF
 kg1cL3bHeAfY1SFj2g6CilYuE/aP9UKynzTZ4AG60AwLSZYYFv0khQkQKerQC3b7
 VhXK5+x0Lr0KEMMLv6K9r2u2zDJJf14CFfJnD4J/duDYPcJmBp2ZF43Vf4K369Gk
 WkJHbGFdR5j4tkB8unmj+Gj1VC5FwjiEEQD4OPufYi9pKh7FXeW1UGDWhXrg5Ktf
 mTfrqefhGLKz+9M7k43RbdbYZab03CdHgZmwPfhD35l1OoT8xio0MPtzsT5diVsr
 SXIZYm275dq9KjoN7Ei9vYYanr5bVxyl4BFCfN+mpLEcyrpBGTxy7KgbDkw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46yrqv02r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 03:20:21 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-23425b537aeso20504145ad.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748661621; x=1749266421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qM3SrV0ZSGtcu0nZsg1WRxS92oN97v6D/cAbUd35Tg=;
 b=ehzyxCBnQNg298A4BW2nDGuWbL/RXGKKvch8st0QPxyBx2BKsHiPNGu/SIndP22AWj
 Us18CCbndSVwWYQQRnk0advJBhWBBwm5+gn/1o5i8qI77Q2UhEKrQk+Hqnow4Qdhz9e9
 ZeakHqBYm63KFaNHhrzsBdg7SVLIM1fLl6lkbDOy/rwswM6UQ8mBV8DFTT1JzvsPW5R2
 wQMiJar7F8KGhC/+gWT2b54gp5VX0BjsM0Y+oRm83kjRA2DMNk6Z7X4iXfp4tOcZwOQU
 v6XBmqDzxo6oc9eUb1jSXWfMMQHEuRqj5SHbWvxc1mZWOsKbiljm6B9oNLt4j5vEBZAU
 sNZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB19XGcCSX/3LAGMgU6BBFac8B2Zli6v+2+nPchbBV9cI0dLUZu9JR1r67tGSWHdAwOuQLyqo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0H+aYNdclxa+GhXtV6mBroDOEBdbKbJoQapERbOu1QTr+FpQt
 LWyty5ja7NkoRJX/Wg5upAbzkqY4qS10We/BYie4/YSBF7CIquCJ+9AobXI5npX3S7bXfgYCL3s
 MxtzxAZc6sMScTCZsPig2CBmq57S5tAOJUzbAt/PQUYuSUFzpjzStVJBg
X-Gm-Gg: ASbGnctiyelrk7hXcjnWa3A3WE52NSx7YUb64yjcxENUKswjDgaEtfSfWfneWHNOqki
 +W+2OeLnbUjVVv65OOg5Cfo6rw4XVXVIovTREBFqV8t4V80/OfXGNny5eNQio+Fc9gK79so93Mr
 rpZbQW5FcuVOM+R4fY7iM39ylHRvzUe9PEOTxNka4OsUwXO0NrHiwWtMbIm7JmFwOSiFTOq0Lt4
 dac62Z7NU8XclVTguiPmEUVX1ZZ01xj2tyQtQYK1n+q+C6HNZ1HeI+c0p6ZHY4vwhdKMOgAxAFg
 lnqEo3NWI0BHxlUvyHRaD7GVh8qG6O9K7q6p1dP3+xEr/Xdd7+b3RrW+AaPzn1EBOuHO/jLAL8O
 fIRZBRaLpOvYPstRB0sWqGEsnkkjkuj0CYPF0th5F
X-Received: by 2002:a17:903:2f92:b0:224:2207:5130 with SMTP id
 d9443c01a7336-2355f77df51mr8887915ad.45.1748661620610; 
 Fri, 30 May 2025 20:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW7LNNQb3QzXRNHs+zMtBVhC/sc+HhjFeQ2eVi1KVIUexKaiPbJHGvSjcaUwXz2tMAcyeKmQ==
X-Received: by 2002:a17:903:2f92:b0:224:2207:5130 with SMTP id
 d9443c01a7336-2355f77df51mr8887595ad.45.1748661620210; 
 Fri, 30 May 2025 20:20:20 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2ecebb49d4sm1856794a12.64.2025.05.30.20.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 20:20:19 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, sjg@chromium.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5] doc: board: qualcomm: document Dragonwing IQ8 board
 building/flashing
Date: Sat, 31 May 2025 08:50:03 +0530
Message-Id: <20250531032008.3083716-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250531032008.3083716-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sOlQ4cLwBdZ0ute_YV2f6Dp5Q4lXnV3B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMxMDAyNiBTYWx0ZWRfX5k5praUHplmY
 8KNcWzeA0caGEceuRL+eV16pfhLVpMcIzKp3w7DXoplsPJp7RyIVe8ziUJ3D5Pi+nQ7r6sJQ0vJ
 BWCqmItdaxd8stN/KBGfoGC0Ig0FOWiUg+Wcp7cQ9g8YcRX1JaJgf0DKU8anzEolmEnmag4emHU
 ZC/EgrQUnwAyUYPL+d8j1Yp2zg/BFS9m9LkbfBdd/G/gtyCopKtKRyYFIdZy7PjtM4upPPuuSG1
 k+OXnLBOtEEUtTwNdY+TEosrtChK5QleTSrhAgI1Vguuya6ddbwT+VRTmdoDSwqkYDp0eQBXV5Q
 oHVQ+NWfC9tO3v8YtvMEMuuYMCHyKID94NZ/Ao+nDwilhqcPtPR1amm14Z/vNRyAW1hkBEiiiyr
 kutP+dyt3lqDpzZ09ntIBleR+rvZKu0KgOJO1/nuK5IZciqFU3fmXgKhqdL24YBjl/yN4lLs
X-Authority-Analysis: v=2.4 cv=KrhN2XWN c=1 sm=1 tr=0 ts=683a7575 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=Im0U9KuXw_dDsnnlwXAA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: sOlQ4cLwBdZ0ute_YV2f6Dp5Q4lXnV3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-31_02,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505310026
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

Introducing documentation support for Qualcomm Dragonwing IQ8 QCS8300
board. Documents the build and flashing steps.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v5:
- Renamed doc/board/qualcomm/dragonwing.rst to 
  doc/board/qualcomm/iq8.rst

v4:
- Updated the flashing steps in the documentation

v3:
- No changes to this patch in v3

v2:
- This file is newly added in v2 based on suggestion from reviewer
---
 doc/board/qualcomm/iq8.rst | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 doc/board/qualcomm/iq8.rst

diff --git a/doc/board/qualcomm/iq8.rst b/doc/board/qualcomm/iq8.rst
new file mode 100644
index 00000000000..3e875c33622
--- /dev/null
+++ b/doc/board/qualcomm/iq8.rst
@@ -0,0 +1,44 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. sectionauthor:: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
+
+Qualcomm DragonWing IQ8
+========================================
+
+The Dragonwing IQ8 Series (which includes QCS8300) powers computeheavy and AI-based devices, and is designed
+to operate in an expanded temperature range with available built-in safety features.
+Dragonwing IQ8 Series delivers industrial-grade AI performance of up to 40 TOPS, an octa-core
+Qualcomm Kryo Gen 6 CPU, a powerful Qualcomm Adreno 623 GPU, support for
+up to 12 concurrent cameras, and 4K video encode and decode alongside multiple displays.
+
+More information can be found on the `Qualcomm's IQ8 product page`_.
+
+.. _Qualcomm's IQ8 product page: https://docs.qualcomm.com/bundle/publicresource/87-83839-1_REV_A_Qualcomm_IQ8_Series_Product_Brief________.pdf
+
+Installation
+------------
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS8300``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make qcom_qcs8300_defconfig
+  $ make -j8 u-boot.mbn
+
+This will build the signed ``u-boot.mbn`` in the configured output directory.
+The firmware expects firmware ELF images to be "signed". The signature
+does not provide any security in this case, but it provides the firmware
+with some required metadata. More information
+about image signing can be found in :doc:`signing`.
+
+Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
+on your device with ``fastboot flash uefi_a u-boot.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+Note that fastboot is not yet supported in U-Boot on Dragonwing IQ8, as a result, to flash
+back the original firmware, or new versoins of the U-Boot, EDL mode must be used.
+
+A tool like bkerler's `edl`_ can be used for flashing.
+
+$ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
-- 
2.34.1

