Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE34F44852
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 12:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F77B8419E;
	Fri, 10 Apr 2026 14:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NtCF6Osv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C98iFQvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AB184106; Fri, 10 Apr 2026 11:12:41 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E2B983DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A86NUb115019
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o0uKCFgZgfq
 Tohu51JNmR4vH9KOEVgkvV9ZE5sy9iE0=; b=NtCF6OsvwIqjDV8xoLBQrIq+TXt
 5gwjT9692i2URH18TDrIiGgBNwt2jLyM5kJnjhnN89XGdCcgORSKB9zwRm4YkmZu
 x6LuO1D+H9XyAfzRPziGT+h1VZsuBEuGmTCrxkFp7kL/vO7DB9MZNQRTxDxztu7q
 4h/m8dmyqqEnGQb51vKyKdPQBf+mOKBZtoJ5e2jzgH7+C3kRH3y3SrHX+CMS3riC
 +SnLU/VWmTOPRd2q8DrVVlVh1z+pY7IKgSwVAoVmzl6HlznsVifxN85oMaZbjlq9
 vvPE51uRWUZ2VDLbhR0S2m5RexhXtUyZrMcKlwjN1xAt4Y5eZrxQEW15tmw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb67e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 09:12:36 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35c12a3bbb9so1993823a91.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775812355; x=1776417155; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o0uKCFgZgfqTohu51JNmR4vH9KOEVgkvV9ZE5sy9iE0=;
 b=C98iFQvikkfPaAqXHmuu4yi11aN1iCkEvKPj/uTXIwljzK/OADzcVnFozH81ot1CCR
 QkKF3HUwRaJY1ac3xt/XJ5BAuuEFV/KhcdlMzNV2Jj5Ec97eaTOp3Q7yRAe1Xxml5Jji
 wFATTVO4KSpKCFaM8ncIuDahS4uKbLmWMiDRciwxZPPxyzvjTyKm+50obwNjkahlpP7q
 X0zotSQ996GAM667ebMQa7aXuDXvtg9GN3a4jnxNFNjfyKymUjMg1WeJ9DffaBoOsRoO
 Q7LJW2D1E5yok+crflouwNemryYOIT//bQ4j9ivdwvna3BTljnzjiF7gOSi70R1mu4fZ
 RBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775812355; x=1776417155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o0uKCFgZgfqTohu51JNmR4vH9KOEVgkvV9ZE5sy9iE0=;
 b=NJUZ+lDkekWxNy3yRfRtrFIubplbOzxpBA4PIjiGou0SuIaCo8f68rRZmQeajniKl+
 S8XuekkUi+mYN60WDp+4JHGXTJw/c5MPbM1O+XBqco1USvIqEIYd4USP6GzwtZ7VCPB9
 esMgnmrGxoiLV9jyIAH3VFSA0P4b6T9Qj56Kz8VM2Q2hvYfzMRb1rm/xllfLdUJOw1tj
 15zuhhXIVhsqBPTN/VAaDorn2KIJzGB9iU5TbUvfosbvjBDJAI5Tv4QQe2ejVCDyZ2Nj
 2/xBbquO4ftaQZvjbpUoyc2O3tQTuRbVSplwoytu89bCPxLB5lzVipKc5v4ItFDeLHkV
 rVfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF+7f4LpY/R8l85WCxxT87FotkX3Eo1QgWbB7IWQbNPYwu55T1u0U459IGvwZjmtwg9YN6g3Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxHDPRehBXPl6Sxpz6LYoQEC9B89UzbfCWMDdN8/U14Ee2snRtR
 OhlJtXMfJWm8RCzaAgzp6ZFsG9JlzRQLL7pD42GmSRlO8gpNTTFpV24JVnzMwaDMGIZQeLWNlEm
 brAtj+Ll/WNnMoReg0RqOe2SJ4EF0lLNrZmZhKc8fQKb7/zfvyBlrTHfR
