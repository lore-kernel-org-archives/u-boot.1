Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E4EF4ECA
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 10:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C4783EC6;
	Mon,  6 Apr 2026 12:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HF2Q3Llq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvlFh9YX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D1A480433; Mon,  6 Apr 2026 12:55:56 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467DD83EC6
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 12:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636Amf5l015917
 for <u-boot@lists.denx.de>; Mon, 6 Apr 2026 10:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 akVF7tVljvP7AoJfMlnpNjloAp6OR/nb76fktSZOYrI=; b=HF2Q3Llq7k2HDNxk
 e25SfnXYoulmbWA2Ajf41xoWV0F5zSky/n+MH9EjP2h1W3brQ6MAgMEtIIxHAWn7
 gALOgK4S2sXWm6tli6g3mYxMI9t8DxnAvfY8nZykFrXraXy1YPIMFOklKG0UU0X0
 aMMNfM5Ex8lJu1U4GkqXMWKC0yzFm6mJr0vkEPtwBSGOIlp5hDtx1zrX2F+9DssS
 r28LaKBO+iWAHyPw4Xw5Ibmk41qP7wJcQIouIWkqcAlX5VDOzruxau+ncUS//z9C
 2pZr5tH/NfIs+L0bqjyJM9mlDX/4eEEn5fDoM46UzwkvROKnVLT4s8dgvPAtqNCm
 GyyhHw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcbd6r0g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:55:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-bce224720d8so1735094a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775472952; x=1776077752; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=akVF7tVljvP7AoJfMlnpNjloAp6OR/nb76fktSZOYrI=;
 b=GvlFh9YXdf0mU3xFLljMcFlq5ODTU8LCrjLyd9OxrxuVzuJGJV/HYXa/FOkqMdFNX1
 oCScmU4c7HUPQqtWygZw04bb12EDVzVnmTapU4+dc9FbGFyF8yufJBuZ7AZ76HlfNEwc
 yHUmsDKDn+ozn2vkeTXJSJnQRksQf0b5X91kRRSVTZeU/cuP9YIxf0t7VV+1UZF3qAmr
 KG7wC7NpMq+InZW7Y82BUXmpA+sFnHoLnv7OMwiydN3hq7C/BY70f+hXk0V9YXkMetUW
 D24lVrnuEOhXeFXsovO1ez/cd9PYTCjlLeaKprLOmy0fO8h8lPZ+q8U/Qa1wbc5sosre
 owFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775472952; x=1776077752;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=akVF7tVljvP7AoJfMlnpNjloAp6OR/nb76fktSZOYrI=;
 b=lJ1+2jpzCA4HSZustFAfH1W7BbnQYUP7tSqLQNRuGSmNeqd50eQWymMVwnODuW9X+Q
 fCEpXZRdbc16nr+z862JQgGzIJ8p4/BVC6CUjmV5+bV+6/+cSjGvUjcE6sI8L4Uc9ViF
 5V0HgI5Zwa8g4joG2R3Fuy+eR8D6jzLKdasPt1vy7Fb0DEQkp3dZ8Zx076FWJb4PuUD1
 QQ7/S32ComaowjO1YEhgMNo3uK36Z9H8FgAO6w8Gw7DKNkrObfR3xspw8cLSfTJgvBqh
 LrGxG9tQNZxExLJD52mGaVrv0cnLKVEhuiXUATa+CwNRl/PrcyKZe3uldGIFp83/Yj7v
 yupQ==
X-Gm-Message-State: AOJu0Yz6hUjhTZxT8orrxXy4lvYf9G+Seg3F5APKcoFs8vkkPpD/ZSz7
 jWpJl18LeuGT/i9fXXO5EMbpPEevrJwgDAJXuhVBefBlp2Xj50QgZAuSpKVit1HRTMw/JRfOQdM
 zRrjBG9GkdC8A25D3RHCfkbcEHjpJF5yjalxC8hb4f5MLzWGd/WOzhF5D
X-Gm-Gg: AeBDieucD0JHKvw98LnEZ6B+NVyuQtPqt2ABERbxeWYJozZHeYSJ4VTTblxmhDoBVb9
 0o6/K+OEJLF6S6JykD79BD+0tlX00uoe6DowXKkcDnrjXj2XPY9vL4uOR0FmkCQ3stBJy5iFG1L
 t05WdDiLob0+JKejyVPXDaC87o+B9KxA96GGyfPSiMwKhwD9kFZU+J3z4Rndc+5b8in1hw80e0Q
 yAWM10K43LfQykfw7sKDSE7IEdNvuGOGGy+soy/pZEnMbafMUPElCnqWgQOExozvg+wS+RQPhqW
 u35Gmgt1QD2AjzvUiA4ZPRhWtf2qh7hG0k3UndEoKGkaaDHwaIV5td0XDv9DDY59D3PhOoZESH4
 /TX0yElv2BuclEfM74N10nMYNv5NmeQbUPZVvqRk6QdW025ObfGD/irI1TKrCQ2cYq6eDLybiAB
 EfCLRqO+6FOb/GFwDsVy6nPsIKU82bSNKCgUbM2PlKfARXMXHgXg==
