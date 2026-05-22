Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3134CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C63C847C4;
	Fri, 22 May 2026 08:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mqa1Dqis";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKBrh2EI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6511283FF5; Fri, 22 May 2026 08:10:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF570846F1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M3KOZx187711
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4J/sTDFHH9K8jsU0seLhSj2Y2ftl9Qbsfca1dwyGrg8=; b=mqa1Dqis026ZncKe
 226wf6/GhVVb9lEggWkGVu6hUHktK6GKeYgxQs4vab+3VqPoYRyC12NLOzl4QRes
 le9BeiZyvhcTiRhGdUZFA0qfVD8PJ9MneK0Y0OzL8plhHKGlbDraSqOtFLwzhp3R
 GaI7xwYlPKFC/w4fnaikRA4/P1j4omV07MuVSeI+Uh21N7f0AowkWcZMMLIr5GzJ
 id2hwW5bkJyKMN5rfGokUWxkaHxJNuI9cAxCLvo0r5L4NpdCpuY0RnffeSzIzWab
 G+cByvfMFkKV8GV9Zjbu1KpTjtR41UqzRwKCg9sqxdvom/erwVycJaBmSc27QCkn
 58cmuA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahw4js-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:10:14 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c82751074c8so11088820a12.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779430213; x=1780035013; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4J/sTDFHH9K8jsU0seLhSj2Y2ftl9Qbsfca1dwyGrg8=;
 b=OKBrh2EImc/zli9iDxcoEwvFT7GrxSebQAxzafsb2qyGEzZmY0RjMRWp20MJBpS0jN
 RGh+Q+48YJfMjCVhywyl2CtYp3lSjwPH5UBYmXm1RS/g5Qt5H/DW1x9/HzvFYQ/yBXTn
 fsuiPlix7YorxnVRe4KVGjMAXs0kByvHA5E1F6AL1lZxcky2DjTNz0IUAqYeq+cgF6x7
 7IhEdksSlMhJ+pdVJoL126+YVbC/oCAjHz5wHIaK8hXRfCV/mCxx7g5pVS8zQTtyjUfK
 /EJdrMXqqR8k+Pkp42MuF30jpSbYH5cXq/0sMX3cKiwJHK9b3bzYflE7mzxffB3dKlM8
 ULGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430213; x=1780035013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4J/sTDFHH9K8jsU0seLhSj2Y2ftl9Qbsfca1dwyGrg8=;
 b=Q3tA7S7hKhGyJ9+ibYTAf+rFH6NrLT5ssbkJkEppCdUY+wSVqJpEHSfiwoGO/+A078
 E7HG7XRGLzFfI2ADE1JBTpGBbviGIjgtrQm1tBjsvfp+hvbvhP0WKnWwyvqTGwr4ubtV
 kodskV6p1R4fWeusNgPaIN8+3eSHxsmx/Fs5oulx7PYwiIH6+SAoe+Cx0bMyGSGp8ec5
 vyGy8C2inwZyrmfclQO8J9gOJG5FPebkdH8oHySw1mrHof9ZSagUlVDcU+yZ1X1vh7l9
 jrtfYtHc4A657nfTnRxgcaZpo3vwxz0jsUGIWZrvNQMIGzssvh9XpOe9v3Fg8U/Hnt5s
 JtXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P2MdzYkgIfCED14uhc1FbKlxtA++Nf1ixxTcK1IMHdejMbOcP9Ao023fFgSSfH6e8H/9qTrY=@lists.denx.de
X-Gm-Message-State: AOJu0YyBoZ6hyPCXXCu8BV5RAL//WmLvosg6yvKg+xTMJJU/Dz/3lIs+
 rUJVoYXKMQhkCN1hpPYUOLzJiszlSCrfhgIDK1pZLPTx5FfPTowgFX0VH62m3FCbYp0i57/5RNi
 qT+5jA+XJO133kiF3w4fJa2HwEqIcLanoiIKVitbgaI5Qz6K8oRZH7Cu1
