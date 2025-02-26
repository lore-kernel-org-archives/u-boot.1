Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A38C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:45:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A6E807EE;
	Wed, 26 Feb 2025 15:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gtFLwY2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C282E80F92; Wed, 26 Feb 2025 15:45:42 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF9C9805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43984e9cc90so6237025e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740581140; x=1741185940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X2cWob/J9rIdxYRVetp5vfDR38gjAVtmMZiOyIdDZ/c=;
 b=gtFLwY2qHH5oir7YQmamgqYgdNqLM0kmakS6kByU85dVdFDjxwXQ+g7eSBPRDkHjhH
 EO5MtnyIy/B/Alf0M6gUbU50QGLTz3lEbAyM2pO0XWArykk9nchwmEGcnbjAlJ+hlbgh
 6cyL80GwGn2CnfcVwbqRyWMSJL0OG/egEtHmO7bFmcat4Yfx0DtlQui1MH5DDHRLzp8m
 sl/xqcRfo50X7bvF0S3AgDB3IQmWAEH3/wQnBs0F3+T9ZcrANugRTdZPPOUxHBXOnIKZ
 NKHSE4Kary+R8M9rC9I0VuiaBWvYSPJ/rqCqtVF1/U9LTF49DWJA/QI7p1RedNwX+Sik
 oV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581140; x=1741185940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X2cWob/J9rIdxYRVetp5vfDR38gjAVtmMZiOyIdDZ/c=;
 b=hEJcKvSUIFbWSZ+Zj6O3Yg+Tb3ULVwwG7ECNLcj2ZBhmlC2nvYZbEEnIakLYUAv5ih
 k05Mxe11J28kSO7PXqV3Gca7Fq0e7N+xa6qLxXXXlHiwlPAQG+MyHFYzgYoDjwQORny+
 ZIyoAXFI0pFlvgzktwFbaPyFxp66rdVkT2+R6gFOXKB5iDseM47Bpg1Og0k8xwVX7O7f
 cCv4FL5mf1oiZqOzwUS8jIh2KCGw+z8POD0bNYR3t6LD68SAs4CsESVcJiu4u7JDMSjJ
 y5j07T1b9pI2Qt+6lDjF5JGTDiKIPZ1EiG36pSX+sW5+aA6PAnrzmKubOF9j4Pz8Rrfq
 P85w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkWBGSIKugYMkzDnvGWHi7JkXl8S2JFKTmm4oqVeWZZ9MSYCe9MFVUYaUzptfGnfKmNEo/KVo=@lists.denx.de
X-Gm-Message-State: AOJu0YxhLcLQsa0SRhz4ThDO3LNyH4a2j4SAxzfc+LnlQsDwOfIoLrpl
 s1Q+9EdBffLW5kaVRT5XyvJ56lV4hkVaMakrPbqCUJ3DesmTbdb/rxM2l9+bduE=
X-Gm-Gg: ASbGnctlSpPb3cUWnx97ITuIqLK1WK3Nv5s0SJruhS3oOYyEAfoZ4baB3qPHcDCs/jc
 Vi1olvR8TUjnZ1BUe5FSZYyjSNxtm5qgA3IiarfDoRu+y9BY2NfLv5Sb1OJ99fAuhjPKucIPo4j
 X3UBL662qkHNXkTA2gI8Ej1oNeW4xnJjL+aVjoKhcZd+VC7/7cUrnEDIFBbozPwnk/X22jxoQvH
 hVkcaYLedNRiQmOkRpz8R3JFec9a/QQL0nAtoRMqNOZ2OtUACdPXHWHdMXebmd++KnPQwmBO+GJ
 /tEXra1fV0RmFwTrGpiS6da5txGkinlYrcq4A4tplut0fX3qZtSEBMc4wuJ4hg==
X-Google-Smtp-Source: AGHT+IFIkK16cWuoRIKnynVWYXPmfpoH035OGuDlE+RcXOVZ48pyqCTIIacbGoFfCEueJSd4FbqXhA==
X-Received: by 2002:a05:6000:1a86:b0:38d:d166:d44 with SMTP id
 ffacd0b85a97d-38f616331b4mr23416385f8f.23.1740581140136; 
 Wed, 26 Feb 2025 06:45:40 -0800 (PST)
Received: from toyger.caleb.rex.connolly.tech
 ([2a0a:ef40:1d11:ab01:3b78:3dbb:221d:d3e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab37403cfsm46750585e9.1.2025.02.26.06.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:45:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sam Day <me@samcday.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom-fixes-2025.04-rc4
Date: Wed, 26 Feb 2025 14:34:46 +0000
Message-ID: <20250226144531.41542-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

Sorry this is a bit later than expected.

The clk_stub, regulator, and pinctrl fixes enable the sdcard on the RB5 dev
board (and sm8250 devices broadly). clk_stub is only enabled in qcom_defconfig
and the others are qcom specific so these shouldn't affect other platforms.

Lastly, a small ufetch fix from Sam which gets color rendering correctly on
U-Boots framebuffer video device.

Kind regards,
Caleb

The following changes since commit dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71ca:

  Prepare v2025.04-rc3 (2025-02-24 16:53:59 -0600)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-fixes-2025.04-rc4

for you to fetch changes up to 6267ce556595e0586aee3a7d63042d105dc3fa4e:

  cmd: ufetch: use 3-bit colour ANSI codes (2025-02-26 13:48:27 +0000)

----------------------------------------------------------------
Caleb Connolly (4):
      clk: add stub clock driver
      qcom_defconfig: enable stub clock
      power: regulator: add additional supported LDOs for pm8150l
      pinctrl: qcom: sm8250: fix pin count

Julius Lehmann (1):
      clk: stub: add sm8150 compatible id

Sam Day (1):
      cmd: ufetch: use 3-bit colour ANSI codes

 cmd/ufetch.c                                  |  4 +-
 configs/qcom_defconfig                        |  1 +
 drivers/clk/Kconfig                           |  7 +++
 drivers/clk/Makefile                          |  1 +
 drivers/clk/clk-stub.c                        | 67 +++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250.c         |  2 +-
 drivers/power/regulator/qcom-rpmh-regulator.c |  7 +++
 7 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/clk-stub.c
