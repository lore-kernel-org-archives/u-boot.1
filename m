Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179CBF43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA125842C9;
	Fri, 17 Apr 2026 14:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dmmGjOf4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ai3IZA8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15112842D2; Fri, 17 Apr 2026 14:11:36 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B0183B99
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H80F0L667783
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZaeAZN+8yaN6Re2s0FGb54d2eF09X5ZjmqYxsyhA7Ag=; b=dmmGjOf4eGrh9c10
 MnO3JRxLTIlTQ3uyE9T85LfQnFv8NiiI3+LG+jz01TpW3ximSptJ5XmE+lPvbcvU
 6WZwBSCXprhJMAqiYHDscO8o6QoExBxFl26QV4ct1K9fHOh1bT4yzMDc45AYNYxB
 hr9W24V0tzuv+IZYx9A3g7NK8owlSk5XO9AeF2I6iSGtsLgnoUBr7JCha3hlzEce
 UwdQj5PuavzfWhDRlxYHUM6XjHK0EkQWfRwyCLAOhYIFzSic1/hEVb4iBTjYc1p2
 jzJJMf/lYYTyK6MloaReO8+m+B1vtZIZ35QO4CF9TSnVMwIoQqobozikgl9WkxqG
 0IVHWA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkaxct61n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 12:11:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f2138a9e0so434994b3a.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776427890; x=1777032690; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZaeAZN+8yaN6Re2s0FGb54d2eF09X5ZjmqYxsyhA7Ag=;
 b=ai3IZA8DtwfkdLQsTh/QKxKDemV5BgstaiMI5iXMSjPvnbNdx+uT9Rdk5bBji2IXUX
 eMUpiJjkL/WnfRjT4zIbYBDvX71yn5ghdsmJ6tDPvXyeQzPBAMpYMRRqmXrBSDFucoZp
 fpjb0Ft8z3Jo0LPV0L5O2nQvsIeb6t5tmeZcXKTrJu4m5p1bj6dtH1p0Ddjj3/CYk5vu
 VprHHbF0a1NY8oCxwrRTiE+Wmf3xty/aZCjEKBC6CzQm8VFueYZ3K89DUythPFTKN5gi
 84Ie8ZXVamDjRjMy5XS71nGwYJmPpKryv11ddpu5Sp3eALCy2x6UH6AHcm2cXAS5IQd2
 gRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427890; x=1777032690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZaeAZN+8yaN6Re2s0FGb54d2eF09X5ZjmqYxsyhA7Ag=;
 b=Jsl+YpclfGHnMcCJWtXq6HIyqKiNV+MzIX6DblpN9Tq/EuaZfL9O3FGUTRM+vPsNL0
 ewdpy+lB63jMxM6qTRY5esMox+5D96pe4LP7YKpZBSS4rVTS5eDv3l+lly6zU57Xl951
 +i8T1UvM+LU+626pky8h+g/aMpfMU/r3Mq73sDpQSlJTkvM2nZ16XWNbesmoz0MAcCmy
 Dqhab2PvLIa6QHLPPo66Fen4+i7O8NeITHft1UDGAY5GcvZVcfSf7sEToR43uNyLh4mO
 f40CaxgGv8IDUuY5tslH7LCSNiMUR62oTUvhLTleqJc5hIqQ2oYJLy9lr0byQU4f82P0
 3jCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Sg2UObf7o0eHTdqe979fNTVFzrwPpxcBvktkTTgzB6AeAzb6sfhL5qHXiZkuSISp8aQOqFoM=@lists.denx.de
X-Gm-Message-State: AOJu0YzDXp69dS3rypXVhsVxgpaDTQ82ubIQeZWie6SMiskJHntbsWLH
 rUsLNsr5aC0vbV/cij1ZeM3nlrObAEuYGdF0+LpQ4xmikrr65tf2nPQB1ZftGdkhROt/vojr95+
 WZToifj8fYncmbYMyKGUrsrL97eD+5m28ztKsYffbRk8VebW8ju80W6CJ
