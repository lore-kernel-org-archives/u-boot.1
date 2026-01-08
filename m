Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4ACCF6ABF
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F363F8410B;
	Thu,  8 Jan 2026 11:17:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPulOHJI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YZ7/3p4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E070840FB; Thu,  8 Jan 2026 11:17:39 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA96840FB
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60859l6r3890313
 for <u-boot@lists.denx.de>; Thu, 8 Jan 2026 10:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5M4ZuqUJBHU
 AyzPRYA6fqv5fYEmfZko8ekpgtL7aigU=; b=BPulOHJINsVb0Uz8Ks9mDoH+mVJ
 f9FyW9ABz/wcatw0XK/TmtdJgllZ3xZlbIZa4Vxn5XQTCmjEm09Ht625WL0jWnuh
 In9PYLN+NQF09TteDO+0RowlAKQgYxZfXqn7u+Mbxsclaqkq/NjxjIKT6ijPk+UU
 ZEINL65t/4cC1JtGDscq1+HEoICgxRVLLhkyz0BQSibMB2q+72nTkQ7MgQBKuk67
 CtcgEdi7/DUQPI4AHPmjjkJYpugzq1OE6gtThwzhRNPTSOQ9mpyoSmBzM53Y6Za5
 B3UjV2QYEzZQ4GZ4eCfcMMbylJgl/81jbFLD2jNzb6XOyKfjAMKnyl64xXw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuy72pp1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 10:17:35 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7c240728e2aso4171919b3a.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 02:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767867455; x=1768472255; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5M4ZuqUJBHUAyzPRYA6fqv5fYEmfZko8ekpgtL7aigU=;
 b=YZ7/3p4dtKTvUiqMGnPqg2m7gjQ4Lbf9fTC8ScLVXcrH1ee7jHkNMzxTl7g8Fo36Dt
 zgApoGon1+LZeUyXYRNZIwQqRBEgp6ADNU4l9Ws40FXnJuiJnXkHtkLCMU00glJvehh9
 UP+jNLdcYualx4vjJgaMRevi6Oipycwb4xoxn2aojXoZgm6l53g3H+lPpURKcWA801YM
 z46yrRX6Gm4fzCJ5nOCTvhGHmoJfTrAO4HNuyy0DpE2a7uqM7+LlHi86taMPs946j3rA
 ZweEkTiOGarBIOHXVSmMdc1WLFpHHVL/JvZi1PVfC6Jr0LI2TTZ57f7tsEyKeyViJcm1
 3xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767867455; x=1768472255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5M4ZuqUJBHUAyzPRYA6fqv5fYEmfZko8ekpgtL7aigU=;
 b=bJ+T/s0lH5s5X1lCaFIuxUaxX4+U3LNww+ZeaEIgIJWlc+2hb0RibR73fHXFZXzxp/
 vSNuLCZfYIdLdh4lXn5vTRwbpYMO+9VjuH1J8sdWNCVvvx+qEXiWlbIGuO6KE4sPFedm
 MwzrunOkhuJz0nrxW990q4v7W9Ga2LvudCEQZJlvgwwRAbiq0sIDIvuuQDFd6V4HvFKw
 YojX9KGPWVcmzHOZo7piOt6YnLXWO07RGsCuJAHZbtU4mfaXLeSHgZmhQAcmn7fTMY0d
 +Mwz9xpgLLSw/KoT2bt9AMwwuvk8JBI6Z6JWWXM+TuQVDFerI9PyE802xeu4ZmtLEhwx
 +gTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT5+bnvl8uovx6eoHhIDvUDsdtBL4rpZFri5qbaueTYPFzBrQAlD9PhC/pggpK5oRsrrkz0RE=@lists.denx.de
X-Gm-Message-State: AOJu0YxskoPjae7o5R6keB1p4znDzgM6CWhh/6Il56EDfk05gww7Y4Pk
 4+nVmmSEjWRSVopvAMQ8+6vXFQNu1lWe7xpD2KcDs05yBWdzwT6Rah/nT/u142U64h1aHmXyyad
 w4iY/ehcbalqUPLO9xlfl6v3y8MWYldKqDc928Ymyu8feoQBr66IVojF1
