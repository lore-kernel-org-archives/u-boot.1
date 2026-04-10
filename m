Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B875F36BAA
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 04:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE7783D8A;
	Fri, 10 Apr 2026 06:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwQWD7kz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PSpGzefG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1E6283DC9; Fri, 10 Apr 2026 06:42:12 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98DE839D9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639MJaH02812084
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZAh9iwD5wM0nORBpb8M/kb
 7Dscfg6H4s3Ny0ikIBtY8=; b=gwQWD7kzyEELvIQdJo7vOFamTrbBjdEPBS8JaF
 YKGLnxA3MMlDVSohn7VdRCNrpQV2x+dCi4UQFyhzcR/Fv1m2DQVOlKPbFhXoMuCr
 qSRbOFF5wjj3EtQalPZ0Oyv4tt2h3Csk8AXM55VJHn/Mb09CPEEa8GLi3SX/Jt9s
 tvr770szjz64gKHmBnIbUQ4ecq2nO9Q+K5aLuQDh+OsrdrzhRuMktZAUpJx1gnoW
 JVkeDW2MOW0gxcWSBVxtkIIC7m/vubEQ9NtzP7Q40smn66zQMlLuA6JRQ6w++K8C
 e3w8PMWg9N+GASFfuUwT31u0IKaxb70h66rnluVjCmUZvJVA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded6hahc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 04:42:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82ce1c395ccso1834418b3a.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 21:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775796128; x=1776400928; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAh9iwD5wM0nORBpb8M/kb7Dscfg6H4s3Ny0ikIBtY8=;
 b=PSpGzefGeezOZ0dqVdmDhCOm5ECSIac+kDzA5MbMbZUdldx9rNXxgPv2OWEgKKc7Rv
 VEb3qr5M6Y54V1bWLGdyG6bptDNrI07Qvsq+i751iHCSQ4HqbrElxOssB271LULSbi5Y
 qgpzOx/zl/oAy3OG390iYN58Fwf0TF+fB5Ju0WSQQMRODhM3BX7VarD1RBkNeQIAJF2x
 jmGc2t7bhon8TxakNZIwWU4k40mhOWlKd7+P+PMWCVrJlwIFh+XsBLJhJqOciMV3p5ep
 njisIky1X4i640xYOtBSewg3H8hd+LWnOqSDhAiTP9fAakPt+TDPyLyIca4OjGH4mD9A
 v0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775796128; x=1776400928;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZAh9iwD5wM0nORBpb8M/kb7Dscfg6H4s3Ny0ikIBtY8=;
 b=Tj8WDmFscKGwtao+lJlW32rSfRb7OqwJQWIeikzhvmHQfaQcbHZndo9lircIUAqewi
 9OOFjk1wSfgNcyx2wqlnXV3oT160RwfJwE3ucj7vQEypfu6j1/u4D8DCUFqfy4o1qlQc
 6QiQWRqul2+6Suw4AnfgRAKQcDFAM5udxMOuMQX4EeXOZ7iAAz5iTez2Gb3OIZ1tyRHI
 NForkfTTM+7s1lruqZ4ix5p9Geg99KMnjqicKccOpMQjrO+EzbWUbetiK8CCtaH5wVyp
 JL+2nQMrxAC2QsGIVCXUoIgYPPvXrmA+xOWaC3eq3RqMatV+8JffddOJAwvzXM+yvsqH
 3U1Q==
X-Gm-Message-State: AOJu0YwX1//nQ7ZYlDq7TDrHOYal3goAACBGvJslLlLUMHkegZ3tuAM0
 bD/qWLhSAo9ahcMzd8BZWU1OuDHx5DmCsmXa8Ql+delrv+EmUpZHgy/gbop/Qte3/XxgjqzFwn8
 Yf+UMB1mc44MXdon97hmz6ygL+L0Z/ujXOFdZS8q9Hsxn7svOqy27NBJi
