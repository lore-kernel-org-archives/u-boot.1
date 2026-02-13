Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB146EDF148
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B0E880FA1;
	Fri, 13 Feb 2026 12:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CPetq3fL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQ1hzlOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D59083AA9; Fri, 13 Feb 2026 12:27:40 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A415B80B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7bR471642029
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=xMm9sMrC21U4TueHOK/T5B
 f0osQMyUTOwjOhnqUFZsQ=; b=CPetq3fLeAJYjYe8YU7Jpp8hPScLi0J/VjEYf0
 07ZN5ycnk3MIHUiPhPHxVSSuwBpHuQ3GNUtCtNS3oy3AcqYcMyDRrimuOsUAh6oZ
 X2CfZyYfWtQxzaI8Z+349VCz+5qkzopcuJGGpPv/MamkFcSo6zsxedSDSNnYEX/V
 Df9uV1ISgGThRqamnNUEJ6tLtUL7Elq2ftN9cK6tstxSLsjCa0ZUYuJSWcwLx14l
 LXoHCK0LosLBr9TsNBiivtE9sjvlJCiSj+8VBM69QqMauv/S6AI3P3jlxwPc6QT3
 XKVyptasTK4G5rNVrdY/po5XbLakRQ5Exob5FAiQWNWTfvLw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv2k1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:27:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ab4de9580dso26479515ad.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982055; x=1771586855; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xMm9sMrC21U4TueHOK/T5Bf0osQMyUTOwjOhnqUFZsQ=;
 b=kQ1hzlOIg6DvLvnMv0RWiBvOUeqHqCtYJkmjmHBbey85G5bLAfXW1wE37nSIpl4wDq
 dfWN2fjXuCATKHJVoplLcVZLesv4wB+IntYasKAhnrqZs3aDGu8XtkGwdL96yy/q0BnL
 BYW1sTRc5Z1wwqEY603KtUGO+a/hUprdjCka43u9dd/rYLkg2J80ofsuNrKaL5srAHog
 Ij1qJbP74kp1apFPqewH/xYYcrAcK6rElOM9kMfBSwLwsVSw+Wan3fwRox0EuE96BqA0
 MUHn81GaLRG+Sr83rpUIvlzFbwY/y0vXMdjJyvp2VHgbFklqLumEF67n3FtOXhVTTpik
 rBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982055; x=1771586855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMm9sMrC21U4TueHOK/T5Bf0osQMyUTOwjOhnqUFZsQ=;
 b=Nky8jfNDdFDce5VL0jDHzBLzcd6BEyT0O2pUaAk24RMksjxEVH0rvK7SNZARkH6aFA
 QOZ6rKZb/25afQHkXhXzQgFQC+APOAcFrfPTigGZ8Nio6K+yTK/9teREzvdfTcAyylb7
 f6su9DraviSgLiJHBSl2xApL+VIOLEwDd+zLwX6YU/58UOsuctBjoY039rTbfWvloeKq
 Bspx4u2dVv7kTpWEGY4zku4biyS3eM0e8OVvukiJpj+s5F+n3ve5EVgCAF2w69gjmO45
 rw0Mdo/AnTQiO/GkUNo/20Yj4fDZTeT/YVRWMEFS71vM2bLlJwBwP8LT3ekDYIQfwcQS
 TF1w==
X-Gm-Message-State: AOJu0YzW8Z791tIZ1/BVyMBm/OxTlBv65O2aI6+9NpOWpXCJNVR6Ko+4
 QVr2KlBdNassjZ+FHMMYbPnq/5egdguzQDYwFhpov9O/qtRtGdpqpZuiLncCVwK61Vvl49+yNR3
 qHClSeNROJKtcXL4gEaqS+gIDmW9+pKh60YqgrRHpG1dcXz1iYE6njfdsN+gAT5Px
X-Gm-Gg: AZuq6aJnOhlE+dAefl/TGJWRp+b9CGpS1mLyqn4Ym/QtLjg3lmm7kcUn0/00A/YGggi
 n3uPcpQOlng0ewee3Kp6g1hnj4Aotyr7sAiNkQ1L+fmyt9i4yJO5e1CH4JbhqYOBchVuROn6oJP
 jlRNhjkGztDQQLk/K6/bpndmIVdAJ4bso1jCAteJYk9kDqhlKmqnoUAPSoRcl9QnFHduFi/YqkB
 DgsJ2O5ZTgrTHoGIgK7FWfx87c20m2Q/0yww3ulG0F2m9Lk2cX8e2J5xXFAwzdxQDQH2d4tHMTm
 Vcv9cIlzUad8aubvSpoQMYnIn3acrcxc88LGOyGW8Fv17WlbjsQMzVGQ5sX3n95Uj1HhNkxRDAg
 UEz/y7d0aqdfCQmV9lAY6mHX94QL1CoC8dGGllOmv552pXY+/1poyMOWLDFeNvqwJ7rDi+o6DKE
 OjmOzFU4X5qYczHcg4wzN694NlOssKOG+9O4Vct7Kw
