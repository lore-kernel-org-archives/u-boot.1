Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31522C71148
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 18:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DAC82E6A;
	Fri, 13 Jun 2025 20:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FORm1mT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7581D82EA3; Fri, 13 Jun 2025 20:10:21 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F1082D5E
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 20:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so20484375e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749838219; x=1750443019; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0v1Ik3zbgk7DcOsEE8cO9DMiyT+1TTYg9x+8m2q4U8=;
 b=FORm1mT59rGVpk8Z+tALW+PDWdrGFaGREBuCHH1pluiqb0y+JyJzMxC3sZMjXoBDqn
 W5JtWL6NCFG0c9sSUs+OanDlgUE9Mu5vJ8Nmcd5JILzTvPV5tBs91DbkSJ8nam7xeNQz
 QtJPlvgxD73tjOBnzzZBY+RWnw8GK/iUPsonKkEm4aRupEyGRWy7ZosLfKvbwR+gsU9V
 Qrocy5ixDWNbEdWEFGk/sriMnRCip23uSXJcQ8kSWPA87yOgDwbRzSDXUflz2jOzC07E
 wViuNrJ7VW5klwJpKNv09naet5zgCTneyEYqd3RRfVE+bMNnn5iDPKWKFePP6BvcCJpP
 Rm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749838219; x=1750443019;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0v1Ik3zbgk7DcOsEE8cO9DMiyT+1TTYg9x+8m2q4U8=;
 b=YomZmN3rWdfrx60L79zjcm9SuZWx2rVycayqRnGP7XsRJNlxCW57XVWxpampqiI09m
 N+P+kmDbyROFPZV/XQudDsSjLtUuYnbT1Q+WG4MlAXKyHmCOJyGPFnR2JE8+cA+pQltv
 JHluiuj5YSlwNQqyPv2nzEsK10h1Putg1Ajf9XC+niy0E8EK6R05ZVCS5aYl7BnE+h1B
 koBfOkGRBCUefRiNNtFgJjH67VTp3R2i4stcX2IdvDf13BLBy9WrFKTp5zCgywffZysM
 eyG+LoBv0XrgNy4NlOpzTn98P21z01EjTFfgEH0e9ICQXbm42NSIVbr9O69izLif8yg+
 54aA==
X-Gm-Message-State: AOJu0Ywi4LDlme8ZbVzaqFypxSr7O8GHNHjyhzrBUmfkIAgyJBAW5vh5
 546xOAj3Qw5+UyIxh27aQLevbm4yVkelLQZ7zrQtTOpHZXZhg0gXFW9LO6fc2watX+vzYjeq4h3
 qQBWU
X-Gm-Gg: ASbGncvr9GI6/UZMlHS9EcGD/qXvVsijeocYmxONtpdroTVMyj1DrGGtSf+jtl3aBfY
 SHube5aNr6MTlRiSrRVg8qaIpzPKOdTLJoxkSmWjgUo0Mi3J0eZTBBbmcOADE3yr2BnT2wHa/Ll
 ByBVccDmWuewaQYCPIwrqmNYoYVVPGFiFQ5Yihj7Zi0nZ9yIwciPEh444Dn3ETsIhfXL2tj24ui
 6l5gKY9jVqExH3Ok/XE1gDWFGS81Pts8k+p2/9p0i2W/edR9RmwOKyt3WTF2QKcDoBZ9X/yR22I
 TNIoBQuJLQLxtst6KjxgQvUWmlseXpp/+U9ukSVO3F3xtaVApLsUrQ5JxGguJ9Ofeeuq
X-Google-Smtp-Source: AGHT+IE1glMsk4Yyeebv0ktIbjv4+ahAkh3CtVnAvzxgEjaTkcd8hjn2Cga9KR3pEieIeNeNzFmL+Q==
X-Received: by 2002:a05:600c:8b2a:b0:440:61eb:2ce5 with SMTP id
 5b1f17b1804b1-4533cb488b5mr5784185e9.17.1749838218575; 
 Fri, 13 Jun 2025 11:10:18 -0700 (PDT)
