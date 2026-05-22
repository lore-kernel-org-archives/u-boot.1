Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBB0CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE168404D;
	Fri, 22 May 2026 08:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgJ1YsA1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YFIn2khO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37EA841D7; Fri, 22 May 2026 08:09:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5759B83FF5
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M41mP43005135
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Rp7b+myXtXEgzomohdEqOO
 tyOBcSu7Hezk8f4hxlXts=; b=NgJ1YsA1qNPpqXRuVMzy4rc2bJ6QjQJLitIh+o
 k/WudPX4FG6SgksY0NMgxIKwwbVaPT9LjWikkuQjH64+TvBgawUck9NhPhCouDJR
 l0L7ttlRqhTaEdpUes6eCgVjmmtrpbqhNiLns0wD1DNhPoq1HnTSXEZCtXpvQQea
 O5Sy/D0fOWIz6grQitUtK8CacDUfOvmSQv2KbjrNjfuO8qQ90SchglcI4EHhYwmK
 EpRfXTc9JXgB1LLBwG2rzQel4vGBKHfISAU0V66QnptDVZJcFSBZvZNjXhyC18ES
 f6Nb2Bob9b1f93Ekc0aClBGEZtwkTvpeTMk0C0g9YdkXGR8Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrt8bqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 06:09:37 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c82bd90afbbso3631547a12.0
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779430176; x=1780034976; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rp7b+myXtXEgzomohdEqOOtyOBcSu7Hezk8f4hxlXts=;
 b=YFIn2khOMSYy+BeYV1Zjp5W2H3DmpRea2kDbjbPIOUIdimkHwm3L681pfSxpqWf9x9
 4jYUHMCkpCKkRMAc53BHCp5jTL1CpncwT6gaJnmfSFWoeLMVwCx0G3RTYoNvvCVd11e1
 Quki5phnTMt3yndxWjJoMfnIddAqUS7QOUhGF1P0JC4XvnvA61BVqf2VA6oA9zss9GHV
 HWpHegFESb/rwLpHtknc+bkEIYVmj0wgr220Oi0Ht5qkWnmYMAQZiWnLhB9x6+HtP9cO
 dOJpyY1SLFlxKek9QFLG5/GayzOVT6xnlRgTibxx0B0z+Hs/lfBB3phcqWQ1ihxbaakd
 NOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430176; x=1780034976;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rp7b+myXtXEgzomohdEqOOtyOBcSu7Hezk8f4hxlXts=;
 b=ADGXXznysIor9CC4Absk5VbWJnsIN+1Sq1GMIHc1GZyHzqplxFD4iN6FBxxLJKtxlJ
 5WIpK9kcJXFOa59HeYP/JVV3bkKr6RsCCu5QM40QBGECD4aDVkSqB7gjHcD7aHGW4kby
 3S4kk1Qy+uYfMpitqHF8isqpyd0O1e6clCAJHsucg1D/97CzDPdorgx358nvrWzQtET+
 YvjnaI6WNSYUZenqkZTYF+T5ibGCmYTQE1lBJU/Jp+IXRarza0ZIVwYgSZM0im4Xncqw
 ohGzJkAkIjFixaxKSBHGMflDV2/7Tg6V6gm8s7qBs/mI3m5N0HVi/NwUAPGxdim0cP9K
 Fsiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KGDJnL6ul1FFuAR/Z9Ov9aZ0p8sSyiPNuVcAEPRChFQhFX5AQmSTcEFc4N9ss3RMxnxPKHT4=@lists.denx.de
X-Gm-Message-State: AOJu0YwENmLwfn93g6knNP3U/KuvI5U5tFjnmatWnpBby1Bgm53vqFfV
 vxc0tVw61sJjzq65bOPIgy9NHyivtuwrn2ETcnPZG2F6pd+rAX7VFqWUL2Pr/g84QiEj8eng1fF
 guYNlPxvCXJpySGiiMMrmncTiwgbJPR/O4P1t+XGzbk0PS7DumzAAKHoR
X-Gm-Gg: Acq92OF1vKXKzUir3abD4LrgFG5ypuPq3rNNxtsrSj9NQbsrN6ifLNEcHE/hwaXRynh
 wqfskZksUnkXdJztvp8qa4P4HLijyQenk1myJcvqfDvZYWzTGSm1CM8yLsAdIiDoDomxAIhkgvU
 Yllw6YkjRfGxN/mGnZWI021G0HfNICU2WpvNLyErFeUzI4A3jDr/Ksc8dmLKadU1x9hFESe/wHQ
 1b3rSpYu0dz111am7HJLLgQ0KqwCJ1BokBOhZS8Vjuqu6thTgYiebC3mJTRVnq0pBlrlWok1+Pl
 37tdMH7/JQnGD4sSceAerxcrI/0SY0L3ZLrOye1p8g4dJqdKXKHfCwERxHdXnqUp+Zy2PdBYWbh
 OBzCLzzaUg7+679Wq2ofIutgcpDGKluclYAYY+6QUPl5qRHdCwEx51r1bIwEbYLdDJGKQqMEJsL
 IzR31S0h/9Dynnc17Uw9VoO/UsMx1Y4bThUX06F+mR4Lzx9FJK6Q==
