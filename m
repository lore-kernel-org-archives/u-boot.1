Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA0ACD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 472DB84913;
	Sat,  6 Jun 2026 14:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJ/0P4na";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hR+tgMQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182E78405A; Sat,  6 Jun 2026 12:21:41 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D02838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 656644Bs688750
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PasHgqwh7CYP+R2nBzdomLMzs0ng8FKc4g36eB2j6BY=; b=KJ/0P4nadDg5bfpu
 eOjnXJ5ry7C2cWmTZI8BN5s7tTNqu28eDJhJyCkaeWBa9zA8NMTiMgF3uE2t8fHf
 3ZW/XD0d9Q1jJcsu9Rhd7a22zu46MJMlDg5VGpM9vMAk8sqVi/CLCVo90PaiNpLB
 ZNw68DZm+DoJKQIf5FlNhpn1emDQxg3VNRJYCqzAz8nk2i9+FiskB04G4BJmfxyM
 YEqMwXyzje8MJ+IfJb4g+hixLSegSKEcMTVnHgElGGgZZPdjlI9rj6DlgM3dTNQx
 GQm+Zhxu403tuuYY0bpnPTo2bF585lrIQ36BpTM0CRXfjfufpZeU2ZAei5/0p3QX
 sHzpCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4s3bn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:21:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bf55c3f44aso30393125ad.0
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741296; x=1781346096; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PasHgqwh7CYP+R2nBzdomLMzs0ng8FKc4g36eB2j6BY=;
 b=hR+tgMQuALxC3cT1eGWIPO5I8xFLxB0r8oiW/xU5W5bQ4pmUccCHdfbK0VlNmZdUTd
 UmLogbQy/SsP2TUqXJIhB4qO83RCD20bfJKA7uQfHor+YVBRgXH+iocq0gstKG+vU43c
 8u9OU3IhNRUxRUh3KzFLGIrBzO5mldWaAkNQxllAIBuCNeW4rX8PXe/fdUCC/pJTACk9
 yjEoGdBb23IvkzLoL9yzA/uKPxYX8tx1Zi8wmGraZG5xM7IR8vYpOpbuvxG/XWeGumSG
 O7t+ARtsviCtKjghcq/jk9GxB06xKMVel5MnPLirIfRmyulHOGygQtfM2VzhUs52tBlr
 VW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741296; x=1781346096;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PasHgqwh7CYP+R2nBzdomLMzs0ng8FKc4g36eB2j6BY=;
 b=pIFmcnTXFxKsP1aor1KnMUSWq8oue4iD+4VCD/MSxKOwC3vQyJn5XmHkh0G4wNEI0m
 I7G34SYfet48FouwzmhABzX6s4SuzPqsds59yUWOWL45GTT7GGV7rhjvW8SVpNWVkfgV
 vCCZudIpEQEqJS3Tz/hXAkhXSoorFKMAADUZ8Qu50nrGp8hqlnrJUK+TaFJ9tmZ2nAav
 HgQcRbQIokj785PQL6TCn2QDonL9bpMRl34oEwbZp2+OPr6hUwZCxLYbaN6YLl8x6Vgr
 PbBGqmkgaq4LMDC1Gq3ufCxWrWLoPxkANwKY06OwbC7xhnza+lYf5mdbTVkoEC+bUEb7
 JHHw==
X-Gm-Message-State: AOJu0YyWeLQJRlsIAvi5obxwH+TzzExbGBrdz+Lmzc3Kpj7O8G/3t56y
 PngMYSaxafpcwM4KuQJiznPWSx14zwALUd24RjyHIrC8/h6jscp3DHVJh73XYpWKgVy7uixONUW
 9GHscaUTwgvmDChras1vvrdRGITSNCqZwaOWTOVtjM3sstw21woWjRHd5
