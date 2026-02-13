Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070E7EDF148
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:28:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EBEB83E48;
	Fri, 13 Feb 2026 12:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0W/wUJj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HU3Lm7Cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5289083E21; Fri, 13 Feb 2026 12:28:18 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1ADD83D71
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7CWnt1642023
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vGdPu/zy0u6
 DQ9sPsntRpsvY9yEJOqj2kittSSm5ZVM=; b=d0W/wUJjUQ5AYec4BKdF3iHFsJy
 7vpP6uETv2yKWf2h3l/aP/sBXfFFxp4pGlQ0U+I2DbGJrC8/g6DN6VEU0t0Dsww5
 lEPp0B971VI+TZdUE2WnvC8dCFBSg7Ii6mz9tEygll7Esa4ew7/KdKW3U0zUXBtc
 Dc8Lc4vqS+MSkqT8d/HMMYGD/cFe5DALV12Ux9FobCtshP7xnUk8Passu4PGE8NB
 7K/4VfAQlO0frO1M6YiVcg61h8COT2EDLEVSW5Ir5GttsKjeTe0UdPyA8ilRYuZB
 ZMigmT9v/KDAbEVbpWm3E2xja+z3ZLyP244KWRTNbHjqIMyrkpD+e5hVTXg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv2k4d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:28:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3568090851aso3322222a91.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770982093; x=1771586893; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGdPu/zy0u6DQ9sPsntRpsvY9yEJOqj2kittSSm5ZVM=;
 b=HU3Lm7CdTOHhbak3XpIdX6PnWifBPxwD1d+AsS8UK6aVfg2UWw4lzmXl8PuWzaluPA
 N1Tn6dGogu57uyIV5WB2VzPFQs5XmfAKpy8wrXDp33pI5nG2qq3MmHSYu5CIS7yTgvke
 BgGY7durF4KjZ9rihAFY7TsQVN57O9IHaox7kQroXCqkPTYNIJWixowtmglp2NjypWjG
 s7Js3UU3Cov9sK7wh6TNhTP/QRxzUrd3sUtRmwJzM8p1QxHP9WghOumJEg2Vj8sfzpmd
 AfhiOl0BQkQXtFISVZBUn2II+U/WAyQWInbHtnM0LZFJFwkpO4vp1q4bUaOskB/YbM1W
 A3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770982093; x=1771586893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vGdPu/zy0u6DQ9sPsntRpsvY9yEJOqj2kittSSm5ZVM=;
 b=ok+R0Avymxq5rLQLgrFHT4j2k0mZd6yq8HD/Ulx5wxeMC9/cY3Aa4GGa1EUnmq7HlF
 HqJ330+MMba5BXe/qcneH/p31qsRCCOMby4Pm0iyKGOR9MK2+1PzO+e0A+17b1FRWGEx
 Rscu5soFmvKvA/l6jn2z46JMIPBlV32PsaZ5lT30Cs/pSla83m/tKDUPtPKsGNTEQbsm
 ti06XJxBnIEFv/hdT2HI2vhf5WRpb4XmaXIyHq7NtTYtBdlSy2yuG7Q6M87vcgIX3ugM
 2qC/SKa2/SvJUhUIy9Sws1tDqsEcNLqDY51CskbGMX47sO352mn30dNUA2q1cUdpRXvk
 aSyw==
X-Gm-Message-State: AOJu0Yzzm8j9bF3eAS8LpQFOQg33G5alBtJvDx6Ic/F4pUmT5hC5g6Sl
 bg0CTEh5lfk1i9Zk9QyodbmDmMIXETzmIE0UL3q/C7HDPPgmFBceFopCJ8VYlAjQfCGvtmir8Mh
 zWOhgd2zRKNCBptthW5oHkWiwQwdrk71wPx6gV4QXYvcVECfVSgYAz4IbZxM6G7lD