Received: from toyger.lan ([213.240.182.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e14fc98sm61511975e9.29.2025.06.13.11.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 11:10:17 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH v3 0/5] Qualcomm: implement support for GENI firmware loading
Date: Fri, 13 Jun 2025 20:10:13 +0200
Message-Id: <20250613-geni-load-fw-v3-0-be778b3b101b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVpTGgC/22PzW7DIBAGX8XiXCpYICZWFOU9qh4wLA6qbVpw3
 VaR372ESP1Tjx9iZrQXkjEFzKRrLiThGnKIcxniriH2bOYBaXBlE2CgmOCSDjgHOkbjqH+jDK2
 RArzUe0sK8pzQh/eqe3i87YQvr8W63B7JhDmbau2aw5c02xY0o1NMSO0Y7VOmK6eMonFKSt1ao
 fE0htmkeB/TcLy2epPL5zhNYemavWZKAHfeYU+u5XPIS0wf9a6V1/T/J9SO0q0H5UFz8D861bT
 CN73j7A8NhW6tcbvecu169ovetu0TM+Yc+mEBAAA=
X-Change-ID: 20250314-geni-load-fw-0eca432f489c
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2843;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=alc1fwbhUCZ4cDT+cjh8b1RM1g6h4ygfnXOrJd09LMY=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoTGmHDVwO/fSvb7HSmFGmaEgoRDH+NaET8r+ms
 p+eSjcsPqyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaExphwAKCRAFgzErGV9k
 tiVdEACBXn/7VOVL9ebQim1y70NMs/zyqsi9ulT3bkMmN30Dp9QXmPBOLRhHDV8IEJOzjSslNa/
 3ej2r5gy3Xkbxlq+k/LUVGXQ/MuGkquu8zEb/ff35porE7yu877yf5TQ+ooE4RuW0De861YbQSP
 v5i41/ldmILYhv3rTEIlkUBbbFrovm+PXn9sHLczZrB/pn7wGAI5mqImnxCb8N8QDD8vljs3eDn
 Ym+p+SaYi0Lwa9KPdIyU8JwVgDMy/Rjn+pDS/hugzakFZ3qU/XfxAgbO5hu3OvzXqfvptn1kqtH
 k7CM0TzaDwMH5gtcS2M1OpajCih9YLyBGhxq5jOsErmBB0UuzZXr1PJG1Et/vkyrXDtQ3R5pZC/
 OQJSxw2d8GJCQx+/bNZOILBS96VuLdsOggLMt0SWcOsmHYHD71ddZqbAp/ali9Lo6KHtQmhQU1f
 Ow3/pZQwFGCvriEPAcIJr3v+nJ4ZQSMaf5OC1T8HCEz6OOrDWijhHB9wZh74xOL6FRjpv+RNU73
 ADfj17RPJLzNSyw1PLbwlW7LVgYfSBZjFqmja2aCZkPxn7vswvK5t5tFBRyigKaRwel57Q0kOKh
 l8FiwL0QsnyQDKXkp6pzPMkBWRqTuUUsFe1SN/GbjVM9HC9L9Jp84hAPVvgfk57w3zEYuMb7Vmt
 RNZ3F6Us2issPeg==
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

The GENI block on Qualcomm platforms contains many Serial Engines (SEs),
these are general purpose hardware blocks capable of implementing any
low speed protocol (UART, SPI, I2C, etc).

The protocol implementation is provided in the form of firmware which is
programmed in to the peripheral, typically by the EDK2 bootloader. Up
until now we have primarily been chainloading U-Boot, and therefore
haven't had to deal with this problem.

However, when running U-Boot as the primary bootloader it is necessary
to handle loading and writing the firmware.

Support for doing this in Linux is also in progress [1], this series is
largely based on that one, however the Linux patches expect the firmware
to be provided in /lib/firmware, and will only exist on newer kernels.

Since we may want to use peripheral (e.g. EEPROM) inside U-Boot it is
still useful to implement firmware loading in U-Boot.

The approach taken here is to bind all peripheral devices which don't
need firmware loading (e.g. the serial port), then wait until
EVT_LAST_STAGE_INIT to handle loading the firmware from storage and
probing the remaining peripherals. We forcefully probe them so that they
will trigger firmware loading and will be available to Linux.

For testing on the RB3 Gen 2 [2] is needed so that the i2c peripherals
can be probed.

[1]: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-1-quic_vdadhani@quicinc.com/
[2]: https://lore.kernel.org/u-boot/20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org/

---
Changes in v3:
- Replace printf() with pr_XXX() in geni SE driver
- Add firmware loading for UART as well
- Link to v2: https://lore.kernel.org/r/20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org

Changes in v2:
- Use GENI_SE_INVALID_PROTO in geni_i2c instead of 0xff
- Fix typo
- Link to v1: https://lore.kernel.org/r/20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org

---
Casey Connolly (5):
      i2c: geni: fix error message wording in clk_disable
      misc: introduce Qcom GENI wrapper
      i2c: geni: load firmware if required
      clk/qcom: sc7280: add uart7 clocks
      serial: msm-geni: implement firmware loading

 arch/arm/Kconfig                 |   1 +
 drivers/clk/qcom/clock-sc7280.c  |   6 +
 drivers/i2c/geni_i2c.c           |  14 +-
 drivers/misc/Kconfig             |   9 +
 drivers/misc/Makefile            |   1 +
 drivers/misc/qcom_geni.c         | 578 +++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_msm_geni.c |  81 ++----
 include/soc/qcom/geni-se.h       |  36 +++
 include/soc/qcom/qup-fw-load.h   | 178 ++++++++++++
 9 files changed, 849 insertions(+), 55 deletions(-)
---
base-commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e
change-id: 20250314-geni-load-fw-0eca432f489c

Casey Connolly <casey.connolly@linaro.org>

