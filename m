Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8F0C43602
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294A984B0E;
	Tue, 30 Jun 2026 14:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m9PkSmfC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yghanwlg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6EF849FB; Tue, 30 Jun 2026 10:11:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE9184857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CZW61056724
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qng99YalN80LYF0kkFTybsuwaZIMNK5qLjafy12rZdU=; b=m9PkSmfCcDzpML5s
 GLe1fVqcv0UmoNtIX3Dgn/QGvsCcAyMowuwxEupblL6Yiq5/WRgfwmFOdBGHchF3
 SzRv+D+Zevng+b5htPPG4Xz6Vkk0MBXWuuAuM3pcMcc6NVqsaBOnOWStyJ8T7G8y
 xxABWsoQCHFdOIeGn8EwEo/N5HZNHelkWAHc+Qah630SUL4EnsY1EES9bWWGRObq
 p2pDB9MAHsVOzRFDVblIEKuiCGXmCTbtzCgnaXGY1oyTR+ncSgAYOShWN7HW505H
 AllriZBHlHZFL+5S8lQ16ZelmGGwwC43WHKuIWT0/xuj0udEowYngk+90qSBfoXL
 syZR4w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4686116b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:11:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c62861b3bso13299039eec.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782807063; x=1783411863; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qng99YalN80LYF0kkFTybsuwaZIMNK5qLjafy12rZdU=;
 b=Yghanwlgdiszf9P5aOehtE5xe9pbVodPxqyW8tr4GydQgE77vxAUCzv/GEcCz6ZErp
 Rh84TXDT+9OARbfygMC/olCzKU7NdZaYeJbiEcnmU1Qf4tqLgnF+cxlts1d0lrB08C+B
 X7NHS12ubNavMZ5Os+ezJg9pJemLjfJSMTxeQ20Dg/R8rHpXDlnDXQRhHMd1wkrHz7B6
 GD/Hd1ZCwlbxs34lfuCtb5rjfrzJYsILZDkHMIhF6L76doXKiw+Us2qWzg16axPSj2aV
 EkdLlUn4NeQHJF3XJTdI5K/mNrY8vgGYOQ+YeYZHoxubKbYXXazJLqk5V1nyyoOgP2pM
 hOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782807063; x=1783411863;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qng99YalN80LYF0kkFTybsuwaZIMNK5qLjafy12rZdU=;
 b=L+nXGy6pFmYbTjQ7t5n/gFOklwypO5NoSrbOx0S9/t4vQ0E0tDXQCPwhPJHU2opo/y
 Hk9jAPMJd01rqb/zZpoHkm58kcCtUDPLYwzFvIVwMuDFQbdriQNOfLA8kuKQFdaxmeG/
 lOoyZ/j0/AQOxMY4RLnlqDlJC2C3nW+TwgDyWHzXPLiw3aYR4GKl5WRHxprHKvKoh+41
 6dLnFrLeEEQEuZpSv6gCZfypzMDi4SG+mnB/+CPABTHebfL/rzWQNAfqHn/2ROdTqiQ9
 69viWXpaG7CdSPJkE6b5QDTn0/ZmA8+83sYlDtvR28hDmloCqRztfenoLFSvYkeHVgDQ
 cHtQ==
X-Gm-Message-State: AOJu0Yz7Vfgxitawaop7VTbH0ABPbBmrqqQmjFxX4GzFBw1xadDtjV3Q
 yzbVKuB32PdNXWlSIokL9c1let05wUSIeBb5R1BIySz10pqOqOmxRq7aiVlDoV3mjEz7wMgi5Sg
 QuhEH7ZprV1qPnwfMyRbVkxo36qsEgWEGVaZOIRQIuPhs5IAJVgVmlUUd
X-Gm-Gg: AfdE7cmUmVmgQ+/mZcGOa5OIygG29vMO12nODN3nt0e/C/n+HD0X4pT3GrqB+p65G0W
 DhlH40FWB72MDpqfI+TmhJHGcSLzoaRdBzC7hW7aVki/X565NskY7OSmfmwLxY/KVG49JhpZOZa
 aLs44BqVJbLwyO1xGRIk2wKBD9clGtSJuvuZPlRDuHd/0jZOh0bOlEOux3X/LdAyg7Hi62kqtyU
 Hzt1y7tZAhYke0W0sg+tK++VpQgDAV8cL84i1ojyXooZnLNvwja35APytljICtVg5ibOAn63Feb
 T2SQG8vF4QEMTiy8P4RxMc7OTsSlD2zuqMBH9T3w06ulZZrHtQPa+y1n8ShGPclNZENH3Ix4aUQ
 MXFbMZs0GjS39zgJx+pKe0fLT7kLUuLtzSyDPz54aD7wPijuQYd4fVZcxLJPUBYUIF1y1RI/RCx
 rwOxlqx680CGRxUHEAsCXXBZLxKeGD3AIAUr7JbCiV
X-Received: by 2002:a05:7300:4793:b0:30c:ab97:d7b2 with SMTP id
 5a478bee46e88-30ee141382bmr2273698eec.44.1782807063479; 
 Tue, 30 Jun 2026 01:11:03 -0700 (PDT)
X-Received: by 2002:a05:7300:4793:b0:30c:ab97:d7b2 with SMTP id
 5a478bee46e88-30ee141382bmr2273669eec.44.1782807062943; 
 Tue, 30 Jun 2026 01:11:02 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee3264f52sm5415816eec.28.2026.06.30.01.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:11:02 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 13:38:33 +0530
