Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6319FCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EEA84881;
	Tue, 26 May 2026 00:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="imG7wdKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDBE8848F5; Tue, 26 May 2026 00:26:53 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A7C8482E
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40ea36b56b7so7667268fac.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779748010; x=1780352810; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i77W717Ybt+xUso8e0hnMfQpwOj7qE2TFS5K5XCMq5E=;
 b=imG7wdKjxoMZ+MfzRq86v9phbzg+FI/8Kef+kdKeEp0+k+Gw5y7KQf1g5/a4wbpcSJ
 LSMolBj7ixm3CdsC0ogmLNVr8QMH8V0ZKmlqrOqzrAivPLbU1YgLYlw4dry1G6THP3na
 CJqh+jJE39ONbVEXSUYBAE9wkmsJJglx2UMkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779748010; x=1780352810;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i77W717Ybt+xUso8e0hnMfQpwOj7qE2TFS5K5XCMq5E=;
 b=E/lNn5fDfO1wnI/Bh6h0Q74OJtaH7wLmdE60Me0RSoECu7rW2y+am17SaKSmx9MYB/
 dsaYZHG20gnoqkw+/36ue/Ic0UVxlqofdDncN4m1B7f2DtRJVBvJM6HcExSb+7sz6ji7
 uac2mN+DwqF1mExrInCiGmDwzWIiGLD36tT95gVLInyUWrM5oCaY1Cp2Ww8bkLa4q9Pg
 d+wBNI4WWPQvA7hyZEgALNhRmIQ27Q5b++KiMA0Ok1odIvdSXUEIKW7EliBfkdafKyB/
 Qcq053QH50GsuoOhUXTQVLfN9vIPUc6f17xkjI3sTJ3P79sXdiR5A+yO2CQGZqITTTST
 LO6A==
X-Gm-Message-State: AOJu0Yy/KvfRcu6d04C2medFV3fj8zK8ZtcErtlgpcP/JIlLNX4/Nh4V
 KKtr80LrtBtwV8pNcsCmCYCWiGGg2V3h2jxe0OoWaBjIhfg1MnneNB65NkC7XThGRoN3XAgYUEK
 Fs8lA+7dc
X-Gm-Gg: Acq92OHR9XN6NtQcQiryIscjnaKvN5B2GWQe0SKVleLU11xtFEKCzzFDZ4Roc68JSsk
 YVH2a8c14edlMJZFRY9ySA1qafuQjotme6nE3ypyIJ8XHnA4GaU2/BOrqGP2uO0W8+1iVBAyvE7
 bD1mc9A6bSL28Z/CwRl7GFct1Dy0PvsJERtKoC92d+olFOKI47KPn4JaEqtWEcrh/FQ93LuvKYQ
 jPyXpLfE5UXAA+jVGP2p0PGTCp6tJxD/ZfcqKlfdU8gKUy9DSbWZrMXvc0VGs6NiZfKPhLFzdOO
 ZgfV3hSY/mW1p7GF59rDLXJ55UKSwRZPfy1mx88hQ8RMjvJUtuwLRth7MQerj4Y9DrxYEg98eZ8
 camgqo58Ptb97XLYyI0odvgA8UW33m6LtdaxKisqwDjMcJHvs7hoFHxlR/6FdD+yhw4pI5zebOI
 NFXNv0Q0EjmKoIaD6y3tgQo+pFm+6s
X-Received: by 2002:a05:6808:3a0e:b0:482:48e1:cdf1 with SMTP id
 5614622812f47-48549ed026fmr10818558b6e.5.1779748009861; 
 Mon, 25 May 2026 15:26:49 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43b63512d63sm11169468fac.2.2026.05.25.15.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:26:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: [RFC PATCH 0/2] Add a linker-list consistency checker
Date: Mon, 25 May 2026 16:26:30 -0600
Message-ID: <20260525222637.2962284-1-sjg@chromium.org>
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

Linker lists rely on contiguous symbols laid out at consistent
alignment. When the linker inserts padding the start/end pointer
arithmetic silently produces garbage, leading to baffling runtime
failures such as wildly negative test counts.

Add a small Python script that walks the linked u-boot image with
nm -S, flags gaps that look like padding, and verifies that each
list span is a whole multiple of its element size. Wire it into
the Makefile so it runs after the final link.


Simon Glass (2):
  scripts: Add a script check consistency of linker lists
  check_linker_lists: Enhance detection of alignment problems

 Makefile                      |   5 +
 scripts/check_linker_lists.py | 292 ++++++++++++++++++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100755 scripts/check_linker_lists.py

---
base-commit: 7bb1917b15b77a7d8c27045df33b6bbc214c2f67
branch: linker-list

-- 
2.43.0

