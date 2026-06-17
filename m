Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060F2CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4E9849ED;
	Wed, 17 Jun 2026 14:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HZdhyBgv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ix0Z8cxT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D69841F2; Wed, 17 Jun 2026 12:18:56 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C13838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8VZbN2190769
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XPlKuCyk2aMflSV0MAsDdIjlvoFXqmOmf3GBuZXcvG8=; b=HZdhyBgv9kHh6uNL
 UjBNFzv/t91pQVvVlEx9itJNXtrSoZHFPBPv3nn8mxzPmn2XgVag0Y2SAMp7V2wS
 hZmJL3JnNdqvmZqnZQO16v6hcWw3/t4pn+5ItsWOqtCqca6nKG0j5BEJP3ewewT7
 /mPYbBYUqYh1ykfA9JKpFKEluA7gR5mi5EPJzo79N98Yzgfakrtiaro8MkHvSAZA
 JClVhicBObcucJGCCwI9hfacz7Fbo13kgSwYdC911KyItvAcL+1drFxLuRAdcJV+
 T8rRhz2XiBUgURLagoH7tRmBb5OHpBFq8Vhgbhu032MGbktHCLXuzZ4klwI75JFa
 lxdirg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjn8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:18:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8422ca754d8so4288335b3a.1
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691532; x=1782296332; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XPlKuCyk2aMflSV0MAsDdIjlvoFXqmOmf3GBuZXcvG8=;
 b=ix0Z8cxTvndSjk9RcQpDL5SWKmuPaM/KBOhpLtMC1l4qPSJYJAAYBJyQamdD7RuI7l
 hcYfAJf09QBthzyOzaAy+ahe43xMnf9WihWSPfedyNsu5nQWqWGqGr2G/K6bbSWdmuLK
 U7mmNBMuLlQBMZF7XgBhe6WthUi8qKw5JQUcoyt1EflObY3S0yeRK0OHe6U9l+UVMfA7
 N6c9TsJdon8PWQAKeBGZ+YVlcHR5vNCaMUAZPScE+PYF0RQVTDZDub/kwiApGyR7cVZ4
 0zd+cfONPYR/0/qrCe5xEmaxtCsNYMkpe8CI8rDqslteD92jGjKEddBMHz0Jir4Dpab/
 iMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691532; x=1782296332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XPlKuCyk2aMflSV0MAsDdIjlvoFXqmOmf3GBuZXcvG8=;
 b=rz4Dr0TWhZEGmpGfbR8Mp2jHNoEAiMMnKIyT7qTKTCFoDyuq4TgxJnH/luXA2cSDv1
 gNMreveCra2C7XpJlxKbhAs27xsKjnJk0CfxGf8OJYyWHqezxB5EpBhPg6blWc0gDVbM
 VMel8DooimH2yBHBnJsNIkVtzOwbbK/M8SUVATDPrdlCwyiqW7vLTIx3EvbdSRhztNVH
 F0Ak1rD9ESAnYWkNa34h0Ns1c1pszNA6pNbCzFOc7jlp62rsOZAz0WB9IPUIhXfDElnS
 +0naS11AIpazC61j1TiZyh1AJAswx1d3dIv4+7iTADWWrepMIEL8BaoCcbfRP53L/0tp
 EcDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rW977h8udESJoybQMrUN+l4OG8eNa/Q1TVMnp7LGSQdWlbQ1kP8FblcoNhM2UZtShwbm1Rts=@lists.denx.de
X-Gm-Message-State: AOJu0YxDfnDP53mawdFJQOmvuoAHjPbRNAf/bFuUQjx3NXfFlM0qRQ+I
 RoYMpkfUf1RFMmWWZDBTj8zZU9PpjOCoA3MxLFH2u+gVvm3zLdCgGf3Z/eFX4+sGYf23BBTYxwB
 qENPz1isTepH+7++duG1ZhtjYYIlQ4ntXJQ4rmTCW3uxXVKIgqqUoGtfe
X-Gm-Gg: Acq92OF4q1Y0daZw7GjINcNhbBKyc5bf8XaDrACyfGBuY7tlwT7vdv1MrXzPFaz87XE
 39+g7Rdnk227P4mXrtSN6dz2fKNLwZJJtw/CuSmcYu+g4yuWU9Z1LSPI3BhQLkQ/oKpIEEX/dQp
 VoC2A4IbCUpQd3jMqF4KIjUN69vPDi6vwL2ApLSTQ6omil7auwooleLGvEh0nxZBWgYqaukfYZL
 Z8ukj2m2cAOB0v50SqN+qIBCzHqN4tYww6SyNT5EFXMobflp98Xh6lzkdVYSJ0kkAK6TPSa0V1a
 LXWeP5IQVD3x3mnMSj5SV9QtobYxTEbUfNsBaVPMoaDxuZNCe6TB3rHfGPR/fY5yszrGJO9A4y2
 Jqj/+Vby+1RryKcf1/5H6s7IemhKl0L/4liOB4+yUqRrEJwDWoPo/rkf7Vt2hggW0HVzi9RXIeY
 RlZcnfRs0SUtU0xy4l+NtEcHNauv6ARxWrYvOyXgH+
