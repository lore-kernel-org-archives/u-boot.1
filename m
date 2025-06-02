Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42444C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 16:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7423D82012;
	Mon,  2 Jun 2025 18:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vEU1LmDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E5D9820EB; Mon,  2 Jun 2025 18:11:03 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C923581F32
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 18:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so1232013f8f.3
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748880660; x=1749485460; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=51HRknQg+ur4nkTsVqREK+QuhkzKDjRaJls54EBkv7U=;
 b=vEU1LmDV7uGK6rw455UovyJvpXLZ+hsS6XAPnijrKHleL8XBueGwKT0HcKHKeR7Nvx
 7CW2R/MVL9S1f5t2Kny2Im93KrwhwqqCUpuNMcnq0bOZz5rUVIDndf0+5PK+LtCIhmzL
 zdpKSE4jOySDabZk/PXo1+JlCAyqV9KpJ+E3IEl0HCkD1EQEFTWMkOHe/sJvP0sX1xZl
 he8PbDJKU0FGBL/v3wBNECfzWedLieLZw6u29Wg01u5OTCGDl19VJNK//1Uzz1CcP1zk
 +sMqBsQtZkssN1ip2wC/pJtDOVHXNn5ugAtFbx6Z0pSOGJnjjkrEbP8wM8BTWUr5ToTp
 bcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748880660; x=1749485460;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=51HRknQg+ur4nkTsVqREK+QuhkzKDjRaJls54EBkv7U=;
 b=wcmtA33NBkjzziLHuJNe+p1PjlSFkE1btAqke7Tdg6WZJgIKFAlPwtBcWLeMnKRd/0
 IDyNmEuiVgy6Yt7KmSqIjN/A4lD+BbsIr4X51I3nsPo3dAQxN11ttFGt6imNhqe1s1Xm
 AuHEEqqpgBXDe3TXbpECB5ErUwc/S2wqeIpNxkennW+XK5EIXhrUxWwwifN6Z8DCP3gE
 tb1jiVsEO/dtepNWkzuGAHwvFlVl+hGUwL7FdF/K75IXzaafJp1G4IgVCv+eYNHgSlsF
 llqfkgT3/13FTs/eVJgKrILyS4DzxLicFDoMFYfVneT4Q3y7KdNNfy5RUUKWV58UiwFO
 MMtA==
X-Gm-Message-State: AOJu0YwT7Ai1lhGk/TUBVjRkS4TPkmwFdsmP++ZC3/PyqM9gMh4cgdCK
 Zr7jkqEBXROBdW+9ac7u70rpHpvwTrHJRkuOWTj7LXZlVuPrz9nh48ZMJUH0h6T9738=
X-Gm-Gg: ASbGncsD5jMujWhwDmfkXjT7vAX6W+ZQWphryJQjPrpSY4svX7ec04nTr4r1aO7Edmr
 D70iwfDHEYhzYfIst4Xz/zryLbZ98a8Gm1bgFKjvApf077XHKSP46wqdWAJUJxG5+mit0yUmME8
 PbaX97EZr34WMLmf0SOueXqz3hoN9UWVaaRZhCSyQiBTLp+PP/9SIutizFAhlsowLyVJVhiPQ09
 3DsoVoxsdJls47jgcRT8BFgACMQm32ZCXpElLhPL90Iozx4Ujh+fZgG5nrgCDlLW21qGKS9H3Tk
 hkmSv1Fe74VGZet9v20te0EhFW2mBYwwme14XaT5ndHpcUH8sOozKBDDy8BYRl9KwQLlCog4f3n
 XooQPco5J87Ux
X-Google-Smtp-Source: AGHT+IGQGtk+ahzgnq6YNj/ZiTAwLPUArBlPgYKhw2/Mxl3315u4Bxs1lI11coSgoBwNhLdA29LHvg==
X-Received: by 2002:a05:6000:2313:b0:3a4:efc0:c90b with SMTP id
 ffacd0b85a97d-3a4fe17961cmr7139647f8f.15.1748880659859; 
 Mon, 02 Jun 2025 09:10:59 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:3688:a9e2:523f:a049])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b962sm15212138f8f.7.2025.06.02.09.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 09:10:59 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v2 0/7] Qualcomm: teach the build system to emit signed ELF
 images
