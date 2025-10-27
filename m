Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272CACCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 11:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DCC082A9E;
	Mon, 27 Oct 2025 12:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vy9F6gZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64DA582C7F; Mon, 27 Oct 2025 12:33:44 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C806680107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 12:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59R8bliV879996
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=8pq3inwIxGTmX/MgCwsuvV5U7TJCoh0gO3A
 NaX1TRhQ=; b=Vy9F6gZLOrZ2wKqdtWY3dPMItcjuymSRslURWpCtKR3TSTjMfWy
 wnwROclf5n721f08tOVVyKtDrY9b4oVSeKsUIew+OlWxRqLwNngE92Lx4sHm80fT
 10IPqrESaNXA2dLkerZ3wxSV0uqo7e8o9lUMqYWfzx1anHQB76C4Lqrx9E0HYac7
 d2uaBuXr7q/OxOzwfuwa4ZWFomKmHrmbAWJbkMY04k4KOb3Y3ygiyQwiGpzykNBs
 cYQmJEdeKfM7vadFZZ8CnnU0XoZLbu3MfrykNHxRXyTwERRlixmhMuTORcO0AkdT
 d5vc6QY8YetlYyWavT8C4tXzAN0Vcx5n6mw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1ud1sscs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:33:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2697410e7f9so118333775ad.2
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 04:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564819; x=1762169619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pq3inwIxGTmX/MgCwsuvV5U7TJCoh0gO3ANaX1TRhQ=;
 b=jVy9KaRCBJsKTFxTE3E9FESyonTOx3GkbPrNG6Wqr3S9b6A+WFP6qP2eoUVcbKHUUl
 Q/ekl7nR7UiHNm8lInaLTzOGimi4qOaC13cZC2fTPuHQXYDxd0iscf1r6bckPxxwtzOj
 +YCJMA97CbvBgbBPBceYVZoShwhc7oOcVNL0DbNYSNyN6u8zhQWv8PGTtn1fGpEnbYO8
 xYTtagGQHCkeEOxWnj8nEyMhfwEjXZ3JGbdnJwK2AZAntJvtZ6sSF25DahNNiyb0Cjjq
 3mYOuQLykw8PiJ3r52ysnVH7UYHjxIQB7uAmU8NwSmkJWJnZdykTmIS5CbOBd1JVzYIS
 QOZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoKOXpFDT8BTN/xDOnTfkNzfMk9J+gRkZTrUroIaBsP1Cvp71RYqMKmJpZ2bpy4vkuU3cBKMw=@lists.denx.de
X-Gm-Message-State: AOJu0YxURNV0tz7OEc/qE/8UYP/8gTWA6uKr1u8MAMiTyKh21yAwTNJS
 rRzPLvoCFaITu2rUKAAb9ZE8zRDlvdwHX2ODdyiT8i3Q3Y+njfibQAPn2pb8hBs6laaxBj+0Msd
 9EFpLW3ZhpfJoZp/6jejPWSWElv5oGsyblEfF4lh8Tk0WFHe68Kob//Hm
X-Gm-Gg: ASbGncsnC6bmuuhJI0UF9bwrPCh7c+TiE8yJGl67fwHY2GLo/eeBpvJPeRw0Asa5kmb
 XkSKiMwAnwRVV6CSBOr3qDBV7MIZqv2dum+x/keDRPsmy1FEPALyCe3MdaAbNBV4IFTjjl2/9Kg
 cOYwzwqiF1LJ1nNzlp6PeIhodrs7Buv9RKk7AySgWNuo5h+zg/9ebBwAifSAF9Gdj5CIPrAblJq
 yv4fxSEeSh0wQsP7MCQkUsEw5kDgjkPptMzjEBoAVwzHEodsdlFvw+J9Gf0Bmqq9gBkLecJvOSo
 77YnsTnyk8Kvkfunss/FHuCI4e1H06ttKVAtcy/OdLvQzxSmqh6JHiCoZhkWjpgYvKGdW9ZEhs9
 vaZCvEI0bfArW5H17+Zh4/Z5KHhx43BzKCuGDQ7VTBbqbj76FA9sXOhd8ThA+dsEUus8/7Omo/u
 Iy929qSS5B
