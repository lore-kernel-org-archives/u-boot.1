Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D80F8A16F
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 13:18:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1418429E;
	Thu, 16 Apr 2026 15:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uy71guSQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Px7+2bl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EADDB8407E; Thu, 16 Apr 2026 07:41:43 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371D383C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G0oMC22834884
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7nZCl2w3/YU
 KgLjtUh4BFAobX1s0Za0J7Qdsi1PlL6Y=; b=Uy71guSQdwERXLy3bpmZqAGK5Xa
 7KydXkCMT/R/dZmiM+8b/qW9dS4sLw3LJhAoC7olnEX6w8vsCRPQv0AKk+VP+r/f
 RQwESB3gB/5lz6EDEvq2IdyrR94eiDH7KTBJBxWXs0mh13MjLu5+UcQ54fK9Aop2
 rfgOa4lXJECR7ZZaaqsMUfuWIpMN7iCtC9zCt+w9TgE2XIASTYlKcMjbpjp2XXtT
 6/rd1kz4pivHggoF4H2dapm06YDmBWAKBN8SL3Ivo6BoDb4//eqmXAXGXAEeSvZW
 Srx4hfa0BfiVOJ59d6r0Pt6yO/1T7H0uSe1jubzTDiQKu9j8Ce0gAPvMLtg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcsvjes2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:41:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f543bae3cso188911b3a.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318099; x=1776922899; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7nZCl2w3/YUKgLjtUh4BFAobX1s0Za0J7Qdsi1PlL6Y=;
 b=Px7+2bl1NYtTOlp0wO8r85qVpQK/zL/drhsc8H3Sws7ks8yZW0SjqcOUXLDsS+4WjX
 32iQyhP34PU3bL4p4OxvQf/5K59/Ml523NiccWYfDeVn1pcuYtPgxQD4pGhT03GAFeRO
 m9zEVWgL4xyvDJ72prCewSifr8CsPx3XxVQYykWfMwxx7o1MagcWgvxetG2DSraSyFrV
 lz3gfQvbD9Sck7Y8mt8WWD8qMenTnqk3Tclun4HnGtJhqtqv0UIqyGvGG/9r9T83IQ+E
 WuaAMO02TWEGhSKYecYHxP/3S9InknPHEt9G01LK6HfuVqZMmKXHpetUrGTvbM9UMGi5
 Dc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318099; x=1776922899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7nZCl2w3/YUKgLjtUh4BFAobX1s0Za0J7Qdsi1PlL6Y=;
 b=YV1/jZG+we09J2gWJ+1SfqSAxwx/s8SpLhtyWr+UTAq9Yr2H/XMEI+vHgADAKhAme7
 5HAq0/Y4CqDSsIB9YR/6JI9jocdlQIXjCOS3HNMQCPvgh7Ry+AI6+X/zVn9qehDgUu++
 u0lQXnPCgyn+NekLLX2sS76DZ0Bh4dROuQrqJ7HFgImQ1NtvU+xKaHLWFYZzc6gcFj3Q
 35dMCXVy4I3MMI+fqkbJ00MZyVVrZjK9B6G15l+qzMncgasjrddiERAwP8BNyhMCHT4r
 QE7D99ZFga3o7uPS+S6u7HTaS0ArTubJacu9YC9Pm6k5NeOZ3qShtk4M2O0oGc4i0Nif
 GuCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//BRDVRxDNTIbIcdCjmj0II9wi6VtKXA5f0YIukH7A45R8ZoXvjn9hzCzRL/f9s73Bo/F8reg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8lHvWQNPvzd/olCAul6pRIgNtlHO6qFdz8bUDKUCjG9RMgbCf
 aBkBg4BqBmYbxxTSwmLBvHfXKMoaiKedLi1ZKXb6/8Ohxh9zpoq4p0CNvV70lgAf3HEWsVfpoyb
 r8DsIFAIFaxYy/7PxC4N1ymKHYNdYvAQIXMrZz7ys2JZHEpAhLg+0hvOC
X-Gm-Gg: AeBDies4dsDM2jomWLASQQUlM1aNPFsnHXUtCyp7Yfs/fiT2P5tPy3PpHPaIQpewvge
 u5dUzpoQA4GjmB0ntLJUmOQQi4KePWJqeL7NbBWJ7MvvyO52dkOQIu/slXn29EXhFQm+vJXEq92
 j7M3EKsWENJZgOzyfkn3xULiEm89gBXtp7Qkbs/UPkfMX/No79elkJuV8PeSxL85RMzz3JwYy6Q
 dEOIfDD3SdMClRrLGj84tA28Etlly+6Dj9PO6Fi9B/RFoje/hxth53wRnPXO/bOlR4dYK0YJD1U
 rvl03MoRJvWb/3Rq39fQiHKvf6tyvshcpzWbaqqZ2t7AzK8HTsOOTn4nkd9VM6jY9y7ecm/gPS8
 uhlEI9aOOH4kpplkKhyJMaKPZMU8oXwG2R7gCEwmuAdrzjoLeK2cZaa6Xf+dAefo8uw5BwR+Hxd
 fWx6gNcikkslynC5NbCZMEFH6TABRCfn1a6X0jrb9pZ3o2TESqjN0=
