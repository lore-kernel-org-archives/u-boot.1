Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60178CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14CD484099;
	Mon, 11 May 2026 15:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ck9tSGW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B808341A; Mon, 11 May 2026 15:57:55 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD7A48341A
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso6440619a12.1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507871; x=1779112671; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cZTQG7BVV/XwH69gTUlODkI3FSzWxryqON8imo3iMuA=;
 b=ck9tSGW7Ms1/ie/XheliFRBsLuSmwVwNETRPbbzTB0eyJiZEwQqpTx4uVzG7DpJWbp
 FooqVMzuxKsCbOcyZ8ZFOwh4qL7rNqmfbCR7T3ehlTDba9BAxeN7N5XyK1Vz9T9STMo8
 OQv+X0oIzEAaC/s8U8nRHhdA5qCijOwQc8BptUojMs1zjccmF5nJrqEVkiyNSU+pTLQm
 LPlaURIlr+XLYMA7Cw4qbe85Wj5JZfqnBA9RsniwcNuqpToZyqevvXcHEq1c3ALv9FM2
 XcfOjK90tyke4teYJHB/jSa8wO85rkZY7/ygCtXClexhUMLbbPC++0ZTCYIOF6r9crcS
 2ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507871; x=1779112671;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZTQG7BVV/XwH69gTUlODkI3FSzWxryqON8imo3iMuA=;
 b=n86ZZxo9VWIjZsM0q8qBMFJVSFEq8Nb5f/8CIjanKmYBQGcHS+L3oQfn2PXDyqzWSw
 nm2qyciwENNnCxtqzBvpS43SgPZ05LLAElnsutTAL2qGwqEv0fpyZ/oXDFe52txdfu8V
 kdny41fgIcHIRnKebn8jp166YT6FUKUK2b+RoR+wW4/mayyxgnrWzaajen1efNlkq14E
 jkbNTfNboCPu+cfNqcueKV6ngv+/CGH8pbsh2ocQlV+Kc0yzrdHCtsSGk349TXdAEcLt
 OlESpmEnV9d5ybNquQcqaWrTUz7AQ5JiMxDCGmLlq/PiTI82Gn4ozdh9Eam8judGkM6t
 WBbQ==
X-Gm-Message-State: AOJu0YzvzoSzj6DLrEKZIW9AaLNn+xvaPYn6yegNfSkTs8szEwz+2Oee
 ntRmr+f/VuuVLfgEMI3iLkUeaMmkbMdzEWLdmNoiNiVZ8TCPIYk9cP7aPocp+LHlm+w=
X-Gm-Gg: Acq92OEkIyr13SlZ2deNl/nu5d9Hv11Y1BO17bfjAknu2BX0eqzlEfUBoOwrd1NPUg/
 I7hDTO/Tu/98SZlnkgoLRHyY6Il56MUcWDGat8DKfb7/mIJIqOCbwDDQNGfgeAMphbuimVsXunE
 p0Fp2aZ+rotgo6Q0Ehhr3ImblCouZZQR+LndGGAf5hIix8Q2rd5NQKhcjPr7VTO+jRTx1ltBdCP
 h3Q3p0Y2LClv/7JcvBuvjpFsbbTYi0rK7bXORfSJCmC/QT2gff03vhx/ZMlBXtba5d+t4aOA2n+
 p7WnGl3fPrmraVzr6PeNwMejyQkiyWnhWD+vPIiblmNrF/I25FtehiFmkhQtzfUTxkyo5pH/9lD
 EvrClsCa+i/LHRwTKQf0IprUXu3fdq5YtQPy44BLC9xfRI/PLsvAvlSi/C4ldT+6rXJSGDD06/r
 6kwgiyZbRmoVjILRZs++5WA+5yB55dHHUZnXjKtlTFldNai5Nawc/J79oZDB5lwl7XU7VKrbUlZ
 UpoEQpn49Ni2mv9Uw==
X-Received: by 2002:a05:6402:278d:b0:67d:d904:df2b with SMTP id
 4fb4d7f45d1cf-67f706f8439mr4201910a12.7.1778507870701; 
 Mon, 11 May 2026 06:57:50 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3805377a12.14.2026.05.11.06.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:57:50 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v7 0/6] Qualcomm: teach the build system to emit signed ELF
 images
Date: Mon, 11 May 2026 15:57:42 +0200
Message-Id: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43RTWrDMBAF4KsEraui0b+76j1KF5KscQS1lcrGt
 ATfvXKgJMULdfmG4XswcyVzLCnO5OV0JSWuaU55qsE8nUg4u2mINPU1E864Yopz6iX9DHmkS84
 faRpoGi8lr3GM0zJT5yVTVnkAB6QSlxIxfd34t/eaz2lecvm+ta2wT/8Jr0AZtSDB206pgP617
 riSn3MZyC6v/K5p1tJ41YLpoQusl84eNfGgQUsTVTMahQzIQUd+0OSjJhqa3LXoIGhrTIfuoKm
 7Zpp3U1XrEaRA4NJgOGj6V9Os/qGh6ao5hV4bgdKh/qNt2/YDgQyLbE8CAAA=
