Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90140EF4ECA
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 10:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8066183936;
	Mon,  6 Apr 2026 12:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kzj9bJlZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eYGq8RbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA5A83936; Mon,  6 Apr 2026 12:55:47 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DC980433
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 12:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6368EapL3173845
 for <u-boot@lists.denx.de>; Mon, 6 Apr 2026 10:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7k6i+CW4Mtv1xazrPTFj+e
 UsOCw9iw0LkQXXHo7c+3s=; b=Kzj9bJlZZzyJ9Zi2iuBSMVleByJOE1tvz/EFQx
 zh/sELM+XMb9ncR64pLjdj0zXZzi8NVDvAp8qKMDqPnjupfU3OCQGpd6F68d7Ejg
 FEZWEtpLvh/Hjaf4y4YciJNbt+XS3wyGGvoQhuFX7bCZiHXNqmEvM1S0iKFDrj7V
 +9peTmxWBN3iMNDmbx/y5uUf8jC8hMmS7exsUOqggZQBGM4bvIjy9IgWrIh46wuK
 U9gY7zEAMKDbamkGc6soAEdfZFQPVnKefFpM4TkvbWBIor8vKMSoO6I6Ucp+ou3a
 p2l/AFgDd64nA6DyPT62ye6RwmoNZ2DH635QU0Jj3WkffvBw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daskrn1nj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 10:55:43 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76dbf0fad3so1018064a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775472943; x=1776077743; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7k6i+CW4Mtv1xazrPTFj+eUsOCw9iw0LkQXXHo7c+3s=;
 b=eYGq8RbGCtrlV6OPyM9Gr7d1Tv3VD6O0xhwlAddl91EOatFvTRZq9qcm8as4EsuSXy
 ouTgPY9KTWyj43kSWUjw+4MK0RYrjKZWQmt3IQt0KDacumPGH6eOwoNtfVsCpxFxXpkH
 e5tJQWoMC02xv8sDT2/XdJgFplG7ELUhwkmlhTDBVIp9EyUlRyzUSo0jB3KjIaGS4JAA
 QFrp7UyFLYviuXGKR6ftLT/lxBK0gnqFC7ATek5GHgy75Qa9RnQl4RH69I09V2a3l1xK
 YQMJHuZsPInWd3cwaksqZb051vWPlGuYcp+toajXdtwGoTbbQ9rPieYvZ9s+lHEwfLFs
 ywGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775472943; x=1776077743;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7k6i+CW4Mtv1xazrPTFj+eUsOCw9iw0LkQXXHo7c+3s=;
 b=EyGyWYYf+5KLHJcXiPl16ahrjbOb5Eg9J0nTWrClcAgJ9udHlOW/wsOHvcnnqBSUv1
 WHeeXH+9h9TamKivCJcJ8dD9N9dmTeuvG9H/f/fGB8DuFVIaiuJ89L3R1Z6B94vKnbi3
 HgqHwp2WB3No/bcAkDx9VTGwzDObZI8UvYgbwa633wJvlWhDLj5jsqXGPpju4OuTVMqz
 xR5n4n1oaiSi4qQVAD/qX9H4Bv+hrA3jn4EH/xJRtOTmRJoRjiz75Ca8UvqiSVhR9m+j
 yHtgEa9X4n1DU7DTE/IZO/5yF8dBqfpD681yCrEQIJNnuZR6SuuF37EqjgDdu6be8zc/
 tGDg==
X-Gm-Message-State: AOJu0YxNHKKgLafSRfFopCkiDGsSN7IoA6bWenl/nnNqiyXJY2r1ZITI
 N0hHAc4jhx8wapfKoDBzFl3IOJ6wPPKRYN56JocOHUDgrwjKYUaxN3rZbrpkInYrdtmn3YceoPx
 hKGeHmeoGEpopWv+elaS0Hkil+GvgK6TPcf6vc+47lIX8jULtlO+Jtumv
