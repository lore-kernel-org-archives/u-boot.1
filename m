Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12799CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 08:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F8B284987;
	Mon, 15 Jun 2026 10:35:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tj0U0t3K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JR1KyDio";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BED84704; Mon, 15 Jun 2026 09:04:26 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5539C83FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65F6J3wf3327636
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7bL9ftZazzAjpxej0qwTUaR6uZNhy38YHD4Ku9c+ems=; b=Tj0U0t3Kh95FpJ0b
 Nivx2jtOdqyvKFlCFjLYJScC++OxHUwphmeMyeNW2U5mr/f6k4pu7LZQ3RTdcbXf
 J0q8YPSz+56D0KUWkEYlYNMQ+S0cUWCzWLrveMyxXdsjbI6YcyvSPEAIJ1HLUEjy
 RpSq0ALFxgJ4TULwvxwQBdphgFl8UQd5icfqlCXFKq3IdAQPySVZeJN1AaQmkGsw
 nP8lWvVY8X39Fi0smMHasUAabzRb8YFRp54rPekw5nPDQi5vxLEsK6da0rg/+iqk
 n07mlHPIh6GQ8ForTVfILFM0h78Y8zGg/+Lma91OQBCy4myB9bakvqmhfwEafG1o
 s9QcYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgny79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 07:04:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-842278a630dso4042931b3a.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781507062; x=1782111862; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7bL9ftZazzAjpxej0qwTUaR6uZNhy38YHD4Ku9c+ems=;
 b=JR1KyDio55jF4lHKFe0eUDsk7Yw1BpJRPsWWEf+npWDHgV6wjrhFGE/zqb/918a+e6
 mJ/obkrCJJJDT+N7vJE+xD04eczKdeZKi0sytfYJWS0a8riDQ4+5bU21GpJ0u7i6SQ+5
 1437JtrysU9ZDp6OD6pQP52ocHRA/BIqDG+y3EQjeHl5yAmMpoK78j9WVmzYTuyyqeWQ
 g4srHHViycGDzqj+NF+DTKs6R3kox0M45ILDX1e1Mihq/4pZxG6EZ2pMk0/0ZDIk4m7/
 RuS47JjylFGRs+cEYLapg2jIo2q2ELDmoV6R7iOFIMJtOMG2PgKTtkHXgSqiKaXZ18xE
 0KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781507062; x=1782111862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7bL9ftZazzAjpxej0qwTUaR6uZNhy38YHD4Ku9c+ems=;
 b=ds9VzRelCkahkm22EmJb+l6rfiHbiRpfixVAMkeg8IY6gAlW0NAEq4hziwracxPoji
 1ZUu1Z1ORIspIFzeXVVI2Mkbt93ddUOG6PMEFgZh8w0Oe1MO/Xkx1yl4/OANI6SUQNS4
 csUW/d98ELxklSdp0kUxXE/SYjE27v01Ug0TqbFSQ0dr6y/gGUDzyRxwed3ZyI53M+js
 hLPkmTH69P99eGDAs8t7lOLnZYkx8UF9MQOm8ZVWWZyGiLVKKUvywPhNdrNfhpPTRNT1
 PmG2h5r5L0kMY8937b4mCTgsJRJTq9L1Ne+nU/zByEu2+ZQ8mSVb8cUDYd06anPrDls8
 cBOQ==
X-Gm-Message-State: AOJu0Yxh5VUuWM3fxYl7z6OdLAtEusbIUlPJjrUymaSWh22aq5f/4F7W
 U6uNpyhMs+wKuBODD5QMh8/mSXm+729LtguwvUx2CTyk255N/6FJmXElDVg2R2wdiSKZiOnhcIO
 IDE9rwKwJJt4j2x6rRVtLJkcH6pBYW1pm42x01k4hg6Q9kOG0LswVS/pi
X-Gm-Gg: Acq92OH87fZ8SYF5rtF8K4l7hSg1Aucm+rfNwHxYn3gWHzBjIq18YMH3tkEI46MUPkG
 oisjrZ15hpIQ2wULDLcayfhYIJWXrMvZDW+VsolW230KcuD23il1vLkCdpdKgUul9jy2g1ktcv7
 EV9hL9VDqIvGG6UJ3JQqOuW3aKsICz2J9XIwDnvTh1it4i7lUki53K3xUs6nqQhSGoS85VV82+W
 nnJqoPZzJgIeFLBNnowfbtsKuJfre5AI2QleWxDPc1uebP4xKT7vMlOckCMeL8hLeVqLNQFmokC
 zMH7qhG7W/5f81mvJnoZRyOcVr3FwKoT005aJnRqv3jSg7KgEdUXDS0uMAGODKhTQPDLaENALRb
 MZUZ8gt3Pozj2jkurZtvXtmel+r9Z/uWLvzlNziRZZ1auuMNN3BSFnBVMHwO5SSc1rzYOVUO5kh
 5/P8DOG4eeca/H+8CYUCKdKKpI5A8ptBan22bN34l21ho2bGqN9Q==
