Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70451C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 15:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC6EF83082;
	Thu, 29 May 2025 17:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ft4/KcIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9CE83082; Thu, 29 May 2025 17:49:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE39C8305C
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 17:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TC1SxK003587
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3w9s8KK0R3p
 Ja3IN5/7/9ta/0fRvR4ena/Zv06jBH40=; b=Ft4/KcIEH6YjmaXfFACDkcg8vUJ
 LA7vFR4WXoxncau22RAEgdCTsyN1BoPNuFLbA77XkcqpONYih9y1+9Q28qJPLm5E
 bbduwkoGMYgEP5YnoSc6Wgp/jdM2liLcY7EPSBQU9npMoikTX7MXfip0sMck0YO8
 JTqpDHESAPL0xTLVoOwCpfxJAHVKqhIdWF2ZEg5zCCxBD2Qfvo8VxTOr5oxMG3jZ
 86/wVE9XQ5q1OJ2gxn56uklCeYC/m2QlCwTe2vBnH1xhw/UpNZ088w7hndnjv0ED
 pee1aBxvA85w81SdPLwiVbUdXXrYTV7o3oNzBjlbrdY3ExLuX9N9cAiF+JA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u549p48c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 15:49:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23505adcac8so8264895ad.3
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748533785; x=1749138585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3w9s8KK0R3pJa3IN5/7/9ta/0fRvR4ena/Zv06jBH40=;
 b=bNCLLfTupttCZrQ4lxBdiAaHDPjlrZFnrWfqq+iMEH2IpIqPnI2gV9OwRxgDkXRIGA
 6Bhaj6RKdOhk74B4i/YPJ2uhI9lncfoIdXppoXvX7Na2Imqf7WMNRfwW73pw1bN5CbXL
 aasfWs9KEKHUUGZTZ21LS1wPgq7WenOMtj+9o2KYLi8br4A4kIuISv99Q3+4lQActaVs
 nuLwGEiJ3sPF74602ImUhU4BKAMlxqr5SufRsX10PGcoZFdjaI4APKe1thyVciof5e2f
 rC8ndyn6/yOCmofzKzY+AParFNsqt2q69VxM3I/DJx5ioUMVNFNKgHAJLj7fibysV1fz
 RuTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFlyPbktwO+lAoC251vkWBAkzxjPpTNGS7Md2Ee5/GDFG+Mj/rnw3lEKHL/gFsQyWgQzw3lnM=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ3SJPdzUFdK75lpPUCPVFowntlLUKgCFwMf0fAfUOeLJ4W48l
 NOzOabEmTGEeaDmsvfieCwN/KTwnDpcEGkiBUM6IQYiGGAr/8uY04jMt5wSxz6v8zWmfow0ZGvf
 OEL7hVbGU9MoxcUAqaUfo6iufZ07FUDn4vhtPuYEFbw5kVlQDcY+G8nUH
X-Gm-Gg: ASbGnctuxs0xDW9FTUQxx0cEqApom1vmj389yr/9hfj4gY4o6xfiaYNkmcB9weYT8Tv
 zmb6wT95nXEGZ0kvOh+BRJm4iImhSnFhlgNHoIK384UR1ylVJdWud5tUeauKWkPDbfFVMiqFJXW
 lTCFjRBWsMWhPT29DZdhTq3y+fWNyOANEoMmIOyuZ+2YtdASNYOUAomcJFxi2zXFbWMRtlrYOso
 abcg90/1aA5t44Y2KrqWpl8Dhj7PG8fdjjRyu19ZWXo3vCC6/axeSt6yyqZ+97e+YN9tRkwhL8d
 8wXDKlCwBIkKr/I+Wa8wk86T7VrNeZM25bmUThfS1yOrRdu7tMxf3BgjbtwHdkcu/oA/t9xVUXt
 oKBzVkLIRgYEA3kEMWaYSLljLfHM=
X-Received: by 2002:a17:902:e74b:b0:235:779:edf8 with SMTP id
 d9443c01a7336-235299022d8mr1357965ad.53.1748533785227; 
 Thu, 29 May 2025 08:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI8DRTwc6ObItp7pcYx3AR5ncKd1MOR1JcreW/eGDodVrEHzL0EAHQP7B1S2Pkod+vlsz1/A==
X-Received: by 2002:a17:902:e74b:b0:235:779:edf8 with SMTP id
 d9443c01a7336-235299022d8mr1357335ad.53.1748533784740; 
 Thu, 29 May 2025 08:49:44 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cf5448sm13879045ad.185.2025.05.29.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 08:49:44 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Google-Original-From: Balaji Selvanathan <quic_bselvana@quicinc.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de,
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 1/6] doc: board: qualcomm: document Dragonwing board
 building/flashing
Date: Thu, 29 May 2025 21:19:26 +0530
Message-Id: <20250529154931.1879976-2-quic_bselvana@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WKCxtHh7q08kMcgtrv0Bi4WRqXwHCLAG
X-Authority-Analysis: v=2.4 cv=E9nNpbdl c=1 sm=1 tr=0 ts=6838821a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=qC_FGOx9AAAA:8
 a=2_xcl1TeLgUYic126PkA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1MyBTYWx0ZWRfXyFLDLDV7RmXk
 jdKgqpgwALv7n0dq7b9YqdAJNh1ohtCTAfmUbpmgL7hAd2qRDyz4O17DdWg0HVpxXsBlQUoWdLw
 vpV8dWiPejvQWzmcZwGEWkaBCCud/gQ7YXXlGgPG+oWcy1nYJ2vAfq1b2GkWTWvARjXLCH1R5yV
 aFivvMMa7bDl8UKoxXY7TUlgo4TcQYDq+VhqlwY9nJeXD/s90C0kRdTgFsGEzHDEX82f0MigZJb
 j16FkDomlqA3zoSMe6A+wPhqRwZLa8g3fyflaWryClcgWbEkcTLO6nLTRlZhKMX0xoh9eYQ7sEv
 f0M9D6XPeGAh/vJ7Gv/V4bgNI0Lf1MvWwuNne6TMPv5g2mcg/8U8ZbFWU7/3hOKLxHGqmQDwsto
 wamqZ8RQftS/YJnYjO9dnQKSj9u7HE8mBOaxRo5n8WgbmX8wvj4bbAq9qb1XA3FesqEJxpCX
X-Proofpoint-ORIG-GUID: WKCxtHh7q08kMcgtrv0Bi4WRqXwHCLAG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290153
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

From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Introducing documentation support for Qualcomm Dragonwing series
boards. Documents the build and flashing steps.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v4:
- Updated the flashing steps in the documentation

v3:
- No changes to this patch in v3

v2:
- This file is newly added in v2 based on suggestion from reviewer
---
 doc/board/qualcomm/dragonwing.rst | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 doc/board/qualcomm/dragonwing.rst

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
new file mode 100644
index 00000000000..4238b224980
--- /dev/null
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -0,0 +1,46 @@
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
+Note that fastboot is not yet supported in U-Boot on Dragonwing boards, as a result, to flash
+back the original firmware, or new versoins of the U-Boot, EDL mode must be used.
+
+A tool like bkerler's `edl`_ can be used for flashing with the firehose loader (for example, for QCS9100
+the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`.) ::
+
+$ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
+.. _edl: https://github.com/bkerler/edl
+.. _dragonwing IQ9 bootbinaries: https://artifacts.codelinaro.org/ui/native/qli-ci/flashable-binaries/qimpsdk/qcs9075-rb8-core-kit
-- 
2.34.1

