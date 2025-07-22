Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B1C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 15:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DAE8338C;
	Tue, 22 Jul 2025 17:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t2gdDhR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A40CC833E9; Tue, 22 Jul 2025 17:35:09 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F060983253
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 17:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4499981f8f.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753198506; x=1753803306; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IkuGE9U2ReUJ55J7fEJLdlGq9oDX9TLbKTEjCkN5m60=;
 b=t2gdDhR/8DVpHn5yF/OyAOsqskhtyvYkolptVpszEB0kWFCtK4Jeg9hJNSBkDS1l6H
 s4h/6gRLIW+JjlPgUqz56pHMs/Rm+ggilvuLzv/1rYGci9E5aIIpmTzgjUtEwz+TnyHy
 lx7S0/EdSgaYtXrV//N530ExwBzN2e6ToVo5Xs5Wzd9ovMACLvbsloz310NLCmS6miEP
 I5jkmmL2kXGMVfCXh6XWm4jCZ3diqERxd+DLnsIniPmZNX5vFM34/o9C8Y1qhNYalrhB
 t9jQW9jLczzOh6V6w+i5mOo8LhQuq9Ftxj2l04jNp7gtzoxatGi4Z5nuEi1Zu8PcUa1N
 AqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753198506; x=1753803306;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IkuGE9U2ReUJ55J7fEJLdlGq9oDX9TLbKTEjCkN5m60=;
 b=BbNdibGlKhaU9R8K6BkRywXQfCnR6CQlMNlouGqTw0n7I0ZbqJqSpRHMSUycJd1r3I
 2QBaNcm08VhmyvaELMdelXX74+PuBk8+3qUAtesjSyglxYzs2kRxzXIU7kpBbOHyX5Nt
 Us/N3mKVW7yOd8c/fDTDbVPOJT5oQs53mV+TJS2XdAUXeKxnAejviwGcI00zLsuqrXrS
 eusv21Z+Whcuw0kCHQWtPlrKNac4CcXpkPCp8dZEV0PfXIgHD5gOw9H2iYzucW0w8D27
 qiBu4kUPJLEYGBA4ib11Jjl5Ji//+Kj34f49mvFCpwep/xVcqLBbw3++3rtb7n2uE+sU
 0BBg==
X-Gm-Message-State: AOJu0YyDxCehaLWl7axErr3iB8Qe+mU72ObLBqQO51mQThFUTM+F1XDw
 UzR6Xd3V7MvQH9dFLdTybch4EAotT0p1zak3tkYilX5XRfIgUplh8FToAgnxu5CdY6Y=
X-Gm-Gg: ASbGncvzeNpbxdlpIOYP80p6ItktB28KLqSLXVMu7Zn5Hhlj8t6UouIPLXaeeNqO5lt
 Q+I6+vmCMaBToJysodYYIVujpqZkIc64rtAScIoFnclgtBub1Vxs0sPRI5KQm6muumPibVFi/BC
 q4NcdQtcAiZskwfH6Y/B/gzZcc3w7UepKOMdLWujysR8dMmISWjGuFrqyksGzP3ET0es5xDy/rY
 I2po8GBtcML87y1K+TZ7IpJhKTksvryOvZpywzEOve0xcJJXp+gwHtq7TrXH+uXylnr9Ta4OMxJ
 7+Tmj6dbjNwtvco+iGuPMdXvjRVYUfg1/AMYpvPMTXgCmvKWla5MBWQ1/wYsS+DGXWbwp7Gq4Vt
 U+6WZ6VRViHZRxIK9jaRChr5UKF5In+4rMuCE4QmVSTcl/MhHSX19QzKssIIY15d7qw==
X-Google-Smtp-Source: AGHT+IHIbSS+CRK1EcLhrL6DHd3roXW4t73MdW3e2kC7zj6ZjWOOl/wGRvV89QDBAP4otXL53z5jOw==
X-Received: by 2002:a05:6000:41f8:b0:3a5:300d:ead0 with SMTP id
 ffacd0b85a97d-3b60e524366mr18222757f8f.43.1753198506235; 
 Tue, 22 Jul 2025 08:35:06 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e886286sm198716285e9.26.2025.07.22.08.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:35:05 -0700 (PDT)
From: Casey Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v5 0/8] Qualcomm: teach the build system to emit signed ELF
 images
Date: Tue, 22 Jul 2025 17:34:50 +0200
Message-Id: <20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJqvf2gC/43NwY6DIBDG8VdpOJeGQVDsad9jswfAwZJUsWDIb
 ozvvuil3fTgHv9fJr9ZSMLoMZHraSERs08+jCXk+UTsTY89Ut+VJpxxySTn1Aj6sGGgcwh3P/b
 UD1MMGQcc50S1EUwqaQA0kEJMEZ3/3vnPr9I3n+YQf/ZvGbb1n3AGyqgCAUa1UlpnPsqNjuESY
 k82OfOnVrMjjRfNNh20lnVCq3etetHgSKuK1tSuEtZxqJG/aeJVqw40sWmowdaqaVqn/2jruv4
 CbuB5YbMBAAA=
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5623;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xplAFysAW8dNvCt4qGwpK3CQuUsj/Bk/PPB0P3/V90I=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhoz69cs9DM/WKX1rjIm4qbnsfqK1ycQnTLLdAtbhR462s
 nAaGGp0lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgImUCzEyTHGKf/Z+6gbut/0K
 2ufijjt7Fk8J847/FdXo/WfVWZaTRxgZep9LeJ3Oa2s97v/Q0yr42Cfblx0ccou7Zsd/3rM72+W
 hCQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

During development, it's become clear that BINMAN_FDT has some
problems, it's selected by default when you enable BINMAN which doesn't
feel sensible, it enables runtime code which on Qualcomm platforms
actually causes a crash during board_r init since the binman node isn't
present... Adjusting BINMAN_FDT to be disabled by default is quite a
lot more work so for now I think it's best to just add an exception
for ARCH_SNAPDRAGON.

[1]: https://github.com/msm8916-mainline/qtestsign

---
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
 arch/arm/mach-snapdragon/Kconfig    |   4 +
 board/qualcomm/debug-qcm6490.config |   5 +
 board/qualcomm/debug-qcs9100.config |   5 +
 configs/qcm6490_defconfig           |  10 --
 configs/qcom_ipq9574_mmc_defconfig  |   1 -
 configs/qcs9100_defconfig           |   9 --
 doc/board/qualcomm/index.rst        |   1 +
 doc/board/qualcomm/rb3gen2.rst      |  25 ++--
 doc/board/qualcomm/rdp.rst          |   3 +-
 doc/board/qualcomm/signing.rst      |  43 ++++++
 dts/Makefile                        |  19 ++-
 lib/Kconfig                         |   2 +-
 tools/binman/btool/mkmbn.py         |  29 ++++
 tools/binman/etype/u_boot_mbn.py    |  53 +++++++
 tools/mkmbn                         |   1 +
 tools/qcom/mkmbn/cert.py            | 127 ++++++++++++++++
 tools/qcom/mkmbn/elf.py             | 238 ++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py         | 281 ++++++++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py           | 173 ++++++++++++++++++++++
 22 files changed, 1015 insertions(+), 36 deletions(-)
---
base-commit: 71b3cd3c8908e9b2230de4f4cd24d4ef7e5a1679

// Caleb (they/them)

