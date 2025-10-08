Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F4CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 15:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9430483A61;
	Wed,  8 Oct 2025 17:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zMLsBDD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AE228407D; Wed,  8 Oct 2025 17:31:38 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0ACB83A5C
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 17:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so79151f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759937495; x=1760542295; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5uzVKW03DsDVFFqJTQ4fNUsHQIuGv4lR8NoRbxjCnI4=;
 b=zMLsBDD4rjKRrITXyGQ+cZgj2alAg+INxQzNwr1kyj9jiVknYKTTr9pNsoIiknKty3
 ory95ONbWLT+eNaKRQIaBq7p1JTuFNSk2gYTezMz7D6Zfhfa4Z5f4Fhb6K9KXjqj096J
 P+TxRcE8S5QCrJOinnJ+bMQxFyjFj8EQ+eUXNT222/XGCIhbT6Xe9YQES2Dq+YKVyWnj
 YFdxqwOLpwhaZ74weeNGIRI64wYb7m9E6T5GeHyiSd3M/9Rg2mJLjs1eQqZsfOU9UrAb
 fU/LdZO7zlGWDhGdfl7LeiNEVNS04qSYhcIWPpjT3sZXKmDPrmaCtrvPCqNCGvMa2msF
 QN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759937495; x=1760542295;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5uzVKW03DsDVFFqJTQ4fNUsHQIuGv4lR8NoRbxjCnI4=;
 b=E1q2Q2YdREPuS8g1diQoHUNWYsihr2Mfhvilb7MN7JgegrRlNfBZmWDlSxMOkUyu6N
 ZmNyeKdgLfKEtBNc3UY43DtyKvU5yCFVpyIIPV6qwSnWBETSOhSA4gh+GMwQGi9Q7uNe
 FEYXorIHtwbEq6S3x1H1X4rUd2EAzL7guCNO743J3/cJq0Dp5MabqJmnWTVRZc6X20cP
 RkBPavLru0/WFuCJT149pAllYLZbAyMwUAXBt5vWvTsNXlJwMQgKjkHO4rI6/GMCkRAh
 9Yx2cro73HJv2dZuf69Fhcs1MnCIklTUAenfGIn9Hn5Qc9liG45erJJa5IuDbCP83/ie
 fKWA==
X-Gm-Message-State: AOJu0Yxi1e0tbBxTE3Slq4CE/dwJDZVmoyb3SZKzQUI/37/OynFQghdL
 JIb7FixX8Ihj0QX5P4cUh3RyPathaAjEtgvo1aSFkVdHp2BhC+feYq8bOs0z/99en9A=
X-Gm-Gg: ASbGncuOsUyQezaRO3oQdk0u0xLwm36BFdn6kTcvYa9ECZ2peIj3RividylSyqkghUx
 BNAJD9WYu4eI6RHXceC6aZkicvO0gE5iyWEg4B8Ua2ttm8BkWrRP0ZC+Are93JR+8g0kBmtznJk
 xnOiW96VU7OWNF9uFb77Lv/DAIxPhIjNhg0rLDXwfoLCZHdHU4WIpuk7rdwz27iRNV4d4oCC/mu
 upFHQwVUMSDOC7rtz1FWL4NiuZFV3hsCe0BXa/KBsCbYuCWFEMB3gjuVXiUE2umqc+F8xLyBfBP
 eW9xg/zTAvk1SzVy90yzr6cSQb+0roSylQvB+aIFoylDpTWdlBCUGpGZsHCN43vyLpatmbGK0D/
 /kyrt/hTSgk7tsJ/fjMMRShEtZCxmoLqSgimfAUdTskpQD1cekEqk7L7R05y6NRmWW5PCgqRBd2
 gqlvZOtg==
X-Google-Smtp-Source: AGHT+IFmEfV2zP3MvQk4CG9wKwSDN7OiZZ85wlD7rW9MlGxfN0ijqRFz/8/+F2R/9EpqyGV0LP+XNg==
X-Received: by 2002:a05:6000:184b:b0:425:8bf9:7fa3 with SMTP id
 ffacd0b85a97d-4267b33970emr2723255f8f.63.1759937494750; 
 Wed, 08 Oct 2025 08:31:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm30715289f8f.32.2025.10.08.08.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 08:31:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/7] Introduce the Interconnect Subsystem
Date: Wed, 08 Oct 2025 17:31:27 +0200
Message-Id: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+D5mgC/4WNTQ6CMBBGr0Jm7Zi2WvxZeQ/DAocBJjEtmTYEQ
 7i7lQu4fC/53rdCYhVOcK9WUJ4lSQwF3KECGtswMEpXGJxx3hpzwhwnIZSQWSmGwJQx8JLxzN3
 Ft0xkLEFZT8q9LHv52RQeJeWon/1otj/7vzlbNHjznrk39fVV8+MtodV4jDpAs23bF0VczcO/A
 AAA
