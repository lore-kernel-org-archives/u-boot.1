Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A2ECD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD7184A1C;
	Wed, 17 Jun 2026 14:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="npNgdBu/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MgRTWGXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE768841F2; Wed, 17 Jun 2026 12:20:05 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEA3838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UZPB240483
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OjhIRHuAt/V
 w0p3ARphWJGQu0zd40pT4zrHoK8huZxY=; b=npNgdBu/u+Zf7dxm6RMsg4Hoa4v
 BRIhS5h1xZHEpdrv++jg/6U8T4v74FNlZfeGGO4yV3PRS0x7T3twhboG5Rs56Rnw
 xwby6M+AmFOI1k1NAz+D5W/LJ2j6EEfMGB5EPyBL7Q3A4QoH7UsDBzS5zyRpVMHD
 +utGMh/8x54vSGqSpG8kv3GMkYhm3DZrKJ6UUq5Ujbf8LmlnuYDG0C/KLkqlhJxG
 XBTCgMVHcwvz7Z/6IPIzHMT3JZPBZj0O4U9Ukwvb9QdOqTSlzDAfHmnKG/SNRn70
 DwHJwmGbdKsSUTiiKiOclwZElcdR7+8lNaxX551oGBJwTmrjJdfPAYB527g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueepjj03-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:20:01 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-845338eb797so55742b3a.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691601; x=1782296401; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OjhIRHuAt/Vw0p3ARphWJGQu0zd40pT4zrHoK8huZxY=;
 b=MgRTWGXLgcfXeI3peypa4luHnjEFbcM1/nEzDgrU05Nv1ibXXoM+R1GhBXW1wK5U2h
 Pwk1NzGQt+ffi5VMcMOm2Etl1PAmlRltdgMNe4o2El/86BcnR1LFJGyTHEvHrC4+qxRC
 Q7Hu7u6kWvLckmjQRvpf/Dq9J7aqlhCZ68exycNvkAHzyt+8wFDuWhSc/gTRdZguxYfU
 Gk8aubzPKFRlRo2oTGVptjDubXRgRaPq6yOwYOKde+560cuWkrGvPCXFJGunogzHw5MN
 +OGj/o+jkJO+Saf3YBYTHfCVs/f5T4qyAa333BMMu9AlCrlLi9YSdoTH7i02SDYWBYVS
 npnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691601; x=1782296401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OjhIRHuAt/Vw0p3ARphWJGQu0zd40pT4zrHoK8huZxY=;
 b=NgzjdW1Oo0ZcQj8KBO830Vp4dohiQKapsWmLNs54PKfesUux9XAsVsxkFNepSNWYIB
 tgLjNo1TJ9IMjgP3d0PqngxQwCAyv3V3Bi3sfhKKZhTyE+x4IcfuGFl0zjOHQDCkbEmZ
 AeSXYmszru28eX78Bmfp2x8Vjv/TEoEokPI8ITAuEYNftC5pL87vZUzO1AjF9BjKPJKf
 AiTJ56JWAP+uv0SiURXHlKX+L7kra/V0U5PNItKFjzuV40LJB7nQCWpRQugQsz8zMg8j
 Oi+9dc2yhRqy/LTvyoBWPGU/lIYxmRIAhSVD+AWsNHZrSTRY83Vrj2LmF3YwWXDSiO+H
 gidQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sOGuxfBfgHeVu3hEfh8g/o50rSAOwk8v76Oamz3DznLkw1f2sBowW1mdpL7pKE4GuLONa7Q8=@lists.denx.de
X-Gm-Message-State: AOJu0YwQvzlL15HDXw76ZB+KsbdYCdGGCdk/e4r7njSHMTmtJHyq0zJE
 3jIIx90BE0srTlpgPQ4K9tPNN6XmSXETA7j7LNEFnE+GVPbOXxk4ZyvyRZLbhdfnCtpse2dRZVK
 iKLLDexJTdfqaVIfq0CUN0QNb/eXSZQV1awHncy1PamwTK5cRiUBL2fPA
