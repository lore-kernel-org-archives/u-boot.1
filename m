Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71258E65D0B
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 00:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BD3C896CA;
	Fri, 22 Nov 2024 01:31:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9jCmek0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF85894AE; Fri, 22 Nov 2024 01:31:12 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC08F896CA
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 01:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e625b00bcso1334227b3a.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732235469; x=1732840269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dkkbbzxFGmKMAjHimLGdWrlja3ZF0CyOgVFg+5jNKCw=;
 b=c9jCmek00cAD8sWiWBPlKihQhQeM3HFOxQ5ua5vV7Y/77lf+O6Z/gWUw87mVFm0qPC
 byM9XDYZB6PGQme1K2vBHZKABK+af4j3+cwBSmWIeKA3Pm0vHH7dUOOYpM+EuqtDPG7s
 jOhxoCcvVwEENw3BWjZ77V1YIp6HLvqg42D21wN0ZwcA5kAa1YVTGB0YN4v4uT6FTw6o
 CR2PwVDUhNAsifNxY3UGP4pluZLgwxxFl5cjRtG2QrrspYb/3VsaeR8M0NMgJUlmvkSo
 nqS7pe4b//cLEUrLpD0lzLrPcmrkCFuA0uGI8NfvluYxQU7UAII62rrVUnJjkion5Fz2
 fhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732235469; x=1732840269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkkbbzxFGmKMAjHimLGdWrlja3ZF0CyOgVFg+5jNKCw=;
 b=Y5pfd4QIXmnPRM62VLsuj8jSnAFL6UiiAmW80MZ+m2LVsoz7CXlLIcjVrssj88aiym
 blQQnMVOVR56UFZy7QinZIjAQ8XxnZ1c22PvlnJS7tQjkjZe6a2Sh7yZClG9U/rmB6Tc
 Uuomb3Q7zxMqIKQ4MaJew4+mMkeb0/oaOqv30anfTcXgbgFMTPUJdz0jvpJluM79B2Yy
 RjC7F6CYzuuYBGuEsRO+w1fRUEtT/9tPgP5sjcW4Zwx6mPW5a7YzbhlmTqZK6c1Fgubh
 88baMu6IS4dZLtFtqu6rUiP8Gro6LBiY/Vt/IbCiTgHUen3/uXCM0scpTfjFpOldJ4HI
 0Xag==
X-Gm-Message-State: AOJu0YwVUuN17O4QGUValq26T1GcNnbDqtnP9B8dIvIV6bynGnY5idLk
 2AGpmSRrZp1uBsVW0ecl3FVVJegUfwmo74UdKj+Xv9suJP8OE9zvNqElIgQF
X-Gm-Gg: ASbGncvrr3ZUlUyLaOWFemKK1xghprHo9ywXVCaPLEJCbxXIU33UQvxmc1vMH/JfKA+
 A0IJvfz5oIsgh9zlGnbLyqjsiRQt3iTvf9ckcGrcha6lrDMzxxHyQEAWFDh2dancgvDx4/GUjGn
 Hrzc28KFNSw/wCts312HnG9Q5TBr373XM76ciTpBlioytJ2Xj0ocf+vSOZECuOeUtIx8w7AH/me
 UOdogIo+DEzgk83uX3TM457jJtTG6aFQdC3BZN72eIR7fExfEvpXGxDK5XuaeQI
X-Google-Smtp-Source: AGHT+IH4+UmuOqNVoqafWyhFsZDYLqYECRMWLPIXMJvowcCSptbUxVc02orVYI7rpONI0IXCqcOlKQ==
X-Received: by 2002:a17:902:e741:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-2129f67a1femr13856125ad.13.1732235468904; 
 Thu, 21 Nov 2024 16:31:08 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:db1b:7332:ce96:46a7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc225d5sm4181075ad.258.2024.11.21.16.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 16:31:08 -0800 (PST)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/7] Updates for Allied Telesis boards
Date: Fri, 22 Nov 2024 13:30:14 +1300
Message-ID: <20241122003058.270163-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.47.0
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

This is a small series to update some of the Allied Telesis boards. The
x240 is converted to bootstd. I've turned off MKEFICAPSULE as the boards
don't need it (and our toolchains can't build it). Finally I've enabled
IPV6 support so this gets a bit more coverage.

Chris Packham (7):
  arm: mvebu: x240: Use default baudrate table
  arm: mvebu: x240: Switch to standard boot
  arm: mvebu: x240: Don't build mkeficapsule
  arm: mvebu: x240: Enable IPV6 support
  arm: mvebu: x530: Remove dead comments
  arm: mvebu: x530: Don't build mkeficapsule
  arm: mvebu: x530: Enable IPV6 support

 arch/arm/mach-mvebu/Kconfig |  1 +
 configs/x240_defconfig      |  8 ++------
 configs/x530_defconfig      |  2 ++
 include/configs/x240.h      | 12 ++----------
 include/configs/x530.h      | 16 ----------------
 5 files changed, 7 insertions(+), 32 deletions(-)

-- 
2.47.0

