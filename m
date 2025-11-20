Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6B9CF8552
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3060D8405E;
	Thu, 20 Nov 2025 09:14:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="juhPVbr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44358405C; Thu, 20 Nov 2025 09:13:04 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 852BD83D3C
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-37ba5af5951so5907621fa.1
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763626380; x=1764231180; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tl3Bdm/WYg1pDMU3O52rYtoa5slciCVqb+5+I8/dguY=;
 b=juhPVbr9EgiTzQWv8d0irojp5/Q/MVj/wCuuojMIYrSSgris7azKWf6S0A0oNXzJWZ
 9XfgXO3BLLAiqToCj+J6ezV2BEyMY1fYbny1ErKdW8wCU8GDwV0yDEjOQ5eMe0lrhcG0
 A9mtSXzgTHgIwsN1ycpb2YarQSlRoCgYKF2XmKDicigeVY6gxBU+twM1ia141LSE9VlF
 JmQVOGSyeJvmPbquqq4TJrPMlYVkzRjV7F44ga52zdXsDY2onk14BttZnNIQ4vk/g40m
 Krw4yRE9wAJKx4ESJjjeXGlNySUjkYiqEiP8SeRIgsvgfoljVDKudGUGM1ptIHvlgIr0
 1p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763626380; x=1764231180;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tl3Bdm/WYg1pDMU3O52rYtoa5slciCVqb+5+I8/dguY=;
 b=eab9/U7weUzI3wkmquBCKMYf0HReDTinTy5UGLiGFFHnSmhR92s3YBozOxl6okPGyY
 UmX6cEoxVV5GyCP4OJPaRON2SLUSDJgDKZQvZGxCIZ2KKm8qE4iYIvh/F+qmO5be9Khp
 izbGKqLrMsa1BWGGkL9Ejk/KmcfGG361rA+IejC0NEEStcbVfnlDMt3N2PuXtRrmNWO2
 M/qMeqj3yaEp1wi1vqK5ktiNR/9IVlvoQBCRLMEwye5yN0c2fh7dBbSdF/4p02OoJPtd
 w2+iDOV+rdoRHta4/DAmUDz+GV7rOHhMheYmeZUvdT8jr1dBt6Qlkp2lMhJnrICJtPxv
 LaZQ==
X-Gm-Message-State: AOJu0Yw1wPH4T67TvqglMFrItURSJDU+4qjoKCYbbteDFgcZajBQQ0we
 kE8A2YaIbgeV02BxaGR/mV0Mp7BY2uouMUOLCayTqjCh810YhCI1erYRZ81sHDhuTSw=
X-Gm-Gg: ASbGnctXGyxA2sLGmTfq2WU3wJ48AgS+eUQDuX9tVbzCe8FqlXhIpAJHQs3AMrjXPZu
 imNDkIHoR17BK5fMcrVCu0jiX7vv8Nxcn4fX+2yp7JAvnJYkAv3fFRPO6yb/GW5T0duvAz8ZN8l
 0NKevCAYimjgNyfkOarL3KBeTb/TEVjyDeoyndPRKmA9f3o7ADmNvh/yzsom80ZOJest6bUDbMg
 sKlDcBguhuTH41T8N0WC9vlxUeQiAB24bqUDNiYmbBxhBt9ywR1aFDMkptU5uOGPMBDLIqw3SIM
 upFHRujCa/elWT7DrUfk3cxLD2WXpcF7NIKd0+UoZmAi2hfr3kirB5CpAPP9F3RJZAXh1hPwYp2
 IukI99Zck6UjFwuiU327eylFRtGQMckBb7U+AG1xWSFd135fLx5u0ydUuFHoNB6E/Q8r7FoB77w
 PhvLRMrX2qLCMMSu979ejTGvlfv0lpDmc=
X-Google-Smtp-Source: AGHT+IEs+e7Ti+vjrCxJbky9Uz66K/hremp/3RrXxMS5wPxXGyXqeYzelv8cg5q6v2WiyqrRWwBRbQ==
X-Received: by 2002:a05:6512:3a86:b0:595:7cf5:f7cf with SMTP id
 2adb3069b0e04-5969e3169e7mr650894e87.38.1763626380379; 
 Thu, 20 Nov 2025 00:13:00 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363c0sm3844398f8f.18.2025.11.20.00.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:12:59 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 0/7] Implement the Generic System Interconnect Subsystem
 for U-Boot