X-Received: by 2002:a05:6a20:3ca2:b0:394:5830:8008 with SMTP id
 adf61e73a8af0-3946c9501c9mr1572074637.78.1770982054849; 
 Fri, 13 Feb 2026 03:27:34 -0800 (PST)
X-Received: by 2002:a05:6a20:3ca2:b0:394:5830:8008 with SMTP id
 adf61e73a8af0-3946c9501c9mr1572035637.78.1770982054388; 
 Fri, 13 Feb 2026 03:27:34 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:27:33 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=200/6=5D=20qcom=3A=20Add=20NVMEM=20bitfield=20support=20and=20reboot=E2=80=91mode=20integration?=
Date: Fri, 13 Feb 2026 16:57:11 +0530
Message-Id: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eZBwqB1FYYaRqPX4rAGZJz6FDWAIiPeR
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698f0aa7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=5KLPUuaC_9wA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=l-UPrZbCS1wS8v9bHbkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfX1EhexV3DiGAV
 ofr+w7Hb2ckwrTlnhtTXDEabyqIjpl/OmmETz1DelWv/3qmBkkz1H7SjT18/OJZObXww9kRiZVT
 mPhtSk9kYCpEZbMIPDtr+mmA8kzHp/RePE43mWa/Tpeqr1jsyi4JbfqO2PEp+iitoQN3Is3yw44
 JxkAAwnvGRuP24r28/YkhsSTgCe+h88q67VxmXq/zKJ7qVTYDhRVpQW9WGjBbR6z18ATkvKo40a
 t9r9XGAjHYzMRbV3mQT3J4u+NOVau6l0WEc5KFQt9agOh5mCT4z91NARJPSmEw2sh2/nRN/K20k
 VQqIMqbtdTqfZJu5E75j67l7q2XdPTfm8ovWbiGXbvZFxCuzzPCsorFXavxDdIucW77nE/Aa5Kl
 sVLySWXPCHYcM12Y6799G5LLosZKLcwdfzsEmotUnm5ZmoRIFYsaIkWgFyVE1osiO1i4UFI8QcY
 5WyN7X5Mnkjyuc3QQ8w==
X-Proofpoint-ORIG-GUID: eZBwqB1FYYaRqPX4rAGZJz6FDWAIiPeR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130087
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

This patch series introduces bit-level granularity to NVMEM cells and
adds complete reboot-mode support for Qualcomm platforms that store
reboot reasons in PMIC registers.

Qualcomm SoCs rely on PMIC-backed reboot reason storage to implement
features like "reboot bootloader" for entering fastboot mode. However,
these PMIC registers often pack multiple fields into a single byte,
requiring fine-grained bit access that the current NVMEM subsystem does
not support.

In addition, PMIC generations differ in how reboot-related data is
stored: older PMICs use PON (Power On) registers, while newer ones
provide SDAM regions. This series introduces a unified, NVMEM-based
approach that works seamlessly across both architectures.

This version also integrates reboot-mode handling into Qualcomm board
initialization, enabling automatic fastboot entry when the reboot reason
indicates bootloader mode.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

---
Changes in v2:
1. Replaced custom reboot reason handling with the standard U-Boot
   reboot-mode subsystem, per review feedback.
2. Added bit-field support to the NVMEM core using the new "bits"
   property.
3. Introduced the Qualcomm SPMI SDAM driver for unified PMIC storage
   access.
4. Updated the reboot-mode driver to support variable-sized NVMEM cells.
5. Added device tree configuration for the QCS615 RIDE board.
6. Enabled reboot-mode in qcom_defconfig.
7. Integrated reboot-mode detection into Snapdragon board
   initialization:
   - Added qcom_handle_reboot_mode() in board_late_init() to enable
     automatic fastboot entry on "reboot bootloader".

Link to v1:
https://lore.kernel.org/all/20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com/
---

Aswin Murugan (6):
  reboot-mode: Use actual cell size instead of sizeof(u32)
  misc: Add support for bit fields in NVMEM cells
  misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
  mach-snapdragon: Integrate reboot-mode handling
  dts: qcs615-ride-u-boot.dtsi: Add reboot-mode support
  qcom_defconfig: Enable reboot-mode support in qcom_defconfig

 arch/arm/dts/qcs615-ride-u-boot.dtsi    |  26 +++
 arch/arm/mach-snapdragon/board.c        |  56 ++++--
 configs/qcom_defconfig                  |   3 +
 drivers/misc/Kconfig                    |   8 +
 drivers/misc/Makefile                   |   1 +
 drivers/misc/nvmem.c                    | 241 ++++++++++++++++++++++--
 drivers/misc/qcom-spmi-sdam.c           | 200 ++++++++++++++++++++
 drivers/reboot-mode/reboot-mode-nvmem.c |   5 +-
 include/nvmem.h                         |   4 +
 9 files changed, 517 insertions(+), 27 deletions(-)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c

-- 
2.34.1

