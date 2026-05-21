Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EB6CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7A984855;
	Thu, 21 May 2026 20:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnxnXLe3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QsZras4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6468B84857; Thu, 21 May 2026 20:06:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B30784825
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGk1Zn2765185
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wWMgOAs2lXs
 jr3JU+lN/WP4VQjSLcc9VMg8gRhKQYp8=; b=NnxnXLe3jmQ22l/DnLj7bcAyQIv
 2m4b+VVnyEOlqii0Lew/9kxhJ9CCbO4fB45iCUQSOORtuppDpjtx+XKWWE+4CoDj
 xmVzq9dUPu4MmMA69kEGg2aqwk3/+2hiut41hq9C/bf4II/7tJRsRYu1i0Lmrcgv
 lWfsICfsCoS7IjbcJhLZ4lRXCUblfAlbawBsAnYmySjqjMhdXg03g+ZDUmg/FCzG
 zBCj4NRgmipPoIWVoz+qnaKj8DKETYyFCCWNh9HDLZ+ySL1ZCW1vVRca+2Nul+HW
 iGEYMHzjXoa0t+p4hAX5UkdDmnH2EmG8L8tUChb9JqXtfi4Y7iGb9dslSRw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea3u7rxvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bd04e4fe3dso114368885ad.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386813; x=1779991613; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wWMgOAs2lXsjr3JU+lN/WP4VQjSLcc9VMg8gRhKQYp8=;
 b=QsZras4UJeSFVuNB+FxymyoTrsJvRUQX8EPEvxuH7//spOK8EpVg3gWpwKBdLNFPOe
 IoHRsEKVpAPgkMBlwTNeT8MOXxcod28TLsFYtoRwNlACYuriJg5mU1ZPDPcLyjrfl3Uh
 aCYFxjbxcHFjWPK3jPAvFo51t3xF7EUKAOsNnO6BAp16LVimlVWorNTss04O7V35UhAH
 yUeTQsDcfAUcsCQH8ODTeYgoWMzJaYECkmrVWWyTvYddkxgDrY7ZcQWtCRD50p3MzBeC
 dSkHCsCatISyc2Hp+Zso0wN28OHnjekTDIkohrJk/YORia/e13vBC5rAHSfWHaiKF6nV
 0V1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386813; x=1779991613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wWMgOAs2lXsjr3JU+lN/WP4VQjSLcc9VMg8gRhKQYp8=;
 b=GhEQ6Bqjvhuuv9KjqVcKkE99Ihm27M4C/EXhC5EfiA3tUMkF59oHcUcLg4IvYs/0vM
 OUWDDHqM6G/vYJwE81Ep067NwYHOUKbCtvHiiHjZ2wLrr8QKxME1ei0E2rR9601/sSIt
 dcgPcAIb68B+Hq5f8ezlgbGgO/BpyW0tiCWNWlFv3GJizpk6bjnCnWPUJlm3NWlBzn//
 QavuRuJ+zSFjYvbmKNvNVHwY+iftKPgGVzVgFE8DyNZmhHlKzHYN7Q4iSnqIv8YYxIxM
 DwQoIAGrbVu9HBg5xQ35M2c1jepqorcTlO8T2eIPfagWsVDvr12Ye5e3rXdkjZ9hoPfQ
 9DHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JQRad3f9/a2whu9VAtp3zUrSZQOzVKjd3vG8c+RhAQfZAmp9OU2FeyYW7nSPcOGdIgSg/vps=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+vMFFZc9+2xwopH2d90E97PxAI/U0T0Sneaw/wywQviLi4lwS
 GmGE76NpDsfo3BPlVQK6j3eYEd0NjnMxVgMAwduqQm9qUZAhZGsTSEfgRMQOT7d781S4/9ZW8N1
 IR/1le6CXtWz8sTjFKolPpuRwfwE1zkmIluktG/HS81vNPp6e+HidMlCg