X-Received: by 2002:a05:6a00:993:b0:83e:3050:d0b with SMTP id
 d2e1a72fcca58-8452441c8bemr3290043b3a.1.1781691531822; 
 Wed, 17 Jun 2026 03:18:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:993:b0:83e:3050:d0b with SMTP id
 d2e1a72fcca58-8452441c8bemr3290000b3a.1.1781691531337; 
 Wed, 17 Jun 2026 03:18:51 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:18:50 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 02/13] binman: qcom: Add type definitions for Qualcomm
 binaries
Date: Wed, 17 Jun 2026 15:48:01 +0530
Message-Id: <20260617101812.299586-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX7DNWZQzaFc36
 NQnVKrX2LFsmC20KytmBSFqMlD+yfppjOROEVtudhb0RnUWafd0+9S1k6Ni1vGAKA6E5WWUm27n
 tFMQfxRHhmCSml9tcdpS2eItD3IfcgrewxoDTCRez/KoaRH2cuJpebLH5smxi8vfaN6m9aa/7wL
 MBW7JNeYk7kwUqGWiMCTr7RpTOOgbno6oDDMZHEd2PsPZGOM5cMTOSklHdv0XjdcQ7CKaX6fafz
 DilahAN27zuA/+04fKhY6RRpC+X5eMWtObUcWdCLywSSxksQPFXUq5hc+2Tt4fa4s60DA/h6eym
 ueIxkJNuyH++x2TBh1fSmudxBBxBseX/E0DRDxeVOnnZbdsov5r6PZd0rflP+VTfUL1pVNdsZJ6
 YhLeVYB9XkqeLatxbztzGiQ6+BGKSW207YLeQDOEuyda4WG/RsoJJzTsQe9h6/Av8UB+01elgve
 Y12oALaXNgwT5NtWK8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXxbxWwCWMsH1S
 Q+0iUW4Z3WVCNQNKrKIwCwVW3SPG1kedRL67KCRZxDLX2aAxYXlmde15K5YlXK7m95VipWLcXe6
 y3lD73a58v0biTCCYtNzkBEwHodqRmc=
X-Proofpoint-ORIG-GUID: ZSs0ZxbXq3BzLUz2Nkyr4m2PKhf-Hfyr
X-Proofpoint-GUID: ZSs0ZxbXq3BzLUz2Nkyr4m2PKhf-Hfyr
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a32748c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=dzUh2ppR8F7ShpQMaCIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

Add type definitions for Qualcomm's

	appsbl	-> APPS Boot Loader (U-Boot)
	config	-> Board/DDR related configuration
	lib	-> Library of proprietary routines

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/binman/etype/qcom_appsbl.py | 23 +++++++++++++++++++++++
 tools/binman/etype/qcom_config.py | 26 ++++++++++++++++++++++++++
 tools/binman/etype/qcom_lib.py    | 21 +++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 tools/binman/etype/qcom_appsbl.py
 create mode 100644 tools/binman/etype/qcom_config.py
 create mode 100644 tools/binman/etype/qcom_lib.py

diff --git a/tools/binman/etype/qcom_appsbl.py b/tools/binman/etype/qcom_appsbl.py
new file mode 100644
index 00000000000..f25bcbec37d
--- /dev/null
+++ b/tools/binman/etype/qcom_appsbl.py
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# Entry-type module for U-Boot MBN image
+#
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_qcom_appsbl(Entry_blob_named_by_arg):
+    """U-Boot mbn image
+
+    MBN is a Qualcomm‑specific signed firmware container that packages
+    executable images (typically ELF) along with metadata such as hash,
+    signature, and certificate chain, enabling the secure boot chain and Root
+    of Trust (RoT) to load and authenticate images.
+
+    Properties / Entry arguments:
+        - filename: Filename of U-Boot MBN (default 'u-boot.mbn')
+
+    This is the U-Boot MBN image.
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'qcom-appsbl')
diff --git a/tools/binman/etype/qcom_config.py b/tools/binman/etype/qcom_config.py
new file mode 100644
index 00000000000..93951a162b9
--- /dev/null
+++ b/tools/binman/etype/qcom_config.py
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# Entry-type module for QC Config ELF
+#
+
+from binman.entry import Entry
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_qcom_config(Entry_blob_named_by_arg):
+    """QC Config ELF
+
+    Although the QC Config image primarily contains configuration data that
+    could be represented as a raw binary, it is maintained in ELF format to
+    ensure compatibility with Root of Trust (RoT) based image authentication
+    during the secure boot process.
+
+    Properties / Entry arguments:
+        - qcom-config-path: Filename of QC Config ELF (typically 'qcconfig.elf')
+
+    This will be part of the Qualcomm SPL based bootloader image
+
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'qcom-config')
+        self.external = True
diff --git a/tools/binman/etype/qcom_lib.py b/tools/binman/etype/qcom_lib.py
new file mode 100644
index 00000000000..ca7666fe6e6
--- /dev/null
+++ b/tools/binman/etype/qcom_lib.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+#
+# Entry-type module for QC LIB ELF
+#
+
+from binman.entry import Entry
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+class Entry_qcom_lib(Entry_blob_named_by_arg):
+    """QC LIB ELF
+
+    Properties / Entry arguments:
+        - qcom-lib-path: Filename of QC LIB ELF (typically 'QCLib.elf')
+
+    This will be part of the Qualcomm SPL based bootloader image
+
+    """
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'qcom-lib')
+        self.external = True
-- 
2.34.1

