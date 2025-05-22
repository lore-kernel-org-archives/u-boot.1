Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B59C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 20:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A058310F;
	Thu, 22 May 2025 22:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j5cKfgwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B836C83192; Thu, 22 May 2025 22:39:55 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC0A83108
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 22:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so105368285e9.3
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747946392; x=1748551192; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oAWTWRK+xm3/Xf2UemxyqakPRnyUKnSRQw7TXO9q840=;
 b=j5cKfgwDrvLkVJU4Qh4nFYG/D/nhHeXD8n9M+ufYUAfxtO+X0fYzTuc4qBFpvI6XSN
 EcsEK05As+e3RJzZwh0eRNP942VhaI0LoNxxeP/MXgS6b6Fl9N31rduW4ecyfnfbHCBz
 txUYdgKty888foqyEBSp8QGL3cc/HATcPGuv5oFRo+ptGTVana0q6jCcYjPypnpfgOqx
 50G1wZmMtJpmujKN5K3n3igW58JKmNLGaPpEPga7teFKXfHekhzx0I4Ce6dnS5HltEwD
 2rvQ+8aSQkpiNXm2C/JD/BgTjvZdIKMhH1H3NhSRUVr9JwcL/fQADZJIRg9WSMFzq22s
 DaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747946392; x=1748551192;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oAWTWRK+xm3/Xf2UemxyqakPRnyUKnSRQw7TXO9q840=;
 b=WWNLi/vLGJrI/hwSpLnpDkgh8kJ/EaUW/6Cdh+aBFdM8WOeSn5kiQ7qOJdMCp1qx6I
 1nbNAuvGVfIpKyj6dTjdAd91i+3CMCmRObcMjCfY/2fwMsAeKQqjOojxSiMGJsTi1RsS
 T/D6KR2W0MVYqkDk4fruCVxnx61nNkbqda9XPStnxHhM6j1cTCPMVMWCbCo3+4LYNo62
 2SVNY/OlpjoLkIS1R30SpdTF+oKuC3ZmMd6E0uNslBrZY9R5uzqnswLK0jxFis5/yaDT
 dGwqLWPcQYhE6BAXeOcFPxHR5Zi3bD7Y7ERNKsrFYVB4miYnpSptL8UTKVviK65UhgqG
 pIzA==
X-Gm-Message-State: AOJu0YwvG1XJD+nsZvX++bwFQm8ChdkJvPG7xbPNlkotZb6i9Uzjz97/
 ffEhnwyo4ouTz1FN92BJj3YK9KVFuqPNoboNfwVOZLRQaJ5tOoy6ivoHx0G7jQ6ApMo=
X-Gm-Gg: ASbGnct0aOJMWn1nM4CKiycoWIBR9JU02/r9kj5AFZshRIs031RlfInH6UY3EKWcvNJ
 JQWHry6OfR5OOxu8GfY8Bj1G9SHo9+cilgTvGne3EfB1Prt8cgb12/qsZPBfgz8xzWx7E5dy9XU
 DkItR0cY3BnxQyRMHVBYS1xYzgahMbtke2rro+LTpGOYaVW+uOfn67jtH2QWBu3vnCLuAVFnPMb
 I/Xir/biwfABTNZLgXfP7tueDqa/qWjG3eN3584zP/FFcenX+3Z2aGVd9FRZfe6tsYW/697Fp7c
 dXrcC4mIhffwYBpSas/Sgwi3gifWq7jTbIl3oEJw82PET/EbgZD9PLZzeViNp1so8dTghbCA+Vr
 m8UJv73AHGWwpqzH2yQ==
X-Google-Smtp-Source: AGHT+IEKVtYEP0P2i064GcszhSYg1YuluhhyLRHKSt0L2dAHlw54qzFTOmew7nQoDpinexXAK2hSUQ==
X-Received: by 2002:a05:600c:8505:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-44b6a1fa525mr4215685e9.0.1747946392309; 
 Thu, 22 May 2025 13:39:52 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f05581sm117304575e9.13.2025.05.22.13.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 13:39:51 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH 0/5] Qualcomm: teach the build system to emit signed ELF images
