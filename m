Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D31C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 17:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D684482CFA;
	Wed,  2 Jul 2025 19:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GvKPIz9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB5F82A76; Wed,  2 Jul 2025 19:13:50 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD48A82ADA
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 19:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DKJd8007049
 for <u-boot@lists.denx.de>; Wed, 2 Jul 2025 17:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=sPfj4te1+8XfIhjsnJNTIUz+PxaNR8CnlbC
 eWEPPEQA=; b=GvKPIz9QkvwUOvsSe/qqH/uVwjGOdpLgFnJWCC3+6ftQwYPTYAf
 5UFR8LMLdWyXOPWkIrmy0aIDknqBiCR1rIfREmvVXs4QC+DrqihnJACTfVLnzLiX
 2Eem+g+hQcxXFH+utWv3AwNV4IXvhlZI66LmOOv78gA/zkGotBy9O3D8yE5Aj3pp
 k/mpJibzkBwBatG6V2Dm+cSfwqaiZdAkRCoKhtfOkHHmE3HlXgLflnfHZnN51HLt
 Ff4azp9ccWDuVBkw1/Hf2rDgB+/ahGhtoPCLXleIPu1wuii6Fx+bdS1N9YDPZkGQ
 0b4Kgs5v9e/6GN68RuAW2Y1wWlvxzfcDbIA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5jhuqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 17:13:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-748f30d56d1so3633987b3a.3
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 10:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751476425; x=1752081225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sPfj4te1+8XfIhjsnJNTIUz+PxaNR8CnlbCeWEPPEQA=;
 b=MFui+xs+GzGtgBBktVgcdnyzpprWyMpUS+n1clE2ynYGWe9iKkCFMmdUUGnXcGu5oN
 ohsPqbpu/x+CPpozkcY2tajxQH7fMueEcsfiBg8CJI9q0MyWgy67ifZ3ylh339vF4vvx
 V4rjk1gkaVCR5wgPoPjWNGIIyDi0wpX+n0VDMKO7mYYz1wrOYnP3WbeO15utnMl7maCW
 Twq2CvRgTkMXmzN0Lvm4dr2p1FuyGRLcMKF7C90aqtI4NijPTzcRSn65n4Yx9E0Whs1l
 ixxoDztiLHEDceuGZ4T2AoxkdVbedzLiyk6R3cdS+CS9zvuBI4AWr+vKgYHYLsx7Zn7W
 ym4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DVRcyjNb4dWHw56KAzMkiVjLlsV/7ryrGnXCmt0PStB1IQ7uKGFHOlQUDu3VHAklM4phslU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqtwm3oEoi6cHFgPEDjyEWaVVkGZLaTKXdXKSh2hXKKNQT21hy
 omhaYelNsTd79NE0838+DDYQmSsHrXeRlWXlZxg/I8bPAz5LpxmkTIMSDf4Ul8tTPxDTS5lKSMh
 JGO5PMuDxef/YE0Kzsid6spQOFyySIbkRqt/DJYpbEyC03wO9JSweWohe
X-Gm-Gg: ASbGncuuF/w2FZwapwV6YWuSReKDVW6L6d2+ZpB3ozzY9YfV1sshduIz2syd1FQdpqM
 WWBDxRxsAbbUqkpSEifUIGnEAKcoLcAO3QN9L6x3pSq2rPlSvmWuxwzgf1J4VSHW/FNx1+REAUy
 bgaYjy3ThaOAGL+0N1yhYyN0mx8qd+vNsj8xAZ3NaorcT6yCcKTPWt57iX2R5k0UX3szm0Tk9xP
 S5M4gsqU2cjnt6Fx8NkwtAXPAPo9STTqMdP44ixfzmeSkvxdk/qy9jmXXxT+NGAnqsbG9K0THre
 8Kckiy0lEgWqx8/L5B7Y6jiz+XQ8ZkIgtrepGQr3VnhaEy9QKzBAJ5jXZgjGA6YQk5dMYQug5fx
 +oMyviGAaXoMecxvzylq3tV/4zNskvU2nv1bjI9Q+Lg==
X-Received: by 2002:a05:6a20:3ca1:b0:21f:51ea:5c57 with SMTP id
 adf61e73a8af0-222d7de5e39mr5493522637.16.1751476425181; 
 Wed, 02 Jul 2025 10:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXj9X/4RESItFHV40ERVVuio96+DK0xEwgil0zJ2hAcX7gyxH5X8EJDjv3KryBhhD3m9EEIg==
X-Received: by 2002:a05:6a20:3ca1:b0:21f:51ea:5c57 with SMTP id
 adf61e73a8af0-222d7de5e39mr5493489637.16.1751476424781; 
 Wed, 02 Jul 2025 10:13:44 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c5837sm15144873b3a.116.2025.07.02.10.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 10:13:44 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 rui.silva@linaro.org, me@samcday.com, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v2 0/4] Added QCOM RPMH Power Domain Driver
Date: Wed,  2 Jul 2025 22:43:31 +0530
Message-Id: <20250702171335.1811080-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=686568ca cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=GXGHb5lZ-4y_vtRE1oYA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: UemQTYVb4BV5L1eJ3E9Lf_5MchAuECD8
X-Proofpoint-GUID: UemQTYVb4BV5L1eJ3E9Lf_5MchAuECD8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE0MSBTYWx0ZWRfXx/Q9Z8GGolh7
 sBF1X/jbPHk5FB6CnjeHNJQVVh5YnIXhVB1w0JfhGUsRB7GLl+d3aQ3EhbznOfxgRkthskhBGRT
 iygRNYWypRPJnyIFjmPmk0jD71Io6LVFLmKCArEnzFrhIKyw2hkWzOIi4vaXVk2qTN21KMlGE/X
 Ka+zkQMWk8ny/GemlxkmfeTv/hapmAvJ4Jadx4JWiaKKywztrxL6QhQp3BuRPREhB/+rQzLN8+0
 m5XZKLni5/X6MPzpLRKep3v86lIx8GZJ+kR40WOtsyC0y9qUUL3Xfa6yHvzTBVq4JUXJKoefe9J
 2m7tQQ3wOycIeyp62go3a5lKKtTxT+qnCoSmdlPz47lHopWGriYLN8fu57snSbs8i5IowVQZRL5
 3cou3ipox12oqkW3zHPyqa0tbPxKcAvlbU9ybpIk6F0wfHxEos1ZByN3UvX4DG0JoC4FNwJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=463 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507020141
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

 arch/arm/mach-snapdragon/Kconfig    |   7 +
 arch/arm/mach-snapdragon/of_fixup.c |  32 +---
 configs/qcom_defconfig              |   1 +
 configs/qcs9100_defconfig           |   2 +
 drivers/power/domain/Kconfig        |   8 +
 drivers/power/domain/Makefile       |   1 +
 drivers/power/domain/qcom-rpmhpd.c  | 285 ++++++++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c           |  45 +++++
 include/soc/qcom/cmd-db.h           |   2 +
 9 files changed, 352 insertions(+), 31 deletions(-)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

