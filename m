Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AA1CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB3E84ADD;
	Thu,  7 May 2026 17:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PgQ8SFXr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WXs8qO7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C1684B76; Thu,  7 May 2026 17:36:38 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C593E84A79
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BxZtM2734080
 for <u-boot@lists.denx.de>; Thu, 7 May 2026 15:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=TraCz5pXViUZkYLSYXhkr/
 B7/seTzy94tOtVgfCciqA=; b=PgQ8SFXrvxfo4VthKlNEsYUubvvwjhxor66Vl9
 ZxJIyGaB864hL8kg4bO0Izrajl9ACKNRG1svgtR+BVrJmPXgc0C/cgd7/KGcUy3n
 oWjcbWpKuODEAdOvpom7ZKZ8rCpuOMagEmspOYkxC+W/LDkwaOudiOjphEWuTYNg
 H6T+pVOboeif/0mnJWKM/9+IogTLaKeUBy7h6cw+ZVGBpanLNKfbzUdZtc6dW1eU
 72O7jmmVqZb6qNzysTTiOa5qBMrYjNMK9FjBaFgqcuzK9H47Q2VHcIdLsaFjfAKz
 QSbTBt9Z8VdAlKP+URKzuRD+MegW8F/6hDfJGDsci9+00KhA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tbqrupx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 15:36:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fa2165c3eso709369b3a.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778168192; x=1778772992; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TraCz5pXViUZkYLSYXhkr/B7/seTzy94tOtVgfCciqA=;
 b=WXs8qO7A1JCHUkZKmNWmhQq6SL34vuAhfuAzhxi4PtOdw1hnAUjjC7woMQ7gNdK93M
 e3gEeQ3JwfjZVsDFw7YWM7mHP2FLXmiI2WPqbU7nqc2z2U/DrwueWAlXPH/Z1+52U9Bz
 o/ZKZyf9gBwrkLVHX0AMQKEeSW9SYRd9elDRN1AhUVOHRVJ0AB3uYc0vR1n214gb7v/E
 hvU7k1Z1/awrRTEn0iGp8U7vtM9Cfe2raR4ZedMqohmCr4N3iBaSh2tPF1+KiDL1Nn9Z
 BsSiJALg/KfYdJapnPiw/Eiprjx8Ter9LfqGJQ+iZWOxeORhTQAY+ULJexxnqNFa+usl
 whqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168192; x=1778772992;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TraCz5pXViUZkYLSYXhkr/B7/seTzy94tOtVgfCciqA=;
 b=OJOy1ofUqo37b4O/01/ou0Hxuse0Qcj5S8ZspdyG5+ZQjySCzoWxLyah91hnf8GuJB
 LG8HR8LoRP0wtfrXiVrp9rBqd6MTr91nN1FXmOaKioNp6c6trV9+UFuUM7QUbMngDOiJ
 44kHyn5BArkyh6RFtIsNo33KNgK7F0SudB6WMRtfinx6uIOsC2MTUG/N6uEWwPm6rTOZ
 Pv2MS5QiysehMI/6wAEXhUS/sZkeotxyhmWTxOChDUanr+uj1TntOLrNR7tbrCOcDA9+
 A2JH4mL0VO6nuV+0ma2QXf2qKUEk88Pv2qacx/V/9CDl1lJS1micoh9dy5dIFQsR5Ouz
 NnUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fZ6YZPIr8uKxNNSkVOestw0+7L13QpKRVT9W6qr+uwcdDs590DaSGpoSPZs77yuLt3dWDm9w=@lists.denx.de
X-Gm-Message-State: AOJu0YybFBwbCUu9fA9lH7GvTWt+iCv2OW0AzwfXNxyGPofieono7v4G
 buqvGe18o7YJ01KA9eGNVdkPugLu6eGgZKq91X5e5msdUBrmtwvcfd2nRstUsxvDZjQe1kdpUTz
 tQvRtADS/F5xNM8m3z8Ad1mmoGW6B4OumNcDRlUD1R2jUJHh7AkTpVLwv
X-Gm-Gg: AeBDiet3DmE/0VJVl4nSp6bWByyrK8GYdSLNkC5PnCotVBxkjrZ5J27N7fipCcDGXOS
 YFcCdKo2J8jmTwNRRgo+NvCm9zHvh8pp5vHMAqqgFyqdDiwCCQX1acFZlyn8+XXSsfcE6fLB+LN
 0HtrC33+S4vYoVy1Rke/v1BeWb59uGpACJAQlPRBbZ/sdIGdCPYeMaxBLqMR++smPG37PFTxtAO
 hv2bE7ZiJH0AOlauyiS6SB6jxBeGxfOkFux16+23pfnWe6D/uRnoMiNOjEFaLwGnA1qkW47BgQk
 /3i28YDRE011LGn1X2VpN5OemMJePOvB3JSYow902KM6NAmUQmQZhAvHfCYoY5tvnn3Hvo9Uk1j
 bCBNBwtcrFqRWxVGa77Pjm0zjNC/ZAHKY6fSubuMq/jZuipJyw827kKBSRmtl8wQo5DGIi6N9gw
 Sjkz0tzDG9G8mYIkiCDS9RCUrh3t10/FMgJRgeCjmcAd1p1nhlyOcETSTKkXda
