Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F251C4828F
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6558487E71;
	Fri,  9 Feb 2024 20:20:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="PtTMPyP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D8C87E6E; Fri,  9 Feb 2024 20:20:56 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C9C987E71
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-560c696ccffso4121165a12.1
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506453; x=1708111253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hnf4AmQgS5LCXT7rR6h208e/kbzvAgS73BriM3eQS6s=;
 b=PtTMPyP1DFijfd382eg5Uu7GZv1JMML1bUYNl4A93c3Cf5CxIx8R5aTsJkdv9SYGnp
 Fk1LVAvI4rsmZlExH1bSDvatlxXionXEdUUuCXZZYXI7+2zAsizpiJXQA3d4CQK0lG8d
 9zZxuXj0XCpI0iAbQtAKwbWxsIhDoKISmk6VgFt5IhX3LHKvl55YCT6UuUgZpLZlWpzI
 IrMYAGufSRUoVqcMDxrTQVsqhwCdiHLuCUMcaS9vs0ojxJ4xA2b8F5r2RKAAGx6DfVAI
 nv7CE6KL6xeeqNcwdNg4/r5ZToTm3wudBmilwS51qi0uiv5vuoY8wGb2g+sNe0eXo4uQ
 pq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506453; x=1708111253;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hnf4AmQgS5LCXT7rR6h208e/kbzvAgS73BriM3eQS6s=;
 b=s7Tmv8UNWP1dV53BBZbWdi4X/uJiAM1zmNsz+skHOGySXjwEw+qHfimb/SfxKmym2v
 +/bvUD4vQ2wDSBoKGeZlOfWiBtkudydos1q5U3blA5tF9x8jB1LAG/r5HeXXFr9cjP/f
 gi1RrW4Lua340UWzCBRbAzkTR6A7dfrWdYhUcH3nkE6p3958bvGUlwVgbzWQSRZx3hBP
 aJXN1fS88vSjXvR0Ul/5sm/diLNf7jYnmyyqK0jWzHPQzr5wkaZVg1lK9K4xefYzxzmG
 hGlsqEaze1/lIRBNvcXlrnkwVK2NZ0ec+A6gd2V++htuj2P2Iau0BxXvPOCHaspXWmAU
 dCLw==
X-Gm-Message-State: AOJu0YyPpxTovoC9wlfck2Ykn6FSfwGWn2ExGeoEBDW6P4f1nUYlgRY+
 Cd8AbEeBgVKCI8UiMV55Buh/tHiKwmTq0inUVJe9pHYTxFV/M+lOdQsz5iD7Fx5/Ud9lZ7XKYnX
 AtpI=
X-Google-Smtp-Source: AGHT+IHMjlv+Io2ajcQA5tKYH+2a00a0Ld781ImNUZiiKZrzA6gKgI0jqZQlqG64zlJwhhve4yJNUA==
X-Received: by 2002:a17:906:4a17:b0:a38:187c:2a9f with SMTP id
 w23-20020a1709064a1700b00a38187c2a9fmr59771eju.36.1707506453328; 
 Fri, 09 Feb 2024 11:20:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW9cqxn8Oj4zZNudVp3GYobW9cAhFblW2yTL5h+t7Dvu7djAGNp6nKwCO2scZrj96jZeHPabrPzgTOtb/KpKMvhIx6tAWCO1eHtAUIlwF5bUJnXLpawtMsoSpPjU4ij+r58Gia0o5RKOCdYZl/Oo5Dc6ZiJW431QWXeLR/P4rtCYDgZ+bbYleFQc7yRi272uJ6N1gSEaTnLyjIAv5YB7RWxi/7rTcGK/7GD7/Ju+0Ae32mO7stwV7Oa2xmL079EwAzPCIv08nI1ihy8PJ8c1/54CI1URljkLblzpwncY8lhZfUlfah7rQXZsiqEUFF6tKeWsg+pO33p9lboL0271lp9FErFIt8=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 k6-20020a1709061c0600b00a387d9d6dc5sm1050214ejg.174.2024.02.09.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:20:52 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/7] AVB: cosmetic adjustments/improvements
Date: Fri,  9 Feb 2024 20:20:38 +0100
Message-Id: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

This is the first patch series for incoming major
improvements for AVB implementation, that include:
- Simplify and add more context for debug/error prints where it's needed.
- Move SPDX license identifiers to the first line, so it conforms
  to license placement rule.
- Use mmc_switch_part() only for eMMC.
- Rework do_avb_verify_part, take into account device lock state for setting correct
  androidboot.verifiedbootstate.
- Adjust AVB documentation, sync usage info with the one cmd/avb.c.

Igor Opaniuk (7):
  common: avb_verify: don't call mmc_switch_part for SD
  avb: move SPDX license identifiers to the first line
  common: avb_verify: rework error/debug prints
  cmd: avb: rework prints
  common: avb_verify: add str_avb_io_error/str_avb_slot_error
  cmd: avb: rework do_avb_verify_part
  doc: android: avb: sync usage details

 cmd/avb.c                              | 173 +++++++++++++------------
 common/avb_verify.c                    |  89 ++++++++++---
 doc/android/avb2.rst                   |  16 ++-
 include/avb_verify.h                   |   7 +-
 test/py/tests/test_android/test_avb.py |   3 +-
 5 files changed, 178 insertions(+), 110 deletions(-)

-- 
2.34.1