Subject: [PATCH v7 11/11] doc: board/qualcomm: Update RDP build
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-fix-edl-v7-11-1dcb0d2a347c@oss.qualcomm.com>
References: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
In-Reply-To: <20260630-fix-edl-v7-0-1dcb0d2a347c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Peng Fan <peng.fan@nxp.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: raHGr-DjCuTHTSCYk_pjUnwvlobrIC9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX9shDCf6WTpnp
 CXTwVYED4tziafWA/CW3bm0cEd+dKT/CkNYGi0R8eEO4Py7bVBCbtULQ8ahlzbIkWEwB9Q209E5
 fJH7U4yv4RyHEH9TCV1mTqFhQsHBppqPEOoTFxG2Xqa8CWN5dIKq93C90pFUig314IKe0/ACAcz
 efLekkkFEyVDPA1zXP8bIBZD5NI6KqPmrd34NtZRf2SNEdu7ZbAu6NRgqWSXZ7aMLX3Tygj5WbE
 3NHFBUl1wrd3xeIo24AWXJpfWcFnspq/qiPEFUfYl9XL/VdKMDkYtbZP8e5vetOGnzvVlaw9B0f
 +lHframFda55izURYDT4n6EGQ0F0JYG/+rdUZ7T5mOkaKy9xyWyJk4tGBvms/MS4m8zNPbS5o1y
 k1A/kfs2rRjyAeCvlkVA0cPyj5ULQZO+dfGo5cEgf61t2jDbIa0bi9R+CeFT5JMM0UFIKQzm90n
 DwB7v8VyA/akLd+akKw==
X-Proofpoint-GUID: raHGr-DjCuTHTSCYk_pjUnwvlobrIC9Y
X-Authority-Analysis: v=2.4 cv=FbcHAp+6 c=1 sm=1 tr=0 ts=6a437a18 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=FmD-qdgRN1vrldnJjaMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX7nfTrGNJf+S2
 1RdP8U4QMiwx1h0IxEKwj+ZZ4Vc8SFhSoeXrLL+FngAoJ5ok8LEX6CvHFUQX2ibJT1BuS67bGIu
 Pc8tYTH7UTgANc1E8sQD8S5J3l31vGU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
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

Add details about the SPL & U-Boot proper build steps, converting to
flashable images, source URLs for the needed binaries and scripts.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 doc/board/qualcomm/rdp.rst | 96 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 4 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..7e3608a0e76 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -24,13 +24,17 @@ This will build ``u-boot.elf`` in the configured output directory.
 The firmware expects the ELF images to be in MBN format. The `elftombn.py` tool
 can be used to convert the ELF images to MBN format.
 
-	IPQ9574: (MBN version 6)
+IPQ9574: (MBN version 6)
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
+.. code-block:: bash
 
-	IPQ5424: (MBN version 7)
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v6
 
-		$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+IPQ5424: (MBN version 7)
+
+.. code-block:: bash
+
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
 
 Then install the resulting ``u-boot.mbn`` to the ``0:APPSBL`` partition
 on your device with::
@@ -42,6 +46,81 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
+--------------------------------------------------------------------
+
+Please refer to the following URLs for more details about the platforms.
+
+	F8: https://www.qualcomm.com/networking-infrastructure/products/f-series/f8-platform
+
+	N8: https://www.qualcomm.com/networking-infrastructure/products/n-series/n8-platform
+
+1. Since U-Boot SPL is enabled on these platforms, the build command generates
+   both the U-Boot SPL and U-Boot proper images. Assuming ${uboot_dir} is the
+   top of the U-Boot sources and ${out_dir} as the output directory,
+
+.. code-block:: bash
+
+    cd ${uboot_dir}
+    export CROSS_COMPILE=<aarch64 toolchain prefix>
+    make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
+    make -j8 O=${out_dir}
+
+U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
+U-Boot image:	${out_dir}/u-boot.elf
+
+2. Convert the SPL image to multi ELF
+
+.. code-block:: bash
+
+    cd ${out_dir}/spl
+    python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
+    python `create_multielf.py` -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
+					-o u-boot-spl.melf
+
+This u-boot-spl.melf should be flashed into 0:SPL partition.
+Please see below for the location of `tmel-ipq52xx-patch.elf`
+
+3. Convert the U-Boot image to bootloader image
+
+.. code-block:: bash
+
+    cd ${out_dir}
+    python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+
+The u-boot.mbn has to be combined with `qc_config.elf`, `QCLib.elf`, `TFA`
+and `OPTEE`. Please see below for the location for these ELFs. TFA and OPTEE
+can be built from the sources using the following commands
+
+TFA:
+
+.. code-block:: bash
+
+    make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
+
+OPTEE:
+
+.. code-block:: bash
+
+    make PLATFORM=qcom-ipq52xx -j16
+
+These binaries can be combined into a flashable image using `gen_its.py`.
+
+.. code-block:: bash
+
+	python gen_its.py --arch ipq5210		\
+		--qclib_path `QCLib.elf`		\
+		--qcconfig_path `qc_config.elf`		\
+		--tfa_bl31_path bl31.mbn		\
+		--uboot_path u-boot.mbn			\
+		--optee_path tee-raw.mbn		\
+		-p qcconfig qclib			\
+		-P tfa_bl31 uboot optee			\
+		-o output/hm_503_test_uboot.img		\
+		--template `template.its`
+
+This should be flashed into 0:BOOTLDR partition.
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
@@ -54,5 +133,14 @@ U-Boot should be running after a reboot (``reset``).
 	Note that the support added is very basic. Restoring the original U-Boot
 	on boards with older version of the software requires a debugger.
 
+.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
 .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
+.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _template.its: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf

-- 
2.34.1

