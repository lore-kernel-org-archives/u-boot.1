Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57440CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A858499C;
	Thu,  4 Jun 2026 14:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B+xcfycG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YMOTo7QX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DCE8486D; Thu,  4 Jun 2026 11:34:21 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DA284868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548a4BY141926
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s6+1GslluBy
 mspc+dbbtf9LPKHPmdCwzi/RQo+q3uB8=; b=B+xcfycGJ7Yun1D2yIxkcf6z8+I
 RxOggkh8TH4iy0FgBDzNlFtuvKuo8capsWPVDkdlA8xcEYpq5fS00as6c5M6+Ziu
 r3ozPJU+zOaGKxTPkOj1pLPRGh5j5oyzCrxcaishr2uqzkitWB7SA2rjXvBgNagg
 bP8mJFz4fYZE6s77yLH2aOTV14Vs+Huwqm3C62OvjjIdshNDIGXYF+vJzKnbPBmU
 hhi9TSqzLrKDK6SdJ3fKLjV96ZcSn4ikim5J1NBzwYvDQoEf6dtzcd+/LN4MReil
 9bUB8K86yz5IGL4lXIQ0MncukVB5kPLX0vhQi0JC5uA9H5exxADvluwGOzw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejyen9my7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:34:17 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c0c3315d31so6880575ad.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565657; x=1781170457; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s6+1GslluBymspc+dbbtf9LPKHPmdCwzi/RQo+q3uB8=;
 b=YMOTo7QXTvGkixzdfjF6TOiwbjY7zfH6x7G2jraOGir/XfhC+kkng5428bNfgQipj2
 lqoTc6yjghznG0VnzAEltjcInr2+5c/yvDRD01dWEmh2GKXKcMCy6ZXmFIkn8zwP9poL
 UQUVzzQvJwGVd3brMTNaV6+l9qFf9bShMd3nR6xRcP+uo/TQ31OrmkivivCswmrmflux
 HJfcJf1T6YMITDc4MypA2ycp884ZrFN9p5YrZ2Kt1JTce+X+hZ4fe+2cYMBbVbN1IikQ
 Qhazp8hjHIQN0bgGPXZKhic/gKFR1qRZMrIO/qM3OpBxuj6lSQEaV1MJ9wGoWvrP1bVL
 pEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565657; x=1781170457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s6+1GslluBymspc+dbbtf9LPKHPmdCwzi/RQo+q3uB8=;
 b=sq//bcKjzZsLon7AeQXMoO4FaQg1Ksj4AQFNUzyD9KqNtH+kqr6Db1VyJwi3o0ohcV
 1wijr6sR4MxDX2JsQFjxmKtWIXkQLbuCa0mSUi+RFbsNAO7vExuX74Mns7RSVq9DnX0V
 prwuqs2vfV08ZYvOkYTEJeK0ECe8tJPYn6+R6L0BeoRY1UcaiO555pxNc3786zBd8fZZ
 CL8yUKCIO0l3VAQxTDm7gsjc5pV3fhiGuLq0xmYdAdgeTJFemq+9fsbhnWKgbwQ8T1y2
 eRLRDl1xbIsOwXIQmJ/Ry2fR4WTlxQFUc91ON4i+PJrbJ3MPywqhC2QluktXORMjgrKz
 cDcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ISYl+1eAfdK1dvhumwEjCVgLR2HPRkP3LPEzg8FYwXasui6OghYh8XB7dIFYUpHfLnBAaDuY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzhcq0UlGNM2VEq5QRXKdxixrnNexwyReFLjUnnBgB0gDRKi00b
 iCZbsPbma7o9Wsf4QBqUOlMDEnlnAiGrue9I2BOVKhqxzH/JP6lxzk9CYVU/fJt+sCIt3zsenOK
 jB0ZSUABR11OVtSmmKjVyuT3IKLKko7mvqIWf+cpXv7Yrv4/GGgPMz8iP
X-Gm-Gg: Acq92OF0aeCjl5MeDRSAwJNaxFCO02v6XDuSTafj6T9VxwuW7u7MZVI6h8VyPDjCBrG
 TgWueN66xeUWIdpVobF4FG1Q9+7p9KstMWhmXSbFkmAiioReaN1uLv6tvHp/HCTsfCe1Y2X5nDy
 EcaYF+WzrOZCkBVFv/xtKSw58Nr87oA3sRoNQUllRwn+0t7T59et6LjNGW6ygAkOwVVSlTco2+q
 2zmImwab3+vUew+Iktz+V+LZzHvrQ7YSpLndIrQ9lUtqEDD4MzJIWpRZ4DtQ0uFF9HcFQQ58PBJ
 vEx41ztLyJxpA8eX5R5JGr1UwvDa0gIA0qKjn/xIRtfTokPCvC/FqA5/6zu+phPlNHIUaDwBETb
 F1lAHS9LxlN5BHU0/MfzHCFwSoWa2Zgg3agqmSlgYHBZyo+A1lTIfkFf+IJBSkl/EyRHDUs4pQ5
 YHm2FGKiJGsgmcbnvlRUBNfMi//UxF6QGg/7k8KMXXWCoeN/YXuy8u0egcsqYuUA==
