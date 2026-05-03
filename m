Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DB6FF885A
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 04:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D7FE83EF9;
	Sun,  3 May 2026 06:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i/D7IG9o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MQBQwLj2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452FD83FEC; Sun,  3 May 2026 06:34:25 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6988C80F0E
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 06:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 642KU2hn3609303
 for <u-boot@lists.denx.de>; Sun, 3 May 2026 04:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HX9yff+YUiMQ1gQRgynu5t
 rcsEnHV41esBfzNGQZ/LE=; b=i/D7IG9ovMY/BRWLtuIAs63XFi/8YIQAuQZVzp
 x4DkUySv94HsDMEdfVjkz+1wmJVFamSMtiFe/2SWjJO9yvKiayoIiELOysCDgJz9
 L879sakoba1aiX7v05DemFz/aY+YtbkZpH+z/X2JsAfzAksuyGk0krpLTR8jl7Dl
 sl0GdGbcMoE4JJJBIQEMzc30xWpmHrj8A5Rvi07b1Y3bOiI0xjsphBK8OHNVTHcW
 XODyiwEbgLXM4H/+xzoIpKQZJTrMcB//r0OW0oSzS5eQ4dggUmHhYt1P7jgJHXRo
 rr4uBfhDgmMIxV3iS0eZflKtEuevE+xGogKe15r484Jub2nw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3j6we-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 04:34:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b7c2ee830aso67307115ad.3
 for <u-boot@lists.denx.de>; Sat, 02 May 2026 21:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777782859; x=1778387659; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HX9yff+YUiMQ1gQRgynu5trcsEnHV41esBfzNGQZ/LE=;
 b=MQBQwLj2L1+fwVbwTkREH24zFYCG6rFVLFP6nURkvOq3/AekILyI6/Xj6wcXdUIRpq
 ID0euvZtv2ier7THwRcAQvFmtfZrJCRH0o6AGnyB7w2c1nyPBLn0MamxFuWqdipIrhxa
 oyUo7UjWjjf7wXcRrT0NETGqFlUMkyjNjXvrhlC65lFXQEc++Y8ybJWlEI5V4GfEqixz
 bBIzVUo2fcqFLPl2VSDZt4MC+3a+7xMg6GC1CR6sYNvnr3MiNZKwftBJb22pm+Li580E
 oYzPxg1IDHf3pVsl7obAVzo+Uq0+Ssv7YTQ2wm8x3cgXVKa8bi3IbyMnYN4sVRSPMKqf
 l0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777782859; x=1778387659;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HX9yff+YUiMQ1gQRgynu5trcsEnHV41esBfzNGQZ/LE=;
 b=msdL0bks1oK3uie0jqH1H0yOERMaphI8z7Gku0mjtouJbncuYXrIYlpPjFoiVDKVvZ
 LwtPQHlC1yV5iFR0EUv0rpIjphImLJOx7uDAw/IirHJlPjeVN2+zvOJS9EzNsyPvRfcj
 TuCeSBfCtAAT4AY8kkZwvHu9Yu8Ogjpe9q33AhZ6JUVLdt+AzJvwLgmEo+p4qenBHO01
 BdvlgwyKJmI9nCMXTbUsAWRCcVZYM5FpwAPyhggkp3anXqJ1hOMFCYTBQLO4YjB73usB
 Rs/pBnbV0guBif/84oOabJcqjagjpd9mxfoTQztdg333vh7/uLvw0PSOP8QI3Ba71Fcy
 ruig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mHJ2EbJXfypOpsuOFJEScnHaGrG1iGGmIMdvixNLjAniLsxPardVjm5oW0sa3dBkNz/+fcA8=@lists.denx.de
X-Gm-Message-State: AOJu0YzNT1tl+RYH64Zqb7ntCIBuQhdb0BT27ZyfNOaW3qJP0PH7c6VN
 LuafnvlFnB1FYbpjHmoyYg4wTeJxAUcEkkQCSb8enYIzPpQkb6dZ04vkn71ZgB2vnKGHkWOXMq5
 SpWma6SR4IxYxENP5OKvYM32iPOiVtb5M00MNk2oQ8tCgQCuCcBiHZB7i
