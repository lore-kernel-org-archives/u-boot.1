Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2F9C77B7C
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 18:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7EAC82A76;
	Wed,  2 Jul 2025 20:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxaqWc6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E86B82ADA; Wed,  2 Jul 2025 20:01:48 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E556781FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 20:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DDANU028430
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 18:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7Becy3zSCB3t/e6QTXFCAmGvkR5OSxiAT+s
 SNySdsPY=; b=hxaqWc6y46UqqzK68XBLun666pG9VYmRfnAL3dwu5GISzW6J0L5
 2fC8BQeAyDnXPQEyMylRw46u4ciQHZAcXQiU4QCO4cVI0i0+u8dT6mq8SrEukpJe
 SR2junWtgp72EIfUdsgnEvZp064jyAj+trWqmGlOJbASuUzSjoQhnKWsZNs95vOn
 GQPI3dQhmMbU+vldKeVhAOx1eCpdJmDU1w3s/d7x7vqc5IjDJHafJDBRR3PvJqEK
 Z34aK87eRNValsPEwlc4bmKYQD3L09yzNBhil0oTYpuPkFIoHwJsrSICA5UbAsBS
 eSe1eu8e/y6SmjNzfs7x6tco27h9YzfWw+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7bvwmd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 18:01:43 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31327b2f8e4so4059495a91.1
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 11:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751479303; x=1752084103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Becy3zSCB3t/e6QTXFCAmGvkR5OSxiAT+sSNySdsPY=;
 b=QMz0cNNNkaLYPiwuvoqdH2wM2wQS1ruYiMAEGgbqGEUVRwGhX1wuHxohJRVEy2cHj5
 QkL8yOtrnXw6bP/YDcKbgsJjEVx/Y5fBaAykO9IePZgP8ydRIINqrG0g+WdGKVAxCa8d
 Up+q1ZVtBbPsxNjoC1vV79D6zlMAMNojOQsFKaEp9H7l6HOcywajqHEDDrJEegwS2l6a
 eTTnTRuGvRpAPR5FW0UmXPxtIR/4dL8+hcYfpOyUwacco7MneHX8TW7xL7fbmiw/JWXs
 El5UxWeapFO/tSKTDtRAUbT4RZrjCIXHIkHFhCaF2mZhbXH34kH4hleCgyZd3izhZwLA
 g/cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUa7/a/df0HnyTBxS8mvM7BUi/88QrNGA+7ssBLHRZ1dDTHcpvr/OFK9sxb3gdJ4NuuirlJwdE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3G5ERSJWV3Ms+WjrY0K6iACheqLpKQU64rcDwkRGOnfQvuwok
 UcTr0L/QowOHZaLi+XVxIU/Qqzbm5k+JD9plZ8fYOS7B2NyvTrlNyiG2BOaaHK5k1T2DiSog6Ce
 SP05/FrV7AADqmXhclbP6gOh4DK+4brywhLXgn22QoH+qQ0XvuDv77dab
X-Gm-Gg: ASbGnctEpENFpXR9aSERiSCcToYg4IlB7lL4sgyoX62fbGLO/DgxQGNjWRUwm4qieY5
 BAwfZefadMMbgdqU6GIMcweDgSlWZR3iD8vrhLQBy9DLbpd9TqCbvNKeq8nnkA60T7WsshNRwoe
 MUypLpI+ucP1UH4SjAJqzhToTDEPV2zGnfqtE7tcPVVmzdbuvJj8jzxPB4OwcJoUyTQbvV93zQk
 9kN8hzHZe0C2zX3iISg5WL4LXS8RvG5oIWNjCtrVYywgQCifii+W7nLDqggYcYVbakiiCS8E9Xy
 HEls5qrA1Q0pZEJH9JhC/UjgboPX2OKrXRKtMkkOMIw7KLd9wuuilKIo1RrCy7CQsRHOGhedSfd
 XcNxznXAKruqNlgXRWEi/w2/Xsb60lKWj4N0GGorA7A==