X-Gm-Gg: Acq92OFrTFHmsA+DuIR8upweoIYMjuCuNI8luQATCY6yrYkcZrQAv60AjJISGAQalPX
 ppd+gD/PLHmbbx/8gmQcgbU0GKvFsT8usGnd7Mta4o6083Dv2si4XXJIuRGN3OGHQDhF9sdx7b7
 MNAlPbBPmvIPjJ0Q78ZcuhCHa22kOLTkrN2wLryjerY/J4ufUq2+xrOw2Al/87IOzYPPPE0Bbah
 Rdg188rtTWmkyq6auKF5GNpLJ0aRJMbuYW/0klnKqfBIEm6QhxHMrp04YaBttLF190xB5h2dnYy
 CPTJnMpSIZpl/2s3Tg6U8lIGFQYWLOjcSwEaTE7SIGZf3BL2VMnSp1pX02m6/AnQ2nJBuRqbANH
 b6xrUMlSqJ2YhXTFn2Jn5+7+AGBHL4RJEq7tJO8SmUQJLK9p9sgHt7OO82Y/TCHWuWD3C6WO5UV
 mg9UrmnN7rxa4bl6bzrqCsQFad8mMgC5he3K1Ohp8h
X-Received: by 2002:a05:6a00:9087:b0:82f:53f1:1937 with SMTP id
 d2e1a72fcca58-84526b4d39dmr1970687b3a.27.1781691600886; 
 Wed, 17 Jun 2026 03:20:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:9087:b0:82f:53f1:1937 with SMTP id
 d2e1a72fcca58-84526b4d39dmr1970657b3a.27.1781691600408; 
 Wed, 17 Jun 2026 03:20:00 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:20:00 -0700 (PDT)
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
Subject: [PATCH v5 08/13] spl: Include SMEM driver in SPL
Date: Wed, 17 Jun 2026 15:48:07 +0530
Message-Id: <20260617101812.299586-9-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AY+B2XXG c=1 sm=1 tr=0 ts=6a3274d1 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=cm27Pg_UAAAA:8
 a=EUspDBNiAAAA:8 a=urvU1upnej4-CWmsP9sA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: tx67a8xMEe--RZG3NSqQkKScfuRPlGLA
X-Proofpoint-ORIG-GUID: tx67a8xMEe--RZG3NSqQkKScfuRPlGLA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX/pC8hhU1NAtC
 +Zy1ytUZELsuKnAo3mWcOYtY3BwVTjHJNhU+lpDJw3oNHoLhkK2rFGdpQk/KgLRSy7LDd18+Vnu
 mofedYb/qffZ4y5E7jEFNhUSAplNXNvxBR4ljBZhr6KcU/fH7zi+ZUdtdvFJ9fqe9nnuKnNR1hB
 TRP1kyV8cvfbhYYMaTQrE04FXlXo6B64DDoDWrcVJ/T14q+koi2rhU80sJLJ82XA1LMM5Vn0YkC
 4k2/qOFikRHjkMKSY3WkuLalmHE3g3VeuZUZ45Em3hDzkSP9N5bqtdyAzSRp7VUeAQ65ZyeqRNa
 j79biU8xeEYiaYFdPllFTuMR6zMcJM+4+n5vpGADeMxjj2lRbVph6bWgYLNtKYbVAwBzJWzFlU5
 ZhH9hVXCR4xkmY98tYRbL8GPYTAFAM0Ia0DcDEyBUexCJgLMwN/D4Oy1GmoFk6VagnQZybHT3Qu
 ZfCjEDeqgwZfRFV35Cw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX/xuu2AuIzdem
 pYp3kqRznvrt7T9uHlnGDQpEA+QanppqDD7F1nVdgmB1sWKALetvMB/QUplAm3Jj2hMpvVSL+Qw
 ovUIRrij2MygEkUXwsvRF8qCPXfruLc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170097
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

Add SPL_SMEM config to enable/disable SMEM driver in SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v3: Pick R-b Simon
---
 common/spl/Kconfig | 8 ++++++++
 drivers/Makefile   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 5fa94098e49..88db96807b0 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1387,6 +1387,14 @@ config SPL_RAM_DEVICE
 	  be already in memory when SPL takes over, e.g. loaded by the boot
 	  ROM.
 
+config SPL_SMEM
+	bool "Support SMEM (Shared Memory manager)"
+	depends on SMEM
+	help
+	  Enable support for the Shared Memory Manager. The driver provides an
+	  interface to items in a heap shared among all processors. This enables
+	  the drivers in drivers/smem as part of an SPL build.
+
 config SPL_PCI_DFU
 	bool "PCIe boot support"
 	depends on SPL_PCI_ENDPOINT
diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..ead082450ca 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_SPL_SATA) += ata/ scsi/
 obj-$(CONFIG_SPL_LEGACY_BLOCK) += block/
 obj-$(CONFIG_SPL_THERMAL) += thermal/
 obj-$(CONFIG_SPL_UFS_SUPPORT) += scsi/ ufs/
+obj-$(CONFIG_SPL_SMEM) += smem/
 
 endif
 endif
-- 
2.34.1

