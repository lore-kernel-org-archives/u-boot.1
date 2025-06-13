Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B741C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 17:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B68C82D2E;
	Fri, 13 Jun 2025 19:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qeGzYNZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F7882D21; Fri, 13 Jun 2025 19:23:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFFC82CE7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 19:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so14760895e9.0
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 10:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749835389; x=1750440189; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CiZBoSy5e7DcOqC98Kiu2xEAniXAlRTMoulWltnlDig=;
 b=qeGzYNZmtj2l/X+VCXVfyhvy29JKUWzzCqiZZiJN7Qvsv/mDHVQQqDDOkCngJk3BIO
 xfsMaMO7/M/hrPHBwyASsngR5P83CrbOFs2C5eYSB/VBY9BG/EUpf4d4kvvTAFhGB9j2
 EzD/l3uaXzP4XjiWEykqF9Br9XIz7P3IsgUJ0MWdHcGTtRbiPJI0xgrTc6Bbx9LMM/6p
 6NU+uGZaXWInhILG+N66fKCOlPcQ08lTzWVhmZBqbgqmRyUV0kTU2ADiBBagK05ls6sr
 uFOo43f+4D7RSZaakuz7JxCtocVYkTFi1d5fYRc7v+nk56Y5iMEcpwcv1jxJ5F8t1Nt/
 ZmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749835389; x=1750440189;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiZBoSy5e7DcOqC98Kiu2xEAniXAlRTMoulWltnlDig=;
 b=PCNXld/z7mTzX863EbnOrT6CWYNoNbeKs1Skr545xOyj7AsAltQJPzPdxe4IzcDcri
 StVfa9cr4uQVclT+MkVoqQoN/xrXFIPsOlxzxEeIfBb/Ow1U788beVVGLv6GkK+0mBFr
 8oKNgvbkaiDQSurUfkZiodFj2/V8g8Hu2ZeDVSzr/R4UJAaIQf7v3RgmPBsDSi8ujWG2
 sAfKAfQ84RPhZuK0zAVl+ZSIGcWzrAqdrbrms4zcZEYZB3UtNeNHr412JHMWgMveFroH
 47APTLOgmqtv74Uq9jcbG6BCtSYSLL5F6zEoPshUXcl0a0Cs0B8Pbt+0U79SwVc5vWOV
 3Gkg==
X-Gm-Message-State: AOJu0YymzOUqVlgEm+kRR/irY5WgEhCJQOqmAt99mNQByvKCYHBQ+JHj
 tIWgog1u+EMXtaw5Yt38lwoNCsE03R2b5FOEpITH4J7dije0jeGGw4P9ByzINcvzFuOFkSpQQ/Y
 nSeo1
X-Gm-Gg: ASbGncvcopXTQQ4YCtq5pS4be34hZndCzxNsdCJphxo5KEddShKTQNLaLrMuBRDwNfz
 PRNUetipYGZCSGRr74Sf0Gp91A0RNLFv8cKR6pjRn6DioiBMWBwtsunZSlpj6d3psDtjYGKivn9
 s4Uk6fU7Pm+Qa2ny4FHtp9LBd3TLv7TeayUrQTsZ0F6L9++KWak8r52W4D4reyhVYjwgaRfrwg9
 iTb3L6LUoI4gBx7XUVRvQvj7lLiD5pWESNeAIIN/zgBIDatxq7inmwtCR4KD7Tzqfa+iiq0WA2u
 dlll+n3XP5+UdMRcM3CdDcdX6tHrjpwQYIvuRskSJz985sfKRzSmYRKL8r3rQBa7Wr99
X-Google-Smtp-Source: AGHT+IGi7JNiuIsWkqk0fk7Z9twUHXQLjuOeccR+NMuOL5WNHHZ1jzrqdP5PSwqwHQC9cs6eR5QIHA==
X-Received: by 2002:a05:600c:3589:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-4533cb0013cmr4628115e9.31.1749835388796; 
 Fri, 13 Jun 2025 10:23:08 -0700 (PDT)
Received: from toyger.lan ([2a01:170:117e:fc:19e6:b5d7:f8b4:a927])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c50esm57895015e9.4.2025.06.13.10.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 10:23:08 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v4 0/8] Qualcomm: teach the build system to emit signed ELF
 images
Date: Fri, 13 Jun 2025 19:23:04 +0200
Message-Id: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHheTGgC/43N0Q6CIBTG8VdxXEfjICh21Xu0LgBR2VIMHKs53
 z30ploXdvn/dvY7MwrGWxPQKZuRN9EG64YU7JAh3cmhNdjWqREllBNOKVYM37Xr8eTczQ4ttv3
 oXTS9GaaApWKEC64AJKBEjN409rHxl2vqzobJ+ef2LcK6/glHwAQLYKBExblu1DndSO+Ozrdol
 SN9awXZ02jSdFlDpUnNpPjV8g8N9rQ8aWXR5Ew3FApDv7RlWV4+zqxZZQEAAA==