X-Change-ID: 20250522-b4-qcom-tooling-improvements-ab40585b11a1
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6063;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=fr73Rd0KShG+L3OpWRM1gQKTQxLfe+toKgqdJzdk9wY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizGBzFiSyce4Q5ksN2RxVp2bsLxD0pdzraeF6+EfFpXW
 aPz/8b6jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAnCRPwz/7HlXNnUwNTIVzuG6
 IbrxgurCL/r3r7Is/PiF8fW/P+aOrIwMLUURHqobJVTjnRc7LUnZNuW23v2TXFsnb7n5bsGK3KV
 O3wE=
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

Currently the build process for flashing U-Boot as the first-stage
bootloader on Qualcomm platforms requires a manual step of test-signing
the emitted ELF binary with the appropriate settings for it to be
properly accepted by the pre-loader.

To address this, let's introduce a new tool "mkmbn.py", this is based
on the existing qtestsign[1] tool but introduces lookup table that maps
from a boards DT compatible property to the load address it needs.

A new config option (QCOM_GENERATE_MBN) is added so that
BUILD_TARGET can be set automatically and avoid the need to manually
specify the target on the cmdline. The make target is added in
board/qualcomm/config.mk with a minor adjustment to the toplevel
config.mk to properly check this path.

The various platforms which currently rely on manual post-processing
with qtestsign are adapted to leverage mkmbn instead. New platforms can
be supported just by adding an entry to mkmbn.py with the same data that
would otherwise be encoded in the qtestsign cmdline args.

The Qualcomm documentation is also cleaned up, a new "signing" page
is added to briefly cover the what and why of MBN signing, and board
specific pages are updated to explain the new build process.

[1]: https://github.com/msm8916-mainline/qtestsign

---
Changes in v7:
- Adjust config.mk include to include both generic vendor config.mk
  path and board-specific path so that both can be used simultaneously.
- Also enable mkmbn for db410c
- Rename db410c/820c defconfigs to have qcom_ prefix
- Link to v6: https://patch.msgid.link/20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org

Changes in v6:
- Drop binman in favour of introducing a make target and associated
  kconfig infra, this drastically simplifies the tooling.
- Various minor fixes/improvements to mkmbn.py
- Link to v5: https://lore.kernel.org/r/20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org

Changes in v5:
- Rebase on master (dropped trogdor chromebook series)
- Directly import the MBN signing code from qtestsign and then adjust
  it in a separate commit so it can be updated in the future.
- Disable BINMAN_FDT when ARCH_SNAPDRAGON is enabled
- Set default value for BINMAN_DTB in mach-snapdragon/Kconfig rather
  than having to set it in all defconfigs.
- Add a comment to the top of mkmbn.py explaining it's purpose.
- Link to v4: https://lore.kernel.org/r/20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org

Changes in v4:
- Rework how qtestsign code is imported to make it easier to sync with upstream in the future.
- Actually raise an exception when mkmbn fails in an unexpected way.
- Link to v3: https://lore.kernel.org/r/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org

Changes in v3:
- Fixup Makefiles and add missing qcom-binman.dts
- Adjust wording to reflect changes to build process
- Link to v2: https://lore.kernel.org/r/20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org

Changes in v2:
- Reworked to use binman with a plugin to build the u-boot.mbn file
- Added some fixes for binman to work with OF_UPSTREAM and with tools
  in the srctree toolpath rather than objtree for out of tree builds.
- Link to v1: https://lore.kernel.org/r/20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org

To: u-boot@lists.denx.de
To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>

---
Casey Connolly (6):
      config.mk: support vendor generic includes
      tools: qcom: introduce mkmbn library
      tools: qcom: add mkmbn.py
      doc: board/qualcomm: update docs for new u-boot.mbn target
      mach-snapdragon: add kconfig infra for building MBN files
      configs: qcom: use mkmbn and stop building ELF files

 Kconfig                                            |   1 +
 arch/arm/mach-snapdragon/Kconfig                   |  11 +
 board/qualcomm/config.mk                           |  14 +
 config.mk                                          |   8 +-
 configs/qcm6490_defconfig                          |   2 +-
 ...0c_defconfig => qcom_dragonboard410c_defconfig} |   2 +-
 ...0c_defconfig => qcom_dragonboard820c_defconfig} |   0
 configs/qcom_ipq9574_mmc_defconfig                 |   2 +-
 configs/qcom_qcs615_defconfig                      |   2 +-
 configs/qcom_qcs8300_defconfig                     |   2 +-
 configs/qcom_qcs9100_defconfig                     |   2 +-
 doc/board/qualcomm/board.rst                       |   2 +-
 doc/board/qualcomm/dragonboard410c.rst             |  19 +-
 doc/board/qualcomm/dragonwing.rst                  |  14 +-
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/rb3gen2.rst                     |  30 +-
 doc/board/qualcomm/rdp.rst                         |   5 +-
 doc/board/qualcomm/signing.rst                     |  29 ++
 tools/mkmbn                                        |   1 +
 tools/qcom/mkmbn/cert.py                           | 127 ++++++++
 tools/qcom/mkmbn/elf.py                            | 241 ++++++++++++++
 tools/qcom/mkmbn/hashseg.py                        | 356 +++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py                          | 165 ++++++++++
 23 files changed, 986 insertions(+), 50 deletions(-)
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6

// Casey (she/they)

