Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D616DE6749C
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 11:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4167883D3C;
	Mon, 22 Dec 2025 12:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CWl2NLIp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BCxujRbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C4D83DEB; Mon, 22 Dec 2025 12:49:04 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338EB83C28
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BM7pGhs3935865
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=qOfq2LrWHv0NFkf3Imrpeh7hwJ3iFckwh+n
 tog9hmA4=; b=CWl2NLIpp2IPWe4EylArajHK52jsdE+HEkxmo7sjSMNdz9HxnKQ
 iOrNG92arS0JUYfH1JHYdRGf4yYngjQgaCcqMi3Lz4sUzt5ZVn37DZFDSujYrD4Y
 8rN3+aGnJ5JYSa7K82WcrFptP+S4XdHhc/nh3qDLithdgjzzf5tYQIIjygYm/NJ8
 hr1g4/TUA8omIcmmaihXhhsObCWavWA/3Xp2XN8TIcLieAqK4P0O84gnsWQuoSPL
 ctIHqf7DgCKxGn66A0mqfxAwZ8DWHyBn7gzifDGQd7YmG9QJiB64Zy6Sldl0KOk6
 +l9N3A8Lx7yh+PY+M02PSLL1I9qjbppzbQg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mvfmuvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 11:48:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0f4822f77so106698705ad.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 03:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766404138; x=1767008938; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qOfq2LrWHv0NFkf3Imrpeh7hwJ3iFckwh+ntog9hmA4=;
 b=BCxujRbVQdrB6LPL6LPyfJtnc34OhMPcvvk5oEzg935PbUOg+RpW++oI4jbPqOIgfW
 p84ndK9yU6gu/Uu9KXzNzebtwAQPLOE2UP916UENvwxjAjwb+Q7eFSTfYd4gDcS8ZMm+
 9fJx2eFsQoaYOE1KjsuyndJR+88yxXLKvIq2VrHxkgK/k406TwgkxvU4qUp6gVA54KsV
 2ikhf2wEWugCQ9v/4xHW7JaseVkT5m9l4SbiEBw0rQdkiqDRpss14bbcL2pauVaSLWbE
 xPFAA2Bok5v77SYs4cOus1jMJV1VC6m+qYbnrT/iHBUKFkUEB5BAnTp6KUGKRe12dWK1
 loXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766404138; x=1767008938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOfq2LrWHv0NFkf3Imrpeh7hwJ3iFckwh+ntog9hmA4=;
 b=i8kHHvD72L575JyMDvQsh3di8TSYT9FH/TUIEl+0Z6wewk1uxEykkxPpkfjJra+BUK
 M6sP1XD+rnl5HlXldZEP2diBdsv9seWpfE9F/dSBg1iH0Mw/DiS8HNUYIFr427iDvtBw
 iLFCVwGSgtntU4SXsiHmTfFlfPwTLJcY7Bw6BebY2tApGL4CJmQNiYJigGn+aGYlkXyF
 KnVUUb99xo5j0ntXDot1k0mb13lcJGk2WkVEkQrtENo/E9gmM4jdV5mpdfthv4ym4l4y
 Lf9wEL32L6E08lJsOEjw8JtKzaaCH0c+KxxlpYbaqRikbOm7vyBbFh/DNl6NWcsdepGO
 h5eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBaym648Cpo05aKUREijZUGjOci3770inwdaY/gevn3vr9wkE+2grtDgN5Tth2pNHWtwxvEas=@lists.denx.de
X-Gm-Message-State: AOJu0YxDd95l8RWMGSP3QPeE3Hz6mOjHvQFya8VEtmWBNbXL/UhbmiD9
 mVL9HYO7Eo8sFpQX1k9+ngQGQcNctMo224i1LCLHNr06WpRbRuEqJZpWcdkkPmP6GGXJSW6jD47
 4FKlefsGGaBpklztLT2ENYG1wqRP7y7YCqk/oAAiv5IFXxox7V8vj8kOO
