Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2CECD98DA
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 09:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DF85848BF;
	Tue, 16 Jun 2026 11:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nqU2xHBW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gfyyJBVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A592A848BF; Tue, 16 Jun 2026 11:23:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A857848D7
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 11:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G8OU4p006652
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BGmI4MMRisD/YFsCFKDXCqbc5j5w1W90pSoveImhVO0=; b=nqU2xHBWO5rv1Rc3
 ATZQAYZUUTlkeZFavlH5MAfVk8IuKgDUqdTlOYJPaPOj2lcTrtHk3OZ1EZvH51NO
 D6aEYFfFNsFqW5sDpBq/1VfVIq9yyaNEkms1t8vC6oJsQ9tFnW/WBbL5O+vCVgK7
 xk+84aJ0PfK/n0C8dtrh5Y+jtHHgN2b2Vclb/pBdHqJOZzLmV5TPtWL7+tOkR23Z
 6KOAS6Obl38YhP74644p+Vo1Rp6fQ/2f4MPDVAWo/SFd4Dv84qj0Lx8V/CIaSFVn
 NaUI41HNNtB2If+GUH40wmJftmJDZ8+a7nQ7pmBEMmZvDKk46y6rw6438wOjxYxj
 dODsIw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu2xs883t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:23:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d982d932aso5728856a91.0
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781601803; x=1782206603; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BGmI4MMRisD/YFsCFKDXCqbc5j5w1W90pSoveImhVO0=;
 b=gfyyJBVPphwW8iLfx+D02IGULo/Qm0UfWuGWAd3Noo9rKGunrUzRIoP6bX0yF30pa3
 5W2B2346HfTZ5GnFI6dGE1d0UWCTnK7g4Xg9vdMpwbYgBwrvLQyjDBTFkS682aXOfXML
 hPPsB62O//jOFTgePRrX6rXVX8vFYMEvmijgviR/ChQbV5F/0fXM3YhQHG4P4jpuHUCP
 Jk90sJYc8rbVTSjJbN8xkOQ462/6pCj+gZNzqIQan++uzVmcb2RmnohtpY6ZovwdSJPq
 KDd5L0yFwo+KIMpChoUBaSjj+nkE2lxVwDnSiSX5GD21HxLYuy9EomWYeslVRcnlQ6Pc
 08ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601803; x=1782206603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BGmI4MMRisD/YFsCFKDXCqbc5j5w1W90pSoveImhVO0=;
 b=mmHWaZJq2sEXn8sUpmdh3GjBH8aZIQlTWk7GBUFCkjfhlK856DDx1SnTLedgEsuXOu
 91KbaAHewdaF85PyQPbcnCYQFDlczcE5vKYjkxE6QN2OD6KcKmQyX55Uk7R0ymTqyAD5
 sp4DoPdLSg2A6fbD/keCFwckAXLwxTjC8B1+rpF5LjfR+mV6/RMuZi5gRc7ULxAGtat+
 zQpNA/pIZb6DmyYFQALFqKb+YBhCu+LKJhAlDGvOneHNpiSjEfvwATtCtSbHW93f9ZvE
 5JprGMwHXiI0it1WGYGu1diZsMuJ9rd1soSOmgn+6zTO0cAmsYMlPhxxW5kqzxuFIoyh
 YJFw==
X-Gm-Message-State: AOJu0YwyTJRJerQENnLW1ur/yMiydcNwyS+0dmXvEMvMyUbGuQRNIgcn
 gcHKknwh7FwixoBMz3Wqis/uZnpsobZBA5BE8N0tw9txQDFiEak4IQnwqiJF2+ovTBydNisbHMo
 QZdHk88ujMETaJEMBP3hn0neYlxbj+KShcQcG1Ly1L86z4fIbrKnZweBN
X-Gm-Gg: Acq92OEKBOjevipH8QkIKmVvKXEsDVimzzXoXtSYnVu2RkK8GKkBY3jbOjtps1Qq60l
 Qr2kF66P8EIOGeUcAiYRFKs4t9joFhFqANEu/yRdu98kZRRbXdJQI4Re0mRfYH9QYMOG5PF4Wx1
 6eFEXIIVZpZ2b0NExucPaddgqB+3WYQTnvlXVrVqDv66+kVxAva72Z8bzxQ0XXNqWd7t0++Q7wU
 WkEQeG1Fjv0xF4RQkZ99kTWu9mzbHzkpQkuohDyaaAxNUNTSLWIRlcpTq/4hrdOAQpuILpiaKn/
 d2ZA5zkzO1KnqgzejjxGIqvz5cQ19lAC7OMA2i3eVzT5zDlfC2U8/16WdCxsCVOErN4SdWuEfwe
 zMXEnHNZcG+NvENTKFhZVe6KfGhwB7C+64u+j+PX3yfOuyQueHQeN1HWP1NNsBOLVAPZ7QlurFq
 wUMFBQjUMtVsAKmOylm2NDNvF4ICTP4ExDVnKMKMoZpJ8yU3BLmg==
