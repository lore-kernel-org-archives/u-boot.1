Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1860BC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 14:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF7F82BD9;
	Thu, 12 Jun 2025 16:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KnRlF+Pu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EEE82C84; Thu, 12 Jun 2025 16:16:45 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 086CD828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 16:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so8867915e9.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749737801; x=1750342601; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aES+m5vyK+UiXvywt+eHGK+mS5VwLOTRT1fkMEKa+wA=;
 b=KnRlF+PupCVe/XudwojKgEGoYVRHrHp6hyUYicyX3Zw67MdKV5GjgY6vYSWLqemdKW
 MiLsF/52HHC0zJolFxikZHXYhYNCkZLWB+jho6ck4bjYObD75GQmU4o4vq/W2D4kPR4s
 Ln7o29ZyAH9R8iDYZl7E7G6n73uwyqDnBnOYxYoiFONvnJt5qd4MPYojXXhhe2N/oBpZ
 QAg19cbPLfjlXr0GAdgtRjTtr5CK8fR67OOXONNuzoPDUNMVsu1qxWCQznp4kMIIxBX0
 MbcCpmpaNUuYaDvGhbiGvVoMt3v87YDMeDXBOrggL3lXECrNyvRbzBmC3A8NccIBb9x0
 Ut/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749737801; x=1750342601;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aES+m5vyK+UiXvywt+eHGK+mS5VwLOTRT1fkMEKa+wA=;
 b=PtYSjuQCVMgjyV6grSUuVXQUYdD3sCIhnrWgR2au9egH8pG+XevGTMLftRvsYBokm0
 7jb/7NzVn+W+6ddURr1+u2l/ZLJJ0JA5dKaOTldC9MOemWAQtThyp2EmRXoLHli5SXtR
 1p/nWVhNn0cUixUvzy5unjfYxFCPxIQIRjPxMV8ol7qtIxBV7oq9hXJ1xnXfZVUxN6Tk
 bFtg2vhYvWegPQw8MEq4+fB1+QeLJAOhKzh5VX3/+mPVY4q7hX4WChAWICWnD2vzx3wI
 dVdMCyD4VuXDJ27MFsWnvnnCrVaFO0r0plO3tdu51s8/xELv/FZiJhcGcyDpRR5Baev1
 qFtQ==
X-Gm-Message-State: AOJu0YyfpkzSCdbrc9FbDiVWyS8DMdnUReF3zcP6tcYVlVzN9gFbYy1N
 C29PnH4wQXOKOBTAugSwNk5bEPkoNRjFkvLxw8tnThdgL9hQ9OvUxllKfdg9VDGvP9JCPyHYU+F
 402Sj
X-Gm-Gg: ASbGnctak2xVrmprSPMfGFZ7ukF/6wmZ8FAEcBx3SAuiOlK5phSPargBW5mFrPb5vQP
 AtcUw4pjO4dxodTn0oQeLGjAJiOR8IYk2jvvKpcrgpCc5InkHTmX6IwxKEs3ESmVUbj4z4cluyv
 4VRs5EFV1/1arvXajT4DNh5PuzF3H7+qdaHYOMJm01pDJ9B5sYUC9AagrRbtLEYbvq1iYIpNta2
 k5QWRPhyjbf9yVh1s8yz9M9qYujlhkvnGhFmV6+SjaPPq578FrxolFznjOtEI/IhEck3ryyaM/D
 togUSvrHh9qlQ3mEdzMjHhBxFuQirdIu6OCSbaEWQGr4zD8VZjtkh2+aVY8BXfpuNqf/uuXL
X-Google-Smtp-Source: AGHT+IGnkomQOpbEdh2BAG9MwUTiqTddaYYK2sL8lDDGN5nvH93LHpMTcJ6xsrrBP5f12jziZPrIXA==
X-Received: by 2002:a05:600c:8b26:b0:450:d367:c385 with SMTP id
 5b1f17b1804b1-4532b9079cdmr45766575e9.16.1749737800887; 
 Thu, 12 Jun 2025 07:16:40 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561b510dfsm2044006f8f.82.2025.06.12.07.16.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 07:16:40 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 0/7] Qualcomm: teach the build system to emit signed ELF
 images
Date: Thu, 12 Jun 2025 16:16:36 +0200
Message-Id: <20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEThSmgC/43NQQ7CIBCF4as0rMUwCEpdeQ/jAihtSSxToSGap
 neXdmNc6fJ/mXwzk+Sid4mcq5lEl33yGEocdhWxvQ6do74pTTjjkknOqRH0YXGgE+Ldh476YYy
 Y3eDClKg2gkklDYAGUogxutY/N/56K937NGF8bd8yrOufcAbKqAIBRtVS2tZcyo2OuMfYkVXO/
 KMd2S+NF82eGqgta4RW39qyLG9aW7NNFwEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4741;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=8m82kRYa6qj6pp6gTUr6ITGfcfwcyXhlOERgKnrsyV4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSuFG+wspkA6DNsU7KZ+zTP/rKwH3FKQYLdY7t
 uWKZT7CJTOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaErhRgAKCRAFgzErGV9k
 tjJyD/oDaKweXVBY3zNAQhm/XbvYwjWNnvVESyrt1gbD750wExxfRo2urZPJ2ObQhZxmtKnN3Yh
 4F12u4Ch1TbRxr6A9MXxu4UOF++kO0RYG6qxKkCV9lbulgcLL0E/4fEnYnvSRqU7SrdQrssHqyP
 K0m7yqKeWU/NVTZPBdKMVE1EvcO49pRVjfBA2DCYsLGDEfLIcMJL4CDPFbdeyDAwxzphQ3PWSE7
 ve21IHBAH/QBDjho9SygFYpQTDlRtr4176jkOOvY59XI6h5mLaWv5HI9scfHWymKvLChFVWCAkv
 qB4NMB2tOq0LKvxrmaCbDh4QuDviynLxnfeqqJJ2Ybmt+AzLefbzcBTuTL3sYFn1dSbLYcRo1b3
 D+OhOcPzTQ0dz+daRH5quJNcQiUaWenUEc3fp+ka45YOY0A80YvXffpOkOTyZ8OurCw2qbOQEOS
 xftDSfhqJM5Bim68J89dCCok9rdqNjLWZ4VvY7p+8K6aClSYHlcK/SHSwlBEzHmyzG5mowsxVfJ
 ob2sLLdT2y849NLgEjKhdaYT4QRYv4DWMmajpQwAbTIJ1nMiPt/0NBHdutjTSaBeI9y96V82Vy5
 TUvIY0qluSn52wpvXTgyagyfmfy9gmgQINZBkwBjbWzJS4eZ22bwBhDKrCL/XlGKGZphBgj7loo
 PvkWawP3k2CS5EQ==
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
Casey Connolly (7):
      binman: add $(srctree)/tools to toolpath
      binman: support building binman dtb when OF_UPSTREAM is enabled
      tools: add mkmbn tool for Qualcomm
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
 tools/binman/etype/u_boot_mbn.py    |  51 ++++++
 tools/mkmbn                         |   1 +
 tools/qcom/mkmbn/cert.py            | 158 ++++++++++++++++++
 tools/qcom/mkmbn/elf.py             | 243 ++++++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py         | 308 ++++++++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py           | 154 ++++++++++++++++++
 21 files changed, 1042 insertions(+), 38 deletions(-)
---
base-commit: a1a56a09c3460341d9017373263742eefa63ecfd
change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1

Casey Connolly <casey.connolly@linaro.org>

