Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34810C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B683E81E02;
	Fri, 14 Mar 2025 16:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vG41V2vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9637481DF6; Fri, 14 Mar 2025 16:31:24 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B57E81D52
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so21434275e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741966282; x=1742571082; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SX5S5o5uxmpVrKpcCpSjkfL+AGKW7fzlLPg1BOIcKK4=;
 b=vG41V2vmAHw6umOVoezALYagYE91SSDqJXOGqrenaxYCYRPxEopTCMsaEQdApmT1OE
 WHJA3jE1Ol4L3NDJgjTwL0yscgFQ+A9KwOPZg+oKEBLjIQPpCS4BkyETChMAr0yAtZji
 Yh0LLgCyKw3RB+Lwik7HUjPdrsj7U9qbplP0oSRz//HT4gQhHuu+bgwYDn64cJdny6s3
 gMtTwupdchB64Iy7W1aqsT6GqC/LAjD5gKbMBoH398Mc1A64Z+UlinNGPf53uSOUL63M
 ov+Pbd9VUN5QsB7zvxCxKXeJdEX80snD4Jm9bjymeLpHL7N+S/MiZ5xcIW17JyilE0e/
 hs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966282; x=1742571082;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SX5S5o5uxmpVrKpcCpSjkfL+AGKW7fzlLPg1BOIcKK4=;
 b=t+IhlZJKn4DlFaAnVFYTtr42dBxhll/4y8/ZuwB6reAMiMZyEFtFpo2eyeEvmklVeb
 X54Gm6TwyWbplFUydrh0AzB5a6zVm9S95wEQD0crSiKhjciUB9cxOqnaiYFmR2N3C+Nm
 s0dyN7KiaCdBl7qA2D1rvu8Ml1suMLsYFcgkPRUa/7frf9qL3Gr2IuBktf2r24NOo+mK
 f/B73K8oPp0feD5dbpdW93rFtH5Wv1M2An41gwaBuD6gNY2rGI9vhHJU7UX7+oaWkVj3
 9yjHDfClsQzxGB2p3Ibd8yVg66Z0lMXOoUX79qC34wdUhh9Zd91M9WSIZawEDlZN6nYB
 uy3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMG0Y6S1cZECldOsCkfTwsdldL6wGyvjW0vn6gGzY6AXpfPrFaiocChVvV7hHZ9sIBBgHJ/1c=@lists.denx.de
X-Gm-Message-State: AOJu0YyIu+i1VuSf7eVEaT4BxANdDAKmoYQTWzo5TL8/2UUFVIFmihlQ
 vq6NH8nZZdCDzSpEecVemwPgsbwQrpcu4PY3o7MVv+TYxjqgbIAacyx66IgxJz4=
X-Gm-Gg: ASbGncv4kt81DrFlFCTHY6d9vH4/rTXaihThVS288S6uyaSLI2C9Q/5LBrI5QbgQI55
 8IOkExiiQeCOiy6+WGnoPVKCeB1/3ELnFN01QhGPYvgldPQOVYfoTkfU79ohg9UPRC0gy0LXxqg
 XorO4k0Dflu4gpIVFni6+fCViInMdxz2qo5dpi99iYzjicTzZOhhQ++5SPysMtcBhy8JUDJ85If
 Q4t+eL+k6sy4rXJ/rQX0ihQWGCCisQQdz6mUQAUe+gl5x5KlHSIf7P8HP+ODlNG4p5UZ5fTsXgj
 dcTM5BAX50ovchZUZlxQ6fGRr/Nrdts+04YXUVLYa59GdbyGe8DkPIQ879hs
X-Google-Smtp-Source: AGHT+IF1yNiPrezVA7emH+NpnWZhu55NUT3Lgvqwhqcsma0M8Yjw88lu3RxuA7WfIS2BnrG586Jg8w==
X-Received: by 2002:a05:6000:1545:b0:391:2ba9:4c51 with SMTP id
 ffacd0b85a97d-3971ea67afemr3739298f8f.44.1741966281911; 
 Fri, 14 Mar 2025 08:31:21 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm5907399f8f.73.2025.03.14.08.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:31:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] clk/qcom: fixes and more SC7280 clocks