X-Gm-Gg: AeBDietyAdyO5I/WgtBXONAAlwkUcOlrcRXuOOZ+3H+GuProbwo7P6nECXoxfJFQDFG
 cL2LDHfTtQ99lk4/t3Pp9ve7Mqhl6MGi9ahVBCzviit/TQVNXZoFPCpUWKW46sQHoc4mnT0Asws
 j+tnpkspVESayb5bwW4RrZw7RaeLMmap+IWmMkZsxpL7iOglUMouF7yCUoDYkG9a1E1IwV1qi0z
 h9fnRI6O9wUQjGPILt3+WzkTY8woJBo51bX4gAfRv7ZdY3Y/0GasFN4fzRNfCjpEIivjZ0ei3cF
 0BfYUA0OjqnRsuNvb3syps0ZhX5E/Rv34v3RM8gd/yBtmlgrVJbzDIjWPgPFCB7pw8c6HrSPlTt
 st5LEsAJMhnT8/qV0TlO0g+fLtj+3tspG5pB0OA+s5rNIKM5f5MtHmCCrvfTs4EtGvDweE6t5fG
 NZiUhupNZeVu9WvLQhFQADpzifPITsXHtdu+hOkvOyJoJxf9Y2J0xp9fD7EXad
X-Received: by 2002:a17:902:7c0a:b0:2b4:5cd0:b6c3 with SMTP id
 d9443c01a7336-2b9f2609371mr34142655ad.29.1777782858625; 
 Sat, 02 May 2026 21:34:18 -0700 (PDT)
X-Received: by 2002:a17:902:7c0a:b0:2b4:5cd0:b6c3 with SMTP id
 d9443c01a7336-2b9f2609371mr34142535ad.29.1777782858036; 
 Sat, 02 May 2026 21:34:18 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caa7e44bsm64716955ad.11.2026.05.02.21.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2026 21:34:17 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 03 May 2026 10:04:12 +0530
Subject: [PATCH] doc: qcom: dragonwing: Improve build and installation
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-iq9-v1-1-0eb29e4f8dc8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEPQ9mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNj3cxCS10LMwsDS8NEE3MTSzMloMqCotS0zAqwKdGxtbUAMUkIc1U
 AAAA=
X-Change-ID: 20260503-iq9-868091a47496
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777782854; l=5511;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hy09lbbk0dLjZADLcL1adWthXd1yFoCMZ4IYL0hy4mU=;
 b=TeVsRqkbwFcX4Hn5KQ8OIN/DwD6Qw8iCxpgoJ5uuDr7ObSs5sMhLq4bv8H8DtgH5PqYQgG3by
 btZKHWMmVMwBJz3KrsXltdl7f87MpLKsgDHM5O2izvzTyXBU62ieRMT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAzMDA0MyBTYWx0ZWRfX0MBOK/tC7rPZ
 mcuZcKug+lu8+qC1f2S/u05LlsEykAAzWvHk/T7jywrNG+TUKjRxAc9fDk2kkXL5LwqFSwVUQYf
 zspAEWfBBXLizvqBq1CugcK6ptuPcqsi/MrkWyO0frCxjTEoNnGXGrftEmmopBzfKajENT9orzj
 HkqzZQETQMGdPA0pkjcs3l+9iyhEymvBGQyJH3LH9pMp2tc7NkEgidNmiPdL60WNAhFLfHVsSYR
 Flm1CjSmbGUA9LLlez+knZsz6TsCbsDZS8HlapUAnXEq96Sq4KtMxc0eOeA+XcI/+LK+FFl0GyP
 bOsDNkzcjIarvB78X4HuPkRaLkPGmTHCDiZ5kODH+8fJ1o0HpK/yC31YucqTEJp5lXmDsoutdxp
 4BLvrFn4ne5tSO/9weBvU7y3q54BcO2HyJV48cN0wu5jiady822LM0LfviZw3oXTHdl5LtUX2/U
 zEiI+WCtANZsFLFnK8A==
X-Proofpoint-GUID: ej5Dm8WBdtaJWt8K174Q05Gq2ZpataIq
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f6d04b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=WtK8poceb6KjsvSHWLYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: ej5Dm8WBdtaJWt8K174Q05Gq2ZpataIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-03_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605030043
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

Enhance the Qualcomm DragonWing board documentation with clearer
and more detailed build instructions.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 doc/board/qualcomm/dragonwing.rst | 112 +++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 14 deletions(-)

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index d4899415309..fbb50a90290 100644
--- a/doc/board/qualcomm/dragonwing.rst
+++ b/doc/board/qualcomm/dragonwing.rst
@@ -4,9 +4,11 @@
 Qualcomm DragonWing
 ========================================
 
