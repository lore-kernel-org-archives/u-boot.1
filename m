Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADCBCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FC78445C;
	Fri, 10 Oct 2025 16:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QrM597TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FE8844C8; Fri, 10 Oct 2025 16:35:20 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7853F8425A
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so1310584f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760106916; x=1760711716; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oy5GEpFign6fl5OmTvxKq/TOdBWrkDLzlPJsPlxu+2k=;
 b=QrM597TO3Qb50sU7yNS5aobygpJ2Pe2ozmOYgCxE8bVZp+q7w9LN4lekbY8oVD0CSk
 UDPQDGuN2kn/guYdocq3voYCOSmpAemsMTh68AGAWBhAWKocS/5J37AS1xnxysq+lPR+
 RqAHrNknnskDym53ngMeBYgh1xbOdGnRGuD0LlJuyRqdfVJsPNwW+dH6Uajb9vEXk+97
 dQAz/TRbvkHzJmY2hSL7+ePI8JP3GrdapeJyROpoPmu+LzwfjrMpPjWPKGsmgMVod88y
 iAiRqw3qj1Gky9xyyxu2rQq4ECpANFGnI3+YI1x0btjHF5m8Thxb2wwDavIzBHR30eKw
 JL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106916; x=1760711716;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oy5GEpFign6fl5OmTvxKq/TOdBWrkDLzlPJsPlxu+2k=;
 b=CJt7KJ9F53QknCIwj51f+v8kiL9EzMo/eslGGNRGQZCDrC8yhDN4kd6qyPMJ/qE+OB
 ze7r0B2cMTYCcFcat5RlFwJEgUKYrrQg0oyU1hRuEE1IyoQ4s6XrpLeBVqfGG3C7nVys
 Lj7algcsGh1OezFkJhX+NTzatBfqUQDslU+1AY8wHdrlD3LsmfdWnus4sWfCGiN9z7mv
 zLECqm06LjuC1nssFRd5iCDY1xThgABCTkzM+S4vqZPgZIkQXYa547/Pku7QuKzWYaNE
 +uUjqfJFEr85kqMUU6fnE/KtF0q2JvSZ4Y20QclJ5GIWcYDTzdD0x7GQued2lrvf+CG9
 eBQA==
X-Gm-Message-State: AOJu0YxQsITC+r1z0lqqHvntcmNmXl7f8WoppCBW8fISp5ynHl7pRv42
 OoDBP7+f3EMEF21SnvbXX/gIF+FefM/DE0sZu+cJfOCztGbw98kIFgV9diutCI+azUQ9dBUR0vy
 F+c7g
X-Gm-Gg: ASbGncvjHi0it0xlp3nsk1Ifz6YjETcWdhpFx3Pe+WpujBojCdCByTKbw6H+U9hBn20
 WqGMGZFeedZ59MP5zpAtIVNc/39XaQuTs8VmehCZq4P6hHNDJg3Ty9v6a9n5Zxpo7d7fHWtpB/R
 lSBPWh4wryXhswxXgQP5CqN3NbkIRyrNs+2Nto78HLQEoTigb3jerPbGF48xdq6t5cUHQNDrypA
 kzMMg0rUH/VFSzb29glF5VJsVoqxXRbZ4NnJBYvyeAdGNCCRFQwp4jVRrkkoyi7Gcz85M9fec+f
 JyuKjdCbe8MqogJtA/PNZK8wQ9eS+nGC0Gsi5av8YNh+woOnyJUQRHzucAcbvzcs4RVlN3t23xc
 MiFbK+6J3F+EHS9J/K61QzK8lTQdIr/IAl9X9fioICRpfXkR3GNhFqj/7VodD8wa1LQ==
