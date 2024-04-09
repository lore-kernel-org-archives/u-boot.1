Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B99CD128A
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC51A87EA9;
	Tue,  9 Apr 2024 20:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FzhVerd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DD5B880D6; Tue,  9 Apr 2024 20:03:09 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC4687E1B
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a51a1c8d931so546009366b.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685787; x=1713290587; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YrhKbtFCViuVCGOqRqDUGaTjvTwf197/vMlEZdjeais=;
 b=FzhVerd1ReOHeq5Zj7fkK3EO15z5UjIextCrUOd8qAcWv7LMIA/KYYaacm3cvK9b5K
 F9B3hghlF2Nbg8rCgLtPvQfH+zD/O2oZUDLLUteqUmlY4igmOEwv59x/F9VqeRhXMIqg
 XKcjg5uRI/DZE+ZhUAGEmF01rZ6B3TkXyTUXfbLQoSQupRRea3UK0k4gl8Wz+nNnPMyg
 v5aogxfa1KtKhwt1DsNftSMplRbiIGi+j4W4n4lzAntnP4vw8+DVV6EsA+yECKbmFHaE
 +RoebSha4dF6cRNd87QtatsnX/I7X8Uw6feWCEQifbquXz0e2NYfKTUMuw7woSQ1PGey
 oXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685787; x=1713290587;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrhKbtFCViuVCGOqRqDUGaTjvTwf197/vMlEZdjeais=;
 b=AfitRFq9JvJz0es/yIf+PhgdaxmOUUriMB60s5gm+fj0MvsCQBitjI9Q+3n14YBjP+
 /HAZMmdOlQWJetiy6tcJwX9m1H3qto2wq2k4f4k7T9axRknXgYzXMHZjeKyHje6is/uX
 5FMIS5xnuhi1hQPjsKATchTdqy5xsgXST7/3B1OR2vIZNdzXGwYnP1e4DRh+yvwuB06B
 i+U5g7uoOibyg0WLTeqI700CFVVTkEIUFfCWKjsER+ftqZPpUCNUGnYJx2sqCZjYUio6
 47dM7dmHKMJciNjDyQXNK7uirBdOH27TRAx2uyGJxLuS5HKLG4nw4gyz+eVmSRokHH3k
 Ee7w==
X-Gm-Message-State: AOJu0YwpgRxAtjo7L/6ywZhJqLlp8U5FxQO+zwHrAKsfvuqwQcr0TB6T
 ludZoYQp32gYhT+j2VYTVYY1TLxCzDmymVqKPiG37fbydbt6Wj1QFr4jrUINvs8=
X-Google-Smtp-Source: AGHT+IFnGsdkbj2EfNHhLZxh3pXOkBuyb1LI8yAwqEncEdjbJoAokPn6rZhRJjrz2jex0wxZfkPJXw==
X-Received: by 2002:a17:906:5a95:b0:a51:d2e1:695b with SMTP id
 l21-20020a1709065a9500b00a51d2e1695bmr144554ejq.49.1712685786726; 
 Tue, 09 Apr 2024 11:03:06 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:05 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/7] qcom: mmc fixes and sdm845 support
Date: Tue, 09 Apr 2024 20:02:59 +0200
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANOCFWYC/x3LTQqAIBBA4avErBswG/q7SrQwm2oWWilEEN49a
 fnxeC9EDsIRhuKFwLdEOXxGVRZgd+M3RlmyQStNilSPM+FlD4fOWVzl4YhLrdpOt9SsZCB/Z+A
 /5G2cUvoA1/RLu2MAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=n6Y5CmGu8/GwE7dYRvYkRZvnD5UOoT9akvCvspTaHIQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLXwWdbVpzkdxyxsmsaR/C0KNgo9hw/dg/rq
 La0zG+pJUeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC1wAKCRAFgzErGV9k
 tiEcD/wJySlnMTpVsQKxrTBdSeDkGaJtbHOd3HZxQEPoAJvKvJPF03T1OY5gmJ9WYY1As6EG5PZ
 kYAeU43o7HxRsJhlnHyd7XAWd7Dl3YGApqUkM+gUtHVc2JmWNvbFSlZZIzNWOmYxCWq8x50UeFn
 Tj44aMBEhAxZtSqBfJmjM7akowbkotWrAD2QRNnZ50HAhzhtQ4B/KjJwBHFHEniY9OSX45nSoV/
 9kz1m0DSHpwZfmWtejpaBWNQ0YuSCTYU6iMDzHPTCWSsf5A3ZCx6V5t+oPUZO1K+9pTJgWkAlkp
 twaNWdhDr/HoE2QX5F+pzWasqafTPVGEFrFwLOjV7uQ8Tw684RikSXv5UOmHDZPMuCi54SBdYZW
 mS2+cN2YFJDcb3uxcECasg/kbjXpd1sY2WFJmRUHxJ0ONAtd37iVl5YM7aj8lAazjJrwirViP90
 xksNTLvCPjJ8YjPNhTEwzRw2VEv86DaEc+xU39EzXQ7s0mz9nHMg3vgUQhD4qnM9OXaZ0BctoLY
 GS5tcKgof4SY5s9kwZ/stNM2632Y2nFhQD6NzJf9esYFJVj1adSIca6DmO0dDnqhnw8vTGRxjDv
 f/1pl6fdwxjnhi2OO4VXlHE7Y6jIUoiJXOGVlAb77B4cJYJVELO0TQGLtCT93EyJ0ychoBwI470
 C4anHnikdK39ldA==
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

This series does some long overdue cleanup to the msm_sdhci driver,
fixes v5 support, and adds the necessary clock configuration to get the
sdcard up and running on the RB3.

---
Caleb Connolly (7):
      mmc: msm_sdhci: correct vendor_spec_cap0 register for v5
      mmc: msm_sdhci: use modern DT handling
      mmc: msm_sdhci: print core version
      mmc: msm_sdhci: use a more sensible default clock rate
      clk/qcom: sdm845: enable SDCC2 core clock
      pinctrl: qcom: sdm845: add special pin names
      dts: sdm845-db845c-u-boot: adjust MMC clocks

 arch/arm/dts/sdm845-db845c-u-boot.dtsi |  7 ++++++
 drivers/clk/qcom/clock-qcom.h          |  1 +
 drivers/clk/qcom/clock-sdm845.c        | 17 ++++++++++++++
 drivers/mmc/msm_sdhci.c                | 43 +++++++++++++++++++++++-----------
 drivers/pinctrl/qcom/pinctrl-sdm845.c  | 13 +++++++++-
 5 files changed, 66 insertions(+), 15 deletions(-)
---
change-id: 20240409-b4-qcom-mmc-fixes-d30782746f4a
base-commit: b40edaf6383b1494222ea9c043d7c1716d4d118f

// Caleb (they/them)