Date: Mon, 02 Jun 2025 18:10:51 +0200
Message-Id: <20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvNPWgC/42NQQrCMBBFr1KydiQTGqiuvId0kdRpO2AzNQlBK
 b27sSdw+R6f9zeVKDIldW02FalwYgkVzKlRw+zCRMCPyspoY7U1BnwLr0EWyCJPDhPwskYptFD
 ICZxvte2sR3SoamKNNPL7yN/7yjOnLPFzvBX82T/DBUFDhy367mLtMPpb3bgoZ4mT6vd9/wIuW
 7DPyQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4370;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1gr4LYNBGLjGhZMfvzXrw6l0Xgl9d4DD0KD+WH6Kamo=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoPc0R1KzLkHGWKKVgcbN7hIP6P5u84QS9jXKxL
 XQSy/Vb/qOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaD3NEQAKCRAFgzErGV9k
 tkrcD/9XRR4c+NLzsOXsz32grw8sl/MsxX8E6uBgFzXlTB+5G6wwkBccdKoSgyemqmxOtgb4BUG
 VNt4zH/4h5zvQUd16bG5rW6HbCbIo3Nhi3pOQF6XnkUctRtoLKTyrQJn3+oTP8307VpgAifNYtr
 8Sn57D9offIlyFAoKBYDnXOy3YVdFq4jcnb7ZTcpOvMELZ/PaWvwilomMY7GAZzyXoP7pVrQMXD
 ihmt97WX26PwEVWoe6ItKao4JwH963OUpGkG4B8V367euMm1xzL63HoOo1kFmkdUNIS3qvPdT29
 OPtwovq2KWcZ1H6B9d6Ad6VilJqozu//sdIVNGWYApwM1KE+nIpYZq6FAMUTMg/eSZ4WDYBdolS
 73gxxfxX3gWB2H8DLWG9tDRhMwsJMj5txTH3SDjBc77CdLlce9mHev+7q+2WM3wCBKkJUUV3RLG
 IpyVdf6ps3HX7rG7MOiIEi+xWj9XIcdZkJ/anMLreQBNDfoLIe+QnqxeFobNYXXVcNLisNh5A5P
 hzM8Fq7JHN1rhURfVz+Ah/KbSH3XgsrjhAga5+M4GLth0mazJqCYBjk5YO7vCOCmh+GEo4jE8xZ
 N+3JK+MEb7J+7mEEdVqPq1QKhMVYZvTO856EIVwmgPy6pXJ3LRUsHiclO6PDk6e8vaGrF79YNme
 nuDvUL4HW99jjBA==
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
      configs: qualcomm: use mkmbn and stop creating ELF files
      doc: board/qualcomm: update docs for new u-boot.mbn target

 Makefile                            |   5 +
 board/qualcomm/debug-qcm6490.config |   5 +
 board/qualcomm/debug-qcs9100.config |   5 +
 configs/qcm6490_defconfig           |  10 --
 configs/qcom_ipq9574_mmc_defconfig  |   1 -
 configs/qcs9100_defconfig           |  18 ---
 doc/board/qualcomm/index.rst        |   1 +
 doc/board/qualcomm/rb3gen2.rst      |  27 ++--
 doc/board/qualcomm/rdp.rst          |  16 +-
 doc/board/qualcomm/signing.rst      |  29 ++++
 dts/Makefile                        |  19 ++-
 tools/binman/btool/mkmbn.py         |  29 ++++
 tools/binman/etype/u_boot_mbn.py    |  51 ++++++
 tools/mkmbn                         |   1 +
 tools/qcom/mkmbn/cert.py            | 158 ++++++++++++++++++
 tools/qcom/mkmbn/elf.py             | 243 ++++++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py         | 308 ++++++++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py           | 154 ++++++++++++++++++
 18 files changed, 1024 insertions(+), 56 deletions(-)
---
base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1

Casey Connolly <casey.connolly@linaro.org>