X-Google-Smtp-Source: AGHT+IFS/02a5OsczaPIfDNUmE9WoIeq2YR8ACpHH5T3Ekd1scys6ZtF+z7jjXoJ2a3Xc2Hn2h4I4Q==
X-Received: by 2002:a05:6000:2f83:b0:3ee:1461:1659 with SMTP id
 ffacd0b85a97d-4266e7e01cfmr7206329f8f.31.1760106915657; 
 Fri, 10 Oct 2025 07:35:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab5250ddsm59878215e9.6.2025.10.10.07.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:35:15 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/7] Implement the Generic System Interconnect Subsystem
 for U-Boot
Date: Fri, 10 Oct 2025 16:35:07 +0200
Message-Id: <20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsZ6WgC/4XNQQ6CMBCF4auQrq1pC0Vg5T2MC5wOMIlpSds0G
 MLdLax0YVz+L5lvVhbQEwbWFSvzmCiQsznKU8Fg6u2InExupoTSUoiSRzcTcLIRPThrESK3uER
 eobnoHgGEBJavZ48DLYd8u+eeKETnX8ejJPf1v5kkF7zVGnEQdfOo8fok23t3dn5kO5rUJ9T8h
 lSGoKqxrYwpVfMNbdv2BsaQ9TsIAQAA
X-Change-ID: 20251003-topic-interconnect-next-4ed75aecc01c
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5971;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mgBL+IPvZMxFFMnvCZhvAthAhPoHr2n6QdFSvbzkb8c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBo6Rmf8UEzbkyIPHBEoSsknOO/IK8Xu30mopglnZUJ
 nCeRL5yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaOkZnwAKCRB33NvayMhJ0b/sEA
 C0IfOjIyM1MRkttzL6PYDThNDNA8QUqu1nv2Wb+makyx4tCGI332Enw7UDn9fhq+jg1jqvU03UmIMs
 e14iNwCJsqTBcPsNXqsQXGDwParJBj/XKjpvNPuvbdSJRWk27AnWeht3+TWMIGyBOOoVVtdx3tkHFA
 iO2yfFUt09EgI2HqZcVBeDUdI4NHk2qKjQImQ75Eo06Tw5MxCTQ9KjRy+s/wzK/ee3nk7qBeZLiw4X
 9emtPFmLAUvRNXeNsblh3+daMsC+lCCui+wIYimvK3QkCGPcIrxvZHVV1xd8fq1n75kVFglzm/9sZo
 frbuKNMTSB2J1FOJWQSCOYVEEM/WBzrhA65OgCE08lQbAnIje7ZTCVoDalZE+0QGANIPRG4p9woBNe
 LkHc4F2YcYnHkhDp/Awwe98KbIjinS5qzCWRFiNT0nKCE0QtW51NklUoCMy5JS2ED4Um65xQOHPdEc
 mL0SYmyKjL9zxHoENwlsPyK5971DuVHo7bqmEpT/tuITRhBnM6VyNYr3EVF7my+UqORHHpEsILBniP
 UOHzTeiWbKXhq21Lb/25Ca49F091hcfcqGi/lac0ggFcnXCO6JymlioKbbFhjCtKNm36MBlJaHgJqH
 MqNWRP7s711zRoFM/DzX+HO8dsFadED8B1bbJfINkodUfDpYRqvF8Cz515Qg==
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

Let's introduce the Generic System Interconnect subsystem based on
the counterpart Linux framework which is used to vote for bandwidth
across multiple SoC busses.

Documentation for the Linux Generic System Interconnect Subsystem can
be found at [1].

Each bus endpoints are materialised as "nodes" which are linked together,
and the DT will specify a pair of nodes to enable and set a bandwidth
on the route between those endpoints.

The hardware resources that provide those nodes and provides the way
to vote for the bandwidth are called "providers".

The Interconnect uclass code is heavily based on the Linux one, with
some small differences:
- nodes are allocated as udevices instead of Linux idr_alloc()
- tag management is minimal, only normal xlate is supported
- getting nodes states at probe is not implemented
- providers are probed on demand while the nodes links are traversed
- nodes are populated on bind
- id management is simplified, static IDs and dynamics IDs can be used
- identical consume API as Linux, only implementation differs

DM Testsuite is provided, testing all the API and nodes lifetime.

