Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AE0C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDFE8210D;
	Thu,  8 May 2025 09:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iMGLCdnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 051F8828A2; Thu,  8 May 2025 09:29:17 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AC628059D
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso4525875e9.3
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689353; x=1747294153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+eSEhOZS3sskzKcwC/FFot4kWQXfuMxxVep86P0gGns=;
 b=iMGLCdnrlL7NmTxT0nSKVeVJW1pfKHVD5RzPmCmGQ0gZjzqrkhhyh2NGYC4iOv7S9O
 qlOPumD9HHCTZtGH0E0eH9xECHieIGi/WMpauklYRMMq4FSpGbm/HQAboPLtpoT9vhAr
 9eMgbHiOOcw5EjujV56O2naUHgKsfvYLVOatM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689353; x=1747294153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+eSEhOZS3sskzKcwC/FFot4kWQXfuMxxVep86P0gGns=;
 b=CfqmyYFR9WsfKtCKUaHwVKC1iBByqu8/SbomlfEIcHWSnujuXVFlY+o77Si3V5IX7/
 X4bGNSZuXGVgp8RuS42miyM/g+Ehugsyk2Jc/Y8Q20EEHAwbniNcC611rE2UXBMJ6Ok3
 0+KgGqLz9QcWNAr0AV5g3ZQQ/25aWA8723HqkUxivIAq/MrH7KbMy22hG2Kvi+mZ5VOb
 GL5iux05DEe2fNKuk5hq4aANu7vkB29RX+rmiKXxu5wXKbwpiuxGdhWcc+uB0B+XLUnb
 hqldM/ErGNf7ylP7nZgTbhuteO87WRdAw0Tho8ZcbQMXQoBS9gpcYliMhcrbJhCNBvKF
 7GpQ==
X-Gm-Message-State: AOJu0YwH+UPc8bXQTs8CzlNpNt4zk9K7rK3/IbqJIffuYXjWp6m0ADJI
 0hNdBDHXGvu2bRz0cMAz4Eg7N78thRp3YU4zQkO6VSrCGIXgZSIWHLiFsSiUNE2CSlalK2aDRi2
 qfCrLLQvtXA==
X-Gm-Gg: ASbGnctgLkFH283mFA88hE0/vzrrVj9j2A+lLPskuJgkALI7+nYF3TxF0CjsYevVHgi
 K61Kzvw8aDUyh+i/vprCCU6yDMQBt/H0gRY/nUJyMOAsBXCzrJBMNBPru/NL7X1RO6jIU1UTb0D
 kilstqpIyk6dpkZJ7CbvU8Eh6lvUkOkKw1oOkR1qnCfBLgs6TRa3zI4O+fC5wD/2KaSZirRIUCz
 mr9AqI61H9R5eib2WBnMFgXyPUsndkVqTlibUJejvFxeGKOt7o/ushQxjJgF6oT6SdO9LmINNfA
 FsFTlTj0SE/M/Ng2dAv0AADOvluXS3F4aVat1R+IbqPPFESv
X-Google-Smtp-Source: AGHT+IEl2O4UmmXBZrVcJ7Mu7pV17YTNakuaQM9jyZV2RSbImNycmpszjRj6QYl0WxTzlF8xNIt0Wg==
X-Received: by 2002:a5d:5988:0:b0:39e:e557:7d9 with SMTP id
 ffacd0b85a97d-3a0b49e9fa9mr4196465f8f.5.1746689353435; 
 Thu, 08 May 2025 00:29:13 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Brian Norris <computersforpeace@gmail.com>,
 Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/20] patman: Minor improvements to prepare for series
 handling
Date: Thu,  8 May 2025 09:28:24 +0200
Message-ID: <20250508072907.207175-1-sjg@chromium.org>
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

This series includes a number of internal improvements to patman:
- Tidy-up of parsing
- Adjust how tests create the git tree
- Support for creating patches in a different git directory
- Faster determination of the upstream branch
- Ability to collect the body of a commit message as a series of lines


Simon Glass (20):
  u_boot_pylib: Tidy up quoting of cc and to
  u_boot_pylib: Provide directories to gitutil functions
  u_boot_pylib: Speed up determining the upstream branch
  patman: Add all files to __init__.py
  patman: Allow setting the current directory when sending
  patman: Allow setting a git directory when sending
  patman: Correct use of str in code
  patman: Use itr instead of lines for iterator
  patman: Use .git as the git directory
  patman: Use variables for series ID and title
  patman: Clean up creation of the git tree
  patman: Use git to set up the test config
  patman: Correct some pylint and asyncio issues
  patman: Split parser creation from parsing
  patman: Add tests for help
  patman: Split subparsers into their own functions
  patman: Move arguments for sent into the correct parser
  patman: Move -H out of the send command
  patman: Tidy up function comments in the series module
  patman: Support collecting all lines in the commit message

 tools/patman/__init__.py      |   9 +-
 tools/patman/checkpatch.py    |  12 +-
 tools/patman/cmdline.py       | 230 ++++++++++++++++++----------
 tools/patman/control.py       |  14 +-
 tools/patman/func_test.py     | 278 ++++++++++++++++++++--------------
 tools/patman/patchstream.py   |  44 ++++--
 tools/patman/requirements.txt |   2 +-
 tools/patman/send.py          |  45 +++---
 tools/patman/series.py        |  47 +++---
 tools/patman/settings.py      |  28 ++--
 tools/patman/test_settings.py |   2 +-
 tools/u_boot_pylib/command.py |   5 +-
 tools/u_boot_pylib/gitutil.py | 102 +++++++++----
 13 files changed, 521 insertions(+), 297 deletions(-)

-- 
2.43.0

base-commit: a15813efc66b624cede0f3c6107ca77abbffe1f2
branch: patc
