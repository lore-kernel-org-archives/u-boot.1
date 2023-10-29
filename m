Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C767C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 04:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382DD87C85;
	Sun, 29 Oct 2023 05:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f4uu8dpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1EB087751; Sun, 29 Oct 2023 05:28:29 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 734D287C7E
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 05:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1eb7a8e9dd0so2127142fac.3
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 21:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698553706; x=1699158506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Wa64SVGNFIgy66GkWY9Ydw5DpHa8D0By6/4Xs7l4X+Q=;
 b=f4uu8dpyyCRcX1Scq7Sb7Au+wIqJOjaPGNifFxXZYeJjnNnDU6NNbXew1z7qzURCi5
 HOfOo4XCFRN9w/u9nbEncYr7Oiigsp5v8AE/C4BiCYxQaITQMigtTL99FdipiTm2a6SJ
 RS4iFPZCrI5lDGqSuJogJ8DwNt6VdQB/dQrKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698553706; x=1699158506;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wa64SVGNFIgy66GkWY9Ydw5DpHa8D0By6/4Xs7l4X+Q=;
 b=urClva1o9fHg5O6Ve5qYu4Y6J8knkyyrcFv0lLeQQbBvxFxOCNz7Tq9ZhxU3KVla3s
 68wQDkJNXQrdx6fQVTxek1+4JsTnBO1sczlkHKNv0tCpYi/gcpUebTl3nfzzPEeYs/6b
 r+Qov/hvBvyHlH8J77zxyTWjUvB/Lw91dVaMgakhD7uhaxwq8Qv8A9m4qYAscd/S8OK5
 Du03QddDt3Xrg8ePwOKu+UwLrwcH/wQhhvfsLkkoKyFlBZAOfhfoLD1ad7wd71p2pi/v
 3i63QLI+lVayu0eeOOUYlf2sP7MJbd19UW3XnybhPRMj5OD9hRr4l5t14Jl/zb6IRPY2
 3PrQ==
X-Gm-Message-State: AOJu0Yz4YzXkSftDzc00PWCN6MYo0ear+n+YRCPj5j92x0iKAl375ODf
 VJc1Bc28vK1uKguFmoyjCwsjNVELBXp3ZIMud6gOvg==
X-Google-Smtp-Source: AGHT+IFuQU8m06MId7nO+4UFWmNGK99nft8XjzUHjlC95gKiH8RpoKfGq+n91WZ0iARTUr94uTrPZg==
X-Received: by 2002:a05:6871:a50e:b0:1d6:8b7f:ce89 with SMTP id
 wc14-20020a056871a50e00b001d68b7fce89mr7871914oab.51.1698553705856; 
 Sat, 28 Oct 2023 21:28:25 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 s194-20020a6377cb000000b0058ac101ad83sm2920564pgc.33.2023.10.28.21.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 21:28:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 0/3] tpm: Start to tidy up TPM tests
Date: Sun, 29 Oct 2023 17:28:11 +1300
Message-ID: <20231029042817.3938657-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

This series is a starting point only. It tries to provide some direction
for how the TPM tests should be run on real hardware and on sandbox.

For sandbox, things are relatively easy since the TPM is reset before
each test. Tests should start up the TPM before doing anything. Tests
can be run in parallel, which is fine because tests are independent.

For real hardware, tests cannot be made independent, other than by
resetting the board, which if the hardware is correct, resets the TPM.
So there may be more work to do to figure that out. The approach taken
in this series for real hardware is to have a few tests which do init,
then have the rest of the tests assume that the init is done. Tests
that depend on the TPM already being inited can use 'tpm autostart'
which works OK on sandbox and real hardware.


Simon Glass (3):
  tpm: sandbox: Support self-test continue in emulator
  tpm: Convert sandbox-focussed tests to C
  tpm: Drop unwanted special cases for sandbox

 drivers/tpm/tpm_tis_sandbox.c |  1 +
 test/dm/tpm.c                 | 77 ++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py    | 99 ++++-------------------------------
 3 files changed, 87 insertions(+), 90 deletions(-)

-- 
2.42.0.820.g83a721a137-goog