X-Received: by 2002:a05:6a00:1407:b0:838:c01a:7a50 with SMTP id
 d2e1a72fcca58-8415f406e6emr2319665b3a.30.1779430176516; 
 Thu, 21 May 2026 23:09:36 -0700 (PDT)
X-Received: by 2002:a05:6a00:1407:b0:838:c01a:7a50 with SMTP id
 d2e1a72fcca58-8415f406e6emr2319615b3a.30.1779430176003; 
 Thu, 21 May 2026 23:09:36 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164afe338sm807951b3a.18.2026.05.21.23.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:09:35 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/7] qcom: Add FIT capsule support with multi-partition updates
Date: Fri, 22 May 2026 11:39:28 +0530
Message-Id: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABjzD2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyMj3eTEguLSnFRdS4NEM8NkC5O0tCQLJaDqgqLUtMwKsEnRsbW1AKs
 Jd0tZAAAA
X-Change-ID: 20260522-capsule-90a61c84ffb8
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779430171; l=2727;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=ojyEHT5wJ621krI3+s8ydxJuIsepRlg7gLgVFoZkDbU=;
 b=82Y8eVDwYISgxwhc0TvwCMnd0ZHBDsuyuPdqCB/f6HvybsH0jraoSMpj2DLwXG4VM2s1sl2n8
 5ABNvIBiA9ZC82LSJ5Pi4J1pgUZHpjI1XP0oY90rMin/bnVIJWOrnlP
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a0ff321 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2RDLD3G19U3dJ__hupEA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfX4cspjWW/W7MS
 RCm9d64drw1dzfRuhRG9e8J6wusN8y26dCiSdCK8rZ+tMsaP+Z4Ryq7Mh69AlEMgK4LRHWkr9UO
 iyp4K+icLfUTwkUtO+zhu89dIrYiBE1hzOuD1JzdmGrJ5iJk9FQxa+yB23n3gwNxAwa++EDjmQ5
 ytcYLo5EGbiLv3f2Ha4N/BWliEjlf7P/vkPDflkuk42BZHdFaQwmvDV/NvRXqw85pDCKwRSe9uG
 MbuTaijVBvgcDpSSVwQuDvsj9scpIafxacWo7QTdkfF1PkIzjYZjymazzEnAsFNGlHnGvPp1zqD
 ElCWSafv3fbpcJjlF9a7YQbypAPFzSYkib0hj2Jv9OIroXRiT/bLv4HIsDwS/DBXftO4zXHLu7l
 1sqIh82toihCWdOWudYxCdOe0sKSGo6WtZqJXUh3LV83hMx/STjKI+HEzoipColQxAesw6Qukrd
 8WQp7DbUajwN8uKhfcw==
X-Proofpoint-GUID: 6BWzOvuckA2OqDbXpSS0aFGD2LQPenk_
X-Proofpoint-ORIG-GUID: 6BWzOvuckA2OqDbXpSS0aFGD2LQPenk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220059
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

This patch series introduces FIT-based capsule updates alongside the
existing RAW capsule implementation, enabling atomic multi-partition
firmware updates. The implementation automatically discovers all
partitions across SCSI/UFS and eMMC devices, applies A/B slot
selection based on GPT vendor attributes, and generates a single
ESRT entry representing all partitions for simplified management.

The series also improves ESRT reporting by tracking last attempt status
for both FIT and RAW capsules.

Patch 1 adds the core FIT capsule infrastructure with comprehensive
partition discovery, A/B selection logic, and multi-partition DFU
string generation for both UFS and eMMC storage.

Patch 2 implements last attempt status tracking for FIT capsules,
enabling proper ESRT reporting with version and status information.

Patch 3 extends last attempt tracking to RAW capsules for consistent
ESRT behavior across both capsule types.

Patch 4 ensures firmware version extraction even when capsule
authentication fails, improving error reporting accuracy.

Patch 5 switches the default Qualcomm configuration from RAW to FIT
capsule support.

Patch 6 provides fvupdate_to_fit.py, a Python tool for end-to-end
conversion from XML files to deployable capsules,
with support for board-specific GUIDs, versioning, and signing.

Patch 7 adds comprehensive documentation and example XML files for
the conversion tool.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (7):
      qcom: capsule: add FIT capsule support with multi-partition
      efi_loader: firmware: track last attempt status for ESRT reporting
      efi_loader: firmware: add last attempt tracking for RAW capsules
      efi_loader: Extract FW version even on authentication failure
      configs: qcom: enable FIT capsule support by default
      tools: add fvupdate_to_fit.py for FIT capsule generation
      doc: add fvupdate_to_fit.py documentation and example XML

 arch/arm/mach-snapdragon/capsule_update.c        | 740 +++++++++++++++++++++--
 arch/arm/mach-snapdragon/qcom-priv.h             |  23 +
 configs/qcom_defconfig                           |   2 +-
 doc/develop/fvupdate_to_fit.rst                  | 487 +++++++++++++++
 doc/develop/fvupdate_to_fit/example_FvUpdate.xml |  43 ++
 lib/efi_loader/efi_firmware.c                    | 176 +++++-
 tools/fvupdate_to_fit.py                         | 605 ++++++++++++++++++
 7 files changed, 2006 insertions(+), 70 deletions(-)
---
base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
change-id: 20260522-capsule-90a61c84ffb8

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

