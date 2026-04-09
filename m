Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3BAF31E3D
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 15:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76EE583D8A;
	Thu,  9 Apr 2026 17:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GBDzm25k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BbqH3g1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CC584099; Thu,  9 Apr 2026 16:43:48 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8511683CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 16:43:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6399tAdT1727209
 for <u-boot@lists.denx.de>; Thu, 9 Apr 2026 14:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=l/PqLS1gJxsK9PxYcsXPvD
 /jungQ3O2viuBtFJPQ1mc=; b=GBDzm25k/v/8tC3luQndWDFLDH/4VQVdkurXVv
 nDZ+mVibY6WmneMN++8Z9qtBQKfFRvZQKOAgDxPacc6xK3T7aZ97C2NLS8N85BKo
 zwKBC85ty/53NjMOv/PLMYPbRPO3fVRXZTfjUm4bekc3QXXry+Iedl06XMLJzcQV
 gA0t2BiRZ7pyw6h/rZuUprwc+akoxCYvsjU8TgUYh7GPmt/94WY0WwjswfweqERg
 KQW+k4dHab1H5d3LGHVlM3VVHPGVJWPPMGtfP8vfhbTMmXEZG1EwVGuhOwrVV8VX
 yhCKhPLjaXuchIsSUay2Jx3dD5NkV2W4ZovGutIhh+R4fTvg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddwcrutd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 14:43:44 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2aad5fec175so15849905ad.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775745824; x=1776350624; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l/PqLS1gJxsK9PxYcsXPvD/jungQ3O2viuBtFJPQ1mc=;
 b=BbqH3g1uMc/rXan9BOZBc49T8l0F7fMMScwrzPodbCWjEK9Vr5yZn9cMn5Cp7KC/KD
 QUA6VuUee83tYxU7WLEYmPjkOdZPe7B5l/VAsk4PpH6iQovIkp9te+2m6ZDsvpsqgbYy
 vsHER1p3wTM8PAPaO6Z2cysKiOY+g/OhScgpf/wO74fO52uNp55ghmkZxUDXUOxY6ttr
 6WR5l9+UoBy9SmAT/Rp4HpbYcS2zU0exLHPASRl/xgRmm0/Q37l6uSiJv+lrJyiMmITw
 pU8M8mHDJPSMnC4oNiU5BuRenBxQAffJ3JkajPfvkL/PKyPsGN89/gY1lHv4HhsuaCLW
 7lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775745824; x=1776350624;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/PqLS1gJxsK9PxYcsXPvD/jungQ3O2viuBtFJPQ1mc=;
 b=c+kKXu8epabOxU+Kixf2fWTpflEqysEBVEcknD8gHSTt6d2puNE/PnjUiF/MlNIgA9
 lok15bqISbn/0UoPPblUUK/TvC5NaTqr8WNxfXyNRuV+fKQchVif3hrsmnZSff+LszMf
 kR4eVGyJFoEafZ/uPwpg4b2f7nLrXuVPk0+u+NUAl9y2ti+36bbJqG7jos4BTmjeaeBQ
 L4VJA7WRNKV+4ciWwKc/5TU/atdBfqEaWR24RvquJuYsBvf5/IhHYl2SfmCDdANxyeNH
 L6TnwWqMNvWcbxji11SRtd8cXEpRxq76+qBQFIQzHqD3d9kL+2Uzvvb93rQgrP169s05
 LG+g==
X-Gm-Message-State: AOJu0YywUbb0ppa7Vb5SFAV522QMPvIrx+istIyM9IytcnwT7fidBDE6
 sl57PXeQESDZAZfG3lETcz1INo5qWj5A8HZGxgCG7yc05qjxVDQOlp832PHHM/cerrijFL/KEyU
 UGBecgjGChhkM9mNN9x23IC+8EsWb1HNGjnxbejM4msF3R7Eh2BPgl9R6
X-Gm-Gg: AeBDietFNZHJZ95RT917Sd6cHrgsYxSl5vgKqKcw+4Q738ftfUWrvU97S9J6nS9/pUS
 hHtdV+cNscr+VpFLJA5lTKwdx+2VRhREzaFYQqsltmKuGPifLPFEyHKRz+Gz1/ihQEIAf/wCUOv
 Q2BkYWbtlS9KycoKpZF5Ee2q2U1CmIu1uNEcnR2FnEk9007lo8MQpp4IOtCcdq1aTyU0Eog7bIF
 fB4BB60ZH2xseJA3y8MjHcT4leY+iwpwGXhQenAMnDHou3J5Dx4fqNNekjtGHaRg+Ciaedrzekx
 spfMpMoGyOLtMp8OIn6aXbTOGpd1pmXyuhMDb91HFQizck+xsafrA/VOOVmMTJckk/AwU+cWcmW
 L7WdEUa5vauBnwbxLoBNsNFLs8UXz8IUgNdNm9jzLJXqg5Xw9miOjewW0BXhH0Urer5IXCBfsCM
 1j3EjpSOzSSrZZL8+EAG2ZN2GfK5tgd+K19EPJJDC80umILz2jeQ==