Date: Thu, 22 May 2025 22:39:38 +0200
Message-Id: <20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIqLL2gC/x3MQQqAIBAAwK/EnltQSYi+Eh20tlpItzQiiP6ed
 JzLPJApMWXoqgcSXZxZYoGuKxhXFxdCnorBKGOVNQZ9g8coAU+RjeOCHPYkFwWKZ0bnG2Vb67V
 2GkqxJ5r5/vt+eN8POgbsBm4AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=JfB6g5WC82A824HreMsnslvWWdMCH03chL1u7QjeSfI=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoL4uW5z4bZTuSjooFByh7G8VCdNS+brrc5rySV
 /50jSG4+JiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaC+LlgAKCRAFgzErGV9k
 tvevD/9JPyNjku/v5vp+CvpiFQOdEHtwuD7eFP9blYHtIU8hqNGDn1a7OtJG/OlJdKxni7K+5n4
 kQR29MRLsegPEmnO/y2cQTNEHMpxL52dHQ4V7f10spNKv8OoTlL0Rf/TaVm6oW2ClIQrOlwtGgp
 YVTUzyBFvU9zPh4GXlhSOPnTijYdyrbcKxHnSDvB6zMuyx1GhyUbmBrv+BImmhXyy3M5kcSWtdy
 wJyYsGLih5Q0/XmYWNpWgeBJcDf5/jmwLsPpDmbZ+3eBzp1EErBG1T0wJ8jOPtSlXQ1Tg33tTQn
 lSoPtm57M6utkZLtr5RcSeCTBBFIWJLRRNNkt8GaTPNh9YCb0boDlGu98H/fM6dppmx+k4QlolT
 XsifpzycQv8zDnjmg6+nZd759cunOtNPdiazxNK6m8lXl882G5ovATYZbhN7HRMKg4oWN4FR4Ir
 oU9KPW5Vjv/iSa+mr+PeazOHvEB9PtVygExitBlL91Py/2vG2exhrqPBQAGKxsN/TsB1NLrPe0k
 j4bP5dRFrWGW9tqqLBSgDhBghoKG631NdEJ6Jt23PxZgC0yyGcTlKsiVPI+aYKJWydtOiLu3eee
 OIaytfx5HqZ7zm+fVleoN4yqLIFfv2oUhORmNf9nRnfwjpy+AZR9lngGpIYjKVB0mFHkc6xcfPB
 Y7IkaB5vXmbb2lA==
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

With this tool in place, we introduce a "u-boot.mbn" target in the
Makefile, this can be invoked to build a Qualcomm signed ELF image for
supported targets.

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

These patches have been tested on the RB3 Gen 2, but additionally
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
Casey Connolly (5):
      tools: add mkmbn tool for Qualcomm
      Makefile: add u-boot.mbn target for mach-snapdragon
      configs: qualcomm: use fragments for debug UART
      configs: qualcomm: use mkmbn and stop creating ELF files
      doc: board/qualcomm: update docs for new u-boot.mbn target

 Makefile                            |   3 +
 arch/arm/mach-snapdragon/Makefile   |   8 +
 board/qualcomm/debug-qcm6490.config |   5 +
 board/qualcomm/debug-qcs9100.config |   5 +
 configs/qcm6490_defconfig           |  10 --
 configs/qcom_ipq9574_mmc_defconfig  |   1 -
 configs/qcs9100_defconfig           |  18 ---
 doc/board/qualcomm/index.rst        |   1 +
 doc/board/qualcomm/rb3gen2.rst      |  27 ++--
 doc/board/qualcomm/rdp.rst          |  16 +-
 doc/board/qualcomm/signing.rst      |  29 ++++
 tools/qcom/mkmbn/cert.py            | 158 ++++++++++++++++++
 tools/qcom/mkmbn/elf.py             | 243 ++++++++++++++++++++++++++++
 tools/qcom/mkmbn/hashseg.py         | 308 ++++++++++++++++++++++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py           |  99 ++++++++++++
 15 files changed, 876 insertions(+), 55 deletions(-)
---
base-commit: 8f85a7345ed5df70a155f0630da72970eb01d87a
change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1

Casey Connolly <casey.connolly@linaro.org>