X-Gm-Gg: Acq92OGFJR+lOXxGTOREI0UYzeQngedAR3aG+dFvx0whI0gAFkAJAdA6GskMycWQKTN
 JKdXDSTFL7t2Ke85IbYb4X73Mx5W4/c5hIGNAzJUDttrmQvEZoa/lvoC9VLTS+ctkz+lbz0qpXW
 +oVKjyyhaXvpJisUnztb6xx6nmz5FZun6B7loCnIH5mgek5hKvbLHWkDViGB3qthlGuhRUaMYci
 BzSf1yo6U7xByy0gQPLpliliLJk3aLRjWJlikl7KcJEHaAKR2bBjxpkigcqSX0K/vBf3bZukfLj
 t0yJjAdm0UwN7NraaStNRv00RdqCe/Lx35obnQhFaUt1N/SNDfj4f4m/5BWAI+lZLwJrF1LjXTq
 UQZMKArQszKSpzoTwjh1hp6u6cUyH/L5GRXtl+e9P3AVGkeVJVPatbVz1MXXcyqCWHA7BEk4QrO
 6El24Ha8qffPsln2rsC54uxKyGja5ijxtET+i+EAPtM8nUEeElEw==
X-Received: by 2002:a05:6a00:1817:b0:836:3f6a:3e77 with SMTP id
 d2e1a72fcca58-8415f17db99mr2413487b3a.17.1779430212861; 
 Thu, 21 May 2026 23:10:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:1817:b0:836:3f6a:3e77 with SMTP id
 d2e1a72fcca58-8415f17db99mr2413404b3a.17.1779430211404; 
 Thu, 21 May 2026 23:10:11 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm807951b3a.18.2026.05.21.23.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:10:11 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 22 May 2026 11:39:35 +0530
Subject: [PATCH 7/7] doc: add fvupdate_to_fit.py documentation and example XML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260522-capsule-v1-7-ff0ac9978d48@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
In-Reply-To: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779430171; l=16446;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ywJgz7IlSQc8z7m5neSa7VN+f+ai5ND0l7XneWm5k+I=;
 b=WelpK/vHVpU1aBd/b9Ep8aEGEWVgfw2ntBRqnzgkHr4KcYwu+qkQnb7AP3hO/wjNeGSTjlQ5Q
 NWwfmEAxEzxDq684njcmGby0PD50o4ZbJeGExgFWcG1xDtKCKpHR5eW
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfXyBN+QENMe6W0
 YgnysRehrUpjH6sVpCTbrKTZoHK406x5rhF1HPu3DMrXZdAEn7jr0q8dNaXpS9A9aroHKosjJOi
 Hrqg+irGhsSg4JKceHmb+ARfgDTT8DVUF9eDQiGcLJlRuLbu76pgMOxcwwyeCgNJlF8oUyGj1Zl
 fOUO7mU2FNp4rowqIBl7cFoY0HLU/s0cV9OK/QQAODQ5Qc2HDYnK70zvqpw6Ts9EGA51B7i89Q4
 G3cpDHFG5LnnWrNMO0FhGyJdVN3EwWOBb8vYpVpAuTHvufsa8VltD0kNpl98TOx5hGuELFW5u1e
 avj5VRHFK8cAf2Dk9JOQrTP2+e1hwgPRxLdD94ARP5v1GyBCpmYH2ojcrGPYVsauFp96clYRXpY
 kAgPduk2G37cTTsxZSpmkyNu8PWKmIVxH3n2ikwe2/FMqkFfSNFZxZ1du5ZzQAYj8OvSp029SSS
 yQe+4v3FhkKCrLfMtWQ==
X-Proofpoint-ORIG-GUID: Tw_fXKV88_ZJmtgBLsWUs6zUhBoA5wcK
X-Proofpoint-GUID: Tw_fXKV88_ZJmtgBLsWUs6zUhBoA5wcK
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0ff346 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0geIkQ0Jow-a3QnHvScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220059
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

Add comprehensive documentation for the fvupdate_to_fit.py tool that
converts Qualcomm FvUpdate.xml files to FIT capsule images. The
documentation covers usage, command-line options, deployment workflow,
and troubleshooting guidance.

Include an example FvUpdate.xml file demonstrating the expected XML
structure with UPDATE operations for multiple firmware partitions.

The documentation provides complete end-to-end guidance from XML
conversion through capsule deployment in U-Boot, including board-
specific GUIDs for QCS615, QCS6490, and Lemans platforms.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 doc/develop/fvupdate_to_fit.rst                  | 487 +++++++++++++++++++++++
 doc/develop/fvupdate_to_fit/example_FvUpdate.xml |  43 ++
 2 files changed, 530 insertions(+)