X-Received: by 2002:a17:902:e843:b0:264:ee2:c40f with SMTP id
 d9443c01a7336-290cb46c41cmr412712815ad.52.1761564819064; 
 Mon, 27 Oct 2025 04:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnuEKUNh5fI+JDoD1F778DquTeRjTvl1yBakds0B12odx1UL87BHzEbpc32WzDLrHRrRsYqw==
X-Received: by 2002:a17:902:e843:b0:264:ee2:c40f with SMTP id
 d9443c01a7336-290cb46c41cmr412712515ad.52.1761564818529; 
 Mon, 27 Oct 2025 04:33:38 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf4aa5sm78497825ad.13.2025.10.27.04.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:33:38 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswinm@qti.qualcomm.com>
Subject: [PATCH v5 0/4] Added QCOM RPMH Power Domain Driver
Date: Mon, 27 Oct 2025 17:03:08 +0530
Message-Id: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEwOCBTYWx0ZWRfX4qpwV3aE06Gh
 ybpCfeVkRz7R4k0ecVWmaYEBgrxkMjiG/8vAFp37SnAl2Lzt5Z7p28k+rpjs3BsW0HEiwYOql7u
 oD+S2CyEDDguuQhx5h7Oy65zuBiMvz/rHW0dLzilBbTyc1iDiKWuZ9rcOlc5RHDxfpWbideHDUB
 fx6oBGiPsv04bdw+qNp7yK6QbxZNZn7RTAO7HUUHdGnIZD4V2nhGeCT8TELzGClpLd8/cWEmlrP
 2lBRRLUkV4SaZCAXiFJkrzzu/p43bR3wDmWkRfC7U38fI13QDxvSQGJm0cCt2rHU7QvX2Xxe/RI
 eNBfcBqD/7+UKe1Z9IhNtlU0zjK2VNy9Di8MBUVIrcpBOqFwbVK2v4kJigw4psTeS0r5VhI0Fr7
 8+zWU+/UphqnqMHdbPNNbGjb5dklSQ==
X-Proofpoint-GUID: ZE3FcxxHO7jhtn6gxROKR_EU4myGUJDJ
X-Proofpoint-ORIG-GUID: ZE3FcxxHO7jhtn6gxROKR_EU4myGUJDJ
X-Authority-Analysis: v=2.4 cv=UqNu9uwB c=1 sm=1 tr=0 ts=68ff5893 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=EuAw1RFdh1CT6udIzeIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270108
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
Changes in v5:
- As part of "qcom_rpmhpd" driver removal change did in v4, the rpmh_write() in drivers/power/domain/qcom-rpmhpd.c
  should be passed with pd->dev as first argument to align with it.
- Added (ulong) casting in rpmhpd_match_table to address the warning. 

Changes in v4:
- Added all soc entries in power domain linux driver to drivers/power/domain/qcom-rpmhpd.c and
  stubbed it
- Removed "qcom_rpmhpd" driver & unused members of struct rpmhpd in drivers/power/domain/qcom-rpmhpd.c
- Moved the "soc: qcom: cmd-db" change before the "power-domain" change
- Link to v3: https://lore.kernel.org/u-boot/20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com/

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
  soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
    functions
  power-domain: Add QCOM RPMH Power Domain Driver Support
  mach-snapdragon: fixup power-domains
  configs: qcom: Add QCOM_POWER_DOMAIN config

 arch/arm/mach-snapdragon/of_fixup.c |  31 ----
 configs/qcom_defconfig              |   1 +
 drivers/power/domain/Kconfig        |   8 +
 drivers/power/domain/Makefile       |   1 +
 drivers/power/domain/qcom-rpmhpd.c  | 278 ++++++++++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c           |  45 +++++
 include/soc/qcom/cmd-db.h           |   2 +
 7 files changed, 335 insertions(+), 31 deletions(-)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

