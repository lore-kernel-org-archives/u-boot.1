Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF3D1061B17
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 17:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37991840AA;
	Mon, 30 Mar 2026 19:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIxRSvM5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eyulusa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D45FB8409B; Mon, 30 Mar 2026 19:15:25 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3888083F5B
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 19:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UEOKSb1557463
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uX2UfzToEOy
 E5uiQ+yNa/SONegC8BBdZv7tcpI9D+Jg=; b=DIxRSvM5lfv990xpsTyE6/JaM8z
 M84C+rzY/BpEvcSyq35uIB0gJR5YjCmHcUSV+Z6s5djXmy80WmiiEh5GRQCtUoc8
 kqJGJySBwUfCKOSlrSXzE0NFWcYf3WHM5mV5lAJ2dyo7x912tdtft0pT/fbylapa
 8WQW9Fws+KjRIKm9eXfKdIuZ7LAmjF6dQmAmHokUj5C7gJfg/NV3gScFLy8P3DBi
 gKtgBUDGhjPOsMCzS+xn1P99xCS+xOltFrr0r3ft2KaaD29JMW5hOe4GpZUjwbJ+
 KaS/55hzeJcI+pIQzwf4iceVBjNUUCaySlmgUgwEdprecc2zzlCxNDygLRQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7twm0qhf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:15:21 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso11323771a12.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774890921; x=1775495721; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uX2UfzToEOyE5uiQ+yNa/SONegC8BBdZv7tcpI9D+Jg=;
 b=Eyulusa/dXolmPXiVQ5yzKkBEUvTZgIju10JFfrBbPmJz2A5XBNPQbDmAMjIwLz5XE
 TRYJJXJ5j0C2jefSprGUclG1K3t3aeIgqZMJM5jAEqX86lltUUXGQlDDbapSPap+8ZMk
 P/LtDEJDpuZ4wuupqJHJabm0YzF5yNy0Nha8Lf7ooOix7MtwhnF6AI6yaPhuOrfPA0LE
 HJRgBUaip371Snmm9gdn2gYFMs2ByIa256AERsDzeW45YyE6MoMkvovbGTRpNk6UPAcd
 BMRBbpGrN1Vr1dqU9KXEHHNRycjrVwjBsqjyMDg7evBIe4xdIrQSHAqqyhd+JI5h6RcK
 NQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774890921; x=1775495721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uX2UfzToEOyE5uiQ+yNa/SONegC8BBdZv7tcpI9D+Jg=;
 b=Wpfo3dPxS1UMK8NIVmCfJ6oJ09GRQb3LPLzgbghnksoaF6hgYYo0S5HnRS4R7eWE7y
 XwHUW5Vuw203OB40K8w6B7tJjhm4RNEJycgs75+sFs4berVTUl9/GBCWSjby4qg3V8H5
 q0zYYH5ZkTUg7r+xeYtHsucBxiMU5yvz5CBJSynUklifqh2nKFB9Qo3PjF/RXceDbxU6
 hyaehazm15FzZgJPBpiBWelr/CEYL6O8akdxgHZPRJThe4zqBSjcuaty/whQ/y2t6Jmh
 6EXJy3DsaKcP7kt335M0quu2ZUIzuUhMcJTnGyeLQYfrguwCC459nLKY6HxwouTsmh1x
 1CaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgaAYeOYtbuDCXZJZDV2iqlbKxMOe0SRtNVkQ3FFdwVjwran6jrgbBDkXvh2n3LSy45/xvtRg=@lists.denx.de
X-Gm-Message-State: AOJu0YxfBGaos4RWWSBp2TT9dIFfSQN7siUMmyYFklNK2QJI4VIMLauu
 2ixRLT5V7JtXxWhbpbpC38ZngYqIH82/2aXc9ccUMrz/np6apg58cm088rWWxs6Pr+XG8raAc64
 oj2Wk9S2b3xmAqe1L/YZXvLkWlcX/c6At2T1GOlJ9cSrqd1yml6mWvbFa