X-Received: by 2002:a05:6a00:a113:b0:81e:1b77:9e61 with SMTP id
 d2e1a72fcca58-82f7ee51719mr411964b3a.25.1776318098499; 
 Wed, 15 Apr 2026 22:41:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:a113:b0:81e:1b77:9e61 with SMTP id
 d2e1a72fcca58-82f7ee51719mr411917b3a.25.1776318097983; 
 Wed, 15 Apr 2026 22:41:37 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f673e3824sm3994496b3a.34.2026.04.15.22.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:41:37 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, sjg@chromium.org,
 mkorpershoek@kernel.org, h-salunke@ti.com, alchark@gmail.com,
 dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 adrian@mainlining.org, n-francis@ti.com, wens@kernel.org,
 jamie.gibbons@microchip.com, justin@tidylabs.net,
 ycliang@andestech.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, richard.genoud@bootlin.com,
 michael@amarulasolutions.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 10/10] doc: board/qualcomm: Update RDP build instructions
Date: Thu, 16 Apr 2026 11:09:28 +0530
Message-Id: <20260416053928.2834699-11-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9x8rMByQaTwHMdIX_mHo79ZeJHG9VeV1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MSBTYWx0ZWRfX74E1eDVt8DXF
 Rd6Dj6/Z+65SEReS7l7IGdhQzMGFGTQyHMwGIRJjRl7Pc6AzN1VMqDGnXDP0Il2DtABWD83keOH
 If0gO/HHfPlPUj5Bk9FrDN0raiAQev2JuUGNT9XmSOJ2xeX7oYrmgg3ONtjuNno5FpyY4tKijDW
 /4rgONf4qqgxiye7HnBQ9aR/rFe8/Q2/CG7BWC1Es02gYzKMnyzlliQBgtHWWpaFneditu96jyD
 jZ07mHvaalEUMnxvc2HwOf6FmSE59f0Eac1MD1vm4DWeJ+iLPVaVU3xvDBi+1Qd7rGjXLcxx/nD
 6NcH8iRiii4BSk0WkuQM41zvQOYpeIavrsL4D5XPT1JMQhAUvkIp4gMAlKKup87FyjmHMHYjOtC
 EiXT6rLV5VRsYdn8IdUgEzSRvN0VOnBKuSR5lCWQbCldIcu4boNJ5yyd4cv0evd3kGtHb0XVPMQ
 HwKKY5OYsyo1jCIwG0Q==
X-Authority-Analysis: v=2.4 cv=Iby3n2qa c=1 sm=1 tr=0 ts=69e07693 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=AXmdIFJ3aiCCDiDjn24A:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 9x8rMByQaTwHMdIX_mHo79ZeJHG9VeV1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160051
X-Mailman-Approved-At: Thu, 16 Apr 2026 15:16:28 +0200
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
v3: Use '-' for sub heading instead of '='
    Add location for template.its and sort the list alphabetically
---
 doc/board/qualcomm/rdp.rst | 70 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..3a96476dd32 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -42,6 +42,67 @@ on your device with::
 
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
+	$ cd ${uboot_dir}
+	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
+	$ make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig
+	$ make -j8 O=${out_dir}
+
+   U-Boot SPL image:	${out_dir}/spl/u-boot-spl.wrap-elf
+   U-Boot image:	${out_dir}/u-boot.elf
+
+2. Convert the SPL image to multi ELF
+
+	$ cd ${out_dir}/spl
+	$ python elftombn.py -f u-boot-spl.wrap-elf -o u-boot-spl.mbn -v7
+	$ python create_multielf.py -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
+					-o u-boot-spl.melf
+
+   This u-boot-spl.melf should be flashed into 0:SPL partition.
+   Please see below for the location of ``tmel-ipq52xx-patch.elf``
+
+3. Convert the U-Boot image to bootloader image
+
+	$ cd ${out_dir}
+	$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+
+   The u-boot.mbn has to be combined with qc_config.elf, QCLib.elf, TFA and
+   OPTEE. Please see below for the location for these ELFs. TFA and OPTEE can be
+   built from the sources using the following commands
+
+   TFA:
+	$ make PLAT=ipq52xx QTISECLIB_PATH=path/to/libqtisec_dbg.a SPD=opteed
+
+   OPTEE:
+	$ make PLATFORM=qcom-ipq52xx -j16
+
+   These binaries can be combined into a flashable image using ``gen_its.py``.
+
+	$ python gen_its.py --arch ipq5210		\
+		--qclib_path QCLib.elf			\
+		--qcconfig_path qc_config.elf		\
+		--tfa_bl31_path bl31.mbn		\
+		--uboot_path u-boot.mbn			\
+		--optee_path tee-raw.mbn		\
+		-p qcconfig qclib			\
+		-P tfa_bl31 uboot optee			\
+		-o output/hm_503_test_uboot.img		\
+		--template template.its
+
+   This should be flashed into 0:BOOTLDR partition.
+
 .. WARNING
 	Boards with newer software versions would automatically go the emergency
 	download (EDL) mode if U-Boot is not functioning as expected. If its a
@@ -54,5 +115,14 @@ U-Boot should be running after a reboot (``reset``).
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

