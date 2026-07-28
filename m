Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7D8C54F54
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 19:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD09A40A68;
	Tue, 28 Jul 2026 19:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4W_bm1Rp9zof; Tue, 28 Jul 2026 19:14:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8FC7A40A41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785266074;
	bh=da8n/PBD02StScdc42Nm1EbPbxzMaVjBl+b3oZwnDHw=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=Hada0l5F1oU6iBeDQkE1LgzkAC8eSq72gbzMmYzT/3LFctSOvl2iGp/a7THXADtUc
	 TCF2VfYkWw9kw1WsqloDLbsX8U+u4iiP3SE5ZIVXSSDNF6ftNsOUPoXxMvkIOqoSxZ
	 A0nfa6MxEFJh916D7OckZrLAmO45nvAQoj8f5Hz/Q9NoLdbdspEDbJPuaZUACxpIjl
	 acwMiFZ1Oh1gMNGIpW8wAu01iUxTZ6g5lyF6hij2W/iRB3mJWiV0UKmK0Iqvu1qxbk
	 EG9oY5Qp58gNEfxEm2v2M3kFu/r/E9FnzFL4EfdOM6hsorojWqNT2mCQCG1N1qZ9no
	 jT+QYW4uCOeDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FC7A40A41;
	Tue, 28 Jul 2026 19:14:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A62C26C
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30DDC80F5A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXf65g9aqqYF for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:14:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7B89B80CA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B89B80CA6
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7B89B80CA6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:14:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5770A8494B; Tue, 28 Jul 2026 21:14:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F35418404D
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 21:14:25 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIC62Z3715475
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:24 GMT
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpvtva1e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 19:14:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so209834a91.0
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 12:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266063; x=1785870863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=da8n/PBD02StScdc42Nm1EbPbxzMaVjBl+b3oZwnDHw=;
 b=TyQdt10uZHoWhwAg9QhAwuWvKfcdPceB7QCdBJFbH4qDCfjOvqt776YulzOFBkNCiz
 yIqCvBI2TzLJT0ykNhHI6AokkK3CwXB63fO8nQhJatiS9ZXSRzU6yNN3qxX1KjLb0Hap
 MvetSk4A8COhcsNZCkJIH0WeNhETrMHf2L9TU/1pfQtCcZXOt2OnCfv/rEgsAKHNlVMm
 0ASRwY2HbTTuEyJ3zzMvZzOjvEEGb1oADR+asU1156VO+VvrQ8dadItb2l1F8EimcIug
 gUR242EOTu3wNx4RuS6PDwUyfvoLkx9xIjalTuwtKkgks68ftJ7i1BoQYUF0eiTiXx9h
 2jMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYZznZ+k/5Z+dHzgTCXYZxY56LK1uqigV7v/J5BlccxoAUvzm6vq7HQkmC6mNNXnYG7Wss+Gs=@lists.denx.de
X-Gm-Message-State: AOJu0YzivZGlC5wqi/ICYG67zcptt436lNwKszmURemZbE9AmmFJWU/n
 LdI8gksRJ6BjgyP7OOHYx6ehnyUg0uKKDaerPHyL9VheR5lrgG//T4EROXToyYqlEMPGw/pbKys
 8yTb12k/qDME64iEmvRpsGQe7emDpaDsQwYRG6vxnl70wzb9pTyEwR6PI
X-Gm-Gg: AR+sD10ncKWbQWc7+mlF+yV9ODCxhy/wpikDE03MhpP5+m6G3GD41hhClenSsh2ogDX
 34kHjuoL7958sYv1VwDMHO833HwXzDrapoxWt9IxI99WVDrnfLwifP0txgG7h3INBMjNo3dK6Q7
 d53OI27T0SRdxqVKsSRRJdYcD491EDUAHGPt+BAQRrbepJYIES5gN2dJp4XwPvK+D36Ys/sGmAS
 RltqbRmVyXXi21ci52hlXsDBGvPBV4vzegcsjB0ppTy9xcNi1F+TnXub0orqDH2Yj/Xc6J6N9kg
 MtKcfO62eGh/9l+quFrMZIlb8Pf9ZsKZ6C4ICYmgIqpk4nfCqT3ZgENxPGtDiXVIPAxohGX7Tht
 BEEtI7USp0+vqrP341wmoEsgaRybI49k3aABWv7JZfxvYRXz3D3zdmViiZLExKx7sZ55gFgA2dU
 RVdegMF5T0QI1yOtJQUGo=