X-Received: by 2002:a17:903:1209:b0:2b2:6cab:30fe with SMTP id
 d9443c01a7336-2b2817992ddmr286121535ad.29.1775745823806; 
 Thu, 09 Apr 2026 07:43:43 -0700 (PDT)
X-Received: by 2002:a17:903:1209:b0:2b2:6cab:30fe with SMTP id
 d9443c01a7336-2b2817992ddmr286121155ad.29.1775745823331; 
 Thu, 09 Apr 2026 07:43:43 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd85sm235083535ad.74.2026.04.09.07.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 07:43:42 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/4] spl: Add UFS boot support for SPL on Qualcomm
Date: Thu, 09 Apr 2026 20:13:30 +0530
Message-Id: <20260409-spl_ufs_only-v1-0-f7e0e243d805@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABK712kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNL3eKCnPjStOL4/LycSt1kS4NkgyQz06S0NCMloJaCotS0zAqwcdG
 xtbUA2rHb0F4AAAA=
X-Change-ID: 20260409-spl_ufs_only-c90c0b65bff2
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Javier Tia <javier.tia@linaro.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Dhruva Gole <d-gole@ti.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775745813; l=1357;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=tcjh2ur8UatBPMySh8NwRA0LHUtECq5rLkYE3qbuQzQ=;
 b=EzSbFnlF68trjrjrU9Lwi/KDcdXTqtewHIdSyWjrJr72s5LocvCQYJ4TbfMa47P5f8ZxeZax5
 C10SqGAQYkdAbZg7oxhLXVHblRksEe4/QJVpuLvncXHcBkxNWyJJyIu
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDEzNCBTYWx0ZWRfX+yeMghqlpKBp
 TYLuFwpo/xNyJuL0zSFHJsvrQpz0UeUO7T87P6WaCuz3iDTioHMmLXdbgecHcSIwQU9SLIvtxgA
 1KJuLafkXeftYwzOUdBm8vC8xSbKwbMRRrV7NrP9Ye3ks81rHN8xOY6Av8qEVBmjZ8CQ4zzPdsF
 jyclyw/yOgofrg7t/uew8er1sGfQvzMLwzg6QkorkS5/qnzUi3JXvQx9ECAKUfLHR/4QQwuJYCN
 kwFi3Kjo8p1JSyxQ3J+vxeLiGC556miLSuhkvkeGQUvUANdtvU7X4zgOhrMmxjQf5ViVk9U2ul2
 VwM/mB52rlj6YZLMIrZxOz6IRkpkJNuRDrsoxz6gPfMpoEMy/M1TfpoKa74CxdtvzgMhAxGrQcn
 +Y+4xtxOMpjmASWYssuDuZ4D2zR427BuR7W21bonZ//0bFM/xnru1Ccvo76dGwy+PS52ogs+Tza
 AKJLHfouJfwx0UGXnFQ==
X-Authority-Analysis: v=2.4 cv=SsWgLvO0 c=1 sm=1 tr=0 ts=69d7bb20 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Et04KiabTPJpFPHYH60A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: v7H6YC8gwDIZ1fURJxOyaDq4H2mCh_o7
X-Proofpoint-ORIG-GUID: v7H6YC8gwDIZ1fURJxOyaDq4H2mCh_o7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090134
X-Mailman-Approved-At: Thu, 09 Apr 2026 17:38:43 +0200
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

This series enables UFS as a boot device in SPL for Qualcomm
platforms. It adds partition-based loading support similar to MMC,
enables the Qualcomm UFS driver and PHY for SPL builds, and adds
necessary clock stub support.

The changes allow flexible boot configurations using partition names
or numbers instead of hardcoded sector offsets, bringing UFS boot
capability on par with MMC/SD boot in SPL.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (4):
      spl: ufs: Add partition support and flexible loading
      drivers: ufs: qcom: Add SPL support
      drivers: phy: qcom: Add UFS PHY support for SPL
      clk: stub: Add Kconfig option for SPL stub driver

 common/spl/Kconfig        |  40 +++++++++-
 common/spl/spl_ufs.c      | 188 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/clk/Kconfig       |   7 ++
 drivers/phy/qcom/Kconfig  |   7 ++
 drivers/phy/qcom/Makefile |   2 +-
 drivers/ufs/Kconfig       |   8 ++
 drivers/ufs/Makefile      |   7 +-
 include/part.h            |   3 +-
 include/spl.h             |   4 +
 9 files changed, 243 insertions(+), 23 deletions(-)
---
base-commit: 6cd26c192df54db580aaf7fccf601b5dca1f13ce
change-id: 20260409-spl_ufs_only-c90c0b65bff2

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