X-Received: by 2002:a17:90b:5744:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-36e32a42cc6mr6902955a91.19.1780565656807; 
 Thu, 04 Jun 2026 02:34:16 -0700 (PDT)
X-Received: by 2002:a17:90b:5744:b0:36d:cc9b:2f67 with SMTP id
 98e67ed59e1d1-36e32a42cc6mr6902917a91.19.1780565656307; 
 Thu, 04 Jun 2026 02:34:16 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:34:15 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 13/13] doc: board/qualcomm: Update RDP build instructions
Date: Thu,  4 Jun 2026 15:01:32 +0530
Message-Id: <20260604093132.757583-14-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JaSMa0KV c=1 sm=1 tr=0 ts=6a214699 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=VTqxET0VOa0c1KIOhbYA:9
 a=uG9DUKGECoFWVXl0Dc02:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: iM45rdbjIjnDkRdE_M-1204zAlhNYZZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX0HkMAOOKbvP5
 XFuQo7zdgKmNaof53+73xVqUNjUsEDFEYyURFoKZDWYOmKqoUtx1Km2YNU8jx3x5WCnlmvchuq5
 TYmZ7IqFo6i+LkRfubgZDix37x5vpdvyTB+YLGdKrxkGguoei6ZscqKFgEdD7yvLZ4ty50Ffu9R
 ccPqHDO421dOz/LB606N5Jaekv0lJuMKxglRWGRjKsmarEdnwoF1iFrJFgzEPdwwMGPZqvIZDab
 D+RAESzaVIkTwyiSwaAcKF5AZS9BRi/+bbxvuPT+u+S27DU0DWbJhJ4WAhbJDKVnrJxgS/vxCp8
 1uEHir1WEdniF77NVoYakVh7Z4uw9Xr5c5dgxxur9Fq1xymZUrkzHHz87mCeFe4HiYfLLQ8POMI
 lL3OZ234VQWHPBi50YzhXoWsl0iQOJjKJqRa/mL3qOUvI0b+tf3Y+KE/Kh/SUzf5ytdtH6Ms93k
 975yPO8qAAEtr91kVvA==
X-Proofpoint-GUID: iM45rdbjIjnDkRdE_M-1204zAlhNYZZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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
v4: Replace script based image creation with binman based command

v3: Use '-' for sub heading instead of '='
    Add location for template.its and sort the list alphabetically
---
 doc/board/qualcomm/rdp.rst | 83 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..354dc9d06e1 100644
--- a/doc/board/qualcomm/rdp.rst
+++ b/doc/board/qualcomm/rdp.rst
@@ -42,17 +42,98 @@ on your device with::
 
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
+	$ python `create_multielf.py` -f u-boot-spl.mbn,tmel-ipq52xx-patch.elf \
+					-o u-boot-spl.melf
+
+   This u-boot-spl.melf should be flashed into 0:SPL partition.
+   Please see below for the location of `tmel-ipq52xx-patch.elf`
+
+3. Convert the U-Boot image to bootloader image
+
+	$ cd ${out_dir}
+	$ python elftombn.py -f u-boot.elf -o u-boot.mbn -v7
+
+   The u-boot.mbn has to be combined with `qc_config.elf`, `QCLib.elf`, `TFA`
+   and `OPTEE`. Please see below for the location for these ELFs. TFA and OPTEE
+   can be built from the sources using the following commands
+
+   TFA:
+	$ make PLAT=ipq52xx QTISECLIB_PATH=path/to/`libqtisec_dbg.a` SPD=opteed
+
+   OPTEE:
+	$ make PLATFORM=qcom-ipq52xx -j16
+
+   These binaries can be combined into a flashable image using binman.
+
+   Assuming all the required binaries are available in ${uboot_dir}/binman
+
+	$ export bm=${uboot_dir}/binman
+	$ cd ${bm}
+	$ ${uboot_dir}/tools/binman/binman			\
+		--toolpath ${uboot_dir}/tools build		\
+		-u						\
+		-d ${out_dir}/u-boot.dtb			\
+		-O ${bm}.out					\
+		-I ${uboot_dir}					\
+		-I ${bm}					\
+		-I ${uboot_dir}/board				\
+		-I ${out_dir}/dts/upstream/src/arm64		\
+		-a of-list="qcom/ipq5210-rdp504"		\
+		-a atf-bl31-path=${bm}/bl31.mbn			\
+		-a tee-os-path=${bm}/tee-pager_v2.mbn		\
+		-a qcom-config-path=${bm}/qc_config.elf		\
+		-a qcom-lib-path=${bm}/QCLib.elf		\
+		-a qcom-appsbl-path=${out_dir}/u-boot.mbn	\
+		-a default-dt="qcom/ipq5210-rdp504"		\
+		-a spl-bss-pad=1				\
+		-a spl-dtb=y					\
+		-a of-spl-remove-props="interrupt-parent interrupts"
+
+   This should be flashed into 0:BOOTLDR partition.
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
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf
-- 
2.34.1