X-Gm-Gg: Acq92OEDFsOymPsk3gyXFzln5dI0Z6Li0+FYc+j9LFWuMi5VXeqJapqPB3FfKRrK14M
 Or4sFHKCR6tl1wiTHVOn0mkIoR43cxqmf1wuy04zhfdUJZSBZpL6MFSimtSY/NYnMKgxFg6Ahyp
 q1UXzadgemknFjRstogJxp8jHfSP9oHmvuEj7+zZL6B/ofwgCIM7/DoKypXjjrxlCI1uqdwOW4e
 MTlmlu9Vvt/4Ot7V1PAPLD5X5fffi9rCH/8aECF/l9El6fVwJQliHYBo7Eq30yKU8oKk9wEZUwY
 b2bGW+21TYL7i252wcEEFhNf+1rCWuHg/3aCoA5k8WfdBzFwCJ5VD57nMb9V0Rp2xo9y6aa6Vsr
 +wvUTVoKubKgt+/cQSelw56KGOx0B885E6ynryGJG/6zpaZ3xej9Wsj9fhPelCK40aO1CRxF152
 6/KQamfNAjRtDZc218MwPoB1Te5tRGBbT2bdRzeT/KqIILWypQwyjqMpSk8SWJ
X-Received: by 2002:a17:903:acf:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c1ec551c58mr63105425ad.13.1780741296483; 
 Sat, 06 Jun 2026 03:21:36 -0700 (PDT)
X-Received: by 2002:a17:903:acf:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2c1ec551c58mr63105115ad.13.1780741296026; 
 Sat, 06 Jun 2026 03:21:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:21:35 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:41 +0530
Subject: [PATCH v2 10/14] lib: update charset.o build rule to use SPL_UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-10-72fed24ef01b@oss.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
In-Reply-To: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=811;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=hkXkmVh9tx0KKrEeTctoiIqzbKe4scvcs8+21RDMvMU=;
 b=48WnouPCojt0+A/TGKrObXm1+sEKy7VmzW6phLLVofBTYJKbEQ816+JCwZthG8heUDF6NAUvG
 jB2ii71ZDa2C56FdFArXbAjoTpk4a7OnyAI7asBYcT51fjRbaarbmW2
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: wZdHxX6DbSUfyb1qmoZO2GfaSjaae94W
X-Proofpoint-GUID: wZdHxX6DbSUfyb1qmoZO2GfaSjaae94W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX9U9DI0wlxafz
 MYYFjhTLTOdKcdA4j4M1ZVc/8KVlXLFOlLkFdAOg3Al6FCFCYTTp8ucuaspr1CdENkjsU5oHS9T
 6evKqqUU81KwNPYdSI7T50/rSUo26m1lYEjt8MhYRwF7wsL7+Gvg5DcT4fQtk/BFvI/6TbhikK1
 3AtCY72r9zE2mDbgN31FtmBWyzFAQd4Z9l2jdhKG7ll6GB0eLo7+KNyX12zE++5GN5KZakC8dMo
 ajJ4QbHSeMrw3HWI8VkJnWDuxZo63Avomg6J8pW57UA21tZNeVmMxwzuVdiFdnwCFQa5ZWwhoym
 GyOETlQdiwUSb78qvaNbb1R4a/DGVPKQzfF5eKFuMtFrfTmUxU13ElRHdGgvYRvrMB237Tl8cg6
 1r/FEfLGT10aSlU/H3RY4zEEM+nNJa2is+nefvK8kuvHLCNBXzHwgV7pCSM5rl3xgf/BKUlfe4N
 KBYc/HRzApsQKVIbxIQ==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a23f4b1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=jAPzq1VG95-kpb0582AA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060101
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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

Update lib/Makefile to reference CONFIG_$(PHASE_)UFS instead of
CONFIG_$(PHASE_)UFS_SUPPORT for the charset.o build rule, following
the rename of SPL_UFS_SUPPORT to SPL_UFS.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Newly added in v2
---
 lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..807a459fb29 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -147,7 +147,7 @@ else
 obj-$(CONFIG_$(PHASE_)SPRINTF) += vsprintf.o
 endif
 obj-$(CONFIG_$(PHASE_)STRTO) += strto.o
-obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += charset.o
+obj-$(CONFIG_$(PHASE_)UFS) += charset.o
 else
 # Main U-Boot always uses the full printf support
 obj-y += vsprintf.o strto.o

-- 
2.34.1