X-Received: by 2002:a17:90b:3d46:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-38f6a44b293mr3628267a91.13.1785266063246; 
 Tue, 28 Jul 2026 12:14:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3d46:b0:37f:eda5:5169 with SMTP id
 98e67ed59e1d1-38f6a44b293mr3628241a91.13.1785266062677; 
 Tue, 28 Jul 2026 12:14:22 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d373c3sm1261294eec.23.2026.07.28.12.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:14:22 -0700 (PDT)
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, quic_varada@quicinc.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, linux@smankusors.com, ilias.apalodimas@linaro.org,
 nathbappai@gmail.com, luca.weiss@fairphone.com, jbx6244@gmail.com,
 peng.fan@nxp.com, ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 1/5] misc: qcom: Add HW-Info aggregator driver
Date: Wed, 29 Jul 2026 00:43:57 +0530
Message-Id: <20260728191401.849143-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
References: <20260728191401.849143-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UllohroRluoLpk_eIZV12KQ-LmAAwXSa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX/WFZ1V6ER0kG
 4kdIEaUEKJ7BbUUO401jBpwVgpYrq9z06QBgYnh1lSm57Jb2pY8726lgC2EjXY0TxgPebS5fuDI
 xTRN56UZmvVNFMFYuetW5gzh/S1kCy8=
X-Proofpoint-ORIG-GUID: UllohroRluoLpk_eIZV12KQ-LmAAwXSa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE2NiBTYWx0ZWRfX19EcAyGZjpBo
 h6larslP/oM/E0U8tqiRkYv0SOwRkjopf9fh5aah8/T8oIpHW1e+mde1x+KtmXNEOGkLMuKFG2D
 lqoGuGmAswfhoxJQ7VtSznZf5hIuSsY1+lj0Id5BPAUIOhs3kAVVhw1ZusxbBCkvzIsTAbbb+E+
 3XRS3XoW7M6yej7ROlLyD3Cq0edEg+Q/sJ5r2BhEtLunKHxc2WgCU126pgsJqWctk/eHfCh57TL
 kBV/5b1Am3H6a/z3JRSyb7uz0KqhEDMs3sVwbxPF6bbdbFp2G6PQjbgnPTfRTaM/h9XJd0JweT2
 EkrX0FmBsHmeCcvBlYSjFxOCzpuNqZ5cOYJh4p7TiWIgQeQfMfvtF7PU82pcMnVR5GwDfmHCxPO
 SvVKlf5498fkJoJOw/qUpkwHLJyS7kya2AaQMmrwMQh4uXjJr/DxBahoWdGuNd7VguqO+LbUOa3
 6cdcBfw0vu6QcbWTczw==