Date: Thu, 20 Nov 2025 09:12:51 +0100
Message-Id: <20251120-topic-interconnect-next-v5-0-e8a82720da5d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPNHmkC/4XPz4oCMQwG8FeRnrdL0j9jx5PvIR46bdTA0kqnD
 IrMu2/Hy7qIevwC+X3JTYxUmEaxWd1EoYlHzqkF+7US4eTTkSTHloUCZRFAy5rPHCSnSiXklCh
 UmehSpaG4tp5CAAyibZ8LHfhyl3f7lk881lyu96IJl+lnc0IJsreW6ACdGzra/nDyJX/nchQLO
 qlHyL2GVIOC6ag3MWrlniH9ACG8hnSDBu3MGhujvXuCzB+E+OYis7wWAGI3YO9j/AfN8/wLGJt
 D2poBAAA=
X-Change-ID: 20251003-topic-interconnect-next-4ed75aecc01c
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Anurag Dutta <a-dutta@ti.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Peng Fan <peng.fan@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Pieter Van Trappen <pieter.van.trappen@cern.ch>, 
 Alexander Graf <agraf@csgraf.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, Sam Day <me@samcday.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6477;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PYHvonWtSNqIaiU2cPDsNOqTJoz+GMUbxnvsluEr4Lk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHs2H2RVI6t3Q1LYQRTy+ccQBGCvMs9LkTg8V3Nhr
 3rw085aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaR7NhwAKCRB33NvayMhJ0RbaEA
 CvUal+4o8I0fjr9EjCt4kkeiWP/+5NGX+kGPRnAOFTJs+R0J7otYDScnCyIbpJM9pA+s+Ju6eeMdIK
 r9ZptjT0rjuNavpI4Q6w8ABPGbiwL7P/r8ev6JtezifWohU1QXJmIxCowvOSkFO3SR3ggENoQfv5+J
 eh0rvofmAil4RRRf7VPe4WjgM88Kb1XLZsa064nTMp8iwfJbWEzjexaFMFduJ3AAFhTOFy8cIn2VkO
 ENM2Mi68uBxVsP+jHNkrOa6Qi2q7A9EF0O/3JoGNZ2oW8nt11aezxt9zJn2JfN6aGh/MEGA3DoKqHx
 kPg1PLFMh2JehGg+lILCi4T4fV3fAzBVeWbGRYVw/k02wsIx5Jw4UNoBWT1iUCbC7bIP5bqjEJnxaJ
 1RTlvAtio+VNpvFu68WWH91b2btpF6KMRM+BUgkBQKnnm8JwePXUdHFhUcRVUIx9zZcLhXcJESrDsj
 RpvF7FYIWEuVteVKHNsLJoeFncwPfI3RmxMuz/VUYO0qf0UJfSWXwbMawlesQ+4PzWf++HqpanMXTa
 1+qBFK9bZgaQ53+0tIWjaLZvtxOxaWayOLxT6FxhVDOYe/ipylIDr+E7Eunb1RJ3hCLXANHrPgGUe7
 8fpG1mmMBPENJiPBoQ6JM82HjVtUzDUg/BWpNEPltecaTizNjwhARESUnkUw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:14:18 +0100
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
Changes in v5:
- Fixed memory allocation issues fixing sandbox tests on CI
  - req allocations were not zero-ed, leading to funky avg values
  - xlate nodes mapping tables were not freed on drivers unbind, leading to memory leak
- Link to v4: https://patch.msgid.link/20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org

Changes in v4:
- Rebased on upstream next to prepare for a PR
- Link to v3: https://lore.kernel.org/r/20251010-topic-interconnect-next-v3-0-b384713283a8@linaro.org

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
 drivers/interconnect/interconnect-uclass.c       |  545 +++++++
 drivers/interconnect/qcom/Kconfig                |   12 +
 drivers/interconnect/qcom/Makefile               |    7 +
 drivers/interconnect/qcom/bcm-voter.c            |  340 +++++
 drivers/interconnect/qcom/bcm-voter.h            |   19 +
 drivers/interconnect/qcom/icc-rpmh.c             |  224 +++
 drivers/interconnect/qcom/icc-rpmh.h             |  130 ++
 drivers/interconnect/qcom/sm8650.c               | 1665 ++++++++++++++++++++++
 drivers/interconnect/qcom/sm8650.h               |  144 ++
 drivers/interconnect/sandbox-interconnect-test.c |   89 ++
 drivers/interconnect/sandbox-interconnect.c      |  303 ++++
 drivers/ufs/ufs-qcom.c                           |   13 +
 include/dm/uclass-id.h                           |    2 +
 include/interconnect-uclass.h                    |  136 ++
 include/interconnect.h                           |  155 ++
 test/dm/Makefile                                 |    1 +
 test/dm/interconnect.c                           |  195 +++
 29 files changed, 4204 insertions(+)
---
base-commit: eb7a61d2cd7b24265c884dadf05ba20778ba99cd
change-id: 20251003-topic-interconnect-next-4ed75aecc01c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