X-Gm-Gg: ATEYQzxCMGkZH1fivq+bOFPzDw2djiZ42JP3j50IObyyyJc62gSF9jmXW433acF5Bk5
 VVSFGgyCQPjXMLUHxk8Jj0OUjolsJj+Yjqw5IO2f/imPmTA6CxE+ZqTpYZUomGL5a5RVTEGdy6I
 gvg6mHbnkYhrA25XsRUt4bGy81Zwdk9cdGjVGyZDTuuEOhUTXd+vKA0ndoVxZeP8i8/t7pOOGSC
 5Nslp/8l42xKvYJ/93mINdUm3V4joQqHwRKb3ypOv41WEcKg7mjpuOmhkOzvYarr6hmXg7vQ9Yc
 MLNoS80TL/CvdPpn6WK2aDyKP5hWpZXRrCccptT7le5rLDllf48FjsRbZTpTVH9DQbjS2DNbsgS
 iHr7jMEua3GweCyjItDHeRQoq+MpDy5o4CXn5QpF48VaNKNru+SGXnobPzii9PNuqc/OxWhNeYV
 QV1FKBoCamnjO3VTHXlks+163pyjNayL5iBeEIn+3k
X-Received: by 2002:a05:6a00:9517:b0:82c:20ba:1570 with SMTP id
 d2e1a72fcca58-82c95ed90fdmr13306746b3a.29.1774890920531; 
 Mon, 30 Mar 2026 10:15:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:9517:b0:82c:20ba:1570 with SMTP id
 d2e1a72fcca58-82c95ed90fdmr13306693b3a.29.1774890919886; 
 Mon, 30 Mar 2026 10:15:19 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca8626518sm7349777b3a.52.2026.03.30.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 10:15:19 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, seanga2@gmail.com,
 sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, gchan9527@gmail.com,
 mkorpershoek@kernel.org, hs@nabladev.com,
 marek.vasut+renesas@mailbox.org, msp@baylibre.com,
 dinesh.maniyam@altera.com, peng.fan@nxp.com, quentin.schulz@cherry.de,
 kever.yang@rock-chips.com, jamie.gibbons@microchip.com,
 justin@tidylabs.net, xypron.glpk@gmx.de, n-francis@ti.com, h-vm@ti.com,
 ycliang@andestech.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 5/7] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
Date: Mon, 30 Mar 2026 22:44:17 +0530
Message-Id: <20260330171419.1117817-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IJoPywvG c=1 sm=1 tr=0 ts=69caafa9 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=WZ0Oi6wz51U_qUjvFLIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: fVQZB9LerMAtKZe3obnGxIlk4qJrGMCs
X-Proofpoint-ORIG-GUID: fVQZB9LerMAtKZe3obnGxIlk4qJrGMCs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfXzUhczOGhn+1G
 T5yEdwXCCdEE9HdB2t1nw/ecyUdjRcFRMCU6Y/OULelsLaWAudV6yx3WDj+TYWQZyaGjKMENPcb
 oVfYdjrTI1t4qFeP7ZiJARkHz5gk5VFer4kdlY7RI/5yBOxNjwgA633gP+mFPuaoVIn+Ddv/XE/
 Q2TC9yBgNvvCA1TbQbOMc8R+BvchHQCO0HtyL2GD3O2ebb4YQBlgFju4fq9q/EM2S2dzIV3ocvb
 NfCoEwqlGZlW51CXbrvTyZP9yQM5x4DYRbZ5u1CTg9BJP+Md3yRdoJs9fFf+pQE/rFbihtzQKVj
 9R3TXlgg6ERiF3/ZGfnlwzJeJOoALXw8w54V0zSiFjP+wjtPOOpFAhNIATYBe41IfiNBBuefQpA
 EeRRHkVLh2urt0jydxuo3rPdYIuX399lejtq+FnJyNGPVurEk7/+jLeKfPJV9IteOsCIwNwmWVo
 xDOifzHn5Odc0mwO+2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141
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

Enable reboot-mode functionality for all Qualcomm platforms that define
reboot-mode device tree nodes. The drivers gracefully handle platforms
without reboot-mode configuration, making it safe to enable globally.

Add config options:
  CONFIG_DM_REBOOT_MODE=y       - Core reboot-mode framework
  CONFIG_REBOOT_MODE_NVMEM=y    - NVMEM-based storage backend
  CONFIG_QCOM_SPMI_SDAM=y       - Qualcomm PMIC SDAM/PON access

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
1. No change in v3
---
 configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..4ecdc70f307 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -116,6 +116,7 @@ CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_REBOOT_MODE=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
@@ -127,6 +128,8 @@ CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SPMI_SDAM=y
+CONFIG_REBOOT_MODE_NVMEM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
-- 
2.34.1