X-Gm-Gg: AZuq6aKtvFAkqKR80HKZqXS+p2r1w1WMiqn1faAypDbMFHnxDHiFaDHa+IYwugKydNp
 d5o+ArDg+aXLlcVLraa46ChJfgtFSgoig+UFmDFOFZtF5dPQyBq8hR89d6TVnpUdgi3RZNDYJmo
 FxRjzihQkUQk7LQb4fGzGuFQFdJe4txi+7xLRS7dxlj7pkp+m7cihGKZBaYc46zxcDaya+uByNN
 s5xv1a4xXGbotXHURW1yQUt9D63CgtOLQ3PT9GdMXkkPWKx9IixczgG53yzpHLnxFBzp0J2rWhT
 FyAnnPMEFl3X2DYtUhlKRJ0umkw+a/frWRKe8JG2qHrxMO63/FLpY/VFwBRcm/eryxwbYLk9O5z
 EKxTIhWcNDI0/sgwC+74EFKGfMKauN5gVnyBI9PbJvGXkOQjKyNbKSIMAmLYvGfVbAUE1gS9etL
 mlEcDzXFCvYPimzH44vEizXDdjYbBSGX9km1qREIKb
X-Received: by 2002:a17:90b:5104:b0:356:2fc5:30da with SMTP id
 98e67ed59e1d1-356aabec1f0mr1609829a91.14.1770982092978; 
 Fri, 13 Feb 2026 03:28:12 -0800 (PST)
X-Received: by 2002:a17:90b:5104:b0:356:2fc5:30da with SMTP id
 98e67ed59e1d1-356aabec1f0mr1609808a91.14.1770982092553; 
 Fri, 13 Feb 2026 03:28:12 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e1969f314sm7996939a12.8.2026.02.13.03.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:28:12 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: seanga2@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v2 6/6] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
Date: Fri, 13 Feb 2026 16:57:17 +0530
Message-Id: <20260213112717.1256823-7-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FroCG7L3K5wBK2DJkVKmT-YYB3Z0uR6C
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698f0acd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=WZ0Oi6wz51U_qUjvFLIA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NyBTYWx0ZWRfXydQLtNHAFKZB
 Jg/z6NsUEIwH9yesbov49ou/+vU9CHmrGygc5/IVZeKyt82uMSjvgyO1T5aHHQP+lXQo6kTvPBh
 STTbqTscRJ8EBiOr9PBWBy5kUfg1AuuirDjcam4oVy3daT2JFrZM0BCeR9/AMPzQcUqJi7ibH7G
 jMHZ1Kq/ann4P2SvZ4SRruDYVlrEDeH9fmVamM/Nkte6ZsK27cgIaJW+cYnMetl4YwbHZFGHeak
 FZvKk3pxEPnEQ/GpNy2plIcOGf2sLhyDYuCu96fckfz6rSroBmN5DWvlz6utg9P4zVsmQjCulS6
 NP5rY1Kioj3VGNi2exh2WS2D4sjHsESRKQmT1liPlHIliSyIux7ZleET/jrxgZTGQGK1VGk1vxx
 lfRYjLOWVO9LM1H8AktyWdi+mjc7DgIuJfdYWk3vjOnd2qh2btF/3GdFFYc/aUIz0/88CWpdYXC
 SAcHYy5tz2Aj9Wx1bWg==
X-Proofpoint-ORIG-GUID: FroCG7L3K5wBK2DJkVKmT-YYB3Z0uR6C
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

Enable reboot-mode functionality for all Qualcomm platforms that define
reboot-mode device tree nodes. The drivers gracefully handle platforms
without reboot-mode configuration, making it safe to enable globally.

Add config options:
  CONFIG_DM_REBOOT_MODE=y       - Core reboot-mode framework
  CONFIG_REBOOT_MODE_NVMEM=y    - NVMEM-based storage backend
  CONFIG_QCOM_SPMI_SDAM=y       - Qualcomm PMIC SDAM/PON access

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
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

