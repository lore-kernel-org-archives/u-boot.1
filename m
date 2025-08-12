Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F597CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 11:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CC28327A;
	Tue, 12 Aug 2025 13:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ap/OyY9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2668331C; Tue, 12 Aug 2025 13:34:41 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9608313F
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 13:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so4052128f8f.2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754998479; x=1755603279; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxjGKpN9uZ+yRVyrORuwySbOpsXgKviEwZG08KoXSEg=;
 b=ap/OyY9RmbLF2Nn8/Hxerhr1urmCJTbDLOUimTZFf/cPmLoqSfPmBcpVhfHEU1PATK
 nTxYyqvwLqW3x3+E4Je1EoxDF/KWSJuvH2iWHsNYl01TXVCRri6QoDoftT5rxVvq5jta
 6ff8obR/HSblVaVZ38jrnOEL9a6I8wG6g71AEJ5uT0Ejii98hikvdDod1AQA/fdgPDcE
 3A0U5g9gUDsPqWW27sNLe3OM68OiHLe3yiJZJc/E4XA+pIR3ROljEEwxTwuHK3dfj2UQ
 Pc1Ubqn+o5AcLrh0sGeHMepn4R3ZTQAYfBqyXD+tYJ+Wa3QnmxuMFpF8LsxcsOQc69Ri
 h2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754998479; x=1755603279;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxjGKpN9uZ+yRVyrORuwySbOpsXgKviEwZG08KoXSEg=;
 b=viTGbsUZtvr26+LPd0OwAMloPQ6/ADyJ8O6i3hCdbvGMkLkhY+tnDzi6NBLvyiZd2g
 n6GBnLAIUCo1w4b9I8FUXA/vGUYijLNsSPceiGljpmTFB5LYKEXacOZaHAGgMrz8jv3x
 AnY5ZKOfl4Z+EOs66k8oM/dIgj2xfBwbvG2cWQ7V4/csAjeeeOyrjjJ0qAl/L1dAib0o
 F7hRx93RZfpJYnYdRW+6LMH/5IiffRafynJVh/845eZhWPwepqiJjFLv87hR8znPsEku
 1cZAtSCI82wLOOy+O3GwI2Y2gi/Pi0c4+rxMTWDxsubPUtQvetpsI9IOt/dJJrkStdhh
 hHIA==
X-Gm-Message-State: AOJu0YyHDaYNSmaqXcw4Btw3itI4Vjwvlkizmie89xF1vWhJel1PabJa
 4h7boiM31EpANz3XJzWgvZ8sSKW6ACNvN39WqFS/iADLkjvK1f0QzhRt/MG7N00NGVY5U9mokbY
 vOhYw
X-Gm-Gg: ASbGnctGBbJqL55SaZOUIHGnSH5ktuflPa5C9oKx4yFztcIPoaQEqHEKsrpilsPX2U6
 Ju/qjk5IXYGbYzF7wb789uWGaYMPehaAK7qohRQq9Ksd4+GJp/NNN+sadyT8iu8FpHV6pHwxIe9
 BjCl8yJM5cWCgp4Fw5hOBh0TxugVLMo8K0vRC2CO3XmNKM1+RU88m6pqoEZ9PvaZOXLsMxlhpR1
 zu/ez7ilAdb51KSyzjTMI9nZ6e9mD/NcU2vfHQxPGeLfV8EFNB6tWzxZPTGFKvnSs5kMUtCw2eW
 3uthEOGbnd05J1j79kkVGKqBYxS73+6FNy6IP4IH24csEoZVCWnAexif6JuvIjljGxCHPO0CAP0
 zza70LPupAsAx9sWwXkUcIo8XLE5e7xl4TCyf8AAC4JHL0Ss3zKo=
X-Google-Smtp-Source: AGHT+IE0LV9HsELA5j6sgVzJuCwSc0Ym6SJKiHhHy3HAusxq68v+U7d8wXLefIlGLhNyVYREO+toLg==
X-Received: by 2002:a05:6000:25c5:b0:3b7:82d3:ff90 with SMTP id
 ffacd0b85a97d-3b900b4f0a7mr17234549f8f.15.1754998478864; 
 Tue, 12 Aug 2025 04:34:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c485444sm44524027f8f.66.2025.08.12.04.34.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 04:34:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 0/2] spi: cadence_qspi: Fix Smatch reported issues
Date: Tue, 12 Aug 2025 12:34:37 +0100
Message-Id: <20250812-cadence_qspi-v1-0-0d693d810145@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM0mm2gC/x2NwQqDQAwFf0Vy7oKuCLW/UkpZk7eaS2o3pQjiv
 3ftcQaG2clRFE63ZqeCr7q+rEJ3aYiXZDOCSmWKbRzaaxcDJ4Exnm9fNWThUXIv6AemmkzJEaa
 SjJczMmyfU68FWbf/5f44jh8Jbf5zdQAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Smatch reported issues with an off by 1 error in a test for a timeout
and also an error exit that did not set an error code.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Andrew Goodbody (2):
      spi: cadence_qspi: Off by 1 in test for timeout
      spi: cadence_qspi: Do not return unset error code

 drivers/spi/cadence_qspi.c     | 2 +-
 drivers/spi/cadence_qspi_apb.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-cadence_qspi-fdc9df3de35c

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

