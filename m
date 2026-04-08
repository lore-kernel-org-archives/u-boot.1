Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC051073C93
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 12:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2706484178;
	Wed,  8 Apr 2026 14:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNy14dR9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DScLU44Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B632F838BB; Wed,  8 Apr 2026 11:12:19 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2C580433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6386uOG71619690
 for <u-boot@lists.denx.de>; Wed, 8 Apr 2026 09:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=o0uKCFgZgfq
 Tohu51JNmR4vH9KOEVgkvV9ZE5sy9iE0=; b=ZNy14dR9IRD/Zp2JCwTMxjQO257
 aE3pda2wt+7YOjOuQFjdingG56/FX0T4IVVfgFpI/4hhY9j0jt3Pjy7PykLBUGVW
 FC1XvbCNwro6anONCpXywjouLtdIg93r3SJP+3pMq+wQheEpvGRJ4qpkBwWTlAkU
 bTYheptGVmPzWPvR9JDizEfYbP9bAWARppyveuNicPjVXD6Br4m71o0540LxSoyC
 iIfHG0l7O+gQwWnrAH40idOz6g+puzRrrEYNkDBIjBC8LQAJxou+euT+9jo26qhJ
 NsEqdgvFFG6sAtA1MZQ9UJ3idCbwWRD2LM0mDYyvVSJCtUarWKClHCbVMgw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddacrj0x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:12:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24305cb3cso70706235ad.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775639533; x=1776244333; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0uKCFgZgfqTohu51JNmR4vH9KOEVgkvV9ZE5sy9iE0=;
 b=DScLU44Zp//gWbZDC3KC9wAevwZs+wNNhq1ZHu8lsPz2A6utIF8Jg4nlMDqZrY+XgJ
 SRyU/84B6wuNutkn4GzBoAYBmnx/dC6j++FDWJH9zfJT5vbnR/r+cajFg1EyuO58wynU
 y1dGKLQvLJtkFKbYmPGkNpurde3tyYP/IbvLJx5T6tpCbjswFGwgy13BGalysS2JlYzQ
 tLJYVgyxfl8ONFyxHZkvXVYD4Omsq1VXVNdexGppOGiU5VoGlmxZFXcQ9bLPsGKcO6c8
 NRtZKiBS6HXK/KdOo15nM/63t+j30BvtnkmaqLiMC8DN0Zzit6k5/+DHQEMNqVn9k4Lc
 3bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775639533; x=1776244333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0uKCFgZgfqTohu51JNmR4vH9KOEVgkvV9ZE5sy9iE0=;
 b=aJDCuXMEsna1kr0A6Fh3hz6kF1vhQ+CWXIG1ChJCYYE8Bbg4lp13L+5ZhZTagGOjK2
 Sx90YTrCMa6FNgbF4L03XOLusn3JxxLZ0gUAtkTBCLyXYkvwlRCI+Bwc8KwQSFnJP4l2
 LgZX28HS6+w+w/jweD4PDDlwpN91BX7Ch8BomkWSeu+VUzmfov/8ERK7jS8GAqAjzSgR
 Hf0BEGHUvg/1MQxv122DHPP8SRZOxaCuZhdY3vM4q0c42SZMnG83Rxa6+rmqEco8pb1B
 7SD3X/KaDqpCVg8LKemhV+Gy4Ue7es0Pwff/b51Pir53YU5QeBZSF959z/xY9gC7UeXY
 GaYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa1lTS5LG9oygWkZKSzevnMwbNwGjJBuvFtUxWdfzIcXxDYbugUBMYZRmHPsT8CIPpHeJHD8s=@lists.denx.de
X-Gm-Message-State: AOJu0Yw95bJmxGtit8O5l53N81E2xeDCr5gyczqbFZrgfl94NtLJt7o7
 mnHg47ssjDn8x/WFwnaEREvGY+fq45yShi+TIhIY7HQSNGbNkbluwp0o9ctQaeDrEN+0dEnsE+b
 Msn2olZCZXtJnNMnmAe7apsUGSpRIHDhjSdQN55YAbADVie+4GNOyKprl