X-Authority-Analysis: v=2.4 cv=dOiWXuZb c=1 sm=1 tr=0 ts=6a68ff90 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nHztRHiazSddbDhVNzsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280166
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=da8n/PBD02S
 tScdc42Nm1EbPbxzMaVjBl+b3oZwnDHw=; b=K0izNQnWyXQN9jsuZ3smTLq7SYx
 kRXX255DYRpzBRUR/izYSej5Uk1TVZ4Dsz/qpJGtZZBxR0078fkEvRhWHJm4eKPC
 6I66CBZIoP9mjarSyAV17RcaKgflNHKdnkqRPyFu4Gr6DC/6qaCJNapl8kD4k3sw
 1N502MUtgRtQn13G+ecy3X7gEY8DmJwfSwJozHHdWKMZ+4snqsJsPo8AH5A0e/RE
 ++/skz72grLxFc/q1hdFEbzoZKC7nlgSeTWdPtrektgXLs+1d+4r/6jnRey62f80
 KSWNK4qTnwLCZvCis4mi1LcStJzuPZYIev3L2IwkPFZON3hINNdojJmQaVA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785266063; x=1785870863; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=da8n/PBD02StScdc42Nm1EbPbxzMaVjBl+b3oZwnDHw=;
 b=XW9T0hUesKD4oG9T6guvsl/RVqpYB47jDdvbScrx5AZ7xBDJOvxD9GW8lV5lJvnuFa
 PU87OiY72EYAzwZXcPBQRITO6SUHiZVqw8qusHr7QJNY0QHTDyZbEeBTjzLIFcK6Tq3S
 lUZ3c8lyc8lQN3mZsxpirILpW2CAZVYL/ZYM3uyIDcygXhbjl3SDIKMksgN0j2qONc1g
 VNevYrYYU6IMiF9E2rQi5noF+jqoGUtF5vgwFYtGKkDH3EQE23+Mhii+St1Pdun+AG2W
 3uZFFDRcewLoDP9usYemWQeBLGyPkSG6au6B0Q3y7pC7PTVUZp6QC4P8scOdmghR+a1R
 eHpA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=K0izNQnW; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XW9T0hUe
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aswin.murugan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K0izNQnW";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="XW9T0hUe"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a generic driver that binds to a U-Boot-only "qcom,hwinfo" DT
node holding phandles to the existing IMEM/TCSR syscon nodes plus
per-SoC offsets. This provides a common interface for reading the
IMEM boot cookie (used to detect boot storage type) and the TCSR
SOC_HW_VERSION register.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/misc/Kconfig       |   9 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/qcom_hwinfo.c | 160 +++++++++++++++++++++++++++++++++++++
 include/qcom_hwinfo.h      | 109 +++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/misc/qcom_hwinfo.c
 create mode 100644 include/qcom_hwinfo.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index bde5c640de8..b75b2e4c70c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -93,6 +93,15 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_HWINFO
