Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC3DCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD34584A51;
	Tue, 23 Jun 2026 08:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iOHq8kuz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4Ki10/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5097F849BD; Tue, 23 Jun 2026 08:50:36 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9416800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6d78n3376107
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=d/hnJ4pA8VJ
 IGjSUaW7pofYFj88sJsj9nWBA2MesToA=; b=iOHq8kuzS7QtYf9ZhGVou6mh90X
 TV2KOklK0GetvKp/ZtPhkti0hXl7noyvVq+nFapFq5mkoAMHSyO8+OwZt56eCD1V
 O1ytVWZu3MV9szkAzC2TKhds7XJ8TVxQ8aBz4cCQZvaHuBnrMLQYzSlgeF8RZEoy
 Gbv3FgN0b5yKBm4pIO+kDmSe3c6TT8vM+mWQ82IQV5JGWa0fGI+GNMBTTQ50HxQ6
 vqs2Aeh9e8cf5mFv6X0xaxIEJRcBJRT4FOgGMixJb+JvKPFj9HlFMmLA2+3xuBO0
 F97OE5LoasX834dmzirCj6M0EaMKmsQ2nEZ8SDg5pHyPTM8Rorf8yLeIttg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5yebb7x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:50:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-37d4f23eb37so4254003a91.0
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 23:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782197431; x=1782802231; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d/hnJ4pA8VJIGjSUaW7pofYFj88sJsj9nWBA2MesToA=;
 b=P4Ki10/bBiy7GHC5Lk+OOpHyw7smsa4y3rB2aqScxLt+0fecKMtGspx7P0DO+QUaNA
 Z0rULLCQNNbYo9OPx6MVsQCwEvH26eEbcuLV+aBIGLz8mXSGZrlAsrnqErjIWKw/u3hK
 JsfNDcaI2MMeo6O5JXpcUCxsuuq3LX7oAHgJs71PdcIKC1rzX948qLTau0rpAoRMVh9n
 YZiRm1g7Gu6JEXBnB8dfiMUSyrZJVpEMtUnOgqBovLsoeIG8pg57sBa8aRIRGawbHKDJ
 KUi1duPCk6q8ByCcFG3sfm0xMYsA5JDnzatxZqX7AbVETB41sdZaWxSRpxerGQwQzkCW
 XTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197431; x=1782802231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d/hnJ4pA8VJIGjSUaW7pofYFj88sJsj9nWBA2MesToA=;
 b=TctimXf3VWxV8PGYMiKufwm5oSlMiPq8MrLZ8dIdWFcsFPs4GCL7zHvs2KqMLVBceA
 zsj5ReiSxK/UuG5ziiLvvSUCiaQysVwa6v209gs+3kMIFmhclkq2hK5OIZYaUU1LvPZE
 OpZ0hzu/JfY8qV6q9/h/7ad1MAgy/qoqrWzq/d2+fp8uKiHtZStY08YnxyLqzXPRGm+t
 zwR+nUdvDfcDgBrJefAp5cXs0oZwjqu5Exilm1W/jqpF65tway/m8+pKJzUvT0vIZfef
 tn+uoEAnB1MxqCYKYb62GAPV+YR66mVAAafvjlanFSmZgOIPLiVsj6zHpSYf1yYNBBjx
 p1FA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqdg1/r09dKSotfcJ+czBVMU+jFZ0at4B++tsOai2MC3otxBdY+B0h8MNxatX8Yf4VzpiESFW4=@lists.denx.de
X-Gm-Message-State: AOJu0YzwNSkqx1xkdVdrB21Y9R+ZpcvYwNYSmeONWBWW3AcOyMJBvhc2
 B6Z+sBnvw4JtvXuhsI5rup4Dmn2S7jfIM4lO85KhWDEeNuyf0Pbcah9qItd+po1duKZdwUJqBW8
 GMNwISdTQeazmpq2fEuBm6vTNqiFYxARnCrUy0MBiIvqqBOZfsLrbJ1bo
