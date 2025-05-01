Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FD1C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD42B8070C;
	Thu,  1 May 2025 15:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/iJzh2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75BD980EFB; Thu,  1 May 2025 15:19:25 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141FC8059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3d93c060279so3153485ab.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746105561; x=1746710361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mSE7Wk5lkdZSApvNx+97szAFXYoWZj7OynPIMnNCiqA=;
 b=e/iJzh2HL2d615pWSTrSb5UaZ3xqDlnW410gIRt/Fp7q/DcswTQGVvWK5pNzdMjBCN
 pZ6xwoFM0iE3Cpj36+q11tkG0pJGnTnlJu52GyG3zxbdROuQRhLfuNdxcorTY1dwLmY4
 pKw4E7Lg0semW2MDkrxAZ97O8vefsvkP3Y+e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746105561; x=1746710361;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mSE7Wk5lkdZSApvNx+97szAFXYoWZj7OynPIMnNCiqA=;
 b=xDADXGm9QBaJgVFK4X4DUb5DZV+VPqIMjfqxzujVFtgRSs8E+cWdB4h4xTkELAWX6n
 mZvQJfemZTAOtgBj1ahVir3O/SXdrm3mZVNKFHns56ymKZPMkX60UUeMopKaeecrz13J
 viOiZnn9bRUf0uSFHUHCvjx0obU1vrkagKfMc3o5HsEsCRwK9goLTe3V7huP8XwZ3DIo
 1Hc2zmNpmrHIvGfrEk0dkZj0jC1qZ9BpqriM9IlnDWnFSKyxsMMabaugKxB3cq9lc+eA
 7bFC7bWZhdOw4zmnHzd713DPumfkIXx5aHtR0wUPFyqH9mVIcWYE/XVBo7/2pvUnK1e3
 v/qw==
X-Gm-Message-State: AOJu0Yzndm7uiYoKgIj1Tryv0xirWkOPA3LHv7iUO5NwQswLqTmA4VSl
 wrfWy1Nm8s5QLRb9smjX3EFJ58PY3kEs/qEvyyGYHUNFPWz4KXqVqiVMc3b3DVJyx0l49chX/Ig
 =
X-Gm-Gg: ASbGnctQQm7GQ8C/5KsgMB5Uiv8NZ+OK/inu+FZagHhuzkdI3JLglWyjM9TJ5Vr5RFI
 SWgtO+EoF+G2TnYG8n/lwBZTLchzAxwhRACjaMbnLKatkHa/Ivd6Oh/WbRWEWzJSWBLbg8TBu0S
 uG3w4XGCxHknfQLFO5DL7Xxo1NKymX4NWZD3ceQ8jHwAbtU2rDn5A9EbqJcGWTGtqDG5xB8QMvL
 AxJbKkRVdvoRYVDBaCp5K4JKAWiNAS7rjfotR6E4SwGWn41RSg4XIZjCn6qd0JBTW+O7sqTQt6q
 iJJApuIvll8lEdy2V2l6JYg2et8un7JzAkFTCckhUopNQzqzaYfVntynlaLOWJyuH+3xLc97KaO
 AGVBZcS+uZXoA
X-Google-Smtp-Source: AGHT+IE9hRuuKo13bRrFomEHcYYs4ZfdCjGNrho3t6pa+N+OlJsN2hB7G1nIy6H3hONbAFr2FfcfTA==
X-Received: by 2002:a05:6e02:1d9d:b0:3d8:3b31:5046 with SMTP id
 e9e14a558f8ab-3d9702929a5mr24794515ab.17.1746105561282; 
 Thu, 01 May 2025 06:19:21 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f882fc9c2esm160328173.93.2025.05.01.06.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:19:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Date: Thu,  1 May 2025 07:18:32 -0600
Message-ID: <20250501131858.2160756-1-sjg@chromium.org>
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

This series restores the original behaviour of extlinux booting linux
'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instead uses
a limit of 10x the compressed size.

It also adds RISC-V support, since it uses a similar format to ARM64.

Future work should integrate the code in 'booti' into main 'bootm'
logic.

Changes in v2:
- Change the commit subject so it doesn't mention ignoring SYS_BOOTM_LEN

Simon Glass (3):
  boot: Add a function to check if a linux Image is supported
  bootm: Add RISC-V support in booti_is_supported()
  booti: Allow using 10x the uncompressed size with booti

 boot/bootm.c    | 31 +++++++++++++++++++++++++------
 cmd/booti.c     |  1 +
 include/bootm.h |  3 +++
 3 files changed, 29 insertions(+), 6 deletions(-)

-- 
2.43.0

base-commit: d755a928c802f9807abb5270d80c4b25aefefc1d
branch: fix-booti2
