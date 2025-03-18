Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC7FC282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92320817D8;
	Tue, 18 Mar 2025 16:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D5FsN5uR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 960D08129F; Tue, 18 Mar 2025 16:21:09 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C874800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso16313865e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742311266; x=1742916066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qDy0IvSV0GL2p0Hy7AWL1fKTSzdNyH8tsFooBoVBipg=;
 b=D5FsN5uRA1edQH+VKGUOfFXhE1COfB+qDDLC4F0qXaDSSXj7L+CoONfS23DTVuZrL5
 K2uCUuJuWsuyluXwbfyEu8HkefD+mG5oA1I5IeSa46kg8/PDLtWPGWMppcKFYy4++LNR
 HOrZXEgwK38KvPowzVB8M2f6vQcDH1r6aJiAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742311266; x=1742916066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qDy0IvSV0GL2p0Hy7AWL1fKTSzdNyH8tsFooBoVBipg=;
 b=wDf6lVLRj8qcHemSGiUpNelYvrkkO+DhzcBR3R76V8AVa+JBDF0B3hDwJv2EZNrVUB
 rlolKUN9VvgL6asLAIp1wd7UvheF3J/bG15IT3C8TgzmJa4RNwXUwlB5o+wdPRLe20PB
 h57DhJrB2V5381YEpDzS1yF5zKxcKdVpoJGZ23Ds+CfOu68mpcRo2Niarz5tJf8b3ZNr
 Bx4Gg86WULF1it3/B7dhzivZ4Ma5j7wQEOanoqecGObLydBOiYj7Bz+pGJwT0VGo8bTR
 gm+0qdDVqsjYpDiNaBmr/jWFLhGI3UfJLjSP/+ALT1LdKfQeIkCvEnFmDvKNGzp4sP4b
 hxyw==
X-Gm-Message-State: AOJu0YzBHsQOZabai1/B/6DF2EhZEcy8boZdvkzfjvnX6eZtVutHWYAb
 iH6AnjyHrRLP2bIH0BtHteYxoHEeS4//2hp58ZLehLp2bk5u0Ufgy1NwQBDqYajHWEjtzx0s0Qo
 yrEFr
X-Gm-Gg: ASbGncthfjv85P/Uld2TGf6wqaS54luSfCxvydrdshosmL5slQKPFahnp+mimMZRs8f
 DWxjy13HWHjYfGTnIOvkxi9/GGXTVI1BKUa+wLU9lOUhguS35ZZclLLbXwKZswhipcfKxEj0jLU
 oMY6J8zF5WggCzdpwdlsW1HSPVJPlVKc2qQveB+XVg05kntZ3gKv1zZIBMkwpdtVb58A74MNXxT
 eDSKm0VoL3b5N2fPBWGRZjY6P6dzvm1ugqIseChTMCzSJFZCjJzWW2WgK/cqgfr/XQK3uhK5aDi
 gGdS2vwVc0DTmikkNjOIhViJaO5IY3rrk9gVyxB/Gn3m7EHWymzt
X-Google-Smtp-Source: AGHT+IFH9Ik4PI5iMsRsHwftWJhcR2Eld08WAguMjFTAaBSjPonhC+C2Po6iRuyg7dC5tZdYtQt9lg==
X-Received: by 2002:a05:600c:1389:b0:43d:224:86b5 with SMTP id
 5b1f17b1804b1-43d3b9519f9mr30227225e9.4.1742311265614; 
 Tue, 18 Mar 2025 08:21:05 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe60d37sm136962225e9.27.2025.03.18.08.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:21:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Soeren Moch <smoch@web.de>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/7] membuff: Add tests and update to support a flag for
 empty/full
Date: Tue, 18 Mar 2025 16:20:41 +0100
Message-ID: <20250318152059.1464369-1-sjg@chromium.org>
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

The membuff implementation curently has no tests. It also assumes that
head and tail can never correspond unless the buffer is empty.

This series provides a compile-time flag to support a 'full' flag. It
also adds some tests of the main routines.

The data structure is also renamed to membuf which fits better with
U-Boot.

There may be some cases in the code which could be optimised a little,
but the implementation is functional.

Changes in v2:
- Rebase to -next
- Drop patch with the 'full' flag

Simon Glass (7):
  membuff: Rename functions to have membuf_ prefix
  membuff: Rename the files to membuf
  membuf: Rename struct
  membuf: Include stdbool
  membuf: Correct implementation of membuf_dispose()
  membuf: Add some tests
  membuf: Minor code-style improvements

 MAINTAINERS                       |   7 +
 arch/sandbox/include/asm/serial.h |   2 +-
 boot/bootmeth_extlinux.c          |   8 +-
 common/console.c                  |  32 ++--
 drivers/serial/sandbox.c          |  10 +-
 drivers/usb/emul/sandbox_keyb.c   |   8 +-
 include/asm-generic/global_data.h |   6 +-
 include/{membuff.h => membuf.h}   |  92 ++++++------
 lib/Makefile                      |   2 +-
 lib/{membuff.c => membuf.c}       |  73 ++++-----
 test/lib/Makefile                 |   1 +
 test/lib/membuf.c                 | 239 ++++++++++++++++++++++++++++++
 12 files changed, 366 insertions(+), 114 deletions(-)
 rename include/{membuff.h => membuf.h} (68%)
 rename lib/{membuff.c => membuf.c} (79%)
 create mode 100644 test/lib/membuf.c

-- 
2.43.0