X-Received: by 2002:a17:90b:3912:b0:366:1172:597e with SMTP id
 98e67ed59e1d1-37a01f335d2mr18480814a91.9.1781601803083; 
 Tue, 16 Jun 2026 02:23:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3912:b0:366:1172:597e with SMTP id
 98e67ed59e1d1-37a01f335d2mr18480789a91.9.1781601802671; 
 Tue, 16 Jun 2026 02:23:22 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c522136cesm2360005a91.14.2026.06.16.02.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:23:22 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 14:52:53 +0530
Subject: [PATCH v3 3/6] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_SUPPORT
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-sngboot-v3-3-6fb0dee8125c@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
In-Reply-To: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781601774; l=1473;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Dwp2FEzuftE+BvZuXTa/TdnU9/GsOpCk3UmoYCeYfgc=;
 b=UzvIs71dGkOKFQpOTJQnNaiPu1eRTsgv03oYwjBuzm5UO9nPp3JTUGDPXaWfs3rRka2AjLpaC
 Kmph9c3HKUhAoI/FaL8BODszHqrNvX0mDxFGqe/uLizb5hyhuce+Y/o
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 6U33W9yv_wJwyp9QyFNN_I7HSEcfO7k3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfX10rApdJmodfh
 WP0G8AMooyF5/wKMZrlLpQw+aHaS55lt2XDgL8Cu0aUCoqCt3wF0TDxbReoJ2uDH8xNROg2I4ZS
 J7HOf4VLjCYiSKWWHkid4fUYpuKdqnBcjft2s9kRgrnyq2qTkWKBTWaDWtC792aZqV+D6XDVHbE
 ijHPprlJA9A9h2VeJUHNfMDDJFV3FPKg/52ZOUYw6hkY5n+TJPiJQkxbh2Ot2vxRRLroSzYDeFA
 HE3tl/oiphBXnujWUTUt0d9nJH1jzCs1Tfwrv8evgaPyO/pWyBeFCPkGMC6gEy1PWFZm/R98wxT
 PRLH2q45sbiVpIZ3cAmNlGG6oKaeZ9zBmwjGh1CANp2YVtXGX4EumqbeZ6yIU8s6MImKm/Bf9/4
 fkRzxDbQjTT3pR6NTMigPyfOE6l9aSjks80a2WRg/Zuu7wFlks+36VFUdLt5B+/2AQiQLjlNRT3
 EHRHItZ3FQ9RDm0SC3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA5NCBTYWx0ZWRfXxhA5QNXFZPzj
 GEY77NtTvKEuIxhQcXLsuLlB5PR6yBGBel0rbZ5574kaKij4smca3qa0N3nW5LfeBQUpM8u0Ik0
 hJMPF7nre4ve4/AlAefnGR/RuJvV3J0=
X-Authority-Analysis: v=2.4 cv=MdJcfZ/f c=1 sm=1 tr=0 ts=6a31160b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5EoeRnimQ4dD3BqEGv0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 6U33W9yv_wJwyp9QyFNN_I7HSEcfO7k3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160094
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

Add CONFIG_QCOM_SNAGBOOT_SUPPORT to the boot0.h workaround choice
block to enable snagboot mode support on Qualcomm platforms.

This config option automatically selects the
required dependencies: QCOM_COMMAND_DB_OPTIONAL,
ENABLE_ARM_SOC_BOOT0_HOOK to enable early boot hooks, and SKIP_RELOCATE.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 931d25c1023..e173af1ce45 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -63,6 +63,19 @@ config QCOM_EL2_GUNYAH_EXIT_SUPPORT
 	  Exit Gunyah hypervisor and switch to EL2 during early boot. This must
 	  happen before EL register configuration in start.S so that U-Boot can
 	  run properly at EL2.
+
+config QCOM_SNAGBOOT_SUPPORT
+	bool "Enable snagboot mode support"
+	select QCOM_COMMAND_DB_OPTIONAL
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	help
+	  Enable support for running U-Boot in snagboot mode on Qualcomm
+	  platforms. In snagboot mode, XBL loads U-Boot directly for
+	  manufacturing and recovery use cases.
+
+	  This option performs early boot initialization to ensure a clean
+	  state for U-Boot when loaded by XBL in snagboot mode.
 endchoice
 
 endif

-- 
2.34.1