X-Gm-Gg: AeBDietF9v5Ladxmi+kEXXA18IkWKQTET2jpncWqz7nvV+DbFTr0qcNNK43jOkyBdO+
 rpr/jncEuQi0Tidnezw67hJ61xrHsajX5YOkGag6L2wJluw7SjG3X+RgySHlzfyVypDA/e6+izo
 DCCIinY5dwdsv2IkyLo+ClnTrU2PVmPQn5oSFgc5lAD/p+2QZmG3PRDzJvdyz4sfetRlpoSnehm
 80Kf+HBa10Ky9/6fB+FaXNnDHdUD7FLVC7gpvqAmNI6MECUXkB9CrHAQerTrmcZqHrHxwwU0aej
 49vOgVnbOSMBz48kmGMbfYUP4UtdHaiiImVHErjEiXecHYifIB5QJoVOJxlfs+vBMfxlK687VPn
 TxB0sclRxz2FUZyAP+uXkGM4LadSgR0SD9xlxAn1g1gSkfGa9txuDZSDnm2trjCdmUyaI0g/rQk
 LXcJACNuoaFlRuVfr48vVPb4+WPGVMJU3dT9rY3VttNTu6TYhn7mo=
X-Received: by 2002:a05:6a00:a90d:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82f8c2c6390mr2550725b3a.0.1776427889937; 
 Fri, 17 Apr 2026 05:11:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:a90d:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-82f8c2c6390mr2550681b3a.0.1776427889258; 
 Fri, 17 Apr 2026 05:11:29 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9cbb28sm1744641b3a.13.2026.04.17.05.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:11:28 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, aswin.murugan@oss.qualcomm.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mchitale@ventanamicro.com, maximmosk4@gmail.com, jonas@kwiboo.se,
 marek.vasut@mailbox.org, quentin.schulz@cherry.de, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 6/7] doc: document mkimage fatfs type and Qualcomm multi-DTB
Date: Fri, 17 Apr 2026 17:39:50 +0530
Message-Id: <20260417120951.3454249-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JcqMa0KV c=1 sm=1 tr=0 ts=69e22373 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=XpE1AkgCAAAA:8 a=3zqMThaUAAAA:8 a=cSziVDP4AAAA:20 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=RfRJOeisY0wqTn3sFHIA:9 a=ER5y7YfLcBVczURf:21
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=z2U-W3hJrleVIN9YIjzO:22 a=IoOABgeZipijB_acs4fv:22 a=dpZMgbseYPk84XhQl7oQ:22
 a=7DfZiAEMZEHNOMwpeQAY:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDEyMiBTYWx0ZWRfX+3UTuf5Iqn5n
 +E1Eo5JJp6AeT5KkhFrDs15Iwy4nqtBhBWE3+YcNyG8osf7X0NvM7N0zTB7iCnCudOv0sk3sk4T
 nazKLrRb18peTu/sEdRzAMcSm24XTUbbdNVUuQbPPg6wWdln9Jf6g8fxJ0vu8qdLC/kkQ8Wf6Is
 YLac3qvOndVhrtgbJo7EJ2wmud7+NKHUAMv6lBP9JJBTa2AXSKp0YLIjk0AOsPSGZCSeIFwSS+Z
 d99HZ6XWqNlYREXAMYW6c5Ko4ix/qACV0zWPUj3IGDPejzJ5N1kYRfr1YrKLbiXn3ciQ+A+kf9w
 POlUzaH90uhXpOLFvgmpN6dpqJFGiwnB2TVhtszkeEdQ77hGVI98E1y9vHytmGfsjT1dZhl8UWo
 XHR0zQL33/HKFtvgFbEb26X3tkj1Dm6jqCGmFVmbdhMwFlyopn7FQ6ttdAcV12WaESoEJgrh0nK
 L2FMZK0db1Sv0ZmgbHQ==
X-Proofpoint-GUID: usHZp2MNsLGUr64Xo__MiKKvtHHZp-7A
X-Proofpoint-ORIG-GUID: usHZp2MNsLGUr64Xo__MiKKvtHHZp-7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170122
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

Update doc/mkimage.1 to document the new fatfs image type,
the --fat-* long options, a fatfs entry in the CONFIGURATION
section, and two usage examples.

