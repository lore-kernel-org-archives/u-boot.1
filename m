Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA24CAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 08:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD27683700;
	Fri,  3 Oct 2025 10:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EI5J3/j+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD018349B; Fri,  3 Oct 2025 10:56:30 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5E33836A7
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 10:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso13538855e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 01:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759481787; x=1760086587; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CHaEyj5ZxAx0xhgzhUCCce+S0OVk02PQC2/NtelcOH0=;
 b=EI5J3/j+l8FCuphMW3k90qoucijw9DW4IeK9BivmmhMRVnhuTIOpPTbCuESlOrfsdW
 7/uGI02RDPqMeb3nasbCexR0683QT5RshLyZ/mxYTC7ikeauc35vvga6QqWV4HCg7+hX
 Slh9rDXYUxf7xcDwWpSsIK1VQux+hKE84kFKXQJUs1KtwB3nBng2KuNRwEVlqBiBHlpf
 a0jgfERoUcT0U1VgdKZI/+MTKhmCuKwP/An/K0OTv/tsq8QfC0f4q82b6MPdxVgWhMc6
 q8AGapbfH4yaay3kHjxqnZ4BnQRlxKc9a4zrwi9xaSTkuzWNlSkw5m5genYMHLKhFzzq
 UCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759481787; x=1760086587;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CHaEyj5ZxAx0xhgzhUCCce+S0OVk02PQC2/NtelcOH0=;
 b=WkIr/22lWYFxSkEidoeHOIwfRUK+UjXzzmFdAZnc+Og7tOpx/1Qvp5Xmr+8PtmY++D
 dtyJmftbFsdLSK2SXe+Dsemncn8zabAJ4rqxPscPj5lQeHNjnK0n4iiP/0au/w6pB5NH
 llwRn4/1EHSfDgBV6AbRgWGvmdrKqqxmFvNSHbrD7qr4VjoxvQDeDAntrURWSaJneUSp
 ydCx7tTv3r1Y2X9B3udtfY458ApkNMqEwFAp+mPNiwQZQo13cUAmxJ+NjFtkMwQMuz6s
 7Jmcg01VSJS//s9NVQrXzpo8xslSjcwC9ooYgkoXilpb8awG5mmNZGjEKEkkFaznGUkt
 c+uA==
X-Gm-Message-State: AOJu0YzC0cqNJCvQbf3loHawN55H940398q9HsnHk0KgyYIT0DP/n8YL
 isZznUoyklTECDxFBzPTf1X3BOXmH2NBqoBYRVYKvM1MHYy/Rg3iq+cW9SHGPNRnx3E=
X-Gm-Gg: ASbGncsxIx/+lYuP57lTn3Gi0Msr94yobTyMu2zAT7HgTBwFZZ13uhwZiQFplMLn8IU
 VQ4T0qvL7UrDgRtKPQWvBioeqgJ51x40tKnhXjafv7jm2qhKDY9QpKl/unEk+HnzQb2vzl1b3IW
 s0A9/iIVaEL9sH9pFAkAQ8q8LBUHZCimJYeEOKewv6Gmoo1Sq1I+nCmjM8uO/robpPjVK076cAX
 uzXHh9VjqU4XNcXdZcNtP4O2WPfK1HztSPy0oneFh4zKAB3LfRo3tIYuFAN2LsgeRd00HkIiP9O
 b3GJT8BP0sJu81K6JbZrA0kQzN98XhyvN8YKgpq6+xdkj8AevxA0wNoo6TNjy0Fo9C80ejM1rim
 XT8irpKSyL2W7DoWCD/GeyW0hVYMBBvKVTJQdheX8uJOTaqIHhnvlXe/YkMTp6/r0X9z3apU=
X-Google-Smtp-Source: AGHT+IH3Mowd4AXqFufso3ZzV6CcYU5i97uJL/jgNT0cq/mJFzC6gVqqrPN/EUc3BNXFCA+45xPQqg==
X-Received: by 2002:a05:600d:7:b0:46e:4329:a4d1 with SMTP id
 5b1f17b1804b1-46e711040a0mr11480135e9.4.1759481787169; 
 Fri, 03 Oct 2025 01:56:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm6951709f8f.41.2025.10.03.01.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 01:56:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH RFC 0/6] Introduce the Interconnect Subsystem
Date: Fri, 03 Oct 2025 10:56:20 +0200
Message-Id: <20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALSP32gC/x3MQQqDMBBG4avIrDuQaKXgttADdCsuZPxbZzORJ
 EhAvLvB5bd476CEqEg0NAdF7Jo0WIV/NCTrbH+wLtXUurb3znWcw6bCahlRghkks6FkfmJ59TN
 EnBeq9Rbx03KfR/p+3jSd5wV7pW0xbgAAAA==