X-Gm-Gg: Acq92OFuqKPF7ioXom1IlH7AbX6iHPKvhcFpmbM5WUw8ng89pmd70g3gvfNNju8Rvj3
 Muyt4FfFLZnvG6SqGO8UDLiC9SotIvrASZ7kHStvrtG2eDwSxm+2LhiSg3Enht0eNUoRo/2HNhz
 H4kTW4/oCxTdmAVjJJP6pTi4DrZVwvecmL8P9WOsnZG+KiEJcfbNnivLtFNSLBM2wVpZalBfBxt
 EDvwpMDISsct8QEBFG/G69ggOLSl4YjugACDqDfuvGtAp9F4BEBx4d4YajQ693PzO/C4Anncx6d
 5PrNLKaTvXsCdDYWL0B4hw0opt1I1vzg0ugHitntisLP77FRvZKF1RPsWOb9oMXbOwUa5a0xmh6
 zp9RlQvsIyEUHjkE47aiFW69S9nw4zyKZIoytaWVBrgTWDZ4zZlAUG8fIgCFw/7dARDxn4a2COX
 dDFP5LX/KibPeYynAuWGH68XyAdegQmGgUDgvUQyjH
X-Received: by 2002:a17:902:ce92:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2beb06924e5mr113845ad.29.1779386812608; 
 Thu, 21 May 2026 11:06:52 -0700 (PDT)
X-Received: by 2002:a17:902:ce92:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2beb06924e5mr113295ad.29.1779386812027; 
 Thu, 21 May 2026 11:06:52 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 mkorpershoek@kernel.org, marek.vasut+renesas@mailbox.org,
 hs@nabladev.com, clamor95@gmail.com, m.schwan@phytec.de,
 msp@baylibre.com, aswin.murugan@oss.qualcomm.com,
 lucienzx159@gmail.com, sajattack@postmarketos.org,
 luca.weiss@fairphone.com, varadarajan.narayanan@oss.qualcomm.com,
 peng.fan@nxp.com, anshuld@ti.com, ycliang@andestech.com,
 n-francis@ti.com, jamie.gibbons@microchip.com, justin@tidylabs.net,
 quentin.schulz@cherry.de, michael@amarulasolutions.com, ravi@prevas.dk,
 dinesh.maniyam@altera.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 5/7] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
Date: Thu, 21 May 2026 23:35:47 +0530
Message-Id: <20260521180549.282377-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aIXAb79m c=1 sm=1 tr=0 ts=6a0f49bd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=cm27Pg_UAAAA:8 a=WZ0Oi6wz51U_qUjvFLIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ZMK9q7We-Lwh1OCTsdjjxYJVeDxuilLe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfX+z7yHvpxCYvL
 kQEQIGy5SQ3meJ2gheL6VjCojRWBYX5O0x9y/plHAdkLfQ6UZbXzwfF3TkCabLAAnSvIkuwpeFc
 Bpe5uXLCxwNPaR1/G5wXJakXcLSXLHWgIy4oIo9rN0pILBhhS6qcJek3q8KfSY+lseQ2EBM/QAv
 71S19A5J2dNmhBufYVAfJwlsg0D/VrxGgtzdCsF6YLOFNdVo15Nhns01Vseb/7tbYD2rnhfBacj
 AyYusrq4QJtQL0EihJO0A9TyiuX8JbSjdfEJgR3LvBSZIKkEzCXm/Mf54Xf8FPJoOCr/B4nV7z2
 kxReWmyayDCO1YGfZ2uNT3jmpZsr3SKJSvkOQB44k/VQ/NRJw5Uh0guOh6FKJzTySRdDVGVcYsl
 8iIMjCJ4kMUePw+ykznR6bxEiB9jLVu4aYCuyQFHwmvG9L7V94F3H2+D/vpqSfOoldvQ6UxOI2d
 5VDbIiWZOjzFxU/fDfw==
X-Proofpoint-ORIG-GUID: ZMK9q7We-Lwh1OCTsdjjxYJVeDxuilLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210182
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
  CONFIG_REBOOT_MODE_ENV_UPDATE=y - Auto-update reboot-mode env

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v5:
1. Enabled CONFIG_REBOOT_MODE_ENV_UPDATE

Changes in v4:
1. No change in v4

Changes in v3:
1. No change in v3
---
 configs/qcom_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70..f26da9ee525 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -119,6 +119,7 @@ CONFIG_PINCTRL_QCOM_GENERIC=y
 CONFIG_QCOM_RPMH_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_REBOOT_MODE=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_QCOM_RPMH=y
@@ -130,6 +131,9 @@ CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_SPMI_SDAM=y
+CONFIG_REBOOT_MODE_ENV_UPDATE=y
+CONFIG_REBOOT_MODE_NVMEM=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
-- 
2.34.1

