Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0105CCA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 10:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7E1830A0;
	Tue, 26 Aug 2025 12:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v/7M+/hI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6304583102; Tue, 26 Aug 2025 12:24:33 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B3083071
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 12:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso46423845e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 03:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756203870; x=1756808670; darn=lists.denx.de;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOZAE0hVn5hjyX8EIHjaGDH+xM/iU2avvqJILXk9S/A=;
 b=v/7M+/hIAj5Z4bWhbKuazqV/W12niipzrVf8Qc3xyZE2ZIsXKoYj1IiKzsatZsteYq
 9G3F3dMMeAB3rihD3mEV544w4HJzyyFyJFslRigVZ2WDYAdlN2PZKD2fuzJ0+866YvSw
 R2CQq+PskHalliWfI2qeKBEj57YCtYwHIvdIVz/GUp5uPBK9CsYABC35lufZI8d4JSH6
 kUMsctn2FcoujsQAASSotmocGpwmp4IcokGFYKB19VEs1rT6uxcaPJYnYlj5ZKhQaDTd
 jsVzQifjwzd/Ju/W09mNYURj9+K/x4DIgvVCKKfqrLd016E34w24VGwCktAHFB6QHoCC
 +FQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756203870; x=1756808670;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gOZAE0hVn5hjyX8EIHjaGDH+xM/iU2avvqJILXk9S/A=;
 b=BzTwzDk9KPck9l3ZWITnSVbrT2mz8CUVD3zmmBbFbwFlYzLzum2ypqE76j7oLODWli
 jQfhrBsV9fhESz+YTxTu7UpzF3vWM7CVL+b1pLPZZf3ml/FLWvfud+NA8lBQw05CaRew
 kUoQz9u72x7hjCk/EgifzcnD6dA/HbKdEiieGom5BH+UzjYCCpfBdg5Svd+e78YpOVkf
 O99vr+ynsijZU6+87zpbypojasP5xKHyK42LbUvUDU3SZThBpxp1k1PGsArQJuH0tLis
 NYAbxRt/TVGDOYShOAsAhT++sEAVqhjyJfscJt6W5m+Z22IcUUJeCY3XGo7Vj95fQwfy
 QnaA==
X-Gm-Message-State: AOJu0YwZRsbuH2NYWXVZ1oxDwHTbCsw/zPren85miP65nufnCr78b9PM
 qDUJvm+ASoob+NbfDM3+Q4aVy2WGZXh4aKSGX0AZPbPi8FT5Gr8UGnHo7gzkyTvdEbdHZLkUTLq
 49aLAPSg=
X-Gm-Gg: ASbGnctLvPP8kqTuHl/ZQSL8volBN323iWQRUcag5OJLHovrG1pZ+q9HTnaYMaQRq5n
 bbQ/xw1ixSYOp5kpW5iI5sr5U8yKjLbmSzXJWXjJAByv/v1jHC4umWG91+bGrZIKcPw2vNaqklO
 K8m6mqkCGo59qI4KnEa35oiZI+oHOH5VTdYTBZ3fUzClHVIjXYBm16/QVpT3W8QLe23b/1FSBQ8
 jXq1chW1EMTQB27UMzZmnbwob6JriGY6nrCll+DxYR1RY+mtbTuaB60jMCMvAbHwmmwYodlfTBz
 HUZDnx3Ju5a4MBTM6l8xgHkHvdgnPeN6P1QVUdoDYJBiWwiSq1WB2BXZn46DvZQ5SJEGfMR00Sn
 KDSfDEylFuE9AF176MlFT19ireig5X+kTzIesAbU9
X-Google-Smtp-Source: AGHT+IHzqZCkR5OaQZU0kyR7YWp0o9JUlnRL02kObGSWp892l8TQXqvNIBdD8NGIIbX1nRtS37SfEA==
X-Received: by 2002:a05:600c:46d3:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-45b517d2733mr114003125e9.29.1756203869826; 
 Tue, 26 Aug 2025 03:24:29 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57487c55sm144069265e9.16.2025.08.26.03.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 03:24:29 -0700 (PDT)
Message-ID: <c535ec44-81ad-4022-bb25-dd5f31fbe36b@linaro.org>
Date: Tue, 26 Aug 2025 13:24:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: open list <u-boot@lists.denx.de>
Subject: [PULL] u-boot-at91-fixes-2025.10-a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Tom,

Please pull tag u-boot-at91-fixes-2025.10-a , the first set of at91
fixes for the 2025.10 cycle.

This set includes smatch fixes for clocks and mmc and one QSPI fix.

Thanks,
Eugen


The following changes since commit a8f20bb6650df56d2600cda2c66f9349df9e49c8:

  Merge patch series "bios_emulator: Fix two issues found by Smatch"
(2025-07-29 13:14:52 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-at91.git
tags/u-boot-at91-fixes-2025.10-a

for you to fetch changes up to c1168f99387b40f5e3323ff16c670427c2c8a66e:

  mmc: gen_atmel_mci: NULL check variable before use (2025-08-13
12:59:36 +0300)

----------------------------------------------------------------
First set of u-boot-at91 fixes for the 2025.10 cycle

----------------------------------------------------------------
Andrew Goodbody (5):
      clk: at91: Fix testing of unsigned variable to be negative
      clk: at91: Fix use of unsigned loop index
      mfd: atmel-smc: Ensure match is initialised
      mmc: gen_atmel_mci: Remove duplicate checks
      mmc: gen_atmel_mci: NULL check variable before use

Ramin Moussavi (1):
      spi: atmel_qspi: fix race condition in transfer completion check

 drivers/clk/at91/clk-main.c   |  3 ++-
 drivers/clk/at91/clk-master.c |  4 ++--
 drivers/clk/at91/sckc.c       |  8 +++++---
 drivers/mfd/atmel-smc.c       |  2 +-
 drivers/mmc/gen_atmel_mci.c   | 28 ++++++++++++++--------------
 drivers/spi/atmel-quadspi.c   | 15 ++++++++++++---
 6 files changed, 36 insertions(+), 24 deletions(-)
