Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C4CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 11:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2218056B;
	Thu, 18 Jun 2026 13:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sAcSTyXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B45C847EF; Thu, 18 Jun 2026 13:56:59 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4267A8005D
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 13:56:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so5628765e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781783816; x=1782388616; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C2TF0kS7IdPoyX1V59QQs4EZaixsmMFxxJKWeNUps2Q=;
 b=sAcSTyXUd+1UQznn7MmIoR6Wxgav+xRCBbu3aB0BOkIvnGS31JRKe8/TkBIwm7tbkW
 jqb3bHXtH5+58RvsOJPMO3db7dms8+dwbf4QiVHPwkAPZAWBvTmXmnLFqWgtvMz5HNsl
 VAlW/Tbr5qHn4dasjXNdcsLiM3afzviL3oIipcnGtNTXeYuiJknjNkokvcMBqIJzvyie
 A7QzwCUpmNxE3ZGkZO7MQ/j61Rbh5MR+u+8DHe43usGiqS0KQdWbDIqOoby7zeST/zXN
 ihmTo9NytdUAOhyyQgtDPGSLCoBUevxcQT/GCx9A1d6BGxMAOp0r7WaZb4VxR1gxMgdN
 K11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783816; x=1782388616;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2TF0kS7IdPoyX1V59QQs4EZaixsmMFxxJKWeNUps2Q=;
 b=rhqxJkHer//K0hsNmHBiA5eeE9iUgJBK0VZe9JuEx1VUcjpWLY53zScIv5sAE4qlRj
 9W0+xWdl0DQezHVeX5lLevEEMZhxKaUbBlYoUgRVyz+avi1jvvFokfJXisyYc5pAx9aZ
 AkiRCojxLj/9GId4JjZ6wLzoEt833W8uaCAIPsOlX6x8OHZKM737fmZ3NxoUWmqnIOvW
 Nj09eHt0j/USkeo4NQb62J/GYxNYPWotM2juAadueKPQZf1VDZBPGgFXOxwzvidUqr3H
 rb3FVn/hhb6d9mc4iEG1xIWH+Ig+jyeRHlNIO5VfvAltmo6BLrW2Gg81zC88M+TAoFev
 mzdg==
X-Gm-Message-State: AOJu0YysenL0UQru7aq7y0LXsT/BuR5gEYIqlR12T4A62jEsLf7O70ar
 dwqhSBW7uzCrt0IxHlW+lvybB6xAX42Ur+gRJ5PShoCzCzFu4BeMwHAhsW+4Ei5Nts4=
X-Gm-Gg: AfdE7cnS8tjOiK/IdoNLwbrqGRb5Naz5ZUjqLgiwDN4putRpCBX72R18iKDZmX16R1P
 Lz4ZvtR9NdRVriOYjEoz2rZVd1CPCOUUSxxM9SL7mBYS7+bnrSK6v61f74jegt1ugU/4voSr88x
 oz3+ent9IKikoM9RSVCevLURZJdR2EUevt9+MnBYfMHEx7PSNGUCkkst6Dci6/zBaFdRn7Wt2UD
 OarjZQ4+cQh8S/cE0RzLynV2iBCwwzn80SSqrbF9gBfIJIEtVwZVElohAHVDU3a6zQWKkBczZ9V
 7H2Be6wZmTLG20WeKU5sS1xyDo+sB+daYhZkkPj2VikRR2fbHIC9zLEQiry6RQW2wNYS/M1O39o
 RBYk35KxgtB7SnsxeRVDsaZOisOn1kG1Am6RMMrLk9pVPLTFVvpUgE/Ix9Kxx/XFKnQ1OPlWBZK
 b4aRVj/fdZXdqKdNw5iM/3xAfK5IM25V6LZLXujILUJxHsRVj47DLjn+Q=
X-Received: by 2002:a05:600c:a48:b0:492:10e8:3f92 with SMTP id
 5b1f17b1804b1-49238219655mr58060625e9.17.1781783815560; 
 Thu, 18 Jun 2026 04:56:55 -0700 (PDT)
