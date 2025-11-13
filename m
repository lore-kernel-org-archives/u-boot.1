Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B978CD5BCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25EEA83C62;
	Thu, 13 Nov 2025 12:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldTPCyAT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVwnNZdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ADAA83DFA; Thu, 13 Nov 2025 12:43:05 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4335683B8A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AD8wFFg2993658
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:43:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Pf365vUsgKgnTAe3TduTTViauAYnb8ZQBGd
 Xrwr6SLc=; b=ldTPCyATPuR4n+eXXpB0L/xSZAC/p7AzZ+s8VIcZNlXU5OfFezk
 nUJb5tzqOwGDm+mBstWQ8L1H4OWhLFZ2gA3RyCZ57r2LBc4jyPIuwJzOg/KB3xij
 bLoPApUpK7HF/gdKrjIZiVCVmobiYgBUNDhcsvHB4eMS6naL9O0jRK/48ASkHeWT
 RGFwYgmcNQtVqUuMJPjCcPW8IVEPKMRSEiiQ1jVw98TF9SCIvhh6FG+Oe8bcd777
 N/gRrZEsWRtFI5jugH+fIhcYvPH99ev6KLTuyFtHUeAjy6LLTX5zvgL8GJli6wV0
 EPSpTIwqrRVkWglZeyAgxCAOmyp7YpahofA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad47jj27u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:43:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b22c87f005so217575285a.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 03:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763034180; x=1763638980; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Pf365vUsgKgnTAe3TduTTViauAYnb8ZQBGdXrwr6SLc=;
 b=hVwnNZdD3iwPYH/WYWuduLhHiEiswfWUQJgrAfzQ/5xPSjbcxhBq5eaefBqJdEEHP/
 oLHCeRnl7puZpm6FyOvCVxJJ13eazJDVQvJX7tv/rOJ3xVmSHxAzotFfd7BHj2o10cw8
 IH4gt3aPbom9tOcioYw4uVJOAD044EbMTfVbz6QD2OIH20FfQbI2xrGvAKcdsU2gwQZM
 728HZ6XEa54AQ2jvb/EMB9PsMerEXAhlCqrPE82bTgShuzkS6+wS+fnWB1om0DtsqohG
 Bf37gHN/HtlbS+2hu5UjYKWcfVObA/PMapvj79bWQCyfFlNrXANnJqZw2ZuUy8AHhhxd
 GCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763034180; x=1763638980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pf365vUsgKgnTAe3TduTTViauAYnb8ZQBGdXrwr6SLc=;
 b=qoG7yC3pe7UxCDskkXESVkrEpSczLHQpomaaKPPZGcQw5hldY9ay4P1OAOIOgjmcmn
 BZInoZjT4mSvt1AMbmVMZPWexunSD5ZOMxm8JQCwoOWI6oGQNW18FLgz44DzcF8as9w/
 BjlJgl4X1GhuDGv9cxNdVEMQrJLXK2p3rCFelJAxE+1Q2I9gnLvDF2f7VNwCk26l+ZbH
 salEmwOwFwn+Zaw/AqlaL65pNPAbZyRCjUUBldYev0pDx7uGADF4Edb7O2ZQJm9VFCHG
 1qBlcYboKOVUpnAvLtsZF7gWsgqPHwj/e7MSbuqFwF8yro3YFFBxUOXXOcmqEJ8W7wO9
 4SvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMI3FJcbhVpmCPPzvTqi7yj4DAkY1xmXcxkZI2WHmGSaY02VUvrKcSf7smAjNZvbqHaxXOfTg=@lists.denx.de
X-Gm-Message-State: AOJu0Yxn8sXfOyZEt76b/G/u8+c/RvII71842C9DxtEDEb3w8CnfqROJ
 V2vXYxdqJDtUx3leoDLbHuQCZgp+qaBoAURul1ibDgsqGdoXzRE36ahuHfaDi90+mClH3EdDO5F
 4R6oHoq6MSF80zrTBxt6h39pHqHq0yfSTKYMN65NYMsptqXgKsHdfbVPc/9wncDVH
