Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CA9CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AF08309D;
	Tue, 26 Aug 2025 00:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kKbgMbnr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84DEF8307F; Tue, 26 Aug 2025 00:46:12 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9683C80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b0d224dso25188125e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756161970; x=1756766770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iPBzs3iqX6jtJDr/+Kp3HlEYp8LrvtpAJjDxe9U01pA=;
 b=kKbgMbnrwvV8sVMw8XWQe8f/mfNdbt6x/0M1ltxSXkZ8BM7Xq3cP5XE1j6tuLNWmTJ
 JiovivRMu6YHjSXKRyrC6bAY3WNaFI74aS7pY755sp8q4rXmfcWbZKTwFCjWSP8NvJ39
 w6neuSLkL8lojvNsIraojP+1BCpde0I5ZUo2IouIiFXAwB6kBKfprhkYzb0x7pmYFJoo
 /cjaSdTjAfhEdejkSyd3/CwzSGiM3TW3WyJjGeGjgDjJQeZ1QZKtH40vqilXgUh+OiwO
 g9GO+usHN0K2cIT+h+6nT4FhT+aDGeD8Jwb5rwKZYkU8ptDH9FuPuCVO7XoCaCCSsqKz
 FQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756161970; x=1756766770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iPBzs3iqX6jtJDr/+Kp3HlEYp8LrvtpAJjDxe9U01pA=;
 b=YOCJtwe1Id9edVJc4N/88QqOiy2bUdQcRCgaWwtCQFT1hPdheB7BaGP7Ytm5bGtJHz
 E/n4T0GfF/UbI+myQ5qC7W7vJ5PTtIaCiBzSzMpwhY2fZmPiab9WOkkHxEAq/UGt0VXb
 dVm9dzqXqYMvQ9C54AnmwRknqAV8UClIAL8yBGuxS04uN7oePn7vbLwLgLJzO++EXOoA
 hxjTKGwFZWrJLdtBtP5eNLZY0tV9JphFe10BchEqBqLLZstbwAVkwPffcpDW/G/Xb5t8
 D++DMhw5oKIZ2KFw30OXTToHJGyaRr+ocQB7V3yjABbcSEE7vRrz+J7s8W75GtfNKolc
 ioBQ==
X-Gm-Message-State: AOJu0YyYrJKTtxBzxhBa2c49+KtaItVUFLuaVzffvoQ75ZJTYPSl3GB/
 3sGJIBHWCrzFOXV20KtLX+3z7/TZNirYGeVdEAkyUA2H4NZO+h8EIlxXbp9MKGrsvRs=
X-Gm-Gg: ASbGncvB24ucz5qo+dIAlaw1H9KtF+qM0b/RqVL0bpvXi0YnO7zMbj9YUT0PDfrtBPJ
 RuutfNPTCFPwmN7mvZ6Gk5IWcTboxTZvnlH3ZqoEc6zCWa11TzM4EZ1patB/6BAB5AET5NQAqPx
 HSE3NU5ThP022kJSqNu5vkGyoTx/zfVUeP+jtnZ7U+G4o6zKLgMhvqA0enx2p7M4ZvZMIAAvt11
 oUYXlUBAcQBvcsr7jA+UUb0BvwPapfKBwFUGsAqE3AXbwsxWoNMjC299euYlxu8gPgozFYiReZB
 PJxlo1uBuOtPHZ1VPJ7pcWFUkl4dv/KX62uARi5t4vG8QD8zuiQoQzP9PchyCj5fAaDqcWSO0Bc
 GCPAQjpO9+OpUrKB5BJvNz5cxy8NJ
X-Google-Smtp-Source: AGHT+IFtLTWxevWNtTNb275Pt1AuEnrY9NNkmlGUFGBwqhsMMFPui0SKbgi5t5xsuAwqIoblCAMUQQ==
X-Received: by 2002:a05:600c:4743:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-45b5179683dmr156126385e9.16.1756161969697; 
 Mon, 25 Aug 2025 15:46:09 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:ba6:baf1:694:9882])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7116e1397sm13296086f8f.49.2025.08.25.15.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:46:09 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 0/7] doc: make pdfdocs: Address issues with the make pdfdocs
 target
Date: Mon, 25 Aug 2025 23:44:43 +0100
Message-ID: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
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

This patch series address several issues that were affecting the make pdfdocs target.

In the end, the make pdfdocs could be considered fixed. It is at least with docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025.

The thing is fixed only after the 6th commit. Each commit solves one issue, in the order as they appeared. I hope it makes sense.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Adriano Carvalho (7):
  doc: make pdfdocs: Specify texlive-xetex as a prerequisite
  doc: make pdfdocs: Update the description with the needed steps
  doc: make pdfdocs: Add pip install pytest to the list of needed steps
  doc: make pdfdocs: Ensure SVG files are converted to PDF before the
    compilation of *.tex files
  doc: make pdfdocs: Update empty SVG file to something, otherwise
    compilation of the *.tex files fails
  doc: make pdfdocs: Increase the maximum list depth
  doc: make pdfdocs: Remove redundant "-j" option

 doc/Makefile                          |   1 -
 doc/build/documentation.rst           |  24 +++++++++++++++++++++---
 doc/conf.py                           |   6 +++++-
 doc/develop/pics/spl_before_reloc.svg | Bin 0 -> 239 bytes
 4 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.48.1