A first implementation for Qualcomm SoCs using the RPMh subsystem
is added, bandwidth vote is required to have full bandwidth for
storage devices and enabling some subsystem like Display to access
the DDR memory.

[1] https://docs.kernel.org/driver-api/interconnect.html

Qcom implementation depends on:
- https://lore.kernel.org/all/20250711143851.1490617-2-aswin.murugan@oss.qualcomm.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Add doc page, hevily based on the linux one
- Documented all the structs and functions
- Removed id field from icc_node, now using the device driver_data
- icc_node id is not an ulong, can accept a pointer for dynamic id
- Removed all functions call with icc_provider, now using the struct device only
- Removed the icc_node provider entry, now only using dev->parent
- Removed the interconnect pre_remove and pre_unbind, they are not needed
- Removed more unused struct entries
- Fixed the icc_path alloc, added the called dev to print errors with dev_err()
- Removed IDs in sandbox interconnect, uses the "dynamic id" using the node pointers as ID
- Now of_icc_get/_index will return NULL is prop is missing, like for Linux
- Cleaned all the debug() calls, added new ones to track the bw agregations
- Renamed node_find() to icc_node_find() to avoid name collision
- Moved icc_node busy check to icc_node_busy()
- Now icc_node_create passes the ID via driver_data
- Added more bw test after put() calls, moved enable() after disable()
- Used "Generic System Interconnect Subsystem" when possible
- Dropped the icc_node init_avg/init_peak which is a Linux thing for sync_state
- Dropped icc_node_add
- Link to v2: https://lore.kernel.org/r/20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org

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
      Introduce the Generic System Interconnect Subsystem
      interconnect: add DM test suite
      MAINTAINERS: add myself as Maintainer of the Generic System Interconnect Subsystem
      interconnect: add support for the Qualcomm RPMh helpers
      interconnect: add support for the SM8650 SoC
      ufs: qcom: vote for interconnect bandwidth on probe
      qcom_defconfig: enable interconnect for SM8650

 MAINTAINERS                                      |   11 +
 arch/sandbox/dts/test.dts                        |   36 +
 arch/sandbox/include/asm/interconnect.h          |   19 +
 configs/qcom_defconfig                           |    3 +
 configs/sandbox64_defconfig                      |    2 +
 configs/sandbox_defconfig                        |    2 +
 doc/api/index.rst                                |    1 +
 doc/api/interconnect.rst                         |  117 ++
 drivers/Kconfig                                  |    2 +
 drivers/Makefile                                 |    1 +
 drivers/interconnect/Kconfig                     |   22 +
 drivers/interconnect/Makefile                    |    8 +
 drivers/interconnect/interconnect-uclass.c       |  543 +++++++
 drivers/interconnect/qcom/Kconfig                |   12 +
 drivers/interconnect/qcom/Makefile               |    7 +
 drivers/interconnect/qcom/bcm-voter.c            |  340 +++++
 drivers/interconnect/qcom/bcm-voter.h            |   19 +
 drivers/interconnect/qcom/icc-rpmh.c             |  215 +++
 drivers/interconnect/qcom/icc-rpmh.h             |  129 ++
 drivers/interconnect/qcom/sm8650.c               | 1664 ++++++++++++++++++++++
 drivers/interconnect/qcom/sm8650.h               |  144 ++
 drivers/interconnect/sandbox-interconnect-test.c |   89 ++
 drivers/interconnect/sandbox-interconnect.c      |  293 ++++
 drivers/ufs/ufs-qcom.c                           |   13 +
 include/dm/uclass-id.h                           |    2 +
 include/interconnect-uclass.h                    |  136 ++
 include/interconnect.h                           |  155 ++
 test/dm/Makefile                                 |    1 +
 test/dm/interconnect.c                           |  195 +++
 29 files changed, 4181 insertions(+)
---
base-commit: b8cea886d50e6c09985256e546904d640f600e4d
change-id: 20251003-topic-interconnect-next-4ed75aecc01c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