X-Gm-Gg: ASbGnctxGD0g5qCieTQISeeY5n3qPKd1tbXXIewf/ERLNpRPLfi9Mnhl9NAl4Ckq1g1
 ILZmjuy/isDms8vF1Up+vWv8FFhk/qPp7M5Evo4EJs/KhVzqg5YNg367Wlr3KJr5RSaBMDQf00O
 KegWrZYybY1uBhH62546mOyL0vlId1pJpyRqL872T0XLYTaiDX9NW6Ok+vI4y8yhSsDlK748bll
 l8fpIWL+8CaXTd1ct8TljMPURac47JY0yPbJHEoE2bsWmdCpxcXJEioSiYkuEznX5AKSfBEIYvy
 TceutjSvbCLvtjwbIVWH4JHVv599ab0B3RAbHiP2NC9IyUZvsLYFmgDAk0AKoL+/GOp/dp4FT+8
 Le4HSpMXF5vnLneqOf48AUqhdWf9Y6JzPVYWkbpVIZQ9tuP8u2Ecd9isnpyDQrKfhFr0E0Tcf9w
 Ij5Mvg1j2DKvlW/N/NFQ==
X-Received: by 2002:a05:620a:3912:b0:8b2:5ded:ff63 with SMTP id
 af79cd13be357-8b29b77f903mr851507385a.34.1763034179814; 
 Thu, 13 Nov 2025 03:42:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4+N0e8cULrGUdidE8ULGKhMfFx6JQpYYzaKvifiIsyf/BfQ6jverARcEKAd78fRcsxg5gKg==
X-Received: by 2002:a17:902:d510:b0:297:dad8:f265 with SMTP id
 d9443c01a7336-2984ed7a19cmr94563105ad.3.1763033683284; 
 Thu, 13 Nov 2025 03:34:43 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2985c2346e6sm22573885ad.22.2025.11.13.03.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 03:34:42 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, peng.fan@nxp.com,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 sajattack@postmarketos.org, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alif.zakuan.yuslaimi@altera.com,
 tien.fong.chee@altera.com, miquel.raynal@bootlin.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v6 0/5] Added QCOM RPMH Power Domain Driver
Date: Thu, 13 Nov 2025 17:04:22 +0530
Message-Id: <20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA4NyBTYWx0ZWRfX8c9P0/r9eHov
 F9dkIgJjlJaEEwjAe3D/DK5qpg5rh5Q+w+8H1vzwhY81bK/cH1jU4zdhwmozveEnz632i3IPHOY
 HnMtqJvx2CZTDS1taHPiReiotxpJyhxzRMZ5myLFbie7G9AIdJYcnJUhLcnUHoJi0votf05Dg7j
 ksfLQ0g70Q/7z6JKHoqLuPKw/5ox0kSUxzmeMXCBXAMIyaKQcOd4/dLiad5E0RHXczEJKO4AGae
 jb611R6a+IoAAM+HekOdGF5AA7btUi11kr8V3aVwCJXLO0LsA7RcIgndogpPIjRQgnqLkje9L+H
 fGMFL7qUmP+FGXHJ6qUYjdupS01T1omKziQnx84d4isV9YiREmrsYBB8Dov47vL+uj3sQ674k3L
 d4ItNvBk/bCsgk778oQFBJaQNUla8g==
X-Proofpoint-GUID: nYBdf84YHHaz4Maf-lbboZ4Rm3U2DEaI
X-Authority-Analysis: v=2.4 cv=A5Fh/qWG c=1 sm=1 tr=0 ts=6915c444 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=giyyX0tnYtHS4K3SAAUA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: nYBdf84YHHaz4Maf-lbboZ4Rm3U2DEaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130087
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
Changes in v6:
- Added the change in drivers/power/domain/power-domain-uclass.c to give warning
  when power-domain driver is missing
- Added the change log 'In qcom-rpmhpd driver, the un-supported power domains are handled with warning
  in rpmhpd_power_on() & rpmhpd_power_on()' 
- In drivers/power/domain/qcom-rpmhpd.c, the 'ret' variable in rpmhpd_probe() is initialized with 0
- Link to v5: https://lore.kernel.org/u-boot/20251027113312.3815169-1-aswinm@qti.qualcomm.com/

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

Aswin Murugan (5):
  soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data()
    functions
  power-domain: Add QCOM RPMH Power Domain Driver Support
  power-domain: Add warning when power-domain driver is missing
  mach-snapdragon: fixup power-domains
  configs: qcom: Add QCOM_POWER_DOMAIN config

 arch/arm/mach-snapdragon/of_fixup.c        |  31 ---
 configs/qcom_defconfig                     |   1 +
 drivers/power/domain/Kconfig               |   8 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/power-domain-uclass.c |   8 +
 drivers/power/domain/qcom-rpmhpd.c         | 278 +++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                  |  45 ++++
 include/soc/qcom/cmd-db.h                  |   2 +
 8 files changed, 343 insertions(+), 31 deletions(-)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