X-Change-ID: 20251003-topic-interconnect-next-4ed75aecc01c
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3933;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=l1KeGzOI/uKwbWhFNBPIrV402DNarCm6U79vmx3PWAc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo5oPSeNgAP1qIr2V/4qHkmKS9pA4Dqz9s0z9YHexj
 OjXCh26JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOaD0gAKCRB33NvayMhJ0WkdEA
 CCwEvkLccBBhk8ILfIjF9aUgE7YV/CvvlCLrGXqpCjO0ZNwY5o6ddrwfylHCUKnZtpR72uri181ZI9
 7wZ2zEp4VFJxJas4GQl6acTjQxgfJ39vgY/d7Fh/qCu5+J0cs3NiSxAZovp/rQel1Tk29L1CthVKtl
 mHRTJSmImirv7rrYPBij9ODL1SIxQ89mwveOaklATsD60VHB5CRaDhwSPBuh6Qvi3avaIEkRMLY1cK
 tSsH1RzoQSVElZR9W0NaRu9BllwlvvUo6QxBUxJR2VQZxduWthoTFMjNb3fUcNTJ13pw3ctgx5qpdZ
 pJuUtN3Ph1SxlAhFSk4c2T4Mct/UNbnQYF96om7UW8RbRQ0aNl6hJTTDFGlDOTO/nCdosKrEeH/IYv
 +aZyfbHBdTw24uUsWhPpbe8haLKAc4l+c7im16agQ52SvZFGwIYthF0fo7YhGVGjz+d+i1CqG1KBfQ
 IKSXzHJsRP4mSi4MTWJh03PLQSZYXNirP3tLFkPxyS8TrKIY7cVEeCnmUOxGwkbg4cHsKpDEeHHoCV
 BCWc24IUGhYzw875z4ZoHultTxjAu9Uxg/DACfeVFrc5I7poVWGBnE1TEM1pbpcyU9DsAfOgjjdv9z
 9dNQmqwmhpSWeFBDTu/SwqrLGmUcJE3NLV6/5rVhxUn7E/L2CTY3KM8ul7sw==
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

Each bus endpoints are materialised as "nodes" which are linked together,
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

DM Testsuite is provided, testing all the API and nodes lifetime.

Qcom implementation depends on:
- https://lore.kernel.org/all/20250711143851.1490617-2-aswin.murugan@oss.qualcomm.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Simplified nodes linking, looking for nodes at traversal instead of complexe debice reparent
- Populates nodes at bind time, only probinf nodes and providers when a path if found
- With proper refcounting the node lifetime is safe
- DM test is added, testing with a small graph that calculations are good
- Fixed plenty of typo and errors, and dropped useless code
- Dropped RFC since DM test is available, and code works as expected
- Link to v1: https://lore.kernel.org/r/20251003-topic-interconnect-next-v1-0-955eef068b6e@linaro.org

---
Neil Armstrong (7):
      Introduce the Interconnect Subsystem
      interconnect: add DM test suite
      MAINTAINERS: add myself as Maintainer of Interconnect
      interconnect: add support for the Qualcomm RPMh helpers
      interconnect: add support for the SM8650 SoC
      ufs: qcom: vote for interconnect bandwidth on probe
      qcom_defconfig: enable interconnect for SM8650

 MAINTAINERS                                      |   10 +
 arch/sandbox/dts/test.dts                        |   36 +
 arch/sandbox/include/asm/interconnect.h          |   19 +
 configs/qcom_defconfig                           |    3 +
 configs/sandbox64_defconfig                      |    2 +
 configs/sandbox_defconfig                        |    2 +
 drivers/Kconfig                                  |    2 +
 drivers/Makefile                                 |    1 +
 drivers/interconnect/Kconfig                     |   22 +
 drivers/interconnect/Makefile                    |    8 +
 drivers/interconnect/interconnect-uclass.c       |  548 +++++++
 drivers/interconnect/qcom/Kconfig                |   12 +
 drivers/interconnect/qcom/Makefile               |    7 +
 drivers/interconnect/qcom/bcm-voter.c            |  340 +++++
 drivers/interconnect/qcom/bcm-voter.h            |   19 +
 drivers/interconnect/qcom/icc-rpmh.c             |  222 +++
 drivers/interconnect/qcom/icc-rpmh.h             |  129 ++
 drivers/interconnect/qcom/sm8650.c               | 1664 ++++++++++++++++++++++
 drivers/interconnect/qcom/sm8650.h               |  144 ++
 drivers/interconnect/sandbox-interconnect-test.c |   89 ++
 drivers/interconnect/sandbox-interconnect.c      |  338 +++++
 drivers/ufs/ufs-qcom.c                           |   13 +
 include/dm/uclass-id.h                           |    2 +
 include/interconnect-uclass.h                    |   74 +
 include/interconnect.h                           |   81 ++
 test/dm/Makefile                                 |    1 +
 test/dm/interconnect.c                           |  148 ++
 27 files changed, 3936 insertions(+)
---
base-commit: b8cea886d50e6c09985256e546904d640f600e4d
change-id: 20251003-topic-interconnect-next-4ed75aecc01c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

