Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A91CD98E4
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA61784A3E;
	Wed, 17 Jun 2026 14:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ck71p0L8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XZKttnaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9471C84704; Wed, 17 Jun 2026 12:21:03 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31660838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8VcK02190970
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zYCXDV2psBx
 8d+zYNTsWmBHTpEW2n7XPdDkZ9ar6Vy0=; b=Ck71p0L8uDkT4ONGV1AJ9+Uzlod
 QHibzIS1tvha8IBdIl4hmfec/CyBFiryfoS7Mxu4P1OciBEJZWy2ipYbWq9HE+H9
 K8Z/8ed5N3UP0FGEGRsduBEZV7dZeluz3tiE/RmIuqUDFqtol1N7l7r2WYV/6WUw
 59pykLdVX5nWPzCyLF/otB6ao/+VOgrV2IN6xqoysxzGPvLZxQn7mj3IbCWIvNtA
 gt0R12ziDVFUpEuTT+2J82taikJhQmdXzzlKhlEh2nD/iugJ4DdUEevoeEcL7hYM
 5yzICgO1hcH9tQyUnB3QHpbDIMNR2JRtECpWv5Y3w/+qOR6z/x1Lg8ZsH+A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjnjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:58 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-842211d6e48so6645601b3a.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691658; x=1782296458; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zYCXDV2psBx8d+zYNTsWmBHTpEW2n7XPdDkZ9ar6Vy0=;
 b=XZKttnaBdbs3F7SXJ00ORxNeEmapE157DCEmLYZfTV7xZNjSXwu6aWK8vjrrbzAI5L
 37ubXYPJssfW6NmWDT73rPV5lN8SLisUsnmDg91UV2Ih5yOJ3w3cOlQE9a0aXUDGfHlc
 kTF9N9wuihKYNWg9KzZvynocTEyT1aSFMuKVUK1jc4k7NmXNZTnrthSEA/QIZLE9eW5w
 lbWwlMJX3SoEUXJW/gpWWg2V3rMrMJNhiNsAsr7jO1xu6XG9RkR3yYgF368ZX8K22ni/
 nQ3rTziuJUB83azk/M+NrVW43P63FpWqq5Ixe29+nvOk3aB5Hf4WhjUt6qf5iNHk68cI
 y5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691658; x=1782296458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zYCXDV2psBx8d+zYNTsWmBHTpEW2n7XPdDkZ9ar6Vy0=;
 b=Y1HPLfQo01r+lrw3sykI90TSVgrypapOdxEbS4b9qfqkq15DKDilLvbYVxlqp8ExQD
 S6wYRNLsjMhVhXALH5vwYmpZgoY9fc8KLqsbwOhg3D5eVQSjaOUCEt6dD8dRAOIq9x93
 ZLL3RbXEY/qjzUzjsLayn5kvzqPBsqBVjCgBDC/YwLrZJ6tFyFO+2YxXoxGE0yg15G1M
 4+ClfEr2fu9IEzx6Y1Ix6sVkIrCKXFLwJqzaHQ1ce6gDubZ547f3oZQI4lLJws7WJnsR
 aRn7mEv/UufBcOxaBZb0nODhgYovZusmf+tuAMHDzfYPYQiY9e7Ln4CXdH0hnmHtL9R4
 k/2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+K0TaCWddVgvT9b8t6vIoC2ni7h4oiNYZa6GeUXSy3rgBGYxuFXt8tHb1Jayi2JrHs4yyIfJI=@lists.denx.de
X-Gm-Message-State: AOJu0YygBQd3wt/ZXlxUsBSfYamMr3IS/PMtI3T5myTx+Wa6mGYQs/OP
 qZeHr1E+S3bQev/pPKEveAxWvtNYV4Kuc8WK2nGj0AJ9SvBg65SSFAiAl3ggcU/v6X0DQE83NGA
 +H/iobAnIG++/a7lZceCSPnohDxH+MvLICPXGGxTAd3SfSomzySkvCz7T
X-Gm-Gg: Acq92OHurrTdKt/cu2Kv/hL0plspK921U8uq7ooesitOdR7tYd39+TAB5Up81nTicso
 S2JzAQ5i47yBOqQ9KUtVuobPhem1oLzYX6vxPH1v01akpQGK4IDWX7floWKqsk1bzM3o8v1x+g+
 PdJo/4you7R7mFIe3DzTUdlWjXB5tqwgAg9S5FFsX6Tn4yuPVWTn3G82jmALl4br4N1EyL6H5yt
 JtatXobcmUNTXMrDMKvOfVb8CRqg0N9xcqkiYLF2t64Mv58BYDqdi7napqNm6qjiUYiX5y/jbuj
 I/UTxqxv0jEBpCCNSHRMR7lrI8UFMZLrWGiwZknHjPSdUMBdv1tqWT7d7xxmNG5D5r24fEADpNw
 DqkjmhWGp2XMNoH09mftrdTSYLUIEux5uYmzMe8fKu0rXj8Gcdw7remKX7mk8utEpNmmRH1PC5X
 w8g6ppKqz0LjfHhXM/nAwznI/gb/rFBV4yQpTJCq3S