X-Received: by 2002:a05:6a00:2d84:b0:81e:f1c3:89df with SMTP id
 d2e1a72fcca58-83a5e3592camr8017587b3a.50.1778168191747; 
 Thu, 07 May 2026 08:36:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d84:b0:81e:f1c3:89df with SMTP id
 d2e1a72fcca58-83a5e3592camr8017562b3a.50.1778168191193; 
 Thu, 07 May 2026 08:36:31 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839659498f1sm11969333b3a.17.2026.05.07.08.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:36:30 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 07 May 2026 21:06:26 +0530
Subject: [PATCH v2] doc: qcom: dragonwing: Improve build and installation
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-doc-v2-1-8d37ed72d8a4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHmx/GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNz3ZT8ZN1E02TjRIskw2SLFHMloMqCotS0zAqwKdGxtbUABKnm+VU
 AAAA=
X-Change-ID: 20260507-doc-a5c3a8b1c8d7
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778168188; l=5405;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hfW8yVhKMLzn8NXSoIddwfTzyoEdZQCTub8nBzQQLQg=;
 b=EC21gtYfe99Y9JWBvmNZ7TjRvyMtkBh7qvy7a7EPq76t+G8aEVviIIFZiALqXpn4Ti+4Q62S3
 ErzsjcRUWX8A6XM82kQQwwTy/oBu2+zs0HDXjq8awQPmqJjueVwm8eU
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: PtR8B84hJCwzLrZxSvg4wY0v9pNCKNZw
X-Authority-Analysis: v=2.4 cv=SJVykuvH c=1 sm=1 tr=0 ts=69fcb180 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=WtK8poceb6KjsvSHWLYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: PtR8B84hJCwzLrZxSvg4wY0v9pNCKNZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NiBTYWx0ZWRfXwgP1CPaTBSIM
 8cTI+hXg8CaBeO94s4GTuz3u9ySUYubKwit2u/f90r87LQkSzDOsmOGuzXEITrV9EQc5NjLAFIN
 +hnNNpBK6BN3aSyUMPmdQ3ircRk6XfKfVA3kjHF9MtVKoPtQzxXEeFB0xsSrENgrO7S/evseRD5
 cKoDiHTLlSIW7YRWgRueBf5LZsK5Zp8PdK12YDf6+ByaeYmRN1kjJqbUrteIMtFDL9w9ZOYqcmm
 /c2Cdp2Wy/ByosKil2v81b7QT8FLpzor0rFFmoJluNLOHht/zH7sXkePF3dOD2BVoYKwtb+opyQ
 +M1/I2KAHGtIkfDUgOhEFeAFBI5kkr5hTfwoJebLJ29NeiKfIlgDWaCO+x8aGXrnZhrVcaevhVI
 Z+vBUI+vz1KSaYpBHllvLhAQ81CoccQGVTQGVUiwX4N01tWyHxJz1/LXvXP3BL39b2uXEwplZ1h
 2qKDACdEdTLEEZfPh+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070156
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
Changes in v2:
- Removed reference to KCFLAGS
- Changed qcom_qcs9100_defconfig to qcom_lemans_defconfig
- Link to v1: https://lore.kernel.org/u-boot/20260503-iq9-v1-1-0eb29e4f8dc8@oss.qualcomm.com/
---
 doc/board/qualcomm/dragonwing.rst | 104 +++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/doc/board/qualcomm/dragonwing.rst b/doc/board/qualcomm/dragonwing.rst
index d4899415309..4491a33b76c 100644
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
 
@@ -16,33 +18,107 @@ More information can be found on the `Qualcomm's IQ6 product page`_,
 
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
+  $ make O=.output qcom_lemans_defconfig
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
+
+.. code-block:: bash
 
-  $ qtestsign -v6 aboot -o u-boot.mbn u-boot.elf
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
 
-Note that fastboot is not yet supported in U-Boot on Dragonwing boards, as a result, to flash
-back the original firmware, or new versoins of the U-Boot, EDL mode must be used.
+  $ fastboot flash uefi_a u-boot.mbn
+
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
base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
change-id: 20260507-doc-a5c3a8b1c8d7

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