X-Change-ID: 20251003-topic-interconnect-next-4ed75aecc01c
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8doHHopg1fTnDFEWVK8J1IlHEa3E8CjcSdHjRHQ3654=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo34+3Tm+OncNQA2WRjzIpOjFbkbZgQ3AGCwMnwGkc
 7ZcKqfOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaN+PtwAKCRB33NvayMhJ0X4CD/
 0TX55/W0OoLmvWHCbTTPC9x8wucRbNHF5buRDCiAGTuTF8CMTK/d+eRWw14xAUAWEHc7tg7u6MdYso
 0MlITUF2Q8Pl+CCUQ692wUjxJwYtlTf996PpkDwdkQsx1Icoj1MHcnMniAxEYeFhtaXONKvsSHuEMb
 nvbbDBydHaEC7CCJEBWf9XPJpQ12BkyvYskh0KabURqIYUVJE+y19GCGb1n7RyqJ0rLdJGiBd3PFTP
 +Y6yZD1nf5nujO7YoZYK3sGNWbFjxNXgXOLJtOZBSF0ZLiEf+KTocH5BNxb/O3wwIGBO6Mihud8v0K
 tjmDtC7d3hI0qMf5JzvjsDRwhrEM6CtHhdj/Cbiy/VX1OWYI8VOkua2cRVubu3MyAeVq/naFf34G5s
 LqxStYn8Y7yNGCgUfLRCv9KYSbMRvR4+L5sQClt2tMwpgzjG/9zQV2u35iXu7cY7G03VdtD3Yiccqv
 TwGjCXjoRCaDWT50MdNeWvE61VTiorc1PsAOZutCyy1yPKfFLssQXdhsYKSR0cbEe9MAAQ3h5yy0lw
 C2YVfWHwj7MStmHoS0Yo+wL2hwq9mL8lW1o165OaAukH1ddqmezbW2qvh5boV8xNVQm0slE241aGuS
 lcbR5E7sUDDJZO44gPYM1fjUG4RCCiGKy9vjJXNI8MvKABauGFbHmuNZmKDA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Let's introduce the Interconnect subsystem based on the Linux framework
which is used to vote for bandwidth across multiple SoC busses.

Each bus endpoints are materialized as "nodes" wich are linked together,
and the DT will specify a pair of nodes to enable and set a bandwidth
on the route betweeen those endpoints.

The hardware resources that provide those nodes and provides the way
to vote for the bandwidth are called "providers".

The Interconnect uclass code is heavily based on the Linux one, with
some small differences:
- nodes are allocated as udevices instead of Linux idr_alloc()
- tag management is minimal, only normal xlate is supported
- dynamic IDs is not implemented
- getting nodes states at probe is not implemented
- providers are probed on demand while the nodes links are traversed

DM Testsuite is missing, will be added soon.

This is an RFC to make sure I'm correctly using the DM infrastructure,
since it's my first uclass implementation I would like some feedbacks.

Qcom implementation depends on:
- https://lore.kernel.org/all/20250711143851.1490617-2-aswin.murugan@oss.qualcomm.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (6):
      Introduce Interconnect Subsystem
      MAINTAINERS: add myself as Maintainer of Interconnect
      interconnect: add support for the Qualcomm RPMh helpers
      interconnect: add support for the SM8650 SoC
      ufs: qcom: vote for interconnect bandwidth on probe
      qcom_defconfig: enable interconnect for SM8650

 MAINTAINERS                                |    8 +
 configs/qcom_defconfig                     |    3 +
 drivers/Kconfig                            |    2 +
 drivers/Makefile                           |    1 +
 drivers/interconnect/Kconfig               |   16 +
 drivers/interconnect/Makefile              |    7 +
 drivers/interconnect/interconnect-uclass.c |  560 ++++++++++
 drivers/interconnect/qcom/Kconfig          |   12 +
 drivers/interconnect/qcom/Makefile         |    7 +
 drivers/interconnect/qcom/bcm-voter.c      |  340 ++++++
 drivers/interconnect/qcom/bcm-voter.h      |   19 +
 drivers/interconnect/qcom/icc-rpmh.c       |  226 ++++
 drivers/interconnect/qcom/icc-rpmh.h       |  128 +++
 drivers/interconnect/qcom/sm8650.c         | 1662 ++++++++++++++++++++++++++++
 drivers/interconnect/qcom/sm8650.h         |  144 +++
 drivers/ufs/ufs-qcom.c                     |   13 +
 include/dm/uclass-id.h                     |    2 +
 include/interconnect-uclass.h              |   77 ++
 include/interconnect.h                     |   80 ++
 19 files changed, 3307 insertions(+)
---
base-commit: 5f04cd73e8051849fb495c001bfb4adc2fc544e6
change-id: 20251003-topic-interconnect-next-4ed75aecc01c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