X-Received: by 2002:a05:6a00:3284:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-8452452b1e2mr3194409b3a.21.1781691657540; 
 Wed, 17 Jun 2026 03:20:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:3284:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-8452452b1e2mr3194364b3a.21.1781691657104; 
 Wed, 17 Jun 2026 03:20:57 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:20:56 -0700 (PDT)
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
Subject: [PATCH v5 13/13] doc: board/qualcomm: Update RDP build instructions
Date: Wed, 17 Jun 2026 15:48:12 +0530
Message-Id: <20260617101812.299586-14-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX0jXEGJAYv9rx
 D2esbSSIX4vA1YHJXTmimBNNn7EdZfo/PEq8q5qvqc6ZdnGDIUWSfz1PP15EZJVl0oEaMY9AVu7
 d8joeTUZxe1b3fiCYEJMO117Ea63GW3EjaKnRV2ICWd9TiiA0rC9U//xPKblYMrAb6zX3aoW6/e
 cBdU/TxFUS5fTbSwWV6lj7R6gbsgpD2rQ1cYyFJJBPc/k2VIMeikVfMcj3u2yDlAUvhUM900JHH
 u8pFrwHcg9qSwoQ5WNkUquf/m6WoRGQtHQc9yCh6blFjST/9e0XX8qex4gocfAd8sI/K10iFOyP
 jXTF7D0DabmiOrsUu6lDwq+DDJA8JBFj6Q46wqrR6evcx8eI6kkLnqhtYtMm3SKRTCHC2y9JXTl
 a2YIeGiFpL9s4C/dzSj+dyZ7oGga/S62s4Vuy+MDD+2RXT9NFjBEM5EacMpqeW20dXleTDsqYUt
 17vdrpaytI4SvRmFKsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX3GKNZ/9XZNCT
 AJ7uDU0qK59zofUDZhiwIfPU5jjbbuyj2KdXMMk7byo1V5uZ2rO9Fw1YwTiKtSsMoL3FfJ9wYpN
 j/YteZiPb1iDt5L71o0u6wfMb5NcjQA=
X-Proofpoint-ORIG-GUID: p1_mqyd_UC9Ko5bio-mwAAPwbX-nylp5
X-Proofpoint-GUID: p1_mqyd_UC9Ko5bio-mwAAPwbX-nylp5
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a32750a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=1FHRc4FDAAAA:20 a=qC_FGOx9AAAA:8 a=NEAV23lmAAAA:8 a=Zgn0vK2B9do-90-E0R0A:9
 a=OpyuDcXvxspvyRM73sMx:22 a=fsdK_YakeE02zTmptMdW:22 a=bA3UWDv6hWIuX7UZL3qL:22
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

Add details about the SPL & U-Boot proper build steps, converting to
flashable images, source URLs for the needed binaries and scripts.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v5: Fix documentation related build errors

v4: Replace script based image creation with binman based command

v3: Use '-' for sub heading instead of '='
    Add location for template.its and sort the list alphabetically
---
 doc/board/qualcomm/rdp.rst | 109 +++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 5 deletions(-)

diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
index 99cf8eba57c..5ef7d6d27e2 100644
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
@@ -42,17 +46,112 @@ on your device with::
 
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
+These binaries can be combined into a flashable image using binman.
+
+Assuming all the required binaries are available in ${uboot_dir}/binman
+
+.. code-block:: bash
+
+    export bm=${uboot_dir}/binman
+    cd ${bm}
+    ${uboot_dir}/tools/binman/binman			\
+        --toolpath ${uboot_dir}/tools build		\
+        -u						\
+        -d ${out_dir}/u-boot.dtb			\
+        -O ${bm}.out					\
+        -I ${uboot_dir}					\
+        -I ${bm}					\
+        -I ${uboot_dir}/board				\
+        -I ${out_dir}/dts/upstream/src/arm64		\
+        -a of-list="qcom/ipq5210-rdp504"		\
+        -a atf-bl31-path=${bm}/bl31.mbn			\
+        -a tee-os-path=${bm}/tee-pager_v2.mbn		\
+        -a qcom-config-path=${bm}/qc_config.elf		\
+        -a qcom-lib-path=${bm}/QCLib.elf		\
+        -a qcom-appsbl-path=${out_dir}/u-boot.mbn	\
+        -a default-dt="qcom/ipq5210-rdp504"		\
+        -a spl-bss-pad=1				\
+        -a spl-dtb=y					\
+        -a of-spl-remove-props="interrupt-parent interrupts"
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
+.. _libqtisec_dbg.a: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/WIN.TFA.1.0.R4/apss_proc/out/proprietary/qtiseclib/output/ipq52xx/release/libqtisec_dbg.a
+.. _OPTEE: https://git.codelinaro.org/clo/trusted-firmware/optee_os/optee_os/-/tree/win.optee.1.0?ref_type=heads
+.. _qc_config.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/qc_config.elf
+.. _QCLib.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/BOOT.MXF.2.3.1.1/boot_images/boot/QcomPkg/SocPkg/Hermosa/Bin/LC/RELEASE/QCLib.elf
+.. _TFA: https://git.codelinaro.org/clo/trusted-firmware/tf-a/trusted-firmware-a/-/tree/win.tfa.1.0.r4?ref_type=heads
+.. _tmel-ipq52xx-patch.elf: https://softwarecenter.qualcomm.com/nexus/generic/product/chip/software-product/IPQ5210.NLQ.14.0/ipq5210.nlq.14.0-qca-oem-qartifact/r00036.1/TMEL.WNS.2.4/tmel-ipq52xx-patch.elf
-- 
2.34.1

