Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5EBFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB9584690;
	Mon,  4 May 2026 20:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yA/2Wcl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC238469A; Mon,  4 May 2026 20:57:42 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1488467A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so1090661f8f.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921057; x=1778525857; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RATr8xny10edFn+Jf5zUOVt70w042c1ieEgVCbSwbc8=;
 b=yA/2Wcl8bZtNm3Hu8uaW4fWb5Z2QWL3/UJN2ETVLcfUsX8hYgnJkzAQrSsTszzDEhX
 2vT6RigXWRp2DT4ssVtT9Ty2X0SCkyzjrmmiXddxD6+0j3815HmW16Z9IOzIKlOqWx23
 hq7Rr41CEtkT49JO1eMDWDwqQSLcQwNLjSpf3qJu1bc2VsUCfPL34JJBOrWSttRHbXsn
 3W3vCzFuXD926xwFpdFtmWCAwsq7Owtf5YfThJ8Z3bqKAWj2PR+YPHpJ3tAPg08LYLEC
 +LJUneTopEVENpCLX4QDHCEfzBMXaAKomla7l3LVUVdNpX5Cxpu7liqBNGIZYn1hCzn3
 U2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921057; x=1778525857;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RATr8xny10edFn+Jf5zUOVt70w042c1ieEgVCbSwbc8=;
 b=EPcc2WCzKCna7JieZ0M2WxdZ/nACLTbAl231hptxxr1TKJ30DdXzLrx3oJPymQf6C9
 dAknjekMUptLx5KMA692dhVIfm9vbaDw2+ks4SNkBlWoysXua6V0GcaUpV0UbUWZF/Zd
 dcGnEHOKBsso7Uw4r4xS7W12RBBIhXs2234L8lUtOZN739+m1tpGEUYf/h9DtCh1KsnJ
 oDsTR77OZr12zk2LbPq1V5MGahEVMcr/z1KErhkypLFV6gImqOvL+SuAyLK/ISdTqAQC
 ZyqYvMF+XdjYySFmm/kPAzuFOU60iKSigohbm8eGb6gYKP3xEfDmMxF3U6rBokVTyuJ0
 CGCA==
X-Gm-Message-State: AOJu0YwqoBujPR3x5dSf57lcyppYQdXKucZ3pSeYct34gypZvc1Ikz2X
 MYs7CFyuFeG8x2CizscmS5k/gwGlFVflGOFC6ljgrZN62Sy4OJHvHhxfj3mUluZD2dg=
X-Gm-Gg: AeBDietATMaMhrNNw8pLnPbJb5zykQA183z0iE4a3y+u/za63S9H0sTxMiAHCoXoW0N
 Bg8cdtLAo7n2kCQTmGIu3aE4TSELDYxauv3AnLtvA+hB0EKrZUgsetZOtsUBr5wForo3C+E2Zyg
 HMNYX2DWF7cKO9d9AXKncQDP/u1ffaXRvkAfs62eGN5rNvwk/iKwaHRwFGrAVoI+CVUoFX2TEgj
 KlLrEE0y1u0HfX+U8nxFNsL5JIUBL3Ew7WcCmWAfxKGbXDDdYtG08/fHOz2pQfZJMqL2CwQvg0Y
 UvOon2LIR5CERpo+blGb3G4MSETaCRQbdSW80ysMV8uy2NlpO+iUsiNXvPhwY5OQrzsqKTtBKuX
 dKXIIxisff9usSgYAycmjKI+9vJP6yhLYlJSVcXiNJNZzM3BsY4HiMNwxwgkpW4L6iiyeq9DIBR
 Qubh/Ksm4EDpy9J57+pcVNSDhfqjdk5ye3QCX4to0TThW7ooN0Sdls9ljq/zGd5aFPLfdVCU4o2
 6BHJ4Y=
X-Received: by 2002:a5d:64e3:0:b0:43d:70de:1c68 with SMTP id
 ffacd0b85a97d-45006240e47mr220830f8f.30.1777921057394; 
 Mon, 04 May 2026 11:57:37 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 00/15] qcom: smem: modernize SMEM in U-Boot
Date: Mon, 04 May 2026 20:57:28 +0200
Message-Id: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywrCMBBFf6XM2khn6AtX/kfpoknHdsAmMpGil
 Py7seDO5Tlwz90hsgpHuBQ7KG8SJfgMdCrALaOf2ciUGaikCpHQ2MqsYWL1EtnEldds6sZ2TDg
 1FvLuoXyT19Hsh8yLxGfQ93Gx4df+atWf2oamNLbtanKItmnd9S5+1HAOOsOQUvoAD5QmEbMAA
 AA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5634;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=XYSgb73hB3d8RqvjmbchOBVBftlKV9zjuBh3hfLX6kg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+TWpVmYXV7x8zyTQ9z/y/s6JqlNu6+6ZV7+j2OuE
 03OsJyN6ChlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATCdnLyNBp8sRx+esZU6f+
 Pl0Vev/wnXN6cQnprz/O5TaL+Fl/8pkCI8P8Vac0VvH/FbT9mi4WlcjtdKrGu2N7zJebQsfKwuN
 y9ssBAA==
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
 arch/arm/mach-snapdragon/board.c             | 253 ++++-----
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
 drivers/{smem/msm_smem.c => soc/qcom/smem.c} | 777 ++++++++++++++++-----------
 include/dm/uclass-id.h                       |   1 -
 include/smem.h                               |  90 ----
 include/soc/qcom/smem.h                      |  36 ++
 include/soc/qcom/socinfo.h                   | 111 ++++
 test/dm/Makefile                             |   1 -
 test/dm/smem.c                               |  26 -
 27 files changed, 1186 insertions(+), 728 deletions(-)
---
base-commit: 2920b49fb117dd70b6219804bf0d298c96f184f2

// Casey (she/they)