X-Gm-Gg: AfdE7clHHf0Fnv62lMqbS8oncDOcDwZm5Z56NIrjeYn7bf0mKlzUsiZYLxosauKFSuJ
 56ej5BzLeNvE2x9tF8mY2DRzhqvH6EuIzQ0JMHgM1gAagqsl6Kih7YjrAm4bwgbx+ds0DWuuf2k
 XzDd2c5p9SAQIkNn6sH97w5+msmIEmmfXUSuSorx2acRCRWzX6VZOZa29vie7tid+qPJFQ7kDWt
 G+cHxmAC5qnjeJsgXEbvygL1sA32rVTyoo/0DSwf0a8im4Chi0ch2Ymg6UQvXy3k37kq93tUUz0
 EROBDvmjqVdaCOlAWpoYCntt/UrqyE+yAERW6xoAsgFToDB/OQuaa2lg69RwFUr+KebE5qBCn87
 /2p8P7XUPEKNLlvRwFvJrx5pi8YJFUADwM6SjhbrgynDoxZ9VUBrq/3wnbH1fXphar8h3aL3qvn
 IrHhQn9LFdZrSuPHPZvZ2xR4mKUofuPxstd8bstq9t
X-Received: by 2002:a17:90b:2b46:b0:36d:6315:1de4 with SMTP id
 98e67ed59e1d1-37dd0dcb335mr2001054a91.17.1782197431062; 
 Mon, 22 Jun 2026 23:50:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2b46:b0:36d:6315:1de4 with SMTP id
 98e67ed59e1d1-37dd0dcb335mr2000996a91.17.1782197430520; 
 Mon, 22 Jun 2026 23:50:30 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37d4eede23esm8951704a91.2.2026.06.22.23.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 23:50:29 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, varadarajan.narayanan@oss.qualcomm.com,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v6 11/11] doc: board/qualcomm: Update RDP build instructions
Date: Tue, 23 Jun 2026 12:18:04 +0530
Message-Id: <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rAGjmN9h6k6bx3oEwFG5xQYaI7B9FdWf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX1Ko9h3JSKVFx
 KraD1apFtuIwhIRrldMUWHPGO4d+NcURRsYQNNqrOzuGxVBBVRzOZkRoQ4RxoquCda1UdCfpDtb
 SYo4bG1lskOyWLD9VBahKIuDzZhmPFc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfXyIQCAPZV8FVI
 7N8JZoqzZN/cyAZRRhRgl6P5BwbmtStu7ndoRjd01HnokSZxCp8GDrD3IFsdRW2ekCG/8eEQzAm
 5UxgTeTBGc7GeCSBkIUVjM2ExsQRZ+O2jKSkS6R1UGY4Mv1DRPKLirCWI5GEBDgurXA5vt57Tzp
 kEN+oUOJmIxEG/Hs4HP8BlQX8hOCv730EM5zAanDWznpx0foS2f4xf4XY6csd74In3aVTAyQvoo
 qk5Thxpw0gpykja/MWixprHJ0d2fSm9NeUH4ucKcAsDTicaySPamD1X8/sgGfTRyPqASN5tzLez
 oJLZbj84nXvhhYldyhFNz8p3ggSUj1aGrFBfce1fausHtVs1YNUhu9YvnaycW1h60+aosIxQkMr
 F/xrRYpRuP/eoBBq26GQCpfQpRZA7YUk09KZeHjVAo5aN5Q6sL8ytGbgpFqIeZmZ2csX2T5B/4Q
 ro1DmQjjcgdpw404J4w==
X-Proofpoint-GUID: rAGjmN9h6k6bx3oEwFG5xQYaI7B9FdWf
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a3a2cb8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=Zgn0vK2B9do-90-E0R0A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230053
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v5: Fix documentation related build errors

v4: Replace script based image creation with binman based command

v3: Use '-' for sub heading instead of '='
    Add location for template.its and sort the list alphabetically
---
 doc/board/qualcomm/rdp.rst | 98 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 5 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..5a0ce92e310 100644
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
@@ -42,17 +46,101 @@ on your device with::
 
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
 	runtime failure at Uboot, the system will get reset (due to watchdog)
 	and XBL will try to boot from next bank and if Bank B also doesn't have
 	a functional image and is not booting fine, then the system will enter
-	EDL.  A tool like bkerler's `edl`_ can be used for flashing with the
+	EDL.  A tool like bkerler's `edl` can be used for flashing with the
 	firehose loader binary appropriate for the board.
 
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