X-Received: by 2002:a05:6a00:2c95:b0:842:77ab:35df with SMTP id
 d2e1a72fcca58-844e19677f9mr10152293b3a.11.1781507061690; 
 Mon, 15 Jun 2026 00:04:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:2c95:b0:842:77ab:35df with SMTP id
 d2e1a72fcca58-844e19677f9mr10152227b3a.11.1781507061267; 
 Mon, 15 Jun 2026 00:04:21 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434aca3041sm9226124b3a.5.2026.06.15.00.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 00:04:20 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:30:10 +0530
Subject: [PATCH v3 14/14] power: spmi: use $(PHASE_) macro for Qualcomm
 PMIC and SPMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-spl_ufs-v3-14-360bceb29596@oss.qualcomm.com>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
In-Reply-To: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781506817; l=1442;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=d1v0WyzInYxI4nq83fn+4RSEgZVEvNoN/SZCHR1GO94=;
 b=kUL+H9AUR2mvE+i4VBLNLM5dWfkUcQxDFXQkIRKM4Nfqly0KD+h6E7D8fJmMeQt/IYssksgze
 pE6cgtUaTjzActr69DRw07qrGmr+Nku84EqMX6+xKWvJr9unVHjkhhB
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: TsZ7lO6cWQcWeEcKDlm1cmFvAgMGt0g6
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2fa3f6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=GKIzsqOsdNxB7MIq_SMA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: TsZ7lO6cWQcWeEcKDlm1cmFvAgMGt0g6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfXzyQGmqWjdNno
 GUsqJnmCx/N44UwcymU5NfwS568Mfa0CUCVO99PVNm0p0e/NErHd8kYaw7htIfFJyX9ili4vhzT
 /8ul6P01yc1C23dSM+0Fqx0+w0m90ew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX7o1/IxWwKyk9
 8j1KJN/uLqrr2PKDw9q/LCSp15o5ghIPK0raHHEfUOoIDg9zJ8aqtNI2fCldHjdQIvnvm8YJq6z
 9gX4MD31qKjdMkeMoiwi3koAuV581p4EKu+xyyHrcfx4oWaV4pio8r9PspkDnmovh/Eccpppe7m
 YaIAAgzN7HFS6+CS7QfgI3MhX5+B3e/DpteFkL3k8J93nuQZ5lsVOBrzGm2QU2Z2sZotniSuDC7
 KPVvC5F25JhQ38D558N1eomELeAwK0TJVkrcyBHYLJ91dMc0uTDn45gFa69HXucojn5eFUInEU8
 lD4szn68MzIXSag7gVCkOyGkVX7rAVw52ko4fJZXGzA845PFzVa2HltJTmHLjAXt/m1Tiv+D7+C
 MClSeJ+XDB19MAt22LAqFdZkseXvrebR+Z2g3OgSEqvwr+vQYZDNbgrKDjCdaL5RRCqTjRBhE43
 s0avlGt6mzLR6tlVw3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150072
X-Mailman-Approved-At: Mon, 15 Jun 2026 10:34:58 +0200
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

Update the Makefiles for the Qualcomm PMIC and SPMI drivers to use
the $(PHASE_) macro.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- No changes in v3
---
 drivers/power/pmic/Makefile | 2 +-
 drivers/spmi/Makefile       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 2cda5a892fd..f0dbb99a6ce 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_PMIC_ACT8846) += act8846.o
 obj-$(CONFIG_PMIC_AS3722) += as3722.o as3722_gpio.o
 obj-$(CONFIG_$(PHASE_)PMIC_AXP) += axp.o
 obj-$(CONFIG_PMIC_MAX8997) += max8997.o
-obj-$(CONFIG_PMIC_QCOM) += pmic_qcom.o
+obj-$(CONFIG_$(PHASE_)PMIC_QCOM) += pmic_qcom.o
 obj-$(CONFIG_$(PHASE_)PMIC_RK8XX) += rk8xx.o
 obj-$(CONFIG_$(PHASE_)PMIC_RN5T567) += rn5t567.o
 obj-$(CONFIG_PMIC_TPS65090) += tps65090.o
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 1b3d57f36a9..8cb93c820e0 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -2,6 +2,6 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-$(CONFIG_SPMI)  += spmi-uclass.o
-obj-$(CONFIG_SPMI_MSM) += spmi-msm.o
+obj-$(CONFIG_$(PHASE_)SPMI)  += spmi-uclass.o
+obj-$(CONFIG_$(PHASE_)SPMI_MSM) += spmi-msm.o
 obj-$(CONFIG_SPMI_SANDBOX) += spmi-sandbox.o

-- 
2.34.1

