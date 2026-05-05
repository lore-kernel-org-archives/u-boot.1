Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688FBCD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9216C84968;
	Tue,  5 May 2026 17:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K5Ek8PNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0886D84951; Tue,  5 May 2026 17:48:50 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86678848B7
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so52483945e9.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777996127; x=1778600927; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S/7gda3sNAl11QWNRJuwPtWRqAGrJGJ4ta8DK+rxbMM=;
 b=K5Ek8PNGxTfvHcFO3JQd/Xb/Kk53IhQH5y7gA7nCpTJX/6jCJJ2Hhf3ImBJQvgy0Ww
 OwcjLRY1yeg3qSMY9x00hTov+nAPn2wgqQEfhSHxKQ146svPmorVLMMMJHDrvsz1K7Ua
 5XrkVkbwwv8DlJFZGunYUNnO/EMA5rh657SWvZoZVyAnBD05cJ9BZnU9ueNSpdRgKeze
 MCmwic+NG5JnGoJZzhDP9VNhhf21DZLuphuuSIpjZf34uUcHMWfmXqsp7hBiRSu0B8rI
 qEityOEPUoeaIfSax1UYAFOm8AGK/nFHg2Vyvcj3d9cndTRkysstPMhANlgSkSGK6289
 Jq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996127; x=1778600927;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/7gda3sNAl11QWNRJuwPtWRqAGrJGJ4ta8DK+rxbMM=;
 b=gw+w0nsrsx+I0oevMb3WQK6PjQ+GjHZiGEM8AszvN82+To5jyL/hwzPCzGifMgE8Wg
 VXNYNNwAU4YGYtJXtUrdscp+zzNePBpbHOn1U343CJ64YLx2hcl4OSFhsMtodeBxD6al
 rmlBEyZ7NCz/AJXfwaJPfF08I9UASp5+DwWX2uU+GcETSQIILCwGgx5J4lzj/RyHldk5
 /aS3D4EdQs7tGaStuLQMYeEtiaacEx9zzfYrqF1lr+FtcGHA2EdQJ/YnXeCVOzo98sl0
 +swLPFzmpT4N2O0NpHwVmpxUFru5qCkwTAa6NSzMubHxzFe1gjw2GSAeGCxfPysntkqs
 sLFw==
X-Gm-Message-State: AOJu0YxQHNLGYFpFj3FoxRjHh6iJrVE/JCfialZaBbLSoqm2GlK6yVVV
 jkoEp4gt6lhPICVxc77nAipQPw9LW5ZLhz9qJtt6Vu8XBLcLFx1ZoYzPJ+4SikQAoyc=
X-Gm-Gg: AeBDietRSMR7ANvttjn72RZsF++sefTa2qRL+scqF8UuVRcJELQEh0hpX92Tq+vBCZR
 FqDGTTOBAjHQVeJzjZuuPqS8HncJ3ITR5S0UT3C5vUeyaBaJbaXqk3zvIpOkYOaA+wr4b5lLLAG
 6nIHMMpcVPLODXpAGK+gQH5t+P2DdRcnLHnT4Qn/cKcoPucLq9/ggWwYkt2WTV/ZvjNUFm9917F
 sO6DJ/WGLD3iEGbhQWTmTfv1YOygq2BxDqYq1ENWo8n9eivzmwnyOr+icaHO8v1ttqkyZjXFgKi
 n3da/xa7NnotlpbgCo8wiemj50O6GQvGyWOqKbpdmJ2KOyAW8kW9h/EbV9KZJY7rNnPHQjLXWL1
 +ffOgCwOu0rW50/xvLsv3TfVNATa16qeCWdtQcsxfx5WSbyB6IPENwmnNXrZ1ek3Ne0nFOkLBFR
 tmiHwMqLUe3qLeGIeIIfRmRUwHL6ysjyYcSmS/r4MCIOKnM5XhBglzl4LPXFOIigXuyC96eE99M
 oHp3RQ=
X-Received: by 2002:a05:600c:c094:b0:48d:5c1:bc3b with SMTP id
 5b1f17b1804b1-48d18cef847mr46012455e9.24.1777996126856; 
 Tue, 05 May 2026 08:48:46 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48d182ee923sm20305955e9.27.2026.05.05.08.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 08:48:46 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v6 0/6] Qualcomm: teach the build system to emit signed ELF
 images
Date: Tue, 05 May 2026 17:48:40 +0200
Message-Id: <20260505-b4-qcom-tooling-improvements-v6-0-a5fb673f4af6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QS27DIBCA4atErEPF8HZWuUfVBWBwkGKTgIVaR
 b57cTZJ5YW7/Eejb6R5oOJz9AWdDg+UfY0lpqmFPB6Qu5hp8Dj2rRElVBBBKbYc310a8ZzSNU4
 DjuMtp+pHP80FG8uJ0MICGECNuGUf4veT//xqfYllTvnnea3COv0nXAETrIGD1Z0QLthz2zE5f
 aQ8oFWu9KVJsqfRpjnVQ+dIz43eauxNgz2NNU3JwLgLFKSnG42/a2xH46vmDTipleqC2Wjipan
 dv4mm9QE4C0C5Cu6PtizLL3a5GPEBAgAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5205;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=gDk+O/cApejPabkG3t6f4AAH6A2YOnL/5Uuja7iI4d8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsxfgjEhD59qr/s7qWZKkk7RWt8Lom/lf8oaFrtzclaqs
 67+bvapo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEyk7wzDf+99jt6XTq23Ne1W
 fc0pdelZdfrf6zatDZpz2CO/aUg8d2L4p3HP6v2qOg/LVHlJSbmLbRaqS/tFr70wSftkf2Ju1Zl
 /uwA=
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

 Kconfig                            |   1 +
 arch/arm/mach-snapdragon/Kconfig   |  11 ++
 board/qualcomm/config.mk           |  14 ++
 config.mk                          |   6 +-
 configs/qcm6490_defconfig          |   2 +-
 configs/qcom_ipq9574_mmc_defconfig |   2 +-
 configs/qcom_qcs615_defconfig      |   2 +-
 configs/qcom_qcs8300_defconfig     |   2 +-
 configs/qcom_qcs9100_defconfig     |   2 +-
 doc/board/qualcomm/dragonwing.rst  |  14 +-
 doc/board/qualcomm/index.rst       |   1 +
 doc/board/qualcomm/rb3gen2.rst     |  30 ++--
 doc/board/qualcomm/rdp.rst         |   5 +-
 doc/board/qualcomm/signing.rst     |  29 +++
 tools/mkmbn                        |   1 +
 tools/qcom/mkmbn/cert.py           | 127 +++++++++++++
 tools/qcom/mkmbn/elf.py            | 241 +++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py        | 356 +++++++++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py          | 165 +++++++++++++++++
 19 files changed, 977 insertions(+), 34 deletions(-)
---
base-commit: bb0f3eebb3c196d9b6efbbd1e5aa9b16abbb9ad6

// Casey (she/they)

