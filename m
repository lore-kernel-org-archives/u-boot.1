Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BECAC83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DEBA803DF;
	Fri, 11 Jul 2025 16:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7bckaPK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB9E805D7; Fri, 11 Jul 2025 16:39:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE5DA800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB06kY012020
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eqD8Zp8SdFoRaXEAVVVlCFAalzCtlvIKX6f
 4I1XGiMA=; b=L7bckaPKEqFHZozZS100JWDucHYExdNzKm5EwO7TPBKANIu3S2w
 o5rcMemlIwHwZlNW9RsjrdxzV6ACLYQembMTYGee8ry8pO2VTxJSS4hwKEyUbKWZ
 rl3KKuYQVL5kpyqjXH+KV98WB6HnPzkBbYt9se0ndR64qqSjoPqsFoAVS6Lx0aYg
 IKhyGoQfgQ18Yv+z+5G/2JWJAnHS/+dG9DDbugQf2+BqCM00OjqVrualW8/1xod5
 BOWRagA91F29wl1rxo7TqhMWhLm2YgVH4p/0YSzL0rSp4V0xB5jFc1659Us4ylCx
 fbedj75fRbv8IUlz0mWCKZ5InmK8DGK5Veg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9e0vah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 14:39:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23632fd6248so22615955ad.3
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 07:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752244740; x=1752849540;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqD8Zp8SdFoRaXEAVVVlCFAalzCtlvIKX6f4I1XGiMA=;
 b=Yxx3TM52L7GRqqX5RS5xtSYMY+u7f/e/NsA9243cIDSWNst5ZmZ9xQ9dJNyyNEhpGV
 cu05j/fCJypwlnhKH8loKXC23SB7w67N2UyJMU+abGWsXkEm+RiaKwskC9EE61SzgoZp
 s9KKgOxPrHgLRkSPDLEX7YbrQBB2P6ML1JlSemD5b65I86tKnbYdk5lelTCGMsWHGhao
 nejDN3Vb+viW8ei/ZMtjg/CpRC+WnKsfPHk8oVokUzkodhyQj6YqGRzmDtKCiTRqzFF2
 TwqURl+PmaXS7TE8k2wRAE6NTJKXR5RSbHpC/JXwU6NTNcuSDpEz7KkbNMbPJOOGAoWH
 74sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSOy7s4sOeDZ/v9K2KZi52Fd9bAvRMnP5eikOSZFqmXafy3VHWTVABfbGgkF/yjyu8UYnSzSo=@lists.denx.de
X-Gm-Message-State: AOJu0YydkiMdVbFIGd2W69occwhp/Mh13BWnpYRfoJlUtRCey8VFqHL/
 ZxMiawDufvOIYNOv2I95rploSK+lr5dKXnlPOIBGWSjY8MgFSocrf2++fpDnDjpx77IWnNIJy5j
 GkKNMSLBqEbJ6o16/6sbnRnNtx+eUQaxL2jaLPLm4Sl+cNmUPv8NXPTtk
X-Gm-Gg: ASbGncu04EyoU1InkIvVEc97K5GmsV2/6XpBJePzgxCk23O9oN8KKrErFL1sAI8qcbf
 gWiK/Fhw0BCBCrjOHWj1snuh2pzwcqMglmFigCMiiFB6bocalwPRnypGyyGBFHh/aCbqGP3Iqul
 iXvyP0oUIXmkIaAJ+FXiPA1O7jjwlCdI0Mt4z1FcOtTw752Q3GJqZg9QiGWGcdqpnRnI8SD5eLQ
 LffM73EUQ5kWiKDvufuzl2R3hTzDT3Y2btAYF+l3WP3NwMSTrciS+vpxMdChXb1pW+Z+tiJItvK
 u4dsj1/zIDP1Q/IZK5CMwM3J2tQRTn8XNbCthWAvIBjoVCP/O2A4LaCB9DjXf/4la1w/2OHA5La
 tKLpdVJxUNIIyN9oiLqgGAKo/Zlaa7g8tJo0XPxg2yBvWmgdzowY+FsDWJkE=
X-Received: by 2002:a17:902:ef03:b0:23d:eb0f:d81 with SMTP id
 d9443c01a7336-23dede2f323mr65064635ad.1.1752244740073; 
 Fri, 11 Jul 2025 07:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiSxdPBXVnl7tJAH5SVCN3Jwprs0ZDe/9EARQRfOfhI2rdoroYJLL1szRpUEIjKfdnYeA8rQ==
X-Received: by 2002:a17:902:ef03:b0:23d:eb0f:d81 with SMTP id
 d9443c01a7336-23dede2f323mr65064075ad.1.1752244739625; 
 Fri, 11 Jul 2025 07:38:59 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de42ad948sm54234675ad.61.2025.07.11.07.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 07:38:59 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 0/4] Added QCOM RPMH Power Domain Driver
Date: Fri, 11 Jul 2025 20:08:47 +0530
Message-Id: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: J82r0-HXDEFREzB2wzqgi8UULnlUVXQa
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=68712205 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EuAw1RFdh1CT6udIzeIA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: J82r0-HXDEFREzB2wzqgi8UULnlUVXQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEwNCBTYWx0ZWRfX6wyUvFcah0N1
 LzpE7y9ZsL1O/Uc1d4eInGMG2zLAoW/YiCGNWNhpNAVz1/pZM98Pw1ZZj9k2yRysZqjh01E2Str
 zsT74Fl0DblCN9EqC/hsUo5L9Hq1XO6ry4d8v4bQ87d3n6E9v1nz9SdGOXv2wZPW29WLv/uwJv8
 dyE8u88nI3XsNjAq6xfo5++WOJJV5/z4gnTPmN27AWHwsxsEsln5xSygr6ULeN7qFf+8QYUDK/3
 m2hJGmIrleB0yPvY+sztF4d6Ztu2+wua/t2ubcrIljp7zmdZEWmA1TOLnWpZtIo40iV+xrXKjkc
 G7kE3Q2YhzsZEjTJla1W95YwfAGQmYiXmS4vqOUk3ohx0Vjti3DiKycCXNHtzhyybUxjjcVKfGl
 3/YZ24lIP96q7XQ7asdpvgx7aTybFB+LryQ1HJqrmVqbQkJEOzynEEcfeVTRA8KHXb5yCnc/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=551 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110104
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

