Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED13C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 14:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47FB83666;
	Wed, 13 Aug 2025 16:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hcxrptpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7220483677; Wed, 13 Aug 2025 16:54:27 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9330D82ADA
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 16:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom.rini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-741b8c26e64so3907638a34.0
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 07:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755096863; x=1755701663;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:dkim-signature:resent-to:resent-message-id:resent-date
 :resent-from:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7+budpte9RDB5efSlCfwRNzSLJPUmUhc+WxazgRz4I=;
 b=NX8tuWfmQOjhN39d02yYCs35hSD71/GaYBclywKnaMAzQJ58OYMYRx7Qjd4UXtN8fB
 wxAq/AaR+aOHJXMo05XyrED5xODO/jp3hW2L7eYQxNqV7RG8Zwa5GKU2LAawdsH38dlh
 qphNgD5YCpv/d2G/p3+FZdIaNOduVb3yptJ0l/xutWvxJ4wSgg2U6DLVZisB3qwYs63J
 dOk6XKhRjxtjeB9IE4Q0z2PrXvjORy2SYLiiWY4S/iAtoXYvC/rZNep/LM02tkv/92gT
 1UvLyS7mChegaV3zVPz8Tj1vwvuOY0pbvNFnp1lAjQ00TsJfwlH5xDckwaEw/txuc80Y
 H50A==
X-Forwarded-Encrypted: i=2;
 AJvYcCXdwA31gkFNpitICf99A0JoY8J3OHkxHZuF2Znx5twy4OJiOV66CVUHv9vp4SxmWimhF0+R0fU=@lists.denx.de
X-Gm-Message-State: AOJu0YyIbGxNcpP3FXh37XSYYYdrU7w5lpdlO4LOIWQCp/l+95P6Z/N3
 /l/BBiBpLY0akd6/SbLHfY8kI9pH3eQkJuxCcRiY2QGkDHXeiAGM8nR0/SmaysPyY9ycT5rwMm/
 FKUucmtE=
X-Gm-Gg: ASbGncvg2rgfwT2UxwogSusZbnzeQMjeuQsoZ3tuu7WxEZbLsDdyebTEiCQm2j4MaaV
 lfPN3UEwCeV/Fn8iAUrG7Xi+j4rGABDqNuzcDFCBCCmR9nXMDUdG+EMHEdt43mvr4mSQPC3bEQS
 K4VXTY7FX1nOqzK9vwCsMCGaZTXi2KWUDMxBIoY0EuR7l45+U15SRKZNMUd3t3zNpgzLEQYZ7jL
 BaMYHJJxRdsgqQ+2/6bV786MGGhHLyTzpC6FEQVB01U0hdCf9FPrx6lpuqFFvJJoR/s7XLQmz5c
 c04asxCqgl3SBRHNx3n5y+7Fd8tG4Gj4G6y7b2nS1KyCe/Vb2JpiIh7As4c3PuwoA/PWozJxxzO
 SIIuQV2TjxCv7DLq6y6jFOVQUVhz0ZGD0U/EsSIwo/1ignjdDRDPuJ8GF
X-Google-Smtp-Source: AGHT+IGkg6ZakYQ62ZFu78UjTlU946spfdd50tCiGdiArrvTu5jhpLKilljXeGxIyNjaiKsRUgTn0w==
X-Received: by 2002:a05:6830:2b09:b0:741:bb8d:523d with SMTP id
 46e09a7af769-743754d6cd6mr2255193a34.26.1755096863201; 
 Wed, 13 Aug 2025 07:54:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7436f87a661sm890691a34.22.2025.08.13.07.54.22
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:54:22 -0700 (PDT)
From: Casey Connolly <trini@konsulko.com>
X-Google-Original-From: Casey Connolly <casey.connolly@linaro.org>
Resent-From: Tom Rini <trini@bill-the-cat>
Resent-Date: Wed, 13 Aug 2025 08:54:21 -0600
Resent-Message-ID: <20250813145421.GA124814@bill-the-cat>
Resent-To: u-boot@lists.denx.de
Received: by 2002:a05:7022:658f:b0:a6:f736:36be with SMTP id bd15csp300517dlb; 
 Wed, 13 Aug 2025 07:13:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8d:b0:459:443e:b18a with SMTP id
 5b1f17b1804b1-45a1704f681mr17179685e9.14.1755094390552; 
 Wed, 13 Aug 2025 07:13:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1755094390; cv=none;
 d=google.com; s=arc-20240605;
 b=FJGTvn9ryf2dkzGiww4uk5Py8Ofk19fHpC4wldL86RjIgnnqXvWLV/ibGVwEogka1/
 5OdmsqnpFis8ExG4lSk5S3h+uT4tBbABvVqFxhjSWOCnb1ecEu0D2Ss/gmkSJZyIk5Gx
 Etfox0Lu3mHXjOJ6/saTA8mSbgOtXVvKbkPI2YUeXKPUCerveLLjPH6AQzz90uRPOzp/
 AJKh9yD238kXYRo0jpS1NJ7rabm/xrDKVFwWE0355wK0jsVN+zLAs7zGxgRDpGmB+Rhw
 ObzBEZYOMYn0HqxNVuzZJWroB+QlBsg3cmYcOCPddHPOFQujYYtHAeRqfuruAkqU9s0B
 LhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature;
 bh=U7+budpte9RDB5efSlCfwRNzSLJPUmUhc+WxazgRz4I=;
 fh=dk8Ryu0ZJVAGEL/rSD/6lr1m0o9nAyaNauhtuq2UNEw=;
 b=BTgjx4wKUsZmgGqgesEZM/D4IT4UPgUiwIOEd7Ni4WqKK7OVZ5IsEGMqwR3BAPSNvh
 7IhIzxaTolUGBMuzcmxOvUNVzk6/rTn4qaN8xCUgzC32PaSNN8dx7IfvOjLCPif1TDTI
 BEG2ZciHsJCI7zJP2P0lYTsYgjPAZ+oB9d71vSbkMA2N/oKuWtKzutT+1INM+RYXkr1r
 isE8aLj1/hukVvbStoNrPXgf1ws1YT0l3jX0/lr3NYbD3qnpdSM8QTTPPXcOb1iSYB4y
 zLDaJDW+52NyFeV+Dpkt8qhLIkCDkkEElG4Y4v0aype8KezisJArxzo5PS/k0Q/9D/f7
 eNmA==; dara=google.com