Date: Fri, 14 Mar 2025 15:31:18 +0000
Message-Id: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZL1GcC/x3MSwqAMAwA0atI1gZiVBSvIi6kjRr8VBoQQby7x
 eVbzDxgElUMuuyBKJeahiOhyDNwy3jMguqTgYlrKosKzTXcEu4hCrotuNVQqrIhz34kYkjhGWX
 S+5/2w/t+gcV532QAAAA=
X-Change-ID: 20250314-sc7280-more-clocks-e4370d2da002
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dQm1JdYMsfujs53oDBy1ue/fLR7lDhvVuEKfUGHd+MM=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1EvI3SICHRgiZmPO2MxtXomWHd9kkWh3gqc5P
 l+434bPlRGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RLyAAKCRAFgzErGV9k
 tkCwEAChFxaQ+wp9XLkKxxv5wNHUl8P8R3eCvIbss/VZDEDlmhN3NMrhI/dLpTtSxlAESU3zDkO
 cVpAMq8t6YLQz9j3ESP4z6V89Zlz8DnivwCGfZ7VW3cifWFp3N1bKqMRGuRcNS6Eocsfkqnsy8/
 5e3NNuDBO4Ng9g/nvv9sJ7PnpWLEtuz6woQ4JfyF9bOtEFPtI3Fsq0lIOT+xyGdz/8gjEl1y7Cr
 cuHN8uszAXn/vXcOtiyGTz6gM8mrl0Xm3M0RVzBo/dPZFQSQYsdipwQ1kISImKBLe2dqa4vpxLM
 64nDpb8tdWPX/qx35lp+xUNOvfGB/0yxJZS2Z7YAIK8ulHz6qCbzfeawHwwNGY6XzkB+AzGvabi
 PVVR4Q3ISatLPZE4HSJQsV31MrR1PUd/m9vylRBS3jF1ZBnAPP1G8GJSCsOmynLscrBECUxses4
 3f5i1RQNNWO7E06JBohdmaRzB4ETgAjZ75/sZwXj6PTdY1BkI70l2R4N7gy8SNStgeRANMnEkxk
 /uuYPkygPFORDJbYj4Se9c6899dWIYGlp+91HURHmsqM717cJWucxHPnCWPxQnstU3mUu76Y8aL
 V1ou4AL6qNhfRpvG5rZANEH9TPS2ykSTQAMxZEdF13Pf79nJSlCf3lOynVuCbieHPZDHFaB76Ka
 qpDHDQDsHqj+sDA==
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

Refactor qcom_gate_clk_en() so that it will actually report an error if
we try to enable a clock that isn't defined. This will help a lot during
bringup and ensure we don't miss any clocks.

Additionally, add a bunch of clocks for SC7280, preparing for i2c and
PCIe support, plus some debug data.

---
Caleb Connolly (3):
      clk/qcom: bubble up qcom_gate_clk_en() errors
      clk/qcom: sc7280: add some debug data
      clk/qcom: sc7280: add GENI, PCIe, and more USB clocks

 drivers/clk/qcom/clock-apq8016.c  |   3 +-
 drivers/clk/qcom/clock-qcm2290.c  |   4 +-
 drivers/clk/qcom/clock-qcom.h     |  12 +++-
 drivers/clk/qcom/clock-sa8775p.c  |   4 +-
 drivers/clk/qcom/clock-sc7280.c   | 124 +++++++++++++++++++++++++++++++++-----
 drivers/clk/qcom/clock-sdm845.c   |   4 +-
 drivers/clk/qcom/clock-sm6115.c   |   4 +-
 drivers/clk/qcom/clock-sm8150.c   |   4 +-
 drivers/clk/qcom/clock-sm8250.c   |   4 +-
 drivers/clk/qcom/clock-sm8550.c   |   4 +-
 drivers/clk/qcom/clock-sm8650.c   |   4 +-
 drivers/clk/qcom/clock-x1e80100.c |   4 +-
 12 files changed, 129 insertions(+), 46 deletions(-)
---
base-commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e

Caleb Connolly <caleb.connolly@linaro.org>