X-Received: by 2002:a05:6a21:9983:b0:39b:e321:63ef with SMTP id
 adf61e73a8af0-39f2f2b7cb3mr11416418637.57.1775472951372; 
 Mon, 06 Apr 2026 03:55:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:9983:b0:39b:e321:63ef with SMTP id
 adf61e73a8af0-39f2f2b7cb3mr11416390637.57.1775472950866; 
 Mon, 06 Apr 2026 03:55:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3baffsm14128816b3a.14.2026.04.06.03.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 03:55:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 06 Apr 2026 16:25:37 +0530
Subject: [PATCH 2/2] snapdragon: Set timer frequency for
 ARMV8_CNTFRQ_BROKEN platforms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-timer-v1-2-f7c5a290c459@oss.qualcomm.com>
References: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
In-Reply-To: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775472938; l=1313;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=pbJiwnGKzDruhD78eMhwvVIjFTVnKdtuBo2CLyXFsBA=;
 b=I59dm5ENEUi3XJtIFX6Mys/AnjLyuekDVj7MRh1AJtnebNu+cm+SekwhC/htT/vJ4InHjWtQi
 rMEEGhvEowUD3yFUdHcwUoyYWLcOs2pCG9/FpJ/J8FTSkVRkPRihOI6
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=ap2/yCZV c=1 sm=1 tr=0 ts=69d39138 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=k4bPOeCAwD1hSteQDtQA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: UnvwKsxVA99_jlUYk54riWJOlAl3VwWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEwNiBTYWx0ZWRfX8P2ghgNeywjP
 2TIgGp77pQJh944RMRiCJpiOZlnZXRJ/lVr0nhN/M5RlwDh9uDc+c9RuqOq/AqJFI+XoqOu5JvC
 BE9LUnlpteh1IeD9P9WfNkLoRjmhF3dj+cR95CkLY9KutUW5woYJeHT2btYhUkzMYw1Vmz5SqfW
 Og6/DQImgXBHt6W8785JcIBFRMzWdKIiU6jKrCN2MoqXaQmR9beK10ZupucabEcQzlzYUjgwhAf
 v5WLrlxVL/UCmP2IW5B5/Uba0H+0U4QnMv5Ua4kMC+PvFJR+8BJDqiGXnh+gzwFkfR6vAEfdzXL
 HWwxHBY2Y1s0/VgLPWeCP9a62MDICJ/4ywt2K1AwG5m8QcEm1DXPAumgguNDgvivqkD54CDtLYU
 ebGH+ZAMYGld69MT83nSzKS2mjRE19Gd7oet+C+WFIiCKAICfJNoJNqbElW0ekaguyYjivLJF9/
 Fp/BfW3LQO8X/N9b+pg==
X-Proofpoint-ORIG-GUID: UnvwKsxVA99_jlUYk54riWJOlAl3VwWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060106
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

Implement arch_cpu_init() for Snapdragon platforms to initialize the
timer frequency when CONFIG_ARMV8_CNTFRQ_BROKEN is enabled. This is
required for platforms where the firmware does not set CNTFRQ_EL0.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..6cc9270cc5a 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -39,6 +39,23 @@ DECLARE_GLOBAL_DATA_PTR;
 
 enum qcom_boot_source qcom_boot_source __section(".data") = 0;
 
+int arch_cpu_init(void)
+{
+	/* Set timer frequency for CONFIG_ARMV8_CNTFRQ_BROKEN
+	 * Use CONFIG_COUNTER_FREQUENCY if defined, which allows per-platform
+	 * timer frequency configuration via defconfig.
+	 */
+	if (IS_ENABLED(CONFIG_ARMV8_CNTFRQ_BROKEN)) {
+#ifdef CONFIG_COUNTER_FREQUENCY
+		gd->arch.timer_rate_hz = CONFIG_COUNTER_FREQUENCY;
+#else
+		gd->arch.timer_rate_hz = 19200000; /* Default 19.2 MHz for Qualcomm */
+#endif
+	}
+
+	return 0;
+}
+
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;

-- 
2.34.1

