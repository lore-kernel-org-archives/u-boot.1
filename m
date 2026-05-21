Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58218CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 18:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ACEF8482E;
	Thu, 21 May 2026 20:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhwsiRtr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pw2ireu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAAA8482E; Thu, 21 May 2026 20:06:48 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33A484852
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGkDul4155588
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b7PCQ0LgHOV
 +RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=; b=XhwsiRtrykpNQZ4yB0NBCi+wt9G
 6xdhRwjqB2dn4Q+d92laX7xpW+BW9OhW8x46wcztJCiqzjpIRwQfbVVWwbPKT1pk
 8mejJxYFkOcjb/5kT19sc6akF4Mi68p623vrKyqcYIK32I9/ZKo8sSOg7zaA+TuN
 uwvkQtqCwO3ZY23t6iKUicPUtiOG9bX+fyBEAOfEFNSqvewOB9q6YlDAevk6MnGD
 cKjPv4VvUFpHCIjQ2vVO6p6distlLOqT0qh/TkwX28nM3K40SJhJraIK9bOkBwu6
 WVgZMEbrIGIOZHWFpqK1z8FLjCbOoJkRka9Q/3Th5KEsUbRG9kIxQ8Fbydg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9r963vqr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:06:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bc6899bfb1so64542415ad.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779386804; x=1779991604; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
 b=Pw2ireu8wKiR5Qajf+7VWMnZkOYsLnkxNYD4B0TUQ8/qR3ExDiaZ7VfzswDSgvL07U
 KaG00bmp0A6sTaQM1wfdi2ke8nsJlCOA6DRovI91hYT+Fqv+02ktMnVwqbBliFPVR8eh
 k3LayDfyWVDykH7S4yEojaRfrkFUNgEAiLvVUyhSI0DwrXYsAIDpJSIgMp+hhdAOher7
 g5C7BuHG89K/NM8YCNBDMq7LiQocDtjQK/7UqIy7qU4F/iGI4vFBXAddKlqvQ7Hm9Pyf
 82eIo5PCdoE64l1cElAFRijmObIGErBTOOvfYQu3He1TgjYWZ31hPwnY11BeLIyM2fqg
 iLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386804; x=1779991604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b7PCQ0LgHOV+RRmKKXVixRZPTdtBXQEKQ2i4T1BqNCk=;
 b=niUePJ6U5HS9LUdAfdO02qXbbjzxWkNY3OkxcbJRs2GZFFTHnzNT2BBqUbmudAFp3r
 HLPBDH9hpABC93xGZSYPMlTS2cU5yqtUEWuK92CYjuiqEjnr5H31tSHKDFvS/+i/XWoP
 rXADjcwQ+PPOzuy0a+CU7JUzM5fCHYT27avJAaWnzeQMTCL6A5onGTtECLuKcRTs9SkT
 RNE1nAvx0/WiZAzRXxcYyS3vK9gHQJ41sZyEphD05Bxd7QUmLW00YLyBR+mD+Lmq1UGL
 vmYZukOY1HDgWXmp20BuAwKkGmSKSWgAk6oH1PVVcVjjoTViJdg7zmR6EOsWHx/NcP3b
 YZ3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OltdBUUfcOr8FMJUOF0iKqr1iK3L1EMpfkwJwefeyMBf7tvoer0qyWkH5j+CwMlBQEEcYU5k=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ4urVrs2G+HLHtIevOmBXbIBE5exa67XYkYtkz3cKz/VHzMYU
 nFmXt0jroJG3bk3RyZZufxdIiYGyTjqoKCDPUF/ZL3L1wO9JRgmwzTtm2q3W2S8RPxyHtoH0PhJ
 K0YguUdA0/ACcriunikmtXwzD2jjMCdl6S1cSJjWwS4ERTefLKqTbqJ4k