Add doc/board/qualcomm/multi_dtb.rst describing the
Qualcomm FIT-based multi-DTB packaging workflow for
Snapdragon platforms. The document covers:
- FIT ITS configuration and compatible string matching
- QCOM metadata binary format and identifier properties
- Guidelines for adding new socver/boardrev entries
- Step-by-step image creation using mkimage -T fatfs

Update doc/board/qualcomm/index.rst to include the new
multi_dtb page in the toctree.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 doc/board/qualcomm/index.rst     |   1 +
 doc/board/qualcomm/multi_dtb.rst | 352 +++++++++++++++++++++++++++++++
 doc/mkimage.1                    | 103 +++++++++
 3 files changed, 456 insertions(+)
 create mode 100644 doc/board/qualcomm/multi_dtb.rst

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..fe4a4aecd60 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -10,6 +10,7 @@ Qualcomm
    debugging
    dragonboard410c
    dragonwing
+   multi_dtb
    rb3gen2
    iq8
    phones
diff --git a/doc/board/qualcomm/multi_dtb.rst b/doc/board/qualcomm/multi_dtb.rst
new file mode 100644
index 00000000000..fa9252ce1c4
--- /dev/null
+++ b/doc/board/qualcomm/multi_dtb.rst
@@ -0,0 +1,352 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Qualcomm FIT-Based Multi-DTB Support
+=====================================
+
+Overview
+--------
+
+Qualcomm supports multiple SoCs and boards within a single software release
+binary, which requires packaging all corresponding Device Tree Blobs (DTBs)
+into a single image. To ensure the appropriate DTB(O)s are selected for each
+platform, a mechanism for dynamic device tree selection is necessary.
+
+The Flattened Image Tree (FIT) format is a standard file format for packaging
+images widely used in the community. U-Boot leverages this format to facilitate
+DTB selection and meet platform-specific requirements. The appropriate DTB
+selected for the platform by U-Boot is passed to the OS at boot time.
+
+Terminology
+-----------
+
+- **FIT**: Flattened Image Tree
+- **DT**: Device Tree
+- **FDT**: Flattened Device Tree
+- **.its**: Image Tree Source
+- **.dtb**: Device Tree Blob
+
+References:
+
+- https://docs.u-boot.org/en/latest/usage/fit/index.html
+- https://fitspec.osfw.foundation/
+
+Design
+------
+
+The FIT-based approach, commonly adopted within the U-Boot community, offers a
+standardized solution for multi-DTB packaging. This design is the first
+implementation utilizing FIT to facilitate DT selection from a multi-DTB
+binary.
+
+FIT provides a flexible and extensible format to support multiple components
+(device tree, kernel image, ramdisk). It also supports multiple configurations
+so that the same FIT can be used to boot multiple platforms, with some
+components in common (e.g., kernel) and some specific to that platform (e.g.,
+device tree). The Flattened Image Tree Specification (FITSpec) suggests the
+image selection mechanism.
+
+Detailed Description
+^^^^^^^^^^^^^^^^^^^^
+
+1. In the FIT ITS file, each configuration comprises a compatible string along
+   with a declaration for the base DT blob and the overlays in sequence. A few
+   such configuration node examples are provided in the .its tree format below.
+
+2. This implementation uses a metadata binary structured in DT format for
+   selecting the appropriate configuration. A node, named
+   ``fdt-qcom-metadata.dtb``, for the metadata binary is provided under the
+   ``images`` node in the FIT tree with type ``qcom_metadata``.
+
+3. The compatible string suffixes in the FIT tree can be put in any order, but
+   the node corresponding to each suffix must be present in the
+   ``qcom-dtb-metadata`` binary. If any new suffix is introduced, it must be
+   added to the metadata (refer to ``qcom-dtb-metadata.dts`` below this
+   section). The new suffix sub-node must be added under the relevant node.
+
+   Suggested pattern::
+
+       <soc>-<soc-sku>-<socver>-<board>-<boardrev>-<board-subtype-peripheral-subtype>-<board-subtype-storage-type>-<board-subtype-memory-size>-<softsku>-<oem>
+
+4. Each of the suffixes inside the compatible string must be an exact match for
+   a DTB to be selected. Upon any mismatch, a configuration is rejected and the
+   search moves ahead with other available configurations.
+
+5. The compatible string that gets matched has its corresponding DTB(O)s
+   selected for boot.
+
+FIT ITS Configuration
+^^^^^^^^^^^^^^^^^^^^^
+
+Each configuration in the FIT ITS file comprises a compatible string along
+with a declaration for the base DT blob and overlays in sequence. Example::
+
+    config-1 {
+        compatible = "qcom,soc";
+        fdt = "fdt-soc-v2.dtb";
+    };
+
+    config-2 {
+        compatible = "qcom,soc-socv1.0";
+        fdt = "fdt-soc-v1.dtb";
+    };
+
+Refer: https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/qcom-fitimage.its
+
+DTB Metadata Description and Parsing
+--------------------------------------
+
+The QCOM metadata supports the following DT nodes: ``soc``, ``soc-sku``,
+``socver``, ``board``, ``boardrev``, ``board-subtype-peripheral-subtype``,
+``board-subtype-storage-type``, ``board-subtype-memory-size``, ``softsku``
+and ``oem``. Sub-nodes of the respective type can be added under each node.
+
+The SoC specific identifiers are encapsulated in DT properties named
+``msm-id`` and ``socver-id``.
+
+Identifier Properties
+^^^^^^^^^^^^^^^^^^^^^
+
+- **msm-id** ``<u32>``: Each sub-node under the ``soc`` node must contain an
+  ``msm-id`` property. Bits 0-15 of the 32-bit value represent the chip
+  identifier; the remaining bits are reserved.
+
+  Each sub-node under the ``soc-sku`` node should contain an ``msm-id``
+  property. Bits 20-21 represent the package-id, bits 16-19 represent the
+  foundry-id; the remaining bits are ignored.
+
+- **socver-id** ``<u32>``: Each sub-node under the ``socver`` node should
+  contain a ``socver-id`` property. Bits 0-3 represent the chip minor version,
+  bits 4-7 represent the chip major version; the remaining bits are reserved.
+
+- **board-id** ``<u32>``: Each sub-node under the ``board`` node must contain
+  a ``board-id`` property. Bits 0-7 represent the board type; the remaining
+  bits are reserved.
+
+- **boardrev-id** ``<u32>``: Each sub-node under the ``boardrev`` node must
+  contain a ``boardrev-id`` property. Bits 0-3 represent the board minor
+  version, bits 4-7 represent the board major version; the remaining bits are
+  reserved.
+
+- **board-subtype** ``<u32>``: Each sub-node under the
+  ``board-subtype-peripheral-subtype``, ``board-subtype-storage-type`` and
+  ``board-subtype-memory-size`` nodes should contain a ``board-subtype``
+  property.
+
+  - Under ``board-subtype-peripheral-subtype``: bits 0-7 represent the
+    peripheral-based subtype; the remaining bits are ignored.
+  - Under ``board-subtype-storage-type``: bits 12-14 represent the storage
+    type; the remaining bits are ignored.
+  - Under ``board-subtype-memory-size``: bits 8-11 represent the memory size;
+    the remaining bits are ignored.
+
+- **oem-id** ``<u32>``: Each sub-node under the ``oem`` node must contain an
+  ``oem-id`` property. The ``oem-id`` represents the OEM and is added by the
+  OEM for selection of their board-specific DT.
+
+- **softsku-id** ``<u32>``: Each sub-node under the ``softsku`` node must
+  contain a ``softsku-id`` property. The ``softsku-id`` represents the software
+  SKU and is added for soft SKU (license) based selection of DT.
+
+The ``msm-id`` and ``socver-id`` are compared with the chip identifier value
+read from the SoC.
+
+The ``board-id``, ``boardrev-id``, ``board-subtype-peripheral-subtype`` and
+``oem-id`` are compared with the hardware description values (Configuration
+Data Table - CDT) flashed on the board's persistent memory.
+
+The ``board-subtype-storage-type`` is compared with the board's boot device
+type detected by U-Boot.
+
+The ``board-subtype-memory-size`` is compared with the board's DDR size
+detected by U-Boot.
+
+Refer: https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/qcom-metadata.dts
+
+Guidelines for socver and boardrev
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+- For any platform, the configuration entry with the shortest compatible string
+  (containing only the ``soc`` and ``board`` fields) must always reference the
+  latest hardware (SoC / board) version.
+
+- When adding support for a new hardware version that requires a separate DTB,
+  update the ``fdt`` property in the configuration with the shortest compatible
+  string so that it points to the DTB of the latest hardware version. If the
+  previously supported latest hardware version must continue to be used, add a
+  new ``socver``/``boardrev`` entry in the metadata DTS for the earlier
+  hardware. Additionally, add a new configuration entry in the FIT ITS that
+  corresponds to the platform compatible with the newly added
+  ``socver``/``boardrev``.
+
+- Consider the following example: The "soc" platform supports two chip versions
+  — socv1.0 and socv1.1 — and both versions share the same DTB (soc-v1.dtb).
+
+  FIT ITS::
+
+      config-1 {
+          compatible = "qcom,soc";
+          fdt = "fdt-soc-v1.dtb";
+      };
+
+  Now a new chip version socv2.0 is introduced, which requires a new DTB
+  (soc-v2.dtb). The older chip versions must continue to be supported.
+
+  Updated FIT ITS::
+
+      config-1 {
+          compatible = "qcom,soc";
+          fdt = "fdt-soc-v2.dtb";
+      };
+
+      config-2 {
+          compatible = "qcom,soc-socv1.0";
+          fdt = "fdt-soc-v1.dtb";
+      };
+
+      config-3 {
+          compatible = "qcom,soc-socv1.1";
+          fdt = "fdt-soc-v1.dtb";
+      };
+
+  Updated Metadata DTS::
+
+      socv1.0 {
+          socver-id = <0x10>;
+      };
+
+      socv1.1 {
+          socver-id = <0x11>;
+      };
+
+- If older hardware requires a separate DT and is not currently supported in
+  the FIT, add the required ``socver``/``boardrev`` entries in alphabetical
+  order.
+
+Image Building
+--------------
+
+FIT Image Properties
+^^^^^^^^^^^^^^^^^^^^
+
+- FIT is normally built with image data in the ``data`` property of each image
+  node. It is also possible for this data to reside outside the FIT itself
+  (external FIT). This allows the FDT part of the FIT to be quite small, so
+  that it can be loaded and scanned without loading a large amount of data.
+  Then when an image is needed it can be loaded from an external source.
+
+- External FITs use ``data-offset`` or ``data-position`` instead of ``data``.
+  The ``mkimage`` tool can convert a FIT to use external data using the ``-E``
+  argument.
+
+- The ``mkimage`` tool provides a ``-B`` argument to align each image to a
+  specific block size. Use ``-B 8`` to enforce 8-byte alignment.
+
+- The output FIT image must be named ``qclinux_fit.img`` so that U-Boot can
+  locate it in the FAT partition.
+
+Step-by-Step Workflow
+^^^^^^^^^^^^^^^^^^^^^
+
+1. **Install required tools**::
+
+       sudo apt-get install device-tree-compiler u-boot-tools mtools
+
+2. **Clone the qcom-dtb-metadata project**::
+
+       git clone https://github.com/qualcomm-linux/qcom-dtb-metadata.git
+       mkdir fit_image
+       cp -rap qcom-dtb-metadata/qcom-fitimage.its \
+               qcom-dtb-metadata/qcom-next-fitimage.its \
+               qcom-dtb-metadata/qcom-metadata.dts \
+               fit_image/
+
+3. **Copy compiled DTB/DTBO files from the kernel tree**
+
+   For steps on cloning and building the Qualcomm Linux Kernel Tree, refer to
+   https://github.com/qualcomm-linux/kmake-image/blob/main/README.md ::
+
+       mkdir -p fit_image/arch/arm64/boot/dts/qcom/
+       # Copy the compiled dtb/dtbo files from the kernel's kobj directory
+       cp -rap <u-boot build dir>/dts/upstream/src/arm64/qcom/*.dtb* \
+               fit_image/arch/arm64/boot/dts/qcom/
+
+4. **Compile the metadata DTS**::
+
+       cd fit_image
+       dtc -I dts -O dtb -o qcom-metadata.dtb qcom-metadata.dts
+
+5. **Generate the FIT image**
+
+   Use ``-E`` to place binary data outside the FIT structure and ``-B 8`` for
+   8-byte alignment::
+
+       mkdir out
+
+       # For kernel main branch
+       mkimage -f qcom-fitimage.its out/qclinux_fit.img -E -B 8
+
+       # For kernel qcom-next branch
+       mkimage -f qcom-next-fitimage.its out/qclinux_fit.img -E -B 8
+
+   The ``-E`` flag places binary data outside the FIT structure. However,
+   since ``/incbin/`` is used in the ``.its`` file, all binaries are appended
+   into the same image. The FIT structure contains the offset and size for each
+   appended binary.
+
+6. **Pack the FIT image into a FAT partition image using mkimage**
+
+   The ``mkimage`` tool supports creating FAT filesystem images directly via
+   the ``fatfs`` image type.
+
+       mkimage -T fatfs -d out/ fitimage.bin \
+           --fat-extra-space 512 \
+           --fat-volume-id "MYBOOT" \
+           --fat-mkfs-opts "-S 512 -a"
+
+   Available parameters:
+
+   - ``--fat-extra-space <KB>`` — extra padding in KB (default: 512 KB)
+   - ``--fat-type <12|16|32|0>`` — force FAT type (0 = auto-detect)
+   - ``--fat-volume-id <label>`` — volume label (default: ``BOOT``)
+   - ``--fat-mkfs-opts <opts>`` — extra ``mkfs.vfat`` options (default: ``-S 512``)
+
+   .. note::
+
+      This requires ``mkfs.vfat`` (from ``dosfstools``) and ``mcopy``
+      (from ``mtools``) to be installed on the build host.
+
+   The resulting ``fitimage.bin`` is a FAT partition image containing
+   ``qclinux_fit.img`` and is ready to be flashed to the ``dtb_a``
+   partition.
+
+7. **Flash the image**::
+
+       fastboot flash dtb_a fitimage.bin
+
+Boot Flow
+---------
+
+U-Boot reads ``qclinux_fit.img`` from the FAT partition image flashed to the
+``dtb_a`` partition. It uses the metadata binary and compatible strings in the
+FIT to select the correct DTB for the running hardware. The FIT image contains
+a configuration table FDT, metadata FDT, and DTB/DTBO binaries. The
+configuration table FDT contains the offset and size of each DTB/DTBO within
+the same buffer. U-Boot parses the metadata, matches the compatible strings
+against the hardware identifiers read from the SoC and CDT, and passes the
+selected DTB to the OS at boot time.
+
+Inspecting the Generated Image
+-------------------------------
+
+To verify the contents of the generated FIT image::
+
+    # Extract individual DTBs from the image
+    git clone https://github.com/PabloCastellano/extract-dtb.git
+    # Creates a "dtb/" folder containing each of the dtb/dtbo files
+    ./extract-dtb/extract_dtb/extract_dtb.py fitimage.bin
+
+    # Verify the ITS/FIT structure (configuration table FDT)
+    fdtdump dtb/01_dtbdump_*.dtb
+
+    # Verify the metadata DTB contents
+    fdtdump dtb/02_dtbdump_Image_with_compressed_metadata_blob.dtb
diff --git a/doc/mkimage.1 b/doc/mkimage.1
index 9a2d07cee75..ed6bd9f32d9 100644
--- a/doc/mkimage.1
+++ b/doc/mkimage.1
@@ -54,6 +54,14 @@ The new
 (Flattened Image Tree) format allows for more flexibility in handling images of
 various types and also enhances integrity protection of images with stronger
 checksums. It also supports verified boot.
+.P
+The
+.I fatfs
+image type creates a FAT filesystem image from a directory of files. The
+directory is specified with
+.BR \-d .
+The resulting image is a raw FAT partition image suitable for flashing directly
+to a storage device partition.
 .
 .SH OPTIONS
 .
@@ -227,6 +235,11 @@ then multiple images may be specified, separated by colons:
 .IP
 .IR image-data-file [\fB:\fP image-data-file .\|.\|.]
 .RE
+.IP
+For the
+.B fatfs
+image type, this argument specifies the input directory whose contents will be
+copied into the FAT filesystem image.
 .
 .TP
 .B \-x
@@ -496,6 +509,59 @@ using
 But if the original input to mkimage is a binary file (already compiled), then
 the timestamp is assumed to have been set previously.
 .
+.SS Options for creating FAT filesystem images
+.
+These options are only used when
+.B \-T fatfs
+is specified. The input directory is provided via
+.BR \-d .
+The host tools
+.B mkfs.vfat
+(from
+.IR dosfstools )
+and
+.B mcopy
+(from
+.IR mtools )
+must be installed on the build host.
+.
+.TP
+.BI \-\-fat\-extra\-space " size-kb"
+Add
+.I size-kb
+kilobytes of extra padding space to the FAT image beyond the size of the input
+data. This reserves room for future additions. The default is
+.BR 512 .
+.
+.TP
+.BI \-\-fat\-type " type"
+Force the FAT filesystem type to
+.IR type ,
+which must be one of
+.BR 12 ,
+.BR 16 ,
+.BR 32 ,
+or
+.B 0
+(auto-detect based on image size). The default is
+.B 0
+(auto-detect). FAT32 is automatically selected for images larger than 512 MB.
+.
+.TP
+.BI \-\-fat\-volume\-id " label"
+Set the FAT volume label to
+.IR label .
+The default is
+.BR BOOT .
+.
+.TP
+.BI \-\-fat\-mkfs\-opts " options"
+Pass additional options to
+.BR mkfs.vfat (8)
+when formatting the FAT image. The default is
+.BR "\-S 512"
+(512-byte sector size).
+.
 .SH CONFIGURATION
 This section documents the formats of the primary and secondary configuration
 options for each image type which supports them.
@@ -544,6 +610,21 @@ and valid
 are decimal numbers. See section 11.4.4.1 of the SAMA5D3 Series Data Sheet for
 valid values for each parameter.
 .
+.SS fatfs
+The
+.B fatfs
+image type creates a FAT filesystem image from a directory of files. The
+.B \-d
+option specifies the input directory; all files and subdirectories within it
+are copied into the FAT image using
+.BR mcopy .
+The image size is calculated automatically based on the total size of the input
+data plus the extra padding specified by
+.BR \-\-fat\-extra\-space .
+The FAT filesystem is formatted using
+.BR mkfs.vfat .
+No primary or secondary configuration is used.
+.
 .SS imximage
 The primary configuration is a file containing configuration commands, as
 documented in doc/\:imx/\:mkimage/\:imximage.txt of the U-Boot source.
@@ -903,10 +984,32 @@ of data storage.
 \fBmkimage -F external_data-offset.itb
 .EE
 .RE
+.P
+Create a FAT filesystem image from a directory, with default settings:
+.RS
+.P
+.EX
+\fBmkimage \-T fatfs \-d out/ fitimage.bin
+.EE
+.RE
+.P
+Create a FAT filesystem image with custom volume label, extra space, and
+mkfs.vfat options:
+.RS
+.P
+.EX
+\fBmkimage \-T fatfs \-d out/ fitimage.bin \\
+	\-\-fat\-extra\-space 512 \\
+	\-\-fat\-volume\-id "MYBOOT" \\
+	\-\-fat\-mkfs\-opts "\-S 512 \-a"
+.EE
+.RE
 .
 .SH SEE ALSO
 .BR dtc (1),
 .BR dumpimage (1),
+.BR mkfs.vfat (8),
+.BR mcopy (1),
 .BR openssl (1),
 the\~
 .UR https://\:u-boot\:.readthedocs\:.io/\:en/\:latest/\:index.html
-- 
2.34.1