X-Gm-Gg: AeBDieu/b/NxaVGgWU5F7SRKhxPlC4vB7347H5VIpxeyvy5TayUXJgRXf3L/Bo+E3Wo
 GWSeF3El4JykE7YmMWzVRYv5cblnRgOPoFjekS2TL6JTGa68H/sddhOusoEAI2E9mm5bOcJK/PV
 UDqhWHFzDGA9sV/wNQyiB6f0TWjkcvfuEDsq44fOacPGZCQdTVf7K1Wxn0GDcWPZ9SvpfOWqJvP
 tJnV8vy+0RT5hIaAhh9bwb/xpTBmqQJcsL/UQixIdvsV59eQSfo+WUvRbnxQ+GD0UG5h4ptbn/M
 vQpL8TOOeEKP0LbizLe3zZgO25D9jQRncpJk+/rBIhmcgQwkGeLket01aHNmND7YbJ+9pz4SL3I
 AYoz5m2/86wDZuhHjz9LMs1v3OyKUbfO8DZPZA7qMnAmuJA16z2XpDo40TO4VGfuiWUM1U9pIDD
 x26TDHPB0YmjeFRwUwZhWacrKBpkiAV0g1EWrjNv84DNXuuScbpg==
X-Received: by 2002:a05:6a00:c8c:b0:82c:f877:3d13 with SMTP id
 d2e1a72fcca58-82f0c2a45f2mr2097012b3a.26.1775796127852; 
 Thu, 09 Apr 2026 21:42:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:c8c:b0:82c:f877:3d13 with SMTP id
 d2e1a72fcca58-82f0c2a45f2mr2096988b3a.26.1775796127362; 
 Thu, 09 Apr 2026 21:42:07 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c4b3b29sm1198815b3a.36.2026.04.09.21.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 21:42:06 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH 0/2] fastboot: block: Add GPT/MBR and device selection
Date: Fri, 10 Apr 2026 10:11:59 +0530
Message-Id: <20260410-fb_block-v1-0-68f0c976fe0e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJd/2GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0MD3bSk+KSc/ORsXUOTNEuDZPMUsyRjcyWg8oKi1LTMCrBR0bG1tQC
 dn2GDWgAAAA==
X-Change-ID: 20260410-fb_block-14f90c7d6b37
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775796123; l=1004;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=0Jw4DDrQX6u1I7Y1DohH97hMJzbIiTCm3qDxx77o6Z0=;
 b=HZFY0EJzuc607L1KE4cTM9OxqwrEl11sGhnBLZ7p837uUKl4/p1W2xMCcdrEnAKCimxcv5Qyl
 wQ1CBBWSn1dB99DafCDcwmrpwqSIXuxVmeWKhae4xMwm5k/Jx1ki7fm
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=RfCgzVtv c=1 sm=1 tr=0 ts=69d87fa0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=O6W46WlA9UtPJepPt1kA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: Jgw-RQvr7lS2ymFRiDQYdUr_-sbuAf4q
X-Proofpoint-ORIG-GUID: Jgw-RQvr7lS2ymFRiDQYdUr_-sbuAf4q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA0MCBTYWx0ZWRfX3vxBcPhA++TQ
 4JotmSjyctusLZVW5ELrtbuUHJSOHizv1l/6W0bgvGupkyNNBZU0LULpEMZwbL7nEndr6gJDUCr
 kOCgwTvCQ+do8njd0XW+IxAVQD0JvC5LmeTb2DRhDuQANrAmvmVKiy0rH5yZFqp/3yAgULdhCBK
 QyTKdj2GCbQrQIzM6/VvzhfS9N9BWVqiRtYJP0lzNMWv13xcwba6jgyCAb9ZFxvTCu0xeWQlX2+
 uSQHs8sS2qqu3nvf3+qR9fQKTYzK0FxD6nYYr9l9+Vqr+sGqsGvTL6eFF3LkOKa0CeI84fTLm/X
 F8b27AMj5UIob3Fo7b+OK/VBLgSX/HkLYqUoqHcoqFkhtcx2UuPmwldSiZ9hNeOEFR3jyeNTlo+
 /dooq3Zi0AsJvo0mqwkPHLdkyVd+WFjxC3ULTXzocVH25FJtx9EY7LkrNHRqQyj9D1tgZ4ReeVY
 JoxQxJdohc5PSuG6jWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100040
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

This series enables GPT and MBR partition table operations for
fastboot block devices and introduces device selection syntax.

Patch 1 implements "N:partition" format to target specific block
devices (e.g., "fastboot flash 0:gpt gpt.img") and adds helper
functions to improve code maintainability.

Patch 2 documents the new syntax with usage examples.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Balaji Selvanathan (2):
      fastboot: block: Add GPT/MBR support and device selection syntax
      doc: fastboot: Document block device selection syntax

 doc/android/fastboot.rst    |  41 +++++++++
 drivers/fastboot/Kconfig    |   4 +-
 drivers/fastboot/fb_block.c | 196 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 227 insertions(+), 14 deletions(-)
---
base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
change-id: 20260410-fb_block-14f90c7d6b37

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