X-Gm-Gg: AY/fxX6LeK1NjE9IgCAILdqy052nj1q1cxHXgzQ35S8tDrVOkHGldBlZ1+6kVuxpU9E
 AhYwd+10IabmrgBojO8Wqm6Qub6lFo6icKXqkRssFlqzDw2LL/JwMkp0XJOF7b+tjfv9nilCSBl
 R4MZtPyVTnFqIcdUGcvvSx3nqg7N8YNyQS2vhqVR9D0YA40SkMC3N+fpufYoIDooBU8cePBag52
 Wmapo1GJ3n99tE3i/I0431PbGaOIfJbbU5NRYKi7Y43nY48nqw6c+bAxsxfS4pk40r/QpDhqomF
 /03Z7efs0Evl1C4Er6zD5mPHSCFpxgRAEXeExNi86tJy6w8Eq4A3JdoSnYT8ieqSJB2tPcLaBNS
 77fj/cpmNsWVGRY7VlUX0XR+PMrYzaU5opRzvIeehjkxygaxsgek0z+g48ztn2csmm6UdVoJQ72
 5SgJq4MQyn3jA/pG2/BRM0KcyyteqF
X-Received: by 2002:a17:902:f710:b0:2a2:f1d4:3b64 with SMTP id
 d9443c01a7336-2a2f232c5ddmr99676815ad.21.1766404137792; 
 Mon, 22 Dec 2025 03:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVOqF9DKPELqyLNShRdp/3SQs4e0dW0qyfqS5YlMBIPyFoE8zwquauLrcUWTzjzm4GlL8tcQ==
X-Received: by 2002:a17:902:f710:b0:2a2:f1d4:3b64 with SMTP id
 d9443c01a7336-2a2f232c5ddmr99676575ad.21.1766404137321; 
 Mon, 22 Dec 2025 03:48:57 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d5d658sm94875935ad.78.2025.12.22.03.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 03:48:56 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v7 0/5] Added QCOM RPMH Power Domain Driver
Date: Mon, 22 Dec 2025 17:18:19 +0530
Message-Id: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H8rWAuYi c=1 sm=1 tr=0 ts=6949302a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=giyyX0tnYtHS4K3SAAUA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kbRgvvQvoeotUP6MMzowU4kERGEvWJ-Y
X-Proofpoint-GUID: kbRgvvQvoeotUP6MMzowU4kERGEvWJ-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwNiBTYWx0ZWRfX39mckpOGUF34
 Uh+4Cx9EiX+jfvakr5hALvThqFtclTfaO0uLrp9MftMpbM+0944tFcA72TfR776rl8hLSQeSp5d
 FGgBOB8BWy/HV3XIT94oyoEC9AvLulfLZWwSbGn+/dfyERX4EGfW49hrwmRngd/fcAaNXaM84Kd
 H8y/Khqnafffs+8zT1BsJTssQVoolzeF7iD6OdoEwPUM/PPHLmF7iF3b1y6ZK/F5EA34zghkqIA
 e3XA8rstilwJD3oXDs3DhnEKR7FmYT18ShBz4E2fmJori6fkP9aiQgIecgiYU42Qg1dqJHMxLeu
 fsHJSzpWFPB717aGDi7J+ZrtLyWTjgFpJK/rG+YWNTUMILiqgtc54LD7vfceiNwLlQDFnrWSk9U
 TWtXVwXESHAjTi4SzQduPtGT30JiwVVCbMigZdNSKryRSZv+OK1+i+gY+r9Q5hyUXOHkjxyEW3R
 sWibOtuvYFd+zF2RBWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220106
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
Changes in v7:
- Droped soc: qcom: cmd-db: Add cmd_db_read_slave_id() & cmd_db_read_aux_data() functions
  patch from previous version, since it was already picked
  Link: https://lore.kernel.org/u-boot/176363183220.2293399.7296647117885059868.b4-ty@linaro.org/
- Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
  when power-domain driver is missing
- Link to v6: https://lore.kernel.org/u-boot/20251113113427.2218045-1-aswin.murugan@oss.qualcomm.com/

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
 drivers/power/domain/power-domain-uclass.c |   7 +
 drivers/power/domain/qcom-rpmhpd.c         | 278 +++++++++++++++++++++
 drivers/soc/qcom/cmd-db.c                  |  45 ++++
 include/soc/qcom/cmd-db.h                  |   2 +
 8 files changed, 342 insertions(+), 31 deletions(-)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