diff --git a/doc/develop/fvupdate_to_fit.rst b/doc/develop/fvupdate_to_fit.rst
new file mode 100644
index 00000000000..ef29587198f
--- /dev/null
+++ b/doc/develop/fvupdate_to_fit.rst
@@ -0,0 +1,487 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+
+FvUpdate.xml to Capsule Converter
+==================================
+
+This Python script provides complete end-to-end conversion from Qualcomm FvUpdate.xml files to ready-to-deploy EFI capsule files for U-Boot capsule updates.
+
+Overview
+--------
+
+The script offers two modes of operation:
+
+1. **FIT-only mode**: Converts FvUpdate.xml to FIT images
+2. **Complete mode**: Full workflow from XML to final capsule file
+
+The complete workflow includes:
+
+- FvUpdate.xml parsing and validation
+- FIT image generation
+- Final capsule creation with provided GUID
+- Auto-installation of missing tools
+
+Features
+--------
+
+Core Functionality
+~~~~~~~~~~~~~~~~~~
+
+- **XML Parsing**: Extracts UPDATE operations from FvUpdate.xml
+- **Binary Validation**: Ensures all referenced binary files exist
+- **ITS Generation**: Creates Image Tree Source files with proper node naming
+- **FIT Compilation**: Uses mkimage to generate FIT images
+- **Capsule Creation**: Creates final capsule files using mkeficapsule with provided GUID
+- **Tool Management**: Auto-installs missing tools (mkimage, mkeficapsule)
+
+Compatibility
+~~~~~~~~~~~~~
+
+- Qualcomm U-Boot capsule update system
+- Multi-partition firmware updates
+- FIT-based capsule payloads
+- EFI Firmware Management Protocol (FMP)
+- DFU backend integration
+
+Usage
+-----
+
+FIT Image Only
+~~~~~~~~~~~~~~
+
+Creates only system.fit::
+
+    ./fvupdate_to_fit.py FvUpdate.xml
+
+Complete Capsule Workflow
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Creates system.fit and firmware.capsule::
+
+    ./fvupdate_to_fit.py FvUpdate.xml \
+        --mkeficapsule <path_to_mkeficapsule_tool> \
+        --guid <guid_of_the_board> \
+        --fw-version <version_of_the_capsule_payload_in_0.0.A.B_format>
+
+Additional Examples
+~~~~~~~~~~~~~~~~~~~
+
+With custom output names::
+
+    ./fvupdate_to_fit.py FvUpdate.xml \
+        --mkeficapsule /path/to/mkeficapsule \
+        --guid 12345678-1234-5678-9abc-123456789abc \
+        --fw-version 0.0.1.0 \
+        --output custom.fit \
+        --capsule-output custom.capsule
+
+With verbose output::
+
+    ./fvupdate_to_fit.py FvUpdate.xml \
+        --mkeficapsule /path/to/mkeficapsule \
+        --guid 12345678-1234-5678-9abc-123456789abc \
+        --fw-version 0.0.1.0 \
+        --verbose
+
+With Capsule Signing
+~~~~~~~~~~~~~~~~~~~~
+
+Creates a signed capsule::
+
+    ./fvupdate_to_fit.py FvUpdate.xml \
+        --mkeficapsule /path/to/mkeficapsule \
+        --guid 12345678-1234-5678-9abc-123456789abc \
+        --fw-version 0.0.1.0 \
+        --monotonic-count 1 \
+        --private-key keys/CRT.key \
+        --certificate keys/CRT.crt
+
+Command Line Options
+--------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 20 50 30
+
+   * - Option
+     - Description
+     - Default
+   * - ``xml_file``
+     - Path to FvUpdate.xml file
+     - Required
+   * - ``--guid``
+     - GUID value of the board (enables complete mode). Board-specific GUIDs: qcs615: ``9FD379D2-670E-4BB3-86A1-40497E6E17B0``, qcs6490-rb3gen2: ``6f25bfd2-a165-468b-980f-ac51a0a45c52``, lemans-evk: ``78462415-6133-431c-9fae-48f2bafd5c71``
+     - Required
+   * - ``--mkeficapsule``
+     - Path to mkeficapsule binary
+     - Required
+   * - ``--fw-version``
+     - Firmware version in "0.0.A.B" format (e.g., "0.0.1.0")
+     - Optional
+   * - ``--monotonic-count``
+     - Monotonic count for capsule signing
+     - Optional
+   * - ``--private-key``
+     - Path to the private key for signing
+     - Optional
+   * - ``--certificate``
+     - Path to the certificate for signing
+     - Optional
+   * - ``-o, --output``
+     - Output FIT image name
+     - system.fit
+   * - ``-c, --capsule-output``
+     - Output capsule file name
+     - firmware.capsule
+   * - ``-v, --verbose``
+     - Enable verbose output
+     - Disabled
+   * - ``-h, --help``
+     - Show help message
+     - \-
+
+Requirements
+------------
+
+System Requirements
+~~~~~~~~~~~~~~~~~~~
+
+- Python 3.6+
+- Linux system with package manager (apt, yum, dnf, or pacman)
+- sudo access for tool installation
+
+Required Tools (Auto-installed)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- U-Boot tools (mkimage, mkeficapsule)
+
+Required Files
+~~~~~~~~~~~~~~
+
+- FvUpdate.xml file
+- Binary files in Images/ directory
+- GUID value for the target board (for complete mode)
+
+Installation
+------------
+
+1. Make the script executable::
+
+       chmod +x fvupdate_to_fit.py
+
+2. The script will auto-install missing tools on first run
+
+File Structure
+--------------
+
+The script expects the following directory structure::
+
+    project/
+    ├── FvUpdate.xml
+    ├── Images/
+    │   ├── xbl.elf
+    │   ├── uefi.bin
+    │   └── boot.img
+    └── fvupdate_to_fit.py
+
+Example FvUpdate.xml
+~~~~~~~~~~~~~~~~~~~~
+
+An example FvUpdate.xml file is provided for reference:
+
+.. literalinclude:: fvupdate_to_fit/example_FvUpdate.xml
+   :language: xml
+
+This example demonstrates the XML structure with UPDATE operations for
+multiple firmware partitions.
+
+XML Structure Requirements
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The tool only processes the following XML elements:
+
+**Required Elements:**
+
+- ``<FwEntry>`` - Container for each firmware entry
+- ``<InputBinary>`` - Binary filename (must exist in Images/ directory)
+- ``<Operation>`` - Must be "UPDATE" to be processed
+- ``<Dest>/<PartitionName>`` - Target partition name (case-sensitive)
+
+**XML Structure:**
+
+.. code-block:: xml
+
+   <?xml version="1.0" encoding="utf-8"?>
+   <FVItems>
+     <FwEntry>
+       <InputBinary>firmware.bin</InputBinary>
+       <Operation>UPDATE</Operation>
+       <Dest>
+         <PartitionName>partition_name</PartitionName>
+       </Dest>
+     </FwEntry>
+   </FVItems>
+
+**Notes:**
+
+- The tool hardcodes the Images/ directory for binary files
+- Only entries with ``<Operation>UPDATE</Operation>`` are processed
+- Partition names are case-sensitive and must match U-Boot partition discovery
+
+Output Files
+------------
+
+Complete Mode
+~~~~~~~~~~~~~
+
+- ``system.its`` - Image Tree Source file (kept)
+- ``system.fit`` - FIT image (kept)
+- ``firmware.capsule`` - Final capsule file (ready for deployment)
+
+FIT-only Mode
+~~~~~~~~~~~~~
+
+- ``system.its`` - Image Tree Source file
+- ``system.fit`` - FIT image
+
+Deployment Workflow
+-------------------
+
+After generating the capsule:
+
+1. **Copy capsule to boot partition**::
+
+       cp firmware.capsule /boot/
+
+2. **Deploy in U-Boot**::
+
+       => fatload mmc 0:1 $loadaddr firmware.capsule
+       => efidebug capsule update $loadaddr
+
+Technical Details
+-----------------
+
+FIT Image Structure
+~~~~~~~~~~~~~~~~~~~
+
+- **Node Names**: Match partition names (e.g., ``xbl_a``, ``uefi_a``)
+- **Image Type**: All images marked as "firmware"
+- **Hash Algorithm**: SHA256 for integrity verification
+- **Configuration**: Single config referencing all firmware images
+
+Capsule Structure
+~~~~~~~~~~~~~~~~~
+
+- **GUID**: Provided via --guid option
+- **Index**: Always 1 (required for FIT capsules)
+- **Payload**: FIT image containing all firmware
+- **Version**: Optional firmware version (in 0.0.A.B format) via --fw-version, encoded as (A << 16 | B)
+- **Signing**: Optional signing with monotonic count, private key, and certificate
+
+FMP Driver Compatibility
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The provided GUID must match what the FMP (Firmware Management Protocol) driver expects:
+
+- Uses actual partition names from FvUpdate.xml
+- Compatible with Qualcomm capsule update flow
+- Works with ``fit_update()`` processing
+
+Error Handling
+--------------
+
+Comprehensive error handling with fail-fast approach:
+
+- Missing XML files or invalid format
+- Missing binary files in Images/ directory
+- Tool installation failures
+- Capsule creation failures
+- Invalid GUID format
+
+Example Output
+--------------
+
+Complete Mode
+~~~~~~~~~~~~~
+
+::
+
+    Converting FvUpdate.xml to capsule...
+    ============================================================
+    Installing missing tools...
+      Installed u-boot-tools ✓
+    Parsing XML file: FvUpdate.xml
+    Found 3 FwEntry elements
+      Added: xbl_a -> xbl.elf
+      Added: uefi_a -> uefi.bin
+      Added: boot_a -> boot.img
+    Successfully parsed 3 UPDATE entries
+    Validating binary files...
+      xbl.elf: 524288 bytes
+      uefi.bin: 1048576 bytes
+      boot.img: 2097152 bytes
+    All binary files validated successfully
+    Generating ITS file: system.its
+    ITS file generated successfully
+    Compiling FIT image: system.fit
+    Running: mkimage -f system.its system.fit
+    FIT image compiled successfully: 3670016 bytes
+    Using GUID: 12345678-1234-5678-9abc-123456789abc
+    Creating capsule: firmware.capsule
+      Encoded Firmware version: 65536 (from 0.0.1.0)
+      Command: mkeficapsule -g 12345678-1234-5678-9abc-123456789abc -i 1 -v 65536 system.fit firmware.capsule
+    Capsule created successfully: 3670144 bytes ✓
+    ============================================================
+    SUCCESS: Complete capsule workflow completed!
+
+    Files created:
+      ITS file: system.its
+      FIT file: system.fit
+      Capsule file: firmware.capsule (3.5 MB)
+
+    Capsule GUID: 12345678-1234-5678-9abc-123456789abc
+
+    Ready for deployment:
+      1. Copy firmware.capsule to boot partition
+      2. In U-Boot: fatload mmc 0:1 $loadaddr firmware.capsule
+      3. In U-Boot: efidebug capsule update $loadaddr
+
+FIT-only Mode
+~~~~~~~~~~~~~
+
+::
+
+    Converting FvUpdate.xml to FIT image...
+    ============================================================
+    Parsing XML file: FvUpdate.xml
+    Found 3 FwEntry elements
+      Added: xbl_a -> xbl.elf
+      Added: uefi_a -> uefi.bin
+      Added: boot_a -> boot.img
+    Successfully parsed 3 UPDATE entries
+    Validating binary files...
+      xbl.elf: 524288 bytes
+      uefi.bin: 1048576 bytes
+      boot.img: 2097152 bytes
+    All binary files validated successfully
+    Generating ITS file: system.its
+    ITS file generated successfully
+    Compiling FIT image: system.fit
+    FIT image compiled successfully: 3670016 bytes
+    ============================================================
+    CONVERSION SUMMARY:
+      Input XML: FvUpdate.xml
+      Generated ITS: system.its
+      Output FIT: system.fit
+      Partitions: 3
+        - xbl_a (xbl.elf)
+        - uefi_a (uefi.bin)
+        - boot_a (boot.img)
+
+    ============================================================
+    SUCCESS: FIT image created successfully!
+    Output: system.fit
+
+    To create capsule, run again with:
+       ./fvupdate_to_fit.py FvUpdate.xml --mkeficapsule <path_to_tool> --guid <board_guid> --fw-version <version>
+
+Viewing Generated File Contents
+--------------------------------
+
+FIT Image Contents
+~~~~~~~~~~~~~~~~~~
+
+You can inspect the generated ``system.fit`` file using U-Boot tools::
+
+    # View FIT image structure and metadata
+    mkimage -l system.fit
+
+    # List all images in the FIT
+    dumpimage -l system.fit
+
+Capsule Contents
+~~~~~~~~~~~~~~~~
+
+You can inspect the generated ``firmware.capsule`` file using mkeficapsule::
+
+    # View capsule header and metadata
+    mkeficapsule --dump-capsule firmware.capsule
+
+    # Or using local mkeficapsule binary
+    /path/to/local/mkeficapsule --dump-capsule firmware.capsule
+
+Troubleshooting
+---------------
+
+mkimage not found
+~~~~~~~~~~~~~~~~~
+
+Install U-Boot tools::
+
+    # Ubuntu/Debian
+    sudo apt-get install u-boot-tools
+
+    # CentOS/RHEL
+    sudo yum install uboot-tools
+
+mkeficapsule not found
+~~~~~~~~~~~~~~~~~~~~~~
+
+If you get an error about mkeficapsule not being found, use a locally compiled version::
+
+    # Use local mkeficapsule binary
+    ./fvupdate_to_fit.py FvUpdate.xml \
+        --mkeficapsule /path/to/local/u-boot/tools/mkeficapsule \
+        --guid 12345678-1234-5678-9abc-123456789abc \
+        --fw-version 0.0.1.0
+
+    # Example with U-Boot build directory
+    ./fvupdate_to_fit.py FvUpdate.xml \
+        --mkeficapsule /local/mnt/workspace/bselvana/k2c_le/u-boot_upstream/u-boot_v2025_upstream/tools/mkeficapsule \
+        --guid 12345678-1234-5678-9abc-123456789abc \
+        --fw-version 0.0.1.0
+
+Invalid GUID format
+~~~~~~~~~~~~~~~~~~~
+
+Ensure the GUID follows the format: ``xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx``
+
+Supported Boards and GUIDs
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following Qualcomm boards are supported with their respective GUIDs:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 30 70
+
+   * - Board
+     - GUID
+   * - **qcs615**
+     - ``9FD379D2-670E-4BB3-86A1-40497E6E17B0``
+   * - **qcs6490-rb3gen2**
+     - ``6f25bfd2-a165-468b-980f-ac51a0a45c52``
+   * - **lemans-evk**
+     - ``78462415-6133-431c-9fae-48f2bafd5c71``
+
+
+Example valid GUID format: ``12345678-1234-5678-9abc-123456789abc``
+
+Missing binary files
+~~~~~~~~~~~~~~~~~~~~
+
+Ensure all files referenced in FvUpdate.xml exist in the Images/ directory with correct names.
+
+XML parsing errors
+~~~~~~~~~~~~~~~~~~
+
+Verify FvUpdate.xml is well-formed XML with proper FwEntry structure.
+
+mkeficapsule binary not found
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If you specify a custom mkeficapsule path, ensure:
+
+- The file exists and is executable
+- The path is correct (absolute or relative to current directory)
+- The binary supports capsule creation
diff --git a/doc/develop/fvupdate_to_fit/example_FvUpdate.xml b/doc/develop/fvupdate_to_fit/example_FvUpdate.xml
new file mode 100644
index 00000000000..c1dea8db4a2
--- /dev/null
+++ b/doc/develop/fvupdate_to_fit/example_FvUpdate.xml
@@ -0,0 +1,43 @@
+<?xml version="1.0" encoding="utf-8"?>
+<!--
+/** @file FVUpdate.xml
+
+    This file configures the content of the payload for firmware update
+
+# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+
+**/
+
+#Operation Type
+  IGNORE  - Skip this entry (not processed by fvupdate_to_fit.py)
+  UPDATE  - Include this entry in the capsule
+
+#NOTE: PartitionName is Case sensitive
+
+-->
+<FVItems>
+
+<!--BootLoader entries-->
+
+<!--FwEntry for UBoot-->
+  <FwEntry>
+    <InputBinary>u-boot.mbn</InputBinary>
+    <Operation>UPDATE</Operation>
+    <Dest>
+      <PartitionName>uefi_a</PartitionName>
+    </Dest>
+  </FwEntry>
+
+<!--FwEntry for TZ-->
+  <FwEntry>
+    <InputBinary>tz.mbn</InputBinary>
+    <Operation>UPDATE</Operation>
+    <Dest>
+      <PartitionName>tz_a</PartitionName>
+    </Dest>
+  </FwEntry>
+
+<!--Add FwEntries based on requirement-->
+
+</FVItems>
\ No newline at end of file

-- 
2.34.1