X-Gm-Gg: AY/fxX4KorutI26MUy9qDJJ1vzNLPXzko5u4hYAZcfKJcPrHfB2whkgevgXwNT4PuzG
 gkszafSpSphurdBv/a0w1+BLnk8n63kO3v0wZ8pOI9MPM2Em4iCkFaTMbbwtYTfuDq594rM3w3Y
 knCIUuwQZSO/3o1F/3a/6lfppdIuI+XgV14r7ncRJxwc8NcPdsz62UEUD/C2Xxbs9+/IoTiVFZp
 L0I/MCIRu3hDDTTg9KdHI3+Q0BbOYsJ11H8hTOXFXQTJn3kMOxjMSBQx2YIukdx5hB6kiGsTOzr
 2aJmqbkSHcxRNBLAObWuhRA6Ev2YWY3gZLEkruPwtFDdWC8MeH0ai3pgjXh0xefI2d20of2ijYm
 F9g2B8cFPnnpFpZcMhuoseEDrdYVgBntih8X5km2dR6ey6xaJBl2oiSaOiS7kjQe5hxCebRya1B
 erApvBGyiE7xAaPm8AvHWrlI8p2IQhpQUhl0howg==
X-Received: by 2002:a05:6a00:340a:b0:7f6:e75d:8efa with SMTP id
 d2e1a72fcca58-81b7de58e2bmr5032157b3a.17.1767867454915; 
 Thu, 08 Jan 2026 02:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvY82ZMZ2sWJyA2POW4M5B8jaKrxsgfaYK9QWnWGfbB6ku7xSXw6ro70lIMCZDX7P3bBCgGg==
X-Received: by 2002:a05:6a00:340a:b0:7f6:e75d:8efa with SMTP id
 d2e1a72fcca58-81b7de58e2bmr5032134b3a.17.1767867454414; 
 Thu, 08 Jan 2026 02:17:34 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbf29086esm7730007a12.1.2026.01.08.02.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 02:17:34 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, me@samcday.com, sughosh.ganu@linaro.org,
 gchan9527@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] arm: snapdragon: Add RPMH cleanup in
 board_quiesce_devices()
Date: Thu,  8 Jan 2026 15:47:21 +0530
Message-Id: <20260108101721.3411854-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cUWMv6P2a2r7MJ2Ls46WeZoA09yiqhCG
X-Proofpoint-GUID: cUWMv6P2a2r7MJ2Ls46WeZoA09yiqhCG
X-Authority-Analysis: v=2.4 cv=DZEaa/tW c=1 sm=1 tr=0 ts=695f843f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=m2JwQED_AIgQGstdizQA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA2OSBTYWx0ZWRfX6IXfIbpnAns/
 Hr/KC5dciwQ036q29C20WT5IGtJrPY6D57Uhu3H5vDdr6KYwQdfOm+qci9gK1u9eXcE4dhr1scj
 lQAxrNXfB3Ft0GwmdSAZPVB/wmZHLolvWqerK0od2Xy4OkiKKs7n5QFl2WrZp6Bh5wD5fu/G/nW
 p9BJxyp6QCiYWoge8MUQI2n2LJ3cZHmXBozg5pvDB6uOftZtpvwSAdacox0vmkY/hNes3DSr80m
 4+oqnwx0ejqjXZoGik59aEuKvUjZ9sj5KWVi2BOMObP9Y/l4bLTz15NUintwuQomOTCAqfM6PTA
 M2Slpsho5eQRIn+lQ4pwEk6K3GgmglLf2LPeg3w2zwkoQBaRry6JA4K7adqn79tbKCQDwv21VBy
 lbg1VALIQG7BTH2WWEmHoeEtwPVq5u97ecrUf2Zwbxbui5AFkpwNSLDrCxelS1wGOtsUtF4gItV
 FzHHI5aLvVwt1O4+MRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080069
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

Implement board_quiesce_devices() to cleanup RPMH controllers
before booting the kernel. This ensures all RPMH TCS hardware
state is cleared, preventing timeout errors during kernel RPMH
driver initialization.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..194318af228 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -32,6 +32,7 @@
 #include <usb.h>
 #include <sort.h>
 #include <time.h>
+#include <soc/qcom/rpmh.h>
 
 #include "qcom-priv.h"
 
@@ -709,6 +710,19 @@ static void carve_out_reserved_memory(void)
 	}
 }
 
+/**
+ * board_quiesce_devices() - Quiesce devices before booting kernel
+ *
+ * Called by U-Boot before booting the kernel to ensure all devices
+ * are in a clean state. This is critical for RPMH to prevent kernel
+ * timeout issues during initialization.
+ */
+void board_quiesce_devices(void)
+{
+	/* Clear RPMH TCS configurations before kernel boot */
+	rpmh_rsc_cleanup_all();
+}
+
 /* This function open-codes setup_all_pgtables() so that we can
  * insert additional mappings *before* turning on the MMU.
  */
-- 
2.34.1