X-Received: by 2002:a17:90a:c2ce:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-31a9d52be03mr351742a91.5.1751479302744; 
 Wed, 02 Jul 2025 11:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw2u/RUEaQ17nqY9cVKVa3SEghX0sotXffR9jII4153Wy+Ya+h/1IaFsItSyA6dd84fiZfsw==
X-Received: by 2002:a17:90a:c2ce:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-31a9d52be03mr351689a91.5.1751479302285; 
 Wed, 02 Jul 2025 11:01:42 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e39besm143315345ad.13.2025.07.02.11.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 11:01:41 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v3 0/4] Added QCOM RPMH Power Domain Driver
Date: Wed,  2 Jul 2025 23:31:29 +0530
Message-Id: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dWegESHqV_obE1oLS6M9Rh5FtlqLJioI
X-Authority-Analysis: v=2.4 cv=RJCzH5i+ c=1 sm=1 tr=0 ts=68657407 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GXGHb5lZ-4y_vtRE1oYA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: dWegESHqV_obE1oLS6M9Rh5FtlqLJioI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0OSBTYWx0ZWRfX/O4FJ9HtsdK1
 uhE+NVew6n4Eg9zWA/+A7Cb3JAzY9KrWEpg7NCF3gBawIbjY4JIUHtTHHlvVPGcGdyczA/LdnHa
 240FwpYX5IcXncS3meDuQXr2pYlnLyVcE8Y85mMi7H9akJPxsQiTc6yO8F+ABf3dwc3gwcFSRhF
 bKGE92jxueg3mYdEV3iwjhAEbmOvzZ3vZDFAfjamjgJyVaU54lrA46QOlvSAe4/KYcM/ceISDpH
 jCIJdTvmUJrf57UyjtG/UJ0Atw26f09atnSwuquJaJH3raBkaHm33BmtcSaAvirtujqC31V4p89
 k+De9NI/0PaYEzxYHeWyRhPoi4fnCOeh1NR/JxU9+6c/+xPfojEiXszkGaboAz6znW0V8IWWgo8
 EQxvJyZAjJTkPHJ9bSE+7ZEyBNhxIBoMLAKUC/NuSmHSNdaIhtFDkZVg+TaqXgvmD3ctiGq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=477 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020149
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

This patch series adds support for the Qualcomm RPMH power domain
driver, responsible for managing power domains on Qualcomm SoCs.
The driver is ported from the Linux kernel and adapted for
U-Boot to enable proper power domain control on SA8775P platform.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
- Removed OF_LIVE_SA8775P config in arch/arm/mach-snapdragon/Kconfig & configs/qcs9100_defconfig,
  since there is no SA8775p specific fixups are done
- Link to v2: https://lore.kernel.org/u-boot/20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN in drivers/power/domain/Kconfig
- In drivers/power/domain/qcom-rpmhpd.c, the un-supported power domains are handled with warning
- Power domain fixups have been removed since they are now managed by drivers/power/domain/qcom-rpmhpd.c
- Link to v1: https://lore.kernel.org/u-boot/20250626112441.143064-1-aswin.murugan@oss.qualcomm.com/
---


Aswin Murugan (4):
  power-domain: Add QCOM RPMH Power Domain Driver Support
  soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
    functions
  mach-snapdragon: fixup power-domains
  configs: qcom: Add OF_LIVE_SA8775P & QCOM_POWER_DOMAIN config

 arch/arm/mach-snapdragon/of_fixup.c |  32 +---
 configs/qcom_defconfig              |   1 +
 drivers/power/domain/Kconfig        |   8 +
 drivers/power/domain/Makefile       |   1 +
 drivers/power/domain/qcom-rpmhpd.c  | 285 ++++++++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c           |  45 +++++
 include/soc/qcom/cmd-db.h           |   2 +
 7 files changed, 343 insertions(+), 31 deletions(-)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