X-Gm-Gg: AeBDieuW7eZxEk438r/eVAfFrVUCzg9X/v6KTpC3+tA9FFTpFZDGKZkmDUIpn8e1NTJ
 kWAx8uRta97O+n8hlAanGMJsyE7IJBn7Q2bCJp9viA3ecvkWnFClOrTSqsdLiBge7xxSHarcSxF
 QuN88yxULFJOCw3NIiOW2gqGVeQRc5mWoC5t99TwgqoOvUNFSSD8xWmfFOrrdWQUjHTxuSrd+Dg
 uhbXLuZtdqH1hMOXIbMZGv45mHx0jT5RhvOlMH1BO45RwiJXITdOIxlARrbIELdGnE2B4aMWyeh
 wMT/lTKi8pvt+JyBGvlvFkfIlYfKQqF3Zf2IATNl1HhTw7GSHO+sNx0VWnJL2Pj7f2k5p8w5R96
 OnV/biFXEN2w2Smle4pRf86YeKm9bAvzRDmF62rVdK1VqttDFxxxaDAjR3Wx60SpYtCQxoeKyhE
 VjQ9J85vsDZ2F65lDTkHilV23Ubb1G9sy3wizi9+D8v1/6kXGTmwQ=
X-Received: by 2002:a17:90b:4c50:b0:35d:8ea1:62df with SMTP id
 98e67ed59e1d1-35e42838d40mr2702806a91.21.1775812355258; 
 Fri, 10 Apr 2026 02:12:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4c50:b0:35d:8ea1:62df with SMTP id
 98e67ed59e1d1-35e42838d40mr2702763a91.21.1775812354728; 
 Fri, 10 Apr 2026 02:12:34 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4123a29fsm2564871a91.8.2026.04.10.02.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:12:34 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com,
 wens@kernel.org, jamie.gibbons@microchip.com,
 david.wronek@mainlining.org, alexeymin@postmarketos.org,
 james.hilliard1@gmail.com, michael@amarulasolutions.com,
 richard.genoud@bootlin.com, philip.molloy@analog.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
Date: Fri, 10 Apr 2026 14:41:47 +0530
Message-Id: <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4MSBTYWx0ZWRfX5g71XNEKB27w
 fo1AdlX6egTg1CPryyalO600SkCe8oYBHvqlkRb5nVO+ZmFF0q2qJ0v4dP/5e+O6hThj8JTG3VT
 t/M98CCX1jFBFC8QBxChjnxTR9Un1ugheV07ql1fVXVT3NWOJ3/wZywh6A3FjAkEUxpS7jUd5w7
 G7KAUXras444QY0NYb79rYEunnNW4ufuDEBnKpvgkNDhhvTOUYczFednZL/0YQYeb7amPViWOiH
 sKcy6cW7fcF1ARra4n/+Tp4nqUHfjNMAIrJsfyufgo8Xnxv+bTT2om76NYvPerkb1uvTT6ICY4+
 uEBOExZjSw1S1VlezAYqcfhU6t+n6n1aFoBILTs9RHIDeUHFGRgMB6qW78oYf5j8HPi871S6H+u
 FTkqlVFSda9SZ9PPKvJVmXleWnUomiA+EXZatqyI426aKMsU4Fr4QOwYCRwrFyBCEC8Kp0RSkI4
 bvIlMRWEh08mOchkfdQ==
X-Proofpoint-GUID: E6aYy82MTncX5PRiJGwX3LpTDZhMuIr4
X-Proofpoint-ORIG-GUID: E6aYy82MTncX5PRiJGwX3LpTDZhMuIr4
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8bf04 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=1FHRc4FDAAAA:20 a=nFfF3bpPldlHIai5wDgA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100081
X-Mailman-Approved-At: Fri, 10 Apr 2026 14:54:22 +0200
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
 doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..d09dba52044 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -42,6 +42,67 @@ on your device with::
 
 U-Boot should be running after a reboot (``reset``).
 
+Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
+====================================================================
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
@@ -56,3 +117,11 @@ U-Boot should be running after a reboot (``reset``).
 
 .. _elftombn.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/NHSS.QSDK.13.0.5.r2/scripts?ref_type=heads
 .. _edl: https://github.com/bkerler/edl
+.. _create_multielf.py: https://raw.githubusercontent.com/coreboot/coreboot/refs/heads/main/util/qualcomm/create_multielf.py
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _gen_its.py: https://git.codelinaro.org/clo/qsdk/oss/system/tools/meta/-/tree/win.platform_tools.1.0.r34/scripts?ref_type=heads
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
-- 
2.34.1