X-Gm-Gg: AeBDievYaaBxFel33RSGzGHyw3g70MkGUCkMqGxgRrMD2Wwd+t2uODR41Lrk4jaLlci
 vQssVLzrcfv5MTBHN2o9eZjCIGbG8GZY5m6X2lgel4RpuGK4e3O1HjsNWMeEVOybSeuPAb1Vsdq
 gvkcO+v8JHprOYSGd/jlqbxLuSgiqE3rgsYYdXUGjcjuvvHaWpEoRrT+uDKAS1XNbugXII8XnnM
 umWp5EapEUATptVG6oJdTWpKh1QO/oFZqBn09bdYeaB+FVYb2GGK0f3mMKXJKxXm9qC0nJFZpmk
 rnwAO2k7sKRlC+0CrhmxeUt+jAjY05BKcDWQ/rhlfUWV97Pf3Rn40v3UeEACLFQMigiH5QSX7EN
 +ebP8Nemqog2XTyX2rjjIAlY35EYnfG70Vpfi5KtZo3S25+Dp36mHhgogqdtyuRInRu0LUyjnuS
 ZUiE7Ya4FEnLmPSa4B95QnL67owGHveOlZxorYHetjdG1kmtt3Vg==
X-Received: by 2002:a05:6a00:90a5:b0:82a:7734:8c6a with SMTP id
 d2e1a72fcca58-82d0dbbe3a7mr10617737b3a.48.1775472942801; 
 Mon, 06 Apr 2026 03:55:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:90a5:b0:82a:7734:8c6a with SMTP id
 d2e1a72fcca58-82d0dbbe3a7mr10617709b3a.48.1775472942278; 
 Mon, 06 Apr 2026 03:55:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3baffsm14128816b3a.14.2026.04.06.03.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 03:55:41 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/2] ARMv8 timer fixes for platforms without EL2 configuration
Date: Mon, 06 Apr 2026 16:25:35 +0530
Message-Id: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACeR02kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwMz3ZLM3NQiXQPzZCAnOdHE0sJcCai2oCg1LbMCbE50bG0tABwo1XV
 XAAAA
X-Change-ID: 20260406-timer-07c406ca4987
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775472938; l=982;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=MHkOmxs/Nkf04bTt97QheEf3YFP/I01lbVfk8pTDXfE=;
 b=Xa1b0tum8Bcxa1Q7yTjzOyaIyHeTGeQH1MD4WEplgQF9qd9JnIBiefFdCD+9U5enF9Lgkqjq2
 lHsS/XDRLYeCRbJUECZS9FhGhqjQy6yYIU4d/oOZXvOxGBVkt08AKCH
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=Xpv3+FF9 c=1 sm=1 tr=0 ts=69d3912f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=9aT5ugCHidHj2AFqBCIA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: F4WnAVtHeWUWOCnRk449IUWLpEEutThL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEwNiBTYWx0ZWRfX7xUbKJLufpbK
 LNa64xfOsN3p9gzMEhIEFq+fJOooWu62GQ2LhcgqrLwYwo8uO14teKJ/Sswj8Ap3uXPTKe+1QGh
 pPZsOT7M3kcgpuTmE8DFTEOz9zdeN4ublZdojK0/n8c8aRpcXYcQoQ9Mj5YI2tbqGkrVzzpKNhR
 2wGAcfBG6zVHLnBp2vGYStWvRfuL6JRAKF2Np6jhJkJkNlmnJOYg95UxDesrr7bT4cFrhUYPxB4
 lvKeO0dELyq2g302R+5bXf9eHfghc1gG+ePwkigP6RKHPDQBDBsifijPerW9CmpTaEyai56XXAJ
 R0v7czFrFdwplUAn73dnQpdkWR7vr+NneUjlWMSigCGg3MLAiaxqcW2ajOR3wR2vMTk9KVtKaEz
 v3gVUkSiFJDv+7RstDw7qGYCVEVQKYsL539uLYD2Gvcy6senwyzLFnM5Yu1Iz/fVed5s0Fv7YLF
 cFjcCBb0roGDGuNSqJw==
X-Proofpoint-GUID: F4WnAVtHeWUWOCnRk449IUWLpEEutThL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
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

This series addresses timer-related issues on ARMv8 platforms where
U-Boot runs at EL1 without a Hypervisor present. This is commonly
encountered when using tools like snagboot for
recovery and development.

On such platforms, U-Boot runs at EL1 but EL2 timer control
registers may not be properly configured as Hypervisor is not present.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (2):
      armv8: timer: Add option to use virtual counter at EL1
      snapdragon: Set timer frequency for ARMV8_CNTFRQ_BROKEN platforms

 arch/arm/cpu/armv8/Kconfig         | 19 +++++++++++++++++++
 arch/arm/cpu/armv8/generic_timer.c | 13 +++++++++++++
 arch/arm/mach-snapdragon/board.c   | 17 +++++++++++++++++
 3 files changed, 49 insertions(+)
---
base-commit: 47e064f13171f15817aa1b22b04e309964b15c2c
change-id: 20260406-timer-07c406ca4987

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