Received: from lion.localdomain (p5b29e032.dip0.t-ipconnect.de. [91.41.224.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46289c3b3a3sm14448355f8f.30.2026.06.18.04.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:56:54 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 00/15] qcom: smem: modernize SMEM in U-Boot
Date: Thu, 18 Jun 2026 13:56:48 +0200
Message-Id: <20260618-b4-modernise-smem-v3-0-472391477988@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQqDMBCF4auUrJuSGTWGrnqP0oWJow5UU5ISW
 sS7NwouCi7/B/PNLCIFpiiup1kEShzZTzmK80m4oZl6ktzmFqiwBECQtpSjbylMHEnGkca8VNo
 aQmi1FfnuFajjz2beH7kHjm8fvtuLBOu6a+WBlkAqaWtToQOwuna3J09N8BcferFyCXdCq0odE
 pgJp4Acdl1hjP4jlmX5ARk8dWv2AAAA
X-Change-ID: 20241121-b4-modernise-smem-b456b8e21d6b
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5996;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1s6/8fqRThtWBKtftaOxtqaAiD5uJBztUc7f1X1ahHs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizjuyyr1K0XSsXYXS06lf79stAEjQ8Bk84VuL/32XPCL
 6xLfd/7jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR6Q8Y/llmPMnmeiG84ID0
 ia5qUS4TV7M7u+aGWDM8vq9e/8u8WYThv/vWudtvm+zU+vj/A3P/rz6e5DlPlNJnxZR2TPIo8Np
 W9QAA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Smem is currently implemented a uclass in U-Boot. This carries with it
some implicit limitations about how and when we can actually talk with
it, since its modelled as a device.

The SMEM uclass is qualcomm specific and has no other users, smem is
also largely useful for parsing the memory map and other tasks which we
have to do before DM is alive anyway.

Let's drop the old smem code and replace it with a straight port from
Linux, providing a familiar interface and enabling us to access it much
earlier in the boot process than would be possible with a standard
udevice.

Additionally, this will be easier to maintain going forwards since any
patches from Linux can be more easily ported over.

With this new smem framework in place, we can now use SMEM to parse the
memory map when it's not provided via some other mechanism and to read
the serial number of the board.

Implement this functionality and split the snapdragon memory parsing off
to its own file to try and organise things a bit better.

Since the memory map stored in SMEM doesn't already have some carveouts
let's also be correct about unmapping reserved memory regions, we
should eventually do this on all Qualcomm boards but it's particularly
important when we aren't chainloading from ABL.

This depends on a fix for unmapping memory regions: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/

---
Changes in v3:
- Fix smem init to ensure the smem region gets mapped and avoid
  needlessly re-doing smem init.
- Improve error checking in parse_memory_smem()
- Call qcom_smem_init() from board_init rather than late_init so that
  SMEM is available earlier.
- Link to v2: https://patch.msgid.link/20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org

Changes in v2:
- Ensure reserved regions are unmapped appropriately when using SMEM as
  the source of truth for the memory map.
- Support SMEM ram layout v0/v1 for older platforms using a header from
  Qualcomm.
- Set an environment variable (memmap_source) providing info about
  where U-Boots memory map is from.
- Correctly handle serial_num missing on msm8916
- Link to v1: https://lore.kernel.org/r/20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org

To: u-boot@lists.denx.de
To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>
Cc: Philip Molloy <philip.molloy@analog.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Rasmus Villemoes <ravi@prevas.dk>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Casey Connolly (15):
      Revert "dm: SMEM (Shared memory) uclass"
      smem: drop drivers/smem
      Revert "test: smem: add basic smem test"
      Revert "drivers: smem: sandbox"
      mach-snapdragon: fix reserved memory carveout
      soc: qcom: import smem from Linux 6.11-rc2
      soc: qcom: smem: adjust headers for U-Boot
      soc: qcom: smem: adjust for U-Boot
      soc: qcom: smem: get serial number from socinfo
      soc: qcom: smem: stub functions
      soc: qcom: smem: add build infra
      mach-snapdragon: move memory parsing to its own file
      mach-snapdragon: support parsing memory map from SMEM
      mach-snapdragon: fetch serial# from SMEM
      configs: add qcom_sm8650_defconfig and debug fragment

 MAINTAINERS                                  |   1 -
 arch/arm/Kconfig                             |   3 +-
 arch/arm/mach-snapdragon/Makefile            |   2 +-
 arch/arm/mach-snapdragon/board.c             | 261 ++++-----
 arch/arm/mach-snapdragon/dram.c              | 239 ++++++++
 arch/arm/mach-snapdragon/qcom-priv.h         |  17 +
 arch/arm/mach-snapdragon/rampart.h           | 194 +++++++
 arch/sandbox/dts/test.dts                    |   4 -
 board/qualcomm/debug-sm8650.config           |   5 +
 configs/qcom_sm8650_defconfig                |  16 +
 configs/sandbox64_defconfig                  |   2 -
 configs/sandbox_defconfig                    |   2 -
 drivers/Kconfig                              |   2 -
 drivers/Makefile                             |   1 -
 drivers/smem/Kconfig                         |  25 -
 drivers/smem/Makefile                        |   7 -
 drivers/smem/sandbox_smem.c                  |  44 --
 drivers/smem/smem-uclass.c                   |  46 --
 drivers/soc/qcom/Kconfig                     |   8 +
 drivers/soc/qcom/Makefile                    |   1 +
 drivers/{smem/msm_smem.c => soc/qcom/smem.c} | 803 ++++++++++++++++-----------
 include/dm/uclass-id.h                       |   1 -
 include/smem.h                               |  90 ---
 include/soc/qcom/smem.h                      |  36 ++
 include/soc/qcom/socinfo.h                   | 111 ++++
 test/dm/Makefile                             |   1 -
 test/dm/smem.c                               |  26 -
 27 files changed, 1218 insertions(+), 730 deletions(-)
---
base-commit: 298d44464dc63a4f3f5489150acd7958f359f9bd

// Casey (she/they)

