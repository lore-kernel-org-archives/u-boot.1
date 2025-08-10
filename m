Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6133C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBDF583327;
	Mon, 11 Aug 2025 07:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F5tRCXL2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5F483278; Mon, 11 Aug 2025 01:37:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6869983278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-459ddada9b1so35664885e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869068; x=1755473868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/16QZc6UEslC8mvyPOZJ2UMu5CW/K0YGXaEbylU5kk=;
 b=F5tRCXL2rFPSnUOw5+bwJYHqlNWKXz7adyY9mzwnOKJHcuoGpob4CwqfimaPFFnifH
 Mt9aIipkffxWVdsqpHXuv+yICcjgGlx0vcAjMCG48sMEevDlfVhlNLiPRuvbFWcX5AnW
 2rcfBeejxOSp83ArbK2Mwje59NXrxoU97f9CwudySJCVyZv1GCn3geXEkOwUIRNAOQYj
 cmk+ZIjAvPpj4FABawzzIl+gEqHJ94VwJlG7x9N1o35gP8RPsE/+Ky98Q1IDO8rM9wkL
 FspV7oB2vXs9byOJAiVMQf7mKNF+AmZ4rMbifngeGktsPY7UL5pAXW/1KXfPmbUWC2cZ
 DVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869068; x=1755473868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/16QZc6UEslC8mvyPOZJ2UMu5CW/K0YGXaEbylU5kk=;
 b=D1ALSjSdDAyp/Dm9BcQ35NrmTWkTvJkEJMt4+1zyqE+kYYTKhG3r2UAX+BUTgS6EVd
 TFuELmyPxtP5c4BKUmBEQz3pDwsqXBdW5A7mqDnau7YyjP1k/ZOMt6UumRdvlzbDWeKx
 D7iB6bXxnRHSkt3YOfXJ1U9OOpES36KpjlWlzRTgtgjjiDKKHYL6je/INLRK0lS1jaD4
 7Yxa/0WUsD/3QopUsd3dX4ffafYf2/mGq1UdbkaVJ1dBWdmOoAxLo/VdnSF2N+vX5mw2
 6AVza0zglxhbz5Ca9ApCkWFs4/5IX712/sa9MLPzHHCjyWDVnIVqXfPIZQbttWwyNeTQ
 1PNA==
X-Gm-Message-State: AOJu0Ywu178HW5T28WCfWjIXM+NGZzVZS8PoXXkCv9ZeHhBtBzkdcn68
 xDMJvancpyqKhfImTFurX9fxnwZaTX30lPhHYckevrakkW/8rxyiESUXsH6Nbg==
X-Gm-Gg: ASbGncvRzZ+XYxEB9ueJka52Y/EnrEUxV7N4J4tsfOxqEGh2JZdz7D8o0qVwq4567n5
 5PAnkbfiPz3YMoIEsbXNjUs88sxQrhkKCYU3/d4z9x0UCfOrZma2E6jjktiS1LW2FD3eTwNUJ+4
 mDvt54jsfoQJsHcCIHZK+mznvclbKT/xx+BBfsSHCsYwyN9kTznk4zLQNrFyRhRywYrZ6M/eS1g
 EvIL4u9cyB9BFwt2Dv3dj5kHZslqcfJmxM7VXAUbahBPd9pHtNFR9JLn/hYGM8JdZUPFNAkAWhs
 K1mBxeuCDHgoAsltka0biBhfIAbL2zM/R0y5Vp0Z5Qqe4UE9/8PNQKj6F8GET4tiNP0WQ/nzQ3P
 UuqlON88gZKbXrFBFrO+eyryoWbyT0Y0obdE=
X-Google-Smtp-Source: AGHT+IFstVjO6dGdKl4JlrrZEXkN6z3g9pc4ickugEfJXKyGkroJ6exp1RrolS8bNovJNzWjZmzZJg==
X-Received: by 2002:a05:600c:1993:b0:459:d3ce:2cbd with SMTP id
 5b1f17b1804b1-459f4ec3b8bmr94567015e9.13.1754869068010; 
 Sun, 10 Aug 2025 16:37:48 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:37:47 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 00/10] doc: minor fixes and improvements
Date: Mon, 11 Aug 2025 00:37:31 +0100
Message-ID: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

This patch series includes several minor fixes and what I think are improvements to the documentation.

I have recently started reading the documentation and plan to contribute to U-Boot proper in the future. For now, I’'ll focus on improving the docs.

Please let me know if I should approach this differently or if there are specific topics you’d like me to focus on.

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>

Adriano Carvalho (10):
  doc: Fix typo in doc/build/clang.rst
  doc: Fix typos and improve wording in doc/build/tools.rst
  doc: Fix typos and improve wording in tools/buildman/buildman.rst
  doc: Quote all long form options using double ticks in
    tools/buildman/buildman.rst
  doc: Ensure consistency of "buildman" (in the middle of a sentence)
    and "Buildman" (at the beggining of a sentence) in
    tools/buildman/buildman.rst
  doc: Add riscv to the list of architectures in
    tools/buildman/buildman.rst
  doc: Fix typo in doc/build/documentation.rst
  doc: Fix typo in doc/build/gen_compile_commands.rst
  doc: Use a long dash instead in tools/buildman/buildman.rst
  doc: Fix typo in tools/buildman/buildman.rst

 doc/build/clang.rst                |   8 +-
 doc/build/documentation.rst        |   2 +-
 doc/build/gen_compile_commands.rst |   2 +-
 doc/build/tools.rst                |   8 +-
 tools/buildman/buildman.rst        | 116 ++++++++++++++---------------
 5 files changed, 68 insertions(+), 68 deletions(-)

-- 
2.48.1

