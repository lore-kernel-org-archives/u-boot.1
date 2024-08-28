Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D305FC54747
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1936188A8B;
	Wed, 28 Aug 2024 03:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PY6aTRwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 307B888A8E; Wed, 28 Aug 2024 03:44:37 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B747688875
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-824c85e414bso214174839f.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809473; x=1725414273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=US8lenqosrseHrpdisQpyO+a+5Qan7uuIIdhkt73Wnk=;
 b=PY6aTRwftRyw2UMtdVHvReKETa+mSfhfBUylEdi1UoGI7xDwxwmJ6mj+4XS5kOdYt4
 BVWyqhemXdDaE/lpd2faclSB0/PHSBp+UmnkSMh+4iofdismtBRxfEAyjLK7oM9twZhb
 KdCRdRWmdTZK7cK/j1D7jLlbqJifjgcKYsJ5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809473; x=1725414273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=US8lenqosrseHrpdisQpyO+a+5Qan7uuIIdhkt73Wnk=;
 b=VJqv2jK3BamuSzP5y1yvLCiMBNeuKZfOMPM5U3bJhJP6RGu6CKjjRIjFJFkSBPvgcO
 EdduDGXKMhwVoJHaQ9OKfon2p1ydKBBlv6nK3AVE1e3NomJbluPWjtWy1+GOOswxS1+r
 M1VIr7ot4u47VpfOftgeS+tOsG96hkteF+VoY25bzIyzBgiC+MnfuFkCEQ2sRC9uc6q0
 k1TwAPXA8AJ7kN2/i3gF7l6N9lX1cV26YDBElU/14EEvJCaG8U3pHJ7QlFdkGFyi/LNr
 nbaBGBijKzAhFoxHSds10cc3EwMh+4DAB7E58SS8KGn9ZT2w9Cens2o+upfaxKfYNyNY
 VROA==
X-Gm-Message-State: AOJu0YzWaOYOjKh6pK67vnBvEjqjCC+lt60p9nB+4F3IYRDkuDOOZIPg
 dsDt5EsI3Y9AE0llbYvtPmC2CB5u4q7vwGGDGFAuGUYKB4o1EsqfzD756mcqVT61t/1vjWO3vjM
 =
X-Google-Smtp-Source: AGHT+IHUAKzDOQ28KlA59bjVfrJTe82u2ZAgBjee0rogwFknkCqkolAj9Eo3RnAakR41X53xyZE08w==
X-Received: by 2002:a05:6602:341a:b0:7eb:7f2e:5b3a with SMTP id
 ca18e2360f4ac-827873116d3mr2071312539f.2.1724809473133; 
 Tue, 27 Aug 2024 18:44:33 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8253d3da8b9sm366342439f.0.2024.08.27.18.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:44:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joshua Watt <jpewhacker@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tom Rini <trini@konsulko.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH 0/6] x86: Correct timer overflow and add msr/cpuid commands
Date: Tue, 27 Aug 2024 19:44:23 -0600
Message-Id: <20240828014429.3320011-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

This series corrects an overflow of the timer which happens on QEMU on
newer hardware. It also adds commands to read/write CPU ID registers and
machine-status registers (MSRs).


Simon Glass (6):
  x86: Show the CPU vendor in bdinfo
  x86: Ensure the CPU identity exists for timer init
  x86: Avoid timer-clock overflow
  x86: Sync up tsc_timer with Linux
  x86: Add a cpuid command
  x86: Add msr command

 arch/x86/cpu/i386/cpu.c           | 99 +++++++++++++++++++------------
 arch/x86/cpu/x86_64/cpu.c         |  6 ++
 arch/x86/include/asm/u-boot-x86.h | 17 ++++++
 arch/x86/lib/bdinfo.c             |  7 ++-
 cmd/x86/Makefile                  |  2 +-
 cmd/x86/cpuid.c                   | 37 ++++++++++++
 cmd/x86/msr.c                     | 52 ++++++++++++++++
 doc/usage/cmd/cpuid.rst           | 68 +++++++++++++++++++++
 doc/usage/cmd/msr.rst             | 61 +++++++++++++++++++
 doc/usage/index.rst               |  2 +
 drivers/timer/tsc_timer.c         | 18 +++++-
 test/cmd/Makefile                 |  1 +
 test/cmd/cpuid.c                  | 22 +++++++
 test/cmd/msr.c                    | 38 ++++++++++++
 14 files changed, 387 insertions(+), 43 deletions(-)
 create mode 100644 cmd/x86/cpuid.c
 create mode 100644 cmd/x86/msr.c
 create mode 100644 doc/usage/cmd/cpuid.rst
 create mode 100644 doc/usage/cmd/msr.rst
 create mode 100644 test/cmd/cpuid.c
 create mode 100644 test/cmd/msr.c

-- 
2.34.1