X-Change-ID: 20250522-b4-qcom-tooling-improvements-ab40585b11a1
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5070;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Ra533MgWpoMKTKuq8xjKQVla0qOjlBRaFXLrCMxboGk=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTF56jdQrtwjqoNNNZssO6kAsrzUSIOywwtPww
 JNBymPNVj+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExeegAKCRAFgzErGV9k
 tgmUD/sFGJe7uA8mxto7/sggj6XpVOZI/lr7qzHyPHfyCfPEaseisTd0CJEUuN18xKNVnSQXOkm
 AI/2QpqcHpm/uhuqRDSBuayhkWdgmM2mocVDvtV6zAxhA0l8e7sUTOr/ODlIXSGCD5vff9biNUa
 XRzs0VBP1feoP5FGbrVZq7pY576mP0JYEH6lpoSgiJsRLWgihDcfye2nArZD6kybNux9b5nyH9I
 yunwIrT9mP2rakyQEwb7xR1Iu6L8vrehIE7cBc1W1lGTkO2gE+UDJDh9kPGawVRAZmIPvKzuxFA
 dYCrT8g/awjjbd8rSAU51ksta6klWnETJ649SrWnjNmDdm4Beegu4Tv2p9Z+vBUkAwf4Xnap4d0
 RidUT02K77wdz8+Zn8QFkrdu82znH0Gaclr6sWqG/F1W2ClmYYgT2gGzXJdWCyFRURZLbQiBPjr
 9CwnBzlNOguTW6w8124okmNi2q6aDz9ZN+kk+zclPJWFuruHtH41xRxl7gNvoNp/qcvo6G6SPLB
 d5JwOa1DG7oeunPwo21SuQMELwnpCv4DFVoQbWK33C/0wfklv3865mPYsmWb//8qkqMMWZM6z+u
 QRsX4tBKtizmGADJBEXNuVNu5ZVZLxZcXvZni3alJCDSL7okOgUuwtfqCaejcs4pwBFuhv/VVGi
 BLnPJjMb1GtqXgg==
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

With several new Qualcomm platforms appearing on the mailing list, all
of which build U-Boot as an ELF, sign it, and then flash it to some
partition on the board, we're getting a lot of defconfigs which just
contain a debug UART and a TEXT_BASE address. This leads to needless
rebuilds in CI of effectively the same image, and needless duplication
of build instructions.

To address this, let's introduce a new tool "mkmbn.py", this is based
on the existing qtestsign[1] tool but is (currently) hardcoded to
only handle the Dragonwing and IPQ boards which use MBN header v6.
Additionally, the tool contains a lookup table that maps from a boards
DT compatible property to the load address it needs. Since it's highly
unusual for different boards using the same SoC to have different load
addresses, generic platform matching is also done (e.g. "qcom,qcm6490").

With this tool in place, we teach binman to use it and introduce
a qcom-binman.dts file to describe the image. The tool will emit a
u-boot.mbn file for supported platforms, for unsupported platforms the
u-boot MBN etype in binman will print a notice explaining that no mbn
file is built and to look at tools/qcom/mkmbn/mkmbn.py

Finally, the defconfigs are cleaned up by moving the debug UART
definitions to config fragments (since it doesn't make sense to have
them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
the qcs9100_defconfig is removed entirely since the same binary can
be created with just make arguments. This platform entirely lacked
documentation to begin with, which should be addressed by future
patches.

The Qualcomm documentation is also cleaned up, a new "signing" page
is added to briefly cover the what and why of MBN signing, and board
specific pages are updated to explain the new build process.

These patches have been tested on the RB3 Gen 2, but additional
testing for other platforms would be super useful.

[1]: https://github.com/msm8916-mainline/qtestsign

To: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de
Cc: u-boot-qcom@groups.io
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
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

---
Casey Connolly (8):
      binman: add $(srctree)/tools to toolpath
      binman: support building binman dtb when OF_UPSTREAM is enabled
      tools: qcom: introduce mkmbn library
      tools: qcom: add mkmbn.py
      binman: add support for building Qualcomm signed MBN ELF images
      configs: qualcomm: use fragments for debug UART
      qualcomm: use mkmbn via binman and stop creating ELF files
      doc: board/qualcomm: update docs for new u-boot.mbn target

 Makefile                            |   5 +
 arch/arm/Kconfig                    |   1 +
 arch/arm/dts/qcom-binman.dts        |  16 ++
 board/qualcomm/debug-qcm6490.config |   5 +
 board/qualcomm/debug-qcs9100.config |   5 +
 configs/qcm6490_defconfig           |  10 --
 configs/qcom_defconfig              |   2 +
 configs/qcom_ipq9574_mmc_defconfig  |   1 -
 configs/qcs9100_defconfig           |  10 --
 doc/board/qualcomm/index.rst        |   1 +
 doc/board/qualcomm/rb3gen2.rst      |  27 ++--
 doc/board/qualcomm/rdp.rst          |   5 +-
 doc/board/qualcomm/signing.rst      |  29 ++++
 dts/Makefile                        |  19 ++-
 tools/binman/btool/mkmbn.py         |  29 ++++
 tools/binman/etype/u_boot_mbn.py    |  53 +++++++
 tools/mkmbn                         |   1 +
 tools/qcom/mkmbn/cert.py            | 127 ++++++++++++++++
 tools/qcom/mkmbn/elf.py             | 238 ++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py         | 281 ++++++++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py           | 154 ++++++++++++++++++++
 21 files changed, 981 insertions(+), 38 deletions(-)
---
base-commit: 783f365c9dbb5c9e9341753fbad6a44dcdc7a069
change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1

Casey Connolly <casey.connolly@linaro.org>

