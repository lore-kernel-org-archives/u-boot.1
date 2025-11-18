Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31BACEBF92
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC32283DA6;
	Tue, 18 Nov 2025 09:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kttKsrRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F21D83CB9; Tue, 18 Nov 2025 09:28:22 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B4583C16
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-477619f8ae5so34439285e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763454499; x=1764059299; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zAbxCdBie9X5I9Mei/zcf6VpUWoNnmN80tRSGEy+Ytg=;
 b=kttKsrRJbNwQ1bluZ1blJZx57ubopkufLeToUcWgzX60aEefv5TgVUl1ZrYMcn0y15
 miy/LcMxrV6G/Tq1rBLwL7B0FcHGw5t/qZjxxGw+vYmfuV+NasN1WGm5bsatKDfss6la
 hZMcsEM05gLr8bU131D4EFf68Xj9+cY907wmVBnBiQFjlztlPiPXUpk1kVs+x41nB0Ac
 3Tbw2dSJmc9LHEtOJv6S95G89F/DMRpBUzDjGL3RoRT/tE8UP/jtqKd1g8FB3wBN3jD3
 0UA8HYHCgW2oY7+Jvj5dqWWbPcCUUfbY6CY+b83v4qRAYFG52ES/HVLar4QQMhPm9IVu
 ma6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763454499; x=1764059299;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAbxCdBie9X5I9Mei/zcf6VpUWoNnmN80tRSGEy+Ytg=;
 b=RXqODFNGYt+gi0ufXN36+3aTxLkkUGpx+4KYhDomdU+Zm1Ma/w60HdvmOxXYVAaf1Q
 ywXAHSZZkO+x3IsZCDc4a1eQBBHbg8S/Rm1QJ6YSLUGU29o3FQC2fxRNMfah+M5NLH7Q
 P2wrJ3Q3YhZrcM/gzepslHa4ENv+zcJ5JIefsH1hREVrCdOkWvBKejNQDNzHuYnyoNHY
 dIRNr5wcZZjlFUmcWeYS271ayqIXxjCSABuxUaMAn1VZRPNoS2JBYK8GjjkrbP6f3iEI
 gGiOFWoJIOYpLyVu7JbGNNXPAPiM+hFfghghwlbJLmLUrnJWPRnXIIj/UMjVw9CyzbiI
 Rk5Q==
X-Gm-Message-State: AOJu0YyzqJ2YSbxsrfBQ+hJveihDSv95fRxNgAVktGmpIuWR8WfCqOPO
 ekIhq2yctkswbjXEGJLv1559+xwAfrtQulBL82nkmlVR7RJXNjIeX+ORAP/Y+MICt4w=
X-Gm-Gg: ASbGncsIW01DXXGX72Tp7ilC9qAfuHWGMi/GUa65C8xxm1GwBvzavTnFlJ70p4h1yOW
 gFy/Vaa4QcjeW3dMdgwPb9ZSOfElW760KOxxZDgIfXrhu+X9jgehfjEhZ1ypC9eEaktWImVPydM
 fKBJ2KGq09Z/2W/1xFik9yKq8I1X1nEykgj/ahrcpq5B5FGXb98/JJtfyrmmbqTgVvI+lmtEcwI
 kbTpjdkE0rPLrob0tstlOz+/xhAmZbyiRIQHOuXv/2jOB4VKFP6FU/kFWoRUKJsYRb+IxhrOivi
 1mGj7CfT41C1FMx99FGfvACeUa/kb3ks7ETWwYB6FI57hanmDcZaFFIFDXddAShQD5jMlq/Tuv4
 kkksSPRruEyoBxpxvR4y+FIepEh14GWH8HoLF2S8p4HHlP84rEbunPNFO/G4BjZENVy0ibKlLLI
 /TJoak+4nUioly2/khmblJw3A+6olBlAouFrRD+kkANBAq10whLZ5r
X-Google-Smtp-Source: AGHT+IGyv6C7NA5gvlW4izmyekLpVLeLNnX9q6pi6D9R0wfBolY5YM7YTMExTVN++XXG5+QoHn6+zw==
X-Received: by 2002:a05:600c:1c94:b0:477:9fcf:3ff9 with SMTP id
 5b1f17b1804b1-4779fcf472amr80241695e9.27.1763454498371; 
 Tue, 18 Nov 2025 00:28:18 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a7cb24dfsm72698875e9.14.2025.11.18.00.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 00:28:17 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/7] Implement the Generic System Interconnect Subsystem
 for U-Boot
Date: Tue, 18 Nov 2025 09:28:10 +0100
Message-Id: <20251118-topic-interconnect-next-v4-0-9c00d6b19add@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABouHGkC/4XNTQqDMBCG4atI1k3Jnxq76j1KFxpHHSiJJEEs4
 t0bXVmKdPl+MM8sJIBHCOSWLcTDhAGdTaEuGTFDbXug2KYmgomcMyZpdCMaijaCN85aMJFamCN
 V0JZ5DcYwbki6Hj10OO/y45l6wBCdf++PJr6t/82JU0arPAfoWKGbAu4vtLV3V+d7sqGTOEL6H
 BIJMqqASrWtFPoXkgeIs3NIJqiRWpU8MbLWX9C6rh/lWJnoUQEAAA==
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6140;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=FEBEOUKnu31T/nljmXVxYIlzTOSqjfDiM2ZGJXResBM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBpHC4d05qnyesNQl/5L3yxMpvY4ae07snPYHoabZ+5
 MR03GyKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaRwuHQAKCRB33NvayMhJ0UO7EA
 C0YGhvTocgtbrBZMeIFvZvUzTYYd+YxGuLFUKZaw2GoshkPtLEhX0YbxrGIRr1xHWmmwpzG2V9kl+q
 tVVSQSjmQyLPypApJ3rPcQEQT/oOY31HbbJe4UVXbh40C0gAAFjQosruaE0Y17lRMveSs8wy38h55P
 S+KGXYfOeKi+Bcm5qhnNj16+HcijqnTag2A5VMEcP5OVdfA1kVl8ftjDQ+UgDu+NC8l13I/5iUci2L
 lN2DslCKNktwA//lGgrwsMBhG6O1mpK5gZM4G3htN5QUbUyPiCUGMHXylMORjrvZSL06Y0Xxp2eNdT
 4RLQppgH8suMTRdAolYCxp2/W7msFcgIQFdb0yueGrxDIIoYUeYWdUQr5jFkg8IZrGSXK0PFCLhuxz
 e4QjYOqKQUHD7iarvRw+AtPxrld1Kc7IHb36tPNm0MJs4LpK6TmGNWCfeRoU/gQeIgn3mQRWnPtRa5
 91NotiQGIV4nvsuB4I9tdKDP+szW8t0PEm69z7mGgB6JRzjrB86BxJNa2GS7dV6iEB+f94RZQIKWca
 uOAuQzwaj3OW01kTTgS14gWmUflM7gY23fMftx2/T1lJVZ5ygCuwH/UiL1AZ8VTVfJGdNujcQdaiTJ
 ZuY6NOJ6hd9wU658d3eepmRy9oY/UrsT7EZ36spWaDbiZK1Em1HjJNrsX6hA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Mailman-Approved-At: Tue, 18 Nov 2025 09:30:32 +0100
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
base-commit: eb7a61d2cd7b24265c884dadf05ba20778ba99cd
change-id: 20251003-topic-interconnect-next-4ed75aecc01c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