X-Gm-Gg: Acq92OH5F/t4KdxocfLKPWg/ymCnmc1W+q/CdKnHjeuEQF7wopJZXoo068fcga9EwgN
 fGB6WAm44Mj6FEmmmVI+E3QGPMsKGgoR4ixY2bsTBFpUzWvoONa+PLA+5rBi0ZWygGlOoLTw2MG
 NzWCA2SqZmDdTbaFGkoY570Cln1oinpSvhWsyPNHOdxbXJr1UC3tIsAQ+radtLjM2pUQWSLrO/f
 xCHleYc8d68OLkKpsQc3vpgHSyKXXgLp5h0mTNglNHB3HqgZsb69D1RClS0s27ZWsR0pusbWWqt
 n4N1108u/+K+1ZzTwhh5hirTRbzQCtmlpGYpUzq1sUTSS2o5czCOVsNeWwnzGIkYnDLEvpFoahl
 1hX8dL2V2CnvHCJdNQ9vs6Q5m9CqY+vxTNYH4AgPsgUTVMZlL0QUw1V3X2pq+h9E1amLweKsVjo
 72wBb8m6DQSyXR5RPHmCU82HC3JnB5IkOfPo7+VP0/
X-Received: by 2002:a17:903:2350:b0:2bd:eeb6:ff29 with SMTP id
 d9443c01a7336-2beb0356a13mr659635ad.12.1779386804165; 
 Thu, 21 May 2026 11:06:44 -0700 (PDT)
X-Received: by 2002:a17:903:2350:b0:2bd:eeb6:ff29 with SMTP id
 d9443c01a7336-2beb0356a13mr659185ad.12.1779386803630; 
 Thu, 21 May 2026 11:06:43 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea9902828sm22638805ad.60.2026.05.21.11.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:43 -0700 (PDT)
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
Subject: [PATCH v5 4/7] mach-snapdragon: enter fastboot on bootloader reboot
 reason
Date: Thu, 21 May 2026 23:35:46 +0530
Message-Id: <20260521180549.282377-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
References: <20260521180549.282377-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n_y7QIM0aBJaKVOA3D-hK76y0CUkcqBW
X-Proofpoint-GUID: n_y7QIM0aBJaKVOA3D-hK76y0CUkcqBW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE4MiBTYWx0ZWRfX8maF1B4rYX0h
 oMIJowAFYmjm3vRxKi6ySrqKzA6tBXON0WkjGaNapAgLE6+3BOLQmJCZdeNi/NMi8xBO0U0ZaSv
 COlkURG0yAS5JfiOC+QDkaNTkGiVEqrIQ0Y2sh2GFQi3l/tuQIFY+d6aJu2i+AQuX1mO08TjWa5
 APQaFlRnW5sOvLc8vrVVmks2c3IOjh2AiLlE0H9aAyWJdBKzYZzxLTuC4kMqltOmx/hleXXMo/a
 20gEDhmYKBRoop+0ryMoOvasTapPFIzDh03KwM67Gxwht0aKLlUxYSu8FaKfAMR+oy/l8s3yIo3
 DFBFdNu83CJna69NriODer631pQycOfYQBry1VhyeyBPHP+o7GM8xz8VUIyQxZD1m2E0znP4dzh
 0q55fUxSo5wSsdHD3GWbirjNrMlkT8aCLlRgYoQdfb750EC8seBZ9hdtWxQHu1AXFgHy+OBNnEP
 ZzIkMZoc/e3gqYdHbgQ==
X-Authority-Analysis: v=2.4 cv=GqFyPE1C c=1 sm=1 tr=0 ts=6a0f49b5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=CUHhPrH4PvmLcno32LIA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
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

Update preboot to check the reboot-mode environment variable
and automatically enter fastboot mode when the reboot reason
is "bootloader". This enables 'adb reboot bootloader'
functionality on Qualcomm platforms.

The reboot-mode variable is set by the reboot-mode uclass
via EVT_LAST_STAGE_INIT before preboot runs.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 board/qualcomm/default.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
index dbf6f4e7260..429d71d57f3 100644
--- a/board/qualcomm/default.env
+++ b/board/qualcomm/default.env
@@ -1,7 +1,7 @@
 stdin=serial,button-kbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
-preboot=scsi scan; usb start
+preboot=scsi scan; usb start; if test "${reboot-mode}" = "bootloader"; then run fastboot; fi
 fastboot=fastboot -l $fastboot_addr_r usb 0
 do_boot=bootefi bootmgr
 bootmenu_0=Boot first available device=run do_boot
-- 
2.34.1

