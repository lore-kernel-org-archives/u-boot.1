Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E55EDF150
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2096180FA1;
	Fri, 13 Feb 2026 12:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZL5YqNsP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O6HImHdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D4DC83AAB; Fri, 13 Feb 2026 12:10:54 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A469980B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7p4aE1641984
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/uoVK+VfqtljPUJ9VAJhV5ArhKF6XZPEpeU
 MQLlzDfg=; b=ZL5YqNsPShNPhYvHmN7rpDf0xfjRgJnHq1zHa0uCdcIQgSCVfzC
 083nrvXuEw0zqaIuVELEsXt0JTgp2ucekjmsGBUmdmFYBYkMDiQkNnbIPXirdCDd
 /G2MbHwZakBDo3BVhLfRR5uv7QqvUpag1pMRD8Ifto9oQMDArS0eMgam0s8hfqbA
 eBU04S9k3zvXW96u8sBKFgBd/L5PmummKUWTd8oYuIkmIwzIZjh6Zw7W3CECduVd
 8SSLoDuPIyBcG/X5XnBkcK1coc91MFJSrokJNeRaVBXxAKuLlXOQ0gIDBlXPfa/X
 PVkFy+qloL+nYgdXdy5vkvbBgW+16zmNNtA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ptv2hhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:10:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35449510446so798175a91.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770981049; x=1771585849; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/uoVK+VfqtljPUJ9VAJhV5ArhKF6XZPEpeUMQLlzDfg=;
 b=O6HImHdQCTpZ4+Ldwmpxt5L6Q6l5LvdwTDXvbKKOnDuVd6WSGxoUETYNmMpoudSzjG
 kmfRjOqbNcyBMUKm9pGQBK8OF8QdwGxu9q9aEUShMcHphxj1KlzWVFvlWz8e0txWcqTq
 AQOLtrKyiS1UfluoTbmev8X3N6MmH5bsyMCTOM9Krs3ToDa2Hg3uXVdASE8lbhJauhbz
 3yckH0WNusYWslNwNAmiwIQOabgVdtFVLTJ/aZeu1vfpFLc0VIc0GI6o1uldEKIZyacN
 pYsAdht50yuJn29YRk/SPHRhLnKZB3SbynDopVQu3c09SM5waMWoTTqyMsVo7ori623v
 XZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770981049; x=1771585849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uoVK+VfqtljPUJ9VAJhV5ArhKF6XZPEpeUMQLlzDfg=;
 b=IJ78GHeapf+v5JS1r9WZYR97+WfztOXMpklKEvkeR+fl07a1C1ENLLKWdCVQPiCqnN
 SWbS5+q9fil+gIl6T9V0zimrUtHmqfvvjQ/djEEh3XLuzC9AChFpQ1T0Zl5vLeqwilUj
 VEHIuM28wvk9FB3aMB7nMyyVdhLtfrizQ9e8gpO5Zgd4FtT5UEj6f9sYP5Y6MXfuBJom
 PDGAUqT4NwJxf6m451mLmDeiNn1rzg2pmH2dkF5U8jLhPc7vZPvcG3E5f9GMpD9m7Y8C
 IsHilTkpUr4HODLCUaD33s42KzGt4HFNBE5Vmvp5fxpaGluciyqa9tDvOVBZo5/DO1vr
 I+Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhTFt8krRvJj3oqTlT07fxhrm3uKphqQVXG4JJnUUzFILL9Yd4MZpk0Rmd9cXsKfZ0+nTxjy8=@lists.denx.de
X-Gm-Message-State: AOJu0YxHtiudrNtvW5ckcYp5fDRlyWqToYlzB67D41eWivrj6rnBo7bS
 iZ+aHs5s9nIUYflUJbNZLnU7tH54cyjOZPhC490uBm9jqhgBBjtn7iJmsQu3ZEDvOvKQfbk2pnC
 zRaRogCXGFjw5oOJ496Tma4kKyq3T6TgnafxmB7Jcz2NNM2bMTeUUB4Qa
