Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FC0C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F1E386FF2;
	Sun, 12 Nov 2023 01:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="htKR+qH1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2B786FE9; Sun, 12 Nov 2023 01:44:01 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC6886EB8
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7a689bd4928so105143239f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749829; x=1700354629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SnuS5l3oGEdFpU5ykzWNYECzGaZLVg4303T/jA8v/Ic=;
 b=htKR+qH1C3UQR5As538VUY6UzkkSe8Om/HBVLM+GsWlNihd0eKow1aeXm0R9kZXhm/
 uJjLyBT7zhs4bU7xG5/qce1iWWtpZ3H5tWFS+gMI2Gc1p8RMCpdiVPMzbBUjHmb8Avsj
 035sPAQzfGXU6mte+YpPL+Uyr2UqFtvV4Nf68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749829; x=1700354629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SnuS5l3oGEdFpU5ykzWNYECzGaZLVg4303T/jA8v/Ic=;
 b=YB0VsnG8lqvAdJ0Pj6B87Um+Qn1HgtNLDY2w1x2Q3Wuv0MvgjpPU+4GhPsQpOcqIEt
 xXDRPoDzHSDJhUvVPzvbAKGh+u2ueUNH53KYV+KEz62DABZDl9npdlL1RSnxc8iSU0YH
 5Ned2C0haPhPJtnY4wo5Rps3Ctn02YbIZKpVI/TV/hosn0JBaTZD7dNoXsqRytSzBeb8
 n/w48zCaUzqPeY3lScth5JdmUti3v/jWzdMWgm4RMTL+ctdWXH+K7SjI/+M08cal5ZzR
 43674SUwvLfQA9EK/5GaY99wwNAiKyfy80aHCUKVisPXzM8ugRG5vQwUFs3uFt/M+K49
 KvZA==
X-Gm-Message-State: AOJu0YxU9Lt1iqYOoZt17u7XNpWnFa/S8FBdEGAxWk8lDTFYNlJx7JWS
 SmXYyxTnZsvpegy3Y9JFbLaqe7zAQdpHYRAO3u9NLw==
X-Google-Smtp-Source: AGHT+IGM/HBSuB1yoOu496xn6/0D8U9Hkx7SvA+sPp/M5/75N8GRHUTbJgWRQ3P9xWWdALD6Pr1Iyg==
X-Received: by 2002:a6b:5115:0:b0:7ac:ccd9:da93 with SMTP id
 f21-20020a6b5115000000b007acccd9da93mr5850488iob.0.1699749829004; 
 Sat, 11 Nov 2023 16:43:49 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 k39-20020a056638372700b00457a6f281ddsm711388jav.59.2023.11.11.16.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:43:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 0/3] tpm: Start to tidy up TPM tests
Date: Sat, 11 Nov 2023 17:43:35 -0700
Message-ID: <20231112004345.80145-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

Changes in v2:
- Keep test_tpm2_continue_self_test()

Simon Glass (3):
  tpm: sandbox: Support self-test continue in emulator
  tpm: Convert sandbox-focussed tests to C
  tpm: Drop unwanted special cases for sandbox

 drivers/tpm/tpm_tis_sandbox.c |  1 +
 test/dm/tpm.c                 | 77 +++++++++++++++++++++++++++++++-
 test/py/tests/test_tpm2.py    | 84 +++++------------------------------
 3 files changed, 87 insertions(+), 75 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