-Qualcomm DragonWing are industrial-grade boards that provides various series
-of processors such as IQ6 (QCS615), IQ8 (QCS8300) and IQ9 (QCS9100).
-These SoCs are used for factory/industry based applications.
+Qualcomm DragonWing boards are industrial-grade platforms targeting factory
+and edge applications. They span multiple product families, including
+IQ6, IQ8, and IQ9, which are based on Qualcomm QCS615, QCS8300, and
+QCS9100 series SoCs respectively
+
 More information can be found on the `Qualcomm's IQ6 product page`_,
 `Qualcomm's IQ8 product page`_ and `Qualcomm's IQ9 product page`_.
 
@@ -16,33 +18,115 @@ More information can be found on the `Qualcomm's IQ6 product page`_,
 
 Installation
 ------------
-First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``QCS615``, ``QCS8300`` or ``QCS9100``::
+
+Prerequisites
+~~~~~~~~~~~~~
+
+Download the qtestsign utility:
+
+.. code-block:: bash
+
+  $ git clone https://github.com/msm8916-mainline/qtestsign qtestsign
+
+Build Steps
+~~~~~~~~~~~
+
+Download the U-Boot source code. See the :doc:`../../build/source` documentation
+for instructions on obtaining the U-Boot source.
+
+Go to the U-Boot source directory:
+
+.. code-block:: bash
+
+  $ cd u-boot
+
+Configure the build for desired platform. This command creates the required
+configuration files in the .output directory. Following gives command for each
+platform (choose based on your platform):
+
+Generate the default configuration for the IQ-615 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_qcs615_defconfig
+
+Generate the default configuration for the IQ-8 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_qcs8300_defconfig
+
+Generate the default configuration for the IQ-9 platform:
+
+.. code-block:: bash
+
+  $ make O=.output qcom_qcs9100_defconfig
+
+Build U-Boot using the cross compile toolchain. First, setup ``CROSS_COMPILE``
+for aarch64:
+
+.. code-block:: bash
 
   $ export CROSS_COMPILE=<aarch64 toolchain prefix>
-  $ make qcom_qcs8300_defconfig
-  $ make -j8 u-boot.mbn
+
+Compile the U-Boot source using the GCC cross compile toolchain:
+
+.. code-block:: bash
+
+  $ make -j8 CROSS_COMPILE=<aarch64 toolchain prefix> O=.output
+
+.. note::
+   Some toolchains may treat incompatible pointer types as errors.
+   The extra KCFLAGS argument can be used to work around this when needed:
+
+   .. code-block:: bash
+
+     $ make -j8 KCFLAGS+=" -Wno-error=incompatible-pointer-types" CROSS_COMPILE=<aarch64 toolchain prefix> O=.output
+
+Expected result:
+
+- The U-Boot build completes without errors.
+- The ``u-boot.elf`` file is available in the ``.output`` directory and is ready for further packaging or flashing.
+
+Convert U-Boot image (ELF to MBN)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Although the board does not have secure boot set up by default,
 the firmware still expects firmware ELF images to be "signed". The signature
 does not provide any security in this case, but it provides the firmware with
 some required metadata.
 
-To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+Move to .output folder:
 
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
+.. code-block:: bash
+
+  $ cd .output
+
+Generate the signed MBN image. To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_:
+
+.. code-block:: bash
+
+  $ python <qtestsign path>/qtestsign.py -v6 aboot -o u-boot.mbn u-boot.elf
+
+This command generates the signed u-boot.mbn file required for flashing.
 
 Then flash the resulting ``u-boot.mbn`` to the ``uefi_a`` partition
-on your device with ``fastboot flash uefi_a u-boot.mbn``.
+(or the appropriate UEFI partition for your board):
 
-U-Boot should be running after a reboot (``fastboot reboot``).
+.. code-block:: bash
+
+  $ fastboot flash uefi_a u-boot.mbn
 
-Note that fastboot is not yet supported in U-Boot on Dragonwing boards, as a result, to flash
-back the original firmware, or new versoins of the U-Boot, EDL mode must be used.
+U-Boot should be running after a reboot (``fastboot reboot``).
 
 A tool like bkerler's `edl`_ can be used for flashing with the firehose loader (for example, for QCS9100
-the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`.) ::
+the firehose loader can be obtained from `dragonwing IQ9 bootbinaries`).
+
+For example:
+
+.. code-block:: bash
 
-$ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
+  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn
 
 .. _qtestsign: https://github.com/msm8916-mainline/qtestsign
 .. _edl: https://github.com/bkerler/edl

---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6
change-id: 20260503-iq9-868091a47496

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