+	bool "Qualcomm HW-Info aggregator driver"
+	depends on MISC
+	select SYSCON
+	select REGMAP
+	help
+	  Reads the IMEM boot cookie and TCSR HW version via a common
+	  "qcom,hwinfo" DT node.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e2170212e5a..2a7e3379d83 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_$(PHASE_)QCOM_HWINFO) += qcom_hwinfo.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_hwinfo.c b/drivers/misc/qcom_hwinfo.c
new file mode 100644
index 00000000000..822968234d5
--- /dev/null
+++ b/drivers/misc/qcom_hwinfo.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm HW-Info aggregator driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Binds to a U-Boot-only DT node (compatible = "qcom,hwinfo") holding
+ * phandles to the existing IMEM/TCSR syscon nodes plus per-SoC offsets.
+ *
+ * Example DT node (arch/arm/dts/<board>-u-boot.dtsi):
+ *
+ *	qcom_hwinfo: qcom-hwinfo {
+ *		compatible = "qcom,hwinfo";
+ *		imem = <&sram>;
+ *		imem-boot-cookie-offset = <0x0>;
+ *		tcsr = <&tcsr>;
+ *		tcsr-hw-version-offset = <0x8000>;
+ *	};
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <qcom_hwinfo.h>
+
+struct qcom_hwinfo_priv {
+	struct regmap *imem_regmap;
+	u32 imem_cookie_off;
+	struct regmap *tcsr_regmap;
+	u32 tcsr_hwver_off;
+};
+
+int qcom_hwinfo_get_imem_cookie(struct udevice *dev,
+				const struct qcom_hwinfo_imem_cookie **cookie)
+{
+	struct qcom_hwinfo_priv *priv = dev_get_priv(dev);
+	const struct qcom_hwinfo_imem_cookie *c;
+	void *base;
+
+	if (!priv->imem_regmap)
+		return -ENODEV;
+
+	/* IMEM is plain mapped SRAM; safe to dereference directly. */
+	base = regmap_get_range(priv->imem_regmap, 0);
+	if (!base) {
+		dev_err(dev, "Failed to get IMEM regmap range\n");
+		return -ENODEV;
+	}
+
+	c = (const struct qcom_hwinfo_imem_cookie *)((u8 *)base + priv->imem_cookie_off);
+
+	if (c->shared_imem_magic != QCOM_HWINFO_IMEM_MAGIC_NUM ||
+	    c->shared_imem_version < QCOM_HWINFO_IMEM_VERSION_NUM) {
+		dev_warn(dev, "Invalid IMEM cookie magic=0x%x version=%u\n",
+			 c->shared_imem_magic, c->shared_imem_version);
+		return -EINVAL;
+	}
+
+	*cookie = c;
+
+	return 0;
+}
+
+int qcom_hwinfo_get_storage_type(struct udevice *dev, u32 *storage_type)
+{
+	const struct qcom_hwinfo_imem_cookie *cookie;
+	int ret;
+
+	ret = qcom_hwinfo_get_imem_cookie(dev, &cookie);
+	if (ret) {
+		dev_warn(dev, "Failed to get IMEM cookie: %d, defaulting to UFS\n", ret);
+		*storage_type = QCOM_HWINFO_STORAGE_UFS;
+		return 0;
+	}
+
+	switch (cookie->boot_device_type) {
+	case QCOM_HWINFO_UFS_FLASH:
+		*storage_type = QCOM_HWINFO_STORAGE_UFS;
+		break;
+	case QCOM_HWINFO_MMC_FLASH:
+	case QCOM_HWINFO_SDC_FLASH:
+		*storage_type = QCOM_HWINFO_STORAGE_EMMC;
+		break;
+	case QCOM_HWINFO_NAND_FLASH:
+		*storage_type = QCOM_HWINFO_STORAGE_NAND;
+		break;
+	default:
+		dev_warn(dev, "Unknown boot device type: %u, defaulting to UFS\n",
+			 cookie->boot_device_type);
+		*storage_type = QCOM_HWINFO_STORAGE_UFS;
+		break;
+	}
+
+	return 0;
+}
+
+int qcom_hwinfo_get_tcsr_hw_version(struct udevice *dev, u32 *hw_version)
+{
+	struct qcom_hwinfo_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->tcsr_regmap)
+		return -ENODEV;
+
+	ret = regmap_read(priv->tcsr_regmap, priv->tcsr_hwver_off, hw_version);
+	if (ret) {
+		dev_err(dev, "Failed to read TCSR HW version: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_hwinfo_of_to_plat(struct udevice *dev)
+{
+	struct qcom_hwinfo_priv *priv = dev_get_priv(dev);
+
+	priv->imem_regmap = syscon_regmap_lookup_by_phandle(dev, "imem");
+	if (IS_ERR(priv->imem_regmap)) {
+		dev_warn(dev, "Unable to find 'imem' regmap (%ld)\n",
+			 PTR_ERR(priv->imem_regmap));
+		priv->imem_regmap = NULL;
+	} else {
+		priv->imem_cookie_off =
+			dev_read_u32_default(dev, "imem-boot-cookie-offset", 0);
+	}
+
+	priv->tcsr_regmap = syscon_regmap_lookup_by_phandle(dev, "tcsr");
+	if (IS_ERR(priv->tcsr_regmap)) {
+		dev_warn(dev, "Unable to find 'tcsr' regmap (%ld)\n",
+			 PTR_ERR(priv->tcsr_regmap));
+		priv->tcsr_regmap = NULL;
+	} else {
+		priv->tcsr_hwver_off =
+			dev_read_u32_default(dev, "tcsr-hw-version-offset", 0);
+	}
+
+	if (!priv->imem_regmap && !priv->tcsr_regmap) {
+		dev_err(dev, "Neither 'imem' nor 'tcsr' regmap found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id qcom_hwinfo_ids[] = {
+	{ .compatible = "qcom,hwinfo" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_hwinfo) = {
+	.name = "qcom_hwinfo",
+	.id = UCLASS_MISC,
+	.of_match = qcom_hwinfo_ids,
+	.of_to_plat = qcom_hwinfo_of_to_plat,
+	.priv_auto = sizeof(struct qcom_hwinfo_priv),
+};
diff --git a/include/qcom_hwinfo.h b/include/qcom_hwinfo.h
new file mode 100644
index 00000000000..994a7d0bb20
--- /dev/null
+++ b/include/qcom_hwinfo.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm HW-Info aggregator driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Reads boot-time hardware info (IMEM boot cookie, TCSR HW version) via
+ * syscon regions, using offsets from the "qcom,hwinfo" DT node.
+ */
+
+#ifndef __QCOM_HWINFO_H__
+#define __QCOM_HWINFO_H__
+
+#include <linux/types.h>
+
+struct udevice;
+
+/*
+ * Storage type values. Match enum mem_card_type in
+ * arch/arm/mach-snapdragon/qcom_fit_multidtb.h.
+ */
+enum qcom_hwinfo_storage_type {
+	QCOM_HWINFO_STORAGE_EMMC = 0,
+	QCOM_HWINFO_STORAGE_UFS = 1,
+	QCOM_HWINFO_STORAGE_NAND = 2,
+	QCOM_HWINFO_STORAGE_SDCARD = 3,
+	QCOM_HWINFO_STORAGE_UNKNOWN,
+};
+
+/* Boot shared IMEM cookie constants */
+#define QCOM_HWINFO_IMEM_MAGIC_NUM    0xc1f8db40
+#define QCOM_HWINFO_IMEM_VERSION_NUM  0x3
+
+/* Boot device types from shared IMEM */
+enum qcom_hwinfo_boot_media_type {
+	QCOM_HWINFO_NO_FLASH         = 0,
+	QCOM_HWINFO_NOR_FLASH        = 1,
+	QCOM_HWINFO_NAND_FLASH       = 2,
+	QCOM_HWINFO_ONENAND_FLASH    = 3,
+	QCOM_HWINFO_SDC_FLASH        = 4,
+	QCOM_HWINFO_MMC_FLASH        = 5,
+	QCOM_HWINFO_SPI_FLASH        = 6,
+	QCOM_HWINFO_PCIE_FLASHLESS   = 7,
+	QCOM_HWINFO_UFS_FLASH        = 8,
+	QCOM_HWINFO_RESERVED_0_FLASH = 9,
+	QCOM_HWINFO_RESERVED_1_FLASH = 10,
+	QCOM_HWINFO_USB_FLASHLESS    = 11,
+};
+
+/*
+ * Boot shared IMEM cookie layout, populated by the bootloader.
+ * Do NOT mark __packed - breaks natural alignment expected by firmware.
+ */
+struct qcom_hwinfo_imem_cookie {
+	u32 shared_imem_magic;
+	u32 shared_imem_version;
+	u64 etb_buf_addr;
+	u64 l2_cache_dump_buff_addr;
+	u32 a64_pointer_padding;
+	u32 uefi_ram_dump_magic;
+	u32 ddr_training_cookie;
+	u32 abnormal_reset_occurred;
+	u32 reset_status_register;
+	u32 rpm_sync_cookie;
+	u32 debug_config;
+	u64 boot_log_addr;
+	u32 boot_log_size;
+	u32 boot_fail_count;
+	u32 sbl1_error_type;
+	u32 uefi_image_magic;
+	u32 boot_device_type;
+	u64 boot_devtree_addr;
+	u64 boot_devtree_size;
+};
+
+/**
+ * qcom_hwinfo_get_imem_cookie() - Get a read-only pointer to the IMEM cookie
+ * @dev: qcom_hwinfo device
+ * @cookie: Returns a const pointer into the live IMEM region
+ *
+ * Validates magic/version before returning. On failure, @cookie is unset.
+ *
+ * Return: 0 on success, -ENODEV if imem regmap unavailable, -EINVAL on
+ *	   magic/version mismatch
+ */
+int qcom_hwinfo_get_imem_cookie(struct udevice *dev,
+				const struct qcom_hwinfo_imem_cookie **cookie);
+
+/**
+ * qcom_hwinfo_get_storage_type() - Detect boot storage type from IMEM cookie
+ * @dev: qcom_hwinfo device
+ * @storage_type: Returns detected storage type
+ *
+ * Wraps qcom_hwinfo_get_imem_cookie(); defaults to UFS on failure.
+ *
+ * Return: 0 always
+ */
+int qcom_hwinfo_get_storage_type(struct udevice *dev, u32 *storage_type);
+
+/**
+ * qcom_hwinfo_get_tcsr_hw_version() - Read the TCSR SOC_HW_VERSION register
+ * @dev: qcom_hwinfo device
+ * @hw_version: Returns the raw register value
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_hwinfo_get_tcsr_hw_version(struct udevice *dev, u32 *hw_version);
+
+#endif /* __QCOM_HWINFO_H__ */
-- 
2.34.1