X-Gm-Gg: AeBDietsWyFATpKknxaoNP4CO34vcYEOGQNb4MdOSpqbFHpzbhLZSaUBH8D0M1mlesl
 MFOcFMlH0KxOzr1NAOKTZrKtFUOOmBIKgCfgFaR3MQInRQUOKlaaKhhmQWOj1Cr/kdeYHSt5evE
 J3KgfOfFiGG0ZzJdtSdXigmxX93xEGTav490dCnsU4HBfId/HniH81Suyn6ZkksYbcnd/DobDqL
 2ZJZTOouX7ipBz9Cx4sC9WxNAevlG7X9NqZqcV6y5szO/1u3SBZVlGccv1EuWTINnFmfX4+mOQC
 a7ahD0UpKTwZ12AWNFhhIN7d1DGHHZWlvgtWtQjiusvSnkPFA/H8hAPMgVE3S/NfvvwrKSFN3WM
 pd66DaClxm3rnsWKUz9/BqmqO+CQBmZG8tHR3qD53LQP6uW0KoyKhRKKeyOWvEh+Bm1Jjt8DBfo
 yGTs5TQVnRslUmn7mY7nIUO6/ZV7PIMiu9QklFvj9O27gv7ZXebXo=
X-Received: by 2002:a17:903:3804:b0:2b0:59c4:e9dc with SMTP id
 d9443c01a7336-2b28170f376mr217522405ad.22.1775639532857; 
 Wed, 08 Apr 2026 02:12:12 -0700 (PDT)
X-Received: by 2002:a17:903:3804:b0:2b0:59c4:e9dc with SMTP id
 d9443c01a7336-2b28170f376mr217521565ad.22.1775639532302; 
 Wed, 08 Apr 2026 02:12:12 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478945asm260020325ad.28.2026.04.08.02.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 02:12:11 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, anshuld@ti.com, tingting.meng@altera.com,
 alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, xypron.glpk@gmx.de,
 mkorpershoek@kernel.org, afd@ti.com, andre.przywara@arm.com,
 h-salunke@ti.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 dinesh.maniyam@altera.com, danila@jiaxyga.com, adrian@mainlining.org,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 alexeymin@postmarketos.org, james.hilliard1@gmail.com,
 philip.molloy@analog.com, miquel.raynal@bootlin.com,
 malysagreg@gmail.com, richard.genoud@bootlin.com, sughosh.ganu@arm.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: snlakshm@qti.qualcomm.com, gopinath.sekar@oss.qualcomm.com
Subject: [PATCH v1 2/9] doc: board/qualcomm: Update RDP build instructions
Date: Wed,  8 Apr 2026 14:41:29 +0530
Message-Id: <20260408091136.2794546-3-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260408091136.2794546-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uFeC3dtRbEjGaTyxHdXkvPVmuUxg9LYk
X-Proofpoint-GUID: uFeC3dtRbEjGaTyxHdXkvPVmuUxg9LYk
X-Authority-Analysis: v=2.4 cv=WZs8rUhX c=1 sm=1 tr=0 ts=69d61bee cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=1FHRc4FDAAAA:20 a=nFfF3bpPldlHIai5wDgA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA4MiBTYWx0ZWRfX7ETWiYOH7BG5
 AhPxRD0EBX0YaEBUx7bZVBnwkOay9y7GHLKzom4ybX78cA5fEd4KpZXCuux9PqxDC8D8QtGunaz
 v8BBi/Kzyny9Pjgs41Jg3jJ02+B6+TLSj8yRwXeHR3bywCD+S9VKGKFbS9JgdDqfad69FUTqQA5
 PKMXJp4nIYAnxhmLNaAb11PxulkpHHvDEmYg9lzeiSXO12FrZfalYLi4VHJ9CaWRJgO8BCIP+e/
 W1ejQk+/mMt1yDystgfIc3ewIIOJgZWqtuickq72v8ocduEPbicHhonb2btdlbIopKSV5QoVB4t
 VJ51eGLQOxmKwa/+p6Owy+OCmaEEQFbVhId8xMrXbWZwI/qWGdywRVXoxHQZ3KCgIliWrBtzZbd
 d/k2AV90fEQ1Ux5LtiFNcTZkg4hmbhVAw0LqL6MNadT0Z7y4cYqYj/jHUaw4CTs+CGhps8J2YvS
 tQixfQ9w3sub4aSmTLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_03,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080082
X-Mailman-Approved-At: Wed, 08 Apr 2026 14:55:29 +0200
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

