Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E32C3ABC5
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 04:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8408294C;
	Wed, 14 May 2025 06:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHYW/z2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D44C2829E7; Wed, 14 May 2025 06:42:33 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3F78294C
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 06:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E2ITSH009978
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=g5++ZOB31oD
 ZcHsp5eBwjuiAP0cQOmgQ/g6s3cn/odY=; b=oHYW/z2euzdLJCK9KVyqtyRjeRI
 7zSNBAjHeS0T3kgKK0EnZoJ+Y0mm1XhvAug8pZ1zqRkNM7UVZ1nNJrJGwoXPaQGD
 LAQHzT5ZeQYeID2zWbXxmFcc+tBCFNI4jY1E91kawH0JB/u3rht/+yVwJ8mAb1cB
 d1JTsbf5he3S7gu8kDbWl1NktpAdzPhxmysfFGEwITXvfhVFURAULl0nmKfqsQAS
 ddrqHJqMII7pGjYDSYV+7mCmTJDGDojH/O7RS7VyY1DxUpN1jw1xLhAdcsOkdzBc
 gaEKEb+4fTRoUqn/zhB6xL9+NPC5Z/BFWjFR/IyOl/YNLLC1Xo0oScOJTMA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyhc77-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 04:42:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-74255209c4bso4893207b3a.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 21:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747197748; x=1747802548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5++ZOB31oDZcHsp5eBwjuiAP0cQOmgQ/g6s3cn/odY=;
 b=hTFp8aK2yqb6KR9xO5faSDm3IuPPIUQ86Dpn7/vrafrwkl11PMIsj0JspF8EooyulO
 uZOf65w4mOLu3wGuQoUfszQH9tZJyDMsye67IcDLr3nu3ON92MvqJU3eLDAPqwI5LfbY
 Y4GbmIv4IkkUGh1Tk+tOEiOGAyYUH1ARmmiF06qsjylKqAt/J6jFxd6SHiMzdEat9CQA
 BP8EYHTOYIbA6Ge7kyJbBpa1qsk524qlZ0Ms7/Oovq7ANyIT1LkLB7Sq2QjT9Z5b6uQB
 BmJ8RKZj6QY2EOaJy3CMt0jqKATNRE2r8+q9qjAyEOSOj1m1NIpRkPM+NKPbvotRavUh
 8YIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULAvtfNOQO8XuZKYGk++ABUvN9I6x6C9hKksx1/uIeABoy5aRfKHA9QDIiN7dvb+06xgjY2EE=@lists.denx.de
X-Gm-Message-State: AOJu0YyxThlB2navRnKLnHUp+X/s5dO1TSugTJhT3hWrawtY4hpxqT5/
 EHZdpSEbPBUkXtYHXvTwfgQ+CNrI001PoMc5DVztKDdPqATuHImt7CsUnm1W82amVXO3pqpXG+u
 ++OIu9IuqVMpK2rW1nJLOOGOWOP1BsaJsRrCt4iPrTYty9HLqYBjK
X-Gm-Gg: ASbGncv+QbKKUVsH5bydl3qqyVpTjnAy5t+EyxYZTzh5mmZmx8oc7Yyv5AOcLcm3lrH
 ymZUXUSO5OAN/kQh/qVEFZfrw/OknIdpVp4qluth5el+qfy5aVtQxx9p4PYqKfhZRMBsc4bcMsD
 +RiQYJf2aTozz9MRQ/nsvHqRMTNc1RRY55ls2ijYl0pYEwMIXyv6xGO/TAZPITi0wdvPLHvXiTO
 zfx316dZCUTktNX/kUmDW1AlEqNIo9pN2seiWfBdmqfJ0Xd2qHY+cgJMnruMnaDJtks0YHslUWr
 UUN8yw+lfD9Yv6h7JR1bFZGYlFYg5XIDxB1J3dufL+rMhqeL/DP7tvVHGwt5tlfvA7LSVdAOxhZ
 4WvM6NQz4ZgtZ08iETb4+nN1eXdcig7y+VjVWrsSG
X-Received: by 2002:aa7:8883:0:b0:742:362c:d2e4 with SMTP id
 d2e1a72fcca58-7428923ffc8mr2577133b3a.5.1747197748215; 
 Tue, 13 May 2025 21:42:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7u4z2WkK7dl/hZVokdYIwKa3ttsfcs9Am8oaNZIret8d++nOAkTG4qTEXUl8shDqGeKom1w==
X-Received: by 2002:aa7:8883:0:b0:742:362c:d2e4 with SMTP id
 d2e1a72fcca58-7428923ffc8mr2577107b3a.5.1747197747830; 
 Tue, 13 May 2025 21:42:27 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a3dbfesm8889588b3a.138.2025.05.13.21.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 21:42:27 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, lehmanju@devpi.de, sjg@chromium.org,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 1/6] doc: board: qualcomm: document Dragonwing board
 building/flashing
Date: Wed, 14 May 2025 10:12:07 +0530
Message-Id: <20250514044212.1422714-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250514044212.1422714-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Tfgn9_3JS4G4je-dCiri6Bz5bPLC05Hh
X-Proofpoint-ORIG-GUID: Tfgn9_3JS4G4je-dCiri6Bz5bPLC05Hh
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=68241f35 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=QRC5FBUSQmOKMuYLiD4A:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDAzOSBTYWx0ZWRfX/YhKM5xPV2ct
 D5A7nz2AJ1tdWDhm8BiJvzgtB+KeUroP0dgoL3KkacUiiwx8LAk8J14iFYv0wF0nhtefpyfcRx6
 RsuBUOeesfF2ug0DvDIrI7BoVN04V65M6ZhZcn8DNVUYsWgZGmWjr/vnE32UQViLPRbYkrw7nyi
 aI+ucnLXG4ezhiWChXRjp4g12M3yWd8pbgAYPgfWOyASB+0Q5Eea6/2o1xWChDBW9qZJVeckcPC
 bw65coVjATqzFGXXCpmwNCaTenCuj6QEhO8XMjsKoI+d/2kDw2OsUhqMBUvQ+148VS1moVK8a4N
 yeah53Hw3oyG5SAa8S1aiO7idaew5Turl1UUJ4D5REs/tY4iIcV1MAqAdITtQYqCH0nCOaDTK1J
 B5itw5mCDQPiTAjp+8+lUH4JxGRAndCj+OmNhX+zAzXNQegbtlMEZ5GQBGGNOCpq8JPe8PrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505140039
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
Changes in v2:
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