ARC-Authentication-Results: i=1; mx.google.com;
 dkim=pass header.i=@linaro.org header.s=google header.b=hcxrptpj;
 spf=pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) smtp.mailfrom=casey.connolly@linaro.org; 
 dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org;
 dara=pass header.i=@konsulko.com
Received: from mail-sor-f41.google.com (mail-sor-f41.google.com.
 [209.85.220.41]) by mx.google.com with SMTPS id
 ffacd0b85a97d-3b94ffc3471sor48091f8f.2.2025.08.13.07.13.10
 for <trini@konsulko.com> (Google Transport Security);
 Wed, 13 Aug 2025 07:13:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of casey.connolly@linaro.org designates
 209.85.220.41 as permitted sender) client-ip=209.85.220.41; 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755094389; x=1755699189; darn=konsulko.com;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U7+budpte9RDB5efSlCfwRNzSLJPUmUhc+WxazgRz4I=;
 b=hcxrptpjubNm9ZfNYUeqqnt1LeDLbmnHqv6ivqXS6/LaXHrG70q65TzFysc1x7fMBU
 LIgZVsAsAvlSaoVaK6loAThYAkpmPaeFVAbc38Oz8BB/JQDCw4iz+U/bqBx7ISSDcsAY
 JUefNH5JrJS/MNncvOk7lhJC/cZTs0lz1xWCX9XnAXaoxWoJHv0+NPMw2g8xuUvdsOir
 jNil+s+uXTLdA7YUGvPnpmZmFnpBuhN+IAoxRok+C9Nl/bbr53+Dj42up26sYQvIp1sR
 nDO/1Tg8UQ+rO/xx+jOz9ht7G2VYQI8ynRfyIMkT1YYew0gnSjXJex/sK1Drnleelzem
 I7/g==
X-Received: by 2002:a5d:584f:0:b0:3a5:8934:4959 with SMTP id
 ffacd0b85a97d-3b918cac9e9mr2356646f8f.27.1755094389502; 
 Wed, 13 Aug 2025 07:13:09 -0700 (PDT)
Received: from lion.tail248178.ts.net (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1a586c8fsm3874625e9.17.2025.08.13.07.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:13:09 -0700 (PDT)
To: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PULL] Please pull qcom-fixes-13Aug2025
Date: Wed, 13 Aug 2025 16:09:46 +0200
Message-ID: <20250813141201.276510-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.50.1
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

Quite a few Smatch issues reported by Andrew, and the LMB allocation fix.

CI for this is: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/27364

Thanks
---

The following changes since commit acfacf452441d0a659e3afbd55fd6061aa17e647:

  Prepare v2025.10-rc2 (2025-08-11 13:47:46 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git tags/qcom-fixes-13Aug2025

for you to fetch changes up to d9fbc1d70bc9d5e7665c9fc1ed71d25e04faba54:

  pinctrl: qcom: sdm845: Limit check off by 1 (2025-08-13 15:18:49 +0200)

----------------------------------------------------------------
Andrew Goodbody (6):
      phy: qcom: Fix ret is uninitialised
      serial: msm-geni: Detect error from get_clk_div_rate
      serial: msm-geni: No need to NULL check priv
      button: qcom-pmic: Fix dereference of uninitialised pointer
      pinctrl: qcom: sa8775: Limit check for array index not correct
      pinctrl: qcom: sdm845: Limit check off by 1

Casey Connolly (1):
      mach-snapdragon: fix erroneous lmb allocations

 arch/arm/mach-snapdragon/board.c       | 13 ++++++++-----
 drivers/button/button-qcom-pmic.c      |  3 ++-
 drivers/phy/qcom/phy-qcom-snps-eusb2.c |  3 ++-
 drivers/pinctrl/qcom/pinctrl-sa8775p.c |  4 +++-
 drivers/pinctrl/qcom/pinctrl-sdm845.c  |  2 +-
 drivers/serial/serial_msm_geni.c       | 32 ++++++++++++++++----------------
 6 files changed, 32 insertions(+), 25 deletions(-)
---

Cc: Neil Armstrong <neil.armstrong@linaro.org>
