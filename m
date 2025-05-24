Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6497C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 13:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D90DC8307F;
	Sat, 24 May 2025 15:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UFtTXlkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E21830B4; Sat, 24 May 2025 15:06:53 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB16C83055
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 15:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3dc978d5265so4434045ab.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748092009; x=1748696809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xP2+HW7nCkhn1+lAaOPzV7Z7PHMOokS4STan/ewcIQw=;
 b=UFtTXlkSrSGtEeQGMd9STNrRXrlk/TtGYVOFcaHrKjnCNdSdxULMFYVC7B7WybQYaW
 5spC6uPWq8L2E4O08fisVXKROq3kf1me0K3/QmWkiGSI16hasaOkC7bKoYe4mxIqIvnV
 9gjTfCr6Ue+iMUdLRLxCOJAMiZ9pooF+je/2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748092009; x=1748696809;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xP2+HW7nCkhn1+lAaOPzV7Z7PHMOokS4STan/ewcIQw=;
 b=UKSRiXRsRknbJzxe5ukPSsKQVpUBICbCGLDYwrMR7MiYK60yKpZbwOm90uyVTlTG2F
 W8MNI0DE0gFcdPKb9StostCEyOmJJJtBf23KAm56otqU9p0FEahDdB/vF5Vva/RlcBuB
 BlMXTWGXQKJ3/ooDxHgfB8NuJOjEKO3E52pz4BTbS/7ImyzTsIF8U3q5Dfpc2GsjZbU2
 GkalcEst8ILmr1XukcgXV8ndIlqUeldBGF1qisppl7XAaW1/nf0Iy3MMfHh+GwrkgJKl
 x9eQfPio9gzdigT25FMKmAsH5MkjDKbysi4UmjjQmfxq8K4YT55Ob7Gqwg7D8Ux8Sng/
 2MAw==
X-Gm-Message-State: AOJu0YwU2fK0YEoCufUp6E0y4bZ0aUblhsb9So2Y4yLk0Su5EJOh8w1I
 nKa6Fxq7CDHmwv6FIFVpgy9aEP3Mto3FwuYetiHbwNyOETyTf6UhdcRPrbYwRxxCb6ePOQ8zUTD
 KwPUIsJMB
X-Gm-Gg: ASbGnctrbiNds6rymR0yVTJ2wDKYoE0fS487e7VYLu1QsTgwVojWpzTpFO+KiEq3PqC
 5iwz7hUYxiSIHaRZt/wyC6tftkt1XIkBm7lE7D7l1cSIkSeyvQmktk6InbO6gRLBPa6HaIkRpZp
 vLWHRKkyk/+6FMycp3tgHA13HHmOh9ZTzbbpMj0Aj25xIJ4lWTFyNYT2XqTI2AFKOWbCDRIGwnp
 TVGUsGTUAjeJFSoPJMDHB9Mkzim59quVSVJMDEyWdx1wVt3qQgFtzOPwMBhC8i+8yYiR37AwoYE
 vTTcqaMbF/KkL2rKsObMWFHmEsn0E66b9qw/HPps27Hb56KAYm7h60shW4BAJ8uuGG9mubzZ0TL
 Bj7OB0o/jQrWa
X-Google-Smtp-Source: AGHT+IGLdxKfuGx4XlnMvvKxUX+1H7IQzhcnnA6iOAFaNBRY+tzIlAcRUJTTwrhw4bSMseJcqVLHBg==
X-Received: by 2002:a05:6602:4c0f:b0:86a:2f67:177c with SMTP id
 ca18e2360f4ac-86cbb89cfe8mr307653139f.10.1748092008735; 
 Sat, 24 May 2025 06:06:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-86a236e898dsm373238339f.37.2025.05.24.06.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 06:06:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 0/4] tpm: Start to tidy up TPM tests
Date: Sat, 24 May 2025 07:06:33 -0600
Message-ID: <20250524130642.902486-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Changes in v3:
- Use 'check' instead of 'test' when naming test helpers
- Add missing tpm_self_test_full() call
- Add new patch to skip failing tests on coral

Changes in v2:
- Keep test_tpm2_continue_self_test()

Simon Glass (4):
  tpm: sandbox: Support self-test continue in emulator
  tpm: Convert sandbox-focussed tests to C
  tpm: Drop unwanted special cases for sandbox
  test: tpm: Skip failing tests on coral

 drivers/tpm/tpm_tis_sandbox.c |  1 +
 test/dm/tpm.c                 | 77 ++++++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py    | 86 ++++++-----------------------------
 3 files changed, 89 insertions(+), 75 deletions(-)

-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: tpm3