X-Gm-Gg: AZuq6aJvQy5GTchOFP87djdXGegj6uxiuSYGZbO9aZv4WIbwn23upSjhaBa8V22Qq+H
 yNSTgSuxNlc0sCsrpyAKTVbS+8t5AgEDqPNNq9Sit2ZN6tCROqicf4hYtwNhuVoAmluv/LKfhC2
 6zHnK7twaAGoq9OuPXvhaelz9Y2G0Vo7mpmMowcuRLfnjVz4uAIPxP8CP7oM8NQv2sH+vxpcZUu
 IhoaUw36OO66B+M+fqbS6WkOpZkVOpmwI0OVQK/jBZtaVWcfSzIAyyFosZ4AdqP8mUQnwo5bU5H
 tlqHA/zA6axvNLt1L13WC6kzXXic8syp5GLS5u4aBnNo+shJo2wMtkIiHfYg4h6japnzoRqzmeW
 J3AI7EHYzTu2a6/Vq61FVkUzG6E0Dcf3AZ7vM1n53e52hI6mokNQJbZX947hEGZ64HstkH17Lqr
 QDL8pJmITDq/at14g5BI/4N1bfUl8RwmkSEcS9brI2
X-Received: by 2002:a17:90b:586f:b0:356:83b2:539b with SMTP id
 98e67ed59e1d1-356aada8a35mr1458025a91.32.1770981048490; 
 Fri, 13 Feb 2026 03:10:48 -0800 (PST)
X-Received: by 2002:a17:90b:586f:b0:356:83b2:539b with SMTP id
 98e67ed59e1d1-356aada8a35mr1457995a91.32.1770981047997; 
 Fri, 13 Feb 2026 03:10:47 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662f8cc57sm12364399a91.13.2026.02.13.03.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:10:47 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com,
 peng.fan@nxp.com, neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com, balaji.selvanathan@oss.qualcomm.com,
 w.egorov@phytec.de, varadarajan.narayanan@oss.qualcomm.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v8 0/4] Add QCOM RPMH Power Domain Driver Support
Date: Fri, 13 Feb 2026 16:40:05 +0530
Message-Id: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8LxLdcRfZ2z21Vg30NwbWgeLq6LXcWYp
X-Authority-Analysis: v=2.4 cv=eaowvrEH c=1 sm=1 tr=0 ts=698f06b9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=giyyX0tnYtHS4K3SAAUA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NiBTYWx0ZWRfXybTgGydycDLQ
 oXSODczZ1CAe/TWlbtNzuLULNWPfvDOrWe9jp/G01+LFRtrzEhfDccJrPoMOPYydXFr2zTQ4ewG
 TmbAdf1hZodCJIgmk70pORWUGFwqOG/LdtoT+B+674JNENFuvjWVRMs5aLcFlpQvV/oSAZwKLLm
 PCJzfxwSAve5oZtbrtEmp78bZWOW6VOKstunSuKmFNmP58g9xv2HiCktAj+SUI3g4LeDF5MwtoG
 NOhNwMYF8FzotOj3jVLMtwrbzl00aXCo35j/xKimX5vVt7tAth9L6y258DlWoDAWTD5likR+q9/
 85V5i1PcnMPoqt5/nYYUkjLSwJOU4n/fVve8IjWUtGrepFT9vU+nrK5MQQbePhEeKCIVIrMf78z
 RWvk58NJEqfuEzt1B/7+vi2Jc0L6Y4c2W3euAOOPIrKOub5NzSB8wwPSkqf7azz9Rznt2y8I6vE
 A5zQFXpkvfjRiUcfQvA==
X-Proofpoint-ORIG-GUID: 8LxLdcRfZ2z21Vg30NwbWgeLq6LXcWYp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130086
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

When a suitable power domain driver is not found for the power-controller
node, it will be handled with a warning in dev_power_domain_ctrl() and
execution continues without breaking, ensuring compatibility across
different RPMH platforms.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v8:
- Renamed Kconfig option from QCOM_POWER_DOMAIN to QCOM_RPMH_POWER_DOMAIN
  for better specificity as requested in review feedback
- Improved commit message for patch 3 as requested in review feedback
- Link to v7: https://lore.kernel.org/u-boot/20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com/

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

Aswin Murugan (3):
  power-domain: Add warning when power-domain driver is missing
  mach-snapdragon: Remove RPMH power domain DT fixup code
  qcom_defconfig: Add QCOM_RPMH_POWER_DOMAIN config

Balaji Selvanathan (1):
  power-domain: Add QCOM RPMH Power Domain Driver Support

 arch/arm/mach-snapdragon/of_fixup.c        |  31 ---
 configs/qcom_defconfig                     |   1 +
 drivers/power/domain/Kconfig               |   8 +
 drivers/power/domain/Makefile              |   1 +
 drivers/power/domain/power-domain-uclass.c |   7 +
 drivers/power/domain/qcom-rpmhpd.c         | 278 +++++++++++++++++++++
 6 files changed, 295 insertions(+), 31 deletions(-)
 create mode 100644 drivers/power/domain/qcom-rpmhpd.c

-- 
2.34.1

